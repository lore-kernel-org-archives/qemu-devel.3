Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCABCF64BC
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 05:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLxCd-0004lW-AJ; Thu, 20 Nov 2025 00:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liang1.yang@intel.com>)
 id 1vLv6L-0001H6-Qr; Wed, 19 Nov 2025 22:12:55 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liang1.yang@intel.com>)
 id 1vLv6H-0000cl-Jz; Wed, 19 Nov 2025 22:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763608370; x=1795144370;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=DusaNF6bxXc1JFVY/EFPCLDvoM3cdrQ7mCNKtoGpxhk=;
 b=HSiI0f1MOAePvgcwueXi9qjHEOb7xFJE+8CHB9n5kb+RC8Heai+6XhJY
 R80WeGFHTtM71Jpih1fSZe4Wj0Ql679IoX77yGzaVjzCe4cN+EvoXcxdf
 zRbBUrGG3VrURmYWpfwhq55n+di5fRtIuuiGqvSkk2LmNAAdfPrY/j2lD
 ltJMYKpeGEhtwWVh0wdSWfCzpOe9BWAcVbmZAawgJ8DTwa3ZKnJeZcYu1
 RgkpwJ+MDAQTa14Cb72WbTOtsWe4Ixcb/++GkWDEsC5J0/gTor2HRuR2f
 REQuquv6kFev/TFaqDa8l3RMr3dl0MGHzm7KtWN03BG6w5zVxtZZXJe5F g==;
