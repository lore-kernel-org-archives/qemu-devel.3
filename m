Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85ED10D14AA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BYY-0005YJ-0j; Mon, 30 Mar 2026 08:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7BYS-0005Xh-Bh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7BYQ-00035y-0P
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774873028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=syiQnXmUDO8mTtl92IiL8BRAtPHudIf55Ubl5damwKQ=;
 b=ZsMOSfQwYtHwS4CX2Dtd30YRz7zGUjc7BoiXe8/pqb9QhsrYbNYzqXpBbO0/Z/UnECofOt
 Y2LXtHePtgvGAHEeytIUCokBMBMX9z8aI1KUY71m0TZSFlSkMzWc0LSeIHqBXzhfkW5fW7
 L8gqiXVtuch0S2M+qI2Ywar/WkK28Co=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-Cp7D63oXME-YYkuSFTwkdQ-1; Mon,
 30 Mar 2026 08:17:03 -0400
X-MC-Unique: Cp7D63oXME-YYkuSFTwkdQ-1
X-Mimecast-MFC-AGG-ID: Cp7D63oXME-YYkuSFTwkdQ_1774873022
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BC66195608E; Mon, 30 Mar 2026 12:17:02 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.36.248])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D4DB180075B; Mon, 30 Mar 2026 12:16:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
 gveitmic@redhat.com, bmarzins@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org
Subject: [PATCH for-11.0] scsi: Don't consider LOGICAL UNIT NOT SUPPORTED
 guest recoverable
Date: Mon, 30 Mar 2026 14:16:35 +0200
Message-ID: <20260330121635.49205-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

When commit bdf9613b introduced scsi_sense_buf_is_guest_recoverable(),
it included LOGICAL UNIT NOT SUPPORTED in the list of guest recoverable
sense codes. It doesn't really explain how the codes to be in the list
were selected.

As the LUN doesn't come from the guest, but from the block backend
(usually the SCSI device on the host that was opened with host_device,
but it could also be the iscsi block driver), there is really no way the
guest could influence this.

It seems that on some storage arrays, LOGICAL UNIT NOT SUPPORTED can
happen during failover operations. When combined with multipath, the
request should be retried on another path instead of being reported to
the guest, which would offline the filesystem in response.

Simply returning false in scsi_sense_buf_is_guest_recoverable() will
enable the retry logic in file-posix, and will also make sure that if
the error persists, the configured error policy is respected so that the
VM can be stopped.

Buglink: https://redhat.atlassian.net/browse/RHEL-158212
Fixes: bdf9613b7f87 ('scsi: explicitly list guest-recoverable sense codes')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scsi/utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index 545956f4f95..daee90ecf0e 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -373,7 +373,6 @@ static bool scsi_sense_is_guest_recoverable(int key, int asc, int ascq)
     case 0x1a00: /* PARAMETER LIST LENGTH ERROR */
     case 0x2000: /* INVALID OPERATION CODE */
     case 0x2400: /* INVALID FIELD IN CDB */
-    case 0x2500: /* LOGICAL UNIT NOT SUPPORTED */
     case 0x2600: /* INVALID FIELD IN PARAMETER LIST */
 
     case 0x2104: /* UNALIGNED WRITE COMMAND */
-- 
2.53.0


