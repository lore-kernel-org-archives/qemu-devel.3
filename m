Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31234C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpls9-00070r-1O; Thu, 28 Mar 2024 05:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rpls7-000702-2S; Thu, 28 Mar 2024 05:16:31 -0400
Received: from mail-db5eur01on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::706]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rpls4-0003b5-Am; Thu, 28 Mar 2024 05:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFPVL/zSXfyiVFzD0MGS+FqFH5J2TSj8Dm8kvYY8GvhjpegubkQb3AVhE1aN2LYC5Iy/9FoGvmt+19y9K2LKZzSc2dotwIJV8Hf7JMtdFBfnMiGaLD7NzEWZOtyRnfTy+r/grYhtS1CtqXeTrwfTTwyAy9xMpzfqTtgfJc3abRGNJfK8O4JxY1jlcrbvZItE3MXllaqa+GpdRMilG9YdXkDlrflA18fhrpzaIQg+f8wgAJYi3Ql9OSMJH9gKv61QlWscm8SEHYnO6Q271Q9gno9J9H2XGVSQGLilGyBacL1xBXK6zml91ARClXpBCvQWHS1MH9116f7SfD2oKcBcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anf8fn5o1Sb5/wbAHn/oQhFb8req4TaQxgnH15M1leU=;
 b=A8p5eg/GzVPE7O8ggTB6ZwVv14rBalJvdf07lEkCPHcm+O2henRowrSEVxFu04JuzSlzZlUQoxMoHZ8bNILr7zI177pSrudTNieXbk0hd6HELQXe1OK/NEhVbcqgYzWDhOXdCnLpOVxUu015RZqf1/Wg6ViX+Zgajvv/IXUabHj0SW1LlBUQtsdas4/6H5YBU7vWWRTteSxgWQZl2PEIPtNQLvccMl4gPH9Lr4Jm3e5BCm8decCTn7QsAkUM4Blv58vrIAUJK+9Illpza1JckeSf246skY3OC2exwyVYnHZcays9d+BpFDfvHs7JB7y44E2r6vJWUL1EUAb4IK2UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anf8fn5o1Sb5/wbAHn/oQhFb8req4TaQxgnH15M1leU=;
 b=L3ZA0Ss30dWRsgPCP0JGhlcVQIPW1VbRpn+mC99npb10oc3i+WZ2Or56TYz4+alqmG7Jhg4AMu53frMnOGWNas28QbdyzQitzxI8t5zuZPRSsZHB9xcYgm+qjfL1ZdeDqhF441db5TsMxGD8XEr445NnOxs+EFd54p1ZAwMxqMN82qf7gS9vO2fJZ3p4lJ+TuBclDz3VdX0zTjnAIwL6GAX7mWwAVowx5mUD0eoTNMhUn1ANSNQQqZpcGPqZj8gKoqOEF1uUQ1lQJmn26B2NnrMBOfDYgWWcNi8ebj8yJ2YGIrRgo/VG8nhxhMib1z9Soh8bZvILU8qh07sx6iseRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GV1PR08MB8665.eurprd08.prod.outlook.com
 (2603:10a6:150:82::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 09:16:23 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 09:16:23 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH v4] blockcommit: Reopen base image as RO after abort
