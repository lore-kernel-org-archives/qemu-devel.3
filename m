Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD55CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76T4-0001hz-1J; Fri, 10 Oct 2025 02:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76Sx-0001dE-E1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76Sv-0001Gs-FI
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e52279279so11406545e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760077132; x=1760681932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dalgO3KHFqrnvpaTZLuwmPIln6ESJ7EOm1cXEsir9nA=;
 b=gHDX0udBq3kOtuP3Fi2iBDUKpkVsS49PqR+aXGUNQSZhHtoGUVC4DxNZ3OICGfoQ77
 4Ry49ex/cHDpj8TrKQEzmEenNUcTg0ebShTH7xENmxFFpKq8G7gNSeRhZbPAwHCAGYka
 F0Pla88MUABLyD7ejgGUWzEKWwoJjd2XTmEhgjGsoUVK2La15XDLFdCUTwCQRu4dddeu
 OwAhbAHSy7i97OPlEUDsrDjWyD8eZ6xFMh2lUoo0qOEnw9J4+o+GGNC4XOXudrUDN1Ww
 phZccRcp+pYsf88z1mqbBo0M7fJLs+6EXc7Jh3TOTqzPSu4SCoG8qSmvCJDqw60+/66b
 1+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077132; x=1760681932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dalgO3KHFqrnvpaTZLuwmPIln6ESJ7EOm1cXEsir9nA=;
 b=Mk7xIMRrc/UqVtoSjDSFE82iQ3/+23tTzndN0elZSfcyZ+JKccYNDJowJkxvZjSal1
 IvPUpPJf2E44sxxHj4ofPW/o5LL72e2oh9blTu1HW/xCRGL+l4ZdIptQiY0i3jKW7aXG
 Kt35jqv4wJl/U1lSjK6WEd8kZqF+5M5OQSsywmYreIrSDYHQtEYfHAoGgXN2w08Xg6mP
 MgKg2Zr2flgCOch7asEvtFmr+Qw2idyfqE6mefEgDLnXu6U8N5qNy2cvISHOaLChA0Kx
 xW+/Slpo1qQjzVVJXHtk3bAm9k6iHprELyKHfENSUS2mdHgUjZVYzxYQbLqljteqX6X4
 pGQw==
X-Gm-Message-State: AOJu0YzWIq9f7eq0gyKX3zpmAemCou697yPp0dIGTJgRDvdUUvdkcIz+
 YCGbpRA6rwu2CK5YsBA3RzlK3sxmhtwOis5bFYAelw2tkN6HVlIkSMQ5p6jvWHMemTsK09BFoZv
 jqAhdDfIjPg==
X-Gm-Gg: ASbGncvzovmQI25Ctr6VgwX8NhPiQj8HK/biKEk2s+vjbW8poQWDDHpBAqy+Ne9K1VS
 pPkmHnPu7Z0fiP7axUTSPrLMFeiFMy0NL091guWkHpL4q72qN1byV02amftFeXTV07sUJM5JtY9
 9rJn9MywlkGMxikbkD/TxlLKJTj+Rf3V6XJa7K1RKIajO7Nk4Unz9o8E2wsQx6XWi0iZzm5kPQ7
 JwvCVodgDJQPx44qPFLhRkHWE5twRz0GgxBqV+PwCuRmCGKsUgiANzZGJI5zngadi02JwwI02RH
 kpmPQfGwRS/2HsDfB2yxFXAoWt4Me0sjsG2p1NnteA4C/3pq84PFXml/pH5Ypwml1p9rtQU0xrs
 wNEPtTYcsonYu51zwJaW3/ifKVO8VYMUDLodXtbNzXZwCKze4Fp3kAGTnwY2XNZVGdSvuQpOr0g
 ET6y+qn1y+Jj2V04YLW+yIthmA
X-Google-Smtp-Source: AGHT+IHGNjSsTetU0n+zcIobLZI9qBpTbbsvK+IyPUH1hYMF0B6AXNnLm0/+tJzbgPUeBxsk+6P/QA==
X-Received: by 2002:a05:600c:529a:b0:46e:59bb:63cf with SMTP id
 5b1f17b1804b1-46fa9af31d9mr70520085e9.24.1760077132318; 
 Thu, 09 Oct 2025 23:18:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab656554sm52308755e9.11.2025.10.09.23.18.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 23:18:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/6] hw/hppa: Reduce variables scope in common_init()
Date: Fri, 10 Oct 2025 08:18:33 +0200
Message-ID: <20251010061836.45739-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010061836.45739-1-philmd@linaro.org>
References: <20251010061836.45739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c8da159a114..cddca69b938 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -352,16 +352,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                                         TranslateFn *translate)
 {
     const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
-    const char *firmware = machine->firmware;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *dev;
     PCIDevice *pci_dev;
-    char *firmware_filename;
-    uint64_t firmware_low, firmware_high;
     long size;
-    uint64_t kernel_entry = 0, kernel_low, kernel_high;
+    uint64_t kernel_entry = 0;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
     SysBusDevice *s;
@@ -431,6 +426,10 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
        firmware on 64-bit machines by default if not specified
        on command line. */
     if (!qtest_enabled()) {
+        const char *firmware = machine->firmware;
+        uint64_t firmware_low, firmware_high;
+        char *firmware_filename;
+
         if (!firmware) {
             firmware = lasi_dev ? "hppa-firmware.img" : "hppa-firmware64.img";
         }
@@ -467,6 +466,10 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* Load kernel */
     if (kernel_filename) {
+        const char *kernel_cmdline = machine->kernel_cmdline;
+        const char *initrd_filename = machine->initrd_filename;
+        uint64_t kernel_low, kernel_high;
+
         size = load_elf(kernel_filename, NULL, linux_kernel_virt_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high, NULL,
                         ELFDATA2MSB, EM_PARISC, 0, 0);
-- 
2.51.0


