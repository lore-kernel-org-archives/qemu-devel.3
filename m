Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CEFC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FW-0004Qw-9d; Mon, 14 Sep 2026 04:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FU-0004Q8-LO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:12 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FS-0005Pw-Dp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTSqAVf8RUvsB/eUI6/rSEjtk7OBnL5iey9kG4DtxiDVVK3t4iPmghp2SkQ4A2XeyNfpGSb3yFLaiMvs/pEMYtwl+0EqNEJrmEtlnYNAw1v7922UFrvsauzdC2yiifXiR+P6zs/GH09URvraPoARrdC8BwPK23OnysUleD5krRZl+iP94IeZXltiVoOw+vYmPfQDuLpx0CxZJT6gc2VbI1xnr46hyWC0o50V4c8FDkpo82l1RBWEwpnud02qaF5r61A3YiT+Ehu5j4d9CohoTDWUkh4GlzrjG8jgk8Rtq+v9d3FZcUE6FToP6KUGCv0DaaNJmELGCt5TMo771zUSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeGC7CB74AEK/eiT/E8MvqfnL6jhZMK/55Vo5DN1ZtQ=;
 b=ip5GuE9dmkM8fTqcshd4qM9s3M/3PCTC7CzDdKb2QVsnm2eWub6+qUT2CbRImTJTNjXnXNS1AvDM3+vmt71o6vgd3vldYGo98P5FYTDUzfo07rID+HaYH9thTh+NpHPhChUXAvg7+7/uUBWPxQrPtHcXUd82qBh5B1PcLZWbsWgwCJ7EetAL4GoGGNCA/y0ajUJZ/v925trim9SlF535jb805i/ljXesDVKnf5PsMzcyLKfvOnIYfqZFu/cYHIflfTsNXVPAt0IEa/fxsZEve6FOMLlgwMlNyl8h7rb5RTVFSMRHkYdYhpXZ/Hm2j4i5eJbMHVdS0EhmB8loqs5zQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeGC7CB74AEK/eiT/E8MvqfnL6jhZMK/55Vo5DN1ZtQ=;
 b=XD4RG0bHdpYuC3f5LWBGf7AQ+0DwzarFmiCwQ0Kd007h8fvwqLSapEnwyUc/SZ+JpziH2hzemDlXZgDSexC3eLKwg6jtT79eE8Vx7jS702aYssXM199qvpKTl+JT3Ghr3Ym46pn3AlXzbY8lpZHE398d6GyAXCas4hde9dsIH2qa+QXD69HCJToj0KQuJY4yDRZZvvf8tMRh5QcD1It/botA5r6ZGrSCa6Nmi1lwEV/xWUc+Dxd34f09bauGlVYDaeZ9IvUBvIEQvlTKkywnCaLSvQDZb49l/Z9h9f2BcDEYV+0Ca6cS4Hi7Ww6mwK94o36cmTkJw1RfpwzWTM3WXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:32 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:45 +0300
