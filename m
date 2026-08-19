Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8273EC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhWI-0003lq-8P; Wed, 19 Aug 2026 10:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhWG-0003li-UF
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:43:57 -0400
Received: from mail-swedencentralazon11023095.outbound.protection.outlook.com
 ([52.101.83.95] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhWE-0006G3-MW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:43:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmV8Wa4V0wG6XPvILpaunAfWP/s9d43GsT2Z2LdG/4vi2PuE74JjelDyvmGHu26l5XT5zlljUsX3GkNrmmVg52oBfixi4ALTkXN0epWjwU+OirSK4Mdy9YVterhzn5fRqu5RwsCDyU10ZOmE4sUtwprxrHN61eAGE0vcvnCrdvUGgC4f1Tl0EQCA00ffkWNTJ38HNg1RhhfWb+/y+GPCgV2QcJ89tef4jb3OXN7CibGPV1Jdtuf0GcKSDq8/J11XAmdSxQ2OTeCii6Y69hwmgIkVxFoT5WBg8XfYQFQAvNASSPlTg8X6EQRO1wr0jRQ675U8ghOQFVnMQO2RpZejvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avzpdYSID/455BkFKaOnclWQRKxDa8U9ViSYcRVNnrE=;
 b=MfoInICD5fxwxAqDMWhIDPIuqi0iHOZXS0e1AUifEl3OwTfT6EyFRA2eovM+2BS55sDUBSwpRGNnhFdObFtBc3IiAM3vfJZnH24Qd0O4VrcL7syCspd818rlGsKZhZnPeGQrtc46nxM3QSCpr4h7Crec/sqZSFS96bxjRfD+KqyXHsb1OJzR/5Xy07ek0ZpQm5KE7O78l2mKzZKwgvtaEJ9O8KuCl6bFR1tRpbdhuxTx2uLmdcL59btAZE84LF+a00awkaYcYpsAVfhIbYUMkA8NvS0HanARMdkQOu1Zp/rXOdm4qiSKhIw2KVExTM91oa935hfvjXXdt3ZXHbRffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avzpdYSID/455BkFKaOnclWQRKxDa8U9ViSYcRVNnrE=;
 b=MLpVSmmPaRUl7J7Nq1va5ShUUpON+HmafcjaD1BZ31XlcpugnnESJhvMYxBhpC4nxIp6/fHQR6TgtdcHoPPEPbZQ5fCYxdQIzRUP2UkLAIl5TgTiFb12erb+KfItCaj11PZsi5tRUt3WEM4GSNA267gSBr8EUuB9keqOylDMyP+plnXPLrlbd6uXsBu0qR0zYpA+pb7GCmZlpgeWdUOAxdx7NKkzUGjkv9cOnAv2GLW0oJBlLqnK0eJQOyXq3eO3AueN9yPRkgpV4gKVQq2vPxSsljHmaSkKuX4OHrFbCfbV0uD5ItwL3fln7/+rZloWozqZJhnhpKFMXHtn5v5/cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by VE1PR08MB5839.eurprd08.prod.outlook.com (2603:10a6:800:1a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:38:47 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:38:47 +0000
Message-ID: <bc812e7c-a30b-43f4-9803-26259bb3a65b@virtuozzo.com>
Date: Wed, 19 Aug 2026 17:38:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] vhost-vsock: preserve vhost FD during CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-5-andrey.drobyshev@virtuozzo.com>
 <aoRyAqduT4FRj9NV@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aoRyAqduT4FRj9NV@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|VE1PR08MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 5034bf29-ff9e-4fe7-14ed-08defdff93ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YoziN3yeH39ekwZO6yu7L03oBZn73Hqe/4buI84e1bVqPMgF6+gb29YmDl2muyrG4vBXG02bnZ5pFimTTmHbDMX0iBHBBrUYCZ/mgS7YwxvL98k4LoqAob1SAHS2CW0pUpflSOOTudRQenMJD+KK+YuYTJUoKOqlMbdiji+nna9UzIq49Iax49r+BY7uB1qRLFwBPLXYte8Dkd/6LtJDGNdUO2ukMrWiGtSccqWMjT1/72xbZb527V7xJCOIZSYKVUDhxD600ZvlGQAabU8L7IdUkKuWfbnMJJsqUkfymDa2WEl+S5bZgzzu6kVagydN4GWKjAw5Mb4qG7Jz/hHlbyNB19eD/DQ0SzF5IZ/I2lQJdgIL/hStI4dij8ufgd1x/ksvrOiYBFEakPA+JYDEGWe8i5+g8AayntdYKdkNCremN/qy8L9QfFEHJUfuLLaFPBro6ggpGCTWVk+HfFlNkS8UU4rT+etUy/MIlAJtPMvTpJAWY5qimRnz/d4t7k1EiqRM6p26M0fTxsXfWmG4de3Q8LexGPppE6ZuTpBrtdmzMwNh6lJOIpZA3sD9YEhwQ1Ybu5fImTlxIFyde9VLSo4mZ+BtWow8Z7HJCh/JDnARoANHgi0HCKpnHjnuHNsbmnteGIc7F4i057KeKLhSa9inm9tWAwdE8QfOCJ8PwzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBKRW1XazRVV3RHdU1tQUlxVXdiMFhBcHhPU3NqanVJREQ5UmRHWVdhUElM?=
 =?utf-8?B?STJRdnVPTUVqNXo3T2tqRXV4TXBiSkZ0SXMrWVBNS25hTmZrZy85OHAydjg1?=
 =?utf-8?B?L0Y1N1J2Q3VTcVRQaEtldXRRenNZQUFmQ2tyRTMya0lLaWlhNHVJSmFqYUgx?=
 =?utf-8?B?Q2xOYUpyQUFLWEhEVWEydU1zSTE4djB1TFN3MXlvaUVPUVp1YzRiaUxHaDZ6?=
 =?utf-8?B?azk5Y1J2M1RJWUlWUXhaQmlub2ZyZVdVQkVSZmo3UGNiSzJyQytuWUsyanNR?=
 =?utf-8?B?NitxYUJGVGVnVmloS2U2TVdkNGVBWVVhT3l0Q052bFN4a3lKL1ZqKzlLeGNW?=
 =?utf-8?B?NStUR09VcnZuU3liMkdXNmEyaGZ1cjdIdmc2cWpDTjQ3LzZyM3ZDTnUzajBS?=
 =?utf-8?B?UUpTM1hjNDRiamNzYkF3L3U2Y0NKdXRvM0VuekE5SW1ncllUU1FoK1JTallM?=
 =?utf-8?B?T0dNY3EyNzFHNE5sekNsT1R0ZDllV3R5RmNoamxTRURUYlA3aWNtdW4rTVZ1?=
 =?utf-8?B?VTJZdmVrRWdYNlRpNnh2MHlnUE9RT1prVnNYMGkyVEJxUHdkTk9WVnQwVnlx?=
 =?utf-8?B?SjRxajlPM1RzZjhCcVFtaDRFTVNlWGx3bDJRRWU0RUhidVc3ZXhqd2FCeXha?=
 =?utf-8?B?M0xoNFpEdmVMYVp4eVIrdlU4T0MyL0dzMHpVZEpWcjByNUgrbXdSNGFqQklt?=
 =?utf-8?B?ZkdEU0xNQ1dZMS8xbmd3Rm1nS1JFeTd1UVUwYm1QSXRJOGRWU0pidGpQNmxn?=
 =?utf-8?B?N0pQUXIzQWlkYkZuVTdadjNDdzR3Y1h3RS9zaU5BaDRHRktnUjZYTnczVEZQ?=
 =?utf-8?B?RTU1QlJYaEpLTUEvR3FGSk9YRTBhcXE1UXVZZ3JBenlVYmZ6Wlk2WTdqRFBY?=
 =?utf-8?B?OURQbnJ0OE5WcVlWUEM3RHdyNTcvaXR2am1hazJzU0FJTnYzVGthQmZtTGhz?=
 =?utf-8?B?OXlFNWxYWFNobDlsZm1wOHc0M29YWVc2MEhQcG9RK2RVcmV3bi9UclNEeHB6?=
 =?utf-8?B?bzJDd3JhUEJPTm1ORXdhV3cwTmpmUjZteHNMK2dEeTNHS3FqRGNJK0VoWGVB?=
 =?utf-8?B?Uk5ZTGx2OW94d0FOTjl6N24wdHZqZUlzdGJjaURrajYwVG9ERXJVMkRxUlla?=
 =?utf-8?B?dkh3WlRkd09uQ01DUVA5bk9tTVFVeGxhdWJTVWlXK1B1TFUzTzRXeE9xWmVT?=
 =?utf-8?B?dTNHZThCeE15QXFYeEhYQjQ0bUkwYkVuM25ra2g1MFY4T3VNRDhpNWowLzFV?=
 =?utf-8?B?VG9pQmEraGJKa3ZGZ3NobytjWTNwaU5mc2U5dDh3dXgxY3FSOHJWN21MUmdN?=
 =?utf-8?B?SzRibTZEYW9keVRCMFcxY1NSdjVKZ0diNXh3STd4SFp6TkJGcFpDYkxUcXpE?=
 =?utf-8?B?TVJqMkFudnp1VWZXOXhyK3M4MEIzaC84YWZrYWVEZFlhclNBMFRIcUhkSmpk?=
 =?utf-8?B?dzk5Z2liS2ZndnVDNXdacjczdDUyNkFYWk01ZVNHYWs0SUZPVmN2MXh0WUtj?=
 =?utf-8?B?TUlwVm9LNjFLUXdkWS9aM3lPY1lENlVFLzJQalFrQ25tQzN6RDFVRmJycEd5?=
 =?utf-8?B?WXFVWndOeXFJTVpFNHk0RzZVRWNiWkRZUTIyakMyRE5nQUJpUmQ2R0dUenVK?=
 =?utf-8?B?MThremt4YmpvcDI0L3JPZnBTZmx1eWpOM1ZCSWNZYnJYRk5Ga2NTbUszT1BC?=
 =?utf-8?B?MDlHMzN0Ym1WY1FOVXRQRXdwSzZkU0xac3hEeWl1U3BYYTA2Sm5oOG5WUnBi?=
 =?utf-8?B?RExwTWRvTjJmR2llak1SZTJuYzloNU1FRTEyamhXY3cwaEFYcStyWngxUldN?=
 =?utf-8?B?Vml4a2c0cjZWZDFQVmdjeUFURVFBNlkrcWVZWFZ0dnNBeVB3cUpJV0o5V29M?=
 =?utf-8?B?T3E4NW1tM2VSeW1XSTY3ZklZTjdpN2FFODJ6U0Zram84a1FvaHFSb1NMS21R?=
 =?utf-8?B?eGNSbEpQbkZLNHk4K3hpS1hiK0dNN1dXTk15TFQxSURHdTUzRWlpTDYxMXNU?=
 =?utf-8?B?UWRubGVsTkNtZ1ZtcVlJYmgvazIwckdsbTFlMUhjSmJlZXVmQjNFZVE3M09l?=
 =?utf-8?B?QXpoRVZseFpZalNpZGpTTkZCOXJ3QmlVRmpBOXBmWjh5MnpjNnVnYldaWHVG?=
 =?utf-8?B?Wk84Q2F3VG8xREdXSVc5bVh3ZlR2YWZVS01ZaUh6c1hFNTlHUHVSODQvWnNH?=
 =?utf-8?B?N1VnaFB2M2s3M2tNVi9aMTY1cEQ2bHdiSzcrL3J2TDJmZFhFN0M3WnBWZUIz?=
 =?utf-8?B?Z1MvdXpUSVJyUy82QU84d0JhWWdKUU9lOEMzdng4ZW56QkZod2EwbUw4a2J1?=
 =?utf-8?B?Sld1azVOUHlXcXFKZElkL1hDQkhSVHJoOFd5VzAzVTlaZ2NEbFZRd0g2QXgy?=
 =?utf-8?Q?HUzv3MR0dF42ZH/w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5034bf29-ff9e-4fe7-14ed-08defdff93ed
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:38:47.4557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYIjqLx145DUWz7APZNACH9nhh9UN+iNnwENjisxmrQMhSsTuZCa1s4K5BzttmH+5biXil79AcF8CKOQhQ4qU2VtTy/MtHCgkqwhBIZb93A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5839
Received-SPF: pass client-ip=52.101.83.95;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
> On Fri, Jun 26, 2026 at 07:46:40PM +0300, Andrey Drobyshev wrote:
>> During CPR (checkpoint-restore) migration the guest keeps running on the
>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>> we should reuse the FD from the source.  The FD is saved in the CPR
>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>> target via cpr_find_fd().
>>
>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
>> Rather than make it mandatory for every vhost-vsock device, we add CPR
>> migration blocker which only fires once we attempt CPR with ID-less
>> vhost-vsock.
>>
>> vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>> Deferring the ownership handoff to pre_save/post_load is done in a
>> following patch.
> 
> So will this patch be bisectabale?
> 
> Thanks,
> Stefano
> 

The issue is that cpr-exec already is broken on the current master
branch (i.e. before the series is applied).  The only difference is
which exact error we fail with: -EBUSY or -EADDRINUSE.

In this case I don't think it's feasible to make each and every commit
bisectable - it only becomes fully working after the last one applied.
If you want, I can prepend the series with a migration blocker which
would fail early and gracefully instead of crashing, and lift it after
it's working.

Andrey

>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c         | 50 ++++++++++++++++++++++++++++++---
>> include/hw/virtio/vhost-vsock.h |  1 +
>> 2 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index fd7ffa88990..7eacb608d07 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -21,6 +21,8 @@
>> #include "hw/virtio/vhost-vsock.h"
>> #include "monitor/monitor.h"
>> #include "migration/cpr.h"
>> +#include "migration/blocker.h"
>> +#include "migration/misc.h"
>>
>> static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>> {
>> @@ -141,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>>     int vhostfd;
>>     int ret;
>>
>> @@ -155,23 +158,49 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>         return;
>>     }
>>
>> -    if (vsock->conf.vhostfd) {
>> +    /*
>> +     * Having a unique ID is mandatory for FD preservation during CPR
>> +     * migration, thus we add migration blockers for CPR modes.
>> +     */
>> +    if (!proxy->id) {
>> +        error_setg(&vsock->migration_blocker,
>> +                   "vhost-vsock: device ID is required for CPR migration");
>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>> +            return;
>> +        }
>> +    }
>> +
>> +    if (cpr_is_incoming()) {
>> +        /* Reuse the fd handed over from the source QEMU. */
>> +        if (!proxy->id) {
>> +            error_setg(errp, "vhost-vsock: device ID is required for "
>> +                       "CPR migration");
>> +            goto err_blocker;
>> +        }
>> +        vhostfd = cpr_find_fd(proxy->id, 0);
>> +        if (vhostfd < 0) {
>> +            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
>> +            goto err_blocker;
>> +        }
>> +    } else if (vsock->conf.vhostfd) {
>>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>>         if (vhostfd == -1) {
>>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>> -            return;
>> +            goto err_blocker;
>>         }
>>     } else {
>>         vhostfd = open("/dev/vhost-vsock", O_RDWR);
>>         if (vhostfd < 0) {
>>             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
>> -            return;
>> +            goto err_blocker;
>>         }
>>     }
>>
>>     if (!qemu_set_blocking(vhostfd, false, errp)) {
>>         close(vhostfd);
>> -        return;
>> +        goto err_blocker;
>>     }
>>
>>     vhost_vsock_common_realize(vdev);
>> @@ -192,6 +221,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>         goto err_vhost_dev;
>>     }
>>
>> +    /* Register the fd for a future CPR after a fully successful realize */
>> +    if (proxy->id) {
>> +        cpr_save_fd(proxy->id, 0, vhostfd);
>> +    }
>> +
>>     return;
>>
>> err_vhost_dev:
>> @@ -199,16 +233,24 @@ err_vhost_dev:
>>     vhost_dev_cleanup(&vvc->vhost_dev);
>> err_virtio:
>>     vhost_vsock_common_unrealize(vdev);
>> +err_blocker:
>> +    migrate_del_blocker(&vsock->migration_blocker);
>> }
>>
>> static void vhost_vsock_device_unrealize(DeviceState *dev)
>> {
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VHostVSock *vsock = VHOST_VSOCK(dev);
>> +    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
>>
>>     /* This will stop vhost backend if appropriate. */
>>     vhost_vsock_set_status(vdev, 0);
>>
>> +    if (proxy->id) {
>> +        cpr_delete_fd(proxy->id, 0);
>> +    }
>> +    migrate_del_blocker(&vsock->migration_blocker);
>>     vhost_dev_cleanup(&vvc->vhost_dev);
>>     vhost_vsock_common_unrealize(vdev);
>> }
>> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>> index 84f4e727c70..5ebc63afc5a 100644
>> --- a/include/hw/virtio/vhost-vsock.h
>> +++ b/include/hw/virtio/vhost-vsock.h
>> @@ -29,6 +29,7 @@ struct VHostVSock {
>>     /*< private >*/
>>     VHostVSockCommon parent;
>>     VHostVSockConf conf;
>> +    Error *migration_blocker;   /* set when the device has no ID */
>>
>>     /*< public >*/
>> };
>> -- 
>> 2.47.1
>>
> 


