Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ADBC41513
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 02:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5cpc-0004GM-UH; Fri, 10 May 2024 22:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1s5cpb-0004GD-3A
 for qemu-devel@nongnu.org; Fri, 10 May 2024 22:51:27 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1s5cpZ-0001ch-HM
 for qemu-devel@nongnu.org; Fri, 10 May 2024 22:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715395885; x=1746931885;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8YRCiSU2CI/E9iOD5wzwfNUlDitWWfRmfAI9yPFDvK0=;
 b=oAPKToTZBr5wiagGYz+klE2NLufumZ2diHSrFIq35awOGF/McOCyNMIj
 6J18er/7tEb8u/FWkWa1OeEemYLpZuic+aU+7+1S4Yg2kceLh7jTLpHVX
 rloms4Fk1raEUK7Cr+lKEMp1pawybEiDE37uv0QMIxKsL1z58K4FuBzCP
 DlfNTS5yfJsUY4OOzP7akzML+Swr+vGpzzkKPBc5QVPvstbFj7vWuzpwc
 g7P5+dcpzxDLPStOzz1NBtFRJ+KZ3t3+VOjewwf1ojbO6KsCGlooRfljw
 I2Ey+vkJ2Zsppu+PuZr8xo4WSvrHQFyeaffsc06NP/RLSSm1z70THTB1S w==;
X-CSE-ConnectionGUID: nBLvz+lRRXOJueCvNryBtA==
X-CSE-MsgGUID: Zo38oOdJRH+bHnCFfHlTdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="15209619"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; d="scan'208";a="15209619"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 19:51:23 -0700
X-CSE-ConnectionGUID: qh+JcX4oTn6viiW6iDk/Qw==
X-CSE-MsgGUID: DJCJZk2VTiCtHpAti5xUEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; d="scan'208";a="34348936"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 May 2024 19:51:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 19:51:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 19:51:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 19:51:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 19:51:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnTlu2BEF3DJEg2yBhnlNP17JYVpx+ABNBbjC2PmxMfU9L8aPiahcRuRCjnNNtjCT4FxxcNvdXwOD2g2PM3UQrQzq+0WA6fiW/QmGTnDBtRONvhuUnjwrUcNkXN56a9I4Oh/abL+PN7dyqk2k/DJg8MHpRBUlHE7tK/wbPoP7qQLyuzj1+zGOQsc4d4HotX/ua/pDUDfVeCWd+oIx2fslGiBpLEQylMHoObzOQHP9duI5pBjsuVH+015jtL1s1n5Ctjc9BQrbysFT7l2/Glq9ZWbK6j7J2+GvnYVeP5Wm+ppUEcJd4FTRLLpaSqjmTDJq/arbj/WDqEpq8PiYGIbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ7VG065yPDEYo+bjXv6GVhwY6A4VOGb8imqpuXGAtw=;
 b=ZqVnDikqGrvvUJuAGF4CuhLgFee869hrBcnk2X2SOrm089T69nP4F1hRa5dyTF27Ogj/EL4OPAJcV4dUmkjG3jzZDcEwO3I7YFSuDTF67jZDzZ1Doq0oo7Z2f5Ccs4N/RLwaFTpEq4P9jBRRDIPS4qpzuPa+gtmvN5FA1ykqf0YG9y2syBsMjL3uzFybWb8l8eVXk3ZB2gVlIS5ZPGTTER6jlJm28AOcETv5cYe+RpVnVXULXifH1iFbo8DI0P2Tctg1QN8CDLCCLwLcq/VIr/vI9X2FkV9RmfsGTkqvywo1v1M9z9vDZdGbtciNBKu7ked7Ot44wKUeaLT678xvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 02:51:19 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828%6]) with mapi id 15.20.7519.020; Sat, 11 May 2024
 02:51:19 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>, "Fabiano
 Rosas" <farosas@suse.de>
