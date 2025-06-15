Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A90C61CE8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 11:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQlQZ-0003nr-Pi; Sun, 15 Jun 2025 07:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQM-0003eL-15; Sun, 15 Jun 2025 07:21:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQK-0007y8-Gr; Sun, 15 Jun 2025 07:21:17 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso3492212f8f.1; 
 Sun, 15 Jun 2025 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749986473; x=1750591273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PAd+Ag09Z1RtE6nSLbu8MU1jQdIfYloyvGbcP1uNwY=;
 b=FnJqbTuJqQao/hZC6gPbNUF1RMpUSlGE2adBMmu4r3cj6O/spFGW4yOCR9sH7ldhif
 2wCd/UocmHH76g54pjnwehq+0gRXEzQ2ldG3ykc6bIYiiWlywHz8q0fE0C6ndr1Svwlo
 koI/AF/6q6Kt2X5k/EJxaWIRzYzVuyNevog6eRWnaDnUOLrYSTP8AayVn+an3GxZ/d+q
 GHTWx4nrixQTOV1HbAfGBvgDac/X/3tOdRxXO79eMTk6yg99qV2SibWv7OBv1QpaGA1h
 QB/aZtBCVPaCaBG0QSC9+7Wa8vLuF0twmCisaVeLXYypQ9qplFG8HfoOveP9e86GAZpt
 ATjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749986473; x=1750591273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PAd+Ag09Z1RtE6nSLbu8MU1jQdIfYloyvGbcP1uNwY=;
 b=YwY0TxHnOwNEuBqXMIYxQR1uhuojMqoIMCTjKugtFRzL2QbQD8x0er1gGu0ySC2oS3
 7+9CXcwbWZ1w6/kNs40NgvKDp0eQm/+P5RYtRNxI000Jb51oM0pvpbCkwKnSxZLjehfE
 AmFY+PwhAh223XmbjKQ/KZb7CQW3Qk26ZBz27K5h242rmtR0rwyexOadWTwgpYqGf92r
 RRfmyg1uH2/4ZBMs6+e0MdiuQD2QQtTVDEcvAYLhiivwSNOOveLKnbpu4N8P7SE/uiR/
 sQXq8Hj4HEJz9iEh+gC/NtEwMVwdaSNgKbp183Be9irZVm5ZH2yLJ0OqD7Wk5VglzVWJ
 mfFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTEwthdNLerWKpQ6BHED2/rXdTroMqMeSK3ocTzZy8syZW3ybMUhf9rn2aEZboPgiitzNX+fWhR2I=@nongnu.org
X-Gm-Message-State: AOJu0Yw4szZ6S2a+odThntvmI+qMHjcfLu+B2L09Uhtn5bF2wu/EqucM
 nQF45StCrkXS00Q3wIs+iqym7ClJwGPJfwk4oyBKk2qY8q+v/0fyVUT/X4AxeA==
X-Gm-Gg: ASbGncvGGEOngRcwvASSWUEhQDMz04NXCxAwKr7ICkqZmMhLTUfGUgFZmLVE1wrn9b/
 k4sYbbjfc/cqKS1zjMTaCTpkXfuEVCswdBmpqCtIyM1spBMV6sQlAaO4PL9no51812O3BTHmh2q
 mo1rWI8xgCdztp7bEZcPfg4Q5anRiXYupTfnfS+jJP0xHfuHzRsCOir/02F2RuzXjnxnnqBcx+v
 vAx5kqfyOtBiwiyKb6nMOhDtT8V7keqYaejtUjDsqyM1+GvFO66Z2C0ilCW+IxwgyFLOePMeaEN
 x7DECuz9a7vRBxP/az1pbhogmoQraEDhAod0Y+MvLvuI8clWFLGM0g02kEjQ0pCVff/jY5amK1L
 0tTyW8mw0iNDQgaMkKaiv6Y5BjHhHe9ZoyKo5Al3E2RFPmT8MM9MawPZQe/PaG88JBJyAAxQvp0
 cx1ymosQ==
X-Google-Smtp-Source: AGHT+IGqFpEiTIg7K7tEux/BOI4K4o2CpLwSw+ng+8y1WcXpcuD9s52EVtO5umVxRJCb8D31lJmMnw==
X-Received: by 2002:a05:6000:2884:b0:3a5:2ef8:3512 with SMTP id
 ffacd0b85a97d-3a572373cdamr5418243f8f.14.1749986472881; 
 Sun, 15 Jun 2025 04:21:12 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-231b-9b00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:231b:9b00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm7327099f8f.89.2025.06.15.04.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 04:21:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 3/4] rust/hw/char/pl011/src/device: Add missing logging to
 match C version
Date: Sun, 15 Jun 2025 13:20:36 +0200
Message-ID: <20250615112037.11992-4-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250615112037.11992-1-shentey@gmail.com>
References: <20250615112037.11992-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 rust/hw/char/pl011/src/device.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index fa591c3ef6..48b4bca6b8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -304,6 +304,12 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
     }
 
     fn write_data_register(&mut self, value: u32) -> bool {
+        if !self.control.enable_uart() {
+            log_mask_ln!(Log::GuestError, "PL011 data written to disabled UART");
+        }
+        if !self.control.enable_transmit() {
+            log_mask_ln!(Log::GuestError, "PL011 data written to disabled TX UART");
+        }
         // interrupts always checked
         let _ = self.loopback_tx(value.into());
         self.int_level |= Interrupt::TX;
-- 
2.49.0


