Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3709FC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmwt-0008D5-C6; Fri, 02 May 2025 05:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmwr-0008Ck-98
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:44:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmwo-000473-U9
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:44:49 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5420tZME023805;
 Fri, 2 May 2025 02:44:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=i5rp0geeAUM7K6J3eN5zzoQ05HiPmeE9AHP1llgy+
 1w=; b=hTnCIpaxj1SToFasc1hvfmspSphdcRLrCk09T7lBdN5HoieyImiwn8O+W
 ZBCkhUtTCVB3xSyEzwn5Yn1AtQe9FY7hueasy6cCXhguHxlU/yCYNoH6QUoILJeA
 W+I+Nc7KuNgLrPZ6a6Q7AgSy4FVa5keoePaPTTN05VGdUOxzkNhcNvlsqKULuB2T
 2z6QbCNHVEH/H/V6Y/XXmtsQJ2i4yNSBH6u4PwzKLcmNY9xSwdnBFXxjVgTdhEho
 /HZt6zIKS/WoPbRsKWvCuUAoJlRrz9ZQtZ8bkXghpVnb58lGl6tmJ3YrFJdA7VVP
 LqNJ1Z8c2Dii6ZWf1WXMyJfUesqwQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8nft6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz8FufKwH5sGhNtKnrX863Ru4DC7KmEQkE3oKq9hnQfIwwyR6zQjvrq+S07d5wXBd0G7ciZ9EqOB20oyqXZuXNY06KV7HI/abEQmEWPzcjRz2IpvXHkXk4iyBU60xx3SUfADITWQYuYNALOrHpPw9DXBTE1vPdnMn7vr+CTQ95CG4aWoXha/B0cn2rDW/CV1jHJMIpXRELNTXOk54NCPFhjzd0Adb0V8GsXrH7+m0LjmHHzBgwoNsofSHAEmNY0JowDnyBAao1iI3ZJqQNZRUDUVvht6rjPqyZWMtg4WUyQbFcj8pfQ8TsiqilhXxKf+z6tsn25Q/ToXwyTSGRSozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5rp0geeAUM7K6J3eN5zzoQ05HiPmeE9AHP1llgy+1w=;
 b=FgirNQCXVExifmUdL1swrvXtdeSwaFZwRJZVNuBFLdReH57WiGASs/w74UTjnAUzUrh/bXgLMuDVMXR74ELva5yzf5N/pU2BzDCEeEouwXDj8IrtyRUsesCXWxbQgZM2YQP2mWGJpc1tD4OH1p8t67vVAxhzkbpcMTQqbDaZYfDJsPfnebM3sLIoh8z2IieyFfOB2TOMBnerkLnsedkBu4yCa8FmCD56SWnLKhDj6hNybvR1bJUcrhUIVE4UsiLNDpU/8dJFaske4AQsg6tdtiCvbaO1EWM+rsbIzdWXuw4PYjEPQZ/6O+xik6cKlp4DVKMmukEZrrK5e4/582zqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5rp0geeAUM7K6J3eN5zzoQ05HiPmeE9AHP1llgy+1w=;
 b=rKcZP9E6mJK4HRuiTuJnCKNcJhrkQ/obN4tMbyaPgo36rfMQxqnoPP5O0WUKuEAmynWW2551bTPLybSBUHVnD4wEzApcjf34DqC1ybS5FwG38YEYUNwy2ETb32nWcNZ518o/prjSIss0RJ+HgkLHrooQiGJmfi+yzYMCuFHHQPDr/eLHPseaIxs+t3CU26VZRdQu9mTxZwW2qGCqX3E2XKZ/6CL0mVV87YMqVqaMtOIjvtOyOfvukwzlAb1+KSLWeHRkFPZxcgCH9Pnwfz6WOJRjHqhiyDdk0tecxq+0/LIKq2PPRRpPrAKC80XOM3DJ8lEYwMBm0bAg/u6GTwGL+Q==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA1PR02MB8656.namprd02.prod.outlook.com (2603:10b6:806:1ff::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Fri, 2 May 2025 09:44:25 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:44:25 +0000
Message-ID: <3c643be2-a21d-4269-8d2b-3db3a77ecf1e@nutanix.com>
Date: Fri, 2 May 2025 10:44:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_PAGE_PER_VQ definition
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
 <20250501183628.87479-17-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:205::14)
 To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA1PR02MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: a92e3746-38a3-444e-fb3a-08dd895dec93
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekUvMmFWYWczdkcvTnhENkMvWlZJS2QrNXdQNkhndksvWjE5WnU1NWp3djJC?=
 =?utf-8?B?aTFRMVc5MEtUbkRJYU42amxJVktROFRhblpSWGRMRE5CNk8zV08yR2tNaXln?=
 =?utf-8?B?cXluN25oNTJHMEwzeGtuTm1YeEM2aEpLcEoxYjdRdVNGWkJ5MkhjUklmNXVJ?=
 =?utf-8?B?U2JpanQvR2FkZ2hhdWtjUHZyUUJIVjVEQktQekJ1ZFFHK1c2ODFrR2NWVlNx?=
 =?utf-8?B?bjd2b05hNk44a1NzVVRRM1c5ck9GZ29Sak04dEh0SU4zSlF6S0J3ODZqQ3lz?=
 =?utf-8?B?ZVoyZko1TTV0TGVTcm91NE4zeHNKRmdkb0FTd1M1V3VaWXNUT3BxR0RiU1pa?=
 =?utf-8?B?RWxvelpxRVdSd1VCb0d1Y1QzelA3R0RDRWlDU3I0VHc5dWpZOGRhMnR2TlIx?=
 =?utf-8?B?ak4wZ0djZ2cvem1laU8rTTYwM05sM3RvNEpzV2srTTJTSy96akZDdWE5UDBp?=
 =?utf-8?B?ekVDTWtaRFpRZmRXbkxaNWdTWnFpUFRrZ3J6WjRIZEtEWHVTSlVGWlFSWkVV?=
 =?utf-8?B?elhKaE1DTE5xZVNqeWNMUzVQUk5WdkxlSkFXdVN5c3RPYitjSVFPMGYrT25q?=
 =?utf-8?B?T25WaUZEWGh4dGZQOTNsK1NkM2t6WWh4b3h5ckVGalZZbm9nZDVVOFBFVkkx?=
 =?utf-8?B?aFpjbFpNQ1hQdDhnYTRwQlQwcFhxQlZTQVR1bkw5dytYS24vU0pxNGVyMkx4?=
 =?utf-8?B?cTdldE9sUXJLVkNsQVZZcVUxeVI3UVlrbFZ4MUJ5OGpQVzVCdDNvczU1amRv?=
 =?utf-8?B?bEVSVENQUWRjczFaaUg3Syt6dDRJM1pTWHVRMmk0SjZSUTlib3VQZ21OQ3M0?=
 =?utf-8?B?dEQ3MG5CTVFjVnRqQWlkQXhUeHJ4aEtqVS8xakpEWTYyVGxadVMzZ3Q0U2Fm?=
 =?utf-8?B?cDdYS2pNQTFmRXdFMUdJYVVaWUZveDF6bzlFSGhUajliTU5BVE9MTzU0cGZB?=
 =?utf-8?B?UUlRL0Y4UDV5anRHSmFaUVdENXdkckNEQnhJS1F4MkNOY1dEb21XRkpHL3d1?=
 =?utf-8?B?WDV5YmpONk1kdDZrQ1VQdHBWcFVIeGJBRGM4TWR1RUJDWkI0Z3VTOU84ajRr?=
 =?utf-8?B?UHVYcm02RFgzeG5lVDAxSWRHMmY0TUgyZ1pBbHB3OU9kMWxGdUZTbGR4cWJu?=
 =?utf-8?B?dFBobU5sWjFoc04vMldPVTdobFlCSTFMYWlnU2NId0lURWRHYkMvam1DbENq?=
 =?utf-8?B?UGdBb3c2WFg3KzhRazFONm81b01jUk1hSUk2a0lDSHFWSUQ5aVVFVjBsRGto?=
 =?utf-8?B?ckIwdE9NOWlqQ2pMT21aOENpeFdOL1VvYXdjV3pWUHVMRVMyTG9WWDJLc1RV?=
 =?utf-8?B?UlgxVVdvMi83STdxMVp2RmMzbitFY0VoUVdpdHBCNUt1KzZ6Yk51N2JaSmhE?=
 =?utf-8?B?b2NNdnZ4RlRlLytMR0l4RjFRR2pqMkxtdGJsNXlFZzNXdFhleU5CZGZDVExB?=
 =?utf-8?B?SkNVMUs4R040bk1aaDN5YWFjbmtGQlU0MzNnYjh0eVFzMy9EVGFIRTJzVzlh?=
 =?utf-8?B?amwxczEvWm1YMUdrSXJCZEZtcFltQ2lva2ZjaFB1ZVZubk8wSXlvejNkaVhv?=
 =?utf-8?B?Ni8vOTJGUkQyYXlIQ3FDZ09UVTh6TGY5akFzQzJMNlFrdkNmdTRNeFArNk52?=
 =?utf-8?B?ekc2NmtlU2NzYWZ1eklORnNhb1dISm50TVVGcko3K1dGdEtHNDROQ0hnOEsz?=
 =?utf-8?B?UFNlTWVDTVhKWkJQbno5S3ZpUEpiaFZrQ1ZxS1c3bVM1NVNTbWhUc1FqWFpo?=
 =?utf-8?B?cmNjNVZmcDZkS0lpQVhyZk10T2VtM3VjTGI5SFUva3RKZ0NrVjNzZGRNMEg1?=
 =?utf-8?B?a215UzNmR3hFU2puMy9mbWRKYkRCdVVCeEg5Zk51L2RJNlFpekNmWGlWSzFH?=
 =?utf-8?B?SXJOdHB0dFBEbHlkZzE0SnBpSDMrS2NjOEE0N2RJU1JlRXJsQUxnRE1Gb3ND?=
 =?utf-8?Q?yDmL2is/DuI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXplaEhHZmJPdFkya3FpMDA5T2JnSFlMV041SDBuVGhoT2xzTmxUOU5XR2NL?=
 =?utf-8?B?VEcrL1REYXhMajNpa0FQbUFzK1FWd1BZRDlKaWV3ME02c29ydU5ObDJObFBh?=
 =?utf-8?B?U1A4UFVkQ0drazNSQnc1ajNwNnVYYTRpeTdsZjlLK3Bxd2NWQzZkckNyVVVU?=
 =?utf-8?B?U2U1dlBwYm5SeG5LWnZZMEtabXAxS1dPczc2ZUk4T3MrOVZIa2hwMFhqZGEw?=
 =?utf-8?B?TzFFZlE3OXdhdHBwT0cya1hzelVUTDd5WU0wNjVOSFh4VllLanVlN2g2R055?=
 =?utf-8?B?OHhJK1lMcnNWNXgyOVdKWHlaM1NrM2Fmd1MwTkJRNGtQbGRuVjN5T1pYWXJC?=
 =?utf-8?B?ZDkxZkZBbG04bFh3S3NxZ1BtSndrN1crWFJLMHc5VHQ1K2Nidmd0M2NrZGhq?=
 =?utf-8?B?bzNhYjRrY3JPMXZtOGdScGpKbTBHejJwR3VKV1p1UFlxMlgyK3BVZTZNT0lQ?=
 =?utf-8?B?bVJNOFMxR0hCcm50d0FzR2c0YTZhKzFnc2RBUEllVWdzZWpoRHJJTEtLOXZy?=
 =?utf-8?B?TjRsQVFnTUozdElLL25GMGNlaDlydFo3d1Y3MXV3Y3g1Nk1JdlNkOENxTHZj?=
 =?utf-8?B?aldpa0tWUVArTVFZd3hWcHk1c1RUbXY2dW1VMUMvWTg5MjVTRmtFVUlvNi95?=
 =?utf-8?B?ZWMrZk1zZ2dsQXZnMVVCZ1BrRVc4U2ZpRys5dTNiTVhnTjhZMTRHenBnYmM4?=
 =?utf-8?B?a3NLYWRZTTlWM3U0bTd2ayt3MHF1UVpyK3pQOXluV2xUNGJ1WkJIa3RMOWhk?=
 =?utf-8?B?QWNRUW9OZ2ZVOXMyYjVza1pvb3dJcW5pandmek5md2ZjaEhpUnNsckxtaEor?=
 =?utf-8?B?TFZlR0o1TkNZakhXNnpBRy9SbU44em1LVUZXSWFRL2NyTHRqRUYrSWhrMmMx?=
 =?utf-8?B?N2c1bzBNdjVMU0xWYXJSb0ZJTkNUR1pmYis2U0duWTBoWVk4MGdSekZnOHpq?=
 =?utf-8?B?MXA0YVIxb2h6RFRBM1BsRW5nSWI1cTI2Tlg3eGVDUXJVbzdiTUpvR1l3Qk8x?=
 =?utf-8?B?eU9OOFRialB1ZzVyMjVuUVVBYUxPMm1WdGNlOWgrWHc4VXhZbmwzWk1ZMU51?=
 =?utf-8?B?UnZ1cnZTdmUvMzlzRUd1U1VVT3dVUndjVjR0UW1ZdHRsUlZNUW1MTmlyMWhi?=
 =?utf-8?B?RllwbzBIV1BiQ0R6U1JFVGxxVW5oUXc2ZWhyWXp2cU9oUWFPaHdKZVM5STR1?=
 =?utf-8?B?YnhYem1xTEZWUHJIN2YyK2RlNHB2T0FnS0lPRDZCZzQ5MzJZK29rN3RwU1FR?=
 =?utf-8?B?d3JUdiswWTVudk9ta3Y1MHZUMXN2NFZyTDdaWHBFWElRbHlWZUpmd2lzLzdI?=
 =?utf-8?B?MVFORmxxSHJkZWFnaVNCaWFYc1NteWdIMzloTHdTbGVQSVdnbUtQY0RPQkx1?=
 =?utf-8?B?U0lhNFY3OUJuUUxHQ2JkQzNINU15N3dGeE1xVkl4dEhxdU5SOUU0Z2NsY1dH?=
 =?utf-8?B?a0RVOEtVYk5EZ212WUVqU1h4RG1CNmlYZVpqWm5EQkJHbmdzSVRFVklSZjla?=
 =?utf-8?B?dGhEdkZaVFFPTXg2Uk5hWWhrVWdYV0tENTRBSFNCRUp2dUVRcnNqR1FWcDRB?=
 =?utf-8?B?WDJCZERuOFg5b25ERDU3NE5HUTlVWCtEbGp3VnZVa3pYcWVQT1hDUnpFcVlM?=
 =?utf-8?B?NE5TOHVqWUdOdE5JbDM5eWIvN2JOMkU0ck5VQWNzOGg4b2VJWitwaG1uRDZZ?=
 =?utf-8?B?YWcxUkdRbjVqZlUvWC8wTnlUNk5ka2s2dkZ2TWVLbmZYeE9QUmducU0raEFS?=
 =?utf-8?B?MFQ2R0hQK05jRTQzSlYyaTlXb2VHTGQ3ZTBQY0lrdmZsYUlLSEVNWndoR2Zi?=
 =?utf-8?B?RURiSmxjeWV4K25lb3F4NUY2MWVOTlZIK0xDZ3M5U0w4RHlhbTN0d3l6Smsx?=
 =?utf-8?B?b3BqQmtYSU1VRzVLVXc2cE1ZTGdKeWtOb0IvOWlZRzEzZG8zSGFyVnpnV3NQ?=
 =?utf-8?B?WlpSNmVtUG5IUWo5YnZIUFBxNGh3MVlYSS94dFNCVldoWTdnRWpyV0tUTVhL?=
 =?utf-8?B?emc5anhraEhIUVlJM3oxUGs5OGVVa0dySVVnTEJmQmVBZzk3OU5sSDJVNmhV?=
 =?utf-8?B?UFN4L28vZVJUQzVPSW5GSS84VkUzZFhZVTl0cnZhQ2NkekE3MytqZTFHWUEr?=
 =?utf-8?B?WWovSElZaDhHYTdBUk9nMDEwZGdFMEhQazhEaFRYSDM3UjB1aWhqa2hDTitt?=
 =?utf-8?B?UllvMloxbjQ4TklDdXFTNkhLTVZVeUE0V1RTclptWGhjakREUXFNMXZXWTR0?=
 =?utf-8?B?TDNCR3lBUDJza0h3RnVvNGdUVzJBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92e3746-38a3-444e-fb3a-08dd895dec93
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:44:25.2585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgIipHlDog7NXWW0V4amj/reFsFWjA8S8/8ZWajoD0j/tGbISFXTkt1FHpNgJ8vCFDffdjJzVzBlPTL5/Sqa1/kcA3PkGi4jSAXBHwqfJ6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8656
X-Proofpoint-GUID: HN1daOzBf5vFs2AzBgHui3uRpdR6X_Tc
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=681493fb cx=c_pps
 a=QfxD4CzqCnNUzUqh5S/TIg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=SeSAl7b7DJ6GKzseXcAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3NiBTYWx0ZWRfX/srTlL2iA+kR
 YpPyhjuZztnINqm7LG6KV+3sERp4YKwyIqBtWH9tzDkaFU5nxmAstgz2IOsNjaV6Kn9ecTLg+ON
 pRG8jzmi1IMG6gzeMoMEpW7ncwElvgKwn7mbIiOAdpQy4poySzSYGjQYB5e+sXVa3iHCXf43k4z
 45H4/iJx4NxsyinsvedeMU4kvl4MS9lsEG5tlLpG6yDozrvar4TEvRajUZ+u5ELbziXkGGN9+xF
 RYyzTLhlBRpVYolMKz3WlJwReGJgJu9IJh85bcrLpvpyLx71KK56e/2VX9RWAXH4N9kYL6i7GOd
 lNtfDgnBb2/4EJiEXtzVMDi4sepIn4K7HOAw0j0AVaAzn/3LlU+SpQA0+1DgUfuDwWqjeyU4w/D
 wJklq+UQM+/1JYOTL8ZQYNoqioLVvzs+RAyIx96EMNQ9e/XmIQLXrX/cyFV640DVYS1VIiz/
