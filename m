Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32047C67861
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 01:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtH4P-0002Wd-3Q; Sat, 06 Apr 2024 21:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rtH4L-0002WN-Hd
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 21:11:38 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rtH4I-0000MG-Uy
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 21:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712452295; x=1743988295;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A7Wt6MYVzoz0h9ZVQSEesbZDzxuHSYhcQynVD6P92Ik=;
 b=AkpIPuTqlBEXc8YYPhAnlXBqBgHRLCAnSGUNujX0MdqL4wr/M68nOwvj
 MH4qggBdJbEOYGuN6KPTTuqWj8tkHe7q8/7q73W+JVQfClgxCiQXy4N6P
 K56g243DiNsx4eLo/CruFwDZgtFzwOWE/4fpEisEhmKQhQmEiNlQ20enQ
 d+Rs2eJ8cka5pM+HzEe8y68nJz9QitJ22oYPxDezkBNGewXGfm6UjaJ+J
 Y/ZEHT9Cle10bnnoPGteOF2FnbzbMU9BwzSL8yxVRCm6SFMSBkaORGkGh
 t9UrteSKZKmrgubSp8YO7wfhfM6/6vo6MNC9b4me9wlEhIeEIrCsmv84N Q==;
X-CSE-ConnectionGUID: 900Wzu7ITD+ocJWDYIWMtA==
X-CSE-MsgGUID: VqkqbUGvSP2iJdg44yYLXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="11578864"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; d="scan'208";a="11578864"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2024 18:11:29 -0700
X-CSE-ConnectionGUID: dwDt3AsdTH6/MdCzJEdaPw==
X-CSE-MsgGUID: PBtu6isQR3WSCdMoFi2yMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; d="scan'208";a="19637333"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Apr 2024 18:11:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 6 Apr 2024 18:11:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 6 Apr 2024 18:11:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 6 Apr 2024 18:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcvMpuTWW+uBxqvjYg579B2rfplThu1IERNDq6c1iTbpC/Hh8jDzQk0SSkZ61YpgH5QgKxyUwVVLjwqWdhjgDn+YkKHvmFv6Sk8sHNLbr75dkFIi+GM03UM/9AxV41u0URJbSJ2VUhr0bLRH7R6RzrvTbOGhal4tykpEyMzALKII0KUz7aeCUgOf4O/AclHMRr3qQpNxh/fyUHf8V1jrDXLdIM0PK2LBokZ+E5/VE5novWhQvG89WjK8CvDFciKBrzaACGVo8gCwHZAYdEvY8a3LBmkMBUv7lNR3pZ3boExgIGQpG/66XZ2QaxkiTj/K9yrWaNu6XFwgsYtGhq1MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7Wt6MYVzoz0h9ZVQSEesbZDzxuHSYhcQynVD6P92Ik=;
 b=K2bSAbM2fZCmNzwXAHGeUlDduHembZO96lAELlQqqkeR5RJg73i9C052fuZkCbSgghpq1rPckTx0Fwjlc9FPGHKEo8L9q5m6b+oiLgHv9d2dUWhuZuAUaRPkTItr7sdbhvOue2lyZR3WbKSSH/fE+tWzo+Wa+up6QiquKTH7xSw4tDgYNX+ns7Agn/HMfIPJqXI0XE9pvuhFVvt0EYsBAc3SALmYfX/NEge4PmhY0Zbm8hKQ4ShpxHLANQwyosSrdwJLotxa3wsBweKSGPI0hwBWgDCepFt1omwLHFVT+gS95uMoG0sDiuFJ5LcNdufv42OpslXMo8pOd2/Qf1pYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 MW4PR11MB7163.namprd11.prod.outlook.com (2603:10b6:303:212::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Sun, 7 Apr 2024 01:11:26 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 01:11:26 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "Wang, Lei4" <lei4.wang@intel.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Topic: [PATCH v2] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Index: AQHahwsYyrUJC7Z4qUW64CcM1lLIZbFaOTyAgAHIapA=
Date: Sun, 7 Apr 2024 01:11:26 +0000
Message-ID: <DS0PR11MB63733079A3F5AA55F3E7348BDC012@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240405034056.23933-1-wei.w.wang@intel.com>
 <ZhByy4YvYl9xLmRP@x1n>
In-Reply-To: <ZhByy4YvYl9xLmRP@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|MW4PR11MB7163:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NwumH7+Btt6GLFnLXo6+xJ8L52xINL1z0+4WpF1CX65bv4lfFooubLdhVkM/WDGRdWlpCCBYdbwW5RLMEqDn0/RrRCqA8Em26633lkFuG5Qui2wM4TIlrrtllWDKbGNhEA258ZSTNCmytVeV9U8ATqHgZ1nOEECDDS+MtAWQe2bHx2/zFz8JzvpMH3rIXd7liFYSe/Poy9IQgmK1+xNsDLlBRkNjmObEITFEcmdCkf8LXJAqz/zvOyIxsOp3+Q2GeOPjFlLKXbH9HScdwXvBZt6/GVS2VVcWr0zxiWebKBfEN0gv7E81EGblsDnk+zhbHTGBAyd83WAh2+9vwdd2xQTF9H/NdeKLRbVqX7wB7yVGkh2LISqFEmxi2dJ4X+ufbIAXmfPJJ0/bk2vFXpwDc8nJ1FGSpR47ppxKOn1fHtRSAMwcfbP01bEaIot1pSQP2tpoM1PFsYvWWdyoZS4M7R+1vpri0opJjoPizKI1K+cn4l5fFwxVDv8UyXTSzQyz27zNbV3yXNS9sfmnM7LEBuzcgmrRk+5+4PNsAeRoEau046BalwvehmIAxek0pG2s/XlxAtSncpq150WCG7gqnOwdtuMPjfTwlGioKdi5vA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzczaGExZFY3ZnZBNFJaYmVka0RFYS9aamZJaFU3clhpbGRrMmI3K0ZRQTlQ?=
 =?utf-8?B?TmRWSndlbkVOOFg0R0VmZVpGWGdVUUNwdGVLdFNWV2l4c0VhSWMyRXF0akRE?=
 =?utf-8?B?Mk5CUzFxZEJHNDFZaHNJb0NsN3Ird2VQcDcvOFhxUEE1aVgyL0c4TEFpL2hi?=
 =?utf-8?B?dzNHblFoemFka3dERm9LejV3ak9FR3RyUGVvOTZsUmNYZXdORW5lNENTZlgv?=
 =?utf-8?B?OUtSRkE4V2hUTG9NZkh6WWJkNkFXSWgrUGxhUGVIN1Y0dFZ0L2RkVU9UTkVr?=
 =?utf-8?B?ZEtVcW8vLzJWWXRpTDlENm5HRk9FQ2FYN0dna2E2bHV5OTQ0WWNzMTVsS21k?=
 =?utf-8?B?UHJaR0xuZFN2ek5QN1BDVkwxaVE5d0drOEhiNDZnMWx0Nzg4UlNlL0hVNVZj?=
 =?utf-8?B?Vk9OYVdJQjBxelVJaFdtUEwwZ1BVTGRxTkRtWHlTN3N6bVVIeThxaWxDMjhZ?=
 =?utf-8?B?TE8zaWExTDg1WFh6OE9YWEJTWitlWExzWWNhT3BCMDJkSWJFNVBHWUczeTBy?=
 =?utf-8?B?YmhZb1ErQ0JLcXpmY2lhMG1tMGMwSGI3dm9VZzQ3d0J3OHJ1SndDdmEvdGk2?=
 =?utf-8?B?MnZPbUpJNjlUUzI3T0ZVRW9iS3FTQ09VU3gvZ3ZocW9kYTVRSzhDQ1p0ZStU?=
 =?utf-8?B?b2xjK2orT2Vhb0FQN2dPR3NYN1ZpN2g5RVRzSmtURkEzenQ3LzRsNG95aHN4?=
 =?utf-8?B?RjByRU5yK21nczdTajVUMTBuMGxEdFlUT3FUYVlndE9ZejVYbXVSMHZ2UUZo?=
 =?utf-8?B?MDZrS2crWm5ITjBxUUMrV294SEZORittdWd0cjBXUDVGSzAyQnlLemNvL1lz?=
 =?utf-8?B?VmI1c0lCOTlWUDQvWmVHUndzLzRJMWovc09QYld2QTlhZDFTK0JZM0FBMmJJ?=
 =?utf-8?B?M0Qwbk1QZnBXOStaY0NqU2l2SUk4b3hsQ1UvcysyYTNsWjgwR1ZCejJwOHJI?=
 =?utf-8?B?Z3Q1cWw2TFM3Zkp5N1VXc3RzWk5waUxndTdQelhOUG9HWXJJZ0ZNVldGNTA0?=
 =?utf-8?B?VEVMYWJ1MFFIOVI0Wno2RWU2MFdWcGNqM2RzSUVaditXaDRZdktPQlVIVVlq?=
 =?utf-8?B?ZVhQd05JK0ZKNElhQy9FMUhhQXgycnUrRmh6cy96WVJrNjBhaE1xSUpvN052?=
 =?utf-8?B?d2phSWQ4Z3lyMFpXbkdVano0UkhwMWhuSWt5bUhxYSt6UEpXbjNaQW5sNVY3?=
 =?utf-8?B?WGRJdS9WM3RPanl1S2pzeXFHTHhwTkRuNnA4OThoZzlQaG5QRjNMeGpCOVpB?=
 =?utf-8?B?YSt5QXkxdis2Sk9BNERmelkrYUhuTHFUbjVqaXNRUFY5aTJzT1cxTy9ZK0Vl?=
 =?utf-8?B?MWxueGo0U0pKZDluNFdJRWhOOG1Dd2ZXVmFqMFNNM0gwN3pFZHpSdm9lT3ZB?=
 =?utf-8?B?dnM5RjBuWndHclFrUjVjaWF6U09GbERxVVdFUUlCSmhncmZmOUhwOWVRZlBv?=
 =?utf-8?B?UnVIbEhxcitMcXlqbWNaT2VBelNURWoySFM4SE1YYVBvQlgyai9NSURLajF0?=
 =?utf-8?B?alNIaUZESmNDQmJaUktLTE9BaFdQOWljVFJxb3hwUWRCUGRNbUEwZk01OWF4?=
 =?utf-8?B?d2FrWW01cjVwdGhXemdDc2V2aElHb05CempPQTVPYnh4T1lINDdaWDJFRlo1?=
 =?utf-8?B?UU80RHF1M2Rmb2JCdENXYVJnNWlucUh3N2xoQ2NDSUtXdURRNG5DNXZFVVBW?=
 =?utf-8?B?SkZVMVlnTTJsVUpWeERkYUFsUkVheDROUGZleGpYZ1NON0tIMjM4WXp1NnBt?=
 =?utf-8?B?Y1pxV3Bsb3RUTEw1M3RUQWZxUHVnYlFiQ054Mm5pVTlmSXBkWUU1SmRvWHc4?=
 =?utf-8?B?RVVUUnRVOTByZXFBYmdmSzl2UVpCMTJ1TDlobzJDUVgwcDRCZy82VFRueldD?=
 =?utf-8?B?Ky9KS0tNeUVwRkVVeWZRMDBSUnorZnd4SXFza0ZzM0xyZ1ZZMU5ib2xBUTFZ?=
 =?utf-8?B?OGVOeDU3WTFhYUtOUTlsclpFS0Qwd3kvRmpIeldBcGx3U0QwSlVLRVBnbG1j?=
 =?utf-8?B?aG5JRm1zbStDQ3gvbGNwcGxsRms4L1JuZGh1TkxMUFZVV2tBNnJUTHFSK3ZM?=
 =?utf-8?B?a2lVVENJVjc1cjRjRy9ENWdhWGlTbGZiR3FFakgwelQzWVNrTXV6aUlEUTdn?=
 =?utf-8?Q?qUYlrVBOyLINKddGnyzMvaTUs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156807e4-cf59-4ce4-e22e-08dc569fa61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 01:11:26.6217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+rm0y2ct1zNlliKjvmNCYWzFDcFeor+/OEJQt84WWmM3GwaB49ChtRygWcBcGNIQsOPdEXobqDRSb/e7SJTMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7163
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

T24gU2F0dXJkYXksIEFwcmlsIDYsIDIwMjQgNTo1MyBBTSwgUGV0ZXIgWHUgd3JvdGU6DQo+IE9u
IEZyaSwgQXByIDA1LCAyMDI0IGF0IDExOjQwOjU2QU0gKzA4MDAsIFdlaSBXYW5nIHdyb3RlOg0K
PiA+IEJlZm9yZSBsb2FkaW5nIHRoZSBndWVzdCBzdGF0ZXMsIGVuc3VyZSB0aGF0IHRoZSBwcmVl
bXB0IGNoYW5uZWwgaGFzDQo+ID4gYmVlbiByZWFkeSB0byB1c2UsIGFzIHNvbWUgb2YgdGhlIHN0
YXRlcyAoZS5nLiB2aWEgdmlydGlvX2xvYWQpIG1pZ2h0DQo+ID4gdHJpZ2dlciBwYWdlIGZhdWx0
cyB0aGF0IHdpbGwgYmUgaGFuZGxlZCB0aHJvdWdoIHRoZSBwcmVlbXB0IGNoYW5uZWwuDQo+ID4g
U28geWllbGQgdG8gdGhlIG1haW4gdGhyZWFkIGluIHRoZSBjYXNlIHRoYXQgdGhlIGNoYW5uZWwg
Y3JlYXRlIGV2ZW50DQo+ID4gaGFzbid0IGJlZW4gZGlzcGF0Y2hlZC4NCj4gPg0KPiA+IE9yaWdp
bmFsbHktYnk6IExlaSBXYW5nIDxsZWk0LndhbmdAaW50ZWwuY29tPg0KPiA+IExpbms6DQo+ID4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzlhYTVkMWJlLTc4MDEtNDBkZC04M2ZkLWY3ZTA0
MWNlZDI0OUBpbnRlbA0KPiA+IC5jb20vVC8NCj4gPiBTdWdnZXN0ZWQtYnk6IFBldGVyIFh1IDxw
ZXRlcnhAcmVkaGF0LmNvbT4NCj4gDQo+IFRoZSBjdXJyZW50IHZlcnNpb24gZG9lc24ndCBoYXZl
IGFueSBvZiBteSBjcmVkaXRzLiA6KSBUaGFua3MsIGJ1dCBJJ2xsIGp1c3QgZHJvcA0KPiBpdCB0
byByZWZsZWN0IHJlYWxpdHksIHNvIHdlIGtlZXAgdGhlIGNyZWRpdCB0byB0aGUgcmlnaHQgb25l
cy4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGVpIFdhbmcgPGxlaTQud2FuZ0BpbnRlbC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIFdhbmcgPHdlaS53LndhbmdAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+ICBtaWdyYXRpb24vc2F2ZXZtLmMgfCAxNyArKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9zYXZldm0uYyBiL21pZ3JhdGlvbi9zYXZldm0uYyBpbmRleA0KPiA+IDM4OGQ3
YWY3Y2QuLjYzZjk5OTFhOGEgMTAwNjQ0DQo+ID4gLS0tIGEvbWlncmF0aW9uL3NhdmV2bS5jDQo+
ID4gKysrIGIvbWlncmF0aW9uL3NhdmV2bS5jDQo+ID4gQEAgLTIzNDIsNiArMjM0MiwyMyBAQCBz
dGF0aWMgaW50DQo+ID4gbG9hZHZtX2hhbmRsZV9jbWRfcGFja2FnZWQoTWlncmF0aW9uSW5jb21p
bmdTdGF0ZSAqbWlzKQ0KPiA+DQo+ID4gICAgICBRRU1VRmlsZSAqcGFja2YgPSBxZW11X2ZpbGVf
bmV3X2lucHV0KFFJT19DSEFOTkVMKGJpb2MpKTsNCj4gPg0KPiA+ICsgICAgLyoNCj4gPiArICAg
ICAqIEJlZm9yZSBsb2FkaW5nIHRoZSBndWVzdCBzdGF0ZXMsIGVuc3VyZSB0aGF0IHRoZSBwcmVl
bXB0IGNoYW5uZWwgaGFzDQo+ID4gKyAgICAgKiBiZWVuIHJlYWR5IHRvIHVzZSwgYXMgc29tZSBv
ZiB0aGUgc3RhdGVzIChlLmcuIHZpYSB2aXJ0aW9fbG9hZCkgbWlnaHQNCj4gPiArICAgICAqIHRy
aWdnZXIgcGFnZSBmYXVsdHMgdGhhdCB3aWxsIGJlIGhhbmRsZWQgdGhyb3VnaCB0aGUgcHJlZW1w
dCBjaGFubmVsLg0KPiA+ICsgICAgICogU28geWllbGQgdG8gdGhlIG1haW4gdGhyZWFkIGluIHRo
ZSBjYXNlIHRoYXQgdGhlIGNoYW5uZWwgY3JlYXRlIGV2ZW50DQo+ID4gKyAgICAgKiBoYXNuJ3Qg
YmVlbiBkaXNwYXRjaGVkLg0KPiANCj4gSSdsbCBzcXVhc2ggYmVsb3cgaW50byBpdC4gIElmIGFu
eSBvZiB5b3UgZGlzYWdyZWUgcGxlYXNlIHNob290OiB2YWxpZCB1bnRpbCB0aGlzDQo+IFN1bmRh
eS4NCj4gDQo+ICsgICAgICogVE9ETzogaWYgd2UgY2FuIG1vdmUgbWlncmF0aW9uIGxvYWR2bSBv
dXQgb2YgbWFpbiB0aHJlYWQsIHRoZW4gd2UNCj4gKyAgICAgKiB3b24ndCBibG9jayBtYWluIHRo
cmVhZCBmcm9tIHBvbGxpbmcgdGhlIGFjY2VwdCgpIGZkcy4gIFdlIGNhbiBkcm9wDQo+ICsgICAg
ICogdGhpcyBhcyBhIHdob2xlIHdoZW4gdGhhdCBpcyBkb25lLg0KPiANCkxvb2tzIGdvb2QgdG8g
bWUuDQoNCg0K

