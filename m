Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E53C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm3y7-0004me-Ue; Tue, 21 Jul 2026 02:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm3xs-0004jp-Hu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm3xr-0003Ke-6m
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784615306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kwq8t8ucQthcGT7mCTrNEZ5MEpukre4jTDvwWTUlGuo=;
 b=QFKqYpbASoRScoDEhuP6X4rQZ3f7FN7GJ6nAFXbVVJ5uJcgC4sFCyM53wxuvh0iKOAXLzS
 dRErOtwaEW2V0epovgvjaSv5IwY4cseTaM+hW69Dh0gYNI/hV6YcRqlLs8g7FU+fkePS1b
 S5pgXBIyzYuiSta36NVvq5xw1uAUg5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-1LMYgqW4NdOH5cGbDNWtOg-1; Tue,
 21 Jul 2026 02:27:51 -0400
X-MC-Unique: 1LMYgqW4NdOH5cGbDNWtOg-1
X-Mimecast-MFC-AGG-ID: 1LMYgqW4NdOH5cGbDNWtOg_1784615271
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A67F8180895B; Tue, 21 Jul 2026 06:27:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D791A180034F; Tue, 21 Jul 2026 06:27:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] vfio/listener: Remove unnecessary linux/kvm.h include
Date: Tue, 21 Jul 2026 08:27:45 +0200
Message-ID: <20260721062745.3793066-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Since commit d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM"),
the linux/kvm.h include is unconditional. This breaks the build on
targets that lack asm/kvm.h such as sparc and sparc64:

  In file included from ../hw/vfio/listener.c:23:
  linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory

This include is not needed in listener.c which only uses kvm_enabled()
and kvm_get_max_memslots(), both are declared in "system/kvm.h".
Remove it.

Fixes: d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM")
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>"
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..008f488a3e7d4ca2ec9e1780b496371b0f447653 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#include <linux/kvm.h>
 #include <linux/vfio.h>
 
 #include "exec/target_page.h"
-- 
2.55.0