Date: Thu, 28 Mar 2024 10:16:15 +0100
Message-Id: <20240328091615.335620-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::48) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GV1PR08MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2652fbd2-995e-4897-d2df-08dc4f07bc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/W5WfT1vLjAsCELwTj9RsQPunBdVxvh+oQfdNxjwG1x5P8GZKF22Z1kY6K42LHd32Qzdy/lr3eUhwmPT2NSFdp/Ov/AoWLcZPE71S+aU8XGBIrE/25OUD6M4EXADYKQU62NXIqLrLIXD+39z0dd/F7Db7enVzsweFPduREIjYrLvNWdFL7slVc0dirul9FnkBCSbnZxd8/ysGw6QBPpIR9UMfdrg4hL7Nf9nFzfQU7IicbZ3DJWTf/VgJ86EB3hVF8P1s03qtFlsmzNWS5QbMhiV55q59rhMUhCiIkNsDRcBNDC59jCkvv+ot+w3jpxYpVGU6/QDvPXnq0s90GYpSTJ3bBgDjLJhiTPOFKmFc/lpnMX3DkI+NhR+t+LRiPqAuu4QqeSuBo8MGXh2DZtKRlZIBDJNKXCzzBy1KO4Ap80wltXw+uxjoMgrMDWvBkRm26ugXp/LJS58iOhya/+aEypiHek7CNouCFX14ERJnq64KC2N7pMnJAK99BDeodrsMMfL9qbBrM0Bj5uOApXNl720r43oyjVZEYITeMd2XXrOtOt+GArD8a9VR1S4Pzsr32+5NoCM/JWKiBAZ60IK+VbN/pWj9f5ypfxBcz8KDFtJ8fRBU1ZBJZcfuy6PTzfIykRSDqjo6Jv415LTBDEROxJ3Xxp7JTa/rkpJlXoRP2tEpvX4femGVFE/tBGR/6tu61zg8HIAUQR4DKAuNiyb6hJkz1nTUEiGLxWLOP+nfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+YaIriOQ6B9lXjgxd8nyqiLgoH/fKiNhtxzjKF2DMjXOaEwlgvNt+TtxoNC?=
 =?us-ascii?Q?0zOdVXum8jyiwbpXR7Et4IJoRVSLp4qb3jurnrNVWWopzsDS3grvpx1Ks7FD?=
 =?us-ascii?Q?MUki5469pS9GKKVnV1fKK5vf0NnmxJGT1KswV9eOhMQ9dLpXg5doGBGCpNfV?=
 =?us-ascii?Q?J3W1m8m5vefQi5byBGjElmmFjnSnkgCL+7r9le/AVY0iYpGVDsisD0W/DeQl?=
 =?us-ascii?Q?ngrmZSwpLK8xLddnUPP8L4SaKe3/Y8jZX6jW6TwEJepNBar6p1hMbEz7sfAo?=
 =?us-ascii?Q?q9QY69BPirkK8qwE+WQCDQvZuW/YEug7nJEy75UuqpuTTxZ/c9h06oexIbao?=
 =?us-ascii?Q?HrqTxCAeYAB3Cy/M1mtWCB9htg7c7etZrJm6terpGHySZ5U/ihPNsqs4KLx0?=
 =?us-ascii?Q?u76AdpC8hPEHbGdXOJIWXH+7tZkltRFD15dGLnKQwrEmiZBJkiERJ2e8NnOV?=
 =?us-ascii?Q?zkRTOFJFOedSjwpucbhvf+mE7VEHdv7qP+mcrMRz0P5eXqi94N0exdtKf8ut?=
 =?us-ascii?Q?RGPAkXXfVRdxWhzxHzJYzMjdK5rE0OO7h0qySh44PhR7+cedI1+gzZznTzcJ?=
 =?us-ascii?Q?om2YwjBI9jEx4s3bxjP0YMuLTU8vfnRAoDaJVAMqoEozvqOYfCIztwJSR/9E?=
 =?us-ascii?Q?NVWK01VUNsQiyFq6+u8+MafcH891BiYBMtznYPt1BZSoOWKGoKG0RgA16Zcf?=
 =?us-ascii?Q?Uo9Q5ljTjZo//rJf9TspZ5nhJTz17tVP9JMBZiy0YCtXNPiJGWvqUZlYelAN?=
 =?us-ascii?Q?tanfz7EGKa7hPFvZPGJ1EyaKZ8X83pYuFbYjQBXaz7H9QXEF9mFqP7dx2aK5?=
 =?us-ascii?Q?rqY4rVliG31DcRlIkk0gs/MgCNFBXDuP64doXVaEt8/hthDN7+Q6L8U7Q1pN?=
 =?us-ascii?Q?i5sot60Nsn712eBtmi85BdqoFo2+ysXTGTLR5iW/cOlPl7lR2kBLtWqRA8/+?=
 =?us-ascii?Q?HSwP67O9MsgymaJYOaZ34R47+LfM73q/oucOszVKaONkjyFX1PWEg93nfTxu?=
 =?us-ascii?Q?3sMkJQdAp+sMVJ4LkpQxn3adeKRMfXaOY6bHHgdeGWXQKyxcgHXOpL7au+57?=
 =?us-ascii?Q?dbmLIkI7TALUYGmEeHOqolurYw87PBWS6XFZSJ4tfICaUDJMwmSLVB8CQDmO?=
 =?us-ascii?Q?yDPVKlf9IqRMPiHPGLVwzhRJBCDI5wgP4HjwUO8MickFfmLt7i4q8KmG/gBT?=
 =?us-ascii?Q?iO6QYeM7jmS/C4AIHGxa8HhSArt3oIP6BR8ZaBrIT2Iwzzu816BBGozbrQ1C?=
 =?us-ascii?Q?GLlOHze1uUmpcOZzDXJya1eSZHV56Ehakf0KCNjVIJ9bHSTc8fdIszeLK2eY?=
 =?us-ascii?Q?zUCbB8yFD8lhWvrjXuGcA60egzNqsDL1iinvnvZWJD74m/hn5mDZ4xlnG1fq?=
 =?us-ascii?Q?JYtuMUKvFBzr9vH4wUxljt4gTtCQK/SYXkGPKQWv6IxXrFJnWHRJSK3gqW/R?=
 =?us-ascii?Q?bNXrO4dYtU5exN8PcwypHXNS5WBcR2D7XjjPXjfcCu1HJ9mkNmsNQ0nZHw57?=
 =?us-ascii?Q?8zMptTna2zfD5aqPpKWKCPHFS3Ifc5oixMMKE1LMxgQgXkSO9VU/SB6sKxsF?=
 =?us-ascii?Q?plaLh514iJUTL0uTwzYcikgJuep5ezK7EDlQUkf36b8yBDgaJ9/nL+vW/KKW?=
 =?us-ascii?Q?yXJdrsbqc/yS0hpmhvDNjIU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2652fbd2-995e-4897-d2df-08dc4f07bc9e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:16:22.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mx1xnuI/hSjn5GF3fXfw3tPpEQzoRBXmZkV4iIDyblG7tQ8VONR4Y0xKM6omBLi5EO+iRgMQjtP4SxWoRpGzXylCkH4Uu1/19rM0+X/0oKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8665
