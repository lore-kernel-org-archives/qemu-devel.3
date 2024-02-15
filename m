Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3F4C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafex-0000fl-W5; Thu, 15 Feb 2024 12:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeR-000851-2U
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:00 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeC-0003ut-Br
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:58 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so1265659f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018542; x=1708623342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nwxkhpG8dtYdQVg6oQayFhjJNiCTSEIeqskFAgqh8XM=;
 b=ZeKWKg4q6dfdLcjdc50DNyMn0aQ9INFKNa15YgJiB8skTo8XsdT0Ld+kwDcygNyoMO
 oVfXBoaYsh/fgL+jgoJXA1eNuQgQLeFCaFmHdI7q1CFvLIu4S1IFU1m0dZcYHXXVXDCw
 Df/P6Xw/zYqEKxAQD5G4m/dZFKQsjh2KjMDNA1roVFBSR/5Wv4QAqIlENy+nmpXXb+1g
 TdlPf8VXpdMEkePTLh4baf2AE61Z24HN6BdeG2+eDngVcetcOCnZjyVCkj/o4MLTWgKP
 RHvE+cVOd1pplXa/pEAtG0Xq947bnk3n7rSeX8QDBb1q8/D7yA2B00+XA3zIoKr/fz3m
 Jvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018542; x=1708623342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwxkhpG8dtYdQVg6oQayFhjJNiCTSEIeqskFAgqh8XM=;
 b=uhv8V741iv9u1PofQqHbFIEQo1Z8MLgs8HN6juZatfoSpIky+rHQlH0KmIi30xGO2b
 GVa54DeUZhUCfo2+zGfU+scEB26zoDOBRJt+bSbXzqWbaSYoro/TUCHCd3ja5q4EDihZ
 f5/0Nra4QMqNtvPpMTzEQFx7d/ioR6K6AlK9ewhSj+mbTrxfwsY6MtYln8ZVBuh71Ls3
 91bHUB9grYZ6EcxeVXGWoBs8rMVKTlUC9oqt9xbkEdv/chc7Pf6QOGlvz/334wUJdzKk
 IqgSBc2beFqNxCr/Oi3MBUvo0WTkLJB7Hcfcn2ADFIC8oX/NSaKeVZd2E06ph1h3Nw+E
 Lekg==
X-Gm-Message-State: AOJu0Yxo5yRCWZJXCFQWZ6S1iZuZTCCnZnrTlliPrA2yeNNcVSdMpn9s
 D3CZMm+XEbZKLvtP0+O6Opa6jkAfEsdxCxVlXpSN9D2pxwQ0V8zyuOXq38EjW+rVfA69dN8OxKr
 Q
X-Google-Smtp-Source: AGHT+IEyZZ3SAx7V3z7ENaq4PyKxB0xp5PMTM23ISIgE/T94fzhCCgJ7k2bCt7kHawBBAkNvgXALhg==
X-Received: by 2002:a5d:40c8:0:b0:33c:ef57:ef02 with SMTP id
 b8-20020a5d40c8000000b0033cef57ef02mr5104304wrq.17.1708018542798; 
 Thu, 15 Feb 2024 09:35:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/35] target/arm: Fix SVE/SME gross MTE suppression checks
Date: Thu, 15 Feb 2024 17:35:10 +0000
Message-Id: <20240215173538.2430599-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The TBI and TCMA bits are located within mtedesc, not desc.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c |  8 ++++----
 target/arm/tcg/sve_helper.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1ee2690ceb5..904bfdac43e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -573,8 +573,8 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -750,8 +750,8 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bce4295d28b..6853f58c194 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5800,8 +5800,8 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6156,8 +6156,8 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6410,8 +6410,8 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
-- 
2.34.1


