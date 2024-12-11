Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D30BE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS3-0000Hq-HL; Wed, 11 Dec 2024 11:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS1-0000Gd-PZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS0-0007ig-6a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso12223695e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934035; x=1734538835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9JNv5O6oxFzvaBtjpDgniZj0/Bs8bCD6Hgo8p0cpegg=;
 b=Zw675H10IGvKx78oPblT5YmLvcf0cPgx29RieKE2ndy5TKbb3VzUlUmyQn46ClsWE1
 9jMmwjPsztHtqKkbDFPbBHeVudCJ2UJ7E4ZK+LhyhmvK+bqAjYXIifeMCILe6/TIfTwR
 HEHh8mcWDJgUTXR32vkgd82U9jSiqLUpjqRe/1/TcGJCZcZm5HSen1/HvcT045oyEkG3
 qmwlSl3TcukQZg4mOSMWFxbsIYZIm+xN9776PgJOXvtSLXphbXrxAz17roDW/siUHiC8
 14kKFBaxM9Wgn8/3Vx23GvAr61dJstl0OTqTG0z0qUF/g17XB/CFZmsuXgGCqAR87+ec
 +5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934035; x=1734538835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JNv5O6oxFzvaBtjpDgniZj0/Bs8bCD6Hgo8p0cpegg=;
 b=PXtU+jhLNJP7Ehal3vnJSIbHTpzBeH09MhmZ3d0mQQrgVvJgjCY6Y2mSKMP3duHuLz
 S5St9MRO0udfqH8C3BiAzWobMb6mzPAsHh5Yu54sK7fFlpxLwt4WB7XSeGU3J4nyEzq3
 /iE9yw/WTg/GbGTN/BPnxNZFJqVJE9lQfSxidfWeRRoQsbljKIgrcKrmsT2ND+X4Guis
 p2Z7mcwgRcy3H4nWuSIg1DUagngvtb/e1yChmsa47G8aP3GleJMlY3qliQD4SPYtv/k4
 MKbzkljfaBBnXhsH+GMeLYJ1DqNvAenVGx0uH8DhVtg9nPZ6oL0dIPx3qo+1kPpQKmZK
 ykOg==
X-Gm-Message-State: AOJu0Yx3PMCyrJOeb5uuL0sd4cVzpAVo9zyeCSrwkz0p+tvs38upL9kU
 uUzT1FY3IIN+tEeuM1CRweyc/xiWGtIyQi9WU+Je9wQuje8WUmQvs0PZxSUVWYOOpAvR3+t+T3Z
 3
X-Gm-Gg: ASbGncs3//slebq69FFs2VC+zh+DT93T9qFjing99EARJjOTM1xBVKS4zSSpaLVIrPk
 T6dw0Oq9+9Xyf5ELSDKRRl2OPqNnpOwzPzPWOZdQzUaENPTnqwEliNPaTYjc9aRz/JstFNXkgOL
 X3TfV8PuPYRMkcdYJKo8Qpf2DPkEWRhjhzx7u+EQtK/UeS7Qkhz848bQjyElgRaJW4EfMDcAw6v
 NVzfZNJRk6EnpXOT/TrhS5zRSpryFA2P5CU9qXHhyu/WDh59szEqpBS/hSB
X-Google-Smtp-Source: AGHT+IH93U71LAYyApCOjOP5fQgmzkf7MtQtGjmOqiP6TV57Is9MRxwwUs7Ps4zcfnoOF3f4eaY6fg==
X-Received: by 2002:a05:600c:350c:b0:434:ff9d:a370 with SMTP id
 5b1f17b1804b1-4361c2b5351mr29722805e9.0.1733934034735; 
 Wed, 11 Dec 2024 08:20:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/72] target/loongarch: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:15 +0000
Message-Id: <20241211162004.2795499-24-peter.maydell@linaro.org>
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

Set the Float3NaNPropRule explicitly for loongarch, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-19-peter.maydell@linaro.org
---
 target/loongarch/tcg/fpu_helper.c | 1 +
 fpu/softfloat-specialize.c.inc    | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index 6a2c4b5b1db..37a48599366 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -37,6 +37,7 @@ void restore_fp_status(CPULoongArchState *env)
      * case sets InvalidOp and returns the input value 'c'
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 3a2d0444475..d610f460026 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,8 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_LOONGARCH64)
-        rule = float_3nan_prop_s_cab;
 #elif defined(TARGET_PPC)
         /*
          * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-- 
2.34.1


