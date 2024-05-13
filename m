Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97411C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WVo-0001Ng-Op; Mon, 13 May 2024 10:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WV3-0000y5-Ro
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WV2-0000AZ-9I
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715609873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xChexl3zJ10AbGiFeV9mOFqYiLCnCKatJG/DJOGNNH4=;
 b=bNulMf5v2ael3ZIJQ2GTEEemBNXq8cTWRZOphS1KsUv5EcuBCnFX3GBoEh2s9Cu1xSn+MD
 KuTSIzYpACd/62JEEUoWIBoMia0omtR1NEC1rZ4poHZfeaHcAjWv0VscmB54xJjYD9Kdr/
 7gkgjGjUv+Lf4yf8N02fTF7/PoniYlE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-nzLoEgUGNQKFy3h3eVB23g-1; Mon,
 13 May 2024 10:17:08 -0400
X-MC-Unique: nzLoEgUGNQKFy3h3eVB23g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBB201C0007D;
 Mon, 13 May 2024 14:17:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A15B491035;
 Mon, 13 May 2024 14:17:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A48821E5E77; Mon, 13 May 2024 16:17:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
Subject: [PATCH 5/6] migration: Rephrase message on failure to save / load Xen
 device state
Date: Mon, 13 May 2024 16:17:02 +0200
Message-ID: <20240513141703.549874-6-armbru@redhat.com>
In-Reply-To: <20240513141703.549874-1-armbru@redhat.com>
References: <20240513141703.549874-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qmp_xen_save_devices_state() and qmp_xen_load_devices_state() violate
this principle: they call qemu_save_device_state() and
qemu_loadvm_state(), which call error_report_err().

I wish I could clean this up now, but migration's error reporting is
too complicated (confused?) for me to mess with it.

Instead, I'm merely improving the error reported by
qmp_xen_load_devices_state() and qmp_xen_load_devices_state() to the
QMP core from

    An IO error has occurred

to
    saving Xen device state failed

and

    loading Xen device state failed

respectively.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/savevm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4509482ec4..a4a856982a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -45,7 +45,6 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
@@ -3208,7 +3207,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     object_unref(OBJECT(ioc));
     ret = qemu_save_device_state(f);
     if (ret < 0 || qemu_fclose(f) < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "saving Xen device state failed");
     } else {
         /* libxl calls the QMP command "stop" before calling
          * "xen-save-devices-state" and in case of migration failure, libxl
@@ -3257,7 +3256,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     ret = qemu_loadvm_state(f);
     qemu_fclose(f);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "loading Xen device state failed");
     }
     migration_incoming_state_destroy();
 }
-- 
2.45.0


