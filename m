Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1D1D5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 01:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVKHT-0005MC-HA; Mon, 15 Dec 2025 20:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKHN-0005Lc-Vh
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:55:10 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKHM-0007R0-6s
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzygtzwLcrTv/XMkWzmcoBV6E1t4+gyVYWtn9p/jvLaFO2K7NsGStFx0CSLHryAalhOcNvgMm5xYkZTjWvYEWkSbXjNJiEA36/AP26sbycqR3H6FzdRGRfXqPJmkVr/AnSVkYlNn+6Hq892SliEeS5iRKbsJGG9xggIyDoI/lLhnjkAxIp6cv3zUJmKtS1+Vz3y5n20ac/Qk0V0dkYaRYmCaeNir5mbjoYTZpzS+weFMlnP67y/g4Yw1j7TgLchxHtfcxii5aJNzC/n13PorEJsxcYeW+nqB08ze8VDMmLfsKebGgP/hGgKo87HjrGaAPqVAZ7piP7pHI0tZqX3nQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZtHVVLA+SbMaMkT67HwF1H5YX44IPT/iqmL4WgaeKQ=;
 b=OX+4u8Yd5AK6EYCJPxuVYBMljnoTPOz2L9L86OxW7KZh+uWl34395vzR1shqrvh4hgrq4d8z/v2jvYUP5Z79Xj2CzkWWsxy6XdnVv65JRqLd7RKeaGR3okMkqITTW5w7RcO92/NtaBm/VkMPvDzhLgcim1cyc05XhnngIlAVWTd1DeqIs/KZDMGbZr02EWKKLU8M0y+kuYZw0be/4pHraEp+clUVp7lmRFYwadGpAagZ5OblhnJJZ+bU55LASyCHgEXWL7Ubxy99kxiCv70vhCBEVLABx1K1gkFmI5d+p2koTclZfoRc3DaK+uuiLmXAi5bbjsf0hfVHwTzIe2wbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZtHVVLA+SbMaMkT67HwF1H5YX44IPT/iqmL4WgaeKQ=;
 b=ivq5KlHJdTRgbSNhgTjnt30+6kxp9/JogEpJbRE6TEUIkS4UtCWhYTMD2JlbcH+CLre6Oo3f3caiH21zdYeI5CXeWyw4k0ScZ/Tk+QwyNmlBdMFxDtumB7xM/fmDZGIbdOLwJpC2jwK462nvIaoj4PoUNst8ThUddRrVz+vgzxoMLabY9VeQP7mm/GpGnbO3hPc8nKYtdoT0GkDROlAw1jPmNf8hjShDEYnnJqkXBD0K74RW/HZRcGbQ3yumoZtpWQbkFGKRCif2tfFqRxBQ3i+6tt7597b9wQC/i58T3QzYlhHQmvS4a/6yPm8IEviJ6aXRKIM8Fuc5ODZyVg1jBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by PS1PPF6469DE8C6.apcprd06.prod.outlook.com (2603:1096:308::253)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 01:55:02 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 01:55:02 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v3 1/4] vhost: add data structure of virtio indirect
 descriptors in SVQ
