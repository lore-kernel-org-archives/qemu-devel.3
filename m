Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3830ACCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApAl-0002G2-Ib; Mon, 20 Oct 2025 08:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vApAj-00029d-1H
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:39:33 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vApAe-0000oS-Qq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963969; x=1792499969;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bzLHv/gVz2ZkzDVCHuyIcP7UsUJRiw+4+m3RtB2aUQY=;
 b=XR8B1CnieytJHrSgBksYSaZo8ofltu9iTwsbEp2KTwatRaEZDn1Ppveg
 Pb9pbkMgHqGuQg+aYUOabc7HpdQdcu4mJRl8Lu74cO99/pDAly9Yd1Bbw
 znQGbxhZJ/rdwzxB/lRb/bGVUGjoEJ7bL3xWMfTaD4FLoUMIqyGhOs4F0
 frd2UP0JhyziYmHFyRCxlUtPJx9ibyBl3Zu8OoBJODiB4rbZvJkMuVOoV
 bTo/9gR7gxWHz7Jv7ibYcUfKkOcH+L64emaprU77RfwdXo6Sch7faHz+k
 VvBtoX6/ZbHJaN2jIopgROb1wvIptYDPHBeC4xR9xp4MlB8wEWFDSBltH A==;
X-CSE-ConnectionGUID: CS+/lXM8RE+AUG7O96U3bA==
X-CSE-MsgGUID: BAvXuXx3RU6DojZ76SAmFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63222831"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63222831"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:39:25 -0700
X-CSE-ConnectionGUID: yvhsFZl+RLmqnIjRkAUA1w==
X-CSE-MsgGUID: KRmbLoG6TQenoWNm8m1SPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="188417380"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:39:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:39:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:39:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnLciRT38E2G/O9T93bS2tAVHTFCUjJdQj/VrbgCNigdTayL5NDOhszkpvnzescNPxSstjtYCVGVf5pNmUCAlRPN7DpKBi0BPrD6auOS7eFLi02j8ar1SrLHKaHwSv4r+ewlGZ/GpD/zN3jqJXj7WS6Pie0cefV3WiKnQ0lNzxmTzVy8w2kJKIL8zOjXV6DT/Nw+0NA+PVrfgWQ3YetsxE6PTDKNjZUbOc4Sd/3XdX2OXpfCQZdU7Dexi0S3wbN2deX6lhJss7hv5n20qTiQ2+en4xMyle2xVLXXnl38Cdyjn1PH4Om/60DbXBuv2HlrL1TiTfPzM7kdzw/wdxuaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK7Wz4nnXKK7mjtDi7bC8So/1NCNYqWMR6QnZvPhUOo=;
 b=wl81z7n2kFsCCWxhJ+iR1k3oQ27LIZspuuRvpiSuVjwpZO67DQX23l8z7UOcoj6qtVQXc/avVxw6x1AYjY7FD/DZEkLMTsNBVnwRM/FQW9ne65Qvs1dMi9hIRhtxsAFesbiWNMDCL2srLCXMAuDLWdLu9jBRU3l+Yg+O8QWnwLUDTtQllKeFyrvTRdQKdDpv3wJIfJ8ouX67RbriKNe4NoDvvy5NbhJdaJJ+wL1aYGbxrV0gdu1wFR7bqOxM2ggf2HCWlKHGZR6hsbA9dGHHMDUtPbd/fgORnY+fCE9n04yPvMI+a8g/Ru2scf7/JHe/EiOllujj0O/aWG3zJKPj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ5PPFB8C3A0B7C.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::84c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:39:21 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:39:21 +0000
