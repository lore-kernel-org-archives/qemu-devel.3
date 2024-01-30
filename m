Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05172C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkCq-0005GV-Gp; Tue, 30 Jan 2024 04:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rUkCm-0005GI-6q; Tue, 30 Jan 2024 04:14:56 -0500
Received: from mail-vi1eur02on2072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::72a]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rUkCk-00031q-1v; Tue, 30 Jan 2024 04:14:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7YUTrtIefZRy5LV5jBr2sE/rZrKXwMpapHBX3QFqOh9r0fFiweReaMo1RhJ7AzfRmU5EAWWiUkWyTKAmGDD6xq+aUr62fJLVtRTumAJXzW0Cfs06QmtLAdGMJ2Hblw8adTJ4z3Fomi7nB1uP2ZAr8cHxyiotsVzcsmnbtFyRo0UH/mD+nxhRptXIPdA+/O5XN5x9Z/jXwE1qUYYj38oTFowxhbdO3/n3O3oBYksCCjC6GMvec8iGLKk1bkegc482YwA28SY3f4jlUtQ2ngW7DG+B3lkjfc3dU1PFgMCtqpNQBIkDhKUHdZ40xxtq5NzL1tx3Sh5IvUrKm9t95uKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMmx+r2TjpCB5oQS0w+GjyQw2qxEvy1syDcYI1Wj0ww=;
 b=EcplK+rLHlyYTqN9/BDudE8yweuup6GkMk/daNC6NTBasASYm6uqAMivlv7ke2sjMISd6dFUCmz48s+xnwEuWy/Zd1V10IhM77xCNnWW4cK0AG0n8vtgCqQP4avgjzRXqLQKLO2gauvujx9iaAbTMSyIH7s3efM3O66isRW/f89yXuHaamn5D+sat+Lnu5PFb0erwi5kWLY5HeZ9hJjkYdF8bbXYMF2+f8Kv9347CNOdrY+nAQAv7gcFR1khqetcEHSWzWC0JzV5zqLSL6sJ7/KzteaxkN3PC3JpZMxFPrVUipnDrhmLyVAoZhdzAen9AK3IhMjNzUBW4kf+EYYpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMmx+r2TjpCB5oQS0w+GjyQw2qxEvy1syDcYI1Wj0ww=;
 b=0cb5Ya8V+M4d0n2iP3Y2E7TDt7RHHnLuoIdrQ8LkxAdxOFR4kZ9bn3JZVFrpMdgsbXuq98UQv01scqlbP1UIBInnb4AGxcgseg/jaHEL85z8SGrUGs96ztkcmwwfwGn7CY8rPWVPxBu3YoIDq39JwKBP1FduEmyvywYAdSTvPHo98gnyI5aqi2JQNQdLQBCaeOWcyup+Eee7V9bnXIrKHHu18NncOyKTuHvpcY/2JFq85VRh9Om61HhQLZHywjx+bIzXTpLFsXcznGHpsTtNeznWecv2K9XcN/YCL9YjkQ7nzl9wXsM6RnF2SIEVsqngpdrd9Wzkx9hc/GqdmT1Srw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PR3PR08MB5644.eurprd08.prod.outlook.com
 (2603:10a6:102:86::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 09:14:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::567e:e2db:3928:5839]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::567e:e2db:3928:5839%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 09:14:47 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH v3] blockcommit: Reopen base image as RO after abort
