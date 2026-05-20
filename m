Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DB2CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPleF-0007bx-Gk; Wed, 20 May 2026 14:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcO-0004Kk-ME
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcM-0002ET-GK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso35263475ad.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301560; x=1779906360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2+saFtU6sDCDywdiaR0c/2CKQQH+n8UBNRc/yHjQxk=;
 b=FKG8t7KyA2BmXWaJoHxB5YontGqK2yMt1beiZQn+F7jP3WsSlESGhWbU/LamuzA7cz
 UktptW3+m+AAL6OZacosl8M1npvqhS+n5X1OwjDMaFPiErb8xSlAm00w5Qb3ubM6+s5p
 j3p6waF7Xzc/etNg1wd58hT8zzbPfYVSHGDMAWN+g8nUhnb2E97cg9APcpCd9J2PanB8
 oYP6mORjMiu/a3OuchfKgdCZvY/DZujCSCn9DbnVihmLGTQ1Z7QMXime5BI4aTkCB6zU
 yB9McaUDL9kG52tFdKgX09HRwFBX1i+OzfWeH+UDut2KIY8dhmb8CJ+WDfhJrIBHKqel
 GSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301560; x=1779906360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2+saFtU6sDCDywdiaR0c/2CKQQH+n8UBNRc/yHjQxk=;
 b=aPDuLW7VxSZpWus+LA4nn7Zy0/iTRKkKnDsEH5FNw4sG0Zu4FiYqezMEDqu0g2Et0t
 c3/x3E58MlA9fBlUd10CgPV/ml4pSttuYLq+PUuCPZjq6nwAM1vyrrKDVzXYOjMBcc6o
 WrHuB5iey7xEMN/AFWM36YzC4aYr9ZvQWIRm3XS10tdzobhDfSnavr3MlXvnILJN466y
 peOuaj1fYzpJegSMl462Qxlf0HGYfNreW2QoUFY51q0yOPAiQuSbgv7HBycwly9AQClG
 OaAuadhJxbA8id299HbbfH4Ye+zK5nMuSMIGzXnN7DnHS95pLGMnBsKBGOehAOK60jkt
 ZYBA==
X-Gm-Message-State: AOJu0YzVmhRBpl6UxZK7CDYTVGa3AY0hjxU3kIkSHYdRNKWGbYQd86L2
 KsHA1ZgOdsCyujZBXFTbBJ/C7x6N3lsg3EWQr1xty20ezGEXEF0p1VPeE2mG2Cj22Ob87+eBtIR
 n+z34mmo=
X-Gm-Gg: Acq92OE4DtzLdq0MsGaKdJHqLPsDXFA07v6YkYFHgFke0WrN5asqXrKo35PsxA+mJhm
 gbR3ct2vWVGWhmM2WWYgYIK3wahGDfNRFtK5SovMHN5/jiSG81f46GmALoKSZhGzonG68u6VsBF
 92LgTVOXIvQcns+GNy08FDdOCT9yLHHMelujmEzoM8ASrJ0bmQWP2zHu6Xi1cmeHhIBMGGuQHRy
 fAoHjyiyEBUsubs4KAVHQNCrGcUVYuTi342cuHzilAk8u/UVctk8MIqgJ8Ea+Cz1fLZOM0QY6Gz
 tiO2m4ZRrY1FB8zCc1Ro4wBE/jrO1n9/1F3BmYfLLeG+U/KNNjFygA2rvC+KzaJneMl3AdALzgm
 RUTmxTh3XLHS5LaTBJn3cJFIFAPkzA8vhIuMTnSRO6R/FpKyaS3Xj4qnELLL6J0aaQcON254R/A
 m4MFgiENUcaLdfnG/Xt2tCaAuhFjml
X-Received: by 2002:a17:902:d483:b0:2be:956f:144c with SMTP id
 d9443c01a7336-2be956f1dbbmr29658265ad.2.1779301559602; 
 Wed, 20 May 2026 11:25:59 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 61/64] target/arm: Implement FMMLA (FP8 to FP16) for SVE
Date: Wed, 20 May 2026 11:22:10 -0700
Message-ID: <20260520182213.872945-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


