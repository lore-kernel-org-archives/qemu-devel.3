Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEABC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5h-0005D6-GJ; Fri, 17 Jan 2025 13:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5f-00050s-2G
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:07 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5Z-0000EF-N6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:06 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so4221098a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138540; x=1737743340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6H6mZe5i1rQYMAvgy3QE9HZBzXOhIJyN9wM3xSG7jg=;
 b=YDEMQZv5gGtTy3LLnfiiC0eWiuNMBgM0a4R9/v2uPD+0XeDP1xsTA/AyjejOdfVVEq
 O8e7tr+8KKKlU+6aeuX6LMg0nkmbJUBAu+cl1Mu9bUC5v5OXq/Rvh8skG+C0cinmHSss
 jK4f8PH49RSnQxdPQTloI56ahzlOwhkEq3zc8PkxP8OeSPLhJaeV3MTTskGM4+3NQR4F
 oWPFY8Usn5/FYfA1VpV6h1Thb19q83SZ/xqSKPxKfDVm1D46KaLfW3PCKmTh60UOv6Uv
 aLcxrUNxQsqURAGxOg27wJRFx9m5+DlbMXU8VoGVIHfG4TM9RxmSrNWGUNE6VE2f+VUn
 ZfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138540; x=1737743340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6H6mZe5i1rQYMAvgy3QE9HZBzXOhIJyN9wM3xSG7jg=;
 b=AvFFKs1FnRYiso+240t5Wiayql/rxZEhhrzFTGzY5HFO8Na5sDaiV9WwSBkfuyE2iz
 nOhHa8GK7j8VQlQrjey9IYR0SaB6x8wiJf4NCAfdMj8bpf2+/yOh6momu/X+KW75rSvD
 kLTdlRqlUltjSkxhMbGOSpmrV0KGDcn7gTsLuduZz6liN7GDbI+L4oD3tyFDYKznPkWO
 HLlMVOHoi8qSiwfaKtJCXBlz/3a0C0kFeJTYmktBns4pfPICPG5HkAUDipKlOFNrl2AG
 lKitRA+65s2oUvlYOKQ1fC6rLfa1dNvuKzFItHWAq+gj6cZY6jrUTxJ1xrbboI5oOHTX
 0fcg==
X-Gm-Message-State: AOJu0YyevKsS+yDjSr76yJc3lQ4fvLvXVapn1qo3ItALPlSw33pMcYeU
 Ya1tScYTsPDEQmQh1o1FYIrMp+PePp2goh3cEGrWWXRNrAhxR8luH47wq+0z4HNTmntQ7uElpzD
 A
X-Gm-Gg: ASbGncselP0h8o+CiNizbMxZmXt1agzOKpTZsW+s1yr3ZDgHbb9+FX+fPonnArX5fii
 OZ9eNSvFfbUWhNEek4rG9MhHGb4tl0MfEruTv3zRIBRFXb+m9eV30zXlL1PjGHHXn/MEeGJXR+V
 06dSGyy8vDpPI7QxSBn3Qm0BtXXCMvNYh6y+5poxKGhfEk2HDLQW6cLD1lg8q7XPceYKqSMtm1p
 GmtDc7O/Bo9i3U1tsC7x9+I9i47vtBrOQsHNjbFrpT+VIyI8NEvIFFVYHHc9CCZtgUZG9URvLkg
 s2gofl+lZrug4Tg=
X-Google-Smtp-Source: AGHT+IE+QKgKBcs30s2J1UsvnC4KUFxfvsYKyhcItM3ukOkn3N/1323dwh/iea8Dcys45uzXUKmMaQ==
X-Received: by 2002:a17:90b:5211:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2f782d4ef70mr5129078a91.27.1737138540376; 
 Fri, 17 Jan 2025 10:29:00 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/68] tcg/i386: Handle all 8-bit extensions for i686
Date: Fri, 17 Jan 2025 10:24:35 -0800
Message-ID: <20250117182456.2077110-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

When we generalize {s}extract_i32, we'll lose the
specific register constraints on ext8u and ext8s.
It's just as easy to emit a couple of insns instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8d1057cdb3..ed064c38d4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1329,16 +1329,31 @@ static inline void tcg_out_rolw_8(TCGContext *s, int reg)
 
 static void tcg_out_ext8u(TCGContext *s, TCGReg dest, TCGReg src)
 {
-    /* movzbl */
-    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
+    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
+        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
+        if (dest >= 4) {
+            tcg_out_modrm(s, OPC_ARITH_EvIz, ARITH_AND, dest);
+            tcg_out32(s, 0xff);
+            return;
+        }
+        src = dest;
+    }
     tcg_out_modrm(s, OPC_MOVZBL + P_REXB_RM, dest, src);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
-    /* movsbl */
-    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
+
+    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
+        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
+        if (dest >= 4) {
+            tcg_out_shifti(s, SHIFT_SHL, dest, 24);
+            tcg_out_shifti(s, SHIFT_SAR, dest, 24);
+            return;
+        }
+        src = dest;
+    }
     tcg_out_modrm(s, OPC_MOVSBL + P_REXB_RM + rexw, dest, src);
 }
 
-- 
2.43.0


