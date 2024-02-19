Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A29C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsJW-0005KG-Kh; Sun, 18 Feb 2024 20:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIg-0003Zd-Le; Sun, 18 Feb 2024 20:18:33 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIe-0004Km-N7; Sun, 18 Feb 2024 20:18:30 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-60837b7a8ddso4278377b3.3; 
 Sun, 18 Feb 2024 17:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305504; x=1708910304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgxIa5HOf2s4PxPeT+Tes/SCgEQfKR5FNbiYSKZGSJc=;
 b=K81z6XsmTDDTduZkmA/+bHYCFH1eeBoflJ/H1l2lLeik2DSKv4enEjLepWpN6X0nb4
 yPLJURHLwwu4B5GZK2TKKawIofSOg+6MjCzNH+uG2AWwDn7/lWHvHVIgc+ftz2thTSYG
 lvXWq9RJE0CbEu5v8c0Lav/TiIvaoTh+bLTqw3/qm73OTy5FCvf95i5uNIrdEZB3uiKl
 jL4nUE5jIaMr3wmn6Wbd+yTghfKgp4LwdUmPrAhgH/i8OQz4PpzEtt2Ycd87qBFT88eM
 iTqCHUf4n7xZwTeuia52/lHr2W+XmQ3zNYucrEQ3sTmUw3rQPVQrlfcdTo+6ZhJbBU7r
 98ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305504; x=1708910304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgxIa5HOf2s4PxPeT+Tes/SCgEQfKR5FNbiYSKZGSJc=;
 b=il9zMpmKxyWam2cYhWaaHL9i6QZ77pFQQ4y9LJYuyZpo9WM2eZqJVjQZ8eumo6mbIT
 DvPmkMzXitNCVdmz3CD+YoRKWvlsuKSLE6RPODimobudIFoBcVAAotg32c5qtM5cL6tp
 HIhpPe8mwaLnhTGQPny0mKhr6uO7SVY8Ym0h+KzEC3y0/pDAphQVylr/wmOgOdZ8kVPe
 axbJOrohPM0s8GKMo3D3PYetvcVB0GRCWNGEAbrWfoxP/KDCEK/i1pRj2PF5Qewz4qPd
 LT3MX7JE08tCGvP93annaTOZc8isRUm0EXg+xNp7LD0bma3k0sF25HKPZjGWalI1rt7L
 Y3Uw==
X-Gm-Message-State: AOJu0YwLoWskwg1uLjAFyaXBic94jSFjrdLk2BOO+19BtMC/w2wlfEs3
 7xmbwhRzCk+2vq17c3BGq1rvh6GyNyZcanNP/Psnfv/W8W5Ps4NxxL2wStUvdac=
X-Google-Smtp-Source: AGHT+IHmxgcqU2lCAJswlTadrzmYsP0sly7O2hXy0lIVz4RHaUo8kO4iXPUlbU4sMdreYIxY8kMGBw==
X-Received: by 2002:a0d:dd09:0:b0:607:7e9e:3533 with SMTP id
 g9-20020a0ddd09000000b006077e9e3533mr11962666ywe.3.1708305504045; 
 Sun, 18 Feb 2024 17:18:24 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:23 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 35/41] Add mailbox tests tags. Part 3
Date: Sun, 18 Feb 2024 19:17:33 -0600
Message-Id: <20240219011739.2316619-36-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112e.google.com
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
---
 tests/qtest/bcm2838-mailbox.h | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index b4f7b7b314..d753f17fb2 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -446,6 +446,84 @@ DECLARE_TAG_TYPE(TAG_GET_DMA_CHANNELS_t,
         uint32_t mask;
     });
 
+DECLARE_TAG_TYPE(TAG_GET_THROTTLED_t,
+    struct {},
+    struct {
+        uint32_t throttled;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_NUM_DISPLAYS_t,
+    struct {},
+    struct {
+        uint32_t num_displays;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_DISPLAY_SETTINGS_t,
+    struct {},
+    struct {
+        uint32_t display_num;
+        uint32_t phys_width;
+        uint32_t phys_height;
+        uint32_t bpp;
+        uint16_t pitch;
+        uint32_t virt_width;
+        uint32_t virt_height;
+        uint16_t virt_width_offset;
+        uint32_t virt_height_offset;
+        uint32_t fb_bus_address_lo;
+        uint32_t fb_bus_address_hi;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_GPIO_CONFIG_t,
+    struct {
+        uint32_t gpio_num;
+    },
+    struct {
+        uint32_t zero;
+        uint32_t direction;
+        uint32_t polarity;
+        uint32_t term_en;
+        uint32_t term_pull_up;
+    });
+
+
+DECLARE_TAG_TYPE(TAG_SET_GPIO_CONFIG_t,
+    struct {
+        uint32_t gpio_num;
+        uint32_t direction;
+        uint32_t polarity;
+        uint32_t term_en;
+        uint32_t term_pull_up;
+        uint32_t state;
+    },
+    struct {
+        uint32_t zero;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_GPIO_STATE_t,
+    struct {
+        uint32_t gpio_num;
+    },
+    struct {
+        uint32_t zero;
+        uint32_t state;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_GPIO_STATE_t,
+    struct {
+        uint32_t gpio_num;
+        uint32_t state;
+    },
+    struct {
+        uint32_t zero;
+    });
+
+DECLARE_TAG_TYPE(TAG_VCHIQ_INIT_t,
+    struct {},
+    struct {
+        uint32_t zero;
+    });
+
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
 void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
-- 
2.34.1


