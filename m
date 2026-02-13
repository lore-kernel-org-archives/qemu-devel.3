Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134BBEEA871
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 01:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqhsp-00048m-3K; Thu, 12 Feb 2026 20:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqhsm-00048Z-9Q
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 20:22:08 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqhsj-0001Vt-MK
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 20:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770945725; x=1802481725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t9Bmhd9HsYgaH5+AF33COuLJiAUDl4EPSG2aIVfcKo4=;
 b=P/nZ5CwbAc8pTNUuUhUKu12t58E1C0EVdF/7z8pSYQnFOgmixfscgiUr
 j1CXWnTwFpX6I0nrlfkmdkRmQ7IA38ktqPs+8m+YXk5txc3LSS7Zv08rC
 U31M6Jtu30QH9thFrGX2mf8dPeG8PXHR6+A5kSTCK2dOIxW++U63pTGGs
 YlynJZbRRqIX3JuYNQ1PXbxXUmQmxnM78wOhL8StsifrAcJ5qmQ6rRbVG
 SmT/94auAznKbLMGPbcM6MIxKW9g0Ory4ZHS9TYZy097Xl/Ge7Q56G0Nv
 uqzgM3oUDdYG9RGn8ocTCsfwf8e1uqVjkhHnGYdmTEbilcoGEv0h7YfFm A==;
X-CSE-ConnectionGUID: HcF/WqWSS8elTjj2qMV7Ww==
X-CSE-MsgGUID: QJ6luJVwRhKZiaAeDG0Upg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72230276"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="72230276"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 17:22:03 -0800
X-CSE-ConnectionGUID: lhijt1NlSTGKSZZE2qQYMg==
X-CSE-MsgGUID: Fv2/vKq1Q0GeR4yI/UWmsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="211709875"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 17:22:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 17:22:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 17:22:02 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 17:22:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQwp/gHAHjWS5J5sjihmrr+7HGIMc7jdqQovDkd1binMppdlh9Ff5mkciNsxrqrfYJbfmiEf2bopLcwWnHRSTd16yCV+95sE9VAJlDNnt9vNXM8ulSx4HnStkvmcgSz6Yun/oKcGC0Pn3evFu6yYv1cb0VNC+j3dJ+W23ClYbaurGn8r/hrCMopoTbximi+ECDLlWYY+A+GQ2CYYAfp7zx5czkGSuAVIKqCN6hbZDEsP2dyDgBmOKaeSvZwuwcMhZnzoSnRXORCW7fBZH/23OK3r6sQZMRrommvRBz/y24ijytXd+M619GKdXtTuQHmdNyF+kDnHtgMaQS5tf4a3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9Bmhd9HsYgaH5+AF33COuLJiAUDl4EPSG2aIVfcKo4=;
 b=dR1cXgfrgLJNg1j1AQpjZkyJOidLhF6NCK3xkGZHEWaylUaF0IZ5VKrnZYO271KC2Y+dljqqrxUpT9V+Ql1nktrvBLSDma7LgeJUfcXe7KRMyl5+ew1Ck8AIs0oH9nXGIyJm9xpAFqFxQJpuZh82gTiqApKBuVoCoEEBZGB7b/xQUBef7cJ33HU9tyQRleUTtl0fCRKkJIKUcwauCxanfgRutKOnZMMFE3u2gCUGWjFMNo6ubHsaUXIwoWmfsYUvZR5AiMbWDfN5seduM8sWaL01aOfrLKxWRclAevdQ2WGuPjdxHxunAwMKYNCD6YFdSuVbNMhHJZDUXq2rX/rhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 01:21:54 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 01:21:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool to
 uint8
Thread-Topic: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool
 to uint8
Thread-Index: AQHclk1PoAq5mUodfUSsvYfD19vxArV+uyyAgAACQKCAABNIgIABDNWQ
Date: Fri, 13 Feb 2026 01:21:54 +0000
Message-ID: <IA3PR11MB9136315AB6D784819ECF18C89261A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-6-zhenzhong.duan@intel.com>
 <4ecdbe5bb0b3a945b3534e8535186280aa8f4f66.camel@eviden.com>
 <IA3PR11MB913635BBC7B506CD40FADD779260A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <02bb4c9d859caec478e36d3c6cde6561ba3032ca.camel@eviden.com>
