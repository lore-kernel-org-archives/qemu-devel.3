Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2FFC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkM5N-0005xy-7u; Wed, 13 Mar 2024 06:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rkM5L-0005xl-2B; Wed, 13 Mar 2024 06:43:47 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rkM5G-0004cj-RO; Wed, 13 Mar 2024 06:43:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4Sst08vlORIcz8jggKhGx4nURhnFHj+KziYfv67l9yKLvJSgiTjP/5Y63E0qLYsCrX4+FK/HheQMUD3Biy3ZeuGJrdiXKNN8jRgtoUZSONe6NDtsmzWogs8FMYDfODdkuj5Ycf15OyJfIm9bn7101bpuPvMNmoXdH8F3TOuHAvHbpQWvOtFYMEMHRNuS5SERSsbaOUhF6movcf+A4B08EG5oiHZYJ44mOukdlfYsJoypWqtW3jejf7hJq9+sdpfaHrYhrl4N0X+PpCU7AbBoNXQkGpXmEDoqmKrQSKeDHGq+3zQ7RVd+6LhzqcJyzr2hJh+T7mDKh84SOqjgEMUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7J2j+LCNWK2fKMyWVEg+4C9P8xwG7ZS8I9/czugb1g=;
 b=k8GujZY24jKPvnx5llR7Mf5Nelo7/zghRVHMZC8QVwUsgf4SpmYPTYEQe1/skapM8gEg4wrNHS2NJ02mq41mFy54rojCIkjfOXfX92kLNsaSZh78ZVJlazhDbmWAOj/l9J9h7+AZweK2P2qkn1IhpbYcGzGrZoPwO8YJII1dusftH8cK8jvry3GrKFcuzFud6pzRt3udJJUDaYlR+73UHRSVe2WcFia44ZFfeojaovQw4ob/P1g8aQu/jYvIH3zVMu0dHz1xDj2Vk9p+KXyDBerRnXuRDzrbkeS1hR3osFZqPkzO4cVfDBt8ilLBJWGROnHAQWnpmFrYCO3UanNv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7J2j+LCNWK2fKMyWVEg+4C9P8xwG7ZS8I9/czugb1g=;
 b=GuP09SVxZk/DMdUNOy0TZybCyqnt9tT3WeMCKukudxIEjKt7V0yQtFGtvj6mf7Z+p9b9iLmvVYt4egbSwTq7jlBy6qRIsasmBaMEhEfo2hsrG5pONq2K0oApK9RMvope3UjK7A+BcecW0fmVY+OJ0/1CrC2YvwGAYGnWDJsb5mzvoHWyLP8ZL0ZaEDPXFXJoCnnn5cnW71eYhst9ShMK6uNp7sk9jzztTfu2206CEMdVxjNJHPiCZgkLvJ3wzNDo+hoG3/pZa/FBRVUhDmXr3npQMIaQECPhSyDRESl8nj2mYaFUlDDaMm6hYl1SCkiq41nq41uzff1IqEI5a0Hvig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AM9PR08MB5986.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.32; Wed, 13 Mar
 2024 10:43:35 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 10:43:35 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH v2] block: Use LVM tools for LV block device truncation
