Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E51C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sJJ-0005ll-Rg; Tue, 22 Sep 2026 00:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8sJF-0005lY-22
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:40:49 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8sJB-000732-Sj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790052046; x=1821588046;
 h=message-id:date:subject:references:from:to:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IfrARGv2fY9WCCsqZrF3yXdjLXfGWkOkkknIwuVDenk=;
 b=gR2t5BO8/rotVo02KxTEg0SOMsEy15S8ndcKg2q0sUVIFInKgid7my6s
 FrJRV0HXpdzul9Irfg4ZohUbmN3jUENqO3TiN5az3V3i5JfC0XrR+yjG9
 qI6EQl1NgKeJzO9nq48g+WUSBi+E6OEqtCQ1/Dsdk9v5zlhHcGiBcI/n2
 likFx+0S77YvoWIyRr0LiiP4LohX+fbC5u1Bu7M9H5ODAe0SES0ki1w91
 s4T6fe7feKINBk7GuRBcnQRnFsQ5jH8gHsrMOAMLjF/850ulVdKw9u3aM
 N4wXy6YoBhTiQPibLVAMQTPw0s289giMF984dMyBoSC/SjWodgyFv1XGS g==;
X-CSE-ConnectionGUID: hczLosajTYmFJ+Jlbl+mcg==
X-CSE-MsgGUID: Xfk8ua5aSmO0lzJ/4ZKaYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93122867"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="93122867"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 21:40:43 -0700
X-CSE-ConnectionGUID: CPrbrdo5Q+qXRpRkPuPkDw==
X-CSE-MsgGUID: ykIKSAK6RveOWnXrwj/hqQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 21:40:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 21:40:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 21:40:42 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 21:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTxXziJY2WrBSGobmERHVUywgrFrg5sUBREXqmMjE+uHD9pyibvVmz763TdXSEdr34T1ritZA10ZSwekwfwXemCQHZImg+tGTTL6w/FlV5QdLJSdldJfr91ZMU36X5MKvqV9Q4WH1L4aN+k5XnCaFE2yj9AsPWNC8Q+CJOnO6V9/imRuXRPxGfi0+M8W9uwIuutV1e019JjqgrmJMzAFXLK9TRkyNk7YJpvzpomv1qFcAy3GAjprAEyIco4M88rYVRuDX1wL9plOqyV6lCILR3luaLhq2+0KmTm+TvgIxgwSPzyvb+EBO8pc+B2aPZDKpFFnYOuNwaNm00w4d2Nbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgonKDxB3+kyUzV01S5Fx0tl+JPJ0OQVkr4AyfcGOPo=;
 b=QIWpX0CiSYZRZGKvdZDCi5bEVfbr33We1UYJVFiIFVuizBAapLqu8+1QleJo3Bs21SOiEpMXcB6ri6O6e9bhqva9ipLQDY7hhjelKfnEfu6ANM0EBBHBSZoTeb2qFoD+tnBvKosVfZ/lLeTcOqi4CjGl+cRRhVJYncemRG/fHOxLHVmFLuTqgwPvqZj8ID2xzOkQ58Ynu1TMKibPSYOMm/ei4hwlXEdwTUq+lJTKrX4Rv9zj4A4xRkeM9L7/y7Gwu+pprEUyxX5G86PZYcLwAJWHkjY4duPhoyJ9IF3t4aVIUrSG60aP3fsPzx1DkRqwwLbx1GT3UVBIUSQWEthZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852) by SA2PR11MB5193.namprd11.prod.outlook.com
 (2603:10b6:806:fa::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 04:40:34 +0000
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d]) by SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 04:40:34 +0000
Message-ID: <03e6fef4-08b7-4beb-869b-3cd6a7b7a088@intel.com>
Date: Tue, 22 Sep 2026 12:40:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
References: <20260921073809.2658872-1-yuan1.wang@intel.com>
 <8d0de268-e9ef-471e-9a32-ead628d75713@gmail.com>
