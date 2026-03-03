Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE7FE67A71
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxK19-0000Sy-1t; Tue, 03 Mar 2026 02:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vxK16-0000S4-SC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:18:04 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vxK13-0001nS-Lp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772522282; x=1804058282;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6T4NcZ7cth8UX6f3iH7nnUqhEG1aHt9FxNKtJDlwWGI=;
 b=KIZTT0lcfo6ldbGwqbeWNT4Fsp2lHl2MX0mQ8j40rr1kBso0BmmdPIYe
 dXHrJF3oLL94lb3+Pk9VEhjeOBLqTh0U+4EwH2L3wMETgKl8Wt5T9Ik9z
 LPItVGOcO7pfgL8MAiBbiEk5YIRrx74mZx1r4LnTJXGeAPgMWuLm14u9O
 zm6XmHLx+ILRMckd8secxTRZKootxCedUtwp0H6X20OlHrEZOjBpCBWIV
 DMfVDnom9zVoIiw4MGVkh/1KiuJITHnJk9srK+/smH2f3BvI25IG8fkjJ
 g7cnKlcuVl3bUCuOa5m+0AOAYiMXU3NWYZYBzK+5OA2LYXg3IqLk23Nkv Q==;
X-CSE-ConnectionGUID: 5q+tVozSS4W9k850W85XDA==
X-CSE-MsgGUID: dkNl/PFNSmqt5CCSmT10GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73419751"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="73419751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 23:17:57 -0800
X-CSE-ConnectionGUID: TQpcacKRRHOi1yAJBydy6Q==
X-CSE-MsgGUID: Pd/8mMnAS72QfyNn93bGiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="218018973"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 23:17:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 23:17:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 23:17:56 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 23:17:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBxBwkbv0erLAyG474ZYuyuYwCBCiHxjOW+4Ndabpi0AVjF0Nmz6aWUDQObLrMIL+x0EmVPv9qVLeZMUxU61jhZtRLrlzXvbNLR17RrVjZrgeR8k/4Xjcc/pX1AePHOS1CWCIjthHhpP5ks5CVZ22u3ziU3QHoq1sA8BJloxHKYgu/gAyGnIWIQcf/C/NdSmXoR9u7z6GrRfrc/Q8w1WaJQWcvYS0FTiTK7AjfGUT7v4CbfXWywM4RWXua0YNqSO3H1g7+bM5KsGjEUrmjlv/XoKwT/t2kKShDP1IXO9zrUliYaZxnitDbx/yXdHlN12XzUTeeyTWcgFldRFCLrtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4PTMSa7ofs/+jn4/bp2c9DLdChZrneH6qwjnSEiiX8=;
 b=xUPkix9ofNBG5iXlDcc6HItCAMfstP67bLG1Nbptv5y4MZESa0eJq28V5ssAFsoMCf7cFwSQXaBsatnroy6kLvVnCmKVyt1wGzR4yIwdkjGSExlnqyAMXUEOmBUr8aYfoJO5KKnBqor7uqJ9TzrUJJnpGd7YQLFs92him1BfuJjjQRjvGqytjuF1c6CWIbf6XMTvJy7TfI28SrezxsAKB4yV00nAhtO4Lu4HDPilgax0IrXIrpvaDCOv3/xhnXGT7adPV9PzjGvmntNglUTUIdGEKZu5anwGPoCgwTggmb1L6UTE0NOYfISJJ13TYkjFxEXsMyeMhfM3hXJB98j27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:17:52 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 07:17:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcqDcyPiGk4Utg+kiAxNQ//lZgfbWXuNmAgALkdmCAAC5WgIAA70dg
