Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C738CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeK-0003zT-7b; Thu, 14 Aug 2025 09:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd6-0002SI-2Q
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcx-0005CY-QV
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e2eb6ce24so871089b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176655; x=1755781455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dB1cHT1ha866F85MzBv2WZgn+PHcRylb/+Q2tL/eLA=;
 b=Xu2l+9doRa2p58XxoYGX/BMDhNS2uYREsS0/Sd4scXld7UAK8DomR0WxOs1ZMt5NY5
 Egqv4oLTW8l7O/TOM/XM5kd4DzAJnKTxcfWGueFR2QJOP1ZZrOLf6ne8kZxJB+APSUK+
 Nm0Os7h8CKEPuHpXitSy7pOjDyc6BnGXLddJ9fxkOKVlZa8p5JpSuVEua/Kag7F67xX4
 dq4M2MyGSDrnG7k5Cmtd5/lbbWUAlf3grVdmUQBcu66E8oDO3r740bviVN34Lr66vg6X
 z1gAV/wIIrol7PLg+XDvO172rvVK4gffBeMABtDjfFMjKKtR9IMZfiMSQRewBh3rRAJr
 qjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176655; x=1755781455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dB1cHT1ha866F85MzBv2WZgn+PHcRylb/+Q2tL/eLA=;
 b=FR3odS62lWS4p0plzrWN95h1OJVRHs/pVI5npTWhHy3S6UVPvtD4cRSmpzbsgBSZew
 m5b4cqv6pQRZwTFQVfMO8GHhwMrCDBqR2fSeuqghLXf8Qy2gNHDPIv68v/EmDgNtew4v
 ZJEdVCqTBLDEHPfawQRUiSaiMKsuabrW8Ou+En9N/BXhxh5XvdQ88xFhuGMDmAo5Foxt
 G6+H9gJJIfie4XRAZZWoS5df493pKrxXigi3kznHLr5Lm1ISL7kpFsDU8wGuKT2O68TS
 oKGWAS2T9INGM4OG2CeQ8RJ7Cuna6DnDxaMz25ppncbp4IcNtuujf2DMVOA17hCQgRsV
 Tx4w==
X-Gm-Message-State: AOJu0YzE37vBKvLRyzypS/Fr3gwdJF6Ybur1djkmPLgigx6FQIBeP6B/
 uExn7Iqp1HVvzHPx6KmhGn77gWu55vXBx4WpXlB57lpWphbI1NgGx3VbTGTkfaLi+O9Lqw+k7RE
 xzLK7Hzw=
X-Gm-Gg: ASbGnctywFvMpcoN0S/oHP32hieuEWSF6Ei5SaHH+3ZPfzbeo/ty1XZp+bZk+GqSy6r
 Hb6RwJYkgxKkOlXFVsz7pHKn1cJ7kfIlTlxe702VGf3pIAbShdL2y3POGcpQX1St1RP5Nn6Omdy
 z6r7G3aKq5UBUXgLpPy7YhLvJ36UgPl/t4XoecmucIeLDQ1W+oiSLuK+YEjgwvqfi6JjBg7BFuI
 fsSq05HP9OmJrfXRJTqlPAnY1fdlRTdKz6iSEjNzLLa9/3YqshbpoImTzMNQC7xctYQRgJu/s46
 fu7zpxjLUgnmkrIXS6qGgVN5ffQwaLfDMRlX1/X5vc4r1Rrnd5vHyO63FR16jEjnQN2qQAR7J8q
 q7xlSJD8MCIdCc1QkI9OLOp0eiZZwWkSuKxE6p1BMfBg62ns=
X-Google-Smtp-Source: AGHT+IHqdxRRDBrq443rv8jsjug/ztz2Gyg5PyVKaOZSVL3XJUjW2vsaadTCuLeGMw10heHkWfTDYA==
X-Received: by 2002:a05:6a00:883:b0:740:afda:a742 with SMTP id
 d2e1a72fcca58-76e2f5cdfabmr4593689b3a.0.1755176650188; 
 Thu, 14 Aug 2025 06:04:10 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 56/85] target/arm: Emit v7m LTPSIZE exception out of line
Date: Thu, 14 Aug 2025 22:57:23 +1000
Message-ID: <20250814125752.164107-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


