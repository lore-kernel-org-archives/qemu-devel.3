Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E9AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 09:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFrNy-0007ym-7o; Fri, 16 May 2025 05:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFrNv-0007yd-Kj
 for qemu-devel@nongnu.org; Fri, 16 May 2025 05:29:44 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFrNs-0002wB-Ty
 for qemu-devel@nongnu.org; Fri, 16 May 2025 05:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747387781; x=1778923781;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7drIM43fJRFyVaMv8FjLcUaV3PcJYk8xeoxPIsVpfrY=;
 b=V/X6vth75OEAo+Tkmbx9quD5yIxVTL4bDsaqkq4SXcqznGFry7sDjtBA
 x0Gbb9GItjqxIg9v+M7K2VppQ3shLqaIelspFgWUmlhAxYGuwpoUmERSN
 PVrKwdlKHRjYHWU/6jqsEyNklEC1uMltr2QSWqApVLtlpdtGsKeVay51Y
 QpoMUcCqerpiU4ZYdPzXVdFrb63xiSiP6zvVzonuyPoHsmiBz0YIwtc0I
 sXpCUw8KcWCgGoaUlBLJs/lhra+4Oy8ycVzxRNhYz9IEFSSYMftJnUjUX
 juRhE3/ySbf3IKE516NOQxBJPz8DNvs1WjSe9c9Vkmrj1zC5cb9gYdJZ+ Q==;
X-CSE-ConnectionGUID: dk+tEYVISZODy51yo/qCsQ==
X-CSE-MsgGUID: Inz0UyfwQayAF54aTgEfCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49491849"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="49491849"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 02:29:36 -0700
X-CSE-ConnectionGUID: NRDXC1YgRxypPTYcFSsFqQ==
X-CSE-MsgGUID: sJuyttGvSZ+VYfESysn82g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="139124135"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 02:29:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 02:29:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 02:29:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 02:29:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoKUI3KrJqAhMiYGShvzNV2OQ4sI3ks/OqyS5RQqMk0oYTF6lWd0zLIasV0ATZ54/XdZR00bgS1vTM/hL4Di3xpoCIWQ4hXsm6sacOXe8GXf9Xcb4vkp96g1Q/jWaPvL4yySr3mrfkOpPsLaMDJ12DJfRPLU/NngiOC+eoIkjVZ4e27I32ZDL9tpfQlSD9X35e7zX/r8ZLbntZaveHSLYNW5v/NJvZJGt4RJJCqEA6xLtBpCtPrPDgft2antQRXGNB7hCVQ6ATsn7oimNx16S5Iq2mxY6lJsKoWXPNx9jcZSVoYpMpsVrLZg8PZo6jwyhF2X9KMegrgspEYx/bVJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY9SBLBKqjmn1g++FW6DllAPwAvGkIzpFp6+/JyGhRw=;
 b=wTglx4f5WnS8/I9ht2CyE/1qu06KE6i+wfddyLK1FPDOHu7vJDFMki9CZ4is0BhJHTwZPW73i0YikDhTsx90dn52uC1VcZiocSXLhdY+uwiUeJYJagnsvuFqR5a0iO8X6p7IO+IhH/LYaWFx0QPAz1rvgXBeTOwZXNYKqjYSyu7t7NjhtSGiI6fhxVYFYdf62T77dC/dkUQtK6ARhMNmE1pV509jpgxXZrkigcSuCeY47Y402+y3+/djW+NlkoHEo/c6fmQh9G/SX9iymnRg+CJF+d+xiZxko/4zkI6FT9swmkQkuNWMBxzMVbQGDIgUolzjdGnyFx3gkpj1J/BSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 09:29:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:29:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 34/42] vfio/iommufd: invariant device name
