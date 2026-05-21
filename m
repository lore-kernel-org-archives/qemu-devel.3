Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000D3CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1vQ-0001jG-ES; Thu, 21 May 2026 07:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQ1ui-0001X2-7l
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:50:09 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQ1t3-0000GA-VJ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779364106; x=1810900106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9URZG5CCw5Z8XZrd9VLMcqS3HAVAsaZ7ERygTy5APvg=;
 b=fBYJSSLbjsExBwe6AtSDLU328JbmAkjHPvcKGmHt+Hb7J+v71TyngTS4
 VXy/fmKmFm6LrQCG3Ym7Psp0rbGg6aTvuZeyvTdXBkVZQ5ahMTHoBsQaH
 EfwrjhZwnvf17hpKQP3Tbx7kC8dAyTUUlkg/qW7FPMLvRKfy9sybAZvsr
 agWlCMd8RBHDmiDbn3+TnE17v03TVNz80XVR3+mLJlYcChN2ZC74Gr2vs
 BcgH3F7Vg+mW0GEd58mb8cq+x2YB/wB95iE+hRDbcqgMgGZ9ORspEg2Lu
 EtFW4JhVA5WJEFobAhLzdj3mt2omwDVh1cHjtAsuJQ0oLT+TcutNCIOoG w==;
