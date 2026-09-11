Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BF9C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Dx-0004Ac-Cf; Fri, 11 Sep 2026 12:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Dk-00049N-Ou
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Di-0005Ir-RR
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bju+Alt5sUw9QZekzakUTE0AiCJbl2KRBiOCR/TgBYM=;
 b=aeKaSmyuPajo0Az4uV9wZPAix0T6MKgW13PcA1mSoEI4RNx+yu/BrMDN8qsjpRPYdBe+xf
 8zQ36f2wjpaAGF8zT55M/8+RxlDkLDqBt5LM2VmxvHqTikzZ0ZD6r4ehvcNTXgDqmOE8uC
 pDGenh3TnJVxCOxGCw6gpUEnZAUo/p0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-AqWhwR0VMEGQIK8Tp_WDYw-1; Fri,
 11 Sep 2026 12:35:18 -0400
X-MC-Unique: AqWhwR0VMEGQIK8Tp_WDYw-1
X-Mimecast-MFC-AGG-ID: AqWhwR0VMEGQIK8Tp_WDYw_1789144517
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DC42180214D; Fri, 11 Sep 2026 16:35:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 558A41956095; Fri, 11 Sep 2026 16:35:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:35 +0400
Subject: [PATCH v5 01/62] qapi: add QAPITypeInfo struct definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-1-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yL3f/NSxuSM+UijvILEdHZ3mnbL0LBQAa9ftHif0VEk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC21Ltzns7Tdw2OyhoIxm3hWINT4IU2ZVdGna
 x//5f3ZgiyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttQAKCRDa6OEJdZac
 5VPCD/wISk+WiLv2JQuNtSyxyZKVWHQi4BLbh4zQFJcg4Fwfc6iF/tPOQO1Gki48r5h9wX/nSYv
 RQWyyOwZUC4bEeAl+t41wQd/OUyf+oSvcDB79eDlIYRBnqGDHHnda8L1rI+rKUJRVBM0z54FdSI
 Ix7y3zLbPrkSR6LRnmY4H7FowucYik1FqCRfO2fWgW64Q2eyNrWrYYU0DHv+47ZbpBpJbiiOyTL
 7wpPCLBIjzU0WygOHllgl6xnFHcQOMXNaYG2XxTG54z/r4M5pXlhHcysXJGowZEClcv7HIrZ0p/
 fX74vdqPY+73CvkHPCtL81+j9PXiH5uLqEdmZibd8vm2/yvrxTRdn+EF+/JULT+WuRd9hlC6sct
 uZ+1P/QDWM7D75ja1Dt00qU3MvtWZspxMn8MVCw4wGwtO4LCpZtGVS7EOjOWj5rchjpeBCz0Sa6
 egx+knp6IMmxXcMFbKl2/NXuoIcFrfntMHeTAmnwnWPirE23VXKAwfwv/E/DTGtA2RD7MTrICOW
 owJs/VEtqb5pAijdWCgG5t9yJWHKW0rg8h+U0xchp2QS5kPlT3v8huGcWdRTGvvVsuF/ERmkjFo
 /Y5FzbuAQk/NzzL8j0OGXtXMhY37pAbRk4KMqyufOVtZw0ehNOhbxvmD/wzRqYSzWBmkb2cJWb7
 CuO6OZrHzYrfpSQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The fields are populated in following commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qapi-type-info.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.h
new file mode 100644
index 000000000000..6a6355568325
--- /dev/null
+++ b/include/qapi/qapi-type-info.h
@@ -0,0 +1,31 @@
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


