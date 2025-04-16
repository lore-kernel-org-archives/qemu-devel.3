Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5CAC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4vk8-0003j4-TH; Wed, 16 Apr 2025 01:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4vk6-0003iT-FK
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 01:55:26 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4vk4-00012W-D5
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 01:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744782925; x=1776318925;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V9HF6POeD8XLPT+kFZSYNY2O1uHYyoC0NSnbeWAkiZk=;
 b=GnwPWhSK/tIlym8fnQP5i3/D6rB2+GiSN8MatBnsIulLFtdFB04TtxD3
 jzmo6aYgXPENwvu5jusRkTbXxWapzBsaca2hwfJ/myvpaFUyZLFu9Slan
 NajoXij/v0TuKudNiOVbg8XX9xgAzp9xLNWsRgkHGQshNByia1ZaZidc3
 IxLYr9MjNHCY/aUlIfSsJf0jkl1Ch0RmzITZXxn/zJJAr5L7x2JLVqYp8
 GwRKdjCw34TaK7UzXiOxRWVINDdcch+ssvt6Jm+uKVjJjKBM9IE5EC5Jk
 xiUKJlMrl8tvzSr2UKDAmHJMlrmScKr7euEPW6ewPf/l8Qav6CdLmDlny g==;
X-CSE-ConnectionGUID: S9FdeNWkQNSXz1SPB4KBrA==
X-CSE-MsgGUID: zRq6DRIFR9CcktLdlpkN4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46477806"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="46477806"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 22:55:22 -0700
X-CSE-ConnectionGUID: rfRMyFjJRjKQtVDibpkmzw==
X-CSE-MsgGUID: pR8SohzOT3m7kLYgucpyaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="135174494"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 22:55:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 22:55:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 22:55:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 22:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjTGN31fMjRXflQu/REtEF3b+FxyAMCYQZKmYySK6O1T4iAyjSIRrYCLnGwHAFYCj2ojE5FMoiBBzX/LPtfrT0TYv9RHps4oJA41KadsjpC6SUgbwHq0Nxhqmnq4TjvTwPSh2oqZMcie5wABgC97dm882IHhnzuiTyiH3MMPe1L3m5XKex6O4oWG0zpVHciD+xiH9wg2MLTM5809ppjh5Lt/s1eyFiUyw1g62c+RZfre/ceFSuew9C9aeoA5jysaYZGrJ77GSWYQguAYN2BavfFvzgW5cuYyaYrshszIAAR/DqZlL69AmoZ+0aXbAC2UaeavvThKx0vArleF5Rwitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM4vj5dGVOelmeZG+6cb5+VnT+RnNUhv+gTm3kISsfQ=;
 b=gpEj5Bbe371ZLDwKuvyTuz9TzAP3NSmtzP6zqhEzDwmNp2VU51iSewNkH0dlJnqOu+wLHuqhGqtiP7PaNPSUe6FUObhUQbyXcDpLJtRxg9wGGpgnM9vBnkXYncTDsnrt5VkT9mrruFsOsSBtWTFHM595A1gLZd4yj3N9AGQNx1XakWU9V4RjakswtpoBaPqWVbURTLUxE3XHK8oVFPOZySqVxvsMiL3pMay2IOh4RYLkJ7JPqSdM/6JvccWglTc9y6Vd5NTD2jWsEv/lnQuYU2LPDwx2n2e1A61d9CCvcCqtnHJLsKAsb04bw+7jxy8vjheiFQjnLVtXrN2t5jT8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7963.namprd11.prod.outlook.com (2603:10b6:510:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 05:54:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 05:54:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 3/5] vfio/iommufd: Implement .get_cap() in
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO sub-class
Thread-Topic: [PATCH 3/5] vfio/iommufd: Implement .get_cap() in
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO sub-class
Thread-Index: AQHbqstrJbFNhSXc8E6q2FPBmsB71LOlcZuAgABfYpA=
Date: Wed, 16 Apr 2025 05:54:51 +0000
Message-ID: <SJ0PR11MB6744C856127EF1082907F83992BD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-4-zhenzhong.duan@intel.com>
 <Z/702atFa6kyCI/D@Asurada-Nvidia>
