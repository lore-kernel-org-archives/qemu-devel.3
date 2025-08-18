Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0AACA0EE9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 16:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo2cM-0003Cu-MP; Mon, 18 Aug 2025 12:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo2cL-0003Bz-7W
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 12:21:53 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo2cI-0001Lh-EK
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 12:21:52 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e9455cfb9d1so1143796276.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755534107; x=1756138907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xlBhVuyiDx3sHAwIeScxz0yValA8W/8lvrL85/LjQu8=;
 b=M2P9Dg+7ZLroySTouelnVzFcgo1SmdZPtPhXJR76AF9tGmqROtpM5GnW1UXDFOdYcG
 wc4rfAB7xykAcGP4HS2qYxVrYICSwF6ja6Wxblddz2SxIPlu8Cg4f9I53kHP0FeRhEpW
 EC4TSfErqX1l8NWEXRZ27c5j4Ba0RcuJYCCGx2hTcMa2jAFDJT5rTVzieMuG4RWCzp74
 hyRVRWTflNMKU0gFiMgJZ5q6B5pdICVTQMX5tYFYpMpVybaxD/JRjOdqT0aKnsgv//cQ
 Na4uq9mORH8+ET7TDxl50rA1PAWY1to1a5exgd/KagauyFOUZ7mtVnlGPLac3EH4WUcx
 Vi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755534107; x=1756138907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xlBhVuyiDx3sHAwIeScxz0yValA8W/8lvrL85/LjQu8=;
 b=JWTtipzX3eRACLxQMIA3Rznf2kE5Ol3aufYjsLRCYY9lDdT+1qxr4A1k4pHuwt9rY9
 MlCrrA7IUF5NXKzp2l/fFW1/4g3a8WDE/SrwK9JyAEI2n/HfCd44TQ1m25q0ex19GUhz
 iJa1TYJpr7R3g9EPs9Hz+CVDIWcZzOK9yOUtJdxKCXdNaqMpnObcNd+ZM5x9CWGvAvgr
 aiMDujsZ0JxjH6/L/Uvt/9CAJ4BIohZzewcN7gtpCnMWh+hheAX7jq61aa6cD/c8FHJN
 PKxn1UdaKwy9vdZ6mkj/HCP3PL9Yt+R1PxhLHtbjCT9MCDTTmwdFj/dWHyyHSZBP/hqn
 Jt3Q==
X-Gm-Message-State: AOJu0Yy0b+HyltQN+hoSS2bHIxdkrc9JAhJn34mELTn/aLxuQqnDRNMV
 kjxNkc7wfUWupspYhzrWLlYvb6MFm8R+ZlD+o7iEONfMC33J0RJWOkQ0YFSwzfufDIwUuUVEzzc
 A47eErggcrVYazDlhZAkAGPkZ6q7z0vMpUNVaHu/DSg==
X-Gm-Gg: ASbGncv0OeRN7ca7JL6Hbw/oLWyZ9j6rceekSDrFq3aeiso5LUPc0Ixuowv2qcdkaoX
 77TjSo53pYr1ht5Z3+RQ8mAKAbGPL7xuLxY9+dKRLjCJ/ICGxOedcah/twiV7sdyEKnqndYUjEj
 yMAHg7Y+gj6vZotRXEjSz02wdst8RYf/BLCHorjMPIjznlllyFyIdoXnA2I7pliKdJAau45rvPW
 E+0vhOZ
X-Google-Smtp-Source: AGHT+IHnA1uI3SU6DTvJOhMFmpFk1QtysuhMzAccLMgPr14MSFtk3h0tHK7zXlgymAA2O+F1P/5jMoCI4AkWTyDvz0M=
X-Received: by 2002:a05:6902:3307:b0:e93:3d61:d5b with SMTP id
 3f1490d57ef6-e94e3a7ab92mr216663276.9.1755534107312; Mon, 18 Aug 2025
 09:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250807-nvdimm_arm64_virt-v2-1-b8054578bea8@linaro.org>
In-Reply-To: <20250807-nvdimm_arm64_virt-v2-1-b8054578bea8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Aug 2025 17:21:35 +0100
X-Gm-Features: Ac12FXwJP8K75WHUagGLprZ25owK05tXR_AvlNNdKwtxlouS53vCCBKmw8-vGwo
Message-ID: <CAFEAcA97c9XT17T=e_=O_8SRdfdmAOQM1Nv825-cLyMOxkB-1A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: add static NVDIMMs in device tree
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>, jonathan.cameron@huawei.com,
 philmd@linaro.org, 
 shameerali.kolothum.thodi@huawei.com, hsiangkao@linux.alibaba.com, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 7 Aug 2025 at 11:14, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> NVDIMM is used for fast rootfs with EROFS, for example by kata
> containers. To allow booting with static NVDIMM memory, add them to the
> device tree in arm virt machine.
>
> This allows users to boot directly with nvdimm memory devices without
> having to rely on ACPI and hotplug.
>
> Verified to work with command invocation:
>
> ./qemu-system-aarch64 \
>   -M virt,nvdimm=on \
>   -cpu cortex-a57 \
>   -m 4G,slots=2,maxmem=8G \
>   -object memory-backend-file,id=mem1,share=on,mem-path=/tmp/nvdimm,size=4G,readonly=off \
>   -device nvdimm,id=nvdimm1,memdev=mem1,unarmed=off \
>   -drive file=./debian-12-nocloud-arm64-commited.qcow2,format=qcow2 \
>   -kernel ./vmlinuz-6.1.0-13-arm64 \
>   -append "root=/dev/vda1 console=ttyAMA0,115200 acpi=off"
>   -initrd ./initrd.img-6.1.0-13-arm64 \
>   -nographic \
>   -serial mon:stdio
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v2:
> - Reduce ret value lines in fdt_add_pmem_node() (thanks Jonathan Cameron!)
> - Link to v1: https://lore.kernel.org/qemu-devel/20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org
> ---



Applied to target-arm.next, thanks.

-- PMM

