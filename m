Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5782C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdl04-00075w-Fi; Tue, 13 Aug 2024 02:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdl01-0006vx-Jr
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:27:18 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdkzp-0004wM-35
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723530425; x=1755066425;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V1yBq6ooyyDVO6ShDlWLVF3AlSed9I/sBv9IGUToeDQ=;
 b=Bdv4WOszMID30yVQSN0yX4MHrzcA08CItLO694npNK8/iHCZteFruD7p
 ZN22tQ590V18XhMSCZMQa126dC4UtBn6pecKyNGZQNgBCfNcYFFwMKVrO
 KAdA6LcLPJy/zzZbKZcKT18XUKaLgx3lIs3uu3giibjlTEtnCCE16RQ2C
 9+0lmHMydYq9UX+4H527sittZjXcbMhdmMPvE/MIYHv0djC5UA8PaHU/7
 iimf7uBiDerAF6KdEDj/1bN1fTmhvmEDXC0uievQKYzGyWoObR7Y7PlOc
 Akzsc5G5ydydC1Bn5wvM1AL9Fmu/un+LWZqM/X/0/8UIJoRqDL+/L3Dte g==;
X-CSE-ConnectionGUID: 9gCaMhpbROaDbzb74NNCLQ==
X-CSE-MsgGUID: KjlMfHu5RqOszvX7WzcuwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32291189"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="32291189"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 23:27:02 -0700
X-CSE-ConnectionGUID: GefKIl4rTo+K8wxsdE/yiQ==
X-CSE-MsgGUID: XPx15sGYS0Op1LI3S9i5Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="62721532"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Aug 2024 23:27:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 23:27:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 23:27:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 23:27:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 23:27:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLci0RmIVZEM5Bx6M4IFl17im782Rt6l8n/vIrQGL0JzXIsmeKqoXzIJjLDQRJ2QfgVJCEZll6emAm0xIQ29PnripCwhSDkLV0/Tu8+vL33/TaQXD9h5RyUVzk2Q4kaDV3o6LEmOBBoKdpGgBKZmhF236caAZLOso4KeTa1aOhy9fBAJwdJN0n/BcQSSvGfMILC3esonwMgccU3X0yMpXm8eo8Dc3gvcRw23dfrvvHcfwrEsFFunQ4LaIa6+pTUFbnZFFbH8EKG9E4Um+b/AjZGl6LI0nEVGQaPi3yi6eq1JD7tUnYIdA9CtvdrbKMvenN06saTKlgszDfNCvuH3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1yBq6ooyyDVO6ShDlWLVF3AlSed9I/sBv9IGUToeDQ=;
 b=Tii6dmIGp/nWczZeG1Cy0VOz9JBG3TguVa14k3kRNutnQgkxk4kUNI8MbSG0tFRPlVCUTl8b90ITVZdXj62maQoc8rM8W7W/Pdazw7SMBuLn4bQSwDLkK5bKcqEYeymp7FBXiLcLeY7NgzyFMQ5xEi2w0TCqoJQQv+q1UtKZSK/tvtv8m9bLrKKkM5yVXon6P6dGXhUs5xrwRXViQVGI2Bio06M2rrEGUGY8aRuzrDbDxWIgQLaAmaiOPkcp0hP/g/myV+FrKU/8TTYlB7HfKOrQOszZeyrykW/TNQODLLAUzgDdKCU7jAv3/xZo3yLiytqp1sRGzBSmZHJ+1SXsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Tue, 13 Aug 2024 06:26:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 06:26:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa5wEF+Nis8FYiJkubkxZ/MAQBaLIZx6OAgAOIR4CAACp8AIAHBXmwgAAzsYCAABE1AA==
Date: Tue, 13 Aug 2024 06:26:58 +0000
Message-ID: <SJ0PR11MB6744A9D527EBEB97A6D4598392862@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-4-zhenzhong.duan@intel.com>
 <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
 <9ae22a85-9bf5-3d45-2d19-c3371aecf42e@intel.com>
 <7043464a-7085-4ae1-a07c-06785626b640@eviden.com>
 <SJ0PR11MB674466B036500FF8875889AF92862@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f1bc5d24-06fb-4b4e-b17c-9d21e57f9931@eviden.com>
