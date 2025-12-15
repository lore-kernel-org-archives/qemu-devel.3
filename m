Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E82ED59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3To-0007rC-4s; Mon, 15 Dec 2025 02:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3Tk-0007qs-A6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:58:48 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3Ti-0004DR-Gg
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:58:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af46oyGBJyAR+PHi9S7ya/LF1WIt+PJbBuXQThdwAqNoPtgfZ2Y90XIddmEkSsSFVgAE2xUlMtiMPWkYCsyeDx/SRvGxhMouGnLzRhrPkBGm0qqqdGdDfVF+xIdNaWC1ryzIM/zQMNScvLjD/3vNE2bmQG206GQLq1p5V4wNed+DQazXR51ZBxoCnb43vjPrEEqgYzzLo579zOBh1RLPuNQ0wKEXYMqCJs/m4sLy3hhVngZ0erugdamDdZG1Jfk4XFHPDcG1PyGQwgNE2T1u8NsM5jg+36BXKKGAcYudho68nR2Pr5B0wveHkLCDZ11jF8mqIFHRqhUnIsvbckqSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqRtpSyWKiPcGehPjO7vHUtms4XA3YgPXOG0le3ZuqE=;
 b=kpjMba+nB8fcIAEsf1DsN46K6fGjbw36t4IPLP/+UVYr06myU0zx8cygBWEet+l0N+GfUVKDRUSvK51EdXn8M+xdj4ZbiZ5pUnQ1k6GIagfnvKOGq6av+Wx7QvbA+FSKJJCTy9cylWKn+9paMJZ9un26L+UWjlQFZINtgF/rlcmnktGQ/Baqa6/jvD1L91X8/eiexi3H1WMO4+WJWsm+xc1DYsDF7WFBzPkcqUzytvb2aDQxHSg3eiUbr8NRodSZaay0n1OMeME0KiwT/FUzC1ya8U+2JWjuJ3EpkkMzyfV/I7mp1V2YM4uvd9NZS70VCjxjtW9UUng+ab4qWgdR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqRtpSyWKiPcGehPjO7vHUtms4XA3YgPXOG0le3ZuqE=;
 b=Hqj7C8nDR7lqRUtXGSX2PJm3lDm6/708pRUBNEjlZwZ7vI+2Tsfho1BUZUcJIXUB7I8SgJX2KHcSBRXQWwlg5OwP5gsOdW/+DpTkzqIEqvr6yzHuqGUO+YwTK/VDgExnh1/9bKs6mHs3BD0oqHH03NjqpxK4pQIUom6mHdta6vwQsPfOKv1bua98Jdc47GTiRu+AF/uACd3E38vUZiZUzpvAwXWcl4JVhjQHuWjstcYJ7Fz0sJtkKAFZcliS4WUpyrVsXQnSqIKnmDI65tGXio4x3xE/mVNZNitDdF9OK0QnAm43xCVacgG5TtB3qGj8Qm3RK7nvihFvc8QdZnN1SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by OSNPR06MB8228.apcprd06.prod.outlook.com (2603:1096:604:45e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:58:39 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:58:39 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v2 3/4] vhost: SVQ get the indirect descriptors from used ring
