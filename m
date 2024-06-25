Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70D7C30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7hU-0007Vw-Vg; Tue, 25 Jun 2024 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sM7hR-0007Uv-Qm; Tue, 25 Jun 2024 11:03:13 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sM7hP-0005RO-PN; Tue, 25 Jun 2024 11:03:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com E9183C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1719327786;
 bh=F5K14Dgm7czKoHpqiITeyoTA7+fEe18XDLC4sSFwo8I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=EyRd2yOTLLTtYADLN2V+sJVvQWAoBC+AbF1KaV350Abb+7nQhNiVBNUr+fgEHxdUl
 SU07b5aK4cSSFcE44SooEfN1SOcLpMvpHMTKLnckpvCH9vIvF6nfR4kVFP65PTCVlY
 4YY6rylm/az+zD1OhoaiChAvNyiHP54KFYtfGaosHTqbujB5co+znfOUZ70yqwuIyw
 Z8HeE+4p+X2Z5WFWnNjkeb0oshNbonrmPcTf7el8gRg2vnlIV/J9HPkFWokhMRH1aH
 41F2aeb05g3g+CQ4FBnXd9J7X2mfy23GG+EYniCo51Pg2MWmOOgD28K/KmDYHv1/3L
 tigbHT/XGcqPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1719327786;
 bh=F5K14Dgm7czKoHpqiITeyoTA7+fEe18XDLC4sSFwo8I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=JTZKDob6gbIBoashckprM8OlRkmuhNkOO3W2wGvrYR6GDzS3GZIgiHdTlW7JQusi0
 3bYmEUjaaND2Ch2Fw//06HLgGJjEoBwUlJfzJTHwJvq3WYXbG8pimzMM0dX3RJEaWd
 KpPTdH9HwEaKvheckAaYJBC5Hdo2TJkykrOxbYCUwIYPkgjCdgaGkuT9cOVMoj7TKk
 h1h/3pX1ghQurdWyqyOouRE1+WIw3PG5lyKmgI9QXKMUjXfjqSrQ46Bl3jWBG9rKhE
 vgfGDI99R9FHVBmetn2IG5/NfThil6PkBOLKRXlLhl8+pasRqueKG6boAThWoIV/vM
 QQZnmEqIPVQoQ==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <ajones@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <alistair23@gmail.com>, <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v8] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific SBI
Date: Tue, 25 Jun 2024 18:02:54 +0300
Message-ID: <20240625150254.38790-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527-3510206a25da720148c06a43@orel>
References: <20240527-3510206a25da720148c06a43@orel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
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
qemu_chr_fe_read_all() may not return sizeof(ch), because exactly zero
just means we failed to read input, which can happen, so
telling the SBI caller we failed to read, but telling the caller of this
function that we successfully emulated the SBI call, is correct. However,
anything else, other than sizeof(ch), means something unexpected happened,
so we should return an error.

Added SBI related return code's defines.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
---
Changes since v7:
		- Fix error handling according to Andrew Jones suggestion.
 target/riscv/kvm/kvm-cpu.c         |  9 +++++----
 target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 235e2cdaca..1afbabe19f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1515,19 +1515,20 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
+        } else if (ret == 0) {
+            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
         } else {
-            run->riscv_sbi.ret[0] = -1;
+            ret = -1;
         }
-        ret = 0;
         break;
     case SBI_EXT_DBCN:
         kvm_riscv_handle_sbi_dbcn(cs, run);
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
+                      "%s: Unhandled SBI exit with extension-id %lu\n",
                       __func__, run->riscv_sbi.extension_id);
-        ret = -1;
+        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
         break;
     }
     return ret;
diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
index 7dfe5f72c6..4df0accd78 100644
--- a/target/riscv/sbi_ecall_interface.h
+++ b/target/riscv/sbi_ecall_interface.h
@@ -86,4 +86,16 @@
 #define SBI_EXT_VENDOR_END              0x09FFFFFF
 /* clang-format on */
 
+/* SBI return error codes */
+#define SBI_SUCCESS                  0
+#define SBI_ERR_FAILURE             -1
+#define SBI_ERR_NOT_SUPPORTED       -2
+#define SBI_ERR_INVALID_PARAM       -3
+#define SBI_ERR_DENIED              -4
+#define SBI_ERR_INVALID_ADDRESS     -5
+#define SBI_ERR_ALREADY_AVAILABLE   -6
+#define SBI_ERR_ALREADY_STARTED     -7
+#define SBI_ERR_ALREADY_STOPPED     -8
+#define SBI_ERR_NO_SHMEM            -9
+
 #endif
-- 
2.34.1


