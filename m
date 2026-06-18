Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6947CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4AN-0005ZN-Ml; Thu, 18 Jun 2026 00:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A7-0005VK-5F
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A5-0005cF-Fu
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c6ab886da6so3163385ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756128; x=1782360928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GynljLkvf1uEGLizdqiJ74gfCC4X3KXAsxV/9RvicuU=;
 b=gX7GPTkHO0Bi2AoR7lWylctvb2MvsXO+0t2oPSXpiTf0phBlhJ+P8GLi0GxkGxV5yn
 aFxLumJZg4mD+mI+eG1KM7y4brpHzvirqWOofs7B52mFv/KrBmVF+o9X+sz4ufIIRLjb
 X0RcRmmKG19Gv+N9c5l83tm4CmTpV7481IwwMjg27g1nTLQfy28MZh+S3vFyp9ERItUW
 Mrv4mYQGbRXKkZzTxvqZPtTPr09Pr2YboVSL+fQaZRm4Pl2DORV8/R0uY5KOSeJ6AlXc
 hjeaqGwNgJg1+GkVNklFygJg9uWm0lLZ0osctRBpYQJGg9TBw+Wk0u4pB9lRSETzPl8Q
 E2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756128; x=1782360928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GynljLkvf1uEGLizdqiJ74gfCC4X3KXAsxV/9RvicuU=;
 b=Nf336q0erx3Ewwu0+0PX+CbSvXCi6C9Q2Hl3fi984pWfFgumjOM9YSBe4OukwoXN8l
 QNl1hOOTehWD82CkQbtJI13b/5qBmsTC8DHKNbSlF8oqX8PJv+Wjo1RotnRWsP4o3ady
 RuPsJb+EtpbH+qIri2ThZWPhQ871B4oXPyrsErPws3otM7GwV9aFaeCJ8lGHFh/GoCHC
 o2ANQ7Ds+ysEfxhT23nrM7buxoVpt71sBTTCPH151fRaw2MVYWogyIJ0qL+o5MMyvxx7
 2Nwic2XhOD71o3j23hV6S/3L+AeyjItEN7mFh7j1lMgPUMNS18KpS2bKGo8U1AWe/5v7
 r2vw==
X-Gm-Message-State: AOJu0Ywr50gz5pq+TEC9SNco6tmXLljO4Y6vIeGSUYCihdDPNbd7Gfcd
 b3iv9ZrFDJEreF/Q2meSlqtLsETiEyyzfOFBHJDuYW35c04skyIBFdKZq1ZWzf+nXSXfflcCFKf
 k458H
X-Gm-Gg: AfdE7cn/UARHAxz0rBtY7N0XYBcb519NHHsBaKGQagqjePdy+UniTApjYXzY2w2Iini
 spwzu5J0RZSKSQC2/cpGtKRbxVA63oMInowrhNC1cpWMtoqERvk1qxZvRAHN2jbN4I71eu00byG
 1w27AFWjMk5h2w8mc0ujVHwFFubRDYH/dQ5q4ft5+uTnN2YjCCWs7OLDYLT220fwdZKK3SBrDqV
 3BRtUgixPOpFzWcBpJKHmsR/9vj1j/QboVNW1R8sTXG7HKxM3gJ/eN4D5YGBRL45R+kPzQbsVVe
 F4GapS/cswAa65HtILs6C0AH4PJiEiyId8mh9ctOqADbwmddVfShFY00E7NjXF6j70Ny4SyYJRf
 uf+w64YYgzISeBsMAn1ZmcrqXjlITAmFaOOHXXwfnsClQz9PqnSJ7wVZKP4QH65j5w8fF0orS0t
 COqn6jUVbyZI8m2rsCHlxzf1IqO6UIm2458vE3LRBntmN3ni2pnA==
X-Received: by 2002:a17:903:1ae5:b0:2bc:ac76:c1cf with SMTP id
 d9443c01a7336-2c6bc224cbcmr71604955ad.24.1781756128122; 
 Wed, 17 Jun 2026 21:15:28 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/10] target/arm: Implement FDOT (multiple vector)
Date: Wed, 17 Jun 2026 21:15:14 -0700
Message-ID: <20260618041517.573469-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/sme.decode      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8fea451089..467b44e832 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1177,6 +1177,7 @@ static bool do_fdot_fp8(DisasContext *s, arg_azz_n *a, bool multi)
 }
 
 TRANS_FEAT(FDOT_n1_sb, aa64_sme_f8f32, do_fdot_fp8, a, false)
+TRANS_FEAT(FDOT_nn_sb, aa64_sme_f8f32, do_fdot_fp8, a, true)
 
 static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 3c7caf8bdb..04dd0e6df0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -575,6 +575,9 @@ FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLALL_nn_b     11000001 101 ....0 0 .. 000 ....1 0000 .    @azz_2x2_o1x4
 FMLALL_nn_b     11000001 101 ...01 0 .. 000 ...01 0000 .    @azz_4x4_o1x4
 
+FDOT_nn_sb      11000001 101 ....0 0 .. 100 ....1 10 ...    @azz_2x2_o3
+FDOT_nn_sb      11000001 101 ...01 0 .. 100 ...01 10 ...    @azz_4x4_o3
+
 &az_n           n off rv zm
 @az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
                 &az_n n=2 rv=%mova_rv zm=%zn_ax2
-- 
2.43.0


