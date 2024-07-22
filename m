Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A9BC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 05:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVlPH-0008DY-11; Mon, 22 Jul 2024 01:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlPF-0008CQ-0e
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:16:17 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlPC-0004xi-Or
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721625375; x=1753161375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qF++HAljdAxPLDvw/O/F4yZrAqCAHs5XpbY3ySkCSqA=;
 b=gv0OuGkvBaNGNvVmcxI79eBQ+iUlNfbIDGF8HTq54xUAWL/32M+vEA1c
 T0APnmgD+7sGbxE16loElRtdygFEW0HEG3SxoUI/M+jCJf3nzZ2a5Rr9g
 O6MEPavqc4auHsjbzAXNww+ouHMO5LO02o97ZcWTcTpy4t9x7iAFwGD6a
 gHIlzkUovbfBn7xJ0PYAFEtrmRi+UEOR48ucEofIiEYINT9pVCx52H4dj
 U/W6JcWdBRGqH+5LtTxl7TOgrtHFFM/9N0OgSc/UfgOAg4zvE65rigvlU
 rJZKyOSNruNPqYpAA2+O43XX+FjMrx8v7UwsPGIgLlQqIXWlLkyEfJu4v g==;
X-CSE-ConnectionGUID: /dTWgOC1QjeWLZ97uFtv4A==
X-CSE-MsgGUID: kBkw3g/zSrurRZ50Lbk1YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="29759620"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="29759620"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 22:16:12 -0700
X-CSE-ConnectionGUID: gByuXRaQRkyfLDjpriBCVQ==
X-CSE-MsgGUID: 3905VNPVQwC57/dn1MlS4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="56039482"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 22:16:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 22:16:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 22:16:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 22:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfUvZ3B7VqRrgk6+hBrtGgPg0Og2YhQBeaDAorvhj+z7fgfvQVoYrtp0+G4eFhAvZD2Gv/Z5t1owmScxR/MFJ+lea8fnb+/mSFDlYd3+NqK/xWxBuxcBXfL9mh2DIkm4KYnXv+DJUJEDmjpu4hCGHyH0asR7ykgtQk0aWQ+UFM89eIwSA99SRvSdx8f/myCT5rgT92/ZKmQS6F3Dvb4WnhhBX69FJ+PeRir1gkMIq5b3iRP7w0Y5svxnOLgbRqL8/Ffd8EZuHCeGhoQ02lq2dqrmEqU2uJQ3LTX7z8xEnMwf/1JvXIHAw5xVGgNcC9pcw7nCT/L6Mn0ODtJdqpk+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SIMvo7kbYTvH18pwDijc0u+Ia45+nEZIDGW1NrD3n8=;
 b=IwBbmcW15aoXqgfx2c5/Abgxw72A9qeNHUgwnCjXmq4ZPsnl4OJHikZJhqoIcqMNmdg7xB9y96lUDvgntpkfAgT8zPiAzvTxZeFJY9pe3mNTk+aHCPFPJe686oXWTxaeeTsdtcqyjKE7MdZ75S743lgv0Qo+vXnrbIEH+Pd3mgpSkGnVBOM6rcOsh6A0WJz6XTlOU1lS58V19uYfZqQXJn6AkTccJX4Y3B6EB/JrMiWhsh+Sq/a/KzE46hcZO7KWyPaGXv0WFobTayg6FyCBG0jjrFOSsCvms3Yd1qHtwlFue/olvR7MUUwM6u51nqR8DO4umwniBVLMD9ro6U2EMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 05:16:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 05:16:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
