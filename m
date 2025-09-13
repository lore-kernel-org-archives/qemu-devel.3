Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CC7CAC582
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 02:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxGD9-0002JM-Bh; Fri, 12 Sep 2025 22:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGD7-0002J6-0U
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:41:57 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGD4-0005MN-0v
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757731314; x=1789267314;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ef1EAnecONTrOmI7Yu78LmkPZBP60O7Brl2ngKQIrRQ=;
 b=Mx1N+3xGmJ3Y2onlCzgkAUX7pHTGaJq4Z/mZtp3aTntDQFlDJQ+ZClsj
 2JflGrsQicdnhQgxxXC17lJq52tia8154TtEmROeC9Pqtw5eTaSfeyzIE
 WqMekmRsfagcBf05OcEyIl1QjWhsKRsci6xhXUSgqfR2A4H7eBhY8/zDP
 EMPJdbSkQQCcPUYSbgG+7XZr7OK49T1YfxRxZr8DBjdOvlYikl9VETXJn
 5KKDxIzOSJRF8VopluHF68n+T7chlrbGCZla1Pyamy9sN6L50xKEWwVG5
 +M2i0LDiAOQJetd21XAk6A9dWHojMCkJfm+xdCMwFuGTerG3MpCU7Mp+p Q==;
X-CSE-ConnectionGUID: XOKdfRO8Qsm3+isvylvraw==
X-CSE-MsgGUID: nGUflXvjRqKZpmFaSEOyWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="59940846"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; d="scan'208";a="59940846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:41:47 -0700
X-CSE-ConnectionGUID: BrfpstbwROK7qS4KXL2Hsw==
X-CSE-MsgGUID: 3E+nZPglSbi0E5Kl/IE8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; d="scan'208";a="205121778"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:41:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:41:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 19:41:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.79)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:41:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD/1TyKg6iAbe2dGl7aU+d7XTJhw2giLG94sj+c4ltnrnVyK9+srtecwrP2PaCq0vHBVZE5T+gwG9mEg9pR8RdW29d4v+1sKMY4ch71njn8Y1WDLwmB2F8vR7brLn1RvJ7E8rljihmTY9FmklcidPGCiaWuichEaa81fLeFpxVSDPvPPq92MEg8VXzxA9mqkYVgq0zckUmHIsAO98VWqDwRR+foAj7v02VXBYcYVJ877MjCaI8b6TaKDv30fucgwZs5kfUegjJxi7K2ECcr8/HDipmSI1BzJzLrlQXfPaAiOR0mLdo8Lg/Qz2pvGyMiqBUlX8YwvG+zCr+iGVaPZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXgkxgPeCG3U14KsbXyBxcVjUStr3LPioUx8yKZiabw=;
 b=PABOkB3izz17CsdFDiQfGfvzWh/iCCgaOvQ1XO0648fJ9GAI3/eXGEopqRUAjVoabrJSwsN4KfH+YSEQKV32hdHnyvkSU4b5wwawFFwVBQ58UGdShysvLycEAIEXRuZcevAT/I94v/zrxjxSEJZbPjGOdR8i1uCnhtddE/PFjIzWTtgyZNrDugF5Y4hUnKpddjI2OV3znaTNna/CaM5DsWy/F1iEkm/Jhn/ONfssRRK/FyEZ2tPCXf9l3/DL3ex2hqHqmBOgQ9GSe6erkdeEg6eb4mxbashQVysFg2KYIUZ2s3DCedZ4Sjx//guznToD1n9rWyvxUnqb5snuTCZhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA4PR11MB8916.namprd11.prod.outlook.com (2603:10b6:208:55e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 02:41:39 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 02:41:38 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [RFC 6/6] virtio-gpu: Find the host addr given gpa associated
 with a ram device
Thread-Topic: [RFC 6/6] virtio-gpu: Find the host addr given gpa associated
 with a ram device
Thread-Index: AQHcHJY313c9OKRAA0+QH/1agtVUkrSFkUGAgAqDS5A=
Date: Sat, 13 Sep 2025 02:41:38 +0000
Message-ID: <IA0PR11MB7185B923F5296FCFEF8ED198F80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-7-vivek.kasireddy@intel.com>
 <48689d16-1f88-4a56-8b48-b20923f92f2c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <48689d16-1f88-4a56-8b48-b20923f92f2c@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA4PR11MB8916:EE_
