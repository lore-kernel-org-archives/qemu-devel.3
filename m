Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A079EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 19:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFyz-0001Xh-07; Wed, 31 Jan 2024 14:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rVFyo-0001Wm-Gj
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:10:40 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rVFyl-0002GM-6n
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706728235; x=1738264235;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VrGR+fBemcmLlf6xGZmjizXf4HPj/F8yzXWvQiXfMxI=;
 b=AIZS2Qux+cZAsauMveOOwCrpblu9qIWiOCp+Ki7FyGBpeF2ap1szU6Uv
 16r37zBlTPqpVQtKlbm37hiA7I6Z3KHkkQ3+9KoEp6vXrmxMUL4MBmTNb
 v4xR25yAEunmw4XNMQrOu1FLH826EnndATd9kVD6ZZhegRmDT4faQU8a2
 jpDU/BSA1l3tIYMZdarReLBQ/DA3lGWZtIHWEYkvFQRDCmG77JemIzqbi
 po+leSZR89sWy/3aaahCS6tXYEm2KSQiuqn0XZew7K1iXT8oFKSXjIUHQ
 iaMKZACzOzoINkgM1G2O89B4htHexmrunHGgkRt7yWQ0NwtvpceDAgYg2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="400830506"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; d="scan'208";a="400830506"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 11:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; d="scan'208";a="22878157"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2024 11:10:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 11:10:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 11:10:31 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 11:10:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6x4gZEkqyD7E/y1LGexPpUldPTiCFJeit5ldPyc8IW0Pt7I7O3PkrSmfd+kGD2zxpvS9WYV97LuPuo2yi3fek0/aPRaWvkRDuVnFrxqAWHFAlr+QeegQVLZI3SdZAtlm9ip5hnt6E/S1GiMOj2uIdy5K9YBGJO19gjl1WFDOb5HCKQiZ1qjFRhnr+KAKweV/Mz9Zo/yVIPSOF2ZFQbE7XjMw1o4QdQgJlF05ZkiD58mHFRmMWp8fARELw2Smc9ETQxXvmeuV62WmqcSPQEkLiKs7zUPEYfS6CtDaUH0N/iuLqcjBNo3PR+/ZL9bZtSEsCOhhvBpUXKFk0+YhL7tBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrGR+fBemcmLlf6xGZmjizXf4HPj/F8yzXWvQiXfMxI=;
 b=nuVnMQmnUUUEdLSkRExGaSDE10hsX1MFcHhP6TjGvJZ8rJoPAquhSTgdBFqOK8mRiYh0a8uvVP/XE+QVFbPahvS0NYCZUN+nH+Qv6SZyjv/ssyYx5QSHWjxX0t7+mz4BVIWwYK/yJN4XOXOHcI/UltZ3KBRyMBsu+uC327Ut2K57MDMXBEMAr4yxUnfTH5LMWM5wBjhkhNwfBB93Ei3imwZiiGhZOpbD1Sw9mmd8jLvF25Afkj799IYOW9oCJkbg4YP0lgWCzmymNdHgaii/+UoQ2jE3Edj3aHuSh8PpV5zPxgcMhySPQ0ikpt9+ZQ3fOqpBy+0tl1ATUEkCEKUqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 19:10:28 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d%6]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 19:10:28 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/3] ui/gtk: set the ui size to 0 when invisible
Thread-Topic: [PATCH 2/3] ui/gtk: set the ui size to 0 when invisible
Thread-Index: AQHaU//bLhwa6CS7806/eG/RIH3+D7DzgdWAgADEfiA=
Date: Wed, 31 Jan 2024 19:10:27 +0000
Message-ID: <PH8PR11MB687929088D824A6F68875FA2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-3-dongwon.kim@intel.com>
 <CAJ+F1CKH6oWkvN44de_FT0hG5vKd8pKapn62OM+DfmQggnDcHg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKH6oWkvN44de_FT0hG5vKd8pKapn62OM+DfmQggnDcHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DM4PR11MB6143:EE_
