Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B114C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxNk-0007El-KQ; Tue, 10 Jun 2025 07:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOxNX-0007AO-Co
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:42:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOxNQ-0001UB-74
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:42:55 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A5r9e4027686;
 Tue, 10 Jun 2025 04:42:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ieDzuKsL5ptnkZLRrI5BQJUTWpK1ZUgUH+1RmUPq2
 0I=; b=dM7K66eNHROWOWm5Qcxcqsx6Elm4q0QF/i1EdptCGn22668Loy+c5sUvH
 R6I7vP1corfHE/zc1gNZ0k4r9UhPqDs/sY1qyXFacBNewe6jDMLSl2BQ/g7z5VBS
 tZy4kBxTmeLP4OXztCEM6Zvh9mT0Xhgp26A6rM8lADAbbk7M9L4sRadJ6xwZJjTH
 w18jBp9c3fASnQlXIDlEWf9MbNEyV9fYnGUprvRwq1iBwvIu5riH3fBjIXFcX3N/
 6og2P3Q5nknvUJ3pwPf9YaZ03A0UCGY7MR/JproleCV9YD3c7POT/AZfyYYCT9OE
 AzvVlVn5T3WFB0qtEYpa/Q0xnUY9Q==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 476e1sru70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 04:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4evJS4bI/9I1Ns/SZSmf52a7g2Y02n4qyzXPPVKhfGdhJantv5VoVE8VUcjdWhi9XYhKZ9puK0DeoB037dxs79d9NYRfttBdquaB0k+RQR+c02hC1AXlS6g5mHahsTkksgFOL1KLcmaId0iHwNLFiuxX88c0yDOtkHgZe6vC6OLSpZQMOCbDfJHYDR2HNwZRAtWobViYaPrMPGTsojCN9xPchz1z0CxUKMKsPErvxxbPKaFfZNRXnD0ufQ67/1ZttlIgBbTuY4Ix7vt/NhBiCMwX6tHIRcyWmxhbCL0iwIEKvbOMSxldkO1ybXAnooQhcHm+q86C0MVrnCqydp+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieDzuKsL5ptnkZLRrI5BQJUTWpK1ZUgUH+1RmUPq20I=;
 b=ClAj9Zaq3vs4fZ7RCHBjEZbmaG2FjEB3EG/qNU+ny71uux3nGVz7vtwnNTJfkLukUcZf2GrBCwtIkHTvdF1X+Wy1sJNfyhfkF0q2PP1QDVhfxAej4SDwMTDR4gD92fstzxpVe/t2lvjpL3c9SoBDenUhXdARh+lJL34xbygpQmX7LBECkdZmb8UTWaTLP1M9EEpUQQHszt8Kljxbz86rhEVZrfNcpzQ/ZTFIc6GNalS11em2SWMd2DAy0g7yhQtJA7xruASea5hW2SkfIASZ3erm5g6SpK+xkIZoeBUm6kIw+rdpFG5GumVfW3NiaMtrAeHSToROSl9JKAMvZbj3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieDzuKsL5ptnkZLRrI5BQJUTWpK1ZUgUH+1RmUPq20I=;
 b=AegmYGQjJl05LNgtCzloVP7CVu08RebjpXOTk0+lyfvub0FTVy36hg+wJY9zCVki5j4kSDARSR7NJXoU3hXceEwaX/Por0R5VgR943cVdZKNdvK6rkHzQEGbceFa6JvU5ka1g91VlEY5UTxVnC7b76pyg6fXrJwTXvM2Hb2cCVHYfnZoegyX23ZEInM/B8GpcjetoX6U5eh4DfWju33vpjCVCuBewz5xyDRgDaRoeVAEo3fFnL0ZcrJhacGHUXI2mhLm26X/UjUq81PFkkCssDxLYaEZHA9uhIsglI/ntlD/5VfY8xJKRWQPebgSu/wAIZ0us+1G6KAKnNm0GbzrwQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA6PR02MB10600.namprd02.prod.outlook.com (2603:10b6:806:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Tue, 10 Jun
 2025 11:42:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8813.032; Tue, 10 Jun 2025
 11:42:40 +0000
Message-ID: <f1a03beb-3667-485e-aca3-5a8f4990f67a@nutanix.com>
Date: Tue, 10 Jun 2025 12:42:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/23] vfio-user: add vfio-user class and container
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-7-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250607001056.335310-7-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::43) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA6PR02MB10600:EE_
X-MS-Office365-Filtering-Correlation-Id: 88302d8f-268f-4225-8cc6-08dda813e79b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2d6L3E2WTZrVmdmczFEYWZ4eHhOc3h6VUljNzdDVEp5bzlUS0hwSUM4RHNx?=
 =?utf-8?B?M3RJZ2FESitTZXpwSDRNQjlmL3N0Wnk5NjZsZ3NZemprL004Wk5NM3ZaN0xH?=
 =?utf-8?B?ZmhodzRseGdmVXRTa2ZoNzloT1BBSGtrTkEwWThkbGt3eVRSejFuTTRyT3Vs?=
 =?utf-8?B?VHRRUFpOTTB4S1RvSHdwUWZCb28rYzV2RlJRcHBQaEh1Y0VLZGFWZldRMmhm?=
 =?utf-8?B?ZEtvalhabDRMd3ZOUi9YSzVFc2JoTElMR3JtYVZ3eTVFTUF3UTdwQUhCSlVr?=
 =?utf-8?B?TTlhU09wWGlueVFjaDlpdmpXNVBrNWtiRGgycFZTOG80UGpEdDhxUEFQVVIw?=
 =?utf-8?B?ajRGS2FTcjRUQ0M3a0NLamRCaDlScC9OTFVuRHRDYWhzZVUwdUQzTDZiRklr?=
 =?utf-8?B?dmtHcFpndGR3YllvWHJMQVJXOXhtNnljMjVhTzJ3c2FLL0w4cG1zVW1vQk03?=
 =?utf-8?B?L1E2VjFzSHRqTGdLdFdycXlHdjdLMEtxOFhCcnQzbW9oVitvRjN4ZEJzMm1y?=
 =?utf-8?B?ZWorREptNVFoOUMwTWpVQzBuVGVVNXEvVUVMTDZzbDNBckxkcjlubTArWWlP?=
 =?utf-8?B?T2VialF5SDFzdVVJZU1KQk4xYUZHQzRIaExJMkNKZUhkRUVHY1k5ZXB5WmFF?=
 =?utf-8?B?cnJIZWtvY2psVzdONGhqYXlqYU8xZTIvYktXN2JTL2x2TmVmQ1dFN1lUMTJa?=
 =?utf-8?B?UGNnT3JpTytXQTZLWUkzb0VQa2dTL09QWDlmdkhaOFFtRlR1UlB4R3dWOUdM?=
 =?utf-8?B?VVBCc2djaXVOMW1yaEkwakF2bGpXeDJpUmJSYTVoelRpcjJLdlQ5MHBMYnN2?=
 =?utf-8?B?RzNpaFMrNWplWmcxSmJlRGtpcEFUV25TRjl3ZTE0UVRucUR3a0JlS2pyTjdP?=
 =?utf-8?B?MEk0ZGk2YTY5T3ZhalZlb1pvdXE4TlJVcXBJVmJqTHMydFNWNlhkYlordUZh?=
 =?utf-8?B?elpaQ1J1YUdoTUpiRFZsd215WnA3cTEvR1F5TmM2bzllS25HNFJ4bElUWmlm?=
 =?utf-8?B?aG93bGgxYVNIZ1Y3a3hXa09kTDIyTWxNSjVNZ2t0OEIzTjdwZjBxL2ZITnM4?=
 =?utf-8?B?WHJpeloxMlZHZWNkYnp3YWk5QktFQUpTRUhDY1Eyd1pYVHFQdHZKK29KNU5z?=
 =?utf-8?B?b1N2amtPRjl3WUVlaVVaejhCWWc3Q0lQVnI4RnFneVR5czVZRFRIQlliK1BE?=
 =?utf-8?B?azdaMWpuc0RUZUZLc1RrWjV1TDFwOFhkTnZUTStKZjRWMVFmb3dIbk51bjBC?=
 =?utf-8?B?K2ZqRm9OTjd1R3U0ZlUyRHA2enNlK0ZvMmo1WWlhYThOQk5jb2h1VnQ2dDhq?=
 =?utf-8?B?dFZXdzdIeUJCZkxaMVNvMGhPRXk1RFhaOW5veG5jSFFlOFNCcFNkRVFiZisw?=
 =?utf-8?B?b0pSQmpST3h1bXkzbUxiYWl5STVYamVKZnFvTklXQlNnVDEyWXNXZTRXTkhq?=
 =?utf-8?B?QUh2SFpHTnlYUy9VSjVpL05QVlRCT0NBZ3MwdTNLbXE4YkpSVkhaRVdWNHp3?=
 =?utf-8?B?S1lsOS9md294cCt3UTZGdTRxTmg0SFdYR2dPNWhUUzRUTEgyZWJWak8zcTE0?=
 =?utf-8?B?YjlxQkJ2TExyMmtaSVJISUFuYVRHTFdoQy9aaXAra0hwZXpKT3RkdDZXMGYz?=
 =?utf-8?B?VlFGOGRRODFWai94K3IweHl0VnFNaFhwb09uekQ2NytpamoxTGxZSU1QL05P?=
 =?utf-8?B?WnA3cFhkd3F0cC9Nc28zTDdDTjFSWDlpNVNvZ0JDeVpKYVVBaFZFZ2ZXVkY3?=
 =?utf-8?B?T0NIUHBnMnd2TUdMalNqbVQwaDZCano0SFRPdTZ5SGRSZkx0YnNPK1ppUmNx?=
 =?utf-8?Q?vZ1bfhPeoNPKstNSorg02Du7ZZs8OJveTXHro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1F5ZXdRbVZnTmJJRjZiSnpWZGYveE9qMkJXSkRwTnFPUktRbkdkelRCRGVB?=
 =?utf-8?B?L3ZXejhsUHRnT21QcTlaZ2VUd0I1bVZtTVBnWXJuUVFDRWQvQU93aWxLU3c1?=
 =?utf-8?B?alA4SnRNejRhQkMxalRPemQ5VUpwMjQvUnozQ1gwYjZjOUJwN0VXSUpiUnV5?=
 =?utf-8?B?VW8vdmVMemFjK25sdHp6dlBTSWxEVmlDUW9teFNpK045bTNUM1dmTnJ4RmRR?=
 =?utf-8?B?a0ZNY2FGdXcyeXlnQ0ppOU9aNWlPQUVOd1RFSXlIM1d5Sk9ackJQQUZJNU5N?=
 =?utf-8?B?MkdJRW1uU21aKzZmUzQ0NXJkVEtJNG5QRTZ4VWNGeXByVDNycy9ndWhldGMw?=
 =?utf-8?B?Y0NrakYxZXZPK3grOW9EangrSFVtUjBPZ05CZk9taWNhTzI0UWZNb3B1bjVG?=
 =?utf-8?B?dXBDakhSNnAyVXpzRmV1REFtWDh0dDFBYUx2N1NrdHN0Sk5UL045blI5STdW?=
 =?utf-8?B?SFFaelZRak13UWFWanNzTG1yMmFHay8vNjk2SEIya2ROVHVDTFF4TDdGWnZ6?=
 =?utf-8?B?SC92MHVQdGNDN29jQ1JZLzlDRnM5RDQ0SWpmbEkxWVowRWVVRzlMWkwweVRY?=
 =?utf-8?B?WTlJdFNpZlg4bUhYVC9aWjYxVWo2MTcvNmVqcE0zSmtNL3dkTzhpVzFaTjBF?=
 =?utf-8?B?YzZpT05FL3RGRitwK3BKYU1ucktQaVFMREhUbDhIM0l5YVRVcCtGQXJjZ1U4?=
 =?utf-8?B?SEtRMk1WYmlrUG94TlJzd25OeWFEOGxRQmIwTVNVSHBwZWQ1NmFCdlJjK1RB?=
 =?utf-8?B?aFFKTlFheUUyNzBJK2V6OHJ3VGJ0aEN1WmticXZFNE5FZEE1ZkVmRE5hdzBM?=
 =?utf-8?B?WkhoZUdCcThXR0d1QWtsbXY5OXB2YVdtdjhIaGNrQmdZYjNlMVpIdVhuVTJK?=
 =?utf-8?B?cTNUMDN3Ylg4Rm9qNVM0WnlRL0ViVkJjYnFaOWowWUJKSHdEdjVrYmdrc0tQ?=
 =?utf-8?B?eUlKVzV0WkxwUWVJSDkzeFhkcisvQVhqTEtNTGxqYlNuaExsMS9iT1RFMHgz?=
 =?utf-8?B?SlJtWkFBYi9OMFc1Yk1NMytvWVFPMmxZQm9YS1hqRkFCMlBJQzBSWUtOSjdU?=
 =?utf-8?B?RS9Ec0xHYW1sMGRYZGdYYmJPVjdMWEx0czlpL0NHRkpwNnhtRGwvbnJDMTRi?=
 =?utf-8?B?R1M1L0J6V25pOUZGc2E2VExXMlBvblRXa0R2emFOdmZYRWtDQUNiUjZGYTJu?=
 =?utf-8?B?Y241Y0NxL01oUE1UdWxKY09sdzhGU3BIUWpVK1NkUVJXUy9qc3J4czhmeWpl?=
 =?utf-8?B?ZUU5WWxpODZqaXNtQmtOK25ha2FMbHQ0K2VydUNYOXBIWGJBbHdxbGJRSkV3?=
 =?utf-8?B?Tkttd0IyV2lNN2NjUjQ3NnpqWWkzOTI4YlZrMUZacEQxMFBqVlRkTnZiSFAv?=
 =?utf-8?B?dlNLcDJkK3FQaU9DQ2hjcGsvYUVPcm9nTDhma3VvRHlnd25XVjQxY21qcEFM?=
 =?utf-8?B?QUV5bFdsMHJYSlBwWlE1S1ZLbXYydmxPVjBTdjNuUzhuWStBTjZQbXJ4YnlT?=
 =?utf-8?B?aG9nSE9vVnk5VENqRERJUVdxdnBDcXRybExLY1kzZVYvQVRCa2tkeS9Rc2Y3?=
 =?utf-8?B?U2lPMVpFZHVSRld4WWVJYWJ0VDQzSzJuY0ZtUkJKTi82OW51dzAxQlhybSs1?=
 =?utf-8?B?OEh5enpKa240Z0xVc3UxclZWWVFQYWdLekFTazBkMXNHVjFOeEI4UmczTTRC?=
 =?utf-8?B?M1RmZmMzK0ZBeWowV1AyUUE5aFJDSVF3bW1CVmZyWWRvV0FCamU2OW9rRDN6?=
 =?utf-8?B?Z0s4eFk0SzFNSzRodTIwb2VaR3lRbFREQ3FkM3F5KzAzNjAwQVZFTVNIZm9R?=
 =?utf-8?B?QXpJLzFyL3JKOXJOczg4Ym5KWVJFNkpqci9Zc1hib3NJYUZ2ak1lejVCYzBp?=
 =?utf-8?B?S2NuTk1maDYrcnQ2aHdwK1BUeWdlc0Z2RjB0dzN6Qk0xUkRvUTRsMHV3Qmp1?=
 =?utf-8?B?NVdVSkU3M080SkN6eVdGWFI4OU1DamowZWtFTW9LV3h4TG1ZM3laYmFYVXZw?=
 =?utf-8?B?ZkZTa3VYN3c2Y0NGNzg0dXFNQ0w5N0htWU1tMFdEL3NOaUkzTVBGUTN6MENp?=
 =?utf-8?B?S0Rwb2ptaC9XQk95VzF0TGxldk1HeW1NbTlFS3VTNmFNYXN6Z2NMVEZpcFR6?=
 =?utf-8?B?dDllT3EwbXRQQ2dGbFNoSnhOR3E5TldsYTJLTnp6Z1NxT3YvaU50b0hLWnpz?=
 =?utf-8?B?eS9DVVNXUCtNc3ljM1ZscWQ1U2pidUJaZVowOUJyQXF0K3FsYmhXK2VJTGJT?=
 =?utf-8?B?NjBzS1RqSlo1djZnZDhobU9wc05nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88302d8f-268f-4225-8cc6-08dda813e79b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:42:40.1239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCRyftr1NYYeN31cT7S8Tslp42hAOzWgCD5pQj9TTn4HYzMwPCT7YYycNnRZ4uJiSxy/IzR4kWy4VlK33dKOsRhP/sdUZJDpDLOkw8/8Vyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10600
