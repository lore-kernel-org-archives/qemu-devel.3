Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821DFFD460E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 03:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvSCF-0000XP-91; Wed, 25 Feb 2026 22:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvSCE-0000XH-B2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:37:50 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvSCB-0000f0-RG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772077068; x=1803613068;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=mzbROBTGqhSbLaDbV303+dm3EeQn04IvCjZzrMJft20=;
 b=QxVGH04xuO1MgKyDpdo6gVvxWhDCXv3owdREXuZNJ0ySsvCSYZeMPeeA
 FVqVh8GyuPx57hjKCXb6Ju4oOTLwPP02z/qFXjGil0uhADcq3WQ+7RJ1E
 23PwUdpo+u96tA/Lf4xS8e7MYG8bSOWzMXotE+5Cb1hfMO4iPP1Ib8xLW
 TrJIIeGFt9nyqklUeV0qOESGrSKNGIUlQp1rLrJlJRgQy2fCjxq065xkb
 Es5hb4fydiJtffhmi/q8wfEXGUWNL7hgiZOUZ9gB7YkfnJGn737XhLSo7
 WnmU0thCTJ0I/GG8et+qArgN7doOBRAa/PJoYqvhbGJpNACcgU2gW+hsA w==;
X-CSE-ConnectionGUID: KATuHdaqSFCyIqW07qD5Qw==
X-CSE-MsgGUID: wSiMco14T6G5DGTpWl7C5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73105916"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208,217";a="73105916"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:37:46 -0800
X-CSE-ConnectionGUID: HyyLP33AQdud71BaTDZJfg==
X-CSE-MsgGUID: xDSdiuhCR6OPqJnotD16GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
 d="scan'208,217";a="221412868"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:37:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 19:37:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 19:37:45 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 19:37:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iu4CPTE39gi2Ib3Em/uiXxh6Phh5KecHkOez58rpiHM1HxixAIFUofVP8ycMOJL0I4fimvPVGRIXSKiHZDiEMCxTb17YWmpOlJawAds4K/AKGSUokRs5GEXqC5n2OROn9JD3fwljvnKCVFjDA7aghKgphXVFa2A5smzpw+rE8eWjBJeE4//8URdARby4I2kuM9j8jt8/fEEuCE5xizxDFlfWpriyFOCvcGmOpb5wIlQoDDhpUt04wIwVto+ABXD2ytzd9ZnUHVj4lJB838M0O7IwVcpthvXwDM3NnywRmNJrV7tzw/4mTBRe/IFYh/3mHB8013QIY6d8rIQEit5VLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yOtyWlcAksKn5Y72vWo/LkUo9ECbW/EBtI7MJz9nS8=;
 b=pbTfTHwT8HGbFkiHY9CO5AUi+qh6QO5bQi1u944l+MF+T/vTzWmYOUf86QDLLEQs1UEEnc6GaeevJa2CQ2lqbs7Sw3sejlv4E+n5lX3z50vjNQmw1bEEYd6p6BJNm+xm/C/K2E4UqXt0IU/AIjKgsFSYaugggdOtwQsWi9StJN3z86F0jfVcevSm4RlGDAsK2fqdV5j7qjo3EGj2hG+vJ7CrFlOo3talg0+ALjTarquJZEivktsmGGs014r6ma6dDbk+VSpf9LVmbmosXh+xfMTvOjq63FnICEwSpBTDd7hTnAOGtCk5R7WNVBwiTHOnnf0NXLm/QLDVWANOoLmMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 03:37:41 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:37:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcnWP6tyKy+zgBK0aBvE2Kf1JwJ7WTCNiAgAFesyA=
Date: Thu, 26 Feb 2026 03:37:41 +0000
Message-ID: <IA3PR11MB9136245DC6D58206EC54E2C09272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
 <AM8PR07MB7602F76D7799033FFCB1A5608675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
