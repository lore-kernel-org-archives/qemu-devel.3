Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F264CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7H-0003bY-LS; Wed, 07 Oct 2026 04:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4Q-0001AG-9l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:59 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4C-0000LX-Ti
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:51 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4l8GHy7OevjCpPRRWPSKFXgnx7ngJRJ/IUfh5//UXwM3T/9zVZKHSc4agI1pvn6JsHaptk4ulkKGmTE6HvvCT45lkgIQnxbJqeX7jVSMuVO6Ju7jGPWejb5BuRpo7uBSu0WL+YCmMCI5VC0Z0et6PM/oiDvf4nb8B1PshcClYKMrT2LUw8pJzIddctiqp7XmVEtbMMaCCJdmgibHB+lg4+uiscKp4ONfDSI2r44V6EKrZvZGo34AsYbx5etZtDVcNWG3rnQlmlkH7JnRF4XYBl+JctSAw8XCjJIeRLQqPiIZ2PTdkL/SXuE/xKwiUgRTu/ggGvI1J5wxJUNoAS7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=bWquK/6ejkrBmYQ3VNRxkt/kdPR6sECIlVaLgwFidLAha1et/vdjTaRlOz2UevHA7ac3Wk5xAW6cGfYr3oQ7YC0eAjJjH8waxbvF5O/VX7ClWv83GM0XhQ6/LqroPVX/iabIaHE1VNc1KFU1jPuvik2XnUDebPNd7Rd1T9ZzqYH5Hm8p38VSQsT0fVRIdhQoNzUIgav993qD8Mhvjp6pFYvw2hgX9RJsJhGincbFwq55iSWHbBq9R/feebwhhDkFuF9crzBubrHEFJF4jMvI3aMxdxVOEbY2tmz4/XTnrhhb3tT6f4wq9sz82wkah99U4cxMbJc3pYBnHbMQcrNrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=CfFrRlvM/x9obEfAuqVE5ulCFTTFc/Uo4NOeCNgtZ15g+3SIcYtDZ2e1iyMnyWj2c8W4fSuN62f61l1GX8bUepU7V1WU0SYpLDjCOVNNmXwogkokuOa4BovOm2rRdQGD5rlt/j6QqlCFMTTP7JU7FPiz8oByS+660uws5g6LX3RIP9ThJRyKjIAicZ1xxB8S3QEILtznkKhNdPucIrQcuADIMTZiJiQWZZSPSjrb2NhfB8HITcPIQnVZ0273TCVmNALwnpP/eMs1aQ4nNuNxcq8IzbwcapIuNwMv8D7D3IqYq+T6YouOVJ55IzlNT3V3UVupD0rOJyn+lcTcvZTpMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:57 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:57 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:36 +0300
Subject: [PATCH v13 13/22] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-13-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b06acf5-d758-452f-4a3b-08df23b1f719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4AYMsEACpUxJ+2oKDhteTH2G6KNwHOOomrqlufRUVxIgYqVDADvmxpLo79t5Lr2gSR6aynT2WgHinpI7xdCzOtEY79CtB0NwUIMh3yFSFtvrTKmRp2OddgFV3QQsmUatu7Uawa0v/8sRhX/39pw4o00zA1ogrUDzpIPZ7pEuey17dTkE9DbyaQ5Pa+cpYsmpgudI9aW4MvIkWWCE/LeQDzRTSKhr46Va+ok/OWUrTk+r56C5tw0YDYui2bbCDh7oOJtQqdY+YGwYCYF1qm45NXVVTDtXL2bsDQf6Xpuu8qNoHoD6/DAjgazIwY3/eAm4QTSugXb1h/UTvPHPtANl8CS9VisU+kZIzrXf6pfDzYy7wxEREtEZcadkoGNkYzJ+4AaihCe0OpP0xO8xvM0bX6iIF9I4+CXfCWRQi8RSMU0V+quu1JeSJhybVwWrddekR9HNFv/GO6DMRDLZ2X8EIOUsqHZWIEuSZVIWsYU1ElRX5MdiBB8VnM8YDLvVekocU4POCTcDD4ynOyisk7eOELXrd+XzjhZzrN49bw6jqhGPwGQzG+argZ5D7lP9Cp6Xsv5LTpHEL251vhlKQTs2NmjhJfJNIIo0n0nm4BMvSYB6BwCduic7/t15AZ53u6YHwALS/PM7auZq2XuzoraBSidSh6TzqHSJ06n9WRZIFNnyH2VxlLIXO0C4iaYHvCo0IH3U4epxpdnWRZEJZ6E7DeoUQ0HIoPfYdbXrHzjNcwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDFSSkVtcVljMlJmalNTZEpqWTltM0tQaWtVV2pMTFR2SnVmcGtQdU1oUG9O?=
 =?utf-8?B?Y3Y5T3RBR09QZjR5cU1rckFzVlZqWFZBYU9kMU92Q2xJNFVYUDRJcEU0NSs1?=
 =?utf-8?B?ZEF2YStHOVhyaEpMZ3JTTnVxMXp4ZDhOK3BQNzNia3k4K3dKRGo4ZHEydnJi?=
 =?utf-8?B?dzlrSkd4K09ER1lrQ0x1Z0VYaERGMnk0NkZtOG5LczNuM1ZGUk5pOEp0ajgx?=
 =?utf-8?B?cFEzYVNRWlcwNkVKVHJ3WGcwc1lOWWs2VnNNMmNoMm5xdE1ON25FbFlWM3Ay?=
 =?utf-8?B?L1NQSm12cjcyc05tN2ozWmgzSDY0UnhwUWZ6Z2xpQWNsUlRjUklGOFBneTc5?=
 =?utf-8?B?aWZ2TWJJaWllWDR0b2dFNjFmYXNrS2dQUzNJbldUaEhXRlVKNHVpdGcvTWFu?=
 =?utf-8?B?amFxY0hoTXB4UmFpV0psb3BraHlZYmtlS0gxcHVoaGZwNkV0SktjU0pjK3o4?=
 =?utf-8?B?M0RUNzdkMERYdDQ0ZGZGVEhjZDFyY1pZM0FzdXJSL2tURDdMVDlpbjBCNEVM?=
 =?utf-8?B?M0F2SEVLbmxITE5HeHpncWFLSHBSTkxkUHdyUDN4V3Zmb3NmNklDV2N4SVhu?=
 =?utf-8?B?RWxuN1FzTm44bGtBWldoeVdtS0tLYUl2U0NUTjdpR1llSXZBdTFQUXZYNTlH?=
 =?utf-8?B?QmY4TzRFMUJpYjR1VEpLbEwxVjIwaEFaUW04dmp4RzlCUlpFaUFiVUt5ekZJ?=
 =?utf-8?B?c29WWkxGcmlNZzdWeWVUU2c5LzBxSWRmYTBvbytZWUU3cEJnM1g4QThDR05U?=
 =?utf-8?B?R0RKcVBkVld6VUlHQU1YL1lDZUtCNFRlcDFnNGx3ajN4SVpuN2VtV2JJL1dx?=
 =?utf-8?B?NG04cWNRMXBoZE5RemFxTC9tRnIyY25XWkRJcTFielE1bTNNbHRlNzJDY3kz?=
 =?utf-8?B?anhyaHZ5UmlBMmwzbVRKSXdxbnozQWNXYW93dzVSSmhNR2U2YXpEVjRxTExU?=
 =?utf-8?B?N3lEQ0RsVHpreW1BeFo5SDFPQmVCZjk3SDR1bE9CK2ROSVJhdkdtVGJ6djl1?=
 =?utf-8?B?UDV5YXBMbnpiNTJ5dkZVQVM0SUhZUW9GcmdzVVBjSlJ3d2RXeGRLREtOS2VZ?=
 =?utf-8?B?R1hnVUhEZ3FtbW9iNjdQV1BMV0xYc0NXcHlwZy9ZSzJGZC9Gelc0YitqaGdE?=
 =?utf-8?B?T0FNMVFuMzJ3cUpWVGJIVHJCajJraE45dkJsRUoyN0pRZ1FXZWJCbS9OMS9k?=
 =?utf-8?B?NGpaVHhKanVlbnAzdExpMDVBTFlOU0xycWVaYVdmcHR6YmtmczcwUHNKc1pL?=
 =?utf-8?B?VGZNUldNM2FyekIzVTNMcUxBUktWSzFIdmgrdzZEemp1eWlXclBCRW5LaEIv?=
 =?utf-8?B?ZEVJaExTUk5TcGQ3TEpENUc3ajBZTmpRL01hVTMwckk5V21YUnpuRE9yWFRQ?=
 =?utf-8?B?N1VtWFcvcTVQclRUekFObHhKd2h5Nm9LcENPZ1ZCWFpWbVAzdVkyV1BYMCtx?=
 =?utf-8?B?VzFIbzdhZVBGUGFWSVNwWGxNaHJqSUkrMFpBa1R4bll4aXc2VmRrSzBBeGV6?=
 =?utf-8?B?cVZJbEdTTXNoeVNYYkVoZzNqd1NMdmIwbHFEbGNnWGtrQjdZMjlrUU5pcTVH?=
 =?utf-8?B?QlFMLzFlL2Z5RHpyaW55YXdRUTN2ZC9SUlpSRjZMejZMTXlDaDY3ZWtXOWFL?=
 =?utf-8?B?eldncWtubm53REFmTFg2cEliMkRDQ3IxYTArUnkwVXpHUGJrZDBSVlNweHV3?=
 =?utf-8?B?b0ZrYURNS1N1SkQwcXR3Rm1kS0dEWmZrRFQvSDE5YTQ3R0k2Smc2d3ZnY01t?=
 =?utf-8?B?ZUl1cXJOU0U1NEtVbWpJZlRvanpxUXRYV1RmeU5GR2c5aHNJZEo2QzNJaFlz?=
 =?utf-8?B?R0hBYko1M09hNFZobGlpVnJ6UUdBS1ZmVUxXTE1ITVNFZmdHWHNxZi8vM0Jm?=
 =?utf-8?B?am1Tc2JyUmdES2t1elJPczY5clZwZjNZakpwUTVMWGpvYTdDNnRrZHNVbTBN?=
 =?utf-8?B?dEpXTjNUQ3VEbHdQUEJHaDUwT29hcEdFVWtuWWZPL2VJY21DSmt4bWZTRjM0?=
 =?utf-8?B?Y0tsdkFBeWpoOXJKeXBqREF4clJGWjhVRkNRVUZYODd6TDFBMmRsanN3VnBa?=
 =?utf-8?B?bHNqSG10NEVyeVBOTFc2SUgwVzhsTkJyY1ozSkxUWm5FVytUM3FXZHlXSEpT?=
 =?utf-8?B?Z1FwQS9Ba1dQdVNaUDVaVUtwNHQ4ZCtlbUFFbEoyZlNHdmJNREFaQ0JQOTBa?=
 =?utf-8?B?ZnZXcnBqQ1pSdFhUWHVVOGRmZmJXbng5emhOcE9JbVZIQ05PLzJ2MmFJaHNJ?=
 =?utf-8?B?elgxMlkyUUI1elhrYm83aUoxR3JmRElzVXZhTkp6VzRlRjYxU3hvWExiVk50?=
 =?utf-8?B?TS8xdXlJUmJaZUVldEIrdHNRSHo0aXROSXhvY2kremlCNGNPeXFieGJ3YlNB?=
 =?utf-8?Q?pqsyJH1jc4Z6j5lM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b06acf5-d758-452f-4a3b-08df23b1f719
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:57.2857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPf7WHvUMTmdYJIvIAN3kIQP+jJ5ARM5QYHtNVQmRqQ2iZlXwDpqGpknS1bywN0eGhGjBmPbhy4RSiYJG+5nGFU8dxkG9Wbl4MFqjJxzJJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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


