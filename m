Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3217C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexat-00012u-PR; Tue, 27 Feb 2024 08:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexab-0000pm-GB
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:47 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaT-0002vb-Vd
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a3ebad2aso17393685e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040816; x=1709645616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6xpLdkE9iXtV73i2+Xl5bPxwLohpFKgvSaeqg1dUVtY=;
 b=IkEZ53Hn7s5eLL+Nfr3a94zLampuoLXax2F+6be/8rFh0Ttb1Z0JFFPmuhe7nDzhW3
 m63TmfZ9lxWUGf6/Gb1s+THkRNaaWIM92en7+etkRHyI6j+k6a7P/AFTLGVHYX62zAMl
 c+Krp5O7jT5RiVFDG4eWPd2ui/1anwUTPWUYFRu9kaK7lsSY67Z56e6JaK6aWmho84r1
 AR2BWrOs9YdbYFbumpLmg7eqGWB6c8UwPlYSlZvoSOxQDU8msluAaR1n5ktDAfcfzQ1Z
 XhWY1AMAb7xtfqD+HSCtxKFp5x4nuuumI9iFevFbJLJQ0+xf8UkE+/vvaCe4M/d6vQZ1
 qe0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040816; x=1709645616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xpLdkE9iXtV73i2+Xl5bPxwLohpFKgvSaeqg1dUVtY=;
 b=wIWlQoXVKGNfI5lq+2crOjwt/pzINBONtfnD81Kz+kUNpXc2MutWMgSdlC4xYFOaI7
 s+zR5QM/E4AmqcZBf8CDnzZr5foZMP6YvvI898xzcv0RdjBWea6Ual453ya1zl7zgtd0
 v9q8cnFe78kvL8t7otPB6ANb3QO9V2cF1Cdct+Pj7IhBZamCne2k9tLEfdTZjZnGiOcm
 XcGLbCsnTX+cWvVOTNTls99I0ihh8hDIa42uQQew6aEcHmcWmMUJqpH38dhn5OCZs1X/
 8FjbYyB07nOhgN7a/tWZMdvORWqnEwV6ZjyTjeHQhZiw1SIUBPfbic2GJrRjcXgis4ta
 Zwtg==
X-Gm-Message-State: AOJu0Yyup+km7mVJ3Gw5E4OqdVfGZb2Val0IB9wVB9iazkqe1bipw8bC
 jKmjKAkf10OTiDezGJWJvQ1ggXyXoVVDvGDwtLsG/H0e3GrPLJXOOjoBWqLeUhwzvb6nmwBMt65
 f
X-Google-Smtp-Source: AGHT+IHj4yg0qciPCClnx0fD7u8dxc/b2WMsHEyH5blGW2nNpi6bxcIvAEvZcwMZukEgwHAjxDKumw==
X-Received: by 2002:adf:f50f:0:b0:33d:ca72:7255 with SMTP id
 q15-20020adff50f000000b0033dca727255mr5044214wro.1.1709040816217; 
 Tue, 27 Feb 2024 05:33:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/45] tests/qtest/bcm2828-mailbox: Add mailbox tests tags.
 Part 3
Date: Tue, 27 Feb 2024 13:33:08 +0000
Message-Id: <20240227133314.1721857-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-id: 20240226000259.2752893-36-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bcm2838-mailbox.h | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index b4f7b7b3143..d753f17fb22 100644
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


