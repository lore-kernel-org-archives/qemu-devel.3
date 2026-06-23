Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55732CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvqC-00069I-KN; Tue, 23 Jun 2026 03:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvq6-000639-Bt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvq3-0008Gl-Bm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAZq6fm90RH8+U0CFVr2YIwSu9l8OeLSPfjmA/gp7DY=;
 b=XP74ZAwJHzj8mh+LpymbF3RCEIiF12gE1nDmNHRey5D3tqvZM36nEoHjkBkQ1ljrpI8WgH
 3Ren5dxNvuKMlqj5JGrsqVhZKwGNc0dcEiwugULXBz0BMVvlqKbkPpMsTej9LVZU3rbfqp
 g4pCAVKb0WZmrwSXZXoKBByHVZw1/KU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-czEWwAc0M-unqmWY3d-ARw-1; Tue,
 23 Jun 2026 03:46:27 -0400
X-MC-Unique: czEWwAc0M-unqmWY3d-ARw-1
X-Mimecast-MFC-AGG-ID: czEWwAc0M-unqmWY3d-ARw_1782200786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E1A41955E9F; Tue, 23 Jun 2026 07:46:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D285A1800347; Tue, 23 Jun 2026 07:46:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:35 +0400
Subject: [PATCH v4 20/34] ui/cocoa: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-20-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HykoT1JvYFnZV/NmtGmkJ57XBE/a/Ecau6SBb5B8jB8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjleM5UCU9JOBXu5efjrJAIRD2e0RYKR1bXFf
 8d/7dnEhHOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5Y7iEACLTA24iJwEuWKv9Zcivcg76lOSGwaBiUoUxG1ooCVz4Qr7+HoIUxt7ffzD3Hcq90LJUcn
 sAnSqru2VXDK8nJRB30Qn372bpNtOXlyx7sCTyfwAS5aFzojX7ZV+qvfM9FOn3Z+JUNXMHf1Otv
 u6Ptj5ribw79PAOp9TVIOjL+PX0VsopoLHwmTgQHYzL/NgSqAEixggBXtfbzf4taMxiYdRVHWo/
 s+Wxhajw+7LQRXg8t17oGeJBfho05QVh/m7GK61Xdu6s+V4/w6fHW4RE2LULYbPQcSIk7KYhRRe
 xz6CXaU2+JtzNaW2x8rF1MQIaIA/+fIXr+WpxPbTdkdhAqyOaSCG7LmJ9PyVfbrWV0kEPbxEijo
 9p9mudvUnTjmr5ppMSXI5Dbhpzg6yK0liOErDJ7kNhCse7KhrW2pzZ5CMRzhHlql8/DrLitQju6
 3X7q/zrIMbDfT0tHDUo68j2QOxdksUq1Y1IIxljehBtOL7TCCBtas6we/kttzVNsQ/Sxu/BNfAp
 sAiOWQI0ngiG/CO7K5PfozlJyV1xm7lTA6cb3qMEm2h4tmmo5ukOCJA7uthuvcIfD+u/NmnWuw3
 MSwgXRbKdMWsB6YU8WluYZDixiW8lhS87uBVTNsNc5Z2jNDSMVS98jV+TzksFYtWdJaRK82d+5R
 4stPLxhXDz1SGgQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Move cbowner release from QemuCocoaAppController -dealloc to
cocoa_display_cleanup(), since cbowner is allocated in
cocoa_display_init() and cleanup is the symmetric teardown path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/cocoa.m | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index e157ad01d85..3751be37922 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1206,8 +1206,6 @@ - (void) dealloc
     COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
 
     [cocoaView release];
-    [cbowner release];
-    cbowner = nil;
 
     [super dealloc];
 }
@@ -2038,9 +2036,26 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     qemu_main = cocoa_main;
 }
 
+static void cocoa_display_cleanup(void)
+{
+    if (!kbd) {
+        return;
+    }
+
+    qemu_console_unregister_listener(&dcl);
+    g_clear_pointer(&kbd, qkbd_state_free);
+    qemu_remove_mouse_mode_change_notifier(&mouse_mode_change_notifier);
+    qemu_clipboard_peer_unregister(&cbpeer);
+    g_clear_pointer(&cbinfo, qemu_clipboard_info_unref);
+    qemu_event_destroy(&cbevent);
+    [cbowner release];
+    cbowner = nil;
+}
+
 static QemuDisplay qemu_display_cocoa = {
     .type       = DISPLAY_TYPE_COCOA,
     .init       = cocoa_display_init,
+    .cleanup    = cocoa_display_cleanup,
 };
 
 static void register_cocoa(void)

-- 
2.54.0


