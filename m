Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBCAC25B76
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 01:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF2GV-0000fT-Hm; Wed, 05 Jun 2024 21:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1sF2GT-0000f6-UR; Wed, 05 Jun 2024 21:50:05 -0400
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1sF2GR-0003cm-OC; Wed, 05 Jun 2024 21:50:05 -0400
Received: from localhost.localdomain (unknown [10.12.130.31])
 by app1 (Coremail) with SMTP id TAJkCgC3WOUsFWFmO5IOAA--.39860S4;
 Thu, 06 Jun 2024 09:47:25 +0800 (CST)
From: Chao Du <duchao@eswincomputing.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 ajones@ventanamicro.com, alistair23@gmail.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, anup@brainfault.org,
 duchao713@qq.com
Subject: [PATCH v4 0/3] target/riscv/kvm: QEMU support for KVM Guest Debug on
 RISC-V
Date: Thu,  6 Jun 2024 01:44:58 +0000
Message-Id: <20240606014501.20763-1-duchao@eswincomputing.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: TAJkCgC3WOUsFWFmO5IOAA--.39860S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xZryDZr1UtrW3Gw1xZrb_yoW8WFW7pa
 1F9F98CrZIqrWfG3ySk3Z7Gr15Xws5Cr1UXw1xZw4Fgr45Zay8Ars2g398Wr17A3y8GFy2
 kFnIvr9F9F1qvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
 04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
 026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
 Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
 vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
 14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
 9x07beAp5UUUUU=
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/
Received-SPF: pass client-ip=206.189.21.223;
 envelope-from=duchao@eswincomputing.com;
 helo=zg8tmja2lje4os4yms4ymjma.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series implements QEMU KVM Guest Debug on RISC-V, with which we
could debug RISC-V KVM guest from the host side, using software
breakpoints.

This series is based on riscv-to-apply.next branch and is also
available at:
https://github.com/Du-Chao/alistair23-qemu/tree/riscv-to-apply.next.0606

The corresponding KVM side patches have been merged already:
https://lore.kernel.org/kvm/20240402062628.5425-1-duchao@eswincomputing.com/

A TODO list which will be added later:
1. HW breakpoints support
2. A 'corner case' in which the debug exception is not inserted by the
debugger, need to be re-injected to the guest.

v3,v4:
- rebased.

v2->v2 resend:
- add the type conversion in patch #1 to avoid warnings

v1->v2:
- squash patch #2 into #1
- check the instruction length from the tail two bits, instead of passing the
  length information by parameters.

RFC->v1:
- Rebased on riscv-to-apply.next
- use configs/ definition to conditionalize debug support

v2 link:
https://lore.kernel.org/qemu-riscv/20240528080759.26439-1-duchao@eswincomputing.com/
v1 link:
https://lore.kernel.org/qemu-riscv/20240527021916.12953-1-duchao@eswincomputing.com/
RFC link:
https://lore.kernel.org/qemu-riscv/20231221094923.7349-1-duchao@eswincomputing.com/

Chao Du (3):
  target/riscv/kvm: add software breakpoints support
  target/riscv/kvm: handle the exit with debug reason
  target/riscv/kvm: define TARGET_KVM_HAVE_GUEST_DEBUG

 configs/targets/riscv64-softmmu.mak |  1 +
 target/riscv/kvm/kvm-cpu.c          | 89 +++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

--
2.17.1


