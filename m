Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74F2CCD18A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 12:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7v7c-0003E9-6m; Sun, 12 Oct 2025 08:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v7U-0003Dd-Me
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:24:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v7Q-0001x4-MK
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760271849; x=1791807849;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PmmgZxyJrMRxXexoiABGtvRS9Fy3Snso2rYEXGQt3A4=;
 b=EerdN9KSieOhr6U4qNoOVKImE8KUoc2aFkOCnpQe2gWAd9v02R9JLRBS
 QIET1SKMF/sEUDQZYd5avw0MyVLPvr5c9gRWG8bLlMrHD7jhd9JjTV/1Z
 0qifZsKb4qlvGUT8XJaAd8Re23HlPGbpZjjBn1TR17wNsMV43y/gbny1U
 +zBPpaDwrdb0Arx/Kzwn4rG+XAwvo9UOvJLtahWDOUT4Czk6AsC4oTKHG
 kVZK3fVrpFhrbao0XjrdVlKNXnyY8AfcYQAVAS9qhzelkpe+F2yPTwr/j
 AeSRnbSFJ7uf+Apdrb3ebeA/pP9Pc4FsWKR4ZZNJiWhdkBvDXuUygbE5x A==;
X-CSE-ConnectionGUID: gKB6x50GQp6YOz14Wh48dQ==
X-CSE-MsgGUID: fBI++jp0QT2f2paCpVXm7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62126467"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="62126467"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:24:06 -0700
X-CSE-ConnectionGUID: unpPBi+UTnCiIfeXlVn/Yg==
X-CSE-MsgGUID: tR8/VM3cQxeomJpSDFzrlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="181790158"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:24:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:24:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 05:24:04 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO3a/1Ahu1BfQb7FtMdJihTCXKi/SYngBCbgC7BwLMpCSi7jz8sKY35I2WZHKw3KeiDcnfyor3X/EXl7P8uKdsSBTRSVY0Z2OvC5wFuNnvcqaWbMKAW/U2d2azCqGN6jljNFVvIqVreYS0ULx4jo+XUUMP4IW9bd008t7/41SYuEEXJ5DPl6J7UmYr+hF+SVjg8MPpQbqVwHnUJc9eJw6lwzBF+wZxyWR5OmB/x1eEu4TjVKMFh7rerpTMd0+ODQPGEXpz5HKx+64OWjeGkvzN6MuMd6t+vpMv8cD7IhzsjpLuINdPuqqNjH7v2PuMwqadS+CzwtVQ/VCYIVWYLTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JXnAKa2D1tytGXdYbLraT7SHWIoU4hNOdgdk04QPX0=;
 b=lZn+MiYNRGIwmqLvaqgbwL+0U8nMCO7fNKZx38QSGfuhNrzYJs8zKQPlfMQMZ04vpYqhkS8fJnNNyQkt7PGrhTWtuCg2OblsR0Fuy97TmSGx7OceC0hdzr0Za47ud+PTe9Gu3lC4L1ZKcmS9iGcM8HrObnsSuVfgB08oitLgRNv8GtGH6JSgFnq4X5VzkW27nwrYZN5jJNVOzA9eRIdICTwd1LZzU4PFR0ojKknu8z+lkus3BqJvC4CTzOKmoEzSuugLBm2qIWa76FneRsLWKE7/8dhjtkljJipebyOZ1J1ecX8+ALMJ4esKRS3IEAnMSc8qbQpWbQRdW3tFUfG3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by CH3PR11MB8704.namprd11.prod.outlook.com (2603:10b6:610:1c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 12:24:02 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:24:02 +0000
Message-ID: <9b21869e-1163-44a3-9bcb-ef372ae4f02f@intel.com>
Date: Sun, 12 Oct 2025 20:30:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/22] intel_iommu: Update terminology to match VTD spec
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0037.apcprd03.prod.outlook.com
 (2603:1096:802:19::25) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|CH3PR11MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec3ee19-469b-4eea-f357-08de098a3a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q01yazJ4Zk9vN0JBTGVTbkRKMXVvQkhEakxjZ0VlRThIZFk4NDVzTzMvUGU1?=
 =?utf-8?B?eHlZMWRVcVYyWWpCRWpoRkNrTnFTNy9QVHpadFdzUGlaQy9WSHN2RUczMkI0?=
 =?utf-8?B?ZUR0TDYxNytIVXVTbkhYSnFrK25GREZQMWFROUdUeFdPcUdhaTRuK01iN256?=
 =?utf-8?B?djFpVFRtNncrd0NuOFFycUQxSXp0WEVkQ3FnbEhCUXBhSHJ1ZXFnZFd2cUpS?=
 =?utf-8?B?blBMakVKWU1QRmxKeXE5c0kvblRKQVBiZnNKdUowVUh1VDNBaUhCdk1PZnk3?=
 =?utf-8?B?azU0YUQ5MlRRdU5hVnYvTnBoVlJoVFE4ODdnK2MvRGVlL1ovVHF4c0Y4eGFq?=
 =?utf-8?B?eUhsYjhDbC9BRUFwTE9pdmp3S1N5V21zT3BvMW4rV0o0T1NxNGRkTmQxMlN4?=
 =?utf-8?B?blFPcFFqOUZ6Ry9kVWVERFdPRWliL2R4UUgvbndnRk00a0lZbkdGdGxka011?=
 =?utf-8?B?dTcyMnQrMmRGUk4vNmhkUURsZHI4Y2xMUVhDajNlVk53cDBadFpyZkR0cllh?=
 =?utf-8?B?ZGJzMnhzcjJsd3EvQWtKVEpFZDZSZVFvdmMyVUNJb2Q5SExxWXpuZXMyTGhp?=
 =?utf-8?B?RGhGZGxHNXZVdmJQVmR2VG8rSDlYN2EyMTJ4TkNncmFjM2JjazVxK3A4Njlp?=
 =?utf-8?B?WlA0c1AvSWtFU0tqL3VwWU5lb0tpRXFHNVFIMFphKzV4NnE1NVM4NGpoZTRM?=
 =?utf-8?B?SGdDRGtpT2E5WFljalU5T3hYQ2N1OUZRc0xWK3BxMWV5RjZBeGRBY25tSHBy?=
 =?utf-8?B?RThhNXJlaC9yVXROQkFMUDA3RFp5UjhXVWliclBsZDQ2YmlTRFF1VkpjWDBB?=
 =?utf-8?B?L1ZEWVJxWHFWRkhxc1VJTzNoSXBBYTFhaFVwWmt5TTdJbGxrdFV6UkhhalBj?=
 =?utf-8?B?a21ObXJRTDYwOElHd1JucjBieHRJOXQ3cFBVQWRFNmM3dXhsZlFiejhmZUpm?=
 =?utf-8?B?Uy85TGFyT1JBUXh6ZzgwMUlmM1NRRE92T0J2Q2VHK25rNTJLN0lMTDEzZk9V?=
 =?utf-8?B?Rk1BMHY5WEVGMXU4eDNBYkNmUHhNaU1QYzByNlQrVkc5a2V2eWpjSjllQ1dM?=
 =?utf-8?B?bEVkbVRkN3JsRGJ4eExkOXFsb1BqNDZvM3poa1VZcWZOZUpJaE81SWxOdGVX?=
 =?utf-8?B?d2o5eUdQbGdaOHk0UDIwU0F4d1h3b3lqdHE2SnhoL3BuaThSbWJZY29NbUZX?=
 =?utf-8?B?eXpTRkx3MnQzenpYWmJ5U3ptckFrRTF6Y1Y4WHIzSTV0TUcxd08vdkEvSk83?=
 =?utf-8?B?cG9UQ2o0bENqMWt3WHFqRjVUVkVlTUhEelVhQWJVK3hkUXBSUHkxTFQxZGVC?=
 =?utf-8?B?RFlnRHVldHpRQkJXMy8ydEw1alJpbEFHL0VTeVN0Z2IzWkdWQVpTbnVOL0ND?=
 =?utf-8?B?RnF5WWZzMVhUak93c0dPQWxYMmdxUWpKeEJtbDN6K3hya0ZNWlhTclNST1hQ?=
 =?utf-8?B?MzdYS0NtOVRSaEc4K2g0WG81dk9GUitLNWhYWUREUFlNTkJQTHQ2Q0xxbWVY?=
 =?utf-8?B?b0JJSXRVeWJ4SVNqZEVadFptRVRpdGx2ekp3S014VjVFNmtqWWZPM1hEUG95?=
 =?utf-8?B?UHRoeUk0bm5SWVkrUHJGdUNSSzJYNHZFWGZJZk9Wdzg1L2hKNGt1bGRFMnpo?=
 =?utf-8?B?RUVtMFR0RzhsYmVOT2JqN1pzZ2xod2paQ2RVWGpQTkdUdEsyWDdmcm1GeGdJ?=
 =?utf-8?B?VTR5MWU0WE5BRnN3UStUZVJnWHIwSmg1WnBGRmNpN1FwRVo0OW1tNkZsem81?=
 =?utf-8?B?TXBjTjNNbWpTMHlGdUloM2tzbXVndUJsemZqQXAxck9jZlJmcHNsa0l3cUZF?=
 =?utf-8?B?WHk5N2RNSzd3b0RoclA2Q0FDYTR4TStwcEZjcGVSMVF0VHRrdXpIb1dLTmxW?=
 =?utf-8?B?NTBjTTkrYmtnSFRSY2puVStCa2k3Q2ZvVTUvSnhFU090dURqR2hRbVIyQnND?=
 =?utf-8?Q?rpWktsuBO9v+9ZuGNOTC4yhXf2w1dlXj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRVbmpuZDV0ZXBrUTNkekNjTUY1N0tpTzYvY1lyZUY5OWo2V3paZTF1UXRV?=
 =?utf-8?B?R20vREhmL1hITmx0eVZvbU9iU2krRlVpK1J6US9ZQmFiM2JjT2VvZlpYZGh1?=
 =?utf-8?B?WFBPZ21JbUcrMmtvb0ZuenVTcmlXVGJPQ1dWdFEwbkFxZGVhUmRNVS9wWUpL?=
 =?utf-8?B?UnhidW15YUtXTnBEcUJ5WEgxVFlVaU92MW5LeFJLN2JhbmoxTVNQb280U2pk?=
 =?utf-8?B?SGpqWWNxaGRzRmxxQ01LWjlXYThJYllTS2NJcWJhUjhhNEZ5Mk82RCtoWUIv?=
 =?utf-8?B?aTFHOFg3RVFORmF2OE9JYnRXZSs3bVBYaWdBUTNpMkV2OHViNEQ0ZEZwQ2ll?=
 =?utf-8?B?QXdRU1Z4WHZwc0w3VlBwNWxJUmg4cWEvcngweXdrUzZqOS9Tb1pDeFJNZENa?=
 =?utf-8?B?dHBldXZXR3hEM1NFTXplcStIb3d5a1lsa1FvVE5KVmttd3BCKzJJTU9yTFZH?=
 =?utf-8?B?elZEMXg5bmVFQ3ZMbWJvUjRqK2dFaktlUUdpdFZGZndnUzA4UC9FTlA5M05P?=
 =?utf-8?B?ejAxYTEyOHhZK3hSN2hVNjZPODdsbGNrSTBBWTRvbUxjdEQrTnd4QU9uU0xB?=
 =?utf-8?B?eU9oUExLZEpCWFduSlBBTmNtZzNBNjc0aW5oY0NmeHBoOWtaSG1FM3VTekN1?=
 =?utf-8?B?U2VIdmludkNMMG5NTGExNmRTUEJXNU9zR3UyRElOM3N0eUlBTktaVnVIb0ND?=
 =?utf-8?B?Y0JIdkFZd3BJY3F5VzljcEtSL1hlNE1zRXJHV3hmaEJCd2taREp1eUdIVW04?=
 =?utf-8?B?ZTBHOWxocTlyU1p1Y3h3SVUwUk1UV3VRaFZXaUozMUhWNTA5azJmNzdUcm9M?=
 =?utf-8?B?eU9CZ3JQRmJob0ZYeGNvWmpITEp5M2NXNW5Sb2F2c3MxZmVucURqalYxand5?=
 =?utf-8?B?TzV5Y1EzVlNIVE9kTnN0TlVJTENrZk16L2RWbWdIbHN5KzR1MzV3M1Q1bkY4?=
 =?utf-8?B?NEhiNDhsRmhxZ3lQTHFLd0ZlaEo0TnZia00zZlBWUmN5MFNwR3NWTG10YmZI?=
 =?utf-8?B?aUZvdENxeVBCWHpRN1FDU1puR1NwT0U2bFl6MWk3Rk9lQU1nMkxtUDU4S3Q5?=
 =?utf-8?B?Zi81R2dyV2N2ZDQydWE2YUVHR2N0eGJTQWRlbmJBT1VvSko0WFptRWs1eFZR?=
 =?utf-8?B?em1ERnpNWE15Y2djZVlqZytmRDVYc3RhcnFyUnJxU3BQUnBRdFJORjdPb1Zn?=
 =?utf-8?B?M0t3UzIvNG9QOWpTNTltVEl1S2pwTml0U3Nld3I4NUs3Ry9GOXJjOTRWRGIz?=
 =?utf-8?B?STZYa05vT0RkcFhVRDhxOStRTWErL2dhdW5PWWVsaFppQ3NRUE1Fc0hNUmJr?=
 =?utf-8?B?c2RaY1RFQVR0V0hqR1IvVFRZV29scjFsLzR5WWdJT3NMUzM1dnZFQ2V3SktT?=
 =?utf-8?B?QU9iUjhibnZYV1NSMzNMZ1ZtZDJKVldQTERRaC9RQ25wVDFqRVNlZmV4VHYz?=
 =?utf-8?B?aXhtcEJXVS9qRTlZRldFTldaZ1dDdzh1dGVaemsvdnVzbHVtTEtaYU84WWFs?=
 =?utf-8?B?RDRhcXdNK0Z4UVhUakxkcDAydzR1Z2wzRW9hdkNCaHRXZnpmVXF2YTFqeUpR?=
 =?utf-8?B?VU15N283dFdoWUJWZ2JaNnlIQzUzWXRyMmtCSkloVG9qT3BvNk5ZMG9SUHND?=
 =?utf-8?B?VWJjNG9VRmVrZVI1V2dNQ1JlNFhNdzV2OUJrYmFhd2lyMWJQQW1PaUZ0eHlt?=
 =?utf-8?B?NzRPQTEvUit6SjMvdU81bVZWdS80T2ptU3dmaDZtS1Zya2NGU2k3Z21aRUlN?=
 =?utf-8?B?eVdkUWREWnJYRC9XYUI0RXJPZTNtb1d6U29zNkxFUW1aVi9Gbm40aDJWZzJ6?=
 =?utf-8?B?Q0Zrbi9KWk1JOG1CMHJKM2VWaXVjUk5ob3JXNjgxUjc2K2MvZDJydU9tUHBW?=
 =?utf-8?B?SzNscTNwV3gzeE4veFlUUkJYU0xsUVdSSWR5d3NsWUxyMHlKeU8yUVRNOE9v?=
 =?utf-8?B?cW9Zdm51YjkrdU9WT3Z3VS9xbS83bGJxaWQvK2FtS1Zid3cwaVljWU1QUHVa?=
 =?utf-8?B?cE10VjVrUVVCTndITU1VMGZJV01BZGNlOUl2dkZNQ3NvdW1NRlJLaGNyUWVO?=
 =?utf-8?B?cVR0ZnY2UWcyRkpvRTN6WlRjemp1dHJXRzZPMUM1TDYwVEl6cnMvOFJ5MlB3?=
 =?utf-8?Q?ayp5JIlzUlTiUwzd2jxdb4sGQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec3ee19-469b-4eea-f357-08de098a3a74
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:24:02.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmgvYDFj2Fqur6NitNgPr6iwiqRvS9UilW8P9LastxFHr2Dm92yDsGmB+d7h4c5QAlZ1zGiG2FYjtp4shELH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8704
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
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

