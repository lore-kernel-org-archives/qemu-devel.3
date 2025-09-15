Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4361CCA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 07:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy3Km-0005fz-9w; Mon, 15 Sep 2025 03:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xb@ultrarisc.com>)
 id 1uy3Kg-0005eN-Bv; Mon, 15 Sep 2025 03:09:03 -0400
Received: from [218.76.62.146] (helo=ultrarisc.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xb@ultrarisc.com>)
 id 1uy3KT-0007Lb-Kj; Mon, 15 Sep 2025 03:09:02 -0400
Received: from ur-dp1000.. (unknown [192.168.100.1])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAfwCXwdChu8do+wkuAA--.45058S2; 
 Mon, 15 Sep 2025 15:09:34 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, qemu-riscv@nongnu.org, alistair23@gmail.com,
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com,
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com,
 Xie Bo <xb@ultrarisc.com>
Subject: =?UTF-8?q?=5BPATCH=20v9=200/2=5D=20target/riscv=EF=BC=9AFix=20riscv64=20kvm=20migration?=
Date: Mon, 15 Sep 2025 15:08:06 +0800
Message-ID: <20250915070811.3422578-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXwdChu8do+wkuAA--.45058S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF15Ar1xtrWUCr48GFWUCFg_yoW3trb_GF
 WIvFW7J39rXayv9FZ8tF4rA3sYkay8Cryjya18Ar4Yy347Wr45Ja1vqF18Xw1jvF4UJ3Wk
 Jry7tryxCr1UWjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbgkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
 1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
 x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
 CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAC
 I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82
 IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
 xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
 1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
 6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
 AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
 vjTR_L0eDUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAGB2jHbnEADwAPsw
X-Host-Lookup-Failed: Reverse DNS lookup failed for 218.76.62.146 (failed)
Received-SPF: pass client-ip=218.76.62.146; envelope-from=xb@ultrarisc.com;
 helo=ultrarisc.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This is v9 of the series. Compared to v8, the patches are now based on
the 'riscv-to-apply.next' branch from Alistair's repository:

https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Changes since v8:
- Rebased the series onto [alistair/riscv-to-apply.next]
- Removed the previous 'Reviewed-by' tags due to the rebase
  * The changes are purely mechanical; no code logic was altered *
- Added 'Cc: qemu-stable@nongnu.org'

Xie Bo (2):
  Set KVM initial privilege mode and mp_state
  Fix VM resume after QEMU+KVM migration

 target/riscv/cpu.c           | 17 +++++++++-
 target/riscv/cpu.h           |  2 ++
 target/riscv/kvm/kvm-cpu.c   | 60 ++++++++++++++++++++++++++++--------
 target/riscv/kvm/kvm_riscv.h |  3 +-
 target/riscv/machine.c       |  5 +--
 5 files changed, 70 insertions(+), 17 deletions(-)

-- 
2.43.0


