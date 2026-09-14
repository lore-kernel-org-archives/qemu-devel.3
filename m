Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4657FC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FP-0004Ip-Vf; Mon, 14 Sep 2026 04:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FN-0004Id-O6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:05 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FK-0005Pw-Nm
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGo+hy+iesOvDsXPsslb71nD0arTaJwy7KjKbH4L6RdEg31iT5QVMm3d6Xd05XsMS7bUDQli6WreraFnVybpkK7K0TNHeH2pXdYJwBpeWUXZYQCXe+jd57PWM1MJc66Rd4VCPRqfrcji4tfI4ap5kGmB+ukFtjKPTSWxHUrqetjp9WGV8ef9NuiDXPIlW1WAYZ7M7nSW3SdhSu8qDK90ARVyDIiQWdMRlrofksLl0Ub2lqj6VZjQNXCWb7hpAenqPOUr0OgxEKSPw9V72irSGPHBGQ2SGiCr8KlWNfjBYOlaBzYqYmV0tcqP8wOz3RSr5KbBf1B9Fmmid4WKNiWIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN6MqyS9dUcEKpKXibgfiZXsMrHv5JELhuqBQdIXBDA=;
 b=gY9QLB8QtUZ/7+g7F/ojZtzZ6ia3UHm8UvCrTLghlxZNYtGG49ATMpDmv7jsfeCMD7AavwQOf3n7lXH/9njxqYQuT3CPkL4ybtov8FgU44ySMktz3IA6/57s5SG56Swwky9400d2Rr215D3nAsClFXU7EHZLvKgFrT61DZQX5CeyfxNV6NcGNw4Lb1obkt5Kkl44UJRd63IZM+GqBiu9yFdsrTfwnu8HX+WYUpLNL7JIH7yAwiJhQB6R7hDfF+JyNukA/Gl7zHFAK4ooHACyc7LYFlrMa1c3Q/ROdUYSMt2CtruE2mIcpNshfqlMWez5phCx/z+1YAMDnFPtGB/oYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN6MqyS9dUcEKpKXibgfiZXsMrHv5JELhuqBQdIXBDA=;
 b=j/rqigLmRSUsvCQM+X8BZUHu9qnHoWqGuxGNuDULpX4cMPJIc/lK18MlaeSfmRc/v+RoabXS79OXgyDCGk7n/KN0m1IVajqkvI242XFe3+kRtXk5kPaj1FLLbURknjAfsNSRuhKzYiIRgyVUhtMnBOwN3O65uJ6N9VlZ/RqkCZhkqEUZqYPLeUFIxRNpnSPPJ6QusIfj14m8YtzHR0shCFJUniSwlquoR1A8tNkABFxjc+BUXAlws8WkE8P+q6HmsJLWhzY17hO51/KM/wo09FpFpsKtKCPOT3In/dOhAsBMxurQf/gKyr3uE0H7WEF13a8EjKdzCTdCGT3jB7s4Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:27 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:40 +0300
