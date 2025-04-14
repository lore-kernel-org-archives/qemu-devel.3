Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A79CC369B6
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Frw-00032c-72; Mon, 14 Apr 2025 05:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4Frr-0002yG-4n
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:12:39 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4Frm-0000Fq-OC
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744621955; x=1776157955;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pEccH3HB4lWe841mgEOBIWwObrfc1RuK+fCNLfRixKg=;
 b=XFMdibCUEaUJjfHI79fs0IEQK3EdrzFli1//qGSowMewotF+7GquzR40
 V4OdbTUmY9d3F3ns6Knjn+YrduynBXiiDUXBFiAWF0gdMqcj8hZWG5cEK
 0m8iNQa19eFqkZLxLB5oAbN18T4tSMSf8rp5oaplAdalAUZAGe3OROe9+
 6XYTwD6Q/Wd1a+ENcV7ScaWWawRz93dlTA1FTI9UepTVwR5noXh660s6w
 QLZi09VWpDZUm0M99BvqPvN95CNMXhFTrpgm4Giz5Wjl3+O3Gp0UET6MI
 02kLkrgZcaD1oFXMP0tWfP04E4NKaag0WqROQ/Wnk1pigF3L8OSt8oEyL w==;
X-CSE-ConnectionGUID: RKjQDvPnRUiC5tuZtXgzTg==
X-CSE-MsgGUID: dM9k6k0eRVq7bqSiAnm5Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57466723"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="57466723"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:12:31 -0700
X-CSE-ConnectionGUID: G3CPeSf+TP+GaLbHhnaTbg==
X-CSE-MsgGUID: q82ZvzLsTOG50/CTW5h4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="160719251"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:12:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 02:12:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 02:12:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 02:12:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2rAX+FFXofNqDLDyclTHmQWMBYKHuMjp+OMHobBrW7szoNTWp7OB7cIDtP+6ZXHyKCvZfgENZojHjsLtxAcBYWGaqWYd3eVD+smTy2U/Crybu6Q0Ar2eRRlviBUdZ4QfAi3pcqEFBWUTSzueJcJMMqWQC6YPSE+emTYxM82rIsCRNJ+sL7+AGFiq4R0+vMkW4+oneGdSWeV5AqvvWLRhUDNBAcNvNwpHY2KZIcqfQLR9a2XO8KZkXN8OUCFocjB9Z1pF3cVl9NksYiTvp1hVzsz8SsIB0Vd/mlb72tbL8RQaNm6DCrl9GuRNSTHBexu66tlSwMH48kZ3bOw/cEbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HTQ9jwCJvkqBkqGTqYokCM3oYlkrcqBqfjBrCWWfFw=;
 b=NcVTWgDBt7WvRN60JgmcY25CHwxByHR3kN75o3axkggk3qm+FHxJkkiLTvj0oxiUF881najKbuKD/ujf9Xpo1SMYir+/QCWYwt3ldaibvK9VrBuMi7Mfz+6zSS+x0lQodhgpNewB3kwjboEepfQbfXZlwwyfen+luei82ViutaQqsfJudKvTULxvjBx5w7yRwuTR1p+puibFu1VPGU8j8DZj5jMxye2fXdclhSiXiCFP275qV/D9fx6DYaufPySDJaCagYlJ13J+uLIKk0vl53h3VnKdohuJhvG7CC4M0U2fawp28GCIahOI01Dw3/DSXrDDl2Ssl3vYvgN4pA3A/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 09:12:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 09:11:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Topic: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Index: AQHbqstnyFbNUaToNUifB0k78FO5YLOeSUMAgASOkvA=
Date: Mon, 14 Apr 2025 09:11:59 +0000
Message-ID: <SJ0PR11MB67445A30856A88ECFAE9B99C92B32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
 <2fc17189-2154-45ed-b9f2-e67583651f7a@oracle.com>
