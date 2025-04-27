Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD41C369CB
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 01:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8quQ-0000tm-Do; Sat, 26 Apr 2025 21:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u8quM-0000tG-SV
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 21:34:15 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u8quH-0004cS-FF
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 21:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745717650; x=1777253650;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zOgwNRAnwZibzuwJ/epISz7puTyQWfH4KYJ4w/kCsm4=;
 b=JBhptOM3Td1PHXVU8i1B0U5c0BxfbFkwmCNCD4PgEk0zcIG9gLfxATwC
 QY3FI+knPbQ8u8fIbi/cW4mXWKKNtvzwksOvS9ydJCaflK/FNIXv9ncKv
 EwwA0XTiTCHnqAbu8nWUIPO3k6/tY8N8mH1+h8rfv63owxasY3q+WE0jY
 mNMgtSV3dHwiuCRomk3CoyhIVw0vKh3Yfy175rnDjkhvgAMl9A1yMpncN
 7xE55ZWtjixtgNBIgb3MIQIhA6Q8tJIbLuyAHdzwKLi0q3t4g4QFM00nl
 lXuX6MLsMMB4OoDH5QFMquutTNbTkaF6O/SPB+adem+5/Wcct07VQprUl g==;
X-CSE-ConnectionGUID: HQIBF/gQQ9+RsVKYHq5RTA==
X-CSE-MsgGUID: CG8rgi//TB6eYxlb/s41Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47246333"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="47246333"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2025 18:34:05 -0700
X-CSE-ConnectionGUID: ZXMh3ld7Sp+UD1bd/Qhnnw==
X-CSE-MsgGUID: dz0iWEcYTZ+UY9Sl0YG6WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="164172590"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2025 18:34:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 26 Apr 2025 18:34:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 26 Apr 2025 18:34:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 26 Apr 2025 18:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jc3EAYzZ/cso7z7dvbIRGOrHOyxEInwzcRlS4CNz7FRJWR5ZIgi6utUe1dILVKPIdwwe3ElWwsdzwX8KuRLBe/Ftsx9AEDPFOP+SkHpKKKI7It/zwa2Ms3hfeWk8pnxOA44Iw9q8c69830jeNM+8/BkKWtU77iNRjjnkQGAx+IULccocNGJkeXeYyNbplfq8FxO5pH/ze1jwJBa/q0Z4DnlnpgKInuQw9D3rod6Q0kkPvlo/NTI/wh53mOLRGpZZFK/d1Ul4UziUKCP00jXXJC6ZS+P3kc/GCUWjGW/MdZWyMS65+qz4qtueyVPtw81x+j+AJ0t/FV1SfNUVLK6gBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpS4QGWxqbkPRFWLa9xjo3hnw5hbKugq7wnYZs1UaHI=;
 b=FkvB2RrdWoA9Kb5QRHyLWNgTRCi+WK1euifs5HrgXCZkB+wT62ZpYtf/pWG2VhmucgbIZDBmbO0lwNs4ZHfK4ikRYJmfr4ypMnYG114j/cpBUlKB/6XcuUEtzL3Ro2+sI/A+7qUFSRVFP9HTZHN9Jmn43uvXzm3ZYgxeIe2IdPXUlYOEGkuonBoXMQdCT2s+18TELzpE7oxuiR/5IpdBMER1me18Tomj2Tp1ZTvauHMluutQ4VXj8+8HrK5TB6NLH46hAMMx/i6XfyZqCxAkbN/3KERbxQ6wYHmc3FS9s7Fo+/5jYHEjnMXPbaadSEdmctoAHtg/q1TtvbgVusWSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sun, 27 Apr
 2025 01:33:56 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 01:33:55 +0000
