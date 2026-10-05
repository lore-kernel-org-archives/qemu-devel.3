Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0026DCA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCn-0000JY-3R; Mon, 05 Oct 2026 11:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCd-0008VH-Fa
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:02:08 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCb-00056n-0y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:02:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyE6a4rc8mbnnjDFz0uQlGMFdr5v22sAtdxixH7rZ8wClAZ7uFCsvuEM9sSj39flxwftv6dfmF9IIJcHNggDTQ16ahjyol/fs75cRqaUukWfJHBimh0IAfn22OUklBnavbr0jQ+VoWGUCf0KNGxXwjWyrtGBLTIoKtHc7nr2Y5UoEsoFwiMNHmZTozPuEVMzY4lTfs+66VUMeFJA3fQkAB4lR0Cx5X/c2W1drcTTbuUVA/OFao/8EY68tJYA/8ocAwktQpkP3OTgJaKjlUJXQhpNA4D7QKBnkLQBLEBDOOufKuzFbzBB4G2w93m2nqhP5/IJQ1tnH0M9HRKgTNUFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=Y/rrd8aQYHAOkwKOc46c1hLtJBdjigjLocGbJnTdksYIiHiwwsEeUh5I5cucSz/zPQzXQR53fh1kT4p/IJ0ZpByIZsqr/0jMaIABVUeYWUNGroD4ziOSqsBA7cl+neczws3inN9Yo0A4DAYJM1xd8lPZpuGUNTV9axB4+919MrXSigBdfMbTU/jZqMkZs+z7lNW7NiVAXVdTspgnJNUGsntTThJXxO9ye6Z8ttUdYsXlEdFgsBufPVSD7Px4WcRUjOaCrC/FUGWA1SL+qURGjj7pWDPvk++54GyVrS2k8HGFG+VN7haPQAuFgB+yvcNbsTcrPQY8if1a6cHSIgudXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=AhCDfRYgPJTw99yJPn0zo2DOqLkLLqxS2uMxWZSp4yEBs+VOaF3ulKVEAs366lHygI9o8vWhP24jb8Lh8jAiJrXzgVR0kQ0AUeOzXbl2MtKoCc4pkw671Dyom1BGJ/YH7VuejrIUJJvCJItP0ZfKocy3S8bFqyq+KBppxhL6DWaLOgcbrmpoWbLDETQH/3JHEEMvanKH9LXLFy6CA8uqIrZUhBxb2DLAdyj1A+9cX7s9IVVpZN88roxiHTaB17OeGOYWbf6aaSfu9xAiG4MBexDpo4D3ElDtQcJt1tejpvQhA1dkBYEbRyrFhHfM7iDU4l+r3bhqOZiZe5xKZEo6ow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:29 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:59 +0300
Subject: [PATCH v12 20/21] tests/functional: add vhost-vsock CPR test with
 a live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-20-40162390c68a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 615efbc5-4123-493f-11c0-08df22f1893d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|260925022911599003|10067099003|3023799007|56012099006|260925021311599003|22082099003|260925021911599003|18002099003;
