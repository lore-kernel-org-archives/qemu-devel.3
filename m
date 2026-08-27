Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F5C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzccj-0002tE-7N; Thu, 27 Aug 2026 12:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzccf-0002sD-AR; Thu, 27 Aug 2026 12:06:37 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzcca-0007PH-S0; Thu, 27 Aug 2026 12:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwV/ApaL14xmBNdZozA+2IuikmW7xaP/06aW7KZnRTFERzXxS2j8Y6tmbVZnK8y2Q7krQuqtkOWiPPkOcQRrGtN92N/QuI71aAGi0XUHTeXfLznmw1JaZ9JNAfyM+j4ieaD6JkCiagbkZ7bFPDA/b+PvkMapc1ZPN9xy54BO5QUjN22oUsrL/I+XD/cu4bxkoUAf8pMZOgFgLFB29Jj/qMcxOECseHiuA/gohXoJqaioIUOm8eieEZ4DorB70CwXc8rNwjIiVwv7uw+tRvDJIYKXIuyOCw5hYApsvgqb/oymgluuHOV3qpefOIygTx7YETU/WxSncfxWEV/X+s7l9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I42n5TNCXZMGH+x9N99IVYsZ5qZk6O7uRJIAbt3UA2w=;
 b=eHEIXgDIYqdp+2CJWaDUBiGKSjPeM6soFPMi3OhmfykXDMnNO7DwKeRG77bqVmeDXjTMHUOys7eU9taXoZmju+gPIRl0eyl7p+ORGoQTmkelzvQEo0K99nwhHD3KYciB3bOl1GEzADCn582gT4RZFVh8XmuvnNlq0KJBFDduMcT++rrxNyRmp3tGoRR1zoO+EB43nWx55DVSC8Al7pKRNzssEtwiGnBqxNpBB29JvQULMBW+5dmGFznUXl4pyCvPePbm21HmIJrpqjJCP50Fi7dS1FNOw1CBGldnBzzlXEEHgDnDuBxokcgqrxqOX8AwQpHufQbXj7PGdRcZEJWicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I42n5TNCXZMGH+x9N99IVYsZ5qZk6O7uRJIAbt3UA2w=;
 b=RDwjY77ENLLeosHVsDnGpWERwPBXF+ewYWdJk64YZfDaXNog4mi+XHyCuAZGxHxHRgvR1WXk3h2TDkLr+M/BpIuyQwyces/SvX7BrdCX16GG/aQ+oS7Es+jcC73czePs07i6/0T91fKuUx43J3usgSSzmYbsP6+K7+LzZZW0e/ln2iTBOvTg7LIGA1xYea2vV9QhQ9PGDn1ozisRjo4ezO2x5tA/g9uejeD5a/KiIhdDzV4tZi1Y+G7q5UfrPNfz0+ZjdoqMUwrInN5L2w7x7KfcHLlBu65ntl+1USrje5UJyUYlhqhKn60HzMJom5E/CyFUZbomUwb7zqw95hPMlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB8564.eurprd08.prod.outlook.com (2603:10a6:10:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.6; Thu, 27 Aug
 2026 16:06:27 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Thu, 27 Aug 2026
 16:06:25 +0000
Message-ID: <aacf393c-2688-47b4-a507-18119dc6d199@virtuozzo.com>
Date: Thu, 27 Aug 2026 18:06:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
To: Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-6-den@openvz.org> <87ld9umth3.fsf@pond.sub.org>
 <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com>
 <8733w0j45n.fsf@pond.sub.org>
 <0880ebd0-d548-496a-9832-eb4e58c46594@virtuozzo.com>
 <87fqzzgc13.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87fqzzgc13.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:50::15) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b637f2-978e-4c44-b40d-08df04552523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|376014|1800799024|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: F/ZmLtC8H4OWtX/UhuWnnEM0+0lRBBwITzgge9tkV8aiOCmam7NaNZNl2TvMJqZGDS0ZPAv1pBbdowWuvp4Ry+z+gTQngsiu4AndKR7+Y5A+21sm/SuclEhkVss9WkIQT6Efa00oCyaIfVmnDUKxR5T943UvrIbR7/cgJn71D6IdSS9qKh0HSCdI7mKQZ6k4Ua5TLa+NPo0kV7ZpnTR5inKH8mJLYiYxVgC7xA8z20+aVRITetPx3W/w5ofn0FL3S8P+EctDHMO8+VenKKqB2N51WPTLUbuw+1FxiA5yAvYlCPyernC7snkrAd8bYc6ggMUuBMYx+NwxTfVQV9hJonD1tcMiXAddjUsew42/xD37ATrYY5OE1RcSrMi08+ZZhn66XOzsgT3jWB3MvD4kmkVlLSKkIItQW6HB3KldkAfRSCah5ZeAFezVrgaYpzPaYefpCGLixrQuv//+9kYgWf7L8JvvkChawwossp6vXqz0geGSBVNmOdg9c/Y9l/a7j1KrAatqq4ZFY/84VcrhvgGIuGBXgri9sxXmeSzNLI8UV3FrZ7Wfvn9hPN5dg5vEo1mtKK3+qBc3vaROmepsI/OgvdfBFT3MDBRHqXFa+AoPSWkzf2ecHEuobcBRy1gPc7zSakFa49LoQxMGh9TZILs4JgJKwRpVb/A3yeiPvZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Syt2YkZ0V0RGYVdFYW5iZFZadG83QVRzODdTWkRuUEo0V29ILzBlbjA4OXhS?=
 =?utf-8?B?bWw5OHZPSzJHbVN0eGIxUmlDazZRWEVOWDV3TE5ZZDFCelp2U1BTVENhT0NQ?=
 =?utf-8?B?bEtDR0gyU0pnaGpUNHEvSG1ZOTcyTDZURUoyRGRRT25xOTZJc1BUbTNpMmRm?=
 =?utf-8?B?a3EzdVdCSnhHb2YzMDczNFZlRWExbXEyWDlyZTF6dFBva2h3V0RLdjRndUhK?=
 =?utf-8?B?bHVVR2d1M0hlYXZIdlNaQnJEKzNVa0ZrN24vOUg1bFNvcGcrU1dFcGp0bzFP?=
 =?utf-8?B?UzJjcWliNTh4V1VMWmx5QjdldWVWZ1kxM3JqV2FCTWdZVFJJR0dLc1pEYnNr?=
 =?utf-8?B?dmJ0VFl2SnJ2MnFtZjV1cjhuSkxiemlNTXFJc1hDNjhvb09wNFJpY2tobm5Y?=
 =?utf-8?B?NXlHY2llZ1JJS0pzLzcxcExSRXFKMFM0bSt2ckxDUmw5VUVtVXlSY09Tc1Mv?=
 =?utf-8?B?QTE5UnMxeWlHb0hHeVd4S2NZM3ZoZDlVd3lZS2hKbE94KzE4WmdXSDJhcmhk?=
 =?utf-8?B?cWRRYjVGNjNJdVFCK2RjZnZtS0p3a2FMS3B4V1N4UGtZSGhuWkVmQ1dSY3ZZ?=
 =?utf-8?B?MzdaaGw5NlV2Q1V0bkhjOGtZd1dQS1J6bUp0UzB3dm92QnZHdnZ0cnk2VzFQ?=
 =?utf-8?B?am9nQmlOVjdYMmlzZXB4N01nK3Ntai85dFA0RXZGQ3J5ZXpBQnhWck15REps?=
 =?utf-8?B?My9lM2NVL2E0ZDc0U25TQi9OSHF1WHBDMmFYMGVaV0pFVGFPdXByMkpydnJr?=
 =?utf-8?B?N1QwNStIeDZPekwwQmljY1pPUVZOZGFUaXIrRTluc3kzZUcrZkZ4akpCSUNG?=
 =?utf-8?B?ODNJTWJzYmZOUWZveW5nbjlmdEIzbVlmRUszMkJsa0xjdFRwcWEraXliL2Y5?=
 =?utf-8?B?MFBhRUtFM2Jza0ZmdmlYRW53aWlzdFZrcGJKZzBvcnVDQUpQYW1jdTNPazAr?=
 =?utf-8?B?alFXYzJvVHZSQXpyK2pWZzJ6dEoxY2lzTDJwNEZ5ZDVjclR4U1llSFdpdFpD?=
 =?utf-8?B?TjNTdnJQMUxPNjhnV3JqQnU5aUZiZlFLWmRFR0R0VDZpd0t6c09YeVRvYURK?=
 =?utf-8?B?NEhzcDhhSFE3N0tORmdhaWwzdDd6R2RYVGkrVlJUUmVLUmJCb1MrMFZqbWZX?=
 =?utf-8?B?S3d0TGJId1FlN1hycmQrQU5mUmNhcGx1MEJHK2p5UDNnZ0dEZWxNaU1sSjJ6?=
 =?utf-8?B?aFdJMmxBN0Y2RUlBS0pxcnZpVEs5QlRONmlvdE4wbndmcFIzd1BqeXBhYjhM?=
 =?utf-8?B?cUFibW9oY3F3Mitocm9ncXM1YVRmdWRONWpkcWZaOXJ2c3NHUHpwdTR6czNu?=
 =?utf-8?B?UVN4emFYMjlVUmJnbFZOZ0I0MkNOV0hDMEFaTUc0em1tODVtNTQ1WVc3d0U3?=
 =?utf-8?B?M0R0MUpqZkVHdEY0QWZieWwrbjBXSFBJTXBqem1xUDlvdUJCWTg2UVJ0dXVa?=
 =?utf-8?B?NVZNU1h4Z1JpV2FmTzVLbEpmb2ZaMndtb3l5YytGQ3JYQmQza0hMQ29yc3RR?=
 =?utf-8?B?MyttNE9iYWpYeWgwR200TE9INTJ6MmpZL09SSVJsUG4zUjNDSVQ4dzhGOUM2?=
 =?utf-8?B?OXJSUENzWE0zQmFMa3U4OXpzbFB4NWRYNjNnWE1qZGJSN2hMRWI1bnE1L09v?=
 =?utf-8?B?Qnd6Q0xuUkoyUnlOVE1OQklZMUo0UUg5T2FEWWMvOTY3NUxBeVdwNVByZEVY?=
 =?utf-8?B?dUs0MDlZU2VqeDBnMUJQaTdtK0M1S2IzZFBCZjhUYXpFWnp4c1diSE1hbFRO?=
 =?utf-8?B?V2xxRytkakk2RXhMc2ZvNHRkb0Fqc0dtSmpwZHhac0JSOUk1OXJ1aVVCVHdl?=
 =?utf-8?B?c1VvWllBTWhiUC9INGd6b01Fd3VrTlFtcWhoZ2hKOEc4RUtxd2xvRDBuSTZm?=
 =?utf-8?B?ZkJKb1N3SEhURVJlKzltMzkyeW11aUxDZnFUT0RzbW93TlB5M3FnTVdpNkdz?=
 =?utf-8?B?aXJzVkNFQlZpYnlXajMxT1p5L3lKTlpEbDNRTThQNmpabExiam5ucGtTanJU?=
 =?utf-8?B?Rm4xQm9TWWZSK0E3RGZGUGpmQ295VUc3VlBQUXJMZ2dTbWJMS1ExR29zOFA2?=
 =?utf-8?B?bWF0QmZUR0h0ZEtxUHY3ZVRrZmNrRW9VNG5TZzc5WVBHeXRlLzBvZGJJV0h2?=
 =?utf-8?B?S0ZBKzd0ZG5IbVIxQ0ZMS1JkQWhNRVROYTBickZaL2RDK2RXdDZjc0tLaVlX?=
 =?utf-8?B?TzNzVTAzVGVud0ZlWGdJQ2hiVnVJN3VmVWUxeWJnL25ZbjhPMFRMU0xjaHd2?=
 =?utf-8?B?UlZJakxrcmZTU0FCMFh3cUllMmE2cXFjVDRndGZ3aUVMaDRTYmRhaDdTN0dt?=
 =?utf-8?B?Z21Ea3o1akxEcHB4QkV6S0cwWUI0ZkhuZXNISVo1Vm94OVNOTGJVQ0JaUncy?=
 =?utf-8?Q?LPWEICpEuoJEY7Y1OiAOjfg7N4mBlZOcgDREZ0wRMCryv?=