Date: Wed, 13 Mar 2024 11:43:27 +0100
Message-Id: <20240313104327.147450-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AM9PR08MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: a025844c-e933-4791-0448-08dc434a6f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ec+TWqrVhywyVyP+JqLNkx04YxY1OfV9fniL10yZF9iFrBbZwbQXCoXnXm4UeCbcUMvvPvQZc+ELmt5b+nnu0kprCzWfqIC9WprHyyDbd6PLs7GeHWS05DU/Cfzc4PalHP8OpO6mkT3Gd/tpt2VkjUCBr0E6ng4SKLDDuDV/Wzpw4ZQNi2yyGfFfnAfKcloYlv7cIj85/x4mo7ZLpc3NlNtMOHXHWsn0K10ugEGmzLY9Pl1dtWuOh7bTLPGbGusWYR/JIDvDGtah7MU5KiW7CBcwuxjWx+OVilBAOTcqQgnnzr/RYtsHk9h9vEhLg+ueZ5V82kGQi3uvJXAoDVt1FxtH7KaGirbPtHWo+S6MxMSabwqu1VU3HmQBTDvEOPIvhnyUI9N219qR/XNZN6CxakA3ljr3T3YHO+x7KHyq1dG0u21KjSdtHqrA78KMXMqIpFsNDXtYaJY0cp+b3u8mg0kMoBt7KqmcVJ7mYZpcIa0c7tecsw5s9IP6+lZ5T9OIF6MbdOCPQ7JUV9bWwBhjmKYHWChetTAeF9kGHL0+vYvtls0BdZVaniCwQpTB5zftlKH4kbk5CTwp2ln9CtiniDWxxshBu1L1vid71hw7USe2qk1LnVQxM5yfwXAMdvbX6BhneVGibfPqbjajf7pInf4XfKMsfYUbWAszkdKmogJnCPt7VAkfSIPWFxehorh6p+F0Erdd1V5YWwrV4khltZqRER+OwVbiVaufjh8bRDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TqK2/Cb4RkaevL/WuCrkDQswGsclOuykkTDRbqwK6B4mKDFuIbVA4P2GKqGz?=
 =?us-ascii?Q?jkXs8shrDUWYY4kX8saFK3xodVgDotEZzjkBSPYJYqEai+7D9A6akgamK8TC?=
 =?us-ascii?Q?6YLFhYg3sfAC7JfdeOrqPIC4Uf9CSdRHXrU0fn0AyI24NKYJCW6l0uxGyPmi?=
 =?us-ascii?Q?n+IhDQQqbIJtL6gn7TY5fuau7+hcAaQ29has6yjsgHNch8wxdO4FpM9JNmDV?=
 =?us-ascii?Q?auTmgZWac97OZ6rtyaDc+a8sZsY88gm7S6R6mup30sQgRVhUZl7mipbdLMfv?=
 =?us-ascii?Q?HxDAPXMTymqJ15llTwTvc8T6Rt9/8Pkqf1M/NGwFBiOfuvl+bmTyw0bPclq9?=
 =?us-ascii?Q?rFJ6lwlwUR1B5P2aVUPU9sCsJJxU+M0+OvmIgSxqtx6wHzdjHdZWt9TnYP7a?=
 =?us-ascii?Q?VLxfBIvYeKsVIskXneK0rRi03d6wEr9Gip1VSrVzRJgv8e/CdzHrfwkcSMJP?=
 =?us-ascii?Q?VMmTpjpUCDP6/tXKXrwTQpvUQ4w6ml5o73gohYuXDNzdXxauLi7m/sNx7jNU?=
 =?us-ascii?Q?QM6zJTqCplz7eccPfL/L10O/iejN9eLzTUTo8Mb2sW40oP5cH8l5qpXWVtA3?=
 =?us-ascii?Q?irzF7q4WRUbHkjHgaTfseo29LXRNRgyK+o8IIx/1nALawyOwVuPlaxHBAWTY?=
 =?us-ascii?Q?bYlfEt1Qjl3r7rCXEK5va6n49NDsvQ+ABM5DFP0ns7ToiP6sd+jOUteC3Z7B?=
 =?us-ascii?Q?ozbxxaoX0YRJcblOJ09cZZf+ev05huz+3QEc6iJWOkwRyVtvFY9OWzXDW37y?=
 =?us-ascii?Q?ewD29+PcNiiso/LvFLr5zWaziPncR13rsLO364Flv4XxUY4R7lOq4+aiPhTU?=
 =?us-ascii?Q?iGOJB+TQZW/5SZL30z9HNzaSd08mU8xFo+Niyy9y9NMIfPEAozlTTjqDWMyC?=
 =?us-ascii?Q?UcrkqXrYcqFgZ+4CatDDasBblKUbC/+2ymvinUOB7LhjKj4aRD5tHu0+sP5o?=
 =?us-ascii?Q?KtSFtoHxWHGVhMpsbNUPh6I4fv38nxFKyDkiwxCdX+cQjjgmjV05iCOup/E5?=
 =?us-ascii?Q?10gaHWXyoGOoWSgVoDW1NgS+M+2KUty1CzRWwNFF+1OSgwepivU9Fqqanydy?=
 =?us-ascii?Q?xXEips29ouQKd8laCaYX1PGZTkdqQPWH6ITHVv2esNfq9EJ1uEhbbL/5+6e7?=
 =?us-ascii?Q?+amdCCnpG0BagClI/TsdJ64AKVVPdSE5m99b7X9RBJ1vRsVRDCQsh7K6oMgH?=
 =?us-ascii?Q?y2QIgeh7Bh2PB/X0fKf+mh5othnhFRqfDp38EhW2l3rMmL7xjpkkalgNnSOl?=
 =?us-ascii?Q?eT0H/7LV5BSPiOXOe6DVF5O9K3IBIOzmZ7IYKrHWMKeLYJK4i/l/O47+6Yg/?=
 =?us-ascii?Q?MUnIC0XTuz8N6XykUC1pynUD79T/iAYsiVNx0QL/C4sdUgN6+LP29C7HNVDS?=
 =?us-ascii?Q?V/z17L5/3E2xfvfol43PTDXVYprzlap849s+39T9dGrU28uYMSR9KXuTsGRG?=
 =?us-ascii?Q?zoTSlgZBBASK0DqhfbZFGyz03VY+nj8Aa1MIFddnb5FoiPrfIKwlHeU5I2bl?=
 =?us-ascii?Q?Zsuuwf8COPeG7ODp2WBLNz8SJQxT3CwTSzB7xUFpZXw3n9lcceIOhT+Rt02J?=
 =?us-ascii?Q?RA2Ze8IbSKU601HgIEpLo5dP4F8LHz2S484Nuz43SggXliAHYJz6faoDEQEg?=
 =?us-ascii?Q?FpjQo+3VBUg/C4pKU66G7Z8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a025844c-e933-4791-0448-08dc434a6f2a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:43:35.2796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1TksXUgedr1IfA3dLJPorUglCMKuQ/Ittpg1Ume5QSvpmll4i39GGJG/ORNa28h+whUqyb4tTqz4jwJXlnCOwpsCruuyLndBqIU5TnwA/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5986
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

