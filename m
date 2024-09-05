Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5190CD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC7D-00022o-Cn; Thu, 05 Sep 2024 09:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC71-0001JO-H8
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6x-0001ma-JM
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42c2e50ec6aso4401315e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541277; x=1726146077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qIUBV+3eAKQWSLQmZz1TCwCdei1m98hDG02Oo3r/Z6c=;
 b=EhHOiydUFE+/Yacszz33MQC0xjDKJAdHWYILuedm0C7o5gBbuevxgjKG6rEf+EezEx
 Zq+LRrwnhPta9DxV4um0U0aM/DPRdiqqpdjlJYr4uHaZBUuws44bgYCQW7IDXvTV5FFC
 gCCB+gNbPE1OY1P5BLJQofxGAIw165Dza8/k8cXIqMy96ZX6QWyl98vVLCGzp4PJzHGm
 uCF6lY5kVCfWLuQ1XshQYIF73gqDqK9QC3/3OW+f0JAwntTydgriNRY4qqUVtxWvHQnn
 gTiW4opKARfOYU1zXpxEWi2Myqh7OM1yHJBa67373EYY04MI4fNT9XPMv0mNfPyBfXYd
 KLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541277; x=1726146077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIUBV+3eAKQWSLQmZz1TCwCdei1m98hDG02Oo3r/Z6c=;
 b=ur3q7vUcTXEgAOhb/Q3LdY0TdzCAv8apy9EzewsSIHI4dIvlSoEaughXPtYY2qBM8n
 hA+MlZcJFrq1/79i3wcupJ/3jrqXvhz6Pzr30/g6T8nHiS4OinTFefjF1kwT3MsyrAAr
 TeD8VzUtTgPRHp3UBwrJnh4Zm0mrAp0qjAX+Tr1O6AuT/ObNVNUi5VqpiyG/EhcQQKpW
 Ps7aMiKXHSMYCx35vGx4lJXD2Se8Yzdg0xuYgOMpFQ2EvogOdS2PDGrYonrY8eIb+ICR
 TAHOTHccGAn82Wh1IiCrjhe1978qNrTT5ugV3YvciJ5PWZ41H+0p8IdrF9iNA6DviAFL
 dOpw==
X-Gm-Message-State: AOJu0Yz8YutWi28QBcTbbAZYQZoxsVbD8vc6eAQXI+OIEMfEO1h1Qg/I
 MId5akKqvoHhbZ7wYOZlvLgzgbvf95+CptRRRVmY0OabHgymAeNrdLfn7IsELygBZe/2ikH7Eyy
 +
X-Google-Smtp-Source: AGHT+IHVH1nyw/Tgl6fbK6JZJpuKlWAfuWW48W/1Y8rDLKHKANxi9+jLwDpaLsCZOpNODzQ+reRc2w==
X-Received: by 2002:a05:600c:3543:b0:426:5b19:d2b3 with SMTP id
 5b1f17b1804b1-42c95bbe2ddmr35864475e9.14.1725541276912; 
 Thu, 05 Sep 2024 06:01:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/25] target/arm: Correct names of VFP VFNMA and VFNMS insns
Date: Thu,  5 Sep 2024 14:00:56 +0100
Message-Id: <20240905130100.298768-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In vfp.decode we have the names of the VFNMA and VFNMS instructions
the wrong way around.  The architecture says that bit 6 is the 'op'
bit, which is 1 for VFNMA and 0 for VFNMS, but we label these two
lines of decode the other way around.  This doesn't cause any
user-visible problem because in the handling of these functions in
translate-vfp.c we give VFNMA the behaviour specified for VFNMS and
vice-versa, but it's confusing when reading the code.

Switch the names of the VFP VFNMA and VFNMS instructions in
the decode file and flip the behaviour also.

NB: the instructions VFMA and VFMS *are* decoded with op=0 for
VFMA and op=1 for VFMS; the confusion probably arose because
we assumed VFNMA and VFNMS to be the same way around.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2536
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240830152156.2046590-1-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vfp.decode      | 12 ++++++------
 target/arm/tcg/translate-vfp.c |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/vfp.decode b/target/arm/tcg/vfp.decode
index 5405e80197b..2dd87a27089 100644
--- a/target/arm/tcg/vfp.decode
+++ b/target/arm/tcg/vfp.decode
@@ -141,18 +141,18 @@ VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
 VFMA_hp      ---- 1110 1.10 .... .... 1001 .0. 0 ....       @vfp_dnm_s
 VFMS_hp      ---- 1110 1.10 .... .... 1001 .1. 0 ....       @vfp_dnm_s
-VFNMA_hp     ---- 1110 1.01 .... .... 1001 .0. 0 ....       @vfp_dnm_s
-VFNMS_hp     ---- 1110 1.01 .... .... 1001 .1. 0 ....       @vfp_dnm_s
+VFNMS_hp     ---- 1110 1.01 .... .... 1001 .0. 0 ....       @vfp_dnm_s
+VFNMA_hp     ---- 1110 1.01 .... .... 1001 .1. 0 ....       @vfp_dnm_s
 
 VFMA_sp      ---- 1110 1.10 .... .... 1010 .0. 0 ....       @vfp_dnm_s
 VFMS_sp      ---- 1110 1.10 .... .... 1010 .1. 0 ....       @vfp_dnm_s
-VFNMA_sp     ---- 1110 1.01 .... .... 1010 .0. 0 ....       @vfp_dnm_s
-VFNMS_sp     ---- 1110 1.01 .... .... 1010 .1. 0 ....       @vfp_dnm_s
+VFNMS_sp     ---- 1110 1.01 .... .... 1010 .0. 0 ....       @vfp_dnm_s
+VFNMA_sp     ---- 1110 1.01 .... .... 1010 .1. 0 ....       @vfp_dnm_s
 
 VFMA_dp      ---- 1110 1.10 .... .... 1011 .0.0 ....        @vfp_dnm_d
 VFMS_dp      ---- 1110 1.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
-VFNMA_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
-VFNMS_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
+VFNMS_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
+VFNMA_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
 VMOV_imm_hp  ---- 1110 1.11 .... .... 1001 0000 .... \
              vd=%vd_sp imm=%vmov_imm
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index cd5b8483576..b6fa28a7bf6 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -2190,8 +2190,8 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
 static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 {
     /*
-     * VFNMA : fd = muladd(-fd,  fn, fm)
-     * VFNMS : fd = muladd(-fd, -fn, fm)
+     * VFNMA : fd = muladd(-fd, -fn, fm)
+     * VFNMS : fd = muladd(-fd,  fn, fm)
      * VFMA  : fd = muladd( fd,  fn, fm)
      * VFMS  : fd = muladd( fd, -fn, fm)
      *
@@ -2262,8 +2262,8 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 #define MAKE_VFM_TRANS_FNS(PREC) \
     MAKE_ONE_VFM_TRANS_FN(VFMA, PREC, false, false) \
     MAKE_ONE_VFM_TRANS_FN(VFMS, PREC, true, false) \
-    MAKE_ONE_VFM_TRANS_FN(VFNMA, PREC, false, true) \
-    MAKE_ONE_VFM_TRANS_FN(VFNMS, PREC, true, true)
+    MAKE_ONE_VFM_TRANS_FN(VFNMS, PREC, false, true) \
+    MAKE_ONE_VFM_TRANS_FN(VFNMA, PREC, true, true)
 
 MAKE_VFM_TRANS_FNS(hp)
 MAKE_VFM_TRANS_FNS(sp)
-- 
2.34.1


