Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A61FE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XK-0000Pu-Bq; Tue, 07 Jan 2025 03:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wo-0000E3-Np
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:32 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wn-0002ub-A3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:30 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso18079362a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236888; x=1736841688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHTGG97acyPD34Tp+rqh/MGzijUGRlOPz3TDCzFvbmE=;
 b=KHeU8acdlNOAKdzvt/HOICDMANqBg3OgrdlYXO0ujhwmi1Efuu5CcE8IcKfm7BbpdY
 +FrgjNSuDqQcPBSOLocEwfdH6YRE2usaaPgDJc36svan4Kj1kF+Ntgzfi6k4EQngM485
 nD7hkFnIAIeFF4IqKSAGzN4G5K+TBimLroa+bVSwFWT47R4bmvPSHBz+fiiBHHziNt/8
 /tB+hN/vW+6RSeE6NTwgOtWh6jeBhg0rYH9mLtbkmP1sSukkNRBD0USyT9+7nuncq6jQ
 ZgzwyT90jQO19CPqDIzdFAQ30duX3Kgvfh1XM8Gphi4Lj8ag+QlnkSfpBJXfpfccNaOx
 Rahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236888; x=1736841688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHTGG97acyPD34Tp+rqh/MGzijUGRlOPz3TDCzFvbmE=;
 b=QGJi+79394s/cxRSecI4NUp4QvpWBZJPXS8zNk9NTXOHh5w0IIghCeW2Ht8SZnaX5/
 MVYdkRFYm73WpuTeUqNW+XTzokhxeT686ff/XzJIsxiFTAW3m89LTOfjitqSL1xxBThG
 L5ZgPoIJOPEt8ebUGBwt9q1vrt0s3sneibnu9hUSofoowkKBszVQTy8u6glwapEGQapV
 hGlWXyiUictUMsc/QZR2HUqX/rjrm4PDX2YaCfRFa+6PTRT0PGgQSPIN6l15eKXsAfxZ
 hXxvqbrJoCzno8nJLI+hpPQ7QA9KRh2+CeLasjgdUwRK//qNIFL7rmdPE4X27NnhlS0+
 amrw==
X-Gm-Message-State: AOJu0YxvHeN3ra4dx19Itw/jFoi55bvbcyh+jSf2vP3ot1jHwpUsfmIZ
 qaGZOinzbnGqp2FHvTzMYW/s2eDfnOAKxlBvgyxvF+DCiroBFbNjygdK7uNEiKnPlamqmlZ3hqh
 R
X-Gm-Gg: ASbGnctzCP/anBFaXf8ymQqkgMY6H/0pEnMSFXI/MCHchgOTBwhlA3tdKAy9mN9WWwc
 dSuLD8Dx6rRPtgSh1aa659st6CVC4yEVV+nZlM13+H1XLRyyoXvu5ZW9JDsbgytBmcDP2MVA3Ba
 29FksVl/qYAq8Ovy+PaQqCdzimY9oACR/PEJDidJGsxwAu9GYmM/IJEFjIOoZBX2y0ec0vPRp26
 jFGHnY1jSYS6GTNUK72o4qP7ALLfYS//aK0amwEpBekys0Ic41kvqHytaHX7rPCyhKq+a5Li4cg
 torCrP+elp212tGbnw==
X-Google-Smtp-Source: AGHT+IG4h9vzuXIlszsNTYf2ZqBGFkBULEjhOdqMtavzTS5nzHKg/mc3D8yb1ACQLzf5kg3WUaCJxg==
X-Received: by 2002:a17:90a:d64d:b0:2ee:b2fe:eeee with SMTP id
 98e67ed59e1d1-2f452e3021cmr98758362a91.15.1736236887844; 
 Tue, 07 Jan 2025 00:01:27 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 13/81] target/i386: Use tcg_op_supported
Date: Tue,  7 Jan 2025 00:00:04 -0800
Message-ID: <20250107080112.1175095-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Do not reference TCG_TARGET_HAS_* directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a2b940a5c3..f305640182 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -24,9 +24,9 @@
  * The exact opcode to check depends on 32- vs. 64-bit.
  */
 #ifdef TARGET_X86_64
-#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
+#define INDEX_op_extract2_tl            INDEX_op_extract2_i64
 #else
-#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
+#define INDEX_op_extract2_tl            INDEX_op_extract2_i32
 #endif
 
 #define MMX_OFFSET(reg)                        \
@@ -2993,7 +2993,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_ld8u_tl(s->T0, tcg_env, offsetof(CPUX86State, xmm_t0.ZMM_B(vec_len - 1)));
     while (vec_len > 8) {
         vec_len -= 8;
-        if (TCG_TARGET_HAS_extract2_tl) {
+        if (tcg_op_supported(INDEX_op_extract2_tl, TCG_TYPE_TL, 0)) {
             /*
              * Load the next byte of the result into the high byte of T.
              * TCG does a similar expansion of deposit to shl+extract2; by
-- 
2.43.0


