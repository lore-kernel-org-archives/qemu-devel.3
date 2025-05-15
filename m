Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98895C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVp1-0000OL-59; Thu, 15 May 2025 06:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnk-0005Yn-Du
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVne-0008H2-Jc
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so8059485e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304807; x=1747909607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/5UHyMTmrHQ5mwQcvuo9BiQqIMdODzOxHwcQCEhq1rs=;
 b=n2JhF6fhi+TbjQ7iV0dWvfCz3Y5oJfSTR3ZViNOrqhT6n9pxUHMz1ri1IahLT2pGIF
 wn3QTstsubEUc1fyl/jZxceFt+NVAZ+ONUeG98ToocWkv7OKpP0sNTzalmBWSw/E9p1Q
 xXGSsPAYAbeYDddfd/qCSCkKp7Xlig1yWpX1YGK7ge4Xz4fd54xYCEHtE3kcanL7mw6Y
 NLtyHVUci3h6zZfKhjKWjlmzpogBnjWB8PmYgJ8i8IAf5OA1wDQh5Kpmnq00hzB0+IoF
 ZjfmX6JqMhXB59/xbAr6tT5uHl4ve1OUSZKXYwBa+lG0MDcUR6qc2wBZxZ10lqPRieP1
 iPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304807; x=1747909607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5UHyMTmrHQ5mwQcvuo9BiQqIMdODzOxHwcQCEhq1rs=;
 b=gpBVQkWDp/LFshHTutwhSyxxf4oLA/rCGz1w9vq93D0ng53d8MBOffKtbrNskj8kdE
 WG4JBthyvVtfFLc5nvco7C5yWwnAlQk355VleBvYJAHj+9HR3aJI2JJnh80kOoXgoqBE
 Z7MLGlZsqk77907H2mXF4CY6lID42m9GWfsTXTQWl+5lGbAkfoT8HEkkxZvLtoykVCrY
 AdnFgNlCIEyoW4Q/xnptZ5eKUTmJV+DhgLyMHi9as4oN0MNZVZEigIIeUIsXmquKGGhL
 5AxCrzQa1w+H1rLlWHxNynniMSVsr/8RWcMNqVE/SMl3Ll/6/A866pMPw9ik92e5Gl2I
 cWcw==
X-Gm-Message-State: AOJu0Yww1chtIy+6WKlVtuG1I8uAchDjEBuTEUmFCBFPXnJTRlOnAe/Z
 TwgHTq+McFZqFfC9HuI7WBK+ewi4msl50hA4hHCheBlyGZbia/1irqRRdrsU+SYFz5BuFavo5l4
 KGkQ=
X-Gm-Gg: ASbGncsgpEe/WN28cCygZNFKkenibo2JWCwnMVgY4E5hV2vOJe9vZ6LnYw6UwOLfqZy
 xh7d5JFN7sSWeutQ92V1x5Grfn47jFHPsRk2ICVnIL1rLU0W2G+6qboi7GdW3KXEz/MQDh7KYZI
 kVOgGQN7tfpGV16/XlNKr7fNObrDN6FJJLBxyh7wMLdiFHPOyuKHWO4dvs9urrjrM5dcZSVBuar
 Ls/f14y2DFzckVQR1mTPN+ScMREelbQoo8GUcu71ngLtdro8JYnRCd3OpT72O3Y8wDqn4sVtY8W
 Jou5S80lFKSTmQsN0YyWGmVmOeBFxBoXQ6A10ADOECUsb+NKUKv0tToVLg==
X-Google-Smtp-Source: AGHT+IGf7hZnvOiIN0+4HEWTQOqIW0DMNb5ZLrUxIg3euIQNqK0DQJnsEvXdbdD36PfcI3yybSWGWg==
X-Received: by 2002:a05:600c:a42:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-442f4d44013mr49324945e9.5.1747304807223; 
 Thu, 15 May 2025 03:26:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/58] target/arm/machine: compile file once (system)
Date: Thu, 15 May 2025 11:25:36 +0100
Message-ID: <20250515102546.2149601-49-peter.maydell@linaro.org>
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
Message-id: 20250512180502.2395029-39-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index bb1c09676d5..b404fa54863 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -13,7 +13,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'machine.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
@@ -39,6 +38,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'machine.c',
   'ptw.c',
   'vfp_fpscr.c',
 ))
-- 
2.43.0


