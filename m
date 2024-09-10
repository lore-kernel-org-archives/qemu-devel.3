Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B438FEDE996
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 02:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snqlp-0006Lu-Q5; Mon, 09 Sep 2024 22:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1snqlo-0006LJ-Eg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 22:38:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1snqlm-0006cH-Ha
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 22:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725935898; x=1757471898;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KD2Apz7cGfsxBLzj2EsbtzWeo+qGQDqH3iIiYZx6wqU=;
 b=evOLCpMYFmcIJvRHDSoVwMJi0W1RG6rF+CCf517098/MIRNqD3eMuBXU
 oY4C9dOUqISGDfz6x/znaa07bha26iEyTlL7Pdw/2bqoFGXLa98UAGgQK
 ovXzpJqCRPmGrud5kf9qBhkW/iT0oOOQPmrS12lg3EXeNwalS+occKYky
 Fo2UiKNll77rw4QY8MHPNXByknMsXkjjQlJehOAtvjJ0pEvzaaqZiANG2
 +2mOHqSybJ8eOUo19bbSCsQOBMbNZoLyyX+1Iny69WuKT7aOKOyLHBanQ
 PiSJ4YAuDYoDScBqGQ27umQ0OAtd2xehWbiFrm8I02jEivxQAyfK12keC w==;
X-CSE-ConnectionGUID: UpaR6eXASTWu/xJlJL3XCQ==
X-CSE-MsgGUID: NeV5sdtFSI+s2L9YYKfF7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24208223"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; d="scan'208";a="24208223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2024 19:38:14 -0700
X-CSE-ConnectionGUID: IZXtCB7kSv+2r3uwHT4DgQ==
X-CSE-MsgGUID: mWYcQyFKTC6a6Q38O0bKJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; d="scan'208";a="71659010"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Sep 2024 19:38:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 19:38:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 19:38:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 19:38:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 19:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE8MMtXLf3pq/2Nt5Vzg7A+1kWo9pLYPgdoHLIYWSDJdxSRkgI1lM8fRAqrpaypdWQwPx0XbgCXysks/IoR7cmppFW28wQ3V6frfvav/BHA0n2yJwsVL7DrTPWk0ayvA6yoXFE7NFtj0VjuAAj0t4MFIPpXK8Jj07lRD8vQT/FYBsVRFD9e/34S2ZkpKUX+pnJprLvPqgWPmrbEJqffnYU89jiyODs/PCdgUTm5PBZNsf7WX0OrE0hh+jL65UovhBWQG3WTpxBVE/BSpYHUkl3IC+khPdo8tRW+gY4jfamoEscX/bBJbg6gwh2mKNHi8pM9MOFM7fA5Ju2nlf7KIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNzFOjFR1+1ETfPq+XK7CfJfa7SXwjaYKNUV/phXfBk=;
 b=devWCg3/8KKGvwBU5FmufyeT6WAnBlk30AYWlVZYL3WNyGiCVSBzn3BFPSUVJnTZ5n/+aGHrOJkpAnm07fcnTfsKgkko4CzsX0P1P2OMjja9krdzJlze4x7CswRFZIsnAY36IVABBCbQPOMQkwHX+knX60kDaUU+EXO0hGq1msVJYy1DKeMmG4AJuK6inDvYoPl50zudwLis5IVen3JjigwtEy2bvmC+BgBd9L9sPxXDVqZBtpRt39zJhweWMw3d5AFkRhzIL6FGQPGIf5b9S42oMCYmO1Jmz2u8Wfs2pp6yeTv6J2G/t3LBuiHSFwjnAJd02UpDfGSzfWkzb4ny2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 02:38:05 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9%4]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 02:38:05 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Stefan Weil <sw@weilnetz.de>, Li Zhijian <lizhijian@fujitsu.com>, "Jason
 Wang" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Fix calculation of minimum in colo_compare_tcp
