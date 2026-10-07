Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E124ECA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEX1J-0001C0-Cq; Wed, 07 Oct 2026 15:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xEX1G-0001Bj-JP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:09:38 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xEX1E-0004e2-P1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791400177; x=1822936177;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=O1gYWIyY/7mCFLyjC4FYHg+VBhn+KMg8Ehzhi8/Yw8s=;
 b=J/RvsTbLsnbZSmjJkrYJ8dplPQ0dSKmGfr33LtQMvHmc7tcf7pwyR0f5
 fZOypKXmGJUhxuQl6yYoVVv5gd80LV3U3w/i212b8pec8YHBxp9yrUjKu
 02isUWUBEUCFCJITJMkMfu2/TDtEB1YiI1V31ZVOxdoD2COUy+guu1MA8
 LUhbXnHHvTKCzRZreuxjJ1FTjVgK4Jh7wtLr0dlhNA7IX+Qve9YBd30RZ
 SU1+5n9V1e7I3ihq5/ZzyDfhnmGwzaSCIcM0LrCDgQ6z7nmVQ8rJcQh5V
 GetonGeCUQTXGF4YIHqIiajI+eXXL/Ze59HYfeTjpl/R5YdQTDXSjJD9n w==;
X-CSE-ConnectionGUID: U4WB9pHhQzaeDmrSNtoEeA==
X-CSE-MsgGUID: fTMOl5AIRZuJwMeTUtEuSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="181571"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="181571"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 12:09:32 -0700
X-CSE-ConnectionGUID: gkwfRlE7QymqbH1tbKQnFg==
X-CSE-MsgGUID: X5pvcdV7RtqXNiPx9N1kNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281263096"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 12:09:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:09:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 12:09:30 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 12:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbUizCfGjXUQEvWN8XDSfRBrKV9o95UjdOrevA4BwctuO1wFVWsS7VdpPMojoh+8HbXEjzPXXPf8W/G7Fdgu/SnUTwWgVhKdGhA1gNpgG99lQ2+mAvpHmIgRmSkBE7ZPXQdDBTT+wAVvnM7o5UrAPNs4gu1lvfC79+ni4ra6XtrhS1ZemhwY8UFTTbbo0qYFjI2VOqinF3U7eorDItKxGVrjwi40aJjCa71cJHGe7ItBe14xukBcfa2JSc1wgCZmfCIRPejfxYzNFJlOR9IStlRwut/deJFRJ3VdlPrjqBqpczF+8D0ZHZyyOBqApL2MMSzo/ooAGOpRpVeNAjHCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1gYWIyY/7mCFLyjC4FYHg+VBhn+KMg8Ehzhi8/Yw8s=;
 b=VbP6Efdq5H3Qz6kyoMriGcjt/INOCDOOg+/GtzraR/ZsKj63dbPQ3VOBs6aKGl9JMBrQW+xulb5mk97vfUzG9yW2+N6N13855Sea1p763cr0W/Vn1NJpM2FCAeWSVlJ/wbvqiWTQPbeWq8/U2HpkUfhVy/2LZyoPL6AT8X+NlwDBD9S3knj4EICLOOW7VAlhU/ZTvzl+okswFwf5WiknVl1xz9G4TlktKhlLZuC9viIYLGv31JlIaykqCGkaTH2wE4f3NP892XGPi8Fgh1os66Sv7Waz3fp2hIj1HV682yhWLMtfAPcYKWVTUZFQhaYGTebZ3duQw32cIaNw+zKofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from EA2SPRMB0006.namprd11.prod.outlook.com (2603:10b6:303:24d::9)
 by LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 19:09:27 +0000
