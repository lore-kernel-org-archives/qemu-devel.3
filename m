Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219A0C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhNf-0007eT-7A; Fri, 04 Jul 2025 10:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLe-0003jC-QM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:07 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLa-0007e0-SK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:06 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6118c1775dbso307492eaf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639101; x=1752243901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evIEKVuk/ILgHNEpYwuB+i/P5ybvHcDbwAQ21gq1RzI=;
 b=uik+tFqHnKwemPl+iC4k40fgSlECXsGPr0AuLdkmKc6A2fLWAZRHU2D2tIJXraFS/E
 6pJFAQa36gYB8HcnpqxvBqi42mBBI5km+nta6/j++Y3KXF1u3gfKulII0d1JuyzBNdZf
 GhjSl66Og2B6GZCCYgn6a2wRW2vNCGFEXA9vpOK/xbrw/CSwG6et8+l6uJ2iao2ikjlu
 y8kg0lVg2lAK2TvbiiWpCnnzysCk/Iq1RLkOvhPAyq7e/6nvGF8mVSmil00qED4bdpcQ
 AJt7cVM43rACvRs4RFksM3D0kKRFLYGw5MOkpfde4Jown8Xi7C7o30mJG8jGoNTEnQu2
 32jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639101; x=1752243901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evIEKVuk/ILgHNEpYwuB+i/P5ybvHcDbwAQ21gq1RzI=;
 b=g3531lTnKWUkAXDUneVEDYUYRtN+iOPlClvPsd61K67DL7siUkwUeR69ZrMV5zkKy/
 ZokhAQXLgi0zLvbS/nVU/I5BTgkwOSQsJyH3UxM+qRFhExFnNuisCpdt6fgDEOwsNowq
 e32LsMMgne34Gw+CCaBPcJYrYxQuxzvXOeFtBbENLdecV+JFI65Ykro6zg0AYFfgWZTD
 4LNtZnz2f8jRuLwEEAG7e+lt+CnqO8eckzmrtRY6iJgeWMSF/VMrWwX9JXrETlump7c4
 1gSZMYwtIWLvKJoUKPrhpjx8pnD57gT8oV5OEQzU2lEr1Qu9KxJOBeXXIkztWxmNpiOT
 q8HQ==
X-Gm-Message-State: AOJu0Yztcq/BzVJ2hw86EU4lcD6LhrO1J0ycpRqEe7UJoUHaugGwpSkW
 Gt0XwDnuPDADy7j9/lr0Hb1EUgiCQJURJQsZHdbjio8t/NtUzyqeXrUT1nDg8kdHUqpvO7Ql6zb
 pyyly9pA=
X-Gm-Gg: ASbGncvQmddlnxBWM0o2XxSNKjRvcxcCGXrcAZCzLiY3HiLVj9FEGFtd9MqOcSX19Sn
 QqGhIGFC3vmdalGm7eX89zIXs9zN2w3L1tUWFu9y6ohE7R8AHAKdpo5UNDmoVTtz/Hg+ZZeEeJ+
 wFXc3VQtMQ60LKp3oRSoB2FqSesy4eQi0/2LGePs8aHl50tqCfH5VkFNwLi+vG8WDUn+JVV32vy
 FCfLBwT5+xXRlwSAzg79dINeUzu49XqG4OF/sCUilWUpPQFFst3AQTOcQyUYb1+6N/KFDG1BuBJ
 RtkUY/5B6IpALwHTiUxNSzBbl1WjxOmbAFUwnZXGWMqhTDj6DFWIMW1KGY2N3BRGSWbPyVOd583
 gUznxgri08HxMICUZcshwwVPQdzvhlgrf9oqG3oVDBtuTi4s/x7nIS4DW+lg=
X-Google-Smtp-Source: AGHT+IE1b/BDR9aou4q77wJH9vTRt7iMwd4rQPP7My98TVt6JLosHCiq9rcq9S08CD9f8e6olVPy3w==
X-Received: by 2002:a05:6820:1796:b0:611:ae2b:4d33 with SMTP id
 006d021491bc7-613900ecb32mr1923206eaf.6.1751639101543; 
 Fri, 04 Jul 2025 07:25:01 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 044/108] target/arm: Implement SDOT,
 UDOT (2-way) for SME2/SVE2p1
Date: Fri,  4 Jul 2025 08:20:07 -0600
Message-ID: <20250704142112.1018902-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 10 ++++++++++
 target/arm/tcg/sve.decode      |  8 +++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c82a0f771d..10261e25f9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3426,6 +3426,11 @@ TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
 TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
+TRANS_FEAT(SDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_sdot_idx_2h, a)
+TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_udot_idx_2h, a)
+
 #define DO_SVE2_RRX(NAME, FUNC) \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
@@ -7154,6 +7159,11 @@ TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
 TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_usdot_4b, a, 0)
 
+TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_sdot_2h, a, 0)
+TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_udot_2h, a, 0)
+
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
 TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 401c025852..83c259def6 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -856,6 +856,9 @@ SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
 UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
 UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
 
+SDOT_zzxw_2s    01000100 10 0 ..... 110010 ..... .....   @rrxr_2 esz=2
+UDOT_zzxw_2s    01000100 10 0 ..... 110011 ..... .....   @rrxr_2 esz=2
+
 # SVE2 integer multiply-add (indexed)
 MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
 MLA_zzxz_s      01000100 10 1 ..... 000010 ..... .....   @rrxr_2 esz=2
@@ -1597,7 +1600,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
-## SVE mixed sign dot product
+## SVE dot product
+
+SDOT_zzzz_2s    01000100 00 0 ..... 110 010 ..... .....  @rda_rn_rm_ex esz=2
+UDOT_zzzz_2s    01000100 00 0 ..... 110 011 ..... .....  @rda_rn_rm_ex esz=2
 
 USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_ex esz=2
 
-- 
2.43.0


