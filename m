Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8717CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsa-0004Hz-Li; Wed, 07 Oct 2026 05:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC8-0001Dw-4k
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:22 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC5-0006kK-Hj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obz+InFReb0BVVVoLA1qFZo43KgteHlvFl8iw/ORfOtteC5BYIvF+jjiuACjxjGP5iwZkozDBGburZoD8B1Vpb/RL+nNuwIxwgHRnpguQ8Pd59zEzy2go35jQGwlplOZDTYazMnDVDuQB89KStcEAZnOwTVq62kIyKBXw8+pcova60qTlNi4RFxp/4EBkVn1g9aLB2AVF+lI1pruHqkOrRyeJD4lCH3qF7g28hb8MyAe9XtHLqVB6J2l6z1tVzSYXJBo3RnL5OiG7SPC4NXSLTy1b7dh7SU+f/o+VlHt9Xc6QGdB51FH/W4yW0+1is3k80tbOW1PeNVo/lMcDE2BKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=jztajgdaqUXEtQJ3HkKytFD3fA5uYVvytl5xzJhTMDVxMx0/oGAPcb9JI3U7USP7BRKoHJolkD6FvNvg7gXwkrCos0Kx5PBCpfaf6E9pBLB0cFhI6kgsw1guglAGEwB4I0KgjdBLJLYnO8rWkKSq6k3if35PDO2TKzUx/Fstyv8zEIeC1Hu+x+KmwrlmM+XgxslFtXSm4PbYVMrC4uYj4CRZGS/CLO3CG7n6h6/lZ2sgkqGiAlysb8+fAgrkVzvJWmqdgQO1FcnRNDN3fa+a4m88zivj8rezwdqasTRkWRbx1qlT5G1nUdKYIVszSBnC3tItUTrzixNt2L5a5DjLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=W0VrynotKIU7wwsVhn6t275jNZ3HacEHIJtm9R5fsGMnH1HicrKr3toeDlaa5ykhiLgjJ+G/qQtV3WCpii0BiLtzmd4AHDE9nC6GFMvQtGoJLjU6JDGPNsnGvLMRWKGxundBT3BEqu2KPY4j7mxqJ6VSPcjrHVagum1/+FZWTEu4vOrJ8M0W34FEhhOvrwrshxgZ68jOxAH7RILo2EuRPru5R6WRyM1fKeBFGx630QO6Pelopa+2u8ZI3ruIR4Q27wP4v3TGqN7WEGQScy+2asXSWQrl8mS4b3dSBkJ6myZJ2jxmZZQiDl8xljA+nuajXb4lYT4QERWM+z2ktVcImg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:02 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:00 +0300
Subject: [PATCH v14 07/22] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-7-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: dc22251a-9ad8-4ecb-be1c-08df244e940e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: u67gSooS1lc8n0n/otIZNj//tEi38faNaOCJiVs8B1M2VIKp6hy8KHajBQoXCkvo1MCJ1OzZKHebHoV+SfWgAWLDUr5ovv77HYTbmWsRlPpKFO4xP9oYMtqUdDGFLvlKtlpBRzQK8vHpF0JeCWL+1ieSN2aR9pqmsbjR75LdNbX4X+FkTaT+j+7Kwqw/UZqNb03TEJIZV37w+Vk1oS1W7QwFC/TrZvKVrO2sNAxSEQyXMAdD7C42pbaxXlA/T46GdeLE2C136fCb1knGi1AQSo0jQSimdL7rtksuNTvXDQjIaY+XCqYDv+WGzKniLYvLfvzIBHABpVV67kvQJQ9wG7KBuze+59M/DJUhDh+4wGgytALHUzHsuAb6z/Evrx/wD3971lKeWi5ZLD6PSWQXyBui1/EoZAY080FbI+W4z3LwKG4RXMBKc71947FDTVXnwwBgC6oIuuGG4nMYvK6oOUew4uw920eUWPHRSNe+/FIbE37HQO7g4DsWL7ljKLijNM/hd8TirPUVRTGK94K8D66xFA9hFcaqFopyKcK+/BweJCXZExE/J0g9W6vodxRHHAJUiUyIMJx7xcrbmX4xoQDIUV1PRHdDpcOvxOjn2ehJ9h+h9Pcw8VDpkG2JXDPCIUkXXU5q3xGu6VOycILgGpDqDd5vxGo+GTW5Y89wWvBCHHhFFWBmrz3UiWurEktIxVXPf5LuWrBdToTMvWbyAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhXZjl3SkRCdmV3Y1cyaS9hbC93U0pVL3RZMHBzYnBqM0NoMU91VnZoNmty?=
 =?utf-8?B?cHFFdjRicjR4V29vL0tHZ01JVElZN2hpeDlzUWlZRmV1WU9SZXhhZjdKN05P?=
 =?utf-8?B?aDRYQTNXYVlhaUkzTFdMN2FHMUdQQ0FzUjhYcXRVclE2YmoxYmhJSUtoRFBv?=
 =?utf-8?B?ZWpXNVo1Ym92TjJWVHZCVFAwa0JZMHhoOTlUYzBvQUZJeWlpZEp0WGpMYkhN?=
 =?utf-8?B?RjdPQjZyUUJUSDBQenE0ZEd1M2x1ZXZLQlI1L0lVM2VpbWJJL1RLOXpvNW8x?=
 =?utf-8?B?R0xKUHBZR05jS0hXQzI0MFc3b3FiZC9SeUxjM2VacDF6djc4OEUraEVvc3V4?=
 =?utf-8?B?TDAzUGJHS1dQV1RoS1g2bkp0T2lWbUxFeEVEaEZtMDhidGFOQ1Q0ZU5KaXFy?=
 =?utf-8?B?RXRIMHhLeWR3eHVRTjhlYndkaTVLaWo3SnVvUlZhMGxET0hqb2JXcUcxbWdB?=
 =?utf-8?B?YnVIRklLN3crb3E1Y0VDV0h6WkoxY3VpaVFYUzUxVnFJMWkvN09OZnVyZ0wx?=
 =?utf-8?B?WnpZV0lvbER1R1ZvQWtXNSt5aGFDQndWdWJJL2dWK2VyRkU2M2ZoRjE2RHB1?=
 =?utf-8?B?Ym42Zk1qOUNteVZJT3c5Z0J0VVpUTTBma2xMcHpVUlk1eDI1bGJ2c3d3WHV2?=
 =?utf-8?B?UmVmQ0hSWXZydWtrZnFvc1dkeDRXcDlmdTlxZ1lkaHE3UHhZOVV3RkRFQVdo?=
 =?utf-8?B?eGlrVjM0N2J5UWxZSUpxT2xmd3A3MThlVGtwcnN2b24zUlhxNGVuNEhNa28r?=
 =?utf-8?B?WE5sUVY1R2FmUWZ4ajZwOWxwS2ozOGFqRHJhUnNTYTQ3dTYydFB3SWUyeVkv?=
 =?utf-8?B?NXZRTWZCbnFCSHFwRWU0WHBET0VYK3JrdDJyaEVKdFYyb0xzQ2VKeDZ6ODli?=
 =?utf-8?B?eFFTV3U2RDZob3NSVDZ0eGxXNkZ1SzhjMDdOZ1JBWEJjbElHNFlYVExiZk9q?=
 =?utf-8?B?U1A4OUZubUx2VG81aVZ3VVk5a2hLVTR0TGxxdnJXWm9UcUhidFpjKzZQVEF5?=
 =?utf-8?B?Y0YxS09jY3o0UUREODhVWVZXYitzdDQwdXAxTXVMSWZ0TWt3dUZLNUtJMUZn?=
 =?utf-8?B?MWNtNkdlTnBQTkh5RkxzSS9ZeDNUMXRWcEVRcVVESlRPRUtES2hYbTM3dWRH?=
 =?utf-8?B?QVNhc2hGeDVPcFdXQUdZeTJEYXVhcHI3SVB3MlZzaDNJVkxiTWdIbko4ckhH?=
 =?utf-8?B?T2RmOWQxNngrN2VWWDJ4NG5rRnBWby83TGh2T0lBblczRGd6UWNIZmkxa3hW?=
 =?utf-8?B?M081c2pVQWRBajd4UmptVFZhMkN0cHVMeXpNbTR4citxM1pyYmxiN21mSXNr?=
 =?utf-8?B?QUhiaXYxdDEvbDBFQkVKOUVlQUpRdTh0M3NJTnhJY1BwQUJvRW1vWGxiOElh?=
 =?utf-8?B?dkNiNi9mYXduZnBZREF6NmE3aE5LUmpPcjh2L0lnaDdFUkRrUGZTU0lQVi94?=
 =?utf-8?B?TWJiV0hPTmQrU0ZrZ1F0Mm5Fa0gyZUpGcG5VWW4yZGticnNNenoyY0YwNlND?=
 =?utf-8?B?ZlVycWs0UUtjQXptVzlpZDNBR2ZOaDhlMmdvdWV3SWJQS1RFbUtOekNhVHo3?=
 =?utf-8?B?akhIV09uOGpOelh4VnZGbndjd3JkZDlZSWtHU0tvSmxVdFhybkRXUjYreUtK?=
 =?utf-8?B?WnVxeEFGYm1iSm1hNWd6YkpSVWI3NFBBSldzZmt2TDYzYWlBbk11aGI2UWFq?=
 =?utf-8?B?UHdnd1ZzU2hleVJmRHNTWHRFeHNuTDVaT2FmYUtyaGF2M21sYnA1QTZFNmo3?=
 =?utf-8?B?bWxmSlhvMDJQRS9ZRzhpelRqUTc2bjVlY0IxQURXWmg3aHRwbEI3NmJOYytj?=
 =?utf-8?B?c2FSQjRLTXlJTHFmYnB4N29MaHBtaWFHbXBOM3B6RXFpZ1I1T3MxUTQrK0lu?=
 =?utf-8?B?L214ZFQzdFY0MjB3TlpvaEk1cDAweXdIaE5Wdk5lR3ZUaVg1T280MkFnVnk3?=
 =?utf-8?B?ZkNJVUtFMDQ5U1FUNFdINXh3NE1tMlZCMlRYNUtFNHRnS051UGUzN3RoS0Ux?=
 =?utf-8?B?OVBMRnNwaWpDMmR6TWIvVlFESmh5eXU5UDRQaTdCOHY0M3IrY2VqUmRFYUJH?=
 =?utf-8?B?TVRZdVo4L0d5RjF1b3Z3RnZ6QUtCQzZvR3I1MVVFcE1US1AyRTR4ZU5TeEo5?=
 =?utf-8?B?VHBweEZwRkZXLzhERGNFSlB5ZDRCZUcxQVJlelo0UU12ZW96WlBaTDdzbzc1?=
 =?utf-8?B?MEZBVlRaN0tiZkdoNS9aVVl6d1lhY0NleDkyU24wS2ROcWNqWUNDRVhXQ1Zq?=
 =?utf-8?B?RS9zdUl2Y0dLQWV6emRxeDJaWXlsckUrai9YZXJ5L0svOWlubCtSdXZkUUc0?=
 =?utf-8?B?V215MGFZTHl1eWdDSndVM1dvYzY1S2NERE5zRENOTUIzVk43dVFGOEUyWHJv?=
 =?utf-8?Q?77mcy1de8YeA+MFA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc22251a-9ad8-4ecb-be1c-08df244e940e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:02.1622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up7wZZT04RU4THvg0bdbF/y14eLV4LoPF01Vss+tGFeFckEHckBrReK/+YzMHI0FpiN7cJ+TKzVinRv6QsVoCeoxpNtMXNpqtcjjTuiKvKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-kernel.c          | 6 ++++++
 include/hw/virtio/vhost-backend.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index daa979a1aae..fb580aa417e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
 typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
@@ -205,6 +206,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;

-- 
2.47.1


