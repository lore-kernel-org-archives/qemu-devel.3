Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00566C3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOplb-00006x-6i; Tue, 02 Jul 2024 22:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOplX-00006U-B0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:30:39 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOplN-0000mo-Vs
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719973830; x=1751509830;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2pvUoXgk0WVEqS8vx70SMXU1veAOQVSzFrdKKwNe650=;
 b=xBfwNuvLTqqu8G+ivgq71ZYhKrnP+2S7RUDOCWoctIspUQDGRiCwpA+w
 KwVm1ZBZfT9AqcOisvvtrGBDwxtbVNFQ+UlmFWDJm4oa1sXL1z9qmoxFf
 ycJoWt6uxFDLmTh/a5NaaDnx4kNSihY8dPcjBFXeLGdpzIsbT8tNJunTm
 t0FUm8+yAa9RolsrBcvPke0dVpSWQ5A3rJW1Jw6nWoEeteNEbbHe7watC
 ZdJm3AA59AwOAwFie28RptteM+dqTnme3RdLGr/pAsW7biBOpS1RVyF51
 8cMl0nWhUCK2RFVkc60oKJczrNiWINqd+2tKC/uFTA+KuC2Fz1/OWAtJK Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="123609071"
X-IronPort-AV: E=Sophos;i="6.09,180,1716217200"; d="scan'208";a="123609071"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 11:30:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlFF4iqZUwYu7/QbS2KeXMneQ8uB941dlcTOqPKqka39Q0SieAaoTrJ9W00i1ErxNqo5tRZtpuEvtC4ydJnLpx+2f4mLz5c2xzeHUOZieJSlvxWnsnEYpEVqdIXoCitEXTqfpzH2uogJCfaqkcgit7ZSikGg/Ou0xUMoerDYBIe1ehCW6gFXRqRE47r9nlxy2C+dKpKxdFSCAACyGkRXTWaMJu9haZOhJez2bdjfmDQ6YI+ekx1SCeiXz6mAyLmxTH+Iz/94vl2K8Spbd1txeLU0TFlbbpuxR8BOCAUT4WzRSVByflZK4kTTIzjYHYb48GyZb/VRg/I1LSizAV8Lpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pvUoXgk0WVEqS8vx70SMXU1veAOQVSzFrdKKwNe650=;
 b=WP1SmQXcjz/oRsrnFjkqwS80JR6nGU/CmM+k95cSiI4Wv+cQdA7Tl2BGAcY3Cs6khIoLunP0AfbEruLtIOrrWfn3X52Phar1ecoz18SEijjXz9+djFuMy4jjR5LptP5iVfEm0meowVBWpljZp78Ndlh1WG6keHgGA+lipx16JetZ4lhAoOQA4Zi7vvN8O7h6dd3EcIv7IJbA3chLkP1d3cXINiSoTY/W8igt/xokvvDmr6yo5Ohv3m6gCjV91jRhE9KWBOhPsf0CeP2PdVMtGGvIzIn72v3nNs/E6RpbX1uCGAI/g8WikMneCk75eL/ywu1wwMWRA1zPMwNFufWLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYAPR01MB6426.jpnprd01.prod.outlook.com (2603:1096:400:94::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 02:30:21 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 02:30:21 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v4 5/7] tests/tcg: allow to check output of plugins
Thread-Topic: [PATCH v4 5/7] tests/tcg: allow to check output of plugins
Thread-Index: AQHazLAkb8756gmMyU6jXMNTKjPLUbHkSG+g
Date: Wed, 3 Jul 2024 02:30:21 +0000
Message-ID: <OSZPR01MB6453AE84AB32A9FDE298E67B8DDD2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-6-pierrick.bouvier@linaro.org>
In-Reply-To: <20240702184448.551705-6-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTkxNmUzMmMtYjUyMC00YzdhLTkxZjYtODI0MTA1ZDM4?=
 =?utf-8?B?MjUyO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTAzVDAyOjMwOjA4WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYAPR01MB6426:EE_
