Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAB8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN6E-0007eR-BP; Sat, 30 Aug 2025 11:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urtet-0006zT-66
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:36:27 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urteq-0003lp-VH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756452986; x=1787988986;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+J/urgxdpGkgmTn9HBKrGyvDQQ6X+8DBgVcWhsCnDk8=;
 b=ZX17q2c/siHJHx/xHHpTb+V0MPj79dpTOreZNepE7xThy7Dap8j9Je2j
 197B3EzQNBf1OQZyfavy2hlgd1KrD6K4I4SbNWazKtTplswq2tZUo+IGA
 JxgpomaDw5C1QyZFFOtEmf6FDrfs48yCTQPAQl49aaKvSV+V4XW9iMjGp
 h6roNLupBVLxZ96bhQ79kdwydRd5YFIsaBtVrPPzQM7/4jO1IX2cyE++n
 tGOjaqGRwAOMmNoH86NL3dfIsfjQvsWeaxxtR/WcTw0XlNsdwQysgbsp7
 rgTxR6oz4Nw6jLyFev4hxZN9Eo4iPee7CBOQaDzE+gN83zDajyQcCME5T w==;
X-CSE-ConnectionGUID: yx9/3YtZSXi8NFXKlZTIfw==
X-CSE-MsgGUID: m3LY+e8uQfm3IPG9qBiD/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58803430"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58803430"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:36:19 -0700
X-CSE-ConnectionGUID: Ey5aa8G4RDC0vYjJGw+hWQ==
X-CSE-MsgGUID: pk0asXKoTLK6jyjECZ+/6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="174492466"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:36:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:36:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 00:36:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.80)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:36:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1RgP+N3e/rV8taQx7ruPYFrxGZ+fkH51/gmmbCcfOIzvJQqzpfCiFym1q/9WM94mxJ8ccNOEwh+k4SMFCT5NURO7NNM6hg3Ui5xncdTYrLwq0cDfefN2uUxS7HolbHgh7AKg1QXRkYFxm0v+rKo14u/+YpFzTDBQf3T25CLHqQzeZqudvA6zoJQWtv+CVQWCpfC1VyTnM138Rx2CEYCvrsVokdF0RwD+Rr19B6C8V1dVkrrq0EBIyLpYjw2L7KOX7mfmQ5mU5ouw9qcGMf0nvDMPHT8y2TS9LHX6K++8c9buW8EAOvV29NpX8T94sbN41TYo8m972ghNgGaOA57BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozwAM/ExfaonTbeGCpMGTjQIwtYmOenJxZU80OE9eWA=;
 b=daokVgTlhLuzdcKBGlQ0OtjxrCuwbwJ2jvRYDVRTBs8eFne2/kW1B5TKDD2Rv5RK/ix4PXu/LAtk3VHPvumdFi+ib2MiX7warYCl3cus+gsAETdNYb7V2YjVQOF2sPTkEJH/QGkrhhb1O/5c6CVmxYnuzQdNEkCZqufq31clvLWpjPD0s0E43JPJfrv6EQ12BQ3/N6EYw7CXs19PI98cnFyy+PgKiSShgIgjUzfNRnzKn2lMXcZcWhKPUSxkCWhPQ04mvMMoN2LvdQZ1DWVM+C7e0wtF2y6itEO8AUEgDriveHcPTAw5D3tL8M2UqQ1D5qCV7h4O5H9lL9FJMrwiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 07:36:10 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:36:10 +0000
