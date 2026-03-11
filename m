Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D291062868
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Hk1-0004dF-CC; Wed, 11 Mar 2026 07:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Hjz-0004ck-An
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:28:39 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Hju-0004K3-Sp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773228514; x=1804764514;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/7gYF/OpFsTgaRmZR2SFtdPnjkSl+jvFx7aN8UJTz5M=;
 b=HGmPtvEOKwwdhELLMDpjb8NnPJx05x9mKexZmhUwlYoQl0MZmQJk5Lv+
 Ny9M6tp21D5BP80mxKKC6fBmB9st3aey2cLsodKlG9ASqnL974HbMsF5k
 3GFos+Ayot+7Mklq/oN98EqGUEtwEOQDfR+8VkTS8vQ9LTPaXVO/EQhE/
 R1Q79lC7zU7oMLN5gw1k91rU3B/gyY2obdR5x37uYi1TCQnHsiknARB6p
 h3t06E9FYZOR1cqyelE0gkmdetbz4MZSmdiAtpWyoIxD0yZs3M5UcPgFn
 J92bB//2DPGxLtycKux6s9NdDqiiQm20YRs//1MmqDEysw9RAc7DPZm8V Q==;
X-CSE-ConnectionGUID: pUo14cvtQNuUv+qvT0vLpQ==
X-CSE-MsgGUID: napzgBKQQ6SqvrlgCbvDgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85379713"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="85379713"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 04:28:30 -0700
X-CSE-ConnectionGUID: LjcaM4/sS6Wf/kEincFhCg==
X-CSE-MsgGUID: 7joXcyPRTuWoJYj/JRp+Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="220489972"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 04:28:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 04:28:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 04:28:30 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 04:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t72wZtCoNJyhgPKnXap7Hz7nRQt7Jt1UX7PEst4Vo0Hxxrv5G2jRUZc+Gqzs1hadhFroyQbwUluSCy4f7OiFYehKBMuyWNny6ZBE5PKSsNEv1oZDeDF70VaXxWaFqMe6K512oSmKXs/fs13bVsFaO/W7EDKY0anoZwD2UJW7Pc4dhbP1qLmED/gv+ufJEnZm6tUuqbYRDNHmncyO8MJFUEw46MgMDh5Ogdl8Num/GBHaR2Ajpt60WELoqaIqyIxj4pIHF7uTZvYSXJuEV8e6UUZcyaJ3nTzYcql5ax4LvjUi17VaYKbog+UbFxbXY/KXjjR115DyG6JMVwbftjZgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FCaS5zkzI8dSFCpfukIo18WpjeX+wVCOB6aWem2+Sw=;
 b=xpiKAF2B5KRbcKbbu33rYTZS2JlN/i5ruXpItF4IItjXcQdZZ/vQQOmFjkAay4d04YNX38E+xVffa2L3p2Tkgd9PPINIeLVe7pCcd+GUZlXGpE7O5Z+y/i7V3Jw/tmRZZO03u7M2VYilYCSEQUy3K1PP4YtJNjhTLSwA37K8IE+fBzKOuRVjNtMKTwbj7wMHwAagiT7/hTJwihTiBmo5u9CO+UTc1cpQeX7zvm196eMIMFowX3366gDgQR4ZzaW+eG2tFCo6p4If95uJ7xnUkqs/A7ySdKwWq1MzqapPuujqcuxW+zMZXFSc+66Uf1lgb/1LD+pvno1/V3epPU8//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 11:28:27 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:28:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Thread-Topic: [PATCH 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Thread-Index: AQHcsFs1MilwJ9N4xkKEKYcTHT2CkbWpM0jQ
Date: Wed, 11 Mar 2026 11:28:27 +0000
Message-ID: <IA3PR11MB9136DC3AC6B7C1696CB618D39247A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
 <20260310065644.426838-2-clement.mathieu--drif@bull.com>
