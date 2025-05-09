Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EDBC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDL6k-0004G0-KR; Fri, 09 May 2025 06:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDL6f-0004FV-8q
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:37:29 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDL6d-0005NW-98
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:37:29 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e728cd7150dso1676885276.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746787045; x=1747391845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxAwE6Zpu+FnMllfRayjT6qRpfVU3GOS2YP4U1s7qTc=;
 b=oUTiEEY6zzuLom5eS+gZZvk2wWCnOwUszPfmUB8QpxH1Yu2cKs3omTnoaHqXnJJb04
 LBMrm+/oE2nLbV09vjDzfSB1RMZSxZhezLgyfycwy+FxyQkIn4+BA+0FAAqkCkOzPWhy
 5TyWCHQs/LtBqfuRP8P6NQTZPsPZBZfqd/BIBDRiORFy25lxY1oBxWjLa2PFq0xYejSR
 UDcDymxk9/pgWFX7g/LmyDB2d6+FxmjWPfqnlHWYD7mVwYOQtho0X/bAKQA/b3si4BPT
 DjDH8Nbf+8F3lR6nb9prKXX4oH2tnD4ikCIq1P5LBNjUnlDNNRFy39PuzRY8UKs7Lwwb
 Ynzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746787045; x=1747391845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxAwE6Zpu+FnMllfRayjT6qRpfVU3GOS2YP4U1s7qTc=;
 b=rqMWJSc03SgA/+ilhLbyJM2SS9VYegjPAXGkHSeM4yNPeAttgVlhdhRu9ZPQ0BUtOS
 n4EJH9x0rV9TnW7BsHNGagNURUPVq+dMAR4OkYFlq+vjp4AX8PWjVopt4tHzDOnegBEx
 MejGJzuT5yqXPKD2gyaBocJnpJX3uUuJmqFBI6GkYcRSme4LHJ4eECJLOImgklE/EQ1b
 +JMx9PsaWjvcvY81IUwKPhgJVZ4ECMVJ8PV0/eF61yM2Sf7CHRwFMIPFLx1CCQFwAhS/
 8UvEAGhOfvaSJ5/NXk1mH9xF22l09HI//F+pif9P6/5EkDuyC7nPFchNX0QmOVM916ZM
 KgRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjSbMwDD2rmgqx1At7GhkK5rCaigo2C0zjQ2MW5271TCIFOGclAfLrU1S7EtWLx0bagJ8aBDd3czZx@nongnu.org
X-Gm-Message-State: AOJu0YxGoX4xUUHYvpdOQ5zM12rjkTN4GENrvev2EOBbxe5kAu+RrHud
 G5WQSxGf/sjpS8dPpY6YE+CDXdF7EBOUdfe8GsLixqeS6hLEetIQhnMyMONiNfJwUHCosloybnC
 eL7BaYpPpBZSbHvM6NoziduqUGr668Jsqwgz0lg==
X-Gm-Gg: ASbGnctTsb9OPYpELLh5Ddhh8o1QY0dmdzO7mRgZtkueH05aN80TrY65+S8n6T6Z9ip
 723vtas4tj533AuXvwybUwZIJAPWzfx1xd9dTmYaY84adyr6rzpieh3KlEOo0zUz1Fo4FHtx/60
 Hesf3citfLa2W2HaJm+ud7t3Q=
X-Google-Smtp-Source: AGHT+IHwxezQ4tOGdiD886Cjqn8kvFfhHR5QSh305KVHCIa1FLiIUMQDn51EMtdz0wWwDibbUOlnfUht6hY/1D8Mzko=
X-Received: by 2002:a05:6902:2193:b0:e60:a068:a14b with SMTP id
 3f1490d57ef6-e78fdb83501mr3680493276.4.1746787045288; Fri, 09 May 2025
 03:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
 <3d7824d9fcf04e2e961d30a5f3404b52@huawei.com>
In-Reply-To: <3d7824d9fcf04e2e961d30a5f3404b52@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 11:37:14 +0100
X-Gm-Features: ATxdqUG98-vokAPvGSpkWdZWQSd74NMv-QDWvbmtFS1TvyvJXi67CObm4wCuCjI
Message-ID: <CAFEAcA-HWuAUVhqsE7p2BMo6wg+7F273Q_J2LVLrHzFagTjxgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Donald Dutile <ddutile@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Shameer Kolothum via <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, 
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, 
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 9 May 2025 at 09:00, Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
> > The problem here seems to me to be that in the hardware we're
> > modelling the SMMU always exists, because it's in the SoC,
> > but you're trying to arrange for it to be created on the
> > command line, via -device.
> >
> > We don't have any of these problems with the current 'virt'
> > board code, because we have the board code create the iommu
> > (if the user asks for it via the iommu machine property),
> > and it can wire it up to the PCI root complex as needed.
>
> Yes, currently virt creates a SMMUv3 instance and associates it with
> pcie.0 by default. However, this setup isn't ideal once we introduce
> support for accelerated SMMUv3, where we need to configure the
> host SMMUv3 for nested stage translation. This is essential for VFIO-PCI
> passthrough scenarios, where the guest manages the stage-1 page tables
> and the host manages stage-2.
>
> In such cases, devices may be associated with different host SMMUv3s,
> and having a single vSMMUv3 in the guest isn't ideal as-
>
> -We would need to broadcast TLBIs or perform lookups to identify the
>  corresponding host SMMUv3.
> -The physical SMMUv3s might differ in functionality.
> -Some SMMUv3 implementations offer additional virtualization features (e.=
g., vCMDQ),
>   where the CMDQ is is directly gets mapped to the Guest and invalidation=
s
>   aren't  even trapped.
>
> Please refer to the earlier RFC [1], which proposed a new arm-smmuv3-acce=
l
> device. The main feedback on that RFC was to instead convert the existing
> arm-smmuv3 into a user-creatable device, and introduce acceleration suppo=
rt
> via an optional property:
>
> -device arm-smmuv3,accel=3Don,..
>
> This series is the first step toward that goal=E2=80=94making the current=
 arm-smmuv3 device
> user-creatable.

(I want to start here by saying that I appreciate that I'm
coming in without having read the previous discussion, so
this is kind of going back over ground you've already
been through.)

I agree that rather than having an entirely separate "SMMU with
acceleration" it would be better to have it be a property on
the SMMU device. But why do we need it to be user created?
Making it user-created leads into all kinds of tricky areas
mostly surrounding the fact that QEMU right now simply doesn't
support having user-created sysbus devices and other kinds
of device with complex wiring-up. -device is really intended
for "this is a model of a device that in real hardware is
pluggable and has basically one connection, like a PCI card
has a PCI-slot".

-- PMM

