Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9547BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJvx-0001Gd-EW; Thu, 30 Apr 2026 01:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1wIJvu-00018V-Pn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:27:31 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1wIJvs-0007ZW-2g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777526848; x=1809062848;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1MXnX5yeU4aZ2GtuLSVW6LKPECuzY2h086mIdNO6r2g=;
 b=mgHCk+y844zzE09GhrJTL2/19yd11s8SUUvzhm72Bef9BlXrIBHEQeH6
 eUKjOOS98lfgZ06o9b6mICAjqYUcg4FDth3zRih3alPA+KswCsU6ewa8N
 Q2kFCfDR4je25ItzQD4X7YozZ3fzjBDtVfJ7n1l32ArrZV4uNBcBEohcT
 47j885BNd8nGTgHTb5h+ThDH+jXdI4rR0ss0mb6EQdpOe9/69dz8zbCRQ
 2Xtjoa71Ib1vIRUfnpV9BAvAtOLhsLjy6IAI3o5uy6cJua0MI48jmVvYY
 RWTlitrTXrfoHO/QOtuaNCqYaQ+3AxsOl5kyFpfQS3bkXQdVRVjp6XNvm w==;
X-CSE-ConnectionGUID: RWVm4CejTwyOTu4tVElQlA==
X-CSE-MsgGUID: XPidQxkgQ9K8XYLkivg32g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89066034"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89066034"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 22:27:24 -0700
X-CSE-ConnectionGUID: e2UMuERtRtCEEBOOz6diSw==
X-CSE-MsgGUID: PKXoqj5dQNS7/33E7b84AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="272594085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 22:27:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 22:27:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 22:27:23 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 22:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvhny0i1yspNerTpc4gYXyRe6BtX5plnunCNJ8QkAVgv6IiTl5L2cXVxcehZ14lgnXPS5jOd7cm/v791Yor3kbR+po5VtII8A/HejkrWUUiq9fC6dWlWu6+NJMEsR+CyRej7YcxNFMNA+/v+/AtgekMJ+Qv8Z0ZEhGDihlKGMS7d8g0oCsHSrq+sGHDbDTEeLaF3n5vtl2aU6AiX0Rjs5nI1lIByGdJsY8NTns8/PVaAu7wYYxNbdHvtmwLpr/TKaZ5hhM3v0dJPbz/n7PycyIs3sNs8nF/xf9oJVNyklIUylfYAg1g2wHv3U5mdvP08ta+Iu3wTFgHzF3A3Zxbarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhPrQo0J7WZrX/qgLnJPgGtkBv4WvecPMpSnJ6KAfYs=;
 b=RKAnIkAFix+FmM/E9qhgQJ23XFVT1I8aD52X2ycH8swa2jwhHS8iHNsAZUiCTI4K+bM0Zybmp5zG942mT/jB8lkn8MEGsTqw6daFTGXbIhNFyWaqwMzLjXcToihk7bYaQld4pyMzQQu9K1uecdM4gDNcA2QHyPz3dNz81a60TdNcqe6qjCI9GxZ/uxcPTCrg6AhQJ6FogJC6MiAxXGnb4XKtLF+eiNbQVJmfbadMFFoL4jIyESJNH146sJKJo9IhZz/SJRkxFN9T24qUdtXyNW11x3Q09ioDe1CwfCag2XWZQvqKSBtgezBSd+OSoGzvvuc7W17vMN7jmlPNvSDcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW4PR11MB6933.namprd11.prod.outlook.com (2603:10b6:303:22a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 05:27:19 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 05:27:19 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHct2CBd1EkLKy70EmTrlWjg/HgLrW8bKeAgAANlYCAAO/SgIAAuJ2ggADRFQCAIdYwQIAKKnuAgAiSPiA=
Date: Thu, 30 Apr 2026 05:27:18 +0000
Message-ID: <IA0PR11MB718592C4186247B072EB8F24F8352@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
 <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F5B516E3FAC39290B6A0F8232@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e09e7494-8261-4ad3-a0c1-6dd41c163961@redhat.com>
In-Reply-To: <e09e7494-8261-4ad3-a0c1-6dd41c163961@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW4PR11MB6933:EE_
x-ms-office365-filtering-correlation-id: 1b5ff181-7c73-4fef-546c-08dea67925e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: mRLs6/+WLVtnrSPv0CELHSmq6aJ/GVKSsqJG1fIy6p67SAU7aHBO8mc6FEwbxkvuYOfOdvUOtv7T1DwkohNp6ICxCyFFDOoNrOLGZ/5GZXKxdqHaXgjHDjIoWMl6JelNTbzobg79H8dEn3xScuV/UCloSvW3pM0De9gFx9F/QiNsEZvBgqm3RWld25n3jAu+45hnHaNAZfDr8zmXPk4fhxMsNWuD8r/rUIetWEDfNC+y9shMhdusT7YpklQbUozGm3jbjDbKoQ4/n8RQ8ZmaMzOjywHKZjF4rMw8kk2fVhOM0MLiqYAbAV95gxOfNvYeM59cJH3NrF17SUYreFzXqkOj5F2GH+d2ElGo8rafOcaXYgaqSlPVjpqxr8eF331sXZRf5FDY2+7rZ8LazWXDyNVJY207qn63AtXxiYqcisn2UqIk9YPVD5iuguaR8h0kquT6xIaG0/VNgBEsDTTGvK+EOrSz+yWFhtObdrXerWQV39o4ijaYtTK5xIfTo4QHa69n9HNdplj1XzaSGyEX+FUav4lPdKfQ8rwVcTp92oNc/3t1dmel1AG0Sl8Pw4p4unFC/mEMTaS06cEwpc2VTEtOTu5J0URtcxzrXxdZDLOzNID7zkjjHRTchC+6d9Ad7rxT8Sb4bWn61UAzjDCAMRnUDvT2uk8SKjTATuT2mFvPLBUaTSxaMZDK67vWUh2RTdVtRsrx3Av63IqmQpA+xQ33+udgWsS4yBMRbiG4r3lwG5DDKObRplEv1ZbwWhpjzgLoe3k3qMtH0FyE8n9HCBhDTY0rOC8krhz8ftcCEYA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L0yh/QK4fdNdFT90BV4Ur45RdiARMijcUZNGkby4IjyaSJ8eWJUFMl381N?=
 =?iso-8859-1?Q?/poFgE23zhov6EAXNKxvM8r8X+bDb6CPMPn3zJVNCQnlWfNhzCrsxCMmbd?=
 =?iso-8859-1?Q?1fm/WCxL4W0uLpiz62dET/3ooi2CWYHnKLFcb5DFhN0X4B4yPmrY8w9Vex?=
 =?iso-8859-1?Q?OhZjV+JNh+xhWjSQeBSjWgopKNt83pnn250sThhOcvS/ye9RfiTOTgrEaI?=
 =?iso-8859-1?Q?kUon679Pv7nZm9BF8f7C5jzViaNeSPIxE/GM/Atv5l1dghHhRJGNuz+xBV?=
 =?iso-8859-1?Q?5H1uQQ1HwVGqV4qUi1GAP+Fjq3S4cYSeOy1LKCFQPUfLMLmZJdb+u1tCjk?=
 =?iso-8859-1?Q?AGsGQAzDVQArrmee/xEpnQoMQnxPgv3xIfuKi6QQBKmA0CCHU0QsdZGKYe?=
 =?iso-8859-1?Q?odxR1U+LtyCjfq1DBoTrsgG3PxZ0JEZnVrLr3L0X13k8BWdfP5UaVwiajD?=
 =?iso-8859-1?Q?yiBaQD8Qz5ecgS1rbW/NE40d76u5WFgXUXC7wXkqVy/uqdzqOZW0BHhXRa?=
 =?iso-8859-1?Q?o/qj5kGbnJohD03bjkooCzZQRT6LN7iG0ZZ+pISgLpXp1CXDSkY8nKXhd7?=
 =?iso-8859-1?Q?27dSYdr+xfKpRralhf57Oq1pc8PRWyk7J6bNCl2sQoOW0lRVHOR6mmVjun?=
 =?iso-8859-1?Q?bl6kC8YqtBTVsjZPDU5RNjnZmaZRIA2zbOs/3A51f+s7tViRkb8YP4pZas?=
 =?iso-8859-1?Q?SZvWvS35WB0JnbbbkkhZAb+/DFXtbTX39NY0iOvxubSXuaFuXEeuhx7TdX?=
 =?iso-8859-1?Q?BT5gvhT3Sg7AYCcZfjNaVuAlATnIZC2+CSwQnFHG8VxhSh7bvqclKkYZBu?=
 =?iso-8859-1?Q?ASGl0YjTNUnktRVk6rJ6bQjOVu1UgcPrrPbNuCplsUoF7OgrS0imi9Py+H?=
 =?iso-8859-1?Q?69QhIUDQrZmnbE0FeAvXPVdBoiK4SED2twg+Lvz9IaDZF3A8mMxW10Y8qv?=
 =?iso-8859-1?Q?jcsUa0ngB6BpCl3mTEU9+MBeUFJ4whWGHnM8Azn07UnpiaWmWMfRwq4Aj7?=
 =?iso-8859-1?Q?CdIPIUB6sVgiS6LJz5QgKxOwcbtGuPLcNMUlr1/HCcaDFDI+KtpmJmkiWb?=
 =?iso-8859-1?Q?TXXI1KPKF0QUyIXRU6xwAdrb0rWHX6WGQ0JJW10+1XkheyiWWCFxbvbj0f?=
 =?iso-8859-1?Q?NQnsxC1KBPiAayiL2vuPl3FBNO8ZrnDCv6wpWrkEuULp4/G+rmbNCveRJh?=
 =?iso-8859-1?Q?U1l/YF1BgkT/RNUYS09yfeU3HtGYHGHRrrbbujw38GBbVW+oxluagOBADK?=
 =?iso-8859-1?Q?iSNXU2uWagYND9CjIQ34utu5ErUolhFgUd3RJZi8lt8ql91wvgzNfu9KNZ?=
 =?iso-8859-1?Q?2CK+Ve8wc7w3DximLWXmsfBTXhzRG+gA/1OYtLWpnW3y/9X0Eacd2M7gPy?=
 =?iso-8859-1?Q?po1aZtvDeaVONYETguQ/4D5emldq8DOuphWL9X0y5Ctvu4fEySvHLUWihf?=
 =?iso-8859-1?Q?VdTSzg6Vbzavr138zI8/Tjy6L8byoiWxnbvhFP6U5u02/s7pWL4114YNZk?=
 =?iso-8859-1?Q?gqwkAZeEfZY2avwEPcwm8R4wJF0Rga+EX3fY2WE/1quSobQPsGUqIVbWf8?=
 =?iso-8859-1?Q?JMGRW8G2lT0ngHjmkihUOxYP3MTzKAF453fFndPCGlEYaNBo8sdLabraZy?=
 =?iso-8859-1?Q?MHF+ZIZcsfQIOKUjmCzpZgCTr+8AL0QGtlJfXw0bBlIwoC4bnkZRVsqp31?=
 =?iso-8859-1?Q?5g8SrLPJfZHU1EIeB9biV+aWjs4L4XgUtcxH70DwqvOm6qJIgkIf1DoFfQ?=
 =?iso-8859-1?Q?gfzOEf3Itcan739SlFBLKG994COHbO44JXc01aRBZMpD+wDX290xMJXBgr?=
 =?iso-8859-1?Q?VtrAm5WngQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bj7OgpQBz6OgQfRYVv4UluVRxYHLxD4z2baP3MJf99sjC2pNSc5LIpK8HsVH1AwFB4l4CpJ3vLUw8iLSE6T6qr5uMCieIY6aOeAWeYX81yyEJZbqOyBgUCEjQq+HoFaJMlhOCp/enIXfDzukx5u9kjUvly/vGT0C5CbVx/FTI/c7zUaSv1B4VHfFiskUmEkRm9Qha6O7SEjpKbg522WAjNJ5I0dJX9pIJkg/IWBDNCwdolme9FUh1jTJk17qiAgvQn1qLESA/wjqr/++zvt7HXRoppanUHmZx99afVMPClm+taNJYnacUOjmj0b6mAMzpp9bvtFqvqhyfkQarmz5QQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5ff181-7c73-4fef-546c-08dea67925e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 05:27:19.0392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QF11tNyz3is3Wo4kSt99ppsYZaH5h309Gh8oKn7qYz690Q7VnMT2VI5H9mhqYy1aLGtbhVfw62lcoLXejXGIqxga14VZLd0iAMtB/Fz55Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6933
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Cedric,

> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
> handling with 'Error **' and err enum
>=20
> >>>>>>> Make the error handling more robust in
> >> virtio_gpu_init_udmabuf()
> >>>>>>> by introducing 'Error **' parameter to capture errors and using
> >>>>>>> an enum from VFIO to categorize different errors. This allows
> for
> >>>>>>> better error reporting and handling of errors from
> >>>>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >>>>>>>
> >>>>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>>>> Cc: Alex Williamson <alex@shazbot.org>
> >>>>>>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>>>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>>>> ---
> >>>>>>>      hw/display/virtio-gpu-dmabuf.c | 67
> >> +++++++++++++++++++++++--
> >>>> -----
> >>>>>> ----
> >>>>>>>      1 file changed, 45 insertions(+), 22 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
> >> gpu-
> >>>>>> dmabuf.c
> >>>>>>> index e35f7714a9..89aa487654 100644
> >>>>>>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>>>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>>>>>> @@ -18,6 +18,7 @@
> >>>>>>>      #include "ui/console.h"
> >>>>>>>      #include "hw/virtio/virtio-gpu.h"
> >>>>>>>      #include "hw/virtio/virtio-gpu-pixman.h"
> >>>>>>> +#include "hw/vfio/vfio-device.h"
> >>>>>>>      #include "trace.h"
> >>>>>>>      #include "system/ramblock.h"
> >>>>>>>      #include "system/hostmem.h"
> >>>>>>> @@ -27,16 +28,18 @@
> >>>>>>>      #include "standard-headers/linux/udmabuf.h"
> >>>>>>>      #include "standard-headers/drm/drm_fourcc.h"
> >>>>>>>
> >>>>>>> -static void virtio_gpu_create_udmabuf(struct
> >>>>>> virtio_gpu_simple_resource *res)
> >>>>>>> +static int virtio_gpu_create_udmabuf(struct
> >>>>>> virtio_gpu_simple_resource *res,
> >>>>>>> +                                     Error **errp)
> >>>>>>>      {
> >>>>>>>          g_autofree struct udmabuf_create_list *list =3D NULL;
> >>>>>>>          RAMBlock *rb;
> >>>>>>>          ram_addr_t offset;
> >>>>>>> -    int udmabuf, i;
> >>>>>>> +    int udmabuf, i, fd;
> >>>>>>>
> >>>>>>>          udmabuf =3D udmabuf_fd();
> >>>>>>>          if (udmabuf < 0) {
> >>>>>>> -        return;
> >>>>>>> +        error_setg(errp, "udmabuf device not available or
> >> enabled");
> >>>>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>>>>>
> >>>>>> The function virtio_gpu_create_udmabuf() is returning
> >>>> VFIO_DMABUF_*
> >>>>>> enum
> >>>>>> values, which is problematic because the function creates a
> >>>> udmabuf,
> >>>>>> not
> >>>>>> a VFIO dmabuf.
> >>>>>>
> >>>>>> This creates a layering violation. The virtio-gpu-dmabuf code
> >> (which
> >>>>>> handles both udmabuf and VFIO dmabuf creation) is using error
> >>>> codes
> >>>>>> defined in the VFIO-specific header.
> >>>>
> >>>> The rationale of using error codes is as follows:
> >>>>
> >>>>    > In that case, using it for udmabuf is cheating, but I think it'=
s
> fine
> >>>>    > since it's locally-contained in virtio-gpu-dmabuf.c, its intent=
 is
> >>>>    > still clear, and it has no adverse effect for users (at least t=
here
> >>>>    > will be no bug).
> >>>>
> >>>> https://lore.kernel.org/qemu-devel/becde56b-90bd-40ca-9329-
> >>>> 0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp/
> >>>>
> >>>>>>
> >>>>>> Please find another solution.
> >>>>> Other solutions I can think of are either move these error enums
> >> into
> >>>> virtio-gpu
> >>>>> (and disregard the error return type from vfio) or move them to
> >> some
> >>>> other header
> >>>>> where they are visible to both virtio-gpu and vfio. I'd like hear
> >>>> Akihiko's thoughts/
> >>>>> comments on how to proceed given that he had reviewed virtio-
> gpu
> >>>> patches in
> >>>>> this series.
> >>>>
> >>>> Disregarding the error conditions of VFIO is not OK. That can cause
> a
> >>>> guest error to be reported as a host error.
> >>>>
> >>>> I think the simplest alternative is just to have a duplicate enum fo=
r
> >>>> virtio-gpu.
> >>> That would address the layering violation but Cedric's other
> concern is
> >>> that he believes having errp is sufficient and using these error
> enums
> >> in
> >>> VFIO would be overkill.
> >>
> >> It would be beneficial to describe the rationale behind the enums;
> the
> >> patch message only says "better error reporting", which is quite
> >> insufficient.
> >>
> >> The rationale is that we need a special handling for the INVALID_IOV
> >> case. The INVALID_IOV case can happen in two cases:
> >> - The memory is backed by VFIO. It will result in the INVALID_IOV
> error
> >>     for the first attempt to use udmabuf, but this error can be
> properly
> >>     recovered by letting the VFIO code to create a DMA-BUF instead.
> >> - The memory is not backed by memfd nor VFIO. In this case, the
> error
> >>     is a guest's fault, so we should:
> >>     - Use qemu_log_mask(LOG_GUEST_ERROR, ...) instead of
> >>       error_report_err().
> >>     - Emit a message useful to diagnose the guest error, which we
> have
> >>       discussed in this thread.
> >>
> >> A common pattern is to return -errno to let the caller implement a
> >> special error handling, but in this case we specifically need to
> >> distinguish the INVALID_IOV case from the others and these enums
> are
> >> more convenient for this.
> > With the addition of the above rationale provided by Akihiko as to
> why these
> > enums are needed in VFIO, would this solution (having duplicate
> enums in
> > virtio-gpu that mimic VFIO's enums behavior to address layering
> violation)
> > be acceptable to you?
>=20
> If the new version of the series reintroduces the enums in VFIO,
> expect me to complain :) So, no error enum please.
The fundamental problem we are trying to address here is that there
is a real need to associate an error with either Guest or Host. And,
Err * does not help here because it does not provide any means to
distinguish Guest vs Host errors.

Furthermore, in the case of a Guest triggered error, we'd like to just
log it with qemu_log_mask() instead of printing it (which is the case
with Err *). And, in order to do all of this, there does not seem to be
a better/cleaner option than to introduce error enums in VFIO.

>=20
>=20
> May be the iov API is not adequate for this purpose :
>=20
>    int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
>                                     size_t total_size, Error **errp);
>    void *vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int
> iov_cnt,
>                                  size_t total_size, Error **errp);
>=20
> or the part validating the iov should be done before calling into
> VFIO:
That is mostly what the initial versions of this series did but as mentione=
d
by Akihiko we realized that doing it this way means we need to make
use of VFIO internals such as VFIODevice and VFIORegion outside of hw/vfio
which did not seem like a clean/elegant approach.

Thanks,
Vivek

>=20
>      if (iov_size(iov, iov_cnt) !=3D total_size) {
>          error_setg(errp, "Total size of iov does not match dmabuf size\n=
");
>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>      }
>=20
>      if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
>          return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>      }
>=20
>      for (i =3D 0; i < iov_cnt; i++) {
>          if (!vfio_region_lookup(iov[i].iov_base, &region,
>                                  first_rb, &offset, errp)) {
>              return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>          }
>      }
>=20
> Thanks,
>=20
> C.