Thread-Topic: [PATCH V3 34/42] vfio/iommufd: invariant device name
Thread-Index: AQHbw1Nh4I+IFptXNEuExdNUR7bUWrPVAylg
Date: Fri, 16 May 2025 09:29:33 +0000
Message-ID: <SJ0PR11MB6744ED7B4B490D35C50A75DD9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB7014:EE_
x-ms-office365-filtering-correlation-id: 3e2df223-ed08-4312-491a-08dd945c2b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4jL6i8u8GfE9Vl9bB/TREFPCcMjx9AApvneRihytr2MPnq5AGJBskDOp3u44?=
 =?us-ascii?Q?Y1dlR6Ja9G0yLeh9JBVzSdOqSI3uvyxZBj74R+t1/A9bk/nvHiYb05xPJaDI?=
 =?us-ascii?Q?hjaG2WoAq3bKe84/5/U9SsArX+GxOlsHkI1kPvovXMrvZSlAwG4PSp8mdV8v?=
 =?us-ascii?Q?CwEluK7eA/0KgRXB4licjs+CjFniygAT6PXnUelufhj+yZIaH7GvaYsON1Q3?=
 =?us-ascii?Q?AxIRSmJFP5ZjhnZ0wY+QgXOS3URQ/VXoG7Bc/3R6BMblmJvbsPSBYtPv5ljU?=
 =?us-ascii?Q?luryPMJuVFQ7o9Y1CBMb9msDEnZd5LVX1qW//CtGWRfKA4vt0gbEoGz5ezlS?=
 =?us-ascii?Q?M5ik9h9q5tqgD9FMUxHiB4fQymFK3yy+//z4krO4KNE4t5K+iAjoOHkiHa+L?=
 =?us-ascii?Q?w8n+C0TTepR+vt2XdlUqMweZ6L0l6M1jAB2K4qMI+qIz4yw/PNUgXUY7y8xq?=
 =?us-ascii?Q?IQEvN3aldb5Xe1xk2QzuQhuV9X9d2XHf5aUdrvmA7whUiFwiuYt7zm6bCdgD?=
 =?us-ascii?Q?Dueoa6ebekMyWYmy+4vUig3DjV3xQZDhuLlNG3JlSGpr0mXaJS/2tAJSO32n?=
 =?us-ascii?Q?DeSuZzT8gdYGbhd3WWnBz9sCzgcCjxcXZkvCg+zxb66lbK6MVf7yCkKwIuUw?=
 =?us-ascii?Q?hVDu/miCLLFyJwHW5PWk/Q69ryA1Kf2HfLD4rdkO8Pc6az7uUfUf2fOrcdL+?=
 =?us-ascii?Q?ORb7kBExkg7PE+DacxySF5Zhiiw6J65dPlbX175J1zReyaVDrF7oy34J7+Zu?=
 =?us-ascii?Q?a5/mj2Jeol8OBahFSdBmbsBEhqk2nGUPW3YDuKEFsni23Cwx0QtDI2eJHcVf?=
 =?us-ascii?Q?kw1PIZ4YHamSqJkvebAQH3iUeI7KhUtDomOzkeSSBII68gjAhkQGm8kaTZn+?=
 =?us-ascii?Q?YmbuNS/gWSs4y86MSMzF3K6SiM9yZjFchVzxSrUoBx+fDdczmDi0QibDJ/HX?=
 =?us-ascii?Q?8QUg381cTbn+98u74oon2WbJlyHR4d3+QsdYCYsMUkUUGj8a7f4M58IHPMZB?=
 =?us-ascii?Q?BZYw6QIc7YRQbNrZOGVY8zoGiy12vhA62tfep/urUZh8bcOV6taP1mQN4iNN?=
 =?us-ascii?Q?3tPxgDG5vwSYYQqiRELlNY5XomFM1rAKqTjlR0Dgo4gnpv4BwFTfN4MQukhP?=
 =?us-ascii?Q?Jmi84v9o/AcPaHH6opWB4xS8Wl2hZ7lkIGtNADlvkG+4DHmkF1pnUluF0dQ2?=
 =?us-ascii?Q?lopQ3wZRVCi9BHEmHqLS0aDZODlgRWoTqTsE+ADmP2tnkV8Hqd8oP+QfNY58?=
 =?us-ascii?Q?KJ6viCbU3SHevVNgmJDkrqXZKC7LCZnPxoX+8si46j7/D4MxabYR2WiEzGZv?=
 =?us-ascii?Q?UbHWYYzHuoy+/aAAEQtuPlz3j6wRwGrdKFOGkvCKVZbQUUK2h6fqTbw9ywty?=
 =?us-ascii?Q?ScDD7IKYuBLbqv6g80yrIFjWLmx0DoQT4LUJDMgmSTbqB8O9kdG10m0ihJEy?=
 =?us-ascii?Q?2bpEshp+5f1LNQgeU2c+EiF15rxLgOwxGWDtvLSZPq70eXNBa06cWw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2vdv298tf3/lyLRbsX1638axukWI+KzC2ykbeutUdIWH6BVz/wfd9k+idWx4?=
 =?us-ascii?Q?L2K50a9vf5JycWEJsTYn6YQC6KPYnLaEQa0EiXTTC6vJeIxAjeh9A/+tNAhC?=
 =?us-ascii?Q?RnibjsmbXg7w80QDpx88GbhN4Dcd+UNTQPoDTKJLrqusyxf4uRgy1LoUO8mS?=
 =?us-ascii?Q?HrmlI0cWOP/wC5OhzOZ8N2Sq8WY2NLIfjxUpJcHXZEHRARUPznzavH+1Xuie?=
 =?us-ascii?Q?aW/NBIcZ8EIEaMuAJgBi6UnX8eeQUnEmEq2SJuur6LgeNJpvSV0lrBkz0fED?=
 =?us-ascii?Q?2bpaH5hgqWfxpN3S3s1zhNzIsz+wirMgZt1I4cjVbcXvWvELl0Xsf3Eu1nyC?=
 =?us-ascii?Q?mQ39h7lZuS87guFW4wIBc5TnB8DJog4Zx7VAMl4cdKBclXCZUIs1KmdokjIf?=
 =?us-ascii?Q?lZY5x44z0XybUQx2wwm6rSiJB9hFaTEOpYOxFqCIm6pIlxkS8GyxOE6F1PHb?=
 =?us-ascii?Q?eISMdaJU6mvRp1OMd6o/8o+cdcCcfEYR6XMCoeePWzmCgIMju98beht+00nh?=
 =?us-ascii?Q?MeOLqL5+R3bM41YF/bT0ZPnPQ1xq9G7BxWxAAgJBNkdKzXKBxVG2FMgR3btw?=
 =?us-ascii?Q?mAbSxjZCdn30zCYwRBUVCEx/SMJmovjyFLlrOzG/Qa/sKXNROf5x/E3g/2pu?=
 =?us-ascii?Q?MNt5vj491EVNkZowBAYHVVkp54YDwBvmiEWTljNV/CU3uSYTeL3r92XROatI?=
 =?us-ascii?Q?cPxk6QeUxuC1b7z6xUa2u6+tJyptKi/+6CLHCYnLIeSZN+X1Cxsw0M/tntjT?=
 =?us-ascii?Q?/4BYaHFP0fCUiMCGYkdDzzC7yrLRyKWivQ64lewUnxVY2fdInLU8JX9AOGjA?=
 =?us-ascii?Q?BHg+h+rSogOWQhFQ/oWU6nQH03s3JruL+gLE8viZeG6Da5CU4iSD44MmFFXC?=
 =?us-ascii?Q?8ttWWzIkV88PH8izdIH1kG8YQQHMdaJ0MBPXnjr0+StccpYZL3iMZeAK0mU8?=
 =?us-ascii?Q?HREj3qnXKquo/W50HucWHwbuxeLS1RUZG01JxcTQLknxyt2X9QzITlHBBckZ?=
 =?us-ascii?Q?cqqimUuIVpyET1vkiS2dMdutCy9Zjuu7SQv+Djh1XinnEGthGjIcpFkW5n1V?=
 =?us-ascii?Q?nJ7a4R84kHO645/csqDo73hG9lGwMDx1VPjs8JHJAfSZGYrt9RKkeM2WjAqg?=
 =?us-ascii?Q?lpxJrkeeyUdSKMWW1A6shwc4Dn0FaEdWKhhUBgrl1FWPmL2+6YHIZDwP3s+d?=
 =?us-ascii?Q?AlGHep6sM/scYfuY3MLeZoqrLjsBH0tMm1xTdOJU7rkJgZz/0yY2xCJ3fIEs?=
 =?us-ascii?Q?FZIbtydsZN+TI53g5eL2L2Lo8X7jMi+K5WlwMXz1r0I0NhU6czfFXgm5U5GO?=
 =?us-ascii?Q?e3tcvxYyhUW3yIVXaDUU0M8SwDQFsjWWFr/oGn6oqWd5rtQC7+GVCkJbkpgi?=
 =?us-ascii?Q?2nWS/53LhLZzX/ML5f4KquIh8avCwrJxYvg+KHbZjy2UVQb19DSUNVwM17mT?=
 =?us-ascii?Q?ZnhIAxRSxwC9aPxcqfCWfAaS5VGbWnmtAdnWg7kYKBQXGCsCUqSE0QV4d+Z/?=
 =?us-ascii?Q?0JmKYGmKQSfgCOr9TtuaKMHnjmoekVhoWG/LIGc9HsBw6RcZYfSlGZcQmdsz?=
 =?us-ascii?Q?giKUg+b206y5qJXUyjdB0mu1+AREr5WUkPEUhIu3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2df223-ed08-4312-491a-08dd945c2b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 09:29:33.6002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2NZgPO1ji/gwXEkbDH9JeGt/BdS42F1VI3Efnt+Dk/+esRJ5ut5fYMUFWhniwS3Z52Y+qO6GUQCjIlAQjQ7JCOnGy9hHQ5c6iYyvlkDOCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V3 34/42] vfio/iommufd: invariant device name
