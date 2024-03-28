Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13622C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 03:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpg3Z-00009d-Sn; Wed, 27 Mar 2024 23:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpg3Y-00009H-0O
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:03:56 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpg3V-0006xX-Ec
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711595034; x=1743131034;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j50kj2UaNLOuR9phSb9qDi7mcGE0X5SkQiPt28iawpU=;
 b=kqeLSaHTZ6B1OjVKuZe/F+7dlRJl6pzmEaNeW4K0/MS9Gw0Jpjzgx5oW
 UmkT/WJ3rwu3s0N3rQcQecAh1vqGle2G+BDjz4JSyr/eE8icTAZHt374u
 6VSWS2Lkz96jsMOp/oXeQpIEk1j+LgsDH2VzKO2V+SHigx8a7X8eD1Rzo
 XBqkPf9uRfzBNGRrAgKzW9TZJk/qdjufP0dmhIQYrsRzlfEJ9MvdiOA0Q
 IOQFtlfShhTuvTxUzYijYoG5hepgcRJ2u25d9O+AmV6k75kWI8CxcYvbX
 wcF3Pz1d239l2wNNy7hPVeiJ1H2fjrbAc4Znu+RshuV3ts46D2VB6zo0D A==;
X-CSE-ConnectionGUID: MWi36JVqR9a2zvkcNVlfqg==
X-CSE-MsgGUID: dWasnICFQCW4u5E+/uA74w==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="29210166"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="29210166"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 20:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="20973610"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2024 20:03:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 20:03:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 20:03:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 20:03:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+sBSCleqftDJRFsejLcnABO3uYyhNeqv91yYGxs7URVU6xwtvlQZ7/vZYazfO4yNBIv9Hf2wyd0RQQmcR9PKxKKMFEokGczsncimYaSgiy5AMF5bFSTGzYlDUnLWUiKs2Mykb1DSzvGq09CpL1+KdY2C3sgVCNoXWctIerPleu3yTpzvHQuozhgEuXe1A8vdsqvejrjsxSVRTlslL81iao3vBh8R2tl1s2zIqOnMKhekm3crhtwhprgiTUKM+M1SBErrCTPFAl+55TD+2gzgRzH9o3lt71BgfqblHGI33vRDhn5agX7TRqktf8+BFFYvDY5ETW4mYRlSlZEwcZAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j50kj2UaNLOuR9phSb9qDi7mcGE0X5SkQiPt28iawpU=;
 b=b7zZNihPoNNS+90Ybr0R9EmG2faeqRLSu5ZHEqY6G1CCeHKbjvx4OmLXhgRnomx9bvilDruZzx6/nry0swCUYiTSlF1pVCbo3H+bsH2GBGrWuecS+SLU/P7q884W+bwtY+6hzCTUI9MySFTgK7b3UgntSgw8EV6IH722fonr12+LocVY82BDC9gncRNzHB7ujT6S6XsR+G92ziuVw5i63FpVBC6cNxdLIMUGMNCQC1NofdBapLsLwnqL+fotyjBPeHAqYr7gaY+/UC29KflqMjY+3YB8SpAZvM/tWgXwqxaZmFPnf9DEdOFzQMVlrYB6QPq4m0uyR/wsWH7nRatewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:03:48 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Thu, 28 Mar 2024
 03:03:48 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 4/7] migration/multifd: add qpl compression method
