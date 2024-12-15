Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33179E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwV-0001Ka-Bw; Sun, 15 Dec 2024 14:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwR-0001Iq-PP
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:11 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwO-00016P-Hi
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:11 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so2494536fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289567; x=1734894367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmMi/xuqJ4zahJFECv1RiZkhOgP/JH9kb/vELILAgfs=;
 b=Pg90uEjLJhJxN+rlFFyL45ONSMrj3vQ+IGIjvLSe0wRxpAYbFxDHG4UUG2csEJdee1
 x3oYOfCMmVH87fYqHl6sh68kwWOlSdZa+Kk3RwJ9WGWcxiirSyaNUVMt3DQJy5dh36qM
 90fcj75ZveKwUDDVG3dHObVxXAQ37bshHMOYFYinbKT96T8HCekx+8M6IY/y2XHblTmQ
 GAcupm95ywSnB+j/kYn53Axwg++4LlThJWrKusYsvSXQyxbHotegL6VypGLEIgEKBFBO
 Ox41La7l5MuyRqnnssi1tnTRPuMzp2YlYzumSf07Wu9DvYhEtP+10H5cQgn1JNt0lNxG
 a/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289567; x=1734894367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmMi/xuqJ4zahJFECv1RiZkhOgP/JH9kb/vELILAgfs=;
 b=Z+EfJu+uoPuZT07HRuh1BIRRxTdkV+uKIuqMwT+peIRwGs5I85FvxbZH7t7oX6jXPH
 /0fadknr2ufOihh+EK2lpFpKdD6ysWkkBc/nUd1rPHYRhlZQPNhGhhKtIjqnf9jqzfL3
 4xK5DGtu5w299h7IDShHEeJBfP8LWSmLq+YdwwZWRpuKjMxu2CvhEAfZovHA0QN+8nLr
 PrhL0xrQYDeXk2HlsQr4lU/FkUrwhmZiZuMnSr5V08MJxA/AQ2iaS4EIdUiTyFjjwdEc
 l/qwTB4Ou/EUZTEQur6p7tDAoFI6A8uUipB4sy3kLhiwtFcGUusXGoDWraaEYg4f7z+Z
 Tkjw==
X-Gm-Message-State: AOJu0YxvOrjYrp+E6LKpm1VAryLCe5f02Nq4kz9nPajd3L/4ptbDTNXU
 k/ofBN0YnjdlnOtXTQgm6N6FMhYuX7/86YhjdvOig0KpB/llHbUOEIU+f99ECP0ozucEZLXIRdh
 19rYcdb6K
X-Gm-Gg: ASbGncvcwnLz2thnKWdbt2WTZkk4yVzUlkqIC9m05xHTQs87GP54JSsanxg7hgqcglb
 x/sl1IHGG6BRrN6CtUWVMQD6mIwnODumINC8O97kW8DpgMj8AZ+qlOgX613e9lVDRGbRuAWFRK7
 uXeuCO6HH5PfUbJNQAxrXXFTRBHxaFHtl29Ny9+IvW0VXS0TFeS4DmXEZMWuOiyf0CKKhCa4Clg
 1PKCQBVgYvDOWpT+0beNs6Unc6/Sub7CXOBeknzR0qlW5QRCIxkJJ4u1M+DgS+392JekrbYcUdb
 CLJpA4Ub4WJTU90JBZH/iGSJU6Py4Mchiu12yNCGci8=
X-Google-Smtp-Source: AGHT+IHiCQu6sjwm4Y9ry9LkmVThzBIfIM4bCMN67wfuzkimYtLH884ZzmJBepXgel3dvQh8+ow1yA==
X-Received: by 2002:a05:6870:a10c:b0:29e:27bd:69ef with SMTP id
 586e51a60fabf-2a3ac8b7813mr5401873fac.30.1734289567558; 
 Sun, 15 Dec 2024 11:06:07 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/67] hw/core: Constify all Property
Date: Sun, 15 Dec 2024 13:04:46 -0600
Message-ID: <20241215190533.3222854-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/generic-loader.c | 2 +-
 hw/core/guest-loader.c   | 2 +-
 hw/core/or-irq.c         | 2 +-
 hw/core/platform-bus.c   | 2 +-
 hw/core/split-irq.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index ea8628b892..c1cddecf60 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -179,7 +179,7 @@ static void generic_loader_unrealize(DeviceState *dev)
     qemu_unregister_reset(generic_loader_reset, dev);
 }
 
-static Property generic_loader_props[] = {
+static const Property generic_loader_props[] = {
     DEFINE_PROP_UINT64("addr", GenericLoaderState, addr, 0),
     DEFINE_PROP_UINT64("data", GenericLoaderState, data, 0),
     DEFINE_PROP_UINT8("data-len", GenericLoaderState, data_len, 0),
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 391c875a29..74af00cee7 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -111,7 +111,7 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
     loader_insert_platform_data(s, size, errp);
 }
 
-static Property guest_loader_props[] = {
+static const Property guest_loader_props[] = {
     DEFINE_PROP_UINT64("addr", GuestLoaderState, addr, 0),
     DEFINE_PROP_STRING("kernel", GuestLoaderState, kernel),
     DEFINE_PROP_STRING("bootargs", GuestLoaderState, args),
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index b25468e38a..fc52796f54 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -115,7 +115,7 @@ static const VMStateDescription vmstate_or_irq = {
     },
 };
 
-static Property or_irq_properties[] = {
+static const Property or_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", OrIRQState, num_lines, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index dc58bf505a..a29c9c6e59 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -204,7 +204,7 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
     plaform_bus_refresh_irqs(pbus);
 }
 
-static Property platform_bus_properties[] = {
+static const Property platform_bus_properties[] = {
     DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
     DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index 3b90af2e8f..40fc7e2e77 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -59,7 +59,7 @@ static void split_irq_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->out_irq, s->num_lines);
 }
 
-static Property split_irq_properties[] = {
+static const Property split_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", SplitIRQ, num_lines, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


