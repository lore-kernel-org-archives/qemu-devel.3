Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD6BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RJw-0005kS-5U; Wed, 08 Oct 2025 06:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RJu-0005k3-AF
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:22:54 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RJq-0004rR-5R
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759918969; x=1791454969;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V6BdlgWQMZtocfVIrjaZ+gN1IOkXI9/XCNu6Brcw76M=;
 b=nESdiBYcQ8aKQ+I5W/ekV1H0OtTxl8VHP49kVDS5McGokdNHIrnHbGnQ
 mJabGyPuLeXuyccCIjPXtitOl5SzrOewGCN1RLvuwhoZPpKowg43kaD4F
 RM+WJPfDPl1sjREZ+1iV9sT1yCyG36V0lFC8OT48H4w08gzL4jOWw08MY
 GQCaagL7U8EcagAZo8j9NaKQiviANXW9vcZyoypGL2p41mArJAOC0YdGk
 mwOOk3kGDVKdtDqhEujrL9fY2omnFi82kppWJj7T2NP8LxZgjShiiG8DF
 BLAa2Mhk4EbFjeD5qolSh+FJilF5W9you5D3BObfSfYr1IaeOxDR3D0XY g==;
X-CSE-ConnectionGUID: SwUbWl1JS9CqnMvPQwQHYQ==
X-CSE-MsgGUID: nAwH2rstQIORtwcd9zODUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79544050"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="79544050"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:22:46 -0700
X-CSE-ConnectionGUID: hhEpf+uETU2f0qG7gG/qQw==
X-CSE-MsgGUID: t7xHRnpOT7S6if4XfnlP1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="180071895"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:22:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:22:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 03:22:45 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSADxMGNCo50xPrLA1YFLy4UFmrbE95UmrC8S4T6IYlfVPEd7xjHq49xVeAjvn0IZfRNr2C9y0cK/NpGYuaKExNGNieZBoabWStmQdEoaK60DWMvBgSiDJ+Ya5Q9OlK2+1bQzJHCWnsE/v/rGomkXp0Hqw2C0x6BMSrW5ht0gYez4qy+AzWiyNxhnnyrQYmAcIwvWfXLygXhr/vRu21qFhs1FjfLXXndFn/RO1jCgc4Rp02yHrNyPllBr/OyHzLe+5vu+sPR0gzVOZWxF31rv82SfeMI7aotzYDbLQVtbEKiKMAO+fbz6UIjWKM3xVMW2uCYIkwIXQ5IddCh4H3tKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6BdlgWQMZtocfVIrjaZ+gN1IOkXI9/XCNu6Brcw76M=;
 b=ljFMGGqhzXQJ7v6TUW42rRyJ8T8jfWwUstbhVZfou9WclT0GTkZAO2+JAtufiCmYrBAYsMTMxp5Lolglv3VCOP4v5w42PXRvrdJKlE+1ixN5Ap3IQMDdW7jkNSMX5VnvK0lbXGthKQ+3eN08ECJgT+Jr6feJGfO7NRAYop8MMbGWD2bZH9BCctzI8682MdLuxAnZ7hmc4b0CLlDx4ZneIU7YjoYjhcK7b2Ug9no7F2hjPPxS98kWZrTGLAqSt1Y0FAV4b7U7W8LJeQfYx29uK5s9p4VMAyOvJisPPnrAtKKe8pu+zKMs6zHn3LiUwV0jKSZ5BUX2nKBHl20Gd9NQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB6662.namprd11.prod.outlook.com (2603:10b6:806:256::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 10:22:43 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Wed, 8 Oct 2025
 10:22:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Topic: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Index: AQHcMFWngtFRdKHVOkWcXMje/gJxi7SqMJYAgADkn4CAAJxjAIAHrvKA
Date: Wed, 8 Oct 2025 10:22:43 +0000
Message-ID: <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
In-Reply-To: <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB6662:EE_
x-ms-office365-filtering-correlation-id: c3625f11-2397-4efe-4ceb-08de06549e30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?b0dKRXVzWDFtZEhRUFZNOWV0L0tkYjF6NzYrMlVORW1YcXdNWUxrVWwreHlT?=
 =?utf-8?B?S2lGYWRPaW8vY0RnRjVVL0RKeFNsT3pjYW8yVElFWmN1TUtxcmpzRjM0T0FF?=
 =?utf-8?B?MnQxWlc5ZVVNSzJ3SGxvVFl6L1AzUWFnY29HR0lZZTlUWFQwMndHT2Ziemxi?=
 =?utf-8?B?djZZbnVVaUlEN3U2cklhWTc0WFpTM0xLUWJzQXNmNmgrMUs0eVRvK1VSK3Fy?=
 =?utf-8?B?blNSY0x3WDFnckNGUm82cjFjK1doay9sYklUelFOU2hUdHJ3dU1SMEhFTVpM?=
 =?utf-8?B?elludGxlWGY1Sm43Y2d3ektZeHhOZUZnT1J5b3Q2TXlPQVpMWW9MMVNRRXRI?=
 =?utf-8?B?NE03Y3FUS0ljanhYVlg5ci9pZ2V4WGFQdEJCVURLYVFlWnIvSGVWUkhNTUFR?=
 =?utf-8?B?WDROcHV2N1dIeE9xaUlYa2xjRTkvYTFBeFJiVmpBOGpMVGFCdjRGV1crVGhh?=
 =?utf-8?B?cERLa2ZxeVI1Sk90WlVIVHhiTC9WY2FxUmVFMEFPa2FORlUwODI5NTE2bjk1?=
 =?utf-8?B?YkswalpJYWI1MTUvby93UjZVam15bnRHV09Vdjd4emgrMXhLV1VFMis4VkZP?=
 =?utf-8?B?MUR6Mm9PVlo3TWRqekRPMjB4NXJVTWdneW5kL1k4R0tDQzA5ajQyZkpudE0w?=
 =?utf-8?B?djFoVFpvdjN6aEFDUGV6NVBnVll2bDFJeW1aQkFlY1phbHk2UEJSL1R1aytY?=
 =?utf-8?B?VzRSbENMZHV6bkphNjg0UXhveVp3S3JqSmtnOU9pK0Jpa3hMOWloc1dwejNP?=
 =?utf-8?B?NEhDQm92SVdhb1g3Z3RQcElLRTRaTWs3SGF4OHA2Q3VzWE5TV2hnUjJZdC9L?=
 =?utf-8?B?MU5BTC9Id3RhRFc2NGJvaTcrck1aME56eFJRdjNPVXBaR3RPaWs2YXVsZkNJ?=
 =?utf-8?B?UFYxMDB6UnV5OFFoRUN4TzJ5R21ZbEJERnFtTXBYRER0NTc5WFZCNk1tVTNt?=
 =?utf-8?B?dGFKWHhiYUoyU1loZVdOQVRub2MwUzFXRTZEUVVtMldIUFRSR3JvL0JwRkJi?=
 =?utf-8?B?TGJVdmI2WjhCK01lOWRBMmdYdjF4RXMxMzBLVkprUVhqdDZiRzVRUnBBV001?=
 =?utf-8?B?WmZVTjAvZURrWXRLVlN2dzNNdGZkTEtyelkwcCtWRUFCNlY4SUFsT1ZVclBG?=
 =?utf-8?B?dHNJSEMwMDUvMlh6aUo0QjZJVm1ULzBTY080cXlzdkZYb0JiTXRUckNFYjE0?=
 =?utf-8?B?WGZJUW1wTXFCbkdHanQ5WnZhM2kzTm1qNFdBcnZtaXJYZE5CMHQ4S1lOT1FT?=
 =?utf-8?B?alJIOXBQeHBEWnlndEV0ZXBiRG9kellXcU5NVytHR28yQ2F1Y0pkTFN5d3Fh?=
 =?utf-8?B?ZXZsMkc5UHo5NFMxYVdGZUpXV2ZKWXFlVWZQTCs4ZHNuTnBiV1JpbS9mcklF?=
 =?utf-8?B?YkhGeDZRQ0ZESUxqSHQ0WjZJT2FzeDBXdk9SSjlUTHVqWDVGUUhsSmFaSXdV?=
 =?utf-8?B?UlpIZEJCZVI0ei9KcGpZK2pVVTYydEZ4aFp6b1BoVjc5TXNEVzErZkVML2po?=
 =?utf-8?B?Tzlnbmg3TVJKSFNOTVlVd3VidmZUVEJnYUVvZmJIR2V2N0JSUk4yRW1YYmNM?=
 =?utf-8?B?dW5vZU9pSVA2Rk1CZzdIRE5PREZSQnprMHFicmM0UjB6Ymw0STUxTkxLaUo0?=
 =?utf-8?B?Z0Z2U2pvZHdFczRTWWFxaHR2OHRvK29LYlVrZDJ1dEc4Uk9jZW9INzVuNWpG?=
 =?utf-8?B?eC9mdElXRGtNcWJSclFlanpvWGhNMWw2NkZGVmVESktLa1JHeExYZWpNdG5j?=
 =?utf-8?B?RklRbjNGeVNjV2RRaFdnNE9JSENXcEZZb3hpWlJiTDhvQnFVa0l6akJ2THJX?=
 =?utf-8?B?Ui9QbElXZEEweWNuQWVRSkMySU9GcWQzL0t1TlpPbjc1Rjk3Q25qMGZPTGpI?=
 =?utf-8?B?ZzVxa3M2WXQ3N3dsNmpoOE5lRElRNEg3cmZDd2M4RVFlcHdqS2FOSWN5ZEZM?=
 =?utf-8?B?SXJrVVRhNC85Y2xWQlp1YnF2Q09GMys5VHlBUHZya2V6azBGbUd5ZDRYdjY1?=
 =?utf-8?B?QUNWbjNTeTJ1RE1WbzY2MWhwY1hIaDkyNzMrTDVZSGV4Z3FyODhzeCs2NWZl?=
 =?utf-8?Q?sS2X3P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OSswbnZ2TDVYNTNIS0pxbjB2bk84VFMwbWdqeTI4TFBzeUlFK0k3T2wzVnMz?=
 =?utf-8?B?b0NncEdIV0N2MHVma1UrY2daMUFvRFpQQ0NYQzYxVHFoakJaaDJ1emZrMStt?=
 =?utf-8?B?TFh3QTc4MUtZaDg0eXc3WkZkSWVMSmRyaW1jNjQ3czhhRzU2dlB0cmRkSUFZ?=
 =?utf-8?B?YXdFMWZUNFZDaTFqSlRrakFiYXh1bkdJNXFqQ3IyWmRScDUyajdGRlAxQlhy?=
 =?utf-8?B?NWhXNklNdEVtSmRBd1lPMW0yMHdjTWhnRjFNSjZoaXhlUjRWVGRkWHZqT3Va?=
 =?utf-8?B?UjhTT2tPbWdDRTBhZjFxZWhNQzZVemR6c24rbU5PQ2pSMTY1bzFlQnV1dWN6?=
 =?utf-8?B?amQyajA2a2ozd3RpM2FRQ2M1bElOUThEeXpNdjVqdHhhTVM5OWdpU2FJb2FU?=
 =?utf-8?B?WURDanpOQVVuWlNBNFBJVFRNcXFQNG5ZRGJTaUxlaFYycXJpaUk1S1oyUmRi?=
 =?utf-8?B?WjJRYUwrNGY2eE9NUk00cnFaRFFZeGdPR3JZZWtDMzl5amFkYU5vWVFRUnFF?=
 =?utf-8?B?elpxZmROMTFwcWhDTndtdHRUbXBsRXpybTh5MzhKNndJa211L1NZdnVDeXhx?=
 =?utf-8?B?OGYvUktvRTJ3NHBhbHYwS1pUY0pUbUtodVM2UTQxUm83eFdpVG1oRlZubGd5?=
 =?utf-8?B?cGlvUEJLY1JOK2F5eElGdUFLMklEUEpYdGhoZnZ3REJ1eHArbTBET0pyOVdh?=
 =?utf-8?B?ZlZOTWFFUkllUUd4UFlVQlRHK3p3dUlkbmZRbU50eXBid1JSS2h6RW9YVjUv?=
 =?utf-8?B?cWhRR0dESTR2RHpPVXZBeGtLVTZYa0UrLzBtSUhUTk0vVVRYMWRNbzhnWnEz?=
 =?utf-8?B?d1VkRi9iK0lHSmFIRmlxczAzN1RWTzVXU1ZzMVd3VG8yM1VaajFvWmpsR05j?=
 =?utf-8?B?Mzd1a29LS0x4ZkVidm9wdVljYUdhMVB6QkZ0SmVaa1I3RFB0bk5QaGRyQS95?=
 =?utf-8?B?ZGF3bmZ2bVBhZzJEdG5kTnRld1JPdFRMTm5Xd2F6UCtyc1JlRHUxaVZoaHFF?=
 =?utf-8?B?VUtWNTRHUnZ6TDdhRlgxZFZ1WVJzT2NOQkFlRGYrMjNOUjBRRklHeDBncEp2?=
 =?utf-8?B?clg5Y1VHOVJhMlVTV1lrZEJ6eTFqdzBLcEl4aDlyZ2tWNjErSWR2bU1DUElW?=
 =?utf-8?B?TzRvZ3NQWlpLbm9pYkNMbHVCMVpkZ3M4eXZ5VUNQYkx5bThjbENoakxhQVJz?=
 =?utf-8?B?Y1FLTHI5VmEzekRST0x2MnRJZlc1enRqNDdlMnhxb3o2TFM1VThabWpsUkN0?=
 =?utf-8?B?QjNwajVwQ3c0UFBZQ1ZIVk5YaU5kektpVDhXZlpaVnY0aUJRRlBQUkhSMVh5?=
 =?utf-8?B?OThKeTRZamNNUGZCTkpvOEVja0xXM21RVkl1QzJleEp2Qm9wRlNLWWQ1VFR2?=
 =?utf-8?B?VGdSQkM0OFpESlJXUjdNUjVvSTZocFJPTFJTWEEwdW1vMXEybmg4VlNRUXoz?=
 =?utf-8?B?TTdVaVJjOS9rdk5xYVVFc2MrNU5uQzJGVlVaL1ozY0dzU3dkK1BZTmc0SHBC?=
 =?utf-8?B?ZUxPRTJ4WmNRS25CYkVraURsLzhhekVMK2lSUnVqREZmR3JnSit4cXZ1SVZN?=
 =?utf-8?B?cEE4d0xtc3pUVnd1bHNEaVppMXF2SHl5cjREL1EvNjFRS3dCOFJYa25qbTJT?=
 =?utf-8?B?ZzY1NFBmRWZPUjN0bWcveTNuWTBydGtkSUlLRmZ2SXhXTUs4dWE4UkJLekZN?=
 =?utf-8?B?LzdETjE4cDZocjRvd2J3d2E0R2JnRWQzNVNpMTZOc3V5OW8vYnpoelNkSmlG?=
 =?utf-8?B?Zk1KSDE5OGlYK0tWOTRFTlBoTWREL2g1b2NFbHVCNkNUUXJzc1MvOTFzUGJR?=
 =?utf-8?B?blZMeVJ3eXJSWThsaENFeld3Y3c2UFVpSkhnN210WHplbzNCZENrV0xzN2FW?=
 =?utf-8?B?b1JEaDgyL3lYZk9KYytpcmlxOHVwbktsUFQyczhDSUE4ZmxvcXA4cVpQTWVn?=
 =?utf-8?B?bG8vSjAxMkc4STJQM0JZSmtZbjQ1cW9GQ3pQUjN2SUFtcTJWbXZjQ01CMzhN?=
 =?utf-8?B?Vnd1WGlTdnNQYUFSTVZzVk9KQktvbGZRRTJhSzcwUHlPVExhaWl3cElRTXZ6?=
 =?utf-8?B?SGZYR2ozbkgrb3VCUXBDWm9qZGU1SXoybkJoL3FjN2o1anlkR1hQZHhRWVZa?=
 =?utf-8?Q?MTNAJW/MYVU/Guw+DNMMysZMH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3625f11-2397-4efe-4ceb-08de06549e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 10:22:43.3577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DW5jp0I6EnzmvFSR//7Tkx8l6vm3MeX96fm8Sz+/BOxkzeCuPtJvldY34yK1YsAFaNVaTii4uiYdGqYQpEGaZHARwkXwtfiIZWdDgyuTURs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6662
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNi82XSBh
Y2NlbC9rdm06IEZpeCBTSUdTRUdWIHdoZW4gZXhlY3V0ZQ0KPiJxdWVyeS1iYWxsb29uIiBhZnRl
ciBDUFIgdHJhbnNmZXINCj4NCj5PbiA5LzMwLzIwMjUgMjowMCBBTSwgRHVhbiwgWmhlbnpob25n
IHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogU3RldmVu
IFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiA2LzZdIGFjY2VsL2t2bTogRml4IFNJR1NFR1Ygd2hlbiBleGVjdXRlDQo+Pj4gInF1
ZXJ5LWJhbGxvb24iIGFmdGVyIENQUiB0cmFuc2Zlcg0KPj4+DQo+Pj4gT24gOS8yOC8yMDI1IDQ6
NTQgQU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBBZnRlciBDUFIgdHJhbnNmZXIsIHNv
dXJjZSBRRU1VIGNsb3NlcyBrdm0gZmQgYW5kIHNldHMga3ZtX3N0YXRlIHRvDQo+Pj4gTlVMTCwN
Cj4+Pj4gInF1ZXJ5LWJhbGxvb24iIHdpbGwgY2hlY2sga3ZtX3N0YXRlLT5zeW5jX21tdSBhbmQg
dHJpZ2dlciBOVUxMDQo+cG9pbnRlcg0KPj4+PiByZWZlcmVuY2UuDQo+Pj4+DQo+Pj4+IFdlIGRv
bid0IG5lZWQgdG8gTlVMTCBrdm1fc3RhdGUgYXMgYWxsIHN0YXRlcyBpbiBrdm1fc3RhdGUgYXJl
bid0DQo+cmVsZWFzZWQNCj4+Pj4gYWN0dWFsbHkuIEp1c3QgY2xvc2luZyBrdm0gZmQgaXMgZW5v
dWdoIHNvIHdlIGNvdWxkIHN0aWxsIHF1ZXJ5IHN0YXRlcw0KPj4+PiB0aHJvdWdoICJxdWVyeV8q
IiBxbXAgY29tbWFuZC4NCj4+Pg0KPj4+IElNTyB0aGlzIGRvZXMgbm90IG1ha2Ugc2Vuc2UuICBN
dWNoIG9mIHRoZSBzdGF0ZSBpbiBrdm1fc3RhdGUgd2FzDQo+ZGVyaXZlZA0KPj4+ZnJvbSBpb2N0
bCdzIG9uIHRoZSBkZXNjcmlwdG9ycywgYW5kIGNsb3NpbmcgdGhlbSBpbnZhbGlkYXRlcyBpdC4g
IEFza2luZw0KPj4+IGhpc3RvcmljYWwgcXVlc3Rpb25zIGFib3V0IHdoYXQgdXNlZCB0byBiZSBt
YWtlcyBubyBzZW5zZS4NCj4+DQo+PiBZb3UgYWxzbyBoYXZlIHlvdXIgdmFsaWQgcG9pbnQuDQo+
Pg0KPj4+DQo+Pj4gQ2xlYXJpbmcga3ZtX3N0YXRlIGFuZCBzZXR0aW5nIGt2bV9hbGxvd2VkPWZh
bHNlIHdvdWxkIGJlIGEgc2FmZXIgZml4Lg0KPg0KPlNldHRpbmcga3ZtX2FsbG93ZWQ9ZmFsc2Ug
Y2F1c2VzIGt2bV9lbmFibGVkKCkgdG8gcmV0dXJuIGZhbHNlIHdoaWNoIHNob3VsZA0KPnByZXZl
bnQga3ZtX3N0YXRlIGZyb20gYmVpbmcgZGVyZWZlcmVuY2VkIGFueXdoZXJlOg0KPg0KPiAgICAg
I2RlZmluZSBrdm1fZW5hYmxlZCgpICAgICAgICAgICAoa3ZtX2FsbG93ZWQpDQo+DQo+ICAgRWcg
Zm9yIHRoZSBiYWxsb29uOg0KPg0KPiAgICAgc3RhdGljIGJvb2wgaGF2ZV9iYWxsb29uKEVycm9y
ICoqZXJycCkNCj4gICAgIHsNCj4gICAgICAgICBpZiAoa3ZtX2VuYWJsZWQoKSAmJiAha3ZtX2hh
c19zeW5jX21tdSgpKSB7DQoNCk9LLCB3aWxsIGRvLCBjbGVhcmluZyBrdm1fYWxsb3dlZCBpcyBh
IGdvb2QgaWRlYS4NCg0KQ3VycmVudGx5IHRoZXJlIGFyZSB0d28gcW1wIGNvbW1hbmRzICJxdWVy
eS1iYWxsb29uIiBhbmQgInF1ZXJ5LWNwdS1kZWZpbml0aW9ucyINCmNhdXNpbmcgU0lHU0VHViBh
ZnRlciBDUFItdHJhbnNmZXIsIGNsZWFyaW5nIGt2bV9hbGxvd2VkIGhlbHBzIGZvciBib3RoLg0K
QnV0IGNsZWFyaW5nIGJvdGgga3ZtX2FsbG93ZWQgYW5kIGt2bV9zdGF0ZSBjYXVzZSBTSUdTRUdW
IG9uICJxdWVyeS1jcHUtZGVmaW5pdGlvbnMiLg0KDQpJJ2xsIHNlbmQgYSBwYXRjaCB0byBjbGVh
cmluZyBvbmx5IGt2bV9hbGxvd2VkIGlmIHlvdSBhcmUgZmluZSB3aXRoIGl0Lg0KDQpUaGFua3MN
ClpoZW56aG9uZw0K

