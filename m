Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968D8C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkCl-0003xd-61; Sun, 27 Sep 2026 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCi-0003tN-Ee
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:25:48 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCg-0004f0-Oz
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:25:48 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso888223a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790497545; x=1791102345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BGfWgZV1+ycIeA/kl0t6gd/B6Sa2mtBnzFGKgGsUbOc=;
 b=BA58LRzP1oCZH9fIXm6ZVB1tKl5EZMG5Tig25QTDGV6/llBx5h27lI+eyreK/cY+Xz
 n5jEILMg4hDBT3uU2qrzimxvl4FBzkLL0Hiexs2zbGkNeYntyU3FrYBoY80ZP483AOOO
 USXESZR7NMGBLsygyJPfXIkcAvciaZxLmZBZXs9vB/BVcWp0XcSifsm98ulTHD7lSoEI
 oGpVdcBEW3MhyUuBGFYpnxiTd62E8jtSaTo6k5csyKqlhIgurA8soxmsDNYB/lYOk8ka
 q1CzjHpAiyxnsjc+MvISCVZl5OJllI6WsUE8DCyDA7MTyiAzTYeZJ/OCpwaJLuTJakjx
 DkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497545; x=1791102345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BGfWgZV1+ycIeA/kl0t6gd/B6Sa2mtBnzFGKgGsUbOc=;
 b=HMX/zMLqRCv2GLzk8hfZabgSPBQtnzPblsPiK3JwFSCGQkGlOkmREbZeDpYXVltPfR
 IJk4ycL5Xi1TYhRYlbNUkqvbuu2ZkmwyfeBThrY1+BDQzSyfg5HL8ceLfsn9iVlWtGNQ
 nORLA5/r0foobY2zX2rxHSiG1VKUrF0ZY6FpFqfOuIf0xLmU/gXLdZqTysM6LhZQiJfY
 Yo6IlDNU3HfBenouENQ+Yh/oCtcKuR7TVgZWCcE8BERVKsqrjT1sUhTpYBXvIpq9xLXL
 GBYVfa7StFf40PhVuInT7Mz75vOWFzlEyImyD6OHN4ZpgyrtV7N+PIv4b3JBvnIEp/MA
 GLEQ==
X-Gm-Message-State: AFq9FYL97P4lGkAjR5LVuXmejb5NrN2JhKJ6/UZd/+OKaErwkOr3H1ji
 QWdYM4TrsP9lZGhNVPkVDBLjTMIPP58qxG50R//M6W6pjdUPPGPWTNwOnpSkIC9BGO86eu9TDKz
 NcT9o4JwLXAOg2cHFBapuzVubOO3X+3G/FhSHziL8R8RBwCqlNT20CzYxpYWX4MbtjwVdaILkE+
 JprMvkiEDx69B4u1lFkId/BNQWFllqzeafsWlwdYWwTw==
X-Gm-Gg: AYBFou30ppTuXxcJv59+Dxhh+cZDGVtzZrIZl3FrtjTIHA71IihtTaJ//MuhXKK1biz
 4XAiTTQadWv/Vci/D8TgyKCNsQeRcTilU4HrrjAKGZCxOltOzy/x9OnjZTPDaV3RHAOGWg6LfzL
 orf2z6PGKh9Tehe6TRS00OHAbCsnElp2XCosMcTTDG1MEuVUTC/zE1jpeZa9+TEBRT7nCZEQBVm
 AaxuT2Iv1m33ucbCIVNy8a0RuQ9x2VQR7sRHUjdfuY2IV/WHfQke7p3GcPLy/D/f+7hs61msbt5
 WFkD5fVIYvLhiTkxxUlC4rYvcWEoiAzt7wQUzpG2L/ZTN8KHLohJha9I6V2GpLHqA8+BRSC7/qk
 dm7iga7R2o0QK12RW3ig1y1fb/QuqPj5vXQMZfxWPtlDSXqwqn3JEhemqiI3R0qoZ/XaE8ZgNSK
 drIyVI1QA5DNVps3FDhLN7s9RybwOsIEbkKsLFROrrPNBaZ9eaDTAHgeSfCovp+Cea+Kbg8jQ+D
 jKN8PT0ah544tEr6zoyNVQbA0bXylTD0acq35uxeHvUb37u8gM8lYyMVrqAx27JlB1WDQJo8Q==
X-Received: by 2002:a17:90b:4c4f:b0:3a0:bf0a:c9da with SMTP id
 98e67ed59e1d1-3a0bf0ad1cbmr6106502a91.47.1790497545113; 
 Sun, 27 Sep 2026 01:25:45 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9357f64sm14498871a91.3.2026.09.27.01.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:25:44 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 2/6] target/riscv/cpu: List one implied-ext rule per line
Date: Sun, 27 Sep 2026 16:25:30 +0800
Message-ID: <20260927082534.3228237-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927082534.3228237-1-max.chou@sifive.com>
References: <20260927082534.3228237-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Every entry added to riscv_multi_ext_implied_rules currently has to
reflow whatever line it lands on, since entries are packed several
per line. List one rule per line instead so future additions are a
pure append.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 58 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 55833896bef..90fa1d714c7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2913,20 +2913,50 @@ RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
-    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
-    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
-    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
-    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
-    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
-    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
-    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
-    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
-    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
+    &ZCB_IMPLIED,
+    &ZCD_IMPLIED,
+    &ZCE_IMPLIED,
+    &ZCF_IMPLIED,
+    &ZCMP_IMPLIED,
+    &ZCMT_IMPLIED,
+    &ZDINX_IMPLIED,
+    &ZFA_IMPLIED,
+    &ZFBFMIN_IMPLIED,
+    &ZFH_IMPLIED,
+    &ZFHMIN_IMPLIED,
+    &ZFINX_IMPLIED,
+    &ZHINX_IMPLIED,
+    &ZHINXMIN_IMPLIED,
+    &ZICNTR_IMPLIED,
+    &ZIHPM_IMPLIED,
+    &ZK_IMPLIED,
+    &ZKN_IMPLIED,
+    &ZKS_IMPLIED,
+    &ZVBB_IMPLIED,
+    &ZVE32F_IMPLIED,
+    &ZVE32X_IMPLIED,
+    &ZVE64D_IMPLIED,
+    &ZVE64F_IMPLIED,
+    &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED,
+    &ZVFBFMIN_IMPLIED,
+    &ZVFBFWMA_IMPLIED,
+    &ZVFH_IMPLIED,
+    &ZVFHMIN_IMPLIED,
+    &ZVKN_IMPLIED,
+    &ZVKNC_IMPLIED,
+    &ZVKNG_IMPLIED,
+    &ZVKNHB_IMPLIED,
+    &ZVKS_IMPLIED,
+    &ZVKSC_IMPLIED,
+    &ZVKSG_IMPLIED,
+    &SHA_IMPLIED,
+    &SSCFG_IMPLIED,
+    &SUPM_IMPLIED,
+    &SSPM_IMPLIED,
+    &SMCTR_IMPLIED,
+    &SSCTR_IMPLIED,
+    &SSSTATEEN_IMPLIED,
     NULL
 };
 
-- 
2.43.0


