Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57597C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 00:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEde4-0003WX-42; Mon, 12 May 2025 20:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEddy-0003QW-5i
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:37:14 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEddv-0004BP-2T
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747096631; x=1778632631;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=FTAsh7CX6GwMwke3eb5hYwyj38AFyIm8SBwlNRmoINg=;
 b=MTMU3d26I4aAiYKpZLVdA8s5bOZTQQKxOjbIxyfzuTCw5/fwmE56M631
 zfJKLZzc7Qpaf3ejuzoXMT4SbZLWpnACmPQ+biyHibJOT2Yd2IeLnHcK1
 VF4l9zwLOwKVXgwWeAWuwBB0Z5Y2I0TqUVdyT0E0guFAUdNwxw1VQlNpi
 SLENNhZpo4Ep8bQUVZ3cXqHe0Xp2NeXYnvpPVBHbWQUeZanrVpGYfgue+
 emyKHiKzu+8JkdJeLZ5UZ90Ecu+TdTpIunUN6O3ZEd6WFWnvZs5TSOyH3
 9VH1QG7Vsgv7rjv8nesV2h8+ojJMwUU2lzGUTkEsnz/WdfAByzG3/8QOa g==;
X-CSE-ConnectionGUID: Tt7QTrhcT5a8BlARTOP0AA==
X-CSE-MsgGUID: mNXi3dekQf2W7woDJnm2EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59923814"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; d="scan'208";a="59923814"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 17:37:08 -0700
X-CSE-ConnectionGUID: yt1oXf70Rzerf5h5EM7Ohg==
X-CSE-MsgGUID: jPqiA5fpQxekHluGGd8oRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; d="scan'208";a="137454523"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 17:37:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 17:37:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 17:37:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 17:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEKT/mNa4xgchvxkxHvSJyzrbt+YumvMS5l4AuPqBHS5nXWsEkZwTOmCCul9ARuq0KgzBh1xbsLgNfwqeny6ettY5wbUSPrLwTNSPEbfhdpjVQ0drNpmlAal8s2nCgqnNf9DNnfRWRft9+EoOd/HWJpOARdXW0VPDyCBK4naUQv7BX3dmCEloEUpw1T5QxLFqfxoSMa3K6vK/Jr9v5/VkXxZunPSWZhAaGms05haKmrMv7t+fpsyCb1RIJrUkuiOCmbqAygJ0llzd97p+76jv0TsYkQC9ATt0bz9fanf/aIwYiVlKospjJv60dYaYmlhBIHJoeqoVfe3Lg3bgE3OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+iJEsoDOFpoXmG6zC8/+neN+12+RFQOtkPZ4jDZQpo=;
 b=Pk0jqdO3bMJfUYZuaNgx2LoDRuijUV/ChK+HtEebAXEGCaDWqmwLNvdGcdVrm4H731Dfs51q0xY4EsfMUuIijZtrs4lKzWEic/aRxFMr7/aaFkezv7VZ5C1i6Fq0ZrvrVg1YMH44v9FCr5AJ+zOVHuE3tguM06mpeB7S9Akn0xP8NHCNHjZeLnDuiKa9W/05LR5E9LwFJPo9em/oiol/6MmG6yMIC3Jeq0vCynhU0EblZr9UpkaofTNzQXCwVRFlaSJm9JPRO8Xfws6I0uko5OWs9v/UnOMCV8cxAj0xjSn9oltRt7yc7a9+oRJtgKXdG+xxQ+ahBA7QrbRsvHNBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA4PR11MB8941.namprd11.prod.outlook.com (2603:10b6:208:55d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 00:37:03 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 00:37:03 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 8/9] ui/gtk-gl-area: Render guest content with padding in
 fixed-scale mode
Thread-Topic: [PATCH 8/9] ui/gtk-gl-area: Render guest content with padding in
 fixed-scale mode
