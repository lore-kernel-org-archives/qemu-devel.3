Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF52C88E59
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54JG-00076p-0n; Fri, 11 Sep 2026 12:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JB-0006ra-JB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54J9-0007D9-Qz
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwaEdy8ZnQVC4f1U6iU1d1dziaG8puTh0bFfych/IvA=;
 b=RdD1b6fmNChcRwrrbasTWoFIzrlRY0InxNLAVEv0k0pEnEA8PKtbVypXvz1Ewb7tiGUh5/
 hC2q6I2kLhux0GcbwHO8vAGxZ2YkvNJ+3x7FaQ8Org0GrgNWk+EtHS9P6kHuJZ8+coYNs8
 rcdt9WpUyPEqz6u6O3Hj8klHrc2uBCE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-CZapvgRPMsixKST3U3zUDw-1; Fri,
 11 Sep 2026 12:40:51 -0400
X-MC-Unique: CZapvgRPMsixKST3U3zUDw-1
X-Mimecast-MFC-AGG-ID: CZapvgRPMsixKST3U3zUDw_1789144849
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB3811954B07; Fri, 11 Sep 2026 16:40:48 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9184E1956095; Fri, 11 Sep 2026 16:40:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:28 +0400
Subject: [PATCH v5 54/62] qdev: convert PropertyInfo definitions to use
 qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-54-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3558;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QHqeQMn/jmK1W7g0UftNgCE38XbzkODSG27/Of7QTCI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC28IjH3F0A9qPde/0skOIiUhL89PiFYSlyQI
 9xLHcd7hIGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtvAAKCRDa6OEJdZac
 5QL+D/4hlhwqKR3E1wpeWRvMJrcLHGHp7i035OsyQornaD27pIVHxEG9QMjsy02p/Hv5/RkGHja
 WTh3aTxlD3g8k4r9pv434oT0LwTjxRKg3ET3M3cmvzhV15XgMUJyZLz/dJ4DJAjUw3Tw8hmwfsg
 IcegWp9uro7DZ1mW3yZ49WOXhydj/uQgXGGO8NAZXKlH5ZjbNN2+aCsBSWwkC1LyhaiQW0SepQG
 M/6yWss46RAxluNzZ7EyfK1MgHLPepcNHtTmP2d5aeYwBR4EMTI5bHlW6EHJn3HBOd3FevL1zsL
 qZYA9ja+nfBKmPMw+Uu5KXPw13DxpkY7fRrcVX9P3wqGIW3SsDKJ7n7d7+hPfM+tgQwydEnYXZn
 a0CYqgXzG+JuE3uvnzGWrjPtWhwYe/XLqzRRllkrqEMfMDB2D+d9u/qrwEwcRfvAzaXFy6VBo4r
 8I2Kw3xboVa+DneNvXPdk8l3VAgfJjU+qORrn6/D9DHC4pdRZBl8vCARRTgdfInY26BsbsYILuf
 KvIP8+ko/5BnOP7YuDiHv7bI76zS2RutHkLA727cbmlepwgum/rhecQeg2DO5Po4sJEdPYWQGW3
 9H1TPXPZ7BU0+Y0vEa9Nwe7hanujxgfUC6XfvooRIfCfbuE+sgdszpeRuq1j6fEFvOdW/D3zagr
 UW/Ls6QKWQzkPkw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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
index 826efc276dcd..4a4307975965 100644
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
index 264bff22a91a..ecbc771baa6f 100644
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
index d2575edb6cbe..78d4d4818514 100644
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
@@ -287,7 +289,7 @@ static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
  * TYPE_MIGRATION's TLS options.
  */
 const PropertyInfo qdev_prop_StrOrNull = {
-    .type  = "StrOrNull",
+    .qapi_type = &StrOrNull_type_info,
     .get = get_StrOrNull,
     .set = set_StrOrNull,
     .release = release_StrOrNull,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df82..d0354a4d02af 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include "target/sparc/translate.h"
+#include "qapi/qapi-builtin-type-infos.h"
 
 //#define DEBUG_FEATURES
 
@@ -948,7 +949,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo qdev_prop_nwindows = {
-    .type  = "int",
+    .qapi_type = &int_type_info,
     .description = "Number of register windows",
     .get   = sparc_get_nwindows,
     .set   = sparc_set_nwindows,

-- 
2.55.0.543.g5ebe2ebe4ea8


