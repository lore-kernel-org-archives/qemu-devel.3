Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65370CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 06:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8YhQ-0004Vm-ND; Tue, 14 Oct 2025 02:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8YhP-0004Ve-6s
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:39:55 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8YhK-0006gS-Tu
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760423991; x=1791959991;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oyNFDJYKhtRaZHAneBOBCe0/u04zmseeovdHbAvlXVo=;
 b=hv2i4WsMI9NebzBGqJNqgZnqhIoC7QpiodYxRMIMlEB35JbRi7pJJv61
 OfGYcJ/3JPta/x28ja8wseNn0HJVhmezxEadDDUOdiv/S356GeU1swR0k
 eaUK9RmRXBStHvk9xK1jVMFRQsFKh/pu3KjS4wuN27SSxGR2vAS31eCy9
 7JkA5RdH58mumvX6E/S9CCrGAgQ6XUfpoTY4/2P6RJrYupvT9v49XB35u
 0qCiIvoZUSycXQ4C7DUa8NpYownbxwDwL9zCDqil8jruXYWnSPjegFhj1
 kBLiaAulI25HzwVh3MLRVqM0I5MJAk/NM9pkxzlxg9PrtC1UKhD0cJ5Ww A==;
X-CSE-ConnectionGUID: BXed8BX9SmmJsxtwxplU6Q==
X-CSE-MsgGUID: EE5coCnOQVS1rrTI4e8zog==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73679166"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="73679166"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 23:39:43 -0700
X-CSE-ConnectionGUID: d+ikkRaSRya+dksOZ4OsMg==
X-CSE-MsgGUID: Z7tZPTVVT9GNYc5MqVvlKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181758018"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 23:39:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 23:39:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 23:39:41 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 23:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No2KPOKGoIvVUXbAspm8hTxUOKanbBc938VOTFFzfo5BHCdqAz5+cxG6S3QVS0iXNvLZG1mKlnQyXGQjyIwcKel/5B+8K0AHW1jIP20NjPx6cJgVsUVe7V/Or0nYpVZSYsl114j6DGlHO18fjM0jIInyARyPgfWiZG9gx0Fyqpml7BGPaG/0inHalQKM/bAUJ3I0dD2RwUI6iXQ+hn1I09dvrFMasr3i8LU3BpeeOSqchEj7vN/TX4FJKUECE8kW7WyxpYZdGFBuqjxiNYlJ/e44X1Xx15yDrBg9OcMfhM8Tid30EkV4d21j6LTt2HHSf8NfmCI5StoCB8vp2ZZs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oUbFdT0DAAGy5W7MtclC+fCZYGp1O0VWMOD7CSDoso=;
 b=LeciJ9/vEYEF04HkzaHeU70vGy0F62QlY8wJ8tE+g8nI0xYiKb5jIbdh/kXt4ctyoL7C88qFpqiGpc7bF62T6KjhXewMx8rQWoYKBEpwQo27429PxCWCFSgdf1SJJaYE+z1+1vnrHGj0y/BWPHGQU4uaP2x0qeE9t+p1EBgmWOAwouSKvrX7H/YN3jD7VD/Wvx2WQRpw8j2INsqJ/plsd1PVju+ABahcDKEtLWXu17F1hNttecJ4cMSz4XCi9YK9JAcU37U5PUVoqNKZX1HmM8bfrE5OWKrRO1zq3L6oA6P8JH3QGmiWBARsDfb9kLEE1BZuafZ4kcgnDYu9KTUREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 06:39:34 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 06:39:34 +0000
