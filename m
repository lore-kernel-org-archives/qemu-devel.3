Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71895C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dJc-000824-Iw; Thu, 10 Sep 2026 07:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x4dJb-00081L-6X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x4dJZ-0001Vn-OC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789041096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PqSXf1rfOOWzmIC8guFB5ahiBpqOIpBETyOPVFJp8Tc=;
 b=LUaXUGOLrOVqp67c0AqaYEeJxCt43Jr4tGD/786bOVvS1HNCTZSMImOnS4BZTG32IPwR01
 nKq1NYvy+rRtCVDqgjy8jbUfBECEGv8dl6bzaBCCbUbcdRRIw1xKbr3/vH1BkPNansG/A3
 qZvP/IsvpZ90OwKAYoVHX8R8/zkJwFM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-anLaQeMyPaexN3IStP1S6w-1; Thu,
 10 Sep 2026 07:51:31 -0400
X-MC-Unique: anLaQeMyPaexN3IStP1S6w-1
X-Mimecast-MFC-AGG-ID: anLaQeMyPaexN3IStP1S6w_1789041090
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A27D19540D6; Thu, 10 Sep 2026 11:51:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D435434; Thu, 10 Sep 2026 11:51:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-trivial@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH] hw/ppc/vof: Use qemu_tolower() instead of tolower()
Date: Thu, 10 Sep 2026 13:51:25 +0200
Message-ID: <20260910115125.383713-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When building QEMU for NetBSD ("make vm-build-netbsd"), the compiler
complains:

  In file included from /usr/include/ctype.h:100,
                 from ../src/include/qemu/osdep.h:123,
                 from ../src/hw/ppc/vof.c:12:
  ../src/hw/ppc/vof.c: In function 'path_offset':
  ../src/hw/ppc/vof.c:150:31: warning: array subscript has type 'char' [-Wchar-subscripts]
  150 |                 *at = tolower(*at);

tolower() should not be used with plain "char" variables since these
can be signed and tolower() could be implemented as a macro that uses
its parameter to index into an array. Use our wrapper qemu_tolower()
to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/vof.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index fa7b73159a0..873e967f1e4 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/ctype.h"
 #include "qemu/timer.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
@@ -147,7 +148,7 @@ static int path_offset(const void *fdt, const char *path)
             if (*at == '/') {
                 at = strchr(at, '@');
             } else {
-                *at = tolower(*at);
+                *at = qemu_tolower(*at);
                 ++at;
             }
     }
-- 
2.55.0


