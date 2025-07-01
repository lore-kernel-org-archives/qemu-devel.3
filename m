Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF80C8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAE-0005PP-K7; Tue, 01 Jul 2025 10:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcA9-0005Is-AY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcA2-0006od-On
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso3671379f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380836; x=1751985636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=phd9Y1Fw+50z9hl8A7dLKl/9Rzh1708BZdlXwjJrDmTk03o6HMhhSFxrGOjjbCsIUH
 ZKLwFTv1hWdAREjznw8OWEzOD8pyVlVtVVVeLlU5Omik03an5hoqNjjesY9WYdyH4GAG
 n96XC3SVh0hSSzTwgXEmaemSgq4giXmoEihHdp3TSnrGS92VM5t9niKxFO9Lm/Mo7itI
 jRQUicyWZxFSHITKftp8582ql1/nLmaN4qziPkDjmOmsO0JVyzXbsd/uLxexOcUzuTiz
 b9M46kU9EVROIdjYz/6BgXG7lJha4/jMk/MaI9dI4yWsRtUpGoh00zM1/29qsp5VbkUA
 19sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380836; x=1751985636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=abwzlyOgFsG0ggZtFv5VRWiDuRUY2iTWJ9JPghwWHFAkqfQ1I55ivNc7tYTUbXhsiE
 TlBmce3PJo482wp7xU2pY5rN/seIM39h9hrr86D28eTWNg6KsTYvvr9RYoVKkWF4ylHc
 DchB0OV0w1TWEuvUDAXV+n04dzqPB6Zw5mfPJYkVh3PPzWm1c6I8gsA4Ih2LtvIngurA
 10Zjb96TVB/AroxiW7h7zTdy6j8j+uX7ja0clJna1qdjslWb1WcD2kcFZEAo3kVOUFv1
 D6bJygOvdbF8SrqI3RjUuZHeYDeL4rQ0Dngbn8dm7pF4ARo7ckuQNI0OyR2O1i9X5rDw
 xQ2w==
X-Gm-Message-State: AOJu0YzHYJhEjHYg4OZqP7q1CXlOnom//wnxm4naOLDLcdIc94GxU9AD
 9WJ5v+jz/BkutuYSxl6BUFsKjNDnTVRTkR0H2dJH06Pe4ju1VMZFzqwLwufibBwHTBv7pX6Z9+c
 GiVAQ
X-Gm-Gg: ASbGncurApsj1NTwingcJVW398ep5q32OJldOpJgdEksnYxdndYTE6A28NlpyDQjjdt
 0/NNJbBjEJYRK3oaK0NL3lMcMAnZ4vBvd856iX/s8P0Ag9SRVmAxO3EZpjzF/XQniHkJK0L+EgY
 DngM/BtZ6qjxBAhdwTuKqiiM1WIK6YXMvTQkB8Yva9LsBxGMgGES8TlBQCbqbigAfTpLmdjwW9A
 CKNp5H8XUw7xeOaj2Xk+VfDqC9crAo0Mxc0+elihUx9DMaPAKxtDIJ3GCFFtdx95DSV0nbbLomm
 YBhdsrALCUuAyeErry8xKC+HvZf4c5xuU3dAIcLUJngO2u2+437JeBFaWdYyr55oGKD+YblGLWY
 DFMwYuXyARWsy3ATBln809ZWppzzwi+z8Bepa5vWuuvyynq0=
X-Google-Smtp-Source: AGHT+IEd5vUg/w03uhBBDAOenwTHQU2oznEuyFtwES0uQ3MWZ2MrTrNRZjsa1eQ3Hu54TTLvTb4ayA==
X-Received: by 2002:a05:6000:2a85:b0:3a5:8c27:8644 with SMTP id
 ffacd0b85a97d-3a8f4ee0ff8mr10754477f8f.24.1751380836510; 
 Tue, 01 Jul 2025 07:40:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c523sm196800395e9.6.2025.07.01.07.40.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/68] system/cpus: Assert interrupt handling is done with
 BQL locked
Date: Tue,  1 Jul 2025 16:39:11 +0200
Message-ID: <20250701144017.43487-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 --
 system/cpus.c             | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index b24d6a75625..6116644d1c0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-
     cpu->interrupt_request |= mask;
 
     /*
diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..a43e0e4e796 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    g_assert(bql_locked());
+
     if (cpus_accel->handle_interrupt) {
         cpus_accel->handle_interrupt(cpu, mask);
     } else {
-- 
2.49.0


