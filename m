Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616BEC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 15:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rduMc-0000Ou-IJ; Sat, 24 Feb 2024 10:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rduMa-0000OS-QE
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 10:54:56 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rduMX-0006if-Rk
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 10:54:56 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41OEt2WH029318; Sat, 24 Feb 2024 07:54:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:from:to:cc:references
 :in-reply-to:mime-version; s=proofpoint20171006; bh=AxRXaYSWXd7z
 hadghFiiKEXY0s1+9wztXtkuoaK5L0M=; b=cBFwr0xAF4Y8KkUDLrp0xzYpCo9f
 CXYusus8LDH4nBQO6bDbqly3FUhYuNB8Aeuw/7z/iuG41LTfoPvpZtbrJXZSh71W
 8b79/jvYBW39sprpUJqeL2DIUBzVZS9JphpLshyiVvjf4IZiwn8Y30CaswRy4dV7
 xEhwXyBRwjB8qNBJjbj2L0GVngyBzs0WmrR0Tsmuk68IRaDEsqgCe0yAnQHOY8xw
 oI6EkCoH83DI60IiKXRLS7uUGtL0k8DjkH4QK7qzKsEq/yfzrrf/0whD9equx7LM
 aht+zZKbIMbB4cPyN/aLgR4v7g2dAlGTgNXtYvWueeBULsx1RkCcmKWX3g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wffepr9ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Feb 2024 07:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epvdSSDkKUlve9IzzQhtyE1a1ygmKyKFSwq5N/2hhZ7cN+Qy7ugCHuedp1cP0GRGMO8RuSVQ9i01pfkvdZB6azn8G86ptHAQb6NejnFrNvoNI7pAEafgiRzifHXq+6KWvqu3GzXXXeVE+qXrFtq3erlClUxwZsfGhBif77C0JWWXqX67R4Cs9qFbtKlYfY7aypYbrXX1JkGHqVnPxkTkqhn8wDJBdkYH0K4nQJXaSFBy+Y53U0KfnP1NZpGDFaPuAy3OBRh1MNblHpWvCAW1ibujItIcETGy3uXlX2tSm24A/CA+mGK5qYNzlE2HE30c5S95/oL3NqApIxduLRwHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxRXaYSWXd7zhadghFiiKEXY0s1+9wztXtkuoaK5L0M=;
 b=k59ur4o71d4P0gsz8RicHUxpWg3hz5L/qIndaVveQ+pOu96ht4zqMGhCDNvZ5WL+9Dt1aCYR4yDFKz9RGR95vtCuoHOaP4wHQDufuhiP5+H8KyIR0rICj7fWR0xQyP0cBWdi0oTvvnqc2CzPW0WSZdSDT8HRioBTGUN0SjOr72S8j6fhiTPKC776rZ4bbnnzI8BpXlP5uACxrRGU32xqBk83y/DoXrPsumxm5WpacDJiQVrHbwzo0Uw9esOiP55tcQ2HhUsbzUOtl8qDOVKxKc5Y1SOAYCknUiRuawERivls3Lfxd1V1bpRXnOoScT2venyekTx6sgfSGw95XWEr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxRXaYSWXd7zhadghFiiKEXY0s1+9wztXtkuoaK5L0M=;
 b=mqvRz0XBiu92y+xw8HU4oyt+YIt81uqrI8tvzgpMnaVzPNgSPwyUeFybSi0nsorbS5p6FcNDGBxSPib5TNvoP20EQePQyP6fzrVPCzYI79p+vZLqmQ7V++H/kfS2KA56zE+NAAMPuHOOOXOifDeLg4WcstwkRI+EDJou5NHg5040COEc5xRS+uk5/yIm1OnnCJdFvr7PgIxP46IUAGhFjBo9lMbY8IaMOOVuMy1cpeL1cXaH3vsHbXv9Mj3kDXJIWPtjmbJdQ+mrf/giZZuN/mUDkjCAvKHHhsiyqFfv5URH8kmm7lzv0TaSFfzBzwYQW2t8vJSgcqoPkBJkC6Eqhw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8005.namprd02.prod.outlook.com (2603:10b6:8:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 15:54:46 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 15:54:45 +0000
Content-Type: multipart/alternative;
 boundary="------------qce8vp5TZOPujVQPe8wvydt3"
Message-ID: <60a8b976-35e9-4bc5-a4a7-8f6e8378319d@nutanix.com>
Date: Sat, 24 Feb 2024 21:24:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
In-Reply-To: <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
X-ClientProxiedBy: MA0PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dfe9c7-3353-4bfc-0561-08dc3550ebf8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MGUPTwefEiPNfr7DSXjh3bIei4VnKNF3hJJm9q9xKfhUGEwiUfE0pIIZ1jIvrLUfPsyrWYRje3ARyDg9gurtV02D1+enIWS3jHOCBzUugmZY9N8CtWSp1wSyUvyLlBDeTylKxIx6qfS9ZGdsOiGdB9RttKiJsMQsP6fMp6gXHWlOoYH9D72ZxHG/9sWz/zJlEfFfiBXhQ2X2DxhqfM7MaZcZLUL3f0fpP/+NfFSg59zLXqGcEef05JMQGgixLJOKw+70SYrhDyx2bB4gINw72+JsJ1exJ8/uNd8yWNWJSWraUsE91gpmwrZDk9y84/JEx6V/QNWAlcpte8Lil/N2CNHwJm1T5h17E1AoDcye0Q1cCIxqy7qsjuAo/lFF13OAbdae3Fz+hTyCPjc4MQAu068gBv/MzOFrPz80ShSVx9ZjkEu1LfJQZBfqivqtv0o3MIIn1vYxBqItF6i8UsESa0SWjJ/5q1I7/9PESwbavNqlbQzwOKIg2TH7SlNiF8d6T7Tc1wyv39OtiEtf2uGU+QmEA5gjSpDqiUmpAGJiH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmk4ZEloVUxnVGg3cDlGWkx2RUdkYWNEekdHY2ZlRHpaMGRQUVZCWk83WlBG?=
 =?utf-8?B?YWhkSDE5UXc4MWlWamtBVllDeDRVZnlVZmZCV1JMMnNDS2R6TG56SWdxeVkw?=
 =?utf-8?B?U0h4WTluWE9Icy8xR0JUelNkdWp0NHRMR0k1TnlTQkh4eUFPU29RemdCVE5a?=
 =?utf-8?B?Ym9semlwS1U1eXRBK1pPdllSc2x1YUpWNkxKYVJtUTlVU1VweVFlMnJCS24x?=
 =?utf-8?B?MjI1NHlZVkVmQmpRWTE2YUJha2htSFlwblhXVThzZUMwc0ZQN0xHSkZLY3VF?=
 =?utf-8?B?Z25EbjR3NmRYcHB0RDUvYk1JUHlDbW9VTVlVcHI0b3NDSmI4L1ovQkZEazdh?=
 =?utf-8?B?SXg5SXNVRTV3eSsxTzhWWXNQZDdLdSs3MjFVckFqdmJ0c29zV2NsbENVZVl6?=
 =?utf-8?B?aUtjZ1k0SHRwam5MMXR5S0NFWTRGQ25FQ0p3OHpqbFlNVXlpazFweGlic0ts?=
 =?utf-8?B?bmhRN1VoUnAzLzhBaHJRRDZtRFNYNG5yby96d2w4aVZaSTFZZEQ2azg5VDls?=
 =?utf-8?B?L0JGV2MrTlA1ekNyTXMrZ21NU0RINnZ0VjFJaFZ2bjUyZzh2NDF2TFJpY1h0?=
 =?utf-8?B?MTRPc1J2NFVMY2N1UkJRb3Y2Y3JFN1ZnUVY2eTduL0hHYWluS011WGJSZVBP?=
 =?utf-8?B?VTkwcHZkNnRKNGpjRU5yL0NXRHlGNW1CdENqYmlDVW1kVGU1TTl4M3h0V2ZV?=
 =?utf-8?B?bkhOQzNEK01Za2thQzc4RlBOUmlPMkVKNzlPZkxwYUp6Q1lIK3cyd09FRndh?=
 =?utf-8?B?L3hCYXRoMUkybTFqMjVLRlBFT1NKbkEycmd2QXltbVYwTFAzTWM1aWNOZC9a?=
 =?utf-8?B?V083QURCNVRyY3NjYVI0L1JnWld4UFlDU29mWVpkVW9qRkpzUXkrNWFPVmV4?=
 =?utf-8?B?SnFNaVNkckh4K1dWSk1SWGRUWFN0bGZ6Z3FoTkZURzd6ZWpvWEZtclh3bEpn?=
 =?utf-8?B?WVAxaXdDL0pFck9SUjZlQnhGNTJ1OXZiK2VmTzBzUHRVV2xQMDlxNnFqcGQx?=
 =?utf-8?B?K3pvcWtkaHpUaHVwbzB3MEcrWi9UcTNxdk1OYVdoaXordkIrbGt3TG5OOVpi?=
 =?utf-8?B?VUlLTEhMcVBKYVhaSGJ4YXF6MWNaZGZYN21uUnUramhGZlhiSnNianUwSGdL?=
 =?utf-8?B?TmtnTW02VC9tL1NGcWJPeEV0NHZCTlUrM0J1YWtqSTNQYjRiY000UzNCM045?=
 =?utf-8?B?MzFKMHBPeHNTQllEeDFwUTJDWFh2ajdTTnJUVldiY01obUtiNTJEYzlhcnUx?=
 =?utf-8?B?T0E2Q0c3blBZMmJkdURrMGp3c0xjekViaGtUUUxhUUhpcWYrcXZoSFF3NTNY?=
 =?utf-8?B?VERwZU1lQVV1Y290V0dqNlBFVlR0VXdXSXRTMytneFZhMVJsVVRVaEJQT1pr?=
 =?utf-8?B?SmFpZmJQZ2ovNkdxbTBMRTNDMTdBNnlNVVpFU05mQlkxTko0SWx6TW5sK0Va?=
 =?utf-8?B?UE5WNnJhM1Rkd1pIY1dRamwycTJaZElJSjhGemsxb1ZjSGg3Rm55REdqcVp4?=
 =?utf-8?B?Ni9xMHBsTTNnYU5WT3g2T3BvZTFycGtUeVNLVzRpUHJkVVp0L3ZXOERkemVj?=
 =?utf-8?B?R1ExM0tndnZSbTI1SUt6WGJwMkcvNmFXR2p4bDNzL2tQNVRGMU01RnpuK1Uy?=
 =?utf-8?B?YmdDcXB2MGtHR2NMS3g4TTNwd3JHU3Awa29TcDcrM29qdVppd2NtZUkvSzRo?=
 =?utf-8?B?U0liWk9EZzBDVFQzdjN3cjV3OGhjN3daUitMeVlkRDc5ME1Oc0wwMVZpaUF6?=
 =?utf-8?B?UTVSc2RpeVBYbDNiZFhCRlZVSVVEdWIrN0xRNmpvdVFsL2d2YzkzZWh3S1Jj?=
 =?utf-8?B?ZGhKSHhsMnEwa3hTazVpNm15VUEvakRZVlk2cFg5RUh4N0djTms5YlVocmZ2?=
 =?utf-8?B?dnZmbnFTT0Q3WDdYQlg0b01iRzdMc3RPR24wS0UxTWd2UDZpS1JqRjd2QnVj?=
 =?utf-8?B?aWhiSjYvZ0VmS1podEpuQXJTRXlEWm4yWFBIY1ZqUXZ1S0ZMaG5yVDNqUmZX?=
 =?utf-8?B?dEdIRjRkVFcyNEluRkF1Q2p6WXJuMmVZa3ZJUGNtZVRsUVliMFpxekgyQmJH?=
 =?utf-8?B?QWJZS2dLWDZhT2RvR2lDVG94UFNFTW1wd3l3ZTNFVUV5VFBBMTNCd3pLVThS?=
 =?utf-8?Q?v5JnZ2Qzg2wVO6b8ZssZ85Ndq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dfe9c7-3353-4bfc-0561-08dc3550ebf8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 15:54:45.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXym46yX0CZleN1PL0Vrwv1ivKwcsVU9XlUP0R9Zd4UagFFxsY/9y9GMOchTPKnjDbZU+RaGMs9ffnqEiT3tUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8005
X-Proofpoint-GUID: m0mB2AJr8f_UV9anldRweSdlN5enPN3H
X-Proofpoint-ORIG-GUID: m0mB2AJr8f_UV9anldRweSdlN5enPN3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_11,2024-02-23_01,2023-05-22_02
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

--------------qce8vp5TZOPujVQPe8wvydt3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/02/24 6:18 pm, Het Gala wrote:
>
>
> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> Introduce support for adding a 'channels' argument to migrate_qmp_fail,
>>> migrate_incoming_qmp and migrate_qmp functions within the migration qtest
>>> framework, enabling enhanced control over migration scenarios.
>> [...]
>>
>> Write the test like this:
>>
>>    static void test_multifd_tcp_none_channels(void)
>>    {
>>        MigrateCommon args = {
>>            .listen_uri = "defer",
>>            .start_hook = test_migrate_precopy_tcp_multifd_start,
>>            .live = true,
>>            .connect_channels = "'channels': [ { 'channel-type': 'main',"
>>                                "      'addr': { 'transport': 'socket',"
>>                                "                'type': 'inet',"
>>                                "                'host': '127.0.0.1',"
>>                                "                'port': '0' } } ]",
>>            .connect_uri = NULL;
>>                                 
>>        };
>>        test_precopy_common(&args);
>>    }
>
> this was the same first approach that I attempted. It won't work because
>
> The final 'migrate' QAPI with channels string would look like
>
> { "execute": "migrate", "arguments": { "channels": "[ { 
> "channel-type": "main", "addr": { "transport": "socket", "type": 
> "inet", "host": "10.117.29.84", "port": "4000" }, "multifd-channels": 
> 2 } ]" } }
>
Sorry, In your example given above, the output looks like :

{"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.1:0", 
"channels": "'channels': [ { 'channel-type': 'main',      'addr': { 
'transport': 'socket',                'type': 'inet',                
'host': '127.0.0.1',                'port': '0' } } ]"}}

