Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09139CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHC0E-0007Ff-2Z; Wed, 14 Oct 2026 23:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHC07-00071r-G6
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHC05-0006qL-FI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-887d902c651so484863b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034364; x=1792639164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JanaOTFDBeozvxbB4MbYHirAOAObiNxiIEi358tCpPE=;
 b=bnccEA7MNOuywz2yOWEwbY3g4LgRpZKJnrxfrA6pfaAmUsmiHv1VPcWpjlXaF6RGnm
 jV4lz7x9t7qKCrY7hUT8j7P2iw6LG8Jocopy+cqjEZPJBMkzeikvrJQq6+qDzFtGYT5P
 drAl+04z5hYsAgeIHFd7oEpwKHYjFSPmQqEtaagDeECQo0qP/7Xwh3RU7vLscxcgIbeb
 a5usDoMwm5idNpKKj1mAUxRxegaR9j521FrIrhIUzmPvW5u/Q5Ac3YDwOcwBiVnmB9Oq
 pxY/7Sq6lBAOWtR3qHHsnoBaqm71+HVNdOwjbEG/VzpL0qBOra9aloT7Mu3C2IPL3wB5
 vTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034364; x=1792639164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JanaOTFDBeozvxbB4MbYHirAOAObiNxiIEi358tCpPE=;
 b=ZSf0tpsF/fvBcuRkohf4M6PBTtxywoFsmogLOjXtpEcGRExBTa+jd2oNjlI9VF9lyQ
 DE1YTFAqKKYTrD6KSj1+9c+2kHBs3MkLbroeKm2PrIPJ/LuzFn/+I5PQNS1whk7t/kew
 f4q2pOCwy5fnDMgYoRK4XaIKjfi1c8Yu7Z0wWNOvMwNyb+3hW84TJZFSjHuqFj7AwACb
 5/h/nD6yyR3Bs4rCDTreMChIikCBEsMaoEqE/N+Y75uaU/qszjAFp+f1lHx/T7SUZd8/
 QgBwShX4bvw9aelgdpXWxs1huC++qSQFFlFb00Yri5+QPjrue9p1xc/ZKs1K4kLzBcka
 6DAw==
X-Gm-Message-State: AFq9FYLY5oHGeagjQlkcaYvpA6jiw0IQHYx0XoHZioQ2Emfu5uHjyvoI
 v59DE6oIR02vJHxdGQ4EjiijNU/UISwJagIQ8unzUB9HRmA3eMxEDTD59Lbka+nvu+YPVmoaFwh
 0Ls4aP5s=
X-Gm-Gg: AYBFou3y1e6jy7As+Nvn2eIhqhM0lh2woCDunIYugielGbQxxp4R4fELeD1osua5Y1F
 BKXCxUlWP0wZs+4k/MDZW+Oo2lOSHFPJ5g2c9V1Xc/FlSm68OAtnX2HPhi1OOE5bz7QNP8QrxU4
 oeJfBKpJ6UlyZsh40+qoUZZzw2fah/94R4ysmDJu/TRaI1kOGJWS4UA6ukT0hq2+DBr6aADzagY
 vDqbHc3LYZAV7RBwSY9SOhpomvjCQzmwXYHsG0+o+cXlBU23FcSXu0WLcE4+AL8coK3yllMUdFO
 F7IQcTLmD7AIZOL2qTNlpZKnJT66CH9TLzLVsfK1wQ+cMYYaGP4FMM9Gb4/OF7/vEoVNWac3Sjr
 Pg+JmkZZjgRx7lcA5O/8FoTQY7pwl3PLP8BwMzt0uOfNfDRqL1fWCg1Mi1QL0wkFp958TXB0Me1
 7ERHJIfOJOrZRELDQbOAK4u7WQR6rBSvIgwyCjtG2pZKMxv/V3GpuccHwiEBC4zBJpPeQceQOKr
 8PVRHIvvtnwkB/rJxFh4D+ORjScsH6jqqk64nj8lynHtPg=
X-Received: by 2002:a17:90b:5247:b0:3a0:238b:db4d with SMTP id
 98e67ed59e1d1-3ab3ad0fe91mr27882415a91.5.1792034364105; 
 Wed, 14 Oct 2026 20:19:24 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:19:23 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 10/12] hw/riscv/atlantis: Load the RCPU bootrom
Date: Thu, 15 Oct 2026 13:18:02 +1000
Message-ID: <20261015031804.2406055-11-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=portias@tenstorrent.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update tt-atlantis to, when the RCPU is enabled and bootrom binary is
provided, load the provided bootrom binary for the RCPU to execute.

This adds a tt-atlantis machine property 'bootrom' that takes a file
name. qemu_find_file() tries the filename before the search path, so both
full file paths and filenames relative to -L work:

    -M tt-atlantis,rcpu=on,bootrom=out/bootrom.bin

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c         | 62 +++++++++++++++++++++++++++++++++-
 include/hw/riscv/tt_atlantis.h |  4 +++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 635f85e44b..652c954898 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "qemu/datadir.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