Message-ID: <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
Date: Tue, 14 Oct 2025 14:46:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Content-Language: en-US
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
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0016.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::13) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b199f64-5b83-425e-3c9c-08de0aec7011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmphUjhXUklUVHVpZkVsb2lxY0p0M2FWUnB1bFB4ZFhjaHU4a2dvMUhDYkNi?=
 =?utf-8?B?dDFFQ0lCYkdtbXFVQkEyNGc1K3ViS2l3cGlGUnlQdVJSTndSWUJMTk53Y2F0?=
 =?utf-8?B?dCtKVmFYalBVRmtpUE05dGQwVml3NVhuWklJeThXeHIrcFBGYlBRc3l4V3l2?=
 =?utf-8?B?K2JtRGZUNyszdXRaZ2pnNHhUdFRHOHYrenNPREY0V3pJTUQ5cHYzbEtPdzFK?=
 =?utf-8?B?SE04NERyMTArcWg2UXF2Z1hDeGExM2FMSVFVS2tJdnh2SWMwNDZwQVFmUUwr?=
 =?utf-8?B?ZU9nU0wwUVhMYlRBZ0ZDL25VVFNmNjF1d1U3NWRLY04yYmVBT21WcXZYVWxD?=
 =?utf-8?B?UTJBWGM5VU83YWhVRGdxczBkQ05ncWVtcFp6ZTMwN3pKTVd5cEJyMGMrcGVI?=
 =?utf-8?B?THBVTkswdWtlVmpzRjkwdk8vM3RBNG0zblhONUw5djVZN2tHUlZTZzZ3bTJ4?=
 =?utf-8?B?d0hab0FMa3RKZmJvMDJZRmN1b2xJYkVJR3B3dkNVQ3pWUlNCWEVUVzV2S1p1?=
 =?utf-8?B?R2E0bWNpRVZlTjN0ZUs4aWhVRnhidTRXSDJmVlpvV1k0VlpkMy8xTWV5NmVk?=
 =?utf-8?B?M3FJTWMwVmFSRktGUXY2Q0dLMmN2ZGFHZUwrSi8vK1E1NXdGT01FM1Jzanlh?=
 =?utf-8?B?OXppSkJDR1VaZ0NaZVVSTlZpNHdBMWZLRFNmRGt5Tko2M1B0MlBMRjl0MTF0?=
 =?utf-8?B?dnBxM0JLZGxPMisvSkRYSldFYXVWcExXSzFMaFFGUlY0NTIvOXM4YUxoQTVL?=
 =?utf-8?B?alFVUnNmSmRDZGt5R3ljQVllNmJUOFV0elBPUDNySHlpRnZBUit4OXZIM2ww?=
 =?utf-8?B?OHVUZXJITU9wdFdETXdwOU5xUVZqK09ISXJtVUZOWERjbkFINC80UUorS3Rw?=
 =?utf-8?B?bkU5OUQxMEtROUM5LytpK3A2Z2oyZ09nVE4vMFNUdXdDLzZJeE9aaFBXZUVq?=
 =?utf-8?B?bktzb0hMdGdUdllmL2ltbHVteGwvc0pIQmFXVks5ZUNCNUNUNk5oNlkxNG1s?=
 =?utf-8?B?SmM5Z0QxeE10dlNZMHdYYldzajMyT240ZWMrQjg1amVwNXBCK0dsQmZaM25W?=
 =?utf-8?B?ZDB5YlJmbitmQzlRZXBYNHdpS2UzY29CY2FvMkNsM2sxaE1uZzVXMVNmK3hI?=
 =?utf-8?B?UEVDRzZ1S2ZiMTBTbkhTV2tRbkVraXgxZDBsN1hZVkdwczY4M1B1KzkrOFFH?=
 =?utf-8?B?ZnVUNGRhY1BML1AwNDBneEdDQTVvZGVud2k3QytyZXk3aVBPazN2MjlVcGZj?=
 =?utf-8?B?RkNlWkxvdnNtU201cnlONzRDNm1teGRXb083RUEveGNKOHhVUnJnd3ZFMWJR?=
 =?utf-8?B?Yk14eStOZmp0ZjQzSWJlSzF3Ri85VTUzVTNyREhEOXdCVUxHZmFGVGYzTDJr?=
 =?utf-8?B?ejlKOGRPZWl6aHVSMHRaQTJ5c3JqK3lIWlptVzRWbGRXaHpuUXFKdkFQMlJ3?=
 =?utf-8?B?M0dRbkJGemdmc254WXFVS1hjM0hXVDNiS3k3cXpEWGNVNHlXazg0NGpMTyt5?=
 =?utf-8?B?dGpNSVFQV2NOWml5cGdrVSs3L3dMdk94a1VUdlhOSnBFWGxoK0d1bHBGNkR6?=
 =?utf-8?B?ZjRXL1pTUWVJVm0zRGlIWGN4cENYbjhNREYwQzl0SHBPMzFLS0NzNkgyamM4?=
 =?utf-8?B?Y05haEh1MmJvRWVYYlBPV1NzOHhDTk9TdDBVQ3MrczBNb0k1N1pUZ1VNVHRS?=
 =?utf-8?B?NnRFTXUwWVpDdi9YdmpIWGJoaEtoZjZtRmRkemhlb0NZU0pMR3dZMkhpOU9u?=
 =?utf-8?B?RXd4a3NXSGZuU1F1VnFZN0Zob2l2ZHNadWN0UWMvNjh6MkwzK1dJN0JjaU52?=
 =?utf-8?B?Z1ZRUk53Ukc4Q0IzY3BBbnNCNHlib2Y3L1l4ZTZKbFRBS2UxREtQRUxIa1FJ?=
 =?utf-8?B?ZWJDQjVEcU4vbUtzSHEzUmxpclptaEkzMFRkcHN3a05lNTRYWHZvdFJpUDJD?=
 =?utf-8?Q?8KRDEFcilOv/AydFdLdxhoaZeA0vkZUR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFUOUlQbThsUmF1Sk94eFFtODJzelZZSGZUdUJWc0pDU1hHcnhxQlZUeWdp?=
 =?utf-8?B?dTB0N21nOFFWS1J3T0FOdXJUQ1BuYWhSMGl5cnBuVTFvMmlLdnBBOWJhYU04?=
 =?utf-8?B?VTNwTnMyRHl0Y3BjMGprUmdMc01DQWlQLzRWbUJlYm95MndqWHJvYmFVZTJE?=
 =?utf-8?B?OXdFcWs4b2lpTVhaSi9kM2lQMG10MDJoTmVBYSs1QVhSVGVrcnZOSUlkQnll?=
 =?utf-8?B?SEhsb3BxVFo4UjVkVHp6aFE0Nkxjb0dwcW82QTI4aVA4NHBQa0dUdnV3TUlX?=
 =?utf-8?B?STJxalJzSXFuUEh4UGEvOVBvQmg1WjNITXBjcmY2MElrQzl4bzlzVmVCRmUy?=
 =?utf-8?B?dGlmVkZML3NZWlQ1NTd6eDZpNGdJZWJMeTI5V29CU0ltL2JSdHdCeW9NcXhJ?=
 =?utf-8?B?SkFkM1ZVbkVMaWpQTUJ6SWxCSVlGTTVyNUFTclVBZXdaSFgvaDVQTXZmYzZV?=
 =?utf-8?B?Q1BuWGNQdG40bnFtZzY4YjZqTXRNV1g2V1Vid1hGMlpXb1RSTENFS1VFNVd1?=
 =?utf-8?B?bTd5VDJFNUthSHZZRzgyZStpdVJMMlpQRFU5T3pROFFPMi93dVA0WVZ6SkFW?=
 =?utf-8?B?UmgxaG1WWlVRQTltZGpEdURidkozY0VlM3ptZHRUbXhGZzNUS3V4L0RjK1ho?=
 =?utf-8?B?TytPNVBKSmgyZjliTktXT05ZNmtKTVlsOHFVT1NEOWNHV2d5dU5FeDNKR0l3?=
 =?utf-8?B?dU1UWExWMFhxVkFwNTY5MkNnL2hSN2JNRFFJTEhhdUJjM0E2NVRQTndKMU5k?=
 =?utf-8?B?YUVtVk5LUnF4UmRvcUZPeGo2VGFGTjY5R3hTYlFxaExIdmY2R2lZb3RQUVpL?=
 =?utf-8?B?YUxkd0czbVRQZkZkbnIwdUs4L1dzUFE0ODhRM0pQN0tOeTk3NzljQmREMWdo?=
 =?utf-8?B?UUQwQ09kY3FKVlZiaERaT3lsZkgzQnFMRkYyaS9kOHF6NG9uQTFhRmc1WlRx?=
 =?utf-8?B?NVpyUzlQTWRCVTZpa3NYSUgxMDN1Q0h5c09DRm1tRk10N3BZWUdGRVdseXlm?=
 =?utf-8?B?S0pUZXMxVERnUXNtc1JiRmU1dndXRWNzQmVvNjZMRjlHVHl5cHkvY3NVR1k2?=
 =?utf-8?B?VWJwYmZEYVFXZ2RUZW03K1AyT1R5Z2VTYmYxQkhkSzByYnYyMjZwM2lod0Y3?=
 =?utf-8?B?RnlTdjVsdE1EUjEyOUE3RlJZTDA1djhYZW5VTGxYd0tPdzVLWVVEenJDR2NF?=
 =?utf-8?B?dHJacTZncG14c2tkTWM4bHMxWGNiOTFQQm5xRm1nRWxzeDZqQ2R4UUx1NGhN?=
 =?utf-8?B?dXFuaU9kL0puRW4vaTNNVzZVTUxaLzBna0RMOXZ6ZEJGbFMzQTNQVmpsb3Aw?=
 =?utf-8?B?Vk44WFhIY3dqdmcxNm9rZHVpUDFpMlg3MHpkNXlsaExVUGpHR2lEcUVKRU43?=
 =?utf-8?B?V2VDcUI0SnFXZy9uQW9TdEQxZC8yZmVJQ3RCckJGc1NPTjIxUjJiZy9Zc0p2?=
 =?utf-8?B?Q1BqSWNMTXo1NUZGZ1FUcnRSSWVwSWFncEo5OXdPR29CTkk1MjFaYTNjdWJK?=
 =?utf-8?B?NDI5TGJTVGhvYnd4YzhxcnRJZGV3VjQ3Qi84N0x5M3E4cUh3emhOT0tsVUx0?=
 =?utf-8?B?aVU4U0FlanQ3MzZmN2trYTcreVpxd04wbW5qWjBsZm9ISEFxTjhjNDBuSGhi?=
 =?utf-8?B?ZlhuOUMvdElZRmVia0cxZ2tNNkV2OG9vN3dtZ0tlZTlWR2N6ZXlNRkVaeDk1?=
 =?utf-8?B?dytrZUk5UitBVTFKL3J4MGx2WGlnWjRFV2RZbmRzY091QnJOTHdGNkI1bDd4?=
 =?utf-8?B?RVVYODlqcTlhdkljYko2NFRDTnJlNVpVZUlPQWNhRC9qNWRWZUVpMEJvd0Nl?=
 =?utf-8?B?bmJ4MGJUM3d5eVN4Zm9qdkNSTW5ReWdvMmZRYzh6UGxNZXJrVGJvU3hzV05B?=
 =?utf-8?B?WTZOcUxCaFI1Q3BXNHZmWUgrRm0wc3lwLzJKbkFIcE9DK2dhRUE1dTlhSFN1?=
 =?utf-8?B?TGFqdS9rRTJqZ1E3QitMSWV2bzFWeTVGb1NtMkp2MXlYU1RtTy9zRFdYSmJa?=
 =?utf-8?B?ZUhON21DZDdYUVpkUC9iVS8vSGRDNHd1WTFLRk9nRlR6OW5BbnErTFBNYVpm?=
 =?utf-8?B?MWNxNXBCUkYvT3NxTnZDYnNMNTNuK0dNdEkreE1TRkZ4aFpQVmUrRStWb2Zz?=
 =?utf-8?Q?hNmVr9K5aZ3tsUfJc8G0I1qRj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b199f64-5b83-425e-3c9c-08de0aec7011
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 06:39:34.4925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRxDo+2snLQkDwefUMl08AmdWXdQoUmJMa0hGsKwuVzRkEhtn24HoS67O5B/Z+vbEze0G7M096caSHZWPoAgYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/14 10:31, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during
>> migration
>>
>> On 2025/10/13 10:50, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during
>>>> migration
>>>>
>>>> On 2025/9/10 10:37, Zhenzhong Duan wrote:
>>>>> If a VFIO device in guest switches from IOMMU domain to block domain,
>>>>> vtd_address_space_unmap() is called to unmap whole address space.
>>>>>
>>>>> If that happens during migration, migration fails with legacy VFIO
>>>>> backend as below:
>>>>>
>>>>> Status: failed (vfio_container_dma_unmap(0x561bbbd92d90,
>>>> 0x100000000000, 0x100000000000) = -7 (Argument list too long))
>>>>
>>>> this should be a giant and busy VM. right? Is a fix tag needed by the way?
>>>
>>> VM size is unrelated, it's not a bug, just current code doesn't work well with
>> migration.
>>>
>>> When device switches from IOMMU domain to block domain, the whole
>> iommu
>>> memory region is disabled, this trigger the unmap on the whole iommu
>> memory
>>> region,
>>
>> I got this part.
>>
>>> no matter how many or how large the mappings are in the iommu MR.
>>
>> hmmm. A more explicit question: does this error happen with 4G VM memory
>> as well?
> 
> Coincidently, I remember QAT team reported this issue just with 4G VM memory.

