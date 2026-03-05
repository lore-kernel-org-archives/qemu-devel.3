Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70823EEF303
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy227-00007y-56; Thu, 05 Mar 2026 01:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vy21m-0008AX-HW; Thu, 05 Mar 2026 01:17:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vy21j-0002VV-Op; Thu, 05 Mar 2026 01:17:41 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6256HKcq066823
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 5 Mar 2026 15:17:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zEGuWpwSPorKgdOr8uqnGxj5GoiSbQsHVJNvDM8QBj0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772691443; v=1;
 b=JW6gjcl8KD9cHADl50P/DdJRuUA+HJkXGj9HI8USTxBe8XZ2CJ797GDa4OjpEJKh
 F4TDxrrsZ4NDv6xTm44J7tQBFIG9/Y2dS8A01OezJ75wL0BvXt7gANeEkOFIjs35
 VTpw1yQhDIRfGZQh1STVA6gueG3w6rFjkSG1/y3C+2lqT+TxrlyLJ4X+BK/FTKsE
 tYaKyB2nJn3jTrJkVx8IwKQEnlbjnVHAGiCLWq7n70rp8IRE+PK1qYy+Le5HyN+B
 HNb2S3BGHCKhCMSlrcWtx6OmmXQC36eSGsZddDYep3yMKhwBJ7aOJAYCE3uMYXS6
 S7QFGDmNCYQvsOA4Q3XMkQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 05 Mar 2026 15:16:45 +0900
Subject: [PATCH v4 2/4] vfio/pci: Grow buffer in vfio_pci_host_match()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-nvme-v4-2-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
References: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alex Williamson <alex.williamson@nvidia.com>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

Each field of PCIHostDeviceAddress is an unsigned int, therefore
while a valid address is limited to 13 characters, an invalid
address could exceed the specified format, up to:

        ffffffff:ffffffff:ffffffff.ffffffff<NUL>

This requires 36 characters with the terminator.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c89f3fbea348..94c174a773fb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2739,7 +2739,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
 {
-    char tmp[13];
+    char tmp[36];
 
     sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
             addr->bus, addr->slot, addr->function);

-- 
2.53.0


