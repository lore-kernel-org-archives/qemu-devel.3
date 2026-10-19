Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827E7CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjbX-0000Td-DU; Mon, 19 Oct 2026 05:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xIjbV-0000Ss-V9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xIjbH-0002md-0l
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792401849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RkyJJftsuLINSzs44tAskMdqVi/d7YlA0Rz4Uj4AZbU=;
 b=QKVbJ/X4LKKuM913rThqEvHfy+ibE9tel2sD+4bhMNYrgaDfA+wPfcFpEWBuoDqVPsHlE1
 R+VhuINStU323f1M9ndwvWyHgaUFWgF3AWlcuFu0w2Tp3vpq42brcrD6Ds5GR3pgr2RRkL
 ieGECKteHyNTmhMKtivhSXEl5K78gcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-CcGDKU_HMqaT9FNgwlaa-Q-1; Mon,
 19 Oct 2026 09:23:55 +0000
X-MC-Unique: CcGDKU_HMqaT9FNgwlaa-Q-1
X-Mimecast-MFC-AGG-ID: CcGDKU_HMqaT9FNgwlaa-Q_1792401834
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1C251800669
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:23:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABF3D767; Mon, 19 Oct 2026 09:23:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/dbus: validate clipboard selection in Release handler
Date: Mon, 19 Oct 2026 13:23:51 +0400
Message-ID: <20261019092351.2435194-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The clipboard "Release" D-Bus method handler passes the caller provided
selection to qemu_clipboard_peer_release() without any bounds check,
unlike the "Grab" and "Request" handlers.

An out-of-range selection reaches qemu_clipboard_info(), which asserts
selection < QEMU_CLIPBOARD_SELECTION__COUNT and aborts QEMU (with
asserts compiled out, it would index the cbinfo[] array out of bounds).

Reject invalid selections with an error, following the same pattern as
the other clipboard handlers.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4717
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-clipboard.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 90318384ee48..44764fff8081 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -346,11 +346,22 @@ dbus_clipboard_release(
     GDBusMethodInvocation *invocation,
     gint arg_selection)
 {
+    QemuClipboardSelection s = arg_selection;
+
     if (!dbus_clipboard_check_caller(dpy, invocation)) {
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
 
-    qemu_clipboard_peer_release(&dpy->clipboard_peer, arg_selection);
+    if (s >= QEMU_CLIPBOARD_SELECTION__COUNT) {
+        g_dbus_method_invocation_return_error(
+            invocation,
+            DBUS_DISPLAY_ERROR,
+            DBUS_DISPLAY_ERROR_FAILED,
+            "Invalid clipboard selection: %d", arg_selection);
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    qemu_clipboard_peer_release(&dpy->clipboard_peer, s);
 
     qemu_dbus_display1_clipboard_complete_release(dpy->clipboard, invocation);
     return DBUS_METHOD_INVOCATION_HANDLED;
-- 
2.56.0.116.g6de20f6092dc


