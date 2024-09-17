Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53039C36015
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 11:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqWnH-00078m-VC; Tue, 17 Sep 2024 07:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sqWnG-00077J-Jn; Tue, 17 Sep 2024 07:54:54 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sqWnD-0003BS-At; Tue, 17 Sep 2024 07:54:54 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com D07C5C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726574080;
 bh=0b+6vJn1T0D5RZfp8GAXyY+hCJJIU3UK4EfWpiPrbFA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=jBL8iHH6VstOOej18g7r+F/v44Qv9gfcmvv7ld2O5RzwqqNiXe9FWAZJv2S9j1/l/
 OD9nzBxtSY+Gqyqj17s2gfqJpL/jcuGUlI+7eW0BTznX6JerVL3Zp9TvkF4+MqwBlW
 5vR/j4XjfpR21QezxwoqX/gzpwcALc181+4f1+QASJVecQ0obpvgd39qeamzNCoEkA
 cjQNJ4S/vThUOhjhK6BG7cNyyBndTr/cn7dk6MwsG5KOVMEHnioXxCbT3ZOFclirst
 Ab5DhBMjwjM+ZFuO3Royjo+X3NoxGEXjdcB48VS57V6VJDUsHhXEnlTX2gWknjLQdm
 WVgQJStuAj4Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726574080;
 bh=0b+6vJn1T0D5RZfp8GAXyY+hCJJIU3UK4EfWpiPrbFA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=t2uJsMR0G1AgTUOTuc0ZCjh4cTlOUWONyrGLUyLMnv1fMDYdc52FqstUV4s2DfULa
 uootGu9j+KmF06DUG5mmShzwfBpZgNh6hIyOt/z/ley9Is/a2fW0cyXxTzgIv4sxJv
 ThbBMNyz82/PTCmQmOFTQmBuU3Cp44YFhnFvMxhOA5ItCeqT2407FhfRfeAYl40W4a
 TICzjApiOHu2jeSITtfnD8+VaorBwLL0QnSJJMHXEW+oigBetd0dISJjsW9stembCV
 S5y+MWA+Msw1tFvdFZdAE+TcDmWvpfpQBZ/b+CUbUFpm4W/8xuhZvUX+H/1hJGPDMU
 /D4pLUGO5/aAA==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <ajones@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <alistair23@gmail.com>, <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v9] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific SBI
Date: Tue, 17 Sep 2024 14:54:33 +0300
Message-ID: <20240917115433.38503-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626-1420003b7d88d892be22a719@orel>
References: <20240626-1420003b7d88d892be22a719@orel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
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
 target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
 target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f6e3156b8d..9f2ca67c9f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1517,19 +1517,21 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
-        } else {
+            ret = 0;
+        } else if (ret == 0) {
             run->riscv_sbi.ret[0] = -1;
+        } else {
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