X-Proofpoint-ORIG-GUID: f9PrGIEp7tDFw-vTBzQzPCxNmeCK0qNZ
X-Proofpoint-GUID: f9PrGIEp7tDFw-vTBzQzPCxNmeCK0qNZ
X-Authority-Analysis: v=2.4 cv=W9U4VQWk c=1 sm=1 tr=0 ts=68481a32 cx=c_pps
 a=+nNJfTtXyuiF5uNGX6Ug4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=NLiCwHATAAAA:8 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=zhBv0WTCkbDYo2DdMpYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XHjirhgxjc0A:10
 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5MSBTYWx0ZWRfXyj9mOGpTLctG
 CpLdqwQAMyZSk1S8+4iV0MEhqeYJ0gl++20Gp4R2NEHw14Ss8ALjWb9F4DpSgUleRvuWMi1G4kz
 sptWkaxEODquh1JFbZy/unYTL6ID4EtzeHp7cBqa16tqYparqrvyXohkMvIcnI3ZPPlfdb8/IaA
 HQT83fgnF84lN8TJoZ0CjzoiAN8XeZ9LFKXB8B6pNdE5JESrNavoTDWMQPO5WRAL+x+FChRAasl
 6WQO+Nu4OXYf7Wnx/t6bDjJGwltZP7R9cw+0Wj/olF0UbhuYGADhR8m8xMWczhXTWxrkpB4NdMN
 K0CYdrYsROt+g/qxs+TSYX4cSEnXVyndiCqNwwqasOg44f6JBJ6XNP2WWTO8E4rtIMhuA3pNo/q
 /RWT9kx0HGn6DenvA5X0UuJZQyyujWXEFzWGLvM+WDUW210TK2UKl0YdX4cg5yI99FKQCbeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 07/06/2025 01:10, John Levon wrote:

