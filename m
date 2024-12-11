Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A4E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS7-0000K2-M5; Wed, 11 Dec 2024 11:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS3-0000I1-H6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS1-0007jD-WE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a736518eso77686775e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934036; x=1734538836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lcAFP9saDoRzm67hcihtav0796Gpanslu14kzIrlvT4=;
 b=kmArW4WldtOYa5I6enP9PfqmzalRogqdIR/IQS3T3dgoPW4IzUCncR3ztlD/2G1/aR
 NGoEWUxvAiqtIXpRr1p4ye9W0V7oMiBgr0CygkADJ4FEFSUoBjik1U/+aYgoND/o8li+
 fmfpv0E5O7ngRaQN/Dl8vIVynuIpdheF335SW6NDAhoDxt3NRN1xSQnyaGQXleYXylWw
 +kRILpfKdPcQH9K/VvuQq6b2ngsSEvu0ID0af+Sor7sX1LuZpzdiJCU6ZUAx42Y1Fjh4
 0iMmqd03Cl+/n721Vzjt24zIfZ/WPjl6PLRK8nTyjv5DMwwfvbfKVSEpEHOWgNJPb37q
 EtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934036; x=1734538836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lcAFP9saDoRzm67hcihtav0796Gpanslu14kzIrlvT4=;
 b=HmfgQKobMBIaU16q/veybYGwCUDKyDOhidFs6A+WICZS8lUm4A+c09pXJ4vrGa6yrw
 fbx+zQMnuoDRkVPtG70fH17XKp1Pmab937+IZTxN5996RgKy6ez0YIbEfE778j4ZFvUg
 IqDo36WSt0lzkoY+bZUjJJ14eHzFFQqRCEcEYZTAK0l4Lo3O9mdj+DHQxzsituXnFd6K
 qrGO4V+93VAAYHCAt63+jGY8GFEC+6icnU/PlUIZ5SKq1ThE7gzCg9bvtbf7zeGTk9ae
 +xRXzug97dqpOHKfuR3CFAOb5JIIYdDE7EZD54TvJu6qvORJ9r1Wo8U9SFsuWpc6k+Jq
 z2ng==
X-Gm-Message-State: AOJu0Ywg7SXI34tAIeyqhonBB4PHv0Qq+7TXYzQrHg+sIdvQkeI4w+Wk
 CNckxJtlzDEvCaGH919T81Mmg1jQ0VaNLL2MQvZVK59sxMxlac4Hti8k3BlGqlL0u8Hvwjf1S0Q
 2
X-Gm-Gg: ASbGncswL+kmzGRqKXpw3XxH61CsBu213NHeXnMiYlWg56V0BSudtubOpA+l3ES1kcA
 kCdLDs1hGQtKV1jBxauAk0R6kFpMcJAlniJ/ZEkD8lzw9UWsMdtgEG1q+2hIwx9jVsUQf82FtPi
 JulaM8XJdqiIribED8yM5n1YC7FBu4vz7Uj89KzMpth1MhacZXicYsptjBaZB1jtWjdu6M4PEZz
 0Qq2oTtLh/eI63VGdtSETw+nXFqJNqNv8cjgRpkv3SDERxdk5Q9jr0992Fh
X-Google-Smtp-Source: AGHT+IHlK9WFYqz7Mg4NZlPtcMQJUX2ZHEgRIU8qWfr5Hc7M36rVj7uZE6tsZgIuHiXTKnsoBVmNRw==
X-Received: by 2002:a05:600c:3acf:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-4361c393cc1mr33932175e9.4.1733934036565; 
 Wed, 11 Dec 2024 08:20:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/72] target/s390x: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:17 +0000
Message-Id: <20241211162004.2795499-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Set the Float3NaNPropRule explicitly for s390x, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-21-peter.maydell@linaro.org
---
 target/s390x/cpu.c             | 1 +
 fpu/softfloat-specialize.c.inc | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d5941b5b9df..e74055bad79 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -206,6 +206,7 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
         set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fpu_status);
+        set_float_3nan_prop_rule(float_3nan_prop_s_abc, &env->fpu_status);
         set_float_infzeronan_rule(float_infzeronan_dnan_always,
                                   &env->fpu_status);
        /* fall through */
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 173b9eadb57..8a36280df1a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,8 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_S390X)
-        rule = float_3nan_prop_s_abc;
 #elif defined(TARGET_SPARC)
         rule = float_3nan_prop_s_cba;
 #elif defined(TARGET_XTENSA)
-- 
2.34.1


