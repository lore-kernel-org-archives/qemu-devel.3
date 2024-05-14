Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E9C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lgd-0006AJ-2k; Tue, 14 May 2024 02:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s6lga-00068H-RG
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:30:53 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s6lgV-00053D-O0
 for qemu-devel@nongnu.org; Tue, 14 May 2024 02:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715668249; x=1747204249;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/B2iiNT5J4Jxbgbvzsch7OqMqYpjHl6qEmFaPzIrW9I=;
 b=GYVVrmVnLHcYYgjlghj01p4hlXZb9Pyb3dSBl0ifq0JSmocm2I9EVqY5
 6ncTZ5Hn4g7dQMnAUsb3+YjmcpnOhZz/T0B3rcbqbDDm9BUckaRXd6IuK
 cbdoWnEqQe0Oq502nTCpOf7aS6EeoMvoJcdCiWllz7MVsXwUjGpjdY/fr
 Vb1fBi/HSAFqBy4URhgK3JT0mA5J3W+PdQN69fHdRDNJ9mTLGNp0WYF7p
 ZBuGpf7PWIMhHz3G2cwsrV6MvxrZJqcOb+HNfeYWEKsQPMdrUxmKGGBdq
 lUxSUIYsm/x6mkFODTjRl2XAyCRfzY8m7Xd99EEbyfpcSPzmPxkVovEyI g==;
