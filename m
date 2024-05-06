Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EE7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3o82-0003xT-TK; Sun, 05 May 2024 22:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3o80-0003wj-Jx
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:30:57 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3o7x-0002l3-Gh
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714962653; x=1746498653;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3xl8QDanmRWaID8VaEPWrR5qZQBLYawX6gXTvY2z1Gw=;
 b=nTC9oK7LHAhmJQihiXCO7OkgfuAM1h8yuoV1mdmgh9dzC6wRuCmrHTrN
 XPueESrSTjF/8gEHDNH2+anJjqbcyyBwfAPfMDn0991+NK0MzhyorHm6A
 lczbiaD5ekSMb4NkvLaFhyNNdiLFwo4GQoDne48I8hQ/hynHrn7XgWs0E
 mGPcrWzii8yZ40/M598wiT3QIMTYpkVRvRG+WBjmyE0DhIQYl2hl2rU6Z
 qzM7qKnNZzhclXiwRafLjUPR8RNOTqbiFVinA+BSYB45re2vPQpptOenh
 xLY5g+e1ZQQACVCJJAJa7jkVR4PKn71dqVNZwyzZxt5CM1cGOYpCx3Lev Q==;
X-CSE-ConnectionGUID: AZtqSaO1Q8mYLz/dQ2IfCA==
X-CSE-MsgGUID: NRUyxQJuTu2MGRBNyGg8GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10523884"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10523884"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2024 19:30:50 -0700
X-CSE-ConnectionGUID: kjUsRF7uRG6efgCtcbF4FQ==
X-CSE-MsgGUID: 5AyVMvBLT6Gpr/zVvEi6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28600948"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 May 2024 19:30:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 19:30:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 19:30:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 19:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYptaegn3JacSavXR3qFi/WsWZGJChtFfe4CScj45zoH+0k4chE5vO1VNeezHDxeDk8pnD4Z5wyJL0qoVn1fBnLLHNzuJGf+6/pDBNliXMzbh4Z9/kT/zdq1m+mZ9IZMRDJNPi2TyzGEC0EwUhP2PMm508gqpewYb9Oy/xIkipYJCGjKmL4N8ORHmvjcTcMJ1+h5bIAjb7RfwqG6U82uM2S5m5lANrIMZYe+iPEpUcweOt5iguGIgmWTj7u2wAoQcniHI5++4QXQxmoM83/OQchmunwuPl1zDf/CCzoYSKrzfCqleUMtYFYMz3M8s6HMaGytOoLVMZ+NMQLnk6Z/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xl8QDanmRWaID8VaEPWrR5qZQBLYawX6gXTvY2z1Gw=;
 b=lcqp+wt6SphLGlgvoh+o+Gv2zZt1GvccDx18cFBypRjUwkxa5tP5rEk+jpdjhjq+vcvmreyEHVliJS5NqBQ3pINUlNhQxr3cbLSWLxFjfBh8T87qmTGsPKc7dyVTbNK0EFGbX63n3ngCChxu1IhsHIBqFnZ7tjhMu+sqG0b2B2Glj2/PMO9R2/GoVdJNeJQ9BwbVrtG59/TB4Ue9ixIfHZAIyi0hwQP1CrzK3bl8uBwbaelkUiqdx5ITIlejiT9VMu3Y/Nambs2y0FNSFoPU8JpxPuiGNClQRWplSGZI2s7mDE3DBCIB2E/gk4xl32u1C+oKl5NxhKd/BAQf66e9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 6 May
 2024 02:30:47 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 02:30:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Topic: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Index: AQHamgH7eck8+te5Z0qCq1cTh3hQ5rGFkZiAgAPqERA=
