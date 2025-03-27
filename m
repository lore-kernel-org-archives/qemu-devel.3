Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B124C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txk3J-0002NH-B2; Thu, 27 Mar 2025 06:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk3G-0002JQ-BN
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:01:30 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk3D-00034B-OU
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743069688; x=1774605688;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cSsWd/eYJZ1hplkMHHZnLrUD2JZAYDwwGSt9nvO9gok=;
 b=cMgMIs5bUOsYaGP59BQy5IBBebEnCjg6gC9dotyJ/1UVkgSdW9qg/KQf
 whSDZ2fXtRWIe5gr8IwkH24sW3lFU5chnX/dMedr/jmRC67zBr90RetGr
 SazVPIeKNPKSJqKcyMLStaq6A349QpK+O5wc2kJHVjAUfvp0YfT5vFxNN
 ekXCJ2bJNeUMIwLw85FGYou1MoSYAufPxEPuXax6h/wvRYab6o8uTKkrU
 8uvhzzUacrSkI8Q002cF0QVigfLhsab2c6ghSwf804Jm2iVlskdyDpRbQ
 NS+j2HZPOq3ItxeX09j75Mk3jJQsBGzw4vGZYd6N8G/cnkMQkD9MumcWH w==;
X-CSE-ConnectionGUID: Tnd4eBTQSHudDiF/XGT8qA==
X-CSE-MsgGUID: eLbd8ZB4SaiyC7s+OelZNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44575661"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44575661"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:01:20 -0700
X-CSE-ConnectionGUID: OAHVPw3ASc2TUc77WQU7+Q==
X-CSE-MsgGUID: Gkk6pnV2TAORG1SYf0pqNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="130281590"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:01:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 03:01:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 03:01:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 03:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvviT4CBU7sCWpNy4qe52g7WiNDmj42iXExUWgVkUEIgGU+JHeGtVvI1CTlxrevx/3mZsLSw2EGh+ux72W81dtJe/a9jV2XIoLzBlQlXFSFBREiH/QuJzR2Q8DpZY+bF3mTYmqmpUxAWYI+vt2JksYlaNVEuX3RwH3KRTLjGB0zUBQzcNfHDWm59zUwmAza1wyf3W+1UFkf8pTwZ2gZpiBPB6ii82qrXnz4++FA0NInOUo6B9f3HCDBeJVGh4BqhnnIU6tP2dw30VAlbzrdMYoOW8SR/RleDe/lnFMgsFnAqOUBqkEXtSjreUsUa1b0uS5PBp6wNQ1v+GEXW0J2eSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSsWd/eYJZ1hplkMHHZnLrUD2JZAYDwwGSt9nvO9gok=;
 b=CyUA4ABPNmUpYXiMKCoAWlTRoz4i4SfDRbjS0dUB9R6G9Z3cdJd/M60EkkaZtgigwaTcGsVBzd7aXlxed0uVJ2BLkY7WES9jZsP9q/Hoi1DJ4VqPC8/MfoDAx9DCUhfQBRtV5FGdL2RpFU/jZvl3GZ5NPiF1Ju0i+MFEgK0sKjvPuFPtdSXNKKfUdA2uQTBsFHK7VB7ZlX/lmcpKKQazAiFgmqrm3+7MSibClcQOW0NodWuusgG+H38Y0IDhugC3YiP9MmdYAApl1RK1y+NCLaRSPgoptg6guUZ/vD+92dqAnDPMfSeTVyvj/Vxa3Ib+mXGFfB6ga5rMAtipbrFQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Thu, 27 Mar
 2025 10:01:16 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:01:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 24/37] vfio: Move vfio_de/attach_device() into
 device.c
Thread-Topic: [PATCH for-10.1 v2 24/37] vfio: Move vfio_de/attach_device()
 into device.c
