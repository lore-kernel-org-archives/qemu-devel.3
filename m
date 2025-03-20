Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DF0C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCLY-00082b-NO; Thu, 20 Mar 2025 05:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCLO-00081V-E5
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:37:44 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCLM-000086-Ka
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742463460; x=1773999460;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RpV4Ol+yAhyJgQUdcwS+3HONhCQ2V1JQqzxip5sqxss=;
 b=fkOL0XIXtNVExF/oc9pXiRTQ8beolnGEdw6+WxArq9BuXY5BByeZv1SU
 RwJSH/Di2zc/NQJu41LBr45XtlaKW5FftlW5lG48ADbpU1oZbg63nNOta
 4mHgnSi/I004UsFd5R229HPr4OIPmRsFzyGoCwrBRfoV2bZcGgGdhgbWt
 6sAhX/iDA/JvjYvewR/cAW2hBHuUeD4HaBd72imwYm/b/zxYrWhJVta/v
 DlhTXJeS66PcNHOeSIYeW6xjkPcNC5Y+6mZCcnmbO60wkeBNJSvUO3vkc
 Y1N4va9ROeedRrPJjE6fHVEsIP/gLszGaAwEe6y/B7k4A2zq5et98D0pm Q==;
X-CSE-ConnectionGUID: 4NjFS8yzSci+KAVUSH38tw==
X-CSE-MsgGUID: deX2LvslQuSb+btE/TD18Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="61212572"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="61212572"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:37:38 -0700
X-CSE-ConnectionGUID: 6B9oyFF5TsiJjlTbLhDM1w==
X-CSE-MsgGUID: hVeaA+w5RKS3GzXZc3GbjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="146245604"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2025 02:37:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 02:37:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 02:37:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 02:37:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnjh8RXbl06PrE1XBnC91BRBBbOV8J4p8eBYkAxIoIr/J8bMxLSrpN2wCpvProEThJjsRasJgYJwx4RxTlYT50c5VuDZI4uDe+Zpp/ysuF2B9DZI2ChEJy6S7O/pZdO81HlkYGJWypPBU/s0fEC2PFXubDihMGkpZ5BZqMZnIhdeHxA5Pl+7jsPVPK8ZHLUjEfjEiuOgPWGRV+XdaKM0xytt0JpSfgxLSdZQ5nhlbArt30fPzJz7O5X5G1hd/4Uws9U20PHrYzzr9X+dOeLwcwpzVzD1jf9L5/CbTA+JzLWENnYSBIZpvWlXQJ2XwFLREub6/lWLFSTi41gG2LjpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpV4Ol+yAhyJgQUdcwS+3HONhCQ2V1JQqzxip5sqxss=;
 b=TzY3JASXto1+lhShJ4WdmaBD/RYmuAcKmnp0XToHEPJoMuCxvWU5J1HIV10q+60zHqHQRMyUDRqojdFEfF7rNqQFc/1laGugkbT3qA7kHnGqS2YM+54LtmaCxSBh03Jnzmj3sIC7KHYVS74vzhgCJAk0Uz+31XvfO0eTDRe+GQ8lsOE9yRfnihoSGVm2wZ+KCzwxO7Gr24TxtwQ443rohym3L4KlOuWByMetfvZzckekdWGKVzuAjxxZ0ze1nROrV0/QpQIYjwdbO/t5jEZuZU5RSnEgarNksn6iAG18lbVPivVsQJUUxrnOXac0BBqaUDw7qi+lf53gaovV/yXtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:36:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:36:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 14/32] vfio: Move Host IOMMU type declarations
 into their respective files
Thread-Topic: [PATCH for-10.1 14/32] vfio: Move Host IOMMU type declarations
 into their respective files