In-Reply-To: <AM8PR07MB7602F76D7799033FFCB1A5608675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-25T06:41:23.127Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6546:EE_
x-ms-office365-filtering-correlation-id: 671271a3-6028-4f42-bba9-08de74e86557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|8096899003|7053199007|18082099003;
x-microsoft-antispam-message-info: qhxEmGhmclQcdsupZRKt/QP566sm9QodusxKOOAsx5ku1/q5qilWF81GGizL2U+7OVfXP0zqdFO9wMjXsXidngyNQ1+gAbUKNDlMrZGOBgpPJZ6pa+MFBa9VTFTU+wHaEaJ8wI463KG3lxc6b1ePrcivh0VVrs14lijMUUcvajH64WzrgJSwIpRHQ5U9jnLAUCPrD124bVmJGe9ybKwb9OEYvZP+VXIs1AEfjF9Zueboul+4J+iC8R9Vrj3zvqPCrNHHFsq4GLOGroshzyVaPlF4X2DDIdmdO+BBSe6hUdo1ApwqaCbl78aalwpx1AV9XHAMSaoEsGNihXnDG5zEeP4dyDd2lg1d8S9f99EW2Gk3uowyrNi5KNjTWPsJBWoZy3i7HG++rd7/H0ce/zpDPwJeeZ8jAN3ooG/KT5uTyz/XlN564hGuEH5lErNK/hI+wH1QAvqWHdF6svltvirfFAOomCp1UtLvUZeDru3PfX8fzDFsWcrbC+G+GcSjXIlQdR8cSx/X9TrqPj/KmsZvSoP1kLpMs+NJeFgT65S7povOVSeUhhoq6szBoczDELmBz/kA0rIHdsLoVtAdLL/iSyhD8XBOssZd2dyoKmh/FJpRql/I3iEZPiI8I4sgI3QlgWg6cB0xPMc2/ngM3iEzpspxC9xWW9+aXX+IB/gVdFUcLK4mCdoYIjHuZsbEFim8HjjoiGGLWaFBUFOm73lnZeh43zwl3k3TMZ/OCmkcN7HvtEIyuqZ5kd8amJyKEom8Ag2Ls6sAmupTs0kZ2Ov87IASwE/zD9RZXgqX+2SMX/I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007)(18082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tBpicE6wQE3JLLG6MWCqZzl0J9XSlIxM9nfegfapqNRVTYpyh4YLbwHO06pA?=
 =?us-ascii?Q?EXUr410LPnAGcvnPwlRkKLQom46MfB+X0insTbNwE+d588bfMlkWRG11bjgs?=
 =?us-ascii?Q?Bk3jb/erXHzF/aSVvpwbY1QeMzY2t+H3hrZCdtMqxN3QWpf2OFKN39V+4t/M?=
 =?us-ascii?Q?bDour8ALpuwe3Mkkpz7zz2IGxPpBpmC7UJ2ST/dFNmVdjg/XYtVHO1dDwL4V?=
 =?us-ascii?Q?1+oEx0zuhohKAgUIe/H+fb/WI5F1lHJ1oFYcN1iNGi/dlwyHHURBrBZdg3dY?=
 =?us-ascii?Q?nU0GQvJaqLf/Vz9vrcEcOaV++g5xNY0i05CFopuIaBx4HLcOKOL+8nVdwNz5?=
 =?us-ascii?Q?KbVqtOqIIQR+GAOyOgecUlDplCEgODAKOvdAuvUlNBetmUd1Jy/Whjesa1PP?=
 =?us-ascii?Q?5AwuJUnPfdaew/zy5eTiNREb+r0OT0NwDTYPy4b5trxPfuIsbG6MDQECSZX3?=
 =?us-ascii?Q?gT3CxEEEh1row/4GUheA270rnjJDDkLz8UD4mvTmTdMD7XDj9CFGt4Uvu65D?=
 =?us-ascii?Q?CpvoRrkZfWyUmvmDh0/7T310BMPzOzHAQSD8DahkgeiZUC/YKur1xnqcX3d6?=
 =?us-ascii?Q?d93NveUFN+y1NNEI2FxXBFfxZ+K3JinW1yWozvs+D4K3NbKr0GHKlXQM5tgt?=
 =?us-ascii?Q?0D6xNm11GueqPTiPz7cevYzWmiBfkyaCXjDbsgAyL1T9ZE4ECvHQaQqXX80s?=
 =?us-ascii?Q?pahboInl/q8v+ZbMQY3Gd2mYelhjGKgp36p+pIAQMxelFraZ9IPBJvv4p7rg?=
 =?us-ascii?Q?9DGWHQvfkWqLj7nu7pN+R6WOA5NaE2sclrJEwb+OrcGRLYOHRIuui+Nt0bu5?=
 =?us-ascii?Q?NmGmUuqD/uMiO+eCHsANBdFjCFWRQZKwJ98iop38C+Js/6MY8KcGWDzY1ohu?=
 =?us-ascii?Q?kwe+T4fT43Pnmaoj6TvyY3XSoLSXXg2GZ5F6ZJe2ckORNCsDT3TDT1MH1Bes?=
 =?us-ascii?Q?vDbWig/F50t+Z0ahKF2H1ao3P+reX467dxLSFMtJSQPMCz0PR8APSDV/2IJ5?=
 =?us-ascii?Q?JT41O2L1Fi0MlbgpPn1zbBbVk1FkjZIhhMa3d+Q9jgpJhd+nziusbarq8KnI?=
 =?us-ascii?Q?5USnIjMZ0uBUzXx6zXV5hMISqXAzyXOSYJ2EScLgH3dMdBPyCPo0uA4Q1ywt?=
 =?us-ascii?Q?dYPIRKgE4bLakj3/1PqziH/5jK5Je8MfWEX0PCiaMD90pGfckcSGftVWgCZz?=
 =?us-ascii?Q?Mc0qOXjvjRBhBmwEKZmLgLET4GykVnjA82uGkNSP4mOXz7KdfLC1p3XdRXAr?=
 =?us-ascii?Q?FHiD1laoMskgmYE+i4Y6cCN6MVFPW/lQ+xTCNxDUc/jzwjqMeUhfRSFI1Ijc?=
 =?us-ascii?Q?56IKtslhL312rW3mLFSZOdrKmIIHgOsSBw+rEhxLoCOXxCIuORfOeDtxpC7h?=
 =?us-ascii?Q?SE0ObxDTnly00Y8faHAaeDW0rwg/sT0zpdUY9RKh1DOYdKy7AUpURULLBUAn?=
 =?us-ascii?Q?r/2/myez5hazEmg3bHdq6kVs+xKOeOX403dS/yKHFSv/Jxcjg3gQiNF+J5Er?=
 =?us-ascii?Q?fOatZfvrjq4Dzbr3tsY49cMUXp3AK+r04KXJLss34bFLulRBvCFUhhxcIjvC?=
 =?us-ascii?Q?k6s8pDg5JOGiLVN8zw4wqAi2Z1SRsPSLrqyGIgmNM6C89/CichupoqHnHpND?=
 =?us-ascii?Q?P37aPaDDotaQ0bJMG8SYZ7VEcw5iu8bIl+L+C8BIrpNwQ+St2p4+oRCQdOeQ?=
 =?us-ascii?Q?P6Gcy1T93fJjMA9MhCqSsWrm+JBHlBMoI4X/b6VkFIbbgfTtkrDh8SSERHVc?=
 =?us-ascii?Q?4eRxAZgBKg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB9136245DC6D58206EC54E2C09272AIA3PR11MB9136namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671271a3-6028-4f42-bba9-08de74e86557
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 03:37:41.4616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeXQFAsNn57r6a5KZlyHBX3O8GhLY8fcwLa89ry363mzAv7GpHaYP+2EjeXtXfeB86V6jEqwHvbC8JKcDhsF1CQV/piKvQstoE3MIteRTNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_IA3PR11MB9136245DC6D58206EC54E2C09272AIA3PR11MB9136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Clement,

Exactly, copied from PCIe spec:

Max PASID Width - Indicates the width of the PASID field supported by an ap=
plicable Endpoint Function. The value n indicates support for PASID values =
0 through 2n -1 (inclusive). The value 0 indicates support for a single PAS=
ID (0). The value 20 indicates support for all PASID values (20 bits). This=
 field must be between 0 and 20 (inclusive)

BRs,
Zhenzhong

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Wednesday, February 25, 2026 2:42 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@redhat.com=
; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothumtho@nv=
idia.com; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Li=
u, Yi L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck

Hi Zhenzhong,

Why do we capitalize the first letter of each word in "Max PASID Width"?
I guess you try to match the pcie spec, but just want to confirm :)