> instead of
>
> { "execute": "migrate", "arguments": { "channels": [ { "channel-type": 
> "main", "addr": { "transport": "socket", "type": "inet", "host": 
> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }
>
> It would complain, that channels should be an *array* and not a string.
>
because of /"channels": "'channels': [ { 'channel-type': ....
/
> [...]
>
> Regards,
>
> Het Gala
>
Regards,

Het Gala

--------------qce8vp5TZOPujVQPe8wvydt3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 24/02/24 6:18 pm, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 24/02/24 1:42 am, Fabiano Rosas
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:87zfvr7xdn.fsf@suse.de">
        <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Introduce support for adding a 'channels' argument to migrate_qmp_fail,
migrate_incoming_qmp and migrate_qmp functions within the migration qtest
framework, enabling enhanced control over migration scenarios.
</pre>
          <span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></blockquote>
        <pre class="moz-quote-pre" wrap="">[...]

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
    </blockquote>
    <p><font face="monospace">Sorry, In your example given above, the
        output looks like :</font></p>
    <p><font face="monospace">{&quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;:
        {&quot;uri&quot;: &quot;tcp:127.0.0.1:0&quot;, &quot;channels&quot;: &quot;'channels': [ {
        'channel-type': 'main',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'addr': { 'transport':
        'socket',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'type': 'inet',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'host':
        '127.0.0.1',&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'port': '0' } } ]&quot;}}</font></p>
    <blockquote type="cite" cite="mid:1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com">
      <p><font face="monospace"><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">instead of </span></font></p>
      <p><span style="color: rgb(209, 210, 211); font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">{ &quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;: { &quot;channels&quot;: [ { &quot;channel-type&quot;: &quot;main&quot;, &quot;addr&quot;: { &quot;transport&quot;: &quot;socket&quot;, &quot;type&quot;: &quot;inet&quot;, &quot;host&quot;: &quot;10.117.29.84&quot;, &quot;port&quot;: &quot;4000&quot; }, &quot;multifd-channels&quot;: 2 } ] } }</span></p>
      <p><font face="monospace"><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">It would complain, that channels should be an <b>array</b> and not a string.</span></font></p>
    </blockquote>
    <font face="monospace">because of </font><font face="monospace"><i>&quot;channels&quot;:
        &quot;'channels': [ { 'channel-type': .... <br>
      </i></font>
    <blockquote type="cite" cite="mid:1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com"><font face="monospace"><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"></span><span style="color: rgb(209, 210, 211); font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: left; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
</span></font>[...]<br>
      <p>Regards,</p>
      <p>Het Gala<br>
      </p>
    </blockquote>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Het Gala</font><br>
    </p>
  </body>
</html>

--------------qce8vp5TZOPujVQPe8wvydt3--

