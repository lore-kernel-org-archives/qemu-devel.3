Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53601D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbS-0004aD-Vn; Tue, 05 Nov 2024 06:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbQ-0004Yk-8Q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbE-00077O-G4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:02 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so3063508f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805589; x=1731410389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cw1psGp48awikydAaL3SY3lKiGJTebHKYQq/ZU+4hUk=;
 b=tfck9LSnEOOFfcW0CLZQQUNbB6E/QcXa6qyrBE5bRVro2OnJSyB86k9f1pJTdNOKQC
 DpG0c1JRRTJTLzXjU5g6uDfCzOs3gX7vVQ6X3qE61KnNJQoEFUApMNpKJptwMEamukY/
 BIdewRO7YInMYqTXJsmvSGrAbnRC7lLNw66mc+0P5NE2Kruye3G96kpGZZh6jqlRLGMt
 zkESnTEVCjKF5NUhWYtA2yQMnuliWgQn31k+90cb+ozH3/x+tpA2UBZmWjIumhR2ddv3
 E5QSD2K0U23qMcLgY/ERKEwfUHfb3SyT/k4JFTibDHyvNrw1+tnIMQyL5honzAZMjQ7Z
 8XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805589; x=1731410389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cw1psGp48awikydAaL3SY3lKiGJTebHKYQq/ZU+4hUk=;
 b=SUyouWQG6jJE0lu1+jKmUS5AciQkixEks4LNcLSXAHN97d8F+h4eIeEqkMCPLliOhk
 ssWyAcdc4iGOxVlvxKFSdzvmLhpIahLnXJNAvaH9vf2h4VnuX2ra/h8DluIIrpb78e2i
 nJ613xLG+xmk2wsRtPWC69vbvaE5mh4Cq8rA5H+pbiljLDQ9FgNt7RuPE1tfi2XD71yP
 mZx8nVSOrqBBN1eyPDtTmYXdYKJl2GvijX1WeIC6Zf8cho51oZo4ONSutVgbhpEmIF2E
 D9awafGJb1oGN4U5sbmeVHluszufBV2a9v4cBHbp8hESGow0hUDWIOhWfMVV+8ZYAhhS
 YFmw==
X-Gm-Message-State: AOJu0YzJhkxQpIqcbQnTLBvaKTM3cocUfI/tLWmeyCRdnYOQd/MBqOZU
 JYV+qIj1shfp9jEBXsEhUNgKLIJKGCaYT5Ah/3BfNDUf8+eAfyHadkmZyS6y31Yi4Qe9yzEDOt+
 3
X-Google-Smtp-Source: AGHT+IGqfpSjGhNkR1W937LJCuH5YnOU0yr3Is245r3oPoYDzd8AIUfxX2jCPZFqo/DRcEVfFaYvPg==
X-Received: by 2002:a5d:47ac:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-381c7973202mr13345787f8f.7.1730805589398; 
 Tue, 05 Nov 2024 03:19:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/31] softfloat: Remove fallback rule from pickNaN()
Date: Tue,  5 Nov 2024 11:19:25 +0000
Message-Id: <20241105111935.2747034-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Now that all targets have been converted to explicitly set a NaN
propagation rule, we can remove the set of target ifdefs (which now
list every target) and clean up the references to fallback behaviour
for float_2nan_prop_none.

The "default" case in the switch will catch any remaining places
where status->float_2nan_prop_rule was not set by the target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-22-peter.maydell@linaro.org
---
 include/fpu/softfloat-types.h  | 10 +++-------
 fpu/softfloat-specialize.c.inc | 23 +++--------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 5cd5a0d0ae1..8f39691dfd0 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -178,13 +178,9 @@ typedef enum __attribute__((__packed__)) {
  * If default_nan_mode is enabled then it is valid not to set a
  * NaN propagation rule, because the softfloat code guarantees
  * not to try to pick a NaN to propagate in default NaN mode.
- *
- * For transition, currently the 'none' rule will cause us to
- * fall back to picking the propagation rule based on the existing
- * ifdef ladder. When all targets are converted it will be an error
- * not to set the rule in float_status unless in default_nan_mode,
- * and we will assert if we need to handle an input NaN and no
- * rule was selected.
+ * When not in default-NaN mode, it is an error for the target
+ * not to set the rule in float_status, and we will assert if
+ * we need to handle an input NaN and no rule was selected.
  */
 typedef enum __attribute__((__packed__)) {
     /* No propagation rule specified */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 254bbd67168..b5a32080505 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -390,32 +390,15 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 static int pickNaN(FloatClass a_cls, FloatClass b_cls,
                    bool aIsLargerSignificand, float_status *status)
 {
-    Float2NaNPropRule rule = status->float_2nan_prop_rule;
-
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
+     * But if we're not in default-NaN mode then the target must
+     * specify via set_float_2nan_prop_rule().
      */
     assert(!status->default_nan_mode);
 
-    if (rule == float_2nan_prop_none) {
-        /* target didn't set the rule: fall back to old ifdef choices */
-#if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
-    || defined(TARGET_RISCV) || defined(TARGET_SH4) \
-    || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
-    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
-    || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
-    || defined(TARGET_I386) || defined(TARGET_ALPHA) \
-    || defined(TARGET_MICROBLAZE) || defined(TARGET_OPENRISC) \
-    || defined(TARGET_RX)
-        g_assert_not_reached();
-#else
-        rule = float_2nan_prop_x87;
-#endif
-    }
-
-    switch (rule) {
+    switch (status->float_2nan_prop_rule) {
     case float_2nan_prop_s_ab:
         if (is_snan(a_cls)) {
             return 0;
-- 
2.34.1


