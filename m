Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7047BCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JZv-00005c-Lv; Wed, 24 Sep 2025 03:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JZt-0008UL-A8
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:06:13 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JZp-0001sX-FN
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758697569; x=1790233569;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=s9smSXDmHXv0K2io4WZFAsNWAY9y0fhNs7n7xRPeDMU=;
 b=Pjv49y4lzWoBZFxUW92FAOTEgnEbKmhqIPX4+ZXdL2e/WJtdBv8tGCZp
 XSIxhQjFmeHdRBs1dzHF3CNFyoMhUY0c7emG2BjCTdTiD78FTFcdIlvDL
 pnMfQmJF3oJgokscRqJb36ojJ2mu0+1DjCQARUsaqq5h+Oxf/xFV45OV4
 XA+TO+hlqGawsJKY5VStEsnu4EgkTKyQK6HhIOD2oVZmolaFVTUC0kADN
 8dyaqMKM+DazFV+8nAwYi9diJfkIhlxt07Lc+4NBIbb9hvaRJzfloyvkq
 glpMJCiodv0pAvLp0eSt4G+HE2/tjAXGLPQHKDcgiz/ye2Y2E6JE9D2p5 Q==;
X-CSE-ConnectionGUID: Rem3hBsGS1eTvZJKjabcfg==
X-CSE-MsgGUID: vSMdZI6NRcOfTjFUtws+MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61039343"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61039343"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:06:03 -0700
X-CSE-ConnectionGUID: l7n1bMiLTWSafseEQ/4fdg==
X-CSE-MsgGUID: +2AAi2RBTHCIsIMeewsR/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="181351277"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:06:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 00:05:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 00:05:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 00:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmZ80FosZQ4uLxA0zy2sRQCUJS60e/qMyFX+XJfThQlWwp8dq9EQa/PijIgOVWK556xmJducNUlyI5ifo0Njt86n2QhYgKveNZK3me8Fjlax5yHs50lDJf9Vtvotz0gK9brMypViLYOhd0y3cFeirCFqdB4glyGFw2plhiYOCGY5GLzkL8he2nVXHNRy1LrQHzaFLHOcygPaK14FnaS8eYYCm4MQt2KXM7iIQ/zlbn4VPaJWuP56mXwnOAdkd34iDkVxJUwtInXHBuNM6u9TnhMYRqDYjm9UoedkHscFoQniTDmCwDg7KAyBkE8gdM+PzEcvkEfqCW0n5ik9eHcx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUzqOA7gQktOAyEGwQ1cDMQBW/+8DbeiuAhmiqeswdw=;
 b=TH+xqMcL4PcmDBbUgf+JtYcWnhHAY9e43t7HK2fJCA8wO/WtV3QHNTOU2Ue8SfFHK9Ci0aY6fdr3Pd8hdkNvNw8dNKPx6xCii7N/dcwiirI7xu1+mpVB4u36WHtH5nw0hlaOPz/dwKH/n3zR77mB8l1fd6xaSo9ZoYULIVfTKspq3/4OhaH903lKQOf9xlX1QtKqz1jfbJbZTWR8hKmtgeMyIOEVZ13SWzyb0BSWOkbo6gJL7psxYGkX2oGQoFtdhdkCOV+30n/dkh90SyvfzLf04MU+syuov4cYVUQszuh58MNKUyk2BybD41GFRBPe/AXzDZsrzcPMoBAiPD5gTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:05:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Wed, 24 Sep 2025
 07:05:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Topic: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Index: AQHcKHp7r9gkkae/lESTayfSQ/kwt7ShJAYAgACDWcA=
Date: Wed, 24 Sep 2025 07:05:42 +0000
Message-ID: <IA3PR11MB9136AE59AECA079CB61C4165921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-6-zhenzhong.duan@intel.com>
 <aNLrOIbBxZy00cS4@Asurada-Nvidia>
