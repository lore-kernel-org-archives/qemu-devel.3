Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00CDCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNpr-0008BN-JP; Sat, 30 Aug 2025 11:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRH-00052t-Ny
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:40 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRG-00052v-8o
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-24456ce0b96so29882195ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756525177; x=1757129977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t71Z0EMt7VoYt+Js0tvLpYVjDl1AThaQamaO8gjGV1k=;
 b=LpeH/VJ7SbJ3TSFXtL/M/wr3vQ30FDsQbZpIwUMrSPhk8Hn8Srmq/IpBotKzphyDtJ
 r7PQawLa1TlF8BdSuiOSmNeOHUim6Z4mIfq8xKE9HLYIUDk2On+gVuAE0di3Fw0TVrzQ
 oeBBo2MZe2S1lZYQS6v8jFSNn/g9kiacWs/NRpXh2AFaV3MSNzPpGMnVLKhinunoRZBJ
 /EVHYWB7dr/h9xu0GRbFqcLHWJ6sggUMn5fclN7PL91lgBts1Tip9dyRzQJBryhyPqXA
 JVZnu92l8CiMyNB064EtMU6PI8mYOhDh6da677nMMmvmRXYmjVJLq7Oz2yW7yfnaGlT2
 YoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756525177; x=1757129977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t71Z0EMt7VoYt+Js0tvLpYVjDl1AThaQamaO8gjGV1k=;
 b=aEM4S88hY/8W2AHtNvFnWhw1bC94bT3tMOX5xOmeBvX6NbBhdRuoLXfzoXnUslbsT9
 J91XYLesCGtypdvIl7IigfUbuu8wt9MbEzIBnwubXn1rw6FEU8KGsQrYbYsFh1gL7fp2
 SGIZH4J1Ec8ley9rB+m2aX+ceiRKuawZ8yM3ghJGCmUiG21etfv/6p8gDTNBUnXHr1a3
 1cYLQukKhn5i6lSk+BPdcGM1/oA/fM9qheomm+xfvq3AQ3KuY7kGiCZzwNFGopwCm/qA
 mYV2u/VumQ9lU32I/nrWvLjyKkcEAd8ryDuzAnTHO6ir3VmXTIvXJOvNNfn6jXAlESiO
 5AJA==
X-Gm-Message-State: AOJu0YxTjljk36bUPpHFdf5SrBuCK2vbRjB2POeyByNdEPtakJsXeyQ5
 dNNEVjeoidzuoJV4JlL+VSywH8mPbvbWVMNnT6yflMOxuVyNSlM4ZCHz/tP1ABqhL5gS6a+60ny
 8sspbTV0=
X-Gm-Gg: ASbGncsTDKWpOtpQlsX7sdLTtEzS7Bhg4030xvltSOXhhdy2h66xBQAA91D/nRkKrI5
 rnMJKRCTy5b8u3N4ljRRS0pvekCvo1ZA6gU1GQlFVjQxgtGBN5uwApiwWwJspEd/DgJTaj5zRPs
 EuLuY5vtVynRq5BXTUnPhzJT9p/WnBb8jZxnVwolBQLCR8sb+7TOHEWPRSZUBVYrlnVTlED2LJW
 ReVV16e1arlSKdx3Vp+9m32icYMgs45GNxYWzono858X6QZyp7Bbb2gu9aWS2EMMGq1eHG2h9+x
 gnbDJR8DYjlj2ePgBqcLLum+5D9DDSNt8Hp1ZVPxmjlNQ/QDzKCyDnItBZq5pkDvuYQsb3APPi9
 sDedVxM5MEObs9v0dR47RMrNVp8531rYTr61AjlnThY6qmOBlftay0LLGqaAtMoE=
X-Google-Smtp-Source: AGHT+IGiN8QzMRDBAz8mg1IGPu+pQXRsz9MvTW2PX48TdeXXDJ/AzfO2QMZqOCEYHA4+bdyB5UzbIA==
X-Received: by 2002:a17:902:d502:b0:248:ffb6:5bce with SMTP id
 d9443c01a7336-24944af020cmr12329765ad.22.1756525176944; 
 Fri, 29 Aug 2025 20:39:36 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da4784sm39551685ad.90.2025.08.29.20.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 20:39:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/5] tcg/i386: Expand sari of bits-1 as pcmpgt
Date: Sat, 30 Aug 2025 13:39:23 +1000
Message-ID: <20250830033926.372955-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830033926.372955-1-richard.henderson@linaro.org>
References: <20250830033926.372955-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Expand arithmetic right shift of bits-1 as a comparison vs 0.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 088c6c9264..4cd5d4276c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -4357,6 +4357,12 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 {
     TCGv_vec t1, t2;
 
+    if (imm >= (8 << vece) - 1) {
+        tcg_gen_cmp_vec(TCG_COND_LT, vece, v0, v1,
+                        tcg_constant_vec(type, MO_64, 0));
+        return;
+    }
+
     switch (vece) {
     case MO_8:
         /* Unpack to 16-bit, shift, and repack.  */
-- 
2.43.0


