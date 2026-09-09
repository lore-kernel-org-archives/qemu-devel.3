Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C67C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Lf8-0000eg-0E; Wed, 09 Sep 2026 13:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4Lf0-0000du-BC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:00:35 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4Ley-0002mq-Kf
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3eZv0sPmldVwr77usSGHT3CGDYxmEM8AAwQfHYmOMn/s8nmJBxyZX9LtlFgMeDz/x/er97Zlsv3mVruLlVDXzYel9u/1WcwZOa52h9FkIPQicaiY6vcisvJaDtzBWSP0xyHXDIJXRAmCFP48xV+SzYxt4qp7QrhKG/FKS5FPfYfm4QRMWO05oj2iObRQyDEBnEobSgl/Z8znjD9SDN5rWns6GuAsoQGqB8R2wCJbDvYsPCh458oZHREYaZCtwnEvXemHpJnuRtYqKpgMjwAHsa2ofA1EIUiWxzXv0b81++1p0W4r9JjL0B9jZqWU2YzV/DWbCzxyaL+eLkQRmxoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3T1Gw3JsOOqn/NNB8+okcnwSuZ/cJ77K1VbD/vRfog=;
 b=JIYRfSQ/4uzoziC7RhsaKgGdaQ5ukVaErQZpqkk1ykqncjI6Mjm1i9AdsKMKLx5LNy2r5PaEViz/+ytLQKJ+mMfOOqSW3javhm9Z8sTjzkiScJpjokb090C9ErQSlB8ItXEZRRI6FckFKb5wXPIprMlLotkEiwisjrRyGiUamz/HQ8ZiYuXH9ByHx3tnk6+v2++fYoiqahfBD1lhWFEi6l/efc6Ppnlb0V6ccWvlmr3vNFZT3XF3Il1nVu2p0MMUbHYknNZEONhSOhGl/sdd6ybr/BSXA8KVjAvGbwTUIzEvEw6zYl8y8Kkh7/wRAUpSlZziZmnnSo388YHRZCaYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3T1Gw3JsOOqn/NNB8+okcnwSuZ/cJ77K1VbD/vRfog=;
 b=kBUaupN3ln6LUn18z4a7L7hP2odxtznLOubkNTLB8apXMFwFN2hG2ilZmfA/PoiloT7f9J1XYV0/qzjF6+Ye7Xd2u26Z2wxyKa8o95gqDhaTPE5UFU3jcuSPYAZ0Vap8BmQ1AAQrhHGsPMjl2jVAcoZWHMjV+1l4T+bgqqitCLCOIVa+QoyXy3jrSJhOt73Rogo23GCNUTHuX+1Ieu1IO3SM2rCeVMiqzfo473BNksB/EaGFZQtfsGC+69zDpOuBp/9xcztxvuXT7P3O0ehQoYjsifv9fo0AISrt0E23W/BVUlyPCF6yglojMuKQ6oI5Rm/bz9Qf59FWV9rcAlVqZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5976.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:59:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:59:53 +0000
