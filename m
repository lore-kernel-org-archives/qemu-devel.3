Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637ACC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTC-0000FL-Qz; Fri, 04 Jul 2025 06:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdT5-0008Ms-Ay
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdT3-0006xp-7y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so514896f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624187; x=1752228987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YzdNSDrMEvcfRaufIPZ8ratyEQ1tLFQSVd+1LrIS2js=;
 b=ra2jNiR2iAyCZyKOTBX4TQny1Esg81NQw/Bv9NJATCCT90kOOquJqhBE404wiJ0eFp
 XxxD0fGdimeiwdQoITM5oUsZ4iFf9XUFgiDlup/zN/KupWbIpSdb4zJMW9wOIxbm3/56
 U7Mfuwl0Uj7nvimDsnxF72CrpC5sjFtv39vCaEWc8ZSqpaEM6OVU8pR+pYPZRpYhPKim
 vJOuTJd/ZYX2ERbaBnunJhb7mztuxgemeJ8eI+7wl+ERSXkKQjxj1kFm4djcvOC+N1rV
 84veeFEz7uyInLm1pR/VCVdYsMQimDz8G+ye9XQswLMCIyUszOUeV+MQLc4tr5QKjy18
 3Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624187; x=1752228987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzdNSDrMEvcfRaufIPZ8ratyEQ1tLFQSVd+1LrIS2js=;
 b=Q3B5CgEXem/rE89/EuIkq/DvAH39HEsq/bVxGH+lLYWLB16ZheFUI4bKcH33NWr9S4
 oI4i1UbyicWk43I/dFFudb0fFTlFc25eihO9nl0+XboZ99bNy6WIV7C0EHEBRe71t0DG
 rkudlYSnlxFMYc3JUykUV6cY5dhDWPA2wggHDJ55QKZ/Ft7tTHeuO48qqlKs08yYqA0O
 WulJC+0CSQMmi29/foTR0MwUDji2DevGvhFdMHOUU5uI3/hhQAS9TJC86Br1T+YbnkoW
 A8SYBogUeHYxPFMMGwOTTSrJF00s3oQ0Pf3rr5DmiioN+d8LfIi6Zu+TSdiP7uHfSiov
 fkyA==
X-Gm-Message-State: AOJu0YzI3dEtjIJ0KJKDz8DsPhZ/fwN2g++S/3xXq8/WXEOyeRVgu+zU
 7shd6NbRpxm+wQK2ek4IN5iwcC29RVnukw9YKuqtsxg3cAJoCzSlgX4qhHoI091ZpibJGMTe3zi
 5Ku8B8b4=
X-Gm-Gg: ASbGnctWkowebP37IC1xcQV9Ram3L/Tp5pQ2KuldTTd7DQkr8q13v6UyPlonYNxF/L9
 d0WGQaOuEgPRmjqXr5B6QR8XeeAAn+DdyEHpHc9NMPo+wE40+AKUxGTdm8UfJ3ySJOHhKrJqGFa
 cUZFu/Ml9FarbqF9/IrlDvBiO6d9XrC3PxfwZILn0DQm5yWD5Iz98oG3pcUzRuleuSR96qUtUVX
 4OmeYrHzq2up18TAYDc0u0Q2iKAqETLaR85806l5QryMs+u3akVXui3oeJIcOZIPj1CmTff/mIV
 IRRdR25VUimTCqKucvGreKBxcSl3L8OiBxCFgnXNs85eKSUlwPImDLT3Dl/dBt31pPWU1+WP2/N
 HIjLgpKO12HV1QtY4V4+mrOUfa7m5mQpMykfv
X-Google-Smtp-Source: AGHT+IEmLTsplqT9VX60Zu1ll3lGdoWUSYzi4d4BIIHkLGa1AH07utcJx+91At86ORj8YgLRILYTQg==
X-Received: by 2002:a05:6000:24c9:b0:3a4:e667:922e with SMTP id
 ffacd0b85a97d-3b49700c540mr989888f8f.4.1751624186677; 
 Fri, 04 Jul 2025 03:16:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a85b3e2bsm54808655e9.0.2025.07.04.03.16.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/31] accel/tcg: Prefer local AccelState over global
 current_accel()
Date: Fri,  4 Jul 2025 12:14:25 +0200
Message-ID: <20250704101433.8813-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250703173248.44995-33-philmd@linaro.org>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d68fbb23773..c674d5bcf78 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -82,7 +82,7 @@ bool one_insn_per_tb;
 
 static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
-    TCGState *s = TCG_STATE(current_accel());
+    TCGState *s = TCG_STATE(as);
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.49.0


