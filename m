Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C71E9DE60
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAkbi-0006Mj-Om; Thu, 09 Apr 2026 04:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAiSj-0005n5-S4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:01:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAiSh-0006pp-Us
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:01:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso4689325e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 23:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775714514; x=1776319314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQ+g+Ftg9KxAdBMCWpE/RWEcneIVeaJ38egOZv8j5vc=;
 b=ZWE7DzCCuXVIqjh5sBjNMFS3gAM0vSjgc0e0VeWlpFXavBtkQfvV1N5I3YjVchNnmz
 UgjoF/yz0v19fpxPaoDUadRFP4UOkROF9NVGm7jPBN395rLUjjxeH+ZZE3sD5IcTuH/y
 2eL2P8PiIlgGoIJbTo2UnqJZVm/JqG2FQKzUehvjAF7tB1RHJdwTXSS3FSJC0RcRS7C7
 mo9gVPm0awDlKndS8uuy+fTLC0fZQyX2xwKgBJO/ijQM/dKu7RrMngy8PxCaCz9LtDkH
 LGYvotYux91HUU5g2meJLj0teV33dcrzehERBpi4e8wzmEoqXe4o2A/Tte4mJmYMRpfj
 mjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775714514; x=1776319314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JQ+g+Ftg9KxAdBMCWpE/RWEcneIVeaJ38egOZv8j5vc=;
 b=XVZ6/cxo3WE4xse5pikzQU3JixZe2RzdR3LI5+WoK/lVYLjvRqYtpdMU9DkIRxIV8g
 IYl0goig8WDrn1+M0hQRaoUxl3J019xUvByhBMiNynleqo+j1nzRX57ZxP9L0RG39ZQR
 4s2FKMRk5oP3jF9uG+yF6T4OmkfnIxkzADFhknr8Mt7QIbgUjbEu66W6q3Xm82El90YD
 6VqA23PeZtHC+bd2XjMDzZy5HAe1+NbLBBE94IbgGYMDQqyerexO9h0ztjKJs/R4f7/3
 iUSzAQQoYj43RrmOSPxe0OyFJfunCdx++lG5g19RAmXEkJJVR31nP0BJlL3LswpPvemU
 1/Ew==
X-Gm-Message-State: AOJu0YzrkuTY+/p7mgetIuraUThNkzi1pFr3lroFX7I8HhyhbFXMaW5F
 jAwdAGo2fZcZnj6fP3iW5OPmAGTS3whJBI4a8/mj4ONyBUlsyi3vkT0pg3EJYplGwHYXCHNZGUN
 +Av+YxJ5dmZpkqGhNAUhAMNGQujzoud1EhuELVIoi5MqnoVTbce4babVqjB+1PDxeMbUSOvsi3q
 FY+EuKzI8MszbS2Cri02fGwcBmPe7hJemrxlYu6Fc=
X-Gm-Gg: AeBDies9KOAB2HUz4pjW/EY72hbmJ1PVZGb1BrLy0//aV4Xn1X8hJutZ1lr6gE6zZHw
 fPD8UXuEzygCfNAMqicKNReCEIVGC4oqTiYd3fXiyNGTed9oe5A9ty1Q/BFHQZQzNk9WA7BHzoq
 NvOT/lFX5PeG/Jjo68T0KVvAtCHyhyxqk2wsXydFHqCDqr1tL288Fb4MzHs2w4AsrvLDcfVj7+q
 bS4lHLn5uppfHhHSAbxm9otzqDPJ06ElQQDru1lFPdavhiC8kR1ucleiU5ezT5hAM6kryffpLOf
 XP0POJdWv37Wpg6JkPloBTjpyBd2pceVVORZsHIlallAoUtZaHj33X2LeV3PnVTimEjISDNjaFf
 rVNm6w7v1MHgTKFdmsJzBA6buaLpSk6fxG5b51P0JUxls0D4Blfxut437aSdMJMkI5uAndnhbSv
 N5t9Znpe7O/b6fc9duDVJvx9fzZyPYlNDc4EaTZNK+F865lebUJi1SlBpx6lpsvLdQN5T3WZ0Xt
 PF0caZpqJq0vD8B69BeR94DkKYZ8UC7faqwB9snWX+wAcWVl3NVoq57lYHeUA==
X-Received: by 2002:a05:600c:a311:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-488cd020238mr22822145e9.14.1775714514263; 
 Wed, 08 Apr 2026 23:01:54 -0700 (PDT)
Received: from localhost (2a01cb00141148004df9ec80d3fa1cac.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:4df9:ec80:d3fa:1cac])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488cd231a72sm47375955e9.14.2026.04.08.23.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 23:01:53 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH 2/2] block/monitor: add drive_insert HMP command
Date: Thu,  9 Apr 2026 08:01:54 +0200
Message-ID: <20260409060155.94704-3-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409060155.94704-1-matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 04:19:19 -0400
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

