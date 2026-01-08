Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC87CF6AB6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmWZ-0002IA-Mp; Thu, 08 Jan 2026 04:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vdmWX-0002HR-P6; Thu, 08 Jan 2026 04:41:45 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vdmWU-0007qC-QQ; Thu, 08 Jan 2026 04:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767865303; x=1799401303;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DcvaeUqLfnrTiZrlM13a0dZXodkcKeG3HLOx0r1qM70=;
 b=AX0w0NF+1vRrDWHvuP9+zLJIKX2FCLsl1BVq+cY24DLpxvD+DEtA6n8I
 v3gQKT1Oxdo7Nd4ZPVFNeBnfGZnLWKBViPjSTausJHlPD0XfS2iYHZzy+
 2IbqszBlIBPSsJVUvIWMhZHIrwfnxLsDdSsyGyyfIi0SXFn6DCQz6pj9Q
 PXjSMS6nRAwRX+5XG4pAky7JlHNIeXSVpfypgq2BAp7drWKL5YyhaQ4b/
 pmswnaHbQeboArObhw1a4KUKTBzuxZQCZ3vbxvdhcuTIwBw+sxuw6o8Di
 S3kF0iB7pMBiE6bnGnJQlQ2gg5K3rZUxiwkZFTqsSyMOtn6b1fsFGbyQI g==;
