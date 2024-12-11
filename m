Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A739BE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSB-0000Lu-VD; Wed, 11 Dec 2024 11:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSA-0000L5-FC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS7-0007kC-Pw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:45 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso12767135e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934042; x=1734538842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3myRINrKnQas6bU6fv1OR23zH4Adyf999B3PUNZnQ7Q=;
 b=Gjuf9Ml6Ui5L9NM1cajl55/8r3ugGLUJ0nWAmcjC2h31ljbFpeB7lYViE6XMu1mHRH
 ADEIo0j9NwEBEdVCkzExkhZdq6obvK8eCr0X1TiHs4lJay/bO4UtGI7rFUvGXq+A4MF+
 fF35A5hrbrXV4VCo16Tbr+vcfLDau9UZn0Mzpd20G+/jfUrsbhsJH4XHKzsoGbSSRTE2
 TorfSKjb3HNODnV3Dnyn+r6f/X5cU8CfhJa5L2xayHm37hrKjmhEuxhiT34rxnuseI6c
 vyJgwn2UL8H+1YwJoeT/SZX33KoZXZqjDUi025enpWkxY76Dw1EmFKFTz+D60pen/pUB
 dDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934042; x=1734538842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3myRINrKnQas6bU6fv1OR23zH4Adyf999B3PUNZnQ7Q=;
 b=Uq80389bKXIuvji49QodIVK8nRhhBLV9XAH3RzevT/RXgbXC5j/Rd7wl5z1a32Trz8
 4y3lOrmus/AEQXGc/kjgC6C4SzAuoApUtn3HexHkeSFJIBTDRIkR7p2UcTka257MXrcY
 HDNxjpLGZJGnE+KPex0w+cTnZTOuQqDQf1v2/EBOpaxT1lt28vKI+OSTqg9Y9eX1Z2Gq
 +wEehrc+J+xY+tDjMs1RKYjyjUkr26/JQrQ0qwpTlqvbhfHt2ZTkp6QoHGaHXsslivYt
 olDxBeXDE5f/m9BwZ7H9pv6+dujHjPOzgpIM3/IRydhRi0DDphV4QlrG7q8JvrZDgZxw
 MTWg==
X-Gm-Message-State: AOJu0Yw758lDiy1lleWYfh6v2rOFU2vSCd40v9Dvgo/UZJFlON+w0eY1
 eKt1PdnXFWXzvpr0hlHYM5H3dpsXD7Is5m4mi1aniJhzv0RlwZ+waOLVj781YkvidZCpiR+RbEx
 8
X-Gm-Gg: ASbGncsNmYGgQX/8lq0a1rtTkOjl3LjT0hCOPJFxZXsWODLSiAaCCfKi4T2VMazl/Gm
 2ehelipwM2Zf9rQvvx3FvlXmXp3spTYty4RPT//2wxdxU8EN0j0t9eg6CDqJpRwCRt9TBx33bFL
 a1RZWhWo6mBresEE9BIKd//nWBAGA9WY+ShXC1FLhLAjEw0zBuZHkwiUz6TZ6x78+y+2tvoB4v+
 klKgsiruwd3T05GpzwGS9FXPbqvD880i1drlI+u9CEqxfKdMLNELgi+PWxY
X-Google-Smtp-Source: AGHT+IEq2dBx7lNRjY88CNf7LqhOf1y2krPpozZp6PR0HieNaAAIoFcPmQ2OCJMgfKWv9pQZ7dJdAw==
X-Received: by 2002:a05:600c:1e0b:b0:435:330d:de86 with SMTP id
 5b1f17b1804b1-4362256d085mr3832545e9.0.1733934042275; 
 Wed, 11 Dec 2024 08:20:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/72] target/hppa: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:22 +0000
Message-Id: <20241211162004.2795499-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
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

Set the Float3NaNPropRule explicitly for HPPA, and remove the
ifdef from pickNaNMulAdd().

HPPA is the only target that was using the default branch of the
ifdef ladder (other targets either do not use muladd or set
default_nan_mode), so we can remove the ifdef fallback entirely now
(allowing the "rule not set" case to fall into the default of the
switch statement and assert).

We add a TODO note that the HPPA rule is probably wrong; this is
not a behavioural change for this refactoring.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-26-peter.maydell@linaro.org
---
 target/hppa/fpu_helper.c       | 8 ++++++++
 fpu/softfloat-specialize.c.inc | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 393cae33bf9..69c4ce37835 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -55,6 +55,14 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
      * HPPA does note implement a CPU reset method at all...
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /*
+     * TODO: The HPPA architecture reference only documents its NaN
+     * propagation rule for 2-operand operations. Testing on real hardware
+     * might be necessary to confirm whether this order for muladd is correct.
+     * Not preferring the SNaN is almost certainly incorrect as it diverges
+     * from the documented rules for 2-operand operations.
+     */
+    set_float_3nan_prop_rule(float_3nan_prop_abc, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 67428dab98a..5fbc953e71e 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -504,10 +504,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         }
     }
 
-    if (rule == float_3nan_prop_none) {
-        rule = float_3nan_prop_abc;
-    }
-
     assert(rule != float_3nan_prop_none);
     if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
         /* We have at least one SNaN input and should prefer it */
-- 
2.34.1