x-ms-office365-filtering-correlation-id: d5c5ed77-89e9-4886-c013-08dc22904944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFCL2BqUND2FZ7CkpLFfvdMxFWCh00cnfHBXXi5wG5H95rdaUSADcv093n1VwvfSW0O9MRjnE43sVs183GovHCnsjHJCEM1ZIQ5mo7VsdV2MIPOzi0fqXIXzZy9fVI8p/3wuysCF1joegmPgz04zY5lOhdSbGtpfCUW1T2ioCGdK6akAmK+xwkhXdSiTrgmMwUmD7Zsd/hUfU2DVyLYS53Lhk++CU2D8iSFcXE0HkN73RCB5OBhNnhC+iVR4EVqaxtdQd27eIEK8ryZ9/UpZ96dflyJjHE1juD2vArmSKMDnxSfoTetI356oM1lDt8EJ+xtSnQzkdFY3jKVV4o2MK9prRcJGzqu26Kzm0HaW1nDaa1LbbpPKCUE5qGAPIg6ckjVPS78QiDsfOklwK5w1WccoEJh4B3AEXwWgBrn7F6QNHWOS03lApVQ26OyAL0JhobTjVEw0nU8CL/D3DvxeX+80q7+yx9/o0TFUh230jSB11wkyfeOlMznzDShOxWbeofm2OhTtXjHV/GZjUCpNHXhODPfSyNZV8w+l+FjPvdDg9HDRX3mEDhkfA5gwAXqO13LcHrJQOmC3qIlFrBqTBXUyJW/9uBilwgoR7sPSlpgH2Kdryt5Tadum0wDN16HP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(71200400001)(478600001)(53546011)(6506007)(9686003)(86362001)(83380400001)(7696005)(26005)(76116006)(66946007)(38070700009)(66556008)(66446008)(66476007)(64756008)(55016003)(6916009)(38100700002)(122000001)(5660300002)(82960400001)(2906002)(8936002)(8676002)(33656002)(316002)(4326008)(52536014)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0MwZGdUZFNaTS92V1ZIazBacmtYQTRHRERoQTNEenlycy9TUFRxTjkxL0I4?=
 =?utf-8?B?NCtYNjhQK0JXWmlDL0RuSjdtWmgxRWlJWTdxd2kyOTdIb1B4Zm0rMWUrTmFO?=
 =?utf-8?B?MzFzZk1rWWlkbDBxdnBnVjVuNUlUQnNIRjJOeW0ycnRmSVlJQkVsekRlemdK?=
 =?utf-8?B?a0l0KytFMTZDWkgwZ3c4d09RemZGdVd5WUY5bFNlNzUvTVkzbXpqb0ZlYUph?=
 =?utf-8?B?aFp6OWExeWRwc2xkMURoSWJpeEdnMCt5d25LYUFmbUkzdVpSalVOSHhQdEtO?=
 =?utf-8?B?Vm1xSWh1b0pwQjdiWjArWDVFcHJ6NXk3aDdHQm96aU9kajc1SmVnQTh6RVM4?=
 =?utf-8?B?YXF4ODlrRW55eERxSzV0OTRCQ1hIdWZBSmhicmZaNFp6TlRmSEc0cW5JMnc4?=
 =?utf-8?B?MmcxN2xxUmlqNUliREJhUW5LYzY1U2E2cWxCMUFiUVRKcDhVREhkRmMvQ0Zj?=
 =?utf-8?B?MU1vcThWbWJJVWNUV2xsTzQ1eFVMck41ZjY5VlJpT2I5aUVSZWRYK2xxamwx?=
 =?utf-8?B?d29sbW9DalF4eXBIalBUNWNjRmMyS2VoL0dlak1reDA0VXNzU2FJRlFnZVJB?=
 =?utf-8?B?NFdmYVI0Sm55UU45Vzl5dVB2YjdEKzQzY3pWZmd2T3FlZTJFTFQzZ0E5RkpD?=
 =?utf-8?B?bXpsWEVYQmlXYytaTlZ6TExNcE5mWC82YXBVWld3Uk9YUVNaN3R3RFVndExN?=
 =?utf-8?B?QjlSZzV6MVl6aWx6REFYcHBCVzVVVlBmWnpXK1pmVk5yMlNQUnlFNUFkMlAz?=
 =?utf-8?B?aktpdFExTG9JN2tJUVM1aVQvNWQwMXQzM3hzRUFsNXY0ZUNwUDV2dmVLZURB?=
 =?utf-8?B?ajFSZlZoWmlTM0diajdsMk1tbXl4Mnh0Smp3amcxWG5IbGEvd0RjOVBTYkVu?=
 =?utf-8?B?ZW5zWk5NSWhYZGc1L1A5UkptVnI4aGsvb2tUeDNuKzZhYjJ1cmhLUkVGRFAx?=
 =?utf-8?B?b1FXTVFUR1VKOUdrZDJMQmloMGZ3aUZ1R0syUUp6aGlIWkVSTVhwVmhRQlIx?=
 =?utf-8?B?bUI3endTcWFjcmgrNGF2ZDFLUTg3ZXo5Rnozd3ZaWWRDNmZqU2ZEYlc1MUdI?=
 =?utf-8?B?VnJtMGZ0TjhiK0ZSRzBYZEIrRHdJZjY1TDJTZGlLdlVMWW5IWDRYeTBNb3pK?=
 =?utf-8?B?VG5UYkZydjA5ZFlTZW9HWS9qOEdBZXlaV0ltWVNpRjBrTGNwb2NCZk01OU9Q?=
 =?utf-8?B?NUlrUC9aUk5FNUZmZkNIMHNCSzExRFlmRDZwL2NQakdsMVNXc3RJbXdnUXhP?=
 =?utf-8?B?aWRhWDRkb3FhQzV2ZktyVTNvWDFYUHE5YXBxRERiNk1RRGg0Qnh4TitweCtX?=
 =?utf-8?B?UW02aXEweHZlaGdLcHF6bmJleGZOUWRFRXFYeEgyQ2lSalNqaGhyekprTnpE?=
 =?utf-8?B?Nk1nemFtVEFjRVFTU2g0UDg2RFQ2U0EydXFKVHV6L3pxanJSQm5wOE56WnFY?=
 =?utf-8?B?aURkK0F6NGprc3VQalhVdXJ2QllLNHdHbXhNZVpsNE5VUXZjVytPWDBIMjNj?=
 =?utf-8?B?ZHQ0cmFPeGFZajNPdm5QNzhkWkRXb3hrOUp1eGl0N0tvVG5UVG9Hb0tiN085?=
 =?utf-8?B?SUIrTmE3YklEbFNmOGtIa2IyR3RKVk9Qb3dURnFmRHJobnRFZ0R0bXh1d2o2?=
 =?utf-8?B?VklBSmhucERzM1ppc1p4OWNIK21rTHVPWkMxQkhMcVdOQXcyTmxJR0s3OWZj?=
 =?utf-8?B?Z2p1b3BpZ1BFZ3QvZ1dLVm5JcEtnMXBadGNCQUFWdGN0ZlZMcnpWZC9NSGZ2?=
 =?utf-8?B?d3c2by9pN2tBNWtxMnpNeVE2NFZXaGU5QlVRM0FPQWpWRXUwZGwvSy9VUzFT?=
 =?utf-8?B?eDZtcUE0YUo0RjJtVTRUT29QZFY0a0dnWHFGTFJPcXJpc2tFWmxmbG1VN0RP?=
 =?utf-8?B?djZtRnVqR3ZWdzhlL3EyTkxCejMxcVJyY3lEU3VOOVJCK29SaXN3SGsxcmhv?=
 =?utf-8?B?eUR4U0tQOHplWUErejZSWFNjbkpiaHBGaUdsZUEyb200SmZvWUk0Y2FWUGF2?=
 =?utf-8?B?Yy9pa3dVZGhwcGZ5RVJKUGw1UTluemNSSDJ3ZjByU29HcE9ielBmblltUFRZ?=
 =?utf-8?B?YWpMRlJKYU5FcUNBL1FQam54UVcyR3BPZ1N2c29Dbi9FakhYRWdlejJqSllF?=
 =?utf-8?Q?ZkuGDmh7dfvaFIoRo8KbFfMoa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c5ed77-89e9-4886-c013-08dc22904944
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 19:10:27.9004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsBUgh3G+vI2rA9SDBgVX3xe2J0pjL4N900QSQ4TdeOB9OwkPYK7g5D0jlt6TsZcbqnjNJ9jIFj0ofm6fxM7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgSmFudWFyeSAzMCwgMjAyNCAxMToxMyBQTQ0KPiBUbzogS2ltLCBEb25nd29uIDxk
b25nd29uLmtpbUBpbnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzNdIHVpL2d0azogc2V0IHRoZSB1aSBzaXplIHRvIDAgd2hlbiBp
bnZpc2libGUNCj4gDQo+IEhpDQo+IA0KPiBPbiBXZWQsIEphbiAzMSwgMjAyNCBhdCAzOjUw4oCv
QU0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBEb25nd29u
IEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gVUkgc2l6ZSBpcyBzZXQgdG8g
MCB3aGVuIHRoZSBWQyBpcyBpbnZpc2libGUsIHdoaWNoIHdpbGwgcHJldmVudCB0aGUNCj4gPiBm
dXJ0aGVyIHNjYW5vdXQgdXBkYXRlIGJ5IG5vdGlmeWluZyB0aGUgZ3Vlc3QgdGhhdCB0aGUgZGlz
cGxheSBpcyBub3QNCj4gPiBpbiBhY3RpdmUgc3RhdGUuIFRoZW4gaXQgaXMgcmVzdG9yZWQgdG8g
dGhlIG9yaWdpbmFsIHNpemUgd2hlbmV2ZXIgdGhlDQo+ID4gVkMgYmVjb21lcyB2aXNpYmxlIGFn
YWluLg0KPiANCj4gVGhpcyBjYW4gaGF2ZSB1bndhbnRlZCByZXN1bHRzIG9uIG11bHRpIG1vbml0
b3Igc2V0dXBzLCBzdWNoIGFzIG1vdmluZw0KPiB3aW5kb3dzIG9yIGljb25zIGFyb3VuZCBvbiBk
aWZmZXJlbnQgbW9uaXRvcnMuDQoNCltLaW0sIERvbmd3b25dICBZb3UgYXJlIHJpZ2h0LiBUaGlz
IGlzIGp1c3QgYSBjaG9pY2Ugd2UgbWFkZS4NCj4gDQo+IFN3aXRjaGluZyB0YWJzIG9yIG1pbmlt
aXppbmcgdGhlIGRpc3BsYXkgd2luZG93IHNob3VsZG4ndCBjYXVzZSBhIGd1ZXN0DQo+IGRpc3Bs
YXkgcmVjb25maWd1cmF0aW9uLg0KPiANCj4gV2hhdCBpcyB0aGUgYmVuZWZpdCBvZiBkaXNhYmxp
bmcgdGhlIG1vbml0b3IgaGVyZT8gSXMgaXQgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnM/DQoNCltL
aW0sIERvbmd3b25dIE5vdCBzdXJlIGlmIHlvdSByZWNvZ25pemVkIGl0IGJ1dCB0aGlzIHBhdGNo
IHNlcmllcyB3YXMgYSBwYXJ0IG9mDQpvdXIgVk0gZGlzcGxheSBob3QtcGx1ZyBmZWF0dXJlIHdl
IHN1Ym1pdHRlZCBhIGZldyBtb250aHMgYWdvLiBUaGVyZSwgd2UgYWRkZWQgYSBuZXcNCnBhcmFt
IGNhbGxlZCBjb25uZWN0b3JzIHRvIGhhdmUgYSB3YXkgdG8gZml4IGluZGl2aWR1YWwgVk0gZGlz
cGxheXMgKGluIG11bHRpIGRpc3BsYXkgZW52KQ0Kb24gZGlmZmVyZW50IHBoeXNpY2FsIGRpc3Bs
YXlzIHRoZXJlIGFuZCBtYWRlIHRoZSBWTSBkaXNwbGF5IGRpc2Nvbm5lY3RlZCB3aGVuDQphc3Nv
Y2lhdGVkIHBoeXNpY2FsIG9uZSBpcyBkaXNjb25uZWN0ZWQuIFdlIGp1c3Qgd2FudGVkIHRvIG1h
a2UgdGFiIHN3aXRjaGluZyBhbmQNCndpbmRvdyBtaW5pbWl6YXRpb24gZG8gdGhlIHNpbWlsYXIg
dG8gbWFrZSBhbGwgb2YgdGhpcyBsb2dpYyBjb25zaXN0ZW50LiANCg0KSG93ZXZlciwgaWYgaXQg
bWFrZXMgbW9yZSBzZW5zZSB0byBoYXZlIHRob3NlIGRpc3BsYXlzIGFsbCBjb25uZWN0ZWQgZXZl
biB3aGVuDQp0aG9zZSBhcmUgbm90IHNob3duIGV4Y2VwdCBmb3IgdGhlIGNhc2Ugb2YgaG90LXBs
dWcgaW4sIHdlIGNvdWxkIGNoYW5nZSB0aGUgbG9naWMuDQpCdXQgYXMgeW91IG1lbnRpb25lZCwg
dGhlcmUgd2lsbCBiZSBzb21lIHdhc3RlIG9mIGJhbmR3aWR0aCBhbmQgcGVyZiBzaW5jZSB0aGUN
Cmd1ZXN0IHdpbGwga2VlcCBzZW5kaW5nIG91dCBzY2FuLW91dCBmcmFtZXMgdGhhdCB3b3VsZCBi
ZSBqdXN0IGR1bXBlZC4NCg0KVGhpcyBtaWdodCBiZSBhIG1pbm9yIHRoaW5nIGJ1dCBhbm90aGVy
IGNvbmNlcm4gaXMgYWJvdXQgdGFiLXN3aXRjaGluZy4gSW5pdGlhbGx5LCB0aGUgZ3Vlc3QNCndp
bGwgZGV0ZWN0IG9ubHkgb25lIGRpc3BsYXkgZXZlbiBpZiB0aGUgbWF4LW91dHB1dCBpcyBzZXQg
dG8gTiAob3RoZXIgdGhhbiAxKS4gTXVsdGkgZGlzcGxheXMNCndpbGwgYmUgZGV0ZWN0ZWQgb25j
ZSB5b3UgZGV0YWNoIG9yIHN3aXRjaCB0byBhbm90aGVyIHRhYi4gVGhlbiBpZiB5b3UgbW92ZSB0
byB0aGUgb3JpZ2luYWwNCnRhYiBvciBjbG9zZSB0aGUgZGV0YWNoZWQgd2luZG93LCB0aGUgZ3Vl
c3Qgd29uJ3QgZ28gYmFjayB0byBzaW5nbGUgZGlzcGxheSBzZXR1cC4NCkFsbCBtdWx0aS1kaXNw
bGF5cyB3aWxsIGV4aXN0IGluIGl0cyBzZXR1cCBhbmQgdGhpcyBkb2VzbuKAmXQgbG9vayBjb25z
aXN0ZW50IHRvIG1lLg0KDQo+IA0KPiA+DQo+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxA
cmVkaGF0LmNvbT4NCj4gPiBDYzogVml2ZWsgS2FzaXJlZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRl
bC5jb20+DQo+ID4gLS0tDQo+ID4gIHVpL2d0ay5jIHwgMTUgKysrKysrKysrKysrKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiA+IGluZGV4IDAyZWI2NjdkOGEu
LjY1MWVkMzQ5MmYgMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLmMNCj4gPiArKysgYi91aS9ndGsu
Yw0KPiA+IEBAIC0xMzE0LDEwICsxMzE0LDEyIEBAIHN0YXRpYyB2b2lkIGdkX21lbnVfc3dpdGNo
X3ZjKEd0a01lbnVJdGVtDQo+ICppdGVtLCB2b2lkICpvcGFxdWUpDQo+ID4gICAgICBHdGtEaXNw
bGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gICAgICBWaXJ0dWFsQ29uc29sZSAqdmM7DQo+ID4g
ICAgICBHdGtOb3RlYm9vayAqbmIgPSBHVEtfTk9URUJPT0socy0+bm90ZWJvb2spOw0KPiA+ICsg
ICAgR2RrV2luZG93ICp3aW5kb3c7DQo+ID4gICAgICBnaW50IHBhZ2U7DQo+ID4NCj4gPiAgICAg
IHZjID0gZ2RfdmNfZmluZF9jdXJyZW50KHMpOw0KPiA+ICAgICAgdmMtPmdmeC52aXNpYmxlID0g
ZmFsc2U7DQo+ID4gKyAgICBnZF9zZXRfdWlfc2l6ZSh2YywgMCwgMCk7DQo+ID4NCj4gPiAgICAg
IHZjID0gZ2RfdmNfZmluZF9ieV9tZW51KHMpOw0KPiA+ICAgICAgZ3RrX3JlbGVhc2VfbW9kaWZp
ZXJzKHMpOw0KPiA+IEBAIC0xMzI1LDYgKzEzMjcsOSBAQCBzdGF0aWMgdm9pZCBnZF9tZW51X3N3
aXRjaF92YyhHdGtNZW51SXRlbQ0KPiAqaXRlbSwgdm9pZCAqb3BhcXVlKQ0KPiA+ICAgICAgICAg
IHBhZ2UgPSBndGtfbm90ZWJvb2tfcGFnZV9udW0obmIsIHZjLT50YWJfaXRlbSk7DQo+ID4gICAg
ICAgICAgZ3RrX25vdGVib29rX3NldF9jdXJyZW50X3BhZ2UobmIsIHBhZ2UpOw0KPiA+ICAgICAg
ICAgIGd0a193aWRnZXRfZ3JhYl9mb2N1cyh2Yy0+Zm9jdXMpOw0KPiA+ICsgICAgICAgIHdpbmRv
dyA9IGd0a193aWRnZXRfZ2V0X3dpbmRvdyh2Yy0+Z2Z4LmRyYXdpbmdfYXJlYSk7DQo+ID4gKyAg
ICAgICAgZ2Rfc2V0X3VpX3NpemUodmMsIGdka193aW5kb3dfZ2V0X3dpZHRoKHdpbmRvdyksDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ2RrX3dpbmRvd19nZXRfaGVpZ2h0KHdpbmRvdykp
Ow0KPiA+ICAgICAgICAgIHZjLT5nZngudmlzaWJsZSA9IHRydWU7DQo+ID4gICAgICB9DQo+ID4g
IH0NCj4gPiBAQCAtMTM1Niw2ICsxMzYxLDcgQEAgc3RhdGljIGdib29sZWFuIGdkX3RhYl93aW5k
b3dfY2xvc2UoR3RrV2lkZ2V0DQo+ICp3aWRnZXQsIEdka0V2ZW50ICpldmVudCwNCj4gPiAgICAg
IEd0a0Rpc3BsYXlTdGF0ZSAqcyA9IHZjLT5zOw0KPiA+DQo+ID4gICAgICB2Yy0+Z2Z4LnZpc2li
bGUgPSBmYWxzZTsNCj4gPiArICAgIGdkX3NldF91aV9zaXplKHZjLCAwLCAwKTsNCj4gPiAgICAg
IGd0a193aWRnZXRfc2V0X3NlbnNpdGl2ZSh2Yy0+bWVudV9pdGVtLCB0cnVlKTsNCj4gPiAgICAg
IGdkX3dpZGdldF9yZXBhcmVudCh2Yy0+d2luZG93LCBzLT5ub3RlYm9vaywgdmMtPnRhYl9pdGVt
KTsNCj4gPiAgICAgIGd0a19ub3RlYm9va19zZXRfdGFiX2xhYmVsX3RleHQoR1RLX05PVEVCT09L
KHMtPm5vdGVib29rKSwNCj4gPiBAQCAtMTM5MSw2ICsxMzk3LDcgQEAgc3RhdGljIGdib29sZWFu
IGdkX3dpbl9ncmFiKHZvaWQgKm9wYXF1ZSkNCj4gPiBzdGF0aWMgdm9pZCBnZF9tZW51X3VudGFi
aWZ5KEd0a01lbnVJdGVtICppdGVtLCB2b2lkICpvcGFxdWUpICB7DQo+ID4gICAgICBHdGtEaXNw
bGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gKyAgICBHZGtXaW5kb3cgKndpbmRvdzsNCj4gPiAg
ICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IGdkX3ZjX2ZpbmRfY3VycmVudChzKTsNCj4gPg0KPiA+
ICAgICAgaWYgKHZjLT50eXBlID09IEdEX1ZDX0dGWCAmJg0KPiA+IEBAIC0xNDI5LDYgKzE0MzYs
MTAgQEAgc3RhdGljIHZvaWQgZ2RfbWVudV91bnRhYmlmeShHdGtNZW51SXRlbQ0KPiAqaXRlbSwg
dm9pZCAqb3BhcXVlKQ0KPiA+ICAgICAgICAgIGdkX3VwZGF0ZV9nZW9tZXRyeV9oaW50cyh2Yyk7
DQo+ID4gICAgICAgICAgZ2RfdXBkYXRlX2NhcHRpb24ocyk7DQo+ID4gICAgICB9DQo+ID4gKw0K
PiA+ICsgICAgd2luZG93ID0gZ3RrX3dpZGdldF9nZXRfd2luZG93KHZjLT5nZnguZHJhd2luZ19h
cmVhKTsNCj4gPiArICAgIGdkX3NldF91aV9zaXplKHZjLCBnZGtfd2luZG93X2dldF93aWR0aCh3
aW5kb3cpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgZ2RrX3dpbmRvd19nZXRfaGVpZ2h0KHdp
bmRvdykpOw0KPiA+ICAgICAgdmMtPmdmeC52aXNpYmxlID0gdHJ1ZTsNCj4gPiAgfQ0KPiA+DQo+
ID4gQEAgLTE3NTMsNyArMTc2NCw5IEBAIHN0YXRpYyBnYm9vbGVhbiBnZF9jb25maWd1cmUoR3Rr
V2lkZ2V0ICp3aWRnZXQsDQo+ID4gew0KPiA+ICAgICAgVmlydHVhbENvbnNvbGUgKnZjID0gb3Bh
cXVlOw0KPiA+DQo+ID4gLSAgICBnZF9zZXRfdWlfc2l6ZSh2YywgY2ZnLT53aWR0aCwgY2ZnLT5o
ZWlnaHQpOw0KPiA+ICsgICAgaWYgKHZjLT5nZngudmlzaWJsZSkgew0KPiA+ICsgICAgICAgIGdk
X3NldF91aV9zaXplKHZjLCBjZmctPndpZHRoLCBjZmctPmhlaWdodCk7DQo+ID4gKyAgICB9DQo+
ID4gICAgICByZXR1cm4gRkFMU0U7DQo+ID4gIH0NCj4gPg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+
ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