X-CSE-ConnectionGUID: nV02FyPtTg6V8W49lTDGDg==
X-CSE-MsgGUID: Hsc7w8QmRt2QMszIeZpGvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69173885"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="69173885"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 01:41:38 -0800
X-CSE-ConnectionGUID: Ik+7c/7wQCq9o81eSuLHSQ==
X-CSE-MsgGUID: E1aI5resTcOqE+43w5JeNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="207701434"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 01:41:38 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 01:41:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 01:41:37 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 01:41:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wlp+I9nqc0bttU7DDEjXfV5lpZPRrxMs+lypXUrZ5JyVbZtteBo66YiPW6xjTVILmWou6nQh/DvuyIWKDy5hxp3kRhHJwh3ksMzUj8O6MNuO7L7qj/QWI79haT2Gyc+czqAa1JIeoHJSMid6c5upgb2I395ztuJUd95mWwjzthVZq6xFBEH1oiD7hkHnz9JmBGFm5CmDV/iMJr9ktOith6NcbAidQZk4mTirEON9Y/fGw7mP/w3uFHqw/WZuXIRFHNfpING72G47AgAOHKD/cUtLiTrnhW/MvsCoWOQrj0vOJhjAExKw8FcHPa6nbeXfT4i+0Rj25GXWLjSVHPTMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHUCR6W23uXlEJuji74kNWLxxqihM6WVdPuhLjidJkM=;
 b=N1hNZDFHLR0YiMk7Gg2Xk4DMYDKpLV5gzSjEmIT64c20DM5gk4n+yzCHmLcyZ4nj8VxGSC+Wkc3suttGlO1GIkt8vKx8KGifrW7r63Bq605ojh1iCuei1UuqYczNioQ/pqD9u0nFAhndgzKg4LdSXIVgOalDIs8lO66V2Txna9wzE0caEciuSatrKFyHESqCk5rkrbii0vCY5p3eQhTpys/aKeqckuWVBHt9YHEbmRaMKxjpbNG3ZfEUBRD5YiVZHHGZGWj1ZsxbR1Z4jDafGE9jlQGwPlxYagfcUkOx2shpjjTa032kuopd4dpK39AHYc6hFwsagVBvhE495Jc3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7278.namprd11.prod.outlook.com (2603:10b6:8:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:41:35 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9456.013; Thu, 8 Jan 2026
 09:41:35 +0000
Message-ID: <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
Date: Thu, 8 Jan 2026 17:41:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
Content-Language: en-US
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <20251222135357.143339-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0041.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::7)
 To IA3PR11MB9136.namprd11.prod.outlook.com
 (2603:10b6:208:574::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9136:EE_|DM4PR11MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: acbfccc5-337f-47a3-a276-08de4e9a1cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWU3Z2N4bVhvR3NRd1pvcHVabHNoTStUdHFvaUMyVmNhd1FhditMR3RVOGky?=
 =?utf-8?B?RTRlVXpZaHEzT1ByM1hjNjduT2ozVzBSOVFQMFYybno2TWJvSzF0M1pSTHpI?=
 =?utf-8?B?RTF2UWYzelBYSUlTSm9xTkQ5QVZqTG1yNWxzcDMrMUNUOTJROFVDenlGdUc0?=
 =?utf-8?B?UTRsaHpDcVVJZEdqSWN4TS9DZ0dKZ1FTVWEyT1ByTXRIZDNaZjJ5OW4vbjF1?=
 =?utf-8?B?QVpIT0U3V2hqUG1wQ3BvWXN2Y2E2M2lrSjNLRzk5S0RrUjMvTC9NU1RvU3F0?=
 =?utf-8?B?S2NkWU9vbmJlNEhhNUhxMTBNUFNCS3lyN0FHWDBhcmZSc2tic1JjSC9TWFpn?=
 =?utf-8?B?ZVE3SVBGL0hGUy9pY3FadVdTc2tCRUhYR2hIZUhuamMvbEZMNitnR0xxdzFi?=
 =?utf-8?B?Qk1VM3c5ckFDVGJydmpBTm1lbURVbEtSS2ZYOHhBS09zaFAyQzh4T1dWWEpF?=
 =?utf-8?B?eTgvNDFMNjBwekg0MWRiT2E0ekhBQUhRS3hreEJkMllhOERPVkNUS3VJeGpX?=
 =?utf-8?B?SGM5R1VhdVJ3dmRObm1ZMmxTT2pxMCs0M2VrbVBaNHpmOGVHSWlHdnhUdHNx?=
 =?utf-8?B?eUhaN3BKRkR4MW91clRQV3dtVFc5ckYxek1mRXdHZXNXMEsxNEFvVHRnNk9P?=
 =?utf-8?B?SWhkTE9CVDZ1ekpZeDJOK2NvNFJvaGw0cnB5U2o2QTlRVEN6QjdWVnVVdkVm?=
 =?utf-8?B?ODBrc0NhOHRRZ0RBOUs1bTYwU1ZSZUVFblp1cUdCMW8zMVFnTVhXQXpVeDho?=
 =?utf-8?B?QlNBMzhQOG4xYVplRHVMSFZ5dFlOUUxhWEZ4cFFZSlEyMXpNYTRRamVucGox?=
 =?utf-8?B?dFVtcGNVenNTTjg4RUd4THV0ZFNxL3VQUXdEVVIwZ1E0Slp5Ym5hM25JdGxj?=
 =?utf-8?B?eGt0KzFwOWtzeEtqbUNiRjg4TlBBc3dvYUgrZlN4Sy93SlhFR3Zodnh3eWVz?=
 =?utf-8?B?K3JjV3VCZ0JnSlRXMlo1bGVxdzZyYUhFNlFSb3M5WEFQTDBROEdWVDZJSnZp?=
 =?utf-8?B?bE9DVGJxd1lZd3BZZm4zeVVhbVk2N3VKUStwanlXdzdRakhYRVROY2JEZEdo?=
 =?utf-8?B?SXJna3JWeWtoakQzTzJOSVc5SGlEdGNBd1JvSlhGV3dzQWVwWm5oUGdZaDdO?=
 =?utf-8?B?K2F3UlEwTHBsbUgvbk5TRThxMjloVXd1ZjBpb3lFWFo5bytLZjhTUlNJYW52?=
 =?utf-8?B?NUNia3llWVVpRlVET0FRSWJVYW9STlIzeXFhMEFvS0NZZk50bHVsMjlYQXU0?=
 =?utf-8?B?aUt4aG5aangxL3E5ZWF4UCtKR2I4WjZFU0xWSzdTekFWR3JXeXZKUDdEUDFm?=
 =?utf-8?B?Mm1CR0FjMGJsZEpGOGVkUGMrVXhvV3NNY25iUGVqZVFtU2JSVlVDL3VmN2hm?=
 =?utf-8?B?T2ZkTXd6YmcrV094OXArRm0yaXF6b3dUemlsTGRBalVSc0tSSmE0bzRDNzBX?=
 =?utf-8?B?V0xhdEJCK1prUU1HTjYrL1o3bUlWbXZKVFE4SmxLdVoyZ3draGFnY0Ywa3Jz?=
 =?utf-8?B?Zk13bVYvK3p6Z2dsdERyRTIwNmxQTk96M3NhaVlNK2t0c2lUZG15QjhYVW5t?=
 =?utf-8?B?eENWYWsrK1o2Tk5oeUJmejRSeitZUkxBV29tZno4ZjBsRkpZdTkvU084b3Ja?=
 =?utf-8?B?dDBMbVNMcnVpTGx5Q0NwTDJjV0hQTXZoL3dkQit6Y1QyaEFhUkhGWm52MUZk?=
 =?utf-8?B?ME1UWDBmUnB5QkdGcmp5aTBRVTFyNVR0UTBTOU0rS21HNXdnTHFwYTMwNmVI?=
 =?utf-8?B?b2w5K2FhVXlrOWxRbnQ5cHp0M1BVeGxudjJSMlk4MW0vcmVnL2VnRC9teXM5?=
 =?utf-8?B?VW1BNjlJWnRSMzNrcmRNazdmLzhxTFJQQVlQTktEVHdHaFBxYlFUUHQ5OW5Y?=
 =?utf-8?B?NHluQmNDNlB3d0xFTmdQRDRPSmZsMUNMRnoyZUFHbE13UGthWXc0TW5jNHVX?=
 =?utf-8?Q?yOTaVxZMrqHJt+/6upqWklSNnrKV9veN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRzZFVzdk92cjlKNE90N01OdlhERkF3ODlaRXl3b1F1bWVhNFRFVUp3RWRT?=
 =?utf-8?B?RkU3ZHBUNmwxUm5hNWNnNWVObDJ2VXplS1ovek5FSDIyYktHd3A5cGFiY0h2?=
 =?utf-8?B?RjZlRmVEZkNRSU9HcnloeTRvN1FsZGxNSVFJeGVsTzVvTElicTJnS1Ryc0dt?=
 =?utf-8?B?K1R6OStIVHlURDV4Z0MyczlJMVZhUC9IM2V3Q0RwT1BVM2xtaHp4VzZZYU5I?=
 =?utf-8?B?Q3FtNGVCUlc0SzdnQ1oweStaVUNMbmFuR3RiNTU0ZThmY3B6VHM5eFF2UTNG?=
 =?utf-8?B?Y1VtS0lIRHY4ZitUbzF6S0x1WXR2MmJvMTRSNzZTdndESXlrMW1RR3dvWVpn?=
 =?utf-8?B?ZkhtVlFzVHRBK1d1YS9TUkpMdkd5a3BIalV2Q2N2b3cvMCtTM2hYN01uZWxm?=
 =?utf-8?B?Ylp2MDZSdWx5YlpmdDhFU1ZwSFlmaDZ6ZDZwNDlseUlDcjhWWmdtMi91cWJY?=
 =?utf-8?B?WnE4a2hwVUdNMTllbXlFd3VNWmRRTjh6QTljSVQreDAvV0lDTjhwVzJSSnFv?=
 =?utf-8?B?TExod3Q5ajcwOUhuUmsrOE1saEJTZmJndkkxMTNob2Z0K2pGMVpjK0VYOXd5?=
 =?utf-8?B?S1ZOYVY5T3Y4eno5akppOUdaakZqREFsWkRUQVVvb3UxVU85dnJraDBjT1E5?=
 =?utf-8?B?OG8rLy8wRVNsb29NQ1RwRExNekkzdVZJMG9KQ2lKbHlBVFdRVFhZSUNqU1c3?=
 =?utf-8?B?WnFVdENSU1Z4eHhOUWF5Uys4MTU3MkZLa2VJM3laeDlEM29BOThwOEtweW1D?=
 =?utf-8?B?ZzZWZGdYclFTcjZaTzdzcWxtNlcvcEV3Sm5uOGFVMiswYXJSNDFkV2lrMUh4?=
 =?utf-8?B?NlZ5NHErY0VQdVJDVWx4TzUwWDBxNGlueGtPYWs3OGlDajM5OUwwR21nVEFy?=
 =?utf-8?B?Y2kvYjRzdzA4WHpldWRQaDhUTEVJSHhabThEYkExZEdHOEl2KzNXN3lxMDd6?=
 =?utf-8?B?amVlbWV1T1d0NnJsSUhaS2hGanQ1bytoQkoyNTJUdGVUY0VxbS9zVnp1TnNG?=
 =?utf-8?B?V3FhYkdreVJNMHdkdVFrcnlCTFUzNFBkZUJHNm5YeGZpZ0dDRHE5UjZub3NI?=
 =?utf-8?B?UmxzMmQxbURVRmVKMk1TQVJkTTdTdVdsT1JlaHlOMWpqdTdJMjFLNDEzc0dx?=
 =?utf-8?B?WkFyUXByQ3c3T2VEWDc0cVc2NmJudGhIa2xFZzRZQUhEUUVPc2NpM2xTVUtX?=
 =?utf-8?B?T2NPNU8zbENUd1YrVFpxcWlFS0pNVFZReHdTcVRJTVVDQllqakFuVXdMcDRp?=
 =?utf-8?B?elpOTHRFOG40UFlXSXFqWG13cmJ4ZVYveHBVZ0NYSCt2RlZralJubHkxSlJw?=
 =?utf-8?B?b3JBT2xMcndqODZURGNIRVQ1SzJybVY2RU9jL0JOUDZhU3cwOGhIUlRHY3JB?=
 =?utf-8?B?Zk00S0lMRndnSzdrNjdZNXczamwyeEljUlRJWDdDalRkRGVDUFdxb1hkQzN5?=
 =?utf-8?B?Ni91ejhzeFZON2lNUGRBQlU5Q0w4TmtUbjdKN1Jyc3dBNE5Hem1QbllYOUtP?=
 =?utf-8?B?ZGhFeDAvZmgrLzRZWE1WOGNKdnpSbDBWR1loSmc2d3J0UUUvVXE4ZTJ3V0pV?=
 =?utf-8?B?NHdPM2tXYzdCSEVreWZBOHhRWWVXMUtkTzVEb0liYzlveDBFekdOTXBnNGN4?=
 =?utf-8?B?a1d6RmdrMnMzdFFMM1MrVzJXYXFQYTNwbjAyQThudDlYM0lPd3JxMDV4MjZt?=
 =?utf-8?B?SGRZRGpWVTA4Umg0dllOaWJvUitjZVp4cTBNNXRsWVIrTE12R3FEK2tSU2k2?=
 =?utf-8?B?a29UWjUvV1hodmZuS3lNNC92SjNzSFhZb1BHa2VoMm43T0o4Z2UzVzNwajBN?=
 =?utf-8?B?Z05hSzRTbzFRNERRNm1xa0VRSnM4T2cwTXowbW84TlNaYTdUVHQvWlM0NnIr?=
 =?utf-8?B?dG54QVcyemdoSWh4SDdDNGFLZTdVYnBUV0xlZzdqMkc1MHo4K2Vac01vMnp3?=
 =?utf-8?B?Q3E2TjRGSmJXdTJXQ056eElTYVBrRGRha2sxQW5wNFRyT2FXamY3MVFqWmV1?=
 =?utf-8?B?T0xteXBaaStCM0lQMitYdFByTTJKZFlGTzQ3TE14dW5NUmxpNmZUWUNQM0VB?=
 =?utf-8?B?cDU1YklkZWhZL0ovMWZWWDBLUXpteWtTOGJZUTdrd3VIL0VLVWdDMmkxYlZq?=
 =?utf-8?B?WWR6V3FoazN5TGZ6eE85Y2o3eEgvK3kzSm14L3YySlFpWDBWT2VBays2ZTA3?=
 =?utf-8?B?TklibjdEQWU0aFhuVy9rVkdPN012ekl0K05LWGs5anQ2cnZ2eGozR0xSc28x?=
 =?utf-8?B?LzQ2YUdNTFdVeUNxZTQySkZqekhRMnZRTkRmM0xJWCtDRHhNcnBiWFJtN3p6?=
 =?utf-8?B?bmUrMmx0YTlzcHIxZWhydVB4UUFuaEMwbHloTUovRitic1NyZmxkbjQwK1E1?=
 =?utf-8?Q?rTbuW0thg0U4OpBI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acbfccc5-337f-47a3-a276-08de4e9a1cc4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:41:35.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBAaHZcvw/j/4DhELF5Q0/jnYj2M/KW7huWh1UjEr2k/gYXAv7g7VkVUmWZX2Oq/ZoEAJBQanfeYw4/lfUIxYJy4vMmDagC17TNgJUkYr6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7278
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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


On 12/22/2025 9:53 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. Create a dmabuf for each mapped BAR region after the mmap is set
> up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
> the BAR correctly in the host IOMMU page table.
>
> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
> and continues with normal mmap handling.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/vfio/region.c     | 57 +++++++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/trace-events |  1 +
>   2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index b165ab0b93..6949f6779c 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -29,6 +29,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/units.h"
>   #include "monitor/monitor.h"
> +#include "system/ramblock.h"
>   #include "vfio-helpers.h"
>   
>   /*
> @@ -238,13 +239,52 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
>       region->mmaps[index].mmap = NULL;
>   }
>   
> +static int vfio_region_create_dma_buf(VFIORegion *region)
> +{
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +    VFIODevice *vbasedev = region->vbasedev;
> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    size_t total_size;
> +    int i, ret;
> +
> +    g_assert(region->nr_mmaps);
> +
> +    total_size = sizeof(*feature) + sizeof(*dma_buf) +
> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
> +    feature = g_malloc0(total_size);
> +    *feature = (struct vfio_device_feature) {
> +        .argsz = total_size,
> +        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
> +    };
> +
> +    dma_buf = (void *)feature->data;
> +    *dma_buf = (struct vfio_device_feature_dma_buf) {
> +        .region_index = region->nr,
> +        .open_flags = O_RDWR,
> +        .nr_ranges = region->nr_mmaps,
> +    };
> +
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
> +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
> +    }
> +
> +    ret = vbasedev->io_ops->device_feature(vbasedev, feature);

vbasedev->io_ops->device_feature may be NULL for other backend like vfio-user.

> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
> +                                 region->mem->name, region->mmaps[i].offset,
> +                                 region->mmaps[i].size);
> +    }
> +    return ret;
> +}
> +
>   int vfio_region_mmap(VFIORegion *region)
>   {
>       int i, ret, prot = 0;
>       char *name;
>       int fd;
>   
> -    if (!region->mem) {
> +    if (!region->mem || !region->nr_mmaps) {

Just curious, when will above check return true?

>           return 0;
>       }
>   
> @@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
>                                  region->mmaps[i].size - 1);
>       }
>   
> +    ret = vfio_region_create_dma_buf(region);
> +    if (ret < 0) {
> +        if (ret == -ENOTTY) {
> +            warn_report_once("VFIO dmabuf not supported in kernel");
> +        } else {
> +            error_report("%s: failed to create dmabuf: %s",
> +                         memory_region_name(region->mem), strerror(errno));
> +        }
> +    } else {
> +        MemoryRegion *mr = &region->mmaps[0].mem;

Do we need to support region->mmaps[1]?

Thanks

Zhenzhong

> +        RAMBlock *ram_block = mr->ram_block;
> +
> +        ram_block->fd = ret;
> +    }
> +
>       return 0;
>   
>   no_mmap:
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1e895448cd..592a0349d4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -117,6 +117,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
>   vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>   vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
>   vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
> +vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
>   vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
>   vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
>   vfio_region_exit(const char *name, int index) "Device %s, region %d"

