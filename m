Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B62C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBrwz-0000oa-Jq; Tue, 28 May 2024 04:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1sBrwp-0000nj-Qg; Tue, 28 May 2024 04:12:45 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>)
 id 1sBrwn-0000HF-Ev; Tue, 28 May 2024 04:12:43 -0400
Received: from localhost.localdomain (unknown [10.12.130.31])
 by app2 (Coremail) with SMTP id TQJkCgAnObtlkVVmsDYNAA--.12486S4;
 Tue, 28 May 2024 16:10:14 +0800 (CST)
From: Chao Du <duchao@eswincomputing.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 ajones@ventanamicro.com, alistair23@gmail.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, anup@brainfault.org,
 duchao713@qq.com
Subject: [PATCH RESEND v2 0/3] target/riscv/kvm: QEMU support for KVM Guest
 Debug on RISC-V
Date: Tue, 28 May 2024 08:07:56 +0000
Message-Id: <20240528080759.26439-1-duchao@eswincomputing.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: TQJkCgAnObtlkVVmsDYNAA--.12486S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xZryDZr1UKr1xtw18Zrb_yoW8XFW3pa
 1F9F98CrZIqrZ3G3ySy3Z7Gr15Zws5Cr1UZw1xZw4Fgr45Zay8Arn2g398WrnrA3y8GFy2
 kFnIvr9I9F1qvrJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv
 0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z2
 80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
 6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeT5dUUUUU=
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/
Received-SPF: pass client-ip=162.243.161.220;
 envelope-from=duchao@eswincomputing.com;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_BL=0.001,
 RCVD_IN_MSPIKE_L5=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series is based on riscv-to-apply.next branch (v9.0.0) and is also
available at:
https://github.com/Du-Chao/alistair23-qemu/tree/riscv-to-apply.next.0528

The corresponding KVM side patches have been merged already:
https://lore.kernel.org/kvm/20240402062628.5425-1-duchao@eswincomputing.com/

A TODO list which will be added later:
1. HW breakpoints support
2. A 'corner case' in which the debug exception is not inserted by the
debugger, need to be re-injected to the guest.

v2->v2 resend:
- add the type conversion in patch #1 to avoid warnings

v1->v2:
- squash patch #2 into #1
- check the instruction length from the tail two bits, instead of passing the
  length information by parameters.

RFC->v1:
- Rebased on riscv-to-apply.next
- use configs/ definition to conditionalize debug support

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


