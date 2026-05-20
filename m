Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E704CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjgK-0006NF-PQ; Wed, 20 May 2026 12:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjg5-00063e-W1
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjg0-000061-NJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ihs0XP3I6CFuopnX9tMtVK9NmX8qMGsW0y0Q3uEM+HI=;
 b=WC6ackxi/lX2a70gxdl0E6EjuqSxV2OyIRO/uw+F0vVDXCs6suKQRcxk9qK9O9R5oNcHKy
 DMvVIso10o2qRK0WppBDTkvvjEdrQFr3nPUHpI1kZ/4ArrBd2jkDY90dEGgORq4s3UDvGM
 wejN8mbSknkC7vrJvYWV0B5JPNaKPBg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-jzJnd-arMY6U9piW7p2W9A-1; Wed,
 20 May 2026 12:21:40 -0400
X-MC-Unique: jzJnd-arMY6U9piW7p2W9A-1
X-Mimecast-MFC-AGG-ID: jzJnd-arMY6U9piW7p2W9A_1779294100
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 187931956075
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 16:21:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.34.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E8F719560A3; Wed, 20 May 2026 16:21:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 09/11] update-linux-headers: Inject VIRTIO_RING_NO_LEGACY in
 virtio_ring.h
Date: Wed, 20 May 2026 18:21:13 +0200
Message-ID: <20260520162115.1613601-10-clg@redhat.com>
In-Reply-To: <20260520162115.1613601-1-clg@redhat.com>
References: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The kernel commit 3c4629b68dbe ("virtio: uapi: avoid usage of libc
types") changed the virtio_ring.h header and this breaks the build on
Windows which requires the uintptr_t type to cast from pointer to
integer.

Inject '#define VIRTIO_RING_NO_LEGACY' at the top of the synced header
via the update script after the include guard. This discards the code
section incompatible with Windows.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260511111913.3327672-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 scripts/update-linux-headers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 386d7a38e7af939291d20d34ced17af823771bf7..0dea7c9551d2eb1e84aef90e82be92a872318706 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -103,6 +103,7 @@ cp_portable() {
         -e 's/__kernel_ulong_t/unsigned long/' \
         -e 's/struct ethhdr/struct eth_header/' \
         -e '/\#define _LINUX_ETHTOOL_H/a \\n\#include "net/eth.h"' \
+        -e '/\#define _LINUX_VIRTIO_RING_H/a \\n\#define VIRTIO_RING_NO_LEGACY' \
         "$f" > "$to/$header";
 }
 
-- 
2.54.0


