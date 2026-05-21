Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C92CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 21:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQAkl-0008M5-SC; Thu, 21 May 2026 17:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wQAkj-0008Lx-IG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 17:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wQAkh-0006dz-Ht
 for qemu-devel@nongnu.org; Thu, 21 May 2026 17:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779398181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvxNW11satdvrOAmdIlQL12AJVYnWYyJAKNxK9CcJIU=;
 b=Byf09kdxUHcCAEz6C0G/z/bA9kkhUVNJ3ak+bIKtKOCd0C3vnOiBjWK1YCfGZ1nyAdSqSR
 l0JtX7vmSQI3TQhJ0BEahKW3CMnoA6iFbpfCMCblXDo0lEshzqgtR5GodIVkLS29VPemdO
 poX00hjnBJatBLqYuWFdInIfWevHL7s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-pyTcRfNtNKyKyv5zlYVWgA-1; Thu, 21 May 2026 17:16:17 -0400
X-MC-Unique: pyTcRfNtNKyKyv5zlYVWgA-1
X-Mimecast-MFC-AGG-ID: pyTcRfNtNKyKyv5zlYVWgA_1779398177
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so3714027a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 14:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779398177; cv=none;
 d=google.com; s=arc-20240605;
 b=HuPEQAv1m5qDfmX7E2KIAv1quLOUVP/0hG/ISaxsB2BnvFVrk1jFolEs/X+JrAdg88
 PweUbtzCJ9ZSdVC2QGtw5joX97Mt5w3mprqwk7jM2k5AfhmuZJfmDQPxkdxk8AlqVAP3
 PmGhuM9vseKQOVnMxLSoNCSdYSUAFl+5BuO6l67jgA5M3CZDPIBfAYK7KoRYB64dvXzN
 +9QPfWpwxeX8551tGaxQahv8gCf7iNsl/mIoG1dnzsNX8TcmkbPckXnerEvg8qsNF90Y
 GuS0JVfhO5Bpmf4dCZvIs3tAlyyDIDjG2PQpZ7oaCvP9pl2woLvAMf+/q11F29xbMC5b
 Th2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fvxNW11satdvrOAmdIlQL12AJVYnWYyJAKNxK9CcJIU=;
 fh=DhFA76c9+yLt0maEn0FGPEicxOTIfvTlyULipvtPjHI=;
 b=Kb1InTGDwgYGgUD8aa8JernEa0k0bkcxVXi0LdcDwvQuGLTDK1JzDXCRKgphbkGttC
 3HRkd1uciMIi4wnH/rpoAQsPPHMxHunqlpUgJarYcwdBMCFfeJ+1D9BdTOyqoYDVPbmZ
 a9hI/FH2ZUF16y7F++84V/JZFB2FyQHVNpKc//cIEmPqM1S3WfXOrov//DAt6ZCFbwzd
 sZht1v8a9pSwcFSDRN1kQyp3MHDfvF011j9iJZRnERk3rMuWf+PKIOOBDJYUvQc73b6Q
 NIszE+HukaeDpfQyUMxKQVzDjKl025Kcq8CHw7ZhvyTr6gAQvdHNBmBsrxiAhVB4p1OL
 XxVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779398177; x=1780002977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvxNW11satdvrOAmdIlQL12AJVYnWYyJAKNxK9CcJIU=;
 b=e6Tqop6WgLG8R5XK19CQopUFdFEVMuA0l3j39T1B0z3/AixfIvsBHGp2yCbwEorjc/
 11qeppgWIr7xy+9q2qC62F3a0xKcumQS9EQZ21XoD3diCzZhjr1lcOhZ99AI6gVQ8Fzu
 yJsWgMBOZGprbyRwjbXbaanq1JlLl54sz0Y0oyHHsGTneduxJHmx2+g7CR+ORBv3PZgp
 hSI31+54FH9nDKaQM0hWtLPFi9YqLi897Naiz9K0z2jd5EJt7/eyhSx09Lg4X5qRVueV
 /eL/+mB3/1sRTUwCdQphIEGPF1afbsbsYkUB8krdZAp9Oq7GSmEbGUL4x/DcgVDMfBgV
 Zt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779398177; x=1780002977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fvxNW11satdvrOAmdIlQL12AJVYnWYyJAKNxK9CcJIU=;
 b=Z8chpOsowBm62IaeBSMskm2OgP8f+I7xq5ptg9pMwvDkNSnU3Zr3/ygfamtg+GSEp2
 wwoepYF6qjbZv1rWRO9rpjZSdHQSZ0o9UbylIWozUkjMz1RrpUpbO1a2nWL6BaSEpoKc
 nbqsc0iGFI2wtFP3mNV+y1URxh22fhacH2CeCNoZ7S6eMoLQsdK2Wzy8smMzvYYh1BQF
 uQv7A48jxVFfyz11sYk5vay6TSbTA4+KqpFOpYCX56LPIkvKYxkZ//iBKhG5tccxYigb
 U53vRHsGqOY8zFdZD/KxaHmUQd7xIzk5rcsbI8KNcMzx+H+fz+q4GT75rJGLFWmL6nhL
 syPw==
