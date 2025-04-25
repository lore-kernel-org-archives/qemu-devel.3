Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C2C369D8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0w-0007Tq-J9; Fri, 25 Apr 2025 17:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0r-0007MG-8w
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:13 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0p-0000Wv-0j
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:12 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c277331eso3825006b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618109; x=1746222909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ts14z2jiwf3lxG64Ck5rNycenfCdM+STE01W/oP8+I=;
 b=iRFWCLADGUMgThxTNcv2ctfzgF5lCxhGb+xTbN2WlztgU7YIqMnid4SCr9yj2yNJjZ
 3oZMM8wzIiagRg/uVGyYJezuTCBt0rp2utsK4XzFKv4XFOhTJERHAGLIkvIyVDf8qmhM
 BMaSGXQAwD9c/YGo17pnHINHudFfkG/rqKpnfWOfJKohKQQRI1mjQ8Py6cwmV1583MQi
 /hQ3bzMs7V5zM8NHHgYdqi1liiAVn9yKiwdhZAJIoWIrByH1jofPFJV1awW78QfZDk4r
 yrK30y8QtO0uyChLQXEMdi17IqdvNuCrlN/gWNQvRHPi9P86olfjMEQSi6QODPyphQ+v
 QNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618109; x=1746222909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ts14z2jiwf3lxG64Ck5rNycenfCdM+STE01W/oP8+I=;
 b=j3poM/pT1hYR0cseAz2Qy3z+FihCRAo/jGdcHIrxyzI+DhMHT0ijzWx5YovO0wDyEq
 jLEZ/ysl116mfA5Us8q0kHwSv46QGH7wJMmLoGTFxd0TUCx+McKCGQXYSarpGCLjuAnZ
 L+k+zSKSuH6zgeUipz/kdXmESyKb6KPynfcCzepbXYhjJ8iXHxKDHnC4BC4IEnkUmMVM
 5H9pfV6WH8I0Pb3Tta9eOFPSXf77PwSV2b/YHSLIFY8rGweYPl5dwW579lI6GMYorZU3
 XxpDAFec+YQq7hWNh0R9PV+i3LLspSlOK94ROyFKc3SBuQaICAspAbRrj249VJTjOyvB
 oW9w==
X-Gm-Message-State: AOJu0Yz+NN96n3wg9tlROtAQ9atJXDaSVv1wc9iA3RP1nAcMmQ9xKD3U
 Di6WIZv5MhhDjiilFs4ZGNgIv2f4oLNWp0XV6Qsx8DZQFJL4eYuN/ceV7qGqpH1biGEfbZSK8MC
 a
X-Gm-Gg: ASbGnctlmwpIT+tA4pcMnU5H8GS6RewpJe7372jjz5PNC8Kg2CU5aWGBuTjDs+E0Wc8
 C7EHUrQ77+80r+07KDUd8qutzt2fgQEgml/tRbNxuU+Xjju0XeSm6Kk34MHqKCCvTaJZWS/McwK
 Wb+s5h40iZdtnIZSJz9R5moVhDNL0UtF34fik794Cf2MRDqmiyCHhJFm4ALlyBQ99mk7Gl7ADqe
 alLnt5kSutJWpm6pnifMSa0Y5LXmtlcCE9NOG+dsoFf1NC1LOtYWgUIyZD4aIcp8zVMTRyu/IUp
 LqVVSl2ft5qAUBXadDMmFq8SxlWM0/sZlGriBNTd2eB8jsHslbIvlz2+xO3Bj8gtWvf+dy7jJKc
 =
X-Google-Smtp-Source: AGHT+IEedzjyNvlEN1nFVcCz/N+H8E8oAYzSfWbpfRvJM+8DMOXomL1Aoqof/zOckexCdAR/rVJnSw==
X-Received: by 2002:a05:6a00:6c98:b0:737:cd8:2484 with SMTP id
 d2e1a72fcca58-73e267e25dfmr12819860b3a.6.1745618109481; 
 Fri, 25 Apr 2025 14:55:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 019/159] tcg/optimize: Fold orc with immediate to or
Date: Fri, 25 Apr 2025 14:52:33 -0700
Message-ID: <20250425215454.886111-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7d5f7af223..684b1099d0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2143,6 +2143,7 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
@@ -2151,8 +2152,28 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        /* Fold orc r,x,i to or r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_or;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_or_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_or(ctx, op);
+    }
+
+    t1 = arg_info(op->args[1]);
+    s_mask = t1->s_mask & t2->s_mask;
     return fold_masks_s(ctx, op, s_mask);
 }
 
-- 
2.43.0


