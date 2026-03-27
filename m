Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65F210BA431
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 06:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w619V-0000Y0-6X; Fri, 27 Mar 2026 02:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w619T-0000XQ-Fv
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 02:58:39 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w619R-0000Az-6S
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 02:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774594717; x=1806130717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R5RwDmg3WImh9eX704sR30eME/BgJ9/P+iByxFhblFQ=;
 b=Frc6r3uVgEk6EyY+K1k0bA684eGMV5k6XiI8554rzLJNdGvbXH+ymDUh
 FAupNm3q6eaIJ2/V5rFQFvW5YVW1O+V2YfGcUyfgx9fwHVdZDW08jagKs
 DhQkOE1msdNsU1PgWqCLemGHN7diyKNNdvoWe/Nn3iZ1jxCbcw2gRrjqZ
 t9LW9gAnSncU45b6cmB5Ds8yVa425Y3trkv2f/uvASoTQ8i9I48N5uDq9
 +Yg7rsJoKoxtAJ060sVyce09OStUiyJO+EuQfDqgdazBACHcHTx/wWUgx
 N7E3Wud++3u9P3UOPuMn8HnCc1hsthzFjDeUcI4htsl2vktX1B2WldCi9 w==;
X-CSE-ConnectionGUID: sLOTUAUkSCeAxmd1HSt8pg==
X-CSE-MsgGUID: /mKsHD1TRme+qbSQDlLG5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75685328"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75685328"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 23:58:34 -0700
X-CSE-ConnectionGUID: SeHxWVs8Rfep8q3ju7MG4A==
X-CSE-MsgGUID: LlfmNAayQC6YV1q3mFp63w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="248276040"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 23:58:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 23:58:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 23:58:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 23:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH6cMqtNPr09xgstvIwrzRRlsr2LM6GrsEbbRlE7JvHHUOWq4zncXCEwuveaL7uiooIUimraGWqrfi/qYzYspjCi14rB1xuiD/+vFaSz6nlsX30i/RgSVIDmM7iURSwrIvVTqTrzUmMNd0NVSwdn9J2n+RqfhcMOma5CAkWUJ8yV47jJGwPTPMiJ3Of5ZZnfFJDJ7DF3XVS8tzTyc5pZytfTaGH4pHSpz3Vf2ROnHbNdhRkEKgY61sXWBhos1ELbKn6qOcsHe+UDsClLbp6pbmHblHVPgNV/IAY8oiAEFEl1Gg0fmonHAd8jSux3g5eZj/IR5HgzJa53x9rUTHUe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+se+GjsbBLJO2fMBvwRiYCG31SXMyRcg7yYGcVsBn8=;
 b=NvuxsP9urkH63QnoLhryTxYZRwM9v2StW0T9ZDEwReEVuVzkRZVSB4SyXHawsbvvsJ+f6VKviu4U4zjI+iNtQXw66dDtjJ5f2PnlkUeKCMAIjeyQhqLZvcHx8X3RfrQW3iQExrNI8QFpEFGEfYQIm0QeAQ4/8XSPqlGKLpIKM4LGwsyF11xye6ohfgykybYouzuQpBcN9/96G4vrPpZKcWYhyvopRxPJXr9r1durHittvCjmd6XlcxZTudOG1NTt57axYiDxdkv87zTeEzcYPDxxmYW9fUF6DDHbuSjd+ykTFKBBq/2dPv5agn1n5POiO5EPgzT+K3XBARx8IwkSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 06:58:30 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 06:58:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, 
 Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHcvQCbcM1XVclbJU+X+K8SR/ZCtrXBbNSAgAA6gOCAAB2JAIAALwdA
Date: Fri, 27 Mar 2026 06:58:29 +0000
Message-ID: <IA3PR11MB91368BBB600C0694870CAADE9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-4-zhenzhong.duan@intel.com>
 <acW5AXhPDT+wZ2qf@nvidia.com>
 <IA3PR11MB9136D7618C06EFF1D66561549257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <acYC2ko1r8OkAvq0@nvidia.com>
