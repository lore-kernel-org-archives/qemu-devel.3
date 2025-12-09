Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6387ED3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 11:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSvc1-0005vP-5j; Tue, 09 Dec 2025 06:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vSvbx-0005v3-MC; Tue, 09 Dec 2025 06:10:30 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vSvbu-0004rg-SD; Tue, 09 Dec 2025 06:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765278627; x=1796814627;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4I88YJOU+QVNJWWzOWTgpOLt70/fslA0fkTWZ/LRsBY=;
 b=QfGHMXcYMWE9WD2q+9YOl9zW/vVhYlPZ0hPMvBVAHFWE9wfo/2pIqxp9
 00/ozatPwA1dDKmvaYoIgWZ4eXpegjpffHP9qyyK1cbtFpvD9VlRjoBvU
 P+d0CKe9DzeIU/aI5OxppnVP1Y/8CWcXS7GHk1xoXeIMcZROwMJRBUAh7
 8zhcsJfCMx2Ng1dE8WYXtDeoETvNi6ymiwtCkn1rdZ7ecg6dxfUSfZAAF
 SJfMiu8GehxMBX1GaECuAmlur2FrpYf/3YVhItcNyuh7tJuIT8tnOm8eI
 kOxxsteDszOsT12MszybZfSarPV8E182WJJ2h1EqDbK5gsUzMzEAj3HGc A==;
X-CSE-ConnectionGUID: fQKEnhFYQ/ePsuFhLmE/7g==
X-CSE-MsgGUID: 8do6xpVxRfCQ2z9ShYip4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67195180"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67195180"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:10:23 -0800
X-CSE-ConnectionGUID: wif1LUjZRcaNz2WvMtrshQ==
X-CSE-MsgGUID: UFQaIXWJQ4yLNSKKVw9MpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="200682131"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:10:22 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 03:10:21 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 03:10:21 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 03:10:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlPc9cPay1YTHLVXnelqGu/1shyNSjYtPq6FB/xX612beWbgYUp5XPqzHTz/rBbxOxQby0OLHx79XFuwh8r5Cx5yq9SIeJyuNXk8dEA62OxfS49Z+qqmnjLde1R00EI3XkuICJHRJS3Ax9SZ/UDyOXXdF4OfkA6GoT5eQhzaPuCwCybTHi2YXLDwhJzKBHBT01l4mA1hAMrfHsz3qCtHaJGxt5ZMeRG9X5nUupa97oScvcovaPRLDyMrbtQqHjhhDNw8zRSDhPxRj/ErXNc4VTl5dOSWslH90mrAiEbP08CZh9cHXjHkUfb0WgrkpptFBDmQhrjFy8oAbuUm9KakkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQBu23UvIi11R6hhSOK5ZhpZKJ8U/GMdGQrC6oidUUI=;
 b=sRuHGwz3EZeseuYWRVqDelaPLcpJDwipMKJTJPwoI+xCV+jse2KtsX1BNaRJPnqsFRQGm6i5elKu66QyEhLTLs+yodqzFYs4Njf0qWXxCvU9q7vJ8ePw0NN5hYNAMN2VnJydf/MX6kKBE3d0bOehQm8w8TZ3gQg2Tse9ZDHc8oYv84cQnPxXDgqFOimEii65CXYFCG7bQklOOpRbOv/+WxgqWec2CVgu3h7HXirUQcoDCvqmaP67VAItom/Aqzc6fteTagCYni9KdhRgB9GvohC5yrXMX//z38BuaLZGdaEniZ5WgkjH+C29EHPVNvSwwVgK/f8Llv27WgeMjtuCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 11:10:18 +0000
