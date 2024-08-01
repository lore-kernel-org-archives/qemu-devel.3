Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6A4C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSit-000112-O5; Thu, 01 Aug 2024 06:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZSis-0000v4-1Q
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:07:50 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZSiq-0006c3-AQ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:07:49 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7abe5aa9d5so781676766b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722506866; x=1723111666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a6ArcVT1vup6+uuJoJ1ubNJgA9SGz0vY4xBKeQu+H+s=;
 b=Wg8Rf95aKalsgQvpCS/MSR04pJymW/w+2uXctciVrHlH2mOH+avq5dETbdVqMZRPO0
 v9FfynZU9P2t6ploJF9Ay7HiCVTEK0+bI8+qm6/U8stchSysGHLWsIMpSNLHF6ntjcQ2
 kM2J6APh53qBlYOWhOdH6SNDroUkP8sfxqG5gStMZHEXN91pPde1dZRdCOj/zFUGt3hJ
 rs8yF4haKTZCRPEnZdJEr161Ou4wZPwZR2xeUYnRla3ksKPFMBrjrjEkq9BDhJ18b12i
 eyvsZha5DO6ry8Kb68Y/7ukD0m6E/OI3Lmiy+NPE8LwQwUk9im89nAPp/LrBAiihu3G1
 mr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722506866; x=1723111666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a6ArcVT1vup6+uuJoJ1ubNJgA9SGz0vY4xBKeQu+H+s=;
 b=kOegMB8DRk3miVID7Gqd11MrNz+mtRRXzd6czEWES5+xvF3zuL24gOrfywmKVCQLdJ
 0sae7N3ZkvQoWoEgYeTPPyKkgw7d6KHJnEzGv42tinQf/OWpHnEyhVEdu6t/TZZjDqfH
 3vfOLQ8HdDn2iMjM7cpSoPtUZDT3lFZ+fu7tlIGeVXalhYD7iJpC621fTltTFfVnW0vc
 zC2idp35EBQXAITnt3Y9LqzEbgiZk8/mZDoxlJZrSaBmHMyx/2cjBjJpGdFyM3+JvoHf
 k/YOo9Esss3sCLds/hoBYAD6MjOvSwNaxFSzYxYKBjV7mCITXJ8Ug3UtvnAQJQRLXHqJ
 gFAg==
X-Gm-Message-State: AOJu0YwtnukIASefspNe2wN6v45ygxGfnwA7QOl0NGp3qPm0hqTp33A8
 u3eFvxb6h/c//3R5RSIIdevA7tFFpMXp8kcBv0bqy3fo56xlQQHC9Ac7qiBhEyvCcsHGzUhP/tj
 E
X-Google-Smtp-Source: AGHT+IF+gp8X9NEcdWcSwWpHzSINyZz2V93EMceK+gnmJc+psMfLWxuFUUOteZ2IdgJ0j+EvBVj9CA==
X-Received: by 2002:a17:907:3909:b0:a7d:3cf6:48d1 with SMTP id
 a640c23a62f3a-a7daf56b6admr108148566b.32.1722506865968; 
 Thu, 01 Aug 2024 03:07:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad9026fsm891732966b.145.2024.08.01.03.07.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 03:07:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1?] hw/pci/pci-hmp-cmds: Avoid displaying bogus size in
 'info pci'
Date: Thu,  1 Aug 2024 12:07:42 +0200
Message-ID: <20240801100742.50312-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

When BAR aren't configured, we get:

  (qemu) info pci
    Bus  0, device   0, function 0:
      Host bridge: PCI device dead:beef
        ...
        BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
        BAR5: I/O at 0xffffffffffffffff [0x0ffe].

Improve logging to not display bogus sizes:

      BAR4: 32 bit memory (not configured)
      BAR5: I/O (not configured)

Remove trailing dot which is not used in other commands format.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index b09fce9377..8421c3f74a 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
         monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
 
         if (!strcmp(region->value->type, "io")) {
-            monitor_printf(mon, "I/O at 0x%04" PRIx64
-                                " [0x%04" PRIx64 "].\n",
-                           addr, addr + size - 1);
+            if (addr != UINT64_MAX) {
+                monitor_printf(mon, "I/O at 0x%04" PRIx64
+                                    " [0x%04" PRIx64 "]\n",
+                               addr, addr + size - 1);
+            } else {
+                monitor_printf(mon, "I/O (not configured)\n");
+            }
         } else {
-            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
-                               " [0x%08" PRIx64 "].\n",
-                           region->value->mem_type_64 ? 64 : 32,
-                           region->value->prefetch ? " prefetchable" : "",
-                           addr, addr + size - 1);
+            if (addr != UINT64_MAX) {
+                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
+                                   " [0x%08" PRIx64 "]\n",
+                               region->value->mem_type_64 ? 64 : 32,
+                               region->value->prefetch ? " prefetchable" : "",
+                               addr, addr + size - 1);
+            } else {
+                monitor_printf(mon, "%d bit%s memory (not configured)\n",
+                               region->value->mem_type_64 ? 64 : 32,
+                               region->value->prefetch ? " prefetchable" : "");
+            }
         }
     }
 
-- 
2.45.2