Date: Mon, 15 Dec 2025 15:57:47 +0800
Message-Id: <20251215075747.2367-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0026.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::20) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|OSNPR06MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0552caf1-9d71-4444-70f3-08de3bafc1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SiPhbl4x4VmB3Wtj+sfXl0x299lhUjNF5ump6NC4ih7XAT+qhSbOZ4xbDXqZ?=
 =?us-ascii?Q?6cnYx4yV9yjUhquYUI6GPIpjAawS6TIli4rZNBHmKutv45wQqKK9qd4JzDKH?=
 =?us-ascii?Q?SvN5oWIyzySqadmPlHnNMabsWbV/cRtoWMlqOwFILQ+jrmxYHZXa3mY9d92B?=
 =?us-ascii?Q?pC9WtQ4bfXuTWd3lBs3SJfJ52S2YDIK5I+B1iSQMJ+xR0NxwxDEsOO83YmCi?=
 =?us-ascii?Q?6OV3Mj7ReauorKclJrp+YKxeWvBCCQGobO25YECl0KXZyRsgokRQkC8H23/y?=
 =?us-ascii?Q?Vbtls04VBdVmd6fiAgkhi198jJtMgEHphqtMtysN9cBiEavM9qtLEdK2ZE7D?=
 =?us-ascii?Q?iO/PUTcqvILGfTmJo1S8KB77hi7adthL8IovWh6xytcR+tFYz4T+d1mtob35?=
 =?us-ascii?Q?I1NAGtpxrQkKxEEfuTlD6AORc/vA7tZXSkLM4CsVkVbgXM2AxpP7boQ/uRfS?=
 =?us-ascii?Q?vtdgsvUVl5idu3JZHjfLK1PjmXkZ1Nouc35DOIq2qh1Fx7cRSVD3fJ/WjcQt?=
 =?us-ascii?Q?Pfq2zIPHYbj9LDf27ynYWhkqxC/4cYJyAniJjnwxaGlfjThJ77wRdU517/QM?=
 =?us-ascii?Q?7POAEdu+clGrnRi20MQvpz+tiQgYgaepDRLcrSWt8REpuYN5bhdqpu4BJtzh?=
 =?us-ascii?Q?395pgXyDNAf4hGMWzIvvnZRI3ClAQFI4nndJWNVIlFtOyKfVjBgvpa0jd662?=
 =?us-ascii?Q?wB7DN5GxwojRvjaIT2k39tWhq4vUq5TI8p1CPnzeJIe13dbcp1HOJf4CjDrl?=
 =?us-ascii?Q?w3Ca9kMYDBuKXaugAqaUj11xaW7sAgcDEtgzJ7j6xOXhKp9RnnY+Krn3eNIJ?=
 =?us-ascii?Q?D7zW5QVLcE4+BTLIB0hO2iI2j9jtVCxK+AKzvlFv3+HiLb8uZ6Vuf7uyL0IF?=
 =?us-ascii?Q?dsvxT0EH56emR8StwbeyWyPdK8+DekHSPjZg15+m/fghOOL2pgQq7YhzBRg/?=
 =?us-ascii?Q?Ch/o5wOf+z5njeBwxjS7aRcY8FcJVp7gBABOqubjIWL1OWbHF6MZk6QkTQdb?=
 =?us-ascii?Q?qNNiip4xe4/q7wpK6hJgJy+O0eSgMZ9GzhO0pDRKhmpy6W6dQMprR+FZf+RM?=
 =?us-ascii?Q?OAZoccyOp/vr7XMHeHhohJX/gTGJX/pmvO6bSIS7+yNsI48CDoepOHLyl/Hi?=
 =?us-ascii?Q?iWlL6Ini+flZ5EbCscRIj5Kjmex/8WfdPA7b1DPAldPpueyn5SRyrs0jvhqS?=
 =?us-ascii?Q?gBgC72Yg4lhq5roD2RJx1dJlxC4Tf8LyltcnMvxy6zZqHTote+tEjdrLwdRd?=
 =?us-ascii?Q?MUft/pC8iPaJekigH1SzljC9iwkoae7eLB8HPKq3eu9Je4alN++jBMU8rAOY?=
 =?us-ascii?Q?ZneGbIJOPFUn4KzLK2ULdr36dg3/fmz4KsHBMCJuyeO3VUlA2ynKt9Lf7lH4?=
 =?us-ascii?Q?zeElfJMGsUKLjjphCeybgDEVi7NQlv6jr3QQmSaJF8s6pYq4Bf0H/K59aKFw?=
 =?us-ascii?Q?iQUKwmKc21PWmPkWsd3UhppnMqGp5LGjxlW8hJfdKM5vDHV3DdCcsRbWZGY2?=
 =?us-ascii?Q?Z/2I9ukbLkKkMbSfjk7RbIarj1AY7JqkjwD8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TiORgqK/Dd4XHnFCea/1ncHPcVZ+p8C6lg3sRsOPf4LcJwELPWmAd3DDUZqd?=
 =?us-ascii?Q?D1/29RrW6cX4rbBbwE26RCK/VKWj9F9p6ckhUSD6EJEXu3HvY/DJZ6JNw118?=
 =?us-ascii?Q?DWQPe+hIMcGxWyeebrZREpfp1VQeF/axh/cR/5DCmKrnFIT8c3JeraHsn3CU?=
 =?us-ascii?Q?aDxYFNCL3qRy9JSMg7Vz7uZGArYMQrO0ZyITuHGpYdLbpqko9UjUFa3etiGc?=
 =?us-ascii?Q?W7EROHUOQjbFfCODvrlpc3WqDnK+aVp0WrXQB6idYM0ZLIDnCJVwZwYtPr3L?=
 =?us-ascii?Q?dKZtEq4yW6U59+ml3pNkwbpkX/FHVx5YrRUNq2iOOaypAs5Mv8/52nuAN/oP?=
 =?us-ascii?Q?WZmY6OfLI/dqAXJrQ49NNzkbXtea2t9h4VU+cT50hs0ugZmHVlPU5krC0KzF?=
 =?us-ascii?Q?FNooOS6JXDrQ3hngtDzfcAlUuIpIMsJ+UYOn+NlAuVKANh4N/H/BNsoiEf0O?=
 =?us-ascii?Q?mAxc6HKL9ICAjDRqy0KiOuuyhARdPAn6KhuYfAg2Z1nLX6CwWaDcAWp9jO4i?=
 =?us-ascii?Q?1M/NpEMTYW0yODrAf0vH76YM7nnmBtsAk9OqrNPM6iJx+G484HWWJehK15w3?=
 =?us-ascii?Q?hyBluQ6q0yIHZY1T8j+G7n3KE6mAfai9umGjpSYEFhM/JR/b9U2Adsq1HFKQ?=
 =?us-ascii?Q?hSkGX0/RiQglKuimHGz0MMD67OKjA2WrPqON2QpF0aV5b04DBgI29yurSevQ?=
 =?us-ascii?Q?Z5jwvMxsVH3DDg5TSJM5G6pQcAcdXOBS6sm30fjVHywqaP631daoh5jwAkb0?=
 =?us-ascii?Q?u4bNuTBi1HTquoJ0sJrkeBOxYNVplFSnmIdT3Zf5VpUCbvcbPJlU85zSruvW?=
 =?us-ascii?Q?7iJFKfcLEelzxffugu96KuzbSCcdUkzwWCtMqc59djnh1RsagNLJaMcyDkWW?=
 =?us-ascii?Q?jsiPk8n2v3XSodQ5Qg235j5QiwwlxBonudvk/MahEvYSiIgbY1wfX8AlmV8h?=
 =?us-ascii?Q?yWbKbl2N3vHfMWQOZx7rW0hAxxJR+BfbD5BwuHXIpCOzaHJFx+3XQQAEEVzA?=
 =?us-ascii?Q?G9nocbpeDtK79W/r6fTsx+6BLrwiXjW7PiG+32myIw6Q40/OCa3DSBC1yP7u?=
 =?us-ascii?Q?pdUKDIhDfCsqu5Zi7nTGFGwmhs09trDQ65opAH0KLq+8TVp7aCXOSUiRDe1L?=
 =?us-ascii?Q?RXPK2KTYYq9tatdRJDNxDqb3z8jsOKG9Pof8z43E+9S72A/rLs+EsM/LBuqb?=
 =?us-ascii?Q?m4pvs6jV2/tKi+LJIF32dKkuGfOKoo0j8Uk7SUtG4mUs0b/0g2/XeA5QndZF?=
 =?us-ascii?Q?gYjxpZUgdQCmlpYRg7fKlpVgsR4WBuMpWIhnifAu4Fh05VGglz4fiG6+NggK?=
 =?us-ascii?Q?gDpKZoAWjQSrZxcQAHHJh7yTxt6zkRz0bsutqNiymiOo1sWQNOv09LyjxhM2?=
 =?us-ascii?Q?cSoyHkMgccONNCwsBYvVlH0VUIZYOchVSP63eVWzOdO23gcjoX6x7Vg82Jfq?=
 =?us-ascii?Q?LNUEMZp5fpSCfAbS5pVLrax+m+eiORIOCYh66tf00BanOslf4qyFuS81GHKr?=
 =?us-ascii?Q?F4YUpqViTBc5wuBLdu2gCfLwrO0EJFkGLzKRhiAlNm3gUp+v+Ms3SJSCep2I?=
 =?us-ascii?Q?lnSYHxzNv/h0FNH2BLIJceQ4uxJeHgtnT/cEAacq?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0552caf1-9d71-4444-70f3-08de3bafc1ea
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:58:39.3632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDuaRmj3IN7F00kALnpxnol9OMffPeag9MiV3Paj8LU9UCmuDge2WAKFbRtzTlsc3pWF3O342VDyHxjAzXk24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8228
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

