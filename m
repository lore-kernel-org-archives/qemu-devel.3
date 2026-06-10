Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8895CCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXz-0000Gp-DZ; Wed, 10 Jun 2026 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXf-0007xn-IT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXd-0005Xe-Og
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so5279923f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107952; x=1781712752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=emZi/jwxDyfSmnVHZEDPcSupdD6XjFSln0KsNJdhnnU=;
 b=OR5ns8/DBK2lX3MsStubQtfVyi+fnGPRvGUu9lkq3/PyO1DYMy1TrMg2Bo8jVq3FzP
 /1sjM4pP0XSzPl7Xi2bZXLOHQVfms37OZxlTqkXXCfXXbiYJsneAFApIlWcVIMBmbvQZ
 PvRotAj0LSdW34GQQLTnuloYCklZD4PWrErhVhjd+JTJziYIt3DeGl4FPsBQIaODZ2+1
 OY0Tgsj2m+DdMoqEe4tZiMpia/2TxKkLc38iQGPcAEBcjOqylhRCtVUiXHvz44VPDbhA
 5/Zx7rmpwitptCLsaPZbmcj3e6b3xN7+VJBz5VDHmG+uHMi2aByWpRGjzzjjyqLqP1Yb
 lgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107952; x=1781712752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=emZi/jwxDyfSmnVHZEDPcSupdD6XjFSln0KsNJdhnnU=;
 b=KAMyusvHJOgZse2SW95vj1HD6Zt1/gUiIjqcAHyYkqXADtDu6QNPmXLcuzY4GZqLj1
 D4w3bU/+ukJ71tmg/V3bvdAgovViQ6vlcMxCyKRp5WtUHBnSQpBmkojNxrPF80QtVU2Y
 XG12oibYUifqck3sADZ13NuRp70JL9OfKJuWzqnsMEkuCySk1O2XfQqIAaI4oKbsWEFw
 9I3b5k+MKoS03jjOyZnnO9fD/lttZ85K/nLQVGbOKfa0MNFv0waHF2K4re4NqBAKdEmD
 YtQX7CSZmrgTFaM+25ToSqpO8s0Zbsk/4Xoa+aS1UD9NqMih+wKuCZEy+uArmCpwyslk
 Y+MA==
X-Gm-Message-State: AOJu0Yxzbgjob5+dcNzQU/EcbWPrST52cIfaPKUgcRG/EY1WkrOgtmhO
 7aIw7xApI1QJ9Sp2YwQ+2I8fNR/8LGE90YFcVwBoFYfG0jg6rT5dXhDVwK0quDcH64LuFi5kRCB
 JiMnY
X-Gm-Gg: Acq92OFnSCjpSLkJO4u7+rN87S2c8Wzn3RhS8G27mer3T4BxcyIgKuQCzcSzzCw6Twb
 XwCUi34PKpJJSMIjy7pl2r6u/N5hfU97kob8D441l/BZlSdUzz2gACuksgUTemMAuVmPVyZNZkC
 w2Ham0dbFhVqAldkuHfoYsjFWU07w0OyqwrIVqWSRrraYZBffzAerZGHkpqImgX09WRMyOYG2dh
 P0dZ7LX5wjGBhdIzpncNQzqATlJS9jmA7nfs6KkLWEjHv4kBr/QzWcv+lY7KOffaFyIUw0tVcuo
 7K284sQHBrIoWzkqT1AHaZzUMfEM4GHm9TL12f70kLIxwu/UCi1OcqlFJMyqiNGuGUwB2MIglvm
 H1NCStrDqZrHkiG3aPdn0TcmNSsQfM1vKAZcXJA8CjjjoLyKQD5FZ1NO84QbNs9vyjF313USltn
 JJj87l4n/b/KrcFmoOVGw+Qyf9vcegGiSd/IlZqIAMB1zIsOFEhDdnCqKWq8Q9Ru97yQXHZ/uye
 dDSoLDFZ/M0H+GZWAFKC4F7bQGsbKvpWjD97ygje+Y=
X-Received: by 2002:adf:fa89:0:b0:453:e3a1:6580 with SMTP id
 ffacd0b85a97d-46030501f74mr27229916f8f.25.1781107952133; 
 Wed, 10 Jun 2026 09:12:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/71] target/arm: redefine event stream fields
Date: Wed, 10 Jun 2026 17:11:12 +0100
Message-ID: <20260610161202.2235298-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260529082948.363931-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c    |  8 ++++----
 target/arm/internals.h | 11 +++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c9536d2d10..22e71a2804 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1772,9 +1772,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1789,7 +1789,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index b2035b9417..f7a57d3ea7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -272,14 +272,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -289,7 +292,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
-- 
2.43.0