Subject: [PATCH v5 14/14] vhost-vsock: hand off device ownership across CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-14-d17423589f48@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6d9ab01-29b3-43f9-4695-08df123bd44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|6133799003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 0A5N9rtaHgWdO48Pa9aC2jmshN10c78248dgUKgpFdU+Q+r2mmuDrOciYv66Dec0zRG7IhUbs5KEsRppenrZcxwOYBa/Up8hoWM1HChFfTcOFUY8POyk56SWhTEzne+BR3sLRGM6q+jRvOsZ+8SFA8bEAJxlgwimlcc1KFN/YGmHfU0W4UPcczs+zwJVr7nRbVAr/MrVNoNKAkXeXAokWbYaERecupOq9KBGzTlDMnpFnMbJTDgHUvTtSOFCT3qf7JTijyGeIIvJp+OpFsfC2FACrrT4/rrpLOpmFGkRFKwKUyGPu8nTDo/XiAktsSGi94LN3lvLSJv+UcVPo1RgkfVIVTLwuZbW1UIHE5xO4fLPVQdA6Sj5vvxrUf0EHBI7ehA2/v6gkcG1m6UjCZaTndunIX9nhUH/zme0lNy1+LLaVlRWJ5/zYHASsWLS21JuZMjAPjUekV75EvOKe0VFUzbcxS/JNh+hRSzwv62BcTzDUjuOiho9+nz/mRK7gvJzU+NpnMnn4JfaB5pBcpTVaIPUTh3rXdIEGnSTg1ucy6udsaNLldiQikA2NY+boW8dBvsoUdOJZ8YS3T2AWLy9RrrEpEw6JIIDJEAaqSCVkThIbBCzDgfiQW9fmIHHJUaMtkxsGRI28/+q1KqwN797/tTULJ5+BFWsELdwPKFxxR+eMD5zlNhkS3UCSN6xIoCe9vXk/PQLsMMJ722N9xvOTBXPUfO/VLyU9yK8bAW9u4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGswbVdiT1c4SFBjdi9TaFYvTWJHcE5iTGdNclhMazBBK1h5MVhkU29QZE5v?=
 =?utf-8?B?L1V5V0MxeXhGZkFpYnpESUxWeUNXWWp6RGRud3VXdWIwVS9jNHVGbzlTU3Fv?=
 =?utf-8?B?MUtNZk5qZnpxUTBmUXg4MzBEVTVyNkd3ZlN4Rnp5S2JFVkd5aDZOTUQ4dmlM?=
 =?utf-8?B?czhWQXgzZm5nZ0ZMMy9mcHJGQ1VIelQ0RjdpN0hFdHZoaHl0OHJDSzltV3di?=
 =?utf-8?B?SGs4NW1UbmxvRW5UdGthL3c2dndzbnkyaHVmYVJMU3RkQzZyNGZLNUhyL1dF?=
 =?utf-8?B?YTFkdVJwS0Y1T04yMmR1N1plcTVTSXUrdm5EbFpJZmdvd2NRT0MvWURQbWRJ?=
 =?utf-8?B?V0kwUVJzRFpzS1RTckVsTXh0aFZUQXh6Z1FSSTc2WjlFelBPejNoamkyTVlm?=
 =?utf-8?B?Rm1NRDV0SW9FZTNuVTNyRWdzWkFqK1ZZdmpBS05oRVpkL2QyaWkranV5c3Y1?=
 =?utf-8?B?ZDNOUDdraSs3dkdPL2N3Sno0SUJwRFlNZXVHM3d6OXpnazNXVE5pemU1aUU3?=
 =?utf-8?B?VGxDQnBLYm5SdFR5bUZsWnRLRTdNc0g0WEF0T1FNM3dhQ0dHNkxLSDRvRlRk?=
 =?utf-8?B?cGJsUVhtUE9SbW41YzR4cFVoK1p2N3N1ZmlNUjlWWVpxaWNNQzI3RUx2cEhp?=
 =?utf-8?B?TE1qMGZvOWlTaGhXeDU3alZ4TjJTTVQ2UkdMWTBvRUNqbjAvQVlyby9XTnA2?=
 =?utf-8?B?UWRqZzNHcklOV0RDRGhqWGd3RkE0RFBubURmdmhvVEdkWVpQYVFpZnJJWENK?=
 =?utf-8?B?eTRxY0NJemdsWjVIcUEvOVIwSGQ1M2JZNi9IajNVbVlJWjNwTk5rVVY1amNz?=
 =?utf-8?B?L2lPTUFNVUg0a0RFOXh2dEIxN0pUd0JSRjRhR0xoN1BSWmlKTlhxdThXL3hN?=
 =?utf-8?B?aFR4T0hqTTJPNDc1WGhMNTljWTlsYThRajRHVTViaXNwNTk2ckN2MnB2TUlP?=
 =?utf-8?B?RFMrckxObGpuSXNGZnpYZmh2dWh1MjU2anNqS2p0dkNSbWhHbCtzTFlkbi9t?=
 =?utf-8?B?enNTeU11Tm1sT3RQZkdxZllmYnhjUVJqTWhBWEZRUWZHeGNHR0tRZjRxMkFn?=
 =?utf-8?B?OUx0aFRzd1BFQXdiZ3JhY0x5UUV0NDgrYjNIcmo1WkJJelpXUzRhNGZOcUFS?=
 =?utf-8?B?UXRsaERuc29ZWUZHOWd0S1dXakJSVXRUblNVWVEvQzBWYnA5Q3pwSEZJcWpO?=
 =?utf-8?B?akpxWHZlWGVWQTNhR3dCU0k4QzJWQU5wdDhzSkJMY0picFJIdkZiUnlWS0hu?=
 =?utf-8?B?czRWY0xLdVdjbGFCaEFRR3g0RHNIK2FtYk1xVEoxZWFLWVV4MDRXN05VVVpa?=
 =?utf-8?B?Ni9JbXVqVk9laStPWmJZeGZybXM4Y3JlWDFTMVVTdWN4REcxODBRMlUyNm1O?=
 =?utf-8?B?OXZLODVJS2VzTWI0TzFIWlRrRWE1TmR3TTMvWTI4QWgzT09oRURPZHJnVTZE?=
 =?utf-8?B?Y0hTU09SdjVTOWJBWTVSNklhTkkyeFhGd0JxaW1HMjNCU2NOdFJMRExjM1BJ?=
 =?utf-8?B?LzF0bGZ2dW5pUlRzYkdHeTJ3a3ZGQ1FqM2tYcm05Sy9MazV4MGN3cjRRcC9a?=
 =?utf-8?B?WS92RTRkR3plODk0ZFBSS1oxR3cyaVlWN1ZxNFM0UlNJek54OXpLSE8rTStk?=
 =?utf-8?B?RldSWlZMZDVSa3k2a1lGWVhVT2Z4SXBVUHhRZXNvMThrSEtvbG1nbTJYeUV4?=
 =?utf-8?B?Mk0xYXlFSEJrMXYwdGVkNWpOUllSUFAvcDFubWFKWVRpd0REZHJocGpPNG5t?=
 =?utf-8?B?OEpQbzRNUjNGakU4dHJkaXpZWEJCOVoxcjJEemZ1elB2WGxSWkxUNlpSai9L?=
 =?utf-8?B?ZGhxWkE1Kzc0U3N0c1ZCM29ud01nUFN1bEpNNlNkRFNRckhKZ2U0TEV0YTli?=
 =?utf-8?B?YlR5OEI1U09SeVliNFd3TlpNUzJmOFYza3RGaXpHNlNnNVRGUUxMQzJoWGll?=
 =?utf-8?B?NWJmNlNPSmxicFkzZVUvWHljMW1nT21DT0J3cFFYVlBOY1ZKdE9tK0h3VHR6?=
 =?utf-8?B?V1UwTEgzSWloSklSeEFnaTRhMTJJTW9jNDVaRVZYeWkrOEJkRFRJZmxmMVdX?=
 =?utf-8?B?ZlFHbXdCSzlaY05iQmtCNFB6VXQwdDFVUklWVkMvYVg2K3F6cjZBNHhDNzVB?=
 =?utf-8?B?QVFHcE1KTnBHa1ZYcnUvWWlzeUp5cVkwc0VMTm5MazEvRC9BMGlSZks0Y2cv?=
 =?utf-8?B?Z1pEZ1N6dlgrS0xYaWpaRjJpNVdjZkpvaGpjMTU0OXY2THZNR2VWSlFpMmFS?=
 =?utf-8?B?RXoxaXZVMTJqakEwWWZHKzVnbkI1TjFnY0xCZWhOSHNZaFBoYmxSWm5pMUhI?=
 =?utf-8?B?dFhuVHFyb09PM0VJMnNQS3lYbDhsYVhaVm4xQ1FhU3pKbVJRUHRxUkJ4OXBE?=
 =?utf-8?Q?aw5SaV4KgRwYkOaQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d9ab01-29b3-43f9-4695-08df123bd44f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:28.6378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNk0y4yv+5eC0TFe+0zUF6hC+/juSfmbCpAdYHVsGingtSgr+90V+B77Jj5tr7JJbEd7fuVsNez2KCntaXyCR30Mt3wHNSxoPvNPbc7LX9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on restart:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker: only ID-less devices,
