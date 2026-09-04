Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E982C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3I-0005V0-QB; Fri, 04 Sep 2026 15:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3H-0005UR-5T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3F-0007oo-An
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMR7ZYSXff17dR6913Tl35fhM/WOgUkQM2Kgqza6nyM=;
 b=HeZldCknoqujFr2EOMdPGN4nByd+l6bAJ5yyRpa/s+Rlr64VaYC1mVzLy3zctvoTktTHeo
 iNPU6WPIO+S9wxTGl51A/lP97aFSWuZ2oEIRkFvcMBeD3WfQ3OkBq/uY21JWFaShGYhP0M
 mOOz5JsIJyUlp37sR5qLXABvmJrjFWw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-T6SQEtfmOeeduD-zv1Xz4A-1; Fri,
 04 Sep 2026 15:58:13 -0400
X-MC-Unique: T6SQEtfmOeeduD-zv1Xz4A-1
X-Mimecast-MFC-AGG-ID: T6SQEtfmOeeduD-zv1Xz4A_1788551892
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 210A01955D6B; Fri,  4 Sep 2026 19:58:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 124B0423; Fri,  4 Sep 2026 19:58:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:44 +0400
Subject: [PATCH v4 01/75] qapi: add QAPITypeInfo struct definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-1-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=W7+TyZelRY5E+foHgcF2zrOJszOTC1p1pAKFNASayHY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLIUTG7RIy4KDgCLej3aQxJhAGfPTSzcRHlq
 rfV2ZSwHIKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5TlpEACxAHpagcHNp+UmFUjawdo++yUpz651pi3KhvHMOhSRv338V+Cd1o0z26L0A+7acpx2Zog
 RAiFgJrvu0ohG0rq6/k1z11+3qVOkK1IZ3VoK1MGAFzHrjdJ/osmNcbPdyVWDFM2jLpooN8DFNA
 JnlV8n8ICm2O+i8BgrWe1wpos/ba8Ticfs92N6eXZ5e//xgh0hvM9GhVUu71Q8zqgaTlnLpdWxW
 OtRpqbJQiHzdzI+L5V1+IKBf4lRWi+rh2F+L9z6nIv+Wl2oI62bJlPyc3vyQRSBa22InqAb54mK
 nCmZjXbsGyJJdpQ95n8LHt68N3or/iclxW9swXc5bEbv+ggGBzwmgahc6WEjslUekp51jIwLjqi
 Dto1A5dIkkYGaDArQDhhHNDVddWswjNYs0McEu3HH0NggrYKH66J/LV17k1RlzE+Gz1/mkZPIoC
 9p+Ka8ncXD4pfdbSifjgNnj//jqb1zoG028Gut7N4vAR9BoLWXEiwpBoNUoS3MzicUk//W0+snY
 SF7RuWZaNitkqdFnOn9jwd12QkBxv02wNbai0Fa1HgCGWbgL4gaXUAIySOPHY5HRPlamLqeBjMe
 qF0IlACFwcEOniyZFRNmMWrj+S8XlF8I1cp+CwK0Td1+59wiXCYpgg/WMSNE+uyIJ1cfGbOAca1
 0LlGDIEf2QXNgmQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce a minimal struct that pairs a QAPI type's internal name with
its "masked" introspection name. Generated constants of this type will
let QOM property registration carry a reliable reference to the QAPI
schema and possibly other associated data.

The fields are populated in following commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.h
new file mode 100644
index 000000000000..97eb1d7bf490
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
+ * @masked_name: Name of the type in the QAPI introspection schema, assigned by
+ *        scripts/qapi code generator (e.g. "368").
+ *        NULL for implicit types.
+ * @lookup: QEnumLookup for this type, or NULL for non-enum types.
+ *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
+ *        all rely on it.
+ * @list: The list-type counterpart, or NULL if none exists.
+ *        str_type_info.list points to strList_type_info.  qdev array
+ *        properties follow this to find the list type for their element.
+ */
+typedef struct QAPITypeInfo {
+    const char *name;
+    const char *masked_name;
+    const QEnumLookup *lookup;
+    const struct QAPITypeInfo *list;
+} QAPITypeInfo;
+
+#endif /* QAPI_TYPE_INFO_H */

-- 
2.55.0.543.g5ebe2ebe4ea8


