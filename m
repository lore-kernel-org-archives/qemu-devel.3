Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4B1C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqt-0005jO-2x; Tue, 25 Aug 2026 17:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqr-0005iz-C8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:37 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqp-0004zG-5J
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 7B32380900;
 Wed, 26 Aug 2026 00:38:31 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-UYBVwPpt; Wed, 26 Aug 2026 00:38:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693910;
 bh=59guOcB3xHJRVsozXKizUePe2ERs8W0Jafu27AlzbNQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dO+vb4YuPaKyHiG18Ooc7jklfOtJgJQRM18F7QvtYJjPHCfaz5I3Uu8qOtwwmXwAm
 0WF6LlIyIySoOmiqpAXiC/KGJpowI4+CPi/zmnAL3gdy083TX6JHZUhQgnuCSOsqft
 HzQCb1GWibwifqRdnTr4G3xfNcqBTAmecZmcf4Wk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 02/30] ui/vdagent: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:42 +0300
Message-ID: <20260825213811.3725682-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
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
 ui/vdagent.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index b9784d4d9b9..a3a1be30404 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -938,7 +938,7 @@ static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
                                    set_migration_blocked);
 }
 
-static int post_load(void *opaque, int version_id)
+static bool post_load(void *opaque, int version_id, Error **errp)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(opaque);
 
@@ -950,7 +950,7 @@ static int post_load(void *opaque, int version_id)
         vdagent_clipboard_peer_register(vd);
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_chunk = {
@@ -979,15 +979,16 @@ static const VMStateDescription vmstate_cbinfo_array = {
     }
 };
 
-static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool save_cbinfo(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
     struct CBInfoArray cbinfo = {};
     int i;
 
     if (!have_clipboard(vd)) {
-        return 0;
+        return true;
     }
 
     for (i = 0; i < QEMU_CLIPBOARD_SELECTION__COUNT; i++) {
@@ -996,29 +997,24 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
         }
     }
 
-    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc,
-                              &error_fatal);
+    return vmstate_save_vmsd(f, &vmstate_cbinfo_array, &cbinfo, vmdesc, errp);
 }
 
-static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field)
+static bool load_cbinfo(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
     struct CBInfoArray cbinfo = {};
-    int i, ret;
-    Error *local_err = NULL;
+    int i;
 
     if (!have_clipboard(vd)) {
-        return 0;
+        return true;
     }
 
     vdagent_clipboard_peer_register(vd);
 
-    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0,
-                             &local_err);
-    if (ret) {
-        error_report_err(local_err);
-        return ret;
+    if (!vmstate_load_vmsd(f, &vmstate_cbinfo_array, &cbinfo, 0, errp)) {
+        return false;
     }
 
     for (i = 0; i < cbinfo.n; i++) {
@@ -1029,20 +1025,20 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
         qemu_clipboard_update(info);
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_cbinfos = {
     .name = "vdagent/cbinfos",
-    .get  = get_cbinfo,
-    .put  = put_cbinfo,
+    .load  = load_cbinfo,
+    .save  = save_cbinfo,
 };
 
 static const VMStateDescription vmstate_vdagent = {
     .name = "vdagent",
     .version_id = 0,
     .minimum_version_id = 0,
-    .post_load = post_load,
+    .post_load_errp = post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(connected, VDAgentChardev),
         VMSTATE_UINT32(caps, VDAgentChardev),
-- 
2.43.0