X-Microsoft-Antispam-Message-Info: z53klGEYfmK1ohOBzx0tNPL3wIV0SSDe9W2sFlVYuo4Pij+UKjdh30FUF3S7wXCzNXT20FSIizSrAsHBp02b3KD8vUpGuiEEuF9ou05Yk3groNBNo8Cl3oJveCqwUi+4LN6N949TAlvfYw3gG2R9TO/nN7nBNi4HhwGGub7Mna3SRYM8II/IFLhwZnHQDO0ZTpOQCb0lNEk9xxb++5aXDsz6Wldcttyyu3etC8Cvty+XEJ0vXOBqBwNAacHpSGImc5wmU1i0Y6f+vwrdNTDcWV38RKi+i//MgragwuKVlfOx1jfqCc1Ak7AgbJJ+b1SgFf63EOwNf/ISLqN1QvJNY+w+NlSn0aD4pQa54s4i/d1hgcVi9sup/4pq47czVSw+NyneYv4bSb9ZcD2kPohEeiMP/i3V6hw26AZWAR1C9GyW1srUQhkgiGljamJLiqjXG2+2gAUzUdgt/34i9JMmd9s8/QoVmBoBDSraeJMwHKoRBryaThQ48WBG0HyXF6zsn6CycNirLFKshyYzVvCutKS9FNVtuJcZYPdEHMVT2jngn98ya7kL/Ap0axxnIhxGjLetNdU1cUiaPeKG0ek8pLVZ1KyeUNKPkcQiVw9dkgmtkAVrOOC+nGkNzjOO0l+R2yRuklAKAry1LEdx432HUG+fxcuzmATbZJqtxFR215npbW7ECXDaqCimoCP+xDxVzPT+s5sksfJbcpUOqZ0OHg2SH0diTpSAAfQ3JHLP9/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(260925022911599003)(10067099003)(3023799007)(56012099006)(260925021311599003)(22082099003)(260925021911599003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lrRmxVUXNvREZ3VG1vd24rVkI0Q3hWRFdpL2Ztdnovak9OODBkaThhQWNN?=
 =?utf-8?B?Szd1ZXdEN291am00TzFaRmRvRzRsbWtJNnYvOUJhMmZKZ21tK0pRYlFwNnJw?=
 =?utf-8?B?Q3hNUk8rK2Zpa0NQRTIvSjJZM1V2MFA3cVVSTUR2a29nc1pwbGVoRHZQUUht?=
 =?utf-8?B?a0xTK3diOC9aem5sb3hZeFlyblpqVm14Z1dnZDF4cjBTa05DWiswYWdHcHI3?=
 =?utf-8?B?Y3I1c0FqWEtyU29zdXFoakN2L3lPUHpnQnBTK09Nak0wRzVlTXM1enVnb09T?=
 =?utf-8?B?ZG1JRlF1TG8vUm5lNEo5RnpqTzlvSnpmbHlpN0FWcWF5YnhDS3pGYytDeDlw?=
 =?utf-8?B?TzdIV0ozTDh3ZFVCMkdLRjVwV2hNQUZOODhEU0gyK2Jac0duL3hDMWZjMnVF?=
 =?utf-8?B?cmZWdFVwWTM5Ukdja2VuVHY3WnJLcFlCWFlGcWxiaUdsQ2JOU1JMSGNwd04v?=
 =?utf-8?B?OFk2T0NQK0tzU2xiNU9NS1BwVTd6akxSeVJZcE5EYUFRVFdlOVZXbDJwV2dp?=
 =?utf-8?B?ZEVodTFKNzNDcE5Dei8zVi9aZG0rQmkrcTBHNVZEY0dFMjNiWnJBTzBjeWUz?=
 =?utf-8?B?aTRsWk9pNnVwRFZEMEpTc3VPd3JLSHRMWmJlS245LzJXbkY4WHlxM1NCSkdt?=
 =?utf-8?B?SXRsRG14MDZBS0lFUUFuNUlMMk9nak8yNTBJYTNOdDZ4SmlaYndHN3RNNW9h?=
 =?utf-8?B?aXhlZW1YSW8wUWhwL2ZvelRYMDdoV1ZBeG9VTEJrQTk0ZitFVVYvaUJkVnFn?=
 =?utf-8?B?OHBqVHUrVXhIdnhYYjBsWTkvblJ6UlRxVzhZaHNoK3Z1Q0habVNITFZDVTN0?=
 =?utf-8?B?alN2WWh4MmRoK1hGM3VXUnpxMmpjWTJVV2llK0kzZ2M0bTRVcHdWTTBSMFcw?=
 =?utf-8?B?cVNhWlNNa2tQdzUrZGRaV3pZRklUaCtyZHlzQitDRG9qL1ZCRm42UHhGeXRE?=
 =?utf-8?B?aW4yRXRYTkhTWktRbWRsYmc2REZnZXVwU1ZrbGdwZ0dMT2EwcS9KUkdORndD?=
 =?utf-8?B?TnpZSXBkenZuZExVWDVuVm1rU2FJVVRqMktCVnJnNjVhMytNREtMdmdBVXNT?=
 =?utf-8?B?NWowWEtSZjEzb2laWkZJaFM3Y3V3emVMOExkZXJybkhRK0ZVYVBhbXY4eXAz?=
 =?utf-8?B?RzFOWE9lYWphOHBzc1BRMGFZblhwTHNtM1RjenAxREp1TE9OUEFDSnhHOHJ1?=
 =?utf-8?B?M0ZEUlVIY1NqK05EMmFjYmJLREFXdUxvanllcEtlTHdaQ1dTNnhRak1zSG9W?=
 =?utf-8?B?YXgzR2VaZWdsbWt3V2dCWWtHbUhseUQrRUZVU3RaSGtqOWozWlRuQ2lOV3FV?=
 =?utf-8?B?RjRxNlVRd2xoSWZnaXdDeGRwcW9UeHR2L1orZGxRbWFnejF2UURGMUMxbFpC?=
 =?utf-8?B?dnlsS1BJelczdnlNcUttUnBISDZsYUptYVU0RHJmMnBQSUtvYWg0M05XNi9k?=
 =?utf-8?B?V2hHbVpxVzRLaWh3SmVGcXdYZnNxY0FwejFDQ2pLYUZadGdPU0xhTHBmTVpi?=
 =?utf-8?B?aDBWTnlMR2ZWMFJvaWNIQ0ZpNTJjTmFmMndpVUJLZjJQb3J3UXFSM2I5K3ov?=
 =?utf-8?B?YlQ2US94SDV3cUJBOW5qN25NcTJwOE0rNjZMdEMwTWlXcHhqWkJJVXdTL0RX?=
 =?utf-8?B?Zzk5VzZKanM5aGluUHhCQUpSVXdpMlRBTy9Db2c4dFc1MTVnL3FBaHZYMitO?=
 =?utf-8?B?K01tRXA2ZUhqWjlVWFhDdXVzNGxnc0NhM0x2TnFSZkRPcEpxeDlIbWpsRkJO?=
 =?utf-8?B?cG43SFBES0pJeTB1cmFkbTFad1E2WmJ1a3hnSHpBbmdkN0NDSHNFcmRkZ29L?=
 =?utf-8?B?TWtQVEVMN3RVOHo2ZkFqaEM0NUFhL0xTb08wWXJKUjNpV0YxUWQ2QiszNGMz?=
 =?utf-8?B?SnlqM2xGcU9qdDVzTjJ5dmg3Nzd4R2dlRHd3SDlLMWVIWm9CSW1QZXZpMk56?=
 =?utf-8?B?SjQwUUxqZmQ2SGtxR1puUVIzeUFmaCtNL00zbmVkZU1VaGxISFZ5SytWcnI2?=
 =?utf-8?B?UUhLckoyK1ZIeU40b0Vid1A0clNIN280R2F3b3JPWlQ3eEVPRnF4dHhFSXpn?=
 =?utf-8?B?andwV1lYd0taVmZKV2ROMDMyMStQWUljNXZxQTNBdVZpN1BveVFLNmFvZThZ?=
 =?utf-8?B?QlM4T3owcGFmK3piWk5pZmZOVTFOWncyVUVXMkMrM0ZZY29zYTRvM0IrMFJX?=
 =?utf-8?B?VmJjTzhtK014a0JIY0hKVW9lbUp1WDJFc1gvWXFNMGZ4Z29iNmVQcVAvWXZj?=
 =?utf-8?B?Z1REV3l0N09nVFdmMnVteEg3cDROeHVKUUdYc3lqUGFIOEFCemVFN3lFYXZr?=
 =?utf-8?B?S1lNTEU3TmNlcEM2Y1RmQmhYekR1TDQrL0hQRm45TEUrOHE2V25DaDFVOHhM?=
 =?utf-8?Q?3MPPdBVLQbjEU6/s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615efbc5-4123-493f-11c0-08df22f1893d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:29.5785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2sMCy6vloOfiyPtHOsBQFblhQCKSG28JlNerq4VqXcvlz0J+ia3YPqpqQ33LZsQpcGnx75+fhQyE4O1rIKofShCJAX/XcPq1cvsfEfaMUI=
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