Date: Tue, 30 Jan 2024 10:14:40 +0100
Message-Id: <20240130091440.2346274-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0214.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::35) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PR3PR08MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d9e432-8faf-4a66-6e39-08dc2173e7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TN3D0zJClE+SUhNGHiNhIjsoumu/NJ7HDHIzw4t3RiTRRDSkMsdZem32mLMHbBFcW6BwuoRPSky/7wnHDw6G7m5NgQjRYm4oUXJuIGmu2Bjoe3uqvTh3IUvi46g6UZr0qJtmJxGlILIoxnf0544yduWUdeP2bYk6HOMxnyCGkPJGrzEqEYQfDOeVrXjBJUp/Fc8eLiW7HtesUpznT2JbLPsU1CUJyLMOP8fCtneIsH+6kinFUkAl95IpqvkzFzP0MPGNkpMI+1UDUFPQK+n8GKoCalVU0sm1zmFRSU560esuucdnveSi9OM0DB0zFplhYTE15E0yECiPIhwFXU4yhy4hGVJnLbluvUJRx3QvIsNN3yErMFwPQL+ud6KguBg90pSudPb/vi9+Ux9cDZ1MduQi5yf82M8RP0GmowLdONhN/uVAHIB1hMqxEY8+NtjW7Cqfi3ofbLUeYq5EnGmddQTcuUs76QTxX4WnJOZKGZZmvIN01Gllgdld/GWTch8+Oh18jLQQTumeTmCkXUdDxTsMXKCdsQbqXgHyTx8NIluBWm4GULG7Do8e15Yt2+h98QM60+Fgqfz9JSkW1496LONQPeu4qEwiZ0IFP4Euy+fSvJbGRXYEwXrazFjYc8H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39850400004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(38350700005)(5660300002)(44832011)(86362001)(2906002)(8676002)(4326008)(8936002)(6916009)(66476007)(66556008)(66946007)(6512007)(316002)(52116002)(1076003)(36756003)(2616005)(6486002)(478600001)(6666004)(6506007)(41300700001)(83380400001)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6+DtPFzkO3covgroE8JoyrEH4NvDOSfXSD9AlZi8138iyCCYn3ks7+LGt4P?=
 =?us-ascii?Q?E0nfU+leTYbt6pGODnhBjvSVbD7IaRUrBTGBdEM7kCG9i14F0sDA9ba6kPAw?=
 =?us-ascii?Q?qZ6Hi+b6hbgXWRdty4dZ7g8w/qspdSKaTABcJlPFJktVgo6K5qWO63yzHE0D?=
 =?us-ascii?Q?zhEMkvDaF9SeGAMdnDcPKJUjKRyo1XG7Nq9qgtt6LVRSzOiR7KhnA5POuAGh?=
 =?us-ascii?Q?qFyvIp5sOwJo5kjjpfotH1C05yUqrEVlquvZNm8L/QQJ6g84kz6DGjqAbRl5?=
 =?us-ascii?Q?YH8OKuPih5Zgamanjm0UJuz50SPRsebOc3DZWoaRirrY+Am6iO60wDJgKccQ?=
 =?us-ascii?Q?ujQJDg4qHbdzy49rJv3yCwn4Ibybazb27B0b+G7crTKv8Jy+35ilcogkikyC?=
 =?us-ascii?Q?+PEGEOW0YUPMbR7k4rfqBNJA3J1bZaJPM5R8e2S6jSzc0niysgk+Om8Yqaro?=
 =?us-ascii?Q?6dwuUN9JHBObt5jZGVsyFCqTpN1tR74h76ybyhJV+B92EzFRuqLLcNiY4+VR?=
 =?us-ascii?Q?bxeUFxYlflS9c5iVNqckXRXF3ApGWrd5yjpBLcI+YsHT2T/5DOON9PgDjQKF?=
 =?us-ascii?Q?HOZklX2/+kLDFX8i1KioAlMhdu7GPHle7pz1bP4c+PpD+kt7SPmLvvywvGow?=
 =?us-ascii?Q?Q6rJ7V7/2rR7t5HKualPOa2DMKeggyN5u7YAMIg5SRS7K1Y8wjXsYVw0oS/b?=
 =?us-ascii?Q?KD9uE7/1C+N5To5LHaKjmOfKSVa3zY0DDG1ynEaOfhva8YBY2X0U3o57JVWt?=
 =?us-ascii?Q?imp8P/b2Q+uV5t384Du+9EWkUkLjhf33BSMnnvV1Wl6rDTAmBJya3KiQyIUh?=
 =?us-ascii?Q?21jrsQpG7WUUHVkF4JP7hm+il3++TErOpRYGcHsTCu3p1FG7Fx9UDZBHy1ZR?=
 =?us-ascii?Q?hyyITCos4VK+TlJPEC0qp/dtYPBBvTebzYPSqtRXw3hQAN0Y7m6nWwiWTKxD?=
 =?us-ascii?Q?yHc82u89f00bJ3X34LrgnCE4q588u5qAw65C544GtgrUr6BBoO9EgXM2mn2O?=
 =?us-ascii?Q?HsOjvPvvh+1Lc1QfTKiwbM79AOx2jUFdbY3lUKFpXyGW85JUjQdR7BigTvNg?=
 =?us-ascii?Q?/nwmI0JDIfovDSDsdr0Ca6YkqrxQSXkvcRqjXq9I5v5ZVoFBVGVFE8Gf/aRb?=
 =?us-ascii?Q?xxxi7jcORw8Nc3l+OU8jJJxus5mCE/P7eqJdI2bG3vjYsUGBYDxLgLXMwoZd?=
 =?us-ascii?Q?VRvFJ7TG2lNLCmiGV5DrfR7oWcf9qmNVwDHGJZ/wV5TQQFLoBEtDmVntqQjQ?=
 =?us-ascii?Q?zIfaX7PSoF3CvcndhwBtF3TDUgn3MWfH2n0Rs/KnisKS6qdGPjsSdWtH7vp3?=
 =?us-ascii?Q?H/4u3UFnH4DqT50YM1qMN82DvI7u0IGCBq+MF5ZrfSBEX6RKAu2hB5pQjPkh?=
 =?us-ascii?Q?DSk9B1HblIMngoIEdJtr4RRNb3B3/bu0Q6q9N6APsz46P3fpjHyhsvuopdB5?=
 =?us-ascii?Q?TUTNuGNDKnV1H5AmpBER7BTUNHps/HrByHSi6GOQ6dYdlHSBBp/jMyr+C9AG?=
 =?us-ascii?Q?lTXkOxKim/A/TqV3c1DPbb5OlbyTORe3DuA29Bc4cifQhMuL+e6B3X8fCnVX?=
 =?us-ascii?Q?nt80NUetchmpeItnBxW+h7aJKdHMjZ6qP4Droy35XdBSuZnoY7e0BL6jNd34?=
 =?us-ascii?Q?MpZ66OQofFpQvDiAwfEC3PA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d9e432-8faf-4a66-6e39-08dc2173e7e5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:14:47.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA8gQs0un7wykpf3wgqYKVwE8DRX73BlCqf2EwJyDWG2k9xQdVT+LiK68SvIVvO1DB2ESE8CqqFRcKa1dH+dnOir2UIaOMBupF/XYNlXguM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5644
