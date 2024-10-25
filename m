Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7A7D0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4I-0004Vj-II; Fri, 25 Oct 2024 10:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L48-0004LR-3P
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3v-0007tQ-Tu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43169902057so20482035e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865590; x=1730470390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0KwrJ+RLRqyfxTos/cR3Np44ABB8RBfSuYyJrILdGI=;
 b=F7nS6GVrZ6Ud5EY3wzWxnRC3v0jBOi+8Gh0/KNexEOm8jNQ6jjTPC0oLlfO+QDfiUl
 Ayke1GDj7kHX9yRk7QdjRSocLxQDWolEDWQnWy3jvo2kvZ2jVwThVF1cyyvb9Z+aZ6VW
 cXpI3vbr84tnrbXSMKiXwlG90xUg/E0Kaoe7cQFlk6mwfAYzGywW71enQCT7Nc0naleU
 XfgyC5dHqI5k0JHMhNvobWEg1gW3NFx2/Ixh4ZJJKmkZS98zWCHq0tlx7vigM25tx2cK
 b4VzTR0LaG3AyTwOUBDarPxH/keGoVFYN0tmzK/GDHpAVBeRl4x/7Rf6ZDEK8Zk1Nsjz
 BeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865590; x=1730470390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0KwrJ+RLRqyfxTos/cR3Np44ABB8RBfSuYyJrILdGI=;
 b=fSNnz1S3PqQ6e690FiVUs7ubYIxXBH/CkLUrW6zUoZPj7rZn+XZCXoZoygtGgrluBs
 Mhiq6m1pDd9122leBvYvIyt3lUE3UYJQembKWzc6l6H4GnIzjwRMOiAPDJjyzewoYIqN
 MgWEtvlPgFO7sQ7nqJQF/tv3zMkViBFIIzj2hF05JeVWMUImcUDJjEAb1cHa6ZhZRANp
 kq39a1Re5IsoqZEnggx85Fy6j+LrY/mCU+aidpzosjebgRp1/KK/4RYCU+RPyJSSFPyI
 JT40Dy/E5rOt2poo310EDGmeFZz8KeDAYom5Tm8bGNNahGW896X+19/1jkuxVBYcek8P
 rg6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbYoJjc3GIs1rIYicd/d56CGez4esSIHYLzxlSmMNNB4E3FUfT6V8Cl8h9lGAdoTFYjgsR91I0QGlb@nongnu.org
X-Gm-Message-State: AOJu0YxKxZBkwVx5fWFiuCg8jRvvtwjgYKnf0OR8SWvKSshMgbKszBHZ
 FsAqhG5dq7xAPVeOFVlgloTuF/ThxyEV7JuDS6U5Mw1Y9sYiZoDXk6yF9u+YJr8=
X-Google-Smtp-Source: AGHT+IElscYFzJMkYmD7qnmfjnyWZqUI37VMxIDiiFWHpHvVdX7AL5ahkCq804b4/QejsLD1QmJqwg==
X-Received: by 2002:a05:600c:1e08:b0:431:2b66:44f7 with SMTP id
 5b1f17b1804b1-431841a5fe1mr81921395e9.31.1729865590281; 
 Fri, 25 Oct 2024 07:13:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:10 -0700 (PDT)
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
Subject: [PATCH 16/21] target/alpha: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:49 +0100
Message-Id: <20241025141254.2141506-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Set the NaN propagation rule explicitly for the float_status word
used in this target.

This is a no-behaviour-change commit, so we retain the existing
behaviour of x87-style pick-largest-significand NaN propagation.
This is however not the architecturally correct handling, so we leave
a TODO note to that effect.

We also leave a TODO note pointing out that all this code in the cpu
initfn (including the existing setting up of env->flags and the FPCR)
should be in a currently non-existent CPU reset function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/alpha/cpu.c             | 11 +++++++++++
 fpu/softfloat-specialize.c.inc |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 9db1dffc03e..5d75c941f7a 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -24,6 +24,7 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "fpu/softfloat.h"
 
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
@@ -187,7 +188,17 @@ static void alpha_cpu_initfn(Object *obj)
 {
     CPUAlphaState *env = cpu_env(CPU(obj));
 
+    /* TODO all this should be done in reset, not init */
+
     env->lock_addr = -1;
+
+    /*
+     * TODO: this is incorrect. The Alpha Architecture Handbook version 4
+     * describes NaN propagation in section 4.7.10.4. We should prefer
+     * the operand in Fb (whether it is a QNaN or an SNaN), then the
+     * operand in Fa. That is float_2nan_prop_ba.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
     cpu_alpha_store_fpcr(env, (uint64_t)(FPCR_INVD | FPCR_DZED | FPCR_OVFD
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 77ebc8216f6..a5c3e2b8de5 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -406,7 +406,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
-    || defined(TARGET_I386)
+    || defined(TARGET_I386) || defined(TARGET_ALPHA)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


