Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EEEEE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soBzz-0001MD-9D; Tue, 10 Sep 2024 21:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1soBzn-0000ny-HR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:18:12 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1soBzj-0000co-Qo
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726017488; x=1757553488;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=z84ZQ7k5mmcasKCKcwDw81IgGKPO0VLH2lTTLVSPVV8=;
 b=UIyTwR70HPLIIsGQgONjUZPRG8TAboy+0l4pvLAbWTlYqtbIGFk6Hbkw
 1Dbp1wxygG44N4tGF24bZsL1tdT6hQONleu+mrxmgfWTKEbHCALIslbY2
 Zm2sIICOz9ohXlQi+0o/h/cDpgNCX5Zc//SnpPDODBYray2SKYb+r6N0f
 8EYPOn7c8j3PJhuoA5eejdorwV9A72/zjGaVufhOliae93o3jxJ2fGF2B
 Y7VL91tcIDlJLsxeGHVs6Y5L6U89u//mY5ujOb+X6d74IdtbaU612+5yy
 F6eQ56dCt5DeC9ro4f4YsSBe78MKMTU8im3lGovjSZA8ziyZfI6FjKKp1 g==;
X-CSE-ConnectionGUID: 9RX2SeGlTj+PLBjAf5Er2w==
X-CSE-MsgGUID: nPXMi56vQzGGEA0ptd6H3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28573504"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; d="scan'208";a="28573504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 18:18:03 -0700
X-CSE-ConnectionGUID: yvq2uII9Tha8AvMzVsgW5Q==
X-CSE-MsgGUID: +AdFSPbqQwavkUjTs3R0ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; d="scan'208";a="104670851"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Sep 2024 18:18:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 18:18:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 18:18:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 18:18:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 18:18:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twgbAhaFiCs2YF+dhJe0AAB2vg+x5FhCL1v4mxHZmX2EUavV5HD0XjYEGN4IRV9xCPJJkH022zkeE/oIfwCFXMXN3gL6n0yTds8sKDkx43xaJYhXBY3UL6iMXyrtfZaE23zbo54t+j+Z3kf1GVTHsPInrx5/+cf2/vvFb26RHaBQh5LQ4Pbt6Izc97z87hcb0PeGn2tg3DZvy+gUX8ljuK7TUXHmCuHEEFYf6NmF+MVuBZdIM8/66YemlD4IkVlkTv+l90N6k6R19Ukas1lwtd3RHg3VpLm0gjfbwerUc0eeKANyHRcHhwU8y4XKmAGXpNRNnVFBHtjvJdcBQfkW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glcbbuhigBG2qC2UXgkOAtiMmu/JlO1pxqKBolD1Fcs=;
 b=nC0XbV34vn8SZEXrXbpp+Wi4McuHVHGyy0KRIIbYtaM/bB1AUE6jeatOl0v1ZaDjlVYQCSphBDCAh36v3/uMe7jV664eaRZukKQH+3jlDrO2cN6U45MKBtUO/TmPy97Jjq9kW0YPGC6qUVmHeyvM6oVOTj7lngHDfbBeelvGIrquuaTySJewvMsZZiMZh1YJ4nsqbhH+vOGKalmi570iixFbS0eRxBC4WdQGN3McXAoHN/lYbmv+lhakGqNkbZn8iLbtU7x+Wi5ZmyI+DDog+KuJxvynvovPI/ukJMI1VJMNmhxGf/VUi6pNlojezf81vi4D3LUysz24BLkmJ+Wb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 01:17:59 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 01:17:59 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 "Wang, Yichen" <yichen.wang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, Hao Xiang <hao.xiang@linux.dev>