In-Reply-To: <Z/702atFa6kyCI/D@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7963:EE_
x-ms-office365-filtering-correlation-id: bb750e51-3240-4aa6-e064-08dd7cab343a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1DiBgNEpkT3HEe/2LBI59kLMwKiGECJh/AV5XKGVj6w1LgsXkbakRNUNgPg9?=
 =?us-ascii?Q?yVMEAX0AOwLPWPD8XxruQ4FlcrBiVNukRkYQVHumdIPb3sVAJnq6Yr4VHIxN?=
 =?us-ascii?Q?R9U/SK7LN0iExN/5FrqyIJBZ5xFJcNcAOcnX+2TOc2qt6mXw5RqE/p33j/Bf?=
 =?us-ascii?Q?uzNLKr6qGsZL4OfY6JURizyzh8OSNKoPLFKCxeROcRTG+LEa+DvKFTbKN/K4?=
 =?us-ascii?Q?EE4srASw3UCJN2MbHuOuDgzdheNreM9eVteKELMVdV/6ZpLsiR9OlDesb97G?=
 =?us-ascii?Q?dcPTKgxz/Ayx00RVI6/UUF8WMz+Y73Prk2+bbBh6juk6LlOXxIwxpsx/q7sL?=
 =?us-ascii?Q?65Xnq0bTPbMCG8v1vjt79JFClTVPWFER1BhJ2DPVw6FNSzZfHsr2fXqu1C2u?=
 =?us-ascii?Q?2S2zcHlG4MrvFoLhLzqIOch805CjdpudcZvTPUuF4cECw/8RbZWd40XGdg5N?=
 =?us-ascii?Q?KD+66fvDr1djLfwGeI+ti8kPXJpeQSaRpAQdM7qM2Iuo1ltfAEMELRWb5VQS?=
 =?us-ascii?Q?XINiVorbK+GKORMFH5/AxqWQVMe4p/Sgl6gZV5jlkdgf1FEOdWFOeFKF0ylN?=
 =?us-ascii?Q?sknJ8V8VaNtgp7eoHRxthi6TmXRu8JxAntROcZ9n++znd5+wfDKDsRdZuBWJ?=
 =?us-ascii?Q?8wJX+Oz0oy3qSYd5ScJA1UVJzieL5l746NwE47BK48WK6XWf1ks7AfwWngpq?=
 =?us-ascii?Q?nAUxWHvYY9wRjt3PvP6OhpF6h6uHwgKrWdN6ew82+OaqT5ON75F9azQPjf9U?=
 =?us-ascii?Q?1+7/noQIQrznmNmAqZd0cl76FhxRwkIGFLYoO0d+51+Lc3uKTipgSe75c3Sl?=
 =?us-ascii?Q?HBPr1jfO1xWCr0gPGsZGk0HMZIf2Y5uAt+DIvE1JCeFv9j+Ub6A898xDw46s?=
 =?us-ascii?Q?bpev+hCwAjx9rJortCTeeeu7KnpzmAVxQNgOC9VB23O6bJsmovmOq6HzYUR7?=
 =?us-ascii?Q?s3QuprKsrkwJQoZ2eb57GDQBJAeizjL0hsjmNS6G/859a6Khxe8/+oGw2pNv?=
 =?us-ascii?Q?BHGjUzVOkhmeXNQLjYgFQ3ZV8b6pb+PzFzfvrYmDqAP93Pq8lOeLTUwIyNyb?=
 =?us-ascii?Q?BSPi5R4KcGIKHRHnWY1twWPXiqWspF+xlqR40KJlIFdJ398G1+Dtp5UaCgq8?=
 =?us-ascii?Q?igYHACRqOeiYDWu6HG1QHTPXmYHkFxDIM3/yqDBOArytXAw6L9k0DVGlJ5n8?=
 =?us-ascii?Q?tRwPVewB1o1gihDkU5guwqzqz89oZSBHVVaYuIYaI839MQnju+AC47BWl0wJ?=
 =?us-ascii?Q?D36ZZ1BQBLcRScaQuC5CbmhIwZBpRwokLnYqkqSnM9IQfJjHL04bHMYgn6pf?=
 =?us-ascii?Q?KKnqGzBNdhbwEATU9r9DKin83Kt9R+acopEjp6jQc1MoEjMCLZH5DIhT+3Mz?=
 =?us-ascii?Q?rgy4cIMfS6O/iKQ1aQtryNexbqT/iSI0iunbkdoclbP9f0NjEhCj3SViJcIU?=
 =?us-ascii?Q?jN1VvDwbORHbBAfpE1vbIVAhtTvjr5FYh1NjxG5XqCvTvYl8gOKO5g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p0CkSrEU3YE0C0w/kQfk59JfrBu5jxFhH5s8vj070Ze8OovvZ6TxpaduFeA4?=
 =?us-ascii?Q?A2T6sn1pluPcLmfVqhJWpH+m6KCVL4D1GEhK9Y7WrjFgKKOgh3AsM9eMCE+O?=
 =?us-ascii?Q?xtKKCpzW3lgZ1LnJ5SMA37Ur2VC3sMCcYMaW3zq2eVA9JL1hQfpFzSh+pB+5?=
 =?us-ascii?Q?TE8TFZDd0PIEl9+CwIuPdYTvQKhlVX7DbCbf9lntATctHAPuDql1e5McTYdw?=
 =?us-ascii?Q?EIMggTHJ656+xTki/LzNMVde3ZaH/rJyxRHLIII+ZAJ4qzk0K/XJp9NYdMFT?=
 =?us-ascii?Q?fJszglwFxpJTnm12mTk/OYVZGPSpyj8ORGXFPFLk7IFf3aemnNxf6l8wf51Y?=
 =?us-ascii?Q?LTddWAHMIQVI5L8qMdi2lZkTFUt/XnrGfBsZoBrKc7SNl1KEecdPHjoSq3e6?=
 =?us-ascii?Q?4nYbAg9DJEqG3/vqY629KRVWYU47Amgn4plwSAUKC8cFMAFn/HNoGSArpV9B?=
 =?us-ascii?Q?a4mM1qWb3cRrqZjyj/T2iVTI+4hxGLCWeOQ5Wgs/mToVJGYhGcHo3CdjTS8g?=
 =?us-ascii?Q?gtbCuO7ENqmxwgkFg+ARk7kLidnWhzFYCLaibjje4PtvErm8XmqY/ssrxbIH?=
 =?us-ascii?Q?urNPAfXOyOYwydS0b9SrEYOiFakjH17GxdCyut2BYmjArrUnAKxx+N9DrdhC?=
 =?us-ascii?Q?kgrc4RHjxedrv9f+Y71iorze/eum3yKyyPvAo2x2eAFDpM+1WIkF0+E+pEat?=
 =?us-ascii?Q?HfIU6eKx/4jKxqX13GXZEpYQOy3cFRQcxzAK3zE+U0p6B1qZWWLGqnKYza08?=
 =?us-ascii?Q?/kBh9yjLz730jgJh4uSLF3kMNAdzkrsQxCaRNoj80ntC3CiyRhTW1j9Ufhx4?=
 =?us-ascii?Q?9ZhYdemvOcA91i5h5/NxFFD5pkQeCdVCy7AMr7SaodUbTGiRdkNEOURZ7yY5?=
 =?us-ascii?Q?2AXUtnUzex4RUwol8qeh35de6IyLiYIzwfeUlBlEMcx8y/PaaS8hZ2Seu3rR?=
 =?us-ascii?Q?Fsgom7oN9SpUyCL/15HDfbEXjvKYEZHLZuHni7mS+XSgZwKhtMGz7HcENOG+?=
 =?us-ascii?Q?JIyWsUwePLYTEs/83VUS/E9BmaViXJr+WZK2rcypg/+4QLZm3StWxGNLt+bC?=
 =?us-ascii?Q?I0xZZGx5l7txld9TekIiRpmesvAHWEKRdYX2mxvQKYaFaKwCVaBDXm3sNw4Z?=
 =?us-ascii?Q?LSBfs/1KoY2dlBA++3HBD8cpBv5ixensZAgTVZBhp8eG1i1ACQ6/FDOJjISL?=
 =?us-ascii?Q?Bn5+aoonI4cUcmkNpV3mt6fNHX3TUpPGIzbyncW8H+bdO5awxeePBQDtpaos?=
 =?us-ascii?Q?NVKhZ8usoQdFaAnQc+gL863+8cHjiar4NlaS2R7jp3cFKFccF2Kb85OQeeNT?=
 =?us-ascii?Q?CIpjCnplkQP73SLl7X9NpRfzrEQGhrVOhEVOHIm0uFN2cWFxpzHUgm9Mm3Hs?=
 =?us-ascii?Q?O3AtHjdRWOw/6s+fp6HpM2o5azKzlTrZ7QeC9keLJSqgQ1U1Q6zWqaoZ0nya?=
 =?us-ascii?Q?8ioje2Bo/C0hqyeNFY46Elbhy2dXhjganNsvyNY8WlGaKQVB30QX+jsHmcMD?=
 =?us-ascii?Q?n/6L9b1Gy5a/OJxe9/gMzgYMFQ2agXhm7uFzTjr+VFaonlzM9rSplMSRHWcm?=
 =?us-ascii?Q?FPqwVt3T+omTmltXqJVh5O9Te2UEgJdlmuL4PvvI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb750e51-3240-4aa6-e064-08dd7cab343a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 05:54:51.3731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ8MS99zXSadNMaDp3xJrvxEyYRHZJ3uiUQdAIGbrBWPn7ee5Pjxva3NmMiTxLMcVswz8STBF0jSQTKqFQxwNJvOjkiW7PGcTWcJftUG2NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7963
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH 3/5] vfio/iommufd: Implement .get_cap() in
>TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO sub-class
>
>On Fri, Apr 11, 2025 at 06:17:05PM +0800, Zhenzhong Duan wrote:
>> +static int hiod_iommufd_get_vtd_cap(HostIOMMUDevice *hiod,
>> +                                    struct iommu_hw_info_vtd *vtd,
>> +                                    int cap, Error **errp)
>> +{
>> +    /* TODO: Check vtd->cap_reg/ecap_reg for capability */
>> +    error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>> +    return -EINVAL;
>> +}
>> +
>> +static int hiod_iommufd_get_vendor_cap(HostIOMMUDevice *hiod,
>> +                                       HostIOMMUDeviceIOMMUFDCaps *caps=
,
>> +                                       int cap, Error **errp)
>> +{
>> +    enum iommu_hw_info_type type =3D caps->type;
>> +
>> +    switch (type) {
>> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>> +        return hiod_iommufd_get_vtd_cap(hiod, &caps->vendor_caps.vtd,
>> +                                        cap, errp);
>> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
>> +    case IOMMU_HW_INFO_TYPE_NONE:
>
>Do we have to keep vendor types in the core?

Either HostIOMMUDevice or VFIODevice, or you have other suggestion?

>
>Can we have another PCI callback like the set_iommu/unset_iommu
>ops to ask vendor code get the cap and return it?

As you said, vendor code can't generate all caps i.e. PASID, any benefit fo=
r a new callback?

Thanks
Zhenzhong=20

