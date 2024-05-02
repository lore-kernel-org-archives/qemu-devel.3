Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4E5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNK-0003gO-9H; Thu, 02 May 2024 11:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNH-0003dt-5G
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:31 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YND-0005zE-4b
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663767; x=1746199767;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=w3ksL9XnsGogkygAQJlBpy6EUuIt8oHQXnFG1VyOXcw=;
 b=pfO/31z8JWPAAzxInLbZmxBXQtvk23g/Y3COdm3ijVowndUoxeXI2R+F
 7EEyWjMdIUuo9I3Zk7qheNTlJPBv4BoxQhOCv4mRChy7jLk6v3LRD6RM0
 QSzN47u5C87Dwz1ID0sTPxkbFv9JDcwnJcVl1KyJRdI+4duc+sfZ/uFfV
 LI/PBWYvGOy6dhF7ZoGNggS9h3rwvW/cgsqFSw0/HrumDuP+OoOajDbnl
 B+ksq4NtVUWGw4ZzfMUUhyjmggbFc+a4S5OIUprUV0hL00RbBihCQv8zt
 fh7q2BWu+yCCjL14ukQHox3iBEo4cle5/mO+H6j3/TRa8MIULczAz0dVY A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730621"
X-MGA-submission: =?us-ascii?q?MDFZJjiiO5iR60E78Yz1bCCO/nXmMpmgiLCEVZ?=
 =?us-ascii?q?F3lU8ff+szYowitUEo2zkIrjn1d0eR4i8IEYPV1GUbKqgK7yAWTAh0fQ?=
 =?us-ascii?q?ojzvtp2eetHEuvCCGgpH/ciATvjGrW3mpZ7wvpucgQluLo3U5haJ3jjo?=
 =?us-ascii?q?TaddFezN2B+05cilPp/FL3GA=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GORuSqUg3eFA4wRkV9Z4zXR5Ih9aMPvmu7ErqxnEKj015N//v7rcDFQI4MrlrAB6FlBE9zBJcVBSQvmRCOXFDQuu4iyH/+5rwfd7zHoKNxakC481P+YFOx1HvDmcmQk14TZ5p+agYa8GwQQZF3n8Eg9l9RND8fQ+ezacbIRpePeN4RdmIor91/EPvMaknxM8SjrrKOVqjrx5j3SWmpiDMRvx5Cs0zO4a+Zl7marTvfpfJJMV4VZJbvESs2mffJu91S2wiCfbAh3vI7EUb3aIrBfKJR5LndkaP7Z7n3463zg+h0OCwtikwUeIsQTxSUK7RR3VnZS68WSA5FW42fOhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3ksL9XnsGogkygAQJlBpy6EUuIt8oHQXnFG1VyOXcw=;
 b=XTUiN9riMOoRj/u2sdxkMX3UPMrw57YMyq929pvRdc6fs4zgDwmOt5bJpLK+ShfpvOCsOQHAIGFudrH8bqqspgbpFVfeGAu7MKH3OkLGZcEavVcxOFl5LoON7nmQnbPf7w1jyBUNFHzZYvenKbBN1x9VcImaVUpK6B2JoaaKnScbWOxOOLTDuQZpImwv1GAaYK41hRB3K7yT09vVCrXbWg56onsAU5EGuR6Gv7hX0pH5qqCRMKrVobLAVWMOAWNsv8eh+/Uff1eHphXctQgBTt2x2jwJ4YHuYHQmpab93yO7loWZIHgv2kI7dUuvgTeSyCYlnRBE+ge+KM1m5skDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 21/24] memory: add an API for ATS support
