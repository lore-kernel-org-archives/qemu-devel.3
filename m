Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F24C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkIK-0008Ix-P6; Mon, 11 Mar 2024 14:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFC-0005at-Vm; Mon, 11 Mar 2024 14:19:27 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF8-0006sy-K7; Mon, 11 Mar 2024 14:19:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzzDJGXPqp5lmsKfn4Qmj+HEE9gsmHag1XoXv8cRd3LENoiiDzxuQaadKINRED6mwT3p5lWqsEcc7d62+WriwRn8R8XcpElEd22QM6NLpb85kwxgYsIdOTVXrJ216GsnLBarCx7/+FChiilnCPV1t+8KxT1sU4ZMuD3/aVXk5P1CJncoRUBsT85KQNXd4LH+QzKjtbg2vOKzdrh7UDwj5oiZw0xTAtfy0+ZprIBKmGpjnwphL/EvFpgHe3lIVNHxPp1OcPuJfszkv86IhwggckNMVD5cGGs7cpxtZtsuSAVcRFw+WIJszcorCntXTPfuM+w2t87TJd16ofbAwN6Sng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iZ76GSq1I9wVZxJ5o4dKziUHUsUXiKz+7P0U9aQHCc=;
 b=a9uceMxmGr7GQmI9tKvNNwDkKFIkui31FUo7CkID2qeLWkP+KPGwtTUKQrjI+cuGsWPPPu6xAoEKbYgDHTnfBx5EcI2X3n6eCUqdViUwyoI3gcEjRHAcpKzP5sIEEgMWe3can0B9FafxCUgzoOPPTqYp6ACqCXQEkvJ5Lp62UxCPNmjiSmqgelFMlO5NuTcOOzAWpWxpINIEwRvofIsEbwILMZekI/8gHRdEekAvOyTqLrDcFfBjNUUxHfvOX2EP1VfgEnPP6kkQomT1KkuHiUILIqBM7Eaz9Arru8K8v73o2zIxbAyVNGnPj+LeODxejHF+rqYhYwefT1uIRCFO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iZ76GSq1I9wVZxJ5o4dKziUHUsUXiKz+7P0U9aQHCc=;
 b=HOwqlghb1zzyujVMcxZoGjuGvpALYY8sEinXoMgMy9Ed92CW4nLh/qgrzysWrAz3ksoPMgo31iZt8akITUXV6CjgxmxF90oMTEIsjkQdIKz9DFWnuZRAuzvuOy6DMB+S4hxEaKkx18mpY4zqroytUVnKN4PfEdCF25jTPtELAffaHjBrXV5bFElyXagxs4wtJBMqo2vUJKQCOuLWqfXj01j22rosvEqqf6s46m88DUEE09OwKd48Xh5VnrFJs2oJJuFw1lDjGyWdxlKFn+ItkeFyUU3hpJ4LgSgbPB6CT2rmsAbratE4Hvyk9vkAUkBUTPhH7gfKzs+alkMv3x4hsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:07 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:07 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 13/22] parallels: Let image extensions work in RW mode