X-MS-Exchange-AntiSpam-MessageData-1: gMl6dwYSw7YmPQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b637f2-978e-4c44-b40d-08df04552523
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 16:06:25.3746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSazzm54N/0lG90AqqT1BXIv75bCyEexP9cENms2FGT0S6cP0FLjfNg2MFNYMJSyOecZByzx7PNVL/kjUWidTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8564
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
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

On 8/27/26 11:15, Markus Armbruster wrote:
> "Denis V. Lunev" <den@virtuozzo.com> writes:
>
>> On 8/26/26 17:24, Markus Armbruster wrote:
>>> "Denis V. Lunev" <den@virtuozzo.com> writes:
>>>
>>>> On 8/25/26 11:37, Markus Armbruster wrote:
>>>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>>>
>>>>>> From: Denis V. Lunev <den@openvz.org>
>>>>>>
>>>>>> A dirty image must be repaired before anything allocates a cluster in
>>>>>> it. qcow2_do_open() does that, but only for a node that is writable
>>>>>> from the start. A node opened read-only skips it, and nothing revisits
>>>>>> the question once that node becomes writable, which block-commit does
>>>>>> routinely: commit_active_start() and commit_start() reopen the base
>>>>>> read-write for the duration of the job.
>>>>>>
>>>>>> With lazy refcounts the on-disk refcount block then still accounts for
>>>>>> the metadata clusters only, so the allocator restarts at the front of
>>>>>> the image and hands out clusters that L2 entries point at. Two guest
>>>>>> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
>>>>>> stays clear, and a clean close clears the dirty bit, so no later open
>>>>>> repairs the image either. The bit also stays set for the whole writable
>>>>>> session, so a node which is merely writable says nothing.
>>>>>>
>>>>>> Refusing the reopen instead is simpler and keeps it atomic, but it
>>>>>> leaves nowhere to go: the base belongs to a chain the VM has open, so
>>>>>> the qemu-img check -r such an error would ask for cannot take the write
>>>>>> lock it needs. The repair does the trick in most cases anyway.
>>>>>>
>>>>>> Do the repair in qcow2_reopen_commit_post(), the earliest point where
>>>>>> the node is writable. An inactive node is skipped: bdrv_activate() calls
>>>>>> qcow2_do_open() again through qcow2_co_invalidate_cache().
>>>>>>
>>>>>> commit_post cannot reject the reopen, so a failed repair takes the
>>>>>> driver away from the node instead, which is what stops writes from
>>>>>> aliasing live clusters. qcow2_signal_corruption() does that as well,
>>>>>> but it also sends BLOCK_IMAGE_CORRUPTED and sets the corrupt bit,
>>>>>> which qcow2_do_open() honours by refusing every later read-write open.
>>>>>> The image is dirty and unrepaired, not corrupt, and qemu-img check -r
>>>>>> still fixes it, so neither belongs here. Return the error and skip
>>>>>> the bitmaps.
>>>>>>
>>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>>> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>>>> CC: Hanna Reitz <hreitz@redhat.com>
>>>>>> CC: Eric Blake <eblake@redhat.com>
>>>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>>>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>>> Cc: qemu-stable@nongnu.org
>>>>> [...]
>>>>>
>>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>>> index 199efc1e00..940249a5e5 100644
>>>>>> --- a/qapi/block-core.json
>>>>>> +++ b/qapi/block-core.json
>>>>>> @@ -1852,6 +1852,9 @@
>>>>>   ##
>>>>>   # @change-backing-file:
>>>>>   #
>>>>>   # Change the backing file in the image file metadata.  This does not
>>>>>   # cause QEMU to reopen the image file to reparse the backing filename
>>>>>   # (it may, however, perform a reopen to change permissions from r/o ->
>>>>>>  # r/w -> r/o, if needed).  The new backing file string is written into
>>>>>>  # the image file metadata, and the QEMU internal strings are updated.
>>>>>>  #
>>>>>> +# A dirty qcow2 image is repaired during that reopen, which blocks
>>>>>> +# other requests and can fail the command.
>>>>> Pardon my ignorance: what makes a qcow2 image dirty?
>>>> usual obvious reasons are SIGKILL to qemu process (f.e. from OOM)
>>>> or node crash.
>>> So, you have to do some cleaning work before you can use it again, just
>>> like a dirty filesystem.  Correct?
>> Correct. QEMU allows right now to open dirty images in read-only
>> mode and it is OK to be used until we switch to RW. In this
>> case real write to metadata corrupts image.
> Feels... adventurous?
>
>>> Back to change-backing-file.  It operates on an open image.  Cleaning
>>> happens when that image is read-only and dirty.  Possible because you
>>> can open dirty images read-only, and that doesn't clean them.  Correct?
>> Correct.
>>
>>>>> Can you give me an idea of what other requests could be blocked?
>>>> Before the patch reopen was smooth - we have just opened the
>>>> file again. After this patch in a very unlikely corner case
>>>> potentially lengthy procedure has been added - full image
>>>> consistency check. Guest IO is stuck until the check will be
>>>> completed.
>>>>
>>>> The case is unfortunately real for production.
>>>>
>>>>> Double-checking: "that reopen" is the one to change permissions,
>>>>> i.e. the parenthesis above.  Correct?
>>>> yes
>>>>
>>>>>> +#
>>>>>>  # @image-node-name: The name of the block driver state node of the
>>>>>>  #     image to modify.  The "device" argument is used to verify
>>>>>>  #     "image-node-name" is in the chain described by "device".
>>>>>> @@ -1891,6 +1894,9 @@
>>>>>   ##
>>>>>   # @block-commit:
>>>>>   #
>>>>>   # Live commit of data from overlay image nodes into backing nodes -
>>>>>   # i.e., writes data between 'top' and 'base' into 'base'.
>>>>>   #
>>>>>   # If top == base, that is an error.  If top has no overlays on top of
>>>>>   # it, or if it is in use by a writer, the job will not be completed by
>>>>>   # itself.  The user needs to complete the job with the `job-complete`
>>>>>   # command after getting the ready event.  (Since 2.0)
>>>>>   #
>>>>>   # If the base image is smaller than top, then the base image will be
>>>>>   # resized to be the same size as top.  If top is smaller than the base
>>>>>   # image, the base will not be truncated.  If you want the base image
>>>>>>  # size to match the size of the smaller top, you can safely truncate
>>>>>>  # it yourself once the commit operation successfully completes.
>>>>>>  #
>>>>>> +# The base is opened read-write.  A dirty qcow2 base is repaired
>>> Reopend, I presume?
>> The meaning here is repaired. The meaning here is the following:
>> "The base is reopened read-write and if it is dirty it should be
>> repaired before any single write is made. Guest stalls until
>> repair is complete."
> If it is dirty, it *will* (not should) be repaired before commit can
> start to write.  Correct?