Thread-Index: AQHbl+vrFqRABx4G/EmeJ/hCcXxxFLN7ZbMQ
Date: Thu, 20 Mar 2025 09:36:59 +0000
Message-ID: <SJ0PR11MB6744D5746CE3DB691CE7F86092D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-15-clg@redhat.com>
In-Reply-To: <20250318095415.670319-15-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4541:EE_
x-ms-office365-filtering-correlation-id: b18b473e-f7b6-4da8-541e-08dd6792c369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JBck3RMR/sMv5QJpu4ENvrQGDeP7wJXMJklUB4A+Gg4lftr4dSVCvHcdrv?=
 =?iso-8859-1?Q?tkoBMdAMgQ+3EhjtEiLUJ+G713mxUEDWQ4gTH2kNQ99vuzXtPUEsNiwNpS?=
 =?iso-8859-1?Q?4HGXCjSnsRMK2dsYkfcuw6CUMM0WTRIuEPfCmgfdYfu1zEHO31idJdvLuz?=
 =?iso-8859-1?Q?kbGTN3/1qkTtCck41QfnmpQcwTESuZZdqzs7wFwJd5nWUuOTlL6WYLh2os?=
 =?iso-8859-1?Q?9Isu0KaqxxPeyQo3RD7maSejeGAhYjQwDD4q7JL83+UGyFI+RcpzI3auPe?=
 =?iso-8859-1?Q?kDg/eKZLiGs+PxlzyLVGVo42qMCoKm69xFQaXEngT+Y98BA+xkz+mz3Ajg?=
 =?iso-8859-1?Q?N0+6du/czXOAhbFJ9uq8z4egGJhfBHxSN5htMBiY+/SW+Dc9Iu9rJ/Ph0k?=
 =?iso-8859-1?Q?C8+gliHyd9AB28d+puyJrgooGC859DG/Ru6fwCOkH4jmaZQBBXIaimLHWd?=
 =?iso-8859-1?Q?WuN86EzLiTDlaMjyNN33TT0GwtGJ7E4FxOiSKeagZXy8S7SIwJOYk6WgHB?=
 =?iso-8859-1?Q?zr01XasUXCDBa4XP5ynO/HluLQqL+bYE9QKZ2a4HOtdNnkQ0EhCD6c5CVX?=
 =?iso-8859-1?Q?rqklYdFt817d8R85Wvx+QHyPwsArgmYoUI2Mpy3yIOgj9UZuBog+A3K1cm?=
 =?iso-8859-1?Q?5dEpMNTN0EMVJ74lN6TgeqO6LWKO2Gr6MCiCVywZCgVWEdpmXN5uOqIjnA?=
 =?iso-8859-1?Q?/YfzoWLS0ZGRdCBAB9zo8Dl9iYF+VyLKcJgkTVzoV46ma/YDR0nzuj+ISc?=
 =?iso-8859-1?Q?9qpB7JtAr2W2blZNSArsPqng8Gya8iqbO/NBWjNs+5iNIlNCI8wj7ZV44N?=
 =?iso-8859-1?Q?FCCBJB4AhIhl3EDdpr8H11YjYXZplhYNn8EuH8Qk227DjjmOv8ydbB2BRD?=
 =?iso-8859-1?Q?bnhGHTswwMFsOI8vTo30eYJ+Lkla9sPu+E7zos6MsCfJ5SpNlDyC/1CKpK?=
 =?iso-8859-1?Q?Y9R9M9s0F/AwvPr8OEaBigfoJ+fM0Ne2RhrNeawdu20xZpMXIz7jyOLTDJ?=
 =?iso-8859-1?Q?s52CIse+xzL+iycoWr2vVZcdEKhClN5H/CLTjLTiRc3ycwwRVtxmEsnOLl?=
 =?iso-8859-1?Q?b8mkANKAr/zV7rMUV6kAYFgDAP/9O9uzabQRbxyqQjwHVjPfnEV15qJ62N?=
 =?iso-8859-1?Q?cvJlkGdwPPje1SyIi5SNUVgO1DbRaGx552hwS43np2nI/QfXblzh08BosR?=
 =?iso-8859-1?Q?ktmbf+xWPpIsXniz+aoH9H/3ybclAY/SOzerUkEfgv1KxKiFr9gO+Acgcr?=
 =?iso-8859-1?Q?qXWe1hFrrWeraiF+01kHzca4/DHLOnjSMzqynprYf0giswB8iJEaaAR9DJ?=
 =?iso-8859-1?Q?z1R1yznUkJWnUmjk68ahNnz8sHriOlMCigfiGqX4YCjr7N78hc3MwlNz9L?=
 =?iso-8859-1?Q?yr5UhjcJjxQLUFjDWQo3SwcbwQF+XZJEhHFIogGKyQxrAp7VCgerObL0x1?=
 =?iso-8859-1?Q?0USLLfpyn0BcgYMCHoOGQRQEHgyDveVz2Nicx/AFKrHEwNoYRYO1V3QFPK?=
 =?iso-8859-1?Q?wGdPamINoXv1sOB7HwdPoG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B1fncU4iDN1LdI9+JA2vD6b16ROUlXgbkV8lny7+vT5Kjz/lQsxN2ucviH?=
 =?iso-8859-1?Q?KM/+4A6U/NztNRyLFzJXeiectZhHwwrcusg8zuKhQlxAvyyby3+ygWj7GP?=
 =?iso-8859-1?Q?8WxH3X3t3D3co9x87sOFJE2LLJCZ+sX14G8JM5IqHBRPvrT8c3JpG/xGcI?=
 =?iso-8859-1?Q?cHLrCFltS86yRn4k2mAAeDTUM1Ictggh6dMeFzpPj0wxczRTtyQUj3zFah?=
 =?iso-8859-1?Q?I39swvL+sPZoTPJ2tOMslLe1CSwXPGuSRtp7j67BoHoDFR1RVX0pyOZARp?=
 =?iso-8859-1?Q?K4Uzu1cyUDiCd+LALDR2uCMLCw5ixIKM0w5fY0j143sO6BLI12/iDPkDOx?=
 =?iso-8859-1?Q?l80Pmrw5lCBX1RCtKQQ38k0Bj1gWwu3cDL2PXQWz2zasok0xFNAiTtIeek?=
 =?iso-8859-1?Q?vp8TH83X96X654B2BH7CXjOVSOfL1orR29XagECDLrWmJuSkb8rEP8HS0R?=
 =?iso-8859-1?Q?VoVqptvmlTWZ6r3jm+qKIPi7HQupoqzM78Ko2JrrK8uTcO0lWntUIfsR6Q?=
 =?iso-8859-1?Q?Ny1qdUFUrgwN5qlKOqaSm0nhcAiU01u3Ekv2lYXLKnA6S2T9vgbmwKln2K?=
 =?iso-8859-1?Q?htiErmTvSytZxGy29IdbZEYkcQJ7wgFTubZA7bcqlW5XNM4hm2nHnej4pz?=
 =?iso-8859-1?Q?jBdcssJ22WuYA/vgivlRggNHWPU6olc3En9bSSiJpUoJ+bfBPfJZ1I4W6r?=
 =?iso-8859-1?Q?ieHqEzjNWqJjerxUk6bn4PLESfBrUb+ILTxRmKE/Mp5Uj0PPzI0vA7rCs1?=
 =?iso-8859-1?Q?pRmrVTHWHPt4XDwSi+pso9Sfev96HEjp0LcbZcA06MaSapTvV5UB4sbRC0?=
 =?iso-8859-1?Q?YXDvXxtu+AcZkXYnYBLx7/rI0ox9+/Vj4REm51RkfC1v6DZUfg9B+cOp1v?=
 =?iso-8859-1?Q?XNCNuuFwMfdPx70T+NExmaKcTCPmRpC+p8eAUyH0AYhpT9Z2AC33DUls1f?=
 =?iso-8859-1?Q?T0+F7q1YDXzAPAcIXZ40WvsQOoC5WO85KSDUX9bSk4xNnuz+pGiB2E8MnA?=
 =?iso-8859-1?Q?GclWTX3xStOGFQVXR7UfLiXCBn1edd6P5nv9pui+tdCpXUnn5YcIP+fxuU?=
 =?iso-8859-1?Q?l+g/28CLYkh5mg6kMvk2BmrTzSsLHJKaIEDHf3gFlvdbBQiq4lqzbseWCQ?=
 =?iso-8859-1?Q?mHahbdvJ66fVpqy/kOqEqVDAwZF0AHVgGIzu9VtcBQ/kWMBjs+FshnV2W0?=
 =?iso-8859-1?Q?vkZOgEsop/6l1n6MfFfjGfmUdh5qh9i1xu98TcJguT4LW3/at8aEOH8Yma?=
 =?iso-8859-1?Q?5607qbwkUY/qf0BSMSWDHXI7pUywCzz2sdAKwKJUKiPEVLc3mIX9N1asU+?=
 =?iso-8859-1?Q?rIzNp+Mf64KDqIuvFT+y6AEwzEi+PCIV3rx0r1uIr3Yo4Bybatc5YIhiWZ?=
 =?iso-8859-1?Q?hjk05k/TLd90mR8sVwERfcSS6xAbaxxT/Wch2TD+Xw8s636mm9XM3QoUiw?=
 =?iso-8859-1?Q?/X3m2Kz78RrubHU5A9gH8RMNDDi8UuSe4Yjmz86BjKPCgL68goQ+r2qAWi?=
 =?iso-8859-1?Q?HC4xQnkUnN2YsjAHVTQf9BxohgQ5XevSCMYk2pDSMpNaJRTq7K7gDXzQJz?=
 =?iso-8859-1?Q?NEx+ijWD9U8RAOFpI+7PsoQ5rD8zv31FI0DvjQGUBiOOIx8O/aI2/3YHs5?=
 =?iso-8859-1?Q?scdPhdLCLL0jAqYovfArUsH1uBu9sQm2Eu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18b473e-f7b6-4da8-541e-08dd6792c369
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:36:59.7606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPtVkQJxRkrox+lX/vBIaW6y20g6X3h8K7c9ILKDbSADB7YvRYeAqM9RNRMi1Sklqa36nBqXujBilxF7SuZJPGc+f5DWejdMIx1pKuLYrsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: [PATCH for-10.1 14/32] vfio: Move Host IOMMU type declarations in=
to
>their respective files
>
>These definitions don't have any use outside of their respective
>submodules. There is no need to expose them externally. Keep them
>private.
>
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

