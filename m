Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB47C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWRP-0005rF-Tv; Mon, 24 Feb 2025 06:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR5-0005nj-EK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR2-00019J-74
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso24833035e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395737; x=1741000537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTW+guxKto4jsRU3T6f5JGrwIUxjIeZwYhIwDRM/nu8=;
 b=K5Hi0qCFYPHAdtAcDE1CyPNiaWaTGOsspUfGckBcH3EPKW6lHJiOaE+WgXmaLOixL1
 NwvUZKt9keWtwTzEjOsln/Ci4wyy4qaMm7C42EUfq7j3ms5MqS8h7kZ+4EPeN4aGturx
 6Is70NOY2b3LkCRjyrCa+uhTK0+ragZp5/xTUADV37pTzsNIOG+n980wb9uv/dguQKeA
 1i5Uh+gCfo+x/29/lqXwj+JmnrHZ8VjsDFe8YCnxFTnNQ+NP5wfxd7jxbVrAXgysvT3e
 O5yLyP7hbGyO+Ee56DbhR1d8YwYJHAnwWjrQHMMSS1xETnehwbgvnWFqcNZXy6NcVovt
 zcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395737; x=1741000537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTW+guxKto4jsRU3T6f5JGrwIUxjIeZwYhIwDRM/nu8=;
 b=dtzU+cjHIUBTC7yeGpwTOybqk/J+nvxxkT4OYKpWVZT6uHoLOkA5v5dSVYdFb00A5g
 Rt+vRGj2EV6S6HaISVqiKSWuy+2SWcnlv/Gl4OaE+6o031khLIc6keTmknBkznkgmeic
 eFS7s1OzqcuJJR98ogYqVM7LlIwvRBY610+ZUVXdigVa5PgzjXiccvZAiJpqMy4m4ESS
 aRIpGscnoFTwrBWIJomrVRN/eLwD26AuRrQUp+T7kSEuIUdLi3IJNGVV5bg519zBiXas
 WCFaAy8Ft4oz3bvs351tT8R3UNrnHf/WzNhvp7MP82jP5BQgMUv5wxne6hlh1K7Iez8r
 oe2Q==
X-Gm-Message-State: AOJu0YxNnBebY5OV3MYMj4CXUTLcaipl6taSgY/NfMgHTHu+A99kw7/y
 muemy6wKDZt/JirHmJ6F+maRTyMAjPtbIvXZq48MLQLlxEJ81tTSX8IBtGn2pi7MmYz3lI0UKbP
 x
X-Gm-Gg: ASbGncubJoAsPtSLkeCpJG81nG3KzBzdxBGYtdzT2kUjOW76DMfX+uBrmycSmbNz5c8
 lqe3vpZJUCg9bdYAXuBBXQQopt7huM2j2+KHJK6hPapJO3DfHfw55Y2AIYoG72GG0+B5HZWzKdE
 gnQmUv0SQYzSK9u9U5gNKPCL3uli3RxQw6e3wEJKUGc5GoiE3cNXMw94MMxXFpE/4U408Oqp/Sg
 pv4aet0UHz8GkCqFolFlwH08Ow0kD1hkPfpvXyJWAi+40JsGsVRvTiJI7P8/eeyp4/ZopSFwkBW
 Ufvl5/vTrd/PbMSJkrjgNZjFRIpl2bMf
X-Google-Smtp-Source: AGHT+IG08KRwDYDl3Eca/M/8HaBNJFxvYjEOQHCH2Utkv4RtOym9hjubqe/nvBxLIy/wgdS7JacjWQ==
X-Received: by 2002:a05:600c:1d0b:b0:439:98fd:a4b6 with SMTP id
 5b1f17b1804b1-439ae33cb6bmr105188825e9.15.1740395737687; 
 Mon, 24 Feb 2025 03:15:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/12] fpu: Always decide no_signaling_nans() at runtime
Date: Mon, 24 Feb 2025 11:15:21 +0000
Message-ID: <20250224111524.1101196-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Currently we have a compile-time shortcut where we
return false from no_signaling_nans() on everything except
Xtensa, because we know that's the only target that
might ever set status->no_signaling_nans.

Remove the ifdef, so we always look at the status flag;
this has no behavioural change, but will be necessary
if we want to build softfloat once for all targets.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250217125055.160887-8-peter.maydell@linaro.org
---
 fpu/softfloat-specialize.c.inc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8327f727861..a2c6afad5da 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -85,11 +85,7 @@ this code that are retained.
  */
 static inline bool no_signaling_nans(float_status *status)
 {
-#if defined(TARGET_XTENSA)
     return status->no_signaling_nans;
-#else
-    return false;
-#endif
 }
 
 /* Define how the architecture discriminates signaling NaNs.
-- 
2.43.0


