Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C450C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhHZ-0000EW-IY; Thu, 13 Jun 2024 06:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHhHX-0000DJ-0q; Thu, 13 Jun 2024 06:02:11 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHhHV-0004QH-1k; Thu, 13 Jun 2024 06:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718272929; x=1749808929;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TrQYqubW/01FdfTg5JdTt+H2hitxBMM+gDVoDsY0Yzs=;
 b=mdrqogtZYKOZpIvgzlcmNZvr4ZL9PLFLvKiH5KW7s0E57gHMOMnjo8er
 yZhmG/3/8RP1MX/vkLsR92wLCgjpAz+zUptWJN6ShwMy/caSEf9XwSphV
 YD5aA9eON+cIKi1i3hdRmud4QMGTAICN+wPYaWIOu0Nn5LFsFLx8LZF0q
 Fm2Y1fMaOiU/d6wZH8A9sCuo2eqUtYldnOQTt6kDvAg12B4fQ9qjnxA7T
 nSbzEgCVF4r+L3aqCz7w5fCwVuX7/g5ot1J9knRQq8T3FgZrm82CblbhE
 P5VNe3Ng0xVTrl535EWoRiCRWca9CyyEoG7gcp1lI8/nFiZUl5hPa+Ds5 A==;
X-CSE-ConnectionGUID: FJx34vNpQq6k3/Dt5iC0hg==
X-CSE-MsgGUID: pmUJYvUFRqe8sgk8ptDpuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15048230"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="15048230"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 03:02:06 -0700
X-CSE-ConnectionGUID: EXYlUZDXTW2BlOuuuLpZYg==
X-CSE-MsgGUID: JiNYFyd8QUSbZedE8LOMjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="71300833"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 03:01:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 03:01:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 03:01:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 03:01:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 03:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZbYAEAQ7WqWrj3QT2Zaa9Aqp3dQk16CVl4FWLkOO2VGR603UITiesTqz4/JJ/3CDbKQUKFGt+lQaTprhNm89Ez46zVqLSVeIpPF92oejqr1qlutp30+1ma5BS/kzh7PCo7dMxdepMJR2uh/HdWAIUOb7/mxKzHrOv8YIQJetWfq9LlbpmYq8ONGahlh3QBUMQ+901pIdZtoMBPD4zn/cUjyXDGLSGy/hRFHW2cD4q6Q3/PH+rt6MLQm006mEeuB0BUOY3+NCNVubHDED4QcXAkkRKTbd9pKZ3/aNVU9ZhixPTbrYXD6uGPUjsazOF5EZNQPfTyoK/GBzQ/MqhYhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOzivNajAX41wefKp5Ia8fPMOuIs0FhDkXnrlQ2OgMQ=;
 b=n/2Kkg6BMFHarmlzwV7Cyl8N4SGa4TvsBFkYo4W27LYqYsL1+KOmaM79IpcLh2bTVGlUd/PKFFqvdOaDs4nX8paEi1Z/wl9Ipyty2nUAr3NyAWx4kuMY6tEQgucbnw9JxaWwc3/zIujYfCvWCwh0Xulip11qpAA9SkLWQOp/ZLMqjvtnsB0x7W3LvVsabqWETcsOJiEnjjg1tnAD5JQ4H7Swf67B9eKiZFDLH8yQIA6ZdNDirmvAeUZZ99CXXX16pSLfuSI5YRHwGX6rkS5pcBmLlZGLxMOTE6eIeBWHEcxjp2IudZz3DlJjPgYQQF6e1433Pyv1xQHJne/iokYcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 10:01:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 10:01:50 +0000
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
Subject: RE: [PATCH v3 3/7] HostIOMMUDevice: Introduce get_iova_ranges callback
Thread-Topic: [PATCH v3 3/7] HostIOMMUDevice: Introduce get_iova_ranges
 callback
