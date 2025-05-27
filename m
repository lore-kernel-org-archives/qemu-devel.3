Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB89CC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 04:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJlnd-0000uI-B5; Tue, 27 May 2025 00:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uJlnU-0000sM-SV
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:20:18 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uJlnR-0006jN-Sg
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748319614; x=1779855614;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ObmrP/mzfF1X/LRIgI7T/sd4dF6y6cCcV7EhdUGjzSI=;
 b=ArBO3VjbzNJGoEymcjdhl50QGMzWxx7YzeTcy/0y3dxmTUhdUCEzbgFl
 u4/6KOM7aYNWYxKBoy4BOLGm3X7yVU22zcPAiPqRrMPYIO4WXw6n3Sm4u
 FTAfuk4KNOqyqvfGZ0MBNquVSRS2rjNO6HH5xrSenCnTJ5U5U+TK30pf+
 MbvF8/yMNHh4poP+oB6l0MMqdppUx2R9DLiCY+820LnbnuhGnocTwGqcY
 zgeuGqq7FyH8wBBXgekakyeHznycLkJN2GWJ67c8KZ2ARUw3/Y9vp8ZDI
 jhNYI29E1mhD/8IDxPoGBvmGhzYu5L5iV32WVt7zVK94CHMWlPliAwO59 A==;
X-CSE-ConnectionGUID: JY44A+ExRXqqOrBMGlmd9Q==
X-CSE-MsgGUID: 9DYcoN7/QnavunsLF3DCQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="49543706"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="49543706"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 21:20:12 -0700
X-CSE-ConnectionGUID: GSqe4fcDTPO/uS+CyHVfCw==
X-CSE-MsgGUID: pu6od9vpR1WPj+SZTYjFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="147398695"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 21:20:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 21:20:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 21:20:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.82)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 21:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAQy0bIRIzruJHXMei31Pjw9IXtMM3p6lRFzz3WTDBBMQ7SfCwHdW6wkp9hEH2iz1KEJLEtrLQHU5Y7QHjJTqiY7AHJhWiDbrNv7ri/jSvrxu+w94mkRGIqfxEJrI1qFQJ1Qw5JkBkla1L+OVmckxGvUBmldFor3YpYszJ1lkXGyfWqkigyIKAR5yhrF4eMNRDzAMyV+S0ulNSMBQwOdsVO2Jy+5BYRPKH3UPnicVvsUZZxSaIyn+GqwTD+8OID65iaRs+aODAkDMAU5Jqg2byxZ2/Pe+ON+ADueK2GRPIgJzOGYVBfL5+G8TKvUNy8m6duKqP50QlXCg9I8OHviBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObmrP/mzfF1X/LRIgI7T/sd4dF6y6cCcV7EhdUGjzSI=;
 b=iQE0SJNhylCzdB8FsBg9QNVlRQmsa6Xdcg2HS3r7zRX233BomA/Y16fHsapyzsSyh1K8jtnLLQuWbgtulLrmdLIEtgA39lM7cxzSvC6koar7QVoiI8vIrbb5yh5Pas48IcHIuuzQwl5EQ6Ev6010aG+2t9NBTMLJFHUpCMJ2ZU6pRLhrfty99nxgdxSJk53Hk88l6xZNxxP+FVJkZmDkV+tOmLV/1nLBBTJomzo/p6pXxbfsm5H2+XiWEDfg+vz/o2NUJlOQTxYd6r1B22mCm0lbZ3uEaxGtdwoX9lwjqFstzYt1Q2Ecrt5OV3lVb5+1ByI0PKW1bL1xLg7tN/g3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Tue, 27 May
 2025 04:20:01 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 04:20:01 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v4 5/7] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Topic: [PATCH v4 5/7] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Index: AQHbxUP6oU7xqQ6Cmka3GbxkfB9KC7Pk84YAgAAkNgCAAHV6AA==
Date: Tue, 27 May 2025 04:20:01 +0000
Message-ID: <IA0PR11MB71855E2B0CCF3D8C1578E5D2F864A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
 <20250515024734.758335-6-vivek.kasireddy@intel.com>
 <7dba8ee4-3af2-4bdb-9edb-df49fea1e842@rz.uni-freiburg.de>
 <746d41f7-4028-4f70-9038-63edf494429b@rz.uni-freiburg.de>
