Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC86BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 21:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwTQR-0001N8-3V; Mon, 15 Apr 2024 16:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwTQN-0001Mq-5Q
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 16:59:36 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwTQJ-0006pP-Fr
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 16:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713214771; x=1744750771;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=z0wUb+nR8me3EkZZ5lHvEKHekPzk3HPnQB6rOLMWeDs=;
 b=OyQgAENtcLOYZ61d9msFyhjjea6oVe6esmA40DIpj9aVNZ95tL8nDRsU
 nW8FAi07FlBtxUgzLb/CoSglL28HKShRk2+NGDOgDDxrxUFt2PmdowmU9
 TK/DkPKdm82q5UiWub+XnIY9D8GFZ22dExQ6l90BzpJ++q4AjWKbmyj1X
 S3YReQ4Ja+xEzeo0ExN2yxw+3zeVHrE0ixr9xS96AbrfeXyQCVGzTyena
 zs+lPDbHTuKN9Z9SG2tH5nMcEeeaTJRcKcZbRB4UCwcbGHLvDeYqIIQrK
 Hogk9ZMkpbMAYbbuht7tMmUDpk8rPWP0kr5VpK7gl8O9epx/YyNYVPqSl w==;
X-CSE-ConnectionGUID: z03C5PSPQOubmsXToAOV6g==
X-CSE-MsgGUID: gritbzLAS9ekQWEbw8gE3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19776997"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; d="scan'208";a="19776997"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 13:59:26 -0700
X-CSE-ConnectionGUID: 9RCvQW+IS6ahGiRZh/H3TA==
X-CSE-MsgGUID: OALwePR4QMy7yQd27Z1A1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; d="scan'208";a="52981081"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 13:59:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 13:59:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 13:59:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 13:59:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 13:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYX+nnKWef0oVBiNN0RU/E8L5Ej9kJ/kf/QPKUU6vpF/pel81RDsBI7yaYjZ1nuDSP3pMKBm+KXuL8EncKHEUCuhDFG40eSFYyJN85WwCqSDBzoXi3gUPYYbKz0wJHNdplG8ePm/UtihkzClmSKwDu6p5xAEswmIfi8BMEAiURLBisOrGevUMEoxblu0rY/uK2HbZnsrACDkRB+IhEE69IdjAhEwmNIE+PBwp7FkqLs9fPsQuTpSsG4N0kil+LW0gozMSUatMU6Fhxn8inKapf2p3KDgPyLKoGIkW3uucobHjzcq1PlX3yXvMB+3ukdk37eUEdJC/lwwzgj6AWkd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0wUb+nR8me3EkZZ5lHvEKHekPzk3HPnQB6rOLMWeDs=;
 b=PjPXuxr3nHpd4X441+ukj1lpGyjsn6ux4Bi8c6Ydyo1BNnI24tf9MEBgGvIQHkIgIoVo/JNhuZQbzBLbS4rmiftfgqEmDe8p4z/uQEOcrW3xDybjnAN0FXchAVmB3Pbo87pmaFXwFZkFQ/wE36YPhdxos/CAj9HDnI/TwgQF34f9FoGxN9GQz7wAIhsYqSV6QZicnhDIL8bz2d+shiOdUXjZ1fxt0ew5EatRbZ2s1A0smlvA6lmWKDb9m7vefIrf6JyDhrc5bmjh/Y9K1m+zRVzstxTayZJlJ15caK5zLjKeoRff9m5QM0T53Yu6OLFzlh8I+Xn2+uSTrLBBnr6E+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 20:59:23 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7452.019; Mon, 15 Apr 2024
 20:59:23 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "dbassey@redhat.com" <dbassey@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH] vhost-user-gpu: fix import of DMABUF
