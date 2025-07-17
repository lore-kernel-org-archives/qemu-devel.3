Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3C0C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVNo-0001XA-VC; Thu, 17 Jul 2025 16:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1ucTAy-00042n-Gb
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:17:49 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1ucTAq-0004jj-Cc
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752776261; x=1784312261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WmRDGP1MFLzqvjZ0y4tOI47YXJ+696gX9K9nURk+tLY=;
 b=GyxNlZGdOwMSbBX/D3qnhbVdOHrKLL35ukhGjsXWbgMyrATWEaOiIJrX
 uN9XyntdNHnsr1L2A2l/DLgoFNYS5fYvHxAEqJ0PKbjtcaMiVP1swyLc+
 +biWf0P/dAFCTtIDBmBWdvBh+DLMaVNZYLZMBabbAHdWTxziPdPgCPHOY
 SkwaCBPAZotCTK0EmXdZ2601C6Cditzdb6VPjwacAtHhvSRmQOeNLR9P4
 Y9hOpHSkYmhW9GbMS/N3yh1nkVY93t5EOM4LdfEqfgSWL62tHST7vJNRY
 J9jMQ6BOGzOBeL3pLsZ+RNKcqI+lDuPqJ4YGFbq17DQ6Gg/ufMypk/Zv1 w==;
X-CSE-ConnectionGUID: bqOH3SqFR6CO+gZ+sVXofQ==
X-CSE-MsgGUID: 41Z5oBQNS6mVjQLFO4IFdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58843297"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; d="scan'208";a="58843297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 11:17:34 -0700
X-CSE-ConnectionGUID: Le30O31DTZe6ONeTcL4PEQ==
X-CSE-MsgGUID: 9Hc5TD4NQe2Dj+CZ3vt8kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; d="scan'208";a="158560166"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 11:17:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:17:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:17:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3riy+As4zsaMrFIjHnYTl/o5SnEboOfUagK+7YJQAbcdHQU+yiCUEgF2jGllftYvdyYyICxCekpTdjKao73TRl6olBP8cHJoWDZnau7re8p44BVazEbYN57y3+E9zhdmbYCTWCJZLAlIbyVevnY79J5r2fmtxD1CKeP89eTRixNw5UAZ/28N/SauQwj5orxgjPYn3J0GIvsCmEmtEDd05V39UfxzZXMNpoekuSumW8Wzs9CSICRKc9fvAXUdhIt7AiT70AxUXMYkXwRZpuMjZdYp3OkPKNUZR9mw2ntzT27yp948IhCQWDAts8PBjqFSDWYrpTIDLqrPr/ZE8zsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+2hEJNnQbnYLMzZMWVwcGfyPqQQ2G8ibncUsUUkNjI=;
 b=oxjaLBR6IrKYKAGFMt6RsfKuvwsL+N/rSaGbSg90Sh/xO8HW0l0yhKOausAa/B+mGuLEgY8LT3uMbskaPd2CdgvSu8pFLk999bGTZyGfB4S6dlLeA2W8F5FDyLXd1UQwjdhm44eevdrJYJLUGbH0IsbynJEgxuG2PwLLmO1hDLfy0+src2EHqO3Sw7o1jN2hRLtBTEJ4r8cXplyj00SEhNy7X1DRTw9ZWFszjcSkae6G5ZvydcRt/j0ahlvKAriRru42ncNJ0uC5y6m54TpvaKWxMY/wBUph4h2SiE6lb8zZQPLIhmoob9BvovL4TFOETOLxp9lQCbtxwkEZ+qS1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:17:29 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:17:29 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>, Michael Scherle
 <michael.scherle@rz.uni-freiburg.de>
Subject: RE: [PULL v2 09/13] ui/spice: Blit the scanout texture if its memory
 layout is not linear
Thread-Topic: [PULL v2 09/13] ui/spice: Blit the scanout texture if its memory
 layout is not linear
