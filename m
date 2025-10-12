Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C0CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 12:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7vVE-0008IU-Bt; Sun, 12 Oct 2025 08:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7vVA-0008I0-K8
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:48:40 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7vV7-0004vj-34
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760273318; x=1791809318;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iCKfNsca6TQrODX1GPQpeSqhvIvSLIsSf2DdvorZk68=;
 b=XyRq4Xw6mKqknHmlKpPNVNV0zyGn8o+t2O4So92YbUPMX7icM4Lj7hqi
 FImqzXM30LIBahPcgUJvNHUyOYGe9ZqYd3H6n2oLEEsQrObsYegD9H7cM
 TuSNSBXijOHKSDbukhLPG47vL/ucnt6uurIqtxjpn4q9VVtvnOlpPsX+e
 cu6so7tf5pRTdJI7V5uoQq/Uyw+R2zkgL8ooGCJzXUo/0qkPTijbYAJp+
 m9DXiU7dJ8f87PJp0A/Pg0C1ahZxIxKm77A8BOFx03+Tz2s5ec0Mnz5sq
 uuRjzKILMoeCGzX0+77kPqvOZUKwQFuPq72XTu+NbxAOqbuCNErasPQG6 w==;
X-CSE-ConnectionGUID: V1QQmLkOS2i+BaVip5PC2Q==
X-CSE-MsgGUID: JgynTR6lS/S9nFgPufUCZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62582525"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="62582525"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:48:31 -0700
X-CSE-ConnectionGUID: FMo6yqFaQeeXRdAFwGZ/bQ==
X-CSE-MsgGUID: 8oO7cidbSOGDnvEI21wOUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="181047865"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:48:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:48:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 05:48:29 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:48:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENPFYk0x1NvrQNSjx+X0AsWkcBXS7WEfMyCR+0NEH3w8r0IoXJgzlH7DUowN2BvrO2ppXeNNet64gs8yhIz/zdsuJSWsjIVJcuTDobRqc0gzmCEGYEwIePZeoRqBUBhiO8wlGcLzwq+msg0teb0cT8VnOwy3XkjjZUqC1mnsQBHNgarT1ceJSPfTcQNhRgdw7Zol/P1z902bVnMipVDRjqIkz9Smu5XHtfQtdD9xQN532OK3q5hsLTHeDgE4lwF464+UEAkSmCCceHVs6Rb/4xXbNqsmiPc5Yb+OUClI9qyRwzZMiGdjcIYsLA8NPO8In78kiN3I1r8tR9ma30w0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXwZDwlqH2+ZT2xIvhHFqPmcjJwV1PorX7hQMZj0z8s=;
 b=wJCp+FBjxanDgZjrs/F4AxkbWz/oyIGIaKyMnlyW5TV+ampZstY7MEauq6ox8hVFcSZG2yHSYS5TlO10izxzRXDxCBFzXBtYc04x3B/5u1FYh3v4wHvaq13KfAK1RvcNYgn0pcjB0P+9PEKboXclLpp6/Y9//4MjoyWnRrt7JaT17wQDq/LhSZCJnxTn4FdQ0sEfQdFKaOjbVMMgEDZtgW4k5WmX1wVbRso/rLcfwN7S5UfQ1NwwPcC1/Yqi7ZWoDmaBa0tfcMOUaXQh6T1NVPrfrj8ESamNJhzvSd9EdOjSozdgvUyaT8oH/rLdtEKwwNgKAblgQMCE7ErYihM7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by CH3PR11MB8702.namprd11.prod.outlook.com (2603:10b6:610:1cb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 12:48:27 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:48:26 +0000
