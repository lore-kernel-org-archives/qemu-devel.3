Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5FFC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 12:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5m1F-0003ns-PF; Sat, 11 May 2024 08:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s5m1D-0003nR-PC
 for qemu-devel@nongnu.org; Sat, 11 May 2024 08:40:03 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s5m1A-00015g-Lj
 for qemu-devel@nongnu.org; Sat, 11 May 2024 08:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715431201; x=1746967201;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Kw9FaPYrvEj1anLsqYwDZcYXeMWwXhNqXaN0Mrwm1uw=;
 b=SRWm8uvJhmcY+s9iEtmbzM7EvXC0Xx4Nic2Gbc9ykEJ35Ft47qa45RzX
 oA90JzsWACPI6kUof7tabWjiiv3R6fJVGcFwtwCVF9Bxe08Goh9oCSPJ2
 Q+f1Kt4gOwuoVvn7l1n0i5NhuiXwne3Z124EBMk3iKfadjUMTOQOs889k
 pwl37h0LYfyTiPsS+5NrTuB92Mh2HAK+leP3O/ydqWMhjbzZE5lPXDwZd
 UuVxzdOOXg4MNhlV6UrNL7o/p+H6pNWzY+0H1WhbyRXgnRt6FA04RjZ0M
 k9apf9EgsbH+f07dk0N2hntphhCL+iYyQ9XGncZVvPvcmw5BAebBBUU5S w==;
X-CSE-ConnectionGUID: 0GpKF+LWRW6FaXZO4NzGrg==
X-CSE-MsgGUID: QEU8JngXQCqF4LiBnQ1bZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11273874"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; d="scan'208";a="11273874"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2024 05:39:57 -0700
X-CSE-ConnectionGUID: KEukCq3iQ4KalNSeLH+LoA==
X-CSE-MsgGUID: HR9fPBd3Tl6yvjwPEX40HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; d="scan'208";a="34431153"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 May 2024 05:39:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 11 May 2024 05:39:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 11 May 2024 05:39:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 11 May 2024 05:39:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFmHKk8j65DDtRofbIWPnKP9EY7UkVNMvM//vS6zDO2DQvDebo4Jnb49rrQNnzQXBzoGVpU0Pgq1NrrsK7BD9+AIEJ/B28uUq5XVFZRVAiSb/IlbSpDuA7F7dzBX22/+HPOvhA2WBAGZrfL3hSLsyNVFC7d9xpPPzb6LBa7lnHJ7e44dfkSEV5yEbhyp+NbvoKMw+6my3t6a93NZK1cfH5eaC2nnsIdLOO2ODpJVNxnvYxLinKmUxY7tdlojXl1qcXgihM2kGn24ggfQcSpKSapCnNH0qZEDy8kJRgXQSx4an1xgDqCyvkPU1IcGGl+9NYPWbCOIAWfdNg/fmQTMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrApcM1zh2f6rdzvP0i5vY5iH1tfk7SDed/Gmt+fJzA=;
 b=dJ+vx5GzUPYRikqQ50MMXQve5hdPCGYwHefd5ZYdGczGo2rV0oC54Y3TFBK2oecldme8+ZTICE1nzlj7WT8Er2wN+re9nbcGzkGPxh3jlldX0Uge8jgvgRB5EtwtYrzquWZHQ2dDL6iZ3Ghnn9WUrt0J481OA0DP1r1m6EyHWixBRp5FwJCIbLzSkEbMz7VePZQz7xVVdfSTh09psRF+lJW/cI+YX33q4m80tFV0qjHMRS5kb01f93akhh/7rAN5bfQJBonpT/3/cOwPooQi+Tv24ic0u9Wanfs/Vl8hIUFxuuMST9dgUfHx0JMtYwSYbTYlNqCZbxtz05dM2g5JSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Sat, 11 May
 2024 12:39:53 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%5]) with mapi id 15.20.7544.041; Sat, 11 May 2024
 12:39:53 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v6 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v6 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHan5HTHXPsmPSqGUqaYb0smdpZjrGQ+OyAgAEHrMA=
