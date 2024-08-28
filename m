Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634ECC54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxZ-0004cz-1E; Wed, 28 Aug 2024 09:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxX-0004VL-4C
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:39 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxV-0002LF-Cr
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:38 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a86984e035aso799579666b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852615; x=1725457415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8g77ehzEy248A4F2VhK7RQfykf/Tq4WF/xnD5jpRvc=;
 b=SPPhNs8x2bZ34kp3UvwjR9WfH92iQmOjjc9XCYKLyKxw8cD3NeYQfbgtrIUa+GoVPF
 8zCvlwRUr33iA4+MRqL4x/NjZ51zTLV32BgLSXinstEHV+1oI8z6n/rIkOnX5d2qvVh8
 PkKkFW8mHLOf/7HNJ9L+OtS/BRSwyLz4mEpi8r9WxU+3+BK0RVTWtw0YyK9xPQYuEYma
 nqtK/70D08lsk0gXqwKX7+IM05RgyyZ7moc1tKSq+r+CfnF0dKrz+zdrfPb6xuNtZ6Kf
 QnsLRTb/NT4NjywJ4EHYlacYiRdv3UqYd4N8W7C6AZ1gqDdJyqzBmJpJ6nYE/Uq8n6uJ
 kVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852615; x=1725457415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8g77ehzEy248A4F2VhK7RQfykf/Tq4WF/xnD5jpRvc=;
 b=P+iYR6GjXN6ZwTvjk48qrc3hb0YmtC0jCY9829S55pfZtyy1DaW+DxbdhMVnSJwhqt
 Y7+oTNX6XwEAcVmDhjAqiKC2W6Kq/HsMX2eUaITdrPkbGELEXGI1FVfTxAbWEx+3QhDW
 173XZ3MUZWhA7OyJidEkJieS39ccVbeIBEuGWXxcFagVx/YHiltFmJ9P59NsOCvIJJ5Q
 5sGNnazV2eXVFODRfDpM0KVVgwrlbWXdrZYQc9K/rPF21P5ruQY4D9i+WouT7priiFoJ
 qSpNzu48ntszKPGKZzx9ucCyDYxqhza70L8yaDuFnrG7uGwvLz9BUkm+tPVMDGcUKEXj
 hhWA==
X-Gm-Message-State: AOJu0YxzQif0BDHCkIkFefDpRzFBZqPLUpIt/t42+DlngKWxzrrnr0MH
 T4fS7SkalXH1V/LYqPRmDisdJVRifHowz/4Lb18GSjZKIUz74x/lLXqpVA==
X-Google-Smtp-Source: AGHT+IGJ7gCPuyXg0FpikzRhJ3YLr3wHeMpfgB2pDAxDllzGkiZduwXvSNfIp6F2cDCneylUEbvcXg==
X-Received: by 2002:a17:907:f1cd:b0:a86:743e:7a08 with SMTP id
 a640c23a62f3a-a870aa17258mr149849966b.31.1724852615379; 
 Wed, 28 Aug 2024 06:43:35 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:35 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 6/7] vfio/igd: don't set stolen memory size to zero
Date: Wed, 28 Aug 2024 15:43:27 +0200
Message-ID: <20240828134328.94528-7-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The stolen memory is required for the GOP (EFI) driver and the Windows
driver. While the GOP driver seems to work with any stolen memory size,
the Windows driver will crash if the size doesn't match the size
allocated by the host BIOS. For that reason, it doesn't make sense to
overwrite the stolen memory size. It's true that this wastes some VM
memory. In the worst case, the stolen memory can take up more than a GB.
However, that's uncommon. Additionally, it's likely that a bunch of RAM
is assigned to VMs making use of GPU passthrough.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 8a41b16421..0751c43eae 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -478,6 +478,23 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
 
+static int igd_get_stolen_mb(int gen, uint32_t gmch)
+{
+    int gms;
+
+    if (gen < 8) {
+        gms = (gmch >> 3) & 0x1f;
+    } else {
+        gms = (gmch >> 8) & 0xff;
+    }
+
+    if (gms > 0x10) {
+        error_report("Unsupported IGD GMS value 0x%x", gms);
+        return 0;
+    }
+    return gms * 32;
+}
+
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
@@ -655,23 +672,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         ggms_mb = 1 << ggms_mb;
     }
 
-    /*
-     * Assume we have no GMS memory, but allow it to be overridden by device
-     * option (experimental).  The spec doesn't actually allow zero GMS when
-     * when IVD (IGD VGA Disable) is clear, but the claim is that it's unused,
-     * so let's not waste VM memory for it.
-     */
-    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
-
-    if (vdev->igd_gms) {
-        if (vdev->igd_gms <= 0x10) {
-            gms_mb = vdev->igd_gms * 32;
-            gmch |= vdev->igd_gms << (gen < 8 ? 3 : 8);
-        } else {
-            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
-            vdev->igd_gms = 0;
-        }
-    }
+    gms_mb = igd_get_stolen_mb(gen, gmch);
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
-- 
2.46.0


