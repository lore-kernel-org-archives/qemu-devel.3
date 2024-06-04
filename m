Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABEFC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPom-0004Er-7D; Tue, 04 Jun 2024 04:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEPok-0004Ei-6s
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:46:54 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEPoi-0007Kk-93
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717490812; x=1749026812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZYaJz8TB8/ppt2rU58CveaPwJYycl0BVW2hRpDjDSeQ=;
 b=iJUGqxBrCPLcycad+zWaglPRo0Sbi+rQ26oSh1LkgEc/8Yif1tpj7uNa
 u3QEDGVvpk/EXAqBMFsTFj3SWuF5mWYMM2O760ZsSywNk+Av5lSYO1xty
 f86cNMiBqMkJJ5t9zH/xPwW6KMIVrFPREqWCbWf5jvxrxv1mwa3G1bMUN
 wWVx8BXM4ZWCBQZLme1mQQB9w16D6BuJRuPzbrOe3xoHNZIGO4auTCAfs
 nJpXpfqufqgVsGslX3uFHeMIxxZirKOQzvdev4LQxUoxu3qskswmzGmdg
 MgGpgCjaAiGP1oH+vK4NA/mYBgpi5P6Y9nalAaLawlL6fxDHU7GNn0f5J A==;
X-CSE-ConnectionGUID: 5Jt6cPaJRMWY5ImFdMsMnA==
X-CSE-MsgGUID: egUlmjkSRPqb9dLdrpe2VQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="39428546"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="39428546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 01:46:50 -0700
X-CSE-ConnectionGUID: xO3XvKVtSXquibvjV+yjzw==
X-CSE-MsgGUID: hvQ/ijNTShiBBWpZBqJpAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37227204"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jun 2024 01:46:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 01:46:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 01:46:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 01:46:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 01:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SovvxIKX46XB41uU3f8XHlTRYVfUKPv3lUjuJk+pezJ8YKPLDxnUSYw4r9Ug+6osHi95sN9YPE6c6eWbKWNohiEcPBvBs76adNq3bvUY64G36mwviSZ/ql8VG/duXrxZOYuLm6Pfyg5v1lFSv6oYNKSF7XYXJSAuQdtUWfKhjTije3n0wSJ+UrxrBtd3i3cWgtsE+JPIFOpvEEm9+MrKfsnrDnSDcQoX+OtebpQSEKQXuByRRx+xy7nWr048u34nlufxt4l/wHbhmLu00bnRcARLlB4Zy49WGnDtBtjrWzo3+x2Pox6EbmkxJ70DOEdh4XleZwZ83xcf0hv8kCgOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYaJz8TB8/ppt2rU58CveaPwJYycl0BVW2hRpDjDSeQ=;
 b=SVDUDJFzJ0XXuo+IjcMNhROPO6hqyYajeE+ixrA0jNgiDe+f9dN09WRaZe7SgUhe5a1H7TvCSQ+yohQC2xnU3ttvE5o60Yec95UbhrQeDy/BGzl1Uh4Z6oRrckghGUBuK4OTcBSBDrxsM7fo+sLDko26iNHAbo/3e7BuDNSOHjfDRGIZt8If0ZxuT3FoKdEqqK4yNReoQYgksz5CTTEe69BPF1W2DqL7ZweiDH1Xs2sNjLh6c1QxizVDomNcVotWvZ9cBDuiv7x6c+OKa/eDrve4ufjr+EY12njt5HC2y19OX360pt7EMhMce2NKBVZQPdOZB7RC3XCzm821zlzlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 08:46:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 08:46:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Thread-Topic: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Thread-Index: AQHatX06h36sLJ7ptUagEHDYae8P57G16ICAgAARcACAAPTFUIAAU8MAgAAI8/A=
Date: Tue, 4 Jun 2024 08:46:45 +0000
Message-ID: <SJ0PR11MB67444BA9CD463A744C9A616292F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-12-zhenzhong.duan@intel.com>
 <d25fc439-c201-4331-9fb2-d62b37d371b1@redhat.com>
 <9d061253-a762-41d3-9313-01c6f94559a1@redhat.com>
 <SJ0PR11MB6744B71456C0686F70F023C892F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <175f9e2d-8ade-4e44-a7bd-d8c7a4c85378@redhat.com>
