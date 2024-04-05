Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A1CCD1284
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 01:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsYXY-0004ob-Un; Thu, 04 Apr 2024 21:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsYXW-0004nE-I6
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 21:38:46 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsYXT-0007QQ-KJ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 21:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712281124; x=1743817124;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yT8rqb4wfljSu6CEm9Q+cYYa2TjnQ3Z8p21gnucJJzQ=;
 b=awH0XXgVvayEcseP0o4rQz/Bt14bpaOVQJj7xbhcXZwzvsACnrSkOMKx
 9w+KLqkJczSWHMkCAncTBsBbzFWOhqXYMEGlDUUQC7mJy3+Okhj50YIA3
 Jmglj61hYNYRQZWa8ULKVyiZKwn2vgUH11CAJyyrhcnNPaWRcozS25e57
 09T7vTN/MXRgj3RcLOwlhrlEGv1kuHRn9KhIDJi+krAWToFUdvY8uY4jU
 WdQWO7ym55p8NQAQyUwp+e5EfwrDynQnd3mzv7sXjQe+D1kvigR0XUVwF
 exEAV0ab4FygLYMcvOi0Rs1i8UTG6Pph5aa/OsiR2++kAOMlO8FwcvpR3 Q==;
X-CSE-ConnectionGUID: LqAwBoufT0mL9ThNiE3R3Q==
X-CSE-MsgGUID: MsWp4pg9R3exFjVwtkNHwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11393966"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; d="scan'208";a="11393966"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 18:38:41 -0700
X-CSE-ConnectionGUID: Z41cG7vjRfeOkt2n5BZv8w==
X-CSE-MsgGUID: WOxLt9txQjmwcbszyurJXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; d="scan'208";a="50241969"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Apr 2024 18:38:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 18:38:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 18:38:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 18:38:39 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 18:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZlP7zTZGj3k7z6bEoX3bfEAzk2QmDVSHxAzOcjC/8UJt6xQ8U1qduln9dFaD7c+Wv1Go8UzR/EG8u2E3CO3HEaRzkAVaRU0c9JDjQGirPI2kYG10LMaH1qny/wQ4UTWg/6MLi934Hvm/KHMrfqDUw/s8a/o3Lvo5mshpOiFg9lttV1ddNBOBvdz0shVxX/LQFeEHHM8fxPnqcL2LgW43mrat3T7qQmQUCAMUi9yyNxfKz25jYhT/3lPAsjKDUThgniJw8aLVHjoJMwf6cHQEakeSDB0Nhgp9rsW8kaEf5Fg+45zW0JDbHGR8WUFitgm5Utgka15K/l+wgIKjo9Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT8rqb4wfljSu6CEm9Q+cYYa2TjnQ3Z8p21gnucJJzQ=;
 b=mnBNNl0aCcN5efEs3ZypsAwQsiqmisN1qeQcx96ASsiwEb2/yyB+8uXOKQk0mjaqAQ4fHCF0ykXaxqRxF9TTPF2Jh6iGyhFQPMrgFfXhRw6ZZvVy1Ri5J25QR63SaZIq5ur6N3BRy+sWuVo5HIFZwcQYmR1zQm4ReS2mNAEHmRV2DesdhB9cJKTiephA3IcCTXAmcKLGj43pqZ670O/N7XR7zchXyB47Yqee4I2Sv2SrG4afQq/iKu6811m6swJ2a4X+w9o7CHlpxEuC21ffSr4lI/jHNBUYl3c2Y+/urN6jjx2w1q6QXPiCdVMXJnnllt4+Gd+/kMTQpUxaxHSf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.25; Fri, 5 Apr 2024 01:38:32 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 01:38:32 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>, "Wang, Lei4" <lei4.wang@intel.com>
CC: "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Topic: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Index: AQHahne59xUzBSmQ9kKgviWy8nsalrFYJxAAgAAU2RCAABbtgIAARWeAgAA7fiA=
Date: Fri, 5 Apr 2024 01:38:31 +0000
Message-ID: <DS0PR11MB637365DD124863C6C0DC995EDC032@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240404100550.17777-1-wei.w.wang@intel.com>
 <Zg61FnuPPAYAJs45@x1n>
 <DS0PR11MB6373FB3A707271E6E158258ADC3C2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <757123c0-c4f9-4332-adb7-e6296ab8d54a@intel.com> <Zg8UB900V4NpTwNG@x1n>
