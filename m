Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A82C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taeMk-0004Ro-Al; Wed, 22 Jan 2025 12:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1taeMe-0004RP-Uz
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:18:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1taeMW-0008HD-QW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:18:04 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2161eb95317so129856085ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566275; x=1738171075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYtOpjqj0PL9kK3cDJke2zZ3co+eRfWI99H3wGD6uBA=;
 b=Z9Tx72qYyEpGalsuWCyR2HWIz7TwonMdNbrv8u2uSYcPOrY4DnzGdjazJ6r/p/PZKx
 wFG3ASnXBFOVILu5/ODzO6JdGTAIFwKDdHEnm0WRM9QYdZl8vBTdSEV/slKAzsD6F4Qo
 zFiOHuOVs1iwaEl2PPEibthtwKZaaBQdPgmA+N0ULRoIQGQaGb/kAd1i6Kkr2CJQRFBG
 W1HkZ+C7Gl8M2AakHFZlKy3FTIirH28n5rQnpMVWbtAfRz0Tk6+wl8oUDtjAop5Fdbvp
 qAOfbe1A9CbxOp1nYB+H/XqubTQjoZZrhTNKInyoFqxO7L6mWDjGEk1FeOXw3J7hng3Y
 rM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566275; x=1738171075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYtOpjqj0PL9kK3cDJke2zZ3co+eRfWI99H3wGD6uBA=;
 b=KyCpZrvlnVpN6ffC3nIsOBcD2uemIdkEXR332wfxsiDYJBoaynlSnEgW2cI6GWPibX
 9vnhYCbl0F4/7zu3aEeAQo4g/e264kkrkg8fHNQeRIj/nUDBy5C8pw+NNCsTMLBQ/4HH
 oex3hU7hQ+vIjdHl6qSZGpJUeRcWE3AQQ6Vzk7fbfe2Hq+ytj6hnptiOu0TUkqvN0Ej+
 3v9HJudtyU0YlklkNni+0uVyRtfAlc8RoTtkg1af5nXRKkDHUuyAVtcHLcrL+akPdN4Y
 v7qckEkeAPpVEzqR168Ykb3S/L6nVwQZfHxcuiRUrm3XR1k33IhfIWbaWgVHpadFK+E2
 wTeQ==
X-Gm-Message-State: AOJu0YxBt3rYXE+iwBUeB8SvAr48HvOOeUfZCrHHB8dpTJ+lwolSvfnI
 PIOSvtYHUuqeou5NRMZclhYHnaKE3yN861BFp4zMHQob75i24PA=
X-Gm-Gg: ASbGncsDuPTIrb8UaQ5NMVYh1rtrLiLjImvwrzeauJbFCRHEdnpr+Ck+tnx9l9ZdETW
 Sjz8yjsChIGcDVWvJPTE7YAavDfa3fU9qUKqOvAMvXI2nMQjGYVNGyektgrk9Ukh3W3n4Y4zl4v
 FOiA2csqAteA/1ZgtNqMrs9D29Jg9+ophTmBcy9JBARUF8bgxFn2LvkdgmQG9iXh8Q4o7fcb+6X
 YCvBsVyecyHSesP8FU2h88GrGYf1KvKgWgNbV5MK0NVay2qfXQm5hl/zmRCy4aDqFTl77EPqqmb
 /uf9CWk=
X-Google-Smtp-Source: AGHT+IGyzNBX3LZjjutTRP0e3icJb8dtoFByi8IlU70EVMxe9kwC/4zHd4tI6Epw0a3nPXAGKa+sZg==
X-Received: by 2002:a05:6a20:748b:b0:1e0:da90:5f1f with SMTP id
 adf61e73a8af0-1eb21485391mr30892574637.16.1737566275043; 
 Wed, 22 Jan 2025 09:17:55 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.217])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba48eb8sm11597818b3a.136.2025.01.22.09.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:17:54 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 4/4] vfio/igd: do not include GTT stolen size in
 etc/igd-bdsm-size
Date: Thu, 23 Jan 2025 01:17:31 +0800
Message-ID: <20250122171731.40444-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122171731.40444-1-tomitamoeko@gmail.com>
References: <20250122171731.40444-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

Though GTT Stolen Memory (GSM) is right below Data Stolen Memory (DSM)
in host address space, direct access to GSM is prohibited, and it is
not mapped to guest address space. Both host and guest accesses GSM
indirectly through the second half of MMIO BAR0 (GTTMMADR).

Guest firmware only need to reserve a memory region for DSM and program
the BDSM register with the base address of that region, that's actually
what both SeaBIOS[1] and OVMF does now.

[1] https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 33e5202052..8bb67b3190 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -112,28 +112,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
 
 #define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
 #define IGD_GMCH_GEN6_GMS_MASK      0x1f
-#define IGD_GMCH_GEN6_GGMS_SHIFT    8
-#define IGD_GMCH_GEN6_GGMS_MASK     0x3
 #define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
 #define IGD_GMCH_GEN8_GMS_MASK      0xff
-#define IGD_GMCH_GEN8_GGMS_SHIFT    6
-#define IGD_GMCH_GEN8_GGMS_MASK     0x3
-
-static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
-{
-    uint64_t ggms;
-
-    if (gen < 8) {
-        ggms = (gmch >> IGD_GMCH_GEN6_GGMS_SHIFT) & IGD_GMCH_GEN6_GGMS_MASK;
-    } else {
-        ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
-        if (ggms != 0) {
-            ggms = 1ULL << ggms;
-        }
-    }
-
-    return ggms * MiB;
-}
 
 static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
 {
@@ -368,7 +348,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
     g_autofree struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret, gen;
-    uint64_t ggms_size, gms_size;
+    uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     Error *err = NULL;
@@ -527,7 +507,6 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
         }
     }
 
-    ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
     /*
@@ -539,7 +518,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64(ggms_size + gms_size);
+    *bdsm_size = cpu_to_le64(gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
@@ -559,8 +538,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
         pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
     }
 
-    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
-                                    (ggms_size + gms_size) / MiB);
+    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
 
     return true;
 }
-- 
2.45.2


