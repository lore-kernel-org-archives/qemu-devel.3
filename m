Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8C21075273
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38D9-0004dg-5J; Thu, 19 Mar 2026 03:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38D8-0004dW-29
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:54:30 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38D5-0000MY-CC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773906868; x=1805442868;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AVC8oo7rUAJ4tmH5C7K+2JiBVNO5qNjos7nKJdSYHOc=;
 b=kK9+MjCipMpyvtwW4spDuaFSRthhV7NSIcY42ojNTBD2PXkPGnlrnOwH
 Y3hTPHRP7rAdAfIlZvGqDZfIoy78fX7Fal78xLwMRKVZprKeqijcMClCH
 Ps/GwXt7udd8Jj537iAjc9CKF7kXI94YVxUjZAnwt8XAYApnWdsq1PZRs
 enk8HpuRwSlXn/TZ3XS4xFSym6whnOZjGH+efdYCwGDI2fIyspm5m9N7g
 WsxYkXF9d+kb2Oe2zX+vEprBt94oQFJUv2tVo3+U79QpUpLvLfUOQ7blB
 cbAe4uIfcEThH+Jgz8lDW66xy/WhiE2aI8FfevTYJhXDGDr8a0e4k5AYN w==;
X-CSE-ConnectionGUID: tO94PS+2QR6yBJ13AcnSQA==
X-CSE-MsgGUID: pHvCh94ASjySLPcuCjgI3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78831202"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="78831202"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 00:54:24 -0700
X-CSE-ConnectionGUID: qRapNhPlTUqnRERNEOth/g==
X-CSE-MsgGUID: pmVCFoBDS9qGFn3S3TZgTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="224904271"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 00:54:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:54:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 00:54:22 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2NNRIpamPwNKSrvbX/3JhmXeddKIQFTVuLUUfpBWtpNKwladNpSd+my56849Byri/tukBNJuLxztycSXM2jj1qpvGDZ1M5JZqoawZpGVMl18NudC94prOzfnX7WVZ48DUAV1hewRQoRzai0gRp4J3AiOXDIs7lKkGMxkhD7UIAmQridkDI7Blndg2PH+r1av8Q6SfDY7RyhofOdSIopywooJSKugd8VTmNej8TdgdO/MKgKv/NBOTstMmQ6GsWdwzFMD1kP1hlsf4KFfR1+RBx6UGR6HUz7TWYL7wEhoJAUduJFoUSAuMcJ/uYgWxZdCvJShgN1oK7obYH+VjCagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV87cgo4LYfoTQzNtRhE3y8z8U0wdxvPMGgbA++fawI=;
 b=VqK/HSL4z5/d6o/JNCuS3ifLx62q7aFdHHkjuKdXSaj/bcwSBsQtu5LM8uF9TUs7F1StlyZwn7jT5WtssZwijvtX5MUhVx7NglspwvtBjkP3+J254gblLyMvuk91lOlnVjKTMLMFoaNIqV5iWTtGUAvAa01lAmqFl8Gb3Hq6PxjY477U1/EZOozFM+QduIM6VJjNSDNWWSq44Qov5Cte3nsUZ19GVKolV+pUzH83gam0sZKPWRW8XXE5rYw96Q7uaR0KqzgfE0abALIR9iGtz9clhgyS0U+UlwXWRatTcCoLIYGGYB45bS6WCgR5B4iEOo/zjXrgaik0Vtok8HqEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:54:11 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 07:54:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 03/13] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v1 03/13] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHcrRuOrVv0g3U2ikqV9aNXIe2IfrW0R5qAgAFI9kA=
Date: Thu, 19 Mar 2026 07:54:11 +0000
Message-ID: <IA3PR11MB91361F9FDF4E58AE4BD40D04924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-4-zhenzhong.duan@intel.com>
 <a33c785a-ab94-4dc2-85eb-10b7d288f661@intel.com>
