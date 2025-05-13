Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A171FC3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeQF-0004Fy-F7; Mon, 12 May 2025 21:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEeQE-0004Fm-1y
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:27:06 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEeQA-0001BS-OC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 21:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747099623; x=1778635623;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=qLz1fKSDgUpAt93Dq6T7RYCLno9v2hBOC0byGwn41F0=;
 b=dNKOmsscBDAAMZ4JYeBhfMT2Wi5oZZ5WGFO5wy82DMml7a37SbFuvemI
 hIdMtfgG3oKJB99Ifzhc1Bk4Wk7EoYXtmYkYzNKX18vSYVJmhnYXk9in/
 jDiNqhnebR9DFQCCMUoKFNOlqFNL8l65eZJ6dC2d8dTIxBbXLO0G7ceZb
 PyN6DLv+ccAWHYNDVpHg2s4MiAnx8UM2QOOxeixDfh4Qq+F4gtTIysSau
 4DFlxSyazpt/Apq9iRo5Ur95PfyP4ptYmAylrFUMcWLD0q4OQQu20rWm1
 5SWHd0h9I1+tXull4P3p5SvlNHKJXs64ZIg1CdAE5fHb8ta35xo+CUf5a Q==;
X-CSE-ConnectionGUID: iWkK3UbMRB2GHOYMJYru5A==
X-CSE-MsgGUID: ioPzjJ/TRpKg0T2aHNsIzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60321757"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; d="scan'208";a="60321757"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 18:26:59 -0700
X-CSE-ConnectionGUID: /53m9HpQRoOIOwVX2sFRmw==
X-CSE-MsgGUID: lUcBpTazQpWIpoB/ajuAHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; d="scan'208";a="138059732"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 18:26:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 18:26:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 18:26:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 18:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/Z58rosbRqNWlaTFhYtKRN/nTuLbvqo1HecL4LKVmFpE1cSKeheoX1u7zjAB4B+lXQRLS6BDyviPrQe9MD5gd1wzR7saNSGF5i3VaaXNi/m+mkIwQm0E0UnkoqvlwDGfOg4MGVIABb8xiuSytPwA5eah41CMVV69CQ3B0EJ8B0Itn/kUHHK+GQLzR1DD0c2G8yghmEH0/D6WeOheTKWd20syAEn5zUiDJRCA/IdZzEL63ffOA5JyzYZUp2O4be0r86LxtOL+b6w0HPapoeNj+lVQ2T6ODrWk7ku2Em93blSe/79goefjwqln6SrZ1mYYxg3OCYYu3RA8EiVAVegrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DqPV4JfATUwtoUf3KY6WqJtugm3Iv9R1heMJ8ifAqw=;
 b=mWOAko+sn+XQdzPh23bbrS9E41Dccn5j7Loq7aEC3jTGM8rqI2o/4GdQOJavRm9hfkepw08F3UuuJq5L7UJs2PrdmXoF01nlhvTAqAFRSY+JzjtoUGTCpM+h6z4jRVNT0wUzio/3bO+hYkIH5h0EwX2UsdwAmT8DtGsJIL1gwHX3hCCwBOL8GrV7nLwb5yUW2U5yQ0sqvsV/mWvJLQqKQVkCpYFpjB/mKHDnY80MNC1BrXBevbWf8Z8S0RghZlJREwr9mJ7qjkCp5p3X/0XE9B3KS2FjagH6QNr2FFPiTZW94pgYlyS8mXLJP/sCZ3uFTxVgYFR/ZE1a00RqKXi39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 13 May
 2025 01:26:51 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 01:26:51 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
