Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9608CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmRL-0005lD-Rv; Thu, 25 Jun 2026 11:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wcmRK-0005kz-BW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:56:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wcmRI-0005Jb-PX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:56:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so119415e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782402985; x=1783007785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eoJASh8MaR4nfptlyCYZGqvvY11skCxIUb+Conb7Z80=;
 b=Yb360k0nMNiANa9Ob43WOlJZS03Gjjy5ATNT7257Drg/i2PvnKBWEWUqddpouq94tb
 nepC6pfnIz8MbFhlxioHZqUh40UAjF8JdGdsqgonKutfhGDLGIiQT/uDi96ar4sSPe18
 16myfzJYwr+6WLHI6d7pqIK0UJ7csvxZLHpD3mLZVdDNGaFVRtFmrbmXkbcZXbEPxxSb
 rLDXGpzUamjByLetjKLEPjv8mDupfp79+7yT060Eio8z95wI9uo1lSFUOhUJhuzdhyua
 ts9dmNvFpM/BOONBxytO3eVZPWTDEm7s+yHmpe5DzOvbshPgSEftLjoOT4gSoJ8+18Wg
 5egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782402985; x=1783007785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoJASh8MaR4nfptlyCYZGqvvY11skCxIUb+Conb7Z80=;
 b=m556sPNai2sOwJi40D++mRlscq87NYiX2cKhJsxhkOXu1QyFb9xal14Vse72tSnO/z
 F6mOJEuEfWdQr6b5Q2kBkHSCBSBag0E8YpgFps011K5rhzEi+7nNvT5VOxW7Ip48mq8h
 R2uk3LH7X+SmKaHfeDBK5QAK7eD0xXpRIRnAuhg9ltqIY8XdjXo5AZQfBt5tdMChpp05
 9U7G33tmdTOdqGmPFqyyPoEqolkFpk6GzHGd9566lCMUGEKZqg0ZWMieCNVURf3wDiQO
 U7hoeujfaR1mvyPAgsnRqbtmJz4FcxevEhzR1u2CJ8m/mkm1T08BwF1WucSdIrOBhw3i
 mGNg==
X-Gm-Message-State: AOJu0YzgCZNBSzTmtkg/XVcpVCzNkx2RHl96f0hmZQxuhEuyrOlY6aSQ
 ahuijZm25oyihYcUKN94rg0J0UQxygA92US1D9C52mtSRSgSXLeihaffxPPKv5D0Brs=
X-Gm-Gg: AfdE7cnv/0R3G7i6fNLEUdMeA8p5HDwR60FxxjhIKwWZwcP6dJi50shwO9bcKaWO6Ta
 vAcrbejSBN/HajDuvGNRxYVzaTXjLXPp+Xk2WsjHk0S5jMw7moH5Ag32RT3MLnUL5El+2XHuyfJ
 S5CuP6l/KwY1S4+5sDRtp+49eP2LMXMDuHw17pUMoFVoRrRj1heANVG5xvQhQJGYc3DXVsbk6Gq
 TWGYJ4suxrjJtEZAZFrhPrgcETOfKbaA7Y3XPIh4OxYiq2iSYrd1zkXDFNkb6NOaJS5HVL/x119
 Ko72HiZupAzH8wX3M2aUC0oEG1Y+mnekdJx4dKIkxQkLIfkyQJyMZMIuheLJN/3M7CCB1PYjoRM
 7H12JT8CjbkrvWlJcNEB6wTJE89kjB2xDyfmVStKtdY4/9GGQ+8mOfHA/ksKbyPodSWyIKJ89P6
 gvqHTx0/5eoBCyTKGhgtEGYwIjs7Pgqax0iWnjBhlIMrzZYf/OvFHyeZbHMHvL6I/zWGk=
X-Received: by 2002:a05:600c:810c:b0:492:2ffd:8f8 with SMTP id
 5b1f17b1804b1-49266873f6amr40203965e9.15.1782402985132; 
 Thu, 25 Jun 2026 08:56:25 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (nt-e167.wlcli.tugraz.at.
 [129.27.244.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269005626sm6549435e9.10.2026.06.25.08.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:56:24 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: fix incorrect decoding of EXTRQ_i
Date: Thu, 25 Jun 2026 17:56:13 +0200
Message-ID: <20260625155613.192643-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The decoding of the extrq instruction with an immediate operand (EXTRQ_i) is
incorrect. Per the AMD manual the instruction encoding looks as follows:

EXTRQ xmm1, imm8, imm8   66 0F 78 /0 ib ib

The /0 indicates that the "Reg" field of the ModR/M byte must be equal
to 0 and the XMM register operand is specified by the "R/M" field.
However, qemu incorrectly uses the "Reg" field to extract the register operand.

This patch instead extracts the XMM register operand from the "R/M"
field.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3611
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ac181308ca..acb300457c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -605,7 +605,7 @@ static void decode_0F78(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 {
     static const X86OpEntry opcodes_0F78[4] = {
         {},
-        X86_OP_ENTRY3(EXTRQ_i,       V,x, None,None, I,w,  cpuid(SSE4A)), /* AMD extension */
+        X86_OP_ENTRY3(EXTRQ_i,       U,x, None,None, I,w,  cpuid(SSE4A)), /* AMD extension */
         {},
         X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)), /* AMD extension */
     };
-- 
2.53.0