X-Proofpoint-ORIG-GUID: HN1daOzBf5vFs2AzBgHui3uRpdR6X_Tc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

> VIRTIO_PCI_FLAG_PAGE_PER_VQ was only used by the hw_compat_2_7[]
> array, via the 'page-per-vq=on' property. We removed all
> machines using that array, lets remove all the code around
> VIRTIO_PCI_FLAG_PAGE_PER_VQ (see commit 9a4c0e220d8 for similar
> VIRTIO_PCI_FLAG_* enum removal).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-pci.h |  1 -
>   hw/display/virtio-vga.c        | 10 ----------
>   hw/virtio/virtio-pci.c         |  7 +------
>   3 files changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 9838e8650a6..8abc5f8f20d 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -33,7 +33,6 @@ enum {
>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
> -    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
>       VIRTIO_PCI_FLAG_ATS_BIT,
>       VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
>       VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index 40e60f70fcd..83d01f089b5 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -141,16 +141,6 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>                                  VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
>       }
>   
> -    if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
> -        /*
> -         * with page-per-vq=off there is no padding space we can use
> -         * for the stdvga registers.  Make the common and isr regions
> -         * smaller then.
> -         */
> -        vpci_dev->common.size /= 2;
> -        vpci_dev->isr.size /= 2;
> -    }
> -
>       offset = memory_region_size(&vpci_dev->modern_bar);
>       offset -= vpci_dev->notify.size;
>       vpci_dev->notify.offset = offset;
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 7c965771907..4e0d4bda6ed 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -314,12 +314,9 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
>       return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
>   }
>   
> -#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
> -
>   static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
>   {
> -    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
> -        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
> +    return 4;
>   }
>   
>   static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
> @@ -2348,8 +2345,6 @@ static const Property virtio_pci_properties[] = {
>                       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
>       DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
> -    DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
> -                    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
>       DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_ATS_BIT, false),
>       DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


