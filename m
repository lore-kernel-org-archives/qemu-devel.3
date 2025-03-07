Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7ECC282EC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 01:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqMHd-0001d9-9z; Thu, 06 Mar 2025 20:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tqMHc-0001cv-Co
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 20:13:48 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tqMHa-0000FO-Dq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 20:13:48 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxOGpFSMpnF+6MAA--.45174S3;
 Fri, 07 Mar 2025 09:13:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx_cZDSMpnSpI6AA--.23154S2;
 Fri, 07 Mar 2025 09:13:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util/loongarch64: Add clang compiler support
Date: Fri,  7 Mar 2025 09:13:39 +0800
Message-Id: <20250307011339.2246600-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZDSMpnSpI6AA--.23154S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Float register name f0 - f31 is not recognized with clang compiler
with LoongArch64 target, its name should be $f0 - $f31. It is ok
for both gcc and clang compiler.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 host/include/loongarch64/host/bufferiszero.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
index 69891eac80..bb2598fdc3 100644
--- a/host/include/loongarch64/host/bufferiszero.c.inc
+++ b/host/include/loongarch64/host/bufferiszero.c.inc
@@ -61,7 +61,8 @@ static bool buffer_is_zero_lsx(const void *buf, size_t len)
     "2:"
         : "=&r"(ret), "+r"(p)
         : "r"(buf), "r"(e), "r"(l)
-        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
+        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
+          "$fcc0");
 
     return ret;
 }
@@ -119,7 +120,8 @@ static bool buffer_is_zero_lasx(const void *buf, size_t len)
     "3:"
         : "=&r"(ret), "+r"(p)
         : "r"(buf), "r"(e), "r"(l)
-        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
+        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
+          "$fcc0");
 
     return ret;
 }

base-commit: 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56
-- 
2.39.3