Thread-Topic: [PATCH ats_vtd v1 21/24] memory: add an API for ATS support
Thread-Index: AQHanKWBI/xSV/efz0Sgz6TcWG7H3A==
Date: Thu, 2 May 2024 15:29:21 +0000
Message-ID: <20240502152810.187492-22-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: 7cf05623-a7ed-4a51-8e7a-08dc6abca427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TUZHbnQvUFhzY1JkU1U1dW9vaElvZitXUjUrTmc5OGh2UjdIblZVQlRZYjNX?=
 =?utf-8?B?VWNCT0dldjJhRXU2dXlWWW83Nk9kUmwzS3VQNnYrMjExZzFPTFZ6RDFVSFVR?=
 =?utf-8?B?SXJVbml5Y2I5Tm14OTF5eEFvQ1hYUHZpVlBOTHFuMVhrbUJTamtyRjIxWjBl?=
 =?utf-8?B?MWtSQ25KOURrRlJvaW1qa0JwNWx5cUJkbDFkZEVGWFZ3SFg2dzBqMVFUTDU4?=
 =?utf-8?B?WURDTHNNdDZjbWtLcjMxbmdhb2xKOEpobUdnZE9zYUcxTHl5NGpGZW9zbndU?=
 =?utf-8?B?YTFCc2hrbmdYVFRpcXpDQVJ2VGJJVWpaMUZkNnp2bkVDb2pQVnVETUJOOUhV?=
 =?utf-8?B?cXlyWTByTzVFa2cvQ1h2V3pMWXFMOEh1U1E1VGlTcnZ6d2VRMHppVzZ1bmw1?=
 =?utf-8?B?RkpDZjNabWpGd3ZrbkJEOUNWbFRaS2gvbnFKSjV5YXdBaU5zUEVaVU9FM3F1?=
 =?utf-8?B?NHBmUlcvSHVCSm1TdVVWSkl4MlpDYjFtSjl2czNhSndhVzJzMkVHSGJyem1u?=
 =?utf-8?B?R0FGaGNuNGZCRm1iVVNoL285Nmg1QVhRcGNtUDBsZjFINWw1OFB4WksybnNi?=
 =?utf-8?B?TkMrTFRXSnpsR0cyTFNSZWJ3UCtXRnNJa2NoUFN2ZU9ISnZYU3hIUGRrcjd1?=
 =?utf-8?B?TmpKd0wrTXR0WEIxWlRtZVZ1ZGJQT1YzT1VpWk5xamVpbGFRL0lMK21xbGND?=
 =?utf-8?B?T2xtaHFDYU5WRmIvaW9mTVhEYmdZckRKMUlyZWRiMkxXRk1uRFVXYml5b0I3?=
 =?utf-8?B?bGhXb01lNXlKWkx1aXhKYVdRZ3FkSDlKUldvaDF5dEY4U0NaZXNoVUFtTGIv?=
 =?utf-8?B?UFhMejUxMm9GR1Jqc09BL01Xc3B1QkttVFZyeU45SU01ZGlwVWtTaU40N0Ez?=
 =?utf-8?B?QnFUb2Z6OHBmU2djWEppb3dFci9KQVJNMG9rTWRhbUFtZlM4MmhuVGs3MGR4?=
 =?utf-8?B?SzJQWUdqV1dSdEFWVGVIbkhmMGNkVlg4Mjc3VjhPeUdLNXBiSGM5L1hyRldi?=
 =?utf-8?B?YmREMXZlelIyTU1Wc0hDTWtqVC9KUmJLR2xwcHdnOGNMTWxBaHQ4ak9hMXAw?=
 =?utf-8?B?QksxUzJ1UkFyRmlNYjFsV3BOR1ZUZGljOHdGNEIrV3VQd0JGTGtuRk10Umtp?=
 =?utf-8?B?QjVrOFlGdzlLd2U3TmU5MTVGWFk3T09GZExaWWxQVjNxQ040eWFzZ2YwcWRE?=
 =?utf-8?B?YU9MN0VuNFlSY3ppbFlBNE5laW9EOHQ3TTJDakpNMmhZQW5JZHNzbGZDMFlW?=
 =?utf-8?B?TUNCK3lkakRtZVF5S2hJcDFDZEJTcXp4WEJ3QTB1cGVsZVF6UkZaUld1dm8y?=
 =?utf-8?B?T3Q4WDJMQWxic2FQT0FrMmZOVkR5YzFZT3NRYTFCeHNoVEFGRXVGWFlhWXlT?=
 =?utf-8?B?bjJNZjVCTGxuNGNPaktQYWxBWXZiaWVFWEM4a3NKL0hMekdIYXdLUEtHcmNF?=
 =?utf-8?B?VkE5SlpnOGZoNWRwTnJwUWpEL3ZTQkdOY1hXQUg2a0xWMGV4cGlpVVA1L0h4?=
 =?utf-8?B?NGhRK3dwM1BlSmNYakgvZGZTNmpqRjVwZTkwQXR5eG4vVVY1MHQ4anYwTm9M?=
 =?utf-8?B?S2dCU3JwUVRtYmh4YzR6b1Y3U2gvTllMSE9vODVwbEJRSjlNc01OYzNuT0l0?=
 =?utf-8?B?dEhiVFFQL3FtbjcwdDFjQmtIK0pSWHJVNFN6QkdMZm1iNFgyZnAwRStoNlR2?=
 =?utf-8?B?ZjRKU0gwVzlZWktyUEZMaW15cWQrYzBOZklNd2MvdlVONkIrMnVCYVA1UlFT?=
 =?utf-8?B?MDJLYXAvUmJqS2lRS3hLYU1NdUNWUUtGdWQyK2JmeVNkczdMek5Lc0Q5Vkd0?=
 =?utf-8?B?WGJmcGsvT3RGeEVVTEZXdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkZwRVRFRUMvQ05MQjFrU3pqNERVRUZ5ZURVay9leDFRcUMxYVJrRkFwK3JX?=
 =?utf-8?B?ejV5c3ZpM0VyTHQ4NllsZUkzNmxlazVtaDVndEtjdUp5K3ByUzk2VnlmaXNL?=
 =?utf-8?B?azdxYmJtTEl2cFJmWE8yUUpOTEt5bUJEa3FOZHcxcDhLWE5ESjNydE15U2g3?=
 =?utf-8?B?SXJmSGNMV3BSdTlEMUNHdWVrbXdCd1BvYzlLc1VIZVB1KzBHczd0d0UyMHk3?=
 =?utf-8?B?elo4NUdlbEVleWhoVG9QNHhKRUdORW9DQ01nWU1xeHBiRTAwelRKUlFRM2ph?=
 =?utf-8?B?T1k4TjIrWk1qNTc4WWVRVUd2ODRrZnM0NlhXcEJiL0RtWEg2ak5MK2xEeHFw?=
 =?utf-8?B?aysyQ21HblFCejJBUDd5bGFmeHRSQ3VJaE9QZDAyOVc5UTJ0VSs2R0FMYkpj?=
 =?utf-8?B?eUtWTUlNSU0yZ3RIaUJXeWtleHhPSVlYUEVIaTZrOHVzcHNlbUNwZi85QkR5?=
 =?utf-8?B?Q3dXc3gvT3Z0V2VHWTNibWhwYTEySEM3U2U1SmZLOVlpQWhkMU4vcDhhOTc2?=
 =?utf-8?B?dFdiM2puVyt2OFJrMkRCWnVXQTdCcFc4ODN1NkNZSnRFdUZ0R0dydi9XdFpi?=
 =?utf-8?B?N2ZWZE5iUS82STdpTlN2UWp3SkJBWU9Va1c5ZGN6b0RoQkhPWFRvb25qSDZY?=
 =?utf-8?B?NG1kWmdmYng4YWQwbzJtaW8zbHR4cVJCdTR1RTh6Z0JDS05OZVRLVjBvUmhq?=
 =?utf-8?B?TkM0eDdHdUVmT2doMWZFbE5ieVdoUGxtc2hpT3MzQVVvSG9Ra1lqaTQ5Vy9Y?=
 =?utf-8?B?Y1Z0MERtRnlUcERTN1pJYkswdm9uN0xiN2hCd1UwKzNEY1k2QXQ0eGtrVDFC?=
 =?utf-8?B?UE5XR3hScVNleC93TGtjY01ZWFRoSUxUSUkvcXZnaEN2aFB6ZGV1V2FsTFRl?=
 =?utf-8?B?Rmh2cmphQndMTHd4bG9GRkxnZmUwNTdObTdiSi83UnlLQmRWbW85MVBIc2M4?=
 =?utf-8?B?YmJGQU1mQXJXMzVPeWROVklpazBxa05HTmltRHdGK3owWUlRL043elhpQUZ6?=
 =?utf-8?B?UVZQYkFveUpuTzUxUlY0OGhLYmZlODlvR1Ivd3Vob3o1OW85R0RJYUtPTmE5?=
 =?utf-8?B?R3dLVjFoQkN2MFFYSHJWNUNYSklvK0lvSTBFYUtzaDVYSnF0dzFPd1RFY1pp?=
 =?utf-8?B?VEdXS1RMelgyR2NrYzlmRm9QOGxqNDAybkIvOFpXeC9xeThnZlBHRWJOYlBS?=
 =?utf-8?B?b1lycllHdElJTGJaT3pvZzNBTjhzdEZYZzFvMDJLWnhIWjlZL0hidFVHWVo0?=
 =?utf-8?B?Qks0UUxubjFsMlZWN0pLZG40elRTZTZad1FhdHlPcWwweC9Lanp2TGVHakQz?=
 =?utf-8?B?VlFLSW5Ld3F0MExNRnVTd0U0Vm0wV3pDZWhHQWhWejY2VzZ5ZVA5dk1Vajdj?=
 =?utf-8?B?ZS90cUY3aEVqN2VSekZwMUZrS2sxTC9yUjE1M0ZyR3JETThGRmVDVmN5VVhM?=
 =?utf-8?B?R1IxR20vbnRrNHV0N24rM09BSERvK3lTSE40Z1gxaGg3ajR3SWFWY1NJMGR4?=
 =?utf-8?B?QS9xMlBPTEpxeFhURWQ0VW1IcUxYejdpb1Jvb2dIS3BuUkpBSkVVNU53Wm1S?=
 =?utf-8?B?RTkvQTZnTzRTSEVMUnVFSWZ3a3VkS1BXZ3M2UG1tZ3Z3a1ZsRjNmWVI0Mml4?=
 =?utf-8?B?UGxhbVZFR3BKUG5ITlJRWWVLNzF6cGZCa2R3cmdrM1NGcWNDOVRQNUx2MnZW?=
 =?utf-8?B?c2UyU3VteHh1ZHZ0Z2xDQVB2dkJBNDdGVFJPcHJya00xN29MUkFNNWwyL1Na?=
 =?utf-8?B?NFdpNUhnRktOT3BDeDNXcys5NTJtU21wY1J6MkE3U1M2WWJTemx5bUN4MVRq?=
 =?utf-8?B?SmtPMEszeWpVM2FUWnRlT0hubzJBUFJxZUdiZGtpeFBHWmcvSWNJVjNWRTRi?=
 =?utf-8?B?ZitZYVZnSnNXTmtjNUMwOElYRFRaSDFWVTNJQkdERzk5ci9JQkJYanhHMkFW?=
 =?utf-8?B?ai9MNjZSd1RvS3g1eTN0T0tPOVJnbEdDcHY4b3QxSGFJcmRxU2o0U2dscWhT?=
 =?utf-8?B?NEltNHdJNmZYOFJnWDdpMXd0VFpRK3FWTFdxM2FHVGJ1MzNBRERscnFiNC9p?=
 =?utf-8?B?cHpRTzlHd2JaMFhPS0Ixek5XT2RFMFRjTGJ0cCtYLzFBenMzQ1d1L1BSL0NX?=
 =?utf-8?B?akFTd3JJcFNWdk5kUVE0dGFoQTVGOGMxZnNkVGlRN2N5WklrMkc4WVZhOFlv?=
 =?utf-8?Q?GT+ClB6sQ6fbcPZqUBvNW8g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64E5536BC0CE454BA701C57731D7453E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf05623-a7ed-4a51-8e7a-08dc6abca427
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:21.6236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJVry1AH09bjqv82zS70L0Ro89NBw1/fFQer752HpVCyABq2CVKJh2VKfeH9Kre6zZsMfFS63Z/y9klXvA1shWHNxRkMhrN5JVsT4kYpoB3FcSfpfDxbpKxokXNKkPlV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SU9NTVUgaGF2ZSB0byBpbXBsZW1lbnQgaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24gdG8g
c3VwcG9ydCBBVFMuDQoNCkRldmljZXMgY2FuIHVzZSBJT01NVV9UTEJfRU5UUllfVFJBTlNMQVRJ
T05fRVJST1IgdG8gY2hlY2sgdGhlIHRsYg0KZW50cmllcyByZXR1cm5lZCBieSBhIHRyYW5zbGF0
aW9uIHJlcXVlc3QuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNs
ZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9y
eS5oIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBzeXN0ZW0vbWVtb3J5LmMgICAg
ICAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9l
eGVjL21lbW9yeS5oDQppbmRleCBmNGIzMzQxNWQ3Li41YjE1N2I5NzExIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9leGVjL21lbW9yeS5oDQorKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0x
NDgsNiArMTQ4LDEwIEBAIHN0cnVjdCBJT01NVVRMQkVudHJ5IHsNCiAgICAgdWludDMyX3QgICAg
ICAgICAgICAgICAgcGFzaWQ7DQogfTsNCiANCisvKiBDaGVjayBpZiBhbiBJT01NVSBUTEIgZW50
cnkgaW5kaWNhdGVzIGEgdHJhbnNsYXRpb24gZXJyb3IgKi8NCisjZGVmaW5lIElPTU1VX1RMQl9F
TlRSWV9UUkFOU0xBVElPTl9FUlJPUihlbnRyeSkgKCgoKGVudHJ5KS0+cGVybSkgJiBJT01NVV9S
VykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA9PSBJT01NVV9OT05FKQ0KKw0KIC8qDQogICogQml0bWFwIGZvciBkaWZmZXJlbnQgSU9NTVVO
b3RpZmllciBjYXBhYmlsaXRpZXMuIEVhY2ggbm90aWZpZXIgY2FuDQogICogcmVnaXN0ZXIgd2l0
aCBvbmUgb3IgbXVsdGlwbGUgSU9NTVUgTm90aWZpZXIgY2FwYWJpbGl0eSBiaXQocykuDQpAQCAt
NTY3LDYgKzU3MSwyMCBAQCBzdHJ1Y3QgSU9NTVVNZW1vcnlSZWdpb25DbGFzcyB7DQogICAgICBp
bnQgKCppb21tdV9zZXRfaW92YV9yYW5nZXMpKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0xpc3QgKmlvdmFfcmFuZ2VzLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KKw0KKyAgICAv
KioNCisgICAgICogQGlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uOg0KKyAgICAgKiBUaGlz
IG1ldGhvZCBtdXN0IGJlIGltcGxlbWVudGVkIGlmIHRoZSBJT01NVSBoYXMgQVRTIGVuYWJsZWQN
CisgICAgICoNCisgICAgICogQHNlZSBwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFzaWQN
CisgICAgICovDQorICAgIHNzaXplX3QgKCppb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbiko
SU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHNpemVfdCBs
ZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9v
bCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCk7DQogfTsNCiAN
CiB0eXBlZGVmIHN0cnVjdCBSYW1EaXNjYXJkTGlzdGVuZXIgUmFtRGlzY2FyZExpc3RlbmVyOw0K
QEAgLTE4NzAsNiArMTg4OCwxNCBAQCB2b2lkIG1lbW9yeV9yZWdpb25faW9tbXVfcmVwbGF5KElP
TU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwgSU9NTVVOb3RpZmllciAqbik7DQogdm9pZCBtZW1v
cnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoTWVtb3J5UmVnaW9uICptciwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVy
ICpuKTsNCiANCitzc2l6ZV90IG1lbW9yeV9yZWdpb25faW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNs
YXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
IGFkZHIsIHNpemVfdCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5n
dGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3QgKmVycl9jb3VudCk7DQorDQogLyoqDQogICogbWVtb3J5X3JlZ2lvbl9pb21tdV9nZXRf
YXR0cjogcmV0dXJuIGFuIElPTU1VIGF0dHIgaWYgZ2V0X2F0dHIoKSBpcw0KICAqIGRlZmluZWQg
b24gdGhlIElPTU1VLg0KZGlmZiAtLWdpdCBhL3N5c3RlbS9tZW1vcnkuYyBiL3N5c3RlbS9tZW1v
cnkuYw0KaW5kZXggYTIyOWE3OTk4OC4uOWM5NDE4YzVlZSAxMDA2NDQNCi0tLSBhL3N5c3RlbS9t
ZW1vcnkuYw0KKysrIGIvc3lzdGVtL21lbW9yeS5jDQpAQCAtMjAwMCw2ICsyMDAwLDI2IEBAIHZv
aWQgbWVtb3J5X3JlZ2lvbl91bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1lbW9yeVJlZ2lvbiAq
bXIsDQogICAgIG1lbW9yeV9yZWdpb25fdXBkYXRlX2lvbW11X25vdGlmeV9mbGFncyhpb21tdV9t
ciwgTlVMTCk7DQogfQ0KIA0KK3NzaXplX3QgbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVxdWVz
dF90cmFuc2xhdGlvbihJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
ZXhlY19yZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGh3YWRkciBhZGRyLCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5
ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZXJyX2NvdW50KQ0KK3sNCisgICAg
SU9NTVVNZW1vcnlSZWdpb25DbGFzcyAqaW1yYyA9IG1lbW9yeV9yZWdpb25fZ2V0X2lvbW11X2Ns
YXNzX25vY2hlY2soaW9tbXVfbXIpOw0KKw0KKyAgICBpZiAoIWltcmMtPmlvbW11X2F0c19yZXF1
ZXN0X3RyYW5zbGF0aW9uKSB7DQorICAgICAgICByZXR1cm4gLUVOT0RFVjsNCisgICAgfQ0KKw0K
KyAgICByZXR1cm4gaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24oaW9tbXVfbXIs
IHByaXZfcmVxLCBleGVjX3JlcSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFkZHIsIGxlbmd0aCwgbm9fd3JpdGUsIHJlc3VsdCwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9sZW5ndGgsIGVycl9j
b3VudCk7DQorfQ0KKw0KIHZvaWQgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXVfb25lKElPTU1V
Tm90aWZpZXIgKm5vdGlmaWVyLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IElPTU1VVExCRXZlbnQgKmV2ZW50KQ0KIHsNCi0tIA0KMi40NC4wDQo=