Absolutely.

> Is the base reopened read-only after the commit completed?
Not mandatory. For pivot cases we are committing top to
base and through out top. Base stays RW.


>>>>>> +# first, which blocks other requests and can fail the command.
>>>>>> +#
>>>>>>  # @job-id: identifier for the newly-created block job.  If omitted,
>>>>>>  #     the device name will be used.  (Since 2.7)
>>>>>>  #
>>> Like change-backing-file, block-commit operates on open images.  It
>>> copies down into a base image.  If the base image is read-only, it is
>>> reopened, and cleaning happens when it's dirty.  Correct?
>> Correct.
>>
>>> Can it happen in any other way?
>> No at the best knowledge from me and Andrey.
> Got it.
>
>>>>>> @@ -2902,6 +2908,9 @@
>>>>>   ##
>>>>>   # @block-stream:
>>>>>   #
>>>>>   # Copy data from a backing file into a block device.
>>>>>
>>>>> [...]
>>> Whereas block-commit copies down into a base image, block-stream copies
>>> up from a base image.  If the image copied to is read-only, it is
>>> reopened, and cleaning happens when it's dirty.  Correct?
>> Correct.
> Is the reopened back to read-only afterwards?

That is I was not tracked, but for commit image could stay RW
after op and from design point of view I believe that answer
is enough.