In-Reply-To: <aNLrOIbBxZy00cS4@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7263:EE_
x-ms-office365-filtering-correlation-id: 0d0ac342-3a10-431a-f1bc-08ddfb38c69b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bL+ehlWfbZgKZViSz7jm3a+O2tvfFtB+n6pv5oPyIVtFOBGDxQ1Lyk+dHNYB?=
 =?us-ascii?Q?ZdCm+HCqZG7S8M0gl6bybuGHKTmkTAKsflmP+W57qLomdGm1gM9mGwagAx9o?=
 =?us-ascii?Q?twv7ReTUXHfBnwZ7BDvFTXbZhoDsSU7C56uyoID7X3+R5aJxZB0/+UD8pGGg?=
 =?us-ascii?Q?/hibviqvqMowfQfIXORWfgwzIBUIfYv/BLRRxJ0KLTqEtJa1WsToP7gsrbx5?=
 =?us-ascii?Q?sTd++VkiUGu3KSQPlXSSSmpIHVroj2Uzh9SJ48N7OgI1Ckq40Sr18f5UFb/q?=
 =?us-ascii?Q?BH/UIjL4R/MfcAeSsuivhyhd4LnblaxaV+A9Dru+bFxICeckW3zE3EKpVZYa?=
 =?us-ascii?Q?maSKQwbEPuiHg3H6MfgqAxDxMyArvs4UBqbkEPxF88joDZumAcWTRIY+9EDS?=
 =?us-ascii?Q?oM9tEZ9zHr4tQIHqfs4KoHusXowbtI0/pl0Rg02luu+ppBqfr30UIwpva4pO?=
 =?us-ascii?Q?L7P3duueH56zAa6of/6ihPdeOaSFj3AOB2szHtW/Yxv7nEQV5Jsu5hhLbQkv?=
 =?us-ascii?Q?zr32qHq9w1RZTljMo7EAxlCX3OQz6Roa41TceOjBgfWo/keIdrm/1cPG8NLO?=
 =?us-ascii?Q?iF2jW+fJlmJ+1S0Hbgpmu2ubYBUZ4CZNn3IeHxChCzK/0qp4nhkV+bv74hhE?=
 =?us-ascii?Q?teiqc01bJk1XXTj872rNaglpuLZHWpgZazr4JjKjK2LUmXaD3FleneyFOjyR?=
 =?us-ascii?Q?QidgiSikm6X3ih5D8knW9aF2n4IjUh8jQIhyq9k/7L+hHZZX9Zb7VC0pmnkd?=
 =?us-ascii?Q?NJO6luLi6IYxOmx1Kl5IwXhx+0To1Dfs11dp7RSwRMgIOwoexH03rh9c59Yx?=
 =?us-ascii?Q?ZsPCO1FtErkyiNRuKsKk7+yX0x1BvhNnTSr172QjsHP1gHR7bQPzwhuCjhsk?=
 =?us-ascii?Q?F5eei5j0nWU/5R0ChxZYsUhbpLsHRqb6+dZoyXsgBCVhGGGLuYxys4qge6jl?=
 =?us-ascii?Q?Zk7RKgkR2sNbFny8yLb2q5tHZMWK3CVY4IkCBSDxdMjHMGYV/I80KNBlKni+?=
 =?us-ascii?Q?KVpQRHmpyy2oQ0VJIxIw7TkJZP02UeP6oci7UXorhijFzquJxkUscziOdlqd?=
 =?us-ascii?Q?gmWFGp9So00FQKNf+tLy5mYbdNmDd2+zN/6DepMV5wTV7sMfcl+5/3NAYvB+?=
 =?us-ascii?Q?24j68pZHFmW6Jtc/gGPpypkRf1kME3MigyBLAebYbA3gUbeq9/cnSN2CxAcH?=
 =?us-ascii?Q?rQoczcbpqJ7vOpfm3Sc4IBA0JB/y22+greoYTR2zqhaZoXC3ceFR0IkdWX5E?=
 =?us-ascii?Q?HmcyMaqlBZwLpvQP6JQ/95EohqGyqNLSKgQhanPft9BE0pTfZwBxgpnSK563?=
 =?us-ascii?Q?5tToUdHvGNXrRSwR/a79qKsGp64yZ/HuM5iD/JV1nZjB+LazQ+QbhffMip3S?=
 =?us-ascii?Q?krulgrBybbx+Mg9Wm9xG1aOhnCsxqblT2nij1sGbdGXfXD3jt8mi9zJw+YkI?=
 =?us-ascii?Q?7cMijYy2WICWRr7yr6ra8rf7xIhmi53gPzfINCzD0FsElgVxELSHQtdQ55/I?=
 =?us-ascii?Q?VNNc87yxQt0JVKE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MO3jgv56OTGJ0mH1Fh3rbnWkZ6kJOFKxZ5WaK1WSwiSV6lkUzf2XthrDBnI7?=
 =?us-ascii?Q?663Z/UMuURpCEpEg9vtijP0WzmX7ku4qJnsMJplUTAcTvdgdUbyo8GJUTa9D?=
 =?us-ascii?Q?BjkPiw6lEoe7To2aBrOiZRN5FNpxs2OAFSTrx3SGO1AjdGdUYF/ADisgE8rx?=
 =?us-ascii?Q?gXiSJN5a/G7zvR9EmZe7yM01PCl5aQlHHzYWTsLRCIxPkmNqPsIZuOhd5xPl?=
 =?us-ascii?Q?1vt8z9hkHG05cnodAs3TsGls7h9LuCVoqUCITDkzrOe7q9Q7yYjpobur1ilv?=
 =?us-ascii?Q?jPwFRmGydNJ5Q2gawvJQk++jXX0R4MNO/g5OyrJ4HpbfEUofUr/NbTzg1bRb?=
 =?us-ascii?Q?KJD4JeTT2yOdCYuuGBKZU7nnY3UwG3Poj6yGzi9jYg1RrNp5wIe9CrPvKRpJ?=
 =?us-ascii?Q?xfyOttYwjx7wOaSzMjBSBH8kQqLxbc8Swr3ffc/CgtRAEe6xHcuSwUgQOtQo?=
 =?us-ascii?Q?KqiLikkLoUYWiTPoXFEKpjsWknam2hhapSnEhLX62oIvkRdwFC6Hfl5drDBo?=
 =?us-ascii?Q?dV9Vebwx52JML+y1yiiI3ePZ3DSVzB9O+0YwaxdA/lStnJythqWz1qQnx+1K?=
 =?us-ascii?Q?kBJ8+R1/fvMK+EzC7LU/QyUSk3oFjTP5cMgKvPbbmEmdr3xTHfqu6P3LOPNL?=
 =?us-ascii?Q?3wHC+AiW/EoLY60GyfZvjWCWCiJuHxZ8LnQeRklSCboz+bH6r/ar2XhcglRQ?=
 =?us-ascii?Q?D5rqIMN8dVCRSNpxVXmbHmUPTWBA6FEq4xkxTG6ek92+rjwCVXsI0Vd73hz9?=
 =?us-ascii?Q?Bfsx72wxIzTLnEywGCuRD+GLt8iyeG5in2LnBFqKjyX8Xq5ZmyrBqvR1wolN?=
 =?us-ascii?Q?uMPELBANwRuwTYgGJjxhSg8pXmDP8dgtkk07YAf76K2xsfARQtUXzOB94AEi?=
 =?us-ascii?Q?IkwxG2ULYxuCfLZzKT01sWs7M9Na7I05XtcPwQh7Kdl+cckraDPn/edg1UnH?=
 =?us-ascii?Q?OK0kft7M5oMQdr81whYcjcyipWkd/nCJlxRXKkJmaw2rleM1TMDo8TcE4bzM?=
 =?us-ascii?Q?7co5OAHw1dFVB6e1Z1v6nAwrIM2YVt0UwzdzhfXCe7RAO/nCSGf3JKshPhfh?=
 =?us-ascii?Q?D5w1GJf3g4SRNx2oU1nUu1ILdD4hZhfcmwKWN3/6ruKczp1rFpUDgPMS6kJO?=
 =?us-ascii?Q?TcCfVu5ctZDl1spjqbqbKkf1Fc6tc4UUIwfTO+hyqV2K0E9C0hwvi/LkmILR?=
 =?us-ascii?Q?q3pOCavYGupLUe0U1WJm6LF+p9ppx8LwerzSttI7gVKCejQDdpH0/fBLFPr/?=
 =?us-ascii?Q?7Iz1AcW5AUe9cSuU5h1yAhS5AUepc2dZT5R6v2PsIbxM+//TZvos2zjeoeqx?=
 =?us-ascii?Q?HyHO5veJMIsmrv1ZVIzL4InfW+Dca03DvLsJ3tKnUcpK80w1XqIDUdJFJq44?=
 =?us-ascii?Q?cYxBl4qV99K2XK2mwIXs3HeiPn9nE9dhXhbONyQxIUyybWE60AzEu+R36M1V?=
 =?us-ascii?Q?HAYZJxTD6cbg2qqfegomgVsOdU5fjXB+/Z4xeh13n/XB21P0GwD5fTzlMs+c?=
 =?us-ascii?Q?q83GguRXjLiQH+MLGadyTEAdDh/0pMx86T3X4mPnBSvfg3fISFmptUkORlur?=
 =?us-ascii?Q?Rk5/+i/LYKJkQyO6CYfSaZGXS7uk3PdjqPfIMMQ/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0ac342-3a10-431a-f1bc-08ddfb38c69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 07:05:42.5165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7Zlml291XwPeGnKavD+mXDlY9ciP11VZcaqKZ03Xt8PcqaXgcPePbyLvxczJhnvJ/glkTA9Ab4Ao+dkNcP+nzTFnsL/YYh9c9TRnlA5AlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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
