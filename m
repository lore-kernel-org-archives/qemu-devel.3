Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AABC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcWh-0004ng-2O; Mon, 23 Jun 2025 04:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTcWf-0004nU-6D
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:27:37 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTcWd-0000QQ-30
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750667255; x=1782203255;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uk19Ru2DfEN2dyqS34hTXLutcI8fV0Ysajx1e6XtNG0=;
 b=LXaWw+lATxLxe6uAqqZVieKtKnX9JCvk3R8XaChVNRb8D7DB1I+u4yqo
 Rov0gul/xqZ1mkYe5E5O+SQySReTJ5rpfVzFKGwQWywuWMkBWyKhxubwd
 NKkA4Q7F1kiCDxKCxvlr0fuUtrWh7km/7tXIuHljv8pqHeA+GgHUi2Q4e
 nmRIp8YdaevfTfYu4UmOudI2XWnY8xeapAbzrXpdMVMPZ638kERvTDb7S
 WauYgVW+iigFFWksiPW9wdZ3iDy/qpHJM8RmHuY6mab2RMxgCK0yXIaz6
 SxFtHgA+pC/66Z8Xf+/rMh7ev4sQ1FGkg99fe0Yk6dMb2QrUCL7NkbeKY w==;
X-CSE-ConnectionGUID: 3/xIcqPUQd6lHyZjc2nqDQ==
X-CSE-MsgGUID: RpbJL9r4SyiVEMaGvjqQwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="55496250"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="55496250"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 01:27:33 -0700
X-CSE-ConnectionGUID: TNiFSCQtTNGD5U1eafGyYg==
X-CSE-MsgGUID: wvPTuYE5SmyX5lCr4TFNKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="155544844"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 01:27:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:27:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 01:27:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.73)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:27:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jidluP2KtHXViOaEdPVULl/tvoaNd+MiSJJ/tjqtsfo+w+OfJDgAqWhocR7VaNzQi7VwO7wZWQMLV26QVws7eawnmVixjTMY+z2ujJEIWg2pXg0ZTgpKyphHECHjN0Y8sJjczPoYzLQLsYwPZaOQQ1xQLj8woSctR7dXiIpKq+V5l88tkiyStjPtWKOfcDkod0BXgSPcG1XopWQDOD5uyd+xYK7iR3dbCBohbALSjXi6XdsNfkCqaqMhmSzo494TuyA1aVa4rYJI4Kjgve4JoAsEbEoRcejTTWsF7xdHM3mKBRUsWfBTh4+nWS73+XoN39wUQ0nQ4gEr9BWxAVl9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZYGslTjutlxRnm/yPTe3y71cHjLIDZke6By1B+Jo4w=;
 b=nLEKgjNiZs9jMG+hdKcp2WQRE1fzl7KtgwqcfCj4I5rppNgkfPV/JahjFb8bgS+ihuOUwsV8oRHbnG0JepVEOxB3oZ/CxnviEYq+n56VbWkgdGembVV2ixBXUP0BTUle4DngsevQBsannYWGoDuIAICC6F6S6W31nxRxV+6tizaciGNcFTFKcK0pX8+0Mh7qy9heJfQOx3/wOlt5uT+nyxZ8KDa6MbBjBOmifWlo+JoTSqFC86Z4IsimnGl6kdBxMZhn7yovSynnkqnf9cZqKibxrt7DQLNTW7Nm91yIjnB2vr8LQVfi91Z3uIthn7acPx0Gze11SYQPY9YK2hIWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 08:27:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 08:27:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 27/38] vfio/iommufd: add vfio_device_free_name
