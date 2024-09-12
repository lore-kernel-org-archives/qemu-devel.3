Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A12EE644D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodSO-0004Gy-Ug; Thu, 12 Sep 2024 02:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sodRr-0004Ea-KJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:37:29 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sodRq-0001SV-0t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:36:59 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso3280730a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726123016; x=1726727816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5PpMTVZmsH4A0nmqAUW4SaOdSqOpVsbmAvPUPKayQI=;
 b=SdZYEnpnmszCCAGG9yIs17/j4O4u3sZzwanXudFcdoBCI7cUyQodDv7oNEn73L8evW
 X+Rck6XQNLAO2lM9aNo96nZKT43NwD3xCMOuEhApMO6DkDIaV7JrNHB01r9wMeabcbtJ
 Y9hpCO1QwR3LDO934V2rp0zpcOW6NoObtA+jG/RJJ0OEax5eankZZT63gnvhDbSk5X9G
 mOJKTKYxk6dr7qkR9uxMx04oCh/UrsWEiTHeTQFdB121H8Xwtbu7JqQ1fUs1Ec9nHm8I
 nVp6fgfPwUkvPpmOu2tcrkJ0VsZqOWFm9Jt6WqG0BZbHBY2e4HhmtetKyouNPmgBc1SD
 rNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123016; x=1726727816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5PpMTVZmsH4A0nmqAUW4SaOdSqOpVsbmAvPUPKayQI=;
 b=YFkDhEgwzz7bIrwzbE3PU9QJUZpRIDYyyvecK8Zn0xEAFNpyXTTHWtTZtwpm7ncK3e
 4e1crpatCx8dqqly+NxiYqSl9G2/z7K+6P5WoezXlzvE+F95EefUEk7zgGArMdyBleB3
 wET0zJw+5oG8OjXvhDh7WND3pGXdW0uRY9xl/vWpo38GjH2r/Cm5DnT2RA490JxUfwHQ
 YyZC2DGzLPDTXwphXrTkHv6uwwte4KVr/D+bVCigxypvbLMXDdREFw7BKzUQzp5zi1nT
 PAbRRMc2Po0vtzn0QeQpyEips1YVOMJifrN8bnNq6zml4kHO4JVBb3n2J3KgPLFW7SrO
 cI/A==
X-Gm-Message-State: AOJu0YwfAB6RBKD/ZVC5dKun3PHNNgb4dWihkaV2KzrC60IyHJUuYdSu
 FET+njAUq70l1WXd7FQmZGESMw2RJWhSlOfDdVJuSEuZ+yUB6yBMVayYtuSHJ330yUJrolb5BYx
 g9vyhnB79wPA2gY5/zWft7BfBJb+8WvmsroIZZqdf7Bax2JgEFIQ=
X-Google-Smtp-Source: AGHT+IFkW88/qo8o3RlCJI31hcV02l0IVMw8/XAYSXBJzejmBKtghUT4uhibqQcv/3Mr0XOUNTIpYgXD6btlIcic1q8=
X-Received: by 2002:a05:6402:51d3:b0:5c2:1014:295a with SMTP id
 4fb4d7f45d1cf-5c4015cc7b8mr10368432a12.2.1726123015061; Wed, 11 Sep 2024
 23:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240912051734.5298-1-jim.shu@sifive.com>
 <5fca8390-33c8-4139-8238-caef3e3f1dbe@redhat.com>
In-Reply-To: <5fca8390-33c8-4139-8238-caef3e3f1dbe@redhat.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 12 Sep 2024 14:36:42 +0800
Message-ID: <CALw707pkot65Zh_kpmKjZoQcm5f=VLLAFZwGbgR3D1qoDmiUGg@mail.gmail.com>
Subject: Re: [PATCH] vfio/pci: Fix null pointer deference from error API
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi C=C3=A9dric,

Thank you very much for the quick response!

I have checked the error API again. It seems to be my porting issue of
set_iommu_device() callback.
I think "pci_device_set_iommu_device(..., *errp)" should set 'errp' if
this function returns false, right?

Thanks,
Jim

On Thu, Sep 12, 2024 at 2:18=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Hello Jim,
>
> On 9/12/24 07:17, Jim Shu wrote:
> > pci_dev_realize() use the local error variable, which requires
> > `error_setg()` API to allocate the error object at first.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   hw/vfio/pci.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 0a99e55247..d994ad8bb9 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3117,7 +3117,7 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
> >
> >       if (!vbasedev->mdev &&
> >           !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
>
> 'errp' will be set by pci_device_set_iommu_device() in case of
> failure and, in this case, calling error_prepend() is a valid
> thing to do. I think we are fine.
>
> Thanks,
>
> C.
>
>
>
> > -        error_prepend(errp, "Failed to set iommu_device: ");
> > +        error_setg(errp, "Failed to set iommu_device: ");
> >           goto out_teardown;
> >       }
> >
>

