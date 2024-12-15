Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37629E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtx6-0002AW-AV; Sun, 15 Dec 2024 14:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwk-0001Z5-Ie
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:30 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwi-0001GL-O8
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:30 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5f2e2608681so1684308eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289586; x=1734894386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ECW39NRqpfZ/PTyPriCYZSRdWHi5xzzMmZM9BZOJCk=;
 b=dC9rJAoR4xIpGIImMB/rUoDvTJsn4zH+rcrPbEoR5Vkc8qAS4oKvFxFGr3HUZLZ6KQ
 BDk57+TFqNQ+gjmmqSs7QfBWrEa2KPd0UaO/brWuy4GX5jRqM2sGzqPOTu/zluFzOgay
 MeuqHb8ysDUn/QcB/YKvcg7H3RnTdSrzmrLRWQbo3Oiz6M0eVaeSwtDx+c8gZIXM290q
 EIl8T0J5oVgpvrwIQ+mf3dEulB3ekCjJDdVQqs123mDfiEBGVYoFPdJC97tnX4G9rI+Y
 EP0adBUDKQd5f1Nevo1Mh1MZCquAgczyKiWwUOtqecIjd7dNLzViTbN58qr4ZCPr8fR9
 8wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289586; x=1734894386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ECW39NRqpfZ/PTyPriCYZSRdWHi5xzzMmZM9BZOJCk=;
 b=YuW+Rzsi/tO/xaiQsj+KwXuWqO23rm07is6+1WozeqXsmclIR8EJuLR8iri0vhIGcq
 gxVhK6FJhmSwNMqQMy1bv5v8O8C1XJFA2Az590KHU5BVZ2xXkarIBo2E1X/7d8u46lXF
 xsWYoq2zqxYi8beCYL4+7aaxuvuaFoiCWe41dIq0+6sYEB4cjmbgbqdlJA6PlCgPy+Cr
 JTFAmTWGqyavK+IpmpbPrQMkKCui/NpdQHRxwvTGIyX/hPboXWAFtgtFFS9yOqtxnYoZ
 54LPDAJbOiGLJMRN2M62scozycgOLr0LkwbwAkfEVUi59DFCuWHHRjGlFjFHATWIbAGp
 qAkw==
X-Gm-Message-State: AOJu0YyhUkSilDxT8Bgcrmva8r5S7bWgJkohTfHy5gImcslddj9GyCCl
 eAFJlDk55SCewQzN+zwAPJgSKRZlu9+JynOzh4Qm0AQbJfu7NN34zg1Stlq6HNgqpZ9FpM12WKn
 SwKVZTs0c
X-Gm-Gg: ASbGncscBv2Rk+9jQSys5RtuuOYaiQegf/MD4eaDvhl3BfomlUS3Ua+cuE7F7KzFIlS
 S9UjVaZznq2LKAIazC8XlRkqO+8y/eRj4+SZENSZC31H3zatJPjrjPI1rM3bDVuUQl6tvZlcO0t
 ORg3aP5V6K0bUs/6zINus3coPPbbeUSw9r2/XEq6Pp7h9Dp63YnhkC4swBTczPJjQ6Pb0Y1lkw9
 0jBXPYUyd27z4GSGeZjquPpsBn0hah+GKyTiKVL2s5EjaQmmH8AhKvwVAEyPBnd7khEqedgBZV8
 YZmG1Cs6hntlkIxfjmyuJdRRMNd7xjtl3/N+m4PYuBY=
X-Google-Smtp-Source: AGHT+IH2hTaEOBrh61FJ8UoPd8ZEa2UrcfXEvROJsOyIYUUp0OyodvKHyHny/+bqAXpW26qKHbCryA==
X-Received: by 2002:a05:6870:8a10:b0:29e:8068:e089 with SMTP id
 586e51a60fabf-2a3ac7285demr5901565fac.19.1734289586753; 
 Sun, 15 Dec 2024 11:06:26 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/67] hw/m68k: Constify all Property
Date: Sun, 15 Dec 2024 13:05:01 -0600
Message-ID: <20241215190533.3222854-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/m68k/mcf5206.c   | 2 +-
 hw/m68k/mcf_intc.c  | 2 +-
 hw/m68k/next-cube.c | 2 +-
 hw/m68k/q800-glue.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 7247cdbe5e..45e5f74600 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -600,7 +600,7 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
 }
 
-static Property mcf5206_mbar_properties[] = {
+static const Property mcf5206_mbar_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", m5206_mbar_state, cpu,
                      TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 9fc30b03ba..c24b0b715d 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -177,7 +177,7 @@ static void mcf_intc_instance_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
-static Property mcf_intc_properties[] = {
+static const Property mcf_intc_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", mcf_intc_state, cpu,
                      TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 08886d432c..a37ce00874 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -914,7 +914,7 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
  * this cpu link property and could instead provide outbound IRQ lines
  * that the board could wire up to the CPU.
  */
-static Property next_pc_properties[] = {
+static const Property next_pc_properties[] = {
     DEFINE_PROP_LINK("cpu", NeXTPC, cpu, TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index e2ae7c3201..0d8cb8b1cb 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -203,7 +203,7 @@ static const VMStateDescription vmstate_glue = {
  * this cpu link property and could instead provide outbound IRQ lines
  * that the board could wire up to the CPU.
  */
-static Property glue_properties[] = {
+static const Property glue_properties[] = {
     DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