Content-Language: en-US
From: "Wang, Yuan1" <yuan1.wang@intel.com>
To: <qemu-devel@nongnu.org>, Tomita Moeko <tomitamoeko@gmail.com>
CC: <alex@shazbot.org>, <clg@redhat.com>, <bosheng.xue@intel.com>,
 <junjie.cao@intel.com>
In-Reply-To: <8d0de268-e9ef-471e-9a32-ead628d75713@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:d10:33::11) To SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFC295640A5:EE_|SA2PR11MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 60edf981-0fe6-4179-7508-08df1863a40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|3023799007|56012099006|10063799003|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: D1fXVaSp4q39tVKkAkY6eKky6n8C7axZ6XGgQdyYfd1fqV2a3cLuhQRPjyLSj1yTq3Q4BMfeSk/C/K7xKbA87YBtANfITVBRvWufQOsixdMkk7PoBkGK6wY82I/MtB7QyBnyE2RWN2tpi7ueYC2RrdiH1cV8uPnBIev/881C2WKgwA7cCiO0iOGVxuaN8CeRUWNlEfzSt271OdEOfuXjbm1Ut+Kt+pYU6ePmRBu+nKhLxvuXF8izz3kw6aQ23WPL2eshT4YjErbBmtzUwKQq9Rwsf4xJd/5///cicDnRpOKTfQ1KUHdX208Aov2DhmjDtazqNu2KnLqrJFX67RKK/TDF/E8jaYjQk9VwVd5FIfyi/bjwHhQsMHdiDJ33EouIpJKeY6ifUA/yDjmBtkWNSV/Bq0DPFzCimYcjrmqpFoeUi5yii8VuvMhucBUtyUi7ajxe+l0ASl0snQbGNi2beY145do5aAqfyMocb7G814RDCD7aUt1erLcY7VlGj5fd9yEndYRoKss3weERDT6FRtLxX5VFZw67TNA5yuz5v8yhin3ovgjKRwyOvNyBW/1EVlaFhElkIcMngYoamVuxFFUrdljZSbI35x3l1RHoRX7QtSMwz6TnYk+za7GCnJNQNbR0WJSLhfnVY2qmJDRNu6DxbtI21oHxRLMjlKjrzmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFC295640A5.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(3023799007)(56012099006)(10063799003)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGQyTytPYVdyNkxJVW5hN053S1M2c01CRHU1WjFNTmdSSng3Nm1mOUNLSXp1?=
 =?utf-8?B?VXdVRjdwbGxNNHdOdGI3Uk1xenpSenlReWdQUXc3a3VnOTUvdnBqL1FaOVpL?=
 =?utf-8?B?WExOUGhTZjZqL1lxNDZMd3ErR3lZa1lsQ0xFTWM2THBDczl5QmJva1RyKzZO?=
 =?utf-8?B?S0d4V3JPZSs0RTdhZ3JRc2dZU2E1N1RsejZ2eTZaNFN6SmZrcWFiL28vYlhU?=
 =?utf-8?B?OEpXc2p3YkpQczJaeGZTK09BODFvNExGMWtpTGxYSzJnbks0YUloaHltOTQ0?=
 =?utf-8?B?aUkvY3VlY3ZkS1ZWbkp1c1JBTVpUditJUmRiWkNZbml6ckVtQk12ektiU1Yz?=
 =?utf-8?B?RC9vekhDdWZ2Q3o2eFNsaEk2cUU1QlEybk5qSkRjaW9IMzI2eGdIbjRhY1dz?=
 =?utf-8?B?TTllRVJMeC9rcTBObU9zZWJJRUVjZCtMOHBvZkpTZFZkclBxVEZSdElDZzN5?=
 =?utf-8?B?aTdHd2V6N21QUmZvaTE4UGQzdVVocUo4cy82cjZHK2VpemkvaE5VZEtmV3RR?=
 =?utf-8?B?aStuZkRIRnVad1gyNnBhZ0E2VUo0WE9DVVl2ZUliclZkTk1PZ0orUzd3emU3?=
 =?utf-8?B?TDF5V0czWUIyK0tHTmVxbFdHU0V3Y2lNeG1JcUptMWFnUG1ING1raEFMdTlW?=
 =?utf-8?B?QzF6MFRSS0pDN1RickV6amRUOVRHUk5EcWJCWGRmN0hrcGlKamgxOXpqa09Q?=
 =?utf-8?B?MlJtM3lFZGpxUjJ5YVVLdzVqUnU4NU96MXVOZ2YrWFUxVEZJK2Fjc0NTZk5v?=
 =?utf-8?B?UVJZWE5ENXh0WWw4OUdFWXhuMUVmNFZmb1gvZjU0VzBIWWdxNG0xN2lJL3Jk?=
 =?utf-8?B?NDh2NGtUeXJ1bjZqa0JTdys3Nlk3V3BqTGRLWHFqNHZ2ckNCOUZMNjZqRUE3?=
 =?utf-8?B?VXl1UE1jNTI1WWZ2eUtFVk4razJpZ3JxRENpazl3ZmdybDNyZVhCYjlMQ3hx?=
 =?utf-8?B?WTZoV2JyT1VWWTF2SWU3N0E0R2wvSkoxamNsYjZ3SUZhT1prZHlNaEthOGxF?=
 =?utf-8?B?U3g4WUk0S1N2eFlJNUNRa2I3bHMxWGVBUDRDdGk2L3Y3dlUxc0IvTHQ2QW9t?=
 =?utf-8?B?ZkEvU1JTQ3RvSkNKN0VBQitGYTI5VXhrZWJtL3hqa20wZjVzUDZ6U2QvSGRV?=
 =?utf-8?B?OUpZQ2dOajJzbUhJL1BTcjFzNDZETUhNNVluYjlHR2RTMmpoRVFTOVF5OFIx?=
 =?utf-8?B?bjREYlVKUjQ0cm9rbnhYTHVNREFkTkwrK3F0TUl2UmJrWkw4Q1BsVmQ4Qlo3?=
 =?utf-8?B?RzNKZ21KUk8veWd5TnpkOWJIdWg0NFBicU5rNFl5OTZnc0MvbmtxNFRFZ2tH?=
 =?utf-8?B?aWlvQVZVdFJYa3dVTDhCT2lmanB0ZHhNZ1FVT015ZHVETGZaZkNSNzRucVp0?=
 =?utf-8?B?MkI0ZUJyUnVNZ283b0ZSOGVMWUsvRjFJRFRySjlGNDYrVFpkcHlMallVc0Jw?=
 =?utf-8?B?S2xlRWNLek1VamgxK3IwUFh1TFdJRFRndmE2UFY1R2QyMFoybW5kQ0RjdjJj?=
 =?utf-8?B?a3c4MnZRcU1yWnhIWUFhcm5Ubk1sM1AxMnAyK1QvZktTZVB6djYxV1dvZ2g4?=
 =?utf-8?B?b2dGRnpwWGVTa2Y4b1RZNllOY25vWGNwZk83WGF6MFBCalRqTmsxYTY2ZUNJ?=
 =?utf-8?B?RE54SGlKOVBIRjJ2YWxacWxvZEMvT0tNZXlrWDAzR0xVVEcxdEJjZmhzODRv?=
 =?utf-8?B?Y2tNNzZERWhSbXlEV1lzNkROeU1hdG0vSUdhb0kxR2RFN3FqaHlUUUtjRWJW?=
 =?utf-8?B?dzAwYUE0QWg4TjhJSWhnUG5TcVljSlhZZ2FydmFHUVpjVzIrV09FZzlGSEFG?=
 =?utf-8?B?emJBK2wyMFArTytxNUhhRHcrNHRDd3pVTmhYNWgyYTZrcUpiTmpKTXQ3Q0hO?=
 =?utf-8?B?ODVjTzRodE5iTmVOYk1SRzRaNXRYV090c2dWeG1YMGpRaDI2NnhjUm1pcFUz?=
 =?utf-8?B?NWJtOFFxSEVnOHgzOWN5WXM5ak5hWU9vaUQ4N1F3b1c5cjJsK3FDYWR0YlNW?=
 =?utf-8?B?ZjFQcjNNV1l2VXNkTXcwbkROYU9TNDl0Z0NSa05IanFmZEdtRmNMZnJjSy9n?=
 =?utf-8?B?S21XZkFkbHFVSGdCdzJjdmFCNnFzNExrWWZ1ZUo0NGNvWkNrWExSakNmSjdD?=
 =?utf-8?B?aWVCejhuV1dGVy9yT082cTN6azgwNUNxYVVrUXJXdHoweDBUSktUbDZ0ZWV0?=
 =?utf-8?B?YUI1S25wZEw0RVcwZVd5bG51OTNuN2paaFZ5Ykc2WXJ6cWFoYWN3S255d0x1?=
 =?utf-8?B?ZGRtTnhxbWZVdk1NOGpocWpWeitvT1UwN2lJamhRNTR2cGtBYVhMamxINmNm?=
 =?utf-8?B?WVFGS0gzVTVJMk8zSER4Y0RydjF3ZFJianQzWTNrK09JeTlGaGVMUT09?=
