Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74AC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 15:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsuh-0002sb-V9; Wed, 06 Mar 2024 10:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhsuf-0002sD-M6
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:10:33 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhsud-0005t1-IA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:10:33 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4269l16O014838; Wed, 6 Mar 2024 07:10:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=/5Noyzkx3rHg
 dSTupfgdSsrqtOAUrgOi6IuRFMgarKA=; b=Q+bcXz/0jpSQguEnPCazR+URCiSV
 CbvtujpE6LHEaP4+DWn8xUdVfPqGhLNCfigJGdcROQBRoRXrc0H4ZWCgaTXwDUhQ
 D3cvkVE04dtza0xifg1s497b2tx0Alh9plGAH1CDV/rsBWNkjYhT2usNFZnOhFVv
 Imy6J6+0K0uGxgvOnbd9+22u2oPpxrF4RJKvxa5J9YbJySJax6CdIs3/sfthNAAo
 P8SFstJtP3+K8K2ect62XH+FqfeTqZ+YUpOxKOh4e7ZmZ0s2iGbwEORqKlE/okft
 HzG8ZS6wwRAWI7PorCLybURiyjOxx7zBvZ+qaB1XtVM2IvtVZLSzyDrjZQ==
Received: from nam06-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam06on0051.outbound.protection.outlook.com [104.47.53.51])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm4ag8wj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 07:10:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At4W8VoptlX8hIsRjkWD77PDjtCSKLkUkqM0XTaxXLXCyRwXQZblELGGgJhE2n3m8GXdJtvV6f3kHMyGz1FKRqPO+bdpfwXevAszxlRyLfK/vjdQaQVFVKHvgPcj+epXXlGskjoISfnRJtkmlKMRtlvGthbXOWkabd0msd972yC+Vr+Meq9kQOQxl+q4E7N0BtMzX61jdmb8T+uxUdKIIrAI6nMsQq9tt+eOkaVMR0L1qJIvJ7KxuvRs/GCagg5G+Bu6G0EQlPgFRP/F8sqi9hbhDH4NQSG3TX1sQrpSeFMmoPGS/mYeGca7DhEn6bGYfkd3BIXVN0uhBUvKWQ/W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5Noyzkx3rHgdSTupfgdSsrqtOAUrgOi6IuRFMgarKA=;
 b=L2LwFuupndT3zqQeEewYeufMRdyylr7Qbd0HvjxW/lA1212fy0sU8DaCfHrUjeV3OoK3tkdBbIxZHskj9mhkh3/752WTketQx/3TRJEXF8RPntzQlkPoHgd2oCYs6oivvVFueDPypKDb8Bn6Of/x6AiXlSTvBPmCH572IE+6gxFJolvhR72kJh8VLUVn5ngllxGvhhq42cCQL8eaneFPHwMixpNgxaI92GCLTVFv6wJGidggMKdmKsGwg+1dH3z+t9fTO6D+7kuv2nOPmEVxukPSkQatrHiS3XXKhHP7EfIWRl3csxqs11RYvWJk0yJVEvEg5ylSRqGLvvbs1edcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5Noyzkx3rHgdSTupfgdSsrqtOAUrgOi6IuRFMgarKA=;
 b=eyZU7Vj4ZHueUABRGKA0xVWuGhsriFEU7E5Mw9+IqUnKpZvnfdn+DxwEh1EqgXD/jwHGFbE57rs5TrxbsGwmcN4NO+o65gxhBK4dz4a380ZpVpLS50KUgRkTAxszatE37J5JETJZlr7+L7iD2tdyP79gYB3kgkRBnkPIpMxib7Vd5wvLlqhI6qcn4S881vJC/S+g6JYEM/D6Uc36cwQtrv1QWtK1BFhkCyW7VtPBGwB8IJFW/UnBPikHKlzS06MQvorIWw6Zy+7j1YoXFbIa5CEGyNPfRtitOiAQB1jz73Ab80KIS+m65gokFKUS758mgSlbMKuuM3BJE9xJMsKuSg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MW1PEPF0000E7E8.namprd02.prod.outlook.com (2603:10b6:329:400::b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Wed, 6 Mar
 2024 15:10:26 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 15:10:26 +0000
Content-Type: multipart/alternative;
 boundary="------------lUZkLNHvkOaF0B2FbFukvTjA"
Message-ID: <dc5a6a31-183e-4753-ac92-8e4537c0f641@nutanix.com>
Date: Wed, 6 Mar 2024 20:40:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] Add channels parameter in migrate_qmp_fail
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-4-het.gala@nutanix.com> <87jzmfs9tq.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87jzmfs9tq.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::15) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MW1PEPF0000E7E8:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a40f2f-c2fc-4539-5cd4-08dc3def8d6b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7a/4uosZ/0nt/e9m1LK/teLBSzK2ETLGyMcQq+yeI0v2H3CJ7LYSQvJHyLvgu9nQvGpuraMG1UalmwUkP0rx1nyX1SmGkcnLhiX5gqfE0BbezBQigz7jd7XAXWyKXZJewZQZ6NuoRVbd4cgMnzgnS0YmBpBLQbH8miYTdi/Fb5FEfJD61m/UjTqB1munzmw1HzHOhzMF6zUG46zlQXUecm5wfEkWA1YusHntnVSMu6FEe7pelvdHT7/M4JluIMXYCXqkwoRUkm5tCOwBBWMw47LP4WuWlwIRhgZEX26gbMSXaME6jeUp/Ac8aEKM4V1adcKKHQEO7bPYckGZIyTlH5x3uv82MYkYbUBnNrNvalt4xQc89RkhXfglfrQ7YnZFp4QA9/iXmCJS+8bhlRPBJ3+klJ7fMkCCUPNfxkyO2YNNVUSgN3CTDG9XJiREBCr4YQ1N5T2VrKBq8fMx9HemyKciNEULH4FblexeZc0lMk3De9/05nJ1I8oG4GjFgShumF4d0KqsxfoBIDVlsVGf4hBFSaR/kShf8Dh3P4npEvGIqJzQ5qMP7PGwYRAmHxM8EPs0S9cnAOzwK9CWXvtHEYIgq+SWaY6aLptTWN0tGZh9Wx8pZHxJ3maG6OUgaRZjdiAd4YAelpHDkYMCPFw7C/UZvIJQmVjnW4g3ohmK+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdJQW5CWkRYRUo1TXJmRGUreWhzRGp3NjFWeENva0pyQWI0aXdKWHREbWE2?=
 =?utf-8?B?UGsya0ZTZ1hLUzFhZUdIQURrQmF1a21HaHpGTHJRbHgyZVc0MlVVNWJxLzl6?=
 =?utf-8?B?dGFCWlRFZHZzeUozYk1taDJSRE9NZG1FWmo1dkVBV2NPUnUwNm5XSmltWXpH?=
 =?utf-8?B?V2RjNTdLYTkyM1B0TTkvYUwrVkVZUU9yWXV4d2tTeFhsY1RCTkwzeTFIM1dI?=
 =?utf-8?B?UzZkOTQ5NDlWdkNlaDNlMFNDL0U5YlA4T1E3QUhoczFTMk1xdjNObGhOdVJD?=
 =?utf-8?B?MTBCMC9KVkdJVHJKcGZYTzhrS1RaQ3JuNTIzRG9kTUY0ck1mcUMyejNzamU1?=
 =?utf-8?B?Vk9BZkIxZDlJd0xXOTVGY21QNTZNa1hNbFZUdGtKMWFuMHo5blZNZU8wRk5w?=
 =?utf-8?B?MXhMY1F6WGhoWnVLRk9RWVJ1T1BZUkpOUkxUbWsyZE5ob2Vjd1RRRDVCaTE4?=
 =?utf-8?B?TVF2aG1ZNDl3THliWFFveitNQlU4QTU1ZnJvOEQzZkd6VGVLWTcvT1hGVFZP?=
 =?utf-8?B?ak9rYUh3NDFhNFAvZmErQjhPTC9LR3A4ZDZ6TzFqRndVaVhYQ2ZWem9UL1BR?=
 =?utf-8?B?TklweE1ORGFWVDFuc0FyV1R5a0FOSG4wQnpXOFU3aEtLS3VZYjhMZFRnWUFH?=
 =?utf-8?B?Z0tZVlplZWM2NGorYTRpSnA3RFdydnZnZlpPdUljUUpDbzdSYndFWHR2VkJ6?=
 =?utf-8?B?ZDVJc3d5TXpjVG00N3hmTENFdVJYRjQ3WDFJc2RXNmtEZ1F1dldqZlpTVkw1?=
 =?utf-8?B?cmpSeHRoSUdvSGJTcXVzVGluN1VKZk9MNVQrUUVzRDFjOWVvVWlyaldvWXY3?=
 =?utf-8?B?U0NpTjRBcGd5cUZNSW1RaWhpUDNnSjhPL09xR3VwZEZkSU92YnFLaDJ1bitS?=
 =?utf-8?B?ZWMrWEpLbnlRNWkxSHpzdTVReWJNemx3ZkIvOS9HazNvbWh1V2c3VURIOUVi?=
 =?utf-8?B?WFR6QTRIcWRZYUY1MW9sWnNUVndrM1dTdE5qRE8zekJHRzNmcVUwTmRMYVFu?=
 =?utf-8?B?NG9WcmpZUjFQMnVBTUd6d01LK2RoRm9GblZGMVIyQWRJZFJkYWtTbUdyRU9x?=
 =?utf-8?B?VG1rN21mYjI4bWVpZkV6bkZUK21OTnVZKzVyQVhsVTVXT0poQ01QcjBqZ1Jn?=
 =?utf-8?B?RlJFR1luUVhRK3MxMUNQaE1NV093S1lTbm42VVpBUDVsQ08vUWsvR28vODk5?=
 =?utf-8?B?YzFJYTRwSnJrVEZVWG0wbHZCVGl4TkJhZVJQY2ZjWVNUcEFmSzNMc2xjL3dl?=
 =?utf-8?B?eE42blZCQmdGOXM0ZzlCSHVKYXl2T3Nyd0h3OVlIbFRELzU2S1ZPZzlpSndt?=
 =?utf-8?B?N2RLQWlHeVdvQzdlY2hZUEdhWFhCR2I0SUoyLzUyOFRwZ1lNT1NVYnVlbWhR?=
 =?utf-8?B?N0g2MHF4WmZqZUdZK25WcTVjOEk3WWZMcjZSTFYrWjJLMVBoRWhGTnF0ZzdU?=
 =?utf-8?B?djFtWFBlZE5IcE0vTGF1RW1iS2dyQ0toNkZyazl2UWZXTm1oa1Z0V01HZ1Fv?=
 =?utf-8?B?dk1kRlQxSGYvRlFXcDlOVjEwd1NaMzJqR01JeVFTVzJrTkVONWlkUkpiM1lJ?=
 =?utf-8?B?TzEzUEJ1ak15MFpxVjE3L1FOK3UwR3h1cGVURHdyWkpYMEdoQmNheWx3dTJv?=
 =?utf-8?B?NXBJVEp5Y2RMbUtlK01YbWVwUEx5bE16MEJLTGFrV1VhSlo2cmpGUS96M3lo?=
 =?utf-8?B?QUI5MTdRNXZldHFjQThGdXl0RDJ5amJlSFNjZTlTcGNzaVhMMkkwd25zeHQ0?=
 =?utf-8?B?S0x3V1ZUM3dLeWpnMXY2Nkt6V0luU0M1QjJVRCszczNwNkJBb0xEam5RVElT?=
 =?utf-8?B?b01qYXNFTGtrTmNzVzJxdTBJVUdMaXpIL1BtVXY2U2hkOVR2cFZaUEV0Szk5?=
 =?utf-8?B?akdWWWt6UkZYSjc0b1V0RDlVbUVYbEVJY2hYMCtaRUJ1bTZNUURiMTdQdnpn?=
 =?utf-8?B?aitXN1cwRHlCd01hMmtXWUh4OGhoM2w0SmZsYjBWdzBPdlkyYTFyTzlpN1lU?=
 =?utf-8?B?TG12Y0hvajhueDJhZVZpd2NJVzhjMU5pV3BXZzdGMlhKUEg2RlYvUzlQRHV0?=
 =?utf-8?B?TDBNSXM0WkVacEYzOStzRUQ4VVVIWFhLWTFVbzRla1FhemxBUXZkUVRsb2xL?=
 =?utf-8?B?NXBITFY1R0VicVY1dG9TVTdGL3Zta3ZqNSt0SWlqWUtxKzFTem56UnR6Y3Z4?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a40f2f-c2fc-4539-5cd4-08dc3def8d6b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:10:26.1919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mSZM7gFbwTyKn67+CeAC7UclG1QAsi01hEBh7TH8SS/+BGTIiacANtYLhcoUU61r56PtW5A9bxJD/oDRBnRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW1PEPF0000E7E8
