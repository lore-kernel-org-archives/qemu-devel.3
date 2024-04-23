Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198B1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHne-0007Ku-CP; Tue, 23 Apr 2024 11:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmk-0004Na-DD
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmh-00006a-GE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlpPVTBNKVZ/awosdGXGLIItCtvp+4fpatVD/Uy1dPI=;
 b=HN4beVNIfdnZznBagLCkawUhsHUsM8zNJJ38j2uBLxGGIES+PuoYuGOxq2D6bjpFjcSgp8
 Vbsp4WDXhURnhCBWXYOvz2x4QumRHAUX43Z6dqLtbweuO3JbRry1wxZ172LAghBx0P0yQl
 fGBRuEo7FMuWe7l/+q8hLrcf2JQHiro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-amladxOgOCyvuMKwWJb8QQ-1; Tue, 23 Apr 2024 11:10:12 -0400
X-MC-Unique: amladxOgOCyvuMKwWJb8QQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D9E01827100;
 Tue, 23 Apr 2024 15:10:12 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86AB4200AFA2;
 Tue, 23 Apr 2024 15:10:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/63] stubs: move monitor_fdsets_cleanup with other fdset stubs
Date: Tue, 23 Apr 2024 17:09:06 +0200
Message-ID: <20240423150951.41600-19-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Even though monitor_get_fd() has to remain separate because it is mocked by
tests/unit/test-util-sockets, monitor_fdsets_cleanup() is logically part
of the stubs for monitor/fds.c, so move it there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240408155330.522792-19-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/fdset.c            | 6 ++++++
 stubs/monitor-internal.c | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/stubs/fdset.c b/stubs/fdset.c
index 56b3663d588..d7c39a28acb 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -1,5 +1,7 @@
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "monitor/monitor.h"
+#include "../monitor/monitor-internal.h"
 
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
 {
@@ -15,3 +17,7 @@ int64_t monitor_fdset_dup_fd_find(int dup_fd)
 void monitor_fdset_dup_fd_remove(int dupfd)
 {
 }
+
+void monitor_fdsets_cleanup(void)
+{
+}
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 20786ac4ffb..4fece49d531 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
-#include "../monitor/monitor-internal.h"
 
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
@@ -12,7 +11,3 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
 }
-
-void monitor_fdsets_cleanup(void)
-{
-}
-- 
2.44.0



