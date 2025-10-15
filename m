Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91C5CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90jB-00017n-GS; Wed, 15 Oct 2025 08:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v90jA-00017U-7h
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:35:36 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v90j5-0004uv-LD
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760531732; x=1792067732;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u6laMJ17UXmDfdIQ0UFCCnFJP5tP/yYFXQLp0y6BVyY=;
 b=Nf6hBiXR0TosX5/0bZoAP+xBYa78sRlDst2odpgUh0Vw+VoqVkAuinpB
 lAUm8yL2F/woJjBeAse3nIoMd7y3XB9fU34+EAIB69mlcBhNm7V/MJqKM
 cZf9FB7ziia9rhUzNITyI2g7heRpjlKY6Qlao9jV17ZHFxWqGYSeQQR1t
 ifXaehmMrPorke78GyzKqEWyjgvGnk+hfmrxntS2R/+9kAFVB7RG6JG6N
 /gXj8WE+zkOInRnCbo4QFCTDo2HPTeUhFisK5rNaaNK5Yh5BJUR9uqOe0
 5V08GBBJPff78W+wsuJlOtZsNY1tYxMLzO5aBizwGeA44+TQKVLAQW0uA A==;
X-CSE-ConnectionGUID: WzgtivlgTEWWSaymp/SpDw==
X-CSE-MsgGUID: n4m/We9bSbKcWKHne4KOYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62743909"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="62743909"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 05:35:26 -0700
X-CSE-ConnectionGUID: 1/DRD3FjQL+2niFFs8dvxg==
X-CSE-MsgGUID: C4awUqWbRTq1Lf8TqaqzLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181714325"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 05:35:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:35:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 05:35:20 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3f8oI5+cB3M6vh3Y2xrnk8hoamI0ke9OWTX9gt0EDYF7ZWbnF019juLEXr8NHWdTtrN+XWXsQa15etC9fEKSajF76WZNxjzISVvCtIjV/PF2majCDbROOkRVPUOQUWNdWKQ9EuwF+HzX9RltaycCt0lw7A5Oxpfr1nrdgPn7+VUsGMRVh22VJfUTzCL1tWj1I9E9ENsgA6512ONKxfVlyoSb0zNVMiOpobjKS9SK2BJgsoL3GvVk1yxSrc1pM/J/mroggKKfzhy1zH7Z+xXGoDfbi3Pr0sdanrMd4XJtT4/SDlu7lNpjy5drcVPRzgKHzDahz2HuQH9fnSGtkC97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdQJJ6yO1X8zucD7m+Ckk2v8x0+YNmSM8zIwl9CN8rs=;
 b=mmcdMvupw98JNjgcfQXd4GLS8yD1i7NU/Tam9lBtT0bERacxIFrohfXq5ryLC7+4WG2ZV0QyuFZe0UN28Bo/Q5c51z8khd/5LgDCJKLwsjfB18QgpKvpX55PAc1GFQUoc+rGM54YQ+of9CidCA+KMlrJeGOo2dVJvjRrxyPkQPrdY0ZlcaMogLfsqJh83EZrPF5QGA/IDm+OBBeGEzEo6fyrUNL4zoybbAg2ai5jmSr/O13tN4o+i6Qzg9sQIadQI3ojz5Inl9CmWkyPVRRikTv9J4oTNKafcPG1TjD+LaY/yuCWfLYGUY6iKEA/vDZqirWDkyTGDzUab6WP47PH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ5PPF50B3E12BC.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::828) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 12:35:18 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 12:35:18 +0000
Message-ID: <847a4b9a-2de1-4c97-b5a4-0cfa6827bf63@intel.com>
Date: Wed, 15 Oct 2025 20:42:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <clement.mathieu--drif@eviden.com>
References: <20251015102003.279239-1-zhenzhong.duan@intel.com>
 <20251015102003.279239-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251015102003.279239-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::32) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ5PPF50B3E12BC:EE_
