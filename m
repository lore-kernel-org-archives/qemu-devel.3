Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F8DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE5-0008N8-V2; Fri, 04 Jul 2025 12:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE4-0008Lx-Ij
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE2-00068K-D5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-454b1d0a115so3624395e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646321; x=1752251121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zNF5S8F9V+F3dl1M/qhV6oCSu+10+dz96rceyYRfQ0M=;
 b=DcDcWDp4oFHs6WI3TBVjaq/VEJya3IWDToclHBfNCnYyWwvmfnQv3MQvba2QBIic2o
 rHJRI7fEqmXW1p2f4+XRiJcan7jpusbuQ1PNb8OWTVqpRpRtIwj5A2Z/0czwwDqFW6TG
 u7+/R7pEHEQ1dGbjPaQxZ238zZFB/PyXKYgM2NURUqYq8o8umAK+SLu7yLzXP2Y4Kk5p
 c8kMoL5Qu29LTkBSud5RdRCnT4Mk0gc2pNToYUuF1UxfKrkndF4QXOv7+CUtC6LWVJVG
 gf3PRaWmuuq2qLn9mM2ePoa4r3jAmdVoIEaB1gNhD3N+6W8Xu/dk4sp3wkACKGcr1LAO
 wQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646321; x=1752251121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNF5S8F9V+F3dl1M/qhV6oCSu+10+dz96rceyYRfQ0M=;
 b=csHYRJi0SSYdZGAuXrKKLlF/rWAqmg2OBfXi6rBtWrg53rKL78/e7SYY/pa52jbr7S
 3NTCC3XcPUG3W4MJk7vW7+Uaiw+6QPGvrfLew7BhmakD1MmYE5Ml0495ZQRQbPyVmfb9
 RwE6ktS89/fsaU9HE6m9Z9WCsRrGI4OUNpIRiK9DWnqHasdEdWoQNCfWgcThDOPKKChG
 LTukfg3pBC2T9QLbPnzl2TjUduxcmICl/vKnKKk9DFZ/KgO3z0g0YgHDcS/MfqGt0tXV
 nBc2pYKFYhVR6hxo+0gvJ6CJL56gSie2f+/yM5wn7EwedVZyWKuxc61VDTSVaOfDe92V
 xm7A==
X-Gm-Message-State: AOJu0Yzn9qnQh8n8qEtx30BDLd34zUshxZALvFy8rDspa9u2dUBhP4AI
 D7wGP1++kkSEVirekc0olVZabpuBQOnUe+igHYGUzUI7em4FnyBogp1FrFDQT8zEvp5h9yrtMXn
 REq9w
X-Gm-Gg: ASbGnctyl52rAZA0PIeV34/KPs4JjSjYcArv8P8i3UGi2+ibK1/SMOJz4eTWlxVSyJv
 cHkMGnlwywPTJ1GDnoCtybozXaxDQRwAKvy58mGit6s+SOtZmlJWiMLZK2sAG980GtuNsPoz37E
 aQNKZp+x7s6RTLzFBzRd5kW+GXq+e88aBhX0Bx4QqLY0nLeIBgdu3pEtyOEYqCG9+iSfD+A5bQw
 Y7svYrEEvt+X5U1P/zvYeEUsOpDw1JFp3b9lARWISC78H+VPoq8dcYm025kyFnJF5tS46KLQMAO
 l6TFQHn2PXtz7zwC1kSh4XCoxP7yblWz3FrEvaRPF12c/2+R38VEedL09EmQhuGKSca9
X-Google-Smtp-Source: AGHT+IEMnAvDJMfQcsSpz/fRLuhIcqZfgZImpqe9PqSglrp/aqT1A0fJMU5ESsT68VCph2nTGiPIgQ==
X-Received: by 2002:a05:600c:64c6:b0:453:66f:b96e with SMTP id
 5b1f17b1804b1-454b4e74691mr26878955e9.11.1751646320763; 
 Fri, 04 Jul 2025 09:25:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 019/119] target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
Date: Fri,  4 Jul 2025 17:23:19 +0100
Message-ID: <20250704162501.249138-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Gvec only operates on size 8 and multiples of 16.
Predicates may be any multiple of 2.
Round up the size using the appropriate function.

Cc: qemu-stable@nongnu.org
Fixes: 598ab0b24c0 ("target/arm: Implement PSEL")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a0de5b488d6..8403034a0e2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7291,6 +7291,7 @@ static bool trans_PSEL(DisasContext *s, arg_psel *a)
     tcg_gen_neg_i64(tmp, tmp);
 
     /* Apply to either copy the source, or write zeros. */
+    pl = size_for_gvec(pl);
     tcg_gen_gvec_ands(MO_64, pred_full_reg_offset(s, a->pd),
                       pred_full_reg_offset(s, a->pn), tmp, pl, pl);
     return true;
-- 
2.43.0


