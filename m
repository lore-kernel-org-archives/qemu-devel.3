Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ACA1075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38rS-0002J3-Nj; Thu, 19 Mar 2026 04:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38rQ-0002Ib-VS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:36:09 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38rM-0001Mh-AM
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773909364; x=1805445364;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LdBTogFtK/i03eb9mTGM+BkuSGh2B79k7qDMcg8Ua/E=;
 b=dEDG96+CvsmKJi7rs5C2bNAAzwS7788bEaemwNKJwklNPXQZyD49v9Ev
 hHRa+vU2E0yDjg3IOJK0WIs70OvhtH8MLEf8plm+Skodz9VDvALeiJOUd
 8+gbmJFL0pfR1KrEqgANvI1ZDzaQ5PvgqmTwAuqMmjYxAgTecHCJwnfNe
 OIWhxoinnG8qDK4um/SXiVob/+AigSblMbiK/0V4lo3q9RopW2UQRgov6
 FMzIE6DYaEfslW2EZ31T9SBaBjBV72X7xNoNCPX9ISMyxibTrEbPB2PJq
 TXkNYldKffKBifeHQtezKlYMKbIXGlYMAOSUS8l1CXVoO6bD0IakcRm9b g==;
X-CSE-ConnectionGUID: uFr3peXURsqPZdJUuiuZZg==
X-CSE-MsgGUID: aSxT+s8tQF+cEuo1DgB0Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="77582794"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="77582794"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 01:36:02 -0700
X-CSE-ConnectionGUID: xAFX7OihSi2IB94w+1L3/Q==
X-CSE-MsgGUID: VOFn0HkET5umpkMsfQ8+Bg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 01:36:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:36:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 01:36:01 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDG+q+6pfYhkpX8FxSfi4fKcAM8mjwlyG5ZtceIqjBy+57WqO+MKLiEz0k+fbxY05FCJfWUiWmASfV55VQOHBT/voZKtce6ytriBoAmJJ31ovfzY0N7DJmPSRkFHax7zRt5QR0hvY6Tkpzkou+1oSETmapDL5uYomA2SdrxoKYHjoJWnNscGWyh0ZEwwlHBzlgf0YVMeRhXbOYNS1iJyIcsNzwQ8uD9SfznfNPDUM4zl9EDXtppAslGk+sCJ6JAp6AaBJX2pMPj43tCHeMAX0Kd/t9xA+M8dzvNwn4ftxc1C+oDJh8pvmiXFw4krcApaECvIOyF2JpsRCUpwUxzMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdBTogFtK/i03eb9mTGM+BkuSGh2B79k7qDMcg8Ua/E=;
 b=HJGlXkEcbNgX9UdAhiPyGKw0WO+HEW1eDx690oavcCGv9RonZLS9g9fIRGgg0qSU7rQEwLvg/O9adcK5rYBCRZ9XE3wxbnuw7LpDonrgeBOAakAZ9Y/meYuJNI6GqLkngXEsZHgOt1Q4Zj9UjKLgl30eL8AyXibdesWUqVmX+gw4EO44tKRX/Z0+CVOzaA8nt/gKBM+MxnnbqIfJvWjJwWr/YNstV8XjnTXXnDXjhKMjMyMijXAJu2nurAjMul85pweooP7UHB8rkpveNI6Ro6jKq/fDOxy6BhMpanSQI4624qraZ6VovDDC///t50jvWQyF9EZjxZYCJ4pQmmuWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:35:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 08:35:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex@shazbot.org>, "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH v2 1/2] backends/iommufd.c: report error when /dev/iommu
 is not available
Thread-Topic: [PATCH v2 1/2] backends/iommufd.c: report error when /dev/iommu
 is not available
