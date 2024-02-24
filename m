Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5F8C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrS0-0001se-3u; Sat, 24 Feb 2024 07:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdrRy-0001pU-3A
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:48:18 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdrRv-0007fB-G4
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:48:17 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41OAdMfG002919; Sat, 24 Feb 2024 04:48:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=J4EoUNOmYcNV
 DoOBxvUVfgN+2+1bbKc659yW5ALkH3I=; b=s8fYMg45WmhoOFhDf7mKCzu73ZLv
 K6BcHj6TlrdbdouiISd/wDVU566Ez5E5ad1bncxiMdn0imS+HVNnrY65UX7c/ZqX
 0tEFIqY25JZ8jS+ai1CyEsXlAqJRbGAiX6ZdtzxIq9bewpL7U4HNp58cEU2qTSN/
 wm6JMaqLqko9m4MT1iyNPpBoRKug1Z8rawYJ8XqZz5OU1FlMq6/bew8j9oENONYA
 DUbzaV4NNd+hIRW1oavaqTBtjpUmamBrMUr+I6bboeYaDfvzymKPVu6X8miFePWJ
 sMdqtlvqfcOKCXJW6J0kXv88HOSHn5jvcU1skRlX6vaV30SfpoR6kKmmnw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wfeva04fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Feb 2024 04:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMo4cMd3/bGDP5yoTcQBsfToukJ6gsKh08trjwnKWoDM8ExYahBbFUIBItjvUd+FBaq2guPYM+KsrVPw5y9qq1nSLMmUojRIOCvN++ro31M3qSiMADNfGrfw45siNVTiOUnwJs3Ct7W7hTwy3uIQwKJYYJG+vOj6Hjw+pAGxhvV+SUIYahN9egW0kPA7pEo7C7gRM54VCK4Xuogf2+w5SyBqusCWlYNe78R9NpUlI0KSn+4DwumJqN/ihBcmpyjaEOlKYjEgv1Rgjc1XQ/bmy95jPECNG+V16gXcrKZnVfoDDz3dxbfKhnBaDoGFXBqVAbVd+4gfyfwCap+iY7wzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4EoUNOmYcNVDoOBxvUVfgN+2+1bbKc659yW5ALkH3I=;
 b=aYBmzttFcbY4KLauomwDaWxljangUM1rS3ZPOZtEt0CY5aOWZUVJzOPdk2/jubxGLXMotmQ5gl0zRDZe3qdlFvTWXA7qi+nRuJw8g1fN3FqoUMfBw2Oj49IIpB2EE13AYz8jHZ0gxDWLOp3c6h1HPUgOorf6nqCnI4XI1C9cva0dlv/8JWk3i54IQ4qNU2ERFhiTSms+byGwCxZyVokNt1ZGuXnoJdbh3O4YpI3b7KpnhF0u+factS2EJvCxpf9LfqseZGCVhbLykefsom3jbc17wRY13LBr4IELBmqpxxmjO0970WoPYWhoSk719w+95a/NZWCYhRZRyLrH3xST3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4EoUNOmYcNVDoOBxvUVfgN+2+1bbKc659yW5ALkH3I=;
 b=JvaGWsQNKBcvURwBbEYWwbdUbwG8OR1FSmfvDL1jI/wlS+b7XlIbij46nwv9vOH6nJfdvqXe3JYbEH7QgM0agdT5PbVHDmuQ5RDVZb+PPC8v1zIyZQM9cd3xqW+2ooEcmo8Wm0ylUrGLeRGFJ3yRAKmt034bqP8eP4ljCxNp5oGlNRIi7VJl+0uYhZMCKNDYPrr9hiZedm7LIHLsBvBbQ98t1+3EJtP6tAkZZyYY8lIn9/fAFEhU4VbIFEeHv/235HsBTyXUrEJ/abxwRkCpJ8+LOhsvghc/yMz6IdkjeO4anJixqXjWzBuPFdYLToZRHg3t5UjDhOLG33YvTZ5rYA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB8784.namprd02.prod.outlook.com (2603:10b6:a03:3d7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 12:48:10 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 12:48:10 +0000
Content-Type: multipart/alternative;
 boundary="------------TnhExN8rApoMsLJLo2l6zhNR"
Message-ID: <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
Date: Sat, 24 Feb 2024 18:18:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87zfvr7xdn.fsf@suse.de>
X-ClientProxiedBy: MA1P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffd0606-6814-427e-f674-08dc3536daeb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCOHV8yf+L2OGe46cSQeLuH84rvrw/Q/1hzVH4Wp7/k6xX+naPjb+5+tiqGqqVkuNynOSkly759cDbY+uaTpOLB9YPWpx6R9IuMqEqdIcjT+7MwLEFAIbbrk6w0V6FpxgCOyni74DTqDIdaMj4KZ+zptpK9CFV4+63udfvS0/ubeXtzBjeiYgMIDZLmG+nHL7YhpUdbwHSvr7T1SmPWLNAwnEQllD9XkcuouHbgJSRQAKm81C6mw5SXTXewn1lG+fsk6z34gHkkKpGQ3qMIPHM0G4Jk7M9lPg1ITzG0imZUgy05ztzbugdZEy75iYF5cUVlftww44Xg+lST8MPjsIQ/UTXXb7ClKWDEuqHeT1ABTYjeH3jwPGhmQf9VoLr5z6EWmNwElLKDZcW2qMQjC4er4ozjO6aRO7IcMpLJv2ktHznmUdp3WNqSzEo3Gr/2LmxGDf0DQ/DuhzQjwBpxg0oNkMtrCRBluxUE7+vMNehgqyaY8OTv7wBhVEQXGLsXuZIrkW1URd9SYheMRx7/vhR2MqAuRBi5LSH36hsBsBrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1RkaVdsSDZPK3ZJdHp6a0JadnpPUEZ0V2lzd0ZKd1pDaGV2djNrR1gwblNs?=
 =?utf-8?B?TkdDNytHZ2J3MmRhVXUxNXk1WHVlV1F0V0VTcUVmUVAyaUFMUW9RRlJkdElR?=
 =?utf-8?B?M3BUZHkvdlJKeXhIY0pYMUxwUmZISFU0aXJOSnZobmFuQVhXQWs2YTdlQWFm?=
 =?utf-8?B?RnpWN1RvbnUzRmlxWDNlUVgvY0pEN1d6S0dQWG1IRkloYTJUQ01EUDl2RGNL?=
 =?utf-8?B?L085cDFNYmh6SldnVkJrMEFKRkVpNGcrRS9wUUdsZFp2dEtpYVZtOXZIWlFh?=
 =?utf-8?B?V2cxbW9FeTJyZVBqL2p2czNBV1BoMGplbHF6ZVRMZVJLZlZjMzN3ejJhTnFQ?=
 =?utf-8?B?N3IzQ3lsOVJvV09GUmlWcHZETnE1ZVF2WHR4ZVlDSlhnQUo5UmxHQVhSaUM0?=
 =?utf-8?B?TUpqOFdlZlhnbmx2T2wwNURNOE5kS0ZFWnMzZ0FVTU9lQnUrby9GaXRoYXlD?=
 =?utf-8?B?cTZaVzdzdVVMT01KZFdmamE4bVB4TWVHbHI4S3NZNFNGTlBBNEV0bVdzaEFE?=
 =?utf-8?B?Wnc4dzBMRGxmcHlucEk0cEhyb1dUM2NYWXFUSGlNM3R5c0hGbUR5TlV5WWlH?=
 =?utf-8?B?VGxwMExmdU5BMlJRaHg4SU13TlpBbXpEZGZvSVcvL01DbFpYMkUvTW9tOHlh?=
 =?utf-8?B?aXVOQ0FETHN3VE9iUzBXUDRwSkV3dll5ckRWWHpUNWtNaExtYmFFd0lPY3B3?=
 =?utf-8?B?RW0zZlJ5WkFkU0cxdlpSb3Y5WnZhaHNzelFsdXhBeGF4dS96eG1GODJQRFJM?=
 =?utf-8?B?d0hjYVlzaU1tWTlSREVSc0UvVHhRTENOS1lTWFpWQ0l4cjBDZ0w5eWVFMDQ2?=
 =?utf-8?B?VHFQcG9zQ2VGRm5xbmI4TnRjRVVxOWdLZFllVVFRbDNOMWRBZU5JUGhWekdT?=
 =?utf-8?B?MXl6UTgweWoweHJLRjlzbzBKUWRRcStkSlhaemg3amU5WUlQTUVtRnM4UGt5?=
 =?utf-8?B?Yi84M2NpL2Zld1NIUk1yL3dtK01JMjdkV1ZqNEtPTjBSYXE5VUswYUExV0hm?=
 =?utf-8?B?bVlEVGVrT253QzhER3gySHltVnFUczdZOTVYYzVWbytVdWFDY1l5ZEd5Y3hV?=
 =?utf-8?B?VVBjSld3Vzkxc01ZVXR1N3puWTM3aXhnb3lpSkNscWk5WDR5WnJPL2o2bHFV?=
 =?utf-8?B?YmVGalQrNkhZK1VVTnJBWEc5c1lZaExabCt2NFNtaU5GbElBZUwrZWpFZUQ3?=
 =?utf-8?B?Y28yVGlMMWdhcWxxUXM3eHJLUmJLblNGd2dKdGpHT2FkOWxlbjJDZTJINTlP?=
 =?utf-8?B?ZXEzSTVUb3JGUG9GcjgwUlhTbUVHNEVSWjM4S0d6QmNsRVNsSG13UVdaczlT?=
 =?utf-8?B?dGxGMlJqa1oxSE1PdFpuc3R2NE9jeW9LSHF0eHV1MTZVTmZTOWJPbk9UVVkr?=
 =?utf-8?B?VnJ3WkhZTmVQd0lCeW9Zb3NjeThhellsV3JZcUhNY2M0eTZYdzE0M01DV0FT?=
 =?utf-8?B?ZlR5Q0JzVFFYVlZNQW5DdnRPa3ltdmdDQlN4MlZkeGc3MjZ4Zlg0UFhhVUo0?=
 =?utf-8?B?VzZiUmpQMjhCSFNhQU1oZUZLRWV1NDJZcW4zTW1tZG4rQW9ER1k5cGpOTWRO?=
 =?utf-8?B?QUg3bzQrZWhBUzRLbHovU3FXRnZFVUl6cGVkT3NUV2laeExwaExESHNVZXd2?=
 =?utf-8?B?VDBpWU51bU81TFJBR09CbmVLbWIwUFJ3L0x1WUtwdnkwemdHaDl5VVRaUVZq?=
 =?utf-8?B?VCt6VGttUDhtdEVMZHFXRVlrYkhJdjJmYm50M1FWSEpYVVBidjhELzRMRGRJ?=
 =?utf-8?B?cnk1R2NQdnBaL0cranlXdHFjQ3BudFdRV3R0T2RjaGdKUWJObGh3OW5ucG9x?=
 =?utf-8?B?anV2Q3hXMmVndWhpYUdNc3pTRlNNUk5zSlRhTVJoY04yVndvR2MrSzEzT1FZ?=
 =?utf-8?B?MENmNWxwUnRJdWZnNVhneS8zeTQ5T2NIQlphV0xQNk5rOHl3c3BRZzg5bys4?=
 =?utf-8?B?c2JyVmdyZjJsRE43bEk0dGhCT0pnblhlSUlCL2xjSjVSMFJaNE9lbkhCa1cy?=
 =?utf-8?B?S2pzYmxBUHcwenZucENpRTBkaFFlVEE3Qzl6dUcrcWpYUCtPWWpud0E0QXJB?=
 =?utf-8?B?WHNNeVVYVjIzZTlFTk8wTzJjYkRkV3ppQUpiYUxpN3QwZVNkN1hmcXBCbGsw?=
 =?utf-8?Q?Sq3MKlmoAeajLeoJuGS0a9SUH?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffd0606-6814-427e-f674-08dc3536daeb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 12:48:09.8504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoirLwwr2QQgfv5cMn1I7f2ENYXxSoLETlAisAL/XupwUhfkBc57UKAooV+k5ctclv7dBzQ2XF1JnCJSERYqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8784
X-Proofpoint-GUID: 0iNO36bhEAONOHrewJVnhvhCTb-LE_Y0
X-Proofpoint-ORIG-GUID: 0iNO36bhEAONOHrewJVnhvhCTb-LE_Y0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_08,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--------------TnhExN8rApoMsLJLo2l6zhNR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/02/24 1:42 am, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Introduce support for adding a 'channels' argument to migrate_qmp_fail,
>> migrate_incoming_qmp and migrate_qmp functions within the migration qtest
>> framework, enabling enhanced control over migration scenarios.
> Can't we just pass a channels string like you did in the original series
> with migrate_postcopy_prepare?
>
> We'd change migrate_* functions like this:
>
>    void migrate_qmp(QTestState *who, const char *uri, const char *channels,
>                     const char *fmt, ...)
>    {
>    ...
>        g_assert(!qdict_haskey(args, "uri"));
>        if (uri) {
>            qdict_put_str(args, "uri", uri);
>        }
>    
>        g_assert(!qdict_haskey(args, "channels"));
>        if (channels) {
>            qdict_put_str(args, "channels", channels);
>        }
>    }
>
> Write the test like this:
>
>    static void test_multifd_tcp_none_channels(void)
>    {
>        MigrateCommon args = {
>            .listen_uri = "defer",
>            .start_hook = test_migrate_precopy_tcp_multifd_start,
>            .live = true,
>            .connect_channels = "'channels': [ { 'channel-type': 'main',"
>                                "      'addr': { 'transport': 'socket',"
>                                "                'type': 'inet',"
>                                "                'host': '127.0.0.1',"
>                                "                'port': '0' } } ]",
>            .connect_uri = NULL;
>                                 
>        };
>        test_precopy_common(&args);
>    }

this was the same first approach that I attempted. It won't work because

The final 'migrate' QAPI with channels string would look like

{ "execute": "migrate", "arguments": { "channels": "[ { "channel-type": 
"main", "addr": { "transport": "socket", "type": "inet", "host": 
"10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ]" } }

instead of

{ "execute": "migrate", "arguments": { "channels": [ { "channel-type": 
"main", "addr": { "transport": "socket", "type": "inet", "host": 
"10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }

It would complain, that channels should be an *array* and not a string.

So, that's the reason parsing was required in qtest too.

I would be glad to hear if there are any ideas to convert /string -> 
json object -> add it inside qdict along with uri/ ?

>    static void do_test_validate_uri_channel(MigrateCommon *args)
>    {
>        QTestState *from, *to;
>        g_autofree char *connect_uri = NULL;
>    
>        if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>            return;
>        }
>    
>        wait_for_serial("src_serial");
>    
>        if (args->result == MIG_TEST_QMP_ERROR) {
>            migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
>        } else {
>            migrate_qmp(from, args->connect_uri, args->connect_channels, "{}");
>        }
>    
>        test_migrate_end(from, to, false);
>    }
>
> It's better to require test writers to pass in their own uri and channel
> strings. Otherwise any new transport added will require people to modify
> these conversion helpers.
I agree with your point here. I was thinking to have a general but a 
hacky version of migrate_uri_parse() but that too seemed like a 
overkill. I don't have a better solution to this right now
> Also, using the same string as the user would use in QMP helps with
> development in general. One could refer to the tests to see how to
> invoke the migration or experiment with the string in the tests during
> development.

For examples, I think - enough examples with 'channel' argument are 
provided where 'migrate' QAPI is defined. users can directly copy the 
qmp command from there itself.


Regards,

Het Gala

--------------TnhExN8rApoMsLJLo2l6zhNR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 24/02/24 1:42 am, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87zfvr7xdn.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Introduce support for adding a 'channels' argument to migrate_qmp_fail,
migrate_incoming_qmp and migrate_qmp functions within the migration qtest
framework, enabling enhanced control over migration scenarios.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Can't we just pass a channels string like you did in the original series
with migrate_postcopy_prepare?

We'd change migrate_* functions like this:

  void migrate_qmp(QTestState *who, const char *uri, const char *channels,
                   const char *fmt, ...)
  {
  ...
      g_assert(!qdict_haskey(args, &quot;uri&quot;));
      if (uri) {
          qdict_put_str(args, &quot;uri&quot;, uri);
      }
  
      g_assert(!qdict_haskey(args, &quot;channels&quot;));
      if (channels) {
          qdict_put_str(args, &quot;channels&quot;, channels);
      }
  }

Write the test like this:

  static void test_multifd_tcp_none_channels(void)
  {
      MigrateCommon args = {
          .listen_uri = &quot;defer&quot;,
          .start_hook = test_migrate_precopy_tcp_multifd_start,
          .live = true,
          .connect_channels = &quot;'channels': [ { 'channel-type': 'main',&quot;
                              &quot;      'addr': { 'transport': 'socket',&quot;
                              &quot;                'type': 'inet',&quot;
                              &quot;                'host': '127.0.0.1',&quot;
                              &quot;                'port': '0' } } ]&quot;,
          .connect_uri = NULL;
                               
      };
      test_precopy_common(&amp;args);
  }
</pre>
    </blockquote>
    <p><font face="monospace">this was the same first approach that I
        attempted. It won't work because</font></p>
    <p><font face="monospace">The final 'migrate' QAPI with channels
        string would look like</font></p>
    <p><span style="color: rgb(209, 210, 211); font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">{ &quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;: { &quot;channels&quot;: &quot;[ { &quot;channel-type&quot;: &quot;main&quot;, &quot;addr&quot;: { &quot;transport&quot;: &quot;socket&quot;, &quot;type&quot;: &quot;inet&quot;, &quot;host&quot;: &quot;10.117.29.84&quot;, &quot;port&quot;: &quot;4000&quot; }, &quot;multifd-channels&quot;: 2 } ]&quot; } }</span></p>
    <p><font face="monospace"><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">instead of </span></font></p>
    <p><span style="color: rgb(209, 210, 211); font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">{ &quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;: { &quot;channels&quot;: [ { &quot;channel-type&quot;: &quot;main&quot;, &quot;addr&quot;: { &quot;transport&quot;: &quot;socket&quot;, &quot;type&quot;: &quot;inet&quot;, &quot;host&quot;: &quot;10.117.29.84&quot;, &quot;port&quot;: &quot;4000&quot; }, &quot;multifd-channels&quot;: 2 } ] } }</span></p>
    <p><font face="monospace"><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">It would complain, that channels should be an <b>array</b> and not a string.</span></font></p>
    <p><font face="monospace"><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">So, that's the reason parsing was required in qtest too.</span></font></p>
    <p><font face="monospace"><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">I would be glad to hear if there are any ideas to convert <i>string -&gt; json object -&gt; add it inside qdict along with uri</i> ?</span><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
</span></font></p>
    <blockquote type="cite" cite="mid:87zfvr7xdn.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
  static void do_test_validate_uri_channel(MigrateCommon *args)
  {
      QTestState *from, *to;
      g_autofree char *connect_uri = NULL;
  
      if (test_migrate_start(&amp;from, &amp;to, args-&gt;listen_uri, &amp;args-&gt;start)) {
          return;
      }
  
      wait_for_serial(&quot;src_serial&quot;);
  
      if (args-&gt;result == MIG_TEST_QMP_ERROR) {
          migrate_qmp_fail(from, args-&gt;connect_uri, args-&gt;connect_channels, &quot;{}&quot;);
      } else {
          migrate_qmp(from, args-&gt;connect_uri, args-&gt;connect_channels, &quot;{}&quot;);
      }
  
      test_migrate_end(from, to, false);
  }

It's better to require test writers to pass in their own uri and channel
strings. Otherwise any new transport added will require people to modify
these conversion helpers.</pre>
    </blockquote>
    <font face="monospace">I agree with your point here. I was thinking
      to have a general but a hacky version of migrate_uri_parse() but
      that too seemed like a overkill. I don't have a better solution to
      this right now</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87zfvr7xdn.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Also, using the same string as the user would use in QMP helps with
development in general. One could refer to the tests to see how to
invoke the migration or experiment with the string in the tests during
development.</pre>
    </blockquote>
    <p>For examples, I think - enough examples with 'channel' argument
      are provided where 'migrate' QAPI is defined. users can directly
      copy the qmp command from there itself.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Het Gala<br>
    </p>
  </body>
</html>

--------------TnhExN8rApoMsLJLo2l6zhNR--