>>> Can it happen in any other way?
>> No at the best knowledge from me and Andrey.
> Got it.
>
>>>>>>  # On successful completion the image file is updated to drop the
>>>>>>  # backing file and the `BLOCK_JOB_COMPLETED` event is emitted.
>>>>>>  #
>>>>>> +# The top image is opened read-write.  A dirty qcow2 image is repaired
>>>>>> +# first, which blocks other requests and can fail the command.
>>>>>> +#
>>>>>>  # In case @device is a filter node, `block-stream` modifies the first
>>>>>>  # non-filter overlay node below it to point to the new backing node
>>>>>>  # instead of modifying @device itself.
>>>>>> @@ -4989,6 +4998,16 @@
>>>>>   ##
>>>>>   # @blockdev-reopen:
>>>>>   #
>>>>>   # Reopens one or more block devices using the given set of options.
>>>>>   # Any option not specified will be reset to its default value
>>>>>   # regardless of its previous status.  If an option cannot be changed
>>>>>   # or a particular driver does not support reopening then the command
>>>>>   # will return an error.  All devices in the list are reopened in one
>>>>>>  # transaction, so if one of them fails then the whole transaction is
>>>>>>  # cancelled.
>>> blockdev-reopen also operates on open images.  Cleaning happens when
>>> reopening a dirty read-only image read/write.  Correct?
>> Correct.
>>
>>> Can it happen in any other way?
>> No.
> Got it.
>
>>>>>>  #
>>>>>> +# An error is also returned when a device cannot be used once it has
>>>>>> +# been reopened.  Such a reopen is not undone, so an error does not
>>>>>> +# always mean that nothing has changed.
>>>>> Could that be a problem?
>>>> Error reply as itself is not a problem. The situation as a whole
>>>> is a real pain in the ass.
> Ideally, a command does not change user-visible state when it fails.
>
> blockdev-reopen is designed to be a single transaction: success means
> all the images were reopened as directed, failure means none of the
> images were reopened.  "So an error does not always mean that nothing
> has changed" indicates we're not actually implementing this design.
> Could that be a problem?
This is real pain and this could be a problem for me.
As fair as can be. I thought about other option - return
success from the reopen itself - we are succeeded on
switch and rely to signal corruption workflow, which
sends out of stream QAPI event when this condition is
detected.

