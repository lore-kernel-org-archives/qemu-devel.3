Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58535C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaY-0000oj-5Y; Tue, 27 Feb 2024 08:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaI-0000jV-Ps
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:27 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaG-0002ro-TA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33de4d3483eso1073926f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040803; x=1709645603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mH020CujZ7OZ2w++F6q5td/qRwav+t8/vo2MNxQRXSs=;
 b=amTantS4Is5UCyNHvJ/lpdbwSns0SxVhi7Kl8Cy+SCawVVhkZHahZuXVllCk88/VOO
 S2z9K9BlI7GQYotBAFOn4yLohvdXOv5fWhHxBeosZ+tlwv4EdfFBGxh+2H3bEW0t7ZK+
 88CY6HwpH7k3hH04698ta/mIOZKrAovuXAvmFVvuAoV/TK0bIk5GopyxkCXUrx+U4ly6
 +q53LfPzGj3kzwgypNPqJELcqWzs3z1HjeuQgrLwti0og78tc2vvccmiUUA2GVtw/fFP
 uNohvFnn9sV/NwQt7PyaBMxq2+L0mi5yPlQ6NHxQlG0SL2u7I815jRAAtytCyrKDhHJa
 HxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040803; x=1709645603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mH020CujZ7OZ2w++F6q5td/qRwav+t8/vo2MNxQRXSs=;
 b=uOxUEN3i/aX6SYcd887iTCfoXp9Xn3Sr3UwNkg5lSfj4a3Z+qz+3YR0MURmctYZrK9
 07QyYRA1K2/tBzjZv7ljXgxfbSbLYH7sjb9AiR6GoEA7gEoW1G0XRLDIHm6HxZdU9gFD
 pjb0rFY97c/agMiQE2RVYXHEi6+jWq/Kw9ivXhg9CDBxLin8qzMIBHTAgT++ghL+IQ2Z
 d8QjgbzkIQiPSwzpiUlxCdiO3YI134hCj10eItk+/utXEcxJWsKqPnzHpCL9Qw2ZLg37
 iQNF/HYib5uq8Ipqf6wQnXiwdawEQh3QvfRQql+/G2fbLwk4cfTawGtEGA6aPhZ53vlb
 oscQ==
X-Gm-Message-State: AOJu0YyJcRmUm7DSzuJR8QJQPXE1ERkGbW2LwsHvlQ9YQzZhGgmSuXnB
 +xSeG/7bU+bA6eLNhBNMNFTViK1TTnawGjlXQ4xLKbata5YNsFwurL0slPMzM1sCiUGiWAi3TJ8
 y
X-Google-Smtp-Source: AGHT+IHUta7D1AQ5/jywP+lReW54FluQz4RUhzo7vqCLtm35CNT0sKY/VjMLTQ6UlkzGIEApW+oc+g==
X-Received: by 2002:a5d:6a0f:0:b0:33d:64dd:4b2e with SMTP id
 m15-20020a5d6a0f000000b0033d64dd4b2emr7717795wru.7.1709040803461; 
 Tue, 27 Feb 2024 05:33:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/45] system/bootdevice: Don't unregister reset handler in
 restore_boot_order()
Date: Tue, 27 Feb 2024 13:32:42 +0000
Message-Id: <20240227133314.1721857-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Currently the qemu_register_reset() API permits the reset handler functions
registered with it to remove themselves from within the callback function.
This is fine with our current implementation, but is a bit odd, because
generally reset is supposed to be idempotent, and doesn't fit well in a
three-phase-reset world where a resettable object will get multiple
callbacks as the system is reset.

We now have only one user of qemu_register_reset() which makes use of
the ability to unregister itself within the callback:
restore_boot_order().  We want to change our implementation of
qemu_register_reset() to something where it would be awkward to
maintain the "can self-unregister" feature.  Rather than making that
reimplementation complicated, change restore_boot_order() so that it
doesn't unregister itself but instead returns doing nothing for any
calls after it has done the "restore the boot order" work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240220160622.114437-4-peter.maydell@linaro.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/bootdevice.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/system/bootdevice.c b/system/bootdevice.c
index 2106f1026ff..2579b26dc8b 100644
--- a/system/bootdevice.c
+++ b/system/bootdevice.c
@@ -101,20 +101,23 @@ void validate_bootdevices(const char *devices, Error **errp)
 void restore_boot_order(void *opaque)
 {
     char *normal_boot_order = opaque;
-    static int first = 1;
+    static int bootcount;
 
-    /* Restore boot order and remove ourselves after the first boot */
-    if (first) {
-        first = 0;
+    switch (bootcount++) {
+    case 0:
+        /* First boot: use the one-time config */
+        return;
+    case 1:
+        /* Second boot: restore normal boot order */
+        if (boot_set_handler) {
+            qemu_boot_set(normal_boot_order, &error_abort);
+        }
+        g_free(normal_boot_order);
+        return;
+    default:
+        /* Subsequent boots: keep using normal boot order */
         return;
     }
-
-    if (boot_set_handler) {
-        qemu_boot_set(normal_boot_order, &error_abort);
-    }
-
-    qemu_unregister_reset(restore_boot_order, normal_boot_order);
-    g_free(normal_boot_order);
 }
 
 void check_boot_index(int32_t bootindex, Error **errp)
-- 
2.34.1


