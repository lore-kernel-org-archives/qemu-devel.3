Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334B3E65D14
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 02:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEJ4H-00019D-FP; Thu, 21 Nov 2024 21:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tEJ4D-00018v-2j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:06:42 -0500
Received: from mail-psaapc01on2105.outbound.protection.outlook.com
 ([40.107.255.105] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tEJ48-0005qb-PJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 21:06:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8x+JqtR2/neakaq6RxQPBbD/Q/cD2Yx8bEi2rAbxz4cA3ZMuiioReca+i54/9p+374oGgnJeaOBfopIzFPa6TzWxfQdNE/nqESsKvADErf7gYPPuMAbtgCabLvUIsGl5RphyZX0Rh10fTHElxlBmJ4GhpwYsK4yP0GhTx7jYTZFVhp6coa9utujuxuMUjclQe/zYjjnjCyIpLJkaoNNaPmB+EJNnNW+1BEGfFt5QdHDL8Hahj1DLRhWBKd3MzdERQsdRErQCqj1neSfLMnfqMsIzDXlAfgvVPwXm0Z+BsRiYTWBR++9XXvK1cCfxk8u55iBs+MDjqMZLImTWN7pbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDRNaBhsdGNP7c+rFnvXi7rATKTb1Z6ndlel8sb1NIE=;
 b=H/UP0/NR1KDygi4LAn1pyBGZfnhY1SO/4kD07jcUf8tzAodIUpTpBILH3FNYQ1gXjC59siV4+Co6aYaawIYQwvMOlGDhu3OLc0tp8Ph3cI+Jwuwye0r/39FufFuagWK28j4377aLneVk/cEGyTTgytsjm7LZ5H7dEOzo2hgi2HKWLo0oH1sVhiXMJNqclBdJCXn9WdHTpPxsQCj2uSeOnOHO/trsE9ZPMIXlVETUYwINAvEDPEiVA3zeb3/WTyhGwuzoAot8p8IyJCITtKUhokImUY7d55SITN+EabRDq25mZ4jgcyP5UyRrAMR+3IiaJuzmdAvTU9hr0/t+pP8kXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDRNaBhsdGNP7c+rFnvXi7rATKTb1Z6ndlel8sb1NIE=;
 b=AThLQV1q7GHQ3T+Jv+BfZKXKYRay9+yNdpLzBTAB+3/lC8mjo12JdAER9FMKmogdKTHLzmjMASJ8qQUmxPhG5sox25iXxNAZwQPNVxGNepDPjyVFqTSa15dSck2Qi9Uw4kgmDQnomn3/ppgcKSihVj+E4j6ivjZpoZVEI8H869PJBBKry3OWg4xv44m2eMa6ZMOVIk2+FBaSif8AOgzr3hbFghlHl6TYhEsPRoAqYk9QEWOqovKBpUIikwGEIMCmALMlWOn0/AAGJIMB8tcbzVStgIs8PRg5ZfQTBgDP7vkzFw/btgYkwkznHhbMVqrNmZrzFlAtSU//9rttiT1pfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEZPR06MB5198.apcprd06.prod.outlook.com (2603:1096:101:72::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Fri, 22 Nov
 2024 02:01:14 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%5]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 02:01:13 +0000
