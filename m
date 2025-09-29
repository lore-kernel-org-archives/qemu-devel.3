Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C91CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 03:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v34N9-0006YW-5J; Sun, 28 Sep 2025 23:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34N4-0006Xq-TH
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:16:15 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34Mq-00080q-7c
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759115760; x=1790651760;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SXnJRteH9hrbgBnlSzTjp9YU5zP/MIcBYa+v/KLABm4=;
 b=RJcp4SY2655eeJahXezA9In7D2hgwK179eD2VjAuYl3Kfm+nQZMlWXyp
 cG85H6WqHjPYS2PY58r5OhQLXzd8gll6sGRHYz39B5FhlKSaaJQIyMDqJ
 WAphDHBr0uxTKTyzxaqkdoKXupt5XuDxJJuCNfP1RQ1VFTGftj4G4pPnj
 I5e0Ww7yg5mnY8m1O7Pe8UqU0QaRnoj9YeV6CjRUeVmTyhJCzQdFAlROJ
 ppJr0j19wzQRBivCejP/p8sz69eOLEOa5MsppmhClexAEONG6+CS5Vs0M
 XxR3zj1t58dixtf+sF4h9gLMvpgCHZagXHGtDqXq6ftRn+UvKsyQwQsSl A==;
X-CSE-ConnectionGUID: WWVCYhN+QZqG9pzkSmSWCw==
X-CSE-MsgGUID: y0XcfSAuR12eIQsqgHMbZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61264077"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61264077"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:15:51 -0700
X-CSE-ConnectionGUID: eM6sSlZmSmC9JFo7oFVy1Q==
X-CSE-MsgGUID: K5/5u4TNTvumW0ApW3Jkyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="201785958"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:15:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 20:15:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 20:15:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 20:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdKm3Bta9T8/OKnvDYrVe9iAq6niOcOkSQ5I5xcjWxcA4da6HxGSVDDf2r5XFYemxOrSPuYbQ0NHXBx5Q7/iH7FhAzaIcq9x+vlPz0auggANsQqWgR2uUrQhdmxKYzUV/hXUoF2sHxK3UH3eWy1adOwgjXNPlY/zm/84Oj3diTeqmeHD1FZQv2T58n2A0Dx4r+Dulqn27Q+SW8TKhLGJtHhdp37qFA4+qQwlKrVUWby820zazhw080e/vcdWb1Y3Caq3W2xqdCNIL9vAWCBPqn9bjghaAJ3+NrFKp9/LcPIq+203NFqxH2frYMaaVBWGA4LxcekBiCzy91s0wZXJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/2/OlV5JX6f2x2vjtVIB0VyvmujF/knVPvD2DNERP4=;
 b=pnfaQAZGmqyrbmKK+5cAgTdS38mV3sc8T3t53uaO+GIJN85wH+JYd9IiTDJol1AJcFPbeyVrbHveGAmDRX7DJJ1QotBlzD05bPLuhYnlB/L4y7ZW3jopzToo0VnWVMs0/sChDM/BdzYW19Uxa+nmP6gA48iCI9980hdaqOCfCdsJV0zuAJVb64zu7j6PqYQdHooXEIuW0OgZtvpdv8G7Qb3DoTs/vMMeiw0EIJZrYuGeXEX9Tbm0Jykmc8M8g6+FQq51m3xC+e/sv8NMEv9QwfDHEQyFN9RoKmqnWqLUcW+ikv0SNoGxceMszMSKFOpqD2/+N7xBhxFL31nYRqeekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM6PR11MB4515.namprd11.prod.outlook.com (2603:10b6:5:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 03:15:47 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Mon, 29 Sep 2025
 03:15:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>
Subject: RE: [PATCH 2/2] intel_iommu: Simplify caching mode check with VFIO
 device
Thread-Topic: [PATCH 2/2] intel_iommu: Simplify caching mode check with VFIO
 device
Thread-Index: AQHcKTQG4LITBsMwBUmT6WTGaRb64bSpi5iw
Date: Mon, 29 Sep 2025 03:15:46 +0000
Message-ID: <IA3PR11MB9136B073DE72E2A703D20AF0921BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250919070638.983549-1-zhenzhong.duan@intel.com>
 <20250919070638.983549-3-zhenzhong.duan@intel.com>
In-Reply-To: <20250919070638.983549-3-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM6PR11MB4515:EE_
x-ms-office365-filtering-correlation-id: ea277777-2298-492c-14dd-08ddff067be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?L+G+HkZE3J8jtg7xeBWRrRdSg/OY5CZuZz/Zb7uP3PzqxuRtFF6SPgRmq3XC?=
 =?us-ascii?Q?iY1OsoVsy/MNA2NGSenJwtTLu2DLRKf69PKp/cYzyWcwXDwLOb8rArRVvMWA?=
 =?us-ascii?Q?SjN6YZiPxE3hgnmd+C9ft4+HeGpMG871G4oeU6tzM8BJrB4JGMuDfs1chTtU?=
 =?us-ascii?Q?y3qgLnarjrty4bapVVFSeh+2uzeTRWIoSRbPU5R0X5IRY59VxOqHmNhuf3tH?=
 =?us-ascii?Q?rqwkXTQwz6KZ30Z+OwzKQkO5bCr40zOarWjCV32+eAFOOUoAZ66ENyyMFxje?=
 =?us-ascii?Q?2qb7Fb+m7AB4jcKOIb9KhlgpSL2K8QSaiguufHergVROJXB1B7/+Z1QX+qYH?=
 =?us-ascii?Q?Zjevu/rYVdWYVcb9Wk4/yLCg958/OzZQEdcXTBDEG98Dg8BLLglWR0Ip0v3L?=
 =?us-ascii?Q?spREHUS+Iap9GtgkUeEkU8+BHuofxm+gK+1BL7wLdAiev2sACLMhIWARl+Yn?=
 =?us-ascii?Q?T4e/W8qVhZubNlDdfgz69BA2v/40XSpJlcHPu0QiBKszS+BbbdqeOOY73SPq?=
 =?us-ascii?Q?Mm/dOtyomxyPVJnsQddOrx622xSVXOdO3aFwkMtXarvY9vowdg2UKlWXRdBj?=
 =?us-ascii?Q?SWd1Jks28RgnsrFfQZartgxX/wz+kc/b1u6igQFhSVUt9LBoDleawBmlEVUp?=
 =?us-ascii?Q?grmbo2vPaozuB+7U5cHZDZfCO14RMR8B+LH9dfRQaANZtyJNp6tmLsb0qS4b?=
 =?us-ascii?Q?EdYlSjOYEPBgHoSMjYyEWC/KC/FKAvAlaMnbPs+m+fpQ38qqC7UGUdhsh575?=
 =?us-ascii?Q?wguS6ozdBGxna0S916YSQ9eJMxWOgE80XbfC9LrOe0BAmgjquC7BlT3CW4/X?=
 =?us-ascii?Q?YncLr+8+yjSP3rSYuyH1DWDonHuhiczo7/Qo6xx2PlRqF149PVSIb9QJcYg7?=
 =?us-ascii?Q?De8Ze7OxiPv28w6oM+v7gw8uAQMixh686YM6Kpc/9tAQi9O9u/Yw/kWqq4S1?=
 =?us-ascii?Q?D1oEFn+40UvZgsdyHlYRjd4SxcmZaMJEmjsZMOvjVKl5BVdBcQKrgjoC0Q3H?=
 =?us-ascii?Q?V+fbCubeCh2xdJgoIkz6obguprmETj2JKaLqukmSBG0SNXan+QZ5V4zr/Ofc?=
 =?us-ascii?Q?UUFZ/ayT5d/YHr591DPiK44/fHoOP0GxEOiymf/Au1E/D3GMcOxF9V7uK09v?=
 =?us-ascii?Q?El02mKqAS+FN31DzSUoXmrkyqHaX3z+MWhlov37o9VL8w3GBjsHo2QKFMY2O?=
 =?us-ascii?Q?GAQG1LIS7l+eU+OCGCQjp6Vq5S6cbk/HEmTMG7+6ywSqdf/6IpBsU+RGzFIV?=
 =?us-ascii?Q?MU5gMIobfIeSoW9jd9HeQAOAfYNJPs7JCvqwDSRH2TZrxhGsu8WlvKXg7oNS?=
 =?us-ascii?Q?SFI7b/ehl55gAmzVUp+k8jl5lZZY62xQRLGtfWB6EZgNLdty8LCkDhaxdDYv?=
 =?us-ascii?Q?/5PeSNb+cmJ/S9FfPxWqFTOZHwOCjSDJLXqgpswAap/nKop3z+aDD292AU0G?=
 =?us-ascii?Q?uzHb3Av8NXBReo41bpll04EKYgQ1QpqS1YxiWkj90vAviqvBXeM1T9QuPT7R?=
 =?us-ascii?Q?B/+Wqv5VW8OD1NxfI290+8SvMvT91rLg/W9X?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g5dbVptgJWppXPGGgljbV7NcP3PWVaKAXXNHT66D0ejL3XBiNLfCUNrhiPBm?=
 =?us-ascii?Q?EOtirpnYjzrO/6opxZ9G7rUw1/z7451OY5XeZjtevX28SnYulqVw7qhv8uhA?=
 =?us-ascii?Q?OuOWHv4s/cLCOBPdZ+eoJZX9vaLqsYEd8I9Ig1+7ZXmlP5cLRDvFfTfElqlb?=
 =?us-ascii?Q?oHuWDwMfSlhXs8Ue68oPCr8S0QZ/UhvcGRoOl91pa0GwLKLR1+2t/4T9CxER?=
 =?us-ascii?Q?iL6ySg0EDf1/DA3pdOScmyeegKPiHb2Is639hB2wisVf6/0nRbJMaJCnbCgz?=
 =?us-ascii?Q?4CXUbdWCYhbS2XIQ7heVmGeCpbisVdYB1xEToQajcGyymb8W6HeMVOvcL9+G?=
 =?us-ascii?Q?thEFFeZcx+XB0fk28yJKGspr3QZZniT/ClCtC9WGIxvRFiF6eB0zMahj3qDX?=
 =?us-ascii?Q?i27vQz7Wx6fH4mozJjNnco1u5lC3fLZdAoSPP2GQR89PEkqBqjpHGEcMgvqt?=
 =?us-ascii?Q?gg6VhNw8JD1xh7y36dleQk4vtCttdBteWT4h+xCYjU7HB9KWsl8GgUCIVK1M?=
 =?us-ascii?Q?BrsxSqEQAqsXZnXcw0AN5QBoNSn31xZ/EUtRQU4Xr0Y1ujmcqcjeKXiR8XEL?=
 =?us-ascii?Q?ZnMQSqaT1/MDVpSh8YX1pOj5aeGq9UfZX3knpe7ksq+XzeakF4DAQgdFrU7a?=
 =?us-ascii?Q?0YeAVSUT88IE1DF2gL/zly/OjxZN8sSp1xhq+FCQdVZCBNzSVUPyKgTowpih?=
 =?us-ascii?Q?rOBbWbGuW4DbmuIzQImGeKohGe60TF5W1MEvDBor99TNjNs/GzbxTqclcS3W?=
 =?us-ascii?Q?6PBSuqF9adtZWJVeueo4f6Z79Y1/wsRyKBGaKPSJQbYyd0FK2Ol+GZaJN1Sm?=
 =?us-ascii?Q?SIYinihbL/qAxYjpgngBV+eHr3dC5KHDC0t5gaDzHI5wr0l22+cu6mjynJbq?=
 =?us-ascii?Q?VKsN7ckrj3Kc+4yz+h/pZO1h1bEM3wZ1+f1c1JJj/wI/2E83JUJNwGN+pGBM?=
 =?us-ascii?Q?5lSbhT6SzhTdnTr74j/A+TNnjAQnP2L+Xc3G8Z+bI80vaSYthTONPMSCB+zG?=
 =?us-ascii?Q?qqQk6FgDlhLfHPvZQNGV/ZoGAm3nVXMmc+lhscCZYJ96Wx5789YnsRSH8uIQ?=
 =?us-ascii?Q?cX6ub7EwRjk7x2KZwcv9uQ8L8qV9YHlMef6y/1gWQtUdZrKHD31nBFFtNidG?=
 =?us-ascii?Q?P6MVqIGTQofnMOy6g7ujNE6rOGk7fMGbM1IKrl87k9RVYZvrmaMKdekgk14S?=
 =?us-ascii?Q?K3GaUmaGh5gqgSARofyVI3kkrks5v6Z2Y1HfZNCgd6HersGSMaq/BMYisvQT?=
 =?us-ascii?Q?M6ngWtRBk/+eNp6NwO/NQXBqtFDscXdu2JtMvPJYrXOj68sCXn9SaHA+c3jG?=
 =?us-ascii?Q?JcSvVEI8iCJXtGRJnJBMVviz+fRK9b7NFDZ4+eKE7HEVPx2M5A8ZpQ9bwrct?=
 =?us-ascii?Q?WfN3zM3cUE/IrosVPjCTwOkNXozMcPGjKOnxj4a3zq/BnBMBySW1VJcN/XPz?=
 =?us-ascii?Q?zYV6mLF0Nj5GlWMUxNNeBZV0qHcbH/Azpn7bN384sodj4umnp6yHijxrWUzt?=
 =?us-ascii?Q?yn5ihORDcwvNVnf38vr7XyyjeZVcmSnPNX+sPnI1gBI9VDv8Yv9ruyetxU2M?=
 =?us-ascii?Q?0ut1hQglerAaNrsId3xhUmGxLdOyR3gWUNC3UOQi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea277777-2298-492c-14dd-08ddff067be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 03:15:46.9073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEqfNj7pMS7lsdYrCFufuYSKrbXUh47ythGh+7LnRK7nZ/D0B+2Rn4JKNZX3B8y+XmSkmgAU4Xdj4bl7782lI/Ge8F5EGXT4d7DPKnKO9uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4515
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Subject: [PATCH 2/2] intel_iommu: Simplify caching mode check with VFIO
>device
>
>In early days, we have different tricks to ensure caching-mode=3Don with V=
FIO
>device:
>
>28cf553afe ("intel_iommu: Sanity check vfio-pci config on machine init don=
e")
>c6cbc29d36 ("pc/q35: Disallow vfio-pci hotplug without VT-d caching mode")
>b8d78277c0 ("intel-iommu: fail MAP notifier without caching mode")
>
>Because without caching mode, MAP notifier won't work correctly since
>guest
>won't send IOTLB update event when it establishes new mappings in the I/O
>page
>tables.
>
>Now with host IOMMU device interface between VFIO and vIOMMU, we can
>simplify
>it with a small check in set_iommu_device(). This also works for future VD=
PA
>implementation which may also need caching mode on.

I made a wrong assumption on VDPA, currently VDPA doesn't use hiod interfac=
e,
so commit b8d78277c0 is still needed for VDPA. I'll have to send a v2, sorr=
y for noise.

BRs,
Zhenzhong

>
>For coldplug VFIO device:
>
>qemu-system-x86_64: -device
>vfio-pci,host=3D0000:3b:00.0,id=3Dhostdev3,bus=3Droot0,iommufd=3Diommufd0:=
 vfio
>0000:3b:00.0: Failed to set vIOMMU: Device assignment is not allowed
>without enabling caching-mode=3Don for Intel IOMMU.
>
>For hotplug VFIO device:
>
>Error: vfio 0000:3b:00.0: Failed to set vIOMMU: Device assignment is not
>allowed without enabling caching-mode=3Don for Intel IOMMU.
>
>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>---
> hw/i386/intel_iommu.c | 47 ++++++-------------------------------------
> hw/i386/pc.c          | 20 ------------------
> 2 files changed, 6 insertions(+), 61 deletions(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index f04300022e..5c67b42dde 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -85,13 +85,6 @@ struct vtd_iotlb_key {
> static void vtd_address_space_refresh_all(IntelIOMMUState *s);
> static void vtd_address_space_unmap(VTDAddressSpace *as,
>IOMMUNotifier *n);
>
>-static void vtd_panic_require_caching_mode(void)
>-{
>-    error_report("We need to set caching-mode=3Don for intel-iommu to
>enable "
>-                 "device assignment with IOMMU protection.");
>-    exit(1);
>-}
>-
> static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val=
,
>                             uint64_t wmask, uint64_t w1cmask)
> {
>@@ -3731,13 +3724,6 @@ static int
>vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                          "Snoop Control with vhost or VFIO is not
>supported");
>         return -ENOTSUP;
>     }
>-    if (!s->caching_mode && (new & IOMMU_NOTIFIER_MAP)) {
>-        error_setg_errno(errp, ENOTSUP,
>-                         "device %02x.%02x.%x requires caching
>mode",
>-                         pci_bus_num(vtd_as->bus),
>PCI_SLOT(vtd_as->devfn),
>-                         PCI_FUNC(vtd_as->devfn));
>-        return -ENOTSUP;
>-    }
>     if (!x86_iommu->dt_supported && (new &
>IOMMU_NOTIFIER_DEVIOTLB_UNMAP)) {
>         error_setg_errno(errp, ENOTSUP,
>                          "device %02x.%02x.%x requires device IOTLB
>mode",
>@@ -4378,6 +4364,12 @@ static bool vtd_dev_set_iommu_device(PCIBus
>*bus, void *opaque, int devfn,
>
>     assert(hiod);
>
>+    if (!s->caching_mode) {
>+        error_setg(errp, "Device assignment is not allowed without
>enabling "
>+                   "caching-mode=3Don for Intel IOMMU.");
>+        return false;
>+    }
>+
>     vtd_iommu_lock(s);
>
>     if (g_hash_table_lookup(s->vtd_host_iommu_dev, &key)) {
>@@ -4910,32 +4902,6 @@ static bool vtd_decide_config(IntelIOMMUState
>*s, Error **errp)
>     return true;
> }
>
>-static int vtd_machine_done_notify_one(Object *child, void *unused)
>-{
>-    IntelIOMMUState *iommu =3D
>INTEL_IOMMU_DEVICE(x86_iommu_get_default());
>-
>-    /*
>-     * We hard-coded here because vfio-pci is the only special case
>-     * here.  Let's be more elegant in the future when we can, but so
>-     * far there seems to be no better way.
>-     */
>-    if (object_dynamic_cast(child, "vfio-pci") && !iommu->caching_mode) {
>-        vtd_panic_require_caching_mode();
>-    }
>-
>-    return 0;
>-}
>-
>-static void vtd_machine_done_hook(Notifier *notifier, void *unused)
>-{
>-    object_child_foreach_recursive(object_get_root(),
>-                                   vtd_machine_done_notify_one,
>NULL);
>-}
>-
>-static Notifier vtd_machine_done_notify =3D {
>-    .notify =3D vtd_machine_done_hook,
>-};
>-
> static void vtd_realize(DeviceState *dev, Error **errp)
> {
>     MachineState *ms =3D MACHINE(qdev_get_machine());
>@@ -4990,7 +4956,6 @@ static void vtd_realize(DeviceState *dev, Error
>**errp)
>     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>     /* Pseudo address space under root PCI bus. */
>     x86ms->ioapic_as =3D vtd_host_dma_iommu(bus, s,
>Q35_PSEUDO_DEVFN_IOAPIC);
>-    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
> }
>
> static void vtd_class_init(ObjectClass *klass, const void *data)
>diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>index bc048a6d13..01cd9a67db 100644
>--- a/hw/i386/pc.c
>+++ b/hw/i386/pc.c
>@@ -1720,25 +1720,6 @@ static void pc_machine_wakeup(MachineState
>*machine)
>     cpu_synchronize_all_post_reset();
> }
>
>-static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error
>**errp)
>-{
>-    X86IOMMUState *iommu =3D x86_iommu_get_default();
>-    IntelIOMMUState *intel_iommu;
>-
>-    if (iommu &&
>-        object_dynamic_cast((Object *)iommu,
>TYPE_INTEL_IOMMU_DEVICE) &&
>-        object_dynamic_cast((Object *)dev, "vfio-pci")) {
>-        intel_iommu =3D INTEL_IOMMU_DEVICE(iommu);
>-        if (!intel_iommu->caching_mode) {
>-            error_setg(errp, "Device assignment is not allowed without "
>-                       "enabling caching-mode=3Don for Intel IOMMU.");
>-            return false;
>-        }
>-    }
>-
>-    return true;
>-}
>-
> static void pc_machine_class_init(ObjectClass *oc, const void *data)
> {
>     MachineClass *mc =3D MACHINE_CLASS(oc);
>@@ -1758,7 +1739,6 @@ static void pc_machine_class_init(ObjectClass *oc,
>const void *data)
>     x86mc->apic_xrupt_override =3D true;
>     assert(!mc->get_hotplug_handler);
>     mc->get_hotplug_handler =3D pc_get_hotplug_handler;
>-    mc->hotplug_allowed =3D pc_hotplug_allowed;
>     mc->auto_enable_numa_with_memhp =3D true;
>     mc->auto_enable_numa_with_memdev =3D true;
>     mc->has_hotpluggable_cpus =3D true;
>--
>2.47.1


