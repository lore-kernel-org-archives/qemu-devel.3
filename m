Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FD2D2E9C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 09:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAQOu-00020T-HC; Mon, 11 Nov 2024 04:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1tAQOT-0001oN-IO
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:07:33 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1tAQOR-0006Ih-Do
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731316051; x=1762852051;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GcL4TJbUsD6E/CMIOHjSyj143xGLIPrH+jjUEubzqi4=;
 b=MH2U8n4BTkL8Igo3mgq/yt4BWGjaM0AluY2MEejXi8esChQvpBBBwZ/Z
 cJ03f+kFYmTGtSeelFOko4Qxt/2m6ms4NjCTFsgkOc/JOqr17mI8ZqMG6
 vZP01HFAoeUUgpMlBdxjTliv2AqICOm3RYT+qdMHA40AnC3sVOQzr/J2z
 uHMrXj1yD7pkYmCViBBlbWj+XJ9CtL0DYOHi1dnfeYLD07NCV3ZMwU0F+
 rdF8qUm0uuLAtiGoNR2hfdBhRhSLJZA8f2jacF4pxbltMG707NmXqZCzL
 WKfcIZw/mQ2ePMkli2jMC+l1bHrkzsAn/Wlh0WcTaQ2+4HWTSQkKE+AhW A==;
X-CSE-ConnectionGUID: FJNoiQnfSe+BlLHkcHGuiA==
X-CSE-MsgGUID: 0IFr6nhVRAyNjfznJQo7Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41744314"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="41744314"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 01:07:27 -0800
X-CSE-ConnectionGUID: bXro2cFdRjqZaRizIVb8AA==
X-CSE-MsgGUID: gDdS7twuTXGALWhAyHHIZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="117740400"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Nov 2024 01:07:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 01:07:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 01:07:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 01:07:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDLenKucKJDP+iXh7se1nrOOaQtmRiXzW1UFNEoG/bvBRqoLLLzQzZhhBGlW9ezjtPMWv4FYGZ3EK8JRI7ZbjgVsPsPLxjhVXJ5Bw8gTmciNKJv+KXFVVPDsONZpSk8BKSHfd0tTvuZOhe/pt8KsGMpWw3nw1WZvrLMljZRFsl8gsDahkXnqTEzfuBhJGI6/l94x0SFHTW4zRMcBFRw+GVdOuhRi3ZE+jXn+cFdE0gTMN8VRXLcq8FVgq0GE7xLOYTbwENzTmDa4o0RaQq+qARLtm5WOf5/QpCZrmZ9/BLoQC6VPQxRAoZwm5Q16BJDWlwX/DUk3/jrrFJ51GS8JTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9Gq5vldu7UqL7MCDSeEkXqEsNZW5rp4B69cnCQe1Rk=;
 b=uvT0vwjDh9ZIZ+I2gP9vBeiZWqbZ3ZDRZ5UBfWYaZm2KJ6jcHrxdIOmeKhoOAR9V2EM6T70acSg/i+YIgPNdjpDQTSQpV90pcR46judlxhuYCUBzTtzg+mdmepGzC/2VeoRQKVogY1ggv2dHk90cDwGmQnT/MrKdrf+cGpX1mEbJbK64voz8cGnXsvY0/nbAEeea3PJTDvrjE4Mt8dqFsVJilqU5u5KCYQtpSCRXSx6BClHGmrieYsxcj3H/OzOSvoyjQ3XRIDnJahghuXulyuhtkfSEzAP3Pth/mL2bZ+GjOUwRdWMmaCA0gAApemcbpH1id3CIDMEPo7koaXH3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 09:07:23 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%3]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 09:07:23 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Hyman Huang <yong.huang@smartx.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "David
 Hildenbrand" <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
