Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7FEC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkHA-0006z1-Ey; Mon, 11 Mar 2024 14:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFJ-0005e3-E2; Mon, 11 Mar 2024 14:19:35 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFH-0006sy-7G; Mon, 11 Mar 2024 14:19:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exTxzumEaOnLl9/Fdn8mJ8ZgukFzVg9M4lJGE3S2qZ1leP+tbtC5B7lr6dOo897C8Fs937qSWT4L12L0yTer7NL1MA/F1CnE/XUCMyrau1oJCbQdfiUNOaIu+iTyNWQM6XH+48dSAIOlwdOi1Ri6FZtFnXXfc2KDnZp23mX04u7DOK1+nMN0BWrsLH92tc9Dj4DcUnizu0zp764gnq0Ph0DMGSK1tvLMFCxKCdUtZIWiUTD2no0Ufg4Ik7jEd93B6asCuVv5xJAoLvHPxNyPFLs+6trn0urpJ9oJN2gIwOCc/MM+69nXwzrigtTUaXGSEMu2O4SPIAp0i1W/VxVztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR09OW1xLSArxEq6S3w5Wn4ermzo6OmaXcWzG/y42bY=;
 b=E7xrN368ZqMn0fcR2pDWSwRr1L1JvTpcrCFBiT5ntp5U0bVDezfe4BK8de6awz12eaUe1wWfLg3EzWlubcOL8hauq9mVW+2vY2Z5TyZC2KokvPW8KONbAyvfJkOg114wABse0KbBTpgSm/oK98S/mAdSgO+llwbMhLl+IMB6iXbRSImqDmUuKOlSVZT9s1zER0Moj/NRNdMBQNR9HIykFmtPNRnT2IWCFe88Bt3zvKvVaxdbjFhLKA5MWDxi31jiEmY0v/7ZnTNmVMDIPt4K/foj7op0WDDXVnAX+bvJ1HyQeYC8g+X88bi2nSVmUFQeTRlY9YtgHCxF6q64Psi2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR09OW1xLSArxEq6S3w5Wn4ermzo6OmaXcWzG/y42bY=;
 b=b/lVymVtW7igiiO6ozrj5wjOjG4Z0xfV6UKhT6jWVZH7CY94e8SnQjywtjs5f11lyiqIb1tnAPkp2IcKFax0R2y4fLuxeZvxG5QfTrNBr4GJF6Umsu8vAIhXriJ8GEG8LHALSEzkdH2v82B1jd5aRx5oNC7LorrU2pGFn66eLW5BkPbI6pYovAJEcnSExppZ4HvFigy0e/Gv6w6ZWq13JaSzHmbWYE/JjwQ9FKwDKrFhYzF30x9UcWX6Ms18LcD4ouBxxf8bpRr1Qgz+gncs0c0zYe4Y41VXl8VxGERp4glOS1OZ2JMfWSrlfrkP1D98X3cJpI5hQISbWvsxfIjj6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:10 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:10 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 18/22] parallels: Check unused clusters in
 parallels_check_leak()
