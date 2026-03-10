Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334D8FCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4t-0007AP-Ox; Tue, 10 Mar 2026 01:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vzq4q-00075W-I4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:20 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vzq4m-0006G3-Mu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773122177; x=1804658177;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F5NHa4JwL78O1viMZ9Vk/kr+/TXGtPlApbfKBF+oALc=;
 b=ScPgXdt3uxmkV09SkP/uC59uDAEFA/yutNcZgABjk4em85RWaOoHbQCV
 uKYKXnaDQF8rsIM6B/P+Jd9JRa0lzogsN7yt6u+6RrpRix4TZeaoKRW3o
 DNB+2wneY/iYCkmExYIweVOiOP0o+vDTLcDENgKl/cPxJClpodm+GUm/7
 KFFW5Qha2jCaMRiZc3olo+haGQUtr3nOVhrthudssJzsZPhAno43boxk2
 PdvCPxUyoxkimZl3l7AMmsibzhuvl22KpzykGBXcDJlmCiISwV0smQWvo
 uWNH9p0VpnNhFOLWvsplWOc1V512LvRAgx/jl2CwjX0bR4bfDkZeGvttZ g==;
X-CSE-ConnectionGUID: h0DGOzCQQxyumzk5b40jXw==
X-CSE-MsgGUID: nt1ZbQqRSUuFaUiJbyepXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85634914"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; d="scan'208";a="85634914"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 22:56:02 -0700
X-CSE-ConnectionGUID: yJeOzUy/T1GpV8hFnHxHpw==
X-CSE-MsgGUID: UFKjrreURWitKm9ycZ3xhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; d="scan'208";a="216412997"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 22:56:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 22:56:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 22:56:00 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 22:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqJ1Fa+926CgvesgS8c4E90TZkCAOT8CxDsVv304ggrLcregUsrU68cXYnhEkMA+ThyaIzMbyRQTW8R8CeKwKnrNKhGZiT9WS2xpRNVFtQUgs4gWQ36K/qG0fdYxL6ZBxkaK9IAxvDjszx6ZJF1o/rOE0lIPfwCLDZOg45YzjbnPx1jILfrqfjjAULGrPOphhJS7Ebr4/yNe8AA351lF4k9t1yOC0oc/aW+rLGrrf6w0neMRs/C2QANYSdKEnnJm7H72U3Utqio+8MzJCSb6nSPJRINVdg/ZSFyypSAhxLQ5NNRPtiFBxejKKZB4sBV81nICAN13QrQ13rRjw98ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5NHa4JwL78O1viMZ9Vk/kr+/TXGtPlApbfKBF+oALc=;
 b=HLX+iDibNvDbksyIAZKCkPR0uzkCxfABpjBxag5xbF0y9/N4PYYf2cXT8NT7uZ0cnVhNFwN00TdTy6oFk5S8SKMkVScv8ErNwtXRTAfHum8cMKYUUQ9xBS3bbiv4WgXclQXsDg0tJKPY/PNqnVkHGNFUzltG8DBKxq2jwvF+GvxZGzw72bc6pvZ0fPPlE0FDVs6QvfcxyNrcIX6VlYZ+05kZgFkmZM9DuFIOwczVrnjHE08odV+/jTp6N+4a7+RURVlB9ng/d5pbtlIuiYLgMFZhB3s/euLkhhFwbPSnnJ34479+13tycOIYdwt2iytqKyBU2RL1fuz7AcmWT6gmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 05:55:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 05:55:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>,
 =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@bull.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Xu" <peterx@redhat.com>
Subject: RE: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Thread-Topic: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Thread-Index: AQHcr6YGzz6xdqy6GE2gPu/CciTCTLWmN7iAgAEL2fA=
Date: Tue, 10 Mar 2026 05:55:57 +0000
Message-ID: <IA3PR11MB91365CDA9A4E4FF11957E3F39246A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
 <aa7P13u3yconC_JU@redhat.com>
