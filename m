Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AAAC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0weU-0003ga-FJ; Mon, 31 Aug 2026 03:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1x0weS-0003eI-QX; Mon, 31 Aug 2026 03:41:56 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1x0weQ-00052J-HK; Mon, 31 Aug 2026 03:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=Nt7lEld3dW
 AtkCJoWxMQi3BMcDyUI7vsc0kJkDLYU28=; b=Q++dGdxgq/dhQklIT8jz7SmDR3
 sVkVOfOufsOPM7xlVNQy3ynsYWoRuON2Fqp60bK6hDgJP8ErY+005bUlUNq1M8fz
 9sl5etRPmpogSTrorqVKCsQO9W8oEji/wNsv5RDf8MO0fCeU4CwV7jOYslg+Egbv
 D/6XdzdMEZMMgaIyc=
Received: from ur-dp1000 (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwDHQAceMJVq4BUAAA--.112S2; 
 Mon, 31 Aug 2026 15:41:36 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-stable@nongnu.org,
 Xie Bo <xb@ultrarisc.com>
Subject: [PATCH 0/3] target/riscv/kvm: Fix a few migration issues
Date: Mon, 31 Aug 2026 15:41:03 +0800
Message-ID: <20260831074106.1798671-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHQAceMJVq4BUAAA--.112S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1xKr47KF43ZryfXw47urg_yoWkuFg_Ww
 40yFW3ua4UXFyUXFWUuw15JrW3JrWrGFyUCa17Jr4DK34UWryDJ3Z8GF15ZrWUArW5Jryf
 Ar1Sqa4xKw17XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
 1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
 IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
 6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
 AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
 s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
 0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbzpBDUUUUU==
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAMB2qOWvsAQwALsH
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

Here are three RISC-V KVM migration fixes I found while testing live
migration.

The first patch fixes FCSR migration.  The second makes the existing
timer-frequency restriction effective by rejecting migration between
hosts with different frequencies.  While checking the vector register
code, I also noticed that vcsr was not synchronized.

I tested KVM and non-KVM builds.  On the RISC-V host, a four-vCPU guest
kept running after migration and FCSR was preserved.  Migration from a
10 MHz source to a destination reporting 11 MHz was rejected.

The test host does not have the V extension, so I could only
compile-test the last patch.

Thanks,
Bo

Xie Bo (3):
  target/riscv/kvm: Preserve FCSR across migration
  target/riscv/kvm: Reject migration with a different timer frequency
  target/riscv/kvm: Preserve VCSR across migration

 target/riscv/cpu.h           |  4 ++
 target/riscv/kvm/kvm-cpu.c   | 74 +++++++++++++++++++++++++++---------
 target/riscv/kvm/kvm_riscv.h |  1 +
 target/riscv/machine.c       | 58 ++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 18 deletions(-)


base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
-- 
2.17.1


