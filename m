Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A8C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YwU-0002sC-TU; Wed, 23 Apr 2025 08:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YwC-0002fz-0B
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:10:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Yw7-00017W-6C
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:10:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso4799860f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745410241; x=1746015041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+arAEUWpnzX2oRLsVknv+xofVWq+hPhMO0BZDlW4t2g=;
 b=voHR/9QyGEFCzIfBU1++/mhrw/kQWVKzoWVGJyCHFLyUcUZynS/NLRaX+Xjh/CX7R+
 BvmTjYwHHpgkHhR78kWrBLMzTxkzW7PSoTJdCJtMjz1B7fSBz4KQynO3ySEp//mNOmEX
 SYzM51A2hdRBrFz/RgCj+Rdi/dj+7I0BKj1WXejhdQDnWOqsnV6+7dP5r9p6Ywxnlpf2
 kuDMtHKhzofnvvZdjqvrjD03ABy72iZkWZWl7lrbYpEwh43JTaF5Nnn3s75xqfuR4fvN
 Wh6zUSK6V2bdf5yHL3OKW3SSIgyLDFvNPMF7VfRlIlLqQOJNtNvS5rvAumfkhmfWXIoW
 l2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745410241; x=1746015041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+arAEUWpnzX2oRLsVknv+xofVWq+hPhMO0BZDlW4t2g=;
 b=ndqszVCx40PsrabBTXaT9lyX0xFXRZW9PQxs2NfvdWgiA6oPjwYPh7ha6ywirpeizG
 ycjYnteZ0bmBoToSEUG6jnxlXJYxfOeh5IFFo4DzYWOnFQfUsQdfXaK/EQ7wSGmekeba
 w3PbhXMBqNQxy/l/QIpcGoqA75Opdkw2+GBQs2qBC7mPlX5hXJuB8VlTE/RbFMUxkSw3
 NlX7POu4TF3dxpB9l1FiW2B4H7anhNESoSDjg0yOBXXv1r9OZemhbc0NdM2Co33UPeSn
 9SCsqm7hcVNnbLqD7aUrVSdpZYtf6Cu8mNLHOHOwhqg95M3/6LYWwKB+VAHho2Ehu/64
 J+fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwZjpELhnJ45TugqrA0jCtI8EQQmf3TVWjBCOrqY78riU+EseW9+f+UHAHrDeL7TwEQ46o0IC7DNdV@nongnu.org
X-Gm-Message-State: AOJu0Yx1aHmHiGDAnijv23c4LeYqMWLMvTif0sz/BklxVsL/yjm3Np2H
 zDZgTCsIsfgMbJLdx5W+NhJrN0aaCcT7LWGPhQWAMqW9+es3ObbDx7VD6kP+7oM=
X-Gm-Gg: ASbGncsOPAgz1BraosDahJi7qEY0GEvMDW2iIqTJ9hP9fMls7D/Zs4sEYpK9cpTeUL6
 kvV7CjwmNxigf9yXnOXU2xPdNrByhDTbnF3zxSMMbYB5cvbPAKIPApMqCy26Ewk6x6KY1M9s6vO
 75PzmsR0XrDVXOwprLj6X1CO6MaQ0Mv5Hs+1PVkgdNCMhUL+wa0pLUJoqewOyJt5fyTHqlh8WCH
 xj0a9yP7/bFfHM8YLvRJhheu4nan2Dw6cRv+Af8ib+hLCy9vaJECoJgZ70ONCx0Xu0I47ve3aMf
 JLv/6LQilAs6f3xgH9ZXDIZiWIqmUZJBDlFfHl2yTrCpgLWuICyojqZkGjdlRR3FhlX/KbmYl0u
 eBVOXKda2EiuWxMmKeLA=
X-Google-Smtp-Source: AGHT+IETBiAwwFKOtfYl3S/jXqaBdGGIdr7XIw6nPOvRHMGXJb/IIDhlotKrOG6FfrTn4gLAvB0oSg==
X-Received: by 2002:a05:6000:2281:b0:39c:1257:c7a3 with SMTP id
 ffacd0b85a97d-39efbb23ac3mr17192981f8f.59.1745410241122; 
 Wed, 23 Apr 2025 05:10:41 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207e6sm18393895f8f.7.2025.04.23.05.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 05:10:40 -0700 (PDT)
Message-ID: <5e064d65-71ad-4d16-a2e5-b3499cdd2ffc@linaro.org>
Date: Wed, 23 Apr 2025 14:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Specifying cache topology on ARM
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, mst@redhat.com, mtosatti@redhat.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com, zhao1.liu@intel.com
References: <20250423120457.1042-1-alireza.sanaee@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250423120457.1042-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

+Gustavo