Message-ID: <3b920606-8550-481f-8f96-77d0605d2684@intel.com>
Date: Sun, 12 Oct 2025 20:55:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/22] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-11-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:d10:33::9) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|CH3PR11MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fdc0b1-96a4-4924-6255-08de098da2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjhiSEFBbW9sdms0MURrM2lYdmZnMEhORDFyUXVMUEFBaVRPYUlWNVM5bWRC?=
 =?utf-8?B?L0IwL1JmQVJ4SFlwNjg4SEhPenprbm40OXJOWWVleEpDdmJucmtjcjNyVzNB?=
 =?utf-8?B?RDhPanh3aG53enF1NGhTNktXVVlZeEEyb2xYZ2F6SEJPM2dOVlBjaEkrYjkw?=
 =?utf-8?B?aXZFbXY2ZUJacTB1Z2pRbFBnQzRjelJMZzVMK1FxVEFzZDMrbG1wZk1Eay9Z?=
 =?utf-8?B?b0VPVDJ3cithRmJBUW1TaWExUmNMM3BLQkllUHVuMDhZWTkvTXBEdHgxbjJL?=
 =?utf-8?B?aXM4V2UzSXQ3WjFWUUdreVdhM3packx3WWRwS2o5V0pYUFRubFZYZlhWZXJ2?=
 =?utf-8?B?UWV4VlF6TVB4RVY2bkwxcTA4SXhWNEVRSUxCampVc01wYWtHek5RMWtwcEdH?=
 =?utf-8?B?cGpteHFocnJRTU1ONmRKUUdFNklBQ2I2amxHQmE5S3A3eUV2NDNrUS9pMENj?=
 =?utf-8?B?TXVJU2NnM1pvZDYwUTlMZ2ZCRk9FNjNPWXhSY2tPbkFZYzUvY2xRVGI2UHV1?=
 =?utf-8?B?bHhYOUR6cTlGS2U2TnY0VGNvV1k4UGw2a1lRNXdoVzJxWmxSSXd4ZUpxVEUr?=
 =?utf-8?B?cmVuT0twRzl2ejlIZ3R5YTlGbEI5S3pXVHo5WDJ1NUJadS9aOVQvcGtnQ2Z2?=
 =?utf-8?B?T1pFRXA2UGlzK3h5dFdEc2ZyZzVVU09oN2VRTkV5ZVRUTFFwbk1Gdy9iS0dz?=
 =?utf-8?B?dDlkNnVIQTlodHUzc3JsTnZwRDNyeUZHQzJLd0FBOTc4Q0Q0VDVVZkwybzdr?=
 =?utf-8?B?UVFhL0pROFZwK2RCT2FIR3YrVXJsenNVSmlLeWdYQ1E0Q0daY2VIUkdKemN6?=
 =?utf-8?B?UlhpL25QODJ5TGZvamxGUzJTNXFwdjBHM0tIYUVNRFhRWEZDRHQyMDBlTUFy?=
 =?utf-8?B?MWZwaXo2WDcrMHpMOTRrakhKa1R0dHZiM0UwbnFwKytkYk1TTEZKL3ZQODFI?=
 =?utf-8?B?NkZKY3IxZ2p4YlhKdlA2WHlZaUlBK0JLV0pBVHVKUGJlcUtBcTd1cWQ4UWJJ?=
 =?utf-8?B?R3cvOUZNRzRoTjg2MW1aVDEvTHZ5N3VhNlJxdTJGWS9TTHZWenZhUVlBOVk0?=
 =?utf-8?B?K2llZjQwY0F2MlZaNSsyUWVNajRvajJIL1h0N2NVUzVoejVOekw1eFlRV2oz?=
 =?utf-8?B?THoyd0hwcytaczQ4N3ozbTVtMENXRWlyektOUVEydnpLbWVTV1NXUk9ZdGw2?=
 =?utf-8?B?WHh2dHhtV3FvNDUvclByT09XQnl4TFQ1NkgzeWxndDZ4UWI5ekRTbVc5OUJz?=
 =?utf-8?B?STF5VFNiQ3Q4RkFNRXZYaGFJcDBWVnNGNDdxSzJEMFpRMXpHb1hpYWYrMUZS?=
 =?utf-8?B?dGtObnZNVi9xdkFxTWJhZGhUZFI3VWZhaUJGeGg2TmpIMDlBbG1IYmxCQVFU?=
 =?utf-8?B?dUh4T0NQOEsxaHVnMGx2eDhqYWhpSFdhTG5zUjVhazJ6YW1iU2dqQWc4aVVI?=
 =?utf-8?B?ZkUzZXdER2syK25XUy82TnZGdytPQ3F6NktVT3dOTEFKK0FtZ1NTdkk3VHdH?=
 =?utf-8?B?ckU1dnRDWXBDcDloaW4zYVMweVlsUXNqUnQzTUFjelJ4OXVIdklzUVN3alh0?=
 =?utf-8?B?MkpUc0hHNlF6L2Q4cW5SODBLbGwwL2JXdEUwVTBVLzBRdS9WUko3bDAwbG5P?=
 =?utf-8?B?UXA3WjRLdTNYeExlRkx3bnQ4S3RDSmJ2ZWNCNEpzUkNPZFZ1K210a0thN2Vk?=
 =?utf-8?B?QWVlK0xYNDNhc2VPNnZaOGpOaS94VXNPM0pERHkwNlZuUWV3ZGhLY1U0S1FW?=
 =?utf-8?B?TDZQZ2hFTzhVUHRkazR4S0JRalpPUEVsd0FVcHA4QVUwVndpcEFMM0NOWFl2?=
 =?utf-8?B?L2tZbmJobjZkZVpkSnlDajFhdTlPVUk1STFtWitPbFBpRkhvODVHbmk0VmVh?=
 =?utf-8?B?SmJxK0pOSjBCWGZrc1Z0RFJQbkNrM0o1dG1Dd1o1ZHFNMTIzZ1lxS3hXektS?=
 =?utf-8?Q?8X129CY4h3hr8pc81pw0rrHa9rJJkGbZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZMb3ppREl0c3B5KzE0ajhzamYvUXVXRktGV2xzeXA2T2hoeCt4ZkxCS2hG?=
 =?utf-8?B?K09rSmdlWEVteDEyOExjdGtlbU9sOXo4ZWVDNHhmYVU1OHRjNXU2VDZCWGJa?=
 =?utf-8?B?UDlVbTFPOUpmeWFoc0UwbTNhcE9HVEpFVjhpSVdUbC9iWWVWNFZrZWtZaWo5?=
 =?utf-8?B?QmltRko1aitLM1NRQVk2OGNYaW1UaHNmNEplOGcwcHVONEpTNG5PVmJaOGdY?=
 =?utf-8?B?TloxRDVyVmlwN2paSmVhOE5laHNlc094azM5N2VSb3hkOUZRQlN2bW5qY2R3?=
 =?utf-8?B?MStXbG9LRWRmd2w0c3MyNXNrL3dnRk9xUlFNVjlwbFZ3ckhEQSt0eC85RWtk?=
 =?utf-8?B?UHJ0amQyRXlCb1JDSFY5N3hzVlVCcDhTR0ZYTlJFWmZFOXhvR2NqdW9DRm82?=
 =?utf-8?B?TXU5N3Y0Q1RWR2I5emFqR3NlUWtqalZHU0NyenZPTE5TSmppcXRuVWV5V0ZF?=
 =?utf-8?B?YlpCUEp2akhjTUZRYUtGYmNXaTNvWEZycmJMOGNZeDFSRGEzU0xla1Ryd2t5?=
 =?utf-8?B?Q3NCQkFIb2ZIWDJIWWMweGQ1bytuektFK0MxRzkzeHk4c3hQSEJZUlRCQnFv?=
 =?utf-8?B?VktJMEJna3NrTkpJSDFWYWRXNXllWjcxYkNmRlJXTE1hWmlhQS81SGl5aXNQ?=
 =?utf-8?B?QTBjRWl6SFRUcUNlbWluSHlxMzhsM0dPam0xU3o4Y2NXOTFvRVM2b2hDWDB2?=
 =?utf-8?B?NTlsa0lZYUpQWS8xODJJNS9wLytscldiMkszTlZ6d0VVK0ZWTERIR3N5SGcv?=
 =?utf-8?B?NVBHeEhjL2pGSkU1V3R0Y3JpN1U4SU5JTUpVa0VtWHlXZjRyU0Z3L0VEU04z?=
 =?utf-8?B?bTU2WWQ2bWZSdWZMbzBIMEhKd1hUdXZhZHZtT1ZDN1pDZ2ZJcEZnamhTNEda?=
 =?utf-8?B?cXloN1pSZ2lDNkFtMEE2dWs0T21vNDJlYWRBQkllS2FyRlVpWFFQVncyRElQ?=
 =?utf-8?B?a1laTzNGV203d0pnaDI1a3Q4TmhibkZOOUdORVhrc1U0MFdsVlFUc3ZGTG8y?=
 =?utf-8?B?TElMbklWZ1doL1RDUWw3WmNMK2U4ZU4zNUZzSkpJNlNPa2dUNkJSVVBBeTlY?=
 =?utf-8?B?WGVCem00T2xSQW1KVW12UFBOT3U0YlpHRHV2blYzS2crUUtzSWhkT2RrenFS?=
 =?utf-8?B?bk04d3BoWXhoSDg1SUFiVmxnNFVpQ3lyR1lkVzF5MXBCRHNVOWxhYTV6R1hQ?=
 =?utf-8?B?K2xUdmhHa1VNalkxTGpjMkRsKzBKMTlTTVVOMm5aM0haNmRnMnBqY2FPVlZU?=
 =?utf-8?B?YVFocVRqbUhFT3FuZnhWcSt4Q0JVOUdPYklHdEtQVmRoQ3dTOG9CQnVRbVJM?=
 =?utf-8?B?dlV5dlBTRFJvYWwxaEV3YmZQUEN3M0N4ZWloTVVYcmExblBTZlk1SXJqbW42?=
 =?utf-8?B?STE1d05NQjQyK3cwWHBGUlpTTkc3QkZiQVkwRkxBZUQ4UU42WCtTUVUrUUln?=
 =?utf-8?B?Z0M5b2l4WitoSk1GbEVmWm1kUllDWXBRRXVOWmVZOHZ1V2dnVUQ4c0VWUVlB?=
 =?utf-8?B?RkxucUlaNzk0YVBuY2lYdkxSeU15cEY4YlRBb3RXVUtMV3gwZDhwYmFaQjIr?=
 =?utf-8?B?a28yL0pYZHF2eDR0cjQ0dVhiMFlETlgrbnFDWnNDdDBsTzJkeExCMXRNN3VM?=
 =?utf-8?B?UTUrWERXcnU3TXRiaGJxZ1NxelJ0WWQ0NVh5SCthS3JzODBzelE1OU95N1ZT?=
 =?utf-8?B?WE9RalpJdnVJNEJoTHNrcUVRMjI5em5qcTJSeGk3NERaM0F6K2RRMmpLVkpq?=
 =?utf-8?B?VFBKdXhNRzU5ek1abDNGN2UyOTgxSlF1YkEvUmg5Q0R1ODRnVlA5RGIzSGM3?=
 =?utf-8?B?dGkwT3MvTktUd3lTWU56VGlpMGFMNlhJWUxWZHV6MHV2MGQyYlpFcTFqZldK?=
 =?utf-8?B?ZGE3eDRMdFg4bks5YU5wc2tRSkNJVTh6M0JBaGxRZ2RxVVdnODlvdEVUczhS?=
 =?utf-8?B?TlhBT1AwZkhvNW9NVVdQQzRnTFlkNmM1WVNwQVR3dFhyZm5yTlJyQ0pxUy9i?=
 =?utf-8?B?RWRzb3ZvaThHOUx5dG5NTXF5TENydlFYejB4YmtPRTJoSThjSnM1N2NPTXZR?=
 =?utf-8?B?U09UaHlvZW9jWHBBUlBCeEN4eFJYaytRZzdtUU1uS1N5S2NyUjBXVUpjOFJq?=
 =?utf-8?Q?3/VgLJlA8vgPVDmxTBf6jZkZc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fdc0b1-96a4-4924-6255-08de098da2f9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:48:26.5185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxOVV9Dz2539A4sT8k+ZHuMUcmJN+5dbJTeCsEfKLsTeO3IMyjPsuLBrFTMLxN0ZyOXNhzpYoD9noSTOfKO3Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8702
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

On 2025/9/18 16:57, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, first stage page table
> is passed to host to construct nested page table for passthrough devices.
> 
> We need to check compatibility of some critical IOMMU capabilities between
> vIOMMU and host IOMMU to ensure guest first stage page table could be used by
> host.
> 
> For instance, vIOMMU supports first stage 1GB large page mapping, but host does
> not, then this IOMMUFD backed device should fail.
> 
> Even of the checks pass, for now we willingly reject the association because
> all the bits are not there yet, it will be relaxed in the end of this series.

might be good to note that nested cap is required but it's already
covered in the core, so this patch does not check it. Otherwise, it
would be a question why it is not added without checking previous comments.

Regards,
Yi Liu

