Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66263C54798
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 00:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riOYs-0006io-Bt; Thu, 07 Mar 2024 19:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riOYn-0006ib-9X
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 19:58:06 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1riOYj-0005G1-IC
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 19:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709859482; x=1741395482;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=toK06Fbs5tXl7+LKjbm0Bk7KImmOGRVgHwKIcH5WVYc=;
 b=VmdZx/4JQ4V/rSGQQWdxa4IpIdCJE6fs7tCxj2SvIl74EDwTD8hd8yv0
 /0Vhi+z6YKxwrr6YVovVAiULkmvH4JC35Rt5ohxiUN2hb2/gYDL4ID72Q
 fVeowGUOhoLm4iR/hq0m94NiBaFDzxrkt/L9K4W8yJf6QexjwuZ34wGtV
 PSE/dpjmc2+WKnQp7jy8dDswSGPVwKNvuBYhxSTdAsIj9D+aI2+sDz7Hu
 thnp0/qb2uDu8LQNvKB2Sm7Y0XXpm03cBXI3lrfc0yj0Y+28Z+RV69baZ
 s0wJj6VdbRveTACj+jxeFJD6nSA+PzkenDpb13ZhqXdH7E8pgbaLjkbMN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8382276"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="8382276"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 16:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; d="scan'208";a="10732131"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Mar 2024 16:56:20 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 16:56:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 16:56:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 16:56:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 16:56:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmMs+zLiJa3pI9EoqzstGQgdeOd45KDrDLB/oiMRcA48oQPl3YGbWFzchAfo/LwbhohAn+CLRNzZyVIyN3cKU8vM5GeGO/0Lj31H3nWVWeiz6NtnPhBz2mWqZDVPy46hX3tJkq60tXCttq0bI07J0iyvJzAlecw4DHxM+vYigjcy3uqqvmwV5cLqg5onSP8hSjr5x1vnTXeUwjQEzZmqpWYOLy3h8V95APSTvsmcSs+qSCrbvp1kY+4zugvOhWIO8RgN9BuiTVY+LX/ThSwKKyXPM00dNMtNqc/9ydABFnDh1xWeD5Jr5XHyJjR2WJTOUyldPWbyFiuNnEeZeiBQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toK06Fbs5tXl7+LKjbm0Bk7KImmOGRVgHwKIcH5WVYc=;
 b=ZPv5hvPGfedKzIS6nHSYHfwa89dxsrrIw2ZNVB1wmGhhWkx/L//7+QGseEEHUAGs7tH/T1dk7Y2Gj7+httbLPq1kNQ8E+/sIFu2YlyX/pkjdwlU1ttEe4viSEqn29gkE7V7UFOO+FWvp4NqSAlNj6Nt/k8lv2KQDfN4U/zjM28qMlhJwiZnLhtFXqdMvrKIc5W74lLVeYBoOENX0nD50V1Shyq9tzeRkk5fkz6QfvtGPSw7sP1H8/MurNmd91F07TXHCMipnPewkCAWQEugSuT84/mpHbr2nwih6mKZyh2FA3WrDoadUsSy9anxLMfpB3RiuML+8IPz66jkA20I0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 00:56:16 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 00:56:16 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "P.
 Berrange, Daniel" <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/3] ui/gtk: introducing vc->visible
