Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317D3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNrQ-0001gr-HP; Thu, 03 Jul 2025 13:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNrH-0001WP-Ti
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNrG-0001uX-7J
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4530921461aso1053435e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564184; x=1752168984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnRok8P1GZORflX5U1xcTlyERslFmJh/V5NQp10XCjE=;
 b=vip2fofLG2oL10kpuEaWJ8FbbQFC9AyQUthcULC3xC4WWisf/EajSiFoZmTo5BwKyI
 olQfWryjvhMyHn+7ZBHA0JXyFueLsjjyfz4iZnqEbWLvKxxgNkesbzSjnPj6EK717dgH
 EPRj5Av8E7zetU3scda5ivpp+iR15B5FkolGKVzoHd9BlQug2IX2FFPWta7CxvC+Iwty
 33f6hb/txxUBGZr3Ue3/KkODTYavJrWzMcsdZ88ceBszi8e9sUahohKSruBDDcImrOxR
 GZ5v2uZcYiKClSl5vMM/MCPyKLGdXq20PZFELOf9qynE8QgUGC/LpkuhOX4yJJ1KGkhw
 PNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564184; x=1752168984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnRok8P1GZORflX5U1xcTlyERslFmJh/V5NQp10XCjE=;
 b=ijdh0sNE1GC0P/nQprd55zlo3vEBFJGyV/hoOHG6AEKGLANfo6W9Y0dTYUCSNdL/gH
 /QzuV6HifzttI4l4qCQMn2pi2tPO6Y9dc3pItitR3lwSuk4MTr2LalNK8USrIoCvtC9B
 PG/o0pfHrkxWkdfbTkLFhwdYtbCQOHEhkUqOWd1TIQGmeEOqgkZaysOdtpZUkza4W4yR
 FbGuQ2NjFCfG3tFMQO2tCGDzt5rrz/NVRtDIYY6hMGDZmZHxdO15dp3ngFONki3ZvAAU
 YqBZtwxJARnvLrVsasIvQyBmlGTpKvwkm0bx6ATH5nQ992OPDZtjrRU7l1dNL3iyJ85d
 Pesw==
X-Gm-Message-State: AOJu0YxU47QWLcmo+F/MPOnfe1w4rjF0TfK44nfUPm6L8p+69aw+xEE4
 ZnDWxt5MMdhBKR4dYtktVroeT4XuVimSVhAokarML1XSGebKb2LyaK4wsPyw774i33MLnioCvtm
 3gDwQx5U=
X-Gm-Gg: ASbGncsCE586GDBsW3OWX4GPmjBKwrsGCjuSKpUYqbov3fkhH2zEagtCh10fYffQsBz
 nUBH8SxdBI+0TMdPX19NZbtrahppvUDTCyKYPwacAu1s4bQgjXZnxgrKHD5HvOqAF6xtMfGERa6
 TUMmPFcVvibsTYNpa+20lCb/mzCp9YKo7BLRauucH2M5263pPxVW5wtIO1wg7cppylWH5hlk+tH
 Z94LvgfzbMpjx4/rPTz1dkNdxInWKa6zAZTvXYNZH6xLtwC4rsWJ69pJbATiRZYy8YPi5tVFeap
 3uRkJ4F2HbvGPINCVKD6+LnKCFQLL0vCWcjyGv2p4M2qplAR8i0n+wBwhojAX2KwQUtL1oXJ5Zi
 wuHQMk5xx2k+jJncJiJkMk+HSL4i+UEAUe11P
X-Google-Smtp-Source: AGHT+IHqzIqBa/MN4R9Ht+M1b9yL2m4HQ3sMz0FjF3tQ+fZTXi/VewkUnXtw8KNc2E7SJL5j64qIRQ==
X-Received: by 2002:a05:6000:2b10:b0:3b2:ef53:5818 with SMTP id
 ffacd0b85a97d-3b32c56dce7mr2910128f8f.5.1751564183961; 
 Thu, 03 Jul 2025 10:36:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997b492sm32407175e9.13.2025.07.03.10.36.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:36:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 39/39] MAINTAINERS: Add me as reviewer of overall
 accelerators section
Date: Thu,  3 Jul 2025 19:32:45 +0200
Message-ID: <20250703173248.44995-40-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

I'd like to be informed of overall changes of accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3e08d4607f..a8bf3f9ccfa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -495,6 +495,7 @@ Guest CPU Cores (other accelerators)
 Overall
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: include/exec/cpu*.h
 F: include/exec/target_long.h
-- 
2.49.0


