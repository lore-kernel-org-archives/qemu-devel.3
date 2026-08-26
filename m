Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C34C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGlP-0005PY-Fi; Wed, 26 Aug 2026 12:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzGlN-0005P5-Jd; Wed, 26 Aug 2026 12:46:09 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzGlI-0000Tx-HC; Wed, 26 Aug 2026 12:46:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPrKD0kUGt9n0JUuDetmuBhWdOZOJv2qcsVEr0lmSJOD7A08H4PAirdgfb71mPs/rjen46RwkJG4Y12UvfsNZeqzANYodQvmMIVipHBzxd7sJEiDaxwj6QbSrLrzfQzcfDKvoAMyUUjXKpk4MWJP29NmEEedYYp4Jkopa3NllUke9QNG0f2pVOHLRexmG8xpg2tgKw96Uxn2m3P3eCelsNmZLAgDt2XPDczfgfi6AzDQpznnGUV2zc1OOrrpEZ8J3tcFsjQA2afLuSGZsTPv+kfgzNx9JL1gz+AcU4wOfkKD4rNvtwMGF3FdlN2QFEb7QHB7t+fK3xwEjGKYDOE46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFkPrccrcp4MyK6/yzlhhdHoywPR/9yqmjAYshBT8BE=;
 b=dMqVIP6DOy+NoE40SyQHQmcFcwUIgmesKwQ8NXDV3zTLhEGAJA1wgo3WNHJf0kjAO5E/JFoGn6ECZfYRf7FJe1WsIoXZzXf4BP6KrUxSlZkVL6I7Sq/PGN3ii/uye9S/WAYKaf7ea8pXPa4w9lxCoZjeYB8LgfrI/owxGRnSHyXfY2gUb0BX6fEh8EgHToVVRZnl38YFbsiViC0lrdOod4hnE2ecGpVv/jj7fleFzdWkeSK5p8a3xMlTV+ZQ4N8PENsC/lLGwbuslYD9oEMEvSkyczNoC4UH33j/WvKpb2oNiVKgPqKNqexoq3+8qGdhEyUaagL8kQ6oBoURFhp31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFkPrccrcp4MyK6/yzlhhdHoywPR/9yqmjAYshBT8BE=;
 b=roilazFYgZOQoQq63zrZJt/1rbCZGG/KRzkgrX2VWZOpxkMblhiVmNvN+S7ZM4cAG3xCPS/nM1jaHcURXUhfOQnk34/19Rn81RF0GAltVmJMCRgnkejmg4YWf8qKXlDpyjICxDWYA5LH+SmO0bhGCluoBn+sEt+44ufcMGyf4YkwBx5cO+aq1ZG5yPBspoA1zdTPJ3LWKj3u7Zg77fZ+FM2uH/0ggktBf11hHrzQFVHaAVqmajPHB4DGgQHd9PuDmp3YzBfEBXTttWNsyR2vbU3zlUXhCmmGuLgajJJAZr0WNVdD9OXiAhET+6NZjGt1TvEIeyBiVpK/c0v6Rizzpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAWPR08MB9517.eurprd08.prod.outlook.com (2603:10a6:102:2eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 16:45:59 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.004; Wed, 26 Aug 2026
 16:45:58 +0000
Message-ID: <84b7646d-0567-4af5-be98-a62f49beb963@virtuozzo.com>
Date: Wed, 26 Aug 2026 18:45:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
To: Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260817185942.1065143-1-den@openvz.org>
 <20260817185942.1065143-20-den@openvz.org> <878q5uo9a6.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <878q5uo9a6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0124.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::9) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAWPR08MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 1949d317-035d-4ebc-ab3f-08df0391810a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|18002099003|22082099003|56012099006|3023799007|4143699003|5023799004|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: KMJMuoW44Wxkaa2F7lkFsEMuVMPDG7fRXPTlbDW7Xtw/Nb3F42HHC28EK7sEENwrOpDO9HKy6TLJJ3KOVbzVtoIHuXU/oyN3rU6qGU4ZJQ4ouzwvgnOnRrtn5k9yavQWoW/UPRHxeQ51tDEfjMXJREAL9onCkfUjiDw/7UxGb1U/WZ4ExKOxLUT+/Vdo8G7iEqwkYNBl+Z72XXTw7KFuybINfoxr4favovTbtopVOgJilH2RAclP0KfBhKlP28zqXDEm0XBPhUYFWRFZmUpqzSc8FU/fYdwQtVpFfv62V6rc6mQ4ii2mjdb++WHoF8ydovPc3WgzVmWM1PcpRC4eFgBwZI7CEFrZ/H8Zpe1rlt/E1MImV2AqsE1h8A5JQQGHv4gNuz3CD+mY/r1xJDu6LmZ87dHOmwFJWzjw7zWx9JxHfNGheZsrOgvX0A64SmF2hJ3voaPA1F88eyX9fTefV5JnIni1FHrUFXjCN6bwnZQUn8puj33JmpaaiBiHZF0TYaUi+y5oLbndzTN6XIG4mCFmA/tPM9Xtw5YubfKRrzaTycyeIyPMVN8lQAlRVmWNXB2HnXXQF/aG4Ymzo9pWSBYXIQlaGkOHuLtWvydT/7Y0WMTunO0TV1L7b39Nd9chjuHZ8GY2qdbvkNVoXjtPqODCk0o3IK0tww91GF/Q/A8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(5023799004)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVk5QzNMbit2SXJtNjZoZTJlNkNBZXphQk15Rldabm5vUGVSYjhSMHZRaG0y?=
 =?utf-8?B?V294MkpYL2g0SGowZEQ2Z29vay9XK2VzbkE5QjRhOUJ6ei9pVDlodHJOTVI0?=
 =?utf-8?B?OTF4SThTcU9qZ1F4UkhORTFuZEJqazVabmxzYUovWGhkZ0lwUFBUNzdZSldt?=
 =?utf-8?B?dUZjc21wVXcrbUl1T3BkOUlONGZLYVVlL05iMWE5Y3FxZDl1Ym1saU9ZZjho?=
 =?utf-8?B?SFdDSVBYbEE2TW5EN1NuQlN4amp1YjRxVmVpVlhZYmd2NGdrZE16TGJ3SFd6?=
 =?utf-8?B?cHlCRnFabnNTalBZczdGVXdjMm9HRkY1dUR3UXNxSHJFcThJakhoOUtvYU1T?=
 =?utf-8?B?UzBOcXpwODBiUXhNZUNybmNqYThPeS9vN2pNVlJGQUk4Wm1ZRjY0cXJuSklO?=
 =?utf-8?B?VU5WbXJBZnMzc3Zhc3lMblE4bDdCa0NVUjY2aVlNWkJEY1I1VGJ4Ym1WOUxa?=
 =?utf-8?B?UlRSWmo1Y1lSOEFsZTUwNzZSY2tMdUIyNDZzUGZCaFEyVlE3R0ZOdC9qMkw4?=
 =?utf-8?B?NmhRUWtkelBUM05jdDY3ZlhBZVJlL1ZFTmp4Y3g3R01UMkNKUmRBcm9Fam1h?=
 =?utf-8?B?VnpsaHpCOUJ1dXJId1l1OUlkcWJFcVZ5VEtsQjBaVjV3aUpGV01GQ0lEcGh4?=
 =?utf-8?B?Y05SMVdVa2xCWWdLeWExSmUybzZoVUh1cWlPaDJDenJRZ1lvU2IxNjlsUkhr?=
 =?utf-8?B?eFRIajNuYWp6TmVRWUFPSndITmtCMG1FTVJSTjFCbzVlQmdVMWFpQXZUZXVC?=
 =?utf-8?B?dTEzdFdWYU5vTWJVaUFDRFZqODN6cHFhNWs1Tk1qUmR4aWFPRGFQM3NzZGF3?=
 =?utf-8?B?dndOeVlwQTc1cy8zNy9PVDlndEc2blRUQjkvMEpQZlBWM2tTRm9LazVROVBH?=
 =?utf-8?B?UTdQa0UyTVZzc3dEUzFla3l2eTJwOHNsREtMMDVBTFoxMk5talNnVGJrcFdp?=
 =?utf-8?B?Z1NYRmsyaFhVM1NtcU8ycGxyOXd6akowbndoR0xnUXBjUXAxaTFhRm4yRStO?=
 =?utf-8?B?ZUZQcVBCb2RUMUpJWU9kRkZsL3FUaDVFRkhnMGdLUzFLbU9Ia1FPaVIxTUVV?=
 =?utf-8?B?VjJ4UWJqc0s4MzJOZTAzV3g0ZjB5Tm5MTDFlV3FuNWw5OGRueXZFQUd6aWdR?=
 =?utf-8?B?cHJGb1FaeWFQRzY3ZmxCZnVFSWNSMHRYNnZnWTk2dVI2K01IeENydnYvTnFz?=
 =?utf-8?B?QXRhaERGVEJlRDEzU1IxR1RsZ01UVkVFZktYTHY5SW1KZkk3VWpuZGFST21R?=
 =?utf-8?B?YTEwZ2w4cktqMm5hU1lmS2JEK2pUTHE0aG5uV1VCS3VoNWdqY0E4TmxoaE96?=
 =?utf-8?B?TFNyTUlXVXJDS05uNTZnOG15RkxDb05uTWVGakRwaGp0b1p6Z05sN3oycURs?=
 =?utf-8?B?YVZFTlJFRXV5citRbkJJV3lRSU1nblZDSlA0eFEyMy8yUWdIeGVMb2UrWlFL?=
 =?utf-8?B?Ujd6aVpoWEZrTjdiVUhSUS9nYmVsbzZwK1ZYZGR1K0VaYTA2eFBkcWhDLytE?=
 =?utf-8?B?UWQ1VU1sUFJJU1U5eHo0N1pVUFNtMTByMXJ6UFh2RVhKL2lwSXNkaGVPanhR?=
 =?utf-8?B?S2ZZeFRoT1BBWlZ2NHpwcWc3a0xjMHZZVlVUMjJuWTJQY3RWOVVOVVJsdlRq?=
 =?utf-8?B?ckp1enljN0dTUlpNSTdiVEtKUyt0K1luQjU4eWhKekhObS82N3lXVzdsV0hW?=
 =?utf-8?B?N3lDbXk0QlUrdGU1dCtEdE1wa010b0lTZGlmRWxyWXNrTmViaGZSUThxaDBI?=
 =?utf-8?B?OUgvaXhCamJvMmlzRCthSTl0K204RmFRZnEwb21vLzYvZUJvdUxQV1orcHBw?=
 =?utf-8?B?N3RZZVdraFlYUVJCWEdNNGdvNG44SHFyUDdBRElvL0xWSWtrQ1AxVktWWUdt?=
 =?utf-8?B?eStiN0VoN2xaRlRtOXFFcXFrbGpBc3pFR1RSR09aWHphYWh5b2xWRlRUaURG?=
 =?utf-8?B?RUNsY2t5M0MzWEJNS2twalE5WDdjKytMRncydkdzNkFDVTlOallOWEd4eWZX?=
 =?utf-8?B?eWF1L1M3c1ZHOFZPY3V2WVNaMXpWSkFOcFAybVlXek1JdGU5b2ZsQ0FOK3lh?=
 =?utf-8?B?ZExoVC9kT0tuTXVFZWVTRVpHRmhTNnRDVHB5ck5sUzRPNitZL3NEQWQ2S1g5?=
 =?utf-8?B?VU4yaWtrb3lRYkZuU1JxSTBPR3F6eXhIcGtZQkhseDlmcTlxcTI4ek5BVFg4?=
 =?utf-8?B?UXB2VmxWRFlYWG9GenV3RDVrNkMyN0VLN0o0M09PMi9Pci9PNko3YzMzY3or?=
 =?utf-8?B?M29GQ2ZPM2ZoRWJZejZaYlgvbnlwaTZ0OStmSGJLWlR4SWdwcmplRTJtVXdt?=
 =?utf-8?B?b0d3eWhlV2RFOFoyQkIrV3ROMy93SUxwUGVEb0V5cDNFbTVFTlFLZ1RWWENm?=
 =?utf-8?Q?cJSrzUn7pM6FPIAjgozDYPZcZ9dToxtpe1VeXC7gb9AoM?=
