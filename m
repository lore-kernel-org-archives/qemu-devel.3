Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F122BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHoc-00010d-Im; Wed, 27 Aug 2025 11:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkl-00006K-0j; Wed, 27 Aug 2025 11:08:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHki-0005gO-Fd; Wed, 27 Aug 2025 11:07:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C50B314C559;
 Wed, 27 Aug 2025 18:02:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B1BC7269860;
 Wed, 27 Aug 2025 18:03:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, WANG Rui <wangrui@loongson.cn>,
 Zhou Qiankang <wszqkzqk@qq.com>, Song Gao <gaosong@loongson.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 48/59] target/loongarch: Fix [X]VLDI raising exception
 incorrectly
Date: Wed, 27 Aug 2025 18:02:53 +0300
Message-ID: <20250827150323.2694101-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
(cherry picked from commit e66644c48e96e81848c6aa94b185f59fc212d080)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.2


