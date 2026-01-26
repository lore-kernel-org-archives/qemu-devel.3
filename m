Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12120D74EFD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkInm-0001qB-S0; Mon, 26 Jan 2026 04:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkInh-0001lK-V1
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkIne-0005te-Um
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769419342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYgRz7jr5GNyxrbwjf9WtD4Etbl+LMoXUeu3rrxpWiM=;
 b=a/xFFmqt+ZHnNX06dYpAVB3211E+cjfQgKSZfy5cuknQJZHTw3SPzJe7WqJ6lkN9z+PVWy
 bDWzIsyfhlAVwNSEm+JeZhToD/7lA/smClXElYr13Nb9zpjUSt2ljF2ZVm/M9j3SCZpSLL
 qcBAv4FFANvzblJFeo7uyNv+dEZJs3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-OSiFwXFIOhK8MERg8xddGA-1; Mon,
 26 Jan 2026 04:22:20 -0500
X-MC-Unique: OSiFwXFIOhK8MERg8xddGA-1
X-Mimecast-MFC-AGG-ID: OSiFwXFIOhK8MERg8xddGA_1769419339
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEF4319775A5; Mon, 26 Jan 2026 09:22:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB1BB1956095; Mon, 26 Jan 2026 09:22:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/7] vfio/migration: Fix page size calculation
Date: Mon, 26 Jan 2026 10:22:06 +0100
Message-ID: <20260126092212.503162-2-clg@redhat.com>
In-Reply-To: <20260126092212.503162-1-clg@redhat.com>
References: <20260126092212.503162-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Coverity detected an issue of left shifting int by more than 31 bits leading
to undefined behavior.

In practice bcontainer->dirty_pgsizes always have some common page sizes
when dirty tracking is supported.

Resolves: Coverity CID 1644186
Resolves: Coverity CID 1644187
Resolves: Coverity CID 1644188
Fixes: 46c763311419 ("vfio/migration: Add migration blocker if VM memory is too large to cause unmap_bitmap failure").
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260116060315.65723-1-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index f857dc25ed4d0f824bdabc168228a5e925ac7dbe..b4695030c7295f318faf1d12ac48ba951aa943c7 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1173,7 +1173,7 @@ static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
      * can also switch to use IOMMUFD backend if there is a need to migrate
      * large VM.
      */
-    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
+    page_size = 1ULL << ctz64(bcontainer->dirty_pgsizes);
     max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
 
     return current_machine->ram_size > max_size;
-- 
2.52.0


