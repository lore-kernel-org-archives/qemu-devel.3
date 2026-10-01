Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44A7CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8C-0005NS-OT; Thu, 01 Oct 2026 04:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC80-0005BT-PI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:58 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7z-0003Pc-4k
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaoqoJ+Sq/iFEJxsRdjZrq2iw8oAEL3IRA1Kx0miE2RIF08N7VLo+wE2Tvmn2pxMpm3eAzb4q82deRTBr/s26Y/bDSyNjySkjxMf95uYezjZtNrdRFCicV2COrwzKpc0h/0ecYrwSdaCy/vekrYU3gpsmk1RzbTYsId1QEOsL0UEPkTUmXKDeGIZfk5S8Y4Ypf+Ka5T5xWtKq7PCUyIrd3IvhIrzuYNxPikW9/+xgg7HK6QuJggVIXvaV5QXrjQjb1BqES67HUGjFA9lOcXb5BfCWCn/H16/6oTXCLHSIZImi3qGm3iLaOfbyd04Xess5Qwu04uZwLk9GJYPUGbZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=EH3DX/OOv1PSfdgwhQsow1gBzgWopmG6nuK2paPbLlTe1EFLoAEYasdk6EeJRGzaROnH72PohNF5CWTz9ivd62x+l5DdPVP/5IWzPrlIsOuaieKKqcy7ZVCUoxLqIaFdksN440M2/cIMD1b7sTjpvuxnreU9cp13ucw4okELx0moJzLAHv8ii5GTjTwjPnjEiNZZ28+Zh6vcMvy+tmSKQrvNALAnqueAkiCPS64yOCmvgCLMc0lx4XKe8EQnovZIOwKwPaRNHql2eRzYnK/ChVTqOmyOD37Nao3vEstmAlMeWXH2Npvl/H4SNUnegxcGbjvNEibJbNhCS0qqFZZrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=zQfftGxHOC9m597y7iIYZze6Z8JaReRlncxzSofZjw7Z7krSkWqZ4WHq6VPTNjCoXmRP0IKdG0M73g+pGiy9S/XvpUmwVI5iMdU3AambxkemQYWUSgLBlEhvOGRTTZLGt9MMihdHbOj4mqVNKkI0Iy4qvHaHHQysHqtT2bYfCrwKy8SqUQR+DSM7tNvjoLYJkGDGKRo5DjdEKc2PXdd2Wxecx9MCsJO9ldOaa4/k/8ZRO+dqlxNdCZWrsUa4bDJND1yweKat4Egs2odr0KjFs8va+uEnfQ/BiH1n7QF2BAbRlAQlJesAVWEpgk8/Q/ZGwBG5lIwDs/QCc64IPJfXXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:48 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:11 +0300
Subject: [PATCH v10 11/18] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-11-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 6342a1ff-b721-4a9e-90d7-08df1f95baa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3nFU8I432l76B6wv+xZ/dtH/s96QmL5XTrBiM8sVp5Tfl+Eq+RFyfEEtpyBlKtdpSWFORSq4UpfvsM0hipGH4zSoR0ZOMFkckNHM0uuGdUc1ouRF9ET3RvN/qu7J3+U7MxJ7FD3AGi6KD2NxKjoL32UneRn4Q26y6VegKoQMtdpu0HZPUwN22T3JkC+2jbZNnLjanWZwbhR4u5eW7yyTE34duA5vLaAiieAgHmDkC53YE+iLLrnaUf2yaIe2+pp3854nxLREKoU0UUiK2K8wPrT6WvbyYKQDqBevPzDiWuzd65jDEgpngXlkZIUeW/o2/QRw0VQekqfJTK9OyA00WGhOIuISzvUmA63lAnK8OOB7N9vAlD/mGSjsIVpZYUK/xLVhfKJL5zZGef7oWhIUv0H2AM87mkdRRY7SVwd47kEbVWZ8bBxl1Nh7xZmPHk3TyQV/26i3NlblYCQNnUIxgW6xpN+tmyrXN0Iwn1LoVAfC6UOqM+LYf6d4mKr+7b/xsoV2T1H4Fi0OB1MMBOHx1W2dHPgiz9v3SMdlByOxTWCJsOtLxYq55udMY+W+D4AQdhI3O62oWTIIge0ZiKCjpfERKYyZ5dhK827nbmVSNBVU7s7kYMTpTnbMdFW9rzDB60KHD9FD2ypT9mWjzJenpvmoD30KO439Xw6qCcGtMRT5wmTVteSgwx/WBs00ttQg+fHY0FXWjOdm5No9VxI2MYooo27Xw+mbVM9CMiJhmm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdTNElBUmFaMXQ1OXdWSk94bzB0eTdJV0R1clJTSlRzV202d2laL2I5V3FN?=
 =?utf-8?B?TElTQnp1MkFkWkxzQzl5VG5jRDdPNWY1RmExMVNwaGJOeUVUUzd2RDdnT0tM?=
 =?utf-8?B?Q2VvWW40ZXlGZGdDcUV6M3Y4R3pTYzFEdmVhWkxXMVBjVk5iWHMrZDlHYUlY?=
 =?utf-8?B?dnhnUzZuZkpqMGF2c3VHNDNYckRZM0s1aWpXMG9uUUQ2QnlWa084MFVPV3cy?=
 =?utf-8?B?a05mYm9ocWRyWVBneldBZnJJcjUzYWltSUplNDVMZ2Jma09uSmFXZUhUdG90?=
 =?utf-8?B?cm5KMjRMV1hoYW9IKzhQSXZGRWlaZ1VSVnRJUkpMSjBRUlJ3L2NTQTJwRVRy?=
 =?utf-8?B?OVFDa0VwNmlRbEVBZjlncVZTeDBSREsxdUpUd21zTDdrZ242K3lRend4Um1F?=
 =?utf-8?B?aGlMRTgxL0h6c2tVSm55YVM1LzRWTEF3S3V1cGhRYnFIVkFBMzRabWRmaDkz?=
 =?utf-8?B?akUvN3NabGd4aXlJZGZ3NHFtU0dJUnF6M0xNL2tTWW1OSk9ZNktqOFdMSC8v?=
 =?utf-8?B?azQ5eDFXYlVIK0dTY3lZSWU1M25VcDU3ckRwSllicXlXL2Ywd1QzWnl1dkRL?=
 =?utf-8?B?d0J2NjBBN2I2Vi9XWW9qUHpkUWxQKzVFaDZ4RWJQZTV2Sm1TNndja2JubHNI?=
 =?utf-8?B?Z1g0Y0xkcU0vaEJWRGIwR1VpUk5GMnJkbUhhT3JIREFXNzgyVGlwWUtwTGtN?=
 =?utf-8?B?S3JjMng3eFVFbFdhN1F5eWVGNDF1MlRicDZQUStRU3dyZ2xNSnF1Nit1TWtJ?=
 =?utf-8?B?M2Nqc2l2a3B4QlBoUzF2ME82Z0NPQjU3SlVrWHZvQW9SWi9qRlp1cXczajJ6?=
 =?utf-8?B?RnRHMUR4OXQ2UlB5SGlXeHFlQU5CWmFvY2ZsMzg2dWpJQmkvSER0TERLVlc0?=
 =?utf-8?B?T1hWNzMxVnR2US9Kc1l4Z1JOb1BmYnBNSEhKSG5YWTBlZVNPK2ozWGZNVHhW?=
 =?utf-8?B?ekdzYVd1VVk5aEdVU2gxbUpjNVB2WGl2ZzlDRWlMMzVWTy94NHpuQWg0WDRl?=
 =?utf-8?B?ZDdBMEhIU2dMMXYrL3JDbXd3L0RFVXVZamZ3dXlVMjZQRmF0K2E5MW4xblV6?=
 =?utf-8?B?aWtMM3lVclg5c3hnWi9VaFV1QmhlZFlBelNRSmM3SUYxdW5iZUpsVFdldlBl?=
 =?utf-8?B?am9weUd3bzFTZW54QW40a0pWeGZTbm9FeXlteDZJRGgrTktFWTJ1Q3lFSnpD?=
 =?utf-8?B?M25LLzI2VnpxMkczbmtJOUFEeUJsOURlNTM2elp2YU11T051SlYxTlByMW1l?=
 =?utf-8?B?UHh6bzVXWWZWaVVEeWNTOFVpRFhSOVdqZnNqazU3eHIyTzA5MGI3eEs3RGRK?=
 =?utf-8?B?UkJuUUUwUjlXaEdObTBMWS9YRDY1VWtjc200K01XbVFVV0dYcU50NTgrQ093?=
 =?utf-8?B?UmhIYkNkbThmY21LWmN3b3JkT2l1SGdtelM2Tm5yUXdmV3ByM3BiNW41UXJh?=
 =?utf-8?B?Z0RJWWpoUHRnK0FYUzJ0OEFyTlBzZlJDeFNobFRRa1BnZHR6R25zSHRqaUw4?=
 =?utf-8?B?Q3dtYTZIaGVZbHJCZXVTWm51bTdMeE5wQ1BTb1QrazJxNVFrWW43UDlXTWd0?=
 =?utf-8?B?cXl1c0VweXp4ZmxxWkhCODhjaVBpaHVWaGhUaTdvdTdRcW9VYXVBSkRJQnJB?=
 =?utf-8?B?UnhDQ2ZmOHNYN3E3aEMxREdqcElnRWtScXNUQ29RaDhLNE5EYlU1WWFPK1dw?=
 =?utf-8?B?M1VEQzdWeFNiQXAzNEpDaWZaOXpnaCtYYVVpbDVacWJFaElBZVJqNHByTUlU?=
 =?utf-8?B?UW8yUHVlOVNibWw2Um02aGxKZWQ4K3p3V203RVZQcU5vRndoa0ZkRDNzMm9z?=
 =?utf-8?B?Wks5bjZ1a1FNbVZJc3VDVm85WVppaVFzUGVrTlZYNU9nRHBvQi8yQktjSWRv?=
 =?utf-8?B?ZHd0WWpYVEE5aUZFTkliY0p0Y2hCaVYvRHhqbkNLc3U5SlZnVHhmSDQ1U3Vz?=
 =?utf-8?B?eVBtbzRaMkR1TWhKNW8vVFVaaG9RUFh5Vm9CeTlEWUROK3dXbk9qKzl4bWFk?=
 =?utf-8?B?Q2J0OXp1dFdiKy9ObVUvVGNkMnZRbVZwNGl2K0pjUmNRZHBESmthcm9xSjlz?=
 =?utf-8?B?clZKeDZHT205MDZZZnhkdTFnWThaOHpNMmlxZVNiNXpsSC94MkJLdFBFcG5N?=
 =?utf-8?B?VlRwbTFwSUJRMjNMc01mOTFMbUpGbXd1UGRrNVcrRVllWlpqcVJqYTVDUUdz?=
 =?utf-8?B?UzdiWGNoMW41UDN1TC9KNWVLUzlneEVCRmVpVjdrVGRwaVpIYllZRUU4dXFl?=
 =?utf-8?B?cE1hbnJJajZEZ2FnRjdSZVIwMDhJWmkzSzg1MGU1eUNEcWFwRjdoN3FMY1RN?=
 =?utf-8?B?ZlVtbTJ5WUYxVmlMUFZvU3RPRnlEU1BJZG5QUFIwTDV2Nm9CcFZyRC9pUkhU?=
 =?utf-8?Q?X40AVF4F7TLA9GjU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6342a1ff-b721-4a9e-90d7-08df1f95baa6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:45.3330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I58tPhK9AOtt6I6NBWAK0X0W7br0T1VQlnBfFbkFanvM1emle5Fqm2YEBO+IPSLCu0oKWjadGWbODfiB+pd9pHdk+CrNV6lxRhTfswZIi7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Split the first part of vhost_dev_init(): selecting the backend, calling
