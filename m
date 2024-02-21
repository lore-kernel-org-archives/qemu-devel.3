Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03173C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxX-0002OG-8n; Wed, 21 Feb 2024 16:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxH-00024Q-Sg
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxF-0000lF-C8
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4127190ad83so14251985e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550195; x=1709154995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/W4KhZI17pYbgZl7WFC76po73LZjqrV640NPiHP0AU=;
 b=Ef3iS58PtEyhd3b9O1hyyK16GzW6rWGKTN/tSxAAR4+4dgcXED+ZjXkk0D6qRPKSZD
 6O6u+6wHsCmlTClXtfyBO2rweaBc7I+3a1HTy6IL58L3S7KKhxUTGmCOIPtsLwbsqmI0
 +iCjGm9g/hZdqyzLZ6fMTDCOw4eaTOorU+hKp0bgFebQ1hCoR1aKeo1GHkaBnHRU5y4y
 R6NEiROxHfm0imU04+gIxBtBUKAOABxip+c6sMwpG+mRqBAHQ6KMPwkXbQkui4fax/Gm
 pjbEqMjO4rbLTO03aPBvTRbTY1ZRllaichNHF2XEZfr+zU2l6wPwiTx/KKYdc6a4MdUi
 gNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550195; x=1709154995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/W4KhZI17pYbgZl7WFC76po73LZjqrV640NPiHP0AU=;
 b=D4Her62nW7taTk9r/FMt3ShqOCyxujWyi1vVZVd+7WfTH3jJZ4AUdRgwnylxL5sCPi
 9+uISIPNikkHNhXJkbRbd05cW4SS6BTQdLLcLaTqAEer8pKpD8RCwA+3pwCVnbmRpOAN
 2eFgGFnlzwR5NY6pzo+2IxQY9jEJvqB7Gke/7OQVW4n721gk1u5YDHfkE1wpAqO0e0NH
 EDtMq1P04JhKd9yrVSIZ1j7wueC3Qj4oqr2WeaTeJZ2/fPIiApWwQ0Dsn9YiunJo7fd3
 ETgLSMmfOdmGwyu8b3jLskLIAM+158OdTyfEk52LFBxvBdAJCcw1XQA8WBwEkw5J1T8h
 NTKA==
X-Gm-Message-State: AOJu0YxzXmnI81SlDrttQP4CAfzvSz7EXuSBmd2zt0HKneYbJoI001oH
 kwVzc7rqzWpK9h0CE3CwUaZMxy0txXOM/FGbWEyW0q8CUYP6FFDLgDnsMh7/AWWCESmthSVpoS8
 SBzI=
X-Google-Smtp-Source: AGHT+IHziSB+3ZCtFIHyoYrNfmPQ5qWO4zVoSDUmYEhMNhvKI5zTgEHuZ0U43uJ7PFerjwQWl4q7OA==
X-Received: by 2002:a05:600c:45d3:b0:410:2d72:63b3 with SMTP id
 s19-20020a05600c45d300b004102d7263b3mr14072844wmo.23.1708550195659; 
 Wed, 21 Feb 2024 13:16:35 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a05600c281400b0041214ff06cesm19052761wmb.42.2024.02.21.13.16.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:16:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 01/25] hw/input/pckbd: Open-code i8042_setup_a20_line() wrapper
Date: Wed, 21 Feb 2024 22:16:01 +0100
Message-ID: <20240221211626.48190-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Since the named GPIO lines are a "public" interface to the device,
we can directly call qdev_connect_gpio_out_named(), making it
consistent with how the other A20 input source (port92) is wired.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Yanan Wang <wangyanan55@huawei.com>
Message-Id: <20211218130437.1516929-6-f4bug@amsat.org>
---
 include/hw/input/i8042.h | 1 -
 hw/i386/pc.c             | 3 ++-
 hw/input/pckbd.c         | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
index 9fb3f8d787..e90f008b66 100644
--- a/include/hw/input/i8042.h
+++ b/include/hw/input/i8042.h
@@ -89,7 +89,6 @@ struct MMIOKBDState {
 
 
 void i8042_isa_mouse_fake_event(ISAKBDState *isa);
-void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
 
 static inline bool i8042_present(void)
 {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 28194014f8..9cbc59665f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1195,7 +1195,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     port92 = isa_create_simple(isa_bus, TYPE_PORT92);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
-    i8042_setup_a20_line(i8042, a20_line[0]);
+    qdev_connect_gpio_out_named(DEVICE(i8042),
+                                I8042_A20_LINE, 0, a20_line[0]);
     qdev_connect_gpio_out_named(DEVICE(port92),
                                 PORT92_A20_LINE, 0, a20_line[1]);
     g_free(a20_line);
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 90a4d9eb40..74f10b640f 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -777,11 +777,6 @@ void i8042_isa_mouse_fake_event(ISAKBDState *isa)
     ps2_mouse_fake_event(&s->ps2mouse);
 }
 
-void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out)
-{
-    qdev_connect_gpio_out_named(DEVICE(dev), I8042_A20_LINE, 0, a20_out);
-}
-
 static const VMStateDescription vmstate_kbd_isa = {
     .name = "pckbd",
     .version_id = 3,
-- 
2.41.0


