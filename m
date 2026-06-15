Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD19ECD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4B-0002m8-Sz; Mon, 15 Jun 2026 16:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4B-0002ln-6Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE49-00029t-Os
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNPn1A4TdwsMh4HPlKL0Z67HnF1LgGZKTOf/5QZrKao=;
 b=DOuYSylXlS3hcL44ltViJiDafYLvqTmL/+ya0P1+muOLqjkF04oMS5VaXt/Yi7fV5CF0Kg
 onnYDYUCyGSeqcdtEN1Ipj5FflhuIUu80PhDrRPymh95vYlN3Gb7wQLugT0O3bZJmWX3O6
 5XPVYSe3ia4ZhFaVkeFDwoxsQEn5Yac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-Oqvay1yDO_KWNtM4EeItIQ-1; Mon,
 15 Jun 2026 16:37:51 -0400
X-MC-Unique: Oqvay1yDO_KWNtM4EeItIQ-1
X-Mimecast-MFC-AGG-ID: Oqvay1yDO_KWNtM4EeItIQ_1781555870
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C19018002C2; Mon, 15 Jun 2026 20:37:50 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B488119560B2; Mon, 15 Jun 2026 20:37:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:27 +0400
Subject: [PATCH v2 01/53] qapi: add QAPITypeInfo struct definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-1-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3Hn5p3o8GowD4Url147++P7OrZcqEPX+kxr1mdBFGto=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKNM30xR+GP00pIZfH7nbN0k6mKvPijkfg5L
 VI0al4NXdCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijQAKCRDa6OEJdZac
 5eBeD/0cYbfrNYbCTsfr/fdIyogOOGmhtEbQ6Fg7jViRks2R/KBENQxZPIv2Fqwv9AVzoGYpzjd
 Coyoddn0VQG7i2uFlRescH2zZYkUPLh9AnmaEUPMgNREtVGH+tdKNnkex/KThGdApdwJL5qA9CE
 NOzCy1V6mNq3aUwJ/0Y7Ue2iCeSL9gqXD9MY2nHWpaFPcrHE5jSeyP97j0XFkei/0U8FIOe7oNg
 xjMCvwGxRGIFlH4DVI4e4HShNHW3y0YgVTI4Fsldb7I7OY1YLrz/JWc81i6RMunOQq7Gba2sSK9
 CcXN4QZ6JrHO1UB67WJRqhhlxtNc/p8HabxhenibasU1G+l3aF0SzssRE/4aykDi+oji0UZf2oD
 jpK+7+1aWlQRYffrcpaaKnU8czsW1kfQo8GhgG0sMxMPcfYFoHHot2BQPrntUL7ReLnyJkBdoQp
 HunOFr4LyBrMXCcgiq5oXElIjL4VhcIHfarL81Kviap788IZqYKU31lwFsOZMS85+0g/LANVz52
 Sxy2QrHA8VdUjt7/yOwRF/g6UInpTN/SAgv61WSauoHzcstysln9jFYrePZsV5WuzSIp6HiA0M6
 dmGOismdiUL5cJplkAmYmZ/0jvg3bmqk/JFmLQeIdsi8jNk5xP78+DM0A5XzQM5v2TedSfugzkf
 C/AS0WfOb8LE/Hg==
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

Introduce a minimal struct that pairs a QAPI type's internal name with
its "masked" introspection name. Generated constants of this type will
let QOM property registration carry a reliable reference to the QAPI
schema and possibly other associated data.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.h
new file mode 100644
index 00000000000..a7a470af731
--- /dev/null
+++ b/include/qapi/qapi-type-info.h
@@ -0,0 +1,32 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QAPI_TYPE_INFO_H
+#define QAPI_TYPE_INFO_H
+
+#include "qapi/util.h"
+
+/**
+ * QAPITypeInfo - QAPI type metadata
+ *
+ * @name: QAPI type name (e.g. "str", "OnOffAuto", "int32List").
+ *        QOM uses this as the property type string.
+ * @schema_name: Name of the type in the QAPI introspection schema, assigned by
+ *        scripts/qapi/introspect.py (e.g. "368"). NULL for builtin types not
+ *        individually present in the schema.
+ * @lookup: QEnumLookup for this type, or NULL for non-enum types.
+ *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
+ *        all rely on it.
+ * @list: The list-type counterpart, or NULL if none exists.
+ *        str_type_info.list points to strList_type_info.  qdev array
+ *        properties follow this to find the list type for their element.
+ */
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