Thread-Index: AQHbniQmZIb78VFsE0OJGL7n7n8DVrOGwgCw
Date: Thu, 27 Mar 2025 10:01:16 +0000
Message-ID: <SJ0PR11MB67447F58344161AAD5F056D692A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-25-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-25-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: 3190f6ed-9075-4bdd-bfc3-08dd6d165059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?WHc2VlFMcHZ6YUtPeFdPcmQrdnJKVFJWc2xZbVRMQ0s5dEpLYzIrTHFJQnov?=
 =?utf-8?B?RmVUYlhualBxUXE5U1dWdkVtbGJpTDhWNmk2a2F6UVFmbS9naG83bWhuUmRV?=
 =?utf-8?B?STQ2SlAyMWlsQ0pubGhpb3VsZzhzVU5XNU82TmlrUlVxNzh6OExuNVhNQkRo?=
 =?utf-8?B?ZXdPT3liT3RrY04zcFUzb21LdllpdGRrSlZKUjQySVVuUWJzbmkveWxmK2x3?=
 =?utf-8?B?dStEMzB3MkZ6bDJWSUlEcndFVjZhaGlvSGJaa1lDNFNQYzZoTjdacTd5dmxU?=
 =?utf-8?B?YzNnTHpndm1MaWVqM3ZVbTNJbmdQTDZYTVNJYkZoQUdwTTNnVGE5ekcxOW5H?=
 =?utf-8?B?Z2IySTQ4S1RkMUlYZjZsUWZ1Y0cycDZaRHZVbFQwZWxueGpIMUR6ZnNma3lL?=
 =?utf-8?B?bUQ0WkJ6cWgwWGZ3OVcwOFNOK0hDNnhCN1RCb1RxR2cxTWQ5R3YwV01zOHE2?=
 =?utf-8?B?MzQ1SjdVRjZZUXRKaC9DZGRnL3ZxY21IZk1TYyswUDVtN1B4c1JtUUVDZERz?=
 =?utf-8?B?K29pMFQzNDZFeVFMZ1NMS0QvS1pSVGMrM0hCbENGTFg4enp3WXJiUVlQWmRN?=
 =?utf-8?B?MjF6MlJJSENUTUdkR0hBU092NEFIUjhqMnRjU21FdTE4R2xIZnJRVkhnL1dM?=
 =?utf-8?B?bHRJaUxpd0tJWDh4RjV2bTV5UUh3NTI0Rm1WbUt6eVhZekxQRkc0ZXZtclZO?=
 =?utf-8?B?RnMvZzRUM1lsZ2hCOGErZGp3SkpPRkdiN2dhQ0czZU5uU2NFR05zWjhHWjNM?=
 =?utf-8?B?YU9pRVBKcnNKTWJPcENFbHQ4cXdaL1ZYcEVwWUZMQW5HYUhrMTY5MnRpN0ln?=
 =?utf-8?B?bUpqZ0owajdMa1FGYWJjaXJrVDErY1dZZU9jQmtYeUdITGNVQzJzbFA0T2Jo?=
 =?utf-8?B?VzdSRTdtNlRlY2VMTWJLWXB1ZFIzdTF4ZzJoSWEzYUluRDhLNGVmczZmSG5r?=
 =?utf-8?B?NUVLMldScVdIN0o3YWNzanY0NWFVQ3ptZGJ1MnoxeUFlUm1RUnNEbUNBUVpY?=
 =?utf-8?B?NUhCS21BMTd0WU9tSFgydlRqaWRzR0xvbzFNUHllSHQzRGdpYUh2ZVJ5NnRa?=
 =?utf-8?B?OHZmUHI3RWc3eUFBR0tIcDJMaDJabDVtYVZPOS8vMWxzZW95VzlHRmNmNEVn?=
 =?utf-8?B?YWlLRmUrVUlmU2NUU3UyeWhyRGh4aXVIYnZ2a3RJcjBjdjlLWWNUZ1FGRWRO?=
 =?utf-8?B?MUJ1UmRjakZSYmd3YlZzTW52QllhUjh5c29YMGRTVFFldzU3bDlYQVR5T2pC?=
 =?utf-8?B?QkJIeFdIekRqTEJ6S1hGN3hEcmpoRTdPN1czNnY2K1NnMlgyWjBNTXh3d3lH?=
 =?utf-8?B?WWZLUGoxUTUvd3Y4QWh5VEdGYTBKeE1hT2lLTmRsYjV1RzBkRW1OZm5MNzBT?=
 =?utf-8?B?aVV2SG45dVkzUm5qNVpzUFNPV0o4S3NFTk04bXVsZVl4dDNYcDJWRE0wQTRF?=
 =?utf-8?B?b1BWS1A4UlNkNHBkZS9nNkZZZkJpbmNMa0YxZHZaNEgzenV4WENKZ2RJZDM5?=
 =?utf-8?B?VWVXMHgvNGtMV3E4ZFpyU2JrWXlzYjdVdC83OFRKUEtSY1F0TzlVSzNtTTNY?=
 =?utf-8?B?dzhMRVhQekhuaTgrVGIwaDVOUEVMMUVLZHd4NzdjSnpWcERhaHBTcndweWhE?=
 =?utf-8?B?NEloSWJ1dnhnQ1NhMjRLQjR2NHBwNVZPRDZBVHNNNktHaFJIM3pYdTZOdjBU?=
 =?utf-8?B?c1g2Tzdyc2JZbkpnS3dIT0tYQlUrYWhJWXkrd09hbUV3SU1oQ095WkdBUFFz?=
 =?utf-8?B?VnRyeHFlUGc4L0tTWDExZ3Byb0ZPSUc0cFIzZmtNQlNFWk1DWW96b1RxUlR1?=
 =?utf-8?B?TlZvTXdwdi96UGVadndUWjRWdDh5T24zVWROTG9lTXcyNFc1eGtTWWxGb0ZK?=
 =?utf-8?B?a0dsU1V2S3dMVnVURU9XZnJjTm5WU2RXWi8rMzNDalNVRnFPcjZwNm9mT2pj?=
 =?utf-8?Q?1WlPfJmuYcrKFna3eVKeaNd9+yVYPY4m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TngyaXVXR2NiUkc2bWxpRXA2Ti9haXc4eXFTdnluamNrUU1hZCtlRTgrOGcx?=
 =?utf-8?B?cVV5SFQ2K3J1d2wwS1M0T3VIUWo2bGdQaFozbVJSNE1PUERYV0IrMzJ0NU9P?=
 =?utf-8?B?N3hhVFlTK0toRGZuQ1JWNjJjVnRoWEtQT1NPdFhOS01vQ054Y2ltUzRReDRJ?=
 =?utf-8?B?bGRkR2pBK1RSWnM3TXNtUVJycEZoSEtEMnNhaTdxejJOM2dPQmVrWjNJRGdw?=
 =?utf-8?B?WkttUWZHVmdubXNTRUc2MHQrWHQzc0ZUUGI4YnZ6NXZZWEgxc0RJWWtZMTNI?=
 =?utf-8?B?aU9LRTNSTzd6dnhmY3pFQytRN0J5QjhNY0hMbjMwUHNTQkdwbFg4bEhVR3Vv?=
 =?utf-8?B?a2taMDFsTEtzU2NIeHloODJ2dm9VR3UzRUkzWExpMmlaZmtPNVNqVVV0YTFB?=
 =?utf-8?B?aWJ1TkY5NTVxTTRTckxEZVNkR2ZTUXk0MUxFcGloQk41d1BmdEl6cmpDbEpV?=
 =?utf-8?B?T3YwRlBjdXFPY3JYemt2VjE3Z1cxSlU5YUZhMEs0MEJ5enR5TkwvOExWNnZQ?=
 =?utf-8?B?akNUQ2pVNUZjcElxTGRnTDZ5RmRXWkEvbTBxUHR6ak8vbFprZEpkQjlLdFpM?=
 =?utf-8?B?Q1JJOUprT0RxOTJmYXJUeXpGSUxQNmZNcDBWUHJIUUppcWltQk0wYTFaV3F5?=
 =?utf-8?B?RjJCN1ROLzFOVEFLVUVUZTJGd3Zxb2cvaVpjWlZFbDZlY3dQY1FUYmx6OUtP?=
 =?utf-8?B?dElacnJML1N6dkRWdnl3UkoyUk5DK28zeHM2WlJ5MmxOZjhWZ0tRVDIyN05M?=
 =?utf-8?B?UnkxeUZMRktOdG5YZzUxbEVmTUJ1R3lwRlAwaFhuLzJ0YzBlbmsyUUYzQ3ZG?=
 =?utf-8?B?dUZQL251dmV4UUVzRFprcktXV0pzVTdFd01NQ3JEdEdJY1ZtNU85STRFT2My?=
 =?utf-8?B?TFNVSnZZWXBCYXBSblNhZVI5Qk9FMzdKYStwUmxxRFcvbWJqem8zeWJ1dlZS?=
 =?utf-8?B?VzNwT3JNQlR2eVVucUIzT2ZjaVcydnUvdGpLbkNWZ0c5OWtvWldaV0h3NVNV?=
 =?utf-8?B?enV1SFpkZWlOK09sSERjMithZWFEcHkwYUVjQ2pIYU1CRzF6NmczREJ3V0Vm?=
 =?utf-8?B?dXoyL1Qva1cyakRRMFVYZTVuYVVobFN2UDNYVTUrVS9pS1pNREVJMGcwTk5z?=
 =?utf-8?B?UmlWSmI2MGZXTy9rWmVHR3pLY09SUjgwN1FiL25pd05WLzdsMXJUdlNhVHNE?=
 =?utf-8?B?THllZWVpVlhLOG5ZdUdZbkxuTjlPN0VYOUhFRGxOYjl4aVUwYUp6Q2phUmpG?=
 =?utf-8?B?bE9ETmRpV0FUZW5ydjc4eTNxT2MrWjdGOVhHRmdYTFF5MTlFOXZZUmZNdzBM?=
 =?utf-8?B?ODhIVFYxY1BseER3WjNPU3JxaitqR2ZIajZ4Y3QweDgvcE9ObjVoV05VazJO?=
 =?utf-8?B?Mktma01BbG0yTm5Ya2hCdWZYa0pvRVgzSkgveDFIOHhGWVUrNW5UUjYrM2hU?=
 =?utf-8?B?cEF5YWNKdlI0UXBqKytqSFdLWk1FZlVyeFBwNU9lTktQb3NZMFVPQ0xHam1H?=
 =?utf-8?B?UmwvZnp5aGhxYkNYa0dFQSsxSzJQbUdFajltOUl3UTVHRlpQdXZhb3BGay9v?=
 =?utf-8?B?cUF5WFh0Y21pNktRTThnZWszaEFDeU1HbDJ3djVaVzl0Z2MxSkFvUWZSWEw0?=
 =?utf-8?B?RGlCZ2Z2QVFlT1V0K3FkbFhLOTdaeU84bmREL25CZnJURlVQNEY1REpXdkFU?=
 =?utf-8?B?M01ScU4rak14Rm95eGpabC9nWGRnSDV0Rk9LL0Q1eDlLRHdXaHpPNXgxUXNE?=
 =?utf-8?B?QjBZUGt1ZzhveXlKdjlWRCtSc1ByZTZHUEJtVVp5Z2d4a3d2NEFpVll4eTJL?=
 =?utf-8?B?OFVVOEwwaXE1OER4eElhTk96YjM3WUUyU3YvSnNjR0Qwc1FtRDU1QUU2bzJ0?=
 =?utf-8?B?TUdsYWFRVnBmL3dITkVKMzZpa1gycFVuL0JGemYvTWxQQ2FST2hHb2ZsaitR?=
 =?utf-8?B?VWlFRk9NTFZZWnpvNlRhaFBORHZGUVZIMzQ2U0pHYWJwL3duQWNtUHluRmQw?=
 =?utf-8?B?cGc3M2ZYZVA5NHIxL2kvSy95N2RjS1FpeTczVEgwSGpZWmJoSW9SaUU5Y1lo?=
 =?utf-8?B?ZFVtWXMxdHZ0VGpoamNtV2FLT0ZYL3RGcXJZSEUyTEVzSzlUSHBZTDZ2RW53?=
 =?utf-8?Q?PtPZ7qgzoekAAIOOdWFqJw47W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3190f6ed-9075-4bdd-bfc3-08dd6d165059
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 10:01:16.0944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYtxx/A2DQB91Mb3dWFpUd7gVNSSf5sLOVkZYQ2Afqu69BliEErYXxwY3AsjkgCpRbH40Kt+ifWxwAzS6j3yOVOjzLQVEAGyze58FQvyF+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMjQvMzddIHZm
aW86IE1vdmUgdmZpb19kZS9hdHRhY2hfZGV2aWNlKCkgaW50bw0KPmRldmljZS5jDQo+DQo+VGhl
c2Ugcm91dGluZXMgYXJlIFZGSU9EZXZpY2UgcmVsYXRlZC4gTW92ZSB0aGVpciBkZWZpbml0aW9u
cyBpbnRvDQo+ImRldmljZS5jIi4NCj4NCj5SZXZpZXdlZC1ieTogSm9obiBMZXZvbiA8am9obi5s
ZXZvbkBudXRhbml4LmNvbT4NCj5MaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRl
dmVsLzIwMjUwMzE4MDk1NDE1LjY3MDMxOS0yNC0NCj5jbGdAcmVkaGF0LmNvbQ0KPlNpZ25lZC1v
ZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

