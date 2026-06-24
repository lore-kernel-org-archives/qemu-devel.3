Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ADCCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPr3-00042p-IE; Wed, 24 Jun 2026 11:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wcPr2-00040U-2k
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:49:32 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wcPqz-0008Oo-Sp
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP9lQLuugc78jcCUdHvKA87d/rclkJreGDAWmYzc0w2bJkWk0Z/wJGLyTnRHV6xJaHE0V0OTbr/yK0/ebgqm7aFjaUztQoZm8krHy5ZWDbwRym7gdVKgXt2ib0zqjq6wRAmcs0isBTzJjcpoW36+HPifAtAfi1MBxa/WWt5XkprkY8I+59QSAZ8h9OAETOYep5dNt8vevYin/kSWT9Z2uv0by0Zd5uSTzTG128H/f7ycycrPa8/MtQtw4/p7D3ZkSAsqXjAbghiSkm3l/73gYFLEncMfLkhPS5vAL7/yROSvs3uPJlBNYMgu4AfZ3rmYE61ekHiRIKWpfhC5gdVF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUXUTAMaQKIoVVK4LFPOYioPAOturVveEFa/G549FPU=;
 b=Eco4X/wBxbnuZ2NjmWB278qgjK5TndLQl3921zy/YF+WA9UZLfiq+LR+puwBaE/da/rqoUsfleF4dObw6L39M2EkOVVwlZmj8//vZkp7rB8+DlTsZByi61PaWWHAT2xTmKgNAXuVP4XAEu+wkivNr5QlVWJuYmy3ska4QRNK6n9UQaUU+Vz+bykJIKfdo2EXgYMn4A6UYjYwxjlnPgxFnmRQaWMCGcDRv8E1hjyfG/GbtMhkm1LktG0vxo9/CMrW+vPaSDiB2M45fY9U+XCGYixOuH25MmiCxL6ORzJgocl9IFwJrl5C+5RLKNrt+/aJ/Vg5Vvn0HwTtJIbY9kC/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUXUTAMaQKIoVVK4LFPOYioPAOturVveEFa/G549FPU=;
 b=Qrzqojnj4/OgAiGdEp78Fj1FGOV9EqYoeQkwU1dKZmgTetdW8R6YHzu/3zuMVu/54/fw3xjxHwIeDVWI9u9FcMA6TNfBDnxcS1DbobAQMlK2bVm13g/9XRPWvC7itcKxSqONyU7W9bvca0DmF9fkeidDgqRa04TnzWQOfXrNYhRUyN1Hk5+GvQfSnzXhsuKHCUjrKKJbkmiMtlb0F5Qbr6DRFt9noV4vwtdGegNAd+eeqMKqJwhtNg8jOCUM4sWC2x313Mv7Fd+d+wNifA8mGcQcct5GkMoLOIOTbtzmmYD6GbW5DJ8UowB7HuQnPR+HDBPam8CJmDWF0i1iO3u6TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB5PR08MB10192.eurprd08.prod.outlook.com
 (2603:10a6:10:4a9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 15:49:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 15:49:22 +0000
Message-ID: <b62c8e66-85d5-4441-96be-8c779ab9be0a@virtuozzo.com>
Date: Wed, 24 Jun 2026 18:49:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] vhost: reset vhost devices for CPR
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, peterx@redhat.com, dongli.zhang@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
 <20260619105514.128812-4-andrey.drobyshev@virtuozzo.com>
 <d258f5fc-5c67-456a-be2e-49b0c7e1f4aa@maciej.szmigiero.name>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <d258f5fc-5c67-456a-be2e-49b0c7e1f4aa@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB5PR08MB10192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8785bda8-fa69-46e5-89cf-08ded2082909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: i4J0zUxCB8amT8boSCg1efWSLr7LVfWmGebIOgIQ5YLln4sieQZaygk/+xAE8n2wDOdtOWQIJEpLGUyfduPank6mRPOZSBOlML2vVf/KpLa1wkUgrP2CxGOPjqzHVofC/Op2sLE1jbEcX0v4NZGxPOP00RpgH21OzRG0PU4+jf5RICMVlAYFPdNyZJ8MsKC/6X/Mh/v35jwDusq+HS/+MvyCwAwwXa4JfcQiuvUyQjLYd9v04e/TEGVu4HDnvnJaVy3LE9LpHsYKgIX54voz3gpc/qIy7ikBeyF5HjLzerUBmNWBN7NU6JKBmjfBSwjLulup/huXSUD0Df7qBK05LfA34Y8tLbyl44duD5X0PWoSKELI1yY7N9xViqApmU1yvYJPQ5Pt9hN4qhaeQGUDMt8UNDUXNq+rhYzmqtLgUvejBMBaQjzq91qbt63o5M+lHUiU9qzol2c0elrZtZ+RvVg0U9hz2VrvNXryCOiX/qqGLuDBzLFN+H0B4vT0ABVL3rNa+S/UKdvqTY5wuhJ7N4cVaVfs+I5XjqKOZANjztX3jo3RKB6ZjMWK4rcM37PzEM9Kyd8VW2vyrCElcw7CYHzTj7B54nxWBx9aDPeeq7RvDF9kri4V10FHXkbqrIaLPQW7cNLNgiH6PKAP0zqQdl4xzxocH08EnlNZPsXvXZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2tKSjQ1L3I5dVBTT0FOZzM3YmVNTWJZZDM1NndyWlh3U0paWDdnc28wbVgw?=
 =?utf-8?B?RTFjdy9JV3piWWFZYjVuWmhUY2FYQ3R1djNieFJCODhyak5FdysvUEVpNHFm?=
 =?utf-8?B?THpvbER6a2FNYzNpMW5HSzcvbnFKU1lwN0xoQW5KN2h6cnBXOWVpTUlDN3RS?=
 =?utf-8?B?VVRyOXVoYmxxMmg2TEptOWtEdEQ5T25iSUpIY1FmbzBDVmp5OFNKZExhWWg3?=
 =?utf-8?B?bzg3UVczUEwwZEJqY2VBclkwMDJXbzhicUZkL20wV08vdGEzTFpxSDgrMjZY?=
 =?utf-8?B?clk4SzFwZTF6N2VqdU1oUjkxeDN0VEZFVk5hck9wbCswdjBsYU52YlVKNndy?=
 =?utf-8?B?UFFDaVBTa2lld3JXaDFKVFNrcjIyaCt3UWUybWhleFlrNVMrUWJBbDFlZit6?=
 =?utf-8?B?WEJlekFvcFhFUytZeUkyK3V3SVVUblg1THRPV3BDUnEwbE5oUmV2R3RYbkIw?=
 =?utf-8?B?bnpHbVlpYXRRNWE5cWxGSnY0TGdya3hLbjZ4bFRhN3lWMGd2MkpmcTdJeCto?=
 =?utf-8?B?bytycUFzVktxU1drOW9sWXVlMUtEcXl6MWFrNis1K0hxMXI4bENDWnE5WW5L?=
 =?utf-8?B?c1VlaHhxMDFuU051QkZ0bkUvVVNVRFpIcnRwdEFZajg0ZTFtb2Q0OHIzVTlP?=
 =?utf-8?B?di9HNHA5WmJNMFVhYndVU3U5Tm5PMFB6K1ppQldzbGczYThKazZ4UWgwcEl5?=
 =?utf-8?B?VVZqOW9tQ05aT3kwZnZSZXBhaWl5dFhWdFM4aDNQQVFjL3MzdjB0bzYzYmUx?=
 =?utf-8?B?OSsvUnp5NjlhM3pZQ2xRdGdJYXo3YlArYTlGUmdRZ3diZ2Zyckh2RjlBSnhr?=
 =?utf-8?B?M0VPb2lhNUYvQW8rQS9IbVhDQ2wvS3JzUHdhRDhUMnNOWkVqeENSOEdKUkdu?=
 =?utf-8?B?ZlJ5NHcxTERSUEpKNTcyMWE5MW9kcDZVR2pBNkFVcmVZenYzVXE1QllWY25S?=
 =?utf-8?B?ZjJad3dLNjM5L2JQNnBZQ3ROcE9WSTY5RW55cGloc0ZTNTVaRkJtRGM0OWNW?=
 =?utf-8?B?eEZBUzlZUU1ZYkJsei9qOWcwQ0orWmVSUmtWNlA5VU8vOEp2VzBxcmg0bEEz?=
 =?utf-8?B?VVFqWkQzMzNCTWp0R0EyQXNHMDRaK054ZllFT3NXL0FralBnRTZST1hEVmI4?=
 =?utf-8?B?aHY3TnU4L1RlRnRLa3dvYWdDeEY5WEMzSXNoK1JjMzZxTWQ2dTRNSG83cW9C?=
 =?utf-8?B?WXA4N2JZbkllNXJ2c0ZobHNOamNrdmczOEFwNnkrTXp5MjVNYnBwdWtYdTM4?=
 =?utf-8?B?K2ZzZWpNR1ZxaFprdjZCeHljYlA3d05tVGhnUGZqSlFoQmk0NWFZZFRtMDJ4?=
 =?utf-8?B?dm5LZjFRTXlsQXBXWE0rbHNuczBuMTRvZHNIMjY3MkdReEJtTkVvQ1lvSXoy?=
 =?utf-8?B?cGp0bmlteWFta05PU2hoNEpqaW1INHR0MnFmdnovcDlENzgrc2ovNjAyd3hC?=
 =?utf-8?B?ZzdnQlpLbE9aQzVzU0gyQVh6V2dSbk9wVVcwNkE3NVA2TCtZN0lieEZWTW1m?=
 =?utf-8?B?Ykp2b3o3VWJiRk5qaExiOXIxR1g3UjNBSktrUFkzWU5oR3A5NHhXTFlGNXM0?=
 =?utf-8?B?eGw2Q1pOWk5hM0FoREhuYzNHYWwrUEFUOWZ1VFkwVFU5U3U1U0VYQnR1dWR6?=
 =?utf-8?B?ZVl2OW55NW41WkhOTWZ2RUhqaE9FU0h1UlF2TjdvMlhyYUhpTm5DMU1GOWd2?=
 =?utf-8?B?eksybVZmcXlPSisxTWFybjlsdFlrVTZMZ0lyMGhXaityM29rK2NFeFBJZkdS?=
 =?utf-8?B?Sms0bkd1a3B4ZlRrQWplbGxiOFBBeUNEcDRjUFhWL2JRaThJNU9xaSs1dXpJ?=
 =?utf-8?B?NXBDSjl4dWhUcmtDcEFuOWJrTzArblVRNXNFdXhpZ1I0SzVwTlpoYk1LM0pT?=
 =?utf-8?B?MFBsSWp3QXFBdDhDbEJOU29LSHcweFZzMzIrRUxCOG9QUHhCUTlsLzIrRVpM?=
 =?utf-8?B?RjhFczVmaTFnSTR5SEpaMWlhUzBYWUdrSE9SN1pNWFVZYkVoOHdVN2pQRXZk?=
 =?utf-8?B?TWR0N25MbHZic25BWFFXc2tqaG9pcTdqeXRSY2lnKy8xcmpvRVNmNU9NQU1B?=
 =?utf-8?B?Wk1TWjJnd1RnYk4yQmMraUh1UjVURnF0K0N0TmduM0Y0czJiWEZ5aUUzckpZ?=
 =?utf-8?B?bVp0Z2QwMEw4ZGl0MkRwamtnUkdWVzZ5dG1qaTlINXpxOGFDWGU0Qm5ucEJ1?=
 =?utf-8?B?VEJXTzVVSjJPczNKWWdONHB5Yy9XQ3JBZU1aTkRGTzZOTUVaRFZKUmtyVUJo?=
 =?utf-8?B?YWxZYlpBdXVOK09kaHcyNE5EdU9oZ2taZDJjcmx3MnRoSDY0UmJzRDNoK3pn?=
 =?utf-8?B?eW5IQ3MxcmllSXBabXRwc1puYnZzSy9XbFBtRVFZSndJT09kWWtxdjJtUlV0?=
 =?utf-8?Q?Bavov5/yocz54mTc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8785bda8-fa69-46e5-89cf-08ded2082909
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:49:22.4331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eZLmCi7NKrk3IaHaFr61GjwuENrlVVKCljzi6RXVSZmgbOmipp/k8OssY+X90vc8zr4u4haEQ+LJllPl7AD1x1Ve/h7mDGa0iA5rnWRnbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10192
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

