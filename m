Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA91CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 16:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs377-0000ur-3W; Wed, 03 Apr 2024 12:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rs373-0000uQ-Ti
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:05:22 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rs370-0001Sg-Qe
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712160318; x=1743696318;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5JR/NLsG++fuYiG9kyPxrJDY0skWi4r9yVdfM/GfBgI=;
 b=gcsAhXNBSYwhWLMZjQCoX8rKwy/NXlPDsuAzNaWosfARGKmIbcABuLMp
 yFEWqrm/Ljl7HBPQAhDOdw2Xx/BOEfAf9NCC07uK2DvC5IOo50q2vE2Gk
 It+/G2kCtzKbSbFVg/28eWbPIJCOfFQHzyCwGbRr6J1dmBbjSfW0a435S
 rtqSne7b3EFbLHXUop8B8nvxeOf4GoXSF3SKuTPNRW5r+jIhPavZffEab
 xTRhSCyJ0ksNjcgHyFp7DHPsbzY9U6i3iUtRgb/uS3bnvucGACgeOB6Np
 +6AIktCqQ9BbAvXcoyeytoUwK5PNjnJs7LuMx+0K18YkAlwdkPsybov/V g==;
X-CSE-ConnectionGUID: X1INQr+qTpiS04Id2ILarQ==
X-CSE-MsgGUID: /ZUqkd1tTZK0S6OaarunpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="10372717"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="10372717"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 09:04:25 -0700
X-CSE-ConnectionGUID: +Pdu03+8QUiU7lUys6kzhg==
X-CSE-MsgGUID: IhUgQPjjTamt4jt9lHTySA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="18455480"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Apr 2024 09:04:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 09:04:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 09:04:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 09:04:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 09:04:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdU5H1OndVbVVqc9Dl7dCcokWD8pSaoSzFoYYTC4LNN1SMb67g2Gk4z6PYxxVNxxXcXfJq5wIGOBLTQv98cnEPLDmdsqm7dZ3w8ir0jyUFqusYf2gP8oa+haijiPQWf1C37NZ4XqWly5hyt+Hw89ETO4972oeuQsK9slVx+XTMjFc+IvBRA1q99zgAoT+MGA3qs8x/NySLTHNykOx+DnQ8dd68DbC8nANdYVgMFWheJNtE31QGlNq4ynfnPTxCLsL2udjL62X9oB+ktWj6Kd86+iEqQsWCXEJIQDODE2CmyHawvM3cKgVIh6pZT3Qczv+e7chFooNv+TVSgbInFQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JR/NLsG++fuYiG9kyPxrJDY0skWi4r9yVdfM/GfBgI=;
 b=DPVPpyoDwh1MhbsCXzPlnQoXTmG7Q5NfSae7h0ToL8NixHhURwX0wYuv8vpz/D1WvtoNHhbAISGT7/QH9XnHWEDPuCdIwxYaep/v6i+yOC+AJZM9FX0IB/tBVuzsyQKTrC6zWDhBOgWVM2z2Pftqb/kGx3DCD2iAFJFkuyhrWuChQQJSq2EYjpp/tWLBB0k6ZaVfENc3UJhXrDUwzYW9YQoiKLMJkm0XuUI/x6yEWoO66tIhkn6Je34h3DQKFLIfVu/5WAeQl8zTUidqZe+gnM/4MpK97Om+Jq0F+pxn0OPHGTseiAUaZadDHvVYbKEYpxSVl2xRHfY44GXvfgnQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Wed, 3 Apr
 2024 16:04:22 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 16:04:21 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>, "Wang, Lei4" <lei4.wang@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>
