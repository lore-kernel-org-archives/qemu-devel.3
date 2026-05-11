Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC57CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 05:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMJPB-0005S6-Ig; Mon, 11 May 2026 01:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wMJP7-0005Rk-So
 for qemu-devel@nongnu.org; Mon, 11 May 2026 01:42:09 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wMJP4-0000uZ-PX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 01:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778478126; x=1810014126;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WnNdXWTpNqASkkM4xGrG6rNE8wTKXM3j2WREvtB+gng=;
 b=KzCpFfKUTB/TNr3wDrl24ahfLkrGdjc9FxVmRURpEcR+tVYjrehlGDrv
 VBHtJNW+xuPRHTT6sCwSeXoy+FLXGhvKJa23jsGxy9UQW9CVniWzZIY1x
 DEbuy1AGwBArQewUTjUMvVqp+ht8hYR01pZJQcM00zCn0uPlsG0IX4rQS
 5XX/KJxl+uKAe5TAFJXBtcpKz3KE5dAamuOEwKCTozu7UNKUA4uihdphz
 DYqF2m+7A8Ht+EUyDbfyDeH3UjpE63ACvGe4EexYGlwyPXdsD9gU3J8SS
 rXYZeiftk7W7dUfAvzmsJV7b7qa+jG5sNaCjca3zjj/MGKzgs06AQGzO5 w==;
X-CSE-ConnectionGUID: xgXEzcEhRgeqNQrRdJrsFA==
X-CSE-MsgGUID: hTVVMgArRbyemmUqUm0SCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="104817357"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="104817357"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2026 22:42:01 -0700
X-CSE-ConnectionGUID: AxFgUUBUTXm6NM/1aL5yog==
X-CSE-MsgGUID: vJsM2VdlRVGIVEVKdM39fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="275491589"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2026 22:42:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 10 May 2026 22:42:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 10 May 2026 22:42:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 10 May 2026 22:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Omdo1JbXgtt1o7T6vT2erjN2CurCmgnDzTlMR3Ei/CRlVf6qBFmMXN6PXJahzGouraZEaIYKR2wbyRSxD0g+J5iCdVHcnOfaXXtDp6qumuRRCGfgIiprRTe4kNHJD0kQzY+Pvivo/eDe62pdQB1r7+X1b5iM8uLzohftJlvttNKeG/7RPblCdwc4NN5JgvaB/XOoEjkactUMP+5lPGRfe5aem05mi1zyBT4/rXNoNUmfKWSC831rFfbW273M1cbFNMHZSkJ41A3CQexeDTs/Im9F52GzSw0SwiMOnQkAZ7ZOrbJ6w2IKt0RhJk5/O4JvSAFP7TCoS0eQ0ic9iM1YSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnNdXWTpNqASkkM4xGrG6rNE8wTKXM3j2WREvtB+gng=;
 b=lc1kFeWRztYr10WIXqKUJg32r1NGqws3rfG3Qyg1zWsG5uzuOn9idSKlDZEbMM1tPf2NMvtL3mM+bcx7JQPibw6DeHBMhHxwLq7A6QFTezUHqPXMuy7ACqLnNc3aktvQxAdUFeLxJMA132vkZolteVRoubu+ylGvfC+RxFamxAcKnLRcdBh60PhNdHeHWhvAXnxLpcPape/UOazQ8WLrw8apF8g2kTVgnK1oTEItNb/OAxWJsX5QUoRcEx1o5v8i5nhd/nj559JlwaBe2RLeuS2TrXNCGOT7f0CY5ch8iYo+QPoeJuc5xozHE0Xsmhq4WPz/C4M79TlaaexrxKmH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 05:41:52 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 05:41:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Cao, Junjie" <junjie.cao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>
Subject: RE: [PATCH v3 1/2] intel_iommu: fix guest-triggerable abort on
 oversized MMIO access
Thread-Topic: [PATCH v3 1/2] intel_iommu: fix guest-triggerable abort on
 oversized MMIO access
Thread-Index: AQHc3QdP2qwF5H9qbEGpGeC7hoCu1bYD4huAgAR0BnA=
Date: Mon, 11 May 2026 05:41:52 +0000
Message-ID: <IA3PR11MB913608B2CB25D851EE72D35492382@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <20260506031942.251335-2-junjie.cao@intel.com>
 <42ec9559-3445-4712-bfd4-1319b4d4ce2d@intel.com>
