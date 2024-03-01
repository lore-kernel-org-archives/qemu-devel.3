Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820D7C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 00:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfqPC-0006hH-A1; Thu, 29 Feb 2024 19:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rfqP8-0006ga-VJ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:05:35 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rfqP5-0002OP-Bw
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709251531; x=1740787531;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zo2rc959VH/trWZGjDknPoKp/CaqbM+3E2D/E8n7XRg=;
 b=nQiqLiMP1XN8VCz6cqkVUCmh2zSCG7jA7CQBgmNocHM6XgSVrnYnnWOp
 7TD1Vpy4D1UwVmge5rDcJGnSh5lUyyg81kLQKmlBv28/gt31UuzHUkfWZ
 JwnHVSAVaSJe3whYWAK93KgAij5r2ZgBWGsNuEMg/Ht2j/wDZqXTD3E5G
 Cr0WJ/8gScaHC+4kEkoiJKNLKb+ok7vJHl8uP3Ssmau8/ZBWY4q9JSpuF
 JU4aAI3l7nr0phUPmW3wHAb5r/YbRvW1LZ48Og28vTDHirJmqe8L1hVT4
 Nxqp8GDS4e7HIlQPCbI+ClkxmYODou4j9yWgWfNz5r/E7CVyeo8+dX/DH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3883597"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3883597"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 16:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7924728"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Feb 2024 16:05:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 16:05:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 16:05:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 16:05:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:05:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YztVyyre4T73W+s7CngziclxHNHocRrkEH3J/u2xRqzXAkypUMnvvpKSR09PD8LEKtZNa4yMbWxl2n2USNhBzeTHuw0fSlBpGgjDjqfVHCX6SwqxgBZbU4l14YTouuqfw3kWsa/DxeUTu2ou/3tNqBnThwqozg1tH3/Wc/6qhzXbAWWaPxXPomFlz+Nvz2l9wYBpstNkrMvy81vnKoXhWyL8KUv4VU3aWBekioR9IMnixGp1Px8wOSopX+7bRgOQbZVpUGgfbdwCUCqplr+j5DsRYrboxwn99jW46Gf106mQJ8KQxkyjW/aDsoZ85hCegITtMszNzqgHoMnMSkmtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo2rc959VH/trWZGjDknPoKp/CaqbM+3E2D/E8n7XRg=;
 b=eEaWMaNPgkfRjpfJqycddKCb12DF4x7i2NTu/ZMh71+PGxNwRUjJKMJyhpgNW3YlAmOiR3Ol29shp5yLDHpExvBoRkKH3szGbEEDcioBdCB1bcf0WfKWIAc2AfXcXaVjFs2ECZBdgQQzVSPZmuUKdo6gchbOtcHrh7SxoDMC4DGoUr6oJ8Sx5UgNq5EYokRyVoG6LmzoZELFuvrDP5Jx8skar8ogZfqLrQsXi2R05Ys0tSSAJEy3RF1BwrMKKA/VCKwnhI38pfi+cMjBUcqAQiZwXJaRvQgbtjbDkEgl3eC/2m49CITbVL+YXIFMe0eJkB24uLoDYNLmYfatJ81Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Fri, 1 Mar
 2024 00:05:18 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7362.013; Fri, 1 Mar 2024
 00:05:18 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/3] ui/gtk: introducing vc->visible
