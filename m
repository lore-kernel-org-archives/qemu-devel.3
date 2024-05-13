Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDC8C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VlR-00064r-5Q; Mon, 13 May 2024 09:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6VlL-000649-0K
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:30:43 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Vl9-0006MC-KS
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:30:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw/Fanka1SencsUH5G79H8uHSQ7oHZZ1hwA/k4L4/N4nEJvQcrecXpDcCV5zSUwX5EnQOapkKflLyX8eDaOppMNNST+6yzEUsGZcWa3irMVSTA1XW13K7uHhuhhoaGVNHDVf95uFAbXJnzUDppfSpl51XMoHLNuC5HNZ6yZHOEy77kZwI4b88iM/Tp419kICmk/jY5fuDxm+v9kvwcWki1TjLlqM1teKvwXSR7BxuUcQ/U72BSMJ7qq6cowe7mD5h4bTlW5GwRbBx8iNb9g0DzdngHkvfjBVEAMJt2SbsT3uRUPg+nr+b5MNIcINoX7fo0Gz6Kyu7AmxZQY48A+nXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4W0mBcJqlr/etSfpFkFy3LzcYHJasf3As46fS/KW9M=;
 b=ZDxLdMtjAOjFXXFNt7ZFaUP20/kRT3GDiaJF6lTMp2fvkvO+39fYJNqtcx9sOe6sZxVwD52y4dBpejyFCCkJdQ40DY10/4oBbSsRGmwaW4AEDk7111a7N8wxWDLhEVuMCJsHCIgyYKaLRoyf5JoD9BfUggj+wltqYP1mbRo7Kxezyc9uLG/5wiAreXVH9yXUwcrcmZs2bzjg6M84oYWaXbSM3Hx8tlmzc4KUncR8+bAR6krIlah8m+jWRqKUJGevB5IRQlefzS0lK+gkXyVRsbxqKxXweFt0CI0YNOcD0XAjtAvQlQj6HS/xyXKs5P86bBV1BlEBnEsQ1J2L636PgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4W0mBcJqlr/etSfpFkFy3LzcYHJasf3As46fS/KW9M=;
 b=l30P15ibYNF44CuTeBjaHWPcymE4D68E+JwgHIMe4v4M1KufFuAOXv5YqHXzxteju347tTLRvHkzp/TB8+XdJF/WvXMYyK7crUACIKwXkB67iva0vWsxYPaz6GTT+LYXaOUXTZd51XkQACyAG4yPh0wpWQAESLjYkowPfWgmn556f6GqQHZZcxmswDoa6V+/YUGY4S1rUMkJ2IlQpfQwQ+00MYZH8k4UetY5Kzwmsu31aj2vCna2ac58JdyDFcTvPjCX7Irrh4WucARTrpA3CZT6VIzuCOvupqZVP0qrmROABec+YEZMPSzWYMdPm/Jf17H2hLo9n6lcAZduRWbwTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:30:27 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:30:27 +0000