X-MS-Exchange-AntiSpam-MessageData-1: HZgchCjXUn1Pag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1949d317-035d-4ebc-ab3f-08df0391810a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 16:45:58.1275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyVuHg3sQzCFLbjlZm3pUmEHy3mPeCgkH08qBOtaeZWzUCr7I3E9IFWoRUZNTW+QKAK4W2OqTRAY4JnQTWAiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9517
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

On 8/25/26 11:10, Markus Armbruster wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
>> From: Denis V. Lunev <den@openvz.org>
>>
>> Nothing tells which persistent bitmaps an image carries. qemu-img info
>> says nothing about them, and the only other way to see one is to export
>> the image over NBD and ask for a bitmap by name, which needs the name
>> beforehand.
>>
>> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
>> as qcow2 reports the contents of its bitmap directory:
>>
>>     Format specific information:
>>         bitmaps:
>>             [0]:
>>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>>                 granularity: 65536
>>
>> The list is built from the bitmaps loaded at open time rather than from
>> a second pass over the Format Extension, as every bitmap the extension
>> carries is loaded and marked persistent there. On a node which is open
>> that also covers a bitmap which was created but not stored yet, which is
>> what the field says: qemu-img info opens the image on its own, so there
>> the two are the same thing.
> The last sentence confuses me.
>
>> An image with no bitmaps leaves the structure empty, and
>> bdrv_image_info_specific_dump() prints nothing for an empty one, so the
>> output for such an image does not change.
> Output of what?  I guess it's "info block" and "qemu-img info", because
> these call bdrv_image_info_specific_dump().
For the image (BDS) without dirty bitmaps the output
of 'qemu-img info' would be the same as with and
without a patch.