In-Reply-To: <20260310065644.426838-2-clement.mathieu--drif@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5995:EE_
x-ms-office365-filtering-correlation-id: 54c38279-20e3-4e7a-4871-08de7f6150b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ylkUkn/tRnGI+Asqiyha3y43V91k6bnD39x+R72X2YbscO9r9r/boryns+E0JmVLNRqofEVo3M1Jfyqb9CzI22chVj9roAWfV2HpCMi3z+DxlT2G25uYjXVSR9+UFKklEBB5SYSZ1JBfOF799ln4mvRsRI4P7PTkt9EUzvfOBKJy47/D+tHQxPDa+gCwqPyjzP7dkloiqCPMQ/wEJXCvxrN7hkPVIdv4JMKYE3pz4gvpm+J5yN1wZl2CZ7m0whGhSoKSaBiSbtOxEjaEyfiVDdttzT33xHwBhGsidcm2Oe1QFtB3qtyQhj/M5teKWtVeafjPSzdQ5qdF8ToEViIpIsFZYti99/jWYdaldGXhvIMui8vg6j5XpLHpcsHUFQzBgrPONlrzoxyHo83GHtCbeQAAsRl+jPG3yra53WKcQqyvjLLzCnjk1+lc27smEBFkq9B8zb3Rq+fBe7ZHd19VNtzq/hk9arqYn07Av2PAOk2cUb+yhCYEBMc+KLWpoKSGW+ChYYnp1OpOsrslkff8DwCoeNixB81062edtKVTivI+xAO3/HAkmqSg9jlvuaeOl/v3XwB8eXpK2la13z1w7YVcavvUiq/3aYycTncmuCzT74yteOplG4QAFMS6ChIWusF98Rkf0BMB+EdsuzbB1rItfiaqPBFrm8Tk3VCjPjd94JLazFmuFmpZYkgYwmQonsv/YjgeUaDFpzSnNqFF9vHvUh1JjDxcqNQXqfEeFa/wg8/zELgFABCMLnHdYXpmF6/YeYIyg9VHDbXf4h80r2jR3Jepqplf2H+WJNjcsrs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D+f3Vrfn2TAqDgUAoXhojCE6/1HRIFtCIP3jAEW4IzBbBJqB6VUpdMFCdQxu?=
 =?us-ascii?Q?u94EscU4W1wHjBYqs9TQHu/5v0ok3nmfSN6upIFJtAFgMYBRCON/J50qhW0p?=
 =?us-ascii?Q?wcYIcWxKRdUHM1Bq+026/jU6+n4ZwU6qco8cYCw8CiFsvvCqgNXvrXLLV6Cg?=
 =?us-ascii?Q?+PWgSByee/4BVeptSRSSC0nrQ58h+HIlSh4U5nx5NAYOgDNYPHMV8Wke9JNT?=
 =?us-ascii?Q?uk7wAOjJ29OvkXV9oepq1I1iUWFPop/EH5xVkGL0QrBa2wKI5sHsAK4gSLxS?=
 =?us-ascii?Q?AS7LqLOwE38gxx/KPRwkqjCaeHG3uvw+7h9IDCYh3ApAJXkjmqjbmm6RcqsJ?=
 =?us-ascii?Q?GN50M7UzX/7dRssjyFbWs2rFOGWRzrw3SA6XelqTioDHMb/xUewJJ330NXUZ?=
 =?us-ascii?Q?OVYHYro+77csyeHuHa93djAeWto6wiTkY8MD0gwvdwvLR8PWXADR0xGK2QR2?=
 =?us-ascii?Q?DyMhuGm9mM18IRi0aF2Zz8Yg8koLNVAnMuReLqk0WdPTpmKVNKSxFjyTZJkY?=
 =?us-ascii?Q?fjmjFKAq3Y8sKYMR1YPoR1JENufkl/P5z5hDV30dB0rRuqky500t38XJnxLQ?=
 =?us-ascii?Q?ikhSzESd8z7k96YtIZQUFE/IWLTQDZAc8B2noVUNmr/9m2Hpo2kVWel/a+FP?=
 =?us-ascii?Q?C/+tzxPKJ/TwwtnQMnr55z1rrectc9hSx+OpMrX7ImEX14h2JomMg7VOBDIP?=
 =?us-ascii?Q?twXNBR6WZ/2rhpqJAWgKw6fW8Aw7JQxXGvTjlbyTWTCU5DwHydi3vPEAA4bu?=
 =?us-ascii?Q?7pLryJ9H9/zzUVyJ/YShwjZTC0BzMeboWGMvCg6lCi9EKVsC0E8dRGub2/op?=
 =?us-ascii?Q?2Z9r8bwTB/PROaO6a4CEM1+QBr2g5spqdEWNXs8QdX+X81DkTb4YpzwXYU7c?=
 =?us-ascii?Q?CdUI0PbbZVP2RSpHKP8tTlXAkbxhfP+p82F+LDrhiWL/bKIrh3fTc2jlCwJD?=
 =?us-ascii?Q?zh8+H6cGmjqJuHK5ThiqKsMndMnU2mZjuQi52na37rLOZbTU0A/FDwZjPM/l?=
 =?us-ascii?Q?GJ8X5GJTWjzj+isK2lvAH920pJMGOHJyBIBV8n4GwFdrgOtvU82NjduiOG65?=
 =?us-ascii?Q?t9AkHzON30vvCMJWX2ZzPfS6JNyoXgVqIR3XErcmcPLo/iN5rZIEVx5p+lcW?=
 =?us-ascii?Q?FqkzEP+pr/t7lWPZSjS3m/k1YPgpysX0jm3SBjiLn7a4auwVbyuoqj78ltf2?=
 =?us-ascii?Q?tEGep8GaDsdwRXHf3j4XzXrc6C0N6ppy7DowhMV5IYYGds7fpSYgXr2Aq3bZ?=
 =?us-ascii?Q?Hf79V1X3xyl4LGryeimSf6n0sD4P1EApPjnFDQEZuxMjX76jH2X66wzg+AWS?=
 =?us-ascii?Q?ask1tFwRQtjqXM84EZ+wbIKDE0AGrwvP94LFHz41gHfDZEBiDiyOOAaaSupv?=
 =?us-ascii?Q?NT3/zlJALRvyf9WTEr8TJVtvAAhpv557IpE3KL1vU4mLosKV9rRkgrWpzOXp?=
 =?us-ascii?Q?4rkDZhjVcx3pxXhbldEnnHIP+Xo96yCJZ4BD/cUfS5vomwA1K98vd3JcNuY4?=
 =?us-ascii?Q?aNb+Jxos2AMTgL/Aib/KMV/XNlOwaqJUO/r71tY45IHpwbVGOywzWiXzENhr?=
 =?us-ascii?Q?orYffo/Ptbfn/8Ls6fWi8eNTmYoUHvdRZwmmy6zFpSt+Q7WlUs0ZyvMOdmWP?=
 =?us-ascii?Q?WSPErAO8ywQpCfKuxLbTuq7tv7IHoZmgHjlbWcZTTOAmvSWMC4vM8AIelRYD?=
 =?us-ascii?Q?9Tlqh2Xw3qenM99tZIMkeEFdGbrLTt0F6IT9wQQX2AfMnjaVRK6ov6wG8wEl?=
 =?us-ascii?Q?3Z5MhnacFZgYm2vJIC4cC0rPkOaSQqDk7eIebhWq0A0v8qdyOBi5eLtL05bP?=