Thread-Topic: [PATCH v5 4/7] migration/multifd: add qpl compression method
Thread-Index: AQHaeqFDspR2MYoaI0es4xdRAAVRwrFMCnwAgAB5B+A=
Date: Thu, 28 Mar 2024 03:03:48 +0000
Message-ID: <PH7PR11MB5941E83693AEB891DA018D13A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-5-yuan1.liu@intel.com> <ZgR4Rp7J9cCtLGGF@x1n>
In-Reply-To: <ZgR4Rp7J9cCtLGGF@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DM6PR11MB4658:EE_
x-ms-office365-filtering-correlation-id: 056ae6ed-663e-4cc8-30f1-08dc4ed3b035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+GrnpjfsCD6zeI8eb0wqfVo0zYB5L2yUGBYOoOT+UVreOFIpqeTmerXl2yWO1LaLYxbD3SLB1YKh+QHa79ypuRa2ad5hhHvfj9aW+9ZRDl2A6WUQlH5mbk36LtPDxEMQX4gnXnuTjbnnwdfLVH4IHZInpEWvxo5anM9RvOlswhd31PQjqi88KWT0lmr8u6Jd4UAKjzziG5MSf73IkXy3+NwQxr+3ytd7GjGMnBorDJG265gM6M78hhJ+7zjdXU5uEOPIaQZuwxYg58S5DfNGZW3l0P7pv+y4w8lretFX66Om0plSQoDKEBrHr1lPXkUHPmmrVVH3cDswXHOPgyDpTMoI6t9cBbLPskinX2ygMNcOhKM6e53cf0/yJDwv+l85uwe7TDyI/OOXUKqF68VvooW+lVTR+XQTMsXxFgqtqW80qsbfVV2D0+S+ciaP98JsIPN+NfHIV0une/4gPOV87pSlHkdYPNStdi6wwzCZJJBRL6nYg9iQ6mvmCnac6sMXt0dpjHjlmxTugTYO2TK0tLkmNRbAFyxWSBrJ2E3ZFFuJ3lFjTu/IiUUiokzKiOTMGIpBRnhKVPUQP7nN+Qah7uZx+TFRA0cP285jMv2jPWi8O7WDffGtg1UUAjd0+NjkzQX8A8HtInqcCr2jRmcwDCBedmJAY2i4sjLl5H0kKFS8vJcTA/J90g3xBiCVJuWVWNZfpXg8jW1WpKs6pq9zIMBQyHSv0Bww9lh/793g3k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUFoMmEwQVl4ZkdNSzYzcmVDcDJKUjBMMzJZSExMMFZtcDlBaGgxekNybGw3?=
 =?utf-8?B?OFRCR2pucUg0V1ZXQ2dNaUpXYzFScWF4Sms4MmVyMU9FTzc1aC85Sk1NLzhM?=
 =?utf-8?B?SzdWMytpQVVQMDExV1o4VjlJdmhRa3QzQU13c3p4NEc5bVBKZTVubXk1U2FB?=
 =?utf-8?B?akFObzdWc3JOcjZUcEZjUEhOWjI5SWZCdWE4bDRlM2NMaHRpSWdUR1U5MDZG?=
 =?utf-8?B?MDN2TmhCNmRTcXlwV3U0c2FscHZzb3gzMDJ1ais2M1VQb2djMkFqVzlWNXQ2?=
 =?utf-8?B?YnArWm5yalZNNCt3UVRvYS9ZNTZJWXFOekZUcVdZMTRXMFJKR1o4OVY2SWRs?=
 =?utf-8?B?eE5LUStjUEIrOUp4eklvL0xvNVdPTDBrcklIbGlIVFErUDkwZGxXZC96K0R1?=
 =?utf-8?B?WFNlRG9XWEtkdkkxajVISnI4MXZUS0RsL0RtUmhGS3hBaFQ1RTZ1K1pFRENm?=
 =?utf-8?B?SVNsa0xFZEZDQnNlOEdOajF4ckZVT2NUUmNUcExZcU1ZT0ZubTJmMWFTM2I4?=
 =?utf-8?B?cnZKYVlIVndjSU9uQkQyYUFWYi9nYjA3dEU2aXZXcVJ5b0U2WXFXRS93d1VX?=
 =?utf-8?B?cSsydWFub1hvZXU2TGljVGltUStFNExIMmg2Q1BFdU9QUURxa1VwM3c0cjVn?=
 =?utf-8?B?M2VkUTZRdy92N3pFSzVBU1U2STJXQ1lLRzAyVXpZeFU1T1dwZEd3YU1semFC?=
 =?utf-8?B?QVZqQ2dHbkMySVA5SkxDVFVNdEVJYzVnUEp6YTlhaXlvTVo1MnBzZE16SGhz?=
 =?utf-8?B?cDlTcUE1M1d1WUxoT2Q1ZXMzbXZ3OElpd2FEUVErUW9QZ0l4aEFUL2Z5dHA5?=
 =?utf-8?B?S25aeFNhWTlYMUhHeEVnNG9aeHpmdFYzVTZEaFpBM3VKWXZCTlRoeDU0bk9o?=
 =?utf-8?B?VDhsRnFkcEloTmdNV25Sb0VDVTVINml0VE5YcEZkaWJ0Mk1nV0JsSlY1VlZC?=
 =?utf-8?B?aU1mZFgzeXozdFhiRk5weCt4NlhxbDNBM3U5MGdZWXRMSGQ1U0l6SG9JbGJj?=
 =?utf-8?B?R0E1blByZ3J5ZzNZZVplSXJwYkJvOUZKUGNRNGdTSVRnc3hPbEtkaStLb2RO?=
 =?utf-8?B?WW0wejVUZjZBaFN4TUxIaXpoSk5XQTg4clM1Qk9lTnFNdkVtWUN4SzlUTlJ5?=
 =?utf-8?B?NlgzZ3p3ZU15SGx5aW5QS0NqVG53Rm8yT2l5YzZGV25zT2J3akQ2ZzRXbHIw?=
 =?utf-8?B?eng2cWNuNGhheTdkRkVFakFCNWxVOEcvbDJlWEpXN3U4b3hJd21oTzBSVXll?=
 =?utf-8?B?VFRiNXp0UW1lVUgxMGFZSlpOZ2ZXL0NIYk4wVGFEVGtFZWZaSDhuUUhMSzJx?=
 =?utf-8?B?OW8za1M5UC8rQy9XQUV3ZDFidkxudy9xV2crSWNabjF5UnM4d092ZXU0dUdO?=
 =?utf-8?B?NVN4QXNxaXR4d1Ivd0FyWTFrYWp4WEN5UnI5LzByTkZKTXR5U1RXV0Mxc2g0?=
 =?utf-8?B?b1BzN256WVdLYThyb1BlWEx1enNWWHRob05CQnAzMjBQR0h6b3Awc29QR3pn?=
 =?utf-8?B?eWptSkZJRGp3YTZsbzIyKzdjVExpNk9LQ3BpWjhxSGxKN1F5UkRSZVdxTHhN?=
 =?utf-8?B?ZTFCNkM5MzRYN2tDM1cySDZ3TzRTcWVBZFplamdBUjFRM3hKYVJmMS9zODla?=
 =?utf-8?B?ZjVER3BuUkI2Zlk4YjgyZVY5bXB2SGRHL2ZiNXgxVmkzeUNsK2pzUm5samhv?=
 =?utf-8?B?SVVqc2xNN3pUK05WQzk0SGRsLzhEa1lOdTVpbkVDMW1RMU9GbmhGTUNURjZI?=
 =?utf-8?B?TWdudUtaakQ5YkVhRThicG1tQkJTMkR6Nm5nRmdtbFZFWUpLY2JQckY5c1JB?=
 =?utf-8?B?bDA0WEFVbDNkdDJZalNuaHo1VmdINmROejgvOGhzd2gyOUR3dStqQnB4K1BX?=
 =?utf-8?B?MSs3TFJIY2VKanI3dWEycTVLazBjVVlFc0JBKzd6cW9tNjBrWW10eHhMNHg0?=
 =?utf-8?B?U0dnaFJZZVROcFdoTll1Ukwra2hscTlNYUttYkZkZTVkSUxkaGt3clZrb0Z1?=
 =?utf-8?B?UVhSWDRQa01rMUtLZVgrN2duWEN1WjYzaHBZSzNvaHZuMDJvV3I4YTNUYktY?=
 =?utf-8?B?WTh0WjU2ZGZOUXhFMzZFTjNqc0UxdGtPd0M0SXM0YVhCNFp6M3JyMy8rUkZt?=
 =?utf-8?Q?jdD8ix2NzBXKvxBz2eodaiL2A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056ae6ed-663e-4cc8-30f1-08dc4ed3b035
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 03:03:48.0897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pPOdxSPCPpdmmjMwk324pO1Q0hRq/alvuswyg3yIRgrL37q4R0/3APrLnbYfgWHn1GjIJ38j5LI+gryVJ//Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyOCwgMjAyNCAzOjQ5IEFNDQo+IFRv
OiBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzogZmFyb3Nhc0BzdXNlLmRl
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IGhhby54aWFuZ0BieXRlZGFuY2UuY29tOw0KPiBicnlh
bi56aGFuZ0BieXRlZGFuY2UuY29tOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNC83XSBtaWdyYXRpb24vbXVsdGlmZDogYWRkIHFw
bCBjb21wcmVzc2lvbiBtZXRob2QNCj4gDQo+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDEyOjQ1
OjI0QU0gKzA4MDAsIFl1YW4gTGl1IHdyb3RlOg0KPiA+IGFkZCB0aGUgUXVlcnkgUHJvY2Vzc2lu
ZyBMaWJyYXJ5IChRUEwpIGNvbXByZXNzaW9uIG1ldGhvZA0KPiA+DQo+ID4gQWx0aG91Z2ggYm90
aCBxcGwgYW5kIHpsaWIgc3VwcG9ydCBkZWZsYXRlIGNvbXByZXNzaW9uLCBxcGwgd2lsbA0KPiA+
IG9ubHkgdXNlIHRoZSBJbi1NZW1vcnkgQW5hbHl0aWNzIEFjY2VsZXJhdG9yKElBQSkgZm9yIGNv
bXByZXNzaW9uDQo+ID4gYW5kIGRlY29tcHJlc3Npb24sIGFuZCBJQUEgaXMgbm90IGNvbXBhdGli
bGUgd2l0aCB0aGUgWmxpYiBpbg0KPiA+IG1pZ3JhdGlvbiwgc28gcXBsIGlzIHVzZWQgYXMgYSBu
ZXcgY29tcHJlc3Npb24gbWV0aG9kIGZvciBtaWdyYXRpb24uDQo+ID4NCj4gPiBIb3cgdG8gZW5h
YmxlIHFwbCBjb21wcmVzc2lvbiBkdXJpbmcgbWlncmF0aW9uOg0KPiA+IG1pZ3JhdGVfc2V0X3Bh
cmFtZXRlciBtdWx0aWZkLWNvbXByZXNzaW9uIHFwbA0KPiA+DQo+ID4gVGhlIHFwbCBvbmx5IHN1
cHBvcnRzIG9uZSBjb21wcmVzc2lvbiBsZXZlbCwgdGhlcmUgaXMgbm8gcXBsDQo+ID4gY29tcHJl
c3Npb24gbGV2ZWwgcGFyYW1ldGVyIGFkZGVkLCB1c2VycyBkbyBub3QgbmVlZCB0byBzcGVjaWZ5
DQo+ID4gdGhlIHFwbCBjb21wcmVzc2lvbiBsZXZlbC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFl1YW4gTGl1IDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBOYW5oYWkg
Wm91IDxuYW5oYWkuem91QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvY29yZS9xZGV2LXBy
b3BlcnRpZXMtc3lzdGVtLmMgfCAgMiArLQ0KPiA+ICBtaWdyYXRpb24vbWVzb24uYnVpbGQgICAg
ICAgICAgICB8ICAxICsNCj4gPiAgbWlncmF0aW9uL211bHRpZmQtcXBsLmMgICAgICAgICAgfCAy
MCArKysrKysrKysrKysrKysrKysrKw0KPiA+ICBtaWdyYXRpb24vbXVsdGlmZC5oICAgICAgICAg
ICAgICB8ICAxICsNCj4gPiAgcWFwaS9taWdyYXRpb24uanNvbiAgICAgICAgICAgICAgfCAgNyAr
KysrKystDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IG1pZ3JhdGlvbi9tdWx0aWZkLXFwbC5jDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMgYi9o
dy9jb3JlL3FkZXYtcHJvcGVydGllcy0NCj4gc3lzdGVtLmMNCj4gPiBpbmRleCBkNzlkNmY0YjUz
Li42Y2NkNzIyNGY2IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5
c3RlbS5jDQo+ID4gKysrIGIvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMNCj4gPiBA
QCAtNjU5LDcgKzY1OSw3IEBAIGNvbnN0IFByb3BlcnR5SW5mbyBxZGV2X3Byb3BfZmRjX2RyaXZl
X3R5cGUgPSB7DQo+ID4gIGNvbnN0IFByb3BlcnR5SW5mbyBxZGV2X3Byb3BfbXVsdGlmZF9jb21w
cmVzc2lvbiA9IHsNCj4gPiAgICAgIC5uYW1lID0gIk11bHRpRkRDb21wcmVzc2lvbiIsDQo+ID4g
ICAgICAuZGVzY3JpcHRpb24gPSAibXVsdGlmZF9jb21wcmVzc2lvbiB2YWx1ZXMsICINCj4gPiAt
ICAgICAgICAgICAgICAgICAgICJub25lL3psaWIvenN0ZCIsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAibm9uZS96bGliL3pzdGQvcXBsIiwNCj4gPiAgICAgIC5lbnVtX3RhYmxlID0gJk11bHRp
RkRDb21wcmVzc2lvbl9sb29rdXAsDQo+ID4gICAgICAuZ2V0ID0gcWRldl9wcm9waW5mb19nZXRf
ZW51bSwNCj4gPiAgICAgIC5zZXQgPSBxZGV2X3Byb3BpbmZvX3NldF9lbnVtLA0KPiA+IGRpZmYg
LS1naXQgYS9taWdyYXRpb24vbWVzb24uYnVpbGQgYi9taWdyYXRpb24vbWVzb24uYnVpbGQNCj4g
PiBpbmRleCAxZWViOTE1ZmY2Li5jYjE3N2RlMWQyIDEwMDY0NA0KPiA+IC0tLSBhL21pZ3JhdGlv
bi9tZXNvbi5idWlsZA0KPiA+ICsrKyBiL21pZ3JhdGlvbi9tZXNvbi5idWlsZA0KPiA+IEBAIC00
MSw2ICs0MSw3IEBAIGlmIGdldF9vcHRpb24oJ2xpdmVfYmxvY2tfbWlncmF0aW9uJykuYWxsb3dl
ZCgpDQo+ID4gICAgc3lzdGVtX3NzLmFkZChmaWxlcygnYmxvY2suYycpKQ0KPiA+ICBlbmRpZg0K
PiA+ICBzeXN0ZW1fc3MuYWRkKHdoZW46IHpzdGQsIGlmX3RydWU6IGZpbGVzKCdtdWx0aWZkLXpz
dGQuYycpKQ0KPiA+ICtzeXN0ZW1fc3MuYWRkKHdoZW46IHFwbCwgaWZfdHJ1ZTogZmlsZXMoJ211
bHRpZmQtcXBsLmMnKSkNCj4gPg0KPiA+ICBzcGVjaWZpY19zcy5hZGQod2hlbjogJ0NPTkZJR19T
WVNURU1fT05MWScsDQo+ID4gICAgICAgICAgICAgICAgICBpZl90cnVlOiBmaWxlcygncmFtLmMn
LA0KPiA+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vbXVsdGlmZC1xcGwuYyBiL21pZ3JhdGlvbi9t
dWx0aWZkLXFwbC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAw
MDAwLi4wNTZhNjhhMDYwDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL21pZ3JhdGlvbi9t
dWx0aWZkLXFwbC5jDQo+ID4gQEAgLTAsMCArMSwyMCBAQA0KPiA+ICsvKg0KPiA+ICsgKiBNdWx0
aWZkIHFwbCBjb21wcmVzc2lvbiBhY2NlbGVyYXRvciBpbXBsZW1lbnRhdGlvbg0KPiA+ICsgKg0K
PiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjMgSW50ZWwgQ29ycG9yYXRpb24NCj4gPiArICoNCj4g
PiArICogQXV0aG9yczoNCj4gPiArICogIFl1YW4gTGl1PHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+
ID4gKyAqDQo+ID4gKyAqIFRoaXMgd29yayBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMgb2Yg
dGhlIEdOVSBHUEwsIHZlcnNpb24gMiBvcg0KPiBsYXRlci4NCj4gPiArICogU2VlIHRoZSBDT1BZ
SU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3RvcnkuDQo+ID4gKyAqLw0KPiA+ICsjaW5j
bHVkZSAicWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCj4gPiAr
DQo+ID4gK3N0YXRpYyB2b2lkIG11bHRpZmRfcXBsX3JlZ2lzdGVyKHZvaWQpDQo+ID4gK3sNCj4g
PiArICAgIC8qIG5vb3AgKi8NCj4gPiArfQ0KPiA+ICsNCj4gPiArbWlncmF0aW9uX2luaXQobXVs
dGlmZF9xcGxfcmVnaXN0ZXIpOw0KPiA+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vbXVsdGlmZC5o
IGIvbWlncmF0aW9uL211bHRpZmQuaA0KPiA+IGluZGV4IGM5ZDliMDkyMzkuLjViN2Q5YjE1Zjgg
MTAwNjQ0DQo+ID4gLS0tIGEvbWlncmF0aW9uL211bHRpZmQuaA0KPiA+ICsrKyBiL21pZ3JhdGlv
bi9tdWx0aWZkLmgNCj4gPiBAQCAtNDAsNiArNDAsNyBAQCBNdWx0aUZEUmVjdkRhdGEgKm11bHRp
ZmRfZ2V0X3JlY3ZfZGF0YSh2b2lkKTsNCj4gPiAgI2RlZmluZSBNVUxUSUZEX0ZMQUdfTk9DT01Q
ICgwIDw8IDEpDQo+ID4gICNkZWZpbmUgTVVMVElGRF9GTEFHX1pMSUIgKDEgPDwgMSkNCj4gPiAg
I2RlZmluZSBNVUxUSUZEX0ZMQUdfWlNURCAoMiA8PCAxKQ0KPiA+ICsjZGVmaW5lIE1VTFRJRkRf
RkxBR19RUEwgKDQgPDwgMSkNCj4gPg0KPiA+ICAvKiBUaGlzIHZhbHVlIG5lZWRzIHRvIGJlIGEg
bXVsdGlwbGUgb2YgcWVtdV90YXJnZXRfcGFnZV9zaXplKCkgKi8NCj4gPiAgI2RlZmluZSBNVUxU
SUZEX1BBQ0tFVF9TSVpFICg1MTIgKiAxMDI0KQ0KPiA+IGRpZmYgLS1naXQgYS9xYXBpL21pZ3Jh
dGlvbi5qc29uIGIvcWFwaS9taWdyYXRpb24uanNvbg0KPiA+IGluZGV4IGFhMWIzOWJjZTEuLmRj
ZWIzNWRiNWIgMTAwNjQ0DQo+ID4gLS0tIGEvcWFwaS9taWdyYXRpb24uanNvbg0KPiA+ICsrKyBi
L3FhcGkvbWlncmF0aW9uLmpzb24NCj4gPiBAQCAtNjI5LDExICs2MjksMTYgQEANCj4gPiAgIw0K
PiA+ICAjIEB6c3RkOiB1c2UgenN0ZCBjb21wcmVzc2lvbiBtZXRob2QuDQo+ID4gICMNCj4gPiAr
IyBAcXBsOiB1c2UgcXBsIGNvbXByZXNzaW9uIG1ldGhvZC4gUXVlcnkgUHJvY2Vzc2luZyBMaWJy
YXJ5KHFwbCkgaXMNCj4gYmFzZWQgb24NCj4gPiArIyAgICAgICB0aGUgZGVmbGF0ZSBjb21wcmVz
c2lvbiBhbGdvcml0aG0gYW5kIHVzZSB0aGUgSW50ZWwgSW4tTWVtb3J5DQo+IEFuYWx5dGljcw0K
PiA+ICsjICAgICAgIEFjY2VsZXJhdG9yKElBQSkgYWNjZWxlcmF0ZWQgY29tcHJlc3Npb24gYW5k
IGRlY29tcHJlc3Npb24uDQo+IChTaW5jZSA5LjApDQo+IA0KPiBzLzkuMC85LjEvDQoNCk9rLCBJ
IHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gPiArIw0KPiA+ICAjIFNpbmNl
OiA1LjANCj4gPiAgIyMNCj4gPiAgeyAnZW51bSc6ICdNdWx0aUZEQ29tcHJlc3Npb24nLA0KPiA+
ICAgICdkYXRhJzogWyAnbm9uZScsICd6bGliJywNCj4gPiAtICAgICAgICAgICAgeyAnbmFtZSc6
ICd6c3RkJywgJ2lmJzogJ0NPTkZJR19aU1REJyB9IF0gfQ0KPiA+ICsgICAgICAgICAgICB7ICdu
YW1lJzogJ3pzdGQnLCAnaWYnOiAnQ09ORklHX1pTVEQnIH0sDQo+ID4gKyAgICAgICAgICAgIHsg
J25hbWUnOiAncXBsJywgJ2lmJzogJ0NPTkZJR19RUEwnIH0gXSB9DQo+ID4NCj4gPiAgIyMNCj4g
PiAgIyBATWlnTW9kZToNCj4gPiAtLQ0KPiA+IDIuMzkuMw0KPiA+DQo+IA0KPiBSZXZpZXdlZC1i
eTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiANCj4gLS0NCj4gUGV0ZXIgWHUNCg0K

