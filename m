Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E62CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 12:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMmFs-0000PP-P9; Tue, 12 May 2026 08:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMmFa-0000M1-1r
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMmFW-0002DJ-SQ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778589009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzGJyCwDRRicw9ZbRTGDUXJ9F2vnDG4yuoCyoa5p0GE=;
 b=BJTFTTUH1fxz2HhDj5nG61sbz6XpLpNdjkV05VuJSfwiME3nXnbbwZszMKGzws5kmhn7SF
 EPtLDXDCacQZx3JopJ/gXPCGQ9SlTNZX3/ShKvdLWDVZCXfiEedmT12udzAiolm400emi6
 2l2qGHTLLPOuvfcIBCES7cflI3Sp79s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-nOdjo8AONc-SW0PM3JfRQQ-1; Tue,
 12 May 2026 08:30:08 -0400
X-MC-Unique: nOdjo8AONc-SW0PM3JfRQQ-1
X-Mimecast-MFC-AGG-ID: nOdjo8AONc-SW0PM3JfRQQ_1778589007
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C9319560B1; Tue, 12 May 2026 12:30:07 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE80E30001BB; Tue, 12 May 2026 12:30:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 02/10] qom: validate ID format when creating objects
Date: Tue, 12 May 2026 13:29:50 +0100
Message-ID: <20260512122958.788097-3-berrange@redhat.com>
In-Reply-To: <20260512122958.788097-1-berrange@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The object_new_with_props/propv methods failed to validate the ID string
format, thus diverging from user_creatable_add_type.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 9c391071fb..62d2f0486a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -24,6 +24,8 @@
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qobject/qjson.h"
+#include "qemu/id.h"
+#include "qapi/qmp/qerror.h"
 #include "trace.h"
 
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
@@ -764,6 +766,13 @@ Object *object_new_with_propv(const char *typename,
     ObjectClass *klass;
     UserCreatable *uc;
 
+    if (id != NULL && !id_wellformed(id)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
+        error_append_hint(errp, "Identifiers consist of letters, digits, "
+                          "'-', '.', '_', starting with a letter.\n");
+        return NULL;
+    }
+
     klass = object_class_by_name(typename);
     if (!klass) {
         error_setg(errp, "invalid object type: %s", typename);
-- 
2.54.0


