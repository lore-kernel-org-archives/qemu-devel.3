Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6ACCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 02:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcwRE-0006oz-23; Thu, 25 Jun 2026 22:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wcwR7-0006oS-De; Thu, 25 Jun 2026 22:36:57 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wcwR5-0005Kg-DM; Thu, 25 Jun 2026 22:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782441415; x=1813977415;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yyAaisJnlU+JQ09spKNZOOC0xucRubtf9WEqGl72hww=;
 b=gCGrHsNtzuXsbnsRgAcOeCLm0Dzv5jDAzYc3U9TmSTKGfaoFbNsNJNB1
 T2EolZpIvb7NS8vCv3Wmh1rp/V41/AWmh2UI3z8IwzkRpX0vmT0jynuS0
 4QOcX0U971ASJ2ur2+y/Zq3h0yq0jIjfCIJCpWa/PV13Pd0uEiO+JQNSv
 Xw/a7ultAYJqHlhiGo3b3c60PFX/NAR6Sro94JYW6C4bQdQKtA3JMEMoZ
 BeCuL8cvZaUyQ2GPdjnlMryjKNkdni4endA6lEdYwa1gTnf7ALlH9p68M
 M6dmzMoS6AoxT7gurc01/ZQ/hOKL7OsoaVIIt8VhQ0BLaTk55BMiQGBU+ w==;
X-CSE-ConnectionGUID: DiYtPL0kSxGF6dSKWfKRjQ==
X-CSE-MsgGUID: py6WL9RoR9ul4ZuEGBDYIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="70758141"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; d="scan'208";a="70758141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 19:36:51 -0700
X-CSE-ConnectionGUID: zJgTclB/QOSAXe7CPVQlEg==
X-CSE-MsgGUID: n0d8FpGvSxKDAS+Mu65cQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; d="scan'208";a="250158223"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 19:36:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 19:36:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 19:36:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 19:36:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jisldZ8bRMyNlNv/+2ByN0UVN60tMfg6aEs0zAbcIKZkCL4oigOIve4vh+KCXOb3va8P/NFkoPtHltaWm+QUVv6ubIyvN6Y1+b8X1DXtP3r8mJaJ7YxSq28KNnugrvWh9TahtvPkjXZgFe1yMeiSe/TeL9C1gQl2U1hFJ2G0y0rnAhGBxdbJc8QKV883mlnZyu85JtI55VyEg5I8Lmc4C5JRtIOChv49zlQJkhje29pAC8rOY6hGvP3O9rWrhYTJSkjqKuAl0p9mPAuHAFCZ4ou6dSYgxlCv+NxeN+U2lYB0AcKoKVfaBl4T91HOk9eq4OXlJdE8X8y+JtrX1IRWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyAaisJnlU+JQ09spKNZOOC0xucRubtf9WEqGl72hww=;
 b=eLM7n+MoTb1T4pq2XSAJWCmyjs28qbW8LUDUxd9ODATUXOfxW0J3/RcKNFoB3iJ8dmUyfaBPHmv7QzYlLIEielDpYu/SHJqt9TMBqqbmxAeWQIUFhOtovFtAb6mOB27cnEWlTyxydyeVkJ2GVEJ/Yu687mgEsFrskRN/3ph3af08x6NaqupTm+tlrdyTxgAP8QL4Mtv/7+mXk8G7TuEgWPuTBDo8nIzDQILRZaHF3tQcp5oWGj428w4oMtuc8E1j5dVErq3P0A7VC6Z79wvpbsQfl2J2BGW45aSR0TepKidr2HYc/haGYGYWbyCkZ9yYy0SMEHBNQN6pnil+Nm4ahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 02:36:48 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0113.015; Fri, 26 Jun 2026
 02:36:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH] vfio/listener: Fix translated_addr for
 non-identity-mapped RAM sections
Thread-Topic: [PATCH] vfio/listener: Fix translated_addr for
 non-identity-mapped RAM sections
