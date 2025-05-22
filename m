Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DDDC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 21:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIDFq-0003o1-6H; Thu, 22 May 2025 17:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIDFn-0003m0-Nb
 for qemu-devel@nongnu.org; Thu, 22 May 2025 17:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIDFl-0002Tq-Tp
 for qemu-devel@nongnu.org; Thu, 22 May 2025 17:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747948500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vqfo21sayTMPUfyXWQIXcwaEp+Rt4NrWMpr55qZYO/o=;
 b=ciVBW6mE4O1SVKPiZPfD3gs1ZqVtG525KX6rsT+U/+ysx0tUtulqlEzX1GhhJv0qx43Hno
 FMt+CNckIFveGydoogIR9xBDSK3V+t6Qql3WFExSHBkBPYQ1eP8Jt2JQuoFFoimrY1O9I4
 F/wR9Q2xI9S3Sk5ZcE3R4QtsxQrNSrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-UORwyq4PO4ahWB5dSJC2lQ-1; Thu,
 22 May 2025 17:14:57 -0400
X-MC-Unique: UORwyq4PO4ahWB5dSJC2lQ-1
X-Mimecast-MFC-AGG-ID: UORwyq4PO4ahWB5dSJC2lQ_1747948496
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6208D1956094; Thu, 22 May 2025 21:14:56 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F63F1944A8B; Thu, 22 May 2025 21:14:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] iotests: Improve mirror-sparse on various filesystems
Date: Thu, 22 May 2025 16:14:49 -0500
Message-ID: <20250522211451.2301791-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fiona reported that an ext4 filesystem on top of LVM can sometimes
report over-allocation to du (based on the hueristics the filesystem
is making while observing the contents being mirrored); even though
the contents and actual size matched, about 50% of the time the size
reported by disk_usage was too large by 4k, failing the test.

Similarly, on ZFS where a file is created with preallocation=full, du
does not see the full allocation until things have had time to settle;
adding a sync call reduces the chance of catching that async window:

| [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> qemu-img create my.raw 20M -f
|w -o preallocation=full
| Formatting 'my.raw', fmt=raw size=20971520 preallocation=full
| [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
| 512 my.raw
| [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
| 20980224    my.raw

Fiona also reported that on a compressed ZFS, the filesystem can end
up reporting smaller disk_usage if it re-compresses a file, despite a
fully-allocating mirror - but since I don't have a compressed ZFS
handy for reproducing that test, that may remain a sporadic problem
for another day.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Fixes: c0ddcb2c ("tests: Add iotest mirror-sparse for recent patches")
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.rc           | 2 ++
 tests/qemu-iotests/tests/mirror-sparse | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 237f746af88..c3fc0bcf02a 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -143,6 +143,8 @@ _optstr_add()
 # report real disk usage for sparse files
 disk_usage()
 {
+    # ZFS has lazy allocation; sync the file first for best results
+    sync "$1"
     du --block-size=1 "$1" | awk '{print $1}'
 }

diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-iotests/tests/mirror-sparse
index 8c52a4e2448..338d6cfbb35 100755
--- a/tests/qemu-iotests/tests/mirror-sparse
+++ b/tests/qemu-iotests/tests/mirror-sparse
@@ -96,10 +96,12 @@ _send_qemu_cmd $h1 '{"execute": "blockdev-del", "arguments":
                 {"node-name": "dst"}}' 'return' \
                   | _filter_block_job_offset | _filter_block_job_len
 $QEMU_IMG compare -U -f $IMGFMT -F raw $TEST_IMG.base $TEST_IMG
+# Some filesystems can fudge allocations for various reasons; rather
+# than expecting precise 2M and 20M images, it is better to allow for slop.
 result=$(disk_usage $TEST_IMG)
 if test $result -lt $((3*1024*1024)); then
     actual=sparse
-elif test $result = $((20*1024*1024)); then
+elif test $result -gt $((19*1024*1024)); then
     actual=full
 else
     actual=unknown
-- 
2.49.0


