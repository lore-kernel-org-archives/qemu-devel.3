Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 11:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rys4t-0007s1-R6; Mon, 22 Apr 2024 07:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rys4m-0007pG-AL; Mon, 22 Apr 2024 07:43:12 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rys4j-0002L4-71; Mon, 22 Apr 2024 07:43:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 76BA5C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1713786182;
 bh=Q40epgFZ5hpHV0dXwsp4bnWiaCWRWE7EM7mU0Mw6Vsg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=wsd3dze/i/W4yBOFsrtPhqLKpULSt6N6RRjnGA7XzWebfyvG439ExNpxFI8NN7mQF
 21YtgCeHyWEx9cHT4UmqSzWwqneH4wnxQVlwPmR1m+k+aYdGrJ0e1MGDoNeJcdC81k
 zrv/Aen1lVxRTQMVu4dr5uYRm3TA82EVsCio7r1V6jKr4yS9aI7O0AsjFua9yvgmSi
 +dMnumSxvzS0xLpVO211TYwdOh9b7lK2+3WUa7hgBzllHG9x9Yb94+BbNKf7LcaBUM
 TCwsG1is+n+kWw2iabi+WViK74kGvLEqpEwqlc1efgidkt+6SC8Xf3/ONHVteqpLX0
 CW7IdDXZFr/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1713786182;
 bh=Q40epgFZ5hpHV0dXwsp4bnWiaCWRWE7EM7mU0Mw6Vsg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=C3pdr98KNssZIVnzBvCEeMycXqhhEHGMd9maHX9/ctuOQWbkuT6/NNgop30CwVAyg
 rsuBW/8eYA5hr9zIZzwdYk4KZDLu8w06ULhue+L1iXlt+qd93xHDCqasRCSTXcfdyp
 r3oYXE8SHhn8J2DbaGEcaZzidFs5W9q7HXuCVuTHW3rOnrTAwnbNhPuba9Ia6boCuW
 xLxI9f/VfuvRpS1JIt5Obqu+gOrORH4PWGniBeZt4cdsn0i2amL77ooTf2cL0Iar8H
 v3BJb+zqeqCCTvQxk6PhWWxiQ2JfKU17rdFmOEL81PYaGXSrAvesa/iCLGNycs/gMV
 fuWY7dQAgGZHg==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <ajones@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <alistair23@gmail.com>, <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v6] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific SBI
Date: Mon, 22 Apr 2024 14:42:54 +0300
Message-ID: <20240422114254.13839-1-alexei.filippov@syntacore.com>
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
Changes since v4-5:
		-Added new error path in case of qemu_chr_fe_read_all() may not
		return sizeof(ch).
		-Added more comments in commit message.
 target/riscv/kvm/kvm-cpu.c         | 10 ++++++----
 target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f9dbc18a76..5bb7b74d03 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1173,16 +1173,18 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
+            ret = 0;
+        } else if (ret == 0) {
+            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
         } else {
-            run->riscv_sbi.ret[0] = -1;
+            ret = -1;
         }
-        ret = 0;
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
+                      "%s: Unhandled SBI exit with extension-id %lu\n"
                       __func__, run->riscv_sbi.extension_id);
-        ret = -1;
+        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
         break;
     }
     return ret;
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


