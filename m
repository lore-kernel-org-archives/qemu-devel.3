Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C385C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57c-0007C7-5R; Mon, 05 May 2025 19:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57E-0006TC-6p
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57C-0003fK-DL
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:51 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223fb0f619dso59394825ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487249; x=1747092049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUmj3qtC0Uxjt25GgPIz4kBx9RjJCUcgOSDgbgc2pqU=;
 b=Y/ECvq0DobgYWAylUSEDhXssxR28f/eA3UlvsZGcgqg4RgZL2I61lmRboTzpEw+/sa
 vs0jZl25JvwyRVGF4b8sjM6liqtcDpLj00rt68eUhdt/E4tbaGcBZ/yGjhPYwMAqZC01
 pU9iKrERuK0gDxkLE2keArfRefsG14UJswNbnbdYiKFrgISZczwJ960OVmlzGZpq51Uc
 vnzfdsBIbWZLvIO0orKb1XzQ/cLxAzFJuRXC+sd7TlbyyW8KV6CVheZXc8jJseicJuVj
 wZ0hT4wBxe4O5CUW5hQyl7qFM6Y8rvGhJx8KvmdoKNuO52w/c8usuqZoUrtTZo2I6WEd
 4DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487249; x=1747092049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUmj3qtC0Uxjt25GgPIz4kBx9RjJCUcgOSDgbgc2pqU=;
 b=K0d+lNpBv30CPnlivTA+p/q0CRzvUa9LEsuhkzCJpkIXFVT39KRUhC1d7qEeliBKol
 TycBpi1//uKEiN5un8kC4syyBvVZEe0BnjnLaroYuvJDZQuUPhKKQ16fEohxA6ajQFLM
 MMYC7XqEC8Ca1SonLBFEIcaqg96TuWTjnmF5FEGGcWd/fLMxtwdGZjL32UDoOgLc7jIF
 5xTVthzi7VHM7l9XMG6ooOasV06WcvHl/XreNRYP7g+7OBSri2yGwvgHjbzmgMMwsjqJ
 ZGAYoGadsEh2RgrhOTitv6m59ZHRVlRajCGlv9/6ObPvQzBDHMFIBlxmHDX91V81cznr
 FItg==
X-Gm-Message-State: AOJu0YwSNbQr7T1Ipj/8HSaCAAsfV6gGn/SylASkDGYQ5VLr+iL/o7p2
 xLaTOdttYVVvcYnXEOpkvhDoVjYo+r/HRa2vICHUtxdW/09QZW0x4WPPSG9VdSx+EeUk2UEDj6c
 NVz8=
X-Gm-Gg: ASbGncv/NGxaDKyn+weh1U1lZ6UaWOmKYWltyrB2x/G9of9R0f0hCyIBxSmHy8v1Bkr
 VIZA1EPdY9d4AadmqLNAfL8rhksxmAF32WZK7YpYkZ2WpRIbmqOU23I7ro9b+pwQFHRLpQeK4Co
 oN95nBrb3/vkIiaMMDG1spXDOw0Chv7EQzytXuhrX6h00INs0vwpOC3gBVBNX6w0gdYBwSfydpc
 FgAHJ1WHsG/YAkgHIRMbTsA3nb2t8Z2bmS+v4FgYhMcr98IDSoxUrrBiNg95/BKeMm0CrW2fNrK
 IKngbtrmF5rhQyS5v8doKJpdawpyNxQB7vevIcAbI8+OrQ1q2nI=
X-Google-Smtp-Source: AGHT+IHvuVTEdPuucnAVpdGG4ydIM8fLCmaTsPKggUPfKTAS4sZirTPdaGSJrLHEw92uhuxYwBNlUA==
X-Received: by 2002:a17:902:ef43:b0:221:7eae:163b with SMTP id
 d9443c01a7336-22e1037ecb5mr223727865ad.46.1746487248943; 
 Mon, 05 May 2025 16:20:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 32/50] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
Date: Mon,  5 May 2025 16:19:57 -0700
Message-ID: <20250505232015.130990-33-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

This function needs 64 bit compare exchange, so we hide implementation
for hosts not supporting it (some 32 bit target, which don't run 64 bit
guests anyway).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 26c52e6b03e..c144516aaba 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
+#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
-- 
2.47.2


