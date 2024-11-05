Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E04D1268A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hbc-0004iS-Go; Tue, 05 Nov 2024 06:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbX-0004dP-Il
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:11 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbJ-00078t-W4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:11 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso5782586e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805595; x=1731410395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+LP6S0HiqT0UnMi7xLzb+PtlWN4r3AjuiB9iv2CEHDk=;
 b=d8VbeaQ4MT9hGxedcDzrl/vAGU4hHDVtQkPT7x0ifi16jeAKYhxZdt3C+h2ppUTGy0
 gldSknjfMETiiglrsPap/js07emz7xg4ZzqC5LYguGBzKvVxrj5Gjlftf8+fZ3Q24/LM
 Lvm6DaDtEy2zxWd0rH7Dm9fAJzj6WVz+wdklSdtWiuvJ9scPmVL+3lXjouOK5zkVH/AO
 PRVoqK4JndasdHvI/iTJWXRM5ifpmsFmxnLORMhT1rc1vZ5bQSTBDVHv8qOk34koMXmW
 PjrwPu4tWHMF9H512XyPsUHA9LAoX4ZBcT67cBjne1To/k00oVJRFjl/bjG8qHsE6Ku5
 U2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805595; x=1731410395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LP6S0HiqT0UnMi7xLzb+PtlWN4r3AjuiB9iv2CEHDk=;
 b=iwKeDJ+CJttPBTfnGqGFUVOagNcFJQi5UROtLg2NB1g22VDRHYeqhJpGmmbsOOlGjF
 PEMtDfU4i9qB2Dfp86c+TR1+l7LQdrI99OfSL/tsJAX9q/ehpqIWzWG9ObWhBhlGxxNr
 M/7VrmU+nP+ngvn/DKm160zWQI6FfXF42RKeM+GRI8MLKKEIlBrMliSNpKeiRsTcp7f4
 dJGc9jjeZcg0DF1Xop68I6NC3YUhU/RBc9dr7jxFHz/WrhfXE6H8xtfpHxFxSsMxZ/hZ
 gsmXf02UBuWINEeSO4f2pK4YPSa5mebsnODDQW3MwnZ4OV99Iuwrfz8UkrLEalR300OG
 BJIg==
X-Gm-Message-State: AOJu0YzfNKkHcFsxjPtUCin/8LZWgUAzm1FLinehMx1Fq7WnXI6KY1cX
 sjT83s+OcBIQI/cZO2QnRE7wdRwrqzVeIiTmySUPHQpZtpmc/sT8YeipzXbSYN+8PAuDc8GyLG6
 C
X-Google-Smtp-Source: AGHT+IH+jt9pf6glwrjI/CSmL/UEVVRPPBvrv69vQpRcyYmmm3sZz0u52YpddYr4YWl9AC6Sm6bCfQ==
X-Received: by 2002:ac2:4e06:0:b0:52c:fd46:bf07 with SMTP id
 2adb3069b0e04-53b34a2e4d0mr15730991e87.49.1730805594825; 
 Tue, 05 Nov 2024 03:19:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/31] hw/net/npcm_gmac: Change error log to trace event
Date: Tue,  5 Nov 2024 11:19:34 +0000
Message-Id: <20241105111935.2747034-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

From: Nabih Estefan <nabihestefan@google.com>

Convert the LOG_GUEST_ERROR for the "tx descriptor is owned
by software" to a trace message. This condition is normal
when there is there is nothing to transmit, and we would
otherwise spam the logs with it in that situation.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241014184847.1594056-1-roqueh@google.com
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/npcm_gmac.c  | 5 ++---
 hw/net/trace-events | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 6fa6bece61f..685905f9e27 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -546,9 +546,8 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
 
         /* 1 = DMA Owned, 0 = Software Owned */
         if (!(tx_desc.tdes0 & TX_DESC_TDES0_OWN)) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "TX Descriptor @ 0x%x is owned by software\n",
-                          desc_addr);
+            trace_npcm_gmac_tx_desc_owner(DEVICE(gmac)->canonical_path,
+                                          desc_addr);
             gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TU;
             gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
                 NPCM_DMA_STATUS_TX_SUSPENDED_STATE);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 91a3d0c0548..d0f1d8c0fbe 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -478,6 +478,7 @@ npcm_gmac_packet_received(const char* name, uint32_t len) "%s: Reception finishe
 npcm_gmac_packet_sent(const char* name, uint16_t len) "%s: TX packet sent!, length: 0x%04" PRIX16
 npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, uint32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0: 0x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 " Descriptor 3: 0x%04" PRIX32
 npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t tdes1) "%s: Tdes0: 0x%04" PRIX32 " Tdes1: 0x%04" PRIX32
+npcm_gmac_tx_desc_owner(const char* name, uint32_t desc_addr) "%s: TX Descriptor @0x%04" PRIX32 " is owned by software"
 
 # npcm_pcs.c
 npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-- 
2.34.1


