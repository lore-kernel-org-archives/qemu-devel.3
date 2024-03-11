Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1633CC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkFo-0005oH-M7; Mon, 11 Mar 2024 14:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEv-0005Yu-3I; Mon, 11 Mar 2024 14:19:12 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEt-0006sL-MX; Mon, 11 Mar 2024 14:19:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dedzvvauIjwZgvHKcWgAxXNNqaoIlTD3IJpBSMu7Pm0wq9JOVocga3UAKZgveeCY+RTYYIpw2wqrcvws+TP7Ws8oeYFGJPs8wGEiyjwnzRtl9LKLHAKdvAnuGAWRrphBUlgJqijFrZcxE6iH8Bo4BuybitTMqQuy+BrYId9JRcygZTLl3kbkSBLLtXz7yM2U333kSSlZP+Vvivltnnpd4vqr7fNsX5N2RBuDEUM7zcZl5On1pZvZyk3A2Kl8lKllnmjUMgC64CzY2bh0abzACfy0rCPBmObBKwcD6NMPiEpkkCI/vLKUbAyxmROkLQ5FDRMp4TMMGStaF9zCJt8iSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGM8R+1YhTFUzcMeWgYcDxrj2klo3PteoKf3LFzL1k=;
 b=niJMb8aFtsbfafaOmKr+G65idPBWAnzRep2HUx3SaCIJGwUHoR3yN51auhSf6jG3KcLnTAiqZpvHR66iEiCTthya80ApJDBvXDET06koVvoUAkKOSAQVfS1LU6itPK+3eHoFxmD+kZhLoHwHW+gqFc1HY/ecFu5NcLo9S6+aDC29hqmr0GaSOXfI+M+qHrvplTo8e+PKKcocgASxZtZJapnBClkiMLOUEn+rbbMlhyfB99dtSSZunuDseu9peKSY+3+ltLwlmorSwYrfjTE3UNcIG9I46SIOYAodNuAgGylxn0J/iyVir3cnksdTozdSyAToW7Pjh/wQLheN6M5fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGM8R+1YhTFUzcMeWgYcDxrj2klo3PteoKf3LFzL1k=;
 b=uJkzOp7M3hQXuYRuzbDEAvw1FX84eD0Oq4mTI33RapzBraqiK3DmDQ8nICb6wUssna/MNYcswN93k9EU5Z8RT4MlheER74BjyhfbPY2ImXZPJ3U5wVke3MN8zxIeOJ2KkMn5djP06cogX0fY57Rp/F7OjULOKnWLevu7kCTv98H5ibQl3jVfb7MLj/osWnq2YrarVWWUx30+9vi/uCex71qReB+tlhOrEcdVWykuglOgD39tILqC/1wHp8nRUyTsHYfUh3XBnSPF5rddP+zWGCBfya1K8msfsZgITJIENZsko9xsYUCQAacUT3Nm0nxjC8IV9Re4Ot+BE+BcA966zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:18:58 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:18:58 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 02/22] parallels: Move inactivation code to a separate
 function
