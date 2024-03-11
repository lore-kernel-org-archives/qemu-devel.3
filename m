Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C01C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkHI-0007EK-Lc; Mon, 11 Mar 2024 14:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFL-0005ey-4Z; Mon, 11 Mar 2024 14:19:38 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFI-0006sL-0d; Mon, 11 Mar 2024 14:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBJ+tylBlDg9eaKUnUDRX7T+RqaOojy9vS8C6P0l20oTUakupZiTkbjgKZBpEwLPmKxtBs9AoymlEqHXaIM+h3sIf0uSR6JQjiPnEA9tdZsnYZjHz0MgdpKDAbP/2deZMGRDBBMV7go+q5zr5xKyPYE5DzU7zI8hoVnH7rDClMYeeBV11iF6gVnLeflgDmLCayvZK44t4GzmZJQIfUjeaSSYDWKpWUg/2QduF3YtWCr3h0Fkv6k5obYtwQ3yNi5yZ/bZaRjqFrlarq2E3nfeuwo7CmEdQmR2SpiQv0ynWYwp/JiWCiH++qCPdAJUXNki9pAuhanI40tpo1HMuvacMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVnixjw7lkJ54tHkRd4jqdxwrGt9LLZUeAm+hZX+jOs=;
 b=Yno4pJj58Dt+0B0J37dIhnbdA1k7bnCTP5kEJBulVSKfGPwf9nDsK/uBH7ix0hbufipK2MBqjR1sIQbMw4IeJdzcfOcQkzhvbisSpz07Tc4mkqTAANllp3CsWF5cKetPLOi1CO7Iy79Pww/vnXbIK42Yiun+qcmLCkpeqz1q8aLRkrNAroKoC/f6W/0zMJr7si15QDm4DZnMWwUw8eYvuZo5Fp6HA3/DGGxPb47tr+j5Xnntsm0nta9IzFJTCTfYV4q3tv3iopv4d0zMVDns164jHpT095SwYTGrHP2tFAI4vYPVcud9AmdG8VEwxncpM1n43RErICUa31/z5pHalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVnixjw7lkJ54tHkRd4jqdxwrGt9LLZUeAm+hZX+jOs=;
 b=dQJgPQQ0LGp96oSilermybIGGzQf3we5btCbBbm51qGoHqri+8c3oYD5hMXMlIys1O567tP6+G/3K05tWhGOBIiPUZuE9owHmDNJLI6mREE6SgsRkISHEqkDaRrwsM4oKphao/UgSBnMkO18id2oT1mBpLDinFGa3gkFggotRuzt9kSpG6Kgh1ezOi4Xf24dLRiLlM8z4+lhL0gPwEsb11KpZJTgtjqmmhq4F3f62RnKKYNmCg+vl5PWaO7OJkSjNqqjij7svmmVV9QrU2r3HmxRrZT0vpmqPpcsc5JbI+UA6/HdeuE7eFD4Sfr9ludCuvL11wJZ6nrzELJ3VOWhOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:05 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:05 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 11/22] parallels: Add dirty bitmaps saving
