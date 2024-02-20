Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C90C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcV5q-0002Bg-Vo; Tue, 20 Feb 2024 13:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcV5p-0002BK-PZ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:43:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcV5k-0007TM-76
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:43:47 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41KAgAF9022091; Tue, 20 Feb 2024 10:43:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=r+hk81/aDBsdKsHwy/7quvPCxWEXRJd899yEfdrQz
 n8=; b=B5TbRc9yXNlScxRXqt1SypIZX0JzlMpiAVPFdq31w8MALHWobCcOpMKIH
 4hajzMwyR2Cuj0W60+mlBg8/hT3eExkisUPbCbAz83Iz16yoNKl1Mr4JjA1dw2eN
 lpuXDCR5TOdpGinh0G9VblDy1k7t0R+ZADutGnQeK7Hts1XaILHtIXDaPVZav2D4
 ZD9vBPdFy8ksME65sP9q3/48ydjmq0Cram9zGvIYmqUvqugUa8Ro9VnEfIRW0RjA
 sfoSy/lvd09We9KtunVf0RXb2pIQPGq6XFqi2A4vk+ZAOxSfH2YKIgMbE9sO1fP3
 PHpdZtTF4MW5H2ItSr0Nm+8yn0WvA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wausmetq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 10:43:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUKrxtpcPtDTHQ7Aqfww6IS5q5TBHbgZzLbqUtYB608BQ58emuKzeftwrRPXnV9lj0BBYLMZXxcrLDUFKu0u0cGBH/hE2owybfM92AqQwb6RdpVovGhsx30L2B9TdVR3xNSU161jBNDCPA4UBrjmCFeb9pE3xiGNVPxLUGDVsjIIMJB3gHqKSuihen4ORwrdP3GKOmS7YAv0soY/DFEqpsFqP0Adwv/R/wSr3ovm5jIdvgZN8WZinZdT/9GE5uSIAzxr/h7WbFbo4lAyMGCe53jU4YYOIBDE1IZQ3PwredsMDBFcjf/YKDzrrUMqDB5+s/zxe7XrxwNmM7UWS8jyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+hk81/aDBsdKsHwy/7quvPCxWEXRJd899yEfdrQzn8=;
 b=IsU+ANnlwGsGNRI5QZT6fCQiO9TRvF9VVTFb0DRUwmqgOdngjgMCktOAnKPai6WA41jcL60KqaDQuPhvDhTk0tEmEMtu6h2XF1RuYO29y4N/XRP1jMRkCB7niJRT3hko2rOWPJ+sXYc+BPQZdCcvwKmG0uZ68mTPj/0r2mC6oWowv6JwCpWsHYft54oNawlFcRolQ+SeSJ0Y1ZHplcW7UO0vLUE3i/3doOR7wwY2WA44CSVEmJb3ibtwfO9n/q0+hPjlQKhXJZJpGwKvfTo5+bbo9QNwn7lXBq7CvAnG3gmZwNfA33CcOGmZdtLow667pIpLMxFFTbVs1JD2Vx+mAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+hk81/aDBsdKsHwy/7quvPCxWEXRJd899yEfdrQzn8=;
 b=Ipq7m9XkKbEMoEP1lUCzzU6iRcaQf3JYpJMv1GjoAtKlO0PoYIjBNyk+u09rxiV2nttpUZ+1dQQ6A24u2Njz3LU/AoEfP5RJWJrsoddRR9jqK7t9lKQmhkPCeKWbDmgEc4XBT4sDQFP+Q+mF1CAFN154BgKm0dM/QibRTtgVHLb2Yxcf5Dkf0Zq9BpgBTkl3jeKLOW0V4kE5cgqcq6w8ZDaWxSzPi+w1vVT0NbjIGEr7mlV7GiA42yRr7rWvzmgIrFdsDJgcqxXjgs1htGpvLj2iulL33EDOCoFOM00iAHY5nbfBii45EEIPn2YN9KXiaGH1VFg/dGNgBTtdATT1yw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6518.namprd02.prod.outlook.com (2603:10b6:a03:1d6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 18:43:39 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:43:39 +0000
Message-ID: <642fc44c-80d0-485f-91db-802db42a4bcd@nutanix.com>
Date: Wed, 21 Feb 2024 00:13:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] qtest: migration: Introduce 'connect_channels' in
 MigrateCommon struct
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 farosas@suse.de
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-3-het.gala@nutanix.com> <ZdRBCYIOiOV39i2x@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZdRBCYIOiOV39i2x@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 485a08ea-8e83-4e5f-87bc-08dc3243da94
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJys6MjCRhS/VsOuURQI34RfngxSY5xgbbDzg4i/yMVZRUaZBg20psOLxAz4D1qXNTUY1QeyLc9Bu8VR61Xb1dj4sTRXPnvWeTJMbsYNch7j2q8ZSfCJaRbjzRzUlbRzDGMtdhVG8YX4+RnZDEYfvaFvPUTdkeiehTTGloMDf3DdWRSMC0Ka2oMjMe4CfqVoHte2Yt60Z3JFzJCl7tQdE0Di4c39+R6f06Mx7s5NtoTa8HUc4XLqFO+UVhug+VB4cevyTbaZBmT/UyPlCLAqM7cQtSRF8pSnZXB1fSMUkBRETPKfJNVimCuYntoHZ+/+gZi6hZGVUHoi7ksfHNKMN/MRg/HCzKW62Cv2DHUa5haozEbt4inwT1n61wqrIs5ZXdQzxXbD888+RXTSQFqhC6+ZJ441mqUQ/bkCl2D+DL7t30DYXo9TdNsZnZjLibwPOsJ0ghDP498ONJhaNVNzTCjjtEAogPk9Bpg/RlCsbYl/5MKwwu7QQk8OOPASgxZS/KRSBfceAhyc3hf7N7NE9VFt4Xs4NlX2b+WH+GatoL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlUxdDNtUWZMTG9jKytEdHBHR3Bxa0FZVTIwcEJFKzFmRDZjaEhLUmY0VkVX?=
 =?utf-8?B?bHlkV0VNZHBFWndjRXdYakVmL0VyT3dZbGl0ak9QUTI0NUhNUHFiQUlyaEQ3?=
 =?utf-8?B?NElCY0hWZzUwclo2N084TVhEZDByQUpIZGh4ckhlamZkR3lPU3lxd0tFMWZk?=
 =?utf-8?B?SzRjR0VHb2RKTlZmQXpUSURRVk5PR2QvdEFqcnhQVU5ya3Y0TkdvbnNYMGdy?=
 =?utf-8?B?TWxOYTE3QXdTYVhPN0pyY3IzcjMxQ3crT1BiaXh6M21od1krRHREQWsraGFK?=
 =?utf-8?B?Y01yN1hrSSsvNUUydm9BV2NYRG1WbHJINDBjc1JIMFdzTjgvKzBCRjVLSStr?=
 =?utf-8?B?b3JHSlZSajUzRi82YWd3b0VRblNZR3cxOG9JZUZ0MzZSZm8vWXVsTVU3cWtx?=
 =?utf-8?B?RURjOFJyQUhtWEtTVWJoV0p3Mm5MdkExOUk5OGVnMklEem81YzV0aVkxeWxk?=
 =?utf-8?B?c3c5VGl5akVQenN5UldOcmdraE8zRVhjNmFnWnBMZ0JjdUROWVV3YjE0U01P?=
 =?utf-8?B?UkphdjZ0RHhqdTF4TUFpNEV4VGE5K0Uxc3phZSt2M01KYmNtQ1ZtTzlSWFNw?=
 =?utf-8?B?eHU0Zm9EMUN0VW5FZXprWUJFSFUzV1pBb3RPMFFXUXp2c1FSWkJXSkpNNFZC?=
 =?utf-8?B?MUQ5WjAzWWQ5MGJWL2pnZTd2d3RDLzZTbjlYV2s3UUlBSEVZNFJOUFRRbVhh?=
 =?utf-8?B?bW1jZ04yWDRqTEpxY0NpOWRTcU1NK3RuN3lIQ0VkRmxhSEhsRnJZL0pYd3BP?=
 =?utf-8?B?RWlPNlhUbjJwZTFXbTlWWTduUTRucEZoeWd0OE5VWGVSUmdBMUJ2MFFmcmZq?=
 =?utf-8?B?elZKd3ZSSHR0MzBIYzFKbzAwYXpUVTlJY1pyRmN2YW53V1BVZ09mZXJtT21p?=
 =?utf-8?B?WkVaSGM5UEMvYS9sZzlFY0k2c05yc00vNEovcmh1WVFZK212d3dJaldReGFX?=
 =?utf-8?B?aHU2N0x0SzBZN1VpdldjS1g2a2ZKOHJkbU0vdEpCU1ZObTROWGJjQWVnUUlZ?=
 =?utf-8?B?MEgwVlk2MkpEOHlZZndJTkVhL2lEYkE5UE9OR2srNmNIS0NDc0YzQStGNzkr?=
 =?utf-8?B?QkJPSndWcm4rdWtaMFl2TWMwL2lkWUhPSFdWYXNOM3doUlBUM1I2SFp4NEE4?=
 =?utf-8?B?UkNJRjR0SVJobmEyY2NoUm9waTIwUU91NVlhY2ZIM2lLaWxiMVhtaWlrMEh1?=
 =?utf-8?B?dmc3c3RPakc3NkwwTHplZjFYZU91VVltOUxDRU1EaWdrc1RkQnZ4KzB3QWhO?=
 =?utf-8?B?dlNLRTF3ZGttS3FnUEVyNFdtdjMzditSSzJ1ZUJnZktlSHBEeThmVW81akhN?=
 =?utf-8?B?bHMyS2JPSnkrZ2cyRnlXeXFXbTBHU3JMZi9qMmZmNTJ6WUF4aEJ5VXZOZEFN?=
 =?utf-8?B?K0FzVkk2a2hxR1NTdVV0K1FqeTI1NTZSVkZUNXhrOW1mSHpPbXlKL1ZsbE44?=
 =?utf-8?B?WXJ1b2xwUXFuUUZQT29DbzJMcnF6SmdMUzRQeW9wWGlkdUZnYzN1NU85RkFX?=
 =?utf-8?B?Zk1hSi8xVlJmRXNheE1rRHh4bWZ4eDhGZmxRVFB1ZzZnZm0vVXMxcnZndXh1?=
 =?utf-8?B?ZkhGV3A0SDNEVE53WlcyOWRoTDFScjk5QVdQampDSzYrSit6RmNZNytueGN1?=
 =?utf-8?B?Z01GM1AzUGt0ZmJKRzRHQm9aNnRZQk5RS05lZFROb0VrYnBXY1FlWFZDc1l3?=
 =?utf-8?B?K3VvOWJzYWRlT25OUXdSV2pwRXdSM1c0aEpaK3pHd1p3cjRzWkc4RjRyZkFq?=
 =?utf-8?B?RExERUErTnhudXVkaEVxaW56d3haN3RIM0V0Z0xXY2JpMDhUTFU0TXZINXc5?=
 =?utf-8?B?RkRQRnVSeGRYTlJ5OWJwVGoxSFBycTRwaEdOR1FmK1JuYnVDS2pzaWd6S00w?=
 =?utf-8?B?TmtVQ3lPdGs3VmpKeVM5amRqaGdRYUpQblZDQnZkdHhzQUZ1RHNlcHpEcEdF?=
 =?utf-8?B?ZEozWXdzRW9tcWIraTBLSHVpMW5hNHZocjVYN1I2QStPWks3MEdRUlZNWEFq?=
 =?utf-8?B?Ym5YWVg2eDVvUzhGVEpqdys3ODdScTZmS2NHdlhQSksxVDZ5dVZjcVhaRXB4?=
 =?utf-8?B?SnIveDFrNHU2YTREcmpBQ2hVclJMbGttaGZnVnhUNUluSytSb3IwNEVYNXlr?=
 =?utf-8?Q?EUQpAIyvewNW4YSoP4U4Egb1O?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485a08ea-8e83-4e5f-87bc-08dc3243da94
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:43:39.4446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+MvYCjGHnSZpD5dEJynDC7cJkQXHa/WirgzAOGBVQr2Jd6DUSeJzSBeAmPkWoVVWvNgVuyHcSwkrYPDwj2xwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6518
X-Proofpoint-GUID: QrVOT1waz4gjZgCVr2vNwnOd7QBSLhNk
X-Proofpoint-ORIG-GUID: QrVOT1waz4gjZgCVr2vNwnOd7QBSLhNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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


