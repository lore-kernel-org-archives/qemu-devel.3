Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B030FC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52UP-0004Ua-2O; Fri, 11 Sep 2026 10:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52O9-00032W-TZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52O8-0008SC-Be
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4kE0kwvfDbuBRKymnLbUvEO8flRNgMjBGhpmSiGsh0=;
 b=ZJfwDC4EfiDR/8OX/RIHEkDrhf5DRT8l8zaXJLdjGJiRk2yAE6lDNROfiL2KsT9furuA6H
 n9V3UEylR688u/ZkPEMBze8pFsR5lCadNZW0Xd3tQaCIpaZZt6Qi9BWmtKjFzBwawWKbSc
 hVQv7zU5mOJAwLYvNsaSn+Dueao43Ng=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-Woi66CdzNE63mR1L80XvTw-1; Fri,
 11 Sep 2026 10:37:58 -0400
X-MC-Unique: Woi66CdzNE63mR1L80XvTw-1
X-Mimecast-MFC-AGG-ID: Woi66CdzNE63mR1L80XvTw_1789137476
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F99F195395E; Fri, 11 Sep 2026 14:37:33 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42B0C3000229; Fri, 11 Sep 2026 14:37:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 28/28] hw/i386: mark vmmouse / vmport as secure
Date: Fri, 11 Sep 2026 15:36:27 +0100
Message-ID: <20260911143627.2743803-29-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These paravirtualized devices are relevant to virtualization
use cases.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/vmmouse.c | 1 +
 hw/i386/vmport.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index e289bce8e2..612e7f7d3b 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -390,6 +390,7 @@ static const TypeInfo vmmouse_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(VMMouseState),
     .class_init    = vmmouse_class_initfn,
+    .secure        = true,
 };
 
 static void vmmouse_register_types(void)
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 865e0e70db..24c4fb27a3 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -301,6 +301,7 @@ static const TypeInfo vmport_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(VMPortState),
     .class_init    = vmport_class_initfn,
+    .secure        = true,
 };
 
 static void vmport_register_types(void)
-- 
2.55.0


