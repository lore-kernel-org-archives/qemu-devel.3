Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5D9C87FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaWP-00005d-RO; Thu, 31 Jul 2025 17:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZw2-0004fi-81; Thu, 31 Jul 2025 16:31:30 -0400
Received: from mail-bn8nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2414::606]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZw0-0006zU-45; Thu, 31 Jul 2025 16:31:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWyR3VGVoL/FRCjw6p70DY43fxvUuLdwmrzL2Z5mmqu4ozm6a7VHN1k9QPbx9PXFn39DDU4Irp4PzWUIrTDTc/ItScrcEcJjWS6eSfTICql49DKTQ5pJKBzter9KjGUODAf1wlFaLi29mzN18APmB8QXrhzN5kCZy1x1OTgG7xJZUwMEhNzE8guNWO3UHzK2aeOKTWvIO0ekkYrwT70lQX+BWFeAX7w1PcN7XlX1/t53bKj8gDdspR5BtYdKAR58RCxXcU9eRdQ4ADIb2RF20InwxWgJIwvHseaCixHAeIZj21/mLd0QjBMsS7zkJ98Sp0ilNJYs929vf3Hxdv182g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwcOBPfzcnCRcDASJG6yCtntD0smVahNIcIQi2+Qf0s=;
 b=aniSDhahIlUUgaHL9ERwIoICVjYQdLGHKlhTyyn+7ueahdi3uCtez4venXEOMS0Dt5R63NUG3jDz2VzqK5sZrZw5GhIgB3TWU/PVmukeGVVHkKqUPgId9BTi+BlifqKrhAWS+q4mQ3l8oQi1noUDJXEG1iZ2/789O2jyOhGvcleMzTpUTBCKpl0rlK964mU/oPY37UsEKk5lIp7dl/ObZS5btCXUEj4xEbbvKmBg2x7214tRPJE2ERyeJ6OFQED7Gv7/FZVX3K7e+e70Qtu1QgFdeowFNJ6JN/VjLbJBNkFHbxX2Tfg9f5bg26We0fyfEz/LpkoJF8mfOc7AmWXwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwcOBPfzcnCRcDASJG6yCtntD0smVahNIcIQi2+Qf0s=;
 b=llUtdy15vAFgMiC8Qmom/eJMFzfXvOD1ESfJoFyR4QpmeNJIxFFY3WHlm+qQqEnVY7Oxm83AdYzAp623InOVCoGiXex5XDo9LIQm68GippUUEeyK10GAmOrXU4P62wKKpe6NnZY3+WMGR/h8Qu+o4bfGhcSpa7SHNzqlOt0ombA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 20:31:23 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 20:31:23 +0000
