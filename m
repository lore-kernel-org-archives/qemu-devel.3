Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B759FD609D7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 11:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGG1T-0007li-DB; Wed, 27 Nov 2024 06:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGG1P-0007kQ-G4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGG1N-0001kC-FS
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732706147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oHENvK5q8dSKft7BX87XNj1KWsLEULxlB9iidhIHNTk=;
 b=iBmvxzj0SsxxTT7OPew1nPWJvvAWdPaptOV/Y5h6FMGgLbUxL/vtOl4nxN5kOYJFSEdu3t
 qU9sD+Q3DW/ccQ8E1jxw2RsPZe875GT5oO5ybnSP/Lcr2Xn1ELEXpg2MEG98obyPbBWb2a
 gciuR3cA62ZmFB38KQTG5CKRcIPYOi0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-m9ZNmz-YPeaTdMrMmFGC0g-1; Wed,
 27 Nov 2024 06:15:42 -0500
X-MC-Unique: m9ZNmz-YPeaTdMrMmFGC0g-1
X-Mimecast-MFC-AGG-ID: m9ZNmz-YPeaTdMrMmFGC0g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E329819560B0; Wed, 27 Nov 2024 11:15:40 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.158])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED8301956054; Wed, 27 Nov 2024 11:15:34 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com, chen.zhang@intel.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] migration: correct multifd receive thread name
Date: Wed, 27 Nov 2024 16:45:28 +0530
Message-ID: <20241127111528.167330-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Multifd receive threads run on the destination side.
Correct the thread name marco to indicate the same.

Fixes: e620b1e4770b ("migration: Put thread names together with macros")
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 0956e9274b..3857905c0e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -37,7 +37,7 @@
 #define  MIGRATION_THREAD_SRC_TLS           "mig/src/tls"
 
 #define  MIGRATION_THREAD_DST_COLO          "mig/dst/colo"
-#define  MIGRATION_THREAD_DST_MULTIFD       "mig/src/recv_%d"
+#define  MIGRATION_THREAD_DST_MULTIFD       "mig/dst/recv_%d"
 #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
-- 
2.47.0