Thread-Index: AQHdBKi4AWLWcxpmtU+0E7JH/p5jlbZQHxtA
Date: Fri, 26 Jun 2026 02:36:48 +0000
Message-ID: <IA3PR11MB913655EA5D1B5699E06EFED892EB2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260625134352.3122572-1-clg@redhat.com>
In-Reply-To: <20260625134352.3122572-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH2PR11MB8779:EE_
x-ms-office365-filtering-correlation-id: 60ade2d8-bbb2-4857-13b2-08ded32bc557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: n6Xo5YG6tPp95QEL2bURp1LMusHDLGPzRiVbQ6pngP71Y5arIb9CKWYvdh3HdXltME8ViPumSDtVFIuK5Rqkeht22lOESFwqA0AuFFpuVh3JjUv1LO7HqcwpoErjuL0doOukWUBD5Ard1Q7ItuaxQgAEczKD4mmf5W8mwRkoHH0dd/7KqXI8NbgK45fxu6/Db8n0oyJ+qqd6l96xjoYngPILBbJABrLYfcajSXhXl8F1ia4qlmJN+00F2Z/iXp773kB64gEwRkLzVkaeCn8NHKGR1D99G5JIVwekCF71wPaUN8MTU0XuF9+vzn6pgfiPPzNAcFH5nUtPLaPfPYYgBBlM7v41UQ8LMzKjTkAo1Z0OJCZsLxFCCSS9e5NAc8RozD2TNEkZ7krKM4WrLx2TGp5UDySWp9b43ru0WaL8yL1XSC14am78bJx786bg15PIoVcCIcfWOjfFNSkHePK6owVpQDjkl15UvP2bwRfNT1QplwnFwpLQgHkgo+BEAUeocZid8zfYGO+ayLN68aeUJtsOG37ZmXu7srlmdFKQHGbDAr92PPbxavH0yutwJSdPl7G+eRDGLJYA0nuixvjBBicLSQ7ax9/+h+euqIPhcrBooS+2Bz+Qt5sRxTA7jNcW6WY73mVrMuyDVs6VM6ysfoolD5mOuvN2DuIa7zIceHUkCPlqxMfE/nJ5aMOroN9R1f9oD7WFnmNQGFnkMxF+pyBsI9GkNhBep2wWHOsk37s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWlUWjNJdFZVT0s0N2NWblErQmltWWlKWEdpS1N5bGpXbXBvS3JQUG1KYUZZ?=
 =?utf-8?B?SVYzWWdMdTg0TTJ6d2lCVjRxdlFjQVl3UmJQOHZtTm9WMm95M0hZeUpTTFlL?=
 =?utf-8?B?c0Q0QXhOMXFGSFlpenRzWEluYXR6L1ZVUkFjZE9salRNNlh2ODVsYitURW03?=
 =?utf-8?B?N3o5aGNDUVVGek51MUFiVTgzSDQ1NWpZUnlHUTZNMWFZYk12dFpkZkNuVTBx?=
 =?utf-8?B?ZUpyZkdHMUJBa3RNMmtWTVlGWWZuL2NjTHZHcEFaZmI2VDZYNXpJb3BmdEhW?=
 =?utf-8?B?aFkxVEJKNDZOVlBENGlDRHhLUGNtYWYxLy9wQ3lpMVV2aThhYkF6YlhHc2R5?=
 =?utf-8?B?UHVmdGJUWndkWm9YS096K2YzQ1g2Q0R6TnI3TFNJVEdDVXl3TURxNkZ1dXFs?=
 =?utf-8?B?WEk1Rng4RmN1cHV5T2V3MEVYTXNvVTU2cEdVWXBRcjRBSWRUYWduV1c5d1RJ?=
 =?utf-8?B?bWx1ZnZEQTlCREs1Q2cvNElMU2dxSzIyZWJuS2VCMG1GSGZtcHVBOWI4eFBz?=
 =?utf-8?B?bXkyalFncG9jMnF6QUpMckFtY3BEaFUrUzU1UmdSd2ErQVFYUHVjZERmZFZp?=
 =?utf-8?B?cFNoMndTWk15U0RPT3k1ZXdnZjhhVWo5VVFYWEVvdTVHaVFsc3phZSs4Z1NZ?=
 =?utf-8?B?UVpLTmo1am0vYm5uRFNEUXgyeXNickNZMEUvL2RYZHE5aXBMd3VCUVhGTURO?=
 =?utf-8?B?MCszY3RyTmVwc2JPNlFsSmMwQXIyRmlRdGlUUnh0UWcwb3hYazFHN0NlcUwx?=
 =?utf-8?B?bzBYNHArVHU5NVdtbEV4TlRCSXQwZkt4L2lST3dQYnhDS3NDVkxlMTZzNGRB?=
 =?utf-8?B?UndXb3dsYnNBODZTS1FpOFBYamVHZmtlUGVvTEdIVmNPWlN5NnMyK3kvUTJU?=
 =?utf-8?B?dXlUVXBRc3piOVpRcm9wcG1ZemZXdTl0TDVUU1VYU0N5Tkw2bW9sT2pESjhK?=
 =?utf-8?B?djFFY1ZKWFV6WEtZRXRQVC93TnRXRURLY1NidlBwV3VETnFqTHhZWVVBL3Ra?=
 =?utf-8?B?NUNKYnpWbm5mMjIwa3NMbnBlb09la3REVEtSMVcwcFAxQWpEV0N5enZCYVA2?=
 =?utf-8?B?UDcyRVNxdnQ0ZW1XNzNKRW5hbTdOWHJ6NVdlcytINkwvakFqSGNIM2pzK2l3?=
 =?utf-8?B?TTFCOXJCREpEWHhabHZySmNOcXc4Zi8zM0UxU2l6UGRhRU9rbHlKR2RrM0Z2?=
 =?utf-8?B?QWtXYmZ0OGtpMFBvUGRTcHZ3M083anpjZmVyL3dNbyt4enFpMTMyNlJ1REFW?=
 =?utf-8?B?VURQakF1Tms2Q2ZkRFdJYXVobFN5U0d2cFR2cjNpZFZyMkhrTzJNZ3g3OG02?=
 =?utf-8?B?d0xZRWVmNUcvZDNwRXBHbDUrVndDL0MveWhqeEV2N0ZGYXdsa002a2diM3dj?=
 =?utf-8?B?SkZTZDkzRHR0cjlFSDlEakgzeUZZRllMYnlXT01nQnE0eXdkMlhLN2ZZWjQw?=
 =?utf-8?B?L3hlY3BFdlBxUkEzdnhoMktqeTVzWjR0Ly9YOWp0a2V5MGRuaDA4OFJybytl?=
 =?utf-8?B?clE1RWlTVnBVVE5hT2R0NHpJVDFzVzJ1cnJaRGl6Z24rcjJFRXNkaXMxTDZm?=
 =?utf-8?B?cldmYkFHSWlOZjcrL2lGaDNPc2Nwb3R5NkZ2MDdLMUpkdnNOWVA1cnh5RnFL?=
 =?utf-8?B?VTJ1aWpoTUhMN1F3QXYyNUlqbnp0NEYxY1lZWVhzbXZNejhuSjRIZ1BhWWpU?=
 =?utf-8?B?c3BMN2tMejA0SnZHMEtEajBMZndaWG92M2hod29OMlBxT09pb0Y4YjM1aWM1?=
 =?utf-8?B?Vi9jUzN0NnR1R2pGV3hkRUVIRFM3R3NDTDYxUkFCV3ZyMlRhTitCN3hUd2Nn?=
 =?utf-8?B?ZGNwOWk0NDkrVUJNT0k1Zlg0aHA0SkpiUWh1NnZScmZEVG1jSEprbmIyWTZW?=
 =?utf-8?B?MENObmNCbWJ6S0txaVVtd2gvTy9GU2QyNm1YQ1F3Y1Q3cVhKVVh5YjUvUy8r?=
 =?utf-8?B?Y2JSQXRsYWd6bWRvNlhnUXJKWHJ2cWg2blVBYm40YkdDRHh6OXB3d0I2dS8w?=
 =?utf-8?B?NG9Sb3owcm4xZmQ3bzB5UnplQjBJeXNsRGsxdkFZZnFTQURkdlUrd1d4UWZv?=
 =?utf-8?B?MFp2YUd4WHZleEdYSm5ONFVVTzB6S2RIcUN6SVI2MGl3dHJFNXpvdmZGcUgw?=
 =?utf-8?B?RE4ya1BsWmpyMU9KVFkydHMxcWJhc1lQSTZQRjE3ejB0RThHcSswdXFXUURX?=
 =?utf-8?B?b0JZbDNBc1JFT3FYSkhPWFZYTzBMdlp4YnF1cFFBYnIrODNXcGQwVFZ4bFRu?=
 =?utf-8?B?a1p5cm51WFZNZ1RZT1hvMUUrRnFKTkl0SXJGTFpQdnZrTDJWUTFwSVFuVG5Y?=
 =?utf-8?B?d2ExbWpHQTV5Ty9jWHdrZWNIY1l1Q3BnT3NTNm1EbTczSUp2YVJBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EL5MgrGxBR4UazMzleIP1/ZHonrsi5HlzuYOkl9SJ4F3gy3JnJTj7GDcavryYs16y140ceZQ6u48djBQfPPNYw7Ax27AHt/mSqlfJJj01WYfhzNUfW592Pfs345RPB0hr1BUpeuv/+E8VT1FM9ulMiN81XkKtHZJ5/5N2Do4hFgAnlgaKJf4J8OzupDqG9HJ9OdyJRymquZcZcQy+l5uuwkR7dsWGxejlak+2mfJlm65WGScUgWUMEfchPF2FIcPylOIM/dDOKUNIfxevJX+4AUvkArPghTyJLakDQk4fFxi3Mz7ryVpaSwpxL8bd/X5/IA7NhV7l2Ih2Ja1CY22gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ade2d8-bbb2-4857-13b2-08ded32bc557
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 02:36:48.0745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sq4VaErfRirbxnP+77mwjEF6RLi18ewWTV4B/AgWjj8Kck2PF98tS1vfTEGjoLtvkaAoce4ycNQ/06mjTPu562H8m0hh4Om8ktxLspoey9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0hdIHZmaW8vbGlzdGVuZXI6IEZpeCB0
cmFuc2xhdGVkX2FkZHIgZm9yIG5vbi1pZGVudGl0eS1tYXBwZWQgUkFNDQo+c2VjdGlvbnMNCj4N
Cj5JbiB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9kZWwoKSwgd2hlbiBkaXJ0eSB0cmFja2luZyBpcyBh
Y3RpdmUgYW5kIGENCj53cml0YWJsZSBSQU0gc2VjdGlvbiBpcyBkZWxldGVkLCBhIHN5bnRoZXRp
YyBJT01NVVRMQkVudHJ5IGlzIGJ1aWx0IHRvDQo+Zmx1c2ggZGlydHkgcGFnZXMuIFNldHRpbmcg
dHJhbnNsYXRlZF9hZGRyIHRvIHRoZSBJT1ZBIChHUEEpIGlzIG9ubHkNCj5jb3JyZWN0IGZvciBp
ZGVudGl0eS1tYXBwZWQgcmVnaW9ucyB3aGVyZSBHUEEgPT0gcmFtX2FkZHJfdC4NCj4NCj5Gb3Ig
UkFNIHNlY3Rpb25zIHdpdGggR1BBIGZhciBhYm92ZSBtYWluIFJBTSAoZS5nLiwgbmVzdGVkIFZU
LWQgaW50ZXJydXB0DQo+cmVtYXBwaW5nIHRhYmxlIGF0IDU4IFRCKSwgdHJhbnNsYXRlZF9hZGRy
IGlzIHRvbyBsYXJnZSwgY2F1c2luZyBhIGNyYXNoDQo+aW4gcGh5c2ljYWxfbWVtb3J5X3NldF9k
aXJ0eV9sZWJpdG1hcCgpIHdoZW4gaW5kZXhpbmcgYmV5b25kIHRoZSBhbGxvY2F0ZWQNCj5kaXJ0
eSBtZW1vcnkgYmxvY2tzIGFycmF5IDoNCj4NCj4gIGJpdG1hcF9zZXRfYXRvbWljKG1hcD1OVUxM
LCBzdGFydD0xLCBucj0xKQ0KPiAgcGh5c2ljYWxfbWVtb3J5X3NldF9kaXJ0eV9yYW5nZShzdGFy
dD0weDM4MDAwNDA0MDAwMCwgbGVuZ3RoPTQwOTYpDQo+ICBwaHlzaWNhbF9tZW1vcnlfc2V0X2Rp
cnR5X2xlYml0bWFwKHN0YXJ0PTB4MzgwMDA0MDQwMDAwLCBwYWdlcz0zKQ0KPiAgdmZpb19jb250
YWluZXJfcXVlcnlfZGlydHlfYml0bWFwKHRyYW5zbGF0ZWRfYWRkcj0weDM4MDAwNDA0MDAwMCkN
Cj4gIHZmaW9fbGVnYWN5X2RtYV91bm1hcF9vbmUoaW92YT0weDM4MDAwNDA0MDAwMCwgc2l6ZT0x
MjI4OCkNCj4gIHZmaW9fbGlzdGVuZXJfcmVnaW9uX2RlbCgpDQo+DQo+Rml4IHRoaXMgYnkgc2V0
dGluZyB0cmFuc2xhdGVkX2FkZHIgdG8gdGhlIHJhbV9hZGRyX3Qgb2YgdGhlIHNlY3Rpb24sIHdo
aWNoDQo+aXMgY29uc2lzdGVudCB3aXRoIG90aGVyIHZmaW8gZGlydHkgdHJhY2tpbmcgY29kZToN
Cj4NCj4gIHRyYW5zbGF0ZWRfYWRkciA9IG1lbW9yeV9yZWdpb25fZ2V0X3JhbV9hZGRyKHNlY3Rp
b24tPm1yKSArDQo+ICAgICAgICAgICAgICAgICAgICBzZWN0aW9uLT5vZmZzZXRfd2l0aGluX3Jl
Z2lvbjsNCj4NCj5DYzogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj5GaXhlczogNmUzNjBjMDYxNzZjICgidmZpby9saXN0ZW5lcjogQWRkIG1pc3NpbmcgZGlydHkg
dHJhY2tpbmcgaW4gcmVnaW9uX2RlbCIpDQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NClRlc3RlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCg0KVmVyaWZpZWQgd2l0aCBiZWxvdyByZXByb2R1Y2Ugc3RlcHM6
DQoNCjEuIFN0YXJ0IGd1ZXN0IHdpdGggVkZJTyBkZXZpY2UgaW4gbGVnYWN5IGlvbW11IG1vZGUs
IHRoZW4gc3RhcnQgZGlydHkgcmF0ZSB0cmFja2luZy4NCg0KKHFlbXUpIGNhbGNfZGlydHlfcmF0
ZSAtYiA2MA0KDQoyLiBkaXNhYmxlIFZGSU8gZGV2aWNlIGJhciByZWdpb24gYnkgY2xlYXIgYml0
MSBpbiBDT01NQU5EIHJlZ2lzdGVyIGluIGd1ZXN0Lg0KIyBzZXRwY2kgLXMgMDE6MDAuMCBDT01N
QU5EPTAwMDUNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

