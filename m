Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D367C88E45
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 04:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5FkZ-0007Yp-Sd; Sat, 12 Sep 2026 00:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5FkY-0007Xp-8t
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5FkW-0000lw-2A
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 00:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789188838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7h2NBRW4582MUQn5zVSEPuE3/mdIPQRLvHDQ/MueTbQ=;
 b=eSvbr9qumlV/fIUOCKaDp+bX3Oz6j96EzFtxSuTLsrgGcTZssjEmfHTjDjxTjyZC71dK+Z
 fUxEcvBlx3rKxPc91BAaOkMR+w1W7yfNCT4lGPSkkq5X6GNsRXcFigrqFzQ9aGMqiL+S7t
 s3MFFmK3oFNfSWmeZVq/U5dQD40V8mc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-r1ycrD0rMpGFMVFEb8Cchg-1; Sat,
 12 Sep 2026 00:53:55 -0400
X-MC-Unique: r1ycrD0rMpGFMVFEb8Cchg-1
X-Mimecast-MFC-AGG-ID: r1ycrD0rMpGFMVFEb8Cchg_1789188834
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 658581955BC5; Sat, 12 Sep 2026 04:53:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94F981800352; Sat, 12 Sep 2026 04:53:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10EDE21E6A04; Sat, 12 Sep 2026 06:53:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com
Subject: [PATCH] qapi/migration: Make migration parameter @local consistently
 unstable
Date: Sat, 12 Sep 2026 06:53:50 +0200
Message-ID: <20260912045350.2139416-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

@local is unstable in MigrationParameters, but not in
MigrationParameter.  Fix the latter.

Fixes: c9affb8e9b (qapi: add local migration parameter)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index f7628b55e9..9a1cc7c4e5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -804,8 +804,8 @@
 #
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @local, @x-checkpoint-delay, @x-rdma-chunk-size,
+#     and @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
 ##
@@ -831,7 +831,7 @@
            'direct-io',
            { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
            'cpr-exec-command',
-           'local'] }
+           { 'name': 'local', 'features': [ 'unstable' ] } ] }
 
 ##
 # @migrate-set-parameters:
-- 
2.55.0


