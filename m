Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E60109B47B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7adU-0003BC-Er; Tue, 31 Mar 2026 11:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adT-0003AS-K0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adR-0002XK-Cr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774969443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0w+FkwPEOE9/aTogVmMcduV786B/IV6iPoHRVRGznug=;
 b=PQ/QzSowe/+OL/+g7fdcPID2zz1fGxlpGqPBaGmdTgSIKirZrL2hSVScPK8wAsV3n7rh3V
 Xs4cdR0Fj5sPNVBuV3cOfP7gPtOpo1AlK2MvWIkDSbPg6BMiXjqlAGsE5Tg+4FJCksOmos
 nSgjSRGtKAU9pjJ9PPsA1EUYc0QnA84=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-WqoFMJCsMyG0fIcaYS17fw-1; Tue,
 31 Mar 2026 11:04:00 -0400
X-MC-Unique: WqoFMJCsMyG0fIcaYS17fw-1
X-Mimecast-MFC-AGG-ID: WqoFMJCsMyG0fIcaYS17fw_1774969439
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C3FC18005AF; Tue, 31 Mar 2026 15:03:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.50.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 192D71954102; Tue, 31 Mar 2026 15:03:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 1/6] ide: Fix potential assertion failure on VM stop for PIO
 read error
Date: Tue, 31 Mar 2026 17:03:47 +0200
Message-ID: <20260331150352.256332-2-kwolf@redhat.com>
In-Reply-To: <20260331150352.256332-1-kwolf@redhat.com>
References: <20260331150352.256332-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

ide_sector_read() as well as its callers neglect to call ide_set_retry()
before starting I/O. If the I/O fails, this means that the retry
information is stale. In particular, ide_handle_rw_error() has an
assertion that s->bus->retry_unit == s->unit, which can fail if either
there was no previous request or it came from another device on the bus.
If the assertion weren't there, a wrong request would be retried after
resuming the VM.

Fix this by adding a ide_set_retry() call to ide_sector_read().

This affects only reads because ide_transfer_start() does call
ide_set_retry(). For writes, the data transfer comes first and the I/O
is only started when the data has been read into s->io_buffer, so by
that time, ide_set_retry() has been called. For reads, however, the I/O
comes first and only then the data is transferred to the guest, so the
call in ide_transfer_start() is too late.

Buglink: https://redhat.atlassian.net/browse/RHEL-153537
Reported-by: Tingting Mao <timao@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260326165124.138593-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/ide/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d6719dbf31d..7a15d6cac9b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -799,6 +799,7 @@ static void ide_sector_read(IDEState *s)
     s->error = 0; /* not needed by IDE spec, but needed by Windows */
     sector_num = ide_get_sector(s);
     n = s->nsector;
+    ide_set_retry(s);
 
     if (n == 0) {
         ide_transfer_stop(s);
-- 
2.53.0


