Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA389C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 17:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1qD9-0002Zn-Ai; Mon, 07 Apr 2025 13:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1qCy-0002WQ-Bd
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1qCv-0004Mg-NR
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744046663;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hpt+5E4PJftiC5mEAoUqrbVomglX561zjCw5YqHHtAM=;
 b=AnR3lprisjJSY47yz8dOxOxKpJsmn+mn7dR+lcet8odVsEf3KYwEnop1h7eeMqCYXcG6Cn
 FmpSzbu6p2C02xKSW/L6UE8UjNdDgH+o62hVeSz9l1woK3dOiwc+5RCrlZ8onamYoAUeEn
 v3gV1cldavWqTi69Hqm8TP4xuIicR6E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-Ocol8YojOFmuCAOKV4I5Fg-1; Mon, 07 Apr 2025 13:24:20 -0400
X-MC-Unique: Ocol8YojOFmuCAOKV4I5Fg-1
X-Mimecast-MFC-AGG-ID: Ocol8YojOFmuCAOKV4I5Fg_1744046660
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so39012825e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 10:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744046659; x=1744651459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hpt+5E4PJftiC5mEAoUqrbVomglX561zjCw5YqHHtAM=;
 b=ZF6XJGf+ZDGAmm2La+in8W4VrC9xZCBp6R8J7c0+XTKxFDYPTWRcSKZcky48eJAsK6
 huAEUqXMGemLv6SCDnIygGfv98Y/TNMDPAPOA5MgBX+FVhxjWIH4gQywn+4JrTIo83jF
 Ib9afNTMTePpEjLKJy5D5EwSIRTYptG+l95AnFCh+diLehIAJw8JWzMpKZFNBz8S+RI4
 71A44NdCqUQ1vDUz9uO1pQVNv4Hd8qMxrfAwv1LsC4OCqMZLwZQtJUXlmTZd8RzetBeG
 4t55wgYQMNiq3mIK5k2RgWW5x5GRydfdyL8/uyZKy+sgGLkiy5Wx9YBV1mgUC+JQ4bCe
 zW5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSJp+IGkO8YqkC2vq/bRKyBjKvxfLoRjNcX3pipB9r2NBOiyIgSHG4GV9HB05vhB66KUIGeCYsPZ6y@nongnu.org
X-Gm-Message-State: AOJu0YyYy5Jud+lKhrrA2cwebCWUMz8tJHOmOdAddkjikv7rcZ9wPUBv
 7N2tewpJ5/WzGxYhqngM1bWGlr6f/gQcCWysbxyJt2f3qindDcVxhHCLxUHAzZAmRKFYipb+/dc
 2WM7s22dsKFw8cHkL3tLn6n8mft1FrMpCiAYBVECL3saMIKs1uGDB
X-Gm-Gg: ASbGncuJ2/wzDKnSoeUltiFFn7od7zG8JrT2bJsRAeoKdRlNDl+xXtc+m6JfiFvWifJ
 kuJXDdIG3SsAZfYOZuLGGIVDsvp/p2/OMQYM31VV3lBKuBNn0ioavGO4RgdizEgibKxq0Hls6Gz
 YGPyFknqX1RyL9m3TVrK6jSICySi7MDBT8ECFiNsvfgiO64lHk/kkR0/nDp3vmH0vSSSYkAmr4l
 fguUKAz9FGkcqI7Z3vqc0H7QBRCJgnrOp2IoSn0d9yLBHAI7+XNZ1xm4BItvS7FoRgkw4S1OMGo
 5L340hcvPFBzfKrKamJlRgobhn8vH39oFVTTQryeea3YdiIM+FSVhqQXWQLbASE=
X-Received: by 2002:a05:600c:1e8f:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-43ed0b837c4mr114459735e9.1.1744046659421; 
 Mon, 07 Apr 2025 10:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWIvPiOCMDG1oNFq5StopaPxIs56gCvyv/yS4tc0+QBqSWiZSXKwFi89zGwOChAHSPqfKi0g==
X-Received: by 2002:a05:600c:1e8f:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-43ed0b837c4mr114459485e9.1.1744046659009; 
 Mon, 07 Apr 2025 10:24:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a727bsm12582362f8f.27.2025.04.07.10.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 10:24:18 -0700 (PDT)
Message-ID: <7cad3f1f-1977-4d98-900c-080aa5ad32d5@redhat.com>
Date: Mon, 7 Apr 2025 19:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/6] Specifying cache topology on ARM
Content-Language: en-US
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: mst@redhat.com, zhao1.liu@intel.com, dapeng1.mi@linux.intel.com,
 armbru@redhat.com, farman@linux.ibm.com, peter.maydell@linaro.org,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com,
 jiangkunkun@huawei.com, yangyicong@hisilicon.com, linuxarm@huawei.com
References: <20250310162337.844-1-alireza.sanaee@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250310162337.844-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Ali,