Received-SPF: pass client-ip=2a01:111:f400:fe02::706;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

If a blockcommit is aborted the base image remains in RW mode, that leads
to a fail of subsequent live migration.

How to reproduce:
  $ virsh snapshot-create-as vm snp1 --disk-only

  *** write something to the disk inside the guest ***

  $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
  $ lsof /vzt/vm.qcow2
  COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
  qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
  $ cat /proc/433203/fdinfo/45
  pos:    0
  flags:  02140002 <==== The last 2 means RW mode

If the base image is in RW mode at the end of blockcommit and was in RO
mode before blockcommit, reopen the base BDS in RO.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/mirror.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1bdce3b657..d23be57255 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
     int64_t active_write_bytes_in_flight;
     bool prepared;
     bool in_drain;
+    bool base_ro;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -797,6 +798,10 @@ static int mirror_exit_common(Job *job)
     bdrv_drained_end(target_bs);
     bdrv_unref(target_bs);
 
+    if (abort && s->base_ro && !bdrv_is_read_only(target_bs)) {
+        bdrv_reopen_set_read_only(target_bs, true, NULL);
+    }
+
     bs_opaque->job = NULL;
 
     bdrv_drained_end(src);
@@ -1717,6 +1722,7 @@ static BlockJob *mirror_start_job(
                              bool is_none_mode, BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
+                             bool base_ro,
                              Error **errp)
 {
     MirrorBlockJob *s;
@@ -1800,6 +1806,7 @@ static BlockJob *mirror_start_job(
     bdrv_unref(mirror_top_bs);
 
     s->mirror_top_bs = mirror_top_bs;
+    s->base_ro = base_ro;
 
     /* No resize for the target either; while the mirror is still running, a
      * consistent read isn't necessarily possible. We could possibly allow
@@ -2029,7 +2036,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     filter_node_name, true, copy_mode, false, errp);
 }
 
 BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -2058,7 +2065,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     errp);
+                     base_read_only, errp);
     if (!job) {
         goto error_restore_flags;
     }
-- 
2.40.1


