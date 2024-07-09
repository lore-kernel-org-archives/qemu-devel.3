Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F3C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR478-0003X4-8r; Tue, 09 Jul 2024 02:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sR476-0003VW-V7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:14:08 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sR475-0007BS-0w
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720505647; x=1752041647;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bP4dbcSXcY1/ZNVVqLxNIOKjnuam1RuoviF5Wdent/Y=;
 b=JuoAmwneISLYfSJsUqxSuEG0GIfLibvZrSaZez2IRCobAkG1wKU4UZql
 wRmuVrl5U06APuX4LRlAWOQbpzKGTwX+vqs7iU8Z9UmtGX0e2mfbbHmXH
 SXTugKugEkCPtxzX5i5BaK9KR4ZlrY2rnGRmrMchvOb4XPrSp9+3aLtX1
 LpvItkTqH2lNWda5t1iBOIk1kXTQLeNm2ZibQV9uh0lTZZzAv+Dw6RLT5
 K3jLAYrIKMaQmahrEQQjD6d/xmjFwADSCj89ETk2W9I8yNM7sSnFp5MIp
 0Whcl3Ukgt1i5cnGplOEul8Jq1tab/smgYg7NiAfp3eyCSBujOWyhR4oU Q==;
X-CSE-ConnectionGUID: FczQAWbDRJu2xs93842sZw==
X-CSE-MsgGUID: CEoSAeqvR4mFw5E+aO3Zmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17874374"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="17874374"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 23:14:01 -0700
X-CSE-ConnectionGUID: EOnsLsi6RuOxfjdCZFq9NA==
X-CSE-MsgGUID: g/GQOD6OSkC4etzSKAYmGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="52921781"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 23:14:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:14:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:14:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:14:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzS+1m3NMbyS6SiNAcwJnEzYMjQF5pZh1dQibzVxppfdQCZXWfjuQUo+dCUV+zHBhVOTLV86Dd+w4QPNXz/QF35m/E8S/f1Ah8LzKRJdSc3qfl8OytJl79BGHEQJO10IuCXJFYsGbdRIDCJmS82w1sbximpcJisAtWKmXW4aMixPKopTWETN3WQtN6kHT1nIGycVp6VZQogbP2uWGcdlZCFXvztslJTepbJenGy0dFcofw3LpQGDomERRLHgsyKEPb+l4+VMXXyQIONCrXUEuPYatekq/WuVNAToGiaFIqJ3fMd9oT4+HP7fje5O0RAAvtmRHAEZL1waovVL7ufh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPFsbRDpvo71VYExIpE9VcZynO/3B6FWy3tLPaCUz9c=;
 b=aOdGsyX7jqOhu2NXW+hgqUp8jyVuGt2TpZYqs0ZCZbOFBWjp1twvQEkSuNyMdk75xRiYV+P4+WVaUKuoqHxPD5VpruwSalKhf0l8cKWCWSbtTveWtK+Dl4vqsFOHPpFcK5UcuwX6spBXhQMC9phWzOZg93/iiL/ZoUhlMFG52RDLVrQ51REMN4FmzQeGivAgrivvzRrbgpeqCmcHXQ9msg5K+JI/ZMXbBhA6T1iyLem/mFYAUkbijaTMfQSABMP3txlp3SHWKKBXQ6SaDoPFxrjPZnHDU7hHpDxG6H9UNaGT2dtf14eNg7/2v890KbFjxvFQ9GqysWrcVrCFvVNuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:13:52 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:13:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v3 02/10] backends/iommufd: Extend
 iommufd_backend_get_device_info() to fetch HW capabilities
Thread-Topic: [PATCH v3 02/10] backends/iommufd: Extend
 iommufd_backend_get_device_info() to fetch HW capabilities