Thread-Topic: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
Thread-Index: AQHa2dUuottpLIb7O02B4sq7FqiDRbICG5XA
Date: Mon, 22 Jul 2024 05:16:08 +0000
Message-ID: <SJ0PR11MB67447F437F8FCDC4F995737C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-6-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-6-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB7527:EE_
x-ms-office365-filtering-correlation-id: 23e8869a-10ae-4d07-108b-08dcaa0d64e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?g0ICsU9X3juI3ST1lXLCTmhbgUHJ/1rMtf413JSUkYltirmpszqr1ge4zMhd?=
 =?us-ascii?Q?jLbkGk3gRC7eG++rxddPPs5Izz+MOOwigQwCgYRO3gka16v6CO4keRtfEzsQ?=
 =?us-ascii?Q?82h+PG396HFi1J8DAwloTWxUqZXv2E/DMB+hNdwdZXmwyjNIV0zSIyTp19Gl?=
 =?us-ascii?Q?wMKbXeIBDTcaYTovweodxw3ns6WbxGoTZr9QlFCey0BWX03qV9So/dxdsNqz?=
 =?us-ascii?Q?R2vO7ALeb57ixas/dWusnxGC240noOZTvxmCXdIwCddu/uHIRE2QDQphcBEM?=
 =?us-ascii?Q?zJYmNde5gNV7W4+33HyK76X5g2pypXGMfjbVWHQtiy8EG/lKDocrQuYrnvce?=
 =?us-ascii?Q?9ty99CkXEKBRGXaUgCNpiAjoZMCmkxqjbULMKz4Epw5F7rmL7DJpH1x1To2p?=
 =?us-ascii?Q?60tAntEcvyNAkvD9CxCZi+7gof7ONb1zSVuStKxX21e2retGMLYpybTI3D35?=
 =?us-ascii?Q?0UHts7IC2QwPUbM9Wch0lOLMSPxzoPpnpE7+7hiN7alUr/9E07y+0J3Nzd0J?=
 =?us-ascii?Q?mCRhvfG3P9x3LyKLcgU1e3S3RKuEBOGVpUKPyHC/tEQewGa883+SEjZD60ox?=
 =?us-ascii?Q?9V4oRN2yqSrtFJ92gV81ALa/fUyOD4/qnWSQ0ykv0HSHCcYRjebVXqaMV+ju?=
 =?us-ascii?Q?6CufYN3u4CsHYiw0evscuhGblnIk5T+KUsuZgjvYBDoY7Vo3sRBO5Ux2JbxE?=
 =?us-ascii?Q?phnZmCeSnIB81w33n9ILvih1bPT3bA65BNtjigr4JQplocVOyp9vDT3DQhtc?=
 =?us-ascii?Q?2WLiJIS0fjNQ0XNYQD3rngNLxOZWLcOqef6sZWF0gR57YLozYqWdT+MlqLES?=
 =?us-ascii?Q?w75/4UGNdcboY8jj0MPVR4yk+L1t4oKtCjZCIrC8mgHFjmk2jD1IGkya++9R?=
 =?us-ascii?Q?uHF8fNhZiD4/WIEH8XLqvO2KPmmnWY6IKL6zvCkHVFVqO+q4JYIt4FiKJDPm?=
 =?us-ascii?Q?sTNaCcRdKFsC4XAW+HFdJ2ygJG5eerDWqMhBblcyo/P7efRzkNFgRjwWde4o?=
 =?us-ascii?Q?UtUReNlG0RmKaiAZMr/wgEsedg9jtzxyTYqvzMqFOCHvhFrShUgMjaLNbrfB?=
 =?us-ascii?Q?KJg7AEWGBWeMasgkupHKT2vB2xpXysB4aRtYi8RvHnQgSI+6mkfM8/oH/ilW?=
 =?us-ascii?Q?xD8enBjkX+YGMqvzEXOz7sXsZiMu0ZQhPLazPZuCHDXBUd1qO6JDcIUwohDK?=
 =?us-ascii?Q?q04fIQdiAM8cfWAXbajoMqPkSaRTM4Stm2U5r9ySNqYQ8DvA2s6rRjeS3zdi?=
 =?us-ascii?Q?0YHAPlU2S8w9J/3rg5Zd8SHmYwRii+53Xd8uZVzDrevnJw5D5Tk4b++qB+wL?=
 =?us-ascii?Q?wIvF2C6n8BDe7xDFzBMS+HXjsKcOSQaYDSXhynSgG2hUlPhOYqFF+Vf6A33d?=
 =?us-ascii?Q?iueIgjqUySXTMF0pb/yE4feQRR1zaTmRrv/b1uOTPGGqKcdzWA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hu3dn2s1zt9iO32w8DcYEn/EWRVzfDCpz8jd5u0Iq0K3PcwJL9somaNrcpDr?=
 =?us-ascii?Q?KDC3DCTTG3ChPZuTr6KISI02gdyrb9KS5eGRE/cS+jo15aCEdUc7d5OPR6EH?=
 =?us-ascii?Q?maTMfj4lJSYu0CUPFJQRROqHbjx92B/j5/htTdVWBYjL0/RexBbVMb/UOUJx?=
 =?us-ascii?Q?61dQF1FmKPAdgYL3ObOeoKxBCoxHlGdBj/Vch/QSL2uK6hFGtwe6YJ3XSBUJ?=
 =?us-ascii?Q?pXOP3+yT85wQ+N84KQjdAH15nOUJRJh+jwh/yfwZobvJ+L4oAvcKAjXl3Kmm?=
 =?us-ascii?Q?roR6BLzl2IgLM9YSuz7hmU5I/G33CnpmSOWD15cZJoO1zwI3bnb9SYKaTTv7?=
 =?us-ascii?Q?b5iu/NaoOOyWBN9RTIQecOjctMLMrnChtuGDYJghxxITnFfAsU3ev/KNZCwc?=
 =?us-ascii?Q?Vs7WjPeXdUkaNKk2VA4OUKpcGxaVxtrb6atlO22b2Q/GBpUos7i8xA7v8bN3?=
 =?us-ascii?Q?XGJISIeMOfeK6z9D5dSUwzD3fd5BxHythvclslc6uSyyu/dtPMVyqABJyAoU?=
 =?us-ascii?Q?kAt1e2RfyAyMjy0kheeZsPIy6jxNKUSkaZ/CkL4G17iZ0oFXQ9ar1KHvq9bh?=
 =?us-ascii?Q?Sb2nu2p4YZmpvV82dowQEGh/t7hCdsHTFhs6Vct1OlbAz7ZqJ5lEMiy9SroP?=
 =?us-ascii?Q?ab5ajsi22ZEi4c3ZR1N/l6ujG+oPYB22luU9RAtJk624aq0+RV9KADgOwnfl?=
 =?us-ascii?Q?KMTNUaiLlQN7OI/LxSytQU0BnoNwSBNDksF2EIqqO5iRHKFHmbMtKVMpWR/S?=
 =?us-ascii?Q?WaTgD9gGn28xcGLFYimg85FKW5zYaENwZapG93KCZttPeYBTVr9FzL9DGqos?=
 =?us-ascii?Q?CYt9r0Zc7DcqoxC8GSXPi126SVk2NwkUepMfJoifnd60rYYfwZjdHhTYZX05?=
 =?us-ascii?Q?Qr4pr3ysMQwBpALxZYSTEvvshxQ62jmDm8T4zQB26OTIOwMi7Z/Gz52BU1TW?=
 =?us-ascii?Q?eJiubHs4wJLyBzO5yzDbCcq1gvDu8sGy9DxHzPUGF2+lnlqss1/cSvravRJJ?=
 =?us-ascii?Q?mprDh0Lf/DLIyB7hqQPJ4uQTqHY0adAqkg+BK02LfxjSIYycyj3AoY08235K?=
 =?us-ascii?Q?9BFoqJIFYpdKAAaUw8KY56AX7M3twnPW5nR1tVfp394or2HMjojwheor8Urd?=
 =?us-ascii?Q?IyO3oZk6mTBupaLYKELmFVDJDNJmb/PpRnXVn9kuSX9b/nnvs1AiueQsiRY9?=
 =?us-ascii?Q?92TtK8A9lyySxj37gNmoO6SwWoOYOewk+3QHrKqtYNa9JPvE01oaO42IYrzP?=
 =?us-ascii?Q?9eWoyCM4LkJbiBmA7+2PjvvYYoiDBx5goDkiqMpVwxPJfoNEIIm7r2Cg9JyB?=
 =?us-ascii?Q?JfDYcL0eEa4lhQ6L4E06e37w69XZY9eMoH7hPYc1WwTWycVVtJGQymetPYYW?=
 =?us-ascii?Q?tMz6qXyuEM7OrvJzSJ3nr20hQNidwN3Lgc/36UR4+8bpqjf0KmZHKfXveNdg?=
 =?us-ascii?Q?7G/kQViEMvFj05P8xo0R25S0E8F1PK7JSOORwr41+4Ks/WuhtYdL6/uUye77?=
 =?us-ascii?Q?ygnGQHmUI2H/TUL0cer8i+Q51B3SsbSxhB4/2YFEGv5ZrRxYfrn5W4Y5dQEb?=
 =?us-ascii?Q?l7cU66EcygfZUmDLJDnuRrQLv9aLzZIPsFfCp8nx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e8869a-10ae-4d07-108b-08dcaa0d64e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 05:16:08.3350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rx9PBu8wBmgoUr+PsSlyFYVGm2JorZmDW/Vv4UEH82UNVPItUKjAKcGH82g0HZ+RwecIVisMN8emKu95guPcg1McfkUlZpTcRLEv1l/clZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7527
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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