Date: Sat, 11 May 2024 12:39:53 +0000
Message-ID: <PH7PR11MB5941AB0833D31F2EB0615C16A3E02@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-6-yuan1.liu@intel.com> <87le4hfkyg.fsf@suse.de>
In-Reply-To: <87le4hfkyg.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS0PR11MB7481:EE_
x-ms-office365-filtering-correlation-id: 022e9901-01d8-47b9-fab4-08dc71b774f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?CBqXwcRICutHYKReOfPv+38LFs2sK/d9DUvF0uZ3onubfLbusmAyKkif+/3I?=
 =?us-ascii?Q?GcNhYPJmTUAPOMHOco5ybXP2Hu5jBeFEPV++GY4oTzh9D7CXGPn+ULtzj1AG?=
 =?us-ascii?Q?T4XnTmv36VjqhIX7bRw6wOd+7aBXwPtFUE450UI+qjQrzkB7YsSHCynjmLSs?=
 =?us-ascii?Q?0GIHoWNHwviGm8PDL/12Ljd9zJ8gGwpmwHTL0O2keYhj++qo4u23QMvOEEOm?=
 =?us-ascii?Q?taxQhYFPkKxARyQgqiiC4WD2rrWIzyRPf+cdtnWJ3jH34ROtj+2jswZJkVYP?=
 =?us-ascii?Q?Q46Y+fe84OQc66sga4QsF5vhqw3N3UPFvTPlMu90WsdR3xJJQDlo7PWTMOGq?=
 =?us-ascii?Q?+LaJwF5iTFgXSdJjRWuLGENyCuOUrUdq+L4Id/hT57XsaijL9vM8n2cSv16b?=
 =?us-ascii?Q?GhyCYqMZjufcxW7Z/T99TJBBYxd8IU2DyzW8/XTf6CkGB1jd9eKcbBInNZnb?=
 =?us-ascii?Q?pswd5CR29i9gOxQFqR2c/Zt21hrrQEv6kEe3WZ/FDjfU85MdIKYnKBIzRAJU?=
 =?us-ascii?Q?Yqr/1rqfCEw76aJBT5Xcg4I84HqeEg0p0W88E8hDZdwS5dKnpLlveDTfnPPZ?=
 =?us-ascii?Q?PzkL9EyLeHQH05BoRwmXeHC3VigK/48WhrVC8W3mqlE6MnGrSdF2k/DDKzcK?=
 =?us-ascii?Q?kb/jZNLPKsUgJR/rM+wlGJU5ZP5hpaiJ3d88Ma/OU52KmHmTTe/UGtPsMVnY?=
 =?us-ascii?Q?dF7f1B3K/60hlv4Q80IVXDx1CEU6iT43AFnYA/uAN8CiXorrJPbWoKbKCpjT?=
 =?us-ascii?Q?FiLhZneaD+jH2pe0wv9WFchZ6+cDego0o/IHrQNfhwrezDUFA0XfX7J0fIcs?=
 =?us-ascii?Q?P6MLseI+vVMrDJ6dZLBoqNZFdHjGOKNx773JGEQteaZlUd/VNKK0J1m02jeC?=
 =?us-ascii?Q?YPWa/RzM32NctzwhP0NtkyS4nqyOvPF915moaQQusxZBWLs+AV3iyUGWcNzO?=
 =?us-ascii?Q?j2RXQuVTNSFoCnYlVec+rC61Eb+hiwt7qeHWJqgiN3n4D3o/cp96Tpc4WbC+?=
 =?us-ascii?Q?Hm8Rf0GxRNxfoC2+o8lbXzS6FiDqEgcEwIQoVjKuozAGnn7MLBNBquajG3rD?=
 =?us-ascii?Q?U/RA+fiC85r9jjbAGS+4DWRddN103niyltGt/fMvaXTx3Gmt2Ve5PZxAeBtY?=
 =?us-ascii?Q?977f7gmXfNHAssJwOUZmKKAumX6yyHOj9ltbXupctgW/xrTFS7IGfaOERPVr?=
 =?us-ascii?Q?jf2aLMmrEuONbFTsp5DW2KvLEDhJFmoiHoyu5xLBFzD98EPQ0l2CB2hCMei5?=
 =?us-ascii?Q?y8H7m+Ue9hwkEmRUm26s/+/PaQgmk1etcizBFXZTHLQ9f4yT5THmPrJ4bhB9?=
 =?us-ascii?Q?CMlcFpyE3xaSV9lpKdQnWItfLoLRY2/k3BUkFp0uB5Rwew=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LbZ1g4r2HUSbfR6+MyeaNj08yk9N+o0tbH8lp9q7eWkKvsL+s8u+pr6yl4ab?=
 =?us-ascii?Q?dzJE9tN22Hv4rkObX8CPUOJomDJmhEGHGtelMMpQUT7+J3bzIEoetjUV4izX?=
 =?us-ascii?Q?gheWeEPmqE7KVASUUx3vwcJeNYTCCZUy7u03MkpQP+GFCSHc9bqwjzVhlQH8?=
 =?us-ascii?Q?M3HB12fVo4gxDpekywe8AUMZo77VyhD+fwpWhN7H0h4s5X8QktU/JOmlO8td?=
 =?us-ascii?Q?I6mXB2k1hSQwjfbgTsHSqNIXEYEt6zSulbyIWfpWa5SQoJoRLY6ROPILHtQG?=
 =?us-ascii?Q?tzpqdKT+vMOAAbNqSj/dz1VDyFm25POSvuRCIc9Cmv0ZZowGalZyMgriVQdb?=
 =?us-ascii?Q?6tuGhgxeStoTpTSLofctJXFc2JEztXPDrI9WfpcqIszpfeEtlkSffaPqJA83?=
 =?us-ascii?Q?ibvVRTef1Rk6T+IrZ+3H7lUAaszJZPJFhVEBHkGhQA9BRz4exXvptUfD+4CD?=
 =?us-ascii?Q?oOd6jXkK5krjPLPqix3AsnQU+afthnh66g21X+oKaLVIQx34NVqIbbU3DKKE?=
 =?us-ascii?Q?ZB3o1VlNC+4eG6V6b79pR4usemXkWBd41C25IsYA+aj2S2xmbkCtfKoiSQqT?=
 =?us-ascii?Q?/V7bk7YoanUQlUjVkpqwdERfYmDMER9Dsm36wgeHEESHipo6FY2iCxutZwg2?=
 =?us-ascii?Q?2Pq/TXHK9SrlRyJZrM2xaX7kWOiAMhPfFOt3j1NGhAfE39C/FC+8w6t5FF/2?=
 =?us-ascii?Q?L7NvTOVrdAOjLEhWE618a2Q1qvHqtLcAeT1bJUyZWuCGY1mDFlYk82AdMnce?=
 =?us-ascii?Q?GvM3iLt3z5T5mm4LKCZXCpZLHcpklf34ZKvluo0YQRmtOJjzJe9QKk+yJ+yg?=
 =?us-ascii?Q?OO8sM5Y6mcyAZWSEXp+fIVfVaMPCqv+XL/NSgfVaNDK0W3Xo9MqAEVEiZUdY?=
 =?us-ascii?Q?r473JigFRESMWdmqjAfdXj7ZwOJIAqXfnTFUZoP+8WtheM/NgR3whMpcEOoW?=
 =?us-ascii?Q?xit2eYJkxeXGcWVRNZV8nydABRdga7h53eEgI708SevQ21JmyzBSGI5X9B02?=
 =?us-ascii?Q?IZo/5REiFMCeKSjPF2hS3LoUUc/QAHrgef7iuWw5Z4XRKGReFJsrWEwcS2L0?=
 =?us-ascii?Q?1pMhMZ7pGlIUzgJMBjQ7ouv/NlArZWqrZHS7hpbv2MgryWHuj/QRoKKTN+IZ?=
 =?us-ascii?Q?0qai/8yTchcuZ+ZM27Dh/EhqbWjqGnzZgzoUwtgzEDbUZ0Lvt8eav+321Uek?=
 =?us-ascii?Q?z7Er9Uksc/iafiuykDTZC05OP2GExeSnZ/wU2eTptyHZhadcUFfi2PRQrNi4?=
 =?us-ascii?Q?UDEILBXp9ZsJ2NPzZO/bf/I6FwBmaYb5FTUTYOPM9B4/8IXsFkSaoN8cERVV?=
 =?us-ascii?Q?Xx7hpC4GYzCC3vdCQVhFGOVQFZIMy8fHNPcKGjvz57Mu9hse6YQv8vUssW21?=
 =?us-ascii?Q?cookuaxviC3JycxIJw311mlJxPGrRY6c5kQG/q8FMAJ/afZPLd1txO1/Vbfs?=
 =?us-ascii?Q?3myhzIpM3+PDhm1KPyRBzmCZb37o4z6OVVlKGwdbFntGGi0S7awhRJMmFswz?=
 =?us-ascii?Q?lS1egCMZKQ638a0ersCvixVIYFxQvbE/oKzR0R8Thm31rpJgLEc5ZU8LxKYl?=
 =?us-ascii?Q?q8e1ivYjDEOoiPAE0ih1SqZjDZ6F2rWEHzflOcHD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022e9901-01d8-47b9-fab4-08dc71b774f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 12:39:53.4956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfejB1kfnP+V4nVP0GI9ml/XpcNtegKPUVCBtEopW9hU+4t/e01PmBB0EKfE1xVzE7IDt6y+tmcltajCy/hU2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
