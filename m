Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D06D5C0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 01:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVKI0-0005a2-2x; Mon, 15 Dec 2025 20:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKHv-0005ZX-Vb
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:55:44 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKHt-0007Wc-SV
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:55:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrvSpsQkqP+NvbbQQpeXh/rAAsH6viZfrZdkkDcyW3oTwZ3S/RzpwADoF63S0ecwQ59wXW/iyu4Zy6ehWLLSTEN/fN+1YG7V2imxuRd9JPX9mpN3idRb0PlxpY4vBcoujceVa09c8qtDy18yjMlhybVjLIPA/SJit3mhp0mMEqIB/tfx1iJdjngw9o9ag7kp1DVARJIU0QIBLkyy4sNVof5YVNVUnAbxfxBGWBw0GnrXYSOQ8tPO7hfflYNDhPEQ/KoHIeOANcKn0Q7ldYIOkErjbXy2ZRoUdkJuVEfVKvrsxMCGMf6NWIrSbCgqwOxQQgG0oOM4xsjGq/skz5Zhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TH9K4oMnrsU4tCvsW0w1nRq+IT1Z1oO4Ed7GZp5oYw=;
 b=oReUmjvqTnxnZD3s86x8INC+zzltvDxsfU4fltTSs4v1K+/ckngcl9j8n7zepa5n+HtV/B8Xx01LAt66yP10YsKSHCfc4jVuc/N71Ow+Bsbd+b+g8DW2EEhW+fCssB15JacLBjTOQcwIM8eDihtQewpFRyMyPSAnrQ9An8P/1RnF86tMmrzC4gsdi1opyQ8HH8nhEC7jpkbJL8ZCJyLEWYcbXiMB+fQNy0Tfi3mGZL0JWxVpMCPY+5pYlqTRfS1R+qQfMswIlCSVFx0ncsUXjU55DM1VRSWtxhYIh6ZbtwhrRXnqfLqqZtmvLqTzsAzckICQrVxHvuX14b5EiRCFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TH9K4oMnrsU4tCvsW0w1nRq+IT1Z1oO4Ed7GZp5oYw=;
 b=p6+Z2UHDQaxOkMvDx/7nC059/8Dm5f4+oudbdE6XPVakZtqql1E08rfWhpAq//xM+140D2pgsgGdrmH6p2gpLmOTgDxqaDZQJm6LhVAnC4JtwtsfedyEnzVo/SpP2i+8QhiXna8dKdM9Ecb6KBPd8JnVTkfQPMEySZ11ICrr0vg1eje4v8WUEe8kynzAZcwxY6YsFeosR0cWyFtJcOhSm5YCaFLaLd1ockB1HQbQgwR8EubNjGa+9uZDL+2rvOHGlkT/up9eCWKmcIv9ZjRdJrFtAvo+4xp64kt3aXa0r7NIhNKdYm5M4qHmv6Uab4n9iNaPzdZS31YKnnHOmg50RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by PS1PPF6469DE8C6.apcprd06.prod.outlook.com (2603:1096:308::253)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 01:55:34 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 01:55:34 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v3 2/4] vdpa: implement a statically allocated buffer for SVQ
