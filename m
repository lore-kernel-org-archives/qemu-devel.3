Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1F0C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 07:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirLM-0002kl-CD; Sat, 09 Mar 2024 02:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rirLI-0002kd-Sr
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:42:05 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rirLD-0006uY-C4
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:42:04 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4295F7eS004832; Fri, 8 Mar 2024 23:41:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=5Sat1qzMXZTqZYn+roSWUcD/5ykPz1JDFqLzQHctQ
 QQ=; b=jMs/41U0rsktniGoPLPoDQxse4l4wZAcHgw3APhQjqPKZ7NteytyVsYzh
 PtvLwb8NXRQusxbJahJpBBQKhDwH7CFLGC0QtwheZ7ATO0k32ss/UHpwoCC7Nq/N
 0UWiUnhRBEz3x6UcAGJ8HaE3ccCUI2Y4stTnVe7xOPkPpIJJBrjnLV/NZUPbEsQ4
 DcveQ1CzZGQ7E0XxHRLk1Gkn53za1s3E+2jSjUIYzBaDZEFdCIPdWYKcDeI66sgA
 XQyXFCRHYx25jezdv+s4TtLp60kisUOc9xdX2RqXEbehkxAegQ72oIFg4HXG3KSi
 JBdh0sjNZ/JH+j47Yb/U89AHRf+Pg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hpq64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 23:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drjIIQoIeEqjG3TYWl9xyG9hZzouhQmPZHqGBNQmEeDsw3nqxCRO919OlRn1fFjeivduEVGdFTGl5ruaWYo+xD3g+9jvi7nRh1ji7Eu2E5hk8sMsCJtmIIbdPXxA8cIH7vyD94VJiZh7Z61SEo3WEncgUnPMqXxRThmVLuQcKzNxhNWDnGTtROG7zhitHe0sYuML0IOap+aMOqYPoeI/D8x7rDukPnxAE0XAWvz3au2dEmao27HTcsUEys9/qHrZ8dfevzdFSi4xGpbrUcxwhA8AKeYY96sYEFFUitCYtP04HOoK/ip4cZunSb85EBhnOtufhdigvvglrT6b24xbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Sat1qzMXZTqZYn+roSWUcD/5ykPz1JDFqLzQHctQQQ=;
 b=dsU+BkQvXKjiRsU43wVFkGEEiokM6YRBWjRfzqmiVpKOa7XgH0Dn81oBdbmbkB7SVnsIDhc8/b+pgZpq2u2hJIRwcWomiiITR0GRWtksalNm0zEbFEP2nly1ZRRMyZXTBSuZjfbyT4hszi4VlxMJX6s34ouQJ1JljEZPuzUHphLfNgDC38yj3zvmWE4UrimnrxekAAkJU1Jv1lOkr/+4G7PBEadeLRpCdFSLzUJYO0n2CIR1+Sy1lwPlbKRioTNso+X9zfSqsR5SsdJTD6UEsa9TKvaj4r4AIOor1rdS0ALEiy11FG+EON8T8ZF5n1LLpetLWdqorYQI3BksAAx0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Sat1qzMXZTqZYn+roSWUcD/5ykPz1JDFqLzQHctQQQ=;
 b=gJRpy925XPoMdIVzjaw/Nde7110JOOg91QCH0dLaiPbHNM8YGpDNuOkKzxnA18EZJjBc1NsjCcbtuR9pPe4m+vMDKO/aIqDqfpG9WXmQzzwhW0Pu8LnoLu+FtGMPRXlRFzyIrp7SrrfrPAWpC7R797lrtNObZohNR2jZ2RME0BpevfOxjOyzqqbfkNxynX+OpIeDdrgyr865HY+x8udsHhoUGq8DB5FePg2LMrqQKB4kkQGwV6ABb2fj+YS+08lSQjBVhLAEiJnp2zCzlGqhl8/FG4DhRDiz916F9KGvZAk3PuvQoWlMYnQzecBY6xfDJayTF8iwbjvhID5mOox7Mg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6643.namprd02.prod.outlook.com (2603:10b6:a03:213::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Sat, 9 Mar
 2024 07:41:52 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Sat, 9 Mar 2024
 07:41:52 +0000
Message-ID: <1db9b780-a83d-4794-8ddd-1547615cdd9b@nutanix.com>
Date: Sat, 9 Mar 2024 13:11:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240308205951.111747-1-het.gala@nutanix.com>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240308205951.111747-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: b22d180b-1f52-4eaf-1792-08dc400c62eb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nFjllqm06o1Q4c2gP9Y7XtmKKEpmuh1uCrhiVvYOr8K1SaCpX/ah4zbRlWSpaUo1l+kKM9euDL0QevUrdkuR0/fzoTRC5v0v/ObZYScSwRmGZbP8sg6jVxDjVODI6z5lzj/+LezWq04rXQytqeERkpaVsuF5YwBott2Ep40ylwI8SxdmdJxi4j84QYOT6LHLXInKJ6lp4oJ0J/IB8f17Qz6lBWP5EwkCX6E9a/9KzRXIHnw/DjpzxrvMFymHaKHI+oPDOl52dYJNoEPAoHPyO3Ua7CyVmZgdY7rf+fFqIOfgebzD/xrqNnfImrgc1p0K4VlL1u8EeuhNtW7cqqeNaTZKhistZXqbeGg+K0/b0d2IdzsrCBVky5BZ9vPaiYxPY2GPefNQv6mzhHRHfXDpuMT1/eBLXRLKej/Dwzkw89UASH11mYJqvp6OmdyqT5QSc/DGkMM1TVQH3kaxegS5/OrFGeUbyQvMABz0hESdtf6jAt8SnnDHJUsM6HAb9UZSm5VVaroTk8Huaw9Ar/imrEGhQB0wlY5QAt8gms1O+SUS1MXTsH9T9su+tiQviB+6jpIhSMQDHCu4HUMEygVJun0xzS4UtaZ3YxKBYeMu9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVWSGZCeDVlL0p6YmxpTFdINjdWSmJJWlVQRVNTU0RtWjZDNEN2cUhmN015?=
 =?utf-8?B?V2FnTnliWXUwdDJIUEE1NCtxQ2Rvd3FnK0FFWC95SjhzTGNyYWFKQWhyYlg5?=
 =?utf-8?B?Z0tVcDl5blEycjZMQWM1MWh5UEdmZmpybkIrZ2srcFdrT1VDdUlCNlVydmM2?=
 =?utf-8?B?SFJaWlIxZzd1NzlLMktiektyVjdQL2FSK2FDcHIzOXhScFRiODJJZXhJV1FP?=
 =?utf-8?B?cjAvNzdVS0RJQTBYdDYxajRnbXQwQWxkUUhwSnFhOWxHTlgycmVqUE92Y0Vs?=
 =?utf-8?B?cVlhRGVpeWcyOWlzdEY1V0Jhb2g0akUvanZoNVl4bXhwT1lzZE4xL0FGTlRa?=
 =?utf-8?B?TlIwc1E0SWhXNXQvaHVOdFloaVh0SDZDM3p4eldDYTdXanVoT0tmM08wZTZJ?=
 =?utf-8?B?dVMyTm1qUHlGRTRJRnl3dE1pR2xqQnFPM3F0QUw5aGQwWitVaEVJZTVtbkx5?=
 =?utf-8?B?TWpyM3NyMFFBdTJJRzBaM2FKN3c3cmFNS2F4U1BoWkQxMzFSOWxWOHZHNytk?=
 =?utf-8?B?Tm1xUnQxYVdJM0tMQm9lVzAraDVWRm5vVit0dWlGdlNxOWN2ckM1LzFCMG5z?=
 =?utf-8?B?Skw4bStESWNkQ1hVL240alhxSkRqRG5uUnNMWXQ3MXhCZEJTZXVQSHpWbzUr?=
 =?utf-8?B?QTcwN3FUZFE0QXJIa0xNZlN6c2hXNlJGbEVNenZEZEJ0cTNOblZ6TmZRdFlw?=
 =?utf-8?B?c1BJL0lTdkFSQkE0dmxyYy83T1M2RElFbDllSHVUYytFajJtNXJHdVVMS0or?=
 =?utf-8?B?UFNsclA1N3orYmx1dXZ4ZmVKcU81UWl3QmZPaThIYWhWL295SkdDU0h1bzhx?=
 =?utf-8?B?OXh0NEUxVDJ0ZU1yVjlNdEhPREN6RHFSTWtSM1VaREp1VEdiTExlTFZ4WHRZ?=
 =?utf-8?B?S25vUmZaY0xlMnR5Zzl2bVZQQzJ2eFNZc2JRMCtKZU85UjcrMWFtSk9iNkpM?=
 =?utf-8?B?citmdElXQW1XT1dXVHdsME10REZNWXRQQVhXMzBMMm5tb0xROWg3SGJDbkt5?=
 =?utf-8?B?bElYNFkrUW1KQmI4M2R3bW9QUTlYMGVrU0ZBNXNrQWFDWU1TWW9PSVg3alpD?=
 =?utf-8?B?Q2NpUUdKUnJBQUV3NjdqdEx3TEtwOUVTcUI2OGdySHRxUGdFK2k5SjRlUkd6?=
 =?utf-8?B?a2RPd2IxemZzdjBzNkNzc0t0YUhCY3VESU1TSlVPMzBGd1ErZUxiY3dYWFFa?=
 =?utf-8?B?eUhhc2RjMlZPOGYrRFNHVXBubE1yM0djWnFGbjVnWlJzY3NqdGJsV0o2TDE4?=
 =?utf-8?B?dkM3elBMY1JKTmRaQURtYUF4cWtISDNOajM4Nk1rQmtRTW56NWsyQTJPYjhF?=
 =?utf-8?B?QzhaWTRJYmZ2NkdGM09nWlFyOGdCdXltUjRjeEFlSHdiWmhrcDVkZVQ4d1Jo?=
 =?utf-8?B?RXNPUnBhRXRGRDNFSDBOSHNMSnJCYW1KYXcwUlZQYnNuZkxLbExYN1REZVZK?=
 =?utf-8?B?MWFFcHJFbXR3YWhFUWh6Rlg5eUVuMHdrQ3VRYkVGNktrY3llQ2FwTE5IZHdC?=
 =?utf-8?B?NG1iSXgvRHBmK01oOGhsVXovYjVoek0vdUc4MjF2bWdoVmRoeDdKSE9pRmpC?=
 =?utf-8?B?OG1CbU1PYmVBbk5WeUpOOVVBNEQ0cW1CeUxCWHlEM2Y5MlNKRGI5elhtbTZG?=
 =?utf-8?B?cjFXQ2hiZjB3RnJ0YWkzNGg5YUZzM01FanNmVVFTWm90NE1EU2ppTXA2Nlo5?=
 =?utf-8?B?NVFrSEw0Q01RNFZtY1VKNzREZ2JhRkZma1BaVVlERTVraC80UjA1dEpOOHJN?=
 =?utf-8?B?a2ttWHZ3TWZFaDRKVWJqOE52UHVRa2RKZ0pJOFUweEJZMTNFS25rWTk2aCtQ?=
 =?utf-8?B?TCthcVRKTHRidThNcEJJQU55a1YwMHp2bGJ3NFI5c25MRmw5Y0piMHBXWkhv?=
 =?utf-8?B?NHA5bjIwTW1nNys2STVMTUk5VTlpaE5hN3pBZjRmOUhDeEFPYlNSbkJGaDFm?=
 =?utf-8?B?dzcyckJuQVRqOGlROW9OOTF6S0pzME5hcnZUK0lEbFNEWWl1cHA0Q0x2UDZ0?=
 =?utf-8?B?ZmhwU0tCMVc0Q0tvVDdkWk5XRnZoTi9aS2MycUtncUhhd0JwRFhLZmZETFBK?=
 =?utf-8?B?TTlQbW5nelBPdGFSK1dTMXY4T01mMHZPTFNHYUhZaGQrVUxIb1BjMjgxYVJE?=
 =?utf-8?Q?1m03e99SkLV4A/lVgfkiWLJ1M?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22d180b-1f52-4eaf-1792-08dc400c62eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 07:41:52.4183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buP/CakijiGJsrQADvVXZcpnFXyYstbWczrsBRHueZEmIdk8QwGLU3mfRI8Sz74fz/cLuVeGg1ZHqQgXl6V1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6643
X-Proofpoint-ORIG-GUID: hg7tgH6XBRcKimZqVadGKP71G3d-nLNV
X-Proofpoint-GUID: hg7tgH6XBRcKimZqVadGKP71G3d-nLNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Can find the reference to the githab pipeline (before patchset) : 
https://gitlab.com/galahet/Qemu/-/pipelines/1207185095

Can find the reference to the githab pipeline (after patchset) : 
https://gitlab.com/galahet/Qemu/-/pipelines/1207183673

On 09/03/24 2:29 am, Het Gala wrote:
> With recent migrate QAPI changes, enabling the direct use of the
> 'channels' argument to avoid redundant URI string parsing is achieved.
>
> To ensure backward compatibility, both 'uri' and 'channels' are kept as
> optional parameters in migration QMP commands. However, they are mutually
> exhaustive, requiring at least one for a successful migration connection.
> This patchset adds qtests to validate 'uri' and 'channels' arguments'
> mututally exhaustive behaviour.
>
> Additionally, all migration qtests fail to employ 'channel' as the primary
> method for validating migration QAPIs. This patchset also adds test to
> enforce only use of 'channel' argument as the initial entry point for
> migration QAPIs.
>
> Patch Summary:
> -------------
> Patch 1-2:
> ---------
> Introduce 'to' object inside migrate_qmp() so and move the calls to
> migrate_get_socket_address() inside migrate_qmp. Also, replace connect_uri
> with args->connect_uri everywhere.
>
> Patch 3-6:
> ---------
> Add channels argument to allow both migration QAPI arguments independently
> into migrate_qmp and migrate_qmp_fail. migrate_qmp requires the port value to
> be changed from 0 to port value coming from migrate_get_socket_address. Add
> migrate_set_ports to address this change of port value.
>
> Patch 7-8:
> ---------
> Add 2 negative tests to validate mutually exhaustive behaviour of migration
> QAPIs. Add a positive multifd_tcp_plain qtest with only channels as the
> initial entry point for migration QAPIs.
>
> v3->v4 Changelog:
> ----------------
> 1. introduced migrate_get_connect_uri and migrate_get_connect_qdict to
>     both used migrate_get_socket_address to get dest uri in socket-
>     address, and then use SokcketAddress_to_qdict to convert it into qdict.
> 2. Misc code changes.
>
> v2->v3 Changelog:
> -----------------
> 1. 'channels' introduction is not required now for migrate_qmp_incoming
> 2. Refactor the code into 7 different patches
> 3. 'channels' introduction is not required now for migrate_qmp_incoming
> 4. Remove custom function for converting string to MigrationChannelList
> 5. move calls for migrate_get_socket_address inside migrate_qmp so that
>     migrate_set_ports can replace the QAPI's port with correct value.
>
> Het Gala (8):
>    Add 'to' object into migrate_qmp()
>    Replace connect_uri and move migrate_get_socket_address inside
>      migrate_qmp
>    Replace migrate_get_connect_uri inplace of migrate_get_socket_address
>    Add channels parameter in migrate_qmp_fail
>    Add migrate_set_ports into migrate_qmp to update migration port value
>    Add channels parameter in migrate_qmp
>    Add multifd_tcp_plain test using list of channels instead of uri
>    Add negative tests to validate migration QAPIs
>
>   tests/qtest/migration-helpers.c | 158 +++++++++++++++++++++++++++-
>   tests/qtest/migration-helpers.h |  10 +-
>   tests/qtest/migration-test.c    | 177 ++++++++++++++++++--------------
>   3 files changed, 258 insertions(+), 87 deletions(-)
>

