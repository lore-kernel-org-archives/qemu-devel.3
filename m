Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A67C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FT-0004Pe-HC; Mon, 14 Sep 2026 04:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FQ-0004M9-T1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:08 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FO-0005PZ-1x
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waDjIZ6YPu2Dd7A9QdtuDEJ8DBE+3Ete9qQVtcoxlTi70r2XSR7BKSq0i/3L97H8dJ+4uUYT83hjUqDA4Be9ECeHAunZloqx92wAy7p6anwrA+R0yvAG5ugE1p8ZECOIw0LhTrnQ/6+cb8Y5ArHfcPWMAh71e+8LB8bQcz11y8ndyZmDKgZMp187pu3RcmgeGhIDMfZm/35060pji1F04JKaR0uhCEDcXY5SpGaS3R4lb4i8U41GP1wjEpP2G3q5v/eXaysqEZ64sn8vJi1QURcOhh5XJ3e5ZkJkS3tSTds5LXmAtezwFpXyXanMNaGP2g5VmX/Uoc8yRuqrfd6qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLdfSSIjrjJ+y2ikvZT77FqSu+X8MFe2FtIwlmjzl4A=;
 b=uyRvhnlb3LNV7ISFF1a8n7m+unXFIVRZlRpvhtW/Mk+72bOQTHCh6AaHc3e53nhMF5fx23AIP4+BP/fgyfGm+K+/9J56zLEtfO36PsmYsyssj7VLXhyTOmw3weqbpytTg+gxq0QuEN5T4zfEJUU8wEq0qTYJO9tIuAzvQSY+YOtYCpZEXpt8CiF9Q53WNTmVOizYP3abGiQnWbgciTvoNHOqbOQypafa3HK954KHXsX+d+z/4xcHVY1FfKS6mg02Tyd8QkEBB8whneqOHJAvqPq4YtV+sa8+cOxZ6MKv+Rhx2H8nigU4auLjaykoA9eJpO3Ay8jETSAqckJnsMw3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLdfSSIjrjJ+y2ikvZT77FqSu+X8MFe2FtIwlmjzl4A=;
 b=FvhgL+9jQx8aqqjYWiXb9D0gjMkF5VQ/98O2UA5T9Bywox61Z0FHZQL8amBBDvi7W+F7TGCYZca/V4tQr/BHmLwQuRrpqJ+78c5Vv2aXUFHp6PIuNh5rhqTuQz3UrKkbQJhHAD7MSiTsfr0KTZaTuwY4/EullaGgDCv+yKlDcM/q0MwIsTuyCmEgnRRYfIXbXKtxoqB0E7cc5UDxvBFOGXIsvoQ68z/YE8BObEBbKSFFjNBanlZMY5EDb7XFfZaDP+x4bQMWpHYpFAJD8cmOB1SDxh/OkVmZfLpNDKv1eY8vWDbKZ4yoUHeJKIcGzwV685dKsRb7EVjwsqhpeSNn0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:29 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:41 +0300
