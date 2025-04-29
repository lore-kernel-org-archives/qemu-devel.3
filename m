Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08915C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nKc-0002wB-Da; Tue, 29 Apr 2025 11:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u9nKY-0002tt-M3
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u9nKW-0003B2-Cv
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745942226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QxSeVOzh1ZOvQlc8005PTafUjWamVAoMPx8ZyD71PAk=;
 b=Rv8fYrZE0vSAkpFreotbBa+fwxVXvCcW2jBbMJCxi8tA+fW7rYJZwoyQpEWs3JEZWgVITF
 JerCeeONFf4BkoM5SI6KOOjc/FacETvCNnpUGI2JCuKFdXOUqfjCutBRXOGwpy6VpyxZCm
 q45zkz0otBlKdhhDkVrKzmKLEGGNz/0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-7ecH-6JrOcWkxgsxJIZdmg-1; Tue,
 29 Apr 2025 11:56:59 -0400
X-MC-Unique: 7ecH-6JrOcWkxgsxJIZdmg-1
X-Mimecast-MFC-AGG-ID: 7ecH-6JrOcWkxgsxJIZdmg_1745942218
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C6E2180034E; Tue, 29 Apr 2025 15:56:58 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.64])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA80819560A3; Tue, 29 Apr 2025 15:56:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH] file-posix: Fix crash on discard_granularity == 0
Date: Tue, 29 Apr 2025 17:56:54 +0200
Message-ID: <20250429155654.102735-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Block devices that don't support discard have a discard_granularity of
0. Currently, this results in a division by zero when we try to make
sure that it's a multiple of request_alignment. Only try to update
bs->bl.pdiscard_alignment when we got a non-zero discard_granularity
from sysfs.

Fixes: f605796aae4 ('file-posix: probe discard alignment on Linux block devices')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0d6e12f880..0d85123d0f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1573,7 +1573,7 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
         int ret;
 
         ret = hdev_get_pdiscard_alignment(&st, &dalign);
-        if (ret == 0) {
+        if (ret == 0 && dalign != 0) {
             uint32_t ralign = bs->bl.request_alignment;
 
             /* Probably never happens, but handle it just in case */
-- 
2.49.0


