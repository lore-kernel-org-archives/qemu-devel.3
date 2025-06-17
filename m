Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4084C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 10:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRTvf-0001vU-8U; Tue, 17 Jun 2025 06:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRTvc-0001u3-Dk
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:52:32 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRTvV-0007Xx-IH
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750157546; x=1781693546;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0MDxrB0n2pVK5646KiIJYtFMxVXrk6fQVFjPTVK5Cgg=;
 b=KECMofowwveKfwBZ2L6POlnY9KSxZ0H7gVpZt4/OQyQ1CJRb3sIRefub
 ekneRawS+lhNDNEXZs5725xxjo4ZXChoruZ9vMMGHIx3HOpqXqcmlsEsb
 tA220W45boeGizHmRb1wdYuESXX/2HCvMQfNsl+yE/J82PXmeBlPZiuWi
 R6OOu5KDmx5IG3XPS2QteheuX89Px/M5pn47OzcuFYl7zQa6ZD7ZGOmQm
 PHJdZPr8ilWvtSTM0yx/ktjJeBV/CziaIa+ZeZnXmfnyygskFFFGOTn9Z
 dVpMg2U+P9wPpb7KgSnE9OkK1LpIdIISNjTXqb7jQZ65IWprGrG8V27oo A==;
X-CSE-ConnectionGUID: kB+bfxWwS/6LlEFbENtpww==
X-CSE-MsgGUID: 2z/ooXa0SN6i/uC4yip78A==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63683667"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="63683667"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:52:22 -0700
X-CSE-ConnectionGUID: hepZCxXtSwef10hxDrwelA==
X-CSE-MsgGUID: BR2kObFBQWmVkTDWZGx5pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="148656922"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:52:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:52:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 03:52:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvpDPThG7cgGmgwIyQupLJKnyt9LconXsWSDRf3n1M5KMJQxAEzJgvdQpe8nhkg5YMV9m58D6BhzEve2BGYflCnRnFcfzVOnbrpD4emWiRKoU2FYhinYnaUNiya+XmbU/StYCW1DVAw5xRHy8rAPsPubZZwGh96Twrdnv0uevBKngj6g/uCZeLlahU+0ANYafGUHv6/5BqA7USJjTbNXgC809Sjf5BE+dBiXZuCPpLseolWYTylD7pYk868zcKMVnfWqGalJchK184QI7h4uEnMEJuBS2Qf9ffnxHPWyTMJ6ZHxB4Fv2fir5KDhBEsplNfFNCg0Hqf5mprr9O26aCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CPd/m6WaGkbZY2Ukk0IuVvoaZFmmX3LqH+QQLyTGGU=;
 b=FRDBXPmYjlGTBgvziiaWpQSx/vd5EvX9fArhvM7RLf3mWWoilz7r/wCypwLeK/5++zyIkQ7K8VsSvxWUsofJ4JVDDx88TwPyrg31i5r/Z4zynM/KjfgtIdiVBK7Emd/+BJcDYjMEx1Fp6FKCw3gxyxuvL1wQFYr6COWnqIK22tSD0g9rA8WP57FUZ3dvTgLBJoffYA0xZ+4T7DoMC6cTDS8Sfg0gOpgXemd5f4RDmN4175w5ZHmhM7peqq80lqPasN1A3x3tT/tXy7FjZ5+jNNA5IPUWDtG9tjFNtft9tEA4ZcUSV60d2ekqE5wuqlpRAe/sVWFx3OyUB+XMuD2OpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 10:52:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 10:52:17 +0000
