Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124AAC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueDxp-0004cM-TA; Tue, 22 Jul 2025 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueDuY-0000sA-Sb
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:24:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueDuW-00046r-7l
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 10:24:06 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso5847639a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753194243; x=1753799043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgRdvDymuUcz4ENig7Co8/7DUwWCH2GmvD/UEqjYk4w=;
 b=YMdhR8PM5KxUiv2DbfJUdm3shF5d9ei3vb+sZJeLUySU2qz7eIxgbXRLs4N0yWUh0s
 2nHV0m23CYmkJys4TfjgphIQItccRTQkse1MRmQQbpZigU0ELF0+moKu3/JF/4+jB6YB
 /f5vLWi33llFXSERMDuy8jOnsydwcY8J7o/dI/H9mdFVXpUG1IxY+qMOttzY2xZbJSgR
 erMsGZkN55b61ZaBCcVRaXgZctmjkjbdbsxUtqUM931waKIYLvyppvzy9Q0spqcJL0vd
 awyoYjH7D2OIkZy2ZLQrAhix0GBPCTEUscOlTK3uXRk3SaLRtJ056l63iDKokp0oCe9B
 epqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753194243; x=1753799043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgRdvDymuUcz4ENig7Co8/7DUwWCH2GmvD/UEqjYk4w=;
 b=N4Z+14KBXmseXP9LraAqkwD/rrQYE0aW8TsaVrJuoevzVBzcV4KXAMwbuHuqRKRRjj
 NFDuw9BLTwSup4meff+zQ5gNJcZ+YSt0tALTd8nR5Q5Ztc+tDLY4hxvJluuGzGsbJQFO
 9xFW1oX2s/oWFC/gBJ8fK23O663K22Iiau+Bn/cI31+qqK/h2tICxNwElPrMxQV+N+mX
 LTXA/FGCfutk6UKMai2OAh9JfGZcBDoUk78Fe3pD8jng9SN8q4SefOHecmXT4BJxO2O8
 qfoKrt3gMlaIgiR+ehEwxkOaBYXXgQQINoAH3aNnzp7bJ9KxJjR4GMuJ0ZN/5p6DAtK0
 oBng==
X-Gm-Message-State: AOJu0YyoDGR8XTyEzzkzVZOhClrJBR8Dzh/VZnd+RrtmPXzk/j2LHWzB
 72He+gGqU1jIyqHtWiXM2ez9vvYeeCbiU4QMZ2YskM8wr2H8lzsRrRdEPeznPWbm98VNDj99K98
 epbMx
X-Gm-Gg: ASbGncvdsNza1pFc+pfan6oluxoyZFFQ8OXt8kusrw+qrbaoa++u46zf16s5dd8kQdw
 6kxi/pYct+7qsD381YMFx+74u7tvKI2XUjyQ3PlJJ8L09vreCiGMB16mRagEQK416DIm0Pvldy5
 tfgFJSmYctmgp2R2ERfbb1QZiEZxW6acsrvCHYbkBsolqpZuSMaLN/mPmRHZU3H8z4Xo02RXaqg
 NS8/sQwleJeiY8uKoMpfVhCOvSTZBPACWK9FdUl9kkLtAnoF3nIB6P6Q2AQy1uq4dQAf9zkJREq
 d7ymqDZMCmWaNd8okcCZ7JJblc+0FwQHgJlnHRgUMJOe26dAe80XIG8MD4GEX7LOtW4YQpZlr+M
 zPCGsC5mtnAeiARVxYSAEePXAJrSB
X-Google-Smtp-Source: AGHT+IES+afgTL+0ZIuMe24b0dxekY/hjdL0umQJUUmCBXozckAHMOmGpgHsZk3TiP3RO969iYBwaA==
X-Received: by 2002:a05:6a21:689:b0:220:19b7:9d6b with SMTP id
 adf61e73a8af0-23810b4e1b6mr41974923637.9.1753194242713; 
 Tue, 22 Jul 2025 07:24:02 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2fe653a7sm7274980a12.2.2025.07.22.07.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 07:24:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 1/1] tcg/optimize: Don't fold INDEX_op_and_vec to extract
Date: Tue, 22 Jul 2025 07:23:57 -0700
Message-ID: <20250722142358.253998-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722142358.253998-1-richard.henderson@linaro.org>
References: <20250722142358.253998-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is no such thing as vector extract.

Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 62a128bc9b..3638ab9fea 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1454,7 +1454,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     a_mask = t1->z_mask & ~t2->o_mask;
 
     if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
-        if (ti_is_const(t2)) {
+        if (op->opc == INDEX_op_and && ti_is_const(t2)) {
             /*
              * Canonicalize on extract, if valid.  This aids x86 with its
              * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-- 
2.43.0


