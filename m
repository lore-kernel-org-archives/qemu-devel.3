Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160DCC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pm-0002Pi-O3; Wed, 19 Jun 2024 17:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pj-0002N4-IX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Ph-0000jk-5b
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:19 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7062c0ee254so249994b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830816; x=1719435616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+5WPOQQn7wdJFBxPC03WeaiWKObhZXvJYhNjI8CS4I=;
 b=zHAo2QIQYJDkGsYuQh7Ekaa3n31GljJLlAlSfEhV40V8BzV0GEwWl8MdwmqcaI5Gqg
 PXeKHG75DK+fLuVZsuBHxBltqoaQU7YPIVS/hPR8LXJoMH7XF7waBo7MfY96VQrTfHKc
 JmtwPJ9rZY8vdj+C6sh+on0FxFEBfTGtKpKqBfECljq+//8ArTT87MP+Xk2JdOOauXwB
 4OjyzT6ghxcD/KVpDfvjlBMvmGVMRMmEhTmkoF7rxOvBNY3Yr0oMQTMAzqJz+khPE9XP
 k9X4pGQMPMFRe2zGK/aatFYrMndALD/kKNz/OKbA+1U+3bnTBD5WT5QA+44lay78xnB8
 iHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830816; x=1719435616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+5WPOQQn7wdJFBxPC03WeaiWKObhZXvJYhNjI8CS4I=;
 b=W9BpkqBMyGIgp3gwiejOTG3lrVabiAMhHcdBQD9qGm0CW8Lcc5WMg6tSfp6piNqLBG
 njEI9xbKocHFPJaFAmshYw9ad19ZuemBH8twcTiKB4n2f8+4dW4klb53vQ56UcbQhEBE
 GN1yKuWmKGb6gMVG6rsrcxAyKQtvPYGyFYfw5zEVdOWV/91D16sOw1Pi2KTFlTXBTSF7
 lDhJCwrNHDbrGFXau2+sZ9K3qR4s9c+RZroZdPpnJWQSORgm253SFf1EZ2LK8QSOjfr1
 5xUgMHwACuZ0sm4NBCiBjGbsNHW+5cqIJ2p4P5/qEHRxpLvz4LNFXc0qfatgk+GDV5zf
 H5KQ==
X-Gm-Message-State: AOJu0Yx9yRPzbZEbFIpnW3rmiZNrf4dpTJDONHPCx6+KJCR2Y6Zd8sz0
 yVgiQLbF98uraj0rHkOxHnQosbPUY9D9gCAEzPMNmk9w9Dyr6mAPN3xLD0xLnu8NgQ3OBFWLk/S
 2
X-Google-Smtp-Source: AGHT+IEufdJCehTRpbxjxsFUisYn/l1HnyqVkOFALrM8B761KPN4s8cWRplJH6vQbQ0YPpWfDZaqeQ==
X-Received: by 2002:a05:6a20:7929:b0:1b8:a2ca:3b6d with SMTP id
 adf61e73a8af0-1bcbb5d4cfamr3375701637.37.1718830815679; 
 Wed, 19 Jun 2024 14:00:15 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 24/24] tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
Date: Wed, 19 Jun 2024 13:59:52 -0700
Message-Id: <20240619205952.235946-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Simplify the logic for two-part, 32-bit pc-relative addresses.
Rather than assume all such fit in int32_t, do some arithmetic
and assert a result, do some arithmetic first and then check
to see if the pieces are in range.

Cc: qemu-stable@nongnu.org
Fixes: dacc51720db ("tcg/loongarch64: Implement tcg_out_mov and tcg_out_movi")
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reported-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1c4dc4decb..5b7ed5c176 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -382,8 +382,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
      * back to the slow path.
      */
 
-    intptr_t pc_offset;
-    tcg_target_long val_lo, val_hi, pc_hi, offset_hi;
+    intptr_t src_rx, pc_offset;
     tcg_target_long hi12, hi32, hi52;
 
     /* Value fits in signed i32.  */
@@ -393,24 +392,23 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     }
 
     /* PC-relative cases.  */
-    pc_offset = tcg_pcrel_diff(s, (void *)val);
-    if (pc_offset == sextreg(pc_offset, 0, 22) && (pc_offset & 3) == 0) {
-        /* Single pcaddu2i.  */
-        tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
-        return;
+    src_rx = (intptr_t)tcg_splitwx_to_rx(s->code_ptr);
+    if ((val & 3) == 0) {
+        pc_offset = val - src_rx;
+        if (pc_offset == sextreg(pc_offset, 0, 22)) {
+            /* Single pcaddu2i.  */
+            tcg_out_opc_pcaddu2i(s, rd, pc_offset >> 2);
+            return;
+        }
     }
 
-    if (pc_offset == (int32_t)pc_offset) {
-        /* Offset within 32 bits; load with pcalau12i + ori.  */
-        val_lo = sextreg(val, 0, 12);
-        val_hi = val >> 12;
-        pc_hi = (val - pc_offset) >> 12;
-        offset_hi = val_hi - pc_hi;
-
-        tcg_debug_assert(offset_hi == sextreg(offset_hi, 0, 20));
-        tcg_out_opc_pcalau12i(s, rd, offset_hi);
+    pc_offset = (val >> 12) - (src_rx >> 12);
+    if (pc_offset == sextreg(pc_offset, 0, 20)) {
+        /* Load with pcalau12i + ori.  */
+        tcg_target_long val_lo = val & 0xfff;
+        tcg_out_opc_pcalau12i(s, rd, pc_offset);
         if (val_lo != 0) {
-            tcg_out_opc_ori(s, rd, rd, val_lo & 0xfff);
+            tcg_out_opc_ori(s, rd, rd, val_lo);
         }
         return;
     }
-- 
2.34.1


