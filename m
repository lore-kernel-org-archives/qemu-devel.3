Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6118DC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zq-0004Rj-Eg; Fri, 31 May 2024 08:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zc-0004KZ-GB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:21 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zV-0003PX-FU
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:19 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e73359b8fbso26596891fa.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157050; x=1717761850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=edFpffT2hsSlEVOjiDyp2/AHPs7CCZ9Ib66cBmt6/t0=;
 b=kV4K/1HQQ+DSRH0O6t9RUKGyuaKuomCWpdtVjjDo5hNWY68clM7A+FqJLyuh5fGBiY
 Ebjax6b3d/xf3/CRNtSHqmF8QRZtfCV/Ve3WXAuuRb50CMVTJfSQNYAi5rU7bGUBU3pM
 TR+IXHK/jC2xiFqle/PU3plDV6l/JLOztP4/7dhd3G46ExpypjQacsrgjrfOWqLfJ6Fi
 vRUOkdGxSni9h/q5TQ17Tit7aiiTLpMXkHXF7w0s1TaPKrFDf2OazQKh1O6fXAkTYuKr
 x3uBLTlAtGgvX1o+Z1Ea1Sn7pxHfYI7bgZrcXutuHXOR/LyezBUGQKJaYv7eojUjkep+
 Jjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157050; x=1717761850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edFpffT2hsSlEVOjiDyp2/AHPs7CCZ9Ib66cBmt6/t0=;
 b=VpyXfDeWGzEBAcFIejTarsqbCaRsQ7nlXBZ+kGhsRa+FJk9oZjzpRpqY+rgXaAkSjm
 8i1J3Lq1/q3Sofgbfo0tYuTF3DEoKXSEJinoX5GXDjsEJ+DviXf26/utBSgMYjYOBOFI
 BZ60jTV/ObxxvigEB6yUf/K0tXWHugWmoCE6gi/fv7lS56/yIhCi4s4VekcR4tB4df5A
 r5lbR8k8xyZ4REVubm/2PhyAmmRuKZvCo2/ENGurnjKGULakYvDw5+xfURq6f9Y/z4F1
 mbwcb+SQh1sJRjiRY1YIfpeJIgc0tizSIojRyc4Y7EQvzOxYlRSyKpfRQA7H6GDRuqWQ
 jpiw==
X-Gm-Message-State: AOJu0Yy4hgmbGWV6r9Stg+zqROfuONmZ3WIe68yyssedmMAhadmqhfdv
 YAyClXaDV1Ur8DeMSuCetzLJ4Ua7laiEz2CcJ0tZufXIrwCAdp47eddCyi+/07hejjgIsxrt3g2
 1
X-Google-Smtp-Source: AGHT+IH2DcViYR+iFfq4dbGkSxUa1/Eg8BiFJyzIuOgiI9PDOW4EXknOXUW3CsTjv7S1vnzfbDRWaQ==
X-Received: by 2002:a2e:780a:0:b0:2e1:ae29:f28a with SMTP id
 38308e7fff4ca-2ea951e4b00mr14103781fa.34.1717157048702; 
 Fri, 31 May 2024 05:04:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/43] target/arm: Assert oprsz in range when using vfp.qc
Date: Fri, 31 May 2024 13:03:26 +0100
Message-Id: <20240531120401.394550-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240528203044.612851-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gengvec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index bfe6885a018..3e2d3c21a13 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -29,6 +29,7 @@ static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
 {
     TCGv_ptr qc_ptr = tcg_temp_new_ptr();
 
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_addi_ptr(qc_ptr, tcg_env, offsetof(CPUARMState, vfp.qc));
     tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, qc_ptr,
                        opr_sz, max_sz, 0, fn);
@@ -1255,6 +1256,8 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .opt_opc = vecop_list,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
@@ -1297,6 +1300,8 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
@@ -1339,6 +1344,8 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
@@ -1381,6 +1388,8 @@ void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .write_aofs = true,
           .vece = MO_64 },
     };
+
+    tcg_debug_assert(opr_sz <= sizeof_field(CPUARMState, vfp.qc));
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
-- 
2.34.1