Subject: [PATCH v5 09/14] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-9-d17423589f48@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa08d2cd-6fb2-4b17-ecbc-08df123bd28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: i/yM15RanPkIu8lpCG6XNJJG+8lGHZXgj1kRqqCKxKSo3rkFNL8IDyFSHCMigo9F+6J5OR+OaEkXBRqKkKOOdASIi/H1W9b06CTo7XghZ9CbPyh614Zp06gd4ya+AYCKeJqIm9hr1DMukdkzJDoaTBxZz/MeLg3HCpxuhhr/cYKtXOcep+6PFtK+5S67rhcbQHSCyQHj4AXa5Wwea0RI+NAycLS/1BXm828NRsXQWdyleEQMp6E3Gnr69YdQDF71RPLz17Gf7SZMQ1R/6xG8ceSYymPIKnVV7IMxKtcIAWhQQ2KEAXjBZp7XVYuomccBWvxdS8bmbugRjrbtC7f08gOWvPeAY8/987ZEqB4XBkiJthS4U6WwnaFz0+eve73o+5rE8KmYB27Lru4Tez/xhLRC21jyHr/UQAj4Sn5TtZIwfsULDK2L6YQlAUtr7HFrmAN0A/i/9LqYWYR0dmiRaDsnlHbFPXKMtSv/qMHPH4ceKiPFRdag9MU05j4LUUeL13iWdWWj82QDGsfzkZHwrcCL+WXQNc76sEzr53Ku3aAUJV8NTEjTUZ8dzuP3RCu0mnmP2YbA+CFXHrKqVoC6tx2Q3xTdvjKdQFJIpxBfcL9BwWvUstpK+fDqe3CywvGEr//XKPy3CDNdO/lALTmWdNjENavHuP8rihr2QMjXjQFuWhWNYeeSn53UOAcU7FgV3U2074kKBIvxx5RcT0rvJ/blDbvJgYlonAoRjGMhkaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTBCdHZLMWpYb29DR3p1QWhNNUxXT1NFUXAyUC9tRUZMWEpQSWlYZFZaWFBo?=
 =?utf-8?B?V1l0OEtPQWxDbTNtZkJYQjg2WWhIdmpvaC9JVTg3dUZmaURjUVpsMFdkWWl6?=
 =?utf-8?B?bVdPeDdWdkR3MmFHMXFLZlkySyttNEUycGNYcWQrTUxLOGhJQithalA1cU5B?=
 =?utf-8?B?MlZUZnBqVTNlK0owMEpKdFhETXdOR3I1UStJL05kLzB5UGxDUGVVNnBoamhZ?=
 =?utf-8?B?bzBlM1lBOUE0TDlmZEh3UG1tMlZTOW1aNXdUbXQycWdPaUplOGI2cWxwRDJa?=
 =?utf-8?B?Yk9EUC9IYlQxWXNOZHVHVmdOaXVBa2I1aG9EQ2tHNHhHVUF5aXZ0cjJ0emxJ?=
 =?utf-8?B?cnFVb1pFNTVEWGszZDVXeHNWUnlOa2xLQXl4d1ArRkdmRU5aY3pzT2doTFlZ?=
 =?utf-8?B?eVdpM1F3UC93R09wTGF6OGJSQUxRdjVDVzBndHFSY0ozSk4zL21ZT2NVeXAr?=
 =?utf-8?B?cnQ3Z2M3ZUpvbVJyMEwwMk5DTGZPTGNITmY4R0l4NFJaWDFPY082RTExK3Z1?=
 =?utf-8?B?RTd0TXl6Mk8rUFFjcVVZZ0hEWWZlSUp3bXFaQ3U4S1NHT3poL0NLMERKVWtD?=
 =?utf-8?B?R2pmK0Jld2dzM2tNbUVXQ3BOdFZmUktqcHoyMTRiRlczMEZJb2EvQy9FR3dh?=
 =?utf-8?B?ZnV0SUlFOFlISThvY3hZejdka1NVa2JrMCtCazFaNGgyWXNzZlU0Qnp5YkpW?=
 =?utf-8?B?bVRraE8yM0hYSjlJV0krRER6d2hYeHMvcXczK0dqNW4xU0VwREVHeU1JYVpJ?=
 =?utf-8?B?eTlYendvZHlaTFc5UEowelh0K3dYckQwSDlxekFsbGpRV0VzaEhkUlBMbTBx?=
 =?utf-8?B?eVRVeGVoczFiaUNmQlMvNlFIaUpKNUpscC9SaTBxU3dUZHZtaEtWS2pvT3JH?=
 =?utf-8?B?VUZCNXIyVGhsNlcyUk92SmxDOGE2MGUyVFpzK2NWT2E4WXd0RE81ajB2azdO?=
 =?utf-8?B?S2ZaVm1WOHFyVjZwcXpHbFltY0FUTUd6U0g1VFZnWTh2ZWRaN0NJeHdTNDNS?=
 =?utf-8?B?VUpFSzR1OE4yZ1BOa2tiYkRvbTlJYWRucHRXT0YydXFqLzByQ2VuVHdmK1Zo?=
 =?utf-8?B?dWxsRVoxRS9UUHlObmw4aVdxMHQ1dlAyS1dyb2M5c05BZzhMblZURnFxam05?=
 =?utf-8?B?VDQ4bm9RUCt0MmUvOHJQYjA1K2hhTnFzUWo5ZUlob1oyUkVsV05VS3BYYjJx?=
 =?utf-8?B?N0J2RzRYVnBCRWM0NVNQZXBHZCtueHNRNFJqK3U3WFZRQkxhQ3B2cHFwUEdB?=
 =?utf-8?B?V1B1MzdzNlorSDR0citETU9KUDdHRmtNVHF1b3M4eVpQYlUwK2NEbHg2STg1?=
 =?utf-8?B?eURCNVA2WXBIT1Bjd3pBUDdUaUFSdnQ1NE5EbEp3amZ3SnU5MzBuNDByZ0hP?=
 =?utf-8?B?cjIxbHpzV1lIaWxWN1BqRm52b3NyRG1yaG1VVVF0UG9JWVgyaDhpRmVnK0VO?=
 =?utf-8?B?ZEd4SXVMNVBzcTVVNWpGTmZQdXdwWC94TjJDQmthNUpsSVBHTEFHVHJ3QjFS?=
 =?utf-8?B?Ynl6ZWt3djBjSHNQNDBVZUZWNTREZXVLa3MwTEN6UEQ2RFpKeVQ2NCtZWGxn?=
 =?utf-8?B?RjZJZnZITFpVUERjN2xvalNXR3VXYnFyYWZhRytMbGwxWlh6VWdYMXNyTWwv?=
 =?utf-8?B?eUdlalZnYTdzbHNlbzRsQzlWTDlQMEJOZW50VUZpNkNLZ3YzRE14eHhrMjhy?=
 =?utf-8?B?WVdEdFRKbzRnK2ZNZzJVb3EyZUYvNkVHcjEvNEg3Ni85V3ByNkJSZFFvWklQ?=
 =?utf-8?B?VnZZdWc4dXFiWEtOalY2NmViUXNjRFU3eTZrQ1F0Y2g3MnZtZno0RU5MMkV5?=
 =?utf-8?B?ZHZwNWlMTXRlQ1F1dng0M3c1VVV0OGNZUnE1UC85NzZ0YzBRYzg2V2hxdnBw?=
 =?utf-8?B?Zm9mTEw5Y1p3VTU2c0pnTzJKNTkrakZZNDdhcm9xTk1IdlhpWC9vQWFsV3hj?=
 =?utf-8?B?LzJzTGwvT2ZNdWZlcDZZNndnOTc0b3MyV0szVlNXU1BPQWlST2MzV1dmak1Z?=
 =?utf-8?B?Wmk1R0l6ZjJoN0RyUFlVc2VRVndPdkI4TDlkaXNwcjhiaERCUWt3TGtsR3B1?=
 =?utf-8?B?Tk12eSs5aEUyV3VuQkFTN09zOW1lbEpNeEtkTFFhc3BwNzZJbUdhd1R0ZkxV?=
 =?utf-8?B?M0pCdGFXc01lelZjeFNLZFhZRTN4emplVzNaWFk1ZXh6SS9BSW83bVB5WmZZ?=
 =?utf-8?B?OE85REV4djRpb2FWV1FpZjJYYTc4bDBNZytNWDlUTlVqaVl4OUR2c0JiNDJG?=
 =?utf-8?B?Yk8vRE4xRjU3WWZVMThyZDJFdjZRZ3dQSTYrdFpRQkwyL0lOZkM2bDljOU5L?=
 =?utf-8?B?Rm9IaGNodGluV2NhSDlrUUpyRWZqK2VXbHNvMEROK2VSSktyY1ZFdFNHNCsx?=
 =?utf-8?Q?dGUCYy5wMJJ96HK0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa08d2cd-6fb2-4b17-ecbc-08df123bd28f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:25.5885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG2t1hAUSPm3RcKZ+dRUV3j3+1xFjVoCy5T8W3gNP+ZGhmSirBXu5gFHDe0BZ83pD1Sr9ELCVt+R7jl6F1HSrawZTekawI2zS1D5TotFJg8=
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Since the key in CPR hash table is the (prefixed) device ID, CPR needs a
unique ID.  Thus we only preserve the FD with cpr_{save,find} if this ID
is present.  In a following patch, when we lift the CPR migration blocker,
we're going to condition it on the presence of ID.

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..203055354ae 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,10 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+static char *vhost_vsock_cpr_name(DeviceState *proxy)
+{
+    return proxy->id ? g_strdup_printf("vhost-vsock/%s", proxy->id) : NULL;
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +147,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
     int vhostfd;
     int ret;
 
@@ -170,7 +176,19 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_is_incoming()) {
+        /* Reuse the fd handed over from the source QEMU. */
+        if (!proxy->id) {
+            error_setg(errp, "vhost-vsock: device ID is required for "
+                       "CPR migration");
+            goto err_blocker;
+        }
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -207,6 +225,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (cpr_name && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
@@ -223,10 +246,15 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    if (cpr_name) {
+        cpr_delete_fd(cpr_name, 0);
+    }
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);

-- 
2.47.1