Date: Mon, 11 Mar 2024 19:18:41 +0100
Message-Id: <20240311181850.73013-14-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|GVXPR08MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: d9438d71-ed4f-41f0-98cb-08dc41f7bd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq28Ui0f+p1dSL66lUarXm3H1Z5xJprTrLcGjtg+XH3cP080m/ub4tGUMOaqqvlvaLKrOzex7kDU7R88nL//Xb/f/Qk5S8RPn47GtshoPNYSsDERZaFd7mBwQgFoj3kAfvaGZExV1c4tiA0ObKPm4cDmaVsBdwnvkCnvGaqkvsu2jyB0HFvbuKT+819Ap93ETDaeCL6YZdZCwocANAdJxBrB74aqfocOD4YN1qKe63sX0DxbM5ea1uQ87OWZMn4WFutgp5UHtnhxnWtVJefMC0LvjUrSWMx/QczFDq8STUDWsgdBpBDUFnFg9NB2IeaSBrHFhgBTy59E2ZwCQJEX8teF1EmySsSopAmPN/24lLeU1K/Q40t9iNpW6wjODQxMPJWqo6Vc6bNc4Sy1aHxoNeBAwXhB+qcDmuABCjQ+VxzWHqj/N6u3C8lYjvYwJBLRUmL6lsM+n7RJWqKoYXfugBfvraV2KA522D578EEdR5EE48byfdw6iG8SvjR1JtMQ+HlsZMj0P9OIhva77C2rUjGgTBis4QvropBghCDMt7KR+a0W/qXIrqbicDK2HUdzRz2KLfK7YqSPRD1esAtIhHww+Va0TivKk22riXmbTWEIRIx+XPIgnujg3xbIT6ZoTid44kmDAAiYN1qbh52FehlczCXJB0YrxKsBFP0AjrzBFOHALhKpg+1qfGypXciH2u2rS4WW8P9QRAp1UXZ7TK8pYbv7YpSJ57aEUkpM4nQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2AlCpKvwBVEv8KVyIEyMAg9BsYzoWRab3hNnCBx9555INfqYl2RtKQ2l2HHw?=
 =?us-ascii?Q?3bYFgzwLqNLo7d/dA/B3e3QS3xDlF3kyUpPL3yb4tkB/yIfb20TCd/3y4VQe?=
 =?us-ascii?Q?S0e4I5rkERfto6bKbwGjXbsrscfG1VpIqGqJ9Rhl82e6N6bNBXsnhQPzFSs7?=
 =?us-ascii?Q?WmkhVeaoaK09/aLSBPHmEKMg13juwt9f80d5McmZpkMl7tfgNon00l11Wnp0?=
 =?us-ascii?Q?CX+PV1wXYDLXbVqN11capY6UPz0KlHtxDkgdpDz5SF8qTrBZwstRqEbWKu0U?=
 =?us-ascii?Q?d0tyOuH4CkmaK/grNOZQxfzg7U0cb6RUqY8Iqctw8kKQUCwDtIbnaCMoShpV?=
 =?us-ascii?Q?XIbXRreUUnnYtfUz4STRJOxlYVsQDw4xwUunVOTl4f4oPxsPIjW63gjWC1E8?=
 =?us-ascii?Q?rMBzJwrzI3DQbH8kAf4nm2yg3Pmo4WhACckaOXiJVqEFtD2bfHSd9lK4Azmt?=
 =?us-ascii?Q?8fIexwRcWiMX0O41X4N28kr0DpRy+f+2AQxhs0UdOlCU3UjETGdvQj7rrHdd?=
 =?us-ascii?Q?Zaf7dh1mc0HQ92uuWY9R3pm3bsXOOL1J9GbO+Uykok3/AtwLWiODIkmml/UG?=
 =?us-ascii?Q?BxhS/P2zP1KPTQWmsUjQ91TiZLC3XJ/OMSbsQbADj7A6WfUlshw6OLbe3XmS?=
 =?us-ascii?Q?JUxvgPoNPzu3Ef/h+4aML8S30zu4zN0FpESZ7ZPBCRvdq+My31StF9+GcTKz?=
 =?us-ascii?Q?Rgf4+YE35s2NxIyd72ST3Lhyq5hl34ZfynuUW/RJWwJHLKdUA0NEeawWKahH?=
 =?us-ascii?Q?NwmcKDsDYOiNWVAt8Bes8d9f7mo3uGRDk2zAE7HxCpwVzZIuwg25e5qgUuOq?=
 =?us-ascii?Q?DRLilZu46zuxeG4ewSudPc9gwfQFpeAVGRjmlVcJP5uACxMxJWWInCS90odl?=
 =?us-ascii?Q?SPrRxXBSSD+sWthTGqR8QRIlYNFg25Y7yRhSPFq19SygUM0vLoK8eKxLsXoF?=
 =?us-ascii?Q?789IOF0UKL5/lG35cIcAnVdwNlFbZC3BXAWW7/V7eGiZRopN7XsujG/kk63B?=
 =?us-ascii?Q?jb1MA2qhWyxlGf3dY0oGHR7Z7uC8dClyDylCAqFLwLBdNvgiTZ9yZvQscos7?=
 =?us-ascii?Q?jDaI3HPXC3tzVfdbNVGL9bRExMToPfmryITIB/e4lji15UYcChVL1v7gn+FD?=
 =?us-ascii?Q?W0Zuv2jxMkMhZfgrfCKnL6sbRd3fZeM/nyFwyQl9XMz3L8b9qQ6Il4OL893z?=
 =?us-ascii?Q?rpCVpuzHqt43WOrSkdxw7ZobnMvaKedqT6IMsvNNhvRRr8j+FeDFeXawIijC?=
 =?us-ascii?Q?bWs4Za3x9PXYhccKPDF2vf8Q1iNz5VkQo27qdkaLn9y5RBhUkw1LpXT7V7bj?=
 =?us-ascii?Q?XxWra2/YqCm2M9nb+RmrSqtRFyvPDRgJcOyuVxfPDbJjZhQ2DvVrAfXkPck1?=
 =?us-ascii?Q?D3HsDnfW5E7xllV3xMkhssjKPmEDcx1XxJFyoL8yMYlfHyzQnkgti8PtmrIZ?=
 =?us-ascii?Q?Fkyo6ChIWplUtMDyjr7bxykAQjVTwZLlt81diAONwuuVkHsxsI9z8ZLH5p9L?=
 =?us-ascii?Q?esGC8865n0RhmFshvRm/AP0eZzfPFpuChMKqzYnrhNHHPptqYK/36rarW1wI?=
 =?us-ascii?Q?ZxFceCMetVUKHZWZ6vGSAWkD5ELz46f/cgyaY0b0yCd4OvGUhUFt3qYP1KMg?=
 =?us-ascii?Q?Gy7mMvWM60RqODxDgqYOHeU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9438d71-ed4f-41f0-98cb-08dc41f7bd1a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:06.6265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9eHjPIZAE6Z1s5KIIfJdiGqBxGrKcE2WOuprjeaIN62OVXyvWh+NjvfsCNWa4L5p3dVm2pu3zqlCnkWdRhSU2BYymz/y+o+jU+2lJXO9jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now we support extensions saving and can let to work with them in
