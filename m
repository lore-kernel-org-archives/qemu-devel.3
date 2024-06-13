Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B267BC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhGY-0007jz-CP; Thu, 13 Jun 2024 06:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHhGU-0007fZ-Kn; Thu, 13 Jun 2024 06:01:06 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHhGS-0004Bs-Ed; Thu, 13 Jun 2024 06:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718272865; x=1749808865;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JcPx3YNKfyWLpeud1FsFG+frpwIGZYelTi1xS6HYGCM=;
 b=P2DRp/Kgf/gAT6YIYGs0JvBQKRJz73xPZGITBTc6BVODT5JBoxOSyjBV
 3zt3Ih2zvrmq+lJahyntsCr9hTDt7ilvkK0GqieS/wuei2psz6kzmlluj
 Her7QuKlQ+16xkWvguOPoIN+kWh+5uy7CQ6xnfMiOsQcGcA0AqtkCkcR6
 ns1/oWWJ5htp2a2R8BWP2LgfPnp3tMJ5/wGTumWzorh8a4tRsuYAJwuDt
 qEn060VJaip0y3ePqZhl8BE/z8xc+U/hwvHmMMLj2idXWxFYvIK66J0JQ
 pCGd79CHV8S3emLMNO3P6/pzjt6HLbz/+3JTVWWD7SA+zeT1j5O+/X1IO w==;
X-CSE-ConnectionGUID: Uq82JFmIRVa9T8ErjxDocg==
X-CSE-MsgGUID: /MHwtKkuRAuaqcI6Aa8ZkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14880484"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="14880484"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 03:01:02 -0700
X-CSE-ConnectionGUID: QCPLQRJuTg29g9IrkSPGqw==
X-CSE-MsgGUID: gIsFswTuSki5ecD61ZoRzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="44530184"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 03:01:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 03:01:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 03:01:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 03:01:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 03:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6seEeqbz1IBb7H8MfD0zdRtjb2sJXp7KNeLu/1wF/tE8GD5/egYqbAV44bJifxaJgeEYdt4RZKjIDMI93Hh7FN90jWQyCXCrxTrl3WRUf5KtpF7NUHHykE+aK8+vTS7bz1pkV/50Uho0+D8Y2SzteD4k1BXHCfaZVcxwAIKBEPeVbpCrqCuD7aJd5XbgxeCYNL+PvUtwpN2JQItuTb8ZZYE4xjAHRhjrebqCRF2lqvapkSwl0WSaKnheCSKtFrcvFlsNsBpirDwREi6LBwMMNEZ5klKM2DG3MtnYKldasqr6LYP9ONj7kCXAo2rpnD4pWXOvHPvwLKWnsb4kGPcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT7MA0nX6TxG/h+C/wW9dk4LmwA2PcBpCA8e5lIsl5U=;
 b=X49LFX1QqVeM4pcmE5jp4PXR9UNa38nu7B+PfhTEG56E986g+Y4H7E3d/N7K+3lbm6eVhYcfsDLyHz1VY72CtXTxt2294mGYL1hHERN1yTk7qv+3baUj7M8/EyVeYx+WSXrBQqkAqdw62afvwNWTIDof4bqIXhLXwhw3pcENMhAXUGS2XEyIS/yZAII7pgxsaz2E3L+ach4QyYh2CYlaRHBn0KxgDAaKRb8nyFWyO7PilDHj/3CoQN0CDWyt8mPBu2lDzEvn1u18nICpm4ZPcC57OBfbONY8JlrXVLVTDnvipjEoyDrHE9SejsVEh72mS9EJM/3tQ4eBeV65fldr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 10:00:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 10:00:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