its .vhost_init() and reading the supported features - into a new
vhost_dev_init_backend() helper, and call it from vhost_dev_init().

This is in preparation for CPR restore of vhost-vsock, which needs to learn
the backend's features at realize time to negotiate them when loading the
incoming virtio state, but also must defer taking ownership of the device
to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.

As a result VHOST_SET_OWNER now follows the feature query rather than
precedes it.  This should be safe, as no backend requires ownership before
VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
for it, and vhost-user already does query features from its .vhost_init()
before set_owner().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e404818..99561ac5868 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1681,6 +1681,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
     return r;
 }
 
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp)
+{
+    int r;
+
+    r = vhost_set_backend_type(hdev, backend_type);
+    assert(r >= 0);
+
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    if (r < 0) {
+        return r;
+    }
+
+    r = vhost_dev_init_features(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_init_features failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1693,10 +1715,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
-    r = vhost_set_backend_type(hdev, backend_type);
-    assert(r >= 0);
-
-    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1707,12 +1726,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_init_features(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_init_features failed");
-        goto fail;
-    }
-
     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0a322efec1d..b2b644c0d1c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -156,6 +156,28 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type,
                    uint32_t busyloop_timeout, Error **errp);
 
+/**
+ * vhost_dev_init_backend() - set up the backend and query its features
+ * @hdev: the common vhost_dev structure
+ * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
+ * @backend_type: type of backend
+ * @errp: error handle
+ *
+ * Select the backend, initialise the backend instance and read its supported
+ * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
+ * virtqueues or registering the memory listener.  This is the part of
+ * vhost_dev_init() that precedes taking ownership; it can be used on its own
+ * so feature negotiation can happen before ownership is acquired (e.g. by CPR
+ * restore).
+ *
+ * On failure the backend may be left partially initialised; the caller must
+ * still call vhost_dev_cleanup() to release it.
+ *
+ * Return: 0 on success, non-zero on error while setting errp.
+ */
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


