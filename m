Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4722DC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmZQ-0008PC-C1; Fri, 02 May 2025 05:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmZN-0008Oj-Kk
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:20:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmZJ-00037b-Rm
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:20:33 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5427f4fX025064;
 Fri, 2 May 2025 02:20:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HYwXUlQzVyBh4kbkO1061kfAx9HXgODBMxQjJWpmA
 iw=; b=2UNVsPstl2K/t62yE0bdcL6OkxDsWLFQSCWV8iS5D5cWUp8UIbB6XaBb0
 EPW4N8H3T6yUU0rr61xk7ZpUdSOhzL83nGTklJ8CwXuuy8XDjfKUSUoGQS1SFp5Q
 OrjDm+XVpns7/Um2HEgzesvi/T4aLPZjeo0YM85lKrAmKs60R0QiCkKOCGduqPOu
 CQSufYepLWai8c/g2WkPm8taplUyRr/4aZ7DAHbVLg+8kPtEJy1jA3trShE//dJ5
 G6xQ5GuGjtSvYeh5f8xG/orIY+m9uznt0ch6nd0/JA/NhXOi0aXyRuchz5FMHI6N
 BoLHETvzwa0V/N420ce1jf76jaMOA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46b4m1pres-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZZ5G81b0Tuy/kguQE6U1rzapfOI+i7Ati1Kt4ywwg8qeSaPr5vhBklvaIbfa+OTBjgGfAqaJH9iJwCAgkadvBaqUAa9SFHVyffL/Tp8cq+sYScO00w2yfw4dDwIA/LgfywNUGbIuZRtTGxu5cOZVVihQAZfQ/H4siHWkKyr3uKWNy86Qg2U7IeqordguxBeMzg8VwUT3eofdIzeh+/nXSFbsllIo0qvFC48D6mhAmtEc5NIHuYBRveJ6xlwH1QzNaLTGTlK9EmDOM3uSboGsjjh9tMvoQSf6B85GIvOLeH34fIsK/+HVMP/ppcSCKPUNMXp8+wY9Aw7tG/XScIMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYwXUlQzVyBh4kbkO1061kfAx9HXgODBMxQjJWpmAiw=;
 b=mhL2J/6GzqKoIwZp0zPzLcqEywgxcbXNRK7khDvY3udxyvDzLlIBEXidkYX+MnyiRhJ5i8+ObK31hsubTXlyhAA6+zxOgetS9lBPE2kvXVw3dQcSkgeBdaSrFXVvufevr9eGleyupBFEK6WKIZdm6rROI4ZKNGtwsv+X18tVafaMUmSULTKKZ7EdmdCEpdJA3mhl35Z+KVn5fAQTOXxVJ8wxhMroNbzQjI9I04g/dhprbSUSVKDPEFWma7hHifvsb+YZewAdNP1iH18uGntbPVYxIvrmt6R4JK1Ziky58OhM54ylDbzEhgE/eWIJn6qU3w7y5bgPfYFu4Ujfyvir1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYwXUlQzVyBh4kbkO1061kfAx9HXgODBMxQjJWpmAiw=;
 b=Kil+0AfjFpZuQkRVkh5XL519sopcSFG6TiKlqF5L4D2umUMMH7aAK7ZsEvlr0ncQZ1QWfYg8WIaU7C3tP2M/yG1Cl4tsPxM2g7Qewn2k99v92G5iw9RDh7DGNdQEiFPk7Hf8pa+rYnY3UfDEQO4Thx96aYSL+GJnLAu5u+XIQUT0jkEXHQBrSTdDiCmxWjxot9PiCj3aeZ+b0SlDSuvQ30eCb5MU+BeqNMfeTVe/rlItaXj/OYfdNm4NfhukCyRaqr2CF8T9eW8F1hfzTnRhJRk/QB3PeZTR0s1muEMmxaCw7cKMUeBZlA93BiK9UUylo5tn6beBlljjWHU1fGaF7A==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CY5PR02MB8893.namprd02.prod.outlook.com (2603:10b6:930:3f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Fri, 2 May 2025 09:20:09 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:20:08 +0000
Message-ID: <8a034d6e-3a09-444e-9a89-8e9a2c878b8c@nutanix.com>
Date: Fri, 2 May 2025 10:20:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] hw/i386/pc: Remove pc_compat_2_7[] array
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-10-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::19) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CY5PR02MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a602cd-dc4a-45a6-7ee5-08dd895a8875
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3RJRVFKYVBDUzNhTDVFVkZKbDljZDBQUEorWWtRQnc1c3BRcndIOWxLRGc4?=
 =?utf-8?B?NWhGMnROWS9uZXZCSkhPSEJiL3Q2RDVpNzI5WEJwcjY4QTcwY2hLY0MxT1Ji?=
 =?utf-8?B?QzFXRGlPRGxmWllIQ3B3Rk5VUkhNalBLTTN0UUhQMUE3V0wxN1Z3NklPVGxP?=
 =?utf-8?B?Q1Y4RUNYREdabVVJcGE1cUNhbGdmVkI0QmNDSWVMcmVjRGo0bVluWENXeVZS?=
 =?utf-8?B?T01CeU8zNzRIVFhLSHd2VnJvUThGeUE4bVJ1TXRFWk1hbWNsSEdWd1ZGMnpE?=
 =?utf-8?B?VzRXNVgydWhBaEtiV214Y0VjK1c0dFgzOE41M0dkWS81REU0L2hXTzEweVdZ?=
 =?utf-8?B?YTg1ZnJaVlFMdVEvRGt1d1hNSHprYmdvUVFRdFhUVkFCTXpQZGtsVjBESkhw?=
 =?utf-8?B?dTRBYU1QeFZIV1JsNmZCVTJ0VlEwMFBzTTc0c3ZNd2JLQ3pxOW9Ha1MzYXdx?=
 =?utf-8?B?SXBVQWdwakhXb0J6dVRiMkQ1R0tSbzRmZ0tvRGhRd3ZZaVRscVBTemVWaU1y?=
 =?utf-8?B?QnQwNzVNdFdFUElkUG9ObkJ1d0ZpeG5HWTFKLzAxR0thenVkR3gzYWxnUzZX?=
 =?utf-8?B?ZWhNdHZaMGhTYzBjVHBlK0VUNitlZERzU2wvSDhyTWtzS1NxL0FrZXlTbGJn?=
 =?utf-8?B?VkJjb1A1dE10N3dBbFlBb2VkdXVENEFzVFBlUHFPQ1JNc21FNVdhVTUvNENx?=
 =?utf-8?B?TjhWcTFoRC9iMEM0eXZ3ZXhWWHFnQmRxaUVUWm5lMTE5MXdqL2c0K0w3ZC9k?=
 =?utf-8?B?djN0RG14TDQ4VWwyL2ROcm9UbVpJWkJsbjI0cUlyMlowenkvWlI1OUN3aWlJ?=
 =?utf-8?B?TWVtTmloa2RPeDk1aFBDU1VWRlptMUdLOEZFVWhoNDNVVHBtOHVHMyt4Wnp6?=
 =?utf-8?B?VXNGRjFSY0ZZbGl2Smd0N2wzTUtlSms0MmdxaDhuSmxEQzlEcnkza1luWEpT?=
 =?utf-8?B?WWw2ZTIxaXplV0ordU1GSzZWdDdvZ3d1QytaTlNlcEdGWUJjQ2ZERE1XMXJF?=
 =?utf-8?B?WUNZcUFCQ0lldG9YZENrZFErK0FmZ3V0WkVwS2tvKzEyZ1FpdzZuQlI0SWJU?=
 =?utf-8?B?ZUFveFQzOXpDOUJWSFJHeUdHVCtWd3dlSktSM1NkVG9OSmxPRHROYzRjQVQ4?=
 =?utf-8?B?TWZxME05elAvTytxM1dmeGVoeFczcmQzZEFxeGQza0kvdmhFVVF3Q1pVa2pt?=
 =?utf-8?B?eEk2a1lQeUFjdW5sb2dlcEtlaW9zdEVMVnBKUU5LK2l3SDVXNVNOallzeWhx?=
 =?utf-8?B?RlZrV043L05sUytwMDEwYnFOemRGK3EvdmhCR1hJbWx3R1VidE44MFRHSXow?=
 =?utf-8?B?My9DL3RTc1Q1TEg4NytRYldsUFM4NHhtSU9OcDVYRW1QcGZJM0JCdHVhNy9t?=
 =?utf-8?B?a05icDUvT0N2K3pCN1oxY01wSGZrWU5nUHZKL3hLUGRSM0J0cGVCTzh0Z0Ft?=
 =?utf-8?B?dmgramVnbVRCOWdFc0pabDFSeUczKzgvQlo2czZMVVUrbU5Qamk0QjVXVC9N?=
 =?utf-8?B?dTFOSFUzMDNza3o3VEdoVjNYeFM0ZE1uL2xFWUVRVkdTVDZVTXhvejVNUzRW?=
 =?utf-8?B?eHdIR1hiNTlreWkzK2tIMzJTdDUzVHg3MVVDYlFhZElIWjdWc3Bpb294L3pm?=
 =?utf-8?B?dEwyMW1zTWNCM2k2UXlQUWpiSmJTNzFMeVRMa25WOHlBeTJHZUZGZDZoc3JS?=
 =?utf-8?B?N0pGWTJPRUtQeDFDSmdEL0JFRTdQemJITGd0RVZ4L0dwZ1dNUHErV0lsU24r?=
 =?utf-8?B?U1czUFU1QTc4VEFTQTNUeVBiWW80V3JPMzVCdnFRb2FZQUd4Vy9YeXNWOWJl?=
 =?utf-8?B?b1YwaG4yLzltbHNJZ290NVVWYm92bUR0VjZVeS8welRURk9ZSnU4aGNYYTlH?=
 =?utf-8?B?SDJ2amp0WUNacVdBOCt1cVI2bllhb2NJeXB0QVJlSVozV0xqUCtlYU82Ym5r?=
 =?utf-8?Q?5eCI00ZeXGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdrcER5aC81UzMxR2xvSmJaNy9ZQUJiNFppWm1weTJHNnoyN2MwSHhOVStq?=
 =?utf-8?B?bWxBQWNIUFp5SFY0SmhpTHBtVGZEelVURGZ1dmpYVlFIU09nVVJTQ0wwZjVh?=
 =?utf-8?B?MmU3cU95V1VhVm05VXE4RnRBaWtEUUpsTmFNVHdxcEJ3czE1SER4bnB3VG8r?=
 =?utf-8?B?SkJhWFplUHdyczFNZlMyV3JrV2haNDQ5N3QyR21oTW5oaE9xeWp4QnZQY2RL?=
 =?utf-8?B?V05oQXgwR3dzVWRsYXVELy81TG1ZclR1d0t4ODJFWjF0NU1TNTYrRm02Vm43?=
 =?utf-8?B?eFVNbVFyMDlxdGVyOUdLUW8xU05IdjZQZC9obURIc2d2Q2ZNYllIaTlVRUFy?=
 =?utf-8?B?RDg0elhBVWtzUlh3NVArbzZuOVR1dGNDVnpTTHBiRFlpWnhmTG1idDRyZTJV?=
 =?utf-8?B?MjQyaUlMWGR5K1VwazAyaFYwMWhzdDAxWCt1SHVzSHU5S0MyczZVN241emM0?=
 =?utf-8?B?dkJFOFJDZ3hOSFZscDJySVlBcldzQytRV09GUlEzZytEbm9adTFIYTAycThS?=
 =?utf-8?B?dHdUMkgzN3c5dUE4dzIrTlFmeFBiWTRqaVFEZXNIMG5reFl6R2gxWThuVExK?=
 =?utf-8?B?bXVseThINjVSMUhhRHI0UTFTc0RHNnMxcnpFVUV3WTdNSCtXdWhxYm05bC9k?=
 =?utf-8?B?cHJNME5yQ3huUGRsSU1pSGN2d3BlWng1RGhwVzloWW1ZTnpzUFBqQ3NVbXlZ?=
 =?utf-8?B?OWM5akJBTDlNTGNqZjhqbEJjanphWnZJRWNNaUhhTjF3YTVRUlVaTWR2T1Vo?=
 =?utf-8?B?THlFNDVRQWVPYjNxYTlFT0JlOGQrclBhNTM1YTVSVk1MbDMra09UWExoSDJV?=
 =?utf-8?B?dFg4bEFVakJWam9jN2l2RVVhSW1kUjVaRXJYNzVyRHhTR2VvekxYNTQzQnN3?=
 =?utf-8?B?NVRINGJSaHlDZU8yS3Z6d3BvRUxGRStWQmhkdkwrZTN5VGo4aUJaLytpNlhQ?=
 =?utf-8?B?WmUrYnRycnN5cEZKb1FlL29taDdGVVVxS2FKNnVRcHZTbFBEcDhHYUNYR0NG?=
 =?utf-8?B?NjdRMk51S3JFT3lNNkg5eWlORGZhdDg2VWt5R3g5VWdHT0ZvbEtHQXBwa00r?=
 =?utf-8?B?d3N5aUpmWGt5V29XSFN1bjl0RGplTjhLSXUrQk1xS2U2YVE3R1B5YzN0c0VY?=
 =?utf-8?B?ZXpuc0FOcWdmT0MyWi9Xejd5aDJjVEFKcVl6QTlIbk5PTDJYdXV0dllXU3dV?=
 =?utf-8?B?VUFmKzBhZVFvZGx6N3BiRStXWnJTUzZlZjI4cWxXNVEyYTAyVjhodUdjd2dL?=
 =?utf-8?B?TExHVXJVTlBkMjVoZ09UWGlUUmhrRDJrSUJKWWtlZXNaYzZkeE5vS2I2ZFcr?=
 =?utf-8?B?c0lDSlNKcFdnQ1NmQkFBZERDR0dCZElGd0lGczlNNWcvM3dyeDE3K05hL1NX?=
 =?utf-8?B?WmhaMmhlMjZDMC82SHUyRXZtSERnQnpkdVF0a1BEWFZ0SnFFRnVxdGJJNlBF?=
 =?utf-8?B?c1A5d1p4QWF3Mm1pS2NuVUZVVzBnWE9NOWJxTVE3dXhac1dhMW01UUpvck9V?=
 =?utf-8?B?RlZjeTRmR2VPMVljU0xXeGV4YkpwaElBcTJxWE1tdUo2VUM3Z1lLbllwMlZZ?=
 =?utf-8?B?endjM2dnZzlpWlRrcXVWdHZkU0tsbTBGOXUvcFBDY0hYaUJKNGpDWWJSWFd3?=
 =?utf-8?B?TXA0UXE5TzY0Y1poUFlzSlp4VndsSWYySEoxQ2RwRVR1VU5MVVZndXd0cThh?=
 =?utf-8?B?MExkemdGNGVNMEtwa1hteVN4Q1dMdDBOWFlRY0lNZFk5b1g2SXJHSDc1U3FT?=
 =?utf-8?B?bDdUY01URWJMZ0hWeE1QQVdVOWxVK3FpSmRNTEkwMjRYQlZZQkJvTDM2SlNO?=
 =?utf-8?B?UTdjcjNhbE41WStNaTdFUnJXaXVJZDZmY0F2TTU5QzArWEI3aVN1ZUwxUldZ?=
 =?utf-8?B?RDBxNGhDRmhvMTd3WnN4ZFY5ZEpLN09OTGdTM3YzczYzS2FDdDgzMHVzTlVH?=
 =?utf-8?B?anlnK1RZQVFHeXNNbjljcnZRdC81ek93T2dUc2xNbndmeFR0TVNtcGVsYm9U?=
 =?utf-8?B?U0N4a2lKaElqZG5QVWpRb0dGRzN4SVl1WjdnSGp5bmNueHBFUzZtY01uRm4r?=
 =?utf-8?B?WVV3MGZRanlJandXNEVqTjhjam9Pd1gzRDluT2lqSFpXMG5VR2NsMFBPWWdk?=
 =?utf-8?B?NmdzWGNSWm4vUzYyN20rMW9kNGVyYmJjaDJtelBRZWJKWkhodjFNSkQ3UzNT?=
 =?utf-8?B?OENtczdaYVBhOHNpZ2tRUXdMNWprNHM2QzI3QTJ4U05XQXFyVlYzWm9kanIx?=
 =?utf-8?B?SXdXNklMVVVkNkdKWU5qanZZYzZRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a602cd-dc4a-45a6-7ee5-08dd895a8875
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:20:08.8155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lni7h6hVMlF6oGl0aT8WIwfMuD8pit4vPdQQFpAcSV3HtBDBOxJD8diNnYs6o8mY6rqsSZx5VTbflgIRL4ow7675qv1ItxadAF+g+vxt4Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8893
X-Authority-Analysis: v=2.4 cv=Y9n4sgeN c=1 sm=1 tr=0 ts=68148e4b cx=c_pps
 a=VzeH2YOhhDlPZ0WtbyP6yA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=i63VPF-aTiSr9jz-lQIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eWfU_qBnV4UvboqF0SW1gud_8RswqvWk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MiBTYWx0ZWRfXwj0cK0NWVbcR
 PpT5nJwd/Z6QrsJ1IE/Vj8C+7wABN4PFK4G5/txnpXWukqH94q9V2VEc6LFZRvIgW8BMW6RoxWJ
 0bMB8mbRNRTNHhj8IEa+TAHBQtbalV58Sk1Lcdn+qqCMYCgD8AOUb8yw9bkuyaFt7onFuYKGYxP
 Nj/lrowa4O0sHk4bl5qBLORfacwisfJvWa6YDRM16NCwVvGSSsrhSTf0ioV7nrUcfUye6f9/MVJ
 KZ6xMT3idXArxDdeNLBxhNP8cUJ+iTQTXShwveAY1XGd0HfbO/r7phbEOPhemJmYP8852jpAQ1B
 JkbznSFGtn9/kTVSnX3eJta0PDmIAmfCDgoAcwNdQN33Z8FL5H/oOK2LQsbJVFJTREI0PEHy72F
 SjgsYUDbNskbsa6WWeJXfbgFyQtQV0PaL4ExSFWc514GZey/Oo+QMnQskYnHU7332ardm1Jj
X-Proofpoint-ORIG-GUID: eWfU_qBnV4UvboqF0SW1gud_8RswqvWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The pc_compat_2_7[] array was only used by the pc-q35-2.7
> and pc-i440fx-2.7 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h |  3 ---
>   hw/i386/pc.c         | 10 ----------
>   2 files changed, 13 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 4fb2033bc54..319ec82f709 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
>   extern GlobalProperty pc_compat_2_8[];
>   extern const size_t pc_compat_2_8_len;
>   
> -extern GlobalProperty pc_compat_2_7[];
> -extern const size_t pc_compat_2_7_len;
> -
>   #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>       static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                    const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 7573b880905..ee7095c89a8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
>   };
>   const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
>   
> -GlobalProperty pc_compat_2_7[] = {
> -    { TYPE_X86_CPU, "l3-cache", "off" },
> -    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
> -    { "isa-pcspk", "migrate", "off" },
> -};
> -const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
> -
>   /*
>    * @PC_FW_DATA:
>    * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