Subject: RE: [PATCH] migration/multifd: Fix build for qatzip
Thread-Topic: [PATCH] migration/multifd: Fix build for qatzip
Thread-Index: AQHbA8UgybCdWp3+g0ayrxSXk3SgUrJRyNBQ
Date: Wed, 11 Sep 2024 01:17:59 +0000
Message-ID: <PH7PR11MB5941A3285A9EBAC7444A8ACAA39B2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240910210450.3835123-1-peterx@redhat.com>
In-Reply-To: <20240910210450.3835123-1-peterx@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH0PR11MB4951:EE_
x-ms-office365-filtering-correlation-id: fa19683d-ab6f-4b0b-e237-08dcd1ff92f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bahE0qnWGnr4Zi1JYlRBkYsyvcUYJI8i7+WCKpsggjuq0It+MC9FyFjZiwh0?=
 =?us-ascii?Q?EQMtD6L8FdQTib6K/iOYtMBcB/fDveTxvOKnzsi0RzxMNZnVB2BfmgPNVtwv?=
 =?us-ascii?Q?s0CLoJB6xD+EdCXxGHKEP1hNFn3btuK68mzRkaDg8oB+lKTqliYTw0Crd+q0?=
 =?us-ascii?Q?P9/tVaRXbN+FuHTc7/QW8hK0knnfvjitAoUEAPHL/AGQ9kgP1ptdvYwmpHAt?=
 =?us-ascii?Q?X6EjVU62+qMr0sEUmF3deUDj5YrDXJMu9bG58eWkmmHNdR+kQaZdcalUA3+6?=
 =?us-ascii?Q?OBKPvpncHz2G/k1N/NMt2lv28bKIz02g7RfKEAMwDMVNLEoNiCG0iVQ5BC9r?=
 =?us-ascii?Q?2m2c9jSk4uWQ7+BC3/gap1AJPYNRt+QregbTLkdulSeNYZQ/nQLf9jIfNIZ7?=
 =?us-ascii?Q?83SER/0KehNs3sINdcfqS2FMBJabjTm7Lfg+xCL/EXLsJxEF5IJNaUB7GHv0?=
 =?us-ascii?Q?t/mOABh4v2FmNJz8XQaB7swPrBMaJVkSkJWFgSMY4gOKQKXcYu+WQr2sRW+D?=
 =?us-ascii?Q?xLddWd+c9+rOKZl6Me4+V+qnR9myW3cpk5dehIfwt40oW+GmCCvL3aY0OMfd?=
 =?us-ascii?Q?7d7i3S/UMyyamIv/U34oMjtFsr8V8Kei9sC0HnQGQrZU0McKNevvsFDXRPkW?=
 =?us-ascii?Q?9jpZMZ3no4xTuAI27ymMR3t65ZreFt9YT9pD9uCi6MtnWgOKYIpYiJ2QhfS9?=
 =?us-ascii?Q?tZNZbymSGnMc3KuKz6IdpDz/mKFGyr/txtMY1rJzNystAiQhy0wbCGLANZk7?=
 =?us-ascii?Q?qMbS1XN+M++S/l75mAlzv0TxLlab0CGQPbsdXEionZqvp6+KOTazkpXuXUx6?=
 =?us-ascii?Q?OiGiwJMQc6113WGKsOXkBV4GIAAywnwokrCuqN0iMB+HbHp7etPMI+mCm9c5?=
 =?us-ascii?Q?F4BxLscXhe23up+V+TLaix1wSX0QaA7qjx+a5v2UkEC6TOzbc0NtE76xWWCc?=
 =?us-ascii?Q?dmyLY7bRYnhDWE52OoSqNfXBh5dL1OXvBdsdqXyyw28orpOBD78iC5nTxsXN?=
 =?us-ascii?Q?o6Lp+jevJ1MbD6AyxOGkc9d+IZVL1mIxolG5NL6Thyg8m3MuHsHEKytNthqF?=
 =?us-ascii?Q?DCqpvgVZQY/ZIVUfTg8TVKFSBQT3KA8gO1oPuiJkCfIRnlmVXRqY/aoUkz7w?=
 =?us-ascii?Q?HieRbizjBZXfFaCzTkDDQHdLB37UDgvGcgac8Kbg5qhrU6hwXW8U6Wp5WSef?=
 =?us-ascii?Q?3aiYsJBwTv8C5+40FFIZmbJAzpAbD2PV35xDcvsRVD3a4hWpeKF/Yd2175bP?=
 =?us-ascii?Q?YLb2EMjZUplrEyT4hMMo0kfdt/eD+g1Uf+MWGwiohCLozqLH8NoIXVgGfDIG?=
 =?us-ascii?Q?qihDnF8uklbssYUSIEbBGbXH82HckwZgv53BLdBpTww5Cawtto/6nBl0Gjxj?=
 =?us-ascii?Q?0hIJcZXIaaj5vo+b09C/0fz4YxMSolNpofMMJ2lVmly8+xT8zg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bo1w3txgsNvpmGzgHXE5j4V/ONv65BUgY51UXHau6cmFbpxyyi10g2KAcUMt?=
 =?us-ascii?Q?D/biHkMpiMPax1/JUYI4cSMarLUGiUP1bUClikmbEaxUs0U+47NDyDUAXWgc?=
 =?us-ascii?Q?vMNs9jnKv3/RSdTd8Y3g/0ID3UNrMGVAru8JstxNSnAeMB46svqluG/2lFw2?=
 =?us-ascii?Q?uAdZRmb2AqXEyQHshcHeb9SnH45+nuWIULOGOahidvYiMHN+/apru/XiB/9A?=
 =?us-ascii?Q?2HQ5gEocDSUhYhpvORFVcRQZmAPka1aZuSF4AsYnBcvIYTVGeb7FLSq6Pzj2?=
 =?us-ascii?Q?LokFEgDRR/n3dDUrxIoyYSVFxePUs+pqNL1AZH6DHRPqEoADk32ZYtAFcPE7?=
 =?us-ascii?Q?AUDivio/8S2s2HxS6OfIYJbsB+cX7/IhACY8fmjD8uzG3//OePSeI/clvz4D?=
 =?us-ascii?Q?he4R2XWUXzVOw2XVu4ilsxp5zJ/cAifYdVbzrqFmrCBkh75ks5G4CorHrElj?=
 =?us-ascii?Q?GxlyTXir2Ia3S27sTvr7jei40eMmRxxaDIm6HyMu0y8fcvKbYhvgnW6Ow0cP?=
 =?us-ascii?Q?TYaZbCT5N0DISMIUwZpk7fgsvZCO53e0naqMzSVhgekz4bTr9028ciFi5UJR?=
 =?us-ascii?Q?FX4dRKBDXTchFEI5nzS/rtDLp21sk2iMIGsC9QeRPLG8I6nVt61wWZjtxuct?=
 =?us-ascii?Q?X6N6ytO+w5UF4MPHmuP2iJmiIPzgDBpYBjsl8V1f0+pmJgH5XsSrK6DknKLG?=
 =?us-ascii?Q?HUcEunHERRw3Q0+lTrmsGtHmR2qaXNsb86FTHagm1b4uEuqbQiPqHdWh7q4S?=
 =?us-ascii?Q?lXogw0Cj/+xwfodltdz+A4Ueayv4E8oHQiQgyL/53mgSuDMiys5Iy5cSJL96?=
 =?us-ascii?Q?EzuDQOzn4Gcu2tLnYMhEwxmIEdp6OfrlzXeW1QWWTPdBp//ApVVcqfU+gpiS?=
 =?us-ascii?Q?TXDOol3Z7tRWdAktn6eFp+4yVFX25IEZuR/2eM6dG8cv0H2Tuc3vtlgguEg1?=
 =?us-ascii?Q?/MDBZ6i767QHNCBWu3zk2UwlTgAi+WELAOXvLzBWv6PRnSDwfN0BAXt8pvBJ?=
 =?us-ascii?Q?LLcdA6W4SmvfgPd0dXyRGIDGiLtdrm8H1TSmdZQ7PBg17nqc+N2iWOqe9HAa?=
 =?us-ascii?Q?8HPfA49ZgXKzh4afCoQ3qqJkmWd+F3VEXRjBx/Dof95+EgFS+G8bk5WhwHX0?=
 =?us-ascii?Q?Hfym/dcKPa4XmMUNHDvWW0b+FhlZ5+BriXxzT1In7DSdroujVtbJ/bJ39TaK?=
 =?us-ascii?Q?R0Ysng82Wb0STdg78om7CVb9lyFpYG1QfBmqttD1+hyANoMTKmkQ9iJ6jMAL?=
 =?us-ascii?Q?Cv/rABUEalilqhfC1QguI52hqgJblsyDca+g4n9Ci9gDp1YCf0ziF04aF0Bf?=
 =?us-ascii?Q?egeYUg5yp6ATfJ+gRsW3mZxGe+Bcb33F0WCqtG7SYQdEL2Ji9NiGrmxbfRVC?=
 =?us-ascii?Q?LV20yPOAAJzU3uOAeQr/aRZ9Ut46IrAAEmO5Rr4d7C9ynPtw7hrNEAvG42JV?=
 =?us-ascii?Q?i8UKLarfsonnKGY9AFQBT5DTeKGFeoXwFiwObPY95Dz2gHyU/G0M0vXUM8/x?=
 =?us-ascii?Q?3pBhYay61PtJK4IHp88lGepu2QZHZ+jXVEQw3pQxzxBwsn3nK2HcP8VQ6lOj?=
 =?us-ascii?Q?W+DCvKTbKM7qXVKtw7ylA0QlWpiV5dXehvo0cxUc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa19683d-ab6f-4b0b-e237-08dcd1ff92f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 01:17:59.2044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tq1zIKU3svo0KwuGfiC9swzbTJi8Tk/Nxkai0D9/PTtIlrO9W+WNYOO6PvtE88iQ0I40Cy6S6IrH35tx/SvEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> -----Original Message-----