In-Reply-To: <Zg8UB900V4NpTwNG@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DS7PR11MB6064:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0G14oy141xMN07zsWfRmal4m4heenL2XKtFxD2YxWHfmM24J+i2tiW5Kmuu2y29QLeP216hUe6sOPbebMZBkllS0OrDAMAtNDiNEy4/Ijp0/VgmINBuX/XdpwA+7bHphfn3LEc5jo+vXlvvBPUVQosym2vNY/rwtWkVVwEz/CmwA/O0V7K2EnfgO2e4G957xL6/8HD+W7bXJqYGSA/AIeTKzVk8TqPOAfMF86YgBqbjVWriEOkbLvZ2B8n8JkakqobOCNl/Y6bUuFWtP0XigImyjvlEH9KC0/pq3jiTWWK3tYn/3jbSwEMIJCCmqqcB0jGh2ORyMUO/blVc9NKHkMro9eCfoKfYNlM2YmCaLx24jAXgyLLAGB7gXkePQFLwJaC5Fu4UIt+0QfPBwYm/uF5W3h6DDLzS3HD9a3BURWC9x+32o2AIRiYmtnXR+XndylxMS/ZG2PUNZfqEirQAoLMhgM0fYnIPvjzcsvyfrOI2FE5q4r3w8HUysLe2LlSPu8CF/N61HID2M46+1kYJIyuuiXsq5pN6wfRwzjTnPEjuSp8H8g6nOxw+EkvSrifyBPGFEGeqI3TsVwFDKezeTMt3aSCNrqNmQyouLWfIME68=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1REUWZDVzlaMTh0SWlTOHYweWp4Y3lHMW5YSDhTQXhVdm5WOFY2V0o3QTFS?=
 =?utf-8?B?VG9zMXdXQldLVzJvTUw2WHFRZStNTXdtS0ljRTFCTnNiUGNrSFNwOVZTN2h4?=
 =?utf-8?B?VjJ6YmhoK0FRdlh0enF6WG9TaVhJbis5SmVVRnd0dVVSaGVqVkVXZ3NOS0ZO?=
 =?utf-8?B?WjhsRlZBUytmZWQzMnZJd0swVG1BTzYwa2JVak96Si83dlR6ZkViRjlLZldl?=
 =?utf-8?B?cDRnbXplS0huRWw5VEhhNFE4bGJjNDljTlgwV2EzMm1xbDZEWS82L204V3U1?=
 =?utf-8?B?dTBHYlY3SzRsYVV0c3RBMk1OeE1PZHJQcGVmWC9ZNFAyblFWaFNyZkdwK3ov?=
 =?utf-8?B?S3FwRVRPbWRnOTR4eVhLWDNDTjNSV3Frenp4UXRzMDdDMTJabE1WNE4xTTg5?=
 =?utf-8?B?UmpETGNJOGQ4Y3RmZU9DM1g0TndrWEtlNW5jTnV1ZlI4L1BvQUNMN1Y4eXhB?=
 =?utf-8?B?NFl3MGJUYkFYNk5uTDFyY1paZzZKSVFuVGZhemJ2bTZYMFhLOWwrZ3BkdjlR?=
 =?utf-8?B?UnYvNUZFZDhTaTRINVBBVFhpcWhKcU90Y1lIdDRZOWh1N2RVZXFPWnAwUkpC?=
 =?utf-8?B?b2h4V1VwRDBCT2VhUXR1bnBvZ3NWcitETjJoOVJ4WE1TMTQrQXg5eVplSWFF?=
 =?utf-8?B?eGVPYXBBQzRXNzVMTEZYaS9hcmowS2JhUWZGUVcvTzQyNkhxZmhSYVdpeUxt?=
 =?utf-8?B?MWlnNndLdDFGTVpLcithS1FnVnF5WUQvVFdqeFRnZ1k5K0VvaEVnL212R0Qw?=
 =?utf-8?B?enJlRWNwdTMrWWRRdTY1NkxaQjZYZ1cxcWxGbFVEOWU5TzVEOVJOSnJ4WmY2?=
 =?utf-8?B?Z0pDcnFUN2oxN1lGajBYMEozdkR2UW5LNzlyWTlmaTdaOGhZeWQ1cEJjSjJo?=
 =?utf-8?B?aTN1Sm41WEdKOUM4eTlNK2xJTFNqMm9tU254Y1JUQ3lCZVh5ckZ1OFBzVGl6?=
 =?utf-8?B?dnU1YWIxb3Jqd0J0UUpLWFFIaGRzck4xR0o0SkQzdEJFRDlnclVjMnJTUWRJ?=
 =?utf-8?B?dGZJQUFWMFF1emZlTCs5Q3V0T2NDQmRIdzVCS21OMjBwaWlZSnRSeXp2aTFV?=
 =?utf-8?B?REJuNFdCTGM4RkpZNkYwbGVhR0dubkdxeXNxTm90UUJEczZNS1J3cld3ampE?=
 =?utf-8?B?dFZ0UEVudnRpWmNPYTJOV3YzeG9Bcm9oN2JLNVM5bjk0Rk5XNEQ5SXdtYk40?=
 =?utf-8?B?a3IyK0dtL3RBWmFzbnkyV2FCVndrbnNaV2cvTjNDK1lZL1lTRkoxdzMyYVRO?=
 =?utf-8?B?T01zb1hpMG5BajVCeEZIRm5OVXliQmtmQWhyZ3k2bFlOeFI0T003QklleU16?=
 =?utf-8?B?SU1JQ1BMMW1wcm1INm1PTWpqZEN5MzFveEhhUUZ3dDBLcVNkNDlSVkdrQnpa?=
 =?utf-8?B?M3JpUEJ0clhwVlBLMDMwNytGellyTU9wd3FoeVBKaXdrUkhUV2pBTHd6Z3dn?=
 =?utf-8?B?SGFXZ0tQYjhqRit0SGplMTR4d1FnbHJmUzExQmlsSEVWNUhkcE5PYzJqWE1V?=
 =?utf-8?B?Ti9HZ0FuYTg3VnZZZHUzWVVvTlFsRFJ1THVFb3BWK2t1RUlhUTZOSFBsZGlN?=
 =?utf-8?B?V0J1Q0NVS0hBT3lvM0pkdFVwSW1ia0Y2OEJOekQ2WDE0UEFUUVFsb2ZQQ25W?=
 =?utf-8?B?QTFhT3R5VWRFRCtRTUFpS0xFVWNQbllkRTk4T0czSlFNek9oZ1F6RkdQQnAw?=
 =?utf-8?B?RFJiaGswYkNhQWFLQnVtWWQ3dzZzd3hlcmhYMkY0ZEptSDNWZGNxK1JuOUNC?=
 =?utf-8?B?eFEwK2JCUkVvTVBuZGVUK1pNVUFYbWZpd2FBanliUFBVdFpoYlU2SzgzWUxy?=
 =?utf-8?B?VTFhSUxXMmVkUWtmMTVnSjluMWxsY0RmOVJEeTdQcGRjYUdlSjhxMkFKTEpv?=
 =?utf-8?B?ZnVTcndUL2czK2F5anV2bjR6NFZvZnRxdi9mSi84UVlWSjc2TGsxNjdOMFNB?=
 =?utf-8?B?MmRQZ0lTYnVDdVUvRGEzVll2WFZyRmVhc1dLUTlINkVoVFFTS09yUzBaaXNI?=
 =?utf-8?B?SEZaSTFTSWFQNEFJOWRFUFg5SEZmUDdLWmJBRk5BZ01JRFBiaUR0WUR2YzdB?=
 =?utf-8?B?OFNWL1o3MmQ1cytaa25UZFlYSUx5UzA4Tjg4VXpxTk5uNFoyZjMrL2k2NkRp?=
 =?utf-8?Q?G/WWAYmaxJewOPE6gwq6wbIWH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5b424d-8b30-445f-0cbe-08dc55111a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 01:38:31.9319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nz+4L2QC1FnRNWjv0jM0lDMAKTwbC4sDLRSfzjdRx9TmtDFY8s+/UxVQdz7r+E8ISQt3O4HCFwuQiKi8KqJfkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=wei.w.wang@intel.com;
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

