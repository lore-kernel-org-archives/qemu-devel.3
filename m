Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36757C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aH6-0001Us-Tx; Tue, 15 Sep 2026 17:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGw-0001QQ-PR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:58 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGl-00010d-2j
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGWiZvZxrIupqN6aqM12x+54rwggfJw+nknM5RxPc20g6Hnfzg4/ogP2ccZhI+BaGU7xldYY3yySdnuDfrK88rHjS1d3mjxgcEN27hKjBTy5uWvCLwJNyK1qojpWGO0tVqNjrLkVEZp3sOKjiY5mt2E5IfvOtl+E9ntOGPokM19mIxvhGQDyGBenCayOicsINeol2qmWfRTwXg+WoqU/kyLMaKMU06o59uquH6c6tPieZtIdfvkJrdwa+/8RB33ffs/rwtHXy8yk6sE2kfHxOyaCn+5T+MYQBroa7FzGP6VHHBSCCfW8JMy389acCuzoGeKzjz5GXeJDfct/xnloLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=plj/Wjg9nCZyBRyreITY3BzzHcKggDBbMUQadjXQ8NvWrE5hsgFxzG1JCh8F9ajwNwuB7PqpeERGvFAqJBOkwTKl1b/3yO68mQ0LBcUSdG83EhyhXwWiUAybLB/TV+LQ6Jsq/0GBB10IwzNhVMH+o2cWHxdxMlZOh/b9ENlsll/zBhp3ZhhchUKwW4J4eWiGY03RNODCaSlGM+LIZjtB9g+UcHe4y6HnB4M9pgGkecOjs0K3v/3Vdm2APhy6qCB5CwBbcDjJmAbrmtYzMiGdZY3Q3GzuQ2SO+/N2iauru5KoExqpb23dNOH8wWbE8ew4z/HSCPdcLrKZHE3boOZK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=v275bmdtPKCwpOgCFfl0pp0yU1+Yi8AdhlwvfE+xtRML3dQuxGA671sbJdDonRIRjSpuP5qAYHO2KgPJLSPS5KxVnAMdNdxx0Xqn42Rnz3D18S8LqJggQsktVTk8DUo5VWGfCFWivAYPy6RaaQ6kyT98wbn6PAFWkXUoeRpYI1OxJIQeiJRoPVzT6Ar2g95PxjknFx0QeZMPUfvkXVOUVXXCXV4RrY6y54x5Iecd8lY1Lm/CGddt/F/nkLBYLJR2seeJtmBMpJKtnh13ND8RwY5LNRU4edFLOonOS6GqAzqa7YzCHzwSuLxvtJia3SVYshPRzjZ8Hs8ZurFtV75H2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:36 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:36 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:46 +0300
Subject: [PATCH v6 10/14] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-10-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1301ac34-9755-47bc-29ea-08df136c63b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: nGbWmaABz3n4xIE6i+cRYv7RBNpItf9Zk2O/IHqmRgbuZ12K6oObN0xUQKH8LnMXCluEfNlasBTOMGy01+JyvGLNWsdNcpSZuMDrPHGD7ScW+Ra/Q3T/bgmZgbNe9qEp9sSyuLMdCWQh5iiygfuLbQCcIaiRoc8zh6csW7i1fPa/JHhrRj2YchGoU867qg2PipGdRgdI6os5tyI0LVCLagCYsixtGsjYPfHM3U1BCGJmeyOX+l3Iv0/1A9Rl3CD0xWfF7IvkvxAkG8cJWss7QiXIlKMvGeSNvkXWbXQFGiaippxSFv5xXL9d/cEFEXx/0eGFciFFzAZAbXwn25T56aO5y9bQuT0/JnrMKZTyEtTfs/Culd6xtalzYsjLyO0W2bXAHHJTme4+jZuD+HdQ7nUKXyZ/0Kk3D+eAXIkIw4zVnvAN7JZfNgK/fTs2e44DzBlFtLV6mnOcU/MYJIyvpfvAF7ZVriVeQrutOkdHo39+b1NsjFa2HeDIHN3TXfuoJlQnAvai53e4PQ0N6XaEzh2fdNLplOuWVaxkqkacWPU4Vs2+FlP+hJL18pZ8Z4WG0ujWPYnoOL8Tu870gvOJWyYS7BNyiKNUzxPxRstaaCuPmciB7cU7+BcrUM8XurjO1Z4QbZqyU341hd/nvvuZUWu7ZTNNrHjbGglfZb/YxkNcK6CEu5Lcq6wmDns3SufY4aXlvv6tEOamrULlJD60LOClVd/x9Vi9zT+1wxzYwsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZIRUI3bnBkZnd0OTRVTnFwZDRjR3EwbElTQ1U3cFZWZ09SUUdsalFSbWRZ?=
 =?utf-8?B?d1grM3NWT09iRDBUb2dQbWZCWlFJaE5TNUVVdmtEOVRxSUY1MGdSdlJYMkI4?=
 =?utf-8?B?WURwR1hSL2I5WEpWU2l5VS80b3hyUzVHU3lmY3FYQVRLOE9wenRjM2NuZTVi?=
 =?utf-8?B?NlpieEdFMXNTd0hqLytHOGM2dUhlRXhpZ1VXditEQitYamZCK00yOFgxRXQx?=
 =?utf-8?B?d2drTDdqYUJlNVY0a3dWdkNhd1dDUkowZXRGUHUwTVRhU0w3NlVxOEVYNXVN?=
 =?utf-8?B?UU9Tb0hTRjN5M0FOYVN0N1pHTjErRGdVRnJBdWtkYmhlZmM5cHlmZWtqc1RK?=
 =?utf-8?B?dnB5aXk4R0VJTzJlUW9iVmNjWC9IRUduQ0JMU0hoWU1NMUFLWFVFaldxVkVK?=
 =?utf-8?B?QkIvd2gxMkU0T0EvOHV1T2xWSnBlYklLVHkzYmgwYWdIbWgvZDRybHdoMlVN?=
 =?utf-8?B?VlFXbzViTTRxOHlBK2pWQ1Y3OXdONThyRDYwakRyTlFIcTNkZUR2dTdkM0JI?=
 =?utf-8?B?cmozL2UyaVNGSFlTQXl1aGgrcTg1MXRLbFUvbVJsNURrRkE1VjF5L1lrcmVZ?=
 =?utf-8?B?OG5vZUpTNHBac3ZNdHNWbmliVURCTzZtaFQrZUUvOXM3aVJFcXFCTFVhY1pU?=
 =?utf-8?B?VjRnY3FrYnNjY2dBNXg3VE9qRUZoVGRoVUpscVR2ZlFiM1AzUEFybnY5akYx?=
 =?utf-8?B?SGVQR0N6K2ZtU0oyakhHVzZoYTNIQ3MzVW1SRHlCNjlvL2pDSFZPZmc0ZW9o?=
 =?utf-8?B?c3Z2YzNSOGRjNGtvcG5ZNTVXYWhKVG9hS0VEcTZKTkdiM3NlTUZCMmJVVGpt?=
 =?utf-8?B?OE1UYzVIdjBxc0IwSWJjdCtBLzQ4RE1qY0I2QjkvSU9ZYWNITS8yWkE3K2M5?=
 =?utf-8?B?YUl3U2M2T2xDM3A2U3J1TGNPM0Q0eTF3YzZpODNWeWFpMWJ2S000VkZJVDJ6?=
 =?utf-8?B?V2JieUpRbTM1clVvYUZZcW5DL3lkMzhhYlNnbHAxZkFjVVFlRGxMZkR0aGwy?=
 =?utf-8?B?clhKWHJjblh0YzNyN2I4ajJjUWVNanEvZXFLYnQvbjJGQ1hvWk9EaW5LRkx6?=
 =?utf-8?B?VzNuWjdFbCtGQXg2djJmTFVPNDN2L1NRNHZYUDhsL3pRSFBnRCtCWVMrdUdK?=
 =?utf-8?B?ek9YQVFkTWJTaEtpWXJ2UkFDWUlxU2VNeE1za2RyZnhnSjFxZiszUHlLeXJM?=
 =?utf-8?B?R2VEcURFQjlQS09McGFqYzdqdDU1MHZaRkpzV1BubjFlRkJxYnl3bHd6ZG9l?=
 =?utf-8?B?YXRwZW5yQVprcUhFVndrak1MelBGU2VFNHdvNE1FaUFmSTE4Rk94eXJVY2R5?=
 =?utf-8?B?SUdWdDNHbnUzOVBObkJobjM0Z0hrbVdQNUJsU1A2MlBKVGk3WFNQeXFkTkV2?=
 =?utf-8?B?cXBCbmUyaUt2T2JPMjhQMTJON1lmbSs5aE5RZjJtZ2J2MlFKY2MxVjlvWFh0?=
 =?utf-8?B?OTdkK25RdGJXbE9vaFpNN0tVSVdzR1Q0ekRiN2w3VU9sMk1WNHVZUkZIYktv?=
 =?utf-8?B?cytkR3ZhKzNvZkF4NVZJc2k3NElJYkZyRDl5VDFjMElFaEE2Vys0UkJpSTB3?=
 =?utf-8?B?anhXY1Azam1uUWJ6SjN2TG93QTRHL3NKb0YxcnczVjRCRUJVWEJqSlN2NlB4?=
 =?utf-8?B?WDdWeTVGVzJWNzlMUDlOQm5YSU9jZXFOSjRRNzFJdkl5Q013VmcrUU9RREVM?=
 =?utf-8?B?M2VPZUNQRm55QUZQWDFDOFV3ZFNoaHp1YUs4WjZ4TjFSVlh6WXJnYm9CbkJ5?=
 =?utf-8?B?ZkFRblF1YkdnRGpEc0NnbFlDdUQyc1RCS0dTellDamQxT0p4Z2QrRW5vK3J5?=
 =?utf-8?B?UlZQSjNxMURxaVJLenlBRUswMjFDSUFGWjJoa1RvaEFzR3RQSVJjZFRKbllt?=
 =?utf-8?B?a1YxOUxUV0pQSDI2M25qaGprOFhOVWgrNGVjdndTNW80V0VPZVB6NFlWdjlU?=
 =?utf-8?B?OXRrQ0V5WGdQajZORUNxRmFWTGR0WHg1d1d0OWIwY2taVkpRZWFjcklabWhy?=
 =?utf-8?B?TXh5WW1iUk84MUtMOWdpa1lkS2xkdVRhM3dtbi8wb2x2MUVlNzU2NGgwTWNN?=
 =?utf-8?B?VTRaU2hFbzJYSWxGNXo4aVEwOTZwZ0ZuVi9QK2VUN2w5Rm1BR1UxUnV2U1hB?=
 =?utf-8?B?TENxMmRXSkgwZXNYUy9FSmU5T1cySGVZZU1sWE9JUFp1SUQxUCtneE96cTV4?=
 =?utf-8?B?K0xCK1R4Rm1ZczlrbUFFS3N4MlpkT2xzLy8rZXhGdVFaUkpTZFRDNElyZmx0?=
 =?utf-8?B?WlR6eGZaQUlGaDhkRjVkZXhnOHNGSTBobSt2Z1IwRFI1N1luVTdVelpkckVH?=
 =?utf-8?B?K3NVSE9YL2wxdUlhMjc3TmZQMHhDa0NEWUQwL1ExMk5XamE3MGIyNWpPb05X?=
 =?utf-8?Q?krK2fgJtc7Qm/NPo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1301ac34-9755-47bc-29ea-08df136c63b7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:36.1640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xyut5KeZry4fNNyCpZIoxJ5li9mw2yFy/ylxzkTtAjHuYVxeqXBRZbaP17xe3UAf4gXqUlN8kFk6u0cXZJrRjdMq821Xq2MZRf6xYsMq1DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8708
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