> From: Peter Xu <peterx@redhat.com>
> Sent: Wednesday, September 11, 2024 5:05 AM
> To: qemu-devel@nongnu.org
> Cc: peterx@redhat.com; Fabiano Rosas <farosas@suse.de>; Prasad Pandit
> <ppandit@redhat.com>; Wang, Yichen <yichen.wang@bytedance.com>; Bryan
> Zhang <bryan.zhang@bytedance.com>; Hao Xiang <hao.xiang@linux.dev>; Liu,
> Yuan1 <yuan1.liu@intel.com>
> Subject: [PATCH] migration/multifd: Fix build for qatzip
>=20
> The qatzip series was based on an older commit, it applied cleanly even
> though it has conflicts.  Neither CI nor myself found the build will brea=
k
> as it's skipped by default when qatzip library was missing.
>=20
> Fix the build issues.  No need to copy stable as it just landed 9.2.
>=20
> Cc: Yichen Wang <yichen.wang@bytedance.com>
> Cc: Bryan Zhang <bryan.zhang@bytedance.com>
> Cc: Hao Xiang <hao.xiang@linux.dev>
> Cc: Yuan Liu <yuan1.liu@intel.com>
> Fixes: 80484f9459 ("migration: Introduce 'qatzip' compression method")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>=20
> Qatzip developers: would you help me to double check whether this is the
> right fix?