Thread-Index: AQHa0UP+w8aLRdsLVEqNrWL0tgvtVrHt61WQ
Date: Tue, 9 Jul 2024 06:13:52 +0000
Message-ID: <SJ0PR11MB674475DEA898596A9EDCE61992DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-3-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-3-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH0PR11MB5219:EE_
x-ms-office365-filtering-correlation-id: 136e6ba5-c122-4384-512b-08dc9fde4e59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2QDiQKivECuw1Lv8mFghYPO8AzCx2fb2KGVo1tVojVQ4Ynmw3c19VfMToL+/?=
 =?us-ascii?Q?UM99c3W19pKlZ2aCE+i7emG+GpB/DqsxmW2jWSPB6jpY+mG3X02NQyBzYwH1?=
 =?us-ascii?Q?7cqCNNC/WhrRULwj4iLCgXpaxVvmIrkht+Vjxh3OEgxZWNwCjmZrVbIAkBQA?=
 =?us-ascii?Q?brwNCPyeQy442yrkNS9HOotwRUVVEiDFegFL+nML6qAxyjoB4Nu6b4a/NMWE?=
 =?us-ascii?Q?XMzOnc13TVU0q1lQj5OQsO2ZzpW1N5CO8FG8kx6eBD2CE8KYX9CfXcFuFyU3?=
 =?us-ascii?Q?RMGNCi7mCkzEYsj/HaS3lEZaY+X8T6VUN0r3WDlvE8XXFuWFr5rSVNK6x/f2?=
 =?us-ascii?Q?B7NZX4XtesjbXRcuycE0cQIjuIR4dy5NPMcadpLs4xt59rPIOxCPRDzAF0So?=
 =?us-ascii?Q?3lnasE2aYFmmrP10yaaQbutTPZ1rMMmGgV2T+q5HI3t6wanD/6nCuwtcGwEY?=
 =?us-ascii?Q?X084g9GyunGTXPXVeK6a5cK8Hb9N3KsDluMGSPR+LVnzsZr6WYVRslO/oQo2?=
 =?us-ascii?Q?olMxDPjoJh7Ps6OcHzTeLbZe9LP58jBX1WGF/nzJXlHJLh+3G0kDx1G1OCzk?=
 =?us-ascii?Q?74vgvaxFrcInbeJCPgM19K4fKKcIes8zsekfZoVThlMOFxnnKW9fAvR1QBTs?=
 =?us-ascii?Q?b8jYQzKcckkkcgTHQr/Q10e+hdgMbUCQqrXi9zgcTig69ehxT5je+5qj3NXd?=
 =?us-ascii?Q?eM8n9lrUYKT8RDI0h7o/h6uxo76DE2IFfHwg0eoWZgk4e3aHGlcawA32cAYk?=
 =?us-ascii?Q?yMhLFdbSbRfxZpe1pZA6sOsqTlp7ciBZ+cvki+lc4aRS7cZ1oNNDcPxMFUOP?=
 =?us-ascii?Q?c7eZzTJb/wxvaoJHf9BHfkZkfuBQwcm5dD0KoD4xxTWcG7nn4KcbacdPAj4R?=
 =?us-ascii?Q?I/7TZ1Ztg1xGM/FmNNu4Y/Qjm8ojmE3AEt8FY9tbuUwB2Psw7doifHb1eLju?=
 =?us-ascii?Q?Haf8AzOUfO1GFr5+VGKVPrfbymV/YbbYVGoMA81KNBuymZylOfGxLUIrF1aY?=
 =?us-ascii?Q?SxRBwpVGURUOWY8qhpxZn+wVJsdamRrqHiZX/DlYibTgaxGd5MSrc6ZrROc5?=
 =?us-ascii?Q?4xABgY4WO0wtj+5U8+xi0zL4oyHk4q/v8QGVWN68hF40FtJ91mH2XlaXJ7Lm?=
 =?us-ascii?Q?1+xMAteZJK4G1QSDgB3e4y8YQYrpoDk+x9yrnGMaWDYUQYkiQQ28ipe/BkiG?=
 =?us-ascii?Q?/nARZY5+FTWwcMagm4aWCikVgGcs00mUUpaGQw247Xi0uxHkChDlGC5RjxZj?=
 =?us-ascii?Q?hNWjTQeh+qKHv+WmQDBEmnhe96IhzGWcvA0rx9nBLpcj8TfH7eNggmvt+ZbL?=
 =?us-ascii?Q?13ADtIOHaLlrJHrT+vl3YG1+LQMmcaEq5tZImurxIEqWpdqjruL8rc1Q2lkb?=
 =?us-ascii?Q?rdnuZnn/tgDhgCKtt8kWWSZrwfz0Rb+LekWSWZ3WYreSKxehlg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kwmsxGvZLTfRQmjAR0wbdCXvag8Pue02C/pf/j3UwHWBXNmgZCY7072C1CXk?=
 =?us-ascii?Q?aULVGsqweyOCi/b038LDdVyIKKXyU0DXJveze6PwUwNJ2V2w6T8wMio7yfQa?=
 =?us-ascii?Q?fklIt2e9tsPx1bEw/daZWGS+afPRRHCr28M+o5v7h5SJAjE54/sEiICVLoJ5?=
 =?us-ascii?Q?wGn/KGYqe0KjcQDmOYzwo/p84a85pw0evsREIl+XZEPxkNvgo/QIo93l9fZh?=
 =?us-ascii?Q?NuHsFI4yiBpJMPC5zVVr7FY1TmLhpCK0o3UI3nkKIE+a4RLvsycOZAYkaHix?=
 =?us-ascii?Q?DY5LkSbEj/k53ULFXzEBUhYzW6ONhv7e63xEdRbiUweiFuLlMlNAPI8Dtz+z?=
 =?us-ascii?Q?FIxWtMYwrNdx8Pqa7cTdb/OdjXfzZOUuhqQpI7Qf2O+HZuWGhC5nxlXzULHf?=
 =?us-ascii?Q?vZZ1BfVO6wpbPvFHK7vHYYdD0SL047xFQzvVwABmMWlKl+kWhurlTOKRPUCy?=
 =?us-ascii?Q?tlxJ6zRWHSJASgpdgEeeyIG5jtjl/dFWCULK8HNutM0NuB+UtBSGqhJ9B86D?=
 =?us-ascii?Q?dcNDrIc6ESI09mBUuuPvJaTIXJ7nFNGhO4Q8X8/n7Y0x/xfo0B4dlm+3JNbx?=
 =?us-ascii?Q?6gXOos57pNsHa4Sy0bQsz7BDVsAZcTAA947oDPNf46WHSWkToltMSDC5DEgX?=
 =?us-ascii?Q?fHu1YpzK59+Kvui/oxHVeOCyA+KAe66mgc7BA9M833dg7Nh8hI40EBUTxHA+?=
 =?us-ascii?Q?Y/QS0N/6uDcyHqHlBs2Tp3VJc2AQ+OJqgOwnJhYZ9UnIU9NPv1SW+Sy5QKfw?=
 =?us-ascii?Q?5xkZVuUsmSFQch5U+H+NstTRJa3gFvz0HnZVPd35uOgO+Gav8iy9PEVLvJLQ?=
 =?us-ascii?Q?mUjPQu801GunXSfXCe25oNS/bYCXtI5pGEI5R194mteiIUmIYPRNfxi6z2Dy?=
 =?us-ascii?Q?6zFffnxoNQllbGGvIzIworSgS7CHZbds7PEzkbydMpiMPmEdvojSfF57UIyH?=
 =?us-ascii?Q?LQQQMd64tV0FwffFXc5vErYFH1GJV/1Tamz3sj7BK/66Hxx/cPS5a35xrhuc?=
 =?us-ascii?Q?a+awzGfIyGP4HDei8lPo7RdvnX40XNGIgQVJsO8FWqOFVjxLwC2W00A7GV5G?=
 =?us-ascii?Q?FapMmFalwHGyMqMI8OxnYIqqotbHzq432ewPWYxVESmVV9U1TL/eZu0dg7AH?=
 =?us-ascii?Q?21SJjfAgnPwqQY9vJuZEG+tNMh4SdRH3gPf89oibAv9rBNdK3Rd+Qww+wavI?=
 =?us-ascii?Q?hxd08bwDzIlJQZoTYxk9bq8wiefy6tMP3ASyobPXE4W2/1x0+YpbLFD0cmha?=
 =?us-ascii?Q?nBaywHa20IjwpdAQ9rGMNgvWhSG959oGetKxcJ7WmslMsyzO4udETvy77nno?=
 =?us-ascii?Q?aECmZTphCGhLBYc1vn6WlNA01g/oXQ4svvG8RfgI/CkLri9TFlG29K/LIpBK?=
 =?us-ascii?Q?y4r8cGW2vwdVw9xAKlNJi8vuaikGC64j5FJGupEf+qsG+yBL6oAQ8kvdf1Ab?=
 =?us-ascii?Q?w0RccOKLh2saN35fwC7POws0I2sl5tNuo9NhP2hp2S//xnZD+JMtAauNalfV?=
 =?us-ascii?Q?d4IhRmMYHu022iCz3Bs+Bwyud40dPKW4ZwcWqjguTiDSEz3RzqgTgNJSkTcY?=
 =?us-ascii?Q?uuKOqOjOBBleDxfKvS14pjIQDiAHqzt67mFntazd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136e6ba5-c122-4384-512b-08dc9fde4e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:13:52.5483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yG5d9Jc/d1uoED7WEy3FjZvnqWYLW/OrgogDc0UgepnHpjq/Sm8ca0i/7meI7TMAu2ASxZDEwFv3djWLOmo9XCPNb4U+NYCvDJ1XqMEtM9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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
