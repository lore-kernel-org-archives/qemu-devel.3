Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8238C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WUQ-0000RQ-G9; Mon, 13 May 2024 10:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WUJ-0000P5-M8
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6WUI-0008LY-5N
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715609829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/P6nXRNKAFpl4GM3C8TWAUCNwPAWckBeOmIyTNegYM=;
 b=RF/0V/6EBgRLqDQICsU+mxRX3YZQ0gglsz9wC7/FWvkwvYTp4Vsnv0zkYJZemsw36knCRj
 1vqUC7GTvdzdSiLlqSohMSMkHrDzwSIn4rhhFHMo++Q4MlHmxRIM4K7hCfc0zg08vJRiU0
 dQQqwdL0MmcLYoKW6wR8PDh6kST5grk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-CT4f9gJ5PUSpc9T0vd13iw-1; Mon,
 13 May 2024 10:17:05 -0400
X-MC-Unique: CT4f9gJ5PUSpc9T0vd13iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCD0638135E8;
 Mon, 13 May 2024 14:17:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B1CA2026D68;
 Mon, 13 May 2024 14:17:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60D7221E5E74; Mon, 13 May 2024 16:17:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
Subject: [PATCH 2/6] dump/win_dump: Improve error messages on write error
Date: Mon, 13 May 2024 16:16:59 +0200
Message-ID: <20240513141703.549874-3-armbru@redhat.com>
In-Reply-To: <20240513141703.549874-1-armbru@redhat.com>
References: <20240513141703.549874-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

create_win_dump() and write_run report qemu_write_full() failure to
their callers as

    An IO error has occurred

The errno set by qemu_write_full() is lost.

Improve this to

    win-dump: failed to write header: <description of errno>

and

    win-dump: failed to save memory: <description of errno>

This matches how dump.c reports similar errors.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/win_dump.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index b7bfaff379..0e4fe692ce 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -12,7 +12,6 @@
 #include "sysemu/dump.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qerror.h"
 #include "exec/cpu-defs.h"
 #include "hw/core/cpu.h"
 #include "qemu/win_dump_defs.h"
@@ -52,6 +51,7 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
     uint64_t addr = base_page << TARGET_PAGE_BITS;
     uint64_t size = page_count << TARGET_PAGE_BITS;
     uint64_t len, l;
+    int eno;
     size_t total = 0;
 
     while (size) {
@@ -65,9 +65,10 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
         }
 
         l = qemu_write_full(fd, buf, len);
+        eno = errno;
         cpu_physical_memory_unmap(buf, addr, false, len);
         if (l != len) {
-            error_setg(errp, QERR_IO_ERROR);
+            error_setg_errno(errp, eno, "win-dump: failed to save memory");
             return 0;
         }
 
@@ -459,7 +460,7 @@ void create_win_dump(DumpState *s, Error **errp)
 
     s->written_size = qemu_write_full(s->fd, h, hdr_size);
     if (s->written_size != hdr_size) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg_errno(errp, errno, "win-dump: failed to write header");
         goto out_restore;
     }
 
-- 
2.45.0


