Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACCBD1D87E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3vy-0001df-Oa; Thu, 04 Dec 2025 02:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR3vw-0001dB-VG
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:39:25 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR3vu-0006PV-On
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I98k4AyFhuSIRQ9VYPtzjFl7yr7wgtrd0rR/UY4s8FJdZODwN0Knn/FboLJieO+E3t9Dm9MYKUG6lhSakomEmMSygOYGfhr+bS6JfPcnwPyFIsxh1/Culkw6NDBQvOTEL2z00XoQMPTSU8XA4t6HT4otOS2RNc+n7rqbW/MX0glvy3JEyXf064CF5d58i/Fjg9OBUdkHBaFQOy9QoPLegbYf5Ct6DVtooMzm2AOgD6IkYrpxT5RvrjsZhW6dBQ70EIFNsBNCeu5S50cwZKKSkOVz88WdtXiAH1tTh3ovI5CERr2c2mVA8u8DW7Ks46++DVL76M40xrj+1pYyS2ZF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqD0zEESEZbstAr1iErFfnNpBnex1zU7B/z2ccP54RQ=;
 b=DllCtLPr9RnwqLKwMhjJ0An6lkP8b6WYuuJja23q40mvDvuaCGLN9ooYLr/YdzkrNWIDjPrfH5A4mxPXWeXInwLWmX8dOZTG8OIjfH8kIPu4bEEfQGVQJiwt1S2JM9YzcpuE8FRIJFhbola8ovzvqN1pHDWNXdt1k/MGdSkoXMBnUCjWPDhJp8QmE7LhjPHzt9YVMtPBIITavgAsUWE49fN9MXi9djPNcPlFJxoUwbfjqckLOyHTPZLA7mzL/QsfgdGv/F39bkhZ4l13x96o0bqcEPP/Or/PrEfugV71v01vUbDgBQZHJ/yNBm1LyPiGpiGqcr+xzjokS9sZFn+W+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqD0zEESEZbstAr1iErFfnNpBnex1zU7B/z2ccP54RQ=;
 b=QA0rfOHl2ITreV8lO+v4govEqhcharltjr0ZnmlDsOfzjjusDlOphnljEWlbPm5o9TdTQ2WeQhZYCSN923/vynbEEWqar4LQYlTGLErkcloSLV78akw6YXgZ8TUoBzJyhKJejeDyTIOJxn4vGRq67S1h3A4GJtVlZHKWDAEwqE687gOQRQDDrO9tF3OlfRGGRpolrFAvqLVBVULYZUNjI0jZ/j2UKlLU4t84vZ/wtfLCK8ekOU0AjYpx4Yu9dWt9KJCplcOiSVxdyg/8bmd98S5/iXFFaissifpRGDH7zzVTUVXnrIhy6vRLFmUMpWkyIozO1CWSjGqznDZXp1yutg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by KU2PPFDF24F4212.apcprd06.prod.outlook.com (2603:1096:d18::4b0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 07:38:46 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 07:38:46 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH 2/4] vdpa: implement the interfaces alloc/free for indirect
 desc
