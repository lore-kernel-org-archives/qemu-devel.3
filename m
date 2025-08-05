Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31558C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 06:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujAnB-0005V9-BV; Tue, 05 Aug 2025 02:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ujAn6-0005RI-Lp
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 02:04:52 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ujAn2-00011g-R9
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 02:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754373889; x=1785909889;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GdNimUGrVTXm6SmAlIjtT/mzYoviTOuy4ezNTjfhbew=;
 b=CBkbsyf0otsrOQmepn3+WhDgreDQEZt1JKF0PoBIsW4MOcG3FHuLBCsf
 WWTW9iw7/SUN9vEyqVutgWAqre+h4F/ufiAp6JtH4WLFHdFlUv+67zseg
 +zj8uThTr7MZWqORjP5/B8u3jI2vCwmywvfeiRRLxpHPHSv/ysXlDZx9Y
 9Jxxbpyi+EeCS+mTBi7GuD0NTzWO0kxzHloRX8d7TlzOF/G9V0vPY8l7i
 HVHq9dnE3/i0aat8UOQj7jVMil6Vnc75r0lwjZXt+lUon/nf15af3Kmap
 vt8qVzSpNig0SuM+t6+8MY763ge9XGi3/ZUKomJjdZ86UvAdYtwBU+/n7 g==;
