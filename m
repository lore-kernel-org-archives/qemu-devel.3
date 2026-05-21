Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DCDCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ23i-0007rL-E7; Thu, 21 May 2026 07:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ23b-0007fn-CA
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ23Z-0004It-M0
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779364757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzvGw9HB+8PugB6Z8oQMMVKJExk0hOER2A6QhEDEAZg=;
 b=gsJ1Z+LLIkBw50RkC/mMtGUNqJtVu0VJWdzWca7KqspemUW+aWqcW2pPIz5ID2E88SoDN6
 hzU+Yf/FmEMTQPzl03hQT6rxlPN6rFHUBWNWWJUhqKlMickcddaQjya8YqAXeB5YoXK9nd
 sHaA4WpvD7if5p7CakLGMXAkg9O+8Ng=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-LgVvz8qJOzCdQFPmXR0TxA-1; Thu,
 21 May 2026 07:59:12 -0400
X-MC-Unique: LgVvz8qJOzCdQFPmXR0TxA-1
X-Mimecast-MFC-AGG-ID: LgVvz8qJOzCdQFPmXR0TxA_1779364751
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 451921800451; Thu, 21 May 2026 11:59:11 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F149E1800347; Thu, 21 May 2026 11:59:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PULL 18/38] hw/display/xenfb: Use Linux key codes
Date: Thu, 21 May 2026 15:56:55 +0400
Message-ID: <20260521115717.1701482-19-marcandre.lureau@redhat.com>
In-Reply-To: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
References: <20260521115717.1701482-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-10-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/xenfb.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 218f37f0740..ae302b217fe 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -191,29 +191,14 @@ static int xenfb_send_position(struct XenInput *xenfb,
     return xenfb_kbd_event(xenfb, &event);
 }
 
-/*
- * Send a key event from the client to the guest OS
- * QEMU gives us a QCode.
- * We have to turn this into a Linux Input layer keycode.
- *
- * Wish we could just send scancodes straight to the guest which
- * already has code for dealing with this...
- */
+/* Send a key event from the client to the guest OS */
 static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
                             QemuInputEvent *evt)
 {
     struct XenInput *xenfb = (struct XenInput *)dev;
-    int qcode = qemu_input_linux_to_qcode(evt->key.key);
-    int lnx;
 
-    if (qcode < qemu_input_map_qcode_to_linux_len) {
-        lnx = qemu_input_map_qcode_to_linux[qcode];
-
-        if (lnx) {
-            trace_xenfb_key_event(xenfb, lnx, evt->key.down);
-            xenfb_send_key(xenfb, evt->key.down, lnx);
-        }
-    }
+    trace_xenfb_key_event(xenfb, evt->key.key, evt->key.down);
+    xenfb_send_key(xenfb, evt->key.down, evt->key.key);
 }
 
 /*
-- 
2.54.0


