Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE1ACAC58F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3lf-0006Km-Jz; Fri, 12 Sep 2025 09:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lingshan.Zhu@amd.com>)
 id 1uwx0m-0005kY-59
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 02:11:56 -0400
Received: from mail-dm6nam10on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2413::611]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lingshan.Zhu@amd.com>)
 id 1uwx0j-0005ln-Py
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 02:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxqXERKyynDbzA3L9Ne48RfqycvcSkx0A6YUznasuYG/o5MDkOgdHrZmrVyb+fTkvQ+xcWdrqoSUzt/XqQDdzQdy8Fu2RGZBzBOgR49KovK00jqI//2g5lr31hscGQEnxPtVcVKAQ5KOsy41NZE2ZzhAQ3Uv+A/HX6HnFlaALL06vH4nYnjborTlP9mUJ39zy5wS9b0Tuh/vL+KIs6Bm33P311NfNmW0T+JgWnRiqkLjg6rSu4Z3mMxEo0hlD1emeJBaHvrlO0fIyKkQNkkraKHZ4WJZa1wSzeJmiZyS+qz2KKDoK1bKGLJxQmNGT8G0xijEsc5dqKO0QHE+Zt7P/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpyMhExORLjCmbrA9QoaWpCbIp8zyys/5Q8qeYSVDMA=;
 b=yV1sb0bayRRq4SDlvzxawvTL4FMYHlrq+HJ4IhEZDuXAP8TGgvfryorENV5OmDHCmQbkg8j3sb+yxmgk2ljB+RAT4uL46LYKgVUCZilSEsjlCLsq9t/RoM6XDOJuG9lJ656GbxTNtNmIDIMChQqp4p6ZFscRR2trXAkgG7KMVK3N5NFtt8Tj6RJXu7/g9r995MqjABrKCJbZqre1ViTMQACA0C9mzygoRy8v8fE5m6/oYGk8Nonca5cnxT5wSNwZakdY8lpAC4xzcIgskbg9ygq6k0iiGJUalHebxr/EbSEedSd06esceMzr+h7/HSXw50sKEjLz6GXbWM3MoBe8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpyMhExORLjCmbrA9QoaWpCbIp8zyys/5Q8qeYSVDMA=;
 b=m6AjzhqUnAHEUSWfgkt/PgtMrhobPG0WMZGbgWHfSg+70pFbnmjkXHilarQg+KTOtoUd8E1IBaubWO3Vj3D8VS8u8sURWALg4vX49bMUOZxgqnAUqqcpIMt7/xT3rTx2kon6qnv8v8vXdlFRVtLC5Kg8OQQf5czGl67tvF/EVgE=