Date: Mon, 11 Mar 2024 19:18:46 +0100
Message-Id: <20240311181850.73013-19-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9697e39c-b540-483a-39d6-08dc41f7bf3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzTI3Kh2WegDoNjJVvCgmhpLtEoPoqnT9xrUL72w9VbnEbYiV7D4U/7gjGm37zJt7qkXWPO+dbVH8D0A88ttjo/yl/arEk+6v8FJ8pZFngqxwgbxO6M1bE38p2i9uSEKrbWUnbAVi1NBqU2ND7WRK1MlCLK+ka8ocTNddbazhamfB0hsGi/MCANCS//LcdcC9qmmF4tlvhLbbw1SxgGUIK3maesFNaOcXLpsAHEi198Q57Bez7UIVBeQuCi3GxK1nSSE/ikAT/m2rWeH9Zfqz3+aCKXhd11tKu83PKZG4kP1Fpd+QjZS2wP9n/P6FcIWNQYCt0GQ6PgfG0QaEQwXdlrOp7ndbyIV+8PxAa6X1FUS4J/hum53GnV741Wse2CaZszXBaGh+apW3jaVYrIcvqNZ4XJaFRlQp6WFUYPb7UKQEcsP4MgKg+aorCUZXmm1jbDHAPKIqOuWnjZHmg/ntUCL+D5XckP436ZT9nEadcjRH84wUAVsXJEWXzrW0VddkGe9pdVhT6zLOAtwrICjqaIDv81rgha0JfPHtSDXinC0bjJk5pfVwdo9+Lskf78e7p6nrIsY7syDTjSZ0O4XrrapWqO992oBvE34I111hMz9cYtgsfWrtf3AsWpQSZBBA73RmFXmdy5CJTPr2evICIq4jf2ruKX0sFyI03DmW4iWDNw5JcaBJPPZbSoGTNgRQDPOknFzuBMrEg1OOjK9DRuTj6a+W8NvtHdmDLUA0bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2OTsOsEXzPF4mRAEBvjsRoQKrTgnyyf+Ibkkyf+5fHntOQuSXiK6hFDO4su?=
 =?us-ascii?Q?eCHyZ8Ro/TnThw0WRCCKMefPmniN/aXZKq4x+PjYnmUOYpQac4hiwZVdzsiG?=
 =?us-ascii?Q?MqWimq/48WSI1ooqRrHD1N/iqfmCwPZolxv72F5Lv4cI3iOxDdE+MpsSmp8I?=
 =?us-ascii?Q?1bryWdgtf/rZbZu8gtWZANx9Ab++TnuMoauc2IOzmSib63jyQ8neBAleQuTx?=
 =?us-ascii?Q?hL9yu6PGWrhK8+T7x/7BmAM8SLfrUu1llq4ZVsz15yrlQuUyOlooyxKtJW3e?=
 =?us-ascii?Q?cf5k8X/h8TIjH5ddbo8qk/ANt+R3YYm+bprNwpSFx6/1aZuLC78M4lM6ssmR?=
 =?us-ascii?Q?aHTEvHUCqveeGWiscyDZ+kmuus1YbGOTn0UBlCoIcJ9ZzZdC7RXsepvLSV/W?=
 =?us-ascii?Q?d3bmpZXk8RmfbCGq/yRu2GSIyuJGq4BSR3K1gfkaB31TcHBpXKvRQoPOOglB?=
 =?us-ascii?Q?AhTzUZFdDutIskepe4ZS+wf9NrYcBtkQZ8+gNbyIDqOtrtjGQrQZZp81Nx5h?=
 =?us-ascii?Q?XZ5kmxUtSQVrFMB8w/Lax71cSAgIG3eqKQc14YUebC6Y/hpCKIt6tml5Mrzr?=
 =?us-ascii?Q?2PN68C3tL1A3Hw2HYOJcTbOHrx3vGNXHXDzbuyvdKCDbl3/syWuJlfTu45vY?=
 =?us-ascii?Q?vIG8h3iYATMrnLKASQfGznHeeT3ExKQVE4PgOd83GYOnFFLVaEntVpKN9Yk/?=
 =?us-ascii?Q?ejrXukpV1pTbafHiw+xX2jbQx8sJUEGxU0jlO8mYECYASSr1G6ApvcNLaQXo?=
 =?us-ascii?Q?B3YT/20T7s6+VZp4uopmWu2955Q1ln126YEuE3WwKa0wZOzlzBKlsBNaYJ62?=
 =?us-ascii?Q?J8l6VYwwCfzFXZj+hZMkq0KD3hrB8ZDwJ1t/aKIPJ0L5dn6ZFozKXEskzNHI?=
 =?us-ascii?Q?SLnycZ++bYdcNnFDT2abzgW8i9W8d/jxN1HWRnZ3i8jvnHlUmlErhdekV37L?=
 =?us-ascii?Q?KN88d/rDNXEn820ENs3kXEhkzps/wMnEpY6XRaaggN40iJ/XRZa9dsPcHLVq?=
 =?us-ascii?Q?M5ad8I9NsD1VRbIJ4Vqa923wSwZ7HpL32Mh8naPbZthu8h3dnNW3KMJJjyh8?=
 =?us-ascii?Q?cr9dsLOpDUah+Cx0Pkyt1JcSE6IVEtBKc0E3HYsyT+STAORLgQ5+JQJpXfHW?=
 =?us-ascii?Q?Ghv0gHSDF4nQsusZLDNf3CjBOYsxQL4kBVHsvKqpizfefPjCIxBMvKcMQuML?=
 =?us-ascii?Q?k6ytk83WqqVwusUiMbO7m0IQifjry+BRyW4P/jTeh7Gi4YqLCiGs7uo6MSf3?=
 =?us-ascii?Q?CKHVwiL3Km5LTKjjtXfDF2+4AQwttA1SMrbSSWu5vRCymIxngnC9U/3B5KoS?=
 =?us-ascii?Q?EchDy8I6pFmZXzYSMJrtJOUBuAdOSaHJGnQcazDJAejcjGvZhME2831OJaOY?=
 =?us-ascii?Q?OuFAJxNCG55NkmM1mcjFE3UeCb/mGH13Gxd1JGHEVKujsE4KB9eEd8kHaVln?=
 =?us-ascii?Q?C4yEVcIAa+zEPM5dPwmVyGMUt27aHavvyjEBC7JsOvUtO/BW0HI6mgtjEVg+?=
 =?us-ascii?Q?5w9BB7riFjfIz6d6HJR70c2LnuZCrG/KasHgB6EWEpsMedscQdC5CLnygJ3c?=
 =?us-ascii?Q?/QyhSLQwBy422CfSIHpGMei/+7JP5Id+fuwxa1OOzSuBNgyI6d3s+cnn0QiA?=
 =?us-ascii?Q?GW4vgFY42xlHE5tpAd19dYc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9697e39c-b540-483a-39d6-08dc41f7bf3f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:10.2154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67Ep9Y6ik4WRVrZBHE04PHXBpZvBF/eLp+o/Cqfe+pesmtQlmcj6jvK7qmOgI5k9NpW0gHsyC/MjcmdgqxskFu0F10Hb7o79brA6AY2dhvY=
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

