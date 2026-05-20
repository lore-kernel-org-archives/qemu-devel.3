Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC83CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPcbO-00082K-87; Wed, 20 May 2026 04:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wPcb5-00081T-Tc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:48:17 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wPcb1-0007pw-IM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779266887; x=1810802887;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WPAe4sipFRH0NMyFKBBqv9Qz5Z3C2ixk1oPi5q+J5+U=;
 b=et417c7UHiOdNHl3ElquA8A1HGxr7k9ro00/bEbaRwdn3JRhxCbPVy2h
 Iv9NQo7/UZBnWejyAWeQsDLlt4mi3MeUqfPailU6z/LfJPdGhwqC3dJ8W
 bmI4cavTCwtK4vHjEIoGimUCTRVc/5Fwb0iX86r+cc3V+YZUX5N0TNywW
 rxM+qumzLtZ3tD7EYws1yxLxguM0HWfSaylfQ/JCzh1FHgLm3zX0EywF/
 wvzDR+QwHh6ugq3B1tgk1rZ7WljkxoeaGn7hCPWXLqSHKqnF5G+eYmhTz
 1huCbLQkhghfqlni5yhh4nFJFYXdUFH/qzH1e+T5GorTCjubGEj5fJLhC g==;
X-CSE-ConnectionGUID: kmQx4OKaTOOUgZqODawSRw==
X-CSE-MsgGUID: XI8DEDbvT0GJV5ufw06RMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="105616971"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="105616971"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 01:48:02 -0700
X-CSE-ConnectionGUID: uHruN/VeQzOIRH3hWUUgqA==
X-CSE-MsgGUID: t4/WANQSS1u94UMjDolJkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="239089153"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 01:48:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:48:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 01:48:02 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzfRO+RNElUT90TsXXmlDfHpBtSt6JOhjldTRss9/xNtAtZQ5I+EIqvYvteRWGAvc6O+Kj8SBjhtHD4heKydxwSdjEQ6ShyEQxRL5K6l2lSq7PZIFzE4C3u9HHEerkxfpswxRTYJGfykQp538Njby/DBKAtZGUdUyywunJ+rQM77UVXTMLo0JI3rbJgttrIAT59Zvl5Rlban4Mq1vJALSxcyVCFz5V/P/uNlCsA7pLZIFo/mkxOLkAVn8f3v16KYevkVPjzrJAJfxgCl8iNAl8yXRKlnKzxfRxm8AFiG9nRXhWpo/1P+iJE1Hgg8QxjI3sPXF1f0urZ2BaMnubeGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSWNXVHaHcdO6H+exTjzjROc0lgwaB1lKU9guOeK1Nw=;
 b=dPvjEgDKmY6frQ+MyLoyLvHN7ioF4kqPhEplfcXKUvbHirudkhYGFXE0OF1FSB8hPYcmSBdKB6LyhQJWW+YmT1QoJQ5Ha5yHEaltm/8Nj+5Z+v8l47qLqCIiczvTGR6Hazq4FGhEKJ2v7gwDDTuv/dPadG1QRm8RGdULoS1ZA3p3aIEvrj/sW4U/lBoQTuS65DfUFz3TCWjyoCK8QSv4QfMfeGVUB03iaH1Q6KAt23a6Bd/fwDj6QHCrkgnu1Xzrz5xvYJrahw54K4bDfFNcjNqUXlFlTpilhXjkx0DYvrH/KxLdxyKlcwlhvbS/OOZbt0gDfj8JLmubxQs15BaXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 08:47:59 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 08:47:58 +0000