x-ms-office365-filtering-correlation-id: bd227d30-d0fd-48c0-9e7f-08ddf26f1087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0w3SqQE45sNIUn/+TqXJwrgZIzPbqeow14ZCQ2NcuI4xmPuxDqZOMOTcVg?=
 =?iso-8859-1?Q?Jsa4GSC+sIeHzfA1jgiASD0m7Zj82YNU43mSSJROb8W9O6w8itpk6yKSMe?=
 =?iso-8859-1?Q?3FB+pwhwSc4FI18IDtTbWEhMNXaqKtZ0fdls4yUAw5ovKfbVjX2GUUaa3B?=
 =?iso-8859-1?Q?Ii+aLVEc2ZIkjA4Q195i9f7JsHVQUZVoZRv4DxP+Rymri0TodZy6a5irCH?=
 =?iso-8859-1?Q?6rYrXgK563NC1plI5WuQcILFq2miGpCc3tLx2qYQJXq4oy7yYUXieWxSep?=
 =?iso-8859-1?Q?wdzYBP1t+lYfhYxxx3RwbMAVL2yhpTGsDO/09+OBJNugF6Kzp2pJbKrg8u?=
 =?iso-8859-1?Q?Ql5dw/FS5OZ+JyJ1kTwYnUq9XBR1SKP1rvh9uVFHYhvio1ogGtl3jdWmRK?=
 =?iso-8859-1?Q?Vo8nryLNLBkv/I+XvAnQsU4jRY9PIUpI97M43Sq2ofD1Kun3zLc6x1KZUH?=
 =?iso-8859-1?Q?54+JD2TTtC3LyA6NfkxXSmAf0o9yCH4iZuTK/wZkOv90iH+W3phuD6spWu?=
 =?iso-8859-1?Q?S4cDbWF0kdsXQjkT/GcGxWK0nhPy3trXiDcMrMRk3JW1IQp3W0bVZaYO3U?=
 =?iso-8859-1?Q?JnhmXl4d8jvn+WV/XSgta1OhS77J3Yk9NSw3SHTOWS9TAKZ59CymlxqMGJ?=
 =?iso-8859-1?Q?6e5vliV4hdecTU86mWRunTUcNTbVWxOAxQWAt0ekef1iQMJk/yRwK6Gi9I?=
 =?iso-8859-1?Q?lNoSJLSzivc33aR2DTZmvtUmBgg0N6QL57GwA1T5FsDJHXA6RH9TInl3ji?=
 =?iso-8859-1?Q?pVqpXiwnCLG9hqKojSLDvkdTi+XaY4rk7bkaNrwwiVaCZGU7bBNgJ5B4cq?=
 =?iso-8859-1?Q?xPluUJvf7z83C7uaJztHkpYsWh4AgVRF9OyoRdsB+V4XBShVj2LTmGJxhE?=
 =?iso-8859-1?Q?AmJmSwwi0Knx9/FWnor4BpVEo0X8BzPm96rstHh2Ff12wXfHE6riXGpKww?=
 =?iso-8859-1?Q?fmhuLnkgHdZDvmfiEGYpjZcQdS4W4mWtpnzZ8hel99UdUYpYbYL8Z7m4Y/?=
 =?iso-8859-1?Q?5ErKL/PKMsyF3JnFNdchMYmsBvjQnwWehNr9QQ8XpZUQqb7hUhTxLmySoI?=
 =?iso-8859-1?Q?2IONeTF3cM3DthBI+K7AI6VcNxtwE7T5Csv7OytddHYKq5guASOQAt7ynf?=
 =?iso-8859-1?Q?lAT+oHrqJus4Y5y4oE09VZ9fCwM12J/dyjtZM6msb9Yc6hIV3G6PiZSkmb?=
 =?iso-8859-1?Q?h8kkCpTsqhunboFuPdEJmy4zEwRCZS+sl3Ty/EpfmAFy16ito6P0EpvvSX?=
 =?iso-8859-1?Q?gOvlkDzFBhXqjKb9R0SRGPtjuUPimbA2+X0F+pzNf/i2Z0RsP+J7wfnPBk?=
 =?iso-8859-1?Q?xbQN3Tx6oCme8hl4VHsySbSm/KcPFxJm1DIqtRFO6arViGSxYseRfvBU0V?=
 =?iso-8859-1?Q?FnNf1oKZJdb7GyB5vtNQppMk3SusiOvvYD+mfDS9mX4Tzly3fhMyKBcar7?=
 =?iso-8859-1?Q?ahYbn/F79N/Wh04zsJHbG/UTJzV57Zfnw4EWGTk8rHA8kss/sr0SllJBR8?=
 =?iso-8859-1?Q?6drtjMs2X/WIMp+hpmX/djenhrXG3o7RSQFK8BOhAgOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lpLqO6aDDaTuM0gCGUHGpUO8sGptNT7f1Yw9QEArAjWgCSIFS7qqYWILnf?=
 =?iso-8859-1?Q?1Yh2XEGadp+TX8j3aL8G3b9MUURK5OJLNf9WGo5aluUTDLHs4HxvzMA7yj?=
 =?iso-8859-1?Q?cFtsRoaKdUECWvSBRSnxhvk6JM1XSit4oTCD8f9D9B3URrrSDxhOkzeckZ?=
 =?iso-8859-1?Q?DLltEDSftzJhRu35P4/eJxc9aTaPtdRL7rvyKPh4S34WjSVKUlsnwGCqwz?=
 =?iso-8859-1?Q?WElHMWvR6BbRjTQ6eHTojM9A9Sa/Xoe3Q8jDAQmSUHyX7Gy0gAb5H3QU/4?=
 =?iso-8859-1?Q?cebug8uCOnwwSN8D41efJZThzlHRexo8Oq6dpwEc2/RM42Z4J56IAX5FIG?=
 =?iso-8859-1?Q?uDaA6ZBaGYn5LTJhVimV5aSXe/5AFWqahC/U12VRFOQH3kvhCOxsgBlF8p?=
 =?iso-8859-1?Q?0G5KhBb8f/CAU8UaKCKjMT0uyA6LXFWsRsvs336nxWYPhk9R3cTfEYorpC?=
 =?iso-8859-1?Q?lKy+l8sdARWWPVX4becxuwO+7rZSYpaPlZXc522zff4/NcDO3gF/lTc60G?=
 =?iso-8859-1?Q?JfDes5Rz8smAyEZUu18jDRqoiiCxktyZO8GACjSjDEcMgH/SLafkKTTvu2?=
 =?iso-8859-1?Q?8K0wQ3/OVd+WDQAvP3+GsmkSjGgmoGLR6QiOxnxkjasmeYqz9w1q7aNSUM?=
 =?iso-8859-1?Q?1N6HVdK9PCJL5Dqkxf+jwrNjlzaiRTSCwMRgk8Ed3yzFwxRuSyxvZuewEK?=
 =?iso-8859-1?Q?6m9PBIS+yN1d/iKPPXM0zzXmPQo5mCAvD6SByOoqD1z3cdYGuKc3maoJaW?=
 =?iso-8859-1?Q?AVG4ggU3fSwNDYJVVMDoYm2vaSApK4tO/Bx30rxsr8Q7qM2sVaQF50jVRR?=
 =?iso-8859-1?Q?kcV6aZ0S7wpkYhOzVs5lFAZyBYcGIGboqTES2zMTNJHdtORGiZxIpynxF3?=
 =?iso-8859-1?Q?E4t/HYnMJWMiFZoDslOgtQ5M9sRnbznNVdBPV3O6XguF4k7RXnStXsya3v?=
 =?iso-8859-1?Q?cePRIir8wRer+mB6LfLPpsZa362terdMT+w5tyLHpxqsPOP3JZpfZxgqq2?=
 =?iso-8859-1?Q?cLxcSFqF2tjZ6n8ewBeWal6Q0nYs34402UulO96PCwdIWUQGA0pvGrpQaM?=
 =?iso-8859-1?Q?NtGA6FGIDNfXD2b5+K25VET4MW5qrzHbX1fxmRrJbAeE19WXvqlY8Qxmef?=
 =?iso-8859-1?Q?y3I+FJM923dVjUt3py1DBOXYO/4qeopVgj4S8IZ72g2IgTuD/Oi8btTDe9?=
 =?iso-8859-1?Q?a9MBo8qeCasl1KnbbQ7fjKv/GAuPno5EzZpZMw/8DRGhjYqvnhZEiUqtec?=
 =?iso-8859-1?Q?2n+PkpmmywFBoHhCHlYL0F8y9T0T4wqxWG0IunLOv5Op4q9/KS2CACHcXC?=
 =?iso-8859-1?Q?AdMZwnHWCaNUbUr6Sd7i1nQY4HwaWjpOSjkVLoWaE9zPT4Pl7NUPHG/Tgi?=
 =?iso-8859-1?Q?LYy0f0xwIABBTsYvjtPbvdTS9Jba2MZkEpTsafb8IpHhWviXoYoa+DIYeF?=
 =?iso-8859-1?Q?gXWhYSpf6psT0P+d/aiaQBjfPALdocRQlCm/4jVR7pPuvvNpf/eXPoU3/y?=
 =?iso-8859-1?Q?0JGEWcCxNpaqC6omvc68qwIwnYLakavZecntEhfPI/gUYZimD7JaqompTu?=
 =?iso-8859-1?Q?vVyU5ET82EoyAqjK0pK7RrLAp2f+GKRp7JctzChal0UWikrmxAExTxnrMu?=
 =?iso-8859-1?Q?PJL1UI+s0IcLvTkkulvhbGrwbK5l9A7DKt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd227d30-d0fd-48c0-9e7f-08ddf26f1087
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2025 02:41:38.8697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnTJohG8hfloFgRsoXgHuJDA6Mv7CyUN7JQsZ/n98rnsyWX8TFlhjgaHkzacAvHrJVuEiIiD0ro6lRzPGfBeR8KC2AueRdeu40h50gqiuqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8916
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Akihiko,