In-Reply-To: <746d41f7-4028-4f70-9038-63edf494429b@rz.uni-freiburg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB6608:EE_
x-ms-office365-filtering-correlation-id: 2450d001-f637-44cb-d6eb-08dd9cd5bfdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?E6/wshBI+iNWzTEVPfVVsTqEjnFzJe7jVMEVmT+yIgo9IetNwxKsRtuzjA?=
 =?iso-8859-1?Q?Fo1KhcT5j7uExINFpgjlj8RIxZLzQbq+xEcaDrxU+OnbmdcRYxK0thUhGi?=
 =?iso-8859-1?Q?fy+J0A7btWxl9oPXRsudvt9q6RC1n+Ka4S5xgHegGJ1rDh0kmjsZujB7S+?=
 =?iso-8859-1?Q?TI3Vs8s52b2JhyxenPFHAalJkqf05f8lVQyFiVbKxIj2Btuze3zzs0cD40?=
 =?iso-8859-1?Q?H1H+VY9nB3n73jjc++DbiFB3lt5kSuvDzLKKvbBEQvIWG7UBLOVu4kz41R?=
 =?iso-8859-1?Q?MpYFR6unwIi9G78aRDcDhyx8GKil+MhN6IA91JJ82y3048dLYCAixVHn0p?=
 =?iso-8859-1?Q?m7Pr6FeN28r+izXAdX8H3US0UW+jIT+1JQ8u24kujyjDGXCFNtnJ+OD8wq?=
 =?iso-8859-1?Q?ym49PrD1jHxN+w5H/UxMtHmMK+G2GbEIA5LuLONOFb723Lio6/BB0l6Xe1?=
 =?iso-8859-1?Q?7KDuz6wVS8zgZ5ssmEHLYbLVQ96xjGmWIrjkYbunWgnLIIjJWmc5ClN3sl?=
 =?iso-8859-1?Q?it+0hv6cmjf3t74i3dEqfa+U1Qrt0+qXFxK/SPQTm0i/6ULuLr1gRUVhCQ?=
 =?iso-8859-1?Q?W9rYdjplz6V1Vbg4Vg7rDl3GJspvAlo67rn641Xtd5hSW6jlFrQU2uKvvt?=
 =?iso-8859-1?Q?R8hNbmyn26Xrkr7Y97h9lYtXv8jKW4OpfWY34bsz5bEiQfpdLPFVja4UKO?=
 =?iso-8859-1?Q?WD89vbvKK3v3MLOQZNl9M9EqWxEJpr58Irh42FVAtcGNFVeqLd++QREYJ+?=
 =?iso-8859-1?Q?iwwtvJin6NrJTGJ8c9RzKHVrLJnpNeXH+jQqccTM9xf8Mo5gGwRxgrE0He?=
 =?iso-8859-1?Q?APnpQWiWESZEwKCWY2IJNnECU/+s70RQxrboIIjJm8UKnvZBj60Hr+IHx6?=
 =?iso-8859-1?Q?D5oM+cVCqvg549YXD63DqIGbAhMWql/Is+4mm3ubl2svwTM7V4C2IfCIEq?=
 =?iso-8859-1?Q?yb0UibHMu/vPpJTG3/pd6xDdD/cAOHr4kiQu1sj2ZlRrHi/Ple14M9uPox?=
 =?iso-8859-1?Q?I2yYffJSn/KariMi0O1Oad9NcZZDpsn6f57+kpbrrBNER7r6Ny9/GRBrpO?=
 =?iso-8859-1?Q?rjgvKqD5hxL4rovH9Q/1LfQsJUZYjPETLnmjWFcGEd7ma8++QYZ2+tCe2Q?=
 =?iso-8859-1?Q?Nbf5Qlff9cg8IysRf9Jn+8jJGyZByWVtWSB7X5tMZ6lK3nHEb5W2odwXf0?=
 =?iso-8859-1?Q?F8K4sIYZUnyb0Gw9zLRpPIJC0+V3dg4tA7UiXxvRhExiDSOISLCpoF17EI?=
 =?iso-8859-1?Q?fOTeDBfWTYkB4KMgidWHwxT+JMSOHrPDmNE5PXwmnNPNmbt9T6F8bJZAIN?=
 =?iso-8859-1?Q?yBELzU+ZhrPq4uMrE/mqRR4IDIFL71jPBxWz4cdYI5L8vHswLBUvSSjNwp?=
 =?iso-8859-1?Q?2EBWSQzcQDND52MX8oMhgRBSlXW063gmKjnEY5H2zwyAU+nVQ8c5CzPCH7?=
 =?iso-8859-1?Q?v/YuZhyyUbCL1P7GbQTKl/0pAw1cqRCxaVgQxULefAAijfkS9tXSZKBBVx?=
 =?iso-8859-1?Q?8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1qRWE6QUc62c0TUD6TNwpKwTgU31JKL/KsCJH2wMIYlw7xdKBSZ4KCltWl?=
 =?iso-8859-1?Q?wA9LsYNU+LjxvPMclaNliYxK3pHuAFejgk+pP6eu+fkkikbwN/lilYMTKP?=
 =?iso-8859-1?Q?rgbBUwSeBIePk+Aag/8SQiFxNY+VjHyPZQFO4uqFS0NMRvIw4loRtsbmnp?=
 =?iso-8859-1?Q?u7wVPCdXmGHNGz1gSStSxdpj/8dkIuHGlsbXLuUAGec5FIXHeRyBHKi5VQ?=
 =?iso-8859-1?Q?9Dq1M8t+b1W9YBvuCm5GKdPc6cXtN/bpNFT4M8ZFw2zvyAKI81YVWEPoCD?=
 =?iso-8859-1?Q?CeZvcodmZj4Ddc0ULkEzADnNuAl0XzSq4Bleh2eoHU+e90OPx07Vrez6on?=
 =?iso-8859-1?Q?JOQjzjIb/AHkDHnEoy+N9YsQgnomzG/H/0vj/bIY2p0/FTmKh3VQURcCWQ?=
 =?iso-8859-1?Q?5p12gMAit6W45k9U/jc3EbPDcAWHaOFHCMzEm1xwUzs8mILwWGO5wuWuMW?=
 =?iso-8859-1?Q?iMPwBWoVwBTgLcGA5YgvjHl5+znvtPg80pv6j6gexg0LqTvppSE74+h+sD?=
 =?iso-8859-1?Q?P80iSnFLJGZPe8zESRVVkSuJR7qwFMrEXPQY3PsEuRsCJigg/Jxz6uQRWO?=
 =?iso-8859-1?Q?tQXs9znaWMlnBuy1NkqPVYgSK/l/O6u7cYNtCxfqYuQ83jzv1n4I1caKDp?=
 =?iso-8859-1?Q?VpRD0cQf+rKFMSOY+2ERzKRG8Pbfd6rLkWMEHmiwcSs/CmC9ffuYEdsanp?=
 =?iso-8859-1?Q?sWHTcAtiTIqhxb+NhYB2tUqyUrdp1RFafDaQqlAUY/sBTWRmWKvvq9KLom?=
 =?iso-8859-1?Q?sc2gPAhtPzdM/Bqg6l0cRXoNeDGFmcIXubfdmOyo5OIMMkhT8fAhBmoWDD?=
 =?iso-8859-1?Q?uouROSpaeA/Rdg578rl8W5xaRmlFQ1DT8bUGJD0sHuUuwCjNwBNgkJwhwv?=
 =?iso-8859-1?Q?lNaz7X7hLDsRmFh9lAk/SjB6SbLnnBZx6M7MfBDt69aLCislcdYWrd4MYe?=
 =?iso-8859-1?Q?I0FVQAdF+yWj0JN1pVJTEd+iIFWXiy9WyjePXOMIRo7gaqDVgzVMoQc+Ht?=
 =?iso-8859-1?Q?Wpmi8jOnDuNTaFHl83m99pAGVnqmM1uTBK0pbZzxszgIoeRFnBkgXeT1C7?=
 =?iso-8859-1?Q?o6m06ttAnbOaxEPK5Sye0WZEVsxhaDno6aB/iejNPz9E1m90bjJ8yytTjv?=
 =?iso-8859-1?Q?Rxfaae26edRRXPUGAqZgCwfM7gdFIVHsKoZDXSxaE3/8Oh19NQLhONs1S7?=
 =?iso-8859-1?Q?SyPezY3FbLlOSi5tDnRZeP3phgrVNjP3JOnhgfjFX/ZieoJDHC6UfMScfp?=
 =?iso-8859-1?Q?ytiIu6NkQqvItUQxDmlcAZW5Z6z36raua55EByOWlWbghv90EU9VM/1jCL?=
 =?iso-8859-1?Q?yQydaC5xbAPLv4qkrNVd2JJlLFh7fkrcrG98igRAJs2dG6K8VFdqN/+nhP?=
 =?iso-8859-1?Q?0uiqNANFt/fTRYMOCs1eqG0/D2CM8sdgou4ZleC2WkbethUugu1/AHWw+4?=
 =?iso-8859-1?Q?PkNc4QjcB54SB3bdapFzFY15NBlA75FDiIQzbkNBSsdDBEdGmcknIDuRcG?=
 =?iso-8859-1?Q?pwGNc+IIbK6e0qjwmmw83lq3Ud8cc80gebqlGylIs/w/DI394SDWV4WWBX?=
 =?iso-8859-1?Q?mz0V3WoNVm71ZUA2RWHrATSjiccXHnIfH2shZ/V3kdTnRCocy2ghybySxy?=
 =?iso-8859-1?Q?+JqF5HIsn2lSQIAIg80ZUktKD/ZVBoD5WT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2450d001-f637-44cb-d6eb-08dd9cd5bfdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 04:20:01.7168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kG9UD9g24OvmuEsFlJwnQ8s0eaIp52eMluKzJjJkLSY3OXehYcWHznJ/ZhRnlQYBkAIdvSABa5MZ/umbzv7X3EYrfAYfi/zvnXnhaQdk+vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Michael,

