Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01CFCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TLa-0005gB-30; Wed, 24 Sep 2025 13:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TKx-0005Sx-Nd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TKW-0006Zt-Fp
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46cb53c5900so501325e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758735041; x=1759339841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01ZOc4BKa2jNYsiKE/FtVTFT3ErOS4ymhecqLqiMBww=;
 b=X9upt1cHYhxtci0DVrA5NYLxGIGgE68LT7VGnlRxra236vtKX5Nt5588t5IN44iV5S
 pwndELeo8ZSO5nQFauML/qht1Wx/CLcad4n/jkZBIJ0d89hC37BQEL76Y+i+hHcwgul0
 ETbwR17VGJTJMLGzipsL6QYRt4Xfx6Qf/Xf9faRthieqwxZqGYINSQTfnxsKqF99Hful
 PEva7sleeN4c5aigK5e+v07DLKQ7NeVnzq0OjDr9hgY4xx6v77t9CbNJXfhFZr6WwkLD
 4BSED7IdNmKyKm471N18nlPH3pOkxeQc/iQn8U/GNI8mBl7m5MURytDjYaKljWNA8VkG
 wB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735041; x=1759339841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01ZOc4BKa2jNYsiKE/FtVTFT3ErOS4ymhecqLqiMBww=;
 b=AzRf9S3xHjY3+JzeGzkiHicovJVyZ5/HGahFKvdZ+gFvcthct1bVqagMIv3bqI/Bh7
 ZgicEgnPvpMFiK8PyiaGatZ1njeIUXNNlbzSQzLiHblbDhzhlMPQyVnF5/d9V6nrsHRK
 0IsH0eg3mVH+KsJmWHhPT56gv8bKDlMykFzC7i8j5Gds8AvLgCdd6g/qqKFMF04wFdiD
 rgUcgauOVtbfH4IPdVhDWyvaLSfvDexfrUsrpM0dxKrvkAxNr5H5CpVByZzCQuLiyAsc
 Tcex8sbhc86e6hYkdrVXPqBZQHYB4QQqtIAJuvUaJQbzRNWP98pYI15IFUQxLHGJoR9h
 gjcQ==
X-Gm-Message-State: AOJu0YxzTCM/eVpuEcnNR6VANqwm2JrJFiRnnflR9YESyORedlwRd8j/
 I1eZSl8kQ7ZrMZsy/EJEgdnMUMSlv/bX5BYzgvbWOeFIDQm82oG/iHo8fydHbF/d0QEXxj/omR6
 z5M517xuA4g==
X-Gm-Gg: ASbGncuLA5mkOhFYtEfl/yoO+v/hJyn/LqjYtexu2rnO7IFdtMIAZ6c4bkWvR2u8bJj
 2/yK7+Yu0GjXB8Rt5Z7FGF0qBn33jkmNJtIkxzd6YomnueYAJoGTRfwRyu4WJ/OaBDYd+kyCEy3
 N+c1GVCeBbmRQinmbVHgmkZnzXQVTDr0BwoYW747B3+2pHajnkMjl/MMSvDJBgPF/DpJmks4VRk
 +iX6rdq/zctnAkVGf6LWIu/ebndSnw8bvTcue87T1xpiMvZU7gNEOT3bKzi8lMaHWYJAyChoYY6
 kePGIdaqRTEBVh8G8AyM0CMK+pqImiXJlBBQI/yc/kcoJyrXVCoQZf1QarH0+MIQpowxuyu7RA+
 rskE36NLRo7eWlcpBAu7AY0EzfVOGEZh1vFk1CCSPbQXx1RRlbyOWsHaIci+RG9FjB6scX0Kc
X-Google-Smtp-Source: AGHT+IEB80XlI7XMcmC7dB0vq+Tq4gZ16YHrlSbjKKLbhEKT1IpbbSmjtxZQGVRYJCfS8//HcyyxTA==
X-Received: by 2002:a05:600c:8b33:b0:46e:1fc2:f9ba with SMTP id
 5b1f17b1804b1-46e32a0d5e7mr7099235e9.25.1758735041569; 
 Wed, 24 Sep 2025 10:30:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm39249895e9.17.2025.09.24.10.30.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:30:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/ppc: Have gen_pause() actually pause vCPUs
Date: Wed, 24 Sep 2025 19:30:27 +0200
Message-ID: <20250924173028.53658-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924173028.53658-1-philmd@linaro.org>
References: <20250924173028.53658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

gen_pause() sets CPUState::halted = 0, effectively unhalting
(a.k.a. "running") the cpu. Correct by setting the '1' value
to really halt the cpu.

Fixes: b68e60e6f0d ("ppc: Get out of emulation on SMT "OR" ops")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 27f90c3cc56..a1a97e0fd2e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1985,7 +1985,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 static void gen_pause(DisasContext *ctx)
 {
-    TCGv_i32 t0 = tcg_constant_i32(0);
+    TCGv_i32 t0 = tcg_constant_i32(1);
     tcg_gen_st_i32(t0, tcg_env,
                    -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
 
-- 
2.51.0