Thread-Topic: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
Thread-Index: AQHbwkdbw2+kS8MKYEeJuKmHcqqnyLPPuxPw
Date: Tue, 13 May 2025 01:26:51 +0000
Message-ID: <PH8PR11MB6879A5858D3F4EA9F4EDB149FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-4-weifeng.liu.z@gmail.com>
In-Reply-To: <20250511073337.876650-4-weifeng.liu.z@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|PH0PR11MB4775:EE_
x-ms-office365-filtering-correlation-id: 58a7bbb0-9647-413a-d132-08dd91bd3cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f4zyal4F+VCCcQbKvXFAMw/3ko459SVwHwWLAx6BhINZrEtlcc1++tOrDjJq?=
 =?us-ascii?Q?+ftFgbb4vl9AUxAbwWOij1zzkMstyhe0RyU2ApYPjfqKiNy+Kx8omv1CxXqk?=
 =?us-ascii?Q?Xwasn4IzZHNZD1LHLVV+DsqHx3K54YM8sBhd+sp8bi/7nNpxnXWR/AhKrLf9?=
 =?us-ascii?Q?iyNk2wZlcsAu/dcdhCthiPHDL++GhkmotCyMvFcidBa4t0QQihnkQejvfD8k?=
 =?us-ascii?Q?7fV1yCBvgyNAs8rY4tzT98NyFT7FWTVBDtm8k4yQAgkJioHA5HNJPpfHZl+R?=
 =?us-ascii?Q?qSpFugvVwAlVsL2CnkIhEv9DgD61SGPa+n1oJpVZ1bjeuMAJE0/5kDse82MT?=
 =?us-ascii?Q?5ORjgv8yZdoa/GJZcllqwQnxTYD+/eEZTtKbbgo6xOk/jYMT2AKX0waTGRvq?=
 =?us-ascii?Q?CzIq/1Dn5CJ4kBtVrGZ/jzrYuJIR6bVIU4q2S3j62sljQY9eqxOv+CP6SN/5?=
 =?us-ascii?Q?sbXo+ZWOxeTcMrjP0mjn378R7voS007l1cuzEzV4YvZ2U6y4VdttBL3WCWG0?=
 =?us-ascii?Q?48qAZQREojTTKlKp4CmxiFGPJSzj0t8dRhHovwQNjdrY3xWRkOeTxnZweSv0?=
 =?us-ascii?Q?K0QYEFVTBIhG0kMVFGIUa+jIdimYiBiouWh2X+SCxq1RDuVttnm9RIh1Xnis?=
 =?us-ascii?Q?MyAB1e9P95BGvGj09j5Y3XcJtd6VPMWFEd4dv/pUqFDogp2mptT41VByQnGL?=
 =?us-ascii?Q?R9Um87vvizcPXXtJHjSaJbcg/8hW9tmPRmtXwCNpxIvwcDHxC46m3LtwCIK0?=
 =?us-ascii?Q?A5Hli95Xnft44eSCaoqV2rhBIH7AehumS/taSdxW6LIQQz3DUjK6CPffyAsY?=
 =?us-ascii?Q?nYfx1UFQ6gueZ1KNlIv9sX2mKRH247xZLfLyFN8ZPPk+1EwCEAKe2JpYuUDv?=
 =?us-ascii?Q?dUCU465o/9sdLF+HU5AgQ1yLnuusodn4pdUCYhVw1W3LiCwmVXXjL7kW09EW?=
 =?us-ascii?Q?xZWhh/iGWltAJnFc6lsA3+PrINXrs5V3Bga77P+wZTWLKq5UO08e8Bszbxw3?=
 =?us-ascii?Q?L9rhAcuV7JWrJg/10m+AUPubIHRK90CXcG78nJujVSaNUVx2FP5+Uo99etns?=
 =?us-ascii?Q?gWjHSsdonPNeCMFAfzLPZUqPyLUmqPV9F835KakEiGyibDwPgnIgjRULyn8p?=
 =?us-ascii?Q?pv/1MXjXCXJSql5PHGEYfAX36DAnPkFUG6oXnLw++zu4dZRLEbIK+7e9m6kT?=
 =?us-ascii?Q?PjKHK7PZlfe0W6XhlWIxDz2z79d9gV+ibHQD8FrogMga2OikXKAksY6TJlMQ?=
 =?us-ascii?Q?Yu4E75kiQG0Rs+lew6puhCnL2arwptWaqhB/iKsuAWE4fkOUj+XBsJkS92JT?=
 =?us-ascii?Q?PHj1kYIktRMOFuoR3m3gI9H1b7iBqh2YvRimkvshS1Jj7tQ+cpI9f9FWRVAQ?=
 =?us-ascii?Q?ujfLII/CbB3DbbnE8Uijkfew+BEmuvQk4+PM0Na1FSl/OrR+HSUcvEkjGk4R?=
 =?us-ascii?Q?drffPiunaQvP2ACVLaFc+O/38VGypa2B1B6q7rD/oWmQ65RLUfxqbg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zSannR4fGklLgGQDA2orOMkvpQscglb20Sy1WtERxTkY0+c2w7ozgqxxAmkd?=
 =?us-ascii?Q?Nw83D1JKNTgOJbyxg6LocNUaQnZ0SgfftriKuw231IBx4h1RF4h+C10akimz?=
 =?us-ascii?Q?jUFmusyE6jkaDsN+JjqONX53M3jBP5IrUimySNPRPpBpKY5RN9WTrQ3js2OD?=
 =?us-ascii?Q?yu2+sbmbe3geXZmh+9/cmaXvB3tcNh6HIOGOHeupuDdKdKhjI3qngZyFhZR7?=
 =?us-ascii?Q?bZvTFM4W/YeYlpiW9uy1NoDmAevHuddSR0jiaHiU7/yLkZ3VZTIsVaFY3Qv2?=
 =?us-ascii?Q?8GEWRVj5yXChHWL5WwQ7NecTteAZrnUMDK7Uf44PWD9elpy7ThVb+54u0Ay0?=
 =?us-ascii?Q?p+lZHeez2HGWDljMLLc60TUb9IkHjnMjua9kuWMRbWtt6LrAvuoXkm5uHur+?=
 =?us-ascii?Q?H5K2RLg1nhbMBaIc/WRr0DV0II/XJ7mC/NodSIqUSgHNfzYZeNH2QEq7P/DJ?=
 =?us-ascii?Q?cNkbEaXxgVlHDuiygPihy/So3Vf4NIvj9RgypjXLEAGn29noDks+lDLZ5dQg?=
 =?us-ascii?Q?FCXArk1zDG3pOtzDiMu7czf9TrNC6FbxPMcluvQI7FJMwNaBSLuxfvjAbl8N?=
 =?us-ascii?Q?ACYUOIQHpjS5tY9dNRogSzoZOjE3HTGFissAlzc+mxB8vHwKXxNFgnzDrot/?=
 =?us-ascii?Q?8OUVQw4frZEKas+h8SgK9Oh2Pj79VJmVoyUIPBb6XIiQ7qW5gcgPV08wl7x8?=
 =?us-ascii?Q?y2dipbNHKXMhxsnvxZdE718JU4q8jzI72jpXRckmT6M7H7l9XyfxZv2Poudp?=
 =?us-ascii?Q?/sklEavvBiPivsE7CA+JSYC5vqUwrqJKgsqvkmP72qMN4mXRsfJ6JNbWQxWP?=
 =?us-ascii?Q?LGwYejraw2FceHLfSdDWMcqFmF5OkQihOevUoBqqbxXBPJSvvPxU4Uhezd9d?=
 =?us-ascii?Q?h9JvPqrNGLy6jJlRRU7KmlRPaFQVfsHLjiVDpkYuZdQn1+Go7TSkW13+sq+e?=
 =?us-ascii?Q?Gg8pdP7kkVpEdSNlSCfoLl2nreNmhaWSIkQ1HfFzqGlmNOH2qKcQZbPlqRxT?=
 =?us-ascii?Q?yTDEiacjzXRqwaQl/ghPv154ptR50yi2iq0ypkbiFWfvKAUBR8jcmK7vu8GJ?=
 =?us-ascii?Q?I2oYWaZ00IccnR4bqzJEBN2bEp7NrYtWsvniIB1eFWsm0/bi8RP+kIwF8kVL?=
 =?us-ascii?Q?Lin2Og/IRerYGOllzuIoibcUKcT001/DMLS7qtzMNN/UHWhC7Z1sTBffHJil?=
 =?us-ascii?Q?RNuGFF4omnrnJ4a0IAQkEi7DY+0ECC62/d2NKjDNItYHt0S9bERLgkirDs2O?=
 =?us-ascii?Q?gTi3AGuSQgh22UNbeflo6rZ6ae2VGiDhk1mHlr/8kvsgzbn/Kx5AOBBSsD3j?=
 =?us-ascii?Q?1rA8T7rwpCqli8MNDJ2pQKnAwzEkr9zQ7ZYzLHc91VdSVJ5+4lp/Z0PKJTRX?=
 =?us-ascii?Q?SP+odhNIfXH6sw0NUsen0fkS5VMDWjl6jceaEi0rvkS7EbtwmctHgZpny3Ka?=
 =?us-ascii?Q?1ri0XR3Go2lntXhCC1zIeT0aNDtzSF8jTM2mGq2v2hmYlxUS3Ih5jgFZzlV7?=
 =?us-ascii?Q?uvNIEZr7niXhZADYSlNOIAYYrTiwSBvZBQ46fqXjow01bHuSRXf7dRz6YXSV?=
 =?us-ascii?Q?Nt9Ynh2T6Aq+PbAcqjGgAJCGA06f49pmi4xTMAq4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a7bbb0-9647-413a-d132-08dd91bd3cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 01:26:51.1500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wa3EzwDZUlrjaGYWr8CTcOE855aLJxBw66zYcNp4wiDxlYir3sJZi5j/BgUfcz9p0VmZ15HzYSad52tyO2STvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

