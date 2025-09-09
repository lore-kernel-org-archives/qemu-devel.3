Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F372ECA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvylU-0000iD-5S; Tue, 09 Sep 2025 09:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylR-0000hU-Tn
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylM-0005Dx-GT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vz1fSiImjfusKWvQuE6YlB1IKPFNFD72nNzG5FIw64U=;
 b=jSRpSJBBrAX52refsb6iPqZL2Ub4iOzc4ivNqC7KEDE9QYwGBn/f4wSLJitW4OctoNIr30
 MAvYAotdJfJX0/JkvFL4Uk6JEa338+y41nLFMgxgf1TCTwb/uzbd8LcGSQckiuUm17M9ki
 Cuur8BcsUfB3HsXsjLlDxxZeAR3OmVg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-sdJ6qgP2Pey4PHuBj45Nfw-1; Tue,
 09 Sep 2025 09:51:53 -0400
X-MC-Unique: sdJ6qgP2Pey4PHuBj45Nfw-1
X-Mimecast-MFC-AGG-ID: sdJ6qgP2Pey4PHuBj45Nfw_1757425912
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61EB91956096; Tue,  9 Sep 2025 13:51:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCA1A1800451; Tue,  9 Sep 2025 13:51:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/23] hw/display/bcm2835_fb: Move inclusion of console.h to
 the .c file
Date: Tue,  9 Sep 2025 15:51:25 +0200
Message-ID: <20250909135147.612345-2-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The definitions from console.h are not needed in the bcm2835_fb.h
header file yet, so let's move it to the place that really needs
its definitions, i.e. into the bcm2835_fb.c file.
This way the header can also be used by code that is not compiled
with the CFLAGS that are required for pixman or OpenGL (in case
their headers do not reside under /usr/include).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250508144120.163009-3-thuth@redhat.com>
---
 include/hw/display/bcm2835_fb.h | 1 -
 hw/display/bcm2835_fb.c         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 49541bf08f4..acc9230b6a8 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -13,7 +13,6 @@
 #define BCM2835_FB_H
 
 #include "hw/sysbus.h"
-#include "ui/console.h"
 #include "qom/object.h"
 
 #define UPPER_RAM_BASE 0x40000000
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 820e67ac8bb..1bb2ee45a01 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -27,6 +27,7 @@
 #include "hw/display/bcm2835_fb.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "ui/console.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
-- 
2.51.0


