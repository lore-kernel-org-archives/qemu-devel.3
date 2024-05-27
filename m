Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17332C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYZv-0004uV-Cc; Mon, 27 May 2024 07:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZo-0004s8-La
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZm-0001P4-CR
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716809497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+8/H9NOh8n2UM5Lr6aYAIQUv69S7Q2wZ9lQ5/X0zyg=;
 b=SUPnBiC6eX4rimR493U19ChDAphQF0G4IPNBRsuUwPsxEsiqCY0tkGvQopwGzJD+9v7n/J
 JRyU2mQifyNicqaEjErVqr1K9dInSdRgs5bv4B0RNQVme7zqlXvN9ELlyiuIl+qy/0KRho
 GOGnFX9lLJVnMxIOI5I1Hw+n87rtvXQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-nE33EuImNqaet5XpWd8vvQ-1; Mon,
 27 May 2024 07:31:34 -0400
X-MC-Unique: nE33EuImNqaet5XpWd8vvQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48BA529AA3A2;
 Mon, 27 May 2024 11:31:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2828B492BC6;
 Mon, 27 May 2024 11:31:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF9EC21E65D7; Mon, 27 May 2024 13:31:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PULL 5/9] migration: Rephrase message on failure to save / load Xen
 device state
Date: Mon, 27 May 2024 13:31:27 +0200
Message-ID: <20240527113131.2054486-6-armbru@redhat.com>
In-Reply-To: <20240527113131.2054486-1-armbru@redhat.com>
References: <20240527113131.2054486-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20240513141703.549874-6-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6c789bd54b..c621f2359b 100644
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
@@ -3203,7 +3202,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     object_unref(OBJECT(ioc));
     ret = qemu_save_device_state(f);
     if (ret < 0 || qemu_fclose(f) < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "saving Xen device state failed");
     } else {
         /* libxl calls the QMP command "stop" before calling
          * "xen-save-devices-state" and in case of migration failure, libxl
@@ -3252,7 +3251,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
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


