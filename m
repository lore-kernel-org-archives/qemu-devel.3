Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC570CCD1A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp92-0008Ae-Mx; Mon, 20 Oct 2025 08:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp91-0008AD-9w
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:47 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp8x-0000fg-6V
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963864; x=1792499864;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IL23QZswcizeUNuzcON4/a7kUofMINo60syMp67rv1k=;
 b=nCDhdFP2yCDQmlMWy+Zisn+FfsIWkakQJQHSc89ZnEBIOncQww6QgQoB
 qmQboCpS1rPzIp06sIPR2YJzcfxu1dCW+UlJKWjylEnDp+zLDhfqj7TBf
 aW8IUM8EODthFFLV5oYNjoPA+v3PI0Yqy+4yFgwZCbAlMQ63C8kg8mWVp
 4pLIeZ0l8D5bj94NZxFmKR4ioaZcHJ2irtspW/Wova6lw3ErdVmBEipVE
 KC0zxF9ducGAI84+w2EeV2oIC9MX1V9tpfMG9NEw4tqDgfQXRyPXuQNQM
 2DO5fXDA7DVmT//uYdoHbmjU8S4oPEKZA8CsZ2+zgdvKr1iYgOhq8VhJs w==;
X-CSE-ConnectionGUID: dlVgBQGFQ529T95oM9xUMw==
X-CSE-MsgGUID: EsgibMzARw+aGnJmIdj2hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73367749"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="73367749"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:38 -0700
X-CSE-ConnectionGUID: Dw5mys5yTq6Vm2qtMLcfMw==
X-CSE-MsgGUID: LxA4FuKsS2i8rHVK71pHiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="214281273"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:37:37 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFHMbCIHmyPvlaRiqW1beNblLz08bbQUv2eFHtaehIQ8IcIEObOHaq/rRJUwypkM7NiMevodJNDW6yykdEM+/fztWGc8M/sYbC1q8ZNd7bFgunQ8HGv+NKge4p2yCb10ndP/jfXrCxU5566xImwImFWJUhE82x6Xbi4loBBpHjvXLTFnILXZUQaElQtigKhK2nXQ+0mNNedQjGC6NcnM2UomduZSn18YjD2GYjWmL+8IdNzPbfNwCHq8GgoGYOkjCChveKiBmXgI+apMgzewqQyhEvt3I8r0+79RnwweaS6DgpAcdiYQZYdfA0ShZoFclP1kM6LS264lkAQoz262Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpdHELwn/qebrwJSmkp9oalwJ8jmpi6E+V48ExtBW9E=;
 b=u5UKejYhe48QcSby+KQ7mnIFMYTVjmTR8fWU4J0cVtu1MopbenQHxtt1ppJ27U+s0N/gO0vzG5S6mqj/iTzD9t1qn0op+y7zabiyAxjzvjUl0lcJTcJCEa4TOJ+8xVxf+H77bsUvPtXvLsNNb/6yWStRGwv93bzUu47zxOjQvIXewjkn7HN2e+jxl+m9Cc7VtlW0If+gHj59SRlrjME9wglGKLt44juVNxEhtHSAxM4IKu7+NY4DWGkdew1Q9XlO/mMfgv1zJ53dcwDFJuXqV9w8gRgAY318qUw/ouNHti36DKCT9f6Hy9jYct4Sh+B6EIfvZaGxMfWSaDVmJaVFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:37:35 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:37:35 +0000
