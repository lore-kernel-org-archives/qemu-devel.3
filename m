Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B673EDA681
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRL9-0007UN-BD; Tue, 03 Mar 2026 10:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRL7-0007Hf-KK
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRL5-0002Bl-TA
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAn5uCxKHsi4ZTxZAQG+S8tZlo8bxfoEvDBRqGdtdGY=;
 b=GLTSqCHdaUEutfRcW3FyOVkdCT36WrHB9Qc0sKWK09PnWs6TMT9w27dPBhG5bQ0y9/5Qvn
 Ee4y7ErA8ga7Djhzswq6ImqYc4J6lUuhfPAL5u4/cyoan1F4J5wLs0rBJt627BddUfjKIM
 WA8nkZqXfOaX/jKwGAsjSB5RdniEIJE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-2KlUCOHDMbaBQKISE7QD0w-1; Tue,
 03 Mar 2026 10:07:05 -0500
X-MC-Unique: 2KlUCOHDMbaBQKISE7QD0w-1
X-Mimecast-MFC-AGG-ID: 2KlUCOHDMbaBQKISE7QD0w_1772550424
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AE8519560AA; Tue,  3 Mar 2026 15:07:04 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3D501800348; Tue,  3 Mar 2026 15:07:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jon Kohler <jon@nutanix.com>
Subject: [PULL 27/27] util/oslib-posix: increase memprealloc thread count to 32
Date: Tue,  3 Mar 2026 15:06:04 +0000
Message-ID: <20260303150604.2402872-28-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
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

From: Jon Kohler <jon@nutanix.com>

Increase MAX_MEM_PREALLOC_THREAD_COUNT from 16 to 32. This was last
touched in 2017 [1] and, since then, physical machine sizes and VMs
therein have continue to get even bigger, both on average and on the
extremes.

For very large VMs, using 16 threads to preallocate memory can be a
non-trivial bottleneck during VM start-up and migration. Increasing
this limit to 32 threads reduces the time taken for these operations.

Test results from quad socket Intel 8490H (4x 60 cores) show a fairly
linear gain of 50% with the 2x thread count increase.

---------------------------------------------
Idle Guest w/ 2M HugePages   | Start-up time
---------------------------------------------
240 vCPU, 7.5TB (16 threads) | 2m41.955s
---------------------------------------------
240 vCPU, 7.5TB (32 threads) | 1m19.404s
---------------------------------------------

Note: Going above 32 threads appears to have diminishing returns at
the point where the memory bandwidth and context switching costs
appear to be a limiting factor to linear scaling. For posterity, on
the same system as above:
- 32 threads: 1m19s
- 48 threads: 1m4s
- 64 threads: 59s
- 240 threads: 50s

Additional thread counts also get less interesting as the amount of
memory is to be preallocated is smaller. Putting that all together,
32 threads appears to be a sane number with a solid speedup on fairly
modern hardware. To go faster, we'd either need to improve the hardware
(CPU/memory) itself or improve clear_pages_*() on the kernel side to
be more efficient.

[1] 1e356fc14bea ("mem-prealloc: reduce large guest start-up and migration time.")

Signed-off-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/oslib-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3c14b72665..dc001da66d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -61,7 +61,7 @@
 #include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"
 
-#define MAX_MEM_PREALLOC_THREAD_COUNT 16
+#define MAX_MEM_PREALLOC_THREAD_COUNT 32
 
 struct MemsetThread;
 
-- 
2.53.0