cmd

________________________________
From: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.=
com>>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> <qemu-devel@nongnu.=
org<mailto:qemu-devel@nongnu.org>>
Cc: alex@shazbot.org<mailto:alex@shazbot.org> <alex@shazbot.org<mailto:alex=
@shazbot.org>>; clg@redhat.com<mailto:clg@redhat.com> <clg@redhat.com<mailt=
o:clg@redhat.com>>; eric.auger@redhat.com<mailto:eric.auger@redhat.com> <er=
ic.auger@redhat.com<mailto:eric.auger@redhat.com>>; mst@redhat.com<mailto:m=
st@redhat.com> <mst@redhat.com<mailto:mst@redhat.com>>; jasowang@redhat.com=
<mailto:jasowang@redhat.com> <jasowang@redhat.com<mailto:jasowang@redhat.co=
m>>; jgg@nvidia.com<mailto:jgg@nvidia.com> <jgg@nvidia.com<mailto:jgg@nvidi=
a.com>>; nicolinc@nvidia.com<mailto:nicolinc@nvidia.com> <nicolinc@nvidia.c=
om<mailto:nicolinc@nvidia.com>>; skolothumtho@nvidia.com<mailto:skolothumth=
o@nvidia.com> <skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>>; jo=
ao.m.martins@oracle.com<mailto:joao.m.martins@oracle.com> <joao.m.martins@o=
racle.com<mailto:joao.m.martins@oracle.com>>; CLEMENT MATHIEU--DRIF <clemen=
t.mathieu--drif@eviden.com<mailto:clement.mathieu--drif@eviden.com>>; kevin=
.tian@intel.com<mailto:kevin.tian@intel.com> <kevin.tian@intel.com<mailto:k=
evin.tian@intel.com>>; yi.l.liu@intel.com<mailto:yi.l.liu@intel.com> <yi.l.=
liu@intel.com<mailto:yi.l.liu@intel.com>>; xudong.hao@intel.com<mailto:xudo=
ng.hao@intel.com> <xudong.hao@intel.com<mailto:xudong.hao@intel.com>>; Zhen=
zhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.com>>
Subject: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Pasid bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.du=
an@intel.com>>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e4bcc884b0..e5518a94ea 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
+#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6483cb3d85..c1b31b17de 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
     }
