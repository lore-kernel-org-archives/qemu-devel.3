Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D802FC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjke-0001Cj-6Q; Thu, 27 Mar 2025 05:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjkc-0001CL-9U
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:42:14 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjka-0000mF-5n
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743068532; x=1774604532;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Rr6UrRzFimaclk/HC9eA3kAdkliA4SG4g+qHPs1Elto=;
 b=ZV/Y+hV+MHrjPbie7/lmk2PDUtpDC6clYtgJILxfh17DH85mzyqjx7h6
 nfTBTAWZEhy6MpSGk08Gh3nFll/lzo80zJERdf2IruSnuxexSnnBKKV/s
 iN1ElZkACnWWCOwBPv7RBZixmtJUbd1MoI1/CWkj2sT8u9J8OPj4tknYI
 7K8vP15E+TPba/NJ5FzXfI4lFmpOEcxR0y6BPxMj7YX+IQe3DrFY383w2
 mFHsgrKunkKQMrNVoJvDgszKN2iwb853qi54QjdNKiXJp8PQocYCYlwhR
 mgoc6X7v/vJ6vcLfoOAvePuOdNfAy3Zz4ov5MkKh42qNwZXPFWuof9ZpA A==;
X-CSE-ConnectionGUID: gYIINk1uSfKlYU4Lm0hJOw==
X-CSE-MsgGUID: zZ8CD2YEQ8CAzrP/Bandag==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55047297"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="55047297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 02:42:08 -0700
X-CSE-ConnectionGUID: rWFXKKIKSHSY3UEoFsj/yA==
X-CSE-MsgGUID: gxVoQdqGSqWqeS1lf/TzUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125543635"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 02:42:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 02:42:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 02:42:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 02:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev3z8yKTvou6pQtcWgThVyYzC3JuC41xY7gWoSIYa9UQR1R02ahuPKyhkQDnlk69C6hf1hU06Z2D5YPYC6LoX0CEcxoHnajpJG3RFlFyZKh3Zbvrjdn3eKosE70gg/3JH4aw54lI3/r1qNOG4PVvQBVsqVN9IE4N/c+nFbLnYTfVVKLEYcRu4dW3IslDGn5R78YJ3D3wiW7dr7L9HxDZ9VvdRkNeEuCCKWllMPrpxneBqxv3DhdQCskPf6K3Qgh+MQxKqeSqU+5ur8Yp3YoamFVoDuScEPtHd2kf9+dag6tcbJ7MbaAvGXSqmSbkdToehiRKEAx5DqDWR58hX196aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr6UrRzFimaclk/HC9eA3kAdkliA4SG4g+qHPs1Elto=;
 b=pdGBY12QhJfccuspwsdacehtihu0dezuUuDpqdWAY/fOjs2T5p+uXoYEOAfCsMKaqJPJ20eC0IZxLmgOnglSlzx4Oc3/wvl9HOk/j7V9VW2DL1RzSqT4024BKVN7JN1T18zhcX5zeaNZcMAe1EF5ifGMzkvt6v+RVtPmdGtDnOxgufJUWKv59O2Xu69zokduivM/L4qhig3EjNxirVdlAQWVr28yHPg0g5Om44K20QHq1IW71nzalg2oxJ4oeVrYh/qB1e4O9i60bW9vpLfYqf7v4OOF1qLOwTOXHJxIR/Zv/bd2clExeZ2RZxMWTqlKww7qA7aoj7g2Q6ccd0VPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Thu, 27 Mar
 2025 09:42:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:42:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 16/37] vfio: Introduce a new header file for
 helper services
Thread-Topic: [PATCH for-10.1 v2 16/37] vfio: Introduce a new header file for
 helper services