X-Proofpoint-ORIG-GUID: ca3tM4_G8kSTYQTgAg7aFvTzpZK3HHsg
X-Proofpoint-GUID: ca3tM4_G8kSTYQTgAg7aFvTzpZK3HHsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

--------------lUZkLNHvkOaF0B2FbFukvTjA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/03/24 8:10 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Alter migrate_qmp_fail() to allow both uri and channels
>> independently. For channels, convert string to a Dict.
>> No dealing with migrate_get_socket_address() here because
>> we will fail before starting the migration anyway.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>> ---
>>   tests/qtest/migration-helpers.c | 15 +++++++++++++--
>>   tests/qtest/migration-helpers.h |  5 +++--
>>   tests/qtest/migration-test.c    |  4 ++--
>>   3 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 9af3c7d4d5..478c1f259b 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -92,17 +92,28 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>>       return false;
>>   }
>>   
>> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
>> +void migrate_qmp_fail(QTestState *who, const char *uri,
>> +                      const char *channels, const char *fmt, ...)
>>   {
>>       va_list ap;
>>       QDict *args, *err;
>> +    Error *error_abort = NULL;
> The error_abort needs to be the one defined in error.c. Just remove this
> line.
Ack.


Regards

Het Gala

--------------lUZkLNHvkOaF0B2FbFukvTjA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06/03/24 8:10 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87jzmfs9tq.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Alter migrate_qmp_fail() to allow both uri and channels
independently. For channels, convert string to a Dict.
No dealing with migrate_get_socket_address() here because
we will fail before starting the migration anyway.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
 tests/qtest/migration-helpers.c | 15 +++++++++++++--
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-test.c    |  4 ++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 9af3c7d4d5..478c1f259b 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -92,17 +92,28 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
+    Error *error_abort = NULL;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The error_abort needs to be the one defined in error.c. Just remove this
line.</pre>
    </blockquote>
    <font face="monospace">Ack.</font><span style="white-space: pre-wrap">
</span>
    <p><font face="monospace"><br>
      </font></p>
    <p><font face="monospace">Regards</font></p>
    <p><font face="monospace">Het Gala<br>
      </font></p>
  </body>
</html>

--------------lUZkLNHvkOaF0B2FbFukvTjA--

