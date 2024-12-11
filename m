Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2AFE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS7-0000JV-6N; Wed, 11 Dec 2024 11:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS2-0000He-J6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS1-0007iu-0R
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a742481aso59513105e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934035; x=1734538835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lo7VMCHiiH9lz9IaE5gLakal324n4TYjmC+cVkhARM4=;
 b=VWuzXDw3J372qF9uhZGF5RhgaW49DhFXExiWVsPIMFmha4VdXqspBQyfCjRBdvRlB7
 8FQ3RhLkfYOeG3Utno5MrqadmrtUnXmD6csSH7tNDJKp8df8bw/poANClRdm/l+m5VU/
 WMLzFfBFdWdfLu0NcrFve3WSxlXUGsUVD1cMpv+nGkTY4+iw0ldrnrwhGaFdRJKw1itL
 WxE9uSQr94OvbzlQwZ3CC0d28zxfENtEIADUYiY2zoRaVA0aT4NxJSMTKohc+uUktR7T
 3pnmkSmi3+gbL5dAx4Lo21RfF60wPui3mCWV7ouWLJGYNC/zGawq67a+/vWWO27nNYPP
 M23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934035; x=1734538835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lo7VMCHiiH9lz9IaE5gLakal324n4TYjmC+cVkhARM4=;
 b=oDpdW4VGwd03qWuHnR4PQFPaYU2CI8XJIFPBLT9bny0UeXlTRzsJ0WjJXVRkqbYqX/
 d82A2kuwXxop8WGwjZDTx4R1v56WFfFjqzCOO2ouHK/i9nw4ZbvaXwrmh9/+MR5Y4Ctz
 /kFrR/6VpFUl7372Z7WOHHN4uVt2bAwWKyRZzL5zEy5B3d1vDnTPfm9AdwGrnP1fc3JM
 aAQVK1Xb206iebsGYGuBLQCccRl5VR14aJYv7Y4aVScNQye6RN1nWXK3+n/ZaQFHSOHI
 o2SPGmFPXDfwoXngyqZcho74i48VftKkZ34WX0HmLRBMqvqe4ZyLPZxcBGgGbhFxjza/
 FULQ==
X-Gm-Message-State: AOJu0YyzBOqWjp+0E5kRoroYDXKrT/MObCDYfOK3DjyHlaFvszDmpHkY
 GG75hWAizli45emRDWlRbzM1U5lSvYGBbAsskamLkJ6l1YyqlpYBUodumfwcF/GbM88ntA5QCAt
 2
X-Gm-Gg: ASbGncv2a/MtN9h71jCAxDgN6dz7Lusd7LHO/+UCJ08QAILnblH7dq39XpfzeMEua3X
 Mh+ORB0DrVth3sSfCYJR5oWOwumSWw4R2aSIEjCW+yyYoz+ih2Sr9sCA03Zv9I6tQv4qtnBK7vf
 8ldAqYsrhy8jweGcY4puKhg1IGlR4t9cqoSyJzP9aQQvRpyxDfJNdu4M7obilkgG+R0ffpvHhIt
 f22WrjPk0HD+1UyddXMqh5sJOcXeqZw/jiW6q/JiD/cuzuoq3sgAGU6/azf
X-Google-Smtp-Source: AGHT+IHlIi7VqqJ2r6ts+BLVySRQ3BfFDjj9D2fk17VKus71AXS/NQjwXP0n96IVlMYsRoNX3JnqrQ==
X-Received: by 2002:a05:600c:5116:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-43622845ca2mr3219485e9.18.1733934035660; 
 Wed, 11 Dec 2024 08:20:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/72] target/ppc: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:16 +0000
Message-Id: <20241211162004.2795499-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Set the Float3NaNPropRule explicitly for PPC, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-20-peter.maydell@linaro.org
---
 target/ppc/cpu_init.c          | 8 ++++++++
 fpu/softfloat-specialize.c.inc | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f18908a643a..eb9d7b13701 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7270,6 +7270,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
+    /*
+     * NaN propagation for fused multiply-add:
+     * if fRA is a NaN return it; otherwise if fRB is a NaN return it;
+     * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
+     * whereas QEMU labels the operands as (a * b) + c.
+     */
+    set_float_3nan_prop_rule(float_3nan_prop_acb, &env->fp_status);
+    set_float_3nan_prop_rule(float_3nan_prop_acb, &env->vec_status);
     /*
      * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
      * to return an input NaN if we have one (ie c) rather than generating
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index d610f460026..173b9eadb57 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,12 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_PPC)
-        /*
-         * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-         * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
-         */
-        rule = float_3nan_prop_acb;
 #elif defined(TARGET_S390X)
         rule = float_3nan_prop_s_abc;
 #elif defined(TARGET_SPARC)
-- 
2.34.1


