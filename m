Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067BCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtCE-0002Ee-Un; Tue, 09 Jun 2026 05:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtCD-00029W-90
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:56:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtCA-0005f4-5L
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:56:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxZnju4idqiTUSAA--.23844S3;
 Tue, 09 Jun 2026 17:54:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S13;
 Tue, 09 Jun 2026 17:54:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 11/14] target/loongarch: Add default CSRFL_BASIC info with
 flags field
Date: Tue,  9 Jun 2026 17:28:21 +0800
Message-Id: <20260609092824.227250-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S13
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bibo Mao <maobibo@loongson.cn>

With CSR array structure, its validity is checked from offset field.
Now default CSRFL_BASIC information is added with flags field and its
validility can be checked with flags field.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605083854.175625-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/csr.c | 6 +++---
 target/loongarch/csr.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index fff2312f87..d759be316b 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -17,11 +17,11 @@
     [LOONGARCH_CSR_##NAME(N)] = {                             \
         .name   = (stringify(NAME##N)),                       \
         .offset = offsetof(CPULoongArchState, CSR_##NAME[N]), \
-        .flags = 0, .readfn = NULL, .writefn = NULL           \
+        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
     }
 
 #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
-#define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, 0)
+#define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
 
 static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
@@ -144,7 +144,7 @@ CSRInfo *get_csr(unsigned int csr_num)
     }
 
     csr = &csr_info[csr_num];
-    if (csr->offset == 0) {
+    if (csr->flags == 0) {
         return NULL;
     }
 
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 81a656baae..508a3214fc 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -14,6 +14,7 @@ enum {
     CSRFL_EXITTB   = (1 << 1),
     CSRFL_IO       = (1 << 2),
     CSRFL_UNUSED   = (1 << 3),
+    CSRFL_BASIC    = (1 << 4),
 };
 
 typedef struct {
-- 
2.54.0


