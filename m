Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381E5C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylFs-0006Zv-LF; Tue, 25 Aug 2026 03:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFo-0006R6-4x; Tue, 25 Aug 2026 03:07:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFm-0005y9-8d; Tue, 25 Aug 2026 03:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=rc/UuXMu2rKfZA7XORSoQghEPR6X3TcTiSNAxujo3Vo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m53KuQrPtHz/tlYQrXUNEKH+9pFLZO5bgd6tCsD2WZu9BvTx+kEPjkjKvCM7FMFp9
 shCtc+N1xq0aRd2cXENa8nnMjBdN86VBE0vUg0sgJnSNyt9dVU3rlg1pm5ZuysAYse
 opEoDAEgnTpDxWb4HJmoyVpgJGRUNXnYgF8RIMNusw3rxTdyrCLzHuCfomLlRPJ5V3
 pkOLdqfUKyISz1LiqVBP0RoC+pa6PR2vxefsMzBtIKgXZ/LRY96omcSpelXsq/FmkO
 urnNS/NfWgrCGYOi3JdY2Im0Y+K++swcZK/b6SXf34TYMMe6YbJnod0d/bMJ/A5ZFN
 ddNuWvL2sFWOA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0BB2F1CE217;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2E6E415F92;
 Tue, 25 Aug 2026 10:07:12 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 791A03240E; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Polivoda <apolivodaa433@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 50/91] target/i386: decode opcode extensions group
 3 /1 as TEST
Date: Tue, 25 Aug 2026 10:05:22 +0300
Message-ID: <20260825070619.174584-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Andrey Polivoda <apolivodaa433@gmail.com>

According to Table A-6 in Volume 3 of AMD64 Architecture Programmer's Manual,
opcodes F6 and F7 (opcode extensions group 3) with ModRM's reg field values
of 0 and 1 can be used to encode a TEST instruction.

Although Intel 64 and IA-32 Architectures Software Developer's Manual leaves
the cell 1 of opcode extensions group 3 blank in the opcode table
(Table A-6, Volume 2D), the instruction in a group 3 with reg field of ModRM
byte set to 1 actually behaves like TEST instruction on Intel CPUs.

Currently, QEMU decodes group 3 instruction as TEST only if reg field of ModRM
byte is 0. When the reg field is 1, QEMU raises a #UD exception.
This behavior does not match real Intel and AMD hardware.

This patch fixes this issue by duplicating the existing [0x00] and [0x08]
X86_OP_ENTRYrr(AND, ...) entries into slots [0x01] and [0x09] in the
opcodes_grp3 table.

Fixes: d7c41a60d0c5 ("target/i386: move C0-FF opcodes to new decoder (except for x87)")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3580
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260621032524.1138213-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 380b9596181760f371713604ea3472c56c19deb9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index faf74b00bbd..9c429e113de 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1624,6 +1624,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
         [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
+        [0x01] = X86_OP_ENTRYrr(AND, E,b, I,b),
         [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
         [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
         [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
@@ -1633,6 +1634,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
         /* 0xf7 */
         [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
+        [0x09] = X86_OP_ENTRYrr(AND, E,v, I,z),
         [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
         [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
         [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
-- 
2.47.3