>
>cpr-transfer will use the device name as a key to find the value
>of the device descriptor in new QEMU.  However, if the descriptor
>number is specified by a command-line fd parameter, then
>vfio_device_get_name creates a name that includes the fd number.
>This causes a chicken-and-egg problem: new QEMU must know the fd
>number to construct a name to find the fd number.
>
>To fix, create an invariant name based on the id command-line
>parameter.  If id is not defined, add a CPR blocker.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/cpr.c              | 21 +++++++++++++++++++++
> hw/vfio/device.c           | 10 ++++------
> hw/vfio/iommufd.c          |  2 ++
> include/hw/vfio/vfio-cpr.h |  4 ++++
> 4 files changed, 31 insertions(+), 6 deletions(-)
>
>diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>index 6081a89..7609c62 100644
>--- a/hw/vfio/cpr.c
>+++ b/hw/vfio/cpr.c
>@@ -11,6 +11,7 @@
> #include "hw/vfio/pci.h"
> #include "hw/pci/msix.h"
> #include "hw/pci/msi.h"
>+#include "migration/blocker.h"
> #include "migration/cpr.h"
> #include "qapi/error.h"
> #include "system/runstate.h"
>@@ -184,3 +185,23 @@ const VMStateDescription vfio_cpr_pci_vmstate =3D {
>         VMSTATE_END_OF_LIST()
>     }
> };
>+
>+bool vfio_cpr_set_device_name(VFIODevice *vbasedev, Error **errp)
>+{
>+    if (vbasedev->dev->id) {
>+        vbasedev->name =3D g_strdup(vbasedev->dev->id);
>+        return true;
>+    } else {
>+        /*
>+         * Assign a name so any function printing it will not break, but =
the
>+         * fd number changes across processes, so this cannot be used as =
an
>+         * invariant name for CPR.
>+         */
>+        vbasedev->name =3D g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>+        error_setg(&vbasedev->cpr.id_blocker,
>+                   "vfio device with fd=3D%d needs an id property",
>+                   vbasedev->fd);
>+        return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker, errp,
>+                                         MIG_MODE_CPR_TRANSFER, -1) =3D=
=3D 0;
>+    }
>+}
>diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>index 9fba2c7..8e9de68 100644
>--- a/hw/vfio/device.c
>+++ b/hw/vfio/device.c
>@@ -28,6 +28,7 @@
> #include "qapi/error.h"
> #include "qemu/error-report.h"
> #include "qemu/units.h"
>+#include "migration/cpr.h"
> #include "monitor/monitor.h"
> #include "vfio-helpers.h"
>
>@@ -284,6 +285,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev,
>Error **errp)
> {
>     ERRP_GUARD();
>     struct stat st;
>+    bool ret =3D true;
>
>     if (vbasedev->fd < 0) {
>         if (stat(vbasedev->sysfsdev, &st) < 0) {
>@@ -300,16 +302,12 @@ bool vfio_device_get_name(VFIODevice *vbasedev,
>Error **errp)
>             error_setg(errp, "Use FD passing only with iommufd backend");
>             return false;
>         }
>-        /*
>-         * Give a name with fd so any function printing out vbasedev->nam=
e
>-         * will not break.
>-         */
>         if (!vbasedev->name) {
>-            vbasedev->name =3D g_strdup_printf("VFIO_FD%d", vbasedev->fd)=
;
>+            ret =3D vfio_cpr_set_device_name(vbasedev, errp);
>         }
>     }
>
>-    return true;
>+    return ret;
> }
>
> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **er=
rp)
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 8661947..ea99b8d 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -25,6 +25,7 @@
> #include "system/reset.h"
> #include "qemu/cutils.h"
> #include "qemu/chardev_open.h"
>+#include "migration/blocker.h"
> #include "pci.h"
> #include "vfio-iommufd.h"
> #include "vfio-helpers.h"
>@@ -669,6 +670,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>     iommufd_cdev_container_destroy(container);
>     vfio_address_space_put(space);
>
>+    migrate_del_blocker(&vbasedev->cpr.id_blocker);

We also need to del blocker in error path, e.g., when attach fails.

>     iommufd_cdev_unbind_and_disconnect(vbasedev);
>     close(vbasedev->fd);
> }
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index 765e334..d06d117 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -23,12 +23,14 @@ typedef struct VFIOContainerCPR {
> typedef struct VFIODeviceCPR {
>     bool reused;
>     Error *mdev_blocker;
>+    Error *id_blocker;
> } VFIODeviceCPR;
>
> struct VFIOContainer;
> struct VFIOContainerBase;
> struct VFIOGroup;
> struct VFIOPCIDevice;
>+struct VFIODevice;
>
> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>                                         Error **errp);
>@@ -59,4 +61,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vde=
v,
>const char *name,
>
> extern const VMStateDescription vfio_cpr_pci_vmstate;
>
>+bool vfio_cpr_set_device_name(struct VFIODevice *vbasedev, Error **errp);
>+
> #endif /* HW_VFIO_VFIO_CPR_H */
>--
>1.8.3.1


