Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8715C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYdS-00059L-UC; Mon, 27 Jan 2025 18:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tcYdP-00058i-II; Mon, 27 Jan 2025 18:35:16 -0500
Received: from mail-dm3nam02on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2405::627]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tcYdM-0007n7-Bw; Mon, 27 Jan 2025 18:35:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWkiEzr2Dhi2irpVfSFzrVyIUYkqlf5lUuXN8zDGlAQYellXw6r7gO3Z47bqcpYQZkU2BwFkO6Ybw2gyAb048mnBIw0nUSRxINzJ+5dHk9ODvmJONC2uF2DrwFVambsEwpLbEiQLs4F4+IMACFNGUMXWv5VyEoW1XOX6T+K0g+4IvltkX6d7L8M/c9egdjrS7LLkRegEj3enVXcqmOUP4HLEnupvnfhaQ+adgj71dsHpMA+NWx7lLkgeIFQwldE3yHZVdcs+ORM5OmwQNyxr5uyRO5J/HDEUTp3A0t5vFG5rn8eIRifLpUxVMoqlLamLkuuSkHMJzL8AZNfgPiLLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=569dR6DKFKFlRC0xBC/AxxgRxJZ+HOsMiQLZy7s9W4o=;
 b=fs89hDPB+sb9sI2/6iplzBKLNTD5ooSHT2PPGawKHeTTKtdVELhQjfWHSy5Td7meUJ/8khTkn2NWn2s/qgyHpve1xIwizhtcyqsNyqlUBVQa4+2nXk5zmbEL2qz9sD85iPGKuM2aFru5oEZ8HWtlD1OlzQ2rqswqbOQZIOTgErxAbrkWY826DOjRT0hvGYP2psHyYrjGNtXhECxeN/BmIEZGM/IUzFv8BWK5Lj/9iBUO8JncBtRnmRPIYMLGEgX9uk1sfdaIYrG+UbJlJxD+dhrtCRkYrkF6QWpd/EOPf80qJQ2cztV864SuqfMn58uSddyGTvcjxCtwHH53mRioJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=569dR6DKFKFlRC0xBC/AxxgRxJZ+HOsMiQLZy7s9W4o=;
 b=hLS/IufAxg9ZISoNdNxDliGq9oQGuwDjSaPDn2qJU84tYSVDu/TkmifvzPycDaH3JqSrxW3v9kczP7srJjQxFvdMuV5Fv6mKw0cZIog+9hxcxREE2yLWQLgA+qfpPgUVYhMuix3Ed0+P6LR2k9RuYFk6SzGlZ+O4CjQtNVCWoA93Lupmn8nfjsf5FvGKxGss898bBhucJOuRvBzmNmprX33CvP0GGb4Prp9jlaVEib0llzNpLpvqcSg7sK3WNzqxFlAZ7vmFLqE6zK5bJ3nWGQfM4cxrnN8UFYaelRU/Bl9373sB3BSUI/DRKgJTO84H0Q62lCi4/6+Sia9JPyJuYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Mon, 27 Jan 2025 23:35:05 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 23:35:05 +0000