In-Reply-To: <a33c785a-ab94-4dc2-85eb-10b7d288f661@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM3PR11MB8734:EE_
x-ms-office365-filtering-correlation-id: c5cb2792-0c05-4655-4bb0-08de858cb52a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: pmg3wTqAaewpT9Vs3bvUS0c6hGQmpIRspC7/E1A1wHG7bdaP5hdSF+9AOnFs7z3ktSIEtwHc8YRfw8ahaTujc1nxe3C/mKKhZGYPFucEMo5EHzojpl2fUzNLVrqUSIghTAU9kuu0KkmvXtCoQ4LIKZgnKiMRuElY96YIdI9azpxjydi+PvdgK1Yz1zgUlx0moJJu80pq2/KfVa4whZ7jHBXDaRPefA/kfzZ2BU6+uVdyofzw276AeIRPV7uY5G5vllFAt0WhTInXhQVRupj6ubcO7Mt2NZ8K1BotX5+yjXYuBB8qBNZfP9QNIiWauq8TiA6KYkw24VzCNkQMKCteIxBJdkQEL3XNcRQIgfHBeKxby+Yvze4zsX1SR8iFK7chey9TtYGGniAZK6bsaYVMMp+2hAIqL3npwVZEL1P4I5lg3qpFH609GYsmRA0StN1BiAlTAds+txzd+vun3BTUY20CzGQzZWnHCsvAaPA1EIIm9FK6jodVaEY7IrGVTGBNiTKaY0ABalJQo416x61r0qeqqMWNMnq7t8ETlnv54h6vh7woVcU0ZXISJ/me6eXKvUG1woUtvF48UNCD1Gp6r77cdzOZqR2eoiTR3vESWCH8Ft0ZavQMImTB5TSDjJr3xb1i1wZ+hCol4aKfa4mNEwvnBmYs0GiLGkhOheXwyIGR8/Vs4xBoFdvFhWNzNhmZPnOS6prog1+AWV8UZdrktNoHpx+vGPHY3QNRSBTfZFNcEjdcQBGQLInXjFBBbuhuPtKO0n4D4rU9Hv5/SQtJ4MRs7Q6JtHhZdQzu0KiCQPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i3kFVRle1NDALbEhr9eZxbyElJT5A7nVb3Ymk68v04i2cUPucUX1iBU1yuno?=
 =?us-ascii?Q?uY9xZJpga9aaBQy71sR9LRqZUJ1kUKABpicWC4S6pXoN0JQZ51K+6OIAzhv7?=
 =?us-ascii?Q?fIjfzc9NRhF8IbrS6+I4mPdMVSEsXHiRGWLwMWrlcQi3R85gvay2IXHIBGbw?=
 =?us-ascii?Q?ZbVygZfobC8od3hEJxo+MksfvM/94UuChRhS6lGzK/D+HJtyZNmfrMFsLojf?=
 =?us-ascii?Q?qbn85Mt5cKGUsJOgWJVsUV2IZB2cEvdfoQjKAnYJ9wAkri13h3Xc4LQxmEK4?=
 =?us-ascii?Q?CmUUdJfK2w037aho1UGOH1ApIu1DDvutyURLWk7in+ea3U2togxv/BqTpVYD?=
 =?us-ascii?Q?qsjeA62Cs+Uq9aZSx5X4EreNNtOs7hQZsko3j1TZe8T1cDW9p4AjteyOL+J6?=
 =?us-ascii?Q?Hqzld0scMCt0t+YvjHw29HbnA8ZBpquIIWL/IR/tcj2rMg62Kn6+6orhobPc?=
 =?us-ascii?Q?T2DVEU5E0svkonRI6ybO24VXDJwxBCmHWJvVYCOgs2dsGf6OBfnDV0JdH2Um?=
 =?us-ascii?Q?5DZ4SEUglpBT8Xs/vanFYMKz5IY38fr+rkz+ZbnGCb0AtzUYJPd9niytD51e?=
 =?us-ascii?Q?xCppAFyWozIG7hdE9UwRDlrWKea8lZ34j76fdm3aTQCv5DNeg3C81iKeqKCz?=
 =?us-ascii?Q?puhJCBa9PqwLtr99s72hDXBEeeooTYba+lsCulOJTqb0ajkVGpfbBckQF91D?=
 =?us-ascii?Q?idS16nNeG4y1Af3oRgmqqr3rURKTvZV7gQmr5ela5xPSqT1LO3pV0ffuAGc5?=
 =?us-ascii?Q?YJ+46r6604AgPmcL3jrdPyKv4+Fhbo3lB8hE7dp6PRvL0pjJMh/lqgzuNn/K?=
 =?us-ascii?Q?sqdeVuyQvDPB5srtYgl8D2K8JWMfvAaZou2Ja6le1l5YAHnpYCscRhXEkZ4H?=
 =?us-ascii?Q?VBQEfnHQLr+WAfULx8lVX+HJ4zVz5CjfEb7CS17cD2QOiT5d2rJisTDcaiix?=
 =?us-ascii?Q?3DpYvxmlVkkvzKxzw5KPZ5pY1VDMg6R/6oHsZT5FpX0X42SwuQOEG5JRWcdx?=
 =?us-ascii?Q?4WEhifNv7CIAINaIsEr9JRG7/IgGy7j6x0ayomQR6BOsioHyItldSjpNBfO3?=
 =?us-ascii?Q?fBVAy5EODi6SVVJF6X9GEvisnrT2DXJJ6ReRqGOegCxgsDbyRM88TJAVjRbV?=
 =?us-ascii?Q?ucxVNmzdVtX7bNrraSstDeZ54Jaxjeo6dcXdGtf9xCKGrAPaZX5rs4fQXG4U?=
 =?us-ascii?Q?+28H0rrafSsvdEM8Z5WhWPIAPUvmXZ8qGzDj5i19C1yiCPEgxijjZ0jQFr5H?=
 =?us-ascii?Q?6bHi5NgR2gZCXKf0v104AKd5PF/g0afRNxhmCn+PWBlslAtAQ+Fvj3h6Wya9?=
 =?us-ascii?Q?JDLE32MY474+iZH8ugwBmEIu5EWRAApS3DEFWbDoJdco/BsTiHQ0OQPFasEH?=
 =?us-ascii?Q?rgr4ds2gAppnJ/zM/W/qGsP5oxMCBkD1m39C4SfuBXrBWH4/uVWACdehul4L?=
 =?us-ascii?Q?EGkbMqW7MfqHTDs847eNTwkxuiIObAAgzx4DEYUYCya4IF0d7s8o0fI5tBnm?=
 =?us-ascii?Q?jfXr5iRARU1dmMgYhBZDTjCUFkfDiIePNnWqv5wzpi1ZkKKw9OiIVzsFuP/g?=
 =?us-ascii?Q?h3vcFMiFcumtj2ZLkMh3He5GjHasM1cCHU8UQdFduJ8y5AW8jXGS51StgW4M?=
 =?us-ascii?Q?C9SBVGXXNL8aobEeWIulFI+J1/SqZosk6rXvNYzqEYwQGzEwCPKcBmiMUvpZ?=
 =?us-ascii?Q?4ZCrEReeS7h4kC4WixC6b0TfOulqr8ayoXsJ1PsGOF8A9/QkXpXp9f400K2E?=
 =?us-ascii?Q?z11Nzk7fdQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HCj8MfWq5cY4xTCDQMdUIiuyQOZwIB1rKw37YH/BlyRMm/Fj6vT9Oshe0EQpNajIpJADzQ7Z9pdEPeDEPnh+W6aMwujCylpo1p/8xqvJCZsdBvq6HCPA8L+4NYtosNp8b+915ix9RdLBHiBeXiiS92efe483fofKZlNC+VceUaJg0bAdB2ashMIl7Scvbel5POR20V+Xu5eUrgNBiW5qZ3bzfWsAF3m4yK24+dtxYkCQGMnLnBuyFpowKt317sECh6gPrzGOdHG0Ys2q38qV2juxkRAE1wrdeZeexPv8mRXRg64MacpMqmPjWYZlAmTuYGThNpCq3ceL2doQZWlyNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cb2792-0c05-4655-4bb0-08de858cb52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 07:54:11.4286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWxSTkbu+UnhG7HMzo3cEXyWr4nP+PpR8s71CXb1APrTG+3b5O+qHwmE7IB+tn1odd7IW6MPZhgnz/AwlGGvweKKX69TftaNavI/9aEb8Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v1 03/13] vfio/iommufd: Create nesting parent hwpt wit=