> Introduce basic plumbing for vfio-user behind a new
> --enable-vfio-user-client option.
> 
> We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
> container type for the "IOMMU" type "vfio-iommu-user", and share some
> common container code from hw/vfio/container.c.
> 
> Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
> sharing some common code from hw/vfio/pci.c.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   MAINTAINERS                           |   2 +
>   hw/vfio-user/container.h              |  25 +++
>   include/hw/vfio/vfio-container-base.h |   1 +
>   hw/vfio-user/container.c              | 212 ++++++++++++++++++++++++++
>   hw/vfio-user/pci.c                    | 155 +++++++++++++++++++
>   hw/meson.build                        |   1 +
>   hw/vfio-user/meson.build              |   9 ++
>   meson_options.txt                     |   2 +
>   scripts/meson-buildoptions.sh         |   4 +
>   9 files changed, 411 insertions(+)
>   create mode 100644 hw/vfio-user/container.h
>   create mode 100644 hw/vfio-user/container.c
>   create mode 100644 hw/vfio-user/pci.c
>   create mode 100644 hw/vfio-user/meson.build
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbc393989a..328bab8d19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4252,6 +4252,8 @@ M: John Levon <john.levon@nutanix.com>
>   M: Thanos Makatos <thanos.makatos@nutanix.com>
>   S: Supported
>   F: docs/devel/vfio-user.rst
> +F: hw/vfio-user/*
> +F: include/hw/vfio-user/*
>   F: subprojects/libvfio-user

Question: how do you see the division between hw/vfio and hw/vfio-user? 
My initial feeling is that there is substantial sharing between the two, 
in which case I'd expect the files to be in hw/vfio as e.g. 
hw/vfio/container-user.c etc. instead of its own directory.

Cédric, what are your thoughts here?

>   EBPF:
> diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
> new file mode 100644
> index 0000000000..3cd3303e68
> --- /dev/null
> +++ b/hw/vfio-user/container.h
> @@ -0,0 +1,25 @@
> +/*
> + * vfio-user specific definitions.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_USER_CONTAINER_H
> +#define HW_VFIO_USER_CONTAINER_H
> +
> +#include <inttypes.h>
> +#include <stdbool.h>

These shouldn't be included directly: you probably just want:

#include "qemu/osdep.h"

instead.

> +#include "hw/vfio/vfio-container-base.h"
> +
> +/* MMU container sub-class for vfio-user. */
> +typedef struct VFIOUserContainer {
> +    VFIOContainerBase bcontainer;
> +} VFIOUserContainer;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);