Message-ID: <894a958e-f804-46e9-a511-c7f62d3ec414@nvidia.com>
Date: Mon, 13 May 2024 16:30:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] vfio: Add Error** argument to
 .vfio_save_config() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-6-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddb4cd9-8e4b-4766-d6d3-08dc7350d9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXdOMEUzWk5ReWtMR2NEUlpKQ1dXcStrQkRlcWFOVTVVK0c3bmZtK1Y0bEVU?=
 =?utf-8?B?WDUrZ0N0UEZBdDQxcTcwcDhpSWhoQXQ0M0xtZ0Z3TmJFV3Y2RnFmQndOeVJy?=
 =?utf-8?B?Y2xEOHE3T1pEU3ViU09mQzdWSDBJYkxQakpWTkhoT09CaWNhRDJFcGVpeUF5?=
 =?utf-8?B?cG5yblJzMGFVRDZGZkxKaUlJN0ZwSzhMVFh3MmxxblJTb2UzNkdrK1FCVUZN?=
 =?utf-8?B?ckNUdWxsSkd0OFBCeWJiNG52T2dLaGFqdFZkQVN0L3FBbUQ5UXJMWk0xQ2lp?=
 =?utf-8?B?bGY3T3VJTTQzdXVDWDVPZkNRbEhsNzVHZFhEM0VReGxWdFRoTGU1OER5MXUx?=
 =?utf-8?B?RVZZNXZiamNRZEtkTXdsSTJpWk5mbGVETTJTeW05aEttYUdrYWNxVjVlcWhS?=
 =?utf-8?B?SUtUNklKUE1TRHVJNE9Oc0MxcXZ6V2JvSzhnTWtjL3JhMFdPQWcxVXd1ZTFu?=
 =?utf-8?B?c1NJOEt2TWIvV3VSUWJzVmFvMkovdXMzdDlMYnJCTXFHUitCaWJkQ29LTEI1?=
 =?utf-8?B?Wm5Zc01RRG1PMUMzOXZFRXBxZzJoekpEcmhiRE9ZWkNVako0VE5VcEk5YWJr?=
 =?utf-8?B?TnhJSmpXSytjWFMxRUZMZDlQQk8ySTAzT1BhNE5XNXhSYkJiVEpaeGZrclRD?=
 =?utf-8?B?Z283VDMrTFRwbDJ3SDNMK3M5Tjd1M2dCVTRTQXhHUEZGdTI2eDZ5YXdkbUpa?=
 =?utf-8?B?VmUwcEtGWHZqVDNtaUcxeWR6T0VMOGJPdlhLMHgxMWttQzUvYkUwdFhINEJj?=
 =?utf-8?B?UFpJZUl4ZXlqUWw5N24raDJGREVURlc1R1JyTjJnTGd0MDErbEpNQWZPUzdB?=
 =?utf-8?B?bzJHcFkyL0RUdWRJZ1JqQTdWK2UyNVFGQ2pHT25sYjBtQnNXVitBNnkyZHM1?=
 =?utf-8?B?aGM1MXQ5cFo1aUU3aUdkNi9ScDFjSWFkQnNQdE1zUzEyTGNkSGpuVWhMOWpk?=
 =?utf-8?B?UmVDSmNOS3cvOGJhSGUwSXN6SmFPMHNwZ2NoSXNIM1FzaXVveDFwR0t3NDNY?=
 =?utf-8?B?SlhSbzJJZjdzZVpocEhGMVowYVJxOW5Gcm1zQzBqQmFKVU5lTDBsOVNZWkpQ?=
 =?utf-8?B?bUpMWG1QcitQZWdybGJ1c0dzU0Q1MEVHMjVEZWVJS3FUMXhjYVhuSEtoaHRx?=
 =?utf-8?B?WmsxZnFZZFczeFczcHZQQ1dWMW5NQ28vK3dlNlhUN20wb3czaVhNZlEyR2Vo?=
 =?utf-8?B?TGpnbXRtK1hYc1czMzZTRE00Mm5ZRDRxRWpzbTJkUVlEMzJicGwwbElrVWpI?=
 =?utf-8?B?NjRta0lGTHc1L1VPeC9tUmlrS0JYRUliMFNjVkxZd0lmNC9aNUdIbGdJS2xX?=
 =?utf-8?B?U2VRendudVZTdXFrVHk5NkhqRVdRbUFGQWFyU3BPODMzM3FKdnR0T2N5K0Fp?=
 =?utf-8?B?NTJURlluRHZYZUlESmJDU3RlMUt1Wjl4d0hlcCtQaEluMVE4YU8wSEdaSWI5?=
 =?utf-8?B?QmUwa1NqY05PK3FyNFp6UVF0L095d2Fzbjc5OXNON0F0Z2YzTjRYSmN2MWtV?=
 =?utf-8?B?VlhHcnl0QjNJVXpTUngra1FPWEdicmpYSTlId1NwUnpVbnZGeWdtb1BpRzc1?=
 =?utf-8?B?NGpWeEdyZ3dkZmE0MnljUVJFYyt5ZEw1S3pTaVlnMjd2NGYwcU5URlFFSXk3?=
 =?utf-8?B?ekpYVk5QaGpMcTN5T2k1MEREUUY4YVo0NEZHKzVrUjhYZUJhT1NSNUNKWkJv?=
 =?utf-8?B?NlN4aWRYUHF1VzNSQkFqNkFFYVl3U1FrWk1sRTQ1QWRJajRVSHNyME9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktmOWcwMk9PQmhqTFVtaitOdWRGMGIvUEoyVmIvbzhXRFRNVXR0dVpkSXkv?=
 =?utf-8?B?V0FTOWxSWnhSd2VNK0dTSEgyYUxhWnFmZ0RvQTRIbzBvbUhRVjBLTGRaN0Ux?=
 =?utf-8?B?eGk4a281ZUZyUU5INEIyQm5Bbk1BSVBaQXJZNlp1ZkppT3BaazZMZCsyRVI0?=
 =?utf-8?B?Q2FXblFSemZDTC9XZGxCNlhzZjBQV1QxT1ZkZXErUkwvMmcwU08vWjFHblZu?=
 =?utf-8?B?R1dTTmtnVExqQnFJRUh3cmc4S0t1YXhMbTV0WThUUGFrN2FiMmN2MDhBV2t4?=
 =?utf-8?B?ZW9vK2hoa2ZTWmJ0eWxqdHM5MlZnNXlNb1VGVXYzQy9FVXBuTWdHUjJIcUlK?=
 =?utf-8?B?Rjg1OURRYmdGdDUrSkN6UzB0SjJKeTNRanNGZ2RYOU1UMUtsRW9GVXBIa2g3?=
 =?utf-8?B?d1ZlY1BzMjFkNjBCTzk5ZUM4MmRBeUpLSXEzOGVySGQzMURWZTNxRTRCa0ow?=
 =?utf-8?B?Zm5pTVVsbkdJei80bFdHcWtBTXRiaXFPeDZJQzRRUmRvQ3VCNXFDbk0rSTFr?=
 =?utf-8?B?cWpaZDV5bUlaZ29mcHZKRjY0cWdLOGlkVnlEUDJ4ZTh2OERoSzM3TnkvcDZt?=
 =?utf-8?B?M3kram9wTE9PRjR0NENtdG1NWkwwMWNWa3F1ZldWM0VZOFlUWHJoRTdueGEy?=
 =?utf-8?B?UTVRdDgxeXlvWEpZMVJTT3NOOEY2VmU3RGpxQk01cGJOcG52Y0lmUWtnaU1i?=
 =?utf-8?B?THpZQzhJSXNSMVVWa2ZHL0kvTkFxdThkeU4zNlpQUS9ycHVLU1pTSWlNZHZL?=
 =?utf-8?B?NGZjRndWemdId0xNQlF1RVZLZk9LdVRKcGJCMVZPeXhKSGJKYUs2WVJmSkQw?=
 =?utf-8?B?TmRQY3FMREpyMjNSb3ZnWkpBWnQvYkVHdlNZdzN2YkgzemxlMTE3N0dTSFNB?=
 =?utf-8?B?TlFNcXZzcjBZc2JlUithbmdPNHZ5SHBwaSt6UUx2bUl6dzcyTGl5NGZybkNw?=
 =?utf-8?B?MXNzenp2cWpnWjhVeG1xc2FqbENrUWRON0hlM2dIRDNBOHFVMnM0SE1CbXBh?=
 =?utf-8?B?aHJOVm5aZlRqTzFTeVNOZzBpc1hsT2JDVG1UWC9SQkVjbTRUODEwdUZ6bDgx?=
 =?utf-8?B?eHJEelBpbi9EMGM3ZE5lYkxsWDlMZ0FxS0h6bHRBc0VjQUY4aVBIWURCbG92?=
 =?utf-8?B?TXZyZkRrZWxNVlkyc20zWUNzQWdqbFNpelJreFhid0hzaWgybVFXUUJVM1Mx?=
 =?utf-8?B?WEFDQnhtRFpNSnFFanNWNVlOaVNkOWt0VFFwNXgvYUFXdE5sa0NMU0orZjhJ?=
 =?utf-8?B?cEh6WEIxTHhDRm1NdG5GRGtUNmtqcTRjME1ncVRCTndxRW1lQ2dNeC9yNDhT?=
 =?utf-8?B?R0xRQzlZTWgrZzhmU1RrTWZLemc4b3JRVHo3NVJ2U2dHdElNWWo2UFA2ODdH?=
 =?utf-8?B?WERsYUtieEwrZWlQMTY2N1RpdkZ4YTYzY0hFRXlnQWhvYW0wWFkybEtycHZi?=
 =?utf-8?B?U0dibnVWQjVLQUJOaHo3N2ZRODBEZ0o0VUgxZWdqZlY3bEtjNDVIRCt1aXU0?=
 =?utf-8?B?a0ZxWnV6aklBWGloOS85RWFTMzZsN0FEc3dTRmxGanBPMzgyTHlsQjZ3aTZD?=
 =?utf-8?B?cWIzNjlwZFAya3BHNVRJUHdNZ1Bac3hPR2taVHZFUjg3bDdFNHBJQXMvWFEz?=
 =?utf-8?B?d216TjA2VGc5NW9YOXNvcU9wQTRNWnZrODNjTC9oYjFtb1JiL2hDOW5LMlF5?=
 =?utf-8?B?MlZWWUpFL2Y3SW9teGQvMmZlU3NFU1VHYTgyWTJNMTllbXRZSXhHN2YvV2w3?=
 =?utf-8?B?dGc1VWJHcU5HRjRMOGpRcTJJZ2FqL0pWMmVQQXRBa2ljbURvTHU2QWVRanZ1?=
 =?utf-8?B?ZUlGclRTWmRZdTcxbjB0QStNZHNoWVcvQW9HYzNocEtRWjBqMnRQTnhWaC9N?=
 =?utf-8?B?am9uYTRJTGt6N01yaUZZcTVkVzhRald4YXJ2Z0lnRmhWOTBxTVJwYXZmRW1P?=
 =?utf-8?B?Y1RtMWhhclVDc1RuUy9YUFYxL2M1UUZ0T0N4eVozalJiMWtuN1BqWS9EMmpz?=
 =?utf-8?B?NWtDMlAwaUpsemcremZwMm9UYjl6QTRjaEFySVJaUzJRVEEyT085VElLM1E2?=
 =?utf-8?B?NVBVeGZLaEp0L3p1THFpcEhURU84UGZkM3dSQVFMTytHK3pRWkl4aVFUMFA1?=
 =?utf-8?Q?gieBhRQSN83tZLtjuE1BgMgWw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddb4cd9-8e4b-4766-d6d3-08dc7350d9d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:30:27.0912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDMRVbzUQiEHQZaFBz25QZxJlUlSVdoVQvtujlWmZ9Tk7U2eLv9D4OTZLsqsJaXw6EOQP2VmXVDGPBaXLreusQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