Thread-Index: AQHbniQeXyGAjp/j6kCE7S0P8U5lYLOGvIsA
Date: Thu, 27 Mar 2025 09:42:05 +0000
Message-ID: <SJ0PR11MB6744C6BF65EF6105B9D8DD2692A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-17-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-17-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB7044:EE_
x-ms-office365-filtering-correlation-id: 614e0a31-6ecd-49d1-ea0d-08dd6d13a2ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Bs9c+LIZfhb0B49a0s60MgTIEImkR+KepFeXAoItttmwKXKTKV3pq4dp8Z?=
 =?iso-8859-1?Q?lYPq3NqnXS03Q3vt1tsva3x+v+2JbiEIVVTC1gSprIumEu3FrlUwzPWDNa?=
 =?iso-8859-1?Q?JncvRR4rviRY6GJhbfcZQjgn1uN/GOqzwJ+K4U54z+aPv04RAu0BY8TonD?=
 =?iso-8859-1?Q?hz0Z/tMQTRvYw6c1LCuNd70CCimayUxworZj8XaFiB1SWZjj9yrs1V8D64?=
 =?iso-8859-1?Q?4JT9xbvCSFe4KkZDpFZJ/HjFTda9bZCT0xW/T3QoGGcD6+YemcLzFaE3v0?=
 =?iso-8859-1?Q?jCbKWUSkc4z0apxdVXafmxXWOjjrjSiTQr5DMtOoRQpjTaZclZlmvwZOu8?=
 =?iso-8859-1?Q?AL0PJP4qNJ4YNPBongZHOCIAPzIiM/DKm7nGxINDUVj1mwmOLciiBEnClk?=
 =?iso-8859-1?Q?NcXkrvF6a0MW1z2l5JLj+Nec7ZNfsxs9VQU2CkC9e5/lmCYyB0kU/WHd2+?=
 =?iso-8859-1?Q?ufPYVwTUOJg23M14Zmomczvi6lJiOlQ+r5Icvwdf+5sG8wZ63rbxYMgzi/?=
 =?iso-8859-1?Q?lsVXEZ7e8JhSokyY8CPhI9+NhL1+psCx4JuF6fIx5Y1WT0+05ZLpNUHwfn?=
 =?iso-8859-1?Q?XlLx1cz3Jj8FG1EAhovM5oLHnGPY8Qz70j3N9jDYykVyKqvwUQ2xdPPSOM?=
 =?iso-8859-1?Q?RupnTrQY4B5jsgd9+svmtNaz0HfDFoe8HXER6B6lEaaD++pTZ5ST1ydINo?=
 =?iso-8859-1?Q?lcdYrypUbp8ejRQATOe1W9Abs0+jXzY4/Qi5mQpEP7hHaBHrPt7PkIRRDF?=
 =?iso-8859-1?Q?kB4OExdzLW2COM+HmTShPYsa5i3djh0ciH9QVqIsL2Zk08PsVhTsfznOKl?=
 =?iso-8859-1?Q?2RT1SlUzCjWXMBU2Pqk1vgJk8E4WSy7zrxCFVaNiX0pcfMYf0qSNE3JVNt?=
 =?iso-8859-1?Q?OS0hepGb1IgMJusViJDBnN/Qyiqt7DfwCRY6J7thpqBz8DJmj7cAToC52a?=
 =?iso-8859-1?Q?bW5sTLI76G67GSy1B1MWgj4qTyd2XDlWJ/FI0LxdRy5AHL5q9CwDqOKtlS?=
 =?iso-8859-1?Q?JEh5+kJas+vK2vmJQnaaUVrRT5GsiG9o0rxuWvjBvBy+mneJDidMkBRtlF?=
 =?iso-8859-1?Q?VOh9Ac1WrfUqowH8/SyEk/DpbNZ1rCUeysGBMUWBsjlreH0ofyIyO8yN02?=
 =?iso-8859-1?Q?8PVWBM4qBcFDzjEuJklZQGyuiHS4XmfbFzud9dOc8ApiAezXZ9G2pVTdGP?=
 =?iso-8859-1?Q?skZmkGhPUzFA7VJ0NswziTQ9rruQlpIUcfxPD5BUjOzdr83YW7wFrNCGSx?=
 =?iso-8859-1?Q?7L2/s3H6FmQtVEJ9Cmo73TR3XRdPTkEAP5wg4tlEvPW89ry/S4fv/ETyQ3?=
 =?iso-8859-1?Q?o7auKjF9Sct1nkI86L6l9Yy1CjCY7E6HkUYVIIj/BL8OrvyTn+wTkSoJUe?=
 =?iso-8859-1?Q?6oxbMnk10bkNqCdwBpjRHKm/lPeeHmsz8mZ5e3fOk4dQqC+/N101DlI8Ct?=
 =?iso-8859-1?Q?spA3MBw+kB8webDaNwh67ywB6zcmIVXN+cVOJPqq7PGUmXI06Go15xOAtx?=
 =?iso-8859-1?Q?7B640v36ihe2LYnVjPHsSm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DlqDCTGX9ShCJQCIVE59TY3k/Du3KS0kyDHpU7gkyvxmxNqIPQBDmBDXSi?=
 =?iso-8859-1?Q?qMELstP+ZtjAz/fD2JBaUgFnuCvEFVCvGzjrCpgsRS7hB3iiuuuFzivpun?=
 =?iso-8859-1?Q?Sa1fCQSSG003h07cI04bvvC5Z1Ba73Y7h3azWdqRRTIV+r0TrHHcS5mZDQ?=
 =?iso-8859-1?Q?KtTa8kzu8HAP8zGMKQyrRLposvBLF2IrForKkasN2XBUywGDzgIWqHYH/c?=
 =?iso-8859-1?Q?NlFh9wD8BRKnHf0AjfmNzh4fGoy+pmh+pIrqGoks+cjWEeEBzH868K178k?=
 =?iso-8859-1?Q?Q4arkvTEug9HNjGExglmztFQDGNanEtym+nBYn1inXvrPK+2MnQb7d8+jq?=
 =?iso-8859-1?Q?xzzqHcPeitlIjlK0R6wZe9FrISGSegW4vYie5yJf1WBUNFlFODeVSNWR56?=
 =?iso-8859-1?Q?0tPjw8OR1EqY7ugb+ldDXkO374qSRKOIphoRQ8yiAt4f68iEImM0T4nnqp?=
 =?iso-8859-1?Q?ZewJ9MJPxDi+x7iru/8OTzJl7ZWV3p/D9YMjeOoiazkQvOkZbaTj2Q4U7h?=
 =?iso-8859-1?Q?y7Q0BGUtZa6DCG18VEJPTREin/E53NQdNa8KwnwIGUi0GXja/U+wXmUAvn?=
 =?iso-8859-1?Q?vVMQrJKsmSAHDUy4/2tRhXzHAhneLy91XUppIDwIoX2BgGXvkiUBVNfkUt?=
 =?iso-8859-1?Q?Nv+ShIhJfFTR5A9kvhLNa+a30xxZEV7WFCHlcRj74Wcs4SxBoPuyK90N0L?=
 =?iso-8859-1?Q?GEy9188B8iroj8+Bw/oFxlaKeyjl36LzoMNL9qnYfm91L65fQ5wXmRIu/p?=
 =?iso-8859-1?Q?FYjh1WiLUQ/xPHDwv7xTHkQCMf12DHkD3cCx4+TFoFBHyROLSfw5Vb7FA5?=
 =?iso-8859-1?Q?QvQHYTxbrwCAPqBCMrK55Q0qMe/6u+/R2pwhQSJ2E7sCYKLfa2nyMYLv7k?=
 =?iso-8859-1?Q?GWN0jCewiWYPGjPAmQ/EjLKVp4DaJ/EEYnj93rifCSorbMChl9tEpqOwmX?=
 =?iso-8859-1?Q?QWAPIdza8P1U8OesnTZIR/gK1wRhtZBK0eGDMxmIMRg5+be4l03PcfNTYh?=
 =?iso-8859-1?Q?WzxMVUfTWpzgoLJvN5t0e4jJKy3GkyjoWdTBnFGLMfUJyK9gBlyrv0mqEo?=
 =?iso-8859-1?Q?lA0hGYYcHwV8PjjIJYsHRCdKDGE88EcO1g6C6DGrtanhN6yT4nL862DTWH?=
 =?iso-8859-1?Q?s4RCTbVx6cpIf2WgYiR7JABbJu/fXy+upJyOZ/62SrVdwreqSopyRcgxmL?=
 =?iso-8859-1?Q?eG8X048Rw2jZL0nyV9oBwfKYzN/9e2133rwMDOZjaIAuAPSjVP7BqChv6C?=
 =?iso-8859-1?Q?b3V9hUlLhmkCZvDb38VYQeySJlejFkKjgDUeu77acd9AXYr5eqhpYDlZjF?=
 =?iso-8859-1?Q?pm96z2xx9q7tBSu7PWixvD+5fnoqNtq60ECwLqfR4/sA9VV8H+b0ocXjBv?=
 =?iso-8859-1?Q?CCfbzIAWwbNGBurTxAmwiVtrNL97rMvarV4jX2RR0wkYUv71nwjGK60f00?=
 =?iso-8859-1?Q?npvtM7YQXea4xdKU5ZdLkyHLZeQVgfcdnxmFSG5Ipw+ngt64IFnEcBEAOE?=
 =?iso-8859-1?Q?MQlFcz17Bch4RylmlzS4wc4D3JJtJda1bz5eF0eL2vcmZXC/voeA7ClMqR?=
 =?iso-8859-1?Q?LsOgEFpV9H9vqdRfflSfJ1JSFSObAVW97MXoCcHKJMcUFvOm4I9Q9F73PH?=
 =?iso-8859-1?Q?DB+1SH16jUb4BVDGqarK8kB3yAruB504jY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614e0a31-6ecd-49d1-ea0d-08dd6d13a2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 09:42:05.9334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hS/GhtTmms0B20YfV3HncoO8oZtWYn2zn7c9t/XLQd4yg+PMjB1SX3LBPbrG2TvHocpxT7rpkWXddNgQZIjzRBGgt4bC0cGKLgdg+xbkVWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
>Subject: [PATCH for-10.1 v2 16/37] vfio: Introduce a new header file for h=
elper
>services
>
>Gather all helper routine declarations into "vfio-helpers.h" to reduce
>exposure of VFIO internals in "hw/vfio/vfio-common.h".
>
>Reviewed-by: John Levon <john.levon@nutanix.com>
>Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-16-
>clg@redhat.com
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

