Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632C4C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQe-0007Ru-Sh; Tue, 25 Mar 2025 01:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOE-00043r-U4
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:50 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOC-0005zV-CW
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso9525668a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878786; x=1743483586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMLogjQnjMTWhIeJ1ZbndYnRq86dbBuVmVnxwVyz8FM=;
 b=S/fzs4F+1Q0/6A4nMSBDqkx3phymsP9GwN88K7ggqx1R/bhGrcCM5V4mUU+F+5eU0B
 wGQqk6O4Yaqx+EON47HT5vNbMyLzAB8ZrO5JaReEev8lc9M9EDxzsagOPSppaScl4jip
 A9XZmpoNzyYUjzDzbG/1lI2gonyYJ3Xk8ds0ndewMjASjTNqrx2wwsyjJJXZU7uVoEMw
 assjZIWUm4MT87RUPZUPKDjWcP+iLskZFTJ7/MBgCJpf1LDjd3dtlxrTly1YdZWhG7tj
 Co+ZHtSg/WtJbH94PSrl8mS+1OGFYfBgW0n2f5VDQFpWxygMS5AUN/83JyjqpEJXrhys
 Wxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878786; x=1743483586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMLogjQnjMTWhIeJ1ZbndYnRq86dbBuVmVnxwVyz8FM=;
 b=sRnLjOkEmzvC2YGyfTgBknJSd+kpMdc91tl4AQxbCyLO15LPWEU5RGRjlKUSMypCTp
 k0ZvedMuLl9LDzje5ASNzwdM7J7K7PqjMSjGd+dgVyl0MZhiKkhLec29JKt6O6WXMY23
 1lrlHDlgXeb65OM+vLXOVL3kDGdk7T7ngTZD+eF7kZzAi8hnvX1jvVmnZO7iF4YvTYDk
 +MRBlyLwG0/vupjkYsX9rsirgXrzhtwn4SW0MAbGW7y3OpumbePg/v6LBiJPLiae3GWt
 mCGOvIUTCBRkzfc399i3QSPGpf8KkqQ0I7EMC04H0/2lV4J9NzgwYeAfTq9UbiLpMyMb
 gTVA==
X-Gm-Message-State: AOJu0YzDwGHYMg22KSF61z9yh6ePdUq43fDLnkKprG+ABsv2/WlWzLRm
 XlNdsQ1bGdLqoUjSV4G69L4dyXOEreVi2hpDSZZ/SL5v7dCpGpYKBdBIg3OrQaEbyrNtlYqAZXk
 P
X-Gm-Gg: ASbGnculA0FYwHgVrou6sLA0u3Y1gluiKt6OdtWfyWeKza3EbKcu8QCUWJZWzXZjc2V
 O3j7v7WeDJpVQSpAxWLLI9r6zo1imGYaWWSFSefjz6fu+n1e6bzI6ztwyMLn42rTgxO2yeydFzA
 VNgN6DvcNlz5tuoO0E/y0fTu82qJl6p5FfDH8toO4TW/gbulKbC8Kk3NRhpqRSCzd4yPeytj1/5
 2wtNMxycfXziN/j/JGPxw/agORByVLJ/UB3p6taWfhPTCzJIfSe3XOTEGh86v+qX257MtZdL9R6
 ZVU89dZxZgk12uMEXs3Mxwu1ucVDMA3baS+9h8XuVk0I
X-Google-Smtp-Source: AGHT+IG977/lluj6yGR5rtQmZPGYD//iaXHpiRPYTxrl/P6YCxp2pH/gKGqlEoMf8j4GBUIV0AflTA==
X-Received: by 2002:a17:90b:2647:b0:2fe:8902:9ecd with SMTP id
 98e67ed59e1d1-3030fe7223bmr23232830a91.1.1742878786330; 
 Mon, 24 Mar 2025 21:59:46 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 26/29] hw/arm/digic_boards: prepare compilation unit to be
 common
Date: Mon, 24 Mar 2025 21:59:11 -0700
Message-Id: <20250325045915.994760-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/digic_boards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 2492fafeb85..466b8b84c0e 100644
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
2.39.5


