Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D523ACCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstI-0002sN-AG; Tue, 28 Oct 2025 19:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstG-0002s5-Sp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:10 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst7-00014V-7x
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:10 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 095A08174E;
 Wed, 29 Oct 2025 02:13:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-SDlcWWZH; Wed, 29 Oct 2025 02:13:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693234;
 bh=EZgFRHRD0OzlmlPv1yQVuHzPOzY9kMBfHCFRUSxoT20=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=y+lJEsuJYbbI9AxRUrFp94119eKIgC4UaADH/VWc1rijssSLwwI4savdwXSve89aJ
 GLRu+V6tI2oEfehr77FsClOfz48wRdbRjpEDUOaJ9+XsBXFHSvMPK2hKKLnNbY9aaZ
 caHc1fl8JunphcT0XwTGDmNvcdM4xT6qa1g49ucc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 04/22] ui/vdagent: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:28 +0300
Message-ID: <20251028231347.194844-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 ui/vdagent.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index ddb91e75c6..4388e90c0b 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -923,7 +923,7 @@ static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
     cc->chr_accept_input = vdagent_chr_accept_input;
 }
 
-static int post_load(void *opaque, int version_id)
+static bool post_load(void *opaque, int version_id, Error **errp)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(opaque);
 
@@ -935,7 +935,7 @@ static int post_load(void *opaque, int version_id)
         vdagent_clipboard_peer_register(vd);
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_chunk = {
@@ -975,15 +975,16 @@ static const VMStateDescription vmstate_cbinfo_array = {
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
@@ -992,29 +993,24 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
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
@@ -1025,20 +1021,20 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
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
2.48.1