Date: Tue, 16 Dec 2025 09:55:22 +0800
Message-Id: <20251216015522.6540-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|PS1PPF6469DE8C6:EE_
X-MS-Office365-Filtering-Correlation-Id: ed75dc6f-8f72-4e2f-7d3f-08de3c46334f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y5GNxPzyIWUI9bMjGYM8A/IH57Dw+EizNAlQ9v8vSEuebaNbewjHIUB4WnCK?=
 =?us-ascii?Q?D/HhmTI95+P4OAaMfx63XirkPU7zDs1EdlBLs2TsFKrZBtIjvxpGA8p0KWQp?=
 =?us-ascii?Q?c0A1k13EPbhKVtgRVGpPCyITv+9f9p2rHWogQF7UUnugdRxpPbcCEOBpFRxZ?=
 =?us-ascii?Q?CrrPoLr7Sk180kxEAzG04VzlcfFP/6qmU8N1lwPseS5v+y9HN53eiqGgNli/?=
 =?us-ascii?Q?vXnHTZb0g/PTb1PMte/IOHAiqLtt2G3vBlKO+FofNi1T2R6AxF5LiiUHqYWz?=
 =?us-ascii?Q?kz8IloAuUq9JjtiWFP7to43dh3Vq5L5nmg8LbcBGwAo1JAiPY+luppNIG/bW?=
 =?us-ascii?Q?8fYvOFoB/V2zaM4ovfrCWAyLOF1XLzEk8y723Myqd3g5dI2xWvmpT2eZZMvD?=
 =?us-ascii?Q?ViNGjYGx8m2+lUaC7L599fNCV2uB7n9OyO7KadZLPJZqK2aw7W2S/bGptRsj?=
 =?us-ascii?Q?RIIBt3paX/2xWEgeocfZyvnJCAVBX/ImeVftt5W2vNr0qp5vzy5glYP+TycT?=
 =?us-ascii?Q?o2yvk/cyiAv1h22B7BSagi2yS3CdlHjp1YrPaQVYNZbR2P1bnGjoSA3HWtbc?=
 =?us-ascii?Q?yqNKBaElM9OJ5uLiE70EnAwEZ13OEMEWUB8U9djl5qQpV2Bu5j1kXW1XtIp5?=
 =?us-ascii?Q?9lolrQVEPzT3ytOjHA0wgq8lSaJFO+3yNn7n50lK+HQaw4SC8fVCSyZMVX3W?=
 =?us-ascii?Q?LW0s97zgkwR6BlvspFUQGwBczhEBgL8wQxhP1w2XwWiUlIa2uOgWcCa18kKg?=
 =?us-ascii?Q?dHONeWdg+N7C7xPy5pLtgnlB2oQ/e19V1icVIcppEsAS2ie2U+ZzDWTjIRaW?=
 =?us-ascii?Q?BZn3uwARoWOpko+4Pym01m5Jes1+1TBrwjm7Gsl1uetAcuutyz0n2BVWbbK4?=
 =?us-ascii?Q?jKjG47b6x64rEGLLKiaFYSqtxM2r23HV4DAtYBfKtmkGNZjoM2QqmK41lLjy?=
 =?us-ascii?Q?BxltM6jqklQdXVXsn8YGVMgbOhEdvfwgnzsgQj/773S0mca3tZReB1eLIXVz?=
 =?us-ascii?Q?WDlNRfS75zzzs+xczptEdjnlClm/peDB0Nr1GOOyz5h2JaYk28ivi0iUVCTS?=
 =?us-ascii?Q?pYjAfwr8h3lvm5KksvlZGSxwOjX+i+aHVU1vfYpHRMDpmCrm4W6F240VFoFN?=
 =?us-ascii?Q?OhWKBLdrsbbA/6RiYe4/NOXxv4TwXj6vn7xjmqJTxu6Q+nz4T7k69CJ753fO?=
 =?us-ascii?Q?aV4bv9QyyjpS9+XPaEQledMQ5KfCvvFOAoi0rdCAzxg5omtWYJ0WpNavxFUG?=
 =?us-ascii?Q?Xbna9KHZ7vRVLl4CnF95vjOVx/A/gA19LaHvNxkL0KhBPAGwRAcc/VcEHHmS?=
 =?us-ascii?Q?nGMup2IGNpomTlMDb4ZtMBcQQQhaT5RSq0mznmQGFWarzUVD48qwAQ7ZRByu?=
 =?us-ascii?Q?Yq0VC6GzxJggMqTX4sKaDrlxQOrtdWgbOMLVjia7to+ODdnVMEMzU45ddDVB?=
 =?us-ascii?Q?HX9UxbZoER/Dx7j+vfZ1R2YGe+T1/l705DYe57FWeJbyLRZ1RFDGCN60IBhE?=
 =?us-ascii?Q?xfPND8BHGZsREi+cZXyq5/9bsnM9S1zcxfTh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W5p0aSR87O8H8xXEmEmSXANUCwJgcZd3gaWTf9nFm8/N75M0VOkSUGGzPOOd?=
 =?us-ascii?Q?XpJ6sJFI0mEmXqUlSGwt3ZBZlKORDkaoficYTkMMD3kCcKrN6Dop4Io7cedW?=
 =?us-ascii?Q?ZvGG6mEFDsrOaM/wKLWqp63sk+MHywv9Em9Ia6oq1+CDsvpv0KH/dCCmp64V?=
 =?us-ascii?Q?n3n8DdCZILNQHllYQzv00VBH8MIb07DuOXhjxfjV6roN75GvRzwVEIyRQNuV?=
 =?us-ascii?Q?ZYh5Ze+2mXIaYwlYYULpUEKXXl0JlGwo8Iwi96vtjw3nVrc9tTkOuxjAP3pP?=
 =?us-ascii?Q?uT0A77AgDWUB/HmohMVjWJufPlzStMlDQPQVo1l8xKIBLLLGgU0WQYtRXqPx?=
 =?us-ascii?Q?uZj3lAfMkTfhGY/6lYuTijfTzCbquoBTFQQM3aBMIIAkoLTD/K8vjecd5P+n?=
 =?us-ascii?Q?x/r61RUzAC2rrrKFlRlyms6qCnunyNqvq7MhUW5BSAkAHrF7QaQ1up5j9QeZ?=
 =?us-ascii?Q?DMKG/0rT0KyxVMDlLKh+VfqPowRQrAhnjAU/aoGJ2OgRtvo0s1yrNeE5u+Pk?=
 =?us-ascii?Q?+Rsku6ZKvQNWry/GdFqOnOd1E7KRb6e7gXjEEQBe7rYQ6PpGLJ/Pr7DO6WLb?=
 =?us-ascii?Q?SExuf9ywE0D/pO6vPcAHzDdT99RqPc9JCWFPtDd8sLFj/OUqQ264CwoYDLSO?=
 =?us-ascii?Q?+FbwMVEtnQfoAKVzollUQWsEhNQNVcGwVyKJyCTMld8iEz45vSA6SHjaoiXU?=
 =?us-ascii?Q?iKju+eM6aNT7cLmB9uNRZ4thTUwFkBCWJ1A+ePm+rruWA7Wx7yjWl8WrwLU9?=
 =?us-ascii?Q?ZKZkHzCocc86PSGF6UA7Yr1Dqsycx2fy0Sm52xA0U1wUjWTAvUU2xlyrPghV?=
 =?us-ascii?Q?pc1O1PFlBU405ers2QpWvh5OSS+hlAeqkDO0uTDrzXNGNu8SF07yc15PPddO?=
 =?us-ascii?Q?Q7RNVQFPuBMKCAMuhcXcqnoD9WH/yMuPsB6/A3aNj8dKtZNeCg/KkAANDE6e?=
 =?us-ascii?Q?nTJwokWTJklCNOPs9WwB/u+t3LVK6MAPegIqeIjF2YnqvQB3WqjcRwwj6C+f?=
 =?us-ascii?Q?YTYW1V3tqqPOWfSkI7yhzuN7red7MDoLNtuOVEhSP7fHGjUauZmU13SM3nMv?=
 =?us-ascii?Q?k2EUletAYSePqrJjZDZvN3Q+Yf/4HiAW3nSsauMeECb9z4ilnWI9Ccs4bDfb?=
 =?us-ascii?Q?cPLGohpChzAIBoy/2bjL2Kkazvx90rJ9wAiFDcZkQUSMul1qLsm8qJ4B4VwD?=
 =?us-ascii?Q?d8tPbYo6FMmK5tEnaqS0waHS6T4mcWi12pxcmm4rGFRBa7cIeggKl86jfv1P?=
 =?us-ascii?Q?M4q5dXP0Zsc/aRGPmFPYOZTtd5w6BWt0jBdVISKmV6VyBkV6lZGu5ce6VNKg?=
 =?us-ascii?Q?5rPVpBIFPJTncsjF4UN2/DAnivwbA8r/kD2VkQkX3suNKMToH8qD+Wc5QLUI?=
 =?us-ascii?Q?i5wTvFx9gE5xmz7d1BrP8Ck7wS0xMfjViMB/zObQc+ADlPFxc3yW8EDX+LUv?=
 =?us-ascii?Q?x+Ak2vVykCK+6nhT0tCZkrm6/3ybYWkhKVk/YvhSk8cbkAWAb3GsiANfwrBP?=
 =?us-ascii?Q?oXT+bzSNEpRdYrvcD1M7K3vNkYmTYeEBi/pYHQcMWnW8TSEpIbhd8evfDS+X?=
 =?us-ascii?Q?iVxMwTvYVVRXnJkaz5t2yTNQuqdb8SWWtmmQHbff?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed75dc6f-8f72-4e2f-7d3f-08de3c46334f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 01:55:34.2892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajdbtsj/V+676DMSTAJIZ+efYYQwIH71cd2XRpONU4ks25src1KhqaEinM62knokaZB4YLsgemgXtrULoi3ihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF6469DE8C6
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=wafer@jaguarmicro.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: wafer Xie <wafer@jaguarmicro.com>

