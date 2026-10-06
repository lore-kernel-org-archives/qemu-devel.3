Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061E0CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9J-0008Ma-Au; Wed, 07 Oct 2026 04:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI5b-0001OF-13
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:13:30 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI5Q-0000dx-EK
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:13:02 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH40BmtpnvOh/MoNmPohqKunwA73n3SDJgpGbWXfiyOlydOfjAFhUlSeO27FnVi2FNqmJ9oriX5SFJpAFhp4vIPUsCl2cpMubi0bV9GZMEV96NIbWzfyfigGaLFxbUEZ1CCath9nhpI4cECxgFUZzXpNzSl4phC74c4OglkqaY+RCAH++41FeQemYgWXrNZWc9C/XIClu5XyQNqivO5u/r+4Wso1leEM/DRPMOi0VxRaYcFlR2KKL3ZtFfRbJIcJBN9KiZgXKaJK7r42zzjy5fzUehBc/pEjgBT+nXEpwXuYiMb2DbWsI1tr+suo7vjP5FjejtuctH6uW4Rf7IdxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=rnE6UNombVRY3AJSNn3dv/NPYRvLGOKo6eTuWyd288jXpqucGkW15+fqFjCpX2nGyokoXGqpf+8dA3XSRJgS4k3v/V+/Rkd2eBsV8RflgyJ/sL488mKyyZOD1ofr4ubLyIZi3BI0mUt8z4yjjvxACaIAPiumIbaYNpw/ocAi2lDYeWF1HHrtAkMRcDOXKp+Wse/Njt2J1F7wWcXL2mtRITpE+K0sQ9560iW1YgG0yblEoOgNean1z8QtNKAwFk20ODdo20QhYGMAL2D8M7wz1UtLihDcKb14vBE/QiWjuterA/nwmY4/4aTwTlWJiscEmfg81Fd8Vq2ZAOs4LefQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=LLeTql0FxDFw8vCLZ3KLIY0SCFdGFUqoXgGnAHaBTi45s3yfrGhFS7crynOBDN6SEGPL87XaaSHAWIId4NRO6qyrlnXlTC965tF5DjdL1Xm3kA9w9+QGiU+LPKqdayfZ8Pl/m3HljK/wh0ms14wMBd/wGhjGDUTT5BSwY/TFcVw2qCrNGwoDJ0/paQCNgA7JxOxQVXsHa0PGz9RjkbCQCLB4OqZuOQ5IEE/W+lc0IYHAJd9RosZopLD5DcJBwuf0NtLpirCI4R6W0KgN0449Ve+f6ONhlzdFGoTJQScrcRvLRM9R24NTOF6KsgQoLb/apBgnr/2slqVlgcYG+f7wBQ==
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
 13:58:56 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:35 +0300
