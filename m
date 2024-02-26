Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB94C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOVM-00034G-Vy; Sun, 25 Feb 2024 19:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTO-00070A-6p; Sun, 25 Feb 2024 19:04:02 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTM-0000c9-2i; Sun, 25 Feb 2024 19:03:57 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-608d4d18887so11366027b3.0; 
 Sun, 25 Feb 2024 16:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905832; x=1709510632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inSZkkJKkHcTM8oSly5Zp46F6De0EeQmyOdwp29R52c=;
 b=dLane68jTonqeqx/PD491xM/rGjCKPs/QqZCRd3mjAfWOvhUkzgBT84w7IWTftUdoL
 muwZSYHOfxsmed2mT7dfWN7EpB7faE5CTflCsgzD5nnU8QxzP4+fshqbtjZ443fid0/b
 EF6dXz6zMJA0gHifpepyUjo4m+fhLHjkprSJZ92RuvJuGsuRE+itPeehigynGTIm7Y8i
 l5NNFl3UOKa+P3F9wlT2pjPBFVYwG27ZAr2XgW9V620ZntvWibsozLSlNlH4HttD8SfK
 IC5Ktfx/lk4L17klGv3VtgJVQSluCPuCMuVGxyUT8TlzeM+ekl5hlm64AmOuO72hqMCz
 1nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905832; x=1709510632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inSZkkJKkHcTM8oSly5Zp46F6De0EeQmyOdwp29R52c=;
 b=rhqyA+pgkV7wcMh3g+vSPz5H2/JWLyBJmhMLiXSxLYjxOY14+1w/a0qTPtJbszWQPb
 SD7TCA3ZpBiEhPQlPS9hiRLzrcXNG5afqoeimBKmTURp32QTt4tW0bc3jr30USnMIttF
 cUwmMrplmlZfSdAVXRApSE1rfuMwNXgoTrKCdRGuodLgSkdYU//BYE+1rQWhPjSVTBBc
 xUQo30ugoZ5wIWyEb76r3KEmY1LHjTUBiFp/V/FIsDSsPIyVcYnkjANOUhlpbf2Ss22v
 hwNfxrcpsPwsttTBCfhUWPueqtWSGtuEe2FGlhqGCwt44P1HOUlBG+ETGhf3/6E773tV
 zxUA==
X-Gm-Message-State: AOJu0YzpN9WkxmrFwI+KKN+/68k6Kcia3K4r12T1X07YhR9l0fXnqemi
 B8K/DyYAYUb5aTwyyPhb+ksC+W15KuuPlsu+13IPFmEjJyYudgJ7rGnHFcH/PbrANw==
X-Google-Smtp-Source: AGHT+IGdjMMlq52BEATqoxQC+INNsBncZYLRsJJUzmkTRZbj+96eiOD6UdzsBHgV6VYkb6tafP7aSQ==
X-Received: by 2002:a0d:d50c:0:b0:608:769b:ff45 with SMTP id
 x12-20020a0dd50c000000b00608769bff45mr4684661ywd.25.1708905831999; 
 Sun, 25 Feb 2024 16:03:51 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:51 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 41/41] Add RPi4B to raspi.rst
Date: Sun, 25 Feb 2024 18:02:59 -0600
Message-Id: <20240226000259.2752893-42-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index d0a6f08b2b..c21b27744e 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -1,5 +1,5 @@
-Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)
-======================================================================================
+Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``, ``raspi4b-2g``)
+======================================================================================================
 
 
 QEMU provides models of the following Raspberry Pi boards:
@@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry Pi boards:
   Cortex-A53 (4 cores), 512 MiB of RAM
 ``raspi3b``
   Cortex-A53 (4 cores), 1 GiB of RAM
-
+``raspi4b-2g``
+  Cortex-A72 (4 cores), 2 GiB of RAM
 
 Implemented devices
 -------------------
 
- * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
+ * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
  * Interrupt controller
  * DMA controller
  * Clock and reset controller (CPRMAN)
@@ -34,6 +35,8 @@ Implemented devices
  * MailBox controller (MBOX)
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
+ * PCIE Root Port (raspi4b-2g)
+ * GENET Ethernet Controller (raspi4b-2g)
 
 
 Missing devices
-- 
2.34.1


