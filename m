Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414BCCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWaN-0001Y6-3X; Wed, 22 Oct 2025 07:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBWaI-0001WV-DL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBWaA-0005dM-OH
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761130841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWO+HWjLIQTLIzxJ/Yn1KzFJP9Nkv8LoxMvKWhvh7Bk=;
 b=Dv+FWpi0oW6cy/eF8GD+VXQqDBJ23Q8/vyfvT8Qnfja0yUXVNcNlIiY4QhnlaSIb+4XA2D
 jCR9wC1ne4BPW0g5NklC/Z7Bq6haOpJwcTd3dIwte//xlPsk7/mSTKZRxULmMn8Fs9GaIJ
 +aEf0TpEauk4zJas8MCsmhvZfLTZiGE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-1wJRCyd_M0KXLEGyh8_bpQ-1; Wed,
 22 Oct 2025 07:00:37 -0400
X-MC-Unique: 1wJRCyd_M0KXLEGyh8_bpQ-1
X-Mimecast-MFC-AGG-ID: 1wJRCyd_M0KXLEGyh8_bpQ_1761130836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBD741801359; Wed, 22 Oct 2025 11:00:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65FF11955F22; Wed, 22 Oct 2025 11:00:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3FECC1800784; Wed, 22 Oct 2025 13:00:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 3/3] hw/uefi/ovmf-log: add maxsize parameter
Date: Wed, 22 Oct 2025 13:00:27 +0200
Message-ID: <20251022110027.441780-4-kraxel@redhat.com>
In-Reply-To: <20251022110027.441780-1-kraxel@redhat.com>
References: <20251022110027.441780-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow limiting the amount of log output sent.  Allow up to 1 MiB.
In case the guest log buffer is larger than 1 MiB limit the output
instead of throwing an error.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20251017115006.2696991-4-kraxel@redhat.com>
---
 hw/uefi/ovmf-log.c   | 42 ++++++++++++++++++++++++++++++++++--------
 hmp-commands-info.hx |  4 ++--
 qapi/machine.json    |  5 +++++
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index fe8acbd19236..98ebb0209491 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
+#include "qobject/qdict.h"
 
 
 /* ----------------------------------------------------------------------- */
@@ -164,7 +165,8 @@ static void handle_ovmf_log_range(GString *out,
     }
 }
 
-FirmwareLog *qmp_query_firmware_log(Error **errp)
+FirmwareLog *qmp_query_firmware_log(bool have_max_size, uint64_t max_size,
+                                    Error **errp)
 {
     MEM_DEBUG_LOG_HDR header;
     dma_addr_t offset, base;
@@ -184,18 +186,40 @@ FirmwareLog *qmp_query_firmware_log(Error **errp)
         return NULL;
     }
 
-    if (header.DebugLogSize > MiB) {
-        /* default size is 128k (32 pages), allow up to 1M */
-        error_setg(errp, "firmware log: log buffer is too big");
-        return NULL;
-    }
-
     if (header.DebugLogHeadOffset > header.DebugLogSize ||
         header.DebugLogTailOffset > header.DebugLogSize) {
         error_setg(errp, "firmware log buffer header is invalid");
         return NULL;
     }
 
+    if (have_max_size) {
+        if (max_size > MiB) {
+            error_setg(errp, "parameter 'max-size' exceeds 1MiB");
+            return NULL;
+        }
+    } else {
+        max_size = MiB;
+    }
+
+    /* adjust header.DebugLogHeadOffset so we return at most maxsize bytes */
+    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
+        /* wrap around */
+        if (header.DebugLogTailOffset > max_size) {
+            header.DebugLogHeadOffset = header.DebugLogTailOffset - max_size;
+        } else {
+            uint64_t max_chunk = max_size - header.DebugLogTailOffset;
+            if (header.DebugLogSize > max_chunk &&
+                header.DebugLogHeadOffset < header.DebugLogSize - max_chunk) {
+                header.DebugLogHeadOffset = header.DebugLogSize - max_chunk;
+            }
+        }
+    } else {
+        if (header.DebugLogTailOffset > max_size &&
+            header.DebugLogHeadOffset < header.DebugLogTailOffset - max_size) {
+            header.DebugLogHeadOffset = header.DebugLogTailOffset - max_size;
+        }
+    }
+
     base = offset + header.HeaderSize;
     if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
         /* wrap around */
@@ -239,8 +263,10 @@ void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     FirmwareLog *log;
     gsize log_len;
+    int64_t maxsize;
 
-    log = qmp_query_firmware_log(&err);
+    maxsize = qdict_get_try_int(qdict, "max-size", -1);
+    log = qmp_query_firmware_log(maxsize != -1, (uint64_t)maxsize, &err);
     if (err)  {
         hmp_handle_error(mon, err);
         return;
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 33cf740bbc1b..2a7f5810d706 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -998,8 +998,8 @@ ERST
 
     {
         .name       = "firmware-log",
-        .args_type  = "",
-        .params     = "",
+        .args_type  = "max-size:o?",
+        .params     = "[max-size]",
         .help       = "show the firmware (ovmf) debug log",
         .cmd        = hmp_info_firmware_log,
     },
diff --git a/qapi/machine.json b/qapi/machine.json
index 96133e5c71cf..c6dc6fe69b5c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1858,9 +1858,14 @@
 #
 # Find firmware memory log buffer in guest memory, return content.
 #
+# @max-size: limit the amount of log data returned.  Up to 1 MiB of
+#            log data is allowed.  In case the amount of log data is
+#            larger than @max-size the tail of the log is returned.
+#
 # Since: 10.2
 ##
 { 'command': 'query-firmware-log',
+  'data': { '*max-size': 'size' },
   'returns': 'FirmwareLog' }
 
 ##
-- 
2.51.0


