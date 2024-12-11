Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A01E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS8-0000KA-9E; Wed, 11 Dec 2024 11:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS7-0000Jp-2J
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS5-0007jw-Km
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso66243095e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934040; x=1734538840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LqLnmo8ZeuKt9gJbN0OoofaNl977bhykVsCXiY8ZDEI=;
 b=P+rdJQfcUzZVPwyYsYGpnQCEAMyLQ1sZPFQmJaKpXen4gF/i3SsnFmFOb3w1YKja+k
 VRUGSkwvq7BIm+5jlcoaQ7K5zjc015C1AEQHBomhBiEwqOxZBT7zGdsTW4d3BLFIJDzy
 HujdOEb9oAk6D9xQ44qvtt3jNwMXeNBgL1ATNfzoX1izyXkYouhZ8/2lZ2Pv/GFMT5jh
 mk7AgA2GHpHQlWA8NIBhexRx9YqKbgtq4M19h3IIN5Dye8h0r4q7pd5cHMq3x2wI+mn9
 m2ZXcMvI+8RNmLnO80Ba8rbwO7tAgDw7kK+H1dt901OF8Pp9HSlG3JAicxEif7m8EIdB
 WHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934040; x=1734538840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqLnmo8ZeuKt9gJbN0OoofaNl977bhykVsCXiY8ZDEI=;
 b=i89xNfQ4zX4nisAvsmur0liy9QOI3711zXiwMucjVwVmx4BpRE+q+w1tDaWnUYE6j+
 ss2TnIoqp08fTiY39hdY6zcdrgPLisQQRODtOQtea9WzTywuPveXzT5gguM9ySqfo1P5
 RvAdICb/A1Yb2eyGgc4w6eTBvGoPiSVZYDMSMVLpAeaIgdomLir3HLDbnbbK5c2Arh0v
 5x9YAh1SNw/OZXYcaCajL+XdFFks0XE+VcfdNqS4DGdBnepuTx69G4W2OrdhAxBSIjOO
 kxBKdSKgAHENPjmmF51L1hd2wOOjviGhmLr/HyGSsx7LEXYXpo/N7SMmjfBZbelFhugd
 Nuiw==
X-Gm-Message-State: AOJu0YzI45YqBKHJ3NUb2JA/fT6AlaRoqN54ZOSnc3mPiSL+taafoWMn
 nbO0yeQ9m1J6/aEL/PpPmgbKLSsHL1ajUviA9KFIB7MA1R/oN4/3yiM/6aEjamOY4qUL7hxJKrx
 W
X-Gm-Gg: ASbGncv7z/nSk9tGD6L9lqh7HIMkYXtfmFtVpq1SrRvzBWDGmNg8L80A8tXfRjjbRga
 87tlDQpmaWItWWPyYmm3luVl6sNszR4GwSAQkrJp6P9D+fWjQ5VK/T1z9l6LnpidiBrl/QIGF2P
 cbg/5Vb+/wL3fcyFoTfqF+qUnWJB46j00mObzzLS1sFNU6gTcXZttTS+mrXeHx2R+kNaJcB7b4I
 aaMFqmBbldwmrCeuGLpYaajsOF2wE2azaYtLmIFhUel39QzquFB40BIHBLm
X-Google-Smtp-Source: AGHT+IFU5ZMOzQ6Hu0uGs9UwcPRaHRlYja1z/LX7WiLgRQTJV5K7Jq6W3EtVH5GPe9DMdRNdOXSmcg==
X-Received: by 2002:a05:600c:1c16:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-4361c344b7emr29878255e9.2.1733934040246; 
 Wed, 11 Dec 2024 08:20:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/72] target/xtensa: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:20 +0000
Message-Id: <20241211162004.2795499-29-peter.maydell@linaro.org>
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

Set the Float3NaNPropRule explicitly for xtensa, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-24-peter.maydell@linaro.org
---
 target/xtensa/fpu_helper.c     | 2 ++
 fpu/softfloat-specialize.c.inc | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index f2d212d05df..4b1b021d824 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -62,6 +62,8 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
     set_use_first_nan(use_first, &env->fp_status);
     set_float_2nan_prop_rule(use_first ? float_2nan_prop_ab : float_2nan_prop_ba,
                              &env->fp_status);
+    set_float_3nan_prop_rule(use_first ? float_3nan_prop_abc : float_3nan_prop_cba,
+                             &env->fp_status);
 }
 
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 28db409d22c..67428dab98a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -505,15 +505,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_XTENSA)
-        if (status->use_first_nan) {
-            rule = float_3nan_prop_abc;
-        } else {
-            rule = float_3nan_prop_cba;
-        }
-#else
         rule = float_3nan_prop_abc;
-#endif
     }
 
     assert(rule != float_3nan_prop_none);
-- 
2.34.1