>Subject: [PATCH v3 02/10] backends/iommufd: Extend
>iommufd_backend_get_device_info() to fetch HW capabilities
>
>The helper will be able to fetch vendor agnostic IOMMU capabilities
>supported both by hardware and software. Right now it is only iommu dirty
>tracking.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> include/sysemu/iommufd.h | 2 +-
> backends/iommufd.c       | 4 +++-
> hw/vfio/iommufd.c        | 4 +++-
> 3 files changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index 9edfec604595..57d502a1c79a 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -49,7 +49,7 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                               hwaddr iova, ram_addr_t size);
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>-                                     Error **errp);
>+                                     uint64_t *caps, Error **errp);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
> #endif
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 84fefbc9ee7a..2b3d51af26d2 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -210,7 +210,7 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>-                                     Error **errp)
>+                                     uint64_t *caps, Error **errp)
> {
>     struct iommu_hw_info info =3D {
>         .size =3D sizeof(info),
>@@ -226,6 +226,8 @@ bool
>iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>
>     g_assert(type);
>     *type =3D info.out_data_type;
>+    g_assert(caps);
>+    *caps =3D info.out_capabilities;
>
>     return true;
> }
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index a4d23f488b01..9cee71659b1c 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -628,11 +628,13 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>     union {
>         struct iommu_hw_info_vtd vtd;
>     } data;
>+    uint64_t hw_caps;
>
>     hiod->agent =3D opaque;
>
>     if (iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>-                                         &type, &data, sizeof(data), NULL=
)) {
>+                                        &type, &data, sizeof(data),
>+                                        &hw_caps, NULL)) {
>         hiod->name =3D g_strdup(vdev->name);
>         caps->type =3D type;
>         caps->aw_bits =3D vfio_device_get_aw_bits(vdev);
>--
>2.17.2