Date: Mon, 6 May 2024 02:30:47 +0000
Message-ID: <SJ0PR11MB6744A435E58FC69DF37AA148921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
In-Reply-To: <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6379:EE_
x-ms-office365-filtering-correlation-id: 8a6ccf22-70a9-4d30-634d-08dc6d74898f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?YUZYSlIybjlZZjBKbU8xY3cxOGlYbFZSZUs5aHA2RzR0Sk9SdmRhSFEvaW9k?=
 =?utf-8?B?eHhoQzhhYndYYzVZWGJEeTBYTjNxRGlvcDlqemFDZFVOenhjU0RXL3Q4WGJ0?=
 =?utf-8?B?emtLMTlxOUIrY2E1K3VHS2ZpSitaL0RwOElETnRaUVdQZXNCWnBxNDF6MFlV?=
 =?utf-8?B?Q010Z1FLVStxY0syank0MEs3TFBYR2NXYThHamNGa3BYc3RlVlNRSGJHRDBV?=
 =?utf-8?B?M3Z2UnhzUm41SVBnZVVXSUpwM0I1cUlkZVNvQ1ZaWUVNNHZNUXVJc1NKSTVP?=
 =?utf-8?B?MWcreS9CVFNNTTNGWngvbVBJTlR2YW9OT2hUcnVLdm5Uek9jNmIwa1grRnBH?=
 =?utf-8?B?NVFSTHpXQTdTb21rQzFDSCtGOXBmZWIrTHZyaFdTMkxIa1UvSGppMmd3d2dT?=
 =?utf-8?B?UHI4bnByS1pSMFZrNFF3SFRlNU1HNzdkQmErQy9MVzJQRkEwV0ZwUVIrRzBK?=
 =?utf-8?B?cHBQS0xTbEVzZjBId1hhTHZjaHlweUpTM0dHcncxQXlETlcwTzNuMzNPK3FF?=
 =?utf-8?B?dHBiUVdIOTZRZkdHTnpxb082eVgzTVI1dFR6YytVaWFteU1tUnkzeGhiQU1W?=
 =?utf-8?B?eng2aDl1QXdBcWoyemNXZ0xZVHJjWjR0YXB0R2JQa2I0Q29KQjVMTGxLeFRW?=
 =?utf-8?B?Y2plUG14T3Bna3BraFMxZGdYUTNldVNFMkJ1V2xyNW9nVG5zemlxNTc4bDJw?=
 =?utf-8?B?ME1ySjIwaS8wT1JZUlRGa29JMzBpZUZVa1ZodC80bHRHUmZnVGZCeWlITDJP?=
 =?utf-8?B?V0pyWTNHTWNEK3I4Y2xLQ0FrblVuMENUaStvZDlPVTJPbnJvcWFzdXM1SVJh?=
 =?utf-8?B?UzZuVVFhazRSS0g5eDNVVER4WktVcnlvK0ZhWkp3ejNOYXFlYjZkdE5BRHUv?=
 =?utf-8?B?UGZ2Sys1djNGT1B5S2lja0JJVjVXYjBpRFFWWC8rWjBwdWJZWXdqb2hEQ2Z6?=
 =?utf-8?B?c0FQNE16dHR6WE52emZ5RU94RWNhZHNZSDRHbStrL043QXYrS1R3bnErZU5m?=
 =?utf-8?B?K2IvVkdjb092OTFqZFdIQWF6cldpdHFCSWJBRTJNeEpQLzRwM1BoRG1mdlRn?=
 =?utf-8?B?Tkk2cGJydWFkYnFKaTEwcUJqejEzUkpkT1pYL2NqZ1kvREZsdXpLTWsxVVd3?=
 =?utf-8?B?bWdkdlk2THhyOVRpbzlHVkp1VjR6V3R0V0VPWCtRZVBSY2tjNXQ2VGRaVWZq?=
 =?utf-8?B?TkZuTGhCM3NrRThPUDd4MnlIWEt3amt2QlcybTB0bGxxNy9zNmVVYWNlNmZJ?=
 =?utf-8?B?cTQrbU50QzJGT3hnY2pwejNBSWErQkNHaTd4T2ZMYThJNjRhUldKaSt3YlMz?=
 =?utf-8?B?K0I1dEJpZTg5Y3djOC9VakR1eHIxMGcxVmVSNmdLTUNXd2habXRQcDJTdzQ4?=
 =?utf-8?B?VXdsV1VObTg0M21XNVJMRWcwVytlN3p5SDNyYlpVa2lkakE0MDBJR2ZueExQ?=
 =?utf-8?B?MVQ1cTNkMjFCcHdRQmJVMEkyUWpzYnlqU1hvd3EySmFVL1BRbXZ3ZUx1TEN3?=
 =?utf-8?B?dnc1Zm9LNGJ4YTVRWjNkTnV3SlFGd2FOYVBvSlZnRkxOTStPRXRnZ1VyQ3U4?=
 =?utf-8?B?clRIT0dDOU5SZlNpMUNTNzBCSnFsTXVaQTNBRUg1cW53bVFWL3dWMHFJbXJl?=
 =?utf-8?B?dVpjQk9hZEt2R0NxbDJuM2xkSis1eG5ra2tMR1ZKdGlDTml6S280Uzc5TkRE?=
 =?utf-8?B?bVh4dXZtZXpiOXA5WXFhZ2RzRUEvOXVJOWxjTzRWV3BRYWk1Um9WMG40U1pX?=
 =?utf-8?Q?4ZI6+ur/m+Ypgiy+wA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0IwUlRkbTB1UzVaeGdIUlVLVHNlNlU3d2t2NjAyQWlXbmpMMjllbkxhclZw?=
 =?utf-8?B?OEhMWUV1cHRSTDR5WUVobGthRzQwVW5STG5pWnN4MGU5N3FJWUZTVS9TRWV3?=
 =?utf-8?B?U0ZEdFk3V1YwR3l2YnNpZlhtZjBrRjNvWTA3NVpubTNBTDhaVndabGg0Q0ZQ?=
 =?utf-8?B?QVVabEgzeUJXUjZSbjhZZ1JJM2JRYmFVVk5CaVAzT2hsS0xzcXdWakxWcFhW?=
 =?utf-8?B?RDN3aUpwWHhLNi82cThlL3lvQVo4bzBQK1BSdnQxMDhvd2FEakgrVko4YWRa?=
 =?utf-8?B?RFFFWGJaVVNDSEhSejM4WFJ4U2hidDNmU2w5MVQxZTJVMnhHU3ZVWm9YRXVa?=
 =?utf-8?B?cEN3cEJtaHQzSEhHOUxYaGNpMzRhUkI3YkJhdkJLbUVRQUwzQWxqTVdrcGVt?=
 =?utf-8?B?UkFMczhlbDF1b0szZzhCdG5ZbjVVREJUaGZKbFY1VWVvamZLMHhmQ3VTM0hZ?=
 =?utf-8?B?N2p6L3RDVzlMMXB4TkNGdW9SYmhlNjZxWnpvYnBHd1k1RVNQM2ZWU2N4TXpX?=
 =?utf-8?B?ZVlPczhrQUIxdUNLc09oVFhPYnFsR051SHhwSmxla1lMQ1hXUnduc3V3bW1U?=
 =?utf-8?B?dE0rT1l0NVVrdGVHMmtWYVNSNStEOVJDeUl6UnNkN1JKVGpOaDF6czR5Ty80?=
 =?utf-8?B?WnliNjZLUEtSWUg3d1JWWlUxUW45elRoTGs2MjBteGJ5cXk0QnA0b3lFZUFs?=
 =?utf-8?B?MSsrT3ErQWh3QjN0VEVOL1hGUitSUmNnaktQNSs3TU42OHVFbWxFQnRzZUw4?=
 =?utf-8?B?UmJLZE9zeGNwVkFYSlhwMURBUmpWNHV0aDgwK1pkNlljNW94TmQ4QnJjSyt1?=
 =?utf-8?B?SWREVDFWWDJGMmE5L1d0T2ZQY1F5NEtlOVMra3huR2NzbkcwOEhWL2dZcnZQ?=
 =?utf-8?B?ams4K212UGthaG1HOTMwTnlsbjFSb1plVFZRYlRYVDJZQ2kzTll4N0c4Y1RP?=
 =?utf-8?B?UzRTNE1DMTNiMTVRK0J5WjFkN1U3eEhTbXRxR2ZDcS9iVnoveUt5dE1ZZXM1?=
 =?utf-8?B?RTBrYW9WcW8rMW1QclNTM1pMMmxDdUxlTGk0TkVSMDR0bzlCRXVhT21DaU1X?=
 =?utf-8?B?OHFwZUltOEtZL0ZxemY1dEhVRjNDQnd3aWNxZHZDZFQrUzltQXRXYWR3NnQx?=
 =?utf-8?B?Y0dCQ3VtNXBHTVRWZmlnTFFQWnRKcUJJQVVNc2xWc25heTh5bi9URGhjNkdi?=
 =?utf-8?B?Z3BwRFM1TnRHOXlnaW1wR2xxOURkbXRkY0tMUnQ1MFRQZEgyOHltWEhjemJn?=
 =?utf-8?B?MnhGaDgvKzYzamthcEJ3Y1ptcFo0aXZnYWs1WjlFeXNGNGQ1QWtRVHVzVWRT?=
 =?utf-8?B?SUxNdVBQMlkxdU5JT01qdStaZThKemNYbUhEbUljSWFsKzNmWWxMd3dwZGR0?=
 =?utf-8?B?YVhmOUV0aTNUZ2JpRStxSmtEdmZ6Q0ZhWEJld0VXc3NwbjFHcnpNU2ROeHJr?=
 =?utf-8?B?aFdneElMeisrMlhkamhkQTFwYWxMTUhmZWYrd2swZ2hobSt0QU1heUtNRk5C?=
 =?utf-8?B?OThBRlAyUllnUzlWMDkxd3FETnJMVDB4MmMrUzB0ZW1NTnhra1JZMFFINytQ?=
 =?utf-8?B?TkZucUxDRm1ETlRRWUVEdnZobjRpbmNFSjNFakVzRCtNbTBWWi8ybHlKZVlw?=
 =?utf-8?B?ekVFd2U5Wi9wSEdsQ2hZd3lON3BHaW94bGhqa1lnR2drc0dpdGZNK2ZmSVBG?=
 =?utf-8?B?MEZZVkNuRFg1anJVZUdxNTFXbkRjWEhISHlEUFBQQ1BzZXdINjlyVmRTQUZL?=
 =?utf-8?B?cWppS2s3L2ZJZ0xnM3AwejFIZzUwaUl2eFVvcjFpMUpCaGZCNlRTbVV2Uk8v?=
 =?utf-8?B?SFFNZ2t5TWsrTGxNb3B4SUhNbWRabGxnSG9FM21kWTJOVFZ4K25xeEZPc1VD?=
 =?utf-8?B?ejRuRlBlcEU3RkE3SnpSZm5NOGF6YS9HSlQ0WVFaMnhYMWlaR21KMFM0K2M3?=
 =?utf-8?B?aFNVRUtMMnpjZHNpbkEyZ2g3OVpWdlNSSzJENWZxNVgzUEtFQ3NIbDhuSjhB?=
 =?utf-8?B?RmZaMDVRK0tDVVNsaUxub0xjb2EzM2FpSVpVREgrS01Bek13K0xHVE5HME9C?=
 =?utf-8?B?d211TmwrUWxLcnF1eTExOW11cnVrTHZ0eGExMktRd1ZLUHYvS1p2K0lOaHRF?=
 =?utf-8?Q?ehnU1jCNVM0evdaHc/mRa0lmn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6ccf22-70a9-4d30-634d-08dc6d74898f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 02:30:47.1112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB3r1XGV/TOzrLNBLGInDmxroWnim9vl9WfrcSdytHf7UCdf4V3Je6kxWy62S2KcxwGBDpSjDaXtKk6gMEIC5fERI0yQSMF07aORnS9xT+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgTWF5IDMsIDIwMjQg
