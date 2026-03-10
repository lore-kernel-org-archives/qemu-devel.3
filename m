Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08566FCC9CA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq5H-0007yz-5O; Tue, 10 Mar 2026 01:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5B-0007dE-53
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq59-0006IH-It
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCoy6OQYtHfUDEcCV0LoVq1e8ZXCcHkuvHBUQYyJXgo=;
 b=WfqVPDaB+uEYkWdJOni5MyUXpS+UInoH11Cu5xuEmS2VnFHGTRP04PYI7AC76Q2QO1aXUD
 hca+tFChX5o80zWqTYDL4Q6Pa5dXuPZlNJ69lHuIz5vhk4MTnZ38ci/EDazleHx8be4BCY
 cDICYGqcxSzDEBG2peZhccF/60iPEsc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-bgKijGGGMYi9jfOnM6_Bug-1; Tue,
 10 Mar 2026 01:56:34 -0400
X-MC-Unique: bgKijGGGMYi9jfOnM6_Bug-1
X-Mimecast-MFC-AGG-ID: bgKijGGGMYi9jfOnM6_Bug_1773122193
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A56518005B0; Tue, 10 Mar 2026 05:56:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 316111956095; Tue, 10 Mar 2026 05:56:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 15/25] include/hw/s390x: Move CLP definitions for easier BIOS
 access
Date: Tue, 10 Mar 2026 06:55:20 +0100
Message-ID: <20260310055530.8893-16-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Move the s390-pci-clp definitions into the "ipl" sub-directory, which is visible
to the s390-bios.  This allows the bios to reuse the architected definitions and
prevents code duplication.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-8-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                               | 1 +
 include/hw/s390x/{ => ipl}/s390-pci-clp.h | 0
 include/hw/s390x/s390-pci-bus.h           | 2 +-
 hw/s390x/s390-pci-vfio.c                  | 2 +-
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6d43a41431..9d1614fd7e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1882,6 +1882,7 @@ R: Eric Farman <farman@linux.ibm.com>
 S: Supported
 F: hw/s390x/s390-pci*
 F: include/hw/s390x/s390-pci*
+F: include/hw/s390x/ipl/s390-pci*
 F: util/s390x_pci_mmio.c
 L: qemu-s390x@nongnu.org
 
diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/ipl/s390-pci-clp.h
similarity index 100%
rename from include/hw/s390x/s390-pci-clp.h
rename to include/hw/s390x/ipl/s390-pci-clp.h
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 04944d4fed7..f643e130579 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -19,7 +19,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "qom/object.h"
 
 #define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 9e31029d7ac..8ce44dbecce 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -17,7 +17,7 @@
 
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container-legacy.h"
-- 
2.53.0