Subject: RE: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Topic: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Index: AQHagYmyxUL+r+eN+kO1eb/5c5VPirFOUHtQgAVLeACAAPZ+AIAAA0oggAAneACAAMwvAIAAt1WAgABmdACAABJ1kA==
Date: Wed, 3 Apr 2024 16:04:21 +0000
Message-ID: <DS0PR11MB637346AE0C9777A6C25746CFDC3D2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n> <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
 <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com> <Zgx7DI4LXYrR_dk-@x1n>
 <c0607330-60af-4e0f-819e-4a22a38edd6d@intel.com> <Zg1qyEJZH8kScSng@x1n>
In-Reply-To: <Zg1qyEJZH8kScSng@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SN7PR11MB6680:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTt+zeLKSgyJtWeWHaGLDQdGXeMES73GURuUEeu3fshYxqsAiNWmy2tWVZhMcqe9KDVkk+//CCucInlGgBwKzvyz+2briYUOPkgifPNtzybLSaNDZDfzmefY91RsC+gZVYP/2+X/K570pm3MWoj40SbYuL0zvwc7uj1uV0WSaPOjKk33TApyoBitEl1HYGNbYeYnrMdRFk0bSJHpp0JuQPi0KhJCU3Y2QsnmeHfefpNVQi+kekP3c/ISyylj8v3cGc+RcxXY5FVkZL0ozFq8deE5GCK9PlRl7BJNu+Il6qpMLIowR2807+aoucpXdlUafXbQQoXLeVSqMC+0ZorF8wQvYRevRj5gNhg4sW8zlbP+dljw16qDKxVVsvbJAcQ2XLZY8JnLRZKWsA1Q66ldwSRM5oYv0+ZY58/R0ImEh4LGDJPIrQQsMjcnPI7re6k/zSd+T1C3fP1e69FNI3p/GQrd1Dc9gIjfihyqEAQ6rVuqnl6ma8d3J1hm5MNyWi98VZpg4peZBOsH1iUQw4Ew2C+U/517jxMUg7O6jOkW0Br1qpc5BjU8zViwWIBc8e6ZsyIB1GgDIZMCkyZHTMXnjvmceKp/mZ2pdtuTHsNzxPVwZab2nz86G2CpUP7ciuQEe6KY0rUzDg/TvwN9ooXVCx9IoDtgNFNlnyyjZ7uXQ9w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZZbTBRblIvZmszdEJiSFVsOThlZHpsY01RWUFMcnozT1dGREdMZlBhRitu?=
 =?utf-8?B?TzFsMnRWTWZQcUNRK3E4SlZBaUIvZStHWXkyTS96QWdBNEpGRFlFWWJoTWQ4?=
 =?utf-8?B?WmFMTG5TbjRBcWsxZ09iVlE3VkpRUkJRNkx6K2I4MVU1WWlDNmgyM09ZTFM2?=
 =?utf-8?B?R2dEVmVjbVhyRGdJb2hBRFJMYzdnQ1A3eEU5VXAwVkRvejY0em1mLzdFVmJK?=
 =?utf-8?B?OHhpazd6SXpwMlhoQ1Awbm9mVzBOQ1JRRXZJdnd2ZzFnc2tuSkQ5Y0Jrd2Ja?=
 =?utf-8?B?MnhmME84bHNsM296ckFaaHNIRWFWenFsYnVUSGJsTWtVdUZwazQ2cHBjaVZw?=
 =?utf-8?B?UmQ5M3lvVXp4Yk1IYkhFWTl4M2ZJMnFBWDJWWXQ1UEJqbFVNeEd2dVZndXRZ?=
 =?utf-8?B?dDlVdmNmUTQydVlYNXFUbFU4Z2htVzVIQ1U5VllsbGZPR3ZaY20vLzlTa3Z3?=
 =?utf-8?B?N3VSNnIxOW9zU3VSaTZMcWtmK1Rub3hHLytORlV3Y0ZpcEp0Z2RjQjlXM3hV?=
 =?utf-8?B?ME0yam9aNGJEUlo1bHBESkVIVlFiRmUrelRUaEpSUTFrbHh2SkNsTWJqalRa?=
 =?utf-8?B?NThyZklFTWZHVllENytMcE90dHBFTmhOdXQrUmQ0ekwySDZZYXZ5RXZ3elY0?=
 =?utf-8?B?azZqQ1JiejBuRVJsVFI2SkNYSEozZUV1L0tWZXR5YWFRdWR4aUhQbnFsRm5h?=
 =?utf-8?B?aUt4aGhWVTJ3WDR4TEJlQi94c0RYRkFOQVIwRTNvOTFtZkJvemxyby9oQTJs?=
 =?utf-8?B?SHVkWG5oZUdsb1RMOVdFbnNrV0VibWJNVlRLMXQwWUI0NFlrN0FDeHpwRVcv?=
 =?utf-8?B?bkt1djA4MEJjRE5wT0h5aFRxVUlPcHBScmdwUFF6NEQzcjN4NG1zdTVjdFdL?=
 =?utf-8?B?aXBWMEFoeHVuQm1zcHoxb0txK0JEdTQ1bnJsWFhlNjdtYWhxcjBGYlZKZE95?=
 =?utf-8?B?WGhZQTVYanBqVmd5NFpDZzZITEtZMEVsWi9VT0JleDBKUllrR0RDZ2R3VURq?=
 =?utf-8?B?K3I4bm5xSHZWMVhzUnlpenc1cjMvQ0dFdnEybk9PTjlOL1pyeU12VzNpUXUv?=
 =?utf-8?B?djJPb2FuMlh3OTdYUW1UMkZuZHl4Qk02aEd0NmVkdGo1RFoyL29weXpITUw2?=
 =?utf-8?B?RVBuN1piWDhMUlJhVE92T09mT2c0MUEza0VuaGZ1cFR6NHRORFIrNko1MVNt?=
 =?utf-8?B?M0ppSElCc1JVZUdRcXc0T1hhZGZRTjV1QWRaZjRRblBZekcxVno5N3lJN09U?=
 =?utf-8?B?TjUxU2xybWdaeTVienE5R3F3dmFaeHpSZ2ZTcy95OTZqVHdqY0VCOXVrK0Rm?=
 =?utf-8?B?V2xRMHJUS2NPMEVmY2hQbXp3L252ajZCQlJ0YUVaV1lLV1BhR3A2MDVzbUhD?=
 =?utf-8?B?OFFZSVc2ZnptRzhLaTN2bGI1aGpueGNVR25mdFRaRjllWlN5eWtlaTJOdkk1?=
 =?utf-8?B?Ti9oamFPcXd2a0lJNWo4NmwvRThHUzVLd0l2YTVLd2UzTDVlWW9aMDUxU0RO?=
 =?utf-8?B?WFRCUXIvZTNNUGNtR1J5MTg2TTNrYis3RXFPdTdZTXNueWVKd2VmSVZPWVl5?=
 =?utf-8?B?OE9DekxNSmc4ZXQ4YlQ0Y0NHdkZvY0tNb3MzY1A3MVhjUDFXZmIyeWcrdG11?=
 =?utf-8?B?bmRhM1B2QWk0bStMNG5BUVNrRHBRQWFJZER3THpsd214N2phb1JtNFVaWjB4?=
 =?utf-8?B?NFppaXZUYnFrUXJ1Ym5rbUMvek5OemFQL3dMVmhJbXdIT1hDbHVaMkc4OVY1?=
 =?utf-8?B?UWxrZTdpeklWY1JiSDNIYzZzT2hHeERWR216L1RoT3kxMVlScDlrb2RIOUhI?=
 =?utf-8?B?Q1BUWmpxVmtSOXFTeUk1SGZWMWVNWFZHZ2dsUjgvTVRnVHBUM1dIeUF1K0dK?=
 =?utf-8?B?c01aOE9RVFVxcjJDcWhuRkNlK2VvQTI0ZDhnVUQ3VDd0L0ZaQ05TTHpDd2J1?=
 =?utf-8?B?OXlRM293bDkxMFhiT2gxSFNxTW1jWEdOVFhXZldmL1REd1V6Y1QwS0F3RGg2?=
 =?utf-8?B?cVR3NWZYK0NjTE5uQWNGdnNsdVFLb3Q2QXVSb0hZalI0aWNPZTQ4S3diUCtu?=
 =?utf-8?B?Mm5INnNPblFUdWRBdVhac3A3bVNqSmVFZ1lpR080L3JBRG56bFhKb29EeUEx?=
 =?utf-8?Q?VtLx1h2oE0HSMW9dBFtSpMu9X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ce78ae-86a5-4f70-3219-08dc53f7b9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 16:04:21.9009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 321aptjX5TmL4DOuNo/IoTWkEigRApFAJPkDZ/jXtUm67EBhAnxB7HU95TFHqoe0cX6xyJ4YnkgBtkYeHNCfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=wei.w.wang@intel.com;
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