Message-ID: <6828f675-0950-47fc-9f07-93ade8d71558@virtuozzo.com>
Date: Wed, 9 Sep 2026 19:59:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] vhost-vsock: fix FD leak in realize()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-5-andrey.drobyshev@virtuozzo.com>
 <ap7Eg7mTIcI97y-z@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ap7Eg7mTIcI97y-z@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4fed3d-e95d-4757-ddd7-08df0e93c47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i5iRhnEcGosRwu2zF0bUArtSA6fX/M7PdNpT4g/EF8WbXPV62vcb9VKwNZgCt+axTfAjOt2oZP5vGfoy08+EgZJBA9bmUGeJPxQA02mkrzrZYLrh4rclxc/sWwwM0DUNLh0ry4hS/h3NrMU7DcyPiFJ0QMDESy9ocKV5GAZpf+2DcsRwtaQUv6Ps5Vh85COpa7XWWbNptw2gt/Qx38cDy3xgr/CH1wama3QnPkDw6Rg7khqpHP8PcycVx7gVoWCbHC51AGtzrk9WMW0ZZneW/WXuyjOUwgUWsW2xvntYxqvLBqYrGL5BfTy9kIkCRTy/2xPOT2OY+qFwtBoYdz2falWeptrZLK1797Vi5OQKuVTT7pGDtUlJBh6WlxpagusixZB3ErrcVvGOmapLMvvwyuF41sX3k/X3MRugvgeK7th2DcKvpB/5gZkmfLeGQWwGNXKh93jqMqTNmNy9pLVPybbALis5X05mf1nq97nV7SlRZQY7DIGZFw05HGDw0EmaXlnCzC75LQB7Vm05QqcoeAfHy8VojFfSFXKc8+kCEcZU5+RBjDGQTQWIzeVQo1cxLCFFDu5J4JtnQIJFhCoEWDanMmcErem8F2+YeRW+ScLjYkYpTu/opIkUoIxEHaGaVaxOSZmoyp3qlHSGNaot5hiqlP03VnDNerrFb9ewL6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjNRaDVRMmwxcXpKbVVtU2ZiR0xUK0lVYkxKREJRMTBSMDY5L2RyMVNyUGpO?=
 =?utf-8?B?eVkxTGU5dEN4SHBOSjFkemdNeFZ4djlCZ0dzL3FBcVRZRWFIU2NnQmkxNFAw?=
 =?utf-8?B?cm85N1FmUVpJL0tMYXRxdkZXQXNqcjNUY0NzV3U3S2VyNXVxcE5SQnNnQng3?=
 =?utf-8?B?UUo1bEYrckdnaFJNbUcrckpNWUVHY05ZK0xCWjVjb0c5SUpweXhkZUwwdmxq?=
 =?utf-8?B?RkpzTjUyZDJldnZnc2tESmtMTWVxWm4xWG5BOG1zV0NLWU1HRHM0SWllcC9U?=
 =?utf-8?B?MGI4UnJKRlM1bWtUQ0hVVDRIOU1ZMnR3OVE4NzUwS2oxZVp3bmhDc21lZFp2?=
 =?utf-8?B?ZHlHM1hneTcxbUg2NkE0d1JtdVRiamlEbVIrM1BYZHBVdEtuVWUydS94cStm?=
 =?utf-8?B?Tjk2dUMvRVRYT0xtZnZZWFVKYit2U0RabkgyNHNubkpVemVBK0oxOEJ0MEM0?=
 =?utf-8?B?R0gwQkJIaUVxcEVheUxxUkNLZ0p3bzh6UEdpUmdXWWpkUk1DYmsvZmE4Q3FH?=
 =?utf-8?B?M001SWVhZDdneFFncVMvcnIwWVFlbFVVOUR2T0NCaXFnT3lKZTFDSVcrV1Bh?=
 =?utf-8?B?MWFSU3ZIMVlsZHFMZzY4MnVtbmxNdEpKQ2xER3JPNGR1aUtEME16eFBLbUQ3?=
 =?utf-8?B?aitsT01rU2tTdFlYcVhpdDZUb3NKMDE0cmpMa2xPbkJlUnNkSjVDQjY1aDlB?=
 =?utf-8?B?V2k5MDVwcTQxNWFGWXRjL3gxT3ljNXRyZEJzZnZvWE1hdlFJOEd0TnFNaThN?=
 =?utf-8?B?VG01S1hFTEwyVnlGWDliQlE0SEVLQVQ4L0NSRjJzY2NTU083NmdraVZ6Z2JF?=
 =?utf-8?B?NEJCazlMRDg4MGI1K043WmVUU21vSnJHQVJUaWVNclB3V3RtMlFJVWFveVhW?=
 =?utf-8?B?bnhSR0FOck9YZGFNV0Fja245MWsyM2VEaFd5TGRlSzJENENnVEIvZ2FaZk9N?=
 =?utf-8?B?V3RDMTlVaVRKMTNlclE2U3hEN1NrYmVhYTQ4eE9NckNCQzBTSVEybG1DRENl?=
 =?utf-8?B?bDIrWk96R0hNSWVyTy93RFYyL1BBdnpZZDFXV3ZoZUFIK1FQakJnUTcxT3hq?=
 =?utf-8?B?RS8rTVJZY2JxUnF0VTZ0M2hkV1Z5ZG4wbm1QTktWaCtSK0dZL0trcjVoNGtF?=
 =?utf-8?B?L01nUnRob212bjlDTWRqUUkrUVJteEhRa2xURGpVQXdydTdGZXNGTms3SGZt?=
 =?utf-8?B?dFJtaVpMMzRwUm9BMnFRYzFPY2VWckpzU205MHZySkl0bEVQSW9aakdreEha?=
 =?utf-8?B?ZXlrKzdCVERLaktFUHBGa1o0S2VkSE8xQno0RWNiWVJwbmFtV21CY01mMUEy?=
 =?utf-8?B?Nzc0cXZ0WElmL0NBRkRyVzJUcHBnMkhURjBlNVZrdjNpZkhCam1BZ2xYOTk3?=
 =?utf-8?B?emRpM05VdEt4TERxVFJBMWZ2dmVMSlh6QTBlRW5sYW9JT1RwcXFRTXpaRWtH?=
 =?utf-8?B?UGZlOGJmajJ5UXBNOFFyeDJkN0IrR2FKWGRRRzJ1WXZMN3pNMkxHeHNoQXZ2?=
 =?utf-8?B?SDVNWE1KcENmN0JsemNpMUFYcHliNkRNQmIxRTJSdlptcWptRXNPNkJ0blkx?=
 =?utf-8?B?RDZGZkEyeFNhUFdtcVk4NDkvN1pXTnBHTTI0QW1RUG4ybEpTTVZ0aWorbUFE?=
 =?utf-8?B?U2lMbERlYmJhYWFRNVJIc011OG8vbUxFM01WdHp2TDh2Nm84cTNnWjRkZW01?=
 =?utf-8?B?U2MwNERTdGVSS2dqYWNXMTB1M1dNdkJRbktmbk1IVHIrSnZ0d0ZxL1hTcERt?=
 =?utf-8?B?bXhkNlBITVRDMVJXdHlTQ2dHT3JKQ2Z6MmxSM0wyTndIeFFSNFNzOTZkWmhM?=
 =?utf-8?B?NGdHSXFXMFA0QTg5YjNMVHQ2MGZGZ1cxekl6WitDd2dKUnJuT0JLbDFnei92?=
 =?utf-8?B?RVBGMEFKRklYeFVoQlFocGhmeFRrakRhWVdHYlJJOHBnQkY3Nlh6WGh5dkl4?=
 =?utf-8?B?dVRXc1Rtc2lPUk5rc1d4K21ucXZlNTNDcUlpTWVMM2Q2QllJYWRtYkpYTXZJ?=
 =?utf-8?B?MjdMUGRDUkZnQWV5UzB1RTRUWmNZNm1PNGMreVExU1dXcHgxb1hvekEzclhT?=
 =?utf-8?B?aXdZRzFFWDdTRitNb01xbnhRTVZwQXR4TmtFK0E5L3NiaFRzWm5EV2t3b0Iz?=
 =?utf-8?B?bEpxdjRjdGNZSzVXaW9YZDZqSWxWMDNoRFI4aXIxYjBUM3NOaCt5dWJsV0Jr?=
 =?utf-8?B?SlMrdXFaRC9rZytINm9TR1pkcklQUFFhbW54T01mWko0SDNmWWptQzNPSFhn?=
 =?utf-8?B?MzVVRjFPd0dVVUNHTkkwdHN3eXhNd2pidW5pcThTUUpiN0xFUFBzekU0SVF6?=
 =?utf-8?B?UzFsMEtCZHlwUi9RWVdCL2tDcmdqRWxtakxVVExjUFRhS0hyL09ydE0xQW5H?=
 =?utf-8?Q?yppoJ2BJxvtcZTqs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4fed3d-e95d-4757-ddd7-08df0e93c47e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:59:53.0337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Go7mE64PFfArmTaK4bXXDKu2yZgeGf+HHDJyVP990ryQfbTqI/ptG6TUTYtJINFDlmg8xTMgyecnhf4PlWcro6NXc4RG2tKH0ZrntAm0Xr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5976
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

On 9/7/26 5:54 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2026 at 02:39:49PM +0300, Andrey Drobyshev wrote:
>> In vhost_vsock_device_realize(), after unsuccessful call to
>> qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
>> explicitly in this case.  CPR-saved FDs don't get automatically closed,
>> thus it is safe both for vhostfd obtained from cpr_find_fd() and from
>> open(/dev/vhost-vsock).
>>
> 
> Fixes tag?

Sure, should probably be 2 tags:

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")

Will add them on the next respin.

Andrey
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c | 11 ++++-------
>> 1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 

