Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34F3CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Rr-0007qi-6X; Sun, 10 May 2026 09:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Rf-0007of-CL
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Rd-0004K8-W9
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLTM7UlfM2pcl1kfhxldekHF9MgNbRrfS8dL3DFlmHQ=;
 b=cD9wNhiM5WGChHJh+FlTGqJgSsCgWcmH1CZB/gQnDppSbYJnaGjvGFkgEU0WwlGaueWIHq
 2Vwi7tnpy2XsaeuFW2Zwhosatjibq8IBtqRwk5bLVLUs00CMB6FJOSUHKzkQT4xa2WZOMw
 El89n0258ou1s5i0lp/i8A9zuo8AFWI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-1RYI-hJZOzy9vu4Mk-9UtQ-1; Sun,
 10 May 2026 09:43:43 -0400
X-MC-Unique: 1RYI-hJZOzy9vu4Mk-9UtQ-1
X-Mimecast-MFC-AGG-ID: 1RYI-hJZOzy9vu4Mk-9UtQ_1778420622
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675F3180056E
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:43:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E37E53002D30; Sun, 10 May 2026 13:43:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:42:58 +0400
Subject: [PATCH 01/54] qapi: add QAPITypeInfo struct definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-1-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SbF0347iS9KGewslgupoZANFsDp/EFCir1K5kbjzQyc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItuVXWs7IRMOD6iOebR376lWpbJKUkbDNmVa
 WZYuJP4BAaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5So5D/4vrP220B3HJPdf4V+jgOrRZ1LLXDdswPkhmdueJEdu8LIOLV5QXu+4/LJ7B3oiF4kGogi
 8xK0GxesxXGY8LkBbtPbSL5enu1a2aKCTTItlzHYJyHY1GBC+/5SNCqpQd63Y2kfv9R1VK2U8Kc
 AiiVx4ZGvQmcB6g50zuf2qnJbbSyx3Ktp68NMKA3CBLAW6Jft/koKZiQVMR9QTArH49m3GRiJyj
 ExVT6GELZuh47hqiOwCzRG3mceOm9yCo2UbHM2KkkaCxCdNICSmvUCNYYEj822nPlV/mIlB/Wm+
 4t0WJtjOSpRFNV8UP28xsSG4oWv0CyK+iPZUZflT0YqDUw2nHkptm6KSabAAcSwBJTi5+dwV2B7
 /6XgJTLDCWhQiGjaN1MdJSKjwpQFVCxiLr5c/PX+C+A9FzDBZlKRB8jbIdFSiF9/mWENBiAE0C0
 7WDkyTFmwwQ2MjVSNjPTrT8RyxUWkh9uYX+7qiax942oPdbTy/Qk+pIdg5PVIyuCsxayyxnLR6w
 9gHd0ChhLH5QP7Ps/UFw+6CeucY9DS/XRfWOzK6awpQbTR9e26847JmZcdRxLxXYZt+Odn4w65R
 X5JfCGoZmu9hG8FDIX9C7uvSnAXFxf8B08sAsUBCWcxKJRWZmcUs+MI0rSqzRKCITV4o8guI8lH
 UuAsRC2YhZ0HmZg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a minimal struct that pairs a QAPI type's internal name with
its "masked" introspection name. Generated constants of this type will
let QOM property registration carry a reliable reference to the QAPI
schema and possibly other associated data.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qapi-type-info.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.h
new file mode 100644
index 00000000000..53b4732297d
--- /dev/null
+++ b/include/qapi/qapi-type-info.h
@@ -0,0 +1,19 @@
+/*
+ * QAPITypeInfo — associates a QOM property with its QAPI schema type.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QAPI_TYPE_INFO_H
+#define QAPI_TYPE_INFO_H
+
+#include "qapi/util.h"
+
+typedef struct QAPITypeInfo {
+    const char *name;
+    const char *schema_name;
+    const QEnumLookup *lookup;
+    const struct QAPITypeInfo *list;
+} QAPITypeInfo;
+
+#endif /* QAPI_TYPE_INFO_H */

-- 
2.54.0


