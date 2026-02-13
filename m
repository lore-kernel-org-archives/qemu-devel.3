Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4E4EEA860
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpoP-0006vJ-S6; Fri, 13 Feb 2026 04:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vqpoO-0006uj-OK
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:50:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vqpoN-0007Fp-3c
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770976206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3G7pz3JVMFqRvpJ05R+kBwpJ0ObSQg4ak0FyKLiTE8=;
 b=Mn9E0ZKYVzFmG3lp+NP7jEtHX8ELne3EVaqo0u/wJQVEFOKKjUUidRinku/wyAxgKB2Z/S
 E8D/95+mhqMuUlWK32edI1yiNrXqgt9c8lvRjJybUlX69IP4j4AcplqLLfbnWNPVmXAa41
 lQ//DQH093u6KEAjc3OGLGMMcOxBrfU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-spO-09MoPhGoxKEqBmvdqQ-1; Fri,
 13 Feb 2026 04:50:02 -0500
X-MC-Unique: spO-09MoPhGoxKEqBmvdqQ-1
X-Mimecast-MFC-AGG-ID: spO-09MoPhGoxKEqBmvdqQ_1770976201
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C43D196C420; Fri, 13 Feb 2026 09:49:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.41])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCA1418004AD; Fri, 13 Feb 2026 09:49:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paul Durrant <paul@xen.org>, Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL v2 03/15] ui/spice: drop SPICE_HAS_ATTACHED_WORKER macro
Date: Fri, 13 Feb 2026 10:49:22 +0100
Message-ID: <20260213094938.4074478-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
References: <20260213094938.4074478-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Since previous commit it is always 1. Let's just drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260115144606.233252-3-vsementsov@yandex-team.ru>
---
 include/ui/qemu-spice.h |  2 --
 hw/display/qxl.c        | 12 ------------
 ui/spice-display.c      | 11 -----------
 3 files changed, 25 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 8e5e6b2a744..111a09ceca3 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -34,8 +34,6 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
 
-#define SPICE_HAS_ATTACHED_WORKER 1
-
 #else  /* CONFIG_SPICE */
 
 #include "qemu/error-report.h"
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index fbba02113f7..0551b38230b 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -530,13 +530,6 @@ static void interface_attached_worker(QXLInstance *sin)
     trace_qxl_interface_attach_worker(qxl->id);
 }
 
-#if !(SPICE_HAS_ATTACHED_WORKER)
-static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
-{
-    interface_attached_worker(sin);
-}
-#endif
-
 static void interface_set_compression_level(QXLInstance *sin, int level)
 {
     PCIQXLDevice *qxl = container_of(sin, PCIQXLDevice, ssd.qxl);
@@ -1131,12 +1124,7 @@ static const QXLInterface qxl_interface = {
     .base.major_version      = SPICE_INTERFACE_QXL_MAJOR,
     .base.minor_version      = SPICE_INTERFACE_QXL_MINOR,
 
-#if SPICE_HAS_ATTACHED_WORKER
     .attached_worker         = interface_attached_worker,
-#else
-    .attache_worker          = interface_attach_worker,
-#endif
-
     .set_compression_level   = interface_set_compression_level,
     .get_init_info           = interface_get_init_info,
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index f2304bb0ce2..28399f8a817 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -507,17 +507,10 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 
 /* spice display interface callbacks */
 
-#if SPICE_HAS_ATTACHED_WORKER
 static void interface_attached_worker(QXLInstance *sin)
 {
     /* nothing to do */
 }
-#else
-static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
-{
-    /* nothing to do */
-}
-#endif
 
 static void interface_set_compression_level(QXLInstance *sin, int level)
 {
@@ -707,11 +700,7 @@ static const QXLInterface dpy_interface = {
     .base.major_version      = SPICE_INTERFACE_QXL_MAJOR,
     .base.minor_version      = SPICE_INTERFACE_QXL_MINOR,
 
-#if SPICE_HAS_ATTACHED_WORKER
     .attached_worker         = interface_attached_worker,
-#else
-    .attache_worker          = interface_attach_worker,
-#endif
     .set_compression_level   = interface_set_compression_level,
     .get_init_info           = interface_get_init_info,
 
-- 
2.52.0


