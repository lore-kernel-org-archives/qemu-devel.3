Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E64CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstY-0002zC-2e; Tue, 28 Oct 2025 19:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstW-0002yi-Ib
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:26 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstJ-00016y-LB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:25 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8E2DA81762;
 Wed, 29 Oct 2025 02:13:59 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-2mUnRvaE; Wed, 29 Oct 2025 02:13:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693239;
 bh=2XoO4sK3PyosnJP9ENpDuxfvkqVmRhLmWENx1ysV1oc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lky/sMJ1rxIIeo3fifHeTmvSUf9OxxHCAFpOoh+pB8GTrzh+LQgrIhw26VJKVBxrW
 CErMVZowtxZEPbDkdu5V7y0Rparx+o6EH7Uon5gPjOYf5HHwpTd+LDkZ65v5OQiZSF
 HwMufkUGOQ67osyDvQIq/+keKaN40Fs0ot84lpjo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 11/22] hw/pci/shpc.c: use new migration APIs
Date: Wed, 29 Oct 2025 02:13:35 +0300
Message-ID: <20251028231347.194844-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/shpc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index aac6f2d034..15f79d6bec 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -759,31 +759,35 @@ void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int l)
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
+        error_setg(errp,
+                   "Failed to load SHPC config: expected %d bytes, got %d",
+                   SHPC_SIZEOF(d), ret);
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
2.48.1


