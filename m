Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E43C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzce1-0003OK-VO; Thu, 27 Aug 2026 12:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzcdz-0003MN-MM; Thu, 27 Aug 2026 12:07:59 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzcdx-0007WH-Gt; Thu, 27 Aug 2026 12:07:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqXAQ4GtdskwoBmtzZZYm65OWHkkoSxvVR3RMRjgrsj8tjSYnvBCqAR32eaizoLWXs7/Vfx8o5MymtvOyNWamW3a9kJL9VRCyu7dbCO3+BwX1HJVUm0+X6edcGhtfx8J2eCPSIvZEXVU9ZvUZd+Nuxc7YSaNHj/0U7T953JOdAkFk7K2vOroSsezTI41vyYD6sPn4euENOyftpSx1XQPdpGSCBUROJLj5fELHzCiezz65pVfRkeHO4txFAwRf8wJVBV2Kjl30W0VXNGVBiG/bumyNFPfbjHyWAcUpDXoq/DBnOWdxBUMiBNF+V2gkg1PIFR7dEzOyuKIBQZskhSBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QtAkU4kJn3F3qPO3CPQPKeqiFhHxcIYBjyHCY/fKrs=;
 b=UFzN5YfGNwbr6WCIF2nQZXUWJ9KxKkpZrKqdmf1atKtkzKcHA4xV/0W26MpX9oW4Su/URC3y9L6rJfhluElvQB5gEnjopnU+danVqayNXS1IFW7dyjJbdG1ZODLlUcZaeS4u8r9s3+I7lzrm4VPRK9pGt3zYfYNvY9i/DXk9cbFexFViiYeMKMtyHdSu7kgvzDDXp1qoGCKg0uOKMr1xd3wu5n0s2wZHQlsq0u0Ep02RORRo/Hlmlqsmu7SfjJY/34bc856WKne3IT9AdFRpLjT/DPdOY3m8HnZCLhHducEHX8CEplFZPuCw+flQCkeMXrVtcsRcd2/aoclGddHZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QtAkU4kJn3F3qPO3CPQPKeqiFhHxcIYBjyHCY/fKrs=;
 b=vr4aSAeFoSsEjZsIE48IJZfLJV34AjErPHRX6lwjBzIb40Vq9B4OdpXd2YqRQb7fyZUjfK3+uAGb4uJvimejCj5rOBqF3GcAi72/NeA3AEM0gY3jrRhs8fMZaEWn4f1RoPV8aHq1GVx0xyK/AGKc2Zj0zF2VKLKgJls2VONmTZZd+0zfF9tMwAA2Oy6OobEV6neIKnTZ7e1yoOx6MbTTq/APbcpfBMqHQDBZ200GlCM7qdI2Ij1v5ssU/uuhwxtzMqayQygfD6ZZp7zn/wKqZuE/rwxN5oLYZhBdIgsORCfqreYnmVYOTEk1stP3Vo8hYezTLqUNjlkyBjbey6sRww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PR3PR08MB5705.eurprd08.prod.outlook.com (2603:10a6:102:93::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Thu, 27 Aug
 2026 16:07:53 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Thu, 27 Aug 2026
 16:07:53 +0000
Message-ID: <324cc650-5ab8-4873-b912-233ab7f04720@virtuozzo.com>
Date: Thu, 27 Aug 2026 18:07:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
To: Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20260817185942.1065143-1-den@openvz.org>
 <20260817185942.1065143-20-den@openvz.org> <878q5uo9a6.fsf@pond.sub.org>
 <84b7646d-0567-4af5-be98-a62f49beb963@virtuozzo.com>
 <87v78wezl0.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87v78wezl0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PR3PR08MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 139b728a-5c2c-4bfe-8517-08df0455599a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|376014|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: ITBH2seaUYY2t5z1hYsGP1dTLdC2DNUek3whwFyt0orOkgaTepCVAZC8w6lYrUTSJ7j9oyCU8bNPhBSA+BaA5nzu69OYyRf3bdA1mTsArhh4hR6f5rfpl5wv+pMIGk4lEqkDfagzqqSbbPLYX6QDBBLopX1JF5bruHqMluCJOPf6NEubBWaEfNuv1S2jp4Sxr+GS7nJ40y89OGsM3uykhP7Wu/OuEyZKTco6pptxtAqIOHUMVX1j6N4ePM86/ARKL8Xpqij1E2JvAHZFHkQu3bd8kq/vXfKE9nCM74qBwkdHoPXYCyjz98CXCRbO9icT68fpX05rl6bB6qfTj0mkeN/hcs9plqiYwCQyiYVBW6aDNGNpj/pSaT6hdI9gJi6D+rJZEf0oEe8fIqoNUMIWnhjKxCTLD97CHGZdg+y/uFzGwrGkmhgTyYyvNVfqjclS7TA9B5hjqtT6SDE1p/LOh8nLnD/nhzEvPYFlt3blXSF6xIQxAvxtJusumT3x3IPS7SNSC+XLg9ozo2lrKJyG52zNpZyyrNgC3h0tLhm6imJ+Yo5+2/xpAuAxBk6qnWJgf5LONY4j4VbP/ZIMK4VsDPMRuXDGbQSbotJh1VTYuAoSsNzO6KCtwmjBRksj/SPFwRtlQgS4aeNGyjYlom9yMPUhczOh6oUHY4eJ+fftbt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBMSzI3S2hCb25uQ285ZDBUMzQxQ0ZOb0Q3bzViSlhUdU12MVFSNnFVclZY?=
 =?utf-8?B?Q2RTL2U4V0FzaEhsTndBLzdXcjZPNFFUUTl1eE9lSkp5UnhqNUZLeEJWNnVF?=
 =?utf-8?B?ZG1veFFnbmkrZ1Blc0VqWmluS2NkK2lOMGU4cnRhWDdHc25rRFhLVVNxZnhh?=
 =?utf-8?B?RHN4Y05hT2JOaGZsdExQM0FJLzN6MVphYWhlQ1lOWDMvYnRNMnNqbGV0M2VN?=
 =?utf-8?B?SE9WVDR3bWYya3FTcHBFRGZLZEc2M2MwYVFKMVR5bENURFY4UHN2ckh0TnpI?=
 =?utf-8?B?QlI3R1g5TjgvSElLRU45V3dGeVhmaDdCUmlDaHkxUUI0enFZSzl4aURYT3VQ?=
 =?utf-8?B?MXBBTWsrbFlFME9MMzhzWnZJTUdMZVJZRUI0ZmFjRlNXWi8rSUlwdTZKQVRo?=
 =?utf-8?B?M3c5eHNSdzBmVm1LMElveFlIWFR1cVRjMUhlemFUdGNwWUhJNmJYeXE5djVF?=
 =?utf-8?B?Nk1yNENVZklKbjYyZDN5SkhSQ21waE83TFNKaUpJb21Nd2ZvUEY4RTRXaDVz?=
 =?utf-8?B?d2lPWFZSUUp5UnJycUhKY1pxRVBrYWF2UXZXQ1IzOHNjVHJxZFdoVjRUTWRv?=
 =?utf-8?B?WTMvTjZnN0pjM2dMZDI5OXk5V3NpSld1VGUvTUZwN1dOU3o2ZVdCY1RNdm9X?=
 =?utf-8?B?aXFaK0pTaDhod09Ga0NDMTBOaUQreGtHNkdjL1dVcFZBM0F6TCtxbzJETU5N?=
 =?utf-8?B?UU90d0M5dThRaTF4SGdnY2I5Zis5akJnWmdlcmVVKzZtaHpZamR0UkJuNHV3?=
 =?utf-8?B?bkp0SWNoNk1sWkhyT1prWE5xQ0ozbVBXQWdmNlNMbDlqUnhmWXR5bkVvd1lI?=
 =?utf-8?B?N0xBMjQvZDRmbmlLVGs1VndVK1gxc0IwWmlHZEppNisvclBSZm4rT1c5NGU3?=
 =?utf-8?B?Vkg2MDFZb0RneGNHUWNadk9YT0kyQlZQQW1scnVsUFFWdEFTRVBySmozSTV6?=
 =?utf-8?B?amRNSmJsMkJZTVZPV3pxQzhoZjZ0Q09NMGpTd284ZjhNM2lnb3ZoQXYvUnM0?=
 =?utf-8?B?QXdVbzdzR2RSYjJoem84V1VoZmk1UEJacDljSm9yQjQxYVdyWDhaVStlUkd2?=
 =?utf-8?B?dXlxQ2duUkpXa2wxS253dDZyb3IvMHBQMjVKN2ZlUmcyM0g1SmNsczBjbWlr?=
 =?utf-8?B?M3I1UGxRQWZLazBJSVIwaWZKNG1jVzc2WkswaldFVE11UGVlcjdxOEpWRVlH?=
 =?utf-8?B?eldLUWlBS1dvUDMzcXRLTy9qSzBrT3EwdWNYazFoOHMzaDVqdUNDMnpDMktU?=
 =?utf-8?B?WVpTK1czeFlqQnVJL1V1QXFDSVlMbXVvbnBLeThOREp4WDQ2ZHI3bWFJY21m?=
 =?utf-8?B?MFF4Qmdkc1h6Q0tqZFZsaTRoTHdMbEhLSkI4b004Z0FNcFRjYTV6Z1RrOE16?=
 =?utf-8?B?Ynp6OVlhWkZ0d0hpNys2djdYekVlQ3p5d0NHUUF5VDR2RWoxWWdubmhTRlE1?=
 =?utf-8?B?YllVdW9YS2Z6TjlXdnlNcTVaa0dlUFBQWUw4YSszeW5wMVlaYjFwT3JIZStO?=
 =?utf-8?B?and3ek1TK0s4TjdoSWIxQTNRRk03Y1Uxd3hPWms3QXVHR2RzaklWdWoxSlpK?=
 =?utf-8?B?aE1Sbm9idE5WaWlHU2xIZ0IyTnFKMzMxKzE0cVBuWndPdUNvK2ZtdzZoUGFN?=
 =?utf-8?B?M1VmVU4waG8wRndGbk5kU1ZzRktSZTg5RnZFZUIxM3pBQ04yOXlHQ1JzWTds?=
 =?utf-8?B?cTM0UDRsdmR3c2lFbHlubENNT3pxN1JjZmFwazNkUlgwUi93Um5pZTRwUzhI?=
 =?utf-8?B?bXRpSkhBU1VrM3Z1MEtBV0N4ZTFYZ1BSaTQ2anhRTnlLRDRJWVZVeEl5MjJs?=
 =?utf-8?B?eDRkbW8yNXBQWiszNkE3em9udVJ2WllsNFBNWXhkK0VjZWZoNEREMTE1VVVn?=
 =?utf-8?B?VkxTdFNMZ3k0ZDM5aWVoUENmWHM4MzY1cGlBRURtSlFWakRJbmNXUkMrRnNz?=
 =?utf-8?B?ckdRS0YvOENCcFJOT2xmQWQxVW8yTGRkN3FBNzZ5eWxqdUVFUDUxMEdZMmt3?=
 =?utf-8?B?MDVmRkM2dWhVbGhkVERGMytnTkdIcGJSVzZmNXBQZVREdnRZYXFCcHhoa2pT?=
 =?utf-8?B?L2xha3MxR3dLQmNhVDRFdEg5azdCR3BuSWowYnM3c1RDU25SVU9zUG50d0cz?=
 =?utf-8?B?c2pLV3lDMyt5a2tabng2cVRpL0M1Zzg3cStjc1lmTmJPVmJrdENPZmdRUW9p?=
 =?utf-8?B?OFNUTjZibG13ZlV1MTN0dkludVV5NFB2SW5EVU1EcjlEWkNvdnMyK2lWTzYz?=
 =?utf-8?B?TCtjWG5KdnJRa3AyRGtDS2JVNDd6ZndKcm9uWjlRSkJXTWRXd1kydDVsU3FD?=
 =?utf-8?B?MzA1WFFMMDV6Y3JnOEZCNWt2eUJSNU8wRU1Sd0hyTXg0VjIyKzIwZDdIdkhu?=
 =?utf-8?Q?H1vpeA8wv/g/OXY50SXvKcC6AJW3izACwVVdDLY9jM3ji?=
X-MS-Exchange-AntiSpam-MessageData-1: FshrFZju783qLg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139b728a-5c2c-4bfe-8517-08df0455599a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 16:07:53.2517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdwWyCs3wWtNH/In2WiRCv+IPNC4mDpb4eT0+MOaB/80GI9Thmitvfk45qA2ceSfVTWMlc3o/xY5KAGn8PlvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5705
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 8/27/26 10:29, Markus Armbruster wrote:
> "Denis V. Lunev" <den@virtuozzo.com> writes:
>
>> On 8/25/26 11:10, Markus Armbruster wrote:
>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>
>>>> From: Denis V. Lunev <den@openvz.org>
>>>>
>>>> Nothing tells which persistent bitmaps an image carries. qemu-img info
>>>> says nothing about them, and the only other way to see one is to export
>>>> the image over NBD and ask for a bitmap by name, which needs the name
>>>> beforehand.
>>>>
>>>> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
>>>> as qcow2 reports the contents of its bitmap directory:
>>>>
>>>>     Format specific information:
>>>>         bitmaps:
>>>>             [0]:
>>>>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>>>>                 granularity: 65536
>>>>
>>>> The list is built from the bitmaps loaded at open time rather than from
>>>> a second pass over the Format Extension, as every bitmap the extension
>>>> carries is loaded and marked persistent there. On a node which is open
>>>> that also covers a bitmap which was created but not stored yet, which is
>>>> what the field says: qemu-img info opens the image on its own, so there
>>>> the two are the same thing.
>>> The last sentence confuses me.
>>>
>>>> An image with no bitmaps leaves the structure empty, and
>>>> bdrv_image_info_specific_dump() prints nothing for an empty one, so the
>>>> output for such an image does not change.
>>> Output of what?  I guess it's "info block" and "qemu-img info", because
>>> these call bdrv_image_info_specific_dump().
>> For the image (BDS) without dirty bitmaps the output
>> of 'qemu-img info' would be the same as with and
>> without a patch.
> Suggest to clarify 'the output' to something like 'the output of
> "qemu-img info" and "info block"'.
OK. Clear.

>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Cc: Eric Blake <eblake@redhat.com>
>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> [...]
>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 1f87b07850..4bc8b45efe 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -200,7 +200,7 @@
>>>>  # Since: 1.7
>>>>  ##
>>>>  { 'enum': 'ImageInfoSpecificKind',
>>>> -  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
>>>> +  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
>>>>  
>>>>  ##
>>>>  # @ImageInfoSpecificQCow2Wrapper:
>>>> @@ -255,6 +255,41 @@
>>>>  { 'struct': 'ImageInfoSpecificFileWrapper',
>>>>    'data': { 'data': 'ImageInfoSpecificFile' } }
>>>>  
>>>> +##
>>>> +# @ParallelsBitmapInfo:
>>>> +#
>>>> +# Parallels dirty bitmap information.
>>>> +#
>>>> +# @name: the name of the bitmap
>>>> +#
>>>> +# @granularity: granularity of the bitmap in bytes
>>>> +#
>>>> +# Since: 11.2
>>>> +##
>>>> +{ 'struct': 'ParallelsBitmapInfo',
>>>> +  'data': { 'name': 'str', 'granularity': 'uint32' } }
>>>> +
>>>> +##
>>>> +# @ImageInfoSpecificParallels:
>>>> +#
>>>> +# @bitmaps: A list of the persistent dirty bitmaps of the image,
>>>> +#     including the ones which are not written out yet
>>> Pardon my ignorance...  Is "not written out yet" relevant to a user /
>>> management application?
>> This means that the image on disk could contains
>> bitmaps A and B while backup software has added
>> bitmap C to BDS. The query will return A, B, C.
>> This is same as for QCOW2.
> Will bitmap C be written to the image, and when?
On close. Same as QCOW2. This is done usually on VM stop.

>>> ImageInfoSpecificQCow2 also has a @bitmaps member.  Its documentation is
>>>
>>>    # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>>>
>>> Are these "persistent dirty bitmaps" as well, or something else?
>> same, as above
> If they're basically the same, then their documentation should be
> basically the same.
OK.