read-write mode.

Place dirty bitmap loading after used bitmap initialization - in the next
patch we will work with used bitmap during dirty bitmap loading.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c |  4 ----
 block/parallels.c     | 25 ++++++++-----------------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 7fa14b057d..2d839006a4 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         return NULL;
     }
 
-    /* We support format extension only for RO parallels images. */
-    assert(!(bs->open_flags & BDRV_O_RDWR));
-    bdrv_dirty_bitmap_set_readonly(bitmap, true);
-
     return bitmap;
 }
 
diff --git a/block/parallels.c b/block/parallels.c
index 9536e4241e..f51e35788e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1378,23 +1378,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         s->header_size = size;
     }
 
-    if (ph.ext_off) {
-        if (flags & BDRV_O_RDWR) {
-            /*
-             * It's unsafe to open image RW if there is an extension (as we
-             * don't support it). But parallels driver in QEMU historically
-             * ignores the extension, so print warning and don't care.
-             */
-            warn_report("Format Extension ignored in RW mode");
-        } else {
-            ret = parallels_read_format_extension(
-                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
-            if (ret < 0) {
-                goto fail;
-            }
-        }
-    }
-
     if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
         s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
         ret = parallels_update_header(bs);
@@ -1432,6 +1415,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     need_check = need_check || ret < 0; /* These are correctable errors */
 
+    if (ph.ext_off) {
+        ret = parallels_read_format_extension(
+                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
      * want to change inactive images and can't change readonly images.
-- 
2.40.1


