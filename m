Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237D0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 23:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPqL6-0000v5-P1; Wed, 20 May 2026 19:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wPqL3-0000uO-En; Wed, 20 May 2026 19:28:33 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wPqL1-0006E5-1p; Wed, 20 May 2026 19:28:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwIm8UdriHuGObik/GZhjCltqNyOVoLsAb7Lg2FxFQusKAWF7cobngJJ6N9DNIDFde3qiUzOHHLlhEbwZ54yBSJorYfwZUiNHpv4Dz6KBG/kEi6z5NeeA75X85IUbFKBa2KHBq06+aoaJMoV0DOkMYr7q9G35fUFnD7EIem2DM+Jq8O2feQclktcA+ns8Vl5FDLZOXo7tlSLJWxPtzjRvqsila11iByrgtO5IWCc/ZXehgkYFDbCXR0A8eNq8uLbvCWHysR11t1bGXe36D85j691q12Kl8OdXtAEB21g0xc+Az3hXrFuC04tFI6bFTgc0LRKJHA7ZRrwNp0WotG5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7biTsxN3FlR0hDmU24sWChDAJFfdNeyqsj11dbCkwE=;
 b=krJ/JfJG6BGKPp8d1/GXEDRqzCosS7DV9FQqOzInhMCEyRqmyNbW6bhwwzQlglPvRwITaChvPvdOG3I9fTUc5D8qNLMDueWaAqS+aQO0YUjrdr7YO3/MbxwNbJMPtr/8xXxGYenqFVvBbtUMP4ZaYYvIDB6OS54+Z98cAFKFb+CKjYb6TZZa/gVi7pmSCckrI8EBdcoT9IJ5zFhdcc6PaDZpQTvMQGXW8A7vGWqvExmiMGwW38b7BKG/96q2mC0UAsZ45oXvLXsKvK+R7E7/2VpfBYOZUnylkc2UCsSMuLn4eqB+Zt6mksrOIpQVnjqg8iYMF3p6WLdPFtt0WMuN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7biTsxN3FlR0hDmU24sWChDAJFfdNeyqsj11dbCkwE=;
 b=aA7vmMXJTqsCqxNzzqLI9nJz27AE/cdQo9wVgOQn0MsY9DfRqATCrw0ha2ahyplmf75Iq4R3oIMqOXfdT6kK1yhQaUn375+V/l4EC+pCqCViTUG3LGnXsvp4FfRvUEdqKcNmAdNc1IofWnox2f+QGOaNKEF07JbbG97Hjy/cAJwKyo5RvHOlP467ywbsqxF7oKWb1N5kMZ/bw4Agkwu7j8soZ7fIhAdE46Ft+kiYNQA1TqOrE4B+thRMpxvpTx9RkIno8nlN7Yrhv9Qsnq1rKWhm4P9B6CXFTzeoPiYuHqHKJXURCaVeiYRDP3HFkFSOgc9rhbuEt3ZOP9HrNV9qhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB7838.eurprd08.prod.outlook.com (2603:10a6:20b:529::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 23:28:24 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 23:28:24 +0000
Message-ID: <1e8a61d3-38dd-45f4-9e36-3b7cb0e1b5b5@virtuozzo.com>
Date: Thu, 21 May 2026 01:28:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] qemu-img: add sub-command --remove-all to
 'qemu-img bitmap'
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
References: <20260424105949.254757-1-den@openvz.org>
 <agcl4DjbG7t17LqR@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <agcl4DjbG7t17LqR@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF000001FA.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::908) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae366f3-9d82-42c8-2f68-08deb6c77be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|6133799003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: 8Tm90u5TpSR8ZSZ+KNSQdckJEnd/+c81A26A47JS4x0j/FvOGfvkqm1tNADEpinvU3WAdRiYlmIXiJDCLMRdf3C/+DOrgXpibC/pjyEUs3cy3uEE9T3R8VaqkDI2CAndB0KD5JaII3YGiAvrr1eeVw4b+BzmLn68XT6gDar0yBSOaHAWvorvQGsLQAITyt6BH/JKfMpQbaqJTbL2OnrPLsfDXZnk+j4sjZkBmCrwtlROt+hDxNCRu4bDeErJv+pzKAbucXKkLDbmJX5fgomwuvn6YrIepkTLC44vJX2Rh9EwNNrRAZ12VBaDy07nxJrZMJZw2WZp4wcbZKs5stB1Nj74ANV1P8sYixWA+cGLWEG0CM4CIqB7eDikSWx2sfZu5uKLHjl/CNO4YRy8tXwA4QrkdV3T1UrAaD4lkOV0Rw/3Vb5nD4kR8YohQoZreoFFb2tLWbT1RwZCEHEK5yttSTmc4lTO67GYNhFDEmveMddxLRAV/3C+VWMilLWEVQfT/dzTL4jfDR7ogYQNenvASA5VO/m/5ppzRSmvvQLSA2M+f7X9UJO4sopUCA4ifjjG4p2AAwqrf/Wqg/TDoVgmB61apyWHfUP/YY/7fhMYYRSqelNHbiD0ElCs6AbbRzyGJ3yjIC+K51QSAwXuBrcu8GOiKnFg1IJJ7CDEclIcrPqQYt3ptldAQVyfakhbCg4k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(6133799003)(4143699003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUtXTnYybWF0eU5nNXRQbFM2eHFRTVV2RFFHMFh0Qkpsa1U2bzZ6NHZDcjd0?=
 =?utf-8?B?N0dEdHlzU3Y4VSs0OFpob0RIVmVoNFJBb1BHRUowRUVTVTdIMW5rRWVEdnNu?=
 =?utf-8?B?Yk5xZFRTMFdZMStYeHJ4MG9iY3ZQMjlpRnlhS016cGdtQUVoWklEOUxQY3VM?=
 =?utf-8?B?N2tiSnlsNHV5WklKamJvdGNUYXVlK2FtUC9KZkNxYktDbmZuV3ZYaWpuZ3V6?=
 =?utf-8?B?OXFzcFRVQXBLNE53NXZrL3RkWTkzaktMb0x3bW02Y1JhdVEvUXJjQzNEeXhw?=
 =?utf-8?B?MmlKb21wcXNoUFFVQlNnaFd1NS9iaTMzUkVLcit4bUtlUzBHV1R4V0dVVVUy?=
 =?utf-8?B?NTlzVVIzZXpvbTYyMkZHWXZ0SEh2S0dxTjZVaDVXbkFnT2M5ZFZOcVRWaEpB?=
 =?utf-8?B?cGw4R0hqZFBwL0t4ZWVodmxCVHA4QmdSZEVXaHNQY20xYkUvRHI5UkFPQ1lO?=
 =?utf-8?B?c1VoQXFESy9ORHdXeVNHK0dLZDZVeGVzL0JuZmFCV3NnUGFiYWtORUVFeVRB?=
 =?utf-8?B?aHJucDlMbXFPWWRUcE8rdGFURE41ZEJZNnFOQkFNNDNFcWhqN2pkUWpXcGY0?=
 =?utf-8?B?N3hUNmhMQ04yc1F6Zy9EMURYdTRVallKZm5nbEdxb1F3QXN5eGdQWTR4QzBv?=
 =?utf-8?B?QzdkM1NnVnpvS3IzbU5PdytsRlBJQk5ObFE1bWc3Y2ZpQnV2TDdEN2JzVUxs?=
 =?utf-8?B?MllIczZMQXFhRWZueWpPK0RSVkJtaktjbmdGS01kWUVySDF4U25ydXlNdC81?=
 =?utf-8?B?bFY0bDQzd2ZhTUN5QTc3cWJIbnZOOUM2VGcrWkkyMWp4Zm5UNkFPaU9UNi92?=
 =?utf-8?B?cWFCRVpxSUJCMlZsYUZzSzJUbXMyb3dEQk9nak4yME1UQVRyaVhlREYzVEE3?=
 =?utf-8?B?UWx2Ky92WFU5dUtkNWFlNnRGKzVoQ09qR3hOOXNkOHpLYzhDZzdoN3k0T3l2?=
 =?utf-8?B?U3VndmNZZVAxUnhNbkxRc1l5enNCWGRLSVZQRitWb3NkckZ6QW0yN0hDdWdI?=
 =?utf-8?B?eEFwTXNBZUs5SXRNWDFxaGkvRERJU1NyTGRmWjcwaDF5UGNPT1crbmJxYjUv?=
 =?utf-8?B?V09CNHhnN2krNzBzdVNHOUxzbVdZQkd0WEc3OUtUTWszK2ZFMkZnWVRwQ0tl?=
 =?utf-8?B?UnZvamNKZ3dqcG5vazRtckptVUJzN0JjcE9UR1RNZGxHUjdkbkIzOUtVa3NS?=
 =?utf-8?B?QmJBQWpNY2xMRnVzZHJLK1V0bk5zWUwxSlNCZ0N4cjJEdUlpUG95NEFnLzZS?=
 =?utf-8?B?SWcwSzJTVC8xcExiUUgyN0dLaVIzVXQ5TEZBQmFEU0M3VUdmOFU2Vlk3YXNi?=
 =?utf-8?B?VlR0VzBKbjBxa2Y0anIraWU2Nit3MlVkb1ByckFpTllsOEs3UkZFTlAzVXFl?=
 =?utf-8?B?WEVGYmtkbzQ4SHBjVWNFcTl3bGJqYW1Td2xTQXBTaVFLRXZCQ01jOHVqdUtV?=
 =?utf-8?B?dGdGampWMEI2THVmU0JaVGxSU0dLV21VeDh6VnRBeVFRYXgvWEtPRklkRUVN?=
 =?utf-8?B?S2I4STU5MzhuVGtGWHB0OGRhSmJDSHgxN1NxY1VKNjdEK2cvRXBnZ2JWWDk3?=
 =?utf-8?B?RW05SWpoN2ZSeENxTHFlaHZMaHpSSHRpdUFhQTQ3eUhvWG5EaTdhL3crdmNG?=
 =?utf-8?B?Q0N0NERXMnBGcnlHMGEvWm1qeldKaCsyTE5CTVYvbFZxNDNpbXZsVktXM1dR?=
 =?utf-8?B?ZHYzR1E2UFo0b25TNEN0NnlnVnVEL3F3Tkx6Z2h3VGpxK2NDOGJKejRCVzcw?=
 =?utf-8?B?ODdYZ3VrZ3VmcWxDdXBESlZES1R2TlAwVERPYU1HeHExMVlpNmJVNlQ3RGVl?=
 =?utf-8?B?TUdWQVduUlVqb3o5QmVxZzZLeC9FWmtndGJZa1hYSmdSVzRlM0V0YlVrV09q?=
 =?utf-8?B?eGZRNVlKK3A5SG1LWFo1Zis4Wjl1REMzQktTc3NpcjlBSGVoODBzY0I0Vnpi?=
 =?utf-8?B?eVA2b2dBQ0xVd3o4NUFLR3JBL0dxNXJoWml4bllhTUV2R0haeFJ2Tlg0Z0lh?=
 =?utf-8?B?UGhCVmtRTVFxTnNFVDlJeE8ybFN3NGg1bFJRK09kelZIcVpNSkNyd3FIUGlj?=
 =?utf-8?B?VllXcHVtSFZRMXBiaGViYU15L1lIc2FTMEorcGRCOHg4ak1yVDlUU2FXdXc3?=
 =?utf-8?B?N0gvSkkrNDBpeVFiRVZ1emhoVExyWGo2SkxKZ3BxU1ZpY25uVnFKZ1hIaWV2?=
 =?utf-8?B?WEJRTTVCeEtzTG9pV25ETFBOTU5PTWFVbEFieEJYdCt6RWREMmlTQmRRcnpE?=
 =?utf-8?B?c09ySlR2c1ZUbkdwYy9jT0JTT2ljNms3eGlkbVRHejk5TXpIQWl6eXBRT2Rl?=
 =?utf-8?B?di8vTTBaTXFzVDBhcVhkRmVPZ2xIMzN1Q0plM08yZnUySGt4OHFSbmcyek9l?=
 =?utf-8?Q?BnnOMTfXU9EGuxn+1Or/AfqLDc98xpgTUiLaUYBvrVNn1?=
X-MS-Exchange-AntiSpam-MessageData-1: hJfvofVD6Fxbhg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae366f3-9d82-42c8-2f68-08deb6c77be1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 23:28:24.3686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uyxt4T10z1faoxlDISMPBeK0iC7EOqksVWak4loudCCWnsrjsAQVHFYUwjvYMNuT9gYCRcDF0KOkY5pS3rNwJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7838
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

On 5/15/26 15:55, Kevin Wolf wrote:
> Am 24.04.2026 um 12:59 hat Denis V. Lunev geschrieben:
>> From time to time it is needed to remove all bitmaps from the image.
>> Before this patch the process is not very convenient. One should
>> perform
>>     qemu-img info
>> and parse the output to obtain all names. After that one should
>> sequentially call
>>     qemu-img bitmap --remove
>> for each present bitmap.
>>
>> The patch adds --remove-all sub-command to 'qemu-img bitmap'.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Hanna Reitz <hreitz@redhat.com>
>> ---
>> Changes from v2:
>> * rebased to the lastest head
>>
>> Changes from v1:
>> * rebased to latest head
>> * adopted bitmap help to the new layout
>>
>>  docs/tools/qemu-img.rst | 10 +++++---
>>  qemu-img.c              | 53 ++++++++++++++++++++++++++++++++++-------
>>  2 files changed, 52 insertions(+), 11 deletions(-)
>>
>> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
>> index 558b0eb84d..b0c798b77a 100644
>> --- a/docs/tools/qemu-img.rst
>> +++ b/docs/tools/qemu-img.rst
>> @@ -301,15 +301,19 @@ Command description:
>>    For write tests, by default a buffer filled with zeros is written. This can be
>>    overridden with a pattern byte specified by *PATTERN*.
>>  
>> -.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
>> +.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME [BITMAP]
>>  
>> -  Perform one or more modifications of the persistent bitmap *BITMAP*
>> -  in the disk image *FILENAME*.  The various modifications are:
>> +  Perform one or more modifications of persistent bitmaps in the disk
>> +  image *FILENAME*.  Most operations require *BITMAP* to be specified;
>> +  ``--remove-all`` operates on all bitmaps and does not take *BITMAP*.
>> +  The various modifications are:
>>  
>>    ``--add`` to create *BITMAP*, enabled to record future edits.
>>  
>>    ``--remove`` to remove *BITMAP*.
>>  
>> +  ``--remove-all`` to remove all bitmaps.
>> +
>>    ``--clear`` to clear *BITMAP*.
>>  
>>    ``--enable`` to change *BITMAP* to start recording future edits.
>> diff --git a/qemu-img.c b/qemu-img.c
>> index c42dd4e995..22ddc7a627 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -87,6 +87,7 @@ enum {
>>      OPTION_FORCE = 276,
>>      OPTION_SKIP_BROKEN = 277,
>>      OPTION_LIMITS = 278,
>> +    OPTION_REMOVE_ALL = 279,
>>  };
>>  
>>  typedef enum OutputFormat {
>> @@ -5018,6 +5019,7 @@ enum ImgBitmapAct {
>>      BITMAP_ENABLE,
>>      BITMAP_DISABLE,
>>      BITMAP_MERGE,
>> +    BITMAP_REMOVE_ALL,
>>  };
>>  typedef struct ImgBitmapAction {
>>      enum ImgBitmapAct act;
>> @@ -5036,7 +5038,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>      BlockDriverState *bs = NULL, *src_bs = NULL;
>>      bool image_opts = false;
>>      int64_t granularity = 0;
>> -    bool add = false, merge = false;
>> +    bool add = false, merge = false, remove_all = false, any = false;
> It's quite unclear what "any" is supposed to mean. From the code it
> looks like it's set when a bitmap name must be specified (which is the
> opposite of what I'd think of with "any").
>
> Can we use something more descriptive like need_bitmap_name?
correct. I have spent at least 5 minutes trying to guess
what I mean under this name. Meaning was "any single bitmap
operation has been added to the list".

Actually non-obvious naming long term. This is good catch.

need_bitmap_name is nice.


>>      QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
>>      ImgBitmapAction *act, *act_next;
>>      const char *op;
>> @@ -5052,6 +5054,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>              {"add", no_argument, 0, OPTION_ADD},
>>              {"granularity", required_argument, 0, 'g'},
>>              {"remove", no_argument, 0, OPTION_REMOVE},
>> +            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
>>              {"clear", no_argument, 0, OPTION_CLEAR},
>>              {"enable", no_argument, 0, OPTION_ENABLE},
>>              {"disable", no_argument, 0, OPTION_DISABLE},
>> @@ -5070,8 +5073,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>          switch (c) {
>>          case 'h':
>>              cmd_help(ccmd, "[-f FMT | --image-opts]\n"
>> -"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
>> -"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
>> +"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
>> +"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
>>  "        [--object OBJDEF] FILE BITMAP\n"
>>  ,
>>  "  -f, --format FMT\n"
>> @@ -5086,6 +5089,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>  "     with optional multiplier suffix (in powers of 1024)\n"
>>  "  --remove\n"
>>  "     removes BITMAP from FILE\n"
>> +"  --remove-all\n"
>> +"     removes all bitmaps from FILE\n"
>>  "  --clear\n"
>>  "     clears BITMAP in FILE\n"
>>  "  --enable, --disable\n"
>> @@ -5115,7 +5120,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>              act = g_new0(ImgBitmapAction, 1);
>>              act->act = BITMAP_ADD;
>>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>> -            add = true;
>> +            add = any = true;
> One assignment per line, please.
>
>>              break;
>>          case 'g':
>>              granularity = cvtnum("granularity", optarg, true);
>> @@ -5127,28 +5132,38 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>              act = g_new0(ImgBitmapAction, 1);
>>              act->act = BITMAP_REMOVE;
>>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>> +            any = true;
>> +            break;
>> +        case OPTION_REMOVE_ALL:
>> +            act = g_new0(ImgBitmapAction, 1);
>> +            act->act = BITMAP_REMOVE_ALL;
>> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>> +            remove_all = true;
>>              break;
>>          case OPTION_CLEAR:
>>              act = g_new0(ImgBitmapAction, 1);
>>              act->act = BITMAP_CLEAR;
>>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>> +            any = true;
>>              break;
>>          case OPTION_ENABLE:
>>              act = g_new0(ImgBitmapAction, 1);
>>              act->act = BITMAP_ENABLE;
>>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>> +            any = true;
>>              break;
>>          case OPTION_DISABLE:
>>              act = g_new0(ImgBitmapAction, 1);
>>              act->act = BITMAP_DISABLE;
>>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>> +            any = true;
>>              break;
>>          case OPTION_MERGE:
>>              act = g_new0(ImgBitmapAction, 1);
>>              act->act = BITMAP_MERGE;
>>              act->src = optarg;
>>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>> -            merge = true;
>> +            any = merge = true;
> Same here.
>
>>              break;
>>          case 'b':
>>              src_filename = optarg;
>> @@ -5165,8 +5180,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>      }
>>  
>>      if (QSIMPLEQ_EMPTY(&actions)) {
>> -        error_report("Need at least one of --add, --remove, --clear, "
>> -                     "--enable, --disable, or --merge");
>> +        error_report("Need at least one of --add, --remove, --remove-all, "
>> +                     "--clear, --enable, --disable, or --merge");
>>          goto out;
>>      }
>>  
>> @@ -5184,10 +5199,14 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>          goto out;
>>      }
>>  
>> -    if (optind != argc - 2) {
>> +    if (any && optind != argc - 2) {
>>          error_report("Expecting filename and bitmap name");
>>          goto out;
>>      }
>> +    if (!any && remove_all && optind != argc - 1) {
> Doesn't !any already imply remove_all? If both weren't set, actions
> would be empty and we'd already have errored out above.
>
> This probably means that remove_all can go away entirely because it's
> only read in this condition.
Correct. We have had a check that at least one action is specified
    if (QSIMPLEQ_EMPTY(&actions)) {
        error_report("Need at least one of --add, --remove, --remove-all, "
                     "--clear, --enable, --disable, or --merge");
        goto out;
    }
and thus !any de-facto means that --remove-all is set and there
are no other actions added.


>> +        error_report("Expecting filename");
>> +        goto out;
>> +    }
>>  
>>      filename = argv[optind];
>>      bitmap = argv[optind + 1];
>> @@ -5225,6 +5244,24 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>>              qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
>>              op = "remove";
>>              break;
>> +        case BITMAP_REMOVE_ALL: {
>> +            while (1) {
>> +                const char *name;
>> +                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
>> +                if (bm == NULL) {
>> +                    break;
>> +                }
> while ((bm = bdrv_dirty_bitmap_first(bs)))?
>
>> +                name = bdrv_dirty_bitmap_name(bm);
>> +                qmp_block_dirty_bitmap_remove(bs->node_name, name, &err);
>> +                if (err) {
>> +                    /* Save name for proper error reporting */
>> +                    bitmap = name;
>> +                    break;
>> +                }
>> +            }
>> +            op = "remove-all";
>> +            break;
>> +        }
>>          case BITMAP_CLEAR:
>>              qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
>>              op = "clear";
> Kevin

The rest is clear.

Thank you for the review,
    Den

