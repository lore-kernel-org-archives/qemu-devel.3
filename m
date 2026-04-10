Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7EBF459EF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEtv-0003W4-0R; Fri, 10 Apr 2026 12:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wBEtt-0003V2-C4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:40:09 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wBEtr-0001UG-Uu
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:40:09 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so9754901c88.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 09:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775839206; cv=none;
 d=google.com; s=arc-20240605;
 b=EytdkpRgKzCh4Nvd7uBNRbP3tvqofb3Un6jjUeMWGCUXrL6Rgr+lbuN+zu9TcVFiRL
 ZW9AQVcPIQ26Necq0EmD9g2TVatSWJJKgUG2ds+B31Whf5rUU7ibq6P8h4nKczeCVEv5
 54Z/RVyaRzzr6cKcdPXCJErpNOHzi7kFCSeout4kp9YjQowi5g1LCE/qovtQI8VxE3ld
 +uVjLS3hg9ItCapURhqdt6K7TAdOaKcsXV2UsIvzP4DYKMEWjn2tIXojgisT5kKJuhQF
 2xsuJCCNx+AGE+5kPwp1stJMeQ1vK5rN68qFRl0k8BpqOOVcp67Bz2mSD894Wk9X+Tnp
 0jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RGq+f38wc8zNWMr6JH5/h+rGv5DrH1N3XDMiUobDA8o=;
 fh=5hm2zad6FptwkTwuMlIAmgfHff93FWjTkPTDKWpG3ZQ=;
 b=PQC2md2N3jtkn2RZnSRd2H2NAtFvMbKIOz2sh87vJlRRoFKpNDwUHyon17JVntdSST
 qOsUwijigCcaJSdzLKu7x8418ZE9WYEBDWFnr+rTDoUYGGMfsP+FTTRvUsK6otbk0sCM
 2ifAB1nVbvLNkDmmXlI5d+E8MKuh3pfRMPOjwPeDRjvFN7E7Jx13M4sP/csFUiw/zXUJ
 d52WLXsYsRlYxm2lEODQetI+KEcsKX5o1+jXprCQ4u7ZNKOdCW92nsX4WAxp5wbGlsgg
 HONSDyYZRLX5U+FglsrgvbeRx4INcCRUKEYbvaIqMq+Pw8qC4Qlg+Gf01Z3VIsIHUMR/
 oSzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775839206; x=1776444006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGq+f38wc8zNWMr6JH5/h+rGv5DrH1N3XDMiUobDA8o=;
 b=QO0vnyN9H5ZM/arQamHrjOD0J2n7C9CMtqoNJLzuyOjMwA80kXTWm+vO6FON+wF9dL
 ot/wj2M71bC8bZIRK2IshWeP1Xzi0KezI9nQpMdFQrszd49WatjXCzbT4d2pkO/6z7Fy
 /OuwE8za/KXrw57/1xWvO7ChaYX7SAWzhBW7UCvievKnkqsVnStEhJEpPDl1YYyzKQH6
 UvNW4UaEZM6x3a6NnFcJdI+cWkXSqrGcSUShNjDEZetuV2a65D552T9lWHUNJsVzTnv/
 ouW3rHRgeQHLcmRiBzHPnrsUPaKkvK5OdHncjKT6rhonwOFpMMEBp7E495dn4kOePlUM
 xvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775839206; x=1776444006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RGq+f38wc8zNWMr6JH5/h+rGv5DrH1N3XDMiUobDA8o=;
 b=SzLpZyL7jPZe1S5Yj6chyUwl+Ym+HJu/BV4/vBKU22htC+UVR23G0XducjjomxuknB
 +0vJ3mLiIImy4r0Yl8rfQl9R2chFR0cDXq+0jGZB/lIviexHq3lOO62OsPKA3yyo6LfT
 63KiyvV/bEKCgpePEEO6D/0XFA5+/3aeBF1KcG0z2GNAc/+VpycGx1jYwSv3Za7IKwfr
 Sy6EtmavBZ5+sqJGS63ug1GXMSllMfEsLkzZshoqFJ9qjrmhogoadK4IU83Cm31k2A6N
 RAxMsAfGCy2BTgmRL0ULnXYrzIG4pPROf3Wpu8Lm8f+W3b0tOOQxc5o9LbhTyFp668QR
 XLuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjjAR8IZFaZ7h9QSD6vCr3AFWFK/VJlBR18qmBNW0xIEPdCZbS0ocwGues+//pErhSQ6h4kTpRwlkt@nongnu.org
