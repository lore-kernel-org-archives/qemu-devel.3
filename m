Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D210CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuPn-0007de-DV; Tue, 12 May 2026 17:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuPf-0006kn-Df; Tue, 12 May 2026 17:13:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuPd-0004xC-K1; Tue, 12 May 2026 17:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619304; bh=7jJ2/RUb1fCDP3vT7vKEJ0UUdHp/sz3gvcscPlJxDN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PpKlmDNOqqHcyQ9D16UbuGDVylbQz3wOWQEkmwXFCt0FfqGq7fKHlsa9KAXARJ5F9
 /Pmcla9kkyu5cO2TdrLhrCr+4jhG2aCv6BU/b08Z+fY7pWyzS1X267Iw9pQiaJowd8
 AlKPt9Rqe7r9/Yvr+l7K1iX2yqyDzASvVIUZWrxuFbzwibo802L2LAUkqaA3FBiW7B
 YjGcXC2m6ML7tE1Z4tjYcGDsiql+I3Ad0ImfkUmNvymsY1IX0veyfM+J8zowhF+v6t
 8w16Su9silm2dzO/tSsfU3FCZDxIP3EwAJPJUlRktqfX3gp0lUrxtCpqsfBqda5ckw
 znxpmpRFBo/oA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC6221AA387;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B9B5E3ABCF6;
 Tue, 12 May 2026 23:55:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 073/117] target/i386/tcg: fix decoding of MOVBE and
 CRC32 in 16-bit mode
Date: Tue, 12 May 2026 23:54:15 +0300
Message-ID: <20260512205503.361097-73-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Table A-4 of the SDM shows

                    F0                     F1
--------------------------------------------------------
     NP           MOVBE Gy,My           MOVBE My,Gy
     66           MOVBE Gw,Mw           MOVBW Mw,Gw
     F2           CRC32 Gd,Eb           CRC32 Gd,Ey
  66+F2           CRC32 Gd,Eb           CRC32 Gd,Ew

However, this is incorrect.  Both MOVBE and (for 0xF1) CRC32
take Gv, Ev or Mv operands.  In 16-bit mode therefore the
operand is of 16-bit size without prefix and 32-bit mode
with 0x66 (the data size override).

For example, with NASM you get:

                                 bits 16
   67 0F 38 F0 02                movbe ax, [edx]
   66 67 0F 38 F0 02             movbe eax, [edx]

   67 F2 0F 38 F1 02             crc32 ax, word [edx]
   66 67 F2 0F 38 F1 02          crc32 eax, dword [edx]

versus

                                 bits 32
   66 0F 38 F0 02                movbe ax, [edx]
   0F 38 F0 02                   movbe eax, [edx]

   66 F2 0F 38 F1 02             crc32 eax, word [edx]
   F2 0F 38 F1 02                crc32 eax, dword [edx]

The instruction is listed correctly in the APX documentation
as "SCALABLE" (which means it has v-size operands).

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 76ad26dd172d27aae9f1e76d1165b497167c36c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0462429cf1..999362f213 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -751,19 +751,23 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 
 /* five rows for no prefix, 66, F3, F2, 66+F2  */
 static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
+    /*
+     * MOVBE and CRC32 are incorrectly listed as always doing 32-bit operation
+     * without prefix and 16-bit operation with 0x66.
+     */
     [0] = {
-        X86_OP_ENTRYwr(MOVBE, G,y, M,y, cpuid(MOVBE)),
-        X86_OP_ENTRYwr(MOVBE, G,w, M,w, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,v, M,v, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,v, M,v, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
     },
     [1] = {
-        X86_OP_ENTRYwr(MOVBE, M,y, G,y, cpuid(MOVBE)),
-        X86_OP_ENTRYwr(MOVBE, M,w, G,w, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,v, G,v, cpuid(MOVBE)),
         {},
-        X86_OP_ENTRY2(CRC32, G,d, E,y, cpuid(SSE42)),
-        X86_OP_ENTRY2(CRC32, G,d, E,w, cpuid(SSE42)),
+        X86_OP_ENTRY2(CRC32, G,d, E,v, cpuid(SSE42)),
+        X86_OP_ENTRY2(CRC32, G,d, E,v, cpuid(SSE42)),
     },
     [2] = {
         X86_OP_ENTRY3(ANDN, G,y, B,y, E,y, vex13 cpuid(BMI1)),
-- 
2.47.3