In-Reply-To: <42ec9559-3445-4712-bfd4-1319b4d4ce2d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: 4fcd9f70-8547-479e-5ba6-08deaf200136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: H/oa4UEz/v8itFzVRKNMglQH1R/VC0VsRlfK3Pmo+17rxX0CmNg2NlGdIbNYP1vJH22G/7J3QNXvZkporoMDrtz6hRhVXMibnJc4cOiebrm/wwhYrHXBgY8BkS0484ZSQUlM6YnxdBgIozTB2YZYpyZgc7d6km6IlyElzY8savzPKFvr6ekMjVpKorrK3c4WE03wSnwC79ZDMCUnDxqMw54AKFh4aKXxVTPy6d7qT1/sFc9+6EErK3Wr5ToI+Jr9gJ6MlqliEIrDchWHWnXJv+AZpLkqBSkGe1yLvAWczZ0WpAgXFiwXZrQ3/6iqvwoFeCnQ+kjXA3/jopJzkWxlPJ9KAqoKC8LUkaLjzslRJ4Tp6RoLbnKeoB6DAkGbwetwXYX6Oy4TAyY4V5waln1ey9Wt3CqvsWl/pdUokEgWznKFShFoHze5pFXKUAUutz/tWJUw0k0QZA52g3w7O0rquIawYb6IiVDY11UTkkRMEN3QFubPYxefsijlVlrFyuJkQTiBCJ2urKo4kNh+9xPSAmxvQq9CB+WABlk1U14SG26luUgeh3yB2HwHxfgkuAmLqpaQhAbiYeY0re4WPuvFhoscXoqZPOze6Q5LAREPggh5u1+E4iDPOWXcrl+cLORL1pOwwPcMRcb2I8vR8rRfZEGWT8x+AtAQUkn9AvgxUJhY+8pGOjdhZcR14YxCv4km/HnvQ/+6ViKkx3Trm27vLIVBe3/RucIvkPXT+37NnaymHq+93rn0Q/Zqxv1lIb21
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHFMYkg2OVVvTlBVUXdqV3dmSlNGWEd2cFdSeEdZaTk2bWV5bjd1elRpUThF?=
 =?utf-8?B?d3JGNnB4QVowWkRlaFJDcEw2a0dBa2lyWXFwNW9xOS9lV011WE5RQVk0Tk40?=
 =?utf-8?B?ZFIyYXpTaUFmREVpSjU3aDU4b3JEUWpaMy9ZRVUxK3RLb2FKTERuWVZ2QUVj?=
 =?utf-8?B?ZEtmQ29mRzRNRU4wS0NaZ21NVTNuejRId2NMekJBTFZRbTdIeS9aWTdZZm96?=
 =?utf-8?B?SGVtb3RkdjZlREdEc3EyNnk5K0hiUHJSakE0cklHRDBaK0MxbEpyTkNjQnI3?=
 =?utf-8?B?d28zTmtwTmtLMmpVdGwzYkFqcER2dU1rK2lVVmRId0tqVXZoVGZ1MGhpTkpB?=
 =?utf-8?B?Sm02NzlhZGNXYXZJZDlKRUJZVkk0eUJqaHJCZ1N1RnM2blE4QkpiUTRkN0xN?=
 =?utf-8?B?aXZMZDFyZlpsNGlpRnNGZFZLRnhWTTFOc2VaVklPSTJEbFJrSjBEaDgySmtB?=
 =?utf-8?B?YjFJREd0L0dqT25rVCtOeDkzdDk2OWhuTmRJUmhzVzBWUXkvQzdFaVRhLzNM?=
 =?utf-8?B?K0tCY2pDQ3huY1cwSUhOd05LdURlUFdwMmlJeG9zbnVTVVdXWFJka0htelNk?=
 =?utf-8?B?dGRNaGRhWEoxTnFzNWpNOWtVRnZYV1JBRE10b2ducENadjlxZGl2bmphQW03?=
 =?utf-8?B?QVpuVHc0ZFdMNzhmN3JvbU0yN2htcFZvY1JZak1jZS9WRlYrSjFTY2R2MEVN?=
 =?utf-8?B?MDM5cjlsSVN6ZmpVdWlGTXlPc0JsZXVpNmtVbnJGMUx3OFJpTTlaKy9xU0hX?=
 =?utf-8?B?VUd4NlRNek5XNzhBekdzN3V3VWR3YktGc0lidzRPQ1dQamJBZVUvSHhZcEZ4?=
 =?utf-8?B?d1pwRUdxbnBsdy9yMzFuK2tZS1dOZkJPT1RIajlINmhmTjZCb3JNbUY3WE1T?=
 =?utf-8?B?WUd1VGVqb1hrM29UT1FvU0gvR3JSWlhIY0hBeTJ4cHhBL3R1cmxmZS9oMW8w?=
 =?utf-8?B?NTAyK29kUy80c2l3WTdMcVIrQ2htTEZseUNMRXo3Q0xISEo2Vi81YkY2d0Jt?=
 =?utf-8?B?enpQVzlmYjRhNmVuTGEvUFhKdU1pdFpTd0lVMng2WDdybFFTUEdtUHVienlM?=
 =?utf-8?B?RFZTUUFwMHVMRWZGRjJxbnJJUkh5T3U3OE45eitOUWt5cXIrM0tzbEdzUkZu?=
 =?utf-8?B?YWRoTk1QT1B6WTVTRDU2U3A1UWZ6K2p2QXJSRVhzeXJrT2JFTnRmTVJOQTU4?=
 =?utf-8?B?NEZUVktoSDZLZXZ1aEQ1dzRUekhXR0VxTS9LSHNHSWtVRGxEbldySXNtRjFu?=
 =?utf-8?B?eTM2QUMrRFl5YTFlZ1d4UzVEVHJPdnhZVmpUWG16MjJWVUhCdGU2SXdsbTFn?=
 =?utf-8?B?VnJCRndDM3hobXgxUFlkVTB6NzFITk1OTWxndm9yT0EyYitScmpWbUphTnpr?=
 =?utf-8?B?L3AydFFjdnJBZUM3S1Voc3JQaGZrd05mTUxoK29qMGlxajZ1NkNjSU50RElq?=
 =?utf-8?B?ZXVlNGVVYU5UOURxM3prVVQxeWR0aGEybnc0Wk5oSzRkcHo0cjc1dms5SkY5?=
 =?utf-8?B?azdQUWhNaEJMV2NGWmtETTJaZU10WlgxU2RsMnQ0Z3ZnSW1JMGF1eEVITkdK?=
 =?utf-8?B?KzRWYlJTcmdDZUg3dlZoeE1pUlRtcHZBZ3l3MTRqYXNDbXVZRjcycDRrWkp1?=
 =?utf-8?B?cjBmMUJCMzBpRmdwL200T1JzVUExdWRiN0FDSDZFZS9JdjN6cnNFbUUyUEhN?=
 =?utf-8?B?OXRGeXJ4NU1uRGViTUtEQzNZem9MaFNETDA2MVg4MVNHSDVkbzF2ZWx6NFRu?=
 =?utf-8?B?blJXUldXWWtWK0lKRUZROTlpbVlwcS8rY2hyb2drR2JvbG1ORVE2OHlvVFY0?=
 =?utf-8?B?S2M3RUZDbkNCRkYrK1pEdXR5SmNWUEkrTEhxM2VDd05FWTNYQWhyVlFzWi94?=
 =?utf-8?B?VjdUaTM3VVl5R1hKMXd5aXZoRG5kRDlFOWNwd3UrWWZ5dDgrWThkS0d1Qm54?=
 =?utf-8?B?T1lOaisxNWR1SGVUalY3ZThIcFBYMko5WmJ0azhaaGRBeEorQ3B1OE8wUDVm?=
 =?utf-8?B?UCtIQnA2ZkFrSkRhR1ZVTEhnNjYzc2NFMXVnRlNkSm5VeHhMRlJoYXlxMmti?=
 =?utf-8?B?ejZxUXFHK2syb0hYSlA3R1ZtTk14UjUzTHdCd3lWNE9UWmJtdnJOZzAzL2px?=
 =?utf-8?B?Z0Y4N0RoaGxLR3RLd2VQaUhpdjlqNXprTVhOMkRnb09xL1ZQaWVTU2xWTEo3?=
 =?utf-8?B?R09SSndjWlNWbXptem9hT1piWkM0YmE5Uk0yYzF5UEtCc0pDK29RbE5wVkVU?=
 =?utf-8?B?VzRhZmZZcUM4aFg1eGh3ZFE4eDB3b05HM0FBQ2pIK2QwTEVHWW1URWhnK2pZ?=
 =?utf-8?B?QkpDa2ptUCt6RTBnYkJQQm9sTjh6cGkwUkxZR2w4R3FGYjJsWDlzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v22tfWdQyscMzaEorZ3RRmd8V4U0gAi97CYFBzrcnsiG+rXOmv7oW449YkUEuxdT+SW3n7lv76gfnvMOuukoFh9voT1ZNQgZLcQkUXkTYo0o/YN2qgETu2MeXBPs7vts4H700WCggLBrsHAY2OMQLiTZl2YYwMlDz6e7HZV9in9mQjDgV4tbwitZAA3//oVt7+35VPcH5uSsWlnhR1gRLRl2Bl64czSVDxIDUZHU+VacO7NXrCfvZ+npYCwR3iXvoc5DyvDvqDeQpF1fHw/hblWaVb3AAwYK+/K6KhND4KFLDGsICKN2BtaPHUOWA75BSNprmFsOaw5xVAs9FZFADQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcd9f70-8547-479e-5ba6-08deaf200136
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 05:41:52.7004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KG1K7htavCdJ578qWZkmzXRO4o9W0I1hENf84O6KiBjMEzNMjvhsyh43e5D9VkCt9m3PcIrnpt1dLUG1xi+GOWDs3QQ2J/BbPjymyvyYj6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBpbnRlbF9pb21tdTog
Zml4IGd1ZXN0LXRyaWdnZXJhYmxlIGFib3J0IG9uIG92ZXJzaXplZA0KPk1NSU8gYWNjZXNzDQo+
DQo+T24gNS82LzI2IDExOjE5LCBKdW5qaWUgQ2FvIHdyb3RlOg0KPj4gQW4gOC1ieXRlIGd1ZXN0
IGFjY2VzcyB0byBhIDMyLWJpdC1vbmx5IFZULWQgcmVnaXN0ZXIgaGl0DQo+PiBhc3NlcnQoc2l6
ZSA9PSA0KSBhbmQgYWJvcnRlZCBRRU1VLiAgUmVtb3ZlIGFsbCAyNSBhc3NlcnRzLg0KPj4NCj4+
IDIxIHNpdCBhdCBub24tOC1ieXRlLWFsaWduZWQgb2Zmc2V0cyBhbmQgYXJlIHJlamVjdGVkIGJ5
DQo+PiBtZW1vcnlfcmVnaW9uX2FjY2Vzc192YWxpZCgpIGJlZm9yZSByZWFjaGluZyB0aGUgaGFu
ZGxlciAtLSBkZWFkDQo+PiBjb2RlLCBzaW1wbHkgZGVsZXRlZC4NCj4+DQo+PiBUaGUgcmVtYWlu
aW5nIDQgZ3VhcmQgOC1ieXRlLWFsaWduZWQgMzItYml0IHJlZ2lzdGVycyByZWFjaGFibGUNCj4+
IGJ5IGEgd2VsbC1mb3JtZWQgOC1ieXRlIGFjY2VzcyAoRkVDVEwgMHgzOCwgSUVDVEwgMHhhMCwg
SUVBRERSDQo+PiAweGE4LCBQRUNUTCAweGUwKS4NCj4NCj5jb3VsZCB5b3Ugc2hhcmUgaG93IHlv
dSBpZGVudGlmeSB0aGUgNCByZWdpc3RlcnMgYW1vbmcgYWxsIHRoZQ0KPnJlZ2lzdGVycy4gVGhl
IG9mZnNldCBvZiBzdWNoIHJlZ2lzdGVycyBhcmUgbXVsdGlwbGUgb2YgOD8gaXMgaXQ/IEp1c3QN
Cj5jdXJpb3VzIHdoeSBvbmx5IDQgcmVnaXN0ZXJzLg0KPg0KPj4gV3JpdGVzIGZhbGwgdGhyb3Vn
aCB0byB2dGRfc2V0X2xvbmcoKSwgd2hpY2gNCj4+IHRha2VzIHVpbnQzMl90IGFuZCBpbXBsaWNp
dGx5IHRydW5jYXRlcywgYW5kIGxvZyBhIGd1ZXN0IGVycm9yLg0KPj4gUmVhZHMgZmFsbCB0aHJv
dWdoIHRvIHRoZSBkZWZhdWx0IHZ0ZF9nZXRfcXVhZCgpIC0tIGVxdWl2YWxlbnQNCj4+IHRvIHR3
byA0LWJ5dGUgcmVhZHMgYW5kIHRoZXJlZm9yZSBoYXJtbGVzcywgbm8gd2FybiBuZWVkZWQuDQo+
PiBtaW5fYWNjZXNzX3NpemUgc3RheXMgNCwgc28gYWxsIHNpemUtYmFzZWQgYnJhbmNoZXMgb24g
NjQtYml0DQo+PiByZWdpc3RlciBwYWlycyBhcmUgcHJlc2VydmVkLg0KPj4NCj4+IEZvdW5kIGJ5
IGdlbmVyaWMtZnV6eiAoMjQgZGlzdGluY3QgY3Jhc2ggc2VlZHMsIGFsbCBmaXhlZCkuDQo+Pg0K
Pj4gU3VnZ2VzdGVkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVuamllIENhbyA8anVuamllLmNhb0BpbnRlbC5jb20+DQo+
PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNDEgKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGYzOTVmYTI0OGMuLjBm
Yjg5MzMyZjkgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM3MTMsNyArMzcxMyw2IEBAIHN0YXRpYyB1
aW50NjRfdCB2dGRfbWVtX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHINCj5hZGRyLCB1bnNpZ25l
ZCBzaXplKQ0KPj4gICAgICAgICAgIGJyZWFrOw0KPj4NCj4+ICAgICAgIGNhc2UgRE1BUl9SVEFE
RFJfUkVHX0hJOg0KPj4gLSAgICAgICAgYXNzZXJ0KHNpemUgPT0gNCk7DQo+PiAgICAgICAgICAg
dmFsID0gdnRkX2dldF9xdWFkX3JhdyhzLCBETUFSX1JUQUREUl9SRUcpID4+IDMyOw0KPj4gICAg
ICAgICAgIGJyZWFrOw0KPj4NCj4+IEBAIC0zNzI4LDEyICszNzI3LDEwIEBAIHN0YXRpYyB1aW50
NjRfdCB2dGRfbWVtX3JlYWQodm9pZCAqb3BhcXVlLA0KPmh3YWRkciBhZGRyLCB1bnNpZ25lZCBz
aXplKQ0KPj4gICAgICAgICAgIGJyZWFrOw0KPj4NCj4+ICAgICAgIGNhc2UgRE1BUl9JUUFfUkVH
X0hJOg0KPj4gLSAgICAgICAgYXNzZXJ0KHNpemUgPT0gNCk7DQo+PiAgICAgICAgICAgdmFsID0g
cy0+aXEgPj4gMzI7DQo+PiAgICAgICAgICAgYnJlYWs7DQo+Pg0KPj4gICAgICAgY2FzZSBETUFS
X1BFVUFERFJfUkVHOg0KPj4gLSAgICAgICAgYXNzZXJ0KHNpemUgPT0gNCk7DQo+PiAgICAgICAg
ICAgdmFsID0gdnRkX2dldF9sb25nX3JhdyhzLCBETUFSX1BFVUFERFJfUkVHKTsNCj4+ICAgICAg
ICAgICBicmVhazsNCj4+DQo+PiBAQCAtMzc3OSw3ICszNzc2LDYgQEAgc3RhdGljIHZvaWQgdnRk
X21lbV93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPmFkZHIsDQo+PiAgICAgICAgICAgYnJl
YWs7DQo+Pg0KPj4gICAgICAgY2FzZSBETUFSX0NDTURfUkVHX0hJOg0KPj4gLSAgICAgICAgYXNz
ZXJ0KHNpemUgPT0gNCk7DQo+PiAgICAgICAgICAgdnRkX3NldF9sb25nKHMsIGFkZHIsIHZhbCk7
DQo+PiAgICAgICAgICAgdnRkX2hhbmRsZV9jY21kX3dyaXRlKHMpOw0KPj4gICAgICAgICAgIGJy
ZWFrOw0KPj4gQEAgLTM3OTUsMTMgKzM3OTEsMTEgQEAgc3RhdGljIHZvaWQgdnRkX21lbV93cml0
ZSh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPmFkZHIsDQo+PiAgICAgICAgICAgYnJlYWs7DQo+Pg0K
Pj4gICAgICAgY2FzZSBETUFSX0lPVExCX1JFR19ISToNCj4+IC0gICAgICAgIGFzc2VydChzaXpl
ID09IDQpOw0KPj4gICAgICAgICAgIHZ0ZF9zZXRfbG9uZyhzLCBhZGRyLCB2YWwpOw0KPj4gICAg
ICAgICAgIHZ0ZF9oYW5kbGVfaW90bGJfd3JpdGUocyk7DQo+PiAgICAgICAgICAgYnJlYWs7DQo+
Pg0KPj4gICAgICAgY2FzZSBETUFSX1BFVUFERFJfUkVHOg0KPj4gLSAgICAgICAgYXNzZXJ0KHNp
emUgPT0gNCk7DQo+PiAgICAgICAgICAgdnRkX3NldF9sb25nKHMsIGFkZHIsIHZhbCk7DQo+PiAg
ICAgICAgICAgYnJlYWs7DQo+Pg0KPj4gQEAgLTM4MTUsMjcgKzM4MDksMjcgQEAgc3RhdGljIHZv
aWQgdnRkX21lbV93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPmFkZHIsDQo+PiAgICAgICAg
ICAgYnJlYWs7DQo+Pg0KPj4gICAgICAgY2FzZSBETUFSX0lWQV9SRUdfSEk6DQo+PiAtICAgICAg
ICBhc3NlcnQoc2l6ZSA9PSA0KTsNCj4+ICAgICAgICAgICB2dGRfc2V0X2xvbmcocywgYWRkciwg
dmFsKTsNCj4+ICAgICAgICAgICBicmVhazsNCj4+DQo+PiAgICAgICAvKiBGYXVsdCBTdGF0dXMg
UmVnaXN0ZXIsIDMyLWJpdCAqLw0KPj4gICAgICAgY2FzZSBETUFSX0ZTVFNfUkVHOg0KPj4gLSAg
ICAgICAgYXNzZXJ0KHNpemUgPT0gNCk7DQo+PiAgICAgICAgICAgdnRkX3NldF9sb25nKHMsIGFk
ZHIsIHZhbCk7DQo+PiAgICAgICAgICAgdnRkX2hhbmRsZV9mc3RzX3dyaXRlKHMpOw0KPj4gICAg
ICAgICAgIGJyZWFrOw0KPj4NCj4+ICAgICAgIC8qIEZhdWx0IEV2ZW50IENvbnRyb2wgUmVnaXN0
ZXIsIDMyLWJpdCAqLw0KPj4gICAgICAgY2FzZSBETUFSX0ZFQ1RMX1JFRzoNCj4+IC0gICAgICAg
IGFzc2VydChzaXplID09IDQpOw0KPj4gKyAgICAgICAgaWYgKHNpemUgIT0gNCkgew0KPj4gKyAg
ICAgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCAldS1ieXRlIGFjY2VzcyB0
byAzMi1iaXQgcmVnICINCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYWRkcj0w
eCUiIFBSSXg2NCwgX19mdW5jX18sIHNpemUsIGFkZHIpOw0KPj4gKyAgICAgICAgfQ0KPg0KPlNp
bmNlIHN1Y2ggd3JpdGVzIGFyZSBoYXJtbGVzcywgSSBkb24ndCB0aGluayBpdCBpcyByZWFsbHkg
aGVscGZ1bCB0bw0KPmhhdmUgdGhpcyBlcnJvciBsb2cuIEluc3RlYWQsIHdlIHNob3VsZCBoYXZl
IGEgY29tbWVudCBoZXJlIHRvIGF2b2lkDQo+c29tZWJvZHkgYnJlYWsgaXQgaW4gZnV0dXJlLg0K
DQpNYXliZSB0byB0YWtlIGl0IGFzIGd1ZXN0IGVycm9yIGFuZCBsb2cgaXQ6DQoNCnFlbXVfbG9n
X21hc2soTE9HX0dVRVNUX0VSUk9SLC4uLiksDQoNCnRoZW4gcGVvcGxlIGNvdWxkIGNhdGNoIGl0
IGFuZCBmaXggZ3Vlc3QgY29kZT8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

