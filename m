Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9D1C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cF7-00073x-Hx; Wed, 08 May 2024 04:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1s4cEt-0006wG-Ry
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:01:23 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1s4cEp-0007Wh-8n
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:01:23 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3PhJAMTtm9yuWAQ--.3660S2;
 Wed, 08 May 2024 16:01:04 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwAHIjs5MTtmb2MAAA--.378S3;
 Wed, 08 May 2024 16:00:57 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: CXL numa error on arm64 qemu virt machine
Date: Wed,  8 May 2024 16:00:51 +0800
Message-Id: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHIjs5MTtmb2MAAA--.378S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQATAWY6gmcCxgABsv
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXw18KFW3Ar4rGF4kJFWrXwb_yoW5GF1DpF
 42v3Wjgrs5JFnruw1kta4rJFyYqw4SvanrWry3AF1ruw1Utr18Xr1IyFy3KFykAw43GwnF
 va1ktFn0qa48Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello, Jonathan

Recently I run some cxl tests on qemu virt(branch:cxl-2024-04-22-draft) but met some
problems.

Problems: 
1) the virt machine could not set the right numa topology from user input;

My Qemu numa set:
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \

However, the system shows:
root@ubuntu-jammy-arm64:~# numactl -H
	available: 1 nodes (0)
	node 0 cpus: 0 1 2 3
	node 0 size: 4166 MB
	node 0 free: 3920 MB
	node distances:
	node   0 
	0:  10 

Boot Kernel print:
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0xbfffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0xc0000000-0x13fffffff]
[    0.000000] ACPI: Unknown target node for memory at 0x10000000000, assuming node 0
[    0.000000] NUMA: Warning: invalid memblk node 16 [mem 0x0000000004000000-0x0000000007ffffff]
[    0.000000] NUMA: Faking a node at [mem 0x0000000004000000-0x000000013fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x13f7f89c0-0x13f7fafff]

2) it seems like the problem of allocating numa node in arm for cxl memory still exists;
Previous discussion: https://lore.kernel.org/linux-cxl/20231011150620.0000212a@Huawei.com/

root@debian-bullseye-arm64:~# cxl create-region -d decoder0.0 -t ram
[   68.653873] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
[   68.660568] Unknown target node for memory at 0x10000000000, assuming node 0

If not, maybe I could try to do something to help fix this problem.


My full qemu command line:
qemu-system-aarch64 \
-M virt,gic-version=3,cxl=on \
-m 4G \
-smp 4 \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-cpu cortex-a57 \
-bios QEMU_EFI.fd.bak \
-device virtio-blk-pci,drive=hd,bus=pcie.0 \
-drive if=none,id=hd,file=../disk/debos_arm64.ext \
-nographic \
-object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-device cxl-type3,bus=root_port13,volatile-memdev=mem2,id=cxl-mem1 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
-qmp tcp:127.0.0.1:4444,server,nowait \

Qemu version: the lastest commit of branch cxl-2024-04-22-draft in "https://gitlab.com/jic23/qemu" 
Kernel version: 6.6.0

Many thanks
Yuquan