Thread-Index: AQHctwIOggPiR2azlEeJpXfCllwWNbW1d5SA
Date: Thu, 19 Mar 2026 08:35:56 +0000
Message-ID: <IA3PR11MB913625F24F98AA40ABC7AE3F924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
 <20260318180641.1797902-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20260318180641.1797902-2-pierrick.bouvier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB7569:EE_
x-ms-office365-filtering-correlation-id: f6a7428a-b66a-46e0-7cbc-08de85928a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: gwYqwZRVfu11WdaIeoAkYWKDtmspywNhknju2A7133kfmx6skaE8C/+IIaqjUUXlbAyefUui462pGLNNJn0ky3tkOZnxWBI28Cn8VWfupwZxLuGa8lcv8saBYgQRa1mJ0WPD+bAsoUFoHInCDAE9aY5bv25hRl2elail9f8+DucUsov4noHEqdogs8st+avaQNP0o7H7klL4/IdBMRE1PdeztP4H3dh40Jm8JmMr9r1E5Bqb7Hz4e1TNiQjCiI1OoKf/y7EjwlSdL/GP3TX5vgVI4+5dqy0k6Hr1OOsbWL4kpH9Bq6fZETw9R3altpC8Nip/lqZIyuaynMMiiQZ+J6EOGPEsiSdaAmsripIFL8cyhFM9T2jHx1NWAs53dUIAW3zlwLkhq4NFlv5Z3umKHxflttJJO6kFtCzkNwNTa4sLMHbPH1GI08IvmL4gR0JrWmNU7bdP+jyWwx4g3JwwSYXNFE9lgeLh+uxkZO13he6m/LUAhtaaVHmnp3UiiHxjyqMYAE1njdmEnY2pBugbrFdTJcysD4eS9gxhb3xYqlIJrqEqde9CYAuLBldZeq7ru+3f3ti1ijYnb1Yst9BXDR1g2ySjvxY/f+58O75kG9+x9Hb3c0YZIRGUYLAqG9+qQRaZhapsBIPb/AQNlTPruXSm/WWnN6HzXBPeIoBAnIXIm33iRUEXmZDuvZINkNBiXXKDcEnO3mt0Sny5EQqPYDsw7str4fsds/kQRKrGsckYkYffiIuc+UWGgTYyiKxZNMPt+r5fl3rxF5Oy2u72DaN/hGp14qp0leVsjV4e0co=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEp6ZGo0RlA0WUNGRXJsT0lueU1sWkV0S2QyN3ZGMUZ0blhnQ1dTV3F0VWRO?=
 =?utf-8?B?dHNlWjYwcE1ZK1VtTXB3TGZHZDBPZ2dhTVUwM2FuREZoNmhXNEIyQVRac2Nu?=
 =?utf-8?B?TnZXdGxFdkVKbDh0YTNJWWwzNnA1dkZ3NDE0cEMyZDJZNDZBOXcvUW9UU09v?=
 =?utf-8?B?OTZvdSt6eXp1MkJ5L2hPaU9KUStVc3EyWFlMTVRIeW1ZTk5GYklndGwxZThJ?=
 =?utf-8?B?d2IxRzFuSVNJdDBJeFl6d0g1VEkySFRtaHFCNk5TT3YyWThWSVQvOFJ0d0do?=
 =?utf-8?B?aTExSkVOeVRkd08yYkFCdW1sWVg5YlREVEVBQWZlSHcxdjNQYk1TQ3pvcXE1?=
 =?utf-8?B?YjdIUGdkUnNYK2lGNDJUbXVNNkRiZklaU0dLaEpKSkNKOWIyZ2ZDb3BpMGpx?=
 =?utf-8?B?R2V5RFBadTFqOWhIcU1mRGVMTHNyZENMWUxxQjdHS2wzZkhzM3V0c0R0QXpm?=
 =?utf-8?B?YTIzVWt6Y2puaGRZa2RhQ1Y3RDRJQlRqSGFNRDlMcGhOTnRnbyt4eXNJN1cx?=
 =?utf-8?B?dHFzSGVXZm5ESCtVdjBHNGh6KzdxT0R0Q3k3KzBteDVqdmdEeFE5RTNwa2NM?=
 =?utf-8?B?UE5Kek5KVHU1Ym8yWGdhU09FeCtrejNVRFFXNTB6eVkzY1BYanBzWjlVT2Jk?=
 =?utf-8?B?blpOaWk0YVhHbC90eDltYnJVblpnc2IvTTZLMk9uK2hOdG1hVHZLcmpFdWZ2?=
 =?utf-8?B?dUVlVXNaWWJ3OG1tcGNieGp4SFNVREFTUi9zVHVxQWJCQTdTTFlxMFlaVmpY?=
 =?utf-8?B?Z0pCbUpYOU5kb3BPb2xGY1lxZHVYNHlFL2psQS92Z0w3MXNMYkdidVJsRUZ3?=
 =?utf-8?B?OUMzV014OFpycU9leXQwVThrTDRxcDBFSDNwT2xZQlVXQ2ZrTldTSTFXYkI1?=
 =?utf-8?B?YUFtMEh0V1NnQ3dBQ0xzSy8vTEJ2RlZORVZ1S3o4enBpQ0NWSGN2U1MzUm9Q?=
 =?utf-8?B?TFBnLzRSbFdENUxOcW9IQXVWbkNTa3lwRGZtUGU1VWN1M0ZxRThZWnVVQnd4?=
 =?utf-8?B?aGNRQ3l6WjJwU0lyQ1JLaDVaWFprbXBJK2lHYlFJQmFoaVNnblJndmV4emRm?=
 =?utf-8?B?T2JVaHBYOUxZVTFnbVlvV3IvY0EraUlJVlNDS05XRWY5aThsenpaRTBRVkF1?=
 =?utf-8?B?MTVUVHRVM2dCQm13aFpRQWpSejBuVm4wOXdheThKaDFzNzhUUmNpSmNDSjJu?=
 =?utf-8?B?Y0VSSnJaaWJJOHVoVWtIak1RTE43bXQyUWZVZkRzQnB2WGRraUpQY29vTVFh?=
 =?utf-8?B?dHVIRkF0MmFLNVp0QTc3aTYxcHE2REVKMUcxTjFKUUE2dTcrSDNUQ3I1RFRz?=
 =?utf-8?B?cUhSOHRxejVqTHB2MHh5bWlQUDB1dUVsNCtaeXlLQk9xUEJwRXR0VklmckFT?=
 =?utf-8?B?Y2pOK0psREEvdHQycDZnM0hPQWQ2L0pSQTdPVjBHdXgwb3J0SXhCZmNIay9R?=
 =?utf-8?B?NGE0cTJpRTBHWUR1dHhoUHZRWTBDSHNPbmg3ZytiSXQ0MlFESDdIc3lYV3VN?=
 =?utf-8?B?OExxaXpSSEI4bEtwcmNtR0F2S04veDZzaWVKeW9XUGw4WFJuOFFxQXVNY2ZS?=
 =?utf-8?B?RFczNGZlUEIvZWdBNkxpNHh2TGVUSm80SDc3U3U3NUtPVUUxNGFVaXBHMTBt?=
 =?utf-8?B?SWs0NHlneHFOTm9TQjB6clhoZldQd0Vpb21lajVkTTlFamsrR1E1cnQ5enJt?=
 =?utf-8?B?NndKNlQweWthNE5nZTRtNUJTOFFKdHVmd3dYVjBiZERkZW9IRnJyYUVudkpa?=
 =?utf-8?B?TGhocnN3SUlSSFlEZUx5emR3WGxwd2dza2pPbDFna0tBcGowTjg1Vk9RZEEr?=
 =?utf-8?B?RmxWL0d4Mld2L3RBVDVpaWpHL2NvSkVYZGpWSjFhQXRoRFFQQWhnTm1qclhG?=
 =?utf-8?B?dGRENEZXU1luRHBaU2ltSGZQTytJUnd3ZU9iU2U5b0diRWVYM1Q4ejlhN0dV?=
 =?utf-8?B?Z3VXKzZoUmZKTk9kOEhaWWhENHlKRGF5M1BQM21FZ1BhMnhCUFZsQ0VLOWU2?=
 =?utf-8?B?SEdyT05pNGhSbnB6U0pCeWR5bTBEbUx4blIxZHVsNHRSWE9OQlFpL2NXdGwx?=
 =?utf-8?B?YktiWjdxNjZmRUlGWVFpbjNRSmdPdWVXQjR1MFA0ekFkaC9hL29jTGdLeFRN?=
 =?utf-8?B?L296ZlJheDhKc1lKZjBha0dTS0h6UjNDeG5CVmJ3Sm9rb1lONnVNbXR2TkhD?=
 =?utf-8?B?R0o4YU9ac3g4RmVTaEZ2UUR5THdzNitWODVDS1dRR21IaVNicnFDZ0VKSFJX?=
 =?utf-8?B?ZHY4VkoxK1cyWjlNc0I0bnhYRkhnZjlqZnh5cm16c1kvOEJMNUgzTG5MTm1K?=
 =?utf-8?B?TktGeGxPVHR6ZkMyelY4OTNBbEVZb09PNGNjcUxBT2dDajNVSFdCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DXqjoelFLc1uia6oRcfc5SQcrS2sSC/yHtY4ZvzuewHfAs4yCk/J7oAMS8nsNTeNlEVpHtSYMtIAnufAP22vFE3GGJKdJO1z5EQSRi8S8aU4vzCu/jmW/QmEzuZWh3mCv9Vz+n1Sn3aMAVnvjzr9VqKNCQb9BdfLNg2W3Zbr1usor16iXeFYs4KGf4ubdIvxn5QzKW/stMU6UR+VZo7SiQHV/AZsV9E7zCrG9kiBkfQFofqsyo8pb/vkif1tV2EcSOLYgdoc88fcXaaOlfn4EHB/11X+F3vSaUz33wliVAuOYpc9C8Xr+S+hPj0i6kKC8f9X14Y45xz6YGgzcGINng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a7428a-b66a-46e0-7cbc-08de85928a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:35:56.0655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWD5fY4inWuIZya4tyoHUEKgnwHzDCxoQX8KJsiHy8IMCK7pktX4kbJjyzlXn7o5wK9Wv0EL/JUb8ZBs+PfVvNVy+JNwrL8PTXNKHnrZ3H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBbUEFUQ0ggdjIgMS8yXSBi
