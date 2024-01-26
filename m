Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE41C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 11:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTK0A-0008Ou-8a; Fri, 26 Jan 2024 06:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rTK07-0008OE-No; Fri, 26 Jan 2024 06:03:59 -0500
Received: from mail-he1eur04on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260f::701]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rTK05-00016C-Og; Fri, 26 Jan 2024 06:03:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azf0UuVzeHGJhz6xfJ5icnJ/8hUqcKzxy4YzNQplq6N2Ju6KD9YSwwghTZmbM7+8dvj7CtkaoKN/baFyurcod6vY1nUXKEz+lmTxNbt87y+wOfIV2PG5dF78ahidJpQIALeuAjI1MvYarnXGUW2xHl6zZlpL3GR5/rxKOmVRchAs40TgCLFC682oUPzScXzrvDcQ6gJZFgQ/Toucoc/ZgVmFBElg87YvPwHQBIwR0nV25RsqdqJF6dwygH3JLLS9b+7P2uN0T0rIVex3BuG4NFljFQYGCZtBkc718D6b8t8znTpymStXN/lQg3E5GbyFMtDIKCCxfioddBxhFZixrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRuNGKIcmeUQtNDXy39vdBBMFJB0VOxNLBMiiWe5o0g=;
 b=iUgF/WaexTnv4dsFyT65srocpTey32PMweZkAVYMFVwfq2sFdV2eYkxYwH38QeRB5YssX5alDdfreoNof3NixtdfHKwbTqFbQd8A9TqbidvpD4dD0p7n11gdCzbcvJFrnvxtl+47yslCc4R2sQFxWv/jKkr30XS+sZRTlstyU5AOlpWdAAPRyLSt7rT0QeAlszcJk1YLxMTRRJ6EYyLqFICMWHbzYZdyCz9djw9URlcu+QNzKUDzE9NTjPTmLeEkugk4b49HxNfl1xArC9ilvDKKjPvMSes+bgYr4vFL4il0uOO+T4/ix+SnbLrNvz1UWhRspVnfWdKabKyDfh0iaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRuNGKIcmeUQtNDXy39vdBBMFJB0VOxNLBMiiWe5o0g=;
 b=TSr/JIIqywWIB4pNdwPsu86Np8CA8qeR16igMQ9SAAsD6Yy+Bpm6MApKOkgzsu30DM951I0kid7jYoQWYwA4Zi6LSMtETWh+0rAKX3BfjL3f3N83F2AuRnjpDEHspQycttzXS8G1+vJibq2+RWoC5EibojfZ6bk5wWN2g2MXQSgf4yg3xBbkM0cUNRnwuv+DO/O/Xhr+9k3Z/tybuqcJ7FVVndNWREvnGPnDWb/vEYqng7PTql66FhkM6tOEqXbMqG3AgdGtHknrzWKRQTlh4O23NTfyHBnSjUnMsYQqU4+e/54RkddtRbqZBj7936DyvBlWEWz8zrYZfHL7GxAyIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB10055.eurprd08.prod.outlook.com
 (2603:10a6:20b:645::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 11:03:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 11:03:51 +0000
Message-ID: <71305cf0-31e8-4d5e-beab-8854a0d1386a@virtuozzo.com>
Date: Fri, 26 Jan 2024 13:04:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: don't run tests requiring cached writes in
 '-nocache' mode
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 den@virtuozzo.com, eblake@redhat.com
References: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
 <ZbOIaoaOI1vc_-3F@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ZbOIaoaOI1vc_-3F@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fbd3e4-beda-426a-fe8a-08dc1e5e7ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTMi9qfdT57HkHHYk+wPCTnSSiLZF9A9+tpEVzPhALc/AyaSZ62+0nTRY0lg5PdFD6lYQ++5GwMq28xzg/Ump9kwA0hzZoNikNNU9nxkbcd50RP18lYhxJu9i6/gyIRXUiOUsGFEO93QGEBOQjKOLoGNPtN3nXQ0/Ntfk/bcAxfSFAMOCRPys7RZkWZVLQkIc8vVUdQFJ+euwMKRApoB0J0xQokRxf6m+XESCBQBtOoOpqpMMSDBmXKkbYJo2K4zG0V/+OI8xtoUsRWs4UCh2xKwiwhA0T2FiCuLH1BgTI//iy13sBIo6wR+A0gSuH5wxB16EzzTx9ag7JCrI5y0fF3GkID/1bEUlsF+hJU1ESzksbbXkHNDeVEqTlYvu1NBDlRTFCNJ9h9otmpmUMHkdAeVSjAYVGHuPeEtnN3loPmdKvo6JVo+OS2wBdhR9FcIutAGM4WVFrQvCrbZ4NtJ2TuBCk6KeQgI3FHr009O3NGLMZCUVpzQbCpgtAnMPIpaCq1kNbUpEEBts7OZFJYdT6Q1MrHGWFTQOAWy/4GVJgB1hVoVPBNreH6DoIh/4qGVCjsTIQtm/G8t8uWeqQRkkXqK3VHp+eCGybxBVPyUfrFAhIcWPua7CKLiygIT9Sk6vmJp4DdOmCrun4GJ3l9KAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(83380400001)(6486002)(2616005)(6512007)(26005)(38100700002)(5660300002)(8936002)(4326008)(44832011)(8676002)(478600001)(2906002)(966005)(53546011)(6506007)(66476007)(66556008)(66946007)(55236004)(6916009)(6666004)(316002)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFKQVZka3dCQzZ6a00wRDhGdHF0RHI1TmhSaGtKbWdOcGFnTk1QS2FEamxk?=
 =?utf-8?B?Y1NtUHNnSGVBblNyNy90aVJzc1JYd0prU1ZjMllCVkpQMzlSSVB0NGZQNW50?=
 =?utf-8?B?OXZZYWEvMkg1YVNYZ1E0Ulc3aEhyVGZhbVZvNThKYVo2dHI4MDM4MGdQNDFL?=
 =?utf-8?B?NlE5SG1hZkZYTzNpR1FKaVMzQTJjSmdheHd5OHNic05ibnEyNGZnTDhaSlJS?=
 =?utf-8?B?MHVRMktkOFMrV0dtSjQvQkkyUjBBQ3RWN1NIajNiT3cwcS9lWSs1MmNQdk1F?=
 =?utf-8?B?ekxlTkNuS1oxcDlpWXNGTWdiSkRLSkJ6SjlLTEhPTmNsbG5ORWFNSjNHcFlH?=
 =?utf-8?B?eXdZSFNVbVprSXBpK3NKU1I1Q0JVZHlSeHJCZ1ZuRk12ZnFvcEc3NUNQQnFU?=
 =?utf-8?B?azhUcy9odUFKVWlZck1XVC8yMGFEdFE5U3NEbXZ2d1Vic1pDUWEzQ1pmVmx0?=
 =?utf-8?B?L2hyNE82Uk1iVVgvVFpoUE9IQjljakFaZGZkQXZYRmRxMmkrYzlpYStzTmlY?=
 =?utf-8?B?ckhKS05JQllSZDBlay8zdUFwMjhteFlXVkt3QVJCR3pON01lQ1dDZnN1YnlB?=
 =?utf-8?B?cVM5N1gzZ2VoYVFNa2Y3UlFQNG1lU0d0bEJ2WVpRbmxvSDAveGh6YUQ4YkVl?=
 =?utf-8?B?SktFMXUvY3NYT0g5UEM2MUNOL2tQcGszc2huZm1jeHoreGpWVlZCWXNSQVRJ?=
 =?utf-8?B?cndKV2QwcG5mYXF6cVV1cjRoZzJKdUJFZkR2dHJXUnBhUFp3LzJVVGdYMDVq?=
 =?utf-8?B?Y0s0dUQ5b2ZFYTBDc2tiZ3U5Uk84VWt6SzQzZEVSTTlrZXBFMUw2aHlwOHdx?=
 =?utf-8?B?VG9ZT3V4dHVEZGpSaVFJbkhFdG8zbXhaTXRGdVVVZVFNMUpyL0RCamhZSGk5?=
 =?utf-8?B?cDRGdjBSZURXNXFTY1duaDFiR1pPcTFRSVRDUld3OFAvOHFXemVzQ05hRE5r?=
 =?utf-8?B?MFNRZE5DYktpckRNcmNBZlpaRDBJY0VGaExyTWwwN3ozZ3pHcm9KM3N6RklK?=
 =?utf-8?B?dXczSGZxQ0NqZTVQakhTZ3d3TVJGbHprcGs5bE9oY1IrUVFQOWJMV3ZtQUR2?=
 =?utf-8?B?ZkRwRFQzZFIwU3hSUTRJYVBUaU5iZDJPOFYwVjdOVlRZYlI1Z0JsblkveVdQ?=
 =?utf-8?B?TmFZOFJzSWlhV0o0ZkZYUjBrWTBEWFREMTcwVUN4VEoyNG1WZmt3Z05QSjRx?=
 =?utf-8?B?UjVTUUFEQ0FZT1NzUXpza3ovdHNKRkhCVjZkdWZtZTFDMk13YlF4Z29zTmto?=
 =?utf-8?B?VStqMmxNM3p0S1BpSDlEUjh1ZlNrdmJVVDVMTmlNNzgwNkZORXJyWWtsUm0w?=
 =?utf-8?B?ZzBRL2toTVUyUCt1L283dEc2WGtVN2hWdUtsajlmWVhzZTI4aHdVWnZ0Nyti?=
 =?utf-8?B?WmdsNTZHN1dJVzZtUDZHckFFZlNMMFZJWFpZT1ZwVVRSTVppNUQ1NzhZR2dE?=
 =?utf-8?B?WDRiMk1SdEo5d1IrdlkwaElVbk00R2F3ejVubksrbGkza3l2NU5qWU9raUYw?=
 =?utf-8?B?UjFYNzZoMzFTeGwvZjNVRUlmdjRTL05kL2NQTVJ0a29DYkZjbkNRN0M2Z3Rn?=
 =?utf-8?B?TXQyV013aWV5RnFFcGlmSlE5NmhYcmNUQm1oMXpMaE9qUk13eDJlSWpSQXRk?=
 =?utf-8?B?Q2xaK1lwcENjVDdXYVlVaDUwbHBtRTl3T01UTzAyNUphUTVCVHZPcGNOakJi?=
 =?utf-8?B?TmQ1akcyQ2kyYkQrc3YwdXZSY1Y4d1JqeDhzV2JIZWJBUXJ4a3FoZmJnNTBs?=
 =?utf-8?B?bEtFS2g1aGFlRjhOVmZVeGpzR0l3c0htUmMyTUlFZ0gzTlVBdkMrNWpZMFJo?=
 =?utf-8?B?bktCYlhCNFNmUmtrTTVGT3VVTy9ocSs0emdibWFwTDVwajZBb2d3elpNMU9t?=
 =?utf-8?B?Z0FxcktUNTh0Y0h3aDBiemluMDFSOXNPN3RHSGpVRlZsdlV3NXhyZWttTTAy?=
 =?utf-8?B?TjljV2V5ck84bEZaWmQrd2dBYnZkQXlMcldUWVZ2Z2lYVUdtYWp3emlvZ25q?=
 =?utf-8?B?QzZaY3JOeS9KbkJHTXAvQ1BjeUw5VHBBVTJpemIzbThndGpSZkdpU2hVRzAz?=
 =?utf-8?B?em0yYkhiUllHQTJtN285MGphRE1YdjBxcmkxd0djUWhRQ0Myb1lUcnY5MElr?=
 =?utf-8?B?Y0VKZjNXTTRJa3hLeTE1NUhjK3F4azhjVGE5WXRUZGdxZS8xZUdQOVFjVFhD?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fbd3e4-beda-426a-fe8a-08dc1e5e7ad4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:03:51.7601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZluOSDdJQ9dYevtI9+d6risRanOfslLHcVPLuMWf51fgFhixoFgC8SvVA5TH2MDHvM3/7hFvebEMkgwYqnGp8LGkSGt8w9lnnSXogzAI7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10055
Received-SPF: pass client-ip=2a01:111:f403:260f::701;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/26/24 12:24, Kevin Wolf wrote:
> Am 11.12.2023 um 14:32 hat Andrey Drobyshev geschrieben:
>> There're tests whose logic implies running without O_DIRECT set,
>> otherwise they fail when running iotests in '-nocache' mode.  For these
>> tests let's add _require_no_o_direct() helper which can be put in the
>> preabmle and which makes sure '-nocache' isn't set.  Use it to skip
>> running the following tests:
>>
>>   * 271: creates files with unaligned sizes, thus producing multiple
>>     errors like:
>>
>> qemu-io: can't open device /path/to/t.qcow2.raw: Cannot get 'write'
>> permission without 'resize': Image size is not a multiple of request alignment
>>
>>   * 308, file-io-error: use fuse exports.  Though fuse does have
>>     'direct-io' mode (see https://docs.kernel.org/filesystems/fuse-io.html)
>>     we aren't using it yet, thus getting errors like:
>>
>> qemu-io: can't open device /path/to/t.qcow2.fuse: Could not open
>> '/path/to/t.qcow2.fuse': filesystem does not support O_DIRECT
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> How are you running qemu-iotests to make these tests fail? I tried to
> reproduce, but they just pass for me:
> 
> $ tests/qemu-iotests/check -qcow2 -nocache 271 308 file-io-error
> [...]
> 271             pass       [11:20:50] [11:21:11]   21.1s  (last: 20.4s) 
> 308             pass       [11:21:11] [11:21:14]   3.3s   (last: 3.3s)  
> file-io-error   pass       [11:21:14] [11:21:14]   0.3s   (last: 0.3s)  
> Passed all 3 iotests
> 
> $ tests/qemu-iotests/check -raw -nocache 271 308 file-io-error
> 271             not run    [11:21:20] [11:21:21]   ...                  not suitable for this image format: raw
> 308             pass       [11:21:21] [11:21:24]   3.8s   (last: 2.8s)  
> file-io-error   pass       [11:21:24] [11:21:25]   0.3s   (last: 0.3s)  
> Not run: 271
> Passed all 2 iotests
> 
> Kevin
> 

As for the test 271, I imagine this might be caused by different request
alignment.  The failure occurs in block.c, bdrv_node_refresh_perm().  If
I print the alignment out explicitly, I get:

qemu-io: can't open device /path/to/t.qcow2.raw: Cannot get 'write'
permission without 'resize': Image size is not a multiple of request
alignment: 4096

For the record, I'm running tests on ext4.

I'm not sure about the fuse tests though.  Could it also have smth to do
with the underlying fs?

Andrey

