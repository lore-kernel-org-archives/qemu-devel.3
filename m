Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D31FC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyA-0007Nr-EZ; Sun, 16 Feb 2025 18:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwi-0004Ra-3w
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:11 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwb-0006Sp-DH
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:05 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-221057b6ac4so19406215ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748059; x=1740352859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XpMdeCbNzg3JmqdW1xzLz7fjwZKDUFJmzeS0cLmNFrg=;
 b=ZB66fo4Vz6JvGo0JscWxMiBhqDMppD6OSLtu0IOtxOb3AqVkHn2UYA7c3LwYCxIyNO
 IEvIVOGAM87lIbO3xDjZjQ7d1LpJdflVoL6tomRwztK8fUD81g1f175F2BoZ/P2tx18E
 h1Yd2dwgBPI2IrUw9o9/g6QKC6XNi2wrN06h1ybLXeCK2AjJGSmiHINor6uUuSm8A9dN
 07t7igMdoZ+TRupokg4kSwTIYbwRqL+9nOm/+EIQVcL9q+ujoMMjVxaF3mhJRKN3tRTG
 4CddrMHTe7+dleYVG8Cb7TDZJKfjr21fPutICqOBljTy7ppauGXZKnozHiTj8Oynh6cq
 KP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748059; x=1740352859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpMdeCbNzg3JmqdW1xzLz7fjwZKDUFJmzeS0cLmNFrg=;
 b=hbWz9GDRA3dlxHfR5G+Adf7Wxc8yZLZLKav5NkHHMri6JPhrbzim/S1FfwgVY1LmIQ
 gGz7nkI/SrazwBhGL0ZWBA5Wth7umwkJGdmO4Ccv6ASRYxtLkVUsjDj+b6DYIdGR4MwY
 g8sztsH+Tx0rszlc4YeWe9ZYDXZskjY+FEQOTI3WuvP8a/IrycVzfZn8o268MDhxakq7
 XZzF0v4tW7XWIX9+/ZgfWpdZo2icwEdbQpvBM6Ymf3Y5DMPaZZz6vVqHmyUWGXPZBW3I
 /KtXfC2LgF6mTwntSN95qRHeUm5/0NswY9DmGTJo/9nm1GL3qy01fUphxVJ+ldq71qxN
 CQ1Q==
X-Gm-Message-State: AOJu0YyGQcgLfbjkmIZQpoS3FODR4YkE2BtKZBjSZgJO01VwQEmy+LTZ
 +pBx6CgtcwePyWYe1XJvvxVWSSdWoMWeSFoTuYhNbxAhqqTQW7PRAXYSCUgkk3HfYnD7vMITKVb
 I
X-Gm-Gg: ASbGncu6EcQ1yaa90R4/dGA5AUZcjlTQt0DohHXjO79+RSitjVWK6pVPAZnPjOrGZ1i
 PWUuzrup4tiESTiDwi1Qev58bbgTmKNxpKkkqbe+cbxVavGkNN54G7dW21JiTb5GaITjjr0jY/o
 vcSuvCt6qSHXPAtFXnttf957aJVgcumMaOMlHiqdt4oDfb8qD6z3PlaTAEL/FLeoHJji4+Q2QtZ
 er2gEntylr2r9ANkY53v0rWp7ZMaydmHwO4i1J3MpuXF05R717u2WkNlRUKpZw6+hRkuhNR4Y+B
 HJCM+1/nreYQ7rLjA6AJ40RmIehg+uBYr9iiHY4Z9OFjFv8=
X-Google-Smtp-Source: AGHT+IEJxSzmpiCsbrNvx43s3HxUqDo2O1ki6fZXgURwxTC6jQh2UJ/MJwnrhfVF+kUkQgRTYx4hsg==
X-Received: by 2002:a17:903:1c5:b0:220:f509:686a with SMTP id
 d9443c01a7336-2210407b939mr129371785ad.29.1739748059670; 
 Sun, 16 Feb 2025 15:20:59 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 138/162] tcg/s390x: Honor carry_live in tcg_out_movi
Date: Sun, 16 Feb 2025 15:09:47 -0800
Message-ID: <20250216231012.2808572-139-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Do not clobber flags if they're live.  Required in order
to perform register allocation on add/sub carry opcodes.
LA and AGHI are the same size, so use LA unconditionally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a30afb455e..e262876614 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -951,25 +951,32 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     if (pc_off == (int32_t)pc_off) {
         tcg_out_insn(s, RIL, LARL, ret, pc_off);
         if (sval & 1) {
-            tcg_out_insn(s, RI, AGHI, ret, 1);
+            tcg_out_insn(s, RX, LA, ret, ret, TCG_REG_NONE, 1);
         }
         return;
     }
 
-    /* Otherwise, load it by parts. */
-    i = is_const_p16((uint32_t)uval);
-    if (i >= 0) {
-        tcg_out_insn_RI(s, li_insns[i], ret, uval >> (i * 16));
-    } else {
-        tcg_out_insn(s, RIL, LLILF, ret, uval);
-    }
-    uval >>= 32;
-    i = is_const_p16(uval);
-    if (i >= 0) {
-        tcg_out_insn_RI(s, oi_insns[i + 2], ret, uval >> (i * 16));
-    } else {
-        tcg_out_insn(s, RIL, OIHF, ret, uval);
+    if (!s->carry_live) {
+        /* Load by parts, at most 2 instructions. */
+        i = is_const_p16((uint32_t)uval);
+        if (i >= 0) {
+            tcg_out_insn_RI(s, li_insns[i], ret, uval >> (i * 16));
+        } else {
+            tcg_out_insn(s, RIL, LLILF, ret, uval);
+        }
+        uval >>= 32;
+        i = is_const_p16(uval);
+        if (i >= 0) {
+            tcg_out_insn_RI(s, oi_insns[i + 2], ret, uval >> (i * 16));
+        } else {
+            tcg_out_insn(s, RIL, OIHF, ret, uval);
+        }
+        return;
     }
+
+    /* Otherwise, stuff it in the constant pool.  */
+    tcg_out_insn(s, RIL, LGRL, ret, 0);
+    new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
 }
 
 /* Emit a load/store type instruction.  Inputs are:
-- 
2.43.0