As per the documentation at 
https://qemu-project.gitlab.io/qemu/devel/style.html#qemu-object-model-declarations 
the parent object should always be named parent_obj and struct shouldn't 
have a typedef i.e.

/* MMU container sub-class for vfio-user. */
struct VFIOUserContainer {
     VFIOContainerBase parent_obj;
};

OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);

> +#endif /* HW_VFIO_USER_CONTAINER_H */
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 9d37f86115..28899ca0a6 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
>   #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>   #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>   #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
> +#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
>   
>   OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
>   
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> new file mode 100644
> index 0000000000..2892845b4f
> --- /dev/null
> +++ b/hw/vfio-user/container.c
> @@ -0,0 +1,212 @@
> +/*
> + * Container for vfio-user IOMMU type: rather than communicating with the kernel
> + * vfio driver, we communicate over a socket to a server using the vfio-user
> + * protocol.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include "qemu/osdep.h"
> +
> +#include "hw/vfio-user/container.h"
> +#include "hw/vfio/vfio-cpr.h"
> +#include "hw/vfio/vfio-device.h"
> +#include "hw/vfio/vfio-listener.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
> +                               hwaddr iova, ram_addr_t size,
> +                               IOMMUTLBEntry *iotlb, bool unmap_all)
> +{
> +    return -ENOTSUP;
> +}
> +
> +static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> +                             ram_addr_t size, void *vaddr, bool readonly,
> +                             MemoryRegion *mrp)
> +{
> +    return -ENOTSUP;
> +}
> +
> +static int
> +vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> +                                    bool start, Error **errp)
> +{
> +    error_setg_errno(errp, ENOTSUP, "Not supported");
> +    return -ENOTSUP;
> +}
> +
> +static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                         VFIOBitmap *vbmap, hwaddr iova,
> +                                         hwaddr size, Error **errp)
> +{
> +    error_setg_errno(errp, ENOTSUP, "Not supported");
> +    return -ENOTSUP;
> +}
> +
> +static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
> +{
> +    error_setg_errno(errp, ENOTSUP, "Not supported");
> +    return -ENOTSUP;
> +}
> +
> +static VFIOUserContainer *vfio_user_create_container(Error **errp)
> +{
> +    VFIOUserContainer *container;
> +
> +    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
> +    return container;
> +}
> +
> +/*
> + * Try to mirror vfio_container_connect() as much as possible.
> + */
> +static VFIOUserContainer *
> +vfio_user_container_connect(AddressSpace *as, Error **errp)
> +{
> +    VFIOContainerBase *bcontainer;
> +    VFIOUserContainer *container;
> +    VFIOAddressSpace *space;
> +    VFIOIOMMUClass *vioc;
> +
> +    space = vfio_address_space_get(as);
> +
> +    container = vfio_user_create_container(errp);
> +    if (!container) {
> +        goto put_space_exit;
> +    }
> +
> +    bcontainer = &container->bcontainer;

References to the object hierarchy should always be done with the 
automatically generated QOM cast macros since they are easier to read, 
and also ensure type safety e.g.:

        bcontainer = VFIO_IOMMU(container);

> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +        goto free_container_exit;
> +    }
> +
> +    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    assert(vioc->setup);
> +
> +    if (!vioc->setup(bcontainer, errp)) {
> +        goto unregister_container_exit;
> +    }
> +
> +    vfio_address_space_insert(space, bcontainer);
> +
> +    if (!vfio_listener_register(bcontainer, errp)) {
> +        goto listener_release_exit;
> +    }
> +
> +    bcontainer->initialized = true;
> +
> +    return container;
> +
> +listener_release_exit:
> +    vfio_listener_unregister(bcontainer);
> +    if (vioc->release) {
> +        vioc->release(bcontainer);
> +    }
> +
> +unregister_container_exit:
> +    vfio_cpr_unregister_container(bcontainer);
> +
> +free_container_exit:
> +    object_unref(container);
> +
> +put_space_exit:
> +    vfio_address_space_put(space);
> +
> +    return NULL;
> +}
> +
> +static void vfio_user_container_disconnect(VFIOUserContainer *container)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;

