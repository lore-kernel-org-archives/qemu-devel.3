Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E050CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZBy-0001kJ-L0; Tue, 16 Jun 2026 15:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8P-0004dX-OM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8J-00017P-Fj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so4212628f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636851; x=1782241651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ghI20RlhSwol2c5KJyoQIvx6SEEjO2aKn93WrShChRM=;
 b=kg0yBfP9G/m9i+4ls4qefKIahNEiYKHb2LRluNaSOqwXrfv3Nzhd+wsv/VAicyzB/u
 iGI4Gz8wo1OzTt7JfJaYP+u4RzSvWRA4GrlesenP2X42hpbgUl8Sv8amCkDHQpgssJoZ
 CllIV4y5utLyxcBdZP98DLy+TeX09y+JBKj4Vbin9zDnpQA/7+NZw2I7D7v3Kh51IVHt
 2jaq2vGXDEaKFbEpMfrRF4EsXKaq7VzU0rDLRjfTdSQrpvinz2ENHumoy2suvfpU8k+q
 LkheDyXh1i3tWvjIEG863+UpyU5C6SsDg1RMolO7DuvLDlykxmv1OfK8B8X7bw66HbWW
 erog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636851; x=1782241651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ghI20RlhSwol2c5KJyoQIvx6SEEjO2aKn93WrShChRM=;
 b=a3BDTGUipBdeiCbxa2qlyoaYH5OaB+TGro+rlTFtotGzaE07N3fXBljn0DTeMryEl0
 atwoCNHXYkAvdNdqyqG4LaXruEUsWL919PUGMbT7qw+WNUOaX/jORCs++1yKXT6KMB49
 zJ88ixNgvPDdaKoRGoiSTVD6SGyCkKLoJv3tEEz34SDtpT0sGdFxTbHOUXXa6KM5EZ/K
 OVc3REQ9ocXt6vMxf3LUe16RcuI/H1O5AAzPeKyUoRVzghG1id8AGYMOgtt48mb5to7f
 LWviuLTftCOddOu3t92i2YXjTZLrcEkk4NeYa+wfe/KfSBCzDOptD76BMAxSy12k/+mp
 kR6w==
X-Gm-Message-State: AOJu0YxaXeNMLlpL7xlHFCTxGoli/6Njzef8u6DgjFJXfmenlKdxLv2q
 USZ3wk68PsKEU/mj9edSTFCLP0IAqdv8m/rRfnMxnrwQYzYALNwrjBCuzM5Kpg7/V/aQ+832zkI
 X3poF
X-Gm-Gg: Acq92OFi+m2ntFaFX8HavdIBSgyWQNHhnIk9fbgMyh88EPgk6g92gXY3G2TjFV6BWMA
 +t/efZBS2Olc/e+5JCwpi5YDVl4jh1m4Umc5YOMdcOiePlyl1s1byX93xV20XOfU9XW9ClHbG4S
 yP3dC3P/i6iHE5kThMqaJGIoLWJsSvaXzhivzDwutZay58P/7tgiG6z332om70nMUFJzh5e6zhN
 pYI/rftc8EhOLOEG+cMuDtn0tNORiOoef3C37v1DpXbmNXANAMFmtYGXO8u9uHPCG/1++5sk9BB
 Kh1xONIBrlN8zEgb9Al0GLvvZfJ0Ykrc3D1b8ZdwLuVhXHtvsAQzwhFCGXxtUz69prhRG+Q5MCQ
 /UQuGWxlx2CVlRIL6Vxwzp2YDgt4zLdV6isk5via26lGTDZtyJ86FjG7ICZZYep7gDsyq7M2S4b
 as5D+DvRlqUBSDCLCtCF0/25UVK+ap/Tq2Ku87lmVe8IEtEVtvH9h8xtlniEZnbF6CL/FB1/SZE
 qjI0oC503EMMOOMUsz3vMlNSoHuj0Ug
X-Received: by 2002:a5d:5e8e:0:b0:45e:7997:8b7a with SMTP id
 ffacd0b85a97d-462356ec3ccmr1101595f8f.16.1781636851175; 
 Tue, 16 Jun 2026 12:07:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/61] target/arm: Add feature predicates for SVE2.2 and SME2.2
Date: Tue, 16 Jun 2026 20:06:21 +0100
Message-ID: <20260616190639.3462006-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 9e70d30964..a80b251589 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1516,7 +1516,12 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_sve2p1(const ARMISARegisters *id)
 {
-    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) >=2;
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) >= 2;
+}
+
+static inline bool isar_feature_aa64_sve2p2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, SVEVER) >= 3;
 }
 
 static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
@@ -1625,6 +1630,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_sme2p2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 3;
+}
+
 static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
@@ -1688,6 +1698,11 @@ static inline bool isar_feature_aa64_sme2p1_or_sve2p1(const ARMISARegisters *id)
     return isar_feature_aa64_sme2p1(id) || isar_feature_aa64_sve2p1(id);
 }
 
+static inline bool isar_feature_aa64_sme2p2_or_sve2p2(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2p2(id) || isar_feature_aa64_sve2p2(id);
+}
+
 static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
-- 
2.43.0