X-CSE-ConnectionGUID: FsI+DyAkRSa3clRJAJOz5g==
X-CSE-MsgGUID: SJT9VV7XQZ+D3WFaBUZxtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="83898464"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="83898464"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:46:08 -0700
X-CSE-ConnectionGUID: 5KfsyidJQmeQ3+w0WdTvEw==
X-CSE-MsgGUID: tuuHK7deQrKHYO4vemImkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="264026598"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:46:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:46:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 04:46:07 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKhqqeA0fqpj4lG4DBRF4UpgsxaYRyErNvJ7MhZUofhDXjVKwi0tG0WF9DMs2ypLzdWi9voRyg7KXbgTsFO78xISPrhXAVG9QaK2KxC+rjbOZ3ck8cbLhnDy2MDik2ZViIxA5qsrnkt6s+5/xQ8d/a1j2EGeX2Kaxszzjt/lRA+QL0rYa70KfHLfKr7ZPZ7s89DqSd0crKalxuax3tLSu322mJe87cC/4UzSp7hJIIlxfyWMYzURU+lNaiGEEf8/aTadL1FdsIlst5PA/BW7kzG6KCgt1zaQeI/NQ0DPh/ppCBgptZ46RECs4kLBZJ5O0802YV6tvLIYR7RtZlTgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9URZG5CCw5Z8XZrd9VLMcqS3HAVAsaZ7ERygTy5APvg=;
 b=fjg48Rc0mFdGonSFcutd3g7KDC12rzUwAxsH9elsH8qogZRcGOh1SEACf6ofWc0q6Olb13tfGUddmorz++OLcyrjhp9nhLQWtUF5U/6mcxRwLEnLPhVd3WnZnHwfD/G3p70LtZJdbtwZB5QxWdyxmx0qmERCP5hd1bTsgzj0esz16PuSGGZFJKokcGdVbeViXzrLFZuAwjMD0L0sQs7IiPf5V7yYJy5rJptERW58NwapsiqqCPLDhyvAfwIS48yfKPEA58nDDhDbamxV1xLrZwnhv+s2hy3+1no0LypwpX1nXO1SLnbFCMSPQw9ljc8U3gMndAqQuXooROqHMGdI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB9879.namprd11.prod.outlook.com (2603:10b6:510:3c5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 11:46:04 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Thu, 21 May 2026
 11:46:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHc32mq+heH+3Y7mkyp8HUicHH917YNafsAgAlf6oCAAU1zAIAAM41Q
Date: Thu, 21 May 2026 11:46:03 +0000
Message-ID: <IA3PR11MB9136D8E8BFC422BD83713FD1920E2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-15-zhenzhong.duan@intel.com>
 <33d2536a-6401-4724-a632-5cf5003f2143@intel.com>
 <IA3PR11MB9136F28FF99D26A8BDA1E2B692012@IA3PR11MB9136.namprd11.prod.outlook.com>
 <16d2698f-7fb1-4718-8e90-7979a3e8d0b2@intel.com>
In-Reply-To: <16d2698f-7fb1-4718-8e90-7979a3e8d0b2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB9879:EE_
x-ms-office365-filtering-correlation-id: 855cfcb1-d5d9-4d5b-1adc-08deb72e89a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003|38070700021|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: PinjYGEA/EXbRcz2/1ovVtQt0cjBxFw2kzyRLoOhy8Xar+DtGQ9flUHHVXpwCRZ0gFpoiAX2EEkQteLwc4DfIaEd1hwNF6aTaNjdCY/JlH5ueq9gJ3FTXTlxm7ii17qEL9fiRXyLMmPWlS3j21w9I1bWjTyM7eRxI16hn/6xce8dQbJzcJipK08WHzSLskUOJ89PzE0okMRF+gu2NlMqJoJR/BkyjEUr8Hxl2y4/s2IBa1+YLSXU42S4W11IbgO84SkPJf38DMQjNhgAvQS87tOWtWzW3IKu/5YIJs82nuLaOqXAJIxsL9wXV2dULCvD5xE/yFs0Qh6qGaSoHrGyjSVSE+EnbzLIBj8eHhhRSxgkw+gypUKIg8i7dz2mvpEdu/0uYHB8Yk7A/M98QjLHiouaCPfwkHylCoTeuhDiOA/znsSqnLjsXc3XRR6DXT1+m12pl+rYMq8/aAu0BcdAqGIlw04AV5FKASaYqZkSI0EioiTDL7IncpTQQk+2UI2dqiBcIP2z3ImHVZknXhscJVJpdviJ6IX7/9bw2VU7GZ//gq86Hhh6wyJSR5jMn4MGKlxXNLNKmU64iQjwrLpYDImdYCEYGgU797OkEDI2Ji0T8cYbFp4gtYE5o4GduYdWBJkmGn7geezeFnOME7P7H1Q+1hsv059PYKb4huUjdQMer4pU0hNt0u7umZgpi9Cp0KCdup9TTFfYIIUntIGurnnTfO9KZcXDVCXSuWP4Jd6ZkF4Z9cxWIO9NrIFT73fH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003)(38070700021)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkNick5wbUZiQ0VUdFdmWnhUWkVQTXhpOUpqcEZPSldyS2VpZHF5R1gyZlU0?=
 =?utf-8?B?ZVlJMHRGbERwck5MR09Mc0o0d3NMMHoyQXhTMUNpNjE5dEpsTUJabEF0MXdw?=
 =?utf-8?B?YXh1aWJ6QWVlQzltVXdyZzhxdjZMcXAvSlVCNVg2NXUvaGROenRKT3U3TnlT?=
 =?utf-8?B?L0dYMzk4dEEwbUprVnJzTXcwSDc3akh4dHc0S25TRExwNHAybW5xV2hQdldQ?=
 =?utf-8?B?WHlPeDZmd2MrbVhnTnByMnBzRmZxa3poZHZ1bHZOMEVCdHUxM3FIajRaMGVI?=
 =?utf-8?B?K0RIaVlMZE91NUI0VmdVajh0Vy9VS0Q5WlUrem9qODZkd3BINzJwTzc3V3Bs?=
 =?utf-8?B?UVJobmw1ajVIRVBOakJPZktma0RGT2xLR0IrMjBKckEwMzUzUnNvUC8zT0RN?=
 =?utf-8?B?S1NmNVhnM2JpRDd3Z1N2TVUraXZDY2N5aEtXdHhOS0dib3NCdTkwVElEc2U5?=
 =?utf-8?B?UEZNazBMZ2NLTHlwNUZhSTZRRlV6VU9NN09wNm9XNUpmek9wbjlLd1JzMVZp?=
 =?utf-8?B?YWNxUzczNGNuS2pqRlZaNHJPLzZZQVdZd3NKcE5PMDQ5Z3hEOVpoVDBkcEhY?=
 =?utf-8?B?bnVWT3FHcnAycTI4OW1CcVpxWUgyUWIxTGpnL0Y0Ymcva0MyMUlHQ3ljdCtR?=
 =?utf-8?B?NDJzTGdvYkNqQk1WT01ISTQ1RWxsTHZZTENsWGM3K0h1RDZSSkpsVGVGOHJw?=
 =?utf-8?B?Nk9wemdGL3QvQm4yeHkwYmdaYUJVNnkyOGJyeDVBTnRsQXFKbHNOYTVtU3Jl?=
 =?utf-8?B?aWVabjQvTFBhTEJyVVhJcUpidGdNMS9JbzBoS3l1RUwrOUVjKzJiL1R5eVBI?=
 =?utf-8?B?VDllOWo4bU9qTG81NTJZU1BVaDl2Y05FU2kwNWpEUjBLUFcxWGt2K2lITjlU?=
 =?utf-8?B?MGVUb3FJMFdzSlFiUWpTOGdTQmxSMEs3bU5ITGZTbC9iNEMzZlRrS09XcEx6?=
 =?utf-8?B?YzJ1Y3JraitPVmcvbEJHa1dJQStFNy8xNjdFbnlsaWV0aGo4NXppditGNEZ4?=
 =?utf-8?B?N0hTTmY3OHlzbFlmUXdCK2pFbHg1SXNLQ3IwV2xtaHBsbXQzTU1PU1RCWjVH?=
 =?utf-8?B?cmdPWWNhajlrV0JBTUJRMjFCcU5UeFIrenBhY0ZLY2RCWThUK203R3lYNUVJ?=
 =?utf-8?B?YnlTWmRZa0JOMWxsVFNMMEZTaVdUVjRJMVQxM0ZDbllMZEU5Tm5JMDJRZlRT?=
 =?utf-8?B?ZUhZdm5TUFVsK2lIWFdZNXNGdDNOTXp4MzNra1VLdWhzcU4wYy9HTjY0T2g4?=
 =?utf-8?B?OUw4dnJMNlZTb1U3RjVSMEkveXIzK0oyL1VOVjluZElHMHZiUS9oMWcwTm5x?=
 =?utf-8?B?ZERmckhPQjZuL2h2Q05NQUZtSk1PNVFFMVk2Rms4aWxMdmJsdlhTSGtDYjl4?=
 =?utf-8?B?ZXR6QWlVeVhQWU1tZHBJVnRjMGlmTkRBb25GMytCNVFkZ3I2RlNzZXdYU1gx?=
 =?utf-8?B?VjU2a1FqUGxzNDd6TFgzaHprVVp0SG5wRk9kb2VHOEVMNlpRdnh5MFpzUzlH?=
 =?utf-8?B?R1JBRkw5b0dHOG9xVkVTZG5EeEtmZjFwWHoxK040VmxZZ2QvcHRsMVVTeFpj?=
 =?utf-8?B?dWlRZTl3aE5KdDFSRlNyMDZ0Q1p1MEUyMm5uUWVPY0NOejJMSldrUU16TEZH?=
 =?utf-8?B?U1l6a1pDeEZuK0FNbktHOGJ4WmFsRUZ2UkhpbllZRW1sNXBQTDMwRHZNK0xP?=
 =?utf-8?B?cEp5UmRKK0lERS9vTFc0TGJyK0xYT2M0ckFIMVVJdVllK1BoZ05WZjNUbzU5?=
 =?utf-8?B?WkYrNDdZOUJyRzFOU0RucU9xWVE1cENPUVpPK244eEdyMU5iZHQ3N21KT0V3?=
 =?utf-8?B?WkJEM2dhM05NNjFrRTQ0UGdiVW1RdjN1dnJjRkV3OEVSM2V2aVdEOXVVMDFN?=
 =?utf-8?B?eHFtY2JFOW5MMSsxeUVpdkI3akF0VWNCb1ViR0xnWGUxNGpUenBXOTVhek5L?=
 =?utf-8?B?TTZGN0dtNSsvYUJtaVpDSFYvSkFXanJrTUM0TTF2U2tHNVhWa3ZxTm5Ya01q?=
 =?utf-8?B?UlNkdCtObnJ4Q25YVWEyTU95ME1VakdrWCt4VnFZZnZuZW15ekVlQU5kMXJO?=
 =?utf-8?B?TUJreFRUdERFUDdidkJ4azFQQk9uZDREN2tXbERkRUg2U0lKaXhtT0lKcGIz?=
 =?utf-8?B?WUtZVm9VY0dEa0l1ZWZScEU2RHFxYVhaMjMyYUZxWW9lRUN3a1BmejdHaHdw?=
 =?utf-8?B?aGZTVGRSOEpKcmFMRXVhN20vZkNwbThmckJ4OHJVdGlMMEYvSndvZk1oWXNy?=
 =?utf-8?B?RDFBWUoyRXJpRDdJUlVTL3dBdFpJTkNSalVGNlp1ZW1scEdlTXBMZlhFcE1x?=
 =?utf-8?B?eTFwdGVDSTFLRFRXb1VVTHV5MnV5R0k1QWp4OVFRZGlXWXVCOXFSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I2mn1hpzFH8ZESRtaMfv6QOFnmtLuer33CKATjA9bBgKhBrqqHPQSoykInbwWAz70iua7W1FRS/kj0fMpCgtibinKLw8TWdos9Q8T8QGscGeo3iHvREuH8LTIZaH8MCAAH5yKjmUQDtxzigHlbHwGJG+jmyB4UuN0ylmX1Di0CLAXUGAF+WwLFA94yPD2nu7HS/Z4a2mgw1dZI7l6gePx/vEyj0fJ2hwZhOVJi2rIpEy+sNX6DKLR/wBnxrCRM/7xdT0bLSE8r9B+r99aPdvb616SpmHVyUA/gB4ZR2TdSY9aB4JfczdK9Z2un6a7RJugLu2lDPVyug1L/Ua3ymgWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855cfcb1-d5d9-4d5b-1adc-08deb72e89a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 11:46:03.8621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRPW1NmLRR+7dPPiArOwMsMusYseBOqXk95QdgNluuMwFwZlN5qqHzvf1ZU4fBOmAWJEdibj59t1YLJbcFx+c5Qelsz5r6Cb6v+x7ZKn060=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9879
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pj4+PiBAQCAtNjQsNiArNjUsMTMgQEAgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElP
TU1VU3RhdGUgKnMsDQo+Pj4gVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCwNCj4+Pj4gICAg
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+ICAgICAgICB9DQo+Pj4+DQo+Pj4+ICsgICAgLyog
T25seSBkbyB0aGUgY2hlY2sgd2hlbiBob3N0IGRldmljZSBzdXBwb3J0IFBBU0lEcyAqLw0KPj4+
PiArICAgIGlmIChjYXBzLT5tYXhfcGFzaWRfbG9nMiAmJiBzLT5wYXNpZCA+IGhwYXNpZCkgew0K
Pj4+DQo+Pj4gdGhlIHNlY29uZCBjb21wYXJpc29uIGxvb2tzIHN0cmFuZ2UuIGhwYXNpZCBpcyBk
ZXJpdmVkIGZyb20gZWNhcF9yZWcsDQo+Pj4gd2hpbGUgZWNhcF9yZWcgaXMgZnJvbSBzLT5wYXNp
ZC4uLiBpcyB0aGVyZSBhbnkgcGxhY2UgdGhhdCBjaGFuZ2VzDQo+Pj4gdGhlIHBzcyBmaWxlZCBv
ZiBlY2FwX3JlZyBhZnRlcndhcmQ/IEkgdGhpbmsgdGhpcyBjaGVjayBzaG91bGQgYmUNCj4+PiBh
Z2FpbnN0IGNhcHMtPm1heF9wYXNpZF9sb2cyIGFzIHRoaXMgaXMgdGhlIHZhbHVlIGZyb20gaGFy
ZHdhcmUuIHJpZ2h0Pw0KPj4NCj4+IGVjYXBfcmVnIGlzIGZyb20gaW9jdGwoSU9NTVVfR0VUX0hX
X0lORk8pLCBpdCdzIG5vdCBlY2FwIHJlZ2lzdGVyIGluDQo+dklPTU1VLg0KPg0KPkkgc2VlLiBJ
IG1pc3VuZGVyc3Rvb2QgdGhhdCB0aGUgaHBhc2lkIGlzIGdvdCBmcm9tIHRoZSB2SU9NTVUgZWNh
cA0KPnJlZ2lzdGVyLg0KPg0KPj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGd1ZXN0IGtlcm5l
bCB3aWxsIHBpY2sgdGhlIG1pbihjYXBzLT5tYXhfcGFzaWRfbG9nMiwgcy0NCj4+cGFzaWQpLCBz
byBjaGVja2luZyB0aGUgdHdvIGRvZXNuJ3QgbWFrZSBzZW5zZT8NCj4NCj5JIHRoaW5rIHRoZSBj
YXBzLT5tYXhfcGFzaWRfbG9nMiBzaG91bGQgYmUgdGhlIHNhbWUgd2l0aCBocGFzaWQgc2luY2UN
Cj5ib3RoIGFyZSBmcm9tIGhvc3QuIEFsc28sIEkgZGlkbid0IHNlZSB0aGUgbG9naWMgdG8gcGlj
ayB0aGUNCj5taW4oY2Fwcy0+bWF4X3Bhc2lkX2xvZzIsIHMtPnBhc2lkKS4gVGhpcyBpcyBub3Qg
ZXhwZWN0ZWQganVzdCBsaWtlIHRoZQ0KPmF3IGJpdHMuDQo+V2UgZmFpbCBpZiBhdy1iaXRzID4g
aG9zdCBhdy1iaXRzLg0KDQpJdCdzIGEgYml0IGRpZmZlcmVudCwgc2VlIGJlbG93Og0KDQpzdGF0
aWMgdTMyIGRldl9pb21tdV9nZXRfbWF4X3Bhc2lkcyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQp7DQog
ICAgICAgIHUzMiBtYXhfcGFzaWRzID0gMCwgYml0cyA9IDA7DQogICAgICAgIGludCByZXQ7DQoN
CiAgICAgICAgaWYgKGRldl9pc19wY2koZGV2KSkgew0KICAgICAgICAgICAgICAgIHJldCA9IHBj
aV9tYXhfcGFzaWRzKHRvX3BjaV9kZXYoZGV2KSk7DQogICAgICAgICAgICAgICAgaWYgKHJldCA+
IDApDQogICAgICAgICAgICAgICAgICAgICAgICBtYXhfcGFzaWRzID0gcmV0Ow0KICAgICAgICB9
IGVsc2Ugew0KICAgICAgICAgICAgICAgIHJldCA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihk
ZXYsICJwYXNpZC1udW0tYml0cyIsICZiaXRzKTsNCiAgICAgICAgICAgICAgICBpZiAoIXJldCkN
CiAgICAgICAgICAgICAgICAgICAgICAgIG1heF9wYXNpZHMgPSAxVUwgPDwgYml0czsNCiAgICAg
ICAgfQ0KDQogICAgICAgIHJldHVybiBtaW5fdCh1MzIsIG1heF9wYXNpZHMsIGRldi0+aW9tbXUt
PmlvbW11X2Rldi0+bWF4X3Bhc2lkcyk7DQp9DQoNCmRldi0+aW9tbXUtPm1heF9wYXNpZHMgPSBk
ZXZfaW9tbXVfZ2V0X21heF9wYXNpZHMoZGV2KTsNCg0KY2Fwcy0+bWF4X3Bhc2lkX2xvZzIgPSBp
bG9nMihpZGV2LT5kZXYtPmlvbW11LT5tYXhfcGFzaWRzKTsNCg0KY2Fwcy0+bWF4X3Bhc2lkX2xv
ZzIgaXMgdGhlbiBleHBvc2VkIHRvIGd1ZXN0IGFzIHBhc2lkIGJpdCB2YWx1ZSBpbiB2aXJ0dWFs
IFBDSSBjYXBhYmlsaXR5Lg0KVGhlbiBndWVzdCBrZXJuZWwgZG9lcyB0aGUgc2FtZSBtaW4oKSBj
YWxjdWxhdGlvbi4NCg0KWmhlbnpob25nDQo=