On 2025/9/18 16:57, Zhenzhong Duan wrote:
> VTD spec revision 3.4 released in December 2021 renamed "First-level" to
> "First-stage" and "Second-level" to "Second-stage".
> 
> Do the same in intel_iommu code to match spec, change all existing
> "fl/sl/FL/SL/first level/second level/stage-1/stage-2" terminology to
> "fs/ss/FS/SS/first stage/second stage".
> 
> No functional changes intended.

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

[...]

>   
> -    if (!s->scalable_mode && s->flts) {
> +    if (!s->scalable_mode && s->fsts) {
>           error_setg(errp, "x-flts is only available in scalable mode");

just realized we don't have chance to rename x-flts..

>           return false;
>       }
>   
> -    if (!s->flts && s->aw_bits != VTD_HOST_AW_39BIT &&
> +    if (!s->fsts && s->aw_bits != VTD_HOST_AW_39BIT &&
>           s->aw_bits != VTD_HOST_AW_48BIT) {
>           error_setg(errp, "%s: supported values for aw-bits are: %d, %d",
>                      s->scalable_mode ? "Scalable mode(flts=off)" : "Legacy mode",
> @@ -4877,7 +4879,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           return false;
>       }
>   
> -    if (s->flts && s->aw_bits != VTD_HOST_AW_48BIT) {
> +    if (s->fsts && s->aw_bits != VTD_HOST_AW_48BIT) {
>           error_setg(errp,
>                      "Scalable mode(flts=on): supported value for aw-bits is: %d",

this should be x-flts=on. right? not a fault of this patch.

Regards,
Yi Liu

