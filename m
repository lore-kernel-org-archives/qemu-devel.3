Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2951C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc20N-0001Pj-Bs; Wed, 16 Jul 2025 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1ubwsU-0008UQ-8w
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:48:34 -0400
Received: from sg-1-39.ptr.blmpb.com ([118.26.132.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1ubwsM-00044T-E5
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1752652083;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=U5ICjmmFh2LQm39YKHRoRRqmKT3VyQukSkY/TuMa9z8=;
 b=Ru5lITW0DJyz0DIdH/UXxuWs2UpXpOcBz03ws2eo0KT2gc9UORJjfDIqpTmOP9gTDqCBWP
 b2qBdd7tPVmfP1sUnfC0WoXUTFxHcibCE2INhuEgZ9GjiZGOkAJ0rcPxuvyosbhMwEpOpl
 F4nyGHgBwN9IOi08R8pe93huxpQtLa7EHRjuERYFXO1xoojWVoUh15vKUv7/eBRJKrOGTZ
 Dn7aQ8NbA89fJRYrIxIo1sV/4RYCau6FlFggH/7+S8ywXZwMcO5VDsNzLqzKl0rq5OYUzT
 2uoxCZ2oB+dXKPauGid229TptsCm9HSnrYk7tTje0cSQpTvEgb3rkKjdszKTDQ==
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Subject: [PATCH] target/riscv/kvm: Introduce simple handler for VS-file
 allocation failure
Received: from localhost.localdomain ([222.128.9.250]) by smtp.feishu.cn with
 ESMTP; Wed, 16 Jul 2025 15:48:00 +0800
Date: Wed, 16 Jul 2025 15:47:37 +0800
Message-Id: <20250716074738.1075-1-xiangwencheng@lanxincomputing.com>
Mime-Version: 1.0
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
To: <palmer@dabbelt.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.46.2.windows.1
Cc: <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>, 
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, 
 "BillXiang" <xiangwencheng@lanxincomputing.com>
X-Lms-Return-Path: <lba+268775931+3e4abb+nongnu.org+xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.39;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=sg-1-39.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:11:16 -0400
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

Consider a system with 8 harts, where each hart supports 5
Guest Interrupt Files (GIFs), yielding 40 total GIFs.
If we launch a QEMU guest with over 5 vCPUs using
"-M virt,aia=3D'aplic-imsic' -accel kvm,riscv-aia=3Dhwaccel" =E2=80=93 whic=
h
relies solely on VS-files (not SW-files) for higher performance =E2=80=93 t=
he
guest requires more than 5 GIFs. However, the current Linux scheduler
lacks GIF awareness, potentially scheduling >5 vCPUs to a single hart.
This triggers VS-file allocation failure, and since no handler exists
for this error, the QEMU guest becomes corrupted.

To address this, we introduce this simple handler by rescheduling vCPU
to alternative harts when VS-file allocation fails on the current hart.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 target/riscv/kvm/kvm-cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5c19062c19..7cf258604f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1706,6 +1706,9 @@ static bool kvm_riscv_handle_debug(CPUState *cs)
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret =3D 0;
+    uint64_t code;
+    cpu_set_t set;
+    long cpus;
     switch (run->exit_reason) {
     case KVM_EXIT_RISCV_SBI:
         ret =3D kvm_riscv_handle_sbi(cs, run);
@@ -1718,6 +1721,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_ru=
n *run)
             ret =3D EXCP_DEBUG;
         }
         break;
+    case KVM_EXIT_FAIL_ENTRY:
+        code =3D run->fail_entry.hardware_entry_failure_reason;
+        if (code =3D=3D CSR_HSTATUS) {
+            // Schedule vcpu to next hart upon VS-file=20
+            // allocation failure on current hart.
+            cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
+            CPU_ZERO(&set);
+            CPU_SET((run->fail_entry.cpu+1)%cpus, &set);
+            ret =3D sched_setaffinity(0, sizeof(set), &set);
+            break;
+        }
+        /* FALLTHRU */
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
--=20
2.46.2.windows.1

