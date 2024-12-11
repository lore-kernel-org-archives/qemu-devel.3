Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6622E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSk-0001Jy-Cp; Wed, 11 Dec 2024 11:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSZ-00016P-DG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:11 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSX-0007qT-Us
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:11 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434ab114753so46294045e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934068; x=1734538868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vq/x7YW4KLHoHlW1YH3eegjJxd8Sl/753I0gqQuiK/A=;
 b=eWku/iYwaUdCwwpAx/5hN//jkB/PnVIVMTuLzIDGcpl9mPI+NpD4Gd8Yu0yQdi9eFR
 yeU1Js2Lnoa25tvG7Ii/87GCh4rl87bYw2MM0C4P1vb0x4ZQMvQRUN3Hi8pH9zs8hlWT
 +AjMSxnCkCS0VFz/c8DPMX1YPGZHigVwBHp/g/y88xSaXDZM50tS8jJsKqRSEb9LlekG
 1S7jzp9zr8IPcQI9wB9D2wEvjz+OMlMbX2yO4Ws5Cn9Hic4Nfwdsb8/z3kiAvDhImsoM
 OQ3lLIiyDdAZDY0zlawBnfmLs5vghWtUDiSGIQUYQLLZSrgZzvfD/fKD8ZCYy4C2X1PR
 64KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934068; x=1734538868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vq/x7YW4KLHoHlW1YH3eegjJxd8Sl/753I0gqQuiK/A=;
 b=wuA6sXrbP5uUb5U6Gs72R5pwkgE28Wxiw58DAGKUQDmLrM14yrzX09cgmtLJOBTdv6
 xwx8MF8uenPat0s/1g7SL6E3PqMXvkVEG8vBf+Ci8whbD+1mTlwTKpGBnw1MFbqTc+Y9
 xIQ+0aODrHdsBrcQYUGnykfa525C4okSa4BKepoAimAOwynPAVaFNCl1M0lWL4/hjI0L
 +NdkyC0cKlHo4b0XVveg+Yy1sx6IuS1sgCfJg+SvxuqBGHI8yhYuBqrZxhgV7g+UJsKB
 IYOoJMYOzngZ/YzTiC6nW690j8Xf6LuZbEucNfiA02nbN7qqjtS62NRthIbQEI6oGt8u
 892A==
X-Gm-Message-State: AOJu0Yx6rtr3lIq9qxCeDfpArkiMYUNViqGXI0HKTEJHCkZbDDD5TGSS
 wxiAeEw7zy6D0MyslN9g0K2la05hIzScMF6AHODHb9xFRInMxlYyi0TJ43i0rIFJygGW61VzEf2
 a
X-Gm-Gg: ASbGncsYq62dND4/uMpsh/3/f0trzorZIFMJIgs99MlIFLjql0sd9/gE8VzThXT7Wa+
 uGTRcSjNBAfnXwDJ2OBYdmvw7N034efjYPFok6qI2HvsVsinCUrllFuEfJNYwIki3rHZRhXFn8h
 4nW+XgmKAriHhRzMQZl2VOZYautTtAn/8RJAhkFslJEfl5DS0HJaeV1mPXZRuIkAktcOqKEejz/
 dpeh3IguJNOAYSJa3lWrjMJ8Zlj6eQmiFiiSA5VU3653QKGEqY81zCdk7Zg
X-Google-Smtp-Source: AGHT+IF27evuIVwc3KpsFFGiZrKpOnRemS/MHgCAONqWUYewZWizlXehc83Oo4NJT0UDGLjVelQmZw==
X-Received: by 2002:a05:600c:1e23:b0:434:fbcd:1382 with SMTP id
 5b1f17b1804b1-4361c35cef2mr27444385e9.11.1733934068595; 
 Wed, 11 Dec 2024 08:21:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/72] target/s390x: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:46 +0000
Message-Id: <20241211162004.2795499-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Set the default NaN pattern explicitly for s390x.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-49-peter.maydell@linaro.org
---
 target/s390x/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index e74055bad79..adb27504ad5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -209,6 +209,8 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         set_float_3nan_prop_rule(float_3nan_prop_s_abc, &env->fpu_status);
         set_float_infzeronan_rule(float_infzeronan_dnan_always,
                                   &env->fpu_status);
+        /* Default NaN value: sign bit clear, frac msb set */
+        set_float_default_nan_pattern(0b01000000, &env->fpu_status);
        /* fall through */
     case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
-- 
2.34.1


