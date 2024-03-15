Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3E3C54E69
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 08:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl3P0-0007B9-E2; Fri, 15 Mar 2024 04:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rl3Ox-0007AA-3O; Fri, 15 Mar 2024 04:58:55 -0400
Received: from mail-vi1eur02on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2607::700]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rl3Os-0005OE-LY; Fri, 15 Mar 2024 04:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xat4LsZjtLBo3Mkt1NemgmRKEglcQxZoT4g5tpj7GBSAkGv3Y1AFS0rcXKc9/3+xpT0rpa2PtOgaypw8iiFljUc+6tiSXZ3zIIlKY2cG2VCDqTTY9A/DET8igdVs8NLTtk0m1waxBjGk8XQLgfYX5Hb50FHGMwC+Nn8NV3r0P0qFKVkK44Xhvdw3bz4ZFET/6qzD2II37RzakC6Pfi9PAo79iL/TOwal0KGojnnw6IHpWnRO5mPQpbpDVHRgjQIe5X6IreW7EK0Xsc7exeXP0jwsbB39t3rsy2C+G2UgWEL0y//LnLo6uvxlzmf/a+2+ik6vxJzjavuBsEQOk4z28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmlhS7QOYHlqG8y4aJv542VUEpmg4fsxPHn4c76w6qM=;
 b=XI3K0tq3LzLn5bXSNFSdYiUpOkaHP1ZqRTLRvPYHrIUyuiQYU0mQ62eYBbcPsaPFnMq27o3rOWFuChXfRoLtsiHBf/xYcPi3jcL3SGYXiGosbnsrfMkgTLKG2/jPR5/fOIr0nl3PXyrO5JtZiSJEVMcGZotds4n3yvILqa4ucy1snKKatz/hObXwAho1JRIxfbRUU6m7/2MlSvMljQ9YEKL3oMeQ++vVk2Kr0jWbtP0+gxmiHg2/8At28yeELZ1IJhF+oIzsd35v1+J33vBDHjS0KP0y/V8j10jR5+kpEZuUmZfnCyI28o66ZOxEsSe8YFbhrsLprDsHdc7h6Idw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmlhS7QOYHlqG8y4aJv542VUEpmg4fsxPHn4c76w6qM=;
 b=EoKmgSM9xyZmmmPbry7KvX+Z7NLENS3cRMTV+XR153TbDMHc0O0oGTM5bpP3JWp1XEEbPK427wLR7InZN/TgtUZ75RQIkVmLT0jCipF008KZHShH8x9d7SUruJIXYmbgWoP8Bppg1C27YW+ahaYbvAY/KdyyT+wQjlh+qc6L6NwhtsDeKaVQUSLhiKvWa3ReTcNSraE+snfw8jPXBmFKoN60YnyerRYvxIRWKz0I6TgyE4paZY5WH6CF4LOYn9nRFMmfqsytD6G4ObB0FsySZOJTUn74Hit50uS11gbBe0lsViFQQHSRcMIE/3YuvWtYAm0W25vqDCIvBx5JLcSuWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAXPR08MB7317.eurprd08.prod.outlook.com
 (2603:10a6:102:230::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 08:58:45 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 08:58:44 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH v3] block: Use LVM tools for LV block device truncation