h
>IOMMU_HWPT_ALLOC_PASID flag
>
>On 3/6/26 11:43, Zhenzhong Duan wrote:
>> When both host device and vIOMMU have PASID enabled, then guest may
>> setup pasid attached translation.
>
>Better be "When both both device and vIOMMU". host device enabled pasid
>does not mean QEMU will for sure report pasid PCI ecap to guest. :)

Sure.

>
>> We need to create the nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
>> flag because according to uAPI, any domain attached to the non-PASID
>> part of the device must also be flagged, otherwise attaching a PASID
>> will blocked.
>
>This may make me thinking about why nested parent hwpt is special here.
>I think you just call out vfio needs to be aware of potential pasid
>usage and should attach the non-pasid part of pasid-capable device to
>hwpt flagged with IOMMU_HWPT_ALLOC_PASID.

Exactly.

Thanks
Zhenzhong

>
>Code change LGTM.
>
>Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>
>> Introduce a vfio_device_get_viommu_flags_pasid_supported() helper to
>> facilitate this implementation.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-device.h |  1 +
>>   hw/vfio/device.c              | 11 +++++++++++
>>   hw/vfio/iommufd.c             |  8 +++++++-
>>   3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device=
.h
>> index 828a31c006..dd0355eb3d 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev,
>VFIOContainer *bcontainer,
>>   void vfio_device_unprepare(VFIODevice *vbasedev);
>>
>>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
>> +bool vfio_device_get_viommu_flags_pasid_supported(VFIODevice *vbasedev)=
;
>>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>>                                                   uint32_t type, void *c=
aps,
>>                                                   uint32_t size);
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 973fc35b59..b15ca6ef0a 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -533,6 +533,17 @@ bool
>vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>>       return false;
>>   }
>>
>> +bool vfio_device_get_viommu_flags_pasid_supported(VFIODevice *vbasedev)
>> +{
>> +    VFIOPCIDevice *vdev =3D vfio_pci_from_vfio_device(vbasedev);
>> +
>> +    if (vdev) {
>> +        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
>> +                  VIOMMU_FLAG_PASID_SUPPORTED);
>> +    }
>> +    return false;
>> +}
>> +
>>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>>                                                   uint32_t type, void *c=
aps,
>>                                                   uint32_t size)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 005f97fe25..c408f9151b 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -360,6 +360,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>       VendorCaps caps;
>>       VFIOIOASHwpt *hwpt;
>>       uint32_t hwpt_id;
>> +    uint8_t max_pasid_log2 =3D 0;
>>       int ret;
>>
>>       /* Try to find a domain */
>> @@ -405,7 +406,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>        */
>>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev-
>>devid,
>>                                            &type, &caps, sizeof(caps), &=
hw_caps,
>> -                                         NULL, errp)) {
>> +                                         &max_pasid_log2, errp)) {
>>           return false;
>>       }
>>
>> @@ -427,6 +428,11 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>           }
>>       }
>>
>> +    if (max_pasid_log2 &&
>> +        vfio_device_get_viommu_flags_pasid_supported(vbasedev)) {
>> +        flags |=3D IOMMU_HWPT_ALLOC_PASID;
>> +    }
>> +
>>       if (cpr_is_incoming()) {
>>           hwpt_id =3D vbasedev->cpr.hwpt_id;
>>           goto skip_alloc;