@@ -676,13 +677,37 @@ static void tt_rcpu_cluster_realize(DeviceState *dev, Error **errp)
      */
     mmio_map_unimplemented(&rc->memory, SYS_BUS_DEVICE(&rc->unimp_mem),
                            "tt-rcpu.unimp", 0, UINT32_MAX);
+
+    if (rc->bootrom_name) {
+        ssize_t rom_size;
+
+        g_autofree char *rom_file = qemu_find_file(QEMU_FILE_TYPE_BIOS, rc->bootrom_name);
+        if (!rom_file) {
+            error_setg(errp, "could not find bootrom image '%s'", rc->bootrom_name);
+            return;
+        }
+
+        rom_size = load_image_mr(rom_file, &rc->bootrom);
+        if (rom_size <= 0) {
+            error_setg(errp, "could not load RCPU bootrom");
+            return;
+        }
+    } else {
+        /* If no bootrom is provided, don't let the core run */
+        CPU(&rc->cpus.harts[0])->start_powered_off = true;
+    }
 }
 
+static const Property tt_rcpu_cluster_props[] = {
+    DEFINE_PROP_STRING("bootrom-name", TTRCPUClusterState, bootrom_name),
+};
+
 static void tt_rcpu_cluster_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = tt_rcpu_cluster_realize;
+    device_class_set_props(dc, tt_rcpu_cluster_props);
 }
 
 static void tt_ascalon_cluster_init(Object *obj)
@@ -837,6 +862,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     if (s->has_rcpu) {
         /* Only create the RCPU if it is enabled */
         object_initialize_child(OBJECT(s), "rcpu", &s->rcpu, TYPE_TT_RCPU_CLUSTER);
+
+        if (s->bootrom) {
+            object_property_set_str(OBJECT(rc), "bootrom-name",
+                                    s->bootrom,
+                                    &error_abort);
+        }
+
         if (!qdev_realize(DEVICE(&s->rcpu), NULL, errp)) {
             return;
         }
@@ -1015,7 +1047,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 static const Property tt_atlantis_soc_props[] = {
     DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_BOOL("has-rcpu", TTAtlantisSoCState, has_rcpu, false)
+    DEFINE_PROP_BOOL("has-rcpu", TTAtlantisSoCState, has_rcpu, false),
+    DEFINE_PROP_STRING("bootrom-name", TTAtlantisSoCState, bootrom)
 };
 
 static void tt_atlantis_soc_class_init(ObjectClass *oc, const void *data)
@@ -1045,6 +1078,13 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             machine->smp.cpus,
                             &error_abort);
 
+    if (ams->has_rcpu && ams->bootrom) {
+        /* Set the RCPU bootrom file name provided on the command line */
+        object_property_set_str(OBJECT(s), "bootrom-name",
+                                ams->bootrom,
+                                &error_abort);
+    }
+
     object_property_set_link(OBJECT(s), "dram", OBJECT(machine->ram),
                              &error_abort);
     object_property_set_bool(OBJECT(&ams->soc), "has-rcpu", ams->has_rcpu,
@@ -1081,6 +1121,22 @@ static void tt_atlantis_machine_set_rcpu(Object *obj, bool value, Error **errp)
     s->has_rcpu = value;
 }
 
+static char *tt_atlantis_get_bootrom(Object *obj, Error **errp)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
+
+    return g_strdup(s->bootrom);
+}
+
+static void tt_atlantis_set_bootrom(Object *obj, const char *value,
+                                   Error **errp)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
+
+    g_free(s->bootrom);
+    s->bootrom = g_strdup(value);
+}
+
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1101,6 +1157,10 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
                                    tt_atlantis_machine_set_rcpu);
     object_class_property_set_description(oc, "rcpu",
                                           "Set to enable/disable modeling the RCPU.");
+    object_class_property_add_str(oc, "bootrom",
+                                  tt_atlantis_get_bootrom,
+                                  tt_atlantis_set_bootrom);
+    object_class_property_set_description(oc, "bootrom", "RCPU bootrom image");
 
 }
 
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 7ef290ca9d..28ae1120f7 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -69,6 +69,8 @@ struct TTRCPUClusterState {
      * prevent faults on accesses to regions not modeled.
      */
     UnimplementedDeviceState unimp_mem;
+
+    char *bootrom_name;
 };
 
 struct TTAtlantisSoCState {
@@ -89,6 +91,7 @@ struct TTAtlantisSoCState {
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
     bool has_rcpu;              /* Enable RCPU */
+    char *bootrom;              /* RCPU boot ROM image */
 };
 
 struct TTAtlantisState {
@@ -101,6 +104,7 @@ struct TTAtlantisState {
     TTAtlantisSoCState soc;
 
     bool has_rcpu;              /* Enable RCPU */
+    char *bootrom;              /* RCPU boot ROM image */
 };
 
 enum {
-- 
2.43.0


