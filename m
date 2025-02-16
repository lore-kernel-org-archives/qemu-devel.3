Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5067C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmj-0005ej-Hf; Sun, 16 Feb 2025 18:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmK-0005Ua-N8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:24 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmH-0005Cu-MS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:24 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220e6028214so58311885ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747420; x=1740352220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72cGlcfTXUkZ8eDE1OmXiJGkbM/2dDEjFpS0ZCtWDGw=;
 b=AJSS+QEho2l5gj3AQvD+iGHECMXM+llz20oEcFAWjEcFumthtxccGiRSfAPZW44ZZk
 MPdbK4XnjPafNz343EhP1H5Rlnbi6bRi3n+ey2lgTJ7thlGOOb2Kq5HrYI1hHyYIrxDt
 YE3U6qqDzNERBa7syth4sAoLfzhr/1YcyFhwjIV7HaVfpjI5nR83OldX1gDaOIiAgxgG
 mtfEHjy50c4vl38ZK1+kmkkWggtIA8tnC2mZs2X0Tbr9SocwZR2pdPAtEocCbwQ5XaaQ
 P3OPlRn64Fu953JPy9tR9YcVOdZZeh+idlS2n53Dgs2EgQZ9ObkJAu74Q7DTZyF4GHLn
 s+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747420; x=1740352220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72cGlcfTXUkZ8eDE1OmXiJGkbM/2dDEjFpS0ZCtWDGw=;
 b=orHOxibl7mWcg0vOjPZgkKJJzhqeCgZNvoaBf0QmjTuCRVuHF7549V+OZBDwy/jjCC
 g3ZUVr7nxWRuNSKiSRsYHe6+8C0Brxo2MSZmf/FtBrdzX110dYtKTsHLwMU1Cipwea9S
 XPPpFoaaArJwvE0sMXCn5LJL0qK3hhLVM42em/p1bTbpbAL95oDoHVgGi2c+uKGnOcFF
 SG1XbFcyGkXu824tdQa4IFMFWNyyYYvJq3OW91lJXLSqL3Bo7HwZZDH1+lkJLf+5IeYq
 o8ME2OCjd3DGeTkWoO6p394b2iKl4yU8xcxf0rETGzpB76B4yAXjtJ5C/nSBMH+jjppk
 Rpjw==
X-Gm-Message-State: AOJu0Yz014b1TL2JpeO1gtD0Rq5fKFW8YCnJ5ksFNEdfxN+m3kw2soce
 Vs3sKNo1ouckNthjwts9RXCzRpsr5m5BkKXr0pSS+VovrAJQPW+i5XxawzRefbG6g3l91ahqDRR
 v
X-Gm-Gg: ASbGncvTU5eXCJbABw+jpoIb83z9CG/IFFOPwTfJQRdW5YHrFvdzvegy92ngM+nK4ZU
 ue2G6QEuRoJt1XeWAnRukegYUGlHRD6HXZm8h6yr8l9DvxUhX/3fSFpBiHVLHSZZe2nUo1rUKEw
 y2AZC7HHdTTX5kdD/gO+KjEoy9hM4GN/ZWsVMT73dkg/ltUgZmAg2zOO4tJmA8w8+r5TE2EugtH
 dGeEgUpumjy8UstX4UNqY1K/TbjFDdzuRlT1PQ/DatvT5+0A0BxSeU4T1K8+j2opK0hcjWuLQpv
 MKZUGtZaTQ/36WCINwh6/l3lvUnl69QbOtC4q0O7XFcOGoE=
X-Google-Smtp-Source: AGHT+IFi6eOlncgQR+7P7zryqxpn47nQrfPYl7p4V2KEl9FyebH3uP5Kunf7z1Btw2Ef7Hwn4mvXJA==
X-Received: by 2002:a17:903:2312:b0:215:8847:435c with SMTP id
 d9443c01a7336-22103f12d37mr124956735ad.12.1739747420320; 
 Sun, 16 Feb 2025 15:10:20 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 008/162] tcg/optimize: Fold andc with immediate to and
Date: Sun, 16 Feb 2025 15:07:37 -0800
Message-ID: <20250216231012.2808572-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index f217ed9366..0b84d97051 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1331,6 +1331,25 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
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


