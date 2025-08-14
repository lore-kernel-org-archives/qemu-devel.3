Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FE0CA0EE0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 03:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umOXK-0004QB-Fe; Wed, 13 Aug 2025 23:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1umOXI-0004PT-0h
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 23:21:52 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1umOXB-0001jm-Rk
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 23:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755141706; x=1786677706;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CusFHQbBIMGROIub/tL2TYYhZODMFBydUpzG86uiS2g=;
 b=VonNAGiBD+bS2s1tO4hHNp+JkAzbQjeeemTt8mjHUMOyAGbj49sOk/a1
 xVRfhql2TIxFCGctir/JCuNr24f7btW9fwUCpc/CzTRge8+gniuh4kvjY
 AkdZ1Xj9P5bAQOAVFHxS6n6zyHOIFpGI3AE+CbXPaDbQ4abIVS8nx8G6c
 VlPvn6p6Q/Pd8V+6QlB2nYrUKmGqfoBzT09HjW2xuGa+hyChq43S50QQl
 sY6decO5Gk5/IfiExBacNeh+gV+diUbrk1bQWRrVSe2Fj2sFV+zTF1nkA
 ptXzbUQYQMHCutaNT6gjCzOM1QWyddwg9h450N2V6tLKZ4VCRtPbn1Cfh A==;
X-CSE-ConnectionGUID: fnPgIS5mROWLFTelJU9Zng==
X-CSE-MsgGUID: 460TYaMMS56bH0LhWBYI6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57353906"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="57353906"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 20:21:41 -0700
X-CSE-ConnectionGUID: sebhR423QIab4B2uWolI6w==
X-CSE-MsgGUID: cY/EFK0LT5+UsfwPT/9Mpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="166290260"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 20:21:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 20:21:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 20:21:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.42)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 20:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1x4mNlshA2efCVqEFTuR0JdfctRPpc2MhPNiCxvE8t5E+Jk7sjWxErpqBtzB2YukF+k+NixxnqPyXnkyX2Od5Sku52ttNRr4pZVtJ45p5OTiH3c6jMZRAKiacBZxs7I+dXT1/CZMlUWRHdbd4cKaRqdlq3dmyYL81RdzHtzJ/UAFAsDF+MOmUVdbOgRgRs2AzHGgFwiY4ixVdQuGcXstBVCwq1u+udSBrUINdBpaCePckVBN25DBYZDgGszs51F5Vn7QjVImNGWTdcJyCJ2nMkTxXl7gBw6ezF6zShPDBBQt/cY+BrmiIbVAG9fcrpczo5BgvAWg57FkybfwVQLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CusFHQbBIMGROIub/tL2TYYhZODMFBydUpzG86uiS2g=;
 b=Wzcts96VIxU0jzJjBTwU3tve9GQHZOFFzPAVPgOLWyVtalUAUrWFa+yiVgUd0jiddDdY84t+wGUW37aV6gqVv3BW48ciG5qbxy3QFK6oKbeybK2EsfrvhhB7B+KptbNr/lsivfho7dMdN6GA327gIYFel6JaHoc8vS9BQB8rkH8NrfKAeGJhaUdD5inJq+8qBVDI/ITlVreKAvyIZ3EVLJOwP5S4bqZAqvGDwMemJIaM105Z3/3CXZkqKDu9Owwg66t2zUxc88+DMNLiXrFx/qUUF6itC9dP9Gas+NbnbQ9fvqBJgU6crDP/WJs0OxmYv4MP1y8kJrmni3as1RUIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 03:21:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 03:21:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>