Thread-Topic: [PATCH] Fix calculation of minimum in colo_compare_tcp
Thread-Index: AQHbAvjmQaDInInX9UClxjrotKzWGLJQTpAA
Date: Tue, 10 Sep 2024 02:38:05 +0000
Message-ID: <CYYPR11MB8432028036D306D2FB6F4A359B9A2@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20240909204254.1446800-1-sw@weilnetz.de>
In-Reply-To: <20240909204254.1446800-1-sw@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|DS0PR11MB8082:EE_
x-ms-office365-filtering-correlation-id: 9ccef6d7-0f03-47e0-cbd5-08dcd1419934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HU+zbVAzl413vyRdIBRqYgwVwljZAjiJVPG1rfSKUmr/eQWCyumve/yOb8M+?=
 =?us-ascii?Q?kluFP+SpWUquWS6pItrK1jI9ukHTvaMmdEFKI3bI4xyZFI4Y7K+P3DoEOwNy?=
 =?us-ascii?Q?J0bTQvU5Cp8LyPcWtgEJi0xh0FF+McZ9G3nxwT+qT+ecgNXa1DTc/8XPAyPy?=
 =?us-ascii?Q?1k4jer1LLq2uqQPGO7YKwhmldODZdfr/UXfiRM6qYUsc2h/mipfVRLx42oGb?=
 =?us-ascii?Q?fSmLVNztp94Ec2XBOD7Okw3rqh+I4HNcvgoknEKAJPubPDjfkTWxZ1on5sgk?=
 =?us-ascii?Q?MB0dKxXVIrdkNhMBH7F6rQYF3xvIeW3fbf+gEH7jPkJhaOeE/lJ8EJAX+0Pl?=
 =?us-ascii?Q?NCojZRDhA735z0ua+RGD67QQUv6RvJDgWf/wtQUPiS9IUd8Qoy0oDJagm8Fb?=
 =?us-ascii?Q?8CmXX61IzCt7Ulk32kANxwSU3j/RrZiqaUI9xOm0JsaJfLnv1ksPUM5LKGFi?=
 =?us-ascii?Q?qqbsHN67a0mheXUnPgFDqXYB4eBWCnTYBPA4NsBqJHGxkdCvJLnN4TjuwKbv?=
 =?us-ascii?Q?m3lphqQXD6nghLeUo9Ad8x3O52jEGGz0/uDeGsDJrbmtd4XpNq8z8MxJikoP?=
 =?us-ascii?Q?k9ey2hkgJt2XNqKyPi8neXF455Rf0PdRdTV3QFyrkVMIugUMylhKky5ol5Tx?=
 =?us-ascii?Q?FLSE2vVy+1glTm+zhpG75vpq7WUnsyxVK0RGyianSBWqplSku3MXcGHqiYq9?=
 =?us-ascii?Q?uoJs1HEWqeu0na5QztN8cV9qgLt6ChwooQgp3OuOyb5t4jWF/kMmnHyIQge1?=
 =?us-ascii?Q?QhyAdNKVjKhreNCptGpP6o+jYQ01Iq/GzQ0uYwzE29B1DJfUsq0xx3tYj7JJ?=
 =?us-ascii?Q?wib+OVSdTja1hPdedSZ35KEtkg151Nohta4erMktdfxRsp73w3FgB9zrLMqy?=
 =?us-ascii?Q?tQTKGfziTtfEkKSzHuiE4VSqOyPLIa3x9m6R0Kzt/98Q/gZYhQkA0EoON2hg?=
 =?us-ascii?Q?zbau11Q2OLyMojb7oN++B3MIpxRDOqGP+7giiBOvYYb6JoNO5e7FC+dC2QGT?=
 =?us-ascii?Q?/RpqoqWeL7T7suGT44w7FuvnRszeq+MOpg/FaHrrHCrd37S4I1yKRNoU416x?=
 =?us-ascii?Q?X/jW6q0jZMiiI2ePHiXJ9fS3nKXGRTagqacJ6V7Npd7d0A4JkffVKAYImjlb?=
 =?us-ascii?Q?6/qrMsL6xore/wPq00uJkjwUHzO1Vt+KTUWpqH13KtI5Hi3gBjs6Pk56PPWZ?=
 =?us-ascii?Q?LLdp7M1UX2FGW5+TMPRlZPCK4hw50vwZdPuNZCm0kZ7z5dPp2npe0bWAoJ3V?=
 =?us-ascii?Q?TJt1ME1Sddnv4YLnjYEsCqeOdSjSeWMf9QFhLEOEEzhyp4COPcf2JM09KMp9?=
 =?us-ascii?Q?rMw59IjDR4TdQtd4jeQlKUhrHtqkYqYwnmfPhbHT9UwZ41l8ilT2jnQ5ecjN?=
 =?us-ascii?Q?/A023rHgaKFgWunYm3oME4ym7WkuX1VhIzu74HBgxYCLU5v4ug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QQnTghB3DUFvIswbJMAtdbOQE5G8xqVglb+H/ZHD3+n53GpOtU11Rvpmex9B?=
 =?us-ascii?Q?A4D9tZoEYqmznVNXymfa1vNd61Ny0POMhdQV6KFLcInMuE8Z9vKU95HqvE9+?=
 =?us-ascii?Q?QDu+KMZtMyyvwzxRjSIjblKTgnW5BbdR3p2+Pnu0zOLZOjkRzt4m1R13N8M5?=
 =?us-ascii?Q?uUQOhxSpN2myOA4RGIB958s7V/63D1QDbCmAq83ZVvkqzg/xoqbSg2hFM/ye?=
 =?us-ascii?Q?i5mWOmD3tJ+n+Ms3IGGbPWZQi7LY/xqkD2kuuF1coKsuyFwXH78wl5R+nc2g?=
 =?us-ascii?Q?lDnmc3fauK6rmbk3XqyiGGT6HdBJU4qQ6ShLiyxKVPOlVlUhyJ9APV7l73em?=
 =?us-ascii?Q?+gPvFkNscF8qC6LGEPYrIjXE++Uuvzk4+c3tPSQhcs0n9nUtfWLfL06kLC0q?=
 =?us-ascii?Q?QdQhYPTEfy2sT2ny6DFFBF/Z1ScfVZw9hH8Omm0o93YW4LYutB/7sYmL5/2Q?=
 =?us-ascii?Q?AdzaZmyCJbjeFEVMEJS3+zkDeKvk10o7y9jGNl3Om/6UtLUM4IIXUxgqVgjo?=
 =?us-ascii?Q?uD9jOkH0VxKND39HhMv4qXfjMzzBLISBUFZmy0XnHcQDvQRCYUaX2xFlJ0oO?=
 =?us-ascii?Q?oHtMPOUzpXffD8X4Mx1u7gsndjYUkwmswBouk8JDOwKGeV+0GjrLXOiVuk9F?=
 =?us-ascii?Q?uG2xjMdFVTSBfHFX4khpC2xjQjAUAofxwZw5faW30ehGTZiJcAIfwvD663ZF?=
 =?us-ascii?Q?GFl9J2DbrV2D29QLZP+x/5WOznXFOZ/2AN1rsGBqAo0g7GcT+qe7RPJKbApn?=
 =?us-ascii?Q?YXfeEB4X+27ICxjvcAxIbazlnzXgMsJPsiYAYauNAiVTE9SDwosyN2DGBT0/?=
 =?us-ascii?Q?sEfd8Lt6z5awTPWEJ7lG9ovIhrW8V/an4X39526La/+VGmoyUu6Zg5SB5D5r?=
 =?us-ascii?Q?Kb4DUgxB1E/l/I7faYQYHkCjElc11r3Iwb5EZFdWXKHNPdrX9P2L8fPBF29+?=
 =?us-ascii?Q?hhUyQBA4q7lAQk8KMkface2RT4n1FDBOJJacJrvwjdLmFnZw8Avnaw3Wwf8c?=
 =?us-ascii?Q?hEZjBL7d8P3nvPBZR/+UGQFPEpW9CkT8iTEEnKzIAF2giC+jaAhbjIpVKnmd?=
 =?us-ascii?Q?7XyOV4kH/IqCyO0LJpvjKPWJYDE0XjTaYb8qEWiUEc/jxWjFVtW9k/Uj9CsJ?=
 =?us-ascii?Q?c/eXRRexlI6facVXQ08073Q5zwHXYmCKgUZ984FEM6bBiZ9rZoCvvd+PAbg8?=
 =?us-ascii?Q?rIMDHfu+kTMIN+vO3oPN28pelgiVJf1ncwUYCedhMMKpwmye4Iin3pSbyWLK?=
 =?us-ascii?Q?kBOVmln5Aojb4iHWRWm32F+io+zEaOoB7RJCQ1RVOS/36tRgRIHQ9Q8Ty2cb?=
 =?us-ascii?Q?jF9k02nu6sQPCK3GwIu8XgDEoMvvOcz1uPB0FMLhA981rDB/0ZPCEPzDNhzL?=
 =?us-ascii?Q?isfJ12XQMD/b0WlxhxwblxrpAWqoszyVTLloG0qkxR7B2f08lJBeQLc8fIhE?=
 =?us-ascii?Q?tV+i5mTnVNmNSPJ2UL6WHNqoSBOc/OcnS8hCt7tRlwTaHkefJAKksdL+PKSW?=
 =?us-ascii?Q?cJ+8lfH6gT/NvuuzRBekWPBLjU7KNPqNIqigv0BZfps+imNGJrb1hPRA0N9E?=
 =?us-ascii?Q?4Vd/jHm0q+6KoAJvrvshbjCcd5tev7POf4dysdMm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccef6d7-0f03-47e0-cbd5-08dcd1419934
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 02:38:05.2736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDbwwWxzmfBn3FNCaIzpwZmqdyLAclvoV+nnP/T9l/UsM1Bnnyz80OMWQHx899ouO47OwlwnTFg0QHO2qEWj4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
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



> -----Original Message-----
> From: Stefan Weil <sw@weilnetz.de>
> Sent: Tuesday, September 10, 2024 4:43 AM
> To: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian <lizhijian@fujitsu.com=
>;
> Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org; Stefan Weil <sw@weilnetz.de>
> Subject: [PATCH] Fix calculation of minimum in colo_compare_tcp
>=20
> GitHub's CodeQL reports a critical error which is fixed by using the MIN
> macro:
>=20
>     Unsigned difference expression compared to zero
>=20
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Looks good to me.
Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Chen

> ---
>  net/colo-compare.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> c4ad0ab71f..39f90c4065 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -412,8 +412,7 @@ static void colo_compare_tcp(CompareState *s,
> Connection *conn)
>       * can ensure that the packet's payload is acknowledged by
>       * primary and secondary.
>      */
> -    uint32_t min_ack =3D conn->pack - conn->sack > 0 ?
> -                       conn->sack : conn->pack;
> +    uint32_t min_ack =3D MIN(conn->pack, conn->sack);
>=20
>  pri:
>      if (g_queue_is_empty(&conn->primary_list)) {
> --
> 2.39.3 (Apple Git-146)