>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
> [...]
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 1f87b07850..4bc8b45efe 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -200,7 +200,7 @@
>>  # Since: 1.7
>>  ##
>>  { 'enum': 'ImageInfoSpecificKind',
>> -  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
>> +  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
>>  
>>  ##
>>  # @ImageInfoSpecificQCow2Wrapper:
>> @@ -255,6 +255,41 @@
>>  { 'struct': 'ImageInfoSpecificFileWrapper',
>>    'data': { 'data': 'ImageInfoSpecificFile' } }
>>  
>> +##
>> +# @ParallelsBitmapInfo:
>> +#
>> +# Parallels dirty bitmap information.
>> +#
>> +# @name: the name of the bitmap
>> +#
>> +# @granularity: granularity of the bitmap in bytes
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'ParallelsBitmapInfo',
>> +  'data': { 'name': 'str', 'granularity': 'uint32' } }
>> +
>> +##
>> +# @ImageInfoSpecificParallels:
>> +#
>> +# @bitmaps: A list of the persistent dirty bitmaps of the image,
>> +#     including the ones which are not written out yet
> Pardon my ignorance...  Is "not written out yet" relevant to a user /
> management application?
This means that the image on disk could contains
bitmaps A and B while backup software has added
bitmap C to BDS. The query will return A, B, C.
This is same as for QCOW2.