Use a QOM cast here.

> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +
> +    vfio_listener_unregister(bcontainer);
> +    if (vioc->release) {
> +        vioc->release(bcontainer);
> +    }
> +
> +    VFIOAddressSpace *space = bcontainer->space;
> +
> +    vfio_cpr_unregister_container(bcontainer);
> +    object_unref(container);
> +
> +    vfio_address_space_put(space);
> +}
> +
> +static bool vfio_user_device_get(VFIOUserContainer *container,
> +                                 VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_device_info info = { 0 };
> +
> +    vbasedev->fd = -1;
> +
> +    vfio_device_prepare(vbasedev, &container->bcontainer, &info);

Use a QOM cast here.

> +    return true;
> +}
> +
> +/*
> + * vfio_user_device_attach: attach a device to a new container.
> + */
> +static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
> +                                    AddressSpace *as, Error **errp)
> +{
> +    VFIOUserContainer *container;
> +
> +    container = vfio_user_container_connect(as, errp);
> +    if (container == NULL) {
> +        error_prepend(errp, "failed to connect proxy");
> +        return false;
> +    }
> +
> +    return vfio_user_device_get(container, vbasedev, errp);
> +}
> +
> +static void vfio_user_device_detach(VFIODevice *vbasedev)
> +{
> +    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
> +                                                VFIOUserContainer, bcontainer);
> +
> +    vfio_device_unprepare(vbasedev);
> +
> +    vfio_user_container_disconnect(container);
> +}
> +
> +static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
> +{
> +    /* ->needs_reset is always false for vfio-user. */
> +    return 0;
> +}
> +
> +static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
> +{
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
> +
> +    vioc->setup = vfio_user_setup;
> +    vioc->dma_map = vfio_user_dma_map;
> +    vioc->dma_unmap = vfio_user_dma_unmap;
> +    vioc->attach_device = vfio_user_device_attach;
> +    vioc->detach_device = vfio_user_device_detach;
> +    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
> +    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
> +    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
> +};
> +
> +static const TypeInfo types[] = {
> +    {
> +        .name = TYPE_VFIO_IOMMU_USER,
> +        .parent = TYPE_VFIO_IOMMU,
> +        .instance_size = sizeof(VFIOUserContainer),
> +        .class_init = vfio_iommu_user_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(types)
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> new file mode 100644
> index 0000000000..74b0c61f9b
> --- /dev/null
> +++ b/hw/vfio-user/pci.c
> @@ -0,0 +1,155 @@
> +/*
> + * vfio PCI device over a UNIX socket.
> + *
> + * Copyright © 2018, 2021 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <sys/ioctl.h>
> +#include "qemu/osdep.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/vfio/pci.h"
> +
> +#define TYPE_VFIO_USER_PCI "vfio-user-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
> +
> +struct VFIOUserPCIDevice {
> +    VFIOPCIDevice device;
> +    char *sock_name;
> +};

Again as per the documentation link above, device should be called 
parent_obj plus there should be a empty line between parent_obj and the 
other members i.e.

struct VFIOUserPCIDevice {
     VFIOPCIDevice parent_obj;

     char *sock_name;
}

Note that by using QOM casts the name of the parent object member is not 
exposed to the remainder of the code.

> +/*
> + * Emulated devices don't use host hot reset
> + */
> +static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
> +{
> +    vbasedev->needs_reset = false;
> +}
> +
> +static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
> +{
> +    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
> +                                           device.vbasedev);

Hmmm. Not for this series but this may suggest VFIODevice should be 
QOMified.

> +    return OBJECT(vdev);
> +}
 >   > +static VFIODeviceOps vfio_user_pci_ops = {
> +    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
> +    .vfio_eoi = vfio_pci_intx_eoi,
> +    .vfio_get_object = vfio_user_pci_get_object,
> +    /* No live migration support yet. */
> +    .vfio_save_config = NULL,
> +    .vfio_load_config = NULL,
> +};
> +
> +static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +    AddressSpace *as;
> +
> +    /*
> +     * TODO: make option parser understand SocketAddress
> +     * and use that instead of having scalar options
> +     * for each socket type.
> +     */
> +    if (!udev->sock_name) {
> +        error_setg(errp, "No socket specified");
> +        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
> +        return;
> +    }
> +
> +    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
> +
> +    /*
> +     * vfio-user devices are effectively mdevs (don't use a host iommu).
> +     */
> +    vbasedev->mdev = true;
> +
> +    as = pci_device_iommu_address_space(pdev);
> +    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
> +                                          vbasedev->name, vbasedev,
> +                                          as, errp)) {
> +        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
> +        return;
> +    }
> +}
> +
> +static void vfio_user_instance_init(Object *obj)
> +{
> +    PCIDevice *pci_dev = PCI_DEVICE(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +
> +    device_add_bootindex_property(obj, &vdev->bootindex,
> +                                  "bootindex", NULL,
> +                                  &pci_dev->qdev);
> +    vdev->host.domain = ~0U;
> +    vdev->host.bus = ~0U;
> +    vdev->host.slot = ~0U;
> +    vdev->host.function = ~0U;
> +
> +    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
> +                     DEVICE(vdev), false);
> +
> +    vdev->nv_gpudirect_clique = 0xFF;
> +
> +    /*
> +     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
> +     * line, therefore, no need to wait to realize like other devices.
> +     */
> +    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> +}
> +
> +static void vfio_user_instance_finalize(Object *obj)
> +{
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +
> +    vfio_pci_put_device(vdev);
> +}
> +
> +static const Property vfio_user_pci_dev_properties[] = {
> +    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
> +                       vendor_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
> +                       device_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
> +                       sub_vendor_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
> +                       sub_device_id, PCI_ANY_ID),
> +    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
> +};
> +
> +static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, vfio_user_pci_dev_properties);
> +    dc->desc = "VFIO over socket PCI device assignment";
> +    pdc->realize = vfio_user_pci_realize;
> +}
> +
> +static const TypeInfo vfio_user_pci_dev_info = {
> +    .name = TYPE_VFIO_USER_PCI,
> +    .parent = TYPE_VFIO_PCI_BASE,
> +    .instance_size = sizeof(VFIOUserPCIDevice),
> +    .class_init = vfio_user_pci_dev_class_init,
> +    .instance_init = vfio_user_instance_init,
> +    .instance_finalize = vfio_user_instance_finalize,
> +};
> +
> +static void register_vfio_user_dev_type(void)
> +{
> +    type_register_static(&vfio_user_pci_dev_info);
> +}
> +
> + type_init(register_vfio_user_dev_type)