Message-ID: <7006a5fd-f8c3-4d4c-9b3f-78b3e4ed1051@intel.com>
Date: Tue, 17 Jun 2025 18:58:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-6-zhenzhong.duan@intel.com>
 <6bbc4632-1234-4f6f-a621-d5f8a1a27bcd@intel.com>
 <IA3PR11MB9136DF86BA8E60C52336F7819275A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136DF86BA8E60C52336F7819275A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: b1713516-467c-46f7-5863-08ddad8d06a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmRGU01vaFRVaml2Unh3b1pFQW5HOU5wSlBqOUp6RmM1NCthS0NMa1ZvbG01?=
 =?utf-8?B?MHB5Y1dOYTJGZVdaSzAzb3NacE11SHhNNzVJQ1Nsa3l4L2t5c1ZuemFXY2NH?=
 =?utf-8?B?ZTNPamM0MFllcHJwVGtCekxoVDI3Q2FPNkdNOUk5WDFLaHN1S3ZhRE5uVUZL?=
 =?utf-8?B?NHZHZGV5S1dUQ2hPRVNFcDl1K09YN1E2c3dJN2VWRlNKVWJmVXBMNHlveSt5?=
 =?utf-8?B?TUFSc1BYaUdZeEx5OWVqN05YQnlsQ2RnQTdCZUxnK3czZXRUalpOc0hMUFFm?=
 =?utf-8?B?SW5pYTJJUDdRa0l4RlFHODg5ajFvUUtIbUFHSjVhTjJsUXFUc3FWOHh4M2Vy?=
 =?utf-8?B?STFBbEpSUEVUeFVzdUtNOWJnekpvQWhSSU9saHRNYzRJVmxIUVBEeG5sL1cx?=
 =?utf-8?B?bWJEVC9LVXpqMlRHdDd0QlRYY0N1S3U0eXNlWmRmVGRlN0R0NVZuWHBoTE8v?=
 =?utf-8?B?TkxJcDE3Vk1yVVFqL1BTb1pxWVlUbTFyNk1LY3JObXRvRGZobWFTbGFyRVor?=
 =?utf-8?B?VDYzV1BwcmtYMlRTeURTUGxVbUFSNVRNTDkzV0swZGF1Mk1rOXY5cnFFT3ZQ?=
 =?utf-8?B?b2NLVEtHK3g1amxkZnlRT1lxalZFOUpURElsTlgySCtMeExIZExPNDFWOFgy?=
 =?utf-8?B?bzdZZlBlMGNyVHVETllnSTZjRzhKSjl0aUEyT0cyNjBIS1d3LytXZmozQXoz?=
 =?utf-8?B?dGNta2NCUTVxSEVWMVJQZklNTlVXeDJ3Rk8zM2QrVU5mZVFiTFdHN3N5ZXJp?=
 =?utf-8?B?WjF2blc1RTRiWmVabGJZejZFRTV6aGtlTEVJWGNEUXpMQ1daSnBDNkY5a0I5?=
 =?utf-8?B?N3Vwb3NZNzV6ZUcyVFV5S2lRVzlDK0c1OVEzZnRJelFpUDdiY3NWSS93Uk1Q?=
 =?utf-8?B?M3h0Z2hJUHJMUDRLNElSRlpDTmxGbEdqRTR1T1BMZDN0SDMzWGxJUHZRYzZX?=
 =?utf-8?B?K09KdXZDOHZKOXJPN1lxMk44ZzRLSWQ0bjQwNDVvai80MExhcmVsYjVCOGti?=
 =?utf-8?B?ZkR0ZysxUm9vc2RBejJKVEZCMFlOVVBoUVkvM1dPbDNhL1pmRGhBVmZiNXd2?=
 =?utf-8?B?RjJ3V3BhOWxqRnpORENheXlxMldkbmJsbnlzcnNGblpvQXYvMk9qWFZWRGRo?=
 =?utf-8?B?eDlzaXp5cDVmTDd3UlNDTlRxUkVJOVBIOHJZalA5Y0c3WFB0SUFXLzhZTmNq?=
 =?utf-8?B?bjNWTmRiNithTkdPYWZWcUtjODYrNzdLczNERjF2WTNmemZUVHFXRGpPdzV3?=
 =?utf-8?B?QjlQVkpxMUVaWkxRbm90VmpYemRxU201NUZGVDhFTUZIS29qL0VKQ0VPUUMz?=
 =?utf-8?B?MS9Rbmt0MnQ3NGpLZTFCVDNTNG5ZbHl2NUJoRVgvMXhLbkFEUGJOdHluUVE2?=
 =?utf-8?B?Tkt1eExCTytMWVhrRUlKWVlZRWVOSnRZSzVzVXpodURudnczMnBMbS9ES3kw?=
 =?utf-8?B?akV3c2c2bTlNKy9Wb0pQcWJxNEJlQXlTZnRyUUgrUGdHYkk4dElKRlp2Q2li?=
 =?utf-8?B?cHVUMWRuUklHRnZndHJ3L1o3VlFTenc1NnpCOU5Od0huaWNrYjN2elJBUnA2?=
 =?utf-8?B?S0JWM0YvZzZMbVJqSTVtTERBWThGbTJNR0pYNCs0M0k1S1ZrbVgwRzV2U3hp?=
 =?utf-8?B?THdaY0d1TjhjK0hZL3p4Z3ZMek9wZmtsQStSVFM0bjdHbWNXVFhKakgwaS9O?=
 =?utf-8?B?QkpkcElSUHBhdGxyOGtoWHZXdmU4amFDSldGdVRnb0JIYXBtYmFBK0wycmVt?=
 =?utf-8?B?bFJFWW0zQk50U3kwckg3Mk4xd0kwYlFRQUVPbVlmdnVKc0Y3dzM3czNGMnc1?=
 =?utf-8?B?NXJ5SzhUUkdlVVA2OGVJTVZ5eFFKSFM4RkMza3FGT1BBQk5LMGY5amRSZVB3?=
 =?utf-8?B?WkZGRWdHZk5wTXY4YW5VQURDWGdONFVVVGV1NmwxeUg4TDA0dnlRbmdmSEZ3?=
 =?utf-8?Q?/Aw6sc65s4E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5EOWpVb0ZDUFQzTWlSaW5TUG52andDWnBpeUExZ2ZMbWJDWHZKN3gwVThO?=
 =?utf-8?B?TTFwUUw3dmlRQXkza2wrSjhTSDNvVU96azZWZWhnSnlTb0FsSkxvRHZvWUFD?=
 =?utf-8?B?YTNLMzhlb1dOK05VSWtpb0ZQdU1JMVM4OFNxaldZbUp4dG1vZE5oS0ppcTE2?=
 =?utf-8?B?S09kMThlOXhGRnZlSExsWGZkT2FtUjZ2dDYrWUZReUV0M1FHRkpZaWVzTHpm?=
 =?utf-8?B?TnV6QlMzcXJhdHloTWowRDNYM3A1WUhuaUxVZnZ0bGRHTXdvclN1TnBMRCt4?=
 =?utf-8?B?U2plU2FPNDFkckp1dnJ5ZjBIT1FQRnp2d21DZFlZaXNXTHRTVk9SbW9NN01m?=
 =?utf-8?B?d1hmWFBhU013WW5LVDVKYkNvZEJicXlQSTRvRWtxajZNTkNMVVQ5Y25CcFAz?=
 =?utf-8?B?WnFqcFNrU25teXF5L2V2MEdmUFJlcEpUUXpsWi9ST2d3blFjZHJtWDl0V0xQ?=
 =?utf-8?B?T0owNy9XZEc0eHg4R0swZUs4dWk5ZHlNRXpuZVFVbkpXTU9jNlhjOG5kdHRE?=
 =?utf-8?B?OTRwTVRMdkQ0QlZES3F6cHpHejNHNzlMNnEvVStjVktlYkNaZktxenhhb2sy?=
 =?utf-8?B?dGhZaHBBNytoNlllaHFIZTZnODhzRDdLWTM4RWZ5REdKQ2lGK0c1enltYzdC?=
 =?utf-8?B?RE9rc0k5QjM4S3R1OVVXUDc0RU45UUVyOGhZTGxsN0ZwajU4TlBrUFI1VFFC?=
 =?utf-8?B?OWlGN3dqZnNEeVBUajRseVpTczA0dXMxeDNUMXhEVjMxd3JzVjFrWXU3dVhD?=
 =?utf-8?B?OTFwYThpa2VNdXVScWsyaTFyM0hYa1E2QlNjWlI3RmlKTFZwaGdGQ253SzZZ?=
 =?utf-8?B?OUZlQXNiajBQMElVTG04WWlweEdSWTltV0hvUWo4TzZvUEtsK0lZMG1OMlVh?=
 =?utf-8?B?SlNjMmZDcWZ0RWRndGFveEc3Z2JuOVhZaERiTnNSTnZCSUVRYWwwQk5DbFMr?=
 =?utf-8?B?enhxb3BxY21IYURCMWNiUExOV0F4QUxSd28zd0ozeGZDM1F4cVJmbC9yb2xO?=
 =?utf-8?B?UG9xLzRMbGM5bHk0cXZOYjQzQjh3bURncnNvSlF6YmxCRTBQK1VOSmp1WUVB?=
 =?utf-8?B?SlJzQy8yNTBIU05DMzNTaGczNlpTUGRCM1pmTm1YdkZSci9IdVZBbzI1Vmtt?=
 =?utf-8?B?a282YVRya2puWWFWbHlqbTY4Y0FuNDlyWXAvQXFiczhhK0Vrd2hHQlg4S0F1?=
 =?utf-8?B?RWg4MHlleXRFWDFWb3MyOENlSzRERFkxdWVNRGIvOUQxem03N3lqRTZYblNP?=
 =?utf-8?B?SUp3MkxZaVhVTDFPbjFYQ2NpM0RBWnEzNjRwelpPWS9XQlI1Tk9COFNQNWFT?=
 =?utf-8?B?aDdUTlVUMFJFRyt5enlYY3B0RnB5aUovSlpHdlgxNmlHbjNETmxKUHJkMVdz?=
 =?utf-8?B?VTBpWWFRN1ZNZnFNY08vclRhZ3V1UWxDQ3MrMnZTTHJSV04xWmRsZWtpR0VE?=
 =?utf-8?B?Wm40MUFBN2dBWFNnbjJMYzJ1KzZvZXUxbGM0VnpvT2FjMXh2eEs3SUJ4MTJ2?=
 =?utf-8?B?YVIvZSs3R0dNMXc0L1FrczNScW43QzU1Nm4rc1QrUjFCd1Y3elFZZlRGa0Fs?=
 =?utf-8?B?MDg2ZVpHWDd4WjhOeVhxSStNaUdPdjVRb1ljUGlaOHhPS25EdUJiVFdZQjEv?=
 =?utf-8?B?TDZDRkZHRW1zTXA1dnJ6OTlJU1VqTWVpTGlKK2s2aFROVnNpQndTTldPbmxQ?=
 =?utf-8?B?SUdKbFV2S0xhOWxGSW42UmVib3gvK3Mza0Noak1FV00zTEZtTVFIN0N3TFg0?=
 =?utf-8?B?OFNGeXRzSXltNTRtVlJGOG9oTnplZG81cmJKYXlRMUhIRGxrQU4xcWYrQ2Qr?=
 =?utf-8?B?QXVIT1FMcE5vSUd0TkJMUE5ITmtDVmhhWGdaRlAvdkhDSlFEcXVyRkxJRUM3?=
 =?utf-8?B?RUZpM3FRYzFGejhRdGJuWk1xTTZINlpIcGc2Uk5wTHRwMzZTbUVNVjJYQVBr?=
 =?utf-8?B?RGU3ZWUrbkpnbTZuaVA4ak9UUHV6THBYdzU4RWhWN21yeUx1NkltNGFnbXpi?=
 =?utf-8?B?eDY2TXR2a1RRVXc2ZmxNU1RGVHdtbXhmVkVxVU9Ld3pGTGV3VWdORThaajQz?=
 =?utf-8?B?Tk5POExRVVcrbGViM1NuZE0ydHJNVHFXcFpCL2I0MDd4SmJMNVJOOU1EaG5n?=
 =?utf-8?Q?R6rOUc1ua0+oLacWeYqbiyrat?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1713516-467c-46f7-5863-08ddad8d06a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 10:52:17.1206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMucG0TvDZON96MLvGB9VrtiWZW0PqWES9+j7Xq5PME2D8OjN4PX4xm5HgJ++1XawGACG8q5PIaRxSF+27mJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On 2025/6/11 18:46, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v1 05/15] intel_iommu: Introduce two helpers
>> vtd_as_from/to_iommu_pasid_locked
>>
>> On 2025/6/6 18:04, Zhenzhong Duan wrote:
>>> We already have vtd_find_add_as() to find an AS from BDF+pasid, but this
>>> pasid is passed from PCI subsystem. PCI device supports two request types,
>>> Requests-without-PASID and Requests-with-PASID. Requests-without-PASID
>>> doesn't include a PASID TLP prefix, IOMMU fetches rid_pasid from context
>>> entry and use it as IOMMU's pasid to index pasid table.
>>
>> When reading the first line, it makes me thinking why need the helpers
>> since there is already a helper to find. The key is the later part. We need
>> to translate the PCI_NO_PASID to ridpasid.
> 
> OK, presume you want me to delete first line.
> Let me know if you mean not.
> 

yes. :)

Regards,
Yi Liu

