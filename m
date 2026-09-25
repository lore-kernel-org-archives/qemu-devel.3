Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F775C9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADos-00088w-26; Fri, 25 Sep 2026 17:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoA-0007lX-Uy
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:26 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo8-0007lY-3L
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:18 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469e211a0so785080b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373010; x=1790977810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FSdoU+FSdyC2v2sCymw+VLzuXFDHBTG/nVBUdUuu2oQ=;
 b=oSUPkG0IbLLFMeCHwKMmHULvNzGxZPEESwFEr2vlDCmmcVHah7zaDRVo5kIX6O8DH8
 YmFnbXyVx/Ar/WH32E/kixuf6MAXuPiUFWNW3nacncrdBUaUs6dfUeVNbc8d2UoGeWqm
 f4mvtwMgyw3bv7w0FZ3MIwLFIDrRdi9AxeEK8mxRRQ33Eciia/tidZsmIIWBvMT4kY9g
 N/iaKcVFGnFxmA6VxaCPhttIBVMZZV7rzqREQ0d9srA/tCD24TWphw+wGrIw/S7OkBmI
 +A47GGuYC3i+OXD5RmOBSRW/yQGqjo7jB++SvG+/GeRqIq7G6MlozHuvYvyvVRqZU9xR
 G5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373010; x=1790977810;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FSdoU+FSdyC2v2sCymw+VLzuXFDHBTG/nVBUdUuu2oQ=;
 b=qb1H12La8ydPQvS2Dh5T8PSX7peme0u7vNSOROYPo+CpBcuRFVoyoCq4tOvhIEAEqi
 o83G7W1lFCpDgSZ2RW0MJBBq4l89SdM821569TpkZmx+EdvlEcEBbtEmErFquY2hnyYc
 sE/jqYxN2+8fXNvVqvXBKmhA9zwU+n9iKjlvg7AjnhnaT23d99gvVQIah0Rp6JwYMufQ
 24ggtw5yxCSUSr9tM3jRDwdq8cZUBwkAdOyFKwyvHHtA0UZoJrli78U4oWd+oEH99Jws
 eVj747WaODLBeKgR2+I5NzpcSm3cjbIci2lUmcVWr/jy729LE4poLWfX5B525Ouih8dV
 nzcA==
X-Gm-Message-State: AFuF++kCvc9zkcnduu9s6iplEt+AvwOmLZk5DyixYWB7sH487vVMwsPZ
 +zwR8TaGlcIAavvJIvSTzxPf86qAHhjDP+lW2N1g6YXgkfsAK+iAL1bH5qozTStx0B8J8veqpQV
 Jm2jQ
X-Gm-Gg: AYBFou396xpRe9FatYbChyXY9B3gF2F0hblzEF9Yb0RRQH7Vj2GctgQSpjrcJZw8vPU
 Rpw+KdNNGmHmYBdompAurQI7hC+8lAcFhoR9edZSbAx04QH4p0DW2l8IYqJY3ZTP9a3/BMRYnYa
 VoFSk7KDh4waVGsrP8ELqV7SsOXGkeKKz+ZyjrO0Z3C43fGBXHpofLhE2hPTj2GxuI2kNmHi6jw
 CbvRDstokZ7X9H47JspN12+wUAgCf1p/tFTP0vaLo6mLnrVjXOmb6g3dsapCo1jUlgLivjTfu4U
 CdGogEH9hKjmyQFP11BQ/nKHayG2H0EBNN6ORJH0tcEg/fTHaeQn68feriM7ay7kGf56n23CbOK
 L+d23rB/SwVBo/y05HYYPCgTLXEMNGO00wbpL88dOt/BIvsQ3BTWzNE4snW0UikWj+O7woLpqeJ
 nqZt+u7wsj/uw8Qf+/3rGcJAHT1PBnbYm0a91Favjw02Ldm71Beb8pBiSb0emVvsY390Vq6HBof
 wSws29b0AITvHddTogckRhhvl7PAw==
X-Received: by 2002:a05:6a00:c30c:10b0:880:7dad:3e5 with SMTP id
 d2e1a72fcca58-8807dad12a7mr1413681b3a.51.1790373010436; 
 Fri, 25 Sep 2026 14:50:10 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 05/14] target/arm: Move ID_AA64PFR2 feature tests together
Date: Fri, 25 Sep 2026 14:49:55 -0700
Message-ID: <20260925215004.456336-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Currently the MTE feature tests are clustered together,
but those are spread across two ID registers.  Sort the
functions by ID reg and bitfield order, like most others.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index eecbc3b889e..06318d12f9f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1207,16 +1207,6 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
-static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
-{
-    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
-}
-
-static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
-{
-    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
-}
-
 static inline bool isar_feature_aa64_mte_mtx(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTEX) != 0;
@@ -1237,6 +1227,16 @@ static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
 }
 
+static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
+}
+
+static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
+}
+
 static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
-- 
2.53.0


