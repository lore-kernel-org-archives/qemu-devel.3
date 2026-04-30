Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7DFCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMnp-0000mo-78; Thu, 30 Apr 2026 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wIMnm-0000mb-2b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:31:18 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wIMnk-000243-7v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777537876; x=1809073876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X+CmL8ARKAOrqShmdpz+q7BnbKMoTHRq3WiRT9rxx3Q=;
 b=DqdfepYmRW8N8lBUPDgp85jVZHofjpMs2XCIXjSmyyL0uZCK4YzgILHO
 wt73Q7jGjovpaqrTGhavkSzcN4NLnPfjeoZhVOMvK0Pvih59tg4esWX3B
 U1kA3yzdrAUjqt/7qTQUQaZSn1Vscg4pe2GnBEGxpjYcAFreI7sZNJlwl
 BCYhKwiO6CG5oEqCBsQXfxejH20HbxzFdWkHI/5kv/zb5ylFPJ8qYH0p4
 9UL4wqoR/GKS20QiGzuAO200K4F3b3NxCwG9R0q//qWcKV9x9fRJgjHRz
 mPLtlaYpEk7Jtf2sMgjb2E3Y8gEQFMsYaAAJWlurDbbvgxQkK+VTkO7SN Q==;
X-CSE-ConnectionGUID: DcWuGymTSGKLSqbRf2WD8A==
X-CSE-MsgGUID: bTNcrs+pSrq/oonkxTyRZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89857659"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89857659"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 01:31:07 -0700
X-CSE-ConnectionGUID: kwHh7qRLQZ6ZG/DJCqzODg==
X-CSE-MsgGUID: +MszszWxTO6S7A3waUO5tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="233680671"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 01:31:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 01:31:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 01:31:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 01:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNjomt+/6Xppy7z1WRZJSSMnCh3xK6shhqJuc6ceZ2TURHvRvm2xzNRp+kmWyj/qplGWVXlXMITfCGcnjbJ3AAkIR/J5z8DqNkGWdJjutiTThlk8cIIT/wB4nPzNyE1Yb1deWqIrA7oc0lSxkFRUDEnmml0wI0rZkwpNVssg6/UkFAREGytPnc2r2+sgBC9ZSd5/8ouY/NN/9ePb2Nqj3qKIqzeS8gS3F9DFfwiVi7q5lxrzyHfLsqJdoqX23YUweucf+z/qMDaL6nxAhTX5QpgvNxzGseuOPZnNRfWgwTYD8B0SoXrinGJgG+/uN+pf4yzLH30/hb/t/UwDKal0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec4BbIvCUxH3mQVx6ewH44TQm3IgXQiScjbRaIqNqRU=;
 b=MA2o3ar/Faq5AgzO69HgEEwGoUyWB+t3++OCCH/GrfJv5Fzg9ZjaPpGngdITYn8T2ESSTa5pzl2QNQ3VzewV9MFv/xXYAnv6yfbUScPBdiiFIeNW9DPk1W9XCHemSlQlAO1YRU8sfD3MHTYMlewkje+Ij4VLy0xkB+tfLB7cDH84pNFshobxAW591CbUXSHLna/Z4Enr7Xhl/J+TtubQHeAb/VhyXrTIrTv1gc2txq3zhMf4afBtRU0mSWmav+n0QfSHtxOb7aZD43WHPElsdeM01Vc4EoIBHEb6WoECdsPgSNrLzjg9GeBemUkX5IWTGpRsFzWkXZMTexGEZeOQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by CH0PR11MB8234.namprd11.prod.outlook.com
 (2603:10b6:610:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:31:01 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::60be:6463:f9c4:f41b]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::60be:6463:f9c4:f41b%8]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 08:31:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Cao, Junjie" <junjie.cao@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH v2 1/2] intel_iommu: widen impl.min_access_size to 8 to
 fix MMIO abort
Thread-Topic: [PATCH v2 1/2] intel_iommu: widen impl.min_access_size to 8 to
 fix MMIO abort
