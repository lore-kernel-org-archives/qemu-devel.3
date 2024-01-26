Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC79C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 07:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTGl9-0004fX-On; Fri, 26 Jan 2024 02:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGl7-0004fI-Az
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:36:17 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGl4-0003yx-HS
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706254574; x=1737790574;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QofThq8MMKRf7ttM3ktyZk6fyvHtccR9lPxN1ii4ZrY=;
 b=Nb5oNKNfPPQXSDKvvelnCejj/Apl2frIZJhPZMN1/6fcNzx7v8RKbezb
 ozVJfRq6khOzXhooYVCDyrPble5hmQR6N22hBwHNMTQ0q+h3pDU43zOK6
 L6NNB1RkqxmL/vabRs3WpfIzN9uHYzPlmfLwYWy7jEOf0ZL56HGTpkdju
 4bNHCzdy0fz9T/RVgOOG5krnJyztzYlaUGvUKbtAsfXF1HXFlhUE8bQzT
 fsxzdAMab63wIeZNX8ocWULRI1YR5clI3ZjPZGG3BBeYm9CQkK88jKNaF
 D+Qaj93SBABh3Of7kv89E6VAT9AQuKWPmLxw6Vx00YHqy4t1eDlTmy9y9 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15936612"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="15936612"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2024 23:36:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736605216"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="736605216"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Jan 2024 23:36:07 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 23:36:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 23:36:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 23:36:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhihSIKc5sfUoS/fCNmc1lMXuDTzusRSpTKk7tRz6K+ZT12ZFFc8d1awoUODuHkYRmfy4IEaXu5hlkst/JHeMFagIY0uajosZyx75yS149V49jW1fclPU3EMAiLMIhE4OQbGhni4p7Cr9cHFerDfB5vz3Q7i4iFYtVi8uJjTgb4HUuLJrqTTqZvM39h/f0JopBt/Z3PADQ8v4pAsEDx+LZbpE053ATHEj8NgSR1qI2oVNp7GFuGSI+ugIe3FlTsPCW3+CzsNtXFQLVpIXMjD0E8kjwdLcuNkOsK9rW86pbnlyESfGFAUGYz+Wo9lRkiv7m/3fLTDV2emdrgbzoboDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QofThq8MMKRf7ttM3ktyZk6fyvHtccR9lPxN1ii4ZrY=;
 b=ewUM8Q0xabkj0TnSajGgPk0eMA4uE+2oEi7ghM0eK7m7MVrmqoy6iRCEhgQI32T8i2Kgfek+AagPi8kwjCg9ZXa5LH2+yRhEtSnv8SM4wZ9h9lAmBJlcniVPuhdyejUiRP+fsVZMfp9764K58H+ow9GvUAIE6kyRklbbAx8ParcBOpCpBEQHwVkKxiFSYxro+RyqZVysdrGoHB84dC1N3Zg62DhPX19mwxr8R+eOy/0OdCIRsrzBmKv3EaHIECZJYpg3AjHkvV0oSwFCtefX9VYQVo9b532dVNJayRhGYwPuyTcWbcRnytVuMZFcn3TYSkwxc+3MHb67TuX/UERXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 07:36:03 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:36:03 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon"
 <dongwon.kim@intel.com>
Subject: RE: [PATCH v1 7/7] ui/spice: Create another texture with linear
 layout when gl=on is enabled
Thread-Topic: [PATCH v1 7/7] ui/spice: Create another texture with linear
 layout when gl=on is enabled
