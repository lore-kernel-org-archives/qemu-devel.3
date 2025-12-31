Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B452EE6425
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 10:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vatbL-0002E0-MX; Wed, 31 Dec 2025 05:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatbF-0002DX-Fu
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:38:43 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatbD-0001Jj-1x
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:38:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyRt+KXM9EuHV+y+ksGOHFmvZ2fyH0BfDhCETXPYtbfF6TqeSYW1NeFdOsbctXDokM42PJaPr876oe0TPXrZmq94hzY76QqEnBf4otLu0HcXMoetc+ScPZoGTlvzaGmtbIub/yDlrKixQN3VhMe+GYy4KFsYK+KPoGyPzmD2TbFkOlrqhP+66kojSD8dfnN3sY/dPk0X+ZLAHxQ5j54YJc7AjXlfmUuHnOtEpZlQ8XHWZOTRjOpPhTOav6d8nJrSBSw5Zi9qWvCoycZ+KXkvXG29OP+/l63/5/nyfDGTwoIMQV9q8AbJ5kguDljW0kT2Uo2r0cfOtYWtjZISWqVIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BqeQKpo0b/dX7X7hoc7p6ffbgB7yzoXo7VvmG1oQVI=;
 b=d8vCJ4M9u+CRGA1lIhFmVcVbC2Qh6QKmN4jSJjzJYOxN1767o2trM3Ut/gYzVnTsFZnkr605XjF5NL0lfFcSRL/VxLU7Hc1hkxsE9Vn/WqBFQq5MGbxn36VjR2gW4Dc2XnrCa3J4tNky+oi1hdT7duNXUobgFqxxOfUXl+IeIqXOfonYQqAqzSEOsEYAxQsgcXyZk3akM94O9lPueotomIau8d5raZkH8TFYLSZWpRLOq07c97Q7Juu5/QL3EWgHWvaBlp8x3H1fBBNr+z6cj4xgP0sfukvBEH6jbZ+D7udT/cvStMfNPS+admvM7CSeD4MiOnRrFXV2qImGdYu3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BqeQKpo0b/dX7X7hoc7p6ffbgB7yzoXo7VvmG1oQVI=;
 b=CJWik8mbW42ExgKVqzzjJTiSL6ItClZZrGPOOKsfiGwb4t6Nh2OQEo/tYOBVS97OmtN+fQUyP09BjFkjwKfTXZArBWhNz4O0x1csbko+AQ7a1lq0zy7E/4o8HuoaCMaf4zQTKqxMi+Itgz6r+MGa7wG4CuIFUBMkW6bnnVf27Pbg1Vj3mgMLL/+Z6L0ylL9WmCL++2OQ5SDYXxvoeHSmuPNGBxKqSdoOI/+W3mwAI4ACRmYRBwhEXcOADSd6a9/oXrsRbyDvEqnNwIeGo5W83Boo2rN4KKo1/rksgSL138fnNQqz7+OjUoQWBSktcFwqXxlF4VlLA9TY2V9qsqEx/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYZPR06MB6546.apcprd06.prod.outlook.com (2603:1096:400:458::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:38:01 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:38:01 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v4 1/4] vhost: add data structure of virtio indirect
 descriptors in SVQ