Date: Tue, 3 Mar 2026 07:17:45 +0000
Message-ID: <CH3PR11MB71772305B6FEC68AE4B75BBFF87FA@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
 <20260227221632.827046-11-vivek.kasireddy@intel.com>
 <45aee031-3ae5-4334-a9fe-16162336f8a8@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185AB3D73F775854573939EF87EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <c16f5e30-6100-4801-ba4b-800559edbc30@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c16f5e30-6100-4801-ba4b-800559edbc30@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: ea148827-9e7c-452c-d5e2-08de78f4f7d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: mdSSvqA+7vTa2PdBHsh9At5sJfnn3lEwrVoqxpp1mBXkuqSE9DIGpLW/OvCT9y7pf+IMZrGnCWevgwCACuzLPwtZzyhV/pLAlyjEWnYXYUcyjY3PJh5x3r4IxPiWrM0aJDXC0Pd8NpvlkL+A5N/fOVfXbVCKgsbSUVqsy4yD8WRSki6TSkn/CauxokViIgWO5g8yZv31Gy4fPvmRqhMehQQrUU1+muDqERJ1+jsvG4pb83WmDm0eLwtC81BgPCrR7Ls07bnOMypvHdFxhFYIaXMp0FFlHsvQCt3KJD0gciRLaAdgVHVXKTJIEa9TncPkRHJg1S+XxgkzbvzlD1BpFFjWc80Ttcu8+dor6VmsLRcLZgRNW67daEmvyjBwK7/8tfUtMtFjB2Q9Mrr58YkTl4pwxx8U3mt1aXi7BGQOBBKkYAFJqH1gsvgnZ7cYI19N2M+vAAh29G6K4T99rlNi66PnUN642ncsrV4ji/kG680JdICRxwkphZW9dhug+P/BDSQ3mD/VyVx70ZS0z8pCKneZ+MHhAr5PdU+xvH+q+w2wembFf2syvRyCDaScgIX85WMgaw9vquyqww5PhCmYbqnhJJJKXcsY9OULekrl1EFyrmo95TsNsiNZjPE52Cua6dtprrT0MzYA9Uz05J+PWsbPKlGaF+uRq08N/W0QdcWZc7tbUCjYCDxSYWcJV0BsVvjBl3n5jRr5YbOph/DOg3GWN7QpYa+83FI+Sg6rsTDSbhbgpNsvdwC93dW19QKAdWovc7QWrlkI+KHOVjKYl+ezpd7qxlVVb1zkNl5wNgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nmRH9i+tYu8A9j4btmU0neMG01T+JYZ+scdIPueI6E5BPA1ZKj4J6tEduc?=
 =?iso-8859-1?Q?UCz6iF6YE1EDPdBLh17uJELfQ1cQRr7f7UG8IG20tcQxwMyWJLfUmSKHiD?=
 =?iso-8859-1?Q?m7RE8EUuIfhh3YpsLspHeOVOyAREd3c8MJ6RHePVk7qvhmXu5e08xwQfEQ?=
 =?iso-8859-1?Q?p3nT9LGrA7vO8sJcF8zNLy9zpT8igN8P4QDfOYyTEwGlWWP8T0TSrcKo5A?=
 =?iso-8859-1?Q?2Ei7FrzHa2XCujWXsxgHuPkBslF4caXS9uvhZiUYaTTFpAxRWX3I6L5CHq?=
 =?iso-8859-1?Q?rOUcS7GkkqgknQOJq1IeePTmtLEUuvCx4+MWXhvGaM3hE60L6apVPWmlD8?=
 =?iso-8859-1?Q?OqW3XiN/in7IykKyLgrrQlYS89ATBJgRSL0r7HzaIYhH1OEr1P9V7OjOsE?=
 =?iso-8859-1?Q?KKNnXln+Gv+Z8fo2cbVF47/f2VGv5a23ou0hYE7Uy877DhcDr9++uoAbH9?=
 =?iso-8859-1?Q?3IoiijTRKkQQB26hs3q0TmiSJ6YipRPPlOWkRDFumjEF6lnMhPTGUG5Tm4?=
 =?iso-8859-1?Q?/evQinuzDpHoOvT6aCx+UxY0PKUv2WdgiQaCIVNhoHCiU7cNxc+QlJ6pTX?=
 =?iso-8859-1?Q?cDowLwNtqcm6KH1dPsGYIRPM5MLi7hta6H0QviloZ6Q4NtHDu8Uz43qOaa?=
 =?iso-8859-1?Q?jEYrvlKZkRQ/kiMjtTG0whb9K1xFWhfOWtoyLzgDz8O3IsjNMNXvCc6QUd?=
 =?iso-8859-1?Q?q87BhnZpx6XsKZCiCQSw2jNG/WBN+d+CmVpoTGixpJH340erXFv0P+uAwH?=
 =?iso-8859-1?Q?9JzqWv9FI6zALLpE9wgO5ndLMrrGSlDuYOwXcWLpgBHHAjI0W90D3KMpgy?=
 =?iso-8859-1?Q?6yuAkTsdst+fS0xXc5QSX1eBvXWxbJjLh6f2Z+p2/mCAMzd+O/U4Glrr5I?=
 =?iso-8859-1?Q?VaOr5+fxVYMb2Yy9bFiTQ1nby3CLIElue/MXAo8CH18Br1cdYPY5dmWbCn?=
 =?iso-8859-1?Q?c7PtEy14u/TUPgG57EObJgtvtylQ0dNgw/ToXzCTErYaFA5Wk5rM0pp5dt?=
 =?iso-8859-1?Q?4fC+LzZpTA5JmfpFeBDD7FE4hzc77WCO1fnKHd+yfx77069FUyvUS60Twz?=
 =?iso-8859-1?Q?48ZbMBKN5SJzmZIC5ddj7gA9xPfmrc8j1idIGVsYKoidEd0gPMlerYinjW?=
 =?iso-8859-1?Q?Mjc2425vXS1BCYhGBlyeQN56jrvkIba9xAC0BgY7FA278jv9eYYX4kyEr0?=
 =?iso-8859-1?Q?GpbmJ/sCn4rZjkJVvZ3cZvfGRpC80NBTY+9BHb2kHzJKLAHnVxSWUgPLKI?=
 =?iso-8859-1?Q?M6wiT8AQE+gAi3oX8T3kKBM9ccnVJb2/TaK14BoAY4hpg5tc5mZQlLkavQ?=
 =?iso-8859-1?Q?cOZJ/6ks9JqnM5htpuRJKi+Ta+VM9diMnDNk7sG2fRs1VT4mKGffEPJHp6?=
 =?iso-8859-1?Q?QGgecyDBm3V8J1SIYUnpKyw/Mud6DA7sdmTZE9oNP736zlAbr5mMZzZi9s?=
 =?iso-8859-1?Q?lQtQOsc7vnmx0gbhynVmABDnIrRKptaWKqUdx1fB0AKd7utNh/AKsfObC+?=
 =?iso-8859-1?Q?BKSWf5YxO3/9qN6FCR5VaYCaNMpLiXKAVquDkV6jZzbfdZHR1uXP3zwGDw?=
 =?iso-8859-1?Q?yUSSYD0AYSLRrRNshWWVdKrh8aWaXEi/xWbT6K8u4DdY1WLd6C5YvcCWcT?=
 =?iso-8859-1?Q?rgCMxLA+Bf2qrQjLX+r4iKSnIT5jO/xA+0Z39Ks+DiNmbXUBLwlIT13UUu?=
 =?iso-8859-1?Q?iTNw8B4EU6uyJq76Vie7wjAtsEUkMu/ew+9nu4+Baxn4RSHsNYbU5+vTP3?=
 =?iso-8859-1?Q?xM+IGh9zcp78KYIEXXhAD5FzWdTHcSXKW2tlKpXYdFJ3wfQXHFLoEU5b2/?=
 =?iso-8859-1?Q?m4bucsIWsg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea148827-9e7c-452c-d5e2-08de78f4f7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 07:17:45.7632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfYL4HLyQgIVUtLvkKAICAA2UxMfc3GXEJGTQY40W7AgkqgzF171CV8uCfEKtfncTc6U+Yq/aMT88AI+nT3T+THJDCHuB/DbaDXacCYeKyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Akihiko,

