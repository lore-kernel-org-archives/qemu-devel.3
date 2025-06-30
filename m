Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D046C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRY-0000Nz-Cw; Mon, 30 Jun 2025 11:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0000MX-R6
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:15 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRM-0008CN-Tj
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:07 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c13802133so689138a34.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297342; x=1751902142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yh/Z6IcqrEAchgIs/HAf59KsDGYMrGPzRcjMoo8cwK8=;
 b=U4zc9Gl6YGKZnVDkMfAnsgeKOtoYbYG4Tl3CFUmqWmoweyiz3Turn6J8HQUQ8yNO/n
 3vw7pYVMpSpwo2/EmbIQR3xxQXBhpzqY9HDpzndXvj+UC4W2J2/D1z1q6ZokPLXMGp09
 wCKatxMAIJmVPGIytmKfeAozRR6UzbU6d8vpFFxIyYSOzEhDfGMq1d8vyztoiT7gSyfs
 jqBu/9iVokEZMhUeUOJ5bvB7lN8Tw2t+tMkutpV+cAcFmfs+BJepVm3dZQf44L7b6w3m
 cHg3rAmOQZsY+O+jf/VwQkK4BO2EjqVSqIeuBRSATOwBIqE7VW837tTQeCFmHenHSdLf
 GYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297342; x=1751902142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yh/Z6IcqrEAchgIs/HAf59KsDGYMrGPzRcjMoo8cwK8=;
 b=dEfrN9+dSGWkevllhNWzfI797+JE8KKqt78MwdmOWsbzdGTkyprVXK3acSSEwxiyx2
 Rpp3MsH6fsJV7LD1MIl1Fcquts50HwOgXR7b7mZvy6Ujjip2wqoN8C4fevwB901RRJMp
 ahYcZLiwC45Dib5qsQP7bZ4xdhNG6/HIITL20wqIeNodzcwSsPUDSpMg2T857U4pQ7EB
 wiU7iNapHGUq3pTUeHUB2ylYDdLPOZBtzKGtrP4JCpDC4Y4ltQHmnzdvWPq4/KwM5Hvl
 QI9ZaJYEW30wZ89lSnh4IwH7gVUDW0Zd6WK6CRaDFV4rcnU1pextYK2ui7LQ4/qDmydn
 fvqQ==
X-Gm-Message-State: AOJu0YwHHCZdYkkUtz+egB0HvFWsQDF2VMvQWYH4fK1Sf56dBURg+tUI
 saNjDZV0z9j3Qjf+NTJOo0qPQ72cjb25Q5KWx56H3q5KPkXHrQeW1OPbe8GEU2siJvpTILOwyuF
 m54ji
X-Gm-Gg: ASbGncvQHQnr0y57xKKY3ZetIsYH6mhmU7gnNnXa1IVvCT+tRQo1HY94JqJHZoGtUgp
 ueX7+GpkpNPLJTi0Dc/+vQ8pdVzQoQJvIZ2eRCHOfoFpNomRN9y9K5U9a4q6RckHDuc/Kb2b+f3
 YkaaSekZTduLX2SETJNt4R6GCM/Jq4KCHSmIPeVHYE6pjYxNSjptG5T/OE80NqrAhcDd0dqO82j
 5EEeXMailUUVJjc0p/RO1knUZ7uuyRlJU3Mkq0vw03dldCYr7DJxK9jh0CTLoUbWm7qYh4ogynU
 JBKgmqiMsbbvJzmQLaJRywoEts6/yOr68dB82uu1+H8nN2lXNQqKTMAam7YcpzRGrVN+QQK+M6J
 a/jDC
X-Google-Smtp-Source: AGHT+IEf1SYdbhSZ98xwb4RmNoV/X6CPJ7W1WySCrZZjvOr9QZYhKfPqHb0EqHbS6QQyoAUXSVv0iA==
X-Received: by 2002:a05:6830:6086:b0:739:fc48:6831 with SMTP id
 46e09a7af769-73afc6b2111mr11532843a34.21.1751297341845; 
 Mon, 30 Jun 2025 08:29:01 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/29] tcg/optimize: Build and use o_bits in fold_andc
Date: Mon, 30 Jun 2025 09:28:31 -0600
Message-ID: <20250630152855.148018-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d9ccbb36e2..123734b167 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1452,7 +1452,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -1464,7 +1464,6 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z_mask = t1->z_mask;
 
     if (ti_is_const(t2)) {
         /* Fold andc r,x,i to and r,x,~i. */
@@ -1485,20 +1484,14 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
         return fold_and(ctx, op);
     }
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer anything from it.
-     */
-    if (ti_is_const(t2)) {
-        uint64_t v2 = ti_const_val(t2);
-        if (fold_affected_mask(ctx, op, z_mask & v2)) {
-            return true;
-        }
-        z_mask &= ~v2;
-    }
-
+    z_mask = t1->z_mask & ~t2->o_mask;
+    o_mask = t1->o_mask & ~t2->z_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    /* Affected bits are those not known zero, masked by those known zero. */
+    a_mask = t1->z_mask & t2->z_mask;
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