X-Exchange-RoutingPolicyChecked: 4YEx47Jz4AdDH+XmGlkJLVkfjArqTZzibfnQVxm6MCcaVVamRb1kKWPFzdGlP2Tn2YStZMKC+AJGU3S1GI1OldxxAAhkAY+CT6nBz6Iiwjk85gixiV6eNd+yoEdEeLjQmA/FR3EomGNCfkYETGYeIkipHX2esMf2ogmj22l7bXnWuvB7462t341m98M3nztM+6TIYbxcjBeLMg7kWus/M5MvsFw5kyXKK8BfyVNSnus+EnVJ4beTh64y3+qNT5dgBv1MnS653x8tKlZbkf4fuieTGZsNEZNQcC0jU4i1IwgGSB0+XPdqNbrdDrkufFoHxIEzjnYHcTb0o+rtHxRY6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60edf981-0fe6-4179-7508-08df1863a40c
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFC295640A5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:40:34.7764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KbnbzQPPPTI9/FWUHmI8ccYNrWT89Rn970CP+ILd0EOnqkc4tRRFumpxNisFvF1dmWFjt1ZGvTqWytQYkjTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 9/22/2026 1:24 AM, Tomita Moeko wrote:
> On 2026-09-21 15:38, Yuan Wang wrote:
>> Meteor Lake and Arrow Lake GOP can read BAR0 MMIO offset 0x138914 to
>> detect whether direct framebuffer access via DSM is available.
>>
>> In a VFIO passthrough VM, the guest cannot access the host DSM memory
>> region via such a pointer. If the guest GOP enables that path, it may
>> hand off a DSM-based framebuffer address that the guest cannot actually
>> use.
>>
>> Intercept reads from the detection register and return 0 so the guest
>> does not enable the DSM-based path and instead keeps using the standard
>> BAR-based framebuffer address.
>>
>> Suggested-by: Tomita Moeko <tomitamoeko@gmail.com>
>> Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
>> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
>> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
>> ---
>> Changes:
>> v3:
>> - Emulated register 0x138914 to return 0x0, which signals the guest
>>    GOP driver to fall back to BAR-based mapping since DSM is
>>    unavailable in the VM.
>>
>> v2:
>> - Resending because the v1 patch was sent with an incorrect future
>>    system timestamp due to an unsynchronized local clock. No code
>>    changes.
>>
>> Notes:
>> MTL/ARL device IDs remain in igd_gen().
>> This is required because vfio_probe_igd_bar0_quirk() checks the
>> generation before installing BAR0 quirks, and the 0x138914 quirk
>> is added afterward.
>> Meanwhile, we also plan to remove the bdsm-size check in the OVMF
>> offline patches.
>> ---
>>   hw/vfio/igd.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 413a49aae9..f6a2eab805 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
>>       case 0x4C00:    /* Rocket Lake */
>>       case 0x4600:    /* Alder Lake */
>>       case 0xA700:    /* Raptor Lake */
>> +    case 0x7D00:    /* Meteor Lake / Arrow Lake */
>> +    case 0xB600:    /* Meteor Lake */
>>           return 12;
>>       }
>>   
> 0xB600 is for Arrow Lake according to include/drm/intel/pciids.h.
>
>      #define INTEL_ARL_S_IDS(MACRO__, ...) \
>          MACRO__(0x7D67, ## __VA_ARGS__), \
>          MACRO__(0xB640, ## __VA_ARGS__)
You are absolutely right. Thank you for pointing out the exact kernel
reference!  Will fix this in the v4.
>
> Meteor Lake is Gen 12.70, while igd_gen() only tracks the major generation.
> Here Meteor/Arrow Lake and existing devices are all Gen 12, but different
> quirks are applied, making it look a bit awkward.
>
> Maybe the generation could be extended to 4 digits, or use flags instead.
>
>      case 0x4600:    /* Alder Lake */
>      case 0xA700:    /* Raptor Lake */
>          return 1200;
>          return IGD_FLAG_GMCH_GEN8 | IGD_FLAG_GMS_GEN9 | IGD_FLAG_QUIRK_BDSM_GEN11;
>      case 0x7D00:    /* Meteor Lake / Arrow Lake */
>      case 0xB600:    /* Arrow Lake */
>          return 1270;
>          return IGD_FLAG_QUIRK_MMIO_138914;
>
> Anyway, this is outside the scope of this patch, just a note for possible
> future cleanup.

Agreed. That's a very good point for future improvement. It makes sense to handle this

cleanup in the future.

>> @@ -454,10 +456,32 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
>>   
>>   #define IGD_GGC_MMIO_OFFSET     0x108040
>>   #define IGD_BDSM_MMIO_OFFSET    0x1080C0
>> +#define IGD_BDSM_ACCESS         0x138914
> nit: perhaps rename this to IGD_MTL_PCODE_STOLEN_ACCESS to match i915.
Sure, will update this in the v4.
>
>> +
>> +#define IGD_IS_MTL_OR_ARL(vdev) \
>> +    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
>> +     (((vdev)->device_id & 0xff00) == 0xb600))
>> +
>> +static uint64_t vfio_igd_bdsm_access_read(void *opaque, hwaddr addr,
>> +                                          unsigned size)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void vfio_igd_bdsm_access_write(void *opaque, hwaddr addr,
>> +                                       uint64_t data, unsigned size)
>> +{
>> +}
>> +
>> +static const MemoryRegionOps vfio_igd_bdsm_access_quirk = {
>> +    .read = vfio_igd_bdsm_access_read,
>> +    .write = vfio_igd_bdsm_access_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +};
>>   
>>   void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>   {
>> -    VFIOQuirk *ggc_quirk, *bdsm_quirk;
>> +    VFIOQuirk *ggc_quirk, *bdsm_quirk, *bdsm_access_quirk;
>>       VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
>>       int gen;
>>   
>> @@ -472,6 +496,23 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>           return;
>>       }
>>   
>> +    /*
>> +     * MTL/ARL guests must keep using the BAR-based framebuffer address.
>> +     * Return 0 at 0x138914 so GOP stays on the standard access path in the VM.
>> +     */
>> +    if (IGD_IS_MTL_OR_ARL(vdev)) {
>> +        bdsm_access_quirk = vfio_quirk_alloc(1);
>> +        memory_region_init_io(bdsm_access_quirk->mem, OBJECT(vdev),
>> +                              &vfio_igd_bdsm_access_quirk, vdev,
>> +                              "vfio-igd-bdsm-access-quirk", 4);
>> +        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
>> +                                            IGD_BDSM_ACCESS,
>> +                                            bdsm_access_quirk->mem,
>> +                                            1);
>> +
>> +        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_access_quirk, next);
>> +    }
>> +
>>       if (vdev->igd_gms) {
>>           ggc_quirk = vfio_quirk_alloc(1);
>>           ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
> Overall it looks good to me, with the minor nits above.
>
> Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
>
> Thanks,
> Moeko

Thanks for the kind review. I will address the minor nits and send out the v4 patch

series shortly.

Best regards,
Yuan


