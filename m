Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9A4C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 07:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTGnp-0006Kj-EQ; Fri, 26 Jan 2024 02:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGnn-0006KD-5d
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:39:03 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rTGnl-0004Op-41
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706254741; x=1737790741;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gfUEs8qD4bRsa1jVh4HAz9FmUEKRRiRdEydV/J/15EY=;
 b=QGoC4KIE44PvEOQiY2pqReaO+y+/YnDwBeDOM5DSPBfgw/Huuu5OWAeJ
 ydPQfoM6IKrBX8s8c8OFLH1lJIukimchFwbS0dT9DEMN0rxchxQ/RUSoe
 vyho7hcGSBwZrJ804dk+ILgcp6/P3v1XNx7//IGtYKyIFf7KxA5L0HmWQ
 2QxWCoie/kVge2xjPANxoiy7atIc1ZVderRIC0leaDi5dChHFT/zHsDgB
 TZBok4OnHXjggjxiPbJjqxznnqSu0CGR9A9tlb95HfFZ3UbvGYBHF1qrY
 QIoNseO24Bx42HXl/9omPQsR8UydcrG0lNlzEelgldYJFBq62F9xiaQye g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15937186"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="15937186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2024 23:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736605628"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="736605628"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Jan 2024 23:38:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 23:38:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 23:38:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 23:38:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 23:38:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8MVbN1b7BKpf2KQVz/kaaIL8dxm+uLgkehYV5Lb1LnBz9VFzhBZwUswzeDFA2KhWFkFkEh4hfNpUIP7VL+GgzK3LxtMITEjvEvGC0gOlolKIiFPw4Xvk/X8KUFxPwQ2LggoFFh8Yg+PMsXekL4TnFSnGQnoPcoIqhEsvUl63liTTDDjsba0w4EbL9tJFPCQelCinlFoLyPPrnS6jSjQEmH7U9wN6kMq/4OoJ5+Jv+jNe0RuubGkXL3RQPFgN5dtDPtPQNmRRCZ50gSgESI59wWHpOSmx+VOuR6JvTk279F98z3uV+80ZKxZI7Yl2021nU3GR2l4hRyy0arCDEN/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfUEs8qD4bRsa1jVh4HAz9FmUEKRRiRdEydV/J/15EY=;
 b=h9oPEOkmK9CvLmQsRdiFUT9xyWyxOhHoaxlAaJZW651qb63yIiw4YdUVrNIsDKGedz2mc2e9F+0tWOX210WMy/nHls4tIqcKl9xJjbwnv7gIHLpg1YxcKlwVQXRmn+0YzfimQBMiY1Fo3E377soM3gn4pf6gupnoJi7jO5gwrG4cZ/dQI4SkzyLGXNOBmm68/w9jR3qqIwz2nqmuwrbg18ci379sZrPpCECcxwmZ80dOXdmqaSEWE6p9tNUVkgVhu11AcAIsxCIjV76Ra3EWpzH5bQLaXPRZZl5LYfIq39la+MZ/E0lK1zuR4wp85SsI46vPZi7bdAStExIUYMP5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 07:38:45 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::cbc8:6370:5df2:b2df%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 07:38:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon"
 <dongwon.kim@intel.com>