X-MS-Office365-Filtering-Correlation-Id: dd736a83-efee-4b16-3c3d-08de0be74c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU5CczhncE40Q0w2azNZcDMzZk8vMEdNY0NhT1hzZE94dW1QMkJEeE4zNWxQ?=
 =?utf-8?B?MVJiYnhKYkN3eDZ2OUdKa0RjQmNvQ3ZEZGtPcVVpZ1RLNG5YMjBPeWI5eGlv?=
 =?utf-8?B?Z3hKc2pMRUhsK2ZLS3NzUC9peXBvaThTMzhsOENuMHFmTEZ0NnR1RHNXckY4?=
 =?utf-8?B?QThyYlBLdDNxMERLbC92b1FBckxoNGRiVU5QNU5TQ29CaFUzVmhZVTZCaE5B?=
 =?utf-8?B?V2lOd0o1cTRMUjlpRk9HUjUxSkxkc1lFYVVRNDhyZHBJV0dFM2lkRDBxK0Rm?=
 =?utf-8?B?S0E3WitWdlBMcUVRb3VvU1VhSVVPcnFHQ3BEdVNzNi9McHRkK2lZeElXQnVt?=
 =?utf-8?B?akp1OTdQU1RCaVl0V3c0MFB5YlNsalNER2s1dkxKZEJHTWZDL1NiaUptKzY4?=
 =?utf-8?B?WDZsTFZnRWtxWGlKektWZnVNaXNmYk1oeUlpcVlhYWxNdWpvMjNWZDhCdkpQ?=
 =?utf-8?B?bjd6Nm1ZNkNsU3YzbmNrYWIxZzdYdy9vNTJWcDhFR1J6RlhLYmpvaVZyUkF1?=
 =?utf-8?B?UWovSGxidU9Db3FUaWl0VGlwcGkzaHFVRUxtc2o3dGJsZE5EbFRJYkkydHBj?=
 =?utf-8?B?VWJPb2p0SWxHb3lQUTZxWEY0aW9EbUU2UVVMb1BtbFNSb3E2Y3FhMC80aTNM?=
 =?utf-8?B?L0NVcDBjWDFoQlpmdkNEbHZVOXNCekxBUGZIT2E3b08zNUNZRXlSY01GZzg5?=
 =?utf-8?B?QUFFQUZRNXc1OVh3eFVRU2UvRTZCa25RK1MwYUQvNHBBbW1UNVRmdUlDWWtT?=
 =?utf-8?B?cFBXOHo2enA1MW50RndtZU85WnVYMFQ1TnpFYzZrcnBrUk9mcnp1VXNLdGtN?=
 =?utf-8?B?Vyt3b2RCb2xJcWpLWVl6bjd0dEpVS3cwTnNzeXQ1WllUbTZPaXdjcVh3ZWE3?=
 =?utf-8?B?a0VQTzJqWFBMREcyWDExZ3oxdmIyaFdaTUlINnYrMmRKRERrQlVxRXVXNitY?=
 =?utf-8?B?M2NkL1N5MkFHd2o2akFvemZPNmFEdTIzU2N0UWthcFpkck1VZ3c0bVRqTjRV?=
 =?utf-8?B?aVloLzdTWHpibkhVYjlRYTBpWW4yNUljcUI3YzJ5dTExVmlXcC80ZGIzbXA3?=
 =?utf-8?B?YWh5YjNOUDlHR3c4ekFVaFFWQnQrV1k5WWxMVnRXYzgydUVkcU9HZGlETEFO?=
 =?utf-8?B?SXNQVkp6dFVuNU5uOHdyaE4zZldsKytWc1JQSjRCNm11MG52UUlHYWpWNUpT?=
 =?utf-8?B?Q1BJeitzS1NXMXJKb3psMXliQUplTUlLYlFYcXpkbmZYdElCQXkwSCtaTmZP?=
 =?utf-8?B?Z0FZY0tRNndSRnhxMVR2OUdjaFBQYmduTTg4OVdLMG9zNktBdmRkVWV5QzFo?=
 =?utf-8?B?VTljeEJ4K2FoTEdsako2VjhrNXlwc0NHOVNVNzB2WVZEYm9UekF6VFdlZmhF?=
 =?utf-8?B?dU5tdzR4ajVxNDU4WWt0a0RkNXQxamZxN3NRRHd5RjYzT3B4QmZTUjlzcHk5?=
 =?utf-8?B?K3dnRTl5cXV1WXU3SGJRR3FoN01SRVlXNnZ3dHZHSWVMa1kyMnR5RnZSZzZY?=
 =?utf-8?B?cHRxcklsOWdDbFdjZHkyazl4ZCs5MDhCT2NXQWQvazdpaGcwSDh5YTYzOGFR?=
 =?utf-8?B?Tjc2bzJwbkZqOXN5Y3dRUk1LK05FbDRabFVmYnFNY2hMVVJWMjFJaGR0S1N0?=
 =?utf-8?B?MVhRL1FDTEptTWNyMkNXUW1COEM0Vm5kcXU0Y0RXT3RGLzNnak5xSXVveVhJ?=
 =?utf-8?B?RGF3UlZRb3hUa2tkWHBuaEF4NCs5RVZoVWEyamNDQlpYTHJSYS9WWmV6SlE0?=
 =?utf-8?B?YWQwS0dmRUVqc0VBbXBJeEhSbTE4NDNYZm1rSXpYVTBhSHkvZm1WRGVRWXht?=
 =?utf-8?B?NWs5c3B2TjZtcVQ4b3Vqd2NubnIwdnR3bDJHUEhWVm82NHI3N0JHWXdzSWtD?=
 =?utf-8?B?SHNNTmorNkcyVlFac09YMXEza1pGOHM2ZkdHOHFSUFN0YXk0c2VYc1Z3cHpN?=
 =?utf-8?Q?yIteqjNMS+4fywBuWp/Bw14uLYkd36Ao?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJrb0g1dDNWdkFVLzRhT2VVY2J2cGdGRVVnUFR0c0VIaURzY1lkWUNPc0dR?=
 =?utf-8?B?Q1NBWGYwbnVUUEpLNDF0TkpCOXhFZlg4RjJPOWN2OWhaaDBXM2RWUGROU2Zj?=
 =?utf-8?B?MGlCMVRwcVQvQVI1RVNaTTA0ZEFFTmhPL2NhcFhXakwrZXczMHRYb2Yvclph?=
 =?utf-8?B?cGdpbmV4ZGdFajFiRzRYM05nb3RGQmJYc3djSE1BU3VDWFJxc1l1dklMTkpQ?=
 =?utf-8?B?N3V6eGhrU2JGSkxsTlJzdGFoMFI1WGJQVmdGZTl1bnpYUzdnV3RWY1NDWWd5?=
 =?utf-8?B?QWZ3MkxLcmFweTJrTS9BUXN4d1lpN3JpVExySlJVK3ZtL2F4V3pOUUdtNWxB?=
 =?utf-8?B?cVVQMm1LK1ZheVpJV1FSdUZZZHI3TGZGTjBDWWU0MEhLMHRxbSt3eGpaaDR3?=
 =?utf-8?B?NFc5Z2xRd3NFWkEwek5TN2dQZHRHT0ZwNlAvUXNudlh1cVZpNXVVNFF6Tmc4?=
 =?utf-8?B?Ukx5QXNmWDQzcFhHdlVqQmVMV2VHdmtlaVR1b0tNS3I2Z3BwTXArazZkZXZJ?=
 =?utf-8?B?RXRuOVZDMDd0KzJ3WGtLNXVFUmhabDBRNVBIS1JlclJOT0NoRElHVElpVjVP?=
 =?utf-8?B?aWRRUHRTRXMxMkZTb3JYemdKN2V5eCs0RnM5Vjcya0Uwa3owY3BvZ2tERG4z?=
 =?utf-8?B?UUxOZjQ0eUtEaFh3VDAraitRUkxpTWYxRHMrcU0rT2p2cG9zOFB2RnIrU2JD?=
 =?utf-8?B?NWpoVTZ4K1dzeDdUT1NXb3UvbGZxdWpCWWFQY2d3OXlUSVR5N0VnQmRkR0lJ?=
 =?utf-8?B?V3p1Yy83eWhnbzRFWE1LekNwc3RHWXdsS2M1Q1hXdUp6NERWQ29nYTBMZGRy?=
 =?utf-8?B?VWNBUEU0dU5OOG5uK2h4cjNGcW43VEYydE52elh5TWNic3pyS211cU1CNC9l?=
 =?utf-8?B?aEJUeVVPaVBRUkhSL1I4aWt0T1U0QWtmT3BEdWFPQTNIMTVlZExBKzNpdTVx?=
 =?utf-8?B?L2JWcEtveUlTQjNuUDRjODZpdHlvbWd6UUNJcm4wWWhXTTNySE80RUltYkRa?=
 =?utf-8?B?YzU5MjFlY2twbE8rNkFPaGU3MzZZbVBlbzRxQXRUTCtwT0NrY1FCOUVsUU1Z?=
 =?utf-8?B?WFFBZ2F4S1RCV2hmLzhIT2hUODYyN28vLzVWVEoxRnBEV2ZiSTlkbVA4azZu?=
 =?utf-8?B?T2Zkb2RvdUJGa00rb3hRTEdnaUFTU1hMREI4RlpFY09DNlpyMklFeGdmL1hD?=
 =?utf-8?B?TzZVTlZYYnBkYzBGTThLcFJZcDFhem1xSUhCT1g2RmpQZkYxYmlhTVU1ZytL?=
 =?utf-8?B?S2l1bWYwSjR5MkZWYnJOZEptcEh0akpvV0Q1VnRHeUMyeUZuTmU5YW5CVDdF?=
 =?utf-8?B?QW5KWjkzSlQ1QVhpRmxNakxJWnJRdVZYQU1OY2lrcUNFN1hPYlZyRWNyOVdi?=
 =?utf-8?B?eGk2KytnYUs0V3NYNWxFdHR4a2RJYkZObG42N1dVWkRQMCsxMVdMNmsxZEFO?=
 =?utf-8?B?bFp2K0V1dEVqd05Td3ZXelNUc0EydFZkeit4VThYNmZIUUljM3RPYjE3LzMx?=
 =?utf-8?B?bjZnY3YrS3NQSzVIYkZHY0NBa0Q5aEQ2VDU2VXliRW9ka0kyTDNxOXZOVlZ4?=
 =?utf-8?B?a2lPVHhXWThQRiszcXc5bWg0eHErRnVFREo1YVlOakdrYnJsWkxQejBQSUZo?=
 =?utf-8?B?NmNVWmorWlFrZFp2RnFZcGM1cWt1VGhOOXUvbTFodmM5TmJpbzFuN0N1MFVP?=
 =?utf-8?B?WmZMMW42ais2b3VYa0FnWW9zYjNwcGxpbWdqTk12cnYrYkVjV2k1MWdPOGJ0?=
 =?utf-8?B?RVNnUUYvazlkTVJWK3U3VnNPSlRXRjNvTGFFQ2NnR0tJclZYa3FqUTVKQWpk?=
 =?utf-8?B?eS9CbGxBSmtzNWxVZlpEWmg2T01LbjZEMVNBSUwrd0Vya2hWM3pGVmpJb2tF?=
 =?utf-8?B?bkJKdWNzR1VvS3duRHNVZkdGc3RLeWNaand3aDdYZElVTjdNMVJYQVozZjJR?=
 =?utf-8?B?bElTcEUvYWo5aUs4bWxQL05qeGhkRERLdWsvR0wyNTVBcjZxaURTWmhVR3Iy?=
 =?utf-8?B?RU9mUkJtR0RKNVZJWmxxMVA1WXpWVmlBWDg1dUFlU01QS1lJRHdxb3lveVd6?=
 =?utf-8?B?Mk55UXJHdzQwaXRueUpKNDBaNDVTSGZ1MWwvZG1NdklkSkMyaHFhR1A3TkJ4?=
 =?utf-8?Q?RQHckhHhEvhPr76NdSZ2vOsHG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd736a83-efee-4b16-3c3d-08de0be74c56
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:35:18.0672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD01qjulVvpWP00UYVc8FYxOKBOSYZcQTUjqvMbFSeHv2lOafdnoD8nlSfATFHc9qVaVBbmh8lRFRsrqcvjHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF50B3E12BC
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/15 18:20, Zhenzhong Duan wrote:
> Kernel allows user to switch IOMMU domain, e.g., switch between DMA
> and identity domain. When this happen in IOMMU scalable mode, a pasid
> cache invalidation request is sent, this request is ignored by vIOMMU
> which leads to device binding to wrong address space, then DMA fails.
> 
> This issue exists in scalable mode with both first stage and second
> stage translations, both emulated and passthrough devices.

does it affect emulated device? The domain switching should have
IOTLB/PIOTLB invalidation. right? Then the emulated device should
not been affected.

> 
> Take network device for example, below sequence trigger issue:
> 
> 1. start a guest with iommu=pt
> 2. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/unbind
> 3. echo DMA > /sys/kernel/iommu_groups/6/type
> 4. echo 0000:01:00.0 > /sys/bus/pci/drivers/virtio-pci/bind
> 5. Ping test
> 
> Fix it by switching address space in invalidation handler.

a good catch.

> 
> Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d656e9c256..30275a4f23 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3104,7 +3104,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>            * reset where the whole guest memory is treated as zeroed.
>            */
>           pc_entry->valid = false;
> -        return;
> +        goto switch_as;
>       }
>   
>       /*
> @@ -3134,6 +3134,10 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>   
>       pc_entry->pasid_entry = pe;
>       pc_entry->valid = true;
> +
> +switch_as:
> +    vtd_switch_address_space(vtd_as);
> +    vtd_address_space_sync(vtd_as);
>   }
>   
>   static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)

The change looks good to me. You might want to adjust a bit per the
comment in patch 01.

Regards,
Yi Liu

