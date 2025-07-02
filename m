Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54CEC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwk-0006jY-Rv; Wed, 02 Jul 2025 06:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwZ-0006gA-0H
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwS-0001KW-H7
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:58 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae0b2ead33cso1165978466b.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453029; x=1752057829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q++VT0w3BFey6U6AhyjA4yt6pGOWJ3/ulMKQuhSNA98=;
 b=Nu+M/P0/beZlN4U+AITXxBWEDWpKszoBubLChG3irC06ZQ2Z3moY4ZP447rwpX8TYz
 GcND8ZfD2dDb0ZbQsphHl9rUZe5L6BKSDfb2E370UPyGQVXupaFJ6KsSFxRRdbzSwrpY
 pp+xQl2wynCXZvUIxpaXtlHSV9IKK19VKuzZ29kaJClgyYxh6D+cIaKEi6k7llCGkasc
 v6OwzA8JrPaBovlN+MN0cXEOhUzLLj1XUI+UsgBOHMr6/ZT0kG8mY58KOG3yMXptvNWr
 A+teG7Z3zZqcdYsrw7kXyGyDByNwMCwppndVR8DO0U/TwRWy7pSRErGodN28IsnarwOP
 ddng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453029; x=1752057829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q++VT0w3BFey6U6AhyjA4yt6pGOWJ3/ulMKQuhSNA98=;
 b=SUohac+68MPnE9/Sde3Un9EeKA1/hyaohZGsmAdpLje+VCEIZvmt1whfi53T5/lyfA
 Ei3EwdJy0JcPNGbdSYrDkk++PzqTIMyG6GRrwdbdU/GFIHMWW50wx2V2A/C7P1C+AmjP
 7eZlVY+nI56oWclWFGe20DTGtduW0xbv5s9Jm2bMK06d6Pyz3Jl9Jh1xyHHhozr89UkG
 DDJ/c1+E3FTuLKLUQtjQqBs9qzjKv2E0D4VkCcUVpp0X+mde3AsOb1UQLPp72IkSq1B3
 LioOuAyisL66CnjboMhoyV+3CTzHU3H06KbQQWLTBwNdZElqMQMFH0O0WfEG1GBv7PEL
 e56A==
X-Gm-Message-State: AOJu0YwrFUG/NKU1+aIqBRc5X0KaN3485zhp8Fer57goU4XQTEC81jYy
 m2eTCCZDBpPWzdiGbnH9z6DxiQYxTUoAE5CS6nERjMY0+yCKSOyCr84nEInQHZsPx5A=
X-Gm-Gg: ASbGncumsvsmUSO80YBKaTspzus3e4aMwV4Q+pYhpBdAdeFW47eoF3kWSMbu0116cOZ
 AIW06+6atmf+FKYLuYaypOz/QAyJkkYTQ1jDhUDkO15ftmPXLXbAsNwximggLnGaHTcq2me4bwX
 LXCz81haerohX+UF9tPgxgmlAl0uSYgZKblU3GVSOqDHfFVL/MBvow/+e25l81d4l5NWVbnolOz
 Z7mWV15gx44+BoRpGJVYe5yQFUJSL/tI2e2n1bfSil50xpzx4Eiq+CEMYy6D5s/MMNqsWr8Y/AP
 YfUfKbZXVB5+Nd1elYS0tdc2uLnfCn8XCLA8ZP07oeuX3yJ/ct0yR7TsjhnpWVZBuBzflJm28w=
 =
X-Google-Smtp-Source: AGHT+IEBWm7rTIyqrHdAyQYZ4J4XKDZm37p+xdsk7L0kPRYVpscQTdfbeHl1fKUDlQYBdYQYOq/BaQ==
X-Received: by 2002:a17:907:d643:b0:ae0:bf99:6c5d with SMTP id
 a640c23a62f3a-ae3c3c55d50mr172572266b.26.1751453029260; 
 Wed, 02 Jul 2025 03:43:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353659f7dsm1032890666b.45.2025.07.02.03.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D3B05F920;
 Wed, 02 Jul 2025 11:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 12/15] plugins: Update plugin version and add notes
Date: Wed,  2 Jul 2025 11:43:33 +0100
Message-ID: <20250702104336.3775206-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-9-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-13-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 5eecdccc67..c450106af1 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.47.2


