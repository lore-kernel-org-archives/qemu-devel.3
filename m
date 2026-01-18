Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD80FC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauQ-0005iT-Jf; Sun, 18 Jan 2026 17:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatk-0002VH-NY
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:32 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatj-0000ss-Be
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:28 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a09757004cso33074525ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773926; x=1769378726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGBrEuQ4ySeYQyQaMh9vioeyRGMPOCdt+8viJgwwXN0=;
 b=t+c/9aBw6AJ/6eKJUAIsn78GUcH4U2OIE+hDFM3tMzj6QS3dWQEG+SNT3NlRCXFIAB
 QPfrhtymzkABvgWgmTlCepL9sSI3AqsIITzbDzE+JHwjzFNr74uZ6hX0CcA8C8nY7LxO
 xc16+dR4OqHtNDbjGrOonpaxeZbuxQzzZZFVdoxC818e/L5InyboSmQxU+cL2+/ytyNC
 6gb6+nNd1uDATRD+2g4URqu9aOZCxnNM0+yJ6X4uLc3mbha8PJnlKfStmwhXKSsr3stS
 kIfLsC/N2e22mrSOXTPJibWqMpYgW+U8hD5pTvILRclTb7EFaK8GcA+3sw+zuoUIQI85
 2AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773926; x=1769378726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGBrEuQ4ySeYQyQaMh9vioeyRGMPOCdt+8viJgwwXN0=;
 b=bjrRVcvk4+PyrFAORQzeC6NXj4OTZf6+GL3BCKErS2E6voHzGJPT+NCa14crIjR26H
 huCodeg4kdE4zWNTbSYnzWzgMacM/snIub/do1ytYN/Sh9sz3SvHWBfMSDfrTLNyzulf
 IGHjAah9wXrgD5Piv7Bv8iuFt7zaMedZXpDsdvJUbGN0PoExVWhVJUZ45mgYf63jk7PO
 9iRqxeVxUkHg9ClrVbdTd28S+ndotHqUaFT/81RZtvxxqmLpO575HV8lgMktC2nOURsB
 UE2j6Cn2w/qCM6OVh6KIV9WbyZqPRKgyw2X3rC45mSVw+IOT+HBPIsmzBeKgZGVNmgyx
 0LUg==
X-Gm-Message-State: AOJu0YweKnO25FwGSHGINxDoVtXufoKs0TKAoEbfHradcfXND7sfF7kT
 6mb766EMOFTor8pkhA/VYJhg6JSbWrw9y9trW0c6HTvSI1BfwQ4Y27y1T0kO8BqmfEBO6PTJ47R
 2oAeXSmHfTg==
X-Gm-Gg: AY/fxX6pT9+j/0UkmlyxREaz6/TRQrkgMluqNB7CoV0y82ENBzw1/GnX+W/iNJW/La3
 wb717fBoxm7m3V/DQdYxAEziiicc/gPK7/rYEVpZVjvaw4H3l6j7nwDyi4z4dbqIoHXMnn8HHb7
 UTRrokgiuPJjYchl4gz/WjXcgmHExJEAMzfr2HJyYIU7ROPgMOIUmQ8/V6bed98dVLluYHki5R9
 YU9hFp1DYdIJSb22AGWkRuZu5dsOxm3RW1zVEQ2CduAL6gOmaDXvnlkF9LzyPDMmDcCwcGz4tfk
 NBn3uQY20N2rZpAe4Dsbj/JbVnQrowetW4+SJr/rALQAeEkkr+vs0TKmIXrMgEMlvjAhyd9Q94B
 UO5C7R4XtR7GtzL49cwlbzTFR2q7BOiP7SR2gUPd9VA/jmxOkmB05yyn6rW4jC1Tv9XPydRcvKE
 xLkdRvp7h1tLOhblhPwpY/QzVohJoS
X-Received: by 2002:a17:903:41d2:b0:2a0:c1be:f436 with SMTP id
 d9443c01a7336-2a7177c9673mr103058665ad.59.1768773926033; 
 Sun, 18 Jan 2026 14:05:26 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 27/54] tcg: Drop TCG_TARGET_REG_BITS test in region.c
Date: Mon, 19 Jan 2026 09:03:47 +1100
Message-ID: <20260118220414.8177-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 2181267e48..5d4be1453b 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -464,17 +464,6 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
  */
 #define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
 
-#if TCG_TARGET_REG_BITS == 32
-#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
-#ifdef CONFIG_USER_ONLY
-/*
- * For user mode on smaller 32 bit systems we may run into trouble
- * allocating big chunks of data in the right place. On these systems
- * we utilise a static code generation buffer directly in the binary.
- */
-#define USE_STATIC_CODE_GEN_BUFFER
-#endif
-#else /* TCG_TARGET_REG_BITS == 64 */
 #ifdef CONFIG_USER_ONLY
 /*
  * As user-mode emulation typically means running multiple instances
@@ -490,7 +479,6 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
  */
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
 #endif
-#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.43.0