Thread-Topic: [PATCH 0/3] ui/gtk: introducing vc->visible
Thread-Index: AQHaVAOvhkQto5F1qE6VVrnPTRFP57EiL3xggAcW5QCAA/aJAA==
Date: Fri, 8 Mar 2024 00:56:16 +0000
Message-ID: <PH8PR11MB68793A3B7706245CE4F0E972FA272@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <PH8PR11MB6879F0CB84091A8436C3B891FA5E2@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAMxuvay8Gir6r4EWE0L=Y_YxGUxu9WS3TwNyUMe5vYX8Qt2SyA@mail.gmail.com>
In-Reply-To: <CAMxuvay8Gir6r4EWE0L=Y_YxGUxu9WS3TwNyUMe5vYX8Qt2SyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SA0PR11MB4703:EE_
x-ms-office365-filtering-correlation-id: c25cab6a-37e1-4ea3-6b0a-08dc3f0a8f56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeXQrI8Bg9fuwjSxGFzo9BA98zRHyD4hb+n+fxGwF0UX/AoS3Ip0SFJrg8tu5VvwKsxDhK46Hjt2mA2TffexKnKljUysfpB0Q7jF+DLrH/RzLUdFPMp6nn2w46Pabf2lt+lW9tIMt+c5eUPRNlvfD1DW7kejHpc4J3qr5WGkJAH+RrsT5O0fqQ8CCn4RMjWcaezPSk1zQcW9+AWhWujsXJiscD2lpiwfqZGLicY/rpd2kcbJ5CO/dKI6uaUNZcPKEEiDMKYJpSDqB6VsUd7FS2iHoq/IJO3LY7LGGMurSrGd0TsdPrFFhZrShvNUTY8qIxjx1H2E4R38SpLpqbdyxMBuDX64sJWRblsXx25bORheUjbt3awNtu+UQZFeK9bry+i9cxLwQXBtuFrvL5k7j1BcuMxVD8QEDWTqfqkCbi+JTVumNdKb/MzZ6AkmAowLP2ltHv4nmDyq1FwiMzGbr6TQu78TxkCu7RID92teFCbEM+ofjW98TVMieeANJhlKqihYuiNQTdJd+zLI7HebjGqQ01gonX+jw25mr2PDVjLYyvMlXCFwBmQA1AVPUxtUCIcn4jCrWumDppBJj5Yt2SQKKlw/n3CDAQLgdblk9TrVav7tEQtTj3qwh52Cz8cJpGaE4LW/SlU2JYQvohflbO+2C7D6ee1wPAdUDVwp00sKPDHP/v0j4DzHKaRcxduG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3V1dTI2R2YxQnZESTBUakpIcU1zL3JPYmNSRWViUmxMUHJRbm5CMG9WQWlL?=
 =?utf-8?B?ekJvREVvRHNYeTQ4US81bnJmZTNhRU5td1pHLy9OQVVVUjA5N1RabWtjOHBz?=
 =?utf-8?B?ZzF6TXNXMlA1Ukc2bWIxeFpDL0RIbEpDYnFBZ1VUeGs0Z2VqRjlwdjUwd1VQ?=
 =?utf-8?B?SXBCTWtsTVloZENKVE83NGZjSlFYT1haK1ptbytTRkp2bkVIU1o3cUpxa0JG?=
 =?utf-8?B?MXVWcHRBa0JBNDZ2eFExenA4VkxyZU1JckdsRW44SzBpM2JJdVkwajN3RFg5?=
 =?utf-8?B?RHhUaDJqRlp4Z3NSdS91MkJNcmNtREZ6bXkya0xyN05QMFYxamJPMjhJS1Vj?=
 =?utf-8?B?WStzWSs2bEwzVEhTd3NScFdtdVdEa0hja3VKWE5JVWV5elFUUjQ0eGpoRFps?=
 =?utf-8?B?eElXbFRjejR3c2dYc1ExMitYTEZTWUVoaWNlT3pzbnNyM0IxNklSVWg0ZGFV?=
 =?utf-8?B?MFRORmtSZGl0N2xxT0pMTXVMUXNaUnlFUmlaN1QrUElsYkpwV3BRSEcreUdT?=
 =?utf-8?B?a082UllxK05ZTjA2NVdqUnIzd21ZQmgyY0Z4YUN3ZG9WOE0xcDdjblg0UmdM?=
 =?utf-8?B?SmVpZ0oyM3VGcjlPc25zUlpianpQVHlHTVAvSFI0OGR1azBES1k3M1NyYUtP?=
 =?utf-8?B?SkhUSmQ4aWpneXNBVE9jOWJkRDlXNEpKY2tZQ2VYeTdoWmtYanREdkZ4QVdE?=
 =?utf-8?B?c2pqME5HaC85V2t2eWRKR1dmNzJ1cWwwWDRSVTRaZEVVdE1tdUtFR0VZQktV?=
 =?utf-8?B?MzlhOTcydkl6Yjl0OXc1cVpCZkNpc29ZZXN2Wk5ORjIrY29FeGpRTHFuRmNZ?=
 =?utf-8?B?c29ud3BtVzdVc1h0Tys2N1VDZGV6aUlTQWRacXl1N043aVBjOCt6VkFvV2wv?=
 =?utf-8?B?TXJUUTltRndsTlZwaVVleTdaUXUwdXhPWHQ1d0o0Rm91dGJEazdpc2YzSzlo?=
 =?utf-8?B?dUJKZGg1NEplU3MvQ3lDT1dsMDZ0bkorR0hObjBuWGx1cE45MHhhaGphWVln?=
 =?utf-8?B?T0JhUCs1SXU4Vk1BaTVFNkpBSHVKUUozdGpqWDlyM0RHQVp2L1lTZnVMUXY4?=
 =?utf-8?B?eERZVW0rU29WTmJFdWhjZjdCdFpaVE1pMkR6Q0F0YXBxeVN2TjVVaW43WFBJ?=
 =?utf-8?B?YVN3aGRrK1VSV0FPV09sbm1RRnZSR0hhYXpZS1hEMlVpUVMvcWl3aW03K3pR?=
 =?utf-8?B?R2JYZUN2MVBLSklXQktJdHEyc2c2K0lpNkkzdWdublZ5aSs0eG1ZTVduQXVV?=
 =?utf-8?B?c3NJN2tGQnJxUFpYUm1BMVo3SzZUMTRtTXlIWkl5Rm9aencyQlV3T2VJSGxi?=
 =?utf-8?B?aFRwejA1ek9NRGlUQUtEUERGWndZMk1La08waEg1VThxUmorZVBzZFV3TjJE?=
 =?utf-8?B?T2Y1WjdWQkkxL2dHaUdYb0VuNE1XQk9Kd1huY1lzSVdHT3FBVG9JNG8zeGNT?=
 =?utf-8?B?dGcyOFFEd0ZQNUhhcmRjK1lVUm1jNmRLdlBPcjc1eW12dGp0NFNRRGhKS3RH?=
 =?utf-8?B?eWJ1a2FsM0VReGZ5WWV1TzlDT1owNWkzaTRqZG5xTHkxcXZDQzBEWWVJQ045?=
 =?utf-8?B?Ui9wZXZXS2xMZlF6VnpFVlg0NU1vTTAyTVAwbmw0dzlmb2ZZZ3BweWpKaFBz?=
 =?utf-8?B?Wm96UU5Ia1RFYk1INGtYZjVFaFpzN2RVYi9VZzhVcURxSFBZd2xWUXBLTVhI?=
 =?utf-8?B?NlV4T3U5VlJnREZLNTl4eGxhbzFuUU9qc3NOQVBITUNBWmo3RHhGRjN4NUxD?=
 =?utf-8?B?b3pzUlNPK2xVRDdZYW8wUjMybVlDd0xwazVGZ3UwcmYxdXhHdkRVWFNVcVVT?=
 =?utf-8?B?QVo5L3VXUlpoajdJUnhmUTNlcjNsUndIWXM5MmZnT29rSVVEUlZrU0l0Ym9D?=
 =?utf-8?B?MC9xTlVJUW81M0hwMHlQdGpwR0RmWGZUeEZUbXVmSFNwSWFSMy80elNLbUt0?=
 =?utf-8?B?THBmcHZNVXdxZmpnM3NCVUUzMVRrZmRHRnlSOGNwenpDTVgyN0x6LzFkQVBS?=
 =?utf-8?B?T0tHUTFMc3VLVWMwa1dJOWxZSnhmMk5ZTTdPUEdXTUV5azVFdml5WnFkTmZS?=
 =?utf-8?B?UW9QcnhFMG5aOWYyOUMyLy9iZFY5c3VjNGdGVXN5MWlVTVB0T3duVjUyUDls?=
 =?utf-8?Q?nD6wGGl8yT3zdmVxw6+So5+tN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25cab6a-37e1-4ea3-6b0a-08dc3f0a8f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 00:56:16.6722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KrZuXTE+P2dbVc3HZWBgL6u4H5DUSQED9MI5jnIz7Dv2JHfMtwPaSPoEchh2jyGD/h5eImHmLQP0K0aTBC/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIE1hcmNoIDUsIDIwMjQgNDoxOCBBTQ0KPiBUbzogS2ltLCBEb25nd29uIDxkb25n