In-Reply-To: <aa7P13u3yconC_JU@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB6544:EE_
x-ms-office365-filtering-correlation-id: 323ceae3-b8c1-4be8-2272-08de7e69b358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: Aza8dnMxRdCHgVdzgf6OkU1JpICgw2jSaoHManolDtClYIVmaajve+Hq60DUBF7JRZ8vWpfIuNrMQUq3IENUVgewBxw5S3l2wuMZ0yh3lg5HkHpJIZ+nBkvlneeB9dZdK0aO4KcOf1TNjztAath89+FSdgPZS+FNGJmiFyyxAbMnF3Y7Kr05+dHiDR76ngR8lzmjOE/6kq9dnMAOqwSxO+VwSQac0QowmMszh2TTvk8Rg3ifCMg981OyomFtT4GYeVpJFvrjMNacoZcU6wHaZjrEDqgyiRhPfyC0nLSmEGzbPRmuyDOG4TQg2fYsierMzndiVDp9eEvzxZNdlN4RSilzgtfIL53gBCczp6kd5r2mJC0V8NfMFYJx37bngt/p6st3HVllChstNLzgd/1uYqoyGlyJyylhIg54xkiKAAQqdX15364XKw7MhyClVujcVECyg7Eu8+brxUPTv2FEbyGVUWyHvkTKLrEwJeIso7P12/uTQbH/Htnb5J5lOTPb7x8NaVSt6EK+IaCmYFtXyWQXvIs0M1B90P2qRo99rmLHjZsgpTKPsfjlO/NGzuK6Lfa0OWk4RamYnDamnchMi5P6gVgIkXErQYwXXIVSpQ0Oy12S3QNLLDYrzvQcB2KWznpTSnA8iv9uDdLYCB8dORdDXpK9+qi0Qljo5oCU1A/0pN2uuKP4cW3gODEbKHT0qgIVvdqVS9LkngK2QBwR2WBcqiAmipucca2pXNVAIeQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME1zMUsyZ2hXVktEM1FUbGVwanYyTlpDR05iSEVJT1dFQVlUUlhPcVozMVhw?=
 =?utf-8?B?cHVSSHBVWCtnZjFVR085ZnJ3cVlPUjBtZ0Vqd2UwNUZpSlRCRmtFOE9mdFFF?=
 =?utf-8?B?YjRSMXBLNE1oODNxd3NDcGtkaDBJcXRSY1lPQ2hlU0hMUzF2elUxcFEzQ0JT?=
 =?utf-8?B?eVI3OXVjOTFYbTZOWmMzWnVld3JhYUdaaFE0RHpDVE82SFU5bHZzRFF6M2pH?=
 =?utf-8?B?ODVsTnViOU0xRWpDMUpCdGc1Q0hwRVRiMG42RFJ0czF1cStDZXlhYU5Sc0kw?=
 =?utf-8?B?SzhJQWxHWlpuV00yUXhhUXJJOWc2M1BXZlFCQVNObVJNZDJVV3hDWVhmcVlw?=
 =?utf-8?B?ckxmNkhpYVBacHFCUGdESXZWSTRVL3NoWkxYVTNWazhwVDFRdWtmTGhSbnBJ?=
 =?utf-8?B?aHVKRCtZRlpQM3dwT0NKc0xEV1BkVTc0SWZOT0poTkN5YkloYjVBMW9YazZ3?=
 =?utf-8?B?SGFYdlBTTERxWklISEVLVk4wcWpRVXI4MVNwNHNDakpEK3draGN3ZElzYzRw?=
 =?utf-8?B?UGNDOUFTMTdWY3JmaWIvWmVMYzdTTThIK2NxWkRMS3pQSDVRUkFlRGYyNGI0?=
 =?utf-8?B?RlpRMnhMOFVuRlRCL01Sa2dxS1hlNXBuUnNteXVJZFg4S0M2MndwaVk0N3I2?=
 =?utf-8?B?NjRjUWlGZUcrbTVzeFFqcnJkTGNvWERnbG1GbkpSMGRpMlVsdi9LZnduelkz?=
 =?utf-8?B?cTZRZEloRU9ER1M2OFp2R2VzWXViWUJqQzc0SFB0eGdvbnJHRWlDT05wSXhh?=
 =?utf-8?B?amt0bzBFVDRxTmRZcjBKcHB2QmIrdjNCUXR1T3dyakV6YUwzWTFycGJobXRV?=
 =?utf-8?B?NnNrWUhWZlFzenlwa1pKR1BDangxcC83V1IrMkZQNEh2R1NPRmhXWVJJbVpl?=
 =?utf-8?B?Vi9BYUdCckx1N2hsZ3lNVU1CTEh5TW11ZERTdFNEQzQ0UERsOTdPaHJPa0dn?=
 =?utf-8?B?WW5lQTRwZFBNdEJLdlh0dit0Q2hCNVB5aWZDdElyV0I4WWhKdW1Qd2YyR2lP?=
 =?utf-8?B?blBVWEVTMi9MQ1BYT2F6TmJyek91c1BzaFVScERzakk4bzVnN2NpZG9BS1pR?=
 =?utf-8?B?Y3Z1Z1JPSFJOanh4WENqS0dJM2cyQ0N5VkF0SjV6UW5GNVc4YUZpeitDcHJC?=
 =?utf-8?B?YU5OdTAzSkFzSmU1eVZ6aXJJMExaQXhYdlhBN0RQM3F3T1dOSVplTTBoQjhT?=
 =?utf-8?B?czRBQjJhSmFKVnROaWJZOU5MeWxrREsyWmtxamQ0M2psK3hGMmtncitPRGYy?=
 =?utf-8?B?SDF5cGhzQyswS0F2Z0w4R0pVRWdpbEx1Y0J6RkFPaUx4WTZLRE5aWU1hMm9h?=
 =?utf-8?B?TE0yUmlUeERGeWtta3pMTk9UU2IwNU5EQnlMTnQ1VFBRc1BDOU11QXR6dWJl?=
 =?utf-8?B?Z01vN3RhZDVMZmZJQ09RUE5sUXJlOWhvVEtSc21YaFdYcVhyQlBjbWxVcWpr?=
 =?utf-8?B?V1F5WG0wQlRrU3htZmt5V3pWQlhjd0ZJUWM4cUs2LzE5dVFMZGJ0U24zazA4?=
 =?utf-8?B?OXdEK3lpUklJODlBYURnZXVTWUw0bitSTzIzakZ1ZFYvQVBuVVp3SzhJa2k4?=
 =?utf-8?B?ekNmOUpGTGV5bzBvRHNtVmNmQkdHdG9FdG1TRWREYjd5S0N1RlREd3NzdHc0?=
 =?utf-8?B?UW0yZnE3TEVQOUM3L0VmTmFhdktrQ25Oa2pmbWgwUU83Zk9nR3hOeFVNdk1C?=
 =?utf-8?B?dGlBSm9Talp0ZElKaW00amUwUWJSWlRDbmR6VnRXM3lXV25jZnFPUk1ybHhx?=
 =?utf-8?B?Zzk3b0NmUGVVMnM5dnpsU3hiMkV2KzVzQ2JXcVQ5K254d0Q0NzIyRGQ1NDJK?=
 =?utf-8?B?andXZVhMRlVudDFXaGJsWGw1cWY3MHpZVGxwNm0vb2ZrTUFqbGN3czZRT2JK?=
 =?utf-8?B?clZ5aXFSQ042M2REQ0JLOTI2V3M2TGtXRXA3cmFsZ3lIRmo0NTZrQXUyem5Q?=
 =?utf-8?B?dFV1djNsTzkyQi9NMDRWVjI4K1FDcFhhaVFpTldIS1VrY0ZwMVMyMEJ0SGFm?=
 =?utf-8?B?RitDa0J6cGorTXlZZDBkT1lHVXNvZXQ3OUJHSmYvcUg2NUVlK2JaL0lBSzZ4?=
 =?utf-8?B?V3ZJSHZOdmY2V2FmUlU5Z1FlMmhSSEtVdllMWWhHcUJsL1ZCZC9RRVV2eWdz?=
 =?utf-8?B?VUlxVS9DbVIxOHR5b3ZrZ2ZCVGY0OTA5TFE3SUdwVTYrT004WTFlSE8yeTRz?=
 =?utf-8?B?bW11OVEwUXlHZm5GOTRxbWI5U0llelRUT0RQaFBWZkxWTjBHQWtOYlYxZWZV?=
 =?utf-8?B?U2ovK0MvNHoxUlFnd0xCWmFCZHZQVUJIWjBuZ1d5dmVIM1FoR3U5Wks4YjZ0?=
 =?utf-8?B?aHNEMWpYQlVSdEY0Vkx0ZnJQczVkZ1VzSnM1Nko2ejZoZ3VneEMydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: odmAhHAlXTEVENuNctIRPIFWmzI9B5fAtOr2TzmOeN0AcT21cWytoSayZ5bLlJewSWYv0/g+TqFw8NcNC868kdPb2A8zdQCCidaa2qLIsNdtxsTqKbt3JQQmJ7guZ86Wy/u+KgQLdBSnPZxTVgr38673s+1GQOhjDSJ/C9mJppEv256m0wqdqY4+bVg4qE+RZzv8KA/6E59Vni18f3gUI44cHg3Ww4cqqcRoyKbfaO7qosdEJN14hGrv19OufiYRcHkhz1w/XMEzI/JCNdl/+VidCqsVsUbCnUm8W79RpDnW9H9EPh+SNEvM3756AHJ9K3pdrHV5za8mCa07bH5uaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323ceae3-b8c1-4be8-2272-08de7e69b358
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:55:57.8128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0bAsPLz3slhXskT9DIpDTvGGHu7NcE9aBNCOg7FsfCF3Qe2HYz9mgsO/rYU3Mzh+yZJo5tnmrU3w6oa3pzlnDjftgdFiTXsiZjsX4g2ZeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBQLiBCZXJyYW5n
w6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9t
bXU6IFJlbW92ZSAneC0nIHByZWZpeCBmcm9tICd4LXNjYWxhYmxlLW1vZGUnIGFuZA0KPid4LWZs
dHMnIHByb3BlcnRpZXMNCj4NCj5PbiBNb24sIE1hciAwOSwgMjAyNiBhdCAwNToyMDoyN0FNIC0w
NDAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdlIGhhZCAneC1zY2FsYWJsZS1tb2RlJyBm
b3IgbW9yZSB0aGFuIDUgeWVhcnMgYW5kICd4LWZsdHMnIGZvciBtb3JlIHRoYW4gMQ0KPj4geWVh
ciwgaXQncyBmaW5lIHRvIHJlbW92ZSAneC0nIG5vdy4NCj4NCj5JIHRyaWVkIHRvIGxvb2sgYXQg
aGlzdG9yeSB0byB1bmRlcnN0YW5kIHdoeSB3ZSB1c2VkIGFuICd4LScgcHJlZml4IHRvDQo+YmVn
aW4gd2l0aC4gVGhlcmUgZG9lc24ndCBzZWVtIHRvIGhhdmUgYmVlbiBhIHZlcnkgY29tcGVsbGlu
ZyByZWFzb24sDQo+anVzdCBhIHN1Z2dlc3Rpb24gZnJvbSBQZXRlciAoY2MnZCkNCj4NCj4gICBo
dHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0wMi9t
c2cwMjg0Ny5odG1sDQo+DQo+SWYgd2UgYXNzdW1lIHRoZXNlIGZlYXR1cmVzIGFyZSBuZWVkZWQg
Zm9yDQo+DQo+PiBUaGlzIGlzIGEgcHJlcmVxdWlzaXRlIHRvIGVuYWJsZSBpbnRlbF9pb21tdSdz
IHNjYWxhYmxlIG1vZGUgYW5kIGZpcnN0IHN0YWdlDQo+PiB0cmFuc2xhdGlvbiBzdXBwb3J0IGlu
IGxpYnZpcnQuDQo+DQo+WWVwLCBsaWJ2aXJ0IHdpbGwgbm90IHN1cHBvcnQgYW55IHNldHRpbmcg
d2l0aCBhbiAneC0nIHByZWZpeCwNCj51bnRpbCBpdCBpcyBncmFkdWF0ZWQgdG8gc3VwcG9ydGFi
bGUgYnkgUUVNVQ0KPg0KPg0KPldoYXQncyB0aGUgdHlwaWNhbCB1c2UgY2FzZSB3aGVyZSBhIHVz
ZXIgbmVlZHMgdG8gc2V0IHRoZXNlDQo+dHdvIHByb3BlcnRpZXMgPw0KDQpBbnkgc2NlbmFyaW8g
dGhhdCBsZWdhY3kgbW9kZSBhbmQgc2Vjb25kIHN0YWdlIHRyYW5zbGF0aW9uIGNhbid0IHN1cHBv
cnQuDQpFLmcuLCB1c2VyIHdhbnQgdG8gdXNlIFNWTSBmZWF0dXJlLCB1c2VyIHdhbnQgcGFzaWQg
c3VwcG9ydCwgZXRjLg0KDQpCUnMsDQpaaGVuemhvbmcNCg0KPg0KPlByZXN1bWluZyB3ZSdsbCBu
ZWVkIHRvIHN1cHBvcnQgdGhvc2UgdXNlIGNhc2VzIGluZGVmaW5pdGVseSwNCj5hbmQgd2UgaGF2
ZSBubyBiZXR0ZXIgUUVNVSBkZXNpZ24gYXZhaWxhYmxlLCB0aGVuIGRyb3BwaW5nIHRoZQ0KPid4
LScgcHJlZml4IG1ha2VzIHNlbnNlLg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGRvY3MvZGV2ZWwvdmZp
by1pb21tdWZkLnJzdCAgICB8IDEwICsrKysrLS0tLS0NCj4+ICBody9pMzg2L2ludGVsX2lvbW11
LmMgICAgICAgICAgfCAgOCArKysrLS0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwu
YyAgICB8ICA0ICsrLS0NCj4+ICB0ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMgfCAgMiAr
LQ0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0p
DQo+DQo+DQo+DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJz
dCBiL2RvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4gaW5kZXggNzhiY2RmZmFjNy4uNTc1
NTUzMjQ0MyAxMDA2NDQNCj4+IC0tLSBhL2RvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4g
KysrIGIvZG9jcy9kZXZlbC92ZmlvLWlvbW11ZmQucnN0DQo+PiBAQCAtMTUzLDIyICsxNTMsMjIg
QEAgUkFNIGRpc2NhcmRpbmcgZm9yIG1kZXYuDQo+PiAgYGB2ZmlvLWFwYGAgYW5kIGBgdmZpby1j
Y3dgYCBkZXZpY2VzIGRvbid0IGhhdmUgc2FtZSBpc3N1ZSBhcyB0aGVpciBiYWNrZW5kDQo+PiAg
ZGV2aWNlcyBhcmUgYWx3YXlzIG1kZXYgYW5kIFJBTSBkaXNjYXJkaW5nIGlzIGZvcmNlIGVuYWJs
ZWQuDQo+Pg0KPj4gLVVzYWdlIHdpdGggaW50ZWxfaW9tbXUgZmVhdHVyaW5nIHgtZmx0cz1vbg0K
Pj4gK1VzYWdlIHdpdGggaW50ZWxfaW9tbXUgZmVhdHVyaW5nIGZsdHM9b24NCj4+ICAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+PiAgT25seSBJT01NVUZE
IGJhY2tlZCBWRklPIGRldmljZSBpcyBzdXBwb3J0ZWQgd2hlbiBpbnRlbF9pb21tdSBpcw0KPmNv
bmZpZ3VyZWQNCj4+IC13aXRoIHgtZmx0cz1vbiwgZm9yIGxlZ2FjeSBjb250YWluZXIgYmFja2Vk
IFZGSU8gZGV2aWNlLCBiZWxvdyBlcnJvciBzaG93czoNCj4+ICt3aXRoIGZsdHM9b24sIGZvciBs
ZWdhY3kgY29udGFpbmVyIGJhY2tlZCBWRklPIGRldmljZSwgYmVsb3cgZXJyb3Igc2hvd3M6DQo+
Pg0KPj4gIC4uIGNvZGUtYmxvY2s6OiBub25lDQo+Pg0KPj4gLSAgICBxZW11LXN5c3RlbS14ODZf
NjQ6IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAwOjAyOjAwLjA6IHZmaW8gMDAwMDowMjowMC4w
Og0KPkZhaWxlZCB0byBzZXQgdklPTU1VOiBOZWVkIElPTU1VRkQgYmFja2VuZCB3aGVuIHgtZmx0
cz1vbg0KPj4gKyAgICBxZW11LXN5c3RlbS14ODZfNjQ6IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0w
MDAwOjAyOjAwLjA6IHZmaW8gMDAwMDowMjowMC4wOg0KPkZhaWxlZCB0byBzZXQgdklPTU1VOiBO
ZWVkIElPTU1VRkQgYmFja2VuZCB3aGVuIGZsdHM9b24NCj4+DQo+PiAgVkZJTyBkZXZpY2UgdW5k
ZXIgUENJIGJyaWRnZSBpcyB1bnN1cHBvcnRlZCwgdXNlIFBDSUUgYnJpZGdlIGlmIG5lY2Vzc2Fy
eSwNCj4+ICBvdGhlcndpc2UgYmVsb3cgZXJyb3Igc2hvd3M6DQo+Pg0KPj4gIC4uIGNvZGUtYmxv
Y2s6OiBub25lDQo+Pg0KPj4gLSAgICBxZW11LXN5c3RlbS14ODZfNjQ6IC1kZXZpY2UgdmZpby0N
Cj5wY2ksaG9zdD0wMDAwOjAyOjAwLjAsYnVzPWJyaWRnZTEsaW9tbXVmZD1pb21tdWZkMDogdmZp
byAwMDAwOjAyOjAwLjA6IEZhaWxlZA0KPnRvIHNldCB2SU9NTVU6IEhvc3QgZGV2aWNlIGRvd25z
dHJlYW0gdG8gYSBQQ0kgYnJpZGdlIGlzIHVuc3VwcG9ydGVkIHdoZW4geC0NCj5mbHRzPW9uDQo+
PiArICAgIHFlbXUtc3lzdGVtLXg4Nl82NDogLWRldmljZSB2ZmlvLQ0KPnBjaSxob3N0PTAwMDA6
MDI6MDAuMCxidXM9YnJpZGdlMSxpb21tdWZkPWlvbW11ZmQwOiB2ZmlvIDAwMDA6MDI6MDAuMDog
RmFpbGVkDQo+dG8gc2V0IHZJT01NVTogSG9zdCBkZXZpY2UgZG93bnN0cmVhbSB0byBhIFBDSSBi
cmlkZ2UgaXMgdW5zdXBwb3J0ZWQgd2hlbg0KPmZsdHM9b24NCj4+DQo+PiAgSWYgaG9zdCBJT01N
VSBoYXMgRVJSQVRBXzc3MjQxNV9TUFIxNywgcnVubmluZyBndWVzdCB3aXRoDQo+ImludGVsX2lv
bW11PW9uLHNtX29mZiINCj4+ICBpcyB1bnN1cHBvcnRlZCwga2V4ZWMgb3IgcmVib290IGd1ZXN0
IGZyb20gImludGVsX2lvbW11PW9uLHNtX29uIiB0bw0KPj4gQEAgLTE3Nyw0ICsxNzcsNCBAQCBi
ZWxvdyBpZiBpdCdzIG5vdCBuZWVkZWQgYnkgZ3Vlc3Q6DQo+Pg0KPj4gIC4uIGNvZGUtYmxvY2s6
OiBiYXNoDQo+Pg0KPj4gLSAgICAtZGV2aWNlIGludGVsLWlvbW11LHgtc2NhbGFibGUtbW9kZT1v
ZmYNCj4+ICsgICAgLWRldmljZSBpbnRlbC1pb21tdSxzY2FsYWJsZS1tb2RlPW9mZg0KPj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gaW5kZXggZDI0YmE5ODliZi4uMDAxODQ3YWQzNyAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtNDIw
MCw4ICs0MjAwLDggQEAgc3RhdGljIGNvbnN0IFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7
DQo+PiAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJhdy1iaXRzIiwgSW50ZWxJT01NVVN0YXRlLCBh
d19iaXRzLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9BRERSRVNTX1dJRFRI
KSwNCj4+ICAgICAgREVGSU5FX1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01NVVN0
YXRlLCBjYWNoaW5nX21vZGUsDQo+RkFMU0UpLA0KPj4gLSAgICBERUZJTkVfUFJPUF9CT09MKCJ4
LXNjYWxhYmxlLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIHNjYWxhYmxlX21vZGUsDQo+RkFMU0Up
LA0KPj4gLSAgICBERUZJTkVfUFJPUF9CT09MKCJ4LWZsdHMiLCBJbnRlbElPTU1VU3RhdGUsIGZz
dHMsIEZBTFNFKSwNCj4+ICsgICAgREVGSU5FX1BST1BfQk9PTCgic2NhbGFibGUtbW9kZSIsIElu
dGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVfbW9kZSwNCj5GQUxTRSksDQo+PiArICAgIERFRklORV9Q
Uk9QX0JPT0woImZsdHMiLCBJbnRlbElPTU1VU3RhdGUsIGZzdHMsIEZBTFNFKSwNCj4+ICAgICAg
REVGSU5FX1BST1BfQk9PTCgic25vb3AtY29udHJvbCIsIEludGVsSU9NTVVTdGF0ZSwgc25vb3Bf
Y29udHJvbCwNCj5mYWxzZSksDQo+PiAgICAgIERFRklORV9QUk9QX0JPT0woIngtcGFzaWQtbW9k
ZSIsIEludGVsSU9NTVVTdGF0ZSwgcGFzaWQsIGZhbHNlKSwNCj4+ICAgICAgREVGSU5FX1BST1Bf
Qk9PTCgic3ZtIiwgSW50ZWxJT01NVVN0YXRlLCBzdm0sIGZhbHNlKSwNCj4+IEBAIC01NTY0LDcg
KzU1NjQsNyBAQCBzdGF0aWMgYm9vbCB2dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUg
KnMsDQo+RXJyb3IgKiplcnJwKQ0KPj4gICAgICB9DQo+Pg0KPj4gICAgICBpZiAoIXMtPnNjYWxh
YmxlX21vZGUgJiYgcy0+ZnN0cykgew0KPj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAieC1m
bHRzIGlzIG9ubHkgYXZhaWxhYmxlIGluIHNjYWxhYmxlIG1vZGUiKTsNCj4+ICsgICAgICAgIGVy
cm9yX3NldGcoZXJycCwgImZsdHMgaXMgb25seSBhdmFpbGFibGUgaW4gc2NhbGFibGUgbW9kZSIp
Ow0KPj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAgICB9DQo+Pg0KPj4gQEAgLTU1Nzcs
NyArNTU3Nyw3IEBAIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0
ZSAqcywNCj5FcnJvciAqKmVycnApDQo+PiAgICAgIH0NCj4+DQo+PiAgICAgIGlmIChzLT5mc3Rz
ICYmIHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpIHsNCj4+IC0gICAgICAgIGVycm9y
X3NldGcoZXJycCwgIlNjYWxhYmxlIG1vZGUoeC1mbHRzPW9uKTogc3VwcG9ydGVkIHZhbHVlIGZv
ciAiDQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJTY2FsYWJsZSBtb2RlKGZsdHM9b24p
OiBzdXBwb3J0ZWQgdmFsdWUgZm9yICINCj4+ICAgICAgICAgICAgICAgICAgICAgImF3LWJpdHMg
aXM6ICVkIiwgVlREX0hPU1RfQVdfNDhCSVQpOw0KPj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
Pj4gICAgICB9DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBpbmRleCA2N2Q1NDg0OWYyLi5iMjhkNWVi
OWZhIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IEBAIC0yNiw3ICsyNiw3IEBAIGJvb2wg
dnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLA0KPlZUREhvc3RJT01NVURl
dmljZSAqdnRkX2hpb2QsDQo+PiAgICAgIFBDSURldmljZSAqcGRldiA9IGJ1cy0+ZGV2aWNlc1t2
dGRfaGlvZC0+ZGV2Zm5dOw0KPj4NCj4+ICAgICAgaWYgKCFvYmplY3RfZHluYW1pY19jYXN0KE9C
SkVDVChoaW9kKSwNCj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQpKSB7DQo+PiAtICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJOZWVkIElPTU1VRkQgYmFja2VuZCB3aGVuIHgtZmx0cz1v
biIpOw0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVlZCBJT01NVUZEIGJhY2tlbmQg
d2hlbiBmbHRzPW9uIik7DQo+PiAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgICAgIH0NCj4+
DQo+PiBAQCAtNDQsNyArNDQsNyBAQCBib29sIHZ0ZF9jaGVja19oaW9kX2FjY2VsKEludGVsSU9N
TVVTdGF0ZSAqcywNCj5WVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLA0KPj4NCj4+ICAgICAg
aWYgKHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihwZGV2LCAmYnVzLCBOVUxMLCBOVUxM
KSkgew0KPj4gICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSG9zdCBkZXZpY2UgZG93bnN0cmVh
bSB0byBhIFBDSSBicmlkZ2UgaXMgIg0KPj4gLSAgICAgICAgICAgICAgICAgICAidW5zdXBwb3J0
ZWQgd2hlbiB4LWZsdHM9b24iKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgInVuc3VwcG9ydGVk
IHdoZW4gZmx0cz1vbiIpOw0KPj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAgICB9DQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYyBiL3Rlc3Rz
L3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPj4gaW5kZXggZTVjYzZhY2FmMC4uNGYxMmM1NjI2
MCAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPj4gKysr
IGIvdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+PiBAQCAtMjksNyArMjksNyBAQCBz
dGF0aWMgdm9pZCB0ZXN0X2ludGVsX2lvbW11X3N0YWdlXzEodm9pZCkNCj4+ICAgICAgdWludDY0
X3QgY2FwLCBlY2FwLCB0bXA7DQo+PiAgICAgIFFUZXN0U3RhdGUgKnM7DQo+Pg0KPj4gLSAgICBz
ID0gcXRlc3RfaW5pdCgiLU0gcTM1IC1kZXZpY2UgaW50ZWwtaW9tbXUseC1zY2FsYWJsZS1tb2Rl
PW9uLHgtZmx0cz1vbiIpOw0KPj4gKyAgICBzID0gcXRlc3RfaW5pdCgiLU0gcTM1IC1kZXZpY2Ug
aW50ZWwtaW9tbXUsc2NhbGFibGUtbW9kZT1vbixmbHRzPW9uIik7DQo+Pg0KPj4gICAgICBjYXAg
PSB2dGRfcmVnX3JlYWRxKHMsIERNQVJfQ0FQX1JFRyk7DQo+PiAgICAgIGdfYXNzZXJ0KChjYXAg
JiBDQVBfU1RBR0VfMV9GSVhFRDEpID09IENBUF9TVEFHRV8xX0ZJWEVEMSk7DQo+PiAtLQ0KPj4g
Mi40Ny4zDQo+Pg0KPg0KPldpdGggcmVnYXJkcywNCj5EYW5pZWwNCj4tLQ0KPnw6IGh0dHBzOi8v
YmVycmFuZ2UuY29tICAgICAgIH5+ICAgICAgICBodHRwczovL2hhY2h5ZGVybS5pby9AYmVycmFu
Z2UgOnwNCj58OiBodHRwczovL2xpYnZpcnQub3JnICAgICAgICAgIH5+ICAgICAgICAgIGh0dHBz
Oi8vZW50YW5nbGUtcGhvdG8ub3JnIDp8DQo+fDogaHR0cHM6Ly9waXhlbGZlZC5hcnQvYmVycmFu
Z2UgICB+fiAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJhbmdlLmNvbSA6fA0KDQo=

