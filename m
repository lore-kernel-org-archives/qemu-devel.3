Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24CBCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 16:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsPu3-0002Rv-AI; Thu, 04 Apr 2024 12:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsPu1-0002Qg-Ne
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:25:25 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsPty-00069r-NG
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 12:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712247923; x=1743783923;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G46pofK+y2DaYRLOyQ7j28NSTmyKrbx4hCJOYdhVBpM=;
 b=gUrN7QXlO+3U5DeFBjBAOcFDK1EQJya2kzwfQOJeYoM30ww8Pqc6cvNw
 248bbgnUrYTPLLHOHKym3sJjyUHkGHSKTAe6s4AWUJiEWYKA2z7SNMaX2
 dYb2MDaGiV3JS/dAjv/VOLHLl0Fval+g0aBp5ahCUzDFAYUKYbgkIMVno
 ZKNPft12ma3OTAPHIxNvt9sdSOL79OFhN3TEd2VGRuiRSUEkppswgTBhH
 n+5rtA38pxUeP5JWTFtOgXdTqISS5YApj1d/jnG1uxbnnsgmc9VW+tq5x
 WDWSUaW8aJYYf1MPB61TvD8+cVXg7aJiTaoNaAG0uO6extzNPYbvYK6Q5 Q==;
X-CSE-ConnectionGUID: W3kjhipZSralfLi0K4XwRQ==
X-CSE-MsgGUID: M2KpMjXoTyijW7ADBfOcjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18281648"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="18281648"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 09:25:19 -0700
X-CSE-ConnectionGUID: OxeSITyhRVGL6f7cws5YTQ==
X-CSE-MsgGUID: pbMbT0m6TsOMMgh56BXC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; d="scan'208";a="18942704"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Apr 2024 09:25:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 09:25:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 09:25:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 09:25:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 09:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQaTxiL+vcfzs3IqVnrPoPlpJq/kU1wXPqnvY3PFWlOsEFYdV54WIHvS8YAvun+nXcphPm3u2rPgifnMawKsuWrk2whXSaUEeVVSPICyLQuieHjIGc4+gXvQWJltZMUZhjLETMXTzzsHxEImCVhBvK3nZDsG3fEmp/uVIGyqpAZzzhnuPxyUfTTwHiPHIeFwW9ToqJNr8chYRUGWjkN1bufYV8MmuBcxsECvJcIKbrf7BuDB34uunaZKKZMQN/KJk22PD6W5W9PmMnlcyFAIletb/HAVVwFtiE1VyC1XZVMfOrAiWnX8Im6avt6cwG6WxyPF2e9PloP3J49+Q/4vwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G46pofK+y2DaYRLOyQ7j28NSTmyKrbx4hCJOYdhVBpM=;
 b=NGHuVa+77PRe16TT7iXZaJE1mQdN6F+ekT8eRyWZghSF9OCK2xz6FA3ZeZQO+W5d2t3bPmPMKGRWUM9SXz98TDhJjdW+xawyQTp1XfMLcWgFl8huSP7u6wzySFO9RsqHo3FcVn8mdwHKyXQyGemutPWw3Cz6Gz35T6QX+HlJzrlwxkqxGa1Zlkc25uPUbQYOHYX9+wt/cRZWtaQXbkr/yUds2LW86Z/pVgcyOiXhuwRX3WDRJDIqrqUmiz5g32pBspZLB+uM49a+pNpaHcTl3WUZYgHI/+y09AMGZycS4Oz4fZAzXCiLpWlUv19QuCjFlQa+UmNTnyDkZ3I6qQin1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 CH3PR11MB8239.namprd11.prod.outlook.com (2603:10b6:610:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 4 Apr
 2024 16:25:13 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 16:25:13 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "Wang, Lei4" <lei4.wang@intel.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Topic: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Index: AQHahne59xUzBSmQ9kKgviWy8nsalrFYJxAAgAAU2RA=
Date: Thu, 4 Apr 2024 16:25:13 +0000
Message-ID: <DS0PR11MB6373FB3A707271E6E158258ADC3C2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240404100550.17777-1-wei.w.wang@intel.com>
 <Zg61FnuPPAYAJs45@x1n>
In-Reply-To: <Zg61FnuPPAYAJs45@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|CH3PR11MB8239:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yj4lLaG49/mB3BOo28LuRF5b4HixRCxRr1QF6po27NT2dqBI7bpMrpkuUVxASFmFXtqBuvFXolTAmBcMzUd6/Lra5n/Vz6vhjOwBpDODG52UfFMWBg53zvrMzSQ7tnqCjNugcTqNvZsLmBOAkG1qnWUqdpp2hJe6uEVgjXalMMPeJVJFUTy2xbm8hx9bNUp21QspU0LAEqLBzG2Tsx744IhGJWB5yhLUW766dD9TXtxkP0NpkZPpkJTleVd3MnVye1oz5YFD06S9TI1BPUIIvGxMJm6UHcknr2cdyxi+IZtFIqb0VRnmEI1oYhSTmwIJBLf4pqPPPjuB/rCLyOArg6HzPumFLiguHnal8m7GWvypsVX1dNNUKsXj8p15xyMVm2pisnarWt6fjx3JnXe7hH16NjHxv6T+AW+Hy+RSzFbW8y4Ro4WI0E8Da9VsF+ioMGXSRfilA9pn+xcQx9LOHVvdSfjpyG7jnCgy64wwIea1q4kt1f7BMgRoSaPbGalIQtIJKFYrqjXADSlkIg6/48xW/e7LRJcbDaHrMkDwkFq8wUw4DtYHDp/ToC5FO1XLmc9mboLDUVwkm/f2DZbQEaiw+izQVfeSgKnZJMyEiHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1hJbTAwc3ZsMktRQ3NFYWQ3MUZtZmhaRjFvUWNhMHZBMTdqQnRBeXhpRU1u?=
 =?utf-8?B?NlRoNEtpajFSWEFLOS9jeWJlYXpxYmtMVmlJa0ExWklhQ0Y4QS8zcHlIQnY0?=
 =?utf-8?B?Q2pIMklwbWF6dk01NzA3RkdQbGwraVAyclRvSXo4VHovZXhkN2pCemhzWUpq?=
 =?utf-8?B?ckdTQXpGVnA4a1V1RjMxbDdPSGhSVnpyNFZncVJnZjZJU3duNEhqKzZhbFo2?=
 =?utf-8?B?L3ZMbXpjcEo5WFVOVGtQQTkxZ01aY2FDc1Zhdm0xRWVISWFFOXFZL0EvUVhv?=
 =?utf-8?B?SFVITUc4UHhsbDF0MkVqa3k0NkZzTEdiN1AzcmVDcDVRNDhUTmkrNDBvYlla?=
 =?utf-8?B?ZkoraUhCdlpBUXJnN2h1dWZaVDRKZEVxdUNaWW9ZYWdHQUhaVzBIUVpMbmFp?=
 =?utf-8?B?MGtQc3ZvR3B4c3c0bU5QSzJmaEJuRXhIa2s2OWxoUUhVVm5JQXQyd01IY21n?=
 =?utf-8?B?eHc5NTVmamJ6Q0VPQUd1TmJ0QmJua3lEVExzMERjWGNLbEo2eDNGaC9wSWNH?=
 =?utf-8?B?aGxoZVd3QTBqSC9PL1dBOWxaMVhsMHBUczU0Kys1a0hJeCtza2NkT1BvRERa?=
 =?utf-8?B?ajhYQWdBN3ZnVGxDOWdZOGdpUE5NdGRrbEpTZGcyMmd5RnlhNnlXTVJ6eWVj?=
 =?utf-8?B?NFh2ZElibEE5cHdXTENJNjY3U05BekgvWkp4em9ScWNLVzk2TlBJbThPN2g1?=
 =?utf-8?B?ck1vV2RRUFo2NEFWSGV0aUpjRk5tNW9GTHd2Y0o1NkxHZWRmMXdWZDJSVita?=
 =?utf-8?B?cTQ3NWVXb3dtUzRLdktubGVDMWJsMEVNNnlaYXVaZVNYeEZpVHdEcncyakdi?=
 =?utf-8?B?dnFLRUlwNEFhRDFNNnZadmFWdlo3YjhQZkl6U2lvTGhTTXlYczZudEtWWUE0?=
 =?utf-8?B?cEw2eTdxK2lOdXZ5cU9EQzlDaHJxNTYwSC9vVHhmZUFjWTBsK1U0TkpLakxv?=
 =?utf-8?B?TnJQWVo5ZTZoRXNwRTFrc1dWS2lYQnAza3NPbTFjQTRZckljWjROb0NOc05j?=
 =?utf-8?B?RWxDMGJlTktxWXdNcFRRbGZSTWhvSG12VU5iRHVTRUV6d3gyNWtLdGNqZm5m?=
 =?utf-8?B?c014cnliZ2NTUW95MUg1UVJIbE9kZWN4Y25iMGFjaGgzMHduVHRvTU84eTNa?=
 =?utf-8?B?ZmVrbUVpbXU0WElTMUI0WGtaWWlsZ3JmamoyWUdzdTg0ZWUxNkovTDF5K0Fw?=
 =?utf-8?B?WG42c2s3c3NxNHRiMnJ3V2RlQkxjT2w2QitHekdQclZpNmhhR0VEdmdRK3E3?=
 =?utf-8?B?QkYxV1BXaEphanBCVlh2QmMvblkvVVB1TjhiM1U3SWx4MVZNRlMxRGtKcTZG?=
 =?utf-8?B?UVp3b25OSjZJdE5pVWxaaWZCVHArRWpsL1YrVVhUUXRDV00wSklrQXVEYVhW?=
 =?utf-8?B?RGV1YXFzU3BzREMrOHhZWXorS1pPeHMzcmthWjJoUFliRCtJOEk5eFFHdWoz?=
 =?utf-8?B?K0VFcFZhQmFVNkNTSzcvblhFMDFJTXZmSU9Tb2pPNlZKaEZzeER0S0Vrb0JM?=
 =?utf-8?B?dUIrUHZNRElJbmJBNlB3ZWh2L2lobWtzb0ZVa3U4NitJMEE1aGZiYnI3ajR5?=
 =?utf-8?B?RzFCSVFBSTdYWUdNdzVtWGdmVU1mV3luL21aVHZKZlBHSnFvREVXc2g1OGNF?=
 =?utf-8?B?U25DN0NLei9rVGNOSkVuVFMyOFdKSDRGUXhMUG1mcVpZekhEZnh0TjlUVDFw?=
 =?utf-8?B?eHVJTU51ZkRuL3VwS2ZvanBBRWR6WGJYVDRlME03SkdPN3oyWU12cC9qTENy?=
 =?utf-8?B?SWdYTER0TkVBUnhYRWYwMnRRRDZKSGxWT1JpUkdwZnVOaVZKVXpQajNhVUo0?=
 =?utf-8?B?K2ltMTVCdVR0VTVzT3F5TVhNRFJrSnNiV3V1TnV4Q1M5U2gwZFErc1l0dDU5?=
 =?utf-8?B?TGtCNERCOGFPdmI3blR6T2lmZHRQZXRLR0VmOHI2RElSM1hCNWpxdDkxY0Nw?=
 =?utf-8?B?NTM2RzhzVnVrL0YyYkVlRllnUE5rV2JqRmRaWFlybHhQUmZWTU9rWlZJZGdB?=
 =?utf-8?B?MEZwLzBndGs4dzliczMxTDV6SG5qdlZPRU53c2JzbDlQVHNlb2k3YUlwaWhE?=
 =?utf-8?B?RHFsU1cxczJzdVZNRVZ5cjJYRlNZTkpZVU1FZUlSYWUxbmFGQnZ5OSszOHFB?=
 =?utf-8?Q?UjNVQCTpO+dUzuwlFfsMgfePQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ab510-59e2-405a-ca35-08dc54c3ce28
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 16:25:13.3771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4X/+9abwYz2Jzf5+cfO+o8lOgbkqVHSKidSG8LAKsBSpUtgVlv7sFgj8ODT2iBYRzU4OtCK/UFbtKxkDwbDD/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8239
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=wei.w.wang@intel.com;
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

T24gVGh1cnNkYXksIEFwcmlsIDQsIDIwMjQgMTA6MTIgUE0sIFBldGVyIFh1IHdyb3RlOg0KPiBP
biBUaHUsIEFwciAwNCwgMjAyNCBhdCAwNjowNTo1MFBNICswODAwLCBXZWkgV2FuZyB3cm90ZToN
Cj4gPiBCZWZvcmUgbG9hZGluZyB0aGUgZ3Vlc3Qgc3RhdGVzLCBlbnN1cmUgdGhhdCB0aGUgcHJl
ZW1wdCBjaGFubmVsIGhhcw0KPiA+IGJlZW4gcmVhZHkgdG8gdXNlLCBhcyBzb21lIG9mIHRoZSBz
dGF0ZXMgKGUuZy4gdmlhIHZpcnRpb19sb2FkKSBtaWdodA0KPiA+IHRyaWdnZXIgcGFnZSBmYXVs
dHMgdGhhdCB3aWxsIGJlIGhhbmRsZWQgdGhyb3VnaCB0aGUgcHJlZW1wdCBjaGFubmVsLg0KPiA+
IFNvIHlpZWxkIHRvIHRoZSBtYWluIHRocmVhZCBpbiB0aGUgY2FzZSB0aGF0IHRoZSBjaGFubmVs
IGNyZWF0ZSBldmVudA0KPiA+IGhhcyBiZWVuIGRpc3BhdGNoZWQuDQo+ID4NCj4gPiBPcmlnaW5h
bGx5LWJ5OiBMZWkgV2FuZyA8bGVpNC53YW5nQGludGVsLmNvbT4NCj4gPiBMaW5rOg0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC85YWE1ZDFiZS03ODAxLTQwZGQtODNmZC1mN2UwNDFj
ZWQyNDlAaW50ZWwNCj4gPiAuY29tL1QvDQo+ID4gU3VnZ2VzdGVkLWJ5OiBQZXRlciBYdSA8cGV0
ZXJ4QHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGVpIFdhbmcgPGxlaTQud2FuZ0Bp
bnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIFdhbmcgPHdlaS53LndhbmdAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBtaWdyYXRpb24vc2F2ZXZtLmMgfCAxNyArKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL21pZ3JhdGlvbi9zYXZldm0uYyBiL21pZ3JhdGlvbi9zYXZldm0uYyBpbmRleA0K
PiA+IDM4OGQ3YWY3Y2QuLmZiYzlmMmJkZDQgMTAwNjQ0DQo+ID4gLS0tIGEvbWlncmF0aW9uL3Nh
dmV2bS5jDQo+ID4gKysrIGIvbWlncmF0aW9uL3NhdmV2bS5jDQo+ID4gQEAgLTIzNDIsNiArMjM0
MiwyMyBAQCBzdGF0aWMgaW50DQo+ID4gbG9hZHZtX2hhbmRsZV9jbWRfcGFja2FnZWQoTWlncmF0
aW9uSW5jb21pbmdTdGF0ZSAqbWlzKQ0KPiA+DQo+ID4gICAgICBRRU1VRmlsZSAqcGFja2YgPSBx
ZW11X2ZpbGVfbmV3X2lucHV0KFFJT19DSEFOTkVMKGJpb2MpKTsNCj4gPg0KPiA+ICsgICAgLyoN
Cj4gPiArICAgICAqIEJlZm9yZSBsb2FkaW5nIHRoZSBndWVzdCBzdGF0ZXMsIGVuc3VyZSB0aGF0
IHRoZSBwcmVlbXB0IGNoYW5uZWwgaGFzDQo+ID4gKyAgICAgKiBiZWVuIHJlYWR5IHRvIHVzZSwg
YXMgc29tZSBvZiB0aGUgc3RhdGVzIChlLmcuIHZpYSB2aXJ0aW9fbG9hZCkgbWlnaHQNCj4gPiAr
ICAgICAqIHRyaWdnZXIgcGFnZSBmYXVsdHMgdGhhdCB3aWxsIGJlIGhhbmRsZWQgdGhyb3VnaCB0
aGUgcHJlZW1wdCBjaGFubmVsLg0KPiA+ICsgICAgICogU28geWllbGQgdG8gdGhlIG1haW4gdGhy
ZWFkIGluIHRoZSBjYXNlIHRoYXQgdGhlIGNoYW5uZWwgY3JlYXRlIGV2ZW50DQo+ID4gKyAgICAg
KiBoYXMgYmVlbiBkaXNwYXRjaGVkLg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBkbyB7DQo+ID4g
KyAgICAgICAgaWYgKCFtaWdyYXRlX3Bvc3Rjb3B5X3ByZWVtcHQoKSB8fCAhcWVtdV9pbl9jb3Jv
dXRpbmUoKSB8fA0KPiA+ICsgICAgICAgICAgICBtaXMtPnBvc3Rjb3B5X3FlbXVmaWxlX2RzdCkg
ew0KPiA+ICsgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgIGFpb19jb19zY2hlZHVsZShxZW11X2dldF9jdXJyZW50X2Fpb19jb250ZXh0KCksDQo+
IHFlbXVfY29yb3V0aW5lX3NlbGYoKSk7DQo+ID4gKyAgICAgICAgcWVtdV9jb3JvdXRpbmVfeWll
bGQoKTsNCj4gPiArICAgIH0gd2hpbGUgKCFxZW11X3NlbV90aW1lZHdhaXQoJm1pcy0+cG9zdGNv
cHlfcWVtdWZpbGVfZHN0X2RvbmUsDQo+ID4gKyAxKSk7DQo+IA0KPiBJIHRoaW5rIHdlIG5lZWQg
cy8hLy8gaGVyZSwgc28gdGhlIHNhbWUgbWlzdGFrZSBJIG1hZGU/ICBJIHRoaW5rIHdlIG5lZWQg
dG8NCj4gcmV3b3JrIHRoZSByZXR2YWwgb2YgcWVtdV9zZW1fdGltZWR3YWl0KCkgYXQgc29tZSBw
b2ludCBsYXRlci4uDQoNCk5vLiBxZW11X3NlbV90aW1lZHdhaXQgcmV0dXJucyBmYWxzZSB3aGVu
IHRpbWVvdXQsIHdoaWNoIG1lYW5zIHNlbSBpc27igJl0IHBvc3RlZCB5ZXQuDQpTbyBpdCBuZWVk
cyB0byBnbyBiYWNrIHRvIHRoZSBsb29wLiAodGhlIHBhdGNoIHdhcyB0ZXN0ZWQpDQoNCj4gDQo+
IEJlc2lkZXMsIHRoaXMgcGF0Y2gga2VwdCB0aGUgc2VtX3dhaXQoKSBpbiBwb3N0Y29weV9wcmVl
bXB0X3RocmVhZCgpIHNvIGl0DQo+IHdpbGwgd2FpdCgpIG9uIHRoaXMgc2VtIGFnYWluLiAgSWYg
dGhpcyBxZW11X3NlbV90aW1lZHdhaXQoKSBhY2NpZGVudGFsbHkNCj4gY29uc3VtZWQgdGhlIHNl
bSBjb3VudCB0aGVuIEkgdGhpbmsgdGhlIG90aGVyIHRocmVhZCBjYW4gaGFuZyBmb3JldmVyPw0K
DQpJIGNhbiBnZXQgdGhlIGlzc3VlIHlvdSBtZW50aW9uZWQsIGFuZCBzZWVtcyBiZXR0ZXIgdG8g
YmUgcGxhY2VkIGJlZm9yZSB0aGUgY3JlYXRpb24gb2YNCnRoZSBwcmVlbXB0IHRocmVhZC4gVGhl
biB3ZSBwcm9iYWJseSBkb27igJl0IG5lZWQgdG8gd2FpdF9zZW0gaW4gdGhlIHByZWVtcHQgdGhy
ZWFkLCBhcyB0aGUNCmNoYW5uZWwgaXMgZ3VhcmFudGVlZCB0byBiZSByZWFkeSB3aGVuIGl0IHJ1
bnM/DQoNClVwZGF0ZSB3aWxsIGJlOg0KDQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3Bvc3Rjb3B5
LXJhbS5jIGIvbWlncmF0aW9uL3Bvc3Rjb3B5LXJhbS5jDQppbmRleCBlY2NmZjQ5OWNiLi41YTcw
Y2U0ZjIzIDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL3Bvc3Rjb3B5LXJhbS5jDQorKysgYi9taWdy
YXRpb24vcG9zdGNvcHktcmFtLmMNCkBAIC0xMjU0LDYgKzEyNTQsMTUgQEAgaW50IHBvc3Rjb3B5
X3JhbV9pbmNvbWluZ19zZXR1cChNaWdyYXRpb25JbmNvbWluZ1N0YXRlICptaXMpDQogICAgIH0N
Cg0KICAgICBpZiAobWlncmF0ZV9wb3N0Y29weV9wcmVlbXB0KCkpIHsNCisgICAgICAgIGRvIHsN
CisgICAgICAgICAgICBpZiAoIW1pZ3JhdGVfcG9zdGNvcHlfcHJlZW1wdCgpIHx8ICFxZW11X2lu
X2Nvcm91dGluZSgpIHx8DQorICAgICAgICAgICAgICAgIG1pcy0+cG9zdGNvcHlfcWVtdWZpbGVf
ZHN0KSB7DQorICAgICAgICAgICAgICAgIGJyZWFrOw0KKyAgICAgICAgICAgIH0NCisgICAgICAg
ICAgICBhaW9fY29fc2NoZWR1bGUocWVtdV9nZXRfY3VycmVudF9haW9fY29udGV4dCgpLCBxZW11
X2Nvcm91dGluZV9zZWxmKCkpOw0KKyAgICAgICAgICAgIHFlbXVfY29yb3V0aW5lX3lpZWxkKCk7
DQorICAgICAgICB9IHdoaWxlICghcWVtdV9zZW1fdGltZWR3YWl0KCZtaXMtPnBvc3Rjb3B5X3Fl
bXVmaWxlX2RzdF9kb25lLCAxKSk7DQorDQogICAgICAgICAvKg0KICAgICAgICAgICogVGhpcyB0
aHJlYWQgbmVlZHMgdG8gYmUgY3JlYXRlZCBhZnRlciB0aGUgdGVtcCBwYWdlcyBiZWNhdXNlDQog
ICAgICAgICAgKiBpdCdsbCBmZXRjaCBSQU1fQ0hBTk5FTF9QT1NUQ09QWSBQb3N0Y29weVRtcFBh
Z2UgaW1tZWRpYXRlbHkuDQpAQCAtMTc0MywxMiArMTc1Miw2IEBAIHZvaWQgKnBvc3Rjb3B5X3By
ZWVtcHRfdGhyZWFkKHZvaWQgKm9wYXF1ZSkNCg0KICAgICBxZW11X3NlbV9wb3N0KCZtaXMtPnRo
cmVhZF9zeW5jX3NlbSk7DQoNCi0gICAgLyoNCi0gICAgICogVGhlIHByZWVtcHQgY2hhbm5lbCBp
cyBlc3RhYmxpc2hlZCBpbiBhc3luY2hyb25vdXMgd2F5LiAgV2FpdA0KLSAgICAgKiBmb3IgaXRz
IGNvbXBsZXRpb24uDQotICAgICAqLw0KLSAgICBxZW11X3NlbV93YWl0KCZtaXMtPnBvc3Rjb3B5
X3FlbXVmaWxlX2RzdF9kb25lKTsNCg0KDQoNCg0KDQoNCg0K

