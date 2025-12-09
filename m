Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8193FD3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT09o-0003co-JI; Tue, 09 Dec 2025 11:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09g-0003af-K2
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:37 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09e-0003r1-68
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:35 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7b9215e55e6so3855956b3a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765296092; x=1765900892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24RF9wvhFdUE+qmDFLRrtImu/p8et45RGyRPMY+AKcU=;
 b=eYOJDW8KkePyf4VMmMgFRkQ3Pw5gs0rqhIEWjWkFKI1VSXatH5xK6n6GH/mVHF8Czz
 ZRhcU05TU9Jj0UYnOffC/0ycxsF9PkvLxrQLK//Fack9b9HZYLPWejPsEGALXoAqLm6D
 Bglu0ceNOC0mRLPDRbVdLBQkQapNBvLLQNHrJZiV9CQs7JWVbj25URRlDRqblEj3TW9D
 8DNTM8Uz3EeDf/HYFimX0XpPempla0SUhWbVpRZjWKFVu8XZitSl+hI5nVC0BGaOBtvs
 4nHh/oA1Do4qeDb8uPXrVlIkv86wJwi/RsZeHJOYGya8k7RzhoszJ4fC4VhePV6k61Bd
 v7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765296092; x=1765900892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24RF9wvhFdUE+qmDFLRrtImu/p8et45RGyRPMY+AKcU=;
 b=TE+uixJyCpGGg8pCa4/jJXgflQnpwVD6GVu8m0Le0evLQ3FRD2JydJ3kJoDr/rBNG9
 Nx0xHI5PjPwh+uq9bhwm9T3lJH7UtGoOvuDBbdXECxowd5gxuUy8Hp/y6lr0EYP5Qrxz
 kXH5k7L3xZoVb6xykmJPYYfv7rVcGmd//sAz8XAo/vq3GcbdqLZweCpoJLIKt83Lfcnp
 PiFLc9CenQ/IcleiqaTtZXqQmyRYo2krphpXX+I+cjOnFmCSB2Y6ruzMq3+MRcgL+TKG
 C8e1B5HI3B2sgUuJ1nswv+CIp0bOYLLy4zF1qdEriyLfq+IGzRN/LFDlOMoyXJmXRDIn
 RYZw==
X-Gm-Message-State: AOJu0YxcpkK64uKjyRCr+uZD4x3mUS8CjInus2PybTySy/qsG/+LXoTj
 MCfkHqYbOc9WdkifuRHG2uxqaRZOgQBoXakBb9v5MZHMinMoPfntfSAoUErAEVKpJRISQXd/cjv
 ZPPlK9kQYwoUtmW6cpVrwTCkk0Ds/NXtLHw6kAwgOwNpIgixuvSGBfXpUiCxV8QzAsI6Xb6g8ma
 tRyEiptQv8ZFgeKmMTiO5kM2CqEphtU+5WCadrI6ck/yg=
X-Gm-Gg: ASbGncuYmWXZscwQhPWHlk5S43MnHLhpMnvL4woAdGKsYvTuwWiBOchPE/jhOwKnW6N
 F9dlQIrh7s06iNr9LX1s+ksws5AZdb6iwMOgNGAFR4ePvJ0U1pJvFH/pmTwpu02qqXKSfX9TiEG
 /CyAYAvmWqEckQ++z1VeCRu1kQKPQcKqPFknQAbtIwh+0q0M3HeIB3171ad+v+OTnLJm37fDsJR
 Nf7411gQP0Ms/ZWDDn/T4kcONEI4QqrTclkA1zj9XG9IGuyzfmrn6yI5awMkzeV7e8zTR6smcNQ
 Bud81letq+sE5xzjlw8/rRm6TIitk3sZUORxiRGu+Jma66WQiZVljvOJCRo8tD11MFDXQ0wYiuX
 KSMtmGIw2RFANFc8uzoihFqHCVuFUFLrE2EQJ52KWwi0jwIrTHs2TqsIUjshfqqBjWE5JbaZxyv
 ncrvKG4NPoMK1dj2RsH/ANvsjMiIR6+NtjWEWVsw==
X-Google-Smtp-Source: AGHT+IFZDC4OhiN1h9B1FhpgKkifN7pix3ytBhwzmVVF5NWKgTlpKXzIx4am0CmKbe5KLrjn35YheQ==
X-Received: by 2002:a05:6a00:1410:b0:7ae:8821:96dd with SMTP id
 d2e1a72fcca58-7e8c09d6299mr10559790b3a.24.1765296091560; 
 Tue, 09 Dec 2025 08:01:31 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e29ff6c68csm16475242b3a.19.2025.12.09.08.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:01:30 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 2/4] hw/char: sifive_uart: Sync txwm interrupt pending
 status after TX FIFO enqueue
Date: Wed, 10 Dec 2025 00:01:15 +0800
Message-ID: <20251209160117.1239596-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209160117.1239596-1-frank.chang@sifive.com>
References: <20251209160117.1239596-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x434.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Currently, the txwm interrupt pending status is only updated when the
asynchronous transmit handler runs. This can cause the txwm interrupt
state to become unsynchronized between the SiFive UART and the
interrupt controller.

For example, when a txwm interrupt is raised, the corresponding APLIC
pending bit is also set. However, if software later enqueues additional
characters into the TX FIFO exceeding the transmit watermark, the
APLIC pending bit may remain set because the txwm interrupt pending
status is not updated at enqueue time.

This issue has been observed on resource-constrained machines, where
Linux reports spurious IRQ errors. In these cases, the asynchronous
transmit handler is unable to drain the TX FIFO quickly enough to update
the txwm pending status before software reads the ip register, which
derives the txwm pending state directly from the actual number of
characters in the TX FIFO.

This commit fixes the issue by updating the txwm interrupt pending
status immediately after enqueuing data into the TX FIFO, ensuring that
the interrupt pending status between the SiFive UART and the interrupt
controller remains synchronized.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/char/sifive_uart.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 4a54dd52a1e..eff1766274e 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -124,12 +124,20 @@ static void sifive_uart_trigger_tx_fifo(SiFiveUARTState *s)
 static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
                                       int size)
 {
+    uint32_t txcnt = SIFIVE_UART_GET_TXCNT(s->txctrl);
+    bool update_irq = false;
+
     if (size > fifo8_num_free(&s->tx_fifo)) {
         size = fifo8_num_free(&s->tx_fifo);
         qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n");
     }
 
     if (size > 0) {
+        if (fifo8_num_used(&s->tx_fifo) < txcnt &&
+            (fifo8_num_used(&s->tx_fifo) + size) >= txcnt) {
+            update_irq = true;
+        }
+
         fifo8_push_all(&s->tx_fifo, buf, size);
     }
 
@@ -137,6 +145,14 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
+    /*
+     * Update txwm interrupt pending status when the number of entries
+     * in the transmit FIFO crosses or reaches the watermark.
+     */
+    if (update_irq) {
+        sifive_uart_update_irq(s);
+    }
+
     sifive_uart_trigger_tx_fifo(s);
 }
 
-- 
2.43.0


