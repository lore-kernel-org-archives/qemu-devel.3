Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70B7F30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5DG-0007gi-Ho; Thu, 05 Mar 2026 04:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vy5D7-0007fh-T6; Thu, 05 Mar 2026 04:41:38 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vy5D3-0004Hf-1S; Thu, 05 Mar 2026 04:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772703693; x=1804239693;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pJIH2/pMVAkvaHrR0Jdqe/qHSIC54VBNYoEjsoDmpqg=;
 b=HQbOHDRHne/misnAWgovUp1v1VevGeZ862k3AVWit3PHoRBrXmvUyHcD
 Nu/TapmCOLb6Oqvsg8BE1fSvF/NeKjJie84mQVqdZH7HbUO46DwlTR8B3
 zPJAAo0mI6ParTPXi9MMCHRB6ao/+iCsj3mtOJ4sbPzFS6Hv66srNPzmk
 gslgsBLDXoae1W+AJTD0ql/befrMZQ2dxZrfMFizNJsf6ddpHS9nja359
 S0RBj6op00bP16fErN70gR25ROAmPcuNI+8bFSxwM1tAR/TRCXm8PKlFO
 KQzhNyDaBR8XvfCDDV1O57as5xRXDRFfcL0k5oubeYrY874p+Pnnjw+GR w==;
X-CSE-ConnectionGUID: JsNSSF8XTYaPhvYVdTSPFQ==
X-CSE-MsgGUID: hYEoKFiMR4ex96yQ627QFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84497658"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="84497658"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 01:41:25 -0800
X-CSE-ConnectionGUID: Eu1qiEaXTxOTIu5WIEsB9g==
X-CSE-MsgGUID: pm6SqEssR0Wiq55CkjcMXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="223117299"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 01:41:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 01:41:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 01:41:22 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 01:41:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+fDzg1iD7despfnZuBspSBJKYcu5teZqPIdzUg6nBZoSLdIMPXb7ilPblKEekfATW8jYlfuoawfvvePXEcyFdr/2kwF+qht5OJ8meVI7AM1BnKiY9hyW2j/XvroDdZxAu0VOTAylSqWaedknUM6Cel4medE53qPqPXUBPz0cGnt4TVBLZxcxHU+pKIZPoFdR7feu4Bis/foifAsGZNo8m3FHTmF56h4VLDA6nmfBQYe2DxARgBuAhqMBp+pxxDWEa9Yz2SxTfwr3jZrDxycGwCHysiRV11vxprto5nRMiXhFYSCh+RmIVa0sjlcZvZxEbeP6qYHv4VkZdqtCPJS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O631VLp4uLaydquyaRJKEieN16y/ZJxf5/uurpy5ohk=;
 b=T98Bf0SC/iJ3xO6XcJTdTAjXw/4W7QcfA1oqrhmmq6y6aAxhL/5oD20ohPc59Tw36mWg0lHmnzpUvznHmw9oarforILN+B5OvmwCcnuGAqC4r73aHf+OiY5wAI0zTsn6hUDen0EfSLbQPb54Xm9S8FVgSM2XJZw/dDz2wrTHo7/4ss3Ei8XIoUlTpJNnXXXHTbhThiLujA7aRUnuEdb3bUOipqS8DhcIjybi49xHyVAhb5tiOklSqVDpZUB1HeijcDmRrGtLC4QvPrpaof86P6iXrLQGVGtAOZ/sRBAlHn9MQ3Pze/EmUUJiiG7PL18gGiQeCr9hINPJSRGXyUfUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 09:41:20 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 09:41:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcpvxrPWY0EIaO2EyyMmxqBreJU7WXd1wAgAKmngCAANiH0IACyuCwgABrX4CAAYyLQA==