Date: Mon, 11 Mar 2024 19:18:30 +0100
Message-Id: <20240311181850.73013-3-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd71da1-68eb-403c-11dd-08dc41f7b86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bO1elA344YP5PiBsaTwVGRmzTCbIsOHsBKPIBmN2l8GXrCtKhW2qGnIiZIWO6YMVZrHC9AtPt1oLXjxJIUGcSflCqOkx5cyqbg4pEKjEdTVsgJrMePM2z8INtU/9J/XjIXoZP75mHDmp0Qik6bYe9yKVkUGXJuOO83yXm3/M7dOEd8Ij5kFyn7EHTjjb1soPJXxE53Dm3KSLc/rbCi1SCmjnpxxfDWL6LmgAfweKxJ5nrmLbLmOc/Hzg8YxOCZ6QhGejF0fnfsZxmoK31LOj9Lb8vko94TRnMQWT+cZxBsOqAbmsbYfFe/mdyp/XZX4FrUJeLp/kaYS5f21csD9PknQR063bl/8lDhrmsPRyRw/JkEQiJnapTmWpM6JmnmBOznOpGEyfsB0xQW2ug3ft15Sefi/DsHf/59qJ8eLSl13kYeEUOVkP5WYPADD8i68jrtJJT/g/R8NoRNopzLp8AMfvSBhXf0yqlyiiKUhCTEMMgAH3Sva3ZQ/QqtZiw884C/yLk9JxfJ7lo6tYwKrniPIvxCVgKVYo7flyJYqLDlLcXNTrWxeXgnV1qPxpUJhKOM2idiMdBZMePTn3grtGPTu5G6LC/xSvv2kI7GUImRPNjXHalgsqLxduHfJ8a3ES8JJTaQfprXeimGyDvVuIYCElejFyVycj/bGGDHs8d+BtT1iRFAhUqggVkt6oj0jRFYBz1kst1+uLscB4BfeaE/HNYN5WYBDRX70NbX6siG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?57fLyRSuTKOTL8cZlxKJHO9ySZFFh4onoCUoKgWSjioD1J2OoAgGqYDEIsRG?=
 =?us-ascii?Q?iLzcGknwnF5DF9StPcHuI0zSdYOg8NEB+H/Qta6Eh90puXvmKb8iW+OLjdLJ?=
 =?us-ascii?Q?G0s9IW2eacSNnlREJc7POjg2tBxMemaXB9cXhePfsIBuS6sjstVMA5rKDhZk?=
 =?us-ascii?Q?qKqGTS2+HagV2ylDzWQP6VF2Qih94IAbN48b+4Zt7AcnaMjKKQOKz3f2THN0?=
 =?us-ascii?Q?VB2eBX91IEEZxu00UdfQ7iIfb5oK6XAa3TgmBfOy0HaGuiJY3qRvcJHX1ci7?=
 =?us-ascii?Q?5slkb6nXwk5oTNCV7uh88UDJpOu6HJz6R6v8tsfrrrhlCMppLCTccrdMKd1K?=
 =?us-ascii?Q?gEJrgcN1IuKOEQMhYSfBg12BgtDx9ICzDFyQFwKYf81lelNLuI2xOMKiFhnL?=
 =?us-ascii?Q?KZZSz94sCgJaaSpEaB4iRm6jhnqrlJyrEBh4jHVgeH0QOmK00Ytyz0RhS5Fg?=
 =?us-ascii?Q?rrZjfgGJdsB16aw2sCWFnc+GjP3SWdjeG9Pna6iQguyBT2VYsWmkrSu0vSJ1?=
 =?us-ascii?Q?pYdgxUjtya9J9P5IiaGupKWeBph12mrJbvJ+u4P297YMed5krmtNq/tdLc4Z?=
 =?us-ascii?Q?AtPbqu0a+lEXEm272qt09dox8s1rh1R4GCQ/Fxydvh7UzOxwCc32CdGHEZ+l?=
 =?us-ascii?Q?cCfqAFc+3X8627ktE/j3SYZ3Hadu89JJxGBqHIYvFZK2keHxoIfKFQ8sEqLK?=
 =?us-ascii?Q?kCqVO39fUbNeiFisU6rT/aVOOTwolUqMZp1fXFNd+O6CyxFeudIWbnxVAYKX?=
 =?us-ascii?Q?vxc10XlnhiPfuIdAM5ElKB6ABHuZfDzrZa58xnT56UCoxAZMZGKgIStmrs8w?=
 =?us-ascii?Q?ml7VNmGKACbqdYNusyjYFqDycuhZwB/V0WmPiDfSM4FBTdga9YY0tjgerCre?=
 =?us-ascii?Q?Pa2cdvaGzOwt00xKcopbpuokAcKBC3Op8NcosymjPeiehwRtd7ri0dOs5+v3?=
 =?us-ascii?Q?DeBzaLeTKIoef+P/FuMtJ5sgMb0HGcFrJ0+WuyUFJAUS1dro4DmJ/HZkOfwb?=
 =?us-ascii?Q?h0VVn5QeCC1y7RHnuiD7wtDQsHw09BKWTFm1uCm08QSZNhwTCevqYknqGDru?=
 =?us-ascii?Q?RVHXWgSNW4Uaep6qjme5oJFsdK5w1Vgggey7TXvfenChFFsjl+vcWkGVwSn2?=
 =?us-ascii?Q?CLXikxDwaKTarYU5+Pyeqxk4E2XsPFVL9LH0rytkRPWXwa2lonqJdU0Aiu4O?=
 =?us-ascii?Q?vLPvvNZaoa8fGFcQ4hVrwLhxxlUjeKYyxmLy6kmlijYI86CX3MDguplRgLnm?=
 =?us-ascii?Q?rmXs4q5k1y+Kzu27BR1242K9GyekalUtcH/IUnG6prRwfO+qvOrBiiqeSWg9?=
 =?us-ascii?Q?4NZK/5kgQqEJYeueQcavKMatrAc7lhbzNt9O9mt3Ui7JvGtaaQhQB9wf7nwd?=
 =?us-ascii?Q?0Q2hqDLulwiVeYxZUs97jI41+Ju9sz/oN0mgVrywyTDVuqrH7y76xlFBqhzt?=
 =?us-ascii?Q?7Z9cug4jgx6Uc52f9bb6Z+Mpb5/B2Kgshxexxb6+998MKq/bK4dMV5/VQJF6?=
 =?us-ascii?Q?ba67F4LhZ9CkxsP25XyXSdujE7R2YLoMXtrN+UhwelXmnwvsa315fxSA4DEw?=
 =?us-ascii?Q?fUZweSNVw2Xah87ONF1oyJ98kTyzSbKBsHuuQjRT3GMu/ImEQ6UL0fLO9d3F?=
 =?us-ascii?Q?YZeQayHy5ZB0zZYsAUHNYxg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd71da1-68eb-403c-11dd-08dc41f7b86d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:18:58.8059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeFyruDEO3nMo6OOJtdVo/unpyvl3T52YIS79WTAHImBoYuWYpvkh7y2cdkTwRLQwN925OIsHbOPTbrOO1R0rhX0X7JtpDvCisVLFAvmfl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

We are going to add parallels image extensions storage and need a separate
function for inactivation code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 072b1efd78..992362ce29 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1424,6 +1424,20 @@ fail:
     return ret;
 }
 
+static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int ret;
+
+    s->header->inuse = 0;
+    parallels_update_header(bs);
+
+    /* errors are ignored, so we might as well pass exact=true */
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
+                        PREALLOC_MODE_OFF, 0, NULL);
+
+    return ret;
+}
 
 static void parallels_close(BlockDriverState *bs)
 {
@@ -1432,12 +1446,7 @@ static void parallels_close(BlockDriverState *bs)
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
-        s->header->inuse = 0;
-        parallels_update_header(bs);
-
-        /* errors are ignored, so we might as well pass exact=true */
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, 0, NULL);
+        parallels_inactivate(bs);
     }
 
     parallels_free_used_bitmap(bs);
@@ -1476,6 +1485,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
+    .bdrv_inactivate            = parallels_inactivate,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.40.1