Date: Mon, 11 Mar 2024 19:18:39 +0100
Message-Id: <20240311181850.73013-12-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51cda284-1203-421b-a591-08dc41f7bc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjUvmshbBdO9Mtdxsy+Q5c465AP61a486ntE8m1EPLKXEcxLoVvtxYm3D8+SI71kQ6uV7+CrkZ5xEZWLbVg5csDU+Nbi1h5KMzv4vdtrlpQn3bqkQIV6BlsjVlB8PNR2fCnh78UGAykRNXDR6EC/ANx3lgJcc7WT7DfOUz+eVh1tEN1TMLyKPbeJSx4tBhqz3+M5hCquM6iGXPvnsCzAYpPDGVicG+cyKvtdPIQn/lqkDPArQ691+fAqwLXEybkZ7ZkFbrXeSBbr4BHOMGWp5aNPulqjxkjaxOhGAO0i39O1FLmV7XtrOmb3K6uBprniUxjGu0oYn/C92gXd9nmkwKffClEnN0qIMCyYtK2U83+OWPAQreq3dKHoHE0/tqAXB2ypRz6abLWU7LLPLfXDPDitrny4QMkzrW1vB2TVr+/+tmWcYlGlBYcr4vLOopXHni/xU4ib3kwmryYR8quDsQu3VXEvQealojkKFKjYYAysnylr/Y0iPHN8p2UOGBM1p7K0IMtl/mZOg0hGoiIPgZ86GKZqiP52YEiTt6xqEpqcEeirImnONWyICY6sjOMirTOSwIK1wwNMWXAhcQy+9hfyg9aH8rn+vSfqWUIt7n+sX1Zd/LEq6SNzdmk/V/1aZr+Fea5v7UH0xlZPzul0hnoLHFYBeG/lpsNkX3OoXbLuq+GDf1J321E1zHkaF+JGjdPhg5fbvORinpVjYqwLnizZtgHD5c78E8GGwXCGeIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQmM8Eu19N1PTdYPAA/rtulxecCjQilBboyIeuFRerHBjAWV0AIc2zmVHQ5c?=
 =?us-ascii?Q?yVBFMPD/YnJyEGbDM9t4HJWqjNXgyhucFRAWHTQvZf2qX06XSa/cN9Sf+ICP?=
 =?us-ascii?Q?9Juts23Uqs1lxoyKBAdH0vpGkRJmo6C5FxqxbEHh7/zTO46YVZHNw0mkoucr?=
 =?us-ascii?Q?d0UOUY4sLWWUGvLM4HjN1vnMGcb/aImcJrajLkTRB5rDDZp/MXfqaVcVYGbk?=
 =?us-ascii?Q?Eisag/FmIjz/HY23/mjBchKNqT8cneabF/ekcTA2uAkAunX6YU9YW/WSpIWE?=
 =?us-ascii?Q?6ZVfZ75sgCshUqiySpm5K4sHB+FphLSNLjnc98GesCcA04GbRdIdIkyyTOzj?=
 =?us-ascii?Q?kH9Sq4kx0oAtOO6qhfMuoPIQTFhMWL3GZ5jM2hKtMfmLQ9OP58OVQgC/Rtzj?=
 =?us-ascii?Q?EUm0+MsnDceSkJdoVe5+p/wzv2Jo4AajbebdUgEFy5C3Z4c+RLy0vsgq9g48?=
 =?us-ascii?Q?am4vI7FyVS9jKDO2Jjx9VOMMu7iCTMnc44SVzPUrnWX1W0rarcoUZpSZfzAF?=
 =?us-ascii?Q?VlL5HWwHeKi1+Ihzpud2EcoJUp9UtFNWBmGuZt4EH93B9d3lpM4H1Ai/QXym?=
 =?us-ascii?Q?OSY5o5QgCnGqmocD26YsumSbmCYT/IkvBwOIJNrcpmNyAS1ZoXWAub4nQFtk?=
 =?us-ascii?Q?N/bRhTa1uX0pNAaEdZnVzK4TpcOgDZIfvHIEL0Da4pW/ZmipoWWy/nlF61T8?=
 =?us-ascii?Q?sVpzdzWpSKRuMpKxUU1m/PgTDIjHsP9FZV1caw81/EcKMK8xqZBTN7d4Sz+G?=
 =?us-ascii?Q?0LTv8JeT4uOJ8OYN9gg3E9yLnEnA9K5sb9q8CB/8p0u3EFmCNgcyyU2CtEph?=
 =?us-ascii?Q?nvBDTYxiyX0y4FOcOfVz0IzTq3okKPH6v+8pbZIf/lzasWT7GvklH/A98+Cc?=
 =?us-ascii?Q?LvpdIeqR9HKg78ZPWpcFwDQCEjMKUm9XxcPyXCMpz+CEfyU9QGsuTp/5v3Qf?=
 =?us-ascii?Q?K1JtclaRO9hekXMp/6MtxqdG5m2AgNz/B09DR05KSb2SJmnnzn4meV55+WZ+?=
 =?us-ascii?Q?29QWX5ACVveHBhQZjm++fqeWPjTIKjYKBmhl3zrUiRlyqm7cehUO7cfGwVpy?=
 =?us-ascii?Q?PlgDyLyRDaidk0UbZ2X3tEiEC4K2hRh9y9mU2b26Q2LY75P0ExZ5McQSo2Mt?=
 =?us-ascii?Q?UvQjSbiLEvSzi+7mfeRgen400Zv9ejoouDdsVOqXIvT1ASHuCagiT2vHjBsY?=
 =?us-ascii?Q?V+Pa83tW2gGKUO9Fxh6BhwaJlmTEp+6ejbEiQjL86LTn3msgEJgICPF0YUfs?=
 =?us-ascii?Q?+c3chItfFv2XLsSd+Gwk8vrfXhrdGiOGtaMKAPlbxVwKdFgyPjavlKJq2M8T?=
 =?us-ascii?Q?ent++BU7nzZ9S7Vrr1O8RSxC/MWgbA3Aj+KnHrk3V0xD5M9S89uBzZ9Zmh+4?=
 =?us-ascii?Q?GxyhFdk9/5dJeyb8JMtI2v+igzw93MiJI//wWDYTflTRQtd4W+tVm/LeHs5I?=
 =?us-ascii?Q?NWfxReEuNWOd9mNqDWSziLAcm13LOoN7k7c3mEszziXBSz9aBXuPrgDA7Pwe?=
 =?us-ascii?Q?bWGWJogJ0rJiyQFkZ9XKjf/5cJP00RvQB7UDK5jkpM93duwhtt8rvvqludYN?=
 =?us-ascii?Q?U4m1x+we8pyQNEfQIC81dro3PROWeltM2xYk5ooPsg5WsGpUBWLU4XvkKBJb?=
 =?us-ascii?Q?/5UL4VGeZeItubd1CBj/biY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cda284-1203-421b-a591-08dc41f7bc48
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:05.2775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFHm6LlHIXruobEsHN2h/u+l4oJlOXe1BA0wFsRYzMqqXNbQ2mn79Jkp5pU+DBAiw0Z8FM9fPAsTlCqf8pXzqw3dAvadCBvF+jhZgS53TTk=
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

