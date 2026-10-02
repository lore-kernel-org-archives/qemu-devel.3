Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F3CA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwn-0003D9-7E; Fri, 02 Oct 2026 09:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuU-0000v1-CF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:50 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuS-0007RG-NP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt+j5yYVdTOD14Leubn8Thed16ciqrnowtnL2L6NtzSGvTAEmcDG+qCMgUQLB8aqGpND/Teb5+iYN3g2bl5xmswRrlEVe4nywAoGvHPe0O36YhMrl43HSq8b1r47nA0QCchFwmsJsGuh+p0y1VKGI39hYtC5TS4Cp/vrGwmOU/uuW4lguRpZ3Imn3PDJ9O3RSHZXcAub8njYopPq7y+GtGMSMjKL4cKV8fSYBQuhoXbh5eHrbrP+tWcbxwyvJyRsP72/eHQ7z89epllHQG9tX6G0Ganz8653rh7ArKNpOYeT+51xUKzc0tCgSsg/To0q7KY3pHuERdFiw74ZSvatNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7pz+/dwZ2x/cB6u+akczuOQxtrm3QcNryzTw5waVXI=;
 b=TBaWApSWgMiVNwCau3lb03X4rRHYQPWhXdl5a3A6Kk5CC9WfPw3b/29hQUg9ZxhgNYAYfB7fwiPtrC0MoRZjcmYrxCYJXRC49DqqZ0CK/KJReaLbf3axT7kRyxN20LLFgZB7tn2VE9wb6cZ6eb0d2f9OF+Lh1HIwMd9W3Ix5c3EiFdHkZ/wC1VnWQzlO3OSVXAXn4k7k0B7JwLOY1M8Z6NfJQ4xLA825osGhSjsQK31qAhi2BvbvXruedusb119oStPC11HxPVQnORNWQcO+WUOGXvPOLPY/vwjsvZ90fq+X47lhElxWCyyx3taUJ1eqvPHRKh9gfsyR7gt94Cdc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7pz+/dwZ2x/cB6u+akczuOQxtrm3QcNryzTw5waVXI=;
 b=Ge7loNiAvc35nyKvpM4iYdnP1OJh3B15xa/x5Kv0zCTBY5qX7pZzg4w9uKO36b1qBwrNrJalv/SHa7PbFelTz3XKGLnTO+TqEBUNJQ2AtsxPK2BIJld86WUzuZOi0gO4Y2yW771ZmRBZ95pzV1AaioLcYvnb3rFf0NmK3xCxomMoyQGqY0m2OXwwvArohAOLl2TsGfNiLKaAXoxn0z0oKxFlBf7/ffMygnmRtvn/V/qt1Ia+DITBlKhuqvu9hSAMhzJllYDmFqrhx8fodIxZ1XJk4uLHskH+Crv/ZnRcBhIvYPOwFVUzbpW5BENZGpDbSnlLopChrkWoEeLe6rzFEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:24 +0300