Use DEFINE_TYPES as you've already done above instead of type_init() here.

> diff --git a/hw/meson.build b/hw/meson.build
> index b91f761fe0..791ce21ab4 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -39,6 +39,7 @@ subdir('uefi')
>   subdir('ufs')
>   subdir('usb')
>   subdir('vfio')
> +subdir('vfio-user')
>   subdir('virtio')
>   subdir('vmapple')
>   subdir('watchdog')
> diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
> new file mode 100644
> index 0000000000..f1fee70c85
> --- /dev/null
> +++ b/hw/vfio-user/meson.build
> @@ -0,0 +1,9 @@
> +vfio_user_ss = ss.source_set()
> +vfio_user_ss.add(files(
> +  'container.c',
> +  'pci.c',
> +))
> +
> +if get_option('vfio_user_client').enabled()
> +  specific_ss.add_all(vfio_user_ss)
> +endif
> diff --git a/meson_options.txt b/meson_options.txt
> index a442be2995..97d3db44cd 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -109,6 +109,8 @@ option('multiprocess', type: 'feature', value: 'auto',
>          description: 'Out of process device emulation support')
>   option('relocatable', type : 'boolean', value : true,
>          description: 'toggle relocatable install')
> +option('vfio_user_client', type: 'feature', value: 'disabled',
> +       description: 'vfio-user client support')
>   option('vfio_user_server', type: 'feature', value: 'disabled',
>          description: 'vfio-user server support')
>   option('dbus_display', type: 'feature', value: 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index f09ef9604f..2c5673769a 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -201,6 +201,8 @@ meson_options_help() {
>     printf "%s\n" '  vdi             vdi image format support'
>     printf "%s\n" '  vduse-blk-export'
>     printf "%s\n" '                  VDUSE block export support'
> +  printf "%s\n" '  vfio-user-client'
> +  printf "%s\n" '                  vfio-user client support'
>     printf "%s\n" '  vfio-user-server'
>     printf "%s\n" '                  vfio-user server support'
>     printf "%s\n" '  vhdx            vhdx image format support'
> @@ -529,6 +531,8 @@ _meson_option_parse() {
>       --disable-vdi) printf "%s" -Dvdi=disabled ;;
>       --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
>       --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
> +    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
> +    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
>       --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
>       --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
>       --enable-vhdx) printf "%s" -Dvhdx=enabled ;;


ATB,

Mark.


