Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED131C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 01:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukC18-0005kQ-Ld; Thu, 07 Aug 2025 21:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ukC0x-0005Uh-8p; Thu, 07 Aug 2025 21:35:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1ukC0u-0006JZ-6b; Thu, 07 Aug 2025 21:35:22 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxlmlSVJVokYM7AQ--.49763S3;
 Fri, 08 Aug 2025 09:35:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxT+ZHVJVosPY7AA--.25968S3;
 Fri, 08 Aug 2025 09:35:14 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, qemu-stable@nongnu.org, WANG Rui <wangrui@loongson.cn>,
 Zhou Qiankang <wszqkzqk@qq.com>
Subject: [PULL 1/1] target/loongarch: Fix [X]VLDI raising exception incorrectly
Date: Fri,  8 Aug 2025 09:11:57 +0800
Message-Id: <20250808011157.375125-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250808011157.375125-1-gaosong@loongson.cn>
References: <20250808011157.375125-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+ZHVJVosPY7AA--.25968S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: WANG Rui <wangrui@loongson.cn>

According to the specification, [X]VLDI should trigger an invalid instruction
exception only when Bit[12] is 1 and Bit[11:8] > 12. This patch fixes an issue
where an exception was incorrectly raised even when Bit[12] was 0.

Test case:

```
    .global main
main:
    vldi    $vr0, 3328
    ret
```

Reported-by: Zhou Qiankang <wszqkzqk@qq.com>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250804132212.4816-1-wangrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 78730029cb..38bccf2838 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -3585,7 +3585,9 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
     int sel, vece;
     uint64_t value;
 
-    if (!check_valid_vldi_mode(a)) {
+    sel = (a->imm >> 12) & 0x1;
+
+    if (sel && !check_valid_vldi_mode(a)) {
         generate_exception(ctx, EXCCODE_INE);
         return true;
     }
@@ -3594,8 +3596,6 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
         return true;
     }
 
-    sel = (a->imm >> 12) & 0x1;
-
     if (sel) {
         value = vldi_get_value(ctx, a->imm);
         vece = MO_64;
-- 
2.47.0