Thread-Topic: [PATCH 0/3] ui/gtk: introducing vc->visible
Thread-Index: AQHaVAOvhkQto5F1qE6VVrnPTRFP57EiL3xg
Date: Fri, 1 Mar 2024 00:05:18 +0000
Message-ID: <PH8PR11MB6879F0CB84091A8436C3B891FA5E2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
In-Reply-To: <20240130234840.53122-1-dongwon.kim@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SJ0PR11MB6576:EE_
x-ms-office365-filtering-correlation-id: 7a20fb0a-341b-4d98-e10e-08dc398347b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnSDxDfTT/05iCYdmhbhguowcKG24AhduIpbWA/SkVf9LAtwPCFdF0vX8qKVEo3XDxV0AchceRXmw2+d3FBoAPbrwsmTNL8wGmzk84h63dUIwxLZy+/ncBplilvSS7dEwvcEAKpbCfO6/O5pHos2FevlzFKbjOu7IkvJ1ASYDFj+g/X//1uww8Rp8vbER0ac4P+f3EUWev6zNwDv2fOo8mUF0vxqe+w2xBh1iDszGCps7Gh16jxpnnZmbgfGK2PA5lUKUCvkbvDUrHeW7X5/DpNgCO4zfq2DL0nBhMGGwL2UoMvIy9VSDqll34YLghYqrBRvaG8y47v+F/binp1HCzUfAP948a0crs1RXoGpBQtE4TjazbX2AMRGxTOdleYys4ExRY6ukmGifD2lSCBJN16SEa0y2QCEid5au7KjDBnhu07KE0p5qCWMGea/XkF4hji1YvBC62TBItgWCqC8kAjPsTU/ANHB9a2v0wli1UT7eqQSgli6apmJSP+KMPCjChXJ/ed5SemM7If2nLc91N5Og4cb9NujjKSK57ICjtopzzm48wWlzB8ybZOH1nbzPdWNsNrKyGYrglc9NuyodjAPmucMUxgNbX+zesj5JPwkm8KdeAJp9QzUm/TQ5lohxub/UaWMWmOcElEEzx/2RVsv+rA0YhIhOKRR29FRF0Lz2M/X/lYi9xgvlx0PBWE/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkFCTldPSE1tcnFUcWdkbDl2a09aWXRIRG1QOVYyeVVOMlc3ZGR3cTErbHU5?=
 =?utf-8?B?aU1pcjJmL1RaZEM2OGdnR2lFY3FWRVdZODdCMy9BWkY1VkZwNk9ZTGNKNGFU?=
 =?utf-8?B?K0U0VkxvcmppbzlrQUIwZmpxY09VRzdQbkw0cm9QMGVGbFJPZkFMTFpnMURy?=
 =?utf-8?B?SmhwUGtKQVkxUnpGRkRybjQ2OWR2L2RPMUswWnBUaVBMOXRHeDJaT0pma2xk?=
 =?utf-8?B?WitNR3dPMGpDY2ZKU2NtUURRa2NaNmZvYVE3QVBKdXRaSWR2MDJkalM4Q0NN?=
 =?utf-8?B?M29wdFIva2d2cm5EajV6MmxXc2d1WFQyRXB4Q1Fid0huVWFONEk1VmlEY0xE?=
 =?utf-8?B?c1pxRVFndFBZU0gwTlpWL2s3ekhZU2ZrbUkyTDVJZDFBcEZRcVB0dVROQkh6?=
 =?utf-8?B?L3RSVllHbUZ1Z3BxVnZTYkpPRlZBS1lTWW9jYVIvTUJXNDdKK2tybGVGZlBj?=
 =?utf-8?B?ZHpkQVljQVdpTE5xQ1RGOU9MR2F4SkVaQ0VTeCtjRk91RHZTME5YVXdlN0U4?=
 =?utf-8?B?VGI3S3lyVmpVMGs0YVMrZnUrS0ZhaHRDemdKdTZBMnNqK1gzS1Q0V2FUZFNj?=
 =?utf-8?B?RXlOc2VzMHlyRW4yYlVtSEYyTkFrQUVKUW41elFVTzduUHdqek5YbER3Vlht?=
 =?utf-8?B?QS9KQ1VIS2dxVnU0TkFoV1lBckd3c3NtcFlYN2VGK2U5bjRzUHFMOEFUd0V1?=
 =?utf-8?B?RVM4L0pORGxsZ2VvK1hRTUpwY25oSVp1QklZcWgxcnR2UFJnRFZ2VHhQV1RJ?=
 =?utf-8?B?bTlBRyt2R2N5NDh4MldzWVVLS1EySHkvaUprdXZOZ3ZaSS9ZZUtPU0tLVnF4?=
 =?utf-8?B?SlB2WWlycng0dTdlUExUWUY0aVQ4SHpNeHFodGo5SGZKZXVZV2ZreitTR3FM?=
 =?utf-8?B?emtXVlcwNk1UbXpnTWNiVUZzL1Z4dWl0RkpueW9ZT1U3dE1INE1IdHJUNHEz?=
 =?utf-8?B?ai9WRGZiK0FlYVBvZVNHVktVTWNyUStxWUNQdlhzSTdaUUpLVDNmS1puUjdO?=
 =?utf-8?B?dUNYMEV3Q2s1aTRrQlhuK2prVnU2dXVkTEJWdFh5bTFndFNjVmxDRFZGeWN0?=
 =?utf-8?B?Tmt2MkdMVm1aTi9KeXZ6YzhNZ2p2d29BOHA2QlRVUG1nbmRwV0Y3SEJkT3F6?=
 =?utf-8?B?R2tZaVcyZ1FsNndxVlFza0V2dk9QNFVXdTFQNEVybXNhTGZRR1V2cGMvS2tm?=
 =?utf-8?B?ejVkdXJZVGw4VXJNVExSR2NzeVZWMjY0OUpIWWZ5ZzFrNEM3WFcrYjNVZUZY?=
 =?utf-8?B?Wm9WZS96WnhQZ2llMndkejhMZFdHdUQwbThTTE51c3l0R3BYSGNLdUM3WjB0?=
 =?utf-8?B?Z0FuYXJMYTVZdmdLQzJNK0JVbEkyZS9nL0N3aUlrUEVlUGUxTStrU2F5a2xn?=
 =?utf-8?B?eGhYQm1vZGN5QWRWQjFJNnc1TTArdSs2UmU0VmgyNWpKU1dyYVpXSHcveWdM?=
 =?utf-8?B?UU00d2FZeHY5eit1SHVVTUgrYzQ5RjFuWGdmeWdhRGJiOVRqdG1BL25MMTQw?=
 =?utf-8?B?Z0thVEtabEhpZFRvYVVKZlRUd0lDMm1wczhUYUJ0emc3UVg4ZFBSUUczL2ZM?=
 =?utf-8?B?RjEvWVlGKzJzS0tkYWFuWWpSTlZ2alcwZk5hYjVBai9xaVFoc1FLU0tiZFFu?=
 =?utf-8?B?am1ya1dnazAvZE9WNHpleTlHWng3aVRIWXhBdlZFdjVIaE5COXZPMDQ3R3Mx?=
 =?utf-8?B?Z0dXUllCekRXaDcxQ3lrdGNodUFIaUNwQS9WTWUyS01vRG5YaThXakhBM2Ju?=
 =?utf-8?B?VVdNV1BvUWxSeE8xTzVsU25sODFsOStMZnBjbGtrK0loQXE1bTg5REFhejI4?=
 =?utf-8?B?VmV1Y2Z1b0kvVE9oa01MaFFQNEMza1djUFdXb2dPRVhveEdhK2lveGM5QWRY?=
 =?utf-8?B?KzArVHpJTU5HNVM3aUYxUklEQnUrZk5VWG11U1lMWHZ3UGZJVnpUZWlVUWx5?=
 =?utf-8?B?YUV2NW9ieXA1aVZKNzVleWFEOGVYYlBXcE1UVmFJQjM3L3BZNE1OMHBmK1ZR?=
 =?utf-8?B?Rys5c1doeVFHQ29leXFKZVZtNVY1SFEvdjRGcC8vdVI2ZjRBaXJIQmpCbER0?=
 =?utf-8?B?dGNhRkFBckZQa3phdXFlOU10QklVS2M1RE5FQlhYazMyTGFSdmR2eE0vOWVu?=
 =?utf-8?Q?WC183vHRMe7bQ2tjHRLrK5Q/i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a20fb0a-341b-4d98-e10e-08dc398347b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 00:05:18.6409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeJsO7hrV0TTzpxVX/xMsQ4hHdDw/tQgqjA2OOk1aUIw06UxRR753zfXfsqCjt/qg+/UxmhLBbpoGrOhq8dEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgTWFyYy1BbmRyw6kgTHVyZWF1LA0KDQpKdXN0IGEgcmVtaW5kZXIuLiBJIG5lZWQgeW91ciBo