X-Gm-Message-State: AOJu0YzhFzSj7F6KX6bQnB3GD7IDPoqnv4hJZhhREJDsILTmompIJnhK
 BmJLept8/DZJhiEuTuvIQx6edhb5jdAjxVhNTdTns1XtuNhFS9XFNjtxuduDd3HW4frpZSn3xcF
 cKOAxN8U75SJ5WbT/zj+jSW0eu0MkkSs=
X-Gm-Gg: AeBDiesuG4WjGe4KyIWwMCl2O30RfIM3APZF+2NEo7jtIrXbXE1M4/nccMFwHFsZtEZ
 0RAAnpjFnv9PN8mIVPML1i6r+XoP4EB8Vyw1WRBG7MOUU3xDEWU68w2X2hcgurqSJyYakqZszFx
 z/3hDoVvLz49W29Vh36wpqD1mv0fEqfewdBrhhZNVuPAvU2Ie8I8sUlJ0X2/FvJm2bmlDTZHEUP
 OC2HPrsOLR9w0TRzUFHbV2DMmZ5KL5HdiJnKaNOfL3OFAdBWNOkIuvFpd9OjOJd0WO/vBwUl4U7
 AEj0jrImC7qxHQcVLJfuor/tpEK0s2c7B08OOo4Y
X-Received: by 2002:a05:7300:d183:b0:2d6:526c:55cc with SMTP id
 5a478bee46e88-2d6526c5736mr831953eec.6.1775839205757; Fri, 10 Apr 2026
 09:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-7-armenon@redhat.com>
 <CAMxuvaw1Zaui2mSw2o6M6OzC7vnwN8CW1hgnZEtz1BiZmsT1kg@mail.gmail.com>
 <adkLu8uBy_Lkfrop@fedora>
In-Reply-To: <adkLu8uBy_Lkfrop@fedora>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Apr 2026 20:39:52 +0400
X-Gm-Features: AQROBzAS8AP9d0wjZZK5pETBfJHdET4xg3dAA3jQMRaxQ9bI0yAuMlDJIep-9jM
Message-ID: <CAJ+F1C+fHg8b9-=uWe22ptQNAvyW01ehCpSofoCcMxrJsZ9Dyw@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
To: Arun Menon <armenon@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, 
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 10, 2026 at 6:41=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:
>
> However, I am a bit confused on the order of precedence of this variable.
> From what I understand, the device initialization happens first ->
> followed by the compat properties
>
> So,
> "DEFINE_PROP_BOOL("migrate-buffers", CRBState, migrate_buffers, true)"
> gets executed first setting it to true by default and then, the compat
> property is applied,
> "GlobalProperty hw_compat_11_0[] =3D {
>     { "tpm-crb", "migrate-buffers", "off"},
> }"
> setting it to false.
>
> When is the user provided command line argument parsed?
> For example launching qemu using:
>     -machine pc-11.0
>     -device tpm-crb,tpmdev=3Dtpm0,cap-chunk=3Don
>
> Is it set in the end? In the above example, the user explicitly set
> cap-chunk to true whereas the migrate-buffers default value is false.

Iirc, user specified property takes precedence over compat properties.

> Therefore we end up with the following scenario.
> Since chunking is supported, the guest writes a large command in the
> buffer. The user then decides to migrate the VM. QEMU sees that
> migrate-buffer is off, so it does not migrate the buffers. When the VM
> resumes on the destination host, it will find the buffers empty.

>
> Therefore, we need to stop migration if cap-chunk is enabled but
> migrate-buffers is disabled. Please guide.

Yes, if cap-chunk is enabled but migrate-buffer is off (compat 11.0),
there should be a migration blocker.


--=20
Marc-Andr=C3=A9 Lureau

