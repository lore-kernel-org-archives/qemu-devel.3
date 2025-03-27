Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8D1C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txkBy-0006CD-Ru; Thu, 27 Mar 2025 06:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txkBq-00068X-U1
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:10:24 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txkBp-0004Xm-51
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743070221; x=1774606221;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NbM10AIVW6r/7QNPSyudr0axNLBx5ON/JhnIixo211w=;
 b=Mc4z4119ID0HR6p+G0obtQCM3Qs4gjPAg9aJz0ldVaTeR9D7sGfZW+vh
 1p8JJBTmcdgYPo8qawEuk6BrV/odbtmyDoH79jj+wqO5vOUKKcUrxWVdL
 Cf+pUSVj0WWSwUG7ZqdjSPREra1+eiSfXNj3z1977nD/Gq8mB/8cievXi
 r0BG1EaPq1AjFOx2/PMy61QjtPomrzvlc2m4flARd1OSXpD/sVVwWjemF
 fbcWTke8RCsDdzSbVQo0UkGxxNPGypOlb1HidWZfnpYA2M/TaXK0CmzN4
 rgFn25q+ESDg2PwnfUPY2IOE6PzTpC3dtbfemdPW9Vp0WUvlZX5I/Ajnd A==;
X-CSE-ConnectionGUID: E2CLZHToRhCpmkfWWmftEw==
X-CSE-MsgGUID: 41JfTY8JSB2lCjcr2pw0EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="43636029"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="43636029"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:10:18 -0700
X-CSE-ConnectionGUID: +ffdm5/CQICyS9j4lK+0Bg==
X-CSE-MsgGUID: mragk8LmQ2WhHtp6HZQyDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="130159290"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:10:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 03:10:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 03:10:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 03:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT77Ikl+VDX2RLCV2UOp+bTJTw8NReSdTmv2K0w/ejHW7e//ajGBZrtP/z4hr3ALyLVmsF3RSym+aC7Kgfz6QARaZQ7K8DAlp8WUxFNkd+JJyo2EGGdjix/mrjabpoDIHWiIXD2mCNPBeBwWjwSzJCG/mwUp/u8HI/iiPL9h5bExuNbAUSWxqWfG68BmjvGRyf305LQ5lObjcsANZreTLdsVnJ+J3PdFtLXzrTEjFiDOVtOMZDMHH7uZH8+YodFSEpu/i8yfWqOMHgATnat9jEkntsSKgTkMbhPRZlpau6GAOUd9RiqXoV8mR7QGfjD3m2lc55w5wKYJ+7lpkmzW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbM10AIVW6r/7QNPSyudr0axNLBx5ON/JhnIixo211w=;
 b=lVdgo49E4VPZ7E/m8/q2EVLGJ+ZQ7IsZ5vTtCz6ab3tmQQWbhhUFChyA2eT6ogrlCHSsYd3mITD3zqEZI3mWoyaIzeaq0crtMLHMcXR1SXg6HIs8ZBON/pNvzW9SSaZdsfv4Xt+vYRcnsIk81DVX/AjYSRqCrZ26dCB5vlNsMNCw6iMXehMtUNN6j2QeWPSMcDylnjyXRmowLyexzCylPQfNUJS5GK2xrZmSnlHlFklwwD3q0nXXxlHUbAxsd7nDsDFp0TMVr04nEAc80SLN4wmNqPFJDx9fHbLNxduqQKUgWEFNF5Pn7r8ZlqJFpjR9SdqGiy/bX9yDW4O90ewN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:09:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:09:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 37/37] vfio: Rename VFIOContainer related
 services
Thread-Topic: [PATCH for-10.1 v2 37/37] vfio: Rename VFIOContainer related
 services
