Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E07C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNTj-0004DP-A1; Mon, 14 Jul 2025 14:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSk-0004a5-8R
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSi-0001JP-6U
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so32482895e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752512130; x=1753116930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XB8LV3wRsOBPp4JPpXFjqFOjZLlAFG+bPFbYCEIwFxs=;
 b=Owg0guTatUlOe0bdf2ohgOheEFnIRITumbe3LrFvhDV3I+J/osTnc7UPuM+d0LygaA
 +w0UtvQEcBHLKytPT6jBOaLTMWnNFvF5CrvSK3GBDvBMTDJr4ACRfnDDbbAg/D5XyUcd
 G6B6k6IuWTho7S/lQO38gill8lNxmIT/W1rLe6rmMqRiBwPYFxo//FtPMSm0xFZkl2T3
 Ajm9xIjXDqNsq6IdYHhK/UQsIOhthKBs2I5H12P+FWDxMaGbI0Tzr9a0Z5FacKDxM6QG
 BSrv7MQf3m+1V0tDVXvlp5QsgKiYI/58Sl5d6xQSiav/XYmc1pbGYoQvEgND5A2AG0Gn
 T3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752512130; x=1753116930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XB8LV3wRsOBPp4JPpXFjqFOjZLlAFG+bPFbYCEIwFxs=;
 b=YcsN6FU5xKP5imgGSPPjoz3Yu/V/e1qtCsRPE3O7htGcxE6dYMmdFaHk98uaXky85S
 P8kX87AHZcdEU+ABYKmGofsYTv6CmKxxIn7eczvznWXwoEWvSW3pej4Kquxayk+7ZptH
 NUXBknRotZkKxGPoT93oi197N9f1xSNxrmQv3IIRkLKetDpiPd2W59MrBzVj02oAL/Nt
 ZqqujV9BPfvouRmWfMDT5k3kkhXz43QEVtkQ7iQlQEAL0aTtvnMPZhPPzL+OJISi1/OO
 5VKJMxBAPi6101eG5HFrFbVPvjpVm/50Geqr1un7Q9PEAOB6CnDzxJae1skcUnZ7ItO5
 uLjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW3qHxJLtrtuv08buaHV3S91rqbx1iq/Z88dPFtprg2Yzzf+6MTQyn6u95NbGuTloD7WmHLTdqdFC1@nongnu.org
X-Gm-Message-State: AOJu0YyRpgeac2Jy2INkOVOJOgmYoDgUJEykomHuNYRFzfSjdUauLw7E
 hHLN7mTzgBU/l229rpgbNL8a05aeP4xsR+5rphRwnS4nu28wYxmVNtS4Bp81Ve2/hapIp+2BWOj
 dJ18N
X-Gm-Gg: ASbGnctlwRyE6yJ8yz+Gwj4FA6v1v8uNHkb7QUr7OnwNOj+xq3YYadr437O2QQhENng
 qIgyhoV3FZAhkrcm72yE65nNAPVjXSE0XjAkxSHlSNnwvfn6vwZ6kcA7hI27ogIjvooDNa8qKTw
 vbJ9QyrofmzFRsY5H8S4f+3EBI9eX1iftYR6yw664q1Kg4uxyyvOtzuw94DAz03+BNtxMSeCi4P
 8/ntM1DlgsD+j6ws1DEj8e4zgUMU2s7WdCfiRHVldLVenR9yFsCqdTDh9lLi3nKSuXH58P5QgDE
 //JwzVc9tD9Su/w9TsRWT2lXX1az1RfgGLRDRVy5VfdOR0Par7Pkh+nyXXa8+F0Hi+F/Uyy4Etn
 XKRYlqgDKzqpcBwEFpgn6/VUhxDyT
X-Google-Smtp-Source: AGHT+IH+/REJ7B+DItU8aASH5jnaoFcfOBxm3LgKHunU9aheiEThUjx2kOxgBM45dgVhV+9NQZKjCg==
X-Received: by 2002:a05:6000:1882:b0:3a3:6595:9209 with SMTP id
 ffacd0b85a97d-3b5f2dfdfdfmr11245919f8f.36.1752512130542; 
 Mon, 14 Jul 2025 09:55:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd15bfsm13164665f8f.19.2025.07.14.09.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:55:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 4/4] hw/net/npcm_gmac.c: Drop 'buf' local variable
Date: Mon, 14 Jul 2025 17:55:23 +0100
Message-ID: <20250714165523.1956235-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714165523.1956235-1-peter.maydell@linaro.org>
References: <20250714165523.1956235-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

We use the local variable 'buf' only when we call dma_memory_read(),
and it is always set to &tx_send_buffer[prev_buf_size] immediately
before both of those calls.  So remove the variable and pass
tx_send_buffer + prev_buf_size to dma_memory_read().

This fixes in passing a place where we set buf = tx_send_buffer
but never used that value because we always updated buf to
something else later before using it.

Coverity: CID 1534027
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/npcm_gmac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 0c17ae9b2a9..5e32cd3edf3 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -516,7 +516,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
     uint32_t desc_addr;
     struct NPCMGMACTxDesc tx_desc;
     uint32_t tx_buf_addr, tx_buf_len;
-    uint8_t *buf = tx_send_buffer;
     uint32_t prev_buf_size = 0;
     int csum = 0;
 
@@ -567,16 +566,15 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
         tx_buf_addr = tx_desc.tdes2;
         gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
         tx_buf_len = TX_DESC_TDES1_BFFR1_SZ_MASK(tx_desc.tdes1);
-        buf = &tx_send_buffer[prev_buf_size];
 
         if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
             tx_buffer_size = prev_buf_size + tx_buf_len;
             tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
-            buf = &tx_send_buffer[prev_buf_size];
         }
 
         /* step 5 */
-        if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
+        if (dma_memory_read(&address_space_memory, tx_buf_addr,
+                            tx_send_buffer + prev_buf_size,
                             tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read packet @ 0x%x\n",
                         __func__, tx_buf_addr);
@@ -589,15 +587,14 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             tx_buf_addr = tx_desc.tdes3;
             gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
             tx_buf_len = TX_DESC_TDES1_BFFR2_SZ_MASK(tx_desc.tdes1);
-            buf = &tx_send_buffer[prev_buf_size];
 
             if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
                 tx_buffer_size = prev_buf_size + tx_buf_len;
                 tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
-                buf = &tx_send_buffer[prev_buf_size];
             }
 
-            if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
+            if (dma_memory_read(&address_space_memory, tx_buf_addr,
+                                tx_send_buffer + prev_buf_size,
                                 tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "%s: Failed to read packet @ 0x%x\n",
@@ -615,7 +612,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             net_checksum_calculate(tx_send_buffer, length, csum);
             qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
-            buf = tx_send_buffer;
             prev_buf_size = 0;
         }
 
-- 
2.43.0


