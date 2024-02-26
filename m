Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FB5C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOU4-00084k-NX; Sun, 25 Feb 2024 19:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTH-0006yB-6g; Sun, 25 Feb 2024 19:03:54 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTD-0000a8-DB; Sun, 25 Feb 2024 19:03:48 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-608d55ab7b0so10822237b3.1; 
 Sun, 25 Feb 2024 16:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905823; x=1709510623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+5nn8hCwpZzaVfTQwWnore40MHayijwV/Mz9d7pKPI=;
 b=WzcZi59r3r2TqTywgC3qUw3Hcrw14XzwzToJP7ilrilPBc8izWOyTDI13M/F6gPDdv
 X377AKUEZhpiI0GLWO2y143B4lFoQCFLovBe3OGsoPO3P/CzEos37x3X3bQqlJ82Xush
 3ahPRPaQhckpziMhcn2SXuRGxqhTJy+A0TfStk/GsKIfzikmEDF7MMhBz3RoVWd+iT8D
 VWr74vLZ0n2kKF0lNHRxGBZEDjmeBoqu+fnQXfx/PIG4yjkoHADoLx9dFW40iLCF31OL
 C35qXI9Bv+Pzw4Rgo3zeD1pDlMhp61YlI4bGztg9zfeKM/l9X9Z53iD9y3fwhg/psD41
 Ri5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905823; x=1709510623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+5nn8hCwpZzaVfTQwWnore40MHayijwV/Mz9d7pKPI=;
 b=IXBshOOusRAuBgl36fXljox/abtO67HCfAInffQM3XaiGnIJnjIAW0NcJWPBG8lmTA
 iyWUGM5fZRrJwann4JS08TNglS7IRsZeszMrz+ZSjqz763veYNdR+/liWwnGD72U4FAo
 CoYqBynBbIgEkun8rJrVoXNtQlabhCCk8ZCA1dlRM7F5IxEENwZhjj8OjtrgRVUGzhx4
 E2SIJ/q6b/rLFuPkKQ6hqxSFoMtBc5xd4wP/DywWMN5rrVCXvskP3c9VEnnBD8jGKPsr
 sQSpVlvvZ84gcVmXrlWYmgv9FA/7Q/wyJkKPBU+PbkFxQmre1pgWAF/ZORAtc8fOjQbw
 GwOQ==
X-Gm-Message-State: AOJu0Yx32XxDaCWIEa4NQcZYdg/EszwSwsOIhU5iRPCnhEd9CURFR4dp
 2hfF31NBzfTChHAYDeJAvqP3b2J1L43FH4VTZaSeK+u1wRBPtLWGRTR0vY/tfBm9xQ==
X-Google-Smtp-Source: AGHT+IEU1MDKCBBh6S7aTh1NgOKTEtmuYE1u7ap/m1xQwENYjRWFtGSWCjMnBxz/iWBVXVZVU7hEaA==
X-Received: by 2002:a81:94c3:0:b0:608:ddd9:812e with SMTP id
 l186-20020a8194c3000000b00608ddd9812emr3523737ywg.42.1708905823571; 
 Sun, 25 Feb 2024 16:03:43 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:43 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 34/41] Add mailbox tests tags. Part 2
Date: Sun, 25 Feb 2024 18:02:52 -0600
Message-Id: <20240226000259.2752893-35-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1133.google.com
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
 tests/qtest/bcm2838-mailbox.h | 152 ++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 1360fbb8cf..b4f7b7b314 100644
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


