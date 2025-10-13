Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323DFCCD187
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 02:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v88dl-0006yv-Ol; Sun, 12 Oct 2025 22:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v88di-0006yS-0a
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 22:50:22 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v88df-0001mP-86
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 22:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760323820; x=1791859820;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F9uCdfCN8xwaz9DWqFvsz6fkmKEMqFJ3xDRDyy+zbOU=;
 b=IEc1LqhzVk+ODTsh0oZsb+Eul3O/KVlHSXJqNZ15g5oSSKOAeqXWj5WX
 J8QbfAKi0Q//2ZXOJryNm1ynAvHKEc2MP4imHjOQXWeWUDaqoxiEjoh08
 quLgtPUV2SDLTnehnvaXEY6VrAQXMX1trk/uPKmE4P+4MIP2eYBZv5+nX
 XqKhY/O6PXKGDTqvtqIpdOGrjhkPMrkmDWW/tRMH8UHbB0AXR1jR0ANOV
 3QsCuF3i0O3A0dlRsRPnKVb5RU0dnxq5tgMJWFBw52UbEM4sGz2MDgzyQ
 tkKzb8t0DEvM6N3wvs6KjCB8/9KIqGmOL17l3CLi9dsfIyTTMqB1Th4II w==;
X-CSE-ConnectionGUID: OcxRxMnsSA6vW0lJ38YW1A==
X-CSE-MsgGUID: hH1d7sKnSWqWPCNmq6RrcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73557525"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="73557525"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 19:50:13 -0700
X-CSE-ConnectionGUID: YWQgZ2TnT/SBqUEXGKm4xA==
X-CSE-MsgGUID: 7y4T+k+QT/6vEDkgPVBWbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181299532"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 19:50:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 19:50:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 19:50:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 19:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7m1my63PD3IGAY7zJSOTcCmzSdDVremprowqSHLVIv7WhbZPbbuTfTdY+PNAKuhsQetFZpIXWfmaniU5Fda+xXZzGPCIT8Ct+ui/XXAu2ywcKb3a4fOLrzhGe8A7f1zTNuI0hDO2UB6hCVaDH0sXF2FB1vHZ8SiEKo2vfaA6HKz/OSwqD2G4V3s3yuDL6hZ2dlc61V8uxNIt5P3sBNQ6yw59GxMjTG7GBQH9Zn/opqH1qbeZHKiBF1KJ4f0H5PXXo9LkohBnt5v7a8zfvcuPdKFZNtacGHs4hpy4nwpTotfcyR8Heui61RzOP4HEAjl38Fjkd0yz440f5fp58Vp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9uCdfCN8xwaz9DWqFvsz6fkmKEMqFJ3xDRDyy+zbOU=;
 b=yRLnBvnkKuAfB4rkDoD7Fx4HILg3C9Ee3CUKyzpFQUY7GeEMAyBiAK8p0apcSeiLOFlR/MG2mfQkH2xfXJ9GD7mcu4dpCQlPcrvobSQDPI/aCiZHcRi0jn7HtDWyTj9bvmivQek411soF69wIZ77tMRxNsLxbASIZrLbYevSyJmibvcUy4McJBp68wKhsp6qAwrb4fXSh2tsGBumXzZTX4ULs77nmtJts4Hs8eSMWXBLJxr+yip6IWDBsGHOilU7tzFhJIfIB/t6uY7xcfBIjn5r6PUfB6kp4uGH/B/ONliYoNP+lg8FC+lbmu8/0ngMGMzGX/J3hOI1FNM/MX0fsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SN7PR11MB6827.namprd11.prod.outlook.com
 (2603:10b6:806:2a2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 02:50:08 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 02:50:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
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
Subject: RE: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Topic: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Index: AQHcIfvpBR8EG6fncUCmXH17xc4ayLS+gq4AgAEL66A=
Date: Mon, 13 Oct 2025 02:50:07 +0000
Message-ID: <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
In-Reply-To: <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SN7PR11MB6827:EE_
x-ms-office365-filtering-correlation-id: ced97ab2-05ba-4c19-c05e-08de0a033836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z3RuVlE1NnJaT2VlaXRTeUdrY1U2bWQ5YmsrZWFLQjhIcVVseDFyalBqUm44?=
 =?utf-8?B?Wll1Q3Y1QjNUek0xRXl0RXFHVW5MSElMVlN4MXdkKzRUOHJraFJWOVY5Szc2?=
 =?utf-8?B?QU1UeGludGpVYkFlbVY1SFBUUXZ1Z0c3YWIrSGRBWkhSYVJseFdRcUo1VVVz?=
 =?utf-8?B?UzZFZUVodkkrK0dpYTVrQWEyYkZYa3pJQkVEd285TGVSbzdaTFprdkcyekZu?=
 =?utf-8?B?Y2FjUFl2aHFmVXo3YzVoL2Q1MEsrcGJrWE93SlVqaXRFbGxlV0k3b1oybk44?=
 =?utf-8?B?QjUzQmc4WGV0NUpmWFpZWnVoMFNOOEtpWXY2NWFNYktsMXFFa3RrTEtpYjhV?=
 =?utf-8?B?ckNsQit3RXpLUkRnQkN2TkQvZHM5eWNNU3NBZDdvYmI3SytpVFpqZGI5VUE0?=
 =?utf-8?B?QysyTUtqTjBKUEpPZkFvZlZsZHFvZVNCeE1ZYXJiKzJSK0cvaGJuVTh5NVQ2?=
 =?utf-8?B?ZzhIWVFNN2YwWENGU2xTbWoyS0NpVmdvOUxzblEzOEFaeFIyMUpUUllMempP?=
 =?utf-8?B?c2pjaWw0SDE2MzRFSW9NK25LODlSQURmMDJLZG5yS2hYZmt2NDJmUlJKcms1?=
 =?utf-8?B?VzZNai9LREVvdE01eUhSTHoreVRidXByYUwrbk9uTEVhTVJ5NGJtVEV0eHVI?=
 =?utf-8?B?bFVEOHRqYjVnbDhUaVVpZEEzY1R1VVl3bTRuMEdhTzhMSkZMOWhtM3NFNHV2?=
 =?utf-8?B?bWNIdWxmMThTb1Z4RUkvaGV2bVdMYXhGb2Q4RUgyZE1DMFVQUVdPT0hxeUE2?=
 =?utf-8?B?MW9PcXMveG05a2pjdUkvU29YcVJKWndkdjlaTVBmNno0OFVjanBiSXcvMGg1?=
 =?utf-8?B?QVd4YVdpcVlpdlRuU1cxdDMzaS93d2R0NDFhNER1WjlXeERBZ2dFWUZ1aDRs?=
 =?utf-8?B?bllMbUtHanpDVlBzbGFGdi9FUTN6L3V0cUtkVjhNaXp4VFVtRkdtRW5pZnQx?=
 =?utf-8?B?NTFmcGlpQ0FiVXY2LzQyQVFoZ1dHSy9kL2dPdzloZ0RWQjF0VWJZUzN0RUNS?=
 =?utf-8?B?QUtRTkxnajhJUVdXeDhCelNJNERYampMSkorcjNUZFltdVdGWFd4MVlEa1ZE?=
 =?utf-8?B?SEJpeUdmcVdRa1ZHRnAxV3NzNjNtb0lkZHJGOWlORWJDdUJ1b3Jzd2w4TW5s?=
 =?utf-8?B?eGZlRnhKcERiY2x0MDF6bSt3ZGRBYnUwY1NxL2JpUUlEdVZyM0QvQUdtS0Nm?=
 =?utf-8?B?NmRSOHZxbnVMeTV5LzZUTVg0UzNTMjl2MldnMnNkTGQvVWdmUkM1MzArcE0r?=
 =?utf-8?B?aXRERWFzd3Z0MmJiZ0tRMmdNSDVqaklMNzdObEtJaWhva2lMakpuamVvdjdj?=
 =?utf-8?B?Nnd2a3Z0aHRJRjU2Y0R1MUlCYmF1eTA1WStDVEh3YTRzZ2N0N25ROFFYc1Nx?=
 =?utf-8?B?TDVNczVnYmU5eFR1WEJySitOQ2tjWFU3R3hNZkoybHdJU2Z3Z0hXLzk4a2hi?=
 =?utf-8?B?YmFEaDhjalo5dDB5NTV1ZG11aG85OHEwRldwRXVCSG5zc1FBOVhlTlFPbTZy?=
 =?utf-8?B?WWw4QnhNdU9Vb1ErSXUrVStNN2RTSC93b1JVMEw0djNUUjhKMDkzOVJ2SGg5?=
 =?utf-8?B?OTEwTmRrZ0VSZmZ4cDg5UHlHQ0VwOURqcVpTVi9RRVY2Y250VTRlZnpaMWNH?=
 =?utf-8?B?ZDlsekZzbkRMNmhPZlNDNDVLb2ltNzVocVhNZXhwTzZsblo4c3I4dkNKYWNv?=
 =?utf-8?B?NWlPYnAvVEVQNVRNZTVNWStkdFY5aHFTWVprZ045dlUrMEJsZUZCZVoySEtx?=
 =?utf-8?B?Qnc3cnNOTFF5MkVLaGplNWtBOG5KUGpMK0VodEdLQytGdHk5eWtOaWkrdVhj?=
 =?utf-8?B?aGZMcE83K29nSUZ5eGgrVnh5Mmpsb3pPcUU5WFEzeGJFbUFXYUFXRXhmbmFl?=
 =?utf-8?B?ZHlVWldkZXJydjNha2RvRUdLdlFRLzhqUnhUUEJwWjV6citvSUNGc0RrZlpY?=
 =?utf-8?B?eVRnamRHRGRjUVpIZ0Mwd2Q5QTVxbGF6Q1N1eHFnV2kwaVNvcUJaS2R5emk0?=
 =?utf-8?B?OFRnNk1RSEdzczBlYzJaZHNPK2xwaGI4YkxhRlErUHhYSVhsNU1nd1lLYlJF?=
 =?utf-8?Q?0dPs55?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk5UaDVpWW9BK0ZzdmQwVHlZbUYyQjRzaVFHS2NjcUdlaWlVdWo4RzhJQWY4?=
 =?utf-8?B?a1FKQ1pnaHJQeGZva0hOSWRHZTFSbFlNMlM5TzMxaTJ2cHdrZDc3eHVDczNB?=
 =?utf-8?B?WkxBOFBDZ3lYL0Q5K2NiTTBodHhsVE9hN1dCY3Q0TTJZdFcrRmh5ZmRiNlZD?=
 =?utf-8?B?Qndxd0NOZ211UE5NeXpVWUJoWU1FaERIOHkrM2dVM1BzSFlzQWlJd1VqS0Vu?=
 =?utf-8?B?S3RpZmpBcTVjaGVYbDA3bXNmYkhNWHJ3QWZERzZjNUZ2ZUVjTzg1d0wrQ2Ja?=
 =?utf-8?B?YXVJdmRNM0p1RWJYM3ltK0lXT0dYejBieExqNUhkQkZwQUZRNXBQeUEySi9y?=
 =?utf-8?B?UUxhOGZyU1R6L25ZSVQwTy9ESnN4SDhmL08yTUxFLzRFYVV5dEZhUk1JZkto?=
 =?utf-8?B?K1N3R2R3bnFYbm1IQ3o2SFRoOExyR0E2cXhETi9VSHJhS0I1MEo4VGEzbGRk?=
 =?utf-8?B?R3A1THpicmQ4Q3BDNld2ME1JQU92bHBablBGRlgyaHVFSFFBakRURml3bk1w?=
 =?utf-8?B?bUt2cGhPdzFLenFiK29MRVVGaVRTbkZSR0VVOWRRZ2JLWi94NHhkeWpKRHFi?=
 =?utf-8?B?WVl3WTB0cWNJNlMyNmdlUVdtdWpaOUJPbFhLR1pabnVMTy83UVNKaHYzWDNk?=
 =?utf-8?B?K1I3MDVrYXpCQ2srcmJscENxY2laZWlJeE9QdlBLMG1vUlVDTVk5RzBvSWRJ?=
 =?utf-8?B?ZHVkR05pVE5ycHVteURCRndTdEs1SUNUZlB4bnBMak9MTUJDd2xPdGZDbjlr?=
 =?utf-8?B?K0xDZGV2ckFTMjJaSnFLU0lPSWxqb0R3SWthNG5nVHJUZVVoOURMVksrTE9O?=
 =?utf-8?B?N3pKeUdqa1U2ZCt5a3BLaUhsbnd5dFpMeXYrd1djMGw2SnZpOFRiRVk5T1lN?=
 =?utf-8?B?Mmkwc1FDdWFkNW5uVXErZ0Z3Z3Y2a0dIWXN3Wks3Qms4ZHUwVnkwcERpeStw?=
 =?utf-8?B?a1doaDN5TUJoU1FzVERWZlloOVhyTHVESGI0TmExalhSditTOHVGaTFVREZl?=
 =?utf-8?B?VFdnR3g2TnNoYVRQQkFkQlJ6enRrRTNralFvMzg2WmI4aWQzSldEZGl6ZmlM?=
 =?utf-8?B?cG5Na0E0U0FXUEg4anFiMGQyWEx1c1VKb1ZyMC93ajFCcHlpcGhaT25VMmpU?=
 =?utf-8?B?UkFJclJjRkNzZHQ4T05JTXR1MlUxOTFnQ3d6Skx6SHN1eEFKeG1UZTVQbzJ2?=
 =?utf-8?B?OUwwZmZlTXEwbU1taGJ1aGVsOEZkbVp4cjRsWG5TS3NOaUNTOUxDVlRxUXRy?=
 =?utf-8?B?QndRRHlicVZ0dTRaQXkySUh2NGFYSUVZVlZjb3gvVi9wVS9GZjNaMlBaSXF1?=
 =?utf-8?B?SEIwNTN3SVlNMHFpZlYxckdqVXpqbTlJVEVUUUMyaEp6amVpL1ovaVJXYjFB?=
 =?utf-8?B?bllaUXFPcnZSUFdpaHNPSlY2c1c0c3B6TkVFTk5UczE0ZzRPcjlXSEhlanF2?=
 =?utf-8?B?R24yaHRHMEdFcmI5V2VtbUFVS3Y1dCsydGZqN29wUU0wVWFiS211R0t1Qkxk?=
 =?utf-8?B?R2ZZMnBhc0lnK2JhR3EyODFvaUdvbFBLSXJ2UTZIMFYxM3dFTW1RZG5DbjI4?=
 =?utf-8?B?UWswOTJLLy9vaXY4NUsxVEc0TmZ0N2JYNStCVzgyQUpjbDkreDBSeHpORUNq?=
 =?utf-8?B?U09sbENlRWxKVlV4d01DTis2L1VvR1Y5SUJOTzY2ME5QM2lLdXkvOFdMSllW?=
 =?utf-8?B?cFp2WFRJNCtqSTB6alQvZXd3ekhqWWpEVHhEYXlCKzg3N29DTmx0QXBFeVlC?=
 =?utf-8?B?VUxBbjNLZEF0a05GT1lyMU90ZTkwQTFPaVY5NmhrTjZLZm5QemdyNGZzRzZU?=
 =?utf-8?B?WS83dE90OUIvRDVFSmk4RzVPVGhhckt0TXkrOHBUOFlLZllYMGxZNEpiRVdP?=
 =?utf-8?B?Q1o2UFFBNWNFZVczNy9jbHV0cDlEN21iSzhtZHpuUmZlS3RBVzQ0VnROMEdW?=
 =?utf-8?B?KzlLbjY2ejFISUErZ29qQ2s4M3BXeFV1WnpRWlgvYkV3MGhDd0tIM2xzSE11?=
 =?utf-8?B?Tkh0YWpLNjUyWHRNbU0zUEN3elJBL2N4Mkc2cXhrV01XYXRPaGZoYlpacnFq?=
 =?utf-8?B?c2FjNHJ4UEhJeVN5bmNtcE8xbVU2alp5aFZyNENiK0hFeHZxUzJpMmRrUDla?=
 =?utf-8?Q?Drt4z8FltUumSonzEM7UkvyhQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced97ab2-05ba-4c19-c05e-08de0a033836
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 02:50:07.7386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2R5TMG3oFlXqV2Td60DvADf99cB1Pjb/Tdc1iT1AI7byPehTi82ef4uz6012MJnh+lxsZS41uCfxYMNqXFTcnHyDwKpXfea2gXz/hd8/7zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6827
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBpbnRlbF9pb21tdTogT3B0
aW1pemUgdW5tYXBfYml0bWFwIGR1cmluZw0KPm1pZ3JhdGlvbg0KPg0KPk9uIDIwMjUvOS8xMCAx
MDozNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJZiBhIFZGSU8gZGV2aWNlIGluIGd1ZXN0
IHN3aXRjaGVzIGZyb20gSU9NTVUgZG9tYWluIHRvIGJsb2NrIGRvbWFpbiwNCj4+IHZ0ZF9hZGRy
ZXNzX3NwYWNlX3VubWFwKCkgaXMgY2FsbGVkIHRvIHVubWFwIHdob2xlIGFkZHJlc3Mgc3BhY2Uu
DQo+Pg0KPj4gSWYgdGhhdCBoYXBwZW5zIGR1cmluZyBtaWdyYXRpb24sIG1pZ3JhdGlvbiBmYWls
cyB3aXRoIGxlZ2FjeSBWRklPDQo+PiBiYWNrZW5kIGFzIGJlbG93Og0KPj4NCj4+IFN0YXR1czog
ZmFpbGVkICh2ZmlvX2NvbnRhaW5lcl9kbWFfdW5tYXAoMHg1NjFiYmJkOTJkOTAsDQo+MHgxMDAw
MDAwMDAwMDAsIDB4MTAwMDAwMDAwMDAwKSA9IC03IChBcmd1bWVudCBsaXN0IHRvbyBsb25nKSkN
Cj4NCj50aGlzIHNob3VsZCBiZSBhIGdpYW50IGFuZCBidXN5IFZNLiByaWdodD8gSXMgYSBmaXgg
dGFnIG5lZWRlZCBieSB0aGUgd2F5Pw0KDQpWTSBzaXplIGlzIHVucmVsYXRlZCwgaXQncyBub3Qg
YSBidWcsIGp1c3QgY3VycmVudCBjb2RlIGRvZXNuJ3Qgd29yayB3ZWxsIHdpdGggbWlncmF0aW9u
Lg0KDQpXaGVuIGRldmljZSBzd2l0Y2hlcyBmcm9tIElPTU1VIGRvbWFpbiB0byBibG9jayBkb21h
aW4sIHRoZSB3aG9sZSBpb21tdQ0KbWVtb3J5IHJlZ2lvbiBpcyBkaXNhYmxlZCwgdGhpcyB0cmln
Z2VyIHRoZSB1bm1hcCBvbiB0aGUgd2hvbGUgaW9tbXUgbWVtb3J5DQpyZWdpb24sIG5vIG1hdHRl
ciBob3cgbWFueSBvciBob3cgbGFyZ2UgdGhlIG1hcHBpbmdzIGFyZSBpbiB0aGUgaW9tbXUgTVIu
DQoNCj4NCj4+DQo+PiBCZWNhdXNlIGxlZ2FjeSBWRklPIGxpbWl0cyBtYXhpbXVtIGJpdG1hcCBz
aXplIHRvIDI1Nk1CIHdoaWNoIG1hcHMgdG8NCj44VEIgb24NCj4+IDRLIHBhZ2Ugc3lzdGVtLCB3
aGVuIDE2VEIgc2l6ZWQgVU5NQVAgbm90aWZpY2F0aW9uIGlzIHNlbnQsDQo+dW5tYXBfYml0bWFw
DQo+PiBpb2N0bCBmYWlscy4NCj4+DQo+PiBUaGVyZSBpcyBubyBzdWNoIGxpbWl0YXRpb24gd2l0
aCBpb21tdWZkIGJhY2tlbmQsIGJ1dCBpdCdzIHN0aWxsIG5vdCBvcHRpbWFsDQo+PiB0byBhbGxv
Y2F0ZSBsYXJnZSBiaXRtYXAuDQo+Pg0KPj4gT3B0aW1pemUgaXQgYnkgaXRlcmF0aW5nIG92ZXIg
RE1BTWFwIGxpc3QgdG8gdW5tYXAgZWFjaCByYW5nZSB3aXRoIGFjdGl2ZQ0KPj4gbWFwcGluZyB3
aGVuIG1pZ3JhdGlvbiBpcyBhY3RpdmUuIElmIG1pZ3JhdGlvbiBpcyBub3QgYWN0aXZlLCB1bm1h
cHBpbmcgdGhlDQo+PiB3aG9sZSBhZGRyZXNzIHNwYWNlIGluIG9uZSBnbyBpcyBvcHRpbWFsLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+PiBUZXN0ZWQtYnk6IEdpb3Zhbm5pbyBDYWJpZGR1IDxnaW92YW5uaS5jYWJpZGR1
QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgfCA0Mg0KPisr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDgzYzVlNDQ0MTMuLjY4
NzZkYWU3MjcgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM3LDYgKzM3LDcgQEANCj4+ICAgI2luY2x1
ZGUgInN5c3RlbS9zeXN0ZW0uaCINCj4+ICAgI2luY2x1ZGUgImh3L2kzODYvYXBpY19pbnRlcm5h
bC5oIg0KPj4gICAjaW5jbHVkZSAia3ZtL2t2bV9pMzg2LmgiDQo+PiArI2luY2x1ZGUgIm1pZ3Jh
dGlvbi9taXNjLmgiDQo+PiAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4gICAj
aW5jbHVkZSAidHJhY2UuaCINCj4+DQo+PiBAQCAtNDQyMyw2ICs0NDI0LDQyIEBAIHN0YXRpYyB2
b2lkDQo+dnRkX2Rldl91bnNldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1
ZSwgaW50IGRldmZuKQ0KPj4gICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICAgfQ0KPj4N
Cj4+ICsvKg0KPj4gKyAqIFVubWFwcGluZyBhIGxhcmdlIHJhbmdlIGluIG9uZSBnbyBpcyBub3Qg
b3B0aW1hbCBkdXJpbmcgbWlncmF0aW9uDQo+YmVjYXVzZQ0KPj4gKyAqIGEgbGFyZ2UgZGlydHkg
Yml0bWFwIG5lZWRzIHRvIGJlIGFsbG9jYXRlZCB3aGlsZSB0aGVyZSBtYXkgYmUgb25seSBzbWFs
bA0KPj4gKyAqIG1hcHBpbmdzLCBpdGVyYXRlIG92ZXIgRE1BTWFwIGxpc3QgdG8gdW5tYXAgZWFj
aCByYW5nZSB3aXRoIGFjdGl2ZQ0KPm1hcHBpbmcuDQo+PiArICovDQo+PiArc3RhdGljIHZvaWQg
dnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXBfaW5fbWlncmF0aW9uKFZUREFkZHJlc3NTcGFjZQ0KPiph
cywNCj4+ICsNCj5JT01NVU5vdGlmaWVyICpuKQ0KPj4gK3sNCj4+ICsgICAgY29uc3QgRE1BTWFw
ICptYXA7DQo+PiArICAgIGNvbnN0IERNQU1hcCB0YXJnZXQgPSB7DQo+PiArICAgICAgICAuaW92
YSA9IG4tPnN0YXJ0LA0KPj4gKyAgICAgICAgLnNpemUgPSBuLT5lbmQsDQo+PiArICAgIH07DQo+
PiArICAgIElPVkFUcmVlICp0cmVlID0gYXMtPmlvdmFfdHJlZTsNCj4+ICsNCj4+ICsgICAgLyoN
Cj4+ICsgICAgICogRE1BTWFwIGlzIGNyZWF0ZWQgZHVyaW5nIElPTU1VIHBhZ2UgdGFibGUgc3lu
YywgaXQncyBlaXRoZXIgNEtCDQo+b3IgaHVnZQ0KPj4gKyAgICAgKiBwYWdlIHNpemUgYW5kIGFs
d2F5cyBhIHBvd2VyIG9mIDIgaW4gc2l6ZS4gU28gdGhlIHJhbmdlIG9mDQo+RE1BTWFwIGNvdWxk
DQo+PiArICAgICAqIGJlIHVzZWQgZm9yIFVOTUFQIG5vdGlmaWNhdGlvbiBkaXJlY3RseS4NCj4+
ICsgICAgICovDQo+PiArICAgIHdoaWxlICgobWFwID0gaW92YV90cmVlX2ZpbmQodHJlZSwgJnRh
cmdldCkpKSB7DQo+DQo+aG93IGFib3V0IGFuIGVtcHR5IGlvdmFfdHJlZT8gSWYgZ3Vlc3QgaGFz
IG5vdCBtYXBwZWQgYW55dGhpbmcgZm9yIHRoZQ0KPmRldmljZSwgdGhlIHRyZWUgaXMgZW1wdHku
IEFuZCBpdCBpcyBmaW5lIHRvIG5vdCB1bm1hcCBhbnl0aW5nLiBXaGlsZSwNCj5pZiB0aGUgZGV2
aWNlIGlzIGF0dGFjaGVkIHRvIGFuIGlkZW50aWZ5IGRvbWFpbiwgdGhlIGlvdmFfdHJlZSBpcyBl
bXB0eQ0KPmFzIHdlbGwuIEFyZSB3ZSBzdXJlIHRoYXQgd2UgbmVlZCBub3QgdG8gdW5tYXAgYW55
dGhpbmcgaGVyZT8gSXQgbG9va3MNCj50aGUgYW5zd2VyIGlzIHllcy4gQnV0IEknbSBzdXNwZWN0
aW5nIHRoZSB1bm1hcCBmYWlsdXJlIHdpbGwgaGFwcGVuIGluDQo+dGhlIHZmaW8gc2lkZT8gSWYg
eWVzLCBuZWVkIHRvIGNvbnNpZGVyIGEgY29tcGxldGUgZml4LiA6KQ0KDQpOb3QgZ2V0IHdoYXQg
ZmFpbHVyZSB3aWxsIGhhcHBlbiwgY291bGQgeW91IGVsYWJvcmF0ZT8NCkluIGNhc2Ugb2YgaWRl
bnRpdHkgZG9tYWluLCBJT01NVSBtZW1vcnkgcmVnaW9uIGlzIGRpc2FibGVkLCBubyBpb21tdQ0K
bm90aWZpZXIgd2lsbCBldmVyIGJlIHRyaWdnZXJlZC4gdmZpb19saXN0ZW5lciBtb25pdG9ycyBt
ZW1vcnkgYWRkcmVzcyBzcGFjZSwNCmlmIGFueSBtZW1vcnkgcmVnaW9uIGlzIGRpc2FibGVkLCB2
ZmlvX2xpc3RlbmVyIHdpbGwgY2F0Y2ggaXQgYW5kIGRvIGRpcnR5IHRyYWNraW5nLg0KDQoNCj4N
Cj4+ICsgICAgICAgIElPTU1VVExCRXZlbnQgZXZlbnQ7DQo+PiArDQo+PiArICAgICAgICBldmVu
dC50eXBlID0gSU9NTVVfTk9USUZJRVJfVU5NQVA7DQo+PiArICAgICAgICBldmVudC5lbnRyeS5p
b3ZhID0gbWFwLT5pb3ZhOw0KPj4gKyAgICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gbWFw
LT5zaXplOw0KPj4gKyAgICAgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3Bh
Y2VfbWVtb3J5Ow0KPj4gKyAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+
PiArICAgICAgICAvKiBUaGlzIGZpZWxkIGlzIG1lYW5pbmdsZXNzIGZvciB1bm1hcCAqLw0KPj4g
KyAgICAgICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCj4+ICsgICAgICAgIG1l
bW9yeV9yZWdpb25fbm90aWZ5X2lvbW11X29uZShuLCAmZXZlbnQpOw0KPj4gKw0KPj4gKyAgICAg
ICAgaW92YV90cmVlX3JlbW92ZSh0cmVlLCAqbWFwKTsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsN
Cj4+ICAgLyogVW5tYXAgdGhlIHdob2xlIHJhbmdlIGluIHRoZSBub3RpZmllcidzIHNjb3BlLiAq
Lw0KPj4gICBzdGF0aWMgdm9pZCB2dGRfYWRkcmVzc19zcGFjZV91bm1hcChWVERBZGRyZXNzU3Bh
Y2UgKmFzLA0KPklPTU1VTm90aWZpZXIgKm4pDQo+PiAgIHsNCj4+IEBAIC00NDMyLDYgKzQ0Njks
MTEgQEAgc3RhdGljIHZvaWQNCj52dGRfYWRkcmVzc19zcGFjZV91bm1hcChWVERBZGRyZXNzU3Bh
Y2UgKmFzLCBJT01NVU5vdGlmaWVyICpuKQ0KPj4gICAgICAgSW50ZWxJT01NVVN0YXRlICpzID0g
YXMtPmlvbW11X3N0YXRlOw0KPj4gICAgICAgRE1BTWFwIG1hcDsNCj4+DQo+PiArICAgIGlmICht
aWdyYXRpb25faXNfcnVubmluZygpKSB7DQo+DQo+SWYgdGhlIHJhbmdlIGlzIG5vdCBiaWcgZW5v
dWdoLCBpdCBpcyBzdGlsbCBiZXR0ZXIgdG8gdW5tYXAgaW4gb25lLWdvLg0KPnJpZ2h0PyBJZiBz
bywgbWlnaHQgYWRkIGEgY2hlY2sgb24gdGhlIHJhbmdlIGhlcmUgdG8gZ28gdG8gdGhlIGlvdmFf
dGVlDQo+aXRlcmF0aW9uIGNvbmRpdGlvbmFsbHkuDQoNCldlIGRvbid0IHdhbnQgdG8gZGl0cnkg
dHJhY2sgSU9WQSBob2xlcyBiZXR3ZWVuIElPVkEgcmFuZ2VzIGJlY2F1c2UgaXQncyB0aW1lIGNv
bnN1bWluZyBhbmQgdXNlbGVzcyB3b3JrLiBUaGUgaG9sZSBtYXkgYmUgbGFyZ2UgZGVwZW5kaW5n
IG9uIGd1ZXN0IGJlaGF2aW9yLg0KTWVhbndoaWxlIHRoZSB0aW1lIGl0ZXJhdGluZyBvbiBpb3Zh
X3RyZWUgaXMgdHJpdmlhbC4gU28gd2UgcHJlZmVyIHRyYWNraW5nIHRoZSBleGFjdCBpb3ZhIHJh
bmdlcyB0aGF0IG1heSBiZSBkaXJ0eSBhY3R1YWxseS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

