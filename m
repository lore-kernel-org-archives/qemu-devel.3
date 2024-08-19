Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51007C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1FH-0005Hg-0c; Mon, 19 Aug 2024 08:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sg1FB-00052z-4l
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 08:12:17 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sg1F6-0006FE-UT
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 08:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724069533; x=1755605533;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yMFavEVoTWk7/NZKbMhgxXZqu3nyYChyZzPHPrgnF2M=;
 b=fc+q4BGewo7clwxP5s4Nl1g4v/CzVYpYyYcCHQc+bbvR8KG0/UJ4EKo+
 8/oysZHehUCQ5o4YrL0m3WWF7AaclBEVP1vvdcXkB1AI0HmL4CdH9O+P/
 Vgn3AEx03ejaS94XmoK9anq/N0mhs08mIMHS+sifyi3D+vt7jO8D+PbCc
 +Y038sTtUcHma8StBeafe1Ta6N3l7cX6vvatXFHDcgON+gsSa/VTWmvnP
 4CacF1noisv5IQoQI8cnD9U0Y2nO9K5jhQJxY8/0EQrjIPqFNF3liQb9j
 uTxL9pJFEsAlrYz+jmQcQMLRePh5jULqjDIPrSqg8phKuYPvnUCMOIzak A==;
X-CSE-ConnectionGUID: LjS2z2jyT26gsdXKlEa8bQ==
X-CSE-MsgGUID: klmnhQlIQYiEMTF3yR9lrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="25215894"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; d="scan'208";a="25215894"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 05:12:05 -0700
X-CSE-ConnectionGUID: eUj3WeuPT6qlz52JVmIp/Q==
X-CSE-MsgGUID: 10RiA0n5SHqqxp3vxTVBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; d="scan'208";a="60334272"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 05:12:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:12:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:12:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 05:12:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 05:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opAdpvQEPPcxcA07Q+q4mvU9jTtXmipOllXPcRtw8PLSG/+OObcV1KcH5JzMwzIl5jF5mVS+Smx5Sc+c08nLGLO1ALzTgt06J3FuWeqabp/h+Ztoy4TYVHpxhI6pa91zKmiXZzVw9Z8F9AADgcpmjGZ/z6PNMNFlyxzWQ+YD4YtqsmWrTeLyhPMNTYx311V3a/DH3RVuILOdfAAZ1EXof1FsVDGwuZTYnBLCviXIMXebu0VcvTMmqN/yecUAO5ClQzt+zPwZ+fRngSDPvBWsEY+kXXJGy8zJBjUoOsj5tNPSDjECI1i9RJS/GYkgp1ZVXiauEmmHtg066D8GPNIlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3GijEZgKyD/Wsdl3jQqRPxX282pPM7utkZIFX3e1qc=;
 b=XU2egjgFIftXc7RF+PKiUZs6d11d8D3jN1+xXuYlR7iXhQXuKK+n8uyx3hA/+LH1rzAxnoOX1b/El8QWfABlFfeKVThCCPWXD4womnZetcn97I8hq+ZNR1u/2WzyfpaBBvXlb8Qor+IGJnAKn9Y8j8QW3PAg9iq2qxRgEyBTR1WPNVpb9RAmQ4gktQDOuoABTx7t8TvRLNI6jcNtnPQizKm0i2mGxE4zuIm1Fuvnm8pXreqQ+JFRLSaFfN/38FYrZMGKlyjjzU3dTvKILsDPulbIvOhbSHtCxdOSyOYlETmBgz8s189Q7MW+C44awXAURGfjIa7cXh26czVqamD6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:12:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:12:01 +0000
