Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16634CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90yL-0005RV-MA; Wed, 15 Oct 2025 08:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v90yJ-0005R7-US
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:51:16 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v90y2-0006tq-87
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760532658; x=1792068658;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2C7ieo60zdeKY/WWoi1H85goRUxSmav05BwsxXh1hxI=;
 b=LnCZHew//gHrNrRAaxUWLWyxQTZ3N2MDoDrd7hAG3yfCmIR86aAhfsO+
 TFP8KzcsAcu6OWKjn/Ngzd6kM/qd73omYxLO1vz0K10ExMzmJLtpDGN6u
 IFUuSPDgMj1giRu6dA2qXhyeEF1jD7xbmpLNXVNgpdvC3ev0x7rZiuFcV
 foAE2bT+FGMa65+6NcNmbmuX3vWhr1PP+cyvjcpoYZbJZLWT7A7wevIez
 AQz1uwSU27+NmzZ6rGC2j5CGpSLeysL/d7Scg/0f6dTDGO53jBpqXvmjo
 O+6yYdwjN2lwHOvyp7PPqhuTtifbwK8dir/vIJJCsQ9TyPzKeH5BwfNND Q==;
X-CSE-ConnectionGUID: 7uRjeB9gTx2Rn590TZ56NQ==
X-CSE-MsgGUID: 9GFC5h/5ReuOWeNyD3zXbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61736615"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="61736615"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 05:50:50 -0700
X-CSE-ConnectionGUID: +isgtT0eT+adzHG35Rotjw==
X-CSE-MsgGUID: gdkg7fCtSX64kMu4xyWQew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181842697"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 05:50:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:50:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 05:50:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8xjDK+H05rRANOBMovGW9v0yxZug+BKhYtb/qV2bmeQ2E+LBbmwCzKALlEjHMA2unmNE+sJFVykiJ5Hxb1ly8ZBzkKY9Evew8iE+Zcrk/6fWzwQZGZ7RvRtFwu+h2HKkb7q3Uvu4zk++yk+QCOw12GruevX4jMOSkqBB/VKx+zSXFcwS29v7alqcv4myj843eAm3iYUWUPAmAD8iO94e/AnJIfMAi7MRMT72dn1bNz7NWsC6efIIU/lAe9nfneqMN+NneWpsjajmmeJHbzcZjdtc1UAqibSWIg0e1/cwDc1XczRgwLJPuLAIAAOiAxsSksAjWT3eEX1f7RAzHa5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXOyfwshsjmnkD3HCAL7vB7dzudHYeeyJ7qQGi8zjnM=;
 b=WnRtTP1nT113aReR71PYG+1pQv1CqTpVmNxFj4oOpZiJBaw8MQyBAMJZOcSCkspKNhu6vJerEdvx6JvcMgkbqDi4UYE6J6D6aCE+PBGEA6kaZE4Eq9VGFfzvOuJ90ftbkvPN4CryiW8gXfKLCSEQ3oKvgW7tmrhKgyxhGpj5Ind8YkjxsirVOW1xg19ZnGZxaiJpt5U1Hf8EfGWKgYeU97E6L3CCWMpwBzGgjLlL58iiwBozlRtqzVlMfsNiUOJmNFhQcOQQqR5TTeAZ72x5Xydd/Sm3IL2Bh9Qd5Or2bGc0MeIFNHtndzY7PBfdtVWJ5utcEBJ2/GC6dGd9W9riiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SA2PR11MB4795.namprd11.prod.outlook.com (2603:10b6:806:118::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 12:50:47 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 12:50:47 +0000
Message-ID: <9fabdf4a-a781-491a-bbd2-40e51462b8e7@intel.com>
Date: Wed, 15 Oct 2025 20:57:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
 <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
 <IA3PR11MB9136AEE8F0C3A989C964E35092E8A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136AEE8F0C3A989C964E35092E8A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:820:d::8) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SA2PR11MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 0991894d-b988-46ce-75ce-08de0be975f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|42112799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjZtVFdyQVYvWnlVeHE0bmZ6VjE1RUV2T242SG1pVEFoY3VnTVJuQVhIY0w4?=
 =?utf-8?B?Y3FOWG9WVzRmMWZ2YTdjNVBkd3libmsydG9nRXhmenNXdWp2SHd4V3hraFN6?=
 =?utf-8?B?TkM4Qm5mb3JQM3VTc240clkwdjh5d1NueVpLQ21Md2tlUlByRUFBWWFIWlcw?=
 =?utf-8?B?ZFVTVDAzVkxiUjJoMUo1WEJsOXUyQWxkSEFqc0xoTlF3VEk0YnRYWE9sVkgy?=
 =?utf-8?B?aUx4b0xYQXpxSTdZUFBKUWcvVFU4K2d0eEdGaGhsZjNkZ2VpMGV3MGFoaThT?=
 =?utf-8?B?N0ltajF5ZnFIK2VtZUxKRFhiZWVBbUprS25vWHk1c3RySytLUHBzM1dnRERw?=
 =?utf-8?B?RzVNZ3hCbXNBMzlxU3hlM2U3K3p5dlZtYnNGK2NPS0JDU3pnZWtyazl2V095?=
 =?utf-8?B?MzFVcTkwWFVaU29uTk4rQm41TERhOFh1U0VaZWx5U2MyR2dtYUgrL0VlNEda?=
 =?utf-8?B?QUdCdHNRNjdnWFVjSHZKOS92OWFlTGpOSG5iNlY2bjNlMklyN3B0Njl3QS9q?=
 =?utf-8?B?YUJ1VmhZYXF2ODNhTUZEeFVkcklHT0xmYTdjU3B3cEIzRm5qRVRDcHY2czh6?=
 =?utf-8?B?ZWo3aXhVaThjM0NDQnNpWTFTdzZJVGJEa0p1YS9haC9FbmxML1U5TWVOQk1B?=
 =?utf-8?B?YzF1Zmd1S1lVY0NsdWdWU080WnhCcVJ6QnRRalRMY0hlRnZYbmUyR0xoOS9P?=
 =?utf-8?B?cDNDeXptQ3dKcmlubnNJZ2M0K2RhQ1lTdnJmZlBhNElMTFpoNndWMS9WdTN2?=
 =?utf-8?B?cVdlb0V1bFBMbjVTTVZCOTZuWjFQNklkNXpWemoyVXV1alhkY2FnU0ZOWmRl?=
 =?utf-8?B?RFdzbTVGKzlpZ202eTZLTVNnM1Zxb2xQcG0wcVVTbWhvUEswYzM0QS9YR0Yy?=
 =?utf-8?B?Q3Z4eXpoQjFWTlI5ajh6MlJHRnVCNlNIa3lVMFh0c0Z0ckI2YWxzdkxSdWFo?=
 =?utf-8?B?bE9LdU1lVXExRWVMQ01WcDhhQjhQM01yYkhlZktiUTBicXVJRUpnMFJOM3dl?=
 =?utf-8?B?ZzBNVEFUbDRlS3ZsVXFpV2dyVDZxUnBqd01NOFpHdnBqeEJ0bW9hQ2hzRTZW?=
 =?utf-8?B?YlVLdEtvT1lRRXNjRys1TFc4MGZDTysvQU5PcndVNUM0OFBvUjZrdjRPNlFU?=
 =?utf-8?B?NlY0ZjA5N2J6b1RTK0JyRlZ2eVVtNHNCZWNMLzhlSzUycE1SVXFIRVVhTUIy?=
 =?utf-8?B?MC9zRkFDdXBlbjRxK0I3RWsxNUxsNklyWDJNd1hlSXA5a1VyTXFFa3ZReFo3?=
 =?utf-8?B?WlhtYUtUaUF6QnNaK0tiN3QxbjlOOS8zWEw0N3ByTXhYVmtwOXF5R0NhL2Ux?=
 =?utf-8?B?UjhnaWRkZVBaYy85Ulk1Y1p1OVl5a3hnRzZtckkrN3U4TXJuREhYODJGdmR1?=
 =?utf-8?B?K0xSRFlXeklVVVFDNkxrYjRydWN1bncyakxhcENIcmRhamlRNmNvTWw3WllL?=
 =?utf-8?B?SUpIdkZxRnpIa0dPMmpDZ2h6ckxKcFhGUG9rL1h6RWNGN2lEOEpUZ0RieFlM?=
 =?utf-8?B?Sy95WElJSzRseTNuUVdjeTloSVNMcFIzMHVDZTBKeFcrY0MxSWh5NHAyS3pn?=
 =?utf-8?B?QXpiNTJUekJrNFMwZEtnS0ZNbFZJR294TEJ6Mjg5TVVJMDczaU1zM3hWbnk3?=
 =?utf-8?B?T3l6OGFCd1VOMUszdG5SekJqdzA4ZlhCd2lkbDd3TFhUSjlrWEd3cCtjZUVZ?=
 =?utf-8?B?NFYvZGN6amM2OGxLMTMzak10dWtMc0lLMVRmWWlBQzJFeVRIb2RpZWZYNjdG?=
 =?utf-8?B?YmtPYy9PU203QTN2ZjlnV1Q4V2dYbTRJR25CQVF3N2grY3ZuSlpqdzhsMk03?=
 =?utf-8?B?bzlBaittcVg5QXlFNFRNaHh4a0pyUDhVcHk3NGVHNTFoVkFrKy90SmZuTEh3?=
 =?utf-8?B?QTFabFpRdDl6V3lvOUE0dnFMc3ZKM1U1azZFNXVWcm5LMkhGNWVwZldTbmVj?=
 =?utf-8?Q?oGLPVlOqgp7vfbCqElipufJqHma5rI+Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXUzVk0rV1pLNDYwa1hoQmQxYWE4angzTG9tRGVNQ2RuUlpIQWhkNFRKa1dw?=
 =?utf-8?B?bnI2clBOK1dYK1RpRE5iQ2twT1JkYzQrVjErdmdHR3NocnAzbzBLd3Zya0RQ?=
 =?utf-8?B?M1hQcTFKSGwvVmNLeTEza3FiTTBicHFiemM2UE5IazJhZEVudHNFR0dpYm5O?=
 =?utf-8?B?VTdSWXczc0QwRnFUSU10SEQybGhMeXRoYWU3Z3JSbEZuaWtHWTZFNUVUZHZz?=
 =?utf-8?B?bXFwOFRBWmE1Y0k3ZzdqNGhZRHFUU09uMlF2UnRVUC9nSTZFeEVpcTNjSGYv?=
 =?utf-8?B?VHIyZWN4WEJyVlhRcC9UY0VBT3NDQzBJYTYwMUhLeUhmQ0FyTUtqY2hhanNL?=
 =?utf-8?B?Vm4wREJ1a0hheC85NzBRQXo5TDVGV2oxYWVIZUVwOFF0TDBpbnpzcUZzRDVq?=
 =?utf-8?B?QXZsNGVjUWxnYTgwVHAzMGkxKzRSRVliM1RBQnp4SW9ETEJWVWhEVHZBQTVu?=
 =?utf-8?B?MEhKdXFDR0QwTWtQcUJEUHhwb2VoQlJFUGdlMUJUeDZRbGJkbkZIMy9HN2lL?=
 =?utf-8?B?bXVSNUlpNXlhUjNwTzhXMUZBb2lPcnJ6Si9rczFCWWtNMGZmQ3NuZkNEQUhr?=
 =?utf-8?B?OFJKTER2TXNVSXl0N1VVZUF6Z2tXNitEN2dsdTluYnprbEh6TWtqSjZUbUlq?=
 =?utf-8?B?ZFVkYnBCSGtONXhRNUROSHlUSWlTSXpXQ0RLdjV0VkJjYlg0c004UEZMVHFp?=
 =?utf-8?B?c29zQ0xoVFFvMTQycEllOCtBL1Q2YWJsblF5V3c4aHl6VWVwVENYVi84dUw1?=
 =?utf-8?B?MFJwbnFubGt0MXllbzR4dGhRRDBTWFJKR2dwOFYxcnJudXlvTDZnVmt1TGJN?=
 =?utf-8?B?ajNUS3lLQU9DNjdyVitBRTEzWjFzblRPUHJWdHhKTlh4akoxMkg0MWh2TjBo?=
 =?utf-8?B?c29tdEJEVUlkUzJKRFhlSDM3S0o0T2NHdW52QnNFRTRLM1FaZ2R0YkdYOGtz?=
 =?utf-8?B?WE1ML0ZGa0FVTEgvaWZDdkcvTmRxLzFFM3hCYUZhSDJmazdiRXkxTHBsbFBU?=
 =?utf-8?B?U0lOMmpQNHdtbzFHVEVtYUhvaXVkVmVIR3IzU2dBN2xCLzJVM3FndzR6aUJk?=
 =?utf-8?B?NjkvZjU2SkVyWVhpQVNhSjFYSkU2V29YcnhmTWtZTElPWTh4N2NWUjE1WmNE?=
 =?utf-8?B?WndWNGNpdEtTQ0Y4NDdrMzY2M2xmK1R4aXNmMktGQTJmM2V3NlJSVXZYMDVo?=
 =?utf-8?B?WUNhSklNK2xseTZTOTZiK21XYTFSbHpidVpETHZqUy90RGY3MnUvYmN3Qk9E?=
 =?utf-8?B?R0hxeDFKaW9BZ2kxM01wNTdwcTEydG5kTGhwVWRKeVBQTUVGQXlFbDdkNFpl?=
 =?utf-8?B?UzJXbjIzRjZLWkZONjdUM2RKa3loR1lXK1JESjdWTStsUkYyNHd4UGpYSkds?=
 =?utf-8?B?ZlFTWkxoTlQ2Z0xFTlNIMnJrR2FuY1J3SnQzaGtBaHBSWmlBS0ZXaHFzMmNy?=
 =?utf-8?B?K3REVlJJczQrTUY4VlN2YWgvVC9DcFV5SkRLSEFuT0U3WUF2VnJ3Z2kxcVlO?=
 =?utf-8?B?VXJQYWpjTUFjWDZvODRkaDZJZ3BrU0VmUE5ZTTRQNEYzWjJCT0grcWdiNklH?=
 =?utf-8?B?clN2YjBSWXh6ckZjeVRnWDNUUW9mZHl4MHM1OHJGTVR6YW5pOG4yL3J1R0lw?=
 =?utf-8?B?dmxLaS9WdVlIWGNQVy9YZjV3UmdLUzdMb2xOQ0lvZlpOVHJ1Tk1tUDZNOGNs?=
 =?utf-8?B?YzkrdHZ5T29GRkVHSFc2MzV1bHRJelJGMGI2SXF0QW5wV2VsK0RHd3Z5aTVU?=
 =?utf-8?B?QVJlanAzVnhaL3hnZ1didW5RS0RYa1l2VXhLNEtMY3lLQmprOGhnRnh6TWQr?=
 =?utf-8?B?UHhpSEV1bXo1VWNFVEN0Y3p6cVpwVU5xWmFCWWR5bEV4QlVmSUxzdDRhUVRX?=
 =?utf-8?B?VFhOYjF6eGJKZ0hqZEREOVF0dm9MR3JkajlsKzNIcjFsQkF4ZDB5ZHFqdGNn?=
 =?utf-8?B?WHJrelk0dFpBcHN2SWV4dllKanFoSkQ4eEdnbzgwOUR2YWtMdGhBeWR1R3hJ?=
 =?utf-8?B?RTlXdFhLOHJlWXZTd09WTHl5UE5laGwyNC8rU2J6VDMwMFF5WTBWZ3RmSGt1?=
 =?utf-8?B?WWw3b3lrdzB3YTlRcEhVMHZVSk1oNFB1TUIwZ2FybFV2L3doRHNlT0FiRkVF?=
 =?utf-8?Q?DXK89JagZWk/pl9Nd2EmS86yC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0991894d-b988-46ce-75ce-08de0be975f3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:50:47.0339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33T3rZO/Rfh24gJh/rC6wqRkZZaEaqnw6ItbUH3pZ9hfosOzGs9FZTvkLodvJKR32L7k/BBR/vx71IvTHTCb7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4795
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025/10/15 15:48, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during
>> migration
>>
>> On 2025/10/14 10:31, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during
>>>> migration
>>>>
>>>> On 2025/10/13 10:50, Duan, Zhenzhong wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>>> Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during
>>>>>> migration
>>>>>>
>>>>>> On 2025/9/10 10:37, Zhenzhong Duan wrote:
>>>>>>> If a VFIO device in guest switches from IOMMU domain to block
>> domain,
>>>>>>> vtd_address_space_unmap() is called to unmap whole address space.
>>>>>>>
>>>>>>> If that happens during migration, migration fails with legacy VFIO
>>>>>>> backend as below:
>>>>>>>
>>>>>>> Status: failed (vfio_container_dma_unmap(0x561bbbd92d90,
>>>>>> 0x100000000000, 0x100000000000) = -7 (Argument list too long))
>>>>>>
>>>>>> this should be a giant and busy VM. right? Is a fix tag needed by the
>> way?
>>>>>
>>>>> VM size is unrelated, it's not a bug, just current code doesn't work well
>> with
>>>> migration.
>>>>>
>>>>> When device switches from IOMMU domain to block domain, the whole
>>>> iommu
>>>>> memory region is disabled, this trigger the unmap on the whole iommu
>>>> memory
>>>>> region,
>>>>
>>>> I got this part.
>>>>
>>>>> no matter how many or how large the mappings are in the iommu MR.
>>>>
>>>> hmmm. A more explicit question: does this error happen with 4G VM
>> memory
>>>> as well?
>>>
>>> Coincidently, I remember QAT team reported this issue just with 4G VM
>> memory.
>>
>> ok. this might happen with legacy vIOMMU as guest triggers map/unmap.
>> It can be a large range. But it's still not clear to me how can guest
>> map a range more than 4G if VM only has 4G memory.
> 
> It happens when guest switch from DMA domain to block domain, below sequence is triggered:
> 
> vtd_context_device_invalidate
> 	vtd_address_space_sync
> 		vtd_address_space_unmap
> 
> You can see the whole iommu address space is unmapped, it's unrelated to actual mapping in guest.