> ImageInfoSpecificQCow2 also has a @bitmaps member.  Its documentation is
>
>    # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>
> Are these "persistent dirty bitmaps" as well, or something else?
same, as above

>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'ImageInfoSpecificParallels',
>> +  'data': { '*bitmaps': ['ParallelsBitmapInfo'] } }
> Please put these right after ImageInfoSpecificFile to preserve the
> existing order of things:
>
>     All the ImageInfoSpecificFOO in order of
>         ImageInfoSpecificKind members
>     ImageInfoSpecificKind
>     All the ImageInfoSpecificFOOWrapper in order of
>         ImageInfoSpecificKind members
>     ImageInfoSpecific
clear, will do

>> +
>> +##
>> +# @ImageInfoSpecificParallelsWrapper:
>> +#
>> +# @data: image information specific to Parallels
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'ImageInfoSpecificParallelsWrapper',
>> +  'data': { 'data': 'ImageInfoSpecificParallels' } }
>> +
>>  ##
>>  # @ImageInfoSpecific:
>>  #
>> @@ -273,7 +308,8 @@
>>        'vmdk': 'ImageInfoSpecificVmdkWrapper',
>>        'luks': 'ImageInfoSpecificLUKSWrapper',
>>        'rbd': 'ImageInfoSpecificRbdWrapper',
>> -      'file': 'ImageInfoSpecificFileWrapper'
>> +      'file': 'ImageInfoSpecificFileWrapper',
>> +      'parallels': 'ImageInfoSpecificParallelsWrapper'
>>    } }
>>  
>>  ##
> [...]
>
Thank you,
    Den