If a block device is an LVM logical volume we can resize it using
standard LVM tools.

Add a helper to detect if a device is a DM device. In raw_co_truncate()
check if the block device is DM and resize it executing lvresize.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..5f07d98aa5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2642,6 +2642,38 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
     return raw_thread_pool_submit(handle_aiocb_truncate, &acb);
 }
 
+static bool device_is_dm(struct stat *st)
+{
+    unsigned int maj, maj2;
+    char line[32], devname[16];
+    bool ret = false;
+    FILE *f;
+
+    if (!S_ISBLK(st->st_mode)) {
+        return false;
+    }
+
+    f = fopen("/proc/devices", "r");
+    if (!f) {
+        return false;
+    }
+
+    maj = major(st->st_rdev);
+
+    while (fgets(line, sizeof(line), f)) {
+        if (sscanf(line, "%u %15s", &maj2, devname) != 2) {
+            continue;
+        }
+        if (strcmp(devname, "device-mapper") == 0) {
+            ret = (maj == maj2);
+            break;
+        }
+    }
+
+    fclose(f);
+    return ret;
+}
+
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
                                         bool exact, PreallocMode prealloc,
                                         BdrvRequestFlags flags, Error **errp)
@@ -2670,6 +2702,35 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
     if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
         int64_t cur_length = raw_getlength(bs);
 
+        /*
+         * Try to resize an LVM device using LVM tools.
+         */
+        if (device_is_dm(&st) && offset > 0) {
+            int spawn_flags = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL;
+            int status;
+            bool success;
+            char *err;
+            GError *gerr = NULL;
+            g_autofree char *size_str = g_strdup_printf("%ldB", offset);
+            const char *cmd[] = {"lvresize", "-f", "-L",
+                                 size_str, bs->filename, NULL};
+
+            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
+                                   NULL, NULL, NULL, &err, &status, &gerr);
+
+            if (success && WEXITSTATUS(status) == 0) {
+                return 0;
+            }
+
+            if (!success) {
+                error_setg(errp, "lvresize execution error: %s", gerr->message);
+            } else {
+                error_setg(errp, "%s", err);
+            }
+
+            return -EINVAL;
+        }
+
         if (offset != cur_length && exact) {
             error_setg(errp, "Cannot resize device files");
             return -ENOTSUP;
-- 
2.40.1


