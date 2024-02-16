Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1B8C48BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayKf-0008Bk-DF; Fri, 16 Feb 2024 08:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayK4-00083p-RY
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayJw-0006DV-Iq
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708090319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppkVwgaUYdwPeFxpk0uqOP/zHRU1fKPe69aJ32CvN60=;
 b=eU4tTrPqbkPY3X6dOuWcc30FXirQfGysGR1s02z6ZfZpEVO7G0mGuDS9w1bNqX/O/W781i
 rm5t0rKtRSfCAWnF7yU9GAR9JIL9MXgIq5tuTIVxufkefesr3eNUnKGdwPaiNiFctSO+qz
 3mIIgMtzsiC4aqQkY+8y2UFy4pynjoI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562--fWgRc42PNyL731qtgvLFQ-1; Fri,
 16 Feb 2024 08:31:56 -0500
X-MC-Unique: -fWgRc42PNyL731qtgvLFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 096893C100B5;
 Fri, 16 Feb 2024 13:31:56 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19ACC40166C5;
 Fri, 16 Feb 2024 13:31:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 2/7] ui/clipboard: mark type as not available when there is no
 data
Date: Fri, 16 Feb 2024 17:31:35 +0400
Message-ID: <20240216133140.3611100-3-marcandre.lureau@redhat.com>
In-Reply-To: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
References: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

With VNC, a client can send a non-extended VNC_MSG_CLIENT_CUT_TEXT
message with len=0. In qemu_clipboard_set_data(), the clipboard info
will be updated setting data to NULL (because g_memdup(data, size)
returns NULL when size is 0). If the client does not set the
VNC_ENCODING_CLIPBOARD_EXT feature when setting up the encodings, then
the 'request' callback for the clipboard peer is not initialized.
Later, because data is NULL, qemu_clipboard_request() can be reached
via vdagent_chr_write() and vdagent_clipboard_recv_request() and
there, the clipboard owner's 'request' callback will be attempted to
be called, but that is a NULL pointer.

In particular, this can happen when using the KRDC (22.12.3) VNC
client.

Another scenario leading to the same issue is with two clients (say
noVNC and KRDC):

The noVNC client sets the extension VNC_FEATURE_CLIPBOARD_EXT and
initializes its cbpeer.

The KRDC client does not, but triggers a vnc_client_cut_text() (note
it's not the _ext variant)). There, a new clipboard info with it as
the 'owner' is created and via qemu_clipboard_set_data() is called,
which in turn calls qemu_clipboard_update() with that info.

In qemu_clipboard_update(), the notifier for the noVNC client will be
called, i.e. vnc_clipboard_notify() and also set vs->cbinfo for the
noVNC client. The 'owner' in that clipboard info is the clipboard peer
for the KRDC client, which did not initialize the 'request' function.
That sounds correct to me, it is the owner of that clipboard info.

Then when noVNC sends a VNC_MSG_CLIENT_CUT_TEXT message (it did set
the VNC_FEATURE_CLIPBOARD_EXT feature correctly, so a check for it
passes), that clipboard info is passed to qemu_clipboard_request() and
the original segfault still happens.

Fix the issue by handling updates with size 0 differently. In
particular, mark in the clipboard info that the type is not available.

While at it, switch to g_memdup2(), because g_memdup() is deprecated.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2023-6683
Reported-by: Markus Frank <m.frank@proxmox.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Markus Frank <m.frank@proxmox.com>
Message-ID: <20240124105749.204610-1-f.ebner@proxmox.com>
---
 ui/clipboard.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index 3d14bffaf8..b3f6fa3c9e 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -163,9 +163,15 @@ void qemu_clipboard_set_data(QemuClipboardPeer *peer,
     }
 
     g_free(info->types[type].data);
-    info->types[type].data = g_memdup(data, size);
-    info->types[type].size = size;
-    info->types[type].available = true;
+    if (size) {
+        info->types[type].data = g_memdup2(data, size);
+        info->types[type].size = size;
+        info->types[type].available = true;
+    } else {
+        info->types[type].data = NULL;
+        info->types[type].size = 0;
+        info->types[type].available = false;
+    }
 
     if (update) {
         qemu_clipboard_update(info);
-- 
2.43.1


