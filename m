Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D048CC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 00:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u87Ll-00070T-6D; Thu, 24 Apr 2025 20:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87Lh-0006zV-Kb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87Lf-0000nh-8J
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745542522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i16aZxxw0o1rdljUx+f96coAB3U70GB6E7l1CM3DuE8=;
 b=ALJ7fQLh8JowBA1ed9fM3zD4hEyF8pp7J9SZ+hh3Z+neIJDP4usdXZe7FzfAS9hPT4ffYA
 GsFL97V8FBwF5DuN9w6YJJPZbyzkoZC+sO4MR8V/ezxounxAcG8WePR9K4F9nfxS/BnFiC
 PJJf5wOFHLv9RbBbds1a+9ZHn9mLHAU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-tEibCA-cPOWMISF5UEgsXA-1; Thu,
 24 Apr 2025 20:55:18 -0400
X-MC-Unique: tEibCA-cPOWMISF5UEgsXA-1
X-Mimecast-MFC-AGG-ID: tEibCA-cPOWMISF5UEgsXA_1745542516
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92C3C1800446; Fri, 25 Apr 2025 00:55:16 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 472F61800374; Fri, 25 Apr 2025 00:55:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, stefanha@redhat.com,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 09/11] iotests/common.rc: add disk_usage function
Date: Thu, 24 Apr 2025 19:52:09 -0500
Message-ID: <20250425005439.2252467-22-eblake@redhat.com>
In-Reply-To: <20250425005439.2252467-13-eblake@redhat.com>
References: <20250425005439.2252467-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Move the definition from iotests/250 to common.rc.  This is used to
detect real disk usage of sparse files.  In particular, we want to use
it for checking subclusters-based discards.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-ID: <20240913163942.423050-6-andrey.drobyshev@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/common.rc | 6 ++++++
 tests/qemu-iotests/250       | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 95c12577dd4..237f746af88 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -140,6 +140,12 @@ _optstr_add()
     fi
 }

+# report real disk usage for sparse files
+disk_usage()
+{
+    du --block-size=1 "$1" | awk '{print $1}'
+}
+
 # Set the variables to the empty string to turn Valgrind off
 # for specific processes, e.g.
 # $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015
diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index af48f83abac..c0a0dbc0ff1 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -52,11 +52,6 @@ _unsupported_imgopts data_file
 # bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
 # anyway.

-disk_usage()
-{
-    du --block-size=1 $1 | awk '{print $1}'
-}
-
 size=2100M

 _make_test_img -o "cluster_size=1M,preallocation=metadata" $size
-- 
2.49.0


