Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D0BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 17:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx8k2-0004Rx-BY; Wed, 17 Apr 2024 13:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rx8jz-0004Rn-V3
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:06:37 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rx8jw-00076L-Cn
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713373592; x=1744909592;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tdN4A9FUEJzO94tKrg97TjzZz3MW5TNlTOWpBSTRgN8=;
 b=lS5X/USeilQPBK0Ps+WgGUkIkaaYW+VctyTul/ceVm7rqFmE6JuZRWPR
 izLJtVrcMRxigmHL5U4s6QR89286VZujhyH1g88KES8gPDfVubXob1/F2
 MIrRV6V2SPlulsLxXp1GFtvGCJGOKRcB1xxStqwyfgYvCCwoWbo+5s+E8
 QPuNqGLB8mL5bLOcyb6J6Baw4wDy+aSfSzCwiJ4iZVwCAVihMEAAB/9gw
 gWGW1p/L5SfqTlxaW2QG5xhad2vG90mhm/+yp8ayT81negXnB2SlTBvDJ
 5H2WCcSl48yWf5Hzr7uyAHFFVyGBD8E5tf2cqfsM/pHTnCAg3HbDhVYT3 w==;
X-CSE-ConnectionGUID: 67sEseyBRGOs1aDDBfA/0Q==
X-CSE-MsgGUID: U4j5xuEeRJ++9HYoJWRDUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12663199"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; d="scan'208";a="12663199"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 10:06:29 -0700
X-CSE-ConnectionGUID: abt+NSMrTDqFi94kSE/6QQ==
X-CSE-MsgGUID: bShrzYYLQdKz436Ojs8GEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; d="scan'208";a="22743634"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Apr 2024 10:06:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 10:06:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 10:06:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 10:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHFCgEMx+f686GWi4DY8zepouCatOO5Tq736Q5qydVN9GfxkjLMVBJpmv6LeUI5J6T/YxhRxxv05ImTBCi5klTjsZmzF8FgskZOqZWocgjKSwqZBZQwstWjkpS53ZY4P6G2VhAcBVhcn+E6ri4Ul9R+zVBZ1Oyw1XIrymMPVQJXPn0BY2Qmv65NDoeF8ewEgBxS9FJENpWQ+3w+GrxzWDO0YKoxKQXDdIajTPGGvtAkumUdUBvVSOeaRCB4UjKG1cAKvFZB4UvW+d1/9OZc6dT9UWgMdh0ysKH4fZ01LcacB7mAijKoMB1egtC3NYwRgmXivetXD91LhnB330vsB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdN4A9FUEJzO94tKrg97TjzZz3MW5TNlTOWpBSTRgN8=;
 b=PxkkvbknwW8kCc4eylim21YJqZDESULCIvgCEzIJoVwslzB6fmLKPWFBKB3PPG3qJRsRMe83bzasCXNuk+TvbFmqd4zVx37QAmXyh9Oa9X+a1ryrTQHSWdbZ7sffbnQ5JnGHiCxjpvg8wa5aMgGDvTSeyu69HmHy5/kU08K0s7sdO++pk2f6mRlhBAPBVnRJqVa8+GL+sKn7WvfNFoyzlDpgiIP6qkp5UB00QBw1+2GdKUhn/Rz7tY77BW2MVEunCwiQ/vKLWkoVkrdpOE33SJlkD6zNaDside4SDu8KrGiTnZyVOg8wvb19mSkBcfQkithSkqwUN1ucRkECVNznkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Wed, 17 Apr
 2024 17:06:26 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 17:06:26 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v6 1/3] ui/console: Introduce dpy_gl_qemu_dmabuf_get_..()
 helpers
Thread-Topic: [PATCH v6 1/3] ui/console: Introduce dpy_gl_qemu_dmabuf_get_..()
 helpers
Thread-Index: AQHakH3ZJEAJtwHix0ejl15tfncMYLFsTSyAgABjcRA=
Date: Wed, 17 Apr 2024 17:06:26 +0000
Message-ID: <PH8PR11MB6879490376E2A6F9A4831643FA0F2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240417040954.55641-1-dongwon.kim@intel.com>
 <20240417040954.55641-2-dongwon.kim@intel.com> <Zh-s1wqWU8c0GHS8@redhat.com>
