Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C54C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8PG-0001fW-Cb; Wed, 30 Apr 2025 10:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Oi-0001Hp-FU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:27:01 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Og-00077b-CZ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:51 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c59e7039eeso1002332985a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023209; x=1746628009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/F9wfO6J1RL2avC/Q42x6BrmpISj7RT0yS78rOyo2P0=;
 b=XJXNs4g4/CECHEBVM94ehfMQKXmcE+Sn2jz7SrpxonivDIN/DwCbjAgZv38YRPmGPM
 j8m1m/A88SDGi2/XXxRPWuxjiqqf5sdnPIHQoc7jMSCSDY3dT7KoGhDUYStpZeMzrsJZ
 1t0pH6+YyOZVVbaqKTchicolgKnYGnL7g8zDBNqHQpSCWoc8p8IBylcyhuvHLfQ83MEh
 YIunNBlvbf8oTVdniKqeFTBcCxzX6HPLkXaj4Xn7xKuwZcxu/wRGqvSyU87aHBsa2hGn
 ENbwgW65e8CJ9BwHpl33uyrT9xZWiD5lZdVu+Ucr2hG23xk1SxnnkE1a4WQ6E9RrG0tm
 J+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023209; x=1746628009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/F9wfO6J1RL2avC/Q42x6BrmpISj7RT0yS78rOyo2P0=;
 b=lJHv6Wx+bkQ1O3zJy/wrLsIE+lOxiz/e8T14yuc9buKX8kd+lTk49f+15Ypgd/5Pg7
 OC5qmPtYaRDRzBMNLZMX6fMectOCNeyEcsd8T1+ugY1Z/Vew32MJq7qjUhnObq3DopGT
 FBT7SxE/fXF0hCPUU7SQoZisjlO77YTj8Ttvs9n9MrOu3Ku6BGqcMjupmQAl7ZxJrh5x
 6fyjkxlOXxq5Vm3Y+GPDeCbXzayVcKpV4MR08a46XOUuQoTkRqgCRgPoZZaLHjffrpDe
 r6WSkQLBjY1A8hbwTsttHDCT27RHZ/LEOpRWScTR3SzRp7cFUjU2sC53Y9rBzq1JOAlD
 vHQQ==
X-Gm-Message-State: AOJu0Yyrgzz06EEVasffm42ujor0v6i8tC3PqMl+wxwzimS9vvU9Udqu
 2pDxvKZW0/v4aHcn+Mtfi7omETf6KDvlJD3zdz4MLr2m50WgBAKr1bKKazgmhtaKoyVq8C8eRud
 b
X-Gm-Gg: ASbGnct5tZJPaaVyeYZOF17d8RdAstMRTwPYtzKGWULZz25tDKAeLf+VsZLb9/NpsTr
 +jA3crnpfA+f0qmT6ZFoo8Y6YYhiw3tE1QVyhXKaV1Rqq1kPGRwwyJC2pPBpTJU/nG4nTTjXV0E
 Bfnl3npUC30PGWrOmEnrrCKgMctId8dOJWvCmrc65xeP8OwxzrO1l1LPvA129e6pBir7HBVwxuS
 PZOFDM/3EnB3iiWGxGSfI8KYpysBAwCKZHfKO1irCkW7z1QlFUs39pbp0d4vH+H8S02L4yVeIpu
 cLaH43oxn2w1dQcvlEBjlUVfBjDCJvwl3UhTrzG3FfxbH2PXSr4aijp6ENbDKeCdciM6xO5n9GN
 /r9I1AEAAwYVIQOg=
X-Google-Smtp-Source: AGHT+IFqPmViPI8ZLkvIpLS6jt3iZWrfxPdPn84yKAspncRjN6+049kTsMquJO0Yf015bGfczBf/zw==
X-Received: by 2002:a05:620a:29d3:b0:7c5:a2f8:e6e4 with SMTP id
 af79cd13be357-7cac7e1db3amr389000785a.29.1746023208843; 
 Wed, 30 Apr 2025 07:26:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958cbe447sm861896785a.46.2025.04.30.07.26.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 07:26:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
Date: Wed, 30 Apr 2025 16:26:08 +0200
Message-ID: <20250430142609.84134-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430142609.84134-1-philmd@linaro.org>
References: <20250430142609.84134-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x736.google.com
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

The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
in the hw_compat_2_7[] array, via the 'emergency-write=off'
property. We removed all machines using that array, lets remove
that property. All instances have this feature bit set and
it can not be disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/virtio-serial-bus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index eb79f5258b6..31bd1b7535d 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1019,6 +1019,13 @@ static void virtser_port_device_unrealize(DeviceState *dev)
     }
 }
 
+static void virtio_serial_instance_init(Object *obj)
+{
+    VirtIOSerial *vser = VIRTIO_SERIAL(obj);
+
+    vser->host_features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
+}
+
 static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1155,8 +1162,6 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
-    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
-                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
@@ -1186,6 +1191,7 @@ static void virtio_serial_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo virtio_device_info = {
     .name = TYPE_VIRTIO_SERIAL,
     .parent = TYPE_VIRTIO_DEVICE,
+    .instance_init = virtio_serial_instance_init,
     .instance_size = sizeof(VirtIOSerial),
     .class_init = virtio_serial_class_init,
     .interfaces = (const InterfaceInfo[]) {
-- 
2.47.1