Subject: RE: [PATCH v1 2/7] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Topic: [PATCH v1 2/7] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Index: AQHaSzsEoxQ2OJegyUC24lhdo14xBrDlhvgAgAFtrFA=
Date: Fri, 26 Jan 2024 07:38:45 +0000
Message-ID: <IA0PR11MB7185566888A4B019022F8D2AF8792@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-3-vivek.kasireddy@intel.com>
 <CAJ+F1CJ2TC+jMjGovWo==CAJJz0RKdo-=UG-3h92uJf7OOUNaw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ2TC+jMjGovWo==CAJJz0RKdo-=UG-3h92uJf7OOUNaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 77a300bd-0174-4ba8-77dc-08dc1e41d3d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18J9br+/idut99qzxvliRAdKaizYgeyOn9exwUV+l2pxj4AW6AMNR1F6waVm1afnfBCjnm/Zn4CKF5dQIJOfq+7Dy1lno8a7Lo1e+Y/J2gyrgPJzjUSbJoKaBmPCBjQv53fZW0wJsbj3l2k5oyYCXFTMpJ7GgFJSmsav+0MVh9trvCWetA9O/dG5Jkcgoh8pchv6F4SyBTID7F06xiZ3djM27YoX/t1VYcgz+F8dwNnh5RwgiK9bOVKlKNE2GgnKfIy+ueC02ETcLrDkr4HJPFxCatHaBuWC6Oe3p75RopdHM2UAWeX+ss7YDmVgViu/kB3vAIVllqBUwmR4QI0JSuf0Pi+i7nDcX1UZ+pdjmuMLMqxehA50s5dlFe5VOKgOV7LmYBjnRZO2AiIbeHCpBw6ZKPXby174MXLpnPl5YDPmbfaHl5km+8+UE6TOBTN5VwAzJhouGr2k9KvzEk2dL2+D3vM2qceSNL0+9jSv5OPo9cYK7HAZLlQTng0Zr7Aw07nZiEYZ4Z2UM3e3iZjmjFVJHPQmkEEm768kjGpUgwbierqyBOJT7x/31sQ3Ccxi/CfGa1Enn/imp5pCq4QRX7BnOAb51q+gNE6aLrxQ5zHsvdryl4KdRQ6l21+03oCN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(107886003)(26005)(478600001)(71200400001)(9686003)(6506007)(7696005)(53546011)(41300700001)(6916009)(33656002)(86362001)(316002)(76116006)(54906003)(64756008)(66476007)(66946007)(66446008)(66556008)(4326008)(8936002)(8676002)(55016003)(52536014)(82960400001)(122000001)(5660300002)(38100700002)(38070700009)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVFBNk81QmVhaDZYMU5uZHJRZEJDNDFaSHBSTzY2KzA1OGFlbjNrRzRtK2xD?=
 =?utf-8?B?Uy95UkxWRlRmMlFHd2J4UVQ0ZHdCSkJRSkt1Um5qUzBNcXJSSmZZWjVVaWpJ?=
 =?utf-8?B?QjV2STF6a0tRQmFaZHk5SnJITHBzdXVheVRJRFk5V1pKb3dWSkc0NzNzWG55?=
 =?utf-8?B?Wm1WQWJUTXlsOC9YNGZMUnhTQ0dIZElVdGMxL3ZSNkozaTdGbTdkM01vcE5o?=
 =?utf-8?B?TitRS0p5WUFQZnpPb1hvbXBZZDdaM3pBdmdXUVoya0xOVzRHOFFEYWVNRk5R?=
 =?utf-8?B?NzZBK0lpWWc5b0hGaEJ2Y0hkVXZOTGFvNUprUUJWNUR4UUZHVnhHUGdyeXpR?=
 =?utf-8?B?UUFyRnBTREsxVVlFQXNiQjhwNEkydGF5OWU3Wkl5cE9NdjhjYUJSTnN2UHFI?=
 =?utf-8?B?Q1B3anVTd01QYTNTRFFzMFVLUzY5aE16TFdWOUJBNGZTNnlKbTRpKzhsK2Fl?=
 =?utf-8?B?RmozUWxzNnZvSlZ0eGs2RTdRbVhtR3Foa1hOVkR4ZHBJbHJ1T0tqNTZpSEhx?=
 =?utf-8?B?azR0UHIwa25EekJSS21VSFpIR0pJYnBITlZBQndxaXVMemJTL0x1OTZEZVJK?=
 =?utf-8?B?dTd6bmx1RkNiUngxVU9peWdpc0h2U25jSWNFbHV0NFdjanpHNjdlWk9xaXNV?=
 =?utf-8?B?S3l4RW40d1pRSzdoVUxCcXpBYWd1dXZraUxpOWE0S0taZktUKzZ0MGk2dVF2?=
 =?utf-8?B?UWs0MkJQYng3YXkwdmpkSGd6MlBaVGV2eXF0bXBZOVljY3BDR3RraGVrRVRY?=
 =?utf-8?B?QXJxNkFTcldTL3YwYmZFQlRDQ1JvWmRIZFd1SE9nMkplcFY0TDI1cWlRNkVS?=
 =?utf-8?B?aEpKam02N2QvV0NscytkRmZ3WDJvcjBLNEJaQVVNUEtMa0UyNHpEMUFtcUNJ?=
 =?utf-8?B?VXJjT3A3bUlIZG8wZG0ySVYzZjE0Z0xHZTVtSUxXZHFVNTkxM3YrSkU5OXVB?=
 =?utf-8?B?T08xUG16MVFrL3c1YXhQTnlqaWc2bUQrdE9QKy9qeEJJSGZnTCtoWHZla0E2?=
 =?utf-8?B?WmNaeEdrVVFBMU9oUVZwNm53d2t3RXRVeGUvSHZVZFU3MXJSOFFNNHc1aGlj?=
 =?utf-8?B?aWVSSUZXb0JaZDF1Z3Y3WnZ2Q1poVW5rYXVwK2F4eTBnTU11ZUk4RFA4ZVg3?=
 =?utf-8?B?OEtqc3dBNWtWdTVZNG50UzlkbWk4cmJjaytaeEE3MUpyaEU0VXdSbjFZamln?=
 =?utf-8?B?U2dQcXhweG9wbWxObWdEanhvYUlMQ0RPV29jMzJqd3pIWjFaZG1kczc2ZTRz?=
 =?utf-8?B?SUVRWVZvcVhIblRvZThtZmxBL3ZPdDM1UTVxMVVEMEVJdUhnYjIxelMvRTIr?=
 =?utf-8?B?cDRhdWpldFhsNzVNTmxiTHUveU55OXh0a21WRmcweDRYM3R1ZStGdjAwV0pE?=
 =?utf-8?B?LzJBTzRIRnBXSXdTK2hFQldKSEJFUWhNQXVDajFtTHlFbjJpa0lYeUtNdHdE?=
 =?utf-8?B?cTZLUHRhUkNDdnN1T21oelhEL0IzSGhvREUwRUpsQVhha3VKU3hvd0RLOW9P?=
 =?utf-8?B?N3R0QmozZEoydXRReGhTeVdSaWtQeGY3ZXVGNDVVNzVkVXJzNWM1QjNuNVky?=
 =?utf-8?B?Nmxwekl6TTBqQ1BiQ0RZUG1QMWRlZCt3UUdRNlN6aEZwcjhzV2NRdXdqSXIr?=
 =?utf-8?B?Q0pmQSt5d1NUZ2NYN3g2ekE1dE9HNFNDalQ1Q2IrajRBRW1YY2tZNFlMYndI?=
 =?utf-8?B?RzFjZU4reG1XaFRjWmRSdHlYNVc4cFV6VXZmd0FxaDZpeC9lTlI2VFpBTUdS?=
 =?utf-8?B?bXdQeVBzY0lRcEtxZ0Qxb0EvM0tia3dwMlRsV0VMcTZqSUFoNEhkTVJuc3hW?=
 =?utf-8?B?OXlHRkNFSWx3ZVdoajdpZGhieCtKOTN3V0NPNGpFQlptMEJwaDBMUkFjbGFP?=
 =?utf-8?B?dnZMU1pFQ0hxUTNpSjNKM0lXWHI5ZUsyQmQxM1k5UWRURFN4U2RYTVN5WUN1?=
 =?utf-8?B?RC9oWkVaK2lURUpXRjJ4S3NCeVovSXFra1FManV0WVFHWnRhbDhPUlhuRE43?=
 =?utf-8?B?NkJFdStRbncxeHRqcWswQTBSSFhmWjRCbU5FaFl4WGJWVEttaXhYTTJwcUw3?=
 =?utf-8?B?NW1hQUFnQmNZMGFkS1UrRHhIb283YVg1UkI0S1h5T2xNYkY1YkJmeGVNZWNP?=
 =?utf-8?Q?oD6tPRc6Kty8swuumYxXm83fd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a300bd-0174-4ba8-77dc-08dc1e41d3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 07:38:45.5628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4mSIRLSOak6vdcumUw8dCwVpNL22kQIstY8ov6UcLjj9BJIOxTJ9aSV7Wb1m0YPVP6E++V5iV3rZUgMP+IVjYRnBrfNLDbNVGxgNMEiCDg=
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
IHdyb3RlOg0KPiA+DQo+ID4gTmV3ZXIgdmVyc2lvbnMgb2YgU3BpY2Ugc2VydmVyIHNob3VsZCBi
ZSBhYmxlIHRvIGFjY2VwdCBkbWFidWYNCj4gPiBmZHMgZnJvbSBRZW11IGZvciBjbGllbnRzIHRo
YXQgYXJlIGNvbm5lY3RlZCB2aWEgdGhlIG5ldHdvcmsuDQo+ID4gSW4gb3RoZXIgd29yZHMsIHdo
ZW4gdGhpcyBvcHRpb24gaXMgZW5hYmxlZCwgUWVtdSB3b3VsZCBzaGFyZQ0KPiA+IGEgZG1hYnVm
IGZkIHdpdGggU3BpY2Ugd2hpY2ggd291bGQgZW5jb2RlIGFuZCBzZW5kIHRoZSBkYXRhDQo+ID4g
YXNzb2NpYXRlZCB3aXRoIHRoZSBmZCB0byBhIGNsaWVudCB0aGF0IGNvdWxkIGJlIGxvY2F0ZWQg
b24NCj4gPiBhIGRpZmZlcmVudCBtYWNoaW5lLg0KPiA+DQo+ID4gQ2M6IEdlcmQgSG9mZm1hbm4g
PGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogRnJlZGlhbm8gWmlnbGlvIDxmcmVkZHk3N0Bn
bWFpbC5jb20+DQo+ID4gQ2M6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL3VpL3NwaWNlLWRpc3BsYXkuaCB8IDEgKw0KPiA+
ICB1aS9zcGljZS1jb3JlLmMgICAgICAgICAgICB8IDQgKysrKw0KPiA+ICB1aS9zcGljZS1kaXNw
bGF5LmMgICAgICAgICB8IDEgKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWkvc3BpY2UtZGlzcGxheS5oIGIvaW5j
bHVkZS91aS9zcGljZS1kaXNwbGF5LmgNCj4gPiBpbmRleCBlMWE5YjM2MTg1Li5mNDkyMmRkNzRi
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvdWkvc3BpY2UtZGlzcGxheS5oDQo+ID4gKysrIGIv
aW5jbHVkZS91aS9zcGljZS1kaXNwbGF5LmgNCj4gPiBAQCAtMTUxLDYgKzE1MSw3IEBAIHN0cnVj
dCBTaW1wbGVTcGljZUN1cnNvciB7DQo+ID4gIH07DQo+ID4NCj4gPiAgZXh0ZXJuIGJvb2wgc3Bp
Y2Vfb3BlbmdsOw0KPiA+ICtleHRlcm4gYm9vbCByZW1vdGVfY2xpZW50Ow0KPiA+DQo+ID4gIGlu
dCBxZW11X3NwaWNlX3JlY3RfaXNfZW1wdHkoY29uc3QgUVhMUmVjdCogcik7DQo+ID4gIHZvaWQg
cWVtdV9zcGljZV9yZWN0X3VuaW9uKFFYTFJlY3QgKmRlc3QsIGNvbnN0IFFYTFJlY3QgKnIpOw0K
PiA+IGRpZmYgLS1naXQgYS91aS9zcGljZS1jb3JlLmMgYi91aS9zcGljZS1jb3JlLmMNCj4gPiBp
bmRleCAxM2JmYmU0ZTg5Li4zYjlhNTQ2ODVmIDEwMDY0NA0KPiA+IC0tLSBhL3VpL3NwaWNlLWNv
cmUuYw0KPiA+ICsrKyBiL3VpL3NwaWNlLWNvcmUuYw0KPiA+IEBAIC04NDksOSArODQ5LDEzIEBA
IHN0YXRpYyB2b2lkIHFlbXVfc3BpY2VfaW5pdCh2b2lkKQ0KPiA+ICAjaWZkZWYgSEFWRV9TUElD
RV9HTA0KPiA+ICAgICAgaWYgKHFlbXVfb3B0X2dldF9ib29sKG9wdHMsICJnbCIsIDApKSB7DQo+
ID4gICAgICAgICAgaWYgKChwb3J0ICE9IDApIHx8ICh0bHNfcG9ydCAhPSAwKSkgew0KPiA+ICsj
aWYgU1BJQ0VfU0VSVkVSX1ZFUlNJT04gPj0gMHgwMDBmMDMgLyogcmVsZWFzZSAwLjE1LjMgKi8N
Cj4gDQo+IChvaywgd2Ugc2hvdWxkIHdhaXQgZm9yIHRoZSBTcGljZSBzZXJpZXMgdG8gYmUgbWVy
Z2VkKQ0KU3VyZSwgSSdsbCBwb3N0IHRoZSB2MiBhZnRlciB0aGUgU3BpY2Ugc2VyaWVzIGdldHMg
bWVyZ2VkLg0KDQpUaGFua3MsDQpWaXZlaw0KDQo+IA0KPiANCj4gPiArICAgICAgICAgICAgcmVt
b3RlX2NsaWVudCA9IDE7DQo+ID4gKyNlbHNlDQo+ID4gICAgICAgICAgICAgIGVycm9yX3JlcG9y
dCgiU1BJQ0UgR0wgc3VwcG9ydCBpcyBsb2NhbC1vbmx5IGZvciBub3cgYW5kICINCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJpbmNvbXBhdGlibGUgd2l0aCAtc3BpY2UgcG9ydC90bHMt
cG9ydCIpOw0KPiA+ICAgICAgICAgICAgICBleGl0KDEpOw0KPiA+ICsjZW5kaWYNCj4gPiAgICAg
ICAgICB9DQo+ID4gICAgICAgICAgZWdsX2luaXQocWVtdV9vcHRfZ2V0KG9wdHMsICJyZW5kZXJu
b2RlIiksIERJU1BMQVlHTF9NT0RFX09OLA0KPiAmZXJyb3JfZmF0YWwpOw0KPiA+ICAgICAgICAg
IHNwaWNlX29wZW5nbCA9IDE7DQo+ID4gZGlmZiAtLWdpdCBhL3VpL3NwaWNlLWRpc3BsYXkuYyBi
L3VpL3NwaWNlLWRpc3BsYXkuYw0KPiA+IGluZGV4IDZlYjk4YTVhNWMuLjM4NGI4NTA4ZDQgMTAw
NjQ0DQo+ID4gLS0tIGEvdWkvc3BpY2UtZGlzcGxheS5jDQo+ID4gKysrIGIvdWkvc3BpY2UtZGlz
cGxheS5jDQo+ID4gQEAgLTI5LDYgKzI5LDcgQEANCj4gPiAgI2luY2x1ZGUgInVpL3NwaWNlLWRp
c3BsYXkuaCINCj4gPg0KPiA+ICBib29sIHNwaWNlX29wZW5nbDsNCj4gPiArYm9vbCByZW1vdGVf
Y2xpZW50Ow0KPiA+DQo+ID4gIGludCBxZW11X3NwaWNlX3JlY3RfaXNfZW1wdHkoY29uc3QgUVhM
UmVjdCogcikNCj4gPiAgew0KPiA+IC0tDQo+ID4gMi4zOS4yDQo+ID4NCj4gPg0KPiANCj4gDQo+
IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

