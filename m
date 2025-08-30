Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09C1CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usODn-000527-V6; Sat, 30 Aug 2025 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQt-0007Jz-Fm
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:23 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQr-0004uS-OL
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:23 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b4c72885c8bso1656063a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532835; x=1757137635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dB1cHT1ha866F85MzBv2WZgn+PHcRylb/+Q2tL/eLA=;
 b=dCbdgZAmVUdkkBUGKbZkgyIRKLSqgnTRBE/xMZmI8sfWjSiTPt0rLLYNE+z9evTCgu
 CZSxnpge1jVEj+WjSfo7mZwQzwl6m76rB4UvzvB1ypx2pAH8COVbB5ZZ4YLeOjPHvC6v
 wWcX8+O0o1z1aeCxoBU/SYGg/vX6RkwvH5mUIQ4z7oXBxuw/KhFK+Hc/ovlZBQCFYBAV
 lArwYx1XKkzRjJfI2q0aPTaXdJSerm8ug9GEXDcnRuKG2O2cZEIcGn4pM2HtaettrTrv
 RTVtMHags14gq4e/IKB5jjojy/dOYm1TKPGtihSSh657UvTH9poRx6kkpGk+iPVr38pM
 e0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532835; x=1757137635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dB1cHT1ha866F85MzBv2WZgn+PHcRylb/+Q2tL/eLA=;
 b=bjWqw/g0hfF9o8ZiPLVdJiJoMciu55g2QzjwCqvFcEhVmIJesjp7Lam2qZVhOEEVhl
 L6wEgyT+XR8wllvn+7UlXAzfOtou5AyXcd0nBd+vaonGGNxUWhv95pHS8q+Qs1pp8tvs
 9S7Ka0f+lxSWsreBqPWdIovs5wwig+3splv3NuKMH0ApA93wR6Rv9TA5fWXRuIYa85E3
 S0x5Bq2d+DOFwAgxembnW5W0hwrSjo+5cBPcDmU+SbDbLcUqKlIfZJGfmiyqPx0K/KHC
 VaitbKGDB57Tk9kPWC9NQAteggoUb+d2yJGLfsKejTohT8sL8w6p00o4SThm2JRaImJu
 d6jQ==
X-Gm-Message-State: AOJu0Yxr70Pe6zIbWNCAUPAp+pikMJrzyJ1L2PyaHwGgafTzUR7njybB
 LXHT+wDAct+T03NZFEgDg/6E1gLsWagrqunFcc1srtpC2MxC8I/GQo4QAKxN/1LrSM120KAm6nj
 UUPO6wv4=
X-Gm-Gg: ASbGncs1TD/KZIm5CChzeH3XRzuS1b5O4W+wM5szddzOkmk0E50dbxuyoWRs2D2FIzr
 voIy86lBfGhaciR/y1EIXpZ4E7bgkybT8edyhhPSMET8iJzDlt9EiA0kXrTspnH+mtC0N11Y4Z3
 8nGF8dzSY+PS73x0hZguVI6vPxCXFuRXqdF9qiz+y4EEDLz0282o9AVbXpj13IkG6aYDl4CMPkJ
 tbSkA1fPK+eL5v7P9tG+tbvgg/47UrKkW6UPzpIkwcBNdNwmRCBSaX/p8EzjdStJE2PQ5nK/+zi
 fpYqifnskZlmDNeRvCa45MuYc9tzfMTC9R/rQyX2UqGUPz4i/v0y47bW9Pf4GYTA8fJlPAV+vCo
 lG10emsYjdWaGMHuT2u8bx3F907AHku5Bm2A1eeubFulHRF5iErGmgiOuc600yqA0JdaWZdv0PY
 8qiXatRISB
X-Google-Smtp-Source: AGHT+IFUF2vw3Ybp9B+8/EVZdXrvMa6WTfWSB0QJE4w35D0pCx6Eg1EUB1BVa5GNIF/lLTeJVSZuqQ==
X-Received: by 2002:a17:902:e551:b0:240:671c:6341 with SMTP id
 d9443c01a7336-24944906d9fmr14071555ad.26.1756532834537; 
 Fri, 29 Aug 2025 22:47:14 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 56/84] target/arm: Emit v7m LTPSIZE exception out of line
Date: Sat, 30 Aug 2025 15:41:00 +1000
Message-ID: <20250830054128.448363-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 target/arm/tcg/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f6fdfaa551..e787acfc66 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6885,11 +6885,10 @@ static bool trans_LE(DisasContext *s, arg_LE *a)
 
     if (!a->tp && dc_isar_feature(aa32_mve, s) && fpu_active) {
         /* Need to do a runtime check for LTPSIZE != 4 */
-        DisasLabel skipexc = gen_disas_label(s);
+        TCGLabel *fail = delay_exception(s, EXCP_INVSTATE, syn_uncategorized());
+
         tmp = load_cpu_field(v7m.ltpsize);
-        tcg_gen_brcondi_i32(TCG_COND_EQ, tmp, 4, skipexc.label);
-        gen_exception_insn(s, 0, EXCP_INVSTATE, syn_uncategorized());
-        set_disas_label(s, skipexc);
+        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 4, fail);
     }
 
     if (a->f) {
-- 
2.43.0