Date: Wed, 31 Dec 2025 18:37:37 +0800
Message-Id: <20251231103737.10159-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TYZPR06MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: e51323d4-da87-4eb5-0d1e-08de4858abe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I6Wbc2VpyHN3kRVKtEieDtINwhE0V+1hNaVVpQZ+GYlNX5/9ks3h8xcwZwsm?=
 =?us-ascii?Q?rNXdBZ1hjmGtRy60o0e6nCbc9fr+5j98/1j6twwnSIBWKGT9mJPsIDeOk8Nh?=
 =?us-ascii?Q?NK6FzBUVkhAJEmnk/3KsctQRJyEWNS1m//CzSmlQ+wRiYFSQWszg3B68XUZH?=
 =?us-ascii?Q?DFZrligyza9RIr2vNmS2AXpestOX2lahe6ir7zHRfn7iWuXSKPSxpomEYpSN?=
 =?us-ascii?Q?OzOffCG12g1NUWRfEkhCArB8c75C55xRjJeZJ79P+z8ryaWT2h5QBBTkIbek?=
 =?us-ascii?Q?QPXGEEBSQsdTYARPTlnt2Pk1pY5kpbyemnOnaZGw5MLUlYVTbz3pA0nFUUX6?=
 =?us-ascii?Q?79L9jNmDBa/1knDWZHXcI+DmhRsEyNcnGjxjGUMSPDT9VvMp54y7L2zgEY/b?=
 =?us-ascii?Q?APN+tVdFZbt5PG98vtbQWAU/v4gIu1qpSS4fSiuwkWOAw4ueVV2O+PqmNPgd?=
 =?us-ascii?Q?mJV4aFoYISmAs07bJSnf7oo31pXfqYxfR2yu6VAGhg3hPn4w3y9iZ1mlNNWG?=
 =?us-ascii?Q?8U/0JO9QhkXFZpG7g2ZTPwZ6PAqvNQqImQAHZSlW7US0w22QlqWatJYhIA9v?=
 =?us-ascii?Q?84Pj0J5Ta9ymkXituhkb185mBEussc7GYhZgkf00RUEaYMXbvSAELu0836Pn?=
 =?us-ascii?Q?7vrpHRKn236F/aFsmlFnxrWPn/XYP6TYp1jFLQHNMZGov2uKa25g/EQ/Kful?=
 =?us-ascii?Q?FexpSKHOGlnOME4WkI2t+UueiDrSl7XTZ6N6MTZ8azBim/VOH1U+DVw/fibX?=
 =?us-ascii?Q?iKQALNryNPmecmAICfn2V8aGGsJ2fHEG/sQc1PWXsI6IlVOqae/YjXetp0Lv?=
 =?us-ascii?Q?GcNMjwXHeHwUn6Yu2kxFulqJm6WKCHGtu6zEoXU5GGS/CPD92q2638YOxerJ?=
 =?us-ascii?Q?ecu2vEipPea0xM210oeE/aMGpb766+fK8qju3ulsRdKVUDWUreYtQATuL6Ey?=
 =?us-ascii?Q?29pLunY+whpAhxOIirV3Mf0j3T/dcRgeYmjQkXFqjq0Kns2DLX56NyRGDCaF?=
 =?us-ascii?Q?IyMF/aPq5N9J99PHnp1JmIMRvrcyeLF3X8hWmu0LB+bjLeydqJdTdx4yDoKU?=
 =?us-ascii?Q?DcM3krlsXODX5qgCJy6XcrC+tfP/v3thT4LSLMK/4cikKdr/A9hjr18EMV/r?=
 =?us-ascii?Q?uJlPlBoEr+NO7G/rzNCUmouyp1eksJNEyNX9VHCgjQWakiwuLqDvX5dH2APf?=
 =?us-ascii?Q?EAfKMxukufLsQ8/X/3g+BI7DeUP+/bfC5AwLTSFJO7Aji6gZWT8vH6dKxIHc?=
 =?us-ascii?Q?GgE4X5K4+yXwgDy5OukF3e8fj/O2v9vo7V+mp3fWEPpT9z8mRcyGJ1fcQYul?=
 =?us-ascii?Q?e001tVshNZD/z/35kEInJDCoAM/O2ISB8nVGDxYebNjhUM0G7bPKlRWBoXqB?=
 =?us-ascii?Q?wcxQJSanoEbt0rihEOlKefTFCRoUVgE3Gs9rkhZaamni0BiNnlkPW4ESu+XS?=
 =?us-ascii?Q?AJqdtKwEJoIXbVwXb5RbOR9+/4wU8pfol05+ujbHy8U2HJ5/n+b5koQCy919?=
 =?us-ascii?Q?w6hV8Rm2vthq0Fo3rxOF8/tdWx87crDn6gVr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzj20yRn4y3snfYgMUDjVlKq8B8BBOS7n8m+STBl1Vpc3cHl+v3IbzHmy6Gl?=
 =?us-ascii?Q?20V6c1Z6PsOp3MC6FAHS4uewJCpAe8wzZRyxDu6IHvFNADNMbal+bK1GdIbM?=
 =?us-ascii?Q?ZK+K7fSHzNbJMnb17xZdZdY0oou7pqpE07rWdGV0R9CymAUHYV0Mp9jpPWGH?=
 =?us-ascii?Q?/GL50nzhU1jWPFSUzfwLCb7mZGRmYBANzpZ2bLFQ9bSI6tUSiaJa48D6Pyhc?=
 =?us-ascii?Q?66ODVfWlFgKEXFXmrkwXiISI2LWeZQmrV11lYK/EkNKio7NYnG5T8dEDRfiW?=
 =?us-ascii?Q?QBin2UE8sG7gAgHJUqDzBWzqIjsQ9EMj+NMmoJPowAzcFyIs70SQGe8fmaYo?=
 =?us-ascii?Q?a0iimJu1SF1mUKo8/oxa+6da4ruUQ1xwik/Gq1OaprqDK9t/90JdMs621nv/?=
 =?us-ascii?Q?P7s7z2dVJs0OTcC7BiwFCmcLRFewI84n7ueTlJ+6vrk4Shrtc8QaJOmqIpwO?=
 =?us-ascii?Q?xphUCiAOP5a1wiM4ksYoftWVxFB3AV2Qs05wRvJKNm7F7r/6wV+etLjI6tpk?=
 =?us-ascii?Q?I3iaEiSlZff5G98ko+f5v02pNphqNSX4OrZR8lxFiHqgyQtgblQ0J0r3LT2D?=
 =?us-ascii?Q?0hY1Tq9NKZz+SJcHFZ178t12NaZrAWqwCdnar+nqYP5yLv69C8q7Ea3cJg8l?=
 =?us-ascii?Q?4q18Mq0ZtokPl9k/nhjhF0PswbGDdTv7joCWKZqiAKOjnFdRnHCmS+7P7tYu?=
 =?us-ascii?Q?HZRkP9J44HqFoS8ftpn/lctxh1uqXTxgC176bWBnJN5UNnClLvJvll5ewRol?=
 =?us-ascii?Q?BGZKLRX3ILilo/Xb8mFQRV2cqvP+cswiGt6vBr/MAObgf8YGWxBBYrR05EWV?=
 =?us-ascii?Q?NPmFO1IMXsMQmiKe6RLjqOLcvobiV/nZP3XcYBqurEcT7dLPehUaspYTNSr0?=
 =?us-ascii?Q?UIc0jGwHtI3PqKtvQI+NYpwhsxiFO8mPp+h9AM2AG1zRJZpSp8HZFXj+baHl?=
 =?us-ascii?Q?mTo1M6NEP9cehJgNVL0ZJkJr/NkT6TCfOidtGReZkPsESh9VUO6GSkxmHqbn?=
 =?us-ascii?Q?+tSUZ41S29AexG8/wwDVyV4FIOjp/xI3NRJsXUpkKKlaBCP2Dj9fuKSTyKB/?=
 =?us-ascii?Q?HozhCRTaXQN5liGCgZFrssVk31l4fHRmcYWIVKcfSxcmgLavQz1U/2bGc2RW?=
 =?us-ascii?Q?+R+AtZ7I5Ko6bF8ehL6bIBUFXJqhWhHCEW8LcoPKfDMsZ+NGpt8t6gve5NMh?=
 =?us-ascii?Q?f1qmMw7sZO9ITAxIh+7DqDM55i0+zF5jmyKeFcTj+mxToXi8h9l8BKCx0hsj?=
 =?us-ascii?Q?MXlW81JJ32V3ii53RIFnIfyVKwI8P9Myw5y1Mt40aDHwaCUH1490d2jGBQOW?=
 =?us-ascii?Q?UXkqx/bsC/bIjvrOPkpqZg0we0WSNNkky55oLOWZEqpc5P0MTzerBN3YAHWI?=
 =?us-ascii?Q?ef1dwVY9B7jdUmwLDDXLZ8FoWStwttexRSh8iVgCMJT0m+zyIWS8KckpCBRr?=
 =?us-ascii?Q?GD0b6Ue/+0gTAjt6YkakKUgZEdf0qFHT5qtuPPsKvKcqqn6SMque5343miQP?=
 =?us-ascii?Q?9Qkk7mErBJZoPTbJ3CBFt1RsW2mfpiYNsVRHF27eGDJSg4SDK/8Z2WQPxuJ7?=
 =?us-ascii?Q?mPVPCSFK9glZkH6oJUPPQw6kipS+iqrY8rTl96LyMUjn3GDp7lOsGjb4z+mt?=
 =?us-ascii?Q?ZNEh+2MVX/b9UYJCx5UGMfWX4VuLhzkgetpuJqS106fwEuJe4SijztfG/GKL?=
 =?us-ascii?Q?7xCGB0YdiREnRcir5iM//W1onuPsEbvHDVQtQJV4Sq84odo5x9/Nw1/+kISV?=
 =?us-ascii?Q?SKpFhRqhVQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51323d4-da87-4eb5-0d1e-08de4858abe7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:38:01.2599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXVC0HIx+oZeRBCePiTI06nhxVRTDiMnS027v5ukN90NmO0i59l11Se90Xn09cknjWh3bwyrvqiL7ErKn0ld7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6546
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=wafer@jaguarmicro.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: wafer Xie <wafer@jaguarmicro.com>

