Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBE1FEA80A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5GqL-0004Iv-CM; Wed, 25 Mar 2026 01:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5GqF-0004I3-Ax
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:31:43 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5GqC-0002y9-EX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774416701; x=1805952701;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gSfm4b6LjDZahCR5jOmd8Kp5Mw5zxaSPNw3UO4eUU28=;
 b=hgymNICZns2AW7Ha7Q1cdUbn3bry625P5yJksvANni3kDHGGgYg4INLT
 yC28R9If3MZyLz3fhUWX+6XmAbJ3l+lQD2EdfzDWTBCsJT/bIOHcfml1o
 ZWKIGoABl7uklUHDKbvX/xdke4ekXZgmjfQ9M7Qf//rZujMm4nJ8sBkZS
 5Jobm+WuPI+zYL0aZkqIKBlzEYCu3ocRHIRDz/5s0jAD2WB+G2RVRnEGL
 n7+24a1plJWT0AzSsoDXthUjViIdWFRvNsHyLtpDp63ICG+5Xz8RggeVI
 O6+iKw1hMsAFZjAwysQKnaQZrLgnx11R5BS+8gvCWv1kD53A0QLofuJbo g==;
X-CSE-ConnectionGUID: WFmsUcn2TQST6k/dFKQLrg==
X-CSE-MsgGUID: UUpvPsmcSO+q/iDY44uLoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75330553"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="75330553"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 22:31:39 -0700
X-CSE-ConnectionGUID: gi9jt1icT1SetGY5PBP1nQ==
X-CSE-MsgGUID: G7fPBO3UTTmYe/4gQYQBCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="224525966"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 22:31:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 22:31:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 22:31:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 22:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpLsQ1w0pq+9uD936YtMHrgCuTMknBBqj7Re+D5Twoj3Ivds6sL9/rRtMFKY3bTvxFX7ZflcgtFJLWDvC2R7gL2TgfVsgowXQyBehcPPYV7/3zAlcbh9oo8D2UtGmBf1Gvin/OPOjooxE8K9A2oYBSAClz5DYzNe6vNx9VULA445q5O1VrMVSWk/qtgy57j5JCTQp1weMsdMroBF8LBtJNaHsx+g/n30+rTUU14licC2RaKWnz2Mh6W6bvulpJeUGoClk+4Q2R4kz/dydPdQOGoVt/mBxmoIe020hu4WNnWMzNV11yJvBXYO07S/J7w+nP0E+Bq+PUkfBKxSToquRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVH2l+uhZ4CRaUH1bGu535FEj5Bqy30rSGEdTjRMk9Y=;
 b=GeeBFYNhSfUrmkUOBycNKOCbDeBf1K9nFMJasH4ltOQhibPZlssAdw/JrVcp0GSCeNQZuFXfBUMsMU91Z7SjfVsHeKyhDgd9cbj64vaHd/nSLN4tV+AEvI+sd2ofOcWjcW3sLVzt0Pq2ONKtbBK/BmDXb8EwNjg0NN08Z08Hdp2IuetugIkuh7nUGTki4BCtjPLOXaGrw436X6seOXMfFpXuzYz1zYyrT0eZ2encb3uGBObAlj+OmWLDRfURvbhVhZjFhDCoS099lAK6Xs/nlKjHD9vuv1AGf3ciyl4DTFjSe27QWjy14Cw/54Ns7svAP97N1n7bImRfa46if9VC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 05:31:30 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 05:31:30 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHct2CBd1EkLKy70EmTrlWjg/HgLrW8bKeAgAANlYCAAO/SgIAAuJ2g
Date: Wed, 25 Mar 2026 05:31:29 +0000
Message-ID: <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
 <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB7015:EE_
