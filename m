Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BE2C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 04:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSUxW-00019D-H1; Tue, 23 Jan 2024 23:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rSUxV-00018h-0U
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 23:33:53 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rSUxT-000648-71
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 23:33:52 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40NKQwJV005397; Tue, 23 Jan 2024 20:33:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=jtWCxOTlyusl
 XrpnZj67kvCUQTrIq5LkonUei2XVaac=; b=XW9YhjuABgRWASFyVQM+WsPYToG5
 mf8FURBPXKNK5f8/M5ahvkhfcgQVu6OyzgcvMlC9l7cRR8JmFJOBTU/CnV3pq15S
 dr/9m35einAAMbww3hbAPCwXen5AOZRwDKG06dGTip+SE5MVZQ1Uu/cfMfQvtoKP
 OFPSf65I2TaQZ3h5cPOuwrGywTlTN1G1KN1ANlMSHHF38T1zviGtaapPC71JjBt0
 e23xtzbo1CJjmGyEjy+2FZwtemlObbZpJTpWMaKo7kfmR7mm77RYjA144eL/SJ2/
 pKJNQ3Jr25VaE2hfcp+Jo/Ap9oY1LTDCiWnVu5npeYlny4FwUdb2cQIJBA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3vtmgg8n7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 20:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAn9SXvdvScxwPmvgTeeOXnz4yDalidhYHIwYO6XGJgLWaFsSrHPh/QoJaR00Zk/5abit2qLWJr721MZRGfeyhHNta9l8RiWwQMbVWXyY70y17nIbd0ZHgDdRn7HBSmjapSMqa9zyeHl8mNKmOhaaQ8RRW4o6IKVEjOhQfxrBgN1CceiS8q4uG+LTXKFkCQeBUuGifVjcdgQT3Wr0EWx/XWUGTLkNZiZ/99nKlurn07QPe/w7mCvN2zVAxqtjHWTttzQiFDUoJ9qkr/9rKAuna/ZrwWBhu1GNmGdqbo+xDbM9Zv3dR58f13iUV8qyUlCIOug+Lj8FKhc9InAFIPTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtWCxOTlyuslXrpnZj67kvCUQTrIq5LkonUei2XVaac=;
 b=Q2gL9fER/f8m4hcCRG8M7dLMjAVEzlejE5N322IBDurUXgT4//8lUFuMKHJ/6EhUaxF2J2eJuQQNqn76t6A34rD8S+C/SMKpRS3+7c4lIvmXO/Fy2ZDOntKvYm1vZdv9EqHfmrs6cZe6xoOSsodOM/UnUMszjARRkcGZgw3ffHJAsC7wg0fLDVSFWkNFv/9kT01jh5oBj3eYOnaYtm8ma69+uhTSVmgYnzNeJcTYL870t+8oQb2U2IPbeB7nzcyIeymv2buG5rpIC1Di5w2jLkaqIEQ4SbrBhNRdo/Kk9mGj/3xRm/G6AV5Gn9EeEPo40kAE3JONeZSdnT0W6+K6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtWCxOTlyuslXrpnZj67kvCUQTrIq5LkonUei2XVaac=;
 b=G898FcvuFhrtc+KZ5HJ513zMGvda0KpxSFPpb+xY0srQMzH3Ta9/sl7VQdW+JBVdAgMkus5S/fG1TQH3HJ1En46SDMFfnHkex3q6n19smsXa70LPLEnOE9g+Twvj1u3tp0xJ8d5ZQ1pkKatclRg/VBvjYxxzRAhTMtJ0t8fRK2etS9g5oVCnqT0rqm/VA32l5z5it3NgURfvMzzz6oumI42VsLoIUH9YkdUWq/Rm8YtX0h6LOs63ivOQpuaR/uhFVZKpHVACvnZOcRN0ERLZTcwBXLQRcbpXaUeCZoQCp/CX6xXv5Oidr9JPvLWVgPh9gnhnkW5VNHS+UftJkXpUnA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA0PR02MB7417.namprd02.prod.outlook.com (2603:10b6:806:ec::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 04:33:45 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 04:33:45 +0000
Content-Type: multipart/alternative;
 boundary="------------zsOi0iiyfHI9KQ081VoF9CTY"
Message-ID: <5fa6f674-a08f-45e7-a89f-028d91c6b8f9@nutanix.com>
Date: Wed, 24 Jan 2024 10:03:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, armbru@redhat.com
References: <20240123064219.40514-1-het.gala@nutanix.com>
 <Za93I-50U745B27C@redhat.com> <ZbBrN-V8goSJxEst@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZbBrN-V8goSJxEst@x1n>
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA0PR02MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: d1006525-a1a2-4b3d-6476-08dc1c95a6d5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGupVoHXx88eIhTa/6KfHFRju4nIw8j/55PWGFNc1IGWQ/lDcoLyT3l6mRc10c7jFzLxGMmr4fZ4zO89UorA9dBjHoMsGeNVAVaoMfTpLzkZ7UopWRzLtXh6+uZZhV4tiR+onEar+Qt5I5p6I7EMoctRWxTN0JkmAiQ1UFcNXYGgum5ZNQITP9NufFmSLBMKv+KeoRZMiCZFIRcSIFoMqJpPkVTGfVjvlJnUDjbMACiDZduN37+vwu24F2hK0B+c1Mcz18t0gB1DGXPOT0Lo6pGCUte362GkYe94BY9aKb0WebdPf+ljioWkP6xRq83Pp+DU2m8yMGpRE1n5Bkob8doE/Uh5Zd/stffbAnUj3tbdH3itJwiuhUxMybL6FjGUPdYJTlV9+dP+Q9bgdcmG4mODqzg+gehc0M34Y8z7sdMjSxUK2CYmPnmrowE+L9UV22+OLWlXlfpUQ6A4Ds7Nq07IPH8szfAwVYkDvtK95GI2pUmALCqRrieE2R9KQ9up2wwyHMV+JE1uZuC2sd1MZqr+Bvy7rlzUg301sjWu0qmXAARATDioo/6d3WXDY3MES1nxVizf9EzbqwRiKxE6LfrZn+2gUqVLtIiA1G7Coo8xcilH4sjubGdz1WX6adcxTlB90JgAH1TVE+hqa0vpJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8936002)(8676002)(44832011)(83380400001)(4326008)(38100700002)(41300700001)(2906002)(36756003)(31696002)(86362001)(5660300002)(6512007)(316002)(2616005)(110136005)(66946007)(478600001)(66476007)(6666004)(66556008)(31686004)(6486002)(6506007)(53546011)(33964004)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFKb1dETjYvdEVIZ0lyYmJQMnpXaUlWVkYwN1Y2a3plTk1wM0NHVy9ZYWRa?=
 =?utf-8?B?WVpVVHdOZGtGNlpqNm5seEJLWlF3Y0ZaUkUybTk5QWRYd2xjNG5jTnhuMXd6?=
 =?utf-8?B?b0c2MEI2YUxTOXlTY1R2TVFOOWFmTzRHZHA2NzBQNFhsQ3NrL28wSzgrMVZW?=
 =?utf-8?B?dW1LaElRaGE2M29OWGhQdkhtQTNIdzhEVjMzc2NkdytzbWoxWnFHUk1GajR3?=
 =?utf-8?B?S0JkSk9ZWXJiMnhwSjFRU2F5c1JpY3BkWm5FeWllaFl6ZllMVmd1aFFMY2xL?=
 =?utf-8?B?TTlLTXE2ZUtDakIzZDdvYUlua3NHRE1xeGk3TTNTdVc0VVozcnNNNEc4RWxa?=
 =?utf-8?B?M3JtOUcrL2NzZU5uY01tK0hjMUJsSkRJMWc1RzZLWUVqaGx3LzlxdW1hbzQy?=
 =?utf-8?B?VHhzY2JITDNvczlhN3J1WlBMZ1NNZGVCOFdCVHBwYjVFSUlGTHlYSUFBM09F?=
 =?utf-8?B?Ty9MMHoxeWp2Z24rZUFsa0x1eHIxSENnZ2syOEQ5VXZqQWVGMzJ1aGMxbWxl?=
 =?utf-8?B?UWN3ZnF2dk0wd3RieHA5TCtzMjMreGxaOUJicHZoM3luaklQVHVaS0RkTWt3?=
 =?utf-8?B?TWI4L0Q2K1o3UWFUeVhGWXlKcXJwS1JYSkRSbXdYRXRoU2NFaVZmQk9pMWcv?=
 =?utf-8?B?NmwvRnVpY3Z2TGY4TENESUZJc3FxcnNESmxVR1UrVXR3b0QwWTNLcFNyRk1F?=
 =?utf-8?B?VkFMdW9uOE9xYkZRMU9hSlNVZ3VoazQxYVFQK2ltcnQxcHBkVndTM1hmeUJP?=
 =?utf-8?B?R29HZEsvdHRrc3pSdEtQZzlnOWhvQXFadG96OVpreVhYSkhtSURvalZ4Uk80?=
 =?utf-8?B?QnBJUGxMN0F3Y2Z3QUY3dDhmcThEN2t6amhmUWxpWTlwMXVvNVpxNUR6N1lJ?=
 =?utf-8?B?bFlyazBqakI1QVNWUXBDWXhpNGc3TGxDY0E1YTdST1lFeHFQbHdEaUNlTTFa?=
 =?utf-8?B?WmZhbmZuVCsyS2tTQjFuTVZzQ1lkNEFsSTUvb3FhbHZONkovWlhoM0Z4Y2ZO?=
 =?utf-8?B?VTIvek83ajhaWUVaVlF4UmlGM1V1Yk9halBlbitNZTA3cWswREtSa0RqNTlR?=
 =?utf-8?B?NWZ4VXpHekhBd3F4SEZlTE1FSGJLdGxzcU1DdnlKYWljT0lxMmJQL1BtYU1L?=
 =?utf-8?B?TXFWSkNNcjRIdGNGQytBenZHbmh2alhOMUsvOHdZUVJvRS9HL3RmTkUvMW5o?=
 =?utf-8?B?WmtIRXRxSHhlRzdZVXB5YllkMGZSc05taEc5dDRQU3FIRHg2SUpkRUVTTTlY?=
 =?utf-8?B?ZVZaRFZ4U1o3Rmg4Qks4WSs0N1lnTGxsNnR3NDRNUHp6M2w1SVhVQ3pnZ25Z?=
 =?utf-8?B?dWRGOHlyUkFsdmtjRldTUUlkdjVTU0YwQjYwdVBEUE05UUZWS0Y5NzdpYnV4?=
 =?utf-8?B?NHNzdU10djBNdjBsUGo4bldiZDBXR0hKNFRhVFBIdG53bmRyMzRFVHdwYU5S?=
 =?utf-8?B?b3lkVnlmSGhYMDR6aFJXL040OFZJb3Q0UUgvSVV1cXV0c0NDTDF2ZXVqNFIy?=
 =?utf-8?B?OVNScGlWbVkrekMwQ1grbVdwYU4ydXdoREpsTmNHamYvVElscXBNYkNYQTBT?=
 =?utf-8?B?Ykd5ZXhBTTRQakVqK3RiUTEzQVBaRWdPcUdHb092T3BkbGpyMFludXdMR3d2?=
 =?utf-8?B?RWpKeTNBUkFVT29nN2ZraEREcGxHR2I2dU4raVFwQlpuYmJ4eURLN0RpcTEz?=
 =?utf-8?B?bXdZVDBKcm52NFNjMXJoNkZkY0cwRjJZMXk0TG8wY3dHc0pRdVlabU5TeGhO?=
 =?utf-8?B?MlFGYmdXMVY0MHpBNURnZjlDd283Q3hITC9hNWE5WE10Z1RmVTZ0cHRQNjQv?=
 =?utf-8?B?TmZOaXlhRFhhb0IvYlZ5a1BDc1o3WjFYckFxZnM5dEdvWkU4T2w4aFhMYjJ0?=
 =?utf-8?B?aVF6aFB0bjdwTUNVdnE4RnpWNzY4b29RRGFwNW5TOHNKR2FieGw2K3kybDdy?=
 =?utf-8?B?ODV0KzZQdGphdEVuUDlidnpPWDA1OVozVVdUajBST2c1ZDZldTN2UjhuOUk1?=
 =?utf-8?B?WkFpWURtVUJ6RWtsRnZ2eFZFUzhiOS9WME9TU1QwWEZqRkxZSWZwS04yRDQx?=
 =?utf-8?B?SFpYcDAwdlc0Y0VBWlJCYWJKTXBaU2dWZEZnYk9OMU8zdDE5MjIvWHRsRDBu?=
 =?utf-8?Q?4yGOzRqxgG/mHN+JrEYaIHuNU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1006525-a1a2-4b3d-6476-08dc1c95a6d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 04:33:45.5867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEFbIoBD1AZZzThpYWFedidp3NGElNbP3KjLaZz1v7UipQWvZ3LSVHUKOkIFQVuEN8zWZAy2lrgQN3HBwaCDRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7417
