Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A279CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEkW-0006wX-0m; Wed, 27 Aug 2025 07:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urEkT-0006tr-32
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:55:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urEkH-0006uF-1R
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:55:28 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57R2e3wr3006780; Wed, 27 Aug 2025 04:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xWqg1JuxQ05u6cCFdi457UVs5gLj4L2nEeHhA0poQ
 MY=; b=a3kWeJ7E90H0C27IBcBAqD1/cxEd/Ch26gi4NIdTFRelrB5eNJixwppyc
 KQnjlXb/30MN/37iYXsUWqWc5e7Uk++lb9Pfe8YsGtoGO0YQ7J+pAs9o9X4QmuxN
 jsTrzyRAqWIXCdQWmeKizpGiHILGeF9CDD2GrYWCl7Y2YuKkXjyX32UHQJZa57TB
 nc8j4/KxTApgJQXED4t1cTBgoj1sfOqEk9bAFfANuTlyRgbCoU9i/gOiUgP6CJBy
 o61GBmuA7TL9tJ6rDiQqVcjDcTFklY8DqENW5+/MqCXAyM5No6DQkelaxDN3SHBe
 Z57C2heL7/rHpy4LsMBGIaql7G1HA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2132.outbound.protection.outlook.com [40.107.243.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48sa4sb6ev-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 04:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM+qQA++c//fUGyfk7q+0cdmQHRRCBYDu0kOkMdm+XmKgWtrql5I/Lzy/oeBUeosXJELpB6FxtyHZfu507+i97P1uT2i/oiezlixOHaKYmqo7HrKJCAEr1ktX1uoGp0s3Bwne6BtuUgUetdLbmUrCoHv8Oyg6FBRX9FiTGjrldm6UcASgObxUCao7r9Hn4RyDSvuy9ONfIeKSbsq6yjhGjFojYI55/F2aUXX0nmM1jjUycWZedg6D2s/ZGHEq2TAwLQSAb8wEm1pVXUoUOsA9lumWtj5+dCJfFpvJCNuxHxF2fiyp/gfQANokacajTHGXNo6LcqcHxegIDBMlWZjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWqg1JuxQ05u6cCFdi457UVs5gLj4L2nEeHhA0poQMY=;
 b=L1HJ5LfyYdcoag8HdN3movDAxPrqvdN6HeVNrNrWqeHdREcb/b9dNKBmap9nbxB4i8irbpkBaq0nlaHj3Z0ckvQGDqP7aj0p7iHwvEuspzWKQqjwgHqYy/5X0zj9SDqqvLX3lW3PDBtTsHpQxbSYt+JucVCgQbiqYcfweupJDdABh90ATViyPAeoOxrBcLebTmPIRJ4UCIaHa3IyvOobZUJD0XwbE3HYzl7BEqYg78RxCtf0GZjgIC1G0ztfqD4I1ceEnIaPtL7fq854vo835It4MGpVeuix9qfxhYWtnvAUhPXA+1HBbOFntNdNbJAtQYx6nUnFuz+o2dw4f5TO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWqg1JuxQ05u6cCFdi457UVs5gLj4L2nEeHhA0poQMY=;
 b=nmlMHGyO69ugaX/SXXuK8UlEc117jEfl/k5ZaWbh0C6j+HpUNdUnDG36ehleF754XsdYy1g/BJL0pUoxqAjuV7vknKKzuvPlOUrNr3avh8JMEogwaFf5mW8pCEgIv3UFnx0D03zYEJ2peAN2rmOWbWetZtRI3EKMgg07A8y0hrrlySGT1l90vCm+fKB0qmlFaMtirZv1wPt16FApSNZL8ZyYcookyxoFRM3EU7PDnFIP9LFGvtUI+3O33YknsODp/bU+F8vBrqpDT02QtdjWEqOB3CJpid+eno5WYnhBmUxV0+aCAoPY6+bqR8JSH7YEBUS6clHPA32wD6jxoPPKdw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB7097.namprd02.prod.outlook.com (2603:10b6:5:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 11:55:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 11:55:03 +0000
Message-ID: <ac507895-931b-4fe8-bb18-ba6592a78088@nutanix.com>
Date: Wed, 27 Aug 2025 12:54:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-16-mark.caveayland@nutanix.com>
 <cfeb193e-6902-48eb-b8c5-c74b19f1c481@intel.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <cfeb193e-6902-48eb-b8c5-c74b19f1c481@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0117.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: d1291b02-da5b-478a-3823-08dde5608ea1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjdZZzJkQVI2NXRDUzVaZDJSdC9QeDg0VTd5MWlNZDVUZWxJYW53aU0vVGVH?=
 =?utf-8?B?cXlYQ1M5RS8xVndlQ3Y3bngxV0o5ZEF0aUpUUXhKTzlTby9CRDV5ZUdGeXhP?=
 =?utf-8?B?M0JXMklkTS9ZNWNla09zWFljQTZYdmhZKytPSzY5eEU0WmN1ZkFzbWVoellN?=
 =?utf-8?B?bmxpY0tmSUxkTW41UTlWOWJtYTRJWVZqZ2pvL2puMFJvQUJ0eFBXRWVjK0k3?=
 =?utf-8?B?R1dONWtiZWlvc0VoYXJLZlYvNEQza21IbnBXNGc0RXFza3hlUVJhUzZPVmFY?=
 =?utf-8?B?aFhHK2dQRVd5TUo3cE1BS3ZkUjl3ckw2Y1R5c1Uzb0dhb014bitGaVcreHRM?=
 =?utf-8?B?YnF2YW5CRGdXcUY2L1psWFZlbk4rOHIyamlqSDh0UDhzK01KNGM2aVdhbFFt?=
 =?utf-8?B?ZEYzRGQ5QkJ5RFRvN1h4YVFHeVBzcEl6UHM2aFBDaldIUW9qbzFnb2MrSEZW?=
 =?utf-8?B?V1dWR0tjYVUwMExVMGhLbDdJT2Z2MEw5VlV5K3JkWUJyZkYyajBXbGhJcTJF?=
 =?utf-8?B?Q0swOEZTMGE2OEJLR3FEQ3FoYm5VcURzQTJjVUVCMzhuSkZmMFF4QVRDWStO?=
 =?utf-8?B?STRkQ2owRWlzR0FGWENLQnpYZE1SNHVlLzREMm5LcS9pTGRFZHhJdWRnTVJP?=
 =?utf-8?B?R0gxNTBucW5WZXlxb29PN0FidFRVR3dvb1p4TW5kL2MwVjBLNy9sRnFBYlZt?=
 =?utf-8?B?TTFwaFIrNHA5YytSOC90MThrOG9jR1RGV2xqUENweSsxTGpzUjlnMmRSeFFy?=
 =?utf-8?B?RFErVGc0ZHcwME53UklSaWpZY05FbFh3R0Ntbm5Vd2xPbkZ4ZHJ0cWJUWVNs?=
 =?utf-8?B?dmxVS0JGQTJtWmRJaC9OSzdvSU1mWWwvajE1T3RGaXc3TWwxa093SXFSV2NR?=
 =?utf-8?B?c0lSaU9zbCtqd1VQMDNvbVdxUWRVSmJVRGRMRDAzdkVMTzZWNnBNYThRN051?=
 =?utf-8?B?WVVaNFkwSUJtRDc3YUNpR3NKRnpiUGZJOXpaSDhTWU1qc1ZuR3lJTlV5L3I2?=
 =?utf-8?B?SWpvZjA2QnNCZmpJelVxanNKSXlibzVpbGxYK0dlL05Pa3FRNHhDc1RYbCs3?=
 =?utf-8?B?OE9TTWxCb3NFaTZ5anluT1ZTUm8raGI5Q284enZtVk12NzFUSHJVMWVrTGtu?=
 =?utf-8?B?WFJjMm85Z0tCWDR2ZXNsZFptd0FCZ20wYjh2R3V0VDdiaFRINlJ4QzlCYjNL?=
 =?utf-8?B?aXlXamQ5SDdYc3dXa29sZlNVc3FXay9PSmN6MDFJUVVxVmh1U2NZb1l4bUZy?=
 =?utf-8?B?TEpiaGZka2ZQL05xV0V5SnBpTFlnLys2VC9pWmxXb2hQWWRhc29hNFQ1bzhy?=
 =?utf-8?B?ZC9hckhtVG52TzRQTWQxS0tMUjc4TU5EYkdwMllEUjhhMnVzSFRmWkhqVFJ1?=
 =?utf-8?B?ZnBqMHZUMFAxZjVUNUR0Nk9rbEdVZTdNUVBPaWNyRytZV3VQQkRvVnlTaTRX?=
 =?utf-8?B?MkUvVHVPVENKejZWWnByenpXY1ZQbGxOMXFPUGJJcDRDV21EUGJURGJLeWR1?=
 =?utf-8?B?TnNJV2lNM1pDcndLUWd0UXZyTExvbGFicUsvRTZGNFhkNWhlWXBtR0VkdktU?=
 =?utf-8?B?Sk5wMEI2MUVkUUI1eUkrQTd4NjdoeVlseUZFSE02VDhvL1VldWFkU0lxY3pD?=
 =?utf-8?B?Z0tmQWUyaU5VZmFBY1JjdngwWmYyMEZqOUpUMXp3dzUxaHdmVWFDQnQzTElm?=
 =?utf-8?B?ZkpIWFJuckhSN1phOHdycWlTREZWRi9iVlYvRXJQcjdWVGlpTzF1T1JodUpC?=
 =?utf-8?B?bnlwQUVJUWNiNFRKcHJLRWt1aWUxUmFtcHEyVVNwN1FIbDJrbHNjazAzN2R4?=
 =?utf-8?B?VkFZUU93Z0NwSTNyc1M3NGVkOFBwUC9oaHlNOEZId2drbU9rQllpOGFNdHFX?=
 =?utf-8?B?ZGlBSERnRXgydkg1NWxsckdoa2FZaG5EVEtsRG1SbCtwd1lHYURnRlZnLzZR?=
 =?utf-8?Q?HngECU3R/Co=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9SUXNxUzc1RFl1eStmZkx4Mlp6NmZkZ1phZDcxUFI5aHNEWWhCZ2FsZ1Fq?=
 =?utf-8?B?ZkptQ2RrQzVSTEtTTVBxWHVFUVBMQndFbW02R2MxYU1HbEREK0NWM1NzRGpk?=
 =?utf-8?B?T1VENVQ5NXhBcDJrMHh3aUd3VFhEekhZWG9ZOEd0cFpENHIreUJEcGtEdzZX?=
 =?utf-8?B?UEpJVTBmTmF5bjZzRkFNNDV6ZGNBbHRsaU1WaUwrOVFmRGdPVFVTT2JmWE90?=
 =?utf-8?B?ZkhuNjhseFpldUFvU1JxT3VCUGJHOFgxT2h4MDFrTUxUdVNkSzJtVnFSdTNi?=
 =?utf-8?B?bXpEWGphTzNKekxBMURDcFdUQThFSTkxV0hoUVFQb1RkZWpSeGNsbkRLZ2Rm?=
 =?utf-8?B?amVyRVIrbFgvelpsNVlXczJCSnVzTTI3RDBkMWN4aS9YVVB1Nkp2R2VPbDlO?=
 =?utf-8?B?WmgyYU9KSDFtRVZ1MURWOFEvRHVkR3VyWFVkaWROaGF4N3QxZkxDR2lxWGNU?=
 =?utf-8?B?RDZLN0hMREp4MUJVQk8vV2lhT0RuVzVZODFWMHNVTGlIa0duQnNLcG9zUmJR?=
 =?utf-8?B?YzFwUitQQTVSbTlkbG5HeC9nZjFWTDk2cElMMkxoOFBvUjdGWmozV09JbUxa?=
 =?utf-8?B?V3ZSOVpkY0lXS1drc0YzcmVuVkdJdnNOZWVvK3d6UWMrdm5xRDhTa3c5OTk4?=
 =?utf-8?B?a2FuMzM3bjMxLy9nckUrcjI0YSt4NjlaKzVhWnBXUGd1ZGxTeDVBOGhrOXFa?=
 =?utf-8?B?SS93NlVwZW5uYXVMUG9JWWdrOURYWnlFOWMrV2FZN28yYUZHQW1WMXRJSzgz?=
 =?utf-8?B?K2kxeTFVTlZabUx2OVNmeDlCVU9JQTFaaHE2QVZIQlhrOHVBUkNtdW5VajQw?=
 =?utf-8?B?RXlNdUlFTUxkNTdkbkY5M0dPOW1MWVhudzhHeXZRV1h5cThMdzZxMFpwTkJa?=
 =?utf-8?B?RDlRSFRSbDBnMWk4ZHpCMU1iZ0pGNm5HTS9BS2tzcGp0bS91eWd3MFJmZTdP?=
 =?utf-8?B?Wi9WUGkwOEdGaVZNbVkzaktydXFiUVZHUlJKUlpXS0g3RXFSeStjR3RjRkZY?=
 =?utf-8?B?eTlWSE5TMDc3eVNrUHZ3Z0RtMlMxQ1NLazRrbURqcWJpMm1hVHZoQVRzWTJo?=
 =?utf-8?B?NW9tOUVGWXdFdEl0YWc1cC91TmtIUzdvWDRyai9HeWx0cWY0c2FYK01ZNFE5?=
 =?utf-8?B?RlBJZWFkdnM0NXljTGE4R2orQ3ZKWjhIVHlRQnJxcnQ2TmU1cXdObmVvY09K?=
 =?utf-8?B?eDBkSStHWDV3aDFTcmsyMWRqVHN5dmJVVSt6bFhEOGpZUmtiTWkzdUNlZEMz?=
 =?utf-8?B?U1RiTkd0K08zWlV4Y1hwNGJmS1ZsbGdISUt4VEJWWUZ0aU0xYldFRVZ2c1U5?=
 =?utf-8?B?UnAyMHNHZGtjTllRZXNObTZ1WjYvNlRubklnV0ZOMVBHbWNZRmZzRUg0ZFJQ?=
 =?utf-8?B?QzR3Uy93a3dVSzUrUEw5Tk0vZGVpRUdEWjl3YmEzVHZITkxCQkg2Q2x1ZnRK?=
 =?utf-8?B?SldsMXpUWGFSYys3ekJGWXBNNnY5L2lQaXc4MmQ2cVFzMVdRdWJ3WVdLTDEr?=
 =?utf-8?B?TmVPdTlVWFZuc2V2QXNVcjNUU05MNlJUUjdyTWZlaklEeUJEdnVJalBzeDY2?=
 =?utf-8?B?NEVTbnNFakFmL1MvZDNZWEZSL1pvTlhXTTk0L25EUlozQWpjNXh6VllrREZw?=
 =?utf-8?B?anN6NTBPT09JZ2lNMXZpZS9PT3M2c2lPR1A5YmJJRitjREQxTHZmSVoxeFMw?=
 =?utf-8?B?TDdpdURGU0pMWGxLcHB0ZnoyWlRBb0pIZUQrY3FlYUVjN2tJaE1Od0liZTBk?=
 =?utf-8?B?dzV0NEpkVUtBMmhRU1RMNHg2a3QwSGRhY1pVb0V6WHpQQnhwN252Z3cxRGFX?=
 =?utf-8?B?eUtWYW01SjFuUTE0aVVmR0lzdnBnM281SzRENVpYMmx5eHlqV2NHNE9rZlQx?=
 =?utf-8?B?QzFsa2tUU2F5b2J0elBMc0ZkemVoR0dGUC8zQzhVYVdsM0NaaUpNWW1GVkRp?=
 =?utf-8?B?ZlMvWE9qYW1QVmNYMVJ3U212c2dSeEoyTkxRVHU5TmRaMzg1VVRqZGpXazZz?=
 =?utf-8?B?a0R1RG9rQVNuTUQwMU51alhVMTUzOUFwZE0xZnN5eHI4TlZUOUZCL2tsbGt1?=
 =?utf-8?B?SEFWWEd6d1pJRENxSXZYc3dEd2dDejZDNUJMbThjZXNjNFN2anpzNUdSamJB?=
 =?utf-8?B?S3JOTW96TVVKUDl0YlNGTGFJc2lyajA5M2h2QmJIU3V2dmNzNnpCMWNFQ1Zk?=
 =?utf-8?B?UElLL2ZRajdWNHI2bFhOa3FGaGN2b0w5Znh2N1NEMFdvSEhKeGMzVldLYW51?=
 =?utf-8?B?K1RaZ05CMSt0ajNMVkVPaTFxeUlRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1291b02-da5b-478a-3823-08dde5608ea1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:55:03.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96Y0kThWhLI30iki9IPe52QzjB5Y8ezX/zLeWvev+egMLlJaTQifaAslzep1lkA/iCGpqJJI5hLsk6Ytt9WtJB7XCAtKDzSIrANbOP/LllU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7097
X-Authority-Analysis: v=2.4 cv=HbgUTjE8 c=1 sm=1 tr=0 ts=68aef219 cx=c_pps
 a=CixL6RxEtn7Qem6gLs8pAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=5ggjaT7wEm3JlHp2C5MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: tLNpht7lOqKldcXH6zQq_GuRRv5SAL02
X-Proofpoint-GUID: tLNpht7lOqKldcXH6zQq_GuRRv5SAL02
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEwMSBTYWx0ZWRfX3Z2vYNn4K6BT
 AA4xORedCkX6JBHU7vsSkz4LdB+5FoVw14xmYJ+p4OLZGwwFTBj9rbSLIa0WTnn7cSZa+ouei5p
 OOGkYmTzQORI25krZCpUPiLORLvieqpwSVZWYzpn2apa4N7oF3YU+xtkLyehjhXRhu7k0xzXTWV
 xpZvR0YnUFsI04fA7aXkj2EaeKo8kR0UrM1CVjVyZVSF1VH9k5ZpoZLUwNSQc2c6PoWVaEr2rzs
 dV5xzqbUvHCHjsUWlAlUFvIwFi1CCmsaj/48R7kW9wBWoyCbFd2tTzjpq2i4rtmBRYiujy30Am+
 EOdu9jJfCjP4ycKxl8qkbAAZ+jS4JHUc2ew3ZTIBb4bnZ0/0geLf2cu1DmVTtY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 26/08/2025 13:09, Xiaoyao Li wrote:

> On 8/22/2025 8:12 PM, Mark Cave-Ayland wrote:
>> PCI is always enabled on the pc-i440fx machine so hardcode the 
>> relevant logic
>> in pc_init1().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> some nits below, otherwise
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
>> ---
>>   hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
>>   1 file changed, 76 insertions(+), 118 deletions(-)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 49bd1a41e7..a776998504 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -71,7 +71,7 @@
>>   #define XEN_IOAPIC_NUM_PIRQS 128ULL
>> -#ifdef CONFIG_IDE_ISA
>> +#ifdef CONFIG_ISAPC
> 
> This seems unrelated to this patch?

Ooops I think this must have slipped in when working on an earlier 
version of the series, but I believe it can just be removed.

>>   static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
>>   static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
>>   static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
>> @@ -125,6 +125,9 @@ static void pc_init1(MachineState *machine, const 
>> char *pci_type)
>>       MemoryRegion *rom_memory = system_memory;
>>       ram_addr_t lowmem;
>>       uint64_t hole64_size = 0;
>> +    PCIDevice *pci_dev;
>> +    DeviceState *dev;
>> +    size_t i;
> 
> Suggest adding
> 
>      assert(pcmc->pci_enabled);
> 
> like what pc_q35_init() does.

Good idea! I'll add this into the next version.

>>       /*
>>        * Calculate ram split, for memory below and above 4G.  It's a bit
>> @@ -195,38 +198,36 @@ static void pc_init1(MachineState *machine, 
>> const char *pci_type)
>>           kvmclock_create(pcmc->kvmclock_create_always);
>>       }
>> -    if (pcmc->pci_enabled) {
>> -        pci_memory = g_new(MemoryRegion, 1);
>> -        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> -        rom_memory = pci_memory;
>> -
>> -        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
>> -        object_property_add_child(OBJECT(machine), "i440fx", phb);
>> -        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
>> -                                 OBJECT(ram_memory), &error_fatal);
>> -        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
>> -                                 OBJECT(pci_memory), &error_fatal);
>> -        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
>> -                                 OBJECT(system_memory), &error_fatal);
>> -        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
>> -                                 OBJECT(system_io), &error_fatal);
>> -        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
>> -                                 x86ms->below_4g_mem_size, 
>> &error_fatal);
>> -        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
>> -                                 x86ms->above_4g_mem_size, 
>> &error_fatal);
>> -        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, 
>> pci_type,
>> -                                &error_fatal);
>> -        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>> -
>> -        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), 
>> "pci.0"));
>> -        pci_bus_map_irqs(pcms->pcibus,
>> -                         xen_enabled() ? xen_pci_slot_get_pirq
>> -                                       : pc_pci_slot_get_pirq);
>> -
>> -        hole64_size = object_property_get_uint(phb,
>> -                                               
>> PCI_HOST_PROP_PCI_HOLE64_SIZE,
>> -                                               &error_abort);
>> -    }
>> +    pci_memory = g_new(MemoryRegion, 1);
>> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> +    rom_memory = pci_memory;
>> +
>> +    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
>> +    object_property_add_child(OBJECT(machine), "i440fx", phb);
>> +    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
>> +                                OBJECT(ram_memory), &error_fatal);
>> +    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
>> +                                OBJECT(pci_memory), &error_fatal);
>> +    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
>> +                                OBJECT(system_memory), &error_fatal);
>> +    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
>> +                                OBJECT(system_io), &error_fatal);
>> +    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
>> +                                x86ms->below_4g_mem_size, &error_fatal);
>> +    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
>> +                                x86ms->above_4g_mem_size, &error_fatal);
>> +    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
>> +                            &error_fatal);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>> +
>> +    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
>> +    pci_bus_map_irqs(pcms->pcibus,
>> +                        xen_enabled() ? xen_pci_slot_get_pirq
>> +                                    : pc_pci_slot_get_pirq);
>> +
>> +    hole64_size = object_property_get_uint(phb,
>> +                                            
>> PCI_HOST_PROP_PCI_HOLE64_SIZE,
>> +                                            &error_abort);
>>       /* allocate ram and load rom/bios */
>>       if (!xen_enabled()) {
>> @@ -242,72 +243,51 @@ static void pc_init1(MachineState *machine, 
>> const char *pci_type)
>>           }
>>       }
>> -    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
>> -
>> -    if (pcmc->pci_enabled) {
>> -        PCIDevice *pci_dev;
>> -        DeviceState *dev;
>> -        size_t i;
>> -
>> -        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
>> -        object_property_set_bool(OBJECT(pci_dev), "has-usb",
>> -                                 machine_usb(machine), &error_abort);
>> -        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
>> -                                 x86_machine_is_acpi_enabled(x86ms),
>> -                                 &error_abort);
>> -        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
>> -                                 &error_abort);
>> -        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
>> -                                 &error_abort);
>> -        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
>> -        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
>> -                                 x86_machine_is_smm_enabled(x86ms),
>> -                                 &error_abort);
>> -        dev = DEVICE(pci_dev);
>> -        for (i = 0; i < ISA_NUM_IRQS; i++) {
>> -            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms- 
>> >gsi[i]);
>> -        }
>> -        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
>> -
>> -        if (xen_enabled()) {
>> -            pci_device_set_intx_routing_notifier(
>> -                        pci_dev, piix_intx_routing_notifier_xen);
>> -
>> -            /*
>> -             * Xen supports additional interrupt routes from the PCI 
>> devices to
>> -             * the IOAPIC: the four pins of each PCI device on the 
>> bus are also
>> -             * connected to the IOAPIC directly.
>> -             * These additional routes can be discovered through ACPI.
>> -             */
>> -            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
>> -                         XEN_IOAPIC_NUM_PIRQS);
>> -        }
>> +    gsi_state = pc_gsi_create(&x86ms->gsi, true);
>> +
>> +    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
>> +    object_property_set_bool(OBJECT(pci_dev), "has-usb",
>> +                                machine_usb(machine), &error_abort);
>> +    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
>> +                                x86_machine_is_acpi_enabled(x86ms),
>> +                                &error_abort);
>> +    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
>> +                                &error_abort);
>> +    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
>> +                                &error_abort);
>> +    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
>> +    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
>> +                                x86_machine_is_smm_enabled(x86ms),
>> +                                &error_abort);
>> +    dev = DEVICE(pci_dev);
>> +    for (i = 0; i < ISA_NUM_IRQS; i++) {
>> +        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
>> +    }
>> +    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
>> -        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
>> -        x86ms->rtc = 
>> ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
>> -                                                              "rtc"));
>> -        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
>> -        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), 
>> "ide"));
>> -        pci_ide_create_devs(PCI_DEVICE(dev));
>> -        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
>> -        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
>> -    } else {
>> -        uint32_t irq;
>> +    if (xen_enabled()) {
>> +        pci_device_set_intx_routing_notifier(
>> +                    pci_dev, piix_intx_routing_notifier_xen);
>> -        isa_bus = isa_bus_new(NULL, system_memory, system_io,
>> -                              &error_abort);
>> -        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>> +        /*
>> +         * Xen supports additional interrupt routes from the PCI 
>> devices to
>> +         * the IOAPIC: the four pins of each PCI device on the bus 
>> are also
>> +         * connected to the IOAPIC directly.
>> +         * These additional routes can be discovered through ACPI.
>> +         */
>> +        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
>> +                        XEN_IOAPIC_NUM_PIRQS);
>> +    }
>> -        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
>> -        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>> -        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>> -        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
>> -                                       &error_fatal);
>> -        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
>> +    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
>> +    x86ms->rtc = 
>> ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
>> +                                                            "rtc"));
>> +    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
>> +    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
>> +    pci_ide_create_devs(PCI_DEVICE(dev));
>> +    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
>> +    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
>> -        i8257_dma_init(OBJECT(machine), isa_bus, 0);
>> -        pcms->hpet_enabled = false;
>> -    }
>>       if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == 
>> ON_OFF_AUTO_AUTO) {
>>           pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>> @@ -321,7 +301,7 @@ static void pc_init1(MachineState *machine, const 
>> char *pci_type)
>>           x86_register_ferr_irq(x86ms->gsi[13]);
>>       }
>> -    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
>> +    pc_vga_init(isa_bus, pcms->pcibus);
>>       /* init basic PC hardware */
>>       pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>> @@ -329,28 +309,6 @@ static void pc_init1(MachineState *machine, const 
>> char *pci_type)
>>       pc_nic_init(pcmc, isa_bus, pcms->pcibus);
>> -#ifdef CONFIG_IDE_ISA
>> -    if (!pcmc->pci_enabled) {
>> -        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>> -        int i;
>> -
>> -        ide_drive_get(hd, ARRAY_SIZE(hd));
>> -        for (i = 0; i < MAX_IDE_BUS; i++) {
>> -            ISADevice *dev;
>> -            char busname[] = "ide.0";
>> -            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
>> -                               ide_irq[i],
>> -                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS 
>> * i + 1]);
>> -            /*
>> -             * The ide bus name is ide.0 for the first bus and ide.1 
>> for the
>> -             * second one.
>> -             */
>> -            busname[4] = '0' + i;
>> -            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
>> -        }
>> -    }
>> -#endif
>> -
>>       if (piix4_pm) {
>>           smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, 
>> first_cpu, 0);


ATB,

Mark.


