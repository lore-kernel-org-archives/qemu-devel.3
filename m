Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E7CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoXg-0000ZS-KT; Tue, 28 Oct 2025 14:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoXT-0000Me-K7
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:35:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoXL-0004an-QN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:35:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4298b49f103so2236347f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676510; x=1762281310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbV20QgyIxlspSHe3slsxqgoOZCxZe5hmrWfCx1z6jY=;
 b=ht6gfUrVraJDYYa0CBatWamXOspZgpNax59eNF+2RDl1ryGeVu5+1fxwbJitjTO8oH
 nvlqmWC4cTjwkl+iJ0+L0VrutYFHeEcnmd+Nog2c2JdTzscJlKUyMvR8pkuLjlLXkPUk
 kw9O1aug88IGRZ7wEqlVpIFPzkLNSxw6AFSeyIdIaymdsfKB9VyaV/K8G4aVht3TaGz/
 xRe75ZrKr/T+rqTI8jJgdkOXDlvnPoRjB11YdSDnLYwQ2bXd4mprMIALTqxrs78htQTP
 nCzw/haCNywpdTQS+/o+nWgX5YAQqjSqvYvST7G1CaeJiEvdLBhKQfFATDPsSdHFGSgf
 fiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676510; x=1762281310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbV20QgyIxlspSHe3slsxqgoOZCxZe5hmrWfCx1z6jY=;
 b=Ab1TwAVXaPI3Tt6Ay9ULRs7FpXHyR6hkVdhAq34sW6NwP89Mii3B8HmQpXchueSCB6
 ID+toN0aF9ltuWnsGvontL15k8FlQ0c6VEuFZMBxw9VadJG8X5VA/+6mm1X1ZAM7arm7
 V8m0vgvnT0aXyV2QV6fE1wKVEsdUZsRhAkJCLlolrbSCVfvg9J0q6GZR9YjqnrAtjbbA
 j7KE/EuooE+PuwaRCppxNSs2WjEsjj9CKqWmSoi2YC9XUdVoRQ1R/GtFgm7PFnaOqji7
 nKfONbVEdUExb96xAk2SC8IagiJVq/mVDy4No6z9Tuu+94ArdBHnqUpDBGkOlwZiVQLx
 ka5Q==
X-Gm-Message-State: AOJu0YwrDBiJFri4uiUduU9cHnUjy+WTLs35M5wOyDB7oq2bQKF3rRZh
 OEGiNsVacZMx1VB1i80XofCBGUM8b7JVRH7S5eUNMgGvjCWMeFTtFh8itAE1AytOPdRhwkaYilG
 8vO7ILIY=
X-Gm-Gg: ASbGncsV3o0qZau6mOdy/ZAr89UZwfsZthQLbjNWhpuJQJYDIbf6O9DuuYTJGMWl0uY
 w76Tt6EJSbGbmnO4s3NysONBEBG9Xi30SpvyMqWTZE/EDZsB/0z85x+NsdW81LuDiejtru5gbA2
 bDsb/zMBlOf1nS+6R1qvPX4JGRkaxiCJmMXONckSPqcEhUjDrUlHdWJwyXLtPYZYLzX7qlTLFGi
 j6nU6xs+pj52/GBsRIyRkGTfdeaEMgPZwTf9BUaz2C+zab9dUt//edRPTwjrUe/7Z4VC7uGV64l
 1Rym8MrYDPpSTkCR81w7yufKK8qd66LXfSZ6TezwMCQmCD/I2/LnK1yABT1cfjdVL4XynrvR3ZU
 OIU6LZnbML/IOaYjtZIY1+trlt1Whn3H+VuIW5T/ajpD6qYKJqGkOH3NtJZwD3/7Fn4lIvAus2S
 2uWIzRLwtz3zFYwPtL3G9OrxYhirBdKcFpzMttvBNxvvA0uzkFXQ==
X-Google-Smtp-Source: AGHT+IFZvJ9NpojrZnUC56Rkdt1ACx7aQJVJlyE1/s6DyXLlTiXnLMfxQJUA3nNkIlmy15bezLbfdw==
X-Received: by 2002:a05:6000:2082:b0:3e0:c28a:abbb with SMTP id
 ffacd0b85a97d-429aef77d9bmr77676f8f.13.1761676510363; 
 Tue, 28 Oct 2025 11:35:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9d1sm21375687f8f.35.2025.10.28.11.35.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:35:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 19/25] hw/pci-bridge: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:53 +0100
Message-ID: <20251028181300.41475-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-bridge/pci_expander_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index aa55749954a..0cb94fca9c0 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -161,7 +161,7 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
         MemoryRegion *mr = sysbus_mmio_get_region(main_host_sbd, 0);
 
         return g_strdup_printf(HWADDR_FMT_plx ",%x",
-                               mr->addr, position + 1);
+                               memory_region_get_address(mr), position + 1);
     }
     if (main_host_sbd->num_pio > 0) {
         return g_strdup_printf("i%04x,%x",
-- 
2.51.0