Thread-Topic: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
Thread-Index: AQHavXOLATA8uQqTv0Ke/++V4XR9aLHFdWQw
Date: Thu, 13 Jun 2024 10:00:58 +0000
Message-ID: <SJ0PR11MB6744A08077F63B0E4535D97292C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-5-eric.auger@redhat.com>
In-Reply-To: <20240613092359.847145-5-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4767:EE_
x-ms-office365-filtering-correlation-id: 937ccc53-948b-44a1-82fc-08dc8b8fb96d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230034|366010|1800799018|7416008|376008|38070700012; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5mpCIOaEghUpbvnK3NdzE1UFHjCpEdJlrhVw287+UWknrb3rX12NfuRjs7KZ?=
 =?us-ascii?Q?37NbNHIvmpcVgngIkFQZ6EkyDK+LP5T+zsmL/dDHD6i1LC7Wi09YNgJEIvra?=
 =?us-ascii?Q?R1AJDixiq9VmVVSn3KeUAimhn5XorWVWtMx0DzO5VMYN/51bh+eivAGhEyn9?=
 =?us-ascii?Q?cMuZ89yBGuTUivniGiEsOYPI0G7zwIosE6yF+OXePh9zfOq9NDaObQcFYWFA?=
 =?us-ascii?Q?HowlSpzY51BpuUVrDE52LXzCnqRHvGYb5OXBEBtyKqCOr90UqEeUPdo0Mjyz?=
 =?us-ascii?Q?PKGk9cD3gQFL1vkzqVakPll/wslTLzwoJ8KhSPL1ZEqtHxEi/ghEHOsj74wH?=
 =?us-ascii?Q?X7rX08/ikwvRhqUgRHoVh8c7R+qkgJWD3DNrS4tyxmAq1cNw5Q2IECVFJAR+?=
 =?us-ascii?Q?vWdCzPGypjrNRABiuMJCVuIyE4BFrAiGEvtRJ9UKNOU6OtOqpzkvFQphgslV?=
 =?us-ascii?Q?hFHELCcG1CuaSHlpska3NqjGM52EGWTne6Xi+sFlUixKwvtqdcA1btuyxOAu?=
 =?us-ascii?Q?0h1Dhb3/TnxHF3knVnsS1dBZgV6dIV0Dy+SxufsQruTunNlTranpHz6Cl/5g?=
 =?us-ascii?Q?pdKEuTJlxrQ1GKUx21mK30z6MG1MZzJUVRNhN1C07ncwthvdw2T0jeTwYc9w?=
 =?us-ascii?Q?X95AS8lQ2RqFB6Oc1QpC7Fo7hjelc4VIdR4XQ9hBgSENQSxwl0Nvb8hlB07O?=
 =?us-ascii?Q?twOmPcOML3fijxn2q1lwY7K1f24y11ycR9AYBcmYOJdA+1hMCXdrs2Ns/8KQ?=
 =?us-ascii?Q?beuhKnc3GDlOhiwPg+nM54WzY41aU811MvhGBEi2wEY7dsccHYGuG9U/RTjD?=
 =?us-ascii?Q?uG5dNza/4IVPmAXpiDio/lGD1gNZfEY+P2Aboku/Yz2J9Oe2sz4sgaqJ/OiL?=
 =?us-ascii?Q?VYxqQAjNGJin+X4VBGScvXMSuk0mL6Ql91l0MIsAcCIe6NbBo7j7NWARriQT?=
 =?us-ascii?Q?9YzIXfINdw3Xd1TTbM+rTS2P5c4OavcDWE9ZhCx1vS1Jlnydsh+Ei1OEhwiC?=
 =?us-ascii?Q?rzQBSlTV+OW4Gb5Hu8FDCovYa1vfBotHDNIwTUHQi2+mIiJtCcEQbua5CVYK?=
 =?us-ascii?Q?QOColtqAfg4BEpE4wWgTxaId0SN7xO2oMfn+EXFkFtJpWRI7cVq/tvWLEwFV?=
 =?us-ascii?Q?qvIJ9jVxKR86QdHOmyos2lJocOolC9qll7CFfIBcHM7F9Og8vuZUE5VINa+d?=
 =?us-ascii?Q?h8EjuKrAESrioqggxBcNg/J7JL8SyQexaIeENYU8ecDFJU1frjM/52+jmD/n?=
 =?us-ascii?Q?54R0nQMGzV+FJDp+bRgegEfXLTiAWlIyKfIePeV08XTuMjoZykSWw/KlaKob?=
 =?us-ascii?Q?uAZY31c2HinqbOESRquNhQ6S3lvluQ26vtPQT9DDleBBmBfmnDDMnQr6V03X?=
 =?us-ascii?Q?nSB4dpA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(366010)(1800799018)(7416008)(376008)(38070700012); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I5DVImpj7HlcJXIQwjfpGGCSZA0/xTLkuESxkzMVZSaSy4fNSDqI5Ja5SBfb?=
 =?us-ascii?Q?XEJBdpmKBZeKeMa1plOeI2nUkzn947ro3TslbtUmc+aNREiSjmuC11EOGMrG?=
 =?us-ascii?Q?ipWXIUgIJQGDhksVNpM44fl3poBXgChyRAC6iBf9UyYDAT4lYtbx6lGvi2C7?=
 =?us-ascii?Q?J3jPfJyjC22hzOumQGJGlyCvz7++sQ/oCsw6hGhCbSje2MmIoKdUCyVI63F0?=
 =?us-ascii?Q?eSOA1m1WDwDm0/xKsaVmxmxfpwERQ2xF4dRils0/WzdWu4YokC33TYAyy/LR?=
 =?us-ascii?Q?/1ubI9MDhvYdRjMAubXQZKwcAHt3hcPIHfs38RWiff4dT8Sc2/fmkcs1v106?=
 =?us-ascii?Q?O/GmVvMATOuLx26j7ipgh9H0r6AsBteY+6VY1FS0j8H9Cmy6E6rGYo1+5eaD?=
 =?us-ascii?Q?7aMaQ7zLJBdnSV8MsqlWPnaVain4XO0R0vgyhqTn9F1B8GJ+4WRY5G4SGg1/?=
 =?us-ascii?Q?L3qMfbe9MFOvp6CUBhjL7tkdwICpM2BPPl3+BCcviYdI/hGBe8Kv9E6BBFaU?=
 =?us-ascii?Q?ciJYadtPEM1c1g0H0Jo0dYpaFbQRvEjk7WDavnio/onXGOqvWyUvEb5CKHho?=
 =?us-ascii?Q?7kLANSgItR5oFj4VJuWxITKuln1JfIbA2pWDCqm+uy3x0ZwZ1muZfYZqQVcq?=
 =?us-ascii?Q?G2XMRlks+/KU7D+c0blWXLPmnsv9YAok832OdE7g1k4F2AHfI5JVt7039BjF?=
 =?us-ascii?Q?ep3n9cjVOfNIC2TiIzGSvJlHCKOsgYZKHocYe8H0Ed62KJATQmADPXyxmvR6?=
 =?us-ascii?Q?K+rSszKqvVk8chaZ+Zp4IABJHBL0CFmhK7KKfUv4naW096noS5S5SfDTr+zX?=
 =?us-ascii?Q?wr60JuKiFjTug/1IwUeHJpVZoS+2cY4/0BabZ/AHbVBwjas3m4+AeOBBng0b?=
 =?us-ascii?Q?DrCHhyreUJVqqsGT8p9BMN5Oj7L4MqvvP3gamgtDHZloNnHfvQm5wzh3WgY9?=
 =?us-ascii?Q?1V5rajUR4OQX+/v9CHw6l29cusHkZABXsD0c28qOC0iGq0YH+3hjFo+lTVjU?=
 =?us-ascii?Q?v2VbxprNvWml6eg9rY446jNl0m939awQc71nvTR4Yptu7O21m8ofpsEVaK8S?=
 =?us-ascii?Q?GFmyoqZttj9TdKEL0Uk6LOB3IR8M8QF//73yHOaW0Vwr9ju5cNhQPlcPcDqq?=
 =?us-ascii?Q?85u7z4bXLC8/iOuJE+TObntcSvm58Bqtg1a8yb8PCD8Ycirb0SJ039AOg7J6?=
 =?us-ascii?Q?SC/IzVUFqqYDibUijn96/JwZ0SdBQsfEIR9Wn7zdCWEePRLQO4CT3aG1BpQy?=
 =?us-ascii?Q?W8/Ri8hkYKxd7mKREeO9pyApkmSi2PLEy5fl+6MCO3qld1qnLEJEQBsaxk+e?=
 =?us-ascii?Q?kGnijD2CBw/Vqa276SqK4WRpHMvxp3n5VhRgaEgNLG4D6OM8Hppd+NGOrswy?=
 =?us-ascii?Q?6CUCcJd1rj0zlCfWjBNRsK1V/ZCpkHCFP2f2q6zruCsW2W4D8xO1Ag12qNz1?=
 =?us-ascii?Q?5EAGYzhdo/xcgKVqXnV5OOm1j60VTlz1a2d2FH7sU4Bu9x4MuwROmPVqmL11?=
 =?us-ascii?Q?yr08XhJggwL1fvNMKxQwJptFjGjgg4VeI4eN12sdVemzc2pa4HlohJwL09pR?=
 =?us-ascii?Q?AB+3MzgeIGAkFq00KNedZcMHJbfbRRyPcJ8G5T4m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937ccc53-948b-44a1-82fc-08dc8b8fb96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 10:00:58.7152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmhG7WG6pJ4b0gvADC2zJXU1fY34j9DBYP3CItUE+uXWZfIEweC0NFkeKDfTqtnGM5hAEn/OeIaAgPmolnThAV46J5Fom31WjGeyVJr9px4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