X-Proofpoint-ORIG-GUID: rFPsADmijCY9MtZRBCFzJcpJaJJ1yOlF
X-Proofpoint-GUID: rFPsADmijCY9MtZRBCFzJcpJaJJ1yOlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_01,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--------------zsOi0iiyfHI9KQ081VoF9CTY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/01/24 7:13 am, Peter Xu wrote:
> On Tue, Jan 23, 2024 at 08:21:55AM +0000, Daniel P. Berrangé wrote:
>> On Tue, Jan 23, 2024 at 06:42:19AM +0000, Het Gala wrote:
>>> 'uri' argument should be optional, as 'uri' and 'channels'
>>> arguments are mutally exclusive in nature.
>>>
>>> Fixes: 074dbce5fcce (migration: New migrate and
>>> migrate-incoming argument 'channels')
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> ---
>>>   qapi/migration.json | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index eb2f883513..197d3faa43 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1757,7 +1757,7 @@
>>>   #
>>>   ##
>>>   { 'command': 'migrate',
>>> -  'data': {'uri': 'str',
>>> +  'data': {'*uri': 'str',
>>>              '*channels': [ 'MigrationChannel' ],
>>>              '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>>              '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>> Hmm, this mistake shows a lack of coverage in migration-test.c for
>> the 'channels' argument. I thought the original series adding 'channels'
>> included the tests for this. Either way, this needs to come with test
>> coverage for use of 'channels', with 'uri' omitted.
> Agreed.  Het, do you plan to provide a test case?

Yes, will provide a test case patch for 'channels' soon.

Regards,

Het Gala

--------------zsOi0iiyfHI9KQ081VoF9CTY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 24/01/24 7:13 am, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZbBrN-V8goSJxEst@x1n">
      <pre class="moz-quote-pre" wrap="">On Tue, Jan 23, 2024 at 08:21:55AM +0000, Daniel P. Berrangé wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On Tue, Jan 23, 2024 at 06:42:19AM +0000, Het Gala wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">'uri' argument should be optional, as 'uri' and 'channels'
arguments are mutally exclusive in nature.

Fixes: 074dbce5fcce (migration: New migrate and
migrate-incoming argument 'channels')
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index eb2f883513..197d3faa43 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1757,7 +1757,7 @@
 #
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str',
+  'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
            '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Hmm, this mistake shows a lack of coverage in migration-test.c for
the 'channels' argument. I thought the original series adding 'channels'
included the tests for this. Either way, this needs to come with test
coverage for use of 'channels', with 'uri' omitted.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Agreed.  Het, do you plan to provide a test case?</pre>
    </blockquote>
    <pre>Yes, will provide a test case patch for 'channels' soon.<span style="white-space: pre-wrap">
</span></pre>
    <pre><span style="white-space: pre-wrap">
</span></pre>
    <pre><span style="white-space: pre-wrap">Regards,</span></pre>
    <pre><span style="white-space: pre-wrap">Het Gala
</span></pre>
    <span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------zsOi0iiyfHI9KQ081VoF9CTY--