In-Reply-To: <acYC2ko1r8OkAvq0@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB6478:EE_
x-ms-office365-filtering-correlation-id: 210bc612-9d1a-494c-e449-08de8bce40d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: qraypzuTnhj0wNeYEkiG4JmLoHXLj7MSZiMjDFHumfHiLexO5lcx3YFtLHhdqwCsaQPS8F4Gm6vnuYAFmPhpr6g3AFUVk7ifWgEu/BdNNuSkCNw+CISiW8zRsQY9qniSImj5LV4ZR5j5Oy6i9Zulz1/lFzogVZ0No+ZD5qBANVtI8DXiZH944UlKy/idaOXp/BY0iJi/rdVCfncwAdo93KEC6jSTk73zxKs57a2D/8r1YanZMKyOLnCveNQt9s0vlja/+1jZ41/UTrxYywxBK4pvCEXp6qICCSdqoUVkE9JQAsw6iPYkeZprl5BdAFGc7kJ2JetumcOczdJff5lAgoP69LrDHYIwOHufnQp2k9Wob5x4rQnI25BxNEiOySme52Bq4AygoL/rE/rFbZnxgNhdmYRiKPQO2YexPI/HVfU/9c10Fe3rky/jdI+ISNUyNqS1eLpH2vlS63KVkP3V+NkEc8BW7KKw//GrmqCFOOacpLhc3ZIDJCRLtKhLm8oUajKpJ9dOpkdyiq5/QiUjGXP33ppNXuyTb191nY2FPCHNlmcTUPlaV9DODHzY4V1bVFS58PjpOYjxRxp9CjJcgrlp9dnjuuhT+HzxmUlC+5ZOfTXzBm/84xSw+RpnmbyBAP/UcVc1IiszN7ZiesZSWxlCEBU4lO2tmpDhNJf4fEw50omROuYvcF0or+raFPQdvIYAgxeSmenLdH8DoeBA2HW0PrjyottP79p0yFJ+fWkacgcbNyQ2O4z7zAvul5fhhHeM10bHbxkd/nIrANu/IBg0pNcLaPoVQpLl4Mtdvno=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cL1fpku+XYGsW+v7N+A5Ygn/+ZZi69g3jGuOPU6TbMCyMOp68DrrZVrGdM1N?=
 =?us-ascii?Q?t+s8Ittj6Tq1fOUfHdcxwF6iCxXBXHDs4sB4DyESo+HcRJgdbtg0wYmaGEMH?=
 =?us-ascii?Q?MsXIRdoArjyHitPiZoorDNtuOqODuF3SDfdA6OBAxVXXeZZXcelkukcTGmij?=
 =?us-ascii?Q?2LDcIe2sYgZH9+3Qi6e159k9LWdlfUuYjPiH4+uUcVpmTdv4HYDd1IUnXX02?=
 =?us-ascii?Q?grYwVVYjeGBTj3dmxpxoOX0diY910A7oejdTG8zrsBZjJnOMnzUd+Et5fAYm?=
 =?us-ascii?Q?Oif1Sl8mmXTDHMDfV5UwE0d4blsMGyn6kOZSyQo/1btoMSg+Sxl5KQvBuo7A?=
 =?us-ascii?Q?G81WAhDpeX9mgeaIG8DYaW/Lsb4AzAzqFFuLw3QEmHNEB55yHHK8Dr8DQ6eh?=
 =?us-ascii?Q?YApdedrbcQZi9675UanrvLy/y6KP9D6wpUFWavWKGSz8vb6N6At5kvdN97Mw?=
 =?us-ascii?Q?xJwD2ad5b3ehCMM5mVCjuQG0NX8I7biYgIMrXErSFgioUnJFPNq88L0zcv5r?=
 =?us-ascii?Q?XR0PXK6SyIvUqWGZNZ6XlngzXYV+st7jPRh9rtE2cfzfPI7ar9uy0zaxn9sg?=
 =?us-ascii?Q?XpnNQNf+fQqSHeJe2eR+7gF6D7OPCqnWKjM9cEJBXdGExUunSNMgNsEABula?=
 =?us-ascii?Q?Sr3j5A+b/Mi3XFayUqukvlRfx7YBEj5Pk1wmB8dB64xBFfFokJkOI2ohqZ6u?=
 =?us-ascii?Q?+Q+17mMwMGuu8E/fehSYvRjNSvQQjbNMHePKGHrIkSg5AQXEqIWuVb1dcU+X?=
 =?us-ascii?Q?ouOpVbYGPi5pbwnhoz2TPn4o4M6slhf3+yiK4GFL6uv0NkhzbJB89ee8nmBf?=
 =?us-ascii?Q?4WSMcIPoyHVyg6uch2rrKkf5M3WD7M6SDVsxTVXzP1AJXfS4AU9CDTSBMN3M?=
 =?us-ascii?Q?LwrIt7R9xzAEStJ9Ll74j1AAWPscaYzy5YudmeTyHGAE/gUhy9nKRVjYjzBn?=
 =?us-ascii?Q?BppUZn7KoovdzHVtPyo07b+h73+zaqhSSgNA3on7f9NCxAWKvWI6H2/GB+pR?=
 =?us-ascii?Q?LWPyEOUMVUMc8Hk/RaQAISduFtPMutcEhIzxLZU1fxkJYVet5RbmKWCMDaJg?=
 =?us-ascii?Q?DS3Dz023Rs8v6kMdgzc1WRN90G3rEPgs3Uf1Wf29ps4qy6ik3gYhXCalrOU2?=
 =?us-ascii?Q?xn9jbt4x5A1U8Tg7/FXrd/XA12vPjBl3dSIjhU/uYHVsXTPomAUtGugJXLBD?=
 =?us-ascii?Q?/IHQ4RqM/Ll81WIDpHPrzT3yJk7/8fPtn9+KjWtIhWlXU4rd4izk/dFztBL4?=
 =?us-ascii?Q?Gnl+iW+OwVM0nnxHqIhOTrZRqGhi6MOzwzdZLVOH0ZH5jxYgZXeF7gRayeTn?=
 =?us-ascii?Q?U/QOTFQVYF9A6TL/nIbQgNPu5Ilz/g3S6lw15a9DeqasE44pPcNGFQg7BSfy?=
 =?us-ascii?Q?j/qGZPt2M4KHAQ2AmSEV0L2ucTQJYrkVAo0YeK6jbZc77G+WMQflM832GUaZ?=
 =?us-ascii?Q?aHMxdb22e7VP3SLC+YRpn16FOfp7YeI1SI5lUMT3tFHxCRSXPxjgVmk1ihIM?=
 =?us-ascii?Q?obEBiGi2AhV8H/gPH2q1Yi5g+8KUYtH3xJpdcFC/TNLT14az7gIt3H+cFRor?=
 =?us-ascii?Q?SPCmu7EcAUESq/7GTbjIypsQO1SH+A8nHUWCVRhnO2aG4RfbHBI8S9iBeI++?=
 =?us-ascii?Q?EvXhhJ5Ll3eVBJbnxsIZW0ADF1MirQa4gx2LB7B5PujsQf0q8N8aWjcW5q7q?=
 =?us-ascii?Q?PzAwmQbuOCVtUpw+v2RX8dplhjYhg85VNQFmrFEGowvN27vlPht0yODNlRP6?=
 =?us-ascii?Q?FtNij3cu1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ip4KIuOW1ETZN2V3a6MPsXDbk/w2BBIK6GZTJ0WqTZdHF1DtkGHwsjc3j0YeKsXXAsjHOs7h1tlxnecee0YLf6IlQyAcJ28UmDKbr9m8zheXQ2rJKq1o6yXI9p3Z5lZ6zzhrXmrJEcM2An739c3iGSig1VGJrYJhM1DVhy7bhtr6B2oguvUx2jAZFIdFj2RImzTFVAMYCZQnFNInUGdl9Ju4DYs5sd6IdVIjJrdNRXENVd+clW1ofAOOdoTfm4q1Y2QR/zR+JOAcClY9z73YpAIoOfCIKjjfeNn6YxxU+EREjTpBoTEU4hlcakE3jGsLZmtP/fINtYDy1k6srDddyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210bc612-9d1a-494c-e449-08de8bce40d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 06:58:29.9923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeljqFfnYQAWqVyyL4S9RgW77paYZnp7aSv9gAqoy3UuWTH/GagM5mORCKtHZ00+UJF/EVQzQGUni3wvTltWKxKiBa1wZ/rvycugJeHhsAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt wit=