Subject: [PATCH v13 12/22] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-12-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ea692f9-624f-4e77-52a8-08df23b1f6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x2pS6GFoIUOCXS//MsuxDFDiSLOzZ6Zt0iR8AQSrAurjTRZnpBHk8W+5CeEjnJ/M9qO6FOXhp2e+NQoAIj1NCZNXj9ubQG7rLhekolhOVOSm71CmBD9lXfIdgCe/2eUUn4EUWMDnl+AKANWmDyCl/SO85BOmJCe7KqrV/xwjG4even4KuRFgLRf8cW5AlTQC/F9Hegw43Jq84na5iMmt/T2N0fsG+oqS00B+trQAja84wbwDN4WeBcIO4qkaYJotmtqasukbK8VPgF3JFLrJlftr/02kNCu07/s2kI6p2+1dDdjHs/b8KSnTUx9O9ti31E8RpIUvznnmBNdb4rFyu6WrIgEkr7qXQNrZgj5OsikHCI5MdYkNGwXq2yZgWdJmkMEHd3jDDw57HD/nhNxCQZUCKXGYS6OvJ1w2JfIF4YN8OjtQzK2OXGr8gR82cCl8YcUKTJWdK9mSNBpyhHtopAl3rOMdMIaXknpIrsvCpO5SPjw0TPMBT1jqGzPVLZv0ifrEMunKnV7SHGaVjAwVJO1PSbDGF5iywpPo6E/XV4qe+FVdtQvSV36YaE1fiIXBfU3ykgEiJvdnK5XrmWqr7liuvBy0K/eqVMHXmGgxxXUHGwP0ucNqhmqi5TZxhSQHpI1W29o0HhDbOodo78bOYP5YS03D2Wvq2JLTvvFWqw9cbjcO396UQBu6FpT9Vr/ZrWHFjz0d8a0S/47eFoHh58EQlbvg+C8EcPgfFGpmdjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZWVnBhd2s5Z05wTi9jSko2aUdLUFZES3hibmtpVmRWY3JjY0lwN3JNWlNz?=
 =?utf-8?B?N2JIVUlSZ3N6MU9lMEMzazc1WERKUVp5L0lLeVB3eEZaVHQrK08vSSsxWWg2?=
 =?utf-8?B?WGFib2NxN0o0UWE1eElMSFZIV1VyR1QwZEgzZVdtdk9mZzVEV080aEdRWnRv?=
 =?utf-8?B?MFZVUnVxSzJJL2YrQU4ranlFbkt2TmI2akpSVmVnTGJjMmpDS2RueFR2N2cv?=
 =?utf-8?B?Q3ZMS0pwM01peEwydTZBOSt5ZHE4UWpSUUhyMUVmY3puSzI2SHB5a2E5Znhu?=
 =?utf-8?B?KytkeWZUN1hrNVdDaDRpTzhGZElKa2F0dStPc1VIRWVoZDd0eFhuY0pvQ2lB?=
 =?utf-8?B?TUxYRWFwK2NFQUdtemYvRWZ0Rk5zaGtOY09pR1NWWk9KU1l0d1Q1WDZiekl6?=
 =?utf-8?B?R3FOYmp1VW5oTmpmeG5SVTI1cWFlbitGVHRJU1NIdlpqV0hIWms1V1hiYk9Z?=
 =?utf-8?B?OHR5Sm8rM3BCL3FFY3hmN2pRWHY1OXBwc3NxOGd4SHBWc2c3TFBWdExlTmg1?=
 =?utf-8?B?SWhmSlpQR1VuSXY1ZWFxRjFFbUg4R1ptaXZKUzJVcXp3NDF1bTFnUXJwdVd5?=
 =?utf-8?B?K3ludHJEU2trdENJOS9XYUdxa25oY0I5NFNwN0FmK2hsaXhDVzNxOE9hQmlN?=
 =?utf-8?B?M0ZSVnJ1SWVVZkVKbGVNNjdlZDBsRXhiQW9ZR1hHQmROTTlva2V0SWxWOTFk?=
 =?utf-8?B?UmRsejg1Q2tJSnVGTU5pWko0YktpTUxwWkI5WG9QMGF0b1pvcUxtMmZFbzMy?=
 =?utf-8?B?c2owUVd1U1JLQ0RVUHpqWWpPOWJWRGdKSk4zdjF4NFJySm9zNWlCZDRFSUty?=
 =?utf-8?B?aXo2eXBJQ1p2anVQL1dhOGR5bXFJcHRoS3l5SWVKRGZmdnErZVc1bk45Zk5h?=
 =?utf-8?B?czNxSTVzbVIxQ1BEbGJjR2w4NVBHNUQ5Z3FhZzVCNFhmUE9MVTJtVFlhUndz?=
 =?utf-8?B?SXJ2Ymd5Uk5JMUxzckRjMnNGOXQ1RFpPSE1hSEJQQTlHQkNsQ2IvTnh1cnBh?=
 =?utf-8?B?SnJvVHgxSm9neWJIKzdNbklOSXlSUytSNkxDZmlHWGptczVVK1VJL0c1OXdL?=
 =?utf-8?B?UFhOZ24xSnRvVFVpeG1FT0Z5TWdGWEhsS05ReW1mN3UwOC8rOXNxbEx3U3Y2?=
 =?utf-8?B?MmdPendoWDVqR0pNTHZ3VzJ0STFvSlVRZm9RMVVFMFpIQ21NL2VNeEkyV1dr?=
 =?utf-8?B?K1gvZDczNHQ4NkJtL3JKS3l1d21pZnFrc0xEUmcvVzRXMDlONmZseUhTTzdF?=
 =?utf-8?B?dGVuR0tSNlFlWVV6K29kOEpVUkxqbEFsK2hiRmJJL0M3QkNyWDZZdUpjVlZw?=
 =?utf-8?B?b2VRTUhTRTFSc1RTUCtFWjRQOHljQVhKTUhta3MrajgwM3Q3RFlsTXpZSW1N?=
 =?utf-8?B?clRrdUhJTWxiQzhYYWo3YWo0amNCdm4vRjNKRTVOVitHKzA5alEyV2Y2SkVD?=
 =?utf-8?B?RFdjNDJtYmNiUHlPWEo5TXNXQkw4M21Ca2psZkRZMzAxbWYyS1NKS3h3M2tS?=
 =?utf-8?B?dEZxNUxNVHFTTTVtNWd1TTNLSUc3Ujk1aUMrTGJJL3ZPYU43Nm80ak50QnZt?=
 =?utf-8?B?ZzhMVnEwS0pIMVFSWUNJZm1kMkVXWmU0Y0lpUFBCYXNGS25XVE93SmI5TWRN?=
 =?utf-8?B?NDhoRUFLNFRxeFFld1dSakIzWERQdEtPN2dwc1I1SkxHRm96dmVmRHhzQTVG?=
 =?utf-8?B?NkI3ckpaSDN1RHR5S2xTOTdGQU5PSmVSZExCRTJpQnVKaDhUdytMQ2doenBq?=
 =?utf-8?B?L2t2MDlpN2FJeVlhNmZkYnp6STVzWElMeEgrbURYRjY5NnZucUlNbW1CcUgx?=
 =?utf-8?B?UUNMcmNxK21EOVFyQjM2cWE3dFhOT0t5R21IY2x4Yld2UllzNnNTNDhyZVJN?=
 =?utf-8?B?NTRMOXMxcmJPditTSjc3dzdrSHczSmR5Q0lKeVBoNm00SWdhUnJhaEhMR0hw?=
 =?utf-8?B?ay9GZjQwQWd3OEZqOWRZRWlqeVNMaVdWcUwzaVFrT3lMenBKN1N5YlJ4ZVd2?=
 =?utf-8?B?dC9PbUwwTE15bDl1T0VHQmNmOUlyeEQ0dnFDVFk5WDE3NGp5ZU1aYTV2akF0?=
 =?utf-8?B?STk3YjRZVStUWnplLzBOV0ozbkEvQ0tzL2ZpYk5XWUFFa3R1d2VaTEh0Mjl1?=
 =?utf-8?B?Z1IrSVhvdnExVWMzai92bk1LYVNZa0t2Vko2ck1rdUNaSlRWanUrczc4S0pi?=
 =?utf-8?B?TFRySEdKWHJFVUZFS2hlSzN6dHVkUHA3UWlUYStFOVpOcXZoU0NkbmQwbWdn?=
 =?utf-8?B?ZHpUQUNkM3ZqcUk4aWxWS3BLdzRTR3pLZm85bzNVb1E1eHpPYitmZjNQRktK?=
 =?utf-8?B?T3d2U1Q2cTNOQW13QWZjSlFUbVFvUDJ0SUNraktPb0dyNStGM0ZTNVBrU2dk?=
 =?utf-8?Q?ITuKDtgW3T8hsv8o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea692f9-624f-4e77-52a8-08df23b1f6ac
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:56.5657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhLB2EFTgu9miV63JVj4BuvEDX96hv09pX89ypCCaPH/kVUaaPU4Gt6hLOKQFDwuvNQ4slJTM6QlbxNwknJmqqwsRk802TTh6O1jVol5EeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

As of now, there's no way for the cleanup path to be reached with
vq->dev uninitialized.  However after a subsequent patch adding CPR
support for vhost-vsock this'll become a possibility, so let's prevent
such a crash beforehand.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99561ac5868..dfdfd49da3f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1661,7 +1661,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }

-- 
2.47.1