ZWxwIHJldmlld2luZyB0aGlzIHBhdGNoIHNlcmllcy4gUGxlYXNlIHRha2UgYSBsb29rIGF0IG15
IG1lc3NhZ2VzIGF0DQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2
ZWwvMjAyNC0wMS9tc2cwNjYzNi5odG1sIGFuZA0KaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hp
dmUvaHRtbC9xZW11LWRldmVsLzIwMjQtMDEvbXNnMDY2MzcuaHRtbA0KDQpUaGFua3MhIQ0KRFcN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBxZW11LWRldmVsLWJvdW5j
ZXMrZG9uZ3dvbi5raW09aW50ZWwuY29tQG5vbmdudS5vcmcgPHFlbXUtDQo+IGRldmVsLWJvdW5j
ZXMrZG9uZ3dvbi5raW09aW50ZWwuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZg0KPiBkb25n
d29uLmtpbUBpbnRlbC5jb20NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAzMCwgMjAyNCAzOjQ5
IFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogW1BBVENIIDAvM10g
dWkvZ3RrOiBpbnRyb2R1Y2luZyB2Yy0+dmlzaWJsZQ0KPiANCj4gRnJvbTogRG9uZ3dvbiBLaW0g
PGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gDQo+IERyYXdpbmcgZ3Vlc3QgZGlzcGxheSBmcmFt
ZXMgY2FuJ3QgYmUgY29tcGxldGVkIHdoaWxlIHRoZSBWQyBpcyBub3QgaW4gdmlzaWJsZQ0KPiBz
dGF0ZSwgd2hpY2ggY291bGQgcmVzdWx0IGluIHRpbWVvdXQgaW4gYm90aCB0aGUgaG9zdCBhbmQg
dGhlIGd1ZXN0IGVzcGVjaWFsbHkNCj4gd2hlbiB1c2luZyBibG9iIHNjYW5vdXQuIFRoZXJlZm9y
ZSBpdCBpcyBuZWVkZWQgdG8gdXBkYXRlIGFuZCB0cmFjayB0aGUgdmlzaWJsaXR5DQo+IHN0YXR1
cyBvZiB0aGUgVkMgYW5kIHVuYmxvY2sgdGhlIHBpcGVsaW5lIGluIGNhc2Ugd2hlbiBWQyBiZWNv
bWVzIGludmlzaWJsZSAoZS5nLg0KPiB3aW5kb3dzIG1pbmltaXphdGlvbiwgc3dpdGNoaW5nIGFt
b25nIHRhYnMpIHdoaWxlIHByb2Nlc3NpbmcgYSBndWVzdCBmcmFtZS4NCj4gDQo+IEZpcnN0IHBh
dGNoICgwMDAxLXVpLWd0ay1za2lwLi4uKSBpcyBpbnRyb2R1Y2luZyBhIGZsYWcgJ3Zpc2libGUn
IHRvIFZpcnR1YWxDb25zb2xlDQo+IHN0cnVjdCB0aGVuIHNldCBpdCBvbmx5IGlmIHRoZSBWQyBh
bmQgaXRzIHdpbmRvdyBpcyB2aXNpYmxlLg0KPiANCj4gU2Vjb25kIHBhdGNoICgwMDAyLXVpLWd0
ay1zZXQtLi4uKSBzZXRzIHRoZSB1aSBzaXplIHRvIDAgd2hlbiBWQyBpcyBpbnZpc2libGUgd2hl
bg0KPiB0aGUgdGFiIGlzIGNsb3NlZCBvciBkZWFjdGl2YXRlZC4gVGhpcyBub3RpZmllcyB0aGUg
Z3Vlc3QgdGhhdCB0aGUgYXNzb2NpYXRlZCBndWVzdA0KPiBkaXNwbGF5IGlzIG5vdCBhY3RpdmUg
YW55bW9yZS4NCj4gDQo+IFRoaXJkIHBhdGNoICgwMDAzLXVpLWd0ay1yZXNldC12aXNpYmxlLi4u
KSBhZGRzIGEgY2FsbGJhY2sgZm9yIEdUSyB3aW5kb3ctc3RhdGUtDQo+IGV2ZW50LiBUaGUgZmxh
ZywgJ3Zpc2libGUnIGlzIHVwZGF0ZWQgYmFzZWQgb24gdGhlIG1pbml6YXRpb24gc3RhdHVzIG9m
IHRoZSB3aW5kb3cuDQo+IA0KPiBEb25nd29uIEtpbSAoMyk6DQo+ICAgdWkvZ3RrOiBza2lwIGRy
YXdpbmcgZ3Vlc3Qgc2Nhbm91dCB3aGVuIGFzc29jaWF0ZWQgVkMgaXMgaW52aXNpYmxlDQo+ICAg
dWkvZ3RrOiBzZXQgdGhlIHVpIHNpemUgdG8gMCB3aGVuIGludmlzaWJsZQ0KPiAgIHVpL2d0azog
cmVzZXQgdmlzaWJsZSBmbGFnIHdoZW4gd2luZG93IGlzIG1pbmltaXplZA0KPiANCj4gIGluY2x1
ZGUvdWkvZ3RrLmggfCAgMSArDQo+ICB1aS9ndGstZWdsLmMgICAgIHwgIDggKysrKysrKw0KPiAg
dWkvZ3RrLWdsLWFyZWEuYyB8ICA4ICsrKysrKysNCj4gIHVpL2d0ay5jICAgICAgICAgfCA2MiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIDQgZmls
ZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+
IDIuMzQuMQ0KPiANCg0K