Received-SPF: softfail client-ip=2a01:111:f403:2414::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Use vmstate_save_state_with_err() to improve error reporting in the
> callers and store a reported error under the migration stream. Add
> documentation while at it.
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
>   hw/vfio/migration.c           | 18 ++++++++++++------
>   hw/vfio/pci.c                 |  5 +++--
>   3 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,7 +133,30 @@ struct VFIODeviceOps {
>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>       void (*vfio_eoi)(VFIODevice *vdev);
>       Object *(*vfio_get_object)(VFIODevice *vdev);
> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +
> +    /**
> +     * @vfio_save_config
> +     *
> +     * Save device config state
> +     *
> +     * @vdev: #VFIODevice for which to save the config
> +     * @f: #QEMUFile where to send the data
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
> +
> +    /**
> +     * @vfio_load_config
> +     *
> +     * Load device config state
> +     *
> +     * @vdev: #VFIODevice for which to load the config
> +     * @f: #QEMUFile where to get the data
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>   };
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 9b6375c949f7a8dca857ead2506855f63fa051e4..87437490bd50321b3eb27770c932078597053746 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -189,14 +189,19 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> +                                         Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> +    int ret;
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>
>       if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> -        vbasedev->ops->vfio_save_config(vbasedev, f);
> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
> +        if (ret) {
> +            return ret;
> +        }
>       }
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);

Below we have:

return qemu_file_get_error(f);

Need to set errp in case of error.

> @@ -588,13 +593,14 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   static void vfio_save_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    Error *local_err = NULL;
>       int ret;
>
> -    ret = vfio_save_device_config_state(f, opaque);
> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
> -        error_report("%s: Failed to save device config space",
> -                     vbasedev->name);
> -        qemu_file_set_error(f, ret);
> +        error_prepend(&local_err, "%s: Failed to save device config space",

Add " - " ("... device config space - "), like in the other patches?

Thanks.

> +                      vbasedev->name);
> +        qemu_file_set_error_obj(f, ret, local_err);
>       }
>   }
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b793345c8e8996fe6b7987059ce831c11..fc6e54e871508bb0e2a3ac9079a195c086531f21 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2586,11 +2586,12 @@ static const VMStateDescription vmstate_vfio_pci_config = {
>       }
>   };
>
> -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>
> -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
> +                                       errp);
>   }
>
>   static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> --
> 2.45.0
>

