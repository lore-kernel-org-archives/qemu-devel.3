Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A41EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKuo-0008LE-0r; Mon, 03 Jun 2024 23:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKum-0008L0-Jn
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:32:48 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKuj-00063E-NU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717471965; x=1749007965;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2xOGNR/7QWhipeOezWLS9zMeywNcFZb8gvfup0/DoXU=;
 b=aWRKstFdwOCZXRjiG21P2ddc60GIGnROEa9BXScpEMe/q9RiFriZ/iAE
 woAJ3NBwEjueWAPABmTSD3ldZwgWBDbI54fzML9JUcSeOo4f3fdPrBW7P
 bgny5WIu6flyrusDNk+GxpzxJ6u1rM4BnKHs32RsKMMhZ4ysePi7qQRsH
 rp58cO/hTBD+yr3tH7/8+RszvLTg/dFJlz5x06n1sirUfM5bwSlkrbvBF
 HGSsWw1LF6l0y15+Be+qNSNUvKhYXyqgYoWaAcjeLiEhk7XrGJqmKdX3H
 eU1GxuMj1OXVGzsg00MIaSfcSX9juVqziIoA/2iVhIlnnpmXhNLKn4G9Z Q==;
X-CSE-ConnectionGUID: HjHGeBsgQ52pVwyXDG6mlw==
X-CSE-MsgGUID: W30XezR0Tfe3taBi1jgfxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13939703"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13939703"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:32:43 -0700
X-CSE-ConnectionGUID: Ks3BFCr3QFiTzXqrgs64RQ==
X-CSE-MsgGUID: oPTzeVC4TaqxUXYYQoIAuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="60263279"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:32:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:32:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:32:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG5MpZFRpmoIOmWaViv7LV+MgwWJn8ICDyFkXWUaG7zgftTc31z4W5zrfwvpAg1thiTX3f8Hn3kp+VuOPyWsEY1fTWltoMfSAVF5TEOMfaNruIYth5EVTKmX6BIsdr29q0SnINqJX2Mvp3eKCV+H47YrgD1V7ehIRWvwtiG2DCxiXYaALYUti38eVr78TCwPisP8IoBWmcmi8tDhjl+9J+ddmAR15hfxYEfEgdTnBddbh3tdb4OwzkKU35hA/YUbF/9vb9tdx+DE9psdEzZZmN1bMMISyh3OscVUkH4lY4jmK698Anl+gN+JY4/PWJ5hT1Os0HBtkM6rlbO1TNop9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xOGNR/7QWhipeOezWLS9zMeywNcFZb8gvfup0/DoXU=;
 b=boR+S7e9Bqkq+On9AZrXdkkEqRsS1KkokkvEy0Q0J3DXRTtOXDh4OTDyq+W4GbBGdZ8o41nEaIvKpGALDgN0A9cAxKKDmB9GW91CcjQNXPAzn82E9m99eYkSMlZ5i6rSwiAPQ0l+/VeSHzcPK+nJYhJxSMKTMLzKX9uMx86Yrk8HHPOLKu+IVJR5kbIPqGeuKGZxJGNmX3JiAPi1rN10fDWYIdMLpNLP4NnpqGH78m/CApv6yqZvDitOBUL0NQms+FN1pudK79V3gB06lt8FjWLVcIVx96BQcta4YSwt/MO1LZ17BgTbExCkluxbJd3YFfo+8+wKreRQ+DTAN0CqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 03:32:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:32:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Topic: [PATCH v6 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Index: AQHatX0gFH1W22uwf0CfTk7EhCniS7G1/DmAgAD4QuA=
Date: Tue, 4 Jun 2024 03:32:38 +0000
Message-ID: <SJ0PR11MB67445DD53EC467A1143B1C4392F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <b2540fc5-482e-4dd0-bca9-60fa1d78d6a6@redhat.com>
In-Reply-To: <b2540fc5-482e-4dd0-bca9-60fa1d78d6a6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7145:EE_
x-ms-office365-filtering-correlation-id: ae2dbf73-c0e0-4857-e92f-08dc8446fbe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?QWVhS0tqb2tOMDAvMGFJRFFBTTdGQ3NVZEp4czRHRmRqNW1BNE44bk4yRlI1?=
 =?utf-8?B?NkVPT0RWYWcxWldLdzN6L0RFVkFPMmk0dFBiUE9vRHplWmIvVkdLZHhzak0x?=
 =?utf-8?B?YzdjeXVTRkp1TWh5cTAwTmZWNzlYbUpXRTEyY1ZXdHFNNEVrZkdvQk03Z0tE?=
 =?utf-8?B?U1Q2MnpoOGJVOW5ZVnlXdEtMRDg0a3h0N0Jxd2sxczkxRUgxemN5MHNESm9t?=
 =?utf-8?B?b1VyRnlPU1hGWit2ZlpkNytJbzRhYTRPRWtXcUtSN0VaSlRXdmZBNVR0YVRr?=
 =?utf-8?B?WGs5YllxbE5TVmhPQ0dPWkFjUW9pdThlelhlOHZzeWZEMjNtSFRRaURBTXAx?=
 =?utf-8?B?N3V4aWxMSEtuSmdoL2dLMCtsRG9xQjV2MjR5R0F3ZGQ0c20yVHVWMnhydFBn?=
 =?utf-8?B?T1BlRktKVlpTeEhjdWw4WHFCcUx6cHUwbGxUMHFoMTh3bHk5MVB2WGhHN1dO?=
 =?utf-8?B?eGVuQndHSm1rTDFhZEdEWTVsbVJOcUhBcWVZSXpkbC9xMHljYzRYUFZHTzNo?=
 =?utf-8?B?OE5JUVMzREhqQUcyV0JvVDEyT2x2aFI4YmtIV09neHJvOWVxRUhOU3VwY1pW?=
 =?utf-8?B?bGE2R0l4bkQzUVNKN3p5YmtMTU0vaUJ4dExjdmhOcVd2Y2J3OVJjVzdSVFlx?=
 =?utf-8?B?K1FuSkw0TjdTSXc5MElUa3BuV0Z6MDY2dHhpM3ZFc3Z2K1N2d3A4S1NOckQ3?=
 =?utf-8?B?LzZXR0FudFZhTTBvZlZ6MWo0d1BSVGlTSEJ1Vzh5MXhiOW9rTXQ4TE1aMEl5?=
 =?utf-8?B?TFhDVUxnamo2eUJOcWRQZG8zUk8yOVFQSzM1TlVjalNBVGduZ3dZUEYwNDVL?=
 =?utf-8?B?WHdaNTFwNE1ucWZ6VkdJanEreUl0RFF3N0szOGVmTGZ1Vnl5TVBTTFVmcm51?=
 =?utf-8?B?MmdPUmxFU2ovMlB6eFBQc0d1K1g0TEtpNXlDcVdjRE1LQ0J4VE9WazVnYlZp?=
 =?utf-8?B?dFFQOUZYWVFKSXhsK1VBa1lieDZkNmhvWEFpTTZHWjdLNTdnVG5FRS9xSmdo?=
 =?utf-8?B?cEN1SElEUW5WTEUxbmh0NXczcXpaTjdROVl4dm01aXhqYzMrTXNRcUkyU0k0?=
 =?utf-8?B?RklubGZvdmFrNnZ5UERqRk9tb0NnOHpDbm81QjdPczNtWVlYNGpkd3NtMnpI?=
 =?utf-8?B?WUMvUDVyMW9hV3dtKyszK3RiMzg1Q3JSamFzc1FGNlhBbVU0RG9LQUxBWFV2?=
 =?utf-8?B?eFRLREhBMHlRa0pGbWhFUFI1cUo4bmttNmFXZXFuT1JJUFBrMjgvQnhzcG1T?=
 =?utf-8?B?QnhlYnRNbHpuY1BKajd6aUZyMjBjdFNsVHR6dnZKeGxaUk9lSXV3NlA5QkRO?=
 =?utf-8?B?Qk4xbEh3ZGdCSjU1SWpBMkFQZ0k4SmVBTGlpTURtQ0w4dVlEUkdiYUlyYnlu?=
 =?utf-8?B?S2c1NFZzMFdocmJYMHNUMFVNMWpORlRIVkQ5amREYzRCdFdKYXM2emRMcWx5?=
 =?utf-8?B?MUY5ZHI4ZVVIdnpVb2dET014WTN0cm5saWJjL1NIZTZRbzBzaWpvUzM2Z28v?=
 =?utf-8?B?aW1qMEF6ckEyVk9zRTlUSFEvbFdvd1gycFVpQWQyaXQ1N1ZxYittbzRtNXN0?=
 =?utf-8?B?SjlJREpDUUhhQmEwbUt5SGpraE5lV0NNekpFSWNIUUNzSUdBS3JZcWxhRlE3?=
 =?utf-8?B?dDlYR1d5T093QTRWSDhrYzVNM2hMUlJTeHhLM3lrYTUvUkhqT3RMRDhmTy9K?=
 =?utf-8?B?N3pJOWdWeDluU0swTW94eEpDQ0lzYUxBTFZWbnZ5eC9CSFZYSTVJYmpRN1M0?=
 =?utf-8?Q?u4cnFhzfWk+3n/mxHQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXVMSUtRZHpUMmo0VkEvaWhKVUxPZGlmcHRWSHNmcHRQTkhzN2VBYStoSUpF?=
 =?utf-8?B?bCtmaGxJczdPb0R2Uk1HTkVKN1JTVEt1TEpDaTRUM0VrdllFeGptREZ2VVRt?=
 =?utf-8?B?TWhQbVlTVUhDUGNrbzNUMXU1VmtHd21pdU1vYmp3WCtZODExV1VTeTB0NHli?=
 =?utf-8?B?RzRmWXNDS2Z4UXZ0ZzZVM3ltNSt1RnIxN214KzFqNS9VdDE0MFR4TXQ0eEk1?=
 =?utf-8?B?QVlacmpSTDhFZENLS0hTbFdGYzRwQlNCeVgzeGJaelFtTGE1TTJSdy9XZ3Q2?=
 =?utf-8?B?akVocG5QVG8vNGx4UDh2RE90REk5VUo0UDV4OTJyNEp2SzhDVEpXUTdzemFU?=
 =?utf-8?B?eWZDZmRmcGwzNmxOcXNBZDBjVkNybGZyNFdkeWl2Q3hnYjRRcU1xQVNJVzYz?=
 =?utf-8?B?cjlYU2xSTEJZRjZramp3OTlmQnNueVBMU3lHenNsai94VXR1TlB3Rml2RkJT?=
 =?utf-8?B?N0dva3p0SEV2NXkvWGtlSXlZSGoyR2t0eS9IaGU2a2tVRGIreXo2SzYxWEVq?=
 =?utf-8?B?K2ZRVEswOFVVL0dGUTAzSFY3Ulh5WFBrUlNnVVhKenA3T1lqOS9EZ0lqZmlV?=
 =?utf-8?B?OTgwMURVUUYzRUp6YWUxc3Jra1VkMThPUlJmbWdmVmtlYWtEMnczMitxYTY4?=
 =?utf-8?B?Sitpem43M0N1bnBnNkpWMkVWL0UxaEJETVR3OHN0YUdWMU90Z1ZKMXZoc1lk?=
 =?utf-8?B?Rkwra0hhUmRUd3JkeWkyRmhDQUc3YklFdHRFT3JzWDRPaGdYeGh6aWhNYXM3?=
 =?utf-8?B?YXJXZ1E3aWRNaWIwd2VNSXR3T1FXSnpBZzR6eG5jdmtKcWpxNStHcThjcWNn?=
 =?utf-8?B?Mkw3UzJ2Y0NpUyttNUN2dlNDdm9SWENJOEhjNTI5bHFhN3YwZlhjaFlCMXhC?=
 =?utf-8?B?d25qTTg1STY5TUl1VitmUGdFY0EyeEFUS2dnVGNMTkp6MmM0eDRLcFRGMFB6?=
 =?utf-8?B?M3F1VEh0WGlVdlJlbEttdy9VMklMUWkwOENFQ3NSQjh2OHJvcDQ5SUtEeFdX?=
 =?utf-8?B?Vm9BVUVmbUV6cit0cm5zRGxyNldXUWY0M2tLOURSOVJ2RWxSWFNSN3gyN3U1?=
 =?utf-8?B?d0E4Mm41ZWRWUDF4SDNjdkZ5UG1lNXg5UFp2RUwyaTd5QlRkL3pTSUhlbE5K?=
 =?utf-8?B?THladXN4UUV1SGZrOUszTEh3cGh5OUI1clBvRnl4YnFrdzYxTEF4Y09zMUli?=
 =?utf-8?B?VVh0OEJBanFnZ2dNamRTZkwrUk5FbXhlODRVenF5R1A1Mlg1NmtoL0FNZFFG?=
 =?utf-8?B?VDJwYzh4WE03UTN3U2tCc3NKVGVVWWJUOFZBbTdSTy9RdnJHRE1zZDlnVGJz?=
 =?utf-8?B?WTBTUG0zNFlseDFQM3JONTJrZkdGdndpSkVvWjBWVlB2eW5HVnRVNWkwdUQy?=
 =?utf-8?B?emJjcG5DcU9FWlFaa2R6THBxd2JaVCsxQlVmNTlhV1V6YjBuUmc5Sm5GNTFW?=
 =?utf-8?B?bUpucVlWSnNLMDE0dGlueklLNXR5TWZ2TzFYVUZjNHh4dU5pZ3F2SUxmY2Nk?=
 =?utf-8?B?R2ZvUmYzeFZPSXNjMFppUFkrNlhIQlVjME5PR0NHR1hxWk9QRWJjbGVsV3lD?=
 =?utf-8?B?WFlXRkc1SU1heUtYSitQelY1alM0NWd1NGVYTml1YXgvSi9kam0xc3Z0d1VL?=
 =?utf-8?B?UUF6ZVdUK1lTNU1TaWlSUzZ2aFQrbXB6bXhhWWJ0MUhBSDR0YWlhVTJYa01L?=
 =?utf-8?B?QktvUlMySTY2T0pldW9lL2owRnpNVVBlU0lVNDYzd205TC9UZ1Q2NUI4dTJX?=
 =?utf-8?B?SERDQi9VeW96WE9QUWhPSjZkTTZxaWFKeHNOVllETG1QN3hpNlc1cnp2T0pm?=
 =?utf-8?B?TFRSZDlXS0NjMHJqYVZOWmVhS2hweXB2VW5hdzZFelgySWFodzFJRk5KRE95?=
 =?utf-8?B?Mzl6aFdjMUhORzBRS1IwTmV4TXJuM0ovWnVmWmRNRUYzWTVUNFVmVEo4TVNJ?=
 =?utf-8?B?R1lnQnBoNVNrZms0WFBWcENyUzhmRnREazVraDRIclhKK3VKazVHRHpCMUhP?=
 =?utf-8?B?cHdFZmRWOUZKaXJ4cGRDajdvOFUvV1JkeUxyOXloV0tBb04vNlZEUW52R0tZ?=
 =?utf-8?B?QnR5ZFN3ZDkrNGEyWVlyMndrSThVdlcyT1Yyb0d4Y0JwTzFkaWZzZkNqdUIv?=
 =?utf-8?Q?Dd3iwnVuaWYDvy37wWTBsDrsr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2dbf73-c0e0-4857-e92f-08dc8446fbe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:32:38.8248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKlocAAI4mmpOMRvJMUMX6IIqo/k2mwUg3UFiuDgNuyZsubugfStiTeAbSFgNZg0/1hZiUaq9UiNUOvaIhYLSTrlC3RKisTDAnhSjUSyUoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDAwLzE5XSBBZGQgYSBo
b3N0IElPTU1VIGRldmljZSBhYnN0cmFjdGlvbiB0bw0KPmNoZWNrIHdpdGggdklPTU1VDQo+DQo+
SGkgWmhlbnpob25nLA0KPg0KPk9uIDYvMy8yNCAwODoxMCwgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+PiBIaSwNCj4+DQo+PiBUaGlzIHNlcmllcyBpbnRyb2R1Y2UgYSBIb3N0SU9NTVVEZXZpY2Ug
YWJzdHJhY3Rpb24gYW5kIHN1Yi1jbGFzc2VzLg0KPj4gQWxzbyBIb3N0SU9NTVVEZXZpY2VDYXBz
IHN0cnVjdHVyZSBpbiBIb3N0SU9NTVVEZXZpY2UgYW5kIGEgbmV3DQo+aW50ZXJmYWNlDQo+PiBi
ZXR3ZWVuIHZJT01NVSBhbmQgSG9zdElPTU1VRGV2aWNlLg0KPg0KPkkgdGhpbmsgd2Ugc2hvdWxk
IGhhdmUgYSB0ZXh0dWFsIGRlc2NyaXB0aW9uIG9mIHdoYXQgaXMgYQ0KPkhvc3RJT01NVURldmlj
ZS4gQmVjYXVzZSB0byBtZSB0aGUgdGVybWlub2xvZ3kgbWF5IGJlIGNvbmZ1c2luZyBhcyB0aGUN
Cj5yZWFkZXIgY2FuIHVuZGVyc3RhbmQgdGhpcyBpcyBhbiBhYnN0cmFjdGlvbiBmb3IgdGhlIHBo
eXNpY2FsIElPTU1VLg0KPg0KPldvdWxkIGl0IGJlIGNvcnJlY3QgdG8gc2F5Og0KPg0KPkEgSG9z
dElPTU1VRGV2aWNlIGlzIGFuIGFic3RyYWN0aW9uIGZvciBhbiBhc3NpZ25lZCBkZXZpY2UgdGhh
dCBpcw0KPnByb3RlY3RlZCBieSBhIHBoeXNpY2FsIElPTU1VIChha2EgaG9zdCBJT01NVSkuIFRo
ZSB1c2Vyc3BhY2UNCj5pbnRlcmFjdGlvbiB3aXRoIHRoaXMgcGh5c2ljYWwgSU9NTVUgY2FuIGJl
IGRvbmUgZWl0aGVyIHRocm91Z2ggdGhlIFZGSU8NCj5JT01NVSB0eXBlIDEgbGVnYWN5IGJhY2tl
bmQgb3IgdGhlIG5ldyBpb21tdWZkIGJhY2tlbmQuIFRoZSBhc3NpZ25lZA0KPmRldmljZSBjYW4g
YmUgYSBWRklPIGRldmljZSBvciBhIFZEUEEgZGV2aWNlLiBUaGUgSG9zdElPTU1VRGV2aWNlIGlz
DQo+bmVlZGVkIHRvIGludGVyYWN0IHdpdGggdGhlIGhvc3QgSU9NTVUgdGhhdCBwcm90ZWN0cyB0
aGUgYXNzaWduZWQNCj5kZXZpY2UuIEl0IGlzIGVzcGVjaWFsbHkgdXNlZnVsIHdoZW4gdGhlIGRl
dmljZSBpcyBhbHNvIHByb3RlY3RlZCBieSBhDQo+dmlydHVhbCBJT01NVSBhcyB0aGlzIGxhdHRl
ciB1c2UgdGhlIHRyYW5zbGF0aW9uIHNlcnZpY2VzIG9mIHRoZQ0KPnBoeXNpY2FsIElPTU1VIGFu
ZCBpcyBjb25zdHJhYWluZWQgYnkgaXQuIEluIHRoYXQgY29udGV4dCB0aGUNCj5Ib3N0SU9NTVVE
ZXZpY2UgY2FuIGJlIHBhc3NlZCB0byB0aGUgdmlydHVhbCBJT01NVSB0byBjb2xsZWN0IHBoeXNp
Y2FsDQo+SU9NTVUgY2FwYWJpbGl0aWVzIHN1Y2ggYXMgdGhlIHN1cHBvcnRlZCBhZGRyZXNzIHdp
ZHRoLiBJbiB0aGUgZnV0dXJlLA0KPnRoZSB2aXJ0dWFsIElPTU1VIHdpbGwgdXNlIHRoZSBIb3N0
SU9NTVVEZXZpY2UgdG8gcHJvZ3JhbSB0aGUgZ3Vlc3QNCj5wYWdlDQo+dGFibGVzIGluIHRoZSBm
aXJzdCB0cmFuc2xhdGlvbiBzdGFnZSBvZiB0aGUgcGh5c2ljYWwgSU9NTVUuDQoNCkdyZWF0LCB0
aGFua3MgRXJpYy4NCg0KPg0KPklmIHN1Y2gga2luZCBvZiBkZXNjcmlwdGlvbiBpcyBjb3JyZWN0
LCBJIHdvdWxkIGFsc28gc3VnZ2VzdCB0byBlbWJlZCBpdA0KPmluIHRoZSBwYXRjaCAxIGNvbW1p
dCBtc2cuDQoNClN1cmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5UaGFua3MNCj4NCj5F
cmljDQo+DQo+DQo+Pg0KPj4gSG9zdElPTU1VRGV2aWNlQ2xhc3M6OnJlYWxpemUoKSBpcyBpbnRy
b2R1Y2VkIHRvIGluaXRpYWxpemUNCj4+IEhvc3RJT01NVURldmljZUNhcHMgYW5kIG90aGVyIGZp
ZWxkcyBvZiBIb3N0SU9NTVVEZXZpY2UgdmFyaWFudHMuDQo+Pg0KPj4gSG9zdElPTU1VRGV2aWNl
Q2xhc3M6OmdldF9jYXAoKSBpcyBpbnRyb2R1Y2VkIHRvIHF1ZXJ5IGhvc3QgSU9NTVUNCj4+IGRl
dmljZSBjYXBhYmlsaXRpZXMuDQo+Pg0KPj4gVGhlIGNsYXNzIHRyZWUgaXMgYXMgYmVsb3c6DQo+
Pg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAuY2Fwcw0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgLnJlYWxpemUoKQ0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgLmdldF9jYXAoKQ0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgIC4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIHwNCj4+IEhvc3RJT01NVURl
dmljZUxlZ2FjeVZGSU8gIHtIb3N0SU9NTVVEZXZpY2VMZWdhY3lWRFBBfQ0KPkhvc3RJT01NVURl
dmljZUlPTU1VRkQNCj4+ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgIHwgWy5pb21tdWZkXQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBbLmRldmlkXQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCBbLmlvYXNfaWRdDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IFsuYXR0YWNoX2h3cHQoKV0NCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgWy5kZXRhY2hf
aHdwdCgpXQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICB8DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlSU9NTVVGRFZGSU8NCj57SG9zdElP
TU1VRGV2aWNlSU9NTVVGRFZEUEF9DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IFsudmRldl0gICAgICAgICAgICAgICAgfCB7LnZkZXZ9DQo+Pg0KPj4gKiBU
aGUgYXR0cmlidXRlcyBpbiBbXSB3aWxsIGJlIGltcGxlbWVudGVkIGluIG5lc3Rpbmcgc2VyaWVz
Lg0KPj4gKiBUaGUgY2xhc3NlcyBpbiB7fSB3aWxsIGJlIGltcGxlbWVudGVkIGluIGZ1dHVyZS4N
Cj4+ICogLnZkZXYgaW4gZGlmZmVyZW50IGNsYXNzIHBvaW50cyB0byBkaWZmZXJlbnQgYWdlbnQg
ZGV2aWNlLA0KPj4gKiBpLmUuLCBmb3IgVkZJTyBpdCBwb2ludHMgdG8gVkZJT0RldmljZS4NCj4+
DQo+PiBQQVRDSDEtNDogSW50cm9kdWNlIEhvc3RJT01NVURldmljZSBhbmQgaXRzIHN1YiBjbGFz
c2VzDQo+PiBQQVRDSDUtMTE6IEludHJvZHVjZSBIb3N0SU9NTVVEZXZpY2VDYXBzLCBpbXBsZW1l
bnQgLnJlYWxpemUoKQ0KPmFuZCAuZ2V0X2NhcCgpIGhhbmRsZXINCj4+IFBBVENIMTItMTY6IENy
ZWF0ZSBIb3N0SU9NTVVEZXZpY2UgaW5zdGFuY2UgYW5kIHBhc3MgdG8gdklPTU1VDQo+PiBQQVRD
SDE3LTE5OiBJbXBsZW1lbnQgY29tcGF0aWJpbGl0eSBjaGVjayBiZXR3ZWVuIGhvc3QgSU9NTVUg
YW5kDQo+dklPTU1VKGludGVsX2lvbW11KQ0KPj4NCj4+IFRlc3QgZG9uZToNCj4+IG1ha2UgY2hl
Y2sNCj4+IHZmaW8gZGV2aWNlIGhvdHBsdWcvdW5wbHVnIHdpdGggZGlmZmVyZW50IGJhY2tlbmQg
b24gbGludXgNCj4+IHJlYm9vdA0KPj4gYnVpbGQgdGVzdCBvbiBsaW51eCBhbmQgd2luZG93czEx
DQo+Pg0KPj4gUWVtdSBjb2RlIGNhbiBiZSBmb3VuZCBhdDoNCj4+DQo+aHR0cHM6Ly9naXRodWIu
Y29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfbmVzdGluZ19wcmUNCj5x
X3Y2DQo+Pg0KPj4gQmVzaWRlcyB0aGUgY29tcGF0aWJpbGl0eSBjaGVjayBpbiB0aGlzIHNlcmll
cywgaW4gbmVzdGluZyBzZXJpZXMsIHRoaXMNCj4+IGhvc3QgSU9NTVUgZGV2aWNlIGlzIGV4dGVu
ZGVkIGZvciBtdWNoIHdpZGVyIHVzYWdlLiBGb3IgYW55b25lDQo+aW50ZXJlc3RlZA0KPj4gb24g
dGhlIG5lc3Rpbmcgc2VyaWVzLCBoZXJlIGlzIHRoZSBsaW5rOg0KPj4NCj5odHRwczovL2dpdGh1
Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS96aGVuemhvbmcvaW9tbXVmZF9uZXN0aW5nX3JmYw0K
PnYyDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVuemhvbmcNCj4+DQo+PiBDaGFuZ2Vsb2c6DQo+PiB2
NjoNCj4+IC0gT3BlbiBjb2RlZCBob3N0X2lvbW11X2RldmljZV9nZXRfY2FwKCkgdG8gYXZvaWQg
I2lmZGVmIGluDQo+aW50ZWxfaW9tbXUuYyAoQ8OpZHJpYykNCj4+DQo+PiB2NToNCj4+IC0gcGNp
X2RldmljZV9zZXRfaW9tbXVfZGV2aWNlIHJldHVybiB0cnVlIChDw6lkcmljKQ0KPj4gLSBmaXgg
YnVpbGQgZmFpbHVyZSBvbiB3aW5kb3dzICh0aGFua3MgQ8OpZHJpYyBmb3VuZCB0aGF0IGlzc3Vl
KQ0KPj4NCj4+IHY0Og0KPj4gLSBtb3ZlIHByb3BlcnRpZXMgdmRldiwgaW9tbXVmZCBhbmQgZGV2
aWQgdG8gbmVzdGluZyBzZXJpZXMgd2hlcmUgbmVlZCBpdA0KPihDw6lkcmljKQ0KPj4gLSBmaXgg
MzJiaXQgYnVpbGQgd2l0aCBjbHo2NCAoQ8OpZHJpYykNCj4+IC0gY2hhbmdlIGNoZWNrX2NhcCBu
YW1pbmcgdG8gZ2V0X2NhcCAoQ8OpZHJpYykNCj4+IC0gcmV0dXJuIGJvb2wgaWYgZXJyb3IgaXMg
cGFzc2VkIHRocm91Z2ggZXJycCAoQ8OpZHJpYykNCj4+IC0gZHJvcCBIb3N0SU9NTVVEZXZpY2Vb
TGVnYWN5VkZJT3xJT01NVUZEfElPTU1VRkRWRklPXQ0KPmRlY2xhcmF0aW9uIChDw6lkcmljKQ0K
Pj4gLSBkcm9wIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9JT01NVUZEIChDw6lkcmljKQ0KPj4gLSBy
ZXBsYWNlIGluY2x1ZGUgZGlyZWN0aXZlIHdpdGggZm9yd2FyZCBkZWNsYXJhdGlvbiAoQ8OpZHJp
YykNCj4+DQo+PiB2MzoNCj4+IC0gcmVmaW5lIGRlY2xhcmF0aW9uIGFuZCBkb2MgZm9yIEhvc3RJ
T01NVURldmljZSAoQ8OpZHJpYywgUGhpbGlwcGUpDQo+PiAtIGludHJvZHVjZSBIb3N0SU9NTVVE
ZXZpY2VDYXBzLCAucmVhbGl6ZSgpIGFuZCAuY2hlY2tfY2FwKCkgKEPDqWRyaWMpDQo+PiAtIGlu
dHJvZHVjZSBoZWxwZXIgcmFuZ2VfZ2V0X2xhc3RfYml0KCkgZm9yIHJhbmdlIG9wZXJhdGlvbiAo
Q8OpZHJpYykNCj4+IC0gc2VwYXJhdGUgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKCkg
aW4gYSBwcmVyZXEgcGF0Y2ggKEPDqWRyaWMpDQo+PiAtIHJlcGxhY2UgSElPRF8gYWJicmV2aWF0
aW9uIHdpdGggSE9TVF9JT01NVV9ERVZJQ0VfIChDw6lkcmljKQ0KPj4gLSBhZGQgaGVhZGVyIGlu
IGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaCAoQ8OpZHJpYykNCj4+DQo+PiB2MjoNCj4+IC0gdXNl
IFFPTSB0byBhYnN0cmFjdCBob3N0IElPTU1VIGRldmljZSBhbmQgaXRzIHN1Yi1jbGFzc2VzIChD
w6lkcmljKQ0KPj4gLSBtb3ZlIGhvc3QgSU9NTVUgZGV2aWNlIGNyZWF0aW9uIGluIGF0dGFjaF9k
ZXZpY2UoKSAoQ8OpZHJpYykNCj4+IC0gcmVmaW5lIHBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11
X2RldmljZSBkb2MgZnVydGhlciAoRXJpYykNCj4+IC0gZGVmaW5lIGhvc3QgSU9NTVUgaW5mbyBm
b3JtYXQgb2YgZGlmZmVyZW50IGJhY2tlbmQNCj4+IC0gaW1wbGVtZW50IGdldF9ob3N0X2lvbW11
X2luZm8oKSBmb3IgZGlmZmVyZW50IGJhY2tlbmQgKEPDqWRyaWMpDQo+PiAtIGRyb3AgY2FwL2Vj
YXAgdXBkYXRlIGxvZ2ljIChNU1QpDQo+PiAtIGNoZWNrIGF3LWJpdHMgZnJvbSBnZXRfaG9zdF9p
b21tdV9pbmZvKCkgaW4gbGVnYWN5IG1vZGUNCj4+DQo+PiB2MToNCj4+IC0gdXNlIEhvc3RJT01N
VURldmljZSBoYW5kbGUgaW5zdGVhZCBvZiB1bmlvbiBpbiBWRklPRGV2aWNlIChFcmljKQ0KPj4g
LSBjaGFuZ2UgaG9zdF9pb21tdV9kZXZpY2VfaW5pdCB0byBob3N0X2lvbW11X2RldmljZV9jcmVh
dGUNCj4+IC0gYWxsb2NhdGUgSG9zdElPTU1VRGV2aWNlIGluIGhvc3RfaW9tbXVfZGV2aWNlX2Ny
ZWF0ZSBjYWxsYmFjaw0KPj4gICBhbmQgc2V0IHRoZSBWRklPRGV2aWNlIGJhc2VfaGRldiBoYW5k
bGUgKEVyaWMpDQo+PiAtIHJlZmluZSBwY2lfZGV2aWNlX3NldC91bnNldF9pb21tdV9kZXZpY2Ug
ZG9jIChFcmljKQ0KPj4gLSB1c2UgSG9zdElPTU1VRGV2aWNlIGhhbmRsZSBpbnN0ZWFkIG9mIHVu
aW9uIGluIFZUREhvc3RJT01NVURldmljZQ0KPihFcmljKQ0KPj4gLSBjb252ZXJ0IEhvc3RJT01N
VURldmljZSB0byBzdWIgb2JqZWN0IHBvaW50ZXIgaW4gdnRkX2NoZWNrX2hkZXYNCj4+DQo+PiBy
ZmN2MjoNCj4+IC0gaW50cm9kdWNlIGNvbW1vbiBhYnN0cmFjdCBIb3N0SU9NTVVEZXZpY2UgYW5k
IHN1YiBzdHJ1Y3QgZm9yDQo+ZGlmZmVyZW50IEJFcyAoRXJpYywgQ8OpZHJpYykNCj4+IC0gcmVt
b3ZlIGlvbW11ZmRfZGV2aWNlLltjaF0gKEPDqWRyaWMpDQo+PiAtIHJlbW92ZSBkdXBsaWNhdGUg
aW9tbXVmZC9kZXZpZCBkZWZpbmUgZnJvbSBWRklPRGV2aWNlIChFcmljKQ0KPj4gLSBkcm9wIHRo
ZSBwIGluIGFsaWFzZWRfcGJ1cyBhbmQgYWxpYXNlZF9wZGV2Zm4gKEVyaWMpDQo+PiAtIGFzc2Vy
dCBkZXZmbiBhbmQgaW9tbXVfYnVzIGluIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbg0K
PihDw6lkcmljLCBFcmljKQ0KPj4gLSB1c2UgZXJycCBpbiBpb21tdWZkX2RldmljZV9nZXRfaW5m
byAoRXJpYykNCj4+IC0gc3BsaXQgYW5kIHNpbXBsaWZ5IGNhcC9lY2FwIGNoZWNrL3N5bmMgY29k
ZSBpbiBpbnRlbF9pb21tdS5jIChDw6lkcmljKQ0KPj4gLSBtb3ZlIFZUREhvc3RJT01NVURldmlj
ZSBkZWNsYXJhdGlvbiB0byBpbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+KEPDqWRyaWMpDQo+PiAt
IG1ha2UgJyh2dGQtPmNhcF9yZWcgPj4gMTYpICYgMHgzZlVMTCcgYSBNQUNSTyBhbmQgYWRkIG1p
c3NlZCAnKzEnDQo+KEPDqWRyaWMpDQo+PiAtIGJsb2NrIG1pZ3JhdGlvbiBpZiB2SU9NTVUgY2Fw
L2VjYXAgdXBkYXRlZCBiYXNlZCBvbiBob3N0IElPTU1VDQo+Y2FwL2VjYXANCj4+IC0gYWRkIFIt
Qg0KPj4NCj4+IFlpIExpdSAoMik6DQo+PiAgIGh3L3BjaTogSW50cm9kdWNlIHBjaV9kZXZpY2Vf
W3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkNCj4+ICAgaW50ZWxfaW9tbXU6IEltcGxlbWVudCBb
c2V0fHVuc2V0XV9pb21tdV9kZXZpY2UoKSBjYWxsYmFja3MNCj4+DQo+PiBaaGVuemhvbmcgRHVh
biAoMTcpOg0KPj4gICBiYWNrZW5kczogSW50cm9kdWNlIEhvc3RJT01NVURldmljZSBhYnN0cmFj
dA0KPj4gICB2ZmlvL2NvbnRhaW5lcjogSW50cm9kdWNlIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0Vf
TEVHQUNZX1ZGSU8NCj5kZXZpY2UNCj4+ICAgYmFja2VuZHMvaW9tbXVmZDogSW50cm9kdWNlIGFi
c3RyYWN0DQo+VFlQRV9IT1NUX0lPTU1VX0RFVklDRV9JT01NVUZEDQo+PiAgICAgZGV2aWNlDQo+
PiAgIHZmaW8vaW9tbXVmZDogSW50cm9kdWNlIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVG
RF9WRklPDQo+ZGV2aWNlDQo+PiAgIGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlOiBJbnRyb2R1
Y2UgSG9zdElPTU1VRGV2aWNlQ2Fwcw0KPj4gICByYW5nZTogSW50cm9kdWNlIHJhbmdlX2dldF9s
YXN0X2JpdCgpDQo+PiAgIHZmaW8vY29udGFpbmVyOiBJbXBsZW1lbnQgSG9zdElPTU1VRGV2aWNl
Q2xhc3M6OnJlYWxpemUoKSBoYW5kbGVyDQo+PiAgIGJhY2tlbmRzL2lvbW11ZmQ6IEludHJvZHVj
ZSBoZWxwZXIgZnVuY3Rpb24NCj4+ICAgICBpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZv
KCkNCj4+ICAgdmZpby9pb21tdWZkOiBJbXBsZW1lbnQgSG9zdElPTU1VRGV2aWNlQ2xhc3M6OnJl
YWxpemUoKSBoYW5kbGVyDQo+PiAgIHZmaW8vY29udGFpbmVyOiBJbXBsZW1lbnQgSG9zdElPTU1V
RGV2aWNlQ2xhc3M6OmdldF9jYXAoKSBoYW5kbGVyDQo+PiAgIGJhY2tlbmRzL2lvbW11ZmQ6IElt
cGxlbWVudCBIb3N0SU9NTVVEZXZpY2VDbGFzczo6Z2V0X2NhcCgpDQo+aGFuZGxlcg0KPj4gICB2
ZmlvOiBJbnRyb2R1Y2UgVkZJT0lPTU1VQ2xhc3M6Omhpb2RfdHlwZW5hbWUgYXR0cmlidXRlDQo+
PiAgIHZmaW86IENyZWF0ZSBob3N0IElPTU1VIGRldmljZSBpbnN0YW5jZQ0KPj4gICBody9wY2k6
IEludHJvZHVjZSBoZWxwZXIgZnVuY3Rpb24gcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZu
KCkNCj4+ICAgdmZpby9wY2k6IFBhc3MgSG9zdElPTU1VRGV2aWNlIHRvIHZJT01NVQ0KPj4gICBp
bnRlbF9pb21tdTogRXh0cmFjdCBvdXQgdnRkX2NhcF9pbml0KCkgdG8gaW5pdGlhbGl6ZSBjYXAv
ZWNhcA0KPj4gICBpbnRlbF9pb21tdTogQ2hlY2sgY29tcGF0aWJpbGl0eSB3aXRoIGhvc3QgSU9N
TVUgY2FwYWJpbGl0aWVzDQo+Pg0KPj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDIgKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgICAgICAg
fCAgIDkgKysNCj4+ICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgICAgICAgIHwgICAz
ICsNCj4+ICBpbmNsdWRlL2h3L3BjaS9wY2kuaCAgICAgICAgICAgICAgICAgIHwgIDM4ICsrKyst
DQo+PiAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggICAgICAgICB8ICAgNyArDQo+PiAg
aW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCB8ICAgMyArDQo+PiAgaW5jbHVk
ZS9xZW11L3JhbmdlLmggICAgICAgICAgICAgICAgICB8ICAxMSArKw0KPj4gIGluY2x1ZGUvc3lz
ZW11L2hvc3RfaW9tbXVfZGV2aWNlLmggICAgfCAgODggKysrKysrKysrKysrDQo+PiAgaW5jbHVk
ZS9zeXNlbXUvaW9tbXVmZC5oICAgICAgICAgICAgICB8ICAxOSArKysNCj4+ICBiYWNrZW5kcy9o
b3N0X2lvbW11X2RldmljZS5jICAgICAgICAgIHwgIDMwICsrKysNCj4+ICBiYWNrZW5kcy9pb21t
dWZkLmMgICAgICAgICAgICAgICAgICAgIHwgIDc2ICsrKysrKysrLS0NCj4+ICBody9pMzg2L2lu
dGVsX2lvbW11LmMgICAgICAgICAgICAgICAgIHwgMTk4ICsrKysrKysrKysrKysrKysrKysrLS0t
LS0tDQo+PiAgaHcvcGNpL3BjaS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA3NSArKysr
KysrKystDQo+PiAgaHcvdmZpby9jb21tb24uYyAgICAgICAgICAgICAgICAgICAgICB8ICAxNiAr
Ky0NCj4+ICBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICAgICAgICAgIHwgIDQ4ICsrKysr
Ky0NCj4+ICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAgICAgIHwgIDQ0ICsrKysr
LQ0KPj4gIGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTkgKystDQo+
PiAgYmFja2VuZHMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQo+PiAgYmFj
a2VuZHMvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgMTkgZmlsZXMg
Y2hhbmdlZCwgNjIzIGluc2VydGlvbnMoKyksIDY5IGRlbGV0aW9ucygtKQ0KPj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+DQoNCg==