>Subject: Re: [PATCH v6 05/22] hw/pci: Introduce
>pci_device_get_viommu_flags()
>
>On Thu, Sep 18, 2025 at 04:57:44AM -0400, Zhenzhong Duan wrote:
>> Introduce a new PCIIOMMUOps optional callback, get_viommu_flags()
>which
>> allows to retrieve flags exposed by a vIOMMU. The first planned vIOMMU
>> device flag is VIOMMU_FLAG_WANT_NESTING_PARENT that advertises the
>> support of HW nested stage translation scheme and wants other sub-system
>> like VFIO's cooperation to create nesting parent HWPT.
>>
>> pci_device_get_viommu_flags() is a wrapper that can be called on a PCI
>> device potentially protected by a vIOMMU.
>>
>> get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
>> flags which are only determined by user's configuration, no host
>> capabilities involved. Reasons are:
>>
>> 1. host may has heterogeneous IOMMUs, each with different capabilities
>> 2. this is migration friendly, return value is consistent between source
>>    and target.
>> 3. host IOMMU capabilities are passed to vIOMMU through
>set_iommu_device()
>>    interface which have to be after attach_device(), when
>get_viommu_flags()
>>    is called in attach_device(), there is no way for vIOMMU to get host
>>    IOMMU capabilities yet, so only pure vIOMMU flags can be returned.
>
>"no way" sounds too strong..
>
>There is an iommufd_backend_get_device_info() call there. So, we
>could have passed the host IOMMU capabilities to a vIOMMU. Just,
>we chose not to (assuming for migration reason?).