> Subject: Re: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
> >> On 2026/02/28 7:13, Vivek Kasireddy wrote:
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Since, there is no effective way
> >>> to determine where the backing storage is located, we first try to
> >>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>> create a dmabuf assuming it is in VFIO device region.
> >>>
> >>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> >>> backing storage is located in a memfd or not. If it is not, we invoke
> >>> the vfio_device_create_dmabuf_fd() API which identifies the right
> >>> VFIO device and eventually creates a dmabuf fd.
> >>>
> >>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> >>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> >>> created for the dmabuf.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu-dmabuf.c | 35
> +++++++++++++++++++++++++++-
> >> ------
> >>>    1 file changed, 28 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index b2badfc1bd..533d3d601c 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -74,13 +74,21 @@ static int virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>>    static bool virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>>                                        Error **errp)
> >>>    {
> >>> +    Error *mmap_err =3D NULL;
> >>>        void *map;
> >>>
> >>>        map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res-
> >>> dmabuf_fd, 0);
> >>>        if (map =3D=3D MAP_FAILED) {
> >>> -        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>> +        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed:
> ");
> >>>            res->remapped =3D NULL;
> >>> -        return false;
> >>> +
> >>> +        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> >>> +                                     res->blob_size, errp)) {
> >>
> >> Let's call vfio_device_mmap_dmabuf() only when
> >> vfio_device_create_dmabuf_fd() is called. Hopefully it will simplify
> the
> >> logic structure.
> > The logic looks OK to me but are you suggesting that it would be
> simpler to
> > remove the call to vfio_device_mmap_dmabuf() from
> virtio_gpu_remap_dmabuf()
> > and call it where vfio_device_create_dmabuf_fd() gets called?
> >
> > Or, if we keep the call to vfio_device_mmap_dmabuf() in
> virtio_gpu_remap_dmabuf(),
> > then to implement your suggestion, I think we need a flag to identify
> dmabufs
> > that are created via VFIO so that we would call
> vfio_device_mmap_dmabuf()
> > only for these ones.
> >
> > Also, for VFIO based dmabufs, should we directly call
> vfio_device_mmap_dmabuf()
> > or is it ok if we first call mmap() and check if it works or not?
>=20
> The current logic structure looks like as follows:
> Initialize DMA-BUF
>      Create DMA-BUF
>          Create DMA-BUF, assuming it is memfd
>          If it turned out it is not memfd,
>              Create DMA-BUF, assuming it is VFIO
>      Map memory
>          Map memory, assuming it is memfd
>          If it turned out it is not memfd,
>              Map memory, assuming it is VFIO
>=20
> The suggested logic structure looks like as follows:
>=20
> Initialize DMA-BUF
>      Initialize DMA-BUF, assuming it is memfd
>          Create DMA-BUF
>          Map memory
>      If it turned out it is not memfd
>          Initialize DMA-BUF, assuming it is VFIO
>              Create DMA-BUF
>              Map memory
>=20
> See we will have less "if".
I'll try out your suggestion but I think the current logic structure is ver=
y
straight forward and readable with not so deep indentation levels and
clear separation of dmabuf creation and mmap. Your suggested logic
structure while looks elegant, IMO, might not be very intuitive when
it comes to the code.

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> +            error_report_err(mmap_err);
> >>> +            return false;
> >>> +        }
> >>> +        error_free(mmap_err);
> >>> +        mmap_err =3D NULL;
> >>>        }
> >>>        res->remapped =3D map;
> >>>        return true;
> >>> @@ -137,7 +145,7 @@ bool virtio_gpu_have_udmabuf(void)
> >>>
> >>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> *res)
> >>>    {
> >>> -    Error *local_err =3D NULL;
> >>> +    Error *local_err =3D NULL, *vfio_err =3D NULL;
> >>>        void *pdata =3D NULL;
> >>>        int ret;
> >>>
> >>> @@ -151,15 +159,28 @@ void virtio_gpu_init_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>                error_prepend(&local_err, "Cannot create dmabuf: ");
> >>>
> >>>                if (ret =3D=3D VFIO_DMABUF_CREATE_GUEST_ERROR) {
> >>> -                qemu_log_mask(LOG_GUEST_ERROR,
> >>> -                              "Cannot create dmabuf: incompatible
> memory\n");
> >>> -                error_free(local_err);
> >>> -                return;
> >>> +                ret =3D vfio_device_create_dmabuf_fd(res->iov, res-
> >iov_cnt,
> >>> +                                                   &vfio_err);
> >>> +                if (ret > 0) {
> >>> +                    error_free(local_err);
> >>> +                    local_err =3D NULL;
> >>> +                    goto out;
> >>> +                }
> >>> +
> >>> +                if (ret =3D=3D VFIO_DMABUF_CREATE_GUEST_ERROR) {
> >>> +                    qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                                  "Cannot create dmabuf: incompatibl=
e
> memory\n");
> >>> +                    error_free(vfio_err);
> >>> +                    error_free(local_err);
> >>> +                    return;
> >>> +                }
> >>> +                error_report_err(vfio_err);
> >>>                }
> >>>                error_report_err(local_err);
> >>>                return;
> >>>            }
> >>>
> >>> +out:
> >>>            res->dmabuf_fd =3D ret;
> >>>            if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
> >>>                error_report_err(local_err);
> >


