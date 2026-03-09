Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC42DEA854A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 02:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzQAP-0006Vj-VP; Sun, 08 Mar 2026 22:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vzQAO-0006VH-FW
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:16:20 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vzQAL-0004Us-Bj
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773022578; x=1804558578;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+ztpHuYPEsWCnoK8rGP6HJIW5VbxfitMjZiWaGDLIBA=;
 b=I2Z2nYwlqdxc0EAqN1brx2Al5m4qOLxrp6fD4oaph2AGUOsSxeexr7dL
 +cuGiW/aurMeNaSp+fz68amoSw497Qk2nHaJOTgDpqoNa7y24d38eKxMY
 9NH+USYBd+Nc24dJlPLNcUksUlAoDBprnm/WeqmdMOaFDyCqU5dJTPI9c
 3Hg7x7l8LTlBbtw/aEWdSNaR4JoOcAbcuUidt7PNwjefpaQFpgHvB4r+c
 q44Bk135Nzz2ll2WKYgFqOj4FO1/MH4NNRkIy5xPDMZlu8gtL0rdMuO2C
 doBXnY+iQGjfEWycBlnciai9zXawJfd+ubTZ3qqactbosMu0VtR66e/z+ w==;
X-CSE-ConnectionGUID: woVSDKisR6iQnicxlUz5Sg==
X-CSE-MsgGUID: Bi+cOCMORZyOffcTSosQww==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73740400"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="73740400"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2026 19:16:12 -0700
X-CSE-ConnectionGUID: f6rp2CaSTkecxIXB4X/VTQ==
X-CSE-MsgGUID: SglcyGiHTKGY6AGzg8di9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="257534616"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2026 19:16:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 19:16:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 8 Mar 2026 19:16:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 8 Mar 2026 19:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvqyWzcsbNOegTq+YNV2sG5jE1UI6UPk/33ye3Lt4SgG9NaxtsR3oNuE68xrAF8V/NfyzRsK8sPtTyRQptHWP7uOxqGRlGyI/1kWqmKbnpXRfVsS+toEp7nWtoxFxnFDzerCAPvIvN8JyHwlt9CMvqMQHoILBxyeB/HOZo6lGOO4fzaFJRKe11RdEziLJ47WI2feHM4nEne3bglGXV5iLIh2qjunUi7oNKhqPCMDlbtiDH/kZCir+UIpKVpv7XhrVdrYUIPTRj0Ml2FBWPeuXdCruk0pcxjCWaF1/ExR3z7mR+PB1JdUE1KWk59RCTNDNuXzHMlR/CAYftmPJ4lBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ztpHuYPEsWCnoK8rGP6HJIW5VbxfitMjZiWaGDLIBA=;
 b=mGFAtVHAlAEDDbgd1c5lU2MiLLOcrMJAfpu4v7M386aJc84+LiUNmRFEUAuuLqH0AG9M96qUcKNqotH7IUnfpZmQrxlyA0Wmk//cvzQJUl/IKyYVCDMD7EaS+ApZOQST7xvo7s7ef9N8vz/dqiN1OU3UahXCnMRQ8xnZzdpcVn6TOaawPflxyau6VSjwExB1TZlZYV7zPRoANTUngcm0Q4WFHvDCQvblAydx77ZjNDZ7ymZhMiLwtVf0iXX7mmNI46Ppca5wWGbPNQX3/52DDTdGdDfvGPtB7T6AHnTYBgmLE82UwV+703+n/CY7GgHFZ1MbEsfQPaQpwc6NrsMCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 02:16:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 02:16:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v1 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [PATCH v1 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcrRum6y3Qp01Jh0SYUQFTMN4VcLWhGzeAgARfuZA=
Date: Mon, 9 Mar 2026 02:16:08 +0000
Message-ID: <IA3PR11MB91365A1457A9EE31E4EA4B8D9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-13-zhenzhong.duan@intel.com>
 <927baa6883584bd5bcc344009cf25ddd282d0ab1.camel@eviden.com>
