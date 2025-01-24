Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA313C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNpo-0002ap-8T; Fri, 24 Jan 2025 12:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNpl-0002PQ-T0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:51:10 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNpk-0004S4-De
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:51:09 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1319739f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737741065; x=1738345865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rT1MOuQ+ROxukrI9hyYFsi6/FYVxGe6kUzeG59TN43o=;
 b=mP1kDJlcyX3PToWKL1JVhPehpP+k5sJ+yDKW9JIUlaL5XRZezq9DzlFBrRopgYHGQr
 xBeV6dNc9r1sxJ7G3qdj6oeNljvDBqpqA8Am+JNn8Mhh6tTyPP5zGvxrTXyeOHyQaBQQ
 i7Ls7PM/qvgXiuQj/Ri3EIfjJYo8IGBmRhCSk3wtYWRFmDG+nb4t2EwJeiqt+z7Xa2WV
 t/Kv68h9FXH6JqkOwhwzxac6lDC0ImHUFPCiyTynZK7fllrqRO2wpwzlZp/Jd5Hc21B1
 WvUbViz1nLvDx3vkrSKK+8MOXvyBZ99vn/tXgygeWzDGO3ooyhKBkIxJ8/6e2AsLxKhq
 szng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737741065; x=1738345865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rT1MOuQ+ROxukrI9hyYFsi6/FYVxGe6kUzeG59TN43o=;
 b=MDjR3xTCqcFdLq2oOad7pMjw0BF6kPYRt+6D31QQdtxVN/o+pVglZ/EmZYCn+25ntk
 VxLZHH/7nZf2PghXl1ROswnthF8yASOCKsmSOyDdAz9FbQyIjdg3G0IfMqM+BCx9YnwP
 AUKnfAtwVvIguP5SbCn8SBAb5XmqXyTWvjHu8bGXmr2cm6MmB3Y5fNtKpBRrytMK1DKE
 CILz2GqHVAUUyUvt7ei61lP+otL2OuLKTd59VSEy7sWROxGOC/8Y4ff38HyTKum/FqzH
 jWkqkmDZxSqbdZ/n4ccO7Ea4Ubu1kmmqN9dw4XaBD+s+o8/th47M6HS84vvuAPX8iDbO
 TXxg==
X-Gm-Message-State: AOJu0YxOhEfPiF/sgVMvU25HhOfO51krYqtATZoe09pTm2EgJ6ZAbpCe
 vPqCj0JdxRYWRhSR7NV52lvP5GaolvJGNMkBXVgAwwNcehgXtMiYF3SbtYEbfzb7v+8D/MIDsDn
 n/9Q=
X-Gm-Gg: ASbGncskBpQ8n/sF9v1VjHMoaksEI1ETkWKULPlh0dLa2estRZX5sdBHEHBsha0OhM9
 pzkTVIAZ5Jl0fkl/lfCHVJj/ObHK3XKqBu0oa407MrYjy73PHil/wO1Tj21N96k1UrPNFuyUigC
 6ly4q1n+/jFHr57k7+G9fX031hDq+216DFa+VCehuEBu8KRmKN11BLUzOw66gNvrSLCnGZ/6yxK
 QLaWtjjOhOxkOUSYsX4Qz6SOwM2mC2LbspdwZt9Zdz+9aq0debmvEVn/7n7+lDXpG1l+oA2NWdN
 Yp4xJ46attNoR9sxJPRerc6UpSNWmfcqXrhzURkocS7CyDD1N1Zwsag=
X-Google-Smtp-Source: AGHT+IF2DM4YNxdNQ/AzLz6jsx6RJFtgJ+ilfxDanLKp3qC1IQmfxCBCX4gcsBuH9nlCBSlYv/MC4Q==
X-Received: by 2002:a05:6000:4025:b0:38a:36a5:ff81 with SMTP id
 ffacd0b85a97d-38bf59e254bmr30134847f8f.40.1737741064841; 
 Fri, 24 Jan 2025 09:51:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764b7sm3392126f8f.10.2025.01.24.09.51.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jan 2025 09:51:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/char/sh_serial: Convert to TypeInfo
Date: Fri, 24 Jan 2025 18:50:53 +0100
Message-ID: <20250124175053.74461-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124175053.74461-1-philmd@linaro.org>
References: <20250124175053.74461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

QOM types are now registered using as TypeInfo via DEFINE_TYPES()
or type_init(). Update TYPE_SH_SERIAL, removing the empty QOM
instance_init/finalize handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/sh_serial.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 29ac9f9e5e7..b1db91656fe 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -78,10 +78,6 @@ struct SHSerialState {
     qemu_irq bri;
 };
 
-typedef struct {} SHSerialStateClass;
-
-OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
-
 static void sh_serial_clear_fifo(SHSerialState *s)
 {
     memset(s->rx_fifo, 0, SH_RX_FIFO_LENGTH);
@@ -443,14 +439,6 @@ static void sh_serial_unrealize(DeviceState *dev)
     timer_del(&s->fifo_timeout_timer);
 }
 
-static void sh_serial_init(Object *obj)
-{
-}
-
-static void sh_serial_finalize(Object *obj)
-{
-}
-
 static const Property sh_serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SHSerialState, chr),
     DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
@@ -467,3 +455,14 @@ static void sh_serial_class_init(ObjectClass *oc, void *data)
     /* Reason: part of SuperH CPU/SoC, needs to be wired up */
     dc->user_creatable = false;
 }
+
+static const TypeInfo sh_serial_types[] = {
+    {
+        .name           = TYPE_SH_SERIAL,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(SHSerialState),
+        .class_init     = sh_serial_class_init,
+    },
+};
+
+DEFINE_TYPES(sh_serial_types)
-- 
2.47.1


