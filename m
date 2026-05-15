Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F904CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtH7-0007mK-DA; Fri, 15 May 2026 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtH4-0007ZN-MY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtH2-0004GZ-RD
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:22 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45562c41ec7so4767432f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854338; x=1779459138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4U8ZCCS2W/eS7opYuY30TphoIHkpy54aFpBL/IoRZY=;
 b=UrpgxejORcUs/HmEPuamvghNO+9Fp0342gzrkr5FbmVhKW8MKPQ+sJB+MKdOZo9Ksk
 lVwRGC6r8ztu7HBeVn/fTMqfs7ySPrRk5TdqyKPAEP7M6scguT85n/8IyKWgfIJIwHbe
 qqq+rVbU7fKHZFIaQBQdnDqOh6Ls7YYZZ0IbnOzQA1PBxwBTe0Kw15ufhxN/ZX0WG5Az
 YQOk5k/c3pinaBIw+gEo0p/erok6slqAgyfXHlXBCdWXiw2esNNS8s1EODfMq5AhjPyI
 XEDYGJA4YkPGHdJC8E4Qqwd+wUBTf+B92zbwJsIVFEczAWwu6ohHDtj7DSp3f+wEf4DX
 n4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854338; x=1779459138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o4U8ZCCS2W/eS7opYuY30TphoIHkpy54aFpBL/IoRZY=;
 b=OyaU9LmP082I6bwePfg9C04VI8UDqOA+9qXNgjENsgfOtwhygYLAWpiCR7PXqRm6y3
 OAyrUgajGUKJxAPd5/17ZQHmfYHffemAdLMqfaN43As01l0MeUY7NUErw6gBTDfkpl/r
 q8BQEvCCi0aXbHr+sIrKqmIZq9gfYPv/QqO3tpZzteoYjk+Oi3hJPUJrCh3t6Kgrs4kc
 7C8wwEl+ZH4QN/SneNFH0FbhGR3A5kp+j4fotCfVkNr4bQuKb4cqVFSSIf44mKBbrMcG
 dyxwVxZ1kry6yU0BIEIDds4ZEH8HhGHIONyLIwsnz5B7bzyXQ2753GdYFgPPbxLt2Msv
 Z6Mg==
X-Gm-Message-State: AOJu0YyHFY1/Lik+1faSjJxABLR23wufHLhbqo7ONwPm3k/zxEeqiDwu
 HqaRHucDgT8EOMtNxmuotBen/tRUzQ/1tB2H0t871kp4vv0Zbxa5mLs8txVNk7jXE8YtmwUs5iQ
 HKLoegw8=
X-Gm-Gg: Acq92OHgwcXpuT1HxLFNpN/7uIeFHacsUOOFVBD8MBr87PrRG6xXnCS0P9t3mQUCzST
 NCFsBnN8vvd13PHH8WsXa9JUFIAZJKTJjgKYtsp9PBXT50eLYu0gnQ25jxaBWvSo3dseBTCW2C+
 JZzkWTQnRWv/7sTgmg/rQOIUTM/vHaerqHzK/cDHGjrgYKGHi0fDomtjIQayYbl7cuyQ/TrJ0fc
 I5qzdIopIfSIf1zpfwcpSOIGSObHFmLFxUPbBj6S90b4kFqhc3bWvLliMJ3F82SXUqjrzYST/Dr
 xVQURI0aGgj8Aa5Kl8DxsJGnz+HJcNpzNvHyjyYL9BNs/LqvF5FP042GvJPtvrmPzkVzXMQD8AU
 mjFe7zKnBGHiX+Fh25q45yhEzUBRExc4Pi8IjrP7XoSysd1nb3ohO9EqXFTg8dqtSkVkErfnXiA
 TW2GypfTVr1wbNzvrzuOTnD4SuUWTZ2VFfzIk1KnTX3GSmh2AB609soXsBaBoHY9pYieUDgSaz
X-Received: by 2002:a5d:5f90:0:b0:45d:3cb0:5ab1 with SMTP id
 ffacd0b85a97d-45e5c5f8424mr5697301f8f.38.1778854338158; 
 Fri, 15 May 2026 07:12:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed30110sm16004845f8f.13.2026.05.15.07.12.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:12:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 14/20] target/arm: Implement DBGDEVID* registers in max
 AArch32 CPU
Date: Fri, 15 May 2026 16:10:25 +0200
Message-ID: <20260515141032.3271-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

32-bit ARM max CPU is a 'Cortex-A57 advertising none of the AArch64
features'. Keep it as close as possible as the A57, by implementing
the debug ID registers, following the changes in aarch64_a57_initfn
added by commits 48eb3ae64b3 ("target-arm: Adjust debug ID registers
per-CPU") and 09754ca867f ("target/arm: Implement AArch32 DBGDEVID,
DBGDEVID1, DBGDEVID2").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/cpu32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index cf643ce43b1..2e8afc28602 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -755,6 +755,9 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
+    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.dbgdevid = 0x01110f13;
+    cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-- 
2.53.0


