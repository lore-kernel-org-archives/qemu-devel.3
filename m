Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4EEF419A5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0PN-0003Tu-KK; Wed, 15 Apr 2026 09:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0PL-0003TN-DE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0PJ-0006Pz-OW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776260153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZgxnJiKlhpfgg42CnMY+u7qWO3b1+KZaeAjDVG+U9g=;
 b=aIsg7t/E+gRI2MJTN3m52r/Ia08OYEsRVpOVCm2ZT5ShufoK/eYGD3f3N5Cs91ImUsPhZg
 816dzET5kzD4YL6cJ6KrIiyNPTcJXJLnf6bpesudx3JENlCHsvgD/R2xd+/qVdGY9nFl8q
 jWBs/C9O0YmFP/a7VIPdLOmPKu5MAKo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-oen-oT7IMMe_BNT-UUH_Hg-1; Wed, 15 Apr 2026 09:35:50 -0400
X-MC-Unique: oen-oT7IMMe_BNT-UUH_Hg-1
X-Mimecast-MFC-AGG-ID: oen-oT7IMMe_BNT-UUH_Hg_1776260150
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-42467c9547bso1663420fac.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776260149; cv=none;
 d=google.com; s=arc-20240605;
 b=bxCnPFWvjiUi79+s4BGFRFbsDmICiPLLMyxgATZF/WIxroCVUS4atg25RYr0W2cJfx
 NG5TDS/kuQ+4YKTTkdNV80YMBjOuklrOeXqHGvIi7tYfnORI9sLLScGnR/tlsugePSEm
 YwUwj50Tuj/40bAm3JyRIAmcS9WtoTwzD3D0hygaE67VLqiP1swrGuJKqMTqUd+bRCRB
 dmNbFyHJSnTubnJoxupAYJ0B4H/YFmLV7lx98gETdSFynz/egrcGcBgnQJpRlSOMWoxU
 N+yqmY3WoP6Q5GXJUbEWwFIz2J5RiM8VXn2hUzy9rREChWA6C2QRRuUBtD4sCTbEJBdl
 H7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OZgxnJiKlhpfgg42CnMY+u7qWO3b1+KZaeAjDVG+U9g=;
 fh=Xrp2glQicIvkcDLzKDtQ4JXqZnWs2rFpNaCudBPk6pA=;
 b=GvWQyEDd9Bj+IYWo8zxA7vw9pL6n1MlUcRydfWZQT+LptO15cpLpnQYSVo4smeXar2
 aMydlt3pyyFDcs4Tswl+rxBB/ggayhP8gK/pvbAcaEVTYa6YHLwRwBnFAyy4ezQ3PNwB
 CNmYQMOnccylnAuTP3s4MlZGG/aWSXymaOABtb7FT+raXwYJ/cLegVX/J/ymNUySijBM
 9yg/RQ7jvvDUc3NA3jzU24VYCqayA6Z+/okCh6xavbid20VRd33bDaYzssIb1n+fYzMQ
 PDfnWKt1qeA4JlA2DJdMZQ8CtmmQs+kw4OEM1e1r9agkxT8cW0kBFgKidxNywd4ouj8J
 WBow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776260149; x=1776864949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZgxnJiKlhpfgg42CnMY+u7qWO3b1+KZaeAjDVG+U9g=;
 b=LiBXDZUqXenM9fJOcB0qOSXq79rHfVG03azufO8KA+Tqp1BP1+V0NjSrvp5nQcmI6N
 7n9DgeFb1p+1mJAFvAgNkp7MZW1fXmArOLKkF/VLOsQnSUxuxoTL/99CmF0ENSMrW21e
 PKRWJHnr0Cts09Ub8o5ueXx7FRQ+QjWDY4+e3ZCEK5fzJlp6GI/fapH4Tz7cKDjT8eq8
 zMrrNarwGrMuvVQbne3oG5zg7NwBxz4Eh4/LI9pgr0yanQOPIcfqhmiDTEPuOBnGlYvx
 MoXua9eBq+AkjEHBGdL6c8f/ulcGML524XQLAI+XayDqq28WeveNf/J9hzlB0ctnUomj
 a9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776260149; x=1776864949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OZgxnJiKlhpfgg42CnMY+u7qWO3b1+KZaeAjDVG+U9g=;
 b=duzfBt7sjxD9jUE5ppzoQkLEkDgVMtjUi0br3A1TqVkETD6hdtkUTZ1zKIMMt04mTg
 8AW2kFTGSRkvQkBh59na2IiSMaF9QURP6lDHtYBWLYyDMY4qlaXwiFvotzGk2GP1ibSA
 ksXouXDDY2x8SfFAlPxKQscb3gx53C4XFGOFMSnBWKUetgjU8t9x+Cwb5HHEIE26703p
 Qb3GKsOVflky4jaljo+Si0ZkPVJeadGmbrjW0Ngbr+0PyjVhLaPed5rZPwEGqQHDaomb
 osqZgRLTiO0i1p157VqjrEIEzKZ3DOvgY4xwF3KlcJw9mXlYP2CiiJR5XjrH4pMAhFS3
 lUKA==
