Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE8DCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbL4-0000fh-EE; Thu, 11 Jun 2026 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbL2-0000TQ-8k
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbL0-0004fs-SK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pcyNGo+qPF7A1W/+3xFE1YsJUVgw/+6amnmb5TgNlI=;
 b=R+lf4/zUh3HHeFRpjfGZr7OyQJYtbn2SOMPAYOE+NlugjF63+UnVVP9vruM+4MBAS6sxlg
 GXE+8QkIZS9x/2nUNZsMRTS7dHKSB2epg0EO575OVF4NxkyjgRdVqz3tRmLm97mPm1Qk+H
 KJXPcQork6AEKuOCQ5rbBLEKik5tfEE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-CEsAmOJDMLGyO_lFg0ISxg-1; Thu,
 11 Jun 2026 05:04:29 -0400
X-MC-Unique: CEsAmOJDMLGyO_lFg0ISxg-1
X-Mimecast-MFC-AGG-ID: CEsAmOJDMLGyO_lFg0ISxg_1781168668
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EE8619352EF; Thu, 11 Jun 2026 09:04:28 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3328219541B2; Thu, 11 Jun 2026 09:04:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:24 +0400
Subject: [PATCH v3 09/35] ui/dbus: remove mouse handler on dispose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-9-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=775;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oU6JmTe/phIh4luHU7JB2qhh1DBckGQ34XnugyV3zOQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnezvZUS4DVOBPYIPS/qFAqAM5dNIK5ZbENI
 +matzbYA0qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53gAKCRDa6OEJdZac
 5WqbD/9LKaBGPU+wJqz77ZU0Lu6/nVMupdunHVwShFJT7AlvVxDmstT84YHgLzkR+XwMh9u38MB
 5gR0MsMnqrW+3o6CZ0w6Vua7LbuyBYqq9u+bNKlLrCASaO5Qkq/y+Gw83bblcw4lUwSNMUQeYK/
 3EIgOSL5iyeCJOhZJVKlTku1l1DJKTtoUBkuGuObQef7dscej9g0AYy36BpxDXi52qUmmHVWYOb
 GJVCAur+9LGip6JqBcAF92w3cveDndchfjUOGO07XidcLja0povMGPomYYEUGMTaNlwx5ogLedj
 g7NCkjZIo1/3aUct96O+68cQ7co5iWE/mwEAUSvj/syiL3GQBiiftIDZ5doZ85R3VthPX7CMe74
 PcQnE/LQfdbzRVtSRkHmOjWCwHn5JG6usY9oYpGZ4WfoiIKmIpl6B/lYDbRgHDUnNV4kmZoGK1h
 aGBki6H7SMSUfceMMCGFnq93k2X7F0682l7nm0xvveiRDxwO3xcI81zgWT3HTw1r6b168F5ccSJ
 z1Du7ZXY1AAC1bIvcxUCu7Dr4jVbtMS11IkdrWKJJOmpbezc1kNNtyl+i7+m698p0AZuVp7CCZA
 9ELJxBffNLg7zvdnWmgN95goCGNpmvsRgDjbj04S/BbraK+LXT8l/GTPM5mTEintxCpFX446yvM
 nbOmseR//RQoJ7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Fixes: 142ca628a7 ("ui: add a D-Bus display backend")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