Subject: [PATCH v11 15/19] vhost: release ownership in vhost_dev_cleanup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-15-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: e791aa75-de67-4beb-ebe0-08df20856b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xxkUfb03MJ/Ox82wCKzhJ3dfRPNuP1I07YSUjaakT6YWP5qSCnhdD/PWEY55d163mDmu+CGOVofvC0RILZH0yIZJ1lSuQ03qRTW1hYojEmb9kWBe8PsYJYOnxgcZRpDMJ4czQVUFLXeGQJTOZxbIP78CtMdqnOrcBi3lBXVjmNsw3+gvyXrBNZAdnSfWwsTt70oCmJ4uzNOHeeT+dK/+ipjI5iCDCNSqYKbVVruTt7mAUbUeUiabSAc+tKqPQvnM9xP9P1kxMEjf7YNZSAkp6UpZvgreRUOboM2x5b+axYFwJgTLb4QRCGlIK38r/ksrb1Tp96PMEZOI5uNc965Tn0YJfm3ObHTcBh8JkjvQOdxOZaX3qgHNVSibjevkc2a7Hkoavrj5OPqimMtoz5vKaZlfu5bdXOCbw2WdPMZ5kfRvwjCMeXx1Vkf9EHVJkj2ZjnfqYpnaXys9Esk4cP9j0BhjuW8SwVXm5H18RdDSmXZgPzQTMbcVwiC2M13j6vA6FbYNJtctdICg+QnEBhGnKoIQU5Tr5EEg1MrB8SOQ3ju3OZlg1gK6FRP6vayPwo5Ij6MkiQUwnRysEwI93JeFx9luDS09tphanedjptGAI6CIvwdKy7xOdwIdH1b2HabCD8BFHl8Hcn6mcoFKgPPW+3kVG1PVs/ckT4VlQ18iRjRnaRchOq3kb695rzo0nkZ1qKqyks17ICLByRm5S4Ux0WBPynPYdlgji2qzVdpINio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0dPUmJrV0FzSTRLN1FKN2IzLzI4MFp2a0VLZFhGZWFhOWY3UjE4WmdCR08r?=
 =?utf-8?B?NkxDMDNSNWJrMVZjRTR6eU5RcTVKS0tKamJGY2g1RUxVT28wRnJ2VUVpNmpP?=
 =?utf-8?B?QStvVFo2NkQxUVlkaHJZVUhzYXp0TjBhbjZDYnJzck1aNnlVRDFnL0NIMC95?=
 =?utf-8?B?dGdxNHl5TEcrUXhlWEs4VHZrVy85NnQ4TGt0c0JpNU9raVFaNXFPWUJIREw4?=
 =?utf-8?B?SUlNdDVjeWVsVm5xTTd5eDFTMDRpQThreC9abUx1MHlVSlJMMnJnNmgzdGZL?=
 =?utf-8?B?bnBwRDd3R2UyZnZBeEdMRVlhcDU5VWVLUmpwazlhanFtakdZSW5LbE5pYWVn?=
 =?utf-8?B?RE50czJvajBEd1p2MFk5aU40U1JuT3BjZGowOHZnQW53N2tSWWt4Q0RsSEZM?=
 =?utf-8?B?TDRpemxvb2M4S283VXpnYWdYdGpDcjdDQm50SU9LbkhnTWxVaElNWGlCZ3g2?=
 =?utf-8?B?Rld1K1BTSlkzTTk3NTFGTi83Y0dxZlFRSlBYN2tGOXMvdmVHTjJkK2preGgv?=
 =?utf-8?B?VjhnSDJadjVTOGJxSlhoMzFFYTQ2dnZ1WHJJbDNERWx1MlQ4cEVDQXUyUkNv?=
 =?utf-8?B?OERMdmY2U2dxaHd4czBWRHRFZUZkSFJERTZUZUhESXNYempVTlR0eWpmRGwx?=
 =?utf-8?B?cmsySGdMWWtHK2JPY2pLL0pqQ2FpV0pXOUZsamc4RThZdnB6UUh0U1BwU2tt?=
 =?utf-8?B?UHhQM1dPQmZKY242T3JQeXNNZlc5U0xtak1LOEJHMEhwVVVjVUJkTFNtY0tq?=
 =?utf-8?B?OUxXRXgvcW9LT1BoekxuRGtjREtUQ2N3WWtoMXpka2dhQ2Y1NkwrSk9jODRq?=
 =?utf-8?B?ZHVudSs4VXlRZjRvcE93bm9SQ3RLL0lqQW9obVdvQ1ZtY2RVQnRHcjNLRU92?=
 =?utf-8?B?Y1ZWK1h6bnZ6Z0t3WkpTRjlsVHE3bDIrUFFJNzBxbk9rS0QrTHg1RFhmMEJt?=
 =?utf-8?B?T2pOd0lvZ2EvQnFMNmhENVJVa1h0ZTRrTUJEMVZxcE9McGpMYzA4QjVyanFi?=
 =?utf-8?B?MWxwWkEwcDNvU1JURlVGWDZQNmVuQ0xkTks4dDcybXlwVXp4RzRHNHJ4RCtv?=
 =?utf-8?B?MGR4OEdaSklTZUdIeU1HNlJoc2pqWG5SaUZmcW9RWjRydUVmd3JqVkR3S3M4?=
 =?utf-8?B?Rnk5Y3U0OXk3UzM2RWkveis5OFBucngzMWQ4QzZZRGtMZmk5Ry9KNXRGTkZC?=
 =?utf-8?B?Y0NqdHdSNTQxWkFEL0kvUlRYSU0wMnZ3Tm52bnl5Sy9aVEZVTGtrSXByUEox?=
 =?utf-8?B?M0VndUxYcnNrUVlaNmhMR1JXRE5JTTlxOVVmdHpEaVgzVXhaVjJ2QzJoM2g4?=
 =?utf-8?B?ZHpmVkNnN1FWNy9MR0RrM01nSmVXQzFFUk0xVDBrWm1VdjNsMjNKTnZZQWcv?=
 =?utf-8?B?T1dpaUw3RG1hbTdDVWE1VExPSThzcG5kRUh3VFdxNFVFSHNzWGxvK0VyWVJy?=
 =?utf-8?B?MXZUNGRhc0dFTE5ONGxHSTZsUjNicjJITHo2RUpRWGNyRGNqdThPUmc1TTUx?=
 =?utf-8?B?ZFlueTJNQUZIcy9IUWZHWEZMNEpEUnRFSTZ0aHlMdTFFcE80Z0lmV3dwRkdW?=
 =?utf-8?B?TFBCOU1kWFZnTGhWOW9RVVNJLzQyWk5mNXVMY3JjVmx2NC9EUUpoc3hBZGM5?=
 =?utf-8?B?K29pTzJrWUFqa21oMmUyY3NtT2JSWmp2UmFWKy9GdUNDdGF3cXBHV1JvSjg4?=
 =?utf-8?B?MmgvVlcySkdYdUFkWFBuSDRkWWlocmR0RzdyaFJieDlRVnJuVkJKYS94WEc3?=
 =?utf-8?B?MVhINkpRQXVLYWxyTlNzRnBmcjRyd3E3ZXo1UUwrWERzVnFsNzJqY2hkOFJp?=
 =?utf-8?B?MXRGQ2RNb1lBUjVURlc4L0EyTUg1ZEhOYUc2U2NtSVl4eWFIbk9QSWlNc2lC?=
 =?utf-8?B?ZXZwMVZsdVBGWkE0YVc2bU1wQW50M3JxdU55K3hqaFVYVnlXc1ZIRW1peHpK?=
 =?utf-8?B?c0pGc3V4ZEQ4c1ZzWkxENXlINW9tcGNHYi9JdjF5VlJuRFRLbVhhNDFUYVZC?=
 =?utf-8?B?dGNMU1dNZTE3SDRIZTdEKzJhakVYQ2FxU0h3N0lGTEVEbUNnWmJXN0kvaXlr?=
 =?utf-8?B?eWV6SjJRM1hTc2E3UlBSajJ5V3dvRGV0QTJTOGlLbytWY1ZhV3lvdGZGc0oy?=
 =?utf-8?B?N3ZDSnZ2NWNqT0NSVVFPek1sdy9NcndUV212cWpQUlVKZFBGd1cxK0JxTTJz?=
 =?utf-8?B?eGw3YTRkNmdUT2pXNkIxMjNEcjJhNHZza2d4ZG85dlhBd0JQNFJqOFRmMGF5?=
 =?utf-8?B?aVRQZHZ5clpBcUNpWmhpUHhpeGo0czk1bzRLeXJKUlZ2L2pkazNtRm5aK2Ja?=
 =?utf-8?B?QWZZM1NjWEhpaXdibVVRT091L0p5by9vVFI1ZjVtNFdMTzBNSEJNalRHOEJZ?=
 =?utf-8?Q?QABimNuYF3Mi6ug4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e791aa75-de67-4beb-ebe0-08df20856b24
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:31.1521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGQR0Yqdy0zJ/Qf79VfaNxoQYtfIJ97lyYNSgcjt/njMKbToKEF2i1dee+9hh1scSaQZyRz6FfTNDq/yN+IuJg/D+DBwNj8anaooz85yjJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Track the ownership with a new 'owner' flag in struct vhost_dev, set and
cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
teardown for all those paths.  That should be safe in any case: the kernel
refuses it from a non-owner, and an owner is about to close the FD anyway.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 23 +++++++++++++++++++++--
 include/hw/virtio/vhost.h |  5 +++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..1241c5a954d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1705,20 +1705,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
 
 int vhost_dev_set_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_set_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_set_owner(hdev);
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (!r) {
+        hdev->owner = true;
+    }
+    return r;
 }
 
 int vhost_dev_reset_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_reset_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_reset_owner(hdev);
+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
+    if (!r) {
+        hdev->owner = false;
+    }
+    return r;
 }
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -1864,6 +1876,13 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Release the device ownership if we hold it.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         */
+        if (hdev->owner) {
+            vhost_dev_reset_owner(hdev);
+        }
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 73ea130d7ee..f6e32b59ab2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,11 @@ struct vhost_dev {
     bool started;
     /* @initialized: has the full vhost_dev_init() completed? */
     bool initialized;
+    /*
+     * @owner: has this vhost_dev acquired the device ownership?
+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
+     */
+    bool owner;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


