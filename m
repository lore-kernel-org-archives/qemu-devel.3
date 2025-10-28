Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28919CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDej0-0000is-1S; Tue, 28 Oct 2025 04:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeiK-0008M3-5R
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:05:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeiD-000193-M4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:05:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso3959115f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638733; x=1762243533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLNTJJ29Ee3X1iQPo0J9sRKYXDME7PYcE1MlaahJ0F8=;
 b=NmbsCkdFO1bIXmdJPZU5bZmPxgf5ssytzFLmJLBu+iAO8MQO8Euwm1fpl0FSv2MkhR
 jVUuPj97s9f+Lq7Waz2GWX5rrBTYr0Pord70qhHz6verIv0VuR9M5XIzNC9P5V2MXWhg
 9WS50bMnqQQ7OCZ//b5YytlMQ2bo8CQnnTdnTKWIymkU4zovi1f9aRBY7YVjjbHQLJfZ
 GpEZHNOzEpuKzhyuAznsOIh7InZtsUkccwWDeiQrczi/7oVbxvHiH48csvARNMOUhDvU
 vAK3c/Qj+bHA5ff6d2nI5X6857bQEvPHlFsJnJFgN3yAs5cyFzOINwErkw1cZnsJ9OpA
 b9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638733; x=1762243533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLNTJJ29Ee3X1iQPo0J9sRKYXDME7PYcE1MlaahJ0F8=;
 b=qfqHBG0UBvrJexfwZBR8TaIbqWbFL6d72dbJtJzTA6DPwcCedPartFXzCzjt8wtMjG
 8vlEqj6l0jA3nigJdKoR46c8E2bWWrKcuV+Qy+EzZHUi3/yA3GbICCFtUmWWre9cD1lx
 0aehzvvV5DxUKJF/02VJ1j3a12AM1/g+McMujoUpCqiSBnH0gPGGxQ9CAWGbah3sfCLr
 Ai+GabvOWYuy916VZ8Nu/B/NhExdvw1m6CLnQ6A9U4LO5QdJUSh6jjLeYVtmMOk09XTr
 znkuJ9SyjBGRfPIKkI67sQguNnNhNqPRMjKId3GIZtGOIUJJJhPa7bn48G35wADYBr26
 QKNg==
X-Gm-Message-State: AOJu0YwqoT3bq7tFeQxQypdnD1ac6sOb7yFK8h/f/UoOU8wPXJha4pU/
 ZpT0b3xRzcihS0wH61G4y0aYPTaweuJSZiryRKUiYFDMq/n8ASKFM7RG2LF8Hpoo/bwZ6N5cTwO
 mRJYh9YI=
X-Gm-Gg: ASbGncteaZ8NsEjEi1GbAh0kRISTOsQmz7z8u/mUeMv7JkJPmhgpcp5zOxZPJa8PRaR
 2Fyvrjj/KyDtWhs/1Gzp8Li4PJxCkfXX6etJo5MGLH395uxHgFTP09djiYZj3KnlocFF5OdrF/2
 NDUXMNSeZ+G/+IMIRO8nwlNy+mo+8pJmJ+j+1gyfWwZ/H2UrLepbJCDRPiKgd4FKjigf0wJe8Xo
 r7AweMDJlL4ipP0lTOcEYU4CJIZYoJvSFAPrbLx3KECNVCVTZEvhSkGXvUlqhGnwVklRCrGX6Vs
 zWsdSxfsxb9U3uGRBUmn7SOfc5YTM7maazme0cHognYZx//bEj3HNJKWZyhLWDg6KBZMvVA2s8n
 NqbATDpNwSQ4HlIQuDKteENcJmsrYTkmrQJM0YsEkb2h1Yf/YXVnGXmyOXjCmRgPjKlyO/nGdx6
 BBv+hEglYH09ztCNwJNl1ZkqRzzuxthowpYgYrlgTP7ALg2ub8ddKrztCoUt6CnrFwUg==
X-Google-Smtp-Source: AGHT+IHTV9tfboutLKGYM3eTyb+CR5VW0SOflc97As9XGisSmavfqFO11jtskHLKrFhaWBMZ+mW0Jw==
X-Received: by 2002:a05:6000:40d9:b0:427:665:e37f with SMTP id
 ffacd0b85a97d-429a7e36fe9mr1801485f8f.4.1761638733488; 
 Tue, 28 Oct 2025 01:05:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952da12dsm19103620f8f.29.2025.10.28.01.05.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 01:05:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 7/7] hw/pci-bridge/pci_expander_bridge: Use proper SysBus
 accessors
Date: Tue, 28 Oct 2025 09:02:57 +0100
Message-ID: <20251028080258.23309-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028080258.23309-1-philmd@linaro.org>
References: <20251028080258.23309-1-philmd@linaro.org>
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

SysBusDevice::mmio[] is kind of internal. Use the proper
sysbus_mmio_get_region() accessor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-bridge/pci_expander_bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4d..b4e2c95ae4c 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -157,9 +157,9 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
     main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
     main_host_sbd = SYS_BUS_DEVICE(main_host);
 
-    if (main_host_sbd->num_mmio > 0) {
-        return g_strdup_printf(HWADDR_FMT_plx ",%x",
-                               main_host_sbd->mmio[0].addr, position + 1);
+    if (sysbus_has_mmio(main_host_sbd, 0)) {
+        MemoryRegion *mr = sysbus_mmio_get_region(main_host_sbd, 0);
+        return g_strdup_printf(HWADDR_FMT_plx ",%x", mr->addr, position + 1);
     }
     if (main_host_sbd->num_pio > 0) {
         return g_strdup_printf("i%04x,%x",
-- 
2.51.0