CC: "Zhang, Hailiang" <zhanghailiang@xfusion.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] migration/colo: Minor fix for colo error message
Thread-Topic: [PATCH 1/3] migration/colo: Minor fix for colo error message
Thread-Index: AQHaocDilaCKRMHLnEie5tMCPBiIQbGRQ/4w
Date: Sat, 11 May 2024 02:51:19 +0000
Message-ID: <CYYPR11MB84322D8588F2BDF2B74B4DA39BE02@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
In-Reply-To: <20240509033106.1321880-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|CH3PR11MB8155:EE_
x-ms-office365-filtering-correlation-id: ba15525f-4484-4e72-fd94-08dc71653c1b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?E3OFbmZkOq0wtLyINZi2AiVblUFRGDH0qp2LDdtTiv8WMtqr3GkceMbGImch?=
 =?us-ascii?Q?Y2ukaHEk/53n2Ddnu3GdJXlJ6ihxP4pU52dK7j+Y9ZLZoy3v5kOkKoMwkXGn?=
 =?us-ascii?Q?QZVW1AbkeC2zuqOCz9AU5XNmiemgNttt+jNb10p5hwdXkeiObBDGUMWGc0WY?=
 =?us-ascii?Q?C/wb88A7OWMv5/dqH5wBNwcNmgqodd4WUULDLUk/fAMt903dIHJqpr6YzclN?=
 =?us-ascii?Q?btI8ucspET8M9sCIwl0SlEq4soFjvpLdE/M1DuT6u7CxebIH3+oXSijmuitz?=
 =?us-ascii?Q?oWi7tBQLifKm400tS9J3CrTGBAGC2wBQqlxQ1JUOBNPT7nNEWmN4UUJgz6hU?=
 =?us-ascii?Q?j2VnB6EYyoUyBBJtX4kdpsCABGQviPXJINyHU8lN5lqpjmhzvRUMYB9StvHu?=
 =?us-ascii?Q?eWIYxahE/WWOt6GH2uSonhl78kAaiSA/UFrvIhxSnzpWQRBKuu2+WfD+3yxX?=
 =?us-ascii?Q?4OkmqUZn21fS8e3I370u//1OUUDdPmgaetNkuhVXEDJ8lH4P+Mw/jSzxmXi+?=
 =?us-ascii?Q?3hzh+9zSn3tbfgc1phNMOPukNg5Zs521lEHUrnT/r1+VkSNXipCNdkF3Zcsz?=
 =?us-ascii?Q?s7NOQLEGmG0AVRCGBeC0KqjcdygygN65y7HhwyozknOsPm54/DfnXaBsAS75?=
 =?us-ascii?Q?6+JNFx9qgmQbckPq3uy3w9zkI8a3VCRPepno5KQ97mn94MGaEYnUj1qd4sef?=
 =?us-ascii?Q?Ln5LY7Vaa9ty6ImB98gb/LAiXk3P86A7smwk8NjNrh+PheNnv/1UFMYH3bdT?=
 =?us-ascii?Q?7AofBbeMnJDFtuQSNfJqnSOwmhqmwx083/WCVQG8DGw2tE16vJT3MRbE75du?=
 =?us-ascii?Q?nBzFucCRRfnBd9fo0PJtg5KB16uLJy5q8DnU8I1gHiyOtwU/VfhQknitzxgz?=
 =?us-ascii?Q?L/tvLKhHw40jmZqkMR/fPa7+4n8qehS4ejSEGxf++EN93ZeM6/U7nayj67GB?=
 =?us-ascii?Q?a1flbphNwM3vgKWdHqTp0+CmEMIHopz0AjM5I9k7qy6o0TGaUX51ZI1n/qyD?=
 =?us-ascii?Q?YSfpW/rohRVceHp6p05rRb6US+1apbloJU1BIfYKrebTdtqbW6yGVbDfdWOi?=
 =?us-ascii?Q?cOWh1j20brudy3OMmQWOKhaLWK4OqOoviGjGw4VoaWb9zrTcknUN/t3W9y3S?=
 =?us-ascii?Q?8kmjVWy3WYWuM1fueutYqUYr5yBkhbdV15C9M6ufwpARVrUCW9fzGZkNbV3J?=
 =?us-ascii?Q?ExCs8/DiEU8BPd34Cctq+KiTe2+q+ctKAt3y7YckbY7YtLrRFwTKvKZm+29K?=
 =?us-ascii?Q?mMNWkeqE/HnaVh9HJooaq/vogA18FkYo92l7ZiKmFg6Uc8u89w9h8DrtSs7u?=
 =?us-ascii?Q?NlpGy5GTfmPhwlPiMzKmyneUUbAoY5LwiDXeiG5mz4OFJg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CmrxITi08CHH8r/w3J+kdRU2lOM34c0f1uduc1QQ0Qrt9c1rS06HmJ8V1QiL?=
 =?us-ascii?Q?js3HSIffOr+e/vkOEDMgBuC7xTjZHVuEvPNQMRxYFKMPGp3A12YD/6vd4Nek?=
 =?us-ascii?Q?apU19G//U9X8cyYrduMLIc3Eohnt0OIWYMpH7aFpvv31ITfvZj6otHPiCupO?=
 =?us-ascii?Q?DJ9skQOZUkRJeuYG0tAeZZA8s83IWy0IG4HMm/kibL6IMYLOVMWDpGzIMiUZ?=
 =?us-ascii?Q?37V9lfwXzS6acfAHG7NEcLsUu1tZ9NksnsQS+j3mv+P9XRvsAMCSp9HqS1r5?=
 =?us-ascii?Q?+qpBMaKuYFEhfo/mDz8TwJvg/sTUeJq+hhPo/u+Z1DA4U5dBZwJdcoXgOCH8?=
 =?us-ascii?Q?uN1DBnmMb4NdKqf8Stfcm3S9blUXu1iMZcx1+NMrCTxUm+0NKLh9kuRJNQpl?=
 =?us-ascii?Q?tC7+LRBY18yWxzy24lseEDOIqWALbUrqnu1Xx9ETY0Kt5LUoPaNh+vLL1/6Q?=
 =?us-ascii?Q?ZJKWLs5mDd+nq53441dmfOjD/tRTGT23rhm5dbm9Xvl9pRvNinys4C35AMjg?=
 =?us-ascii?Q?Sz0EJiOUiMA73V1OEEjuhSKkkKaHjSoB6JCaJdbs+D+RKvbhao1YwEEnhRYL?=
 =?us-ascii?Q?xN2J6+Or3qxkmqfcbjPw53LV1w4sXbdfjIyQJu9sEZWkD3OZxMrQtWzuEM3N?=
 =?us-ascii?Q?gHhCa+OHV47gW3P1SHPXGjIzzs5magIUtmvoZAMhI8e4Fcs7Z4gb5yhcWwH8?=
 =?us-ascii?Q?cVmRZ0URohpmqofmuvn3U0HR0Rll9tj2uo+2Skg5OXR1Ks1+u8ndq8WTXOcf?=
 =?us-ascii?Q?5f9GTyYeJC8NwaM6lUFOl9HD7ebE0dOADV6r0+yB75I39b/DEmfboZV6W1MM?=
 =?us-ascii?Q?yvmdQOVw5McEKHaRdwPPr28YVba/0ISZsuPJ+4ezsYU1TiFryOCRZCdeF2AL?=
 =?us-ascii?Q?8axi7MYjnguo1T8qQql6pCp6NIJ2/JQWW2rs4p+j4vYgkQHjOLrmGRhyHrVz?=
 =?us-ascii?Q?DKRDZHqfvnwzQKgzQue9fcpjuIC92zQbhyJZOwYavHjvnJiXflh17CJ40dUf?=
 =?us-ascii?Q?4uQKbkpZcoFtj9LwCwIFeT6SwGJfIHiWOG7LhEOCPiuS1LnyRksZZTsPUtR6?=
 =?us-ascii?Q?pKu8GL9eQWwoIS9bbpYDFU12JczxFyU7bP7OlaUGCFjAYAh5qPmKLZ2bvAyg?=
 =?us-ascii?Q?/Ae5M4UkFTzvi7Hdh6p2OyHaH4PHdKP/LPuLazDPdKeUrKto6IrC6V3gOhsH?=
 =?us-ascii?Q?jqTzN7ae3GPaiKL6Pey9yO2xT8+xISlGl+n1Cd57uKfLXW/EAox5HFV+2Rc/?=
 =?us-ascii?Q?HgMQGu7y2OSBFyYa1lJ0F3Zfi5qJnqPaw3LZdb6G53GMKF9yt1rtHzTkYpOj?=
 =?us-ascii?Q?TNGtP/svVVc/ns9tgM2FsHzOPLBvq9SJV0ZWts5Xq7NAsiRE7N134rpvfgrQ?=
 =?us-ascii?Q?eqdlmk//1uS/tJtA4lnQoh7cfv8Fdsk5lLfLqUzeWlOmBUw0jAHhfdI3tby5?=
 =?us-ascii?Q?S4Q0guCBpOBhAAUmse25zIL9tgqpnNKM8w4321HGwk1bymTUsRCvE34O9Cw9?=
 =?us-ascii?Q?ssuVyHbWlgkEytCD0cpYzOrY/t55RI9hQ1hr4Mnlt2eYz/4KH65IL4nfYvzK?=
 =?us-ascii?Q?sbhTqYFUNDAWCo4iJAvhOT9fKq5nF/KG0BhiI9sa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba15525f-4484-4e72-fd94-08dc71653c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 02:51:19.3550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xegn5tij5aHTd5sGLkuoRBXetoNFStLFdMT4NxktGOOYSq+a2R1QfthC5B++mjDQIpW7ILc/GgEXpWsscV96ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Li Zhijian <lizhijian@fujitsu.com>