Date: Thu, 5 Mar 2026 09:41:20 +0000
Message-ID: <IA3PR11MB9136065890737254E6BFAFDF927DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
 <20260226084456.112142-6-skolothumtho@nvidia.com>
 <IA3PR11MB913652049863E1F32BE9C1319270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB754818FE668426F2078F25BCAB71A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91365D6AF54A9D44998A9BD3927EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB913663EA85A8B00DCEAB2301927CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB7548A4BD3DB9BE3D21E9BB2AAB7CA@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548A4BD3DB9BE3D21E9BB2AAB7CA@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: e6b490a9-5df8-45cf-bb33-08de7a9b5b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: LXu6d/eODgclNRN1mUJUbteEPrcZgBQ3aU6/r1o+hYhTU57K4cj4mGiqjBnR4GyVrvPVGVeahHK+yAeBQCeOLv2fTPFTQsYVSgUJdr57TQoaBdMXn0Put5WuAKtAp/QNgBKN25ZlX5Zv1awHXXTCOiVmZEMqNHoKowXsDWAmn8lOaKKuUi3MpMHLzq3O0fArZXFZBM8wYrSuufrlo5auHfqGgffbMq4HdPrmOd8Lx5E4DmxKbXFb9rcPnPoMbmwmsGans1QnEvUon5B1YyAZ8wt2gtytpBfjLNGGRytSTK6uZkYMFa3ecZg28aDS9Vo9l22HfGM6sItz+zolCAM/sj0ng2oBrqCmwndWJrxUXDGYRWnpOke8BByFx9rn9LJ+gg3GpV+DIE0ndDXwEIjmuqVRjRFfmZHvSHsharxvYSDrZpPrW9ajtYrEF0dOWsdzFbHUNzbT48X2irwlXjXDuukGS/Jt/l3FcEiGf8p4yTJ8/jwfLkc09KJ5R8BLph8HvDu+3H1XEqIyAlFPv5mkwViNaQVGZAVhRgw600NVZ4BEb+scl05xeTD5+WJRuDaAXrFuZvC4JC6mdyG6wnGN6AUnN4QA7oJs5SQW4JB07V7LyazoQkJ++5wbXn8i0vtPU4VvmZMEBXXg9SWaj5Ern3yOa/Ewi1YlL0Dx5DlWdERFRyg+u83f13iRaAcH+cmGQF/++lqGaxWgeKvOD4JZdAvH6nD5tf9XYBAf8GH2B8HlXSMIcszKEi61PmLbjQPn/h0YpL8yuekZkUK6HB9uPtC0j82oGqX5PWUNJXdYhO0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SMvxjG8ja/TO0C9x6sFBf+uLp+WoL2VVZZY9cO0AN99soYmPSSNYv1RrmRML?=
 =?us-ascii?Q?2VMU1PzOQJOcNWK4VN7Ua7LOtlprAZHd1Xl9sXpZNewGDR+Ro5TmLIn6Opx+?=
 =?us-ascii?Q?1jXK8y9OkCIvaApyYoyRfRUSzHMjIppk4GuKi9IsX2PTqGD9y1hRxv4xz3Uy?=
 =?us-ascii?Q?gg6CMYgGX4YIHBxYA6r4/lbs+dB1d4GBNCcKqBOwE2AWoRG/2LEyTx33h0i1?=
 =?us-ascii?Q?y/b9+qARaewMEtdy+N1I5EryaPmUMC6oDohLQ/T3ktUlixm4FO/6zfOGeLzN?=
 =?us-ascii?Q?XAzoH8tbFTxnlFvS18kw/tdJpXhCWleZ/D77CZXaYPW/I30arZylRH/NIynY?=
 =?us-ascii?Q?FOxfBm9ZvKu9ezNkev15NBTCBLbfKqokP7mqv3ArkhSb9xuQIHcTIvjlQY8X?=
 =?us-ascii?Q?o/CgXZh6M5zBY28M+gQ8ryCNqqwpeby0kvI644CvMjoHYk65LdRA+B4YH2p9?=
 =?us-ascii?Q?Jqlymvc1DNJJaZL/DSBQ9Qn6DBkEk2oBAQd+5CdFIAtP9N6Xgz9BS/oDI7fl?=
 =?us-ascii?Q?qomRWYQRWqzD7qNeb7Eb/tusa4h7UdwZYFHd7o/LWxIF3YwLr5RQfNfEA/Ja?=
 =?us-ascii?Q?dtUV1QE/rDFka3/7C8swY2PGiuj6vY992rYyVxM6ZUdT/3RKov3/iZ80Sdeb?=
 =?us-ascii?Q?gbqQGvJ6I1JKBFxxyQdzybx4Vh2ryeN8fVe9ZUbCmexAoePJDci2ONRXu3Kx?=
 =?us-ascii?Q?il97mSKyoLH/0NXvp/Qej7cIwWtQjH/fICViMom07zhkQdTG4QgMWQvZ7Dx3?=
 =?us-ascii?Q?mmCDJ3e4WcEZuPUw4aGoHkWXOCG7beJTe6Wh0RcnbyxYTob+4FLaa2+xWN9o?=
 =?us-ascii?Q?mBvlx+lEzewLQV2wsUaO0i8sA7TIuEidupnT1QccLSkQ86s0XemdsBfxTLFL?=
 =?us-ascii?Q?/kDDhh6gh6jMK3dNs8Jm6gt+WhyhsCvdLdi2IigBFWSu9BuZZc/ALw2L4Sme?=
 =?us-ascii?Q?PAYJUC7sdUXHnmVvXwwpC5//Va2sjpWpuD05fbLTb11A3RL+ZWoneNIXSHgy?=
 =?us-ascii?Q?JWAfszatziMlVy4VBYrjEtAEIHNbs6YcR6jtf2SMg91AAH+K9TLhsNPTPe5d?=
 =?us-ascii?Q?UUug2cygkx8rZuK9KjLJ23oAGfgwfwgQSBuSL0I6vvmYXWgCc26OJy4x3EXv?=
 =?us-ascii?Q?GLhPM0VNukNnoDKyYNZv5T65Lla+IcGe4PXkidDs3FOay6cBesUzoz+c3Gxt?=
 =?us-ascii?Q?03ixLJZWPJKowtgNoiowtWzYMWD9AF9xt0wYyvGF/PUKmIi+gA+RsaF0PpB8?=
 =?us-ascii?Q?DbcxmPpasn9LoTFkVPSOcgEP81Wk06E3fLEBnkMFH0g74Vgnj8vTaqDJuoUM?=
 =?us-ascii?Q?XbJcgFkpnly6y05ahJrievn2SVACxiXJ8hIGIoOc6sHnjFNmklt//SceJD/d?=
 =?us-ascii?Q?MnkM63llEzvu9S+0iyIhjJ5YqptVhcVPhA8GoOrqdMVPUKrZGnAjeAoEL/69?=
 =?us-ascii?Q?fbFcr72BjwsTGYjOWMcXDWI9GNfmODsMH9GSbzvV+iMDFgU2ooKi06hQEPL3?=
 =?us-ascii?Q?tJr126/4IqVTVv/VHQ0Vd03LLozaCxXtRn1GVE/sf1Vi53TOvo7oW/1Wg7XJ?=
 =?us-ascii?Q?Vb0b8t3rTuP4WKkC1yOSZFzPs+bspU+GPZDlmveFS29kJPMvO/A1U+4zyY+w?=
 =?us-ascii?Q?lDGAtieGodwDGk4+kcD33bnGo8eDofCr4pKItnVsUv2zoTT1I1fcMa7hvhKk?=
 =?us-ascii?Q?bfLLGqA08Pq1TeA9eH/b16nFaBI/cxwomEzq1AEVqAlT4LV/tiNQRJtaXaI0?=
 =?us-ascii?Q?bC5t39KR/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XCLutJZmmNp6E0aTVvqmdc/BTTHzStQL9u9sRpyqe6UUig0Qh4xlBmhVL1p7AskOMPp62XsGkZiqgdnVsLXHCEkh8z0rIgUfNZbf2C/VwuRI/2qEwGuG6pKwB6PU32soX6Rc8TYhE7pTrEmkLqpTrPb9fYdrn6mYE7XTCo7ukLL7RnQuwPjRg7bctUU2W+eQElQkH5wPwyx2axEGF5Zo5rE3tAL3RJPN0l1EZJatxH07WnsWuMeI7LVwsVvrLSTx2LEUTiDt72VAaIbRw+/qkWHj4eIz6+3C+UJgLUUvrrYksf+TLA/POJ4i0vNTSSb48pFiGzhIA28FKuf5CJSEhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b490a9-5df8-45cf-bb33-08de7a9b5b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 09:41:20.1396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/RVrYHcraqSUk28Xg6HDWPA4kXcKUKuOtlJgEqTPQWMLZCQhPPKxZcSFu/qoJSP78GWwPCneVj4fpNw70uTU7cfSJXGBQOUOYRP+bITKCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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


