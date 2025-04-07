Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FC3C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hIt-0001cy-2v; Mon, 07 Apr 2025 03:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u1hIa-0001Z9-S3
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:53:51 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u1hIY-0005gw-Jq
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012418; x=1775548418;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rKnnWRgY+kHrzLRf3zmKYqBLIwg21K062K2ADcElaaI=;
 b=ah3nzMHljom1KcttpniIsK6fIhDghy31tGskbMBDCAMPab3LIOnry2nf
 TGdETr1p/2iKjyoyCXT8qlPytgCmnrrD3iaeZfhTbvZwkd1SER2AfQQPU
 JmZ1cRlj6HskNJMLT0XJLU0B0RzvXtfRh6tg9kVdFiwVN2AjPPLaExBRv
 3E4CQ4E2xpplCt7jXN9+Tvst1/97ey94wj0UR3wzsST/cMUONMXYbfM3z
 3uWCGWhrcwVY/ANYz3NKLHZFOm4zxjyU3wlj/tAe5l3QjTkKBxNVDrqXL
 QA+4mA6XXoHJeF5BrO6dSJ3mB2Idxrn2f4pPUcp5BN4PajbIg6DlIsWr6 Q==;
X-CSE-ConnectionGUID: f/3PZho2QaKa34anS7Y67Q==
X-CSE-MsgGUID: KK4UcAhMTG65FPqH55oLvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45502179"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="45502179"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:53:34 -0700
X-CSE-ConnectionGUID: MwXHh3aATryuP2eCDlBnaw==
X-CSE-MsgGUID: 7UZhx35cSSql8k5IgyJc/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128380292"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Apr 2025 00:53:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 00:53:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 00:53:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 00:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbCRf8q1BBClB2x7MyE5VmnDlXRhYqT39wU/B7bR4EJScCn+7cgAU1KA4XR9Br6zdk+3YOCO83ypj+mFAelvKO624ton2jo1h3/ybYu2nb+Au7NQrx0QIefI1eOBgud1xtLSBv8AjTAOfWp6oGg+IsHJUfmYdnJXr3gcMxR5K6ouBl8ErbU3gE8d8vKLRlR4k+0CwIx3zUaQ8Fca0qUf3vn8bcvPFJqHQG7mTcUpXQZmQOdnZU8+whfd2DBQY1z6ptiMJpxUmHmqcoi20gqytMpWjxxq56yrj4fpNhk7p1YlZBhUBvjThL6i9zSZHxb+FYBs32e7RsxMXc49S8QHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKnnWRgY+kHrzLRf3zmKYqBLIwg21K062K2ADcElaaI=;
 b=flxigQAmwrb/OupV7xZ1jq57pFru0/0KcPCkBG5dhulzk8DULwewOZmS5IY9UfMCLAbYfPEaC+xOxgwomMcHDvnpfnAV3hFksMwFlpWrwymwoqrS7rdbtd1UksXCi/nPd/e/hBLp3n/O4VW1Rpo3hE/aH77ulvtIn65FGLd2G3saizuByoO1FzSwAkM7V9ZnAMveFKihpMzg5XnwXwlYy+lHGtHOuzxVK/alhghWOYeO0oFP+l1HQAmEMSyKMERVl5VhBCzWQHOPR8+AMc3tQ+bUR6wT9BmJZTFD1UhQtZ5tYYq9d+liflGj09BQyjyRYBj7IxNJqM5cIa0SyOF3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM3PPFD3EB37DFC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f52)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 07:53:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 07:53:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for
 VFIORegion definitions and declarations
Thread-Topic: [PATCH for-10.1 v2 11/37] vfio: Introduce new files for
 VFIORegion definitions and declarations
Thread-Index: AQHbniQW1fH1XhI+g0itsTgL1r2YAbOGurYAgBEcVoCAAAggsA==
Date: Mon, 7 Apr 2025 07:53:30 +0000
Message-ID: <SJ0PR11MB6744784C71F86B276A0B31BD92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-12-clg@redhat.com>
 <SJ0PR11MB6744636C2266BA6A6837CB8D92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b0b5b230-4be8-4406-9ed2-978e9bcd4713@redhat.com>