Message-ID: <a7a4131d-dfbe-4c52-980f-0d2f8f221023@intel.com>
Date: Mon, 20 Oct 2025 20:44:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] vfio: Add a backend_flag parameter to
 vfio_contianer_query_dirty_bitmap()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: ad36fd3b-a9f6-4531-a278-08de0fd571ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDVIM2tWekp1bENuM3pxZ0F2YzhDSW5TbktDU1JFbFEvY3RvWUpjV1U3TnhB?=
 =?utf-8?B?VDZVaVpNblhiQVR6UmtlYVNrRk1Mbmt2MkdPM3ROMnVCRWJHR2g0N01adVNr?=
 =?utf-8?B?TXZiTEc3QUxxUlVVMmp3T213UWN1OW85dkxKSmVpVG1NSEZXdGtZVVBXK0Rl?=
 =?utf-8?B?SVg4VVV3a1RleTNHYWg5dmUrTy9ROEk4N1VqZmxBaXhWU0pOSW1TQWZpUUZ2?=
 =?utf-8?B?SUY5OEU2Y0pQaVpST0JmR0lkbTNTTjBORmtDUnppRzIrOGNPeDhhQ1BpR21Y?=
 =?utf-8?B?Wi9memxGTzRoM2JSTE0wUE9pblRsVkVSTE5rUXp2b1RmdVFtTXBQdk0yUGds?=
 =?utf-8?B?NkVQbWxmckozeDgzL1BPT3ZvRkM4aGZ5TnpBV0JKMmxVSHRROEdDZGFEc25l?=
 =?utf-8?B?UjUxbnNoT3ZGWko5N1RZSVNhbDF5ZFRTSkdSR3JRLzJyZ1g4d1gxdy8wZ2dB?=
 =?utf-8?B?MEdCU2RSdXdseU1jK3ZlTUVWZDVHb0VWL1d4bkJXYjhwNWlCWVJTOUZBNjc2?=
 =?utf-8?B?NDBMeGVkM3VYZ2RJckhxck4vQ0hNNEZsQzRHMTBRUTZOQ00vOHBrNlRqNGow?=
 =?utf-8?B?dFdjSE5waWVFamo3M245eTZXVEVQUFZ1bDNqN1h2N3paYnVBYzliQlljZVJ1?=
 =?utf-8?B?bGEzaTBCclFtSFVvMlJWZEw1VFUvbXE2NkZ2cC9yOGhLSTBnTlZ0MTJRRmU1?=
 =?utf-8?B?cUNBVTBVc0lWeVY4WHNKSzR1MXVxbXBXQzlKVkFIRHFKemRaTUl5L28xTTdw?=
 =?utf-8?B?Uk1FeW1kVjU2dlQ2NThDTWxmU2U3UEV0VmVscmZUS3VQQ3lDcXdRZnkxYnNG?=
 =?utf-8?B?Q1VWK2dYbGs3MDdKWWpBemE0RnNaRytyZHNoOEpUQkNNY2Znc3VqVFBXUHBt?=
 =?utf-8?B?YklIaC9Yb0t0MTZpcHF4OVJKaDIramhJcnZRaUxVK1FPK3dTVmxFOTA0cTlq?=
 =?utf-8?B?bENoZnp0WTEwakNyK20xMGRWZ1hLVE92QWt1OC9XeFVFOXVJclpwNmtBTmla?=
 =?utf-8?B?dUQvR3I5QnRIMXQ5NUt6MkdYNmNSRUVTeU9vRVVhN1VYZURweVpnMFhVbDd3?=
 =?utf-8?B?R1AyUWs0TGpvOEwvaTVWWXFRSzNTODBtcGQvOWhLN1FnRCtzQ3Y2Vnpqejha?=
 =?utf-8?B?MG5GVWc3MHBMZ1JPakowQTJTd1dTOFJEWEtSQVJqV2pOTS9EeGVockxJbG5a?=
 =?utf-8?B?ZWZWVC9Qdko2dUp5MVNZK0QwMm05QlpoaHpPWWF6ZlowWHNKUGZBWktvQWpo?=
 =?utf-8?B?dVFvcmNBQ3hjOExjNVdXZXZsLzNTNllDUFRzWHU5NGlnT2s1RWg3M2YvVVhI?=
 =?utf-8?B?ZUlEbklvK3czTkp6ajhLbzBMenFLQWo5NGQwMi90bUw4MkVHdVh1OWtEamVH?=
 =?utf-8?B?R2ZpeFlUKytjNjJOTXN5cEViV3VIVE5JSUhMVTJFaGxmalpCelNZeVFZWWRk?=
 =?utf-8?B?aUZJMDVyZHZVcFRMb2hQZzFwRWsxU2srNHBlR0FIaTVkTlF3RUhTM3JnRncy?=
 =?utf-8?B?bnRUdE9aRHprNjkxekx6R2hmQkphRm1najdzK09PT0RWWThyRS9ucW9XUWow?=
 =?utf-8?B?dVAzSEVHNzFiSVdqaEJxeEpsdkZCSHJMVmR6ekU0UGJkZkViQS9wOUZyM1kx?=
 =?utf-8?B?Um5nMGllR3Z1UzUvb0NQeEx4NlJ4blkzdm15YXBUYjlVMUM5eXo2R1VtUWJF?=
 =?utf-8?B?WUl4RVFkSXRKZUdMZ3FQOW96K1RjcmFnL2NscWYyL1ZmSnhneHVGVlZwN1hK?=
 =?utf-8?B?aVRxSXZITEg1cU0rSG1FTlZLdkRmSDJiakJ6TVNaQTJZSjNUellKUWhYbU96?=
 =?utf-8?B?SEEvb0pkTkdzTEFpQlNoQ0h6VTdIeHNkNEF6MjF6c01hOHNKenI0TXREU3Y4?=
 =?utf-8?B?ekZ6SEplVjIzOGRYd09RNXkrd1Myd3ZsY3lMNVVsYTJNMkdSbmV6NDNhSVFz?=
 =?utf-8?Q?0hCBgK/mPUpA5t5HryAzZ7EYN1fd6wjY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZaNXVpSjFob0ZqVHdPMGVCU29vOWRkdVgvVUEwREVRYXIyV3c3eGIrMlhM?=
 =?utf-8?B?QkplMi9ONEZBRzdpTWo2YnJjK0R3UHJKMWk0LzV0L01FQ1dOU2RCODB4NGZy?=
 =?utf-8?B?Y2xPM3JsVEc4MFRPakhZdklDN2txOU9WYUY2cEZ2TEVBclYxS25KNGdaRlp3?=
 =?utf-8?B?R1Y0Z09ma0xqTmhBbTNqbU5pdkw3a0JQM0w3b3lEOVk1YnhhaGp4aG5IeHhz?=
 =?utf-8?B?SnlTRVVjUzNsMjBrV00ySWV5dVhkVitHYTZraUs3NkNUbERPb3BORjNNa3k0?=
 =?utf-8?B?QUFDcnNWVFBhRWxUdUtidmJMZTJVRzNQeFNweUJURHNxaWdDRHFaZEZXN1JH?=
 =?utf-8?B?TTQ5YjZFZlZlUWEvSDZUSkIwUUJjMTZKOFJlNjdkcTg1WDVhYTgyRlV1VUNv?=
 =?utf-8?B?L2JVOWZ5aVhTczI2WitjSUpCZmZ0N0h0Q3ZUM3V1UmtaRU9qb1NFOUxmemhN?=
 =?utf-8?B?OWI2SXViaXpjbjlJQ3RDRW52MTVYZjB6aXBuTGVYeDN5YWxYWGh2TzlDOWsx?=
 =?utf-8?B?dWJ2SDNMSXNZOUNaK0ZqU2h3M3dYT3MrNXYzLzdTclozVzZwVzZUdDRkU3Nz?=
 =?utf-8?B?Rng5aFJadXNYVnUvSlNwY0QwOHErQTI5bHlOV2N6UzNrZjE4Y3dhdnZOMGhL?=
 =?utf-8?B?QzI2RmJhVEpybWZuckhOT2prOFYxVVYyUll3eno1bXRQUlRua05VWkIzd29s?=
 =?utf-8?B?WXJJbE5JUlF4am02MVBEZC9MNzkxcG1Gdkp6Zy9ZSE1jNDBleXVtbDdpOEVZ?=
 =?utf-8?B?eFFxa2VHdGk0UlR1VjZwTTZuT2V3NjdtbWY4bFJHU2RGcEMrZGdhVDNjTVJZ?=
 =?utf-8?B?Q0VlTktQT2t4UGFXcEdZZXpVVDJBTUFkdUpQKzV4dlU1Y05IZFE0ZGlLWk1t?=
 =?utf-8?B?bnB2Y2ZIeEZjcStJODZUalZVb2xZN000SDVZU2hTTVg0UFBjT21UbUdvZjdO?=
 =?utf-8?B?VjBWdWQzMmJQSHRVQmxSSU9CUExuMVVQRlQzQ09YYjhSUGU1dldnT0hJTW8r?=
 =?utf-8?B?bEJ5YTFtbDdGL2RHNnI4U0tNYnRyclRxRUlmcEY3N3hKVE9oK21XelBxTmp3?=
 =?utf-8?B?R2ZEaXQ2bFdVTEZQL3JCUXdVUzRVeFd2SjE4Ty9qV0M0RWl6YU12QmFiaVJ5?=
 =?utf-8?B?Ny94Q2Rwc1hROThYZmgzdEhac2Y1SUVSTzVra1FIeE8vaDNuZityeW5xc1h5?=
 =?utf-8?B?elFiODVpTElQRXMyV3ZTQlQwT0ZLODVXRTdvQ0tXRy82a0M3SjRmd2t5RUVW?=
 =?utf-8?B?enhKbFd6WXhFelVXdW9YRkNuRVM2MTdjVWVhM2hLbVJqZlliMXZpTTdvTHJz?=
 =?utf-8?B?bE1YOVRCRHl2S2g3amx0OHpFMmVxeDhZdkF0OUYwVnBIRWJnZklkWlRUdXZR?=
 =?utf-8?B?MEZleGo2VmNtYnJYdW9UMjZaNFRqaTVVMEI2SjFUZyt2KytFUFdvVzJ2M1E3?=
 =?utf-8?B?ak8yQ1NuMkNTN0IyUHYvZk00S3ArRkh5R3k1WDhhSEVDenhSVFZIb3lJV3Z2?=
 =?utf-8?B?VlIyeFFuUWwyN2lSYUdwMzY4Wi9zMnpsRWp3ZzdLRG91dFdBOVFDN2daRUhz?=
 =?utf-8?B?a25JeTdDbDFFam9UZDNlSkx4RUR2WmJqWVUwSVdhVkxZY3ZvYjhKRzZnWGh1?=
 =?utf-8?B?SEUwTVo3amlya1FaODNrV2FsYmZnNWk3TDlQUEEyMWkrQ0ViTEM1WFZYVzZt?=
 =?utf-8?B?SkZPRitQQ3NQSGZ0UjN2d1Bhb2RrSVovbGpUcml0YXh0RVBObm1ZMk1NQXQy?=
 =?utf-8?B?SlMxeEVjWGpnWVc1dlE5SmNNUmgwcUxpVVU2ZjRQR3NQUTVWYlFMZnpRM3Jx?=
 =?utf-8?B?ay9mZlVXVm54WUdDVEw5WXRKQWkzaFFrZ0luMHMxQTBNWWp2ZldRWmpnL015?=
 =?utf-8?B?Q3RxWTI4VHdiQ2JKbmIreFFDWFpSSzgvaHhGdGxhZllwV0NUWDFNU3hQM0lN?=
 =?utf-8?B?MFAxa3VJczBYN0dSZnlmaEhMc0kxNTNiZWZwSmE4VjFvWkppWWM2Qis2RnRH?=
 =?utf-8?B?L1hweXdwVlVQWk5CRVljd2dQV2RYZHhuQitOSDlzVk1pd2h3dW1iaGYyWmtn?=
 =?utf-8?B?QmxDcDFPSDh2WDNKeUhtVTMvTERMaUw3Y3hHYldIL1FxZEVESFZOY0MzUWo1?=
 =?utf-8?Q?GEv7qxgEiVJ0k+MaS5GYybzBA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad36fd3b-a9f6-4531-a278-08de0fd571ec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:37:35.1371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+fkPvR0aeK6EljsLmUE/VWIKPkDd2wp+8vFQ66mceKmpadUFgmiL1l7b5pQ14+oOp6XEdztH7QH+i8x/pghPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
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
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> This new parameter will be used in following patch, currently 0 is passed.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   include/hw/vfio/vfio-container.h |  8 ++++++--
>   hw/vfio-user/container.c         |  5 +++--
>   hw/vfio/container-legacy.c       |  5 +++--
>   hw/vfio/container.c              | 15 +++++++++------
>   hw/vfio/iommufd.c                |  7 ++++---
>   hw/vfio/listener.c               |  6 +++---
>   hw/vfio/trace-events             |  2 +-
>   7 files changed, 29 insertions(+), 19 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index c4b58d664b..9f6e8cedfc 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -99,7 +99,9 @@ bool vfio_container_devices_dirty_tracking_is_supported(
>       const VFIOContainer *bcontainer);
>   int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
>                                         uint64_t iova, uint64_t size,
> -                                      hwaddr translated_addr, Error **errp);
> +                                      uint64_t backend_flag,
> +                                      hwaddr translated_addr,
> +                                      Error **errp);
>   
>   GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
>   
> @@ -253,12 +255,14 @@ struct VFIOIOMMUClass {
>        * @vbmap: #VFIOBitmap internal bitmap structure
>        * @iova: iova base address
>        * @size: size of iova range
> +     * @backend_flag: flags for backend, opaque to upper layer container
>        * @errp: pointer to Error*, to store an error if it happens.
>        *
>        * Returns zero to indicate success and negative for error.
>        */
>       int (*query_dirty_bitmap)(const VFIOContainer *bcontainer,
> -                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
> +                              VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                              uint64_t backend_flag, Error **errp);
>       /* PCI specific */
>       int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
>   
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index e45192fef6..3ce6ea12db 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -162,8 +162,9 @@ vfio_user_set_dirty_page_tracking(const VFIOContainer *bcontainer,
>   }
>   
>   static int vfio_user_query_dirty_bitmap(const VFIOContainer *bcontainer,
> -                                         VFIOBitmap *vbmap, hwaddr iova,
> -                                         hwaddr size, Error **errp)
> +                                        VFIOBitmap *vbmap, hwaddr iova,
> +                                        hwaddr size, uint64_t backend_flag,
> +                                        Error **errp)
>   {
>       error_setg_errno(errp, ENOTSUP, "Not supported");
>       return -ENOTSUP;
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index b7e3b892b9..dd9c4a6a5a 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
>       }
>   
>       if (need_dirty_sync) {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
>                                       iotlb->translated_addr, &local_err);
>           if (ret) {
>               error_report_err(local_err);
> @@ -255,7 +255,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainer *bcontainer,
>   }
>   
>   static int vfio_legacy_query_dirty_bitmap(const VFIOContainer *bcontainer,
> -                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
> +                                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                                   uint64_t backend_flag, Error **errp)
>   {
>       const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       struct vfio_iommu_type1_dirty_bitmap *dbitmap;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 9ddec300e3..7706603c1c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -213,13 +213,13 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>   
>   static int vfio_container_iommu_query_dirty_bitmap(
>       const VFIOContainer *bcontainer, VFIOBitmap *vbmap, hwaddr iova,
> -    hwaddr size, Error **errp)
> +    hwaddr size, uint64_t backend_flag, Error **errp)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>   
>       g_assert(vioc->query_dirty_bitmap);
>       return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
> -                                               errp);
> +                                    backend_flag, errp);
>   }
>   
>   static int vfio_container_devices_query_dirty_bitmap(
> @@ -247,7 +247,9 @@ static int vfio_container_devices_query_dirty_bitmap(
>   
>   int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
>                                         uint64_t iova, uint64_t size,
> -                                      hwaddr translated_addr, Error **errp)
> +                                      uint64_t backend_flag,
> +                                      hwaddr translated_addr,
> +                                      Error **errp)
>   {
>       bool all_device_dirty_tracking =
>           vfio_container_devices_dirty_tracking_is_supported(bcontainer);
> @@ -274,7 +276,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
>                                                           errp);
>       } else {
>           ret = vfio_container_iommu_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> -                                                     errp);
> +                                                      backend_flag, errp);
>       }
>   
>       if (ret) {
> @@ -285,8 +287,9 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
>                                                            translated_addr,
>                                                            vbmap.pages);
>   
> -    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
> -                                            translated_addr, dirty_pages);
> +    trace_vfio_container_query_dirty_bitmap(iova, size, backend_flag,
> +                                            vbmap.size, translated_addr,
> +                                            dirty_pages);
>   out:
>       g_free(vbmap.bitmap);
>   
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 404e6249ca..6457cef344 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -74,7 +74,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> -            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
>                                                       iotlb->translated_addr,
>                                                       &local_err);
>               if (ret) {
> @@ -93,7 +93,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       }
>   
>       if (need_dirty_sync) {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
>                                                   iotlb->translated_addr,
>                                                   &local_err);
>           if (ret) {
> @@ -209,7 +209,8 @@ err:
>   
>   static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
>                                         VFIOBitmap *vbmap, hwaddr iova,
> -                                      hwaddr size, Error **errp)
> +                                      hwaddr size, uint64_t backend_flag,
> +                                      Error **errp)
>   {
>       VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
>       unsigned long page_size = qemu_real_host_page_size();
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 2d7d3a4645..2109101158 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -1083,7 +1083,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       translated_addr = memory_region_get_ram_addr(mr) + xlat;
>   
>       ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                translated_addr, &local_err);
> +                                0, translated_addr, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
>                         "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> @@ -1119,7 +1119,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
>        * Sync the whole mapped region (spanning multiple individual mappings)
>        * in one go.
>        */
> -    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size,
> +    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, 0,
>                                               translated_addr, &local_err);
>       if (ret) {
>           error_report_err(local_err);
> @@ -1204,7 +1204,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
>   
>       return vfio_container_query_dirty_bitmap(bcontainer,
>                      REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
> -                   int128_get64(section->size), translated_addr, errp);
> +                   int128_get64(section->size), 0, translated_addr, errp);
>   }
>   
>   static void vfio_listener_log_sync(MemoryListener *listener,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1e895448cd..3c62bab764 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -105,7 +105,7 @@ vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32,
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>   
>   # container.c
> -vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
> +vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t backend_flag, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size=0x%"PRIx64" backend_flag=0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
>   
>   # container-legacy.c
>   vfio_container_disconnect(int fd) "close container->fd=%d"