X-Gm-Message-State: AOJu0YyDAaASoPxFa7ikRBTl+K6C5aWrRbmR3e+XBqwTELB1S27wr+87
 7hj93iuiKbUgOkzJZNxdyb3BpLNESRWT8VI/JfYEJ2mJ4G8pok6819EJoSJshBnjTrGiQrwtpee
 fJ1D/pdeK/XVuEFvuMsd8WB09qFRHBwrCGxKc3gi5+RuBadgvZFs8ZVtmq/D+3UgJnPeupAhDfI
 0kGOjOWTIq2lpBIaz1XOdHEmAURpzWs/Q23Zol9nM=
X-Gm-Gg: AeBDieuzptFgQV+kkoKJWwIO00UXddaJ1cvKM5ZA371EXa32g+T3TF7vlJb2QcVHjgQ
 fzJue8NQRFM2tzgN4NhYyISj1Yly+/2fgPD/r1JwrFjSBhaddOIQa32HDzOmk/cR7TIZ3OFutAr
 irSNn9eh64yUeTzTJCte3hq4mO+4D5ZDFh+qtdYAemgc7JsnZzkmK1cPYHXDXnscB+VzhncdiCz
 yeh3dqx7nrlOvxdo7CpxggmJx3lx14aqpGe2kI3wEySRg==
X-Received: by 2002:a05:6820:16a8:b0:68d:9ba5:de27 with SMTP id
 006d021491bc7-68d9ba5e476mr7838362eaf.56.1776260149268; 
 Wed, 15 Apr 2026 06:35:49 -0700 (PDT)
X-Received: by 2002:a05:6820:16a8:b0:68d:9ba5:de27 with SMTP id
 006d021491bc7-68d9ba5e476mr7838345eaf.56.1776260148811; Wed, 15 Apr 2026
 06:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-2-armenon@redhat.com>
 <CAMxuvazscrXMNc+VV_jpTLY1aRjCKAbmBoZ-LCcsZ-4iazBfvg@mail.gmail.com>
In-Reply-To: <CAMxuvazscrXMNc+VV_jpTLY1aRjCKAbmBoZ-LCcsZ-4iazBfvg@mail.gmail.com>
From: Arun Menon <armenon@redhat.com>
Date: Wed, 15 Apr 2026 19:05:11 +0530
X-Gm-Features: AQROBzACRi4jHsRjCjqcLutU4nHp-Jl0oT6DIy9403R2yIU_hKfI99zCFZkZ2LU
Message-ID: <CAE_eyq9QqcsQcRY53rH5tbBhnYNWtXHYjQUQu7HKpGtDQOaoHw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/tpm: Add TPM CRB chunking fields
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Apr 07, 2026 at 11:49:54AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wr=
ote:
> >
> > From: Arun Menon <armenon@redhat.com>
> >
> > - Add new fields to the CRB Interface Identifier and the CRB
> >   Control Start registers.
> > - CRB_CTRL_START now has 2 new settings, that can be toggled using the
> >   nextChunk and crbRspRetry bits.
> > - CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
> >   this revision of the specification.
> > - Refer to section 6.4.2.2 of [1]
> >
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Spec=
ific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
>
> You may update the link to the released version
> https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-P=
latform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
>
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  hw/tpm/tpm_crb.c      | 3 +++
> >  include/hw/acpi/tpm.h | 5 ++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index 8723536f93..0a1c7ecdc6 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
> >  #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
> >  #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
> >  #define CRB_INTF_IF_SELECTOR_CRB 0b1
> > +#define CRB_INTF_CAP_CRB_CHUNK 0b1
> >
> >  #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> >
> > @@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
> >                       CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> >      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> >                       InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> > +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
> >      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> >                       RID, 0b0000);
> >      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> > diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> > index d2bf6637c5..03d452d2b5 100644
> > --- a/include/hw/acpi/tpm.h
> > +++ b/include/hw/acpi/tpm.h
> > @@ -149,7 +149,7 @@ REG32(CRB_INTF_ID, 0x30)
> >    FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
> >    FIELD(CRB_INTF_ID, CapLocality, 8, 1)
> >    FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
> > -  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
> > +  FIELD(CRB_INTF_ID, CapCRBChunk, 10, 1)
> >    FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
> >    FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
> >    FIELD(CRB_INTF_ID, CapCRB, 14, 1)
> > @@ -168,6 +168,9 @@ REG32(CRB_CTRL_STS, 0x44)
> >    FIELD(CRB_CTRL_STS, tpmIdle, 1, 1)
> >  REG32(CRB_CTRL_CANCEL, 0x48)
> >  REG32(CRB_CTRL_START, 0x4C)
> > +  FIELD(CRB_CTRL_START, invoke, 0, 1)
>
> Any reason to diverge from the spec "Start" naming here?

No reason; I think I should stick to spec. I saw cancel invoke and I
thought start should also have an invoke.
I will change it to FIELD(CRB_CTRL_START, start, 0, 1)

>
> > +  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
> > +  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
> >  REG32(CRB_INT_ENABLED, 0x50)
> >  REG32(CRB_INT_STS, 0x54)
> >  REG32(CRB_CTRL_CMD_SIZE, 0x58)
> > --
> > 2.53.0
> >
>

Regards,
Arun Menon