> Subject: Re: [PATCH v4 5/7] ui/console-gl: Add a helper to create a textu=
re
> with linear memory layout
>=20
> Hi all,
>=20
> I just noticed that Dmitry Osipenko had already pointed out a similar iss=
ue
> earlier-so my message was somewhat redundant. Apologies for the
> duplication.
Yeah, looks like you and Dmitry identified the leak independently, almost a=
t the
same time.

>=20
> Also, I made a small mistake in the patch I proposed:
> The call to glDeleteMemoryObjectsEXT(1, &mem_obj); should be placed
> above the #endif, not after it. Sorry about that oversight!
Your patch from Open Source VDI repo seems like a better solution, so, I'll=
 add it
to this series and send it out for review in v5. Please add description/com=
mit message
and your signed-off-by line to it.=20

Thanks,
Vivek

>=20
> Best regards,
> Michael
>=20
>=20
> On 26.05.25 15:06, Michael Scherle wrote:
> > Great to see this patch making progress.
> >
> > I've tested it extensively, and unfortunately, I've noticed a memory
> > leak in surface_gl_create_texture_from_fd(). The memory leak is hard
> > to see since the memory is owned by the gpu driver.
> > On Intel hardware, it's possible to observe the leak using:
> >
> > cat /sys/module/i915/refcnt
> > or
> > xpu-smi ps
> >
> > In on of my use case-which involves frequent scanout disable/enable
> > cycles-the leak is quite apparent. However, in more typical scenarios,
> > it might be difficult to catch.
> >
> > The issue stems from the mem_obj not being deleted after use. I've put
> > together a minimal modification to address it:
> >
> >
> >
> > On 15.05.25 04:45, Vivek Kasireddy wrote:
> >> There are cases where we do not want the memory layout of a texture
> >> to be tiled as the component processing the texture would not know
> >> how to de-tile either via software or hardware. Therefore, ensuring
> >> that the memory backing the texture has a linear layout is absolutely
> >> necessary in these situations.
> >>
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> Cc: Frediano Ziglio <freddy77@gmail.com>
> >> Cc: Dongwon Kim <dongwon.kim@intel.com>
> >> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >> ---
> >> =A0 include/ui/console.h |=A0 2 ++
> >> =A0 ui/console-gl.c=A0=A0=A0=A0=A0 | 32 ++++++++++++++++++++++++++++++=
++
> >> =A0 2 files changed, 34 insertions(+)
> >>
> >> diff --git a/include/ui/console.h b/include/ui/console.h index
> >> 46b3128185..5cfa6ae215 100644
> >> --- a/include/ui/console.h
> >> +++ b/include/ui/console.h
> >> @@ -422,6 +422,8 @@ bool
> >> console_gl_check_format(DisplayChangeListener
> >> *dcl,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 pixman_format_code_t format);
> >> =A0 void surface_gl_create_texture(QemuGLShader *gls,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 DisplaySurface *surface);
> >> +bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int fd, GLuint *texture);
> >> =A0 void surface_gl_update_texture(QemuGLShader *gls,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 DisplaySurface *surface,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int x, int y, int w, int h); diff
> >> --git a/ui/console-gl.c b/ui/console-gl.c index
> >> 103b954017..97f7989651 100644
> >> --- a/ui/console-gl.c
> >> +++ b/ui/console-gl.c
> >> @@ -25,6 +25,7 @@
> >> =A0=A0 * THE SOFTWARE.
> >> =A0=A0 */
> >> =A0 #include "qemu/osdep.h"
> >> +#include "qemu/error-report.h"
> >> =A0 #include "ui/console.h"
> >> =A0 #include "ui/shader.h"
> >> @@ -96,6 +97,37 @@ void surface_gl_create_texture(QemuGLShader *gls,
> >> =A0=A0=A0=A0=A0 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
> >> GL_LINEAR);
> >> =A0 }
> >> +bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int fd, GLuint *texture) {
> >> +=A0=A0=A0 unsigned long size =3D surface_stride(surface) *
> >> surface_height(surface);
> >> +=A0=A0=A0 GLenum err =3D glGetError();
> >> +=A0=A0=A0 GLuint mem_obj;
> >
> > +=A0=A0=A0 GLuint mem_obj =3D 0;
> >
> >> +
> >> +=A0=A0=A0 if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
> >> +=A0=A0=A0=A0=A0=A0=A0 !epoxy_has_gl_extension("GL_EXT_memory_object_f=
d")) {
> >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >> +=A0=A0=A0 }
> >> +
> >> +#ifdef GL_EXT_memory_object_fd
> >> +=A0=A0=A0 glCreateMemoryObjectsEXT(1, &mem_obj);
> >> +=A0=A0=A0 glImportMemoryFdEXT(mem_obj, size,
> GL_HANDLE_TYPE_OPAQUE_FD_EXT,
> >> fd);
> >> +
> >> +=A0=A0=A0 err =3D glGetError();
> >> +=A0=A0=A0 if (err !=3D GL_NO_ERROR) {
> >
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mem_obj) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 glDeleteMemoryObjectsEXT(1, &m=
em_obj);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >
> >> +=A0=A0=A0=A0=A0=A0=A0 error_report("spice: cannot import memory objec=
t from fd");
> >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >> +=A0=A0=A0 }
> >> +
> >> +=A0=A0=A0 glGenTextures(1, texture);
> >> +=A0=A0=A0 glBindTexture(GL_TEXTURE_2D, *texture);
> >> +=A0=A0=A0 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT,
> >> GL_LINEAR_TILING_EXT);
> >> +=A0=A0=A0 glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8,
> >> surface_width(surface),
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 surface_height(surface), mem_obj, 0);
> >> +#endif
> >
> > +=A0=A0=A0 glDeleteMemoryObjectsEXT(1, &mem_obj);
> >
> >> +=A0=A0=A0 return *texture > 0 && glGetError() =3D=3D GL_NO_ERROR; }
> >> +
> >> =A0 void surface_gl_update_texture(QemuGLShader *gls,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 DisplaySurface *surface,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int x, int y, int w, int h)
> >
> >
> >
> > That said, my OpenGL knowledge is somewhat limited, and the
> > documentation wasn't entirely clear to me on whether deleting the
> > memory object while the texture is still being used, is always safe.
> > Based on a quick look at the iris and llvmpipe implementations, it
> > appears to be acceptable.
> >
> > If that's not the case, an alternative fix could follow this approach
> > instead: https://gitlab.uni-freiburg.de/opensourcevdi/qemu/-/
> > commit/4ca806871c141089be16af25c1820d3e04f3e27d
> >
> > Greetings Michael


