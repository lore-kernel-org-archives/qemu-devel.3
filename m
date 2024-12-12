Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AB0E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkvC-0005Ea-Km; Thu, 12 Dec 2024 10:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktq-0003eZ-8L; Thu, 12 Dec 2024 10:14:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktn-0003h2-QS; Thu, 12 Dec 2024 10:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VVnaZsJ2GflS1eyAYVQtNIu9ewyB4hBJfRYsfK5TDd4=; b=tGGcwhtoGgWqlpj2g9q+64ohtr
 D7I12jCHtlMQFA8w59YAFc8EdD49hGmrKkZ0YKx+Q3BOtkdQjJ9x9/E1unHLugqXqI73b+08Hueqd
 VSNCDyqYJlHmQxOmYIkw+45WvCKDdLUbZWfAKGteAozl7n3NKsEtW01lBvDDSib+86h4FGV1F+rG4
 f/QgJXZlbmg+kYoUK/8VAzm3W9NimXvSESM8FppLb4E3jEnDqQC6ebYIXcCUDuDaOKck2/NhzIpPZ
 QKqJrR5n5iij66Sn3z9oZw1K0LlbT9tvASbYrQLAodDnR4EoaiHV43/qW8FomZzSUCtn3oPbWjHPh
 K6WOnjWJT7JwjOvQxnaKVYr86jqX5G4G/XwqgsHID2TgVJskUHAKmInpIviQbyoqVTx3EAD+UdToj
 TzV4aXrKXcbsJ2sf4fHwIzdRltM7mKzP7gcP5xJFjrfCCiY8YSZyqNVrjebHW1LwvN7kmJ6i9kqCt
 SmJYS/7shL3U3n6AbI3UKo+44rGZj7vf0z8aTF7fnI7TsmyHDNpJ6hT8yr5KWpWfsdtuuUOF3HK7E
 RvRbS8oLN5JrT3J7Bd947jk0mkz7ruHJoS6FfhjBLYOj2SwwljFz1h8+o7QtJdK3o4mn0s/bbBIYY
 bQT6oLMjkMjiY2S42mr1AMdHxNUP37nvbdo0k86Os=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktB-0008Ue-NR; Thu, 12 Dec 2024 15:14:10 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:06 +0000
Message-Id: <20241212151412.570454-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 05/11] target/ppc: introduce need_addrswizzle_le() function
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

This function determines whether the MSR_LE bit should be used to implement
little endian accesses using address swizzling, instead of reversing the
byte order.

(FIXME: which CPUs?)

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4c47f97607..1211435039 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -208,6 +208,12 @@ struct DisasContext {
 #define DISAS_CHAIN        DISAS_TARGET_2  /* lookup next tb, pc updated */
 #define DISAS_CHAIN_UPDATE DISAS_TARGET_3  /* lookup next tb, pc stale */
 
+/* Return true iff address swizzling required */
+static inline bool need_addrswizzle_le(const DisasContext *ctx)
+{
+    return ctx->le_mode && true;
+}
+
 /* Return true iff byteswap is needed in a scalar memop */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
@@ -2578,7 +2584,9 @@ static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
 static void gen_ld_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
                       MemOp memop)
 {
-    tcg_gen_qemu_ld_tl(val, addr, idx, memop);
+    if (!need_addrswizzle_le(ctx)) {
+        tcg_gen_qemu_ld_tl(val, addr, idx, memop);
+    }
 }
 
 #define GEN_QEMU_LOAD_TL(ldop, op)                                      \
@@ -2619,7 +2627,9 @@ GEN_QEMU_LOAD_64(ld64ur, BSWAP_MEMOP(MO_UQ))
 static void gen_st_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
                       MemOp memop)
 {
-    tcg_gen_qemu_st_tl(val, addr, idx, memop);
+    if (!need_addrswizzle_le(ctx)) {
+        tcg_gen_qemu_st_tl(val, addr, idx, memop);
+    }
 }
 
 #define GEN_QEMU_STORE_TL(stop, op)                                     \
-- 
2.39.5


