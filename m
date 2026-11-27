Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204F606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=CLyRv0KK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8N-0007JS-GS; Fri, 27 Nov 2026 01:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7D-00063c-Kp; Fri, 27 Nov 2026 01:07:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp7B-0002im-V1; Fri, 27 Nov 2026 01:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=HKwXtMh0Ds5Sl0toMnlkAYk54MLXrGm5g/goG3jRfck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CLyRv0KK0VdfepFX7cljtbZPNKF9UDdIm5XpZ7pS4XUdC3abdHCV7lyjG+eFtVaTW
 JGNEUHPBMbcyFDQX4dDNkcf/Zp1CeOCBLqa/4fxpwZyB6llJxDrJxiflUokZj1V8Dm
 F8FZEqpGxmHxCaKnIGJKmySRLAwX2+sfln7VG13FWlUtJNFpAhuTyiiOUA8WPOa/JE
 hIdBZQkm1AHfrl+A10IkOu8clnEPk1ItpJ/6DIE98RoRaBKRcE25eij1Wbu+a0BEf8
 Al0O0+pGwjS7ZuBm8Ol6QWSL6a5U7b4qywF4m8R2wssC2EIvCdzaFheLSvT1fsAmzh
 DK+IlfH2msVng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0567A1EA361;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 033DC46998C;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E85F2CF310; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 111/152] target/i386/tcg: fix lea address
 calculation for CS register
Date: Fri, 27 Nov 2026 08:54:09 +0300
Message-ID: <20261127055709.39630-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

When the effective address calculation was simplified in commit 55a15eb3504
("target/i386/tcg: simplify effective address calculation") the refactoring
accidentally introduced the ADDSEG() macro into the CS base address inclusion
test.

Fix the logic in gen_lea_v_seg_dest() to use CODE64() instead of ADDSEG() for
the CS base address inclusion test, and at the same time split it into a switch
statement to make the logic easier to follow.

Fixes: 55a15eb3504 ("target/i386/tcg: simplify effective address calculation")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260927123807.492352-1-mark.cave-ayland@ilande.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 12b268222422219b21126a2ce59ba59725296f97)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c4ad6fdeb22..87c7658b999 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -605,7 +605,25 @@ static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
         ovr_seg = def_seg;
     }
 
-    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
+    switch (ovr_seg) {
+    case R_DS:
+    case R_ES:
+    case R_SS:
+        has_base = ADDSEG(s);
+        break;
+    case R_CS:
+        has_base = !CODE64(s);
+        break;
+    case R_FS:
+    case R_GS:
+        has_base = true;
+        break;
+    default:
+        assert(ovr_seg < 0);
+        has_base = false;
+        break;
+    }
+
     easize = CODE64(s) ? MO_64 : MO_32;
 
     if (has_base) {
-- 
2.47.3