Thread-Topic: [PATCH] vhost-user-gpu: fix import of DMABUF
Thread-Index: AQHajyZVTLaKttv9UU6MFpGJqBARG7Fp0IyQ
Date: Mon, 15 Apr 2024 20:59:23 +0000
Message-ID: <PH8PR11MB68796D6A887ECEA0D22FAA06FA092@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240415111553.2733357-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240415111553.2733357-1-marcandre.lureau@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: f400d1dd-1995-41ca-6235-08dc5d8eedae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKlD5qFDb4qBqgprSu56ERsAc78xLdt5Hq2GuDKR3X81p2SIzhtnmmZIz72oz8tEa/UcWWM6fF1cUIpA0UyuwJhKSYl/vealCOYFz1wArPJg1bqAQMl2fjg+MwtDCRV0D9IK5aKP47INdfq9ibjlgTBwjXWaVy0oTh0efiuH/UAbGFHtYThFv+DN6vbx/8RndXZVk+bE/OYRBuMgco4GCnT3V7KnSotxfCuN30OZtv7S5/QrKF5ejHLCn7o4NcX3xugeVLenRZsTMOMuPgEin4JfA+14gQKv5eaDCesMSJ/xAFyTNYtwfjWMTFrCKLRZTU4tFSaSdt2GODwyI8JYyCnxBdwo4DNC2Rwr7Rw8HAU0NulAnmiyNzve9KA4SqTiDRLUT2/IkWpEOZR7ilu6zbeGsxE2Bn+MeCbmzc0Pq0wlQqFwGB8CthQYOXqO8bGiSCYBgHh7NK0xI0unLXlo/YrYXjG+jeangHgwOYan9jcflpRqbolKZP1JZz+8MH7Hr+0TlWJwQIovxfx/fQEs1VkZmVsdjjHA9g85/6k+Jo4ha1j+QaCWxdUG6E9I25Z5ZJrav60Y4/bMMVySVM8+g4uNT8d5b0yzuV0h6rgg9Y9aV1s2rVHD105XLuKJce5dMR1zkhYQmaWP0ZXWZhH30Vwx8QDFV3yhyTVj3nfTwK/eqQOy54jcPIb4z58Ge8DSRTbk7YeykiinJkmT7Xb9jVmfCV3oB4FFwgkNKAF997Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDJ6aThjT2VDUjBLdlNLaTF1TXh3ZWlHUnBlc25HblV4T0lacTVQNWxKclJH?=
 =?utf-8?B?MU1oYlA0NVRSQ3FsQUhRT2QzbXhiZk5leTg0YXY3NitsaVlCWEdhUTFVVGRm?=
 =?utf-8?B?eXloU2FrTy9GOWVRMTAvTldGQ2pYRmJmMzNZNmU4SjdlZXlGL2c3dE5pM3dU?=
 =?utf-8?B?U3Y5MDE1SExrMjVtUklVUTBDdG96bmRkdzdiQnljdGJoeWpWMTJUZ2hRUFBM?=
 =?utf-8?B?a0tuZHN4M28vWTBIZjN4d3o3OVJ4MWJVZDUraWpFUldPWFFRcFZRWTd2aUlx?=
 =?utf-8?B?eGRoR3l5c2R0SDVRR0VIbk5FckI1bG4zRXc0Y0hKYVJxWnA1cFAzUC9vclJY?=
 =?utf-8?B?QUpOYzY5L1RxMzhxcmVpSzl4L3NQTDR5ZEU3TVN4WVo4SENZVEJmTngvR2h5?=
 =?utf-8?B?TXVhc2FRQkNnVnQ0dzhiUFFqRUFDNmoybE5pdjJXUXplWXRMOVFIL2hkaVIw?=
 =?utf-8?B?MnZnWjJ5RXZadER6K04rdnJ0UXR0VnRhSGgyM3RXaExVR3hyRkJEa2VIbEpj?=
 =?utf-8?B?TW9mS0liMG94UXNCWUJrN3UzamNXUDFWd0N5dnEyYUdDbVpnV1IvTTJGaExi?=
 =?utf-8?B?SmF3NGFPREVuVzRJQ0hmZlZhZXVkNzIzQkI3bEdrTTgvT3RLRnV1S3BGcDdJ?=
 =?utf-8?B?dHFseUtCRkI0NlBqNy9QU0swQlN5U1VTb2pZODJCTW1EUElUTFpaNEZZM2d4?=
 =?utf-8?B?VzBqdWtQemtSRE5wR24yR0RyN2hsSDNmU3dqTVdaV3BJek1WOHJCQnRJZzcw?=
 =?utf-8?B?M1loQVl1ckRMMDJEejJIbG5MdExuTEllWFZxTVFHTHNQL2RwSktZblpleWpE?=
 =?utf-8?B?SlZ4UUNWOGZFRlNqalBFN0kvOUV1MERIc0F0N1ByR0JzL1A5VUxlM2JLQ2ow?=
 =?utf-8?B?QmRwbmxJbExuYUluemx3azlZVFY0RE9DMFJzTm5KbzBrcWlkQXJNd1UxalVC?=
 =?utf-8?B?dzIrUzFLbTBOT01yL1VBaGFJWDN4NkFrTVJZNkNyVWh1TFBacEdvbnpLa1Y0?=
 =?utf-8?B?dTdTZHZXeHJYWHNkQzE2UnR2YXNzQmVEMVI3WGNJdXJ0TlJidU00RC9BZXZm?=
 =?utf-8?B?UCtrTVkzSU1kWDhseWdlcnJjSS8wMmR5TzRPYlpvazR4Tk9Fc3I5K3c4Wjdp?=
 =?utf-8?B?K2tsRS9IZFovdHQ4WXFYekdtbWxPckpRN0J3Yk1JcVlRSlQySmpoeFlLWkZl?=
 =?utf-8?B?aDZkcjgwOU1naGIvdU9aeWhnRjg5bEdMOU9Cam4wdjNCdC92UzFvN1V6OHg4?=
 =?utf-8?B?elhMWG5nQlo0aVJwTnZmYzlDMHoxMmtKMTFTQzhrRWtXOVdFVlNNSmVvb3Rp?=
 =?utf-8?B?SDY5ZDdER3NWSHJNL0pva2svcEx0TFVXcVZXODE2b0FKNWlyLzVVZzlKdTY0?=
 =?utf-8?B?eFpHdUdOOG0zUGgwRHE0ZFpvSEk4YlJQa09NSG5VcEkwWWgrMHB3djdscG1t?=
 =?utf-8?B?SEtTeGJWUmR2QmJ2a3AyZjA3bUIvVHc0TEJJc0xVcDZjOXZVTWlFdmtmeHpm?=
 =?utf-8?B?N1dLeE5HUXZBcGVLTWN4dXhJc1c3bjBVdUluSnlZZm43S29pblVmYjVjTVhP?=
 =?utf-8?B?TjBjSWVJMXJCSy8vRHFMTWl1NjlsRlpnajhRdllqUU02Z2YwVEtRMU82VHhQ?=
 =?utf-8?B?SWV0ZkhLWmE0R2pjQjdHS3FIUlRrZnRwcTZvVEVmeE5pOVVzTlRmbGhLaU0y?=
 =?utf-8?B?ZjlNN2plN25tUU9taDBwTFhNTjF0dnRFalQ2czFoOXdqZDFIZEoxMkNaK1ha?=
 =?utf-8?B?bm15NjJEaUl3Z2RTWkk4aHpjUU5PL29KYnJmd0ltTjJPcXpmTitrSFZoNVpS?=
 =?utf-8?B?aFhBR1BHUDlwWWdKV1lRQzZHeXJRVnZRQ2F5RzljMnA2TVA4bk85VURuNXFu?=
 =?utf-8?B?ZThtWVlmcE1BWFpkd2IvNmJkOXBHaG1lNXZwSFRoV0UySXdvcHRqK3FsTm1O?=
 =?utf-8?B?dGo2QmFzYmRuQjdaY1hNQ2xoeUJoYUI3TjZpdGhyRi9WT205MTVydisycml6?=
 =?utf-8?B?VWU2RmJQckRHNlZCanRuL0pQSjZtV0V6WTVyVmV4NEJtd1hsSWNJRVo0OCtp?=
 =?utf-8?B?TS9HN1dTT3FuN3luR3NzY2M4bVAybXh0UTYxbEtvWEtVUms1V0VmM3hCNkll?=
 =?utf-8?Q?4KV6B2Wuph+yWn1Ek8SffiYaw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f400d1dd-1995-41ca-6235-08dc5d8eedae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 20:59:23.3803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxQusMW5ZgsNMSYXRwidW1t4JFmgu0w8tarxdF45BHpxWnrkOfts9JdqU7QBnpFrolz3UDSLIyhq+bJC5HR6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+
DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTUsIDIwMjQgNDoxNiBBTQ0KPiBUbzogcWVtdS1kZXZl
bEBub25nbnUub3JnDQo+IENjOiBLaW0sIERvbmd3b24gPGRvbmd3b24ua2ltQGludGVsLmNvbT47
IGRiYXNzZXlAcmVkaGF0LmNvbTsgTWFyYy0NCj4gQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tPjsgTWljaGFlbCBTLiBUc2lya2luDQo+IDxtc3RAcmVkaGF0LmNvbT47
IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHZo
b3N0LXVzZXItZ3B1OiBmaXggaW1wb3J0IG9mIERNQUJVRg0KPiANCj4gRnJvbTogTWFyYy1BbmRy
w6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IA0KPiBXaGVuIHVzaW5n
IHZob3N0LXVzZXItZ3B1IHdpdGggR0wsIHFlbXUgLWRpc3BsYXkgZ3RrIGRvZXNuJ3Qgc2hvdyBv
dXRwdXQgYW5kDQo+IHByaW50czogcWVtdTogZWdsQ3JlYXRlSW1hZ2VLSFIgZmFpbGVkDQo+IA0K
PiBTaW5jZSBjb21taXQgOWFjMDZkZjhiICgidmlydGlvLWdwdS11ZG1hYnVmOiBjb3JyZWN0IG5h
bWluZyBvZiBRZW11RG1hQnVmDQo+IHNpemUgcHJvcGVydGllcyIpLCBlZ2xfZG1hYnVmX2ltcG9y
dF90ZXh0dXJlKCkgdXNlcyBiYWNraW5nX3t3aWR0aCxoZWlnaHR9IGZvcg0KPiB0aGUgdGV4dHVy
ZSBkaW1lbnNpb24uDQo+IA0KPiBGaXhlczogY29tbWl0IDlhYzA2ZGY4YiAoInZpcnRpby1ncHUt
dWRtYWJ1ZjogY29ycmVjdCBuYW1pbmcgb2YgUWVtdURtYUJ1Zg0KPiBzaXplIHByb3BlcnRpZXMi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBody9kaXNwbGF5L3Zob3N0LXVzZXItZ3B1LmMgfCA0ICsr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvaHcvZGlzcGxheS92aG9zdC11c2VyLWdwdS5jIGIvaHcvZGlzcGxh
eS92aG9zdC11c2VyLWdwdS5jIGluZGV4DQo+IDcwOWM4YTAyYTEuLmJhZmZiMWMyZDQgMTAwNjQ0
DQo+IC0tLSBhL2h3L2Rpc3BsYXkvdmhvc3QtdXNlci1ncHUuYw0KPiArKysgYi9ody9kaXNwbGF5
L3Zob3N0LXVzZXItZ3B1LmMNCj4gQEAgLTI3Myw4ICsyNzMsOCBAQCB2aG9zdF91c2VyX2dwdV9o
YW5kbGVfZGlzcGxheShWaG9zdFVzZXJHUFUgKmcsDQo+IFZob3N0VXNlckdwdU1zZyAqbXNnKQ0K
PiAgICAgICAgICB9DQo+ICAgICAgICAgICpkbWFidWYgPSAoUWVtdURtYUJ1Zikgew0KPiAgICAg
ICAgICAgICAgLmZkID0gZmQsDQo+IC0gICAgICAgICAgICAud2lkdGggPSBtLT5mZF93aWR0aCwN
Cj4gLSAgICAgICAgICAgIC5oZWlnaHQgPSBtLT5mZF9oZWlnaHQsDQpbS2ltLCBEb25nd29uXSAg
SSB0aGluayB3ZSBjb3VsZCBqdXN0IGxlYXZlIC53aWR0aC8uaGVpZ2h0IHNldHRpbmcgaGVyZSBh
bHRob3VnaCBub3RoaW5nIHdpbGwgZ28gd3JvbmcgaW4gYW55IGNhc2VzLiBEaWQgeW91IGhhdmUg
YW55IHNwZWNpZmljIHJlYXNvbiB3aHkgbGVhdmluZyB0aGVzZSB1bmluaXRpYWxpemVkPw0KDQo+
ICsgICAgICAgICAgICAuYmFja2luZ193aWR0aCA9IG0tPmZkX3dpZHRoLA0KPiArICAgICAgICAg
ICAgLmJhY2tpbmdfaGVpZ2h0ID0gbS0+ZmRfaGVpZ2h0LA0KPiAgICAgICAgICAgICAgLnN0cmlk
ZSA9IG0tPmZkX3N0cmlkZSwNCj4gICAgICAgICAgICAgIC5mb3VyY2MgPSBtLT5mZF9kcm1fZm91
cmNjLA0KPiAgICAgICAgICAgICAgLnkwX3RvcCA9IG0tPmZkX2ZsYWdzICYgVklSVElPX0dQVV9S
RVNPVVJDRV9GTEFHX1lfMF9UT1AsDQo+IC0tDQo+IDIuNDEuMC4yOC5nZDdkODg0MWY2Nw0KDQo=

