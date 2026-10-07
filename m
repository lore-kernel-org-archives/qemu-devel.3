Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01EECA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUb0-0002s0-Nq; Wed, 07 Oct 2026 12:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUax-0002rZ-Pg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUaw-0006Hp-IS
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XW+MRNLXXL2SMptMVlcFiaTCmriMyYA6BjIkOEQuok=;
 b=G4wjAvgrPdMHENAFtlR3CGkld36WgZQ03+/1cxST8eIRIuV5lsBQzkQu6PzQA0yEUTdC9E
 wEStjht+o0dM8I0v7pHsELPbdEyoHT5m56wSmEWq2XdPmtTQ/jLHy25ifEtHsquX+1pdU4
 FdARKJJMOuq02MqHsYGA/EmHNs/yc9g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-AzmE0FRpPVS3VIG9_5_joA-1; Wed,
 07 Oct 2026 12:34:16 -0400
X-MC-Unique: AzmE0FRpPVS3VIG9_5_joA-1
X-Mimecast-MFC-AGG-ID: AzmE0FRpPVS3VIG9_5_joA_1791390855
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 433CF1809C87; Wed,  7 Oct 2026 16:34:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B113A1956087; Wed,  7 Oct 2026 16:34:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/21] block-common: fix BDRV_WANT_PRECISE duplicating
 BDRV_WANT_OFFSET_VALID
Date: Wed,  7 Oct 2026 18:32:42 +0200
Message-ID: <20261007163302.332250-2-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

Should OR in BDRV_WANT_ALLOCATED instead.

Actually there is not problem within the code right now as the value is
used as enum rather than flags but that is for now. Let us stay on the
safe side.

Fixes: c33159dec790 ("block: Expand block status mode from bool to flags")
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260724161158.445561-1-den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 895ea175413..3932ff86156 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -351,7 +351,7 @@ typedef enum {
 #define BDRV_WANT_OFFSET_VALID  BDRV_BLOCK_OFFSET_VALID
 #define BDRV_WANT_ALLOCATED     BDRV_BLOCK_ALLOCATED
 #define BDRV_WANT_PRECISE       (BDRV_WANT_ZERO | BDRV_WANT_OFFSET_VALID | \
-                                 BDRV_WANT_OFFSET_VALID)
+                                 BDRV_WANT_ALLOCATED)
 
 typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
-- 
2.56.0