Message-ID: <053b39b1-c522-491d-a36f-aa105485f916@intel.com>
Date: Wed, 20 May 2026 16:56:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-9-zhenzhong.duan@intel.com>
 <eb419b7c-8fe9-421c-b0b9-d2dd5993e6d1@intel.com>
 <IA3PR11MB9136FA1C2BD60E9A028FC71692002@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136FA1C2BD60E9A028FC71692002@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CY8PR11MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d25ae1c-66ee-43e7-b52f-08deb64c7e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|1800799024|366016|4143699003|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Lmx0gldO+CYJFAIL0DALpf7wgekmnsZ4HXfD4nhJEnGy9BSCmkQ+4CyZJgBkeiwVyGTxcUyg76cweS4Iq2KqVFKl//29uPJZqlcacWiAAkF2vGmohMoDEmQW9dDynR+bq74smOyamSe9EJLHuAb362XGEAyfrtFeAh6yqcBkVfgh/bAE7ECmlMOcGcW2lcbHMbiLbHEgq0KV4loqnA3NfOpHM6UAF5p6vB1z1bgh3aQxln9QxJFXYlK9uHyHeK1rAb7XV0ahjmgdxTHfJ3Z0/so5Fvc6puRWDfs0zjuK5OSfzKcGUdq96JWuYAmHJaR2tHMBpc4PH7mYCkSzeaKW2AnuVfQmJkjR/CvprkayP41Bugja8ymteLcXCIUvWxmxqUCiUyMaitRO9rs871jp+x+acv4S5wtSkkWBpFnSgE/+Zh4/WZPO8K3go+88aS9QeP7ys7JK89ILoLMKRgZCXmANAzNxB1zeGHBpvOarEY8y29j4lF1xh+D5jRQO+Sbj+UsjKRRfi3sTQehgud3F1kAtuiJ+VxnYoIx3cOe7ExcbpniN4YoS5qNkbaDHM/FuquLZn3HsaYxnQOIQy3YINkuqmCrIo1LKFuz79YUEB0G0l35QkSJhZ3YKHmfZAEgNAultEbaFh5wexT3TeEgA6OK/U+0sNESSth8UXiWlHlyH354EBwy/Zuz7WN9voPlc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(1800799024)(366016)(4143699003)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWk5NmRTcGdwejZ1aDNWdnMwWUw3ZFcwWG5taENjRjVKamt6T3ZlRWRud2JK?=
 =?utf-8?B?UWZNQWJvVDJxL0cvc3RMdjNsOEhZNzlJbkRyMTdIemk2Q21QMFV4TTFEdE8z?=
 =?utf-8?B?cWlkNDBPNjc5VXZaM05xbTVUbm9hb3R0YnA0L1k4WVhCRW5hZ2ZoYy81RW9p?=
 =?utf-8?B?NkVkSnpyNGFoOWFVZnVvUHgyK2JTUjVwdHZ3cGhVd3FIdjg0a2ptNnRIL1Jo?=
 =?utf-8?B?MDliSW54U3FQRlBGNVhxYzQzYmVQQll1cnlVeTJWdC8wbXRWOEJaOXpKTFJt?=
 =?utf-8?B?MXVyWmJ2VFdtYTI4dlhWSytwT3BwcXZtUzBSeGovR040RnVEWjdhTXVBYTAw?=
 =?utf-8?B?QVI1UVJ1RGpxNmN3N29PNTlHSDVZTTlBazE3WjIxUEdJUHVyM3RHVE1jNVhC?=
 =?utf-8?B?TTVJenUzeEVlbnYxV1NQK2tiVWdYZ3pMaVA0TTBaczcxVjdvOGNBUzQvaUtQ?=
 =?utf-8?B?SXBrUkttdGV5bEE3Rm9mRjg0WUV1MHpubzFCK1pWZDJxeUkwL2xyZTRlS1pY?=
 =?utf-8?B?Qm04aUg4RUlBWG83YlNUcmRQbEp0OHJMUGh6d2U4S1lhbDNjYzdtSDdBTjVr?=
 =?utf-8?B?OGZXb3FNNlRwQVVNdWlKcFgwSTZzUGFMVXdieExXZk5rVjVWUGdaOEZLK0Vo?=
 =?utf-8?B?S2ZtaG5YUXFnUytDWUFSMldRUW5Rb1JacHc2RWdRRTRHamh5ZmtKWGRtTitF?=
 =?utf-8?B?ZVBlTlZybnpINzZSdUpUTEFhOHRObmxkMkFsVEo4NWt0bFBRZm0za1RIWUVY?=
 =?utf-8?B?YU84RXN4ZXFlNWlFaHpOUEhBZ1ZpZHhRTExhMTNJbS9BRS82TWpLSWpHeGhV?=
 =?utf-8?B?NjZ4TFZlUGU5NDBPNStoWkZxMndMYUlCb216KzFZaE81T1RlRGFxcjNNRFZJ?=
 =?utf-8?B?VzZ3aWwveGoyOVczTy95Wi9vc0NNTXBzT295SVVNWlFZVHBUVlFFTk44RzR4?=
 =?utf-8?B?Y1pRWUxzaFc0aTUvWS9ES1dSTzBVOE9CeVdWb3I2MXZUQW8wZVNUZnBpSUJm?=
 =?utf-8?B?VlcwWC9HSjNvQi80RjdhZW9hb1kxUU9UazBoZGJqYjV2SlFtbXVJZytLcTlI?=
 =?utf-8?B?RWNXNmVUeHQ5UnVNMndqWFFMWEsyTGdQQXJuRzZvT2xNWXdINzNPcjJPN2sx?=
 =?utf-8?B?QUhrY1J4QzJSOUNYd1V2UDB5cndvSXpnVCtHbzRZK3BmVFpNV3p4RWZydnpq?=
 =?utf-8?B?bHB3RlFJc1FXenY0YmhuMk9oSTluRW1Nb01TUkQxdHgydURqRkw0aU1JblZF?=
 =?utf-8?B?YjFSdXg2Qi8zWDlXQzdDdkpXT3pwY2ZCL3ZGbUVuV2FyZzU0dldISkh6cEp6?=
 =?utf-8?B?M1VlOWJKU1ZERTZlQkZGRzRjNlQ4OEhRSjdPSDZ1SEp1cTBRN3pvVU5ObXc0?=
 =?utf-8?B?WVBCYUFINnR3U3ZqZ0dzTVFBVXlhcE1JbGhQRFc1bnRQS3dWd1N0MFBVVjc0?=
 =?utf-8?B?VkZYZ2lTL3RNcU1LYjYzSWVXam1VM2RBbFB2dU1Vc1haRTVYdGcyTmlTOUxU?=
 =?utf-8?B?ZXB0QmRGRzhMQzN4SmhiaVo4MWNxakdlSURxUlBJVldmeVB5b1o2eHlyQjFE?=
 =?utf-8?B?MFZEZHcxMndjT3lacEZBME1JUVErbS9nV2MwLy9ieXQyKzRLUzlkMVNaM1k0?=
 =?utf-8?B?ajhRb01tNlAvMDlVb0dkaFZlK0JLOW81WVVETnNRZXNRRDRLYTl3SHhtV3J3?=
 =?utf-8?B?KzMyMUs0Q1dTKzV3VkFSZWt6azhtOHlnOHE3US92SndnQS9Jb0VlUU9vWmtO?=
 =?utf-8?B?ZC8zeC9xWVpPZCt2cCt3S3ZXKzBLL0tLZzNmSjRxYlFWbmY4cFVxdFpMWlJN?=
 =?utf-8?B?VHdvR0trMm1jam91bWxqc2xUMEFQaDdjaWVVSVVGZjc2RHRXOGIrbDBzdms1?=
 =?utf-8?B?TzNxTnhuUkI3aDJaTCtRS0cxUitmbEN3Q3ljbVB2UUN6Q2Y0QVJZNzRwcXlD?=
 =?utf-8?B?VElKeTVNV1pzRTdJWTFkb1J3Yk5sZnY5UTFtS29IZkdmK1dNVENHOEZCRUZ4?=
 =?utf-8?B?bzBxbnJzamt6aUVuOFZzT0NHQ21ha2FRTHZYRk9aRFF1MHUyVXNiSTMza3Fz?=
 =?utf-8?B?ZmFucjdEUDN4VjhhTjVQSy91Z3lucGdLbm1TdmxFdkYzN25mL3B6ZlFkZlFO?=
 =?utf-8?B?bjhpbkxVMVQ0MWExV21ScDA1UFpGSVlhckFpSTRoYVFsbEtNMEVBNVd5UGNt?=
 =?utf-8?B?UGI2MU91eFc4OGVWY3pSZDBYcng1SVZ6VGMwbFVFdkNSVXlHOTBNL09GZFlB?=
 =?utf-8?B?WHdHQzNneCtac01HVVI2czRyRFBrTTVCNER5Ky9lZGdieGZ5Y3Q4b2tUaUxq?=
 =?utf-8?B?VGR4NHR2K1ZQazhxUmxOWXFqSzc4YzdJbFJjMmdTUytIT1ZiNGJSUT09?=
