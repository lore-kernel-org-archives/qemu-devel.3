Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A757C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0t-0007Pd-Fa; Fri, 25 Apr 2025 17:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0n-0007HZ-DI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0k-0000Um-Bi
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so3680114b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618105; x=1746222905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DKhAMUQPDe+QM6xhz0FegIZBqmAkuabH4xRLwdAtM8=;
 b=Q3hCeifpN80jE5MoIkXxLOz3ksCKNFBHY/EFyC3rW7gbHPGFcr4sWXeVKn5hdEwAfY
 v3SpEt3is7ALSe5FyfR80CFC7dbwXpgz2r4drGKnlBqcxYiEyYUDWF+8QSyCtLqgcmh+
 GLqlvQTwJCf8NWLjAXQAhTw34NkqyKKJHHTTluM4nf60/0YryAfTs2VVDrQefMbSpUUh
 EwYpeZptCwQjnlcJTVpgZe5Z11cUvd6Ucyzq/FqTsilk7c3pvUfNWbPGRHdi2pMtTESB
 ZntTJ1Gryvc9fWydYVEscLwOFKSA7VxVNphHnwEU4+OYUyWz88JV6I0JF0xxnhrtkppG
 T32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618105; x=1746222905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DKhAMUQPDe+QM6xhz0FegIZBqmAkuabH4xRLwdAtM8=;
 b=TShFOp7QDEbl0DO7g4xAJKYhiJ75LmH+s2//wLDTgqjs/OwMkrBhp2RrbGb5t+2dKD
 VemjyThuwtrpxEqaGJSp+v45DPLZSM5GnJjdSdbf33y/X0XGJxr3cDdCERbZ4AsmCklq
 Tq3VidZAJvhNPEHeTD+Ivtghm2rjerhsNtwrAb92XxV1XlpQl0efRl45vD981TgjJk55
 +8PB1baM4TQxx6nj2u2oDXTdVGUuAnyFV350vk1IgWbRZj++E4N4m54XVqiKqmymf5+1
 T/r9oT0hzFrn1CSnGKq9YYjIW6LAkIyb9lPslhkyZ+H/KnXdOpP/57tgjHv5BSZil6G/
 0XaA==
X-Gm-Message-State: AOJu0YwzGXrwFp2i9Xab1IrjmxvoNI0iTCQbS0AZv/T/42waRbiOD7Fu
 PbhknvjHrTqqj8neZn9ajxExqG+otX/ztVUsr6bh+lsJ37ZVHdAb+Lrfn3edZbu+loOcbJh0oB8
 c
X-Gm-Gg: ASbGncu6fcYPInsXa+UCYntFJVNwyCHFPI1oDmtleYCLhyWjnSmj4RU9JusPyYLIX6p
 CxUzEZ6x+VFINPqVuBOOnal9OtFdrOh+b9NMqjM5NQ3VcthvaBd+k/aVkMbXAfOHYQXaPRKUisI
 CEcqULgMC+sVgmzrvjJXVDWjS57nxTo6gNC55E016k1vB/SYR59QW5UCU0RwGICWnf5DjyNEQt1
 UWEcXf7HjVj1jgzUJCFBbep9XzaNV4bj8Jtp3cnAKBgGeHM21a9tpVCVFAT3u13Jvb0he6PCzd0
 w4y9hQBffrbJsolOtWMM9YmV6eJx11yjNVVpRJO5fQ6lpl6bqjxu+4DnYn9hiFBh+pGF0EKI+bY
 =
X-Google-Smtp-Source: AGHT+IFgOg6/K2qv2ilFllilr8ylL2Hn1QVq0WRZL8pQh+hM6W7RAhRRQEH2GBFtbIJxc4/lx84zfw==
X-Received: by 2002:a05:6a00:3914:b0:736:ab21:8a69 with SMTP id
 d2e1a72fcca58-73fc7a58aacmr5675835b3a.0.1745618104778; 
 Fri, 25 Apr 2025 14:55:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 013/159] tcg/optimize: Fold andc with immediate to and
Date: Fri, 25 Apr 2025 14:52:27 -0700
Message-ID: <20250425215454.886111-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 tcg/optimize.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 20cde598fb..1f6fdee734 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1343,6 +1343,25 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     t2 = arg_info(op->args[2]);
     z_mask = t1->z_mask;
 
+    if (ti_is_const(t2)) {
+        /* Fold andc r,x,i to and r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_and;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_and_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_and(ctx, op);
+    }
+
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer anything from it.
-- 
2.43.0