Date: Thu,  4 Dec 2025 15:37:48 +0800
Message-Id: <20251204073750.8953-3-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204073750.8953-1-wafer@jaguarmicro.com>
References: <20251204073750.8953-1-wafer@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|KU2PPFDF24F4212:EE_
X-MS-Office365-Filtering-Correlation-Id: b025b369-40ab-4d76-5986-08de3308283e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nd9K5ciS0Ums8TU27I0WEk/DltsbE9IMpvYMXaGV8gUZ4IjBBsfdTCN1bk0h?=
 =?us-ascii?Q?NIlLZxH3RYXT9L825ZsQtsoxbFseyoSqbnrn1+UCHoTJGZ9pBOVQReHA14nd?=
 =?us-ascii?Q?2QVy21HPBuOBBk+nIGEQEz2sAF4upDEEGfG+vDUw+LNAYcQqQGodM2fpq2he?=
 =?us-ascii?Q?YmycPUs/9m3Eoopd6jiKyTQrQ/6kMyTH6H1IQsm9N0YGGyy4UPx6iQ0dWCPG?=
 =?us-ascii?Q?yqyK45wEDUDck7dt746ZJDIsWMnDDA0aK5c1qSMAn44JMQpxh3lsoVJeeIea?=
 =?us-ascii?Q?c1szmBG1GLs/q4y89972W2qs2G7PtbIA3fyQsBOkKnzigfEGJJUneOaY3hvD?=
 =?us-ascii?Q?ZnyqFDMcsn8ekUnd/6Hu3gxz+WUFXVzxJSLb9mt67XiYxCLznsbDqc/Ta4BF?=
 =?us-ascii?Q?dT3rwv9EJyrs997aKlI2PSZ5mJ8qRycSHz35ekpOxmy1nE2V+QDXVn4mL64O?=
 =?us-ascii?Q?HxMBlRqTBpnnIKWQpWCxEDOGWAPbF7rLwpekP88cVBQOIRM3K9GpNXvGcTJq?=
 =?us-ascii?Q?zIgBLlw/aqn8jBOttKEB7hGgRl/39/ff9NDKMZFz7zc9/q4bKzRMxkNJm6Tl?=
 =?us-ascii?Q?ype5lxLZGRkjPpUQ8BrHRp/k3Hwen13jeyvD9w67AVX1/j9yqJgvUd4gapEl?=
 =?us-ascii?Q?cDqMF98fR7Msnbh2hkn0Dloe7pnoL2xihjbkhuKWdpvDnikBVXkzyudzbEza?=
 =?us-ascii?Q?jGZC9OHeI1XhHs85txbNiiRCkY/p5To8t1c8p9Xmx9sLL8ji9NEm5oJxSQ4n?=
 =?us-ascii?Q?vIio5fpP2RA0csw+B8k5JMaz/b4fIn7PH23/AWTEsSW2HjR3wGEWzMisvN1S?=
 =?us-ascii?Q?/2Wc9LNzHonFse2LAxcIhho5TX0JQfmmDL5ZoLj1zP/4Ci0f9/A9xuiyoLsW?=
 =?us-ascii?Q?rxcqTDnI7g96oGcb4ImLsUrWXTNmSI0o62G9/0tbntB12aJpLJwoi0g0Wko3?=
 =?us-ascii?Q?B8k7U+vVo3SOp9+9cGybgikjgKcb6tf90lvtUU6tP1BnK5czT+Xc6j+EzraN?=
 =?us-ascii?Q?kyZW1p26VHW6jA/3ksnwb4mfQARmIadtuOV8yBZvrNjGR/MunLYk+0Sjo4TX?=
 =?us-ascii?Q?vBsbhLpzeRMUdrV7DIgTI2SeylSlmn37qnGAK8hWdzFJrDWVzNVU+GZuQLWw?=
 =?us-ascii?Q?ZSF+b1XtTT2TBj7gnFOUlVK02q6BtvtWJKS2fpTl8Hzs0MN+nWarzMxENWao?=
 =?us-ascii?Q?MwRDkV/ZG8iu0xk/ttBpT2DQ0xdnTdhHlzMu5q8PdVNZ+PsvfUe1dJMZjSTP?=
 =?us-ascii?Q?imm1X0+VdDd0XftB4k8pkObPc91T42bjWf+nRgrV+aLN2MlKsTqRLPipJqrE?=
 =?us-ascii?Q?wVaZf87YW3niftTEZ8EfG6AawFDIu0U5uMhr6/hq7w3na19tRiqkYh3p2iZ5?=
 =?us-ascii?Q?7Ujiyh8+Y7LwIxMpO3xbccuvPAw/mhEnOX4R1YwX98zVEikL7BUCXGSjsEdR?=
 =?us-ascii?Q?d94WBC2acOSHu2W5pZ0eTFC1d5Wd05/SJMn/WeAqnuKyNw9qgH2lQcNFJ+Ah?=
 =?us-ascii?Q?rYhZcFvh+B7QB1/mubkGkxCpmUqWTWT03Pwq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6JKaAs+mMcoPTNkKU+ICZ3LqnPmcTW57+s3tOY9wRQCRwYWEwhYYTkVT9HF?=
 =?us-ascii?Q?S1YnzQov6l+pYqPa7dZ0IZaosxgMe1I7XMM3doLUNv+GIWd/oRXJhhtrQUSW?=
 =?us-ascii?Q?85fYoM1yATi358w4Mftgd7dCMHBSuqgpbLDAXl4HxcfqxPOWAhKPT73jQja5?=
 =?us-ascii?Q?olWZXz5O3v1lpAJk6Ycc03qPyp4WC2IrH09kmWlopGhnflrVMY8MnhBSapXk?=
 =?us-ascii?Q?4oA/ULKxx+NwYqKVtblyCJ0yiJlETYvhY/AQihsB88M7bDeSNrFBO6OKx6nd?=
 =?us-ascii?Q?MV7+KJ5bcIvRpxR7Hb+i2bHiflQoNP/6LUowDi5FeSbPVymdNPaIOLOw2g/j?=
 =?us-ascii?Q?QRGkDAJCrz0GNFNoADEJNP2wwAfnw72Pm/Pf7cfReIaGyYkhrmi8VFLZ9VPy?=
 =?us-ascii?Q?uE2EhobKbqaTM6nh1nPH2asGdPJyhOjEqYnMKHF1kHY1Ksz/sgcjY5pwPJTd?=
 =?us-ascii?Q?N9yyNQpFQWtEZCYnSml1FPzxx8YgA7XfUEmETrcjITT2K0A9A+ed/d3wx24V?=
 =?us-ascii?Q?m0fAikwKFXWiqBNfWfdb4FwkvpbyfSpedSvp+k+3VA1PfNLVeYE7W61LteuG?=
 =?us-ascii?Q?dCy9PVe4IF22WDG5GURcHbFOtd9JcBu3PQydhcsjDUEwjdAc4EeQ5Zl9wmbW?=
 =?us-ascii?Q?fboPxnBDZEmraFtFP2Ywh8q65dRJZFdkQXqNsfDid6bGWBPy0vTuJLMedQDH?=
 =?us-ascii?Q?+fxniEDBPECP5zN+xHcvcYkhlwEeV9hpnXSTKI7aY4AtoAhxWg5LWP194sF9?=
 =?us-ascii?Q?hbDPp1t7axB3mnrUOxQtmd4eOfLdERTsSIHd8G48yaCiLulVZ+C8D6adSYt3?=
 =?us-ascii?Q?qHKucO5XKrhxAymwGHwwSoW3HXCu5iNf1Up+TnZYF8ZLEgtQlROjkaaHfsM5?=
 =?us-ascii?Q?N8iaK9vk0VgGZhsQtRklOLcbrCW4QCWF0W7g8mhwZDU6+iweUKrstygpnx1V?=
 =?us-ascii?Q?fYLgOtdK3UPLaXg0AMNvvPNbSeEO97lscUavHm1qs4fOv43kJ/0HPYUkTGbC?=
 =?us-ascii?Q?iwaQSTovfXHqCof7QsjkAnhyBJf7kKj4I/LwSMLf+hy/yszx1EKW0mWBXogc?=
 =?us-ascii?Q?kw2w8SJwUPhCpHDd686hz6/W5vzLyA3aqiOe1qnB5ydcPgGWFY3e8/Ol7uaM?=
 =?us-ascii?Q?Ki2/88A5+JQwX7DZKVQ+njomRrfq4iSeseFTIV4ISv23QHwzw84tnsXvgw1t?=
 =?us-ascii?Q?kTC/mj3Uk+3CDlNzfWoF7aFaTUdNAwHAZ0IkOlnO1NCZD8R0SgjDKTrE023x?=
 =?us-ascii?Q?i96A/E4GFTcbjgA2nZWXkjKZciGdYcpDL2tK7qYP406fw6m5x8UNmVecjatP?=
 =?us-ascii?Q?QUpNrvhVQHzOfkQ/3xR+m6UyaHYO9durwAzRVVU0AvTfGCh3Ys5UfmvWce/y?=
 =?us-ascii?Q?yo70bq9jbokiT/oDcGN/IRsdtM9rmhGxnC8DvwIASkiMLykjPleFXlYRniZE?=
 =?us-ascii?Q?mm4HWfKihcEaFW+bJE2IYNSUn9EpPRC0rd6gxB1Nte7LkkysjtmSFk9v711M?=
 =?us-ascii?Q?+2HPcZPH/RUSuIqUGdKy/kRQfGuOOd1aUXG5CPi8mqEhCRkzHsIIpgoxC4FQ?=
 =?us-ascii?Q?R0yxo8NdDfkUhVWidshM762NJbqPjQ5LiKqwSxWJ?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b025b369-40ab-4d76-5986-08de3308283e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:38:46.4217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4cHXeUInVtpmc5HW9McIVWhVhwGvvtUNwirSor35yOp4byqAiYBO9mIlaaGK/nQLKV4pgMsWvOtYD7/jhpvSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDF24F4212
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Dynamic Allocation/Free indirect descriptor.

Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c |   5 +-
 hw/virtio/vhost-shadow-virtqueue.h |  49 ++++++++++-
 hw/virtio/vhost-vdpa.c             | 130 ++++++++++++++++++++++++++++-
 3 files changed, 180 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345..ecc3245138 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -756,15 +756,18 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
  *
  * @ops: SVQ owner callbacks
  * @ops_opaque: ops opaque pointer
