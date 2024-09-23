Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F922CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPQ-0001hp-1m; Mon, 23 Sep 2024 05:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPN-0001ZQ-TE; Mon, 23 Sep 2024 05:31:05 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPM-0006wb-1B; Mon, 23 Sep 2024 05:31:05 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso647969666b.2; 
 Mon, 23 Sep 2024 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083860; x=1727688660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UacqFQWwY/RdMUHAYDpVrliqhGJbLEk5GcxMrcdJHGk=;
 b=NyjLwOdZpoSoH2To2GYNTAPfWGYdFRZjZzXMTYgirwxTP2v/Qe3UrckNGRElJX2j+o
 CYzAolwhD8XezeAtgtEktOf2JrRZbKSIaTYIyPan9Fgoxqm96TG/79cbOlTzxvTpP35E
 86QEtCZQU9eRma5Un9tB7jVnJ8jHiTA4GggtSHmSMOq8NmF+IMRdNbUVtftadBMFi1eE
 RNglb2mtFa/Tx4rzoNgG6bRRNaShe+ib5kFsJz0W/9scXztf2jtk/b8H0xGH5MDqu4mR
 Kajr5UmOEakeQopfOKvSr/fNegFhvR+b/UtO5p+/WBaKVlmGf0b80SDJQrnLlM3Opxw6
 wKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083860; x=1727688660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UacqFQWwY/RdMUHAYDpVrliqhGJbLEk5GcxMrcdJHGk=;
 b=ZOacUta6jL06Pz8Tbj1cIMTlCV5oqghNcfWTqaL0AjIyO1ysLylK4OauG3r5PY9/N7
 OzfD1NLshzBvug/zrBxjEDdq3kEJgsE5Z5sSH9EJUnHvZT/qZ+JdroxbejCjED+9zPwx
 A/whvEZEPMWM/Zn3pFg4+aHthOtSkObpb5OjgfS43ccwBKeX4Y/SEeDU0rewUWJuBfkQ
 Od4XqInE8zZebMu1vrai048HdWO2i3f5h5Yemjbmp5YjsC7MU4sEfXW3LMh2f3YoQXsM
 ses3kZECJboQstjtyO7EOGJz7W/VudmxWd71QvDt5opHUGeNFTZWBXow5ebMcoJZuGxP
 hsTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT2mapbusWfUldAYmODVYASdHAqOvfJjdTzTFXMvDALb5TXzlFWqu0AYzXFEorxwbw8HMdGep1So48@nongnu.org,
 AJvYcCVo2Wgmj5MSN7i2lICE9QcKQ/SpF7TLPKy9foAXi9rHGxS2TiLsDkXQ1SoOwJ8dMUQXujzZcDVAni8=@nongnu.org
X-Gm-Message-State: AOJu0Yyvlciovs4us9xpK4yFUKqiC5JbdmmbqQ4byJOe2dQ7xBU6jyNH
 T60OgUJ5unNx2FHbFfsLzeyP9ePtazje/4utNt6hlUesSZXzDqHAB1IXmA==
X-Google-Smtp-Source: AGHT+IGNRJb28XANS441MzHqrZmf6zgrrGW6A35kGGoV2FP+oJji9k/8fcBegCp2m1HTQS03XKjsKg==
X-Received: by 2002:a17:907:7da5:b0:a8a:8dd1:b2d1 with SMTP id
 a640c23a62f3a-a90d5109321mr1065095566b.55.1727083860425; 
 Mon, 23 Sep 2024 02:31:00 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:30:59 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 01/23] hw/ppc/e500: Do not leak struct boot_info
Date: Mon, 23 Sep 2024 11:29:54 +0200
Message-ID: <20240923093016.66437-2-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The struct is allocated once with g_new0() but never free()'d. Fix the leakage
by adding an attribute to struct PPCE500MachineState which avoids the
allocation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.h |  8 ++++++++
 hw/ppc/e500.c | 17 ++++-------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 8c09ef92e4..557ce6ad93 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -5,10 +5,18 @@
 #include "hw/platform-bus.h"
 #include "qom/object.h"
 
+typedef struct boot_info {
+    uint32_t dt_base;
+    uint32_t dt_size;
+    uint32_t entry;
+} boot_info;
+
 struct PPCE500MachineState {
     /*< private >*/
     MachineState parent_obj;
 
+    boot_info boot_info;
+
     /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
      * board supports dynamic sysbus devices
      */
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3bd12b54ab..75b051009f 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -80,13 +80,6 @@
 
 #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
 
-struct boot_info
-{
-    uint32_t dt_base;
-    uint32_t dt_size;
-    uint32_t entry;
-};
-
 static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slot,
                                 int nr_slots, int *len)
 {
@@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
     bool kernel_as_payload;
     hwaddr bios_entry = 0;
     target_long payload_size;
-    struct boot_info *boot_info = NULL;
     int dt_size;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
@@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
         /* Register reset handler */
         if (!i) {
             /* Primary CPU */
-            boot_info = g_new0(struct boot_info, 1);
             qemu_register_reset(ppce500_cpu_reset, cpu);
-            env->load_info = boot_info;
+            env->load_info = &pms->boot_info;
         } else {
             /* Secondary CPUs */
             qemu_register_reset(ppce500_cpu_reset_sec, cpu);
@@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
     }
     assert(dt_size < DTB_MAX_SIZE);
 
-    boot_info->entry = bios_entry;
-    boot_info->dt_base = dt_base;
-    boot_info->dt_size = dt_size;
+    pms->boot_info.entry = bios_entry;
+    pms->boot_info.dt_base = dt_base;
+    pms->boot_info.dt_size = dt_size;
 }
 
 static void e500_ccsr_initfn(Object *obj)
-- 
2.46.1


