Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D955CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa29-00029R-QM; Thu, 14 May 2026 13:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa10-0000r8-5r
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:31 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0x-0003tO-IM
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:29 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so8916852a34.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780280; x=1779385080; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=r1Utfjk8C/ggB3LbEppAgQ0MpjMVXbWRJN2pM3j6V3yw3U/KohAKFtki68yapmSBLf
 zqpwaXXLFEXQSOKNWUWmBLjxXZ36td5tnxOu5hjh3oV9CCIMb1HonfseDiKoLYmuTdqf
 R+0IQBZbs9oU7zHlc+6zmcjqkguEaK5WoBAicWI4yEB3BYzJsPDyQF0KaNFHpm8wYwYg
 dEBuVlbevyfeOw4pXdvOwgVgcjJiGn0NPsdvcbHSizDmeEthZlj6CY9UgCIWPnvj0ryE
 PIJGq8qCmLdwbSwVbMnn2NRiCshLd7xpCV75SoeYDpbrvBZgqyVnHMVs6pNhXgQ23mYf
 mNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780280; x=1779385080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=oZBoI7411PKUpPjRZR8TtBjYltYP4zwGNASJzQR2L1q1ZUb0yWp4eCmab98SsJkmGD
 QZVNbXai5b+SsY7P+y64dLQtmfzDgzNpVgXgFgYF4cq2lvPGtZ0QXd54XCw7tgBO03Xc
 h+OSCLja1P/qIgnKUltC2guxxqVEPrZC9MrYooGTL2N4pRmH8c8/C/7gOwcgiapj15rE
 eYe9cm3Fm5AtDS0W5QL0zEnv8qRCku+MTbJPfa2pBz8cdG0A0qJlY9wcp0h9XrjNzaFs
 /VWIkveRDJWAa5svRokuTaTOY6Z3nOUgsnnaEnjOWZA3BW8BKuV4oYJtLpB3KiNKJT8T
 zQ6g==
X-Gm-Message-State: AOJu0YwUW7vItl4V0K1A5OwTcheqv1DhnpGrSxiF+mCuc6mT7ehvhb63
 NhTc1N9BXIMjkVpflukoN8gu0zaTIHG2uVeY69tJ9k5HsIVoAYSWJWnO
X-Gm-Gg: Acq92OFIM4xUoAkAs+qIlznHBrXiQ80n7FRV6bJZOvHzg0sBr1gC4H0xS8cMTWCf4WY
 55/eyDZE8/WFozWw0NFqdOlhH9TjqEtXZZWUYQ8fCWyrAhEQgt0rlzfwfnOMgc+gPYeyUuaCB5I
 CjEqA+QrdKF7yDPvL3E4hi/sUPOY3fqevfRYHzyxtFpYSIaXM4MZXJHPJBBx6+RS+oL9XW2K9gZ
 8oZD90KI5s70i5zFdmOIXJI31/4VZGz/pSpa4xT8C46gGzz7pC1TJRrqlOhO8kffeSbq3f6FkQ5
 SY0xvz00oBGXZWQJgGbO+gQMt6aHEWYEslmX9mnCSaDE+0CImVqKlDcPAAmev3rgKfeBWZ61He2
 xr/iWQYENs8J+gX1YKHLQOPx7SDdAhIvA7IZ9TLYvT1/CA2uciwm2vMwEaYAEwyrf5Kqi0Yi3an
 T27fr/abXIHCr9PqzFwwrIitsmrAZxOFfJk0AoXqK9j/NpCCpvRG7ivb24viWhFaR9QFSzAD4JF
 cCQteW/BIpWk5UJNDEEAZTXcLADF1MEAvK3J1nB7hubpRTne+Nb12RaSF9HmHdO33q4
X-Received: by 2002:a05:6820:6ae1:b0:694:a062:1aa0 with SMTP id
 006d021491bc7-69c945887ccmr243249eaf.47.1778780279853; 
 Thu, 14 May 2026 10:37:59 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:37:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:56 -0600
Subject: [PATCH v7 07/35] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-7-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32d.google.com
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LBX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d..efb1a48b38 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5497ddfb10..451737cda1 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);

-- 
2.54.0