Thread-Index: AQHbwk5lM93Dhl6s1k6lusnWxuOKqrPPuAtA
Date: Tue, 13 May 2025 00:37:03 +0000
Message-ID: <PH8PR11MB6879607C14D7E5BB7FCDAAD1FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-9-weifeng.liu.z@gmail.com>
In-Reply-To: <20250511073337.876650-9-weifeng.liu.z@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|IA4PR11MB8941:EE_
x-ms-office365-filtering-correlation-id: 07e246dd-b1b1-406e-2f6b-08dd91b6482c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+NGOK2lnBJ5plSUll6d7cO016wkfhmWNosq4ZiCzf244t5cdjdJV86uaLPnI?=
 =?us-ascii?Q?p4tHhaU8XzObU5sd3g13ZjJO/WZXXUgnW70A5FlEdWm/p5Pqhh2ve0rBSqtP?=
 =?us-ascii?Q?GT8ew9DL3JxL5olMXPU1U9dgDgM/ZwOEAxTbVc68v7NvOKhcbj8n+aF0dEjc?=
 =?us-ascii?Q?TjPNG0FxyBlOxrAZDVBQCNZobarH5XGVGUGi1wvDC9jk8s93inPuzTnF0481?=
 =?us-ascii?Q?h6eBXJ+itZp/h7LuriwTrZ/YQR3uH2cUNrwvlX/Tp4pv34acZ6wyWs9NuMog?=
 =?us-ascii?Q?T5b1K+W/apZ/JwUgrDEClo71EEhRHcus0E43oqblXpGG+PMsjICcT1mltQxl?=
 =?us-ascii?Q?7819tzuIiurKdzG3PZs6beJt90zpzTpwkyYXCpBzjA5QpElAXFR2AGZ5P1bp?=
 =?us-ascii?Q?Q+zm40s8eqegbl5/QbIzebj5AiE61E91g9hfLo+y+pSWdLyYrWzZFiUUPvcn?=
 =?us-ascii?Q?9lubLjg8YpAUze0Y70qzrRfyAU6vyshrpS2MxwwWje3XdX5P5oS/LCQ186aV?=
 =?us-ascii?Q?M0viM35GiW3rPOb2t9dkyFjVpJzlbARmk05DKDD7nY0yteGoibw6cNp+NNXT?=
 =?us-ascii?Q?tlHynakSUIulIyAnOVga6w5aKNsNeof6HXkqV+6jV2UCy7gJtEUzmtJNQ+vC?=
 =?us-ascii?Q?KdaduADFg2R1B99rwNy45IlkxjBQaYnXDlINBCxub9eRyiSu8liJ6rrZR10W?=
 =?us-ascii?Q?nOH2V5Qw9IaRcQ08wyOdMAS1DIxL1T/aq76p6eC2goUUCA8XDE6SM1gBxNob?=
 =?us-ascii?Q?Xu1bXSyPGm67TvumLlYTaRcRm4fYaOYLTwlSk5ZbDhE5Am8cwyKmQ2jgZNVy?=
 =?us-ascii?Q?pltoA20uNuxdVKprK6nCQt2oKDjZLeDeFPt/kUiTKiJKVEhgDIU2dw4bmdm0?=
 =?us-ascii?Q?Z4xQqPmuApLardlhEoJd51sK9aKTW2vhYikRJolzPpYapTZArfa7Tx9o6m6r?=
 =?us-ascii?Q?VdTO0cRgMiRZxThpgBCR5rH1yB6X4PQK5uKvtxyfzws0m+q2AbwoBGri2QdX?=
 =?us-ascii?Q?Vup877r5o0FeFC6aadMXb55D1bOsp0tOWoUWRlvXWp5gGwRgcbkScJKyJPeR?=
 =?us-ascii?Q?fwUK5YeZ5Cg7P5uOUNdTlNf5hk0qSV69JKfWS8YOhWeu9XjuZ+zxGqu1rgAZ?=
 =?us-ascii?Q?Y4Urho67H6rT0QjKDuVMYL42rYC6rgJBJRV5bHmYGkXFnWY4DwvQOhuHf9UD?=
 =?us-ascii?Q?UrFdSUSZNxFxef6tMCbHhCpXPII3tYyyzwd+Bo/t4657l9GC1/I+8Va207eW?=
 =?us-ascii?Q?8VvSkvR7P377DRQClhUbOd/luhqrTo/2njjM90V6sfWYvOSqRRBc/21t2SR5?=
 =?us-ascii?Q?WeLu3ZGnMjXMsIl5YWaOA2xaVHPT+Jt4YpqsyTeWbi52qz5Pi6uP5HDioUGK?=
 =?us-ascii?Q?ZEpGkjtFQrR3HtxXdddksLYpevETOj9U7muKrvtnSf4huQmFPdxuDSmVgwGL?=
 =?us-ascii?Q?bJSI+ooKzJO04dXdXyjCcm1od/Z6ueLYhARbeYAvIR4qzLvjZ1f+iONh80TN?=
 =?us-ascii?Q?4S0GZHkIKqKH8KY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TRnS2DnpDfPa8djmpLCZpBsX4QC4lmOpZJkzOZf0Gg8lKlzxBdBDYK7/keXG?=
 =?us-ascii?Q?LUWLMBXEE8K9zdKKhKgnLP7qBenP/JXXEBSU9gS3wLBydkX2kKDz58dabwh2?=
 =?us-ascii?Q?ijUVxDRaIaefjEK5/jy7dmIkk49jDRyP1cR09n3I2+Mh2RAZvg8zVFN6QGId?=
 =?us-ascii?Q?EHNCHHS+MKl8rAnWg8Ochm+rX51hzByZEe1w8LbakmTRFxM3/RDfhq7qk1Iu?=
 =?us-ascii?Q?pqXgwr8O4u33eHEiG1F+GI+q0myC2C7EkPVglQhMukcZg308ok8bQeiUJKT6?=
 =?us-ascii?Q?t7auR53xJlvbexzxw+RUw1Bb86yHUTh1pEU7Euvhe+3hYP/wzC1OInUfBTU1?=
 =?us-ascii?Q?Uu6kLinZ2axDNLbGEB/X1Z8G5fYIzNWKeaPxsZ9bPkLN/reoTtZ2ivaJepz0?=
 =?us-ascii?Q?9grNa/VTLib1MBlFwhsDCAGnsG85F6Tr8IEgnguEfhqjzHahvPQTEhoLFj8y?=
 =?us-ascii?Q?KhR8z5w+yg25WaTbKul1C++95ma/VvDh8YSy9RDF06q8FmRwJGo9ksoRoHsK?=
 =?us-ascii?Q?5ldiKeGXrn7u2nC/6MpaUwnBBMpdpJyuoWVyhpETMi+OE128mpFxBY8otHy9?=
 =?us-ascii?Q?WOOPN7G0XULTk1P7+tZsjMJpyCsok4fIpRBqxlDx2csmQgxP4MpNtneqgIWT?=
 =?us-ascii?Q?FlXmZPvhsm8bce2ODJVeUfe6i/9U61hgqg0yJcUcPomYkzU3SKxELxI+qaZm?=
 =?us-ascii?Q?VmbZeBt0zV80fiy25MwJ3kP7moM7Dopke56Nkn4o/WqZang85XGyAP+7mjcm?=
 =?us-ascii?Q?UYbCEM3AxeAukmQXjizVBL2uVMqW3QXzwUJvcpsib+xbTkuWqHEUM7RLVrBW?=
 =?us-ascii?Q?9305ccd3C1/7bZqNILXbXmxd6Z2LSfPJ1p3PzhvvFI9SLsaPCkuV8hzKQAGr?=
 =?us-ascii?Q?0pXJpksyXW/umRdMnT4xbINZ7MhywWK7YiGMkmiOBDK6TyrMZaFwaDb5+Qmv?=
 =?us-ascii?Q?m++QfqGXEWgZYU4v4ng4t2GEYBgGo++BS0Co90gvXC5tNpasmFAVw2eCqXDv?=
 =?us-ascii?Q?je3Xw59CwG128FuC0CCHSZIUhG5d+P9MmxjEOVc6yF0dNcQLr7wktjoW4Anz?=
 =?us-ascii?Q?O689jXsZqBWcrvx58XUuiP7WHM+zFWi4izWPn0KuQqkPPRyhHyDcWzsO/pBt?=
 =?us-ascii?Q?IMEXmBV9bZzYs/xlWyrLcUwruQzHpGgapJS1UFlfBQSOgyUNmfxOtzkXhKiT?=
 =?us-ascii?Q?X9BbmZgBdr5PJzZ56yoEDdnas26cO91W888IvpvF0QFTIzpoBsEHEoa80N5l?=
 =?us-ascii?Q?01i38LWWinhDY/dtiEzK9c+VvY7ebFQbR1CBB3iDwfJZt+ylXVIyjmhiSQih?=
 =?us-ascii?Q?VU4OpgefrJdloDNADnN3YLxvU+zexbYUCZw8UkcKNX6ijdlRUTM7eUpiM8ty?=
 =?us-ascii?Q?jl/H0cDRPAI46EsdU7ggaoxaeggSzBQ/agDwYtVggB4k42WkedsETJBXWmQn?=
 =?us-ascii?Q?4lcHFoNIF1Lepi+mH4gjxjMYqVEzGuEfnEnfn/1ySo1YVy2CFc6wnvicQUIs?=
 =?us-ascii?Q?mnHaQjOP5fHA9x5dJ0o148glVw+D4Bt0KBacJHKzuMlmRg9ZlsXwWBEISLH0?=
 =?us-ascii?Q?zEX9o4zZs7yDjXJrSVrYIu0nBXqJZbkebdj9Ix8g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e246dd-b1b1-406e-2f6b-08dd91b6482c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 00:37:03.7277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByoqP7sFvakn8cN7IpsOBuS95dcV7XZiqBFg6jYSXcmVTu+bhQoMu93FUIkRTxsGS8hcT06vECg4adjWmCeKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8941
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=dongwon.kim@intel.com;
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

