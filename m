Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC319CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyAA-0007sM-9R; Mon, 20 Oct 2025 18:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy9x-0007iP-E7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy9t-0006mV-7P
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4711f156326so35792515e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998515; x=1761603315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3tbfCKWZubrwcw3IFxSwsDjRtMvhIESY0jvezMdbaU=;
 b=q3tppfVTExApIizgE8DLzboidJ0qwQ+vfzyDjbtbC5k+pNny8PmmkY1O7h3NUkWNSx
 sJXywnS7BXjFpBvNIVzmUVkjQBsRkNKovI/KoGnLHLSenbmZjTnV5RKRlcLfGKcWI1pO
 VoLo8PMK24tWdmXrO6gpOSzK0bAzUmfGspEMygMDCqjk7/T+Jfpwo2KFdlHGV+ourLMT
 ummwPM1lHhxqzAFek+T5Pz6BPzuu9+E7vaz7i6ui06GvJwlqYTPGULaSynNCssDB/lPx
 XYX4A/yNAhICSSk9oN6SaNR/lYrAH0khEthNOc2/pLx0IwRwI2uoquRCHbbMWcMNy/MK
 gFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998515; x=1761603315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3tbfCKWZubrwcw3IFxSwsDjRtMvhIESY0jvezMdbaU=;
 b=T0wvsGuoHrW7ZNNHS6jPBZLZC2sezUI1aVie+T0CRX4slt4CNFBmKE2/Hcdt/Ebbff
 ZmFt+x47lFOvO2FuT9zH00apycvTEKS2KXajZQgwCNYGDkLEMP+vRuLQbbybl2E29zIS
 tlFZo9kuHFT1QzKHZfVsmzyIZqcHL8sRpL7zlKs2v28f+MOWD1K0Ed4cBJ/RmFS+rUyf
 H3F1vCA1KiTbLWmHNk96abADhJnNlsv0oHVvGGhO58v0aNgBpd5opJjrOhkYL+cP1WNM
 FaE+sTXaCIYNrXxkRO9ZsSDhTHEV5JUrwC5SrfVORmaev/KE41X2dTsAXSWI1g/zyWS0
 jquQ==
X-Gm-Message-State: AOJu0YxfDa8N/KRam0Un4pW2QqGlduCWsZ7HHupdnH9b+lwa52hdT6d/
 zQynyJpecf4gpRLA3IRlrYy3PzTOft6/74sVDiG58gyi1eJdSIlztP1mm3VUfMMqhwcPq8PHMN4
 u2I/9rl0=
X-Gm-Gg: ASbGnct/pGZX43ftfXyiu0tL4I+Nm/++53KDKNY3zv8yG7SFb5TnO9dSocORdSauEQ0
 Y8mTfczoVCGOSIGuuKwz7y1ZcbQCAwZc0crqWxN4962nwx51nC3HsYyuC3SxclfEsrfMmUBKGZW
 S9lVcbNMmcwoIqsKKL3Y6Gpo2bxV0MClJavcaWYLc7ZOx/n6XCyYCANNd6uhvI9WgCQEnXXDFTv
 q99P6cqFmkqKRy0Ij4lcN0gnDtTWZ7B6dt3SLoQCaTwNL3uF79NczfV4mcpZMW0w9leeJcnW/4K
 YmifBu5p24HxXnP/CNDnS/LCglzSwqxBpR6OCMH6GeySMaCuECWS9ObrsLz3j2988m8aKOqYCFT
 Sc2fLOkwEB6Ul36GnGCCr3AzjMPFqHarExMv6Q7g5SWtVHLrBy5vy9jNT+cuScwMCv0kTI+vslX
 XsrLqiru2J9L2IZ5mDny3EZEN83UU3uTXr5p0mvFTHaPdXVRA4tQ==
X-Google-Smtp-Source: AGHT+IELRuCwlidv6Q/BlcxSZo6p8VXX9a2kyVtBerqCKc26xeUQUjvA4avM27vV23MWNOExWIAOkw==
X-Received: by 2002:a5d:5f82:0:b0:3fa:5925:4b07 with SMTP id
 ffacd0b85a97d-42704d74f9fmr8879587f8f.18.1760998515313; 
 Mon, 20 Oct 2025 15:15:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c56sm17459246f8f.18.2025.10.20.15.15.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:15:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 17/30] qemu/target_info: Add target_arm() helper
Date: Tue, 21 Oct 2025 00:14:55 +0200
Message-ID: <20251020221508.67413-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Add a helper to distinct whether the binary is targetting
ARM (32-bit only) or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index abcf25db6fa..984fba3f42d 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -50,4 +50,11 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_arm:
+ *
+ * Returns whether the target architecture is ARM (32-bit, not Aarch64).
+ */
+bool target_arm(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 3110ab32f75..40716bf4051 100644
--- a/target-info.c
+++ b/target-info.c
@@ -52,3 +52,8 @@ bool target_big_endian(void)
 {
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
+
+bool target_arm(void)
+{
+    return target_arch() == SYS_EMU_TARGET_ARM;
+}
-- 
2.51.0