X-CSE-ConnectionGUID: g90bytLPTbK6tyfxYYPD7A==
X-CSE-MsgGUID: bmmx8bV8TJWoKqbivcGMkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="22232793"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="22232793"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 23:30:41 -0700
X-CSE-ConnectionGUID: JxrIbReTRgSUMtwDwIBfpw==
X-CSE-MsgGUID: NLrciVACSF6K+8S/RIDFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="35030135"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 May 2024 23:30:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 23:30:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 23:30:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 23:30:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 23:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy2bmnULEMoRIdtpaDeepK0QqqFTKLQ9rAcDrOORkTZLklRF/Kw9HR6k89UQEk4unwN3gNHLAQaG20DR2rNaE8LNK4tCdoODK0OechJ49p9EyHSCgUx9deh4oariAdXBebjHtV6rsjXVfVf7Ics9TdEmHJSXW2Ln4yiN81C7facp7PSc2tJa/NBowT8REoeRPybYSLko7kLXVdlAX9S6ybpdRIgnVrXC6PpP95Gf90XKwgWKSdVe2zGO7y5wUJ5147ACoNs5ZKliXwjnykhfryV3Jc7uiKzAFNyWt6GpI4TT+Su8q0hcutdXMy0TKVfaAA2hb0dX85Y0Rupd9Mc/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdxF1OT4tCEFdsh5cvX/PoS1qGxCwiy5PF9EFv6DbDM=;
 b=RzXfQpavrn3jPE9GRl4/M1D+jKdK1KGghCgyVJOQZixwBX33GFfVLeGYWXkrlefQZVsPskUJAXZ9qxoYrDXas6KYmCfl9sp9uoqdVzKYpKbBxi6TCv8wk5EHfFqUKZyyqGAauiWVxXdhvz8XjUkcQ3QyhN3SeWL17lll3sJwvDHUH/jMIJv/NwJFBohydcqvwRvamr/sb8WgXmiYgRkVuLgm79X9CSxYQXYr0a/V/d/msE84yNMx11gIFG+lMnjbo4URShdQdNag9AucGVRqopH84nN9bvSaos0TpIOoeOgozm89txrt9fgl58B2nhwGLY7oEGd7Qon61di/IeQa6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:30:37 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 06:30:37 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v6 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Topic: [PATCH v6 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Index: AQHan5HVP8olQmturE6meoKKc24AObGVUR6AgACpysA=
Date: Tue, 14 May 2024 06:30:37 +0000
Message-ID: <PH7PR11MB594145F081617DC668B59343A3E32@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-7-yuan1.liu@intel.com> <87ikzhg2xq.fsf@suse.de>
In-Reply-To: <87ikzhg2xq.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|MW3PR11MB4538:EE_
x-ms-office365-filtering-correlation-id: 21c7d554-ecc4-4d8a-70a8-08dc73df5e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?BOH3T5/ADGwo1elCR8+BK0dHwKcoIy1sCejT20V0MYufq+mgFgU+QF0K8IvD?=
 =?us-ascii?Q?yI1edjs3Kh9tdciNk9+CmgEvbIz2zKyfiz1AWMPlv8+HaNhKZrKppFYYa1I6?=
 =?us-ascii?Q?7O1X0/AG3qhjSgtPoZiF3tlVQjqk4J2L6yOnbnT7BEsqcV1vx3rAtW5/4Aor?=
 =?us-ascii?Q?2Wu4adrbwXMjcDbRvunlSejnGIU+W9nQTq61Y0NsiXXmf7l+alP2AHirXGw5?=
 =?us-ascii?Q?zHbPMsBq6rJxmsb/NBzpG2QtSrCgh6GPL5TFA9/fsJQQh4TuloX5y536dwwm?=
 =?us-ascii?Q?B+wM/uIQgGI9VkI4/NV3UxIyrRUC/3r8PHIcHqKHic1HB/yvoOrMxDiZYhii?=
 =?us-ascii?Q?nxmZ3RFHV9MVQFBRpO0aCRYSA0BCEfWfoDBC2N/ssrPwc+lRgQQUtC9eAwIQ?=
 =?us-ascii?Q?gZuxFm86H7GGF9B8SZelWMS7HjrSRLr0vR1jiKlftLJ/Z1oQ+lDTIddoB6Xt?=
 =?us-ascii?Q?M1e90qST92hD9jAFTo+EcA07NzeEYT+ZPFfibBHLbe9Jt1WM9tUJkUngulFT?=
 =?us-ascii?Q?cx95x6d3G2PTxou3/0EANwVwGP2qZ21VXaZSMOa05ZCEmf3xKz/cvBZ/x+jV?=
 =?us-ascii?Q?LauFjyRN5qsb5aVM4+YVGWC4W4f6VayDa8lOfBfGgP2Ieyf+HoYLiPlG0zXn?=
 =?us-ascii?Q?Nyt6TltPKLs0EAjgPHutaQFPZBAriCed+BeNok9P3Cxd2aUfbhrok9xg4pCE?=
 =?us-ascii?Q?L6vrm9SIfNkaLXW/IPk6PYXk7/L84ne4HtW2/ONvKLF8els+O10tGw1gX6YW?=
 =?us-ascii?Q?X4jIExy7P7zWEIEu2an7zoAmhXSZln4eP1kiXZoKBXXz4Isxh1GNNHJPCgtD?=
 =?us-ascii?Q?7e04b0fCdiyIjwdCO3Fy1xQDLHNt242r7eLrAyUdM8vTLcRqHTlqxctRskOy?=
 =?us-ascii?Q?H7dtzE71xdZKBVZgs3uJFg0wzpVvl+OZgPJxhRhJ3LbDSgprYL0wzCdCxXKH?=
 =?us-ascii?Q?844EyTnnC00eq2G2poj+K7vHqjQKpM1KWzDgBvLKdIAhbmrC8WLBKi37BC3z?=
 =?us-ascii?Q?VgWUwB7jvS24vBbZd4Owuck0TgQi5ZzGVqQXyatON2twUU8e51uDAMPxPKbO?=
 =?us-ascii?Q?aRX0m+EBtxISqWzozi4cWP60JWeufLZ58xY6xR+m8VTOfll8ruv9uN25Rmhk?=
 =?us-ascii?Q?bhFZnm7e4j2CpRXW64oIF7ZuCUlynqCHft9ZuKY4UAjNGU7XPTEubeeccHQ9?=
 =?us-ascii?Q?1qJD6gDElVVEOzWjfzUJsC5pmxy4ZBmbEVN9Piqf+k2goCoev3Be3nuYRCUC?=
 =?us-ascii?Q?qf2LEVgB6MjSf6zgWsWhz5ilLbYujj8Iu1Q6fhstInGFAAbNLw2rXv0HwzNC?=
 =?us-ascii?Q?DPk2utnbWjskVxpqQJiqYKHs7cvqtn8DSdlpEPlBA/zWfQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ZfxnIH/UHPB/crHkwvzoTCPm55cn5zrI3tAxXmxDxbwJWgepGwSBTExQOMq?=
 =?us-ascii?Q?HiQbZgZnjXNINwd3zzpXYbwUDdrznsi5Rb7xd0x1ITuNEU0LhVPE/4XWbgLU?=
 =?us-ascii?Q?lMP4jwy2mdlPvKHGW0YAgQWcPwsXlHyzNJhTyUb8yUpDYbYirW5vVeBsVN4T?=
 =?us-ascii?Q?z5xbsFyF0yNPSqWfxWeAJr6xhj9F/OAMBAJGow74GySXmqM2BCEf4OzymqEg?=
 =?us-ascii?Q?nllgBdqLRNAmYzlU0WutDXfGZu+bzr6ehS30c84SejfaUGl1sThgfXAgC5Hu?=
 =?us-ascii?Q?FAYRAeEYFg7TEDKFYqIrB/XTScHZgTizdII1NQRLkO7WUJIJAAqZ3FmApzFu?=
 =?us-ascii?Q?Gk9F++Hh+ilUSjRgpflWsyR802CooqN2ahG64FIKUgwCMZ6539EKclGE3x5B?=
 =?us-ascii?Q?woiYHnhMMEinWxjEQZjV2OanEe9hnr2WdS5TYr7ByHSmrqDB9QQQ6x3lC3Y2?=
 =?us-ascii?Q?oO6/K1R7XLmGiemzkCrAuH/1XuF6YYjPN90JO2xw4EKaWy5PEP5D1CAxrMC6?=
 =?us-ascii?Q?UHR5sFhJbSVSfko4E8I3C8SjaeJ4HbCmdhF717B7vZZa2hGk3LNXdyKlXFXe?=
 =?us-ascii?Q?zPMl0olmr2E/ShIvgal6H7+Bk5LO3ozbPoqKleIvmpbiM1TWjk5716TaArZk?=
 =?us-ascii?Q?3dtMGNFpAAR5wR/OpamDFThBWRC/BZ6D+9TzYcM8KKTParS57UPX/fE4Zulj?=
 =?us-ascii?Q?idKcjQFKwbqudQXXtYMb7a20mvhUX3+Wup5WgYbFfbD+KI8uHZsRxduKQF88?=
 =?us-ascii?Q?aHajWfq21nzJ6FFqH1zHUwZqVcvpBDgAz9v1UIFGBfRrDRX7B/Oan5fMH2og?=
 =?us-ascii?Q?Z7trWHEfbTMijjEz4+zCIax2p4NkMDWcyQ/TRWekO3uPe2ik3VOcvJap7der?=
 =?us-ascii?Q?wLoUSDBYB2VaZvh5w2ebZlQF5FlkbKPZKUAWe2u0r4azk8O3WW+Z8b0lGkAY?=
 =?us-ascii?Q?/lvntuTXSdjpZbBGil9UKdAS6DeRlZYUJGjjzzb3ssN6YEXM8Y632ougZCOp?=
 =?us-ascii?Q?2kPg8TzngmoLo/2ntBsJzkAAaP9oPEZWPuY4Jv6GTHo57VZqKd2KJCu4eXMd?=
 =?us-ascii?Q?uq8gN2l324OpiS9sG62qS4Z5bwNxpiMwzS7YbbhlnXi17I0ZvztZ2CkEHX8q?=
 =?us-ascii?Q?1wqJLu6GCubmIUPYe2+tL4/ua4umzs//a2J5azAdOYrFHXngyzporBpjigDs?=
 =?us-ascii?Q?u+anV8vmp9QWcEesXRB5xHkw3z0EVGQlRoF6JHvXIuWZn0XRKuKVKv5c/dDw?=
 =?us-ascii?Q?ZXWKajLA5g5bPlAkwSkHYhtp47o4DrSc51KzTZsh4ZJ+tWWaMA0RsN9SBsuu?=
 =?us-ascii?Q?yQ+FieKmu2IyRmWfqGHLArf3FZf9cBoCDFLUfHRjWcDka7OjtCFUR/5WNF5F?=
 =?us-ascii?Q?3MGiwAgvcyPAW3hndd2fzLDY+M467zBI/twWO4/CadB17nkFA1WzN879pe+H?=
 =?us-ascii?Q?0d2i5psCQouJVmJA8ZtFHzzrDAfUlwXsfQc1VV+v6O3uiOuXNjIAaSOPgpRw?=
 =?us-ascii?Q?olFZZgd/uPqIeGw6dVYVGYYyRgrrkQTlqGiNCqS2TZT/RLcpy5yzUU3astqY?=
 =?us-ascii?Q?Tva4oluVPrexLA06EXKlRwsJpHB787tOH5SWmHUw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c7d554-ecc4-4d8a-70a8-08dc73df5e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 06:30:37.1531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYE/Hdmdz3fqjGZnvlVPisf7Q7VtYejHO3GCF5I+rzE6jtPWMuorj2Han/jspWBUFyS0D4U8h/MBTwJpeLrt5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Monday, May 13, 2024 11:14 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v6 6/7] migration/multifd: implement qpl compression