x-ms-office365-filtering-correlation-id: 4d047730-4336-480f-e9ec-08de8a2fc4a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 7OZ9vBJlgaqLskXas17Bo4eAss2jfLdh1ONKIsIJ8ekJ+H+rtOiYaah2hLlW/B1pDG7z5RrcDoVctDe4XHjUIWSVxzE7eAZAUXO+E4PzlB+CNASCs9HV/TuZOmRFut3r9bGbXH89hA8ubMT2AQME1WZ/vqP3zGMPPwG2R/pduAHgcg6B1Hgo3y+aZcS6Cfgxa4xEiJ2PmJQoGx/f1Cv3Cl+rBYXM21H/UJ9TNDEgGtV8w0KvbGwk5UMLPakDzY4jDPssVNKPrKlVxIpjL8fC/+cBvBPk4kZtBPn6L4Dd6oLFsHNM9w7SWr5fm7P3G38uk68fEBdWYxLWyX/E3WURbcHKr92pmc1Ytk/Cfu+oFz6CQ2uum95UihwP/38ZfKAJdiwkOnxgV6XyPRBJoWz/hDCFHLN3lA6f1cQpWud7aqKjTBoJPTR7E77ghBlw1jLlZvMpILcgubuOdF5bzQrr56G66khQKw8WSsWfrBXBcPRrsdrWxdDxHsN3i5C+VYdIE/MupQd1+f1QorfMWtj7YGcWDZxWLq0I3JBHHRUDxVu4eM6TsrW6F1cSp3jKttZmbdlSBnbw4DkFhnlPWhhyzqPLEdheHMizIYpk0ZHf/WeSxQ19igii5gLr8getU7mkb7QrVuEwrq9oqbo1ccQmYkgmIJrdevT3TY3Bn8BX5e9VC3cy55bIpjGVBdXfkj1CXwcAvDU8MB0mb+RUtF3ZRUkHzHw3fZG7H2OsQBxgjsqeDjAN4iIwuw722yHBfUkY8o6bJL/m2XQGWqqrx0f5uT/c1/6HJXSy7MrpwPWNIws=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k7n5LWjJ4XjOSX+yTJaNcFuxhFF03yN4D+o8nwHpp/R/RReYwjLBFhGv3Q?=
 =?iso-8859-1?Q?tk0t5A1ClQlF/AfI4U2xfkbz2kIIghhWM86O74LpTV/sSifkcv5i6MYFNI?=
 =?iso-8859-1?Q?NsF/MPmMfH3pgPeHyN0ibszbSMrOVDV/t+idXcgGpQDc3FB7hTs3tooFni?=
 =?iso-8859-1?Q?e+d4rOAL3m3HXFpdCHT2/6yqN8mjMN5dtNOyeulHO9w6Qvr/FsBN0O4mWU?=
 =?iso-8859-1?Q?aLw/RU7d09Gf7BwfiqaJAn9d/JiiUU7eKZSc3fIjx/kkoC8JwnpKNhkjVW?=
 =?iso-8859-1?Q?J646Ux/jWa1cAko/mWy7dXhuz2FUMjbZrwu3g5yKo39iJlwyGQ6H3ouun6?=
 =?iso-8859-1?Q?b2W3kpTOapVhN7QB3r2NJkVs+/nOhEPlI5EdWzUHt3qQDkm72K3mG1wbG5?=
 =?iso-8859-1?Q?MjO6MZcRsXjkpQAExGHnn6W1+2j297xs/XADwEoSMW6uOKwNZt+upemrs0?=
 =?iso-8859-1?Q?26/xWZqmae2prWDxwdG2/8Y3KpbU+/cMfx7AVuli8ExQPM91P95TqSl97b?=
 =?iso-8859-1?Q?PnhllkMdsB/RMwHdyCov4sN/39w1cAZyXglxVyFPZSSYbtTw3vDj0Id1h3?=
 =?iso-8859-1?Q?qi5lTxOWx+XxnULo7R/L09AdB5XcqISyi8X+nOCBlc0wTJPbEGJie5z/p0?=
 =?iso-8859-1?Q?h0hmGQk3vIkLgZ9hLepCmJQSFASUxg7hc+NjafQTS7EUqt5nwWGtyld7Ay?=
 =?iso-8859-1?Q?vWzniRX3Bl9Odi+3gx7+1e/N/JnSdPoun1mkmc3G+U4A84zN/l7qVVjaj9?=
 =?iso-8859-1?Q?fbtlLNbo1XYxJLZfNXdl4Ov4fhKNZB5HsPynPqLF9bpiTBowrFTKO/eQIL?=
 =?iso-8859-1?Q?IyaCeEt/ysPnA+EGZ9OF/8yRrGNwvePJ1fHnlHQz7KeUVulmR06+Fc2Sdl?=
 =?iso-8859-1?Q?/qc1vGcUMyRl+jh+FqtmBxF5tKVnGMogz3nD6vewrrOePqwV9Of3RNsQga?=
 =?iso-8859-1?Q?qrteUDSiX6a/Ynanb5lI/kJslZ8/gqe9T9DVzDw3HeLIKlxn0ZFxzo6rOs?=
 =?iso-8859-1?Q?E1V3fVAkN7GulZMTC7VANerF8vzqGSOpZteis6cggSd4j8vlVFZRNxq8N6?=
 =?iso-8859-1?Q?XCJaVdHH5XmEUy4OeVHIkcCF3g7H1syOPlZZXfJwCC/YImWKzZkSFSAFjN?=
 =?iso-8859-1?Q?BcMrAHsVoxa2MQmS0Yo82vM8XjpytvzzMFxp4Dzgc9kPBNIqIOjTBuBKnA?=
 =?iso-8859-1?Q?O86rupJVRxxeN/m4TEiu4FPkfKUaeKmxQzNX1PNSGbcoMBwFHFh+L8Hkzx?=
 =?iso-8859-1?Q?stlOizOcEFjbVr2X7mHzpVRnCgqBW7EbwX8S1EL4OgvqpaWxyGFMkAiDiK?=
 =?iso-8859-1?Q?5neS68i+xzaKxYwS2+wgsr1TvNRobVsc07dLHfFs62jGjEt91HUOdZgvmN?=
 =?iso-8859-1?Q?xRUIsQn7XWORKf9XtBedUxqO+XcSivxTEtkk3IWOozjs/c9F2sjwjqluQG?=
 =?iso-8859-1?Q?FmSunxc7bGMyT7hDnb5hiuDXlgXx70wHr9spnAUzSJNE7HM5XoG2HzVbZM?=
 =?iso-8859-1?Q?7s8Yx3qudVg+kT0xChqNL2Z6uLGp/aiK2GiGUnw7t4SQtPHNfvo5fJFw8f?=
 =?iso-8859-1?Q?//tWBItcSEHZLDGY2GTtylnAxzqOG3zX9wp3t4SfsQ6sbvyh9Yv+7wVl74?=
 =?iso-8859-1?Q?XinRmoKJXItgO+KrJCMb6K+0bxUfBtA7tV9YbyfmvCduFv4IN1i6WvH/nM?=
 =?iso-8859-1?Q?ZVLp58YFP81q631Yh6+PX1Yt+9nv2BnEG2c9A/YYw0GlEOomHdrptcJpCw?=
 =?iso-8859-1?Q?MIc1D2PBAbJPJHXiI2jE9sDYZAubhxzCiSbjRFpHAM3wWJzAwogCQhmjAE?=
 =?iso-8859-1?Q?9sAm3pdmuA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZjRvt29iVw+nXzBNwauwIP8l5lvwPlhJP1qu6LM2HdZp+wE8SDNFxr2Sj+7TAM48n6/MF8LcpWUpGLiMPynJFy050pytdg1308LZZ6B1ha/AthWiEh7Q1JS1wNwTCCuGUzKyEGi7Et2NoQfsG7J8xnhye4vnG63YKz6HnAedUFoC0tgrBde/fsULUMRBJ+QZEYxDOCANyaH4sS3LLWdqLybe6VMOX6BUR7IKlxNWDutWLtVgIc92gwc3SGlJr9ZOdWju1FQ4JDOJkt76T8aNrm3KbqF00VPBZqz+Aizvf3+ymSVrH0jrcGCuK3535FY7XVxvhqrBGcbyUcB/zw05cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d047730-4336-480f-e9ec-08de8a2fc4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 05:31:29.9636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOrbpUu0DBzmr+Sp5EgNAIoiva5ILuAtyfUhkby7t5zVDVDACZMF7wBj6bMxavhXhrpOTBZL70/lA9kbz4FMXv5h01on3Mj9vpJQ1Uw/K+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Akihiko,

> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
> handling with 'Error **' and err enum
> >>
> >> On 3/19/26 06:15, Vivek Kasireddy wrote:
> >>> Make the error handling more robust in virtio_gpu_init_udmabuf()
> >>> by introducing 'Error **' parameter to capture errors and using
> >>> an enum from VFIO to categorize different errors. This allows for
> >>> better error reporting and handling of errors from
> >>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu-dmabuf.c | 67 +++++++++++++++++++++++--
> -----
> >> ----
> >>>    1 file changed, 45 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index e35f7714a9..89aa487654 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -18,6 +18,7 @@
> >>>    #include "ui/console.h"
> >>>    #include "hw/virtio/virtio-gpu.h"
> >>>    #include "hw/virtio/virtio-gpu-pixman.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>>    #include "trace.h"
> >>>    #include "system/ramblock.h"
> >>>    #include "system/hostmem.h"
> >>> @@ -27,16 +28,18 @@
> >>>    #include "standard-headers/linux/udmabuf.h"
> >>>    #include "standard-headers/drm/drm_fourcc.h"
> >>>
> >>> -static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> +static int virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>> +                                     Error **errp)
> >>>    {
> >>>        g_autofree struct udmabuf_create_list *list =3D NULL;
> >>>        RAMBlock *rb;
> >>>        ram_addr_t offset;
> >>> -    int udmabuf, i;
> >>> +    int udmabuf, i, fd;
> >>>
> >>>        udmabuf =3D udmabuf_fd();
> >>>        if (udmabuf < 0) {
> >>> -        return;
> >>> +        error_setg(errp, "udmabuf device not available or enabled");
> >>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>
> >> The function virtio_gpu_create_udmabuf() is returning
> VFIO_DMABUF_*
> >> enum
> >> values, which is problematic because the function creates a
> udmabuf,
> >> not
> >> a VFIO dmabuf.
> >>
> >> This creates a layering violation. The virtio-gpu-dmabuf code (which
> >> handles both udmabuf and VFIO dmabuf creation) is using error
> codes
> >> defined in the VFIO-specific header.
>=20
> The rationale of using error codes is as follows:
>=20
>  > In that case, using it for udmabuf is cheating, but I think it's fine
>  > since it's locally-contained in virtio-gpu-dmabuf.c, its intent is
>  > still clear, and it has no adverse effect for users (at least there
>  > will be no bug).
>=20
> https://lore.kernel.org/qemu-devel/becde56b-90bd-40ca-9329-
> 0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp/
>=20
> >>
> >> Please find another solution.
> > Other solutions I can think of are either move these error enums into
> virtio-gpu
> > (and disregard the error return type from vfio) or move them to some
> other header
> > where they are visible to both virtio-gpu and vfio. I'd like hear
> Akihiko's thoughts/
> > comments on how to proceed given that he had reviewed virtio-gpu
> patches in
> > this series.
>=20
> Disregarding the error conditions of VFIO is not OK. That can cause a
> guest error to be reported as a host error.
>=20
> I think the simplest alternative is just to have a duplicate enum for
> virtio-gpu.
That would address the layering violation but Cedric's other concern is
that he believes having errp is sufficient and using these error enums in
VFIO would be overkill.

Thanks,
Vivek
>=20
> >
> >>
> >>
> >>
> >>>        }
> >>>
> >>>        list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> >>> @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>        for (i =3D 0; i < res->iov_cnt; i++) {
> >>>            rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, fals=
e,
> >> &offset);
> >>>            if (!rb || rb->fd < 0) {
> >>> -            return;
> >>> +            error_setg(errp, "IOV memory address incompatible with
> >> udmabuf ");
> >>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>>            }
> >>>
> >>>            list->list[i].memfd  =3D rb->fd;
> >>> @@ -56,22 +60,28 @@ static void
> virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>        list->count =3D res->iov_cnt;
> >>>        list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >>>
> >>> -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>> -    if (res->dmabuf_fd < 0) {
> >>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> >>> -                    strerror(errno));
> >>> +    fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>> +    if (fd < 0) {
> >>> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> >> failed");
> >>> +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> >>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>> +        }
> >>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>>        }
> >>> +    return fd;
> >>>    }
> >>>
> >>> -static void virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> +static void *virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>> +                                     Error **errp)
> >>>    {
> >>> -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>> -                         MAP_SHARED, res->dmabuf_fd, 0);
> >>> -    if (res->remapped =3D=3D MAP_FAILED) {
> >>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> >>> -                    strerror(errno));
> >>> -        res->remapped =3D NULL;
> >>> +    void *map;
> >>> +
> >>> +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> >> res->dmabuf_fd, 0);
> >>> +    if (map =3D=3D MAP_FAILED) {
> >>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>> +        return NULL;
> >>>        }
> >>> +    return map;
> >>>    }
> >>>
> >>>    static void virtio_gpu_destroy_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> @@ -125,22 +135,35 @@ bool virtio_gpu_have_udmabuf(void)
> >>>
> >>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> *res)
> >>>    {
> >>> +    Error *local_err =3D NULL;
> >>>        void *pdata =3D NULL;
> >>>
> >>> -    res->dmabuf_fd =3D -1;
> >>>        if (res->iov_cnt =3D=3D 1 &&
> >>>            res->iov[0].iov_len < 4096) {
> >>> +        res->dmabuf_fd =3D -1;
> >>>            pdata =3D res->iov[0].iov_base;
> >>>        } else {
> >>> -        virtio_gpu_create_udmabuf(res);
> >>> +        res->dmabuf_fd =3D virtio_gpu_create_udmabuf(res,
> &local_err);
> >>> +        if (res->dmabuf_fd =3D=3D
> >> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>> +            error_free_or_abort(&local_err);
> >>
> >> Why not report the error in the QEMU log below ?
> > I think the idea is that in the case of INVALID_IOV error, it is suffic=
ient
> > to just report that the Guest passed in incompatible memory
> addresses.
> > But I guess we could also just do:
> > qemu_log_mask(LOG_GUEST_ERROR, "%s\n",
> error_get_pretty(local_err));
>=20
> The error message may not be useful. e.g., "UDMABUF_CREATE_LIST:
> ioctl
> failed" does not tell what error the guest made and how to fix it.
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >>
> >>> +
> >>> +            qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                          "Cannot create dmabuf: incompatible memory=
\n");
> >>> +            return;
> >>> +        } else if (res->dmabuf_fd >=3D 0) {
> >>> +            pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >>> +            if (!pdata) {
> >>> +                virtio_gpu_destroy_dmabuf(res);
> >>> +            }
> >>> +        } else {
> >>> +            res->dmabuf_fd =3D -1;
> >>> +        }
> >>> +
> >>>            if (res->dmabuf_fd < 0) {
> >>> +            error_report_err(local_err);
> >>>                return;
> >>>            }
> >>> -        virtio_gpu_remap_dmabuf(res);
> >>> -        if (!res->remapped) {
> >>> -            return;
> >>> -        }
> >>> -        pdata =3D res->remapped;
> >>> +        res->remapped =3D pdata;
> >>>        }
> >>>
> >>>        res->blob =3D pdata;
> >