In-Reply-To: <175f9e2d-8ade-4e44-a7bd-d8c7a4c85378@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL3PR11MB6483:EE_
x-ms-office365-filtering-correlation-id: 1774201e-8757-49ed-c539-08dc8472dda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?dFh2Y3JiWGpjUUV3ak4zL29mRitWaFBDVGdlVkhWaVVDSWlFa1B3RnFpaFE5?=
 =?utf-8?B?aWZzbExKeW50OGtYc2NNcGIzOVZBU0JyZGVuQVhmZEpWTVJXNkJjR3JmTGpx?=
 =?utf-8?B?OHAvUnlMRFdPOFlBKzZ2a3M0YlhuTEZxVDdJZ2FoVVN4OWFMZ0IxRytrWCtU?=
 =?utf-8?B?UHIySCtRb2t3WTdwN0Y2WTZDVnJqeUR1S2FQT25tWjNPbGNqR3Y4MkxjMGpn?=
 =?utf-8?B?TXk2SkNDOUlISXozWGZVY1FEYzRiWFdDN1lxU3VrYWsyTG1yazVvbk13K1VU?=
 =?utf-8?B?YlVqUDZVNkxhTFdBRHNwM3RKbU1yL1cyVURQdVZtS3JVd1g5MGVDQy84Vlhi?=
 =?utf-8?B?eDlPa2I2anVmUkh6c0wwU25sTFEwbnZHZXV2WFJ1MlZiU1c0OW5HVVVHaS9j?=
 =?utf-8?B?RnlLb3NocUx6ZzlOKzZrZk5qUFBlWGkzL3I1OXlzUjRBSmxIVUVTRHZPNnlE?=
 =?utf-8?B?U3p6YWd5b0ltMnZJUlFHSFQ4NkZvbk00b21iTDRoandhMUNORmlsNkg3WW1i?=
 =?utf-8?B?V1BVRlVMcHVlRlFZUU9BWlJ0UHplVTJhaEZydkdhMVdIZ1F2YkZZMWdzeHVE?=
 =?utf-8?B?a3BwcGJpamZxSndFdDFNWXF4QWdVcXJ2MlNZb1dHa1VBUnozVEVtNTFaVy9R?=
 =?utf-8?B?Tk94ZHZaenZBUnd3dVZlampxUGVvcVVEQjBMRTJDb3NyZy8yYm9XbVN3NDVv?=
 =?utf-8?B?UWdpZVo3TVhhM0cwckN4UGtJWC9jTG04VXN5aTF1TDlOTWhjcGdmVyt5VlIz?=
 =?utf-8?B?NCt2Rk0zbDY2Z1A4ekdhdThuZDJRY1B4L0JvNmFodWxVMTl6N0hJa0kvalVI?=
 =?utf-8?B?SEozSGZ3SlVGaGdjV09QM1B4M3hlN1dzRVNOc2NUZElGQUlKZ0RvMFZRcjRY?=
 =?utf-8?B?N3M5WlkzN0tiQ1FJeU5namsrK0gxTHdIR2tUN0ZiWVdCWC9tbUhta0g2L1dm?=
 =?utf-8?B?d0ZTakN5U3ZjZVoxWk1EenladnQwUmZtNGZ6dXRuZ2hpQjFhdU9yQnlNcWhs?=
 =?utf-8?B?ay9tYk5GRmlxWk1WL3NYSmswVUo2eWxWcDNuWXZGbHJWb3A1ME42ZzdCRFFO?=
 =?utf-8?B?U21aSXhiZVlDRTRMMEtQRGJNRTJLOFhQa0xuTFZYcWV4ZktHWXVzSDVWczFz?=
 =?utf-8?B?eC9VM3JZRjY5cTJXUGVRS1hYVTUxZkFwa3lNL3U3UXF2ZEJ6UFlmWFNXMjJL?=
 =?utf-8?B?TU5mdlYvWjZtaXRmVDhIZG12L1hrRjBpRThXMnZHYm4ra3ZpV2FSS29UY3Zk?=
 =?utf-8?B?UmczNS9nY1NNbTVPMGhyRFo0Zi8vM3lMZE1qZloyOEYzVkxtai9vVjBoSDhy?=
 =?utf-8?B?SGI1SGEySDlWQ0lqRGgzN3RmVHFKNGpXMTlFdkVLRDF4cnlCRUhMSG14Z0VN?=
 =?utf-8?B?NTZMZjlmYWRmaVh5S0IvbWg2b1NQS3Zpd0FNRGkrWUZaZ1dxWWtmTlllUVM5?=
 =?utf-8?B?dVlWTW9uMnhpWGtBV1YyQzZmamJFM3BIck1UbEk4ckhIelJaVFhiM20yWVlT?=
 =?utf-8?B?NUhvRUkweDBsSVVRRVJEamRmeW41WUd1N3VRdWwvSlNNNGRsRjlqbXpSY2wy?=
 =?utf-8?B?aUdzMS84N2xzVXRuN0d6SUV1SW9BdTA2YzNDV0IyTmM4QzNzV3VYdEo4eml2?=
 =?utf-8?B?WjI5OUVwRGJ0L1Z3a1ZKV3dRVHpLRUhoL3pBVElWUmtETGE5QWhHOHpEN1FT?=
 =?utf-8?B?QkhvMmFJK3VLR1JhQml0MDAyQTZjRTlqZHNQaHhmVUpuTHg2MEF5UUlRMnMz?=
 =?utf-8?Q?HWjd/wMDyf2a9lXEZWvnTnKxr/IogMaEf/yB6hd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDF5YTNHVE1RUkVrNyttYUhFVFFFRDNUNWs5NlpFZWR1OTNHMFgyaVlhYzVz?=
 =?utf-8?B?d05CdWxuZ1dVQnZuUktYUTN6d0M1YjZPRU1VMXZ3Y05UZDdxbGVTOVJYTFVv?=
 =?utf-8?B?OGVZOWlKVm5Dei9NWDNpc0lUK0V0aGc3Yy9zUWNqZ1paSU01RFB6WE1DTmdx?=
 =?utf-8?B?LzNvM2xuU3NaNWtodW5iRlhWWFdzMXFIazdGRHFQb2kyUkMzK0dUL0NJajcr?=
 =?utf-8?B?WVNJNWJlQ3VYYmc2VnRsQ1BPd2JNcTlLaXBha2hMZ2pPMXhqVkZyb3YwNjAy?=
 =?utf-8?B?UzdPd09hT2Z5SEhYSmh1cnorRm44dEJWZXFxUUtmRzE0YlFUNzdIVlczWTgz?=
 =?utf-8?B?a3luekpkU0JhWTRDRDBDVEhhTlNEbVNSSnArZzFtMjVqazRlVnpVbHpBUDgr?=
 =?utf-8?B?dk9uTHgyNmNKTzNnTTFRcW1Id0w1emplbEtoLzU5bUR4d1BpT3o0VlM3aW9N?=
 =?utf-8?B?b2Z3VVFERVNxN2JqdkdwNUpJZDRHZVM5eUlLWUYyb3pTbDB6MGNLaCtpeU9t?=
 =?utf-8?B?Tmw5VTM4dlR3NW41eXhSK2pDaWRiT2V2dnhUNi9Tb204dUROVUUxTTlGTE5I?=
 =?utf-8?B?UHpncytnWnlPSCs3aWJrR0FLT01MTDFlb2kzK2E1T2ptV2NPbjByRk56SjlD?=
 =?utf-8?B?VThlSWtnU1VaMWNyWjVZQ29SV1V1THFxcFRKclZ1Zkp0WmYrc0x3QkJJVnlE?=
 =?utf-8?B?NWZPeFpNSWQxbkZBNHRqTERtdzZtQkZjUHZod2pJdkxpblZQUmJPVWZOVy9X?=
 =?utf-8?B?SjFQMXVQSXNWVndhaUp3bWp0UnF4TVZrMEgyREdIY2dlT3JEWjJ3TGZiWmIx?=
 =?utf-8?B?dXZjSUVSbWhSbE9HQ1EyYVd1Q3ZhNlRmWkUyODN5THRvb1g5eE1mK3pKcFpM?=
 =?utf-8?B?azh3aDNkWmRyeEMxcERSekdmNk5YazFTUkxjZllEZjc5aGZCSzhxUVFzRUV6?=
 =?utf-8?B?V2dGQ0I2ckJIK1FZODlpN0k2VFhkSit2TWoyeFVyU0YvVUR1T3BOSmc1bXBC?=
 =?utf-8?B?cjZSaDV0T0k3Ym8wSm5RKy83bDFJVmhmbDg5Q3pINHlqWVRJZ0NQODJFY29Q?=
 =?utf-8?B?dU4yMlRSYXgzQUpYeGhUY0NrMmM2VmNJbkwwUUh5akFCWE1FazZhTlczalJW?=
 =?utf-8?B?Qm5WbUZyMlRYR0hRcmRXWmwwOHVrNnlkVGpjVVR6MDRFdkdLai81SVFLeUo0?=
 =?utf-8?B?aEIwQjB6VzloT1dFZmpPenQ5MGl5M2ZTVVZpc1ZHaUl3dUxNRVhCME41S01i?=
 =?utf-8?B?Z0dkVm53NUR2c0k5WURqc0RSN3Z2dXlQMHAzWGhFWFpJL3Z3aTRsKytsU0xX?=
 =?utf-8?B?emtUQ2p2WWZoTlJWSDFPdkVJcXNwSzVHVGdnaHVYM0V3alovY1dJRGpsaTJp?=
 =?utf-8?B?eUs3SWZtVHk2aStPWHRHdFRudWpoM2MwVTQ4RnB4L0VjS1lGMUFKdWxQTU9U?=
 =?utf-8?B?MUpIejRjZnJLMjlSYnpLWTB0WEJJWEg3M2s5UDNsdVZ0bjhKelRUdm5WV0NE?=
 =?utf-8?B?YVRKb0sxclRkeUdVVmpmMldTS1RveThWTXIrVFFBOTZuTmhYcVpTVkJOekd2?=
 =?utf-8?B?QjN5MVJ6Q2hZVURlaVdFVEV0cWQyUHBEZUZrOFhqTG1DY0NocUtrWXBWZWtE?=
 =?utf-8?B?U1htZzFFajY0dDFyQk55RXE4WXl2d3IySjNuT2xVMTlWZk9CdlNFNjFmQzMw?=
 =?utf-8?B?QjFDdFVaWlozczlXM0thZmpicWgrOGZTbmNNUHU2NkFDcFgwSTJ1QVlRR2hj?=
 =?utf-8?B?YlVzZTBKS29WTUtYcFQzenVzRVFHRFVuOXlnU3ZjRldYNnBLTWl5VHpqYyto?=
 =?utf-8?B?eUpPeXY0bnRiZDlDRVNoVUJScms5RzB2ZU1UOGNoWXhYRHZoUUpIQzRGSFBq?=
 =?utf-8?B?dS9xRG9CemlkZHlRV0ZTNjMzQWdkR1RsNlpnU1dJMnhVay93Y1R3K0oySjdG?=
 =?utf-8?B?UkNVc21DNlV2aEcxZkh3UjBYTTNCcWg2NFkydEY0dlZlS2plVXJselZuanJP?=
 =?utf-8?B?b0dIaUE4Y1N0M3pjVDBheFpjMzNZM3UwVkNLMWd6anhDS2V1UnRjMXhvNGFx?=
 =?utf-8?B?L093bEFXYS9pRG1LL0QyOTZvWlBKU2VsaGpyT1c0VUFsMm5KcEVJVURMeEN3?=
 =?utf-8?Q?m1UK68BI9U2Ff0KLbjTgYH1uJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1774201e-8757-49ed-c539-08dc8472dda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:46:45.9123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yW24ZYsYO14kYuKIfo2SCZIuILiCXCqZzU3Gig8mDc9Z+zxKCu2bdYTdAW6hbKbVqDfx9pT/rwAXwtIXsqsddo65v1xAZmbDmemQEmQFNNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDExLzE5XSBiYWNrZW5k
