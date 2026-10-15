Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C9CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4b-0002J9-7w; Thu, 15 Oct 2026 06:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4Z-0002If-3g
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4X-0007pH-Hg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so42918815e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061548; x=1792666348; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y2THRkcowFt8BXPCKTuP7l9cCUJ2bhNGSwLzU9DTbXg=;
 b=cHztgblmb0y8udRsSC6Hau/c8Ae5u4SGMJP5biiZDEvAyFLQfct3kCZ/yJqvU07kSl
 9TWXow+XOH/IMd9vouqzwVLc94SmKXfN/J9AQU89ZT+L1GypcNcHBajRTgkKe6vQclj5
 lHwFpmdhiuYs3kJgROy4UpVd3BCiKQjkfb4KScHKAdIW4VenZQO7n/JxEXbtPQgF0Tqi
 u1Cwh5BWbAak665lzChgsOlTEcemSzk8qHTYQqKYuParAMU8vvvK2JhFgHD/at/KVh9g
 UE06gePiXBqn4UYQUENH0U4vZTulIgBIxbeFB6nRTqVd1fRUrnW3Wqqp3XDwMddN5URz
 lhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061548; x=1792666348;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2THRkcowFt8BXPCKTuP7l9cCUJ2bhNGSwLzU9DTbXg=;
 b=QhRedbZxc6wxluV8v+eO3I1MpL+uNUw5rXjwl9icp0Zwk+uZDwysqk81yUIk8k7Ouo
 UQoSrAEUbYgkNuEzGvfNNz9ho9uK/ysGSHSzi0K4l8ryudYaXXVvqZFLaCUwdJdH7Wgh
 3OM9rKguEC+DbgDeBaHozMx1W4hZus6IKG7fjDK6QCkf8c6pOnHOSUWOAGyhADiTj0e5
 tH2X/HLum663rwR8JAw8gQE5yNoL6S5isJenE196FZFBAkMc6d+OOnzN78XC+yMRw94r
 weoOVNzQr9mJW63gpIJqqJEFX4+JZgbBOdeVL0FgIU7yIb5+0kPeMzjVOFUoDdrT3XZH
 j6rA==
X-Gm-Message-State: AFq9FYLoXZ68OOiy7kGQjFJM6WVbelMATvKAa3nBt1HIPE9sKxU1a3tj
 Fadw/Xg4OgZAcJsmA/vMk9u2Is9DeWcq07OV34GJPfhpgTKVrRt27Wo6TalWEBu2DiFoGRkO6dt
 K8mxyiaU=
X-Gm-Gg: AYBFou1jLRUBFZHf63i79xqdTj0fP3Q1vUaTuM63Xlni4tkWGkUyzg+ocrkpWYF8MWc
 zhs2UymQ4r8nhnJ0PMG29yFu6W8CtdupwV8lVunHzzYDA9bi3QRtyhgFdkiG5VJ5hrFr+3SbbkL
 lj2EIhalUEc09UbFWE904z6XS0BvapsKYuQ6zUIO8DVKhP/4cqykplLzP3zjft331X5OY3bRyA6
 bg1OIJVVg6XlOgYGE8VCJ779Twmx0TCvYFGFt+qg2r3/C3bbWWv0RaPvNlnShwXiRXHqDnfgd1N
 8f0sIEnWIYsG4ti+IigHpgupo9ESNJJnPfJfFqIhGWbB1LR7sHdqwyNWUTR3O2SQHEiFrRtaAgO
 sT9johN0+laOMmgksVUfWaUc3FdcqyUSYchipK2A5eOB6L4ZvnKj/T2C9USuwlQsaMsTXWEfQ2h
 x+eO3nFtFuYx74mg+z6jiqOewsxIa8i6RU2EIi4wSoUFjpe0rA2UGBQSivoWmzsfgtSP1VvFmKj
 0jjAXtoWDvFH3lgrLnChD7Dc00p6xMP3jgyFQ55sLe1T3xqVewKrcEfxCa7YF/h43AzYI3EKts9
 p01AMe5Q+/ryOwM=
X-Received: by 2002:a05:600c:810a:b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a18e4a954bmr355010125e9.21.1792061548034; 
 Thu, 15 Oct 2026 03:52:28 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 05/16] tcg: Introduce tcg_type_bits() helper
Date: Thu, 15 Oct 2026 12:51:57 +0200
Message-ID: <20261015105212.356392-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Add a helper function for computing the width (in bits)
of a type. Use when appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260928113938.3157-1-philmd@oss.qualcomm.com>
---
 include/tcg/tcg.h | 11 +++++++++++
 tcg/optimize.c    |  4 ++--
 tcg/tcg.c         |  4 ++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7669dc1c2db..2e005189344 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -164,6 +164,17 @@ static inline int tcg_type_size(TCGType t)
     return 4 << i;
 }
 
+/**
+ * tcg_type_bits
+ * @t: type
+ *
+ * Return the size of the type in bits.
+ */
+static inline int tcg_type_bits(TCGType t)
+{
+    return 8 * tcg_type_size(t);
+}
+
 typedef tcg_target_ulong TCGArg;
 
 /* Define type and accessor macros for TCG variables.
diff --git a/tcg/optimize.c b/tcg/optimize.c
index c631f690afb..294eb5ed29c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1704,7 +1704,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
                                           ti_const_val(t2)));
     }
 
-    width = 8 * tcg_type_size(ctx->type);
+    width = tcg_type_bits(ctx->type);
     type_mask = MAKE_64BIT_MASK(0, width);
     len_mask = MAKE_64BIT_MASK(0, len);
 
@@ -2279,7 +2279,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
                 op->args[0] = rh;
                 op->args[1] = rl;
                 op->args[2] =
-                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
+                    arg_new_constant(ctx, tcg_type_bits(ctx->type) - 1);
                 return fold_shift(ctx, op);
             default:
                 break;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ecc1f54c1bf..65d3190a8ed 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2883,11 +2883,11 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             if (def->flags & TCG_OPF_INT) {
                 col += ne_fprintf(f, " %s_i%d ",
                                   def->name,
-                                  8 * tcg_type_size(TCGOP_TYPE(op)));
+                                  tcg_type_bits(TCGOP_TYPE(op)));
             } else if (def->flags & TCG_OPF_VECTOR) {
                 col += ne_fprintf(f, "%s v%d,e%d,",
                                   def->name,
-                                  8 * tcg_type_size(TCGOP_TYPE(op)),
+                                  tcg_type_bits(TCGOP_TYPE(op)),
                                   8 << TCGOP_VECE(op));
             } else {
                 col += ne_fprintf(f, " %s ", def->name);
-- 
2.53.0