>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
>
>There's generally two modes of operation for IOMMUFD:
>
>1) The simple user API which intends to perform relatively simple things
>with IOMMUs e.g. DPDK. The process generally creates an IOAS and attaches
>to VFIO and mainly performs IOAS_MAP and UNMAP.
>
>2) The native IOMMUFD API where you have fine grained control of the
>IOMMU domain and model it accordingly. This is where most new feature
>are being steered to.
>
>For dirty tracking 2) is required, as it needs to ensure that
>the stage-2/parent IOMMU domain will only attach devices
>that support dirty tracking (so far it is all homogeneous in x86, likely
>not the case for smmuv3). Such invariant on dirty tracking provides a
>useful guarantee to VMMs that will refuse incompatible device
>attachments for IOMMU domains.
>
>Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>responsible for creating an IOMMU domain. This is contrast to the
>'simple API' where the IOMMU domain is created by IOMMUFD
>automatically
>when it attaches to VFIO (usually referred as autodomains) but it has
>the needed handling for mdevs.
>
>To support dirty tracking with the advanced IOMMUFD API, it needs
>similar logic, where IOMMU domains are created and devices attached to
>compatible domains. Essentially mimicking kernel
>iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU
>domain
>it falls back to IOAS attach.
>
>The auto domain logic allows different IOMMU domains to be created when
>DMA dirty tracking is not desired (and VF can provide it), and others wher=
e
>it is. Here it is not used in this way given how VFIODevice migration
>state is initialized after the device attachment. But such mixed mode of
>IOMMU dirty tracking + device dirty tracking is an improvement that can
>be added on. Keep the 'all of nothing' of type1 approach that we have
>been using so far between container vs device dirty tracking.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/hw/vfio/vfio-common.h |  9 ++++
> include/sysemu/iommufd.h      |  5 +++
> backends/iommufd.c            | 30 +++++++++++++
> hw/vfio/iommufd.c             | 84
>+++++++++++++++++++++++++++++++++++
> backends/trace-events         |  1 +
> 5 files changed, 129 insertions(+)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index 98acae8c1c97..1a96678f8c38 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>
> typedef struct IOMMUFDBackend IOMMUFDBackend;
>
>+typedef struct VFIOIOASHwpt {
>+    uint32_t hwpt_id;
>+    QLIST_HEAD(, VFIODevice) device_list;
>+    QLIST_ENTRY(VFIOIOASHwpt) next;
>+} VFIOIOASHwpt;
>+
> typedef struct VFIOIOMMUFDContainer {
>     VFIOContainerBase bcontainer;
>     IOMMUFDBackend *be;
>     uint32_t ioas_id;
>+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> } VFIOIOMMUFDContainer;
>
> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>VFIO_IOMMU_IOMMUFD);
>@@ -135,6 +142,8 @@ typedef struct VFIODevice {
>     HostIOMMUDevice *hiod;
>     int devid;
>     IOMMUFDBackend *iommufd;
>+    VFIOIOASHwpt *hwpt;
>+    QLIST_ENTRY(VFIODevice) hwpt_next;
> } VFIODevice;
>
> struct VFIODeviceOps {
>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index 57d502a1c79a..e917e7591d05 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -50,6 +50,11 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp);
>+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>dev_id,
>+                                uint32_t pt_id, uint32_t flags,
>+                                uint32_t data_type, uint32_t data_len,
>+                                void *data_ptr, uint32_t *out_hwpt,
>+                                Error **errp);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
> #endif
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 2b3d51af26d2..a94d3b90c05c 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -208,6 +208,36 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>     return ret;
> }
>
>+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>dev_id,
>+                                uint32_t pt_id, uint32_t flags,
>+                                uint32_t data_type, uint32_t data_len,
>+                                void *data_ptr, uint32_t *out_hwpt,
>+                                Error **errp)
>+{
>+    int ret, fd =3D be->fd;
>+    struct iommu_hwpt_alloc alloc_hwpt =3D {
>+        .size =3D sizeof(struct iommu_hwpt_alloc),
>+        .flags =3D flags,
>+        .dev_id =3D dev_id,
>+        .pt_id =3D pt_id,
>+        .data_type =3D data_type,
>+        .data_len =3D data_len,
>+        .data_uptr =3D (uintptr_t)data_ptr,
>+    };
>+
>+    ret =3D ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>+    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>+                                     data_len, (uintptr_t)data_ptr,
>+                                     alloc_hwpt.out_hwpt_id, ret);
>+    if (ret) {
>+        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>+        return false;
>+    }
>+
>+    *out_hwpt =3D alloc_hwpt.out_hwpt_id;
>+    return true;
>+}
>+
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp)
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 077dea8f1b64..545f4a404125 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -212,10 +212,88 @@ static bool
>iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>     return true;
> }
>
>+static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container,
>+                                         Error **errp)
>+{
>+    IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>+    uint32_t flags =3D 0;
>+    VFIOIOASHwpt *hwpt;
>+    uint32_t hwpt_id;
>+    int ret;
>+
>+    /* Try to find a domain */
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>errp);
>+        if (ret) {
>+            /* -EINVAL means the domain is incompatible with the device. =
*/
>+            if (ret =3D=3D -EINVAL) {
>+                /*
>+                 * It is an expected failure and it just means we will tr=
y
>+                 * another domain, or create one if no existing compatibl=
e
>+                 * domain is found. Hence why the error is discarded belo=
w.
>+                 */
>+                error_free(*errp);
>+                *errp =3D NULL;
>+                continue;
>+            }
>+
>+            return false;
>+        } else {
>+            vbasedev->hwpt =3D hwpt;
>+            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+            return true;
>+        }
>+    }
>+
>+    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>+                                    container->ioas_id, flags,
>+                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>+                                    &hwpt_id, errp)) {
>+        return false;
>+    }
>+
>+    hwpt =3D g_malloc0(sizeof(*hwpt));
>+    hwpt->hwpt_id =3D hwpt_id;
>+    QLIST_INIT(&hwpt->device_list);
>+
>+    ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>+    if (ret) {
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+        return false;
>+    }
>+
>+    vbasedev->hwpt =3D hwpt;
>+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>+    return true;
>+}
>+
>+static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container)
>+{
>+    VFIOIOASHwpt *hwpt =3D vbasedev->hwpt;
>+
>+    QLIST_REMOVE(vbasedev, hwpt_next);
>+    vbasedev->hwpt =3D NULL;
>+
>+    if (QLIST_EMPTY(&hwpt->device_list)) {
>+        QLIST_REMOVE(hwpt, next);
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+    }
>+}