cy9pb21tdWZkOiBJbXBsZW1lbnQNCj5Ib3N0SU9NTVVEZXZpY2VDbGFzczo6Z2V0X2NhcCgpIGhh
bmRsZXINCj4NCj4NCj4NCj5PbiA2LzQvMjQgMDU6MjMsIER1YW4sIFpoZW56aG9uZyB3cm90ZToN
Cj4+IEhpIEPDqWRyaWMsIEVyaWMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMTEvMTldIGJhY2tlbmRzL2lvbW11ZmQ6IEltcGxlbWVudA0KPj4+
IEhvc3RJT01NVURldmljZUNsYXNzOjpnZXRfY2FwKCkgaGFuZGxlcg0KPj4+DQo+Pj4gT24gNi8z
LzI0IDEzOjMyLCBFcmljIEF1Z2VyIHdyb3RlOg0KPj4+Pg0KPj4+PiBPbiA2LzMvMjQgMDg6MTAs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+Pj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgIGJhY2tlbmRz
L2lvbW11ZmQuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2JhY2tl
bmRzL2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+Pj4gaW5kZXggYzdlOTY5ZDZm
Ny4uZjJmN2E3NjJhMCAxMDA2NDQNCj4+Pj4+IC0tLSBhL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+
Pj4gKysrIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4+PiBAQCAtMjMwLDYgKzIzMCwyOCBAQCBi
b29sDQo+Pj4gaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhJT01NVUZEQmFja2VuZCAq
YmUsIHVpbnQzMl90DQo+ZGV2aWQsDQo+Pj4+PiAgICAgICByZXR1cm4gdHJ1ZTsNCj4+Pj4+ICAg
fQ0KPj4+Pj4NCj4+Pj4+ICtzdGF0aWMgaW50IGhpb2RfaW9tbXVmZF9nZXRfY2FwKEhvc3RJT01N
VURldmljZSAqaGlvZCwgaW50IGNhcCwNCj4+PiBFcnJvciAqKmVycnApDQo+Pj4+PiArew0KPj4+
Pj4gKyAgICBIb3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0gJmhpb2QtPmNhcHM7DQo+Pj4+PiAr
DQo+Pj4+PiArICAgIHN3aXRjaCAoY2FwKSB7DQo+Pj4+PiArICAgIGNhc2UgSE9TVF9JT01NVV9E
RVZJQ0VfQ0FQX0lPTU1VX1RZUEU6DQo+Pj4+PiArICAgICAgICByZXR1cm4gY2Fwcy0+dHlwZTsN
Cj4+Pj4+ICsgICAgY2FzZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUzoNCj4+Pj4+ICsg
ICAgICAgIHJldHVybiBjYXBzLT5hd19iaXRzOw0KPj4+Pj4gKyAgICBkZWZhdWx0Og0KPj4+Pj4g
KyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTm90IHN1cHBvcnQgZ2V0IGNhcCAleCIsIGNhcCk7
DQo+Pj4+IGNhbid0IHlvdSBhZGQgZGV0YWlscyBhYm91dCB0aGUgZmF1bHRpbmcgSG9zdElPTU1V
RGV2aWNlIGJ5IHRyYWNpbmcNCj50aGUNCj4+Pj4gZGV2aWQgZm9yIGluc3RhbmNlPw0KPj4+IHll
cy4NCj4+IGRldmlkIGlzbid0IGFkZGVkIHRvIG1ha2UgdGhpcyBzZXJpZXMgc2ltcGxlci4NCj4+
IEl0J3MgYWRkZWQgaW4gbmVzdGluZyBzZXJpZXMsDQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1
MTc2NS9xZW11L2NvbW1pdC81MzMzYjFhMGFlMDNiM2M1MTE5YjQ2YTENCj5hZjc4NmQxOTlmMTAz
ODg5DQo+Pg0KPj4gRG8geW91IHdhbnQgdG8gYWRkIGRldmlkIGluIHRoaXMgc2VyaWVzIGZvciB0
cmFjaW5nIHB1cnBvc2Ugb3IgYWRkaW5nIHRyYWNlDQo+aW4gbmVzdGluZyBzZXJpZXMgaXMgZmlu
ZSBmb3IgeW91Pw0KPg0KPndoYXQgd291bGQgYmUgbmljZSBpcyB0byBnZXQgYSBjb21tb24gd2F5
IHRvIGlkZW50aWZ5IGEgSG9zdElPTU1VRGV2aWNlLA0KPmNhbid0IHdlIHVzZSB0aGUgbmFtZSBv
ZiB0aGUgVkZJTy9WRFBBIGRldmljZT8gZGV2aWQgZG9lcyBub3QgZXhpc3Qgb24NCj5sZWdhY3kg
Y29udGFpbmVyLiBBdCBsZWFzdCBhIGtpbmQgb2Ygd3JhcHBlciBtYXkgYmUgcmVsZXZhbnQgdG8g
ZXh0cmFjdA0KPnRoZSBuYW1lLg0KDQpHZXR0aW5nIG5hbWUgZGlyZWN0bHkgaXMgbm90IGVhc3ks
IHdlIGNhbiBzYXZlIGEgY29weSBpbiAucmVhbGl6ZSgpLCBsaWtlIGJlbG93Og0KDQotLS0gYS9p
bmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQorKysgYi9pbmNsdWRlL3N5c2VtdS9o
b3N0X2lvbW11X2RldmljZS5oDQpAQCAtMzMsNiArMzMsNyBAQCBPQkpFQ1RfREVDTEFSRV9UWVBF
KEhvc3RJT01NVURldmljZSwgSG9zdElPTU1VRGV2aWNlQ2xhc3MsIEhPU1RfSU9NTVVfREVWSUNF
KQ0KIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2Ugew0KICAgICBPYmplY3QgcGFyZW50X29iajsNCg0K
KyAgICBjaGFyICpuYW1lOw0KICAgICBIb3N0SU9NTVVEZXZpY2VDYXBzIGNhcHM7DQogfTsNCg0K
ZGlmZiAtLWdpdCBhL2JhY2tlbmRzL2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KaW5k
ZXggZjJmN2E3NjJhMC4uODRmZWZiYzllZSAxMDA2NDQNCi0tLSBhL2JhY2tlbmRzL2lvbW11ZmQu
Yw0KKysrIGIvYmFja2VuZHMvaW9tbXVmZC5jDQpAQCAtMjQwLDcgKzI0MCw3IEBAIHN0YXRpYyBp
bnQgaGlvZF9pb21tdWZkX2dldF9jYXAoSG9zdElPTU1VRGV2aWNlICpoaW9kLCBpbnQgY2FwLCBF
cnJvciAqKmVycnApDQogICAgIGNhc2UgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJVFM6DQog
ICAgICAgICByZXR1cm4gY2Fwcy0+YXdfYml0czsNCiAgICAgZGVmYXVsdDoNCi0gICAgICAgIGVy
cm9yX3NldGcoZXJycCwgIk5vdCBzdXBwb3J0IGdldCBjYXAgJXgiLCBjYXApOw0KKyAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiJXM6IHVuc3VwcG9ydGVkIGNhcGFiaWxpdHkgJXgiLCBoaW9kLT5u
YW1lLCBjYXApOw0KICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQogICAgIH0NCiB9DQpkaWZmIC0t
Z2l0IGEvaHcvdmZpby9jb250YWluZXIuYyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCmluZGV4IGE4
MzA0MjY2NDcuLmU3ODUzOGVmZWMgMTAwNjQ0DQotLS0gYS9ody92ZmlvL2NvbnRhaW5lci5jDQor
KysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQpAQCAtMTE1Miw2ICsxMTUyLDcgQEAgc3RhdGljIGJv
b2wgaGlvZF9sZWdhY3lfdmZpb19yZWFsaXplKEhvc3RJT01NVURldmljZSAqaGlvZCwgdm9pZCAq
b3BhcXVlLA0KICAgICB9IGVsc2Ugew0KICAgICAgICAgaGlvZC0+Y2Fwcy5hd19iaXRzID0gMHhm
ZjsNCiAgICAgfQ0KKyAgICBoaW9kLT5uYW1lID0gZ19zdHJkdXAodmRldi0+bmFtZSk7DQoNCiAg
ICAgcmV0dXJuIHRydWU7DQogfQ0KQEAgLTExNjUsNyArMTE2Niw3IEBAIHN0YXRpYyBpbnQgaGlv
ZF9sZWdhY3lfdmZpb19nZXRfY2FwKEhvc3RJT01NVURldmljZSAqaGlvZCwgaW50IGNhcCwNCiAg
ICAgY2FzZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUzoNCiAgICAgICAgIHJldHVybiBj
YXBzLT5hd19iaXRzOw0KICAgICBkZWZhdWx0Og0KLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAi
Tm90IHN1cHBvcnQgZ2V0IGNhcCAleCIsIGNhcCk7DQorICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICIlczogdW5zdXBwb3J0ZWQgY2FwYWJpbGl0eSAleCIsIGhpb2QtPm5hbWUsIGNhcCk7DQogICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgfQ0KIH0NCmRpZmYgLS1naXQgYS9ody92ZmlvL2lv
bW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQppbmRleCA4ZmQ4ZDUyYmMyLi4yZGYzYWVkNDdm
IDEwMDY0NA0KLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5j
DQpAQCAtNjM3LDYgKzYzNyw3IEBAIHN0YXRpYyBib29sIGhpb2RfaW9tbXVmZF92ZmlvX3JlYWxp
emUoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB2b2lkICpvcGFxdWUsDQogICAgICAgICByZXR1cm4g
ZmFsc2U7DQogICAgIH0NCg0KKyAgICBoaW9kLT5uYW1lID0gZ19zdHJkdXAodmRldi0+bmFtZSk7
DQogICAgIGNhcHMtPnR5cGUgPSB0eXBlOw0K