Hi,

> Subject: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
>=20
> The code snippet updating scale_x/scale_y is general and will be used in =
next
> patch. Make it a function.
>=20
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> ---
>  include/ui/gtk.h |  2 ++
>  ui/gtk.c         | 30 +++++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h index
> aa3d637029..d3944046db 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -224,4 +224,6 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
>  /* gtk-clipboard.c */
>  void gd_clipboard_init(GtkDisplayState *gd);
>=20
> +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int
> +fbh);
> +
>  #endif /* UI_GTK_H */
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 8f5bb4b62e..47af49e387 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -801,6 +801,24 @@ void
> gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
> #endif  }
>=20
> +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int
> +fbh) {
> +    if (!vc) {
> +        return;
> +    }
> +
> +    if (vc->s->full_screen) {
> +        vc->gfx.scale_x =3D (double)ww / fbw;
> +        vc->gfx.scale_y =3D (double)wh / fbh;
> +    } else if (vc->s->free_scale) {
> +        double sx, sy;
> +
> +        sx =3D (double)ww / fbw;
> +        sy =3D (double)wh / fbh;
> +
> +        vc->gfx.scale_x =3D vc->gfx.scale_y =3D MIN(sx, sy);
=20
I assume you are trying to keep the w/h ratio same here in case free-scale =
=3D=3D true.
Why would we do that? We can easily stretch the host window to any directio=
n then the scale-x and scale-y
could be different any time.

> +    }
> +}
>  /**
>   * DOC: Coordinate handling.
>   *
> @@ -908,17 +926,7 @@ static gboolean gd_draw_event(GtkWidget *widget,
> cairo_t *cr, void *opaque)
>      ww_widget =3D gdk_window_get_width(gtk_widget_get_window(widget));
>      wh_widget =3D gdk_window_get_height(gtk_widget_get_window(widget));
>=20
> -    if (s->full_screen) {
> -        vc->gfx.scale_x =3D (double)ww_widget / fbw;
> -        vc->gfx.scale_y =3D (double)wh_widget / fbh;
> -    } else if (s->free_scale) {
> -        double sx, sy;
> -
> -        sx =3D (double)ww_widget / fbw;
> -        sy =3D (double)wh_widget / fbh;
> -
> -        vc->gfx.scale_x =3D vc->gfx.scale_y =3D MIN(sx, sy);
> -    }
> +    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
>=20
>      ww_surface =3D fbw * vc->gfx.scale_x;
>      wh_surface =3D fbh * vc->gfx.scale_y;
> --
> 2.49.0
>=20


