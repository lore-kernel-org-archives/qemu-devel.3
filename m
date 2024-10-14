Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA485D18128
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mxq-0006IR-3k; Mon, 14 Oct 2024 11:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxk-0006Fo-Hs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:24 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxh-0000vw-KA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:24 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539e1543ab8so4276404e87.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728919577; x=1729524377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Twyv6YldhETnLvxZDkBVahrdEIkG4B6Hw1qzwu/nBjU=;
 b=ao+ZrR8KweE/5YbZQbnoQf1z48TBhH4vSKIWLCN6KCMnFrs1xtukgKz7At4/ieItVj
 vxaQhKiT9tRjNsusHGzXBZviOyejBrTJFyzEYVtq9eiT1B27nGioBhNFY4KjK/FWBmgD
 15iwt8NPEvjNcwiI6OR81TQzNx+O7qIh6mASae4zIqitDWQnhNPcvhoBM7zIbvFjfsik
 Cl5xS9n8C8vi9IGij3Q6iAdDas+TBwIMTCiH3bmVsrLVHphAAtzso+p3GM9DxBhC4oHi
 rPo9Cd07r/KUQjDmTpoNGeuSUfTgQWjQraRXphmGt0xPC3PX8aEoNNbXE618W1/RlIiS
 WAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919577; x=1729524377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Twyv6YldhETnLvxZDkBVahrdEIkG4B6Hw1qzwu/nBjU=;
 b=QjcPXa0ezVzefnmyaX90ibZbPcfPMAxVXe4ifB1LwbSHDyhXL9sYYGkZ3IVGE+cXGX
 bmn3m09zDIZv6DZYN8NpepeWhzh8079CNp5NgNFv4La6LHRk/audN6oU6z7sGcxiEBR3
 wOO0WKJTwXNliVSfWF7tw+mjkNkDnvkSswXf8cVYP3Akv+9tUv/le4XSFLUIzTwmdkVA
 piAI5A3D1P1BKJOFA52SxwQLw3hmGWkWZv9PfZSEWqzAZLjQ2AdX0sm2gRiQCHz5oyBO
 0V1tpkVh9joCJN6a14asUbEXnxj9XvnH/im80uM/3j2RnMYupiUKXe6amaFwdu/w17sA
 vqOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWftznYq7lLY084GEx5WTWVrMDFNzzAxhuOyjCQT75i5QILRQIQ3la8Tb99QdI0UdRDaNt66oTGt2am@nongnu.org
X-Gm-Message-State: AOJu0YwkTXLiWr23Nv+EyzCPG461msNduDabfIsyKXbYbDz6OIX/84K2
 gve58MDWlIfohfn6ii3P5pslTyj7hadpW95EvgInPuG9I3SQKnsW9w2m4Q==
X-Google-Smtp-Source: AGHT+IHCOPZH9o0oJOAmtTOxYL3dSlzfMHZ27dFbAyKyjaSYxeLcfQa2M04Ak1OI8w4o5mtHu/0adA==
X-Received: by 2002:a05:6512:3ba5:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-539e54e74f6mr4398904e87.16.1728919576245; 
 Mon, 14 Oct 2024 08:26:16 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a13396603sm133689966b.169.2024.10.14.08.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:26:15 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] tests/unit/test-char: implement a few mux remove test
 cases
Date: Mon, 14 Oct 2024 17:24:08 +0200
Message-Id: <20241014152408.427700-9-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014152408.427700-1-r.peniaev@gmail.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x132.google.com
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

This patch tests:

1. feasibility of removing mux which does not have frontends attached
   or frontends were prior detached.
2. inability to remove mux which has frontends attached (mux is "busy")

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 tests/unit/test-char.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index f273ce522612..2837dbb863a8 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -184,6 +185,21 @@ static void char_mux_test(void)
     char *data;
     FeHandler h1 = { 0, false, 0, false, }, h2 = { 0, false, 0, false, };
     CharBackend chr_be1, chr_be2;
+    Error *error = NULL;
+
+    /* Create mux and chardev to be immediately removed */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", "128", &error_abort);
+    qemu_opt_set(opts, "mux", "on", &error_abort);
+    chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr);
+    qemu_opts_del(opts);
+
+    /* Remove just created mux and chardev */
+    qmp_chardev_remove("mux-label", &error_abort);
+    qmp_chardev_remove("mux-label-base", &error_abort);
 
     opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
                             1, &error_abort);
@@ -334,7 +350,13 @@ static void char_mux_test(void)
     g_free(data);
 
     qemu_chr_fe_deinit(&chr_be1, false);
-    qemu_chr_fe_deinit(&chr_be2, true);
+
+    error = NULL;
+    qmp_chardev_remove("mux-label", &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "Chardev 'mux-label' is busy");
+
+    qemu_chr_fe_deinit(&chr_be2, false);
+    qmp_chardev_remove("mux-label", &error_abort);
 }
 
 
-- 
2.34.1


