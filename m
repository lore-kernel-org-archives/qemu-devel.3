Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8CFFD4F03
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvW-0003fQ-8L; Tue, 10 Mar 2026 12:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvK-0003R2-Pz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvI-0000wt-82
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMADtodgxED6gXdhsqP/rjK9lfC+lRgElo+09eD/r3w=;
 b=RvMyeqWp3mDQ0cIOQkAPCyrA3aeOJ2p3rApwyWUjm3B9UojTtKXRx1Zx4sh6QBk3xIOAVZ
 i5q7qwDbzqzi+XDvU9m2Yx8ep4ZhTJKpu5QKCrHZjf8JrvTeKLh7seujpZTptvNPndY918
 SnkvG6TtoL0z61JeNLfmt8t/3nrG87A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-Ga04mpZ5NMu_sP4JrOARGA-1; Tue,
 10 Mar 2026 12:27:05 -0400
X-MC-Unique: Ga04mpZ5NMu_sP4JrOARGA-1
X-Mimecast-MFC-AGG-ID: Ga04mpZ5NMu_sP4JrOARGA_1773160024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95FA81956057; Tue, 10 Mar 2026 16:27:04 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B9E619560A6; Tue, 10 Mar 2026 16:27:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 21/28] iotests/307: Test multi-thread export interface
Date: Tue, 10 Mar 2026 17:26:15 +0100
Message-ID: <20260310162622.333137-22-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Hanna Czenczek <hreitz@redhat.com>

Test the QAPI interface for multi-threaded exports.  None of our exports
currently support multi-threading, so it's always an error in the end,
but we can still test the specific errors.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-22-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/307     | 47 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/307.out | 18 +++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/tests/qemu-iotests/307 b/tests/qemu-iotests/307
index b429b5aa50a..f6ee3ebec08 100755
--- a/tests/qemu-iotests/307
+++ b/tests/qemu-iotests/307
@@ -142,5 +142,52 @@ with iotests.FilePath('image') as img, \
     vm.qmp_log('query-block-exports')
     iotests.qemu_nbd_list_log('-k', socket)
 
+    iotests.log('\n=== Using multi-thread with NBD ===')
+
+    # Actual multi-threading; (currently) not supported by NBD
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0', 'iothread1'])
+
+    # Should be treated the same way as actual multi-threading, even if there's
+    # only a single thread
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0'])
+
+    iotests.log('\n=== Empty thread list')
+
+    # Simply not allowed
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=[])
+
+    iotests.log('\n=== Non-existent thread name in list')
+
+    # Expect an error, even if NBD does not support multi-threading, because the
+    # list is parsed before being passed to NBD
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0', 'nothread', 'iothread1'])
+
+    iotests.log('\n=== Multi-thread with fixed-iothread')
+
+    # With multi-threading, there is no single context to give the BDS, so it is
+    # just left where it is.  fixed-iothread does not make sense then.
+    vm.qmp_log('block-export-add',
+               id='export0',
+               type='nbd',
+               node_name='fmt',
+               iothread=['iothread0', 'iothread1'],
+               fixed_iothread=True)
+
     iotests.log('\n=== Shut down QEMU ===')
     vm.shutdown()
diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
index f645f3315f8..a9b37d3ac11 100644
--- a/tests/qemu-iotests/307.out
+++ b/tests/qemu-iotests/307.out
@@ -134,4 +134,22 @@ read failed: Input/output error
 exports available: 0
 
 
+=== Using multi-thread with NBD ===
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": ["iothread0", "iothread1"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "NBD export does not support multi-threading"}}
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": ["iothread0"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "NBD export does not support multi-threading"}}
+
+=== Empty thread list
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": [], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "The set of I/O threads must not be empty"}}
+
+=== Non-existent thread name in list
+{"execute": "block-export-add", "arguments": {"id": "export0", "iothread": ["iothread0", "nothread", "iothread1"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "iothread \"nothread\" not found"}}
+
+=== Multi-thread with fixed-iothread
+{"execute": "block-export-add", "arguments": {"fixed-iothread": true, "id": "export0", "iothread": ["iothread0", "iothread1"], "node-name": "fmt", "type": "nbd"}}
+{"error": {"class": "GenericError", "desc": "Cannot use fixed-iothread for a multi-threaded export"}}
+
 === Shut down QEMU ===
-- 
2.53.0