Add a drive_insert HMP command that reconnects a host block device file
to an existing guest device whose backing store was previously removed
with drive_del.

After drive_del, the BlockBackend remains attached to the guest device
but has no BlockDriverState (shown as "[not inserted]" in info block).
drive_insert opens the specified file, finds the device's BlockBackend
by iterating all backends and matching the attached device ID, then
calls blk_insert_bs() to reconnect the backing store.

This complements drive_del for non-removable devices (such as NVMe
namespaces) where blockdev-change-medium cannot be used. Combined with
PCIe AER Surprise Down error injection to trigger a controller reset,
this enables complete NVMe disk hot-swap simulation where the guest
sees the same device names throughout.

Example usage:
  drive_del drv0             # remove backing store
  drive_insert ns0 disk.qcow2  # reconnect backing
  pcie_aer_inject_error rp0 SDN  # trigger controller reset

Signed-off-by: Matthieu Receveur <matthieu@min.io>
---
 block/monitor/block-hmp-cmds.c | 59 ++++++++++++++++++++++++++++++++++
 hmp-commands.hx                | 18 +++++++++++
 include/block/block-hmp-cmds.h |  1 +
 3 files changed, 78 insertions(+)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 1fd28d59eb..77e9662ead 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -38,7 +38,9 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "system/block-backend.h"
+#include "system/block-backend-global-state.h"
 #include "system/blockdev.h"
+#include "block/block-global-state.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-block-export.h"
 #include "qobject/qdict.h"
@@ -195,6 +197,63 @@ unlock:
     hmp_handle_error(mon, err);
 }
 
+void hmp_drive_insert(Monitor *mon, const QDict *qdict)
+{
+    const char *id = qdict_get_str(qdict, "id");
+    const char *filename = qdict_get_str(qdict, "filename");
+    BlockBackend *blk = NULL;
+    BlockBackend *iter;
+    BlockDriverState *bs;
+    Error *err = NULL;
+
+    GLOBAL_STATE_CODE();
+
+    /*
+     * After drive_del, the BlockBackend is removed from the monitor name
+     * registry but still attached to the device. Find it by iterating all
+     * BlockBackends and matching by the device ID shown in "info block".
+     */
+    for (iter = blk_all_next(NULL); iter; iter = blk_all_next(iter)) {
+        DeviceState *dev = blk_get_attached_dev(iter);
+        if (dev && dev->id && strcmp(dev->id, id) == 0) {
+            blk = iter;
+            break;
+        }
+    }
+
+    if (!blk) {
+        /* Fallback: try by block backend name */
+        blk = blk_by_name(id);
+    }
+
+    if (!blk) {
+        error_setg(&err, "Device '%s' not found", id);
+        goto out;
+    }
+
+    if (blk_bs(blk)) {
+        error_setg(&err, "Device '%s' already has a medium inserted", id);
+        goto out;
+    }
+
+    bs = bdrv_open(filename, NULL, NULL, BDRV_O_RDWR, &err);
+    if (!bs) {
+        goto out;
+    }
+
+    if (blk_insert_bs(blk, bs, &err) < 0) {
+        bdrv_unref(bs);
+        goto out;
+    }
+
+    bdrv_unref(bs);
+    monitor_printf(mon, "OK\n");
+    return;
+
+out:
+    hmp_handle_error(mon, err);
+}
+
 void hmp_commit(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_str(qdict, "device");
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12..79af8e8988 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -207,6 +207,24 @@ SRST
   actions (drive options rerror, werror).
 ERST
 
+    {
+        .name       = "drive_insert",
+        .args_type  = "id:B,filename:F",
+        .params     = "device filename",
+        .help       = "insert a host block device into an empty drive",
+        .cmd        = hmp_drive_insert,
+    },
+
+SRST
+``drive_insert`` *device* *filename*
+  Insert a host block device file into a drive that has been emptied by
+  ``drive_del``.  This reconnects the backing store without removing the
+  guest device, enabling transparent disk hot-swap for non-removable devices
+  such as NVMe namespaces.  Combined with PCIe AER Surprise Down error
+  injection (``pcie_aer_inject_error`` *device* ``SDN``), this enables
+  complete NVMe disk hot-swap simulation.
+ERST
+
     {
         .name       = "change",
         .args_type  = "device:B,force:-f,target:F,arg:s?,read-only-mode:s?",
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7ef..73c9607402 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -21,6 +21,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
 
 void hmp_commit(Monitor *mon, const QDict *qdict);
 void hmp_drive_del(Monitor *mon, const QDict *qdict);
+void hmp_drive_insert(Monitor *mon, const QDict *qdict);
 
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
 void hmp_drive_backup(Monitor *mon, const QDict *qdict);
-- 
2.50.1 (Apple Git-155)