Received: from EA2SPRMB0006.namprd11.prod.outlook.com
 ([fe80::78f9:bede:eb4e:c16b]) by EA2SPRMB0006.namprd11.prod.outlook.com
 ([fe80::78f9:bede:eb4e:c16b%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:09:27 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 0/3] ui/gtk: Hotkey and fullscreen handling fixes 
Thread-Topic: [PATCH v2 0/3] ui/gtk: Hotkey and fullscreen handling fixes 
Thread-Index: AQHdSgTEtbiDreDFi0CQ/EfQB9Orb7byiBIQ
Date: Wed, 7 Oct 2026 19:09:27 +0000
Message-ID: <EA2SPRMB00066DA87286CD23F17260CDFA942@EA2SPRMB0006.namprd11.prod.outlook.com>
References: <20260811102426.35538-1-dongwon.kim@intel.com>
In-Reply-To: <20260811102426.35538-1-dongwon.kim@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EA2SPRMB0006:EE_|LV8PR11MB8606:EE_
x-ms-office365-filtering-correlation-id: fb49443f-dd4f-4145-896a-08df24a6823b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|5023799004|56012099006|11063799006|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: I2ODvPUoYbh4BMZnzECbYGsdVGDw3pNQ9Yfd3skMBEOQhaH/9pMMMswRYbF8rrZEsrC9D8RunTPW8LUihWQ8nWHfL4b/rsWU01yIuzHzT9zrtMxFTYanDnQZkORC2i8wTaMEoa0ZiGQCbwT7Li78mAN2aoeMHyJLFhvazFgENK263j9mjtFAhfev2fylrhSJAk8Wq2imq6JBfRb1sZosPnlDKF94+3huVJAZCHgheF8tuEE33ogq27jn6EUPNRMw1biUzcBJ79MIEY3riyDcV72jeBA/BkSNJ3EedP48n5JzKsdZ9HEHv1cOO7LbZjpgbdOqUvTjT4uKVQrLBzBP6IFQohKdYKLjVi1sXN7T4FfFSXjJKsaIpBeGupkPQrl7H3dqoL+uTX5q86UqkqgRbiEhtt1YJMIVUUDDhzg8zOZBZi9q4ktexNMWuHeomfJ3yF6o9OE2Eu/ntnzoKi/fvD3IuOCb6UXLfBQSFRcmEHoxsP8RsXbIDKCw/KGZDCQNego1zdJ2H9SuHDcwa9ac0Uz+D+jPCBMZBHlqvIQsuQk4C3bV3LAeX201FHhyeFZtgCJHXSfDWc0ShZvUD3cbedeWdYW3oTBqKLiagaKTAxvgwr7+0oCV0yAdCPjnnlxwmf7N0cSMfJZ+tmDqyol1HMIZTh214wgZpQOzjCCL81RqNK1kci1JaiGKYVVLxmCYzVq2shaYasg64VaocthMkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EA2SPRMB0006.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FnM0ZTbURPRFhkaGRMaDcyOEpka25ld3V4YXF0YVlTWXBKeWdWaVZseVNX?=
 =?utf-8?B?NDAraW1aYkZGQ2orVndzbzZnRzVWcGhYQXRwREl5ZkxTbVlpSTVQTGdQNUJZ?=
 =?utf-8?B?ZU50NjVKOVp4NWJTeGpxNkpHNEd4YXFUdnplWStKM0daL1QvMklrQW9uWThP?=
 =?utf-8?B?Sk5wTGUxVlhBVjB6ekpaaHVDK3hsTmxSN0ZDaTFpYWNZdWpHOStIaklmWDBQ?=
 =?utf-8?B?MlBuZFFwRk4reXY3RkYxc1MxUWFUMXkxa1N6K2VkcUFadzdPUlhZM0F2Q3Jo?=
 =?utf-8?B?emUxbEJiUTBkK2ZQU0pDcnNwUHRrQXh4KytmNlZJTWtXd0lnWWpka2ZIQ3Zh?=
 =?utf-8?B?eU1RaVI5SW5aNkRZQzNCNnBaeXllaXJ4WkZ2OStrS3ZSOTg3bmwveVJjV0RU?=
 =?utf-8?B?dmN0WUp1cDRXQUlmcUdVVFVpcHgwbE53VHhwakU2NENYaVpBNEM2d09CRGlz?=
 =?utf-8?B?YXlUQW5VZXZhWlphVWZZL1lPSjRCRlM0aHpxKzNhNEtvWXh6cThkbHZMSUd3?=
 =?utf-8?B?cm5wSC9Fa3J1dzQ1Z2d5RlFuVUwvaGl0TVRZbjMwdXZkYTgydkhkMkxOaDBh?=
 =?utf-8?B?ZU9SZDRFOUlKaGh3ODVqa010SDQ0ZXJONzdlRDBRQnBTR216VHVXNnBwQWlP?=
 =?utf-8?B?Vmxid2crL2VFY2pDVmI2bXg5N2RXeTRaOFdIekpJODdTa2lXU0FBeE1IZGJ1?=
 =?utf-8?B?blpxNGNJbkpvVTI0Y1lXYTdiWmtabE5LLytYV0F2eGZZQ0RiVjJmNFhmSEc5?=
 =?utf-8?B?VzRxeWJtMUR2c0NWUC9oUG9MTjFLUGVnSWlvaCtIaFBUeStyeWRxaXZOQXNo?=
 =?utf-8?B?UmJYMDh2Yk5zYS9HdXp5bW1SMmsxUGt1RWQ5RDI4MnBmVTIzNEJpaHA0ZXpN?=
 =?utf-8?B?WVR0bVVnRW8rbEJJNE50bjl1QW9McUQ3U1daTlcvYkZWTmNrVmNUU0lmY1lr?=
 =?utf-8?B?SGJPaEREY0s1LzQ5R3hMZFkvMUpvMTdKZnJsbUxjL2NPRHpBSjc3RnRBME0z?=
 =?utf-8?B?cEtHZmt6U085bXN3U29rcE1JN0ZsbGVabGVQNSt2ZksrcVdjclBUcFBQcWNm?=
 =?utf-8?B?bCtFTGRCQlEvRHNTeW9xNzNGdDJmZHdaSWN2d1Qva1BGSlJ0RzhsaVZCM2FI?=
 =?utf-8?B?Uk80aXhUNnhKK0NZR2U5ZHdJM2hXMnRXdHNsOHlXdkVlMitZd21zRS9vYTdy?=
 =?utf-8?B?aHE1UmlncmE0T2lNekZDRS8zSDF1ZnZmVXA1WHZJMUZJVDVxN09TbHRkWDZo?=
 =?utf-8?B?SEozZ2JiVXJSVlBEQWo1clRXNWhMUHhyaCtZWGVxU0RzUWp3OFBFRUdBdjV0?=
 =?utf-8?B?aDZsVlhSNkdNOWdCYlpkVW9ndVNLYU5ZWWdQUkVmcTh6cXJ2WktsUXk5TUxq?=
 =?utf-8?B?MERMNVByUCs5MDhDYitHcUpuSnREM21TRkl2S3Y0empUSVozSW9oOEtoa1Yz?=
 =?utf-8?B?M3VIWGNSSjZCQy93dHFtWm1URWtJZS80azRVeUc5SStYYmxOMVZaOEJuN3J4?=
 =?utf-8?B?TEFuRXltMGVEMzB1Q3BBbWRqZFdGQy81QTBVQUhha2d1VkMxa1ZQOFYrU0Uz?=
 =?utf-8?B?K0dSaStlYVNqMGtKWm9PR21YUDBUVVZKbmwvWVhWemFYZlYxNjBHNWw3ejQ1?=
 =?utf-8?B?VGJSdzh5bkpZOEhVTDBqWVNzVDdOZU9pcjlqaDdiTFFzbmEwK0VlSW5xei9u?=
 =?utf-8?B?ZVM4QyttV01wRWpsUEZpRGg0ZlRIRzBMRERJVXZ3WEtEOENWbkladHVrVVRD?=
 =?utf-8?B?MFVaKzVncFkyeEJXQUxEZlFkd3cxTkNzcXpRMjJTMFV4R1N6bHMzK1p4ODlV?=
 =?utf-8?B?TWM2WXAxK2tvc1UrV1c1TnAwWWFnVmdZRUhmcVl3M3NJRlYxQmNQdWZxdGxl?=
 =?utf-8?B?WU55RzlGcXR1YUo0SHBwMnNnbVkxdktWcXFLeklpa2JXdTFoUEV2ZEZyeVo5?=
 =?utf-8?B?a21zM1Y5aHZqdEpDc0ZPTTBvZE1SS3MyTFNWY2NTcHkzS051MEZaNkk4YjBZ?=
 =?utf-8?B?V2RaRElRd3lld3ZjVHJQNEovWmd2bytjZXp5MHQ1Z2xRSnVnQy9WYVNnV0s0?=
 =?utf-8?B?cEhwd3grS0IzL295clVmNzNNQ3lNd0dveEJyUFVvYXFIWkh1aklQM1E4T2l0?=
 =?utf-8?B?N3krOUJHU2toK0dmUko0SGlEVVYvN1RSdmdUZ1RUWEtrRXFDaVJ5c1VJZVF6?=
 =?utf-8?B?YWNhUUFGNlFiaFpRTnF6eDh6YTd5QnlQa2dma0YyaXNMZ0h0T0I1ZWhrOEV6?=
 =?utf-8?B?dUpZZGhlcTE1bEJpSnpXaUNoanExR3VtTDlYbWZiMXNNbW5aMm5ZN2xScE43?=
 =?utf-8?B?MGpjSWc5OHoyYnFseHlodm1BcnB3RnA2enNsQ05WV0dNWDRQS3A4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gRswQlXL5e5QDpLpLnrhxkXY02EpXCzeYaFH27mFdyBBQB+Xi4hbHWtA06JL2V1gFQdGLWLrYGwYQqdoMn+P9u716fWqlO2RPNin+rszRYJE1aVtoQf8/s05EF/WeNocNLvC3guphzm0rq1gNWgRqWqplfEhuGoO5ZVYzvj5/GrAbyJ9cya0X4WUtFSTpJ/PcxOQpe2VKtMLWhZweIQadcpOsMLesyj4RkZUNSAcCsSo3EUJnh/evlxjwqKFukDi6OBg3UwiLFTka1sscDTtA2KYxnG+Bvs9hqC/pSQNZaEL++lFZKfuf4tjIc5tY+Jxs05fk7014SQry6BQbiNLBQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EA2SPRMB0006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb49443f-dd4f-4145-896a-08df24a6823b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 19:09:27.7404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkSJdSd1+fDyMcLVGORzCA8VqYCeLYdAbnTqtAb1BWYs5BHYaluer0pQnZMp1bKHZyWo/vFziEZymYNXxQ3BqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
cWVtdS1kZXZlbC1ib3VuY2VzK2Rvbmd3b24ua2ltPWludGVsLmNvbUBub25nbnUub3JnIDxxZW11
LQ0KPiBkZXZlbC1ib3VuY2VzK2Rvbmd3b24ua2ltPWludGVsLmNvbUBub25nbnUub3JnPiBPbiBC
ZWhhbGYgT2YNCj4gZG9uZ3dvbi5raW1AaW50ZWwuY29tDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3Vz
dCAxMSwgMjAyNiAzOjI0IEFNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVj
dDogW1BBVENIIHYyIDAvM10gdWkvZ3RrOiBIb3RrZXkgYW5kIGZ1bGxzY3JlZW4gaGFuZGxpbmcg
Zml4ZXMNCj4gDQo+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+
IA0KPiBUaGlzIHNlcmllcyByZXNvbHZlcyBzZXZlcmFsIGlzc3VlcyByZWdhcmRpbmcga2V5Ym9h
cmQgc2hvcnRjdXRzIGFuZCBmdWxsc2NyZWVuDQo+IGJlaGF2aW9yIGluIHRoZSBRRU1VIEdUSyBV
SS4NCj4gDQo+ICAxLiBEZXRhY2hlZCAodW50YWJpZmllZCkgd2luZG93cyBwcm9wZXJseSBzdXBw
b3J0IGZ1bGxzY3JlZW4gYW5kIHpvb20NCj4gICAgIGFjY2VsZXJhdG9ycy4NCj4gIDIuIFRoZSAi
R3JhYiBJbnB1dCIgYWNjZWxlcmF0b3IgcmVtYWlucyBmdW5jdGlvbmFsIGluIGZ1bGxzY3JlZW4g
bW9kZSB3aGVuDQo+ICAgICB0aGUgbWVudWJhciBpcyBoaWRkZW4uDQo+ICAzLiBJbml0aWFsIGZ1
bGxzY3JlZW4gc2V0dXAgaXMgZGVmZXJyZWQgdW50aWwgdGhlIHdpbmRvdyBpcyBwcm9wZXJseQ0K
PiAgICAgcmVhbGl6ZWQgdG8gYXZvaWQgZGlzcGxheSBjb25maWd1cmF0aW9uIHJhY2UgY29uZGl0
aW9ucy4NCj4gDQo+IHYyOg0KPiAgLSBSZXR1cm4gVFJVRSBpbiBhY2NlbGVyYXRvciBjYWxsYmFj
a3MgKGdkX2FjY2VsX2dyYWJfaW5wdXQsIGdkX3dpbl8qKSB0bw0KPiAgICBjb21wbHkgd2l0aCB0
aGUgR3RrQWNjZWxHcm91cEFjdGl2YXRlIHByb3RvdHlwZS4NCj4gIC0gUmVzdG9yZSBzY2FsZSB0
byBwcmVmZXJyZWRfc2NhbGUgYW5kIHRyaWdnZXIgZ2RfdXBkYXRlX2N1cnNvcigpIG9uDQo+ICAg
IGZ1bGxzY3JlZW4gZXhpdC4NCj4gIC0gRGVkdXBsaWNhdGUgem9vbSBoYW5kbGluZyBieSBzaGFy
aW5nIGdkX3dpbl96b29tXyogYWNyb3NzIG1lbnUNCj4gYWN0aW9ucy4NCj4gIC0gR3VhcmQgem9v
bSBoZWxwZXJzIGFnYWluc3QgTlVMTCAvIG5vbi1HRlggY29uc29sZXMuDQo+ICAtIFJlbW92ZSBs
ZWZ0b3ZlciBkZWJ1ZyBmcHJpbnRmIGluIGdkX3dpbl9ncmFiLg0KPiANCj4gRG9uZ3dvbiBLaW0g
KDMpOg0KPiAgIHVpL2d0azogRW5hYmxlIGZ1bGxzY3JlZW4gYW5kIHpvb20gaG90a2V5cyBmb3Ig
ZGV0YWNoZWQgd2luZG93cw0KPiAgIHVpL2d0azogUmVnaXN0ZXIgIkdyYWIgSW5wdXQiIHNob3J0
Y3V0IHRvIGFjY2VsX2dyb3VwDQo+ICAgdWkvZ3RrOiBEZWZlciBpbml0aWFsIGZ1bGxzY3JlZW4g
YWN0aXZhdGlvbiB1bnRpbCB3aW5kb3cgaXMgbWFwcGVkDQo+IA0KPiAgdWkvZ3RrLmMgfCAxODgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4g
DQo+IC0tDQo+IDIuNDMuMA0KPg0KDQpGcmllbmRseSBwaW5nIG9uIHRoaXMgc2VyaWVzIHdoZW4g
eW91IGdldCBhIGNoYW5jZS4NCg0KVGhhbmtzIQ0KRFcNCiANCg0K

