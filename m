Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA64CA5FFF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhkSk-0004g0-F1; Mon, 19 Jan 2026 03:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vhkST-0004bg-Q5
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:17:59 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vhkSQ-0001NJ-QG
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:17:56 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-382f9930e54so38612711fa.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 00:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768810672; x=1769415472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2gpQ3rF1sUTzlmS/B3wJsIxT8D9IIdKIdjdwD5Xcmo=;
 b=GitOCYvhPZTvTBvHQAYQ3X+GZNTdq/WNobdWdjch2HXLE3rpvUPcIDIFOo/iNnJens
 zOhiPW3LDABwYJqLZre42GXBlgmG6Y4xy2jh1CWSABctg8bicAGD1af6n6zaaohD9N3U
 dUiAgi1oBe8yjGcaOaAPC9qsXpVn76f3q7IYH6JocTt8KGLcoaEaxPaU9+oBTLT8fDAf
 HBSCSykgIUGdadBJ22HuMavNvYT0KI/dh5bglSiPbCLKAmgbjDygf5+0eAG1MUpmbHb4
 w2ZSzOZFdvtl8kMNDLF80Oq4QH5p14JFFRkdZOhtqb5o8+MrCxhYr4SzJtV4QqTu6JHO
 ptLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768810672; x=1769415472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p2gpQ3rF1sUTzlmS/B3wJsIxT8D9IIdKIdjdwD5Xcmo=;
 b=VafN6tOydEf/dgYRwPLiLHca9SyLeLkdiC/rbL0vUDJx7ib1nQ9nidF/fdibMzG7sR
 zb+KCHKpgMvs1ZAVkHf9oMUoqhaochSlWrSEDBP6gUfkBt/aKe0frrxhiWGFJQkwUGdh
 gwSgf+8RMqBf2BHjnuRQUl1fhOGYCfIoj/2zPN1arnKkKH59tbzmHN0fzGhSxBC37nV7
 Kfx+dmHnG8CVlz9hk0N+pDHL6pbJzQ0NSAJFaYbZW3mh3DdTFbZ86/prjb3A55fCQogy
 As0Pzv2uAzVNOmxbbKJJzgesGFQeCbVTVpe8B7pXLgsQQPS0g+iCYevDM2m+8NjC0sRS
 4DCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY5R29LKOr8atUYmnf/uWI7q8pNz4iZWAZFT49pHz107qiejU8h4KxMvOO9x1lubCIRjvmGAIT85HR@nongnu.org
X-Gm-Message-State: AOJu0YzpgLihyIFMjES1Dm+B5qOnVtIP0HUJyFXm6E8dA3K0SOaipQ2/
 bomjivqCsAOkoqvBvvJ1ZJrlAvSbsEnmx95r1JU1Lj9tTrHZ1UGmghkhlOH/Fam2RnASFTgHrFk
 uQxa5rfO6qlGeyTt1X9WHggJOyy+vPnlYSTaQtruIHA==
X-Gm-Gg: AY/fxX4RnoMBzD8cnc+/pdgsItvGAvT2oyONTnW50i1vggwHZNEMd601du8oUHFg+yC
 VYdrd1kRM6mOee8iohEq6IcrEpMIdgSK0aM7jf6SGk2RF3CrPUQlIUYbUycFAjsT7AdSttuSv52
 8SCB1E2ITnc/Zn+p/yEN74m/wmdeoEt+Ifi6FwMU/dCIJlsWvu7TNu3GRS1RVf2nZqmCwbfxIZW
 xk8MX6uheQyUwt2JlwVdGs8c2QGgYF/UNHPiweayRJm+tqvLa3osdjT+tvK18Thfxp+nw==
X-Received: by 2002:a05:651c:43c9:10b0:383:3f0e:adef with SMTP id
 38308e7fff4ca-3836ef60220mr41861281fa.1.1768810672122; Mon, 19 Jan 2026
 00:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
