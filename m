Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD4BCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUJJ-0005jL-3K; Mon, 08 Jun 2026 03:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUGI-0002MY-Rw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUG6-0000e9-78
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BS5+8uDbUO8tnie7RIoFtC9U2mSiMSeu6Pam5/wgM3Q=;
 b=f/rEg+Fm4HAslg2OIB59dRi8aOKgjg0/bUY/BIwxk1buJrJkZ8n1vHBxQrUQ5zHEpC0NXP
 Ilwx7mmCvsghz+AOixv1KyiJVl5GMnG3iHo69onbojBlVwoi2JNuoh2kqazg+nNHY8WkC2
 W4BaWYMWPg8nm3FxUs/SatqML79WTC8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-KjMI5pZnOSicTKKC3qDlFg-1; Mon,
 08 Jun 2026 03:18:44 -0400
X-MC-Unique: KjMI5pZnOSicTKKC3qDlFg-1
X-Mimecast-MFC-AGG-ID: KjMI5pZnOSicTKKC3qDlFg_1780903123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42A68180048E; Mon,  8 Jun 2026 07:18:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 042B019560A3; Mon,  8 Jun 2026 07:18:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:41 +0400
Subject: [PATCH v2 23/33] ui/console: fire console ADDED/REMOVED notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-23-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6hGNnrGYNd3ibRqfbbVKqo9FqKz4axEEuiTBy0WRKJo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxMaHgs8EYIR9FEjEs/eb/nHADtkRy1YpUP8
 4fnNNtlIsOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsTAAKCRDa6OEJdZac
 5VeqD/9c91HEQjgRAXuwGc7bvJuT2+BFavVoZlF4UW+s3eCs0wSc+UKa1feFANAFFsmf+5mRhYe
 ctVPK3Wj7NFI7KttyjJI8xLt+LQFGr57YlF6tyPxtMTyhe2FJVFRIiFy+IW+JL3bqmm9JWss/Tw
 VjrSv00xZ/oZ53ujyu6Hfetw91rTmBXT08XVTRvM+PK7pzE1soNXSHD49187XiwmzTsukAPVK/i
 kCDBhMSlp4nilbGGj8ygLqIaMSufmq3FAhKAkNaYEqwufPS0qgMN4IR1hKjhugI27hqLS1Pi+85
 VvUDlWjDnVi+EVtX01iOU7nwV0q75DcVerFdRg6413Bsj/1j5FlAvATQcqA6CxHkh6aJWiXdPgQ
 fx9fBo25iffdDijm3TAmpg2prBpE3QnPTxqvCV3oejdCiKJgYQFRHJPeJk7ab8xm0vN5nxo6oFE
 9QUevyafI56c1hwb3F+C1Kqumcx2urDQ8O+B2senccoZukKSjtyUUf3j73RkXPR9qd9hjeqD6Y5
 GIH8t5phqv9HTwR3Q9msqbRmXBn/w6q2SGTz+uIpXXHyDxx2dH6xaxSqzYcf7WE6SLZPUnz9/3u
 PpyroTO+Snuugk2/dT1HwZx6jXGRCw+O6Ik/F0lZNOG+n0lgEQG9UYyts4MqojUPPrhedzJ7To3
 GZ2pmZt+eHZbJcQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fire CONSOLE_ADDED at the end of graphic_console_init() and
CONSOLE_REMOVED at the start of graphic_console_close(), so display
backends can react to console hotplug/unplug events.

REMOVED fires before the device link is cleared and before the
placeholder surface swap, so handlers can unregister their DCL while
the console is still in a known state.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 76851bc129d..975eaf15706 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1142,6 +1142,7 @@ QemuConsole *qemu_graphic_console_create(DeviceState *dev, uint32_t head,
 
     surface = qemu_create_placeholder_surface(width, height, noinit);
     qemu_console_set_surface(s, surface);
+    qemu_console_notify(QEMU_CONSOLE_ADDED, s);
     return s;
 }
 
@@ -1158,6 +1159,7 @@ void qemu_graphic_console_close(QemuConsole *con)
     int height = qemu_console_get_height(con, 480);
 
     trace_console_gfx_close(con->index);
+    qemu_console_notify(QEMU_CONSOLE_REMOVED, con);
     object_property_set_link(OBJECT(con), "device", NULL, &error_abort);
     qemu_graphic_console_set_hwops(con, &unused_ops, NULL);
     timer_del(con->ui_timer);

-- 
2.54.0


