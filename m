Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0165CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGkc-0006c5-RP; Thu, 15 Oct 2026 04:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xHGkU-0006ah-R1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xHGkR-00076n-SC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792052614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMbH46NIuuR3tz1VhQI6SevZ/s/DcUHVJE6FSXi7Zjw=;
 b=IMBbbOjJBrjEmEuRoq0h7OkuF5XYkjBjuqZ1sOuaizcZ7Q2GyuCCtB/+3myQc0vDfmUOBl
 IPkAtb60OsxJhNV3bif3LKouhw/hUeD1EyzJz1rgLmWkKh52NbfIkVEWFnpY4oIZhW7fDK
 t6B9FzBWWMMymgHSTEZolf0XdqJaKig=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-ssRfDCiaNIKxS6Ueaj_SRg-1; Thu,
 15 Oct 2026 08:23:32 +0000
X-MC-Unique: ssRfDCiaNIKxS6Ueaj_SRg-1
X-Mimecast-MFC-AGG-ID: ssRfDCiaNIKxS6Ueaj_SRg_1792052611
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74C8E180065C; Thu, 15 Oct 2026 08:23:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.37])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC228300072E; Thu, 15 Oct 2026 08:23:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D62011800399; Thu, 15 Oct 2026 10:15:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] pci id: clarify pci subsystem id usage
Date: Thu, 15 Oct 2026 10:15:43 +0200
Message-ID: <20261015081544.40310-2-kraxel@redhat.com>
In-Reply-To: <20261015081544.40310-1-kraxel@redhat.com>
References: <20261015081544.40310-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Qemu uses the pci subsystem id not only for emulated devices, but also
for virtio devices and generic pci class devices such as pci bridges,
xhci + nvme controllers etc.  Update the documentation accordingly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/specs/pci-ids.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 261b0f359fe5..832f8bd1b802 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -46,8 +46,9 @@ maintained as part of the virtio specification.
   upstream merge or shipping a distro/product) to avoid conflicts.
 
 1af4:1100
-  Used as PCI Subsystem ID for existing hardware devices emulated
-  by QEMU.
+  Used as PCI Subsystem ID for existing hardware devices emulated by
+  QEMU, such as the intel chipset devices.  Also used for virtio
+  devices and generic pci class devices (1b36:00xx, see below).
 
 1af4:1110
   ivshmem device (:doc:`ivshmem-spec`)
-- 
2.56.0