>> >Maybe this is a race case only in my scenario, I need to dig further.
>> >Thanks for your analysis.
>>
>> Sorry for the noise, find root cause, this is indeed a race case only in=
 my
>> scenario, because I need to delete fault_fd from polling fds in vcpu thr=
ead.
>>
>> While aio_set_fd_handler() indeed wake up the main thread from poll(),
>> but there still could be a small window we call free_id(fault_id) before
>> poll() exit and release fault_id file reference.
>>
>> I wrote below to make it work, in worst case I see free_id(fault_id) fai=
led once
>> and could succeed in second try.
>>
>> --- a/hw/i386/intel_iommu_accel.c
>> +++ b/hw/i386/intel_iommu_accel.c
>> @@ -206,13 +206,20 @@ static void
>> vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
>>                                    uint32_t fault_id, uint32_t fault_fd)
>>  {
>>      HostIOMMUDeviceIOMMUFD *idev =3D
>> HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>> +    int ret, try_cnt =3D 5;
>>
>>      if (!fault_id) {
>>          return;
>>      }
>>
>>      close(fault_fd);
>> -    iommufd_backend_free_id(idev->iommufd, fault_id);
>> +
>> +    while(try_cnt--) {
>> +        ret =3D iommufd_backend_free_id(idev->iommufd, fault_id);
>> +        if (!ret || errno !=3D EBUSY ) {
>> +            break;
>> +        }
>> +    }
>>  }
>
>Is it possible for you to use aio_bh_schedule_oneshot() here to force the
>unregister run in QEMU I/O handler AioContext instead. I think that is
>what this fn does( though I have not used this before).
>
>Something like,
>
>aio_bh_schedule_oneshot(iohandler_get_aio_context(),
>                        faultq_teardown_bh,
>                        data);
>
>and
>
>static void faultq_teardown_bh(void *opaque)
>{
>    data *fq =3D opaque;
>
>    qemu_set_fd_handler(fq->fd, NULL, NULL, NULL);
>
>    close(fq->fd);
>
>    iommufd_backend_free_id(fq->iommufd, fq->id);
>}

Good suggestion, I just confirmed this works fine for my scenario.

Thanks
Zhenzhong