Received: from SA0PR11CA0194.namprd11.prod.outlook.com (2603:10b6:806:1bc::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 06:11:48 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::25) by SA0PR11CA0194.outlook.office365.com
 (2603:10b6:806:1bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 06:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 06:11:47 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 23:11:45 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [RFC 2/2] virtio: implement virtio control-plane suspend and resume
 facility
Date: Fri, 12 Sep 2025 14:11:25 +0800
Message-ID: <20250912061125.262457-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912061125.262457-1-lingshan.zhu@amd.com>
References: <20250912061125.262457-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daa36b6-3a31-4fc0-c415-08ddf1c34132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4LwHORRdIwrymi19Y84pOA/y2/j8mC4QnRkEAjql1dZ/SUlc3aDVCjQN1CSW?=
 =?us-ascii?Q?HpfeZsSPSx6cy5iLJ0dLnGNkUtWUkYm41Iu/7zzwF0kgd/D3lLdKyA3knaIY?=
 =?us-ascii?Q?eMzo835cEJ+sMJIbr8/EKBTlucQJYokJH4ajm91vkchlsUay8h5RPMN7BnO8?=
 =?us-ascii?Q?ACTX8iFVWEcvq0FPzW4OngJPOokRiFx/zTx4xJT1ZcqB80aNqn8t81apwqDr?=
 =?us-ascii?Q?1izs03Q1686GjPfMD9NAMb2UcKYTJbyf+JHKqFNaaS20TJeMhh3egs3zFpdq?=
 =?us-ascii?Q?fNABa5ZXimGVJGMxKHym3FU2WdmryaVVBRQ6niy9HxXiOvS5nbIlkIN3BGLc?=
 =?us-ascii?Q?qG6sT8VLh8i0xs/uY4XAjb1y0Zz13CM77HHtz1JHjWM0I7myzxi7fa4Sfpq4?=
 =?us-ascii?Q?v8fjjrbFpM3w4HaaOMn3dMv4HhEu4z940HWSs3JbtZpTKrbSUaINY7D5nFa6?=
 =?us-ascii?Q?47iWUCN4S9P0QBZjcELLZCt5cskHsbjrbXOx2UlwW2oOcDtyplhXR85nGSoR?=
 =?us-ascii?Q?irv8MPp7DeUnRB1AHqrenpp44rw3TkM4fsOreY0Jc09uxW7EnqS2iT02fygz?=
 =?us-ascii?Q?/7d2vxQLlT6Nf+a824BG4nePnvQ3lvRKpJkCqjmxIl2B3xDhsjXMX+LqlISm?=
 =?us-ascii?Q?s0jWOmuwP9JDBn62Mj3Ga8cDCuD/3eMWrFPVR4n9Qmx609mbi02vWw1vlTGU?=
 =?us-ascii?Q?WBKJMR5NK3pwRofaAUdLyfQn+dPp3o++Wifff91qTksZ+Q434QCLtVaGqtbZ?=
 =?us-ascii?Q?2Zt8QhyAJ9j9asJyERXsE7jCXr9tgk5eMQzaJ9HSVg+ydIhhUh5Ib3SCQD9I?=
 =?us-ascii?Q?JxG03Mb93SDXmIyi4NBbYirHmWmpwTSmvuQ4lf3dS+cdtwZlz9yPgZf8KRww?=
 =?us-ascii?Q?vkjAES2ShM4r1o5bBdymYAid2FUzdki3lFTE325GDMzanKGErrAOJOV7m4It?=
 =?us-ascii?Q?Zo/d/TT0BTOFcwmAITcf5hB4kDGE0f+2HLdVULsHAylZ+2HVBd6AmD5dF+3q?=
 =?us-ascii?Q?AMuw9v+HOPSlFpRsqAA7GOm3x09PT3habGHP0pfTppsymK7x1itdIGPnSzD+?=
 =?us-ascii?Q?F+jU5fe3dLj5d2OvXS/n1TaZunsAb1B663UU/iHJWCpijy2ucnZ7vVgaNKe0?=
 =?us-ascii?Q?EvYTbySicTszaLMme6+9gi/D0riP1JtYR+TQU5/HCDOxZJsxVj0bUGy2O/I/?=
 =?us-ascii?Q?fN9ihbxujQrv2rZ7yTCGBNkKhDh63HwX1fhGIWDrnAOo+c+pv2niwSVO8/fU?=
 =?us-ascii?Q?yfZ1bhqJgEiWlAjQ+hamQqhDxtXOhLf5te2nyStuuejkk6K2j/zUKb9i9Yrg?=
 =?us-ascii?Q?v8ciYAzAf/myyY7YYxXEmem3htRP98nCA+Yeocm2mXi4jtsAysEXbfrA1EN6?=
 =?us-ascii?Q?JKSy9gzpq4zIdy0rleAvrAF0PAvhkVNvj7zypXud3ATY0vg03oyMVUJaybUL?=
 =?us-ascii?Q?PmTpa8gaLiMY+wRPdo+5JG2pi5W+uGf0KZ9Bn1Jqn5KkOThKw7anePJeCOL8?=
 =?us-ascii?Q?WY5lDzu/Hx60MHCmbQhFnIh9QHA8Ihp/Auji?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 06:11:47.0588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daa36b6-3a31-4fc0-c415-08ddf1c34132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
Received-SPF: permerror client-ip=2a01:111:f403:2413::611;
 envelope-from=Lingshan.Zhu@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Sep 2025 09:24:40 -0400
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

This commit implements suspend and resume facility
of virtio control-plane according to the new spec changes,
and a reference design on virtio-net.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 hw/virtio/virtio-pci.c     |  5 +++++
 hw/virtio/virtio.c         | 16 ++++++++++++++++
 include/hw/virtio/virtio.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 767216d795..bc9189746f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1580,6 +1580,11 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         return;
     }
 
+    /* only allow writing device status while suspended */
+    if ((vdev->status & VIRTIO_CONFIG_S_SUSPEND) && (addr != VIRTIO_PCI_COMMON_STATUS)) {
+        return;
+    }
+
     switch (addr) {
     case VIRTIO_PCI_COMMON_DFSELECT:
         proxy->dfselect = val;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e5abbc4601..9d632d72be 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2242,8 +2242,10 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     trace_virtio_set_status(vdev, val);
+    uint8_t old_status;
     int ret = 0;
 
+    old_status = vdev->status;
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
             val & VIRTIO_CONFIG_S_FEATURES_OK) {
@@ -2276,6 +2278,15 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
             vdev->status &= !VIRTIO_CONFIG_S_DRIVER_OK;
     }
 
+    /* The device has been resumed */
+    if ((!(vdev->status & VIRTIO_CONFIG_S_SUSPEND)) &&
+        (old_status & VIRTIO_CONFIG_S_SUSPEND) &&
+        (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        (vdev->config_interrupt_pending)) {
+            virtio_notify_config(vdev);
+            vdev->config_interrupt_pending = false;
+    }
+
     return ret;
 }
 
@@ -2714,6 +2725,11 @@ void virtio_notify_config(VirtIODevice *vdev)
     if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
         return;
 
+    if (vdev->status & VIRTIO_CONFIG_S_SUSPEND) {
+        vdev->config_interrupt_pending = true;
+        return;
+    }
+
     virtio_set_isr(vdev, 0x3);
     vdev->generation++;
     virtio_notify_vector(vdev, vdev->config_vector);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..9d66076f75 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -167,6 +167,7 @@ struct VirtIODevice
      */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
+    bool config_interrupt_pending;
 };
 
 struct VirtioDeviceClass {
-- 
2.51.0


