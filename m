Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738D4CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf2B-0004VP-My; Wed, 20 May 2026 07:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf0E-0002os-UE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:22:45 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf0D-0002Qx-7p
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:22:18 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-393c93a0166so48419911fa.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276135; x=1779880935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4s6EOQ6ZnlJu90hNf8VpH3028jFWn1tyWjcvCFB1a5s=;
 b=y9FvI1+lz8YuOlrAkem48vWBL8eRUI9nbLD/4vqjBOm4eHihBkoK8PXI4kI2yPdIJY
 gEGDAsT5o47A7hDRJrI9If9MqdEyofjyMFsPb+e7qYfApbLb8DENOiMiaop8UEIg8lyT
 lqkh8LiZdfFvLs9MS+n3gedWn6sRij2NNLE8IsSbODYfDKVSTk2hPLV2hHoNcE9TOm+y
 aRTtHtBSYH+haus2Mp5D2K2ZOeEE8sOSatAnjuHohehws+dI25n57Umby+cFpxWq8vP/
 4DwYopNsQ2ulvZkPn3pGEAz6bmXfTEN78frCZ61W3jfN/ho1GoqkZsnqw52EhKWOLRwN
 f6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276135; x=1779880935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4s6EOQ6ZnlJu90hNf8VpH3028jFWn1tyWjcvCFB1a5s=;
 b=tDrzOMbvOVXMTxIxxBOxDwciEh7EKuSoxELJdvrw0Kd1U5h7SkKf+lFcQHkqd7qh9n
 qZ5O9t98kMG0t93g8Et4P+MTcx2NvzwMlJeeFITdZV0C8rNo/yJ5fgy/vmZY+2jUwpwU
 BNUTg/7mQ8QJGJ6FUjHe2pVZcvFaPhcVDqIjGQ464i0sgUSuN0PCaboZDQA8iJbqIOSX
 Xllcdi52+sfDHdTGgVWMPx9D+FGQcyMMVPpx8epJjGjlJs/J1NacaIRfYhHlXPKSHPPB
 mcI+7nmv/xcwwmiM+JLICg+kKe5qnWTmp1aQH1pqPE6MpTEYhseylOq49s2Q5HeqKtKa
 wf2w==
X-Gm-Message-State: AOJu0YzfOUbx6kjpA5X4wwLVzOW9EKbyyrajDVper5HquiHaZwhNw+ag
 TsJgwET/7OMPt4eslTmwUR6RmultTeFjYj4ERujNQp5fAneO3Zw5r7swP70RaUJqdM+oDdHfGBN
 bieOC2pA=
X-Gm-Gg: Acq92OHa66hW7yz1p5X6JewegQwgcT4XgicXnrBQSeOH4BYDvpW9r7ydIqBeqA88I1d
 taoDWUBFAfEt0QF7dxW9r76ODawY+v+ZgI7eRfOiSW4287qeBoLHNAbynLhUIUf8IBZGzegzw3R
 PHfoBf19c4O3KX+rpqkyGNrgKY++syEpvXsEK4t7dos+qxRDxzncL4npaNmOJH2C3dkHFyz46IJ
 RV/GWO/Hv6zdjKnq79izOgaY4gMXNE8T1Tg0N7L3+5J9dodUsrRCCMzm5N8HE+R08+9u1RXXZ80
 AAPhZjOk71b6cQwzuIB+z8FO4IbrwX+xw0UNyj91FZg1yT9id6637JPgSB7/R1aKi2P4Ze8JVhJ
 p/4Pht2JgDC7goCka6YBXEcGoKztbXiOy6u9GoRWjxFbF/cWurd4RzRPysnryk40BXFrqwuC1+w
 Dm9bTKOnoNCIfbyJq5pQ6XEUbL9RjJAhVmMDxJHrlK0mPTPIU/kUwYHwbfwMFTjKUFvoaaFpw+C
 C+Z+m5S1ik0Mqs/
X-Received: by 2002:a05:600c:a406:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48fe63297b9mr291800915e9.25.1779272394625; 
 Wed, 20 May 2026 03:19:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm48803598f8f.26.2026.05.20.03.19.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 14/24] target/mips: add Octeon SAAD instruction
Date: Wed, 20 May 2026 12:17:55 +0200
Message-ID: <20260520101807.9971-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: James Hilliard <james.hilliard1@gmail.com>

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de421..d77717cd507 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f00692830a9..d3dfef2e0c9 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -175,6 +175,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_32);
+TRANS(SAAD, trans_saa, MO_64);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
-- 
2.53.0