On 6/23/26 9:27 PM, Maciej S. Szmigiero wrote:
> On 19.06.2026 12:55, Andrey Drobyshev wrote:
>> When preserving a vhost fd using CPR, call VHOST_RESET_OWNER prior to CPR
>> in old QEMU.  Otherwise, new QEMU will fail when it calls VHOST_SET_OWNER
>> during vhost_dev_init.
>>
>> This patch is a rework of the change originally proposed by Steve, Ben
>> and Mark at [0].
>>
>> [0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com
>>
>> Originally-by: Mark Kanda <mark.kanda@oracle.com>
>> Originally-by: Steve Sistare <steven.sistare@oracle.com>
>> Originally-by: Ben Chaney <bchaney@akamai.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   hw/virtio/vhost-kernel.c          |  6 ++++++
>>   hw/virtio/vhost.c                 | 33 +++++++++++++++++++++++++++++++
>>   include/hw/virtio/vhost-backend.h |  1 +
>>   include/hw/virtio/vhost.h         |  1 +
>>   4 files changed, 41 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
>> index 3390b48c6f1..55d316b88e9 100644
>> --- a/hw/virtio/vhost-kernel.c
>> +++ b/hw/virtio/vhost-kernel.c
>> @@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
>>       return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
>>   }
>>   
>> +static int vhost_kernel_reset_owner(struct vhost_dev *dev)
>> +{
>> +    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
>> +}
>> +
>>   static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
>>   {
>>       assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
>> @@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
>>           .vhost_get_features_ex = vhost_kernel_get_features,
>>           .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
>>           .vhost_set_owner = vhost_kernel_set_owner,
>> +        .vhost_reset_owner = vhost_kernel_reset_owner,
>>           .vhost_get_vq_index = vhost_kernel_get_vq_index,
>>           .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
>>           .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index af41841b529..1521b50cbff 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -24,6 +24,7 @@
>>   #include "standard-headers/linux/vhost_types.h"
>>   #include "hw/virtio/virtio-bus.h"
>>   #include "hw/mem/memory-device.h"
>> +#include "migration/misc.h"
>>   #include "migration/blocker.h"
>>   #include "migration/qemu-file-types.h"
>>   #include "system/dma.h"
>> @@ -1667,6 +1668,32 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
>>       return r;
>>   }
>>   
>> +static int vhost_cpr_notifier(NotifierWithReturn *notifier,
>> +                              MigrationEvent *e, Error **errp)
>> +{
>> +    struct vhost_dev *dev;
>> +    int r;
>> +
>> +    dev = container_of(notifier, struct vhost_dev, cpr_notifier);
>> +
>> +    if (dev->vhost_ops->backend_type != VHOST_BACKEND_TYPE_KERNEL) {
>> +        return 0;
>> +    }
>> +
>> +    if (e->type == MIG_EVENT_SETUP) {
>> +        r = dev->vhost_ops->vhost_reset_owner(dev);
>> +        if (r < 0) {
>> +            VHOST_OPS_DEBUG(r, "vhost_reset_owner failed");
> 
> Shouldn't we abort the migration attempt here?
>

Hmm yes, I think you're right. We shouldn't proceed and should do
error_setg_errno() and return r < 0 instead.

>> +        }
>> +    } else if (e->type == MIG_EVENT_FAILED) {
>> +        r = dev->vhost_ops->vhost_set_owner(dev);
>> +        if (r < 0) {
>> +            VHOST_OPS_DEBUG(r, "vhost_set_owner failed");
> 
> What would be the impact on the guest of this failure?
> 
> Shouldn't we *at least* unconditionally print error here?
> Maybe even more if guest would be unsafe in this condition?

Agreed. Should report error as well.  The only catch is we might also
get into this branch after unsuccessful qmp_migrate() -> SETUP ->
vhost_reset_owner() -> migration_connect_error_propagate() -> FAILED.
Then we'll attempt set_owner for a device whose owner we didn't reset.
So we should probably add some bool flag which would signalize whether
device has its owner currently set or not, and only attempt set_owner if
reset_owner took place.

But you got me doubtful about what can happen to the guest if on FAILED
we couldn't restore owner.  Realistically enough, we can at least get
-ENOMEM during high memory pressure, which is likely to leave vsock dead.

WDYT?

>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
> Thanks,
> Maciej
> 