allocated and initialized when creating the vhost-vdpa device,
and release the indirect buffer when vhost-vdpa is stopped.

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c |  25 +++++
 hw/virtio/vhost-vdpa.c             | 163 ++++++++++++++++++++++++++++-
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345..85eff1d841 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -708,6 +708,25 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
         svq->desc_next[i] = i + 1;
     }
+
+    /* Initialize indirect descriptor state */
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
+    for (int i = 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
+        svq->indirect_bufs[i].desc = NULL;
+        svq->indirect_bufs[i].iova = 0;
+        svq->indirect_bufs[i].size = 0;
+        svq->indirect_bufs[i].state = SVQ_INDIRECT_BUF_FREED;
+        svq->indirect_bufs[i].num_descs = 0;
+        svq->indirect_bufs[i].freed_descs = 0;
+        svq->indirect_bufs[i].freeing_descs = 0;
+        svq->indirect_bufs[i].freed_head = 0;
+    }
+
+    /* Initialize desc_state indirect_buf_idx to -1 */
+    for (unsigned i = 0; i < svq->vring.num; i++) {
+        svq->desc_state[i].indirect_buf_idx = -1;
+    }
 }
 
 /**
@@ -748,6 +767,10 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
     munmap(svq->vring.used, vhost_svq_device_area_size(svq));
     event_notifier_set_handler(&svq->hdev_call, NULL);
+
+    /* Reset indirect descriptor state (memory is freed by vhost-vdpa) */
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
 }
 
 /**
@@ -765,6 +788,8 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
     event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
     return svq;
 }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..816868d153 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -584,6 +584,155 @@ static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
     return ret;
 }
 
+/**
+ * Allocate a single indirect descriptor buffer for SVQ
+ *
+ * @v: vhost_vdpa instance
+ * @num_descs: Number of descriptors (should be vring.num)
+ * @buf: Output buffer structure to fill
+ *
+ * Returns true on success, false on failure.
+ */
+static bool vhost_vdpa_alloc_indirect_buf(struct vhost_vdpa *v,
+                                           uint16_t num_descs,
+                                           SVQIndirectDescBuf *buf)
+{
+    size_t desc_size = sizeof(vring_desc_t) * num_descs;
+    size_t alloc_size = ROUND_UP(desc_size, qemu_real_host_page_size());
+    DMAMap needle = {
+        .size = alloc_size - 1,
+        .perm = IOMMU_RO,
+    };
+    vring_desc_t *indirect_desc;
+    int r;
+
+    /* Allocate memory for indirect descriptors */
+    indirect_desc = mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
+                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    if (indirect_desc == MAP_FAILED) {
+        error_report("Cannot allocate indirect descriptor buffer");
+        return false;
+    }
+
+    /* Allocate IOVA for the indirect descriptor buffer */
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &needle,
+                                  (hwaddr)(uintptr_t)indirect_desc);
+    if (unlikely(r != IOVA_OK)) {
+        error_report("Cannot allocate iova for indirect descriptors (%d)", r);
+        munmap(indirect_desc, alloc_size);
+        return false;
+    }
+
+    /* Map to device */
+    r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle.iova,
+                           alloc_size, indirect_desc, true);
+    if (unlikely(r != 0)) {
+        error_report("Cannot map indirect descriptors to device: %s (%d)",
+                     g_strerror(-r), -r);
+        vhost_iova_tree_remove(v->shared->iova_tree, needle);
+        munmap(indirect_desc, alloc_size);
+        return false;
+    }
+
+    buf->desc = indirect_desc;
+    buf->iova = needle.iova;
+    buf->size = alloc_size;
+    buf->state = SVQ_INDIRECT_BUF_FREED;
+    buf->num_descs = num_descs;
+    buf->freed_descs = num_descs;  /* All descriptors are free initially */
+    buf->freeing_descs = 0;
+    buf->freed_head = 0;
+
+    return true;
+}
+
+/**
+ * Free a single indirect descriptor buffer
+ *
+ * @v: vhost_vdpa instance
+ * @buf: Buffer to free
+ */
+static void vhost_vdpa_free_indirect_buf(struct vhost_vdpa *v,
+                                          SVQIndirectDescBuf *buf)
+{
+    DMAMap needle;
+    const DMAMap *result;
+    int r;
+
+    if (!buf->desc) {
+        return;
+    }
+
+    needle = (DMAMap) {
+        .translated_addr = (uint64_t)(uintptr_t)buf->desc,
+    };
+    result = vhost_iova_tree_find_iova(v->shared->iova_tree, &needle);
+
+    if (result) {
+        r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id,
+                                 result->iova, buf->size);
+        if (unlikely(r != 0)) {
+            error_report("Cannot unmap indirect descriptors: %s (%d)",
+                         g_strerror(-r), -r);
+        }
+
+        vhost_iova_tree_remove(v->shared->iova_tree, *result);
+    }
+
+    munmap(buf->desc, buf->size);
+    buf->desc = NULL;
+    buf->iova = 0;
+    buf->size = 0;
+}
+
+/**
+ * Initialize indirect descriptor buffers for a single SVQ
+ *
+ * @v: vhost_vdpa instance
+ * @svq: Shadow virtqueue to initialize
+ *
+ * Returns true on success, false on failure.
+ */
+static bool vhost_vdpa_svq_init_indirect(struct vhost_vdpa *v,
+                                          VhostShadowVirtqueue *svq)
+{
+    if (!svq->vring.num) {
+        return true;
+    }
+
+    /* Allocate indirect descriptor buffers for this SVQ */
+    for (int j = 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
+        if (!vhost_vdpa_alloc_indirect_buf(v, svq->vring.num * 4,
+                                           &svq->indirect_bufs[j])) {
+            /* Cleanup already allocated buffers */
+            for (int k = 0; k < j; k++) {
+                vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[k]);
+            }
+            return false;
+        }
+    }
+
+    svq->indirect_enabled = true;
+    svq->current_indirect_buf = 0;
+    return true;
+}
+
+/**
+ * Cleanup indirect descriptor buffers for a single SVQ
+ *
+ * @v: vhost_vdpa instance
+ * @svq: Shadow virtqueue to cleanup
+ */
+static void vhost_vdpa_svq_cleanup_indirect(struct vhost_vdpa *v,
+                                             VhostShadowVirtqueue *svq)
+{
+    for (int j = 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
+        vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[j]);
+    }
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
+}
+
 static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
 {
     g_autoptr(GPtrArray) shadow_vqs = NULL;
@@ -791,8 +940,11 @@ static void vhost_vdpa_svq_cleanup(struct vhost_dev *dev)
     size_t idx;
 
     for (idx = 0; idx < v->shadow_vqs->len; ++idx) {
-        vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, idx));
+        VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, idx);
+        vhost_vdpa_svq_cleanup_indirect(v, svq);
+        vhost_svq_stop(svq);
     }