X-Exchange-RoutingPolicyChecked: bD+eTaG5I3CG6vNUcGXL7aI0W+ZheCk0Hac8U+O7wN9C0NlKfYleSs+Ppj5nN5jgEpN7r4TMmwRowAAZT9a51Oq46q1Ze/e4/E5vq53EErR7xlkHJ3fGRegokFPCZReVCvGNIHIP7ys9qtCOeFtenMTWGkTg+/VeyE1L68bx+1x9rJEV5otRVYBF/+VV6C86QaphNBx7606lgbF/dlizvHcIvxHCso8t/1p6XO3BTBcnxPH/x6zCqIywEYcbzXJPR0Wft+KLtPs2zoS/TuWpfN3RkALd+8gch4oVy6qMjun+TUJNivbF3fRLN1gSCS+x66OtPAcH845rRU3LY1umYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d25ae1c-66ee-43e7-b52f-08deb64c7e26
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:47:58.7107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6PQ5dbr0iZkK7Qmrsax9g6sqNvCKPJ8FlAZwLcU7iV9YQ/YbSEdZRYvuOW91M+YxqaBoUfplJjVzZsNEr+WSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5/19/26 15:20, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
>> IOMMU_NO_PASID internally
>>
>> On 5/9/26 12:08, Zhenzhong Duan wrote:
>>> The PCI subsystem uses PCI_NO_PASID for requests-without-PASID, but VT-d
>>> uses IOMMU_NO_PASID internally. This leads to conversion and checking code
>>
>> s/VT-d uses IOMMU_NO_PASID internally/VT-d emulation uses
>> IOMMU_NO_PASID
>> internally (ecap.RPS==0)/
> 
> Will do.
> 
>>
>>> between PCI_NO_PASID and IOMMU_NO_PASID throughout the
>> implementation.
>>>
>>> Refactor to use IOMMU PASID consistently within Intel IOMMU by storing
>>> IOMMU PASID value in vtd_as->pasid. After this change, PCI_NO_PASID is
>>> only used at three boundary points:
>>
>> a typo or the third boundary is missed?
> 
> Section 2 contains two points:
> 
> 1. Convert when notifying UNMAP events via memory_region_notify_iommu()
> 2. Convert when returning IOMMUTLBEntry in vtd_iommu_translate()