From: Wafer <Wafer@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	groug@kaod.org
Cc: eperezma@redhat.com, qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Wafer Xie <wafer@jaguarmicro.com>
Subject: [PATCH] hw/virtio: Fix getting the correct ring number on loading
Date: Fri, 22 Nov 2024 10:00:02 +0800
Message-Id: <20241122020002.564-1-Wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.33.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SEZPR06MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a6851c-6063-4ed5-a1eb-08dd0a998ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QnpSoV5Hk4jdIYLGPvpCVWKjSQMuAYD5Lqzm9VpCBmuomUoJowlAJBLvKLnE?=
 =?us-ascii?Q?LIFtD9coN81SEp8v7+zMnHk3NyGT3We6Mq0gD0rEIt7JXF4q8+A0QTz70M0h?=
 =?us-ascii?Q?SOCFqzZWnDgBdLhTW9DFdESlkQJ4jAX3XLqjxL/y7R/zxFcFkj0jq9lpDuRp?=
 =?us-ascii?Q?2qTlbl67JpGTM1VpAp2/1vdJzktzMC9+L2ftLLe30STQirToLYACpxy0b9eJ?=
 =?us-ascii?Q?U+Us0oMKiyKMYlZWlE7sa42IBGkMUc/mU/SmfjD+NotnYcQUOqO+NQT7XRJD?=
 =?us-ascii?Q?p7Xuk1DunsPTUEX+4n5lUrQjisKxCmOGLCYmBr14D0d1CdFaFm+2jvjcjhMI?=
 =?us-ascii?Q?eI1HsGnjPgLceB6s2ww95zWXe8KR6sabSlOPO275qS0qSkJkS0ehJ7YJrKbl?=
 =?us-ascii?Q?QG8vRBwJUPQaviZa7UMglophTtBClyF4D4HjJ1TsuiEt1ekhLxS2RNsFtLoz?=
 =?us-ascii?Q?almXWH5LqDjXiwY13rV9f1IiMidtiS0Z2jZ4Mo2G/V9macGkbGY2CQAxCqJt?=
 =?us-ascii?Q?6DITDaKbyW+YUquG7cS5aef2UTWavyE/MpBRZK2Xju15s9L7ECa4K/rubSEW?=
 =?us-ascii?Q?REK1fXQOF9HZj++QgzCR3XcRtdId3ZwlHX/nn3mQC50jWFUFsFlD4okaBWbk?=
 =?us-ascii?Q?jH7EERK9ziYiirQHs3F+oYJtvJUv2hexuSdv4UloRXymC6Le3zBVHQ4gYMTF?=
 =?us-ascii?Q?IZ7FwH2EhpZUQcMf7eQiUNSkFzV59I7nCjKsKbnz+ClMips/8tpZ8GNqSqVq?=
 =?us-ascii?Q?V2I4orsR3HsQz0IQdhcJgMGWNuLWeDVG02GVYx2Ill+C10b+ceS+Uq7qXzL8?=
 =?us-ascii?Q?RbZ7j+P5t621ih4ibGCCN4WMeJ9J7kg6XqDKy0pps2TWXaV0DvMpkUHEtaHW?=
 =?us-ascii?Q?1+fjmWeYrFlw8cDr6NHtW3S6VHNoKgA49cpzkuR5cQChoXC5zwyIzFZp9fPg?=
 =?us-ascii?Q?jHlVIyQzjaMEwiAdXahg1hfHAxfP415P7nlz1KkxJfNVvygd13fUf/hBmd73?=
 =?us-ascii?Q?HHXWZ1CZsN2L8QjmkZDP59f41MTbu2xEfwI2VHryZ6jFMfZVUnT0mWKLJRVx?=
 =?us-ascii?Q?diFB1AFFu9SnDS0QMSFpxE1Ir2kZd5oa6QDTYsghJjFN1DVX3SVd9gIW8aCR?=
 =?us-ascii?Q?o6Sa9RYTky8aEsiG7NdoAJJaj936O2EqiwtP+tHSTTtL05hZZDMNQlYhEnVh?=
 =?us-ascii?Q?VnqBREgkdvAPw8Bf2hkkGXzWgIuec9v6D43x7xW4iH3nh6X2tdEhXoc1KEus?=
 =?us-ascii?Q?QWoVHzsrQPZSdwL1YMi74u2VrlNbSyFSffEWQI0RK/BRHsyQYxT9k0k2E31D?=
 =?us-ascii?Q?x1u0UE86ieBAnYKvxPul/wBk5vGgLkWLceXSjm1qNZE8nPR6sBAFwqlsPN9M?=
 =?us-ascii?Q?L/Zeh0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0j23SBSS83uaHTNDdR5LfL6N8nelhMWDLtSpYasNaYjUwdtnIXO+9W5hnTQ?=
 =?us-ascii?Q?7ZPqkl8W5u7XEaTCUmBifvFat/3FpCo/Ua+UyCpV11CFv6EgM6fZ6cevl6+a?=
 =?us-ascii?Q?i21MP0Nj1zHRb7+Z43fK31mXZf9a+1NNyf6OKewRSLJxdBAj3skF/NBM+uYk?=
 =?us-ascii?Q?SoiVzUwhaTtmYlgJoY5TXTegUXp/27GrU6tRwDsrEbwrT9YSv45UK0trOnfb?=
 =?us-ascii?Q?Nu7RmQ62v+9btwQ/+8lfWxbUQwueyICEJA6teCoC/ni3kk6KXnnTEmrX3hHA?=
 =?us-ascii?Q?Ebatw3XeQUdUVwl35GjcYOfYaYcCvYz5jM32Ugv5ygB66F5n3Wo08M3H4fD7?=
 =?us-ascii?Q?1YZldQKRX5F0E06BvptbggbfDVlV38iACRfT/Lr85lzNUT2JCmCAeKAuilwb?=
 =?us-ascii?Q?muBuXoADolkd73dwPPRZOSxRRbSkEMeGRfhiqdiaJekwe9zDMS/MfO0L6uIz?=
 =?us-ascii?Q?J2U9nrSU3A2rK0L2s2pQvVTzVp6feo0711WlfUMH+lCheeIQ/mFmMqgYNIll?=
 =?us-ascii?Q?9wOuc96j5WHEPcC4NE3QeIqKmnQA4vRBMdPk/L2qwyqV4Hsh7EMiQaFiVbkD?=
 =?us-ascii?Q?pRAFSVFaqlJ4VQ6i+ly3HBs8RIhh69dSGdETZ3BRwR6UTxHrbdAeSNU6r7W4?=
 =?us-ascii?Q?E2rxl0PVY5xK6br+51+IFIpsyj8eBFI5qgfX7NYWEiBfqTvj1hFpIFYkFmVZ?=
 =?us-ascii?Q?/26zZPtEW1mEb7VAVyjaGKbroFRLcRb2LKLr8q+Cxf92pPu5ApfJN/+tpcUc?=
 =?us-ascii?Q?3L7Hxydx9G7NnDRUWslMG1rrZ0aQla5pilthR/f6Cu0gxqa8RgpscEpb5+bt?=
 =?us-ascii?Q?D9FrJq/hdc8HAKYGiGomYMOubT4q2enu/IRZDWmzGrZZYFeManpR2m5b8Ouw?=
 =?us-ascii?Q?OBKflQjjpOna0VohrcXEboWFl+5+2sKqwkyLeonF+Szx7oiJnWAtcS2U3uoC?=
 =?us-ascii?Q?XodX6fw7IlaZj/4uFnxEz7s6UZaliOjJ/IrSLd3EyklR237q+MyQGrl2zOk9?=
 =?us-ascii?Q?+TzBj/7tVECt/xISTlrwQ6My5vc0b9ITKtrlGl3HfjGcxKJvn4pQ/EhPQIuM?=
 =?us-ascii?Q?5OL9l+keuGs+97AiNvnId+XpqMQlWAgAvVv4rh9pMV+mcIrXVHQaFBiN6MXp?=
 =?us-ascii?Q?4o0O0lg0mXvlOMAL3vDy56P25EX3vKbyCICMQe+X6BmSajC83xK9vJArkK+p?=
 =?us-ascii?Q?HAs2fOtcAKRYMViSkK/L1+1eqng8/ZP4eMXAW61Us+CVrxak6hjxZ2GlGi9A?=
 =?us-ascii?Q?VpOEMgkgpku/FSLfNAL6GAsQOyFyUYBH78Hb8oCMxPk5LIrw/O7PbC/DirL4?=
 =?us-ascii?Q?MH852EzBQl0749XrnfakK4QRnzEHURTfoRqKiH3+wN5OGbNyV/qJVXDnA/Am?=
 =?us-ascii?Q?AV/a7eV6MPirJC+5+j5fjmBsesbE7Z/JdPKCqvLeqzHcPzt8n3XB0vEtuFIT?=
 =?us-ascii?Q?8GjfypBpG97jbqp4cqXuWmrRJSfRjEu2z1B8FaQx3huwiPluGop+8ziGXoSj?=
 =?us-ascii?Q?rR9D1hu/a09Jzi2oHWO+CrooZmjsrapYVZzL5H4Mk5MD1Jyl1QqlYL5G51JV?=
 =?us-ascii?Q?k80agiR+XmAHvhjt7386d4LcKtACjkoMYcmAwr5Z?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a6851c-6063-4ed5-a1eb-08dd0a998ae6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 02:01:13.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leiU9cP1qPblOF3fFymxXLwwvE3OPYTgmbWCdvZCnmDDhKzRc9MsJBODE6SFuqGEDBLn713r2+E0AcSyo1vtgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5198
Received-SPF: pass client-ip=40.107.255.105;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Wafer Xie <wafer@jaguarmicro.com>

The virtio-1.2 specification writes:

2.7.6 The Virtqueue Available Ring:
"idx field indicates where the driver would put the next descriptor entry
in the ring (modulo the queue size). This starts at 0, and increases"

The idx will increase from 0 to 0xFFFF and repeat,
So idx may be less than last_avail_idx.

Fixes: 616a6552 (virtio: add endian-ambivalent support to VirtIODevice)

Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/virtio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a26f18908e..ae7d407113 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3362,7 +3362,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 continue;
             }
 
-            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
+            if (vring_avail_idx(&vdev->vq[i]) >= vdev->vq[i].last_avail_idx) {
+                nheads = vring_avail_idx(&vdev->vq[i]) -
+                         vdev->vq[i].last_avail_idx;
+            } else {
+                nheads = UINT16_MAX - vdev->vq[i].last_avail_idx +
+                         vring_avail_idx(&vdev->vq[i]) + 1;
+            }
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
                 virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
-- 
2.31.1