Thread-Index: AQHb9VKBxcMuo3Nw9UqxdvahzF7yW7Q2Dk8AgACThaA=
Date: Thu, 17 Jul 2025 18:17:29 +0000
Message-ID: <IA0PR11MB7185EE1F0594404C45CA1C98F851A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
 <20250715063301.145191-10-marcandre.lureau@redhat.com>
 <CAFEAcA_humAdK=eco8GNgO77d9tJUP_mTsoyuG=uEFCCSc34pQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_humAdK=eco8GNgO77d9tJUP_mTsoyuG=uEFCCSc34pQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CO1PR11MB4882:EE_
x-ms-office365-filtering-correlation-id: cdd8d63c-214e-4a2d-bf91-08ddc55e3113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?F6SLGVLnouFUlLClCFC6I2i2Bm/3CzLMn0sOR82o+4s96aBaGlVXSqfDMG6X?=
 =?us-ascii?Q?Z+NtM5ZEgxR0rKNZtWrHjMAQkW1MswnLtq5wrKpz80WJrvbfsg5z16WnJ96V?=
 =?us-ascii?Q?cFKdDqGF1CQ8atophlfJc3D4RpwUAONx0xbjmS4TliN5uSEKEAHqpt3LT39G?=
 =?us-ascii?Q?eZXQAMVlJGZU6FUB0R6ZLf905pynLaDMCPHqnJNlC+qIX2ZC2rVd3bS/Sn72?=
 =?us-ascii?Q?yUNyB2xsAUMjL4wzVknSHcaKVggD2G00S6ebO1eNiYtoeSySMm8USSt166Nx?=
 =?us-ascii?Q?ABnSvBouMv3poVP2NJ62TAAQnRUgNAQYK0rlcUB+s1jzNny1Gx+Z495H1fAe?=
 =?us-ascii?Q?FKEIQvC6Lh0Zgk5VBqFbjNChGV4vQxC8hCNS/vwB3lT8HF2awnOic0WaSL0p?=
 =?us-ascii?Q?Ok9XBlHPZqqmvzZ4m0mP2eluZeJJjjZwFl577xdYaMRlr2/B75qfX8Ty0TNt?=
 =?us-ascii?Q?PKjOLvNr0lbbw0En7X2zFNWF3Do0IxYM+tjLnq1XZqVin7XnF543QEs3Am5q?=
 =?us-ascii?Q?P94k/cyKcyXwE+tQoRnm2/7DdJSDQf1wyA24tQB7lHesuVx2EhbvX4lRxGCP?=
 =?us-ascii?Q?eY64Ah9qI/v32aFhkGdLllSD5l6y9eFWEQlMREJsOaNwwDaMvXTB8z7SpY1n?=
 =?us-ascii?Q?ac7d1wa9dhxYPiDPZ041c9EATsoF74W3mVNwrIO3XR9Jur3TbXxfNMqfLjBa?=
 =?us-ascii?Q?RWPFJqW9wdv8NLJOocox2ZAj7FMRPDYGzyJQ6/Yx1uJC4rbAWUId8swX9dcd?=
 =?us-ascii?Q?7MnEIxHYtVJkXjZUUgT4ebe+FvyzRxkhwqbTyKV1oEIiWXG82cy5a6HdZVE2?=
 =?us-ascii?Q?0lq8jQ5z5DPATdPqux/KS17W4VbivrHgSby5wHT+Rj8Yj4+dMgOm2RNnrGEa?=
 =?us-ascii?Q?CLNSczrprV2ZN3ge9ZlN4y+j61RfqjYjAu8LVz6PjrUflhs7PzG7RQoP7EFN?=
 =?us-ascii?Q?TOuyWxZzVRP3YoHTrGhCRpLJOxoNx3LxJV+SdUIl2CL1lVNvdyXrN/KEyHSu?=
 =?us-ascii?Q?DxozHfyY4VGidEdBREPlWuMjPtR8ORHZic2cvfVZeTZL0lBiSxdVkEdXfQK5?=
 =?us-ascii?Q?7Bz10gZHUiR/q8zX5Exdvctm2+7QRG8ynRBgsazaiOhN0gDboGBstlBKTAtn?=
 =?us-ascii?Q?M5bLvMeEiqVn32c9GMsQoS2uDAw2HCM/7hlUKFcwCb0I0bIradBKac0cStNm?=
 =?us-ascii?Q?z5EgYR1aI/CkDXn5qtxQ6OFiJyO6JX+aeNiBAurhERI0Y3RbE+ZVqF18h/ak?=
 =?us-ascii?Q?m0fWZbi+DA0Jx8syGz9R4KPJ/NWjfXlu5k5RFTHk+we4M6IkBkV534w+zkVf?=
 =?us-ascii?Q?YNEpW5LOkthU75WiZYRZuwmPNR30auOmCZOaj5rotfSlores7z9uZxdJbrOV?=
 =?us-ascii?Q?8wswROoCA8UsA5AoeHTw5399bbD8S+hu/I0BSeY9+9+bgUjx92A85UuqSx1+?=
 =?us-ascii?Q?7cZV7MEdW73Qebz1z0zmugj2aX832DL6lrn4aFpjz1Y8jXg8HUEuzg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jsXwvhAyhdld9QJHISRlNoCsEsT31Vz9PPPYfD8tWR5RxCKbaevFihbzEdJT?=
 =?us-ascii?Q?2sUUDARf1T6OtJ0WYcKtoxrTx8BjruEVcF28y2PRMxvbWHg40pWL/Lp/Q45t?=
 =?us-ascii?Q?dKG3LPIbf6K0+AEDCqHSEF4qyoobbxlZyaW/uYaia+Asy8LBM7Jg9vBx2zgT?=
 =?us-ascii?Q?VMJOrUMREfUxV9MXOXPpbW6qFM+elJTnkobrDftS2f4u2fZEEzrHXXB9QOeJ?=
 =?us-ascii?Q?7amGXe4a6JivnKq4bqJW4R3ipHziETFk/RJXatscPLvzWnPvZ45FAn20DK3f?=
 =?us-ascii?Q?d8PnWb1Zz4V1QiwyCOXr2XlzS/2Q3PY6ibdWfE2S6Zdz58XiycZtNZREuQSq?=
 =?us-ascii?Q?epzB/L790yUwtpHcaT7HdKte7b8WNXKRenNto6Aznhw7+qeIsPFaDhN2Cgvl?=
 =?us-ascii?Q?UVVhsHBNis1IuqG3ST7dXOTQegweCvYlcgJ8ESiOBiRlvVypLDM+j3tAuev8?=
 =?us-ascii?Q?CU/YsYEcODutSKOdTxFKh2O9eqUaRxQ3y8wJ71+fwuUvyxlaULrfOeeZ2EMk?=
 =?us-ascii?Q?GKMsjiP2+yaZtp5HUAcCnPJCm/P7wwpyZNO6OVVhd8/trGn9fCHDo360r7go?=
 =?us-ascii?Q?2VQJ9SyU26W99OyhdZtNagvpvIQmk/fqfFH3wvhxwFGNt8H0Jn7tXrIu5iG9?=
 =?us-ascii?Q?JzaJdYdO1rwPfAwWVjpuR1PfqFlAOKKxUo0+zLRffj6cEE5XfwHFb/YESmRS?=
 =?us-ascii?Q?TiX1yTcFQLkFFw14nlOXJancXPHKqHCEH4Qb06OKGCRlLTRs2Geha3hQ9XWQ?=
 =?us-ascii?Q?m8F7WN08pXzdaigLD4LyDidTZG4mrVJ5o89ES+QnfL6MGSRBSZwIwVnpWcrB?=
 =?us-ascii?Q?3wTr2u5QyRIgU23UbIWOU3BFi9ScIO4bezPsyvVMLCPfjXG4SCaBOR3r3+fX?=
 =?us-ascii?Q?fezNbnhCFmyqfTXlRkk654TCr63GzV5jF+jIxEZOqXqn+bWEEHPdbe+c61lM?=
 =?us-ascii?Q?9qQ80i+w0PtR5A5N1BAYVulNHj0fKEoKIrFnEZqMHcCrE155xGMUUz49WHwG?=
 =?us-ascii?Q?DBRuyRqGr864ul5UnznT6pYtfwnQFgHXLexo4wMiPw3S8Ekp33eKC6LFHPSS?=
 =?us-ascii?Q?Q98vNxPMp71inOEtzLOOHEwjW9r7S4Gioskc6h2H1E3Ok7RLgW4Nw1j27Vdh?=
 =?us-ascii?Q?rHhS81YN6aaCFBzms+HVNZZGbIIae4n+Kp344x/1fd6MKHyCcJAFEZUkjjzd?=
 =?us-ascii?Q?CEGB4wi51ZZrBz2pttN2TbVRVVzYlRPVDlmrv1Jp2Y4++50peTsa4v89mjt7?=
 =?us-ascii?Q?VDNNQcCd1K8oopvbGzYRaSDxYb0eG095/vY1pIQEU7u4AxezSO4+VcSX9RzL?=
 =?us-ascii?Q?a7u5JKREfmYXAq447Wu9ko+C3OTjtNedvYOv20YWZLKOHOA27eqbyk/LdmYv?=
 =?us-ascii?Q?HbKy2CYXR+VfkUrcahpNYDGlkGyQ+WM5kM6gdlHVm/Ra9dmN1hMYoBbsQ2u7?=
 =?us-ascii?Q?VbuTXCDPYpzBxJ+aGza96Gjv7VWapsTzohzrti2n3Pwv4u4fKCVPAHHqnDts?=
 =?us-ascii?Q?+CzzImd68dUZdOU5DPHG+M/6O5KfKOyBnNTc2XDNVU90/YIpJZf0620sYHBn?=
 =?us-ascii?Q?YyuaI2g2nbAH8KrjHOgryzM/rOZg9mJamALVYO9r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd8d63c-214e-4a2d-bf91-08ddc55e3113
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 18:17:29.7073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mKLvW9046shOlljHvU7DGg+mvh4XAW6ZwN1pNqrxWFyX37kQ2vbzmf34r0GNzp62+HWMkr3SMVyRDtyC3pXbAHNOzCfIqYm85Yx5/lkEiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
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