h
>IOMMU_HWPT_ALLOC_PASID flag
>
>On Fri, Mar 27, 2026 at 02:29:20AM +0000, Duan, Zhenzhong wrote:
>> >-----Original Message-----
>> >From: Nicolin Chen <nicolinc@nvidia.com>
>> >Subject: Re: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt =
with
>> >IOMMU_HWPT_ALLOC_PASID flag
>> >
>> >On Thu, Mar 26, 2026 at 05:11:17AM -0400, Zhenzhong Duan wrote:
>> >> @@ -430,6 +431,11 @@ static bool
>> >iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> >>          }
>> >>      }
>> >>
>> >> +    if (max_pasid_log2 &&
>> >> +        vfio_device_get_viommu_flags_pasid_supported(vbasedev)) {
>> >> +        flags |=3D IOMMU_HWPT_ALLOC_PASID;
>> >> +    }
>> >
>> >This would set it to:
>> >	IOMMU_HWPT_ALLOC_PASID | IOMMU_HWPT_ALLOC_NEST_PARENT
>> >which isn't supported on ARM :-/
>>
>> I am a bit confused, if smmu supports dirty tracking, flags would be
>> set to IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>IOMMU_HWPT_ALLOC_NEST_PARENT,
>> in arm_smmu_domain_alloc_paging_flags(), I see it will return -EOPNOTSUP=
P.
>> So how did smmu work in this case?
>
>You hit a point. I almost forgot we need to do something with that
>dirty tracking flag. This is currently broken..
>
>For NVIDIA, the current generation Grace CPU doesn't support dirty
>tracking. So, our QEMU VMs don't set that flag. This is just lucky
>for us. Yet, it would trigger -EOPNOTSUPP on ARM CPU that supports,
>as you mentioned.
>
>For pasid attachment however, ARM doesn't need it: regular pasid=3D0
>attach already has the pointer to a stage-1 PASID table.

Clear, will add VIOMMU_FLAG_WANT_PASID_ATTACH and check it instead.

Thanks
Zhenzhong

