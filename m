Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741C7CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKs-0001jY-SB; Sat, 16 May 2026 20:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKc-0001f3-2R
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKZ-0002fh-R2
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-834f1075805so858057b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977566; x=1779582366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RFzxrZgIp76/g6uZzqeb4ErU3uXRZCw3p7gJi8brWB8=;
 b=mZUbHRK0R5E+TpBth16/isQwwn/X2sCdqxYaI7eZfStZsgzF4W84E7PFoAaBgi4GPh
 liQanFrO+2MfdVfeFzVTYtcCKfqnOaEWoiaVxAOJd3NHe5dXeOA5RpxnlA3GDQRx17UL
 o/o67qOrcRUWX/6holT0m6zwWmvT6ZnXYb1pSXz4WfpdX++1E4bTWIMD1ZpqaBgmjziC
 VFEa9v0nQKB0zRBgn5RrHv2JOBYlGSSVPMQCIdLh4H6IwTYiX/qMn0idA+hqKwZh7pw1
 7s/CY1eBAvzb45EiBZudiCuHVGOM8Qxs+4b7RJ0kCEh4L3nhShn50mTx+bPxovey1rDR
 X0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977566; x=1779582366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RFzxrZgIp76/g6uZzqeb4ErU3uXRZCw3p7gJi8brWB8=;
 b=HcgF8bncWf3GLZHxilBiF20EUZUXObWtD1yCUTQXaE4E1AOcnAu4bC0jDzsFIIsEjI
 8Vos14dPEmtgAq41LoyyYDLeTzecp3ggCjg1VdYCrxJOCkqfMyRSP5RdYeoQcdD+tVtP
 23iluDrLO77GRirzzDtp/JTuAv5WYvQeO/1VZLPRuPr1C4dD+3GpGhjEuGZEJk2f+aPA
 4TFyYXrRRdGHuNS0+2mYGdBtjt+B28c9KA5SAh7kN4RXR3ctf63uoMFSilbnUFbbUMni
 VuQGGleyYRc3gJwWRlD6ZF48RGvk2/aMUprpZjzfC13d7XDKlXMqWdAVKpftLT9BgAE3
 z7XQ==
X-Gm-Message-State: AOJu0Yyjz/ABnoau84+Y5eDVJ091wh6XZTGsrxF271VMjnznBKruC7Ny
 E04LySlETWrfoyr7qv1sFYXnBGy8JFrb0H+kINHwuqMeN7Sz4GAN9pSk9VpXH+RwByBgTiui6eR
 I72EE
X-Gm-Gg: Acq92OEjl/H60aVncysTqwqtYbMoQIvCPA/m6wTd6pBgbgeEOW8V1/K+d6am9yjZY5p
 StPuZX43ozETphx+naakW23kOTx2Fk6qP64Egd3MBouddwuA3I45RK3o3ogOAaHfqbjBHLcPMXU
 QoKxqQeDT4GJLlR6OULOD3PxYheJZRGiIian7E5872P8q22YRaheXmpOV77OQAw4JvGUImgStes
 aCZeFeAvKzNsE2BVOh1FZvEE1NcSUHUwxuuXkhtBNkNi5esA/JbGeL/52UbGaM1dYHsnsj1bdC7
 7TQenFMO7Lq9ZVzhiJUwZMVpd8xTJuZ3eFMUD8yfL3Rw4b/5T6LIHUDQQ2bE2dKIEbv0hRqNoBP
 VDntxTCSLxrXeJbpAh5RRmx98J16AD10eCZy1VkI09U6qXZN73+3EuNER4TBP8FDD56FPoQ/7lg
 IRFLi5DmrpAHwZutBW+KC0rEZkv8aM5bnmD2i1aMk=
X-Received: by 2002:a05:6a00:194f:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-83f33cf2aefmr10301311b3a.21.1778977566331; 
 Sat, 16 May 2026 17:26:06 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.26.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:26:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/12] fpu: Saturate the exponent in uncanon_normal
Date: Sat, 16 May 2026 17:25:48 -0700
Message-ID: <20260517002550.321291-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Notice the conflict between saturation and rebias_overflow,
which should never happen.  Otherwise, saturate to INT32_MAX
and allow the usual overflow to max, infinity, or dnan.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 45606f8402..914e588ec8 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -341,7 +341,17 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         g_assert_not_reached();
     }
 
-    exp = p->exp + fmt->exp_bias;
+    /* Because exp_bias is positive, we can only overflow past INT_MAX. */
+    if (sadd32_overflow(p->exp, fmt->exp_bias, &exp)) {
+        /*
+         * rebias_overflow wants to compute a modulo exponent, which
+         * conflicts with saturation.  That said, saturation can only
+         * happen with scalbn, which is not a PowerPC operation.
+         */
+        assert(!s->rebias_overflow);
+        exp = INT32_MAX;
+    }
+
     if (likely(exp > 0)) {
         if (p->frac_lo & round_mask) {
             flags |= float_flag_inexact;
-- 
2.43.0


