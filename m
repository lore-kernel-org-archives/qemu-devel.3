Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264B606F23E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hFSRbwgp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtEF-0004Jd-Du; Mon, 02 Nov 2026 09:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDI-0003HB-ON
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDA-0008V9-Vq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swdG63NENFR1xPwCwOmnIXUcYihFHG3oU2L7OS1+cSk=;
 b=hFSRbwgpKlPizCm7BXz4XIRjBeqsj58ci88LpX2X2Wqz253SjywcDYZ540RfVliNbsZm5e
 Fybn8xRWk8JzAKxXUU7+/3DAMgQN4YDiuWLIcb8cz5Kdv5mJL+aT0uoS+JGHZ3gV4iuPeg
 qPrrw5C13sJSJ5+5wvpMC/4ywj19tMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-dNT5jaIVOeu3G8RcwI0m3w-1; Mon,
 02 Nov 2026 09:40:34 -0500
X-MC-Unique: dNT5jaIVOeu3G8RcwI0m3w-1
X-Mimecast-MFC-AGG-ID: dNT5jaIVOeu3G8RcwI0m3w_1793630433
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2484D19539B3; Mon,  2 Nov 2026 14:40:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8DAD5BC; Mon,  2 Nov 2026 14:40:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1FBE321E65C9; Mon, 02 Nov 2026 15:40:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL 69/74] qdev: convert PropertyInfo definitions to use qapi_type
Date: Mon,  2 Nov 2026 15:40:13 +0100
Message-ID: <20261102144018.3212223-70-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a .qapi_type pointer to the remaining PropertyInfo definitions
outside hw/.

After this patch, all PropertyInfo definitions have .qapi_type set,
except qdev_prop_link (uses .create) and qdev_prop_array (left for
later).

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-52-armbru@redhat.com>
[Trivial conflict with commit b8bd33422586 (migration: forbid
snapshots under Xen resolved]
---
 backends/spdm-socket.c  | 3 ++-
 backends/tpm/tpm_util.c | 2 ++
 migration/options.c     | 3 +++
 target/sparc/cpu.c      | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 826efc276d..e1d5626062 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -17,6 +17,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/core/qdev-prop-internal.h"
+#include "qapi/qapi-type-infos-sockets.h"
 
 static bool read_bytes(const int socket, uint8_t *buffer,
                        size_t number_of_bytes)
@@ -254,8 +255,8 @@ void spdm_socket_close(const int socket, SpdmTransportType transport_type)
 
 const PropertyInfo qdev_prop_spdm_trans = {
     .type = "SpdmTransportType",
+    .qapi_type = &SpdmTransportType_type_info,
     .description = "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
-    .enum_table = &SpdmTransportType_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 7019f7fd3e..e52f342933 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -30,6 +30,7 @@
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 /* tpm backend property */
 
@@ -78,6 +79,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
 
 const PropertyInfo qdev_prop_tpm = {
     .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of a tpm to use as a backend",
     .get   = get_tpm,
     .set   = set_tpm,
diff --git a/migration/options.c b/migration/options.c
index 0b7f393492..bd40394aa7 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -19,7 +19,9 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/dealloc-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-commands-migration.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
@@ -296,6 +298,7 @@ static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
  */
 const PropertyInfo qdev_prop_StrOrNull = {
     .type  = "StrOrNull",
+    .qapi_type = &StrOrNull_type_info,
     .get = get_StrOrNull,
     .set = set_StrOrNull,
     .release = release_StrOrNull,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 28ae629d50..7729413698 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include "target/sparc/translate.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 //#define DEBUG_FEATURES
 
@@ -950,6 +951,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo qdev_prop_nwindows = {
     .type  = "int",
+    .qapi_type = &int_type_info,
     .description = "Number of register windows",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,
-- 
2.55.0