>
>Compute the host reserved regions in virtio_iommu_set_iommu_device().
>The usable IOVA regions are retrieved from the HOSTIOMMUDevice.
>The virtio_iommu_set_host_iova_ranges() helper turns usable regions
>into complementary reserved regions while testing the inclusion
>into existing ones. virtio_iommu_set_host_iova_ranges() reuse the
>implementation of virtio_iommu_set_iova_ranges() which will be
>removed in subsequent patches. rebuild_resv_regions() is just moved.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
>---
>
>- added g_assert(!sdev->probe_done)
>---
> hw/virtio/virtio-iommu.c | 146 ++++++++++++++++++++++++++++++--------
>-
> 1 file changed, 112 insertions(+), 34 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index db842555c8..04474ebd74 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -498,12 +498,109 @@ get_host_iommu_device(VirtIOIOMMU
>*viommu, PCIBus *bus, int devfn) {
>     return g_hash_table_lookup(viommu->host_iommu_devices, &key);
> }
>
>+/**
>+ * rebuild_resv_regions: rebuild resv regions with both the
>+ * info of host resv ranges and property set resv ranges
>+ */
>+static int rebuild_resv_regions(IOMMUDevice *sdev)
>+{
>+    GList *l;
>+    int i =3D 0;
>+
>+    /* free the existing list and rebuild it from scratch */
>+    g_list_free_full(sdev->resv_regions, g_free);
>+    sdev->resv_regions =3D NULL;
>+
>+    /* First add host reserved regions if any, all tagged as RESERVED */
>+    for (l =3D sdev->host_resv_ranges; l; l =3D l->next) {
>+        ReservedRegion *reg =3D g_new0(ReservedRegion, 1);
>+        Range *r =3D (Range *)l->data;
>+
>+        reg->type =3D VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>+        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>+        sdev->resv_regions =3D resv_region_list_insert(sdev->resv_regions=
, reg);
>+        trace_virtio_iommu_host_resv_regions(sdev-
>>iommu_mr.parent_obj.name, i,
>+                                             range_lob(&reg->range),
>+                                             range_upb(&reg->range));
>+        i++;
>+    }
>+    /*
>+     * then add higher priority reserved regions set by the machine
>+     * through properties
>+     */
>+    add_prop_resv_regions(sdev);
>+    return 0;
>+}
>+
>+static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus
>*bus,
>+                                             int devfn, GList *iova_range=
s,
>+                                             Error **errp)
>+{
>+    IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, bus);

