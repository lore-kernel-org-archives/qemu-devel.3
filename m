Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD2ECD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbMO-0005fv-O0; Thu, 11 Jun 2026 05:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbMN-0005Zy-Fs
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbMM-0005Dx-6P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BS5+8uDbUO8tnie7RIoFtC9U2mSiMSeu6Pam5/wgM3Q=;
 b=OEQL3Mkg2jcG/s2HjeSEURNe3bY34DZOENYuxNzfs/06WGomzjwTo6bXQB9trB0KVAsYZr
 Y5QfLxBAWOCHKKYetQHWMOnkeZe6QAeXNm35jhFwe9o5S2Xox9aASgovlVbWS970VVMq8A
 VZPYqyZ5xPfWk9N3BGCYYIpxqiAcqPU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-VCkePTLoMtOZIxYDBBbg2w-1; Thu,
 11 Jun 2026 05:05:54 -0400
X-MC-Unique: VCkePTLoMtOZIxYDBBbg2w-1
X-Mimecast-MFC-AGG-ID: VCkePTLoMtOZIxYDBBbg2w_1781168753
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 246751800D85; Thu, 11 Jun 2026 09:05:53 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C31791800351; Thu, 11 Jun 2026 09:05:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:40 +0400
Subject: [PATCH v3 25/35] ui/console: fire console ADDED/REMOVED notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-25-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6hGNnrGYNd3ibRqfbbVKqo9FqKz4axEEuiTBy0WRKJo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnngldUquYYFNJZkRmYZyhhlkaTwDKAsJ4c2j
 8o1qdRRQw+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip54AAKCRDa6OEJdZac
 5fpBEACQ7ANklRxneAg8PG5ki1UpNtpuQ+SicZD+jVMJAjYSREdsXxTX4O+kF7bHpBZqRxLJcms
 cfJnFGX4wO68l8Ks576tFedn7gXmhl2LKBoIA5Af2ZxFN5/GlB8qoMCHQiy7yvnb/+W4yUnR0dQ
 lb53t7j2LEZuTIcwHR1loa8ZwdELvLm6tlJKgJpHCBf8IhixvO6qfWWI5eAtZPAIjhDAdFLlJZF
 7PM/Z2VHr7LgZTCJy2AQdBJJz1rnai9OUlO+o0MGkaTT6DVrFN4C2CCXRc84EG118GrL9AqSHRf
 HugjiPxn7hnNhtpD/Pg0cVZOrDoDhrxQqlEcXySSei2Tcv3IchZ2gTQK9uGyr/J+qpFhUHm3YF3
 CVXQP6Dya8FLDH9i2XWvlOmQOJFlvI03WfUNvERNxlKcxE3EW7GdeE5ZHv8l1l93z4QzQ/o8rP9
 fxzg088uU3yBbnPvHT4iynvFtscajA/hqebmY0Kjpp1giIFiMuI+wD/NUK8BqkYHgkol5QK80QZ
 gzDd7R9PFFOG6a+6x2pjYwt7bErk2Pns+zcruv1h296SSh9zQUOrSJo4d6R/bcI5ZYVQMmOQmf0
 wyLFoSsmzsKOW8Clvk6BBHZDhbCcP5qBMctulS2IVSz/22sqKTFK3zC9w681jTgDKIxgT0NvVlP
 eeghKV+G1AP9pGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


