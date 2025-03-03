Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5054C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp32n-0004bP-KQ; Mon, 03 Mar 2025 05:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tp32l-0004b6-3j
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:29:03 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tp32i-0006LJ-Te
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:29:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2235c5818a3so39283095ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740997739; x=1741602539;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0OLmglrFG7lDGpzE5FypLOYIGLn7DdcrlFVoprwPaCI=;
 b=n89GiOIYVmjt2Y/iePMuY4LRM7cJiXJIVo6dOvR3KAFgbDcMEb82pzFm4alP6bUuN4
 hXYrcPEk/eLlSV3rlRjJaMg0WW6w59K98ON2plOC183YyFwM8NXkJj8SzTwnCZj02bvM
 ie/1Rq1zE92tgHeRpDw/CSci7uuqV9u6L31K/bd6bgjgs1VA0seeStlwzzBM+BwJyVoT
 tgGRpVzAOKDQDCIMxoSVn/FtzwqFvEKjidR8zSyCN7F6vgwt0RpFk1URkmzYOXrFjiPY
 pN0XqE6ro48RdyAtkaCMgYMGMnfe3pLWOHbRiHhSfCwXbbVpNtmPRT660STnCeag/+Rl
 BOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740997739; x=1741602539;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OLmglrFG7lDGpzE5FypLOYIGLn7DdcrlFVoprwPaCI=;
 b=LckT8XSJWuz3gzpeeL63E0O2jBt35JINddA2gRgwwWngop6+TkMts4WTzNhOX6dPA6
 SI3Jch+sBBaG9OoWVoCjxj8YLEAPOnPdiQqaaHM5wruT21KJAXyGG3EVWIJndwRfD2YP
 jA++mKsV8ZkIDzzoa8aPiFBInHYOZ1xpRf/M0MCTjFQKX6XrbF8aYD4OT93bQBLi/02X
 DfSVBgMcCN4Y89ykxxcYRoYdf86206fSWIo/f47PVHICrSSX8fFjZeRaIO78YAOIocB6
 nYxVwOmbdcP+wRIpt0CalBMEDWSdEn3yAf4u0oIpdOvsn6/kHy2LdcstaVGd8mVliXBB
 q5jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFHQAzbnIl8goZaIrOROZlUfs/3wlUlSCAH8ifiUfcgFot9cIyXbeVH7u3wBRYOGSehfGhv/nyYRwM@nongnu.org
X-Gm-Message-State: AOJu0YyRteI4y/vZGzW9JwPQFLHRm8fNdL/GHM0Uq84Eo5NAh2yYOMT7
 W12TfkQAULdUb5U7qzvHilG9jllWi8vcrKVkKZ8dK7rsnTAyDpvSSWmHjzYC7VQ=
X-Gm-Gg: ASbGncsuz73z7JLLfKO6n2MGUkr6tvRuM4PYOYc+ZGK41bdnRTWhDn9l/nsoMJeujLn
 JAsnVwnSP6P5j+ZYvmtghS6Z0pwa9U7AKjLOudlSk0DE2gr4lVJvhCt1ThX8CsZ1k/7hjNqc6uD
 Eh7sfudWC0cR2qVjxBSMGX8VRp/Fx8ttCoYjpTbO/9XfoMf21OblWa7cANHbEQCLYHaHWDNAZ4R
 ozvFUEXnjWZm6kXuCSKn5o7LHMGiFPJKLFkwboi2uoTCn67SOZNZ+GP7e2vHn6awJMpp1+6Jz0A
 PWGIkztL2snA1nI70SKb8Z/stntu6vevF4VRGmAZgaBfEe8t24s=
X-Google-Smtp-Source: AGHT+IFsOoWw8L2o7MJPKPgSqzIYTbB+Wxnwc/xh+0VXw8+K4sMtopqvaPzg8tsekxU2Y2w1DX3Wgg==
X-Received: by 2002:a17:902:e84a:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-223690e0257mr209972895ad.24.1740997738834; 
 Mon, 03 Mar 2025 02:28:58 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7364374b320sm2889887b3a.31.2025.03.03.02.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:28:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 03 Mar 2025 19:28:48 +0900
Subject: [PATCH] usb-storage: Allow manually adding SCSI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-usb-v1-1-70f700a181fd@daynix.com>
X-B4-Tracking: v=1; b=H4sIAF+ExWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwND3dLiJF3TlJRUk6TkJEMTM3MloMqCotS0zAqwKdGxtbUASwani1U
 AAAA=
X-Change-ID: 20250301-usb-5dde4bcb1467
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

usb-storage automatically adds a SCSI device, but it limits
configurability of the added SCSI device and causes usability
problems as observed in:
https://gitlab.com/libvirt/libvirt/-/issues/368

Allow manually adding SCSI device when the drive option is not
specified.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/usb/dev-storage-classic.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 56ef39da2e634d1639a07ac4636cdaa000989f5f..33e5a7cfc8bdf3f92b18014e885771aee6d32f5e 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -33,10 +33,9 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
     BlockBackend *blk = s->conf.blk;
     SCSIDevice *scsi_dev;
 
-    if (!blk) {
-        error_setg(errp, "drive property not set");
-        return;
-    }
+    usb_desc_create_serial(dev);
+    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
+                 &usb_msd_scsi_info_storage);
 
     /*
      * Hack alert: this pretends to be a block device, but it's really
@@ -48,23 +47,23 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
      *
      * The hack is probably a bad idea.
      */
-    blk_ref(blk);
-    blk_detach_dev(blk, DEVICE(s));
-    s->conf.blk = NULL;
+    if (blk) {
+        blk_ref(blk);
+        blk_detach_dev(blk, DEVICE(s));
+        s->conf.blk = NULL;
+
+        scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
+                                             &s->conf, dev->serial, errp);
+        blk_unref(blk);
+        if (!scsi_dev) {
+            return;
+        }
+        s->scsi_dev = scsi_dev;
+    }
 
-    usb_desc_create_serial(dev);
     usb_desc_init(dev);
     dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
-    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
-                 &usb_msd_scsi_info_storage);
-    scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
-                                         &s->conf, dev->serial, errp);
-    blk_unref(blk);
-    if (!scsi_dev) {
-        return;
-    }
     usb_msd_handle_reset(dev);
-    s->scsi_dev = scsi_dev;
 }
 
 static const Property msd_properties[] = {

---
base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
change-id: 20250301-usb-5dde4bcb1467

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