Here the bus/devfn parameters are real device BDF not aliased one,
But used to index s->as_by_busptr which expect aliased bus/devfn.

Do we need a translation of bus/devfn?

Thanks
Zhenzhong

>+    IOMMUDevice *sdev;
>+    GList *current_ranges;
>+    GList *l, *tmp, *new_ranges =3D NULL;
>+    int ret =3D -EINVAL;
>+
>+    if (!sbus) {
>+        error_report("%s no sbus", __func__);
>+    }
>+
>+    sdev =3D sbus->pbdev[devfn];
>+
>+    current_ranges =3D sdev->host_resv_ranges;
>+
>+    g_assert(!sdev->probe_done);
>+
>+    /* check that each new resv region is included in an existing one */
>+    if (sdev->host_resv_ranges) {
>+        range_inverse_array(iova_ranges,
>+                            &new_ranges,
>+                            0, UINT64_MAX);
>+
>+        for (tmp =3D new_ranges; tmp; tmp =3D tmp->next) {
>+            Range *newr =3D (Range *)tmp->data;
>+            bool included =3D false;
>+
>+            for (l =3D current_ranges; l; l =3D l->next) {
>+                Range * r =3D (Range *)l->data;
>+
>+                if (range_contains_range(r, newr)) {
>+                    included =3D true;
>+                    break;
>+                }
>+            }
>+            if (!included) {
>+                goto error;
>+            }
>+        }
>+        /* all new reserved ranges are included in existing ones */
>+        ret =3D 0;
>+        goto out;
>+    }
>+
>+    range_inverse_array(iova_ranges,
>+                        &sdev->host_resv_ranges,
>+                        0, UINT64_MAX);
>+    rebuild_resv_regions(sdev);
>+
>+    return 0;
>+error:
>+    error_setg(errp, "%s Conflicting host reserved ranges set!",
>+               __func__);
>+out:
>+    g_list_free_full(new_ranges, g_free);
>+    return ret;
>+}
>+
> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>int devfn,
>                                           HostIOMMUDevice *hiod, Error **=
errp)
> {
>     VirtIOIOMMU *viommu =3D opaque;
>     VirtioHostIOMMUDevice *vhiod;
>+    HostIOMMUDeviceClass *hiodc =3D
>HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>     struct hiod_key *new_key;
>+    GList *host_iova_ranges =3D NULL;
>
>     assert(hiod);
>
>@@ -513,6 +610,20 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>         return false;
>     }
>
>+    if (hiodc->get_iova_ranges) {
>+        int ret;
>+        host_iova_ranges =3D hiodc->get_iova_ranges(hiod, errp);
>+        if (!host_iova_ranges) {
>+            return true; /* some old kernels may not support that capabil=
ity */
>+        }
>+        ret =3D virtio_iommu_set_host_iova_ranges(viommu, bus, devfn,
>+                                                host_iova_ranges, errp);
>+        if (ret) {
>+            g_list_free_full(host_iova_ranges, g_free);
>+            return false;
>+        }
>+    }
>+
>     vhiod =3D g_malloc0(sizeof(VirtioHostIOMMUDevice));
>     vhiod->bus =3D bus;
>     vhiod->devfn =3D (uint8_t)devfn;
>@@ -525,6 +636,7 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>
>     object_ref(hiod);
>     g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>+    g_list_free_full(host_iova_ranges, g_free);
>
>     return true;
> }
>@@ -1246,40 +1358,6 @@ static int
>virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>     return 0;
> }
>
>-/**
>- * rebuild_resv_regions: rebuild resv regions with both the
>- * info of host resv ranges and property set resv ranges
>- */
>-static int rebuild_resv_regions(IOMMUDevice *sdev)
>-{
>-    GList *l;
>-    int i =3D 0;
>-
>-    /* free the existing list and rebuild it from scratch */
>-    g_list_free_full(sdev->resv_regions, g_free);
>-    sdev->resv_regions =3D NULL;
>-
>-    /* First add host reserved regions if any, all tagged as RESERVED */
>-    for (l =3D sdev->host_resv_ranges; l; l =3D l->next) {
>-        ReservedRegion *reg =3D g_new0(ReservedRegion, 1);
>-        Range *r =3D (Range *)l->data;
>-
>-        reg->type =3D VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>-        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>-        sdev->resv_regions =3D resv_region_list_insert(sdev->resv_regions=
, reg);
>-        trace_virtio_iommu_host_resv_regions(sdev-
>>iommu_mr.parent_obj.name, i,
>-                                             range_lob(&reg->range),
>-                                             range_upb(&reg->range));
>-        i++;
>-    }
>-    /*
>-     * then add higher priority reserved regions set by the machine
>-     * through properties
>-     */
>-    add_prop_resv_regions(sdev);
>-    return 0;
>-}
>-
> /**
>  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>  *
>--
>2.41.0


