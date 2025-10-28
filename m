Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5D4CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoIK-0003OW-Dq; Tue, 28 Oct 2025 14:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoI3-0003Ip-IO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:19:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoHy-0002KR-KV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:19:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so35412895e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675557; x=1762280357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUj5tDuFxMrJLcMfMzba2XS192smTgWQLL5DdnxIsIc=;
 b=IuhRkrFVs+vVgPzP0yd83rXBTD1ivBFPi7bpG7j9cmaTAfYd2oSrfLpkNhO/EJ0GY3
 nmgJcOqeJkmZ+kf9dE6QiVRg/mOOBUqaD33YUbAgMND2DapTwePLYxqK2Bclq9ieag8c
 Rj3M0WNTQHdrhajYg4zTBn6Rly9BqQ5zomqzL9WJUDqgdqSba+nq/iY9UnCNCHsu0t2j
 H6Q83GGKjajqL5ck7WeDhxIUPUPx2Eo6kLtO9tZo4hhL1s6cVKeZr9w4udNZcKO93tkj
 w96fQ76cY7ebJKXG16c/SwTxZ8Sd9cvvmRTMAM0gjiUgARe+aEchG/axA00mprGI5wUJ
 4DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675557; x=1762280357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUj5tDuFxMrJLcMfMzba2XS192smTgWQLL5DdnxIsIc=;
 b=r0zRfFwW7Etp5hk13LwrgMkPaAIq6bqvH7bJ1DCPWbSfFLcM95GEYljQeQeOIA5t9z
 uyq4qKJBviTvflHS3sFeQxrOaCnCumBoPW0ZzcVgD4oROoD+MhL3pqwJOHCU+WrxiJgd
 p8/66FqHSrqK8fm/AXBsW5XnMOEgLeA31rDlFaIrWWciUbycaTcwWYI8dGSkfGQmZU0a
 I4ltLvOWy+DRQEwEcK5VDhgMDO4X+ReH8JNpux+m1x8o3NU1KiLFVH3LzgNnBkmPBOd1
 iX6WBHlxHH4nsUMuhOV+2ZKkZyAt2Sig2z9pXN2+Xtro4TQkTGLcKNchfD6uUAKhrFZ1
 +sBA==
X-Gm-Message-State: AOJu0YwpU4IpAtj+L8sQUfarYLMmcdRUnUjVzoaojbiiIHn6qfxAWKbe
 AbCETd3V+g6OJc0gMz5Uy8NVU1i8go47DcaFUraMlr2PBbGPrhk/6Nm4NmEATBCMyo+l11jqayl
 y/JR+xQ0=
X-Gm-Gg: ASbGncskXHzizEU+rnDjrA3EiwvEF7LiiQMkoXoZkEglbRyFfpiKjH4X+2FrrxS/zui
 tLbJ5Nm49LWp6bRQgRNLbXt1LI8EUXY5I/xU5//JVmB9I3mjU1iDANBvLBRszCY7UoEUl8O46sD
 i0dYWq38PpSYRbHNQSraLd36JE3eGTJVgUBtFSmHpKSXEUMj2QpNZjm4siTXOvnQFYAQ/ESC3hD
 tbxMqEp8dh1UI/pBOSisux6DBwBSWhW+RbXEPJQ2d8jnEYVKk/e4PQyIacjHHkiSQn54LALpuG2
 1VFHcsDGGGMnygBQSK8DnVP4+kWcb8gehUxGoIkhBGwPJGtXUlPZQkpVcWdND+96efFlmP3qnyN
 11r9ggfznmvr5MSJimRE/giJqDXIGkL2RHrql60FW2c4Q0HLofxqBLJlB9JraQwP3DzfiklNZFE
 GOveKT9vJN0gsKo+NUWrSEXogplQBaFzAt82MrWNGJ3MG+DjMZRA==
X-Google-Smtp-Source: AGHT+IFI+gul3yKAwz4c1fktmae3PtXn0re8tT5hM2q9v277iSe/eJTmPxa7M5Ll7Jfuyxo1LE2TRg==
X-Received: by 2002:a05:600c:46cc:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-4771e1e0589mr3761845e9.27.1761675557024; 
 Tue, 28 Oct 2025 11:19:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a4bsm6065935e9.6.2025.10.28.11.19.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:19:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 06/25] hw/pci-bridge: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 19:12:40 +0100
Message-ID: <20251028181300.41475-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

SysBusDevice::mmio[] is private data of SysBusDevice, use
sysbus_mmio_get_region() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-bridge/pci_expander_bridge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1bcceddbc4d..aa55749954a 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -157,9 +157,11 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
     main_host = PCI_HOST_BRIDGE(pxb_dev_base->parent_bus->parent);
     main_host_sbd = SYS_BUS_DEVICE(main_host);
 
-    if (main_host_sbd->num_mmio > 0) {
+    if (sysbus_has_mmio(main_host_sbd, 0)) {
+        MemoryRegion *mr = sysbus_mmio_get_region(main_host_sbd, 0);
+
         return g_strdup_printf(HWADDR_FMT_plx ",%x",
-                               main_host_sbd->mmio[0].addr, position + 1);
+                               mr->addr, position + 1);
     }
     if (main_host_sbd->num_pio > 0) {
         return g_strdup_printf("i%04x,%x",
-- 
2.51.0


