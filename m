Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165D4C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYJ2-0005WM-0X; Tue, 01 Jul 2025 06:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIu-0005PL-Rq; Tue, 01 Jul 2025 06:33:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIs-0002Ni-JU; Tue, 01 Jul 2025 06:33:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23602481460so55691665ad.0; 
 Tue, 01 Jul 2025 03:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751366007; x=1751970807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aRIcodaoxwPOVqLMAiD3Xs6uLadGOPk1WBQF+3EBdA=;
 b=C5u+RIgWcMaJUTSwBeneo74yAfQQzh+tOsFefx9jFakGXJwt8zQQ8s3hx5fgk4Wjw4
 yO5aal9jU257JNtXTJTKLuU7PHxyQybLRnFwpgBe0cWi+APWt7mBcyYaFQl7C1ybStBT
 +e+7A2FeJ4mqT3yZv4ItqcfXmAepA0AznxfuCZoi5mwGSYUiZmUwnQdUBtlx0VQX4lZh
 r885kfT3U00lULLTQZSV+JuuuoTMkul8gmUnJKC5x1TzVIwMcJsiRMgldQkTDb4WU9uO
 PbT9U9+OxYk34fCE/sUzwqjXdjHUnUf/XmQJLq3wdebj2LljTXmcpj8A2R2d/EyEKhPP
 hBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751366007; x=1751970807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aRIcodaoxwPOVqLMAiD3Xs6uLadGOPk1WBQF+3EBdA=;
 b=aSYu1vnwYgi4CwlqgCqfk4ZaXIIDLI/R93IlaAoL2dT16MmdXSB1ordI2LATL0roEc
 P0c58gOulKBejjAkW8xVYDaFMq77C4KulVSqF/14AiVtPHGp8kyZPo96R4MSSWKsKZbk
 O3fcbbzptKve1nqU4j2rL/zz56LngPyggo+2u3y1Lnsp+a/RKTly6Ox5yayU+QCyyI1U
 JpAG8mLYgViElN2xI+9wivsv0WhSjr7yo0DzRMprK+9q+l+3zopzJ09SDSijC5tZFUBP
 qL/Q9lgH1lZ6022a3d2SeWGMfviCiaKgHV2WZ8uYia05mQo3+xcy7Cf7N+W1Izu6Pjw/
 ju7A==
X-Gm-Message-State: AOJu0YxGbnpuvn9IxAVgJL5asnwes2lRM31JSjw22EXEo33YrqipA2Dj
 w5LXOI/pqwwrUl3FGNqfWn64yyZ/Uu/FAG/2iTL40fgGfOR4N0Bp89Xk4/WyY2Dt9pc=
X-Gm-Gg: ASbGncv9H+09ltNLpkKFZuL/MCDd34HWSwPGS5uWSU228cXxoTDxjQTaPKeSwflZJZF
 kRo+ll1dhAHM026+2aMeEc7gPnOMdIlCf8GC4Oh5pK0xQvAc8vjm2R1edHwiC1YLgGErfAJgj2M
 K+BlsIGaCyw77sTE5iAqeRi+a+8WI/lD96lSUzmr+vBS3NtlX4kI7mrtikwVA3dlUylQsq3PKGl
 K05kUnwp8+64hoCgNus4J2N7EAQH0zkOrTNuoe1ME/9G9eAL3tFdsftKU71WMdDuhUc3MFv6w7J
 mpY3vFz96YzCB5yovfb6SccweHMg13UTlEtcyck7reBxeSal4vRUqO7c8qc6QlLSvDKj+DpEN2l
 IPlyEOGI38/nJTtiSC5y5f9T3DEMaKibTvGgIrt9J/hA=
X-Google-Smtp-Source: AGHT+IGM3ppVDuzRwXOuBF6/7ine2kkFnd3QIiy1osrAHX94x6RbrBd1KeYYf3dEOSKYIjydoBhSgA==
X-Received: by 2002:a17:903:1a67:b0:236:7333:f183 with SMTP id
 d9443c01a7336-23ac3afd8e4mr245773125ad.19.1751366007307; 
 Tue, 01 Jul 2025 03:33:27 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb2f1c40sm104476955ad.67.2025.07.01.03.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:33:26 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 09/12] target/arm: Fix VLD2 helper load alignment checks
Date: Tue,  1 Jul 2025 20:01:56 +0930
Message-ID: <20250701103159.62661-10-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations in the VLD2
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 2d2936abde..9e8ea04074 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -513,13 +513,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 2;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 4; e++, data >>= 8) {                       \
                 qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + (e & 1));    \
                 qd[H1(off[beat] + (e >> 1))] = data;                    \
@@ -537,13 +539,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         int e;                                                          \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat] * 4;                                \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             for (e = 0; e < 2; e++, data >>= 16) {                      \
                 qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + e);         \
                 qd[H2(off[beat])] = data;                               \
@@ -560,13 +564,15 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
                 continue;                                               \
             }                                                           \
             addr = base + off[beat];                                    \
-            data = cpu_ldl_le_data_ra(env, addr, GETPC());              \
+            data = cpu_ldl_mmu(env, addr, oi, GETPC());                 \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + (beat & 1));    \
             qd[H4(off[beat] >> 3)] = data;                              \
         }                                                               \
-- 
2.48.1


