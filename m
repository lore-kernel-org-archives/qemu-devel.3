Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBDECF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLGq-00089E-Mx; Mon, 26 Jan 2026 07:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLGB-0007qu-2E; Mon, 26 Jan 2026 07:00:07 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLG5-0003Q8-Go; Mon, 26 Jan 2026 06:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428794; x=1800964794;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IFPNIrkG/d9B3jypiYxgGjpvlrAH5m62xYvGd4Wplts=;
 b=X4adVUbf9t78vfVoYfV4C+ZUPLZ3AhJ9wSuu94rI2BQoVCVUv3VzM1mz
 obUESea4qAGO5oSlRF3WfIF636kloiv9Ck4YbfDBV2t4IPHOMi7Ov5z46
 gA4idqexo9cZu+s59zVVN7cLq4jbDsozMrXrSezKTvdJ4Tz5ygOV0CDyu
 kQc9hzaDnmGYIKppvxu0gt56UPw7Qdj49LxN95ryjA4Z8pm4M/pasPEfj
 DdehxLOSFwI6xJBn/bbYQeNNxsPChd41A+iQF+rFLvVxqHS30D7DMjiRZ
 184DLfAPUKI+pkw0NxeETWzG1CrXdDbru2xtzWxL9f+YZoPptl8nfmLoT Q==;
X-CSE-ConnectionGUID: nRdJarmnTdeBADzNEuxJxg==
X-CSE-MsgGUID: NSuB8nA3TwWsMXT7dYcpWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70507427"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="70507427"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:52 -0800
X-CSE-ConnectionGUID: FPkCQ0ZvQS6sT93qx3ft8Q==
X-CSE-MsgGUID: UX83NK4TQVObKWwhLzVN8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="230613310"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 03:59:49 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdQAO7oqqyNEN555o17ofX+TMoT9m+yo3vPh2bsuhxDoksLWktwRQIxAB7mIMbb3NVvVOQzJKe6E7upDbUvRv/2k3MCuOlfTG/vJKbdtsgYpViVTDtPa/shl3IDprm3zzMuxHRZIo6SQNb0xAg9zkq/sl3VUtq2A1PsUtYJoUPwtjBO2UuyoEv5RDWsfQLiTeGB+uc5Yhg1678KXH4wgQ4S6zyhrBkKTs4FzRA7F91G32Ib87ZnVE7vFqUdULK+IRwz20j8v+wSsSi19ww2hZPIb08hlJa3lbIYQtwykeNYS5nwMWLXSXpWnPy8QljD0/rwUmsXxzZkXXa5s5aUIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odMnF3EaxhFrjPIYT1jwQ+0afyXGmA+w+FwsvCy6Kms=;
 b=xQ+DP99iAXHPXyIkMCD7DD4TY2nRQIAMxmiYV0kU/ZH9k4vClZFNSWACJQMFWdwbRV0bTMYqmQtFe7BCFDw3CvHF/jb9yciu0yWkh+3d3bMtlQFUadLvuR2Hyvnhqw6EIypNsN5zLa8/Tp3UIYLbuxO7PhGQzY+dNMdz5wckAww49f/orzNw5dROHeKZAM5PET3wn+eUtiZYPS8RyJ4ug20XLGwCXi8U84z0pupCwf7l6YGEetSrW03tm46KTUjpc3YPmL+JHDZRzbHi3qsBDjnefQ9/dTH/gAcAbn7dgVnk19JmTuOSeUfE1C3/oMQqIzBdKNHFThjRcEURgDdvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 11:59:47 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:59:46 +0000
