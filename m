Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580AEFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC7J-00005V-R0; Wed, 29 Apr 2026 17:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5m-0006Ss-EO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5e-0003Vd-NU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xEMaCQqjSebJ1+71cJFBJzEXz13GiV+gV7EIYyxol8=;
 b=Ivkh4Pxj2G8r+di/6Vkq2giMg95zY7HAjI20SvZMRMOVsaR3uXQnnWeR4qJk8NfP1jtzqu
 zdzL0aGhxxsW9WU5+fCtWHVtOdggoohcxtoliA7L+zb50dD3N5U7XqwiiOJaLYzKDJ3hdS
 Z+QAS2rGEemiLUwYbhDj41AuL8KeWII=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-3l_ft1mkNP2D-gNrxN8AfA-1; Wed,
 29 Apr 2026 17:04:59 -0400
X-MC-Unique: 3l_ft1mkNP2D-gNrxN8AfA-1
X-Mimecast-MFC-AGG-ID: 3l_ft1mkNP2D-gNrxN8AfA_1777496698
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2EB718004AD
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:04:58 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3D4D1800480; Wed, 29 Apr 2026 21:04:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:51 +0400
Subject: [PATCH v3 18/26] ui/vnc: defer listener registration until the
 console is known
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-18-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RK09TmaDHI9YqNxso5kjLy2qpHqN5kF0JjAA2oakXGU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIMH3Nu8J+aiKH8UyK7dbTyZivqBc8wshoww
 UeEG2dABeyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyDAAKCRDa6OEJdZac
 5bqED/kB2HIIs7nJrZaHcJoXvWv8vy6SdBeoGHxBvMOUmdufdiVURXjrLY4VtLurf+GKh2guuBL
 mI5R9jAMj8DrKMz3smJDK1Ki2xWoB9YexsW/K0NxQfJ7FQMdju/fuGYSp+4kzs/QHydrwe01MEL
 T/L+P/LSZwkye+GFxj52+MKM2WDK921/6npKXq0B6vZNr/lqstvX493OlOHM151THGANwocShqY
 9v8ei7qHoxMR/lV/g/I71UcGfLo7yuChYMEl5kdOENywdih+qqZJ1th68cIcPq4AgUhpDoMvp9l
 dyS7XjaoWwAGisYLiKY+SQKQPylMHdBG25aUy4StIA6jAtzAxRVc45M91cR6EmdsW7iAz6iQB0d
 oPa3C2zGo10mtF2NTaC77M8iW3MAzfUJsWJIZ3g1Yf4PVygzXk/Hd9XOXD99FzZesG3t9WGNDOj
 SZofDW7tKlp97/pWwTdl1bRTUtBC3VfdOcq+LBw/6c9LXCzCDLKSjLxbRzEZTjS8HQthicYIXxz
 OVd1hcwhfv7ucyB8J/sxFBBwjvnKH3FjyCsPTGyH/OoOkOOhaTTU3lVmg5GObeLvD0O3jUjbeST
 AD7GLZbQI5FX46wmpwVOWXeww5bTuLwLNfS5C8x7Wy6DvhIQ72Stc4ix0zm0T9wEiDkC8iX55Jo
 P3NPv79F6cUXlhg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Previously, the display change listener was registered early in
vnc_display_new() without a console, requiring vnc_display_open() to
conditionally unregister and re-register it when the actual console was
resolved. Since vnc_display_new() and vnc_display_open() were merged in
the previous commit, simply delay the registration and keyboard state
initialization to vnc_display_open(), after the console has been looked
up. This removes the conditional re-registration and simplifies the code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index d65153a5001..ea1579135b8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3457,8 +3457,6 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
 
     vnc_start_worker_thread(vd);
 
-    register_displaychangelistener(&vd->dcl);
-    vd->kbd = qkbd_state_init(vd->dcl.con);
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
 
@@ -4269,13 +4267,9 @@ static bool vnc_display_open(VncDisplay *vd, Error **errp)
         con = qemu_console_lookup_default();
     }
 
-    if (con != vd->dcl.con) {
-        qkbd_state_free(vd->kbd);
-        unregister_displaychangelistener(&vd->dcl);
-        vd->dcl.con = con;
-        register_displaychangelistener(&vd->dcl);
-        vd->kbd = qkbd_state_init(vd->dcl.con);
-    }
+    vd->dcl.con = con;
+    register_displaychangelistener(&vd->dcl);
+    vd->kbd = qkbd_state_init(vd->dcl.con);
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
     if (saddr_list == NULL) {

-- 
2.54.0


