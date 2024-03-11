Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B24C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmLN-0004QB-EI; Mon, 11 Mar 2024 16:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjmLJ-0004Pn-3i
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:33:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjmLF-0006Gf-Rk
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:33:52 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BHllCB008152; Mon, 11 Mar 2024 13:33:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=rR2t6mM2rBam
 33JYMKxn2rPvb+LBzZ4mkxV4UklGq/A=; b=kWR9cTo4gIdcoSW+QRN7DMherSQu
 fhvivLbf0U7+PUV++aMIVniwqI55+iYEA1rRc696TvvC7QmPlf3fLmf9213+qdad
 Zx1wwFJmHhKBU3F5cVvR/zp7o7H8+Vaul26bipn4hlgfSojLiW/tVccDTGr2WO5L
 Hbj8o09EWb8YfVAnXXkWXdswzQY/o528IjxsMJT8nKNqJhYzROIyHuP0mQ9vDh5U
 2BQQxjOWyiTY8jpfDgqhJ0FC5EVXWHcWEsUT7k1eX1yQ50q+L7hSE/+OI40124Dq
 Xxbi9gqkpVn/soayhkgk7fuJlWuCG/Zr2Es4Gemve/7omnSTZfWeOUki1A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr70v1xf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 13:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHt56TEWF6gZeo0rNhhkEGAeSRfdUL2H3Umw9gqBgz9QfZv1xJ3TEjtgZGGGaj6mvjsqVqoUHdCiZidqJdkhFLAuacVBnuCRGgaSow32dA+8B7ltluNWOLoRLxXM3x1FhyDLfDa2jz8n8OrfO1Mv4FMwRR3iC/lzXHRrU0dWVzdfPrzp4xERaSuMCvxNmAyrmobr3W43GFEB3xDtc+GBi/HN/0ySYDmoOG2fGtmG2nZHlxosvhqeDlAXG+F7RFU7XsY523HO1u/60p6/b9mn3WLuDI1ytYGRoFKAXS+18c4OWsVvzKJIwN5JyNST/OXZ7Q8grTlIGnZgy/7yF7mv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR2t6mM2rBam33JYMKxn2rPvb+LBzZ4mkxV4UklGq/A=;
 b=C6aDnv3MRY81zrUdZeWZfUtcs/DB3REpxsPgJJF9dPy/1G/trTc2pPxyCVTP97lbiWO3X4HwoNuORO+iloveVllI/1QeQJ6YDIeaUS+EwiDtCaLv37rJ0cGyYtEfCr1qiD+WrOJTkyajOz0YbifrAEOLS99ojbxKB2vkhyGqD0kdhT8M+EiXf9mRc2NigoRv7uTY7t9739f+xWwScBZE6BXnk4gngniE9ctbEFv3+1yRwZdSfoBQvyy+WskRTN0iLvCnep61HEQ9tuk5RFucZgqA2MsTuvUa87JltKjTOq5SR9m9ZwJZNLepDDt8cjvoetW1JgKA4d/7+Hyxw6oyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR2t6mM2rBam33JYMKxn2rPvb+LBzZ4mkxV4UklGq/A=;
 b=gIcL81B6THxxZKFJrAuwPqxxhzOt97S6UraSvzcZBU3LbzABGGzDBI3We1YhNPKjF9mv4TYmQHDNOVTQHchgX3TPH50vO88THiyS87o+/9AO5QhedajLg6bbwd0MteCXBQMDz2KHZHS25IVW8/n5aVRbmprpde+Ob/046f3vFz2WwQdYJ/daaPXPQVQuUJ00BTFaBfGDf96VHsQhdt3sDFQNw7ZkqT8pXfhphVNBuwMTXSTHvzjh7nvAsTMnhUboYHIOlvBA/HuXUAUdCi0PYkPjaI4miwBEbjDb6jn40wv1RNW+g9NTNi5vcYCbqWeCrok9Al3kZzG4fv8AqEkNhw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MN2PR02MB6798.namprd02.prod.outlook.com (2603:10b6:208:1d8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 20:33:44 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 20:33:44 +0000
Content-Type: multipart/alternative;
 boundary="------------aN0L0g2oA6uuCzGd27n0ookJ"
Message-ID: <2e9121cd-cbc9-4ac8-a058-815dbbff25dc@nutanix.com>
Date: Tue, 12 Mar 2024 02:03:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <20240308205951.111747-4-het.gala@nutanix.com> <87wmq8my0s.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87wmq8my0s.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MN2PR02MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 55904411-e669-4126-3f0f-08dc420a8b9d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MougDFgR5WGGkN9HYyZLDpe7Gd/2GVZohtDQK8Zk7FxPKPnKbcOiDolhhcJ/XzhEjbupk/keUS+ED7K1W4rotFz9jpGUgtKRn2vn0IM4I7Ep+4vzxeO3RY01je/JFkzKVKoAkK9AnAnHLBaw+VW0XopgEm/Ca4rpjPI/HDDESYd1Bt5iZMtymIq1qkMrfyMi1Fz4zeh2AaRyXkJUypNkmqC/1YYtbYDBd0xfdhYFZuWYguYilIY6AUXCp3E7hbLyvjjRSUoWV9L8Im48x4sRAeRmLfhw+9fl5+IPJwjfWIkeH5ZIF5AKYbTKNOqYb4LTOo5NujboBonyPAM86kcHs4dcKrpAoucBdMEgdnowIDSzeWE1V7VRBOlgTjzCtr4uGiNk96//hYC0HVL4zeI9tyWcZAqbpIT3YaRea7SRbrCJ+OjnYHKbB+OHk5qiTiLZsPgyZwcmUmTXrxBAb5WOw6IqBKWzQFQnr7eVuKQnT7B/mxEbyxGKPtzY8wO72P1eaG3fE635eecr4fbZjl5peD1Rhgn7UBVx0oHupGEoKhYiz3a4ZSU3tJ6NlbaYvARUIjuQLb8hMI0Yn9vM7Ye3/SETAEBHAShw+OpbWWBx8dujq0yHGYj0HSyZJWXmLySk8zR9pmH6GEpNrgYUqmjAMrSc8DYfijLsJN6Q9jzssEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTUrMDZnd25uUVl4eWlJd0hrQ21lUGtMc3FmUmtFTVhDT2NjMCtoWUNENHRB?=
 =?utf-8?B?SG92UWo3c2ZBQzdaQWJtTGRzdXpmTWpDNml6VUxUVDRNNVRKeG1rUFBFU0pX?=
 =?utf-8?B?UVB1djBqTUI2SExMbkxGcFVBWjRTSzlvZjBNZ1N1QzljYmhpcTVqMTZoc0pE?=
 =?utf-8?B?blYxdmtvekg0ZnRhWlFyWFlXYjBhZGpYRTNyMkVLNGVybVhJdFZVWXRjdWli?=
 =?utf-8?B?ZVh2azZGREEvWGk3aFFEMlk3ZnhkbVNuNDhESGp5YXhEeWdsSWJNd0g3RU41?=
 =?utf-8?B?WVB1SG4zbXNwUk9jc0dMaVExcGdjRnpFRVNMeFJsUDJGSWh6d3crMUYvNTBL?=
 =?utf-8?B?SGtQYUVmd21WaXlMT0sxZXNEbkdWS3hESndJYld0cmZBdzRGclg5KzdnZVpV?=
 =?utf-8?B?dUZxMXl0SG5NVmNtMFpnbTM4QmVuVk95cjE1V2t5UXhBaXVFZTBSeHV1NHB4?=
 =?utf-8?B?QkYxYUUyZW5NdXkxdng5ZVNScFVWeElVV1lIZzQrcjh2R20veEo2MjhzSkZL?=
 =?utf-8?B?ZTdrbXlxVzJXa2ovSjBwZG1TZjVlZ3h2ZUd2NHBBYjgwYmdVR21zSGJpUDJ3?=
 =?utf-8?B?L1hkQXF0aEE5R1doejBqbmVZOVc5VE56M21PcllvRFFVOS9vdHY2Qk1XYURt?=
 =?utf-8?B?NDd3V3lZNEpWbldRb3ZjcWp4eDdwdVcyOU9HaVQ3dGR2aTVIcFRya3pkelpI?=
 =?utf-8?B?R3BTa2Q0MnFQcGhKbGtHWDdEMjlJa1ZTWVRXR0VJODVmZnFQU1loYUx3RGJV?=
 =?utf-8?B?RUdkR3plbUJjTHVXaWZCSExZZmI1V21nUEhmelZzWWd5WTZ3NVF0cnhveVJI?=
 =?utf-8?B?MmhmS1RXWk1Fc2ViaTV2UHl4bGxvckVobGFseTlPOUppTW1DcDIxTjBrRjNm?=
 =?utf-8?B?UjBlQXdSR2NzWjBDcUJNN2E4ZlFFKzYzVExPQWw0RVptSldYa2MxNkpMOXdT?=
 =?utf-8?B?NVhzdVpxeUN3QWVrMUY4Y1hVZlJjSUk3S29ra1dDcnp5eTZGcUlnU3FyVzVL?=
 =?utf-8?B?R013ZTdxR2tSbkZYelA1R0tZNFNVclljWWdEZGRWMmdMaXRBazNrYkZoZTZ6?=
 =?utf-8?B?Q3gwSWNCME1GTHErcmF1WVZ0QWRidFVPR3lHRVRIbGkvN3drNmx6UUhmMlEw?=
 =?utf-8?B?TmtmRkNkQ1JVVitRbEFvNGZ5ZUltOWR5NEtPd3dkUVpoVmVDZHZPL0syVFN0?=
 =?utf-8?B?N0hLWHVIZ0FEREJUcnIxeGowaFhRQTYxd2Fpb1RQS1EyU3k1bU1lb29iVFEx?=
 =?utf-8?B?UGczbjAvOVNHcG0rQm9FbWpLMCtyWXp2alVXenJac1Y4b0syOEFZVVhvbHV2?=
 =?utf-8?B?VGxXb1RpOW1FNDJqc1oxdlduMSs3SWRzYUtia0VlUm1aN01QaFZDNlE5REhE?=
 =?utf-8?B?emZUcVlZRHdld0dlcFJwckFTOW9GS1VNM3VEUDJqeEloam9FUWMyeGdIS21Y?=
 =?utf-8?B?S0V0N0ZlOVpIT2VKdHh0R1VKTmN5VHJBRXRmYTdSeVB2c0ZFcjBwUU1nS1VV?=
 =?utf-8?B?K3U1cDdCcWdFVE1UZkZiZmkxamMxdmprWWxGY3NvVk9kS3haSzdoS0d2ZFFE?=
 =?utf-8?B?bWFmdXVXM1NIMzdkRm9tbUtGVWFNbHBQaWxLdXVTRG9oT05oSWkyOHJhQTFD?=
 =?utf-8?B?bzcwWjJOMHArdGpNZk1rdVVtSHB1dFZSbDR0Q05DMWFzbW91ZHRNTHZwTFpG?=
 =?utf-8?B?MWNBUEdvN2syL0lRaUJTRVpvcFVVOU8zL2RhZjI3NUh5cHVrMktrRVNMWTJF?=
 =?utf-8?B?U01Td3Vad2lBUW84ZmtpSXB4QThOM0ZTLzM5aU5WMjFHNDJVMHRDQTRLZzlY?=
 =?utf-8?B?MzVXeUpTcHpXWmliT2lGVHlVYUtVci9GTURSdTA0cHRzanhaRzliOFUyYlkz?=
 =?utf-8?B?d2NQR0NxbVM2NStKZmQ0QVBhM0VUb0V6YVk0ZEszNUJ6RlNsOHlndW9tSGJk?=
 =?utf-8?B?Y0dHSkNQajA5VVhYZURNd1U1MlpCMTl6bDFUWERhU05ablcyZXo2RmVaY1py?=
 =?utf-8?B?enVrOURQdHh6OURmNkJHMEJ4emdHT05pd0NhNmRQUWZ4UzhKODg5NXcwbU81?=
 =?utf-8?B?RkRLY0xVTjNOdHBiNmNGWkd4dHFXZXFjY0tZOXJDbDUyZHduZllVS3JBMUZ2?=
 =?utf-8?Q?VOhQxc1HPM8gxIF9npsfrnTBd?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55904411-e669-4126-3f0f-08dc420a8b9d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:33:44.2142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDK9qxutXqYeZCOFb+HlGlK3Wt2eTqhze/x8uT0a5rBLYOE7HAHHfzIBhQVaMHhMnuqajixR3SWwPOhchZtRzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6798
X-Proofpoint-ORIG-GUID: JycWvWNDUWJQT62ze-uKx7Nn9VyoYInb
X-Proofpoint-GUID: JycWvWNDUWJQT62ze-uKx7Nn9VyoYInb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

--------------aN0L0g2oA6uuCzGd27n0ookJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/03/24 11:49 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>>
>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>> @@ -130,7 +140,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>   
>>       g_assert(!qdict_haskey(args, "uri"));
>>       if (!uri) {
>> -        connect_uri = migrate_get_socket_address(to, "socket-address");
>> +        connect_uri = migrate_get_connect_uri(to, "socket-address");
> What's the point of the "socket-address" argument here? Seems a bit
> nonsensical to me to call: migrate_get_socket_address(..., "socket-address").
>
> What about we just suppress this throughout the stack and directly call:
>
>      object = qdict_get(rsp, "socket-address");

Fabiano, I didn't get clearly understand your point here. From what I 
understand,
you want to call just
1. migrate_get_connect_uri(to) and migrate_get_connect_qdict(to)
2. delete migrate_get_socket_address(..., "socket-address") altogether 
3. Just call qdict_get(rsp, "socket-address") which will return an 
object 4. Then convert this object into qdict and uri string respectively ?

Hmm, If that's the case, converting to qdict shouldn't be a problem. But 
for uri string is there a simpler method or writing a parsing function 
would be needed ?


Regards,

Het Gala

--------------aN0L0g2oA6uuCzGd27n0ookJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/03/24 11:49 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87wmq8my0s.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

 bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -130,7 +140,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 
     g_assert(!qdict_haskey(args, &quot;uri&quot;));
     if (!uri) {
-        connect_uri = migrate_get_socket_address(to, &quot;socket-address&quot;);
+        connect_uri = migrate_get_connect_uri(to, &quot;socket-address&quot;);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
What's the point of the &quot;socket-address&quot; argument here? Seems a bit
nonsensical to me to call: migrate_get_socket_address(..., &quot;socket-address&quot;).

What about we just suppress this throughout the stack and directly call:

    object = qdict_get(rsp, &quot;socket-address&quot;);</pre>
    </blockquote>
    <p><font face="monospace">Fabiano, I didn't get clearly understand
        your point here. From what I understand,<br>
        you want to call just<br>
        1. migrate_get_connect_uri(to) and migrate_get_connect_qdict(to)<br>
        2. delete <span style="white-space: pre-wrap">migrate_get_socket_address(..., &quot;socket-address&quot;) altogether
3. Just call </span><span style="white-space: pre-wrap">qdict_get(rsp, &quot;socket-address&quot;) which will return an object
4. Then convert this object into qdict and uri string respectively ?</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">Hmm, If that's the case, converting to qdict shouldn't be a problem. But for uri string
is there a simpler method or writing a parsing function would be needed ?
</span></font></p>
    <p><font face="monospace"><br>
      </font></p>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Het Gala<br>
      </font></p>
  </body>
</html>

--------------aN0L0g2oA6uuCzGd27n0ookJ--

