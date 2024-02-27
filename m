Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB4C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexb0-000189-K0; Tue, 27 Feb 2024 08:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaZ-0000pQ-PU
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaT-0002vT-HP
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412a38e2adaso16988375e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040815; x=1709645615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LAJ/EogWW9dhCM2UgCKzftAD6rpSgQuVvkridR+6mrg=;
 b=Bf3iPuIBI9fXEU1eCt8r/ZRczaBsl1Nusmhg500qyPyWZ/Ng354lYhb3ZAW6Tg+an7
 Kp+8AeKeD6AFadOoKGA9K9Nl5Qtf3w6AxVpQYktFkDTtf5WlV+C6/bG6jBpA58wHFN4u
 aDwbOEGvOOAoWJM/LNL04P1hZj3WluYlBH68Ba6DH9FPT+z2QMjmnH74cTg+qg0OeH4P
 A2LU5HKTMYtJ92A5smDRgyxfa8pkB5xEX2vTUk4ZdHLfwSPXOsIv4v2h1Hd9TSuqrGK6
 eFr5G9BkuaElctuGWXw7EuFUFYp/+TjPIe8N4+RmCuq4lQ/+R7BKHVdmGewje/J+N2Pp
 O5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040815; x=1709645615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAJ/EogWW9dhCM2UgCKzftAD6rpSgQuVvkridR+6mrg=;
 b=BJ7oc/ulayggfTLgCXAU1fGfNM7CehQRNR2/relq5GEgNS6cbHBreX7A4IARKCW9di
 nAaz8zQ4wswMimVHwoDpazsqrLPRkcFEtUKoQbLOOSJcgB11vYaB/x+XO09HAgC/Me45
 B2h2WlbIkjLjy9+dWs2PryOOfTtu754wB3tQIPb7JnssWPTiDGmbHXjSNn2XYmBmrU9y
 eYoQYiXhVgfMmdjEhJ3QJPjqdYVdp5epc6KFJWVli7Qn00gy9FpSn8ToI4Uh476X8FWo
 OOSysvIrdzs8xgsK/wiN39YsMA69AmQxgFGWOmodNmMGQHEs+2YSPL6Kx2ZfBUB6EO2t
 HO1Q==
X-Gm-Message-State: AOJu0YzVCQlX4e4SSyDMG/JjGCiF0oTDXkIQGl4QjKkWIhY2jkfx/QTV
 pF4L407CUv2/mYH213kH7RRbx7lSjzFPnTeD2ufZK98eoDNx7Swm2ltYuX4EmchzPB59LmSlLMD
 V
X-Google-Smtp-Source: AGHT+IFvvsegRGuljJvmRPiroA7iA5Sbi2WTvX/W5fyOHu1jLymWJE3aKog2zwphlg6MH6dmCdGFyw==
X-Received: by 2002:a05:600c:3508:b0:412:b0ed:f18f with SMTP id
 h8-20020a05600c350800b00412b0edf18fmr111726wmq.21.1709040815706; 
 Tue, 27 Feb 2024 05:33:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/45] tests/qtest/bcm2828-mailbox: Add mailbox tests tags.
 Part 2
Date: Tue, 27 Feb 2024 13:33:07 +0000
Message-Id: <20240227133314.1721857-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Message-id: 20240226000259.2752893-35-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bcm2838-mailbox.h | 152 ++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 1360fbb8cf4..b4f7b7b3143 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -294,6 +294,158 @@ DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT_t,
         uint32_t height;
     });
 
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_DEPTH_t,
+    struct {},
+    struct {
+        uint32_t bpp;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_DEPTH_t,
+    struct {
+        uint32_t bpp;
+    },
+    struct {
+        uint32_t bpp;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_DEPTH_t,
+    struct {
+        uint32_t bpp;
+    },
+    struct {
+        uint32_t bpp;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_PIXEL_ORDER_t,
+    struct {},
+    struct {
+        uint32_t pixel_order;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_PIXEL_ORDER_t,
+    struct {
+        uint32_t pixel_order;
+    },
+    struct {
+        uint32_t pixel_order;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_PIXEL_ORDER_t,
+    struct {
+        uint32_t pixel_order;
+    },
+    struct {
+        uint32_t pixel_order;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_ALPHA_MODE_t,
+    struct {},
+    struct {
+        uint32_t alpha_mode;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_ALPHA_MODE_t,
+    struct {
+        uint32_t alpha_mode;
+    },
+    struct {
+        uint32_t alpha_mode;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_ALPHA_MODE_t,
+    struct {
+        uint32_t alpha_mode;
+    },
+    struct {
+        uint32_t alpha_mode;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_PITCH_t,
+    struct {},
+    struct {
+        uint32_t pitch;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_PITCH_t,
+    struct {
+        uint32_t pitch;
+    },
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_VIRTUAL_OFFSET_t,
+    struct {},
+    struct {
+        uint32_t x;
+        uint32_t y;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_VIRTUAL_OFFSET_t,
+    struct {
+        uint32_t x;
+        uint32_t y;
+    },
+    struct {
+        uint32_t x;
+        uint32_t y;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_VIRTUAL_OFFSET_t,
+    struct {
+        uint32_t x;
+        uint32_t y;
+    },
+    struct {
+        uint32_t x;
+        uint32_t y;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_OVERSCAN_t,
+    struct {},
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_OVERSCAN_t,
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    },
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_OVERSCAN_t,
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    },
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_COMMAND_LINE_t,
+    struct {},
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_GET_DMA_CHANNELS_t,
+    struct {},
+    struct {
+        uint32_t mask;
+    });
+
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
 void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
-- 
2.34.1


