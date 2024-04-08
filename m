Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3B2CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrSF-0000tj-O1; Mon, 08 Apr 2024 12:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rtrS2-0000Wb-FI
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rtrRw-0003mc-GU
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712592143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xtbY3RjUKfGcENjQQKZSw8bidoLgAm76/S9RsOXP+Vg=;
 b=JTqr3jgGqNIG42f8y3fagNgR+dv7MmrOVlx3eK+z40BBDp6xe/k6l79tFQUvYqGQ55XEYs
 f/ZV2EDs4SkNqNNZZvc18MwzuQ9KMCNyiSZINlMgYD8Qmapmyhts17RZ/JIpJfe5/XIP22
 V667/yvYQRgtruabh5jbts45y4PQNiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-5px05-49NlOotZackQDtow-1; Mon, 08 Apr 2024 12:02:19 -0400
X-MC-Unique: 5px05-49NlOotZackQDtow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8876490ACCA;
 Mon,  8 Apr 2024 16:02:19 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEF69492BD4;
 Mon,  8 Apr 2024 16:02:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Zhu Yangyang <zhuyangyang14@huawei.com>
Subject: [PATCH v5 for-9.0? 0/2] Fix NBD TLS poll in coroutine
Date: Mon,  8 Apr 2024 11:00:42 -0500
Message-ID: <20240408160214.1200629-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

v4 was here:
https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00624.html

Since then: add some asserts [Vladimir], add second patch with more
coroutine_fn annotations [Vladimir]

Eric Blake (1):
  nbd/server: Mark negotiation functions as coroutine_fn

Zhu Yangyang (1):
  nbd/server: do not poll within a coroutine context

 nbd/nbd-internal.h |  10 ----
 nbd/client.c       |  28 ++++++++--
 nbd/common.c       |  11 ----
 nbd/server.c       | 128 ++++++++++++++++++++++++++++-----------------
 4 files changed, 105 insertions(+), 72 deletions(-)

-- 
2.44.0