T24gRnJpZGF5LCBBcHJpbCA1LCAyMDI0IDQ6NTcgQU0sIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBG
cmksIEFwciAwNSwgMjAyNCBhdCAxMjo0ODoxNUFNICswODAwLCBXYW5nLCBMZWkgd3JvdGU6DQo+
ID4gT24gNC81LzIwMjQgMDoyNSwgV2FuZywgV2VpIFcgd3JvdGU6PiBPbiBUaHVyc2RheSwgQXBy
aWwgNCwgMjAyNCAxMDoxMg0KPiA+IFBNLCBQZXRlciBYdSB3cm90ZToNCj4gPiA+PiBPbiBUaHUs
IEFwciAwNCwgMjAyNCBhdCAwNjowNTo1MFBNICswODAwLCBXZWkgV2FuZyB3cm90ZToNCj4gPiA+
Pj4gQmVmb3JlIGxvYWRpbmcgdGhlIGd1ZXN0IHN0YXRlcywgZW5zdXJlIHRoYXQgdGhlIHByZWVt
cHQgY2hhbm5lbA0KPiA+ID4+PiBoYXMgYmVlbiByZWFkeSB0byB1c2UsIGFzIHNvbWUgb2YgdGhl
IHN0YXRlcyAoZS5nLiB2aWENCj4gPiA+Pj4gdmlydGlvX2xvYWQpIG1pZ2h0IHRyaWdnZXIgcGFn
ZSBmYXVsdHMgdGhhdCB3aWxsIGJlIGhhbmRsZWQgdGhyb3VnaCB0aGUNCj4gcHJlZW1wdCBjaGFu
bmVsLg0KPiA+ID4+PiBTbyB5aWVsZCB0byB0aGUgbWFpbiB0aHJlYWQgaW4gdGhlIGNhc2UgdGhh
dCB0aGUgY2hhbm5lbCBjcmVhdGUNCj4gPiA+Pj4gZXZlbnQgaGFzIGJlZW4gZGlzcGF0Y2hlZC4N
Cj4gPiA+Pj4NCj4gPiA+Pj4gT3JpZ2luYWxseS1ieTogTGVpIFdhbmcgPGxlaTQud2FuZ0BpbnRl
bC5jb20+DQo+ID4gPj4+IExpbms6DQo+ID4gPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC85YWE1ZDFiZS03ODAxLTQwZGQtODNmZC1mN2UwNDFjZWQyNDlAaQ0KPiA+ID4+PiBudGVsDQo+
ID4gPj4+IC5jb20vVC8NCj4gPiA+Pj4gU3VnZ2VzdGVkLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IExlaSBXYW5nIDxsZWk0LndhbmdAaW50
ZWwuY29tPg0KPiA+ID4+PiBTaWduZWQtb2ZmLWJ5OiBXZWkgV2FuZyA8d2VpLncud2FuZ0BpbnRl
bC5jb20+DQo+ID4gPj4+IC0tLQ0KPiA+ID4+PiAgbWlncmF0aW9uL3NhdmV2bS5jIHwgMTcgKysr
KysrKysrKysrKysrKysNCj4gPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
DQo+ID4gPj4+DQo+ID4gPj4+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vc2F2ZXZtLmMgYi9taWdy
YXRpb24vc2F2ZXZtLmMgaW5kZXgNCj4gPiA+Pj4gMzg4ZDdhZjdjZC4uZmJjOWYyYmRkNCAxMDA2
NDQNCj4gPiA+Pj4gLS0tIGEvbWlncmF0aW9uL3NhdmV2bS5jDQo+ID4gPj4+ICsrKyBiL21pZ3Jh
dGlvbi9zYXZldm0uYw0KPiA+ID4+PiBAQCAtMjM0Miw2ICsyMzQyLDIzIEBAIHN0YXRpYyBpbnQN
Cj4gPiA+Pj4gbG9hZHZtX2hhbmRsZV9jbWRfcGFja2FnZWQoTWlncmF0aW9uSW5jb21pbmdTdGF0
ZSAqbWlzKQ0KPiA+ID4+Pg0KPiA+ID4+PiAgICAgIFFFTVVGaWxlICpwYWNrZiA9IHFlbXVfZmls
ZV9uZXdfaW5wdXQoUUlPX0NIQU5ORUwoYmlvYykpOw0KPiA+ID4+Pg0KPiA+ID4+PiArICAgIC8q
DQo+ID4gPj4+ICsgICAgICogQmVmb3JlIGxvYWRpbmcgdGhlIGd1ZXN0IHN0YXRlcywgZW5zdXJl
IHRoYXQgdGhlIHByZWVtcHQgY2hhbm5lbA0KPiBoYXMNCj4gPiA+Pj4gKyAgICAgKiBiZWVuIHJl
YWR5IHRvIHVzZSwgYXMgc29tZSBvZiB0aGUgc3RhdGVzIChlLmcuIHZpYSB2aXJ0aW9fbG9hZCkg
bWlnaHQNCj4gPiA+Pj4gKyAgICAgKiB0cmlnZ2VyIHBhZ2UgZmF1bHRzIHRoYXQgd2lsbCBiZSBo
YW5kbGVkIHRocm91Z2ggdGhlIHByZWVtcHQNCj4gY2hhbm5lbC4NCj4gPiA+Pj4gKyAgICAgKiBT
byB5aWVsZCB0byB0aGUgbWFpbiB0aHJlYWQgaW4gdGhlIGNhc2UgdGhhdCB0aGUgY2hhbm5lbCBj
cmVhdGUNCj4gZXZlbnQNCj4gPiA+Pj4gKyAgICAgKiBoYXMgYmVlbiBkaXNwYXRjaGVkLg0KPiA+
ID4+PiArICAgICAqLw0KPiA+ID4+PiArICAgIGRvIHsNCj4gPiA+Pj4gKyAgICAgICAgaWYgKCFt
aWdyYXRlX3Bvc3Rjb3B5X3ByZWVtcHQoKSB8fCAhcWVtdV9pbl9jb3JvdXRpbmUoKSB8fA0KPiA+
ID4+PiArICAgICAgICAgICAgbWlzLT5wb3N0Y29weV9xZW11ZmlsZV9kc3QpIHsNCj4gPiA+Pj4g
KyAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4+PiArICAgICAgICB9DQo+ID4gPj4+ICsNCj4gPiA+
Pj4gKyAgICAgICAgYWlvX2NvX3NjaGVkdWxlKHFlbXVfZ2V0X2N1cnJlbnRfYWlvX2NvbnRleHQo
KSwNCj4gPiA+PiBxZW11X2Nvcm91dGluZV9zZWxmKCkpOw0KPiA+ID4+PiArICAgICAgICBxZW11
X2Nvcm91dGluZV95aWVsZCgpOw0KPiA+ID4+PiArICAgIH0gd2hpbGUNCj4gPiA+Pj4gKyAoIXFl
bXVfc2VtX3RpbWVkd2FpdCgmbWlzLT5wb3N0Y29weV9xZW11ZmlsZV9kc3RfZG9uZSwNCj4gPiA+
Pj4gKyAxKSk7DQo+ID4gPj4NCj4gPiA+PiBJIHRoaW5rIHdlIG5lZWQgcy8hLy8gaGVyZSwgc28g
dGhlIHNhbWUgbWlzdGFrZSBJIG1hZGU/ICBJIHRoaW5rIHdlDQo+ID4gPj4gbmVlZCB0byByZXdv
cmsgdGhlIHJldHZhbCBvZiBxZW11X3NlbV90aW1lZHdhaXQoKSBhdCBzb21lIHBvaW50IGxhdGVy
Li4NCj4gPiA+DQo+ID4gPiBOby4gcWVtdV9zZW1fdGltZWR3YWl0IHJldHVybnMgZmFsc2Ugd2hl
biB0aW1lb3V0LCB3aGljaCBtZWFucyBzZW0NCj4gaXNu4oCZdCBwb3N0ZWQgeWV0Lg0KPiA+ID4g
U28gaXQgbmVlZHMgdG8gZ28gYmFjayB0byB0aGUgbG9vcC4gKHRoZSBwYXRjaCB3YXMgdGVzdGVk
KQ0KPiA+DQo+ID4gV2hlbiB0aW1lb3V0LCBxZW11X3NlbV90aW1lZHdhaXQoKSB3aWxsIHJldHVy
biAtMS4gSSB0aGluayB0aGUgcGF0Y2gNCj4gPiB0ZXN0IHBhc3NlZCBtYXkgYmVjYXVzZSB5b3Ug
d2lsbCBhbHdheXMgaGF2ZSBhdCBsZWFzdCBvbmUgeWllbGQgKHRoZQ0KPiA+IGZpcnN0IHlpZWxk
IGluIHRoZSBkbyAuLi53aGlsZSAuLi4pIHdoZW4gbG9hZHZtX2hhbmRsZV9jbWRfcGFja2FnZWQo
KT8NCj4gDQo+IE15IGd1ZXNzIGlzIHRoYXQgaGVyZSB0aGUga2ljayB3aWxsIHdvcmsgYW5kIHFl
bXVfc2VtX3RpbWVkd2FpdCgpIGxhdGVyIHdpbGwNCj4gRVRJTUVPVVQgLT4gcWVtdV9zZW1fdGlt
ZWR3YWl0KCkgcmV0dXJucyAtMSwgdGhlbiB0aGUgbG9vcCBqdXN0IGJyb2tlLg0KPiBUaGF0IGFp
byBzY2hlZHVsZSBzaG91bGQgbWFrZSBzdXJlIGFueXdheSB0aGF0IHRoZSBmaWxlIGlzIHJlYWR5
OyB0aGUgcHJlZW1wdA0KPiB0aHJlYWQgbXVzdCBydW4gYmVmb3JlIHRoaXMgdG8gbm90IGhhbmcg
dGhhdCB0aHJlYWQuDQoNClllcywgbWlzcmVhZCBvZiB0aGUgcmV0dXJuIHZhbHVlLiBJdCBzdGls
bCB3b3JrZWQgYmVjYXVzZSB0aGUgbG9vcCBicm9rZSBhdA0KdGhlICJpZiAobWlzLT5wb3N0Y29w
eV9xZW11ZmlsZV9kc3QpIiBjaGVjay4NCg0KRXZlbiBiZWxvdyB3aWxsIHdvcms6DQpkbyB7DQog
ICAgaWYgKG1pcy0+cG9zdGNvcHlfcWVtdWZpbGVfZHN0KSB7DQogICAgICAgIGJyZWFrOw0KICAg
ICB9DQouLi4NCn0gd2hpbGUgKDEpOw0KDQpJIHN0aWxsIGRvbuKAmXQgc2VlIHRoZSB2YWx1ZSBv
ZiB1c2luZyBwb3N0Y29weV9xZW11ZmlsZV9kc3RfZG9uZSBzZW0gaW4gdGhlIGNvZGUgdGhvdWdo
DQpJdCBzaW1wbGlmeSBibG9ja3MgdGhlIG1haW4gdGhyZWFkIGZyb20gY3JlYXRpbmcgdGhlIHBy
ZWVtcHQgY2hhbm5lbCBmb3IgMW1zIChyZWdhcmRsZXNzDQpvZiB0aGUgcG9zc2liaWxpdHkgYWJv
dXQgd2hldGhlciB0aGUgc2VtIGhhcyBiZWVuIGJlIHBvc3RlZCBvciBub3QuIFdlIGFkZCBpdCBm
b3IgdGhlIGNhc2UNCml0IGlzIG5vdCBwb3N0ZWQgYW5kIG5lZWQgdG8gZ28gYmFjayB0byB0aGUg
bG9vcCkuDQo=

