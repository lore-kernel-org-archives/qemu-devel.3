Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5CCE64A9E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4p-00084O-5G; Tue, 03 Dec 2024 08:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4o-00084F-JD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:30 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4n-0001Hr-3A
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:30 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2155e9dcbe7so28738355ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232987; x=1733837787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjHE9Z6WrftEnGOF6FxD/A7yotkBFL8L2UOLnZiXDUY=;
 b=VEc2cEix2Audq4OasIxx752ns1jAAJJTXqzoessUZuQ9lZ2lro5SCT9bjMeGj3Ljf/
 BJHoAG+2+2G1JnBDAdbTXruMnKRZm9CkOreTz1lhvS9YZAqJylFvmwgvrDLPjDcGTnzk
 WgReT3LIwZM3TCLu+/IC+pcIGVbiCdAetpQq+kTIW/S8rDfi7EwW2Y016q8pfnqjnyvk
 8gVSvvXmtJVYoJNLS2iwjl2/SUxo8ZR5fvdy/tns0YbjWo768QICDsvQUctXYen5VhZK
 CUitMVoG+XGhKNPFmb4RTfjhGsw3oQ6X4NEvK7vBmJk+X26MgOCCrUZc0cQA3bho64US
 nKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232987; x=1733837787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjHE9Z6WrftEnGOF6FxD/A7yotkBFL8L2UOLnZiXDUY=;
 b=JQsNbT2Csn43kRfBKq3O5P4AB+iAR7DewaxFRDACk9Dc9h23X3xn21lYO/Z7DO5uPB
 4h2kcyj8K1yaj2gMNw89anyjqroUs8P2yT1B4HIuqcZd3djlP12YNt9xBGLbr0mOhPqW
 jbx3YUNmNcBEaO0wKUywmDQHnBwh19U6gFWYoXxUJ4FueNNlpONckY75ZGK2eeEr8VVJ
 fV7tvtfiXz75lsM88xvM0NuvESLNhTsIW1zj+v6VbzYWqHPtrIhXmiEj56aEJuiBRyhQ
 GzYQI48mYgtY2b31NerLVC1ZFxh5Ujd/9aRQOjkZ5Sq9yBk3p/HASckDei6XgLDEHdlP
 dg6A==
X-Gm-Message-State: AOJu0Yw4qGCxuKraJo6i4DT30L6rGrBjJe00v9o8V9Ji1MQan6C1I2hI
 fnXNSaqba2lChW7fZ6iNc52B9mp2wLLijFIBgxwhHA9rKGxIBokQvlLRR9h89Q==
X-Gm-Gg: ASbGncvTijfR7pnGpxVPK96HgVO4rH5chF/T9tYNGzI+fhhOEJZTPf9FXLiCmV3Sg8m
 fFLDQa7v72ezIjrByMc1ntMTXbLykBZ6eCwzonD9bDm0rH9dD3a+Dm/NQIo4qKJogsBCfVKAeFF
 XUetmKWBqFxshShVZSe4GwoXGcw4Pa3s+yMk3ukujz/2io6xlHxhnVfMsLMrQWZPaei5eod2GL6
 BuN6wLGLMq40tzGF/nu5GzlR3pbgVqK30tZ78/M+EfZhGTKWCj5g5RO4AM=
X-Google-Smtp-Source: AGHT+IHWUvlPD2yCX4OhbnW4Zl6SiTnJvNkMWvHlS06dmulqoOAlIEL/sIvG5L8mfGH+9kQ26rfTsQ==
X-Received: by 2002:a17:902:ecca:b0:215:4665:f7e5 with SMTP id
 d9443c01a7336-215bd16f93dmr29216905ad.43.1733232987439; 
 Tue, 03 Dec 2024 05:36:27 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:27 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 9/9] vfio/igd: add x-igd-gms option back to set DSM region
 size for guest
Date: Tue,  3 Dec 2024 21:35:48 +0800
Message-ID: <20241203133548.38252-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

DSM region is likely to store framebuffer in Windows, a small DSM
region may cause display issues (e.g. half of the screen is black).
By default, QEMU uses host's original value, which is determined by
DVMT Pre-Allocated option in Intel FSP of host bios. Some vendors
do not expose this config item to users. In such cases, x-igd-gms
option can be used to manually set the data stolen memory size for
guest.

When DVMT Pre-Allocated option is available in host BIOS, user should
set DSM region size there instead of using x-igd-gms option.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e464cd6949..0814730f40 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -717,6 +717,23 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
+    /*
+     * Allow user to override dsm size using x-igd-gms option, in multiples of
+     * 32MiB. This option should only be used when the desired size cannot be
+     * set from DVMT Pre-Allocated option in host BIOS.
+     */
+    if (vdev->igd_gms) {
+        if (gen < 8 && vdev->igd_gms <= 0x10) {
+            gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
+            gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
+        } else if (vdev->igd_gms <= 0x40) {
+            gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+            gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
+        } else {
+            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
+        }
+    }
+
     ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
-- 
2.45.2


