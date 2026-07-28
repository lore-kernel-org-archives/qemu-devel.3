Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3B0C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wollt-0000uy-2Q; Tue, 28 Jul 2026 13:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkw-0007te-Sc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkv-0005zi-6j
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T26i0yXSZnxgT5kd6VS+hSgVR9pBVR7ojkg37UQEB1A=;
 b=glqjZLLg/gkmJz44rG5c3yJEPSjE7QjCc/VgVRKgUOzZg01g8bC61uOg9J0C7xDdMR9Fuv
 exnHhEJ8QfbYipOd4hObXCE/TvdFL6cm7iQ4SK2u05mQ0ntaSjujPoSsKgCZEHNoUvk9zM
 mqtv1tY72YggJgDyTy3k09t5zu4BEF0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-6pwk8H7EOaK28YE25PUVZg-1; Tue,
 28 Jul 2026 13:38:13 -0400
X-MC-Unique: 6pwk8H7EOaK28YE25PUVZg-1
X-Mimecast-MFC-AGG-ID: 6pwk8H7EOaK28YE25PUVZg_1785260292
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 459E5195604D; Tue, 28 Jul 2026 17:38:12 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E248B19560AB; Tue, 28 Jul 2026 17:38:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/17] hw/block/fdc: select the drive named by the READ ID
 command
Date: Tue, 28 Jul 2026 19:37:37 +0200
Message-ID: <20260728173739.352078-16-kwolf@redhat.com>
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

From: Christian Quante <christian@quante.one>

Every other command handler begins by latching the drive from the command
byte:

    SET_CUR_DRV(fdctrl, fdctrl->fifo[1] & FD_DOR_SELMASK);

fdctrl_handle_readid() does not, so it works on whichever drive happened to
be selected last.  A guest that issues READ ID for a drive other than the
one currently selected gets an answer about the wrong one.

It has gone unnoticed because a driver normally writes the DOR to spin up
the motor first, and that write selects the drive as a side effect.  The
controller does not require it, though, and the command carries the drive
number for a reason.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Christian Quante <christian@quante.one>
Message-ID: <20260714164031.60551-2-christian@quante.one>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/fdc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2c1681b7d0a..9b2409cfa4c 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1936,7 +1936,10 @@ static void fdctrl_handle_save(FDCtrl *fdctrl, int direction)
 
 static void fdctrl_handle_readid(FDCtrl *fdctrl, int direction)
 {
-    FDrive *cur_drv = get_cur_drv(fdctrl);
+    FDrive *cur_drv;
+
+    SET_CUR_DRV(fdctrl, fdctrl->fifo[1] & FD_DOR_SELMASK);
+    cur_drv = get_cur_drv(fdctrl);
 
     cur_drv->head = (fdctrl->fifo[1] >> 2) & 1;
     timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-- 
2.55.0