X-CSE-ConnectionGUID: XI5uoIuySWq8EEbxxti1LQ==
X-CSE-MsgGUID: LqUePGDvTX2x3tQDIitT3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56571173"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="56571173"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2025 23:04:43 -0700
X-CSE-ConnectionGUID: FW5uTrxQQoG2CWXP7G0Dpw==
X-CSE-MsgGUID: uYIRkUAvRRiN9TBYNzrBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="164675822"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2025 23:04:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 23:04:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 23:04:42 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 23:04:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3ZVBn/aEtETxKdOJdgv6nEo7GEwffi7BTjCCH62eQSx8ju72b2Qd3muFqMBmM3kvTB3zLlgOLZf/CGa11YQp5/oD2KdsaeYdQVzl6DfY09VXimxzFKbTORQQliMtwXJsh2k5z30jzt3vN2t+7xBv0RXO5qhWIVsqLXj5S8Gd63Aq4rn/mz6+1OaIC9vVXalO0duwuWV2WecqRllxw/a0M642M9TP1rkzp2Je25Kmjtmf7zMSK/RcNnYy5LpoyOaF4CwcNBC/ClgRFOAXuTqyCCyG2eTa7TI5B/CKPk21WDvd1RvSJU0xZLJjSdb9DiABNjSQ2MBT+mn7ZysKzyYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgebAZx4kObNCLVEer6yCG+oSzmAZTpn6D74yjw6cr0=;
 b=bQ/ZNDxqxhidna1/v1U0/CcK4R7HgdzdxOTsOo8y/RRkcgrPomrwzFji9vgfgLoA1zCC7ThvNaRS7TbzK8dKdLMe1eFFFx63mKkR3wzOAYfgWFT3HCH6TuMxVGxwjIqnZq5ugGTEtdIWaCoWxPoa1X+9Y84tDgCq45/gVxaLhl5477bvAZcvSYC7jDYHLulzwNCyzms/dB592N28YRSi6PhCopiB/1cl9ScUBWueOI3cypIte5WH8+ziySkfnKubspHXH8y3PoMnlrBbqHRgOtzUZFBnlUnCmqyVEbJyI/OjMFc4uvvKO/JFdZZZnmEoltHRiehjT9lQ3QgxLwXb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA4PR11MB9011.namprd11.prod.outlook.com (2603:10b6:208:56b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Tue, 5 Aug
 2025 06:04:40 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 06:04:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHcAGojBHGmrySSMUmmVahA3JzrVrRJFhCAgAFhZeCACGetgIAAmKcw
Date: Tue, 5 Aug 2025 06:04:40 +0000
Message-ID: <IA3PR11MB913602B3C31F1C016EF23C579222A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-3-zhenzhong.duan@intel.com>
 <9989340c-c304-4208-9c33-f54fc5d1e865@redhat.com>
 <IA3PR11MB9136DEF9919BCB1B4F9662619224A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aJD/1w/sNcy7C3Uv@Asurada-Nvidia>
In-Reply-To: <aJD/1w/sNcy7C3Uv@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA4PR11MB9011:EE_
x-ms-office365-filtering-correlation-id: fe332257-8fa2-46d3-0ccc-08ddd3e5f748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dz5qpNSPA5xX7fOWHZsPBNi79GXs91bHcH1WEnxuEDYXKkB8rBIFkyOPzo?=
 =?iso-8859-1?Q?1/jTpX+U2mtlC9f9Rf286i6sYGiS25cABH9rZBgj/6v5LEfucoBxNs3FKM?=
 =?iso-8859-1?Q?GRX6rRzSnTNERVTl94V9HCr2K3jtFGljsu2CgqQeBrm7NIFwbNiHYeLW2u?=
 =?iso-8859-1?Q?M3LA2jJA+RltiS/MbxaDULY2wp06A/aLRu5RzkuCrsbsdYybTBcn0++rNn?=
 =?iso-8859-1?Q?f756KyK3ViFpN7Pwp6/cBUvX2KayItJlkH0MYfClSeE15DzsNqDUWwvZlU?=
 =?iso-8859-1?Q?uYWTLPME2m4pPQBRdrjUW/7+lkgarSDLfr1Vonktg95TvIioNY/7akMk6D?=
 =?iso-8859-1?Q?s819F5TWphEJlC1EcFvbkkzKcnzKFnu/BceiWohgQU835UeRCHAjXtk7ET?=
 =?iso-8859-1?Q?LyNFAobXcsdoqhC3of6jCexQ1MBbUA1FTpHvIygtckl61Dnz3SuIqLulip?=
 =?iso-8859-1?Q?f+huLy3OPJoeVU8vcIbBO5w3iecDDCceN4rUYjOsHJ1Y2FZjvoU3PRhu/Y?=
 =?iso-8859-1?Q?JVqGJa0OV0bNSTK3b0nsIC/SNshlT8q8xlWCdT8xfU/OJ2UUqNSU8Q4liP?=
 =?iso-8859-1?Q?s/6O60lSbnAQQ4UuSTSVXH8TaRO9Oj08mBE5Tbh9ilExkicc9MxepzBDIR?=
 =?iso-8859-1?Q?d3WpuG8T1Kk/SQ1gikGoNc9J+FGTF2ybvxPD4BlwE0t+AoW6AyGzoUGEF2?=
 =?iso-8859-1?Q?Moa2RTLZIMHuwUoUx0bbxpKYi34MMt1FkwukAtC2mUpRcY1+3S82qSAwDR?=
 =?iso-8859-1?Q?hFZ6dlm0HFuwoidyb8q7amluXF8layxq/8d+PXJDE8W7fEzf/SOXMBfLDB?=
 =?iso-8859-1?Q?yY91Aa82y9ekum9daWi4gcCIxUo2UsAHP8MmAxqjvogKtlpt4F1ZcIyKNq?=
 =?iso-8859-1?Q?7j91EbSBJQnFkhqZS+EEioGBT8MDX9O81etzL5CNm/s5Tg3Ja5BSP5ste2?=
 =?iso-8859-1?Q?aIReb8XgRVsc4PLgv4RrRSiDbNevWLSXExR0zXrG+ORvqdHvnzjZek0Ox+?=
 =?iso-8859-1?Q?imMZK1I7CKoUkADwUA6vZIMTkEg409/7d6+AxacayEg3rWMl8Z5A7WPaS4?=
 =?iso-8859-1?Q?0XcVr3jiadV4T3LZGdum3X84OAhEZa7Y9cMaRQuZNomZhTYDDGYP7qBPZ5?=
 =?iso-8859-1?Q?xcHSquDOUqu1PUtT/0zJpaGHTFAZ+QAZ7Jep5xcMNl9iS4hJMCOlZkV32X?=
 =?iso-8859-1?Q?QcF6wR2+2tmd8UPBCfN2uaxFlPsWOYb96L+9pEaLPh0IdrfLZp3zeAP5Zw?=
 =?iso-8859-1?Q?dM67zcfcUN5uQTTEwfixKH6HP58VwB4LaytvIfLSQWH7CCfls4wRLQQYmT?=
 =?iso-8859-1?Q?oYEtsbnE8i1gy5cQaed8GqaI1g2yHyzyAHWWkNj0wrWphkHIEoOv8B4W8D?=
 =?iso-8859-1?Q?fwv7BGGRR8EStSsDbrST5DO1GdGWDH5oS8Jw25jJeDcRNrbykpj0fq0mQn?=
 =?iso-8859-1?Q?IiiUEMB6ZucGFWJlqVsAASzKzLVNpnkgFGZA5zmZSmFzbynNZx8e00NyaX?=
 =?iso-8859-1?Q?gaLnPLdsdsduINsxU2xWG5DK6h0GOMtin+Jjghy8I01LkntNmWzQxkKEY4?=
 =?iso-8859-1?Q?KWI90mU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Qi7yQk+W5oldIHkWYj8UfD2hWeWjTQvEd6fyAJRu/pY5XXa4bjl2csrQjo?=
 =?iso-8859-1?Q?+gxJ8SShB6H05gziudxt/fuzX7Y2WrkFlhtYxhPFyHHjlCIkl2ebyyyOzj?=
 =?iso-8859-1?Q?wkB0e4b5crGarGIDi6WpLcT5ZdPycpbKpLpTSAIYgErcg9I2XR8f9APMGp?=
 =?iso-8859-1?Q?wE5BA67douO8pV4Sn/yd2DSTDl9P2BoFMeTW8IMeR3AGnwOlkrvSiaRg1c?=
 =?iso-8859-1?Q?TP2P0oaSi0NNOUaiVedRf9SKFeQZ935gZFUBZiQ3jYxjbZt7oxR23m3VJ5?=
 =?iso-8859-1?Q?PJpibHd8stOTOd9f5FiOGR/WdUSwXcosOYjsdJJndtJ7gU08k1JlsAd5Fa?=
 =?iso-8859-1?Q?8gvEur1eOX+L/qrFCiai804Ih33NcS4j5HwsVe9U/r6MAvrGjYWO/+Zupb?=
 =?iso-8859-1?Q?KHP5s4nd7/Lu7sOmvVfDmYZOATgruJU1HyWsykWumRyoU6StafDKxrr6iF?=
 =?iso-8859-1?Q?oNm21U23DfXUgZiE3udsgEUabU1+SEKfw9rtLZHUfPtMTqWpUl1rElhLtT?=
 =?iso-8859-1?Q?Nf9emgj4AO6LpZohU9tSyYssXWs0UP6xMVFvzdk1ALCXzqP8wwH7lvXxlU?=
 =?iso-8859-1?Q?6Sg9j6N35F27oR/YuT776vugEy3cjeUw9SBql/ubXuRYZA6smw7BM0Fk9z?=
 =?iso-8859-1?Q?FemRvzRcVbC9vXOnbbBvZ76g6uByfPvm+qRZNBldqxKcLq4v1YsX57b9wT?=
 =?iso-8859-1?Q?+4ji/f5n2nmTpbTQGmfK7QqkavArWvL3iNJVn7u8UzpWm952iqNeVPIHDX?=
 =?iso-8859-1?Q?p7W7OgJIZeVogSxY2BwbpvQBrawRqtT4ipZdf2lwGRZwV8TufAd+PK3Yzu?=
 =?iso-8859-1?Q?pOkj/RDCPPEF8QlYpEp+7na8r6X5ego14PSAZjpAt4lAJGiQwiC4Gp4A3X?=
 =?iso-8859-1?Q?6r+cT21yF0Wt/vXrlVjkOlb4VCB9OEI1SBBEI/tqcmfgYMsosbIyV3pNbS?=
 =?iso-8859-1?Q?TJ16Ev0dN8ChQWsz5mxKVeifHegVd1uO9amzmGSWFgWBn5v+OfMr5hccCR?=
 =?iso-8859-1?Q?GWug7rr0g87HsORhdwFeQQ0dj1UOen72ZQnn51SCoLbpw9bWeDMqq776CW?=
 =?iso-8859-1?Q?S/iCCIwk2kKB21zy/eMZ5o20He5aQzTf+RmIx02wtZo6excgK4HUcCuU0d?=
 =?iso-8859-1?Q?XCWs2n4aGlAOe78h3ByHrAYTzNnCHLd0D0awmL2nlpaezH08ZURgUJqiT6?=
 =?iso-8859-1?Q?Vikc6aoc5Z6Lu/CVxkFKjDUfK8fb40v2oh4uFm7Ru/AQ4MsrqMM+6BEnsd?=
 =?iso-8859-1?Q?F3anWFsq4sl4y84y901oGFFUOzHKSJv9zihVHQK9RbZAjvQopIBiNBTh/7?=
 =?iso-8859-1?Q?ursvH5V+IfpMdVIRm6ZxZ12xSDGmlYCxCR4FtBxfrbd1cNWjDHeAJUrDrL?=
 =?iso-8859-1?Q?zdTBsiPwISymw7WEGYN7fqRMkpSPMwpVpxCLhIJeUYbug5LJxQobTUO5Oa?=
 =?iso-8859-1?Q?Qizz2+PlSOW1IPrzhghXzS/cW/m3hCiyhY63ebGJxRTamCPr72Mc3K42bW?=
 =?iso-8859-1?Q?ET7O5DCeIpQw8bNDepbWPdDSGgcExVhPOeF4QjZ2tH0y23SW4sgcSnF006?=
 =?iso-8859-1?Q?cMmmarw3c/hhwLW3rDlLIdLIs9IQbRE3/J56deJasnZMVLuziWH/fUzUlv?=
 =?iso-8859-1?Q?Vm26r2Y7pNyUs/WnJElQW0Ko0oOzRsZ9Z3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe332257-8fa2-46d3-0ccc-08ddd3e5f748
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 06:04:40.5678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZIum3RHStFsnNL0fkrBsJs2rQyQT6IiWpsO7u8ltQyTg+jc3QSV8w4DMFIIaFxxV9N9LF5CEZYNj9bzd1TFLE/EX0+l4HMaQmKaVKxRn4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9011
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v4 02/20] hw/pci: Introduce
>pci_device_get_viommu_cap()
>
>On Wed, Jul 30, 2025 at 10:51:13AM +0000, Duan, Zhenzhong wrote:
>> >> 2. there can also be more than one vIOMMUs with different user
>> >>     configuration, e.g., arm smmuv3.
>
>That's correct. But would you please elaborate how different user
>configurations would benefit from this new op? I don't see a good
>reasoning behind that.