d29uLmtpbUBpbnRlbC5jb20+OyBQLiBCZXJyYW5nZSwgRGFuaWVsDQo+IDxiZXJyYW5nZUByZWRo
YXQuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMC8zXSB1aS9ndGs6IGludHJvZHVjaW5nIHZjLT52aXNpYmxlDQo+IA0KPiBIaSBLaW0NCj4g
DQo+IEkgYW0gdW5jb21mb3J0YWJsZSB3aXRoIHRoZSBzZXJpZXMgaW4gZ2VuZXJhbC4NCj4gDQo+
IE5vdCBvbmx5IHdlIGRvbid0IGhhdmUgdGhlIG1lYW5zIHRvIGRyYXcgZG1hYnVmL3NjYW5vdXQg
IndoZW4gcmVxdWlyZWQiLCBzbw0KPiByZXN1bWluZyBkcmF3aW5nIHdvbid0IHdvcmsgdW50aWwg
dGhlIGd1ZXN0IGRyYXdzICh0aGlzIGlzIGFscmVhZHkgYSBwcm9ibGVtIGJ1dA0KW0tpbSwgRG9u
Z3dvbl0gWWVzLCB0aGlzIGlzIHJpZ2h0LiBUaGUgZGlzcGxheSB3b24ndCBiZSB1cGRhdGVkIHVu
dGlsIHRoZXJlIGlzIGEgbmV3IGZyYW1lIHN1Ym1pdHRlZC4NCj4geW91IGFyZSBvbmx5IG1ha2lu
ZyBpdCB3b3JzZSkuIEFuZCBJIGFsc28gdGhpbmsgcmVjb25maWd1cmluZyB0aGUgZ3Vlc3QgYnkg
bWVyZWx5DQo+IG1pbmltaXppbmcgb3Igc3dpdGNoaW5nIHdpbmRvdy90YWJzIGlzbid0IHdoYXQg
bW9zdCB1c2VycyB3b3VsZCBleHBlY3QuDQpbS2ltLCBEb25nd29uXSBJIHVuZGVyc3RhbmQgeW91
ciBjb25jZXJuLiBUaGVuIHdoYXQgZG8geW91IHN1Z2dlc3QgSSBuZWVkIHRvIGRvIG9yIGxvb2sg
aW50byB0byBhdm9pZCB0aGUgc2l0dWF0aW9uIHdoZXJlIHRoZSBob3N0IHJlbmRlcmluZyBvZiB0
aGUgZ3Vlc3QgZnJhbWUgaXMgc2NoZWR1bGVkIGJ1dCBwZW5kaW5nIGR1ZSB0byB0YWIgc3dpdGNo
aW5nIG9yIG1pbmltaXphdGlvbiBvZiB3aW5kb3cgYXMgdGhlIGd1ZXN0ICh2aXJ0aW8tZ3B1IGRy
dikgaXMgd2FpdGluZyBmb3IgdGhlIHJlc3BvbnNlIHRvIG1vdmUgb24gdG8gdGhlIG5leHQgZnJh
bWU/IERvIHlvdSB0aGluayB0aGUgZnJhbWUgdXBkYXRlIHNob3VsZCBqdXN0IGNvbnRpbnVlIG9u
IHRoZSBob3N0IHNpZGUgcmVnYXJkbGVzcyBvZiB2aXNpYmlsaXR5IG9mIHRoZSB3aW5kb3c/IChJ
ZiB0aGlzIGlzIHRoZSBzdGFuZGFyZCBleHBlY3RhdGlvbiwgdGhlbiBvbmUgb2Ygb3VyIExpbnV4
IGNvbmZpZ3VyYXRpb24gLSBZb2N0byArIElDRSBXTSBoYXMgc29tZSBidWcgaW4gaXQuKQ0KDQo+
IA0KPiAoZndpdywgbXkgcGVyc29uYWwgb3BpbmlvbiBpcyB0aGF0IFFFTVUgc2hvdWxkbid0IHBy
b3ZpZGUgVUlzIGFuZCBkaWZmZXJlbnQNCj4gY2xpZW50cyBzaG91bGQgYmUgYWJsZSB0byBpbXBs
ZW1lbnQgZGlmZmVyZW50IGJlaGF2aW91cnMsIG91dCBvZiBwcm9jZXNzLi4gdGhhdA0KPiBtYWtl
cyBtZSByZWxhdGl2ZWx5IGxlc3MgbW90aXZhdGVkIHRvIGJyZWFrIHRoaW5ncyBhbmQgYmUgcmVz
cG9uc2libGUpDQo+IA0KPiBEYW5pZWwsIGNvdWxkIHlvdSBoYXZlIGEgbG9vayB0b28/DQo+IA0K
PiB0aGFua3MNCj4gDQo+IE9uIEZyaSwgTWFyIDEsIDIwMjQgYXQgNDowNeKAr0FNIEtpbSwgRG9u
Z3dvbiA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpIE1hcmMt
QW5kcsOpIEx1cmVhdSwNCj4gPg0KPiA+IEp1c3QgYSByZW1pbmRlci4uIEkgbmVlZCB5b3VyIGhl
bHAgcmV2aWV3aW5nIHRoaXMgcGF0Y2ggc2VyaWVzLiBQbGVhc2UNCj4gPiB0YWtlIGEgbG9vayBh
dCBteSBtZXNzYWdlcyBhdA0KPiA+IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwv
cWVtdS1kZXZlbC8yMDI0LTAxL21zZzA2NjM2Lmh0bWwNCj4gPiBhbmQNCj4gPiBodHRwczovL2xp
c3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyNC0wMS9tc2cwNjYzNy5odG1s
DQo+ID4NCj4gPiBUaGFua3MhIQ0KPiA+IERXDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMrZG9uZ3dvbi5raW09aW50
ZWwuY29tQG5vbmdudS5vcmcgPHFlbXUtDQo+ID4gPiBkZXZlbC1ib3VuY2VzK2Rvbmd3b24ua2lt
PWludGVsLmNvbUBub25nbnUub3JnPiBPbiBCZWhhbGYgT2YNCj4gPiA+IGRvbmd3b24ua2ltQGlu
dGVsLmNvbQ0KPiA+ID4gU2VudDogVHVlc2RheSwgSmFudWFyeSAzMCwgMjAyNCAzOjQ5IFBNDQo+
ID4gPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggMC8z
XSB1aS9ndGs6IGludHJvZHVjaW5nIHZjLT52aXNpYmxlDQo+ID4gPg0KPiA+ID4gRnJvbTogRG9u
Z3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBEcmF3aW5nIGd1
ZXN0IGRpc3BsYXkgZnJhbWVzIGNhbid0IGJlIGNvbXBsZXRlZCB3aGlsZSB0aGUgVkMgaXMgbm90
DQo+ID4gPiBpbiB2aXNpYmxlIHN0YXRlLCB3aGljaCBjb3VsZCByZXN1bHQgaW4gdGltZW91dCBp
biBib3RoIHRoZSBob3N0IGFuZA0KPiA+ID4gdGhlIGd1ZXN0IGVzcGVjaWFsbHkgd2hlbiB1c2lu
ZyBibG9iIHNjYW5vdXQuIFRoZXJlZm9yZSBpdCBpcyBuZWVkZWQNCj4gPiA+IHRvIHVwZGF0ZSBh
bmQgdHJhY2sgdGhlIHZpc2libGl0eSBzdGF0dXMgb2YgdGhlIFZDIGFuZCB1bmJsb2NrIHRoZSBw
aXBlbGluZSBpbg0KPiBjYXNlIHdoZW4gVkMgYmVjb21lcyBpbnZpc2libGUgKGUuZy4NCj4gPiA+
IHdpbmRvd3MgbWluaW1pemF0aW9uLCBzd2l0Y2hpbmcgYW1vbmcgdGFicykgd2hpbGUgcHJvY2Vz
c2luZyBhIGd1ZXN0DQo+IGZyYW1lLg0KPiA+ID4NCj4gPiA+IEZpcnN0IHBhdGNoICgwMDAxLXVp
LWd0ay1za2lwLi4uKSBpcyBpbnRyb2R1Y2luZyBhIGZsYWcgJ3Zpc2libGUnIHRvDQo+ID4gPiBW
aXJ0dWFsQ29uc29sZSBzdHJ1Y3QgdGhlbiBzZXQgaXQgb25seSBpZiB0aGUgVkMgYW5kIGl0cyB3
aW5kb3cgaXMgdmlzaWJsZS4NCj4gPiA+DQo+ID4gPiBTZWNvbmQgcGF0Y2ggKDAwMDItdWktZ3Rr
LXNldC0uLi4pIHNldHMgdGhlIHVpIHNpemUgdG8gMCB3aGVuIFZDIGlzDQo+ID4gPiBpbnZpc2li
bGUgd2hlbiB0aGUgdGFiIGlzIGNsb3NlZCBvciBkZWFjdGl2YXRlZC4gVGhpcyBub3RpZmllcyB0
aGUNCj4gPiA+IGd1ZXN0IHRoYXQgdGhlIGFzc29jaWF0ZWQgZ3Vlc3QgZGlzcGxheSBpcyBub3Qg
YWN0aXZlIGFueW1vcmUuDQo+ID4gPg0KPiA+ID4gVGhpcmQgcGF0Y2ggKDAwMDMtdWktZ3RrLXJl
c2V0LXZpc2libGUuLi4pIGFkZHMgYSBjYWxsYmFjayBmb3IgR1RLDQo+ID4gPiB3aW5kb3ctc3Rh
dGUtIGV2ZW50LiBUaGUgZmxhZywgJ3Zpc2libGUnIGlzIHVwZGF0ZWQgYmFzZWQgb24gdGhlIG1p
bml6YXRpb24NCj4gc3RhdHVzIG9mIHRoZSB3aW5kb3cuDQo+ID4gPg0KPiA+ID4gRG9uZ3dvbiBL
aW0gKDMpOg0KPiA+ID4gICB1aS9ndGs6IHNraXAgZHJhd2luZyBndWVzdCBzY2Fub3V0IHdoZW4g
YXNzb2NpYXRlZCBWQyBpcyBpbnZpc2libGUNCj4gPiA+ICAgdWkvZ3RrOiBzZXQgdGhlIHVpIHNp
emUgdG8gMCB3aGVuIGludmlzaWJsZQ0KPiA+ID4gICB1aS9ndGs6IHJlc2V0IHZpc2libGUgZmxh
ZyB3aGVuIHdpbmRvdyBpcyBtaW5pbWl6ZWQNCj4gPiA+DQo+ID4gPiAgaW5jbHVkZS91aS9ndGsu
aCB8ICAxICsNCj4gPiA+ICB1aS9ndGstZWdsLmMgICAgIHwgIDggKysrKysrKw0KPiA+ID4gIHVp
L2d0ay1nbC1hcmVhLmMgfCAgOCArKysrKysrDQo+ID4gPiAgdWkvZ3RrLmMgICAgICAgICB8IDYy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ID4g
IDQgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+
DQo+ID4gPiAtLQ0KPiA+ID4gMi4zNC4xDQo+ID4gPg0KPiA+DQoNCg==

