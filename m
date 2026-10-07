Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C30ACA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbe-000347-DD; Wed, 07 Oct 2026 12:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbD-0002vA-TY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbC-0006Kr-Du
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knz4UwNqK0rnekPFnOdS9qjQtiobf7YrVWDh0LhQfIU=;
 b=KMCSJk0/1vL38VsifrteBlVlj8i20YoHzCELSecY6LPyCIXSLEScwloS67AevsCZKI+Vgq
 e5xFlk7IcvKDusXWB4wLkNVAyXLnwAwAqJXBN3Nj8u09eBTKI4S5I5Bdlk4/AGnjvh7VIY
 o+K4wsP+EuvUy0/5nw10C55jWP7vBGA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-nltsNlZTPOy9OnAVg0aJdg-1; Wed,
 07 Oct 2026 12:34:32 -0400
X-MC-Unique: nltsNlZTPOy9OnAVg0aJdg-1
X-Mimecast-MFC-AGG-ID: nltsNlZTPOy9OnAVg0aJdg_1791390871
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 547F71935DF5; Wed,  7 Oct 2026 16:34:31 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 058AC1956087; Wed,  7 Oct 2026 16:34:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/21] scripts/qemugdb: coroutine: Fix '--detailed' description
Date: Wed,  7 Oct 2026 18:32:51 +0200
Message-ID: <20261007163302.332250-11-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Both commands claim the coredump is copied before its registers get
patched, but patch_regs() writes to the coredump itself.  Describe what
actually happens, so that nobody expects their coredump to be left alone.
Fix a typo in "runing" while at it.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-7-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 4803914dde0..9148264de3c 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -306,7 +306,7 @@ def bt_jmpbuf(jmpbuf, is_coredump, detailed=False):
         # but only works with live sessions.
         dump_backtrace_live(regs)
     elif detailed:
-        # Obtain detailed trace by patching regs in copied coredump
+        # Obtain detailed trace by patching regs in the coredump in place
         dump_backtrace_patched(regs)
     else:
         # Obtain a non-detailed trace by poor man's unwind
@@ -342,9 +342,9 @@ class CoroutineCommand(gdb.Command):
         Usage: qemu coroutine COROPTR [--detailed]
         Show backtrace for a coroutine specified by COROPTR
 
-          --detailed       obtain detailed trace by copying coredump, patching
-                           regs in it, and runing gdb subprocess to get
-                           backtrace from the patched coredump
+          --detailed       obtain detailed trace by patching regs in the
+                           coredump in place, and running gdb subprocess to
+                           get backtrace from the patched coredump
         """)
 
     def __init__(self):
@@ -380,9 +380,9 @@ class CoroutineBt(gdb.Command):
 
         Usage: qemu bt [--detailed]
 
-          --detailed       obtain detailed trace by copying coredump, patching
-                           regs in it, and runing gdb subprocess to get
-                           backtrace from the patched coredump
+          --detailed       obtain detailed trace by patching regs in the
+                           coredump in place, and running gdb subprocess to
+                           get backtrace from the patched coredump
         """)
 
     def __init__(self):
-- 
2.56.0