+
     g_ptr_array_free(v->shadow_vqs, true);
 }
 
@@ -1299,6 +1451,13 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
             error_setg_errno(&err, -r, "Cannot set device address");
             goto err_set_addr;
         }
+
+        /* Initialize indirect descriptor buffers for this SVQ */
+        if (!vhost_vdpa_svq_init_indirect(v, svq)) {
+            /* Non-fatal: will fallback to chain mode */
+            warn_report("Cannot initialize indirect descriptor for SVQ %u",
+                virtio_get_queue_index(vq));
+        }
     }
 
     return true;
@@ -1313,6 +1472,7 @@ err:
     error_reportf_err(err, "Cannot setup SVQ %u: ", i);
     for (unsigned j = 0; j < i; ++j) {
         VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, j);
+        vhost_vdpa_svq_cleanup_indirect(v, svq);
         vhost_vdpa_svq_unmap_rings(dev, svq);
         vhost_svq_stop(svq);
     }
@@ -1331,6 +1491,7 @@ static void vhost_vdpa_svqs_stop(struct vhost_dev *dev)
     for (unsigned i = 0; i < v->shadow_vqs->len; ++i) {
         VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, i);
 
+        vhost_vdpa_svq_cleanup_indirect(v, svq);
         vhost_svq_stop(svq);
         vhost_vdpa_svq_unmap_rings(dev, svq);
 
-- 
2.48.1