Subject: [PATCH v5 10/14] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-10-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce92157-4cf1-4210-878b-08df123bd2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: ysC4kDEK2D+5Ifrq5vf4dude0YGKjkQZ3oC8gzHhPfFz1wegZVTamNhJC6eMk3B5k11dwHbyNVzX5w/f4T1B4jMnD8JdwrukKd9s5I7o5MnXnGo+SRN49puUIG4ZGbYIVp95gEKQVkOcaatN0hndkBFsSkw8rbtdzLLemrBNCk50rqkfH87u9pXcINxfA0hHqbnOEU2Db+TJBE52rSAfhGBB+TGenTE85Pls1he01uojFSBXc4SQMJhFr2CoGpDYz2kYy6rwHgh6yK5pxq6YgosVSkJOVAWLwljaqgDXSabqLftioU5+8gBoJSf+jnuzGGzBfRK5jmGn0gDygow63NhFtrQYhwm+tONCoMtP+xSbQ9PQK0uDpy9kC7FD9qf/n1J3KQTtMxssg47djdrzW268m+Y2Gk7KOz4309MFPhfQDb7sfddP0RQM33Fq4QjPBic69Wvl44yv6Nr9HFxQSI99ee/AZfZ+JMFOvrfiAry5B85dNDmUnjNfpkdtnVzgnGzq9iTCga/euu8jFVA0vNT2x/4Z8MUKJ9hE57yfgiOR2cPTRmOQFqY1eBiPK3SXqODozK5xyY+xL5VcJv/t1ObOAS9xkUDjidZ4gYraTLxpxx5FCsOCu7YISe5kcvkhQFrWgwqFwU/XoHPx7gFtoyovdfO9HtgH708eQxlymGYCPyTFaAj2L0/KcoPPiah6R87g3GaYE0GjaHYG/i0antBMhGmzZAmoftrTQfKFuOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRHNUZEUTJUa1FIK3FuNU5WUUhSVGJEMkNXdG56VEVsZWc3L2I1dkNRMDBM?=
 =?utf-8?B?c1VqcDVYeXhpS2JvaVdlSldzRHc2aVlrTGEwSE9odHcvRFUxNjlzNWtGcjFm?=
 =?utf-8?B?VnltTXhuZGZOY084NnYzVHJwVUxTelM3QmYzaDBydTlBbCttMEllVU4yb29Z?=
 =?utf-8?B?cjd2TlFGS05tS1FYSmVWUVFnb3dvb2RkemxnSmxnYVdWb1p3ZXR5VVRWZXUw?=
 =?utf-8?B?azR1TjZMS2JFZ0t2U0NCZXlvcHFnRERuK3FWc2hYNnVtS3YwWUc3MlRRQWFm?=
 =?utf-8?B?YVVRYnh3cjdQTGc0QVFHRWQ1OWpFRStyZk04MVpNV0ExS2h6TjJpWmtzU2NF?=
 =?utf-8?B?QXBrQUxLVk9PV1J1QzJMVlc4UlNrNUlaNXFXRzM3NnF2SlV2eUZaTU8yNGZB?=
 =?utf-8?B?bjdGbG1nZm5IUUVRemJpNUl4a2hYbUlJeFEranhZODdzbEUvRVg2Rk03V2x4?=
 =?utf-8?B?SmpaQzlYWFlCZGRvenBFb0J3N1hIZEZrMzV1MzBOb3RWVXRxQzFaSkFQeEtp?=
 =?utf-8?B?aSt2R3FmbUpTclNQTTkyVXBKUFU5WjFUNUVyd3prYnhIRTV3WGw0eTNNZC9t?=
 =?utf-8?B?dXl2UHhwSmt6aUVEM21CbDFUaS9HMmFNdm1zT0tBQ3ZheU55RVZHMk1uZVNp?=
 =?utf-8?B?dUkyWHY5MTlINEQvMW5KbmtSMmZFRkdkSE5PS0t0Y0Jva1M1clNJcVhSby9S?=
 =?utf-8?B?Z3RiY0NJWEV0ZlpjVDI1NHRlTjJOSlFrdnlkY3lCS3VZNEpMcGlDM0RteHRj?=
 =?utf-8?B?SDhhMyt5dDEweFlRejdLQUZjZ0JBbFZ6WUNXdm1Rb21FaG1odUNFdDVFak9N?=
 =?utf-8?B?S0pUaW1ad3lBKzNVbGIrRk40TUh5bVdWUTVnT2Qxd1hkdWt4YUNmRDMwTkRF?=
 =?utf-8?B?T09ncE0zd21FYW10M0lyUXVHVy83RCtEU1RoR3dlWFp4bkFuR04zYlQvd1Nh?=
 =?utf-8?B?cnNsbWgrblZiWm9HSkJHVk1mbGltK29sa3VGZERhVkZzcVlKT3QvQURQZlVE?=
 =?utf-8?B?UUNWYzlaNlduc1N6ak9ZUDdIU3hGZ1JTNGtmYnl2Q1lGWlp3RWkvcTBoZGFU?=
 =?utf-8?B?RUNWYXFpZkNRVzNCSnd5aHNXenFxU0VtN083bnZ4c0xZL2lJRGswL3BTZ3Rj?=
 =?utf-8?B?bThqNHRTVkJMTlNvWVpuSGNTRlA2ZmgxZnE4a1RrdzQvelZTYkwzUndubUJi?=
 =?utf-8?B?aXdGdnVDclo3Nmg3TmZqNjVOa2hzYkhDQkRwRndsQnlZa0NSVnJVVHp1Tk9P?=
 =?utf-8?B?aWcxdEV4Z3loT2xmWkc3NHhTZGVYa0VBaUVLbDd0UU5DelVnOXBkYW54OG41?=
 =?utf-8?B?alc5SWo4eXMvWXdjR3J1em1RcUpreW1CcmFuSWZTNHIzVkJ5VDJ4UTl4WGIz?=
 =?utf-8?B?UExtMUhwTnRIM3praUtudTlPRXVhZkRzT0Z5c2owVURHMTVlZ2svQTd4dWhw?=
 =?utf-8?B?N2FUcCsyTWFJSFpSQzdyMjM2WmRrSFE2MEQxdXBJOHhHM0s2MVBYNm1DSCtk?=
 =?utf-8?B?Yi8xK01seCt0WW9rek9kWUIrNThlMXdxNnhjZnVRenppaTJnLzdPeUxuNXFI?=
 =?utf-8?B?K3hnNE0xY3Z1UG1CbGJlKzlxdVVBYXREN0Z6dzAvZFE4dHBVckJZaStuWllL?=
 =?utf-8?B?UkttNjBIL1ZoanlOWFN1Zm1kMDYrMWRQYUVCbXV5TXBzUSthMzhwWVNnZTFI?=
 =?utf-8?B?VWMyT0FwSklOalEybnpVT0pGQ2I2c00wc0JGRDZnK2xMdGRuMHUvVkZmcldN?=
 =?utf-8?B?WHN3UXdBNE9FbkVBMFR4MmFQV0pGdzZTSFp2bnNlQS9iYWFHTzRLeVhBVjRx?=
 =?utf-8?B?a054anN1bjJGbGtjTkxkS1BPaFcxaTVhQXp0Um1GWGJnNHA2ZWhHUTBIMklp?=
 =?utf-8?B?UW1lMDVQN29HWGN0YWkxeXR6a202a3NaNmkvWEtBSS91Y09jSlVsVVdZQVVa?=
 =?utf-8?B?UytCR2NSQUhFK0ZkRjhOMnZlckJmV1QzdDdrYWI2TkJPRnpsL0tUT3dWL25w?=
 =?utf-8?B?cGRCR3ZCVXNoa2hlS3ZxOVlkK2RnRHlwSDArTFFZdkd6MUtjVlU2TW1NSjhU?=
 =?utf-8?B?VzY2Z0FxMmJYZ1hEU3kvVXBUaVlpRkFmWUE0a3FKbW11VnVnZ0NYK3MxcnhG?=
 =?utf-8?B?bCtmV2NkbDZNS0sxc3N6Y0Rpd0xKc1dIVzQvN1E5QXNHQW5NVFRobG16MW1l?=
 =?utf-8?B?L2E5TlhpZkR6bTJ2MDJYdGFBdllKTXNNTVgvMVVXSW1JZ3RBcVpLMmpnTUM4?=
 =?utf-8?B?bmV6TndxSkpaYjhnbDJ3NmtMMFI0UG9HeUpOVHk4SEZWMjdTQlhpVS92bE0r?=
 =?utf-8?B?TDVselVpZ2RiZHlyaFMwYUVGYXQrTjdvM25OeWQvei9VQVFGZ1NmaWhvUER0?=
 =?utf-8?Q?9VmLP8GrwP+Jkz2w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce92157-4cf1-4210-878b-08df123bd2e6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:26.1581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqUG4PX7LOKrkuPeGhRp2f7EZ/I6Td6B/VmNTo9pC78CjbZUrX5S3GAE1CKWCHifFFLWtSlXLz6IMy46TirMoD1lZ1WZXlgWi4H7Ghcnwhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
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
index 371dca17dd8..f9b54c46f93 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1668,6 +1668,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
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
@@ -1680,10 +1702,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
@@ -1694,12 +1713,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
index 684bafcaadd..9b98d34dd04 100644
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


