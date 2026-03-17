Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09540F33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QE7-0005N6-VU; Tue, 17 Mar 2026 04:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCy-0003V5-5G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCu-00074G-Sm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yCXR2+AcR/DGDwWpZSm9RScE/rcFlXwHiIjwQncmniw=;
 b=iSU24QGx+LBSgAeyCAkOJ1rw+7ENmC00IRdh3ppCy/B0sJom18spZONg6+8pRzYGrdg8I9
 rAx6NIRfmUjPYxcMmleAlj+6B97S866yrwK/7fsFlNZg+e8p9VYsyzInypwRY8ASeE+scy
 osBgogIiUapQrwp9ztLvSgAzTtdCnIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-la9ebm_5P7is5p_8Mnf3cA-1; Tue,
 17 Mar 2026 04:55:18 -0400
X-MC-Unique: la9ebm_5P7is5p_8Mnf3cA-1
X-Mimecast-MFC-AGG-ID: la9ebm_5P7is5p_8Mnf3cA_1773737717
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DF95195609D
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:17 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A03001800576
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:02 +0400
Subject: [PATCH 48/60] ui/vnc: defer listener registration until the
 console is known
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-48-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lSKR0ylzg5pfugxCI27NznzkCqR45WH+pLi9aJ4ssU0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcK+tgrGcTdVAArYW/wTmxvNGRZtZMbONzV
 vf3w1rQLdiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5X2tEACOzFM72rR5QAfjvaBeOxPWMKgDOYVsn7ZnqSNy3xKoOb761OABusm1TGz75QxtwKx3/iu
 F0pD5pv5kNsND95TemYd4uNUM8lRRvBxMFxmKhTjYQVQoVjYXZo7Noc2M+wY5/1H+jEks9WDFMZ
 gNrGWsaxZSN7SFr24PxroSb3Z0AFI6u6TpAZdR0xVpX0Y9L4wP9HSggzAaEIzgAdNcZdJuIfDIT
 bWqe4b1MR+K/QM4IkydzUV0Ad1tT1hhq4KMIfrzQbRr5kcEDFeVWUapNA+h/Fsoufn4da9owL5w
 +ZoH7mV9IVGpprAZK5s0i2lgKw/ob0RhBRveY99WL+iaRiAdOW4iMwJkZVnE6HV32qRSsLgJZCj
 qhJWVLUWZipEploJumo9bHDkIP2cIPiQQGQujxVs/ICytw5SiYpSHzPyRgNadAk8LGKyVSS0Z4j
 As0MPVbHbiQjD/iuKaa/46y2NUsmDxoLkMSd5t5AGaGJTYotqosJiaPPUsUMzRzFRiOmRAXjIhP
 9iC27oaxitGB//o46xG+7StETpMdf2pVOu4zlu79AnSFbU6yzsfK6OiGGYublc8CbAWQEuHUCYw
 krMwKG3hugZ6rOAPAcOSiBcuvqWHV6GD9BiAB5xTKdgPL691KnrCrZ49DZZxpMKEZrcu3Zuof7J
 eINzzD73LdYVB8g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 2c53c92914b..c38be7113f1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3458,8 +3458,6 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
 
     vnc_start_worker_thread();
 
-    register_displaychangelistener(&vd->dcl);
-    vd->kbd = qkbd_state_init(vd->dcl.con);
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
 
@@ -4263,13 +4261,9 @@ static bool vnc_display_open(VncDisplay *vd, Error **errp)
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
2.53.0


