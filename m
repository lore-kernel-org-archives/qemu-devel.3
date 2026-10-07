Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D92CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbc-00032N-Vw; Wed, 07 Oct 2026 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb8-0002th-KK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb7-0006Jt-57
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDagjWHFv1Hudak/ht59zB86AR0RncODY5Sy4xUJ7WM=;
 b=Qxuo7kcg/PffK/dPvR1DyF58kv+fgK/zm5VN+6mXbA7KGu3RtCuV7DA2PRQcVHX5IKEvfN
 AtEEL+b5eZGJNOLJouR6T5W0WgSlzlWk4Re0gofOFmaI+wvQOqQAPt26TMS08h04yDsCvD
 SiKlv+mmIO0wP2JAquufnBih//cBO9k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-oaDUfzh0MoScYHUQpPz7LA-1; Wed,
 07 Oct 2026 12:34:27 -0400
X-MC-Unique: oaDUfzh0MoScYHUQpPz7LA-1
X-Mimecast-MFC-AGG-ID: oaDUfzh0MoScYHUQpPz7LA_1791390866
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C1D51955BCB; Wed,  7 Oct 2026 16:34:26 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B01461956087; Wed,  7 Oct 2026 16:34:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/21] scripts/qemugdb: coroutine: Only attempt to restore regs
 in coredump
Date: Wed,  7 Oct 2026 18:32:48 +0200
Message-ID: <20261007163302.332250-8-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When calling 'qemu bt' / 'qemu coroutine' in a live process, we get:

    AttributeError: 'NoneType' object has no attribute 'restore_regs'

That's because for both commands finally: blocks attempt to restore
patched regs unconditionally.  Fix this by guarding regs restoration by
'if is_coredump'.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-4-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index d3f31bab9fe..649579378db 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -354,7 +354,8 @@ def invoke(self, arg, from_tty):
             bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
                       is_coredump, detailed=detailed)
         finally:
-            coredump.restore_regs()
+            if is_coredump:
+                coredump.restore_regs()
 
 class CoroutineBt(gdb.Command):
     __doc__ = textwrap.dedent("""\
@@ -409,7 +410,8 @@ def invoke(self, arg, from_tty):
                 bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
                           detailed=detailed)
         finally:
-            coredump.restore_regs()
+            if is_coredump:
+                coredump.restore_regs()
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.56.0


