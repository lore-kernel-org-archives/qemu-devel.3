Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF23FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvV-0003eP-Uv; Tue, 10 Mar 2026 12:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzv6-0003Hm-38
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzv4-0000tW-LF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a90dg7Kpj66lfcCXYa3gY/ZRYMIGRWa/2aZcC7ix4io=;
 b=IFZz+lpbi/awAqHEtsLKifwuHvKOmOZq7nch9Y/co6jou46MbRFl0em7Vxu7ndq/zhHKVd
 s6BGMxFmXUssGpGJwwZlXfGjlSWK3NwLRV0GiIyMMYh26kXk6m8jKw2URfv8GQQxpA8s1X
 hwOEjAJ/CRav9/x9Ih8hQe/20+OqVtM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-C9FmgeQHPm-YlMCdK9MRPw-1; Tue,
 10 Mar 2026 12:26:52 -0400
X-MC-Unique: C9FmgeQHPm-YlMCdK9MRPw-1
X-Mimecast-MFC-AGG-ID: C9FmgeQHPm-YlMCdK9MRPw_1773160011
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ADFA195608F; Tue, 10 Mar 2026 16:26:51 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6437B19560A6; Tue, 10 Mar 2026 16:26:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/28] iotests/308: Use conv=notrunc to test growability
Date: Tue, 10 Mar 2026 17:26:07 +0100
Message-ID: <20260310162622.333137-14-kwolf@redhat.com>
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

Without conv=notrunc, dd will automatically truncate the output file to
the @seek value at least.  We want to test post-EOF I/O, not truncate,
so pass conv=notrunc.

(It does not make a difference in practice because we only seek to the
EOF, so the truncate effectively does nothing, but this is still
cleaner.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-14-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/308 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 033d5cbe222..6ecb275555a 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -296,7 +296,8 @@ orig_disk_usage=$(disk_usage "$TEST_IMG")
 # Should fail (exports are non-growable by default)
 # (Note that qemu-io can never write beyond the EOF, so we have to use
 # dd here)
-dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$orig_len 2>&1 \
+dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$orig_len \
+    conv=notrunc 2>&1 \
     | _filter_testdir | _filter_imgfmt
 
 echo
@@ -333,7 +334,7 @@ fuse_export_add \
     'node-protocol'
 
 # Now we should be able to write beyond the EOF
-dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$new_len 2>&1 \
+dd if=/dev/zero of="$EXT_MP" bs=1 count=64k seek=$new_len conv=notrunc 2>&1 \
     | _filter_testdir | _filter_imgfmt
 
 new_len=$(get_proto_len "$EXT_MP" "$TEST_IMG")
-- 
2.53.0


