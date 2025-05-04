Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5D5C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvN-0002SH-7K; Sun, 04 May 2025 01:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv8-0002CJ-0H
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv5-0004OP-DY
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so3889978b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336582; x=1746941382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=pAsyKEMxHodw2r8o8B82dcPgo3eLFWBzVwMRMbTh2YANzAKtReE+qsNpuzMJCLXj5f
 SfDAVzyDzpWXvqhKQUBUzhvyIqS0v/+WQa61gxH4vwXzLXs15W/msP4ctt9wJULNqmjV
 XiidOCYKkQlQZdcw3cr/Ht9aBMBD9KwW0/+TfwES+Hp0xEc8mEIwmIoCaSuKFUSTVAak
 mev+ukdUF+celpVlN6c1mpWZqafUkDc5/j2BDim/SKHIR7ROk7OKLLx/++ky5bSrT6BD
 OD/hX4BmbhhwfbPeo5x0/ZruRRHJ4+bbw49znq5f4MtBGfyuDNo7NW1xWLhBI7TIvPnA
 z/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336582; x=1746941382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=SHeopB+RWg7GmNqvctA5/Efnoj9yLmfRqJZ4cvpl3nA7QdULjhgfPYi9/Lz4LhBp96
 aAlqRHjaVL5kPdxrnYbcLXulAZfR4utGE56FBR+Te/gcrGU1Q/eib/qBW0BTLF1pyUZO
 /58riLBzlnxsEmm3HcwPE06qQMiN2BPefVUNHQ4UXqtaaEnSW1tP4ruUOyHyei5daRKi
 XhclsPbmOIo3MaFzkOyDu2P57xnG5u9YrlS20qHxy1ApQX0jQLzAX/BBiJh2mz/QSMm1
 NrFy1QOU8wSZ49PwWRHRu/U2mpVvO4LpfdoieP/OhafPYfSuQVPAHTNan7/UBbAI600V
 lsiA==
X-Gm-Message-State: AOJu0YwH2g1vwUdFbTzTlZtpqjlqSC3BtwO7iWElz3marcdYECMXCdq+
 nVvpmk0iTC70pZOc7Rhja7nBdlpYH9QnIMVqBXd1H8M7DuK39CpUXDMZS4WgVjtpolQcMIocsBX
 O3JA=
X-Gm-Gg: ASbGncs9a7WGCttCGKmVbxwVSaI6oNtopCk9LM/8iI+u7SYV8tkec1K5Pb27KwbWCAe
 kP9Zi5buMYxi1NGsJN6EWGox/pA1/BfJLID+XNq9BChC64UR8qvbo7C/Lk0MjgphtWAR4kgxbQr
 sMuJiZNjSQRzq8plf3LtwbkcoMyRi1bxPDJ49wDtcoZxVftyLadScj9I/uUGjh+BShWSFH6Hs3E
 g0sghUN96K/ByIIKJsboI2dbY6aEWhw8FLeOVXQVAvTbBLjM6C/eT4gqTNZPY1aRvDfBnIjxZV7
 QyRWVqUki8ZrR28M4i4lEjy0tTfmsx3oTL5FgtnX
X-Google-Smtp-Source: AGHT+IF0vgFiMAHdZTdTEbIL7XDeL5ZCJrzUL1LmXrsR2TgO/FrRqNsHWu2PRmIMZQhJT89uq6uwwA==
X-Received: by 2002:aa7:9316:0:b0:736:339b:8296 with SMTP id
 d2e1a72fcca58-7406f17a52cmr4455342b3a.18.1746336582061; 
 Sat, 03 May 2025 22:29:42 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 25/40] target/arm/helper: compile file twice (user, system)
Date: Sat,  3 May 2025 22:28:59 -0700
Message-ID: <20250504052914.3525365-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 48a6bf59353..c8c80c3f969 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'helper.c',
   'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 ))
 arm_user_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -39,6 +39,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


