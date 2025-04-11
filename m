Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8523AC369AF
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32s7-0006KA-Sw; Thu, 10 Apr 2025 21:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32s2-0006Jm-PV
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32s0-0004I4-R7
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744333667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZkyi0Zz5g4FNFrSOeCcuZwXAOyZvQwC0Ax4vbVu7IM=;
 b=LSyOves0LfTnqPH5hzgYsnnQwVR3evocpWw2cXyVVnw1YLqaDyvHT+eLsMBBYCIu974UxB
 JbzhcbAsFE+4PuZzI23YGbwUlgFmqIel3GAPlqWLCVrFtN0J9OVfJGsS/4V/gfuflbL0/1
 o5IWF47CSNn+PvjsrFgTxe0mEj9lqJc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155--z2AMpp5PDeiowqW3XM5Zw-1; Thu,
 10 Apr 2025 21:07:44 -0400
X-MC-Unique: -z2AMpp5PDeiowqW3XM5Zw-1
X-Mimecast-MFC-AGG-ID: -z2AMpp5PDeiowqW3XM5Zw_1744333663
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83E5B1801A00; Fri, 11 Apr 2025 01:07:43 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90ED318009BC; Fri, 11 Apr 2025 01:07:42 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:raw)
Subject: [PATCH 2/6] file-posix: Allow lseek at offset 0 when !want_zero
Date: Thu, 10 Apr 2025 20:04:52 -0500
Message-ID: <20250411010732.358817-10-eblake@redhat.com>
In-Reply-To: <20250411010732.358817-8-eblake@redhat.com>
References: <20250411010732.358817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

The 'want_zero' parameter to raw_co_block_status() was added so that
we can avoid potentially time-consuming lseek(SEEK_DATA) calls
throughout the file (working around poor filesystems that have O(n)
rather than O(1) extent probing).  But when it comes to learning if a
file is completely sparse (for example, it was just created), always
claiming that a file is all data without even checking offset 0 breaks
what would otherwise be attempts at useful optimizations for a
known-zero mirror destination.

Note that this allows file-posix to report a file as completely zero
if it was externally created (such as via 'truncate --size=$n file')
as entirely sparse; however, it does NOT work for files created
internally by blockdev-create.  That's because blockdev-create
intentionally does a sequence of truncate(0), truncate(size),
allocate_first_block(), in order to make it possible for gluster on
XFS to probe the sector size for direct I/O (which doesn't work if the
first block is sparse).  That will be addressed in a later patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d156..67e83528cf5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3217,7 +3217,14 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (!want_zero) {
+    /*
+     * If want_zero is clear, then the caller wants speed over
+     * accuracy, and the only place where SEEK_DATA should be
+     * attempted is at the start of the file to learn if the file has
+     * any data at all (anywhere else, just blindly claim the entire
+     * file is data).
+     */
+    if (!want_zero && offset) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
-- 
2.49.0