Thread-Index: AQHbniRBV5QIiwTD60GNyK6kMXo6QLOGxF5w
Date: Thu, 27 Mar 2025 10:09:43 +0000
Message-ID: <SJ0PR11MB674468D95FEE62BCC13D0D0A92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-38-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-38-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5029:EE_
x-ms-office365-filtering-correlation-id: ef3d8157-cb3c-4ae4-3d93-08dd6d177eb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?NWl2OG50WjNLY2JPOEowOTc1UCsxakFaRWJ5TC9jamVpWGRDWDk1OHNjdmpS?=
 =?utf-8?B?N0xDRVhOOElTdVJXRFJwUGlGcXFFaWowSE9xN3NBbW93QjM3RGVVKzBnK1Ni?=
 =?utf-8?B?Rko0RDlzNzBBU2w5OEN5bjlESkUyVUQvY2l2cmRoenVML2pxT0ZrcVEyNnd2?=
 =?utf-8?B?U2Vwd3BTR3I5Q0JZYi9EdERJbU5IOVNJMTg1Q3g2ZnlMcHFNUXNMU3ZHQlJL?=
 =?utf-8?B?VVpvbGFNVXhEdnBydy9YL1NOMHdXejljc1B6YldacDZxcDJtZGRKSld6eXo3?=
 =?utf-8?B?cmxDaktoUTUyK0hDTmpMMkdpdGZvanpCT1VqN1FXeDk3VzAxWmpCdjBnS0hM?=
 =?utf-8?B?UkFCb05pVXp5Q0dsYkwvNlZIek9TMURCNG1rS3JCcHkwQTFjbmMyVTZhaE1U?=
 =?utf-8?B?OHJVN1FNcEdtWUdjTWt3eEl3ZHROL2E0bFdWQzl4RmxiMnN2bGYxa0tmTlB1?=
 =?utf-8?B?aklpNWorQld6UGRFNURMTjhHekw2ZVFReURvYjRRM2NHZFp4VEhIQmJCeURt?=
 =?utf-8?B?cnd5NUd3bUxRenR3dVl1T1dnTi81d2IzTjN3MHdvcEl4M1BqUmZnaUY2cG1F?=
 =?utf-8?B?akNuRlFVU001dTRJSG02R2RYMmZwZzdieGU4U2RpYnBya3JySVhuWk1JZVZW?=
 =?utf-8?B?cmRsZitTeURxZ2gvNysrMnlucHdlUTFtUE1UaW85aytsWmk3K2xRY3dQbXBG?=
 =?utf-8?B?dXFVRCtnWEVVWnZjVWJQc2x0b2FiVTBHRk1CMmhFTWpmREg5RVFxdGpNZFlz?=
 =?utf-8?B?RklINmdtTUp1cUJnTTE0QXNWLzNXR0k4NmJyV2RQTjk3R3p1enZybm5VKzVK?=
 =?utf-8?B?TUFjOXo0c1RNR0pCdFRoeXJpYnpRaWZEQkZRR0M1TTdDYkJhL0xsSGNscUht?=
 =?utf-8?B?Vkh0eHV6aHFwRHNpQnozMCtwOGVBOHIzc1NHRHlXNityWWVLcUI4ckFIcW8v?=
 =?utf-8?B?cXJaZ3QwY1BWUXg2ajhjdkJnL3RWcFEvZGpjT1VSUitSc3JBckxEZ1hpU1Fa?=
 =?utf-8?B?TGV5RU1nSFMra3FjOWw0TDdubXUrdEltREU0U2x2RmJEZ3Z5VEE5TGxjdFFM?=
 =?utf-8?B?Vi9YT1Y2U3lyYjhQKytXUWhWZ0k3ODNWNVpKQzhtNlR6Z1NLTmo3QUZ1a3Jp?=
 =?utf-8?B?aWo1YkJ5WkhOY051L0NWNURHcjRhL2Q2aVk5Rk1OLy9uek9SNzlOT3VUUllm?=
 =?utf-8?B?TE9EV1Zwd1YxTXVOYXVDdnpzeVRiRUV5NGZBWERnbDZWdWpnZ1JySjAzdGJP?=
 =?utf-8?B?Ym5RMk40bnhSZW1uQVQ5SU10K29ZUzR5QThLQ3g1NlpvWHl5ZDE0bjNBUngw?=
 =?utf-8?B?VnU3bEpJU09GRDZHOWpNbHRQK0IyUmZmSFljbFl3elh5aWJnV0VrUGJwUXYr?=
 =?utf-8?B?aDVLOHRlbEc1RWpEcUdvdDR1RFBZL0hYUWlrdEx5cjhPMnVXNDFjVjZQcmh1?=
 =?utf-8?B?WWRQdGx5b3lySExlbUR5WjNtSkVBR1hlTm80SFZrNTB6K2svZmdzcmtCMGNq?=
 =?utf-8?B?dEsvUGlzckR4d1AyK1VOT3FPSEZ4MGpYbEljeVJ1NE9qUU9MUUwzTFdxS09z?=
 =?utf-8?B?Y2s0QnN1MWYrc2VzVW9BTW1aVmtuQ0Z4Y3FVQmhlN0h3OXBVdUVWU0N0MTM5?=
 =?utf-8?B?UjhLL09ZSVp2YmRSMnVkU2VPYzhkSzQ3MHB4c05qQkRqdWpzQkN3TVVkbEpO?=
 =?utf-8?B?S29HcHU1NWw5ZmZnRjFpbUs4eDV5bHUrcFRBQjRmN01JK3h0NUpmdTFMU2ZW?=
 =?utf-8?B?NE5jZEdhMk5Pd1Jmb2l4SG1JUiszS1NhQkUrbzJIUHUyRU1LSHFBRExqMXBB?=
 =?utf-8?B?ZktDNW56WENhbUgxSGQydEM2dXhXQjF4QktpT3lLZTFJbUw1L055SnFjWE9q?=
 =?utf-8?B?MTBuYTFXOElXaERtV2RzQmJ0QnFZa1NvTU1LamxlTWlWRVV3VnAvZlpCWkg5?=
 =?utf-8?Q?wugweCxNn1SXtmXo3+3yeGbfDy8j71/A?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zy9tdE1nb05JakFuUmZlM3pIZGp3aFhDb2tnb1FLVVpzRFRWQWQrSE5aaVZy?=
 =?utf-8?B?dm52MVp2Rm8zRS93MXdhTlZ4d0JCczlBTmdQbE5vb05xV3lyeHQ2T24zVmJM?=
 =?utf-8?B?WFhpNENaZjVWbHBzcS9LcytFS0k1dDlQYjg5dmZPUEtHYnpTK3F2U1RxcFVL?=
 =?utf-8?B?OHQvZG1hN1BtSFl6SllpZHF2WC9jMEU2Vm1pbVo1anRmRkxjVythR3RKT1p5?=
 =?utf-8?B?RGJET3M1T3pFL2ZxbXA2ZThuMGIwak5ZNE9yZmxSTThCb3JwWll1VEV3R0pQ?=
 =?utf-8?B?c2hrUmd5VmtOSGlzOExJQWF0VjRWV2lsQTFXWVZtcERyZHdveEtwT3RIVE1R?=
 =?utf-8?B?ZlFUOVo2N1NwOS9NNmdwVkRHOFNRTWprZTRvd05TWjhwS3VFS29LbUpJT2hZ?=
 =?utf-8?B?UEtNUHQrVDZyckhEMFFFdk9rU2pGN2lVaUZucitEVlpwc3lWZzNZMXpIcmJr?=
 =?utf-8?B?dEZjWGs1Q1pMNVFadGdSb3FYN2VXZUhKd0xnVk1vTUNsTlEvVmZvOW1PRm5L?=
 =?utf-8?B?allRZXh1c2lET2p0MWR3WUZKVVZ5Y1JabGl6ajhUaHloZVlLS0RGM1grZncy?=
 =?utf-8?B?NTZ1STFOdDVSYzhoTlFYUFRrMTJLYkJ1WjVjcUYzVnlVOVdHVFZ6NWlPYTN3?=
 =?utf-8?B?WHk1ZlhGWWtWUzRlQmZVYURod1ZyNDMxd3JIK3VPUlFJY1ZKR0xjWjkyWFpm?=
 =?utf-8?B?VUdib0hxK3VqNHdhL3hUeVNJOWluS3NUK3dRL3MvWXlJdVhUaStKdU1EZGJK?=
 =?utf-8?B?dVUybUhUQVpOTDkzUm5XaW9RRGZydHhWd0swQXRLZ2N2ZzVTUVpiZUtTRFc0?=
 =?utf-8?B?Y1NXSElXQ1RSVDdEaEtubXVpWEhRSm1yTVd0cjNEUXlxRDBMaUdQUVY0R3V0?=
 =?utf-8?B?UFNzMHRReW5aUG5FYnM1ZUEycHYvalhPWTZNa3NkbVoyTDByOHVCQklOeUg3?=
 =?utf-8?B?ZUYxbkpnK0JmZnhibjhpOGU3c25vVXYzRldUK1BqaU9hRGgwKys5bWhSOXJB?=
 =?utf-8?B?Z1pDT1VDKy8xK1lUTGdZbmk5algweTllUWlsa0IzSzVlUlM4V1dJSDBSSDJS?=
 =?utf-8?B?NGNuRzR3WEQ2SmdUUFVFbnowWmtLRThIaENoWXRHYTZqK3ZER2hIRzJoamYy?=
 =?utf-8?B?OGc1TzkwdVVJN21JRkpTQ3VUclVuMG5wNlN4ZTVqcVBuWEJONVRzZHpNaDdP?=
 =?utf-8?B?Z09zYVRtRXU5ZUUveDV3amJ6MzV6Q0t1aEhLYnNRTHdBZ3l6bURqOWl0QTgv?=
 =?utf-8?B?dFEvQkd1ZldqeTBEQ1I3R2gwcEE1anNoSjUvZ1BWRnZqTTczZmR2MlJweEEr?=
 =?utf-8?B?NzkxZ1NsaG1VODdMZ0V1eCtMeFFJMXJVcEtENlhGTlpzbm5tV05hcTE4T2xD?=
 =?utf-8?B?Mzd1SmhMM1NQNUNhNGtCVDh3OG5INVI0Z2VQK2NxVkJoZ0V4cFlHcUxpdXR4?=
 =?utf-8?B?Z3cyekJzaFNKRDZNL3hJZGxreCtEMW5YNW9ZckwvNzNnQ1hkWGxMTVdEWEVT?=
 =?utf-8?B?UlVGMDFTUnpXV2NRMlI4UitZeHBuT2FaclJCbzJKK01NR0dRUmt3V0lSalZP?=
 =?utf-8?B?K3B1MFY1UlF4OEZQcnd1Q3RIL0pnK0RwTng0akp2YVJDNVEzRmU3bkRtUHZG?=
 =?utf-8?B?V1NsNURUTURvSHFNdXpqVGFQSkVkYlVVS1pqMVArNm96RmN6blBpRzdRSUpZ?=
 =?utf-8?B?eHl1MGNhUTR6VGRMTHl4TEVPdG5vMit1b2FiS0h6V3JmS0kzTFo3UW9yUmhZ?=
 =?utf-8?B?My9JcHlyOE1HZjRTRm9sQW1GYlZ3ZnN3TDRDY2M4c29uOVZSMU13c3NmaXo2?=
 =?utf-8?B?aWhKb1QvNVR4Qlhmbk9YR0pmOUF5NitjcFRZRUNjSWJmMzVZQkFqYVNFa2tU?=
 =?utf-8?B?aHBxbERCNlRxcytHaU42alorZnBGejlIMDc3T0I4aWQ0OWxSanBwd0NuVmg1?=
 =?utf-8?B?Z2JXTUZQR1JLSU9GNFdBQjRXVkIwSFJLK3h3eDBNOGtsT0pCRWQ3TlZwc0dv?=
 =?utf-8?B?TzBIZ0pMRlpyZWp0eStnNUkwTjdPZ0d6U1dxbmhTK2dQTjVJZXgva1FVbkFN?=
 =?utf-8?B?U2JlazNUaGR2aEpwOHMxU01IVnpndkhJcUo0bUFkLzVmaEQ5YkVhSUxTREJQ?=
 =?utf-8?Q?pvG5c5aPWmRq5AgYUXHIvsNzj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3d8157-cb3c-4ae4-3d93-08dd6d177eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 10:09:43.3690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwF0IIZG1mUNn15N0Ipqa6w0EGCzhWcGBxl4ZzoWVB3sxpBIYYvIoajAmlhOTc7WSsB6HC/PcGTmd6NGZlE5BlGQSA/b9eWPSMaBl/6HS30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMzcvMzddIHZm
