Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81794C25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYa7-00051k-BP; Mon, 27 May 2024 07:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZo-0004s6-KJ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZl-0001Oe-Pw
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716809496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60cRWFZoJmzp2R5J/UmL7L3ILwxklIPSAGWkNk9aSCA=;
 b=bfo69NdL+95fwkMO18vE8ztvkoSfLvtoJkzKC4v5Ho8BYytFEt79ZAILk2ruaXxTjmIAZ7
 hHdBBUMeBNRHLYIJC/HjcBlTD6dYUWKiytbN8GzGnbLPm1uqHYTkpY7xV27yFpbbVG0+Pr
 10JslvbwbrRqKNdz3mJzMj/2dk2jYKQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-FJt7BHfvN7SqxcNFt03SjQ-1; Mon,
 27 May 2024 07:31:33 -0400
X-MC-Unique: FJt7BHfvN7SqxcNFt03SjQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C183380670C;
 Mon, 27 May 2024 11:31:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9D2140004D;
 Mon, 27 May 2024 11:31:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6CB221E6697; Mon, 27 May 2024 13:31:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/9] dump/win_dump: Improve error messages on write error
Date: Mon, 27 May 2024 13:31:24 +0200
Message-ID: <20240527113131.2054486-3-armbru@redhat.com>
In-Reply-To: <20240527113131.2054486-1-armbru@redhat.com>
References: <20240527113131.2054486-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Message-ID: <20240513141703.549874-3-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