What about 'it's hard for vIOMMU to get host IOMMU...'?

>
>>    See below sequence:
>>
>>      vfio_device_attach():
>>          iommufd_cdev_attach():
>>              pci_device_get_viommu_flags() for HW nesting cap
>>              create a nesting parent HWPT
>>              attach device to the HWPT
>>              vfio_device_hiod_create_and_realize() creating hiod
>>      ...
>>      pci_device_set_iommu_device(hiod)
>>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>Despite some nits, patch looks good to me:
>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
>> +enum {
>> +    /* Nesting parent HWPT will be reused by vIOMMU to create nested
>HWPT */
>> +     VIOMMU_FLAG_WANT_NESTING_PARENT =3D BIT_ULL(0),
>> +};
>
>How about adding a name and move the note here:
>
>/*
> * Theoretical vIOMMU flags. Only determined by the vIOMMU device
>properties and
> * independent on the actual host IOMMU capabilities they may depend on.
> */
>enum viommu_flags {
>	...
>};
>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index bde9dca8e2..c54f2b53ae 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -462,6 +462,23 @@ typedef struct PCIIOMMUOps {
>>       * @devfn: device and function number of the PCI device.
>>       */
>>      void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>> +    /**
>> +     * @get_viommu_flags: get vIOMMU flags
>> +     *
>> +     * Optional callback, if not implemented, then vIOMMU doesn't
>support
>> +     * exposing flags to other sub-system, e.g., VFIO. Each flag can be
>> +     * an expectation or request to other sub-system or just a pure
>vIOMMU
>> +     * capability. vIOMMU can choose which flags to expose.
>
>The 2nd statement is somewhat redundant. Perhaps we could squash
>it into the notes at enum viommu_flags above, if we really need.
>
>> +     *
>> +     * @opaque: the data passed to pci_setup_iommu().
>> +     *
>> +     * Returns: 64bit bitmap with each bit represents a flag that vIOMM=
U
>> +     * wants to expose. See VIOMMU_FLAG_* in include/hw/iommu.h
>for all
>> +     * possible flags currently used. These flags are theoretical which
>> +     * are only determined by vIOMMU device properties and
>independent on
>> +     * the actual host capabilities they may depend on.
>> +     */
>> +    uint64_t (*get_viommu_flags)(void *opaque);
>
>With the notes above, we could simplify this:
>
>     * Returns: bitmap with each representing a vIOMMU flag defined in
>     * enum viommu_flags
>
>> +/**
>> + * pci_device_get_viommu_flags: get vIOMMU flags.
>> + *
>> + * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
>> + * flags, 0 if vIOMMU doesn't support that.
>> + *
>> + * @dev: PCI device pointer.
>> + */
>> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
>
>and could make this aligned too:
>
>     * Returns: bitmap with each representing a vIOMMU flag defined in
>     * enum viommu_flags. Or 0 if vIOMMU doesn't report any.

Will do all suggested changes above.

Thanks
Zhenzhong

