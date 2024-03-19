Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEDEC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgRg-0000M6-M5; Tue, 19 Mar 2024 16:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgRe-0000Lp-5C
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:52:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgRc-0004HJ-52
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:52:25 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JKPFPL025907; Tue, 19 Mar 2024 13:52:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=ymCrcu05IhNQTVdfPaGTKjGFsAyAr28MPJSt13Ncn
 ZQ=; b=tMVCq7KseYIpRl0sOYCR1zdD5WtAn8/TSTD+5t3PkvfXA9k/NpV9PKei0
 4ay3VQp+qHMdY9yWtKsmimy35HM3S2xdFlL7+0ctEO5Sy0vF+pmHBSPeeplMWnFd
 3ueenmi/9ovT4M6nTEpAWTVIuNWtM+dFtX/CTxovIJ6hXFLr7rVMdUhFOaAnz5TQ
 BctLOekDXxSZdTbryEFP6NqUPa/zDqEUmfywGmhyow8nEyPYh9Fk2Z9lyEaHHU7d
 LrfDlv6XbPJcka4k0UHe5s5+liH8MsAF+fEKjTQgLpfn+jr4t/eN0WddzrV4Hm0B
 wPyD8HXCmrB6n74+YbHkzrxuVvHRw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wyhqn01jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Mar 2024 13:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix6askuy+g1EeexJ6ma6bsjPBaSEwdm+nJpSaehFugkYLJ8SWtgs/PZ8AgvZJV9DGb2slZEUypTd+8UAR3CCuBwh06VaxtCioVoZMdCynQr5KkwXdWqBqumorzR3OXsn4VMTAq8wsL6KYHOibIkNT0KCzFpbfP6UEjQvRWq35HZNkV/IPcqZAMJLY6hXdmhXxP+itShsdRbXKlo4eU/TB+OozT1TkKRVcplD2BKnR5Hix97Npsd/LkuIViWuRBnRqS46y71k7TSwT9GPCGdThQcttZnEcc9CCDNpOytKJ4D5w6OBeEAgRiAxYO4pgT1/ZF1prYU/2j0+jcO+6MGWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymCrcu05IhNQTVdfPaGTKjGFsAyAr28MPJSt13NcnZQ=;
 b=mR6sbp10WnaMJ2x5l3WFt7ZRvFF5Zd/TXUtE/8Kus03AHfNsccumcm/8+tMXltJUG/3g/drSgbHhkkWo7xL5ZiMFm3gNu5mRS+ipkNuL2et8PQNssLC2YkShU5BYNeB9JWL6KnI8BKba7U/nfrB1sEGxdIQYpsoHKwtP3e0pVItw/CqQsb98HHz9qDjdS0umZ5NMANv9FoeU4HW4wRf2jn1xy+6plUeY2YluKpST2HKkqhuHpXgyFwTF0+BZFSv2N+YjY6Z7DwHsUZnEh+SMvNPM09yVwUDtv5KZqVdl1XCUQ1DDFh/1ahRbIlWV8gT6s8CftUcAsKzZ4TQBITsJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymCrcu05IhNQTVdfPaGTKjGFsAyAr28MPJSt13NcnZQ=;
 b=ZJGWbtSfCbebBghjJ0kQcWOfGyrztE7znyeS45YL4Kmpno5WJ51U0Lf97yHyP2QAzCp5YapiNwzRfHhKLKQ2gZXNtPhGekN0IGnhOXKj3+p3v8D6khrb3HL/z8ZNqJCNEq917P01Gwix6ioxMbI1J7tisiwSyQcw3SkRU1YnIIQ8XJ/YT6esTQc0AGtime4JjQHNaBltRIoRkf8E8aF9uUDBTpqoEJZyA1N/RCmMoX6W95vUn7782jC9xylUzhCyQQ6zJpFr7eQptOtkovjHbBSqsXwzsJxy2wFUnxcKaUejUXxUxCzddxJmRLabsRUiN9W77Z/eTbwZHdCbWGZk/A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6998.namprd02.prod.outlook.com (2603:10b6:610:88::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 20:52:19 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 20:52:19 +0000
Message-ID: <0bdca0e6-75fc-415d-a604-07c4c5e17651@nutanix.com>
Date: Wed, 20 Mar 2024 02:22:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/qtest/migration: Ignore if socket-address is
 missing to avoid crash below
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240319204840.211632-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240319204840.211632-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fd5c12-c579-455a-7f97-08dc48567779
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KP9kHX3AG+YNUsiCEeHCW61V3MVJzwbBEtp6sLeu2kCOw1MlJ75rBXCeM1LZypKVNxVdvbVJOkrNMENLYWWNAxPbZfTLdSjg2z30drQfQzjvHYCFty7MmsN9bRc3PgNu/D2Xo9+4x+ElhWJDI61JpHVebvD0BBYjwtMqHVWcABn8u5kthDi6STjXKp9RrnqFcwbEo5YG9+mahc5ApcfwicKqy4uunYvE66gWNmdcKDPqYO3NTXE/5VcGVsrqddz9GifZz+YWXmmzwbkWREBeZ4XeheBb0w8axmrhAmE4MajUOeCXKBZl7oyyHAjWkQEn3dgiC0LLXi51OSfym9b3L1/7KrzUUb+DF8kKLMiP25IZttgJf6qtEnDyvvlb4i5Jz59Cp8I5hBJAcgC14D5vu9GqgwZ+QPaqwJrz2YLF0NKnv+H1ccwW2uUXF+H12splvIArr4Qekp4N4lOjKCmipniOlcHwtFXGjVogXCaPG4mb8ojtgXN4171VSjnqhNsD582JnGi9CoAeL+ghL3SiHS3apY/EMKx6UhEWhD+TKKomlC24xMC/tgQxYRrh8Puz84QQmxtoPFVNIASwGJalksXIO04PVsHxLOnGKzJIpC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckYyQUF5M29OSk9OZ21XakRDOVFNN0dRYW1HZGdlSDhsdEdOQUx2cGtHQkVu?=
 =?utf-8?B?QWJLdXRIT0x6bDQxcUdkRFpTeHVMcmUrWWp2SnN3aGJoZTVkRGFYRUhpaGxk?=
 =?utf-8?B?MmpqMVp1eVBZa2tEK1hXeGpsbnc3VlBtY1RJQXlqYjcwdTg5dGhlT2JzTTRI?=
 =?utf-8?B?bkpjSzZMS21qekN5TFFjSFVSMWE3aGZNeEswcE1TckJmR2pkYkJhNnlQeUw5?=
 =?utf-8?B?aGpOdUsrMk1oN3FGNnMvN2puM1hMdCtFU3BxTStQNUZlUmpuSmFQUzZiUjhJ?=
 =?utf-8?B?NVRSZE9hUElJdjZNdDB0OTBuTFhmbnpZOHBTYkFYbDdxRzlITzNPdFdnZ040?=
 =?utf-8?B?NjRLWmhOc2hRTm05cFcydEVad3lMcHF1V3BVUVBuMlozR0tyVjkvcWpESWVs?=
 =?utf-8?B?aVlaZWxHQ2ZIVS9Pb1UxNjhXK2pRRDlGMXBtOTZZTEdkNXRWRHlVcmdWMXdV?=
 =?utf-8?B?cm52MDdNdU8yaDYyMDdGcVhUNHhLMGpzSzJQdXpaK0F2ZUhmaTQxaUYrZ1li?=
 =?utf-8?B?MlpuNC9tWFJFczd2UWxSSnM4NjNZU01rZGZ6bCt6OEpMZ3p6NU80SSswS004?=
 =?utf-8?B?K1E5T20yblBoL1EreWxMRHZGWVRLQ3NIK3lHSUFNTlQ4NENPV1RaTFhZZ0xk?=
 =?utf-8?B?cTQ5TEtqU1BvUk40UzdGejFBZVFad0pLMFVWb3VTcWoyU01KVzZZZ09obUN5?=
 =?utf-8?B?cmE0MCtoeUFTaVJaanFCczl6T0UrQU5MdjQwSC9pbFM5SHBsVUU5MUhSTjZC?=
 =?utf-8?B?ZmZoY2pzWWJMZE9pT3FXNGZqWTJjQVBna3ZiL09aTXRLSHYzRVBsRlQrWFp2?=
 =?utf-8?B?MXJKUVgzSyszcVAyRkJ5MC9LamUzNVZyWTJDamFYcGZyZkE5U0xHRGpjM21C?=
 =?utf-8?B?UzN3bytuTnFwczlwY3JXSGtpVVl1OWhaS2RCR29adFFFUWxKL3hmNk1HUnUw?=
 =?utf-8?B?bGpydFExdjJLWnpXSWJMVkwweGF5RW1qTVpwQXM3TTJFTE9xSlVySUZGOVFP?=
 =?utf-8?B?TnVhMFMxWUdQOG1oU0FHTFVQYm1OdjZNalNtT0R2QnFTakszdHJ1eURJQzIw?=
 =?utf-8?B?eEZUd2xvRjJjV2NNVnc3S0ErUVh2bnFXekIyQWIrUHFJRk9KQllmeHJRV2F3?=
 =?utf-8?B?TDdpOVM2RXlQSklVanh3R0FvZHloSHU0Q0U1cFRPWnVDUGViYzl5dURRR0xE?=
 =?utf-8?B?Q1hseURCb1Y2bTZveERaS2VkVEcvRmdnYkdyZ2tPWHBPenpTd0QwRWVrL3Bw?=
 =?utf-8?B?aEprL1pGN2pvc252YmVzWTZiTzJLRU5QWHhwbU9TQ1NuU29LNzlNVHFxd1Vz?=
 =?utf-8?B?dWpLWWlyVXhxSmxtQW9BZ3IwQTRtQzgxL0lnc2VYYzZRcjI2SzQ1T0dMOGNh?=
 =?utf-8?B?ajg5T0tzckoxV0FnV01SRVc1dm05TldHZXZ3aGhOcXlBVk4rZUd5UzgyVE5w?=
 =?utf-8?B?RnJENDIrN2ZWaGhGdWFOc0hlWFZoR2ozb3dhMERFaTBFRnJvV0xiQmsvSkZk?=
 =?utf-8?B?M2xnNTVTMGFQQnZHMWthMENNaHJUYXhDR3hGd3dwd1VXekJFU2o5ZDVmNmlq?=
 =?utf-8?B?eE84QWI1Y0t2UXdRbjRaTjZ3TTQrUEVVakF2YkxhUVo3NnJINzlhYjdUUHZa?=
 =?utf-8?B?eCtIcmlEWm43Ny92R1pNSkZaYlZoZHplTnhxaVVyRG1yWWZQTmp0UzZPdVdX?=
 =?utf-8?B?QXlyRVFoUTNVWVRCdFhCeG5HeGpqRnpVZGplQkNsQkJRMmZrQlp5MXZPRW4x?=
 =?utf-8?B?R1lkOEdpLzk4aFpRMzh4aFdlbEhtZ1FpWEgxQ3Fkd0ViUS9paElKZ1U3K3li?=
 =?utf-8?B?ZWwyT2NUVGxPejNNQmVCTHZEdXltSnpSajY4dzlsVE9LSHpoV29KbFp4Skx3?=
 =?utf-8?B?bHZzRGFYaVZnb3dKSjZIS3J1RDdQcTNPK1BGVDhaLzA2VmpaMm9LVlREeDBo?=
 =?utf-8?B?UXlZRC82YVcrcGlpVVZRdEppQzh0YUYzYUlINEs5MEJ3Qm9hS2ptcy9UNmxO?=
 =?utf-8?B?NUM3NGJWSmVURkg4ZGlibFBOWHRNMTBNRU0zL0RibGJZbjVYT3R0NW5wZ0t6?=
 =?utf-8?B?d25aY01HVzRmZzBjYThHUmk0eXNMSjlRRHJFRXlkaCsyeUpESGhLRzNNVklF?=
 =?utf-8?Q?Zivxdvj9HWxgdhkmEIuvWWJU2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fd5c12-c579-455a-7f97-08dc48567779
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:52:19.1583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmoU0eK/78uDHyLrGVGq1SoPS+iCq7zRhKWlZxQMUWDj/oa9tiPa33guPoguF4xoW27TxNqTzDoAFH0FBw7Qgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6998
X-Proofpoint-GUID: P7tpX6QD_D_BJObMTOG2brsA9RB9SXln
X-Proofpoint-ORIG-GUID: P7tpX6QD_D_BJObMTOG2brsA9RB9SXln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

FYI: This 2 patches are rebased on top of another 
(tests/qtest/migration: Add tests for introducing 'channels' argument in 
migrate QAPIs) series.
Can find the build for both the patches here: 
https://gitlab.com/galahet/Qemu/-/pipelines/1219841944

On 20/03/24 2:18 am, Het Gala wrote:
> 'object' can return NULL if there is no socket-address, such as with a
> file migration. Then the visitor code below fails and the test crashes.
>
> Ignore and return NULL when socket-address is missing in the reply so
> we don't break future tests that use a non-socket type.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>   tests/qtest/migration-helpers.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index b2a90469fb..fb7156f09a 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
>       QObject *object;
>   
>       rsp = migrate_query(who);
> +
> +    if (!qdict_haskey(rsp, "socket-address")) {
> +        return NULL;
> +    }
>       object = qdict_get(rsp, "socket-address");
>   
>       iv = qobject_input_visitor_new(object);
Regards,
Het Gala

