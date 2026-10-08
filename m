Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6633DCA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKa-0003aS-GS; Thu, 08 Oct 2026 06:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJz-0003GJ-Rf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:58 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJx-00014o-1Q
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELgtybSXqra9GzLsNhTxm4/MYxEIkw13vHKR2rN0uSb1FZ9xGh/jp4ZDgjSO60mmuxAPDbW4TMfK1oBMMKx/AlnUZ2+SJ29e9FccSk6PQhOB16tdHkLRGV1GoD7CmwagGeQ+H/znsNUfVwoQuEVW72ZyHFoXWuAlG3m6sfuZTK9tj5kZJYwSq5E9CGk2bFxBpWEVT5uiQh1e9AgkyPRzWhQKzm777wGmAvllwtR3vTM+38+5yGvwq7wVTIftBq3Cx2i5gaRMcuMYgSDhx8/U4atrxdXKXj5CjmQbUl3ezL7nkMX7auuAbTFgfnIUzlsqPRlYyO/Y88mJcKw/2WX1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=Mgxa2DOI1WZcwDFMIQCDvFv4WBjFqudZ2Bjxl5ly5Er1fuNs3EtWtbWmAOxsg0WuUj7h/hGEIbucNNO52H/N/PDdYa1+j/JBQoa1PS5wubLPxQvC8pXkdKWrt5hcUl/9rt7JSJxUEcUs1GxpCJQt5+RB5RVXThokX9us3MZ5uRbFdW55LdtHmGPEs/4++pJ0+vg2W0l0A6tAjj+92qv8ieM2EhEsjuyvEDntDpAUCRglbNJ9uEYNBRgwncomJVr/9aHSnSC894UBhzso502oD9AONPs4HnqUuuK21I9ARz79rqKABC8CKJlX3Y9FKjGG0qLm1MNjtus0cYafcBqk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=mTzuwqQ7zqUoSynt7XpWNP37P+5GGER4R0Tq6z8PYsccKBTLYgmNfekR4T+4jHw7Sv9V4bzjXBfh9qXAYoRwdUSxchJMXIsIQrYuXcFyJvF4PGFqXvhCOwYzIImyDF+Zfx4IheaYlzxtI3wotT7zescbj/cI8NQj1kPS5AmB1Q6uLywKngWqp4+UFlfMfnAq8TZCHVp9M8JrmHE9NfzVvpsecTDnZkyUuyHJK/CNM2UcQvTvy4ITZSqBCbVprzMb7sXhatSPxToddSw1KFJhIcv5ipJvuTGAeBMiDRe9j3TilW0FUTAyOX6GghuLJV9iyaFxwQa3iLqSvvG8qLMXCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:45 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:38 +0300
Subject: [PATCH v15 14/22] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-14-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10270:EE_
X-MS-Office365-Filtering-Correlation-Id: 276cc66d-3055-4f6c-3cf1-08df25268192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: M9K0DlwFbf4zMBiVTYCyQmVS2SdjTJ1fgJSvTjMdhMEqWZVY+aLSqXfrPoLImiWYkO0CrFUmZeAWcs2xgKfxKV8YkXFXL4TOOPdandGA4zX1MkrNTWUG9UEUq6ibi/AzzpjcHxPYh2ijP0fkn6KpuP3Hm3Vlh26JI/1bpfAbrsvOXi62qKawPZZzK0prN/83mSnTi3TOmxtA4/CDa7cgOaeA8FP6eNCr0kJO9fLBGl95FKOSqvKpCvU8fonpf6vOGDK8qD9hLtBdvEHT3cT5gg4fM4QBwKOnSdcxr9jyfjSCtxLgnJrPoMX0OJ8U6Uey4CTFqTbEKztRJminELcK4LoDVX4ngAXxXS8qp2QyXzm9NxB7ysmlmShTuFzpYbp7m1WJ75+EZJK8JDIZVXh4YPNkM42nJnwwKw6lnLRRag3Yqv2h3uTqrory3MLzAaQmvm9tGpVgpn/LeRswYcjjDyAQtyquiOBTfwi3OEvYvP9DONTwjsiuee2KfzaosuesFABJmpNemAmQFXjIcVkeYrCHXJCyZ6iYs+25TdbsCj8EDS3uS7zebik1Zi+a5IQSa41aEh4j+ddmQEDv6DLXVuAezIPIMgqSDt8wkS8h7c51gUW4UENbFtcOrKbA+M0G5VTC070qe0AuEoWSBB6QrzPvTocEB9ToeR+BffojJ4YgoYhomA0Qfzx4RbUnvMhI1JhWMSJd8x3Yrmhs9C89ZwiXUzVD7QoXfLqnNS8ayp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BpVG1ZR2NrdUFsT2ViUDY0a2gxS053Rm1CbTNRVW9sZ2pkY2VFaHpxRGVI?=
 =?utf-8?B?TENQTW5BK0dZelpKM25lclBJWWtNc3lqTXJ4Y0hEQXhMcFkyazRMYkRRS0Fa?=
 =?utf-8?B?VmdhOFpTMUdsVXVuM2Q2Q3FaRDREeTVkdUhwc1NwVGdya245eEtNbkJ5UUE1?=
 =?utf-8?B?ZDRPQUxDb0lMT3lSYmY0ZWFNa1FnK2t6TnFUS3JMVjRjcHgxSjc5Q3pGZGQ4?=
 =?utf-8?B?UDcvbnJ4TzI0TTU0bHEvbGZFQnhpOUhzam5IcHhZVk5hNGpyalBMc1ZiYXc4?=
 =?utf-8?B?M3F0d2J5bmUzVnNmZmszaUM5bTZGZnRPNm5jdUhncnZseStHYTdlQlQzRmVw?=
 =?utf-8?B?c3BSVDVMWjl1QmVJSGwveGhkMmp5bitSY0NhOVVUeGtMRGRCR2x2eGRyaGhI?=
 =?utf-8?B?b2QwTU1Ybmo1VzN3MjFoK0hiQ2xrZFFhVEk5V2Jvc2txdlRXM1VoUTdzWEtQ?=
 =?utf-8?B?NTlXVjhTK3lVZnZuN0FkVEhVUFBDdmFaRnl4MU9mRExWMXJxYktJRlJQUXhX?=
 =?utf-8?B?K2F5TWFnTWZEM1kvM1VlYUV6cGg3OHdtVnNXd3Q3WUtrdjJ5STI4Z2dBQ2dy?=
 =?utf-8?B?SVhhSE5lMHFRdUFEWkV5UURSajF1NjhObENPVnd6MGhmUTNsREdJd0hnQnJQ?=
 =?utf-8?B?dnpWVmpaRUJudm5xN2xMZkdBejR6SEt1VDc4S3hmbnlCRmp5WGxMeXpKNHJ4?=
 =?utf-8?B?NTBJdlJXVjhPN1loM25TU2h1dEN5UDVmUE9xL0RnN3RjenVoRUdIU2dmaFRy?=
 =?utf-8?B?aURSVkQ3cnZkUVRSb2JvUFBDYXNyaGhZRk1wZmhOZ1paVkxadkphSTdqcFY4?=
 =?utf-8?B?ZGtRYm5UQm1Ld2J1SkpkMlhLanIyT0lyZWhkSUJIUDVHa3c2R254QlZyaXJI?=
 =?utf-8?B?S01iSFhETFhOSDh5d3k0aEhoZ01ad3FxUTE5VEJjNXY5SU85Y0J4U0VWOFQ2?=
 =?utf-8?B?c2RPbWQ2clZWekZ6RXFwUGhkbDJvY0pQRnc3aHJDSGlPT0llK29kN2dPNTJL?=
 =?utf-8?B?QjY3L0pianNXcDdrNURzUDBnZGllbm9mKzlBYXBRZEI0L3I3STZvcU1lYTJK?=
 =?utf-8?B?bkx4Y01DVGM4Q2tXMy9kcWVJQVQrSGtEeURQNXBTVWFSSjl3MXhCWGczZU0x?=
 =?utf-8?B?SEZLZkRiV0xPMkJ3Z0pOY2pUV2NTK3laNWQ2UFFKV0NodFV2UXhHN2M5UUZp?=
 =?utf-8?B?czFSSXRlSHBGV0tBS0ZHeEpFZVBGWmpjeTVEa2l0WktmOHcvNlF4SXZWbHFC?=
 =?utf-8?B?di9WRGJqRmlMNDJxYkRtenNJMlYxK2E2S2ZNSjd5Nk9jTVF4YVIrVUFUY1Vl?=
 =?utf-8?B?d2krN0pheklaMDJVL1pJTXFzUnc0ZmhBUHFkWTNXN2FSL0tSdG1hWjljWmxG?=
 =?utf-8?B?eWZrK2RBSEpPeTIvejZZSTB4QUJ1U2ljNnA2SWY0dDEwajlFRS9IS2R1NEpr?=
 =?utf-8?B?enpTNFd2UjF2emVFZ21scG8rWmo3SWFPWnVVMkNEUWRDZm1DTEZIUmxnY2JY?=
 =?utf-8?B?MklnOVBIbHo2dDdOOU16L3Zac1JZWWwwemM4ZFJkTkJzblFpNW9ZcDd5WTEw?=
 =?utf-8?B?L01ML3MxOWhiOWNrUjlKNk9wQmp1QkFZRVVFYUtMcjVhUmhEdDU1b0tqVHhM?=
 =?utf-8?B?YW1XM2ljaEdYM1Q3bVl0b2tpYVFHYkZoV0ZUaTZiMTJnWFBvYUZpVTdRc1NL?=
 =?utf-8?B?Yk1xdWwvZGpUKzB6VUR0bGVwMVJVRWxndEZHZHZzbHBOcXJVOUo2SlpWSEM3?=
 =?utf-8?B?UXd5UjZVMVlwQ0JBSmgzdGx6RXpmeGN1S0hLaUt1d29FMElwMlFwZ2cxYjVy?=
 =?utf-8?B?NDBBTGZLK0ZWUVQ4SkNtRjhZbjNwaGNtNGpVMlhnbHdxYVZKK0JKdFBCcXFP?=
 =?utf-8?B?ZU5HRGMwb3NGU1VOUkpGekNGK2w4aThzb01CZzdldU5SRnV3N2c5K3BTMjhU?=
 =?utf-8?B?Qm05MXdJVjhKczlJS1JPWmRVQ2s1SFEwSEg3blRCYWowN1QxcUhoL1Nkb2Ny?=
 =?utf-8?B?eG1UazF5aWVXVDhBeWNrU3NhZmZuNmlISXV4SE8vTzdDc1MyRGdDZ290VWkx?=
 =?utf-8?B?cVlBTjdKZXpwRXNRSERDS0dJQjJQbXdMR0loSkZHNzMxWmQzWElZY3ZnZ3Vy?=
 =?utf-8?B?WElVNS9lNlo2M3hGWEYyRnp3TTRZaGRmZkpoQkpXR1k5NTg1ei83SSt0K3Vn?=
 =?utf-8?B?UVltU2FzR3IvZy85LzUzcXFld3NLQ0x3RmlWd3NjaHA0cUd0M3FqQ0JwTHg5?=
 =?utf-8?B?Q1d3UytKaXVQcFh6OWpYbXBuUm9SdU5qZW1yekZXYytFbXFsaE4rM0Rtd1Bx?=
 =?utf-8?B?YTJwQ3lYajQ3dWZPRjlWNHo2U29ZYjcwUmhRM1JoR3QzU2psZEVKNk5XeW1x?=
 =?utf-8?Q?poL5B3PqJfrp+qtQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276cc66d-3055-4f6c-3cf1-08df25268192
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:42.4260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwhM83/O6E1JeuLnFo2tSqniIyaTIFcp71ojG3YOHIor3g0m80xIZHb6JgcWMNw7gGYAQT5FDPss6i/GaXgVKdDecJG7XrVzwRx8UpUM5Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         |  2 ++
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 56fa4345886..c01ccc800cb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1834,6 +1834,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 8127a9a5a2c..73ea130d7ee 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -248,6 +250,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {

-- 
2.47.1