The qtests only cover the QEMU side of the vhost-vsock handoff.  Add a
functional test which runs an actual host<->guest vsock transfer across
a series of CPR migrations, for both cpr-transfer and cpr-exec:

  - the guest is booted on top of a qcow2 overlay shared by all the QEMU
    instances it goes through;

  - the host sends a 512M file of random data to the guest with socat,
    where it's stored on disk, then gets it back the same way; a CPR
    migration is performed every 0.2s while a transfer is in progress;

  - with cpr-transfer each migration starts a fresh target QEMU and
    retires the source; with cpr-exec the same process is re-exec'ed
    over and over;

  - the file received back must be identical to the one sent, and both
    socat instances in the guest must exit cleanly.

The test needs KVM, socat and /dev/vhost-vsock on the host, and a kernel
supporting VHOST_RESET_OWNER for vhost-vsock.  If any of those
requirements are missing the test is skipped.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 2 files changed, 247 insertions(+)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e1..718bdc5195c 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -7,6 +7,7 @@ test_x86_64_timeouts = {
   'netdev_ethtool' : 180,
   'replay' : 480,
   'virtio_balloon': 120,
+  'vhost_vsock_cpr': 300,
 }
 
 tests_x86_64_system_quick = [
@@ -51,4 +52,5 @@ tests_x86_64_system_thorough = [
   'virtio_balloon',
   'virtio_gpu',
   'rebuild_vmfd',
+  'vhost_vsock_cpr',
 ]
diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
new file mode 100755
index 00000000000..035307fc82f
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+#
+# Functional test for vhost-vsock over CPR (cpr-transfer and cpr-exec):
+# a host<->guest vsock transfer must survive repeated CPR migrations, in
+# either direction.
+#
+# Copyright (c) 2026 Virtuozzo International GmbH.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import fcntl
+import filecmp
+import os
+import subprocess
+import time
+
+from qemu.qmp import ConnectError, ExecInterruptedError
+from qemu.qmp.legacy import QEMUMonitorProtocol
+from qemu_test import (Asset, LinuxKernelTest, exec_command,
+                       exec_command_and_wait_for_pattern, get_qemu_img,
+                       skipIfMissingCommands)
+
+GUEST_CID = 4000000010    # we expect this CID to be free on the host
+VSOCK_PORT = 5000
+
+TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CPR_INTERVAL = 0.2                   # interval between CPR ops
+
+VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
+VHOST_RESET_OWNER = 0xAF02    # _IO(VHOST_VIRTIO, 0x02)
+
+# What a QMP connection raises when its QEMU goes away underneath it
+QMP_GONE = (OSError, EOFError, ConnectError, ExecInterruptedError)
+
+
+@skipIfMissingCommands('socat')
+class VhostVsockCPR(LinuxKernelTest):
+    # This should have passwordless root login, vsock support + socat
+    ASSET_DISKIMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-nocloud-amd64-20231210-1590.qcow2'),
+        'b94e3f34db59988a815b33dffc24f5a58502540efece2cc1ed15e0ac8749bb2e')
+
+    def require_vhost_vsock_cpr(self):
+        try:
+            fd = os.open('/dev/vhost-vsock', os.O_RDWR)
+        except OSError:
+            self.skipTest('/dev/vhost-vsock is not available')
+        try:
+            for name, request in (('VHOST_SET_OWNER', VHOST_SET_OWNER),
+                                  ('VHOST_RESET_OWNER', VHOST_RESET_OWNER)):
+                try:
+                    fcntl.ioctl(fd, request)
+                except OSError:
+                    self.skipTest(f'{name} is not supported for vhost-vsock')
+        finally:
+            os.close(fd)
+
+    def setUp(self):
+        super().setUp()
+        self.require_accelerator('kvm')
+        self.require_device('vhost-vsock-pci')
+        self.require_vhost_vsock_cpr()
+        self.set_machine('q35')
+
+        # Use Debian cloud image as a backing.  During host<->guest
+        # transfer the guest will write data to its disk, so we start
+        # it with an overlay
+        self.disk = self.scratch_file('disk.qcow2')
+        subprocess.check_call([get_qemu_img(self), 'create', '-q', '-f',
+                               'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
+                               '-F', 'qcow2', self.disk])
+
+        self.payload = self.scratch_file('payload')
+        with open(self.payload, 'wb') as f:
+            for _ in range(TRANSFER_SIZE >> 20):
+                f.write(os.urandom(1 << 20))
+
+        self.sock_dir = self.socket_dir().name
+        self.cpr_count = 0
+
+        self.guest = None
+        self.qmp_path = None
+
+    def prepare_vm(self, vm, name, *extra_args):
+        # We don't want QEMUMachine.launch() set up QMP for us.  In this
+        # case launch() waits for greeting - which won't be sent cause
+        # CPR target is reading CPR migration channel before QMP
+        qmp_path = os.path.join(self.sock_dir, f'{name}-qmp.sock')
+        vm.set_qmp_monitor(False)
+        vm.set_console()
+        vm.add_args('-accel', 'kvm', '-m', '1G',
+                    '-object', 'memory-backend-memfd,id=ram,share=on,size=1G',
+                    '-machine', 'memory-backend=ram,aux-ram-share=on',
+                    '-drive', f'file={self.disk},if=none,id=disk,format=qcow2',
+                    '-device', 'virtio-blk-pci,drive=disk',
+                    '-device', f'vhost-vsock-pci,guest-cid={GUEST_CID}',
+                    '-qmp', f'unix:{qmp_path},server=on,wait=off',
+                    *extra_args)
+        return qmp_path
+
+    def wait_for(self, what, cond, timeout=60):
+        """Poll cond() until it returns something true, and return that"""
+        deadline = time.monotonic() + timeout
+        while True:
+            value = cond()
+            if value:
+                return value
+            self.assertLess(time.monotonic(), deadline,
+                            f'timed out waiting for {what}')
+            time.sleep(0.2)
+
+    def qmp_connect(self, qmp_path):
+        """Connect to a QEMU which may still be starting up"""
+        def attempt():
+            try:
+                qmp = QEMUMonitorProtocol(qmp_path)
+                qmp.connect()
+                return qmp
+            except (OSError, ConnectError):
+                return None
+        return self.wait_for('QMP to come up', attempt)
+
+    def wait_migration(self, qmp):
+        def completed():
+            status = qmp.cmd('query-migrate').get('status')
+            self.assertNotEqual(status, 'failed', 'migration failed')
+            return status == 'completed'
+        self.wait_for('migration completion', completed)
+
+    def wait_running(self, qmp_path):
+        # Make sure we're dealing with the new QEMU after CPR
+        while True:
+            try:
+                with self.qmp_connect(qmp_path) as qmp:
+                    self.wait_for('the VM to resume', lambda: qmp.cmd(
+                        'query-status')['status'] == 'running')
+                return
+            except QMP_GONE:
+                pass
+
+    def boot(self):
+        self.guest = self.vm
+        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.guest.launch()
+        self.wait_for_console_pattern('login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
+
+    def transfer(self, guest_cmd, host_cmd, cpr):
+        """
+        Run a socat transfer between the guest and the host, and keep
+        performing CPR migrations as long as it's in progress
+        """
+        exec_command(self, f'{guest_cmd} &', vm=self.guest)
+        with subprocess.Popen(host_cmd) as socat:
+            while socat.poll() is None:
+                time.sleep(CPR_INTERVAL)
+                cpr()
+        self.assertEqual(socat.returncode, 0, 'host socat failed')
+        exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
+                                          'RC_0', vm=self.guest)
+
+    def transfer_both_ways(self, cpr):
+        """
+        Send the payload to a file on the guest's disk, get it back into
+        another file on the host, then compare.
+        """
+        echo = self.scratch_file('echo')
+        connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
+
+        self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
+                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+        self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
+                      ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
+
+        self.log.info('%d CPR migrations performed', self.cpr_count)
+        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+                        'the data came back different')
+
+    def test_cpr_transfer(self):
+        """
+        Perform consecutive cpr-transfer migrations during vsock file
+        transfer, starting a new QEMU instance on each one, migrating into
+        it and shutting down the source
+        """
+        def cpr():
+            n = self.cpr_count
+            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
+            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
+            target = self.get_vm(name=f'target{n}')
+            target_qmp_path = self.prepare_vm(
+                target, f'target{n}',
+                '-incoming', f'unix:{mig_sock}',
+                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                             f'addr.path={cpr_sock}')
+
+            # The target listens on the CPR channel: wait for it to be there
+            target.launch()
+            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+
+            with self.qmp_connect(self.qmp_path) as qmp:
+                qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+                qmp.cmd('migrate', channels=[
+                    {'channel-type': 'main',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': mig_sock}},
+                    {'channel-type': 'cpr',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': cpr_sock}}])
+                self.wait_migration(qmp)
+            self.wait_running(target_qmp_path)
+
+            self.guest.shutdown()
+            self.guest, self.qmp_path = target, target_qmp_path
+            self.cpr_count += 1
+
+        self.boot()
+        self.transfer_both_ways(cpr)
+
+    def test_cpr_exec(self):
+        """
+        Perform consecutive cpr-exec migration during vsock file transfer,
+        saving devices' state to a file
+        """
+        state = self.scratch_file('cpr.state')
+
+        def cpr():
+            try:
+                with self.qmp_connect(self.qmp_path) as qmp:
+                    qmp.cmd('migrate-set-parameters', **{
+                        'mode': 'cpr-exec', 'cpr-exec-command': exec_cmd})
+                    qmp.cmd('migrate', uri=f'file:{state}')
+                    self.wait_migration(qmp)
+            except QMP_GONE:
+                pass
+            self.wait_running(self.qmp_path)
+            self.cpr_count += 1
+
+        self.boot()
+        exec_cmd = [*self.guest._qemu_full_args, '-incoming', f'file:{state}']
+        self.transfer_both_ways(cpr)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()

-- 
2.47.1