Received-SPF: pass client-ip=2a01:111:f400:fe16::72a;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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
mode before blockcommit, check if src BDS has refcnt > 1. If so, the BDS
will not be removed after blockcommit, and we should make the base image
RO. Otherwise check recursively if there is a parent BDS of src BDS and
reopen the base BDS in RO in this case.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/mirror.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 5145eb53e1..52a7fee75e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
     int64_t active_write_bytes_in_flight;
     bool prepared;
     bool in_drain;
+    bool base_ro;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -652,6 +653,32 @@ static void coroutine_fn mirror_wait_for_all_io(MirrorBlockJob *s)
     }
 }
 
+/*
+ * Check recursively if there is a parent BDS referenced more than
+ * min_refcnt times. This argument is needed because at the first
+ * call there is a bds referenced in blockcommit.
+ */
+static bool bdrv_chain_has_significant_parent(BlockDriverState *bs)
+{
+    BdrvChild *parent;
+    BlockDriverState *parent_bs;
+
+    QLIST_FOREACH(parent, &bs->parents, next) {
+        if (!(parent->klass->parent_is_bds)) {
+            continue;
+        }
+        parent_bs = parent->opaque;
+        if (parent_bs->drv && !parent_bs->drv->is_filter) {
+            return true;
+        }
+        if (bdrv_chain_has_significant_parent(parent_bs)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 /**
  * mirror_exit_common: handle both abort() and prepare() cases.
  * for .prepare, returns 0 on success and -errno on failure.
@@ -793,6 +820,11 @@ static int mirror_exit_common(Job *job)
     bdrv_drained_end(target_bs);
     bdrv_unref(target_bs);
 
+    if (s->base_ro && !bdrv_is_read_only(target_bs) &&
+        (src->refcnt > 1 || bdrv_chain_has_significant_parent(src))) {
+        bdrv_reopen_set_read_only(target_bs, true, NULL);
+    }
+
     bs_opaque->job = NULL;
 
     bdrv_drained_end(src);
@@ -1715,6 +1747,7 @@ static BlockJob *mirror_start_job(
                              bool is_none_mode, BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
+                             bool base_ro,
                              Error **errp)
 {
     MirrorBlockJob *s;
@@ -1798,6 +1831,7 @@ static BlockJob *mirror_start_job(
     bdrv_unref(mirror_top_bs);
 
     s->mirror_top_bs = mirror_top_bs;
+    s->base_ro = base_ro;
 
     /* No resize for the target either; while the mirror is still running, a
      * consistent read isn't necessarily possible. We could possibly allow
@@ -2027,7 +2061,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     filter_node_name, true, copy_mode, false, errp);
 }
 
 BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -2056,7 +2090,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
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


