Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D940DCA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJj-0000lG-UX; Wed, 30 Sep 2026 06:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJi-0000kT-Di
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:38 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJg-00045T-Ro
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOblEO543CHQQ2DUBzfPdJNrZ2ZHbwuqc4CGDTmSwVnNkoZZLx7yuUefs0XW0oi2TfFbtnXXDh8jq7ttX6phjIuw+lTUc7N8i2P2i/nSyAac8xtiPkXCujx9k/jLsaof1ubU9AzO959/oQpIH3cjd7CFfksYMsmJo8rsqKEIYzUkG5rnI3g2AHgHm4tG8L9GN5IeJKgYv2NzMlk2PqfDzPfiKCblTGJEBNBaOnLFuMXl2v+6C5Uqh89t3IF1GlW4DxpOtr9mz+VLyo5S7vn+QVDyBA+d7AblGQyJ5+3rvtNAo0CrIDMUg4+tiS6ubRIaTo6Sxm5hEaxxiyotKKAMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8K1V3ZSyYVxoeRrKNs2ISWy1M0QNoeCprxXVX7boCg=;
 b=SaUd+CkJx28vfKA7oTjqsVzYRjR47rpbep74wdWxaMulP8G4fJJzUsLW6MC4XGlHFhq7m+0r8MyrBxwDXaqhHFXAY33PTntT1AVBrJctMvw/jNR2Sx2EceO+hrStWcogWM6GK04/LHbKviRc4qYX/CEqhX2pB5LPJEAAnflt+hblqAofckkHmIRIjV4sDFjqwdONES8MK4ThnjYQPS0CL5ab2W5fZmsCB9KcSWDibsViKbPaGD+3G8rCT9Ugw8OhNyhJwtA46lVtK8lLCRm6BAorEZ4KORz62+mYWLbWLlIiIBeVy96znCS771dxhBmtQhnHecQxWoKEsBNTRqt6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8K1V3ZSyYVxoeRrKNs2ISWy1M0QNoeCprxXVX7boCg=;
 b=jubOGnC+WLWgelNL4HQUI3+9Zu5sxt2NL+ofN0YifqLHZ/LT4Z/CH+vmCNRnVF4jrpLEoQhC80SiEqvhSMgtTMn5tgUWXB6lPzZvtRNrDmVj+uynV636ljm3e+E/pBn2vw1Dhluu4/OV97gwc8oENZoJqwnP8PMLOL0hnp27vGa638HsnVLIgSoccudqEidXUJZJaM/jYEA68GPmR+ZurudKM0G40wXShLsMwPFJfQsmAAWQUYIiH1B6F0yrYIm2YMqhF8RjtSt6sf1FM+zKEDe+UFLoxA1vyUCAUV1XvkSjrR+bCahXCiiPUt5tHqFLKRxn/brtxwCWdwy4C8g3Og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:14 +0300