Thread-Topic: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
Thread-Index: AQHbMmRAPMPsb8CplUKdBW2tyl1PwbKxootg
Date: Mon, 11 Nov 2024 09:07:23 +0000
Message-ID: <DS0PR11MB6373166B09A9A0E9A0646508DC582@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
In-Reply-To: <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|LV8PR11MB8748:EE_
x-ms-office365-filtering-correlation-id: 47a03f9a-e333-4279-3f46-08dd02304137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?l7OjbbV4sC1ZKVWZXVHXOxyFOpeWgEWS48tnM+hgrb+EjH7xtDuyvfJD15HI?=
 =?us-ascii?Q?Wjus9vnBY1YTYrjD+wBXjvxab3p7a4v5UBqkdlMQ9ETfKITJEweFC+YeOXub?=
 =?us-ascii?Q?vt49gCqvvIihWZqI5i17B+mnv6Im9RfdRDKDjKovT1HeCdLpqiK2H8qIUhFE?=
 =?us-ascii?Q?NBHK1iTBAf/YNdyQVBTlKhqFQGyN+PP6mHUS1839hLDyT/YnDotQHXWFDCYl?=
 =?us-ascii?Q?bU++TizkdOtS7MwgdrlPCmoCQ/VxQR+yoQLZ4lxoJITTayIqv3ese13F8xyp?=
 =?us-ascii?Q?j3k9Aj/UBL3TsDMVwxGWrnbqnl66mw6kjQjY5yYvSTpmTHlGxbel2O2NHPBI?=
 =?us-ascii?Q?vs1dZ4B0a2ynz/PsjgZSgxP+AqQZ1hrEZJe3Uxxp5kZeeq7KkCVm7nxCEsIu?=
 =?us-ascii?Q?NC8sKUE6fnQDk9SQQhCAd4YmJryTOk7FHvyXy9QuwxxssFFR4aOFOIAkOi3o?=
 =?us-ascii?Q?66rzLk8DE7whvTcmlpB2FU/QFSXHDLhKfiXdK0cOsEjCexaHnSUvbXketnNa?=
 =?us-ascii?Q?+hzjLAYBfbcqiYsGelmKYJiwbr9qaqGzz5GakZydjNzj8w2VVstyBqX6xRmU?=
 =?us-ascii?Q?fiOT5Iq38ciFhMf8j/kpQlh2wVIQQ48RyB+TOeH/gxwxm7DjrpPIvDXPHzZL?=
 =?us-ascii?Q?tscbL34dl5EHVVAWEDcgFA3a6DgXfW3kEowv9jsOrQqhOYMI4k0rfzdkNRjt?=
 =?us-ascii?Q?YV+ejUtXR/ki3sXK4PujxkYJ07ev213k99AbZW6jfllY/AUOeCUlmxLOTfmn?=
 =?us-ascii?Q?QfGaLYRQjye2zzhwmomSDL/QIW6olVXe4qy9XE+cjpAnAsEvPuHZIip7S4HX?=
 =?us-ascii?Q?vX+LsDzRSrCVHJnU4xlk1ypDJ72B1q82L16nWqLH7K8Q84Gsns+7hKENCQhG?=
 =?us-ascii?Q?ofkw+xIlasRx25vKf5sUl0NTzH/0P9XrJ+8TzKSCr4433a5vOw2GQgwSCoI0?=
 =?us-ascii?Q?s5BMWAYx/s0+TNXXIULI6rIGpxfWX6hpsj9plSBdCkGJEQZynXDW4oxvOd7f?=
 =?us-ascii?Q?ZvLuLM0Gvi+j/syN4+H60g+ztjcLFXhSIRWqFPfvSfpX9we8sZaYT/CyaekR?=
 =?us-ascii?Q?mi5/Mqmaaicjb9NLa7ecpWBqjca6tD6pV660I7EsaI2N3Z6AJdFO5NpHcd6K?=
 =?us-ascii?Q?HPpYoz2LmZb3mEz8L0n2gDHTDG7Mem/4vQqI1QCrPxTUHMzrdLowfyzkCzCi?=
 =?us-ascii?Q?o2oppiuDrup9GBSF4CAaiiS28b38m7qHcClq1/5vA1onFrrKkK72x3fAOLk5?=
 =?us-ascii?Q?dqaHvLch6MIj4c4K5CikOvcfyyK2k01OIrjYTb+hK/FPmN0YlJrrIPUX5kHP?=
 =?us-ascii?Q?eEjbtdJa7qGnoTOuiBjGsmTp8KwBHA1s732F77OdefFXL1kVlVlKMrtwqwvD?=
 =?us-ascii?Q?Bo7xRb0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WHQ8y5srNKT8aWfCBh9hBqN4lTkiFf5rUBoVT8CCnWpPPlh1xA2V9Jxt4Jet?=
 =?us-ascii?Q?o16980Gv88beWzg0rFeZb7HqggdSgV6hIWoXLrVIn94GD4L5IznbkgF211ur?=
 =?us-ascii?Q?tHjITDivOiZB4BjsTKKDfnM3dTnrYiG39aSiey0wefQyQi8wYAJT0bAztlQl?=
 =?us-ascii?Q?GRn5ECh1bvx8ug/CgMGCiYhs0orEYIewwM71ktUAcylexwLCyuu+w+mX+NCx?=
 =?us-ascii?Q?8ZI2brIKBTVfSxm2stvK3LVXI2e+AG7vAcHklpYu4l5e7tt+JIR0jQOynhL/?=
 =?us-ascii?Q?dWFoZJUXZdLAni21gY5YpJ7oJ3OXKqPF3EpgM4sfLLsIcG19N3AmM3bTwlYB?=
 =?us-ascii?Q?X7pspIBPaVrjJfViIm3vq7MXv8B+e6zwhFAVaIwLhyol8bGEGANT0vV4FyCA?=
 =?us-ascii?Q?elrZavbGntFRrbsrJNQn6ZKw9q4YsMDLWhuH1WmRaf74FlW56F5O8uAOm7vX?=
 =?us-ascii?Q?uIQyH4m/suUHOf4/wSKbT5fIpD9MF/X7U7588PSkPjVZ+W6YT5+26xgV6806?=
 =?us-ascii?Q?ZleyYwaXoIE61tX3rDKnRsrHfz3VOVKwE4CKUjB35+4+/1ER9+uFMQH3KkBK?=
 =?us-ascii?Q?OkUlTGEarsF190ix+LngGtcO93yFUQGSUmDPSh0X32d/dyzccOyhtPNqaAUp?=
 =?us-ascii?Q?HN4HSlJtogCHV0TIKAGCnFRlnvJCKDUZDes85KqrifnOTkaLf8V9CyO2QFA4?=
 =?us-ascii?Q?xGia5si16f/IjJkkUwRs4bPKfyyXL6e5/E+YsWZ7fUx50mQJ34ep9VrJNnXY?=
 =?us-ascii?Q?KYH7ivP11ZDZ0Lv8pYFxNtu6tGibPAblKW2g21scORIuOJviM5H/ZhEoIKWm?=
 =?us-ascii?Q?TNS40OC/bNB1opA7qNx3Jtzs1aQNTCav1A1nRLf2RyaRk0CInUowH/9xqQy8?=
 =?us-ascii?Q?Bx4eIaQce3P+mGmYyBboA+jwpW0qmLsuz00biNXYHr7EEpIAxoWn5jqG/iFp?=
 =?us-ascii?Q?yZdfb06AzmFlATGepYwR5z8qn99KH3TFV+GNfUiKTrdtGscUBri1+39o6I5A?=
 =?us-ascii?Q?J1l/vpbGywjrsjliXMZOgqEbhATLZUvCBvoXSrrfzEfxgDWS0Vp8Lt57VH3y?=
 =?us-ascii?Q?x9b435qCg8xu5KqdTujnO/Yu54IZdo8TadxIG5BeZ00+duCqSbxeMPrax9bl?=
 =?us-ascii?Q?pH22vKSADjSkihSKGTFcAdp2yq5KhasDVjZ6qQe4Su23ft1W+tJfkKak7nLj?=
 =?us-ascii?Q?5UbrAcGJwkFT11n9r0PhM36t91pBlIqrPjA/u3IYsPPIMqL+f7NpIobEBK8T?=
 =?us-ascii?Q?7/dc86klfPxyT1NGI08pNOUpoxZOiRHndvuVv9qaionxxhBGLaRQBAV8TTGB?=
 =?us-ascii?Q?gyUUFeeMEE6SIpRlmTyh6dRzsxlWf6ZuGQ9SYgXXYLHusYL91cFj+tTQ5M3D?=
 =?us-ascii?Q?k2NlRtiHKum4D5jX0WIMuskscwk7xFBX+u+odqCcavfq6Y0Q2XMmChh+JBiP?=
 =?us-ascii?Q?JgScyHCUnobW+4ZueuTMJU3w1z1faDtPLB3RiXiMMYyud7cpbze0dimrmvgb?=
 =?us-ascii?Q?6wrTdEMICO0lgyn+TjOKr4J540u49hWGLPGuOJTMmz6/ljD4bzpM7AVhAq/y?=
 =?us-ascii?Q?yWQXss1Iqr6f1i5liVLt882IjR3X6UWxIfvOzich?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a03f9a-e333-4279-3f46-08dd02304137
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 09:07:23.2201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIYuJePl9nNJXyZBYgmIdc3kjgjahzxlJvW81Gy85bL7o+pWlv78xqziWRfRR7TKkdj8qkbVY4s8HBPpcezmIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

