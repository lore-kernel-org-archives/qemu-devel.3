Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A328CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OT-0000Ob-23; Thu, 07 May 2026 19:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OP-0000Kq-ED
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:33 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8ON-000149-LR
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:32 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dea20cf21aso1347463a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197470; x=1778802270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WK8IU7LFshBJy1B3/luWeWQwxfypwBRVNYAwu+A8Dw=;
 b=Na6CmFJHKaKo+P1cdFYcGz3VHuFwjmxzYU0OAKe2s9f0OuT+s1KQ+coF5qy6fUpuNP
 eL9oVVYtlANPIeDFT8xOp6G4YJyBnzbHBwJVUw1K88p6FOTC2x4ahzL/CWmUN8MG68RA
 nhQZ/KIW13ALqc+7eanQY3aDALi5CitZqjZJhbdBHPFDK0OMGekEIwKvge6OMZhn32v3
 aFnhnblBsNmvfs1S03fVQDy+Sjnx1QHUx6fb7FpPYcs5r4aCXyOlst5tY6bHJMENmAIr
 W/RBa7ScZPyFlyb2909eJgzWb5DiLuTzLiXilXBc7c7rmrOQzGancqKQGzzdhDoB0dPH
 oDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197470; x=1778802270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9WK8IU7LFshBJy1B3/luWeWQwxfypwBRVNYAwu+A8Dw=;
 b=C5CsNoxyr2PcBABei5XQ7Ljq7ZvrTICL0QTHU8PbLVeHGHM19REroyO911ORpf75VF
 if3gD+wYYHPFsdUOra2Zfl9kDGhy1JIRE3Hc/lbxToAdQpSE0ieH9FfHBGQ37UQ+Aqw7
 u2ED8rsQ04PMJ+gMIIWeUrnqyghWUGo38sMmz6ttsuoHUQkb16+NxFivOl3y2QBrvPNW
 Gxzl3BBJIr4UhEVDnTiYigyGYshS4mq8iaJUPxVbDHTMPuVrEkzvBgLfZJ4jF7ijSisD
 ud+ecOrBORM2jk3MGgdzwMRmU/tEMCfdwITn0zgb/RAzkn9ViIP0EMKFN/ZCskenacAD
 s10g==
X-Gm-Message-State: AOJu0YzfXWeuTsU9WAOnBX2jC0yEOynNTZjQzn+8QTa/cASHZrzX3hTL
 C9MdIfkR37d13rF6r2qzHlrw7BStwNX4097Er4jgJkn+tGTNsYZJMsgRh3j7UC973eoK6yPTA6B
 LLaUc
X-Gm-Gg: AeBDieuMToKWStXHw7QioE+5npFI0+c7+bMDYEEuXIz3VPwv71oqMpeXLFZ4CP+s1Gy
 ez40uLN0B3cjYYYP4VlOktUbKSvwWSgLTrJjtCu47PtkVscu8UDtgSTyYUOtOhigIAumSkaUPNr
 PQ4A2rh5QbNaCRGIUdxzPFWludDwdYMsfpTmrD0YAQpuI6s47vxqFEgMgVjTQVsDFtVfb1OirJM
 r6QucOLZdU22w9mutOepk95gZUCeoDolRnv6bL8u6Lu/n9yfVM45jhICuVMDH3eqa1C544HXbrp
 oRyH5qtmCMFcGz6wqVU9s73oLnMRT4diWrX5GHKznb9ZF7QtKxnzX5s0azg81+JkagwDwtmQsWZ
 BkmbKGAjStgmhZXduJ9UAwmxwdK0Q78zg4BkgCisLC6HXtZehCVMh4DplFRlWRQD2BOkIwNWQYo
 iCMxRJXihnMbTzZUaXs1qY0udP7KGzjLBBs+cvGp0u4Pnxr/+0dA3XsoqH
X-Received: by 2002:a05:6830:4488:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7e1df0d22d9mr6473160a34.17.1778197470543; 
 Thu, 07 May 2026 16:44:30 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 17/60] target/arm: Add isar_feature_aa64_f8cvt
Date: Thu,  7 May 2026 18:43:30 -0500
Message-ID: <20260507234413.643512-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4ba263b225..3758bd19c2 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1563,6 +1563,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
-- 
2.43.0