Looks the detach flow is still missed?

>+
> static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                           VFIOIOMMUFDContainer *container=
,
>                                           Error **errp)
> {
>+    /* mdevs aren't physical devices and will fail with auto domains */
>+    if (!vbasedev->mdev) {
>+        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>+    }
>+
>     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>errp);
> }
>
>@@ -227,6 +305,11 @@ static void
>iommufd_cdev_detach_container(VFIODevice *vbasedev,
>     if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {

Shouldn't we check mdev before calling this?

>         error_report_err(err);
>     }
>+
>+    if (vbasedev->hwpt) {
>+        iommufd_cdev_autodomains_put(vbasedev, container);
>+    }
>+
> }
>
> static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer
>*container)
>@@ -354,6 +437,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>     container =3D
>VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>     container->be =3D vbasedev->iommufd;
>     container->ioas_id =3D ioas_id;
>+    QLIST_INIT(&container->hwpt_list);

This can be in ::instance_init().

Thanks
Zhenzhong

>
>     bcontainer =3D &container->bcontainer;
>     vfio_address_space_insert(space, bcontainer);
>diff --git a/backends/trace-events b/backends/trace-events
>index 211e6f374adc..4d8ac02fe7d6 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t
>ioas, uint64_t iova, uint64_t size
> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas,
>uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping:
>iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64" size=3D0x%"PRIx64" (%d)"
> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>uint64_t size, int ret) " iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64"
>size=3D0x%"PRIx64" (%d)"
> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=3D%d
>ioas=3D%d"
>+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr=
,
>uint32_t out_hwpt_id, int ret) " iommufd=3D%d dev_id=3D%u pt_id=3D%u
>flags=3D0x%x hwpt_type=3D%u len=3D%u data_ptr=3D0x%"PRIx64" out_hwpt=3D%u
>(%d)"
> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=3D%d
>id=3D%d (%d)"
>--
>2.17.2


