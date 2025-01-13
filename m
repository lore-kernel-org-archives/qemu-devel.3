Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673DEC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYf-0007zN-DF; Mon, 13 Jan 2025 14:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYM-0006YP-Un
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYL-0007Wb-Bf
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so2556040f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798207; x=1737403007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbHDNHtZHrM8bnAI4XGM3Ol5IwOL8ZDw/7AER4oObB8=;
 b=fKCTQ2aG5oBuz9qc8N2L4TGEVdPwvX7JRjj+tZdwYCqQza9hVfg10qz8UW50upUQrY
 H24ps57Ye4Qtjrc5QJkywxcI/R4X9CnKEHoAzHd/RiFI6FCiFavVG6D4bqKc3iaP+30i
 J0Bwm3w+fAjfZ7pdVpIYyLB/qluaVbVrBQcj6nJHaSJWja4PFucXvDzsX2J9gxZUKCkV
 Mmj5e3MCRxI1m+vEDNVXInff7fEhO5BlUautofPw6ybSauEupJ4KDoEUl3SJJwtxuZvM
 DUccXJjLiTeNiBWhO2xRbtCfs1amCoxjX3NTMRjWIYsoJs1K/zgvsAc8uq3v7MdxtCtP
 CcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798207; x=1737403007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbHDNHtZHrM8bnAI4XGM3Ol5IwOL8ZDw/7AER4oObB8=;
 b=vGgw7PPeZRzYRMKoHBBPpnlcUhtyYWt9bXGK9+VZwf4rTt4LiXgZ2+FWIZEF3H8lag
 S011XZ9EuehRSxuUo7gyfrdt1jA5bOdjtV3heTSkfbBinj7zWiI95qbK3Hk0VdnA8shU
 sy21QQGci9KkSWdO8JpBt8DfNqiz2EOUG6benpFCiqV1d0MWyMdn6zR4zeINoYwiyHPa
 o/e9GtAyT2E6kUl0ZS5ysvTDj2W3iBXM85CqS+GHitQeImVgu71LPT0O7nZ2mSGWBfJ9
 VNTaUsvLzEheL3rLm/DKOeY2bKrEgHpBRFKNAX4MwwN5w+Cii59xd1W6bs6iS2fQi6ir
 O9aQ==
X-Gm-Message-State: AOJu0YwT5LW96pG2bR9g8a5GPlqj7hNCLM63XBqLROxR4LO+JieFC+1E
 1cKMIHqbNB50eXRfqMVPUJsTGllS8zo6RN5ylUuj5XNnA00klOGBH6H9xfn3oC4U+CuM9YBaDng
 a8OY=
X-Gm-Gg: ASbGncvMlwH04tE1JovDma8jDf3Z1B6FqPVfMTHMzEuQkFxJ1NNEx+AeF8UU43xII/h
 dD3kN+30nfjBN7ZW3cgUJ6hRzjT9f1KlV6PNa2Mq3OcQROnWlkQwzhHmzb4GsAbmFBGdZbroaUh
 UwkHOqEQ3CbfCoOTTdpLgSPNvKDBEdJ+886SSu7WbBqnXfBmLbnGBxPhoWODTBqTc8U8tb8pLN9
 5o8sjolVYCN73d37P76I005A0Ta/itkIR04AxwAuYsFY04jwnJJLoBIA7/sQpFR1PsDMeVe2L3r
 2P5ZR3wcTLAKxw1azwcrRqU8aO3HQRs=
X-Google-Smtp-Source: AGHT+IFyCj+fen4YU4qvRLhbwlYRKjj5g1ZrEvi0MGgY4n2j+qAdNBZtQfw0EnyJ621fUfCvDarn3w==
X-Received: by 2002:a5d:598d:0:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-38a872ec201mr19684591f8f.31.1736798207645; 
 Mon, 13 Jan 2025 11:56:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf65sm12823298f8f.49.2025.01.13.11.56.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 16/19] hw/mips/bootloader: Propagate CPU env to
 bl_gen_dsll()
Date: Mon, 13 Jan 2025 20:55:22 +0100
Message-ID: <20250113195525.57150-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Propagate the target specific CPU env to the locally
declared bl_gen_dsll() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index a0fc840e89f..e57d5c3278f 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -118,7 +118,8 @@ static void bl_gen_i_type(void **ptr, uint8_t opcode,
 }
 
 /* Single instructions */
-static void bl_gen_dsll(void **p, bl_reg rd, bl_reg rt, uint8_t sa)
+static void bl_gen_dsll(const CPUMIPSState *env, void **p,
+                        bl_reg rd, bl_reg rt, uint8_t sa)
 {
     if (bootcpu_supports_isa(ISA_MIPS3)) {
         bl_gen_r_type(p, 0, 0, rt, rd, sa, 0x38);
@@ -231,9 +232,9 @@ static void bl_gen_dli(const CPUMIPSState *env, void **p,
                        bl_reg rt, uint64_t imm)
 {
     bl_gen_li(env, p, rt, extract64(imm, 32, 32));
-    bl_gen_dsll(p, rt, rt, 16);
+    bl_gen_dsll(env, p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 16, 16));
-    bl_gen_dsll(p, rt, rt, 16);
+    bl_gen_dsll(env, p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 0, 16));
 }
 
-- 
2.47.1


