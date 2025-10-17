Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFF7CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9duY-0002K2-Ut; Fri, 17 Oct 2025 02:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1v9duS-0002Jk-DO
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:25:53 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1v9duJ-0001ey-Cm
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:25:52 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3717780ea70so14890271fa.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760682338; x=1761287138; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmLGdQdxQezXgDJXBxj33ObpNLGygnZoOAk6H+H16Y0=;
 b=oPRtigSQzAWmOm41Q8SnFEMXMdrQ0FLNdeYqPWfD7YTPLq8bJcZ2/+EARTGkRtOgQG
 BUtyzSEaL3MfJavudt8MlkmORLSj4hIMeRcRow3qCWf1biZETqcIxwMADDENnZW7doS+
 kTVLKQnk5K2SMzmYBOUKjI5kNWpv0yorTuroCRv/3xVR0dk4ic/xvPSnVoVNfsnTLmcv
 vBLOcFR4w4IM1Decuygk6TO/jf2sKyQZgq8qNvz1eoqq3wXLDu8eRzgXXgHFrEYci6gb
 4Js01sEf0n66PBj6BBAj0XZhhRyd5LXVoaD+UFChP/ftj2pz3a3+ovvPJ7JFPpqCUMqo
 qQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760682338; x=1761287138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmLGdQdxQezXgDJXBxj33ObpNLGygnZoOAk6H+H16Y0=;
 b=AeU/MmG6Agi322oLgHRsD84MjKrKbrnvV0hpPsxCqm283VI5F5e8FqsRAZK6ONDclJ
 Ta23TJkPToNaXH7GTzMPFwvTa6w3m7taoqhSMBcL1OKum/cWwy3fH6rYwSC57WhMiKYR
 DkKtvVqYPMdW+xvimhrb1dESnHe9qKvtwu3OEiWRdIEGiXxUgLsIR33tBSp2kExfG2dm
 KFhjl4w+4MIXjJCSbn7Q/937wUcxRZ9oSOMjdeNpuTXTJg1fkiNmmIDnfBVZBzJnCdtU
 9fs8icpPPO7+qxTt/CG6VP9gOc0ozkBYxXPlGcMbVmjDZDp2PXdozUkrMovcangFfVne
 OQcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpL6bzibuhLpLexkplKSxLRaDf5fJeZdy51oR+YWLgaEGY+Y6wb+1OrNgHYCxnGMXDlA1roxJtK4m0@nongnu.org
X-Gm-Message-State: AOJu0Ywx35CHC382l+Fl+N/Jd1fnc0GjSLr4Vwe1cUHLJKae58ozG58E
 nvRPHI6IKFurUvjySEeGwElEIWo57N4sJS3Lz55dHtaBHFuNBhBQyM8IQdB9QuG39svP1yAikWa
 mqGYyZSpqMTXtW5RvfMOf0Mv8T2SV5ktVVdiBU8Fxag==
X-Gm-Gg: ASbGnctFTxpameILEtgZuXufNVR8J3fkQ9SUX0hBKPJwAX43Mcg/spHhGU4mcFA4LlI
 IjlRE4Bg0Uq/ylRPZGhz7vOitQTDRNjTh1I5CNASdtRG5lv2xP0sKvRh3xVgFEjS3tgZE4Y7I5Z
 fl4NwazOIRmQ25h3+8IwFiIRdUNgux94GO/NWDSJ4zvCLHf+Eae1BcR0nnv7iIfuDNHfOzCSqMP
 dFQOFAFZXv7okaYsFUqoWMzutHf6VqaJpzLKe/rfXEIFbNYRIUz9APkM4uGuIwOVM8JzxjooM6t
 FziH
X-Google-Smtp-Source: AGHT+IEkRsauOpdYHg6HZWmxW+UKvjnYgksS5Be/PHl1sEUqMqEzAYWiiFeZS6PgG8uUud9ncIPvBZHZEHOoZmFMuPo=
X-Received: by 2002:a05:651c:12c3:b0:375:f6bf:880 with SMTP id
 38308e7fff4ca-377978aefe5mr10992191fa.19.1760682338396; Thu, 16 Oct 2025
 23:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 17 Oct 2025 14:25:25 +0800
X-Gm-Features: AS18NWBA7dy9XcjIp02VfRlQYVGsxYyj3Q3HvOsiF6YA0YwEbKw-f-hyrA-n82I
Message-ID: <CABQgh9Fzf0XJYwybb2S0ophuSZ6v+=FM=OWmnG3md7bXOo95-Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/27] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com, 
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com, 
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com, yi.l.liu@intel.com, 
 shameerkolothum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi, Shameer

