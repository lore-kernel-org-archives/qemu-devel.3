Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40F4C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNg-0006cl-0y; Mon, 10 Feb 2025 11:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNM-0006Tm-Il
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNI-0000zX-2h
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTvvyJV51yKmE4CVU0pXnpzRX1iwCAAQnLunpxMEj1g=;
 b=db5brUxfLo/5sOS8fT7ceG/DLMmsi4ZgxhGN+tKFFJ+72Ut2hhHSKvJceE0jlTzQRAZPYC
 ucgRG/Bj405Za4aiu0KiLGYBjMw4MVLZkD8MNWGxBqczh7BP+edvTLd5AgvoExMiXZLGda
 V3JkYtH+XNvW7xQOptw0qhmZhBUUqGY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-zoyOfZJ4M9CVnacaZuJfIQ-1; Mon,
 10 Feb 2025 11:11:03 -0500
X-MC-Unique: zoyOfZJ4M9CVnacaZuJfIQ-1
X-Mimecast-MFC-AGG-ID: zoyOfZJ4M9CVnacaZuJfIQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C233A1800879; Mon, 10 Feb 2025 16:11:02 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C77B195608D; Mon, 10 Feb 2025 16:11:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/25] scripts/qemu-gdb: Simplify fs_base fetching for
 coroutines
Date: Mon, 10 Feb 2025 17:10:15 +0100
Message-ID: <20250210161034.76494-7-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Xu <peterx@redhat.com>

There're a bunch of code trying to fetch fs_base in different ways.  IIUC
the simplest way instead is "$fs_base".  It also has the benefit that it'll
work for both live gdb session or coredumps.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241212204801.1420528-3-peterx@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 7db46d4b68..20f76ed37b 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -13,28 +13,9 @@
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
-def get_fs_base():
-    '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
-       pthread_self().'''
-    # %rsp - 120 is scratch space according to the SystemV ABI
-    old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
-    fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
-    return fs_base
-
 def pthread_self():
-    '''Fetch pthread_self() from the glibc start_thread function.'''
-    f = gdb.newest_frame()
-    while f.name() != 'start_thread':
-        f = f.older()
-        if f is None:
-            return get_fs_base()
-
-    try:
-        return f.read_var("arg")
-    except ValueError:
-        return get_fs_base()
+    '''Fetch the base address of TLS.'''
+    return gdb.parse_and_eval("$fs_base")
 
 def get_glibc_pointer_guard():
     '''Fetch glibc pointer guard value'''
-- 
2.48.1