Thread-Index: AQHc0+QkF5ESGoU21UOa0hgTlinj8rXyYsIggARiiYCAAIaKwA==
Date: Thu, 30 Apr 2026 08:31:01 +0000
Message-ID: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20260424201842.176953-1-junjie.cao@intel.com>
 <20260424201842.176953-2-junjie.cao@intel.com>
 <IA3PR11MB9136A84869D0FA17B213347392362@IA3PR11MB9136.namprd11.prod.outlook.com>
 <20260430001607.3505699-1-junjie.cao@intel.com>
In-Reply-To: <20260430001607.3505699-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|CH0PR11MB8234:EE_
x-ms-office365-filtering-correlation-id: 7da47e7e-7db1-47b5-67c8-08dea692cfcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: /CP9a5Q9Q3/d8pemAehRiEevO6beRAsZ5JYfvUlrtzb4cMyuvvEa6SiiZt65gBo8/Z6AnyvD7ghE2D/y0G3LoIOMG35XFZ7mQz8w+nd2H6qlJjd0l7oGpY4XMIwrKgFwJLUtb3SSTnqozQm+8/xv9Xa+4BlEgAEpBzvA2s/vJIbaXWzFEbMG1ifnaFe1XpBfXhi0w12j0jPQQSmo7Q1PzUSWsHK4gDBqhkosQyvU8JX6KEHppdWhsfjoMbhEa8rjiYObIUh5B6kp/5qVccNus7lQYlr28r+KsembsMd25RcPYh1aGVpIraRyyMVsycJf5FkcNfESZfiOV/begx/naYr4+wiv/EmbVf+R9TcT5Vd6pR61+6nQnMzW5wbKXQS7PAqjTFcXqetDE78l4oGBN1jEQUSkXovz9UoX+GK8TCaYpkXZkeAwxMaM/aIiodYPSUYmi4W9gEN53cGmxToaZ5uOl4Ebr+zKzHrhXTm0nnDHq/ddvYrfwLrxlNZobdZnbEQvbHr/67M+L6EHaS4E0DWya3P7FtFDmdQC7WPFK0sq1pesZKMsLdR9igyl7JGzUzksyfbHPRypOzymZuGnEHvnVrZpklkiSI2hTBds/p7DQIbmi+tnwN2s1Dy71Z7f97cOb+BcI8/PsqiHkBZeuWW4VteOayrVsyfamc2ma4Wqf0PhTvV9RAAHQiUsbnFUeqoBpr+B++iE190zLBXn6jp4BH02fk5jrowZ7FpHE2V464I9TY4x1kGmX+xYO247+OPUluMxZ0ikCunIytmjZHWEHhP8tDn80KttC4/er/g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUNjE73WWwTu6TnH/DgAsPeRh1Y7+iIlBo/Vgaei4HPZdQZiArRUisVpwyUt?=
 =?us-ascii?Q?pMwYotYVSJ58bdkKIr0PAYdxSmTsszDB7OEz1Et2JDfd2rPTztZcbAj55E5z?=
 =?us-ascii?Q?dSi1bg0Xs5FJI5HdelxqbOcxFmBFEReY6KgpPtnYP6mW5lqOv6N5Urb9mK2O?=
 =?us-ascii?Q?YY12sVOHOPjFki/RUvNH87PXDlW+PWQubkQ5At/sAxC+xK7c3OtF3E/1QwZx?=
 =?us-ascii?Q?5pFg0Rcu+KG1Y/9TGj6r1IqgGaZZw1Fmwz0NAVT/rQgyMCtiCFaYDWtra+kj?=
 =?us-ascii?Q?+xILb/s34EJpqXqAIDnntrRj4BSnhCwYxRTfJdNq6IJ+LoO+eVEDc2MUibpc?=
 =?us-ascii?Q?wpB9KpQoAnqIuLuL8iCKZ8b389er8ngPuqkFVuqIW2MsacbcW/p2AVc6Tg8j?=
 =?us-ascii?Q?VVEC/yZKkNDZ5eVK6ebYF2RAN2YGO8EkK6pyCt43X3x+rSo6HpFn/UNAZAKe?=
 =?us-ascii?Q?kUC7rM/KwcyTkj1tAFWPsnLUswLGuk1090hzkmU9MeDUVgQeEv8R8NDZf/S1?=
 =?us-ascii?Q?mnXfOCNwxormPaoMU6v0pvIGXS/PeoRq/lxYbmoDgza6HeIySTiCTtsu0snH?=
 =?us-ascii?Q?8FUQEfpU3r5QhRP+fcLU2GndVhPyk3Bf9kPM8kJIW5+HxifBslz8IMMbZxQP?=
 =?us-ascii?Q?OVyYPsY2vj7c0EAh774dY+oMK1mqi2cvBfnf/HcuAUiMslNMd07nZ2ZOmMsG?=
 =?us-ascii?Q?3vhMSm/qIYCNznm9X8m5iX936mi59Hj9qRTK5+T75doLt1/JkXpM6DMWexF3?=
 =?us-ascii?Q?4t/TlmyQr4Rj0Fjcq9oGGuZPlTqop6fiGRKHZ7fZQX1HmtblUlRpGoFOVAkt?=
 =?us-ascii?Q?X3n22aSILoGGFw4GH7xvllK5otp9Up/X4sfoza06TlhozwVktIuwtXXnF7JP?=
 =?us-ascii?Q?P9xllDTtjDq7kQ0qcZyAq/nosk1HUoGkEPV2koIVHhJ3xV05ZMTOVFpLmcHe?=
 =?us-ascii?Q?KKtXklhBuyPmYTg7FyeUNxYscl5V6lF6KWCinW4NjdpsbUHf/apNzzJm6pOD?=
 =?us-ascii?Q?61eGzU1GB2TX4y9qx6pOfag0MsCbm65bdV7L1/uVRFW9sqS07CbQe+eSdw2T?=
 =?us-ascii?Q?itzN+miCcedyBgmTZ5G0Y6RBQteXmy4FKum7KL4ltSWWXQcbNnM+fdoovET+?=
 =?us-ascii?Q?SR0sjFhCxEV1UfOvEg9aP68YkmjFeA27cA8EMxqScPXxP6r81U4Jd9Czj+7k?=
 =?us-ascii?Q?dCGWo41oCfAQmwsObliI98OeTzCmzmTibkZZllxxTN/FyBUleDk53yQ/G9hF?=
 =?us-ascii?Q?yK9yahsiAMykhT+wnzrwl9Zr8BWr6jPzIb0XPndg95AGkfYPOYjDnsGxfSu1?=
 =?us-ascii?Q?P53gFrZMDaEcZhkskmA8aGp4y5g1PEcJaI0R+3CM12Q7EZq0IEzLcOuD/Qxb?=
 =?us-ascii?Q?Jf+uSxFuIoKtb/kXujm77xkpWULA13IWBSvCNKbtTpPK9QF7UqiFmL6LTOzC?=
 =?us-ascii?Q?LJssPj6hR2rKLBsNgeWxIPZQpSGYX/IXIBGuzEpd6GUOdf5iIIWCjB3kgZtV?=
 =?us-ascii?Q?IBu8Msu+Om+xUaqXJOwwGKoC2EMM8EkoA6Sb98qZnV66dL/DyukrROLlFPPX?=
 =?us-ascii?Q?cRJcw3m975u8pRnPI7L0ZRa9678qekz01agK//O9NDjBbMyv6DlDo/MPeV/G?=
 =?us-ascii?Q?J3VbvbKc+23Osr7/L8ifCw8oxxa8WmuASruE8NgoZOlHYJSqaQrLF3lRknb8?=
 =?us-ascii?Q?mQPA1i6/41Tkjmlmg1KF/qfHQq8MqPn0lY0cB4dDaEiq1ZSZiPHNPeUDwrzP?=
 =?us-ascii?Q?+Ud86KXTrw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NRBWXPRRxAbmiZ0W7MYzD7WQPXNV4ENKM3tbSa4lTd/LgQTb4dn+6AwT0/Pa3kPkIEgXUatURDzoNALP+w3KLntHw8ixEpOYsX9DknxAy0h7gfHBFWLHlICG0YSxei2hAqMytOvFQMJVlXgN534WBe8ece8MsLYNe5h9aMiXFEW05lw8nAzMpbDR9+KBo3dC2RhSCNvaA4OWvo+u/awYFU/lyrdE5tTNJFSsXBgccJH/e9N6TUz6YGsqzk+qRLrM/InDuw33Gtr9dOXcfJOUaRYZdvzRxosD8YF5w13pWEj8ncwobSFOAXRwA9byGXKlBNwoMkE5Om/hDIuM4Zx8fA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da47e7e-7db1-47b5-67c8-08dea692cfcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 08:31:01.4946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7UPwaMPw2CwaQb10WKQdpKOK1QdPUhAIaAgUqfORESO/8CXnn+70LbFGsf+mdNGtR1aGqo9d7A3EMeZrKFF3vmtBXL8D0AllFE/zu1to9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8234
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: Cao, Junjie <junjie.cao@intel.com>
>Subject: Re: [PATCH v2 1/2] intel_iommu: widen impl.min_access_size to 8 t=
o fix
>MMIO abort
>
>Hi Zhenzhong,
>
>Thanks for the careful review.
>
>You are right that the code path has changed.  With min_access_size=3D8
>the handler always receives size=3D8, so a guest 4-byte write to a base
>offset calls vtd_set_quad() with a zero-extended value instead of
>vtd_set_long().  Two effects:
>
>
>1. Triggers called unconditionally
>
>CCMD_REG, IOTLB_REG, and FRCD_REG_0_2 originally guarded the
>trigger on size=3D=3D8.  In v2 all three are still no-ops:
>vtd_handle_ccmd_write() and vtd_handle_iotlb_write() gate on
>ICC/IVT (bit 63), which the zero-extended write just cleared
>through the wmask.  For FRCD_REG_0_2, wmask is zero and the w1c
>bit 63 does not fire (val bit 63 =3D 0), so the register is
>unchanged.
>
>
>2. Upper writable bits cleared by zero-extended vtd_set_quad()
>
>Where the upper 32-bit wmask is non-zero, zero-extended val clears
>those bits:
>
>  Register       Offset  Upper wmask   Bits cleared
>  CCMD_REG       0x28    0xe0000003    ICC, CIRG, 33:32
>  IOTLB_REG      0xf8    0xb003ffff    IVT, IIRG, DID
>  RTADDR_REG     0x20    0xffffffff    address 63:32
>  IQA_REG        0x90    0xffffffff    address 63:32
>  IVA_REG        0xf0    0xffffffff    address 63:32
>  IRTA_REG       0xb8    0xffffffff    address 63:32
>
>  (IQT_REG, FRCD_0_0, and FRCD_0_2 have upper wmask =3D 0 -- safe.)
>
>This is safe because a guest must program the full register before
>the value is consumed: CCMD/IOTLB fields are set before the action
>bit (ICC/IVT) in the high-half write; RTADDR, IQA, and IRTA are
>latched only when a GCMD enable bit (SRTP/QIE/SIRTP) fires; IVA is
>read when IOTLB invalidation triggers via IVT.
>
>However, a read-back between the low-half and high-half writes
>would observe zeroed upper bits -- a real behavioral difference.
>
>
>Two possible paths
>
>(a) Keep v2 as-is, add comments documenting the safety argument
>    above.

This is risky, there is no guarantee that trigger bit is in upper register.

>
>(b) Stay with min_access_size=3D4.  Simply remove all 25 asserts.
>    21 sit at non-8-aligned offsets -- unreachable by any 8-byte
>    guest access (alignment check rejects them).  The remaining 4
>    at 8-aligned offsets (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8,
>    PECTL 0xe0) fall through to vtd_set_long() which implicitly
>    truncates the value -- safe and no semantic change.  All
>    existing size branches in 64-bit register pairs are preserved.

This makes sense. I didn't find what happen about 8bytes access on
4bytes register in VTD spec, but I think at least we can print a
warning for the remaining 4 registers, instead of silently truncate.

Thanks
Zhenzhong

>
>As I see it, both approaches are correct; (a) is simpler but
>changes observable semantics in an edge case, (b) is conservative
>with zero semantic change.  That said, I am happy to hear any other
>suggestions.
>
>Thanks,
>Junjie

