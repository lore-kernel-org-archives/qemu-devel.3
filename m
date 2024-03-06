Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAADC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 12:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqog-0006ab-77; Wed, 06 Mar 2024 07:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhqoe-0006aL-Jc
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 07:56:12 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhqoa-0005ne-VZ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 07:56:12 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4260283n013405; Wed, 6 Mar 2024 04:56:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=577yT8pVyo7K
 zMQsQqqph/suOkedF2fbLfpVOYTRsw0=; b=YfJ/2ZzbgZKDi9M77MS8X8Ysa2El
 i/b5oDuE/VH29KUg72DD6Fx8Wg7Kg0FdQ/FdO+7DWFSmrSXuoa5qh4rIiUTua5so
 SgBD1giPMMboq0aI3dFRrplqOqMOo37FoaCSkmlZSlvJnio4i7IW+jPVfn0MBjRt
 9pwdo8tOh04aigZcOCT8ipA/OhEZ92HwGwv4xG0DeGjabIKB8jh6CkDrCpchV+8f
 x2Wd+fatlLX+o1UbmPRm+b7nI4qFYLstqG9dTwQLpSrFpb+4DVY3q+XY7Rcf0sNL
 fQImMx+hd8IgYok4jgpishRDm9bNeUJwr+x1blHuWfpnUtCnReFEV5ppHA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm0w98y0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 04:56:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn3+hNpKaZagdvHa+jRZO8e5J+PA8Wf+bWyqpMLiyJAYfroprodn8hWvoNXQ6l5l/RU/Aibb0ciNbDW+Evo8f38yHdSaJ5dj1+DtHPqceQo+orygMAZgtceYNzl4/0yuzlYObBBVAR0iVnwsCAc6ti6D45tIKpXDUe38y+Rrh7nUEEpb+jOR05PJQErF0cdVVMip3t7UMa1Op65QgyMylk3CesbV4vYqeplH4KMsJTDrBZZ9EvV2gmGbb8+UHEMo0H6HyUQVMhfaBs6ncio3dWzhCVNqfSwVjQCg3WrRFlH9B8MiSCh6APlvsQUwhWgO1WS8EtMHbQOCi7BwIG7LAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=577yT8pVyo7KzMQsQqqph/suOkedF2fbLfpVOYTRsw0=;
 b=YUc6b485cZF7nJc7qnjL8wZmMIu5mlgteXzNPp0RAmFqD5Y3PMElTlA3CKFAMEHoiUaHinGqHICxkj6bT3RJlSnPPkKLitXpZM9ZGSD4B//rGL2MA0PpENwptEqRmm65btvxGd4oRRsnWadKqfQNBrxBKerQTitGBxocOnR159tMaSh+fdhp91vNemuuHw9/GrCbIoWDQ6rDVe/LLaAjbNhuewpWg1gy+KuceiJKjgxTB/bIF29i1APCYuIr4Txwc5PqYcIbZ7rLHm111BpLaF0IZ4TBPLEvknkUHgAEhW8e5JYqNqyu8H8cvtNpSRWqDZlTo1GP/qXHKIr578cUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=577yT8pVyo7KzMQsQqqph/suOkedF2fbLfpVOYTRsw0=;
 b=JnQKR8EHYZDldZTeWblECLbfLuLvfTDb7uA4UjQ952/r/afHHDChzmFTrchnSgtBKv9jLWMFKL0JHpZKScW0BG7dm5xq6e8Je/xjQqgY+EFbTaxeQo8GbgqbVCyNNR6KJ/H5C+hBMUAQnmQMQiX4qDaZMpEP6VL08gMPxtk0qV/fw08GzD/gH09W5Yk+Z+IaJHBTTJgNhNBa0gWxsm5QzEblJYHrvIB9YesjL6Qw+Q2sLRuehPOaTkpdUXcYhOs/QBI2hpJ2VCnvg6n4qbuazfN/DVMi8ysoIoUxEMhsA1xVqBA20nPWrLkeadfV2qCJ1swSgSNcYD1qf8gN+c5Dzw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB9113.namprd02.prod.outlook.com (2603:10b6:610:146::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 12:56:01 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 12:56:01 +0000
Content-Type: multipart/alternative;
 boundary="------------QjxU9Ip3fTIau4HuZGZ0TtG3"
Message-ID: <ade5625f-d9a3-48a3-8605-ed008207bdfc@nutanix.com>
Date: Wed, 6 Mar 2024 18:25:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240306104958.39857-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240306104958.39857-1-het.gala@nutanix.com>
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 089ab1bb-1ee6-4fa6-ccca-08dc3ddcc63d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0sZMY61GSdKmama8E+zUKqFxRysPRGecVyorvFPZxEqmpt4MycnvpgJrgzd/tycPqHHh0JDU7KbVQS9v1zHmR5mR3UdoH8fEtC2pK6Q8K5A2QFf5NrmaKVrWJcVZhQHltzsULUywjqS7oDwuK9aVcRJQWs5mJ4B8CellII6Pju+kT32L6zKuuU//FZugLCzV2iE9CP9skPi6aYD0W0Ob939XheXwxL6j1VjlrqZwYAKmD1dEOtCoJnPpBmB1lxK+gNjGC05RhvwKMXeWddv2/zU4SKNvAhPXlOls6ZUOZ7sBymMYmEkI47Lzjru472J864E7e6hsUvv0wQ4HXasemGRfqf8HGVNc3pCgABaQ7np8mHyHs5r9F3A5OXbUd9oC21ZNLj7WH8KO7w1mdIqyPoRy6UP228ojHEMXTJYwJFzLinqCS4ooLxOTVCa5c9pEqG5H5/lNLENQyti6itv+cCHb8XyTQyqsZBrKb1FEEGo4CObjQFTj6tacRciCkT0J20Riag4r3VgEPf4M3uXAyz8mQytXnVmD+NPVFqXb4UukASTlGG4TB/iZgaKrgDYXYFWdsxaC3YKg3miI5PqIpOtVvP3W7JpoTBSN+nryg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGwxcVdHYzdua2RnZCtWT2tXNk1mY3NFOERRaTd2QTRLRnpham1Ua2w1Q1FQ?=
 =?utf-8?B?WWZMS3NrdWUxK1ZkSWFDNFhUUHROUDJlZDJrUmpsWndacWVHTjN4S0RWQTdW?=
 =?utf-8?B?bWM3Ly9Mcy93SWlwQUl5NW01WndEQlF6U2JOTXEwVHZNZkxXd3pXb084VUhE?=
 =?utf-8?B?eS84VklYSDl2em80WG9NOEtaTjlmN2xpeVdWNnI1MmRYazNlREk1YmJad2xm?=
 =?utf-8?B?dUJDaWdvN2FDT3prSklJS2lmZVRHOEEwLzA4d2NGQTdUMCtPbkZqdWZNK0Nm?=
 =?utf-8?B?UGxwQy84R01uYy81Umt6aVgyZWE4T1lpTlpkNC9BY1JVYUdwYnh1KzNyZTJE?=
 =?utf-8?B?dUNGTUJjRkdzM3dRUkowZ1ZKdUo5TTExejFmRkR0UGFYaDZCSENGMmFOWjEv?=
 =?utf-8?B?OHpMWml2UzdPWGFuK3RwSDJ5YkF2N3haVzE5ejRxWTJSbVlCR3Mzd2xqRVJB?=
 =?utf-8?B?cTdqTk1qYjNTV1loNVNHOUdwbENsT25DWVBFenNUUk93QXNqUlVLb2ovYXBV?=
 =?utf-8?B?VVZnTzl6V1BXazZSZ0x2S0Y3Vk9oMno5Q1pVL2FlbytsVWpHOUQ2Vm9XNW1r?=
 =?utf-8?B?eXhQdHJFcUFXRUMwZGVJZ3l4WVZyek95NWNaM01UMUw5eitRTXNoTTBPejVy?=
 =?utf-8?B?NW8yd2c3KzFHZmZQeHJqZFVUUmx2SncyQndzV3k0TjVqUG1YK0t3OHFFd0NM?=
 =?utf-8?B?TVEwRlhXT0VVV25CcVpqa1JGQmxHellHV0g0L0xwemZVK0hONXpWUEF0OVRV?=
 =?utf-8?B?SFJNT2ExUjEwTUM3c2xlTHVtUWw2eTFYNmlMcjk3ZnJJRlp4RWE0Q1h2Snhn?=
 =?utf-8?B?dmpCQ2NtUFBKdkdxTFBKVU9IUyt2WWlxSXhlQWM3YzE3UXBZR1daTW1GUWln?=
 =?utf-8?B?a1YzNjZ5eE9oanYvcExDQW50TlBSZUt5WVpua1FraDl6dGw1eS81SlRZVkdC?=
 =?utf-8?B?L3YwdjhzblYzQnFEMnRUeTZLZVZHbGdiK0wvQnU3NWROeVlVRUpQRzFKN1ZQ?=
 =?utf-8?B?YnIrMjJqQWZIa1pMQ1R4aVZKa0Vpc1RyN1g5SEhYcVhKbjRGbUwwUXE0VnpO?=
 =?utf-8?B?VXljcGNkT0p4V3drcXBqWjc2V00xcTZqb1JIRVN6RGl3bTJ4cHl5RFVoSTAy?=
 =?utf-8?B?a29rNXBaVGhRazlEdVE5QnI2ZjRtTlBhQm9IMmpXQzk3eDcyQ1VoWVdZZnYr?=
 =?utf-8?B?b2FLc3k0ZW1tMzIyUFR3ZVNpOUxjWTlkaDJ3eERxZWZyM2FUU1grSVhtRGs4?=
 =?utf-8?B?NEI0ekgzbURXZzN5dm82SFZNUW1RbHhLV1dSeTd3bTFLUE9kd0o0T05KeDdC?=
 =?utf-8?B?MHdhdUlzbytoK1FmMWg5c1NSaUM2UnU2NmN5Nm9rUDNpNGZ0Ny90b04yaFR5?=
 =?utf-8?B?VjI3UkFoajhaMzNJVjBpckwxc0dHUzJTSmIrZm5PVjhNZFp5UFhHN1YvK2RO?=
 =?utf-8?B?bGhnRFpObzNEQit6eDBMZldLQnJDMUk0RnlwTG5uNVh0ZHA3WDl1R1dvNkxG?=
 =?utf-8?B?clJ5emxMUm5hZHd2YWUzOURQRDdqVWVyeENraEFKU253ZHgxaFBRakc1Nkxr?=
 =?utf-8?B?bjlGVUNZaWx5YitJc01NdlRoSmF6OW9Fc0lzTGFQcWxFUVlaalV4UVhsTnlB?=
 =?utf-8?B?Uk93dERxaVBQb3BCNjB4dUxLMGFUVDBySmJabVl5NU1wQzc5c3hzR3U1dXQz?=
 =?utf-8?B?bFhzM3ZBMng4M3paMkc1YlBrc1d3c3JBOS94YVBNNmh6YTlUU3lmVzFUUmtx?=
 =?utf-8?B?TmFDTVlCRksvZEx2RVNPaEk5VmdadENzQU0zUTlHZjVkSWpFMFlzbEJROTFM?=
 =?utf-8?B?U0NkSFp3U3EwUitmWFdMWkZMVkNhUlF0NXFUTFFoUGJId092NDNUQmlmbzlr?=
 =?utf-8?B?cldZeVAyVy9FU0VmU0FhTHF3bnBiMk9CSGM0dnNtTTZWaGV2ZmtDbEhvckhM?=
 =?utf-8?B?SEppS0NSbnBPamFWSll6M0FPQ0oxK1FlNXFxeWtCNTYvY3hsdi9kYWsyQkRj?=
 =?utf-8?B?eHlseGJsWmFSeW1vT2hqZzRodzlzWi8vaVhDd1ltSEdISTEvbHl1M0JVTGdE?=
 =?utf-8?B?eEVUei84cVpiQkxQYTlKUkRoM1pEaFpXRjNySVJTRHd0OXQ3VFpnOG0wTE8v?=
 =?utf-8?Q?oG1y1FymSx0guNTbZ9Ir1hwrb?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089ab1bb-1ee6-4fa6-ccca-08dc3ddcc63d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:56:01.0969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urtKGGafvLhnCSVDohpnHZJ4qP3/EZUoJfTi9fMteRbOg8HyzbCfXf13w3JJIaLEJA5ydkYjnnULAqsonkL5UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9113
X-Proofpoint-GUID: dxwT7ey_fcV7q7dErm2hC4ip3HtIBi9T
X-Proofpoint-ORIG-GUID: dxwT7ey_fcV7q7dErm2hC4ip3HtIBi9T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

--------------QjxU9Ip3fTIau4HuZGZ0TtG3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/24 4:19 pm, Het Gala wrote:

Can also find the successful build here: 
https://gitlab.com/galahet/Qemu/-/pipelines/1201488612
> Het Gala (7):
>    Add 'to' object into migrate_qmp()
>    Replace connect_uri and move migrate_get_socket_address inside
>      migrate_qmp
>    Add channels parameter in migrate_qmp_fail
>    Add migrate_set_ports into migrate_qmp to change migration port number
>    Add channels parameter in migrate_qmp
>    Add multifd_tcp_plain test using list of channels instead of uri
>    Add negative tests to validate migration QAPIs
>
>   tests/qtest/migration-helpers.c | 109 +++++++++++++++++++-
>   tests/qtest/migration-helpers.h |  10 +-
>   tests/qtest/migration-test.c    | 176 ++++++++++++++++++--------------
>   3 files changed, 208 insertions(+), 87 deletions(-)
>
Regards,

Het Gala

--------------QjxU9Ip3fTIau4HuZGZ0TtG3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>On 06/03/24 4:19 pm, Het Gala wrote:</p>
    <blockquote type="cite" cite="mid:20240306104958.39857-1-het.gala@nutanix.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <font face="monospace">Can also find the successful build here:
      <a class="moz-txt-link-freetext" href="https://gitlab.com/galahet/Qemu/-/pipelines/1201488612">https://gitlab.com/galahet/Qemu/-/pipelines/1201488612</a></font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:20240306104958.39857-1-het.gala@nutanix.com">
      <pre class="moz-quote-pre" wrap="">Het Gala (7):
  Add 'to' object into migrate_qmp()
  Replace connect_uri and move migrate_get_socket_address inside
    migrate_qmp
  Add channels parameter in migrate_qmp_fail
  Add migrate_set_ports into migrate_qmp to change migration port number
  Add channels parameter in migrate_qmp
  Add multifd_tcp_plain test using list of channels instead of uri
  Add negative tests to validate migration QAPIs

 tests/qtest/migration-helpers.c | 109 +++++++++++++++++++-
 tests/qtest/migration-helpers.h |  10 +-
 tests/qtest/migration-test.c    | 176 ++++++++++++++++++--------------
 3 files changed, 208 insertions(+), 87 deletions(-)

</pre>
    </blockquote>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Het Gala</font><br>
    </p>
  </body>
</html>

--------------QjxU9Ip3fTIau4HuZGZ0TtG3--

