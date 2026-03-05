Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE93F47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCqX-0007Ze-KI; Thu, 05 Mar 2026 12:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCq9-0006dj-5V
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCq7-0002bG-Mc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAn5uCxKHsi4ZTxZAQG+S8tZlo8bxfoEvDBRqGdtdGY=;
 b=WcNd+K295IXR0rYAAkGM485ckq8bZrl9wdP5ajUjr3rmpPPLokEiCve0vzuAW8yxEt5YNz
 FiC1KuSCD3pQnsea/NPr+2t7QYUV934Uqgsr4zPkx3M+bmAPJ7c1SEyhf1WijotVhBiUJo
 Y+pw543tBPJvEHCkfHeqgd7sbTx4ZOA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-TAGewmzgNOGoFnt5JOPXRw-1; Thu,
 05 Mar 2026 12:50:19 -0500
X-MC-Unique: TAGewmzgNOGoFnt5JOPXRw-1
X-Mimecast-MFC-AGG-ID: TAGewmzgNOGoFnt5JOPXRw_1772733018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA27E18005B9; Thu,  5 Mar 2026 17:50:17 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 184421956095; Thu,  5 Mar 2026 17:50:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jon Kohler <jon@nutanix.com>
Subject: [PULL 27/27] util/oslib-posix: increase memprealloc thread count to 32
Date: Thu,  5 Mar 2026 17:47:43 +0000
Message-ID: <20260305174743.3084606-28-berrange@redhat.com>
In-Reply-To: <20260305174743.3084606-1-berrange@redhat.com>
References: <20260305174743.3084606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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


