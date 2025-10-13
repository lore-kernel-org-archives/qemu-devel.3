Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575E1CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8G89-0003qC-Eq; Mon, 13 Oct 2025 06:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8G86-0003pA-BF
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8G82-0008HT-JI
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760352607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvZxEGssQt5lRMdeoL8b/rdzkt3zolTRm5uuvD75DF8=;
 b=CmsFCQ+byIufETy8C0wnGnhkMdV4pJxmoQhBl47XGOMuOqq2fO+cps7ZHG4aFmt/T7oTb0
 fDuJEzGvsdUzmvKoLnnbiUhub+edRDxdmHB1H2tiyxQ33GHnwzfraNjGDUUuJcG9sFuFgS
 1yOuv+1xGHP+WClPi/9+MobPu4S1CdI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-eZk9mgGYOcW8h914sJyl8A-1; Mon,
 13 Oct 2025 06:50:02 -0400
X-MC-Unique: eZk9mgGYOcW8h914sJyl8A-1
X-Mimecast-MFC-AGG-ID: eZk9mgGYOcW8h914sJyl8A_1760352601
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29FBF19560AD; Mon, 13 Oct 2025 10:50:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBCFD180035E; Mon, 13 Oct 2025 10:49:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 91FDE180060B; Mon, 13 Oct 2025 12:49:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 2/2] hw/uefi/ovmf-log: add maxsize parameter
Date: Mon, 13 Oct 2025 12:49:54 +0200
Message-ID: <20251013104954.250166-3-kraxel@redhat.com>
In-Reply-To: <20251013104954.250166-1-kraxel@redhat.com>
References: <20251013104954.250166-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/ovmf-log.c   | 40 ++++++++++++++++++++++++++++++++--------
 hmp-commands-info.hx |  5 ++---
 qapi/machine.json    |  3 +++
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index f03e47a290d6..9d9dc7b0d8d5 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -19,6 +19,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
+#include "qobject/qdict.h"
 
 
 /* ----------------------------------------------------------------------- */
@@ -167,7 +168,8 @@ static void handle_ovmf_log_range(GString *out,
     }
 }
 
-FirmwareLog *qmp_query_firmware_log(Error **errp)
+FirmwareLog *qmp_query_firmware_log(bool have_maxsize, uint64_t maxsize,
+                                    Error **errp)
 {
     MEM_DEBUG_LOG_HDR header;
     dma_addr_t offset, base;
@@ -187,18 +189,38 @@ FirmwareLog *qmp_query_firmware_log(Error **errp)
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
         error_setg(errp, "firmware log: invalid header");
         return NULL;
     }
 
+    if (!have_maxsize) {
+        maxsize = MiB;
+    }
+    if (maxsize > MiB) {
+        maxsize = MiB;
+    }
+
+    /* adjust header.DebugLogHeadOffset so we rezturn at most maxsize bytes */
+    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
+        /* wrap around */
+        if (header.DebugLogTailOffset > maxsize) {
+            header.DebugLogHeadOffset = header.DebugLogTailOffset - maxsize;
+        } else {
+            uint64_t maxchunk = maxsize - header.DebugLogTailOffset;
+            if (header.DebugLogSize > maxchunk &&
+                header.DebugLogHeadOffset < header.DebugLogSize - maxchunk) {
+                header.DebugLogHeadOffset = header.DebugLogSize - maxchunk;
+            }
+        }
+    } else {
+        if (header.DebugLogTailOffset > maxsize &&
+            header.DebugLogHeadOffset < header.DebugLogTailOffset - maxsize) {
+            header.DebugLogHeadOffset = header.DebugLogTailOffset - maxsize;
+        }
+    }
+
     base = offset + header.HeaderSize;
     if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
         /* wrap around */
@@ -237,8 +259,10 @@ void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
 {
     Error *errp = NULL;
     FirmwareLog *log;
+    int64_t maxsize;
 
-    log = qmp_query_firmware_log(&errp);
+    maxsize = qdict_get_try_int(qdict, "maxsize", -1);
+    log = qmp_query_firmware_log(maxsize != -1, (uint64_t)maxsize, &errp);
     if (errp)  {
         hmp_handle_error(mon, errp);
         return;
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 257015f0b403..db03d88d3c74 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -980,11 +980,10 @@ ERST
 
     {
         .name       = "firmware-log",
-        .args_type  = "",
-        .params     = "",
+        .args_type  = "maxsize:i?",
+        .params     = "[maxsize]",
         .help       = "show the firmware (ovmf) debug log",
         .cmd        = hmp_info_firmware_log,
-        .flags      = "p",
     },
 
 SRST
diff --git a/qapi/machine.json b/qapi/machine.json
index c96e582afdd6..d0c6d3ede027 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1857,9 +1857,12 @@
 #
 # Find firmware memory log buffer in guest memory, return content.
 #
+# @maxsize: limit the amount of logdata returned.
+#
 # Since: 10.2
 ##
 { 'command': 'query-firmware-log',
+  'data': { '*maxsize': 'size' },
   'returns': 'FirmwareLog' }
 
 ##
-- 
2.51.0