> Sent: Saturday, May 11, 2024 4:53 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v6 5/7] migration/multifd: implement initialization o=
f
> qpl compression
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > the qpl initialization includes memory allocation for compressed
> > data and the qpl job initialization.
> >
> > the qpl job initialization will check if the In-Memory Analytics
> > Accelerator(IAA) device is available and use the IAA device first.
> > If the platform does not have IAA device or the IAA device is not
> > available, the qpl compression will fallback to the software path.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  migration/multifd-qpl.c | 272 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 271 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> > index 056a68a060..89fa51091a 100644
> > --- a/migration/multifd-qpl.c
> > +++ b/migration/multifd-qpl.c
> > @@ -9,12 +9,282 @@
> >   * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> >   * See the COPYING file in the top-level directory.
> >   */
> > +
> >  #include "qemu/osdep.h"
> >  #include "qemu/module.h"
> > +#include "qapi/error.h"
> > +#include "migration.h"
>=20
> Where is this used? I think you only need qapi/qapi-types-migration.h

Yes, the qapi/qapi-types-migration.h is enough, no need to include migratio=
n.h
I will fix this next version.

> > +#include "multifd.h"
> > +#include "qpl/qpl.h"
> > +
> > +typedef struct {
> > +    qpl_job **job_array;
> > +    /* the number of allocated jobs */
> > +    uint32_t total_job_num;
> > +    /* compressed data buffer */
> > +    uint8_t *zbuf;
> > +    /* the length of compressed data */
> > +    uint32_t *zbuf_hdr;
> > +    /* the status of IAA device */
> > +    bool iaa_avail;
> > +} QplData;
> > +
> > +/**
> > + * check_iaa_avail: check if IAA device is available
> > + *
> > + * If the system does not have an IAA device, the IAA device is
> > + * not enabled or the IAA work queue is not configured as a shared
> > + * mode, the QPL hardware path initialization will fail.
> > + *
> > + * Returns true if IAA device is available, otherwise false.
> > + */
> > +static bool check_iaa_avail(void)
> > +{
> > +    qpl_job *job =3D NULL;
> > +    uint32_t job_size =3D 0;
> > +    qpl_path_t path =3D qpl_path_hardware;
> > +
> > +    if (qpl_get_job_size(path, &job_size) !=3D QPL_STS_OK) {
> > +        return false;
> > +    }
> > +    job =3D g_malloc0(job_size);
> > +    if (qpl_init_job(path, job) !=3D QPL_STS_OK) {
> > +        g_free(job);
> > +        return false;
> > +    }
> > +    g_free(job);
> > +    return true;
> > +}
> > +
> > +/**
> > + * multifd_qpl_free_jobs: cleanup jobs
> > + *
> > + * Free all job resources.
> > + *
> > + * @qpl: pointer to the QplData structure
> > + */
> > +static void multifd_qpl_free_jobs(QplData *qpl)
> > +{
> > +    assert(qpl !=3D NULL);
> > +    for (int i =3D 0; i < qpl->total_job_num; i++) {
> > +        qpl_fini_job(qpl->job_array[i]);
> > +        g_free(qpl->job_array[i]);
> > +        qpl->job_array[i] =3D NULL;
> > +    }
> > +    g_free(qpl->job_array);
> > +    qpl->job_array =3D NULL;
> > +}
> > +
> > +/**
> > + * multifd_qpl_init_jobs: initialize jobs
> > + *
> > + * Initialize all jobs
> > + *
> > + * @qpl: pointer to the QplData structure
> > + * @chan_id: multifd channel number
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_init_jobs(QplData *qpl, uint8_t chan_id, Error
> **errp)
> > +{
> > +    qpl_path_t path;
> > +    qpl_status status;
> > +    uint32_t job_size =3D 0;
> > +    qpl_job *job =3D NULL;
> > +
> > +    path =3D qpl->iaa_avail ? qpl_path_hardware : qpl_path_software;
> > +    status =3D qpl_get_job_size(path, &job_size);
> > +    if (status !=3D QPL_STS_OK) {
> > +        error_setg(errp, "multifd: %u: qpl_get_job_size failed with
> error %d",
> > +                   chan_id, status);
> > +        return -1;
> > +    }
> > +    qpl->job_array =3D g_new0(qpl_job *, qpl->total_job_num);
> > +    for (int i =3D 0; i < qpl->total_job_num; i++) {
> > +        job =3D g_malloc0(job_size);
> > +        status =3D qpl_init_job(path, job);
> > +        if (status !=3D QPL_STS_OK) {
> > +            error_setg(errp, "multifd: %u: qpl_init_job failed with
> error %d",
> > +                       chan_id, status);
> > +            multifd_qpl_free_jobs(qpl);
> > +            return -1;
> > +        }
> > +        qpl->job_array[i] =3D job;
> > +    }
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_qpl_init: initialize QplData structure
> > + *
> > + * Allocate and initialize a QplData structure
> > + *
> > + * Returns QplData pointer for success or NULL for error
> > + *
> > + * @job_num: pointer to the QplData structure
> > + * @job_size: the buffer size of the job
> > + * @chan_id: multifd channel number
> > + * @errp: pointer to an error
> > + */
> > +static QplData *multifd_qpl_init(uint32_t job_num, uint32_t job_size,
> > +                                 uint8_t chan_id, Error **errp)
> > +{
> > +    QplData *qpl;
> > +
> > +    qpl =3D g_new0(QplData, 1);
> > +    qpl->total_job_num =3D job_num;
> > +    qpl->iaa_avail =3D check_iaa_avail();
> > +    if (multifd_qpl_init_jobs(qpl, chan_id, errp) !=3D 0) {
> > +        g_free(qpl);
> > +        return NULL;
> > +    }
> > +    qpl->zbuf =3D g_malloc0(job_size * job_num);
> > +    qpl->zbuf_hdr =3D g_new0(uint32_t, job_num);
> > +    return qpl;
> > +}
> > +
> > +/**
> > + * multifd_qpl_deinit: cleanup QplData structure
> > + *
> > + * Free jobs, comprssed buffers and QplData structure
> > + *
> > + * @qpl: pointer to the QplData structure
> > + */
> > +static void multifd_qpl_deinit(QplData *qpl)
> > +{
> > +    if (qpl !=3D NULL) {
> > +        multifd_qpl_free_jobs(qpl);
> > +        g_free(qpl->zbuf_hdr);
> > +        g_free(qpl->zbuf);
> > +        g_free(qpl);
> > +    }
> > +}
> > +
> > +/**
> > + * multifd_qpl_send_setup: setup send side
> > + *
> > + * Setup each channel with QPL compression.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
> > +{
> > +    QplData *qpl;
> > +
> > +    qpl =3D multifd_qpl_init(p->page_count, p->page_size, p->id, errp)=
;
> > +    if (!qpl) {
> > +        return -1;
> > +    }
> > +    p->compress_data =3D qpl;
> > +
> > +    /*
> > +     * Each page will be compressed independently and sent using an
> IOV. The
> > +     * additional two IOVs are used to store packet header and
> compressed data
> > +     * length
> > +     */
> > +    p->iov =3D g_new0(struct iovec, p->page_count + 2);
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_qpl_send_cleanup: cleanup send side
> > + *
> > + * Close the channel and return memory.
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error
> **errp)
> > +{
> > +    multifd_qpl_deinit(p->compress_data);
> > +    p->compress_data =3D NULL;
> > +    g_free(p->iov);
> > +    p->iov =3D NULL;
> > +}
> > +
> > +/**
> > + * multifd_qpl_send_prepare: prepare data to be able to send
> > + *
> > + * Create a compressed buffer with all the pages that we are going to
> > + * send.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp=
)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +/**
> > + * multifd_qpl_recv_setup: setup receive side
> > + *
> > + * Create the compressed channel and buffer.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    QplData *qpl;
> > +
> > +    qpl =3D multifd_qpl_init(p->page_count, p->page_size, p->id, errp)=
;
> > +    if (!qpl) {
> > +        return -1;
> > +    }
> > +    p->compress_data =3D qpl;
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_qpl_recv_cleanup: setup receive side
> > + *
> > + * Close the channel and return memory.
> > + *
> > + * @p: Params for the channel that we are using
> > + */
> > +static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> > +{
> > +    multifd_qpl_deinit(p->compress_data);
> > +    p->compress_data =3D NULL;
> > +}
> > +
> > +/**
> > + * multifd_qpl_recv: read the data from the channel into actual pages
> > + *
> > + * Read the compressed buffer, and uncompress it into the actual
> > + * pages.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +static MultiFDMethods multifd_qpl_ops =3D {
> > +    .send_setup =3D multifd_qpl_send_setup,
> > +    .send_cleanup =3D multifd_qpl_send_cleanup,
> > +    .send_prepare =3D multifd_qpl_send_prepare,
> > +    .recv_setup =3D multifd_qpl_recv_setup,
> > +    .recv_cleanup =3D multifd_qpl_recv_cleanup,
> > +    .recv =3D multifd_qpl_recv,
> > +};
> >
> >  static void multifd_qpl_register(void)
> >  {
> > -    /* noop */
> > +    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
> >  }
> >
> >  migration_init(multifd_qpl_register);