On 3/10/25 5:23 PM, Alireza Sanaee via wrote:
> Specifying the cache layout in virtual machines is useful for
> applications and operating systems to fetch accurate information about
> the cache structure and make appropriate adjustments. Enforcing correct
> sharing information can lead to better optimizations. This patch enables
> the specification of cache layout through a command line parameter,
> building on a patch set by Intel [1,2,3]. It uses this set as a
some dependencies were merged. The series does not apply anymore.
> foundation.  The device tree and ACPI/PPTT table, and device tree are
> populated based on user-provided information and CPU topology.
this last sentence need some rewording.
>
> Example:
>
>
> +----------------+                            +----------------+
> |    Socket 0    |                            |    Socket 1    |
> |    (L3 Cache)  |                            |    (L3 Cache)  |
> +--------+-------+                            +--------+-------+
>          |                                             |
> +--------+--------+                            +--------+--------+
> |   Cluster 0     |                            |   Cluster 0     |
> |   (L2 Cache)    |                            |   (L2 Cache)    |
> +--------+--------+                            +--------+--------+
>          |                                             |
> +--------+--------+  +--------+--------+    +--------+--------+  +--------+----+
> |   Core 0         | |   Core 1        |    |   Core 0        |  |   Core 1    |
> |   (L1i, L1d)     | |   (L1i, L1d)    |    |   (L1i, L1d)    |  |   (L1i, L1d)|
> +--------+--------+  +--------+--------+    +--------+--------+  +--------+----+
>          |                   |                       |                   |
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
>  -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-
s/cluseter/cluster
> cache.3.cache=l3,smp-cache.3.topology=socket \
>  -cpu max \
>  -m 2048 \
>  -smp sockets=2,clusters=1,cores=2,threads=2 \
>  -kernel ./Image.gz \
>  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>  -initrd rootfs.cpio.gz \
>  -bios ./edk2-aarch64-code.fd \
>  -nographic
>
> The following command will represent the system relying on **the device tree**.
>
> ./qemu-system-aarch64 \
>  -machine virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-cache.3.cache=l3,smp-cache.3.topology=socket \
>  -cpu max \
>  -m 2048 \
>  -smp sockets=2,clusters=1,cores=2,threads=2 \
>  -kernel ./Image.gz \
>  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=off" \
>  -initrd rootfs.cpio.gz \
>  -nographic
>
> Failure cases:
>     1) There are scenarios where caches exist in systems' registers but
>     left unspecified by users. In this case qemu returns failure.
Can you give more details on 1)? is it a TCG case or does it also exist
with KVM acceleration?
>
>     2) SMT threads cannot share caches which is not very common. More
>     discussions here [4].
>
> Currently only three levels of caches are supported to be specified from
> the command line. However, increasing the value does not require
> significant changes. Further, this patch assumes l2 and l3 unified
> caches and does not allow l(2/3)(i/d). The level terminology is
> thread/core/cluster/socket right now. Hierarchy assumed in this patch:
> Socket level = Cluster level + 1 = Core level + 2 = Thread level + 3;
>
> TODO:
>   1) Making the code to work with arbitrary levels
>   2) Separated data and instruction cache at L2 and L3.
>   3) Additional cache controls.  e.g. size of L3 may not want to just
>   match the underlying system, because only some of the associated host
>   CPUs may be bound to this VM.
Does it mean this is more an RFC or do you plan to send improvement
patches once this series gets upstream?

Thanks

Eric
>
> [1] https://lore.kernel.org/kvm/20240908125920.1160236-1-zhao1.liu@intel.com/
> [2] https://lore.kernel.org/qemu-devel/20241101083331.340178-1-zhao1.liu@intel.com/
> [3] https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
> [4] https://lore.kernel.org/devicetree-spec/20250203120527.3534-1-alireza.sanaee@huawei.com/
>
> Change Log:
>   v7->v8:
>    * rebase: Merge tag 'pull-nbd-2024-08-26' of https://repo.or.cz/qemu/ericb into staging
>    * I mis-included a file in patch #4 and I removed it in this one.
>
>   v6->v7:
>    * Intel stuff got pulled up, so rebase.
>    * added some discussions on device tree.
>
>   v5->v6:
>    * Minor bug fix.
>    * rebase based on new Intel patchset.
>      - https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
>
>   v4->v5:
>     * Added Reviewed-by tags.
>     * Applied some comments.
>
>   v3->v4:
>     * Device tree added.
>
> Depends-on: Building PPTT with root node and identical implementation flag
> Depends-on: Msg-id: 20250306023342.508-1-alireza.sanaee@huawei.com
>
> Alireza Sanaee (6):
>   target/arm/tcg: increase cache level for cpu=max
>   arm/virt.c: add cache hierarchy to device tree
>   bios-tables-test: prepare to change ARM ACPI virt PPTT
>   hw/acpi/aml-build.c: add cache hierarchy to pptt table
>   tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
>   Update the ACPI tables according to the acpi aml_build change, also
>     empty bios-tables-test-allowed-diff.h.
>
>  hw/acpi/aml-build.c                        | 205 +++++++++++-
>  hw/arm/virt-acpi-build.c                   |   8 +-
>  hw/arm/virt.c                              | 350 +++++++++++++++++++++
>  hw/cpu/core.c                              |  92 ++++++
>  hw/loongarch/virt-acpi-build.c             |   2 +-
>  include/hw/acpi/aml-build.h                |   4 +-
>  include/hw/arm/virt.h                      |   4 +
>  include/hw/cpu/core.h                      |  27 ++
>  target/arm/tcg/cpu64.c                     |  13 +
>  tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 540 bytes
>  tests/qtest/bios-tables-test.c             |   4 +
>  11 files changed, 701 insertions(+), 8 deletions(-)
>