Subject: [PATCH v9 15/18] vhost: release ownership if vhost_dev_init()
 fails after SET_OWNER
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-15-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: ed94b293-80e0-4f49-9ba0-08df1edb778c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: ar/CdUiVcMB2x9t0EjI18LD1i88MVkoxP2FMNLENd3bek0py0Gh+0mmCW2IvSpohP9BSySK0Jp0urDkPKEAkZnoIf4y3fHwq9Uz/tVSuFix0C/Yf+8cOjw6DeRgg8pDOOUsP8BGjmHbO1qYOzVlENYmW6e/QoWlRHX3FXdAp0cZ85PE57fvzNeKq85mjKlMa0IxCIu4Q3HuAaqJgnJqpCs43by94NlX+LdAyHeg8tfMSrxC5Ht1/79hxeUXcbo5FiA5ZsvceRdmuEisSbiKZP3noIE3KFeOmAm9YzrAyl93arMxeSaWdzNW4gpTmaYGC5D1h/Opbb18N+iIBvhzw/FD4bwdWG6OxUHWN1unD6rq88XA2wSbKPl5lvOtG47o5b497bwj8xbYZG38lVwC+CKfGHzD9l8fj8/l+gCf8giDRAtsMXASO+GDLYfLFb5cz5vJbaXK97gILLwz5+ETiJwlQS4yyalJD7OFvXFv3DO8H9fZIkPMCyCf2CimcZy+vt+nj83VaHcHb0wj8ZnKSmAgga/Cj7aj2RcnxWXpOZ2wliNQPn+/x6csb7ynNHBTY+NWpL1GwXnz2/us8XENKK+r8cRpPXEh3enXY62swYIFi84+IBE57/b8lz58hro27Znd2Wvh6++Ic4MNJOrhPc0y4QohTqhZhdgpHFV9ITqFpEGorx+PwNlmD8gF7nPvV6plUHio45yUE7lTm8VsE+zsoJWlKqcGaY7PUMNyvJ34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1QTzhTeGJTZk0wbjNIa1NWM05nVU5ZQmpETnFNRnBDUmxPdGFMTzZCNnoy?=
 =?utf-8?B?TUNYaGJpcVZ0SjNhYngrNEVqaUhUem1ZU29qQ2RpN0RvRXZydFpGZ3hKU25G?=
 =?utf-8?B?WWFGLzRia0NrME1oQlVGcXlDUjJDRFN0U0U1c0hWZndPS1BvTzhJL3kvblo3?=
 =?utf-8?B?QWZEQTQwTUt2QVFFY3pRZFhIaTdaNUxCa1RiVE1mMFJ5OEkrazVPZkhNNU1E?=
 =?utf-8?B?U0JYUSs2ckwxMHRyck13dmQ3bVJ0OXRnZnFOZlBGdXRMd1plL0t2MXlkVWoz?=
 =?utf-8?B?NlFhbHVWWDdkb1MzVUJlc3ZWRUloK1RlL3JCVWlxU3RodEl0WG40N0IvTUR2?=
 =?utf-8?B?Q0pWOG1GVkNRTWlIZTQ3Q2VSY2FDK0dMYUhFb2EyRlJYUFEyc0NZRTR6QStj?=
 =?utf-8?B?WUh2OVlMQ0poVUMwYi92UzQwaFdNU1dwUzRZRkJPcnI5MmZJQmF6SlpCSmIr?=
 =?utf-8?B?Rit5b1hPbERab05keGZuOVdmbWhBMFdGRWZVL0U5M2JsN2EzZi9uY2F4b0VO?=
 =?utf-8?B?V3h6dmNQekVXd1lTZjFGMUFHSEE4eVpPM1Z5SmxlM0oxakZ5UFRSaUU2VGU2?=
 =?utf-8?B?ditTdXNYOVNuOVFSc0JIaWowQ0toWGtkclZaR0hXSU96ZWpmWkxjR1RqUHRz?=
 =?utf-8?B?UGVCa1c4UGpyUWxlMmpQM1dmeGkxVWpjN29qajJnZHovcTNrenlOb0NvL2xp?=
 =?utf-8?B?NlVLSFMrL3Rjcmt2UFZmellkMTZpVWFEa3plRzdoYVZ3NG1HdlpjR1g0bkVZ?=
 =?utf-8?B?aEM5R01hT2lVbG9iMDJCWDBxTUtVWVQxUlR3RlRXdnFGS3BrWWtKYVI4NGhM?=
 =?utf-8?B?NHdmYzZFMFNtcjNyNmNGUUlzR0FSQ0pHSWpvb0x1Y3pHZVJnZE1zS05YTVpn?=
 =?utf-8?B?RDRjSGtsWUczQ1F6QzZZVlJEQ2hVYmJnZW5ncWlDT3NEWW1JYWZNOWxBc1Yx?=
 =?utf-8?B?L1BQczVXKzZjckhZZ2ZHeGRzVmtMU2llYWFpVVhuUmhteEpNaFY5ZkU5U1M2?=
 =?utf-8?B?Y1JOOTIyaEdGWkhvT2xIaUMyRU9QclVxaEVqcHVzdFk0cmVDd29rUmZWWG5J?=
 =?utf-8?B?WHZYa3Z2Q0JDR3pKY2pPQkJIYmErUDE0Z25pS3pYeU9IdFAvWFRJNDVkYXdQ?=
 =?utf-8?B?YVFkZlV3ZGFCWklzTHZMNmt1TXdNR2ltVWhNMU53empneWU1SkFmTmVIOThu?=
 =?utf-8?B?VFNoQ1UvTnd5TFprNTdOK2x1OGZaZDIzbWptekV5Ujdtcnl6QTZveTVnQkFH?=
 =?utf-8?B?UEFzTEtBeHJnck41UTBpSkNTS1pzdVJ2QmEzczFUN053SXJSNWh2WWFneS9V?=
 =?utf-8?B?VENxMmRFNHFkMnVwQTRqRjA4bDFwRTZNUitmNGFhT1M5VnJ1UjhGZFRtR3M1?=
 =?utf-8?B?Y3RRK0xZRFo3UHdSWEdUVUxDd2EwdTA1VHVjdHNUcmJyOERrRFpaSkFjUGMv?=
 =?utf-8?B?ei84a3F5dEZkdWRSdzdsRWdrMFVPOUx5NktHcFZ1M2xYbEV4VG5xV1RMWk5F?=
 =?utf-8?B?NWxsUzhhTGZhVHEybTRBaHZxWEV5VFFZbFJJaVlBdGd1dWs4UGtPM1NPWjRX?=
 =?utf-8?B?dDJteWh5WmJvUlBiNmxZbDkyZHFtMjF4dEVTZ0pocUVnYk5SWlh1aG9zRkhN?=
 =?utf-8?B?UUNyNlFoVi9zcmNMMFJRbzZDejJneWJISCtqdkRrVkxSRlQ4S2hDeE5qOVBy?=
 =?utf-8?B?dlpVSVpSSEdwek15by9HaVBQMzR2NWxvNHVKNkdYd2ZnYnBBcDVSQkN6NzdH?=
 =?utf-8?B?M1lkdXBkMEZNYjBldnNmY2JHNy9MLzZoYzlyK1I2Z0hqQytwMWF1ZGdKS2g1?=
 =?utf-8?B?ZlJ5Lzc0ZnduVnEvNjk5VzFnNU16WVZia2QyTit5SmQxek9SSWpPc2hqb0Fo?=
 =?utf-8?B?Z1BYZWJtNGN4OUwyWjg5Rk9YUVdxV3NoVE5FdXYxZWFUdFNVdmdrR1ZlUS9H?=
 =?utf-8?B?V0VOWjdob1hFMXlrSmp1QWF4VXJiRXgzYkMyV1ZFYW81bG1JTEdGUitmLzBo?=
 =?utf-8?B?T1lOdWYyZGIzei9XZ1EyYXovcDJ5VnZQbnlCWThMR25sQkR3WW5uTThlNGdv?=
 =?utf-8?B?V3duSWFjQVBqUVVRaTlyUVpTOEQ4djUxS0J3bnRSbUh6cEo2MjhycmFESjNS?=
 =?utf-8?B?cTdIcTYzL3BSajdLZ3JhRmZwbndRZ1RiYjBSNWRZdDBQYnExMk5QNnJSMUps?=
 =?utf-8?B?SEZoUVZSUzBoOVptSk1XL2tXdGpjbjlkS0x6SUtpSmpQQzNWQ0JmVThpRlBK?=
 =?utf-8?B?NEtpLzN1SkE1QytsZ01neGYyaWU2ZVBDSXlUbmNmRUk2aE5XbmhCZWw3cjhD?=
 =?utf-8?B?bzdld0VKMFI5NVlLTHM5R0JRdTl6NDlidDk4UDh0UUlZdzhPOWtiRlFSRlRW?=
 =?utf-8?Q?Cr3IgEfHCFgN0AWA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed94b293-80e0-4f49-9ba0-08df1edb778c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:26.3547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l20koeZJfm+SbhCA2WQJgZ7soTtJEbhoEbf+aWj/JV5TM1UCLdvUWgIW4oT5Qt5FXpTFssbGMaKprG0j9e6yg9ZQaq1dVhjRuCKnvQ0y/n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