Thread-Index: AQHavXOCkqyXXtMZokG2alB1INTlmbHFdlnA
Date: Thu, 13 Jun 2024 10:01:50 +0000
Message-ID: <SJ0PR11MB674422E6AFBE0E09BAF2926B92C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-4-eric.auger@redhat.com>
In-Reply-To: <20240613092359.847145-4-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4767:EE_
x-ms-office365-filtering-correlation-id: 1ce66ee8-93db-4883-102e-08dc8b8fd865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230034|366010|1800799018|7416008|376008|38070700012; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3BIDz/cTIx3435gaw1wknw+8+ylCSouQe7o0Aatn4f0SrupyFu6dEAI9P7Fa?=
 =?us-ascii?Q?q34rua8XrVvdoo5Hn+yisSv8/HsuicgRP8rEVO/MY/28tm0SpgO3y6Z6uqlq?=
 =?us-ascii?Q?EeAA53p+AFLyIoSFmAFmqDtbmh6+VrwvFwNY1bQ/GEgrBlmbA+RINlxjDJ6B?=
 =?us-ascii?Q?sqLkZ2cjoMaj8zvw0CGojnZeN5on703QUaUfWyealMYBUTTnfRi560WzNLxy?=
 =?us-ascii?Q?PtXHgOI8QnhhLyMBqE4ZDLyIeFxXoyV0GXxOEkFufp27hR0qDOSog0EpJezQ?=
 =?us-ascii?Q?Ywyc6XBU2ByJSFYGzzu0sduoM4TiMLD5l9Y1qg/aPdws2m4wWpwNDjv14p9b?=
 =?us-ascii?Q?8Avf2A3nwlAicGN4YZsM4S6VNrvoJ5qfH+T0jUd4VDQ/j5hA1B/sYrZ3UxUs?=
 =?us-ascii?Q?FdFNW2LF28/3fAx3eP06MLmrFSbf1E6sB2j4oFscUvx6vauPhApESHkePsHm?=
 =?us-ascii?Q?0au20q3KwtHURebkMXrHhpfRg48H1lu57bdHK9IF51xZ5JDQrQX7UQwYIfMv?=
 =?us-ascii?Q?m2sqhxosXUz9ButgkUWRHTieqUsiahkWDYOamiRKPtCrkMp63bs87RWgTye7?=
 =?us-ascii?Q?Mws3YPRhyYIhv+RnhJkHdNhrw3HYZJYNZbr9TaoKFa1CsFERFAmwy5A+NFsW?=
 =?us-ascii?Q?ZesXpvVmsyZ7Cu5QxpmdJDAKu6SchIC/ZXZCvj+2zOuIoMlq23WXbS0FTQ5F?=
 =?us-ascii?Q?J5UI7usTLS6/iAuY/aLasPsT6QutUzPjOJFQGnaOBTwXNTorex+QFUu44Gr9?=
 =?us-ascii?Q?JvOKaU5n/x5LYTFY48Az8S7ti0bANBk8oX0OQv8AgMSYkbcnTMxmtA08Ymuh?=
 =?us-ascii?Q?URROfCIxlQLf0G2sOYq8QfqhNAEajvU2ujSA7TZZxTkbK8Bpbm/atUj22lxX?=
 =?us-ascii?Q?jAKndCBBIeZlyuRQ8t7owZqXcA+ukC1jgVNarIILj89lTN8mkd+3qYLVVYDN?=
 =?us-ascii?Q?gOg7mHNU4K6wS8dgUvbD9SLTJv0vKRXFLgP0yml+7EV0OuhEWuCGCyAyXC9h?=
 =?us-ascii?Q?lbwO96R376iDOLjPIQMDX6WyCSLsVuKf0zL+QtMFYnN1q1CyoBL73IiOAQD9?=
 =?us-ascii?Q?tKY/q1oj2XazoRpqj9vnj21TIph2y9MZxkFpR3o0LOD0MCDIF2jPZoCLbZ7R?=
 =?us-ascii?Q?pYjLBQw66ke2zeK8spf7ZAx10CKVVu82hThRtgukiceYXyPVAPTKIniKriqX?=
 =?us-ascii?Q?fXLL3IpB5LmDQsr3EoNELwlMdITX8sCffjxJg9ocqgsJkxP0WXRG+i0Y1Wn8?=
 =?us-ascii?Q?c+pCbTEQ3q8vmk/96wNOLQUSyU5z9WPmNVgIWg8IA2VZ+i/ncMUU75790LoC?=
 =?us-ascii?Q?b19mNqKzoj1PlCnqjWu/889lSjDAJ/1qFB+UEud130hltxwSDGe8mfeUu6OU?=
 =?us-ascii?Q?KGiy8yA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(366010)(1800799018)(7416008)(376008)(38070700012); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IB0CroNsm8Z/5asGO7CeiX9026MkD7HfAlyOZNgxh9OVH8Yv+aJGEt48KGXi?=
 =?us-ascii?Q?BQWr11X7M6VVoiBXxL4OhQTZVV1s2PCFAh4hZHcCfWp2r2BQ6twdZqGN3vOM?=
 =?us-ascii?Q?OpvujbczPay4tiyec16Ivav2dOG0OMbQXmf9ZG1ecb9ei6eEVftwkrQZnEkb?=
 =?us-ascii?Q?Z/5NhqznZMNKNk2933NNkbICvcUZVicrEvWPyxH/ezpU0qYvUlfdSQjc8sFB?=
 =?us-ascii?Q?y/kcNS7XHhhRdmweJd6gcDS7hTfiOg2Uh2Xj20ZGBKkrb2At36Z7cWLRRsKv?=
 =?us-ascii?Q?PWEoXpqAhIyIW4OK9xCmG2r9te02+cIzXHrIwmU/dasEkrzaIVkEpRwbzNXl?=
 =?us-ascii?Q?ugMW1v9wLilNQbDMdjMuvrOBhD+YMVqB2Os7AeaRnLcKnflUte4ZQGaGf4bx?=
 =?us-ascii?Q?X0/YN49CvB5RJxyCkJTXOZri4S4bM1swLtdfNuLLoBV+BCXdUOotxivPFtCu?=
 =?us-ascii?Q?L2wM+c/uIe430svh1HlMfub+Ax2Jh0mjDoODjXtv4BWag3IeZv1709hCgYwS?=
 =?us-ascii?Q?N9ftZnNr33+2VDa3FPdjTrk8gqajmyc48/RlPhZ0l0A5RboQG9gaUxiO2XEL?=
 =?us-ascii?Q?DWb1oiuVMU+BAAkjDDyZGJbfz+Fd+r3K3wWuQq4PBvL9JvT+0ldB7RcR1s0u?=
 =?us-ascii?Q?y/8HkwifB3G+HmbKn864aBd8/oAArkbXSzN8TqqeoWIhF/fuVHUoBpwAzzy6?=
 =?us-ascii?Q?AEjkMPG1QvUKjw2ifDraMgw3a1paV9m1s0kscR1a2IxuWAwVSLZKNb6GqGE8?=
 =?us-ascii?Q?PoDnXBiX5OTPzdjSixAtmNiQPWJ/DlzQUeoAo0ih1P3YRNsc/7I8tU1FmLpX?=
 =?us-ascii?Q?GvrRJVWRTTRIydNg+eJTd3VQXjBJEplLsmSjaeWmtZ5epEKSpJA5qvut/e/U?=
 =?us-ascii?Q?TcKo/uz5cvEbHx1TdjpH2WyFfciYfkvAYpzFyZkiWhzfYgfBraAPQLEqDPRC?=
 =?us-ascii?Q?ATKnai31F5xcAwhAZAq+Uts/le0O7fMs7dsiP1lznhbR3Qqb23aVRjwHs7Yq?=
 =?us-ascii?Q?Jv9kHer0VqbYQUFQOuJYOkT/E2f8a880oDSdqFf335io4tOwR6uDe+StIPZJ?=
 =?us-ascii?Q?bxOp22ODs1/51FZapNLnOVwnD5OPkc0K1f9do0hDNkD5rNEgMFInHJ/cb2dX?=
 =?us-ascii?Q?kvGRtY9mQaOmywzXx7cfRbTgCZcLV89k5a+xIVuL4vI6KwGegPQvZoJMB+bP?=
 =?us-ascii?Q?7dlNHQd/4V+DA723nddcusYtmXw+1tff2XDlKKa3z+ly23CC0CV+YX9pvyL+?=
 =?us-ascii?Q?r7VLp3geZZNK+FVP3ccUuNuY2j/9VUFg3VSm4VHSCrxf4zcAvvYiBhLWVbX6?=
 =?us-ascii?Q?RB1HmyORX3cHvCgrLN8fxDNL7Hx6iPA8n6fxDHEos4s7JLyQvwFWUhk+l0nH?=
 =?us-ascii?Q?s4hs94dGolqxnpc2/aDdNZWdrvstOjSZSrH9BVpUkAOcpIbLh3x9hj327y6p?=
 =?us-ascii?Q?r6DRxa2VhJ/H9ggelGBcTz2ZGjaki7VzYTcHM+rCeqfMPRvdoXjEckgL58No?=
 =?us-ascii?Q?RndJijivhMulJ0z+yNmfBJJhLEvEIIUeU82+s7kVonMXUgAD7C7j7SiUKgxe?=
 =?us-ascii?Q?kLx6lbapLndu0r84Q/EEqEBODjPB4cyV6+TFUkNd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce66ee8-93db-4883-102e-08dc8b8fd865
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 10:01:50.6516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJvpQd+X4fAP4Kj7MIg59eb6kHZDroO+3+TA5/oAgMfWAi4mHN2pAvxNKtPfTMQojcaD/UnZhemDNeil+HBQosrziHIVuPdsgrpvypBQGgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH v3 3/7] HostIOMMUDevice: Introduce get_iova_ranges
>callback
>
>Introduce a new HostIOMMUDevice callback that allows to
>retrieve the usable IOVA ranges.
>
>Implement this callback in the legacy VFIO and IOMMUFD VFIO
>host iommu devices. This relies on the VFIODevice agent's
>base container iova_ranges resource.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>
>---
>
>v2 -> v3:
>- add g_assert(vdev)
>---
> include/sysemu/host_iommu_device.h |  8 ++++++++
> hw/vfio/container.c                | 16 ++++++++++++++++
> hw/vfio/iommufd.c                  | 16 ++++++++++++++++
> 3 files changed, 40 insertions(+)
>
>diff --git a/include/sysemu/host_iommu_device.h
>b/include/sysemu/host_iommu_device.h
>index 3e5f058e7b..40e0fa13ef 100644
>--- a/include/sysemu/host_iommu_device.h
>+++ b/include/sysemu/host_iommu_device.h
>@@ -80,6 +80,14 @@ struct HostIOMMUDeviceClass {
>      * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
>      */
>     int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
>+    /**
>+     * @get_iova_ranges: Return the list of usable iova_ranges along with
>+     * @hiod Host IOMMU device
>+     *
>+     * @hiod: handle to the host IOMMU device
>+     * @errp: error handle
>+     */
>+    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod, Error **errp);
> };
>
> /*
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index b728b978a2..c48749c089 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -1164,12 +1164,28 @@ static int
>hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>     }
> }
>
>+static GList *
>+hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
>+{
>+    VFIODevice *vdev =3D hiod->agent;
>+    GList *l =3D NULL;
>+
>+    g_assert(vdev);
>+
>+    if (vdev->bcontainer) {
>+        l =3D g_list_copy(vdev->bcontainer->iova_ranges);
>+    }
>+
>+    return l;
>+}
>+
> static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
> {
>     HostIOMMUDeviceClass *hioc =3D HOST_IOMMU_DEVICE_CLASS(oc);
>
>     hioc->realize =3D hiod_legacy_vfio_realize;
>     hioc->get_cap =3D hiod_legacy_vfio_get_cap;
>+    hioc->get_iova_ranges =3D hiod_legacy_vfio_get_iova_ranges;
> };
>
> static const TypeInfo types[] =3D {
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index dbdae1adbb..e502081c2a 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -645,11 +645,27 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>     return true;
> }
>
>+static GList *
>+hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error
>**errp)
>+{
>+    VFIODevice *vdev =3D hiod->agent;
>+    GList *l =3D NULL;
>+
>+    g_assert(vdev);
>+
>+    if (vdev->bcontainer) {
>+        l =3D g_list_copy(vdev->bcontainer->iova_ranges);
>+    }
>+
>+    return l;
>+}
>+
> static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
> {
>     HostIOMMUDeviceClass *hiodc =3D HOST_IOMMU_DEVICE_CLASS(oc);
>
>     hiodc->realize =3D hiod_iommufd_vfio_realize;
>+    hiodc->get_iova_ranges =3D hiod_iommufd_vfio_get_iova_ranges;
> };
>
> static const TypeInfo types[] =3D {
>--
>2.41.0