Message-ID: <631f49a8-e39c-48ee-b9e4-f6cdc5633afb@intel.com>
Date: Mon, 20 Oct 2025 20:46:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] vfio/migration: Allow live migration with vIOMMU
 without VFs using device dirty tracking
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>, Jason Zeng <jason.zeng@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0039.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::13) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ5PPFB8C3A0B7C:EE_
X-MS-Office365-Filtering-Correlation-Id: 054d7bef-212f-41d1-8fc3-08de0fd5b13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2padis5UWJZWTkvZ0FLNjAzUm1BQVV1YXZYQTF2RzlZZUx0WCtDSDNCcnZl?=
 =?utf-8?B?aFU3cjJQQzI0RkdjRXVXdVprREd0MHQrbUhCWEZlR0hzV0ZQUytLdFlJUkxY?=
 =?utf-8?B?Z0hmMjRLaUdaTEFNdjNldi9EdVBRV1hqS1ozMGlLaTgyc2JQK0cxSE9QcnNS?=
 =?utf-8?B?cHI1NXRldXd4Y0pEa1VoSE5naVkvYXZ2V24yM3BrTS9FaVFqZFRHWkJ2cjND?=
 =?utf-8?B?aUVsbVhGeGd1KzNMbDFxMEpEdUJLTmJza1NBK2dBTE5DUjNvSExzVlB6eTgw?=
 =?utf-8?B?ZDlHQ0JrcEZuOFRGUTJNUEc4VHpHbktMMjZUQlBUdTBsTHB5YzJETXZGVXdm?=
 =?utf-8?B?K25FLzdSeWZNdFpjQUlyQUdzRGlQdVFMUnU2UFRuWkdQYWVSNmJKa2tKbm1N?=
 =?utf-8?B?T2o0ZFQwalozS0VNTXo3bU5iZUhpbGxkUDBjWnlCWXJSVHhtNDBBeVVRQ3NU?=
 =?utf-8?B?TmM0RURKcDBPS281dmlYK0pRR1F2QU9RbGZtQ0N0UlBrQVdqaUlDWFVaK29y?=
 =?utf-8?B?V20rdTBScTJ1UjduYzFRM2xvTnorSWd3RjlPdkwrdlVPcE03Z1NReGZkRnhy?=
 =?utf-8?B?NEZNK3ZTYlhIc0FVS2FGcnYrYW8xWmk4YnZSOHJqUXhsbW93RlhmaFlhWlA0?=
 =?utf-8?B?bEFzS3ZsSEtWT21xcFk4UXZNZ1ZDWWdMeDdTb2VibEVEQm9lSUVRL0VVVWZh?=
 =?utf-8?B?NFN1aEJCNlRKN0F2RDVoSi9DeFNXelFxRWNDbjY5Vi9qLzNSR2ZIbzJHK0s0?=
 =?utf-8?B?dWMyOWxtUGJEdDZkclNEVTBUOHRyckNTekVZK1FORGRVQ3k5ays0Z3hVL2lu?=
 =?utf-8?B?Rk5zOEYyODVFaG1DOWxuODFHb2FGMmZqT1lYVm9zS04zUHRyYlI1ZVdxQzFZ?=
 =?utf-8?B?TFVwRXdaWkFWV1NmQjFzNEJxWHVBVEdsYzUyUHBqU0xHVDdnZEZpWWszaHNr?=
 =?utf-8?B?TXFPcFluejF0MW1MYlpqVnRveExMUFpza25jenJzN2RoYkkvSVdLYlRHS1Vq?=
 =?utf-8?B?YkZob29BNUtmVk9nVEVtbnZxQXVTdnhWODZ3V3E4aWY3UjBkQnRuNXB1eTNO?=
 =?utf-8?B?b2JyalRzajZNVFpJN1poQ3ZsbkFCTnpwOFdZZ3hJdXR5MVpIMHlJSW96V0Fs?=
 =?utf-8?B?Sk8vUU1hdFZnWFZkQjU2UGxTNHY4UUs3RW5LM0MvNU53VDlvQ1dKU3NJTFlE?=
 =?utf-8?B?ZzZLNzFONHY0dWJORXNwWnBtbm9hV0dCN3FMVTdxUWFaNEQ0MWxLWEFKT0p5?=
 =?utf-8?B?anpPWUk0QVRXSzArQ1BNbGRvcnFSK0ZaSHBNU2tGR0FxWGZmNXhQRFJscVJP?=
 =?utf-8?B?eEYwVnFRUXBOOVRacURGZ2EzbGt1NlNiWFRBWU0wckZ5RndPandPQzd5eXM4?=
 =?utf-8?B?dER2aHdScVg4WjRKTVBuRVRxakhMUXpCYTlkY2JvcFIxRzlxSURGUjFuOWVG?=
 =?utf-8?B?ZVJOb1NvMC9zTjFJbWdJa3htZnRJRHVNUVFoemd1Qkx3MkVZUktzUVIrYllE?=
 =?utf-8?B?T0M4MkFNaGlOVG1hOFE2VldiWldjZjk4ZFN6TGVnUTdpd0hWeHRNd1NRQkNr?=
 =?utf-8?B?NC91TWtaek5tbG1sT0pQNDRoV3ZOc082ZkVVOERvOHI1Z2RnMkMybEt1UnVQ?=
 =?utf-8?B?S2dDdHdRUi80akFUcmlhTlJXMDRoV2YwM2I4eWpMZzEwMUJUdlFnTG9DQmoy?=
 =?utf-8?B?N0hZSXNiemQzYVpPcWVvQ1RYY2tRV01kQmM4cjJLR0l5ektCa0pVcHlkZU1n?=
 =?utf-8?B?cHJRZEVuOTZvOHcyYWh6UzdQcmUzaStZOSs5VENkZ0hUNmlGMkVRQWRmc3Bv?=
 =?utf-8?B?Y2M5SGNDQTkzVG1Pd0tkRzJYU1V3a0tPWEhhSnh2VW9FMUgvdzZFNWl3M2tV?=
 =?utf-8?B?LytCRDBwYjNFQkhhcjJzN0ZWRzhQVDJFRnRyelJmaEhzL0gyL08xRFF5WmZr?=
 =?utf-8?Q?e7mvKAoMQvX3nORkFxsLFIvUCVSERTjk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVFLeXl6RUc0bXpWcW5SelhQeWV5UkdiVEpCbXd2NVNZS3dUd1kzWDhPK1Yx?=
 =?utf-8?B?K1V0S0FtSkpRME9UczRydlhjVkRUL2VZbGl4YmFDOURqeG5vTGJmR0tUTVRY?=
 =?utf-8?B?U3B0a29TeDR2NDErMzVyVnE1RlpNQVNxaTI5ZUNzclZYeHl2ZElwQlorOHdL?=
 =?utf-8?B?K01qb3BIcGVpVFZnSGxkTW1ocE5uVmhPRlRzdzFlOW81a0w0cWZSWklhbXpE?=
 =?utf-8?B?ZmVLdzFXdEJySnVsMHFmWFVMSHIwMTNYajZPdHhCZEpieWhDcHRUUFBxM0F2?=
 =?utf-8?B?QjF3d0FtWitmd3QrS1ZTTGFmTUVNOWlUV2srQjIvM1N4Qk0yT1VGS25NVEoz?=
 =?utf-8?B?ZHljdW1DL1pFUitwaVFSalVrRVQ2cnIvazFDSXloVmNmcEVDYnhkNk1QTjNi?=
 =?utf-8?B?QW5TSXBLdjZINDJKNXNuYlBwa0R5dDg1MXArMnFBUVkrNWU0STBzRWkyaGd4?=
 =?utf-8?B?Z3N6b0NjS3FNaFUxbDJCbHQ4ZGtVMTNVOTJGRzRwUUw4dkRiTFNJLzFEV0N6?=
 =?utf-8?B?Q0dSQ1kzZjVvYUhoQjNpenpyZ2hkSnpMVHoxQkRYekVObk9TRk91TGp4VWFC?=
 =?utf-8?B?T3dZOWN4cmd4d0hqWi9NQ2kxWDR4SnpZKzJMc3pkNVRFTnBEajJ6Y1NsbU5Q?=
 =?utf-8?B?MjFLYWZTdUNDTll3MG04aVBIMnEydTBWOE5GZGNmazZ2VXJocm8wTzN1ZXlV?=
 =?utf-8?B?TzRQUWJaSHJIL1VFTlh6WlU4MUwrTkVUQXoxK0s5dHFoajJYdVNFWFJSYjZR?=
 =?utf-8?B?Z0srRVp1akdpdkw5SnlyYmtSR254ODQvT1NVR1pTU1B2VUVFY0JZNlpxMkxR?=
 =?utf-8?B?dSsyN0JBc3VBNmlSNEZZWEJwT3VrSitacmZna3Q2TGNySzdNNFFXajc0Tjdr?=
 =?utf-8?B?UkhTRjVLdWxnVlQ0NGZKdE5HTW1BNGQ2WVF1R1JaOUVYOGpsdjNDckExQldJ?=
 =?utf-8?B?M0FQck5CSWptZlJFWnBLcjEzSDJXdCtUSk51NThSS2xzYVZhWUNaNVN0dTRz?=
 =?utf-8?B?ZmlNV2tzbmxRUFUydGQ2NHE4U3pxOEEwM3R1Vjh4UXZ4TWJFWnN2ck81NDFs?=
 =?utf-8?B?eFg3UmNUM2c2VXpvQTFoYmFVN0lQTHVsTDVyNStOeEpnWVg5VVVoTW5tRGF0?=
 =?utf-8?B?SzZ6aG0rblVDNDBOWFdrQ1pveHJTdWdyZXE3NWVIaHQreDFPVEkveUdPZ3B5?=
 =?utf-8?B?Y2cwV2VBTUVwMnd5QWM2L2hWMGV0SUV3YzBtVWhUQWV5UGZ3OHJHYlI1Mitq?=
 =?utf-8?B?dldTZ2o4NHg5VkwxelIwbGdaM1NLM3FRamJ1QTZDTktEUE81K0NOTmlTUDg4?=
 =?utf-8?B?OCt0Q2FaK2hWYzFkNU14TEpXcDkzRkQ1OUR3dE02ckwwM2JSTktsa21PU2pD?=
 =?utf-8?B?bjUrNDMycGxweVJncUlBWi9QMDFHdjdGakc4eWhaNEFtNHB6WlhuUVFLQWhQ?=
 =?utf-8?B?cGNWUFhOTDI5TWJaeDA3aStTdjk1dmpYVjJRRXBsdFYyMThnd0FJNEhvd2Ft?=
 =?utf-8?B?L3h3THRWWldaY3NkYVVOY0tKSWdLMWt2eHByNC85UU5RZjYyTEtOM3FDOS94?=
 =?utf-8?B?d0xyckVvVWZ1VWVwdzdmOE0zYmcvY0h3ZVkyam03SVh3RkNXL0c3M3NMcmpN?=
 =?utf-8?B?VHRvMWZqVnpacE5zK0E1b01GK01La2dydElBcWlvTlJtZ3grMVkzNnRMaU42?=
 =?utf-8?B?WUo1bnlPeWo0UjV1Q2pJQkZaaU1va0NNRVJmMjYvVG13NktRVC85Ukh4bXJJ?=
 =?utf-8?B?NU80M1VwanVPaXlmdm5YeG9Lajc0bEVQRzBtazgwUXV4Y01zTXhDNkFyRlhl?=
 =?utf-8?B?YzNySDhySjZDWVZBS0ppK2N4SVpjRDJZL2dHT2IyWGdWWHltZklXUU1OZ2sy?=
 =?utf-8?B?NEt5S3VOckhBcExLVFBpR0N4bGVZWW82Qk1qOWpNL2FoUFJKZ1BDcVYzeEJo?=
 =?utf-8?B?cXhqQVFCVWY5MTBoWDVWb3R2ZWZkaG5veUordHM3ZFpacTVvZDZ6dHVjNFhj?=
 =?utf-8?B?eWI5Qk5DVUVsTGlEUEtCTHlac2RpditPcHNRdnRUQWJlUjUremlVWlZEQWFG?=
 =?utf-8?B?OWJqTVhVdWdBTE1IcGV3RWdxTkVXcUNINFR5UFNac3ZCZ1pEZXhpRW5uNHpt?=
 =?utf-8?Q?ogECjMSRWgChqeqrbI1WtpHdu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 054d7bef-212f-41d1-8fc3-08de0fd5b13d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:39:21.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHU+SLITvp99Sb+fDw8cAFSKCjkn8mVT2XOwDeKZedsiAFNSR1hcaVK52dK770LdMJ6dgdUtASgb7TevH4pErw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB8C3A0B7C
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/17 16:22, Zhenzhong Duan wrote:
> Commit e46883204c38 ("vfio/migration: Block migration with vIOMMU")
> introduces a migration blocker when vIOMMU is enabled, because we need
> to calculate the IOVA ranges for device dirty tracking. But this is
> unnecessary for iommu dirty tracking.
> 
> Limit the vfio_viommu_preset() check to those devices which use device
> dirty tracking. This allows live migration with VFIO devices which use
> iommu dirty tracking.
> 
> Introduce a helper vfio_device_dirty_pages_disabled() to facilicate it.

