Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E454FD5E39B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 11:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA5ma-0006gC-Am; Sun, 10 Nov 2024 06:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tA5mG-0006ef-Tt
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 06:06:44 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tA5mD-0005kE-TN
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 06:06:44 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2e6a1042dso2927669a91.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 03:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731236799; x=1731841599;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpsWfsbH5xoUebn/zjxxMVTbsEr81qCxwQSf8mBq5ys=;
 b=BOgm9epg/Tp2grcHmDJbrEpi8SRLRsIQ6ZfoE1InxZra82u0iOy6+TZxk9+GW5p9MZ
 5q+EG9s3+GWytrNtMnuivb1zhy3Uo1rxVx5OuS33aIALwrq3Dck5t6LxRucNK9UgJ9Ud
 4bDinhrryMXZ9TJYf/PKjdHas7RK0hy5OJmHRYkwrKRgFF3eo71MC5+5XnJRtBACDsAw
 D07WGDDpyxg48o6T4QlKmnRb62u8vE9ASBZ36XmzZxsq8WWbDeLz3Xa7q2jjhPsHhtAy
 w8yoYBif14UTlaRbd+dILaVT69WBveCVlFTl68xHRUiOGwRk7dU45qyqIo2+GlfmIWyn
 MLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731236799; x=1731841599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpsWfsbH5xoUebn/zjxxMVTbsEr81qCxwQSf8mBq5ys=;
 b=wE8tEDCLHQbGrIa3ZQCEVIq5Y9eSUYFkMIwaypUZOTkFoDLxAkEm2ulqG75st7tPzc
 45dggOU9z+/pRbLU3vlFdkt6iq7yULY2Sw+6ta+67o30DswYU+UBGktHbrRjCpWdc2AD
 HKUVaTucjx++I3hrIx5PFI7ZyWajO4KCucMYZob8DX7DMnjq+8Ji6L8FgblGMLwusoab
 34rFTtzFii7QlbIGHT3cKSOonWn7CrpRbnXCeUKtqKTusPvCFWj8kc7G1qa+mPX4iJhD
 k8RhStf3VrWfEMMkUorl7gSYswiUmHnFojk7Odll+NYFdJr2SlbYPYu1Ss1QJxFiSSSG
 UdNA==
X-Gm-Message-State: AOJu0YxHmnoCDA0eux75k1Kk75qC86C1qSUCmKwg0Fb7BAkapWAtP/df
 9W6rUFYPrwohWUH/mmMp7BHmuKzzATXvhsTDP4c9IfntD878taMCSyqVLx3/folsVRYxHlE0UDg
 gwBC6xe01tnasShSJObQLo6iPujGvZXuVL6Wd
X-Google-Smtp-Source: AGHT+IGKdtIQLYq/VBFQg09zFRDSu9Guz+CV7rCMHhRpVuh+3V4szdCxmOJwUQsHr8EbNcz02EZcBa+TyDB7KffyTXQ=
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e9b177632bmr12616274a91.28.1731236799333; Sun, 10 Nov 2024
 03:06:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730754238.git.mst@redhat.com>
 <b12cb3819baf6d9ee8140d4dd6d36fa829e2c6d9.1730754238.git.mst@redhat.com>
In-Reply-To: <b12cb3819baf6d9ee8140d4dd6d36fa829e2c6d9.1730754238.git.mst@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 10 Nov 2024 12:06:28 +0100
Message-ID: <CAGCz3vsrwGQ9v_ZFtteU9jeHpw7z5YATLDLbuKS=dpAzs3C_HA@mail.gmail.com>
Subject: Re: [PULL 32/65] amd_iommu: Check APIC ID > 255 for XTSup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1029;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Hi,

This commit seems to be causing link errors, likely on all platforms
where KVM is not available, but at minimum that's what I'm seeing when
trying to build the staging branch on macOS.

ld: Undefined symbols:
  _kvm_enable_x2apic, referenced from:
      _amdvi_sysbus_realize in hw_i386_amd_iommu.c.o
clang: error: linker command failed with exit code 1 (use -v to see invocat=
ion)


On Mon, 4 Nov 2024 at 22:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>
> The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
> to support vcpu w/ APIC ID > 255.
>
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> Message-Id: <20240927172913.121477-6-santosh.shukla@amd.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/amd_iommu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 38297376e7..13af7211e1 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -32,6 +32,7 @@
>  #include "trace.h"
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/qdev-properties.h"
> +#include "kvm/kvm_i386.h"
>
>  /* used AMD-Vi MMIO registers */
>  const char *amdvi_mmio_low[] =3D {
> @@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev,=
 Error **errp)
>      memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST=
,
>                                          &s->mr_ir, 1);
>
> +    /* AMD IOMMU with x2APIC mode requires xtsup=3Don */
> +    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
> +        error_report("AMD IOMMU with x2APIC confguration requires xtsup=
=3Don");
> +        exit(EXIT_FAILURE);
> +    }
> +    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +        error_report("AMD IOMMU xtsup=3Don requires support on the KVM s=
ide");
> +        exit(EXIT_FAILURE);
> +    }

I suspect this last if() { =E2=80=A6 } block should be wrapped in an #ifdef
CONFIG_KVM block? I don't know anything about this code though, so if
this whole code path is generally a KVM-only feature, perhaps the KVM
check should be implemented at the build system dependency level?

> +
>      pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>      amdvi_init(s);
>  }
> --
> MST
>

Thanks,
Phil

