Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4824BCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvqS-0007DQ-H4; Tue, 23 Jun 2026 03:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqR-00075J-AK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvqP-0008J4-Qs
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BS5+8uDbUO8tnie7RIoFtC9U2mSiMSeu6Pam5/wgM3Q=;
 b=SSajDqlyKk32pCWRpGbdrdQRQ6ukQBWWOnSZFQu86Y9XfVNHD0va0Q32eRDhyor9Gfy2d/
 qwMF5ufloEW5037w4fFd41ei2xLWJvwiWL+sWUjXvxT10aoBZ9l0eCyX1+DuViAqe/+2y1
 ADbb4GDccjv6zZHn9htCCGdEWOBX8rw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-kscpTS_0OO-jGaa5po8-qg-1; Tue,
 23 Jun 2026 03:46:49 -0400
X-MC-Unique: kscpTS_0OO-jGaa5po8-qg-1
X-Mimecast-MFC-AGG-ID: kscpTS_0OO-jGaa5po8-qg_1782200808
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A7411955F70; Tue, 23 Jun 2026 07:46:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C3741800593; Tue, 23 Jun 2026 07:46:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:39 +0400
Subject: [PATCH v4 24/34] ui/console: fire console ADDED/REMOVED notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-24-4656aec3398d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6hGNnrGYNd3ibRqfbbVKqo9FqKz4axEEuiTBy0WRKJo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjleunrM/k7DwQ0/F6iKQrmpkaEDh2TAdJR9v
 GAFx1k3EJSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XgAKCRDa6OEJdZac
 5WI8EACj2er6KZKW9XrO6d/3YBEjMvbqnnfOzu2VUzFeue60SGMyneIzgS0kydQXO4DxwNbFHSm
 zTCpxPE6O+Kyp4IMd5ROsFXRjd/kGHthK4VfdrWrDIjVauutV7n9B9UvN1/T2FfkaJ8Idr7yBon
 dLNNAV3ujCo8hSTs6EvQ1BptYmMHf+/qdAl/jUiRuS5/yjeRwqByzHCUXYJaxrkMDc7+PUiIjc9
 L/QP2fU0g59ghVfHrJBRjcCqOB0vLh0Tgzd65T6AQOwXQlT80l44h9oFpgJg7q7yridP8k6IB9h
 ebngP6NfD+8uMbfaGQIaplK2ms8RCnAjNa0KZ6KjLMLGJNptbPwt/raBuscsnwvonhCf/h4uWIb
 SwnEHMiq4R/SaLX+fwzTxYud7bl7wapkncR24Hw3K/jf0AYh0wa5+CW91DwUaL7usXWllWbwRJz
 MQy+75AuXX81+LrTl17kENvMzSYhWvQNf6Iz1UCIPQ02wGUTH6xsNDyoUwGC3YKeTZMVBGnT6r+
 GIcwhTuz4ZrCcUi2UPShCu/k1Zf7H1gGXsW2BpNy1fBL9tatZpLSfZvZXSEr3FrO255eUkwo6sq
 rJDhCDam6sl0rAeCsAFLmxbK8JHdM7XTCJYVKXjsCMb1APVIKPocEWjmcpG+FNsj7yZi2ZD/Yb3
 cbCUR2JlagOCw0w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