In-Reply-To: <20260111195508.106943-1-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 19 Jan 2026 16:17:40 +0800
X-Gm-Features: AZwV_Qh063PZ5KtmJ5jw-3MP97vQQPxXwUHPjeQjPPvzzdGqGcKDgFJCmoicLv4
Message-ID: <CABQgh9HD=2CJC2n5_h0vwFn3yr3SKbvTJWKGqWBo4ppSFgjj3w@mail.gmail.com>
Subject: Re: [PATCH v7 00/36] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, alex@shazbot.org, 
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com, 
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com, 
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lj1-x22c.google.com
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

On Mon, 12 Jan 2026 at 03:55, Shameer Kolothum <skolothumtho@nvidia.com> wr=
ote:
>
> Hi,
>
> Major changes since v6:
>  https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@n=
vidia.com/
>
>  - Addressed feedback from v6 and picked up R-by tags. Thanks!
>  - Fixed build and compilation issues reported on multiple architectures.
>  - Reworked and introduced a HostIOMMUDeviceClass callback to retrieve
>    pasid info(patch #32)
>  - Added an helper to insert a CAP ID at an offset in PCIe config space
>    (patch #33)
>  - Added an x-vpasid-cap-offset property for vfio-pci devices to allow
>    opt-in synthesis of the PASID capability (patch #35).
>  - Renamed the pasid property to ssidsize (patch #36).
>  - VFIO/IOMMUFD changes depend on Zhenzhong=E2=80=99s pass-through suppor=
t series,
>    patches 4/5/8 [0].
>
> Patch organization:
>
> 1=E2=80=9327: Enable accelerated SMMUv3 with features aligned to the defa=
ult QEMU
> SMMUv3 implementation, including IORT RMR-based MSI support.
>
> 28=E2=80=9330: Add user-configurable options for RIL, ATS, and OAS featur=
es.
>
> 31=E2=80=9336: Add PASID support, including required VFIO changes.
>
> Testing:
>  Basic sanity testing was performed on an NVIDIA Grace platform with GPU
>  device assignment. A CUDA test application was used to validate the SVA
>  use case. Additional testing and feedback are welcome.
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
,ril=3Doff,ssidsize=3D20,oas=3D48 \
> -device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1,chassis=3D1,pref64-re=
serve=3D512G,id=3Ddev0 \
> -device vfio-pci,host=3D0019:06:00.0,rombar=3D0,id=3Ddev0,iommufd=3Diommu=
fd0,bus=3Dpcie.port1,x-vpasid-cap-offset=3D0xff8 \
> -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,node=3D2 \
> ...
> -object acpi-generic-initiator,id=3Dgi7,pci-dev=3Ddev0,node=3D9 \
> -device pxb-pcie,id=3Dpcie.2,bus_nr=3D8,bus=3Dpcie.0 \
> -device arm-smmuv3,primary-bus=3Dpcie.2,id=3Dsmmuv3.1,accel=3Don,ats=3Don=
,ril=3Doff,ssidsize=3D20,oas=3D48 \
> -device pcie-root-port,id=3Dpcie.port2,bus=3Dpcie.2,chassis=3D2,pref64-re=
serve=3D512G \
> -device vfio-pci,host=3D0018:06:00.0,rombar=3D0,id=3Ddev1,iommufd=3Diommu=
fd0,bus=3Dpcie.port2,x-vpasid-cap-offset=3D0xff8 \
> -device virtio-blk-device,drive=3Dfs \
> -drive file=3Dimage.qcow2,index=3D0,media=3Ddisk,format=3Dqcow2,if=3Dnone=
,id=3Dfs \
> -net none \
> -nographic
>
> A complete branch can be found here,
> https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v7-e=
xt
>
> Please take a look and let me know your feedback.

Thanks Shameer

The whole series is tested well with Shameer's fix of patch 33.
Tested-by:  Zhangfei Gao <zhangfei.gao@linaro.org>

https://github.com/Linaro/qemu/tree/master-smmuv3-accel-v7

Thanks