On Saturday, November 9, 2024 1:00 PM, Hyman Huang wrote:
> The first iteration's RAMBlock dirty sync can be omitted because QEMU
> always initializes the RAMBlock's bmap to all 1s by default.
>=20
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/cpu-throttle.c |  2 +-
>  migration/ram.c          | 11 ++++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c index
> 5179019e33..674dc2004e 100644
> --- a/migration/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void
> *opaque)
>       * effect on guest performance, therefore omit it to avoid
>       * paying extra for the sync penalty.
>       */
> -    if (sync_cnt <=3D 1) {
> +    if (!sync_cnt) {
>          goto end;
>      }
>=20
> diff --git a/migration/ram.c b/migration/ram.c index
> 05ff9eb328..571dba10b7 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)  {
>      MigrationState *ms =3D migrate_get_current();
>      RAMBlock *block;
> -    unsigned long pages;
> +    unsigned long pages, clear_bmap_pages;
>      uint8_t shift;
>=20
>      /* Skip setting bitmap if there is no RAM */ @@ -2736,6 +2736,7 @@
> static void ram_list_init_bitmaps(void)
>=20
>          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              pages =3D block->max_length >> TARGET_PAGE_BITS;
> +            clear_bmap_pages =3D clear_bmap_size(pages, shift);
>              /*
>               * The initial dirty bitmap for migration must be set with a=
ll
>               * ones to make sure we'll migrate every guest RAM page to @=
@ -
> 2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
>                  block->file_bmap =3D bitmap_new(pages);
>              }
>              block->clear_bmap_shift =3D shift;
> -            block->clear_bmap =3D bitmap_new(clear_bmap_size(pages, shif=
t));
> +            block->clear_bmap =3D bitmap_new(clear_bmap_pages);
> +            /*
> +             * Set clear_bmap to 1 unconditionally, as we always set bma=
p
> +             * to all 1s by default.
> +             */
> +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
>          }
>      }
>  }
> @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs, Error
> **errp)
>              if (!ret) {
>                  goto out_unlock;
>              }
> -            migration_bitmap_sync_precopy(false);

Would this affect the statistics collected in migration_bitmap_sync_precopy=
(),
e.g. rs->migration_dirty_pages?

