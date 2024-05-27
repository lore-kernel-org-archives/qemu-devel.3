Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A40BC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 13:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBaiB-0004XV-J2; Mon, 27 May 2024 09:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sBai9-0004V8-5h; Mon, 27 May 2024 09:48:25 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sBai7-0001pj-7s; Mon, 27 May 2024 09:48:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 764C2C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1716817698;
 bh=lalzhHjkbamM4OCsreBFCTmyuWBZzQdSrCFnUTmsOKE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=C7jjSEL3pjnDJfOXpZy9hNt65Sq/eJ8Vy7/Mur9OKFBckfmyU0CVFWrbcnfRqmFX6
 NOgX4IaOabKsOXiHxWtYETbHBU8nDtocLgjntGwI5lNOeXNO//XQtz3BvrmY72zkvX
 Am6P8ki7MR4EcM/rSIiZrlKePpct2oUMlc9WPUn/WmxhXGnorMBRCk2Uga8kF9NXcK
 gcY7E6UXbFRnwtGpPgkoUsvBoMHZIp4MKdQFkta8jWvAHfnvxTEClF+DOR+ujJpoY3
 AzFeOq756MdSR0EfU+osIcOcEWDemSfr21sk0A8HihiIKZFb36xCIzU+CcG6D6HVfp
 zZpUHcW210ulw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1716817698;
 bh=lalzhHjkbamM4OCsreBFCTmyuWBZzQdSrCFnUTmsOKE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=wwOBUsyqTUxtqtInVFkIjwEGp4zcJFEA47J0tpo/MMotfWIFF396cWvanHEvYIn9J
 CkdZifjTvhSJQKIQUqEfMLp+VusZA77/bTPk9WmdyclZntE5315md5EaLAUQ0Afq6L
 1k8vck9BtAkaea7HTjsvyw9yhDf1vRMUrK0SXzx4La0+fAtobhaxhDlBCBZ5eaglbt
 43XsjyTQHkuzH6c83zjqVcC758PN7MlJjPskdgBGo1rXWopg1XBmjfHjBB/5jzhDNj
 hNH7vTY2c/VV6dd52rjcUChuJeaf4Sw7K8OnH5biLTiSC1Rk8dYjGg1yGtDlik4rcs
 8iwUAoT7aQ2gw==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <ajones@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <alistair23@gmail.com>, <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail
 with vendor-specific SBI
Date: Mon, 27 May 2024 16:48:11 +0300
Message-ID: <20240527134811.342027-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503-1417868a079951810dadb71c@orel>
References: <20240503-1417868a079951810dadb71c@orel>
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
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Changes since v6:
		- Add appropriate commit message.
		- Fix error handling according to Andrew Jones suggestion.
 target/riscv/kvm/kvm-cpu.c         | 11 +++++++----
 target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f9dbc18a76..a84bcda9d9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1173,16 +1173,19 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
+            ret = 0;
         } else {
-            run->riscv_sbi.ret[0] = -1;
+            if (ret == 0) {
+                run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
+            }
+            ret = -1;
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