got it.

>>
>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>> Because legacy VFIO limits maximum bitmap size to 256MB which
>> maps
>>>> to
>>>>>> 8TB on
>>>>>>> 4K page system, when 16TB sized UNMAP notification is sent,
>>>>>> unmap_bitmap
>>>>>>> ioctl fails.
>>>>>>>
>>>>>>> There is no such limitation with iommufd backend, but it's still not
>> optimal
>>>>>>> to allocate large bitmap.
>>>>>>>
>>>>>>> Optimize it by iterating over DMAMap list to unmap each range with
>>>> active
>>>>>>> mapping when migration is active. If migration is not active,
>> unmapping
>>>> the
>>>>>>> whole address space in one go is optimal.
>>>>>>>
>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>>>>> ---
>>>>>>>      hw/i386/intel_iommu.c | 42
>>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>      1 file changed, 42 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>>>> index 83c5e44413..6876dae727 100644
>>>>>>> --- a/hw/i386/intel_iommu.c
>>>>>>> +++ b/hw/i386/intel_iommu.c
>>>>>>> @@ -37,6 +37,7 @@
>>>>>>>      #include "system/system.h"
>>>>>>>      #include "hw/i386/apic_internal.h"
>>>>>>>      #include "kvm/kvm_i386.h"
>>>>>>> +#include "migration/misc.h"
>>>>>>>      #include "migration/vmstate.h"
>>>>>>>      #include "trace.h"
>>>>>>>
>>>>>>> @@ -4423,6 +4424,42 @@ static void
>>>>>> vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>>>>>>>          vtd_iommu_unlock(s);
>>>>>>>      }
>>>>>>>
>>>>>>> +/*
>>>>>>> + * Unmapping a large range in one go is not optimal during migration
>>>>>> because
>>>>>>> + * a large dirty bitmap needs to be allocated while there may be only
>>>> small
>>>>>>> + * mappings, iterate over DMAMap list to unmap each range with
>> active
>>>>>> mapping.
>>>>>>> + */
>>>>>>> +static void
>> vtd_address_space_unmap_in_migration(VTDAddressSpace
>>>>>> *as,
>>>>>>> +
>>>>>> IOMMUNotifier *n)
>>>>>>> +{
>>>>>>> +    const DMAMap *map;
>>>>>>> +    const DMAMap target = {
>>>>>>> +        .iova = n->start,
>>>>>>> +        .size = n->end,
>>>>>>> +    };
>>>>>>> +    IOVATree *tree = as->iova_tree;
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * DMAMap is created during IOMMU page table sync, it's either
>>>> 4KB
>>>>>> or huge
>>>>>>> +     * page size and always a power of 2 in size. So the range of
>>>>>> DMAMap could
>>>>>>> +     * be used for UNMAP notification directly.
>>>>>>> +     */
>>>>>>> +    while ((map = iova_tree_find(tree, &target))) {
>>>>>>
>>>>>> how about an empty iova_tree? If guest has not mapped anything for
>> the
>>>>>> device, the tree is empty. And it is fine to not unmap anyting. While,
>>>>>> if the device is attached to an identify domain, the iova_tree is empty
>>>>>> as well. Are we sure that we need not to unmap anything here? It looks
>>>>>> the answer is yes. But I'm suspecting the unmap failure will happen in
>>>>>> the vfio side? If yes, need to consider a complete fix. :)
>>>>>
>>>>> Not get what failure will happen, could you elaborate?
>>>>> In case of identity domain, IOMMU memory region is disabled, no iommu
>>>>> notifier will ever be triggered. vfio_listener monitors memory address
>>>> space,
>>>>> if any memory region is disabled, vfio_listener will catch it and do dirty
>>>> tracking.
>>>>
>>>> My question comes from the reason why DMA unmap fails. It is due to
>>>> a big range is given to kernel while kernel does not support. So if
>>>> VFIO gives a big range as well, it should fail as well. And this is
>>>> possible when guest (a VM with large size memory) switches from identify
>>>> domain to a paging domain. In this case, vfio_listener will unmap all
>>>> the system MRs. And it can be a big range if VM size is big enough.
>>>
>>> Got you point. Yes, currently vfio_type1 driver limits unmap_bitmap to 8TB
>> size.
>>> If guest memory is large enough and lead to a memory region of more than
>> 8TB size,
>>> unmap_bitmap will fail. It's a rare case to live migrate VM with more than
>> 8TB memory,
>>> instead of fixing it in qemu with complex change, I'd suggest to bump below
>> MACRO
>>> value to enlarge the limit in kernel, or switch to use iommufd which doesn't
>> have such limit.
>>
>> This limit shall not affect the usage of device dirty tracking. right?
>> If yes, add something to tell user use iommufd backend is better. e.g
>> if memory size is bigger than the limit of vfio iommu type1's dirty
>> bitmap limit (query cap_mig.max_dirty_bitmap_size), then fail user if
>> user wants migration capability.
> 
> Do you mean just dirty tracking instead of migration, like dirtyrate?
> In that case, there is error print as above, I think that's enough as a hint?

it's not related to diryrate.

> I guess you mean to add a migration blocker if limit is reached? It's hard
> because the limit is only helpful for identity domain, DMA domain in guest
> doesn't have such limit, and we can't know guest's choice of domain type
> of each VFIO device attached.

I meant a blocker to boot QEMU if there is limit. something like below:

	if (VM memory > 8TB && legacy_container_backend && migration_enabled)
		fail the VM boot.

>>
>>> /*
>>>    * Input argument of number of bits to bitmap_set() is unsigned integer,
>> which
>>>    * further casts to signed integer for unaligned multi-bit operation,
>>>    * __bitmap_set().
>>>    * Then maximum bitmap size supported is 2^31 bits divided by 2^3
>> bits/byte,
>>>    * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K
>> page
>>>    * system.
>>>    */
>>> #define DIRTY_BITMAP_PAGES_MAX   ((u64)INT_MAX)
>>> #define DIRTY_BITMAP_SIZE_MAX
>> DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
>>>
>>>>
>>>>>>
>>>>>>> +        IOMMUTLBEvent event;
>>>>>>> +
>>>>>>> +        event.type = IOMMU_NOTIFIER_UNMAP;
>>>>>>> +        event.entry.iova = map->iova;
>>>>>>> +        event.entry.addr_mask = map->size;
>>>>>>> +        event.entry.target_as = &address_space_memory;
>>>>>>> +        event.entry.perm = IOMMU_NONE;
>>>>>>> +        /* This field is meaningless for unmap */
>>>>>>> +        event.entry.translated_addr = 0;
>>>>>>> +        memory_region_notify_iommu_one(n, &event);
>>>>>>> +
>>>>>>> +        iova_tree_remove(tree, *map);
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +
>>>>>>>      /* Unmap the whole range in the notifier's scope. */
>>>>>>>      static void vtd_address_space_unmap(VTDAddressSpace *as,
>>>>>> IOMMUNotifier *n)
>>>>>>>      {
>>>>>>> @@ -4432,6 +4469,11 @@ static void
>>>>>> vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>>>>>>          IntelIOMMUState *s = as->iommu_state;
>>>>>>>          DMAMap map;
>>>>>>>
>>>>>>> +    if (migration_is_running()) {
>>>>>>
>>>>>> If the range is not big enough, it is still better to unmap in one-go.
>>>>>> right? If so, might add a check on the range here to go to the iova_tee
>>>>>> iteration conditionally.
>>>>>
>>>>> We don't want to ditry track IOVA holes between IOVA ranges because
>> it's
>>>> time consuming and useless work. The hole may be large depending on
>> guest
>>>> behavior.
>>>>> Meanwhile the time iterating on iova_tree is trivial. So we prefer tracking
>>>> the exact iova ranges that may be dirty actually.
>>>>
>>>> I see. So this is the optimization. And it also WA the above DMA
>>>> unmap issue as well. right? If so, you may want to call out in the
>>>> commit message.
>>>
>>> Yes, the main purpose of this patch is to fix the unmap_bitmap issue, then
>> the optimization.
>>> I'll rephrase the description and subject.
>>
>> yes. The commit message gives me the impression this is bug fix. While
>> subject is optimization. BTW. perhaps call it as an optimization is
>> clearer since this smells more like an optimization. For fix, I guess
>> you may need to consider the vfio_listener as well.
> 
> Do you have any idea to fix it with vfio_listener?

no good idea.

> My understanding is, it's hard to fix this issue from vfio core, because vfio_listener doesn't
> know the mapping details in the guest, only vIOMMU cached them through DMAMap.

yes. that's why I suggest above fix/WA to avoid it.

Regards,
Yi Liu

