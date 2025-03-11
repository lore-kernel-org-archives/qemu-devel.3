Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4FDC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2BT-0005WS-59; Tue, 11 Mar 2025 12:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts22X-0004PQ-VP
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts22L-0005l9-Fv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9AvjSm3OBLPexgkNYguLSVaeQ+0WUa/J+lMQ8EWkFY=;
 b=ENJ1vnECuswgdOWamAjqkgO1/DfSLgB68e178jSXckbVs6Xc3okPx4M1bj/oh2NPN1sH7Q
 q7P7Fkq6QnhPhwxsgTdn6rMhmTcw92Y4igLPF97EqM6CNmspOs+SKz52FJq07iaN6z8Tw8
 58ZuTrrdhnxFb3x058Tv7DTiITD3u8Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-e1C-ZCVxN7KjWdX_DXS5fQ-1; Tue,
 11 Mar 2025 12:00:54 -0400
X-MC-Unique: e1C-ZCVxN7KjWdX_DXS5fQ-1
X-Mimecast-MFC-AGG-ID: e1C-ZCVxN7KjWdX_DXS5fQ_1741708853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D54B180AF6B
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:00:53 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4BA3180AF7C; Tue, 11 Mar 2025 16:00:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-10.1 09/10] ui/vdagent: add migration support
Date: Tue, 11 Mar 2025 19:59:31 +0400
Message-ID: <20250311155932.1472092-10-marcandre.lureau@redhat.com>
In-Reply-To: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vdagent.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 125c659af7..cc5738a6ea 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -10,6 +10,7 @@
 #include "ui/clipboard.h"
 #include "ui/console.h"
 #include "ui/input.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 #include "qapi/qapi-types-char.h"
@@ -930,6 +931,143 @@ static void vdagent_chr_class_init(ObjectClass *oc, void *data)
     cc->chr_accept_input = vdagent_chr_accept_input;
 }
 
+static int post_load(void *opaque, int version_id)
+{
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(opaque);
+
+    if (have_mouse(vd) && vd->mouse_hs) {
+        qemu_input_handler_activate(vd->mouse_hs);
+    }
+
+    if (have_clipboard(vd)) {
+        vdagent_clipboard_peer_register(vd);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_chunk = {
+    .name = "vdagent/chunk",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(port, VDIChunkHeader),
+        VMSTATE_UINT32(size, VDIChunkHeader),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_vdba = {
+    .name = "vdagent/bytearray",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(len, GByteArray),
+        VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+struct CBInfoArray {
+    uint32_t n;
+    QemuClipboardInfo cbinfo[QEMU_CLIPBOARD_SELECTION__COUNT];
+};
+
+static const VMStateDescription vmstate_cbinfo_array = {
+    .name = "cbinfoarray",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(n, struct CBInfoArray),
+        VMSTATE_STRUCT_VARRAY_UINT32(cbinfo, struct CBInfoArray, n,
+                                     0, vmstate_cbinfo, QemuClipboardInfo),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, JSONWriter *vmdesc)
+{
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
+    struct CBInfoArray cbinfo = { 0, };
+    int i;
+
+    if (!have_clipboard(vd)) {
+        return 0;
+    }
+
+    for (i = 0; i < QEMU_CLIPBOARD_SELECTION__COUNT; i++) {
+        if (qemu_clipboard_peer_owns(&vd->cbpeer, i)) {
+             cbinfo.cbinfo[cbinfo.n++] = *qemu_clipboard_info(i);
+        }
+    }
+
+    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc);
+}
+
+static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field)
+{
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
+    struct CBInfoArray cbinfo = { 0, };
+    int i, ret;
+
+    if (!have_clipboard(vd)) {
+        return 0;
+    }
+
+    vdagent_clipboard_peer_register(vd);
+
+    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
+    if (ret) {
+        return ret;
+    }
+
+    for (i = 0; i < cbinfo.n; i++) {
+        g_autoptr(QemuClipboardInfo) info = qemu_clipboard_info_new(&vd->cbpeer, cbinfo.cbinfo[i].selection);
+        /* this will steal clipboard data pointer from cbinfo.types */
+        memcpy(info->types, cbinfo.cbinfo[i].types, sizeof(cbinfo.cbinfo[i].types));
+        qemu_clipboard_update(info);
+    }
+
+    return 0;
+}
+
+static const VMStateInfo vmstate_cbinfos = {
+    .name = "vdagent/cbinfos",
+    .get  = get_cbinfo,
+    .put  = put_cbinfo,
+};
+
+static const VMStateDescription vmstate_vdagent = {
+    .name = "vdagent",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .post_load = post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(connected, VDAgentChardev),
+        VMSTATE_UINT32(caps, VDAgentChardev),
+        VMSTATE_STRUCT(chunk, VDAgentChardev, 0, vmstate_chunk, VDIChunkHeader),
+        VMSTATE_UINT32(chunksize, VDAgentChardev),
+        VMSTATE_UINT32(msgsize, VDAgentChardev),
+        VMSTATE_VBUFFER_ALLOC_UINT32(msgbuf, VDAgentChardev, 0, 0, msgsize),
+        VMSTATE_UINT32(xsize, VDAgentChardev),
+        VMSTATE_UINT32(xoff, VDAgentChardev),
+        VMSTATE_VBUFFER_ALLOC_UINT32(xbuf, VDAgentChardev, 0, 0, xsize),
+        VMSTATE_STRUCT_POINTER(outbuf, VDAgentChardev, vmstate_vdba, GByteArray),
+        VMSTATE_UINT32(mouse_x, VDAgentChardev),
+        VMSTATE_UINT32(mouse_y, VDAgentChardev),
+        VMSTATE_UINT32(mouse_btn, VDAgentChardev),
+        VMSTATE_UINT32(mouse_display, VDAgentChardev),
+        VMSTATE_UINT32_ARRAY(last_serial, VDAgentChardev, QEMU_CLIPBOARD_SELECTION__COUNT),
+        VMSTATE_UINT32_ARRAY(cbpending, VDAgentChardev, QEMU_CLIPBOARD_SELECTION__COUNT),
+        {
+            .name         = "cbinfos",
+            .info         = &vmstate_cbinfos,
+            .flags        = VMS_SINGLE,
+        },
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void vdagent_chr_init(Object *obj)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
@@ -937,6 +1075,7 @@ static void vdagent_chr_init(Object *obj)
     vd->outbuf = g_byte_array_new();
     error_setg(&vd->migration_blocker,
                "The vdagent chardev doesn't yet support migration");
+    vmstate_register_any(NULL, &vmstate_vdagent, vd);
 }
 
 static void vdagent_chr_fini(Object *obj)
-- 
2.47.0