got it.

>>
>>>
>>> 1. PCI_NO_PASID -> IOMMU_NO_PASID: Convert PCI PASID to IOMMU PASID in
>>>      vtd_find_add_as() and cache in vtd_as->pasid.
>>> 2. IOMMU_NO_PASID -> PCI_NO_PASID: Convert when notifying UNMAP events
>>>      via memory_region_notify_iommu() and returning IOMMUTLBEntry in
>>>      vtd_iommu_translate().
>>>
>>> This eliminates conversion/checks in PASID table lookups, simplifies
>>> invalidation logic with consistent PASID values, and improves code
>>> readability. The PCI subsystem interface remains unchanged to maintain
>>> compatibility with other IOMMU implementations that may not use PASID 0
>>> for requests-without-PASID.
>>>
>>> Suggested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/system/memory.h     |   2 +-
>>>    hw/i386/intel_iommu.c       | 164 +++++++++++++++++-------------------
>>>    hw/i386/intel_iommu_accel.c |   2 +-
>>>    3 files changed, 80 insertions(+), 88 deletions(-)
>>>
>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>> index 1417132f6d..1edb38b07d 100644
>>> --- a/include/system/memory.h
>>> +++ b/include/system/memory.h
>>> @@ -150,7 +150,7 @@ struct IOMMUTLBEntry {
>>>        hwaddr           translated_addr;
>>>        hwaddr           addr_mask;  /* 0xfff = 4k translation */
>>>        IOMMUAccessFlags perm;
>>> -    uint32_t         pasid;
>>> +    uint32_t         pasid; /* PCI pasid */
>>>    };
>>>
>>>    /*
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 5e5dcdc274..b50c556c40 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -938,12 +938,8 @@ static int
>> vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>>>    int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
>>>                               VTDPASIDEntry *pe, uint32_t pasid)
>>>    {
>>> -    dma_addr_t pasid_dir_base;
>>> +    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>>>
>>> -    if (pasid == PCI_NO_PASID) {
>>> -        pasid = IOMMU_NO_PASID;
>>> -    }
>>> -    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>>>        return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
>>>    }
>>>
>>> @@ -953,15 +949,10 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>>>                                    uint32_t pasid)
>>>    {
>>>        int ret;
>>> -    dma_addr_t pasid_dir_base;
>>> +    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>>>        VTDPASIDDirEntry pdire;
>>>        VTDPASIDEntry pe;
>>>
>>> -    if (pasid == PCI_NO_PASID) {
>>> -        pasid = IOMMU_NO_PASID;
>>> -    }
>>> -    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>>> -
>>>        /*
>>>         * No present bit check since fpd is meaningful even
>>>         * if the present bit is clear.
>>> @@ -1750,7 +1741,7 @@ static bool
>> vtd_switch_address_space(VTDAddressSpace *as)
>>>             *
>>>             * Need to disable ir for as with PASID.
>>>             */
>>> -        if (as->pasid != PCI_NO_PASID) {
>>> +        if (as->pasid != IOMMU_NO_PASID) {
>>>                memory_region_set_enabled(&as->iommu_ir, false);
>>>            } else {
>>>                memory_region_set_enabled(&as->iommu_ir, true);
>>> @@ -1780,7 +1771,7 @@ static bool
>> vtd_switch_address_space(VTDAddressSpace *as)
>>>         * We enable per as memory region (iommu_ir_fault) for catching
>>>         * the translation for interrupt range through PASID + PT.
>>>         */
>>> -    if (pt && as->pasid != PCI_NO_PASID) {
>>> +    if (pt && as->pasid != IOMMU_NO_PASID) {
>>>            memory_region_set_enabled(&as->iommu_ir_fault, true);
>>>        } else {
>>>            memory_region_set_enabled(&as->iommu_ir_fault, false);
>>> @@ -1892,7 +1883,7 @@ static VTDAddressSpace
>> *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
>>>
>>>    VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
>>>    {
>>> -    return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
>>> +    return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
>>>    }
>>>
>>>    static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
>>> @@ -2121,10 +2112,6 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>
>>>        vtd_iommu_lock(s);
>>>
>>> -    if (pasid == PCI_NO_PASID && s->root_scalable) {
>>> -        pasid = IOMMU_NO_PASID;
>>> -    }
>>> -
>>>        /* Try to fetch pte from IOTLB */
>>>        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>>>        if (iotlb_entry) {
>>> @@ -2235,7 +2222,7 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>        if (ret_fr) {
>>>            if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>>>                vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>>> -                            addr, is_write, pasid != PCI_NO_PASID, pasid);
>>> +                            addr, is_write, s->root_scalable, pasid);
>>
>> a typo here? s->root_scalable should be "pasid != IOMMU_NO_PASID"?
> 
> This is intentional.
> pasid = vtd_as->pasid = iommu_pasid, so it never equals PCI_NO_PASID now.

not quite get. It can still possibly be IOMMU_NO_PASID, right? If not,
this looks to have introduced functional change, which should not be
expected by this patch.

