Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10FBE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6ds-00078U-30; Tue, 24 Dec 2024 10:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6do-00074t-MM
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dn-00044P-1w
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrl6zynbkbHoDqtO+2JM845choi2UqvDOhU6uqJPKtE=;
 b=g4CQG0xFlp/1lfBxwaDiwKvWPxh3U2RstmWA/+OlxNQrNL2HcruXILy9JnZO37BscMgqV6
 sP+MiN/mgFTiqwjVCztRROtnYrQ/bdSMTDA4mfXPcfpXOs6VPcPUEHDSvTZ/ZmMrLprxUE
 8LveGD1FHR37qoRJ6DA8TDBiPAAdQ2g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-7vvYTszzMnu9ungpSSMGLA-1; Tue,
 24 Dec 2024 10:16:06 -0500
X-MC-Unique: 7vvYTszzMnu9ungpSSMGLA-1
X-Mimecast-MFC-AGG-ID: 7vvYTszzMnu9ungpSSMGLA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98EE19560A2; Tue, 24 Dec 2024 15:16:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 593F73000197; Tue, 24 Dec 2024 15:16:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/17] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device
 ids
Date: Tue, 24 Dec 2024 16:15:36 +0100
Message-ID: <20241224151547.386529-7-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

All gen 11 and 12 igd devices have 64 bit BDSM register at 0xC0 in its
config space, add them to the list to support igd passthrough on Alder/
Raptor/Rocket/Ice/Jasper Lake platforms.

Tested legacy mode of igd passthrough works properly on both linux and
windows guests with AlderLake-S GT1 (8086:4680).

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20241206122749.9893-7-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ed236f443a2a0ed525fb81c08b8f6dba8316186a..49b65477767308cab3ce1f4e5b3bd77b90f42831 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -86,9 +86,14 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x3e00:    /* Coffee Lake */
     case 0x9B00:    /* Comet Lake */
         return 9;
+    case 0x8A00:    /* Ice Lake */
     case 0x4500:    /* Elkhart Lake */
+    case 0x4E00:    /* Jasper Lake */
         return 11;
     case 0x9A00:    /* Tiger Lake */
+    case 0x4C00:    /* Rocket Lake */
+    case 0x4600:    /* Alder Lake */
+    case 0xA700:    /* Raptor Lake */
         return 12;
     }
 
-- 
2.47.1