x-ms-office365-filtering-correlation-id: 5d94e2d1-49bb-439d-d5d4-08dc9b081631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?ZXdLRFRoNm9EQWJSakVZcHlWd0FETXZNVUJHVkgxOWVFWXZpdUJIbVFYa1N0?=
 =?utf-8?B?RC9iQUVPL0lKaTZ4UnZvK2kzRWRxWWx4S1QwWWRYRkxRQ0tkMnRkSzdwZ0Jm?=
 =?utf-8?B?U2ROQmtDMkRuYXFqQjJ0eWtCWmJjVUVzVCtHVEdWemRxZXoxaGxFSWpCM3U4?=
 =?utf-8?B?K0xZZkMxRDBDUm5aVldkY3V1RFZLeUNjczR5S3JFeCtrRC9SWWU3TGxEZGxy?=
 =?utf-8?B?bVVNRktLd0l1VlBJN21WK1QwcElaaTl5bFJtYkJ3L25MS1NLNCtzcVNKSjc3?=
 =?utf-8?B?Y2JrV1QyTGxWYTl3QjJINEF3blE2Tmg0NGRLWDlocXE1cEFXRW1uTGFZSXFU?=
 =?utf-8?B?MVAzKzdoR0Fxb3FnSW40M0s4V0FZUk50d2R2RXJtcFhOSGR6Z2dJOHlCWDUv?=
 =?utf-8?B?Vm9DTXUzZDlmUi9hclNmSDBtY3hZV1ZDeXlwRjlEaE1FKzBocVhZbHU2K3Y5?=
 =?utf-8?B?S01CSEt5QTJaVE5melc5SXYrYlVrZUovTWxScU5FUGZ3b0lUZytvRWFPaUJh?=
 =?utf-8?B?V01jaFNTRmY2WEVUUmczQUhzd0NyVXBsZFY2ZWVZYVY4cDNaZG5oQkNWRWo5?=
 =?utf-8?B?alJpN1FUQm4wUVU4UngzV0dSQ3U1c1c0OVpQNGRGQUR2dFdRRkw1eFBudENN?=
 =?utf-8?B?aW1NYWFvMXIrTkNCejBad0NVb2pnZmRWRnIwaFQ2eE9JQnY5b0xnMk9zOFpQ?=
 =?utf-8?B?Um02VHZud1FSbzFaaHNPWjlvbDRrb1oreHdTcjNPVXd0M3IwdTJNdTZpSUJ2?=
 =?utf-8?B?bkZJQnlpaHcvVFhtdGd5QVdYSzFHVi81U3VWaDJ1WGFSYnR5YklvWTk1SDdP?=
 =?utf-8?B?NWVibGM2YmJwaUtjTG1rZEtWUDg0N3BjYkYyOHBPbFl1N1M2UEcybmszNno0?=
 =?utf-8?B?c1JITXlaRytHemNCSThwZmxzeUJSMVdBcmhFUHYycXUxZmJBbTlmL1Q5TDBu?=
 =?utf-8?B?YUtBV2MwL1VheDlYZ0g0R1VxL3pFTmRkTTVnM25sWXFscTVVaE9vZGx3SGJm?=
 =?utf-8?B?K0s5eUVHTTBUd25SWkhsc3dZc09LT0xaTytuQlRRLzBybWhCN1puNU0zd2p5?=
 =?utf-8?B?YjVvRHZPcWdGd1BwNkVlY1o1UkcvbW44cXQwR1hIY2xGc1ZKenM4aUNpQXNy?=
 =?utf-8?B?dFpyOHhIdjlkUjh4NG1vUzNObnIxQzlOSUNMSkRMd29yUkIrUUFCUmhSc1V3?=
 =?utf-8?B?R0JleitWbmZra2psMlRBaU5saEdzNytwUitMNEFVZHBKRUsxSFg2MWRZNVFz?=
 =?utf-8?B?SmplMUZNZGZ4c3ZWaUNNNm9rbm1HZTdQZG51Z1ZnMzdGRTNHdVBqQ1Z0ZktZ?=
 =?utf-8?B?N2hPYjM3YWtkZmRwdndEVkY3U2ZMRTRrdEpZczlMVGNvUFhiZERKNE5EV1Rq?=
 =?utf-8?B?YXM5MjR0VlN6NWR5RkhQV0p4L0lmOUNMd3gvVUY4MzlFNkswZG9NR2QxTmJz?=
 =?utf-8?B?anNLY1JFZElqMjV0Nmw1bVlyMnI0SjZicjJMenZtRzlPMExwVXVCcUVNYkFE?=
 =?utf-8?B?RHloWXE0bW02VXJ3aHlpRWJtQ2psUjN2by9IYkNQYnpsaHNhWTZIM2pkd3oz?=
 =?utf-8?B?d0c3Ky96a0RtZkVkV3R2Ukl1d1JuemZrK3o3a1BCZmxndkI1RC9yTFdRTndi?=
 =?utf-8?B?NmZ0dHlmNEZ1alJzNUhkT05qeEYwRkl2VngyaUJ3anYzamNycEd1L0E4SDZt?=
 =?utf-8?B?d2dqTnBJTGtidFUwUXpNejVSMUI3ZkdKMDZYZ1ZnbE5JRiszaFhNTGtwTm9Y?=
 =?utf-8?B?TVM4UEk0Z2xSV3dOWWRQanlQRGZEKzB3aWdPWGhsaFVmZ040YStaMTkxYi9s?=
 =?utf-8?B?QktTYU95eU5iYmZCUzJyLzAwNmtPWVZvWTF0Ryt0Q3g4NW53VSs5VHlUaG5Z?=
 =?utf-8?B?eHg3RVl0bERISXZ5blNLL2hlc2MxQTJSczdKZWl6d3ZtRW9UemtaV1BEcFpL?=
 =?utf-8?Q?rSn+F4jKPDk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDczdnAraFQ2R1hHOXY1MEE5YlFOR2xZMnNmZGtGSW5NZyt4N0hjT2w3cEd3?=
 =?utf-8?B?YWtBTE5xZUhacERHYmpTUnJ2cHJOb0tZekpwZzZiZFNnY1hKNTRVcUN6N1Rh?=
 =?utf-8?B?T1ZjMWlkaDFRWVByZCtCd2JKMEV5RC96QzUzK1h6akJHdWI4OFM4bzIyZ3dt?=
 =?utf-8?B?MktWbTYyOHFDdHQ2OUtkSkRpcWlHdjlENk0rcGtiRHBSYVRRU1paRXd1cnhR?=
 =?utf-8?B?OFJINmJQWDhOMlRCMTJQbVRjNVV5TU5WU0xGVzBGaHJRM3lTc2dWUHU4dmxo?=
 =?utf-8?B?cms1VGFBRGErN3B6b2N0bDVkWkwrMjJGNUlvVFFhZ2t2OUg2bGJ5ODB0eXBh?=
 =?utf-8?B?WkJaUjFKUWpNLzJaT3ArV3hMNlhwcDE2SWJSeDdwQkNuL3p6Mk9UUm84WitZ?=
 =?utf-8?B?eFAzQ1BkcW55alp6L3ZmRys1dWhpK093UnlleHpDOTROb3ltS3VDZFdNUjBZ?=
 =?utf-8?B?S0o0T1B4WFZwMCtFbWNmUUVWU2dBSVZOL09DTDUvU0FqTCtKd3c5bHo2NTAw?=
 =?utf-8?B?SXBDcVBmY0hZVjM4VUlXR2ZmZWhCUG5YWEx2dmhUV04zOGM3bHRmbjZwZ0FB?=
 =?utf-8?B?Wm1kR0Rsd2NyNjN4WXJxc0V2OUV5Y1hKRCtRaW9mdU1NNEVsSlRtYWNqYTRt?=
 =?utf-8?B?ZU5NNnpDb29rK0U5TloxWWVUVTVrZnJqQWpOTU5wdU02aTRJNHZWZk1CNUlo?=
 =?utf-8?B?WHdtNk5FTVhGT1Z3ZkFrWUdrUmk2R0duYzAzeGI0U1NLRHlYYmd6M3pEbk1N?=
 =?utf-8?B?R25qMU1PK0k2ZVV6R1FCeG1YdmlaUE4zTDJCbENhMzdzcEhDS25IRTZQZllv?=
 =?utf-8?B?RFBmNnVIdEtmZkVVTExBVjIyNEZlOVJZaU9vSnZsaHltR2ZENXg0QkwvVVFI?=
 =?utf-8?B?ajlXOFRIL2dWeE9rWUMvemduNGhkbzM3K0M3T0VGTVBKc1VZVUQ2KzRNOGo2?=
 =?utf-8?B?NkhUSk5qb0RlVVZ1R21pakMzR2ZWWU51Wis4RXFjWW12bEd2SGZaY1A1RFla?=
 =?utf-8?B?bjgvR2dlbm9hNDVqQ1VDYlNSeHFrNHJkMTU2WG8xNDBVQjN0TFhXczZIQmxJ?=
 =?utf-8?B?L2FrY1M3TTRkeFRoRTQ1RnMyMW82Qk53bE1NWFlRdXpBQldublloTmo5c0Rr?=
 =?utf-8?B?dWI0S0djMitBYUhQYnFhTEhHb01rUStQRElKTzlMQ1QxdjlBaUNLTE9JVjV2?=
 =?utf-8?B?ODhESHFrN0JKOXZRaTc4M29hcWdwY2FNbzhGOGlqQzMrUWlBNlExa0VBdy81?=
 =?utf-8?B?dW4wcnVlVlNkY2lZVHUvUkwyWmZnRjM2M2tVd3NGZElXMkxxTi9ERHBBMmNq?=
 =?utf-8?B?dW5kM3VTRlNGcUJzZzRwbzJQYi9zYy9qWGp0bjNEV0JTTC82bnp0cUd1WkZp?=
 =?utf-8?B?ang5THdyM1d1d2tkWXJ5VFdDcVE5QTJQT3pFQ2dNQk4xdVhXZU04WEh3TnpJ?=
 =?utf-8?B?eldMZ3d3cHBIdndLZXE4YXI0MTg0ZHRaS0JnRlA4ZkxyS3M3K3Q1SVI4cW5o?=
 =?utf-8?B?cXR4dUs5L201dWJGMVFZTDlXMjV0SWE2UzdJQWF1bEoxQUhrTEhRV0xSOHFE?=
 =?utf-8?B?MGJlK081Z1JwSG9DeVY4UTZCNS82Vk5rOWxwQlZxcE5vM2JYR2pxZVVmVnFk?=
 =?utf-8?B?TlFRTW9QdEsrWHRDL2x3TzQvNDcxRkM1U1doVDJhTzYzR0VYczAyMFREM2Yx?=
 =?utf-8?B?QmpzQ2V3SG5tTUVWT0ZuNWpwT3c2UzJ3NlljNFZETHB5SHJoRy9ScUM3Mkxj?=
 =?utf-8?B?Qzc5RVViQ2dadVlSTmlaeHBJaUFwNXVmSVFCeXhjYXFBTjN0TVQ5eWpOZlI3?=
 =?utf-8?B?TFZ0bDBYNHlGTDZMVzVGeFVjdlM2c0had2hhemdFbFZOY1hmYmUzU1R4dEU0?=
 =?utf-8?B?OXBVTGt4QjA2VHBOb2RtTC82S1ljVmZGTE1iSzZ1S0FuZWlBTFU5QVphc0d3?=
 =?utf-8?B?Q0NHK2VVQzgwbXV0azl6bDlJeUxFSlZNMlFKUnh2QUpCS0l2U0lyN2phWVR5?=
 =?utf-8?B?WHBTYUZrUXdVbVQ0TGNDY1YrdGRIUUtTWURpZnk3ZHN5NVI5Ym5XY1BHcmhW?=
 =?utf-8?B?K3VCNmhWNW42VjBJeitYWERQSUs3YW1UMUdPbC94VDRZWWpuLzlQUHl1VlFM?=
 =?utf-8?Q?gypO9aWuSRW3E9Dc+woarckB/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZmtFd3CPY7+JFWKxT4AyDvXzsRnkxVjV0F1RqLUC6IZQL1G8/VyY95Xzc2huu+QhaFRmpsQ+RVHFpFAq1/humRTsF/iJXHatSX2O4A6jN2dloMK4h1ivyQ59DOBJCgMCcw8OvZ2+bEON+jkXR1/MwSQrkIqCEWJF3TPb17NB7lFHOEoOu5jzqQPI+yFdyXGNdjdduNjVjRGmaAri0kpApXZ4EwO2FZwGipaGivrEUm4I5tLKmXQVW4TZYI/xqw3Ouaz9lCZEhrB9Z4aMk17JJ996HJa/ou6OdOfoWv+CGBKbQVQEqecaEh6g9JL6O1tShATTKuTLbQQkwdlMkZ9BrbO0rvWLOHa3V/sm1vtHTGzNVs6uPLDMIbYoR6jZoVs6RtaeAi8fd4vHxBslEm28XibtQv0NHL7eEvuORLj+mbpNkXB4wQiOP1w199mUIIPg952nYi1hjNe3UbKhMuI2YsA0R6SEGj1y9hrhXSnaRWQ99JRNI+Wvm09GqO2UgyTf4bV6kQvdKGQJQLbYaIY1xCoGBQghYzfbv2Idd7dPQCazwlcRBu8eTP9DfMazQhG7N/Gu7OcHYaoj9zollk68BuNthXJBAQvjy+i/i5mHwaEN2iOLwHSWHZGFkIJIN/JI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d94e2d1-49bb-439d-d5d4-08dc9b081631
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 02:30:21.4156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZvAhqUdFCfBHIku0lKxcWncuOLXsHfOHG0iC7sylKd3n+Xq07a9VC5jQfsgTgUgs3O6l4hrDXpVJWx2Z4AV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6426
Received-SPF: pass client-ip=216.71.158.62;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa19.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGVzdGVkLWJ5OiBYaW5ndGFvIFlhbyA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMreWFveHQu
Zm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnDQo+IDxxZW11LWRldmVsLWJvdW5jZXMreWFveHQu
Zm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnPiBPbiBCZWhhbGYgT2YNCj4gUGllcnJpY2sgQm91
dmllcg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMywgMjAyNCAyOjQ1IEFNDQo+IFRvOiBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJv
Lm9yZz47IE1haG1vdWQgTWFuZG91cg0KPiA8bWEubWFuZG91cnJAZ21haWwuY29tPjsgUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPjsNCj4gQWxleGFuZHJlIElv
b3NzIDxlcmRuYXhlQGNyYW5zLm9yZz47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGls
bWRAbGluYXJvLm9yZz47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBSaWNo
YXJkIEhlbmRlcnNvbg0KPiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8g
SGFia29zdCA8ZWR1YXJkb0BoYWJrb3N0Lm5ldD4NCj4gU3ViamVjdDogW1BBVENIIHY0IDUvN10g
dGVzdHMvdGNnOiBhbGxvdyB0byBjaGVjayBvdXRwdXQgb2YgcGx1Z2lucw0KPiANCj4gQSBzcGVj
aWZpYyBwbHVnaW4gdGVzdCBjYW4gbm93IHJlYWQgYW5kIGNoZWNrIGEgcGx1Z2luIG91dHB1dCwg
dG8gZW5zdXJlDQo+IGl0IGNvbnRhaW5zIGV4cGVjdGVkIHZhbHVlcy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4g
LS0tDQo+ICB0ZXN0cy90Y2cvTWFrZWZpbGUudGFyZ2V0IHwgNyArKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL01h
a2VmaWxlLnRhcmdldCBiL3Rlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQNCj4gaW5kZXggZGM1Yzhi
N2EzYjQuLmI3OGZkOTljMzM3IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvTWFrZWZpbGUudGFy
Z2V0DQo+ICsrKyBiL3Rlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQNCj4gQEAgLTkwLDYgKzkwLDcg
QEAgQ0ZMQUdTPQ0KPiAgTERGTEFHUz0NCj4gDQo+ICBRRU1VX09QVFM9DQo+ICtDSEVDS19QTFVH
SU5fT1VUUFVUX0NPTU1BTkQ9dHJ1ZQ0KPiANCj4gDQo+ICAjIElmIFRDRyBkZWJ1Z2dpbmcsIG9y
IFRDSSBpcyBlbmFibGVkIHRoaW5ncyBhcmUgYSBsb3Qgc2xvd2VyDQo+IEBAIC0xODAsNiArMTgx
LDkgQEAgcnVuLXBsdWdpbi0lOg0KPiAgCQktcGx1Z2luICQoUExVR0lOX0xJQikvJChjYWxsDQo+
IGV4dHJhY3QtcGx1Z2luLCRAKSQoUExVR0lOX0FSR1MpIFwNCj4gIAkJLWQgcGx1Z2luIC1EICQq
LnBvdXQgXA0KPiAgCQkgJChjYWxsIHN0cmlwLXBsdWdpbiwkPCkpDQo+ICsJJChjYWxsIHF1aWV0
LWNvbW1hbmQsICQoQ0hFQ0tfUExVR0lOX09VVFBVVF9DT01NQU5EKQ0KPiAkKi5wb3V0LCBcDQo+
ICsJICAgICAgIFRFU1QsIGNoZWNrIHBsdWdpbiAkKGNhbGwgZXh0cmFjdC1wbHVnaW4sJEApIG91
dHB1dCBcDQo+ICsJICAgICAgIHdpdGggJChjYWxsIHN0cmlwLXBsdWdpbiwkPCkpDQo+ICBlbHNl
DQo+ICBydW4tJTogJQ0KPiAgCSQoY2FsbCBydW4tdGVzdCwgJDwsIFwNCj4gQEAgLTE5NCw2ICsx
OTgsOSBAQCBydW4tcGx1Z2luLSU6DQo+ICAJICAgCSAgLXBsdWdpbiAkKFBMVUdJTl9MSUIpLyQo
Y2FsbA0KPiBleHRyYWN0LXBsdWdpbiwkQCkkKFBMVUdJTl9BUkdTKSBcDQo+ICAJICAgIAkgIC1k
IHBsdWdpbiAtRCAkKi5wb3V0IFwNCj4gIAkJICAkKFFFTVVfT1BUUykgJChjYWxsIHN0cmlwLXBs
dWdpbiwkPCkpDQo+ICsJJChjYWxsIHF1aWV0LWNvbW1hbmQsICQoQ0hFQ0tfUExVR0lOX09VVFBV
VF9DT01NQU5EKQ0KPiAkKi5wb3V0LCBcDQo+ICsJICAgICAgIFRFU1QsIGNoZWNrIHBsdWdpbiAk
KGNhbGwgZXh0cmFjdC1wbHVnaW4sJEApIG91dHB1dCBcDQo+ICsJICAgICAgIHdpdGggJChjYWxs
IHN0cmlwLXBsdWdpbiwkPCkpDQo+ICBlbmRpZg0KPiANCj4gIGdkYi0lOiAlDQo+IC0tDQo+IDIu
MzkuMg0KPiANCg0K

