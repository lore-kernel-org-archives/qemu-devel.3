Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3964EDF16D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquZe-0001VZ-QJ; Fri, 13 Feb 2026 09:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquZd-0001Tr-80
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:55:13 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquZa-0002BP-Ab
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:55:13 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DCg2P3072390; Fri, 13 Feb 2026 06:55:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ou1QEtWEYJZkTuEk9sRi7J/AhKpk2SWp9ivV/35o9
 9s=; b=YxVRRgOTwLd9zSFUAV9vEJMsxOrwDBsa5yxWUdQ8AuKhO1Ra5Xi0CqYVy
 y49Sg9l/S3nz6qU34eCpEDFkUL4twr6fBIAgckAZ9sUp4S/UfgYJdF4iRvc1aAwZ
 gTFA9bnDa5pPB8rFXe16arTmM5EwmCyZELw+hFynV0uo96hvD+MpxFNUKVcjZU00
 cdBJ2bUjww9CGck3xS/SC1FqNUN/040XT4wx9HhPw75JPrRw6ED8h7MKwvD0E8aX
 I/MIdf3MXm83mBGQgxbNwgWWJEILoFTr4OMrheLWn8UZYqPRYNfhm+g1Yc1Q3bZ2
 TspBB9fO4xqoo7m19GA0OJeEf9w0A==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021073.outbound.protection.outlook.com [52.101.62.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9u9f9kmm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbGwoAZapqXQ7SXTQyFA40mfakqd/i9TIKyvbXqCVnzzXRYGE6xHSHACD3J8/2fQYQ3Z9Ch7S8xMnND1TEL1aBD05lUmBrdqbYOGj8BBjnvtotBCo5tgN8g4x9EN9DtH9SIy1i21m1Jqps9gjw4zxEp91YyvWV6SaMWVL3IPmXi6w6aKXzYq15kvYEDxwTCOQSO8sGT2NaK6wQ13nuEpIoruOgNxt6oOn4qGQ6+2RLwaLrGoXUOQrTLesbTrXE5IpPjPKkFdoNqd4Fu6RMdpy6exjCELrEMSVD+1UwS0D0PTmb7cLK5+7ecyBYOT1MrN+c1ZdpyUXmsZbPNsbU+yLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou1QEtWEYJZkTuEk9sRi7J/AhKpk2SWp9ivV/35o99s=;
 b=tQANTq2z8gkmyv5Xpe3B+6dER2DtLrVDAgSm4gpAwRuu1tcWBGXSIF5hW6VL2usgYEHuRGKnNTfVZNQ8ORsyBM6JA8k0yZke+/VWevV0WcmYsOgn1YQs8qvFVDBrtJnePmhEosZ+NDo5Ed1grgjecb5GuTwzO9ezTJjs2FUWxNpzUxMTU0nCaO5tO4E6VBUMKQsKa5q2xo3zYsQlEfKTcb+UtfIyk6xMQ04KdFF+h3bRXNXbyqS1546isg/znx+bJ0zw4xDjWBPwmauEtk4eZvq6eIqtlyT6/RoBKJbA/BGLpanHofIeEN8saiS6xaDwI0XRcgXYSCQ3K5rmeTD5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou1QEtWEYJZkTuEk9sRi7J/AhKpk2SWp9ivV/35o99s=;
 b=aQGT+raEJY6ZvouWssnApM+RBhoPGjPQj5F7VwMow8MgeFTREqg1pQhgokwD73nUfGJZGUn+NX16j7itxypu5KdceOWxc89PpFWiPMtr2NEGtYzTqjWNMFUg2+zM6Y37wvwyCPMiD5HWzujCL8AmcRgUHBnqkRvHTse/JbTe7o2abmF+pU4gVtpmy1n4G7wLC4/pHattJpEthVMSJPLx+seSDnZ9Vc7zIgVLxhM7vOnD/4XZ8KJ2bem/NwS3kKjqu/pw/GMwFAIZYfGF28u8yzJ3+E8TdwOUEHpo6mZEitQ/hyxiX0svKMHlYCjyVOBF2fGtgJUXKHw0qwKCRhM2gA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB10983.namprd02.prod.outlook.com (2603:10b6:208:5b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 14:55:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:55:05 +0000
Message-ID: <65e54123-bae9-43bc-9845-b46cecc64a72@nutanix.com>
Date: Fri, 13 Feb 2026 14:55:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/43] audio/pa: replace custom logging with report & trace
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-26-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:610:cc::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB10983:EE_
X-MS-Office365-Filtering-Correlation-Id: da30667f-07ca-4c23-253b-08de6b0fdf9c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnZWS1NSZkkxRzA3SHNrdXY4Um9zV1V1dTJKeEc2ZkNacHVCR2RGZWJvS1k2?=
 =?utf-8?B?K0lRQUFrR01lY3hvbmloeVNzUGhsc1NSMkdzWk9udlFMQTVpdnZBa1B2SUI5?=
 =?utf-8?B?Y1A3dTFHYkhsb1JOUGI2ckw4YWpIWHpyczBQNGQxRWRYNEtZZVptOW82TXNB?=
 =?utf-8?B?RHV0VEpQM1FlOTR4ZkJLZTJZSi9DZE9zQlFJNzF2aWZqSWVHR0w3em9qZXU2?=
 =?utf-8?B?Tlg2SnlQQkg3NzNjSnRtUWk2ZjdWOVRsMWxrL29YcEVRS085ZG93UDNPREl6?=
 =?utf-8?B?blFSbDR4VU9vVklHaldnVnVaVnA2S25jUTd1d09UQUdDSEZJeWNoMkpYOW9z?=
 =?utf-8?B?ZlNLRmRsWXlPTWtacWwxc1BrOWVHRHVQb2JLb01NUlRGVEFjUjVVc1J2ZW8r?=
 =?utf-8?B?c0xOdTJKdXc0dm5HcHZPTGZQZjdydi9QN1J3eXhpWkd5T1Zyc0VRTE5IYjBq?=
 =?utf-8?B?RW1jZnNsYk5nQmhySldQWTdqM3lMekdTZVhraWdYbm9ETkNrSm9yd0FYTFhh?=
 =?utf-8?B?eno0TGl0ZUZaQXJzZ1FWTnAvck5sZEw2aGU5cThpdGFrU3dkNDliZjhaVGwx?=
 =?utf-8?B?MDk2aU4ycmlFRHhMY00yOSt5ODhqbkc4MnYyamJOY29lcVVFa0ZMNDE4SUxy?=
 =?utf-8?B?d0x3YUtGVFN5RzNqOVhocHRFbFRYQTRiYXFlZzRlWmx4UU9UMEdUckJtWDln?=
 =?utf-8?B?OElTTXA5c2h2S2xoVlR2a010a21FaWJtVzN6dUcrV1JoQkd5cHlHQlQrQTkw?=
 =?utf-8?B?dWNHMkZRVnpOaE43anREUitPblVSY1AxZ09tTjE3WGV3Z2RjUkMrM3VnNk5y?=
 =?utf-8?B?cE96c2JFWHhENGxkTndmbGhsSWRpTVVZYXpzVURVMlcwTDBZZG1YNzlQYlBE?=
 =?utf-8?B?dThDVUo3aEZVT3ZqaHpVMWMvK0pkOHBreGVBdVYwa3RnZ0JXR1NVWURQTUp0?=
 =?utf-8?B?TXR5SlVwZVljK0JWY0Rkakcyd3dRNVJWYjdoOC9PYitkeDVMVUIrb1p6OW8r?=
 =?utf-8?B?aVcrbHUzeXJsbkJoVUFPb0tIRnhZVlRoRkVWTSt2aXArMHhuKzBZMzRoQ3RB?=
 =?utf-8?B?MURMdGVoWFZTd0tzb0txdnZZRXpGSFo4YXIzMzJzRmc2RWVzQm5EWmNDQ3FQ?=
 =?utf-8?B?VE5lTWt6YUZCTmJ3MVNpbWhVRmdRVTdBT3BkMHd4c1RqcWI2WUYwbWYxUkFx?=
 =?utf-8?B?NFBYdVAvL0Q5S0FnYjdBL2VMTGwrRmVFVVNSM3AvaS9VRk9kcTRSUjIxYzRD?=
 =?utf-8?B?YytIS1IwZGg3cmc2NlNvcVhGRlJCSnZlbjhEVXQ2aE1ieHV1WE5vaEtjeUhu?=
 =?utf-8?B?Mnljckc2SjdxRElaZFVmQis4M0NrZ3B4cDNyQnN4dWlYdDZDQkpKV1h6cHor?=
 =?utf-8?B?blFteCt4ZStPUm10aDE0cUNQNWd1RWJPTEFYbTJHS3h3K0xmMldWVndFQUhL?=
 =?utf-8?B?MzAxaWxEcEIxbU5qQ0tDRjNGNThoajlCc0F5K2pkMUtqQWRYcTR4MllsMjV6?=
 =?utf-8?B?eTNYY2o2SStCVDNGR0g3bTVhbmYrM0pEUm12Q25uVjZ2a2tQZFJLNThlcVdF?=
 =?utf-8?B?bWhjQ0hYalVRYkxVUVFNYWwreG0wZ2hJYkpxRFF2T3J0dmNpMVhabkFpd09n?=
 =?utf-8?B?eGtad2R5alg3ekdrWk9XeTcwbGszUzMzWXhhOG5Bb1pXRXpZbm5XQWtrOGNo?=
 =?utf-8?B?Wi9EMzhPdDQrUHJjY1JTME8yN2o2eVNWNFJyd2krLzlxcTY4K0FqVTRVUzg0?=
 =?utf-8?B?WjRPSCtJdXZ5bEgrdTQ3S2EwNnFhTnJvMDNURmJUMGVGRFJyVE1YOWhoSCsr?=
 =?utf-8?B?bmpFUGQxL3pjMEtieERNWisrRmJac25ld2lsamJudXAwcStacHZuWVRDOFRM?=
 =?utf-8?B?Zmgrc0dFTW1JTmFOdEUxaStNU1V5bkM4NHRmN2pJSk5NcjZCaGpOclhLTHRF?=
 =?utf-8?B?YkNwNmhrdk5ncXQ1THNndmdmU2M0eVQ2UGl4YTBtUnVHTGZkNXRjUUlQQ1ZY?=
 =?utf-8?B?VVBrSDIzWGdzQlZTamZPdmJBWGgrbDYyRmk5S25ZOXE5Njh3eTBvMEJsbFRN?=
 =?utf-8?B?dCtvT0pCZnRDdEtQLzVZaWRpRnlnMmJ0S2NEYjcwQjNBaWFjY0taa04rUTl2?=
 =?utf-8?Q?21zI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1F2MzRaeTRPR0UyeEFUNDB2OHNvTE90a0YvOEpJVUY3YXNHayticDF3dVhM?=
 =?utf-8?B?eWZwdTJUdkprWHVIRU14OWR2c3l3cGZxelduRXpwOWV2STl0TVVDWHBJM0tH?=
 =?utf-8?B?aTdYenN0bFE5QTVCcTJhaWFRQWtpaTAzbEpHT3FNdU4zclVmZ285MDAxNnNp?=
 =?utf-8?B?b0djcWgyZTRWUk5pVmpUZFZaME9TTlcvS0tSSTlJZjJKZDBscHB4UXNSa3hI?=
 =?utf-8?B?YzlJU0RSNG5RLzdIRzdXTXNXRXVrb1JXdXl3M05LcHpMeGZzdVc4RTM5V2Z5?=
 =?utf-8?B?SDhhK0FqVVMyZHR2SXVjdkhYTzhxMmE0ejlaQy9rUVY3ZzlZRmtHSHZkWEE0?=
 =?utf-8?B?V2lUdUsvRWtlSXBKYnpiVkFjTjNFN2JQeXIxL2MwQVEzVFpocTlqL3IzR2pU?=
 =?utf-8?B?cXBFS08xbXNMTU5GZnUwSXpaK0NRRC9wQk5DejdMc3c1dkJrMVVVR2svZkhk?=
 =?utf-8?B?YWlSVGZDTStsVmIvWDB2NGxYZU5qWlVzbGdqQWJPMitjVGpyQ0tmOWwzTVhI?=
 =?utf-8?B?Z0JSbXIrdkpQVnc4bm1MWWVLSnVhUkE0VFkvelkzajZrUzM2OWpGZmlqLzNW?=
 =?utf-8?B?OFI1OWpnZC9aWXRDUzRJNU1qOGZyUW5LeUNac1NReTN6R2hCWWl4cWF0MDJw?=
 =?utf-8?B?V1IvcUloRWlkd2xxY09tMFBxaVdySG5GQ1VoR2lMUjdCVjB5Y28rWTRLT1J2?=
 =?utf-8?B?RVhJZElWYUZaYlFNenpzN1IvaWJwRmRNc2g0YnprOGJBdXlUVEJlN0p5c1V6?=
 =?utf-8?B?b0czT0hyeHgrL2I1SDd4SEozQ3dBSmJlYXVRL3orMnF3WUxLcnc4ZS9FQytR?=
 =?utf-8?B?YXJBQ2Y5ZlRmZ2FBazhHa1VmQk96RjQzSmlsR0hlcmwvTlM5amlGSWxka1Ux?=
 =?utf-8?B?WVdVYy9CeDhZSUFuVDUyc2NHWEtuMXJMU0ZMQkw0QVV5aTJmeVZkdTRuZWRQ?=
 =?utf-8?B?dmIyV3dVZ01Hd3I1K2pVcko1aUxTUVQwVXJkaVEzSjlTN2lQbWZqek40L3Ey?=
 =?utf-8?B?cXVaMktNWUFtRTlYOEwwRm9wdHhScktDYkNCd044Qk5tcVZXR29YRVc5d3VN?=
 =?utf-8?B?cVgrcXZ1cTNEKytoTSs0Y2VrSTdNUGpLNkttQ052U3Z3MzI4a3ZQYkIzTURr?=
 =?utf-8?B?RkFnVGQ4cTVPbXdBNWY3WFJmandYUUROVmV1MytHOFJQY3VlZUQzU1VDb1I0?=
 =?utf-8?B?YVZuT1NMdG5Ed0pVWHRtWmVpRW5lQWdSUHR1NTc2c2c5ditHV0NBcWJDS3V3?=
 =?utf-8?B?TkxpNGxlVHZNRjEyeitWSEFMeUZHLzR1UkJ5SDllTVFDUXJ6L1p2WW1jQnFQ?=
 =?utf-8?B?ZVA0K05ndTQyS2huSThlMW1xbWhiYnhFUG5nUTV2WldXZHZXdWVNUjAwZFE0?=
 =?utf-8?B?K3A2MlJUSk52b01RZUdwQWNtZFVYakRXa2hzLzVIUXBDb2lYbHkwc2V1encz?=
 =?utf-8?B?THhUeG1OaEZ0SWJmUzFLNVd0VUZNVVg3TVEyVWQ3ZnVlcEd3c1llbHNVMitO?=
 =?utf-8?B?N3FXNlhud3lVbzdmdFUySGxJR3Vib1hPL0Z5UWtjWkVWcDc5YnJGTVMxY3hz?=
 =?utf-8?B?V3FJTDNkdGl2QmovK2ZVemhiZWlGR3NnbWhsZWRoTHdkeXEwNk5tVWxZR0Ji?=
 =?utf-8?B?QmxTaFNGZ04vREFZU2dPNkYyM3VnVzZ6bjVqOHVpa1BVWXA4UVJMdUNYNmVz?=
 =?utf-8?B?ZC84ZVpkbEJkVms3RFMxVnlOcE1qcXBOZldRN3NHNjlGQ01WekVoNk8xeUZk?=
 =?utf-8?B?aFNsdmwwRWZTY244amp5Uy9uV1RmYmF4NDczSkdKamx6cWQ2NXlrU1g4dDBn?=
 =?utf-8?B?dXRsU2pEZEZZWlVia012R1RuOFlSa04yT3YwSnFBUjYyUUU5eWdQMFMxcElK?=
 =?utf-8?B?N1pwTDg0TzAwdVc2Uk0vYnd5dkRkcnphOStOY3c1aWk0QXk1SmcrMHNERWx1?=
 =?utf-8?B?OSs4enFSZDVRcEJ1bWdsbGFjWjZYblVQSUhWQ1RYQldpeWVYZmxvbnJIOHJv?=
 =?utf-8?B?Sy9LalAyVWpoU1FTV00rTG9nMVJMSU9EYWc0NDNZVWlWeXFOeHN5REU4MTE5?=
 =?utf-8?B?NXdveEhvclhyZkJGSm16UHJpeVlZcEhpUWNyakpySkh1MmFDbllaK2Nuak0z?=
 =?utf-8?B?RDdaMGJLUUhaQ0dwVVpLZDBHZG5lNjlSeng3WlhUNzQyNEF1YXVwcVp2SXVG?=
 =?utf-8?B?YTRURXplQ1MwZ1Q2enBFWkVLZi9tcEJ6TWJsT05uc0t3cnhFRFRjZTBHOEZB?=
 =?utf-8?B?Tm5YNnd5YVFqekJqT1VFNmZPT05wZnNCUXlIOEhTUTUwOEVXaXg0aXBIWGdO?=
 =?utf-8?B?dkZWaVBGcE5kcll1UExLY2t1MUFZdXBzd3Z6dkMxa0RYcERUTXU0eExKaFZa?=
 =?utf-8?Q?aJO5NMjXhltA1cM8=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da30667f-07ca-4c23-253b-08de6b0fdf9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:55:05.4456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvLA3xLqrttShY53jvgARUUrH1b4d/PNHpn3RIqW+zAI7Odp8fclThmd+PEC/dwkbgDAUbXzzkKMmHrk8Phdxq+o/uY3eV5EWHTzrLMspfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB10983
X-Authority-Analysis: v=2.4 cv=OuBCCi/t c=1 sm=1 tr=0 ts=698f3b4b cx=c_pps
 a=A7BUKRKBnQHIc+bwMO6jVA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=vjfUhzNMZYcKB00ieZ8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2RqIWF0MHtSpm8hVhVo8P9-m9MKWEb5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNSBTYWx0ZWRfXyffejfYyJaU1
 oO7PDM3K8gDDTBmEyUw7GsQM7KUoUVgFvbNe91qf+U8lGXnU0RscJA4EZOAS0o6xAOH6j5ITrfm
 4wk2wjiM6j+3NdUW8Tusm6mvBgvqy2nGkOkdA9uVK8+kRPZt+3sU2sCxoxa+FEi5p4vdnrsRl2b
 t3y0hiIXD2BuGL70ac6MEb5T6pbvsRVLujKx0AF5NaA36Qe8B66EwNUEpgwFaiUr8gh7cpSuECS
 lzwPJJL/FjV0g0enJFbR9z0N1xul2WqdDFst8wunG3EoTaO9BeV7VXyeYgTVybKi0IpgwKxUYfB
 aLUEgW04GHvsuQgzhzVoOs9gdcKiJ2Rsjiy4/AOWpmH84qW9WIhAwCIoerVfjqcQu+L4oxB4cNF
 k5meameSrPDLFQOUdWdlwTb9N+3b6yqO9LCWHZEoRQTktSSs/Z2zwHWdsey4ktzzAMyoBeOY5IM
 o3xhQfsDVslgvznCg/w==
X-Proofpoint-ORIG-GUID: 2RqIWF0MHtSpm8hVhVo8P9-m9MKWEb5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace the custom audio logging infrastructure with standard QEMU
> error reporting and tracing.
> 
> qpa_conn_init() is called during audio_pa_realize() and already reports
> an error through Error *.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/paaudio.c | 77 ++++++++++++++++++++++++-------------------------
>   1 file changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index e98b4a33b68..bc6a8fa67b3 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -3,14 +3,13 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qemu/audio.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qom/object.h"
> +#include "audio_int.h"
>   
>   #include <pulse/pulseaudio.h>
>   
> -#define AUDIO_CAP "pulseaudio"
> -#include "audio_int.h"
> -
>   #define TYPE_AUDIO_PA "audio-pa"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
>   
> @@ -51,15 +50,16 @@ typedef struct {
>   
>   static void qpa_conn_fini(PAConnection *c);
>   
> -static void G_GNUC_PRINTF (2, 3) qpa_logerr (int err, const char *fmt, ...)
> +static void G_GNUC_PRINTF(2, 3) qpa_logerr(int err, const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> +    error_printf("pulseaudio: ");
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
>   
> -    AUD_log (AUDIO_CAP, "Reason: %s\n", pa_strerror (err));
> +    error_printf(" Reason: %s\n", pa_strerror(err));
>   }
>   
>   #ifndef PA_CONTEXT_IS_GOOD
> @@ -113,12 +113,12 @@ static void *qpa_get_buffer_in(HWVoiceIn *hw, size_t *size)
>       pa_threaded_mainloop_lock(c->mainloop);
>   
>       CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
> -                    "pa_threaded_mainloop_lock failed\n");
> +                    "pa_threaded_mainloop_lock failed");
>   
>       if (!p->read_length) {
>           r = pa_stream_peek(p->stream, &p->read_data, &p->read_length);
>           CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
> -                           "pa_stream_peek failed\n");
> +                           "pa_stream_peek failed");
>       }
>   
>       *size = MIN(p->read_length, *size);
> @@ -141,7 +141,7 @@ static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
>       pa_threaded_mainloop_lock(c->mainloop);
>   
>       CHECK_DEAD_GOTO(c, p->stream, unlock,
> -                    "pa_threaded_mainloop_lock failed\n");
> +                    "pa_threaded_mainloop_lock failed");
>   
>       assert(buf == p->read_data && size <= p->read_length);
>   
> @@ -150,7 +150,7 @@ static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
>   
>       if (size && !p->read_length) {
>           r = pa_stream_drop(p->stream);
> -        CHECK_SUCCESS_GOTO(c, r == 0, unlock, "pa_stream_drop failed\n");
> +        CHECK_SUCCESS_GOTO(c, r == 0, unlock, "pa_stream_drop failed");
>       }
>   
>   unlock:
> @@ -166,7 +166,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
>       pa_threaded_mainloop_lock(c->mainloop);
>   
>       CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
> -                    "pa_threaded_mainloop_lock failed\n");
> +                    "pa_threaded_mainloop_lock failed");
>       if (pa_stream_get_state(p->stream) != PA_STREAM_READY) {
>           /* wait for stream to become ready */
>           goto unlock;
> @@ -179,7 +179,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
>           if (!p->read_length) {
>               r = pa_stream_peek(p->stream, &p->read_data, &p->read_length);
>               CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
> -                               "pa_stream_peek failed\n");
> +                               "pa_stream_peek failed");
>               if (!p->read_length) {
>                   /* buffer is empty */
>                   break;
> @@ -196,7 +196,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
>           if (!p->read_length) {
>               r = pa_stream_drop(p->stream);
>               CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
> -                               "pa_stream_drop failed\n");
> +                               "pa_stream_drop failed");
>           }
>       }
>   
> @@ -218,7 +218,7 @@ static size_t qpa_buffer_get_free(HWVoiceOut *hw)
>       pa_threaded_mainloop_lock(c->mainloop);
>   
>       CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
> -                    "pa_threaded_mainloop_lock failed\n");
> +                    "pa_threaded_mainloop_lock failed");
>       if (pa_stream_get_state(p->stream) != PA_STREAM_READY) {
>           /* wait for stream to become ready */
>           l = 0;
> @@ -227,7 +227,7 @@ static size_t qpa_buffer_get_free(HWVoiceOut *hw)
>   
>       l = pa_stream_writable_size(p->stream);
>       CHECK_SUCCESS_GOTO(c, l != (size_t) -1, unlock_and_fail,
> -                       "pa_stream_writable_size failed\n");
> +                       "pa_stream_writable_size failed");
>   
>   unlock:
>       pa_threaded_mainloop_unlock(c->mainloop);
> @@ -248,12 +248,12 @@ static void *qpa_get_buffer_out(HWVoiceOut *hw, size_t *size)
>       pa_threaded_mainloop_lock(c->mainloop);
>   
>       CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
> -                    "pa_threaded_mainloop_lock failed\n");
> +                    "pa_threaded_mainloop_lock failed");
>   
>       *size = -1;
>       r = pa_stream_begin_write(p->stream, &ret, size);
>       CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail,
> -                       "pa_stream_begin_write failed\n");
> +                       "pa_stream_begin_write failed");
>   
>       pa_threaded_mainloop_unlock(c->mainloop);
>       return ret;
> @@ -273,10 +273,10 @@ static size_t qpa_put_buffer_out(HWVoiceOut *hw, void *data, size_t length)
>       pa_threaded_mainloop_lock(c->mainloop);
>   
>       CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
> -                    "pa_threaded_mainloop_lock failed\n");
> +                    "pa_threaded_mainloop_lock failed");
>   
>       r = pa_stream_write(p->stream, data, length, NULL, 0LL, PA_SEEK_RELATIVE);
> -    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed\n");
> +    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed");
>   
>       pa_threaded_mainloop_unlock(c->mainloop);
>       return length;
> @@ -296,7 +296,7 @@ static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
>       pa_threaded_mainloop_lock(c->mainloop);
>   
>       CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
> -                    "pa_threaded_mainloop_lock failed\n");
> +                    "pa_threaded_mainloop_lock failed");
>       if (pa_stream_get_state(p->stream) != PA_STREAM_READY) {
>           /* wait for stream to become ready */
>           l = 0;
> @@ -306,14 +306,14 @@ static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
>       l = pa_stream_writable_size(p->stream);
>   
>       CHECK_SUCCESS_GOTO(c, l != (size_t) -1, unlock_and_fail,
> -                       "pa_stream_writable_size failed\n");
> +                       "pa_stream_writable_size failed");
>   
>       if (l > length) {
>           l = length;
>       }
>   
>       r = pa_stream_write(p->stream, data, l, NULL, 0LL, PA_SEEK_RELATIVE);
> -    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed\n");
> +    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed");
>   
>   unlock:
>       pa_threaded_mainloop_unlock(c->mainloop);
> @@ -345,7 +345,7 @@ static pa_sample_format_t audfmt_to_pa(AudioFormat afmt, bool big_endian)
>           format = big_endian ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
>           break;
>       default:
> -        dolog ("Internal logic error: Bad audio format %d\n", afmt);
> +        error_report("pulseaudio: Internal logic error: Bad audio format %d", afmt);
>           format = PA_SAMPLE_U8;
>           break;
>       }
> @@ -376,12 +376,12 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
>           *endianness = 0;
>           return AUDIO_FORMAT_F32;
>       default:
> -        dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
> +        error_report("pulseaudio: Internal logic error: Bad pa_sample_format %d", fmt);
>           return AUDIO_FORMAT_U8;
>       }
>   }
>   
> -static void context_state_cb (pa_context *c, void *userdata)
> +static void context_state_cb(pa_context *c, void *userdata)
>   {
>       PAConnection *conn = userdata;
>   
> @@ -473,7 +473,7 @@ static pa_stream *qpa_simple_new (
>           break;
>   
>       default:
> -        dolog("Internal error: unsupported channel count %d\n", ss->channels);
> +        error_report("pulseaudio: unsupported channel count %d", ss->channels);
>           goto fail;
>       }
>   
> @@ -553,7 +553,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
>           &error
>           );
>       if (!pa->stream) {
> -        qpa_logerr (error, "pa_simple_new for playback failed\n");
> +        qpa_logerr(error, "pa_simple_new for playback failed");
>           goto fail1;
>       }
>   
> @@ -604,7 +604,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
>           &error
>           );
>       if (!pa->stream) {
> -        qpa_logerr (error, "pa_simple_new for capture failed\n");
> +        qpa_logerr(error, "pa_simple_new for capture failed");
>           goto fail1;
>       }
>   
> @@ -633,7 +633,7 @@ static void qpa_simple_disconnect(PAConnection *c, pa_stream *stream)
>   
>       err = pa_stream_disconnect(stream);
>       if (err != 0) {
> -        dolog("Failed to disconnect! err=%d\n", err);
> +        error_report("pulseaudio: Failed to disconnect! err=%d", err);
>       }
>       pa_stream_unref(stream);
>   }
> @@ -664,7 +664,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
>               int r = pa_stream_drop(pa->stream);
>               if (r) {
>                   qpa_logerr(pa_context_errno(c->context),
> -                           "pa_stream_drop failed\n");
> +                           "pa_stream_drop failed");
>               }
>               pa->read_length = 0;
>           }
> @@ -698,7 +698,7 @@ static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
>                                             &v, NULL, NULL);
>       if (!op) {
>           qpa_logerr(pa_context_errno(c->context),
> -                   "set_sink_input_volume() failed\n");
> +                   "set_sink_input_volume() failed");
>       } else {
>           pa_operation_unref(op);
>       }
> @@ -708,7 +708,7 @@ static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
>                                           vol->mute, NULL, NULL);
>       if (!op) {
>           qpa_logerr(pa_context_errno(c->context),
> -                   "set_sink_input_mute() failed\n");
> +                   "set_sink_input_mute() failed");
>       } else {
>           pa_operation_unref(op);
>       }
> @@ -740,7 +740,7 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
>           &v, NULL, NULL);
>       if (!op) {
>           qpa_logerr(pa_context_errno(c->context),
> -                   "set_source_output_volume() failed\n");
> +                   "set_source_output_volume() failed");
>       } else {
>           pa_operation_unref(op);
>       }
> @@ -750,7 +750,7 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
>           vol->mute, NULL, NULL);
>       if (!op) {
>           qpa_logerr(pa_context_errno(c->context),
> -                   "set_source_output_mute() failed\n");
> +                   "set_source_output_mute() failed");
>       } else {
>           pa_operation_unref(op);
>       }
> @@ -788,7 +788,7 @@ static void *qpa_conn_init(const char *server)
>   
>       if (pa_context_connect(c->context, server, 0, NULL) < 0) {
>           qpa_logerr(pa_context_errno(c->context),
> -                   "pa_context_connect() failed\n");
> +                   "pa_context_connect() failed");
>           goto fail;
>       }
>   
> @@ -809,7 +809,7 @@ static void *qpa_conn_init(const char *server)
>   
>           if (!PA_CONTEXT_IS_GOOD(state)) {
>               qpa_logerr(pa_context_errno(c->context),
> -                       "Wrong context state\n");
> +                       "Wrong context state");
>               goto unlock_and_fail;
>           }
>   
> @@ -823,7 +823,6 @@ static void *qpa_conn_init(const char *server)
>   unlock_and_fail:
>       pa_threaded_mainloop_unlock(c->mainloop);
>   fail:
> -    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
>       qpa_conn_fini(c);
>       return NULL;
>   }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


