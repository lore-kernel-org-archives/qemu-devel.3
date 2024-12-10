Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA09EE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL29k-0007M4-Lo; Tue, 10 Dec 2024 10:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29f-0006bx-VH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:08 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29b-0000Jo-37
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:07 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71de22bc86bso1192950a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844482; x=1734449282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eaoltddxKl4v6Ez62fvCnLv/Rwse0SlBYVLIzgwT8Cc=;
 b=TezuvRI3BzF6K45udtYili4fUyKeEZo72E6V0F6bhIP+dheHC3HvnuGfNjXs8NHhX/
 vdtOsm1Vj+soDSekPvizzkSW9mzoHgjXERqCJOAmjvRgdcP1koHTEN1MierjfxeGHdvL
 KroY6zOhl+9sj1rTma5+uSXrCeKHEmHK80Rz5fjuxxfboeVJwKX4NsO+tCxr+HIQvlPl
 eGAU/xkKCOB1lMW2Z/Quob4xs+24WSs/E79iyxtw7wFSmoFCe0NzkNfPRTLtuVFLOSAS
 Eq7qMU7ruVh7p9efZ/MqwuycCQ77Gxum4eppz/gXUtVo+nG9mItUR2VP53Styl4Rm5Z9
 zalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844482; x=1734449282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaoltddxKl4v6Ez62fvCnLv/Rwse0SlBYVLIzgwT8Cc=;
 b=ID80yGSa8VQXyHtpva5Op5X1y/JuY6Ow4+7045KPZ9pGU6ggm6Ukmgwre9PBz68YTa
 m4lfGEn36p2iNIOu/U86BlIl/5tR1HQoAqgHPN+1YNzC107/UP5Q2vjBAs5aw7x2O3MS
 UcpIZhCh+Ehbaapo/ASztYdkJ+OQH8DXQKholO2MNLmEjKS42TNVqcdxDWG0cwa5p1sk
 rvrby1XUu2ayQUsP7HxH68IyIAFTmXM3UlVkG7xsPeJ7db9m+TyHXqZLE0CKLxftOWpU
 JhN0V1sueaxxUq+sL50ViFU0NE/ZBPZqAgltDjgt5eXEA+hxm6Hv0mvUSczzFHhwy7Kv
 XGWw==
X-Gm-Message-State: AOJu0YzwMjDn86PkP9W0SSPswJK3iei2iVs/3F31pzn589Sj6SZ9JIRB
 c66x104bDmgmqOi48ycP+2+646DBBT96xSebZ10Sv2riW4njdV+4+JXwGVOSDMPB80ZIIQfEMe3
 Am5f6WOe9
X-Gm-Gg: ASbGnct0/tmaV6ILyG+Q46F3ETmLWV1vnvM7Bny3kG49/uixDCmrM9HV1KcdwwLddco
 RWrgNTlF+jiAdjP1rVRdv/nn2AUJHSi+SLR8IW7E6uhBUL+wD824SGyYY5PaXW+GcHECsKHNgsl
 Zu5OgcDQaqFXyMAds4SzEkRZhemdaff+zMUguQjclTp5rMsDUeykK0C9OvYQCKNvd+cfWSpTd5p
 5ZIaQvNBUoZs/yAIME8mZKm8NOacovHvfanDcqrS13Qk99SzVcURa8gGw2Avg==
X-Google-Smtp-Source: AGHT+IFVuLya4O0cHCe02gLiBQTDbX4nbV34gOP/L1AZo6TPn1eaGtpkdRNWIfA8YJvKroOX+maO1A==
X-Received: by 2002:a05:6830:4992:b0:71d:fb64:b5fc with SMTP id
 46e09a7af769-71e02253f75mr3364301a34.21.1733844481869; 
 Tue, 10 Dec 2024 07:28:01 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2785955a34.52.2024.12.10.07.28.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:28:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/46] tcg/optimize: Remove [zsa]_mask from OptContext
Date: Tue, 10 Dec 2024 09:23:59 -0600
Message-ID: <20241210152401.1823648-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All mask setting is now done with parameters via fold_masks_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 94e942e1cf..eb6e93809e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -64,9 +64,6 @@ typedef struct OptContext {
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
 
     /* In flight values from optimization. */
-    uint64_t a_mask;  /* mask bit is 0 iff value identical to first input */
-    uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
-    uint64_t s_mask;  /* mask of clrsb(value) bits */
     TCGType type;
 } OptContext;
 
@@ -987,14 +984,6 @@ static bool finish_folding(OptContext *ctx, TCGOp *op)
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
         reset_ts(ctx, ts);
-        /*
-         * Save the corresponding known-zero/sign bits mask for the
-         * first output argument (only one supported so far).
-         */
-        if (i == 0) {
-            ts_info(ts)->z_mask = ctx->z_mask;
-            ts_info(ts)->s_mask = ctx->s_mask;
-        }
     }
     return true;
 }
@@ -2867,11 +2856,6 @@ void tcg_optimize(TCGContext *s)
             ctx.type = TCG_TYPE_I32;
         }
 
-        /* Assume all bits affected, no bits known zero, no sign reps. */
-        ctx.a_mask = -1;
-        ctx.z_mask = -1;
-        ctx.s_mask = 0;
-
         /*
          * Process each opcode.
          * Sorted alphabetically by opcode as much as possible.
-- 
2.43.0


