Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B86CC88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hgG-0005gn-5i; Sun, 13 Sep 2026 06:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgE-0005gU-Li
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hgD-0008HU-5y
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2w/82IAJNSu6luYuSTo2QbhSwZBWj4t6EkrQbFgAcI=;
 b=M1KFDr9qLlWyls4dDNv3A+tg6k0WRVs4OYeT5ibUsXDvtc4AWzrUVK9h6qXF1HFL1OKZ5i
 hHwiUaYBo6zOOn01A25Ln9IltbE1LQe20bSByc7eBNVf0Re0gxQ3FWcDNnD61XM3eBR/VF
 Emgybh0pgW5rcrbGDBhyvv3wEEXmLeo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-ujfk3N96NUiGGvYgwqn6YA-1; Sun,
 13 Sep 2026 06:43:23 -0400
X-MC-Unique: ujfk3N96NUiGGvYgwqn6YA-1
X-Mimecast-MFC-AGG-ID: ujfk3N96NUiGGvYgwqn6YA_1789296202
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6EA18011ED
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:22 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73C3A19560AB; Sun, 13 Sep 2026 10:43:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:28 +0400
Subject: [GIT PULL 10/14] ui/gtk: Work around the gtk-menu-bar-accel leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-10-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QSGYLAEuOVNKuO/0oYNvTJK7sT8eRkII3yvwZCdQ8MM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4j5ziMO7eIsJPS7cgmHK+47Vux5cRw5T+ON
 dzsUeKoiCGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IwAKCRDa6OEJdZac
 5cavD/4h560UzyKhXtXp9swQ5o56L1gv7AzD67anajIoOJh9pHCvaPlzPLUXv8ME+A9loJhEvI7
 wyyvJOfIcjWkJZm3aVeSJODXRL0CbL0lk+q4Xwe4xWrcbr0x0MFUAGoY0z9uo3xPIhJGA7NfycU
 FPHKJaias/l24SpiZ+0mQ12DEScCsrasZcB815mUbIfpPXDFb35RIARVhXBYTKLJBi2rV3qlUPK
 4jc5355/sLX1VFxRDO55v7zcN31KX+02rtAYK7xHogbnRycIIUZBShFa4nPGPjiyxB4qoiJsl5S
 R2Rq5OCHbGhtBbDHvESN2VAKFFBnWRgDsI0rfbb9D1wfVlHQOUw5m4tv14NwITAJLWSpgXENhC6
 trXxew9vg8StovddkdXHLFrTLyzt1Cfi3HrQbmXVSFgqphfuucRPcS11cnTM2CkbWEDaKyXStGP
 xrVFO6HRTO3xtm/+yLXLgpWdFdakxLMt4QPlPRIH4meia7ux/WsVTAeDAm9ytaPoPsR3XQWu4oX
 bMFm5mOyrcrW30/IzywSqPK8mG5JpZ6uW6gXP15N/MLhY3iS4pwjXvjdtbhWENHjnskglm4xo9P
 x2bgkqdeJFSDbmSly2d9Y4uuXWeEHNAkumBio3bwUju/+Z8py/yGtiKvcyl2ssjlwKhhGfkvRfy
 Ws/i+1ZnyBaFTzw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The implementation of the gtk-menu-bar-accel property had a bug that
leaks memory when the set value is an empty string, which was fixed
with:
https://gitlab.gnome.org/GNOME/gtk/-/commit/44bf10c4a2a0463891884a105fa27cf36b73f119

To work around the issue for old GTK versions, replace the empty string
with NULL, which has the same meaning for the property.

Message-ID: <20260913-gtk-v1-1-3e4ac542e054@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index c615d35451b6..ae28f1fbb89b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2645,7 +2645,7 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
 
     /* Disable the default "F10" menu shortcut. */
     settings = gtk_widget_get_settings(s->window);
-    g_object_set(G_OBJECT(settings), "gtk-menu-bar-accel", "", NULL);
+    g_object_set(G_OBJECT(settings), "gtk-menu-bar-accel", NULL, NULL);
 }
 
 

-- 
2.55.0.543.g5ebe2ebe4ea8