Subject: RE: [PATCH] vfio/container: set error on cpr failure
Thread-Topic: [PATCH] vfio/container: set error on cpr failure
Thread-Index: AQHcDF0W9enB1tRq0UmsOUQOKROViLRhfB2g
Date: Thu, 14 Aug 2025 03:21:32 +0000
Message-ID: <IA3PR11MB913617C54F85022EC60635E99235A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1755094667-281419-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1755094667-281419-1-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7766:EE_
x-ms-office365-filtering-correlation-id: 91a50904-8ffc-4ac1-5dd1-08dddae1ab21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q1lsL2VSWnZNa1BGK2hRTDc0L29mNVBVY25QZzdzcEhveWwxZ2ZRa054ZENF?=
 =?utf-8?B?MlhXdlNsMlNiK3E2cmZtTFQ5cElpZ3plREFoMENTcDRwME0rUlBtbzJIT2lZ?=
 =?utf-8?B?cEtEeUhZQVcwK2pvZVkzcklPN3pmZ3diR2FnL2NrVnZXOTZTUkgyWWNiL3Zn?=
 =?utf-8?B?T2VPRG1RZjRVbzcyYTFJNk0zdlBpQWt5dE53cEZHcnh1czN2S3NUNFJMdXU2?=
 =?utf-8?B?UzVnWEZZVzdsVGpRMFFjVTFiSHppUVpxTXNSMG9JeE84b0FZdU93UDZMVGxI?=
 =?utf-8?B?QmQzc3lDeXExMW9RMGZSalkyZ09PMjZFTFFtakJ5Q09JOFpLOVBQTVh4UEFr?=
 =?utf-8?B?b3cxb1ppTGNBaUt5bXhYNHN4ckhITmU4VnZwdTY3ZWJISENWeFJQRjE1b1lq?=
 =?utf-8?B?UFQvbVVGaU5UR252MjJtYmFhN1FjZ2YwMVBqN0xSRHJ3QjBlNWoyRFZ3WGtK?=
 =?utf-8?B?cmpsSzJaK1RUc2Y5SnMySCsyVlIwR0J4MDNTa0tteGtwT01DZHBidUhoZTRx?=
 =?utf-8?B?cnJqVHBPcVovYm85V1VIU29IMmdjSDA1a0V0dE0yMzlNR212Z3FxTUJqcUVM?=
 =?utf-8?B?N0ZLTjBGNHlaNXhPcVpWSDZkay91WG9EakhzSnBmWkNFSVlEMS8rMzZFaXF3?=
 =?utf-8?B?c042cnRKaEY2TWFkR2pWYnRBWVVvU052TUR5Y3lWU2hNcWVHZDRNSm4xRGpi?=
 =?utf-8?B?UE1Zc240WWIxS0ZvcE4reWsrbjBvKzhHeEpPYmZtbytrKzdUU1M2ZTFrVU5z?=
 =?utf-8?B?bzNVdnJuZnRWOHdmRG9kcHhqaEYzTFYwM3ZIUXd5anplWjR1YmJVMHBCOFEr?=
 =?utf-8?B?NHdsdHc3ajZmSFd6Qis4RXZPbnJXOFBzTUpFZ1pRaWRPVFNLOHI2enJRM25S?=
 =?utf-8?B?N1dTT2FvTkg0bEJLRUNFTTR3OEd6VTZQSmM1d21VL0JSd0MycHdQNHlPT0Zz?=
 =?utf-8?B?cjYrNDVKOWZsUE1jMEFwM2F1eDEvYVBSVXZnemZGQ0J1ZURXYXhuR0RTaity?=
 =?utf-8?B?SkpQblE0dDBkT2E2clJOc2hLUnI2T2psZ0xjUVJVbGlnQmZpZ0FzNWpOdlVH?=
 =?utf-8?B?dDBqYVROd2Znd1QxWGdFYzNKYmU5cENrVHVkaEo2WlhDVGd1MGkvRHE2aXFr?=
 =?utf-8?B?bXhjUEVlNWljZDN2aDkwRkdCb1lrdm8yOU4zL0p6VkZ5T0x4R25DMXR6eEhp?=
 =?utf-8?B?MWxuT01EbXZWZ3g0WnV4MGtPOW5GWjFWdDdOOElyMmtnd2FTR2lEeldrZXpR?=
 =?utf-8?B?WTNDbkF3NWdDMnhwWXNwQWttL2l0cWdROWRiSklUc2V5RFlnUjdYN2E2ZURu?=
 =?utf-8?B?TXBiSUpPMkNXVGhBWDBlcTFxNk5Pcy9hSWcrOGN6dUI3NHgrZThpTHNOQmpD?=
 =?utf-8?B?MTZzL09DSUVuVUI0Q3NVdCtrbmloSVpiZTBSUWZNMjNrVEl3L09MeHM3TkNU?=
 =?utf-8?B?YjNmTlNuVXByREw3eHZxSStMVXppSGlwYnllRGhwOVlET3dnTlN3S1FHRWVl?=
 =?utf-8?B?VjhFTGo1SmRSdjNiWDFTblNuaUFVQ0cyRDhyZUZGSyswcktIZUd6OGE0VTZP?=
 =?utf-8?B?QWlyYTdaa29mbnJrMmFQc1BsZUdzMVZaOVNqQ0JEeitMMFUrT2NUMjh6KzE0?=
 =?utf-8?B?UEhiWnBadU5sTm0welFBeXNkUmkydDdaRzFlV25ieVdhMmJKdkE4WVI0dEdz?=
 =?utf-8?B?dWt6L0J6T1I5V1AzRGZGTzR2YkVYdDBhK2NKVHNvR3hId3MzSUpyRG42cjFH?=
 =?utf-8?B?bGdkNW1KT044L2JUbjQzZnZXRjNjd1NMUU9YZkJJUGlhNDNncXRIb2JXVXdD?=
 =?utf-8?B?VlVJcXVDR1NYd2NpUHVwbU1ZNXozNjlIYjFVbVg3b1J2VXhmc0JOQzExbjl4?=
 =?utf-8?B?SS9nOFl6VXJTUGw2YUZhOUtwbGltbnljaFVZdTJDOG5WaHVyb1Y5Q1JqN1dG?=
 =?utf-8?B?eW1FZm0wRVordHRWTDVsZldrMW9jcVlZMTdPekJ3UXFIN2dyY0dnc3dkdnJr?=
 =?utf-8?Q?EIko+Q/G6cnfmqxaFYJyxgVaKlDWG0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmNHdnY2K01QWFEzZGU3d1Q2TkF4WFhYU2Y1MUF4YTluSXJDTy84OGlRN3J1?=
 =?utf-8?B?dVlSUFdsVHVJdEN0aW5LeTUxUVFxdXg0TW1MamJ1TE5VM3ZDVDloQnkxTHho?=
 =?utf-8?B?N212Ky9zdVIvY0I0dGE1UG9UV25ydjhKUWIrQ3pod1gvdURiREl1aWZYbXM2?=
 =?utf-8?B?SXhtbDdFWVBGTEJ0NjhUSGt2eXZ0TW9OUGJkMy9VUjVxSWg0dk85WEw5bGM0?=
 =?utf-8?B?bmhscFhWYjE0WjI1NW55R3VBeXdrWGdMRkY5WGhSdjJRU2dQdDUycG50WGla?=
 =?utf-8?B?U2tTVFR5WEN6UFhjZFBhbWpVallaYTFKNGJJTm1sT2krV0FubDFqQ0x0RE12?=
 =?utf-8?B?RTRnQ0ErOXJyZko2QVNnQjJqalUwdklWM3JLdE5KMitJWll4NTNWa2JRbk83?=
 =?utf-8?B?cjYrL3p4OUNlNkdXNzdrMWJaVnNMT1dJM2ZjdnpmR1BiWkROM2VtTnJtUzdj?=
 =?utf-8?B?SU5uNUl0UWFRaHVyem5xUzJBVzQ5R3R0V2hGdnpMT3JOS3Awdy94NFhleGFx?=
 =?utf-8?B?Wk9jaWIvU0gyQmlQU3lFS0IrSUJFRDdLNEdQaGcreEQzdVpLRy9aVlBwa2ov?=
 =?utf-8?B?YjZGeFRJUTVIT0dTYWJ2dGwzSzFvbk1iNXNuY2VtaEQxZnl5QlFuTDRUZHlL?=
 =?utf-8?B?U3FLOWhkSlM3ZjJzQlhhMU90V1Z1U2ptUnZFMWc5b3JsaUVVSW1qK2V2aVQ1?=
 =?utf-8?B?d2dPb3VzTlI3OEdYU1V2bDVkMGZFUU5WdDgvNmh6cm10NnBvVGYwRW5pNEpj?=
 =?utf-8?B?emdoVUp3Sng4TjVwU2ZDcUdtVmdaSGsvWlNLNEFEQ0VaZFhqVjVlUGdUdkpM?=
 =?utf-8?B?aVRpcUhnZkRrYVJuQ0lILzAxaXRSZko1bmZMaHIxZWF3aXgrSUR3Mk5wUzhP?=
 =?utf-8?B?TnRtYWxxMCtpZy8yRmlqWUxmYytKankwZjN0ZXNTdDRDcG9KL2VMcXFuTmR6?=
 =?utf-8?B?Y3JNMFhHYXZxeTFsRFFoQWdJNU1KUE80M0x6WTIyMXh4MzQ4LzFNbm9BQkNo?=
 =?utf-8?B?SmJmWXBJQS9MMkw5VVhPWi9aT0VmOGh4REpHZ0x6bWFlTUxTQjJGUFRsUG9M?=
 =?utf-8?B?Y1QwR3M0M0xSY1FXSUZpZWZYWUg5dVlGS2RYclpRZHZtRWVCVWhOL05VbjJR?=
 =?utf-8?B?RU5kR2s4OU9UNWt6bmVKd2JtSGRJMFdHYktOUWVQYVBlUU5PZnJVN08wdDg0?=
 =?utf-8?B?VGpDQ2FQRWMraHZaOXVWMHpYeTNMK2gwS0srM01SWXNzc3Z0ZklCbGQ3S1h6?=
 =?utf-8?B?L3B1OFZ6eDA4KzEyUFFCYUl0LytkSHVnK0tJdFNLeXdvL1JoSFdxWjMxUGhI?=
 =?utf-8?B?TXZibisreUZaWng3cmdtVk5IZW1lV0N6aHE0UHdLVDJoV1B0aWk3Mks5WmU5?=
 =?utf-8?B?UGo2ZDl5N1RpNkI1OGozV0o2ZVI1V1FuVnNLWXZRekZTcXFMb0RZTjZKRXJY?=
 =?utf-8?B?K3NlUFdrRFBMMFBLQkpNNUNJaFkxUTNBUjdxY2lRQTV6NDJFcWZtbVI5WGFC?=
 =?utf-8?B?R3ltamtJQlA3Vnd0ZHZndzVER25zUjRmK256WHQzbkZEQnhLU2haV3lsQkVX?=
 =?utf-8?B?enVQVGU0VXZDSFFkOHVLN3JUR3JPdjNBaXg1L25UallxSVlUbHRnUkdLdSt3?=
 =?utf-8?B?RmJ1SDZPTHplYVd1ZFNIUUlxSUNmTXFkQ1ZZSnVOYzBTdDQ1WExEWm93dlJI?=
 =?utf-8?B?VkkrYUpwNkZmT01TVXFPSUIzTXdpR3htMDlkZG95VzlSM0tQbU9BbWNnMFNL?=
 =?utf-8?B?b2pWMmRWYmpSdVVrUXZObTBhQ2tOSmtXNE92cmg0ZGZqUVhDRm4rNk1sUS9v?=
 =?utf-8?B?c0pYeVNmZ1R6Y3QxRW1tdlp1cnFOMDZHRWhKUmhJU0NmUld6eTc2TGt6OFFC?=
 =?utf-8?B?djhHMGR5eUU4bXBEV2wzZHpQdTBLQUhuOGwzSU1UN0JVaXAzYUtibTBMR1Nq?=
 =?utf-8?B?REpaeG03YXRqMFQyYTRBZTd5RlNkak16cC9nK1FBUjhpSEZ5bHlSQnhrVlpH?=
 =?utf-8?B?cFRPUml5Lzl4QUdnMVN3c0s4Z1FZWTRzODk1cjVCZjFKZE9XOTFoYXJHUkgz?=
 =?utf-8?B?NjNBb2U1WlFETG04TGNyblFiUUNia2c4STZYZXpDR3huTlVGMWF2cDBydU9G?=
 =?utf-8?Q?W5jjHCMb2qupcwBzLJ2IvLw/l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a50904-8ffc-4ac1-5dd1-08dddae1ab21
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 03:21:32.9979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxTa/UUwmY595c6cBp6dicpzU6+zgWA27tD+S6V5zvl2UjA/M0qTKwk/uoRo67kov46IPrpD4n+CbvK2p6PQStrYrOMQshHD9sGcFdZ6SIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+U3ViamVjdDogW1BBVENIXSB2ZmlvL2NvbnRhaW5l
cjogc2V0IGVycm9yIG9uIGNwciBmYWlsdXJlDQo+DQo+U2V0IGFuIGVycm9yIG1lc3NhZ2UgaWYg
dmZpb19jcHJfcmFtX2Rpc2NhcmRfcmVnaXN0ZXJfbGlzdGVuZXIgZmFpbHMgc28NCj50aGUgZmFp
bCBsYWJlbCBnZXRzIGEgdmFsaWQgZXJyb3Igb2JqZWN0Lg0KPg0KPlJlcG9ydGVkLWJ5OiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Rml4ZXM6IGViYTFmNjU3Y2JiMSAoInZm
aW8vY29udGFpbmVyOiByZWNvdmVyIGZyb20gdW5tYXAtYWxsLXZhZGRyIGZhaWx1cmUiKQ0KPlNp
Z25lZC1vZmYtYnk6IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQoN
ClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
DQpaaGVuemhvbmcNCg0KPi0tLQ0KPiBody92ZmlvL2xpc3RlbmVyLmMgfCAzICsrKw0KPiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbGlz
dGVuZXIuYyBiL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPmluZGV4IGY0OThlMjMuLjVlYmFmYWEgMTAw
NjQ0DQo+LS0tIGEvaHcvdmZpby9saXN0ZW5lci5jDQo+KysrIGIvaHcvdmZpby9saXN0ZW5lci5j
DQo+QEAgLTU3NCw2ICs1NzQsOSBAQCB2b2lkIHZmaW9fY29udGFpbmVyX3JlZ2lvbl9hZGQoVkZJ
T0NvbnRhaW5lckJhc2UNCj4qYmNvbnRhaW5lciwNCj4gICAgICAgICAgICAgdmZpb19yYW1fZGlz
Y2FyZF9yZWdpc3Rlcl9saXN0ZW5lcihiY29udGFpbmVyLCBzZWN0aW9uKTsNCj4gICAgICAgICB9
IGVsc2UgaWYgKCF2ZmlvX2Nwcl9yYW1fZGlzY2FyZF9yZWdpc3Rlcl9saXN0ZW5lcihiY29udGFp
bmVyLA0KPg0KPnNlY3Rpb24pKSB7DQo+KyAgICAgICAgICAgIGVycm9yX3NldGcoJmVyciwNCj4r
ICAgICAgICAgICAgICAgICAgICAgICAidmZpb19jcHJfcmFtX2Rpc2NhcmRfcmVnaXN0ZXJfbGlz
dGVuZXIgZm9yICVzDQo+ZmFpbGVkIiwNCj4rICAgICAgICAgICAgICAgICAgICAgICBtZW1vcnlf
cmVnaW9uX25hbWUoc2VjdGlvbi0+bXIpKTsNCj4gICAgICAgICAgICAgZ290byBmYWlsOw0KPiAg
ICAgICAgIH0NCj4gICAgICAgICByZXR1cm47DQo+LS0NCj4xLjguMy4xDQoNCg==

