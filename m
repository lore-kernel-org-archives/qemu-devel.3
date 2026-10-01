Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F264CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8B-0005Jl-I9; Thu, 01 Oct 2026 04:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7y-0005Ak-H0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:56 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7w-0003Pc-1D
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiwHCKrx1V1eN/P/wQ05fKHjF9VGeA9AtaPZ+RaoxtWMpJ7XdoD8F+jU2ru21oIDbToNqpwQy5SIHRYpPwNl27V+M2az0XI4L8D8e1cseHIAcSb5Ltj+rKHe/nH0UP95BG23LAHg6amvYrarNXTBmaNg6bFsQtnsL/Z/TAYsakAIAbxHZtscBMV23GvYJiEEt7vAmq9JSK9FnOyWgATzIoYEVGp4oIpAChszuioptoO7SKjYSEW3rCdARoAgyud4va85HrNvhHmbYFdwJpQLvXYxUnWLt3biPBBhHRxiIX2vDoQjagvpWGWoqg8PHiOMSJLXk42E/sDpNiePdeDwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=ZzjHV4sBpEHCVIqPy6IHznLdLdjdVco6NaHB7K104ftnqv5iKi8nB8ys5YKkYL/VcYyIfIPAdVvBYIgludQTV/eZFzudFAD4hbtn9g76Xrf/smor5VPSmxp5AF8K2/vx3B39KHEdranpEyugVvFDO3WXDsf1C1YSTtalrN3tbvmZPcsT61mowUF6N/53U1drrfPtd0KrMLTrGLnBwAKaLMGvMWbWnyGx5yHMnBOEQ83hffWg/hzSBuSKFAwGIsIWSqY2psDAy9DRCzq5jsN3Jf9usdckVc4L8C77anps8h9GrLXwa5sxX43kGT9oCLZu7DLopChjBRP/5b50a+FFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=sJxcWYy/tCrmXrx2TkLginLz3zFku7vJgF0+56THfcMWZq8B3zz7bHPthMSXN3Ufbz9DQS1pxfEUbLP6QRdFbPufJDG/ZIYeGV84BZm/CJrsFuLO8wu0iSrPfSbA9gGggkAox3DlnMXgwOdoS/tzY+fr9Hmvb0YvbYgCQmwU6+350QHUS+WSGVDIwGG+mIW5W9mkOu8y1kexuuPDuFQlqGKTkpzgFs/FXhEUTnKunBUwUq2ffXx7C73XNSeYLzm81Xtte4jK3uE+jI2mIq2pETBUMWJc1Y8jiB0AseU103TJSHEi03AsvW2BQMbyPnVWkPuYiIVmWTccStYZwW7tjw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:48 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:10 +0300
Subject: [PATCH v10 10/18] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-10-8c094843e98b@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 586c63db-40c6-4ad7-b279-08df1f95ba45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: r+9evzjPaS1/0qSeec9c9RyKVMfe5Rph03zLVhkmZrPdP3jz49/d7j0DKQTtMYS5bMrajDRTeotleGuKndl26LUntmqlin5C+KJIKHhP2IAYgisIEWOx7bvGhC3ynxcTC6BfU7Ftyf9DP6iKefIgLlfXul5N+sN7stph6S8/A7CnQp+vwsL3I6hKQcHscG37taebRSpLlpNdXNv4RflLJqSGFLcKefAvQhoAzjxs+NcHbcBIp0/nFJiM9ZE69RhvyRHpGRdN/pi9yF7omysw2+DjJOUm8HmRNkG7TCoqBAylJbR+qppPf6aeo626ddIOgKwc639t78ti9OsRyldu5eHF0p9XePu8dDdlOrowcC7SyBX2qqEW1T6iAWSa0s9lYYr+2LEIG5GfFwLCZCueyRDvM/PFQK7DXC7xOIRFUxATOyRx6lXLGz4uRj9zBQYf2Dxyl13EvXX6s9wQ+bLUY7SnHoKz4MRffxyk1c3L2AGbQo4p5WffxKdXiyCTxwp/wRBSX5L4GCNJU0GNwIa0uFaz0aZB1Wx0LKFo/QDwkd3/AWngflGxsUj4/OdOnRmAvxHIqqJiH3zOYoPg85Z3il/82fNrZ3NpwRa/XNjUhx3dlNcP2dgGukyrnrj3hRGyX2MCCDkQoKHZ50Y/mQ8jPKk07sfEtwq9Gtzu3PHUIaB2m85Oczs3cKjwu6uzbjfxUbcGArGRspug8G6mjWtBMqouBxQ1SFpIKXBv5M8HWY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTYxMnRoZ3ZWYnJhaXBSZUJJWVNjRXZvN2MxSFRHbWtNSlpPVzVaa2FOcnVD?=
 =?utf-8?B?VFplN2NsL21CWFVRKy9QVE9ROTZUWjErRDJodTFXY3FJSXN3cWhManRDZDAv?=
 =?utf-8?B?TzMzQmR0UHZnaGNDZjVvSkNoQW44M0U5UERrMFE5Vms3UU1LajcxWWNXTFN1?=
 =?utf-8?B?QWxYSTNEbkpxL2Q3SENxWDdrbzVOSldPdXVCcWdXZUZTSGR6NkRqY2g2V2pF?=
 =?utf-8?B?Y2gxbEdNR1dOWHlVeU9lNmd2RlpvZzJFejN4MVZYekVyMS9ka3RKcEpUUThh?=
 =?utf-8?B?dTNJMldNWUVuTXhCWWdKOURYSzUwQmtuVUoxNzArVGRHcER2YTFlL2hwdXh2?=
 =?utf-8?B?MTdlOVp3VURRN0NTcDcyem1BSUEwb3ZUajFyQ1hBeDdhYm4vcW9ZakNVTVpP?=
 =?utf-8?B?TUo0dncxNm5SMkZhRExIUTFlOGtQaDIvUldMOThlNTM5N250aHl4WEtsYkJE?=
 =?utf-8?B?MHRxT2NNTkQrN3ZDY0M2dXBscGxXN202VTRoRWk0VDJpV2tPeHd2aGlRcFFV?=
 =?utf-8?B?Q3hyQjEvUnhaaC8vWDAxU1lFTjZjT0NxUXJMNXh3WktQei9ENmlzMHVmU1gx?=
 =?utf-8?B?aEFCREQzWHR1VVpubUt6U0JnQmRQRGdoL3NMWUE0Z0hvVlZCdjZwTFhjcGM4?=
 =?utf-8?B?NVB6K2V0dXJxVk5Jb2NiOTN3d0F3ai91SWtBYW9YZFJVMW1NZHl2UW1jdDli?=
 =?utf-8?B?cUlRT242bERSZUk0ZURIdVQwVmFIVmhUYlMyZE1rZXNrR3ZvdS91djV4MU9T?=
 =?utf-8?B?Q0xsL0c5UkFCUnhJOGRKNzFsdnpmRk9LdnFqSTdqZ1Q5U2RiN1hwa2QwQXIw?=
 =?utf-8?B?VUJMbTluSjJ2V1NvNE01dDdyY295MnYvcXVyaHRZZnhmUEp3eW1YY3RrRG9X?=
 =?utf-8?B?a01la2NZK0dXRXc4bUljc3c3VnRERUdDS2tEdS83NUh2c29lNWhuS0hQQ2x4?=
 =?utf-8?B?MkZYR1BNYzNqNDJmV1h3dFVRMWF6OWZ5c3c0dnZORHNETExSenNocDhDa0l4?=
 =?utf-8?B?VXhMaW0wcmNwWGFoR3RTTXVSRS93eFN1QUZtbXVTd0VZMW1vZUZGZjFtam8z?=
 =?utf-8?B?UURlem9lZDFIVmh3anAvaDIxNHJXL2xBOUJuT3ZqcnlrVm15NnBnNHVQbGc2?=
 =?utf-8?B?ODIyWHloK205TXVNTStqUE5Pc2F2NWJBWjhOdzZKQUJicTg0Z0VrdS9aV2h0?=
 =?utf-8?B?ZTV2VDlTT3FhV0pheDhuZEMra1pCTlJZek1VMWdVdCt0RkhBUWdZWUdQemRS?=
 =?utf-8?B?SXhHcG0wMndkdm40Y2dVTkhzTmZjVGZMb1I2U3JPcTF1UzlJY3dPenZaZ2kv?=
 =?utf-8?B?SDI5cWl0U2JNOURYY21vK0Q1cFk0Z0V2d3dXbSs4b0hZRU5OL0FlR2ZTSS8y?=
 =?utf-8?B?Um9IZGRHNEhhTy9RbFp0WEZ6SFVDR2Rudk5RWjh2MlB5OGFRbDdVcWpMRUdK?=
 =?utf-8?B?c0VBMFBWZThUS1J1N1hvSFY5RlBTYndETjc4OWViTnF5MitHWlcxNjIySHFu?=
 =?utf-8?B?YlFFR0pCQ2tBc1FVaDdsTWdkSEVyVGY2ai9DbVpHOU00cXNkUmQrT3F3Z0Iy?=
 =?utf-8?B?ZEI2TTdDNUNSalI2TDZHa0hvdGNQTTRUQ2VxajZ3SGpUb2dEMCtGNTNnU3Nn?=
 =?utf-8?B?T0YzdVZkc3NYWkNUZ0R0V0hyekN0RWxleUJqSDBIVW9KZDNNU2FHODNFS2NG?=
 =?utf-8?B?MVZwVGZBODNUWDZ2ZGZtSnc5cDFzNk9Icjk3UWtzSEpKOHhhVGF4THY2NmJ4?=
 =?utf-8?B?eTVXa2pYeWIzbk1sVXhHN0ljZU00aTVFRHBzM2xMekJXRmF4aWwvT0pxTGxn?=
 =?utf-8?B?L254dFdtMng1dnJnY3UyVTJtYlk1akhSUWdOQ2xCTE9CZWNXa1ZnMTlNR0VF?=
 =?utf-8?B?OTcxZ0dNeDRVV2hlZjFpYmVwM3cvQkxuSjVZSUNwMGNEY1g1VVVxZFBYOFJX?=
 =?utf-8?B?aURuTzh6K0hraU83WWZSazVYdXVMTnoySDRCS09mSnY3eEhPZnNoZVY2RENs?=
 =?utf-8?B?TkgvaDRDS05VTjczOE43Z0ZNeEMrL2paK2o1ckk4OHlPaVRYeUtnRjVocHA0?=
 =?utf-8?B?YzNleGprSkRlZ3gxUkpFYjJncEhiNFNtRktFYmdQK2RYK2hMTFdjcmpJTnBI?=
 =?utf-8?B?QjYvSkFLbEZnNVhCZVV4THV4M1o3Z2pGczJLNUIxdWR5ZkFpY2xoUFdOMlo4?=
 =?utf-8?B?RGw3dmU5K0VkRnUxU1l3QndlRWRkKy9JbkoyMytoQm1FZFdDanhlUjQ3T0dQ?=
 =?utf-8?B?T3lNNDlkZVcySXNHSWtYZWxrRFJxbC9UUitnY25xb1FZZUM1UUdpU0IxcWk2?=
 =?utf-8?B?OWxybXU0M21rRHNGTC91YklyQUN4RUJIVENjQWt4akVwSWF3UGNkOWpkaW9u?=
 =?utf-8?Q?B/94zMsaGxBtQUBI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586c63db-40c6-4ad7-b279-08df1f95ba45
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:44.6700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIWwgy/1nYlf9qpp8uRhiZnewjuaTufIz4TGtrgnMVk/q8OwGz+pui9W5/o9Jsn2LE0CPmx8jqv1KwzY0j6Hu6RgyDM0z2TMoE7mk3Gq0b4=
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Use the (suffixed) device path as the key in CPR hash table.  Device
path is obtained with qdev_get_dev_path() and is essentially the
device's address on the underlying bus.  As any vhost-vsock device is
attached to a virtio bus, whose .get_dev_path() forwards to the proxy
device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
always be getting a unique non-empty path with qdev_get_dev_path().

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..6e89007b2ce 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+/*
+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
+ * which guarantees us a unique CPR name.
+ */
+static char *vhost_vsock_cpr_name(DeviceState *dev)
+{
+    g_autofree char *path = qdev_get_dev_path(dev);
+    g_assert(path && path[0]);
+    return g_strdup_printf("%s/vhost-vsock", path);
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_incoming) {
+        /* Reuse the fd handed over from the source QEMU */
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -186,6 +207,9 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
@@ -207,11 +231,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
@@ -223,10 +256,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(cpr_name, 0);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);

-- 
2.47.1


