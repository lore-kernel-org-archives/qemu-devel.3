Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3453EEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMnG-00015M-89; Sun, 08 Mar 2026 18:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMnF-00013N-12
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:40:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMnD-00042V-0y
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:40:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso5450723f8f.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009609; x=1773614409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vi22zdaCk2LuAhPhd6uA58Ohth+YuI+ifJV1zGOLiuk=;
 b=vHO20rK7Yu18qr33qERLJmQinTkmf58jqAbfvBr/2hlg5fuekXG/n5gL0SQgG9qsA3
 8GnmeKaKr6WS85l4ft80ohlHP/rhaREHrXO7exExANF5rlz3K8HoQryJUFvHW7UhtSsM
 TIpo1RYrJvzHvTCnheNA8lXbC+7KHfO6yJayqjKrg81dBFO29V37Mpw4SvfkO15wT+Cy
 vqAYqhck43O18GTqOEV4T51YJxFV/+jUn/G224bIZGuGgzLFjP6IMWxx9S9YnurkWjcm
 7lRFCFgzLY4ChrdA6tbaK5uncEAwgUQb7vcOd8gS5L6nHS0LbwPXlzUk12o4jo2nDWYu
 NUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009609; x=1773614409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vi22zdaCk2LuAhPhd6uA58Ohth+YuI+ifJV1zGOLiuk=;
 b=wNAwmSyPwZ+ybkYCKMk4jzwGUB/88bJ8POUPPATLO2Hk8oNK+Z6r/ymjKq+Xj/0dxr
 IVuM/oAV30BkjzLu6A/XvT+/EMmp8NR0VYHmGpWeLf4gaJYwyU0mNf/Fi0KV69ekIkL+
 paf61zYjmYDUrVav/TrFvMR1KyzhWWC9smTOpQFElvuY9pFMdAHQ77CAcYcAYaFy5JEA
 Uhq/610Mklmf66tWxTZC49YSzogBFWvlQlG+uHU62QrLfDLsAGHqvqOCrmdrYwzYdo0V
 mceQTixuRDrXw2noJgrbmStASIvZHXyclvNVxe0VPXZcgcIo9pKhKE0oEOYshaK0CR83
 CzDg==
X-Gm-Message-State: AOJu0YyS51uI05lqv37Z9VU/EUxTo98+QjXLEIo/K+PabdwPJ9DtSIlj
 BXXkuSTZU/VFMDhhw8fZrXl3BC+TOHl2I2M0tdhHVIY+5MKy46JsWSsQvHXZG7gZ/+qObbUz+6r
 ecg4EMjk=
X-Gm-Gg: ATEYQzzJJvyYTxyq10hhqOHHNeHniqB/L45T7dTs0p3atbTZV70IG5iaDsbqPnLPOdm
 NFNBLmTvmwXmp9Lx3sZroXSRH+jGCapwxqvSUVkIzNrHd0DPSHar+FrSYCk2g470XDK6JiLegjl
 X+XMsZWfkptDzZHh8cZ85eJblQAprMG8p5+fhCgyZL/UUGPfm3sTrNGFVj6VlZeaBYEStJI3DOt
 PWzssTrjv29uPrrzQAL+ieyDRIveOoB7/BrxdtRFlJQ8uJJTYwAGWmL9rgD0urCGDT6pMxBF+L+
 b0QfESFemavA3InuJ4L0YndLj/wWVGRJRK+iEiuhEICAkOWnlbzOihiCVS2Y7E37u17E5zgli9B
 Upy7LUGkMzP963DaypaGdIg3S+7YIuRMMtdcso2f1norktrrKJimp0KqhUKTLZwa7uJoTftqax9
 V8/pX0Ff6TqA2kPZ/cxbsRVlvjIN6TrTkpTjIVmxqn+3BuTtGIsTSK1o47EXylB3W7LI6daHiO+
 fTUsQ==
X-Received: by 2002:a05:6000:3113:b0:439:ba75:7db7 with SMTP id
 ffacd0b85a97d-439da555428mr15016841f8f.7.1773009609197; 
 Sun, 08 Mar 2026 15:40:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm19858880f8f.27.2026.03.08.15.40.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:40:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/49] hw/char: Drop disable property of Diva GSP card
Date: Sun,  8 Mar 2026 23:34:33 +0100
Message-ID: <20260308223433.25503-50-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The "disable" property is not used, so drop it.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Message-ID: <20260307195243.8813-3-deller@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/diva-gsp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index f9aa6e326d6..53fd0fe2a13 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -51,7 +51,6 @@ typedef struct PCIDivaSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
-    bool         disable;
 } PCIDivaSerialState;
 
 static void diva_pci_exit(PCIDevice *dev)
@@ -159,20 +158,18 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
 
 static const VMStateDescription vmstate_pci_diva = {
     .name = "pci-diva-serial",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIDivaSerialState),
         VMSTATE_STRUCT_ARRAY(state, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS,
                              0, vmstate_serial, SerialState),
         VMSTATE_UINT32_ARRAY(level, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS),
-        VMSTATE_BOOL(disable, PCIDivaSerialState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static const Property diva_serial_properties[] = {
-    DEFINE_PROP_BOOL("disable",  PCIDivaSerialState, disable, false),
     DEFINE_PROP_CHR("chardev1",  PCIDivaSerialState, state[0].chr),
     DEFINE_PROP_CHR("chardev2",  PCIDivaSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIDivaSerialState, state[2].chr),
-- 
2.53.0


