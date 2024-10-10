Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB292CF11FC
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 15:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syufw-0000T3-QB; Thu, 10 Oct 2024 11:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syuft-0000R3-9p
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syufr-0003GC-RA
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728572514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bk4xte5W5tm8S9sgv3z4qkfh3Dfy23pC+ZOBftEffqo=;
 b=KX2+hcYGB+iv0g83M95AxJEU8ShPQztvyaOkb1weJRkO/oNwzkhXfVfVbRkttteqqf7IV6
 PZmgANenI2nO+qTa1ej+uUMXltwQrokepkSEUrp8n4XTPYpWuFvS4Ok0g4FhxY7PEzxbKb
 8lCRkhjVNlHk5VFxj5vmYJmyKnthJ6Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-ubvjaxwyN06MMzrLNnbI5A-1; Thu,
 10 Oct 2024 11:01:51 -0400
X-MC-Unique: ubvjaxwyN06MMzrLNnbI5A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 585F31955D45; Thu, 10 Oct 2024 15:01:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF5E8300019F; Thu, 10 Oct 2024 15:01:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D08121E692E; Thu, 10 Oct 2024 17:01:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 2/7] block: Improve errors about block sizes
Date: Thu, 10 Oct 2024 17:01:39 +0200
Message-ID: <20241010150144.986655-3-armbru@redhat.com>
In-Reply-To: <20241010150144.986655-1-armbru@redhat.com>
References: <20241010150144.986655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Block sizes need to be a power of two between 512 and an arbitrary
limit, currently 2MiB.

Commit 5937835ac4c factored block size checking out of set_blocksize()
into new check_block_size(), for reuse in block/export/.

Its two error messages are okay for the original purpose:

    $ qemu-system-x86_64 -device ide-hd,physical_block_size=1
    qemu-system-x86_64: -device ide-hd,physical_block_size=1: Property .physical_block_size doesn't take value 1 (minimum: 512, maximum: 2097152)
    $ qemu-system-x86_64 -device ide-hd,physical_block_size=513
    qemu-system-x86_64: -device ide-hd,physical_block_size=513: Property .physical_block_size doesn't take value '513', it's not a power of 2

They're mildly off for block exports:

    $ qemu-storage-daemon --blockdev node-name=nod0,driver=file,filename=foo.img --export type=vduse-blk,id=exp0,node-name=nod0,name=foo,logical-block-size=1
    qemu-storage-daemon: --export type=vduse-blk,id=exp0,node-name=nod0,name=foo,logical-block-size=1: Property exp0.logical-block-size doesn't take value 1 (minimum: 512, maximum: 2097152)

The error message talks about a property.  CLI options like --export
don't have properties, they have parameters.

Replace the two error messages by a single one that's okay for both
purposes.  Looks like this:

    qemu-storage-daemon: --export type=vduse-blk,id=exp0,node-name=nod0,name=foo,logical-block-size=1: parameter logical-block-size must be a power of 2 between 512 and 2097152

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/block-helpers.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/util/block-helpers.c b/util/block-helpers.c
index c4851432f5..fb5de348e2 100644
--- a/util/block-helpers.c
+++ b/util/block-helpers.c
@@ -10,7 +10,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "block-helpers.h"
 
 /**
@@ -28,19 +27,16 @@
 void check_block_size(const char *id, const char *name, int64_t value,
                       Error **errp)
 {
-    /* value of 0 means "unset" */
-    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   id, name, value, MIN_BLOCK_SIZE, MAX_BLOCK_SIZE);
+    if (!value) {
+        /* unset */
         return;
     }
 
-    /* We rely on power-of-2 blocksizes for bitmasks */
-    if ((value & (value - 1)) != 0) {
+    if (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE
+        || (value & (value - 1))) {
         error_setg(errp,
-                   "Property %s.%s doesn't take value '%" PRId64
-                   "', it's not a power of 2",
-                   id, name, value);
-        return;
+                   "parameter %s must be a power of 2 between %" PRId64
+                   " and %" PRId64,
+                   name, MIN_BLOCK_SIZE, MAX_BLOCK_SIZE);
     }
 }
-- 
2.46.0


