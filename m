Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC70606A329
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UWKZJjxy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNULc-00080K-Vi; Sun, 01 Nov 2026 07:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUL6-0007xY-DU
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUL4-0003ZA-LJ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeDah+VKW97RJc7gvLmyRHLnom9rEf0TvC5+5afZDPQ=;
 b=UWKZJjxyclubtqu9uGUquHNsjdUg9UDjxklW+2ZVw+wK7aONSNxofqBFLt0yujBIotwflA
 yp6hlHNTS01woWrW0XT1pzN/bVLFFMiBaQvvPwPFPtMcTEwGPcTMMbixTnvzT8gdbUmMgm
 72XQL5aP1VQAOyPFNbrOTOcvtFag6os=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-1rPgX5FQPsWix8eVpd4sAw-1; Sun,
 01 Nov 2026 07:07:04 -0500
X-MC-Unique: 1rPgX5FQPsWix8eVpd4sAw-1
X-Mimecast-MFC-AGG-ID: 1rPgX5FQPsWix8eVpd4sAw_1793534823
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A50FD1955EAB; Sun,  1 Nov 2026 12:07:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9EC71800446; Sun,  1 Nov 2026 12:07:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:39 +0400
Subject: [GIT PULL 6/9] ui/dbus: send a Scanout before the first Update of
 a new surface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-6-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3678;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mQCqn+g1HRb6Y73pYT1WxXgDJTbqQWNs86rDmjNlgm8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOkuJha4ItF75O1FQuXklotCIipAz9Hpd/w
 UkX8rGTCj+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5a+2D/9Lav5apLADldyeVM9CoXZs0/nUo82DHAPBDrOZ5id0iEHZ1y2/QzZK5v5Y8SpjhaVlCcY
 DbGBJ7v0sa3eYOl3mOONIYsYGdfh6kRVhTTw0Q77ajFBarJZtcWOshISLfT5OLNJKdeSyxyfPJP
 kKNVkir6IKB5ta6zDQg084dscY9HT2Vl3zvAoFv77/m6EHhh969B6cBI2lbzlfslkqqNW82v9AV
 9Uba4NgnZEsycQssGm717WRZ4ofzP/pf1b0N2IMM0eaJC5D390E8W/eOzkfUGVzTnOUQkr8mXus
 rfh9AOZRbMiKjaXlRd4sX0ld9YLOnwAL6G9fwRXQb8hEoi62EsTfJ+x58RcQpYEhxcRa58Zvhib
 GDmZs6Ic2up7WwH7oHDzUvuajbfabq9nT/ZkUt/EVlVUCIna6K3ANwwF/s3pAXE5V5HhtN+6h2+
 cPRMCoDMoEZunmtIaQkEn1BCdKlxR9jrufX+SnIt9GWmVxrTP2E32cAXVu6K1KAN97FOWEysz2u
 amq2ULeLR2K+/Av1lDK9rLgh8yG0kVzKOSEwzsky8taolNw3wvFHa0wDjQsSLh0iTOyjcN3lpbr
 2/QaydRlRtKIPzphAw8I74qk/SQXgibqGICndgIHnoYhdpbD3tezupViDmTE1IkT4S1NmRJKeI1
 c37MuTm6udEE5fQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Quante <christian@quante.one>

Without OpenGL and without shared memory, the D-Bus listener sends a
Scanout only for an update that covers the whole surface, and
dbus_gfx_switch() only records the new surface. So when a device draws
a new surface in parts, the client gets Updates for a size that no
Scanout has given it. VGA text mode is such a device: vga_draw_text()
sends one update per row of characters, so a text mode that changes its
size does not send a Scanout. According to ui/dbus-display1.xml, Update
is only called after a Scanout call, and Scanout is the call that
resizes the display.

The client can learn the new size only from the Width and Height
properties of the Console. They come on a different connection, and
the generated skeleton sends PropertiesChanged from an idle callback,
after the redraw. A client that sets up a new buffer when this signal
comes loses the rows that came before it. VGA text mode does not send
them again: it redraws only the characters that change, and all of
them only after changes such as a new font or palette, or with blinking
enabled.

The Windows NT 4.0 setup shows this. With blinking off, it changes the
character height from 16 to 12 lines (720x400 to 720x396), and in a
D-Bus client large parts of its blue background stayed black.

With shared memory, dbus_scanout_map() already sends ScanoutMap with the
new size at the first update after a surface switch. Do the same without
shared memory: the first update after a switch sends a Scanout of the
whole surface.

Signed-off-by: Christian Quante <christian@quante.one>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261022134335.12241-2-christian@quante.one>
---
 ui/dbus-listener.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 624d0fb71d6b..26ed84d70062 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -71,6 +71,8 @@ struct _DBusDisplayListener {
     DisplayChangeListener dcl;
     DisplaySurface *ds;
     enum share_kind ds_share;
+    /* true until a Scanout or ScanoutMap of ds has been sent */
+    bool ds_scanout_pending;
 
     bool ds_mapped;
     bool can_share_map;
@@ -480,6 +482,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     }
 
     ddl->ds_share = SHARE_KIND_MAPPED;
+    ddl->ds_scanout_pending = false;
 
     return true;
 }
@@ -591,6 +594,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     }
 
     ddl->ds_share = SHARE_KIND_MAPPED;
+    ddl->ds_scanout_pending = false;
 
     return true;
 }
@@ -844,6 +848,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
         ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
         surface_stride(ddl->ds), surface_format(ddl->ds), v_data,
         G_DBUS_CALL_FLAGS_NONE, DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+    ddl->ds_scanout_pending = false;
 }
 
 static void dbus_gfx_update(DisplayChangeListener *dcl,
@@ -872,7 +877,9 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
         return;
     }
 
-    if (x == 0 && y == 0 && w == surface_width(ddl->ds) && h == surface_height(ddl->ds)) {
+    if (ddl->ds_scanout_pending ||
+        (x == 0 && y == 0 &&
+         w == surface_width(ddl->ds) && h == surface_height(ddl->ds))) {
         return ddl_scanout(ddl);
     }
 
@@ -907,6 +914,7 @@ static void dbus_gfx_switch(DisplayChangeListener *dcl,
 
     ddl->ds = new_surface;
     ddl->ds_share = SHARE_KIND_NONE;
+    ddl->ds_scanout_pending = true;
 }
 
 static void dbus_mouse_set(DisplayChangeListener *dcl,

-- 
2.56.0.116.g6de20f6092dc


