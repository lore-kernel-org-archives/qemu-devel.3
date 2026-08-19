Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B711C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhRy-0000V1-AR; Wed, 19 Aug 2026 10:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhRx-0000Uo-AQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:29 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhRv-0005AC-Cn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrRi7oAPis2xHyssd5er32DLFCyQP1Ei9PVwkP7T8w0Z2i1FW5dgwlSB9KUg0z1Zkg59XLHQ8azWfTa+AzT8sc25JybCy+Ar+lGp/C4nk0bngWx39z7p2E7sUxPKFDr+dw+gZphp/qhfxs80pV2ubaMaqauTTxB2AQLP3+U0lDEeitysWKgDDD9XQMMCpKkuf7crZdhMHQMnmgd+IXvwIKIWKd0bMxzMXfAW3Ageah//oEP4CgFfzOIxMgcx8GVc8GufmSuDWBIEi/sSAxAgbPY7Xi29ckmAxzMDpPQF4t013tEQe5qdgpfebIT1W/WxqAy7SjQHkkMkqNEU3JLbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJIgXAH7pi59o4dsa0DIA6fyuYYXCnY3PCOclFuZFp8=;
 b=PysgO2oP7hWI1dG0Te3prZ2KoCiAwGbsJuOUE4UM9ISXm2a0u/B1C4UtsVrX7ApDA6hqAL0oXSswoI/4njmTqz0XfAloJwaEul+9PtX1ISIzqd0YqAbS22gr8zhdfzBJDTb/QEBdROnO8sNv+DBnoLxcwju+60lnOd2WEK5tHs7eHUOCW89iAmvLkGtlacCWWIu9SINngYVBTFMjNVEdJ6JY4prLttljQEpjJKnV0St1+wLZuw4/5Dlq1+IaIfEkyXt+W/J8RHLoUpKu+3aaNkqx0jQKbYwHL4K6GqvG8GFaJYBhokT0o3WgzDfRsrJuBYocyPC6tvOIiPek59/0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJIgXAH7pi59o4dsa0DIA6fyuYYXCnY3PCOclFuZFp8=;
 b=jA22jpNCzwa2NSbtX9hzStgneuqh1uNimuOM2wdkmefMqifoOoI3iFzRuHyS3UDuc2veeMA5skwYa+0buQ3xCMMZTSPtbgoJDeR7BlFHriP7Ne4yOhYNaEqIWSs34eO8R+Hzfzi0se1wL99YclcBEDO3Fu/f1c8vsNdYD+BUcPQc3nGLMznvOZUYhQ+gtjKIY/SJdFYZvkoewyK6ZLx/nRRdkhDMefXJUsBUcd3pu5aViZjjKWeIaw8TeYnhrP0NAUWBim+BJfCqE9k0H2UdrcaV9+M8gfHmDQl53OsyoE+Eaei/fu8TQX4a0M30pd8uPXF5y3GiFDS9WI+nNSaRjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by VE1PR08MB5839.eurprd08.prod.outlook.com (2603:10a6:800:1a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:38:50 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:38:50 +0000
Message-ID: <3b16df97-002b-4a4f-808f-c2cfbdf7696d@virtuozzo.com>
Date: Wed, 19 Aug 2026 17:38:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] vhost: factor out vhost_dev_init_backend()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-6-andrey.drobyshev@virtuozzo.com>
 <aoRz2pDHkWCCr1hq@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aoRz2pDHkWCCr1hq@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|VE1PR08MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ad4393-c6c6-429a-a8bc-08defdff958d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JIr4n7xZ8Wzzs3yP0Yq36lGLD0qzo0R7bRszSG+GPKcboICtsQ5TMEpkJYKrmzfXItXY3l9lDkH+m1QT2de2dUoAQvBSZsLKDtB6Kd+gAZ3nF0JPKsXr4bX8Efv4726t0qu3ICqJ3WKk4kHoWPrezz+34fRC2WhyfBXApxYjfAvjFV1zugpR9IhBQrhHPpnsOFnCQNMCJOSl2iOtBoPLZRNPzLNb7nGT9YynKUvS2h2tl0YfHPtNK18avsvbCdYcf9EW+CYDCGaQ2wj5IAbpGYaXUkdTISjFDloZOHyJuTlv2bShqgxGuDaVswp4cGqfEr5CSSamGDToR3nBC9DeiECCDqeT1qD5Kks4VF8bjGD1eJ/D7toBMfMchCyITIDw4M5/x3Y1dAlAdDlAfhNSczZ6jbffryD9V+5NHmBvBJMLFLqLxe5gVMIx7vTIDKc5YZ20pMQ1MEHVciIXoPIoEUlkRzRIbb3wpPsoetyGkFgx2rLx0On9zT5kXTsllPLeKpopUjjLV7n6tBUrnGk9cL0MUeygSqScQAvKB76E2A4K3jbxP1BA3C9hYILsMCToCFZZvoLH7yBL1+6WaMZrFpsia3BiNfrMnR75l2ZR5iFVDFONX4HUjOqgHKaoSnWJJcln0p87Tg2jwm6/VVFrfGRk5B8Jqziy9iU0CpJOhdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxETHBNYUl4dlFjdEprbHl4L25laFh4Rzg3VFFPTkxHRlZHRXI5OVdnelFr?=
 =?utf-8?B?a01EengvYUIrTVBPdlBiL2w4eE5hdzQ2VVRuZUFNeHlQZlpOTkM5MUdpMDBs?=
 =?utf-8?B?TUx5MEpsOXNiT3hXZ2FlTEJVa01samw2UHRxb1Bwb3NPSXBublhhNkowdmhD?=
 =?utf-8?B?Z0lyU2Z0Uk9VdVlZT1ZieUQzNDljTEFsampIRnZaZXlIZFJnK2JtdmJ4d0kv?=
 =?utf-8?B?c3laNU1pU1BUeG9pWmdjcTJIclRuTGswc2ZYTjd5cWFxR0tYakxBalBKdlR1?=
 =?utf-8?B?bzU5ajNFMGRrbnJVSFNLWStZbUNqVkkwbURHVTJwMlQzRWgwQWFrek9iY1pn?=
 =?utf-8?B?ZkJwM1BvMk9NRHRlSUNOL0RUbU9wTGJIWDViaUgyNzI5WkZQM2cyK09zT3JR?=
 =?utf-8?B?NXB1SXRIK3h4ai83SWpHSXp0ZXZTQVNOdjR5T05NaU9QNXZFam9yUnRCSVBr?=
 =?utf-8?B?WTd0Q1QvTUlSa0RNNE0wcTlKamJDY0VEa2FFM0huYzNISmJYOWRvLzUycEFw?=
 =?utf-8?B?VUk2UE42T0dOdWdnTnl0ZUVCNmxCa1RTZ1Y3RnFURUpSanF4MG4vYXk5V0lu?=
 =?utf-8?B?ekJKZDh0bEd1Y0toQzVDVWVwdEtkUHYyalFZYWo2TTAwcTJ3by9vbENVL2Z2?=
 =?utf-8?B?Y3hUTTJjL08zeVFVcU5PVit4MEQxWnV1YXZ1WXdFU0l6VmZic1pOL2xmbUhR?=
 =?utf-8?B?R2QrS0pFNjNqRE9NcEIvc2NCdGpZSWlFcEtBS3hVM1EwYUxNaDhrNXYrTWlD?=
 =?utf-8?B?b1hrbE5OZzRTZWVIS2RDUldCQVk5UDdITkE0MGFKZXdhbFdTOUNyOU9haTdo?=
 =?utf-8?B?L2tRWGU0L3IxekR1RjNxMHdJeWRLcko0Z3Y5TlFuNEhYZDJ2QThxOTRSOE5O?=
 =?utf-8?B?SU0ybTAvU3pzSE54WDdQWkMzTlEzUFRINW5DdngzS0lTcG9IT05JbGxtYjVy?=
 =?utf-8?B?S1BlTldzN1R0cnV3bnpPZERpMzEzUk1FQmdaT1BDOENlNml6SGpWUWVEbHVI?=
 =?utf-8?B?OVRpSW1YeXErU1NFZXdDY2lTaWVFR3I5RDBFaCs1WUlVMzJtRFRqYWp2bjVJ?=
 =?utf-8?B?RnA5UEY1ekZJLzJVQVg1TVUrWnJHMlg5djRiOCtBZUNENHBwN01UNmRCYzNu?=
 =?utf-8?B?aDBTKzZycWhlV3BiWDlWZnFKdEFwb3B3TXJtTldXUFI5TEFiWXl2T2RJMHNX?=
 =?utf-8?B?NERiWWh6UjErRC9CNDUySmV4MnlyVWd1dUJJOXVHU3VJUnZaODU0aGh0RGxi?=
 =?utf-8?B?ajVCTjc2OFd5RTY5a3dONEdaQkpZU0RXV280Zzg1MksrUkRGWnZzb0Z1VkFz?=
 =?utf-8?B?RG43bEt0K2U1SGxtOWRWZWRtSG5BaFREakp4UnEvRlhFREtsNHI4aWxtSzFh?=
 =?utf-8?B?RW5sT2g0aitiZ25GZi9oZlF4dVRLS3RKYjFjdnZKaG1GN1haYk9HYklqbUtu?=
 =?utf-8?B?Q0g5czJXK3BOaFlTbmZHZlFqQ01ya1ZwT0xFUEZaQStBSFBUQTA1S1F3ekdD?=
 =?utf-8?B?NG4ya01UWmZ2MG9vZzBOckhQc244SEc5MGREeGgvVjIvS3lnNDNmbGh1WGhW?=
 =?utf-8?B?MXBZLzFrSEFTYXNtZ3lxSjY5RHN0ZDVuMVFiNWo4RzZtbjdaZ1BqSHV4cDY3?=
 =?utf-8?B?V09lTVVYUSszOWR5TThzSXljdzNFOEVVbFB2dFBZR0ZUMFh0dWNvcmxSeXVN?=
 =?utf-8?B?MW1QNjAreEV0NER5NmZIY0JkTkMraEF2czVETkcvTUoySEZrT0xBMFVKT3V0?=
 =?utf-8?B?ZTNnQW9pcUxsRlFIUHZlZElKTjZWdWZYYjN1a1c1YkdpQWdtUnRGaVdsS2tt?=
 =?utf-8?B?UitrdTRpaVlwSFZRaThnQmtwS3lRMDRZU0tMZHBIam1SRFg1ZEdOUFhHWmI1?=
 =?utf-8?B?c0EyZlNuazNqK3Ura3Y3YUFPVUtuUm1sbXZ0QlhNSDR1MTdhS3dYSmY1Zk43?=
 =?utf-8?B?eXVwWE1ScGhRRFFNU3gvSGJTdzBjVWF1UzdiREZXL0N5ZXBOc3RZYml4aDZL?=
 =?utf-8?B?dzBQWnAwQ1lraDJFTWhaaHkyTjZ4UXQ3eXBOUldpM3RrWkFXYzFhRW9vcEdW?=
 =?utf-8?B?SlU0bXZCYjRSMlBlTWlhZnd6TTQ2Rmo4d2Npd1VpOUdQaElhdFRhaW84T2dk?=
 =?utf-8?B?ZGt6V0ZrR3FobnJoS3RQYUo1SVJsMkhBU2FaMHhLbktWZVR1UzVtZG1LV3ZP?=
 =?utf-8?B?aEVHd0wzcFZaTzA5bnZPU1hZeWl4MEQ5bGZFS2JWM3gvNU04a2toOHlJaDFR?=
 =?utf-8?B?Qy9CNEpNSmpjcldFcXJSOFFtS1Y3VEc5YTBEbWFDc3RuSWVxeG1YQ3l4UGow?=
 =?utf-8?B?MHAyMmw0dms1emwvMlJXaXB2YWc2SHlvaEZXNEI5VElrb0ErZ2t3eXdodG5O?=
 =?utf-8?Q?wna0aCqLnw1mOfOo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ad4393-c6c6-429a-a8bc-08defdff958d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:38:50.1524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQDWbS9AE9eetPnufGEIIawzQAP2FlG9ji+Zq+TMfOq5KWo9mF651PYKVn9VCzgo1/zQoH6WN+Xq0hWUfhHAuiLsSMDeeIHO/LbAXXDFbEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5839
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 8/18/26 6:29 PM, Stefano Garzarella wrote:
> On Fri, Jun 26, 2026 at 07:46:41PM +0300, Andrey Drobyshev wrote:
>> Split the first part of vhost_dev_init(): selecting the backend, calling
>> its .vhost_init() and reading the supported features - into a new
>> vhost_dev_init_backend() helper, and call it from vhost_dev_init().
>>
>> This is in preparation for CPR restore of vhost-vsock, which needs to learn
>> the backend's features at realize time to negotiate them when loading the
>> incoming virtio state, but also must defer taking ownership of the device
>> to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.
>>
>> As a result VHOST_SET_OWNER now follows the feature query rather than
>> precedes it.  This should be safe, as no backend requires ownership before
>> VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
>> for it, and vhost-user already does query features from its .vhost_init()
>> before set_owner().
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
>> include/hw/virtio/vhost.h | 19 +++++++++++++++++++
>> 2 files changed, 42 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index af41841b529..f11588cc51a 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1667,6 +1667,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
>>     return r;
>> }
>>
>> +int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>> +                           VhostBackendType backend_type, Error **errp)
>> +{
>> +    int r;
>> +
>> +    r = vhost_set_backend_type(hdev, backend_type);
>> +    assert(r >= 0);
>> +
>> +    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
>> +    if (r < 0) {
>> +        return r;
>> +    }
>> +
>> +    r = vhost_dev_init_features(hdev);
>> +    if (r < 0) {
>> +        error_setg_errno(errp, -r, "vhost_init_features failed");
>> +        return r;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>                    VhostBackendType backend_type, uint32_t busyloop_timeout,
>>                    Error **errp)
>> @@ -1679,10 +1701,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>     hdev->vdev = NULL;
>>     hdev->migration_blocker = NULL;
>>
>> -    r = vhost_set_backend_type(hdev, backend_type);
>> -    assert(r >= 0);
>> -
>> -    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
>> +    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
>>     if (r < 0) {
>>         goto fail;
>>     }
>> @@ -1693,12 +1712,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>         goto fail;
>>     }
>>
>> -    r = vhost_dev_init_features(hdev);
>> -    if (r < 0) {
>> -        error_setg_errno(errp, -r, "vhost_init_features failed");
>> -        goto fail;
>> -    }
>> -
>>     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
>>     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
>>         memory_devices_memslot_auto_decision_active()) {
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 684bafcaadd..bc81e09663e 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -156,6 +156,25 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>                    VhostBackendType backend_type,
>>                    uint32_t busyloop_timeout, Error **errp);
>>
>> +/**
>> + * vhost_dev_init_backend() - set up the backend and query its features
>> + * @hdev: the common vhost_dev structure
>> + * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
>> + * @backend_type: type of backend
>> + * @errp: error handle
>> + *
>> + * Select the backend, initialise the backend instance and read its supported
>> + * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
>> + * virtqueues or registering the memory listener.  This is the part of
>> + * vhost_dev_init() that precedes taking ownership; it can be used on its own
>> + * so feature negotiation can happen before ownership is acquired (e.g. by CPR
>> + * restore).
> 
> Should we mention that on error `vhost_dev_cleanup()` must be called, or 
> maybe should we call it in the new function if vhost_dev_init_features() 
> fails?
> 
> Thanks,
> Stefano

Good catch, thanks.  In the entire series we have 2 callers for
vhost_dev_init_backend(): vhost_dev_init_backend() in this patch and
vhost_vsock_device_realize() in the last patch.  Both of the callers do
'goto err' where vhost_dev_cleanup() is called.  So let's indeed mention
in the doc that cleanup responsibility lies on the caller, as our
callers already comply.

Andrey

> 
>> + *
>> + * Return: 0 on success, non-zero on error while setting errp.
>> + */
>> +int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>> +                           VhostBackendType backend_type, Error **errp);
>> +
>> /**
>>  * vhost_dev_cleanup() - tear down and cleanup vhost interface
>>  * @hdev: the common vhost_dev structure
>> -- 
>> 2.47.1
>>
> 