x-ms-exchange-antispam-messagedata-1: o0A2qMMr/FTUAg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bs13tYjED7D6YW/eGS2ifrK3StEgXbgZwp/OhplOkngBHbPTGjr29r1DFp0sOmeBUV4c95z7rOOXmh3RNZ4+qzBpdPTroqb5cOenf2QTp6dcLaSA4pIRXsDnCrA9Kf4F2twcQ0BkQtwOGt0pzR3y/mZh1Cd45RrkNiEtXfxeHJvPb+NonvzWbEtK3sclEQvMHgF59PATIQRs2KXA7dq10zombNt4vwdMzEInOxduFEybveThK6UGfgSWe3cg65bLMsR7tKb87k9mILItJXPYP6afMP4UbgqI/ulPOrPkqp2Plv/aJRvF/tGi32s0vL2uy4hpWVV35y5F1SwCx44eZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c38279-20e3-4e7a-4871-08de7f6150b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:28:27.5300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy6hyqMeKqrDSP6tQTxOKo7k1463I00Bua/v4jyTAkfRqAoAcW8j8SubNQZK5UFG8lRlcnxC7VJT1nNmWpiJnl5FXzXkGA5iGAOVcLn83Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5995
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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



>-----Original Message-----
>From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
>Subject: [PATCH 2/2] intel_iommu: Always write all the flags passed to
>vtd_set_flag_in_pte
>
>This function was initially designed to write a single flag in a pte.
>The current implementation expects it to set several flags.
>
>Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stag=
e-1
>translation")
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>

Good catch.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

BRs,
Zhenzhong

>---
> hw/i386/intel_iommu.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index 56146aafc1..441c96125b 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -1991,13 +1991,13 @@ static bool
>vtd_iova_fs_check_canonical(IntelIOMMUState *s, uint64_t iova,
>     }
> }
>
>-static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t ind=
ex,
>-                                       uint64_t pte, uint64_t flag)
>+static MemTxResult vtd_set_flags_in_pte(dma_addr_t base_addr, uint32_t in=
dex,
>+                                       uint64_t pte, uint64_t flags)
> {
>-    if (pte & flag) {
>+    if ((pte & flags) =3D=3D flags) {
>         return MEMTX_OK;
>     }
>-    pte |=3D flag;
>+    pte |=3D flags;
>     pte =3D cpu_to_le64(pte);
>     return dma_memory_write(&address_space_memory,
>                             base_addr + index * sizeof(pte),
>@@ -2070,7 +2070,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s,
>VTDContextEntry *ce,
>             flag_ad |=3D VTD_FS_D;
>         }
>
>-        if (vtd_set_flag_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX_=
OK) {
>+        if (vtd_set_flags_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX=
_OK) {
>             return -VTD_FR_FS_BIT_UPDATE_FAILED;
>         }
>
>--
>2.53.0

