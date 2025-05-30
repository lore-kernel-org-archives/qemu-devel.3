Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A0BC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBi-00025o-2F; Fri, 30 May 2025 08:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBc-00021p-Rq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBZ-0001qA-N2
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442f5b3c710so16526645e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609407; x=1749214207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4x+me4Pbg1U0h54ePraPUwWVwk17jQPOnkO1m9j/qnI=;
 b=gsLzFNEQq4pOcZd8xvvu9P6xOP7E2jjLNEhZYxqQove58pbL4Vi3jXUIm1+wOyY7P1
 QqMY75rSiZ7rn8BwzkcoZ2DMMXdhCYZwemSEkiOZ/pwrM3FbeRaQGjQ6eIZikesndkVj
 YjhY4ecScfDIkx3SIyWLtbT3sKhRrLFnlCvGYfmMCEceN2XWN5E+CaaPDTBafRBbC85W
 voSIiWcisDvKR6Vi11iDqaMPohENsiXE7gxIClrSVKkbWh/sJCBX9EmPCTSbpkR/hS/f
 NreUxbpE0h/v8vPgqEEys19VD4nY4n0wYK64MQGqRSdDRmW3tglI26WXmREuyxMhP20+
 s8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609407; x=1749214207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4x+me4Pbg1U0h54ePraPUwWVwk17jQPOnkO1m9j/qnI=;
 b=DggPe5FAwxU2Md4SK1PKv0XCZPZsQZMAFtLimSWd3HrkkIzC+3GsSw5Sn+cPbYZA0T
 uUdJUAPIYpokkwbxNaTpwN6fBKK+gHEpWPwzyFEOk7o4kwL36ulkZloDHf9IvnXbsPma
 gd1n4hIDRDLDolFOA0EVGgS/K3T+y0TxSmJKBrWjFQUnPvC0Kpkx+20lOkSgD2YE4nzm
 TpcVK3UoDghtRcL6b/JWX2zhQ5cFwHBEIEKjZtXomiH5QBdx938zeNeZl4B6JoW2rlbx
 EejGrRnTReVCFLPaR3H8Ve5UoZNRZO3ytnr3TEnEDGTCwZ3qLyKHwp4XHwTObf4Wxk/R
 wmHA==
X-Gm-Message-State: AOJu0YyspzPggeKr1Vgli3BjDRlC7lusdqtf1bT46ivfgSwSEJxZMJ4E
 ynd6KvhLj/jupTJzfkKevIXmy9RDpsow+DaYFs0DZwdEs/H9s8+hSAQFlaRhNCu+RVt1FSCX7kF
 qpoqG
X-Gm-Gg: ASbGncvCLWE+m7w2ST8EPosNjA0MT2iy2RT8V+Rnd5wAGRIVV0tql3lcpdeM/HZfRYf
 S9wWoE6RrGdrF7/zN+XSi39IfRLArRpL+08jLF3uNiMCIcVHWSyxIVZWLiKEAp6WbrWuYmTkjzb
 PTRf2+eCVgStbb7S02Q/UWsmVDKczG7JNEi6xFipE2sbNvODJQF/I2PCZTkd9YBwZ3rS4W6B8iK
 /RFJd51cbZnqUl3Bbt/baRXKGje+HUWyqhjmGVbtKm/jrjD7/XhCcc7KSZqEYxc4KHhsDPrVSKF
 6SqoVjCjcT9QemMSwZHu7WxpZdZUDYF948JEc2Npo04bZ5ftAwDKpDnr6w==
X-Google-Smtp-Source: AGHT+IEKZf2xsXShFX8AJvwMuhSBOaBWh9mvyY+ifM927Ia7aeHYTGGd1xXUT7gdCnU9oiSGKy8LxQ==
X-Received: by 2002:a05:6000:2407:b0:3a4:d8f2:d9d with SMTP id
 ffacd0b85a97d-3a4f7a9d60fmr2309883f8f.38.1748609407510; 
 Fri, 30 May 2025 05:50:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] target/arm: Only link with zlib when TCG is enabled
Date: Fri, 30 May 2025 13:49:44 +0100
Message-ID: <20250530124953.383687-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit 538b764d341 ("target/arm: Move minor arithmetic
helpers out of helper.c") we only use the zlib helpers under
TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250513173928.77376-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