aW86IFJlbmFtZSBWRklPQ29udGFpbmVyIHJlbGF0ZWQgc2VydmljZXMNCj4NCj5SZW5hbWUgdGhl
c2Ugcm91dGluZXMgOg0KPg0KPiAgdmZpb19wdXRfZ3JvdXAgLT4gdmZpb19ncm91cF9wdXQNCj4g
IHZmaW9fZ2V0X2dyb3VwIC0+IHZmaW9fZ3JvdXBfZ2V0DQo+ICB2ZmlvX2t2bV9kZXZpY2VfZGVs
X2dyb3VwIC0+IHZmaW9fZ3JvdXBfZGVsX2t2bV9kZXZpY2UNCj4gIHZmaW9fa3ZtX2RldmljZV9h
ZGRfZ3JvdXAgLT4gdmZpb19ncm91cF9hZGRfa3ZtX2RldmljZQ0KPiAgdmZpb19nZXRfZGV2aWNl
IC0+IHZmaW9fZGV2aWNlX2dldA0KPiAgdmZpb19wdXRfYmFzZV9kZXZpY2UgLT4gdmZpb19kZXZp
Y2VfcHV0DQo+ICB2ZmlvX2RldmljZV9ncm91cGlkIC0+IHZmaW9fZGV2aWNlX2dldF9ncm91cGlk
DQo+ICB2ZmlvX2Nvbm5lY3RfY29udGFpbmVyIC0+IHZmaW9fY29udGFpbmVyX2Nvbm5lY3QNCj4g
IHZmaW9fZGlzY29ubmVjdF9jb250YWluZXIgLT4gdmZpb19jb250YWluZXJfZGlzY29ubmVjdA0K
Pg0KPnRvIGJldHRlciByZWZsZWN0IHRoZSBuYW1lc3BhY2UgdGhleSBiZWxvbmcgdG8uDQo+DQo+
UmV2aWV3ZWQtYnk6IEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0YW5peC5jb20+DQo+TGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDMxODA5NTQxNS42NzAzMTkt
MzAtDQo+Y2xnQHJlZGhhdC5jb20NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0K

