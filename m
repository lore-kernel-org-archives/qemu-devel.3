Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F0C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 22:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKlKq-0005YI-NE; Thu, 29 May 2025 18:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKo-0005XG-H6
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKm-0002Zf-Ac
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748556163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=infoBmjAFnt00Pn9BDmXDmuyPlBkDoA5gGMWMip+CFA=;
 b=AhyAeQeM5jjmkf4KAVsu0+oTF/wz82SpNFO6dQmloFSy7tId2ym7eQ7Pe14aFY8zErbonm
 8Oar4mRw3+0/QnQRVTg7c1MNdNFK5XCyquklT0UNVgVMcQir5esNzv1kyx+UEK0KWPhsW4
 FuOCm++3y2QRM6PlWE7sw4evE8oUvDo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-OdhmHnFAPqy0NW1DxsURbw-1; Thu,
 29 May 2025 18:02:42 -0400
X-MC-Unique: OdhmHnFAPqy0NW1DxsURbw-1
X-Mimecast-MFC-AGG-ID: OdhmHnFAPqy0NW1DxsURbw_1748556161
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D02B61956094; Thu, 29 May 2025 22:02:40 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49CD119560A7; Thu, 29 May 2025 22:02:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 4/6] iotests: Use disk_usage in more places
Date: Thu, 29 May 2025 17:02:11 -0500
Message-ID: <20250529220228.1187563-12-eblake@redhat.com>
In-Reply-To: <20250529220228.1187563-8-eblake@redhat.com>
References: <20250529220228.1187563-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

Commit be9bac07 added a utility disk_usage function, but there are
a couple of other tests that could also use it.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250523163041.2548675-6-eblake@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/125 | 2 +-
 tests/qemu-iotests/308 | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 46279d6b382..708e7c5ba21 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15

 get_image_size_on_host()
 {
-    echo $(($(stat -c '%b * %B' "$TEST_IMG_FILE")))
+    disk_usage "$TEST_IMG_FILE"
 }

 # get standard environment and filters
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index ea81dc496a0..437a9014da5 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -290,7 +290,7 @@ echo '--- Try growing non-growable export ---'

 # Get the current size so we can write beyond the EOF
 orig_len=$(get_proto_len "$EXT_MP" "$TEST_IMG")
-orig_disk_usage=$(stat -c '%b' "$TEST_IMG")
+orig_disk_usage=$(disk_usage "$TEST_IMG")

 # Should fail (exports are non-growable by default)
 # (Note that qemu-io can never write beyond the EOF, so we have to use
@@ -312,7 +312,7 @@ else
     echo 'OK: Post-truncate image size is as expected'
 fi

-new_disk_usage=$(stat -c '%b' "$TEST_IMG")
+new_disk_usage=$(disk_usage "$TEST_IMG")
 if [ "$new_disk_usage" -gt "$orig_disk_usage" ]; then
     echo 'OK: Disk usage grew with fallocate'
 else
-- 
2.49.0