Message-ID: <352ca3c2-b808-4328-a57b-0563e7eb189a@nvidia.com>
Date: Mon, 27 Jan 2025 15:35:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "ddutile@redhat.com" <ddutile@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, mochs@nvidia.com
References: <31db1f75110e46ccaffffb801e894605@huawei.com>
 <a80c78fd-6203-4aca-a3d3-d67a68b8e595@nvidia.com>
 <0b281d2f8ebf4368b7e7b97aa0a4cfd3@huawei.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <0b281d2f8ebf4368b7e7b97aa0a4cfd3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: a73942cd-fed8-435b-11a8-08dd3f2b3a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NCtVYjdmSXZVa1hPRHFmYnN1OGhvMVZjTWJ6bjNyRHQ3SDJrSi9UTmM5Wk9l?=
 =?utf-8?B?MjNMK0hxaUp0UExTeU1FSHZCY2FYVHhsc0gzM2J3Y3JxUE5kKzZaNW1TdUg0?=
 =?utf-8?B?UDlOVW5QYVFKSDBGU09laXhxdmJOUU45eGRrWHdTYU83Wmg4aTN1RXV1c0F6?=
 =?utf-8?B?d0F3cWYvZmZnSHNQclo1aDdtMXZySXpFbW1FMkw2bXFQT01TdGk5VEFEZDdJ?=
 =?utf-8?B?dERaVzhmU0xFSkxlUnVWemhRbDRmMFF3WXdDMlRUOTBGenRDUXlocml5d2Z1?=
 =?utf-8?B?dVp1bExDSDdOOVBFOUZqTEpGVUk4YzBRby9ubFlSL1NTM0o0UEttdEl4SWdP?=
 =?utf-8?B?TXM5MytBdVpxdjhPdjZmU0FGMFpIUFVtTGZ6NEsvVWYvZXZibUFPcVB3UkpX?=
 =?utf-8?B?UjhtWEdDeEFKNmFOZ09nYTlDT25Ea3Q0TXNZaHROMG8zMlZNdXR3TVdLUVhL?=
 =?utf-8?B?K3I2Y2s1c1FvazdnVXpQUlluVkxBS1RyYUdSRU5DN1o1azNhMC9Hc2VvZ0hI?=
 =?utf-8?B?Tys1cldHY0tBTlkrV2hBanN0RFl2Q084bTdZYkxMTzVkMUp2ZWpiaDU2ZTZ3?=
 =?utf-8?B?aXdCTHp6c1l1WWd0UWt4TjNOaEthZkpMSzdxZnkwUndiNXBZSjlmeHdER0hw?=
 =?utf-8?B?TCs3c1RLOUU4S3dSZHhGVXNBQWNOT0VDSG1WaGJRblpnQTdkeHBtbjZQVERz?=
 =?utf-8?B?K3QrUDNiWHVzRWcyejVoYTVDWG1lQUtQUWo3L3VIVXhIN25QWWJQWUJVcE5J?=
 =?utf-8?B?V1Z4YlQybWdOMnRpOXRGcWo5ZkZMYlhxQzVSQkZ2eWEvRVJXQXpKcnByeDlw?=
 =?utf-8?B?WWVvWVM5dzZTbkdwQWhGbDdoVE04Z21DV0ZnSHZNMVNUeFBMbnZta0JLUkM1?=
 =?utf-8?B?cjBmcTZyUXNkamNobjB6OHhtQy9Uakp3QjZ3VWdUY0xIQWJEMkZpSUVDY3RD?=
 =?utf-8?B?Z1hGVEV3WlVWbXRkV0FTQjVpbXFkeXdTQkxzVDJQMXF4RllCUnkzQVVMUkhL?=
 =?utf-8?B?S3ZiWFNUQ3hSUGRYVTlSbTFtSFcrVSswQ0tVWjNlU3l4QWh3ci9XOEsxOXI2?=
 =?utf-8?B?V25zU1hPd2RxVEdneTZ5M3dtQ0pMVE12Q003RjF5bGVDSGxCbHFET1R4YmZl?=
 =?utf-8?B?MkxkRGNpV3pzVFlHTE0xVTFjV3VrOGRwM0JBanNCUE9NSFZGeUxVVTMvNnlR?=
 =?utf-8?B?VHQ0ZlNzblB0d01zc0tEQ21JZ2dsVmRNak8rUFVDNHdqUzljS3ZldTVkakRo?=
 =?utf-8?B?dHA4RmJWanRVMFgzcGlwQVR6a2hOOTNNY1hFblBMSVdsYmdOOUJhSklNSXFu?=
 =?utf-8?B?N0IyS3FZUDYrckVhVGpsY0NIL0t4QklSdlFlYk9Rc05RMjcxSW9jRnZIU3Ir?=
 =?utf-8?B?K0owZ2pQV2dOU2Fnckt2YWR2OVZ5RzN2WXI2R2k4a1VJTnU0aUxqU0E2VE5i?=
 =?utf-8?B?YmE2U2NrSjUyQnlUQTA2b0RxM1NEVHBLdk5Ra1A1b0NCbE9Yc2dHNEJtZ0xU?=
 =?utf-8?B?YXZTSWY3d21NSjlCcXZJK09lTHA0eUs5T3V5ODAwcHF4RFVuNm5BYnZ5MmdY?=
 =?utf-8?B?Y1hIK0s3ZXRZdWhLWXcvWmYrdG9KRDlRSWNWRStsNGM0RVplRVNQQmQxMzZZ?=
 =?utf-8?B?Tmh5clVra09lYjh2NDdkY1BCQzdhdzJiNlVQR3lXMm1wNnBaM2txTjFOeWo2?=
 =?utf-8?B?WTMreElUVnZxbVVPcVZkd2lMWHRiRGVVeE9VOUZUS2cveWg0ek5tVjdsODRD?=
 =?utf-8?B?eDdZR0ZSOVo1WFBkY2Jwem5HdVQ1c1VETDF3V1A4MmQvT3FDTzFWcXhXaVpx?=
 =?utf-8?B?bHdPOG5pb0Mya3N0WnU1RFN5eTNMVy9PTXBTS3MzOGhGNmQwcVVpNXo4V2FI?=
 =?utf-8?Q?dhRQ+/0qI7LlS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hPMTdEOEVWaEJnckNVVGtvS3lDTlZLQ0xHN1NQcXpKUUN2WU0wTDFXNi9U?=
 =?utf-8?B?WmhESnJkQVhHTnVsL3o2L1JPVEJkcExOM2FBd3M3a3RndHAyNHhJYjFQdUZv?=
 =?utf-8?B?dEN2QldYd1hUN2xpbzdTVWJDWEtXcUFDd0hLWEFvbFVzUWZ1TUZSVzRXV1dv?=
 =?utf-8?B?eHhQN0hSUDd3OVBtS0Q2YlQ3RmhORksxallKSkt0Lzc3Nm42cDFINTR1R3V0?=
 =?utf-8?B?b2Iyc3AyN0dpUkE0TnEweThTUDhraUpvM2pBWGttUDhxNFUrMWtRaDcrUWFU?=
 =?utf-8?B?UVVMK01WR1JmQ0FLTS8yQ1laVFJWekFIY2ZqQjd3ZGtpcE1NZXoydUhZZTha?=
 =?utf-8?B?NnlsbUYzMmppQkU4QmJYUVdTZGFYZ0tvTUlFc0dGeGNJWEVWcnc4cnN6RUNj?=
 =?utf-8?B?RXVDL1ozNklLZ2dHL1RrazMyUXIxWXV0eHFQdFVkR1U4YUs4aW9SVkdrdm5o?=
 =?utf-8?B?ei9qZlgrWDZoS3hDVWNpRjhSUm1GTTYxTWdvWTBRQWQzTkFNWGJoSVh6Unp2?=
 =?utf-8?B?NmhwSmFNVDFGRnRhMDZvQW9sU3p5NkZpUkNaVWJmUVpjdkxvaXI5OWJOeDB6?=
 =?utf-8?B?ZGVLMGhXQ2xKdG9zTXhNc2RpRTNUbnFBajNKUHd2SUtGZlZ6VjF0M29QWE9U?=
 =?utf-8?B?bWxDMFdqRUpub01MTXRSQ3ZmelN2V2dOU215Mmx4bUxidHRTOEJXbC9YTWU2?=
 =?utf-8?B?RW1zM1RZR3dSbjEwcWgyMXNUakQvb0VGU1dCTU5FVDJqWlh5UTMyN3RHTG5Y?=
 =?utf-8?B?eHRLRDQrN3FxcEI0bFdXUkFhNXJWZUNBNzNmS2s1WnNxWXdlV0IrZXJTdXFk?=
 =?utf-8?B?MEw1OW1EUGxkRFFvbnRDSy9IaGY4UDJSN25aMzg1TEJoL0J0RCsrWm1mT3pp?=
 =?utf-8?B?WDBmeTZmcXJnWkMzUUZjQ3Y1K1NNN3hZTC9qcFZEbFlxL0hWTnZXdU9JWE9Q?=
 =?utf-8?B?bkRsWnFrY055cWFISGZ1dGw0c3lRQ1pjenJ0ZmdrekYrL3o5TEFwdnYrMmU2?=
 =?utf-8?B?bENvbzN2bVB2NXJUT3Y4UWRDWVkwUmEzdE4rQk85a0w5NjVybitUNHdwNDJE?=
 =?utf-8?B?SWNFM3diNkNCU2ZLZnlKUUI1dlF1QitJRG5sYTdPbGVRSk9RS2k1MGt2NHFn?=
 =?utf-8?B?RERzYmFsTS80WEVETTdHWndVN0tDU2pkU200QkthSEJVWVZkNUNtcjV5WWVE?=
 =?utf-8?B?dGorY0dhMFI4QWt4YzRGYlBxSVB3MlJxNnZqOStnU0NBNVRvcklVa1Z3aUZZ?=
 =?utf-8?B?WFIzUzU4UEVxbmJPcHN5ekRobXpWcGduYTNZWEc4NTN0VVRWYTR4MGhrTkhY?=
 =?utf-8?B?Q21UN1lMVjJYZWJpSmF2VlNBbG5Nd0s5dVlMSTl6V3dwMjN2cU5PaWJrQWEy?=
 =?utf-8?B?dmdnN0dLWk5EMGJTMkxvYVQ3WXZqYkFMYlQ4azRtTFAvSzJrMXJobFVqazRT?=
 =?utf-8?B?NWtyenlPdW5hSHB0Vjg2YnUzY1dBUU8yMFRHM1FCUTRHVWlXSTJrVXFMSDVy?=
 =?utf-8?B?Tk1ycTZmaEtsS2J6VG9CR2tRczJvdkRUYXd2WEV1dDZrVnR1Q0I1WklHSWZV?=
 =?utf-8?B?R2dqcmxBeGN0Z3pDTlAyeFl6ZkxDbVRSMXo1S3RPKzR6d09qMXhhRXdVNHdP?=
 =?utf-8?B?YmxFQmVaZHZQZ3BSVmsyYmNwMVU3K0lINXdycyttVDZMaHdhMk9tc2orNzNF?=
 =?utf-8?B?clRCTnkzOEdTdjNEcEVGZno3cGJKQklXenQ5NVY4Y1g5TGtIeXpDbWY1elBO?=
 =?utf-8?B?WllwakM2QmxSN3pDeWVaSmpuMmk4emlLcUxqWjJ2MnQ3SGp2OW93M3pGb283?=
 =?utf-8?B?OVk0L0xZM1pJSW92dWVPRU9vak9TYmpnVGcwb0dOR2hITmQ1L1dDaE16ZVdp?=
 =?utf-8?B?Z21SSm5kUDFSUEhFQUlNcC9ZcTNZSHEyY0EwUFlPVWMwdVlsYWkyZ1dwd0x1?=
 =?utf-8?B?bXJYeVZlRnJKRldVdHN1YU84RXBNcTNneHN0QllSZ1ZwMWpPVmFSbzBVaTBs?=
 =?utf-8?B?L0hxVHpyYkt0cEVWR2FNMEhhbXkzWTdRRHhzM2owcStVRXdKS3J0bjY0eGxN?=
 =?utf-8?B?V0lhR29vS2J0YmIxRzFCZmlxenp0YTRwVnpoNjRPWTYwMy9qY0g0Y1RRdDRI?=
 =?utf-8?Q?iZOqxma4iFYbS4gUx4Jty7Mfd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73942cd-fed8-435b-11a8-08dd3f2b3a11
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 23:35:05.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENXneyHtiZFp4EBN34KpM7Az4eKslQ62kQi3r2+zyovmzhociQyzL+zlpTgs1DJYmnECV7m1gJ4Qkcgyv9Uz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
Received-SPF: softfail client-ip=2a01:111:f403:2405::627;
 envelope-from=nathanc@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>>>>  >with an error message indicating DMA mapping failed for the