+ * @indirect_ops: Indirect descriptor operations
  */
 VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
-                                    void *ops_opaque)
+                                    void *ops_opaque,
+                                    SVQIndirectOps *indirect_ops)
 {
     VhostShadowVirtqueue *svq = g_new0(VhostShadowVirtqueue, 1);
 
     event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
+    svq->indirect_ops = indirect_ops;
     return svq;
 }
 
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 2b36df4dd5..c5d654eae8 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -54,6 +54,49 @@ typedef struct VhostShadowVirtqueueOps {
     VirtQueueAvailCallback avail_handler;
 } VhostShadowVirtqueueOps;
 
+/**
+ * Callback to allocate indirect descriptor table.
+ *
+ * @svq: Shadow virtqueue
+ * @num: Number of descriptors
+ * @desc: Output pointer to allocated descriptor table
+ * @iova: Output IOVA of the allocated table
+ * @size: Output size of the allocated region
+ * @opaque: Opaque data (vhost_vdpa pointer)
+ *
+ * Returns true on success, false on failure.
+ */
+typedef bool (*SVQIndirectDescAlloc)(VhostShadowVirtqueue *svq,
+                                     size_t num,
+                                     vring_desc_t **desc,
+                                     hwaddr *iova,
+                                     size_t *size,
+                                     void *opaque);
+
+/**
+ * Callback to free indirect descriptor table.
+ *
+ * @svq: Shadow virtqueue
+ * @desc: Descriptor table to free
+ * @iova: IOVA of the table
+ * @size: Size of the allocated region
+ * @opaque: Opaque data (vhost_vdpa pointer)
+ */
+typedef void (*SVQIndirectDescFree)(VhostShadowVirtqueue *svq,
+                                    vring_desc_t *desc,
+                                    hwaddr iova,
+                                    size_t size,
+                                    void *opaque);
+
+/**
+ * Indirect descriptor operations and context
+ */
+typedef struct SVQIndirectOps {
+    SVQIndirectDescAlloc alloc;
+    SVQIndirectDescFree free;
+    void *opaque;  /* Pointer to struct vhost_vdpa */
+} SVQIndirectOps;
+
 /* Shadow virtqueue to relay notifications */
 typedef struct VhostShadowVirtqueue {
     /* Shadow vring */
@@ -104,6 +147,9 @@ typedef struct VhostShadowVirtqueue {
     /* Caller callbacks opaque */
     void *ops_opaque;
 
+    /* Indirect descriptor operations */
+    SVQIndirectOps *indirect_ops;
+
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
@@ -143,7 +189,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
 void vhost_svq_stop(VhostShadowVirtqueue *svq);
 
 VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
-                                    void *ops_opaque);
+                                    void *ops_opaque,
+                                    SVQIndirectOps *indirect_ops);
 
 void vhost_svq_free(gpointer vq);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(VhostShadowVirtqueue, vhost_svq_free);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..1719993f52 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -584,15 +584,130 @@ static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
     return ret;
 }
 
