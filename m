Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0696FCD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUEg-0007bS-Er; Mon, 08 Jun 2026 03:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEe-0007b0-5o
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEc-0008Li-Pc
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42pjXpnS3GuIn7s6Zh3seKv48mIlHa86AQ8iMF/OKzA=;
 b=ZG/ml+HJmmUYipUVrx/wWzniJAata4kKu206d0HJ8I5k3+y8AM7/6aBLbbTeQrjS6ihEv7
 wnAbC4UaTQyvylo+wzPaJn97uT81OeSmlFyNRvwCGVNVQMGbf9E1Ez29EqhLdvLRRAadR4
 0FwYltpTcAlFsJErryh4+bDmxRdzY+A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-Hz9-mQ0kPg2ccKnwxA02Cg-1; Mon,
 08 Jun 2026 03:17:18 -0400
X-MC-Unique: Hz9-mQ0kPg2ccKnwxA02Cg-1
X-Mimecast-MFC-AGG-ID: Hz9-mQ0kPg2ccKnwxA02Cg_1780903037
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C4B219560A1; Mon,  8 Jun 2026 07:17:17 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 167D21624; Mon,  8 Jun 2026 07:17:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:25 +0400
Subject: [PATCH v2 07/33] ui/dbus: remove mouse handler on dispose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-7-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=719;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Zlbop9zuN6D0e4GxEJlAcaL73bwcfVgoQ3P7DEp7fMs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxIl0k7OJW2wftFX4HM3DVfNXftb7kh5RfHQ
 z0LPZliz4aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSAAKCRDa6OEJdZac
 5YW/D/9c/3BUi5xDZvezUbEtrwKztoYJ3uikyESq6CJvC9cUt05ccQJOyV28tWJVlG3DdwYJ+1g
 XxwKJunAYq84OuMGsf3ndIZ5T1said5AYnbNywJmuW5iFh9wbCAkbCBMfqtHsF8eMnMiZQUQM0W
 Ss5DsMvH4WcK2m5x8XKafTvQn31W8yfTcxsh01SXcGjmYJr1MxDw86G9edLV/9LcsNy+Q1tzRG3
 EUGN08NtwJkRimfxeyL3ETgSWd21jKy10PZ0BT26bjgIqdTCXYZVE19HusfLTZrZzF7OpPO1sTc
 NADWOlUp7ecC5ANC7Lw2IqKmiAUF27VvcZO/n7b9OOkhVfmfDAFEmoFc6vkpt5r81cQ8wM1p7si
 N5tTlSgCy2V6+xv68JZ/39XwDFmUfFenFFusaion3T/rGDyVCaF3lgrnsh3to5De5LqCRDxIq8X
 H9Jw6d1NxjLGCi8TvXqKf2ZNoCzxzyZ8hRmEtWhUSxiEIYEikBcf1Y5PhfMc1ocUBFiiWnjRLpj
 9kUhVSl5X7ES1jGp+NlJrrIvh1LD4LkGb2rTyR8sqBhh9/vQxqbwoilShdP/vuMTITlPPmXau5n
 haSBy9vzHjbOSB7quCF+0fbusDscHDjUutcBeZfC+ULGPrTS08VN+2j7LXyrsw8JqQ8doG2xysE
 KkGIXUO2IYl1/eg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 21eceb24362..0813a08f85e 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -151,6 +151,7 @@ dbus_display_console_dispose(GObject *object)
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
     qemu_console_unregister_listener(&ddc->dcl);
+    qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);

-- 
2.54.0