Thread-Topic: [PATCH V5 27/38] vfio/iommufd: add vfio_device_free_name
Thread-Index: AQHb2h4ORZCVKd5t3ESRoECOL30pSbQQfO6Q
Date: Mon, 23 Jun 2025 08:27:16 +0000
Message-ID: <IA3PR11MB91365D3A381EA48E4BEEBA939279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5064:EE_
x-ms-office365-filtering-correlation-id: 764b0cbe-dbfb-4ef9-e44d-08ddb22fc337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SdZ4cFZx//CD0MvkhqgiYLs12X3PRpR6qvMyBvVg2XJ+xGcFoYBalq6BFuhe?=
 =?us-ascii?Q?YCs8z6CWPcUlJ+GQe8umvS/4bR35YuM5s1k4VtfAwrLyMEs88j0oi8ynS6Vd?=
 =?us-ascii?Q?++TodKZ0lQ2gLsBzQQajQzjlNGsio6EtELaPfKtFaYiaQBk4AAeqzPscfcpF?=
 =?us-ascii?Q?srxKLKbNHd01ytP5/okDcjF88dD+Fmu0SD2HXK2K2hrDe1SDZJeXfMbpQITt?=
 =?us-ascii?Q?/vyIJMCeeqxvXKocZGqrpoxQUOyW/oBBBKRrXzVcl5WtbcC4BWULny8jsKU8?=
 =?us-ascii?Q?WWmRO7rwLYX7H6/qyv0KUwO5cOmYp2sSZ1XQKL0kisvDHRy8n0MmtvMUelJJ?=
 =?us-ascii?Q?f7zGv6MJ8DEEj9xl1xyoE55aYQ1knYfJaDWz8rWw3AfCDmV+v9ehfPu/9CuE?=
 =?us-ascii?Q?OBPrblUm/2bAA8SkkrZ0cw9mZyZVu+nN7GJyilVKLfbcn45OvM+08bRYFPMg?=
 =?us-ascii?Q?KX6xQ83lgeBGai9c5QK+j4vAHHUbE7J2cdY4sYsn50R/53JCkhUsOykK93uS?=
 =?us-ascii?Q?aIysGQ6mEEx6qLR8Y3giL5Xhs3z8PVHjN/HCAaMF+sdOdQWwkIbYt162e0qt?=
 =?us-ascii?Q?GnL3BRyTFPCu+GrAnrZ5hGTW+F+IloJfRgGswkp5O39N83fmg3pcoLI/0dLo?=
 =?us-ascii?Q?S/Pd2VmXbQdCkxDn88rMLklx+LcbJZeVLqFjvbJxiqcn80DwXInM+pYGlCMY?=
 =?us-ascii?Q?+XSqZhTfpxNT8ayY1eYr7mdSk0LXsuhTGovrnDka7aV7qncyAOx0JJxq7NWZ?=
 =?us-ascii?Q?SIKb5kVi071ywZXPnjmseKpaVceV3eHL2QPztV82s2K/YrjH/2QlCfo/jtr3?=
 =?us-ascii?Q?mLmeY+L/gIVjYFSYcHvXB5R5FgZwNUcclo/QNrrOm+WuJERHQ0vpcNN0rj6U?=
 =?us-ascii?Q?UmV+RYUEy1u9RmEPum4zQbrQ++mBVckhD5dERErqfBjscFxyhW6o8xo/ykai?=
 =?us-ascii?Q?VmqBhjCaCl89YsheP5TaNWH3FYUYKZMbw3Atg54Dl0WGPZQRf2vtWEp0UNRk?=
 =?us-ascii?Q?mtRlpCBOLeAf0Uwdd7vh6kLXp99PdagFP4fOXNgU37IZCf8GG8M7N1RM1JCS?=
 =?us-ascii?Q?Dt9pQ+z+uq3VaoUt1o92kMYuAQA5HZ8K7iUo7DkoVpWfr/tzTne3RDceAesj?=
 =?us-ascii?Q?mCOUpthZlW/47BBb83N67gLMj7bDtisWqlen0J5UIA68LxCfokgIOe7ptHJJ?=
 =?us-ascii?Q?afDOMu4v49vcI7vlFZHSbVbEAQI/gEczoSzGUmA+ROauAXefiyNvTWXL2V+x?=
 =?us-ascii?Q?vrhgcccOoRQz8/Ak4nmmJJefRtU0wHao//xM6KKyNXLuDs751TMox+8/ajFU?=
 =?us-ascii?Q?1iQZXalp8z3uFTjIX6u43RCaOTrSzwP7s0s7DUOc98VBumJN9GdbNhL6ui+w?=
 =?us-ascii?Q?p7uLV86SxHBzbd2afLKWK0DEPttqdrCaghnGBoFN84noh9RZ8M2lwG22db1g?=
 =?us-ascii?Q?af4Nwu4hFqBjbAihBRAoPOX9mRlDOVP7gPCmH/Kx7lVSTU9RS1pu+w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?80lSDgCPp+OvzdQpCwjGfUhJVX1Q3+NCivbjhK4guXMDxwRaXB0mz0ghDmSd?=
 =?us-ascii?Q?npYkEfL5ueK6m0ajGmQzUN37O8KnElAym1qD4uIbCLHmNoqQeRJBqDlnAxdW?=
 =?us-ascii?Q?bHWTXWeyxMxpxyxhhb5m/vLUyWbYq4hat8kmUwWnMFONvUD14sK5gxQuuso6?=
 =?us-ascii?Q?8415pCchwX3zIkwKcTUkQvR1T7YOFEnx2wxstvLtvr2HVdzZlVYZN8DzChbY?=
 =?us-ascii?Q?GBb9D2zXTLH6XRod7daz+O5/EzNKGYi6ZHf6WLrswn/P8cPnZlJRHdmuF2Rl?=
 =?us-ascii?Q?WyTccjO/vYrQNki8Y7mxhhcogsQheer5gngf7RdTTO5xagus9Z//C5CrjEni?=
 =?us-ascii?Q?MliluaD9T4d5ljPEnSc7GI09UlZMmQ+sprsKWETN28B3vOtxwASFYvw/4xiK?=
 =?us-ascii?Q?Vh5mEKrmuMGeEivnVCiC9wT5dBYDTlk3+6qJo9sGeeTGlIKY2YAHSm78F36x?=
 =?us-ascii?Q?WIdP9d2hG++fTTsHUij/mcU8kw7pbECqb1L5IdfQ9ahhGa0e9yyOxjqc/wXq?=
 =?us-ascii?Q?X6H/FNBYbwPYLMvMPjzh4ofnK28j3Tq+fNb1/kRn8G9BkxV+Atp9G639qGUJ?=
 =?us-ascii?Q?tfB79txWoB/wsLczzSTIR342fFY6ybaAibwj5nDQ974PGkIeUqHrotzFSObI?=
 =?us-ascii?Q?tFQCLmTcC97b7bM8vg9tMxwdLPbLIJpsbwbXrRvxYKlwhB5EZ5NjuxhqSgFV?=
 =?us-ascii?Q?XhDwuMY7C7NRW5I+vGviCjxzqr875/xMsV8vLFkD6OntSvfhZp66RhchhRhw?=
 =?us-ascii?Q?D6LReZqswVYpguKS4W1QfEJNS04w159gx/S9ATLMwmpHC8DGGiJKoy0tGGg6?=
 =?us-ascii?Q?lmt/36L9cK+vgMHkjs/TSGGYoBlwfdyS8mZSAoesMVPsPnxTVnqSlvAhdnzo?=
 =?us-ascii?Q?W/irpQxUc5gRJU+GFLE9w2FM7ptmcgCUuhAcPATwcXM8pNSAJ5SiISk7tOA7?=
 =?us-ascii?Q?4Jy3CuFrghy8UoSyKRkURUGMj1PIRRTDcLClffBhjQVVsDD8JdSyHjynCFvY?=
 =?us-ascii?Q?Js4Al0LHLOOUfEVKAbXkVlGwueFJRXYN8TTXPX49J5PN555fT7ABzSXAohDl?=
 =?us-ascii?Q?y2WacoVAd7521Mnvl2JY/ZowZEF5S5FGrN52qlZjl3CS25zCE+t2zX4RCiks?=
 =?us-ascii?Q?URTaoAOjRukmsY4zKCZK/uQlr5O5qYp2HqNbSbsIQBRTKq7Xg8CYVZu43qX7?=
 =?us-ascii?Q?thskBCYVBcjGR2LHV+2eT7HsA99BR3HKJHUkJVfdSLiizUgdI00Y0XZ/j/03?=
 =?us-ascii?Q?84gC97xeQxoe1/IfjvZ4rJY8/Z8c6IUuIoqkIWGP5MlxiZozEPG/wEFQYa1E?=
 =?us-ascii?Q?1M73G/C8OgQAFswzj06M5SMUznc0gpt07751I8RjEbiirJp3NpL5YmcFNI1L?=
 =?us-ascii?Q?0SbtuGvvdhs+6dh38czsFP2rsUrXAgO1Lb13eC7Aq+Ml6/Io2/NiVtjUsNfQ?=
 =?us-ascii?Q?QsoVRYhEvskuEiST/oWACuhzlnb+j5GzIGf80oyexhvT4/+EU1QMdSe7FWn3?=
 =?us-ascii?Q?K+pkWhyFOu5e8DmoJ93G3rOXCoGxNSAa52ni3oq7zGzc3OlsPCa/k/W1a9Ji?=
 =?us-ascii?Q?zc+w7lKv7vYCBrZ1qDhhG7TGVGjBwJigwxbQfTsK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764b0cbe-dbfb-4ef9-e44d-08ddb22fc337
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 08:27:16.4280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZ7sF5vagatXhHyoCma8XQObKmjN72k0T4yTD6EWk97X8QLuFVQM/vxx3n/bIJ8aCQUqK0WVhS0v9bD6mjKGhNGb/kFLgJ/QCK1HSPRevVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 27/38] vfio/iommufd: add vfio_device_free_name
>
>Define vfio_device_free_name to free the name created by
>vfio_device_get_name.  A subsequent patch will do more there.
>No functional change.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

