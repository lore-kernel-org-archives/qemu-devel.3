Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE0CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuCo-00037r-7p; Tue, 12 May 2026 16:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBj-0002Ng-PH; Tue, 12 May 2026 16:58:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBf-0004s4-2N; Tue, 12 May 2026 16:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=YzvE8O4x9zZLxo+Ep6+0WXIyCOVdcNes7Y0xXI9gjLo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nKCa6AKlO8iyE9VS4iXZUsu2XzRblD2uDL1xEGf6mmbs8FQ3xfoaluVh0nzAmnhZc
 n6Mqe9Wm9z3u5UK3B/CjpJv3qhSH4jvhfsLSYPbvQfvpT5L+gYqokDQxNwzY6zDEpt
 6TnjXIMP6vCtYJ+Ck3cIgmRkmBTaKY0vwsBZHyYy40+DPR0DEWZ/em+MXBcPEuRnf6
 LG5WzYRRKFhBq11GGliUSqEmzX7WShhod0MzhovhBZwIaZty20bofKnsyfEokxsvWU
 wBWryylq9WLaqXj7/M0naXJqwjtyvnfgY7AFkZmujjgw86la46N7LmZQMcuF237100
 /8j507UqdAq5g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 065D61AA2F6;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 115593ABC67;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 042/107] scsi: Don't consider LOGICAL UNIT NOT
 SUPPORTED guest recoverable
Date: Tue, 12 May 2026 23:53:29 +0300
Message-ID: <20260512205437.360850-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

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
Message-ID: <20260330121635.49205-1-kwolf@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ccc613f96c66eb5401185ff6eeba18143892055d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scsi/utils.c b/scsi/utils.c
index 357b036671..7533b25af1 100644
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
2.47.3