+/**
+ * Allocate indirect descriptor table for SVQ
+ *
+ * @svq: Shadow virtqueue
+ * @num: Number of descriptors needed
+ * @desc: Output pointer to the allocated table
+ * @iova: Output IOVA for the table
+ * @size: Output size of the allocated region
+ * @opaque: Opaque pointer (vhost_vdpa instance)
+ *
+ * Returns true on success, false on failure.
+ */
+static bool vhost_vdpa_svq_indirect_desc_alloc(VhostShadowVirtqueue *svq,
+                                                size_t num,
+                                                vring_desc_t **desc,
+                                                hwaddr *iova,
+                                                size_t *size,
+                                                void *opaque)
+{
+    struct vhost_vdpa *v = opaque;
+    size_t desc_size = sizeof(vring_desc_t) * num;
+    size_t alloc_size = ROUND_UP(desc_size, qemu_real_host_page_size());
+    DMAMap needle = {
+        .size = alloc_size - 1,
+        .perm = IOMMU_RO,
+    };
+    vring_desc_t *indirect_desc;
+    int r;
+
+    indirect_desc = mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
+                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    if (indirect_desc == MAP_FAILED) {
+        error_report("Cannot allocate indirect descriptor table");
+        return false;
+    }
+
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &needle,
+                                  (hwaddr)(uintptr_t)indirect_desc);
+    if (unlikely(r != IOVA_OK)) {
+        error_report("Cannot allocate iova for indirect descriptors (%d)", r);
+        goto err_iova_alloc;
+    }
+
+    r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle.iova,
+                           alloc_size, indirect_desc, true);
+    if (unlikely(r != 0)) {
+        error_report("Cannot map indirect descriptors to device: %s (%d)",
+                     g_strerror(-r), -r);
+        goto err_dma_map;
+    }
+
+    *desc = indirect_desc;
+    *iova = needle.iova;
+    *size = alloc_size;
+    return true;
+
+err_dma_map:
+    vhost_iova_tree_remove(v->shared->iova_tree, needle);
+err_iova_alloc:
+    munmap(indirect_desc, alloc_size);
+    return false;
+}
+
+/**
+ * Free indirect descriptor table for SVQ
+ *
+ * @svq: Shadow virtqueue
+ * @desc: Descriptor table to free
+ * @iova: IOVA of the table
+ * @size: Size of the allocated region
+ * @opaque: Opaque pointer (vhost_vdpa instance)
+ */
+static void vhost_vdpa_svq_indirect_desc_free(VhostShadowVirtqueue *svq,
+                                               vring_desc_t *desc,
+                                               hwaddr iova,
+                                               size_t size,
+                                               void *opaque)
+{
+    struct vhost_vdpa *v = opaque;
+    const DMAMap needle = {
+        .translated_addr = (hwaddr)(uintptr_t)desc,
+    };
+    const DMAMap *result;
+    int r;
+
+    /* Find the mapping in the IOVA tree by HVA */
+    result = vhost_iova_tree_find_iova(v->shared->iova_tree, &needle);
+    if (unlikely(!result)) {
+        error_report("Cannot find indirect descriptor mapping to unmap: "
+                     "iova=0x%" HWADDR_PRIx " hva=0x%" HWADDR_PRIx " size=%zu",
+                     iova, needle.translated_addr, size);
+        return;
+    }
+
+    r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, result->iova,
+                             size);
+    if (unlikely(r != 0)) {
+        error_report("Cannot unmap indirect descriptors: "
+                     "iova=0x%" HWADDR_PRIx " size=%zu: %s (%d)",
+                     result->iova, size, g_strerror(-r), -r);
+    }
+
+    vhost_iova_tree_remove(v->shared->iova_tree, *result);
+
+    munmap(desc, size);
+}
+
 static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
 {
     g_autoptr(GPtrArray) shadow_vqs = NULL;
+    SVQIndirectOps *indirect_ops;
+
+    /* Create indirect descriptor ops */
+    indirect_ops = g_new0(SVQIndirectOps, 1);
+    indirect_ops->alloc = vhost_vdpa_svq_indirect_desc_alloc;
+    indirect_ops->free = vhost_vdpa_svq_indirect_desc_free;
+    indirect_ops->opaque = v;
 
     shadow_vqs = g_ptr_array_new_full(hdev->nvqs, vhost_svq_free);
     for (unsigned n = 0; n < hdev->nvqs; ++n) {
         VhostShadowVirtqueue *svq;
 
-        svq = vhost_svq_new(v->shadow_vq_ops, v->shadow_vq_ops_opaque);
+        svq = vhost_svq_new(v->shadow_vq_ops, v->shadow_vq_ops_opaque,
+                            indirect_ops);
         g_ptr_array_add(shadow_vqs, svq);
     }
 
@@ -789,10 +904,21 @@ static void vhost_vdpa_svq_cleanup(struct vhost_dev *dev)
 {
     struct vhost_vdpa *v = dev->opaque;
     size_t idx;
+    SVQIndirectOps *indirect_ops = NULL;
 
     for (idx = 0; idx < v->shadow_vqs->len; ++idx) {
-        vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, idx));
+        VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, idx);
+
+        /* Save indirect_ops pointer from first SVQ (all share the same one) */
+        if (idx == 0 && svq->indirect_ops) {
+            indirect_ops = svq->indirect_ops;
+        }
+
+        vhost_svq_stop(svq);
     }
+
+    g_free(indirect_ops);
+
     g_ptr_array_free(v->shadow_vqs, true);
 }
 
-- 
2.34.1


