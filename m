Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB2FD0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4Q-0004jS-De; Fri, 25 Oct 2024 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L4D-0004RY-3c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L40-0007vx-25
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so27049265e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865594; x=1730470394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a+J6mOz6+tgsx1AS0v8GOVI5VoZBPQJco52huASzlo=;
 b=swGkzWKB74q/r6UrCjCpsnhkDVw6Jws4JQpv2NNPOqK2jbJxltko7H1+s8u/qRECcz
 EFrs4zJ52KlVn4HQ7M8a5bAgpanB0ujovC6GcYbm0RG/PaxnV3d2eSc8QmTym7D/Bqgq
 MjyH2wAhQpFCQuKjtwXgv0Bz4ijnmxfYngxfItHVH5kQKIhRIbO2Wr63fThNWYnzrswq
 9O9h4ba8jTOW/5EMdqZIFdnZgL12fjKgOZRzXfDz0ByziOT9Z38yMkm8wUdgUoGEjVQ1
 aV5kjVtvnf5sApbcb8kgcSp4PiKiNtge8Ur6Yk66Grv2f8ZtceGDJp5uzY0QOYL1JYOl
 7uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865594; x=1730470394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3a+J6mOz6+tgsx1AS0v8GOVI5VoZBPQJco52huASzlo=;
 b=t83tJoNs38s7o6wBQ6WMzW79SFYB4DdyEP3s/W4ZcuvOEZem9ql8hjz48jMOTuVn3e
 a7CnzyqHcL7VuE9WJa98DSlpGMY2uAn1/gLaQlwSO1Qx6uFejvEixxiqLHOEOpOHqH7i
 y0sefcqDjOsebmc2IdDMKADhjOMMimDCMavV+6PZbSi+5fhXvepQDDYvN6direHDYL/i
 +IL6FOGaTHvuKQ1brB/C69XrRvEtKN0AoErXW3Q1kXEJybD3pbENk2zoUUXROOH+PwyM
 kb4UBmsFU+kXyShv3to2Og8tZ1Le006dqAb+tg3bqbJ/fQeMHZPgjHWF3jz+Q+zlFAzF
 oUGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG3OTE2UuWYaa7HvRCDEekEU4TtZ1wX8wK7mJeO1VP8t0ea7JUuytTHdFXbxI2M/294CM8C8MobqaA@nongnu.org
X-Gm-Message-State: AOJu0Yw043jVn3efLLYBe/6vnrtdCkffPwABDMfe9bSVbgsM7dJDdhoe
 7dKiQOKoDit7OLLohtMzLjUB33uwiDMjWTNZ8UgZT1rXZf8thbP8bPMnCDez85w=
X-Google-Smtp-Source: AGHT+IEYMdsaWi/TEfmIcbi85fBTUZ7J91UQRDnMyPxYqnX5zLsKoYqJjNy9q5lZ3k4JbpehHV50wA==
X-Received: by 2002:a05:600c:1d82:b0:431:5ba1:a520 with SMTP id
 5b1f17b1804b1-431841eb454mr112345445e9.3.1729865594517; 
 Fri, 25 Oct 2024 07:13:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 21/21] softfloat: Remove fallback rule from pickNaN()
Date: Fri, 25 Oct 2024 15:12:54 +0100
Message-Id: <20241025141254.2141506-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Now that all targets have been converted to explicitly set a NaN
propagation rule, we can remove the set of target ifdefs (which now
list every target) and clean up the references to fallback behaviour
for float_2nan_prop_none.

The "default" case in the switch will catch any remaining places
where status->float_2nan_prop_rule was not set by the target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


