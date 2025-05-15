Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEFFC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVoN-0006Mn-R7; Thu, 15 May 2025 06:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnT-0005Hg-Fc
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnP-0008Dg-3l
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so5860955e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304792; x=1747909592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rwfPuBQXcGtWoJn9msWHbhqRij5/5zipndMnWAXWLc4=;
 b=YyD/oNacMDuPvqMAqJ6jlXT6yc/CvoidJjafXtn7Ho7a6+kOh2egUyN4KF6LzOaMmQ
 i4Q2eX4XtRzTo8ItKkk4xcuN9hTHL5ZhBM7kdVNOwFTI1xRJqUAbfs0Bh6sr0nfqAPhJ
 lvLDZia8U1M+xnfjhjRON4RkZNoITX/Kt4PlQe3+L7EnpDMUSmQLSo5EptF1jT3pFslr
 vttcLHIQXZ8FI1PHA3mNTH5cMnQRjzhdPdUgTSpvZ+pKifA04htPo8fvQSQn1uqv2qtx
 98PAywuJWPF3FE8IO41qafQihKK2TdY5b2bhcdduDAB+n+ud160BwHQu8b6wrTnYf7fK
 wkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304792; x=1747909592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwfPuBQXcGtWoJn9msWHbhqRij5/5zipndMnWAXWLc4=;
 b=ONxKDMx//RYdoZNeqOlAqtyuf1R0BsBihaXmrGaKErCi4y5CXEVlHSQj+535BzqAue
 YEP1ysIo+yzt9YOwrgZUGSZpV7dMnW6IL1VgVdISz3zm5unsKTjDSmtAB1Jz3k+fwBBm
 bephWNqaYm8NGjnVZumW/2QKJp16VkvYwDkgUvEGO0RzuFJB1TQfHEKgPDJV1lB398bE
 ybH+7a3oMbIURB/AAcPvVEJwifN4kMnmOkz4npYzPT37tEOihQp9G/38F8Y9fqEUOhYF
 NQWfLwRwvMz9X3+7DvE3jjRvUslxpN66od9hHs4Ex4pBdjRPcM+eGR7jyFrzSUH5Ll3z
 fiLQ==
X-Gm-Message-State: AOJu0YwC3JB9PxTggBk+C00JO2pBcfAa618d4qL9QY3LDO/53oIZL5JS
 PmZANSd60uSb3/XEdXa1aUHqXxGdf//J+ZnEVms5cPPDxFxodKDvClnm7UAoy7TYdKtrf9tZa4t
 5r3o=
X-Gm-Gg: ASbGncuR0pzMTTesn0wnWdoa+gVXy5Lw4Ig7VDH1cQ3RoegkjAijrE6nLgScjKY4qX+
 wr5pbC1Is2sMKyhKUnzGYuLasDreyQ6JbapZGdmrMpS6NZ3whoXpjTlFe5XrW6iSzCo/nlK3PBj
 Z2WLO3BZ5VzKLrCeHzVGQjOvuNg9cKybRZoSOFjeyFRLaXHkenetn7YSJYcC0FHy6qWxCToARA9
 0e3z8xWq6rA04ABIHUCEOns/l5sWQFK+XCwtL+QHW9a83G0M5ex+kTOKlL44LtPlLt1rx3imRtd
 UfafRVjHRYqIwlaKR6d/nEp1Wc7wA59O/PYATMfVy0xSY+QD7nuzktF7Rg==
X-Google-Smtp-Source: AGHT+IEEs2DF1BETNK6ZLUgGLusc6hRdnufw7UTm0i5JpFhAyWm5DAAFTNF/iPitb8R6e0pW1aBDAw==
X-Received: by 2002:a05:600c:609b:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-442f20e8c4fmr62358485e9.11.1747304791881; 
 Thu, 15 May 2025 03:26:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/58] target/arm/helper: compile file twice (user, system)
Date: Thu, 15 May 2025 11:25:21 +0100
Message-ID: <20250515102546.2149601-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-24-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


