Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C38EC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qDC-0007eB-9F; Wed, 16 Sep 2026 10:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x6qD7-0007c2-3F; Wed, 16 Sep 2026 10:02:06 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x6qD4-0004Be-VK; Wed, 16 Sep 2026 10:02:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaIPOW5oiKzivUzpAvshep33fdjG6eCfbimzIUPt12BSJ16KrrmsMrQcsZyE5AejWIz0aRFrWYh4oiRERaGVjwnlMJlqWjdyp7IjSy2H80f5IGtUf/Pu/qJVBC7bHqkEjOQVHe8A5QsNSDQgPYYX1ykAFsoop6Oba2S0ToMWxBcfSkuly7DVI/R6mrFHPc8L0K+G4Rp1taex2DqPZRf/mpR18/BcKTmxCF6WPoHz5e5PnNfspQTOUxuhHsv9RFb0kFhXSBP0v9cRvCJyVtR3h+l3ANj3wLhA/8WQQLxAmN2OOrgXTjADtIKzT80SSrFAeccEkLA3wt7Cg4eNnI31wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXfoJBvMcPu/T+DtXspef5IOZz+siC5ydyqn6Wwi/Ck=;
 b=V6Kg6EnYzMbXcID93GgRmi5cX9RWpu/0RKZB3SIayxqzQjQBHbncYinf/co+dEcB1B2p/4y/PpnFqOq7+65t9TfMlXnCxZpyZnHhHe+5TW0LyfE4t8DW/hLRyBY+LHIC18pTDe+BUHCmqqKDiuFoZ2bT5XvNdnzFYrdWATxHxX05ztMqg+3pdEEYbhSSInvDx48ziBWhaZ8D2dPLUgZm3293FioPbozkGcmsLLaF+/WOrCWM6pIeCxbkZedf4YS5DAzLwHGlk1qzhZcArncuzAEV4D7ASGdnAg8zapFql/+9++z/Ve96Ujqrze8BRL6UZ+NvMpb3QBrSYR2I3qAPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXfoJBvMcPu/T+DtXspef5IOZz+siC5ydyqn6Wwi/Ck=;
 b=TYCM+Akv1YyIOq8xOA4c6UaAw/iWK+ygbLxn3gSh+1w1CBYEauKarOPAmLuNOQ4608jmo7kyB+lS6SGbQ2QhYknOw/tgfaJhJeU5fpW8iqi94dYOcJrhhJPW6BzXTnlkxyDCNK4Exzx+uDrldQt9D2eTTEL74FQE3T8RM8r4jK9hRELOJNCMLXqHgTlmBfGB4DfTTTjPDVZncnneO3SHKLLLG7gtgWB+2jUrp77R0Rp2EO88ZFMILSd3CKkku1hld+NT6p74QRJJniwiSjmwTxvbtSgGCo0IXNqYoq0C15me73PyqxcN27eRuW36wlzpOZZJy/u6KvFR+NDY8sJSbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AMBPR08MB11657.eurprd08.prod.outlook.com (2603:10a6:20b:738::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 14:01:56 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.004; Wed, 16 Sep 2026
 14:01:56 +0000
Message-ID: <1df6125a-c7e6-469d-831b-19996725f785@virtuozzo.com>
Date: Wed, 16 Sep 2026 16:01:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nbd: comment on locking for requests[].coroutine
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260916132740.872244-1-pbonzini@redhat.com>
 <20260916132740.872244-2-pbonzini@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260916132740.872244-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF000001FD.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::910) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AMBPR08MB11657:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c29cea-abb4-4c2b-6d43-08df13fb116a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|366016|3023799007|56012099006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: K1AeV0YW2iaatANd5m7pQihmBNb5TmpG6zAza6Ek91CV5BXZ5DLaliz34PtlwBJbTm6uyLXmTnJxYnXnsGHYueMJXiDMRz0BtsfTe+D0fmYgRmPIaVGJzKDNcZsHWubBaPm4Ya17dnIw4c7CV4NmB8a7WW8Goggntw0xcOuRPIQ66ZNfdK9cxQH7wpyqxanXQ8qKw+6KyuyqqZ1bSMXmpDa28UBMD7AN4qQ1C3xlq/voGuN6jjf64mLu9sXF3OxraEN6RUJ+nLaFHN+KW2NgkFdNMmQoT9vlTWrYYjJWAd6zFiEDDD5XmT1jeQRDjVIv19JngNdMewPCUhtqsuNa7vvy8M8lomgjfqYYVcJmejGU4uwDOQp5WZ8PbNFWoxaAZGw+IimagWzESrFqp1GHfP9BvaZR+xNHIU5ST/WasT/ioF6zEHgo10vNbDgh/M07Jfaw/+YjxXPKgUOKvRwxNfOXH4rcJDQW4h4ZsNbjycBgm8JtHf3/fa+ob3BbmOB9CSIdV8b6AzHGMH1tK5Fthpl8TRWrDgsvI9t2UPTN7eClawed3j4gVAxUPgpkx902tJMk0TU6tqrk3KgPgs43R/uu1CaYsitYYlDm7jOQVLswb94Mw7jYiUCTU/ZsjvRUho+FD3J+GDghEPPOqfN8NZbCXhB7zL4S8lT8z8wdxx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(3023799007)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smd3VkxhR2duUGYydDdqcjVqNit6RU1WelpSTC9VWVF0NGlacmhUZk45L2Vw?=
 =?utf-8?B?Q3JJRXFBWjZWSlFuWFZTWUpSbC8xVVRIK0tRSUhnYTEyNWtFT3pua1hhUGpB?=
 =?utf-8?B?cmhGV1JYZkh4d0hNenJ4QlBKR2lVVXpzK3ozUUNRQ0VJMVhabm9sMzBWeDlM?=
 =?utf-8?B?aTlIRUt3dzU5QWZ0RWZaQjBFeGZCV3B5WmRaeG5aR3YzUmhpdWhMaG0zQUE0?=
 =?utf-8?B?ZnIrRTlpM0o1ZG9iRXBNZWlNbTBMckNmc2pvaHFDNUtWUWZjSTFFQjNlUVFn?=
 =?utf-8?B?Uy83NXFvTEZ4eEpnemtiVzhCQnczOEMrWW1hMTV0SXRzVFQ3NjlJZW92dndJ?=
 =?utf-8?B?a0dnNFVJUWI5OU1KOEkzNU1VN2diQzhxN3laUUlHRVhmWnppZnAwaS93VmtH?=
 =?utf-8?B?Y2t3MHNyOSs2RnRYQzJEQlVwdHZPdUJGMkNtN1hnTm8zUm9iNS8wTUNmNE50?=
 =?utf-8?B?Y3MrSm9aaWVQV3YyT1VTTXJhRW1QY0xEdGJSYy9EcG5rT05VYWJ0QVRkNURJ?=
 =?utf-8?B?ZklOTVltaWZ3dDZaTnVGY21MT0NLQlF4c1NVcmduNUhEMEZoZE12ajZHRVVK?=
 =?utf-8?B?N1RtMWUxRHNONXZsZlBTdmlUQ3hGTXJ6bWVnT1IweVlFbEZFWkEybWRWK3Q3?=
 =?utf-8?B?bDBlNForQTNSaWxXMyttQmt5ZlU0Z1Q2dmpweWZsbDhkV2VBb2tvek5RV2h5?=
 =?utf-8?B?UG5sbkw1alU1S25vOWxKU1VIZGJtQ1F0dGtEUHVybUtOemtyM3c4aE9aRFdN?=
 =?utf-8?B?NTg5RHcraE8wajhNTmdEMTZ6YTV3K3RJbWcyVlRZeldYeTZtZ1NkTWRoVGlt?=
 =?utf-8?B?T2Y5VVRZUndhalh1eCtDZll2czBRdzRMNzZLanhzWnhUU3I0YVMvWFlyTm5H?=
 =?utf-8?B?VlVPaVBJVE1LUUN2cDA4QnZyWDFuZCtsczNOR0VRbWsra3hqc2V3eEZhWGdZ?=
 =?utf-8?B?eU8zSUdWREJjdS9KSHZSaUlWQ0JKREVoeGdKcmFCZllkUmdBc2JRKzNQb2Fk?=
 =?utf-8?B?UXZQY3p2bnZiMUtjQmpvaVdOTEdLRCtrMDB3ZWVBV1Uyb3JTQlNyMmhiem1C?=
 =?utf-8?B?S3MrRERtL1RMMXBRdTl6cnd5akE3UFB6Y3NJRmhURDBFUTZORDNRdUNyc0VD?=
 =?utf-8?B?ajBmbzhOMm1wQ2NBck9XSmhaZmRGalg1RitRNFlCc1ZwVmNGOFVkdk9SZ3ZU?=
 =?utf-8?B?SjZmTEdKUGFwc2puK3JrUS90aU1LRXpyS2x6cUFtRzd4d2ZaUVRJdG5qVVJk?=
 =?utf-8?B?aGlhWGt1d0ZhbnFxY2dKcmErSUtVdTNUdmFvenh2WDAzWHVpTW1zQjAyRzZz?=
 =?utf-8?B?d0s4RG9xRXdQaFlnVW1TdzM5TW91bGNMazN1dnBZM3B5MWZKQS93OEdjdHVH?=
 =?utf-8?B?N0orRXkwdW1YM2hzek9QR01TMnFpcEQwY1o3aVhXaU5ORUNSUEJ6eFRxQjV2?=
 =?utf-8?B?UVJSM1VmRURGRllDa3hyNjY3VnFUVGxINkhBTlVyRjNIbWhrUWVrL2NGNWx5?=
 =?utf-8?B?TzhTYW9VM3lXVDMxL1o0YVNONjNvZ0t1Yjl0bUtSdXZEVkp1Tm5aOFluM1VS?=
 =?utf-8?B?K01UNm9YOUtlVGw0ZWROL0tpOERuQ2pPbVd0MldNSVM1U0V3cGJvNWdJd05Z?=
 =?utf-8?B?MXRJcElpVEhDVHVMdk0ralJob1lGWElhRjg0U21zV3dNVlBQL09CMkZBYnRu?=
 =?utf-8?B?bWNVa3JjTXQyYWVKeHRnbXd3aU1pRWVQVUpMdS9pVzhveUhLd2hnbVMwK0Qy?=
 =?utf-8?B?WHpaT3M0a0tZRzBRcldRcTVicEFoNHAyNFZlN3FmcEVRMXE2S1l5OURkcUVa?=
 =?utf-8?B?elFRSmZMeXRpYUJ0Y1hobWFJWjlqb0RhYVI1eU9WSjBNYjBxRktKS3BIZ1lk?=
 =?utf-8?B?SkpSNnpLM3RqTER5WDlsZUVuVFN5MThTWCt5RUw1eno4NUxNazR6NXRIMERF?=
 =?utf-8?B?cWNpeEk5d2JCajE4K09XcXBJS0dOSUlkcCsvdmpvZktZZk5kYzNHcEI5cmln?=
 =?utf-8?B?bkp5Q1EwcG9wMzFQS01CamdYbkdldG81K0xEWEtXNTRvVHRrOE9pL0VINXdt?=
 =?utf-8?B?Z0hFZjVleTE2c3NVYmFSYlR5Uk11bGlqdC82VXluUWxudEtldVBtOWwwcmhk?=
 =?utf-8?B?bEkzRXJkZHFpYUhlS3JBN1pNQ2RkMFZhNEdHQkM4ajZzZkE1aGxmaWpzdUsw?=
 =?utf-8?B?TENsMWUwajV3NHdNVWFRclRRSml5N2ZwQlc1UkhXRE01TVhFVTd0T0Rxb1Ix?=
 =?utf-8?B?OGFTS1l1eFZ0ZzlMbjdDSVJnVjNoRVZCSVNHTU5BL1pxK01YWjdrcjErT1NP?=
 =?utf-8?B?KzQrcjcvWlpRR0Fzc0xiOXo0b3JHOGVGUWx0ak1IbVdOS3R1VFNieTVIUzdQ?=
 =?utf-8?Q?YJuKcfquiuLEnM5efF7Txj1KsCZglO+4OL4ZGmLh60vDu?=
