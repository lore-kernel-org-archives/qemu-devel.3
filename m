Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D23C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokeI-0006MT-0A; Mon, 25 Mar 2024 09:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rohLq-0004AH-2H; Mon, 25 Mar 2024 06:14:46 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rohLo-0004SQ-8q; Mon, 25 Mar 2024 06:14:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com BAF2BC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711361677;
 bh=4/F9Iz/B58YpptQ/lFLdFrpCKHH/DNX8vucZgaupHkc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ag0Mv54YoZjjPMSWm23mKxJ1o5UWtOGOVREu/0JUagnByHC5hpDocOghfYflr3CdR
 OXLRxYlujhXV89OAVkX84yz4RwwBDjk442NvSSR6w2wPdIeK05NcZBMNEVHWKubSkv
 ajNBBcNQNuc/TVWYUOOzTZilhv9dHD1jIs8I8RVNEBwK08AAECHnUWJa8NugNJtAMu
 8ylHws0g90CsyN5RIF3429Wq3qTC3XtysSuY6FqTGs/XERzGG0uy/sLX3QlRzRmfq1
 H8LiI1AyuCu0GTJIiIHhuRftk8YMnl1gWtezM8wAv9sL3r0rsHL0GX8zqSf1CY9aSF
 KUStVtreXlEDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711361677;
 bh=4/F9Iz/B58YpptQ/lFLdFrpCKHH/DNX8vucZgaupHkc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=sGP1iAHGrNEdZKJRu/9h2joq7LKaPIimPircM09ojag7+avN7KQ/xtR50bzPy5TO+
 HVhlo1hlozNU7erUpHfyxmP7gFddJoXWoPDePSgu/K4grJJCDRs5sNVBFhs3ES8dR8
 wq/6dNm+cwoittT2TZ9F37Vw9dVV8GSHTwVqswDlT8iM1oXiCANrqAzd0ogOEC5sfF
 TadFyzRV3jFwBLms+DhEgoeEhRtRsdAHpSGM6fiehFYI9uuPp5wAamYBfryMJWbY1Y
 JXZqej2pgHkXGhGLeeO50rHkh03/9WG9fymNSjbuDb3iX6+NCsuoGSKUSXhb1dKL4l
 BKJga1GhQzcfw==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>
CC: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Alexei Filippov
 <alexei.filippov@syntacore.com>
Subject: [PATCH] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi() fail with
 vendor-specific SBI
Date: Mon, 25 Mar 2024 13:14:28 +0300
Message-ID: <20240325101428.8875-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 Mar 2024 09:45:59 -0400
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
---
 target/riscv/kvm/kvm-cpu.c         |  5 +++--
 target/riscv/sbi_ecall_interface.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80..a4f84ad950 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1404,7 +1404,7 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
         } else {
-            run->riscv_sbi.ret[0] = -1;
+            run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
         }
         ret = 0;
         break;
@@ -1412,7 +1412,8 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         qemu_log_mask(LOG_UNIMP,
                       "%s: un-handled SBI EXIT, specific reasons is %lu\n",
                       __func__, run->riscv_sbi.extension_id);
-        ret = -1;
+        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
+        ret = 0;
         break;
     }
     return ret;
diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
index 43899d08f6..0279e92a36 100644
--- a/target/riscv/sbi_ecall_interface.h
+++ b/target/riscv/sbi_ecall_interface.h
@@ -69,4 +69,15 @@
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
+
 #endif
-- 
2.34.1


