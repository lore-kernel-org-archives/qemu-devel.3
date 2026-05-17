Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6E2CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPT5-0002PB-An; Sat, 16 May 2026 20:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSJ-0007B5-T9
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:12 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSD-0006sX-Vz
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:05 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36900945df5so470433a91.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978040; x=1779582840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2+saFtU6sDCDywdiaR0c/2CKQQH+n8UBNRc/yHjQxk=;
 b=IWxDM+xo4QFzN4L2Dj6ARYXzei3ACqnT8YzQel1jtecOuFmEnrG7TiRQSIO+1lV08Q
 N1b8DrovYPDh79oIErRwF6rvLuOTWXNN9heZQbn3JThFVe472TKAIoecxUoBJ8sE04/L
 Emyl9ij7OYR5drKhapUA/7SRdatC7WaVZUYBJ7Gcwj+jk7Q3gWPRRBmUr3UcoZAMueco
 INL4zNK4b5t+OjmtBtc5Jbeh9wyMVh/yaUHIdzdYWtalAXbkI2QEvbXqAqohAwJpYk0q
 g9VW3BbjaWwtj9uVGq2KjvU/adzOGlvQzrATGu9sLNF5hSZgBN3c8eeOumdgeCqcz9IZ
 Q7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978040; x=1779582840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2+saFtU6sDCDywdiaR0c/2CKQQH+n8UBNRc/yHjQxk=;
 b=XnSPoj/Hno8scTpIqs5mGs9Yw3ae7nGHPmBlCZQ6DegdM2jTeAJBdNhcUuQz4QbRk/
 CKyO0q2ccf8s02Xy/pSP0oFDNs7cBC1Bol/9C2CLYlf+4pMODay1UYqs/NAHQMRiDOgV
 I5ldMg0OipjjTl0tjIKnZ7QhVLnhr1AlXMnMjq6FCBhQhk+nCvDJZDNzm+GagGXfkneA
 bznfWsT1rGhoxSp2K5YyU+qP0Laj3EO2pKBCy0tBrCfyIALzV/2EkKivz6LGEmp2uVMj
 oOgNNf8oZkb5znO8mKB2cNn4SGahvkyxovEqq8jSUGx/eHHXJN+Gc0t7RPsAtt92Aqin
 Yj1A==
X-Gm-Message-State: AOJu0Yw6ZvKa75l49/zgKe1n39zwkajGray2XdPmmqRxS3mKjjoYloc/
 ax5spT/EH54W2hvPghs3ljyxT+4L2I3AUId4t6o3OosGGGOFOlzmNdETXXaGMszlrOk3hJ/sgfi
 yRDnw
X-Gm-Gg: Acq92OE05TpL7o9rWvRGjppXyYzFsQsv+LTJ0Gokjc17NUoKkMsBPcH4m5DtHv/p+3p
 L6UgJdu36ZQhpmSFZqcYMzlYtNA8yWcuxjtYxDX1AXD4tKLBzmUAVSmRdTNRNz7jxx3OhRY0OV+
 I+d2Lgocm9J8UblVy3KWdN5AW1p8wStk4GqkAg/qhW01M9jLI5MsxpduTGvqNm2xTV5IVkk9TLN
 /k1EvLiyJjELKqp8PgdfXduaMWUBVMbKUi4u9kbo81iU0zi9+x5zyl3M/rosVLeOuRhi07sID3t
 YqAw0Gw/htx0bML1KTTMdIpb6NryRWekERS4+xZNzyqDn/S7wed3OyH/sZGMjx17MJCf0FKIlrR
 4EwVc2q5AOegqQFZkeZXU7JvI/KP2SbqiE/4ewbpL20B0ma39VSU7rwne1xSG1E5E6V9u8VmD9b
 O0JVVI1xnoBbM+pCiLTVH4utc9C7qI
X-Received: by 2002:a17:90b:35c8:b0:356:22ef:57ba with SMTP id
 98e67ed59e1d1-369518b669amr9859171a91.7.1778978040474; 
 Sat, 16 May 2026 17:34:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 60/63] target/arm: Implement FMMLA (FP8 to FP16) for SVE
Date: Sat, 16 May 2026 17:29:59 -0700
Message-ID: <20260517003002.321430-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 target/arm/cpu-features.h      | 5 +++++
 target/arm/tcg/translate-sve.c | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fce38dfbb0..3eb08da6df 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1703,6 +1703,11 @@ static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
     return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm4(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bda5f6c01..2bce6a38a2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8458,3 +8458,5 @@ static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
 
 TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
                         gen_helper_gvec_fmmla_sb)
+TRANS_FEAT_NONSTREAMING(FMMLA_hb, aa64_sve2_f8mm4, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 6610432528..b53fe6a58f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1809,6 +1809,7 @@ FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_hb        01100100 01 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 Memory Gather Load Group
 
-- 
2.43.0


