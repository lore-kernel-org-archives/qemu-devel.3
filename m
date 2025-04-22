Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF43C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSG-00044p-F7; Tue, 22 Apr 2025 15:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS7-0003w2-QE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS5-0007J1-Qq
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22435603572so60128505ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350720; x=1745955520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6H/GoAoFwszVT4TvnJT7Vzq/vNV9Nxqb0K+QM0Htps=;
 b=kB0hBciXTAZZ8PnZ7fxVRBWKP1y75hZjWt5HeMrOn6u+IOY0OWM5NseP9flPPgvKM5
 zEBAfHhq79s+iokgj7THnnu6k3P/u1VO2HkI98t1YphJYIw5lnWIeCVAI3hNVEywKXK2
 +sX+81VnyYumQnMmEfzhAYiWhFG6mYNaAF0WmfMMfP97fMWiYZ/9DD1PI1yEZIZo/m7M
 kjvBWU8IxQnpLxYxpOz3+EWvm/qBcy+xgtUxtjV0zdSTg1sVBAGPXY14fjyb8sZFd2AQ
 ZxIIp6kQGB6eX90PAinrPAlHfL2ia8tajoKB/pFJzRIrnrYMcjykZBl6SLZTrldmdJ8Z
 IuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350720; x=1745955520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6H/GoAoFwszVT4TvnJT7Vzq/vNV9Nxqb0K+QM0Htps=;
 b=ux+lkd/D6fwx8GJasGA8y2ivVSbcfpHyETWhbmSCi1f9AVOreMKKv+pVXR1fAksI+R
 5DqfufceKZyA1jj+cZOzGYfozMQSLkvYe4z1WowvqTo+GZqVFaJloqjdEQrtyYOVjdVU
 SwKgM8F4MOqiHX/PBUYtDptAf52/SsCkJYNU+y/5nD0OB31XP60y2DkxJQEraQaK/ZmA
 aog4BuGATB3wljukrxd1A2GJGFk8BoMT50EwbcAZhU2lAMK5APyRfxobGtlwCTdeweR7
 n5jILOx6DeF2MDm85idpTfqt+eK3Px4/9g8ZbSo4WHg2SjtDvfkC8tTZXiLxZ0A54bU2
 pGpQ==
X-Gm-Message-State: AOJu0Yw0v09HvYuj6N0wF+mr+FrO+HeW1TS5PdjNDdO06Vy2lTVESiKr
 907wpUXlbzkkQxZC5gbCyIMbTMKEQyby7R5Cns+HStwWZKR9b7FrWQyilE9rjBeh548qZWYP7V/
 G
X-Gm-Gg: ASbGncu9upSEz7ZkrvYgkT6iTLsLoWgKNzpCqcX+VZBf3kI2g0Ks35Qk4TYeO0RK5lv
 dcoa0escn9R4dTtt1m7mWiA5v2cv60GoWIMII0iywvvdpWCAiTgg+zb/Cjh3VXHPRlIpQmPmfRp
 GPXOF2m33K6+R1WgJYCS61286iKh5Nt5PwnnmQ8Jvc5p7vnqTG5Ml34aE1Gv0UYnrf0u3khfmHB
 7JOES7p2Nz5OB/zTtfyplYzs8AW5y/AdxJpV7eJbil2f/1cpTSpxUzboxYjZdZ19lG2/+DiiTQX
 UA0F6ZztN+Z+KIGshTk9vS+Yb6zFVfotQhVsxfbiSsXkGRkZxtgkgJ2KIH+z1EnGhHTbxVR9QL9
 8GdLDzoSrAw==
X-Google-Smtp-Source: AGHT+IHu32h4DRXCpPjwfTB/2TeHUFFG+BHZL3h6cPTGoIwj0HabouI/gX7Kr342X8WadKaP9cAKcg==
X-Received: by 2002:a17:902:f60b:b0:223:432b:593d with SMTP id
 d9443c01a7336-22c53601137mr249025865ad.42.1745350720177; 
 Tue, 22 Apr 2025 12:38:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 121/147] hw/arm/digic_boards: prepare compilation unit to be
 common
Date: Tue, 22 Apr 2025 12:27:50 -0700
Message-ID: <20250422192819.302784-122-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-27-pierrick.bouvier@linaro.org>
---
 hw/arm/digic_boards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 2492fafeb8..466b8b84c0 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -80,7 +80,7 @@ static void digic4_board_init(MachineState *machine, DigicBoard *board)
 static void digic_load_rom(DigicState *s, hwaddr addr,
                            hwaddr max_size, const char *filename)
 {
-    target_long rom_size;
+    ssize_t rom_size;
 
     if (qtest_enabled()) {
         /* qtest runs no code so don't attempt a ROM load which
-- 
2.43.0


