Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DB7C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexb4-0001AS-LY; Tue, 27 Feb 2024 08:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexae-0000r0-IB
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:49 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaW-0002xt-Sv
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:48 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d288bac3caso27993981fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040819; x=1709645619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P4hkNztqDNRnaj+KFHGOI40tyfjypqPbuVEH2aEu/ZE=;
 b=aDH/Cv7YDomn/mjERrsncVZ0o53RbnyAog096DYWI1ROzohllKa9W0sjV65d5YC4rt
 Tg2I7lReUR9HyVokNemRqYzwunrGkr5ILFvsqmmDhDzCQHtAx5h3NWDVB6NKECZnJvfg
 ahji41lc6JdlW2nMAyar1cu8wHxQTmJUwG2RobdseVIREd4IvK43CXrx7eKdMsXtt6sa
 oa1ThrBKy8idr3bhXpK/cVv4NB52MdPtVonaFhXCMrq9ztCq6J6ENEPxcU0mspQXfwQr
 uerylaHEeO4XxUgEKFi8p9aIN40xB5wEZb/bVF9YGXUozbQ5ALZhqnIF2eSIRl749bAI
 m4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040819; x=1709645619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4hkNztqDNRnaj+KFHGOI40tyfjypqPbuVEH2aEu/ZE=;
 b=tXv9nV9IVg+3Xb6cwixwR0Qb1JHYDMEjZu2CoikEAO2JLUJyPt8crfnF7BAg3g4uSY
 GKggRUgibyyY4E5u3o92u2MJwkp+DLvyfV3ni15cwpxJEvQSQf9tE+mIrAZCHHBuJ7jM
 boI5LLwTFtJyEb97mwfr4hS6eurTekhiFzpeXzUJ8xVsvgQYzEWUmYOHoJKtawtQZO03
 us5yDYscHrY9qCvSqU0E8C2EqbhGfOJPhfPVi8wsPHjZ0X5NSTIlv+a54l2dfifuLptt
 QOH6Ai8cQq/INjMiHI1CbhtuoykXhjeU7+rgDcyX/5O4Zsh3Lwdh6hGyv0njCuhy3Q7O
 A0PA==
X-Gm-Message-State: AOJu0YxWBh9uBYrsA99ZcFe60OCMSD4f1dQ1fgvYJmwNjqfCNAQutK8O
 t+DytNbNMy1DuJz/Gh8whmcRhCrbAtJXF+K29CGtTjCw5lMIlOIHHNH1rDl8pWslq0hMqt6wB+E
 W
X-Google-Smtp-Source: AGHT+IH2aeuzCh7MERJeH2RyIdLtxblTvgOkXiUL3pWlEUS2YCjaqKiqpyDzQmzeJ2TuuZs8iA26kQ==
X-Received: by 2002:a2e:be89:0:b0:2d2:5430:605a with SMTP id
 a9-20020a2ebe89000000b002d25430605amr7860482ljr.7.1709040819205; 
 Tue, 27 Feb 2024 05:33:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/45] docs/system/arm: Add RPi4B to raspi.rst
Date: Tue, 27 Feb 2024 13:33:14 +0000
Message-Id: <20240227133314.1721857-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240226000259.2752893-42-sergey.kambalin@auriga.com
[PMM: list PCIE and GENET as 'missing' for now, until we land
 the patches which add those devices]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index d0a6f08b2b9..bb417c34241 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -1,5 +1,5 @@
-Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)
-======================================================================================
+Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``, ``raspi4b``)
+===================================================================================================
 
 
 QEMU provides models of the following Raspberry Pi boards:
@@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry Pi boards:
   Cortex-A53 (4 cores), 512 MiB of RAM
 ``raspi3b``
   Cortex-A53 (4 cores), 1 GiB of RAM
-
+``raspi4b``
+  Cortex-A72 (4 cores), 2 GiB of RAM
 
 Implemented devices
 -------------------
 
- * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
+ * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
  * Interrupt controller
  * DMA controller
  * Clock and reset controller (CPRMAN)
@@ -35,9 +36,10 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
 
-
 Missing devices
 ---------------
 
  * Analog to Digital Converter (ADC)
  * Pulse Width Modulation (PWM)
+ * PCIE Root Port (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
-- 
2.34.1


