Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390D7CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE3C-0004NN-6u; Wed, 29 Oct 2025 17:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE33-0004Ke-5Z
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:49:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE2t-00079B-7G
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:49:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475c9881821so10021275e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774561; x=1762379361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feo8FQEGOqzAXoyKXsNivpWnArCzPABZfbbNYQk863w=;
 b=byQmvuuLfQ8GP5CNcW964E3ax3bJMxGY365lNcKumH+w7T9iXD7jo1J5p3z7KxFfUo
 woNbbhCc+BLwR16V4bcbsg90K2GJgJ59g4nJ+eG/wtg0BXGvLfO3nN8brO73Sa+4Gwp4
 phpj4ccI28vHNzIlPzKyxCi+zRxQwDCizqX01cVZT0byMEF+FfSrye1gwvWvfv/nUcG1
 tnvvSXjtXuZqgMviC9AlWEGZskpN3rykjk8Sxb0BNsP/SmTFloUm1w/0oFlEqFd37SaN
 5MtXvSsHrwlRWUiwlGXqEE8R9R5NHnlujwOEDamMk/wDun5v/PfERPdI++TEvHGq/3Ae
 oBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774561; x=1762379361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feo8FQEGOqzAXoyKXsNivpWnArCzPABZfbbNYQk863w=;
 b=qDFTljGRWWBz4Sm7J4HLCQ3L4/sO+NLEISffwS3ZcSkrwiawiV+YczgtYeuq1r9cx2
 evOyn39D9ySOC0B0b0r2o6heyyyk14GzfLhtHO+DMR2ZvRdR60Qz74KBETV+agCXgKbM
 R7F7z1SYaKsORSdogCVFY6lgoufIMOV/lnRzzJH4St8nuFODHZKvqnIXVd0tgaNCQeUT
 gvB6rH1vSPb/4hrPV/uY3qpNucg+s8vs03jBGSA+47PfJ/XUB9Oe1pq4rLT2yRdUF28q
 1NtEi/MirIJ+qqA8dqGwJZDkdGqUADUCTch8jCkr9mhI5tfegoWn8l55FWPkc0i/hklj
 hAEg==
X-Gm-Message-State: AOJu0YwEseFPHqDi5ayoV23oCF9JjMTNPUiREZAedII8rC7cg4DCOx7D
 xbgZrRmXwXCLuuyGHA6HfTPv6dkn5LKzrUcvpWq6sR01MNKSEwYpAWskhY43EswW3m8/zU/uCyU
 1/vzWH8Q=
X-Gm-Gg: ASbGncvzQg3CdqD/97UwPfOgowOy5QdA1WwPEElcZ/WXp2z81bzPzP0zvo5j4cYhMqg
 7ELLtJCyhGJVekGLQcqoaRuue1m2lwIdNKaN4a3JvckD2d9RibcUJ66BqE5oEmBCN5xEkvUFKBj
 tTxog3pBusICYiPNnucK+N8Y9yZWXK6fUZfXS1Xhbn5+rwp14B9nztJfVhKeENzNPrFj6lUV4Wd
 vjaml1b9OZsUEarpyOXGCXGT4lJyt3S1D31nyMJIalcwpV+O1Kx0i1bP/pEPPH//JI3xf7Us+32
 m3wKfJinAI4H4hnfxcZfDTQuMuVJuPEmxUnjid2hS0nUyFzRO5G6o4F22l8+O2ICp7H4rCs0ltI
 So26xKLe6droqwTPUgXNApfvI6OfhCiQkLYRPOebCBOel5Pd1QT0U3B8vfgAvA1elbTFyiYLDPO
 8sFB5kn+W7cveNzd/huX+saNgGJi0Ech8jKMIlIzBRiHUzt+naXw==
X-Google-Smtp-Source: AGHT+IF+4/nFuvC4cJuytWiWe+H7AZ4+Eyp1KQg0BMmif9wXeFHWWHlo/AvfI0PJ99gtsbJeXZhSfA==
X-Received: by 2002:a05:600c:a4b:b0:46e:6339:79c5 with SMTP id
 5b1f17b1804b1-4772626120dmr12343685e9.5.1761774560927; 
 Wed, 29 Oct 2025 14:49:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de971sm27977643f8f.39.2025.10.29.14.49.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:49:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 09/23] qemu/target_info: Add target_arm() helper
Date: Wed, 29 Oct 2025 22:39:46 +0100
Message-ID: <20251029214001.99824-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-1-philmd@linaro.org>
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


