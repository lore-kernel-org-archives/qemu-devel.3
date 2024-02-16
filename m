Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E60C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb61w-0005xt-Gb; Fri, 16 Feb 2024 16:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb61t-0005xQ-0J
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:45:57 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb61q-0004ED-5c
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:45:56 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-21e45ed41d7so1011792fac.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 13:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708119952; x=1708724752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8j36+4fI5sNYOhWFuNrMwlyHtTJx2esNZyAe8iVrCNU=;
 b=MXLttRoBMRNQQz9SRq8viUwI1vHRSytJHXP6xUWEjPXmi7HekuuqITGePqOTAX6ENh
 5wd49beq14DBQuUPNgZICQd5uD4J7VtY/bodE+nr8oRvJWwvJgc87lWe+A5Au1kzgDQh
 oTKE2ZuF+oIuylcaIMjKVU2+2VIdNt30ArFbK5GSdklmGclBmJnnLXqfNZMD6m7hq0dI
 IVmWZjZsTnQt55GjJtp5LoWHlGMwSBj6DNZGUx5PqH7DFmykCrnLUDw+1xngrUZ1loE6
 0XEp1PG6mFGM1dF9vq9K9TI+D/WWhBfGA2cglDOeyvjKcQdkuZ2rQw8mGEntM2HzP1zY
 +nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708119952; x=1708724752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8j36+4fI5sNYOhWFuNrMwlyHtTJx2esNZyAe8iVrCNU=;
 b=mB0AI9nKxWv9EhqDYQ6bsnM1Zl/NF4/WAFKodORTY64DbXBC8RYgoPVUKsaHmZ0UeR
 oScBZ3tnfOyJRsWBN2a/YHcCoSXXisAUDXuUwn9aVCHR8/xtJ0Kq3CYmEnFn1uC/CfPs
 e2H9Pc+EfkzfU2JJ5nAAkTGKla3JSC7XycSF2ySAyI98qsszdhh+WrUUiGtaS47aEATI
 0cPzXFdCokWp7ZJEdh6Hc3UEgIS1lUkGnOMOKeMY0Oi5Z/DGfkDkWOBcgvnMrt2DmANh
 j73hnXPPGjRR3RIz3RfQwescBdBNNACKIHyS2fBYblukWc1+vDTZSnVQpTgTaVFeI1OR
 HTTQ==
X-Gm-Message-State: AOJu0YxK4AJshgho3XAhfJDQrmgdr3lqRpmpQrscUGbx9y6gNkkGpZxa
 nxLq1O/tIDSQ1E2t8hMg8vdYowyM85hc7qcGakWWg7Bu7PCCFBhZa1U0+4yKa4hWTFrMj6TO2YK
 j
X-Google-Smtp-Source: AGHT+IFHndqCnmIqU1qufSaxL7O2PMRyNCeO+HINs6VqNV759prcp4aDMvug3e3RsuFCb5FzbARl5w==
X-Received: by 2002:a05:6870:5314:b0:21a:1007:4af2 with SMTP id
 j20-20020a056870531400b0021a10074af2mr6831268oan.7.1708119951560; 
 Fri, 16 Feb 2024 13:45:51 -0800 (PST)
Received: from stoup.. ([2607:fb90:4561:1dc5:19c7:835d:6676:d30c])
 by smtp.gmail.com with ESMTPSA id
 ov11-20020a056870cb8b00b0021e70d17dc7sm179350oab.30.2024.02.16.13.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 13:45:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tcg/aarch64: Apple does not align __int128_t in even registers
Date: Fri, 16 Feb 2024 11:45:47 -1000
Message-Id: <20240216214547.10350-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Fixes: 5427a9a7604 ("tcg: Add TCG_TARGET_CALL_{RET,ARG}_I128")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2169
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

See the gitlab issue for complete discussion of the ABI.

r~

---
 tcg/aarch64/tcg-target.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ef5ebe91bd..85d5746e47 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -55,7 +55,11 @@ typedef enum {
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
+#ifdef CONFIG_DARWIN
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
+#else
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
+#endif
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
 #define have_lse    (cpuinfo & CPUINFO_LSE)
-- 
2.34.1


