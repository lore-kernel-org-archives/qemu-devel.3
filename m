Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A3AEA8548
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 20:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzKqa-0007Fn-Gu; Sun, 08 Mar 2026 16:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vzKqY-0007E3-SK
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 16:35:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vzKqX-00044c-CL
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 16:35:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso1314489f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773002127; x=1773606927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBkN0OXRGFMvrV2S5QZAiH2Wv1UWYT7/qi+m9sCjHKk=;
 b=CNcGv54lNxDSE3yue3N8ztXgTI5tmdLJLt8CbOQcipY8ChC4K4G9XnVz6qVLAFxZ5T
 FAJw7eziMcQ8Q1PQkebRtEEfj50pEtTnnhmKhX5FWxVPd+NEMvXRXMOpfnjkX6BtihwD
 NKT1n/vjaOiZCApN7OwfN+6Qd40nTGWVImXYUJaPMcWWPP8FARljh5L3mP4MUPAyy4rs
 MwHL3LXigJ3RV5jUaNp3KdGZd++RgJz4L++r9TA2fLVvfupJg0FQZDUpiH/JxC4EUhRD
 qSodm+FnnaWh2zr/FFmO43G9tf6uEVjYuBqoEClT0RmsqDQWTLxPqWiadTn47mWpJTXM
 0ktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773002127; x=1773606927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBkN0OXRGFMvrV2S5QZAiH2Wv1UWYT7/qi+m9sCjHKk=;
 b=GkUiTVeamSOaQTQYE4nQ/YlAQYG2zk2tsOIvcCQO1WfKVRm81fwqeueXMbDqeBhRKX
 jFimPL02v2XqLpcwxFQO964nKOPLfPe1Y1I5OSOKlpnAjwwTEEcAgHXpSX+xLc3qNFO/
 rMoyex/aXlLp6IKyVZe08OsITGY6oJMCv4ZXNtTTujs3UXV6UxqyMj38MLcdFiPhrtr3
 /9bvzPyzHnAkaeKfd5P7pql2D+HO1SKAf9hkQ7QJ41JVnTXur6/3DV1woX7L5pC/nFSA
 Ygur3dReX8Q6VcVxP3QKlnttlujgD6mUZqzcWP/F2WAtu56De6d1Rk9UH36y7+a8OK2r
 rQcg==
X-Gm-Message-State: AOJu0Yxfwn5R1NTg/SFEgYYEKwtE3IJ+iuxtOJJ83jKMpP+sAPuYUEqv
 ywQkHBxMA1Dfd/3q/mM834eav4Sy6bAxH0GhZ51Ix9QJGrWs7uhKBNCPPwPrIQ==
X-Gm-Gg: ATEYQzzfQyY44kOMuev2c8zexVkSbp92VdPGQnICoj0xXa162cF1zMOAVI9cfUSrzGi
 2au15nUlHfUkjMAW0VIN+GlQSZuQABCUamSx+usRyZf4lu4U3kmZvPqcIHwk0GFJYhxDNdKb9FI
 lTErmsbHKITFpacO6bQuaxJx0IxV48TFKu+lrBoYJ4WHGyXUiUaKkW+njTTNZ9U5P2CQmvWHs3x
 Fz+K5xj10ZeNuHqTMK66FgPi+2L8tIEzRX3AD8m3bSz3cbgZptHysMDyVVeU0c5AFLu9adDqK1w
 cgZ5Y+93+4gx5bwKBJPQMgA5KWDTewJT4ZrRN5fGwsbkATGkyknIU4MAx7mWOaD0cpfkLlQW+pG
 gEyIsOzPb1yY/2I3oGMpbl9suou2YCRdu/TsATXlhgmM04dcduLSxmMMsrrU9K7+QRR7JrJM6/a
 kmUM/cK09c2AfQgg7JHDnsQzVqblB1XCnZEyIBpDtjEo04gaeIahz9swLHBT7B9Jb3KXBsbbo1f
 GDDK5A68TlMQX5C7UYvb0tVDOzAi53/8OvfFIVL0w==
X-Received: by 2002:a5d:5d06:0:b0:439:b886:20d3 with SMTP id
 ffacd0b85a97d-439da35f64dmr16113282f8f.15.1773002127220; 
 Sun, 08 Mar 2026 13:35:27 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-25c6-8f00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:25c6:8f00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2bdf8sm20995508f8f.25.2026.03.08.13.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 13:35:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 2/5] hw/arm/fsl-imx8mp: Fix parent of ocram memory region
Date: Sun,  8 Mar 2026 21:35:13 +0100
Message-ID: <20260308203516.160103-3-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308203516.160103-1-shentey@gmail.com>
References: <20260308203516.160103-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rather than having a NULL parent, let the containing SoC object be the
parent. This cleans up the QOM composition tree a bit.

Fixes: 1aaf3478684f ("hw/arm/fsl-imx8mp: Add on-chip RAM")
cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 0119a18416..839c925e4a 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -671,7 +671,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
     /* On-Chip RAM */
-    if (!memory_region_init_ram(&s->ocram, NULL, "imx8mp.ocram",
+    if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram",
                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
                                 errp)) {
         return;
-- 
2.53.0