This could be an option and may be I am over-designing
with this QAPI change. Anyway, this is the place than
other different thinking person is very welcome.

>>>> The problem is that such images exists in production and there
>>>> is not way to handle this without downtime.
> Yes.
>
>>>> Under this patch we are trying to fix things hard and this is
>>>> correct thing to do - on RW image we are doing exactly the
>>>> same thing. If automation is unable to fix - the guest denies
>>>> starting.
> We must not (re)open a dirty image read/write without cleaning it,
> because writing to risks corruption, i.e. data loss.
>
> When we open a dirty image read/write, we can clean it without
> inconveniencing the guest, because the guest cannot access it until
> after open completes and we connect the newly open image.  Correct?
correct.

> When we reopen a read/only dirty image read/write, cleaning it *can*
> affect the guest, as discussed above.
>
> As far as I can tell, all the trouble discussed above ultimately comes
> from letting the guest work with read-only dirty images.  Why is that
> useful?
>
> What are the use cases for opening dirty images read-only?
Read only images usually comes in image chains (snapshots, backing
stores). How RO image becomes dirty is very good question. May
be this was due to QEMU stop/node crash during running commit.

Why this is needed? VM should continue to start with dirty
RO image. Doing maintenance at start? That is also problematic.
At this moment we can face shared lock on base image (so called
golden image scenario).


>>>> Here we report an error and render guest as unusable. This
>>>> case is expected to be extremely rare but technically possible.
>>>>
>>>> This is a problem.
>>> I'll come back to this as soon as I understand when exactly cleaning may
>>> happen.
>> Right. Thanks.
>>
>> You are asking very good questions which are quite important
>> and interesting :-) Simple "deny" policy is very bad from
>> operations point of view.
> I try!
>
> [...]
>


