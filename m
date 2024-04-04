Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E35ECD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsMZz-0008HO-OQ; Thu, 04 Apr 2024 08:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=817f4dfc0=jhnberg@amazon.co.uk>)
 id 1rsLpv-0006Mp-SI; Thu, 04 Apr 2024 08:04:55 -0400
Received: from smtp-fw-9105.amazon.com ([207.171.188.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=817f4dfc0=jhnberg@amazon.co.uk>)
 id 1rsLpq-0006rh-KN; Thu, 04 Apr 2024 08:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1712232291; x=1743768291;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sVywjRiZ1vFgVRZg9B7Oj01vGsLIDcLjACuW81lksaM=;
 b=KvT5ARbZ53uim7LDO/AOWyUw0i2AxWS3M1fihmK6wkfzv4xo42kwMQvq
 KOPfZeTWTWchhiiPtdCzfXxiXE5lHEpDgh536+7sv/zspOCIatMGQYzkS
 5iTgmVrLlubhdkpphCtaBZc/K0m4gpzgeA8aEk85Dimg9lHF9/C0cukxV A=;
X-IronPort-AV: E=Sophos;i="6.07,179,1708387200"; d="scan'208";a="716688577"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:04:27 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:34272]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.247:2525]
 with esmtp (Farcaster)
 id 6b2bd791-1243-44c6-ad62-633fa15ad325; Thu, 4 Apr 2024 12:04:25 +0000 (UTC)
X-Farcaster-Flow-ID: 6b2bd791-1243-44c6-ad62-633fa15ad325
Received: from EX19D047EUA002.ant.amazon.com (10.252.50.60) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 12:04:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D047EUA002.ant.amazon.com (10.252.50.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 12:04:25 +0000
Received: from ubfa7eda7e45052.ant.amazon.com (10.106.83.9) by
 mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Thu, 4 Apr 2024 12:04:23 +0000
From: John Berg <jhnberg@amazon.co.uk>
To: <qemu-devel@nongnu.org>
CC: <kbusch@kernel.org>, <its@irrelevant.dk>, <foss@defmacro.it>,
 <qemu-block@nongnu.org>, John Berg <jhnberg@amazon.com>, John Berg
 <jhnberg@amazon.co.uk>
Subject: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Date: Thu, 4 Apr 2024 13:04:18 +0100
Message-ID: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=207.171.188.204;
 envelope-from=prvs=817f4dfc0=jhnberg@amazon.co.uk;
 helo=smtp-fw-9105.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Apr 2024 08:52:30 -0400
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

From: John Berg <jhnberg@amazon.com>

The MQES field in the CAP register describes the Maximum Queue Entries
Supported for the IO queues of an NVMe controller. Adding a +1 to the
value in this field results in the total queue size. A full queue is
when a queue of size N contains N - 1 entries, and the minimum queue
size is 2. Thus the lowest MQES value is 1.

This patch adds the new mqes property to the NVMe emulation which allows
a user to specify the maximum queue size by setting this property. This
is useful as it enables testing of NVMe controller where the MQES is
relatively small. The smallest NVMe queue size supported in NVMe is 2
submission and completion entries, which means that the smallest legal
mqes value is 1.

The following example shows how the mqes can be set for a the NVMe
emulation:

-drive id=nvme0,if=none,file=nvme.img,format=raw
-device nvme,drive=nvme0,serial=foo,mqes=1

If the mqes property is not provided then the default mqes will still be
0x7ff (the queue size is 2048 entries).

Signed-off-by: John Berg <jhnberg@amazon.co.uk>
---
 hw/nvme/ctrl.c | 9 ++++++++-
 hw/nvme/nvme.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..86cda9bc73 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7805,6 +7805,12 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         return false;
     }
 
+    if (params->mqes < 1)
+    {
+        error_setg(errp, "mqes property cannot be less than 1");
+        return false;
+    }
+
     if (n->pmr.dev) {
         if (params->msix_exclusive_bar) {
             error_setg(errp, "not enough BARs available to enable PMR");
@@ -8281,7 +8287,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->ctratt = cpu_to_le32(ctratt);
 
-    NVME_CAP_SET_MQES(cap, 0x7ff);
+    NVME_CAP_SET_MQES(cap, n->params.mqes);
     NVME_CAP_SET_CQR(cap, 1);
     NVME_CAP_SET_TO(cap, 0xf);
     NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_NVM);
@@ -8451,6 +8457,7 @@ static Property nvme_props[] = {
                       params.sriov_max_vq_per_vf, 0),
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
+    DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..2e7d31c0ae 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -521,6 +521,7 @@ typedef struct NvmeParams {
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
+    uint16_t mqes;
     uint32_t cmb_size_mb;
     uint8_t  aerl;
     uint32_t aer_max_queued;
-- 
2.34.1