T24gV2VkbmVzZGF5LCBBcHJpbCAzLCAyMDI0IDEwOjQyIFBNLCBQZXRlciBYdSB3cm90ZToNCj4g
T24gV2VkLCBBcHIgMDMsIDIwMjQgYXQgMDQ6MzU6MzVQTSArMDgwMCwgV2FuZywgTGVpIHdyb3Rl
Og0KPiA+IFdlIHNob3VsZCBjaGFuZ2UgdGhlIGZvbGxvd2luZyBsaW5lIGZyb20NCj4gPg0KPiA+
IAl3aGlsZSAoIXFlbXVfc2VtX3RpbWVkd2FpdCgmbWlzLT5wb3N0Y29weV9xZW11ZmlsZV9kc3Rf
ZG9uZSwNCj4gMTAwKSkgew0KPiA+DQo+ID4gdG8NCj4gPg0KPiA+IAl3aGlsZSAocWVtdV9zZW1f
dGltZWR3YWl0KCZtaXMtPnBvc3Rjb3B5X3FlbXVmaWxlX2RzdF9kb25lLA0KPiAxMDApKSB7DQo+
IA0KPiBTdHVwaWQgbWUuLiA6KCAgVGhhbmtzIGZvciBmaWd1cmluZyB0aGlzIG91dC4NCj4gDQo+
ID4NCj4gPiBBZnRlciB0aGF0IGZpeCwgdGVzdCBwYXNzZWQgYW5kIG5vIHNlZ2ZhdWx0Lg0KPiA+
DQo+ID4gR2l2ZW4gdGhhdCB0aGUgdGVzdCBzaG93cyBhIHlpZWxkIHRvIHRoZSBtYWluIGxvb3Ag
d29uJ3QgaW50cm9kdWNlDQo+ID4gbXVjaCBvdmVyaGVhZCAoPDFtcyksIGhvdyBhYm91dCBmaXJz
dCB5aWVsZCB1bmNvbmRpdGlvbmFsbHksIHRoZW4gd2UNCj4gPiBlbnRlciB0aGUgd2hpbGUgbG9v
cCB0byB3YWl0IGZvciBzZXZlcmFsIG1zIGFuZCB5aWVsZCBwZXJpb2RpY2FsbHk/DQo+IA0KPiBT
aG91bGRuJ3QgdGhlIGV4cGVjdGF0aW9uIGJlIHRoYXQgdGhpcyBzaG91bGQgcmV0dXJuIGltbWVk
aWF0ZWx5IHdpdGhvdXQgYQ0KPiB3YWl0PyAgV2UncmUgYWxyZWFkeSBwcm9jZXNzaW5nIExJU1RF
TiBjb21tYW5kLCBhbmQgb24gdGhlIHNvdXJjZSBhcyB5b3UNCj4gc2FpZCBpdCB3YXMgbXVjaCBh
ZnRlciB0aGUgY29ubmVjdCgpLiAgSXQgd29uJ3QgZ3VhcmFudGVlIHRoZSBvcmRlcmluZyBidXQg
SUlVQw0KPiB0aGUgbWFqb3JpdHkgc2hvdWxkIHN0aWxsIGhhdmUgYSBkaXJlY3QgaGl0Pw0KPiAN
Cj4gV2hhdCB3ZSBjYW4gZG8gdGhvdWdoIGlzIHJlZHVjaW5nIHRoZSAxMDBtcyB0aW1lb3V0IGlm
IHlvdSBzZWUgdGhhdCdzDQo+IHBlcmhhcHMgYSByaXNrIG9mIGhhdmluZyB0b28gbGFyZ2UgYSBk
b3dudGltZSB3aGVuIGJ5IGFjY2lkZW50LiAgV2UgY2FuIGV2ZW4NCj4gZG8gaXQgaW4gYSB0aWdo
dCBsb29wIGhlcmUgY29uc2lkZXJpbmcgZG93bnRpbWUgaXMgaW1wb3J0YW50LCBidXQgdG8gcHJv
dmlkZSBhbg0KPiBpbnRlcm1lZGlhdGUgZ3JvdW5kOiBob3cgYWJvdXQgMTAwbXMgLT4gMW1zIHBv
bGw/DQoNCldvdWxkIGl0IGJlIGJldHRlciB0byB1c2UgYnVzeSB3YWl0IGhlcmUsIGluc3RlYWQg
b2YgYmxvY2tpbmcgZm9yIGV2ZW4gMW1zIGhlcmU/DQpJdCdzIGxpa2VseSB0aGF0IHRoZSBwcmVl
bXB0IGNoYW5uZWwgaXMgd2FpdGluZyBmb3IgdGhlIG1haW4gdGhyZWFkIHRvIGRpc3BhdGNoIGZv
ciBhY2NlcHQoKSwNCmJ1dCB3ZSBhcmUgY2FsbGluZyBxZW11X3NlbV90aW1lZHdhaXQgaGVyZSB0
byBibG9jayB0aGUgbWFpbiB0aHJlYWQgZm9yIDEgbW9yZSBtcy4NCg0KDQo+IA0KPiBJZiB5b3Ug
YWdyZWUgKGFuZCBhbHNvIHRvIFdlaTsgcGxlYXNlIHJldmlldyB0aGlzIGFuZCBjb21tZW50IGlm
IHRoZXJlJ3MgYW55ISksDQo+IHdvdWxkIHlvdSB3cml0ZSB1cCB0aGUgY29tbWl0IGxvZywgZnVs
bHkgdGVzdCBpdCBpbiB3aGF0ZXZlciB3YXkgeW91IGNvdWxkLA0KPiBhbmQgcmVzZW5kIGFzIGEg
Zm9ybWFsIHBhdGNoIChwbGVhc2UgZG8gdGhpcyBiZWZvcmUgRnJpZGF5IGlmIHBvc3NpYmxlKT8g
IFlvdQ0KPiBjYW4ga2VlcCBhICJTdWdnZXN0ZWQtYnk6IiBmb3IgbWUuICBJIHdhbnQgdG8gcXVl
dWUgaXQgZm9yDQo+IHJjMyBpZiBpdCBjYW4gY2F0Y2ggaXQuIEl0IHNlZW1zIGltcG9ydGFudCBp
ZiBXZWkgY2FuIGFsd2F5cyByZXByb2R1Y2UgaXQuDQoNCk5vdCBzdXJlIGlmIExlaSB3b3VsZCBi
ZSBhYmxlIHRvIG9ubGluZSBhcyB0aGUgZm9sbG93aW5nIHR3byBkYXlzIGFyZSBDaGluZXNlIGhv
bGlkYXkuDQpJZiBub3QsIEkgY291bGQgaGVscCB0YWtlIG92ZXIgdG8gc2VuZCBsYXRlIHRvbW9y
cm93LiBMZXQncyBzZWUuDQo=

