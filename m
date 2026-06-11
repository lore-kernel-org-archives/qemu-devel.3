Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AC6CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbMA-0004m0-4i; Thu, 11 Jun 2026 05:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbM8-0004dD-7k
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbM6-00059E-MN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3G+Z9C/f5p90NyI5uU870dyyh7DrtQUmLbu++czPQg=;
 b=UJQh0z/J4Bz4AJk8Q9I6dPZ8temUSvKSqvcArlUxzsSwiZCoVxdwcqpkSJSa5n15Wiym0y
 EViuaeYd0gavoN9QN1GdLviwhgm3vMfatLE96fmQ5L+kf/0VR1hMWr3KvSkFbHGM/TOkbu
 OlRRs4WTiibOnRx+82S24rMJDmOk4wM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-K06Eifz_OqKkGew1DdmYcA-1; Thu,
 11 Jun 2026 05:05:38 -0400
X-MC-Unique: K06Eifz_OqKkGew1DdmYcA-1
X-Mimecast-MFC-AGG-ID: K06Eifz_OqKkGew1DdmYcA_1781168737
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 331501955F20; Thu, 11 Jun 2026 09:05:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7D7F27A; Thu, 11 Jun 2026 09:05:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:37 +0400
Subject: [PATCH v3 22/35] ui/dbus: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-22-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pi+9APeT868BBLg7deiC9tV8dSRWZVksHDtFnOyZ704=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnngKiWILcZt6HNnBcYT9NUiY1h+TkBq0avud
 jGvr5Lt/Y2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip54AAKCRDa6OEJdZac
 5ad6D/4nhjThoDRlweuhBnmny4UsV0CExe39sAyGbmPxKXZFfEZHqIR5Aaq1M1Jt6N1H2u7Ga5K
 RVj2JjLKEmWrCxS6RhYXKgh4NyAQdEwro2BgWCG4hIsN4gUlyJjd7bG08wSbxBsyfsIlsji8XKZ
 93L1B5yYZM5PtoSRxJHtIHSo7RJJYDhvFNEP4FvdiTTgR9Ds1j8AiWvDNzBPsufOCk+/xag5VPU
 vBSGsopnX4w3Ps2O87cMtd2gN2HQSeIgbgzwnjUYOA5/HOihc1bKDkbiufFz1rSa/Wvo+chSw91
 LdNdJ3tT3ttwZapHLmcJmZy0j0X5QACEZc/5DmYhMNZs+uzkJhv9PdIeqjdcZW2NQlRcEqYJjza
 EMEr2LcU7OTHtcEhk2kOLRZkahCcZFaMzkx+L/r8a1n9h9FXCVyUJpBclUGixAX79dNVOhVpcUd
 UUsyRIF3VgaiRtGxEgLsuYB+A3afEfudCSslUz8sdWIcTBFKAeMqw1OSf4lpBV5hurVxazhJTdx
 UHQ20QydRwQFmmtANhoFePXtpL9Sj9CSBYh6FzpGuWMRJMYeLFBRS9eELBLK8kxcZ+XZrw7FdHa
 YR4CuCxOv1EzFwBVFPdl84p/m0gwTkOotpA/7Uf7qovNyToWIrDsficlIsBqNUxibcPLb/+dxwc
 XRwcQuJrMa05IGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add dbus_cleanup() to unparent the D-Bus display object, ensuring
proper teardown before user_creatable_cleanup() runs.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c |  3 +++
 ui/dbus.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 742bf9639a4..63d21493101 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -152,6 +152,9 @@ dbus_display_console_dispose(GObject *object)
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
     qemu_console_unregister_listener(&ddc->dcl);
+    if (ddc->dcl.con) {
+        qemu_console_set_display_gl_ctx(ddc->dcl.con, NULL);
+    }
     qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     g_clear_pointer(&ddc->kbd_leds_updated, qemu_remove_led_event_handler);
     g_clear_object(&ddc->iface_touch);
diff --git a/ui/dbus.c b/ui/dbus.c
index e02a94df2f3..b23cb44c535 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -615,10 +615,23 @@ static const TypeInfo dbus_display_info = {
     }
 };
 
+static void
+dbus_cleanup(void)
+{
+    Object *o;
+
+    o = object_resolve_path_component(object_get_objects_root(),
+                                      "dbus-display");
+    if (o) {
+        object_unparent(o);
+    }
+}
+
 static QemuDisplay qemu_display_dbus = {
     .type       = DISPLAY_TYPE_DBUS,
     .early_init = early_dbus_init,
     .init       = dbus_init,
+    .cleanup    = dbus_cleanup,
     .vc         = "vc",
 };
 

-- 
2.54.0