On 23/4/25 14:04, Alireza Sanaee via wrote:
> Specifying the cache layout in virtual machines is useful for
> applications and operating systems to fetch accurate information about
> the cache structure and make appropriate adjustments. Enforcing correct
> sharing information can lead to better optimizations. This patch enables
> the specification of cache layout through a command line parameter,
> building on a patch set by Intel [1,2,3]. It uses this set as a
> foundation.  The device tree and ACPI/PPTT table, and device tree are
> populated based on user-provided information and CPU topology.
> 
> Example:
> 
> 
> +----------------+                            +----------------+
> |    Socket 0    |                            |    Socket 1    |
> |    (L3 Cache)  |                            |    (L3 Cache)  |
> +--------+-------+                            +--------+-------+
>           |                                             |
> +--------+--------+                            +--------+--------+
> |   Cluster 0     |                            |   Cluster 0     |
> |   (L2 Cache)    |                            |   (L2 Cache)    |
> +--------+--------+                            +--------+--------+
>           |                                             |
> +--------+--------+  +--------+--------+    +--------+--------+  +--------+----+
> |   Core 0         | |   Core 1        |    |   Core 0        |  |   Core 1    |
> |   (L1i, L1d)     | |   (L1i, L1d)    |    |   (L1i, L1d)    |  |   (L1i, L1d)|
> +--------+--------+  +--------+--------+    +--------+--------+  +--------+----+
>           |                   |                       |                   |
> +--------+              +--------+              +--------+          +--------+
> |Thread 0|              |Thread 1|              |Thread 1|          |Thread 0|
> +--------+              +--------+              +--------+          +--------+
> |Thread 1|              |Thread 0|              |Thread 0|          |Thread 1|
> +--------+              +--------+              +--------+          +--------+
> 
> 
> The following command will represent the system relying on **ACPI PPTT tables**.
> 
> ./qemu-system-aarch64 \
>   -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
>   -cpu max \
>   -m 2048 \
>   -smp sockets=2,clusters=1,cores=2,threads=2 \
>   -kernel ./Image.gz \
>   -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>   -initrd rootfs.cpio.gz \
>   -bios ./edk2-aarch64-code.fd \
>   -nographic
> 
> The following command will represent the system relying on **the device tree**.
> 
> ./qemu-system-aarch64 \
>   -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
>   -cpu max \
>   -m 2048 \
>   -smp sockets=2,clusters=1,cores=2,threads=2 \
>   -kernel ./Image.gz \
>   -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=off" \
>   -initrd rootfs.cpio.gz \
>   -nographic
> 
> Failure cases:
>      1) There are scenarios where caches exist in systems' registers but
>      left unspecified by users. In this case qemu returns failure.
> 
>      2) SMT threads cannot share caches which is not very common. More
>      discussions here [4].
> 
> Currently only three levels of caches are supported to be specified from
> the command line. However, increasing the value does not require
> significant changes. Further, this patch assumes l2 and l3 unified
> caches and does not allow l(2/3)(i/d). The level terminology is
> thread/core/cluster/socket right now. Hierarchy assumed in this patch:
> Socket level = Cluster level + 1 = Core level + 2 = Thread level + 3;
> 
> TODO:
>    1) Making the code to work with arbitrary levels
>    2) Separated data and instruction cache at L2 and L3.
>    3) Additional cache controls.  e.g. size of L3 may not want to just
>    match the underlying system, because only some of the associated host
>    CPUs may be bound to this VM.
> 
> [1] https://lore.kernel.org/kvm/20240908125920.1160236-1-zhao1.liu@intel.com/
> [2] https://lore.kernel.org/qemu-devel/20241101083331.340178-1-zhao1.liu@intel.com/
> [3] https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
> [4] https://lore.kernel.org/devicetree-spec/20250203120527.3534-1-alireza.sanaee@huawei.com/
> 
> Change Log:
>    v8->v9:
>     * rebase to 10
>     * Fixed a bug in device-tree generation related to a scenario when
>          caches are shared at core in higher levels than 1.
>    v7->v8:
>     * rebase: Merge tag 'pull-nbd-2024-08-26' of https://repo.or.cz/qemu/ericb into staging
>     * I mis-included a file in patch #4 and I removed it in this one.
> 
>    v6->v7:
>     * Intel stuff got pulled up, so rebase.
>     * added some discussions on device tree.
> 
>    v5->v6:
>     * Minor bug fix.
>     * rebase based on new Intel patchset.
>       - https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
> 
>    v4->v5:
>      * Added Reviewed-by tags.
>      * Applied some comments.
> 
>    v3->v4:
>      * Device tree added.
> 
> Depends-on: Building PPTT with root node and identical implementation flag
> Depends-on: Msg-id: 20250423114130.902-3-alireza.sanaee@huawei.com
> 
> Alireza Sanaee (6):
>    target/arm/tcg: increase cache level for cpu=max
>    arm/virt.c: add cache hierarchy to device tree
>    bios-tables-test: prepare to change ARM ACPI virt PPTT
>    hw/acpi/aml-build.c: add cache hierarchy to pptt table
>    tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
>    Update the ACPI tables according to the acpi aml_build change, also
>      empty bios-tables-test-allowed-diff.h.
> 
>   hw/acpi/aml-build.c                        | 205 +++++++++++-
>   hw/arm/virt-acpi-build.c                   |   8 +-
>   hw/arm/virt.c                              | 350 +++++++++++++++++++++
>   hw/cpu/core.c                              |  92 ++++++
>   hw/loongarch/virt-acpi-build.c             |   2 +-
>   include/hw/acpi/aml-build.h                |   4 +-
>   include/hw/arm/virt.h                      |   4 +
>   include/hw/cpu/core.h                      |  27 ++
>   target/arm/tcg/cpu64.c                     |  13 +
>   tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 540 bytes
>   tests/qtest/bios-tables-test.c             |   4 +
>   11 files changed, 701 insertions(+), 8 deletions(-)
> 


