Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5CCC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr3-0005qR-1s; Tue, 25 Aug 2026 17:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr1-0005pK-17
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:47 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqz-00053K-FW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 690A780DCD;
 Wed, 26 Aug 2026 00:38:43 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-oyDaBLAm; Wed, 26 Aug 2026 00:38:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693922;
 bh=fm1O7sVTDL8aWS2MucI1ptgit5bHG785yNcUdbArR8g=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ILyOEWhFgaK4e+9LJUI/XH7xSsEznkh2SHCtfEM9ILs9U6eKYsl+CbDJKwHOFzEh9
 plehWROqu5M0DK5Au7DJXJJSVrBr2Am2M4HABHjSnqTcUcIpjPuiHBhS0HHShq85uR
 4vdqJkDMLKY154KvEh7CMxDS9YrJwyQDt8Th5+sM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 13/30] hw/pci/shpc.c: use new migration APIs
Date: Wed, 26 Aug 2026 00:37:53 +0300
Message-ID: <20260825213811.3725682-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/shpc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 938602866d7..cdd2d0564ea 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -758,31 +758,33 @@ void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int l)
     shpc_cap_update_dword(d);
 }
 
-static int shpc_save(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool shpc_save(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, JSONWriter *vmdesc,
+                      Error **errp)
 {
     PCIDevice *d = container_of(pv, PCIDevice, shpc);
     qemu_put_buffer(f, d->shpc->config, SHPC_SIZEOF(d));
 
-    return 0;
+    return true;
 }
 
-static int shpc_load(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field)
+static bool shpc_load(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, Error **errp)
 {
     PCIDevice *d = container_of(pv, PCIDevice, shpc);
     int ret = qemu_get_buffer(f, d->shpc->config, SHPC_SIZEOF(d));
     if (ret != SHPC_SIZEOF(d)) {
-        return -EINVAL;
+        error_setg(errp, "Failed to load SHPC config");
+        return false;
     }
     /* Make sure we don't lose notifications. An extra interrupt is harmless. */
     d->shpc->msi_requested = 0;
     shpc_interrupt_update(d);
-    return 0;
+    return true;
 }
 
 const VMStateInfo shpc_vmstate_info = {
     .name = "shpc",
-    .get  = shpc_load,
-    .put  = shpc_save,
+    .load = shpc_load,
+    .save = shpc_save,
 };
-- 
2.43.0