It is the reason to have get_viommu_cap(), get_viommu_cap()
returns capabilities of vIOMMU which underlying VFIO device attaches to,
but indeed, it's not reason for leaving out host capabilities, I'll drop th=
is line.

>
>> >> 4. It's too late for VFIO to call get_viommu_cap() after
>set_iommu_device()
>> >>     because we need get_viommu_cap() to determine if creating
>nested
>> >parent
>> >>     hwpt or not at attaching stage, meanwhile hiod realize needs
>> >iommufd,
>> >
>> >hiod -> "host IOMMU device"
>>
>> Will do.
>>
>> >
>> >>     devid and hwpt_id which are ready after attach_device().
>> >
>> >I find the above sentence difficult to understand.
>>
>> This is trying to explain the reason of order between attach_device(),
>get_viommu_cap() and hiod realizing.
>> What about:
>>
>> 4. host IOMMU capabilities are passed to vIOMMU through
>set_iommu_device()
>>    interface which have to be after attach_device(), when
>get_viommu_cap()
>>    is called in attach_device(), there is no way for vIOMMU to get host
>>    IOMMU capabilities yet, so only emulated capabilities can be returned=
.
>>    See below sequence:
>>
>>      attach_device()
>>        get_viommu_cap()
>>        create hwpt
>>      ...
>>      vfio_device_hiod_create_and_realize()
>>      set_iommu_device(hiod)
>
>I think it should be:
>
>    vfio_device_attach():
>        iommufd_cdev_attach():
>            pci_device_get_viommu_cap() for HW nesting cap
>            create a nesting parent hwpt
>            attach device to the hwpt
>            vfio_device_hiod_create_and_realize() creating hiod
>    ...
>    pci_device_set_iommu_device(hiod)

Good catch, done, https://github.com/yiliu1765/qemu/commit/34b02bdc0d615c60=
d1b07bfee842aabf1f7e2b28

Thanks
Zhenzhong