s/facilicate/facilitate/

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> 
> Suggested-by: Jason Zeng <jason.zeng@intel.com>
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   include/hw/vfio/vfio-device.h | 10 ++++++++++
>   hw/vfio/container.c           |  5 +----
>   hw/vfio/device.c              |  6 ++++++
>   hw/vfio/migration.c           |  6 +++---
>   4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 7e9aed6d3c..feda521514 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -148,6 +148,16 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
>   
>   void vfio_device_reset_handler(void *opaque);
>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
> +/**
> + * vfio_device_dirty_pages_disabled: Check if device dirty tracking will be
> + * used for a VFIO device
> + *
> + * @vbasedev: The VFIODevice to transform
> + *
> + * Return: true if either @vbasedev doesn't support device dirty tracking or
> + * is forcedly disabled from command line, otherwise false.
> + */
> +bool vfio_device_dirty_pages_disabled(VFIODevice *vbasedev);
>   bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
>                                            const char *typename, Error **errp);
>   bool vfio_device_attach(char *name, VFIODevice *vbasedev,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 7706603c1c..8879da78c8 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -178,10 +178,7 @@ bool vfio_container_devices_dirty_tracking_is_supported(
>       VFIODevice *vbasedev;
>   
>       QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
> -            return false;
> -        }
> -        if (!vbasedev->dirty_pages_supported) {
> +        if (vfio_device_dirty_pages_disabled(vbasedev)) {
>               return false;
>           }
>       }
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 64f8750389..837872387f 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -400,6 +400,12 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>   }
>   
> +bool vfio_device_dirty_pages_disabled(VFIODevice *vbasedev)
> +{
> +    return (!vbasedev->dirty_pages_supported ||
> +            vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF);
> +}
> +
>   bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
>                                            const char *typename, Error **errp)
>   {
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 1106ca7857..1093857a34 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1213,8 +1213,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           return !vfio_block_migration(vbasedev, err, errp);
>       }
>   
> -    if ((!vbasedev->dirty_pages_supported ||
> -         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
> +    if (vfio_device_dirty_pages_disabled(vbasedev) &&
>           !vbasedev->iommu_dirty_tracking) {
>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>               error_setg(&err,
> @@ -1232,7 +1231,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           goto out_deinit;
>       }
>   
> -    if (vfio_viommu_preset(vbasedev)) {
> +    if (!vfio_device_dirty_pages_disabled(vbasedev) &&
> +        vfio_viommu_preset(vbasedev)) {
>           error_setg(&err, "%s: Migration is currently not supported "
>                      "with vIOMMU enabled", vbasedev->name);
>           goto add_blocker;