YWNrZW5kcy9pb21tdWZkLmM6IHJlcG9ydCBlcnJvciB3aGVuIC9kZXYvaW9tbXUgaXMNCj5ub3Qg
YXZhaWxhYmxlDQo+DQo+SW4gY2FzZSBjdXJyZW50IGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IC9k
ZXYvaW9tbXUsIHFlbXUgd2lsbCBwcm9iYWJseQ0KPmZhaWwgZmlyc3QgYmVjYXVzZSAvc3lzL2J1
cy9wY2kvZGV2aWNlcy8qL3ZmaW8tZGV2LyBpcyBub3QgcHJlc2VudCwNCj5zaW5jZSBRRU1VIG9w
ZW5zIGl0IGJlZm9yZSAvZGV2L2lvbW11Lg0KPg0KPkluc3RlYWQsIHJlcG9ydCBhbiBlcnJvciBk
aXJlY3RseSB3aGVuIGNvbXBsZXRpbmcgYW4gaW9tbXVmZCBvYmplY3QsIHRvDQo+aW5mb3JtIHVz
ZXIgdGhhdCBrZXJuZWwgZG9lcyBub3Qgc3VwcG9ydCBpdCwgd2l0aCBhIGhpbnQgYWJvdXQgbWlz
c2luZw0KPkNPTkZJR19JT01NVUZELiBXZSBjYW4ndCBkbyB0aGlzIGZyb20gaW5pdGlhbGl6ZSBh
cyB0aGVyZSBpcyBubyB3YXkgdG8NCj5yZXR1cm4gYW4gZXJyb3IsIGFuZCB3ZSBkb24ndCB3YW50
IHRvIGFib3J0IGF0IHRoaXMgc3RlcC4NCj4NCj5SZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPlNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4tLS0NCj4gYmFja2VuZHMvaW9t
bXVmZC5jIHwgNiArKysrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPg0K
PmRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj5p
bmRleCBhY2ZhYjkwN2MwMy4uMmMzY2EyM2NhMGYgMTAwNjQ0DQo+LS0tIGEvYmFja2VuZHMvaW9t
bXVmZC5jDQo+KysrIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+QEAgLTcyLDYgKzcyLDEyIEBAIHN0
YXRpYyBib29sDQo+aW9tbXVmZF9iYWNrZW5kX2Nhbl9iZV9kZWxldGVkKFVzZXJDcmVhdGFibGUg
KnVjKQ0KPg0KPiBzdGF0aWMgdm9pZCBpb21tdWZkX2JhY2tlbmRfY29tcGxldGUoVXNlckNyZWF0
YWJsZSAqdWMsIEVycm9yICoqZXJycCkNCj4gew0KPisgICAgaWYgKCFnX2ZpbGVfdGVzdCgiL2Rl
di9pb21tdSIsIEdfRklMRV9URVNUX0VYSVNUUykpIHsNCj4rICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICIvZGV2L2lvbW11IGRvZXMgbm90IGV4aXN0Ig0KPisgICAgICAgICAgICAgICAgICAgICAg
ICAgIiAoaXMgeW91ciBrZXJuZWwgY29uZmlnIG1pc3NpbmcgQ09ORklHX0lPTU1VRkQ/KSIpOw0K
PisgICAgICAgIHJldHVybjsNCj4rICAgIH0NCj4rDQo+ICAgICBJT01NVUZEQmFja2VuZCAqYmUg
PSBJT01NVUZEX0JBQ0tFTkQodWMpOw0KPiAgICAgY29uc3QgY2hhciAqbmFtZSA9IGlvbW11ZmRf
ZmRfbmFtZShiZSk7DQoNCkkgdGhpbmsgbW9yZSBhY2N1cmF0ZWx5IGl0IGNvdWxkIGJlOg0KDQpA
QCAtODIsNyArODIsMTIgQEAgc3RhdGljIHZvaWQgaW9tbXVmZF9iYWNrZW5kX2NvbXBsZXRlKFVz
ZXJDcmVhdGFibGUgKnVjLCBFcnJvciAqKmVycnApDQogICAgICAgICB9IGVsc2Ugew0KICAgICAg
ICAgICAgIGNwcl9zYXZlX2ZkKG5hbWUsIDAsIGJlLT5mZCk7DQogICAgICAgICB9DQorICAgIH0g
ZWxzZSBpZiAoIWdfZmlsZV90ZXN0KCIvZGV2L2lvbW11IiwgR19GSUxFX1RFU1RfRVhJU1RTKSkg
ew0KKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiL2Rldi9pb21tdSBkb2VzIG5vdCBleGlzdCIN
CisgICAgICAgICAgICAgICAgICAgICAgICAgIiAoaXMgeW91ciBrZXJuZWwgY29uZmlnIG1pc3Np
bmcgQ09ORklHX0lPTU1VRkQ/KSIpOw0KKyAgICAgICAgcmV0dXJuOw0KICAgICB9DQorDQogfQ0K
DQpUaGFua3MNClpoZW56aG9uZw0K

