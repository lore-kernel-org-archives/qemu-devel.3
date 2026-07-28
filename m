Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE9CC54F55
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolks-0007i0-AW; Tue, 28 Jul 2026 13:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolke-0007XB-C4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkc-0005vJ-No
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RVhm+ytOQchRTjwtS8vfC4qyEA3Ed976t0ttQMGsEo=;
 b=T8PVREKfdxcEgMWsHfcqjA05Gx3Tw1orZtW6NUckOKbNMQZkN2bOEvxEwnBnRyMBI2Ielb
 I6W3oHBQrhJjeeptNz21fREqKw1xGOuLYau4fpXXZ3wy/N43f2SBWOM24eiaP7rHJSJEPh
 v5otZAIoLFB4iOK30my7RKHw7DF0W4I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-8Obj8a82NfmgtCcz12h_5A-1; Tue,
 28 Jul 2026 13:37:56 -0400
X-MC-Unique: 8Obj8a82NfmgtCcz12h_5A-1
X-Mimecast-MFC-AGG-ID: 8Obj8a82NfmgtCcz12h_5A_1785260275
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6E6719560B5; Tue, 28 Jul 2026 17:37:55 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66F8F19560AB; Tue, 28 Jul 2026 17:37:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/17] dmg: refuse to open files with no chunks
Date: Tue, 28 Jul 2026 19:37:28 +0200
Message-ID: <20260728173739.352078-7-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The dmg block driver expects the disk image file to contain at least one
chunk. Refuse to open such files. This ensures that dmg block driver
state always has non-NULL s->sectors[] and related fields.

Note that the previous commit fixed the only known way to trigger a
crash. This patch is just for defense - let's avoid opening the file and
having NULL pointers in dmg block driver state.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4021
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260723144519.364701-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/dmg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/dmg.c b/block/dmg.c
index e325127d144..6f8120e0338 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -559,6 +559,12 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    /* There must be at least one chunk */
+    if (s->n_chunks == 0) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
     /* initialize zlib engine */
     s->compressed_chunk = qemu_try_blockalign(bs->file->bs,
                                               ds.max_compressed_size + 1);
-- 
2.55.0


