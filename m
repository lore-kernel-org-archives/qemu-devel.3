Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA2C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 11:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvbWA-0006eq-J4; Sat, 13 Apr 2024 07:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvbW8-0006e8-Lk; Sat, 13 Apr 2024 07:25:56 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvbW6-0008TS-Br; Sat, 13 Apr 2024 07:25:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com D7EFEC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1713007549;
 bh=gdGwFR7E2dP6kVQgP8tYvVboB0w7+yvC8SaHxMhztqY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fDkoKwmlzVHrKI/BYgwAD4q5xTkYop2Iq/gE4XuGmax6AGWx5DyKqPW1E8mK/sf0z
 p/YN2l9W3/+ED3eOE9OFMQplCgG8txF4IRJxLSm+50sdjo9CUvxXvd2ydcdyZC8vE+
 O9CqgB1aPYIFJ4XpZ2OKNsrVkrD7eIqMfdMZbgbpHOHXjNCwSXrcq1yoP9tERc1v//
 fZUqglChtmzbyXIh8oNQR9oaiONJxZsneoc+LDoH6NbnYcdxdgjuwPZp2TbhTvSiuc
 IfDoOUuOvaLhjwvygWL6PiAJ+d05AqOfT38I7F1IZU3oY5lwqtk5BHbM9kgsyh4Ah3
 iNkPihHHmwYSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1713007549;
 bh=gdGwFR7E2dP6kVQgP8tYvVboB0w7+yvC8SaHxMhztqY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=g0qc+ZJWqEiOxH3kM6FkO4JyHsutoqL5rkpZtm8IpGNjxsfb1V5YIKz7/Rg6A05bA
 GZ5gC1o9Wfv2r0oVmGFjSkgo7uj2o1eX4hYovZA9h7DOE3acJW0OT+otMtVFGkL/NI
 +RKhog7K0+yEg00oSSiDnUoEOGV/r2fLmsk9LjEIUsviVHGaNBimg5TCW5/DewIJDi
 t9NQkpvcfCgbDpaTJ7KEw26Zdq50YiT8loz1gZaakthAGmfWr0LTKKzv5rR7vpqjGt
 GwQ6c1TbmmmKI2xR88itTMvzGhI8/y/dBKgEFyto0I3eg5VqQ33JcHNFTemgYEYSqF
 m0OXEQIcPyHjA==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <ajones@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v4] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific SBI
Date: Sat, 13 Apr 2024 14:25:26 +0300
Message-ID: <20240413112526.8748-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326-672b9d2fa4066ec883a9f037@orel>
References: <20240326-672b9d2fa4066ec883a9f037@orel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
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

kvm_riscv_handle_sbi() may return not supported return code to not trigger
qemu abort with vendor-specific sbi.

Added SBI related return code's defines.

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
---

Changes since v3:
        -Clear Reviewed-by tags
 target/riscv/kvm/kvm-cpu.c         | 13 +++++--------
 target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80..844942d9ba 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1392,7 +1392,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 
 static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
 {
-    int ret = 0;
     unsigned char ch;
     switch (run->riscv_sbi.extension_id) {
     case SBI_EXT_0_1_CONSOLE_PUTCHAR:
@@ -1400,22 +1399,20 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
         break;
     case SBI_EXT_0_1_CONSOLE_GETCHAR:
-        ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
-        if (ret == sizeof(ch)) {
+        if (qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch)) == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
         } else {
-            run->riscv_sbi.ret[0] = -1;
+            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
         }
-        ret = 0;
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
-    return ret;
+    return 0;
 }
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
index 43899d08f6..a2e21d9b8c 100644
--- a/target/riscv/sbi_ecall_interface.h
+++ b/target/riscv/sbi_ecall_interface.h
@@ -69,4 +69,16 @@
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


