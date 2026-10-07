Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92AFCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbQ-0002zH-9f; Wed, 07 Oct 2026 12:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb8-0002tZ-1n
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb6-0006Ji-Mz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5h0prqwXWxiGIul/IlgDwJeY57yRSzdewxBqG3X8HU=;
 b=gitaIf1/Me/wH0zxw+OLPhF0qWh2q8akywMPjphmkymO5XLNKX13Mob7mnvz6rK3JGFSYb
 ZxfMOqwnOAH1u4Q0p/6sqlVrf/cvaV+LDgQiSF+reNOywS+8fbgRvlTDqO2F4CObWn7LZn
 j0ajkT53VLywZiHKR8OFRE+7aiV7Pzc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-ONi75Z0QOIKjDAfh5I6Mgg-1; Wed,
 07 Oct 2026 12:34:23 -0400
X-MC-Unique: ONi75Z0QOIKjDAfh5I6Mgg-1
X-Mimecast-MFC-AGG-ID: ONi75Z0QOIKjDAfh5I6Mgg_1791390862
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89B9F185FE58; Wed,  7 Oct 2026 16:34:22 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38CE71956087; Wed,  7 Oct 2026 16:34:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/21] scripts/qemugdb: coroutine: Fix selected frame leak on
 error path
Date: Wed,  7 Oct 2026 18:32:46 +0200
Message-ID: <20261007163302.332250-6-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently, whenever gdb.execute() fails and throws an exception,
previously selected frame gets leaked.  I.e.:

  (gdb) frame N
  (gdb) qemu bt # throws exception
  (gdb) frame   # shows 0, not N

As a fix, wrap gdb.execute() commands in try/finally, so that selected
frame gets restored no matter what.

Fixes: 4cbf8efc5b89 ("scripts/gdb: fix 'qemu coroutine' when users selects a non topmost stack frame")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-2-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 29f57ae84ed..d1e6722d14d 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -265,18 +265,21 @@ def dump_backtrace_live(regs):
     selected_frame = gdb.selected_frame()
     gdb.newest_frame().select()
 
-    for i in regs:
-        old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
-
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, regs[i]))
-
-    gdb.execute('bt')
+    try:
+        for i in regs:
+            old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
 
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, old[i]))
+        for i in regs:
+            gdb.execute('set $%s = %s' % (i, regs[i]))
 
-    selected_frame.select()
+        gdb.execute('bt')
+    finally:
+        try:
+            for i in old:
+                gdb.execute('set $%s = %s' % (i, old[i]))
+        finally:
+            # restore previously selected frame in any case
+            selected_frame.select()
 
 def bt_jmpbuf(jmpbuf, detailed=False):
     '''Backtrace a jmpbuf'''
-- 
2.56.0


