Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D78C47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 01:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUGeE-0000cd-WD; Sun, 28 Jan 2024 20:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rUGeB-0000cP-UB
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 20:41:15 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rUGe5-0005bc-To
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 20:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706492470; x=1738028470;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jCwVAIgxdXrQ+ZBt9JLT++52M8dn/6+F6numeTx60tw=;
 b=d2BREAltPTUnBU9A5LMiOmfKGzDdRzfCpMUpj1IMPltdtGcikVda+DEU
 RWVKDLoSdb6FVbTI5tDiCSd3n8BkhnQ+yTVygqZEe33WQ8yBvBLA7ugIN
 6FIRv3YbASWyfsYAOoDfzjC5DixWr0XuLAE2ALZK785qMjyj40H/ITDT6
 1X3hHxm5I9wpnumDkyREXbSJCrIQE9DOGQ20zOXza7tazyyjHlzZaYSZN
 jAj/sLd8+cACtuc07kI2Qq2q5B/Cg3z8KkO7AyXgy64DbcE4wg+YBLqG+
 FNfeynbVUWuYLgl+9+qDh6l5243IqJp11h5F5+B0dM9HWLcJWUzXgeKgu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9937081"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="9937081"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 17:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1118781494"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="1118781494"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Jan 2024 17:41:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 17:41:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 17:41:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 17:41:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 17:41:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFVmNFBpLPoIy6nfwKx53N7f5Wm0mhW+2qheqGGbVVQnIn08fAfEwTYmHLDBwmyDWsbUzs6XWsRq2OlkYTdC9UK2yp4MPfwyTb0JzJk6tiMuTPusi90haoivn4KjjH6aF4f+MaQ+d3q5rfPTuff5ukXrM+juxqx/eiFIDiqko7ES3QchNPU1dpPEdSQzKX2WtELEbV/iWJRrdfX0LTjak/n12q1fDMHRRLYsPWbejcIWdR/aar9ImZ8iKCfCxF4TFRV3gjJggoCKszN3AKQlGxyxveuHhNl6sctQ6QbDMx7bu2LtBsYuNvMEBOzWy4pq2m2MKZUlgD2gz7k2j6bLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCwVAIgxdXrQ+ZBt9JLT++52M8dn/6+F6numeTx60tw=;
 b=jLXQTPKITwF2AdznQecs54xeOMsxg0NLhlhezOwRbU7u9L1LsRrz+VLo79Xt4cMa8iYE49/K0AooRt93pTEaXRJQv5TNYpUsRY4lBjubYO9Q+bypkETBuPgZ3vJkcno+0bOEs16LKDq8ZGTrGcJycDJRpGszORCR75eWJNsEyGPPdOvSbxmGcf57OSd9Gzx9RaW0dFVae8Bf6j02ksglxfuyVB3W+ZCKFg5RQQn3Rzm/2QqRFMLP3MGRsryTKDyhC1o8AhpQYsryCKBit47gAPgAMwQGwanUZZZgHmdeG13utKTZqHXwyQ0pIcfejrIMmjNEVj0yUJ8tbKSPiGc4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 01:41:02 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c%3]) with mapi id 15.20.7228.026; Mon, 29 Jan 2024
 01:41:02 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>, "Bryan
 Zhang" <bryan.zhang@bytedance.com>
Subject: RE: [PATCH 0/5] migration/multifd: Prerequisite cleanups for ongoing
 work
Thread-Topic: [PATCH 0/5] migration/multifd: Prerequisite cleanups for ongoing
 work
