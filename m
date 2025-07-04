Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C8CC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFu-0006Sx-9t; Fri, 04 Jul 2025 12:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFK-0003lk-5n
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFI-0006u3-7n
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453749af004so5394595e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646399; x=1752251199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xQENxFGRfD482l6+gWAdAgnQVEFdxssNteaf2y0Yxps=;
 b=WPMVpgBPtx/1eCBNgXslmfOQX6qFdEqQ/kOR5fL/pKUnStW+E83wpsoOLQAXnpBWsT
 JO8MFRWNHjA3k3uUthHjU4qX5kfYJwOcZT91D31jjU39hGCXZjZc7QdZqRH2JfmXvR/m
 R1g7HPgl71T5RMF4nByuUrSWhuDxHTkX2I9PDM/PcqWO1MRHeXR6Wu1E0tPZ54girWtL
 bTOdi5O3fAQMhN0zUOYZEi1idbQpE4HMgT3h2AkK5lEMRyFoq4EN+8/AU2YHvRGcPcoq
 +S6ddE9xIbvuDuqTMIvZMgFaH7uTdqsE+zp/MPFwIPiYltWNeruZhekyB+zsfmF35tpR
 tFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646399; x=1752251199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQENxFGRfD482l6+gWAdAgnQVEFdxssNteaf2y0Yxps=;
 b=RUvEUlwRSSnR1LCDfPUaoPUTVvPtN9+qF1EQCL/rusWoSaYzXaJo9UxCjN2SIV+Nlm
 usGSfj8yCqMGJslsiLZFaOwVrJ+jaD0iQqN7PpEbv2VNr2vH3Rwroidr/j+ptDy5s6BA
 JslPyppn1lvcMMqHQYml90thZ3vlkNKACHZlVcQmjBInA56ntRfltBSlncx2FcXxz6rs
 NtraBzk2ErG2pM+m5715zRxOiVeakd9AibS1gSfNNxLF7qqTnzSukD9nt4f0PQU2avvS
 xP2M+FdoJJH3xs9lHUKOKzHKwOHiZAgNqwrA1jC/kiNWyzTvCg47LBFEpv90c8tUCB3Z
 ckmw==
X-Gm-Message-State: AOJu0YzhKI89TGnWDZOCVGurUs3hxx3zNUCssD4P3kaGai6ptIcsokL6
 GgcpXxq0LYhyZw0lFfwoFNOlhUdky/16HdIRErUhu1UDOfCb7DIIIibQZZlk6PwkQ+thKzfXwBJ
 iROkf
X-Gm-Gg: ASbGncuX89YjB09EEOqgrv5a8jWKmAPz2xGF+eDdffW2xnK4dxJ+lhgkJahW+vrdpnI
 czV50o4OL3VLO3NmxmxjoaGYiRY+fuQbkqJelFyDh5gTBnxaYabjIlyZg6nk4x8PVEDwmONDx6E
 wE6D2eq07glGeK9h9xOLrV2eYZHaYo+mZQ+rlOAd5bTXqLeEnsiKIG8+NqhQCmMxqjQuDsiA/Ko
 +Sron13NGh6StiMyG1WjtKlPgPDgBlDxkP49tVLpyocWUHC/1r2J83lE9i9DckYkeuwStpoldXh
 ebooBPqHNToVUiMlYf6PLDE4Vzbx19f/U4MxdxPVrHpizx0vzjUFD2g3V2NJK/ix9XbA
X-Google-Smtp-Source: AGHT+IGcq6KVk+DzVjXPOQsRA+qOloFBE4QH8Cm4FT+HIcdyiB7bh66UUTs2AJCijyXsrs0qs08lyA==
X-Received: by 2002:a05:600c:8b52:b0:442:f98e:f37 with SMTP id
 5b1f17b1804b1-454b30df071mr30341685e9.21.1751646398583; 
 Fri, 04 Jul 2025 09:26:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 101/119] target/arm: Implement EXTQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 17:24:41 +0100
Message-ID: <20250704162501.249138-102-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-90-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  2 ++
 target/arm/tcg/translate-sve.c | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 2650e00f80b..af4fb966bf9 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -583,6 +583,8 @@ DUPQ            00000101 001 imm:3   10 001001 rn:5 rd:5        &rri_esz esz=1
 DUPQ            00000101 001 imm:2  100 001001 rn:5 rd:5        &rri_esz esz=2
 DUPQ            00000101 001 imm:1 1000 001001 rn:5 rd:5        &rri_esz esz=3
 
+EXTQ            00000101 0110 imm:4 001001 rn:5 rd:5            &rri
+
 # SVE insert SIMD&FP scalar register
 INSR_f          00000101 .. 1 10100 001110 ..... .....          @rdn_rm
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e33b2eb2a4e..a918da31fe1 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2202,6 +2202,55 @@ static bool do_EXT(DisasContext *s, int rd, int rn, int rm, int imm)
 TRANS_FEAT(EXT, aa64_sve, do_EXT, a->rd, a->rn, a->rm, a->imm)
 TRANS_FEAT(EXT_sve2, aa64_sve2, do_EXT, a->rd, a->rn, (a->rn + 1) % 32, a->imm)
 
+static bool trans_EXTQ(DisasContext *s, arg_EXTQ *a)
+{
+    unsigned vl, dofs, sofs0, sofs1, sofs2, imm;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    imm = a->imm;
+    if (imm == 0) {
+        /* So far we never optimize Zdn with MOVPRFX, so zd = zn is a nop. */
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+    dofs = vec_full_reg_offset(s, a->rd);
+    sofs2 = vec_full_reg_offset(s, a->rn);
+
+    if (imm & 8) {
+        sofs0 = dofs + 8;
+        sofs1 = sofs2;
+        sofs2 += 8;
+    } else {
+        sofs0 = dofs;
+        sofs1 = dofs + 8;
+    }
+    imm = (imm & 7) << 3;
+
+    for (unsigned i = 0; i < vl; i += 16) {
+        TCGv_i64 s0 = tcg_temp_new_i64();
+        TCGv_i64 s1 = tcg_temp_new_i64();
+        TCGv_i64 s2 = tcg_temp_new_i64();
+
+        tcg_gen_ld_i64(s0, tcg_env, sofs0 + i);
+        tcg_gen_ld_i64(s1, tcg_env, sofs1 + i);
+        tcg_gen_ld_i64(s2, tcg_env, sofs2 + i);
+
+        tcg_gen_extract2_i64(s0, s0, s1, imm);
+        tcg_gen_extract2_i64(s1, s1, s2, imm);
+
+        tcg_gen_st_i64(s0, tcg_env, dofs + i);
+        tcg_gen_st_i64(s1, tcg_env, dofs + i + 8);
+    }
+    return true;
+}
+
 /*
  *** SVE Permute - Unpredicated Group
  */
-- 
2.43.0


