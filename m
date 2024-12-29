Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76C6E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnh6-0006TU-7c; Sun, 29 Dec 2024 02:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRngz-0006Sc-Vz
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:30 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRngy-00026c-CR
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:29 -0500
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso766586666b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457187; x=1736061987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAtx5jrlA9KZeccpdqCh6rBdfWSP4VBSS5wQmXaUrf4=;
 b=FuTJX/NSrLQQ1RbikITnI5M+wZywnCKZ+M0iU11jH1wfggFPhE7Ss7VXuAqXeNfvZp
 vzYgLMA0X27JV88XQu2HDBrHl/ZfSEy0gTPl6m7BA37EosB64SEjMCLFlqRAf16ebwEf
 VLpW6k1aUS326/INQSj7KtnUOphmaxvWeyXwv9uAoW+oZLqB9N7o8wADm20jspeShS1b
 kC8VTStLezZXysJLvywuafTFReClS++6zc3zZ1u3IzuNey5BlZ7IqC7hzwRRSwmchnax
 FV0IWp5iijKvr2QhblN9c4BmwRiSfOG8/ZPu/XWN7bh13/Q6fz7kz3b/eZu6dFwbCWAF
 TZsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvXL0F/x8EzXNfUdNmyhv3vc+GVqtUyHMBUIoYWxBpoTg/qyT3rlcdX36+iyPlTjHv2H39LnkSJVEN@nongnu.org
X-Gm-Message-State: AOJu0YylgAnIveAMsMret4mgtAJVlHoKhc1/x9t1c829O5QEDalHlXXj
 FAJckBt/lPJZKWEYu/OeguUSokq24MWHEekd0C+wrS4XWWkEWhfmOTSXXg==
X-Gm-Gg: ASbGnctTV8RirMmy/P6Q0RyOsW5snWonMLti1FNiOo3GaDErDyFkEwvrTy5+ooWhmYB
 VnI2xt1VfR6tgrcWJYWXjYjgUlmmn2A4cN3NBJKrmdZwEgXSMIj6VBVCKBC+T8TzxADOIc9+beE
 PVKHI3QJxHcykACo0+UupeLoUJIuftrzGtKLNMf7y5rm4mTv479wYLwLXlzsHGp1jZIohvqBqkG
 a+jG67If9I4M/uS4yuXCFRFMrq5oIHPfJlYy/fllnK9dwcbUkSSSjPxa4OUjW1Efm7xwJWmj6gz
 o7Y=
X-Google-Smtp-Source: AGHT+IF9uhpuvCwWKUdIhPoHRQfwSQwZsc1LWgTIExMDJJd73hVf5fqLjVx1KQxz1uIDtqZX2eaIfA==
X-Received: by 2002:a17:907:2d8b:b0:aa6:6e41:ea53 with SMTP id
 a640c23a62f3a-aac271316a3mr3208956766b.7.1735457186535; 
 Sat, 28 Dec 2024 23:26:26 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:25 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 01/35] hw/m68k: Mark devices as big-endian
Date: Sun, 29 Dec 2024 08:24:52 +0100
Message-ID: <20241229072526.166555-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.49; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f49.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

These devices are only used by the M68K target, which is only
built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241106184612.71897-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5206.c  | 2 +-
 hw/m68k/mcf5208.c  | 6 +++---
 hw/m68k/mcf_intc.c | 2 +-
 hw/m68k/next-kbd.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index ef619cb9a4..c22e615f7a 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -582,7 +582,7 @@ static const MemoryRegionOps m5206_mbar_ops = {
     .write = m5206_mbar_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index f290ccc739..409bb72574 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -155,7 +155,7 @@ static uint64_t m5208_timer_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_timer_ops = {
     .read = m5208_timer_read,
     .write = m5208_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
@@ -192,7 +192,7 @@ static void m5208_sys_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_sys_ops = {
     .read = m5208_sys_read,
     .write = m5208_sys_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static uint64_t m5208_rcm_read(void *opaque, hwaddr addr,
@@ -224,7 +224,7 @@ static void m5208_rcm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_rcm_ops = {
     .read = m5208_rcm_read,
     .write = m5208_rcm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 008626f813..7b9213947d 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -166,7 +166,7 @@ static void mcf_intc_reset(DeviceState *dev)
 static const MemoryRegionOps mcf_intc_ops = {
     .read = mcf_intc_read,
     .write = mcf_intc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void mcf_intc_instance_init(Object *obj)
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index dacc26413f..68b17786b2 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -162,7 +162,7 @@ static const MemoryRegionOps kbd_ops = {
     .write = kbd_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static const int qcode_to_nextkbd_keycode[] = {
-- 
2.47.1


