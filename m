Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A48BCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAjz-0005Eu-OP; Sat, 05 Oct 2024 15:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAjy-0005EO-Dr; Sat, 05 Oct 2024 15:46:58 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAjw-0007c4-US; Sat, 05 Oct 2024 15:46:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so24094315e9.3; 
 Sat, 05 Oct 2024 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157614; x=1728762414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdkFcAo6SJarXbbtplTNN3BG2rXmHDAV05HAtHMlu7I=;
 b=jElIT4t9inY5HHLZDxD69IK1iaPJjdq3CTauPJKkPT2cGzKBtkGhjdSBAKPCsdtDG3
 9L4IHemsNVNPagj0lEhQI/Zqmdidyc/bosiX65seaUCCvte1Y+Ulh6dj4jjBN/vdOBs7
 XOvH29yUozdLp/ZmFQG2Inu75Vm77iKsP4fFaiJsGWW/zMZugEZ+CBlEnu+nv6ivj64O
 f7JnQrPF5I2rNU4/6jwJVWDNZzL0IK7ppVT59LkUQcgOtMZ/CDoOHMKfa9cq10pc0w9d
 n0wLNh9CETRXzXfy+TraUq2Jj5gywwESPGppgRbyPpFerDXKVJz2yWkySTv0nyvAb03/
 w+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157614; x=1728762414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdkFcAo6SJarXbbtplTNN3BG2rXmHDAV05HAtHMlu7I=;
 b=A+vN4mMTNlqBmRHHVjYB1527SiFPlQuZgtHq5Y1omjExp+avW2byxas/jp/3uuJiiT
 fSxU6CG1OGr/VnKHU8jyLLlf6tojORvk6N8PRCEOr9E49suUORrAHmIVK5x6dJ59icDf
 ibwHFBrVrbGhZfr2qGYOAVLx8YF2/MvReYZ38evMganr7gTNi8U6PXfEK2+yLNf3/kWF
 40DI14NV03lc1fdZo23lxb3vNMeZFUKk5xT67+hv/rMX7c3yRPCdh11pC2b7Cs97cMpL
 1aV0mri5AaKC6oI3YqRvcARmisfe/MVLDzzFSP+tkEpJCBG7WF3Jea/5u0dFPFSTHH39
 rMlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq8WScioIcMMpCPqQ9911z3XY2+Wq8ip4tnJcykfPCIHZs1JKCm1cZ0I3IewGqmPbtw/ujISyIwSE=@nongnu.org,
 AJvYcCXZOjG4xk4oDxwZOX4O+njpPukdC2Y0l3wXZGqQiLZSnzjFFatZnDl5utYjd1SL8o8ZqI2m7vh7tZX7@nongnu.org
X-Gm-Message-State: AOJu0YyxjAla4QBcrOrOGIPq3PxcyyPRk0/rbq5bSWXNheA/HO+I8CLg
 y9IfNJS9xWR4dC2ZSXXI6HntZbkFHpoZmjpDie6XcDNuGxpCa2TBtsZTLA==
X-Google-Smtp-Source: AGHT+IGvu8EMVPKK2PQQgtoPp9bhnmgAJ6BHDImb7jXQD6fegFdhqTFx8p9xhCj7DgBqYOlO2vdf0w==
X-Received: by 2002:a05:600c:1d16:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-42f8dcb8afbmr9434775e9.21.1728157613843; 
 Sat, 05 Oct 2024 12:46:53 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:46:53 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 01/23] hw/ppc/e500: Do not leak struct boot_info
Date: Sat,  5 Oct 2024 21:45:41 +0200
Message-ID: <20241005194603.23139-2-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
index 8c09ef92e4..5654bb7907 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -5,18 +5,23 @@
 #include "hw/platform-bus.h"
 #include "qom/object.h"
 
+typedef struct boot_info {
+    uint32_t dt_base;
+    uint32_t dt_size;
+    uint32_t entry;
+} boot_info;
+
 struct PPCE500MachineState {
-    /*< private >*/
     MachineState parent_obj;
 
     /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
      * board supports dynamic sysbus devices
      */
     PlatformBusDevice *pbus_dev;
+    boot_info boot_info;
 };
 
 struct PPCE500MachineClass {
-    /*< private >*/
     MachineClass parent_class;
 
     /* required -- must at least add toplevel board compatible */
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
2.46.2


