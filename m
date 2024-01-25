Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCB4C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2g1-0006ac-Dj; Thu, 25 Jan 2024 11:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT2fw-0006ZZ-BJ; Thu, 25 Jan 2024 11:34:01 -0500
Received: from mail-he1eur04on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260f::700]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT2fu-000242-GJ; Thu, 25 Jan 2024 11:34:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENDd8jNGnbEkM3FDJMucEOgcgZVbwJ5RQ+t4hNtxod760ifVwa4V6uWGO951Gado7lBjoYbXV4k1x4p2G79Z3tSMRc7b8Oc8mgBKlrnwTqqLXeYbPMlsyWmxMQxnlQyYaAYGWu8IUTWP0QBxBbFTuAwe7C/RPrhIUXexbdteMK+Ey9G77janvkC4PcrF3W1AmnAY2BaZilelelduOOWKQEmIPlhqmwXMFlfbmPXpdVjhnQTcEay+VWzhgFETzTgj32b/YL3XMKuZL3xijiqCD/sNdECkIuDtEgc0kPXb0R77wzifF7uHK9KOrFDEQ/eDE24/eR4g8PtLG0zjA7zMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZrq/yhWTVzUNNQwam9HWvcyAWrHqj0DqdjSQPc7W5Q=;
 b=i4Fqz/oFmJUq17d3TOKuhfV4xRwHr6CTq9cL3MNQtftcrwJIGQ8q9R9EPt9NtVhmILHwi3rG2Rz44xsOG3AMMYRJN8Ont6z9r1iugeP9uQXVSwYJFkJAyBJ56VOGFPG+cQESI1E9PiB2ppI52d7bgEc3mY//hfDWqH9tKhxoDw/jtK/QmEhQkyPljxYmqN7UP/jngGIBqqZkkQoFdxtnhlldA1MKchU5RNIoxB+n9ozA1uFIrCOSZgmlQ3p50PhfxcPQxQv/IoCgp71sDXrM0ZGTVgzqOtFP8yXEA7gBS3bQ5hy1oJBhyhJROEPAuBVoD5ybo/L5jsJaJPh96kcRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZrq/yhWTVzUNNQwam9HWvcyAWrHqj0DqdjSQPc7W5Q=;
 b=Q25K2CcmOPD8nmzYTDJeCMHzf2r4NWKZuX8H1qL8j1Ou4/rjLK5tRgRME57h4tU2SeNtLvXJKXfRtqoh1KuA9kSQrnahwBjWEj0bpN4tXn2AmUMcjVe9a+/KTCFJdJDebyHYdk83ctaatKNt8wtxBRB8uz8e2D8MYZO4V9TB+Yq1Cc2apI+58VfZWH+fKWEdX9S8G3HGQH/mWspf9uHPJUl88JQRD9XMjL5ZKm8Q2ezXuHCJftg294bLa4EQtpVC3d4fVlyxfKZh4cELFRCCCo7IT8vA0hLiM0YhYHlMTvUT4fV/qz+LQCCegOWf2C+1wGYayihEstL25Iu0tK011w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by GV1PR08MB8450.eurprd08.prod.outlook.com (2603:10a6:150:82::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 16:33:51 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::d027:c96c:6bb1:d5c3%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 16:33:51 +0000
Message-ID: <79fb5b32-64dc-430d-9eb9-9d70f29a5225@virtuozzo.com>
Date: Thu, 25 Jan 2024 18:34:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: don't run tests requiring cached writes in
 '-nocache' mode
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 den@virtuozzo.com, eblake@redhat.com
References: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
 <cfe9a043-43c1-4054-bc99-5576cd0c34e7@virtuozzo.com>
In-Reply-To: <cfe9a043-43c1-4054-bc99-5576cd0c34e7@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|GV1PR08MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1843ab19-cd1d-4c20-8ebf-08dc1dc369b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxQPOTK7yj0TTcz6BhP73i9MtmoIlqDv6UWd9lCwMYomJBHlmQCN0k1sEN8o7O5MRvqznef3UrkG0CaOSJ/T+KbSjwRcsMMq1VnoGQIr55URQZBGyfe/RBADrJD6GISHFTJYa+sNIhS1XsdssH72P3qyDkDhd+5lOMO2/JYISpUZiJwSv9bpqHNViHF/pQlM5TAnskplCVUFilgOVCQeXA4dIWex7K9a1WKUWDZbWp5KvnHQsBMqf7xE7OQpJKcnKKeKqr3teZG4juoE3X2M0D3okuRbrz3aHjfRy5MHy8FjTu28Q4YLV/ZURWDjeaN8rsrCERDnNkjdG+vO1fs4c2eXYfe8WhQQzhKAVEQTOeIRbLyZ45E7d/uVZRE+WChlU37E4GxhaeGfp3Mt9eU1xnfT3RdfLy2uBvX0q4f3Xnw69bYF0O3a/uruUGqxuTQ1jDn98/v9FpuW5AiaS/YOG4KOW8Br1T0ix/9TEzxa318sORcslL63uJDV025JLGhpFzn3Bj2oed45TEUYKLqkYIrkUuVJ/ky6zQuAVC9EZfhGSoXrzeYQMgkHFjyNAZFfFrsWAVacfkVtkAEpN13ojHiEhMAW6rOf/IIn297GnKPknenSie7aHCiLVRbiBWWXLdG5hEibf8hbkKzkmMb3Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(31696002)(41300700001)(478600001)(966005)(2906002)(6486002)(4326008)(8936002)(8676002)(66556008)(5660300002)(66946007)(66476007)(6916009)(44832011)(316002)(83380400001)(26005)(6512007)(31686004)(6666004)(36756003)(6506007)(55236004)(53546011)(38100700002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZSMnk4RytLRjgvTG1Ra1hSdS9LbTBURitQVjBST1JCWllKUTZSQW5acnNq?=
 =?utf-8?B?bTBZdW4rM3p4UU8rbWd6UmY1ZlZaWUpGZTJ3N2dSREtKQXlnWnh5RlpiRTFs?=
 =?utf-8?B?R25STUZoQ0dQdk5iYWI0QjI4T3NlSW1ZZ3RpKzR3UnJWT0lXMHZ3T1dpcWdS?=
 =?utf-8?B?WS85a1ZMdEJvcmxzT3M1RkZWWnREckU3NG5GQ0lkRmt3eGRhN3hTY0N6cmJE?=
 =?utf-8?B?MG5IQkRDZ21JaEQ3bVBrR1RnNlo1UWdQbUVKZzJ6U2xReWFtbGY4dkJOUmFS?=
 =?utf-8?B?MTFFb2FzK2NqVmsvVTBRY3JKclVIaUpiaHUvbG5laDJTV2FCaUlOcUdtejQy?=
 =?utf-8?B?TWt4Wk8zaUNrcFJuTWtpZHlCcEdtYUdSRFhSdlNDaWwyOEpOeTM1bEhua0wx?=
 =?utf-8?B?aWtFNUlOL0FtQTZsSlBqbVE2R01ySU9neTUvTUhOWE54R0tDNTdrSHVCaWYx?=
 =?utf-8?B?TS9uTFNZU2JKcFphcXlaMkZ2ZjM0Ty94c1RlenJGVll1dWJSZ253OS9KSVVo?=
 =?utf-8?B?YWk2bmxlODdSbHhhUlRoU0g4bys2SjRtdUd6SjdNQ2JhdE9Yd2RUdTZ4LzFk?=
 =?utf-8?B?aUMrNEltZGdIYWw1NnFSZTJkSnlwVDRuZmNMQ2lOTWpzUCtkRnkzTEk2OWY2?=
 =?utf-8?B?Z2pmU2lFT1VrTExoS3Ezamt0d0lwcGRXWFMrYWpDSkZtQW1KUTFRTFRObXpj?=
 =?utf-8?B?Z3VxbnBXcTE5MWxDVmJhaHhsSnBzeVRMeitZZ0dJdmlVU0dYQW1sWWhOQXNs?=
 =?utf-8?B?Z3ZNdkE5bCtoZzVqdEhUMVBGcnRlUVZUSTBBWHEyV0FZQ0IyWUlHTkh5eFE2?=
 =?utf-8?B?K0kvN2h0b1plZzhBSS9tUUtqeEZCZkxZZzQ2aGtVazlKTFVSL0hWSlZMd3dT?=
 =?utf-8?B?Y0xsZjEyejgrQ09rSGM0MmhDbHhnSEZGaHI5cE5xQ053RDVkV2ZLSmcwTDV4?=
 =?utf-8?B?ZW5xV3VsNnV0OGg2T2VmVzRteS8veEtBYU9KeENBR1ZzMXZVNlBBbGJtRmc0?=
 =?utf-8?B?UXYxS29pOFViaGhmUUUyaUc4cEppb01IdzkwUDFORWRRT0c4UDBCZ3JWaURR?=
 =?utf-8?B?bTVyWkpuYWxNc20yNm0vdlVDd1gwOTdoMWJQWU5md0hMeDkvdi9SZWRHbnpK?=
 =?utf-8?B?YVhGOVpWaDl3SG9RT2VIbE5IelJsOUJkQ01mcVBFM2ZuNVZTK3R4UEd3MGR1?=
 =?utf-8?B?TG8rOTVQSnBLaDA0TnVxUzNIeWllM1NrWld0eUt5YXc0RGdOOHdxTzV3Tmha?=
 =?utf-8?B?YkRuSHRyZHRzV1hibG13S1NHNFZtaHNON3JWeDVpMHNyS05UeXVKSWFiVnlC?=
 =?utf-8?B?TW91ang3elFGazl0bFFFdE1kTzVGbjI3bWNrdld4Vjg4ZGhhYk11bi9PdVFB?=
 =?utf-8?B?NEtFZTZ4TitTMFhoR25nYUFmdUJIMUpRc25vdVN3K0R3ckNjVjFVVHpBN3l5?=
 =?utf-8?B?R0x0ejV0OVJ1aXpZWG5HOWhIZWpDcVVGV0hBSFB1WHhJUWxpMHJubHpvL3U0?=
 =?utf-8?B?cms5bjByZkJjWTRNakQ1R0RDY1ptRmw3azdwaDJYRFUvaW1YR3IzSjhlZGQw?=
 =?utf-8?B?dEZLUytaZno3c25lUXpjZDJPSTlTT3Y4T1dya0lEekxhRGZOREZPcWFzN2d1?=
 =?utf-8?B?eVZaUUpxK1AwQ0tFOHBxb3R0RE56UW8zbG4yRGFxQ0gvUC8xZVl4VlAyRHB2?=
 =?utf-8?B?aEhXMkJVMzBBNWQ0NXhVemJHa3l2OHVXSEtyNlZjTVp5NEZFcldjQXE4U2xr?=
 =?utf-8?B?RlduZHVZTm0raEJCV3VtdEtENlVSbkc2RHBHYXh1TldKTlIrbm1FQW1GMVVz?=
 =?utf-8?B?endRUDZrcWN0UlM2NDdBZ05pSUU5QTQxTzlKK3JCTlNCZnpQN1ZRSkNRSzR5?=
 =?utf-8?B?L05HRXNGWjZsc1BkTlpvcGZaby9pYWFHcVYrdEJUdUU1aHdiSUlOTTErSzFx?=
 =?utf-8?B?VnVtb0U3Qit5S1JlalhZYWp6RTZ3NWkyMWJrVUs0SFgvVEE3OUlyZGZHd3o2?=
 =?utf-8?B?YzE0bFRZMGtXNGsxZjRIQnVhYVhOUlhwYWZFdVkzZW9CclVBVUw2eDZ3bmJN?=
 =?utf-8?B?UzZjeEhsR0M0VWs1UCt3KzhQY2FpaGo0TU50UHp1QUFGWTNhYTlCVTNPVG5j?=
 =?utf-8?B?dlBrMk85VlJjY3lpdmZoMjBLUVFpQ3JMTmlyS0Y0N1hCaHAzMXp2THc4cEhP?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1843ab19-cd1d-4c20-8ebf-08dc1dc369b1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:33:51.0512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBhWk3RzD4g9ZFi2G7ED+OX+IfMrOfICF8MiAAWL5rsLPs+n5mJCnxrrEd5LReniLveKpqo2R85YCX5JWTK5zQU0RCP3/kG/y98gka61c3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8450
Received-SPF: pass client-ip=2a01:111:f403:260f::700;
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

On 1/11/24 14:53, Andrey Drobyshev wrote:
> On 12/11/23 15:32, Andrey Drobyshev wrote:
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
>> ---
>>  tests/qemu-iotests/271                 | 1 +
>>  tests/qemu-iotests/308                 | 2 ++
>>  tests/qemu-iotests/common.rc           | 7 +++++++
>>  tests/qemu-iotests/tests/file-io-error | 1 +
>>  4 files changed, 11 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
>> index 59a6fafa2f..1424b6954d 100755
>> --- a/tests/qemu-iotests/271
>> +++ b/tests/qemu-iotests/271
>> @@ -44,6 +44,7 @@ _supported_fmt qcow2
>>  _supported_proto file nfs
>>  _supported_os Linux
>>  _unsupported_imgopts extended_l2 compat=0.10 cluster_size data_file refcount_bits=1[^0-9]
>> +_require_no_o_direct
>>  
>>  l2_offset=$((0x40000))
>>  
>> diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
>> index de12b2b1b9..535455e5b1 100755
>> --- a/tests/qemu-iotests/308
>> +++ b/tests/qemu-iotests/308
>> @@ -52,6 +52,8 @@ _unsupported_fmt vpc
>>  _supported_proto file # We create the FUSE export manually
>>  _supported_os Linux # We need /dev/urandom
>>  
>> +_require_no_o_direct
>> +
>>  # $1: Export ID
>>  # $2: Options (beyond the node-name and ID)
>>  # $3: Expected return value (defaults to 'return')
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index 95c12577dd..f61eae73b4 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -857,6 +857,13 @@ _check_o_direct()
>>      [[ "$out" != *"O_DIRECT"* ]]
>>  }
>>  
>> +_require_no_o_direct()
>> +{
>> +    if [ $CACHEMODE == "none" ] || [ $CACHEMODE == "directsync" ]; then
>> +        _notrun "not suitable for cache mode: $CACHEMODE (implies O_DIRECT)"
>> +    fi
>> +}
>> +
>>  _require_o_direct()
>>  {
>>      if ! _check_o_direct; then
>> diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
>> index 88ee5f670c..2b8dc7f009 100755
>> --- a/tests/qemu-iotests/tests/file-io-error
>> +++ b/tests/qemu-iotests/tests/file-io-error
>> @@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # Format-agnostic (we do not use any), but we do test the file protocol
>>  _supported_proto file
>>  _require_drivers blkdebug null-co
>> +_require_no_o_direct
>>  
>>  if [ "$IMGOPTSSYNTAX" = "true" ]; then
>>      # We need `$QEMU_IO -f file` to work; IMGOPTSSYNTAX uses --image-opts,
> 
> Ping

Ping