> Subject: Re: [RFC 6/6] virtio-gpu: Find the host addr given gpa associate=
d
> with a ram device
>=20
> > If the Guest provides a gpa (guest physical address) associated with
> > a PCI region, then we can obtain the hva (host virtual address) via
> > gpa2hva() API instead of dma_memory_map(). Note that we would still
> > call dma_memory_unmap() (to unref mr) regardless of how we obtained
> > the hva.
>=20
> I think address_space_translate() should be used instead. The guest
> passes addresses that are valid in the DMA address space, which may not
> be a GPA if an IOMMU is in effect. address_space_translate() allows you
> specifying the DMA address space.
Thank you for your suggestion. Looks like address_space_translate() followe=
d
by memory_region_get_ram_ptr() also makes it work and is much cleaner. I'll
include this change in the next version.

>=20
> The motivation for this change should also be described in the patch
> message; otherwise a reader may wonder why dma_memory_map() does
> not
> suffice.
Sure, I'll improve the commit message to explain why dma_memory_map()
does not work in this case.

>=20
> While I added comments for each patch, the overall implementation
> direction of this series looks good to me.
Thank you for taking a look!

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 35 ++++++++++++++++++++++++++++++++---
> >   1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 1654a417b8..4af8390bb5 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -32,6 +32,7 @@
> >   #include "qemu/module.h"
> >   #include "qapi/error.h"
> >   #include "qemu/error-report.h"
> > +#include "monitor/monitor.h"
> >
> >   #define VIRTIO_GPU_VM_VERSION 1
> >
> > @@ -799,6 +800,36 @@ static void
> virtio_gpu_set_scanout_blob(VirtIOGPU *g,
> >                                 &fb, res, &ss.r, &cmd->error);
> >   }
> >
> > +static void *map_gpa2hva(VirtIOGPU *g,
> > +                         struct virtio_gpu_ctrl_command *cmd,
> > +                         uint64_t gpa, hwaddr *len)
> > +{
> > +    MemoryRegion *mr =3D NULL;
> > +    Error *errp =3D NULL;
> > +    void *map;
> > +
> > +    if (cmd->cmd_hdr.type !=3D
> VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB) {
> > +        return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, gpa, len,
> > +                              DMA_DIRECTION_TO_DEVICE,
> > +                              MEMTXATTRS_UNSPECIFIED);
> > +    }
> > +
> > +    map =3D gpa2hva(&mr, gpa, 1, &errp);
> > +    if (errp) {
> > +        error_report_err(errp);
> > +        return NULL;
> > +    }
> > +
> > +    if (!memory_region_is_ram_device(mr)) {
> > +        memory_region_unref(mr);
> > +        map =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as, gpa, len,
> > +                             DMA_DIRECTION_TO_DEVICE,
> > +                             MEMTXATTRS_UNSPECIFIED);
> > +    }
> > +
> > +    return map;
> > +}
> > +
> >   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >                                     uint32_t nr_entries, uint32_t offse=
t,
> >                                     struct virtio_gpu_ctrl_command *cmd=
,
> > @@ -840,9 +871,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >
> >           do {
> >               len =3D l;
> > -            map =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
> > -                                 DMA_DIRECTION_TO_DEVICE,
> > -                                 MEMTXATTRS_UNSPECIFIED);
> > +            map =3D map_gpa2hva(g, cmd, a, &len);
> >               if (!map) {
> >                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMI=
O
> memory for"
> >                                 " element %d\n", __func__, e);


