Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579A1E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIsJ-0005XP-M9; Fri, 10 Jan 2025 12:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWIsC-0005Uh-6I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:32:40 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWIs9-00009h-Hc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:32:39 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so1253880f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736530349; x=1737135149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNUbs9+iXWkzUulkoWT20NOwr2Ic+DqflysU5aQWhXA=;
 b=tf+HYap5+HB+/KwX4SpcqsiV4RcJuKbfz3pZ6nu0W4GG7VzkwZkRggcUj3l6SOb00x
 KwidAFpXlqITHqK9nZ/MDKfiRIQNoQCREUzfxAECGINdkURAcFIv1cIIw9en+gyprnxL
 kOJkrThWUJLzbTVxvaUaOXp3IfTifnb/EYilRPuOl5C50qfqTZ1plyhU/EIkVTeklNE2
 ivR4beRuLx88AzD1Ni4YMMlmm8QM0mm8H4SqVAOm8O457g2yb5coUYoSgwBUENANbfGO
 oc95WPYKmHS1V7ltolulZzgJRwSaBmwHpRvWRaDkrMgNbWHLobv9n6OcMTGg+x6Nh+jx
 MpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736530349; x=1737135149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nNUbs9+iXWkzUulkoWT20NOwr2Ic+DqflysU5aQWhXA=;
 b=kWB2Iq+1BZPdpiu+9kg3XlSDnUFkGijE8KR3Ldmhs9K8cRanzYWTjFaRWjSRb5zXF6
 MwCZKGKMSPNj/hw55yF1shCOak3qoW1++CS8Ov9jY7WilYCHJtWSVRmou3x9ljP5Tvr0
 JahswS6l5TDrcep4HIlaJOlmuougQZp+8VyovR6VZFuZCthj84z2OE7/TPKdVK07GTxQ
 arGv40zxmOnYaLji0GO4b73BFeaXXogO7uurRt4GLmdr6sc3g0pc2eys/7iue77H4xfZ
 Eb7dmTRD3XHv8rtPULbxCSmySFFjD1X53RiCKYG7uXI/JsSuycCbP90jvasYRS2tRNYh
 x8qg==
X-Gm-Message-State: AOJu0YypKw2ZXE/nvY6HumOg9LwvH74+WOceNXR9MNzT89DrqtHtky1v
 Y3kqVqI0ieV6BNFcCgcleyqeKa5AnfejnYeDqgzWexeYT2oGWNYa+n2IaL4L0kNU3BumB+kP73V
 X6t4=
X-Gm-Gg: ASbGncsAsHnJ0sEk1M+oJE8l1QS/Wx0ZYtNY4ZVPSjn5wEG+I9Ad8XRs+7hP5j9bKwl
 E0UZHGKn3mXVY2GQExGJB8PU00Fb5iS/szzHWg9V4xuOHpp4V2M02fWM4oMaQRz4YbZQNSrT4tX
 PbYfOAMrqACdf/MKKSHokhqyqAjL7TtIum/HoToQaKOZhlw2oOiugqQvqr3+yP6dBrOVDIbhMDm
 YT4ekAZV1BxgQm2nLfxcKS9i/teHjaLsiCfqsAm66ddG4QRx4XvnShJ9U5O1FPFuhpvDVB3qs0F
 DYvZ+rsGcFwunNCLBiA+rSfX3yszQ1U=
X-Google-Smtp-Source: AGHT+IFBRXvmojeptjmFxNDaZBsmcfZm9vpZbKLnZyyLe+xdmiUQVmnsCSYyaV7mq2cY3LTGdXyAIA==
X-Received: by 2002:a5d:6c63:0:b0:385:e22e:288f with SMTP id
 ffacd0b85a97d-38a872ea33fmr11189484f8f.31.1736530348711; 
 Fri, 10 Jan 2025 09:32:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383654sm5134100f8f.30.2025.01.10.09.32.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 09:32:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/ppc/prep_systemio: Set IOMap IRQ in ResetExit() handler
Date: Fri, 10 Jan 2025 18:32:17 +0100
Message-ID: <20250110173217.80942-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110173217.80942-1-philmd@linaro.org>
References: <20250110173217.80942-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since the IOMap output IRQ is created in prep_systemio_realize(),
it can not yet be wired before the device is realized, thus
it is not reset properly. Fix by moving the qemu_set_irq() call
in the ResetExit handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/prep_systemio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 7cbf7e4eecd..87f412891e2 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -260,8 +260,6 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
     s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
-    qemu_set_irq(s->non_contiguous_io_map_irq,
-                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
     s->softreset_irq = qdev_get_gpio_in(DEVICE(s->cpu), PPC6xx_INPUT_HRESET);
 
     isa_register_portio_list(isa, &s->portio, 0x0, ppc_io800_port_list, s,
@@ -273,6 +271,14 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
                                 &s->ppc_parity_mem);
 }
 
+static void prep_systemio_reset_exit(Object *obj, ResetType type)
+{
+    PrepSystemIoState *s = PREP_SYSTEMIO(obj);
+
+    qemu_set_irq(s->non_contiguous_io_map_irq,
+                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
+}
+
 static const VMStateDescription vmstate_prep_systemio = {
     .name = "prep_systemio",
     .version_id = 1,
@@ -295,10 +301,12 @@ static const Property prep_systemio_properties[] = {
 static void prep_systemio_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = prep_systemio_realize;
     dc->vmsd = &vmstate_prep_systemio;
     device_class_set_props(dc, prep_systemio_properties);
+    rc->phases.exit = prep_systemio_reset_exit;
 }
 
 static const TypeInfo prep_systemio800_info = {
-- 
2.47.1