On 20/02/24 11:34 am, Peter Xu wrote:
> On Fri, Feb 16, 2024 at 09:06:23AM +0000, Het Gala wrote:
>> migration QAPIs can now work with either 'channels' or 'uri' as their
>> argument.
>>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   tests/qtest/migration-test.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index e7f2719dcf..0bc69b1943 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -704,6 +704,13 @@ typedef struct {
>>        */
>>       const char *connect_uri;
>>   
>> +    /*
>> +     * Optional: list of migration stream channels, each connected
>> +     * to a dst QEMU. It can be used instead of URI to carry out
>> +     * the same task as listen_uri or connect_uri.
>> +     */
>> +    MigrationChannelList *connect_channels;
>> +
>>       /* Optional: callback to run at start to set migration parameters */
>>       TestMigrateStartHook start_hook;
>>       /* Optional: callback to run at finish to cleanup */
> Please squash this patch into the follow up patch that uses it.  Thanks,

Yes sure.

I am also planning to convert this field into a bool (just say whether 
connect_channels would be present or not). It would prove useful for 
positive cases actually where only channel is being used, because if I 
convert them before hand itself port is 0 but kernel converts port 0 and 
gives a random port number for migration. And positive tests fail there.

Will be more clear when I post the v2 patchset. Let me know, if it does 
not sound right then.

Regards,

Het Gala


