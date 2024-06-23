Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E79C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 11:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLLqc-0002mL-Po; Sun, 23 Jun 2024 07:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLqb-0002lv-Cd
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 07:57:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLqZ-0003a7-KD
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 07:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6xNfDS9B1uK2w7AYl6ksEAe8y0NO81aBAzoi5J2zag0=; b=Cx4ozLn8SE7sVMzEtIackcsY/L
 6oVS9BdxYEID7c+dMI56dVNXj4GZARlBbAtQOYN/FJd4KMZ0RUglDqVC3rugw6oofCJhSPF3bS807
 p3LqUN4iSzHgU3rKkIp5MtT6n9yEYPZKGyJHk48q0mQ5fPG0kb1eyOI9X03qy9styfW9cuArI9xNc
 +nfNN54a1cpVyfuzT64AjyOv1lAsTnApo2mCIUopJjDC1n9JXscFhkZZTT+mRY+kkbj4XGWrMx9yt
 tfTtEpSTlpPbPFPvkN0wopifqJnJWnsvTGyRcuGR1yOBC9fFKyCd/t+IT+8Up8Py+Eb0193XwNHpJ
 6nlXjLo5ooC7AGe9ZonE03Fa5yzVoUpDAvV5kNhL2Q93OT1fVC8e5XIVJQLiXiy3MtfaXCpHD8PYf
 X1TYm7CibJM8OtVBnLQZ4+353kZ2dENbQLbQk0rRbmFddjAqhijeehEVK6WTn71c6T5xoRn5VB2wf
 zopj7VJxrzDseCkJosAchLXoXeiiOzSaqWU1eVZRgwIZ9I4EQH4dW1VrlDo+WRBkUee/eK5/pGSyF
 obx1IOEv0xUAy8GPDnNgR0IMJKaw1V5CsWJXpxlAqCvWDHTXkQ7DNL2MQ/1eDka3mB2PBjoCoRTKF
 jWNoNvwax3xqj9hRC9IDzZHdk9BIsnDeDqV++KKVk=;
Received: from [2a00:23c4:8bb4:4000:e8db:395:a8c5:fda6]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLpA-00080P-ET; Sun, 23 Jun 2024 12:56:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Sun, 23 Jun 2024 12:57:04 +0100
Message-Id: <20240623115704.315645-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:e8db:395:a8c5:fda6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/2] target/m68k: pass alignment into TCG memory load/store
 routines
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that do_unaligned_access has been implemented for 68k CPUs, pass the required
alignment into the TCG memory load/store routines. This allows the TCG memory core
to generate an Address Error exception for unaligned memory accesses if required.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2165
---
 target/m68k/translate.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 445966fb6a..661a7b4def 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -303,13 +303,18 @@ static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
                             int sign, int index)
 {
     TCGv tmp = tcg_temp_new_i32();
+    MemOp memop = opsize | (sign ? MO_SIGN : 0) | MO_TE;
 
     switch (opsize) {
     case OS_BYTE:
+        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
+        break;
     case OS_WORD:
     case OS_LONG:
-        tcg_gen_qemu_ld_tl(tmp, addr, index,
-                           opsize | (sign ? MO_SIGN : 0) | MO_TE);
+        if (!m68k_feature(s->env, M68K_FEATURE_UNALIGNED_DATA)) {
+            memop |= MO_ALIGN_2;
+        }
+        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
         break;
     default:
         g_assert_not_reached();
@@ -321,11 +326,18 @@ static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
 static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val,
                              int index)
 {
+    MemOp memop = opsize | MO_TE;
+
     switch (opsize) {
     case OS_BYTE:
+        tcg_gen_qemu_st_tl(val, addr, index, memop);
+        break;
     case OS_WORD:
     case OS_LONG:
-        tcg_gen_qemu_st_tl(val, addr, index, opsize | MO_TE);
+        if (!m68k_feature(s->env, M68K_FEATURE_UNALIGNED_DATA)) {
+            memop |= MO_ALIGN_2;
+        }
+        tcg_gen_qemu_st_tl(val, addr, index, memop);
         break;
     default:
         g_assert_not_reached();
-- 
2.39.2


