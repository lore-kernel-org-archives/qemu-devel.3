Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C7C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 13:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28ab-0006r8-OK; Tue, 08 Apr 2025 09:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u28ZZ-0006lT-NS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u28ZX-0005bg-O6
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744117258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rX++C6y7c2kTkmHdJ5btTzWRmxB6hJRYTB6HAm2FhE=;
 b=ZCTkAFAuCLcm8kqSW1Wzql55ob9BhPA8j0eOnr3OTDFdXPSw9whT2aBLB4ZDSeTaen38HF
 iInvVPAGRqbBfcMhV8ALAm+goJqzWZpsh6uuN6q4jHRyi0nlbQnxy6sQPchS2088A5ljnI
 tqCzkFWOnhWCf+3O8xuKg0kdRHFFxKI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-u_drAbzINzOnWPJIaF9-fA-1; Tue,
 08 Apr 2025 09:00:56 -0400
X-MC-Unique: u_drAbzINzOnWPJIaF9-fA-1
X-Mimecast-MFC-AGG-ID: u_drAbzINzOnWPJIaF9-fA_1744117255
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E3141956053; Tue,  8 Apr 2025 13:00:55 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AA211955BF1; Tue,  8 Apr 2025 13:00:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 1/4] qemu-img: fix division by zero in bench_cb() for
 zero-sized images
Date: Tue,  8 Apr 2025 15:00:45 +0200
Message-ID: <20250408130048.283364-2-kwolf@redhat.com>
In-Reply-To: <20250408130048.283364-1-kwolf@redhat.com>
References: <20250408130048.283364-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

This commit fixes a division by zero error in the bench_cb() function
that occurs when using the bench command with a zero-sized image.

The issue arises because b->image_size can be zero, leading to a
division by zero in the modulo operation (b->offset %= b->image_size).
This patch adds a check for b->image_size == 0 and resets b->offset
to 0 in such cases, preventing the error.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Message-ID: <20250318101933.255617-1-gerben@altlinux.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 89c93c1eb5..2044c22a4c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4488,7 +4488,11 @@ static void bench_cb(void *opaque, int ret)
          */
         b->in_flight++;
         b->offset += b->step;
-        b->offset %= b->image_size;
+        if (b->image_size == 0) {
+            b->offset = 0;
+        } else {
+            b->offset %= b->image_size;
+        }
         if (b->write) {
             acb = blk_aio_pwritev(b->blk, offset, b->qiov, 0, bench_cb, b);
         } else {
-- 
2.49.0