Thread-Index: AQHaSzsD08b9QalJD0y2OyzSuzGiM7DlhuiAgAFgmOA=
Date: Fri, 26 Jan 2024 07:36:03 +0000
Message-ID: <IA0PR11MB71855CF2A0272310219B4E4BF8792@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-8-vivek.kasireddy@intel.com>
 <CAJ+F1CJbf37qJcyo+aZkqrN7chXoCK=Q_yHYJQrwZOkZpJawvw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJbf37qJcyo+aZkqrN7chXoCK=Q_yHYJQrwZOkZpJawvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 904d9c2f-4fab-4f3e-91d4-08dc1e417326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xS/TDxFJxwR+A9Q4EevdxlaCOP1SIwOr7l5/rofd1OkaPv0Cla8oCtTXanbF8lUABuL7DBj/ClKkLeiq6ik7JQLAEm7e949p29jb1i9ZGZ0Yekto/PBQi0DVWOz2myIsGBVaX9/bHdVdDkJS76M0d3Bjnud3HlW5rgO0kbcH+gIQesrD/+Fu3LobSyDvGR1v3TttLyxeBzQbqb9x+kUn+KPgA78nCi1BweJ5grjnSjjd7KfLvjNDr72AFUzFkGArCFUG5OrGzl/RMBfmm8FnFhNal8SPqnoBxQ+w4Fmq+uGCC0NnQDL7YPrhrRKO3YwGw34DTDG6oo2anRb6caG4QugLOdAiJ24qIovAr4hGFVQw+bZQHXQG9W/VNmbexE1ixmthzX+nPVxJnNvpPOWdKhz6lQGQKWL1aNxAftllIvSJgMhsnwPvDzdH7/eevk3I8HMDtDZNtskpgRQzyc0ZWge2mR/w9rLuoBeCPym7vInD1LXgRBRaWmGvETkR3HxfQ4mMoJl6QpPHW6UtQmf/8Es6zfv9BWmSfCs1kz6e3krpD4KefCIvYfwrkxqY+ZlqqDAWa/6QhGmdxh0acCMhpJ7JCQfaYqkLfz7q4ZUmIR9JOssHuDXo57U3t385VfMi9XMDt1iaDaEDswNZhvXsPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(107886003)(83380400001)(26005)(478600001)(71200400001)(9686003)(6506007)(7696005)(53546011)(966005)(41300700001)(6916009)(33656002)(86362001)(316002)(76116006)(54906003)(64756008)(66476007)(66946007)(66446008)(66556008)(4326008)(8936002)(8676002)(55016003)(52536014)(82960400001)(122000001)(5660300002)(38100700002)(38070700009)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEcvRnVYN252OVp0ODMwc1ErR1JzSlc1VGFYaWdSTFFTbERidStZUFV2bHFh?=
 =?utf-8?B?OU5GOERlZXY2ZDE0SVZFaTdacG1nd1NyeTI5TVh1clBmRDN3bUtjLzN1L0ly?=
 =?utf-8?B?VEJFQXVBcXRBL0EwcngvYUV5NjFxUGZKbVZGa1FUNE44Y3lXTDU2OFR3VDFW?=
 =?utf-8?B?KytNeXNVSVNXQXhOS3crMkhEUTVVc1crYm8rV0d0U2x4U0loSEZrWS9kYXcx?=
 =?utf-8?B?QlcwQTFtb1ZtbDFmVENQNFQ3QUcyekx3QmRtWi9YS1o3ZEFNTjB2c2NuazE0?=
 =?utf-8?B?NUcvY3B2VUVyOEtkZXBEc3NSWkI4dGkxd3BvSG1qcG9vaVYrL3M3L1pIend2?=
 =?utf-8?B?bmJUVXJxUTUyZnJtelNXd3I1dWhNSFFpODRBaGVDdFprdEQwTzROOCtSanRZ?=
 =?utf-8?B?aDArdFlCMlY1WlZhaEc1RWZjT29HRUUrQ2JCbjZ6YWhKN2ZTWUYvU0FUQTVW?=
 =?utf-8?B?MVBTQ21renVnOGY0RFBsTmxOeHBSWkI5b2RGUWxEaUxFcWJhZFhjUWJxUVgw?=
 =?utf-8?B?d0JkSnVYSFd2Rjh5cnc0Y09PVnptUXFER3ZkSUdNVE5hNFB5L0RHQ2RPeENZ?=
 =?utf-8?B?bUFiZnJwL0lLa3VZOXlONnZtbTNWaGxrNCs4bnRqc1VocVhxRWJmK2IyUlhw?=
 =?utf-8?B?ZVllaFRWUnlDNmthL3VPWTFhNW51V2xmd3BMbTZjZ00wS0o5RzhjTGYyaFRC?=
 =?utf-8?B?cFdIWmdBRVI2M3NGSzZpeE45NlJvc2FWbXB5NVJ5UWNTbFIyUVRmWHpLQ0tR?=
 =?utf-8?B?YTU0cXhpZEN2dmdCZUJ6UU9RZU9GQURkOUVhb0JVSG9uekdpMGNOTDQvTXdv?=
 =?utf-8?B?VWJCbUJCMWZHVWV3eWFoRDVsNWZySXd6bzFEaWZaTW1uOXVOZXpGeTkwOFpI?=
 =?utf-8?B?cG1Jby9ScXZ1RCtFclJsOWtINklyTGZEeXNyVVZDUWhvMjJ4MXpqRVppL3Jq?=
 =?utf-8?B?b3NZQ084WU1Gd21tVksvaFh6Z3B3MjFKUEExWHlLWEdrVy9oZjh6cWVHK1VM?=
 =?utf-8?B?N2VGRVR1T2g3NVdBN0s4clpMcVJVR3BHRm02T2hnWjZva0wxWW9NZE1QcEd1?=
 =?utf-8?B?NGFvRlp4TEQ0OEdBZmthelRnM2xPeVR3OGZtZUE1Qy85S2l6a2tmL0grbjFw?=
 =?utf-8?B?OGwwNkhueHlOdFJMVE5LMDRQMzc3bTZ0NTRYdDVzMWk5RFlKUWRaL2Zya0Ex?=
 =?utf-8?B?Tm1Gc1pRaTBIdHZXMmZYQktpRklQV1BZZ0JtLzVVZ1hjR20rb01EN1Z4NHFk?=
 =?utf-8?B?QU42RGE0SWlvM0NmZUZTaUwxOGJHc1BKYXRPczgwN1NrQ240aGxNQXBGVi9T?=
 =?utf-8?B?aDllZm9kUVl4MkZjUTJIU1FmeWlLRFlWRjIwL29JbElUdVpTZjZhN2c0L3c0?=
 =?utf-8?B?TnRSNlY4bTJuTENXb1grUTVXSURpNWdFNk1RKzZrd29VK2NkV1cxYkkvZWVC?=
 =?utf-8?B?UkRld2RMTGNGamlaVG1jZGRKZmhXOGowVENZZFBpeFlZbjMzN1BFNVJSdDFZ?=
 =?utf-8?B?b0RVSzA2K0RPMUFUNzU2RDNiQUZnMjRIVkJMcjFmNC9WMndVSnVPV0dUMmdR?=
 =?utf-8?B?ZGhXblh1QW9HQjA4Ym8yeGFuUGZqR2tUdmpRRHlxa3FsaUMvYWppT0Ztc1NE?=
 =?utf-8?B?MmpDZElXejZqNlVtL0lSZ1ZmOUpveHNaZFlwYVZtN01ZOVI4VEl3bzFiVXJI?=
 =?utf-8?B?Vk81b3p0eWtyQlpla1ZrZGpqenVNOGNoc3BLZmhmeGRudmxKcmNyclpsTkgw?=
 =?utf-8?B?WDRJdUR6dzVBbXovdGc3Y1R6YUtYY0NsWHF2WXhpWFI0b1ZYNXpTY20xMWpv?=
 =?utf-8?B?UnhXQVFGZ3IyZTZxSHZtVFNsNkxuMlFyUTRMRldxNyswNFh3Nm5iVVFwa1Va?=
 =?utf-8?B?dExOK01PWDBJVjZHNGlZT1lyMm54WGVHSVR2Nlg3WGRWWGphdXJPS3NoR2x1?=
 =?utf-8?B?cVcwY20vdXhieWVaN3VjbW5DOERnc2FQSlFCeWh2VE1INlRVd2lyWE1zbEN2?=
 =?utf-8?B?TnNSR2RpSlMybGxrRk1DRG1NNWVpSmFyS0FEZGRCTlNLQ0RSRk91Y3pOY0ph?=
 =?utf-8?B?YXpwR2tiZGdQRytYZHh3ZE9rY2xlSGFxN1JZQmR2ZGpFaDJyRmc0YTg0QzJ5?=
 =?utf-8?Q?E/djbTFawYb7T7wtWTsahn1Tx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904d9c2f-4fab-4f3e-91d4-08dc1e417326
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 07:36:03.2936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h92qXs126eQdXLfitu1gHq+2daRpbp3LBtBOcqRQ3J+oNE7JpiMORVZJugN1T0i0Axn9qDW+7ETuVogEvcgWlIjTM0xbTZAYMMLhYexXQ+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgTWFyYy1BbmRyZSwNCg0KPiANCj4gSGkNCj4gDQo+IE9uIFNhdCwgSmFuIDIwLCAyMDI0IGF0
IDQ6NTTigK9BTSBWaXZlayBLYXNpcmVkZHkNCj4gPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gU2luY2UgbW9zdCBlbmNvZGVycyAoaW52b2tlZCBieSBTcGljZSkg
bWF5IG5vdCB3b3JrIHdpdGggdGlsZWQgbWVtb3J5DQo+ID4gYXNzb2NpYXRlZCB3aXRoIGEgdGV4
dHVyZSwgd2UgbmVlZCB0byBjcmVhdGUgYW5vdGhlciB0ZXh0dXJlIHRoYXQgaGFzDQo+ID4gbGlu
ZWFyIG1lbW9yeSBsYXlvdXQgYW5kIHVzZSB0aGF0IGluc3RlYWQuDQo+ID4NCj4gPiBOb3RlIHRo
YXQsIHRoZXJlIGRvZXMgbm90IHNlZW0gdG8gYmUgYSBkaXJlY3Qgd2F5IHRvIGluZGljYXRlIHRv
IHRoZQ0KPiA+IEdMIGltcGxlbWVudGF0aW9uIHRoYXQgYSB0ZXh0dXJlJ3MgYmFja2luZyBtZW1v
cnkgbmVlZHMgdG8gYmUgbGluZWFyLg0KPiA+IEluc3RlYWQsIHdlIGhhdmUgdG8gZG8gaXQgaW4g
YSByb3VuZGFib3V0IHdheSB3aGVyZSB3ZSBmaXJzdCBuZWVkIHRvDQo+ID4gY3JlYXRlIGEgdGls
ZWQgdGV4dHVyZSBhbmQgb2J0YWluIGEgZG1hYnVmIGZkIGFzc29jaWF0ZWQgd2l0aCBpdCB2aWEN
Cj4gPiBFR0wuIE5leHQsIHdlIGhhdmUgdG8gY3JlYXRlIGEgbWVtb3J5IG9iamVjdCBieSBpbXBv
cnRpbmcgdGhlIGRtYWJ1Zg0KPiA+IGZkIGNyZWF0ZWQgZWFybGllciBhbmQgZmluYWxseSBjcmVh
dGUgYSBsaW5lYXIgdGV4dHVyZSBieSB1c2luZyB0aGUNCj4gPiBtZW1vcnkgb2JqZWN0IGFzIHRo
ZSB0ZXh0dXJlIHN0b3JhZ2UgbWVjaGFuaXNtLg0KPiA+DQo+ID4gQ2M6IEdlcmQgSG9mZm1hbm4g
PGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogRnJlZGlhbm8gWmlnbGlvIDxmcmVkZHk3N0Bn
bWFpbC5jb20+DQo+ID4gQ2M6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICB1aS9zcGljZS1kaXNwbGF5LmMgfCAzMyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS91aS9zcGljZS1kaXNwbGF5LmMgYi91aS9zcGljZS1k
aXNwbGF5LmMNCj4gPiBpbmRleCAwOGI0YWVjOTIxLi45NGNiMzc4ZGJlIDEwMDY0NA0KPiA+IC0t
LSBhL3VpL3NwaWNlLWRpc3BsYXkuYw0KPiA+ICsrKyBiL3VpL3NwaWNlLWRpc3BsYXkuYw0KPiA+
IEBAIC04OTMsNiArODkzLDcgQEAgc3RhdGljIHZvaWQgc3BpY2VfZ2xfc3dpdGNoKERpc3BsYXlD
aGFuZ2VMaXN0ZW5lcg0KPiAqZGNsLA0KPiA+ICB7DQo+ID4gICAgICBTaW1wbGVTcGljZURpc3Bs
YXkgKnNzZCA9IGNvbnRhaW5lcl9vZihkY2wsIFNpbXBsZVNwaWNlRGlzcGxheSwgZGNsKTsNCj4g
PiAgICAgIEVHTGludCBzdHJpZGUsIGZvdXJjYzsNCj4gPiArICAgIEdMdWludCB0ZXh0dXJlID0g
MDsNCj4gPiAgICAgIGludCBmZDsNCj4gPg0KPiA+ICAgICAgaWYgKHNzZC0+ZHMpIHsNCj4gPiBA
QCAtOTEyLDYgKzkxMywzOCBAQCBzdGF0aWMgdm9pZCBzcGljZV9nbF9zd2l0Y2goRGlzcGxheUNo
YW5nZUxpc3RlbmVyDQo+ICpkY2wsDQo+ID4gICAgICAgICAgICAgIHJldHVybjsNCj4gPiAgICAg
ICAgICB9DQo+ID4NCj4gPiArICAgICAgICBpZiAocmVtb3RlX2NsaWVudCAmJiBzdXJmYWNlX2Zv
cm1hdChzc2QtPmRzKSAhPSBQSVhNQU5fcjVnNmI1KSB7DQo+IA0KPiBobW0NCj4gDQo+ID4gKyAg
ICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAqIFdlIHJlYWxseSB3YW50IHRvIGVuc3Vy
ZSB0aGF0IHRoZSBtZW1vcnkgbGF5b3V0IG9mIHRoZSB0ZXh0dXJlDQo+ID4gKyAgICAgICAgICAg
ICAqIGlzIGxpbmVhcjsgb3RoZXJ3aXNlLCB0aGUgZW5jb2RlcidzIG91dHB1dCBtYXkgc2hvdyBj
b3JydXB0aW9uLg0KPiA+ICsgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgc3VyZmFj
ZV9nbF9jcmVhdGVfdGV4dHVyZV9mcm9tX2ZkKHNzZC0+ZHMsIGZkLCAmdGV4dHVyZSk7DQo+IA0K
PiBXaGF0IGlmIHRoZSBlbmNvZGVyIGFjdHVhbGx5IHN1cHBvcnRzIHRpbGVkIGxheW91dD8NClJp
Z2h0LCB0aGF0IHdvdWxkIGJlIHRydWUgaW4gbW9zdCBjYXNlcyBhcyB0aGUgUmVuZGVyIGFuZCBF
bmNvZGUgaGFyZHdhcmUgYXJlDQptb3N0bHkgY29tcGF0aWJsZS4gQW5kLCBteSBwYXRjaGVzIGFy
ZSBub3QgcmVxdWlyZWQgaW4gdGhpcyBjYXNlIGlmIFNwaWNlIGNob29zZXMNCmEgaGFyZHdhcmUg
ZW5jb2Rlci4gSG93ZXZlciwgdGhlIGNob2ljZSBvZiB3aGljaCBlbmNvZGVyIHRvIHVzZSAoaGFy
ZHdhcmUgdnMNCnNvZnR3YXJlKSBpcyBkZWNpZGVkIGR5bmFtaWNhbGx5IGFuZCBpcyBpbnRlcm5h
bCB0byBTcGljZSBhdCB0aGlzIHBvaW50LiBBbmQsIHNpbmNlDQp0aGVyZSBpcyBubyBlYXN5IHdh
eSB0byBrbm93IGZyb20gUWVtdSB3aGV0aGVyIGFuIGVuY29kZXIgY2hvc2VuIGJ5IFNwaWNlDQp3
b3VsZCBzdXBwb3J0IGFueSBnaXZlbiB0aWxpbmcgZm9ybWF0LCBJIGNob3NlIHRvIGFsd2F5cyB1
c2UgbGluZWFyIGxheW91dCBzaW5jZSBpdA0KaXMgZ3VhcmFudGVlZCB0byB3b3JrIHdpdGggYWxs
IHR5cGVzIG9mIGVuY29kZXJzLg0KDQo+IA0KPiBTaG91bGRuJ3QgdGhpcyBjb252ZXJzaW9uIGJl
IGRvbmUgYXQgdGhlIGVuY29kZXIgbGV2ZWwgYXMgbmVjZXNzYXJ5Pw0KWWVhaCwgdGhhdCBpcyBw
cm9iYWJseSB0aGUgcmlnaHQgcGxhY2UgYnV0IGEgc29mdHdhcmUgZW5jb2RlciBsaWtlIHgyNjRl
bmMgaXMgbm90DQpnb2luZyB0byBrbm93IGhvdyB0byBkbyB0aGUgY29udmVyc2lvbiBmcm9tIHZh
cmlvdXMgdGlsZWQgZm9ybWF0cy4gVGhpcyBpcyB0aGUNCnNwZWNpZmljIGNhc2UgSSBhbSB0cnlp
bmcgdG8gYWRkcmVzcyBnaXZlbiB0aGF0IGl0IGlzIG5vdCBhIHByb2JsZW0gd2l0aCBoYXJkd2Fy
ZQ0KZW5jb2RlcnMuIEkgZ3Vlc3Mgd2UgY291bGQgYWRkIGEgUWVtdSB1aS9zcGljZSBvcHRpb24g
dG8gdHdlYWsgdGhpcyBiZWhhdmlvcg0Kd2hpbGUgbGF1bmNoaW5nIHRoZSBWTS4NCg0KPiANCj4g
SXQncyBhbHNvIHN0cmFuZ2UgdG8gcmV1c2UgYW4gRkQgYXNzb2NpYXRlZCB3aXRoIGEgdGlsZWQg
dGV4dHVyZSBmb3IgYQ0KPiBsaW5lYXIgbGF5b3V0IChJIGFtIHVuY29tZm9ydGFibGUgd2l0aCBh
bGwgdGhpcyB0YmgpDQpJIGhhdmUgbG9va2VkIGFyb3VuZCBidXQgdGhlcmUgZG9lc24ndCBzZWVt
IHRvIGJlIGEgd2F5IGZvciByZXF1ZXN0aW5nIHRoZSBHTA0KaW1wbGVtZW50YXRpb24gdG8gY3Jl
YXRlIGEgdGV4dHVyZSB3aXRoIGxpbmVhciBsYXlvdXQgb3RoZXIgdGhhbiB2aWEgaW1wb3J0aW5n
DQptZW1vcnkgb2JqZWN0cy4gQXMgbm90ZWQgaW4gdGhlIGNvbW1lbnRzIGJlbG93LCB0aGUgZmQn
cyBvd25lcnNoaXAgaXMgdGFrZW4NCm92ZXIgYnkgdGhlIEdMIGltcGxlbWVudGF0aW9uIGFzIHBh
cnQgb2YgdGhlIGltcG9ydC4gDQoNCkFsc28sIEkgaGF2ZSBzdGFydGVkIGEgY29udmVyc2F0aW9u
IHRvIGZpZ3VyZSBvdXQgaWYgdGhlcmUgaXMgYW55IG90aGVyIHdheSB0bw0KY3JlYXRlIGxpbmVh
ciB0ZXh0dXJlcyBtb3JlIGVmZmljaWVudGx5Og0KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Au
b3JnL21lc2EvbWVzYS8tL21lcmdlX3JlcXVlc3RzLzI3MDY3DQoNCj4gDQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgKiBBIHN1Y2Nlc3NmdWwgcmV0dXJuIGFm
dGVyIGdsSW1wb3J0TWVtb3J5RmRFWFQoKSBtZWFucyB0aGF0DQo+ID4gKyAgICAgICAgICAgICAq
IHRoZSBvd25lcnNoaXAgb2YgZmQgaGFzIGJlZW4gcGFzc2VkIHRvIEdMLiBJbiBvdGhlciB3b3Jk
cywNCj4gPiArICAgICAgICAgICAgICogdGhlIGZkIHdlIGdvdCBhYm92ZSBzaG91bGQgbm90IGJl
IHVzZWQgYW55bW9yZS4NCj4gPiArICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgIGlm
ICh0ZXh0dXJlID4gMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgZmQgPSBlZ2xfZ2V0X2ZkX2Zv
cl90ZXh0dXJlKHRleHR1cmUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnN0cmlkZSwgJmZvdXJjYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCj4gPiArICAgICAgICAgICAgICAgIGlmIChm
ZCA8IDApIHsNCj4gDQo+IEkgc3VnZ2VzdCBhZGRpbmcgd2FybmluZ3Mgb3IgdHJhY2luZywgdG8g
aGVscCBkZWJ1ZyBpc3N1ZXMuLi4NClN1cmUsIHdpbGwgZG8gdGhhdCBpbiB2Mi4NCg0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICBnbERlbGV0ZVRleHR1cmVzKDEsICZ0ZXh0dXJlKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICBmZCA9IGVnbF9nZXRfZmRfZm9yX3RleHR1cmUoc3NkLT5k
cy0+dGV4dHVyZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJnN0cmlkZSwgJmZvdXJjYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
aWYgKGZkIDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdXJmYWNlX2dsX2Rl
c3Ryb3lfdGV4dHVyZShzc2QtPmdscywgc3NkLT5kcyk7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAg
ICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHN1cmZhY2VfZ2xfZGVz
dHJveV90ZXh0dXJlKHNzZC0+Z2xzLCBzc2QtPmRzKTsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICBzc2QtPmRzLT50ZXh0dXJlID0gdGV4dHVyZTsNCj4gDQo+IEhhdmUgeW91IHRyaWVkIHRoaXMg
c2VyaWVzIHdpdGggdmlyZ2w/IChJIGRvdWJ0IHRoZSByZW5kZXJlciBhY2NlcHRzDQo+IHRoYXQg
dGhlIHNjYW5vdXQgdGV4dHVyZSBpcyBjaGFuZ2VkKQ0KSSBoYXZlIHRyaWVkIHdpdGggdmlyZ2wg
ZW5hYmxlZCBhbmQgaXQgbW9zdGx5IHdvcmtzIGJlY2F1c2UgbXkgcGF0Y2hlcw0KZG9uJ3QgYWZm
ZWN0IHZpcmdsIGNvZGVwYXRocyBzdWNoIGFzIHFlbXVfc3BpY2VfZ2xfc2Nhbm91dF90ZXh0dXJl
KCkNCndoaWNoIGlzIHdoZXJlIHRoZSB0ZXh0dXJlL2ZkIGlzIHNldC4gTXkgcGF0Y2hlcyBhcmUg
b25seSBtZWFudCBmb3INCnZpcnRpby12Z2EgZGV2aWNlIChhbmQgYmxvYj1mYWxzZSksIHdoZXJl
IHRoZSBHdWVzdCBkZXNrdG9wIGlzIHJlbmRlcmVkDQp1c2luZyBsbHZtcGlwZSBEUkkgZHJpdmVy
Lg0KDQpCdXQsIHlvdXIgc3VzcGljaW9uIGlzIHJpZ2h0LiBUaGF0IGlzLCBpZiB3ZSBhcmUgdXNp
bmcgdmlyZ2wgYW5kIFNwaWNlIHNlbGVjdHMgYQ0Kc29mdHdhcmUgZW5jb2RlciAoc3VjaCBhcyB4
MjY0ZW5jKSwgdGhlbiB0aGUgZW5jb2RlcidzIG91dHB1dCB3aWxsIHNob3cNCmNvcnJ1cHRpb24g
YW5kIHdlJ2Qgbm90IGJlIGFibGUgZml4IGl0IHdpdGggdGhlIGFwcHJvYWNoIHVzZWQgaW4gdGhp
cyBwYXRjaC4NCkFzIHlvdSBpbXBsaWVkLCB0aGlzIGlzIGJlY2F1c2UgdmlyZ2xyZW5kZXJlciBv
d25zIHRoZSBzY2Fub3V0IHRleHR1cmUgaW4NCnRoaXMgY2FzZSB3aGljaCBjYW5ub3QgYmUgcmVw
bGFjZWQgaW5zaWRlIFFlbXUgVUkgbGlrZSB3ZSBkbyBpbiB0aGlzIHBhdGNoLg0KSSBhbSBub3Qg
c3VyZSBob3cgdGhpcyBwcm9ibGVtIGNhbiBiZSBzb2x2ZWQgaWYgd2UgKFFlbXUgVUkpIGNhbm5v
dCByZXF1ZXN0DQpWaXJnbCBvciBHTCBpbXBsZW1lbnRhdGlvbiB0byBjcmVhdGUgbGluZWFyIHRl
eHR1cmVzLg0KDQpUaGFua3MsDQpWaXZlaw0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgfQ0K
PiA+ICsgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgICB0
cmFjZV9xZW11X3NwaWNlX2dsX3N1cmZhY2Uoc3NkLT5xeGwuaWQsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN1cmZhY2Vfd2lkdGgoc3NkLT5kcyksDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1cmZhY2VfaGVpZ2h0KHNzZC0+ZHMp
LA0KPiA+IC0tDQo+ID4gMi4zOS4yDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IE1hcmMtQW5k
csOpIEx1cmVhdQ0K

