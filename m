Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CC3CAC59C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 09:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy5JM-0007Uu-DP; Mon, 15 Sep 2025 05:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uy5JD-0007Sr-Kc
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:15:41 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uy5Iy-0005uA-RX
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:15:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQK0P6hJnz6L6V5;
 Mon, 15 Sep 2025 17:06:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 652B91402F0;
 Mon, 15 Sep 2025 17:11:11 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 11:11:11 +0200
Date: Mon, 15 Sep 2025 10:11:09 +0100
To: Bibo Mao <maobibo@loongson.cn>
CC: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/8] Add high MMIO support with GPEX host bridge
Message-ID: <20250915101109.00001833@huawei.com>
In-Reply-To: <20250915071946.315171-1-maobibo@loongson.cn>
References: <20250915071946.315171-1-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 15 Sep 2025 15:19:38 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On LoongArch Virt Machine, MMIO region with GPEX host bridge is
> 0x40000000 -- 0x7FFFFFFF. The total size is 1G bytes and it is enough
> for emulated virtio devices basically.
> 
> However on some conditions such as hostmem is added with virtio-gpu
> device with -device virtio-gpu-gl,hostmem=4G. The PCIE MMIO region is
> not enough, 64-bit high MMIO region is required.
> 
> Here property highmem-mmio is added on virt machine to add 64-bit high
> MMIO region supported. With high MMIO region added, it is not compatible
> with old machine, so property highmem-mmio is disabled by default.

Trivial request. Please mention loongarch in the cover letter title.
It will help people make a quick decision on whether they should be looking
at the thread or not.

Jonathan

> 
> Bibo Mao (8):
>   target/loongarch: Add phys_bits in CPULoongArchState
>   hw/loongarch/virt: Add field ram_end in LoongArchVirtMachineState
>   hw/loongarch/virt: Add field gpx in LoongArchVirtMachineState
>   hw/loongarch/virt: Get irq number from gpex config info
>   hw/loongarch/virt: Get PCI info from gpex config info
>   hw/loongarch/virt: Add property highmem_mmio with virt machine
>   hw/loongarch/virt: Add high MMIO support with GPEX host
>   hw/loongarch/virt: Add property highmem-mmio-size with virt machine
> 
>  hw/loongarch/virt-acpi-build.c |  17 +---
>  hw/loongarch/virt-fdt-build.c  |  43 +++++++---
>  hw/loongarch/virt.c            | 152 ++++++++++++++++++++++++++++++---
>  include/hw/loongarch/virt.h    |   5 +-
>  target/loongarch/cpu.c         |  13 +--
>  target/loongarch/cpu.h         |   2 +
>  6 files changed, 186 insertions(+), 46 deletions(-)
> 
> 
> base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d