> Subject: [PATCH 8/9] ui/gtk-gl-area: Render guest content with padding in
> fixed-scale mode
>=20
> In fixed-scale mode (zoom-to-fit=3Dfalse), we expect that scale should no=
t
> change, meaning that if window size is larger than guest surface, padding=
 is

# @zoom-to-fit: Zoom guest display to fit into the host window.  When
#     turned off the host window will be resized instead.  In case the
#     display device can notify the guest on window resizes
#     (virtio-gpu) this will default to "on", assuming the guest will
#     resize the display to match the window size then.  Otherwise it
#     defaults to "off".  (Since 3.1)

Current definition says the host window should be resized to fit the
size of the guest surface instead. Wouldn't padding accommodate this?=20

> supposed to be added to preserve the scale. However, in OpenGL mode
> (gl=3Don), guest surface is always painted to the whole canvas without an=
y
> padding. This change tries to fix this bug by adding appropriate padding
> when drawing surfaces.
>=20
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> ---
>  ui/gtk-gl-area.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c index db93cd6204..8151cc=
413c
> 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -44,7 +44,9 @@ void gd_gl_area_draw(VirtualConsole *vc)  #endif
>      int pw, ph, gs, y1, y2;
>      int ww, wh;
> +    int ww_surface, wh_surface;
>      int fbw, fbh;
> +    int wx_offset, wy_offset;
>=20
>      if (!vc->gfx.gls) {
>          return;
> @@ -61,6 +63,17 @@ void gd_gl_area_draw(VirtualConsole *vc)
>=20
>      gd_update_scale(vc, ww, wh, fbw, fbh);
>=20
> +    ww_surface =3D fbw * vc->gfx.scale_x;
> +    wh_surface =3D fbh * vc->gfx.scale_y;
> +
> +    wx_offset =3D wy_offset =3D 0;
> +    if (ww > ww_surface) {
> +        wx_offset =3D (ww - ww_surface) / 2;
> +    }
> +    if (wh > wh_surface) {
> +        wy_offset =3D (wh - wh_surface) / 2;
> +    }
> +
>      if (vc->gfx.scanout_mode) {
>          if (!vc->gfx.guest_fb.framebuffer) {
>              return;
> @@ -79,11 +92,29 @@ void gd_gl_area_draw(VirtualConsole *vc)
>          glBindFramebuffer(GL_READ_FRAMEBUFFER, vc-
> >gfx.guest_fb.framebuffer);
>          /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
>=20
> +        if (wx_offset > 0) {
> +            glEnable(GL_SCISSOR_TEST);
> +            glScissor(0, 0, wx_offset * gs, wh * gs);
> +            glClear(GL_COLOR_BUFFER_BIT);
> +            glScissor((ww - wx_offset) * gs, 0, wx_offset * gs, wh * gs)=
;
> +            glClear(GL_COLOR_BUFFER_BIT);
> +            glDisable(GL_SCISSOR_TEST);
> +        }
> +        if (wy_offset > 0) {
> +            glEnable(GL_SCISSOR_TEST);
> +            glScissor(0, 0, ww * gs, wy_offset * gs);
> +            glClear(GL_COLOR_BUFFER_BIT);
> +            glScissor(0, (wh - wy_offset) * gs, ww * gs, wy_offset * gs)=
;
> +            glClear(GL_COLOR_BUFFER_BIT);
> +            glDisable(GL_SCISSOR_TEST);
> +        }
> +
>          glViewport(0, 0, pw, ph);
>          y1 =3D vc->gfx.y0_top ? 0 : vc->gfx.h;
>          y2 =3D vc->gfx.y0_top ? vc->gfx.h : 0;
>          glBlitFramebuffer(0, y1, vc->gfx.w, y2,
> -                          0, 0, pw, ph,
> +                          wx_offset * gs, wy_offset * gs,
> +                          (ww - wx_offset) * gs, (wh - wy_offset) * gs,
>                            GL_COLOR_BUFFER_BIT, GL_NEAREST);  #ifdef CONF=
IG_GBM
>          if (dmabuf) {
> --
> 2.49.0
>=20

Thanks

