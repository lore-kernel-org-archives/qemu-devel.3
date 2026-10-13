Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1FBCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcUJ-0001a3-HQ; Tue, 13 Oct 2026 09:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUG-0001ZN-Ss
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUF-0004hG-Dv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZVmESOYWGOI1F0pvpXd4KSdm/v3l0o57SnTNLnXihU=;
 b=ifaGFDHrOj/Rw/RDwAeU3GbT1lBM+NbLuVvL7oGDl/BeWdn70Qe+3diMqnAjY4FxPWfR+M
 WYizz7oOjD3CsmUtU0ZGLinhIpMcPTsLo60Kfj1WkOGCPTt03sTttoGa7l8+/gWqsjOVBW
 J8Eiao3irnf5lAjhONMZxR78fSfzino=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-m4fjE0VXOAqLYFJ7fSZFgA-1; Tue,
 13 Oct 2026 13:24:09 +0000
X-MC-Unique: m4fjE0VXOAqLYFJ7fSZFgA-1
X-Mimecast-MFC-AGG-ID: m4fjE0VXOAqLYFJ7fSZFgA_1791897848
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 963771926B6D; Tue, 13 Oct 2026 13:24:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D6B11800446; Tue, 13 Oct 2026 13:24:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:08 +0400
Subject: [GIT PULL 11/40] qmp: add chardev-window-size-changed command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-11-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QL02FlPuGBZSe42coS+I0RitheEYqs6RSW2h6dbX7Ho=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDC+Z+qyovXk23ZTSx7/joUx7cfzxRj9Jq4D
 zHv/UCNXtCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5ScSD/0XSSzJ2keDGP5c9SiYXj8HxUFW7FoLW4JnnZoVtHgX94pluWejPOON0oguriENrS1IGIN
 tvKO6VMy+2jk8DGZnWEYsJSgy2vlelAbyxJHyRnEBXiMSjq7MI1FYk/zQBw0ieNf4d6ODL8M+l3
 lEbMqAQdoYHwnEJ8aZmLAy9G8dqTjmP62a16ExFRNo0l1iUthqafsSmTByAhPaTNsV5EOauAeVc
 eJCsj4ePH/YVWWMDKa4SBxYieDKNV1hq7Ced+YQHUs0O3IJd2U0IS7udXxUNTommqXyi3dRAENH
 rmX8emc4IM2v//0v5OGroWwB/9GEyFdZaH6RLHI7WvH+Py26+LJdDeR2rU9u0utdStFvQ/1z/ES
 owFiDrwXC8Yt7wRR0HGrHAkFCotshoSTfBThlcPY1f4tbqyg1rTFtvGYGdREvh82ilBCOTCD5gO
 Bky+6cWfJ4/zhfXMMORyZtJ6dLt7QMAGXUTTXnzEdo2NR7tv9ElAlfO22CSEn2ztydwEL+/EFEO
 kqz+xyYcnIfLqL155mx5GXreK4XtZFE/Vvk2LongobOdJt+idqpqTAqfNKMCDpQliBYFX4Zhn1c
 hTOWtFpRtq0uvJP0tNUq+I5tCJ2hX/uavk/ndVG767DV3x5rh6BpYGfJpcAxPMIRj+cl7A1uFHR
 WL8rw7+7rIF+Yrw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Szymon Lukasz <noh4hss@gmail.com>

The management software can use this command to notify QEMU about the
size of the terminal connected to a chardev, QEMU can then forward this
information to the guest if the chardev is connected to a virtio console
device.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
[Filip: rename command, change documentation]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-10-2c3b10d829b3@gmail.com>
---
 chardev/char.c | 14 ++++++++++++++
 qapi/char.json | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 8c8386e5b51b..fe513ae9621a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1347,6 +1347,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth, bool skipauth,
     return true;
 }
 
+void qmp_chardev_window_size_changed(const char *id, uint16_t cols,
+                                     uint16_t rows, Error **errp)
+{
+    Chardev *chr;
+
+    chr = qemu_chr_find(id);
+    if (chr == NULL) {
+        error_setg(errp, "Chardev '%s' not found", id);
+        return;
+    }
+
+    qemu_chr_resize(chr, cols, rows);
+}
+
 /*
  * Add a timeout callback for the chardev (in milliseconds), return
  * the GSource object created. Please use this to add timeout hook for
diff --git a/qapi/char.json b/qapi/char.json
index 7ae67eedff8e..842e00319488 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -862,6 +862,37 @@
 { 'command': 'chardev-send-break',
   'data': { 'id': 'str' } }
 
+##
+# @chardev-window-size-changed:
+#
+# Notifies a chardev about the current size of the terminal connected
+# to this chardev.  The information will be forwarded to the guest if
+# the chardev is connected to a virtio console device.
+#
+# The initial size is 0x0, which should be interpreted as an unknown
+# size.
+#
+# Some backends detect the terminal size automatically, in which case
+# the size may unpredictably revert to the detected one at any time.
+#
+# @id: the chardev's ID
+#
+# @cols: the number of columns
+#
+# @rows: the number of rows
+#
+# Since: 11.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "chardev-window-size-changed", "arguments": { "id": "foo", "cols": 80, "rows": 24 } }
+#     <- { "return": {} }
+##
+{ 'command': 'chardev-window-size-changed',
+  'data': { 'id': 'str',
+            'cols': 'uint16',
+            'rows': 'uint16' } }
+
 ##
 # @VSERPORT_CHANGE:
 #     Emitted when the guest opens or closes a virtio-serial port.

-- 
2.56.0.116.g6de20f6092dc


