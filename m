Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD01C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtgt-0005FG-Fu; Tue, 13 May 2025 13:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbZ-0008EA-I3
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbX-00038Y-Ts
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so7384895e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747157986; x=1747762786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZUjAMI61frHwsGBUl1u718eVkak4wUh6JhRLUE3SNU=;
 b=LjFKgDxeOXmbcmlYajA9+glyROi11ehKDqpeIV1Hyh2FutMmIGiDhD1LP86hej9dlN
 0spvGxCtMGD1xpU/B7RCWu0f8DJBP/EMOTBjqhMNxXsNJJtQXFYuorZz5n377w20ah+4
 l/+Uh2MU0Z/pWrAfzIh0xf4NybB4QWZtYXqle3cfPEUdmMN4h5rcB20WEhEQAV9Lf9+H
 mB7VirJ5rqRL3aHevfTv1FIZ7n1ocEuuAjul8aGHwL2iKdJvbauVX5P5vWZqXiNfC3L6
 2D/G/ehZVCXJyWndczz+MekXeUfDFaStGQ0Q0fD7uzFGsQXq5ope0h8L+fuXyYEGN3XG
 enAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747157986; x=1747762786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZUjAMI61frHwsGBUl1u718eVkak4wUh6JhRLUE3SNU=;
 b=TXk2AcQbLzUkPrfVfweUtj/aawNWtoIXV3LHt9Hs33KiXC6kNK3jIppDp/4HAH1VKF
 WkQ909xNy1KUXTzJhKwChYQEK79B63fQlvAhp2akrsr8somQZpFc+Arp+87Hqil7WB8H
 y3EPjjnv+r4DnWwk5ZgMotB01tqX+iJkbKvT47Wx0FUYl6sBo5LivbCc41drE1gRLTW8
 Pm0PGqx9pLogKm9NXv38LyL5odMFzvRBa+CvltdhuBrwEDgsdRJzVRSzkLGBlrDT7hh8
 4q1splycFn3n7tTA0AjpBFvovE4kfqvc97kGyuXdgtzYagsfQDkIUPBpwg8KyqdTQPXN
 cB5g==
X-Gm-Message-State: AOJu0YxTz0K8Itfbm6HVPP47oldyoJbeLM1u0Uo46DMYHz7gXg98rLIU
 0bWISJkAwoXXl9C8RCJA4F11DKs7yfQEBbWYseiUY4/rEhAw2lk5C6JDkQgx5GoF03WEUDRLV7C
 MpHw=
X-Gm-Gg: ASbGncsDk5jlm8KaDvwPlI01tbu6amvM1QyBgPkYSDgJnq4RhRbMlki4RIVO2m63x7F
 l/LHYo7fW/HQH3NV2PI/HP2HA8DZzuHBuZhY5B+DN3eJPWo1ouXNFYlCLaquZuCbpUj1HdPNoKo
 WFtH4AHc2wuIJpUFaeLJ3z4KcP57JRYwVZXbCI1j/5xON49D8ARI23qswgl0f0zbFAYnlK1eG5c
 kGJ5JnKg/pszDf8rIvEKwBwl2mom1Lf6WQD2M5tNxXOXPZfRFw6+kAkb6MKzVQqjpCyq8jbCVpN
 mVcB6u59+h5thodXz/l62F/NSoBOX1sQAcr+TiUAPK7uxM8phrrxrtRgEUvlJfo2li3AQlf29NB
 MQzzsxnLw9O7Y0W5iTlgnSpsDf0te
X-Google-Smtp-Source: AGHT+IGpdJ04lqoDlMvqxaaMQbtzwJyZqp9yNJ2Q0v10AbgjVoG9l+UbH8ogYhI4L+i7SMICme1Pcw==
X-Received: by 2002:a05:600c:1e89:b0:43c:fa24:8721 with SMTP id
 5b1f17b1804b1-442f210fa5emr2720075e9.17.1747157985932; 
 Tue, 13 May 2025 10:39:45 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd32f331sm221365035e9.13.2025.05.13.10.39.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:39:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/19] target/arm: Only link with zlib when TCG is enabled
Date: Tue, 13 May 2025 18:39:12 +0100
Message-ID: <20250513173928.77376-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Since commit 538b764d341 ("target/arm: Move minor arithmetic
helpers out of helper.c") we only use the zlib helpers under
TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/meson.build     | 1 -
 target/arm/tcg/meson.build | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2747f4b404c..dcba4ef3792 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -3,7 +3,6 @@ arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
 ))
-arm_ss.add(zlib)
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 2d1502ba882..c59f0f03a1b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -56,6 +56,8 @@ arm_system_ss.add(files(
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
+arm_common_ss.add(zlib)
+
 arm_common_ss.add(files(
   'arith_helper.c',
   'crypto_helper.c',
-- 
2.47.1