Message-ID: <a516196a-a7bd-44bc-aa2d-b3b53676e036@intel.com>
Date: Mon, 19 Aug 2024 20:16:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-17-zhenzhong.duan@intel.com>
 <9b2b2f76-a5ef-4378-b233-af1a44f742c7@intel.com>
 <SJ0PR11MB6744410546621C57CCF7D2E892802@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <68c7f380-08c3-42ca-9cb8-db0368f92fc2@intel.com>
 <SJ0PR11MB6744C75C8C541498CA22479E928C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744C75C8C541498CA22479E928C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 62749378-d7ea-4996-8a21-08dcc0482175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enJPaTRmWHVibGJ6bmZrNTZPU0ZqQ0FrNUovSzRteGVOZE00MVYwajNIekI1?=
 =?utf-8?B?eFdiZm5jZERIbnRrZXEwdWQ5Zzh4YzBVQ1RDVTg3R2k4K280cENiT3lMU2Nh?=
 =?utf-8?B?YWxNd29QaktuSGlBM3pnTk51S3hWYmxKSUFLdSsrbzBmRmRvVmVpOEtMQnBF?=
 =?utf-8?B?bXFiMmNzZ1FJVG0zWHhhRVZIV09Wa0tseHMrVW50czRKWGRZelZhL2s0WWVR?=
 =?utf-8?B?VllLcStHWUYwYjVZMDRsV0dKWmhRYVdzTUhUajZyaSs0K2lyLzg1b010QVNu?=
 =?utf-8?B?UGF1RW5VSDVEWk14dE9rVDQ0OVBkd0JOWlA1RnNhek9hbmdmZnhNbTZHTHBK?=
 =?utf-8?B?cjFZb3pSaHBpWGxJbkVucG03eGtkc3o3SFNxT1RaNXUvNTc2TS9BTUpHZ0p6?=
 =?utf-8?B?WVZuTUtWMFNBQVQ0aVNOWTJmT09YZDFkSVV0Rld5YzQ3WEFMRXYvdnhhakdJ?=
 =?utf-8?B?NGYzdU56RmJUc0VlSk1LTGRmM2RaMFBxdGRiNkpEeVdKNFBXM0F1U1Qrc2RB?=
 =?utf-8?B?R2NKcHI1cytkRkllcU16dFV4b1YvbEpMNmw5Vzg0ZzQzS21IYzl3ejdOckY0?=
 =?utf-8?B?Yk9zZFE0UmRJcHFtamNJVGFxNzFsTENVcktCaEpNRnExOFhRUTJnd20rejBF?=
 =?utf-8?B?T29tR3JNdVpRcHViVVZGWGtpeS9hRXZha0VBYVhlSUdCWmxLUUI2WU1rL0ty?=
 =?utf-8?B?ZlVQWkpVNllYWGlvbWNFNTJlbERna2tDUUhmYldDcUxveFNBS0JBc1F5Zzdw?=
 =?utf-8?B?UHV5dEc4WXhtdjViald2RUw5YUZIdVNPRjMwZFhJcDNhYUJGUmRPdVRVajJ5?=
 =?utf-8?B?R1RVa211Ukp1ZjY1YmxzUE9IRGhmOElCT3ZrRlBpWVdRdmIxMFdQdExiSjBD?=
 =?utf-8?B?bndSaWpRRkxMYk54SlZWc1dybjJpcjkyYUx0YVllMkZ1OUNBc2dscjZOWDJs?=
 =?utf-8?B?NE8xUzJpdW55VnJzZU9oclgvays3K3FFM2t4clpTd1RGZldlV0VsejcxNitp?=
 =?utf-8?B?V0xuZXIwNVVUYUFXWHh4ZHdjYU01TW1LUzY2TFFVZDlWczBEb3FNM0Jnd3Bx?=
 =?utf-8?B?UWdqdTF2KzJjTGFrb3lUNmxXR3FTTVFvVDZ0eThad2pia1N6UTVvZElZSEt1?=
 =?utf-8?B?MDhJblM1V2FuRlZmVVVVVkV6bXJBOXF3RFZ6aHh2aElKRXlud1NzRkViclpt?=
 =?utf-8?B?SVdLM2wvNFZJWWRsSWFpa3JNM0V0Y3F0Vi9VZ1NEQ0VSc2ZtdGZQL25oYnR0?=
 =?utf-8?B?RXR5Ni9VRm01V0w0blFEeHFkVXhLR3pra2dvcEZPQ1hYem8zNDR5SGhrcnhK?=
 =?utf-8?B?bzlPWGJvVktIVVQrc3NNV0pmSVZPQmtXbjN5aUs2QjNCS0NmOHo0ZUl5UDFl?=
 =?utf-8?B?WW5Jb2N6QkwzTHo4QTV6UHZzVitYaEtLU0l3WEZaZkJidUJmVEhNNUx1T0JK?=
 =?utf-8?B?Yk0reWpxKytyMFpDN3NDMm5PNEx6eTdseU1jM09iZ1RpaEZpbGFHem5qc0Z2?=
 =?utf-8?B?MDRsc1Q3WjRmRXl3eWF0M01NZ01YampuU09KM0F6NWtYR1ZlajF3THlvS1RV?=
 =?utf-8?B?NTJDMnJ6Wk1kYTBPZW1wcjZ0V2JxSTVyL2VZeWlKcWpuVWhoV3pNWW1RVDRN?=
 =?utf-8?B?WlVNWS9XYmg5c1RJamQzV3FMUTJHTDdIT0lEOCtlMTk1bEFNamJmZWcxY25t?=
 =?utf-8?B?NXl3bXkzTUNQR2VNZFIvVXVCQ2FOa0plV0x1V3pqNmVDWGNsS1hGUFVjcURk?=
 =?utf-8?Q?0XeyXR8CQzmh/J33GY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RTUWxXK0NFRWJyemk4S0lNZWpScHNkSFdFVGpzTFBGS2hrR1lBRWRWdkFE?=
 =?utf-8?B?MjA1UHMzYlBneUJRQ0lpNWZMbDBlWWxGdTliTHpwV2tuSXVMMmpKdm9xTFhD?=
 =?utf-8?B?QkFWTzJlVHRYRGNidEhzbHVCUm1BUi80ZDlxa0pTS28yK0orTlNZaUNBcXRH?=
 =?utf-8?B?SFdIRm81N0I0R0xCbk9uazhFV3FDWWZvdUF2WWNIdmN3S3lyUGxxR3F5emZX?=
 =?utf-8?B?S0pZYmsxeHJLaXRZS0pKK2ZDK1V3ZTVrVWpLVkdXaENBUmZ2UnRMNjFUYzlm?=
 =?utf-8?B?eGZnL2UrZzV0bmpWVnI4ZW13RkZGdVhMSlpxc3dGQ2hPOXNSUjlNVCtXMjlh?=
 =?utf-8?B?ZHJLMXd2amVLSTV6MVNUSStoWnY0dDQ2M0VyS09GS2g4WS9EbTV0ZnhIWG44?=
 =?utf-8?B?YTFwYjFkUUdTUDNNSXF0UU1HUE9uNGpqbmcwbm4zL1YxTVJaVTRUQllwRjNv?=
 =?utf-8?B?WmNwblBJUG5qL2syMnBoZG1OSHh5aFY3S3VhekhtbExNalYyK0wvT284V1lO?=
 =?utf-8?B?WmxZcXNnYnJxV1lBeGgvYTM4SmRlTDJNZGQwaWdXcUp5eklSOXhjOWVFYlpC?=
 =?utf-8?B?UlYxMzJyNEp3R2dsNitmMmM2bXpkTDFsaEVZN2tzM1VYc2twSTFGZVo2elUx?=
 =?utf-8?B?bFlvS3dqVVlWYW9aVWpKL1Vlc1FEMks1QTA2L1FISVZDeGVlUldrTXZXUGoz?=
 =?utf-8?B?VWdYVFNscGdPVlVySVpqYVpzYXZrYVJtRE5nSHFWdVY1Y0V2NzUyOSt6NTlR?=
 =?utf-8?B?ZXhXc3Y1bENqdHJyRVQwOXM1QWpTT1pkTWtEUTFCbnZwTkZyRlc2U1d3bkpu?=
 =?utf-8?B?bUpMMFY5TGh2SUNWLzVSdkFUZE1MVGtaR1paMkxNREw3Znh5QlhSdXVBdTJz?=
 =?utf-8?B?ajZRdUN6N2JKUVBFbUNub3l0S0NLQlk4ZW9GMjlncEQxM0w0OVRNZ1FRZThy?=
 =?utf-8?B?NmlGMDhxZGZ6WktESU9NTVpwQlNCWjQxQ3l0TXJCaXNMMDh1MUV4YkVETjJJ?=
 =?utf-8?B?Ujk1MHVqckRaZS9HSnVoK1dmWmYyaFVEdDdDdXZKLzhmMm9KdVVqNGcwZXdm?=
 =?utf-8?B?aTcwTGt2cGhSUGo1TnZnZS9XbjBCOThVNi9zWU5RM3dndGdFS05IN3hER1k1?=
 =?utf-8?B?YzRkbVl3NG1kVWprZW9DZ3NGTkpINktLTjB5WFcyTDBraCtSeVJibVEyWFpm?=
 =?utf-8?B?WmpEWGt3RGVZWGdtWGd1RUdHOE9tZ2dFNWRMVFhZYUVJTDhyRkhHOFd2a1RN?=
 =?utf-8?B?R1Y3eWx3ZEs5K2wzcXZGNEpIM21FRitTUHA5YzhGd3NCV3NIaCtnOE1uZUpJ?=
 =?utf-8?B?N1UrVHF5OEtFempvQS9qRjF1NkpuZi9ydmtaOFArU0VtMWdPZ09KVWh5amg0?=
 =?utf-8?B?QU02WG11WENYWFBvY1B3TXl1TWZaS0FzQ3ZsTmhVVVdycWFyUlhpbXBod2J5?=
 =?utf-8?B?M2EwSjRTVDEzQWh1b1FaTSsvRGtod2NLS2RydFVOeTJhUThvZjBQeWovdllz?=
 =?utf-8?B?QmNlRkFFQlpROHNZUFZyOXhGd0VkYjNEOTdhbGswak43MFQrcEozVGVaMFo3?=
 =?utf-8?B?S3NVT3ZkdUNwemJjMmd4RS9wbzdLSmwyditVQnc2Q1RJYnRCMmVKV3FsUWJQ?=
 =?utf-8?B?OXRSNFJGMUJ2cDMzMFNyTWs0bEhLaXUrT2xqQzdrUTMvTUVnYzhjb3ZTS2xX?=
 =?utf-8?B?TXVyVEg4ajM0YjZSWjl5YWlhQTdITVowRkJwb2EvVVU3ckhiM1VOMzlKQU5E?=
 =?utf-8?B?cEZHcEN5WVd3dkt1VUN5ZHVocldnaWZRMnhNYXl6RUdlR3hiOFhYMG10OElB?=
 =?utf-8?B?WTh4ckYyWXZVM3RCdi8wL1JXcjd4NVdjcHM5RjFuaTlDRjB6TXdIR2phQWRY?=
 =?utf-8?B?cDlnZExXSVYrcVlWdXUrdjZ3WTlITHd5MWxIeHgyazBQcFhjc1dCbmtkZ282?=
 =?utf-8?B?d2p4M3ZYbzB4Tm5QSkFtWUZPVlc3K0FQcmptRFlVTzZNc3JmTU0rT3EzbU1y?=
 =?utf-8?B?MGE1T21zeWNpOW5xNkprNnBTcHpMOWFWaFZGaFBFUUt1YW4wTm0wKzcrOTQx?=
 =?utf-8?B?WElKOFkzejZHdEVxeThtWUhVcVBabHNMV2RVWmZaWmlFbEhGV0wzbzFxcngr?=
 =?utf-8?Q?RXgugo1aHkKncLOjKzUw36+31?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62749378-d7ea-4996-8a21-08dcc0482175
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:12:01.4522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EP/kcfvKbHOsmuAH/5Sc6X44C3j/OdnnvJJvJZGtWeVxPFY5zmR5STtaE/TLXQfprE0TKjx2s6cTG46ZNvXFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/8/19 17:41, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 16/17] intel_iommu: Introduce a property to control
>> FS1GP cap bit setting
>>
>> On 2024/8/15 11:46, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Subject: Re: [PATCH v2 16/17] intel_iommu: Introduce a property to
>> control
>>>> FS1GP cap bit setting
>>>>
>>>> On 2024/8/5 14:27, Zhenzhong Duan wrote:
>>>>> When host IOMMU doesn't support FS1GP but vIOMMU does, host
>>>> IOMMU
>>>>> can't translate stage-1 page table from guest correctly.
>>>>
>>>> this series is for emulated devices, so the above statement does not
>>>> belong to this series. Is there any other reason to have this option?
>>>
>>> Good catch, will remove this comment.
>>> In fact, this patch is mainly for passthrough device where host IOMMU
>> doesn't support fs1gp.
>>
>> I see. To me, as long as the vIOMMU page walk logic supports 1GP large
>> pages, it's ok to report the FS1GP cap to VM. But it is still fine to
>> have this property to opt-out FS1GP if admin/orchestration layer(e.g. libvirt)
>> knows no hw iommu has this capability, so it is better to opt out it
>> before invoking QEMU.
>>
>> Is this your motivation for this property?
> 
> Exactly.

ok, then let's keep it in this series after refining the commit message a
bit.

>>
>>>>
>>>>> Add a property x-cap-fs1gp for user to turn FS1GP off so that
>>>>> nested page table on host side works.
>>>>
>>>> I guess you would need to sync the FS1GP cap with host before reporting
>> it
>>>> in vIOMMU when comes to support passthrough devices.
>>>
>>> Yes, we already have this check, see
>> https://github.com/yiliu1765/qemu/commit/b7ac7ce3a2e21eb1b3172743
>> ee6f73e80fe67b3a
>>
>> good to know it. :) Will you fail the VM if the device's iommu does not
>> support FS1GP or just mask out the FS1GP?
> 
> For cold plugged VFIO device, it will fail the VM with "Stage-1 1GB huge page is unsupported by host IOMMU" error report.
> For hotplug VFIO device, only hotplug fails with "Stage-1 1GB huge page is unsupported by host IOMMU".
> 
> We don't update vIOMMU cap/ecap from host cap/ecap per Michael's suggestion, only vIOMMU properties can control them.

I see. yeah, it makes sense.

-- 
Regards,
Yi Liu

