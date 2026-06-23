Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B8ECD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvqY-0008HO-V7; Tue, 23 Jun 2026 03:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqW-0007pR-Pl
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqV-0008JZ-9o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1PMzPwuEXW67aOzPq+tpb4RknWUk4HcTWyNDmnQBKs=;
 b=N7wWFC6hakZt8kvjGMxOBbMUOmKQk3m2aO0L5GjgXqINI3gP32BOFEpin6nhL0GJbu40dN
 62ffyxBLLSrnUr7d7BBbbUrpl2bqTzZOqUaYxXl6SwCuiedIztP/jshl1Wlo7tOB7msFEQ
 kEs77GHAeJlgTx1XnNqkFRh+Gn92dS8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-FVmyDVR3MpSMBk5ZZs70Gg-1; Tue,
 23 Jun 2026 03:46:55 -0400
X-MC-Unique: FVmyDVR3MpSMBk5ZZs70Gg-1
X-Mimecast-MFC-AGG-ID: FVmyDVR3MpSMBk5ZZs70Gg_1782200814
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1258918052ED; Tue, 23 Jun 2026 07:46:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CFD930000DB; Tue, 23 Jun 2026 07:46:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:40 +0400
Subject: [PATCH v4 25/34] ui/console-vc: fire ADDED/REMOVED notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-25-4656aec3398d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YapQn9Mbsz473V4fTJPToKR0zvzbCFqEf4qxDOs0Qtc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjleBF+Rp+03++K4oqQiVpGN3I7M+zCcEnuA8
 zGllsTW4BaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5dmWEAC5RE/GcrnpGs9wqrw0oDRtIvh7ElxsF9mcWakzuOrB2j45YwFHt0tfhE6iwyz1fPnZenG
 BpXooNY7OESpxYkNLnYc+3keLDFc4MnVYLb459SKGv4uJIhG+ru11OyJ/vazmZC12YK5lmTHm1e
 vFpLgFhLY+vMGLTsKjYHRqPw6RTUzq+3uR0opEhBMoA6bnw19zV4mA+KjfJOa4ZfK/wPGNBpTnB
 I/NeHcapHD7BXsYAyZfTKIMEkAZAChA5oGrN38ux9ToWE45HWS9Mj58UkPGIcXF9MXfkdttK2Qw
 0oEdJJpomsDfdjLZtcz3BsbqMSEE9MlAARHnBEtVKwBxKTo8vAToSnBZy1EyUlwAVStJaNX+gS3
 RZzCXy3gFyX2hfNBcc31uTA3mRcBax2JsUmFEyLcV/NHvSzll8fENj/hWZzSKqi5a6p8GIcD7cF
 BFmK86M9hwUjzEKhw0uQoxjgmFYxFi3sVZyGqwJeg6dVl7YGcxhLKAOaI/KPDXjyYbDbaP1ujcM
 1pxcO7D7A+Fzlcjk+EK2spdP3Gh9bqBFJXGXng24DAgZsYUP0M0s8AQvEzS1eoUYOsyqcf4Jw07
 sAZbmSpLoRBRUIa3tJ3QVq56IOcC+XwBvV/8eYFST1Vpz0Xl+wdU5vUlnQ+i7qQRBTz2fZDAVlh
 ItVkv9hU8cw1zGg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Fire CONSOLE_ADDED when the chardev is opened.

Fire CONSOLE_REMOVED in char_vc_finalize() before dropping the console
reference, so the console is still in a valid state when listeners
handle the event. Also fixes a console object leak by adding the
missing object_unref().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 828e78c41ea..53d9e9d39b3 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -255,6 +255,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
+    qemu_console_notify(QEMU_CONSOLE_ADDED, QEMU_CONSOLE(s));
     return true;
 }
 
@@ -327,12 +328,24 @@ static void char_vc_init(Object *obj)
     vc->encoding = CHARDEV_VC_ENCODING_UTF8;
 }
 
+static void char_vc_finalize(Object *obj)
+{
+    VCChardev *vc = VC_CHARDEV(obj);
+    QemuConsole *con = QEMU_CONSOLE(vc->console);
+
+    if (con) {
+        qemu_console_notify(QEMU_CONSOLE_REMOVED, con);
+        object_unref(con);
+    }
+}
+
 static const TypeInfo char_vc_type_info = {
     .name = TYPE_CHARDEV_VC,
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VCChardev),
     .instance_init = char_vc_init,
     .instance_post_init = object_apply_compat_props,
+    .instance_finalize = char_vc_finalize,
     .class_init = char_vc_class_init,
 };
 

-- 
2.54.0