On Mon, 29 Sept 2025 at 21:39, Shameer Kolothum <skolothumtho@nvidia.com> w=
rote:
>
> Hi,
>
> Changes from RFCv3:
>
>  -Removed RFC tag as we have the user-creatable SMMUv3 sereis now applied=
[0]
>  -Addressed feedback from RFCv3. Thanks to all!(I believe I have addresse=
d
>   all comments, apologies if I missed any)
>  -Removed dependency on =E2=80=9Cat least one cold-plugged vfio-pci devic=
e.=E2=80=9D The
>   accelerated SMMUv3 features are now initialized based on QEMU SMMUv3
>   defaults, and each time a device is attached, the host SMMUv3 info is
>   retrieved and features are cross-checked.
>  -Includes IORT RMR support to enable MSI doorbell address translation.
>   Thanks to Eric, this is based on his earlier attempt on DSM #5 and
>   IORT RMR support.
>  -Added optional properties (like ATS, RIL, etc.) for the user to overrid=
e
>   the default QEMU SMMUv3 features.
>  -Deferred batched invalidation of commands for now. This series supports
>   basic single in-order command issuing to the host. Batched support will
>   be added as a follow up series.
>  -Includes synthesizing PASID capability for the assigned vfio-pci device=
.
>   Thanks to Yi=E2=80=99s effort, this is based on his out-of-tree patches=
.
>  -Added a migration blocker for now. Plan is to enable migration support
>   later.
>  -Has dependency(patches: 4/5/8)on Zhenzhong's pass-through support serie=
s[1]
>
> PATCH organization:
>  1=E2=80=9320: Enables accelerated SMMUv3 with features based on default =
QEMU SMMUv3,
>        including IORT RMR based MSI support.
>  21=E2=80=9323: Adds options for specifying RIL, ATS, and OAS features.
>  24=E2=80=9327: Adds PASID support, including VFIO changes.
>
> Tests:
> Performed basic sanity tests on an NVIDIA GRACE platform with GPU device
> assignments. A CUDA test application was used to verify the SVA use case.
> Further tests are always welcome.
>
> Eg: Qemu Cmd line:
>
> qemu-system-aarch64 -machine virt,gic-version=3D3,highmem-mmio-size=3D2T =
\
> -cpu host -smp cpus=3D4 -m size=3D16G,slots=3D2,maxmem=3D66G -nographic \
> -bios QEMU_EFI.fd -object iommufd,id=3Diommufd0 -enable-kvm \
> -object memory-backend-ram,size=3D8G,id=3Dm0 \
> -object memory-backend-ram,size=3D8G,id=3Dm1 \
> -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 -numa node,memdev=3Dm1,nodei=
d=3D1 \
> -numa node,nodeid=3D2 -numa node,nodeid=3D3 -numa node,nodeid=3D4 -numa n=
ode,nodeid=3D5 \
> -numa node,nodeid=3D6 -numa node,nodeid=3D7 -numa node,nodeid=3D8 -numa n=
ode,nodeid=3D9 \
> -device pxb-pcie,id=3Dpcie.1,bus_nr=3D1,bus=3Dpcie.0 \
> -device arm-smmuv3,primary-bus=3Dpcie.1,id=3Dsmmuv3.0,accel=3Don,ats=3Don=
,ril=3Doff,pasid=3Don,oas=3D48 \
> -device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1,chassis=3D1,pref64-re=
serve=3D512G,id=3Ddev0 \
> -device vfio-pci,host=3D0019:06:00.0,rombar=3D0,id=3Ddev0,iommufd=3Diommu=
fd0,bus=3Dpcie.port1 \
> -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,node=3D2 \
> ...
> -object acpi-generic-initiator,id=3Dgi7,pci-dev=3Ddev0,node=3D9 \
> -device pxb-pcie,id=3Dpcie.2,bus_nr=3D8,bus=3Dpcie.0 \
> -device arm-smmuv3,primary-bus=3Dpcie.2,id=3Dsmmuv3.1,accel=3Don,ats=3Don=
,ril=3Doff,pasid=3Don \
> -device pcie-root-port,id=3Dpcie.port2,bus=3Dpcie.2,chassis=3D2,pref64-re=
serve=3D512G \
> -device vfio-pci,host=3D0018:06:00.0,rombar=3D0,id=3Ddev1,iommufd=3Diommu=
fd0,bus=3Dpcie.port2 \
> -device virtio-blk-device,drive=3Dfs \
> -drive file=3Dimage.qcow2,index=3D0,media=3Ddisk,format=3Dqcow2,if=3Dnone=
,id=3Dfs \
> -net none \
> -nographic
>
> A complete branch can be found here,
> https://github.com/shamiali2008/qemu-master smmuv3-accel-v4


I have tested this series with stall enabled.
 https://github.com/Linaro/qemu/pull/new/10.1.50-wip

Tested-by:  Zhangfei Gao <zhangfei.gao@linaro.org>

By the way, the stall feature requires some additional patches,
including page fault handling.
Shall we handle that after this series?

Thanks