Now dirty bitmaps can be loaded but there is no their saving. Add code for
dirty bitmap storage.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 187 ++++++++++++++++++++++++++++++++++++++++++
 block/parallels.c     |  16 +++-
 block/parallels.h     |   5 ++
 3 files changed, 206 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index b4e14c88f2..9cb8e65c0d 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
@@ -300,3 +301,189 @@ out:
 
     return ret;
 }
+
+static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
+                                               BdrvDirtyBitmap *bitmap,
+                                               uint8_t **buf, int *buf_size)
+{
+    BDRVParallelsState *s = bs->opaque;
+    ParallelsFeatureHeader *fh;
+    ParallelsDirtyBitmapFeature *bh;
+    uint64_t *l1_table, l1_size, granularity, bits_per_cluster;
+    int64_t bm_size, ser_size, offset, buf_used;
+    int64_t idx, alloc_size = 1;
+    const char *name;
+    uint8_t *bm_buf;
+    QemuUUID uuid;
+    int ret = 0;
+
+    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
+        bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        return;
+    }
+
+    bm_size = bdrv_dirty_bitmap_size(bitmap);
+    granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    bits_per_cluster = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size,
+                                                                bitmap);
+    ser_size = bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size);
+    l1_size = DIV_ROUND_UP(ser_size, s->cluster_size);
+
+    buf_used = l1_size * 8 + sizeof(*fh) + sizeof(*bh);
+    /* Check if there is enough space for the final section */
+    if (*buf_size - buf_used < sizeof(*fh)) {
+        error_report("Can't save dirty bitmap: not enoughf space");
+        return;
+    }
+
+    name = bdrv_dirty_bitmap_name(bitmap);
+    ret = qemu_uuid_parse(name, &uuid);
+    if (ret < 0) {
+        error_report("Can't save dirty bitmap '%s': ID parsing error", name);
+        return;
+    }
+
+    fh = (ParallelsFeatureHeader *)*buf;
+    bh = (ParallelsDirtyBitmapFeature *)(fh + 1);
+    l1_table = (uint64_t *)(bh + 1);
+
+    fh->magic = cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
+    fh->data_size = cpu_to_le32(l1_size * 8 + sizeof(*bh));
+
+    bh->l1_size = cpu_to_le32(l1_size);
+    bh->size = cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
+    bh->granularity = cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
+    memcpy(bh->id, &uuid, sizeof(uuid));
+
+    bm_buf = qemu_blockalign(bs, s->cluster_size);
+
+    offset = 0;
+    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
+        idx = offset / bits_per_cluster;
+        int64_t cluster_off, end, write_size;
+
+        offset = QEMU_ALIGN_DOWN(offset, bits_per_cluster);
+        end = MIN(bm_size, offset + bits_per_cluster);
+        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
+                                                          end - offset);
+        assert(write_size <= s->cluster_size);
+
+        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end - offset);
+        if (write_size < s->cluster_size) {
+            memset(bm_buf + write_size, 0, s->cluster_size - write_size);
+        }
+
+        l1_table[idx] = 0;
+
+        cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
+        if (cluster_off <= 0) {
+            error_report("Can't save dirty bitmap '%s': cluster allocation error",
+                         name);
+            goto clean_allocated_clusters;
+        }
+
+        l1_table[idx] = cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
+
+        ret = bdrv_pwrite(bs->file, cluster_off, s->cluster_size, bm_buf, 0);
+        if (ret < 0) {
+            error_report("Can't save dirty bitmap '%s': write error", name);
+            memset(&fh->magic, 0, sizeof(fh->magic));
+            goto clean_allocated_clusters;
+        }
+
+        offset = end;
+    }
+
+    *buf_size -= buf_used;
+    *buf += buf_used;
+    qemu_vfree(bm_buf);
+    return;
+
+clean_allocated_clusters:
+    for (; idx >= 0; idx--) {
+        uint64_t cluster_off;
+        cluster_off = le64_to_cpu(l1_table[idx]);
+        if (cluster_off == 0 || cluster_off == 1) {
+            continue;
+        }
+        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                              cluster_off << BDRV_SECTOR_BITS, 1);
+    }
+    qemu_vfree(bm_buf);
+}
+
+int GRAPH_RDLOCK
+parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    BdrvDirtyBitmap *bitmap;
+    ParallelsFormatExtensionHeader *eh;
+    int remaining = s->cluster_size;
+    uint8_t *buf, *pos;
+    int64_t header_off, alloc_size = 1;
+    g_autofree uint8_t *hash = NULL;
+    size_t hash_len = 0;
+    int ret;
+
+    s->header->ext_off = 0;
+
+    if (!bdrv_has_named_bitmaps(bs)) {
+        return 0;
+    }
+
+    buf = qemu_blockalign0(bs, s->cluster_size);
+
+    eh = (ParallelsFormatExtensionHeader *)buf;
+    pos = buf + sizeof(*eh);
+    remaining -= sizeof(*eh);
+
+    eh->magic = cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        parallels_save_bitmap(bs, bitmap, &pos, &remaining);
+    }
+
+    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
+    if (header_off < 0) {
+        error_report("Can't save dirty bitmap: cluster allocation error");
+        ret = header_off;
+        goto end;
+    }
+
+    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
+                             (const char *)(buf + sizeof(*eh)),
+                             s->cluster_size - sizeof(*eh),
+                             &hash, &hash_len, errp);
+    if (ret < 0 || hash_len != sizeof(eh->check_sum)) {
+        error_report("Can't save dirty bitmap: hash error");
+        ret = -EINVAL;
+        goto end;
+    }
+    memcpy(eh->check_sum, hash, hash_len);
+
+    ret = bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
+    if (ret < 0) {
+        error_report("Can't save dirty bitmap: IO error");
+        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                              header_off, 1);
+        goto end;
+    }
+
+    s->header->ext_off = cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
+end:
+    qemu_vfree(buf);
+    return ret;
+}
+
+bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                                          const char *name,
+                                                          uint32_t granularity,
+                                                          Error **errp)
+{
+    if (bdrv_find_dirty_bitmap(bs, name)) {
+        error_setg(errp, "Bitmap already exists: %s", name);
+        return false;
+    }
+
+    return true;
+}
diff --git a/block/parallels.c b/block/parallels.c
index 86958506d0..9536e4241e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1471,14 +1471,25 @@ fail:
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
+    Error *err = NULL;
     int ret;
 
+    ret = parallels_store_persistent_dirty_bitmaps(bs, &err);
+    if (ret != 0) {
+        error_reportf_err(err, "Lost persistent bitmaps during "
+                          "inactivation of node '%s': ",
+                          bdrv_get_device_or_node_name(bs));
+    }
+
     s->header->inuse = 0;
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                        PREALLOC_MODE_OFF, 0, NULL);
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
+                        true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret < 0) {
+        error_report("Failed to truncate image: %s", strerror(-ret));
+    }
 
     return ret;
 }
@@ -1530,6 +1541,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
     .bdrv_inactivate            = parallels_inactivate,
+    .bdrv_co_can_store_new_dirty_bitmap = parallels_co_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index 493c89e976..d1e46dcfa8 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -101,5 +101,10 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
+int GRAPH_RDLOCK
+parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool coroutine_fn
+parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        uint32_t granularity, Error **errp);
 
 #endif
-- 
2.40.1