In-Reply-To: <Zh-s1wqWU8c0GHS8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SA2PR11MB5193:EE_
x-ms-office365-filtering-correlation-id: 117e23b5-f4a9-4f14-fe3f-08dc5f00b766
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVztKYqgbMwo8Yh9q1m1M1ACUDi+TigftNF1pNl4HBz0fC7pB6P2yHWHZl8md0WzUIcZ1eTSFzx6P8GJpPSSHd5E2sjzAIcg6oVcYl5HnherLkYqmdaJh9MyYFKchiVU0C9ULSQRr6ZcvXVm0oJdbSq9dyPN0lm86HmK4N0b8zwHCWfCGK/Aj+IZO1yVum/clhlos+jsNuoHC/LUbb5EbdtStsiUdbD7wTsB73xhl7tGwU2CvEqnwEYPSYPxguSn+ma/KJ/s+YlQ17hioN4aVQrXkdlByBGfriyxLsXw8mwbzebeII06HRkpQnYB9fRj8L61G8U90GwX+8uMfFbZ1oAeCC3dD3WXF2hlpvyeHulaV7jCD1iBlV3dbnvoD3x7Kd7kj0g4mQO2Ubtw5cNgnNXaL24R8HGe3vQi+rhxccCJHMLbmBxo3L3rhlsV9ZHWVEIKuPL4CtFZhXfcbM+pavGCTi7HLTI602HaKWUnZYuQT2NOZlc2UP6/xeqevAF0jiAw4P8Fa18pVCl6cMyf3R4WsLcvHuLK7kDN77gpmPlU/rq9Y4FLrDOofWdPfLkRE5QYOSmzdMCYy75UJqerOzqrRnzEcFz5FG/hU3L1Iq21q6Oaz8dtxabUj9IfPgWmOj0LNE9nBISaIa+VdTvf/cVOvPTatCiCvLuQuIsFGOo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmhTVnZKL3hXSk1PZmQ5eHdxM3g0azE2dXRiZ3pzOHc5anZnYndkNmhzMDNU?=
 =?utf-8?B?aFJXVEpNNndTUmxXcUZVWnh0NUM1V2RDRVp5MC9rUnZSbjBYM3dQZG94cHBW?=
 =?utf-8?B?anBCSFQyUGx2cXYvdW0yZTU3RnB6K3MzbVpKMmM0c20vSUcxOXdieXB6WEc1?=
 =?utf-8?B?RUtSNE0vYXk1NDZQa1B5UmdncGFmNW8vWXcvNHhiWlMxYURoS0l5OW5zZFJ2?=
 =?utf-8?B?cDhWSmloaHRSQUV4UFVnNUV6OTNDdDY3SldhRDBwNHN1TXBXTzNqTmtLOE5L?=
 =?utf-8?B?YndyS0x3cWduQVROOUVPOXJSWGNZTGtvM2lFVHZPRW5sc3dIb2pXRjMwOEJh?=
 =?utf-8?B?ODlpWE04dGhNcHZJdEhleU5TMDYrL2MxREF1cDkxd2xzRCtBOGUwZE5GOHJG?=
 =?utf-8?B?NW8xUnhYeER1RFN6aUdUdE1rc1E5TDErSlpBcU5CdEZOVGYzV29IVHBhYWFn?=
 =?utf-8?B?bVFySDM2aFF1bWhBVWpUSUlzQjFuWDhSRGxlWm00eGJTUW1oM05EajJCQU1r?=
 =?utf-8?B?b1JSVG1NQVhla1d2Zjl4KzdHd0VUbHdCS2FLeHZEQWYydVFnV2xETTJrUm1B?=
 =?utf-8?B?Q3dCYU8yZnl1eUZqZkNaYlhsTGdiMmt3Y1pQUExSQVVOdEdIbGc2a3U3K0tE?=
 =?utf-8?B?a3YzelA1d05FdnNuS0hZYnplOFE4Y2lIQ0d3eGx2YUljZDk5MmM4QTZ5M3Z1?=
 =?utf-8?B?NDJ6dzF6SjFBcm5NL2t6TXU2OUVrZGxWYnltR2NUdGRnZXRtUDhNNW1GdmtP?=
 =?utf-8?B?dCtTb3JMUUtmbGxZV3UvVGk5QnpIN0hoZ3NXQUZwYnJpRWZQck1lcnhhWUNS?=
 =?utf-8?B?VHJMdzd4dTJ5amI5c0JzUU1PZldZY0hpRWs3NlR5d3pCYkxTUjVuZThQV2NB?=
 =?utf-8?B?bnJJalpqNFdibjNUejZpajdIcmFxOFA4Rk1oQTNlMStCc0dmZXRKR0wrVW5r?=
 =?utf-8?B?RnRXYjJuOTE2T0JTMktpaU8vNnUvbVlvWHRPRUhlNVJQb3NhaDRNdW4xelUw?=
 =?utf-8?B?RDNIa25CRDR6Y2ZCVmR3ZlpYRjhTN1JjemQwaEFDTGNYM1E0d01YTDVLdFNj?=
 =?utf-8?B?eVE3LzB2VW1QU3BaaC96dlc5QkszNkcvVWZNc2krbi9VaEJWQ0NpY0V1QzNa?=
 =?utf-8?B?Zm8yTStqMFFIcjJrcU9xeGlhU1NZaldxbjExOGxPblRrZHlFb2tkK1hzVGMx?=
 =?utf-8?B?d2JVSU5qclNFQ2dsR0NPdmlSclFaY09YK3JuRm9mZ1NDUlZHQm15bDcxcUtw?=
 =?utf-8?B?ekpFRjg5TXFOQVVTTVcwSDdiVmd3NGt3U1hpOHJ6dUVBMUwxdWZ1WTFWdHgx?=
 =?utf-8?B?OHh3RCtFZ0tiVnI4cDc5UVB3OUFwMmxqbFpYbEZZTE5peXgvLzIvTkh1TTFy?=
 =?utf-8?B?OVdJL2dZNDREbkJZdjNHS0lzdVAzL08xSjRVVnR2VWF4NGYybFFGWmpDemQ0?=
 =?utf-8?B?ckpwcWl4b0JqU0dHdzRRS0l5ZHgvUlNKQTFWL1l1cExPbkRFMWl6WHBhaUVV?=
 =?utf-8?B?M0lIYWpJNHNPN0thMS9iT3ZxOUVHNVBOeFhBM2xwdnRwQjBQUUxlMVIzMXQy?=
 =?utf-8?B?cnVQZVg4cWk1T29kL3ArYlVMd0J5dG5ha1R3eDBhNWIrQ2VTSjVLZ2p3elV1?=
 =?utf-8?B?NVZ3WVd5cWtPczNTcTNJZ0kzYi9wK3RKY3U1eURQdWFBVkU1d2VpdjdsQ0dl?=
 =?utf-8?B?NHBlamVoUFRuWmgwdzZpTDR5U1VXT0RiZUJ3QUk2bUZwMEhIKzhtdTVGMmJH?=
 =?utf-8?B?L2NiT3pRbkpNbmwxTFJPYk5yU2U4UllCRzQyT1FZQ1VyaUtUU090WW9FSitU?=
 =?utf-8?B?KzJycU1xMjNjeWdNenlqY0RLZ0F2WGxBVHByNldrMTk4UEpXZjNQM1kzaVA1?=
 =?utf-8?B?ZzdWdzI0TzRaQjVqa21UQzBRQ3BMbU5lK3VFazlCZ1o2dkQ3MXhyeXRyWGtQ?=
 =?utf-8?B?ZnlVOWhTcEpUVGdVMjgwdW5acXdCUjVNbzhuKzZXVDNMTnJDSXRaK1pXK1U0?=
 =?utf-8?B?aUJ6dnJSRUxZUC94ZmZkbE9mZEFQaHhMWHhrSHZsVlFFSzdCS1E4V09aMzZl?=
 =?utf-8?B?SjM1Rk1wdnBpUDhlNklTUS9nS2xjZTNobWVFdS80VEIyWHJuN2J1K2ZJcFV6?=
 =?utf-8?Q?Alwo+9Ku8JRUIolk2vrfTTqFR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117e23b5-f4a9-4f14-fe3f-08dc5f00b766
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 17:06:26.1168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeKT6WSTn4ybGLXG2oU5JR1pNs51gHG4CkOPSZGKgCp1hh/vVEVowd7HGhdTd5OAMwTPs7Ut1OatRWCBSw/9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
QXByaWwgMTcsIDIwMjQgNDowNSBBTQ0KPiBUbzogS2ltLCBEb25nd29uIDxkb25nd29uLmtpbUBp
bnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IG1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDEvM10gdWkvY29uc29sZTogSW50
cm9kdWNlDQo+IGRweV9nbF9xZW11X2RtYWJ1Zl9nZXRfLi4oKSBoZWxwZXJzDQo+IA0KPiBPbiBU
dWUsIEFwciAxNiwgMjAyNCBhdCAwOTowOTo1MlBNIC0wNzAwLCBkb25nd29uLmtpbUBpbnRlbC5j
b20gd3JvdGU6DQo+ID4gRnJvbTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4N
Cj4gPg0KPiA+IFRoaXMgY29tbWl0IGludHJvZHVjZXMgZHB5X2dsX3FlbXVfZG1hYnVmX2dldF8u
Li4gaGVscGVycyB0byBleHRyYWN0DQo+ID4gc3BlY2lmaWMgZmllbGRzIGZyb20gdGhlIFFlbXVE
bWFCdWYgc3RydWN0LiBJdCBhbHNvIHVwZGF0ZXMgYWxsDQo+ID4gaW5zdGFuY2VzIHdoZXJlIGZp
ZWxkcyB3aXRoaW4gdGhlIFFlbXVEbWFCdWYgc3RydWN0IGFyZSBkaXJlY3RseQ0KPiA+IGFjY2Vz
c2VkLCByZXBsYWNpbmcgdGhlbSB3aXRoIGNhbGxzIHRvIHRoZXNlIG5ldyBoZWxwZXIgZnVuY3Rp
b25zLg0KPiA+DQo+ID4gdjY6IGZpeCB0eXBvcyBpbiBoZWxwZXIgbmFtZXMgaW4gdWkvc3BpY2Ut
ZGlzcGxheS5jDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+IENjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+ID4gQ2M6IFZpdmVrIEthc2lyZWRkeSA8dml2ZWsua2Fz
aXJlZGR5QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dv
bi5raW1AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL3VpL2NvbnNvbGUuaCAgICAg
ICAgICAgIHwgIDE3ICsrKysrDQo+ID4gIGh3L2Rpc3BsYXkvdmhvc3QtdXNlci1ncHUuYyAgICAg
fCAgIDYgKy0NCj4gPiAgaHcvZGlzcGxheS92aXJ0aW8tZ3B1LXVkbWFidWYuYyB8ICAgNyArLQ0K
PiA+ICBody92ZmlvL2Rpc3BsYXkuYyAgICAgICAgICAgICAgIHwgIDE1ICsrKy0tDQo+ID4gIHVp
L2NvbnNvbGUuYyAgICAgICAgICAgICAgICAgICAgfCAxMTYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCj4gPiAgdWkvZGJ1cy1jb25zb2xlLmMgICAgICAgICAgICAgICB8ICAgOSAr
Ky0NCj4gPiAgdWkvZGJ1cy1saXN0ZW5lci5jICAgICAgICAgICAgICB8ICA0MyArKysrKysrLS0t
LS0NCj4gPiAgdWkvZWdsLWhlYWRsZXNzLmMgICAgICAgICAgICAgICB8ICAyMyArKysrKy0tDQo+
ID4gIHVpL2VnbC1oZWxwZXJzLmMgICAgICAgICAgICAgICAgfCAgNDcgKysrKysrKy0tLS0tLQ0K
PiA+ICB1aS9ndGstZWdsLmMgICAgICAgICAgICAgICAgICAgIHwgIDQ4ICsrKysrKysrLS0tLS0N
Cj4gPiAgdWkvZ3RrLWdsLWFyZWEuYyAgICAgICAgICAgICAgICB8ICAzNyArKysrKystLS0tDQo+
ID4gIHVpL2d0ay5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCj4gPiAgdWkvc3Bp
Y2UtZGlzcGxheS5jICAgICAgICAgICAgICB8ICA1MCArKysrKysrKy0tLS0tLQ0KPiA+ICAxMyBm
aWxlcyBjaGFuZ2VkLCAzMTYgaW5zZXJ0aW9ucygrKSwgMTA4IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWkvY29uc29sZS5oIGIvaW5jbHVkZS91aS9jb25zb2xl
LmggaW5kZXgNCj4gPiAwYmM3YTAwYWMwLi42MjkyOTQzYTgyIDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvdWkvY29uc29sZS5oDQo+ID4gKysrIGIvaW5jbHVkZS91aS9jb25zb2xlLmgNCj4gPiBA
QCAtMzU4LDYgKzM1OCwyMyBAQCB2b2lkIGRweV9nbF9jdXJzb3JfZG1hYnVmKFFlbXVDb25zb2xl
ICpjb24sDQo+IFFlbXVEbWFCdWYgKmRtYWJ1ZiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBib29sIGhhdmVfaG90LCB1aW50MzJfdCBob3RfeCwgdWludDMyX3QNCj4gPiBob3RfeSk7
ICB2b2lkIGRweV9nbF9jdXJzb3JfcG9zaXRpb24oUWVtdUNvbnNvbGUgKmNvbiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBvc194LCB1aW50MzJfdCBwb3NfeSk7
DQo+ID4gKw0KPiA+ICtpbnQzMl90IGRweV9nbF9xZW11X2RtYWJ1Zl9nZXRfZmQoUWVtdURtYUJ1
ZiAqZG1hYnVmKTsgdWludDMyX3QNCj4gPiArZHB5X2dsX3FlbXVfZG1hYnVmX2dldF93aWR0aChR
ZW11RG1hQnVmICpkbWFidWYpOyB1aW50MzJfdA0KPiA+ICtkcHlfZ2xfcWVtdV9kbWFidWZfZ2V0
X2hlaWdodChRZW11RG1hQnVmICpkbWFidWYpOyB1aW50MzJfdA0KPiA+ICtkcHlfZ2xfcWVtdV9k
bWFidWZfZ2V0X3N0cmlkZShRZW11RG1hQnVmICpkbWFidWYpOyB1aW50MzJfdA0KPiA+ICtkcHlf
Z2xfcWVtdV9kbWFidWZfZ2V0X2ZvdXJjYyhRZW11RG1hQnVmICpkbWFidWYpOyB1aW50NjRfdA0K
PiA+ICtkcHlfZ2xfcWVtdV9kbWFidWZfZ2V0X21vZGlmaWVyKFFlbXVEbWFCdWYgKmRtYWJ1Zik7
IHVpbnQzMl90DQo+ID4gK2RweV9nbF9xZW11X2RtYWJ1Zl9nZXRfdGV4dHVyZShRZW11RG1hQnVm
ICpkbWFidWYpOyB1aW50MzJfdA0KPiA+ICtkcHlfZ2xfcWVtdV9kbWFidWZfZ2V0X3goUWVtdURt
YUJ1ZiAqZG1hYnVmKTsgdWludDMyX3QNCj4gPiArZHB5X2dsX3FlbXVfZG1hYnVmX2dldF95KFFl
bXVEbWFCdWYgKmRtYWJ1Zik7IHVpbnQzMl90DQo+ID4gK2RweV9nbF9xZW11X2RtYWJ1Zl9nZXRf
YmFja2luZ193aWR0aChRZW11RG1hQnVmICpkbWFidWYpOw0KPiB1aW50MzJfdA0KPiA+ICtkcHlf
Z2xfcWVtdV9kbWFidWZfZ2V0X2JhY2tpbmdfaGVpZ2h0KFFlbXVEbWFCdWYgKmRtYWJ1Zik7IGJv
b2wNCj4gPiArZHB5X2dsX3FlbXVfZG1hYnVmX2dldF95MF90b3AoUWVtdURtYUJ1ZiAqZG1hYnVm
KTsgdm9pZA0KPiA+ICsqZHB5X2dsX3FlbXVfZG1hYnVmX2dldF9zeW5jKFFlbXVEbWFCdWYgKmRt
YWJ1Zik7IGludDMyX3QNCj4gPiArZHB5X2dsX3FlbXVfZG1hYnVmX2dldF9mZW5jZV9mZChRZW11
RG1hQnVmICpkbWFidWYpOyBib29sDQo+ID4gK2RweV9nbF9xZW11X2RtYWJ1Zl9nZXRfYWxsb3df
ZmVuY2VzKFFlbXVEbWFCdWYgKmRtYWJ1Zik7IGJvb2wNCj4gPiArZHB5X2dsX3FlbXVfZG1hYnVm
X2dldF9kcmF3X3N1Ym1pdHRlZChRZW11RG1hQnVmICpkbWFidWYpOw0KPiANCj4gSU1ITyB0aGVz
ZSBtZXRob2QgbmFtZXMgZG9uJ3QgbmVlZCBhICJkcHlfZ2xfIiBwcmVmaXggb24gdGhlbS4gU2lu
Y2UNCj4gdGhleSdyZSBhY2Nlc3NvcnMgZm9yIHRoZSAiUWVtdURtYUJ1ZiIgc3RydWN0LCBJIHRo
aW5rIGl0cyBzdWZmaWNpZW50IHRvIGp1c3QNCj4gaGF2ZSAicWVtdV9kbWFidWZfIiBhcyB0aGUg
bmFtZSBwcmVmaXgsIG1ha2luZyBuYW1lcyBtb3JlIGNvbXBhY3QuDQo+IA0KPiBUaGUgY29uc29s
ZS57aCxjfSBmaWxlcyBhcmUgYSBiaXQgb2YgYSBkdW1waW5nIGdyb3VuZCBmb3IgVUkgY29kZS4g
V2hpbGUNCj4gUWVtdURtYUJ1ZiB3YXMganVzdCBhIHN0cnVjdCB3aXRoIGRpcmVjdCBmaWVsZCBh
Y2Nlc3MgdGhhdCdzIE9LLg0KPiANCj4gV2l0aCB0dXJuaW5nIHRoaXMgaW50byBhIG1vcmUgb2Yg
YW4gb2JqZWN0IHdpdGggYWNjZXNzb3JzLCBJIHRoaW5rIGl0IHdvdWxkIGFsc28NCj4gYmUgZGVz
aXJhYmxlIHRvIG1vdmUgdGhlIHN0cnVjdCBkZWZpbml0aW9uIGFuZCBhbGwgaXRzIG1ldGhvZHMg
aW50byBzZXBhcmF0ZQ0KPiB1aS9kbWFidWYue2MsaH0gZmlsZXMsIHNvIGl0cyBmdWxseSBzZWxm
LWNvbnRhaW5lZC4NCiANCltLaW0sIERvbmd3b25dIEkgYW0gb2sgd2l0aCBjaGFuZ2luZyBmdW5j
dGlvbiBuYW1lcyBhbmQgY3JlYXRlDQpzZXBhcmF0ZSBjIGFuZCBoIGZvciBkbWFidWYgaGVscGVy
cyBhcyB5b3Ugc3VnZ2VzdGVkLiBCdXQgSSB3b3VsZA0KbGlrZSB0byBoZWFyIE1hcmMtQW5kcsOp
J3Mgb3BpbmlvbiBhYm91dCB0aGlzIHN1Z2dlc3Rpb24gYmVmb3JlIEkgbWFrZQ0Kc3VjaCBjaGFu
Z2VzLg0KDQpNYXJjLUFuZHLDqSwgZG8geW91IGhhdmUgYW55IHRob3VnaHQgb24gRGFuaWVsJ3Mg
c3VnZ2VzdGlvbj8NCg0KPiANCj4gV2l0aCByZWdhcmRzLA0KPiBEYW5pZWwNCj4gLS0NCj4gfDog
aHR0cHM6Ly9iZXJyYW5nZS5jb20gICAgICAtby0gICAgaHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9w
aG90b3MvZGJlcnJhbmdlIDp8DQo+IHw6IGh0dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAtby0g
ICAgICAgICAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJhbmdlLmNvbSA6fA0KPiB8OiBodHRwczov
L2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0gICAgaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9k
YmVycmFuZ2UgOnwNCg0K

