Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05ACC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZd-0007YG-9l; Sun, 26 May 2024 20:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZM-0007HF-Fj
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:32 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZK-0003hP-2d
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:32 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f12171523eso4699425a34.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771021; x=1717375821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vNGTbU6DTUvMSHt1rxKvf5wFDuC+/EH4FoXciheiqRg=;
 b=IW/YV/g3z8GMM37gpwlYY5QUELIP9mQuH1ZZz/F5lX7DUJvCpXc0UnAixZc9nxo4Pz
 ItfINgNUPlT8P9ioQ2FT7XBaum9i3l1eVwvjeffmfSlHgjGkXMO4KvmzW9toZlN0dbhC
 I3M1VncSQLUi0YzYyOPscjKrr5AnnkkAZeacO+NoWW0ReIMHmzcyEqx/NYDlkd4PU/fD
 tTks55PwhZtlPq4BNeh5PtSLfzORJCtjXna+bDr2ssB7OjURq0Q+uWov7anu7Dc5vvKq
 TDOypPhPlIJSigjUwzCWca7QCSXaYV4vGv3LvY1O+DcTVcAP9FNFtn/NTrRs3HQgQNfj
 i4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771021; x=1717375821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNGTbU6DTUvMSHt1rxKvf5wFDuC+/EH4FoXciheiqRg=;
 b=kqyP+M4Mqs1IycMt+pg/Cs2m1cqgrkjk7zj6TGEwzOXKDctD1ZXlssTrcEtt4MsiCx
 bMqevEPqNTDsFM1a1+h5dk5tk+tIL0ek7a1D+LfCasj3hT06FZLmW5W30H5N8vbC1gTf
 W+ahirUX3ehAcXLKGmtC+/0tmv+SSOvdIdBFasDSgrGuZtGEA/wMw4a94SdplE4BugVO
 TlYkyQEHhiCFMqhL8OtZxKZYEusfPVGpsWmuzga1u8sL+t4Ow8JONV09QC96ILw0cTnf
 u7dIR0KOTgUG91YRhd9gCOV3CHE7ivLt0dStP/SvcqEwVV0y49lq93/Du3n7/lVtbuFS
 9jUQ==
X-Gm-Message-State: AOJu0YzYZwMs2vC3ohVPQtVZaZyOAwQOjyR84XG7d8863DtW2IqSUbge
 FRg6gQrgEJUN5iKXL04gmkHbzP3NsvZqP5HRMPGJEioQFAit18yWzXWIUpVPeptNyqotSvBsXXC
 4
X-Google-Smtp-Source: AGHT+IEbQxdYqF0MRFYLAx8XZ75mE79vXrUuxYoO7+cCJ5IEaQtY1Pi5bFpKnba0FQqfPGzlsS/o6A==
X-Received: by 2002:a05:6870:828b:b0:24f:eadd:9a30 with SMTP id
 586e51a60fabf-24feade53d6mr2861908fac.55.1716771021077; 
 Sun, 26 May 2024 17:50:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/28] linux-user/i386: Honor xfeatures in xrstor_sigcontext
Date: Sun, 26 May 2024 17:49:56 -0700
Message-Id: <20240527005001.642825-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 47e6c0ff0d..e716ec8989 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -613,6 +613,7 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
     struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
     uint32_t magic1, magic2;
     uint32_t extended_size, xstate_size, min_size, max_size;
+    uint64_t xfeatures;
 
     switch (fpkind) {
     case FPSTATE_XSAVE:
@@ -629,10 +630,25 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
             xstate_size > extended_size) {
             break;
         }
+
+        /*
+         * Restore the features indicated in the frame, masked by
+         * those currently enabled.  Re-check the frame size.
+         * ??? It is not clear where the kernel does this, but it
+         * is not in check_xstate_in_sigframe, and so (probably)
+         * does not fall back to fxrstor.
+         */
+        xfeatures = tswap64(sw->xfeatures) & env->xcr0;
+        min_size = xsave_area_size(xfeatures, false);
+        if (xstate_size < min_size) {
+            return false;
+        }
+
         if (!access_ok(env_cpu(env), VERIFY_READ, fxstate_addr,
                        xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE)) {
             return false;
         }
+
         /*
          * Check for the presence of second magic word at the end of memory
          * layout. This detects the case where the user just copied the legacy
@@ -645,7 +661,8 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         if (magic2 != TARGET_FP_XSTATE_MAGIC2) {
             break;
         }
-        cpu_x86_xrstor(env, fxstate_addr, -1);
+
+        cpu_x86_xrstor(env, fxstate_addr, xfeatures);
         return true;
 
     default:
-- 
2.34.1


