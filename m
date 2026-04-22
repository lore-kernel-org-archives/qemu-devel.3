Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E317FF9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4S-0002J8-LS; Wed, 22 Apr 2026 06:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4I-0000ps-RZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4C-0003HU-HV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qa4ZRXbb55roIjKCRf6D/q3tb4pr40RYyAXAB/YDbiM=;
 b=Iza8KCrXXkW8RE9yNE1ZcLDzbCaGOcLOeR57qoMRnBH/04tmg4PrXwrDI+uUbVcTLHlhz9
 gdfK8ntBSf2dtxxeCUwcreiLvU4ppvUwqEggDnCyxO041TXZZRImsIy4nyW5kwW5Pg/QIz
 pw+HWdpSpmVDroperMbhgglqRX4buoE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-skud3djgNAOvGnYBpIQpZA-1; Wed,
 22 Apr 2026 06:44:19 -0400
X-MC-Unique: skud3djgNAOvGnYBpIQpZA-1
X-Mimecast-MFC-AGG-ID: skud3djgNAOvGnYBpIQpZA_1776854658
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C92EE1956088; Wed, 22 Apr 2026 10:44:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 575A919560AB; Wed, 22 Apr 2026 10:44:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 34/40] ui/vnc: VncDisplay.id is not const
Date: Wed, 22 Apr 2026 14:40:35 +0400
Message-ID: <20260422104042.3936506-35-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

s/strdup/g_strdup to highlight the issue and be consistent with other
allocations.

The next patch is going to introduce vnc_display_free() to take care of
deallocating it.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 2 +-
 ui/vnc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index ec8d0c91b57..c5d678ac31e 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -166,7 +166,7 @@ struct VncDisplay
     pixman_image_t *server;    /* vnc server surface */
     int true_width; /* server surface width before rounding up */
 
-    const char *id;
+    char *id;
     QTAILQ_ENTRY(VncDisplay) next;
     char *password;
     time_t expires;
diff --git a/ui/vnc.c b/ui/vnc.c
index 23af83fd6c8..d5d92c0d99b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3433,7 +3433,7 @@ void vnc_display_init(const char *id, Error **errp)
     }
     vd = g_malloc0(sizeof(*vd));
 
-    vd->id = strdup(id);
+    vd->id = g_strdup(id);
     QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
 
     QTAILQ_INIT(&vd->clients);
-- 
2.53.0


