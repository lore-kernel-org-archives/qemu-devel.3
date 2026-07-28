Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4A0C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wollC-0007xk-Dd; Tue, 28 Jul 2026 13:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolku-0007qT-4G
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkr-0005xv-Ra
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDZQbofqv5m60JFMRA/EoBTzbN7uk/fXGJCKGWn9UEQ=;
 b=c9AVrfDIToJSGh87bBjJojcgucMXzPBytSPA4wCgF424NaxZsYQ1jWB+5N7CrEoHivA9wB
 2kIwE5ELtk5zNiIIapb1TCEG4fvYIRjbIXBXiZVh8g1lcM/vyymSv6+wYe21qVqp2j9UCi
 P1eabAxl+qBVhgjgZz6xcJ5Z5prPly0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-IJ8sohpPO1eSN6XC5Xytmw-1; Tue,
 28 Jul 2026 13:38:09 -0400
X-MC-Unique: IJ8sohpPO1eSN6XC5Xytmw-1
X-Mimecast-MFC-AGG-ID: IJ8sohpPO1eSN6XC5Xytmw_1785260288
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1B0B195609E; Tue, 28 Jul 2026 17:38:08 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D91A19560AB; Tue, 28 Jul 2026 17:38:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/17] block/export/fuse: fix regression with O_TRUNC when
 export is not growable
Date: Tue, 28 Jul 2026 19:37:35 +0200
Message-ID: <20260728173739.352078-14-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Before commit a94a1d7699 ("fuse: Manually process requests (without
libfuse)"), the O_TRUNC flag when open()-ing an export would be
ignored. This is because libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, so the
kernel lets user space handle the O_TRUNC flag, which is ignored by
the fuse code for export. After the commit, FUSE_CAP_ATOMIC_O_TRUNC is
not set anymore, so the O_TRUNC flag is handled by the kernel, which
executes a truncate.

For blockdev-based exports, this causes a regression, because opening
with O_TRUNC would previously work, but results in an ENOTSUP after
commit a94a1d7699. For file-based exports, the fact that truncate is
executed can be considered an improvement in general. However, in
combination with growable=off, this still results in a practical
regression in combination with virt-fw-vars, which opens its output
file with O_TRUNC and previously worked with a file-based export with
growable=off. After commit a94a1d7699, the file is truncated upon open
and then cannot grow, meaning virt-fw-vars won't be able to write the
output.

To fix these regressions, while keeping the improved behavior for
file-based exports with growable=on, set the FUSE_CAP_ATOMIC_O_TRUNC
flag again if growable=off.

Cc: qemu-stable@nongnu.org
Fixes: a94a1d7699 ("fuse: Manually process requests (without libfuse)")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260702132256.661429-2-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c0e8dfb6430..9ae22a2e003 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -859,6 +859,18 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
     uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
     uint32_t flags2 = 0;
 
+    if (!exp->growable) {
+        /*
+         * Back when libfuse was used, it would always set this flag and thus
+         * the kernel did not execute a truncate itself and passed along O_TRUNC
+         * to user space. Continue setting the flag for backwards compatibility
+         * when the export is not growable to avoid issues with O_TRUNC, i.e.
+         * blockdev-based exports running into ENOTSUP and file-based exports
+         * with growable=off to be truncated and then stuck with size 0.
+         */
+        supported_flags = FUSE_ATOMIC_O_TRUNC;
+    }
+
     if (in->major != 7) {
         error_report("FUSE major version mismatch: We have 7, but kernel has %"
                      PRIu32, in->major);
-- 
2.55.0


