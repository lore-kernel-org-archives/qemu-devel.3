Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3729ECA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCE7J-0001CM-TR; Thu, 01 Oct 2026 06:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCE7I-0001C8-Qi
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCE7H-0000rh-B8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790850857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1UltUo9/poES0oOVyNwwI5VSuJ0jQtFd3c/EoF/w6cs=;
 b=EoO4lpnzbnB4gs1UsuCzIg0xxPrm0gjCOwzGBImfgiA2OGmWAHSycQbMkfdGE4SyUabMd1
 AI+106H+77InPJJEDGPg3iB7mmFj+XA5JvqAYa8sBVIw1pmCgPTV7Yu2v+e7fN/e+UQvt1
 uAbxmibhaCANuJcPH/pBzmaOXfwdgy0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-JjoxiWWqMWKHr9o5gugdew-1; Thu,
 01 Oct 2026 06:34:16 -0400
X-MC-Unique: JjoxiWWqMWKHr9o5gugdew-1
X-Mimecast-MFC-AGG-ID: JjoxiWWqMWKHr9o5gugdew_1790850855
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 909A3186BB06
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 10:34:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF9EF41B; Thu,  1 Oct 2026 10:34:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] RFC: chardev: disconnect backend when frontend closes
Date: Thu,  1 Oct 2026 14:34:12 +0400
Message-ID: <20261001103412.2162829-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When the guest closes a virtio-serial channel, QEMU notifies some
backends (spice, dbus) via their chr_set_fe_open handlers. Backends
without such a handler, like socket, keep the connection open even
though the frontend is no longer active. This is problematic for
stateful protocols, as the peer has no way to know the channel was
reset and must handle re-synchronization on its own. Disconnecting
gives the peer a clean signal to reset its state.

Add a base-class chr_set_fe_open handler that calls chr_disconnect
when the frontend signals close. Subclasses that already override
chr_set_fe_open are unaffected. For the socket backend, this tears
down the connection and allows reconnection when combined with the
reconnect option.

Note: this is a behavior change that may break existing setups that
rely on the connection staying up across frontend close/reopen cycles.
It may be preferable to make this opt-in via a chardev property rather
than changing the default.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 7daf87f0363e..58c69db7340e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -331,12 +331,22 @@ static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
+static void chr_set_fe_open(Chardev *chr, int fe_open)
+{
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+
+    if (!fe_open && cc->chr_disconnect) {
+        cc->chr_disconnect(chr);
+    }
+}
+
 static void char_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
     cc->chr_write = null_chr_write;
     cc->chr_be_event = chr_be_event;
+    cc->chr_set_fe_open = chr_set_fe_open;
 }
 
 static void char_finalize(Object *obj)
-- 
2.56.0.rc0.29.g47ce80527c56


