Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36BBC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VQK-0003Uv-Ec; Mon, 13 May 2024 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6VQA-0003UL-AH
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:08:52 -0400
Received: from mail-bn1nam02on2083.outbound.protection.outlook.com
 ([40.107.212.83] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6VQ5-0002Fh-PI
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QD0fiO1CS6GbQO01tt6K7rWIcdHk1Al9BLB1h8UFSDUej9ughV7zgEypjK3qBYuUqJX0haWoPegjqaOxiJpV30yZfO/3cutRbKKcKBO9PDeyIV0D9nZJ/nhobVLLbVNZ9hu5onwRkCvWdgQk9o/ZOOwhjQI/26FAxSW2eIlerksI+eA0rNrq4YAgxAWY1iGyzIBf+EXEhrpJigThY57PXpkJZ46M7OF4AlA3bZPBf84jHJ/aIaDFihJL6XvqRKWuOcefxrURhQaou/E4JYxv2HOmIsqBbOaS99gIlHQWGlPRu2ZgSv6kSy88V/dWDVWVVgw7lFNOprNIfNutTMhkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHw5QRwTZ1GFyKeHHwQvApR2KsiXQ6DgOnsil6gOKXo=;
 b=LftKN44QckuM+SW90m1uVwBY7sYvGnNXr7kq06HH8N51/2Waq/PZclTUBoupA2KtjBr+jdudxfRNdCb8H2CLPh5tQnHgjgN01gAB4r7GIn8pqDSAWj66NYKD+v1crcq2j1hQDCkB23AQ96UCY1qrWlELYrmrBB76xx9zuLXyTQZYHINkEctyUfZbsx9FMseAgJB0jWQ0nnnT+0DsYoDBSzQkfHwFZKJrnWL5IBLykQHhN2kuH0Namk2F+aZeEQtuYdQM3sm6LI6kw8lyRH8yQi4AhAxLuFMosHAzOd8YiRUxr89r+optUcE2/Bp9G7nTmmVKLhtrsATS5UpfL28O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHw5QRwTZ1GFyKeHHwQvApR2KsiXQ6DgOnsil6gOKXo=;
 b=ksQgDhKtmyoEpA85vey0pY3n9k7Ny6+bUAS6PextEj+/EQoEqCZfVXCuBn+80pCeDTn80GvkNLceJ2jtuLV+rzq4V7Bb/SHGWr7y1Tu1EmnBxT3dB15oe59P94L9ByMLqOplvqihaJnDb1e582pVuFwG7mfjuDSAkDDnyk9uypGHgcvPRy4sVRHkvFkKPtAqxDwtXhPZGWaiQcdB4nCciLvgYxgy5WOQ/R3fX8XYpM/qzntMLnyd4+GFyWVVhAFC9Hhc4e+GD5D1NUalcKw4GPJicwI7iv6F5ZsiSCoqGaNqhh9xk+I4LppC8u86wEq5409CkjIJ1Y19y1Mch2xe+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:03:37 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:03:37 +0000
Message-ID: <2e55e1ad-5c40-4ae5-a362-5f7fd610b0e9@nvidia.com>
Date: Mon, 13 May 2024 16:03:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-2-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0319.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e14fa46-db68-4624-1f49-08dc734d1a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGhVWjkxdlA2V1FZK0NKYUhXZ3p1OW5TSzZrTHV6VWlDVjl4RDExNWhWUjk3?=
 =?utf-8?B?NE5UWVIvVUpvWDExN3ZUTWhOcHpSNFVtRTBKYUtUZzJSanY3UjZkRDNjQ3hn?=
 =?utf-8?B?S1ppU1FYS29IQzZLTnVHNFprWlZsNUZMc04reE5uNHplUGFyVGt5QVZHTUp1?=
 =?utf-8?B?ZzRMeEF0RWZkU0F3Wm1neTZQVlY2UlA2SytoTHZ1SkRxK0lJYWJHY1ZzNmho?=
 =?utf-8?B?aTZOQmJzMEtyc1FuQTYyU21LSTN4RThrRkVsbVJ2S3RmVFk0UnoyUmlpc3ZH?=
 =?utf-8?B?SXpmRmNkRDNPemgrNi9sd3BHRGtCMnVCNlpkZ3g0ZTZIVzRrSEJCQURGYmdI?=
 =?utf-8?B?MHFIMnJ3d2dSRXdXR0JwWlAxQjYrWDZyQXBsZUdncC9JVVpjdWliaVVkTHdN?=
 =?utf-8?B?K2V5SHA0c3FTTFM5dGRhczJyYW8xK3pnYVFkYWd0emQ3bEZ0S1ZJZ3RYTXdL?=
 =?utf-8?B?Tnd3U0hocmp5b2xMbU9CWVgxdDI5eFhzUjc3TUhvazRtWmhjQ215dkV3TWpL?=
 =?utf-8?B?WTNyQ2FoSGdidEJuMnJ6bk1hVVZ2UGlmMmxiSEpLZFR0eVcyZ2NZSXRXRWxa?=
 =?utf-8?B?czFmUytLcW5STjFzKzdnb2Q4cEoxZXF2ZTk1ZmJES3FIcFAva3YvQ25LOGN5?=
 =?utf-8?B?NXpMS2ZyTVBlNDE5WktnMXdaT2lLWGtVRzVnTDBsZVUzbHRhVkM4eCtwWjFm?=
 =?utf-8?B?ZXJUZ3pIbjNHNDQ5ZVlHdEJQMkpjOUpYS3pKN2lRb3J4T0YwUTEvWGJad2t3?=
 =?utf-8?B?QnBaSWRDMHh1TThuT1lDd1VmR1pqZ3ZTRVRrbEVDTDM1S3FlWS9VMUgzbXcw?=
 =?utf-8?B?c2RVTElGVFN2emkxSFJVYXd6NFUwNytJc1QxRE11Z2N0WWRMd09RcU9Xa3hZ?=
 =?utf-8?B?dlpyTXp3MnM1MmtGQVI4T0xodFAvQUFpWjUxaUdPVjJwMmhrcXdkNDZxK0xK?=
 =?utf-8?B?SlF0ZTNzZjlQWjR2ZVRybnd4VUxxVHVxbGJFem5aUXoxOXl6SjNGRUg3d2lu?=
 =?utf-8?B?VWJFdDF2U2JpcStocis2M2VDTjM3cENUL0thZDdoZVFuNE9Oem94QStaTHhI?=
 =?utf-8?B?NitXVjBTZXB1WGgrTTVSNjQ2d0Jsazd4S05Qenp2TS9FZWVoakdzODdaaGk4?=
 =?utf-8?B?WUVyVHFCZU1TODRsWHkrUXlVSUtDSDg1ckZIZmZWdG1ZQ1FqRGtvcjQ5RTE3?=
 =?utf-8?B?bVhScndiMEc5NkZoZWNGVzdGVnh6TmxFTGlRb1VNb2dFM1hZTHc3Wlo4QnhM?=
 =?utf-8?B?SThlOUE3a21yVFZIbExhdk93VUVUVkIvTGgxY0VhbncvK2ZxVXZGSUdjQ1NZ?=
 =?utf-8?B?Ky93TDN4L29BNWF2TWZCd0lwbENGSU5MUHRNL3VQc1Nob2cvRlJDblFtdlNK?=
 =?utf-8?B?OWxjVGRKRmp4SXYxZzdlYW41ZHNKVG1mMEo3R3FPdVIxcjh3YWE0WExTWWQ4?=
 =?utf-8?B?Y01pQ05PUG5ML1pjRjdPdFY2eGI1NXJWb1lEY1o1TmVaelYyQVk1Q1N3My9o?=
 =?utf-8?B?NkZ6dlM1ZS9JN2Z3QUtIdnB3alVPVmVMMjhwY3V2eWRFeHNuTWNldkFSQmVr?=
 =?utf-8?B?dDF4cFF1UkxUbC9Yak5FSHZXWVV4UGZOTGdNNTFNMitKcnFxdzZoVHhVUlla?=
 =?utf-8?B?RXlCaS9ORW4vMDIrSU1qWGNKblZOdTBlN0tuZ2xIa3I5cXVSNGVCRXhYQmY1?=
 =?utf-8?B?dG5ub1Y4YkM4SUF2c1dLTVlTM1JjaTR3emQzZ0NmelBDc3RTSHVKV3VRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVsbmtqcUpLVGl5QUdzbVQ4TVdYaHpzOGVEQlFhbmVvZTdkOFI1WkJzOFI1?=
 =?utf-8?B?dis1MlNHMFcvZVBvakRtaFZKczhSa0tRMlI4dDVtaG5idEg4MktaTmR3ZDUw?=
 =?utf-8?B?eVMzc21MelpYQUM5OVZ6a0xjd0ZJQ1NrQWhMaExqbS9BV0pvZUxEM0d3dmQw?=
 =?utf-8?B?QVZyeXBaVzdYV2JZc3RES0RpNWJQWktRNFcvdVlwb0xQQVNOeEZkMWVWNGp4?=
 =?utf-8?B?ZmtrOUd1NlE0bkpHRmFIeGkrUWQ1VWlaUld5c2RvcWcrZkRpR20vY25PNzVL?=
 =?utf-8?B?TFlTN21pMFI2NG1iOVZKL21ZSjVvZVZYNERTc01PdUhwemNoZFFRdTVGSjVs?=
 =?utf-8?B?M3gvTmlPZTZoeWQ1V2xHUXN0bFQwaXFNSkluRGlNeXQramNtRzdlV1NkQ1RD?=
 =?utf-8?B?NWsvS2dva012ZCtOK2N0dE50WElSQmprZFJXQ1lBMG9aeWhPRSsyYTFjMUpj?=
 =?utf-8?B?VGJNekF4bHBJcklDemp5T2JkU29Ud2p6S2F4eXlUYVpaaUZ4M0JtNGIrRVMx?=
 =?utf-8?B?ZVVIdEc5c0twdzBPcVRKYTRSTFNtQnhVZHE2VVNkZHVJV0dxbm00Mi9pR2Nm?=
 =?utf-8?B?S3BpYnVkalRqZnFDczRISVRkY0pwRjJYVWlrQTM4YjhCOWx0VGViZTAwWjFB?=
 =?utf-8?B?TXU1RTdpdmRoNUtGV0lXYllpdWxrRHc2Wk8wNjBWQnkzRVZHbzl5RU9OckVv?=
 =?utf-8?B?bzIyYmNlWXBBc2FPY2ttK0VUbVZoaUVEWDEzc2lNVmxtSjNBN1Z5dDdVSmkz?=
 =?utf-8?B?ZVFPUnlZTTlhbVFIdGkzT1N6dStiak10Y0pBc3VhaUJjLzJ6dG5BWHpvNys3?=
 =?utf-8?B?L09RUEkyYXVtS2kyUzVIaUtwYjNmaFRDeEM5YmozTWVVU21BUXBOd3hRWFdZ?=
 =?utf-8?B?WDF6eXBCR1lyMVFhTE5SMUpJMFhlcEtOMHNHNDl6N1pkUG5WN1BMcE9lSUR4?=
 =?utf-8?B?TGZ2M0Y3T2UybU9jNEduN09xUU04M214ZUViLzFZV3lxM3pqWjdzYWpaOWZE?=
 =?utf-8?B?N0VpZXdRa0RiOU1EQWZjY2NmcklTQkhMM1VxMkV6T2lVVTdBMmRCZ0tSOVBQ?=
 =?utf-8?B?d0kwb21SU1ErUnlSTkNXckhLSnJMRCtmUXBKdjJ3bEdDeXZ1UmhiMkVxYjI5?=
 =?utf-8?B?UUxUQWNIZVk2bFBtSUV4dWhWNUFzYTVHSExWMkJkMGM4cDdibXJKc0hqckVU?=
 =?utf-8?B?ZGF2S3hibE9XcjFMTG5kSG12VWw5aURHYnlpTkNBcFFsNVVBVTVpK0IyRmR2?=
 =?utf-8?B?VytBTy9DN0RRYnU4dlNxT0RhNXZPSk5vMkhadHdCV29EQ2RyTjNlYTR2YW14?=
 =?utf-8?B?VTBBNGptZjhRTGZQR3Z0dmdoME9GbzFtWFM4aC9yOUVVd3V0WlpVb1pHbjZ3?=
 =?utf-8?B?bUFwRStJRmFDaVhWRFhTM3NteHYwUlY1R1Y3SFJDRW1ZOU4xbklxMkZYdU1Z?=
 =?utf-8?B?aHJMS3ByTUg0bUQzRElZS2l5ZkpLTHhyK052Q0pBMDBrSTIxTk81TGhEMjE2?=
 =?utf-8?B?OFRoYXJIZllpdjFnVE9kS0MxSkJaVGZKVEd4Qm52amFBdGJKTElYbjB3R09j?=
 =?utf-8?B?V3Q5UnY1clRGNWlVOS9NMm9uR2JXR2JrT3ZvOU5heC9yRkhuVTkxNFBQMkw1?=
 =?utf-8?B?UVVBZURkMU1ONklWdkgzWHZuZVdUWDZ6eWpWeUdtZjJ5bEQ2bDlqRHNMTTBw?=
 =?utf-8?B?SnVxNDB0a3B0eVJwcUVjYWlTR0dOMlBRbThra0gzcWZPcm80VXVyUlQ4V0RK?=
 =?utf-8?B?TDUxRThLMWcwNnMxcFNKWklacy9MT2ZHUGIycFNBbTErUEFYRkgzbk8xM3hv?=
 =?utf-8?B?VDNPSGJ4SkRTVXlJRmpqWHE5Y01FT0FGUGFNQVgvaFVvOU85bDF4dUVsS2xz?=
 =?utf-8?B?Mmk0VjJxVVpYRzV3NS90NEcrZjdVdExaakRTL0ZZMjJDNnk2bWpBYXdvRUdo?=
 =?utf-8?B?T3VaZlFoVUZUUE9qNHJkMzYyZmdHZjVsQVdRNTYzQXV5ZUhMVG9PK2syakNk?=
 =?utf-8?B?VWMxekhsZmZqeXlNSjdRZG42dUdnZzQ4Tmsvbm5Iak5RZ1VMSHhWc0RmNWJV?=
 =?utf-8?B?OGdMYjN5NG5zejJJUzdMelkzUzVpYkNJVGhxblJZdm5WQjl1ZVRvZlAvRzhx?=
 =?utf-8?Q?BDesYN0Q0bPXu2YD7AIeyTIa1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e14fa46-db68-4624-1f49-08dc734d1a64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:03:37.4261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CR2kGgGoC3TLWHvC8b/g8ry1oT2Tv0aYbylQG8ugdXo90hiJtfRCrYr5Xs2LtbHli7pa/vd3XbGZI09RisHUgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
Received-SPF: softfail client-ip=40.107.212.83;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hi Cedric,

On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> We will use the Error object to improve error reporting in the
> .log_global*() handlers of VFIO. Add documentation while at it.

First of all, I think commit 3688fec8923 ("memory: Add Error** argument 
to .log_global_start() handler") forgot to set errp in 
vfio_listener_log_global_start() in case of error.
This causes a null pointer de-reference if DPT start fails.
Maybe add a fix for that in the beginning of this series, or as a 
stand-alone fix?

Back to this patch, personally, I found the split of patch #1 and #2 a 
bit confusing.
Maybe consider squashing patch #1 and #2 so container based and device 
based DPT start/stop are changed in the same patch? Like you did in 
patch #8?
Whatever you think is better.

In any case:
Reviewed-by: Avihai Horon <avihaih@nvidia.com>

>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>   Changes in v5:
>
>   - Fixed typo in set_dirty_page_tracking documentation
>
>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>   hw/vfio/common.c                      |  4 ++--
>   hw/vfio/container-base.c              |  4 ++--
>   hw/vfio/container.c                   |  6 +++---
>   4 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                          MemoryRegionSection *section);
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start);
> +                                           bool start, Error **errp);
>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                         VFIOBitmap *vbmap,
>                                         hwaddr iova, hwaddr size);
> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>                            AddressSpace *as, Error **errp);
>       void (*detach_device)(VFIODevice *vbasedev);
> +
>       /* migration feature */
> +
> +    /**
> +     * @set_dirty_page_tracking
> +     *
> +     * Start or stop dirty pages tracking on VFIO container
> +     *
> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
> +     *              page tracking
> +     * @start: indicates whether to start or stop dirty pages tracking
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
> -                                   bool start);
> +                                   bool start, Error **errp);
>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>                                 VFIOBitmap *vbmap,
>                                 hwaddr iova, hwaddr size);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>           ret = vfio_devices_dma_logging_start(bcontainer);
>       } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>       }
>
>       if (ret) {
> @@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>           vfio_devices_dma_logging_stop(bcontainer);
>       } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>       }
>
>       if (ret) {
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>   }
>
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start)
> +                                           bool start, Error **errp)
>   {
>       if (!bcontainer->dirty_pages_supported) {
>           return 0;
>       }
>
>       g_assert(bcontainer->ops->set_dirty_page_tracking);
> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
>   }
>
>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>
>   static int
>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> -                                    bool start)
> +                                    bool start, Error **errp)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>       if (ret) {
>           ret = -errno;
> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
> -                     dirty.flags, errno);
> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
> +                         dirty.flags);
>       }
>
>       return ret;
> --
> 2.45.0
>

