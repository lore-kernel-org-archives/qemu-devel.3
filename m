Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE401D5B840
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 15:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVABI-0001FB-Q8; Mon, 15 Dec 2025 10:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vVAAl-000161-MJ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vVAAf-0004l7-UZ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765811250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t/kCcBase3Tz+aCgmKAsDzFcba538laeV3krP3ohidU=;
 b=LV+oXhZsy2yozKRbcxSzEj29SifeqUcvybNRzyc3eZU9uzlS3tZ2ASsj1ou7JJ/Ehp+vQE
 U/jeUE8J33Viy4ZTzUyn2pZhjzDCYwRMQUevy0zdN0/5Gs4vhwRGG7vbuwf2HgRz6HXA5U
 To0X8GaZ47g7tZkTxR+TcWVBBUAw+Og=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-2jCcwGupNYGAf1jR1Kp30A-1; Mon,
 15 Dec 2025 10:07:28 -0500
X-MC-Unique: 2jCcwGupNYGAf1jR1Kp30A-1
X-Mimecast-MFC-AGG-ID: 2jCcwGupNYGAf1jR1Kp30A_1765811247
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 022FD180060D; Mon, 15 Dec 2025 15:07:27 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.188])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6359230001A2; Mon, 15 Dec 2025 15:07:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, stefanha@redhat.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] block: Fix BDS use after free during shutdown
Date: Mon, 15 Dec 2025 16:07:14 +0100
Message-ID: <20251215150714.130214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

During shutdown, blockdev_close_all_bdrv_states() drops any block node
references that are still owned by the monitor (i.e. the user). However,
in doing so, it forgot to also remove the node from monitor_bdrv_states
(which qmp_blockdev_del() correctly does), which means that later calls
of bdrv_first()/bdrv_next() will still return the (now stale) pointer to
the node.

Usually there is no such call after this point, but in some cases it can
happen. In the reported case, there was an ongoing migration, and the
migration thread wasn't shut down yet: migration_shutdown() called by
qemu_cleanup() doesn't actually wait for the migration to be shut down,
but may just move it to MIGRATION_STATUS_CANCELLING. The next time
migration_iteration_finish() runs, it sees the status and tries to
re-activate all block devices that migration may have previously
inactivated. This is where bdrv_first()/bdrv_next() get called and the
access to the already freed node happens.

It is debatable if migration_shutdown() should really return before
migration has settled, but leaving a dangling pointer in the list of
monitor-owned block nodes is clearly a bug either way and fixing it
solves the immediate problem, so fix it.

Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/blockdev.c b/blockdev.c
index dbd1d4d3e80..6e86c6262f9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -686,6 +686,7 @@ void blockdev_close_all_bdrv_states(void)
 
     GLOBAL_STATE_CODE();
     QTAILQ_FOREACH_SAFE(bs, &monitor_bdrv_states, monitor_list, next_bs) {
+        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
         bdrv_unref(bs);
     }
 }
-- 
2.52.0


