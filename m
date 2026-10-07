Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108BCCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsb-0004Ld-Rw; Wed, 07 Oct 2026 05:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCF-0001H5-Vf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:28 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC9-0006sq-Lh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgMI8xU/bVosD6hZg1o779YdNvkV/XKED2momS6Gf71WrlonLX4vuLkSsqjatrwnek1QUME/qAwarN1Wh8KiPNDhmRjBNqYUarIkz+4UaQKQNCi+kQaF+qBIly4VUF8I1j7hNJYvd5AWBFxoSnTI2xvA7ZG210ji4B+rwZ13aodDTkwIJy37wCZQZXFSASQuCoWcK1MVjN3UlMhnmvUPFoQsEEHzYi2QIHPSakBbDD6ygUnjpxO9Eh/2uwLL+tkelOyVr3Q1QumvNBIIK7sxwEM8Sn4xu702/54rd5Prkj5tAqM2YgEGgv03ADQIQ7MZRXTvzzs+JuKzLNmRZtkAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=qO07ovr5xCkl5eVs7ri+46O+CvXtha7sSy6dQ9gDL1tvX72CTzO7PWA3HBtdiQOh6MtRef1rANjYF5WGTf4AzsvXUxjczsIIa6vLivVtS2h9C5uavLk4wmgDYPNs7EpywpKD71QOooPoGME8jzYD9fKpMhCWsccLV3icxYrSILUCHgxq4MnXQlhMFtu3cSYyvMlLv16mQ3iZ3dtXuSnJimibncPbEqRQfFJfIjmbcsBbEMJUpApj9ppZFS+l37lw8OgKRRQg7r+8odjOSN187ybA72sYt3RzjxTSqdWOV0cR6PsyKTJkZo0sO8s1dBp9r4torsQFnK2/bWjdBbGrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=ti45l6R3rAairjST8wQpX4rwAdEhUbxlvsWe3pRQDPGmgdpH7hi3qh0ah8pImSgpEYXkJYF/G4zW8wM/rRWsaot0n0DmpNAPPQIaKNVnbuUTXuKJ3d9wJBh6pAhI0sfZrV095n+txoSbSr2hCkwVtfSsVHcJurVLbCDC48zoIBdHEm1k4Bv0t5n/2I5tjOb89wrRTpK03FOC4OG8q3f310uPEjvqXsPpsudf7lnHKPZt7hQCaHRNS0zfb/temzQTvwKtXJUFUTm3AAE7wBi1Hffo5Fv7DJnGk33MIoCovSQfqnfg7H1LdCgGF1LZkIM/kvKERMH9sDKmT5q/hdU2FQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:04 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:03 +0300
Subject: [PATCH v14 10/22] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-10-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: e65009ca-cee3-42cc-1b18-08df244e9563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: x9BizHDWYZ/+Thx4eqPJaqaMJz/jzdWh1io55DB8biitaYb5lYawvBCYQX0GCQ1h8x5DY/nDVQuUbI23fSVOiUkp9ZEpuicX2ITZsnrr2xCF1c1T6lhOSmYcIQDxSKJVy5LQVCAt3VcyaL8WJiLXfJo1YdEOT2brSnzaNAYD/bE91uJMP//2AvmzMNnkn1qcAG04l1ymHZkMtBrdaI5KfdNcAByfH4eCtAxexWG/KyY8vECmXFoQGxHT2mwEwmDF7cl2FKC7guRbtrqzeN0y4iK0BRhWhtTIlDJUstoDvtyCph4kkNnOK0QS+8Urvd7yJB1OPB060TJ0rTtqA6zDDv+BUOR54iQmRgrqccfsRQXDoDwvEF3Y4SfVi0Dp9M+q1RMTvHxcLxCY+VBokTTI94wfBNRE2jNjxQtBaCxcfWXcYOFd4AHWRuNUox0RLmmCp0fzdt8f5oFxGby1OvQzqLx+/7WSiDpktxN6NFeh4YChT7V2HBs8wlDbP82UmORvIkaFb03GDdRutc2AToVWDxTmlLSLVorKSyPoH6LoUESrLPFLLUZybafF5RjZfD9T2P/6d2IthmQ4z7zEf/9TszQ86TmuPJvoik+kNfEfg6LsVdPh8tmq/IwGdvmP9gKU0nMvrs13IP3z+mreaivB3PTGzjNIgEIw2zWn+Kla6g/27EoMXmua8+rWu/+VlCIX3SL7K6vvAE1sFPrk0aDUjYSy6tqM1vVrIJcYA+0avHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklhQ0p0eWZFekorYlUwRHdrYU1LYTFmanBTTzk4SE40WC9JTVNLRUlFUmla?=
 =?utf-8?B?ajNtL2dSaVA3em1UcUpOemNKSTlVMFB1dlIxMGJFQTQ2d08wbysvZDVRUFgv?=
 =?utf-8?B?d3hYZjRrZHdsby9qaFp3WkVHUEkxZHcwTmJESjFoQTkxQXBIem5jSnNERFFz?=
 =?utf-8?B?VmFmMk9xMEk4UXA4NTM0YjRBaW5nc0ZpV2ttclhNa0pSaVVHc1RmWGRzSmow?=
 =?utf-8?B?aGVBSTRtWEMwS29jNFlTMDNRamE4akZ3WkRVQ2V1SFI1Q0tBN054QmkvcWY0?=
 =?utf-8?B?ejhEY09mZjBsRmttVkI4SlRsWncwam8xMCsxdWJWSGVZcXNQRlRGU3dIcmZZ?=
 =?utf-8?B?VVlNOHlkSjdOaWxaNWZRbUhZNmdxL2RDS28vVzRlQ2F5cUFyb08vYVBBbG4v?=
 =?utf-8?B?M2VjdU9VdmlHVzRoVmQwSnJLZngvNjV0N1VQemR0OXJTSnlFQWZyQ0Iza0NJ?=
 =?utf-8?B?UE1xaTM1UytCV3E3eUtTV2tRTnFHNGxaTUtVQXpKanFVMHZjbkRRaDVDK3JG?=
 =?utf-8?B?UFR2ai8rQTVrUCtDWU10Z214bGVSM3k1OGNhNWoxUWVRdC9ybmpDZTlMY1hH?=
 =?utf-8?B?aFpkMjV4RVJ3azhjNHNja1E2MkgzT21sbXRKdWVQWTk5YzY3akJ1MVd5Y2cv?=
 =?utf-8?B?dEFtQjh6a04vLytMSytNOTJ4YnRYRXIydURnNUNFNWl1aSthVUVOQnluWEw0?=
 =?utf-8?B?ZEp5Ly9KbkFiZmhiajVYQnkvUUJxZmRLbDdDZHR4VWZnTHFZQlRjekR3MzZa?=
 =?utf-8?B?ZWVmdHd5ZG1udGg1NzZkNDVIc0lRMEo4dzJ4dkgxOFRIY3ZJMDljd3YwbVBv?=
 =?utf-8?B?TzUybGhlakJnVnp3Tmc1WXdzbUlvVElrMXo3cHErOTFOcnFINHhDR1J3eE9Q?=
 =?utf-8?B?dHpad0x4OEViRDJmV3ZvTFFQcis5ZjE0UjNNOUxEZW5pSTRLYUpBY0FuNlNm?=
 =?utf-8?B?c1VFWm1MVDFXWUR5MGFZVDhvL2ZCMko5YlBCa0Jsc3FSbEZaMXAxU3VoNGRh?=
 =?utf-8?B?MDBMUlB4NHlLV2hlc3pndkpHeXhxLzFNOE41R0tHbG56cU13M2JIbSt1MC9O?=
 =?utf-8?B?cmdqalpwNUlSQnZkdkJLeDlubW9tYnYzVGFNUDIrTUlXb0JuRkFJMS9NbjZj?=
 =?utf-8?B?d0VyY1lpb3RwVWNnQlBpOWxycVhlM0hqWVpCUVVxbWNPR2NRNXI3S3J5cm1l?=
 =?utf-8?B?NEJQQUcrb0VrUXNjcWNMWHFJU3JpZEFHQ3huMk1haHpyb0FJbDdxTzRaZjgy?=
 =?utf-8?B?cnBsMlFNWXBOVGdyU2xQRG56YlZUT2UwdWZZTzdqbTIxQjJGRFZrTWZFSSti?=
 =?utf-8?B?RGFucC9vQXBoU0s5R0UxWkhweDgydnY3MTVjVG43Q3o5ZVFwdDBMV3ZXcTFE?=
 =?utf-8?B?OXUwQ0k0QjdGWkZKUmlRa3lNNTdreWVnczRmdld0d0lTUDRQSW9CRG9vczVU?=
 =?utf-8?B?bWp0UFVVTlBuTUtlS2FlYTRlRUgxOVd3U2E3bmlJdmx4YWY3N0gxZEhNRkhU?=
 =?utf-8?B?NS90K0Fic3pDL0x2WTE4QU1MbXBXcjFVdHRYUUxKUjliZjYvR2NWZlg3VTRS?=
 =?utf-8?B?blJJOEdiUlpmSUZCcGIzbkUxdVdvQ2VzSUdIWkRwQXQ0NWhFMEg5OUREUDFT?=
 =?utf-8?B?dnBaSTRzWndFd3drSnBsd24yaXdDYmMxZ2JhZmN2K2JaV1RKbWV3djI2R21l?=
 =?utf-8?B?dm1JQ0xoNGQvdWJ1ZXg0Rlo1OVo3YWYvd0twcmdweHRTUi9JcGQ1cmI4VXE3?=
 =?utf-8?B?Q1RnU0IrekRnUXRlV3JXK2ZReXF6a1lpUWYyeTZIMHhVZ3dFLzJQUHFTTzBr?=
 =?utf-8?B?WnJHVlJNV2lXK2RyajZrUm4yUVppclVKYU4yQjUxRGI2U091cVJlRW5sTGUz?=
 =?utf-8?B?enY5VmVBQWUwdFMyTldJOTh2aUNIazBPc0hsT0FwbkV6VHdWZGttRWs3WHNM?=
 =?utf-8?B?VWhGS3BnengwclMrRVJUZzRMZEVFWmRiZ3BadzhRaVl1UHVST2w0d1FIelV3?=
 =?utf-8?B?M1Y3Q2xjZXhBNUQ3OUZ0MGtMb3BKbkRvMGdGWWJENnoxZGlFbEdRYlNJOWtZ?=
 =?utf-8?B?UDZTYmJLakxMVnQxT2E4SnZOQU9GQzZYVEtCY2d4dEg2YnpsNE1nc3FSRHJP?=
 =?utf-8?B?alBXckphUmhsT1NzeHdVWnl5UWR2bG9MYlliV2lBODAvUkg5ZkRJbEhNYVYr?=
 =?utf-8?B?UVc1dEFYYTl3MG05bHRQcmkweDdDNTFUZ1dKOFdKNkRtb0JuSjNsRXZweXZG?=
 =?utf-8?B?ZlMvOEVCaDlQUnJvRG0xUkNYdmxSS2NUWm5ER2xyTjJBVFJFUkFhbVpvUUQy?=
 =?utf-8?B?NVNSK3Z1cEVrN2hYQ05RVnBRbm92dE11TGJ1SEpMTW14bnZNc3YyY2JaMzJz?=
 =?utf-8?Q?brLCsEsoD8qmp0co=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65009ca-cee3-42cc-1b18-08df244e9563
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:04.3196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo8AscULvnb1L4JdYEPdPLOx+U79a/VDD+vFcXeAJmZ4RV9Z7xL+NWM5VA39xYZldri4L9o96ez7KMSSOnWraTGqyBFIGycPtV0zOUMHocU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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


