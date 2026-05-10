Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05AFCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4aZ-000713-IA; Sun, 10 May 2026 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4aL-0006B5-G7
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4aJ-0006Me-9n
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sIbnyunO4q+6Y28HodZK8cqJ+CdQBboCwLp2Hj1XDo0=;
 b=QVZ/v9ASNHH0Onl1xWy3DqQZFVToct/FmgJCZKr7694aDZHZFWbnOvugR9OANlrRYlVTVC
 uPQdU+Cepcaw1rh8S9pMon0dQLtb6i68ZRSAyYu6bbHthq1NesOG/j0bxBA+1tOsIJqd1m
 etYzxZP81XsJXCOSCmBwxmvcfGGGiL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-lKIFfg7FOgi1XcLUZ7c8qA-1; Sun,
 10 May 2026 09:52:39 -0400
X-MC-Unique: lKIFfg7FOgi1XcLUZ7c8qA-1
X-Mimecast-MFC-AGG-ID: lKIFfg7FOgi1XcLUZ7c8qA_1778421158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EE2218002C7
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:52:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B7861803A8E; Sun, 10 May 2026 13:52:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:45 +0400
Subject: [PATCH 48/54] qdev: convert PropertyInfo definitions to use qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-48-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YlwueDnCTHy/YbpLDJR4HKSWfvxwh811dbqG5oHpTWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItxpsOJvp97DQUkb41tUmsSwG2bHES+fGydd
 IbSXMcePOeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcQAKCRDa6OEJdZac
 5VFqD/wO0QPl+BezogUarpJPdG/wH32KbCzZo5p/iOTGjI/9rG/JR9foEe7RxpGnvgYgRy4j9jm
 u78qjt8mtpFnHzgVowu3hqWYcYcYtLs7ZfVA79xm/FXQubV9cMmQkx83sWoRC2wVcQkHzrUW5eH
 RmStrjI7eOYPvC8oOPyRR326eLlcw29pdcdOxyC3vdzdOwY74EwN3rDaAZRVIPySMW4OMSxCS7q
 BK0ekqIEBJ7w8yQVCyPTT7yR92YsgImUu9eon26cjqJVFz9+b0zK35GW/azVAdnF+lyPKRyjoDc
 87wdCjAEY6yvDiiqQvxAnAnkclTHgAJapvupylNroHJDeBksa1z0Fi11wnERGXR6xg7XvJRh/Xn
 6FxaZEEbYL3Cw600ugKADlp7woqwHl7/H6x4nRkDxPkQdrD8BgcGoikcdYXPTrVFIpUdiqlPvgU
 hoTeXDgzeNiinMr2Oirk7qW0cMu8I9p8r4v9jum545Z4Aui5H12J1plHrQ99LhipPOUp6l/Bx+3
 adaEbVECQvcWwcKjDhd0SHpjsS89LOWLC6TA8BFoXJXHzP6/lYN2pVeHfWxwoZmzMoIzzHZ32a9
 YJNwgDxvudTan47gXQwo7f6aZunn9qHmv6GzcTMZ0VPBquRwl20MjXLH8RrrUprmcI/qqrtvq6x
 jjorqo/izH6wxVw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Convert the remaining PropertyInfo definitions outside hw/

After this patch, all PropertyInfo definitions have .qapi_type set,
except qdev_prop_link (uses .create) and qdev_prop_array (refactored
in the next patches).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/spdm-socket.c  | 4 ++--
 backends/tpm/tpm_util.c | 3 ++-
 migration/options.c     | 4 +++-
 target/sparc/cpu.c      | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 826efc276dc..4a430797596 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -17,6 +17,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/core/qdev-prop-internal.h"
+#include "qapi/qapi-type-infos-sockets.h"
 
 static bool read_bytes(const int socket, uint8_t *buffer,
                        size_t number_of_bytes)
@@ -253,9 +254,8 @@ void spdm_socket_close(const int socket, SpdmTransportType transport_type)
 }
 
 const PropertyInfo qdev_prop_spdm_trans = {
-    .type = "SpdmTransportType",
+    .qapi_type = &SpdmTransportType_type_info,
     .description = "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
-    .enum_table = &SpdmTransportType_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 264bff22a91..ecbc771baa6 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -30,6 +30,7 @@
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
 #include "trace.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 /* tpm backend property */
 
@@ -77,7 +78,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_tpm = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of a tpm to use as a backend",
     .get   = get_tpm,
     .set   = set_tpm,
diff --git a/migration/options.c b/migration/options.c
index 5cbfd29099b..7ef7db667a8 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -31,6 +31,8 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-type-infos-common.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -285,7 +287,7 @@ static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
  * TYPE_MIGRATION's TLS options.
  */
 const PropertyInfo qdev_prop_StrOrNull = {
-    .type  = "StrOrNull",
+    .qapi_type = &StrOrNull_type_info,
     .get = get_StrOrNull,
     .set = set_StrOrNull,
     .release = release_StrOrNull,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index c6989229da6..463eb34f354 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -29,6 +29,7 @@
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include "target/sparc/translate.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 //#define DEBUG_FEATURES
 
@@ -947,7 +948,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo qdev_prop_nwindows = {
-    .type  = "int",
+    .qapi_type = &int_type_info,
     .description = "Number of register windows",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,

-- 
2.54.0