Looks good to me, thanks

>  migration/multifd-qatzip.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> index 3c787ed879..7b68397625 100644
> --- a/migration/multifd-qatzip.c
> +++ b/migration/multifd-qatzip.c
> @@ -160,7 +160,8 @@ static void qatzip_send_cleanup(MultiFDSendParams *p,
> Error **errp)
>   */
>  static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
>  {
> -    MultiFDPages_t *pages =3D p->pages;
> +    uint32_t page_size =3D multifd_ram_page_size();
> +    MultiFDPages_t *pages =3D &p->data->u.ram;
>      QatzipData *q =3D p->compress_data;
>      int ret;
>      unsigned int in_len, out_len;
> @@ -179,12 +180,12 @@ static int qatzip_send_prepare(MultiFDSendParams *p=
,
> Error **errp)
>       * implementation.
>       */
>      for (int i =3D 0; i < pages->normal_num; i++) {
> -        memcpy(q->in_buf + (i * p->page_size),
> +        memcpy(q->in_buf + (i * page_size),
>                 pages->block->host + pages->offset[i],
> -               p->page_size);
> +               page_size);
>      }
>=20
> -    in_len =3D pages->normal_num * p->page_size;
> +    in_len =3D pages->normal_num * page_size;
>      if (in_len > q->in_len) {
>          error_setg(errp, "multifd %u: unexpectedly large input", p->id);
>          return -1;
> @@ -197,7 +198,7 @@ static int qatzip_send_prepare(MultiFDSendParams *p,
> Error **errp)
>                     p->id, ret);
>          return -1;
>      }
> -    if (in_len !=3D pages->normal_num * p->page_size) {
> +    if (in_len !=3D pages->normal_num * page_size) {
>          error_setg(errp, "multifd %u: QATzip failed to compress all
> input",
>                     p->id);
>          return -1;
> @@ -329,7 +330,8 @@ static int qatzip_recv(MultiFDRecvParams *p, Error
> **errp)
>      int ret;
>      unsigned int in_len, out_len;
>      uint32_t in_size =3D p->next_packet_size;
> -    uint32_t expected_size =3D p->normal_num * p->page_size;
> +    uint32_t page_size =3D multifd_ram_page_size();
> +    uint32_t expected_size =3D p->normal_num * page_size;
>      uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
>=20
>      if (in_size > q->in_len) {
> @@ -370,9 +372,7 @@ static int qatzip_recv(MultiFDRecvParams *p, Error
> **errp)
>=20
>      /* Copy each page to its appropriate location. */
>      for (int i =3D 0; i < p->normal_num; i++) {
> -        memcpy(p->host + p->normal[i],
> -               q->out_buf + p->page_size * i,
> -               p->page_size);
> +        memcpy(p->host + p->normal[i], q->out_buf + page_size * i,
> page_size);
>      }
>      return 0;
>  }
> --
> 2.45.0


