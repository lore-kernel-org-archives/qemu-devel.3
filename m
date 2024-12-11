Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79357E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSY-00015N-Kr; Wed, 11 Dec 2024 11:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSV-0000zX-1N
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPST-0007ow-Fc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so45369095e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934063; x=1734538863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kqc/nDYRVw371GtkZwgUaEiTpivDb51JFPpNFEa+LMQ=;
 b=xxGLLGaXYK13mgR4nfwgD6INDqMIX9ENoBWteZKtSHMF4tPgeZRnAiuGpXBgeNZ//3
 T2wpNlbHsaug+dR0zjsBzcY9eC5xKzI4N4J1HbJP3pfcFt0HABj+nQ575XyNz8UzWuox
 N4zDovXGtixje29XB2iq6FOZfEhSchEpOHPN7/C+kJMSDwN8qoanTnZqXZvBVgY9FDMG
 Q2xZRcIdTumNyIxETQyqRI1pBwVVa73DWpHozRJc2Lv3d7IAU6He12nBoroyCsLG73Hi
 rSzNakI308o2bqU5nx1ZOuJjwFSWFaVixOEMuyklHVlxzT+1pHXJz717W1V3QBId8cT3
 yA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934063; x=1734538863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqc/nDYRVw371GtkZwgUaEiTpivDb51JFPpNFEa+LMQ=;
 b=ic3gJJl1gWzukHIaRirInF6Hdb/6ruq/vw4bgSuUzFeJsxpVfBl1rOE09vJRxv7qVo
 +mdqtaRHZGyYOvkGBS8l9jShIk8XldlAvSA4egxAexdECpuqizYYWOjZQV6kwH2ztfwk
 9xdDUNF/7itO0RYCpT87bls8SzrB+T8wMiook5hZgwO3RQipMxWADZ4Nv6OJXGjjgzqv
 k2bBl3si2voH74rAaU++tJ9AIDaGaQlzJDVOojkpLK7NeEqHUTDKczpAidRlz6rJ7E0R
 asq9VUoZP7P/pRwmuhJDSqlXXdiFocLg4Z3Wid4hd/LSwnpvcaaElbH63Y0paNyaXxl7
 y4lw==
X-Gm-Message-State: AOJu0YyEkpxkmi1HPyrryKGvNZfBMr5VuXHUY6EKDxG9PWJzH/poD5Fr
 jPBasp+rqHJyd0xIQZOunLllCpWgUEq/rJoomPo02lP+ei4egBE+zviMBJMHGzOJ1TfuZ3vELx1
 p
X-Gm-Gg: ASbGncvNLD9aEQKyF1eQ89S5vuNV4bk3on5GRGf+xyh8w/At7Nb3EIewLqY1sk5F2kg
 T0iX3juf4GIQy+/R0kvIyF2+eedFn5eAuAk4mORxbHiavYbnPdjavZggG2sC6kj93Fs0tYnAjEn
 ua3g7xOQVRk04iZ9RgDziarozUjBUuTJSvOxO4ptxUcLxEu1lNxuA+bAXqc/wNzpbArxSNlylkZ
 IcSq6A6IX+g8nEz/yvLy0tg5/sftQMKyf2RMUMY++Ges6+PgWsvk1grpbnj
X-Google-Smtp-Source: AGHT+IFkNT6ajNQiw37UOXkrZQZcTWgzSClLDeuJS/Kb9zBFtRLWPuteNWN9r3Gp2AUoxH3rfEq/pA==
X-Received: by 2002:a05:600c:3541:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-4361c36f796mr27470055e9.9.1733934063021; 
 Wed, 11 Dec 2024 08:21:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/72] target/mips: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:41 +0000
Message-Id: <20241211162004.2795499-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Set the default NaN pattern explicitly for MIPS. Note that this
is our only target which currently changes the default NaN
at runtime (which it was previously doing indirectly when it
changed the snan_bit_is_one setting).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-44-peter.maydell@linaro.org
---
 target/mips/fpu_helper.h | 7 +++++++
 target/mips/msa.c        | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 8ca0ca7ea39..6ad1e466cfd 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -47,6 +47,13 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
     set_float_infzeronan_rule(izn_rule, &env->active_fpu.fp_status);
     nan3_rule = nan2008 ? float_3nan_prop_s_cab : float_3nan_prop_s_abc;
     set_float_3nan_prop_rule(nan3_rule, &env->active_fpu.fp_status);
+    /*
+     * With nan2008, the default NaN value has the sign bit clear and the
+     * frac msb set; with the older mode, the sign bit is clear, and all
+     * frac bits except the msb are set.
+     */
+    set_float_default_nan_pattern(nan2008 ? 0b01000000 : 0b00111111,
+                                  &env->active_fpu.fp_status);
 
 }
 
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 93a9a87d76d..fc77bfc7b9a 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -81,4 +81,7 @@ void msa_reset(CPUMIPSState *env)
     /* Inf * 0 + NaN returns the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never,
                               &env->active_tc.msa_fp_status);
+    /* Default NaN: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000,
+                                  &env->active_tc.msa_fp_status);
 }
-- 
2.34.1


