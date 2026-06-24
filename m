Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2F1CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1R-0004ad-7z; Wed, 24 Jun 2026 07:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1E-00044f-Uf
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM1D-0008Bp-CN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAL/ZeGpAeKjHQz8lnwn6zmTPAbMzg3ySLg+WHFGrWk=;
 b=I4ylJF6ETT3+8y+IvGgNaLTvLSmMqmnfkkljHrvrWD76VuPCzYVZ/AKmtyq14rQf0t2FeM
 AmnDBDcyUjnYYUDPGo2bBanFKsAOfUFXi48yKNM0QMrAQLTWknOQSGVc5AQo3NuUppYup7
 OfDAtT4Ee0Z9/vq+QSEIUVamM4veVEo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-6CEZ6F7NMbGOcasg9R2whw-1; Wed,
 24 Jun 2026 07:43:43 -0400
X-MC-Unique: 6CEZ6F7NMbGOcasg9R2whw-1
X-Mimecast-MFC-AGG-ID: 6CEZ6F7NMbGOcasg9R2whw_1782301422
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D38E1801F09
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 204B3195609E; Wed, 24 Jun 2026 11:43:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:46 +0400
Subject: [GIT PULL 24/35] ui/console: fire console ADDED/REMOVED notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-24-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rOBUfopW4WHLebYreqzIPIp0XyUwE3HTsA+4ZujwCcI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JoAdcwD+SicS53ND+ytTLQ4/LRhJdhhz2uc
 dY3n1aZ862JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5RGcD/92FxS8HZqtnxh0WysHzPxmyQzV63lAM5EAPZk+ewJ30AuNXJyREqMFTbcofmHaOLFyHyG
 5gkywTF5OyrV1cLad6L8uzGQX/LnSaE5LLXjxNjqy3C6wTynPcwsxFi8WH/NsB0WGmN9zaqucXy
 ESgN1862ghjK4oPs9Fg5JyawJrmGQTZ+DYhErkuegjrVsZ1fDuzyEbvfn6Y0UJV7qVH8x/wO+4j
 JzKR7TT6u782JieYCZkhsYGaYDu/NRIm7ekJHRu4XBLS+9BuR6g5WFbCL1Untq0exVhF0Bz03zq
 HW1BuqoOaEPlr1GGK+JGNrwtzFzIwYJgG0WUUC7g90Y4mVoVBNthSAOI7a0SqMTVK5oWEIWhI6a
 xVWrL4K31Sy2gAVAy9dktvV7G/BUOvdqkx3ilr9QNJxCfZEK7/84oZJMfbKCJSrMlYXifqYejDe
 QPgVJ9hHlUHhG1Fm7WVRA4F6F536aeeWlUC1kpjd5uYMAlXClpQzTRC3L+axYJk4gvWmMlrUMMn
 8JEGbkV3G8IAuEOYmKzukBqE4RrHaYbDLycgQRz0ZUJqdnLv41ZioMsn/I9juHh8Pj6u8hxMFtu
 pQZT4hrvRew1VnrM73uYckPKdnQ8A5wUhqRMBejnAMMMzdwWLUdlABHjVHFVG+H10fH/w8tSoYH
 NzSAs04EAOBJ0ew==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-24-4656aec3398d@redhat.com>
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