Message-ID: <564b4bfa-a605-438e-b8c4-36e200ad21bb@intel.com>
Date: Mon, 26 Jan 2026 20:06:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/37] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-10-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c595fc2-d31d-4dd9-48a3-08de5cd26691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHp2S1p2bGhyRSswdWxETFQ5RzhJRzI4THY2amgzaW94Rm80dXFKYm1kWjEx?=
 =?utf-8?B?eEtKdFhKZ0doczJFQVFPUmRCMUl4eG9CUUJlNkVhdGhFcitaTHdBd1huZndH?=
 =?utf-8?B?UlBEOUhlQ2pFOHpLLzFIbUdxUlFoUjFJeG01d3A5SHdGZDd6cVI4TXFsOGV6?=
 =?utf-8?B?K1QxWXZ4R21uOEVCY3lySkRzaDBhTmRPbklHQktiREo2UHVLbHVrbVZYL0g3?=
 =?utf-8?B?UCs5bHkvZTBSdmo2Ukx0Q0M4NjZwRGwrTXlneFVPelY4eGRidnp4ODNCS3l4?=
 =?utf-8?B?Yk85V25vQnJDaGt5dm51MFM0OXA3cGhlQllhM0xCUEgrd0lmYjFsejc1ekZT?=
 =?utf-8?B?MVdJZ2kydXFxQjU1eXV1L1lvaXpNeUV2dEJxWFRwUW5TUnUzZGgxU2I3RVJN?=
 =?utf-8?B?T1VlbmRoamNxTXNIaTdNQ0tLSnBENWhEemlWSCt4clFiQWRCZWJVSThoUVJS?=
 =?utf-8?B?eDBqYVJUZEwvUHZTbWhyUkZTbFVmRXJ1MUw2SndITmIwVzVQK2s4TGNGM1dy?=
 =?utf-8?B?ZVNhQXpwSU1EcFJJemZER3VtUVR0MUQrb1N0aCtVekZtVU9TMXhJczdpcnFE?=
 =?utf-8?B?Smtwd29KTUR0dHFDVFU2ZTF2QkNONFFVeHg0SnVzdjluc1ZNK2d0UmorRGlZ?=
 =?utf-8?B?VUp5Ti9zWEhoNFd0K2VLQmMzd2dyWjc2amNoZ0cyd3FGM2dpQjhLeWtCZy9S?=
 =?utf-8?B?d1dMUkFBYVRQVFM2UTVJV0E2Nis1bW5NSHREbStHZFNzNTRpWEVRV0R2Rnlh?=
 =?utf-8?B?YkhtNVRDQlJDZ29jZG5wdXV2YTlGZWJqRDczeUFMd1J1N1pGaytHS0xyeU1W?=
 =?utf-8?B?ckJKY3Q1N3pjeW1NcGVEbFZzUU50eTNYVlJlRmZyZ0wwenJ4TldpQmJ1bzZy?=
 =?utf-8?B?RnpTMWoySEt4SHlTcUwxdmJNYjhYY1lLMlljOEorM1ZjbjdWRmFyT2RyUG9h?=
 =?utf-8?B?UGVrUksyK2JDQ29Cb1Z0TTZ3VGlqZmpYWkUvb1ZJbDkwVEZzL2pRZTE0am1n?=
 =?utf-8?B?WkhVdGU1bDlLWGlLdytJR3BDWVRNNkVnR2ZnNkZBMGdkcWhjOXpEUFFjZFYr?=
 =?utf-8?B?MmdpeFZxM1hZdTRpWVRIaHFHc2x2dmQvTmVsOFQ1dmc1cllXTDc2RWV3Ynk3?=
 =?utf-8?B?TnRYVVdRakFJcVE2dUFKc1dtYWVXZXl3aEZVdU9mUjYrbkt6VHMyRHhpRTlL?=
 =?utf-8?B?ckhHemMvZERLTEpobWt6NURtTzlXMWpoNG1QRUl2U2ZRL3hWZTFOWi85QlN1?=
 =?utf-8?B?ekxsVFEwVk5QWVpFVDVscWU3eU9YNlZkdDI3bTlQN081bTk2SnJrOWRNMFBx?=
 =?utf-8?B?WjZmTVNveGRqeElNNGhDYnhEbEVnYVNqOHllVnlMWGdiTkxqWGtNQmJIUHpi?=
 =?utf-8?B?Tkc4bmd0QzA0VDYzcmhxMlFkc0dHMGJ6Z21lODQ3aHVMeGMvWWovTlpRZmRV?=
 =?utf-8?B?MU0yRHhGdFdBZTNDTW43WCs2VmhCc2VGQ29TK2VSb3RGQ0xjVnRBdDZGcm5p?=
 =?utf-8?B?aWdIcUZSWm1YeWxndGdscVE0eTR2c0dlcTc1cDA5aXZZOVUzb1d2YjhaYU9U?=
 =?utf-8?B?MCtxdThxalVkWUVmR2lqRHNKSFplRzA0dVAyeGdhRkxyY2hKVzAvanpTK2xv?=
 =?utf-8?B?K3JjRWk0VVk4WlplMVVReU1POXZZRld2STcvTVl1SXV6MmFKV3B3R1NsUUJh?=
 =?utf-8?B?ZzNWSU9mdnAxQndsR0xoOEJuRGNsQkNWa1F0bEJ0eFRETklCTVFDakpOK0NF?=
 =?utf-8?B?MUN3cFpBRUZ3NHRwbmhDK05ibThyYTNBeU4zMGplUTgzVDRyWEtSTG44dzV5?=
 =?utf-8?B?YVlKOHlwM3luRUZNZjdiNEt6WFdGdnN3MTd3dmtsUTh3N2tzSk9pcWNRUXF5?=
 =?utf-8?B?a0FHOW02M3Axc3pURndvT1FxUnFITXpnK0o1RjZzTkloSVZCMjhSTnRTYnJO?=
 =?utf-8?B?VnNJaFN4V3RGQUVXbVlPSUhad2l1K29JMFM2YTB0M1ZIZktibldKaDhTVUd1?=
 =?utf-8?B?VXVmaVFCTE8vRXR6Z2NDM1BmZldHQkpwaHFTWEI1aWs4ZGU4QjZhMFZoWllv?=
 =?utf-8?B?YnMwVVFwTmNFSmh6cG13OXVqMUlrNGcwcFArMGZTQktkUkM2RkxzZTMzUnpI?=
 =?utf-8?Q?bs6Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01zaHMrYlBmY21VMTU2WG5iWjdHbEl6VG5Gc3REZHZrMnI1cEVZbDVDUkJh?=
 =?utf-8?B?bXBCM3NYSVBNYmNXN3cvb0ZxU1FGem5xOXowL1JJWStTdWpuM3hwTWNTMDFm?=
 =?utf-8?B?clZHMk9KRWd6anVsdSt0YnRxcndOSjd2dzNCbE5mVXNYS3Radlpoa250Y1ZY?=
 =?utf-8?B?U2hCU0RzNllTeWgxNzF5UTlvU1NhRGNnNTRTYmF0MXhsanp6TGhQdVg0K1pS?=
 =?utf-8?B?OVZKeFNJQmZOQUs0NTVqQ0I3Y1FacElTYzZqaGhHcTNsR3BXcCtjMndKaGoy?=
 =?utf-8?B?SHBVZEJobWFtN29xRTk2L01mY2pSY2trTkxad2hPeUFxSU5Jc1F0WDdneGRF?=
 =?utf-8?B?WHgvaHZnVmZZUjI4UVp1SGFqYnBMa0ZkcURvSEtxRFZmZFZWYkU3bjVybkhO?=
 =?utf-8?B?aUExOTVvMVJpbWhVdmwrYTlucXpKTHFBYjIraitjUG1HU3V5WHd2c1dpeDZn?=
 =?utf-8?B?QnE4WFk0RTZSb0xZcUpmUTREZDE1M3NGblRhWURHR0hXdEtVL2lINUlpTjVN?=
 =?utf-8?B?eFNvN2VraDRDcUpTa3ZZeWd1TEdLREQ5OEhrblI1dHZnZEFZM2RJdm9aeERF?=
 =?utf-8?B?WDVDdGRMQWFNbXAxNURhQlJxUmpQUnNHYlRwNFcxNjA2MDgrc1M1ZGlvbG1K?=
 =?utf-8?B?bHp6dXVlSUxwUGFUU2sxVGx4SmIzOWcwWjF6Y3diaFlZK2dkTUJ1bWU3UGxq?=
 =?utf-8?B?WDMvS0h1eDdrbTRzaU1NNkNUaEdsR256Y1UxNFo0d2V6REFoYXppN0xRR3Fr?=
 =?utf-8?B?OEtIOFJQTUw4cXp3M0RpT1dBMlpCTTZXWERiaExndlBpbGZNekUrMUltcXdx?=
 =?utf-8?B?MDhVaFdJMnQzc2hPRldLbHo1QmtMd2NOcVlSRTY1Wms5SlZSNFB4eVpjd2lj?=
 =?utf-8?B?UVJKcjdYMWhGVkRTNmFBb2tPT3p2UUFIUFVpdkpqYjJkbDNWSkNrRVU1d3dN?=
 =?utf-8?B?dEI5Wldadkh1eDlkdUtEVFJRR1o3bTRCeW5yTVpqTVZjRmpIMU9VOTBKYnBW?=
 =?utf-8?B?Q2wrWW5DeGkvanJMaCtFVzdPLzRtUThjMkRmMlFGNlNSOXRWRldaL3dXMk1n?=
 =?utf-8?B?dVdMMjBGeWlUK2I4RGVyK3lwYzV4KzUybWJmdVFSVDYwc0FTbjdxRkZsdEFs?=
 =?utf-8?B?TC9CSEsrYkRzaUxNdnBTcTNyRm1RcnFUcTF5U0FENWsvekMzb0ZVQ2hlUjVN?=
 =?utf-8?B?Y2RxTGhCN1o1VWgwanZ2NUNvTVBodjlqZGFVd3g2dUdFOWJKMGxkelF2ZVk0?=
 =?utf-8?B?STFyTU9VbFlsSVVCZlNVQVljdlNWWiswMWo0NTFLMmE1WnhGQTFOTTVLM2gy?=
 =?utf-8?B?TnJ3aXJDellyR3RhNG5yamxxQVNEd0x1NUxSWTdtTTF3M3ljaGdWT0I0T0tP?=
 =?utf-8?B?ZndoRS92SEFFNzQrM1FyS3hQSHprdkpJMUxqd2FoblRrcUVUTFdGaUc1aEFp?=
 =?utf-8?B?Sml1SnhnOUVyTkJiVVBIZWZad0Myd0tuQ0hNeVQ0Rk9tL21DMkdmUGpRUDd4?=
 =?utf-8?B?L0RCYkRMN2Fmb3ZIeHM1eDR5RUtvRVZGVmU2RGErRmpXSkRmODZJQ2x0eit0?=
 =?utf-8?B?Uk9ta1NOeEtxQXFiQitZOUpXWEt4SjVjMDJyWFNkMXNFTlVKc2o2c2NxL1BC?=
 =?utf-8?B?YXJ3MUdSZ1JYR2tXY1lRSFZYbTFzdHN0R3pnenNzSitHYlBuK1lZK1dBa0kw?=
 =?utf-8?B?L0R2eGVybXVCRnREaTlBeGVjTWpwdFh4RXVESFFnV1NVa1Z0a2FrQkRRUHU2?=
 =?utf-8?B?MzJUemdrTmh3NXRKNkx5NlRCRG5Kem5DZHRHbFV5QWEyVjJpL3paazlQdnQz?=
 =?utf-8?B?a3VXK1VpSU1MQlRDRGNSVjJhTzQxc01lZldNczJPSUNHZTBOejBiOFYvL1BB?=
 =?utf-8?B?VkkwdkpuWTE5enpUSWx0ZHJ4NkZEeklUam1sYXJMSE4ySmRtYVUvQkVlaXM3?=
 =?utf-8?B?Q08raXV6NzhPUlJ0VGE0SEhtK1psaDdudWcwUURPa1dlUzhoSkJvL2hQejND?=
 =?utf-8?B?bmpMbC9zUGd2SEdVc3J0MWpZM0pKV1lodFZqS0ZMSGwzRVJoTy8waG1jWHhw?=
 =?utf-8?B?NExYRlA5bWZWRjJzMnFRMjJKZTI5UjJKUkxWaHpUcitueGl3Nkg1dHYyMmZa?=
 =?utf-8?B?NWhpNDhQKzZQcEQyeVF0WWdvYkhGTmhFMHRvWXdkSnROdUFVTGlzSytvR0RH?=
 =?utf-8?B?TjYvSHh4dStmVUhtV2JnRHdSeUdjcWlmRVp5MWF5U2k1OS9Vc25RZjh4WXM5?=
 =?utf-8?B?SlNwZzUxZGpnUlpXMXFWYVEyZU82ekNOcTdxQmN1TVl3YnU4Rnp2dlJzSVJG?=
 =?utf-8?B?a3JiL29aQUNLamVzdW1ONHZXWTcvTllEQllsem9HeEtwMkxwZUJaZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c595fc2-d31d-4dd9-48a3-08de5cd26691
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:59:46.9443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4uQZzqRy3tPJxeXNVghWPcxo/p8DugmPLHfO+cKUx0XOH/qG+BKzYtJHSnWBGGuIzPTTcWToNnuchAHzlQdzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/1/26 18:43, Shameer Kolothum wrote:
> Move the TYPE_PXB_PCIE_DEV definition to header so that it can be
> referenced by other code in subsequent patch.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/pci-bridge/pci_expander_bridge.c | 1 -
>   include/hw/pci/pci_bridge.h         | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 08d40aa2ea..b6e2eb7969 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -48,7 +48,6 @@ struct PXBBus {
>       char bus_path[8];
>   };
>   
> -#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>   OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
>   
>   static GList *pxb_dev_list;
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index a055fd8d32..b61360b900 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
>   
>   #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
>   #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
> +#define TYPE_PXB_PCIE_DEV "pxb-pcie"
>   #define TYPE_PXB_DEV "pxb"
>   OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
>   

