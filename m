Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABACC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 21:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmgCQ-0003iG-OI; Mon, 24 Feb 2025 16:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmgCO-0003hN-Gx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 16:41:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmgCN-0000yc-2H
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 16:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740433268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MttmAEZLPlFAqt/EnQfSctKGSt2erueS3Qn/JgXIEGg=;
 b=ALz1fliVTsdTFympwxOmvwsrZ3PU4I5A7m6VieJGBjF2t1Qg/swAfbe12RTnEo+S4F3dXR
 GhMNSnoIA1cTKi/CvNnGxrN0nrFRaPD6Ny1kfof7SjcrZXAcdxkWOYVFy4wu3YTW3wUvOi
 1FnRBrhLFGQ4fXtOflGha/ytQQkR8MI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-0ygKkn-bNTOnbVZNO3kUyg-1; Mon,
 24 Feb 2025 16:41:06 -0500
X-MC-Unique: 0ygKkn-bNTOnbVZNO3kUyg-1
X-Mimecast-MFC-AGG-ID: 0ygKkn-bNTOnbVZNO3kUyg_1740433265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A068E19560B9; Mon, 24 Feb 2025 21:41:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E49D6180094B; Mon, 24 Feb 2025 21:41:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] iotests: Limit qsd-migrate to working formats
Date: Mon, 24 Feb 2025 22:40:58 +0100
Message-ID: <20250224214058.205889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

qsd-migrate is currently only working for raw, qcow2 and qed.
Other formats are failing, e.g. because they don't support migration.
Thus let's limit this test to the three usable formats now.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/tests/qsd-migrate | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
index de17562cb06..a4c6592420c 100755
--- a/tests/qemu-iotests/tests/qsd-migrate
+++ b/tests/qemu-iotests/tests/qsd-migrate
@@ -22,7 +22,7 @@ import iotests
 
 from iotests import filter_qemu_io, filter_qtest
 
-iotests.script_initialize(supported_fmts=['generic'],
+iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
                           supported_protocols=['file'],
                           supported_platforms=['linux'])
 
-- 
2.48.1


