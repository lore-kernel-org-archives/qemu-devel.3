Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B22C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 11:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaC6m-00021I-JE; Fri, 11 Jul 2025 07:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaC5v-0000lN-Ky
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:39:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaC5r-0003Y8-N0
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:39:11 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7mKAs032449;
 Fri, 11 Jul 2025 04:39:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6TA6oIpJR6LqIMhZUcQMhZCwJps+6/7GEwVM0O0vc
 gE=; b=eqatpyJFLphw+kFgLvvOzuV4ZJjZsdoMFv/QEj9hJFUMfHhLvZz61b6RZ
 qnrNlO9ugwrK+REEUyKcp9Knh1k7O9jhbF92U+M34qktHdp5jyUKM9h276nptPBA
 MaK3vF35JWaFRozwSageXBVBNAjfpjmttiQ/Ed/bD7yF2KDkXdwl97XPX1PcOfJn
 1VrMXBgT1651mEg52m6nDJJnNsM+QNQzmjz4YDtqHBBucXtC/YasH2NErmO5QNso
 ujQrYjAemgolf6kHeEu+ceCVrRwgNUMFG0Ym6N301g+5DnkwPU36XXj6KzLjgXmE
 clZsY+v1CoaNPjCUsKe6XWK0b9UZA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47th9421xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 04:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q70PbklO3YkFAG0t0E6gM+z2PUBg4ln8ujc1Ps12afLnUf0Qyncoq06Hcf4Hok2yV8eBPJb3VNl+7b1j/mMYGVzHqBjOxpRdj4r4UGi60v7vWrkTdDdqRJ4d4TgSDu9TynhqJfHkkhy4Uqq7K6gsABXlITxIcerG6qL8I2qv/vO4FC7tOFWA+HJ0JXm7exbY1nIht+zZgfWQLxUO9zfFI2tIwMsMqBF4QB77hmvq0HmJTM0rpJa0YrJTHGPrOG9oayh//MXfg8GNl177P3kgUqg4qgqfA15bWvWyUHAVf9GPqN5fcgDxKFAO8xhsf+ugevbx24fLz8CjwWv3CrRVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TA6oIpJR6LqIMhZUcQMhZCwJps+6/7GEwVM0O0vcgE=;
 b=vyp9wXDHLAYb9Kudy3o/sAz3y3fcC0PtQ1CCaL9E1OVwETVzqyL78aFVA46NSc74ca1S5TGSZ2P+SzBlXjuanUtNEyi/yzdATXol11940YAJB5ph9xHwTcnW1bjb53RWe/DZcrVY8nfD9qGoVM5ErdCwZ5dwz7q27sMLdmsWgvYccx8clnhFOBY38D/+uwrQHmaJKlykTM4A776bRIiVOcwQ+Nkt/HveVsnYqRcdEpqABy5+80cVUsDy9zcsaNOigQujJinzkbGJutG1IM2fagoKA+3P7Div2UXwUpXzMaam7e6FFvQrgn98OewgvnsSxd1adSPbNC8C76JbStqbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TA6oIpJR6LqIMhZUcQMhZCwJps+6/7GEwVM0O0vcgE=;
 b=RJhFnMY57HyPVbkTfLNOmIRpFQia3MMoui8v5W1g7EkOwO6Qya1I1GrZMuNrECygSNr/f0C7IOW04fgbGzfqi68V7CSvxQDf5bt/39+82HwD1P4KbSJJvd8konEXxC3OT6jmVpNZUZL6NR83kjClTuc0UaeapaawmF1dPB41S4HCvKcF71Wy/I/GlYTFfsz6DTMwGJYxZbuJpRXSRw83PGE9k46gW76JpTT9COBQaL9xC7GpC3NPj4D3XLYulhl35x9lqHmHIYqOtLmylRnpd7PdIlaRuRr8sdnFoRQ1aBJKU5O2m16YMxKvr/ffG5MJxxd2Z2H0guzlz1eR8hfquA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10944.namprd02.prod.outlook.com (2603:10b6:8:298::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 11:39:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 11:39:00 +0000
Message-ID: <cdf4931c-cf7b-4849-8aff-0f73fc3d1189@nutanix.com>
Date: Fri, 11 Jul 2025 12:38:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: wait for proxy close correctly
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 Cedric Le Goater <clg@redhat.com>
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250710154731.1266732-1-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250710154731.1266732-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0d174b-23ca-4ec5-dd40-08ddc06f874d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T212N1RBOHMxNDJUNGlWZjY1eXdpZDBMNjk3WjRJbzFJUi9NNmd2YWlwNElo?=
 =?utf-8?B?VkkwaGwzV29PYkhKTDNrZ0hzeFZ3dEVNR2dwMWhqSDVYMGFYenJOL3JZcmI0?=
 =?utf-8?B?Y095S1oyRE1JLzJCR1VCOFd0NGtMd25HTDdaN2pMditYdmR5NVJsYTdJeG9R?=
 =?utf-8?B?NVpveThGNmx4V2g2K2Z0QmNwQVR1NGczdEpjZjFFKzlyRk5HT3YyZ0UzTzJW?=
 =?utf-8?B?bG94ZitpelF3cWp6Tyt1VVhIdllkMlZRSktmaS9VYkJmSVVmUDFzZjArMElD?=
 =?utf-8?B?T1RqS0pyS0pIZmQ4Mmtpb2luSC9aSXo0VFJMQzFWMnVZQW9pYzBtRU1QYnAx?=
 =?utf-8?B?dERrOXAyYXhmQUZacWdyaEdhSkJwTlVBT1RGT3ZyblUvT2QzTTA2NUJTcW1F?=
 =?utf-8?B?SCtTTWV1eHJzR3REKy8xSGNjRnlhbno5eE9BTFo0WnYyMkZWS1hrbzRkY1ky?=
 =?utf-8?B?VmgvejNONElJbS9neStoaXRnSlR2TnF1a2FSWUtxZnA4bTZYUzA2clVVOTA1?=
 =?utf-8?B?Z1RRcDUvcVlmOHBicXJPOEFmMlFhVVlWMUVwa3h3L1BnZU1ER09oRmE3Y0cv?=
 =?utf-8?B?dDNkMllFWVhsV2xTb2duRXg2aUk3WnYwdjJMekVpOHFvblZhZU1oZGZIbCt5?=
 =?utf-8?B?ZUc5QWNNM3BSWlFqdEs3bm5oZkJaOFNmVEFoSXpaVHI1ZG84RTdPU0RlelRL?=
 =?utf-8?B?a2FzYndPRk84RVYwNkVwYm5HUGljMWhWcVg1blovRFNnYjNqN3UzTnFxaHZ5?=
 =?utf-8?B?TUpHbmQ2cDdFbUx4ZCtCOHJCVk1MNHpod2FKMENQQ3pOZHQxdVNDa1Njb0FI?=
 =?utf-8?B?bUxBSkhJK3BnZ292OWNCdFEvbVVkWDR5RU91cjl6Q1JaTzYySWNDblRsS1F1?=
 =?utf-8?B?T0dTU0FwRHhFZjMzdThLNlJTZjhjZXRVc3pHVkZpRExJZ2ZnS05HTW9RejRK?=
 =?utf-8?B?RkUrVWhhQnlBQjh2dktVVkxFaU9keGhtM0NGenVDcUlUeWxzVmFSOW9ERGpM?=
 =?utf-8?B?Vm1vRnMxdlpiOVNwTWlVdmhvU2ZmV280NmtKMjhRQ2YwQWNxSklROWdZQ2lP?=
 =?utf-8?B?a3pHTTdqRzJjajJ4aDd3a0xDVDZQaXBtZ1VXYjFoQWdyY01yOVpUbU9TbXNk?=
 =?utf-8?B?SEhtNGsvSldlQkFycHJBZlQ3UEViQnd4VlFMa0J4TFhTZzhNM1RoYnpLT1dr?=
 =?utf-8?B?d3VpOGZ6d2lTY3lRRnRTVnQ4Snc5WXd5ajNoTUJjaW40N2t1S0VHWlRQNjJy?=
 =?utf-8?B?RHArKzVDT21ZVmFYOGx2MGNHZVlKaGFpNGkydm5WV0hOYi81ejNBQm9teEdv?=
 =?utf-8?B?MXR5ZjR2Y2REZnNTTWVtS2RhSjd2TUR2TklrQ09WWGYvVEFZMTZPeFkyb21q?=
 =?utf-8?B?Smt1TDdLRlFvdWFjeEhGQTd4YUVreTJCS1pVM1NUekRDT1VhaGl6bStuMkxY?=
 =?utf-8?B?NVRLNlFzTUwvY3JCWVhuWU43VkpsczdpQXZ2MEN0WE45MmtmTUVBMWFNemVy?=
 =?utf-8?B?LzhUWmwxdHg4bEZJTmpzMjYvKzR4b0UxSHZCdEE0bERXa0xnSWtqK2gyb28z?=
 =?utf-8?B?R2NNQUdscytYdnU0RzZJWTloendRZjNQbTRKa1JVMHVTWUVBMC95U1RlWVVx?=
 =?utf-8?B?SER6WkF5Tk1YaEdNYS9tcjA2NzdTbVRMMXlSd2VrYytSVm1KLzNJV3h2U09K?=
 =?utf-8?B?OXl2ZGVNR0VBdmZzTEFaWGo2ZXhCcDlEZWhYMDB4blJ0L1hycUdxeUc5Nk5Q?=
 =?utf-8?B?YTluMGNZcklnckJ1alE5Q0FSNVE5U2xqMEVSV1hrb0ZJSmhtdjRsZWFLeXBJ?=
 =?utf-8?B?VTcwcmRCQW5pZXkzTUZKNGRCQWFnOHc3STVhSldIc3hTY09HNThLQkc3Vldp?=
 =?utf-8?B?UnpPcjRUWjNBTUUzRmtFMVJpOEtQKzJZdkpYMUE0WUxCelltL2pCc3RWS2ZP?=
 =?utf-8?Q?TE0qE4Lvdr8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3A5bXdYcGVtampBWHFCU2dRc24zMjBMaHBvc0xmd1QzbUZFM3VFUks5Vk4y?=
 =?utf-8?B?b1RFeUFwckVPZ3lETkIwN2tuZWNDektzV2lvZHlweXZvM2hTL2NERmdmd2xz?=
 =?utf-8?B?NW1uaVpaWTlDNHIvOU5zK1VCemRNY0ZBd3VCU1h4UVU3RjZKM1l4UVg3N3dI?=
 =?utf-8?B?VGR6OWtJZ2pVRTNwWjd6NkF2Q0pWcEMzQ0IwSzIxK2xhT3k5dW5mdXFwN2ht?=
 =?utf-8?B?OXNPUE9EdzJXMitLM1lJLzIxaHR5MEtEem9Gdi9YRFNOeFBZV3hINUlaSFRQ?=
 =?utf-8?B?Z2xnUG1RZTJHNTB0eTI2dkdnblJqZGpvWW5JV21CODZRY09WQUpqc0lqVG1z?=
 =?utf-8?B?MjJ2Ulpmb0tQK3FCSi9rVXNYdWtkemZ4ZGxEQnhEVm40NVc0SnR5RmlBRVEv?=
 =?utf-8?B?WjZMYXUxUm55eWRMM21tOS9OcXFsQ1l3WHBHc3l4b3FwM2R0Y1JYbkZORmNz?=
 =?utf-8?B?WVIyWC9yUkZBZW50T25hREtVd2pON0ZoNHNRMHE5ZEg2SGNBR1k0UURzK0dk?=
 =?utf-8?B?Z0FaV0RnWHRoSmRabEJMVnRLVDh4Z09KY2MxMkhsY1BOaHFnY1lzRUJHTXFF?=
 =?utf-8?B?aS9ldDZoR1pxc2RocGVtZUE0enlKOUxnR29GS01tanppdHRCMDc4ZHJ6US8z?=
 =?utf-8?B?aXA0a3Q1SUt6WXl0MUViZVlOMmpOaVdvRG16UTlZelk0c0xwRGFQU0pya0li?=
 =?utf-8?B?UGlOOXk5cHNCbTFBODg1bUNKOFYzSG9sMTljTm5zWGlLUXBxaEV1MUJwY00w?=
 =?utf-8?B?cjhuUThtWmhGSG03VzF0NkhzbkI1TXBjSFBXb1lQTUU4SEx1aU5MWkdNRDVJ?=
 =?utf-8?B?bG9jOHlha3p0L0lxRzh2OFVnQWhCQ3JHNWNHdlRLcDNlRk9MU1FzOFdCM2J2?=
 =?utf-8?B?VXpDcmtPRC9hU1QvSDFiSktscXJ3bit4cDd6N1RWaXg1MGFJVFpFdUs5bmFu?=
 =?utf-8?B?OFdYNk4wa1NoQTRBbkxYT3c4M3Y5QWN1clgvZnkwcVlvaHBjYTl5NTFYTThj?=
 =?utf-8?B?UlAxbloyaHRSUU5GQUNyZ05GeUZnLzhPaVpRSHM3aXhQWExvbTQrYzdQUlJQ?=
 =?utf-8?B?ejcwR2w1b3FKZ0NUaEFGU1Z1enJWbHRQcUk0OTU4OHlSdm9nSTRaN0JlYWVI?=
 =?utf-8?B?eEROZnE3ZVBjNlV1T1g2ZnVYS0hCN1ZjMHJDUzBHVXBMQTdmc2dKeGxETnBu?=
 =?utf-8?B?dmEvMzBJdjQrTHcyMkhOUWtHQUZNNGs3STZrN1pQVFpUZDUwMHphZXhENUxo?=
 =?utf-8?B?QzBJZEFUQlp1YWZLeVlVT3RNOEgrVUNWZ3diejNTd0xER2xXNEcxUU85dHZw?=
 =?utf-8?B?VlRWQkE5WnBFUTFBakd6TkdSRXQxTUkvZjVIMmI3QXhRL0pHdmNDYWpDTFNk?=
 =?utf-8?B?M3VLWHI2TzN4QUo3NS8wQkVwNC80MkpJQlhJWnVZMjdnekVBLzdPSER4T1JW?=
 =?utf-8?B?a3hUWEUvZTExTVd4YTBHNzI4ejNlZnBaL0pBLzF3cDVTNEZlR1lhOHhkbDhD?=
 =?utf-8?B?NElCU3Q2WTZKcWRGNFJSZm5XNVZIbTN6UmlZdWNxVVY3QjZqMWwwRkg0WGlW?=
 =?utf-8?B?YWpYc3pCVkNrdTlBdXVpRWV4SzUzUG8rTWUwd1dUUWdGcXZyWm00NEtaNkEy?=
 =?utf-8?B?WmFlcUNsUVlqbEZBaDArUElWOWpOR0pJQzhpSlkwSlNMT3NMYjdkZ1FuSXJt?=
 =?utf-8?B?V1dpS2gzNDB3MFdpSG9kajVpeUpnV1I2UlFWTDZWMHM1TzYrUXNCQ1gyMSs0?=
 =?utf-8?B?U1hlYnptVXNTUHFwNEsyMVJEMGk4L3VFUkJRdktlRmhLdmlBZlJrdEg4Rjdz?=
 =?utf-8?B?SlBtd2pQd0JadkpwOFNPM1YySUhhamY5aktFVEZaYUhmRjJUMGR6MkpJRTFl?=
 =?utf-8?B?anQyWDRreTJ1YjVjeStRTkFLNWdVTThBN0pJa3crL2xKNUF3Z1IzTSs1VWQ0?=
 =?utf-8?B?MERvVURMWTNPTjU4cjEwVGIxV0xsNVVFT0RxRTMwNnNrdFBIUWJKSnorc0hV?=
 =?utf-8?B?YnJDTWVZVjZ1TzNacWFMa0dkWHIvYmMzZ3lCdlFWczI2Qk0wSUhkNk9Zc0NP?=
 =?utf-8?B?V3I3T3lzcktMZ1hyV2lhWFNudHJ5U0gyOTVZUlpxWjVjT1Rkcy9yc2NoeDRa?=
 =?utf-8?B?UzFTWitRRkxLMTM3N3YyUVRxZlVrS05XY1lwTXhhRzBYcExXWG1UM05wWVRi?=
 =?utf-8?B?RUNBcExXdHIvaGVpdDlzNmVIWTRQNGJReFo4blJnTW53Qkh3dk1naUkyeG5W?=
 =?utf-8?B?Mm80TUVGSThzSUpLZ004ZTYyZTJnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0d174b-23ca-4ec5-dd40-08ddc06f874d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:39:00.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcnx+SYqHKEk+1i3wngmv0TICIJTF/p+DCwGz9lC3KVJABM3itrneU5kKRg85fo5CIaD54LtFbsoX8wLnjYSCyHORFCKgLTNcdFnMgh3uB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10944
X-Proofpoint-GUID: OOmrA2lwnoWwruZhddqtyi-f7Mms1mnm
X-Proofpoint-ORIG-GUID: OOmrA2lwnoWwruZhddqtyi-f7Mms1mnm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX/zkseA4gvEwx
 lzm7NEmFhvT/nuxg3xPDQOgp8WzSB34+5mGJ5mkrCcpO0ey81p0HBxZB4FxYfyMmMgA5dThvzsf
 NB1n/6bTLdXoWInnfQ5XEzr1WjZd9pquxf7EGSyN6dWIVSR0mZt6LSWpaT0eFBofe/qY9fxpo7D
 AACiOAX/sof3hZcaWdtex/i/Dti0b8tu+WNchmsmq1MHRi3P+/EJTzFxjwfDEEZjWkXvxnN9cED
 xFtRkkVUOVRoRE/MOwGdom4uVGS+CALkR2QljWZ+QeXzkSmM9QMbFD5S3vldD8mbHUaL1RT5p2x
 ZkKWfFel0V6k91T7GdPPMhrWPPN8kt1Fq2661OYfkfeY6NYzMrD3MXsR0v5tVyFuRApOzMQGSQN
 l+Mxp9pMNRN8rcKVIGyUXgxUjbfaPSHDwMDEdoVq1xYZw/LyLbLfdOm7fc7B/MUp0RRzESrj
X-Authority-Analysis: v=2.4 cv=DutW+H/+ c=1 sm=1 tr=0 ts=6870f7d6 cx=c_pps
 a=lFGjc4TqP16raBj1c1EA/g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=woZ6fEwJnWlRihMXnGUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/07/2025 16:47, John Levon wrote:

(added Cedric)

> Coverity reported:
> 
> CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)
> 
> A wait is performed without a loop. If there is a spurious wakeup, the
> condition may not be satisfied.
> 
> Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index c418954440..2275d3fe39 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
>   
>   static void vfio_user_recv(void *opaque);
>   static void vfio_user_send(void *opaque);
> -static void vfio_user_cb(void *opaque);
>   
>   static void vfio_user_request(void *opaque);
>   
> @@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
>       }
>   }
>   
> -static void vfio_user_cb(void *opaque)
> +static void vfio_user_close_cb(void *opaque)
>   {
>       VFIOUserProxy *proxy = opaque;
>   
> @@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
>        * handler to run after the proxy fd handlers were
>        * deleted above.
>        */
> -    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
> -    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
> +    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
> +
> +    while (proxy->state != VFIO_PROXY_CLOSED) {
> +        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
> +    }
>   
>       /* we now hold the only ref to proxy */
>       qemu_mutex_unlock(&proxy->lock);

It think it is worth mentioning the function rename in the commit 
message, otherwise looks good to me:

Reviewed-by: Mark Cave-Ayland <markcaveayland@nutanix.com>


ATB,

Mark.