Date: Thu, 31 Jul 2025 22:31:15 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 39/48] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Message-ID: <aIvSkxUT2Q/gkZiP@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-40-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-40-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0435.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::8) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fdf83f-21ae-4628-33a9-08ddd0713703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTJjc0xxenJvdGFZOUcvNFNHZkJrck90R0xrZVlRaEtWaFRpd2FGTk55ODND?=
 =?utf-8?B?RWZsYkZVVmFVUHRoa3dDY2dkb2NTSlJPMlFISTF3MG5tY0tKQ01HRDRkVGxZ?=
 =?utf-8?B?NTFJb1dHWDEvVnNjekl6aFdYOCtvOSttc3QwMmprUFZaLzZRTEowY2VMNjZx?=
 =?utf-8?B?TU9uaEc1MUl0VW9ncW52Uk5xT1NWbWdNRWdCWnZkaHlwYnUrbFBxOVl3UEpK?=
 =?utf-8?B?WnhYUVI4MmlCYkdoTVRxUE90cjNtbTVWNmV2WHluQnJwTUJ6dzVEcWlweUNi?=
 =?utf-8?B?SjVZMFJWTTdJVEJMY2lyNWNvUjdaTkc5Z0N6NUtqNHRqT0pqMU9zS245ZHNp?=
 =?utf-8?B?ZjJSYlNDWnNTeFNXTzNOQmJOaytxWXZkZXpyRG9VQXM1dSt3eG5xdzNKZU1Q?=
 =?utf-8?B?alZudHdXNmxsN1pCY1VvMTYxVHM0aytVTlFLN1Z0cWQwYStsZjV6Qmg5UXM2?=
 =?utf-8?B?dHlvdGk5YTVsYXd0QTVnSHRMdjE3UnVadlJocHF4by9jUytmSTB3WU5NelNL?=
 =?utf-8?B?aXprU2FyNFNENi9uWlg1dkUwZWI5TGJ1NW9vV01xL1ZNZWZYN3dVTDRnakpt?=
 =?utf-8?B?Y0xIaGx6Qi9VMUNkT0ZJOXJhRE02OTFRayttdmFjTzlnQVA4cUhWQlN2SlZF?=
 =?utf-8?B?YVFpV0hvaWdTV3lhWVVYeXNMdGJNZXRkNjVScnMxR2ZldDhkSDBjL1VFU1NF?=
 =?utf-8?B?aklLQjE3UmRNWStlL2pESHZCYjdFaGQvT0hCWk1RV3R6a0JpTXVkcnZCWnZl?=
 =?utf-8?B?cjJ5em1jMnRLM3JBdTk0WXRCK2tZQjJmcmJGSnlzaUZKVUw3Qm1XQWJERE8r?=
 =?utf-8?B?bncyYThmdzdHeGl0cGpvU29VMVNlVXh2ZlZVaVlLQStTbDdpaDRISUdISGFI?=
 =?utf-8?B?MUIvMGRlc0JWMmdDS1JOUlBoS1FicmU4SS8zejZQbmtYTWg4VmlMaE1LRi93?=
 =?utf-8?B?SDlteDNEL2gzeGhXREFxTjNsbEc2SXNaNVBYOEc1ZEt6UUtIUUdUdVB2cjlG?=
 =?utf-8?B?VmN6cUtnZTJpdWlxY1NlWTBUWTB1RGU3TlNPaGNsMnJUbVAxeGszc2gwODgx?=
 =?utf-8?B?UjR4WFlVZjNXN3BETzQrYTVMc1hZQys5NUU4czVoMjRXekwra2tHMVI5bGhO?=
 =?utf-8?B?aDhScDI1bG80c1ZNczFiWHQ0dTgrZHdpa3VDUkJ3ZnB6TEVub0k5bmtyb29p?=
 =?utf-8?B?WnB0d0VxazduTytDeS9jcjMreDRoVjVoWGgrQ0dPVnpPS2FkQnp5bTNUZy8w?=
 =?utf-8?B?MTV3bEdTR0lvdEt1ajNtK0F3WDlFVXhnQ2xCY3hYZjdtWG9SY1dIcUZVcGdu?=
 =?utf-8?B?WVJRVGxQMlBCVGNVNDFmcy96TFJCL1JsL2Z2UlluZkFUWE9aaGIxRXpuS1ZM?=
 =?utf-8?B?VG1TMjhWTjVwRitmcTFabVdSM2xJdnNUSUpzUDJuakdvR3BOTEpvYXhQQWtQ?=
 =?utf-8?B?cjdEb2NEY1JwSUFVdnE1cDRqbmZydm1JaDU5VWd4YnlCUC91am5EOEkyUUEz?=
 =?utf-8?B?ZkM4b1RJQkI4cXI3Si92YU82Sk94ejRDSXlYdmNHcW5VeUxyQlIvekZ1bnZN?=
 =?utf-8?B?SStjYldJQkJKYVJnMHJtb3V6L3gxOW00R1RMYjJScXVvbU9jemZSMFVJdlZQ?=
 =?utf-8?B?UWVicUlGeExqU0J1MEFlRHoxNnZLQWZ3UzVqcUlXSWZlQ3JLT3Z3OWZpZ0xV?=
 =?utf-8?B?VWhCbkVZZW9QY2dMUkhYbmdxeGE5dzVwalB2eWVvZjluWXlGYWI5Q0dmeVQ5?=
 =?utf-8?B?eEh4Y2VucjRVbStmYnprNVI1L1pHRzREVnI2TkllZmZXM1l3Y0pUdEVxOGlD?=
 =?utf-8?B?UE1la3VkVWJqZUY5SW1Pc1M1bjZEdXppdFU0aDlqM0NoQzlhT2M2ZnJUMmVM?=
 =?utf-8?B?andPSmtNSGFMREhnbFY3UEoxRXRJQyt0WGJaUzN5NFJCcXdRaWtoWmYxa054?=
 =?utf-8?Q?rrCaDkCD/zE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpQdmpxY2xmM0R5S1h1ajVyWnYwTmdDTjlQa0s3MzNCb1lYNjRFWFNvbHBF?=
 =?utf-8?B?QWFaOWlrb0l1Wk1YZ0k1YjJFbGN3eVhibVpJSHVYZGs5UXFkN2xrdDh1UC9y?=
 =?utf-8?B?UEpoRm9kcFFLM094UmpPTnBnSVdoV1VQZ3hJKzVxdjZxTkhVcVpVMnZaMFlY?=
 =?utf-8?B?by9qUXFxVmVvakkzNlBsOU84Q3lPL2dlMWk1Lzk3SXRXQW5mZVJBRXo2eXow?=
 =?utf-8?B?bUZsUEZhZjZ4YTV0anUzMDVkTlNMaXRrNjlTSFVXRU1DcllXYzQzb3RnUjNP?=
 =?utf-8?B?ZVAwQWhxT1FCQjBZQzk5ZDJ2aUo5M3UwcmxKZmJjUTZ2NmFtRU1YUWw1VjhT?=
 =?utf-8?B?ZFBLZFZtTk1hMnlEUmcrRmNvWEsxVSs3aG5xUGJ3Y2piQ1pYeU1qWUlhMEZx?=
 =?utf-8?B?NnI5OHlRYlowM21iekxhcVdZWHFFSy9wR0gyY0ZEc1FuRVlnZW5uRkVZUEsr?=
 =?utf-8?B?dnljNzFvUk9pWFFSQmZzSVQ3N01yQzJ2Nm9nMmIyRWtDbTE1QzZ4T0ZoZjR2?=
 =?utf-8?B?TjFmbklDMFZkekJMTkNiMUlTaitKRDFJRnIvbGQxRUpPa01aNEJRU3RZL3Rz?=
 =?utf-8?B?aWw1UGhjWnZiTlk1L0FvSkJtZzA0djlaMzR3NXM1LzVHSldKNXYzbDNtZFMr?=
 =?utf-8?B?RURLQTMyVWIxTDFvcDRGbGhjZ1RTc3MrS0xPUExsVnRjOFp2L1NiNmNLc1kr?=
 =?utf-8?B?MHpXR254LzlRTTlBeERvTTlqb2VFVlY3NldLNndYcTVsSUtPM0ZvODh6MTRy?=
 =?utf-8?B?UzFPVElIVXEvWmcxOXNnMkpYOWFVaGhGMDdGd1dLcnlrZmJONkZCUTdlUFRk?=
 =?utf-8?B?T3JsSE1GQ2JleE5hZXk1NTY5T1E1OGt6ZHV4N1Y2UTMxRXlEbldSWTFCOGpN?=
 =?utf-8?B?dlpSSTgrUzVLbjlVZ2xKaWNrZnJPMDZBMzFCME5xdHFsT3JXR3JrN2ZCbkJp?=
 =?utf-8?B?Mmg4a2hwK2hmYU1Md2RDdDNZbUV5bkdvcWNBcktHL2k5VTNpZ2pEdGdjV01W?=
 =?utf-8?B?b0JFT3VxTFNOYm1IR1c4d1owR015NUwwdURoWHVOSHVIM2FGam8yL0gzYWFr?=
 =?utf-8?B?SzdKZHRKNTQ4eWZJQ3dIRjFMcTdrYTdjM1BROVBMTzJmYURac2s0RGZVTTdn?=
 =?utf-8?B?SFJ1eTlTNjBwd2I2a1J0STBVdE54WkJ1TkdiVSs2NHRYdlhKWFU4NjF6cE16?=
 =?utf-8?B?ZnFyTmtJZ2plSEF3T1V1WlhRKzQ5dGpGWXd1N29zTVpUVW82eEkxWTNiK1Fp?=
 =?utf-8?B?ZXhnUHk4UVZjV0JwWnlONE1YbVJXd2ZueDlKNWM2eURNU3lxaTJIT1M0QlFl?=
 =?utf-8?B?NlRwZnMyUEhRM0JaT1JYa2x4cGM0ZkJaWDQ4UXZ4YzhlVWhwWksrT25tRUFm?=
 =?utf-8?B?T1dOdFp1MmtOZXlqZ2ZKRng2NVovb0xlVHBFbU1UUVMwOG1FZ0R6YVhDa05P?=
 =?utf-8?B?cmNJd0l4SXVWRmp2cUhDaVVwVk1CdGswMlFwUXhzRmFMcTRDOWZvTXBQcWhS?=
 =?utf-8?B?aWc5WHhaZ0ZMa2JhRTBFYkFHZVNPSHBabFU0d0hqdlRPR3dFVkNiK0x4aGt4?=
 =?utf-8?B?RVZoOTQyeXpON21wWnFxVjZVZHRIamQ1WlVuaDZ0cGRwRFhNdFVvU0s3UG9r?=
 =?utf-8?B?TVlocmE0TG83QWFnSXZTallqekN4V3ZlTUpNdFdBNXpjSzY2MSsvS1VxVzBM?=
 =?utf-8?B?dFVlalNrL25KRDZ2dXFlV0FZc3FkQ1REcGROcjAyempkMEZnMXE1c0F3cnpG?=
 =?utf-8?B?N0ZadHgxVXlQRS9ZczhZNzB1V1pSVkRTeHdhNkswYjZWU3hlOHJ1TDZyd2Qz?=
 =?utf-8?B?Smd3SmVoU1pwM3VXUDZ5NE5NNzk0dEYydEtvajFEVDNXMVlUM1ZpcFFXRTRz?=
 =?utf-8?B?YUg3cTNIa3dCaEpLSXBFQlFHclZkRjVKTHd3MGdXRDEwTExlbHlXRElxOUpx?=
 =?utf-8?B?N0tBTHB1aitZTWlPMHBOb3JORWc3azVvQ3JNRGNzdnRQN2lUai9rcXBMSzJM?=
 =?utf-8?B?Qm50LzFRTjRqamtIbmd5NmY5TE4yOVhUOGthM241Mlp0L1FaSTA4NXVjUzFR?=
 =?utf-8?B?UkEyTlczeUI2VCtTczdDcVlINWx3bWNudW9HK1c0dk91cGU4SWNvaG0xMk9W?=
 =?utf-8?Q?t9koTJzvVoq5qM+UIvB/Whomk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fdf83f-21ae-4628-33a9-08ddd0713703
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 20:31:23.3740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmCLhyckMHcr1tG64hU90GZTUwrTXk9WI05vzfpqCN21BPYDF29QSKttgn/U/98lXAulYSKe9DV3HwizLsOI6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
Received-SPF: permerror client-ip=2a01:111:f403:2414::606;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:54:21AM +0200, Luc Michel wrote:
> Add the target field in the IRQ descriptor. This allows to target an IRQ
> to another IRQ controller than the GIC(s). Other supported targets are
> the PMC PPU1 CPU interrupt controller and the EAM (Error management)
> device. Those two devices are currently not implemented so IRQs
> targeting those will be left unconnected. This is in preparation for
> versal2.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 9d900fe3127..551671af425 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -50,18 +50,30 @@
>  #include "hw/cpu/cluster.h"
>  #include "hw/arm/bsa.h"
>  
>  /*
>   * IRQ descriptor to catch the following cases:
> + *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
>   *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
>   */
>  FIELD(VERSAL_IRQ, IRQ, 0, 16)
> +FIELD(VERSAL_IRQ, TARGET, 16, 2)
>  FIELD(VERSAL_IRQ, ORED, 18, 1)
>  FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
>  
> +typedef enum VersalIrqTarget {
> +    IRQ_TARGET_GIC,
> +    IRQ_TARGET_PPU1,
> +    IRQ_TARGET_EAM,
> +} VersalIrqTarget;
> +
> +#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
> +#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
>  #define OR_IRQ(irq, or_idx) \
>      (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
> +#define PPU1_OR_IRQ(irq, or_idx) \
> +    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
>  
>  typedef struct VersalSimplePeriphMap {
>      uint64_t addr;
>      int irq;
>  } VersalSimplePeriphMap;
> @@ -415,19 +427,27 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
>   * Or gates are placed under the /soc/irq-or-gates QOM container.
>   */
>  static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
>                                            qemu_irq target_irq)
>  {
> +    static const char *TARGET_STR[] = {
> +        [IRQ_TARGET_GIC] = "gic",
> +        [IRQ_TARGET_PPU1] = "ppu1",
> +        [IRQ_TARGET_EAM] = "eam",
> +    };
> +
> +    VersalIrqTarget target;
>      Object *container = versal_get_child(s, "irq-or-gates");
>      DeviceState *dev;
>      g_autofree char *name;
>      int idx, or_idx;
>  
>      idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
>      or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> +    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
>  
> -    name = g_strdup_printf("irq[%d]", idx);
> +    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
>      dev = DEVICE(object_resolve_path_at(container, name));
>  
>      if (dev == NULL) {
>          dev = qdev_new(TYPE_OR_IRQ);
>          object_property_add_child(container, name, OBJECT(dev));
> @@ -439,16 +459,33 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
>      return qdev_get_gpio_in(dev, or_idx);
>  }
>  
>  static qemu_irq versal_get_irq(Versal *s, int irq_idx)
>  {
> +    VersalIrqTarget target;
>      qemu_irq irq;
>      bool ored;
>  
> +    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
>      ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
>  
> -    irq = versal_get_gic_irq(s, irq_idx);
> +    switch (target) {
> +    case IRQ_TARGET_EAM:
> +        /* EAM not implemented */
> +        return NULL;
> +
> +    case IRQ_TARGET_PPU1:
> +        /* PPU1 CPU not implemented */
> +        return NULL;
> +
> +    case IRQ_TARGET_GIC:
> +        irq = versal_get_gic_irq(s, irq_idx);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
>  
>      if (ored) {
>          irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
>      }
>  
> -- 
> 2.50.0
> 

