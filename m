Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CF3CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCC-0008Ii-Vm; Mon, 05 Oct 2026 11:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC5-0008Gq-HX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:33 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC3-00056n-NP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCexwXj1xAI+W7SLai1F89EJQk/5+0LfepyPyAtAwu+Ko8WCvE1oTxm9KjrvMlf6j1WmYzUuM3FnuHPp0oIIS9FcQqcHP06wpZbHjLxp/EupUqFuLbUwRLQAeY3qZgUkzPognLf+D8gBe/2YGVG3sCG1GKd5MNZGsYpAzMbLP0HwPA66e4by8sqYeTViVrgnLpaFnHy1VdGTZ6o4sy8XMmFNu9r3gB8hTlYPr6bUXmu+cKXWfH29qHjpTzZWjjMpOrVe737OwL8xgY8UQ53Sp421i5T+EHfr657TsLuJDNVjSE+vw7XL2yK/JZ90gr/XUz0xUsJVjaBDjro2XpZn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=W5oarAMC9i8TQL2hZmF83EZ52OWhMIbB33471YukDyNdR/UN/jROl1+FNuzjD+cMl5h2EMTqhd92XuEW6tcbwJBazNn8HovYOHAL1NZDxqs5eywn9cl8jM2EwTTZsWLDSiRc7NwitUdGqnUDsgkdYVO5toLIVBOSDd2Car5+nYVIXMldTlvvBDJ6TXOiocQirVrswGw/MaJmCivyHqHV9KPYQ1iosJeOQMpJFIcmUaUoRDMG6SKwTBEWnTcOzAkgbWZ6NNAKhIRx77SisnJ3poLtCbVxoepeIvYZ18BlXdCtZPZzUgW9ALAd51mfMCrSm6VGyJpRrjp2UnBjJ0KHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=CIoZKqq07ZidUQmEeGr9yTxz7R3HH6q4rXcejccHs176OnWXEHy6yV+6w4m30fOFvGO9+h+m+V5E0kwYYDMrHb1er+Btczko6nZufjhf3oUfneslibKrmU9+ttywW1XRf+dStqovhZf0SGCos0J/9ktkw5HRd8I8GmmEyp5HvmEbkY42h/MKTHJCeYQn1wWegW1MZnTZI6be6PtBhQ/hgJJUAKrhFQxFi7Ry0GDMxkSOaQQQQEDNzKp1uSYaeLVv0znhqsfN243SeI3suoiG9JV2dvIpQfbvaU+pcAs1aR74cK908LB6hIRfgl+IU4bST82iesoUwcdKC5JoXOhxJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:18 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:49 +0300
Subject: [PATCH v12 10/21] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-10-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e914d99-e889-453b-1799-08df22f1829e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xfCvyEGbpwhm/jW7KVuCGQMIuK+yi6JhWM4GtOgnLac5bn0Z2IcCIfb5gEC+FWc8PJq0V66Cw8/vxuAgpkT+jKrxWjK5q7nzwFcHSRWFnrw9VE38Lhk6t1m0jsFpaA+InzUk/kg64BxPFeOVjioz7ukCoF2uECUK/PahBlIhydXg6NuLWc36gnedgQwucT0OxipiiC7z+9Tg4bDq+vW+arVuljsBhSykYp1Va8J6GwWMPVEYOIWTHNealEiAk1H3WLnyLBsRo9o+idRlLrjOQ9ni5vMowGav4hT5Av5GuLL4bI3Ky/hHN17cs3D5lgc4O3EUPsTRHJZ39JfeMC9T2hkTzo51+lNxOX1FwAmCceVVZna85bHTk/dW39uzaCwmDa/+qBIMSqG9OZhRkyWGq/6n+tQKJ1AI2aAmulyRQi7avh2OiYhQj97i9reUrZlo3wKTpERz0ObWbajphDe6iFMb79Xu8avsf0mdZK7uimnyh5c8PPTDDAM2qaftCL5Kf1G+dgCtthvwQnLVWLzmqw3kyrLal6aql2zE/osW2YPYM1jIXNp6Fc/EFnrgvMtNqaRmHwPlQ0dHOnEf4cSYPbvjFw4L0nERU29Il6DY03JINFVrWUyt9NmvXrpFZs6PNGKxJsvG8xV9Sv6RuSLuZJuud59hzL+84LJnv15PSfcOO+rRgzwwlJ0WJY5ebFRwjoSKDwWr1Xtdq85h8pZEgozWuZLBpHOFxys79DlbI5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJOemRNNWxLODFmSDRXcGdGUU9wemdlQXE0NHpWZUxyZjYwSzhGc0dMblVB?=
 =?utf-8?B?SHp2ZFJWSFBvMm9nYSs3R0xrdXdkZmU4SGcwVHM1TTM4bGhSQWNpZ2orakVH?=
 =?utf-8?B?aUUveE03WElsc04zdTQ2dGN2d0U0YWZZaThkQnVKU2FnYW1EV1ZEOE5CbHRS?=
 =?utf-8?B?NVRmTlMvTjJid3NxY1lQRFA4aFdUVXIza0ZPYUJXKzA3ZVlYTGRTTG1iZm9Q?=
 =?utf-8?B?OC93WnJBcGdSYUdYU2cweW5yRXI4T2xKMG95bHM3d3RyeEpyS241Mjh3TmZG?=
 =?utf-8?B?NGsrcTVqK1lwREozOTlSalcrQ0VJMVpxRldvZlBwdDdpK01oMlJVUjlGOHhj?=
 =?utf-8?B?NFRleC9oM2xTVS85cUVCOE5PUzE4cHprNlpIYTNwYkJYWUtxc0UzS2NXMHRX?=
 =?utf-8?B?K1ptMVoyR2ZBQ1pzNTZ0V2lMUFhIWFB1VmpabWplVEpvR21pdFNIWFRQQjNV?=
 =?utf-8?B?ZjgwU3dveDFxV29Hbk5PNDJtazlzQ1RnS2MveDUwamRPRVkyUmw3aXdDV2ZP?=
 =?utf-8?B?MytnZENHZ09xMkdHNjB1SUdNMjVIMW5TbmgyTUFiTG9uV2RVOWRIMnJpUGRK?=
 =?utf-8?B?Rm12OWFxL1o5b0dRL0lQZWtMZUwvdnVURGZaL09wU2ExUFBjaVpDTzJENkxS?=
 =?utf-8?B?dEUvZExyWkQ0M09WYmpoRk1aWkJnVzhkdmJkNXJST1NEVEd6QjhxZm1HSmlm?=
 =?utf-8?B?cWtHa2pSVHVMckc4ZzlydDNlTXRad2VGdGlpQ3lyTmJPU2htVExma2dtVEhz?=
 =?utf-8?B?Q1RLbTZSL3NNM1oyUFdNWUd1NE5LY3luYXY3dFlOYjBpZ3pFcUF6ZkhWQXpN?=
 =?utf-8?B?Vkd3USt1WGRZYzRzWlhjNlkrdklINE9yWU5SV2dxQ2JPYkVpSElSTGpBdG9Z?=
 =?utf-8?B?cGQ4RC9MYUxseHpkQjJWZnFSemtJWkJGT0hUQ1kvZGxiNXpvTElhTHBCSnla?=
 =?utf-8?B?bzcwYmhBWDdSMXZhbzIza3Mra2Z3UUFGK1I2clJqNWZvRFJtaHcwbElSYlZR?=
 =?utf-8?B?MFIzUlZ0WWFzTEI3MndMZDRCUEJRMUNoNzRweEZjWG9OYUsvM3Y5MTZFNVI1?=
 =?utf-8?B?SHNteExXZUdYVm8vdklDNWx6YmY0OHhZL3F3b21tckdnWXVyQXA3UkFOMHlJ?=
 =?utf-8?B?UUJRYW52ZThxVlNDeUZmaG1qSUwvaWs5ak9xVVNhTGUzQ0pDZ2I2blYxQ2Qy?=
 =?utf-8?B?MVI1Q2VtSmRreTA0S3lNb3dHZ09LSkVlNWtENGRwVFRwZzh0ZG54V0I0aU9Y?=
 =?utf-8?B?R0tRUXVUTnp3cWlXMjNta3dnSHFOVGlsSzZBQkJBd3pTNWZQNW1oVWh0a01B?=
 =?utf-8?B?RVRJdzAzSDI3UUdEV2dhSDJUN2l2U2xPYWUweE9jSTlmMWpyemFzTndocXFX?=
 =?utf-8?B?bmVvTVVWVTBBNExveFNONmp4M3krQUc1dkNsMG1CUnk2K3lqdkE3OWRCNDJs?=
 =?utf-8?B?aWVQM0FQNWR5SzFYK3k5dzJISVFaU0l3QTdFanFnZWg1N2RpYUttMkp4cENj?=
 =?utf-8?B?S0huZGtBY3M0N1JuMU1wTGV3RGNHdHdjbHJTUVp6RG5DQld5clVmK1Fiem1B?=
 =?utf-8?B?SW54NVljczlEdFF6N1pOaU5lUXpxM054OGN2MlVqQU1WZ1Z4YS9jaXFGd01T?=
 =?utf-8?B?dXRzUzlkeTRnUFJia1gzUWhBcXl4T2RmUVNUVTJCQ2xXOUs3OUxNN3V2UWdh?=
 =?utf-8?B?bWoxU2hDbnlKaDQzb243cTQ3UjdDV1pMcFdzVzQ1MEFrbzRMZGhLT3ptS0tV?=
 =?utf-8?B?NDAyeFE3SDBqUzlpWDJZT3U1MEJ5UVBRT1FQaC9FZzltQVppcjdiNDIzYWxh?=
 =?utf-8?B?UXd5bVNoNExlRjc0VEdWbTduTmg5aU5Cc0dvT0UvdksrYkxrVWRIZVVzMzM1?=
 =?utf-8?B?RGx3TDBWL0ZyWHRQcXgwdGRVazBWbHAvL1VPRSs4SEhBVFJUNzFLQVlnVWZn?=
 =?utf-8?B?cjd6c2RvaThnMGx6aVlxU2kvSWZFL3pjV2NFWDgxcjhRc1RyUE9RUkkzeFh1?=
 =?utf-8?B?eGdpcUhwUDBkM2lWK29vRzNTUThuVHJZYVdtWjVEcTFWdjVjUjRNMUVPY3h6?=
 =?utf-8?B?NWlhS3BiNnE1UUl1MnhaQ3EyeXlPM3Y5ZnpMQm5FZzZUYVc0TVM2d1ZNb0N5?=
 =?utf-8?B?YkliMFpNS0l1Zk0xMFRSSm05a1YzWlluenRRcE9kNUlXZTFaeUpnN3ltZm1a?=
 =?utf-8?B?ckNNNE1SdlQwZGIrMTh0a0dKVjlhVVcvNlVwRURnbG1pYmtDbUw5WDhsLzdV?=
 =?utf-8?B?TnFoZjY5Z2NleCtKcmM1TFN4cTBqS2pWNXFBY2tCSnhlUDhhSGljMk9rSENK?=
 =?utf-8?B?a0tEOStSeVoxTUwyRXJPcE5Wb0pTcDVyeHg1dnZjNjVaeUpwRWZVOGpsY2l6?=
 =?utf-8?Q?wp6lM6VoJqMoZ8mk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e914d99-e889-453b-1799-08df22f1829e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:18.4895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JryQmnErayDFP8Yl832c/+xSZ+JkHP2ytwpijOO0BsdjD76WT7b8NcpiGB+W0RVRpdEaPyKns/YHRJzuVjLqC1a3j5tF8JsTjl3QvYNwAYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
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


