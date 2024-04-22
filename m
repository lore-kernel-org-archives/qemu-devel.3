Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5F0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 01:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryilf-00066d-Eu; Sun, 21 Apr 2024 21:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1ryild-00066S-FZ
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 21:46:49 -0400
Received: from mail-eastasiaazon11021006.outbound.protection.outlook.com
 ([52.101.128.6] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1ryilb-0007vS-02
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 21:46:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE+riaQIZek/yP3NhIMAstlfh7TPTIHYjWZ/GNK8fIh/tpCBop65i12dKwZ9AMPH949D9zgQ8eWkG35+WtZWtKtvK6RIouKqJ+jXX9RNa5JPcLhVUmYz0XWSJ8j+uX65WBmYQk7fplKZZp3BwGEldHi1S+xUrlS2VjkyiXZpgpk3D9o5FowZMQz5CI0yIpV4UNwwWzGd9BHK/FDb6HaJ+lAl1rpgcFyI/5ebrmEBMElv+Pj24ZFdr2ARxnm7o2CsbSwXIb41UPt2v0TZeA1HFGfA4C8+FIQWkTKoIGBQ3RVIjN2BdEsS700oPZOmlrcPWO+V8fk9UtYhJtTrri/PAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4uGrFfxJVn7VlKyBQgVtmViFnv7AWHX4Q256vo99lA=;
 b=SbfvpU8TGed4mLShbigmzFJ/rRWUpFnahRdq6pfvfzLxZ/ofSjr9wMmvvuQJ/4G9AVXB8TclH9gMAJBL90N2JTRzwO2F2S4jMqnhhg2iMIrkeHVaxhhn7Xmq2U7L/uJmV0ADeI77Bd22W7RaOK/DZVkWW8GugYqRx0s4ah0LvQW0n1cQwysM3Ids7aBzV3WBkX3IMN8zXGobY27MmuR8svvbCUeLsSdR7x9tYNmwquMuJKsm4I7Hn2xZ6LDwgln0fx/YzV0Verfb2TDw1XtfpK8VQlIkOY/+irUA/YdXAQgJ5YbHcaZF+pjcKJXpkkyP43caLKnKDg4iEzzCL6tWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4uGrFfxJVn7VlKyBQgVtmViFnv7AWHX4Q256vo99lA=;
 b=Jl9qyvBSCa56CewmIsBtMffqziRcHqs3oU9cgbc+faahyhqfFdh5UxIN9VRTkwOYiwH0mTlyly2u8U96kt0Di7prvI40cEPhDpssoigIJWWSMUCDjbKUtbagkoVJDQdJK6Ym7gRUOXHnYyAu3Pjz0A+Rd8b14u6eWVJtlD/soPsV2RS142kNUcoghY93HuaEqtER9MBHSBBJymA9Lk79ulBKypqtNiByUHfJ+2WPltIoVO5zugFRibK8pyLB+cpDsgu8YroNFcQ8LVrDLEkZBjaoFMkRYj2S79FxMmIaw6EituJ6eKNtmLc7Kf0c41ntRNcjEWtbL4sCgYv3g72Zyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by PUZPR06MB5828.apcprd06.prod.outlook.com (2603:1096:301:e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 01:41:36 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 01:41:36 +0000
From: Wafer <wafer@jaguarmicro.com>
To: mst@redhat.com
Cc: eperezma@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 angus.chen@jaguarmicro.com, Wafer <wafer@jaguarmicro.com>
Subject: [PATCH] hw/virtio: Fix obtain the buffer id from the last descriptor
Date: Mon, 22 Apr 2024 09:40:41 +0800
Message-Id: <20240422014041.5706-2-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0230.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::26) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|PUZPR06MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c6503d-0508-4792-82eb-08dc626d58b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKjyAeE4FXqgRXnPCzXz+FLi/GzjVb28pjMdBFWd+VNJ2lsXGG2NaqtOM4YX?=
 =?us-ascii?Q?nsNkEqWU9zOag65DCa4PCDRKlC56RZbPHvmUPD1xi7jHO7XcgmCOamXP49RM?=
 =?us-ascii?Q?IFJ1kRDTwwvZmrrqmXLqKA2lq3OCrxeUzL+tiY3/QJ1Hl6yXll0whyDJL7UF?=
 =?us-ascii?Q?ZjOzVH/OWSaljmX2SWz5MSCDfIcLmbbLsS3qE3jyh4PbbnqGpFp38PMEk7Od?=
 =?us-ascii?Q?JNs+kuk2ZHIEofKNIv5wfJxce8YemTKsYzwUjdm6H1m7b3pZcaJ7kv/U9GM5?=
 =?us-ascii?Q?RXTEvOjZZaQjaZaHU3p5Bx+7qPhNUA2Y7jdvYcg7cpLfh1x9vELmHgV7zOQF?=
 =?us-ascii?Q?DOjQOUEPdluXqvxkXwxJKIGz5Q5HgYYifXzS14eBfgorAwW/p1obuTrRrViv?=
 =?us-ascii?Q?gcCdqtQK2sTBBXd3kPSEGwmNgiT8sb9YtiiuZ98umws7EerhpRQiisH4vlw+?=
 =?us-ascii?Q?PagCctEiAdLC/C4MiIMdV6ZkNXkESxLwEKfd20dvRhlZGjJEg2wbC/4bIkDV?=
 =?us-ascii?Q?9jmI8Ck7qPkRwMnBMzcMwBK2eK67zoYOFxFRtbWuC1HhuJPzOPCw7LwrfKl0?=
 =?us-ascii?Q?WwFaEUuEEA3xvQL/QCjI7mtYsHJePAcJem7nBc+Wf3rIfgrqjbsnRnEKIzzQ?=
 =?us-ascii?Q?8u+F67VBRgLQQgOtVJr4pS6vAPerjRW+ASavT6Z3Ze3Au6LauihY9fuzavNG?=
 =?us-ascii?Q?b3Mh8BwBOAcEDPdTuhxFlw5cGxIiBcoVggI9/vCx4DMwQZ6Lj3DJgHfhirF4?=
 =?us-ascii?Q?Fb6LgnRd6czvOlL0k+4nn/+zseCdafrnnMPbk24WHW8G6EwvqueNRMF6B5Zd?=
 =?us-ascii?Q?6a/rep8GKzRab9AYCJL2iovw+8aXcFvujRfLSPeacCOSMABv0fvqM5apxdqS?=
 =?us-ascii?Q?2DXpm51Uk6TJEAqoht+O1Z+3S/TZxM3CyIF1zXJ2gLXSMB/Qx3ZLSZx7AlZa?=
 =?us-ascii?Q?TEdgIs4NnqBZNqv3Z9uN32iPV52/z9EhgxA39nneCiPkF083XmsmyN9/Nwu0?=
 =?us-ascii?Q?dAskGcOQk+fKbPAvNyuzEkb99Z5vJy50YYpjJHLKcNc2Iw05AHqBRc5j7zOy?=
 =?us-ascii?Q?fG6zIcilnLmVKZmv1I/Gthkw1nO5EPwldxcvB4FQWl9plmM7HJi051Iqha5d?=
 =?us-ascii?Q?ZKKh2IilijUcpThe0Be3pP620dJ70EwDBrIHlln7/Gt9iwyAgXbG9RUi+xI0?=
 =?us-ascii?Q?39ktkqAwV6cbcsCxZ4kYq61mUVtJXwzASE6dD4g03W/aWByB1KDQkJ0zkxdo?=
 =?us-ascii?Q?1/yBLi1qgajM9T7kp/K6XE1woHgbDMMZDdVzmRLvDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MDle4Cq/uTpo3eQiE6KdAXb9EwXy44bTSa4oedJaLiRRp/T9arpZSVNo6Rnq?=
 =?us-ascii?Q?62NejOQBHbP7Y8wBZbYmnn5G5tgLycyB1zZjdOBMd6UenRhLwHDMRW0H7vKB?=
 =?us-ascii?Q?dKzG4CQgF0Wnd3pfdTQ0OQ/J6vVGoQ44/l7BYz47CKEGwLPdUuwG3Bbps5ay?=
 =?us-ascii?Q?w1lgmxIoo0TUpiCYb6Pe4iU46Fa/p1C+e6/bPA2543Y2JqGjywozEws82pp0?=
 =?us-ascii?Q?OIy5QVrobdzvpk/3zDF26U4VnQz2pwNCrQJBkR9/CTORmX5QrtO9YRsd/+b+?=
 =?us-ascii?Q?s+/sikb8j2gKlX4R78SXgnAErqV4YcIA+kh+8oMu5s1RMnlDV1IHAxtTrL/f?=
 =?us-ascii?Q?fUpJ5Rriqny1Eum43utVkMoMIReJroA6ekE9oxMjyhAbdne44Da3W1izgz5J?=
 =?us-ascii?Q?nq/+pzkvnEQasDlAsW6LtBtte7mYZeH7DS6Jgtvyj72yq1/MTxtTCAYucMEt?=
 =?us-ascii?Q?dHPDfxHP8jHqUTmnjRf6I5XjnAo9wJJGl+EPHciX7a9prOUxBM1gEeNnpCQ3?=
 =?us-ascii?Q?f1RZBapmSXw56vfnaxNCL0c4hWv5b7l+i5Zri1Iqx3zYfcHoLFdpMK+yVxn7?=
 =?us-ascii?Q?QpXM5qA2zOWxP4ds+6q2ulY0kcsP2/0FnAPY5zJmBSwMhNTMaQ0iqxsnyoBz?=
 =?us-ascii?Q?jGLAG3wByZbv2FHpVPevI56eWBYSLsE+LvjzxOvCg3ElcITB2AdKBq96wa4C?=
 =?us-ascii?Q?jwAm9HVRZtj9XZHgNJfRECKbcXl1SmDKcu8NW69CycKi7RTXh8+pI3tCIKvJ?=
 =?us-ascii?Q?jNTK1ffcuLz1eggoYpxtrFc/3vsod4Rc+9mFWOXiMCm7eqITufrjlmNiWQQA?=
 =?us-ascii?Q?Cz+I6jhQ+QMaJ5jwhYDtc2V1NACX1Vv7ZOSZ7Zgb7o7nRPIDQmk7/ah0dQou?=
 =?us-ascii?Q?T8g2RmcyeS8WMrMsCVqZxXnWJCq1QsjbeAsm0OyKMpY+y5qUms5LXVMv4FDr?=
 =?us-ascii?Q?dscMQzCT0Y7mEuB9P4G7GbgvjLERCYNUEszVmsMwJFHOgr6pm9cEdYfeVfKP?=
 =?us-ascii?Q?jORDMJdbr1Cg+UwlwZ1P56R2s0pC/SQtLclCqdw+G2InsWQk2f1XbivA4gkJ?=
 =?us-ascii?Q?rQ3Q6wXf8G9OOPbLKzZ/msOm3+78U7FmCjOaKftPXgFqaHcKLbSUllikAT8A?=
 =?us-ascii?Q?VrUl3cYmkJbT07DpfKMyh6hnAts/o9lnnEcQt3rFoelQq5xKUEzCourV4oNc?=
 =?us-ascii?Q?JF62yKJRsSluz3h5eVLm4ppnmc/NQ1A/I9uPBcHXBVcZa2R4cgUSCfNcnGoU?=
 =?us-ascii?Q?a1TKDjeU04dTlKnXXZfU2HPet4d9SgdYmdLMN8TYRrC8WxcVk0zA0ly5ijmi?=
 =?us-ascii?Q?cNsrvSaPYvMo0XTGNlgiO7/bXg91YzEn6LNKwOoGUSrB8ItQ2NDpHxAG5vbR?=
 =?us-ascii?Q?KHVlq6vVjH2B2mIjSrQgUks90YDBvJrwqmiGakJyyA6nd9FVf9UsqO3qWd45?=
 =?us-ascii?Q?/R0Fe3GiSu49h6fjXbRRMPa6NMv3nD352ORZvHiTMwaQ2SwU3xkUnwm/9aiu?=
 =?us-ascii?Q?7047SMn3RCUIrTwKTJwXeUQ3dBOOQbZgl57+Q4Cz2dJ8tmqFyzLR96jIHSsW?=
 =?us-ascii?Q?jaQ26TVPW58yR2QqsZ4j21BdZRScK5OmbbDd5QYn?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c6503d-0508-4792-82eb-08dc626d58b3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 01:41:36.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs1jXEf71R3uyLnK0ST4+oPN+nkrvgq9TmNO3gJA4QaT6NMj5fhVeSFu1CrnfTWFtGA4po1M9xaBuA5X/zezEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5828
Received-SPF: pass client-ip=52.101.128.6; envelope-from=wafer@jaguarmicro.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

The virtio-1.3 specification
<https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
2.8.6 Next Flag: Descriptor Chaining
      Buffer ID is included in the last descriptor in the list.

If the feature (_F_INDIRECT_DESC) has been negotiated, install only
one descriptor in the virtqueue.
Therefor the buffer id should be obtained from the first descriptor.

In descriptor chaining scenarios, the buffer id should be obtained
from the last descriptor.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")

Signed-off-by: Wafer <wafer@jaguarmicro.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 871674f9be..f65d4b4161 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1739,6 +1739,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
             goto err_undo_map;
         }
 
+        if (desc_cache != &indirect_desc_cache) {
+            /* Buffer ID is included in the last descriptor in the list. */
+            id = desc.id;
+        }
+
         rc = virtqueue_packed_read_next_desc(vq, &desc, desc_cache, max, &i,
                                              desc_cache ==
                                              &indirect_desc_cache);
-- 
2.27.0


