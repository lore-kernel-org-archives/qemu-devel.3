Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C839FE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSQ-0000db-9c; Wed, 11 Dec 2024 11:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSO-0000b5-FE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSM-0007nh-Sr
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434f3d934fcso25241895e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934057; x=1734538857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6N1dihOamyfHYjM/z+kdaJYMimdmA9nR0DIGLi0bWbc=;
 b=CRs2wdnegP4wST+YS6IB36bNOf3fpHXsy2nra+UrBHwt+/yhLBMsFO0uptvvJsmEDx
 3ObBKV0VOkO+GZeLGIWWWuz8z6ZDP86GcKSPWZpL8T9M2KoaraIBQAPqvIzRXoCwm1BB
 GvT+4J8QQl2FUBJd8Vc5VaShGshwIxH/X7ZF0ObWdn2GLEsC0a2rVUxQtsnHMFHJNyZ/
 fAq5k4n8rpKmItoQ+OjAhohtIplVEpGKdRNc1L1tXlG/gAB3eIHqLPSRgl9QjbJfsqaK
 rTmxAe6j1uAcrEZ6XT9ORIOIfuxs7YOvFyIVyuUqBlZolL1v7x3gPLYX35ru/5PUeP0t
 trOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934057; x=1734538857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6N1dihOamyfHYjM/z+kdaJYMimdmA9nR0DIGLi0bWbc=;
 b=MDspIGU2j4Ms5T6OWsIp4H25xexCod8x5bCPDBo0Kikq4VLUJzsrzpKYdL493HKJa9
 f5Sxvz+iE5b4PpNWp8kgiQv6ZcN3CGuu2QIArn6Bopr86e/6Knl7IiYcJOhp4HCJ2iFX
 HRtBRAVS8KgUE83MtFxPIW9Ffpl8TAbQEhImNae4oPZKdaxU5KOW9MEf9EhXEkjuf7td
 XJjjrQpkFclxCKPWUSJkf8VEw49lJIjLlSPi9WKcvH2IM35h3JaQc0n3WcxKhOMU2hgw
 m1z8JhxgDE4yuHX59IOELCnV+LcYCZNAkwZWaff6j4tV2EIz9dXn6LIkHTZxPmslC5lZ
 nFNA==
X-Gm-Message-State: AOJu0Yw2dDNJot52nllZrkZyMWlkzkiC6R0XUVkGKnd3VUCH3wp1voUG
 qty40MRlMBjwass2wm3pUSCuBOiIy71k03BkLBhfGBYG5xjWlqyaMxaIlDHhsylXrsqad9CZpKZ
 Y
X-Gm-Gg: ASbGncuQx972lh6su4j1f/BvJVAIVTXJCnOzcX4feuGylfDARG5MRaM52kAWPuCEm/l
 DjRwQqY1CLroKsGpUSR0g2lZ37/8nfaa5e5YTmnLQuxBS3BlWyFviP4uUn8nnzlKodg9CJcRtU8
 Cc/jeZzoyEbnp1IaaEf1QIBMtrsPu4mGPR7tBhFR4L4rupOC72DJwb2hC1DSoac/hIxAVN570n+
 7a1WXmJsgjBRzpcpsizM9lCKveVLTcYI07USY6sFVqQq9Lko5Gha/kaiQ0x
X-Google-Smtp-Source: AGHT+IEWwplHT8Q8see/989Jo34lpPQH+Qt5cRhFhamhHv59GeogPGzzTozucyM5XmV5lCvP26ahkQ==
X-Received: by 2002:a05:600c:1c82:b0:434:a04f:2557 with SMTP id
 5b1f17b1804b1-4361c396b7cmr28014205e9.4.1733934057462; 
 Wed, 11 Dec 2024 08:20:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/72] target/hppa: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:36 +0000
Message-Id: <20241211162004.2795499-45-peter.maydell@linaro.org>
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

Set the default NaN pattern explicitly, and remove the ifdef from
parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-39-peter.maydell@linaro.org
---
 target/hppa/fpu_helper.c       | 2 ++
 fpu/softfloat-specialize.c.inc | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 69c4ce37835..239c027ec52 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -65,6 +65,8 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     set_float_3nan_prop_rule(float_3nan_prop_abc, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    /* Default NaN: sign bit clear, msb-1 frac bit set */
+    set_float_default_nan_pattern(0b00100000, &env->fp_status);
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 452fe378cd2..b5ec1944d15 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -139,9 +139,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
-#elif defined(TARGET_HPPA)
-        /* Sign bit clear, msb-1 frac bit set */
-        dnan_pattern = 0b00100000;
 #elif defined(TARGET_HEXAGON)
         /* Sign bit set, all frac bits set. */
         dnan_pattern = 0b11111111;
-- 
2.34.1