> Sent: Thursday, May 9, 2024 11:31 AM
> To: Peter Xu <peterx@redhat.com>; Fabiano Rosas <farosas@suse.de>
> Cc: Zhang, Hailiang <zhanghailiang@xfusion.com>; qemu-
> devel@nongnu.org; Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@fujitsu.com>
> Subject: [PATCH 1/3] migration/colo: Minor fix for colo error message
>=20
> - Explicitly show the missing module name: replication
> - Fix capability name to x-colo
>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

> ---
>  migration/migration.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c index
> 6502e169a3..b4a09c561c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -517,13 +517,13 @@ void migration_incoming_disable_colo(void)
>  int migration_incoming_enable_colo(void)
>  {
>  #ifndef CONFIG_REPLICATION
> -    error_report("ENABLE_COLO command come in migration stream, but
> COLO "
> -                 "module is not built in");
> +    error_report("ENABLE_COLO command come in migration stream, but the
> "
> +                 "replication module is not built in");
>      return -ENOTSUP;
>  #endif
>=20
>      if (!migrate_colo()) {
> -        error_report("ENABLE_COLO command come in migration stream, but =
c-
> colo "
> +        error_report("ENABLE_COLO command come in migration stream, but
> x-colo "
>                       "capability is not set");
>          return -EINVAL;
>      }
> --
> 2.31.1