Message-ID: <2397c399-49dc-4d16-9463-3b7c9c418cdd@intel.com>
Date: Sun, 27 Apr 2025 09:33:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] memory: Introduce generic state change parent
 class for RamDiscardManager
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-5-chenyi.qiang@intel.com>
 <402e0db2-b1af-4629-a651-79d71feffeec@amd.com>
 <d1a71e00-243b-4751-ab73-c05a4e090d58@redhat.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <d1a71e00-243b-4751-ab73-c05a4e090d58@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1024d329-ab68-407f-6331-08dd852b931d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHd1c3Z0ZFZRQmd1OXg0cjdvbi9EMktwTHMrMmdXT1ZMNnRHMDFISy9sSFB0?=
 =?utf-8?B?NVBzT0FGb1lHSWdrM0MvZlZyRXd2L2VDVVBxNkIwdzFNM29JYW55TjkxZnJs?=
 =?utf-8?B?Y2xLSFE4SkJneHlwY2xkcGZuUGdRZ0syWmhBRENnRUsxMXR3SzdWbVRZSUov?=
 =?utf-8?B?dW1uNFh6OE1mN2ZWcTlLdEdVcnFDN0dESHJPTHQ2ekdRZ3hUL2MrZTIvYWVT?=
 =?utf-8?B?MVZiWVl4Q1E1aThxcVdVcSs3QTkrU3pYTEdzRk1HWE84REJVQzZQQTlGd2FH?=
 =?utf-8?B?dis1REJMV2lnZXhBOU5CQ3FxcWFvNTZRcmk0ekhjajFYbjFLajduU0U2bzVw?=
 =?utf-8?B?OGFCN3Z6b3BZV1lIY3I1YXpQcjBIZEttVzhNVldnYU1WZXNCQVBzdnZnbHZG?=
 =?utf-8?B?ZGVSY3Z6L3RKK3VmTjE2WXB1YjBlZE5GeU9lN2lXc3RrcFNXMTVrVC9nMU9m?=
 =?utf-8?B?dW5SemZJajVnNWZpY1poUDVpSWQ1bWwzWFJsZ1V5SkdVWnk1eFpyN2xlRWI5?=
 =?utf-8?B?VUpIR1h1RjlSMHR0SG1VWmkzbWdtSUdhOU5GNHFuSUcyalZyNFVWZmRNa2dY?=
 =?utf-8?B?Yy9saStmZUd3azlJcFh3a3MvSi85WnYyM3pjdWVQVUJtbTVxN1dxd1htejZF?=
 =?utf-8?B?bEtlNGFzNzREMmpoN1NBNU9NTGNxcW1uSTRRRDdNOVNDUFcvcjlOenczWGYr?=
 =?utf-8?B?RVd1N3o0S1Exemt3VzA5NzJNVHdlZ3ZRMjlTYk8yTDF0QjV1dWdZT1cwakZa?=
 =?utf-8?B?YVJyQjljdDUyc09BZFFIb1pXTG1wUkJaR2VCRWYrRjZmTFE4WE10QnV0Q0hk?=
 =?utf-8?B?TkZUdzZsL2lGVHRzT1lmaFM0NWh0cEFBdi94TXQ3eTJMV0tab3BRRGVhelI2?=
 =?utf-8?B?YWd2bHlDUnlqWFRwWFJrU01zZWZxZnQzeTRCRUNIUzlwTHE2Ti9KR1h5ZkNk?=
 =?utf-8?B?QWNtbnhYdVdCcnhPUExORTZUcFp0d3hHeXQ3TlR5alpDUmlDY2xNREJqdklU?=
 =?utf-8?B?dnQ2VWhTcTdNSGxqN0t0ME4xL2MvbWovNDFoNzNVYzB3WUlVSEdvMm9PMnJT?=
 =?utf-8?B?MElMWWY2Qm1yaEtFYXF6eVRGS0pBZE9zRHZXQWNONzJxaGJSR2tmcGduVTJa?=
 =?utf-8?B?blJ0Sk8yNXZIUnBsZEliZk1tWThPSXpDMk5OM2NJMnM1a1p3YzJ3TWNhbjEw?=
 =?utf-8?B?UXBWSDVheTNkOGdac0hrckY0c1dtVGhwVXJMclpQVFFQTkIzYTJvUjdUUWoz?=
 =?utf-8?B?UnBUZnFFZGVSR2ZIL3JLd0lHbmFxcHJoYVdzYWZuZ3hIVHA5dkFnMEtJUDVa?=
 =?utf-8?B?QTFwT1JyYlRTcXdneW9YbjB6eVRvVjlzTFQ3dkgrYjRPOVVWLzNaSjJyQUht?=
 =?utf-8?B?NFFyWTIzdk9Wbm1aNEFoU2FhSnV3WDBDMXRoenVNRmJVd1dHV0VkT256ZWxK?=
 =?utf-8?B?UktDU3VrMm9JVWUxWXBwUGg3eExuUXNmRjY5UWlYSXFZL2hZWUJ6UnkzUlhj?=
 =?utf-8?B?ZmlqRkNlVHRyL0N2NUFzZFRGRTJQdTBaQ3hPU0FDeHhWci9FbEFVS21UeUVu?=
 =?utf-8?B?Y0tkbEFzTmtwS1NSR0Vid1lOOWF2bDQ4aTBxVTF1T1hUOXo4eFk0QjR6aVlL?=
 =?utf-8?B?R0kwcHNMcHh4SEJZRGhEQ2N5N0V6U1BuSnpyTW5GWFFvSkVqN0F2UnU5bkth?=
 =?utf-8?B?N0RjTFgyUG5TKzZGaEZOQUdXcWl5OWpQbHd1QUdmKzR2OTBzekMxemZNd2wy?=
 =?utf-8?B?VjFEUDVWMDh5Tys1b3RrS3NOOTdBSnlFT3NlNTBYVDFTVEFGU2VQaytwUVU2?=
 =?utf-8?B?ZEFXKzgveFpWVHRBUE15ZEtlWW1CeU8vNGJpTzM4SUhFN0R5Z0NscHcwQXU5?=
 =?utf-8?B?OHQrVUtVRWJ0OFdJUjEwOWtVeGEvVXhiM2ZFTGpPTTBjaUcxK2ZlTGJJNU9R?=
 =?utf-8?Q?Af57/MNwKTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdSSzl4T1ZzTFhDKzZVdkt3dlBORC90cEZTY0FxSVZqRjVOU2VJdDBva3lK?=
 =?utf-8?B?aGgxL3E4bFd2S0RrT3pnaDNlbWkvSnJIM28zU2ZDcitRQlBORXJySlRvMWdQ?=
 =?utf-8?B?elo3aTRTUFNMUkxHcG1QTkhHOVl2WlB6bWZoRGpKSGVQNTl4bzRCb2JROVhQ?=
 =?utf-8?B?SlNPKy80RWZXbXVFWlRVMDBEL3dYVHZ5Q094VlU1cCtmNXN3TEhjUFRQY2k0?=
 =?utf-8?B?dkRVUEkycjliWldTL1NaSXo1aTZRQWJuQU9LQTFDY3E4eXNTRVJjS08vS0pz?=
 =?utf-8?B?bHJyU1lxNkZkR1ZDWXJjZ3pYTGs2M01Obk1IR3h2SDBkcWhRcUxQc0dpNlZO?=
 =?utf-8?B?ZXR3ZGJtZzVTVG01am1FVG9aZzRvODdURm1SQ1J2bCticVloV0V4MGRVZDFp?=
 =?utf-8?B?MzRsVWhBaVRxTXk0Qkdqc2Rlb0UyaUd6NnNZMGVHNGhYQjNEK2dUN0hicmdE?=
 =?utf-8?B?UzFoSG1VbXR1VkdNVHY1YkUxNzRKQTJVZi80Y1RJcXJpOGd1QmZPQmQwRlJ3?=
 =?utf-8?B?ckdRYlBHR2tJU1FXbnpYTTB0ay9QU2JYZDVNWTZ4ZTd4TkNWa0ltYmxJT0No?=
 =?utf-8?B?dERKaVJnbWpUQTg2UkQzY2NVQjFMbDBvVzVwQzRNNDE4QXFjTUNlREt4bXh0?=
 =?utf-8?B?aGpYejRUK0NadmZ3bFgzUkw4bFBiblhxZWRjam9WWStvZ3RtS0N6U1dvaE9j?=
 =?utf-8?B?bWpYaVZvS0ZZS2FOQi9rNGhKY1FYNE5CUXVCcUdTcjRKZm8ybjVUT240d1l2?=
 =?utf-8?B?M3VDaEtLN1hQaVhwMTQ0QndleWtnSUo3Z1hHTVlQL0lkMTVqcTU5TldmeXpP?=
 =?utf-8?B?b3dpUklJMzliVkpBNmlHQ0lQaVYwL2JLSDVERGF3dUF6cGZpQzRNK3ZYN2dN?=
 =?utf-8?B?dFVaUFd0NkdhUDJaNFF3TUEzcUpWQk5zTHFKeXQ2cnRPKzM5QXNJVDZWMGVi?=
 =?utf-8?B?RGgxaWVKRkx6eGdXR3UrdkI3Mlc1dE84eGlYcmEwdkRvWFR5aDQza3ViNUhy?=
 =?utf-8?B?aVNEN2VPR3ZpaC9ka1RMeVRVUXRPTDlNZjNnNWcvYWdjSVFSUk9WRExDOFg1?=
 =?utf-8?B?WjU2VTdpNGJobmJwY3MrbUJUbFB5bVFkRFdQVzRxQ3YxQTdnL3BxVUl3VFVU?=
 =?utf-8?B?eGprUTkwakk1Y0FzUzlrS2FxZTlQVGRkeXdJYlVEbXBZb2ZKcE93VnlEZ0dH?=
 =?utf-8?B?SlJtcU41M3BKNmNTWE5iOHNrTzJRVEtmVE82Um9iYlRSZ0IyZ0QxbU5YWFl4?=
 =?utf-8?B?OU40OEFEajBEK2hwQ3ZwM3gwTHJWWmhPUjVZTHFlNktYMitWZnRKeG9lRm8v?=
 =?utf-8?B?cFdaeEZDYUFOQjFvNEVHd2gvS2ljMVBqKzVoSkVKRzZNN0RUcTRRQWlabUJy?=
 =?utf-8?B?c2V0QzErMUE4MDJCeE02b1JxeHFGRHNzdUVkbncrK09OcStmK0RnOUw5OExv?=
 =?utf-8?B?ZXNPY3BlelJHZHl4blJmY1ZWaE9GU04vZkl2MHJCNmlzRVdlekpXaVpRSjZw?=
 =?utf-8?B?YXFxUEVub3Jqc2xjNjNtWmtrMzRaSWY2THZOUGdlSmRSR2o5MlJzcG8xMGhS?=
 =?utf-8?B?UllCS1FBSUJoeC9Pa1orQ0pKTWJWRFUybWs4RWZ1U3J1Y2hWLzNZQW1vdytP?=
 =?utf-8?B?U3lWZlg3UnpQbGpjQ0xrNFgydUdPNFUzYXdZbThXZDkvSjk0VEZoakVYR05o?=
 =?utf-8?B?Zm9JZG9KNzZ5cDBkZE40b3hNOUZrZG9Da01vQTlBOHM5cldXbmJ0NjVXQVNC?=
 =?utf-8?B?VW9kNFVOd0RGRnp5RVpIQlZTZXo3Qk9GSHQ5dTFOQm5lZXNOZ3U4cENQbXEv?=
 =?utf-8?B?M1ZsVUZCRmhHeWV1UGd5ajJEUFBtWEVWSTJiMW45eERUWVhyWHEwSTRQQXZG?=
 =?utf-8?B?aEZhQVh2WW9DS3lJWW9lZU5GR1AvYStqU2VMUlBoRVJqejBHRFdXZGhuNVBG?=
 =?utf-8?B?RUsyRytBTGhUNG1XaXdyTUtJWXFtMXhaM3AxREhMR2VoaUFyY05WYVFFSWQr?=
 =?utf-8?B?d1dwREpjTFZlMnQwdHgzQlZKYk1tenFoOHNKM1g2Y1lETmkvRTRFOXRmOWFy?=
 =?utf-8?B?UlVxOEkvV25CTUlBYTM5cmJRbEE4NmtEb2VrRHRrd1FiNWxQUytSOXNDWVhi?=
 =?utf-8?B?NE1haFlJVkxlYlZJYndkZ09CL21vRnpyd0JNZDA5eEtpYjVpUzVHK3hoaWtE?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1024d329-ab68-407f-6331-08dd852b931d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 01:33:55.8034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG+yW5Qb3fd7kigSe14KdZf5IsWwwL5MrSFP59uh30RQiCYI7RFE2H7UAQXLTjvw4sUFrFNdR5VXJu7yLI3b5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks David for your review!