Use a shared indirect descriptor array to store all indirect descriptors.
If the current indirect buffer does not have enough freed descriptors 
to accommodate the SVQ descriptors, 
descriptors can be borrowed from the next indirect buffer.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.h | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 9c273739d6..a50baff615 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -23,6 +23,13 @@ typedef struct SVQDescState {
      * guest's
      */
     unsigned int ndescs;
+
+    /*
+     * Index into the indirect descriptor
+     * buffer (0 to SVQ_NUM_INDIRECT_BUFS - 1) if using indirect.
+     * -1 if not using indirect descriptors.
+     */
+    int indirect_buf_idx;
 } SVQDescState;
 
 typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
@@ -46,6 +53,44 @@ typedef struct VhostShadowVirtqueueOps {
     VirtQueueAvailCallback avail_handler;
 } VhostShadowVirtqueueOps;
 
+/**
+ * State of an indirect descriptor buffer
+ */
+typedef enum SVQIndirectBufState {
+    SVQ_INDIRECT_BUF_FREED,    /* Buffer is free and can be used */
+    SVQ_INDIRECT_BUF_FREEING,  /* Buffer is being freed */
+} SVQIndirectBufState;
+
+/**
+ * Pre-allocated indirect descriptor buffer segment
+ * Each SVQ has multiple segments that share a contiguous memory region
+ */
+typedef struct SVQIndirectDescBuf {
+    uint16_t start_idx;         /* Start index in the shared descriptor table */
+    uint16_t num_descs;         /* Current number of descs in this segment */
+    uint16_t freed_descs;       /* Number of descriptors available for use */
+    uint16_t freeing_descs;     /* Number of descs being freed from used ring */
+    uint16_t freed_head;        /* Next free descriptor index (relative) */
+    uint16_t borrowed_descs;    /* Number of descs borrowed from next buffer */
+    SVQIndirectBufState state;  /* Current state of this buffer */
+} SVQIndirectDescBuf;
+
+/* Number of indirect descriptor buffers per SVQ for mulit-buffering */
+#define SVQ_NUM_INDIRECT_BUFS 4
+
+/**
+ * Indirect descriptor information for a shadow virtqueue
+ */
+typedef struct SVQIndirectInfo {
+    vring_desc_t *desc;           /* Shared descriptor table */
+    hwaddr iova;                  /* IOVA of the shared table */
+    size_t size;                  /* Size of the mmap'd region */
+    uint16_t total_descs;         /* Total number of descs in shared table */
+    int current_buf;              /* Current active buffer index, -1 if none */
+    bool enabled;                 /* Whether indirect descriptors are enabled */
+    SVQIndirectDescBuf bufs[SVQ_NUM_INDIRECT_BUFS]; /* Buffer segments */
+} SVQIndirectInfo;
+
 /* Shadow virtqueue to relay notifications */
 typedef struct VhostShadowVirtqueue {
     /* Shadow vring */
@@ -96,6 +141,9 @@ typedef struct VhostShadowVirtqueue {
     /* Caller callbacks opaque */
     void *ops_opaque;
 
+    /* Indirect descriptor info */
+    SVQIndirectInfo indirect;
+
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
-- 
2.34.1