Date: Tue, 16 Dec 2025 09:54:51 +0800
Message-Id: <20251216015451.6479-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0050.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::18) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|PS1PPF6469DE8C6:EE_
X-MS-Office365-Filtering-Correlation-Id: c02657d5-06c2-4fec-7ece-08de3c46204f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?higRmoYsKyr69x3MwK/UeZyndiLD2zBMbob1bazBuoUblWArRI/onrLPiRLv?=
 =?us-ascii?Q?u4lb9qQuWeL2MJHE4w+5DE4BY8YlxTymjVYuF5wPkkf+W1OKqTyXmyMptfZQ?=
 =?us-ascii?Q?XSqPtdUEv+Tirp1s3lU3OCfQCfPTmSOBN5hhYPyWdcbG/waDv30HnIXdwORq?=
 =?us-ascii?Q?JTgMHOyACT2M1mzGWNsv2tgYdlMtXlu0moeK5c1bcPrqI5mqLu86ilf27Qfn?=
 =?us-ascii?Q?o/9emx8W9w1KzNxVpxwBUwVOVvTmp2guZze61os1UzTCEAXa1jg6c8q5r9iR?=
 =?us-ascii?Q?V8HxyctxKa0wHgNURN8KKkpjBdT7/ITPVis5U8djF/bjFRQUVJWoayRd8Nar?=
 =?us-ascii?Q?WUPnMAYOii5OKypRRxy/1QtEehSPbgsR7XPfKhcMWfgZVwHda4nNnwFwseMd?=
 =?us-ascii?Q?X76o9Dcemqijt6y93ZmH6rzSFXqKSqmXXWl4YtmQtriVlDBVgqfyhgcYTg5E?=
 =?us-ascii?Q?xegHwyBCsIFURlgv/6foP4lKe1jfa+grBS+FbKuAklzURITOFU2UD9ftbxGe?=
 =?us-ascii?Q?3cQiISI+3sqAvtvJmVa33PW8EdhugME/ccJyxiW600XpbgICWHegg1zmkBeM?=
 =?us-ascii?Q?MOH+VvWkFYKzvMsV2BOeogvdJpe0h6nQakfRRimFFcJ9kuFPi43l9OMguV22?=
 =?us-ascii?Q?2DOE0a8F94l/PknKwnoQ/sEE0uJ/GVMsOjcS6tvfo6h6qsX8zhLC5EAKCzG0?=
 =?us-ascii?Q?IzGZWuw77n2SHcJmdKdG8DoVKhnrFPhBAil9OwRAuhY+3tDMNJx6rRBIWbwp?=
 =?us-ascii?Q?ILMo2TZL/xLO85glIcMoWm4FyLbUnfh9BfKlWtjwNRI8Xav09O6bUX2rEiLc?=
 =?us-ascii?Q?5PF3N3BHSJFEQWUG62FdjR8fPQ7HIz+qA97yrCvjBbsFxnYLnOCvO2yROlxf?=
 =?us-ascii?Q?k41LcU6meYETCQezG45f5woYV1qENQDyRh3WnS4Yyc47MGeGGv1wz+IPe+KT?=
 =?us-ascii?Q?URtlYhW5h6a4DIcga6omjlcGi2EQY8I+4joKyWqJCJZpJ+/AeL7xMAI1bvfv?=
 =?us-ascii?Q?P5pKr4N5WvkcBElomLty6jUdVAhkTjGtMEF8DGfOlEsY1U7KrtcGegwGOxbj?=
 =?us-ascii?Q?HSX6yxtA4WvSPbfnp382giZzepLEEQycaslE2D25UN/7+1ljMgzE0v6c+z2q?=
 =?us-ascii?Q?blRJF8bzUt2J8Rb1SmCjvB2tJw9+uBVgx/IF7XaCs+AC1gk5aDudq5sfr6zY?=
 =?us-ascii?Q?lT4a6wwoYV7MG2S6amcj+Asg1XbxZr+SJiSkjpAEXQncRYMVMkPhc6AcYipT?=
 =?us-ascii?Q?2LxyEzLGNZlUNpxDjySaK3wyu6dMAGmVwsFhAquv828eaLXlzkTJ++4gcFvy?=
 =?us-ascii?Q?ppyOS5NW0aMPzw1AaMnl845XFUaif2noWymNpJt6x7hNGKrvS3uKS9Pne+Xw?=
 =?us-ascii?Q?wAl8uU3WetkPd+oyX6zckpWsHMMbl/qPiad+TQpe1ty/WWkatUKawomxCSxa?=
 =?us-ascii?Q?asf2cLf8z+fjUauEn0aTWHuIIoL2hhj18WYrNMFRcR9FOOEKedYDUB6LGQ/b?=
 =?us-ascii?Q?RY1WIJL48XFnWEahMfIU3udJ4HQbwc8dgLln?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lkEbvFhrpBzEm55DgH0IyccwlJDo3810GEKq1DEYvL26j0SYR3kvPjCqH0x1?=
 =?us-ascii?Q?Z8OXmbyef8qPpdMTKVJ4uzxGTuXrK8R/ol8sBuVyL+5k00mTSo8HzX5gRC11?=
 =?us-ascii?Q?sCqFkq5ufDocVqCWaKpNln+APLGz8PYz4OiXhXhNjGjZNj4JNYTPNFT9GJyu?=
 =?us-ascii?Q?tGihmDDjvJA6vALkKVG/YukmdHkFOh5R2vBLmbM4xB3oZxKGo72FSLXrtyK0?=
 =?us-ascii?Q?qwXPLrM46YcKFR7vduZASpQlM8f4P75qqZ2b4VAYbuW9zUqmcyYNA6SxfssX?=
 =?us-ascii?Q?eUYkX49KsqN3Yf9RmHRay6ckAvXMyLXklTcay6IMdYp+q3JzdsOAoyB5DjsQ?=
 =?us-ascii?Q?JzQBJ9Vxi7mvN+bN9/dkdoHaBEZFYORc5nKpIBA/4GNt1PUNyPiWRONnCIJ1?=
 =?us-ascii?Q?XY2Y7OhmhHAcXNIEsDzbbtuiEPoljndYH7IXn0MKPz5EAYQ3030kJY29Gbeh?=
 =?us-ascii?Q?hlEIkcOPcDmi4Z0C2OxAiNpwIntnIv+bGF+9WhM9b8P5N/zJ/ds5zqYMpNyy?=
 =?us-ascii?Q?o1+9pGCHIXGx9uQ6fIzzdeLeQaKtCGTqkU6WX/2mWf6d7r5eK05T63sSq8De?=
 =?us-ascii?Q?N0m1k/B7Dn2RQ4lmIsRo0jXw/3O8IXPF+glwoKtFpnUeOjNkUfE859NOCF9n?=
 =?us-ascii?Q?oYHtxx7zG7dqTu3+4sVFYPg3FTTDSyV1GFCEHNgGRbE/MMtkbkdDnFRRQBEw?=
 =?us-ascii?Q?9DphG1TC+omMdmQ02kIr7q6LczktuuBv2NoBpSS3xvZOkdIH7rFC3LZXl6xM?=
 =?us-ascii?Q?R/YdZ5YrtV9pvuMjx18xuW6MEzOs7xtBN6fQymv1Gx9xmozG7+eyoA+yF2J6?=
 =?us-ascii?Q?1tmM4n6muCwYDesXTAA0rVHMSZZUN/MtnNfOvHebiXc0h3gjZqmc8JafLSUK?=
 =?us-ascii?Q?YStE1YHVPpVwfQoc+EE29nnCP2k6r4lhJgBv6xzTzmaLjJtNJM86Mz7Pl9hx?=
 =?us-ascii?Q?fCVPFxSLYavN0IrJsWt0l0+1xd25kr8O2EQ6GYGzPjCbz18V8u7FEvQ9kH+n?=
 =?us-ascii?Q?92+24BJgRVuU8r5uRTfqLjK7eLgtYy4cAjtbKt3xhtmtbsBESc7JRqimF+D7?=
 =?us-ascii?Q?VwfQoYbKwU63JN7k51QZxEaRPcS+PzUwCfDYWSVUh0m48oAMEsFDHh5YUD4y?=
 =?us-ascii?Q?MCQXNMkeMsA7RGHhCgLEqn+RJOF7PaqESBziZrgzIalbr5fIx+6r9fEKblnV?=
 =?us-ascii?Q?MPYnNJauKKK7pNuvDf4DYmjuiiZHzahISK5HdcdHZS8ZTGMG3sQddE55dnKf?=
 =?us-ascii?Q?RcZneB+zcoZ687mzz1CXw8QtaP7agK7+b1E++QnBJcf22uGmn1cDKIsmnx1M?=
 =?us-ascii?Q?xrbo0IiEvlvq/u7yJUrZ5KBEu53vY0B/3k5qaGuuEU8xWIiFWx3ufXL2PSYx?=
 =?us-ascii?Q?BQ843swyky3e8WtfXJUXDlCv2BftA5vLi+lGmAq58ORDHDchmp7csECyG7Na?=
 =?us-ascii?Q?kXsg9LhCoyPbyfcyA1p5+wtYctTLPfDsbFGsrS0cwn18Ii7GBNDLcDNcaKmw?=
 =?us-ascii?Q?r1GY6iSn/CPc+B/bYlh1E+iHP9UtZ9yExh/2/75ycTd5lVnx41BNXz5ZKzdw?=
 =?us-ascii?Q?LgeDmzbIzURklDM85zb7ZqWAQaIWstYHMObk1NAD?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02657d5-06c2-4fec-7ece-08de3c46204f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 01:55:02.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82C5MvcM3tDTG6Znbqbx+RU4LVNppfSYjTMmfzFC9fPOqEeVwUBFXNtRrFR7wFIw17vsvHOxPSJX9q7iTIMXgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF6469DE8C6
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Using multiple statically allocated buffers to store virtio indirect descriptors

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.h | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 9c273739d6..b0f236f049 100644
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
@@ -46,6 +53,32 @@ typedef struct VhostShadowVirtqueueOps {
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
+ * Pre-allocated indirect descriptor buffer
+ * Each SVQ has two of these buffers for double-buffering
+ */
+typedef struct SVQIndirectDescBuf {
+    vring_desc_t *desc;         /* Descriptor table size = num_descs) */
+    hwaddr iova;                /* IOVA of the descriptor table */
+    size_t size;                /* Size of the mmap'd region */
+    SVQIndirectBufState state;  /* Current state of this buffer */
+    uint16_t num_descs;         /* Total number of descs (N * vring.num) */
+    uint16_t freed_descs;       /* Number of descriptors available for use */
+    uint16_t freeing_descs;     /* Number of descs being freed from used ring */
+    uint16_t freed_head;        /* Next free descriptor index in this buffer */
+} SVQIndirectDescBuf;
+
+/* Number of indirect descriptor buffers per SVQ for double-buffering */
+#define SVQ_NUM_INDIRECT_BUFS 2
+
 /* Shadow virtqueue to relay notifications */
 typedef struct VhostShadowVirtqueue {
     /* Shadow vring */
@@ -96,6 +129,19 @@ typedef struct VhostShadowVirtqueue {
     /* Caller callbacks opaque */
     void *ops_opaque;
 
+    /*
+     * Pre-allocated indirect descriptor buffers for double-buffering.
+     * These are allocated when SVQ starts if VIRTIO_RING_F_INDIRECT_DESC
+     * is negotiated.
+     */
+    SVQIndirectDescBuf indirect_bufs[SVQ_NUM_INDIRECT_BUFS];
+
+    /* Index of the current active indirect buffer, -1 if not using */
+    int current_indirect_buf;
+
+    /* Whether indirect descriptors are enabled */
+    bool indirect_enabled;
+
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
-- 
2.48.1


