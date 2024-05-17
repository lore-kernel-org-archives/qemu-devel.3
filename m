Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188CDC25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7tqk-0000Qx-Gl; Fri, 17 May 2024 05:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7tqh-0000Qe-L5
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:25:59 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7tqe-0000qf-El
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715937956; x=1747473956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dwpqxx4U5cNQMy8/XPgWtS54bAzkD2OvrP3xb9mY0PM=;
 b=HFMBEfDwNFBOFncH4axHsiMkj6Y7WkpbpqCZV53KL/LvHNPb2KRszI94
 +IarnDtmCpKMh/v9qmT+dVwTSDbCP2GBz+nU+xFo8HCqtAEKc1ckbKpqv
 sAu85CMtcOv1ZaPvquGxqDgDYof9+2B7KCq2eME11DfccjS282OVL53kQ
 v3rdVLAMrUsDigSzy8vykclGaSPTo9soLTqTijHOUNq5yxqclHRi2pG8l
 cbQIq++iFxI6wSLTZ7Pt6kDHP+QRYU3mMtUqDAx7fPQIE9Dj4W6E/WIkX
 LAcIAuC/A/IyrvPFtJa5wTyDvgjn0/D/IKFyYZtiZJywWxny1vOVzpcJB A==;
X-CSE-ConnectionGUID: /bl3nBmkSiCQNL1qJmQvjw==
X-CSE-MsgGUID: cueIliblTjKIoPxSpn9Hag==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15053702"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; d="scan'208";a="15053702"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 02:25:52 -0700
X-CSE-ConnectionGUID: 4AZsWTEXQHS+2lQ8JVd6IA==
X-CSE-MsgGUID: M5FLBKtCTSyFax6RLELfGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; d="scan'208";a="36246805"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 May 2024 02:25:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 02:25:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 02:25:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 02:25:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 02:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2aYnHwimJ1MjLJnSIyuWGpj61fHyANnPHTerfgjDilrrD0AsMQV2tcXkBS6i+D2jvtWiWK/Tw3ewpaQ7Mpo+WIl8PxJbTB7cFxP56RqxkJt/ag+m5oQVTjFHK41VexMIEyrc/MKctM94UU3T7bPM3hcTYRL1ENTs/DQwsxEAmy00vbPPnphSw32mjyTnQb2/JRjs8B+LwWaLWn4GOpM+yzFXGwsAB3RKQI64PHnWGeFT4wjc4mfhADr/5e66XDs+YDUKEOh1zjkYdvjjdn8PYY3GiKN6cXEmEIjnJnZRt2346pY9TeM7Gtnf1X8IPKS/svCIOH+N9BXxzkkjZ1JIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwpqxx4U5cNQMy8/XPgWtS54bAzkD2OvrP3xb9mY0PM=;
 b=bsqXq8sjgxt0FbvHKHeV98WYU4xrmS9PxJRuFqhp0+u0llb/isi+WjUEdiWvV8iMAaTvelUcDoKkR7HNGtxR5JzlJ4OPrMsHQ1O3qyosDRSPI1I8ihjN+/KLVCHwFnpORY/uTMcF0hEH6gKJw4D3D76hMaTOIzWeFsJ25zsvG10i7qJiklm9Ki3cJll1dn2YOEMTrIYQWUpIygIbtH2Xn8a31fn7B83tPIgnaIs7nZRSeC1LjlocaM6Mx8EKuR6RmIOfie/rqbV+n55WE0TgSv+FTzmSCiNBaKcLkcMxjXZZArN4BxR28yUBpTr/h8dO5fSIljPLPqW9JrQDGiW3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7928.namprd11.prod.outlook.com (2603:10b6:8:fe::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.30; Fri, 17 May 2024 09:25:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 09:25:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Joao Martins <joao.m.martins@oracle.com>, Eric Auger
 <eric.auger@redhat.com>, "jasonwang@redhat.com" <jasonwang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: RE: [PATCH 00/16] VFIO: misc cleanups part2
Thread-Topic: [PATCH 00/16] VFIO: misc cleanups part2
Thread-Index: AQHapqE2p60OTWt8dkOWUMGGjIYoX7GaFF8AgAESbsA=
Date: Fri, 17 May 2024 09:25:15 +0000
Message-ID: <SJ0PR11MB67445D8FADB5C1AD1C96D26392EE2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <e242532d-01eb-4521-90b9-0b1069b498b5@redhat.com>
In-Reply-To: <e242532d-01eb-4521-90b9-0b1069b498b5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7928:EE_
x-ms-office365-filtering-correlation-id: bed17383-2f2b-49bd-50f8-08dc76534296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SDZkZVVEdUpvVlQwaThkTG0wMERVTDI5eGI2dlhoc3EwOUJKNnArMldmQ01K?=
 =?utf-8?B?TFZOZjNhU1R3Q21GaXVnOVlxV1RFZmh1dUlhYkQ4NVJkK21RRmNIb3h3cUZi?=
 =?utf-8?B?OFRMMEZLYzdTL2JYaktyUXhXTTVSQ2FteUVzcTgrZHFIMXBUalk1L3pRbmJm?=
 =?utf-8?B?ZnVSN1BtdndIZWZVUXpUdXdEU25YTHJSNkd4a0x3ckdGcXQ4TWdjbTZ4L3Jt?=
 =?utf-8?B?dmQ5RHBnUjhKczdzZTRWMGRSekFGQnJyZzEwaVk0eEpKQnEwN1d3cVp3NEVl?=
 =?utf-8?B?M25UZ1RBcTFFNG1pRWJYeW9ja0xGWDJpdjlqNXZacy9jUDYxYzVBckg0emxa?=
 =?utf-8?B?WEdzQVY1TzZGWStFODZqMnZIc0RsUWl4K05xdktYZ0VycXhFQjdNSWhqbHhK?=
 =?utf-8?B?MW4xK0NpMXlDYTU4NUxrRnhWdUk4SmFxUlBxWERsY1ZId0NlK2lXd2dwV0JN?=
 =?utf-8?B?YUFJc2lxVFVoMndBR2xJZUlTMlRBRWUzQWE0MUViSXFtUTR4OFNCRW5naXEx?=
 =?utf-8?B?bi9JK3AvWWtHR0dsbTU1Q1g4Q3dnSCtoaXpEWS9hSWdaUko5aEY3cFdlU0Z3?=
 =?utf-8?B?UWR1RVhzUGZNVFNubEtZaENreTdmWHNKRkloelhScDZ1MkhnWnFPdXZ0WjJu?=
 =?utf-8?B?UmI2ZkI3UXFaUlZ0YTlxb1hqMFJ2eEpVbTc5MU9hbmJaKzErdFlOdjkySXNO?=
 =?utf-8?B?OGtZN3JnemJkRWN4cXpuc3F3SlBtRzdxcXlMUXBFNnNET0Z6Y2tDNitwRDh0?=
 =?utf-8?B?ZTN4Qzl4dmlkUEhvT01NWnVya2EveXNQeFJYVkcxOTBIaXhXKy9GNnRndnpo?=
 =?utf-8?B?aFhZN00zbW9qdEVrM0VGd01vY3pFN0gvY0dxSjljYnFoLzdHN3pZbVFJMnlO?=
 =?utf-8?B?aGREMEt6Ni8wWGYvK0NDcDE3RHkrU0pHV2UyNG5KSlRiQ3ZCamtwOFVnZCta?=
 =?utf-8?B?K2dvZkNmNWMyRWl4Y2lIaUVBN2M4NStIZGNINUwwRHhET3p3d3VHZ3hiMmlp?=
 =?utf-8?B?UlRpWW1CMjhQYjZYSjNpYVl2Mkw4b0dXQko2bG81ZnpqWXRLYW1vRmVJcFh0?=
 =?utf-8?B?UzRKeWdPaFFIODVZS2FSUVBUSU96OUs3bFJLa0dWS2Y1NzVJbjZNVDRHZ0lC?=
 =?utf-8?B?c1pPcmtHc1d1YUpDZTRtSnhBcUFBRkhaUHl6Y0JCYTJpemZ2b2MyQU1MVnM4?=
 =?utf-8?B?SWliemVpSitnaUJQY3RINmNjelNMeUpUMWdvUUVOMytJam4xL1BnQ2hIV3FH?=
 =?utf-8?B?YlhWcTJodWN0NWh5U1BIN2tPRS9PU2dlL2JXZ2tyT01XNFRrZlc2TVIwelZN?=
 =?utf-8?B?dWFLNjdPSE55amJXd0w2S05MTEt4MHhwb0NHL1pNWDNmdlFLcHNZcU9teTVz?=
 =?utf-8?B?MzM3VG5kVmRwUVZEa1ROSjRXM0l6SGZ4dEpsWTB4MFJqNWpaNzdSMXE3MEoy?=
 =?utf-8?B?SEEzVjVCZ3NRVlE4WkNRdXlYOEhyZFVKejZhNTZsL2hVbnc4U0hibEdUY09O?=
 =?utf-8?B?SllmVjNweEdwVHlOanFyMi9ZcEwvSmp0REFFeSt5Y0dsald2SDI1MGliTFYy?=
 =?utf-8?B?Wk5HQlA0aVdKWHB3di9sOTFzUU9yREFIVnBoZWk1clN0aW1NVjRFYVZzQ2xZ?=
 =?utf-8?B?NzRGcHIzaWxIek4rMnJPalUybG8yajQ5Z2ljbTBudEM4MUZGdmdLTWRYTjkv?=
 =?utf-8?B?QVVncHB3VW9tQVU1UWtKTGR1WU0xK25VWkdSODMveitoSkdIUnJSSEVhQjhS?=
 =?utf-8?Q?1Ei9MGEFOUBVuY4lBw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXlYRVlxT05tVW1SeTc1TVB4a3VVQVdvWEliTFVBK1B6ZVdRZ2RiNWRvdUg3?=
 =?utf-8?B?M0kvaFdWNjBWL2w0TU5lcnI2VWkzUVNFYi91NUJzTWJSVlE5cWx4Qk95MUlI?=
 =?utf-8?B?d1FaeDYrVks1UmlTOXJVNHNLR0o1aExhM3Z4d2k0b0E5a0VJTDVSekFBUTZX?=
 =?utf-8?B?ZEgxRDdtR283bUZLZWE5U3k5aEw1TVdWcUJ6cytZUzdtVDRIbWVQR3NZbjJu?=
 =?utf-8?B?aEFSbks4TFhvOE1Gd1hFbUxrU3YwOTEvQmQyU0JpUkNTNzFOMVBPKzd0OGd3?=
 =?utf-8?B?aWtLUTNVWE1DbVFPMjBmRzl2NVdwc0VSSHVjeXRqYVovczdSZE50dU5jczJq?=
 =?utf-8?B?TW5oekExempqTmIyQVB4OFZWOFdUQks4K2ZSYnNwMFpJU2c0SWJjMEU1eUZl?=
 =?utf-8?B?eUh3SFFaM0Z3MElZSDlaOW1PeC84OE1jdzJWTVJYeVNhcFVMTXFybUc1a1Fq?=
 =?utf-8?B?SlEzcTREbldLMklRa2NtR08wT3ZVYVVXQ1B1ODhIZzRhKzhZZUw4VzBnMkxL?=
 =?utf-8?B?a0ExbEZYdjM2dmw5RlVwaEdUL3BaTGtRZWdiajQ5eDIrRXl0MXE4Y1ZMVmE0?=
 =?utf-8?B?RUFDenVEN080dmhHaDlXWlVBa0dkUFRHUE0xaEFVTStuM2J1QXF1VDA2bE5L?=
 =?utf-8?B?VGVqSy81SmQzdFYzTEdsQ1dkYjFIUHBvNnNNNmFmYlJqR2IxK0lqaHRvMEZO?=
 =?utf-8?B?a0w2aTBiVVFMNHJORUhhVWJPNWFvaXNteGowckdzZFBtdzl0cUluT0YvTVRF?=
 =?utf-8?B?cjB1VUovVE9rZGZwQkhvVlFuKzhMVCtrMmRRYnU4bzhlSk1hSm1vUW0yNW8r?=
 =?utf-8?B?MFg3QTA3YTRqdXBSMXZjeFAxSEQ0eXFKUllMZHkydndGNmI1emJBTE5yV2E0?=
 =?utf-8?B?YS9lbVljSnhHUzBzUklqdXE3dnpOYmdCbmUrSmlreGpBVjdWWjBpNndMbThX?=
 =?utf-8?B?aHU1YVVtMFg4aStISStmMVB0ckVISGtZRk1SSzdVVmdDVENEbUljRThKQXFu?=
 =?utf-8?B?aUpZbnhOcStRUkxINlZ1R1Q3QWxGRHpHY3pNZGtPR2lqc0YvR1psNjZDa0JE?=
 =?utf-8?B?MzBtSm4vWmN3cjEvMWZPNkk2Y2xTeWVTSlVrblNvdkpROGM1V3lmcE5sM1FY?=
 =?utf-8?B?L2RlK3c4R01LZFpjNWMxY1l4cTBDbXI5RHN4ZzRwTUJQbS9jYkMxKzlENzZH?=
 =?utf-8?B?WDhDelZmelA3K09XK3lXanBhL1VZTnBTbDNoZzA0RDB2VlhOMlcvbWdyK090?=
 =?utf-8?B?dDdGZkFsblhnWVdYOUZrYnZxa21nOUt4Z1FycEU5UStjZlBDVGVxSFNieHdK?=
 =?utf-8?B?U1V0L3ZtekZHZnRDZEs5OU9oQ3BtaXA3WXZTZmsrNmpLVzdLUVdlUE9IREJo?=
 =?utf-8?B?bHVZWXhPQTRFT1pLVWlrT3N5TzhKbmMvMUhJdWxSd2pJbUt5UHpYMm55QSs0?=
 =?utf-8?B?NDVVVmdBL2srR1QzaHdQaitSaUpySFhKekJsWmNPck9UcUZrREVQYXlMM3NC?=
 =?utf-8?B?cndGL2lENWc0a01qRy9OZGRIclJpZ2I2bzVxaCtIandWeDdMemlNZjhSbkhx?=
 =?utf-8?B?Q3pMek03NEZoVVlqczFhRzZFNFU3akFJTFd4WkFycHJFQ3EvSkRINDdRaGpi?=
 =?utf-8?B?UXJWUE12V09vZWRTM0RzaUYrcE1vTG1qRVQ0Zm52djNoOCszdE9USmtHRjV1?=
 =?utf-8?B?cU9MZVVkd1QrSm04RDN2cThRRThSTDM5RjIyT01MbzBoR1pYd2JMandwNW9t?=
 =?utf-8?B?bFNUWThqQzhyb3dKeUE1eHhCby93c05nUGRrQjRFSmxWTXNqU21WTFlkK1po?=
 =?utf-8?B?VkpHTGpEL0Z2QjNZS1NlYnNzMDROR0dhSzhRd3NCTXFVYTNzcVNwekptSVFS?=
 =?utf-8?B?ejdiVHEvWjRScEFpajJneE12V2Y3MEhNZVpkeVFqZS9FTTluTEg4V2Y4eVdv?=
 =?utf-8?B?S0tic1VUYlVFa2dSVjhjVFRkV1ovS2pGNEVOalkwYllRaGNpZ09hSTNPTk0z?=
 =?utf-8?B?eXM1QjQ0M2JFTkRmRnZjV2Y5UlpsL2dUUWRzb2hoK0NwaVNJVXdSQ2lNMFJz?=
 =?utf-8?B?VFlVSEZzczlSNGdBRWZSVU9pVVovSWRYK1ZQSnI3dXNrTnRGejlHdjRuZmtW?=
 =?utf-8?Q?QILrT4t3z4T+rtKACKchebQk+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed17383-2f2b-49bd-50f8-08dc76534296
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 09:25:15.0992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPoXU9o7XLNcIKmrfpt3oCsAVIzQ7gIcGbb2kuw32yo9Z+qkewKEYPj+ct7wJvP4Wk1Pw6ZCG2cosHGtloVqALyt3Irhi3mYJ8yu07LWKB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7928
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgTWF5IDE3LCAyMDI0
IDEyOjQ4IEFNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
PjsgcWVtdS0NCj5kZXZlbEBub25nbnUub3JnDQo+Q2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQu
Y29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207IFBlbmcsIENoYW8gUA0KPjxjaGFvLnAucGVuZ0Bp
bnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCAwMC8xNl0gVkZJTzogbWlzYyBjbGVhbnVw
cyBwYXJ0Mg0KPg0KPkhlbGxvIFpoZW56aG9uZywNCj4NCj5PbiA1LzE1LzI0IDEwOjIwLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+IEhpDQo+Pg0KPj4gVGhpcyBpcyB0aGUgbGFzdCByb3VuZCBv
ZiBjbGVhbnVwIHNlcmllcyB0byBjaGFuZ2UgZnVuY3Rpb25zIGluIGh3L3ZmaW8vDQo+PiB0byBy
ZXR1cm4gYm9vbCB3aGVuIHRoZSBlcnJvciBpcyBwYXNzZWQgdGhyb3VnaCBlcnJwIHBhcmFtZXRl
ci4NCj4+DQo+PiBUaGUgZmlyc3Qgcm91bmQgaXMgYXQgaHR0cHM6Ly9saXN0cy5nbnUub3JnL2Fy
Y2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjQtDQo+MDUvbXNnMDExNDcuaHRtbA0KPj4NCj4+IEkg
c2VlIEPDqWRyaWMgaXMgYWxzbyB3b3JraW5nIG9uIHNvbWUgbWlncmF0aW9uIHN0dWZmIGNsZWFu
dXAsDQo+PiBzbyBkaWRuJ3QgdG91Y2ggbWlncmF0aW9uLmMsIGJ1dCBhbGwgb3RoZXIgZmlsZXMg
aW4gaHcvdmZpby8gYXJlIGNsZWFudXAgbm93Lg0KPj4NCj4+IFBhdGNoMSBpcyBhIGZpeCBwYXRj
aCwgYWxsIG90aGVycyBhcmUgY2xlYW51cCBwYXRjaGVzLg0KPj4NCj4+IFRlc3QgZG9uZSBvbiB4
ODYgcGxhdGZvcm06DQo+PiB2ZmlvIGRldmljZSBob3RwbHVnL3VucGx1ZyB3aXRoIGRpZmZlcmVu
dCBiYWNrZW5kDQo+PiByZWJvb3QNCj4+DQo+PiBUaGlzIHNlcmllcyBpcyByZWJhc2VkIHRvIGh0
dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11L3RyZWUvdmZpby1uZXh0DQo+DQo+SSBxdWV1
ZWQgcGFydCAxIGluIHZmaW8tbmV4dCB3aXRoIG90aGVyIGNoYW5nZXMuIHBhcnQgMiBpcyBpbiB2
ZmlvLTkuMQ0KPmZvciBub3cgYW5kIHNob3VsZCByZWFjaCB2ZmlvLW5leHQgYWZ0ZXIgcmV2aWV3
cyBuZXh0IHdlZWsuDQo+DQo+VGhlbiwgd2UgaGF2ZSB0byB3b3JrIG9uIHlvdXIgdjUgWzFdIHdo
aWNoIHNob3VsZCBoYXZlIGFsbCBteSBhdHRlbnRpb24NCj5hZ2FpbiBhZnRlciB0aGUgbmV4dCB2
ZmlvIFBSLiBZb3UsIEpvYW8gYW5kIEVyaWMgaGF2ZSBmb2xsb3d1cHMgc2VyaWVzDQo+dGhhdCBu
ZWVkIGEgcmVzeW5jIG9uIHRvcCBvZiB2NSwgcG9zc2libHkgb3RoZXJzIFsyXSBhbmQgWzNdLCBu
b3Qgc2VudA0KPkFGQUlDVC4gQW55aG93LCB3ZSB3aWxsIG5lZWQgaW5wdXRzIGZyb20gdGhlc2Ug
cGVvcGxlIGFuZCBJT01NVQ0KPnN0YWtlaG9sZGVycy9tYWludGFpbmVycy4NCg0KVGhhbmtzIGZv
ciBzaGFyaW5nIHRoZSBwbGFuLg0KDQorSm9hbywgRXJpYywgTWljaGFlbCwgSmFzb24sIE5pY29s
aW4sIENsZW1lbnQgZm9yIHRoZWlyIGF3YXJlbmVzcy4NCg0KT24gbXkgc2lkZSwgSSBoYXZlIHJl
YmFzZWQgbmVzdGluZyBzZXJpZXMgb24gdG9wIG9mIHY1WzFdLA0KdGhlIG5ld2VzdCBwYXRjaGVz
IGF0IGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56aG9uZy9p
b21tdWZkX25lc3RpbmdfcmZjdjIvDQppcyB1bmRlciBpbnRlcm5hbCByZXZpZXcsIEZZSS4NCg0K
VGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPlRoYW5rcywNCj4NCj5DLg0KPg0KPlsxXSBbUEFUQ0gg
djUgMDAvMTldIEFkZCBhIGhvc3QgSU9NTVUgZGV2aWNlIGFic3RyYWN0aW9uIHRvIGNoZWNrIHdp
dGgNCj52SU9NTVUNCj4gICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAy
NDA1MDcwOTIwNDMuMTE3MjcxNy0xLQ0KPnpoZW56aG9uZy5kdWFuQGludGVsLmNvbS8NCj4NCj5b
Ml0gW1BBVENIIGF0c192dGQgdjIgMDAvMjVdIEFUUyBzdXBwb3J0IGZvciBWVC1kDQo+ICAgICBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA1MTUwNzEwNTcuMzM5OTAtMS1jbGVtZW50
Lm1hdGhpZXUtLQ0KPmRyaWZAZXZpZGVuLmNvbS8NCj4NCj5bM10gQWRkIFRlZ3JhMjQxIChHcmFj
ZSkgQ01EUVYgU3VwcG9ydA0KPiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVy
LjE3MTI5NzgyMTIuZ2l0Lm5pY29saW5jQG52aWRpYS5jb20vDQo+ICAgICBodHRwczovL2dpdGh1
Yi5jb20vbmljb2xpbmMvcWVtdS9jb21taXRzL3dpcC9pb21tdWZkX3ZjbWRxLw0KPg0KPg0KPg0K
Pj4NCj4+IFRoYW5rcw0KPj4gWmhlbnpob25nDQo+Pg0KPj4gWmhlbnpob25nIER1YW4gKDE2KToN
Cj4+ICAgIHZmaW8vZGlzcGxheTogRml4IGVycm9yIHBhdGggaW4gY2FsbCBzaXRlIG9mIHJhbWZi
X3NldHVwKCkNCj4+ICAgIHZmaW8vZGlzcGxheTogTWFrZSB2ZmlvX2Rpc3BsYXlfKigpIHJldHVy
biBib29sDQo+PiAgICB2ZmlvL2hlbHBlcnM6IFVzZSBnX2F1dG9mcmVlIGluIGh3L3ZmaW8vaGVs
cGVycy5jDQo+PiAgICB2ZmlvL2hlbHBlcnM6IE1ha2UgdmZpb19zZXRfaXJxX3NpZ25hbGluZygp
IHJldHVybiBib29sDQo+PiAgICB2ZmlvL2hlbHBlcnM6IE1ha2UgdmZpb19kZXZpY2VfZ2V0X25h
bWUoKSByZXR1cm4gYm9vbA0KPj4gICAgdmZpby9wbGF0Zm9ybTogTWFrZSB2ZmlvX3BvcHVsYXRl
X2RldmljZSgpIGFuZCB2ZmlvX2Jhc2VfZGV2aWNlX2luaXQoKQ0KPj4gICAgICByZXR1cm4gYm9v
bA0KPj4gICAgdmZpby9jY3c6IE1ha2UgdmZpb19jY3dfZ2V0X3JlZ2lvbigpIHJldHVybiBhIGJv
b2wNCj4+ICAgIHZmaW8vcGNpOiBNYWtlIHZmaW9faW50eF9lbmFibGVfa3ZtKCkgcmV0dXJuIGEg
Ym9vbA0KPj4gICAgdmZpby9wY2k6IE1ha2UgdmZpb19wY2lfcmVsb2NhdGVfbXNpeCgpIGFuZCB2
ZmlvX21zaXhfZWFybHlfc2V0dXAoKQ0KPj4gICAgICByZXR1cm4gYSBib29sDQo+PiAgICB2Zmlv
L3BjaTogTWFrZSB2ZmlvX3BvcHVsYXRlX2RldmljZSgpIHJldHVybiBhIGJvb2wNCj4+ICAgIHZm
aW8vcGNpOiBNYWtlIHZmaW9faW50eF9lbmFibGUoKSByZXR1cm4gYm9vbA0KPj4gICAgdmZpby9w
Y2k6IE1ha2UgdmZpb19wb3B1bGF0ZV92Z2EoKSByZXR1cm4gYm9vbA0KPj4gICAgdmZpby9wY2k6
IE1ha2UgY2FwYWJpbGl0eSByZWxhdGVkIGZ1bmN0aW9ucyByZXR1cm4gYm9vbA0KPj4gICAgdmZp
by9wY2k6IFVzZSBnX2F1dG9mcmVlIGZvciB2ZmlvX3JlZ2lvbl9pbmZvIHBvaW50ZXINCj4+ICAg
IHZmaW8vcGNpLXF1aXJrczogTWFrZSB2ZmlvX3BjaV9pZ2Rfb3ByZWdpb25faW5pdCgpIHJldHVy
biBib29sDQo+PiAgICB2ZmlvL3BjaS1xdWlya3M6IE1ha2UgdmZpb19hZGRfKl9jYXAoKSByZXR1
cm4gYm9vbA0KPj4NCj4+ICAgaHcvdmZpby9wY2kuaCAgICAgICAgICAgICAgICAgfCAgMTIgKy0N
Cj4+ICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAgIDYgKy0NCj4+ICAgaHcvdmZp
by9hcC5jICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCj4+ICAgaHcvdmZpby9jY3cuYyAgICAg
ICAgICAgICAgICAgfCAgMjUgKystLQ0KPj4gICBody92ZmlvL2Rpc3BsYXkuYyAgICAgICAgICAg
ICB8ICAyMiArKy0tDQo+PiAgIGh3L3ZmaW8vaGVscGVycy5jICAgICAgICAgICAgIHwgIDMzICsr
LS0tDQo+PiAgIGh3L3ZmaW8vaWdkLmMgICAgICAgICAgICAgICAgIHwgICA1ICstDQo+PiAgIGh3
L3ZmaW8vcGNpLXF1aXJrcy5jICAgICAgICAgIHwgIDUwICsrKystLS0tDQo+PiAgIGh3L3ZmaW8v
cGNpLmMgICAgICAgICAgICAgICAgIHwgMjI3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0NCj4+ICAgaHcvdmZpby9wbGF0Zm9ybS5jICAgICAgICAgICAgfCAgNjEgKysrKy0tLS0t
DQo+PiAgIDEwIGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNlcnRpb25zKCspLCAyMzggZGVsZXRpb25z
KC0pDQo+Pg0KDQo=