>>>> passthrough >devices.
>>>>
>>>> A correction - the message indicates UEFI failed to find a mapping for
>>>> the boot partition ("map: no mapping found"), not that DMA mapping
>>>> failed. But earlier EDK debug logs still show PCI host bridge resource
>>>> conflicts for the passthrough devices that seem related to the VM boot
>>>> failure.
>>>
>>> I have tried a 2023 version EFI which works. And for more recent tests I
>> am
>>> using a one built directly from,
>>> https://github.com/tianocore/edk2.git master
>>>
>>> Commit: 0f3867fa6ef0("UefiPayloadPkg/UefiPayloadEntry: Fix PT
>> protection
>>> in 5 level paging"
>>>
>>> With both, I don’t remember seeing any boot failure and the above UEFI
>>> related "map: no mapping found" error. But the Guest kernel at times
>>> complaints about pci bridge window memory assignment failures.
>>> ...
>>> pci 0000:10:01.0: bridge window [mem size 0x00200000 64bit pref]: can't
>> assign; no space
>>> pci 0000:10:01.0: bridge window [mem size 0x00200000 64bit pref]: failed
>> to assign
>>> pci 0000:10:00.0: bridge window [io  size 0x1000]:can't assign; no space
>>> ...
>>>
>>> But Guest still boots and worked fine so far.
>>
>> Hi Shameer,
>>
>> Just letting you know I resolved this by increasing the MMIO region size
>> in hw/arm/virt.c to support passing through GPUs with large BAR regions
>> (VIRT_HIGH_PCIE_MMIO). Thanks for taking a look.
>>
> 
> Ok. Thanks for that. Does that mean may be an optional property to specify
> the size for VIRT_HIGH_PCIE_MMIO is worth adding?

Yes, and actually we have a patch ready for the configurable highmem 
region size. Matt Ochs will send it out in the next day or so and CC you 
on the submission.

> adding  ""mem-reserve=X" and "io-reserve=X" to pcie-root-port helps

Ok, good to know - I'll keep that in mind for future testing.

Thanks,
Nathan