Message-ID: <73f2d705-e571-4248-8a2a-26c38a0395e5@intel.com>
Date: Fri, 29 Aug 2025 15:42:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/21] intel_iommu: Enable host device when x-flts=on
 in scalable mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-22-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-22-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|CO1PR11MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e0ab19-fa1d-4a92-0afe-08dde6ceb8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGF0TGs4TUd1L1BEeEhPclE0K21uV2I5eXZmekt5YlZrVngwSGFLN1VkNklt?=
 =?utf-8?B?MXZiY3pmYkZVSDc3dHdTTnpLaXYwVmhOOTg4Ry92bmlQY3E1R0hKTG5RRS8w?=
 =?utf-8?B?NklwQXhvcWhERnNDUFQwOGhFT2pEU3lkbTdjenFqTnJlZXdXTnJnK1A3cGlx?=
 =?utf-8?B?Mk5YR1E0dWhYZlNkT3U3NnoxS2ZkVzZGSEdPd0c1bFRiR0ZkbFQ2UlFGK3g4?=
 =?utf-8?B?c0I2L09jWmtoQ2xkWWdYYzNPSm5XWFJBcm56VXpQa2pyM1NOanRFSDIwQWJQ?=
 =?utf-8?B?YlVPT0E5TU1JVVhHOU9vRDcxb2MzbTRtS1NYSFdhdkNVcUZSRVJJVDBGQ3Ju?=
 =?utf-8?B?WFh6SkRXTmE3WitWRTZKL2xteFR4MUhaWEkvcm5RV09UZDZKSGFZS25pd0M0?=
 =?utf-8?B?djdtQ0phazJSZDZFVmEzZWZFZWhNMzJ5RDFuZnJvSXdReWRmSFBKM2s4cE02?=
 =?utf-8?B?b1RJSWlCSm4vOEdZVEZHNjRBSlE2QnZ2M0FjUzJxT1MvMC96aUJqMDRsQnZp?=
 =?utf-8?B?WHdRanlIQTd5N3F4Z2dEemM4YVlxNzNPTm5YOWRkTExTcjZHZHdwNmRGeGpL?=
 =?utf-8?B?QmVZVm56T3BQa0g5MGVtZUNJMUU0U3hCUEMwMG42OW9zTkVzTEVlZEpIbkIr?=
 =?utf-8?B?VG1SRXF4Mkt6QjZMQmIzMkt2VldmOVdKdVNGaW5sNHo4RWxuY3U1RUhFTy9v?=
 =?utf-8?B?UGNGbDJEdnBQd3Z5MUlkaXlpRzY3dWpUUzdZUFhLQTVxY0dqdXBGOUpraTJS?=
 =?utf-8?B?Y3gzZWw1Q2F0SjZDbzlSdHdSTUU1SWhFZUJYbEtnTXJhRTM4L3R2MWZrMVg2?=
 =?utf-8?B?Q2U2ZXpYWnFhS05EWEVYQnRPYkdvdU5TSHBYVUFUOTJpTEJtSTRTOWk2bFZs?=
 =?utf-8?B?akhwcm0rcWtUaXgybTErMmJjM3llY1dvVG5hQjR6YjFxRTBkaHc5VnVJTjBQ?=
 =?utf-8?B?c2dBdURiY01GVzJFQWJHYjZIRWhtbVR4aThWUGVXbzhXaFdTYjZ4dnJYYlVv?=
 =?utf-8?B?Z2x6MHBCd2ZBbFVLRWxvRURPWkhJTU1FNHF0MXU0RU13ZFZlSFZSeHZLSHI1?=
 =?utf-8?B?NG5ZdFYrREU0a3puUXF1RkNZV1RZQVg5N0hXeDIwb0NDVU9Yb2ZwLzFiamRz?=
 =?utf-8?B?ZXc5eDY5cW1nSzJUS1BMblJYQnJyRHVrdUs1a2V3Q01TaUJLaTlESVFqeVU1?=
 =?utf-8?B?Rk1jTEpkalhMbFM0aEllb3Y1V0syUnhLbWpIV0Y0TXRNSklYa3FhWDBtVkMz?=
 =?utf-8?B?ekhvZkU2ZXRrN0ZJWDNJS0xwek81NkxqNmJneGdrUnNHWmR2Y3Q5VnpsNndo?=
 =?utf-8?B?NlNZK2JLWnpJQlRuR29CWnNMZ0hXc2ZyV1RINzNlMGdXZG51SGMzdjlFbGFw?=
 =?utf-8?B?b0RMeU4xVy92UkJkMTk3WWN0eGd6cHQ0QzVmWnZJK2RrNFNyYlF2R3p6ZWJN?=
 =?utf-8?B?M1F1Tkw4UWxLdXJqcW5ndFg5bHBIMFVyK1EvRXVyYnM4K3lHdlN4VXdtRUhG?=
 =?utf-8?B?N2N5M2lnMTA5akpQOWpjMmNYVVNPTHFJSDFqNFdJWk5BTzlxTmUwelJpc0F4?=
 =?utf-8?B?Qm1RcjlpSXdrT0VGNlZDTXU0c2FNRnlrcm9QZ2pOWk1rQUFEblUvYW9VTzV0?=
 =?utf-8?B?QVUzb1dDNlNzOC9KYW1qZFFDTm5xRmt0Z29RQUE3N3U5bWpaR2xGeGNScEZi?=
 =?utf-8?B?M3QyR3lEdGk0b0k3NXo4dkZMNEtDN2NhUXV0NHZpVUJnN0ljckVoYjZpeUE0?=
 =?utf-8?B?NGtVM01LRzk4alpaTWNjWXN2c2I0bGdsK0g0ejBRdGNPdTdaekVIM2xJZ0Nr?=
 =?utf-8?B?SDJVTXU1WElLMjdGVUxuUXJ3Z1hjeEJwY2RRN3k1QXRRVU5HQ040dmtPSDJU?=
 =?utf-8?B?ZHBJemp0KzdxMHprRXduWWl6Mm45SVVBWlprT1M1SkFFazBKMG5YQVk1R3hO?=
 =?utf-8?Q?wHjvEd3D9YU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDVIa3VydDFyVEJHWW1lSVpyT1k1MWdwZHU2cEZYWGkxaGZ0Qks1TFNWK3Zv?=
 =?utf-8?B?T0JyUGsyazZJWExHMkZMRnRrSE5NK0JlbTh6WVpObVRMdGlQK2pscEFjeGZk?=
 =?utf-8?B?bjRxSGZhOC9PNVczdFF4TktMMDZicEVHcVpXeW5nTVNNdDJXSTFFajhGMXRU?=
 =?utf-8?B?ZFVnNjBoelVVR2ZabUJUTG1aRGtXOU1paW1Dd2ZFQ2I0c2h4Y1RiS3Z2RXpP?=
 =?utf-8?B?RTJ0dWp6MzNjOUNLVGRFMUNxemgyM3l4cWcyZDRSVjltb0ZhSUR1MW9oYjdi?=
 =?utf-8?B?OGFtRFZIZ25QSkpza1V6YTlrZXdFRVFWWllPTzM5SVhUcFgweDB0MWtQQzBD?=
 =?utf-8?B?VmlBK2VkNkZPR09WZ0xXejRiQlQreFNhSkp6aFMyUG5rWCsxTStBNURzeVZs?=
 =?utf-8?B?RDl4UThYc3VSNVM1K29vVk1uNjVySkVxbkZ0MG41bHloeEgzWENtVzZndjhH?=
 =?utf-8?B?MVhiL1JVZnhnSUlhWkpVYlUydzNrQnU3SVkzdldSa2x0NzU0K2p3d1U2cm45?=
 =?utf-8?B?bVU4bjA3VmdOSFZpOTRXdW5vNm5maWdzaHhyTE9DbFFzTTArWklmQk91ck1m?=
 =?utf-8?B?N29hblBJcWtVSGhyWVYxY1B5RWJtbm5BVGJmU0JtRU5nUDhoTUlhT1k2K1JK?=
 =?utf-8?B?dzdKK0NVaEdMVDVHL0d3dHpWb2xiN1drem5wVFRzOFVwVnNEUjkwelpOd0xF?=
 =?utf-8?B?SFg2U1ZMaW1xVTlpQ3IyRWZvQWRzRFYvN1NFK0R5YmtPT0FVSU9HVVpka3Zh?=
 =?utf-8?B?V2xCcEFUVURhaEF2SlpHTXV4eXkzaHpveGNTS3lIbCtsRGNOUGZxQ3NmVEt3?=
 =?utf-8?B?RjM2QllUOWxQMUhNYjBqTVhLbmVhSHVGWVlIeS9aTFBmQTFwVDFNRmJmTG8z?=
 =?utf-8?B?cWtHa2syYnByR3QyN01PV0dIQ3RvcTdjc1pmVU0yZDg5YWJ4SjJDeDlXNHVT?=
 =?utf-8?B?c1NJMldsNTNiZHJwcklMam1taUJFSkxVUGRFYUZTVk1takp2UG9KbmZRaDY4?=
 =?utf-8?B?L0xwRmhTS3Z5ekM2bUQwampDUDdwSkFNU0pkdVZ3WEtDNmd2WFBCQWFaa1JV?=
 =?utf-8?B?NzJGZmZMUVhWdWJOQkpKakZCQmhlREZVK1lDTjk3cEFpQlNqZFhlWVhUZU9y?=
 =?utf-8?B?Zzg3aHBXTlRYeXNBWDVURjduQzljQU5HcElCTDRWUUZwditzK2RIREpuOVhZ?=
 =?utf-8?B?bDFhdXJTQVhUaXk0bUxYSitrTmdHbTVteElqUUtpSEVPT1dBTmhyMDJNYjU5?=
 =?utf-8?B?TGw5eEIyWDdHSHltMjZ5Mk9pTFhpdW82NzNVOHpkVG95WnljbEpCRlZudjdV?=
 =?utf-8?B?UXQ1VDQyOWQ4ZUJxWG5qZDhkNEFUdUJCREhXR2FuS3YzZFFlSXBYU1NQMVFo?=
 =?utf-8?B?dGx0c0RzcmNrRW1hUEd5TUd5ZFFyMzdyZkVjWUVVVWZZRDNXMjc1VC9ZL21h?=
 =?utf-8?B?MVJHM09ENjJPcXBYd01HTGFZZFBnZUxqVm1EWDNaUmxZdW1lN1ByZnJxdlZu?=
 =?utf-8?B?cDBpOG1UdFpsZnU0OXNTZTZqWlovZ05MYkpXWVZZblg3Y3BleTY4QVRqQ2ow?=
 =?utf-8?B?QnNBRS9sU3hTdVR5ODRDQ2NaZVhBUVlKTkcyVG93UnhHMzVDNFNpbHU4NG45?=
 =?utf-8?B?UXVZVnREblVzTGhWcEFVcWY3QVB0QVBJd1NyZzg3ZXRSTFRKYmpseVNhOVRp?=
 =?utf-8?B?bkc0S3VLeTFYdks3a2xuZVZpa3c4R3NnVWQrQzRrR2dtYXI1empjQ3FBblA1?=
 =?utf-8?B?VTZqeHIydDU4ekxtV1I2dU9FM0RCZUhuSEhxNFJrWkFKeTdqYmQzVmRxbE5E?=
 =?utf-8?B?cDIyOUV0b0RMcmpod0xmSEdZLyswTERsTk5oSmx1NlphMTMxbTI0bHZWc2VG?=
 =?utf-8?B?ZE1rQVN0N0ZZMnEyRkhsemdJazNLR0NMYmxsR1JEU212OXFhM005M0xHTFBr?=
 =?utf-8?B?SXBtMyszRWZoQXFWNXNCc1NnVGNiRzB0Rk1XQW9KSEEvQ1JuaWNrT3lXdG5k?=
 =?utf-8?B?ZXFnclM1cG1VR0hFU2V2eHdlQVpGNWgrc2FBRmhlVlJieEFCWko5cXlYSWU1?=
 =?utf-8?B?czluMWdnYW5qMEpUcXlQOUthSldZeEFHald2MEM3WFVRcFpWbm1VajVIVGI2?=
 =?utf-8?Q?F+t/BnBBBZft3ioancNvRvapE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e0ab19-fa1d-4a92-0afe-08dde6ceb8f0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:36:09.9857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0OEeflrsvv+SNcz9vMi9tgQ8hjTTKdNdIg+/tnGCccFJ0zVfKog/PBnMUFlJuN53Q97kAlTiVfVscwEsMI/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> Now that all infrastructures of supporting passthrough device running
> with stage-1 translation are there, enable it now.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f9cb13e945..04a412d460 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5222,6 +5222,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                      "when x-flts=on");
>           return false;
>       }
> +
> +    return true;
>   #endif

just to echo if this series does not support non-rid_pasid PASIDs, then
factor out the configuration that has both x-flts=on and x-pasid-mode=on.

>   
>       error_setg(errp, "host IOMMU is incompatible with stage-1 translation");

This patch itself looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

