Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A71D0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4B-0004Pe-JD; Fri, 25 Oct 2024 10:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L43-0004Fw-AK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3u-0007s9-3t
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso20447695e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865588; x=1730470388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/5hJDm1PODLj3BAsIJIpQ+juZ5PqFngoiMdJEv0hac=;
 b=iGqzg3SGOcUBSb+jS5N/ka49+o0NzhSKJbFBct29sn1YiHgr9TSVZ2rZfMEHqLncIG
 OH1IKB/4rBMqTux9/E7xFfwBGDj6uVzN+nJ0hOl4tyObJAiFDl7/Y+rU4PTqYCbr5YQ6
 veRiXQloO9kh2o4VI8511uRmDhWo0ha86aVn4t00FWCZ3/Nmiftumo8WrDwt9QFRCzOC
 0yusKc4avkLprT4u+CrLubuOkzvK4wMPqIQL6RHt2vi0oj0sl4+8zyS5vpuI7IUXqGfO
 NhrpJ4qhUXLEKFwVp+zsa+D5zGEplIfhjOerWk3Om4Q6AtnWJdxShMrOjnpLKz3YMZKt
 G6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865588; x=1730470388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/5hJDm1PODLj3BAsIJIpQ+juZ5PqFngoiMdJEv0hac=;
 b=iL9n/9c4K6T98TbEa1UIQnLiB9i97935ekBrUUNXo8PkvzDlRSv4OfB68KldyPLW+V
 K9E3NyWtrXv8zXnMjcqkXhfkzOuykBCFz30ui3sTkPuqrwlLvsNQl4pcIA8ckJwdS482
 3eSAE6dWce/oaD+uKlplwW4I7TmAvEmLbWZnivtf1YDy0MnD2bENhyhzvWz/pOPMUllz
 kw0zgHIQzD2bQ4dPT5khXp11ORaa0lzp1s8dGzhM0rwtmkEFiGHur4s0zED3+JOkpZgw
 xMSj2L5iPQXYLVjCG7x1RmDaqpF8B0uLgDRC5+oHV3y6y4tj+Yd3TdwRF9UTht0n/s0j
 HAig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIAj0+aoSxkWDLClvE8jx8PuUhb8M1Lff0Bet8koTc4dNfus2/6kQR2ZRKnn0QHnMFAiK8K/HeevtT@nongnu.org
X-Gm-Message-State: AOJu0YzgertamRzUXR9+VGJSU2gK83IKqjgBNjFOu+WjTEkUERqPdMS0
 4bwVZKb00RDwyx3TZtSCFzcRuhYt9Z19hugrow7HZ32PX9pZ4UMzN39iPKZ7fyA=
X-Google-Smtp-Source: AGHT+IFtr8tPLlxe4AzE9S1JUVvrPqyWHnFA5MwdtS48wd3RFQvCTT4NKQGzOSE7PL2RdlkvdzSAaw==
X-Received: by 2002:a05:600c:5011:b0:430:54a4:5b03 with SMTP id
 5b1f17b1804b1-4318c6e0175mr46337875e9.6.1729865588576; 
 Fri, 25 Oct 2024 07:13:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:08 -0700 (PDT)
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
Subject: [PATCH 14/21] target/xtensa: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:47 +0100
Message-Id: <20241025141254.2141506-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Set the NaN propagation rule explicitly in xtensa_use_first_nan().

(When we convert the softfloat pickNaNMulAdd routine to also
select a NaN propagation rule at runtime, we will be able to
remove the use_first_nan flag because the propagation rules
will handle everything.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/fpu_helper.c     |  2 ++
 fpu/softfloat-specialize.c.inc | 12 +-----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 50a5efa65e2..f2d212d05df 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -60,6 +60,8 @@ static const struct {
 void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
 {
     set_use_first_nan(use_first, &env->fp_status);
+    set_float_2nan_prop_rule(use_first ? float_2nan_prop_ab : float_2nan_prop_ba,
+                             &env->fp_status);
 }
 
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8bc95187178..b050c5eb04a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -405,18 +405,8 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
-    || defined(TARGET_SPARC)
+    || defined(TARGET_SPARC) || defined(TARGET_XTENSA)
         g_assert_not_reached();
-#elif defined(TARGET_XTENSA)
-        /*
-         * Xtensa has two NaN propagation modes.
-         * Which one is active is controlled by float_status::use_first_nan.
-         */
-        if (status->use_first_nan) {
-            rule = float_2nan_prop_ab;
-        } else {
-            rule = float_2nan_prop_ba;
-        }
 #else
         rule = float_2nan_prop_x87;
 #endif
-- 
2.34.1