X-MS-Exchange-AntiSpam-MessageData-1: yETayOHvVKcGmg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c29cea-abb4-4c2b-6d43-08df13fb116a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:01:56.0692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1f/03n1/Ni57oMZWysbbNHBybIuIbz6Lk+g9zMr5JxUa75OB7axdM3u4qZ4yMuxXWtI7/sH+97g7Oe/Oi6ScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11657
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
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

On 9/16/26 15:27, Paolo Bonzini wrote:
> Explain why it is safe to read it outside the lock.  Basically, if
> the protocol is followed correctly, the reply header will not
> appear until after the request has been sent out in its entirety;
> long after requests[].coroutine has been set and s->request_lock
> has been released in nbd_co_send_request.  And
> requests[].coroutine will also not become NULL until after
> the reply has been read, and that requires nbd_receive_replies
> to finish.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/block/nbd.c b/block/nbd.c
> index e5e16722ba2..85842e7cdfb 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -141,6 +141,11 @@ static NBDClientRequest *nbd_request_by_cookie(BDRVNBDState *s, uint64_t cookie,
>  {
>      uint64_t ind = COOKIE_TO_INDEX(cookie);
>  
> +    /*
> +     * Once requests[].coroutine is set, it will not be cleared until its
> +     * reply is read completely; so it is okay to read it as long as a
> +     * request is in progress or receive_mutex is taken.
> +     */
this is incorrect as written nbd_co_send_request could
clean requests[].coroutine on a fail path. It seems
not a problem now, but in the future this could be
misleading 

the second part "or receive mutex is taken" also does
not stand. Mutex by comment at declaration does not
protect this field. I am unsure on that


>      if (ind >= MAX_NBD_REQUESTS || !s->requests[ind].coroutine) {
>          error_setg(errp, "unexpected cookie value");
>          return NULL;
> @@ -154,6 +159,12 @@ static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
>  {
>      if (req->receiving) {
>          req->receiving = false;
> +
> +        /*
> +         * Once requests[].coroutine is set, it will not be cleared until its
> +         * reply is read completely; so it is okay to read it within
> +         * receive_mutex.
> +         */
>          aio_co_wake(req->coroutine);
>          return true;
>      }

May be Vova or Eric will bring some light here.

Den

