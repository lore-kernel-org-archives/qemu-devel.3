Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B37CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrJ-000875-Sp; Tue, 19 May 2026 13:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrH-00086G-VN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrG-0004IJ-Hk
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmZO1DnCQFJvIPMAXOKqvGPa8liadj2g4sH8wSYFG6o=;
 b=YTJXnQKQAxpdMnvU+DQLhS+WlLz/3zAvrxI/Ec1VGCm+MaKXVPnu8IHxKaOpctCQYg+U/R
 AUHBGBUlCeOyV3T0CyzR2S7gYFVd12jsoO0TLH2HaOKPw9uhiQSao6cuQRBL6kIaa6qxpD
 FfqE9XjejpCOaOYYZ8XcNqhEW6Bcn0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-bUshOFFXNkWollXftYJvpg-1; Tue,
 19 May 2026 13:03:52 -0400
X-MC-Unique: bUshOFFXNkWollXftYJvpg-1
X-Mimecast-MFC-AGG-ID: bUshOFFXNkWollXftYJvpg_1779210231
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D5181800343; Tue, 19 May 2026 17:03:51 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19DA61681; Tue, 19 May 2026 17:03:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/18] block: Add more defaults to DEFAULT_BLOCK_CONF
Date: Tue, 19 May 2026 19:03:11 +0200
Message-ID: <20260519170317.345032-13-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

discard_granularity was missing from this, which means that SCSI disks
created with -drive if=scsi would default to 0 (i.e. disabling discards)
instead of -1, which makes scsi-hd automatically pick a granularity and
is the default of the corresponding qdev property for -device scsi-hd.

This was broken in QEMU 9.0 with commit 3089637.

Also set other fields whose default isn't an obvious 0. These are not
actual bug fixes because ON_OFF_AUTO_AUTO in fact happens to be 0, but
it's better not to rely on the order of enums.

Cc: qemu-stable@nongnu.org
Fixes: 308963746169 ('scsi: Don't ignore most usb-storage properties')
Reported-by: Lexi Winter <ivy@FreeBSD.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260410152314.86412-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/block/block.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index e0a427039ee..df941df19f2 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -53,7 +53,12 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 
 #define DEFAULT_BLOCK_CONF (BlockConf) {                                \
     .bootindex = -1,                                                    \
+    .backend_defaults = ON_OFF_AUTO_AUTO,                               \
+    .discard_granularity = -1,                                          \
+    .wce = ON_OFF_AUTO_AUTO,                                            \
     .share_rw = false,                                                  \
+    .account_invalid = ON_OFF_AUTO_AUTO,                                \
+    .account_failed = ON_OFF_AUTO_AUTO,                                 \
     .rerror = BLOCKDEV_ON_ERROR_AUTO,                                   \
     .werror = BLOCKDEV_ON_ERROR_AUTO,                                   \
 }
-- 
2.54.0


