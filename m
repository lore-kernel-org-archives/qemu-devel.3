Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06A3C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2Q6-0006lJ-2v; Mon, 05 May 2025 16:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pw-0006iY-Rt
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pu-0000NP-Bl
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:27:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so4392098b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476877; x=1747081677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U+uJdIaBD9egT3YwSM7u2Wx24dmDX5ceZUE2NcP4xK8=;
 b=q5YEkIb3CC5iM9PW+Y72z9OyM4H2Q0g0b63rxnjCxP2U0EFx9PXoXetUeMNjHO9Dcy
 j63kR30lgKVTlWLQznlW+YmQnWDUUOOtyodN8tE4Ggb/2qcbH/3VP4S7s9Ms4G8b6L3x
 8KOk6lncu52bAwVHBRRG3tBKG8cfB1g8ir4RzN3VEu0l+cDRtywJ4qEDyeCvnSD/qZ51
 stjpMiF7O2xEXbHOejODykXAo578uBTT9UyCmNl/vid8bWZ5yajWdoTdnVLOwwlyUk8o
 N/m7vwB6YW8DDocf+RkrPy5utogdLNkRjdXRsaELzYgJdN8Qkl5ekNf1dtFSl7KivjDd
 tOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476877; x=1747081677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+uJdIaBD9egT3YwSM7u2Wx24dmDX5ceZUE2NcP4xK8=;
 b=XbFBMIHCPUQJT8rlpJ1Tu1v8+f9dJKzppfh6gyNLk+AIvjU4I3zkZgRLK17R2fzOnJ
 2QhOGi3+CpT8Ij74CquQySFFm0Y6Lw/WGWkYjefAiDxRR100xo5IoTtbVcjMsxbl5KWV
 dSoOkfDDRxXNQJiYfpUZkOPmkWvy/ZVYv3PkrG1aMYskUBjNclSqlxgkhqMNe2YZuW3y
 hMH+mftzqUnL89qaP2AxNjMQnsRZRT/YvtcS7EaJKxQPQZTPDSxlE8M6UQal5YfjDgOL
 /oNwvIGIqoZq/MlOpz6WF0BHeAEiJoUTtb0hFz1ll43+Idxps3+UrK/v5BsoUFKBaTcR
 zfig==
X-Gm-Message-State: AOJu0Yzf1z+QjbXXAzbr9uto4ikQCKGjnuqP1aCipdWwHXQiJcdriM4r
 o9m/BF3eNZU2F4vQhkZxb2pGVndNWy6k/5J2dyO70sdXZVYyPj8WNHHQbfe1FsepefkC0fwLCgq
 i
X-Gm-Gg: ASbGncvEzzC+ZeD2tLNLvfRf0VDUhitlIw9TwD1So4k78RfYZKMvV8CDjh+7e9p8094
 DbZD6ngHclhGliq0INnelF4KfQCbdOCthb9a0BVIg2thpRNBOTvUk+Z+cg+K0OdYeoKXMZohsFg
 UCuqwC4xs7ifp8/uK0Cb2LpUti8dZl8J4OaA8VQtRGGc4uXNKOTJ8+UZVFBc1R5EHRVPvRHqnAK
 iD70qAKMIKzzmuQifVnvHmhqOgN1VyUw9hSu0LLqIW1+AShYn+KuUXjW1s7wvOVt+oactR10W5A
 whpMp66xFoMtmae006XCN8ORBjfIJVN5gQSnc4U5s/lSgTqLM0heFXXVzBX3eOIexWLGGVZ3jS8
 =
X-Google-Smtp-Source: AGHT+IHoZOI4wNWZbe3dZq+EndBp3cNWV2Ynr7HyxIwLXYUC6pycJMKwTiw8JYsnmjrx8EuH1IfO9w==
X-Received: by 2002:a05:6a21:9614:b0:1f5:769a:a4bf with SMTP id
 adf61e73a8af0-20e97eaa02amr13306519637.36.1746476876797; 
 Mon, 05 May 2025 13:27:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/20] tcg/optimize: Build and use o_bits in fold_andc
Date: Mon,  5 May 2025 13:27:35 -0700
Message-ID: <20250505202751.3510517-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c9f0f46b83..faee3e8580 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1451,7 +1451,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -1463,7 +1463,6 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z_mask = t1->z_mask;
 
     if (ti_is_const(t2)) {
         /* Fold andc r,x,i to and r,x,~i. */
@@ -1484,20 +1483,16 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
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
+    /* Affected bits are those not known zero, masked by those known zero. */
+    if (fold_affected_mask(ctx, op, t1->z_mask & t2->z_mask)) {
+        return true;
     }
 
+    z_mask = t1->z_mask & ~t2->o_mask;
+    o_mask = t1->o_mask & ~t2->z_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


