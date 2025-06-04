Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673A7C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkQX-0003Fe-GH; Wed, 04 Jun 2025 05:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uMkQU-0003F2-HU
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:28:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uMkQN-0007Jy-0v
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:28:50 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5540ZMdf027702;
 Wed, 4 Jun 2025 02:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vO7WwPGgBUvEDQW04g7La6mFmZZECWWGP9iL3KuOJ
 Qs=; b=oqMd1bOaOzpOHauDVNb1n2XbCfPYdIfhrkGtx2UtEyCtUmA/7mhw3wI1K
 urvf5sesSSW6A8LGjle7fEJnduAotMBfStNeRI3A+yQtDU/EOGchwueptUjp8oA/
 ohzC4lHzumWvWDi5N+UDgOaK09PvobnfqbffmbdR8bH2kY9+U79gNvbdXz/1ZSUW
 xag2QX+NzRawoJAACtR7OneBoUaOQLVAPw2WkJ0Lce51+h4E7l3i4vTP1UUMO/ki
 AZEo97NIHPtjHX6IaY6sb1BABWrJmgTYmMGl2Dz93pMYkLPvGq5MhTNDvC03HFZT
 4tYjzi+KB/6r6CylGtE1tha6fev0Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020106.outbound.protection.outlook.com [52.101.61.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 471g80vx87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 02:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsWDCJ7ftuzda4T9IZ+iB91jh2eKyFb/aXtR1WrK/4QtDMvI1WQBoIhDtq3E3WEprD30CtpUtEu75LWYrrL0NuZ50IaGKoJcp249EJI790G19y96PW8ykX7IysffVSnC+qUXsehY3pDitEUz664sF+p4Hg/bxFhCy4exbPHfpYFYRnz0We153mmE//gOclwDQTAkBLlx6+AJ1unKANYCxCssDV69oYuyIkJ/Xgk8ZEYvBPuHih45XjxPBPTp2pb0eglDCeOzIdsSflP2QpxvRowx08aQ6r/3kzp7MWiU41aBLKVxYy1iHZLvLwiUsAUm31L0trwl9nDCbO6rPkRraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO7WwPGgBUvEDQW04g7La6mFmZZECWWGP9iL3KuOJQs=;
 b=sviAlam4Upe6XvVh5sa5XjwHad57Dc5/SkHyo1sF4ORjpZ/RzcWTj7PTc9imj07Ur+InqDuHIP++XRmbjHEHBZ8jhdKqC6vtJvGYmQV78qBg905W25uq15+sLSfzdKyUFclsLa7iVQUiuR7Q9Q/lbZn4N8lKONRnKX6hjJxfuLqvEcZ8hMc2ifR1HT3hODxdsOzkPslARLw36hTGUgwhOUKsRgS011LqXBz6uVvzMpjLk8vZA/faMujP3vf5OJlT2HgChSag7WYEwLBQvZ7njAM5dCzawxxo0UHgLcKPOQ4TQIio9ImYsVO+V3PmsohgDAV1kcjLmKloMAxH2ri2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO7WwPGgBUvEDQW04g7La6mFmZZECWWGP9iL3KuOJQs=;
 b=fa4OcZs7IRtQYWj8QwTnXxM0UJtqv78zOMW1yS2oUt0456Sg0w28mEWWNvNB7p3rL7AAkQ4OfYtHuF5C9T9ySbr0lnjgjCvr+mf/Q9z99YL8VelOSeBZXf0onvu+jGGisWSzOmMg5HBgGioiI67ByuGKuWaf9HVZc0JPmbkw/u9ajxDn4iDTXkrI5mCniuzzw5qagKuc6ceN47f5K15HcNoVYQnOzjVFJVolyZJfb42plA4YmHOwdpkUp1Oy1pqeKd5xbhI0TtuqdmNWEVQRuHOZWZZuplgWCZsgPg799lu6ppjqary8N6+tid6JkOtTF3g41cXlTEQFvtm7zOgGjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN6PR02MB10680.namprd02.prod.outlook.com (2603:10b6:208:4f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 4 Jun
 2025 09:28:33 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 09:28:32 +0000
Message-ID: <2ec415b1-36ca-4170-9168-a027083be0db@nutanix.com>
Date: Wed, 4 Jun 2025 10:28:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a test for the Arduino UNO machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Michael Rolnik <mrolnik@gmail.com>
References: <20250603184007.24521-1-thuth@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250603184007.24521-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0213.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN6PR02MB10680:EE_
X-MS-Office365-Filtering-Correlation-Id: faeb1b39-3ae2-467e-f83b-08dda34a2c50
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TS94YlY3UnJUSHNYdkpnOTk1VHR0SXMyREgrMFM5RHJOTGpxOXlQK3VHVEMy?=
 =?utf-8?B?bG83b3phQ2VNaHI5bkQvMFQ2YkU1alZ1RU1iUE1CSEhRU2RML0x3M2ZZRTd4?=
 =?utf-8?B?UVFQQnhtVGhPdEtaaVpKVEhTZzFxZTlLZVlyNFRWNFFqK3lrWkhRanB0WUNN?=
 =?utf-8?B?SkxVMWNJaHhaTFdnU0FwbzFiZ2VjWU0weExqS3BSUEtGSkxEQ0Fkbm9kR2tt?=
 =?utf-8?B?Y0QwbXpQUHhjOHk2VEFkQ1FoMURVRm4yZEIwaGplNFdkMmhkbUYrMXpRQUFB?=
 =?utf-8?B?TUl6TzhKVzl2YnR3ZzQxQThObVlmOGJ4OUJrSTZsMVNlV08yQk9lckkyTHJv?=
 =?utf-8?B?OHdjQzhJM3A1UmszNThzNVlnK2JlQk91WVZSTWV3NllBY2hPSFdQa0gwZkNr?=
 =?utf-8?B?SjR5R0QzRStMQkVpWlJPRXUrYXVaSXJ1SDd3c1NaQmhPS2xydEdmcnNDaHha?=
 =?utf-8?B?NHBVSnZ3MVAvbVdDSnIybE5wb3IwQldQWC9ySTJ2aHVmUnRVbnhCTE1tMkRJ?=
 =?utf-8?B?bktNcmZsWHU1bituNG9RYzRKYnN0L3VsSE1MVk1nSFhzd0VDemFNQUNKb084?=
 =?utf-8?B?OGN4M0tHaWdSaGJsTjdsaElyTjJ1UlFERFovQk9ocXVxN3krQjB3RGtidGh1?=
 =?utf-8?B?UkZ5bXFvOTArMFJMWEdJc0hHZEhmR0ZxR3VZdmk2c2M1aWFxMGxTd3k0bEor?=
 =?utf-8?B?QzRxa0h5YzlEWjRMTjQvUTJ0YlpjY29VOGVsSjJ5WkprZEg5TWpyOGhOQlA2?=
 =?utf-8?B?djlaNlBWOFBTMUdZbC90T2UvVkNSd1JZSnBwSHQ2UXZBcXFMN0ZqS25yOUxF?=
 =?utf-8?B?cGwzUStPZVhqbktUZG9rVTM4MFVsQlJ2SGI1WHg5MERJNUh5cEhUbEwvZ0Nh?=
 =?utf-8?B?YVlvMFRPenlKWXBhU0pqbmY4MmdGSk5HSVl1a1BIZjFSZUk4aGtYYXFOa2c1?=
 =?utf-8?B?TEU2T29lMTlzdS9jaldrSmtMK0p3cUwySHVoUDJHdS8vNk4xNlUrZ3FNRDQz?=
 =?utf-8?B?ZXExb2Nody95MWRRWGhKeGQ4STVidU85ZzZLYklTajh6V0IyR1QybHFTZ3ZE?=
 =?utf-8?B?bVlLUnpnUTFDUVI4dkg5di95UGRXSmhjaFMvZlRGVmd2SGJ3Tk5nb0FmRU95?=
 =?utf-8?B?Z0EvMkxVMktXQXZzQTVkMDRYNkl2cTVPckZxVDFsU2ZTVWpYdWFlQWMyM2JL?=
 =?utf-8?B?RFhtNkJGeUdFSmRrVFp1UXBVcHh1cCtueHBqeUI4V1BNczhad2JxRkFJa3lL?=
 =?utf-8?B?d3ZaR2IrNXlpYmg2a2pYMzFJRDdtYjdxbW55eEhoTXN1Z0FMRkx0QnIvOU91?=
 =?utf-8?B?c1g4dy9GUW04bU5BQTAxR3JGdmpMaTlhU3NhM3QwVm91aUVEdkZBOWdueEZi?=
 =?utf-8?B?SVBaQndvTXl3TXBCVi84NVdnMEFZeXA0bDFzMG1HNGhTU3dldlRjVnMyUm81?=
 =?utf-8?B?RFN2TE14TXlDUnc1bVhrOEdvZzNkQy8wTjZ4VVdNYUZNQTJUSWRpL1hIaVA0?=
 =?utf-8?B?Ykovd0w3eXVEVVFXREFDcEs2TE82UjBpQ0F2RlBRcVZKd0tzRk5lcWFDV0Qx?=
 =?utf-8?B?ak43a0c2V2prWGVrVFZ1am5oblhWdXphSUtTbDh2YWUrYzRSbWVzR1NJR1F3?=
 =?utf-8?B?SHBKUGpvTmVXVWpTV1p4OVRROTlyV3JrQ3JSYWlPeTJ1UDNWNlN6bjhIRmFi?=
 =?utf-8?B?aHhKTlEraUYyaXc5WFRMUHJDQnpLVzBVbko2T3hSdkdpbEtsNi95MEhYdytF?=
 =?utf-8?B?NktYOENraVMvL29TSEYwYzdSU1FPV0dDd0ZvNzJDb013VnBWWGhwVkl4SEpS?=
 =?utf-8?B?eVBueWwrK2Vld2pJTXd1YVd2KzFJdC9oQTNsUlUwZzZjZ3ArMEdNQjhRWDhU?=
 =?utf-8?B?MER6QXh1SjB0ekFiS00xbTJYMVI1YmdXTVczNzNJcUNWQUZJVEk0djVJeTJn?=
 =?utf-8?Q?54zgbOM3TO0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1p2Nk1wNW1nYzJ4L2t2azJNNTI1L2Q1NnR5d0xmNzViLy9JTklYM0NXU2VD?=
 =?utf-8?B?MTVPZHRQSm9wTXdMUmtnSVRFMHpPTEhRQzdrbUpKU2ZKbGU1WWF0a2dwOVBV?=
 =?utf-8?B?SjhFajc5MDVnS01XczVNSXBzRTY5NGZDR1dzWWNBNUswTkJYeldnako5bzlH?=
 =?utf-8?B?Vi8yQmNGeVc2Z1NGOFhEbzBFb3JveVBDMVlid0Z5TzRySElIZDc1ZCsxWU9V?=
 =?utf-8?B?eFZIcmdnb2ErczdINmo5eFFsU0J1eGxHYll4RStZNEJSSXN4Nnc1S3lKeWxI?=
 =?utf-8?B?c1Q1cmRYVDcvNDZCV2Rzam1hYWZzSVFPckF0ZVdBU0ltMFZHVTRPQzhnOWpB?=
 =?utf-8?B?MTM5NUNES3NjbWYyRmR0MjRKWVNDQzlvNzVHWFowbGRQVTdoU0ZLZ2wyNFZs?=
 =?utf-8?B?SUJRMCtacFVFWUQwSHVZOUh1aC90QUpLN1pmdmUyb0ZBS2hxaTlUOWZiWkZ0?=
 =?utf-8?B?ZVlEb1hLRWFNREQ2d1ZaZEFNWnZxWlR2Wi9FN0RRSHUrUGdhVjMyWWJ4c1RC?=
 =?utf-8?B?SEZmOUVrSzlwRjVhU2xJa25wTDlQK2ptVlhkOWNBRm5Kemh3YzVYbHFoY0Zt?=
 =?utf-8?B?b3ZJTVY3R0RPcUhIb3NFRWpFVUpqNElmZThuNExBV1B5QUh1ZnEzRnVQUHI4?=
 =?utf-8?B?KzNIbWFwR2hhRHBTT2xMSDJ3enA3Z3Y1UldqWWdqT1FKTUZzNW92L2R1ZkhO?=
 =?utf-8?B?MXBjYm4zQWtxd1o5NEpNYjlRcW5BL1g0cmZNWm5FOXRDcEgyYkRJZXFvL2RG?=
 =?utf-8?B?MnU4NmNVdmdEeWNPb3QxTXFNbjljQkgyWXhvTGNyeVkrWENvWm1TMGVVUkxH?=
 =?utf-8?B?Q2VVMWlPTG95OEJ1L1VNRTJlZW1ZdzlTQTRtZTdtWDFTTXFsbGZsL0hpeE5B?=
 =?utf-8?B?TjVyNE5SeEI4N1dyM0ZlRjZ5V2hsbkxEWjR0NGpSL1V4eExTTk1zMU9oeTJk?=
 =?utf-8?B?MlFjMk5VWkh1ZFNXdFNCVndwTWtzRlhOeEovV05GMWppb1NQMmF5NlAxMDAy?=
 =?utf-8?B?Ny9ZSGpnaEw4YUZXMzVPd1J1ZXRjNU5KZzd0WHVjZnNsTVg5K0R2NFNVS01o?=
 =?utf-8?B?TkRMSEJKTzNvZVJrdlIwRG85bVQ0WWNmQmtCaGZNVlZhS1lUYXF3QVd1Qzg0?=
 =?utf-8?B?L0ZvVnpOeDBWdWpFUzlGNk1TdkRYbk1Fb0RZSXJHT3BJRzFRdDhGeXVBVWFj?=
 =?utf-8?B?bEVSUGNIbEJhQnc5Rmw3VldaVXlqQVB6M1YzcEZuaEZBa3BDRmxtQUpPbmRH?=
 =?utf-8?B?NHdUaDVJRXpWbUZqNTVVS3czdU5GN0hYLzJvQ2RlSWhZM3pUU2grTUZoZHBq?=
 =?utf-8?B?NkMzNmJkRENRN1F2blBTM3FrT2NVLzVIUG1ZbnZ2QTVycno5bkE2OE5IU1Yw?=
 =?utf-8?B?TFpYd3g4aW5vUzhVMmRqQm1Ua1RNZUpVcE5PM3AzVkEvencwQXFiOHZjL3d5?=
 =?utf-8?B?cFZCcEtpY2MwME9rcTgydlI3d0U3Zmg3cjZhbkxYemZqYVZvTWhCYmJXaWlO?=
 =?utf-8?B?M2dBL2hINjU5VnkvSDIwMUpQRm5IRlJRSzFNZjFUb043MVNhRTB6RjFuQWJG?=
 =?utf-8?B?WmVyZ2kzZ3lSMFBqMkxYdDA5TnFpbzNiUTY4TXZHMzBscmlzOXZMcGJGRk9l?=
 =?utf-8?B?aERxVFNkMWRMbVl6VVhPQXBFZ2NUcjBPeThhSjczL05rWitWdk5LaVdiTFcz?=
 =?utf-8?B?UFcvYVZWMGdFRFVMRVBxMEtzQVNCRnExT0JGcGFlR2RVdGFRajVPTWNZUFYx?=
 =?utf-8?B?bnIyOThON2hJTjhNSDNZS0FneXp1TWVzb043SHlsVGlyL3pFODI2VTBoa2tH?=
 =?utf-8?B?L0IzVUFKZERxeHZKR3dVTG03eDhqOGxvRGlpNWczU2hJajhMVkRWNjJucmVJ?=
 =?utf-8?B?RTFtQkRidjRsY2EycjMwcW5ZUHpVZWFFYXNBMkdhVjRLU2U4ck9YcVJWSVQ0?=
 =?utf-8?B?YitNN0taUng5OXZSSUZEaTc4VzBZZDErOTRNN2g4ZjdOaGZTeVBDSzFlQjBt?=
 =?utf-8?B?b1FiV1JMYWM2SEY1NmRadzVZWncyTXNsZWwyRUNWdFh2Z2R4WkkvTzhGeTd4?=
 =?utf-8?B?V0s0eVd3QmlFZlVlQ3k3dXMxdkg4ZTY5ZnFCa2UxcCtmb05hZHB4UlNCU3Iv?=
 =?utf-8?B?UU1hUDFiOEJWemo0Nit1MXIvRVhyTi9FaXg1NmV6OFRGL09aVW56ZFNIMVh5?=
 =?utf-8?B?UllsQzlFY0c3V3BzSTRUUVl1WVduYUhzbFlTNDliWEFxQTZQbUVoVjhWQkNM?=
 =?utf-8?B?d0lPbVVzODU0cnpHbVFtZ0dQdC9BPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faeb1b39-3ae2-467e-f83b-08dda34a2c50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:28:32.6870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a2fL/Mhe6loDPSi+jY4OouJpIE1B020AwDvFj8/Dss1svEyVxi3v3xO3gqcXhKGzL0QOYK/1vJsnK8izWIMV51XQYFRtV1XKra7D+dnE38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10680
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3MCBTYWx0ZWRfX56iJ7EZnhTXO
 Th6HWlmi/9wYPH0+wGRXg3fXas76dFgGwP+HO8mcemxiVhRq1BOeknPZ1J8PpZ2PzxqTTDEQNW8
 1ZpNsRfqE1vK/pULbI2vy2E+tmfyxtcimIgT7yf8WgY1UTo+A44pZqGNf3mdevhkUexIWL8ljYT
 ZO5+N4iaJn5gONMfN1Cdv8ln8UK2oINvdvFABmmpL1lseo+0eNzUfKoLehWKBRKbDGKuESjIpcf
 62Dx8ojhgJJAusV3vNNO0FFEkTnsAowcLVlYNoMbvyONzJolW9M+ZMCZa2EGZ7oocrfeLreLIoE
 FRgjXGPSjmPiRLjCDnMjffrKojEhHDb5+iKfU4W+dlbDl8H+Eas5T9DIoKM4HiM8cr21u+qYK6Z
 UWHCqa84GuV2vDyTc1pulxHvs/LpcbHB7BFH7sngymxBJr+UFb0z9aibLZcTcnIsYGx7N6gT
X-Authority-Analysis: v=2.4 cv=SY33duRu c=1 sm=1 tr=0 ts=684011c4 cx=c_pps
 a=X0tkg3G9SmSAvlwNIS9bXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=64Cc0HZtAAAA:8 a=DtAbaYx4Z3uHJzjcfXMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: I5M_874wxjg89qV8ApZO94Y28vpIO4-v
X-Proofpoint-GUID: I5M_874wxjg89qV8ApZO94Y28vpIO4-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/06/2025 19:40, Thomas Huth wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> Check whether we can run a kernel that prints something to the
> serial console.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                      |  3 ++-
>   tests/functional/meson.build     |  1 +
>   tests/functional/test_avr_uno.py | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 35 insertions(+), 1 deletion(-)
>   create mode 100755 tests/functional/test_avr_uno.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d1023635ee..eb56bc0ad1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -219,7 +219,7 @@ S: Maintained
>   F: docs/system/target-avr.rst
>   F: gdb-xml/avr-cpu.xml
>   F: target/avr/
> -F: tests/functional/test_avr_mega2560.py
> +F: tests/functional/test_avr_*.py
>   
>   Hexagon TCG CPUs
>   M: Brian Cain <brian.cain@oss.qualcomm.com>
> @@ -1237,6 +1237,7 @@ Arduino
>   M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   S: Maintained
>   F: hw/avr/arduino.c
> +F: tests/functional/test_avr_uno.py
>   
>   HP-PARISC Machines
>   ------------------
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 0de1caa0f72..3c50bde9349 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -151,6 +151,7 @@ tests_arm_linuxuser_thorough = [
>   
>   tests_avr_system_thorough = [
>     'avr_mega2560',
> +  'avr_uno',
>   ]
>   
>   tests_hppa_system_quick = [
> diff --git a/tests/functional/test_avr_uno.py b/tests/functional/test_avr_uno.py
> new file mode 100755
> index 00000000000..adb3b73da4f
> --- /dev/null
> +++ b/tests/functional/test_avr_uno.py
> @@ -0,0 +1,32 @@
> +#!/usr/bin/env python3
> +#
> +# QEMU AVR Arduino UNO functional test
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
> +
> +
> +class UnoMachine(QemuSystemTest):
> +
> +    ASSET_UNO = Asset(
> +        ('https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_RahulRNandan_LED-5FBlink-5FAVR_raw_&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=530NWSnMpE_NPXBxuADIlm0sMstPhW77cROz21WCPe3qMNFYpc8YLkcGuSuKkEQb&s=vKvgS1S-708MYmvw6As7RxsfFDGwddkmpsk4T3J6if0&e= '
> +         'c6d602cbb974a193/build/main.elf'),
> +        '3009a4e2cf5c5b65142f538abdf66d4dc6bc6beab7e552fff9ae314583761b72')
> +
> +    def test_uno(self):
> +        """
> +        The binary constantly prints out 'LED Blink'
> +        """
> +        self.set_machine('arduino-uno')
> +        rom_path = self.ASSET_UNO.fetch()
> +
> +        self.vm.add_args('-bios', rom_path)
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'LED Blink')
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


