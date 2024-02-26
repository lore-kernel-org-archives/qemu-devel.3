Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC9BC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOUy-0001lk-5H; Sun, 25 Feb 2024 19:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTH-0006yA-6x; Sun, 25 Feb 2024 19:03:54 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTA-0000a1-Rx; Sun, 25 Feb 2024 19:03:48 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-608c40666e0so12441437b3.2; 
 Sun, 25 Feb 2024 16:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905822; x=1709510622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDMTaxB0TWxp4LTnEEK1r7+Pg3vnDkkuQfxuwY3SDHI=;
 b=nKOMwjsyoBne5q7iXGqI5lisG+NkOdjEHMGOnHv0fpMTiGl5lcTmAHq3sTudb2mOSZ
 zmT6Gpw/RR1Y3HfJOxdNYep1IRdUtsl3zYehE7j/ciGLUoZLJASY4qOo40melID88Yjx
 jGl3kDC1tL479Wvrbr6yA8KsgfDC16wHeUJf8IcVwCzg9P4LKgziB22dDX0lF0RuyMyB
 ykbon8sTEm7iQRPvBeLQVIyqkGNfZQfLHtzC5JkCGvKqRbHXtRSczoD/q4zt7EG4OXMV
 XajCRHpWG5+hMaF4l5wFshv3N52pHBDzg1jSjxd18eINQHmCOjX0ZfZgrfSYxrpm1Yyp
 427g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905822; x=1709510622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDMTaxB0TWxp4LTnEEK1r7+Pg3vnDkkuQfxuwY3SDHI=;
 b=BX7WLdEqsBmZ3fEMfT6SITG5LQnh3+CZBVrKUhL9D6wj0AwabNegttKmGauad00xui
 xTW+5oI/GQUa/W7GsS2uobamdQx2eLLzqAPzZJlQ+MzcFbVUqskSLuPW4iUjGTrgt5RW
 fXHo1PzzO1HSi6pc23S0yh5YiRBYTh6gjTWK5cTe+p6pTagjhxeR5u6URGwzBV5Bk0lj
 WdMx0IklNGuh6RuPOMAFyYvXHtrRcyjaYpp1qSx7J9HQ0D4FCjrqtEqV0wgZ/XXYS9rf
 F+xjaTIKOpsxYVIkry0qAPHaWRUn+Sf9ttaSHc/hn1EMnZRpsvnc03O7y5iqUEC8u6fj
 gQ9w==
X-Gm-Message-State: AOJu0Ywl4QZMNfpC1I/Ga6NyGTS1Bxb/fTVkaJELSu/pnVMDF13jYfrw
 SYSndB3P1BgolL74veGvJ+EFWarbJSrYIhAQpdJc7wMMgQbNm8TCTGdJUz9vYpbrkg==
X-Google-Smtp-Source: AGHT+IG8Zf4elndbIUXe879R7BRHjiDDX8sNU88RpsCarUQmF67FKGiaQlRurIn/OKR3eqKuFeQq/Q==
X-Received: by 2002:a81:b650:0:b0:604:a081:c198 with SMTP id
 h16-20020a81b650000000b00604a081c198mr3197795ywk.42.1708905822344; 
 Sun, 25 Feb 2024 16:03:42 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:42 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 33/41] Add mailbox tests tags. Part 1
Date: Sun, 25 Feb 2024 18:02:51 -0600
Message-Id: <20240226000259.2752893-34-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112c.google.com
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
 tests/qtest/bcm2838-mailbox.h | 177 ++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 9222b38bad..1360fbb8cf 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -116,6 +116,183 @@ typedef struct {                                                        \
     };                                                                  \
 } TypeName
 
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_VARIANT_t,
+    struct {},
+    struct {
+        uint32_t variant;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_BOARD_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_ARM_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_VC_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_POWER_STATE_t,
+    struct {
+        uint32_t device_id;
+        uint32_t cmd;
+    },
+    struct {
+        uint32_t device_id;
+        uint32_t cmd;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_STATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t cmd;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MIN_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCKS_t,
+    struct {},
+    struct {
+        uint32_t root_clock;
+        uint32_t arm_clock;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_ALLOCATE_t,
+    struct {
+        uint32_t alignment;
+    },
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_RELEASE_t,
+    struct {},
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_BLANK_t,
+    struct {
+        uint32_t on;
+    },
+    struct {
+        uint32_t on;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_PHYSICAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
 
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
-- 
2.34.1


