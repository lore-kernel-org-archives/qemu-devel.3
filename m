Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE57C88E67
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB0-0002Am-CA; Sat, 12 Sep 2026 22:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAu-0001f1-NP
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAs-0001s8-MJ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-86a25369f16so1674498b3a.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267353; x=1789872153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iV2JW6iooGyhZ9o7GgovMAvWd6ICVXFlqq5GOoX9SSY=;
 b=OVMgFt6Xvggi3h3/DCAxWSrj+LGzV9GOXcOzKZtKCSL/fvA5lHmtOS0SsByYBndmQT
 n3F8S90Ix6gprXCllEkI/sd/E3ofF7r/37kjz2qraN2YfQ6BFqGjFNH/Xc5qGE4454mA
 vvcW5yOdbVYV+3pFiPDOYteynenW8xpt3yGNABEs3pqtCktjFdZe2HyOdllXwrBxe8U2
 oc+fF2qht4H0sbNBkSK+Awm7QTTCHZc0YsXcBuiotsNvkMSZO9QkyN3nk1C7sDGh6wZ3
 ZTJeBxpM7NNP2UgjJBjHXpIAIdDVtdbzcFgjA9iP0cZ1U96u58z4JgJ96WRqpvqEhkB9
 cf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267353; x=1789872153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iV2JW6iooGyhZ9o7GgovMAvWd6ICVXFlqq5GOoX9SSY=;
 b=MwEOmsZPAjAvqCbx/8xmwTnrIFupGzleQ9XeMb6lKpq3YLr0vRpRHPJyC0bQcs2aAF
 BY4Kx09WOj1EWOReGYYNTGl9Bhu2rE0Z0pqTj6SQ4jD3wdJ2aZkkf41/BJIpHH54cIyx
 dMrcJ+NgBZVg21ceBr777XTZd5C1PPz3nt/ejKoqQtrlrNxTh4v4NURAFqZrETlyM5X9
 hF77QVzCb9FxIY1DI2on/d/lwl+gVocOoKUWgjdjCXJVy6MCOPhWymEq0Knk8MT8zcl/
 +GeRIlh1Elctq+OdXrt/7XzP0ut9PeLm/zdYpgejTnlco8DfDAolZ9lldu0elJFnyhsD
 wbkA==
X-Gm-Message-State: AFuF++kmeJ2phsi6ENZs6hlyEB7D6c3p4Fc27J3VDgTUfYEi12qEwPBC
 UfheCT2/Gv9gGdFfZkboU9yvPll8fPxpqpI8u5AOYC5If4sJFj7EiOKfsZWNPXONTnKSwDwvogK
 TL4D/jGc=
X-Gm-Gg: AYBFou1vxY+64M3KBvxOygBCqCrq8e9iUPgYEGExTQkJcsPd9CIjNmLykC/E+tNcOcK
 DDh3pCnWeQFPYaZdD/hgsqcIoxkewH5U9BQcSqpADY+h5pqG/DUMvFzFE3koWH+b0bCN2guVgzQ
 5gxUnyBabY32ZWB55tXuHOlWv823uSW9w9jIxvF/9qWidMydnLnDiFmcDP/YDJ70FOOHPpZ2As+
 Q6bHjZPrp1ME8tjAx+qXvOftjfDJafp4dSQvs3fMtNTRBHKm0rvyKTVUvr6rw2omsg+765pRGc9
 /3J+oO+3MgNerZlUQnXV1TvWRXmUuy0DFB+XOSw2LS8KXMu4kIUJQhfV0AzSqasFZfGHUbOYXrn
 XnYvvSaYk96/dm3mcCQY5W8JP3xpmiBj9FIniPab6oEaONS1AYRn8aV2UJ7iIdOTiqLU4gr4S1+
 hyedpFSU7jfL+nuzW4M4lRN7QnKJBIxe4fMiMIOuUBA4QzVINVvXYCNa3ERoLJ+I2GdTt078gyF
 /DMgO0=
X-Received: by 2002:a05:6300:670d:b0:3d3:ae1f:d7f6 with SMTP id
 adf61e73a8af0-3daed617e0cmr24300378637.22.1789267353112; 
 Sat, 12 Sep 2026 19:42:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 47/86] tcg: Split out gen_ext_i32_i64
Date: Sat, 12 Sep 2026 16:37:58 -1000
Message-ID: <20260913023837.741866-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8268762f182..fae6cd7450d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -413,6 +413,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
@@ -551,6 +552,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_ext_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
@@ -2307,8 +2313,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_ext_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
-- 
2.53.0