In-Reply-To: <02bb4c9d859caec478e36d3c6cde6561ba3032ca.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7374:EE_
x-ms-office365-filtering-correlation-id: 4f37d21d-9591-4600-d0ee-08de6a9e4622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bzBmcUVBVmtJN1YwV2NRODlFSTl1aEluMWc5K2pyQlMwdm9CaWhJY0N1SHRH?=
 =?utf-8?B?RExiOU92YXVkUTdtNExGOWRoTm45L1NXdHl0TzVUMVNyRHg5SzRwckNjT0R1?=
 =?utf-8?B?OE1reHZTdjVsUnZ0SXZTUzc3MlQ1OHh6T2xIWk9tSDFVZlZRRm4rTjdjOWZi?=
 =?utf-8?B?Y05nbGJ6bUdybFRQLzFocWJyYTJIcGhrb1B4Y0FFclBuemQ1ekFMVGNpdlgr?=
 =?utf-8?B?SSs0WExoYTRrMmxjUWQyOGc2eXFjeUZEWEp5SnlVeEFzdk9tbFJRVHQwVEN4?=
 =?utf-8?B?RTR2VGp1d0pKNGlmOEMrc1J4RFljQTl0bmpQUFdQemtPQ0ZDcTBCYi9lanB3?=
 =?utf-8?B?bVJkSUdzNitkdi9PQlpmbFIwZHQzTE80dlVJUGs2MVpPand4aVhuUDlkTFZx?=
 =?utf-8?B?V3BhQ0Z5T0hmWldzSkVhUVI2OG1DeWROSWlTbG9LV0plUTNDSndjOHZTVDdE?=
 =?utf-8?B?SzFCRC9iN2Y0Ris2Q0ZzNkZhUFpicnhRVUVWa0k5d1dUNXBrNVd6WVVOY1lB?=
 =?utf-8?B?MDNRMlRuamhhU0NEWDYrbnozQy8rOUxOdit3K1g5ZlZwSkZEWDFOanZXWE5B?=
 =?utf-8?B?TEdYY3RVb2NxaTBqek16UXg4dUxXenNmb2RBdFdNK3phdzJMeUV3YjlISG1t?=
 =?utf-8?B?RjhIQTFMN04rVUhJazFTZ21WckMwcVc2OEF2ZzhIeG1VelJIdTI5c0tGQ2sw?=
 =?utf-8?B?NElFVWdHQjVYWXQyNkliVEZqL2lqL3VldmFMRjh5dkd6OFdwSkpmeWRKVUxx?=
 =?utf-8?B?RzV2bW5vN1hSVVJ0bWlaWEl0T2R2aFpuUW1SQmZrUjRSV0Y1U3ZTTGRINFZq?=
 =?utf-8?B?MXJGbm1hK3ZCWmVUS2xLSGl0VnFCZm9UL3pwdUhPWkR1MytmSk80YjRrSU4x?=
 =?utf-8?B?MnpWQjVmdzdadlk3UEFacWlEazNma3ZjMlRtcFU3eTNOcFR4WTBSbXRFWjhU?=
 =?utf-8?B?MGl3dnBFa1hhOUw2bkdXd0pCRWc1THhvSThEa2lUSHVQTG9Ob05tWXAyaDdD?=
 =?utf-8?B?NUdGWUU0TERISmFzVERsMFBjdWFhenAvaFU1R2R6UVc3b2JsWjJNZUZLR2ky?=
 =?utf-8?B?M1FJQTdZeHFHWHFITE9vUzBMMjBCWGJXSXZhTGMrNEpmcW5vVVoyRFRJSHN6?=
 =?utf-8?B?aThTUXd2QnRMZnZkQ1Q3eEFDeVJBWnRGTkRwdldhbk5VeDl1QmdYbjZ3Zkwv?=
 =?utf-8?B?VnVNOFgyS1dFZzFUYnFZckJrTGZoSURxVmpGRlJZV3VCZVB2c3owclFoSWF6?=
 =?utf-8?B?RWptR2NROUVUaEVrMSsyS0Vhb2w2Q2p2Lzc1L0NvckxFQVFYT0dqVlVHMXBy?=
 =?utf-8?B?SHBycCtKeTBrWnpncWRKT2NaMk5HYjJDaUtudEpIait0OHg4c1QzSUhKNHZo?=
 =?utf-8?B?bC9HeS9LOVNLVHpSZEl5akJTSnhmeFBIODhDOENwU3NVL1hwT0R4N3NMaCto?=
 =?utf-8?B?N1RZZDFVRkI3V2NFK2xzWWl2K3BjNzMzQ2V0a3B4VzE4WGRGbEEwcWpMNEJt?=
 =?utf-8?B?VXlWVlRrYnVWYzBFTjJoL2dTSTNoOGc2bG1scUp4QUFjaitrV245K3VsUm5S?=
 =?utf-8?B?bWR2VmllalRJZGNnSnE3dXA5bW05NXNMeVVVMUYwQUlLdHJON2NrY1liamNO?=
 =?utf-8?B?NlF3SjVIa3dtbitzQUt1dEJOTDJKaU9wZ2pyT2JvSG91WlZOUDdGbnBmUklD?=
 =?utf-8?B?Z1lEVHZQM05PeGpncVdFcnZwdXpxL0tBdzB5QjFWVDdTN2xVZTduc1RXN3p6?=
 =?utf-8?B?WkhaVlV2UnFWUklHc0xBYVZuck91WU9CWU1PcjRzd1gydE9wSFE1R0FhcXFD?=
 =?utf-8?B?Y2NDZ2MrRVZFUzg1L2JsUnFyK0pZU09FVzFMaE05Q2k4OU5WamhabXM0Njl2?=
 =?utf-8?B?ZE9rSVdZRlY3TDNwRTdDS1pZcVBMUWIzK21SbEdmVVl4ZW82QTJwZmxEQnlX?=
 =?utf-8?B?QzZjS2diODJaRm8zQnVMU1FLNE1QcWp3emErLzdnMXFwK2VGNkFLY0dDUi82?=
 =?utf-8?B?Z3l1b2hpY3BwT0RjTGVXUy80U2tIQVBJOHJJLzF0elFZMmhWOUp4UXZFWnYz?=
 =?utf-8?B?Y2pnZlM1bjhBYk9FVFV0d0I1VlB1RHp6Ym9CeG1aUHFLdEwxV3Nacmo2OE4r?=
 =?utf-8?B?U1hjYUNYeEFtMTZXaEtsRWRKbHJPUHBsQy9VSlZFTExJS29xRElMODA2dlR4?=
 =?utf-8?Q?AonTCoqS2B38zY3vabbBniQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0RCakU1T1ZaK1JaM1pGdWxkUDNaS00wSkZLV2N5V2NTWmczb2YwQ2FMbElr?=
 =?utf-8?B?N0RKb0duaHhJWXRqTHcvU1VqLzJzSGNtY0Y0VmVUTzcraTlJYVdFbWs2NkJk?=
 =?utf-8?B?bi8wMWlNcGRZMS9hcVE5L1p3Sjc2dDNCUHBuSzlXQnVSTm5vL2Q1ZmI4dUlu?=
 =?utf-8?B?SldJNUwyS3B4cjRTNG9qMDl6VlcyZ1BORk1sdFJLUmVGVjh6ZmtSalZmd0x1?=
 =?utf-8?B?VlFlV084LzREVkowcC9jSUoyN0F4MHRsaVZJa2JraFY4TlhrVld4OHVZd2sv?=
 =?utf-8?B?WTBBNHBiNVRmZ0JycWxQYmRzZnJFUUNaaTZ3REFCMCsxc0QrV2NoNlhGY293?=
 =?utf-8?B?Z29wMzN4WlFhSHRhSDF2eWpvWDlDMDVFLzdKVFNiUG9ndkpOZ1k1RjdJeEV6?=
 =?utf-8?B?dVRrVXJNWFBjN2JCclZ6QWt0WTBOak9HUUd3bXc4cFJCYnR3SEExdWREUGFC?=
 =?utf-8?B?QWxHR1dIcFNYVkZzMjVaSmUyWVdJcWlUNktiZU9mWmM2b24zMklJMTBpQnlB?=
 =?utf-8?B?Z2lYcjI3QVV2NzJsa3JST2Q5NXZzYmsxS3Qrbnk0L0QrdmVHWFgybkdmQkEr?=
 =?utf-8?B?RFgvSi82S0lyYUgzQXE3bE1HZlpFYUtTVlJxblJEODNXcjNVcDlGbThkdzlI?=
 =?utf-8?B?ZERqNld0ejJvdGF0dEVGaitQV2NuMzlNTEJZbHIxcVhzRnIxWFFreUVldHhi?=
 =?utf-8?B?d1FOK0NIbW51VWcreGJjbFlSa0MvUXRIVzdDZ2dyZ0hPcWxkZU9kc1JBT0E4?=
 =?utf-8?B?UDhBb2VuTXlKeDAxWFRPOVdIbThkZ3BtbzEydEVubnZnbUJCek95SzhXOGJk?=
 =?utf-8?B?eEg3VUptb2Jwa1cxbjZ1YjU4WGdKUHEwRWIxUmxuWHJpZFVJZ1ZmUzdMeWJj?=
 =?utf-8?B?enRPaHEvVnRmY1MrOVNGb3A1WUNhOEFTVVoyZG1KQ3hzWGJmaUxLUk1ucnpU?=
 =?utf-8?B?NEYyS3lOck9xMmFaWFlzVDhWOWtUSCtJVnZKV1VKWm1PK0oyWTJrT1JzN0pF?=
 =?utf-8?B?MHl6aWF3S1hLUlZOVjNHNloyWSswRkUwRm9WblZmUEpRYTJWNlFXbVhTWTla?=
 =?utf-8?B?TTQ0TFBSWkpSczRMQkZ0VVdiR2E2RTE4NjE2dXdEdUZ4RG4wYlpYSWdCR3NH?=
 =?utf-8?B?NFhrbG5Ob2JiL2xrbXlLR2FSTDlFMjJVeEZXVnRRRzkzRHdYa3FrZ1RXTzRj?=
 =?utf-8?B?M3FSQnViSzE0VitRemgvWGwwdTRnV2dvZTg0MEZ3WlJXWHIxSjVrQVl2cU5O?=
 =?utf-8?B?a0lTR3RQZUFnNHEwQ3NsU1grcFlUNFZILzdUYUxSRk5SZFh4SVl3MUNwNWNH?=
 =?utf-8?B?V2dmeDUzQTI3Z09YNGtpRkcvODFpT284UEo2UVp1U2ZaT0VXc3Q1MVdTaTlH?=
 =?utf-8?B?WjkxdHZJVzNLdGY3VndTS2tXN0xGdEdDbEt2WklpNzRiQmZQTDJuWXZxSGJW?=
 =?utf-8?B?ckZIK2dZWlFFbXFKZnpyelMwNGR2RVZLRWF6TklONTNQZXJyWHV0RnF3Y1oy?=
 =?utf-8?B?MWlTMGJBUGt2bXYwazBmYWtJOE1wNWpqWkhxbzZpY2dZRk1tbDltVnZNSXVW?=
 =?utf-8?B?U2pTcE54SVlFcG9qTEgzV3Y0V3JQb0RNbWxORTZDQW1FTE9tUnlTRk9oSVJ5?=
 =?utf-8?B?UmRySUt5RlhlU0hQSGtkZkZlVGFkVzBSNjNvbzM1Sitwai9qbVFLQUxSbzdy?=
 =?utf-8?B?dWRkdXFpS1NuMlJiMVJkcjAwcnM0eENTOUJLT0hiRE8zL2ZWdjloOVNlVU1T?=
 =?utf-8?B?UnhLa0lOaGlXRlQ1c09acEdmcytXWkpKekhWR2VVQlJseHFXYTZPaW1UdDVr?=
 =?utf-8?B?NHFuWEVlT0JsU284YlZIcVhUNnMvSHRLSndmZVdBQ2UrdDExN2xpaG4wK0pW?=
 =?utf-8?B?OEF6T056NDNiS1c3d2ZSb09OQ3NSRmpSSmt4STlCUGlxZGRmLzN6K3RaeUhE?=
 =?utf-8?B?R0VhQUt0T2lWdGoveWNxNDZwK0JGV0JNSXYwZlV1T1pDVVBsRzhuTWtHQmoz?=
 =?utf-8?B?MnBvQnQ3MUI4R1NVM1gvTW91TitNd0lSRGswVnNlem9JdGdEUVlYQmtxa2Qz?=
 =?utf-8?B?YWthTTduSEU4b01BdGxFeUxmWFJ1V214a3BwaHpydG9XRE9WSDlBYW9oVWVY?=
 =?utf-8?B?YWNVMEsxZ2liditORHI5ZlA1VUdOYVNEUzlTTVBmUmF2VFdTNk1LOVl3OHpw?=
 =?utf-8?B?Q2NtajE1ZEhLdS81aHRlZW45dldaWmdOaFZqdkRyNDVmUXp3UVlmWXFrV1Bo?=
 =?utf-8?B?L2tPWVFQcStWZFYyYnBCT0ZYQ2djM0VpeE42WVhHSXd2RmpOdVhERjMvZWl6?=
 =?utf-8?B?NFJPT1I5ZGNFNE5ON09kaDFnb0E1dE5pRTVZa0RHM3FJVkhXeHNnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f37d21d-9591-4600-d0ee-08de6a9e4622
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 01:21:54.6982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WfYOf2ONr9VH50VOZaNOmYJ+hlX70dJa265vUAxpD8hEjkLUcFlQanh+lfLf49M8cVsL4DiaZPChlhVkcXFCnG50dpyGYT7OhuxoQaDx88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsZW1lbnQgTWF0aGlldS0t
RHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggMDUvMTRdIGludGVsX2lvbW11OiBDaGFuZ2UgcGFzaWQgcHJvcGVydHkgZnJvbSBi
b29sIHRvDQo+dWludDgNCj4NCj4NCj5PbiBUaHUsIDIwMjYtMDItMTIgYXQgMDg6MTYgKzAwMDAs
IER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+ID4gRnJvbTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxbY2xlbWVudC5t
YXRoaWV1LS0NCj5kcmlmQGV2aWRlbi5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbSk+DQo+PiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDA1LzE0XSBpbnRlbF9p
b21tdTogQ2hhbmdlIHBhc2lkIHByb3BlcnR5IGZyb20gYm9vbA0KPnRvDQo+PiA+IHVpbnQ4DQo+
PiA+DQo+PiA+DQo+PiA+IE9uIFdlZCwgMjAyNi0wMi0wNCBhdCAyMjoxMSAtMDUwMCwgWmhlbnpo
b25nIER1YW4gd3JvdGU6DQo+PiA+DQo+PiA+ID4gJ3gtcGFzaWQtbW9kZScgaXMgYSBib29sIHBy
b3BlcnR5LCB3ZSBuZWVkIGFuIGV4dHJhICdwc3MnIHByb3BlcnR5IHRvDQo+PiA+ID4gcmVwcmVz
ZW50IFBBU0lEIHNpemUgc3VwcG9ydGVkLiBCZWNhdXNlIHRoZXJlIGlzIG5vIGFueSBkZXZpY2Ug
aW4gUUVNVQ0KPj4gPiA+IHN1cHBvcnRpbmcgcGFzaWQgY2FwYWJpbGl0eSB5ZXQsIG5vIGd1ZXN0
IGNvdWxkIHVzZSB0aGUgcGFzaWQgZmVhdHVyZQ0KPj4gPiA+IHVudGlsIG5vdywgJ3gtcGFzaWQt
bW9kZScgdGFrZXMgbm8gZWZmZWN0Lg0KPj4gPiA+DQo+PiA+ID4gU28gaW5zdGVhZCBvZiBhbiBl
eHRyYSAncHNzJyBwcm9wZXJ0eSB3ZSBjYW4gdXNlIGEgc2luZ2xlICdwYXNpZCcNCj4+ID4gPiBw
cm9wZXJ0eSBvZiB1aW50OCB0eXBlIHRvIHJlcHJlc2VudCBpZiBwYXNpZCBpcyBzdXBwb3J0ZWQg
YW5kIHRoZSBQQVNJRA0KPj4gPiA+IGJpdHMgc2l6ZS4gQSB2YWx1ZSBvZiBOID4gMCBtZWFucyBw
YXNpZCBpcyBzdXBwb3J0ZWQgYW5kIE4gLSAxIGlzIHRoZQ0KPj4gPiA+IHZhbHVlIGluIFBTUyBm
aWVsZCBpbiBFQ0FQIHJlZ2lzdGVyLg0KPj4gPiA+DQo+PiA+ID4gU2lnbmVkLW9mZi1ieTogWmhl
bnpob25nIER1YW4NCj4+ID4NCj4+ID4NCj48W1t6aGVuemhvbmcuZHVhbkBpbnRlbC5jb21dKG1h
aWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pXShtYWlsdG86W3poZW4NCj56aG9uZy5kdWFu
QGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSkpPg0KPj4gPg0KPj4g
PiA+IC0tLQ0KPj4gPiA+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMSAtDQo+
PiA+ID4gwqBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaMKgIHwgMiArLQ0KPj4gPiA+IMKg
aHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArKy0tDQo+PiA+ID4g
wqAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+ID4g
Pg0KPj4gPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5i
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gPiA+IGluZGV4IGEyY2E3OWY5MjUu
LjcxY2IzYjY2MmUgMTAwNjQ0DQo+PiA+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+PiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiA+
ID4gQEAgLTE5NCw3ICsxOTQsNiBAQA0KPj4gPiA+IMKgI2RlZmluZSBWVERfRUNBUF9QUlPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgMjkpDQo+PiA+ID4gwqAjZGVmaW5l
IFZURF9FQ0FQX01ITVbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxNVVMTCA8PCAyMCkN
Cj4+ID4gPiDCoCNkZWZpbmUgVlREX0VDQVBfU1JTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICgxVUxMIDw8IDMxKQ0KPj4gPiA+IC0jZGVmaW5lIFZURF9FQ0FQX1BTU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAoN1VMTCA8PCAzNSkgLyogbGltaXQ6IE1lbVR4QXR0cnM6OnBp
ZCAqLw0KPj4gPiA+IMKgI2RlZmluZSBWVERfRUNBUF9QQVNJRMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICgxVUxMIDw8IDQwKQ0KPj4gPiA+IMKgI2RlZmluZSBWVERfRUNBUF9TTVRTwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0MykNCj4+ID4gPiDCoCNkZWZpbmUgVlRE
X0VDQVBfU1NUU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNDYpDQo+PiA+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Yi9pbmNsdWRl
L2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gPiA+IGluZGV4IDZjNjFmZDM5YzcuLjVlNTc3OWU0
NjAgMTAwNjQ0DQo+PiA+ID4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+
ID4gPiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gPiA+IEBAIC0zMTUs
NyArMzE1LDcgQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+PiA+ID4gwqDCoMKgwqAgYm9v
bCBidWdneV9laW07wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogRm9yY2UgYnVn
Z3kgRUlNIHVubGVzcyBlaW09b2ZmICovDQo+PiA+ID4gwqDCoMKgwqAgdWludDhfdCBhd19iaXRz
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBIb3N0L0lPVkEgYWRkcmVzcyB3aWR0
aCAoaW4gYml0cykgKi8NCj4+ID4gPiDCoMKgwqDCoCBib29sIGRtYV9kcmFpbjvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBXaGV0aGVyIERNQSByL3cgZHJhaW5pbmcgZW5hYmxl
ZCAqLw0KPj4gPiA+IC3CoMKgwqAgYm9vbCBwYXNpZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qIFdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLw0KPj4gPiA+ICvC
oMKgwqAgdWludDhfdCBwYXNpZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IFBBU0lEIHN1cHBvcnRlZCBpbiBiaXRzLCAwIGlmIG5vdCAqLw0KPj4gPiA+IMKgwqDCoMKgIGJv
b2wgZnMxZ3A7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGaXJz
dCBTdGFnZSAxLUdCeXRlIFBhZ2UgU3VwcG9ydCAqLw0KPj4gPiA+DQo+PiA+ID4gwqDCoMKgwqAg
LyogVHJhbnNpZW50IE1hcHBpbmcsIFJlc2VydmVkKDApIHNpbmNlIFZURCBzcGVjIHJldmlzaW9u
IDMuMiAqLw0KPj4gPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+ID4gPiBpbmRleCBlOGE2ZjUwYTVhLi45MTZlYjBhZjVhIDEw
MDY0NA0KPj4gPiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gPiA+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gPiA+IEBAIC00MTUxLDcgKzQxNTEsNyBAQCBzdGF0aWMg
Y29uc3QgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4+ID4gPiDCoMKgwqDCoCBERUZJ
TkVfUFJPUF9CT09MKCJ4LXNjYWxhYmxlLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsDQo+c2NhbGFi
bGVfbW9kZSwNCj4+ID4NCj4+ID4gRkFMU0UpLA0KPj4gPg0KPj4gPiA+IMKgwqDCoMKgIERFRklO
RV9QUk9QX0JPT0woIngtZmx0cyIsIEludGVsSU9NTVVTdGF0ZSwgZnN0cywgRkFMU0UpLA0KPj4g
PiA+IMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1V
U3RhdGUsIHNub29wX2NvbnRyb2wsDQo+PiA+DQo+PiA+IGZhbHNlKSwNCj4+ID4NCj4+ID4gPiAt
wqDCoMKgIERFRklORV9QUk9QX0JPT0woIngtcGFzaWQtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwg
cGFzaWQsIGZhbHNlKSwNCj4+ID4gPiArwqDCoMKgIERFRklORV9QUk9QX1VJTlQ4KCJwYXNpZCIs
IEludGVsSU9NTVVTdGF0ZSwgcGFzaWQsIDApLA0KPj4gPiA+IMKgwqDCoMKgIERFRklORV9QUk9Q
X0JPT0woImRtYS1kcmFpbiIsIEludGVsSU9NTVVTdGF0ZSwgZG1hX2RyYWluLCB0cnVlKSwNCj4+
ID4gPiDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJzdGFsZS10bSIsIEludGVsSU9NTVVTdGF0
ZSwgc3RhbGVfdG0sIGZhbHNlKSwNCj4+ID4gPiDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJm
czFncCIsIEludGVsSU9NTVVTdGF0ZSwgZnMxZ3AsIHRydWUpLA0KPj4gPiA+IEBAIC00OTgxLDcg
KzQ5ODEsNyBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0K
Pj4gPiA+IMKgwqDCoMKgIH0NCj4+ID4gPg0KPj4gPiA+IMKgwqDCoMKgIGlmIChzLT5wYXNpZCkg
ew0KPj4gPiA+IC3CoMKgwqDCoMKgwqDCoCBzLT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEIHwgVlRE
X0VDQVBfUFNTOw0KPj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBzLT5lY2FwID0gVlREX0VDQVBfUEFT
SUQgfCBkZXBvc2l0NjQocy0+ZWNhcCwgMzUsIDUsIHMtPnBhc2lkIC0gMSk7DQo+PiA+DQo+PiA+
DQo+PiA+IEkgdGhpbmsgdGhpcyBpcyBhIGJpdCBkYW5nZXJvdXMsIHRoZSBNZW1UeEF0dHJzIG9u
bHkgYWxsb3cgdXAgdG8gOCBiaXRzLg0KPj4gPiBXZSBoYXZlIGEgY29tbWVudCBuZXh0IHRvIHRo
ZSBkZWZpbml0aW9uIG9mIFZURF9FQ0FQX1BTUyBhYm91dCB0aGlzLg0KPj4NCj4+DQo+PiBDb3Vs
ZCB5b3UgZWxhYm9yYXRlIHdoYXQgZGFuZ2Vyb3VzIGRvIHlvdSBzZWUgaWYgcy0+cGFzaWQgPiA4
Pw0KPj4gTWVtVHhBdHRycyBvbmx5IGFsbG93IHVwIHRvIDhiaXRzLCB0aGVuIE1heCBQQVNJRCBX
aWR0aCBpbiBlbXVsYXRlZCBkZXZpY2Uncw0KPj4gUEFTSUQgY2FwYWJpbGl0eSBSZWdpc3RlciBp
cyBubyBtb3JlIHRoYW4gOC4gRW11bGF0ZWQgZGV2aWNlIHNob3VsZCBuZXZlciBzZW5kDQo+PiBh
IFJlcXVlc3Qtd2l0aC1wYXNpZCB3aXRoIHBhc2lkID4gMjU1Lg0KPj4NCj4+IEhhcmQgY29kZSBW
VERfRUNBUF9QU1MgdG8gOCBiaXRzIHdpbGwgbWFrZSB1cyBub3QgYWJsZSB0byB1dGlsaXplIHRo
ZSBmdWxsIHBhc2lkDQo+PiBzcGFjZSBvZiBwYXNzdGhyb3VnaCBkZXZpY2UgaWYgaXQgaGFzIGxh
cmdlciBNYXggUEFTSUQgV2lkdGggdmFsdWUgaW4gcGFzaWQNCj5jYXBhYmlsaXR5Lg0KPj4NCj4N
Cj5UaGUgcHJldmlvdXMgYXBwcm9hY2ggd2FzIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBrZXJuZWwg
bmV2ZXIgYWxsb2NhdGVzIGEgdG9vDQo+bGFyZ2UgcGFzaWQNCj5ieSBsaW1pdGluZyB0aGUgd2lk
dGggaW4gdGhlIGlvbW11IGluc3RlYWQgb2YgZG9pbnQgaXQgaW4gdGhlIGRldmljZXMuIFlvdXIg
cGF0Y2gNCj5zZWVtcyB0bw0KPnJldmVyc2UgdGhlIHByb2JsZW0uIElzIGl0IHNvbWV0aGluZyB3
ZSBhcmUgcmVhZHkgdG8gYWNjZXB0Pw0KDQpOb3QgZ2V0IHlvdXIgY29uY2Vybi4gRGVmaW5lIGEg
aGFyZCBjb2RlZCBsaW1pdCBsb29rcyBhbiBvdmVya2lsbC4NCkhvdyB5b3UgZGVmaW5lIHRvbyBs
YXJnZSBoZXJlLCBsYXJnZXIgdGhhbiBNSU4oaW9tbXUuVlREX0VDQVBfUFNTLCBkZXZpY2UncyBN
YXggUEFTSUQgV2lkdGgpPw0KDQpJSVVDLCBrZXJuZWwgc2hvdWxkIHRha2UgTUlOKGlvbW11LlZU
RF9FQ0FQX1BTUywgZGV2aWNlJ3MgTWF4IFBBU0lEIFdpZHRoKSBhcyB0aGUgdXBwZXIgbGltaXQN
Cm9mIHBhc2lkIHJhbmdlLg0KDQpXZSBhbHNvIGhhdmUgcGF0Y2gxMiB0byBlbnN1cmUgdklPTU1V
J3MgcGFzaWQgdXBwZXIgbGltaXQgbm90IGJpZ2dlciB0aGFuIGhvc3Qgc2lkZToNCg0KQEAgLTY0
LDYgKzY1LDEzIEBAIGJvb2wgdnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpz
LCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLA0KICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
ICAgICB9DQoNCisgICAgLyogT25seSBkbyB0aGUgY2hlY2sgd2hlbiBob3N0IGRldmljZSBzdXBw
b3J0IFBBU0lEcyAqLw0KKyAgICBpZiAoY2Fwcy0+bWF4X3Bhc2lkX2xvZzIgJiYgcy0+cGFzaWQg
PiBocGFzaWQpIHsNCisgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlBBU0lEIGJpdHMgc2l6ZSAl
ZCA+IGhvc3QgSU9NTVUgUEFTSUQgYml0cyBzaXplICVkIiwNCisgICAgICAgICAgICAgICAgICAg
cy0+cGFzaWQsIGhwYXNpZCk7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg==