Received: from PH0PR11MB4790.namprd11.prod.outlook.com
 ([fe80::3836:742d:4c18:1025]) by PH0PR11MB4790.namprd11.prod.outlook.com
 ([fe80::3836:742d:4c18:1025%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 11:10:18 +0000
Message-ID: <483fa0e2-aeb5-43b7-a136-692bbd24d0ba@intel.com>
Date: Tue, 9 Dec 2025 19:17:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
To: <eric.auger@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-33-skolothumtho@nvidia.com>
 <7dc608a7-b36b-4250-befd-d26115b54e26@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <7dc608a7-b36b-4250-befd-d26115b54e26@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::11) To PH0PR11MB4790.namprd11.prod.outlook.com
 (2603:10b6:510:40::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4790:EE_|CO1PR11MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 7503b714-a203-432b-7b73-08de37138990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJwMWpGVVVtNTVFbW94c3J1UWdCNDRqbzV6L05EcHFHckhyM1ZyV05MZ21I?=
 =?utf-8?B?bU0veDR3N1FUdGtsMENxemt1eEp0ZGlsbjhVOEZQNTM4dlhWajM0VFI4ejd4?=
 =?utf-8?B?TXd2cXVrb1c2cWZVN2VsRHNoME1ZQXEvVTJtU1FkODFmTSsvOWhJaEZsdStK?=
 =?utf-8?B?UHRWWElET2pQSkNEL0dBZ3VXdzBFaG82QndxczhDT1phNk16TXo5c3VFTmFu?=
 =?utf-8?B?alpRcElzQk9QWHJUTndmZVVHY3k1QlFMZWxwM24zZnBFekFzMFMyZzlTYmZ6?=
 =?utf-8?B?M1BPUk8yNWVkYlFmZTRWL2wxcHJLK0dJUkk1d2RrVi9wcDJXNktuRXRnN28v?=
 =?utf-8?B?a2dWUlo5K2czanE0dlVqUmZjajhQZWVMbFh4ZDU2bGg4Tm9QNEFKRVdTVXdW?=
 =?utf-8?B?TlFEcEJSa0p2TnZodk1wbUxCbXI2VTVKcEd5bUxuVDJlZkRieXNJZmNhaUVB?=
 =?utf-8?B?UWM4a2RDVEtpdm1tamtwMm1hVU9pMVZsblBIUlM5N0NHZk85TXFXRnowaGI4?=
 =?utf-8?B?L0NhK0tlbFQ2c3Y0dnJwZXhIbTAyTkhLT01EZjV1TW1idUFwMlpwcWVZWFpx?=
 =?utf-8?B?eEdpZVlCVlFtU252MGlqem0yWGVxZFNoM2QzdWZGREFsMnczY1lkSkFQY0lz?=
 =?utf-8?B?SE5UUDRWczRnNkdxWWFuNGdVVWhXRU9nT1ZuYlJYRUcrMExiZytxV2YzdHp4?=
 =?utf-8?B?RjAyYlloS0tWUGYxNURvcUIwUDdldnIwMWlvNVNQKzJZVHZNNm9jakExSzZr?=
 =?utf-8?B?bGt6VFdrc2tHQnZYZVZ4a0ZLRHRLckZWY2NrWVNZTXdaRjdRRW9GY3ptTzVR?=
 =?utf-8?B?cUJiQ2pyczZ4cnF4QWozYXhxNjFEWGZFUE9RUHkrZy9hbktnRGdFVU9NUDI0?=
 =?utf-8?B?eEEwZ05uNFNoWC85WDVKKzN6TndHSUFRbmd3NndSYmJRbHluZ2FZdFJxakpL?=
 =?utf-8?B?ck5jNEN6My84NHVIMFpjN0dlbERvRTJpU29vaFdTbXA4OXBGWWVnNkhLdXda?=
 =?utf-8?B?VC9Qc05kWUJ0ZFQ3Y2FPUFBmbVJMeXV4ZkI4Y1VjZEtscGoreWRCaVAzWVl1?=
 =?utf-8?B?bnNBZDhoWForaGExU0g2VDQ0eU9rb3dQQnpmRUk3elpsRzRIN1p6VHVsbkFP?=
 =?utf-8?B?bDRvUWFrb2plRTFROTFDKzd1L2JWdm0zN2NKYU9QbUE2SitpTStxQ1BiNklw?=
 =?utf-8?B?Nlk1NEo3eDkrRkpLcGIxWGs4MTVoWEJRZ2hQdStIaWhSeVdPRlVpaDY4OGdz?=
 =?utf-8?B?SzhlNnNUQTlrU1FPUE91ZTlCWkZSR3VIekp6WHM5Mk55Ylp1SG1OMHdYdUsv?=
 =?utf-8?B?YWJ1MnNXMVpMdHBXRVhZamN2aWlHRlE4NHBldHhjZk5RYjlEd2RGN2ZJRzBp?=
 =?utf-8?B?dWU1VXU0Wm1DbzVJME1MYktpUmJPRmFzZ3grUXN6ODEwUnRTZWpmTlUwNlhK?=
 =?utf-8?B?V0pvTDIrZjlRL3VoNXpYY0hUb3VKbWhPenpqUWhnWmFhQU95RUpGYmZJblBH?=
 =?utf-8?B?ZUFSRElUVXR6ME9XRHpVWmFheTZFM0FDSWIzcDRuU0N2KzZoMnpKZHFlNHZu?=
 =?utf-8?B?L3V1ZWM1QnI1UnRQTWxYb2V2azlLNzE2dXpQdVRYdlprS013MVlORStYNnp0?=
 =?utf-8?B?bDJsTXFJTkk5OHBNUG1mM0NKcHE1N0ZsVnpSSjlHajdXbnlYSFJMR1pXbVRE?=
 =?utf-8?B?aEk4eFdHVmNxQStVaFBmUFBQUnBjZmVXNWJuOWxUQnJHU2dqY0JCa0FwOE1G?=
 =?utf-8?B?N0x2MkhQMHZScmNVeGk3Y1BHYk03YUw5U1RjWnJqT2dtVVU4Q0ozbXNkc1pq?=
 =?utf-8?B?ZHA4aEdJZldrZGlYcmd2Zmd6R0tzSGxWb2ZvZzZIVk9BdkhSdjE0K1hwMXFU?=
 =?utf-8?B?aExNMSszcWVhMlZMTDk3K0R2Y1Zkc3JVV1lFdHlKVmdLNkJxdCt2dzlvYnNQ?=
 =?utf-8?B?eTlnd0g1UFU2M0oxNy9ZZ2ptTGY1UGFsM1RXZS9GSitpYjRHR0ZleTFOcjY5?=
 =?utf-8?B?L1o2ekswakF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNjNnNKWG1vM1VWL2MzNlZJTzNPMENQMWtXRVhZZEZUajFha0FDYkhYSHpa?=
 =?utf-8?B?WmdxVm5ETXhLMk5xTnlqNXJhYUFCL1dDbm9SRFJqR3BBT3ZNdVJZdHA5ZVdD?=
 =?utf-8?B?UGg4TDZPWlA4ODhxQytiRHRNNFM1VXVWZUtqRWNwampkQ1d4YTJxZVZsUFNX?=
 =?utf-8?B?K0xjdHd0aDlxcDREMnQrc0I4cms2bytjRUk0MWxaZVJIeTBWb0hFWlhZU1d2?=
 =?utf-8?B?VkR1VXo2Tm9GY002OTdPbktWT3BOeWVGbmVDMFpOKytQWC9xdzIvS2FHMVYy?=
 =?utf-8?B?MGV3Q2xhTVRTblVxZ3hLQ202UldzQ2djVCtMcnZjTXR3ZkVQMVlDNkpaOTJR?=
 =?utf-8?B?TDM0bGRZaU4zVDVUcmhMQjkzZHBpMmlydEorQVZZSGJLeklZQ1RCdUtsbkhj?=
 =?utf-8?B?dlRXSENDTnVNM1QwalgvYkRkTGs3amthWWxmV0h4ZVFzaXF0U2d4ZDdlWVBU?=
 =?utf-8?B?Z0hlRlc2M1JGSEt1dkdBTjA4QndsUHlsSmhmLzVpVTU2WS9DUHVFYUttM2ZO?=
 =?utf-8?B?KzVKSHFmUjI4V2lNYTdUc0tsbnRoTnlUZk81aVpJcUdJQUhMbFpMZFo1ZXdv?=
 =?utf-8?B?MnhMNk1Zc29lYmFEOWhnWUxOZlB0K3diSEJXeFdIYnFRZWZEcjZFcmlQRitC?=
 =?utf-8?B?Qm9MdEtPWTRBdUtrRGNkTjlPOWp5ZW8rUGdmYml2bTI3aGx3Z1NQc2IwcjBE?=
 =?utf-8?B?Y2FXbHNSU244ZndldTZyTm1MUjhMa0o1V1hGSFJjNmh6R2pXMEtqNElQblB2?=
 =?utf-8?B?cXZ5TXN1NUw0MzRIRlZYV2Rhd0ZXZDZDMlFKdUtYK3ZPRkJsU3NoSHRLWnk2?=
 =?utf-8?B?enZDQ01UZFZzcEs3V2tiU1hmaXhzSnpnUkhGREN6UDVVL2tIVUdQMzFsRHVu?=
 =?utf-8?B?cmNXZHVaZEwvVUdqOEFwdGVQNGR1a1RUYW1QNW1QL2RYaGhOV091WkpUZ24x?=
 =?utf-8?B?OEdvV1Rxb3BhK203cmNNTVJDc3dlaFQ0T2dON3V6YkxDR2JscVdpSU1BMkk1?=
 =?utf-8?B?SktwU3E1S2RmVE9lSHVUbUxVeDlxcmw1Q0JqVStrSGZZTFBGUUVzQUpPV2M2?=
 =?utf-8?B?dHVXOVZtUlNuUzVNRmgrQ3hjbzV4cGZPMmo1MTl5M00zVUZaNFJqS3o2M1Ix?=
 =?utf-8?B?NE9TejR3d3BiVVBtQmdkeHVFNGYvOGx5TEd6RThzZVc4dFE3QU0zbCtBQ2ZR?=
 =?utf-8?B?RS9SVGt5alJuekVMVjU5eVBNUEFudjZpOFdPK0pzdTh1UkpwUkJ4dW96ajR2?=
 =?utf-8?B?SUxYdThFWlFrOWN6S0syVDZUM20zbzBESWt1NHlmVTBVaEtzK2Q1UHR6MjVz?=
 =?utf-8?B?dkt0dmNqLzZyN3pRRVlUZkU4WmFDL0c2TlRFQXRpb1I3TzB1QzlIZzF2VVBV?=
 =?utf-8?B?VG1YQXBKbjJseU01cGF6RU51dkdXNUhEZ2RnMFVJcWh3Vk01dFI2ZTFqR21o?=
 =?utf-8?B?Z3haWGJGdmV4K0VCdkJXZTBQMXBwbVdsOWxiQm9yMVFQNFBtMjdIU2FodHdt?=
 =?utf-8?B?OENsc3YzdVBPVWU2bytBQ255cTY2T1hrZDBzQmIzK3NmM2hPS1YwRHpZUllr?=
 =?utf-8?B?alRXYUkwR05LVWJ6eFozdTZGZEhtY2Rqb1FtL25ZQ3RtaFdNYnhVQmpsbHlI?=
 =?utf-8?B?ZmxEb0xQUzFNQjVhRWdHVnVFRGJieHFvZkxlMGpJQ0xxSWdkaW51QVR2ZDdh?=
 =?utf-8?B?YnNVckNzV3VXOG5HYUp1czVGZUpmbnlHMlA3Mkw1OUM2K0FqSGZzUHJKUWty?=
 =?utf-8?B?eFZjZ1pYdkRUM0o2M2huVmZLQ0s4ZzZOQ2dHditVcWFKZnJIcm9UR3l5alZF?=
 =?utf-8?B?dnhaQ2xSMW5iL1Jkb1ZZOUNuSkd6NEljNWk5VUNsUGRBcjhGQlFZejA0czAx?=
 =?utf-8?B?RE1RbXNLaHc3aCtvQVdZVHRDeFNUSHA2b0FpaVFDNWV5bGJueTNRNDZ0M09Z?=
 =?utf-8?B?WmM4UW1lYW9Ybng2cUU1S1lJYXErNk9vS3ZpK2w4ZHVIYU1xeWJmcFF1bHFu?=
 =?utf-8?B?ZjBsRU9NUUY5STZHR2xJakZOeUhoMElWWFpEV2RnZTNqYjNpTE1ZVFE1Njl0?=
 =?utf-8?B?OHdaMDIzaDBiOHh2N3JHenpGVGJkWXVjQXVOYTFpdi8zOHNnVkFxbm1zanRF?=
 =?utf-8?Q?w3VxJpQqcSWW1DFh07EIVLG9R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7503b714-a203-432b-7b73-08de37138990
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 11:10:18.6360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nI4ys8ShXblQ57n7yQCsPkfR6KIY7+M3MXPb7to/5jtdQ8njq39dSyAbDflxgfJF7SuKNgcwJ3H01+cRTVAckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17; envelope-from=yi.l.liu@intel.com;
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

On 2025/12/9 17:51, Eric Auger wrote:
> Hi Shameer,
> On 11/20/25 2:22 PM, Shameer Kolothum wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> If user wants to expose PASID capability in vIOMMU, then VFIO would also
>> need to report the PASID cap for this device if the underlying hardware
>> supports it as well.
>>
>> As a start, this chooses to put the vPASID cap in the last 8 bytes of the
>> vconfig space. This is a choice in the good hope of no conflict with any
>> existing cap or hidden registers. For the devices that has hidden registers,
>> user should figure out a proper offset for the vPASID cap. This may require
>> an option for user to config it. Here we leave it as a future extension.
>> There are more discussions on the mechanism of finding the proper offset.
>>
>> https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/
>>
>> Since we add a check to ensure the vIOMMU supports PASID, only devices
>> under those vIOMMUs can synthesize the vPASID capability. This gives
>> users control over which devices expose vPASID.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>>   hw/vfio/pci.c      | 38 ++++++++++++++++++++++++++++++++++++++
>>   include/hw/iommu.h |  1 +
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 8b8bc5a421..e11e39d667 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -24,6 +24,7 @@
>>   #include <sys/ioctl.h>
>>   
>>   #include "hw/hw.h"
>> +#include "hw/iommu.h"
>>   #include "hw/pci/msi.h"
>>   #include "hw/pci/msix.h"
>>   #include "hw/pci/pci_bridge.h"
>> @@ -2500,7 +2501,12 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>>   
>>   static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>   {
>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>> +    uint64_t max_pasid_log2 = 0;
>> +    bool pasid_cap_added = false;
>> +    uint64_t hw_caps;
>>       uint32_t header;
>>       uint16_t cap_id, next, size;
>>       uint8_t cap_ver;
>> @@ -2578,12 +2584,44 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>                   pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>               }
>>               break;
>> +        /*
>> +         * VFIO kernel does not expose the PASID CAP today. We may synthesize
>> +         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
>> +         * record its presence here so we do not create a duplicate CAP.
>> +         */
>> +        case PCI_EXT_CAP_ID_PASID:
>> +             pasid_cap_added = true;
>> +             /* fallthrough */
>>           default:
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>           }
>>   
>>       }
>>   
>> +#ifdef CONFIG_IOMMUFD
>> +    /* Try to retrieve PASID CAP through IOMMUFD APIs */
>> +    if (!pasid_cap_added && hiodc && hiodc->get_cap) {
>> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_GENERIC_HW, &hw_caps, NULL);
>> +        hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_MAX_PASID_LOG2,
>> +                       &max_pasid_log2, NULL);
>> +    }
>> +
>> +    /*
>> +     * If supported, adds the PASID capability in the end of the PCIe config
>> +     * space. TODO: Add option for enabling pasid at a safe offset.
>> +     */
>> +    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
>> +                           VIOMMU_FLAG_PASID_SUPPORTED)) {
>> +        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
>> +        bool priv_mod = (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
>> +
>> +        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF,
>> +                        max_pasid_log2, exec_perm, priv_mod);
>> +        /* PASID capability is fully emulated by QEMU */
>> +        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff, 8);
>> +    }
>> +#endif
>> +
>>       /* Cleanup chain head ID if necessary */
>>       if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>>           pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
>> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
>> index 9b8bb94fc2..9635770bee 100644
>> --- a/include/hw/iommu.h
>> +++ b/include/hw/iommu.h
>> @@ -20,6 +20,7 @@
>>   enum viommu_flags {
>>       /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>>       VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
>> +    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
>>   };
>>   
>>   #endif /* HW_IOMMU_H */
> Besides the fact the offset is arbitrarily chosen so that this is the
> last cap of the vconfig space, the code looks good to me.
> So
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Just wondering whether we couldn't add some generic pcie code that
> parses the extended cap linked list to check the offset range is not
> used by another cap before allowing the insertion at a given offset?
> This wouldn't prevent a subsequent addition from failing but at least we
> would know if there is some collision.this could be added later on though.
> 

You're absolutely right. My approach of using the last 8 bytes was a
shortcut to avoid implementing proper capability parsing logic
(importing pci_regs.h and maintaining a cap_id-to-cap_size mapping 
table), and it simplified PASID capability detection by only examining
the last 8bytes by a simple dump :(. However, this approach is not
good as we cannot guarantee that the last 8bytes are unused by any
device.

Let's just implement the logic to walk the linked list of ext_caps to
find an appropriate offset for our use case.

@Shameer, apologies for the delayed response.

Regards,
Yi Liu

