Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F0CC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4LjH-0001g4-2W; Wed, 09 Sep 2026 13:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4LjF-0001fw-MC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:04:57 -0400
Received: from mail-francesouthazon11021091.outbound.protection.outlook.com
 ([40.107.130.91] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4LjD-0003ct-PD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:04:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYQVSPH0WITelvtL1/+10Y9k3ILxU/Fy7UHvL6nbiMGLirhPL3M+qINRWRKgVFmhrhmefMm/Tgi+wWDCl4HPXqJW4yJM/OUlTaTE4iNuQV+gBLezs0+OtiH75Pf9ZuzHcLa98TIEqibzvc9eUq0rkhbLXYpBE0f2JsO5iVkLl0tqZcguijOoTTFs2KYvzcf41MY0v0aP/pKw0IezCaiTYaWL4ZQpYArhoKadCJpC/IElIQpe9rCrFPnQSTF0sIlzPOBsnhkKjFnDt8BbrldvShe7imH0zJg3qdAZkd48VudIuZfjwmtQBQMXBN1wO35kLvssXAE784axb4AQw7xrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr2cLR7FI44EGKE+ODW6bMz/R1PH1Dt8g6PJ9NJqvos=;
 b=GmgtdbzT2GKkKd6R5Mw+iI90AEgoJuWRvPkCEOn9vetb7czaXxSK/ku+aSo3wR+htgVDFSrdPsFxnlhIPsCYMqAEfoEl1oPcXC7BUDCpAFsLextNeQ6MlzrNYJpAKj7JTWkaKdtnP/SA9qx5iObaWGp1syqQHpfATJSLZJjrznctv/P8acjJSkml+tJ0Q7dlGP2wTJy4QSTxJC8n098/+dP6njFB1Twtw7lQfxl+Sfq4jyXzZYLCZnzNzzjtmCMQDuTrTLpKk8MD3Viy/U3JmuRp0SgwquiszHn0COpq6HUZFBdVOOrAnD1elvqCnJy4GwRBILP+qo9xAnumjzn3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr2cLR7FI44EGKE+ODW6bMz/R1PH1Dt8g6PJ9NJqvos=;
 b=BaXx/shvarl7mgcZ2yPvdy6yvTQD2jOwHp85+0TPZTS1hxsRPMLi89DEby/2L0RA0Q3ZTvm+p3dxI2Z6y4OVF4VaYqBjrpLnB1uLj+NqfBRGgShZOSZ/lcMfSnoFIdIYocXjKyttLyRVkLC1dtxSHxHdoI0dUIM7m37JRt11hs37oYVImsItE9Uz1oFmgGojKs0LFsq8RovdVKNMkcsDR3A2NwieNdP/qqPtKyZ7xiFhCEUp0NR39c90kaKd/IF6AWoa6IN8sZNJm0WOiqa1PAtBeRH/7BTktkxxxWZpErHMSoYpIgRYlaRPhbKDIJ5TbbaxdRjvcuVmkbm04yIEfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5976.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:59:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:59:49 +0000
Message-ID: <edd88fdc-3e50-4740-a296-e89937e35f81@virtuozzo.com>
Date: Wed, 9 Sep 2026 19:59:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] vhost: add vhost_reset_owner op
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-3-andrey.drobyshev@virtuozzo.com>
 <ap6p_XeJ9NAXpuPn@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ap6p_XeJ9NAXpuPn@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed3d730-f4bb-45a2-d54f-08df0e93c214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O8z5ZtM5tH2lg/6tyU4cqO65AIbPmGYCXXDOKH31NXDZsHX7MKuQ0nXchTqL649XG/5n1v0+PI8OmEaKmmwc7pt8Ihj06oZkC6Xx+d66Jm1w+184yEgLppEhVG6IuRDkpSCW9wW22O/AI5Hxyz+skWgmZGDpuIgHncLT8SrixjGVhHj7g2qTQGGd/C/rcgXA2ZO6j/NBu6GtOOU1I6a9Uyj8iR27z8xPF+w6c+4+Ov4quSZ4Dw8ia87QCIru5aHXRk9eteBVSRQXIpxmgFjc9BrmnnW651bax8xL+IiObpadekKaFR5W7cihtHkakE7ajEO53sgtibmdTekTuPXdYf9cMq8324BDyYvtptONHR8ccTOW63gPsc8dBJMsyi1MxXIPlD2c2ezUftQgxa6QlAe+HEvNVEgdAPVFF9XE2tXNIQH0EAKSxxIvVWugprxsZEsxNGv0Op+xvCB4cEhK7Plk0S4sPzljT/jjlfVxO2ccxwgIaFBko/1lPifxzhoOTtfN0nJF7rBfCtG3+uk/BG/NfKOZWDAG07JmKfS7aw/IqSVpEOsJ9yh6q1PxudWQl2QrLZfVEZ3AljWhvWC22zrsJHP2CiBabsnd7+wWdu+VSQmdT/yd8xCaj2EDAHf5yBqXayBv2JvOF8hsf4dwnh/W6/0w9x0O+Z3zEKDoVXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzQzZWFDdHkxdkVnUXFtelY2MVhNMkVHWUhyQlBYMDlhSDhHYy9jVjdmaXgr?=
 =?utf-8?B?Q1lkeUlaUStVcjAvSmxrbUttQk1zTjNmKzdtblFzbWdlTHl4MjBKS0tvaFJE?=
 =?utf-8?B?RWN3elVvLzBmNW5nd0FlWGtrWjN1RTYzTHBkcFFPZjVubkUwY2MyT09sU0Uv?=
 =?utf-8?B?RSt5T1EvRnV6VDNIQ3FTR3l2d0wwc3NOTUtMMitHdWZudDVkWldaMU8xN0dx?=
 =?utf-8?B?R0NBc09mMEhoNlNvRzNhTVRuMHpqcXVwTzZDQVhOQ21oNkFUd2NGTnRjQkp4?=
 =?utf-8?B?ZFliaDd1RU0xd1Y2eEhNZ3hkWTV2cnRISmFZNS9FeUpaa0thZHZCa04zbDJy?=
 =?utf-8?B?VmZFblMva3RKM24wclNuSUcxeFBFWVBRRjdQNDdLOGpTMExrbVdRS3VSVnlS?=
 =?utf-8?B?alFLbkgyMVAvOE0zY3JpV3VzVW5kRjhKWWMzNVlESmMwa1dSRzZTRVcvQURI?=
 =?utf-8?B?Ti8xS1JEUVRjeWtaeXJ3dzVlVE9BT3Z0QnpqSFZKdzdOdE5PcGljS1FQQUtV?=
 =?utf-8?B?ZVdjZTRENkhnRTR4Mm8yMng2T3VITE5ZYWhySnE3cWZFZms2MDJNTVBLeHor?=
 =?utf-8?B?TnNEaTdLM2xEaW9BTHdhVngvalE0dFcySXQxQ3NSUWpHU2puUUR2Qzd6WjdF?=
 =?utf-8?B?cGlpQW05eGYrZHB4Nk1xM0ZpU3EwMkM3QkEwSElCWThBd2FQZkJZUDVMRjBL?=
 =?utf-8?B?Vloyc1QzYVA4bGpuaDY5TTJYbVQzclAxYUV6MHJuYW05b3VUVzJrbUE1NkhV?=
 =?utf-8?B?d1ZWMU9PcXZnU1BZTmIzSkdHTW84N2ZtNzYzU1R2SVBiOTJ1YnpkS0p4UGp2?=
 =?utf-8?B?TjI0NFFGK0tWclNOaTZXbGpKMEd5SmtqbHhyRzhyQWNrSFE2KzhjYzJZU1la?=
 =?utf-8?B?OGV6cWFicmFRMm0zc0lLNFdaOHhXTGl1VXJIVlNVdFV3SjdrL21VV0RsRzRz?=
 =?utf-8?B?OGtIL09PYmU3VGgyQVVKNnAyejJDYlBHQTFleVV3UGh3UkFtQmpzcTVReElo?=
 =?utf-8?B?WkFubnUrbDFBTXUwRjlQTGFUa2toWlo4Z2M0OHcveTdQWHVRSDV6VW8rQzkr?=
 =?utf-8?B?bVAxWW1nTWgxSmVTWXJ1ZHJadk1sR1hUQi9LSVF4SGhNb2hOUEhCNW5UYTFt?=
 =?utf-8?B?ZVhYb3lLeU1XQkY5eG1nU0RBTTFVRHZ4UWpleHNXNEREaDhlZXRWSjhqUk5U?=
 =?utf-8?B?SFR4NTJDTEFsUzNEWGlxM3YzcWwvaml0MkVtV0ZGZ3pJRkhVczM0Vm5YYTI5?=
 =?utf-8?B?MUJJSHpjZ3pGallDUGFCb25mcWJGaXhEUy82czk0STRHNnF0TGY3c29OK3hz?=
 =?utf-8?B?OXVoZkMwN3lFSGdjQkF2VUdsaXhGdkNtbG5BckxCeTdtM3JMS2tVR1BUbVhU?=
 =?utf-8?B?WXFYSFpxenJhNXpRVXdYRWxsU1VjVjRiOFFKaEdSNUhLazV0RkVqSjliL3U3?=
 =?utf-8?B?a2RCVGs4WjBKVlV0eDlZc2k4bHdWZDYwWGF1bURMOGxObWV6Z2tmTGRWVlBN?=
 =?utf-8?B?TFdCMGdqcnhPaVV6VlN3Wm5kV3YwejV5eXlWV1FqSDBUVGNLMk5HYWFsWCt0?=
 =?utf-8?B?WDdFKzN4bUJyMnZXa2hrRGdKSW1FQUpnbzFvazZnS05VcFZkV3M2Q0Y1dHVU?=
 =?utf-8?B?WkxocXpJK3F1TlJETTZsN0FLSi9qdEhNN3FWVjFoZ3orNkFWNnZIZVA5TTlq?=
 =?utf-8?B?MmEwZ3UxTUtNTXR2azBsbHN2b25ZcFlaVDAyMVNmWTlPWTFEbEF2S2FHaHJZ?=
 =?utf-8?B?aHhDK2NKZUJ2RG1Qa1V6NEhGeUQ4MldSSFYwc0dUcEFieHJnUTlZb0IvOWxD?=
 =?utf-8?B?ZFNkMXpIYlhhR1B5RFpmNXkxNGdBZ2h2b0RqQ3RHeDRxUGtWRGJZSFc1OXll?=
 =?utf-8?B?dlJKNnlQWnhseHpIMDNHRVFRYU15dWpLZDlQNGdGbTRHN3M4cjNPYXlPRExs?=
 =?utf-8?B?dzUzUE8zcXEyNkp0TnRDVWs3L21sOC9UU0c5cUNoeHFCZ3lxZE5WZURUS3Vl?=
 =?utf-8?B?M3lKVk9iWW1JelBqVVR1d1FEN2MxWE1waHJlMGRjZ2Zac1VvVm45RXQxQS9k?=
 =?utf-8?B?MVdwMHRCUGl4b284TEp4OG1CRzdEZGRaZk9VV3FLbXA5Qkt1RGRrV25CbS9S?=
 =?utf-8?B?aUU4VTJJS1VUc256RXc0Nkgrb1BWelpyaW5yM0w0TTRKVUxZWGI4eUJGR0FH?=
 =?utf-8?B?andyV1lZSmNyalpYWUZzY1RTd2JFY3dibGhqMzc0SXZmY1ZtdS9kQ3pHR25r?=
 =?utf-8?B?WXltajNabHdkSEJ4WE1ialQ5ZGZvZytIR000T0psOVE1UFFISWdObHhSbFYx?=
 =?utf-8?B?TWNSczhzUWNrdGVUTitqZFlUVVcrZW5GWTZqZGJidGxDc3p5WWJvTGxQRzhJ?=
 =?utf-8?Q?/6ecM9Kig7Sdp/b0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed3d730-f4bb-45a2-d54f-08df0e93c214
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:59:49.0518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbagXmV/i6Q4cPKZC5ji84B83swtkOEzLxDR+6gXX6oQ2VuVOu0Ka8biiUK7Kw79ENOtNk8RSzAHVrTPQxVfyPCeXv3T+FbuEHTyKagcH90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5976
Received-SPF: pass client-ip=40.107.130.91;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 9/7/26 4:58 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2026 at 02:39:47PM +0300, Andrey Drobyshev wrote:
>> Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
>> backend.  The CPR (checkpoint-restore) path uses it to release device
>> ownership on the source so the destination can reclaim it later with
>> VHOST_SET_OWNER.
>>
>> Originally-by: Mark Kanda <mark.kanda@oracle.com>
>> Originally-by: Steve Sistare <steven.sistare@oracle.com>
>> Originally-by: Ben Chaney <bchaney@akamai.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-kernel.c          | 6 ++++++
>> include/hw/virtio/vhost-backend.h | 1 +
>> 2 files changed, 7 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
>> index 3390b48c6f1..55d316b88e9 100644
>> --- a/hw/virtio/vhost-kernel.c
>> +++ b/hw/virtio/vhost-kernel.c
>> @@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
>>     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
>> }
>>
>> +static int vhost_kernel_reset_owner(struct vhost_dev *dev)
>> +{
>> +    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
>> +}
>> +
>> static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
>> {
>>     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
>> @@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
>>         .vhost_get_features_ex = vhost_kernel_get_features,
>>         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
>>         .vhost_set_owner = vhost_kernel_set_owner,
>> +        .vhost_reset_owner = vhost_kernel_reset_owner,
>>         .vhost_get_vq_index = vhost_kernel_get_vq_index,
>>         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
>>         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
>> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
>> index d878d7b733a..6c949e6a38d 100644
>> --- a/include/hw/virtio/vhost-backend.h
>> +++ b/include/hw/virtio/vhost-backend.h
>> @@ -204,6 +204,7 @@ typedef struct VhostOps {
>>     vhost_get_features_op vhost_get_features;
>>     vhost_set_backend_cap_op vhost_set_backend_cap;
>>     vhost_set_owner_op vhost_set_owner;
>> +    vhost_set_owner_op vhost_reset_owner;
> 
> Should we introduce `vhost_reset_owner_op` ?
> 
> Stefano

You're right of course, I overlooked it.  Thanks for noticing!

Andrey