X-Gm-Message-State: AOJu0YzUFSQc+UN86GIpQOfE9t8uwGl255cs/b1LtUyHThKVlO3DHyai
 IBHw2+i8BRnKlwFFcAB66njPxyS0LdqHQZDQ46bTd5BQf66IUDTipbbrZOhWYmi+ZFxmEV8V6Jz
 Ax3BaMvH/LD0t51Bn7LHggBVcruwDxZDNsibKQib8Xt97/kl4VeRz6L+kC5RqibyDBOPHjRRAtS
 tADkLCWbWHlRZKWUb7DKxmueIpQ8OpCJ8=
X-Gm-Gg: Acq92OHGbxdne6Ls+k9/yiLyD/PjgjDOSd5bTvvM4Ci0cvYyZtl5SAZFr6/2Q99hAj8
 q07AVjyoPPbzjoKuaR/tf8FJHkFhjodIszh4dzKkNcVNJviS6Q/db41zUG23MiS6jVPGWqlvcU+
 eArsGXGDZm0x4yxhh6HRVz4hJYsWXvFwg/WqplUy1X/B8s1qwrREt/jXihAtWu4RLHJR08Jc36U
 8LUxrZGSYDusxwOIf9Uw8t0SQ6KjWDcVFBt0gu5z8gSpS5QnbZuZ80qLq2dsLBVfuKZmSPAkNBf
 ZM8qRW2mWue1sfq/sPCddl2pmT8IBAtCrQ==
X-Received: by 2002:a05:6a00:8c10:b0:827:32de:d197 with SMTP id
 d2e1a72fcca58-8415f37d792mr881221b3a.40.1779398176815; 
 Thu, 21 May 2026 14:16:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c10:b0:827:32de:d197 with SMTP id
 d2e1a72fcca58-8415f37d792mr881198b3a.40.1779398176349; Thu, 21 May 2026
 14:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-18-3f20c3a029a7@redhat.com> <ag9oaNePe_-iS35W@fedora>
In-Reply-To: <ag9oaNePe_-iS35W@fedora>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 22 May 2026 01:16:04 +0400
X-Gm-Features: AVHnY4Kxu00ZSYPUwlz4Wuev-XPEyb-EjHPihlvwyTOpabSQZ7qqU5VzM3ygkuQ
Message-ID: <CAMxuvayCTrOSENFaeWnyGj5-6L862QuTDCwCe1FAV+p4jt_aiw@mail.gmail.com>
Subject: Re: [PATCH v3 18/24] hw/tpm: free PPI buffer on finalization
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Fri, May 22, 2026 at 12:17=E2=80=AFAM Arun Menon <armenon@redhat.com> wr=
ote:
>
> Hi,
>
> On Sat, May 16, 2026 at 11:59:17AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > The PPI buffer is allocated with qemu_memalign() in instance_init but
> > never freed when the device is destroyed.
> >
> > Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM=
64 virt")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/tpm/tpm_tis_sysbus.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> > index 6bec30c36fc..3984228c42f 100644
> > --- a/hw/tpm/tpm_tis_sysbus.c
> > +++ b/hw/tpm/tpm_tis_sysbus.c
> > @@ -150,11 +150,20 @@ static void tpm_tis_sysbus_class_init(ObjectClass=
 *klass, const void *data)
> >      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >  }
> >
> > +static void tpm_tis_sysbus_finalize(Object *obj)
> > +{
> > +    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(obj);
> > +    TPMState *s =3D &sbdev->state;
> > +
> > +    qemu_vfree(s->ppi.buf);
> > +}
> > +
> >  static const TypeInfo tpm_tis_sysbus_info =3D {
> >      .name =3D TYPE_TPM_TIS_SYSBUS,
> >      .parent =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,
> >      .instance_size =3D sizeof(TPMStateSysBus),
> >      .instance_init =3D tpm_tis_sysbus_initfn,
> > +    .instance_init =3D tpm_tis_sysbus_finalize,
>
> shouldn't this be .instance_finalize ?

Good catch! Weird, it made it through the test, Ill check!


