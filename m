Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CB0C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOF-000436-3p; Tue, 25 Mar 2025 00:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNu-0003nC-88
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNq-0005oE-JG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224100e9a5cso99101705ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878765; x=1743483565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MN4UgqEwiL4w4rQY8ucWfe1J0m6eYAX694euQp2wpb4=;
 b=k83ByWI4TFK83qu4WOoJrkbavzkRc8B/ycStIv+HjBMz2Z95RA5SOLZfBUCMuOpq6J
 wsQJLnrz+JlhQ5v1eao1B1pYWY4GY8xpWLgrbqOJAXsiYK9NP4E+IFzvfltyn9Yrlr9z
 O7XsyNbMvbgCJeE0/9dOuXQuhbVKodB4O6ggZqnQQtFKp4i2khm+RtpELkHcul0lk8mZ
 N8IrDnFyxUJy31IK6ZUnt534jZXvmi0f9rT3yB4fHBfHHanNr3PW/6l4+XOPEHz9nmDI
 vfxyUF2X649irwfBB2banZ4/y+7rVhxLDa9k+wwHTn1SMw5+puXzlv/JXph/Npy0Ddmx
 a9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878765; x=1743483565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MN4UgqEwiL4w4rQY8ucWfe1J0m6eYAX694euQp2wpb4=;
 b=twxP6zPSGU9MfdS+zxntX1PvdvTF7tsjx39gL5SK2DzSf4M1vw49SZ53Vqk+Tike+J
 vaZx1Sm++AF8r/GtSVNVcvS1i2CstLYEVyYQ5AolGXWFL2iS3vy9Fvg0Tfi9TrAzS5+H
 sK55nVdZtPhACYuvI84geLO2i7EMe1qtb2yEjaONJhReSOQcCGK5Ukc0NuV/Tf2glzzi
 x2vuzGnb/k/+GQboA4NzfvtkpmlrFiPjX8MU8cSFm1MhGF/bqKVHQvuJR2hlxEEJ88R/
 c480EPpPI0/yEGEQe1uJJTQ4ViBoTx0KSaDvqkI1BRds1bQO6jed52LFmA1MjzaNW0Ux
 tGbw==
X-Gm-Message-State: AOJu0YyyTQj5BXQNGJvuRPOq30YGVDdtR/11EnSXVKnh1mvHp8Wu5JcN
 yCPwhppTf7Rs8b4RUc2eJFGLeBbC5b67FGW0HiAS0e6FTC6s9ryUj1DLqJ9KGzpkOW1Y568Lyhl
 z
X-Gm-Gg: ASbGncvn5/hmJC7GvvxjKtyWsZPtBzaKMI0z/puvB+n1FXUmXftbZGzKnzcRvPB95wT
 7l/gSmMnW5o0kIhw9cWaeZ2PtpqHuu5isIp53GAgD1PBp1qWClO6gQevodG78xYBuRNU9H6BefC
 gytyE37fDxzfXvJkqlb+gVQZv+wBMKAZIGMHwPRnx8CBy1yXypklSuovfEvnO4IfG5i5LgYWZfX
 U8m2yQLSQdEkigYVaxVYD3i2d4OePCYbCSDfoABPE3vX6EBRtvzRXMjyqofIP9n/D4j2sTaHsq2
 DTDeIb9GT1PJb00tf9W/v0eaadkiOmm0Y6fetnqvT4sH
X-Google-Smtp-Source: AGHT+IEhdiwVNCAUxVqAXEujnJe80rlTseAWcro62yNqBId6GD4J1Z8w34u8f/q5GRpM3AW3E012lQ==
X-Received: by 2002:a17:90b:4a08:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-3030feabaf5mr19365794a91.21.1742878764496; 
 Mon, 24 Mar 2025 21:59:24 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 03/29] include/exec/cpu-all: move compile time check for
 CPUArchState to cpu-target.c
Date: Mon, 24 Mar 2025 21:58:48 -0700
Message-Id: <20250325045915.994760-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
 include/exec/cpu-all.h | 4 ----
 cpu-target.c           | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 74017a5ce7c..b1067259e6b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -34,8 +34,4 @@
 
 #include "cpu.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 #endif /* CPU_ALL_H */
diff --git a/cpu-target.c b/cpu-target.c
index 519b0f89005..587f24b34e5 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -29,6 +29,10 @@
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 char *cpu_model_from_type(const char *typename)
 {
     const char *suffix = "-" CPU_RESOLVING_TYPE;
-- 
2.39.5


