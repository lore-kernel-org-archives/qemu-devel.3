Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03224C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hfl-0005cE-PZ; Sun, 13 Sep 2026 06:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfj-0005bZ-Lx
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfi-0008Ab-Bp
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RnuFdKKVpqFKDm4hZnFD0Rhn5+yJEZDo7nKlyDxdy9Q=;
 b=Zz2RDetwHRW6HUspTC9VdJtgqGjuM7zWgZMB+7STCb3+Dei9slFcRCN4OXwbLPN3pzCYwZ
 7zOD7nnxa6RcSyJRHBkqvi9T03HtMltZGAwymDPNrttgAswRbSWIbWXYtssiZZSm6ngIa3
 1C6IA9dO76MOGEA4DagCh/ZOluo9gDc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-XNJjXC5SMG-vh56EtB0KIA-1; Sun,
 13 Sep 2026 06:42:51 -0400
X-MC-Unique: XNJjXC5SMG-vh56EtB0KIA-1
X-Mimecast-MFC-AGG-ID: XNJjXC5SMG-vh56EtB0KIA_1789296170
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB3BB1944DD2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:42:50 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8F8930001B9; Sun, 13 Sep 2026 10:42:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:19 +0400
Subject: [GIT PULL 01/14] ui/dbus: fix cursor race, copy cursor data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-1-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=llMUUGzcjuqZBsgOy2Q3nKSAiYWuK9mpFKVJ6lb5KHc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4i1ljhUZSHw1zx3L0r8N2MD9TDVY6LWhCHh
 h0cJBPmwViJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5YoTD/9Nchyttb1XTgKLZTwZuoAuHmkGkTJh7kh7iwqxSG/1YrFBbk7KsOq+SViHotrwfYV4CwI
 RcJIwsrlanOfQgiBEmP+faGGmNxrRvPwMQ3sKF2WR3jMnS9N8xoB2fsgSCfQwVK8GZQB6rgYC5V
 xxxO3Ki2XDZX0HYFFNovoKA3jtWlTtpECHEuxFM9vzNY9nM7J5ZUvr/Px4qPeI6sQgxCyjzTN4I
 KN6Wp2cu0AbF7O0VM7AKOIFIXlqbq3ZXTxuMtqmB+iWlgM7kuJH9UYEcnz9Fjang18sK0CDOfZ8
 ePHLjtoMBgFw3QkGJlspO9jGKrGAxSWQ6ebk0O3LtVzZewKTkPTx11W6puPnunY2jX7xhN0288s
 ZC5Odpnpcua7LCgQ+6XnmECMsZY/L1U2tmHgnfqt8nazbgO+RfcwF/zBiUGZhnWuUmirJQWR5Yw
 qBZ971ddd2N3wigjiGxpOsJ5gsAN8FHue61JuFyFsOdFuoTLdgTGY206HKidaBi77Dj6xC0XS4m
 p+rmPLkkp3BRbo9yqOiIzIT5VCz8Ng5XyuMUtzpAiZfD2p18Toob5X8J03yridgnYhSnaHww6Re
 EHxA8riytmVhJhyYZoqlMi8HG/7msYAOjlmweIccK24GBICxhVTAqTkzDKrNrMBLZUhtXtkm11j
 Hpw+9vl6qNAZ+LA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Eliminates the undefined behavior where virtio-gpu's memcpy() overwrites
the buffer that an in-flight gvariant still references. Fixes the data
race where the GDBus worker thread calls cursor_unref() concurrently
with main thread.

Fixes: 142ca628a733 ("ui: add a D-Bus display backend")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260904123020.3108205-1-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index c1e86648384c..624d0fb71d6b 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -926,13 +926,11 @@ static void dbus_cursor_define(DisplayChangeListener *dcl,
 
     ddl_discard_cursor_messages(ddl);
 
-    v_data = g_variant_new_from_data(
-        G_VARIANT_TYPE("ay"),
+    v_data = g_variant_new_fixed_array(
+        G_VARIANT_TYPE_BYTE,
         c->data,
         c->width * c->height * 4,
-        TRUE,
-        (GDestroyNotify)cursor_unref,
-        cursor_ref(c));
+        1);
 
     qemu_dbus_display1_listener_call_cursor_define(
         ddl->proxy,

-- 
2.55.0.543.g5ebe2ebe4ea8