Hi Peter, Marc-Andre,

> Subject: Re: [PULL v2 09/13] ui/spice: Blit the scanout texture if its me=
mory
> layout is not linear
>=20
> On Tue, 15 Jul 2025 at 07:43, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >
> > In cases where the scanout buffer is provided as a texture (e.g. Virgl)
> > we need to check to see if it has a linear memory layout or not. If
> > it doesn't have a linear layout, then blitting it onto the texture
> > associated with the display surface (which already has a linear layout)
> > seems to ensure that there is no corruption seen regardless of which
> > encoder or decoder is used.
>=20
> Hi; Coverity points out (CID 1612367) that this change
> introduces a use of an uninitialized variable:
>=20
> > @@ -1269,6 +1329,15 @@ static void
> qemu_spice_gl_update(DisplayChangeListener *dcl,
> >          glFlush();
> >      }
> >
> > +    if (spice_remote_client && ssd->blit_scanout_texture) {
> > +        egl_fb scanout_tex_fb;
>=20
> We don't initialize scanout_tex_fb...
>=20
> > +
> > +        ret =3D spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);
>=20
> ...and we immediately pass it to spice_gl_blit_scanout_texture(),
> which will unconditionally call egl_fb_destroy() on it.
I'll send out a patch in a day or two to fix this issue.

Thanks,
Vivek

>=20
> > +        if (!ret) {
> > +            return;
> > +        }
> > +    }
>=20
> thanks
> -- PMM

