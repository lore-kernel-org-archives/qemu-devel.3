Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB5CD11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7akm-00068j-4z; Sun, 03 Nov 2024 08:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akg-00065i-M6; Sun, 03 Nov 2024 08:34:46 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akf-0001D4-4N; Sun, 03 Nov 2024 08:34:46 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso469327466b.3; 
 Sun, 03 Nov 2024 05:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640882; x=1731245682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kcGj5THgATrhziRVv9fCQe0+3eD5yxcFJLfyqBCQbg=;
 b=JxZdCnzecxv8Fs4J9oFXMam3pQtA0SnE1c/guwt4AWis6xL0XbKY1AW23qEKXIxIZI
 k+hDkamnJnW1scEVLagMydEChgG4660+1KODs+JT964dMf1Eu9gYMlAXjmyw9XVh5pHV
 r+l1f+U5t0a/vvLemeccHdnFJGtKGLC5zOjOJ7q0H+WlcmYZBxw3hnefLZT8xRm9qLzC
 /TWrRkLNhcrhRjxawNEg02oHCwXLtaWT7vda2SI5BVVyXhfsxfsYDMg4PebN22aGWI/j
 RxcHoxLs5NBJDD3xYpfMFX5qYdwt/n7gwSlx7fgJKvwQOM9Zt3ZwLm2VXcAEs55ywxK9
 yMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640882; x=1731245682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kcGj5THgATrhziRVv9fCQe0+3eD5yxcFJLfyqBCQbg=;
 b=TmZNd658al69wFwmlAZ6/oSi9ASb2BkcU5NafJUkuezttoqamgMy1Dvzk7I3pdeg0c
 prn2VNTK3g7s/alVHv6kVSwc/TDox1Od+2dFwJggA9WpiGGFzWctreN9iiV1Hopso0/3
 vceRtjYnZtT+TbggpXwP+zFmWrFkIWE4C6CONh9JIite12reyqrtl9Eh+BUOzBuer6TE
 hNJ8eThL8xg5zqLvANan/vzyQphcHt8lAHJnK8qwB3t94NUbpfA/wsIUC/YdgQgkh7u7
 +qBpSGh27bn+zt0bhRNMGSBD6L5I8NU4Gifb0/rcEBt8o49vPLzYL02GFSWcRBPd/u3V
 U4wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0AoB7TVNMqCsDOnDNSp7RtCO7uLwGoSlS18K5mi1T+MNx7x1KS/IoEzmlNyZao7VCcPTcq/7blSc=@nongnu.org,
 AJvYcCVmRy/XnAMXQnqwuQYYE1nwBAR8VqoFelVfkFxYaHpxbqCIb2ql7ehxqeXcajGGdwFY4nweoVSquGAD@nongnu.org
X-Gm-Message-State: AOJu0YyKGO6CF1rwhfPmvYCthvl7z/6dvdj9o0cV1TC0kpekHl7oOMNP
 nvhtd3diYHgoZe/O438s2DsogdMecK3QJU2epLWgdPNWL6sltE4tLt+a6Q==
X-Google-Smtp-Source: AGHT+IEY30HUHnATzk+Jh1Vg1LG0xMCN2LDUFv/lGfk4bEtvJKrgA7Rnz3ef/frMty/+0RpDj1AA2Q==
X-Received: by 2002:a17:907:e88:b0:a99:7676:ceb7 with SMTP id
 a640c23a62f3a-a9de5f49bf7mr2870520966b.26.1730640882416; 
 Sun, 03 Nov 2024 05:34:42 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:41 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 01/26] hw/ppc/e500: Do not leak struct boot_info
Date: Sun,  3 Nov 2024 14:33:47 +0100
Message-ID: <20241103133412.73536-2-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

While at it remove the obsolete /*< private >*/ markers.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.h |  9 +++++++--
 hw/ppc/e500.c | 17 ++++-------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 8c09ef92e4..4a1b42d44b 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -5,18 +5,23 @@
 #include "hw/platform-bus.h"
 #include "qom/object.h"
 
+struct boot_info {
+    uint32_t dt_base;
+    uint32_t dt_size;
+    uint32_t entry;
+};
+
 struct PPCE500MachineState {
-    /*< private >*/
     MachineState parent_obj;
 
     /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
      * board supports dynamic sysbus devices
      */
     PlatformBusDevice *pbus_dev;
+    struct boot_info boot_info;
 };
 
 struct PPCE500MachineClass {
-    /*< private >*/
     MachineClass parent_class;
 
     /* required -- must at least add toplevel board compatible */
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b760c6d6a2..ba83f33033 100644
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
2.47.0