In-Reply-To: <f1bc5d24-06fb-4b4e-b17c-9d21e57f9931@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7902:EE_
x-ms-office365-filtering-correlation-id: 615ae91c-5f97-4ed8-19ce-08dcbb60ef12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T2VTQjlLRTFoaXVHcVJWT2ZnWWRTWXJjamgvbE5ZOVJEb0FlRXhQdTRqV3Iz?=
 =?utf-8?B?RDVXT21CeEpkZHdOQ1JlMDBIY3kzVndIbkdtSGFqV3FZK3FCRnRjV2RYeEFk?=
 =?utf-8?B?UWM2QnlGTnlQekNESERaelFqMkR4eG8zeG5rYi8zZFgxMW5jR3k0NUlPbmlx?=
 =?utf-8?B?L3BudnM3MDZhZkN3a1RvYTR0VHNmUlgzMGRGbnBtYUFka1M0L3VLRDduMWp2?=
 =?utf-8?B?NlZXYk5ac1lyVkhPZUVYekQ1dHo0aDZmTFZ4bXBwVlVGMlAxWGJTelpudkZ1?=
 =?utf-8?B?eDZxQTdiUjJyQ1M4b2RpbyszRk9XMXZPK0dDSlpUQXZvQUlGaXh4enhjWjRs?=
 =?utf-8?B?OTBOVkhaTmhwT3BSM3hrN0R6aEovUFd3Y25KQytBak03aHhlRWJoeTh1a21v?=
 =?utf-8?B?RmtkSjd1MzVlVndNYWJSNGZDdWdBYTAxbmVqYi9qdndYSG10a28ybldaTDMr?=
 =?utf-8?B?c0J2elNmQ01FS2Zad2oySjRCQ3hEU2JoUzJ0TzlhcU1jWHpxMUw2dUN4cVQv?=
 =?utf-8?B?QkFPM1hqK291c3dSYUhnN2hKQVZpbnY0SXo1SWY1WG50UEpoUE95Njg0QkM4?=
 =?utf-8?B?U0pnTDdmbGFwcDdNcDdjYUo5Qm5rN1psaG1Oek1mOTRsR1cwaDNFTGttaEhI?=
 =?utf-8?B?YnNYN1ZYSHFaSW9FcWRqTytzOWFPWlNNV3ZWRHBEWjRxcW5UcEY4QXd6eElI?=
 =?utf-8?B?aUJna1ZCaXpNRzZWUjNqVS82UzdZZkUzMk9ucUhuUTZ3djRxSEJUd1hPMkhU?=
 =?utf-8?B?ckZSOEY3SzhHdlBKZnRhdkhkV3pEYkJTbkhMMDhkaldMVFdXSitpYk8zTURv?=
 =?utf-8?B?WkZwL0V0Nkp3Sll1cm1GdlRFYi94UFBMTXJTWWp0bFhobkg5ZmxRdS9vK3J6?=
 =?utf-8?B?dHRxeTF2dHpaWDF4TDkzU1NUazQ2NG5NVC9NdzZ1QWUwd0RsdnhlVmZWc1NM?=
 =?utf-8?B?NkNaa28wbjZLYVg0RHVqSmlHNmpRQ0F4MkRhaUt6UXpTVGJlRlNwbmlIdjNi?=
 =?utf-8?B?RVJ0WURuVlNtZXdEaGNPN0dsNHVUWU5PTFpQVkpnaVdhRnYxV1NwTVYyMzVX?=
 =?utf-8?B?dHhlenQ5ZDRHVXFzRmd3dldZMER0MXJPREI5TktFUmFhMWdXQmJMUHlVZTVm?=
 =?utf-8?B?K1R6dzNtWlo2ckVUZHFQRE40ZGttUExSOUJmMnJ0UDBXZ2VhUGVrZDJEL2wy?=
 =?utf-8?B?SW9GVzZ5QTRVYWw0ZWN2bC9QZXJQaFR6alFmQm5yeVJUSGU4ZU1tRURNcHFQ?=
 =?utf-8?B?MDAvTldWOHpiMU1VenI0RXZIZEtuUDRSVUFScXU0dWhrN2s2VzhBUjRLRENX?=
 =?utf-8?B?WEhpbnRKVnhwekcyNVo4cDFBeVNlWlRFZ0JNMkt0RTM1RUU0OWVNWGZIRFND?=
 =?utf-8?B?SjRyMHoweThwQWQvc08zMURmTkhmeklaMlY1OGd6cUo0WGhjWHl0bGpmdUEv?=
 =?utf-8?B?alA5V3UvWWgvVHZYS2dJdThINDBNb0EzcENpYVp1STRWbWVhY3B4elhhV0hn?=
 =?utf-8?B?bTFqY2ZoMmNZRlI0dmVQaEMxWlFmdEZmYTh6WEUxTEkvN2VpdzBKZ2U1WUdF?=
 =?utf-8?B?ZVNMajZjL0Vmc29GVmNFYzBVcmhZcGdLTnp3elM3a0svZzgva0REQ2s2eWFG?=
 =?utf-8?B?akx4b3kzK3JWSmhVSmZBNDJPWkVqRGFJV08yUWtRR21ucm1UVHBMNURRNGtw?=
 =?utf-8?B?QzBDRXlxdEFpdGhRRTA2KzRxZ0R2cG40d2FxY25DSDE2WFRHNmZIelo2TWc1?=
 =?utf-8?B?VzlyNjRvdmQyY0NQdURHYWkrM3ppQnN1eDJZT2I4aWRmcGpKSEpCNXJGWGxQ?=
 =?utf-8?B?bVowTDcyWXYxT1FFZFN1ZmRkaEVKUFBmdzFmblZmbHRKWXBaVkVsQUpidzNC?=
 =?utf-8?B?NDQzdGxJODgwWXJoSTBacUkxbDU2SWpPdkNjTGZRTEN2d2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THB2RVVlRlZBQkUxdWRGNHBoRUQwdzZpV1Y4L0JVajY4aHN0TytPNWlxR2Qz?=
 =?utf-8?B?YXYyVStKdkxkaHRpcTdwaFhaQWxibG9ZbllGL2g5ZCsyd292M3ZGdGl1Sytj?=
 =?utf-8?B?bmY4NkJsYXY1dVlaaUhzT0NxU0V5dnBaSHVUQmZXMCtJaGdWTVN0cGZaWEtu?=
 =?utf-8?B?Q0ptcTlVdlhWRFZRZUlpelcxYVRBelkxelI2bTYwZUM5T2wvazFCNEtMUzlh?=
 =?utf-8?B?TFlpK1dTSDRkdituVHl5MVJlZnJoTUFvTmt1QXducG4rbjNRenhmYzdXNnNJ?=
 =?utf-8?B?K3F1K0VVb3BwWXZWbFozQU5ad2RTVHZaNUJPOHRwbEp1Q1NNUnVxSVVobi9z?=
 =?utf-8?B?VGpsWTBFRUpjekFTRnFDWDJZL2pkTVpNbGNwNFM2T3lxbU0wSzlId211elV3?=
 =?utf-8?B?KzJvdVF1MDdnVHdWbFJraU0ydGtFZm9nWjR1RVNYaWZLc1BZcGlxclhaMVpa?=
 =?utf-8?B?TVRyUzJnMDR5TWw0bCt4OFhkNTVZNENsU2pNT1crdlR2eEhwYlI2M2gwQkow?=
 =?utf-8?B?ZUMzbGFsV1kvLzlGVjd0RENlYVFEdFVTTmVVTXIzMndMeExvZk92SUxwcmNV?=
 =?utf-8?B?NFVaODlWMmF2eGNaNXJSV0VtT1JuVGF6QzVPc2U3UG9rdk9wQzc4eVo4emlU?=
 =?utf-8?B?dktjbHZId3YzQkQ5bWpKdzZESTFjVnNCbzFKbnZMV3VQQXJkRGo2N3A3MWVN?=
 =?utf-8?B?OU4zYnRWQ0diWnpMOUpXSkNObG5GMEd4SzRFdmR4WkxxZ2JmeFp3Nk9YaWc3?=
 =?utf-8?B?NnYxZExzK0xWUjRESjRJa2ZWenRhMGdiNDE5QlM1TStGb2RPRy9aTjNuM1Y3?=
 =?utf-8?B?TEFhWkdhUmhRODI3VWNuOW9JdE50MngzVDYzSUc3RjBIUjcvN0d3TUVndTlN?=
 =?utf-8?B?eWoxYzNxZVdQUCtTZDFrMWdETjd3dUpMMGdqbHdMckxUZ0tPakREekFtem1l?=
 =?utf-8?B?a3pBaytIT1BLOVRJVzBJa3NCK1BldlUvVlN5NXBMTGlwbTkrbHRwS29HSUZm?=
 =?utf-8?B?Y3RaYXFiRk9vZ2QzMHNuZklhcC9BSUxwbkNLUHFUVkpQdUE3bFNmNGw0K0Vl?=
 =?utf-8?B?NzhDOUttNFVvTGpDOGpaNEVmeTFZZ1cwOE1OYmJPOGJBUC9LQnZnZjViaG1C?=
 =?utf-8?B?ZjU2aDQrakt3L1o3UC96L1RPWk1WTUZxc0VPdTRwWE95RnlNNjJ4QlNiY2JE?=
 =?utf-8?B?TmdWL0RsWG9aT3ppOXNpREo5NU5WZlg1b1NBcC9EMUhsMGllaUpFVzZqdG1a?=
 =?utf-8?B?aUhOT2xlZTdkeEFwVDA2MytLK0srb21WYUdQQlkvbWxYenRQZVdYaFJURHZB?=
 =?utf-8?B?VHluS1Z6UTFDNktpNEpLTkhQRkJPTzJZV3RUeFpkaDN3RDRPRFJFTGF4Z3dU?=
 =?utf-8?B?M25YMHZtNjVpWmQ4UzZ0bnNMZ1RIYUc5eUdCOWgyblpRNUVTNjl4eXAwdXRr?=
 =?utf-8?B?VHVHcENkVDlGR3NtdEEyOGVJdWxFQ3FNZHlvZUl6eHViNGlpZlhkMmpmbGw0?=
 =?utf-8?B?ODRZdzJtdHpFTTFLV1pkMkRZK3ZmcjhnRmY0d3NPeHZEc09UckxxUDNhcXlt?=
 =?utf-8?B?UFpPMm9aWFNvSDhGNmRnWUhuaWRZMUFXSVZMV1U1L2RwOEdFc09GSDRRS3FM?=
 =?utf-8?B?bVdKdENvVllQTEh5WDIwRGU5cEg3TTZwdnZEKzlmUHJZU3V5eEpxS2hCSk5t?=
 =?utf-8?B?OFVlZGMxeWRlRG9obWY2dDNaVllOd3pNbGZRWmVTRklOTlEwMExET1BjYUZ4?=
 =?utf-8?B?WWgyT3lTcHhwbmxvSnZlQU1XNW9BWW1iSllRN3lacHdTNjhhYnk1cXh3VnVS?=
 =?utf-8?B?YVhUdDdwUms4ZHdGbkxkaDZONVpVVzNobzcwT0RZeWtSOWVDdm9JcXJEV0ZM?=
 =?utf-8?B?RjJUUnY1YkVjcSs0azdraldQSDVEcUp1THdUdWlIMEtLOUlvTWRtYmdqTHJI?=
 =?utf-8?B?bGVuRTdIbmJmVTdGSXNNamZoK3dyU3hWdzhiSEdFUk9lMHVYckcvQVk5UHlC?=
 =?utf-8?B?RFpraU5RSjBMRDliK2QvcktQTkduNTBxZ0pxSDZ1Y2FkS3FmQisvT3J2YVJr?=
 =?utf-8?B?eTdnWThMWE4xODRUUHZkVFFMWHo3bXVsK01PUWxYTWlRaUV1VlNIOXlsSjdp?=
 =?utf-8?Q?Y6+QAHEK6YzDPedba8KZ1XKCQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615ae91c-5f97-4ed8-19ce-08dcbb60ef12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 06:26:58.1630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8KA8vpQ5o/DRyP+c+1WcAPhhSvLtLTNd2+7NRtnxjdY8tWzr0CLYXMD+MhK4zeuGj3XVp9ecCDPsITwRpJc+DOR80rg8f2sDv275OH5e2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlhYmxlIGZv
cg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+DQo+DQo+T24gMTMvMDgvMjAyNCAwNDoyMCwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPmVtYWlsIGNv
bWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IENMRU1F
TlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9s
ZGVyIHZhcmlhYmxlDQo+Zm9yDQo+Pj4gc2NhbGFibGUgbW9kZXJuIG1vZGUNCj4+Pg0KPj4+DQo+
Pj4NCj4+PiBPbiAwOC8wOC8yMDI0IDE0OjMxLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+
IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGlj
ayBsaW5rcywNCj4+Pj4gdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQNCj4+Pj4gaXMgc2FmZS4NCj4+Pj4NCj4+Pj4NCj4+
Pj4gT24gOC82LzIwMjQgMjozNSBQTSwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4+
Pj4gT24gMDUvMDgvMjAyNCAwODoyNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+Pj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLA0KPj4+Pj4+IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIg
YW5kIHlvdSBrbm93IHRoZQ0KPmNvbnRlbnQNCj4+Pj4+PiBpcyBzYWZlLg0KPj4+Pj4+DQo+Pj4+
Pj4NCj4+Pj4+PiBBZGQgYW4gbmV3IGVsZW1lbnQgc2NhbGFibGVfbW9kZSBpbiBJbnRlbElPTU1V
U3RhdGUgdG8gbWFyaw0KPj4+IHNjYWxhYmxlDQo+Pj4+Pj4gbW9kZXJuIG1vZGUsIHRoaXMgZWxl
bWVudCB3aWxsIGJlIGV4cG9zZWQgYXMgYW4gaW50ZWxfaW9tbXUNCj5wcm9wZXJ0eQ0KPj4+Pj4+
IGZpbmFsbHkuDQo+Pj4+Pj4NCj4+Pj4+PiBGb3Igbm93LCBpdCdzIG9ubHkgYSBwbGFjZWhob2xk
ZXIgYW5kIHVzZWQgZm9yIGFkZHJlc3Mgd2lkdGgNCj4+Pj4+PiBjb21wYXRpYmlsaXR5IGNoZWNr
IGFuZCBibG9jayBob3N0IGRldmljZSBwYXNzdGhyb3VnaCB1bnRpbCBuZXN0aW5nDQo+Pj4+Pj4g
aXMgc3VwcG9ydGVkLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmggfMKgIDEgKw0KPj4+Pj4+ICAgICBody9pMzg2L2ludGVsX2lv
bW11LmMgICAgICAgICB8IDEyICsrKysrKysrKy0tLQ0KPj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4+PiBiL2luY2x1ZGUv
aHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4+Pj4gaW5kZXggMWViMDVjMjlmYy4uNzg4ZWQ0MjQ3
NyAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+
Pj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4+Pj4gQEAgLTI2Miw2
ICsyNjIsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAg
ICAgYm9vbCBjYWNoaW5nX21vZGU7ICAgICAgICAgICAgICAvKiBSTyAtIGlzIGNhcCBDTSBlbmFi
bGVkPyAqLw0KPj4+Pj4+ICAgICAgICAgYm9vbCBzY2FsYWJsZV9tb2RlOyAgICAgICAgICAgICAv
KiBSTyAtIGlzIFNjYWxhYmxlIE1vZGUNCj4+Pj4+PiBzdXBwb3J0ZWQ/ICovDQo+Pj4+Pj4gKyAg
ICBib29sIHNjYWxhYmxlX21vZGVybjsgICAgICAgICAgIC8qIFJPIC0gaXMgbW9kZXJuIFNNIHN1
cHBvcnRlZD8gKi8NCj4+Pj4+PiAgICAgICAgIGJvb2wgc25vb3BfY29udHJvbDsgICAgICAgICAg
ICAgLyogUk8gLSBpcyBTTlAgZmlsZWQNCj4+Pj4+PiBzdXBwb3J0ZWQ/ICovDQo+Pj4+Pj4NCj4+
Pj4+PiAgICAgICAgIGRtYV9hZGRyX3Qgcm9vdDsgICAgICAgICAgICAgICAgLyogQ3VycmVudCBy
b290IHRhYmxlIHBvaW50ZXIgKi8NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4gaW5kZXggZTM0NjVmYzI3ZC4u
YzEzODJhNTY1MSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
Pj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+PiBAQCAtMzg3Miw3ICszODcy
LDEzIEBAIHN0YXRpYyBib29sDQo+Pj4gdnRkX2NoZWNrX2hpb2QoSW50ZWxJT01NVVN0YXRlDQo+
Pj4+Pj4gKnMsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+Pj4+PiAgICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+Pj4+Pj4gICAgICAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiAtICAgIHJldHVybiB0
cnVlOw0KPj4+Pj4+ICsgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+Pj4+PiArICAg
ICAgICAvKiBBbGwgY2hlY2tzIHJlcXVlc3RlZCBieSBWVEQgbm9uLW1vZGVybiBtb2RlIHBhc3Mg
Ki8NCj4+Pj4+PiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+Pj4+PiArICAgIH0NCj4+Pj4+PiAr
DQo+Pj4+Pj4gKyAgICBlcnJvcl9zZXRnKGVycnAsICJob3N0IGRldmljZSBpcyB1bnN1cHBvcnRl
ZCBpbiBzY2FsYWJsZSBtb2Rlcm4NCj4+Pj4+PiBtb2RlIHlldCIpOw0KPj4+Pj4+ICsgICAgcmV0
dXJuIGZhbHNlOw0KPj4+Pj4+ICAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiAgICAgc3RhdGljIGJvb2wg
dnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsDQo+Pj4+
Pj4gaW50IGRldmZuLA0KPj4+Pj4+IEBAIC00MjYyLDkgKzQyNjgsOSBAQCBzdGF0aWMgYm9vbA0K
Pj4+IHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZQ0KPj4+Pj4+ICpzLCBFcnJvciAq
KmVycnApDQo+Pj4+Pj4gICAgICAgICAgICAgfQ0KPj4+Pj4+ICAgICAgICAgfQ0KPj4+Pj4+DQo+
Pj4+Pj4gLSAgICAvKiBDdXJyZW50bHkgb25seSBhZGRyZXNzIHdpZHRocyBzdXBwb3J0ZWQgYXJl
IDM5IGFuZCA0OCBiaXRzICovDQo+Pj4+Pj4gICAgICAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlRE
X0hPU1RfQVdfMzlCSVQpICYmDQo+Pj4+Pj4gLSAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hP
U1RfQVdfNDhCSVQpKSB7DQo+Pj4+Pj4gKyAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hPU1Rf
QVdfNDhCSVQpICYmDQo+Pj4+Pj4gKyAgICAgICAgIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+
Pj4gV2h5IGRvZXMgc2NhbGFibGVfbW9kZXJuIGFsbG93IHRvIHVzZSBhIHZhbHVlIG90aGVyIHRo
YW4gMzkgb3IgNDg/DQo+Pj4+PiBJcyBpdCBzYWZlPw0KPj4+PiBUaGUgY2hlY2sgZm9yIHNjYWxh
YmxlX21vZGVybiBpcyBpbiBwYXRjaDE0Og0KPj4+Pg0KPj4+PiBpZiAoKHMtPmF3X2JpdHMgIT0g
VlREX0hPU1RfQVdfNDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+Pg0KPj4+PiBl
cnJvcl9zZXRnKGVycnAsICJTdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGFyZTogJWQiLA0K
Pj4+PiBWVERfSE9TVF9BV180OEJJVCk7DQo+Pj4+DQo+Pj4+IHJldHVybiBmYWxzZTsNCj4+Pj4N
Cj4+Pj4gfQ0KPj4+Pg0KPj4+PiBMZXQgbWUga25vdyBpZiB5b3UgcHJlZmVyIHRvIG1vdmUgaXQg
aW4gdGhpcyBwYXRjaC4NCj4+PiBZZXMsIHlvdSBhcmUgcmlnaHQsIGl0IHdvdWxkIGJlIGJldHRl
ciB0byBtb3ZlIHRoZSBjaGVjayBoZXJlLg0KPj4+DQo+Pj4gQnV0IEkgdGhpbmsgdGhlIGZpcnN0
IGNoZWNrIHNob3VsZCBhbHNvIGZhaWwgZXZlbiB3aGVuIHNjYWxhYmxlX21vZGVybg0KPj4+IGlz
IGVuYWJsZWQgYmVjYXVzZSB2YWx1ZXMgb3RoZXIgdGhhbiAzOSBhbmQgNDggYXJlIG5vdCBzdXBw
b3J0ZWQgYXQgYWxsLA0KPj4+IHdoYXRldmVyIHRoZSBtb2RlLg0KPj4+IFRoZW4sIHdlIHNob3Vs
ZCBjaGVjayBpZiB0aGUgdmFsdWUgaXMgdmFsaWQgZm9yIHNjYWxhYmxlX21vZGVybiBtb2RlLg0K
Pj4gUmlnaHQsIEkgd3JvdGUgdGhhdCB3YXkgd2l0aCBhIHBvc3NpYmxlIHBsYW4gdG8gc3VwcG9y
dA0KPlZURF9IT1NUX0FXXzUyQklULg0KPjUyIG9yIDU3Pw0KDQpTb3JyeSwgSSBtZWFuIDU3Lg0K
DQo+PiBXaGF0IGFib3V0IHRoaXM6DQo+Pg0KPlRoaXMgY29uZGl0aW9uIHRyYXBzIChub24tc2Nh
bGFibGUpIGxlZ2FjeSBtb2RlIGFzIHdlbGwuIEkgdGhpbmsgd2UNCj5zaG91bGQgY2hhbmdlIHRo
ZSBlcnJvciBtZXNzYWdlIHRvIG1ha2UgaXQgY2xlYXINCj5Tb21ldGhpbmcgbGlrZSB0aGlzOiAi
TGVnYWN5IGFuZCBub24tbW9kZXJuIHNjYWxhYmxlIG1vZGVzOiBzdXBwb3J0ZWQNCj52YWx1ZXMg
Zm9yIGF3LWJpdCBhcmUgLi4uIg0KPk9yIHdlIGNvdWxkIG1ha2UgdGhlIGVycm9yIG1lc3NhZ2Ug
Y29uZGl0aW9uYWwuDQoNClllcywgSSdkIGxpa2UgdG8gYmUgY29uZGl0aW9uYWwsIGxpa2U6DQoN
CiAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfMzlCSVQpICYmDQogICAgICAgIChz
LT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJg0KICAgICAgICAhcy0+c2NhbGFibGVf
bW9kZXJuKSB7DQogICAgICAgIGVycm9yX3NldGcoZXJycCwgIiVzIG1vZGU6IHN1cHBvcnRlZCB2
YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCwgJWQiLA0KICAgICAgICAgICAgICAgICAgIHMtPnNj
YWxhYmxlX21vZGUgPyAiU2NhbGFibGUgbGVnYWN5IiA6ICJMZWdhY3kiLA0KICAgICAgICAgICAg
ICAgICAgIFZURF9IT1NUX0FXXzM5QklULCBWVERfSE9TVF9BV180OEJJVCk7DQogICAgICAgIHJl
dHVybiBmYWxzZTsNCiAgICB9DQoNCj4+ICAgICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NU
X0FXXzM5QklUKSAmJg0KPj4gICAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhC
SVQpICYmDQo+PiAgICAgICAgICAhcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiAgICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJTY2FsYWJsZSBsZWdhY3kgbW9kZTogc3VwcG9ydGVkIHZhbHVlcyBm
b3IgYXctYml0cw0KPmFyZTogJWQsICVkIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgVlREX0hP
U1RfQVdfMzlCSVQsIFZURF9IT1NUX0FXXzQ4QklUKTsNCj4+ICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+ICAgICAgfQ0KPj4NCj4+ICAgICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FX
XzQ4QklUKSAmJiBzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+ICAgICAgICAgIGVycm9yX3NldGco
ZXJycCwgIlNjYWxhYmxlIG1vZGVybiBtb2RlOiBzdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy0NCj5i
aXRzIGlzOiAlZCIsDQo+PiAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FXXzQ4QklUKTsN
Cj4+ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgfQ0KPg0KPg0KPj4NCj4+IFRoYW5r
cw0KPj4gWmhlbnpob25nDQo=

