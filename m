Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F39D690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc2G-0005XM-VF; Thu, 28 Nov 2024 05:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzj-00027U-9r
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:39 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzb-0000Yu-PB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:32 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-382296631f1so596653f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790604; x=1733395404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyYEZNn0XnxoTIdyelbgzeOaKzs7K1fWizjpa6l6dh0=;
 b=LSUEZ68btM0PfQErI+T4vC2nMtuo4MqcsucP7nVlTNXyy92h/VKsG4ivSA4NXBzExx
 iUSpmHtOps0ZflLr6QPm2QknHq87Ql/MdHQ39XbKI6HdQlvYR8TFuGtzqzaP7hAJS8cF
 Yy2us6fGvY7oaoulb4Pn6ZaBzbO3BPOafCXOEpfiwf6YdnUEIStEjRwa4Sz0NRkwBEPb
 ivkWvtSyZg/HqasRlkmjK5A3o/vHiMmPXPch/TYRSH/P2nydjY1ucuTrXLCFiQcMwbJN
 SV0IO9Yd/Io9wbOeQ2Ll+UItgU0fuXxST1sLPCYTwluVRCp7W/1IY2hAIQhyUcmVKYLH
 4PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790604; x=1733395404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyYEZNn0XnxoTIdyelbgzeOaKzs7K1fWizjpa6l6dh0=;
 b=ghXF1rYrxAM1OmbE4GzK0WJwZzHGmEak5sSXrZftOzxQ6qkJ8iEzqjDK+cnaotN7GI
 0TphHgEvOerQ6c+VoHvY/RBpLGAD+uXDeixLHNhDXSTE6bpnUELn97l2S86KLVkn0Zan
 zEu94XRHO2P14T5wCnAiXBJS7g0xJfybI+Xx182Ab84wGNth3qEZiftnNyo7glzMHqVI
 6vh72dHKLv+CD1iJ9pWuZ2Y1FU8jang4aEip4lqaOAWwNTszr1s3gigI1WQYjfvP+yoF
 qmrDIPdTLAqUNXeqSyLTjqZn5UPbnV5lMJvD29q11IUqPNnX1pHN9fUrT8UJcoixS34L
 g43A==
X-Gm-Message-State: AOJu0YzuPRhuq2CIudMdfueZV/t0HwKV0tQFTOeIozzHTZzhkSZh3igG
 ajEE6ZZCRRsB6BjaNN/XdTwr5UhTsFxETkptTkwbljt4WN3A6yBDAwoXRnfRFVGHX+fqd7aI/5D
 H
X-Gm-Gg: ASbGncvoIBz7K1yezjRxfkkuF1+o+0/cT+I88eCfkR2Yd2dwCFbCBqs1j3F1Y8H6FWz
 ONFvc1xW7hsqMi2yfedt9k87kukXuVumP/ggZPRmx9TsIrKbA1Tb8S/luCSHdIbdmx1jcX+f7Ax
 J8Dk1x+3mEaEdrf2BWVR+JTg9iT0jsdBPh/H1yHG24211afk5uExq4kYLBTH6J4gQcB7FjjW6Ne
 tMqCN2kbXgCFR8hG1F0A2YAmOUdmshOL7wrJSxGjL1d7YmVw1R/vB8=
X-Google-Smtp-Source: AGHT+IGbzy7EzKb4dzUEAavEzzJsSYKrO6t+vXSJ9MO8ux6hcDinUpScoS9ZCNZkY9iXna2ctNwC7A==
X-Received: by 2002:a05:6000:2c8:b0:382:4792:a48e with SMTP id
 ffacd0b85a97d-385c6ef39b2mr5795236f8f.48.1732790604581; 
 Thu, 28 Nov 2024 02:43:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 13/25] target/hppa: Set FloatInfZeroNaNRule explicitly
Date: Thu, 28 Nov 2024 10:42:58 +0000
Message-Id: <20241128104310.3452934-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Set the FloatInfZeroNaNRule explicitly for the HPPA target,
so we can remove the ifdef from pickNaNMulAdd().

As this is the last target to be converted to explicitly setting
the rule, we can remove the fallback code in pickNaNMulAdd()
entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hppa/fpu_helper.c       |  2 ++
 fpu/softfloat-specialize.c.inc | 13 +------------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 0e44074ba82..393cae33bf9 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -55,6 +55,8 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
      * HPPA does note implement a CPU reset method at all...
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /* For inf * 0 + NaN, return the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 05dec2fcb4c..3e4ec938b25 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,8 +475,6 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
-    FloatInfZeroNaNRule rule = status->float_infzeronan_rule;
-
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
@@ -485,21 +483,12 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      */
     assert(!status->default_nan_mode);
 
-    if (rule == float_infzeronan_none) {
-        /*
-         * Temporarily fall back to ifdef ladder
-         */
-#if defined(TARGET_HPPA)
-        rule = float_infzeronan_dnan_never;
-#endif
-    }
-
     if (infzero) {
         /*
          * Inf * 0 + NaN -- some implementations return the default NaN here,
          * and some return the input NaN.
          */
-        switch (rule) {
+        switch (status->float_infzeronan_rule) {
         case float_infzeronan_dnan_never:
             return 2;
         case float_infzeronan_dnan_always:
-- 
2.34.1


