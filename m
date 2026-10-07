Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0821ECA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcE-0003hS-RY; Wed, 07 Oct 2026 12:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbI-0002xA-Da
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbG-0006Lk-G8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Fp8cpt4NUe2PL4upuvYP3uT/Q+ZAbBl5lUwHNtHTMY=;
 b=XwutRlu3F6iCHDSWNWyWoxZWB/UWyxW8BqYPwcH5NQCqRzEHAk0IJJNvAlZ3t/g4owzHM8
 dae1WHxBqtHgVjeqinq+KCSXeABKKJaLIT8jCK0/kQM0lzzKlSPp64HU2nlVd0aQEEo/xy
 uSM1Y/oBI08dmC7ukWJ82lYaK01oagU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-4ASzn1oTMtOGs0HsWUkQPw-1; Wed,
 07 Oct 2026 12:34:34 -0400
X-MC-Unique: 4ASzn1oTMtOGs0HsWUkQPw-1
X-Mimecast-MFC-AGG-ID: 4ASzn1oTMtOGs0HsWUkQPw_1791390873
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4871019540C9; Wed,  7 Oct 2026 16:34:33 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAFEC1956087; Wed,  7 Oct 2026 16:34:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/21] scripts/qemugdb: coroutine: Handle target absence
 gracefully
Date: Wed,  7 Oct 2026 18:32:52 +0200
Message-ID: <20261007163302.332250-12-kwolf@redhat.com>
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

init_coredump() picks the core dump and the executable out of fixed lines
of 'info files' output.  With no target loaded that output is empty, and
'qemu bt' dies with:

    IndexError: list index out of range

Search the whole output for the core dump file instead, and take the
executable from gdb.current_progspace(), which doesn't need parsing at
all.  Neither can raise if the pattern isn't there, so an unexpected
output format now just means "not a coredump" rather than a traceback.

That alone only moves the problem to gdb.execute("bt"), whose gdb.error
escapes invoke() and still gets reported as a python traceback.  At the
same time plain 'bt' just prints 'No stack.'.  Let's mimick this
behaviour and simply report an error if there's no selected thread.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-8-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 9148264de3c..3e0b37b73ea 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -322,16 +322,14 @@ def coroutine_to_jmpbuf(co):
 def init_coredump():
     global coredump
 
-    files = gdb.execute('info files', False, True).split('\n')
+    files = gdb.execute('info files', False, True)
 
-    if not 'core dump' in files[1]:
+    match = re.search(r"core dump file:\s*`([^']+)'", files)
+    if match is None:
         return False
 
-    core_path = re.search("`(.*)'", files[2]).group(1)
-    exec_path = re.match('^Symbols from "(.*)".$', files[0]).group(1)
-
     if coredump is None:
-        coredump = Coredump(core_path, exec_path)
+        coredump = Coredump(match.group(1), gdb.current_progspace().filename)
 
     return True
 
@@ -362,6 +360,9 @@ def invoke(self, arg, from_tty):
             return self._usage()
         detailed = True if argc == 2 else False
 
+        if gdb.selected_thread() is None:
+            raise gdb.GdbError('No stack.')
+
         is_coredump = init_coredump()
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
@@ -400,6 +401,9 @@ def invoke(self, arg, from_tty):
             return self._usage()
         detailed = True if argc == 1 else False
 
+        if gdb.selected_thread() is None:
+            raise gdb.GdbError('No stack.')
+
         is_coredump = init_coredump()
         if detailed and not is_coredump:
             gdb.write('--detailed is only valid when debugging core dumps\n')
-- 
2.56.0


