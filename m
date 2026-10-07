Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53417CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcc-00049f-6B; Wed, 07 Oct 2026 12:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbM-0002yM-5c
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbK-0006MI-1f
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNEeB10bElCq7MoGCq7Hh45pQlF7H1gVePF8XCdtyG4=;
 b=bq8Xli/y1iUA5nS1YkDnH/Q4p9+JD9+zLtqosFg0m93DmLE0X3Wxcumo9DquNBaHBsj5Sd
 q4PgnJ53HzFHLRFJZY0hDTZjOO5Z4FPOHlmbS4tI5/z4Ozf5Dr1Rqw8GQ7C+cpswjDzrBA
 HlgzzE6rVMzatW7yx4FTNVylcDBmyJQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482--CbCFNUkP4iWV9v1htchvw-1; Wed,
 07 Oct 2026 12:34:37 -0400
X-MC-Unique: -CbCFNUkP4iWV9v1htchvw-1
X-Mimecast-MFC-AGG-ID: -CbCFNUkP4iWV9v1htchvw_1791390876
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E1D119540CF; Wed,  7 Oct 2026 16:34:36 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E5781956087; Wed,  7 Oct 2026 16:34:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 13/21] scripts/qemugdb: coroutine: Don't touch the coredump for
 a plain backtrace
Date: Wed,  7 Oct 2026 18:32:54 +0200
Message-ID: <20261007163302.332250-14-kwolf@redhat.com>
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

init_coredump() creates a Coredump object for every coredump session.  That
implies opening and scanning the actual coredump file.   For non-detailed
'qemu bt' invocation we don't really need it.

Les't only create the object when the core is about to be patched, i.e.
for '--detailed'.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-10-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 21ed7cbaab8..edc1f3cc69f 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -328,7 +328,7 @@ def coroutine_to_jmpbuf(co):
     coroutine_pointer = co_cast(co)
     return coroutine_pointer['env']['__jmpbuf']
 
-def init_coredump():
+def init_coredump(detailed=False):
     global coredump
 
     files = gdb.execute('info files', False, True)
@@ -337,7 +337,8 @@ def init_coredump():
     if match is None:
         return False
 
-    if coredump is None:
+    # The object is only needed to patch the coredump
+    if detailed and coredump is None:
         coredump = Coredump(match.group(1), gdb.current_progspace().filename)
 
     return True
@@ -372,7 +373,7 @@ def invoke(self, arg, from_tty):
         if gdb.selected_thread() is None:
             raise gdb.GdbError('No stack.')
 
-        is_coredump = init_coredump()
+        is_coredump = init_coredump(detailed)
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
             return
@@ -381,7 +382,7 @@ def invoke(self, arg, from_tty):
             bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
                       is_coredump, detailed=detailed)
         finally:
-            if is_coredump:
+            if coredump is not None:
                 coredump.restore_regs()
 
 class CoroutineBt(gdb.Command):
@@ -413,7 +414,7 @@ def invoke(self, arg, from_tty):
         if gdb.selected_thread() is None:
             raise gdb.GdbError('No stack.')
 
-        is_coredump = init_coredump()
+        is_coredump = init_coredump(detailed)
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
             return
@@ -441,7 +442,7 @@ def invoke(self, arg, from_tty):
                 bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
                           detailed=detailed)
         finally:
-            if is_coredump:
+            if coredump is not None:
                 coredump.restore_regs()
 
 class CoroutineSPFunction(gdb.Function):
-- 
2.56.0


