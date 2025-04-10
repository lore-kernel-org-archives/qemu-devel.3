Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42800C369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 18:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2wxy-0005eY-FH; Thu, 10 Apr 2025 14:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2wxG-0005YF-VE
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2wxD-0006lT-DN
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744310926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9n00Jxc8hu1xXA3jc8CVP7N9a4Pf3tNPMmo2saLwBwE=;
 b=Wpm+0HvDBON50UCHPpjHcbUj/4/Bm7DtNoTbhHAZkLtTE3m9l4BvQk4CtsBsAaXW/nQaDb
 R9YeZAnrMArAranGul4CMfJ1CJhTXTNcukgKBWGn9Vaf1O5cOu/tc70hMGSPAC9amjQtR6
 hE0t+7FRpg+HnOFvfYGpJPBqYOkQ3PA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-zDNS46xDNXm08ev2cPkh0Q-1; Thu,
 10 Apr 2025 14:48:44 -0400
X-MC-Unique: zDNS46xDNXm08ev2cPkh0Q-1
X-Mimecast-MFC-AGG-ID: zDNS46xDNXm08ev2cPkh0Q_1744310923
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA05D1800259; Thu, 10 Apr 2025 18:48:42 +0000 (UTC)
Received: from localhost (unknown [10.2.17.97])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7BE519560AD; Thu, 10 Apr 2025 18:48:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 <qemu-block@nongnu.org>
Subject: [PATCH v2 2/2] block/io: skip head/tail requests on EINVAL
Date: Thu, 10 Apr 2025 14:41:03 -0400
Message-ID: <20250410184103.23385-3-stefanha@redhat.com>
In-Reply-To: <20250410184103.23385-1-stefanha@redhat.com>
References: <20250410184103.23385-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When guests send misaligned discard requests, the block layer breaks
them up into a misaligned head, an aligned main body, and a misaligned
tail.

The file-posix block driver on Linux returns -EINVAL on misaligned
discard requests. This causes bdrv_co_pdiscard() to fail and guests
configured with werror=stop will pause.

Add a special case for misaligned head/tail requests. Simply continue
when EINVAL is encountered so that the aligned main body of the request
can be completed and the guest is not paused. This is the best we can do
when guest discard limits do not match the host discard limits.

Fixes: https://issues.redhat.com/browse/RHEL-86032
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 1ba8d1aeea..a0d0b31a3e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3180,7 +3180,11 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
             }
         }
         if (ret && ret != -ENOTSUP) {
-            goto out;
+            if (ret == -EINVAL && (offset % align != 0 || num % align != 0)) {
+                /* Silently skip rejected unaligned head/tail requests */
+            } else {
+                goto out; /* bail out */
+            }
         }
 
         offset += num;
-- 
2.49.0