For the used ring, based on the state of the SVQ descriptor,
if it is indirect, retrieve the corresponding indirect buffer by index
and then increment the freeing counter.
Once all descriptors in this buffer have been released,
update the current buffer state to SVQ_INDIRECT_BUF_FREED.

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 43 +++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 85eff1d841..9d43f13842 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -469,12 +469,47 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
         return NULL;
     }
 
+    /* Check if indirect descriptors were used */
+    int indirect_buf_idx = svq->desc_state[used_elem.id].indirect_buf_idx;
+    bool used_indirect = (indirect_buf_idx >= 0);
+
+    /* Update indirect buffer state if it was used */
+    if (used_indirect) {
+         SVQIndirectDescBuf *buf = &svq->indirect_bufs[indirect_buf_idx];
+         unsigned int ndescs = svq->desc_state[used_elem.id].ndescs;
+
+         /* Increment freeing_descs for descriptors returned from used ring */
+         buf->freeing_descs += ndescs;
+
+         /* Check if all descriptors are accounted for (freed + freeing == num) */
+         if (buf->freed_descs + buf->freeing_descs >= buf->num_descs) {
+             /* Reset buffer to freed state */
+             buf->state = SVQ_INDIRECT_BUF_FREED;
+             buf->freed_descs = buf->num_descs;
+             buf->freeing_descs = 0;
+             buf->freed_head = 0;
+         }
+
+         svq->desc_state[used_elem.id].indirect_buf_idx = -1;
+    }
+
     num = svq->desc_state[used_elem.id].ndescs;
     svq->desc_state[used_elem.id].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
-    svq->desc_next[last_used_chain] = svq->free_head;
-    svq->free_head = used_elem.id;
-    svq->num_free += num;
+
+    /*
+     * If using indirect descriptors, only 1 main descriptor is used.
+     * Otherwise, we used 'num' descriptors in a chain.
+     */
+    if (used_indirect) {
+        svq->desc_next[used_elem.id] = svq->free_head;
+        svq->free_head = used_elem.id;
+        svq->num_free += 1;
+    } else {
+        last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
+        svq->desc_next[last_used_chain] = svq->free_head;
+        svq->free_head = used_elem.id;
+        svq->num_free += num;
+    }
 
     *len = used_elem.len;
     return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
-- 
2.48.1