In-Reply-To: <2fc17189-2154-45ed-b9f2-e67583651f7a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4528:EE_
x-ms-office365-filtering-correlation-id: 3955fb4e-7387-461a-ee52-08dd7b346998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lVLuTGQsQR2t0A3B4orIga7VTydbNdnfmTwOp06I/7xx+JCXx+MbguKYEg?=
 =?iso-8859-1?Q?VzW9GzP4T5oS4NrohBF8tkOIEfspDCStdV1qviagAEQxs6AGefLSfddsee?=
 =?iso-8859-1?Q?eG1NCywmvUBpHaY6C5tCIrFEDHgfc1vD3R8pRo1kHa1L0ZuhvPyiVhLPnT?=
 =?iso-8859-1?Q?fw3d4rA+8LuPRIh1yej5pgOpvvhUF3D12KjFMakuizePhTi63fdH4pFNyZ?=
 =?iso-8859-1?Q?7rWFc5NXE/7dLfZ9zNWyji8DcWG06eQezdNTmn51dQ24JTTbw84gHFPsEW?=
 =?iso-8859-1?Q?f5IQbDQchVZuNkyKk8IFKXmwS7ZarEOvuUPsA9VFD0xLSnZ9lMOEBJmW+t?=
 =?iso-8859-1?Q?UqK6wm/YIxAGGcmcIUymOUpRm6+vkTjhtJ8g7EVsGd7/9NWY2qCu+LpbRy?=
 =?iso-8859-1?Q?YqoMAqLz7KbhTJZN7xwpn+1yPl0DgGp4JC6bY+RDM+53ZTLLVPEr+iNZsV?=
 =?iso-8859-1?Q?cixCRZa8o5skwdGCt7m/dEV7MCmQjeobkyjqgqUaraX8L1PUU4Xs/MLRa/?=
 =?iso-8859-1?Q?+x+/TGL0xUoMw9lGFO1SOu2/lMhO/kKLtZ1MBSINeLzZdYT97S0YMFNi6X?=
 =?iso-8859-1?Q?2li8kCxH+4r9VNfBJXwMDmeBuNtac6zd9YSzIpMFYcAYI24nVNFZtEja8F?=
 =?iso-8859-1?Q?XW6MjvbEh2Iw1HaDtT2XCFYIXeS7WI3wayLobEkW+N9B5CyCDZRnmd2LWx?=
 =?iso-8859-1?Q?kkRsx4IB6ty1JPn5rXTyh2UuYfzvmLliF13jb9P+5SgZQYQRoVMwr86dgV?=
 =?iso-8859-1?Q?4IOUzz6eKc3w8IPwl3W6KQ5ORsAMoUmTbGp78c6CdatseXiDbgDS3YB664?=
 =?iso-8859-1?Q?hgfWq1LESaqTsaK4vVK6pdyZgbWzX/EFyK/cWNdSVu9y6vYjdvfWs+SsfA?=
 =?iso-8859-1?Q?32vGF+lHQI2Sizlb8kqQISDS2uqqm/gsYBsvS2q3nG8fPOU9kTzq9x6HN7?=
 =?iso-8859-1?Q?nMuX2kEKTJolUaEZJI/gXLcZSkhpmISsI0xTx2fE9+QhQf1RtVJSIfG1yv?=
 =?iso-8859-1?Q?pgLR/LySuuVzymH/dH5tqxsHqsvR4+Sf529pu+xfd/H+k4yboR3BSnceT7?=
 =?iso-8859-1?Q?k39du/nR4xQvQ6Fq/1+UIq/vQB4Wv4pWfnNxIOnnD21h/1ROCivDpgZ78d?=
 =?iso-8859-1?Q?h1nAyDWQN3vpYchDkK+Z+x117xyGsueDLcGJ0nmhgjeO8PRqicVC886Gdw?=
 =?iso-8859-1?Q?CsAdkirDxRwlizs2QzLUTDrACPDVGi7feXA17j97lTWDWpVNewpls5cR5+?=
 =?iso-8859-1?Q?4oMUvgjRLTgq/7QbUBs2zeHPq/ExrKxWN8meQKSjjMAQUiXCXt8q19c2TP?=
 =?iso-8859-1?Q?oD7oWcNaXzumFP6EiJRLH9VxuAMgJpfcHNzLxbT+Qxr8oIhvczx+bYylxm?=
 =?iso-8859-1?Q?p6sOsJpTxwk9tlR6wZjzuBT0kUL2sZTVxeZF3dhFqxq78ZLvyTMOQyL4CT?=
 =?iso-8859-1?Q?wenxVdbw9ggVcgIrdWBhGYPmAwjmmb0+coewuOcXBWbVvzJXKKCDEFhK81?=
 =?iso-8859-1?Q?Znf39H25E8Dvb9B/gM0v32+JrWrelIef+BHWFk8sT6TQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qMFlLEb0Yf7VqavYo+TfhRc2j8+k+ZJPJYML2olXLg44ZshmBi6aG1kUcT?=
 =?iso-8859-1?Q?FDBz511bcjvmkvTSQI6z7O4YhynLHeG5QHv8Yvd9tqccmZ//GjF8xvA8bx?=
 =?iso-8859-1?Q?2alrd6/jN6T/nsF8xZfc8Knde9xH5YoiNEaiJQm+wnCUjHNY+YYLQ6e+ae?=
 =?iso-8859-1?Q?HxuWAP97nikkgpTexzg+2QhLarvs4ebkUZEDCrtHZL1g4gMt40neukAgN6?=
 =?iso-8859-1?Q?rS2PjSw+CW3vFBIdHNVOugP1M0SX2gQf43mDHXGNG51nbEElSRMGOuO2K+?=
 =?iso-8859-1?Q?cvZYJugletnFlfQesW1/s+d6dNrhOwRxCD3ZCAfX3IVqnYqLr+eR8eJcbn?=
 =?iso-8859-1?Q?RYNIzDGGMEGiDBlP2oZ29gGGHeqEII+hdJTbA4yvrhpQdOsam6r0S5Keb4?=
 =?iso-8859-1?Q?vXg6wo4rCtBCTtYapT3B5/H6lzx+w0rIWhjapk2A96bdlKuMruqIQ70PxH?=
 =?iso-8859-1?Q?lWItnOyQcW5k918rkeQzhsFnkKrlmMnABH36sufx2OyB0pJjYY7dZjesdm?=
 =?iso-8859-1?Q?wwAZB4XDd3NsM4xf1o23NkdP08tfv+tXNga44xi35DqRxk89MKYUfwreL0?=
 =?iso-8859-1?Q?wCLJ3/CGnibh+Vc9YpfPG/5EG4oeo4dV802NEU2D+ETdrUuuK2SlCPELQN?=
 =?iso-8859-1?Q?epVgcD1X/2MuAyTM9lynsbKCK9SSEylOUos9fmGG8GnEJWXoEUX9zC8WYX?=
 =?iso-8859-1?Q?qNhsb8b9efwEwh78MFxks4EcUOf/0hQhhKuL/fsjUrD7ATO+uIxw1i5s53?=
 =?iso-8859-1?Q?QFStxGC3SE/YCOGjCIQOOWfmT9mgXXg56hCa4nYZ57pHrxdp0VjCLd41O+?=
 =?iso-8859-1?Q?98al2/YfsKsa6fZETvYcov6gzg9cUPWDx7QNKLWVHHNGqE9rDEeR66RY7l?=
 =?iso-8859-1?Q?jqZmv/UwwCUFhgpC+cYvnJWnZci/OW17uXcK1pDnwnRCM2IIk7S5Lxj1v4?=
 =?iso-8859-1?Q?XgN+rET8vs2lgGIfGZo3iRb6vjDDKB3o0powMN/UbM2eBDuyEI3a7VQRdT?=
 =?iso-8859-1?Q?yWS+WINqqAqhyldeaFyRXkrDrWA1pjV87J6mv+9WonXl48MbeZiSlAjgCU?=
 =?iso-8859-1?Q?RlyMGKmbz1UnN/jI3GOEzTFgoiJG5kXiBaGZ8/0NIqPRVfZ4YOHJhcbEVA?=
 =?iso-8859-1?Q?SnvoyUrll98mZE7BINFDVTSCiEGrZLs2sqHQurlaFh2lG1k9uuH54qzaKc?=
 =?iso-8859-1?Q?0Ht17MRIx0VeZNkpWwTB+7EBmHL7s0uzGNzCB1KwE1IUfo+qzWogpRMfH7?=
 =?iso-8859-1?Q?37dbQiU9FeODrAi5G+0Jn2Yhk1ING6KSke/ShLvAPdF7+UMWiNTldHAXUu?=
 =?iso-8859-1?Q?5p5/X6u9uN1smSvGQxLhX6MOL2VZanY2wiavuA6rK/meHFnKZtzTZ9qKWC?=
 =?iso-8859-1?Q?DYVgev1cmmLSYF/Epl6PcSc/KA/rG223HpVP53/Idoxr4w36vwYUB+4L6Z?=
 =?iso-8859-1?Q?zKH5EpkhUfWIaD8MSbm17DRbnxs5B7V+EzdxbD9gEUw7QVgUX8P+vqI2os?=
 =?iso-8859-1?Q?WgZw8xdJMwh+jOVmDtUxKIdd1CCMUdcckCE4c842onCEPhxwvcty3fzlky?=
 =?iso-8859-1?Q?YMYpFHVq3Ix0uoFSgNJu5oDdTRWCR889v959UOz+Wz2+SkP7BQydWkguBq?=
 =?iso-8859-1?Q?iJgFmItuiMJ4IQCFmnfrSxQwBf08mHPJBg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3955fb4e-7387-461a-ee52-08dd7b346998
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 09:11:59.6041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDbcGipyZD53MA9srmKD+njVG+0dl8lZ9OL3k0hZXk5ZMeijumXKv3/LxhMVzZCXOf4qhkeEc2jkKECYXcD8gFHeekhtNlt7OWJGdtYlPv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
>VFIODevice.caps
>
>On 11/04/2025 11:17, Zhenzhong Duan wrote:
>> The saved caps copy can be used to check dirty tracking capability.
>>
>> The capabilities is gotten through IOMMUFD interface, so define a
>> new structure HostIOMMUDeviceIOMMUFDCaps which contains vendor
>> caps raw data in "include/system/iommufd.h".
>>
>> This is a prepare work for moving .realize() after .attach_device().
>>
>> Suggested-by: C=E9dric Le Goater <clg@redhat.com>
>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/hw/vfio/vfio-device.h |  1 +
>>  include/system/iommufd.h      | 22 ++++++++++++++++++++++
>>  hw/vfio/iommufd.c             | 10 +++++++++-
>>  3 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device=
.h
>> index 66797b4c92..09a7af891a 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -77,6 +77,7 @@ typedef struct VFIODevice {
>>      bool dirty_tracking; /* Protected by BQL */
>>      bool iommu_dirty_tracking;
>>      HostIOMMUDevice *hiod;
>> +    HostIOMMUDeviceIOMMUFDCaps caps;
>>      int devid;
>>      IOMMUFDBackend *iommufd;
>>      VFIOIOASHwpt *hwpt;
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index cbab75bfbf..0f337585c9 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -18,6 +18,9 @@
>>  #include "exec/hwaddr.h"
>>  #include "exec/cpu-common.h"
>>  #include "system/host_iommu_device.h"
>> +#ifdef CONFIG_LINUX
>> +#include <linux/iommufd.h>
>> +#endif
>>
>>  #define TYPE_IOMMUFD_BACKEND "iommufd"
>>  OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass,
>IOMMUFD_BACKEND)
>> @@ -63,4 +66,23 @@ bool
>iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                        Error **errp);
>>
>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
>> +
>> +typedef union VendorCaps {
>> +    struct iommu_hw_info_vtd vtd;
>> +    struct iommu_hw_info_arm_smmuv3 smmuv3;
>> +} VendorCaps;
>> +
>> +/**
>> + * struct HostIOMMUDeviceIOMMUFDCaps - Define host IOMMU device
>capabilities.
>> + *
>> + * @type: host platform IOMMU type.
>> + *
>> + * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this
>represents
>> + *           the @out_capabilities value returned from IOMMU_GET_HW_INF=
O
>ioctl)
>> + */
>> +typedef struct HostIOMMUDeviceIOMMUFDCaps {
>> +    uint32_t type;
>> +    uint64_t hw_caps;
>> +    VendorCaps vendor_caps;
>> +} HostIOMMUDeviceIOMMUFDCaps;
>>  #endif
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 48db105422..530cde6740 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -324,7 +324,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>       * vfio_migration_realize() may decide to use VF dirty tracking
>>       * instead.
>>       */
>> -    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +    if (vbasedev->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>          flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>      }
>>
>> @@ -475,6 +475,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>>      int ret, devfd;
>>      uint32_t ioas_id;
>>      Error *err =3D NULL;
>> +    HostIOMMUDeviceIOMMUFDCaps *caps =3D &vbasedev->caps;
>>      const VFIOIOMMUClass *iommufd_vioc =3D
>>
>VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>
>> @@ -505,6 +506,13 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>>          goto err_alloc_ioas;
>>      }
>>
>> +    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev-
>>devid,
>> +                                         &caps->type, &caps->vendor_cap=
s,
>> +                                         sizeof(VendorCaps), &caps->hw_=
caps,
>> +                                         errp)) {
>> +        goto err_alloc_ioas;
>> +    }
>> +
>
>I think this will fail on mdev (and thus fail the attachment mistakengly a=
s
>there's no IOMMUFDDevice with mdev) ? In case it fails, you can just do:
>
>	if (!vbasedev->mdev && !iommufd_backend_get_device_info(...)) {

Indeed, thanks for caching this.

BRs,
Zhenzhong