vhost_dev_init() takes the device ownership with VHOST_SET_OWNER and
then may still fail, e.g. on virtqueue init.  Its cleanup only closes
the backend fd, which doesn't release the ownership if the same file
is open elsewhere.  That's the case on a CPR target: the source keeps
the fd, and once it's resumed after the failed migration it can't take
the device back, SET_OWNER fails with EBUSY.

Release the ownership explicitly on the failure paths past SET_OWNER.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..3ff54879068 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1754,7 +1754,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         error_append_hint(errp, "Try plugging this vhost backend before"
             " plugging such memory devices.\n");
         r = -EINVAL;
-        goto fail;
+        goto fail_owner;
     }
 
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
@@ -1762,7 +1762,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                                  busyloop_timeout);
         if (r < 0) {
             error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
-            goto fail;
+            goto fail_owner;
         }
     }
 
@@ -1799,7 +1799,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     if (hdev->migration_blocker != NULL) {
         r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
         if (r < 0) {
-            goto fail;
+            goto fail_owner;
         }
     }
 
@@ -1831,7 +1831,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    " than current number of used (%d) and reserved (%d)"
                    " memory slots for memory devices.", limit, used, reserved);
         r = -EINVAL;
-        goto fail;
+        goto fail_owner;
     }
 
     hdev->initialized = true;
@@ -1840,6 +1840,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
     return 0;
 
+fail_owner:
+    vhost_dev_reset_owner(hdev);
 fail:
     hdev->nvqs = n_initialized_vqs;
     vhost_dev_cleanup(hdev);

-- 
2.47.1


