Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD18C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 11:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryrn4-0003DR-AJ; Mon, 22 Apr 2024 07:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1ryrn2-000381-QE; Mon, 22 Apr 2024 07:24:52 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1ryrn0-0007L1-SE; Mon, 22 Apr 2024 07:24:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 62DEBC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1713785085;
 bh=knZaCxNyHEEDulzJLlcCVQiRkDfhoJ7zcpyDgfjmZUY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ph68UmMhzQPy2w5I92igEJKabBPHJkLR3GcxJhsvzjU8hTsmBZ3O/oK6jem5CCs/O
 I8zpsFkOq/zuDw+mvYYjeX3wKd4k3D7oAz0prCFQLDJtgEvr3+BlNcaVSCVhaCiHzf
 4q1WYNv/3SfBbiN5csrI20tMplMFWPTjE6MZ3Eoxuhhn2Oq0V9DMjnKheHeNI4O3AM
 l8eOlIa9I1588HFPHUFeGIblLBN4ghHOYzwhLSWCg8PfKSBx7ENgApRQgCzOausocN
 S19wuX6VLJ63Y0vskVXGm50IPKtvqnHDanzRs2zYZpa+75xn+y8g7cDbMlgPb6y3qi
 K8q4KjHa1KyfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1713785085;
 bh=knZaCxNyHEEDulzJLlcCVQiRkDfhoJ7zcpyDgfjmZUY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=IFI0ubrFLL8U4/q4N2M2NrKMeZhmjyL5LRegX71aQB/E0123G430NAE1GN4KmdP7Z
 T2/pupG/XnXFP3UdYYFGGgLrz0JDmhVIfUDS7ji6fdwbjGB/+Cj9vlJ5xwQU8BhWNI
 pau1IJHzLd4VXBAkvGDswDeVUqrr2weFvhaWXkSodlS6DQ7kO2ceuJAREC7m7rM48j
 9s1pcl9x7rEpDhywMzV02mlhB731C+Ecka8ntoZnklNkprT0qTr31AdD6pmxd4uLSd
 YxaMP0S24pdbyGCN6Dn9nT+bq3fhPw1FZ0BHPd31HL1WDumZ7k+I7hCv3gtWUOheVH
 AT/qzejRPGcVg==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <ajones@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <alistair23@gmail.com>, <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v5] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific sbi.
Date: Mon, 22 Apr 2024 14:24:37 +0300
Message-ID: <20240422112437.11079-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422-e78b28f00a168518c5d4937a@orel>
References: <20240422-e78b28f00a168518c5d4937a@orel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SORTED_RECIPS=2.499,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

kvm_riscv_handle_sbi() may return not supported return code to not
trigger qemu abort with vendor-specific sbi.

Add new error path to provide proper error in case of
qemu_chr_fe_read_all() may not return sizeof(ch).

Added SBI related return code's defines.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
---
 target/riscv/kvm/kvm-cpu.c         | 9 +++++----
 target/riscv/sbi_ecall_interface.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index aeca1e3e83..5bb7b74d03 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1173,17 +1173,18 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
-        } else {
+            ret = 0;
+        } else if (ret == 0) {
             run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
+        } else {
+            ret = -1;
         }
-        ret = 0;
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
+                      "%s: Unhandled SBI exit with extension-id %lu\n"
                       __func__, run->riscv_sbi.extension_id);
         run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
-        ret = 0;
         break;
     }
     return ret;
diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
index 0279e92a36..a2e21d9b8c 100644
--- a/target/riscv/sbi_ecall_interface.h
+++ b/target/riscv/sbi_ecall_interface.h
@@ -79,5 +79,6 @@
 #define SBI_ERR_ALREADY_AVAILABLE   -6
 #define SBI_ERR_ALREADY_STARTED     -7
 #define SBI_ERR_ALREADY_STOPPED     -8
+#define SBI_ERR_NO_SHMEM            -9
 
 #endif
-- 
2.34.1