X-CSE-ConnectionGUID: yiSH74ZkShiDY2QwZWlpOw==
X-CSE-MsgGUID: CfzvT2YuRByN1FPL+R7ZBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65597236"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208,217";a="65597236"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 19:12:41 -0800
X-CSE-ConnectionGUID: /EXcZH6AQd6rfl0CQLD7lw==
X-CSE-MsgGUID: I9O2JyapQdqijCAoy8+C8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
 d="scan'208,217";a="196196024"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 19:12:40 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 19:12:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 19:12:39 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 19:12:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlkWOgavUQo1ixOj7RyTh2VgJXetnjIgG/UPPdwkLC714Lq3biT/PXwN+rSPsMoJZKUvyjjzT99L90Q1nMi51oTadrh4YWSqb0P0CLB/HF5PSrth6nX06Hnu4p5dkq4ApDk3Q+TGOqCtxseOpsYx2zmVQba67JWhTJW1vkbrshMHQ7w8k/b2Fn5zDCTW3UZ9unPteG/B7Ju1zBQIUpQ35GVg2m/CjjYKPYPzEPtvh8lwksZH92lO+yuRwR0Q8ROxEUhzD5cSRneic1i1ARy4ndcdxkuDP1+GzppkjYfNQTMbc/mH/WvuMme88SJONxln0+1HH/8z+8vDDwN6IDku9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+GCBAkgI/l4dysuKRXx6+vx0Zl0jKMY1ZVZq6ppOjc=;
 b=gtRh3e341D34OOVFZEbdIZTZ3xQvn7IZkh4a9bVlw6oDnQzS6pt119YDI5P/mMrrD9bcurNvmX7veaWHcooysPu0r+Or3G0GxGvYPeclLjcFz0EOlwDFN30yWANQIBQlorwYdtxchWJ01y8uG48e0nOhLsJhAq8ZlTXyenwiD2KVe6X8V0z0aEvZS4Crnwhvw8/nE/tLUzFQWXb2KYwaq6CZ/7DG+VTImMfngySAt2wkmg1QPjPOVMD00a6/LkHK3kKJawuW4hBl9BVB0mI9a0w8WUH7P1eqj6oWVYEFp45q7UuqqVX6OwRr/k2WpyoyCotYQuSASNIaCayiHsFgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 by MW4PR11MB6761.namprd11.prod.outlook.com (2603:10b6:303:20d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:12:30 +0000
Received: from MW4PR11MB8291.namprd11.prod.outlook.com
 ([fe80::fd81:328b:63fd:46f6]) by MW4PR11MB8291.namprd11.prod.outlook.com
 ([fe80::fd81:328b:63fd:46f6%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 03:12:30 +0000
From: "Yang, Liang1" <liang1.yang@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: [PATCH] hw/usb/host-libusb: Do not assert when detects invalid
 altsetting
Thread-Topic: [PATCH] hw/usb/host-libusb: Do not assert when detects invalid
 altsetting
Thread-Index: AdxZGlhBGy6gfZiISI+dbcvBgm7OFg==
Date: Thu, 20 Nov 2025 03:12:30 +0000
Message-ID: <MW4PR11MB8291BDD718BE9BB5A160C839ACD4A@MW4PR11MB8291.namprd11.prod.outlook.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB8291:EE_|MW4PR11MB6761:EE_
x-ms-office365-filtering-correlation-id: fb5ccf9d-cc55-49cc-9322-08de27e2a445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vbnvyJNj8l0bpDW2wQXj6hqfgrb/iSqlBtGxQNMviT2yvCeQvkjzEBOky3eu?=
 =?us-ascii?Q?3640lBKu9UaVPXW5vDlNq2TrkNY7QCq9Hwkc8C40oyFyxpIHKEPJJUOzbISN?=
 =?us-ascii?Q?v7IwiWObp5W6YXeEOWNgLNPs6tOjUmlHNrFGdOldW2mjcbr0Zg87seirGPNz?=
 =?us-ascii?Q?WzAe1vtbCnoZWgz1bII9suwchvDKT3PT13pJqWiyvNDqe+Qi+Pl4RUJLpgSM?=
 =?us-ascii?Q?4p05z9ee/AD3SzTJ0nIjjefhZ7C4rDgjCgf/RjtArYI4kZCzlxJFgBM5Q753?=
 =?us-ascii?Q?IktdFme6Dr2bR4ivFvHLLtFmW75Xxpa0wLgsRavnRIbB06iXpEZlAz8aB6oh?=
 =?us-ascii?Q?w99TSGLssBJiF98PxmM7IRyEp+CuhBc9NMg8R6mudQuCaF8ydyCyTwsgaHtA?=
 =?us-ascii?Q?kw1YohpkZdbmtOXUUQBSvwTCBsSDXRfYXBq+XcjE3Nbb2n/cL97TaFmdER/7?=
 =?us-ascii?Q?f9bOvkzBlPDU9FT9VxfwZxbhOrI8l5FNIUDPgCXldW0frWa6ueS4oUSxxhsg?=
 =?us-ascii?Q?oCIn1/bQjf9hfR+1yYDCzkfqa6FfOmlWttRzhpDiEPj6WH9VZdjC1aa7Ebwl?=
 =?us-ascii?Q?ubpVAbPk97zxZPT1D/xVNVVlw0tPc4ePN6K5VUH1iTcXZxcKepj8RInmK84q?=
 =?us-ascii?Q?9mOLMDyr1pQQ3W4IsqHst4n8kizOrkT0sMVfeYFquezKDd7QMyNc7qDxXjp2?=
 =?us-ascii?Q?5olBx5sfz9pDOprWQH71u1h8CpHYUGLY9+2IuzA9tSkyddb14USMvOr8wVjA?=
 =?us-ascii?Q?VKkAgQeviwfJwKmejIB15sT46267QKFW3D+2aewwBH0QndszsQ0d+3ka+XzK?=
 =?us-ascii?Q?ALRixmykB5oOx4EvBS1p67H+URS5UEqh2To6TIib5xmtDx9EtV+b+ulLQ82d?=
 =?us-ascii?Q?7B5sdr2yzQh4vMJgTuNrrDY0h8PJcM8w188483bjiPDOZPSPAnpu6sRIGS0n?=
 =?us-ascii?Q?AVdyVTMNwBJYxLI71gHZQ5ZpYTMl+qLH0gv8soI6FcbXqhXwZoW2mIcFCcX4?=
 =?us-ascii?Q?tbhBBgZGCntPC3fqeJsZMEW72CAHbff9iES+JX1qMZ5PtrZzU+CIfbz5Heib?=
 =?us-ascii?Q?Ssr7yIN6AzIAQv5AmYwvQ5zw4rlvQPJjpR24iLob1M32sGG9qzMCjBlIF8xm?=
 =?us-ascii?Q?iUxyyUfpzs07kU4IspLQda5AKcqPNsVlk7M2C3Qg8laZBu/xEZSN+hlN/t+4?=
 =?us-ascii?Q?p0ZJgsy/2dxW1fhTh4O8ThzNDow4xExkMcDmUbE4FA6Z6o7isnKYwtUiJbGi?=
 =?us-ascii?Q?NNwqmniWU/0rpNZhY/f545pSNutiZnlE5aeLlMblUWeqcdBF2cO378B8MF+V?=
 =?us-ascii?Q?qLT89L2NQhktOqcGG73d+FqJWHnJHp5GCphkrkv4y0UDSBnMu51vAFsafk9w?=
 =?us-ascii?Q?JEczEUZHMhDnOvy9U8FnqZUK/aWrDfznZRl6XmkMitvFVcElVQlouUibEALe?=
 =?us-ascii?Q?M4QDNN54u6lu6pzGQ9h/sIZaAmAaLjZBIwG2AV2XU3be1i/8Qu5cPdej2rvl?=
 =?us-ascii?Q?98iEV/muyYBjolCMR2uEZS9GOyHtMVZIfytFE9Z90U2E1xc3RgNTuoqDzw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB8291.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZY4kadWaSQsAxvYu7ssr9sieSJ1+HA8V1jI7vMEyrQ6viRIxJXjcV0k9xAO5?=
 =?us-ascii?Q?Nkydmamp3DlJ7dwEiI6Z6Vdy/P3vd79BFt5kPR0GdLlWoOPg+oGSfQyp3cSP?=
 =?us-ascii?Q?tHXwiJhaSBLpTGcYuTd8nNeEDhMVOqCHw9R4eC3c+IEf7y2Pfj+yoPTfeP0z?=
 =?us-ascii?Q?UZhxK1iMOUbsbV0XHORBA1qtHr4sLyvGyWORMhMoGw8u9g7lvManUH1TN9Xv?=
 =?us-ascii?Q?9vuCRuhWIAXKJ7VbE3w6KECsXMg6payj4TzkCGhHqMvwvCuJiVNew+afj8pJ?=
 =?us-ascii?Q?G7igKqLCPwdykF8uw6N6WvOr7AbTPkN1RAfk+RyGyyoMOO05wZdlGajlDnkZ?=
 =?us-ascii?Q?NZXXl9O1FeNrqEfjoFN7Rzr+AoRBB4F36JtBnDBuqe6QwNc10U+ufyPtgkSt?=
 =?us-ascii?Q?1lPXh5Xb+KK63MoXJlKoy20XH4yxMGETP8qAtwVDS7/Pp2A1KAt1nzVEHy4+?=
 =?us-ascii?Q?9H9bdDOYCDZQpVtdz8p0zMvC14Qxqy000SBTTm4QvOJyKmhClNTmWlDeFLk9?=
 =?us-ascii?Q?RieN4uUQGYi44DsRvdzTUbZXgmDjD/LcRmiMHT+AaDijqShgNED3v0J+kclO?=
 =?us-ascii?Q?x48Ja3/nnf4UCiOd3HjgqGdAvmZfh5EePtmrgUqI005RlO+Gfa5DPGsS3Aw9?=
 =?us-ascii?Q?is19BUrDlUMoY+gbdD4Lb/Bpcr1r8488w85Y0acQn/pmNAvBGRrGDIbzRWd3?=
 =?us-ascii?Q?JjqClU7h9GLNSsHSV/vj5GObC+T3imiDNmh7aYU6rFC5KQndnaJoFUWa3cM7?=
 =?us-ascii?Q?jPcVm4WDyp/FA/l7/JJgKEYStOZQxsVKl7GWFQgsYzE5zNASZOnGbWiLJGoI?=
 =?us-ascii?Q?RvhYCebL18fFpQ6pZb9rzSgo1sL6aCvy1LpFZLEyUzuClk5zKkNVFLublvZy?=
 =?us-ascii?Q?PoIbmlGUo8+Qq3VrMHSeKzocAfdpBc2iADEOy3DyiWYOdp63DE7D0hVC4zeA?=
 =?us-ascii?Q?a1N3UqbEueth98bbXURoTYwVixCdIC2Olya/15z8R/wLJ4abmgyopby8Ek3V?=
 =?us-ascii?Q?zCmrZu7OuhuiLf5vIbha2DHbZpjc55E8ycwv7TNNdlbWvkwNp5r9Pd0RoJKW?=
 =?us-ascii?Q?+v+ynwwBWjF5qcW3eVl+unHjJWyqyrg3qC6EfZPdEyUjIIZxHmOrrraB2AIG?=
 =?us-ascii?Q?ZUsnNna3pekxCztIpJqJ5uDce8t+CzE3lDWjbngJCaWkJD+OdroZGSs6f8qA?=
 =?us-ascii?Q?KeAsMit2+ePy4H797aOJssuC7hfSL+sjssQ5WvFsuMNs2nZKH4V/cSYm7crb?=
 =?us-ascii?Q?HqtW1U9vlvx370qXoZojulPGbMaV5/AFFMI4o1S6Jlj8x0I8TjpSG9pfjkZB?=
 =?us-ascii?Q?Xmr5ylZP+xm0zq7uxJLtaQMejWXLcZKewBgZZ2Ih+F/lZ/coAR5qmpLVvDv2?=
 =?us-ascii?Q?wF3DHYUaTs6AxD5DIVxOFLa7zcZ9rexuNZNEA8TCac/8LtbNhdtRanaHt+R2?=
 =?us-ascii?Q?PdfnGIdoZU7LIJN5DxF30XhHCy9fFNaSOZTKqn9x5cqa/Mcn8eBNdleUx/tJ?=
 =?us-ascii?Q?4YGn+xYBfA3rHe9uwiFzbqbX1QQItlXXcH5JNpXTeCXaGKD1bEvRH0e+wIoR?=
 =?us-ascii?Q?eLpJforVLMkSQi5gNsCvUCAT5VpEZmmpI6speJUi?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR11MB8291BDD718BE9BB5A160C839ACD4AMW4PR11MB8291namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5ccf9d-cc55-49cc-9322-08de27e2a445
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 03:12:30.4740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d28f2OCyI372yikmkhhW8aKiHvZaZDfMAbu3LxZyHyHmryn0OmHQyuzC2MpC64p5Sl+m7kl0RLIZdh9RpBTtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6761
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=liang1.yang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Nov 2025 00:27:29 -0500
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

--_000_MW4PR11MB8291BDD718BE9BB5A160C839ACD4AMW4PR11MB8291namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear QEMU maintainers,

I would like to submit a patch for preventing the guest VM crash caused by =
the assertion failure in usb_host_ep_update() during USB hotplug/unplug on =
host passthrough.

QEMU issue submitted:
https://gitlab.com/qemu-project/qemu/-/issues/3189

Please help to review below patch, thanks!

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Author: Liang1 Yang liang1.yang@intel.com<mailto:liang1.yang@intel.com>
Date:   Thu Oct 30 20:07:41 2025 +0800

    hw/usb/host-libusb: Do not assert when detects invalid alt

    Log warning and skip the interface instead of asserting in qemu
    host-libusb when there is invalid altsetting index during fast
    USB device hotplug/unplug.
    This is to prevent guest vm from crashing which is caused by
    QEMU task abort.

    Signed-off-by: Liang1 Yang liang1.yang@intel.com<mailto:liang1.yang@int=
el.com>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 691bc881fb..3a08caafa5 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -885,6 +885,15 @@ static void usb_host_ep_update(USBHostDevice *s)
     trace_usb_host_parse_config(s->bus_num, s->addr,
                                 conf->bConfigurationValue, true);

+    /* Log and skip if configuration is NULL or has no interfaces */
+    if (!conf || conf->bNumInterfaces =3D=3D 0) {
+        warn_report("usb-host: ignoring invalid configuration "
+            "for device %s (bus=3D%03d, addr=3D%03d)",
+            udev->product_desc ? udev->product_desc : "unknown",
+            s->bus_num, s->addr);
+        return;
+    }
+
     for (i =3D 0; i < conf->bNumInterfaces; i++) {
         /*
          * The udev->altsetting array indexes alternate settings
@@ -896,7 +905,21 @@ static void usb_host_ep_update(USBHostDevice *s)
         alt =3D udev->altsetting[intf->bInterfaceNumber];

         if (alt !=3D 0) {
-            assert(alt < conf->interface[i].num_altsetting);
+            if (alt >=3D conf->interface[i].num_altsetting) {
+                /*
+                 * Recommend fix: sometimes libusb reports a temporary
+                 * invalid altsetting index during fast hotplug/unplug.
+                 * Instead of aborting, log a warning and skip the interfa=
ce.
+                 */
+                warn_report("usb-host: ignoring invalid altsetting=3D%d (m=
ax=3D%d) "
+                    "for interface=3D%d on %s (bus=3D%03d, addr=3D%03d)",
+                    alt,
+                    conf->interface[i].num_altsetting ? conf->interface[i]=
.num_altsetting - 1 : -1,
+                    i,
+                    udev->product_desc ? udev->product_desc : "unknown",
+                    s->bus_num, s->addr);
+                continue;
+            }
             intf =3D &conf->interface[i].altsetting[alt];
         }


Best regards,
Yang Liang


--_000_MW4PR11MB8291BDD718BE9BB5A160C839ACD4AMW4PR11MB8291namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-SG" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Dear QEMU maintainers,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I would like to submit a patch for preventing the gu=
est VM crash caused by the assertion failure in usb_host_ep_update() during=
 USB hotplug/unplug on host passthrough.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">QEMU issue submitted:<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/qemu-project/qemu/-/is=
sues/3189">https://gitlab.com/qemu-project/qemu/-/issues/3189</a><o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please help to review below patch, thanks!<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Author: Liang1 Yang <a href=3D"mailto:liang1.yang@in=
tel.com">liang1.yang@intel.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Date:&nbsp;&nbsp; Thu Oct 30 20:07:41 2025 +0800<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; hw/usb/host-libusb: Do not assert=
 when detects invalid alt<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Log warning and skip the interfac=
e instead of asserting in qemu<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; host-libusb when there is invalid=
 altsetting index during fast<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; USB device hotplug/unplug.<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; This is to prevent guest vm from =
crashing which is caused by<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; QEMU task abort.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Liang1 Yang <a hre=
f=3D"mailto:liang1.yang@intel.com">
liang1.yang@intel.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libu=
sb.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 691bc881fb..3a08caafa5 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/usb/host-libusb.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/usb/host-libusb.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -885,6 +885,15 @@ static void usb_host_ep_update(=
USBHostDevice *s)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; trace_usb_host_parse_config=
(s-&gt;bus_num, s-&gt;addr,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conf-&gt;=
bConfigurationValue, true);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; /* Log and skip if configuration=
 is NULL or has no interfaces */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; if (!conf || conf-&gt;bNumInterf=
aces =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn_rep=
ort(&quot;usb-host: ignoring invalid configuration &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;for device %s (bus=3D%03d, addr=3D%03d)&quot;,<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; udev-&gt;product_desc ? udev-&gt;product_desc : &quot;unkno=
wn&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; s-&gt;bus_num, s-&gt;addr);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; conf-&=
gt;bNumInterfaces; i++) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; * The udev-&gt;altsetting array indexes alternate settings<o:p></o:p></p=
>
<p class=3D"MsoNormal">@@ -896,7 +905,21 @@ static void usb_host_ep_update(=
USBHostDevice *s)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alt=
 =3D udev-&gt;altsetting[intf-&gt;bInterfaceNumber];<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(alt !=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; assert(alt &lt; conf-&gt;interface[i].num_altsetting);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (alt &gt;=3D conf-&gt;interface[i].num_altsetting) {<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Recommend fix: sometimes li=
busb reports a temporary<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * invalid altsetting index du=
ring fast hotplug/unplug.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Instead of aborting, log a =
warning and skip the interface.<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn_report(&quot;usb-host: ignorin=
g invalid altsetting=3D%d (max=3D%d) &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;for i=
nterface=3D%d on %s (bus=3D%03d, addr=3D%03d)&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alt,<o:p></=
o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conf-&gt;in=
terface[i].num_altsetting ? conf-&gt;interface[i].num_altsetting - 1 : -1,<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i,<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udev-&gt;pr=
oduct_desc ? udev-&gt;product_desc : &quot;unknown&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;bus_n=
um, s-&gt;addr);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; intf =3D &amp;conf-&gt;interface[i].altsetting[alt];<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Yang Liang<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MW4PR11MB8291BDD718BE9BB5A160C839ACD4AMW4PR11MB8291namp_--