On 4/25/2025 8:49 PM, David Hildenbrand wrote:
> On 09.04.25 11:56, Alexey Kardashevskiy wrote:
>>
>>
>> On 7/4/25 17:49, Chenyi Qiang wrote:
>>> RamDiscardManager is an interface used by virtio-mem to adjust VFIO
>>> mappings in relation to VM page assignment. It manages the state of
>>> populated and discard for the RAM. To accommodate future scnarios for
>>> managing RAM states, such as private and shared states in confidential
>>> VMs, the existing RamDiscardManager interface needs to be generalized.
>>>
>>> Introduce a parent class, GenericStateManager, to manage a pair of
>>
>> "GenericState" is the same as "State" really. Call it RamStateManager.
>>
>>
>>
>>> opposite states with RamDiscardManager as its child. The changes include
>>> - Define a new abstract class GenericStateChange.
>>> - Extract six callbacks into GenericStateChangeClass and allow the child
>>>     classes to inherit them.
>>> - Modify RamDiscardManager-related helpers to use GenericStateManager
>>>     ones.
>>> - Define a generic StatChangeListener to extract fields from
>>
>> "e" missing in StateChangeListener.
>>
>>>     RamDiscardManager listener which allows future listeners to embed it
>>>     and avoid duplication.
>>> - Change the users of RamDiscardManager (virtio-mem, migration, etc.) to
>>>     switch to use GenericStateChange helpers.
>>>
>>> It can provide a more flexible and resuable framework for RAM state
>>> management, facilitating future enhancements and use cases.
>>
>> I fail to see how new interface helps with this. RamDiscardManager
>> manipulates populated/discarded. It would make sense may be if the new
>> class had more bits per page, say private/shared/discarded but it does
>> not. And PrivateSharedManager cannot coexist with RamDiscard. imho this
>> is going in a wrong direction.
> 
> Agreed.
> 
> In the future, we will have virtio-mem co-exist with guest_memfd.
> 
> Both are information sources, and likely we'd have some instance on top,
> that merges these sources to identify if anybody needs to be notified.

Yes, that's the problem. My current proposal is not so abstract to fit
for this target. In my proposal, it tries to create a center for each
target. For example, virtio-mem has a VirtioMemRamStateManager to manage
populate/discard states. guest-memfd has a GuestRamStateManager to
manage private/shared/discarded states. That is poorly structured and
would bring a lot of duplication.

> 
> Until we figure out how that would look like, I would suggest to keep it
> as is.

OK, I'll revert to the old implementation in next version. Thanks!

> 
> Maybe, in the future we would have a single RamDiscardManager and
> multiple RamDiscardSources per RAMBlock.
> 
> The sources notify the manager, and the manager can ask other sources to
> merge the information.
> 