In-Reply-To: <927baa6883584bd5bcc344009cf25ddd282d0ab1.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB8393:EE_
x-ms-office365-filtering-correlation-id: a5863f24-674f-4f75-fe31-08de7d81d3a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|18082099003; 
x-microsoft-antispam-message-info: 7gtUuLv8G655Y3iJ/Jaa6nHLmkPruG03G/JMMuhf0uQxL9JeP97U2LcXoXTCjfhP38mVpVWLjwfFCALzCixSHMQadVnnG9feStqlYDrp0yMWeKAIAakofVupksTsXjs9DoVX9VOnNVF6FEzuTHEUA4iETyXZiDNqx4ek9GtSvE6JD/dFk5yCkUm2U1Sc3MYMhcdoB5PgKzhq3iXMTgmArHRU1Bjd3os6YmIWB9196yc+HTn1vZbBYBZJWke/gJOG0tMCBA/3zC5VmEu15oeosghHZ0YeE8DEtcxbPU/E5ZZD8rj6ErOzNo3loioPooAea1dhXHFpYZrk6hlzZMNS1wh1hr4lgFVe96DGdFOSq3NrenJB33r96C/BrYRL0N2titUJCHX5dGwNQntPZQUShXChayHE8orII4eOD4T1iViurLjW4YJE+bAO4GiOR1wcajrt/zsHmmagpVX5jCYSmP+Xq0lHOU5N5Ikzi+8SBij6P0fVPiqwxGWpMOwxZvMjLV1Q8iGZqdpYaBoLKk3/nN2iVLE/OFDaa5NDAyF1nuhmE8NxhVOWoohKrKhwaxDbrz6uvlHdUM+7ll51ihPB96KLttxG/9yZ+FZbKudDSaUuU/zzzMXQX5bC6XaxZcspQyzKIVilEVDEnWyRi3Uf7Xwro4eLlXo1EW7knLCgWq+2QNubEiOSSVP7gVH3vbYeRUEDzj/IOx5+wiZ37FPOHM3h42uGkHzc87Q8LBtpNE5u1JKxA1Oy7ywgVHxDntVeqMZqri566enn7noaJnJOKJm5lVPvfalQz9QPNnVbf4g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnZzcExMc3BMWnY5WjhUYXdtZnd3U0R2NGlLekNuclVYaHJMbGRRekhnNU9t?=
 =?utf-8?B?QkptU0daM2ppSU4rTWwxRjkrWXdrS3hzV1lycXlLaDByeW9lYlF2Sy9uaExo?=
 =?utf-8?B?SVFVRTRkcm0zTW11ZEp5UTRCNnJmRnIxMWh5Q2xvQjJsV0pwYlR5Y0dMOTNt?=
 =?utf-8?B?Z1A4UE1oL0NTR29EOVViUjhncFNQTGdxT1lpYTl2VzZ6Ym4vUmNmTjBGeFBM?=
 =?utf-8?B?OXlMWDJoUDVEb3phMkM3dmpWcEVpb3IrOFMyeEgvelhycHdHN2pkaDM5MFZy?=
 =?utf-8?B?RHVtOHRUVmc0dnZHVmcyYWU4ZWZXOUNpRzh3Wi8ybVBLUVNGRUtFSTl5KzBI?=
 =?utf-8?B?OUlIb1dqNnFnTTh5d3ROREthamdKZlNPakhyUHBuekpBa0ttNVgyb1RyR1Nt?=
 =?utf-8?B?NXh3L0t5RVROWU5zTHNFM09RWDRpSG5UeWFPaWRZNTBIT2I3WnJmeU1Rdll3?=
 =?utf-8?B?Qk5mWXgxb2t4MlN5NUxGOG5FNU5SdHJ3ZkpGZVMxaXRhd3czOEFmdmRWWURp?=
 =?utf-8?B?L2dtUFkvNW5LZ2x1WUozT0dQdHhsMFZTaDZibmhOZFRiOG1tRjcvSFVuVWVK?=
 =?utf-8?B?REdPTm0zRG90a3pDWWtpQ3VaRnJCQTJjZlEwUlVibHN0a3N4dmdNOEtpUmMz?=
 =?utf-8?B?R01icWsyRnU2d1hRNWpWVm5PcDhDVDIxbUdMUjduNkNyYk5oZTVWVkVHWnpr?=
 =?utf-8?B?cy9Ia0Y4NUFMQkFaZjN4VWVPR1dmYXoyd0cvQjZNb0xLSExCVERXYlZiYXpx?=
 =?utf-8?B?dXNkZFM3eGx5aVdQeG9Nb2wwUXFZTTdEK2dxMDNLN2JkOEJmK2VYM3JVNnNi?=
 =?utf-8?B?VUgxblBZYmFQNUFRaHRZNVp6VjNlTDc1cFNxakZzcTB2c3JrWFMyOG1zbEtD?=
 =?utf-8?B?NTlNZlpGakdDSHhQYlNHVFlKNVZ6bHVTTHA4MnNJL2h3MTdXa2RIejRNSExE?=
 =?utf-8?B?RVQ5UTUvVk5sMkdlLzJUaHpBMi9VL3h5a1FkdDRIQXJHcXZXclV4MEd1bVlv?=
 =?utf-8?B?ODlzckdrdlZVSDdOWmtKQ2I3VVVFd0cySlBzcjdJL0pqMmpzbkNwaDJnNmVr?=
 =?utf-8?B?VzFMTXlRU0JEd1JsbEJVbkhJS3dyL2dxNjdDNTAyWkR2dkR1RDNuYkNYZFEz?=
 =?utf-8?B?U3VBQVdFTDhGWHlLcXFkWFhXaDUzbEt4TEhvbnErdmY5U1BBUzVLcWVHdEZm?=
 =?utf-8?B?ZVI0NHJtUzl3OWtmRWFDbXN3WkF5T2VweWN3R0xURjl6MEI5Vk9odTRnNUps?=
 =?utf-8?B?MGpMRlJsaElqVCtFaXJQdlYrM1JLd1lSMnhFSU9BYnJNRGZKaXl0dmRQd3pi?=
 =?utf-8?B?c291KzVLbFVzQUJnejlxVndFeGg5b3h1VkczNEpnNUJDdUlWNys3TXZhU2lC?=
 =?utf-8?B?QmhRZXFlNElDQVRxWTJTQXNua1RaTDlaRXQ5VTd2WkxSTVFDYURsK3h3TDFY?=
 =?utf-8?B?WjRaRGRjK2E0OWwwU0xpY2paT2FnTFA3QkVGM1lXamtyY2QxUHVOWjJYbFk4?=
 =?utf-8?B?ZUlFOFF5amtRalNvam5uRkc0UG9QTDJrZzIvR1FKN1JNbXk0OGVDNTNQR2Zr?=
 =?utf-8?B?T0d1aWhTaE55V05PbjNPOXVzbk9leDl6czZPY3Y3dzJWR3lycmFEV1dxOUdQ?=
 =?utf-8?B?Zy9jdDhEYnFMYnJ0YkhhZUE0OHRKVHJObnZTa0E4bk9rNEFVU3JJbzVKcmN3?=
 =?utf-8?B?ZG5mZ29FSWg4eHBPT1ZBazFxbkZFdXcraklyclFDcGNvWFFHejdtd3BMQzBo?=
 =?utf-8?B?M2pOd1YvY0FrZnE4Yk1SNjdvbDBnQk9GS3EvZHUxVysyY0FJSExCQ2R2VlZP?=
 =?utf-8?B?cTFtM1FsUXFXNEgvQnZTK0lNYjRscXpHTk41eXZnM0M0L2NndmswWmsvbnRv?=
 =?utf-8?B?S1Q0QlUwZC9kU2o4ejZiZmJjbFA1TVVOdGJGQ0tLTTV3WXRIbjhTU0M2Z3RB?=
 =?utf-8?B?TG5oS1U5ejNEeDNJMzcwemxDTDVaem5JNnRiTmZtcDBwTnBsYm41STg2R1dV?=
 =?utf-8?B?a3dxMFljeGhtbENvQ1JRZTVKS2g1N085QnNjYVpGNkxzV1ZzYTRTT3VPa1FO?=
 =?utf-8?B?SFlDR1BBOGJZcEdHSXlWcmVVYmN3VTJ3ZnNrdGdHcVMvQlM3QzdRdXNSUkY2?=
 =?utf-8?B?WmplOEVtWkg2SXBoTlZNVmlKZDNOTjhJRjNHb3VaempmSGlNeDE3RFNvVTF6?=
 =?utf-8?B?YU5BUGtGOXNBVXI3UWkyVkpqTlFHRWVPOVJhRVRYMlV2NEs1T3RlUWpWWXlN?=
 =?utf-8?B?RG1tZ2k4K21YcW4rR1JtaTdrbS84NThZai8vRWpOc05Jc2h1UVlVUU9FYVU5?=
 =?utf-8?B?dU5RcW9WMVFuMjlmQnFaNkFLNEVoYlVsTXo0SFdOWUNlVDR1ejhtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wMiEpcSdtXKW/9eSjuZ2fDV6VtB+wjL7gx6qeXT3BzKvE4z8TQwNpuOAUSUri1USvGZmmKepSzp55fse4ezZClWrr23I/4FvKVw261joU6eU+QQjyyKPcfpUrXvDaU8J22WFhUVhhkDpFMsNY8x3wpk1+OStV/2Kx84tXdByTkBKsXPAjgsLUxw1DW9ZMeRf/rFr/WRyEvxT3yOmj9vkuH+f93pvSuFwZdrm/sYmKqhDWw99DAsyYG3FAQJ5rDnw9LqKdpWob/FgQBrfAIkKi7zv3sMhjotC4E7zW+gAtCO2NfeAiclehLvtJToJL6m0GIjN1WiyDzMNTjU8Ze+W3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5863f24-674f-4f75-fe31-08de7d81d3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 02:16:08.8208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqT7Gk7buVghrvR6T/kyp3MhPeJZLoJbddW8rMT3yrlUvzALrEP/MbBzpPmdASTywMRH6mf/SqeQi+bOT5zs/UfvYFmrjQqjGK0wu+vbWNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8393
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQo+U3ViamVj
dDogUmU6IFtQQVRDSCB2MSAxMi8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IEFkZCBwYXNpZCBiaXRz
IHNpemUgY2hlY2sNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gVGh1LCAyMDI2LTAzLTA1IGF0
IDIyOjQ0IC0wNTAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IElmIHBhc2lkIGJpdHMgc2l6
ZSBpcyBiaWdnZXIgdGhhbiBob3N0IHNpZGUsIGhvc3QgY291bGQgZmFpbCB0byBlbXVsYXRlDQo+
PiBhbGwgYmluZGluZ3MgaW4gZ3Vlc3QuIEFkZCBhIGNoZWNrIHRvIGZhaWwgZGV2aWNlIHBsdWcg
ZWFybHkuDQo+Pg0KPj4gUGFzaWQgYml0cyBzaXplIHNob3VsZCBhbHNvIGJlIG5vIG1vcmUgdGhh
biAyMCBiaXRzIGFjY29yZGluZyB0byBQQ0kgc3BlYy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBa
aGVuemhvbmcgRHVhbg0KPjxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tKT4NCj4+IC0tLQ0KPj4gwqBody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggfCAxICsNCj4+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDC
oMKgIHwgNSArKysrKw0KPj4gwqBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmPCoMKgwqAgfCA4
ICsrKysrKysrDQo+PiDCoDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGVkZTRkYjZkMmQuLmQ2Njc0ODYxZmQgMTAw
NjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTE5Niw2ICsxOTYsNyBAQA0KPj4g
wqAjZGVmaW5lIFZURF9FQ0FQX1NSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVM
TCA8PCAzMSkNCj4+IMKgI2RlZmluZSBWVERfRUNBUF9OV0ZTwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoMVVMTCA8PCAzMykNCj4+IMKgI2RlZmluZSBWVERfRUNBUF9TRVRfUFNTKHgsIHYp
wqDCoMKgwqDCoCAoKHgpLT5lY2FwID0gZGVwb3NpdDY0KCh4KS0+ZWNhcCwgMzUsIDUsIHYpKQ0K
Pj4gKyNkZWZpbmUgVlREX0VDQVBfUFNTKGVjYXApwqDCoMKgwqDCoMKgwqDCoMKgIGV4dHJhY3Q2
NChlY2FwLCAzNSwgNSkNCj4+IMKgI2RlZmluZSBWVERfRUNBUF9QQVNJRMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICgxVUxMIDw8IDQwKQ0KPj4gwqAjZGVmaW5lIFZURF9FQ0FQX1BEU8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0MikNCj4+IMKgI2RlZmluZSBWVERf
RUNBUF9TTVRTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0MykNCj4+IGRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IGluZGV4IDNlYTViOTJiMzQuLmU5OWE5Y2Y5YzYgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTU1
NTksNiArNTU1OSwxMSBAQCBzdGF0aWMgYm9vbCB2dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1V
U3RhdGUgKnMsDQo+RXJyb3IgKiplcnJwKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRn
KGVycnAsICJOZWVkIHRvIHNldCBzY2FsYWJsZSBtb2RlIGZvciBQQVNJRCIpOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+PiDCoMKgwqDCoCB9DQo+PiArwqDCoMKgIGlmIChz
LT5wYXNpZCA+IFBDSV9FWFRfQ0FQX1BBU0lEX01BWF9XSURUSCkgew0KPj4gK8KgwqDCoMKgwqDC
oMKgIGVycm9yX3NldGcoZXJycCwgIlBBU0lEIHdpZHRoICVkLCBleGNlZWQgTWF4IFBBU0lEIFdp
ZHRoICVkIGFsbG93ZWQgIg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiaW4gUENJIHNwZWMiLCBzLT5wYXNpZCwgUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIKTsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+PiArwqDCoMKgIH0NCj4NCj5JIHRo
aW5rIHRoaXMgb25lIHNob3VsZCBnbyBpbiBwYXRjaCA1LzEzIGFzIGl0IGlzIG5vdCByZWxhdGVk
IHRvIGFjY2VsDQoNClllcywgbWFrZSBzZW5zZSwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg==

