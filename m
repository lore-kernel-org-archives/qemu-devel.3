Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45C7C28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trRwx-00045E-Gh; Sun, 09 Mar 2025 21:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRws-00043d-Mu
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trRwr-0006T0-0K
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:28:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso21509495e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570130; x=1742174930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wS79SS1CQxxkd3qnon8nNpovVlwqoGNVt9KU+09W3OY=;
 b=Sh9rTsV9fmGjKOKmxQtfUekDlfPLJKDn8zH6SXpz4XysntLgSvDG8u4ErurzWw3V0u
 BIirtzv3a4rwaHB7LCQcwnFC2Yh9lWSUs0Phn4UrsBRKHQL8uE5DlHTrsOlDmhhxSpyT
 TQxg134EJaIeoSRMnLfXmKEQPa3p0z0MyLUhUqogk79TicqGPhaA5R4g836urN8Q/8iD
 yVL8FBWBaGlqxasb69YuwuBNCVLABgBbcLTzXGooqHMh3gFIRKOfpJloyACTl34MYj3F
 UBa6Tc27gy7yLme8TitRSApCWM+vSVJtSqSJwOJGKZFgwO7RF6hwlkLDeqlOS8Q18kQg
 v3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570130; x=1742174930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wS79SS1CQxxkd3qnon8nNpovVlwqoGNVt9KU+09W3OY=;
 b=p/1gAnt2f5rjsa6kZEuhOj4z28HEqmseDsKTM++qSCwnbAgicvvJhzYxt721I3z607
 eFyw7Bt8W9Qi5NWwGyzD+Y2OQafLjNIKCiwUES5AHK0fosASmJnfcZeymUaEMYrJaBxm
 JRNrlOwRHKMA6KlhlsCNjDYbRnorn6t/8rhABwglx1xOtZNlLflU9E331BPbqw/AA3YJ
 UfZl9dalDlx6G1w/uUodoRIAIrTih/mjIsBK9K0KJl42uTk2a+YxDywW4drhMySLGTXR
 5WXEp6eusS89lhwNgQX67vvJ/E3DZPsoS/va8ulrVIuiQBG6AdltvyoMMDOSxTKoKeeM
 JbQg==
X-Gm-Message-State: AOJu0YxVQT5g0pF4QNt01CIMo5Vo5ekR9a4nzOSOxk4R1NQalVeLImTB
 gAAeQldd1Y26NlfdBluDE9yHXTZM4/1fyJgWaPazJ3bX3JPfugtBcJyzz+TkbZS6+l3vWtPGm3I
 P2KA=
X-Gm-Gg: ASbGnctKnRkdZIAbC9N9CUKHhYJCheJhV745DfVz2SrAOmZu0YIhgce0Aton0qqF7Eo
 2PD/HZvX4N86HcgYG9M94AjV4uKurejD4Nxi1piAWD6Vn9SbggLUFxmJHHy8NvswY2NHL38ZMUi
 paKZyF39efJZpOyZrEBxPEDLXTCsIDwpUQLKiZWKCBGLGwWVniryVStc2sw6QVjom23LRYQioZB
 VmeFoBThxB+JuD31gURLUAT9CWHOC1OiJhgspcCRIvnw8pMg6JqXD21rK/Y3e1gWUSZZCVfoI+q
 JddF9sB1scSM+N5VFpN0WX8RWI5tqz4yfFeQpU2MVvg8KHklmASx6H11zN3fLxhjRPEbsnmfMCt
 YPgPlj3soZYJpem9kAFs=
X-Google-Smtp-Source: AGHT+IEU+o3PvNWcLG1GvyNSXZDCJC2rsfUpn1+77ppYPB98quLAsSLIG7OR2dN6KsAByfSmYcdcrQ==
X-Received: by 2002:a05:6000:18ae:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-39132da96b3mr8000092f8f.43.1741570130520; 
 Sun, 09 Mar 2025 18:28:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79fbsm13570645f8f.13.2025.03.09.18.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 18:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 4/7] hw/char/pl011: Trace FIFO enablement
Date: Mon, 10 Mar 2025 02:28:22 +0100
Message-ID: <20250310012825.79614-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310012825.79614-1-philmd@linaro.org>
References: <20250310012825.79614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c      | 3 ++-
 hw/char/trace-events | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 18ea03a52f4..34a5cb3af5d 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -480,8 +480,9 @@ static void pl011_write(void *opaque, hwaddr offset,
         pl011_trace_baudrate_change(s);
         break;
     case 11: /* UARTLCR_H */
-        /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & LCR_FEN) {
+            /* Reset the FIFO state on FIFO enable or disable */
+            trace_pl011_fifo_enable(value & LCR_FEN);
             pl011_reset_rx_fifo(s);
             pl011_reset_tx_fifo(s);
         }
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 1bab98fb5f3..c857f4c4b38 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -63,6 +63,7 @@ pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x valu
 pl011_read_fifo(unsigned rx_fifo_used, size_t rx_fifo_depth) "RX FIFO read, used %u/%zu"
 pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
 pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%zu, can_receive %u chars"
+pl011_fifo_enable(bool enable) "enable:%u"
 pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_fifo_tx_put(uint8_t byte) "TX FIFO push char [0x%02x]"
-- 
2.47.1


