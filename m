Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54926C19777
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnD4y-000515-2L; Wed, 26 Feb 2025 03:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnD4w-00050i-8w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:47:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnD4t-0006Sg-H9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740559658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80ZF4ISdCoduPCJbEOdl32mGrQrVwBBuxvyhBHYuIm8=;
 b=RbQTGvU6x8sT2qsA6MjHHyJOShASikv+rlANMhS+Euu9OmAz01EZVpcRR0bx8V8fRyeCQ5
 T0PxqI4mVJyELG/2CohSyGZoV5OY0ODPqJ7nFbqS9Bd4XCLsDWJf8lZJ5s5a7dlt1eeo59
 Gigojhcze2CeY8Frhm8rhtD8q/s9nr4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-OuA63KwsMWCxzcg3TzYVjw-1; Wed,
 26 Feb 2025 03:47:31 -0500
X-MC-Unique: OuA63KwsMWCxzcg3TzYVjw-1
X-Mimecast-MFC-AGG-ID: OuA63KwsMWCxzcg3TzYVjw_1740559650
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 804C919373D8; Wed, 26 Feb 2025 08:47:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BA2B1800949; Wed, 26 Feb 2025 08:47:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host platforms
 only
Date: Wed, 26 Feb 2025 09:47:20 +0100
Message-ID: <20250226084721.232703-2-clg@redhat.com>
In-Reply-To: <20250226084721.232703-1-clg@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
worked on i386 long ago but we have no plans to further support VFIO
on any 32-bit host platforms. Restrict to 64-bit host platforms.

Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -7,7 +7,7 @@ config VFIO_PCI
     default y
     select VFIO
     select EDID
-    depends on LINUX && PCI
+    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)
 
 config VFIO_CCW
     bool
-- 
2.48.1


