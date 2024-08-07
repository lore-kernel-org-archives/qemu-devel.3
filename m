Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9F0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnH0-000202-0J; Wed, 07 Aug 2024 16:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGw-0001y9-Ui
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGu-0006uO-8D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so1966045e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723062514; x=1723667314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6ryEDlXxlrvMeiKVLcQCfvmoYPTROsSgs3XZya+DuI=;
 b=yWBB0tQS3x/zbLLG5yYzvkI66qaduOSxYEAG7FSlLKSlV09G4cX3dc2PiSvo281pyZ
 lcJSLxTd8VMQyrmp2p8G23X1K7NcG9UAkpxUyeWfHEtw9Fm18ozYFsBOUFJakW+MFXCv
 wVzRVb0/eAWd2BKZ0WN6Y3ci5o6splvjw/ke4K7d1AvAecf37d5Alb6QrpoTInBVxLCW
 JDagWNd74Z/meDBtFlzR6q21Mk5EjAxZqic7ILSnZix9AiQErRmu6xUhn0MrNXaYBC0B
 e+uRqO1S2/YE1nvZygHHxTHR7JJTIBamvT+qbhgSgfhs3jhMjBy+ZihcEfKzS05Nxu2h
 PKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062514; x=1723667314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i6ryEDlXxlrvMeiKVLcQCfvmoYPTROsSgs3XZya+DuI=;
 b=SxVlMoiTOdSRMA+NbEBjf4QOUOlhsCPIZeYBBkrrL407EfCeY/DDMuGWUS/lmD3ngx
 rxMv4RarkbWSi2tcUrxlmNicE5HUq7k1O1xyiDke9hpXemb2BUfNhqT9wcNffog02Crj
 UQKOcLkT+1QA3Csy6BCblZ9E9HQVhFlzz5Npwpa0Q/T9PFcyuKALNGFoxVQUIKZowbMC
 /RdDe4GmE7PCRTAjMuO/VxurMaxfpjLKfbzhGtS4D5V7ooy2ma3bASQwrxemKebO13Xg
 BkP7UZV3BbArKDBUcwiIZJ9WDAzHl+VZjlxvmdvzA0N9DfAS6yQTDoOj/EgQQcT6cphi
 m+2g==
X-Gm-Message-State: AOJu0Yy8HpwdtP7HsMdtQu1MogANMy5CU7gctK6nLF5Dgf+vU6AqGAFD
 fQ6EqIOGYbOIk2ALnzkrStOd9YDxxGdhV9sDSgtrL7l5kUHLTH606heuQNE3wSiQxD1FX9a7o82
 V
X-Google-Smtp-Source: AGHT+IE1Jd3/3I1uB09/WeI2RIs6cGzJ5SzwkPTGSv9BFq68vOR+/N7AH/sdomEHd0F5YrMMlYyGLQ==
X-Received: by 2002:a05:600c:470a:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-428e6b08a32mr142794275e9.19.1723062514246; 
 Wed, 07 Aug 2024 13:28:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290580c573sm44258595e9.39.2024.08.07.13.28.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 13:28:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 4/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
Date: Wed,  7 Aug 2024 22:28:04 +0200
Message-ID: <20240807202804.56038-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807202804.56038-1-philmd@linaro.org>
References: <20240807202804.56038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

In this commit the following coverity scan defect has been fixed
CID 1558831:  Resource leaks  (RESOURCE_LEAK)
  Variable "rsp_payload" going out of scope leaks the storage it
  points to.

Fixes: Coverity CID 1558831
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Fixes: b4cb930e40 ("hw/ssi: Extend SPI model")
[PMD: Rebased on previous commit (returning earlier)]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ssi/pnv_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 05e6afc11e..eadc36fa86 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -239,6 +239,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
         }
     }
     spi_response(s, s->N1_bits, rsp_payload);
+    pnv_spi_xfer_buffer_free(rsp_payload);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
-- 
2.45.2