MTA6MDQgUE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
OyBxZW11LQ0KPmRldmVsQG5vbmdudS5vcmcNCj5DYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5j
b207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207DQo+cGV0ZXJ4QHJlZGhh
dC5jb207IGphc293YW5nQHJlZGhhdC5jb207IGpnZ0BudmlkaWEuY29tOw0KPm5pY29saW5jQG52
aWRpYS5jb207IGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb207IFRpYW4sIEtldmluDQo+PGtldmlu
LnRpYW5AaW50ZWwuY29tPjsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBQZW5nLCBD
aGFvIFANCj48Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMg
MDAvMTldIEFkZCBhIGhvc3QgSU9NTVUgZGV2aWNlIGFic3RyYWN0aW9uIHRvDQo+Y2hlY2sgd2l0
aCB2SU9NTVUNCj4NCj5PbiA0LzI5LzI0IDA4OjUwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+
IEhpLA0KPj4NCj4+IFRoZSBtb3N0IGltcG9ydGFudCBjaGFuZ2UgaW4gdGhpcyB2ZXJzaW9uIGlz
IGluc3Ryb2R1Y2luZyBhIGNvbW1vbg0KPj4gSG9zdElPTU1VRGV2aWNlQ2FwcyBzdHJ1Y3R1cmUg
aW4gSG9zdElPTU1VRGV2aWNlIGFuZCBhIG5ldw0KPmludGVyZmFjZQ0KPj4gYmV0d2VlbiB2SU9N
TVUgYW5kIEhvc3RJT01NVURldmljZS4NCj4+DQo+PiBIb3N0SU9NTVVEZXZpY2VDbGFzczo6cmVh
bGl6ZSgpIGlzIGludHJvZHVjZWQgdG8gaW5pdGlhbGl6ZQ0KPj4gSG9zdElPTU1VRGV2aWNlQ2Fw
cyBhbmQgb3RoZXIgZmllbGRzIG9mIEhvc3RJT01NVURldmljZSB2YXJpYW50cy4NCj4+DQo+PiBI
b3N0SU9NTVVEZXZpY2VDbGFzczo6Y2hlY2tfY2FwKCkgaXMgaW50cm9kdWNlZCB0byBxdWVyeSBo
b3N0IElPTU1VDQo+PiBkZXZpY2UgY2FwYWJpbGl0aWVzLg0KPj4NCj4+IEFmdGVyIHRoZSBjaGFu
Z2UsIHBhcnQyIGlzIG9ubHkgMyBwYXRjaGVzLCBzbyBtZXJnZSBpdCB3aXRoIHBhcnQxIHRvIGJl
DQo+PiBhIHNpbmdsZSBwcmVyZXF1aXNpdGUgc2VyaWVzLCBzYW1lIGZvciBjaGFuZ2Vsb2cuIElm
IGFueW9uZSBkb2Vzbid0IGxpa2UNCj4+IHRoYXQsIEkgY2FuIHNwbGl0IGFnYWluLg0KPj4NCj4+
IFRoZSBjbGFzcyB0cmVlIGlzIGFzIGJlbG93Og0KPj4NCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAuY2Fwcw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IC5yZWFsaXplKCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAuY2hlY2tfY2FwKCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfA0KPj4gICAgICAgICAgICAgIC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICB8DQo+PiBIb3N0SU9NTVVEZXZpY2VMZWdhY3lWRklPICB7
SG9zdElPTU1VRGV2aWNlTGVnYWN5VkRQQX0NCj5Ib3N0SU9NTVVEZXZpY2VJT01NVUZEDQo+PiAg
ICAgICAgICAgICAgfCAudmRldiAgICAgICAgICAgICAgICAgIHwgey52ZGV2fSAgICAgICAgICAg
ICAgfCAuaW9tbXVmZA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgLmRldmlkDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBbLmlvYXNfaWRdDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCBbLmF0dGFjaF9od3B0KCldDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBbLmRldGFjaF9od3B0KCldDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgSG9zdElPTU1VRGV2aWNlSU9NTVVGRFZGSU8NCj57SG9zdElPTU1VRGV2aWNlSU9NTVVGRFZE
UEF9DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAudmRl
diAgICAgICAgICAgICAgICB8IHsudmRldn0NCj4+DQo+PiAqIFRoZSBhdHRyaWJ1dGVzIGluIFtd
IHdpbGwgYmUgaW1wbGVtZW50ZWQgaW4gbmVzdGluZyBzZXJpZXMuDQo+PiAqIFRoZSBjbGFzc2Vz
IGluIHt9IHdpbGwgYmUgaW1wbGVtZW50ZWQgaW4gZnV0dXJlLg0KPj4gKiAudmRldiBpbiBkaWZm
ZXJlbnQgY2xhc3MgcG9pbnRzIHRvIGRpZmZlcmVudCBhZ2VudCBkZXZpY2UsDQo+PiAqIGkuZS4s
IGZvciBWRklPIGl0IHBvaW50cyB0byBWRklPRGV2aWNlLg0KPj4NCj4+IFBBVENIMS00OiBJbnRy
b2R1Y2UgSG9zdElPTU1VRGV2aWNlIGFuZCBpdHMgc3ViIGNsYXNzZXMNCj4+IFBBVENINS0xMTog
SW50cm9kdWNlIEhvc3RJT01NVURldmljZUNhcHMsIGltcGxlbWVudCAucmVhbGl6ZSgpDQo+YW5k
IC5jaGVja19jYXAoKSBoYW5kbGVyDQo+PiBQQVRDSDEyLTE2OiBDcmVhdGUgSG9zdElPTU1VRGV2
aWNlIGluc3RhbmNlIGFuZCBwYXNzIHRvIHZJT01NVQ0KPj4gUEFUQ0gxNy0xOTogSW1wbGVtZW50
IGNvbXBhdGliaWxpdHkgY2hlY2sgYmV0d2VlbiBob3N0IElPTU1VIGFuZA0KPnZJT01NVShpbnRl
bF9pb21tdSkNCj4+DQo+PiBRZW11IGNvZGUgY2FuIGJlIGZvdW5kIGF0Og0KPj4NCj5odHRwczov
L2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS96aGVuemhvbmcvaW9tbXVmZF9uZXN0aW5n
X3ByZQ0KPnFfdjMNCj4+DQo+PiBCZXNpZGVzIHRoZSBjb21wYXRpYmlsaXR5IGNoZWNrIGluIHRo
aXMgc2VyaWVzLCBpbiBuZXN0aW5nIHNlcmllcywgdGhpcw0KPj4gaG9zdCBJT01NVSBkZXZpY2Ug
aXMgZXh0ZW5kZWQgZm9yIG11Y2ggd2lkZXIgdXNhZ2UuIEZvciBhbnlvbmUNCj5pbnRlcmVzdGVk
DQo+PiBvbiB0aGUgbmVzdGluZyBzZXJpZXMsIGhlcmUgaXMgdGhlIGxpbms6DQo+Pg0KPmh0dHBz
Oi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS90cmVlL3poZW56aG9uZy9pb21tdWZkX25lc3Rp
bmdfcmZjDQo+djINCj4NCj4NCj52NCBzaG91bGQgYmUgYSBnb29kIGNhbmRpZGF0ZSwgd2Ugd2ls
bCBuZWVkIGZlZWRiYWNrIGZyb20gdGhlIHZJT01NVQ0KPm1haW50YWluZXJzIHRob3VnaC4NCj4N
Cj5Ib3dldmVyLCBoYXZlIHlvdSBjb25zaWRlcmVkIGFub3RoZXIvY29tcGxlbWVudGFyeSBhcHBy
b2FjaCB3aGljaA0KPndvdWxkIGJlIHRvIGNyZWF0ZSBhbiBob3N0IElPTU1VIChpb21tdWZkKSBi
YWNrZW5kIG9iamVjdCBhbmQgYQ0KPnZJT01NVQ0KPmRldmljZSBvYmplY3QgdG9nZXRoZXIgZm9y
IGVhY2ggdmZpby1wY2kgZGV2aWNlIGJlaW5nIHBsdWdnZWQgaW4gdGhlDQo+bWFjaGluZSA/DQoN
CkkgZGlkIGNvbnNpZGVyIGFib3V0IGEgc2luZ2xlIGlvbW11ZmQgaW5zdGFuY2UgZm9yIHFlbXUg
YW5kIGZpbmFsbHkgY2hvc2UNCnRvIHN1cHBvcnQgbXVsdGlwbGUgaW9tbXVmZCBpbnN0YW5jZXMs
IHJlYXNvbiBiZWxvdzoNCg0KSSB3YXMgdGFraW5nIGlvbW11ZmQgYXMgYSBiYWNrZW5kIG9mIFZG
SU8gZGV2aWNlIG5vdCBhIGJhY2tlbmQgb2YgdklPTU1VLg0KU28gdGhlcmUgaXMgYW4gaW9tbXVm
ZCBwcm9wZXJ0eSBsaW5rZWQgdG8gaW9tbXVmZCBpbnN0YW5jZXMuDQpXZSBkbyBzdXBwb3J0IG11
bHRpcGxlIGlvbW11ZmQgaW5zdGFuY2VzIGluIG5lc3Rpbmcgc2VyaWVzIGp1c3QgYXMNCndlIGRv
IGluIGNkZXYgc2VyaWVzLCBzdWNoIGFzOg0KDQotZGV2aWNlIGludGVsLWlvbW11LGNhY2hpbmct
bW9kZT1vbixkbWEtZHJhaW49b24sZGV2aWNlLWlvdGxiPW9uLHgtc2NhbGFibGUtbW9kZT1tb2Rl
cm4NCi1vYmplY3QgaW9tbXVmZCxpZD1pb21tdWZkMA0KLWRldmljZSB2ZmlvLXBjaSxob3N0PTZm
OjAxLjAsaWQ9dmZpbzAsYnVzPXJvb3QwLGlvbW11ZmQ9aW9tbXVmZDANCi1vYmplY3QgaW9tbXVm
ZCxpZD1pb21tdWZkMQ0KLWRldmljZSB2ZmlvLXBjaSxob3N0PTZmOjAxLjEsaWQ9dmZpbzEsYnVz
PXJvb3QxLGlvbW11ZmQ9aW9tbXVmZDENCi1kZXZpY2UgdmZpby1wY2ksaG9zdD02ZjowMS4yLGlk
PXZmaW8yLGJ1cz1yb290Mg0KDQpBZGRpbmcgaW9tbXVmZCBwcm9wZXJ0eSB0byB2SU9NTVUgd2ls
bCBsaW1pdCB0aGUgd2hvbGUgcWVtdSB0byB1c2Ugb25seQ0Kb25lIGlvbW11ZmQgaW5zdGFuY2Us
IGl0J3MgYWxzbyBjb25mdXNpbmcgaWYgdGhlcmUgaXMgYWxzbyB2ZmlvIGRldmljZSB3aXRoIGxl
Z2FjeQ0KYmFja2VuZC4NCg0KSSdtIG5vdCBjbGVhciBob3cgdXNlZnVsIG11bHRpcGxlIGlvbW11
ZmQgaW5zdGFuY2VzIHN1cHBvcnQgYXJlLg0KT25lIHBvc3NpYmxlIGJlbmVmaXQgaXMgZm9yIHNl
Y3VyaXR5PyBJdCBtYXkgYnJpbmcgYSBzbGlnaHRseSBmaW5lLWdyYWluZWQNCmlzb2xhdGlvbiBp
biBrZXJuZWwuDQoNCldlIGNhbiBkaXNjdXNzIHRoaXMgZnVydGhlciwgaWYgaXQncyB1bm5lY2Vz
c2FyeSB0byBzdXBwb3J0IG11bHRpcGxlIGlvbW11ZmQNCmluc3RhbmNlcyBpbiBuZXN0aW5nIHNl
cmllcywgSSBjYW4gY2hhbmdlIHRvIHNpbmdsZSBpb21tdWZkIGluc3RhbmNlIHN1cHBvcnQNCmFu
ZCBhZGQgYW4gaW9tbXVmZCBwcm9wZXJ0eSBmb3IgdklPTU1VIGp1c3QgYXMgeW91IHN1Z2dlc3Rl
ZC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPlNvbWV0aGluZyBsaWtlLA0KPg0KPiAgICAg
LWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTIzLGNoYXNzaXM9OCxpZD1wY2kuOCxidXM9cGNp
ZS4wIFwNCj4gICAgIC1vYmplY3QgaW9tbXVmZCxpZD1pb21tdWZkMSBcDQo+ICAgICAtZGV2aWNl
IGludGVsLWlvbW11LGludHJlbWFwPW9uLGRldmljZS1pb3RsYj1vbixjYWNoaW5nLQ0KPm1vZGU9
b24saW9tbXVmZD1pb21tdWZkMSBcDQo+ICAgICAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDow
ODoxMC4wLGJ1cz1wY2kuMSxpb21tdWZkPWlvbW11ZmQwDQo+DQo+VGhlIHZJT01NVSBkZXZpY2Ug
d291bGQgYmUgbGlua2VkIHRvIHRoZSBob3N0IElPTU1VIChpb21tdWZkKSBiYWNrZW5kDQo+b2Jq
ZWN0IGF0IHJlYWxpemUgdGltZSBhbmQgaXQgd291bGQgc2ltcGxpZnkgdGhlIGRpc2NvdmVyeSBv
ZiB0aGUgaG9zdA0KPklPTU1VIHByb3BlcnRpZXMuIFRoZSBpbXBsZW1lbnRhdGlvbiB3b3VsZCBi
ZSBtb3JlIHN0cmFpZ2h0IGZvcndhcmQuDQo+DQo+VGhhdCBzYWlkLCBJIGRpZG4ndCBzdHVkeSBk
ZWVwbHkgd2hhdCBuZWVkcyB0byBiZSBkb25lLiBUaGUgdklPTU1VDQo+aW1wbGVtZW50YXRpb24g
aXMgbm90IHJlYWR5IHlldCB0byBzdXBwb3J0IG11bHRpcGxlIGluc3RhbmNlcyBhbmQgc29tZQ0K
Pm1hc3NhZ2luZyBpcyBuZWVkZWQgdG8gY2hhbmdlIHRoYXQgZmlyc3QuDQoNCg0K

