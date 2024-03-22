Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E534C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 02:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnUIv-0000ZZ-43; Thu, 21 Mar 2024 22:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rnUIt-0000ZN-TI
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 22:06:43 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rnUIr-0006Hp-05
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 22:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711073201; x=1742609201;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N948lLTD2Vbd6fOm541cu1XhKBhEEJNm2BOZnPITA+A=;
 b=lIO4E3WH/3yfOE40Xms771QFwk6X5qZmu+tZfTQgAHicjV3rSWD5CsXP
 0jGo+2EHqgj58IbmsIr0C8BUGGAV/DG4iw7NfCww+XSzYq4OAUg2g/29T
 kGziQKEgtTKik2jVGP50I5LlD1vZ8ilg0x0tnhrwrOKkBk19R/fPF5Nyf
 xNJi7JVmslddA6w2HfjnG9CRMYhnVFW39ypRShYyoh1C/GANaWa//k2k2
 tKtBNkBxG0Q7anjnn5drCKE0Y0Z3ij5KSNW6CcBRJY4oRtXN9KPlYL9S7
 MHc5Jslb4382SmabxAP+mQnPp+Op9xRXhjJaxo8ZQXIttLq7ZYi8pQkH7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="23592458"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; d="scan'208";a="23592458"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2024 19:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; d="scan'208";a="19427981"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Mar 2024 19:06:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 19:06:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 19:06:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 19:06:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 19:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1DaHUJWA3jNB1sepydeptWN0OL0jpOXM98pxYkgrM0mfkaCksC4A4Z65esu9WrbQvtGTTr8kY+qtBVavd7ht3/T3U+8nsxVP6Gng2FY18C8ZGLomxgLdDE51/xDocImG/JJeo5nKuCtXRAp52TfiEZrVnR1lfkuZysdMDypsHuu6ePazTprEjTDBaNt27IVdYchK5Jq1yzeARQ9QI+ilHfGE+o03wRc1gh7yiZWlvjYFsPMnITwYTrHjG3UgMZxUaJ+odoxm5XLqSXDGAKBMRuY4fwfmKQj7/Rvka1ACiCfhwACdCs0YO6bo2MwHL1LNNAV+tl3+wJOdUtzhQ0Fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N948lLTD2Vbd6fOm541cu1XhKBhEEJNm2BOZnPITA+A=;
 b=nwiWGJrC7iXM5Mw5sZGTnYPWAIJxaK6I67C2GkGkKPOK5vuWAvXlvwHzdU0Gpmjqfe5uFTnXbegKzNv3/oHuJiDv1H/jC1h9tjEabgq1t1aFLSu2eguJxFrOYtqkxeIXb52wpTbgEokYMqxLvE24SZhu2imMtBHLg7O1j7FIEUrxnt9KZ1b5VV/6NPiMhCaCT+vHR4HMP3ZxvAi1e1EuOLfcdU5ZSQmT9qu59yLIinrnwSkKe/PHjpNp+HuiGEja16umx9C8Kh5/qELw4UsoFs7lEHpGzjkiBm8Xa5i2j0s01wdK4xe1HMiZw6EirQ5j+rYENPljW99bQ7yLBAdpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS0PR11MB7578.namprd11.prod.outlook.com (2603:10b6:8:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 22 Mar
 2024 02:06:33 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 02:06:32 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHaeqFFcriI4s02jkWbmxh5d6Bh27FAcVgAgABDk6CAAA4OAIAACKEggABKaQCAAFH34IAA63wAgACmUnA=
Date: Fri, 22 Mar 2024 02:06:32 +0000
Message-ID: <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com> <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfxSAgJECCOqtGRh@x1n>
In-Reply-To: <ZfxSAgJECCOqtGRh@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS0PR11MB7578:EE_
x-ms-office365-filtering-correlation-id: 51ff64b2-52ea-4d92-b805-08dc4a14b233
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5yrNajIMXFRbsA+jbdPK1QU8kMwydVnRFEd9lERO9pDVFtXqZhacL+FcHvm4e/4AHuG1kMDDYShQTSRwjN82lEyYnUoPiFakH8Oc3koXIYsq98xm+cio6SR/Adgt7rEt1LJ+yIWOMmihZisPSJHfPDLnRMv9Vgtky5GU1F090CkGovEXglsbpDB5R51+B1sGq/BF0VQDVP6tKqlS+VNc8+jfJww6HRUlVvtSYL91/I+J8KuO/XceMkA0jLBM+pcRytVuElKJv4Gf04uvKKEN6L1Nz0RWEjkBhbSPKsXKAgGl3EgyDVaoLPpvc2gvA61lQgTTtutjlXWyOCB5ZCz+ZUK3h1OEh1uGN0uRcLl4NbPLIa0Zdi0bNv5x3FBQqa6br2KdH2RbrEijtI7tPl7uYvN0+2PuiKaHWvZsllGHmWwnzShOUt96khECzfuYLmCkrmcXenZMApxkB9egjxLXvYrxr4Tl3rWc5XxjWEAqPIkMt1464EKV+yo9m+sGSzG6/h8Em7zVOuAh4RdPulQN848SgQc4pvwPe7cKcOZUqLG/tmfkx4+9VjhbUeHZUtZN0dCkRyOWnLABHRmUxAFMk4b1vb1ADCb55bcKySiE0G+Z+HVAMkcmglK0ISCyyLSBEY0101sIfSfu3fOLSEfHVFG29XlGLrLsIIMkFOUdQ7+8ISiCfxA4fD7GSn6zhW1HXvJLSnRqEwI2wTS324C0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnM4Q09YSW1TdWJncWQzTTF0U20xZmJObFc2SG5qMjUrMk9lM1FNcXo1UEFz?=
 =?utf-8?B?bE45TmpWeDM3OFZmTzdHY2xucml5OFM5bGNBR01jWU9ubkR3OXpXazlnTmdo?=
 =?utf-8?B?U0ZCTElWZUJKRnptdlhIN3FXVmtnTnVURHppT3llcXJSazdKdzBDZ3MwS2hD?=
 =?utf-8?B?d0ZCWU0xVWg0KzJaRzdhajRLYnZYc29aTjhRWTJBSUIvUXZmb0NxUS9IOEEz?=
 =?utf-8?B?OUhJN0pHYWI3YURna0FhR3lteWlpUk5zeS9KSHR0bWpFa1UwanpGeWc3TENS?=
 =?utf-8?B?VC9URElDUVh6M2xrWWp5WGNJYnp2WncrYzIvdWNUaSt3emRzRVpLNXplb2Q2?=
 =?utf-8?B?SU5hT0YzOHltbjZRWUtiZVU3WjlrSVl3UEx2TXZ5TWs4KythOVBvTnJ2Qnpz?=
 =?utf-8?B?UUthNXVpbjd1Tk9oSXlpbDZyWGRvRDJRMEZzSUgraGZTaU84b3RydFo1b1FV?=
 =?utf-8?B?ZDNLQmRnY0c1VFVJNTVKUUxWd0Jrc2FWdjh0dmZEQWEvNHQ1R3hXTDRuWVpn?=
 =?utf-8?B?UUhRS1ppMmFQZkVpN1ZtN1hQY3RVWWFJaEtBSjE2c0JIK01JQW4wZzVFM255?=
 =?utf-8?B?Zi90S1g2a3gxQnZZZ0pBMmtxSDN3QnJrYVlFcjlYQjhqVUFFWTE5T05xSURw?=
 =?utf-8?B?cjZQMk5CRVF6RzZQdzZ6Uzh4SFJYeU5Vb2JRVUVvYUQyUFprRldiRXpZQitY?=
 =?utf-8?B?UjBNVFZuTGlTbjJaVFZHdG9PTG9lb3RNTTRhQkpuczVYWEVWSkY3YVdmNEhK?=
 =?utf-8?B?UGVyREh2ZGVNWXAyNTVDKzBvSURleit6clNLVmxMbG5DMWxqQkRSL0cvZGkv?=
 =?utf-8?B?cnNnRGp2UXBoT3pmVTFFdU52enMxdFI0NTM4bUpneEFPdHpBRVYvaXl0MEll?=
 =?utf-8?B?ZFdBOWt4VEpYOGtZajdIcHY4QlFsdmFNd3lZN2dpQWlieTBwTDhURWVDMml0?=
 =?utf-8?B?dEdiRmtMaDY2UklXQ0pUdDRSK0NRSWROaGc0SVJSdjB2SDZ3SWllZ1FRb3g3?=
 =?utf-8?B?WktCNFRpdjZUNXRvT0VHRjFTVFg4NlFCSEJTdk1ZdkNWdVQ2WVRtK3Z3S1Vy?=
 =?utf-8?B?N29OMmVyd2F5QUJ0aStwZzFnMmppNEI1aGxMQnB1MzZHVkNmbEdiWUFjMUtl?=
 =?utf-8?B?elZvMW9hSlJ0QW1DVFBVOW5Vd01IMHFSSUY3WUlHUHRoWFdHWXFIK2lodWFs?=
 =?utf-8?B?ckNXcFZON0g2dHVPdDJTYW9VeXFTcjYzclEva0ZUUTBKT3c3VGVvTWJJMVUx?=
 =?utf-8?B?TjNDN1piU1EvMUk1VXgwbXloT0NURG9vZklOSjV2UW16T1duSCt3WnlhMlNr?=
 =?utf-8?B?bU51R3RWOExONTRGRVpRMTlwMXpBZ29uYUVyYitHNGIxbEZ5b0RhZzdoQTBn?=
 =?utf-8?B?U3piQUM5RXR4YjNaelhReVRzK0lvYm51Q0RFVlJSQjYxMXo1WGU4T2ZPOGcy?=
 =?utf-8?B?NUdwS25kOVNrU3ZpamtYZjVNZGpURHZ4VFRRalQrZGJUekdYUW0zVlpLazlh?=
 =?utf-8?B?M0dOSTh1emtuRC8vdloxSmVKY1dxNlFnMWM3R2JjVStIL3hHTElYOHlTM2xT?=
 =?utf-8?B?Rnc1dkJzR21xM1JaUmN0YzE1ZzJHdENpNjZwOEVjMGo3SHZ6MWdRWGpqNVBC?=
 =?utf-8?B?eHVBYlNaMkpITXNlNzBXK1JpVzNobzJ2UmFBK0c0WFJydlJhd1l1NHAwTGNr?=
 =?utf-8?B?d2FvOFRmaW0wd3pHWjNQMUlub2lETDlLeG9TOHpHQTBia0ZGbmIzUVM3UVpx?=
 =?utf-8?B?eW1FTk42eWRMTHNVKzV2Z2ZTZUJPN2h6bXNWTlJhVExSUTZCanM5V1dUNlE2?=
 =?utf-8?B?dUFraVVTbk9Zc1Y0WURpSExlOWJMRFZzL0tqbUhsNXlxQlU0c1J0dDUzY3hO?=
 =?utf-8?B?SUpSOE51Uit2aHhwa1RGZXEyRDFMelN1NEFkTmF2d0Y5OWxGbUFKd0lTaDBn?=
 =?utf-8?B?aWl5OVEwc2dvVTJSTzJwQWM3c1ZHWm9oZ2YvOW9taDFOOWhnamI5S0ozb1BP?=
 =?utf-8?B?K21uWmo2b0NyWThjRlZDZVRIb0ZJM2JvbUxPTUhRTjZuR0k2QVdGdG52UldK?=
 =?utf-8?B?bGJTUnExK2dDNkNUekxlL2hHTURUZ0x4S2dIMENrbFcwOG9UWlEreTFZUHFM?=
 =?utf-8?Q?zjJfJcN+l7bBIwWEr3A3Zn+MN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ff64b2-52ea-4d92-b805-08dc4a14b233
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 02:06:32.8799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgYHiT14AH3KnkpVVc8yyAOq7981qLJOht9LuDSDD1Mg33j01sblVbmXOR1L3tk0m5v6eRJfVwX8hSt6fnnIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7578
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMSwgMjAyNCAxMToyOCBQTQ0KPiBU
bzogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT4NCj4gQ2M6IERhbmllbCBQLiBCZXJy
YW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBmYXJvc2FzQHN1c2UuZGU7IHFlbXUtDQo+IGRl
dmVsQG5vbmdudS5vcmc7IGhhby54aWFuZ0BieXRlZGFuY2UuY29tOyBicnlhbi56aGFuZ0BieXRl
ZGFuY2UuY29tOyBab3UsDQo+IE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjUgNS83XSBtaWdyYXRpb24vbXVsdGlmZDogaW1wbGVtZW50IGluaXRp
YWxpemF0aW9uIG9mDQo+IHFwbCBjb21wcmVzc2lvbg0KPiANCj4gT24gVGh1LCBNYXIgMjEsIDIw
MjQgYXQgMDE6Mzc6MzZBTSArMDAwMCwgTGl1LCBZdWFuMSB3cm90ZToNCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5j
b20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjEsIDIwMjQgNDozMiBBTQ0KPiA+ID4g
VG86IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+ID4gPiBDYzogRGFuaWVsIFAu
IEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IGZhcm9zYXNAc3VzZS5kZTsgcWVtdS0N
Cj4gPiA+IGRldmVsQG5vbmdudS5vcmc7IGhhby54aWFuZ0BieXRlZGFuY2UuY29tOyBicnlhbi56
aGFuZ0BieXRlZGFuY2UuY29tOw0KPiBab3UsDQo+ID4gPiBOYW5oYWkgPG5hbmhhaS56b3VAaW50
ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzddIG1pZ3JhdGlvbi9tdWx0
aWZkOiBpbXBsZW1lbnQNCj4gaW5pdGlhbGl6YXRpb24gb2YNCj4gPiA+IHFwbCBjb21wcmVzc2lv
bg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDA0OjIzOjAxUE0gKzAwMDAs
IExpdSwgWXVhbjEgd3JvdGU6DQo+ID4gPiA+IGxldCBtZSBleHBsYWluIGhlcmUsIGR1cmluZyB0
aGUgZGVjb21wcmVzc2lvbiBvcGVyYXRpb24gb2YgSUFBLCB0aGUNCj4gPiA+ID4gZGVjb21wcmVz
c2VkIGRhdGEgY2FuIGJlIGRpcmVjdGx5IG91dHB1dCB0byB0aGUgdmlydHVhbCBhZGRyZXNzIG9m
DQo+IHRoZQ0KPiA+ID4gPiBndWVzdCBtZW1vcnkgYnkgSUFBIGhhcmR3YXJlLiAgSXQgY2FuIGF2
b2lkIGNvcHlpbmcgdGhlIGRlY29tcHJlc3NlZA0KPiA+ID4gZGF0YQ0KPiA+ID4gPiB0byBndWVz
dCBtZW1vcnkgYnkgQ1BVLg0KPiA+ID4NCj4gPiA+IEkgc2VlLg0KPiA+ID4NCj4gPiA+ID4gV2l0
aG91dCAtbWVtLXByZWFsbG9jLCBhbGwgdGhlIGd1ZXN0IG1lbW9yeSBpcyBub3QgcG9wdWxhdGVk
LCBhbmQNCj4gSUFBDQo+ID4gPiA+IGhhcmR3YXJlIG5lZWRzIHRvIHRyaWdnZXIgSS9PIHBhZ2Ug
ZmF1bHQgZmlyc3QgYW5kIHRoZW4gb3V0cHV0IHRoZQ0KPiA+ID4gPiBkZWNvbXByZXNzZWQgZGF0
YSB0byB0aGUgZ3Vlc3QgbWVtb3J5IHJlZ2lvbi4gIEJlc2lkZXMgdGhhdCwgQ1BVDQo+IHBhZ2UN
Cj4gPiA+ID4gZmF1bHRzIHdpbGwgYWxzbyB0cmlnZ2VyIElPVExCIGZsdXNoIG9wZXJhdGlvbiB3
aGVuIElBQSBkZXZpY2VzIHVzZQ0KPiBTVk0uDQo+ID4gPg0KPiA+ID4gT2ggc28gdGhlIElBQSBo
YXJkd2FyZSBhbHJlYWR5IGNhbiB1c2UgQ1BVIHBndGFibGVzPyAgTmljZS4uDQo+ID4gPg0KPiA+
ID4gV2h5IElPVExCIGZsdXNoIGlzIG5lZWRlZD8gIEFGQUlVIHdlJ3JlIG9ubHkgaW5zdGFsbGlu
ZyBuZXcgcGFnZXMsIHRoZQ0KPiA+ID4gcmVxdWVzdCBjYW4gZWl0aGVyIGNvbWUgZnJvbSBhIENQ
VSBhY2Nlc3Mgb3IgYSBETUEuICBJbiBhbGwgY2FzZXMNCj4gdGhlcmUNCj4gPiA+IHNob3VsZCBo
YXZlIG5vIHRlYXJpbmcgZG93biBvZiBhbiBvbGQgcGFnZS4gIElzbid0IGFuIGlvdGxiIGZsdXNo
IG9ubHkNCj4gPiA+IG5lZWRlZCBpZiBhIHRlYXIgZG93biBoYXBwZW5zPw0KPiA+DQo+ID4gQXMg
ZmFyIGFzIEkga25vdywgSUFBIGhhcmR3YXJlIHVzZXMgU1ZNIHRlY2hub2xvZ3kgdG8gdXNlIHRo
ZSBDUFUncyBwYWdlDQo+IHRhYmxlDQo+ID4gZm9yIGFkZHJlc3MgdHJhbnNsYXRpb24gKElPTU1V
IHNjYWxhYmxlIG1vZGUgZGlyZWN0bHkgYWNjZXNzZXMgdGhlIENQVQ0KPiBwYWdlIHRhYmxlKS4N
Cj4gPiBUaGVyZWZvcmUsIHdoZW4gdGhlIENQVSBwYWdlIHRhYmxlIGNoYW5nZXMsIHRoZSBkZXZp
Y2UncyBJbnZhbGlkYXRpb24NCj4gb3BlcmF0aW9uIG5lZWRzDQo+ID4gdG8gYmUgdHJpZ2dlcmVk
IHRvIHVwZGF0ZSB0aGUgSU9NTVUgYW5kIHRoZSBkZXZpY2UncyBjYWNoZS4NCj4gPg0KPiA+IE15
IGN1cnJlbnQga2VybmVsIHZlcnNpb24gaXMgbWFpbmxpbmUgNi4yLiBUaGUgaXNzdWUgSSBzZWUg
aXMgYXMNCj4gZm9sbG93czoNCj4gPiAtLUhhbmRsZV9tbV9mYXVsdA0KPiA+ICB8DQo+ID4gICAt
LSB3cF9wYWdlX2NvcHkNCj4gDQo+IFRoaXMgaXMgdGhlIENvVyBwYXRoLiAgTm90IHVzdWFsIGF0
IGFsbC4uDQo+IA0KPiBJIGFzc3VtZSB0aGlzIGlzc3VlIHNob3VsZCBvbmx5IHByZXNlbnQgb24g
ZGVzdGluYXRpb24uICBUaGVuIHRoZSBndWVzdA0KPiBwYWdlcyBzaG91bGQgYmUgdGhlIGRlc3Rp
bmF0aW9uIG9mIHN1Y2ggRE1BcyB0byBoYXBwZW4sIHdoaWNoIG1lYW5zIHRoZXNlDQo+IHNob3Vs
ZCBiZSB3cml0ZSBmYXVsdHMsIGFuZCBhcyB3ZSBzZWUgaGVyZSBpdCBpcywgb3RoZXJ3aXNlIGl0
IHdvbid0DQo+IHRyaWdnZXIgYSBDb1cuDQo+IA0KPiBIb3dldmVyIGl0J3Mgbm90IGNsZWFyIHRv
IG1lIHdoeSBhIHByZS1pbnN0YWxsZWQgemVybyBwYWdlIGV4aXN0ZWQuICBJdA0KPiBtZWFucyBz
b21lb25lIHJlYWQgdGhlIGd1ZXN0IHBhZ2VzIGZpcnN0Lg0KPiANCj4gSXQgbWlnaHQgYmUgaW50
ZXJlc3RpbmcgdG8ga25vdyBfd2h5XyBzb21lb25lIHJlYWRzIHRoZSBndWVzdCBwYWdlcywgZXZl
bg0KPiBpZiB3ZSBrbm93IHRoZXkncmUgYWxsIHplcm9zLiAgSWYgd2UgY2FuIGF2b2lkIHN1Y2gg
cmVhZHMgdGhlbiBpdCdsbCBiZSBhDQo+IGhvbGUgcmF0aGVyIHRoYW4gYSBwcmVmYXVsdGVkIHJl
YWQgb24gemVybyBwYWdlLCB0aGVuIGludmFsaWRhdGlvbnMgYXJlDQo+IG5vdA0KPiBuZWVkZWQs
IGFuZCBJIGV4cGVjdCB0aGF0IHNob3VsZCBmaXggdGhlIGlvdGxiIHN0b3JtIGlzc3VlLg0KDQpU
aGUgcmVjZWl2ZWQgcGFnZXMgd2lsbCBiZSByZWFkIGZvciB6ZXJvIHBhZ2VzIGNoZWNrIGZpcnN0
LiBBbHRob3VnaA0KdGhlc2UgcGFnZXMgYXJlIHplcm8gcGFnZXMsIGFuZCBJQUEgaGFyZHdhcmUg
d2lsbCBub3QgYWNjZXNzIHRoZW0sIHRoZQ0KQ09XIGhhcHBlbnMgYW5kIGNhdXNlcyBmb2xsb3dp
bmcgSU9UTEIgZmx1c2ggb3BlcmF0aW9uLiBBcyBmYXIgYXMgSSBrbm93LCANCklPTU1VIHF1aWNr
bHkgZGV0ZWN0cyB3aGV0aGVyIHRoZSBhZGRyZXNzIHJhbmdlIGhhcyBiZWVuIHVzZWQgYnkgdGhl
IGRldmljZSwNCmFuZCBkb2VzIG5vdCBpbnZhbGlkYXRlIHRoZSBhZGRyZXNzIHRoYXQgaXMgbm90
IHVzZWQgYnkgdGhlIGRldmljZSwgdGhpcyBoYXMgDQpub3QgeWV0IGJlZW4gcmVzb2x2ZWQgaW4g
TGludXgga2VybmVsIDYuMi4gSSB3aWxsIGNoZWNrIHRoZSBsYXRlc3Qgc3RhdHVzIGZvcg0KdGhp
cy4NCnZvaWQgbXVsdGlmZF9yZWN2X3plcm9fcGFnZV9wcm9jZXNzKE11bHRpRkRSZWN2UGFyYW1z
ICpwKQ0Kew0KICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcC0+emVyb19udW07IGkrKykgew0KICAg
ICAgICB2b2lkICpwYWdlID0gcC0+aG9zdCArIHAtPnplcm9baV07DQogICAgICAgIGlmICghYnVm
ZmVyX2lzX3plcm8ocGFnZSwgcC0+cGFnZV9zaXplKSkgew0KICAgICAgICAgICAgbWVtc2V0KHBh
Z2UsIDAsIHAtPnBhZ2Vfc2l6ZSk7DQogICAgICAgIH0NCiAgICB9DQp9DQoNCg0KPiBJdCdsbCBz
dGlsbCBiZSBnb29kIHdlIGNhbiBmaXggdGhpcyBmaXJzdCB0byBub3QgbWFrZSBxcGwgc3BlY2lh
bCBmcm9tDQo+IHRoaXMNCj4gcmVnYXJkLCBzbyB0aGF0IHRoZSBob3BlIGlzIG1pZ3JhdGlvbiBz
dWJtb2R1bGUgc2hvdWxkbid0IHJlbHkgb24gYW55DQo+IHByZS1jb25maWcgKC1tZW0tcHJlYWxs
b2MpIG9uIGd1ZXN0IG1lbW9yeSBiZWhhdmlvcnMgdG8gd29yayBwcm9wZXJseS4NCg0KRXZlbiBp
ZiB0aGUgSU9UTEIgcHJvYmxlbSBjYW4gYmUgYXZvaWRlZCwgdGhlIEkvTyBwYWdlIGZhdWx0IHBy
b2JsZW0gKG5vcm1hbA0KcGFnZXMgYXJlIGxvYWRlZCBieSB0aGUgSUFBIGRldmljZSBhbmQgc29s
dmluZyBub3JtYWwgcGFnZSBmYXVsdHMgdGhyb3VnaCBJT01NVSwNCnRoZSBwZXJmb3JtYW5jZSBp
cyBub3QgZ29vZCkNCg0KSXQgY2FuIGxldCB0aGUgZGVjb21wcmVzc2VkIGRhdGEgb2YgdGhlIElB
QSBkZXZpY2UgYmUgb3V0cHV0IHRvIGEgcHJlLXBvcHVsYXRlZA0KbWVtb3J5IGluc3RlYWQgb2Yg
ZGlyZWN0bHkgb3V0cHV0dGluZyB0byB0aGUgZ3Vlc3QgYWRkcmVzcywgYnV0IHRoZW4gZWFjaCBt
dWx0aWZkDQp0aHJlYWQgbmVlZHMgdHdvIG1lbW9yeSBjb3BpZXMsIG9uZSBjb3B5IGZyb20gdGhl
IG5ldHdvcmsgdG8gdGhlIElBQSBpbnB1dCANCm1lbW9yeShwcmUtcG9wdWxhdGVkKSwgYW5kIGFu
b3RoZXIgY29weSBmcm9tIHRoZSBJQUEgb3V0cHV0IG1lbW9yeShwcmUtcG9wdWxhdGVkKQ0KdG8g
dGhlIGd1ZXN0IGFkZHJlc3MsIHdoaWNoIG1heSBiZWNvbWUgYSBwZXJmb3JtYW5jZSBib3R0bGVu
ZWNrIGF0IHRoZSBkZXN0aW5hdGlvbg0KZHVyaW5nIHRoZSBsaXZlIG1pZ3JhdGlvbiBwcm9jZXNz
Lg0KDQpTbyBJIHRoaW5rIGl0IGlzIHN0aWxsIG5lY2Vzc2FyeSB0byB1c2UgdGhlIC1tZW0tcHJl
YWxsb2Mgb3B0aW9uDQoNCj4gPiAgICAgLS0gbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2UN
Cj4gPiAgICAgICB8DQo+ID4gICAgICAgLS0gaW50ZWxfaW52YWxpZGF0ZV9yYWdlDQo+ID4gICAg
ICAgICB8DQo+ID4gICAgICAgICAtLSBxaV9mbHVzaF9waW90bGINCj4gPiAgICAgICAgIC0tIHFp
X2ZsdXNoX2Rldl9pb3RsYl9wYXNpZA0KPiANCj4gLS0NCj4gUGV0ZXIgWHUNCg0K