Since we have a used bitmap, current leak check is useless. Add
parallels_check_unused_clusters() helper that checks if there are unused
clusters at the end of image and truncates them (if needed). Use it for
leak check and at image inactivation.

In leak check we need to recreate used bitmap because it will be used
during work. At image inactivation we can skip it.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 106 +++++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 38 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 5155b8ac48..fd80179642 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -773,57 +773,89 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int64_t GRAPH_RDLOCK
+parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t leak, file_size, end_off = 0;
+    int ret;
+
+    file_size = bdrv_getlength(bs->file->bs);
+    if (file_size < 0) {
+        return file_size;
+    }
+
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    leak = file_size - end_off;
+    if (leak < 0) {
+        return -EINVAL;
+    }
+    if (!truncate || leak == 0) {
+        return leak;
+    }
+
+    ret = bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+
+    return leak;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size, count;
+    int64_t leak, count, size;
     int ret;
 
+    leak = parallels_check_unused_clusters(bs, fix & BDRV_FIX_LEAKS);
+    if (leak < 0) {
+        res->check_errors++;
+        return leak;
+    }
+    if (leak == 0) {
+        return 0;
+    }
+
+    parallels_free_used_bitmap(bs);
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret < 0) {
+        res->check_errors++;
+        return ret;
+    }
+
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
-    if (size <= res->image_end_offset) {
+    res->image_end_offset = size;
+
+    if (!explicit) {
         return 0;
     }
 
-    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-    if (explicit) {
-        fprintf(stderr,
-                "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
-    }
+    count = DIV_ROUND_UP(leak, s->cluster_size);
+    fprintf(stderr,
+            "%s space leaked at the end of the image %" PRId64 "\n",
+            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak);
+    res->leaks += count;
+
     if (fix & BDRV_FIX_LEAKS) {
-        Error *local_err = NULL;
-
-        /*
-         * In order to really repair the image, we must shrink it.
-         * That means we have to pass exact=true.
-         */
-        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                               PREALLOC_MODE_OFF, 0, &local_err);
-        if (ret < 0) {
-            error_report_err(local_err);
-            res->check_errors++;
-            return ret;
-        }
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-        parallels_free_used_bitmap(bs);
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            res->check_errors++;
-            return ret;
-        }
-
-        if (explicit) {
-            res->leaks_fixed += count;
-        }
+        res->leaks_fixed += count;
     }
 
     return 0;
@@ -1475,9 +1507,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
     s->header->inuse = 0;
     parallels_update_header(bs);
 
-    /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
-                        true, PREALLOC_MODE_OFF, 0, NULL);
+    ret = parallels_check_unused_clusters(bs, true);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.40.1