Date: Fri, 15 Mar 2024 09:58:38 +0100
Message-Id: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAXPR08MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd763cc-3e30-49a0-761a-08dc44ce1e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzS/i6Hvag5zZF3rrzecDuhywJCl6eMgTa1Eec4zC9J4ILsVuqS/Sv2NJOcs2YWfbtu+puN56Sy4j+xbueE0qFXrmgGSmw3Dfp5UvQKpGpxBdSZh7dG7J4IP8SyULzw8WHc2TA6wiChenfvfKHX1LqYJHjf1F3Cf0hKeGLqrETgcIY0Ichz/KpgDgvhsPEB5bH48TRqiqKr7Q8z7r4iw+NnmVBI/sWhCuZ1MxMPJFghrOJZ1VrsVP9cMOLiT6y3Z6B2uN/ppN4ZwQNsh4zeW/0YirHTmEs0yIeUkUb5f/KufwY2QSeJZ+PMyzI86ebzVq1lMbH5k3po9Cl6anXIMEvQDEBDNgsNBgqmYX/F29Yf3TB54+JoiYbPsMQOf3Ph5WSoINZdHgzg36pih/NgG9gHkQwtRKiKEnL8BRObND7U2p3C7XpW8oRVn/MjuHvmTd44Iv73B5RhcU+6/jo92igca9o2aBmAKyXA6QXpn2WO+jnX4XjgaERyuE6Lge6QuM5JLMoTJtVIaGMyPTuD5wMZON8Nj6fV5uotinAAyJQeMX+0z5DCCIkezIuAiVz5xculH1Juvvy5QrEmQPt4lRpvdBUcFnjTzDmuM+fgx7uN7N3tyFHvIgPtNJmqrnWfKRKaGc6j8JaEilHQfSh9RqcTXWCZEbI+JqcwfAUsNwCTGObr8UYQ8fjDQ/Ikq3yCrMYVjkEyn8zk1w7ToXMJwwxVFBcl1RCi/RJ72S+UabyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tv/X3JRqLri1RqunLrZqbcIVcGTPSzAXXdQpxJd4boECqkRZruY1fAkS/gOt?=
 =?us-ascii?Q?gqwotw06eU12kwhL6bPE+TsD3/Mk1HJGJLxL3imsrANroFNI1oXdCqhBckPv?=
 =?us-ascii?Q?c/UQi+2utm2/bB7TSGnkDcn/0Ni4uEZk8DYu76M62bc/JVEhT62EvabUcKOZ?=
 =?us-ascii?Q?eKL6EwNNikQD+1bw5KG7V5L8wGbpD2mASgZwcOOLNMEMku10IWaXQoOWmHll?=
 =?us-ascii?Q?TOX2lqolD32nmDJZ0z79vVnVHAW1XvOmbHUpgQ5xS3haZ06LSTUDvYgec7PS?=
 =?us-ascii?Q?njGk6PHKOxboZqeZgatd5+IbrzLnQv62BoU/SwaT16Lz+GF8rl4T4maQSNEH?=
 =?us-ascii?Q?+LeHZkDfBLcaTzHoEsIHQ/mUDYLgZ0i1I20+jl363rX0zXJVj3deWuFg4YNw?=
 =?us-ascii?Q?Wdo2r4zVa2q8bwJ6eu98e3OV3mWKcG21oXiDgBeYt3XEG87/PX0dCpbq2UFE?=
 =?us-ascii?Q?oCBkyV647YF8Tj3mR/Zmync9/5sij1oHEusnG9r3L3nm020rHo2brpr2PRAK?=
 =?us-ascii?Q?vIFBXl9/iIaJ00bqzOP5oFiyaXsMUBsIBoNN7Wn1QU5dGwPRokFwWZMhdpHZ?=
 =?us-ascii?Q?/4KIhbKB0CiWeqyqDHSQUjQbvvZQw8hpQGyUlRN00afcLuDeirlzOD9XrWgD?=
 =?us-ascii?Q?D08RVvPbjvSMoYufa6TEaUqHVA5iMq39gt8zAz6cDJl2FKIpHOs5GwSLeLVh?=
 =?us-ascii?Q?WsN8hH+9kHV07Hmj6Dsb4v7uRTXbKp8KM54N8YpBPw5pRMDX4APbkSGV+hat?=
 =?us-ascii?Q?37vgXHdkYT8UmJkQCI7VNGLzli9fCGEq1Kp5ilAm4M4ZJsTFDktp9iDBgV63?=
 =?us-ascii?Q?KYDUGdn5Pef6c6PKIAZ+UnZyrWmQkj1UhSEeYM8wsE+F6mD5vokNIjGmFPvS?=
 =?us-ascii?Q?aF9SxQkXEx7B8JVaXU77lDeYfzyqSXsBYyiKdUKB12qG+h0XSKQxWyqgmk65?=
 =?us-ascii?Q?4Kj1d7D/AU2t5Mp7u1h1bBvkKa2GQUPgCzPI9SxUPZR39dJ52q/SJl3cGhd8?=
 =?us-ascii?Q?NpAlsOUpUaCaWN8e8jrBvBAE6/sp5lZBXtXPE0peqYeTM1YwzDkb3pysPSA5?=
 =?us-ascii?Q?i+30pidvOzPy0I0myESC/eOnq7Xqu3ne41cZhjTU1ED5S7jFPDf4dpcV71nV?=
 =?us-ascii?Q?svLRYCiwTv3FREOqxgWkVmcigNnrUOHChkKXFT1XsBaqRfyDD+CrYsG7WgDf?=
 =?us-ascii?Q?yMJl07ItpubE3wRPfS3kzEtgPCIWTlWTOsJu3S6o0rbDN1CcMR6FwvQS7mDz?=
 =?us-ascii?Q?NdqJPXV4fMxdpReCNTgvP/yuiMOepGQsIs5s7WVLu/C6zkp6SGcad+/n2m6L?=
 =?us-ascii?Q?J2PK2UvL4kVWBfjgpYDQuu9iwJ9DgRAbHyTkAC5NiEMncBMvDthSEicbUanO?=
 =?us-ascii?Q?XQ+lIpshUSoCazXRDoMQawv+C4GjoUEWtI8+RCHOFqEoD9WezKaWwep/SCY8?=
 =?us-ascii?Q?aDQGFi8eeTyKz4Ik+bpPLxAahlMWjqc1NAwGY6dGFGwrMWTk+eA6CpSk/REi?=
 =?us-ascii?Q?37/IhXzztTK7ZuQW8Id0XxBU+sUODdyDECUmnIKVQaEEf1rQpa5RWA+7AR2o?=
 =?us-ascii?Q?+ClBL+1aNplW09WVN8tWoqYgDEUlvC8sog9DdnH3d7xHmRflsOqVM73SOVvj?=
 =?us-ascii?Q?lOU5aevc5+S2t5VI9/t4Y98=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd763cc-3e30-49a0-761a-08dc44ce1e7b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 08:58:44.6587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QOGQb7PLJtIlp6C1sCVOKWSF1k+90yzkJP1X4InXwF6UodLp666ctsx6mxPcuoi0xvGWzDAU57E3ornhZdrgmtdyPnY+wYxrS+aW2IQiJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7317
Received-SPF: pass client-ip=2a01:111:f403:2607::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 35684f7e21..af17a43fe9 100644
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
+            GError *gerr = NULL, *gerr_exit = NULL;
+            g_autofree char *size_str = g_strdup_printf("%" PRId64 "B", offset);
+            const char *cmd[] = {"lvresize", "-f", "-L",
+                                 size_str, bs->filename, NULL};
+
+            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
+                                   NULL, NULL, NULL, &err, &status, &gerr);
+
+            if (success && g_spawn_check_exit_status(status, &gerr_exit)) {
+                return 0;
+            }
+
+            if (success) {
+                error_setg(errp, "%s: %s", gerr_exit->message, err);
+            } else {
+                error_setg(errp, "lvresize execution error: %s", gerr->message);
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