which can't preserve their FDs, remain blocked.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 159 +++++++++++++++++++++++++++++++++++-----
 include/hw/virtio/vhost-vsock.h |   3 +-
 2 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 203055354ae..e3d83815ed3 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -77,14 +77,46 @@ static char *vhost_vsock_cpr_name(DeviceState *proxy)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -115,8 +147,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL) && migration_is_running()) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -126,6 +194,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -137,7 +234,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -149,6 +246,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSock *vsock = VHOST_VSOCK(dev);
     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
     g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -164,19 +262,21 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
+     * With the ownership handoff in place CPR migration is now supported.
+     * Having a unique ID is mandatory for FD preservation during it, thus
+     * we only keep the migration blocker for the ID-less case.
      */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
+    if (!proxy->id) {
+        error_setg(&vsock->migration_blocker,
+                   "vhost-vsock: device ID is required for CPR migration");
+        if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                      BIT(MIG_MODE_CPR_TRANSFER) |
+                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+            return;
+        }
     }
 
-    if (cpr_is_incoming()) {
+    if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU. */
         if (!proxy->id) {
             error_setg(errp, "vhost-vsock: device ID is required for "
@@ -204,19 +304,40 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -235,6 +356,10 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
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
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..c5b9a488f3b 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,8 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    Error *migration_blocker;   /* set when the device has no ID */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