+    if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowe=
d "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }

     if (s->svm) {
         if (!x86_iommu->dt_supported) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acb1b1e238..15412123d5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,
     HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
+    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus =3D vtd_hiod->bus;
     PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];

@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }

+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size =
%d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when x-flts=3Don");
--
2.47.3

--_000_IA3PR11MB9136245DC6D58206EC54E2C09272AIA3PR11MB9136namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Clement,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Exactly, copied from PCIe spec:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Max PASID Width - Indicates the width of the PASID f=
ield supported by an applicable Endpoint Function. The value n indicates su=
pport for PASID values 0 through 2n -1 (inclusive). The value 0 indicates s=
upport for a single PASID (0). The
 value 20 indicates support for all PASID values (20 bits). This field must=
 be between 0 and 20 (inclusive)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BRs,<o:p></o:p></p>
<p class=3D"MsoNormal">Zhenzhong<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> CLEMENT MATHIEU--DRIF &lt;clem=
ent.mathieu--drif@eviden.com&gt;
<br>
<b>Sent:</b> Wednesday, February 25, 2026 2:42 PM<br>
<b>To:</b> Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;; qemu-devel@non=
gnu.org<br>
<b>Cc:</b> alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@red=
hat.com; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothu=
mtho@nvidia.com; joao.m.martins@oracle.com; Tian, Kevin &lt;kevin.tian@inte=
l.com&gt;; Liu, Yi L &lt;yi.l.liu@intel.com&gt;;
 Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b> Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits s=
ize check<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Zhenzhong,<o:p></o:p>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Why do we capitalize the=
 first letter of each word in &quot;Max PASID Width&quot;?<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">I guess you try to match=
 the pcie spec, but just want to confirm :)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">cmd<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;Z=
henzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.dua=
n@intel.com</a>&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.=
org</a> &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org<=
/a>&gt;<br>
<b>Cc:</b>&nbsp;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a> &l=
t;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a>&gt;;
<a href=3D"mailto:clg@redhat.com">clg@redhat.com</a> &lt;<a href=3D"mailto:=
clg@redhat.com">clg@redhat.com</a>&gt;;
<a href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a> &lt;<a h=
ref=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a>&gt;;
<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a> &lt;<a href=3D"mailto:=
mst@redhat.com">mst@redhat.com</a>&gt;;
<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a> &lt;<a href=
=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;;
<a href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a> &lt;<a href=3D"mailto:=
jgg@nvidia.com">jgg@nvidia.com</a>&gt;;
<a href=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</a> &lt;<a href=
=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</a>&gt;;
<a href=3D"mailto:skolothumtho@nvidia.com">skolothumtho@nvidia.com</a> &lt;=
<a href=3D"mailto:skolothumtho@nvidia.com">skolothumtho@nvidia.com</a>&gt;;
<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com</a> =
&lt;<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com<=
/a>&gt;; CLEMENT MATHIEU--DRIF &lt;<a href=3D"mailto:clement.mathieu--drif@=
eviden.com">clement.mathieu--drif@eviden.com</a>&gt;;
<a href=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.com</a> &lt;<a hre=
f=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.com</a>&gt;;
<a href=3D"mailto:yi.l.liu@intel.com">yi.l.liu@intel.com</a> &lt;<a href=3D=
"mailto:yi.l.liu@intel.com">yi.l.liu@intel.com</a>&gt;;
<a href=3D"mailto:xudong.hao@intel.com">xudong.hao@intel.com</a> &lt;<a hre=
f=3D"mailto:xudong.hao@intel.com">xudong.hao@intel.com</a>&gt;; Zhenzhong D=
uan &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.duan@intel.co=
m</a>&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits =
size check<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Caution: External email. Do not open attachments or click links=
, unless this email comes from a known sender and you know the content is s=
afe.<br>
<br>
<br>
If pasid bits size is bigger than host side, host could fail to emulate<br>
all bindings in guest. Add a check to fail device plug early.<br>
<br>
Pasid bits size should also be no more than 20 bits according to PCI spec.<=
br>
<br>
Signed-off-by: Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.co=
m">zhenzhong.duan@intel.com</a>&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 +<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 5 +++++<br>
&nbsp;hw/i386/intel_iommu_accel.c&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&nbsp;3 files changed, 14 insertions(+)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index e4bcc884b0..e5518a94ea 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,6 +195,7 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
+#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 6483cb3d85..c1b31b17de 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Nee=
d to set scalable mode for PASID&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pasid &gt;=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID wi=
dth %d, exceed Max PASID Width&nbsp;%d allowed &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;in PCI spec&quot;, s-&gt;pasid, PC=
I_EXT_CAP_PASID_MAX_WIDTH);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;svm) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!x86_iommu-&gt;dt_supp=
orted) {<br>
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c<br>
index acb1b1e238..15412123d5 100644<br>
--- a/hw/i386/intel_iommu_accel.c<br>
+++ b/hw/i386/intel_iommu_accel.c<br>
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp; HostIOMMUDevice *hiod =3D vtd_hiod-&gt;hiod;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct HostIOMMUDeviceCaps *caps =3D &amp;hiod-&gt=
;caps;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_hw_info_vtd *vtd =3D &amp;caps-&gt;ve=
ndor_caps.vtd;<br>
+&nbsp;&nbsp;&nbsp; uint8_t hpasid =3D VTD_ECAP_PSS(vtd-&gt;ecap_reg) + 1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIBus *bus =3D vtd_hiod-&gt;bus;<br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIDevice *pdev =3D bus-&gt;devices[vtd_hiod-&gt;d=
evfn];<br>
<br>
@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /* Only do the check when host device support PASIDs */=
<br>
+&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp;&amp; s-&gt;pasid &gt;=
 hpasid) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID bi=
ts size %d &gt; host IOMMU PASID bits size %d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, hpasid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (pci_device_get_iommu_bus_devfn(pdev, &amp;bus,=
 NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Hos=
t device downstream to a PCI bridge is &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unsupported when x-flts=3Don&=
quot;);<br>
--<br>
2.47.3<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_IA3PR11MB9136245DC6D58206EC54E2C09272AIA3PR11MB9136namp_--