In-Reply-To: <b0b5b230-4be8-4406-9ed2-978e9bcd4713@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM3PPFD3EB37DFC:EE_
x-ms-office365-filtering-correlation-id: b45b5cd3-8a3f-4db6-43dc-08dd75a94a0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dHllaFZIZWd1Rk5rcWY3M1JtTXBUMEQzeWxaM0ZqVy9SYndDKzl1cmUyQXQv?=
 =?utf-8?B?UHZKdlMySVJXMGVndUMxaGVSQ0xmSVZlMHQ3ZEdiRmovbmlodEoxajVyTG5M?=
 =?utf-8?B?RmFGMDRkYlgzWnRadWNqOVlNMW5lZ2lDSTF1TSs1cWt6NEUyZ3VEeWc5S0Vp?=
 =?utf-8?B?VERDT0pKWGV4Q2NGbmNZKzdYNGhicytGYmlvZUpaRkEvVzBScWV3b1FYSXJY?=
 =?utf-8?B?d3ZFYW83cHZxV29pNlNkc0lKeGRDYnFGUHdGclF1a1M3R0VVeGdXK3VRN2dT?=
 =?utf-8?B?S3JmRStyeXZLQStRc2xCOW5WU1RJVEVaUVZaVlB2a0RIQ20wMm1xSXNaY0dr?=
 =?utf-8?B?YlZqSEZDTmhEamxYOVpUQ2NFMTF2Y1NydWhoNktwa3ord3dHL09kL08yK04r?=
 =?utf-8?B?M2xoZ3FXSHhJeDhXZFNKRWdlbGVqQmlTajJUK0hFR3ZuWENRMSt5dUpYSk1q?=
 =?utf-8?B?blNJMGFzZ3EwTmZTRVAreVFsQ0hXT0NEZWhPODhIWHh1TlVUdlA1VHpRSUtz?=
 =?utf-8?B?RUNEbnFxQVArM1NkS3RDamZmb0RJU0hLQ1lBVmVxWUU0cjRPQjR5SHJHNGpI?=
 =?utf-8?B?N21EZWpKSVlZUXQ5Z2p6Vm9GamlqaktwRlhaODNwZStndEtyeCt1dU1XNm4x?=
 =?utf-8?B?TjBOaUJZYXhPbWc0Z3Fha2ZSbEpGVEZlWW5LVXpDZzNxRDVBQ3FkMmFBemM0?=
 =?utf-8?B?eGNYZjRXbnBxMGhHeGdqUi9WaVhWc3B3M0dPalB6eHZXVGpBbDk0TjgyRjVQ?=
 =?utf-8?B?K0Q1OXhZZTJKNHVDSjJhTFJ3K2xXTDY0YkxwNHphM1hyR1hnRVNkYjAwYUhj?=
 =?utf-8?B?dEY3b1VlcVVGVWhwSE5PcVFpb29IbThjeGJNVUY4eXY0RmVSMEJKS2grTUlo?=
 =?utf-8?B?ZHl0dzNHbmxTV1kyczB2UDdSNXgxdXZvMU5CeVYvRER0MnFFTGk1UDBpNkd0?=
 =?utf-8?B?M1hEd0RQemhFYnRrQ3RJYlZDRlBRbWpqNjEybGxQbmNDSlF0N1ZzejhLbEpZ?=
 =?utf-8?B?QkUzclh0VjNZUCtnU3VFU0dQM0JyNWF2OWpTaXpaSVorZkVDZGxCL05FZllM?=
 =?utf-8?B?dmNBUTJOSXY4emVnUTBGVFh3eDhNenlUdVB2N2YwVDVPUWovVGtvWUEzcjlP?=
 =?utf-8?B?dDliL1VOaXVScEk2bXphMHdFRERBQW5BejdvNzFmVk9WdmlLTVJCRmpIbnFl?=
 =?utf-8?B?RXVkS2NNSXFxdTRibW5mQWhHczhGOUFXelVZWm9EQlVYeisxeGdEWFJRT1dx?=
 =?utf-8?B?N1BTSk02emV0OC9jOHFvaHBDRXBjeGltODRRa0NIUkQ0VFZaQitUdW9mRllt?=
 =?utf-8?B?SXZOZmpDV3hPc2REemZPTkx5cnVjZ05veEFjejgxeTlWN0FqOVplaVEvejIz?=
 =?utf-8?B?Vjd1Y3djZW5GcmNlUnhsMjBNeWt4c2RRNnNCUjhUNDVqZG5abHlVUFlUMXo1?=
 =?utf-8?B?Y1d6cS9zZXhmSEsrK1Z3ZkNXVDQwQkNjVVZZY0ZWMzR2eC94djVNUG1lYjZ3?=
 =?utf-8?B?VGtVWFZFb0hZWXpqUE9majBxWDZCYnFrREd6bzAvVXkvdEtVTVhmVXlFVTFT?=
 =?utf-8?B?Y1hhdVpLNWlFNzBrbk41YUNrL1NwS3pxc0h3bmJqNHI3M3NVRm1BaVhLTGFT?=
 =?utf-8?B?N01Vbkg0a3BZNmg4bG5yTEJybVNNeGVJUHIrcWVwSHZBR05PT0ZvS05mK1N1?=
 =?utf-8?B?T0NiRmxjc1FQaGM3YUlmQVZ1ZHNGNFRYYlB6OTEwTXhWaWhvM1JGUURtMjkx?=
 =?utf-8?B?YW5xOWp2azBOd2hvdTZaVWtPU0w1UitpUnBCRk5jWE9wclBKMUlQb0tMbjkw?=
 =?utf-8?B?eEFJditKSUFvdGROdXd3TnZsYVF0TUR3VW1xZjBYQkFGT3VTeGtGRXgwRmlS?=
 =?utf-8?B?SU5VTlJ5VC92RDRoWXB5WU1UTTY2TVFKSDJiZ0RQVlMwa0YyR25Hd0hLWW91?=
 =?utf-8?Q?gMeQ5zlk0etdYt2ggVh+SMSjY4lKPuVZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmdjeGtDbis4MUtpMWxwcGE4NlhiajkzTi80bzg3MTl6SWhrekwxaUE2Wkh4?=
 =?utf-8?B?Z3VTYWNCQlVlM2RhWk1vVVJXQ2hCRVBPWUY4L0pzc3lTNUg1TmFpNFR2Wkgy?=
 =?utf-8?B?b1V3eG5wbFBvR3VlS1c1eVZGRmNWSVMvT3AvYWE4Z1UyRVRKbDNaL0VlWmVM?=
 =?utf-8?B?Y2kvMFB3cFMyMUdyVWFEaTVnMzVZdlVzWTIxbTk3MmVULzUwOUgxU3lwQXNN?=
 =?utf-8?B?aUlWSXhYNGd2MmNSRThNRWF5OWNHMG9pS1pJWWhLdVREUml2UWdId3Iwd1M1?=
 =?utf-8?B?WXljajhONHNQT01BNnpJdzdWOGU3alBwRTUyc2RsenlUQlI3ZGlqN1hJd3J0?=
 =?utf-8?B?bTVPVW5qQTZ2SWVVT3F0L1ZIM2tPaDh5cXdUNkg2REJIOWZIQ01oQThBT09k?=
 =?utf-8?B?WXBod3o2QitaakZlbEpLMnNvVS81OFFLNXRGWHVKK0xzRkQ0Y0dlRFFiZXZM?=
 =?utf-8?B?YlNSUFc1UXhxME14VzNUTUFLcHBiL0g3cGF1KzRNRVR0eXovQ3J1VFZPcFBT?=
 =?utf-8?B?dGZ3Um9QYlVBL2F5WmdIZS9iVTYyMUJjOFRoeENlZ2hLeU50QVhsNXRXL1F1?=
 =?utf-8?B?TFhPUkoydUxCajE1RFdTZTI4U3dyK3Yxc0M0VXBDYVdWOWZJSnR3OVhHaC9Q?=
 =?utf-8?B?aWplNUxOOWxDMEFzdHlGSDlqOXQyb3hJdnVDeFhkcTFBdDh1Y3VtenJFVGk1?=
 =?utf-8?B?T0llMnJxMVM1ZmNFQUM0UndEbTNBY3h3MGJqRFdFR2tOYkk1SUJYUERxSjlF?=
 =?utf-8?B?YlRmd04zYTdZbnBGck94eHQ5M0NmekRwSjlIYVc4aEVyZDViNnN1bVk1NFNG?=
 =?utf-8?B?WUl6QnZVVDk2TFV1TFlyT1NVYzROOVZnc1kxdDlqeWg0YVQvaThHZkxIMTU4?=
 =?utf-8?B?MWNiSzJFS2U5ZU82R0dSWStLUXMvWVFmSjg0ekRHNTV1L2FWU01zaHVmVzNW?=
 =?utf-8?B?ZnBobzI4cnl6cnpuTlVmV2dnWnNrNEl3UTNOYk1Ldzg1R1hCMXBwM3NLNmdO?=
 =?utf-8?B?RERjNlYxSGxZMXpZRlg2ZmJ6b0FTUnVRdG05MENxa3FUTVBLK1RmZ1E0K3FF?=
 =?utf-8?B?cnhpVS93UDl5SWtLa0w2VzFVVHV3QURpdGlpTURrZWtZbDQwckcvYitkd2NF?=
 =?utf-8?B?c2hSRFNmWmxpNEZiK2Z1b3FwajFMZ3N2WVpXSUJRcG84bU15L3Jrc1NvbDE2?=
 =?utf-8?B?MzRGS2Z0YXU1T1krZTl6SXQwSW4wMnNFS1JsUU5QcW9zdVVUcFZ3bFZSSzk2?=
 =?utf-8?B?eVc5dys0WmJFa2NOZHFtMUFHcy9qa3kyVk1lVnJBVWZoVG5XaTBQMnhJaDFK?=
 =?utf-8?B?bXZrL0p5RHpkdnJpMDhHeWZDdjZUdnJvNDFndVlBV3R6c0RmcHFIaGUxa0Fl?=
 =?utf-8?B?blAwSnRnd0pPdkhiWThvRGRsR29tcE0zTCtFVnowajZKUzRySk5ueTBBd1VY?=
 =?utf-8?B?a2RTcDBrZ2VMNjZkeFpwV2NRMEJhY0xBc1IrVHU2dXM5ZW1JWmdvUlFRVGNP?=
 =?utf-8?B?Y0NKZ0NRTGJBZmxFc2VHSDM3VmZFeUxabkNzQUtwYmxDUzVWUHliRVNCdVJI?=
 =?utf-8?B?SlFtb3l0YlBtQVRJZ3ZDVG5IaS9WRlpxa3gvV2N2SWt2UjFsWTR1bjFUL1l5?=
 =?utf-8?B?WGNjQUFKZ0xvMWw0VHZjQkpheWlLbENFSFVrdnpIbkpvdEtnOS8rZGU1eDdM?=
 =?utf-8?B?MG9OLzBiT05wV0NDdmdKM1I3TEd5K2dVeFloaDI3MER2ZkVGaXJzOEhOTU9a?=
 =?utf-8?B?THNKZWhmQmQ5NXd0Zk9heDhXVzV1T2RYN1pQYlU5anRWcWc2eU8rVkdRZWpH?=
 =?utf-8?B?RUY2L0NEa0tFcHJJbnVNQWNXczQrOWxHNXc4UHRXTWdwY29CRGxwN1RiVVpR?=
 =?utf-8?B?WE12aldUZVh4ZlR3bG5hZU1QNnA0VjhHZVJncURPZHgxalI0TUR1U2xuWVJW?=
 =?utf-8?B?akUxaDcxakdOMTFxb2lJR2hTRWp4WjF6Z1Z5WDVhZUx1VUJzZ0dzQ2VBSmdx?=
 =?utf-8?B?V2FTVDJ6VmlDcnFnUWd1WFlRYjBPTndOaW95Z2trS3Q1VFk1MTB2UmgzYWJl?=
 =?utf-8?B?emc1VHUyTnI5UHJadXZIcW43UTdkKzdLbjh5dFcwNCtVS0hNV0dyRTYxc2kr?=
 =?utf-8?Q?rjgsyyaHC/ahfkFtz+12MGnv8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45b5cd3-8a3f-4db6-43dc-08dd75a94a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 07:53:30.8343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ASM8I4NHIRC+ad3++TWDg/EEohHr3xriTYvidguD7zGwYeEp1mlytM3WhOqm5q7D3y/piwJZxcHyCvxUMi8+TRFHBKgMbzASF/2vMcqzus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD3EB37DFC
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIGZvci0xMC4xIHYyIDExLzM3
XSB2ZmlvOiBJbnRyb2R1Y2UgbmV3IGZpbGVzIGZvciBWRklPUmVnaW9uDQo+ZGVmaW5pdGlvbnMg
YW5kIGRlY2xhcmF0aW9ucw0KPg0KPk9uIDMvMjcvMjUgMTA6MzcsIER1YW4sIFpoZW56aG9uZyB3
cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFtQQVRDSCBm
b3ItMTAuMSB2MiAxMS8zN10gdmZpbzogSW50cm9kdWNlIG5ldyBmaWxlcyBmb3IgVkZJT1JlZ2lv
bg0KPj4+IGRlZmluaXRpb25zIGFuZCBkZWNsYXJhdGlvbnMNCi4uLg0KPjNmMDAyMjUyYWNmYjdh
YzgwOTEwN2M5OWJkYmRiYWY2NmQ1NmE1MGQuLjQ1OTFlYzY4ZGE4NzdiMzA3ZjQzZWExYTgzDQo+
Pj4gMGMzMTU3MjFiNTdlOWUgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmZpby9wY2ktcXVpcmtzLmMN
Cj4+PiArKysgYi9ody92ZmlvL3BjaS1xdWlya3MuYw0KPj4+IEBAIC0yNiw2ICsyNiw3IEBADQo+
Pj4gI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIg0KPj4+ICNpbmNsdWRlICJwY2kuaCIN
Cj4+PiAjaW5jbHVkZSAicGNpLXF1aXJrcy5oIg0KPj4+ICsjaW5jbHVkZSAiaHcvdmZpby92Zmlv
LXJlZ2lvbi5oIg0KPj4NCj4+IFRoaXMgbG9va3MgdW5uZWNlc3NhcnkgYXMgcGNpLmggYWxyZWFk
eSBpbmNsdWRlIGl0LA0KPg0KPkl0IGRvZXNuJ3QgYnV0IGl0IHNob3VsZC4gSSB3aWxsIGluY2x1
ZGUgImh3L3ZmaW8vdmZpby1yZWdpb24uaCINCj5pbiAicGNpLmgiIGFuZCByZW1vdmUgaXQgZnJv
bSAgInBjaS1xdWlya3MuYyIgYW5kICJwY2kuYyIgaW5zdGVhZC4NCg0KaHcvdmZpby9wY2kuaCBp
bmNsdWRlcyBody92ZmlvL3ZmaW8tZGlzcGxheS5oIHdoaWNoIGZ1cnRoZXIgaW5jbHVkZXMgaW5j
bHVkZS9ody92ZmlvL3ZmaW8tcmVnaW9uLmgsIGJ1aWxkIHBhc3MgaWYgb25seSByZW1vdmUgI2lu
Y2x1ZGUgb24gbXkgZW52Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