ok. this might happen with legacy vIOMMU as guest triggers map/unmap.
It can be a large range. But it's still not clear to me how can guest
map a range more than 4G if VM only has 4G memory.

> 
>>
>>>>
>>>>>
>>>>> Because legacy VFIO limits maximum bitmap size to 256MB which maps
>> to
>>>> 8TB on
>>>>> 4K page system, when 16TB sized UNMAP notification is sent,
>>>> unmap_bitmap
>>>>> ioctl fails.
>>>>>
>>>>> There is no such limitation with iommufd backend, but it's still not optimal
>>>>> to allocate large bitmap.
>>>>>
>>>>> Optimize it by iterating over DMAMap list to unmap each range with
>> active
>>>>> mapping when migration is active. If migration is not active, unmapping
>> the
>>>>> whole address space in one go is optimal.
>>>>>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>>> ---
>>>>>     hw/i386/intel_iommu.c | 42
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>> index 83c5e44413..6876dae727 100644
>>>>> --- a/hw/i386/intel_iommu.c
>>>>> +++ b/hw/i386/intel_iommu.c
>>>>> @@ -37,6 +37,7 @@
>>>>>     #include "system/system.h"
>>>>>     #include "hw/i386/apic_internal.h"
>>>>>     #include "kvm/kvm_i386.h"
>>>>> +#include "migration/misc.h"
>>>>>     #include "migration/vmstate.h"
>>>>>     #include "trace.h"
>>>>>
>>>>> @@ -4423,6 +4424,42 @@ static void
>>>> vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>>>>>         vtd_iommu_unlock(s);
>>>>>     }
>>>>>
>>>>> +/*
>>>>> + * Unmapping a large range in one go is not optimal during migration
>>>> because
>>>>> + * a large dirty bitmap needs to be allocated while there may be only
>> small
>>>>> + * mappings, iterate over DMAMap list to unmap each range with active
>>>> mapping.
>>>>> + */
>>>>> +static void vtd_address_space_unmap_in_migration(VTDAddressSpace
>>>> *as,
>>>>> +
>>>> IOMMUNotifier *n)
>>>>> +{
>>>>> +    const DMAMap *map;
>>>>> +    const DMAMap target = {
>>>>> +        .iova = n->start,
>>>>> +        .size = n->end,
>>>>> +    };
>>>>> +    IOVATree *tree = as->iova_tree;
>>>>> +
>>>>> +    /*
>>>>> +     * DMAMap is created during IOMMU page table sync, it's either
>> 4KB
>>>> or huge
>>>>> +     * page size and always a power of 2 in size. So the range of
>>>> DMAMap could
>>>>> +     * be used for UNMAP notification directly.
>>>>> +     */
>>>>> +    while ((map = iova_tree_find(tree, &target))) {
>>>>
>>>> how about an empty iova_tree? If guest has not mapped anything for the
>>>> device, the tree is empty. And it is fine to not unmap anyting. While,
>>>> if the device is attached to an identify domain, the iova_tree is empty
>>>> as well. Are we sure that we need not to unmap anything here? It looks
>>>> the answer is yes. But I'm suspecting the unmap failure will happen in
>>>> the vfio side? If yes, need to consider a complete fix. :)
>>>
>>> Not get what failure will happen, could you elaborate?
>>> In case of identity domain, IOMMU memory region is disabled, no iommu
>>> notifier will ever be triggered. vfio_listener monitors memory address
>> space,
>>> if any memory region is disabled, vfio_listener will catch it and do dirty
>> tracking.
>>
>> My question comes from the reason why DMA unmap fails. It is due to
>> a big range is given to kernel while kernel does not support. So if
>> VFIO gives a big range as well, it should fail as well. And this is
>> possible when guest (a VM with large size memory) switches from identify
>> domain to a paging domain. In this case, vfio_listener will unmap all
>> the system MRs. And it can be a big range if VM size is big enough.
> 
> Got you point. Yes, currently vfio_type1 driver limits unmap_bitmap to 8TB size.
> If guest memory is large enough and lead to a memory region of more than 8TB size,
> unmap_bitmap will fail. It's a rare case to live migrate VM with more than 8TB memory,
> instead of fixing it in qemu with complex change, I'd suggest to bump below MACRO
> value to enlarge the limit in kernel, or switch to use iommufd which doesn't have such limit.

This limit shall not affect the usage of device dirty tracking. right?
If yes, add something to tell user use iommufd backend is better. e.g
if memory size is bigger than the limit of vfio iommu type1's dirty
bitmap limit (query cap_mig.max_dirty_bitmap_size), then fail user if
user wants migration capability.

> /*
>   * Input argument of number of bits to bitmap_set() is unsigned integer, which
>   * further casts to signed integer for unaligned multi-bit operation,
>   * __bitmap_set().
>   * Then maximum bitmap size supported is 2^31 bits divided by 2^3 bits/byte,
>   * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
>   * system.
>   */
> #define DIRTY_BITMAP_PAGES_MAX   ((u64)INT_MAX)
> #define DIRTY_BITMAP_SIZE_MAX    DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
> 
>>
>>>>
>>>>> +        IOMMUTLBEvent event;
>>>>> +
>>>>> +        event.type = IOMMU_NOTIFIER_UNMAP;
>>>>> +        event.entry.iova = map->iova;
>>>>> +        event.entry.addr_mask = map->size;
>>>>> +        event.entry.target_as = &address_space_memory;
>>>>> +        event.entry.perm = IOMMU_NONE;
>>>>> +        /* This field is meaningless for unmap */
>>>>> +        event.entry.translated_addr = 0;
>>>>> +        memory_region_notify_iommu_one(n, &event);
>>>>> +
>>>>> +        iova_tree_remove(tree, *map);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>     /* Unmap the whole range in the notifier's scope. */
>>>>>     static void vtd_address_space_unmap(VTDAddressSpace *as,
>>>> IOMMUNotifier *n)
>>>>>     {
>>>>> @@ -4432,6 +4469,11 @@ static void
>>>> vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>>>>         IntelIOMMUState *s = as->iommu_state;
>>>>>         DMAMap map;
>>>>>
>>>>> +    if (migration_is_running()) {
>>>>
>>>> If the range is not big enough, it is still better to unmap in one-go.
>>>> right? If so, might add a check on the range here to go to the iova_tee
>>>> iteration conditionally.
>>>
>>> We don't want to ditry track IOVA holes between IOVA ranges because it's
>> time consuming and useless work. The hole may be large depending on guest
>> behavior.
>>> Meanwhile the time iterating on iova_tree is trivial. So we prefer tracking
>> the exact iova ranges that may be dirty actually.
>>
>> I see. So this is the optimization. And it also WA the above DMA
>> unmap issue as well. right? If so, you may want to call out in the
>> commit message.
> 
> Yes, the main purpose of this patch is to fix the unmap_bitmap issue, then the optimization.
> I'll rephrase the description and subject.

yes. The commit message gives me the impression this is bug fix. While
subject is optimization. BTW. perhaps call it as an optimization is
clearer since this smells more like an optimization. For fix, I guess
you may need to consider the vfio_listener as well.

Regards,
Yi Liu