Thread-Index: AQHaUKXNiVxcGstwVkSsGev8eYFCJ7DwAvqQ
Date: Mon, 29 Jan 2024 01:41:01 +0000
Message-ID: <PH7PR11MB5941BDAB9743C53A9E08CC3CA37E2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240126221943.26628-1-farosas@suse.de>
In-Reply-To: <20240126221943.26628-1-farosas@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DM4PR11MB6288:EE_
x-ms-office365-filtering-correlation-id: a3e4abca-72ac-4331-6876-08dc206b59d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3D/qOoBiQ5zmQ9KQJiM9+4R58BSM88xffhbI+y5y5UG9RKfGHibl+2ly9t0t7fmjmDCNFjPp2wMXtonw5MmjNBRSDhFutooxP+TSv33JtfhmbLT2beHiOBEfspExmhQoPopCcC8q/n8u54NKfDXXiYBmBHXEHdrbEhhOflvL0w215SUGEqYiNT9ijsIgdECifus/ZJL1CsIKelq7nNb2oqHMuDEkVvL+z2xMn3NrjWoukJ9UPt5LQPw0CM7ZxWEWhyImJuxBdQFzcotdsNNeoJqT6fjmm2OGTGlCzJwnG9LWg77UhdjWS29m06cQtxsWl9+xhj3OqgfkVgjL4uWeFa9ijOaLdD/y8dTwe9YY1+AQ5F0TO4moAp1jSU8QvZDV9opvW7ShIeYC+pr9dQ6QHJynbmfcn0ELF0WbAqehjVH4ypED2ANF9mMD0BxIjHDrLEkJ6q+3BztuYcRAnnqW4tpZ5NuQxIoOpALHrPzAJYNq0EedYpHhhbNqOpi0MLg1aD/ukkEk17htmojm+mXMuiCQXPomhPYCAtVVuXuQtpVPZ05ptibv2jLb6RQteWEkqTT13ZVFV3PQ7ylhZlVNNDJRCs9EvBHBUg9O0ppGwHo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38070700009)(55016003)(2906002)(6506007)(7696005)(5660300002)(71200400001)(9686003)(53546011)(76116006)(316002)(66556008)(66946007)(110136005)(4326008)(8676002)(8936002)(52536014)(26005)(66476007)(66446008)(64756008)(54906003)(966005)(122000001)(38100700002)(478600001)(86362001)(33656002)(82960400001)(41300700001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?amNGN2RYUTBjS3hUeUFreE5RN3pRSUpEMUJWcVl4YkpTMElncTR1czVjdWlK?=
 =?gb2312?B?dG9NRnBKY1lnWFZnckorc2NCQ09WRktrTEZ6MVVDY0pyaUY0U0VMS24rbnA0?=
 =?gb2312?B?Y1hQTUR4QnpCaXNobzh1WXNTVG5CSEJXUUZLcFY3ZnlEaGYvS0ptWnkyVHVz?=
 =?gb2312?B?K3gybFlYZDdBeno2M1pkNi90WklVd3hPallxQ0xHNUh2ZHVpVU1ET3FZcE5W?=
 =?gb2312?B?OEVhRGNVbmZwRnVPUEhqOVpvcG5tZ2pzOURFak1obEtQNVc1VzduWDRtanBL?=
 =?gb2312?B?cElEMlRQaUVGL0FXSlJqQlBWaTk5eGl0U0tzMzkrUWk1WVRab2RERTYwK1pS?=
 =?gb2312?B?eVJUTUEyL3RranpYSUNKQnVLV0JmbmFrYk95UEZxcm51eG92YlhMQ0MwNWhU?=
 =?gb2312?B?c1hkdTBUekMrM3FZT2l3R2I0N2RScmlUTVZvQkt2OTJIZ3pib3llYzUyR3RX?=
 =?gb2312?B?Kyt2bkt6YjV3di85Smxaekh5ZjNBejNlZVBORDNRdmlYdzFKT1dWUm9Pb1VD?=
 =?gb2312?B?N3hsQTRMaUt1R1k4UnlWaVVSVmthVUYrZTRtOGhTTTNWTk0zT1JtSVpvK3V5?=
 =?gb2312?B?aUkrcEU5RjU2R254SWpZUDVSZ2VVOHFQSVRIOGVieUNTSzVlck5PWE1DVldv?=
 =?gb2312?B?U2F1TGR4eGNkNnhtQ0wrSnUyU2hQR0dzSjlwRjBJejc2dHRmTFdJNkxHaUsy?=
 =?gb2312?B?aXZ2UnYzdXdLa1FUVThSczBtRGd5UVVsTEJxOHFwaWI4WFE0MXdrUXhNVHhH?=
 =?gb2312?B?WC8rMzV6bW1oUVBkL3NMS0JoMnFRdGl3bGQ4ZVJTQTVPTmZYSHVJUldXc0Ny?=
 =?gb2312?B?Zm95Y05qVGhxV3YzSXBGM2RzK3E5UXFWckwyTEw1bm1TOFl4cmRiL2s4Y3U3?=
 =?gb2312?B?Si9ZUGFpRUVXdGIxUnRaS1lTMmFHWWZOOHlha0J5bVAvN050cDFWMFpaWjVi?=
 =?gb2312?B?UXJFVk8zWXlQb29jNHhoaFRZK2ZNRVM2eXMzRUZ0SUZXbFVQNW5pMFlCNDZE?=
 =?gb2312?B?dHVzT1VEOWlVMzBjNURubGtIZ1hneFpjZXVNZU1oN1VzL0xETHpPT0hQbnQz?=
 =?gb2312?B?c3FFL1JtVnZxV2cyY20wWWJRZDZ1WS9Gb2hhOWVtcG54S0VLVVdtdWc0Ujhy?=
 =?gb2312?B?WS84bHp3am1HMTM5WW5FREtlYlZnaG90d2dwNHlOSGdKZXRVeXlIUms0OWN2?=
 =?gb2312?B?cTA5eTMrTTZ3dzkwKzRFQXRKVVlPWERQeEZ0VUQrQm5YUHJpMnZzOS9BS1l1?=
 =?gb2312?B?em9YYWtRcDJJU3VtWHM2T3VsR3dqZko1OUszTERueFZ4VFRSdXJBekhhbjE4?=
 =?gb2312?B?aHQ4NDNEdjFqc0h3Z3VOb29vUFc1d254clZxSnc0WGFMV1hTTllPMk5BbVZZ?=
 =?gb2312?B?MmVZS3NPY290OS9GaytkNFRwbzJyZnllek94SkY2S2RvTStiUWloWlhyWElH?=
 =?gb2312?B?N0lXTDRLOHJGRVpzOGtEbWw5QTA2ZjN1Ym5hMHJHWjFwSlpSNkdHaVM3NGNh?=
 =?gb2312?B?QUFNcWJHT21RdXo2OWhWeG54OXZmVi9oaDR1RXl3UGxCenNBbFZlQXQxVU5B?=
 =?gb2312?B?dHNDdlNoWTBkZ09mUHl0SXU2c1MrL3BpUW1DZjBCYUlFQld2M1BEVGlrQmVB?=
 =?gb2312?B?SFp1UEgvZE1wK2dHWDBxK09lK0dWUWF6OUZaTE45WEpCMldVSS9pK1lYM0Iy?=
 =?gb2312?B?NnBoNTVQanNJeFVPdHZSb0tyVEFURWE0N2JHZG5GQUw5OUJNT1pEL3pQVCtN?=
 =?gb2312?B?eVF1NlBMaS9Bci9QZTJhLzJUdVNSSjd1UzRXdTFoZi95SVBpUElJaVM2ajhm?=
 =?gb2312?B?L3Q4OE1HdXJxdG1RRTBuRnh5cnpJeGNGRVUyNU9mOWFqNG5iUi9XWE5QdElB?=
 =?gb2312?B?bWZUaHRLeU55a2pQdUh5a3hta1pIMDRrMGFzUW40cXZkVHlkUkVJOUFJT2tr?=
 =?gb2312?B?NDNDR0cvUEc5MW9BWHRMN2xvazBTelNDR1FmNjhQT3pPUDZwemVkYTZPNUhz?=
 =?gb2312?B?c1FPdkJYbTczRWY5NlB1SnNkWG16ZzRBSG1ELytWNXo3RHpUYUlkNm5saHpu?=
 =?gb2312?B?V2RZMk9zOTJqNXpielJWbzYxR1ZSb3BGQXpnOFAwdzBoQkNSTVFMbGFmdXFy?=
 =?gb2312?Q?XMqnNJAIbeF9Yo82A+SkgLfO9?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e4abca-72ac-4331-6876-08dc206b59d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 01:41:02.0095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mngspEMLwi74Cx9cA1vMiSehMJubLsXF3lYkiLMGz4CVUQiLIK1OcsTzFm291TK6cym+RHU4zspOFqHHPrnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpYW5vIFJvc2FzIDxmYXJv
c2FzQHN1c2UuZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDI3LCAyMDI0IDY6MjAgQU0N
Cj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPjsgSGFvIFhpYW5nIDxoYW8ueGlhbmdAYnl0ZWRhbmNlLmNvbT47DQo+IExpdSwgWXVh
bjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+OyBCcnlhbiBaaGFuZyA8YnJ5YW4uemhhbmdAYnl0ZWRh
bmNlLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDAvNV0gbWlncmF0aW9uL211bHRpZmQ6IFByZXJl
cXVpc2l0ZSBjbGVhbnVwcyBmb3Igb25nb2luZw0KPiB3b3JrDQo+IA0KPiBIaSwNCj4gDQo+IEhl
cmUgYXJlIHR3byBjbGVhbnVwcyB0aGF0IGFyZSBwcmVyZXF1aXN0ZSBmb3IgdGhlIGZpeGVkLXJh
bSB3b3JrLCBidXQNCj4gYWxzbyBhZmZlY3QgdGhlIG90aGVyIHNlcmllcyBvbiB0aGUgbGlzdCBh
dCB0aGUgbW9tZW50LCBzbyBJIHdhbnQgdG8gbWFrZQ0KPiBzdXJlIGl0IHdvcmtzIGZvciBldmVy
eW9uZToNCj4gDQo+IDEpIFNlcGFyYXRlIG11bHRpZmRfb3BzIGZyb20gY29tcHJlc3Npb24uIFRo
ZSBtdWx0aWZkX29wcyBhcmUNCj4gICAgY3VycmVudGx5IGNvdXBsZWQgd2l0aCB0aGUgbXVsdGlm
ZF9jb21wcmVzc2lvbiBwYXJhbWV0ZXIuDQo+IA0KPiBXZSdyZSBhZGRpbmcgbmV3IG11bHRpZmRf
b3BzIGluIHRoZSBmaXhlZC1yYW0gd29yayBhbmQgYWRkaW5nIG5ldw0KPiBjb21wcmVzc2lvbiBv
cHMgaW4gdGhlIGNvbXByZXNzaW9uIHdvcmsuDQo+IDIpIEFkZCBhIG5ldyBzZW5kIGhvb2suIFRo
ZSBtdWx0aWZkX3NlbmRfdGhyZWFkIGNvZGUgY3VycmVudGx5IGRvZXMNCj4gICAgc29tZSB0d2lz
dHMgdG8gc3VwcG9ydCB6ZXJvIGNvcHksIHdoaWNoIGlzIGEgc29ja2V0LW9ubHkgZmVhdHVyZS4N
Cj4gDQo+IFRoaXMgbWlnaHQgYWZmZWN0IHRoZSB6ZXJvIHBhZ2UgYW5kIERTQSB3b3JrIHdoaWNo
IGFkZCBjb2RlIHRvDQo+IG11bHRpZmRfc2VuZF90aHJlYWQuDQoNClRoYW5rIHlvdSBmb3IgeW91
ciByZW1pbmRlcqOsIEkgcmV2aWV3ZWQgdGhlIHBhdGNoIHNldCBhbmQgdGhlcmUgaXMgDQphIHF1
ZXN0aW9uLg0KDQpCZWNhdXNlIHRoaXMgY2hhbmdlIGhhcyBhbiBpbXBhY3Qgb24gdGhlIHByZXZp
b3VzIGxpdmUgbWlncmF0aW9uIA0KV2l0aCBJQUEgUGF0Y2gsIGRvZXMgdGhlIHN1Ym1pc3Npb24g
b2YgdGhlIG5leHQgdmVyc2lvbiBuZWVkcyANCnRvIGJlIHN1Ym1pdHRlZCBiYXNlZCBvbiB0aGlz
IGNoYW5nZT8NCg0KPiANCj4gQ0kgcnVuOiBodHRwczovL2dpdGxhYi5jb20vZmFyb3Nhcy9xZW11
Ly0vcGlwZWxpbmVzLzExNTQzMzIzNjANCj4gDQo+IChJIGFsc28gdGVzdGVkIHplcm8gY29weSBs
b2NhbGx5LiBXZSBjYW5ub3QgYWRkIGEgdGVzdCBmb3IgaXQgYmVjYXVzZSBpdA0KPiBuZWVkcyBy
b290IGR1ZSB0byBtZW1vcnkgbG9ja2luZyBsaW1pdHMpDQo+IA0KPiBGYWJpYW5vIFJvc2FzICg1
KToNCj4gICBtaWdyYXRpb24vbXVsdGlmZDogU2VwYXJhdGUgY29tcHJlc3Npb24gb3BzIGZyb20g
bm9uLWNvbXByZXNzaW9uDQo+ICAgbWlncmF0aW9uL211bHRpZmQ6IE1vdmUgbXVsdGlmZF9zb2Nr
ZXRfb3BzIHRvIHNvY2tldC5jDQo+ICAgbWlncmF0aW9uL211bHRpZmQ6IEFkZCBtdWx0aWZkX29w
cy0+c2VuZA0KPiAgIG1pZ3JhdGlvbi9tdWx0aWZkOiBTaW1wbGlmeSB6ZXJvIGNvcHkgc2VuZA0K
PiAgIG1pZ3JhdGlvbi9tdWx0aWZkOiBNb3ZlIHplcm8gY29weSBmbGFnIGludG8gbXVsdGlmZF9z
b2NrZXRfc2V0dXANCj4gDQo+ICBtaWdyYXRpb24vbXVsdGlmZC16bGliLmMgfCAgIDkgKystDQo+
ICBtaWdyYXRpb24vbXVsdGlmZC16c3RkLmMgfCAgIDkgKystDQo+ICBtaWdyYXRpb24vbXVsdGlm
ZC5jICAgICAgfCAxNjQgKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ICBtaWdyYXRpb24vbXVsdGlmZC5oICAgICAgfCAgIDYgKy0NCj4gIG1pZ3JhdGlvbi9zb2NrZXQu
YyAgICAgICB8ICA5MCArKysrKysrKysrKysrKysrKysrKy0NCj4gIDUgZmlsZXMgY2hhbmdlZCwg
MTI4IGluc2VydGlvbnMoKyksIDE1MCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMzUuMw0K
DQo=

