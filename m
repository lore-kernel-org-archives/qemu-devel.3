Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AFAC54F32
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIVIa-0001Qi-AX; Fri, 23 May 2025 12:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVIP-0001OA-Oz
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVIN-0006XL-TK
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748017855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiRD1Rvo5qlgffSZ3bR6VrSUTKIKB+PJh+sKyKvmYj4=;
 b=JoPsf/gJvMD+AZntpr/U11OGhVwiMPodrMHEER26u1qP3ixbicpYs0YQcETnbdSonhKL+t
 PUWLpBBlXkmQmcJ5iYTspYCz0Xt4OkuCrYWoROgan9hRakfZOql9gaihu/Zv6GKhHj1ELD
 C9fmnz/+67TUCbVYiH5rmi+CmT1TqA0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-60n3V470Nfq7QS-vedKF5A-1; Fri,
 23 May 2025 12:30:52 -0400
X-MC-Unique: 60n3V470Nfq7QS-vedKF5A-1
X-Mimecast-MFC-AGG-ID: 60n3V470Nfq7QS-vedKF5A_1748017851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE58918004A7; Fri, 23 May 2025 16:30:50 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BE92195608F; Fri, 23 May 2025 16:30:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, f.ebner@proxmox.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 2/3] iotests: Improve mirror-sparse on ext4
Date: Fri, 23 May 2025 11:27:22 -0500
Message-ID: <20250523163041.2548675-7-eblake@redhat.com>
In-Reply-To: <20250523163041.2548675-5-eblake@redhat.com>
References: <20250523163041.2548675-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
reported by disk_usage was too large by 4k, failing the test.  In
auditing other iotests, this is a common problem we've had to deal
with.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Fixes: c0ddcb2c ("tests: Add iotest mirror-sparse for recent patches")
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>

---
v2: Drop sync for ZFS
---
 tests/qemu-iotests/tests/mirror-sparse | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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


