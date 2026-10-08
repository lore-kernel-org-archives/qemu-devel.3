Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E80BCA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKN-0003Kh-6m; Thu, 08 Oct 2026 06:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK0-0003GM-0L
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:00 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJy-00015i-2e
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXDwrIu83iiuraU3NtO4n899UFce28O7G/oOWupDiFtbfSETNDc5u7hlFdWF7D+jMZLtus10I6NNtgjxFMB8UnAjkyWpy+WxY1oU9S5A9bKVfz7MxS4lypNyWd+6bAFhB2JVDiLUnq0C4ze2bOGo9WW6FpECq2gXG3QCK4OrMLmY0+bAzOvbJ/3JPm8nU5hNqZoJi56bWSF9XFA03Tq2fbOK1WaQ2e+djCq4X3FibI3J0+yjOE21lnSemDbaCvL7AzITE/Wyz3yDHBS9wZo+KAUZXNOvZLMzCfSdAyD5iUJDRu/KXUdlh1K2SUcjKVO0YBznLvME4AZtxrGhsMkCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=yeJTPVW6br5IJ+ahZBHzciDT2BRovos+RLEg8YPfsfWLh0kOhUhaTs9QlEj21TyQVyGMJ5AXUt6QbanXQXr3tevgrJZ6gxWxoDEzZBmcYTBlpqD9KLM/w8grLP+MfRL/vz1fmyCElnIiN1PCk7ZiM2dRwtLO1khmMjqM9gYfb9d7nsxffK+dL63tGm3hyABqfjZRXfpUXDyq4rqwUG0aBUZ2f6p+lCy1+q3kBjtbMN+zpq/C8f6Rm3iR99gzYcEBawX8BNpJk+bArkfeqGhMe3zMUI9riCqdypXpgten6uWl7Upz0QkUegQgD491/2OYiWbnDmgmpZPlEiq/VRlIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=ff/WfglKwczwVHCAT1jm0ej0v0fyne3Qp2XE1m3nSp4ycc8GP2h+nBNuFL5AY9Q7yF8jfR1n+XQUsNwPwpvHDVG+yO1f6U6dDGMx2OFsbNR0sLJv9xZMMfG1ES+nNrsf5D2EYpljAsxSUY57EvflNUh/AR3iziz2Fu8vmT6fR179IQlcp8DUZWnJCLFYZzX/ndT5TyYLwVjur3DbAwX491wvzP4uL6mBvjaiK0afpQ2hukqNpj3TWhv2gj8bJWgnDKsEKY6l5RIijZjrUrh5c/MwUw8ROyD5PVqQRmz+xJ21bDDfEkiFly45ZRVpaUVYRDsZ/pwCKezQcPDk/kTY/g==
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
Date: Thu, 08 Oct 2026 13:25:37 +0300
Subject: [PATCH v15 13/22] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-13-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 47b754d9-5d55-47ff-fbe0-08df25268128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 5ianzObXqU10bueA1wOWlAsLqiDiGO+2Q4lt6s9tktnxy2cM/9blzAl2isieFL3fitgd1BAfv0iYfjICoeHdVpwzAGxEi18T4ShCaOhT/OcmqhJEA6iKp+a2pasP1e/FQbS0ImM9Z2U1+n+tP7z7Cy/xH5asv5c1xQ4IFYeNIqePfDVtsHNY7mLiO5qWV2XtAs1YN8WJSM/AfPRcT8qW5HGsSpYvV5gFSDOEE/0kCOxkgzwtjHWYtp/E84afidMkoUW5ngZyScuX8dc+Qz4t8AXou77B4AWDjaQoionQwbmhFbQmiKD5UuixIu6OVF98YdRIF/27RHDP63rmAvsO8C8GLYPS4H1SlAQMsA43qbTJu/Z2r6CWtOq1Dtc2ty6+q30Q2WXLyhQgDWE6m2UndprsA3EJB++JRJr5EL+gyqB+BF3sooPiNwWw/HhYA67qBaP1MuAri+/mVHZrQcLfwBXxIICzxJz23R/8gvpmv6rjd+bD/QIHXoxITHjk4mbWsdoqAXexm/C0OJzDrtkyP0K6u2PDpzFiowwHH2XZ8vfPDbqgl9Lwahd5d/maZVEPecUMalieoSgXlj2alKCT85Eg/Ch33IltMhYPTJ3X+QkFRoqYW1wLnsKetg6B9ge8JygWYzwoRaIVd0NHtiiFKkMm3sqMJBIMKWGhW5NA2yNBfVaAa4ueJyW9RFRcuzVr+G5BooHhu6yNl2fQxWYyw4lYnGhC+9taFE7EhhVwy/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZUVm5ob1JUaGY2U085MXcyWmswUWtLdHVUc1JiYkVBckNBUDNlYXhHUVFE?=
 =?utf-8?B?NysvS2lBNjdRUkhVSTdnSHRnMHJ6V3prR0JEbE5pdjVHQzhFMXVlK3ZYL3RE?=
 =?utf-8?B?RFlKUnZoaXdUaWFKRUNjbzNuOE9acjI3Ymp5c2F0QkJKNnpqbTRlVE5UaE15?=
 =?utf-8?B?N0dWK015b3kvVHhLNFRJZzVIL2lxTCtxcEs5aWN1ZkZqMDFRMGphaTlLYmk1?=
 =?utf-8?B?aEM3YjVXbFpITFMreVBORVZCRVliaWpCNlFTMWErMzFMRElVNXdnUXRmQm81?=
 =?utf-8?B?bG12K0hpQ2xlSEdQWmdkTHQwWEhkSHFXSm9CWFMxSXlXSU4wWTVtVHFJVE54?=
 =?utf-8?B?UncvLzU0UHk1cklLZW1iTUFEanZjU2grRFNPNGtzZ3o5bGRKd3JXOEd6OXNF?=
 =?utf-8?B?di9lTDNWQkpvQ0Z6S3pDMmhaWlpkRTBlL2NiZVRNS243MVJpMkR4VGdiVUNJ?=
 =?utf-8?B?YTV4SkN6ZnB6dkpyWnhnMkxyQk80V1ZWd1dQbDVhNWU5QkZPK1c3THFuN0cx?=
 =?utf-8?B?eUxENlJxdUtKZTVBOGNXcERRcTdNYjh3ZHpmcWxVbms2VSs3Z1kyZmsrNHoz?=
 =?utf-8?B?aXlLcXg0bG4xeEw3SS9jKy9kbitoK1VBSFhBamhoaDE1NmtaN1AzOFY2aHRy?=
 =?utf-8?B?TnhmK09hQjRwYmREemMwRlowdzljT3pWZEUwcUg0THpDRkZaMG5iMmFxOG1J?=
 =?utf-8?B?NWhDTFFxMXJhWHhYalNOMXB1dXRPckhHZW1VYWl2TzYyV3pPQkxrV0htdys0?=
 =?utf-8?B?QWJXSUpOMTBRN3ZYcVZpdHVLV1BtNE9wTjhxOFhOOTN5aDFzSmdBVGdoNUJx?=
 =?utf-8?B?Q2ZNaVJxZys3aWZJSUJYdHBOQ0I0TnFUWHB6Z1hWUVlaQ3o3NG5JNDFUMjZi?=
 =?utf-8?B?ZVpZNVBMa2E3Y0RNMDhBQi95eGNEUnY2ZjNxQVpNdmF3cjc0UEs2OEVaT09P?=
 =?utf-8?B?S2w3M0lsRVBtNFlDUk15UVRlWEE5SjU4VnNFTVo2b0hPN1RtZ2VuYmNpOEJS?=
 =?utf-8?B?TTJnRlc1UUpIYld1WW5WeVdzaitZV1UrcS9JWHdJYStHWFJUK2lFUG1QZTRm?=
 =?utf-8?B?bjVzMzBHVkYxKzVvZThEZER6Q282di96cnovQnB0QjZlUUdQZHJ4bzdrUXhG?=
 =?utf-8?B?RzJObUYwS09qRnEveFk3U3VobTdmNGMyY3A2WnljczdlelArODUyTUcxTVV2?=
 =?utf-8?B?Y1g2VGFWT3llRnpEbVRaNS9WODdvditRWGlYdXNKY3FqMjM3MThValNLL3Vh?=
 =?utf-8?B?WUhzd3d0bmJvZVAvRFRGaFpuQ0JLb01uRzlub1NyRzk2ZTJPd2lJOXAyREdS?=
 =?utf-8?B?azJ0S2pPU0lGY3ZHaUJLWlZZZFhoY2FPdGdaVUw3S0dOVkdhNkR2ay9GWitv?=
 =?utf-8?B?VktLWGRaa3I2ZFduRUN5dkZHNlUwNWFobXZyQnkyb2RlM0FTS0l2dkVYMW0y?=
 =?utf-8?B?TUI3aXM5dG1zWXB0b1ltbEU1cjBQdkdJU0xIMzRnOXVoMDNhUFcrL0Nvdy9R?=
 =?utf-8?B?ZGloZEROWXFYMHlRc0JiQVV0aVVEaFN0K0h5bDJ5RmhmRXdPS3dZUlVHVy9G?=
 =?utf-8?B?RElIbE5QNG9HdmhKSGhJU0xFcGJJUHZNbUFFczNxY1dMRDJnb0xtK3hQcWNz?=
 =?utf-8?B?SjdOYmRMMnlFTlZ2cjkydGlyRllUTXJka1pXdmNBS2c0SUdDM3REUzNnYk5J?=
 =?utf-8?B?ZGc5RHRBVzhNMDlqcExnNFpBZ3NaQUdtS2VPcEJwUENCSDBMVGVSbXFJdEov?=
 =?utf-8?B?cURVbTYvZ0JHcEFKVTRqR1F2b2pZNTJtbEp4aVFDbHRURng5YnVLUzFaaGh1?=
 =?utf-8?B?eXpCdmdGZTZtVmJ3MlovZGlJZExncWVBZEZhMzhRQnAyMW5uVmdJV3dCZysw?=
 =?utf-8?B?YlFIeCtpRUltZTl5RFEySmRNMjI5YjNHOXNqdmZNMTcrWm5WbURwck5jVjBK?=
 =?utf-8?B?QkNOUGhMeWF1L0cxU0xOdFFYaVBhdllyckY4QTl6M0MvVnV6U3dLd05zQ1Bq?=
 =?utf-8?B?aXFBeXM4V25XL3JiUXVDb0R5NjlRNUdzVS9tanVKTGdBTVYwaHRFSUNST3Bw?=
 =?utf-8?B?RzBIYlhoNUZrYmhqWUh4MjVSU1BCTzdZZU5ZakZKUHZnUURmSTdPWGFQQllU?=
 =?utf-8?B?ZW9KQUJzcEpiZTJGcWRudXB4elltM05OMW5pVHo2Mi91YzdFcXpzekdKRjVW?=
 =?utf-8?B?Z1I2YjJTSDRoK01DZnJibkFuTkJuanJCMFZMSGh1SUN6Q0tWUEwzZ1c4SUhL?=
 =?utf-8?B?RGUxcnJRc2lvL2tlY3l3TWNTMk4yNjhiV0JJUkQrTU9CVlNjbmtxTmdwTmlv?=
 =?utf-8?B?aFU0cU9MUll1UFV1dU01VzFIZnhYMW1FQ214b0VQQ3l4YUFzTkMzRnBvNXFh?=
 =?utf-8?Q?X39IS845QreaxnJ0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b754d9-5d55-47ff-fbe0-08df25268128
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:41.6801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiBoVvE5+qMOAkyLPxmKhYQ4CVl5BxJhUaLVU7rYJVZod1a7UQW1eUJl71/lI4Zdl5rl2uyqNI8r35cq6K6nD+lOd2yK88MCL9jkqlVxoUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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


