Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850AFE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5H-0007BM-Fp; Sun, 08 Dec 2024 17:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5F-0007AR-Fx
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:01 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5E-0006Eq-24
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:01 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71deed20e69so251201a34.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698139; x=1734302939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xxQ+Dq7R8GnM1J7sgIMgZ9zk0m58GoMVFOUgAxTchA=;
 b=r28TckVR3dovnSqAfSZVj4OhWo5my+T/O3dIn38DjlSHMmPEvFnrMEfqoJ5iQguNwH
 X1Bt4ARqJPP5MQN91j2FcjC+iXUGtFrlaq0jfaWBkHX2u3E9lzh8SsQsITv4tPlKKLqJ
 7z7mdu2TX7QoFVa5gVjqige6k3Cr993s+eFlP4p5qwLM4eTQ4xp4DDGBAWO2wGQXi0Q6
 Np1bYdVg7/4ud73+o7KcGLiW8+NrrwwP3q6vrZuf/Gb23qP6szFgLhnwT4SZZX5qXW2W
 iXKvSKmPslpYTL6GAkzc2+aB8IDjdg58LmQ7h9CmDZKcT3oXJDO+ufpOfGsCeyr1uGLW
 m76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698139; x=1734302939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xxQ+Dq7R8GnM1J7sgIMgZ9zk0m58GoMVFOUgAxTchA=;
 b=CvzOWqBmp4e074xgwi255IWgOzP2k+0P4Qybp3Fbsh5WcxWAkuSIr1I4GR2BwHjVJy
 6XC4vMMX5FRbyX3ANUjc2wNxeZPGA3eFUXZ6qtfvqIrzsZN54Bse93txsI5FVMS+zjW4
 hQ2/eAcxox9j+xZnQNPvJZ5juXCw9/zloi3+teSihex0lvAV0PTJ6qPZoXRBvk1/BBHa
 oMJGW0bDqQGpYXaahwnSyVOjgS8TouhDCAhWrqJDGSayNXcsI9t4/W/0nGXPFeo63/lQ
 ZRlrUcC0wENaBAnRjKpHPeiW1R0InbzkhoTgBrxp+svGPmBbBoNN4eZ6231xsiT7Cj5O
 WHyQ==
X-Gm-Message-State: AOJu0YwpB42H4WxNchPhGLZdWwFdoGqTyNWgkLMvIfiFgFLLNaRXhBcU
 6F+H9vrdVu+JfPkHsdoHwxkKVBzdlBnk4l7FF8h1Fl9lNzzf6CP73J2tffBO4wusvKGQI0hpprf
 3V3Lvgw==
X-Gm-Gg: ASbGncsZSjmegayJvRL5AuO88pN+HWaewgVArHT2LaQRpuUvQjJNbYxvB/oBvFmjeDk
 i+Jt8ur4wIc2R0uzoXziFfrMjvx0JYJ9D/eGqdRvdSj0LDTkKU5TJ4UfBb0HQoxLQi8/LWBYxU+
 YBaF0IR/+jOrQNEsWoPq4I15dVAmdthFVddYlRI507yW2HpLFJvpE5FRlv4/Uk7jRnlkBggKv+n
 eDgvBzs6cBQgNieUgqh0pqzOvqpw8PiGZedITraYBA4Pc2c2i3BQLpwUimBBDiAoraFi9VJ2nko
 n5vI9qKYFv72tRRLGEn2bE/psXVqRf+IzxpN
X-Google-Smtp-Source: AGHT+IERuQph16M8PSd9N4kNcsyFTPSDkZD5rhoeVbLnzaONZiBvPM8RvWfBbgi3Pt7cIF5PGpR26A==
X-Received: by 2002:a05:6830:4114:b0:71d:548d:6f76 with SMTP id
 46e09a7af769-71dcf54b629mr7206117a34.26.1733698138847; 
 Sun, 08 Dec 2024 14:48:58 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/17] target/hexagon: Use float32_muladd_scalbn for
 helper_sffma_sc
Date: Sun,  8 Dec 2024 16:48:37 -0600
Message-ID: <20241208224844.570491-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

This instruction has a special case that 0 * x + c returns c
without the normal sign folding that comes with 0 + -0.
Use the new float_muladd_suppress_add_product_zero to
describe this.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index aa5ab4a31f..eb010422bf 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1192,15 +1192,10 @@ static float32 check_nan(float32 dst, float32 x, float_status *fp_status)
 float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
                          float32 RsV, float32 RtV, float32 PuV)
 {
-    size4s_t tmp;
     arch_fpop_start(env);
-    RxV = check_nan(RxV, RxV, &env->fp_status);
-    RxV = check_nan(RxV, RsV, &env->fp_status);
-    RxV = check_nan(RxV, RtV, &env->fp_status);
-    tmp = internal_fmafx(RsV, RtV, RxV, fSXTN(8, 64, PuV), &env->fp_status);
-    if (!(float32_is_zero(RxV) && is_zero_prod(RsV, RtV))) {
-        RxV = tmp;
-    }
+    RxV = float32_muladd_scalbn(RsV, RtV, RxV, fSXTN(8, 64, PuV),
+                                float_muladd_suppress_add_product_zero,
+                                &env->fp_status);
     arch_fpop_end(env);
     return RxV;
 }
-- 
2.43.0


