Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD15C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaj-0000rj-0M; Tue, 27 Feb 2024 08:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaM-0000kG-E1
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:33 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaH-0002sQ-Px
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:28 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33dc3fe739aso1658912f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040804; x=1709645604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uw8kJ1LxwsE/kFsD2cs5NZmvm6BAwgqD/ImRlmAAIm8=;
 b=WzJI6X+8UNB6N+N4rDnw8fxjuRrzwy6h2rNkxH2I8WRofVD20lFDRDrD8oYCCBa0iC
 7rYdcUwNZamz6gsnf4CUXfgq2PoW+yGHzP8MpCLjESJuMf9NpvQPyUWRb9PFdPjltlae
 HmpHuZ6KxCjgXoq7u4gkVQF8tZNm/PgAfI9+4AVo0PNrHrMduG0MsME/nYAdPnlxNsgz
 3Gc5X//tCTTLMAAAdlaOb888ruSBe+tjGnNmkiNHHC4Op8BGEjLK+x4AW2M8vqNlGXv0
 LSVVTTxq3bV1UiO2h7f3HI0KaeSpiWJsHvfbB9tTv7R6KYEA0PUbob4Qx3E0A02q07xY
 inJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040804; x=1709645604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uw8kJ1LxwsE/kFsD2cs5NZmvm6BAwgqD/ImRlmAAIm8=;
 b=I7hpEv3Z5lj0TsdPzTsdSZzQ0Ef6CKW4k4jyMrdYdQJvzQndnW8ESkbpI7ILsTeXv2
 Wc/Go1FtOPd2P4qiMaw12zlxiwBuYUulmnP62KRioVHx43hHWcAGT2fN2vkGPWEQ1CCt
 maifrE2jcof3zi5+I1vrhIqtYlRgM/gvHuqh5nr6GXrBUKU5VpRstsRj8XFx4qowjvDS
 OPCqhvceh71M4WsLXiA+OITus9D1s11fycQ26tc36Pg5ouam2EyuJYGvzZfZexRnCL3g
 saY7wPpNPb9zmolQFhiTtR6vQQdVh2MYlyw7es27EBCYrdZKQPbGpb17U+CIX350rH35
 wHpg==
X-Gm-Message-State: AOJu0YwIjoTucJZlJ+2r3Z9g8Mh1rQcVpxQzLK8byp+I84p30pmtDMkl
 5IpSog9Uk3cZV71u0LITjS3gfkyddPX7nL3JQRT1QqaYEamqYIkNWNe2m2LKe7AIl/DSCB+d1RV
 M
X-Google-Smtp-Source: AGHT+IF4TahKhSwK0jS165kBvVPUwb67reYsb8lRm0UzFgjJFvgOnUREIh47V7XgnHX1w5USnQlYCQ==
X-Received: by 2002:adf:edc2:0:b0:33d:8c9d:419 with SMTP id
 v2-20020adfedc2000000b0033d8c9d0419mr9457057wro.24.1709040804424; 
 Tue, 27 Feb 2024 05:33:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/45] hw/core: Add documentation and license comments to
 reset.h
Date: Tue, 27 Feb 2024 13:32:44 +0000
Message-Id: <20240227133314.1721857-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Add the usual boilerplate license/copyright comment to reset.h (using
the text from reset.c), and document the existing functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240220160622.114437-6-peter.maydell@linaro.org
---
 include/sysemu/reset.h | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index 609e4d50c26..658a7e091e6 100644
--- a/include/sysemu/reset.h
+++ b/include/sysemu/reset.h
@@ -1,3 +1,29 @@
+/*
+ *  Reset handlers.
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2016 Red Hat, Inc.
+ * Copyright (c) 2024 Linaro, Ltd.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
 #ifndef QEMU_SYSEMU_RESET_H
 #define QEMU_SYSEMU_RESET_H
 
@@ -5,9 +31,62 @@
 
 typedef void QEMUResetHandler(void *opaque);
 
+/**
+ * qemu_register_reset: Register a callback for system reset
+ * @func: function to call
+ * @opaque: opaque data to pass to @func
+ *
+ * Register @func on the list of functions which are called when the
+ * entire system is reset. The functions are called in the order in
+ * which they are registered.
+ *
+ * In general this function should not be used in new code where possible;
+ * for instance, device model reset is better accomplished using the
+ * methods on DeviceState.
+ *
+ * It is not permitted to register or unregister reset functions from
+ * within the @func callback.
+ *
+ * We assume that the caller holds the BQL.
+ */
 void qemu_register_reset(QEMUResetHandler *func, void *opaque);
+
+/**
+ * qemu_register_reset_nosnapshotload: Register a callback for system reset
+ * @func: function to call
+ * @opaque: opaque data to pass to @func
+ *
+ * This is the same as qemu_register_reset(), except that @func is
+ * not called if the reason that the system is being reset is to
+ * put it into a clean state prior to loading a snapshot (i.e. for
+ * SHUTDOWN_CAUSE_SNAPSHOT_LOAD).
+ */
 void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque);
+
+/**
+ * qemu_unregister_reset: Unregister a system reset callback
+ * @func: function registered with qemu_register_reset()
+ * @opaque: the same opaque data that was passed to qemu_register_reset()
+ *
+ * Undo the effects of a qemu_register_reset(). The @func and @opaque
+ * must both match the arguments originally used with qemu_register_reset().
+ *
+ * We assume that the caller holds the BQL.
+ */
 void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
+
+/**
+ * qemu_devices_reset: Perform a complete system reset
+ * @reason: reason for the reset
+ *
+ * This function performs the low-level work needed to do a complete reset
+ * of the system (calling all the callbacks registered with
+ * qemu_register_reset()). It should only be called by the code in a
+ * MachineClass reset method.
+ *
+ * If you want to trigger a system reset from, for instance, a device
+ * model, don't use this function. Use qemu_system_reset_request().
+ */
 void qemu_devices_reset(ShutdownCause reason);
 
 #endif
-- 
2.34.1