> and decompression
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > each qpl job is used to (de)compress a normal page and it can
> > be processed independently by the IAA hardware. All qpl jobs
> > are submitted to the hardware at once, and wait for all jobs
> > completion. If hardware path(IAA) is not available, use software
> > for compression and decompression.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  migration/multifd-qpl.c | 284 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 280 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> > index 89fa51091a..9a1fddbdd0 100644
> > --- a/migration/multifd-qpl.c
> > +++ b/migration/multifd-qpl.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/module.h"
> >  #include "qapi/error.h"
> > +#include "exec/ramblock.h"
> >  #include "migration.h"
> >  #include "multifd.h"
> >  #include "qpl/qpl.h"
> > @@ -204,6 +205,139 @@ static void
> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> >      p->iov =3D NULL;
> >  }
> >
> > +/**
> > + * multifd_qpl_prepare_job: prepare a compression or decompression job
> > + *
> > + * Prepare a compression or decompression job and configure job
> attributes
> > + * including job compression level and flags.
> > + *
> > + * @job: pointer to the QplData structure
>=20
> qpl_job structure

Thanks for the comment, I will fix this next version.

> > + * @is_compression: compression or decompression indication
> > + * @input: pointer to the input data buffer
> > + * @input_len: the length of the input data
> > + * @output: pointer to the output data buffer
> > + * @output_len: the size of the output data buffer
> > + */
> > +static void multifd_qpl_prepare_job(qpl_job *job, bool is_compression,
> > +                                    uint8_t *input, uint32_t input_len=
,
> > +                                    uint8_t *output, uint32_t
> output_len)
> > +{
> > +    job->op =3D is_compression ? qpl_op_compress : qpl_op_decompress;
> > +    job->next_in_ptr =3D input;
> > +    job->next_out_ptr =3D output;
> > +    job->available_in =3D input_len;
> > +    job->available_out =3D output_len;
> > +    job->flags =3D QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERI=
FY;
> > +    /* only supports one compression level */
> > +    job->level =3D 1;
> > +}
> > +
> > +/**
> > + * multifd_qpl_build_packet: build a qpl compressed data packet
> > + *
> > + * The qpl compressed data packet consists of two parts, one part
> stores
> > + * the compressed length of each page, and the other part is the
> compressed
> > + * data of each page. The zbuf_hdr stores the compressed length of all
> pages,
> > + * and use a separate IOV to store the compressed data of each page.
> > + *
> > + * @qpl: pointer to the QplData structure
> > + * @p: Params for the channel that we are using
> > + * @idx: The index of the compressed length array
> > + * @addr: pointer to the compressed data
> > + * @len: The length of the compressed data
> > + */
> > +static void multifd_qpl_build_packet(QplData *qpl, MultiFDSendParams
> *p,
> > +                                     uint32_t idx, uint8_t *addr,
> uint32_t len)
> > +{
> > +    qpl->zbuf_hdr[idx] =3D cpu_to_be32(len);
> > +    p->iov[p->iovs_num].iov_base =3D addr;
> > +    p->iov[p->iovs_num].iov_len =3D len;
> > +    p->iovs_num++;
> > +    p->next_packet_size +=3D len;
> > +}
> > +
> > +/**
> > + * multifd_qpl_compress_pages: compress normal pages
> > + *
> > + * Each normal page will be compressed independently, and the
> compression jobs
> > + * will be submitted to the IAA hardware in non-blocking mode, waiting
> for all
> > + * jobs to be completed and filling the compressed length and data int=
o
> the
> > + * sending IOVs. If IAA device is not available, the software path is
> used.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_compress_pages(MultiFDSendParams *p, Error
> **errp)
> > +{
> > +    qpl_status status;
> > +    QplData *qpl =3D p->compress_data;
> > +    MultiFDPages_t *pages =3D p->pages;
> > +    uint8_t *zbuf =3D qpl->zbuf;
> > +    uint8_t *host =3D pages->block->host;
> > +    uint32_t job_num =3D pages->normal_num;
>=20
> A bit misleading because job_num is used in the previous patch as a
> synonym for page_count. We could change the previous patch to:
> multifd_qpl_init(uint32_t page_count, ...

Yes, I will replace job_num with page_count for multifd_qpl_init next versi=
on.

> > +    qpl_job *job =3D NULL;
> > +
> > +    assert(job_num <=3D qpl->total_job_num);
> > +    /* submit all compression jobs */
> > +    for (int i =3D 0; i < job_num; i++) {
> > +        job =3D qpl->job_array[i];
> > +        multifd_qpl_prepare_job(job, true, host + pages->offset[i],
> > +                                p->page_size, zbuf, p->page_size - 1);
>=20
> Isn't the output buffer size =3D=3D page size, why the -1?

I think the compressed data should be smaller than a normal page.=20
If the compressed data size is equal to a normal page, send the original=20
page directly to avoid decompression operation.

If the output buffer size is set to p->page_size, the compressed data size=
=20
may be greater than or equal to a normal page, then there are two condition=
s for
sending a normal page, one is job status =3D=3D QPL_STS_OK and job->total_o=
ut =3D=3D p->page_size,
another is job status =3D=3D QPL_STS_MORE_OUTPUT_NEEDED.

If the output buffer size is p->page_size - 1, only check QPL_STS_MORE_OUTP=
UT_NEEDED is ok.=20
I will add comments for this in the next version.

> > +        /* if hardware path(IAA) is unavailable, call the software pat=
h
> */
>=20
> If we're doing the fallback automatically, isn't that what qpl_path_auto
> does already? What's the difference between the two approaches?

The qpl_path_auto feature currently has some limitations.

Limitation 1: it does not detect IAA device status before job submission, w=
hich means
I need to use qpl_init_job(qpl_path_hardware, ...) first to make sure the h=
ardware path
is available, then qpl_path_auto can work for software fallback when submit=
ting a job to=20
the IAA fails.

Limitation 2: The job submission API has changed
For the qpl_path_hardware, the qpl_submit_job is a non-blocking function, o=
nly submitting
a job to IAA work queues, use qpl_wait_job to get the job result.

For qpl_path_software/auto, the qpl_submit_job is a blocking function and r=
eturns the job
result directly,  qpl_wait_job can't get the job result.

In short, the qpl_submit_job/qpl_wait_job APIs do not well support the qpl_=
path_auto feature.

> > +        if (!qpl->iaa_avail) {
>=20
> This function got a bit convoluted, it's probably worth a check at the
> start and a branch to different multifd_qpl_compress_pages_slow()
> routine altogether.

I agree that using multifd_qpl_compress_pages_slow is a better choice.

In my previous thoughts, the QPl software path(or slow path) is only used
for the unit test and I did not consider fallback to the software path when
migration start because the QPL software path has no advantage over zstd.
So when the work queue is full, always try to resubmit the job instead of=20
fallback software path.

I now realize that when IAA hardware throughput is the bottleneck(the work =
queue is full),
switching to software may also increase performance.

I will implement the automatically falling back to the software when IAA wo=
rk
queue is full into the next version and update the performance data. With t=
he
increase in mutlfd migration threads, the performance will be better than n=
ow.
Currently, 4 threads will reach the IAA device throughput bottleneck, then =
increasing
The number of threads does not increase any performance.

> > +            status =3D qpl_execute_job(job);
> > +            if (status =3D=3D QPL_STS_OK) {
> > +                multifd_qpl_build_packet(qpl, p, i, zbuf, job-
> >total_out);
> > +            } else if (status =3D=3D QPL_STS_MORE_OUTPUT_NEEDED) {
> > +                /* compressed length exceeds page size, send page
> directly */
> > +                multifd_qpl_build_packet(qpl, p, i, host + pages-
> >offset[i],
> > +                                         p->page_size);
> > +            } else {
> > +                error_setg(errp, "multifd %u: qpl_execute_job
> error %d",
> > +                           p->id, status);
> > +                return -1;
> > +            }
> > +            zbuf +=3D p->page_size;
> > +            continue;
> > +        }
> > +retry:
> > +        status =3D qpl_submit_job(job);
> > +        if (status =3D=3D QPL_STS_OK) {
> > +            zbuf +=3D p->page_size;
> > +        } else if (status =3D=3D QPL_STS_QUEUES_ARE_BUSY_ERR) {
> > +            goto retry;
>=20
> A retry count here would be nice.

As the previous comment, I will switch to multifd_qpl_compress_pages_slow
When the work queue is full, I will give a performance comparison between
hardware only and software fallback next version.

> > +        } else {
> > +            error_setg(errp, "multifd %u: qpl_submit_job failed with
> error %d",
> > +                       p->id, status);
> > +            return -1;
> > +        }
> > +    }
> > +    if (!qpl->iaa_avail) {
> > +        goto done;
> > +    }
> > +    /* wait all jobs to complete for hardware(IAA) path */
> > +    for (int i =3D 0; i < job_num; i++) {
> > +        job =3D qpl->job_array[i];
> > +        status =3D qpl_wait_job(job);
> > +        if (status =3D=3D QPL_STS_OK) {
> > +            multifd_qpl_build_packet(qpl, p, i, qpl->zbuf + (p-
> >page_size * i),
> > +                                     job->total_out);
> > +        } else if (status =3D=3D QPL_STS_MORE_OUTPUT_NEEDED) {
> > +            /* compressed data length exceeds page size, send page
> directly */
> > +            multifd_qpl_build_packet(qpl, p, i, host + pages-
> >offset[i],
> > +                                     p->page_size);
> > +        } else {
> > +            error_setg(errp, "multifd %u: qpl_wait_job failed with
> error %d",
> > +                       p->id, status);
> > +            return -1;
> > +        }
> > +    }
> > +done:
> > +    return 0;
> > +}
> > +
> >  /**
> >   * multifd_qpl_send_prepare: prepare data to be able to send
> >   *
> > @@ -217,8 +351,28 @@ static void
> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> >   */
> >  static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp=
)
> >  {
> > -    /* Implement in next patch */
> > -    return -1;
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t hdr_size;
> > +
> > +    if (!multifd_send_prepare_common(p)) {
> > +        goto out;
> > +    }
> > +
> > +    assert(p->pages->normal_num <=3D qpl->total_job_num);
> > +    hdr_size =3D p->pages->normal_num * sizeof(uint32_t);
> > +    /* prepare the header that stores the lengths of all compressed
> data */
> > +    p->iov[1].iov_base =3D (uint8_t *) qpl->zbuf_hdr;
> > +    p->iov[1].iov_len =3D hdr_size;
>=20
> Better use p->iovs_num here in case we ever decide to add more stuff to
> the front of the array.

Get it, I will fix this next version.
=20
> > +    p->iovs_num++;
> > +    p->next_packet_size +=3D hdr_size;
>=20
> Here's the first time we're setting this value, right? So just a regular
> attribution(=3D).

Yes, I will fix this next version.

> > +    if (multifd_qpl_compress_pages(p, errp) !=3D 0) {
> > +        return -1;
> > +    }
> > +
> > +out:
> > +    p->flags |=3D MULTIFD_FLAG_QPL;
> > +    multifd_send_fill_packet(p);
> > +    return 0;
> >  }
> >
> >  /**
> > @@ -256,6 +410,88 @@ static void
> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> >      p->compress_data =3D NULL;
> >  }
> >
> > +/**
> > + * multifd_qpl_decompress_pages: decompress normal pages
> > + *
> > + * Each compressed page will be decompressed independently, and the
> > + * decompression jobs will be submitted to the IAA hardware in non-
> blocking
> > + * mode, waiting for all jobs to be completed and loading the
> decompressed
> > + * data into guest memory. If IAA device is not available, the softwar=
e
> path
> > + * is used.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error
> **errp)
> > +{
> > +    qpl_status status;
> > +    qpl_job *job;
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t job_num =3D p->normal_num;
> > +    uint32_t off =3D 0;
> > +
> > +    assert(job_num <=3D qpl->total_job_num);
> > +    /* submit all decompression jobs */
> > +    for (int i =3D 0; i < job_num; i++) {
> > +        /* if the data size is the same as the page size, load it
> directly */
> > +        if (qpl->zbuf_hdr[i] =3D=3D p->page_size) {
> > +            memcpy(p->host + p->normal[i], qpl->zbuf + off, p-
> >page_size);
> > +            off +=3D p->page_size;
> > +            continue;
> > +        }
> > +        job =3D qpl->job_array[i];
> > +        multifd_qpl_prepare_job(job, false, qpl->zbuf + off, qpl-
> >zbuf_hdr[i],
> > +                                p->host + p->normal[i], p->page_size);
> > +        /* if hardware path(IAA) is unavailable, call the software pat=
h
> */
> > +        if (!qpl->iaa_avail) {
> > +            status =3D qpl_execute_job(job);
> > +            if (status =3D=3D QPL_STS_OK) {
> > +                off +=3D qpl->zbuf_hdr[i];
> > +                continue;
> > +            }
> > +            error_setg(errp, "multifd %u: qpl_execute_job failed with
> error %d",
> > +                       p->id, status);
> > +            return -1;
> > +        }
> > +retry:
> > +        status =3D qpl_submit_job(job);
> > +        if (status =3D=3D QPL_STS_OK) {
> > +            off +=3D qpl->zbuf_hdr[i];
> > +        } else if (status =3D=3D QPL_STS_QUEUES_ARE_BUSY_ERR) {
> > +            goto retry;
> > +        } else {
> > +            error_setg(errp, "multifd %u: qpl_submit_job failed with
> error %d",
> > +                       p->id, status);
> > +            return -1;
> > +        }
> > +    }
> > +    if (!qpl->iaa_avail) {
> > +        goto done;
> > +    }
> > +    /* wait all jobs to complete for hardware(IAA) path */
> > +    for (int i =3D 0; i < job_num; i++) {
> > +        if (qpl->zbuf_hdr[i] =3D=3D p->page_size) {
> > +            continue;
> > +        }
> > +        job =3D qpl->job_array[i];
> > +        status =3D qpl_wait_job(job);
> > +        if (status !=3D QPL_STS_OK) {
> > +            error_setg(errp, "multifd %u: qpl_wait_job failed with
> error %d",
> > +                       p->id, status);
> > +            return -1;
> > +        }
> > +        if (job->total_out !=3D p->page_size) {
> > +            error_setg(errp, "multifd %u: decompressed len %u, expecte=
d
> len %u",
> > +                       p->id, job->total_out, p->page_size);
> > +            return -1;
> > +        }
> > +    }
> > +done:
> > +    return 0;
> > +}
> > +
> >  /**
> >   * multifd_qpl_recv: read the data from the channel into actual pages
> >   *
> > @@ -269,8 +505,48 @@ static void
> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> >   */
> >  static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
> >  {
> > -    /* Implement in next patch */
> > -    return -1;
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t in_size =3D p->next_packet_size;
> > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> > +    uint32_t hdr_len =3D p->normal_num * sizeof(uint32_t);
> > +    uint32_t data_len =3D 0;
> > +    int ret;
> > +
> > +    if (flags !=3D MULTIFD_FLAG_QPL) {
> > +        error_setg(errp, "multifd %u: flags received %x flags
> expected %x",
> > +                   p->id, flags, MULTIFD_FLAG_QPL);
> > +        return -1;
> > +    }
> > +    multifd_recv_zero_page_process(p);
> > +    if (!p->normal_num) {
> > +        assert(in_size =3D=3D 0);
> > +        return 0;
> > +    }
> > +
> > +    /* read compressed data lengths */
> > +    assert(hdr_len < in_size);
> > +    ret =3D qio_channel_read_all(p->c, (void *) qpl->zbuf_hdr, hdr_len=
,
> errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +    assert(p->normal_num <=3D qpl->total_job_num);
>=20
> I'm still in doubt whether we should use p->page_count directly all
> over. It's nice to move the concept into the QPL domain space, but it
> makes less sense in these functions that take MultiFD*Params as
> argument.

I don't understand what you mean here. Do you plan to remove page_count fro=
m MultiFD*Params
and provide a new API to get the migrated page count?

> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        qpl->zbuf_hdr[i] =3D be32_to_cpu(qpl->zbuf_hdr[i]);
> > +        data_len +=3D qpl->zbuf_hdr[i];
> > +        assert(qpl->zbuf_hdr[i] <=3D p->page_size);
> > +    }
> > +
> > +    /* read compressed data */
> > +    assert(in_size =3D=3D hdr_len + data_len);
> > +    ret =3D qio_channel_read_all(p->c, (void *) qpl->zbuf, data_len,
> errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (multifd_qpl_decompress_pages(p, errp) !=3D 0) {
> > +        return -1;
> > +    }
> > +    return 0;
> >  }
> >
> >  static MultiFDMethods multifd_qpl_ops =3D {

