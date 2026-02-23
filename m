Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A64DEA4FBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWJK-0001y2-Nc; Mon, 23 Feb 2026 08:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vuWI9-0008Te-NS; Mon, 23 Feb 2026 08:48:09 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vuWI7-0006z1-1S; Mon, 23 Feb 2026 08:48:05 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61NAsW221384749; Mon, 23 Feb 2026 05:47:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=sFidcEgJt/JCxh7
 KpHlfO0h5T2+j0q9DYmb0cms4ehM=; b=EJL9RxJenvpSdYfUuM5wxVBAPpDx2x/
 5NL3q0+ciWIZG2U+vrSMu7qZMxC4klqzCgUDBad7Yp0E3UftjHHq06sInR0mrbKT
 2WRQqameH9EDECNN9SxQFMFn66f6Ahlz+DuDwSHfj6owIs85cwv1hTTBASEdZMw2
 mHEWsZ5x6RfqGY8huNQoNpBCFrPMclIQgik4r2mr+Z9OoyZP7Qwlxw0c7xQGjLgk
 aM7oN8q16IoTOeEbBOgqagn4Djq2fUkISroMh8kl8Rd4DG8CYWterMLZMQFKijA8
 M0OOL+TETBuopi94Y3ivVTJ7izlaHIDv8mdfVaWm5vWOTb4SDCLjPcg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020096.outbound.protection.outlook.com [52.101.46.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cfbpjknkv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Feb 2026 05:47:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMZc271oJp4J8dvJMH0Mvdq2jPbdEadrMdl5hKdT254ez6h6FuYoWlbdHEHahfemy/4qxUulIhff5WAcyioa4nSqAOy2Q9RBEqAuPuedDC/2pRCTOxQ1LP0gc5j7H8N/wMo7qWhd9ZGQA7AQixImFUnQ9/vDhtLu7fuGWJDElhhTJiHIe5YeKCsoAefI4O7pSYfXZLnIlOi5uew0CTvIaMeX4o5OOp2XDUH09g+nRQAkSyDpqpSq9snPrPI/grDY2kmioN5OZ57DvTLhsmWRQ4fZcKyUwqVrMzWJ2+tQmemjwMoG9JGss0idATV7zntdTj32bdnnLSE/Tp/AZmqewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFidcEgJt/JCxh7KpHlfO0h5T2+j0q9DYmb0cms4ehM=;
 b=t7CDqciHqwG/UqOWp9n8bt5LhP5ix33bv2rjxMRBIwcCxUXgq+2zT6MG+B7S5kPU5jE8niqNse3hV8lJOKt/7JAJZl32W2oiOwdje8L8tiHcfJNGkGdbyx5bYISt2vmeE1kbf4R7A9eaeTfz99N64fd2uq+7o8VyNcmZ/NHTb51hocpXcYtPNxyWH9xd9wDOwRGggcxdsIbVTaxPXHJRVHW9dxYH7+6fuXt1YIcb5oHY/gL7qvBeBBtAaWpZKj+MIxwZtomftuPqC55u8W7uoILpsK0BIR4GJEFSnNALrGXiRSdfVGK0Y83AfSKhrmFZih7BTbbxgSDU61RsaWia9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFidcEgJt/JCxh7KpHlfO0h5T2+j0q9DYmb0cms4ehM=;
 b=eNumSAgD1VgDA91r938vpI56fSV1OvkWpHDp8MPeQz1YzaSIeVHEox8x7Jgt3zOvtx0rHQ/gdIQyxy5ZhjUukTJ0q37tFsC7Ot8ky761at4RgPCxHyqoOzYMrbG8tZuU57oKMgPs7I+kli1RFq4gvTDUWnqgSbzYv5ApvWZMvK+Zf3dGwEKcxX8W8t7ZUimniDY85oYYfO0iNfTl58ChkTfCEZ8x2aE8ImOTJdiucfDRTZSly65+0Dy670550aEcgrRwBxi0WVFanSFT/ZNkaGDdM7HhO1Gfzmbot7cvOMd20P7r7MQcDr49sW9VngqZ1FxRQxXqMjTm65VMWkdjRQ==
Received: from DM5PR02MB3831.namprd02.prod.outlook.com (2603:10b6:4:b4::21) by
 CO6PR02MB7635.namprd02.prod.outlook.com (2603:10b6:303:a7::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.16; Mon, 23 Feb 2026 13:47:44 +0000
Received: from DM5PR02MB3831.namprd02.prod.outlook.com
 ([fe80::b0ba:9ac1:4aed:805d]) by DM5PR02MB3831.namprd02.prod.outlook.com
 ([fe80::b0ba:9ac1:4aed:805d%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 13:47:44 +0000
Content-Type: multipart/alternative;
 boundary="------------Hk08N6MiYdTyfrdaaAH0TjB1"
Message-ID: <84b3b9fc-d448-4da3-b76f-de72c4e775fd@nutanix.com>
Date: Mon, 23 Feb 2026 14:47:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260118215945.46693-1-philmd@linaro.org>
 <20260118215945.46693-3-philmd@linaro.org>
Content-Language: en-US
From: Lucas Kornicki <lucas.kornicki@nutanix.com>
In-Reply-To: <20260118215945.46693-3-philmd@linaro.org>
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To DM5PR02MB3831.namprd02.prod.outlook.com
 (2603:10b6:4:b4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3831:EE_|CO6PR02MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1fcb80-5c8c-474b-f324-08de72e21ec3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTgzZUU0USsrMVpMUVl5UmR2WkFObHR1U0Nza3dxdk5qRUV5TzB1bmxNRUdt?=
 =?utf-8?B?Q2x1bVVDUWc1SS9yUDNCSU4vVHZ0YUFOR2FSMDF5RElxenBnNTVUOUtqM0oz?=
 =?utf-8?B?UHg3RnhUcDF4R21zYm1QS1VsUnFvcjBvbmlWYzk5RlFrcGQ0UmFwUFRJS1Zq?=
 =?utf-8?B?dmFpdWlveHVGUEtuRnJ3Q29BQmpGWUdIMGU1YkFKUjNBcTFCWU9HaXllbnhr?=
 =?utf-8?B?V09HSkl6Mmt3azhFYlJXMWtGWGJSWDBGWGpHcnhOVUJ3Q3BmNGpESGxjaG5H?=
 =?utf-8?B?aVJ4VndaYXkyN3NjNTJ6WS8zMW5QSFRUUUtSMmdLcXdzZkhMdTdubjhQd2pz?=
 =?utf-8?B?QXVZYjZ1L3FCamMwZGhQQWllY0RQOGhaUGFla1JoS253OCszYUFyVU5uVzlU?=
 =?utf-8?B?QVFSU1NIcXNFSm92eE9BU2k2ZDMxNHNJbjVqVDBXQUZ0cHYzOTJ6L0pLbGRr?=
 =?utf-8?B?dFRUZVFUc2svTWxVTWVmUHZuRU5DT2xaeDIwamtuY2JTNmJjR3RZVWcrSm96?=
 =?utf-8?B?My9raFpUdG1ES3JyUlFOWFIwelFscmhHVldzZEZIVFVtT3l0UFgxcWZ5UVYw?=
 =?utf-8?B?c2s4bVgvZUJ1YWlQK1lpS29mUk83cm1rU1NvZi9TeTYvbkYzYnB6V2V2NDFH?=
 =?utf-8?B?cHYwQkVJZjhjbldxU2xDOUhUUjFjeE5rNlMybWlibVRJY3h0VTZKSDFNcEF0?=
 =?utf-8?B?OER3a0tDSGw3bDVmM0VzU0pmdFRlbXJGVVdKY2FDc0VHb0d3eVpsd1BkVEN3?=
 =?utf-8?B?cDgwVkFPM0h2TlpDamhKSE5ybXlQY0pjNFZxWkxkb2EwS0F3M0RwSkI4THBO?=
 =?utf-8?B?Y28zUDlyMVNGQmlVMFdLTTFyQnlWZ1YxYjZiWVBtTGwvLytmdkFLL3dzV0w1?=
 =?utf-8?B?OEFkUnBEY0xyeVo0ejBIQnNEdFFVc0k1QnNITkxRRUZzTUloK1hSU0c2aVk5?=
 =?utf-8?B?UVluQ0hydHlwUERVRjFmVDQwdFdYbDR5b0NIVVo5SVN6TS9RaUNTbVpZT1Rm?=
 =?utf-8?B?eW8yVlpOWW1QQSsrTVdnSzZpS0x1dTBhM0Q0RWkrSnNaRFdhY0dBeHBRQ1Ar?=
 =?utf-8?B?Z1IrZENPK2lGV04rVzZUaC9UcTJod2lIcWt0M3VJbm1rM0RYdzc4eFpzSWRi?=
 =?utf-8?B?TGF0aWVrdTg2UVhIUWhqWitNZFlWYm9sYjFyTTA1WmNJK1RuNjBjbTVzb2Nt?=
 =?utf-8?B?eFdHdGdFL1d2bG5WakxzeVVGTWJhcW95MnR0Rm8zL0xDcm9jR3RMOEpVdlkx?=
 =?utf-8?B?ejgvYVVyVktudEpSVmk1emp1OGNrTEd6c0cyRTd3YW0yWC9oalk4bjV5cTF5?=
 =?utf-8?B?bzBOa2VUMThKcmUvUGI2UzR3TzZ4eW5ZUFpaSXJNTFRXMUllY2ZKYjFZOURy?=
 =?utf-8?B?MUhDWE95SktUcnNQeFNGQXRzS3ZoeGlkK282RmhKTEd3Y3VsdGFta2RoWDFx?=
 =?utf-8?B?YVEvd2lVSStGU05MY3gwLy9IS2xMbFJFVDhNNURkaWovVHhXNjAwczY1Nkk0?=
 =?utf-8?B?bkc3WkFrMmJiWUp5dkh6dy9lTkhrVkNaZlQ3bDh2VzZaa0FOcVZwSldEUDRj?=
 =?utf-8?B?R0c1TWd3WkxZYUh2REVCRjkrQlpsdklDYi9uY05PYS9JUVRIYXJLT2FaQzgv?=
 =?utf-8?B?VHZObTllNXNwMnhmbWVFMWYzU0ZpQTJwSkxVWkxPRFEvR1h0cjhuSEVtU281?=
 =?utf-8?B?d09pNHcyK0JCWTA2ODdGRjhqSlV2M0hyWDFTTER0Vit3cVpnaElOampid1BV?=
 =?utf-8?B?a1MrNjhjUkYwMzBhbGE3dDJ1Z29BejFxT09WdC93R3dkSGZscDk1RzE1TlUv?=
 =?utf-8?B?aTQ1cHdjbEFOeE1nZzBRbkEvVFJUNHVaNnJGSU92UVNrdVZLL2JsdDB2UkZM?=
 =?utf-8?B?TCtyaGk0UGEyVVY2UmxWQjhkd1lKa1pUWkM1d2xmSHZXTVpVRUt3YUx0dUdC?=
 =?utf-8?B?Z1hrUU9YUU92Y2VBM2hxRlBFVEJWOWNDNysvWkcrRC9pZkZ1RXgvdkFJVVZJ?=
 =?utf-8?B?RmtUd0pJSjdVOVpxdzVCbXdsMEw5dDFJbEdlU1h2ZCtKUHU2MHFnZjhRQ1FL?=
 =?utf-8?B?TmlxK29MT2Nkd2RaRlMxeTN4TDhRYWkxWVRyTTBrd1FkM3IrekpvVmFXSjlr?=
 =?utf-8?Q?wcF0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3831.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVVaWVrL25OMTd5ZTRTRTFCNUFKY05hSitscWEzQTlGd09WcktlaVNPeXRn?=
 =?utf-8?B?ZWh2eWZrWTU2K0JDSWZlbnRNU1RJRFVQV3h0cGdxZGgwcTM1NkNINU5TNUg0?=
 =?utf-8?B?OUoxTS9WT0M2U0NLZHZqNjNPbGVmRkpCT3IxNWgzb2pmV0dxTTErVTB6MXgw?=
 =?utf-8?B?UXd4RENUdUFnMG1DUHVpZGp1UVZZS2NaV0czM0VVdWJYSjV3cGRqNVR5Wncy?=
 =?utf-8?B?cldCL2tJY3ROUDdxVGl6TTdXcFJ1NGlYVndnZ3ZoRm1paWZXZ3JYaHVLSEN0?=
 =?utf-8?B?ZUwraVBwN0tUcTlHWkVNY0xqc3pwbU9iRWxGbHI5ek1xdHJqYmp2UVU3R2NG?=
 =?utf-8?B?VTN2dFFDU3BUdjlsWTZiUUMxUlJ5dlUyQ205dFMwK1R2MXNRNTd0cjFMdzRK?=
 =?utf-8?B?d3ltWXJvZXlidFRHSVp5QXB3Q21jZW5QWjFhcWxZdjl1ZFZnQnE1VDZKYTZR?=
 =?utf-8?B?YzZFeEVEdVdYN3plU1RSSlJKUVlqQXR6TmpreFEvckxqVm1GUENSa2k0dHMx?=
 =?utf-8?B?M3lwRUlmWXVFczZRWEhPSjZQL04xdytYUDJqWTRuSEt3bzV1d3pndTZ4SFIv?=
 =?utf-8?B?RjVKVy8veTg5YURjaEtEWnRzYkczTlZwRUwwUk9Ic3YxRldKZE1mRXpEcnNP?=
 =?utf-8?B?Uk5qdnU4bmZZeGxvOHM4LzlSaWY5L2pZWTIzNkVFem9mZW1qejBDc01uclBD?=
 =?utf-8?B?SDFtTjdyQmw0K0dCb2h4L2lLR3VCSEIyZ3Z5MG1LYTF5Mm02UWE3b2RPVWFT?=
 =?utf-8?B?NEhCQnAzeW9EOUE2dlo5VEw5L0dsUVVVTnFjMGc1c3VwSXpZOUh0NHZGMTdW?=
 =?utf-8?B?MUpKUVlvT3VMVjlTMCtZN0RBT0hhL0dsNTRIRVBwdU5iYis1eXdEMlBvYW83?=
 =?utf-8?B?emE2K0U4RlJJdlFlbkp0WWo1a0tjVVl2UWVRditoc1F2Y3VrZ3hXQnRFL3hL?=
 =?utf-8?B?TTBKKzVSa3dRSG93WlpkVklpbWpOLzdHaGs5NCs4Uk1ZL0p3WCsxdWx2SXpq?=
 =?utf-8?B?YkpDYUlFZDVWL2RJQUZ6MlVaQ0xQN1pURFBiMkgwbk1TbDF2aG01ODJsalBU?=
 =?utf-8?B?NFFrenRVU0VERjFTRVlWNW5QQk9NK3VJVmpPZ2ZIWFBYUS9GYzVxc1JTNEg2?=
 =?utf-8?B?NEZndWMyOUl6RjBiK25FbnNHK2hCdlVUdG9wNTFZVG91dG90VVdPWWtvVlJZ?=
 =?utf-8?B?ZTNnQWdpRzQwTVdtRjdxZmpDS2hZOHgzdEZRT1FjSEU3QzNJY3NKUWxjMkdU?=
 =?utf-8?B?TzBVM00vMW42czNiNXMrVTVOZ3BLU2lCbmlZN3g1NFRVN1VtSkpaT2RZM2h2?=
 =?utf-8?B?N0cwMEdkWlh6QzBZWjRaYmQzcWMxRXUwdUx2Z3h4SElaOHUzRU8wT01ZMXhh?=
 =?utf-8?B?NjFCbmgyYitsaWZuNDBtSFRlcXlhemU2eWNpVmZvVHF2RzhiOFZhS0ZJRElD?=
 =?utf-8?B?QVhMTUR5RjJKRkhDRG1RV1JDeEl4WVpDQ1NHL2pUNHJ6dTBJZWpEVWRXdHFh?=
 =?utf-8?B?TC9GM3FrUVFtZHpac3MrU2twcWRzeTN0cXBUS3ZuMXVSVzNCNXdWd1pqL0R1?=
 =?utf-8?B?YWlza1RyWFEzbnAvK1c1M0hLZ0c2SGNuZlNuU1FwdWdQa0E4MTlheThFQi9E?=
 =?utf-8?B?ekNyTmIyYkF0c05RM2N1YVgzNnhKdXRxa0Z0dnZtME5jSmRqUUlSNzRnQWRG?=
 =?utf-8?B?V3ZMaVVlTkx5UEZKOTVOTzVqcUQ3enFrQ3FVZmc5aVBkalowY084VXBaT0dR?=
 =?utf-8?B?ZFhJNi81VzdFaUt3YWRTMHVkeDJaVDNkSXUwTS93UTRuS05DWHJ3TkNKUDM0?=
 =?utf-8?B?Z0xPa05vQk4xd1VTM2pLMzJjcUxnMllMVVZWd2NPZUJHT0F6cCt3bTFwa0Rh?=
 =?utf-8?B?Nlk0bnlZQ3VlNkxEQXp0OXFNQU1MNVkxU1R6NkpnN0ZDeUJYamo2VXlmdXAy?=
 =?utf-8?B?M3BpVGZ6WGFtS0hnanlQbkthQWNYTGVVRVFPOXhvdUZuUEVYa3JPbG14cy9P?=
 =?utf-8?B?M0dtbFpMMlJVM2JGcDhxb3RmKzVPQVAvdFRpbVViR0s0bkRGbUh6ZVJlbmxN?=
 =?utf-8?B?ZEFIVTVHeExxQnVjcjdhaVJuNnNQL0ZUelVtK2s2M2V0cGRZT1I2Q1V5WGts?=
 =?utf-8?B?aC9jRjZKM3pTQkQ2ZWs0R1JUWWZ3VmZUdi9MOVJuaWIzZmY1bUszakdFcEwr?=
 =?utf-8?B?NEVzelBHbHF0RjB4V3EzVG82dWhrTktQZjV1T3dEQ3lEZDVpUElTdVl6ajdi?=
 =?utf-8?B?dTJ5ZjR6NTU0anJ1c2hKSEJFUlNJMlh6dnQ1MVRFTDFrekRxbGF3QWpDZllh?=
 =?utf-8?B?S0crVHY3SG1FUG9MdkhjSGZGOEJvbkpJTUZZQWlPc04xazRDYU5MaHdCMWVi?=
 =?utf-8?Q?G87DKseuCNRfGQ6U=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1fcb80-5c8c-474b-f324-08de72e21ec3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3831.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 13:47:43.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88122JjjqRzWGW0UQ3gxuto+NKsm4CbJLuHIX4D7d3mzUi+qKBpmfsLzTkpzTxkGJSFr8dydBcwhXOLGv3ncKMHFjlYBC0fFi7igyI8y+IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7635
X-Proofpoint-GUID: zuYXphvjfVEEoXHHKdFn0x9F_vna2A79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExOCBTYWx0ZWRfX74t4sj2rTOFU
 KyHVzo4sa0vTbnum9CqAdyGPdYfOdHx6gGGGoXXCWFZ9xmcpyHUwigp/LEqCD/m774eQMw4TGx2
 arbncy8j0hmBaN6mVOf6hwCStdTdw+yG9iQejkjt2pniNYQuciE+ajMqdIKkWMToydtGVrcYp7C
 JSc/qVTxe3P91BR7WnpRZy/tWthyig2A2HgRdBT48xGwX34khYT+agcsLzh8HQGJPij/cX66nsR
 hyyKDd3878RU1FJ0dECm6RNamhxw8v+YTuei+GPMoHF6k6ln4yfdC+OfI5rBcopLc6Y7Vq1dHji
 nvwWMFswLxmm+9o8CdJdpm7JwCU7rxS1M8cFQglgNv/4+1gKMY++Kwsj4qFtiNyroz6WG2Bc+Dd
 Jr5OjXlEt/M8tNCaWv4kfR4zmTxAQRQf7i95u30h1IMvO6fDDB+y81TrlxRoJd6SXHxgoO6a6PY
 9BB+VMnd/VU9+sxkopw==
X-Proofpoint-ORIG-GUID: zuYXphvjfVEEoXHHKdFn0x9F_vna2A79
X-Authority-Analysis: v=2.4 cv=Jf+xbEKV c=1 sm=1 tr=0 ts=699c5a82 cx=c_pps
 a=Xk0cAt2nCKMrkR9Vo+L1ow==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=KKAkSRfTAAAA:8 a=fFG202kn2beVBYtiD7cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vlzWJkapEg366JrjLlwA:9 a=J4wRDfBh26zhZtQk:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--------------Hk08N6MiYdTyfrdaaAH0TjB1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi. I've found this patch to break EDK2 UEFI on MacOS 15.7
With it applied, the vm is usually stuck on display not initialized, but 
sometimes it will init and hang on the tianocore logo.
I've narrowed it down to

b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);

in hvf_arch_get_registers.

On a related note, I've noticed that when using accel=hvf on aarch64, 
the cpu usage is maxing out all assigned cores even if the guest is 
idle. It looks like it's constantly getting woken up from WFI. Could 
this patch be part of the solution?

On 1/18/26 22:59, Philippe Mathieu-Daudé wrote:
> Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
> host hardware accelerator.
>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index fcb7fa3b30c..9ce720793d8 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
>   #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
>   #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
>   #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
> +
> +#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
> +#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
>   #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
>   
>   #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
> @@ -502,6 +505,7 @@ int hvf_arch_get_registers(CPUState *cpu)
>       uint64_t val;
>       hv_simd_fp_uchar16_t fpval;
>       int i, n;
> +    bool b;
>   
>       for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
>           ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
> @@ -631,6 +635,16 @@ int hvf_arch_get_registers(CPUState *cpu)
>   
>       aarch64_restore_sp(env, arm_current_el(env));
>   
> +    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
> +    assert_hvf_ok(ret);
> +    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
> +    assert(b);
> +
> +    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
> +    assert_hvf_ok(ret);
> +    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
> +    assert(b);
> +
>       return 0;
>   }
>   
> @@ -642,6 +656,7 @@ int hvf_arch_put_registers(CPUState *cpu)
>       uint64_t val;
>       hv_simd_fp_uchar16_t fpval;
>       int i, n;
> +    bool b;
>   
>       for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
>           val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
> @@ -756,6 +771,16 @@ int hvf_arch_put_registers(CPUState *cpu)
>       ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
>       assert_hvf_ok(ret);
>   
> +    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
> +    assert(b);
> +    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
> +    assert_hvf_ok(ret);
> +
> +    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
> +    assert(b);
> +    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
> +    assert_hvf_ok(ret);
> +
>       return 0;
>   }
>   
--------------Hk08N6MiYdTyfrdaaAH0TjB1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi. I've found this patch to break EDK2 UEFI on MacOS 15.7<br>
      With it applied, the vm is usually stuck on display not
      initialized, but sometimes it will init and hang on the tianocore
      logo.<br>
      I've narrowed it down to&nbsp;</p>
    <pre wrap="" class="moz-quote-pre">b = hvf_sysreg_write_cp(cpu, &quot;VTimer&quot;, SYSREG_CNTV_CVAL_EL0, val);</pre>
    <div class="moz-cite-prefix">in hvf_arch_get_registers.<br>
      <br>
      On a related note, I've noticed that when using accel=hvf on
      aarch64, the cpu usage is maxing out all assigned cores even if
      the guest is idle. It looks like it's constantly getting woken up
      from WFI. Could this patch be part of the solution?<br>
      <br>
    </div>
    <div class="moz-cite-prefix">On 1/18/26 22:59, Philippe
      Mathieu-Daudé wrote:<span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite" cite="mid:20260118215945.46693-3-philmd@linaro.org">
      <pre wrap="" class="moz-quote-pre">Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
host hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <a class="moz-txt-link-rfc2396E" href="mailto:philmd@linaro.org">&lt;philmd@linaro.org&gt;</a>
---
 target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fcb7fa3b30c..9ce720793d8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
+
+#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
+#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -502,6 +505,7 @@ int hvf_arch_get_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
+    bool b;
 
     for (i = 0; i &lt; ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu-&gt;accel-&gt;fd, hvf_reg_match[i].reg, &amp;val);
@@ -631,6 +635,16 @@ int hvf_arch_get_registers(CPUState *cpu)
 
     aarch64_restore_sp(env, arm_current_el(env));
 
+    ret = hv_vcpu_get_sys_reg(cpu-&gt;accel-&gt;fd, HV_SYS_REG_CNTV_CVAL_EL0, &amp;val);
+    assert_hvf_ok(ret);
+    b = hvf_sysreg_write_cp(cpu, &quot;VTimer&quot;, SYSREG_CNTV_CVAL_EL0, val);
+    assert(b);
+
+    ret = hv_vcpu_get_sys_reg(cpu-&gt;accel-&gt;fd, HV_SYS_REG_CNTV_CTL_EL0, &amp;val);
+    assert_hvf_ok(ret);
+    b = hvf_sysreg_write_cp(cpu, &quot;VTimer&quot;, SYSREG_CNTV_CTL_EL0, val);
+    assert(b);
+
     return 0;
 }
 
@@ -642,6 +656,7 @@ int hvf_arch_put_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
+    bool b;
 
     for (i = 0; i &lt; ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
@@ -756,6 +771,16 @@ int hvf_arch_put_registers(CPUState *cpu)
     ret = hv_vcpu_set_vtimer_offset(cpu-&gt;accel-&gt;fd, hvf_state-&gt;vtimer_offset);
     assert_hvf_ok(ret);
 
+    b = hvf_sysreg_read_cp(cpu, &quot;VTimer&quot;, SYSREG_CNTV_CVAL_EL0, &amp;val);
+    assert(b);
+    ret = hv_vcpu_set_sys_reg(cpu-&gt;accel-&gt;fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
+    assert_hvf_ok(ret);
+
+    b = hvf_sysreg_read_cp(cpu, &quot;VTimer&quot;, SYSREG_CNTV_CTL_EL0, &amp;val);
+    assert(b);
+    ret = hv_vcpu_set_sys_reg(cpu-&gt;accel-&gt;fd, HV_SYS_REG_CNTV_CTL_EL0, val);
+    assert_hvf_ok(ret);
+
     return 0;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------Hk08N6MiYdTyfrdaaAH0TjB1--

