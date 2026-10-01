Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2441FCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8C-0005NV-PB; Thu, 01 Oct 2026 04:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC87-0005Df-SZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:03 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC86-0003Pc-5z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWmNLKHfok8uIRv9GZEp1zscQd4fpRGM6Hl3cxyiOYqjgxK5rEQdyMDx8amAu2kLXBCSe/KqmZBRnGyCmg7VmcjZHLqaulrovr5tc/3kqheY+txnU411oHkqnCVbIl0eSDhKpdWhskmpOjg6/r7tcVQZuyarHBqjSNgWjL9CsIIuHgjexH7tUYAk/VWEPZNxp3YdlWEbiYFmEtAPOIIq2jE1o3BZCWXZKg9OnvQFPXUfErvvf0X+HtJxJ/xdiivO7XB8EzikIzAACMC4vLXyXn3Dgw8eI8D31zvJ70w4YaCOJb0CMsnpdpL44Lw/zfIg3oXs+BnAzKfrO3nLyO5AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=jCvIysI+rspO+7Topx/cjjoN3JrbYRuztzZaPv6lzgFffixStGZMTbCUK7Zn/RKztt07LlOGRDl64+7gKDqVZj0IfEN0uhnIzWK3BE8Ac6Q+evTRGANjqtK3zPvkMUCHzlf845fS0M/Lknjz26aK26h8HgPcNlZCrAvejFkacvX4vE2nvvm21eljOs/IkVOeVn/VfLmInxOoniD8kElTnIkro9eCB5wpuq1PmlgxpfmVqRIYTDHjWuUn7h9qOOTEzJ/OUPMePCN2szmiePZ7Ha6DBC3KHbdp168ECin/wR/CcwqHhzz4BzoYOWtsp0mSI3g72Wr68tzyP7QU7h3MJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=dtG9+gyTLkQLjxo9pHIwnmxuxsfao3gZ1uqU2SG3y2NE0ftX34SQUyUZbAJL/AzNUc9dQgaqlJ0swXnv/i6wcTdJ4syZBhvLX5sEWb94CtyxHAEHQdDiu0iz08ZIQsffnKgWb5FxrfL0tBzk30sKbYDz7O+XMP/mSnLnX5KCNsyyXHNeIneZhn9+TikdTRxO1YDz9uXq+qP/JHj1M0RrB+tHVMYRSXQ17Dfm6qL60qo6Q13/5a5Mbb0AUf2uJcp9NxJXt3+VQnP4FS6PO2C0WWun8qFX08kGlEA1TKaCtlLe9aB5GIJF82mG2YPp14JzO6UptnFsH5cpQ+gM77j6+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:50 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:13 +0300
Subject: [PATCH v10 13/18] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-13-8c094843e98b@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d5198d0-7c31-41e6-96f5-08df1f95bb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: RxbKROgdBY8I0A5MR0ka+tMTdWnHcSmySNWHxOLhLlrVPD0mJBsQfHZUB4lXxmO4KJsbgPZPjmTxmltUaL090sLr4hW5mvGqwnf6gF5WU0zo0BLrlyMG6hmcouTrB3tMVTiQBkJFgjizP5tOtrtCuvnokj2GGpQFoLtkD/Jmxiey2r2tzhkev43GThCT1nYvllmFwqvKi4AkE6Gh14T3JrBpJCjFl6T2S0KsxkT5HDPokOrTpmEgD7Dl7wtntAQeWsGb9hynYe3vcG49+oGoNbu/jcKSFVDOA1jMK9AqIYQ/VlOPtKaEHwZaSPz2ngmAmi+e5mC3dk8A0SvCFm+Py6d7nqIUl62ud8rjUT5TswmzdpIcNQaN0xL/0JtVz+ADkc4oAqC/hm/9O/ijJHRvG1K+eXIuS0WvfT7iI3C2KxryOhA2u+NxUt199kLC8pmIW+p2u9OanQfYqyK9kIwEZs19i90xZRzynlwvYphkIzSd35S89L/sGG1hvYGyEXlAbo2lflGvpY4FVzptOGVv5P4VAjBu5cTtHzYtKxGvEWQWakbaLrJP3rLDS094CHo0KgSpOvs5w8M+Cia4QAdjOGTOEg+iw+tYgfji/buP/1yxi8+balFFqzp8xvScKiJ3hQwC2Klf2Yv9vVCPZ2RIEPr/uG3c1WImmlr6fzmKcYIPYcPfUvwX41SvYU6UCGOuojwEA+0j0nfjOU3ysidIou7d2PQWAZbiVBN87TZ69Kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3d5U2RvaE91WVIzUDVtNW80ekR6YndSMUkwb0RTOThMMFBPYTZKcmpQNUdm?=
 =?utf-8?B?SlhIK2NJdFlhb0tCZzV5b1gxdkxjRUp0SFhQdGtiSnZ5dWZuYVYyVUJxcFp0?=
 =?utf-8?B?ZVc1Y3JzN0hkT1R0OTdnRTcvTlRQTHA2Mkt2WUJJTytocmxWb3Y0L0FEOFEy?=
 =?utf-8?B?cWtPZFovbGpVZXNFb25pWk9PK3hOeDRJNWVQaHI5cDVMYTZzZWd0dlBRNitG?=
 =?utf-8?B?R2JSNlFZd1c4Q2NmSi9CWnRFNDdaRmdiamlzNTA0Z05HeU9RelhRM3ZIcnBz?=
 =?utf-8?B?SXAxbm5la3FaaW9XS0NNaDVKTkZ0WEJUOW9BY2szS0s0T29qUnUrbDJwazFN?=
 =?utf-8?B?K21tT2NwVk00Rlk5bG5XMTEvSUJDa3pEaGtBbW5wQlFLcUVPOEo3UjVxZXpn?=
 =?utf-8?B?cXdFT1hmTG4yNGd2QnF4L1lpSUNieFpKOE9Va3B4eVJGVGJOZ056U3BOVUVk?=
 =?utf-8?B?MStZYmpDQ29wVGtYTFJDNkdMWXpaMk9HWlpGT3NscGFzeXhVTXY4amJOMkV1?=
 =?utf-8?B?ZFVudk5aNmZ4aEswWXpiTTluWTd2NDRFNGJvT2RHKy8xUkVteFlPdXlqZHEy?=
 =?utf-8?B?Y09oKzVHdVFPSG9Dd1NvUmplMTM3aUswM1RmZEJHeGRFS1ZOSnViUnk3R2d3?=
 =?utf-8?B?bGdFMmNGaTJud0gyanI0b0JEL2dlOGZnRE83SjljeEtvZTdEd0RPYk5HS3Jv?=
 =?utf-8?B?YW9OTUJ5Nm9ZT1lMRlp3TmxUQW9yL2ZSYUs5eXFqcTJVUk5TN1FPTHVqVmtS?=
 =?utf-8?B?Q1hrcjlIWnNtMjZmRVJ5R0FraytuWTM1YjZMcm5zYW9jbkg1dHQ3YTRmVDlk?=
 =?utf-8?B?RmxGK2lxVGVacHJ4dUVYbktpUjBPeFBVMGdIVE8yWVovMlQxenJoem16bGpX?=
 =?utf-8?B?SWhkaW9HTHpzNjRPNEZVTDF5RmRkbkdWY1c1Wit3ZWlsa1NJT1NlOHVNT2pT?=
 =?utf-8?B?Z0tTT3ladDZROXVhKzhDYlUwb0pTY0s3YmtDSVhzeElTSGRCRTdjbEtHQXNQ?=
 =?utf-8?B?TXRKdTljd2p6M2tWbzhiNVlUcStsNTBCRXFIdjVkK2N5VjV1aHpPWjU2ZUtG?=
 =?utf-8?B?QkhSZFNOaWpGcUdOYThmZmptaGJsNWhRODF6a1haK2VXdUExcyt5dkdBT1J2?=
 =?utf-8?B?TGw4MGNXRnBJY2N1Y0crR3dHVFhneXR4d3JNRGttSHhLdXNabStPUnEyWjMx?=
 =?utf-8?B?c1kxUUhaUkxjZUVaK3dpSURZa25tQjkvdXBRSlMvU2JiZmJNNEVJRWRVZjdq?=
 =?utf-8?B?emRTbzFxVng2MzJIVGxMMlNGLzBFKzh3bWtpbkxXUldEc3M1bzkvVGNXK2Ns?=
 =?utf-8?B?OEJPNUR5SWducktDTytTSHkzcUFkUDE4bWZTTUZ6a0pqMWxTSEtHaFZQanBs?=
 =?utf-8?B?NWxmQWNiQUV5a3VFN1RZaEV4a21YYzF4MmdQQlVHN3d5MlVjY1hHUFNEV1pF?=
 =?utf-8?B?TkJpeWFubFpzVzF0bS9zZlZsRG52VElneDVZYlpjb1FrZHlLUGlzOWRqZFAy?=
 =?utf-8?B?VTRrZk9CVHJYVmhodHdKdmxvMmJOVU1xK1kwV3RLYjBQYWsxbzlIQ3dEeThM?=
 =?utf-8?B?ZjNTS2E2b0x1TjBxTmlmOTMwUHgwdzBHazE4bHlWeDk4NFpFOTVodlhwSUhs?=
 =?utf-8?B?MTRSaUE4Zi9nRWpMbmdwa0lGbXE0M2MzNmtyQlBxVVkxZGsvODkyRTlSMWJV?=
 =?utf-8?B?RzhoUVNNcUFiWmhQQ1p1ZnRZaTNZN0dzSTJqU2U3aTY3Rk14OXF2WWF4V0hH?=
 =?utf-8?B?VnJkeFAyOU4vM1BqeFJwYyt5TG5aTk5Tcm5tV1NUSjYzOWJRekpObVdGcDZj?=
 =?utf-8?B?ZEM3VkhaMDhFc3RYMFcxL1Q1RnVkVCtXY0RVWVVWUUV0NjRta0dLVE1vcUFF?=
 =?utf-8?B?MkZVVk0wQzBTeFFMWWM1eklpbzBuV1FSVGozR0RjOVNUMElvaG44Mlc0czRx?=
 =?utf-8?B?djRYdlhDQUZmSGlsbTd3V3M0S0o4R3dpUFN6UGhSSXRLS2x0dXJIMDVSQ25y?=
 =?utf-8?B?aWU0R1V1K2V0dHN4Q05zcHBvR2lMRXFLVkkweGducWd1TmNYRFg2NzMrOEF0?=
 =?utf-8?B?bktrVitDRWxLVXBsNDN6bGxvK00wUmNNL0pvTFg0NDZZOEtkbGdFSnc4WUtU?=
 =?utf-8?B?KzBwc0JCZFhlaVlpcWFLNUdmN0RXMmZjWVhGbVJKR0VXdVF4U3dXRGhaemtE?=
 =?utf-8?B?R2JIWkI3bEpsUGZSSjBiWjNLNVAzanRxazZyNmNmY3AyR0dUNlRZRDIxVm52?=
 =?utf-8?B?NVhnamhuWnJ5T05aN203VFVkSFZFVzREUWx2OEFoSTl3WWwwcldUNTEvUGNV?=
 =?utf-8?B?MEF0QWcvWUtmVnFucHJPR2lUdUxOMEZ0Z3dvdW1YNE41cWhMV285d3liRHBE?=
 =?utf-8?Q?We5teUp3JAXKuqdY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5198d0-7c31-41e6-96f5-08df1f95bb72
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:46.6378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCF3Sy5YS7CndmyIrjgWMT3T7b829fbmRE9gQxHKXsl6GEIEqKUx93FuSmznyHRy0MPOC6muu1GH514f05vTGebXHCLMtqPuqpxfEMgRZ1w=
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

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dfdfd49da3f..56fa4345886 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1703,6 +1703,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1720,7 +1738,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b2b644c0d1c..8127a9a5a2c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() - take ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
+ * complete a CPR handoff on the destination, or to take the device back on
+ * the source after a failed CPR.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+
+/**
+ * vhost_dev_reset_owner() - release ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_RESET_OWNER so that another process can take the device over
+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


