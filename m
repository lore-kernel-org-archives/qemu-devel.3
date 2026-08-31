Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88224C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qiN-00022F-Uk; Sun, 30 Aug 2026 21:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qiJ-0001yp-Sh; Sun, 30 Aug 2026 21:21:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qiG-0000P1-EI; Sun, 30 Aug 2026 21:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788139288; x=1819675288;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/ekPGpKAjtYvXlae5aZJyD0U+AuCTFLoezLqN/QhYyM=;
 b=oFasbUDBdIIB7GvyL/+Z7taRKtOSmbuGnRCUVqcKkXjePGHd42E+W3YX
 R2327VEgMiyaEybub7wFSGQwFeoFyiW0FbJjPmUpzxyAna+A+M9oyA4iw
 8iDoiwe5hT1lOWjq02fxiFjqfH3DmI7MHb5QOKxPanFkhtztuV9iIyj9w
 Fs93PQzhYcwZBUMcv2QAXbHLuRhXxOTSqqsZjvLI/4d5D7fLIgCITn90T
 9rn29hIdFuaw+jJMzZKTbI8jVHRmzFK3vjzpzYuYjHZ/xB8pDOAwcBZ6R
 wbpgea0HM2Q2nmJpnnUey8/BwKyZc09M0WtH85wsHxpYaPVyxuVbFH4WM w==;
X-CSE-ConnectionGUID: N91dMMXIQ9CLH1cuWaGFmg==
X-CSE-MsgGUID: R2W5Ir0yRpCSR+hX2s0orQ==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154365964"
Received: from mail-westus3azon11010008.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.8])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:21:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efsx9uNQpqu1rDV1PAX1y8dv8oK9bPeu55/tjpVTPOSOZq5vc4HzxQOU6PajWP6y3BNpL9Jl6bM7z+uHzJ8rMl3YkzXwr+cEhOCMzxAd5mcss9mVhaghkMzF4Ty8m3uMSfEuQqz8XYEvOF1ZNps1H4yYtaWUlksOlfCGEHYUCnOqS54xpqgMYulJUTxMni/cHMBPbOvBeRf6gDztdk+0fQ7qPqy3pyXTQcdgwKzYSctulF+o9mJgdQOqZZMtSWKYYOpcym59FEfc9bGmaXARjXbzXz4GcvxTwbexeRXPj1JKliAAmDzGJVBlrWrve980yHv6nhCYGCAl39N1moMJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ekPGpKAjtYvXlae5aZJyD0U+AuCTFLoezLqN/QhYyM=;
 b=NbDp80ZDSpykq0Iy46mewxZH2xsnTQp/KiqCpjCBdEZrPDfAdWSLAHT9q1ciVbHeD4CYbibSHJ3+23ZHbe2QzAjrbvdizeyBRnhhCstFFKpA3LXbGvFJUzyCzeSoyLWjHimRyf4hWjPtLT6M1YKJEz2bD89dHKbP/u4OOxBVvmMf53dWeltne6iZ0xsQWrqrO6aMocqf7A+chAM1gWjdFduK0Sh48+C+zKUNtywpM1kPiMvFHAJ3OT8l1IsPdn5bfsztJOb60z5h8uEZJfliMrQEnTUnXeTqzHq9E8N4tu97uhwUSJgX5onH74UrlR0eL2JJ33enFV7VJrD0qbkX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ekPGpKAjtYvXlae5aZJyD0U+AuCTFLoezLqN/QhYyM=;
 b=FDSOplk659kXvHFk1PSpJfbg77VaJxTlrVg/ht56QhIKgrmt9G7NSZUJSNsbNo0ilxmUK9WdadW+8Mp+lMaTgPCqdbELwq/QCk/25MHy1gPy+Y3kaj6nrSXHx0Oiigz+BmPAlsNAtvW3DwwCl0o4EOD4M9VYTJo0ndIgHRg+kZQ=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9402.namprd04.prod.outlook.com (2603:10b6:208:505::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:21:23 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:21:23 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 07/12] tests/tcg/riscv64: Enable memory record and replay
 test
Thread-Topic: [PATCH 07/12] tests/tcg/riscv64: Enable memory record and replay
 test
Thread-Index: AQHdNeJz0vYr9/72WEWrcLztnyQ3Ura3YksA
Date: Mon, 31 Aug 2026 01:21:23 +0000
Message-ID: <88d2d557888cb500cecdf162dd972a475e2b633a.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-8-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-8-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9402:EE_
x-ms-office365-filtering-correlation-id: 3d450f56-d564-4970-e00c-08df06fe2b77
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|10070799003|366016|3023799007|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: CALOBovOzI417qYmvUIEWcxM22SJivw3ksE4YIirHw84cu1PGqJUkVn454+SHpRnaZPDz4IL0iXPZUEztFrUYZKk731TdfbJVt1dNXoE3cHybw+ZXC8OGR6+5tTI5Yj/45XVz66qdYfpHSSuF4aB7HAUGnYuEfFKvWRUEnoO5l4uYVxH8o/4A2uRj/xk0DW4IWmUUbnVqM07emwAsQqQAvLDaXORxmI/5MvbXv4h9MYRTahbilmPl1AujLTiOFuW3+B1RC6wqxUaWck3fGBeEgNKIvuGLvuMutFp4PBvlqrxfgSSE8cHZIfLFSNb0idKJtagciYox1skYD1Q26S4X/MSQEVFY6m5CCPumAGVYebSStl6L4H/3iLCakQ3l/X/1x4RVUu+6Vd6vn7dz1ykZZUH97TNzHSDS3V+3Y7GkMeciwRwZAZQ8ZjhiEOoqcitUX8o27kO759X2WWt3pzJmiqLNbjibfl/ns+ksZqXK2zqmz9sQo2pM/PiJWLewFTORwitQaqFWXj8DBCyG9mAnJPadYsjXwqRWQGgp8KuELVMpiaqtwHNuUnB7eNDPTkFeYKorHudGAC1neqe6m3BbNu+gmX/mt+U5K2POHc9qLb8K68o9WNBczhbNVsKAL2ynrXXKqZh6ADvVbnHjNZ8N+3Jyn0x/TR+jJ/m+aEiRUnIBrE8Yfo9fJymF/8fzEZiXo0NZRPs/UpdacUfzwiacOgp8rUJ44Dm2jZgDFRXn0A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(3023799007)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djRYMnhDazhERkJka082aEdDQkVqWWxQSkJhUkowZ3NZS0x0d0ExS1BxQ0JE?=
 =?utf-8?B?UWxVWnhBQndvWDIvenZFTnA1dGdiN2k4dEY0a01oZFZHd3lSbzVxNkdndkph?=
 =?utf-8?B?U1R3d3ZxREZ5Zno4ZklXSFNJZzlUSE5NSW4vV3BMOUhkNkNBWCs2WHlyanV5?=
 =?utf-8?B?SWY1ejlXUk52WThKTVhPRUNVL1F3cGphc05SLzZCTjE1STZmMEJhT2ZXUUZ2?=
 =?utf-8?B?ZEVGUVNvdjMwbmpIbTdISlV2ZHNqZVNKNXB0SnE0dWJsNkY2VFlmZ2YwdjZr?=
 =?utf-8?B?TWdQY1djVUVPY0hzNHh6U3BtbGlWakV5NWNqNnYxazhCQVJoUlhtckdHa3l2?=
 =?utf-8?B?S0lQaTM1ajA1SEpKQlgrclhvRU5wa2Z3VU9IdFkwTUlQc3U2OFJLMU43bUFz?=
 =?utf-8?B?QXRqLzUxcXBHMGJqUHNHejhBYThZcS9ycXlGcC9tNFFYRzl0Nkk4NmZGOUpB?=
 =?utf-8?B?WW81U2dYWmpqT3hSUDdEMk1TUFRpTmVCTExsdjNscTVDMXBKRHFuQVdrZDBH?=
 =?utf-8?B?WU5pWFdZdHQxbmdSQ01vaEovQ1JtYUNkZHBLWG43RzJMcEZENEJVUlNxamJF?=
 =?utf-8?B?Z2VQNGw5WE1hbEhWQU45S0wrQXNnbDc0UjVaTE5oZXR3eDZLNnB0Y21vQk9x?=
 =?utf-8?B?ZVZNQ3JkRWJYWVJEZi9WRUlibmQxeDRFWnUwVG9vNW50Q1dFNnJkdm5oWVM0?=
 =?utf-8?B?OURId1hFUGdlTGI5OFo4YTBLWTVLdTEzcEhqRzRYMmQzVkNnMW40cjJFOGlm?=
 =?utf-8?B?dis2bDl4WGx6RjNIbHJSN2JsS2NNQ0xMZlJnazhzSEpENG5TUXlrRVFSUTRr?=
 =?utf-8?B?WTVocnRWaUI5eG4zWG5GcjJFbjYwUEZjVHhqOFFYVkhHNFJzUy8zSDQxRUR1?=
 =?utf-8?B?a0N3akpzLzhTWVNRQ0JES2ZhNlB2dzRISkhQL0Y3a0VTZmJNb2RYVy9xSVJH?=
 =?utf-8?B?UjE4RGVZOVRSTmZsTHUwVm54elJNdGlLRkY2Sks1TWdPUDBIdkhnYjRHQWJl?=
 =?utf-8?B?VWNEZmplcFhocURSTGQ4dlY2S0xTZndPVFhDd3psbGJEY2g2NVpUUlhoOEd4?=
 =?utf-8?B?c2lVUGVOOVQ1UW5LK0RBUGw2eHkrSUNvdXZOZzlzem4xVDI2UFdvTmtCdHpu?=
 =?utf-8?B?ZUdKY29ZaDNOLy9tMHF3QXYybGdwUCszKzJXR01PVWx2dUk2VjFhMGp3bG9Q?=
 =?utf-8?B?VHFOSlgyZVMxYzlNdXpKUytxcTlxTWxNZThJMlREUktjOWplOXZXdElNVk1m?=
 =?utf-8?B?cjZzVmNmeW9kN1pUNkFGSUtwNHYxdVVRY3N2YzJOSWR3bHp3TmRxc216QkpS?=
 =?utf-8?B?NWEzVEJXT1pyalFLZEtYa2o0Q3hEOGh5djYrcTZhL2lodTE4QTVSeE5XZ3Y1?=
 =?utf-8?B?Z0lERkI4SE16ZGNvRDBzU1VrblBENzRtN2gyNW0wM2FZQXVMSUxSMk9jYTlO?=
 =?utf-8?B?VUErOG9HYk1oZFlzS3FpNVZBYXpmUU9YVHFOQ2FCanliKzJkMlBjNkVIU2wv?=
 =?utf-8?B?ZmxML2o4VUJZaTFsd0FYS3dEV0lPdEZDMjJFaGN2Q3hidm55cC9zWXRZeXBK?=
 =?utf-8?B?Y09FSjliR3FKeDhna3NoUE9YVmhPV0cvWDJNbHBWYjJ3VmkvOStZeU1VREVl?=
 =?utf-8?B?Wk9BeXhzNXZXanBxak4wTWpnMWR6enFjdk0wRnJ3bHVhUk43WG1nZS9kYUNC?=
 =?utf-8?B?NVpqZUY4LzZXVTg2TGFsVytOVjlyVjM2QkNranB2cnpwZVpxa3NBaEVNcFha?=
 =?utf-8?B?WWZuWnRqS1RsOUx4RTZycGF1cXRKRmI3cEl3K0dHVEdYS1VPaWhoaHhVSmNT?=
 =?utf-8?B?RDVqYXN2L3A2ZUlTTjBEdFZVNDNWMUdYbkZwNEo1VHBEWEhMVi93bHhaQita?=
 =?utf-8?B?VjhuZDAwcVBFaUdMTnAzY2prQldRdVpMTm5KSmVoYndzUGxheXZabFdVdlVE?=
 =?utf-8?B?aVRmTE5DdkthSmRQRVF2TFJLZ0dYN1Z0RnBoODJzekJ0Q0JjMGsxbTRLVzhR?=
 =?utf-8?B?OUc3NDJBZGVCU1FKY3dCMmRTSEVEeDkwUytUVnQ1cG5EajVSb3RWdk5yZ25O?=
 =?utf-8?B?MTlBaDFoNTREZDJjUjAwcmtzZ0J3R0FyaWVvdEpXR1VSRzZSQTNtdkdJU1RH?=
 =?utf-8?B?WU1qU2RjOGNvdHNIOEdNYWhwejg0UEV4aUU3QWNCZFpXUHA4Y1ZMbUNFZEJv?=
 =?utf-8?B?b3FXVEJQaEZjbDBnMGlEU2J5TVZXeHZkOW5odEN6YkwzSTBCbW1oTmVGcVRu?=
 =?utf-8?B?RmdCOWJmS21rSVRSK1NGQ1ZtUmxEMjhOQnBpKzlYRkQ3THc5WGFaZDZQWUYx?=
 =?utf-8?B?NXJlRTZHUmFIZWZEMjR4K3dleWU0a3BEK01DbXA0QlJLSkJpMjB6VGI2YlRv?=
 =?utf-8?Q?QIwkYFtlDaipTYEDsRm9xTXCvxdOnDpd9DCJxwD1U37hS?=
x-ms-exchange-antispam-messagedata-1: B2xB6XhROYryZwV+remF/HDFcsNXX1NoIB4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50A62AD3BE8B184B99BE2F679CCDE8B9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PzBR+Y2GItT0J1A3MYfDbnZSk/55gf3+BBPH4efoYTkXYNK8nTtPNBAskY1qZkVfuBNz+yanE5+03LGEQy1F+zwiOZV7l+ZxWJdWETwRYLD0sXtSqaH7viljaMtDl4SOfo2ig2HnOzbJlCOYhe5wJThMXHFoIGsnN9WDFbvHYhTJiZ7WoNObzFoHJ78AuTKbAGZ+jDufYdSzUhtiT1wZRNjX3MtmxrYiUtexebMq4tKO8fzxzP/ngNhitONbk4COiAcQvjDLZhj9vxhadYH/N8W7/mzO37kycB5LnVZfts1HOYn0PXgb21M1bFiIPmbEmyerL18t1fofnFeoMBjN/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yNLP++0ZG37b4wpJxLWLvQvVfyIzXH7NJ724Nh0WgNEfrvynk+diQCSsUY2J96qENQ/wvjlm72yPmOZ1lj6Bj8kXoZFH4ND37BpZq/gTaSlzG0mGJjLquxAMtwJD0OmEdIdBVxCPxTDNe00oSKW84P769tin3i8XcF93+YTE69FC0hFSLJ9XfJVBqX9m13pQKjf2j1tBoXl75Tue2LuwSRf2lFnrupKy9/rCf0az71dpUGDbZ1jK7KRO/XqDOgTl2fgEMHPlJ4V1q+eUntJ57phKkqjEipmQkvr6rO9tyZohhgoInNaEATLI/KhIZZx6dHkHQvvRnMU8usOP3XAiMUDdwZHI9ygt8wcfHBL1UPW72xSS+tyZRAw1ugQi7dm9RKuwvxh5Sy/eDE8GY9mUuyI61W/N0lsH7+EUOCgN6uSqLr9z3BPp0lInEqd1bv1O7AqK21mpQgHABzu6IXIdOR5FRLeBzFNgo8aoNEL/TIgG6crCI2SudpuJh55VKbYujYrGD/V55E5y1xk05VhpZq6KPw7QvCvDiFl+cp0z+oGD+l7R6+HwLU0rkiZuQDWdMM5bDp5kq+7hZLrqA2bPI1eDyuQ6nFMlNV7Xqy3F3zwWRlElcWiXV6/LzjXprIZg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d450f56-d564-4970-e00c-08df06fe2b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:21:23.0393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+PIWojv01Dtl1oIt0kVyHBh9m4Z505JW5bhV6Lt+z6uvZdxz6lBkrp7QqgVkaQi9NM6Ajq7WGzsjTkTnmrZxa15PEGOE/lcNNJ9Z/4R2PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9402
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IFJ1biB0aGUgbWVtb3J5IHRlc3QgdW5kZXIgaWNvdW50IHJlY29yZCBhbmQgcmVwbGF5LCBjb3Bp
ZWQgZnJvbQ0KPiBhYXJjaDY0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9lbCBTdGFubGV5IDxq
b2VsQGptcy5pZC5hdT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0ZXN0cy90Y2cvcmlz
Y3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldCB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4g
wqAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGIvdGVzdHMvdGNnL3Jp
c2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQNCj4gaW5kZXggODJlOGZlMjY2NGIwLi4zZjJh
OGVkMTYxNDIgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRt
bXUtdGFyZ2V0DQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFy
Z2V0DQo+IEBAIC03NSwzICs3NSwyMiBAQCBFWFRSQV9SVU5TICs9ICQoTVVMVElBUkNIX1JVTlMp
DQo+IMKgDQo+IMKgIyBEZWZhdWx0IGlzIHppY2Nsc209dHJ1ZSwgc28gbWlzYWxpZ25lZCBhY2Nl
c3NlcyBtdXN0IHdvcmsNCj4gwqBtZW1vcnk6IHByaXZhdGUgQ0ZMQUdTICs9IC1EQ0hFQ0tfVU5B
TElHTkVEPTENCj4gKw0KPiArIyBTaW1wbGUgUmVjb3JkL1JlcGxheSBUZXN0DQo+ICsuUEhPTlk6
IG1lbW9yeS1yZWNvcmQNCj4gK3J1bi1tZW1vcnktcmVjb3JkOiBtZW1vcnktcmVjb3JkIG1lbW9y
eQ0KPiArCSQoY2FsbCBydW4tdGVzdCwgJDwsIFwNCj4gKwnCoCAkKFFFTVUpIC1tb25pdG9yIG5v
bmUgXA0KPiArCQnCoCAtY2hhcmRldiBmaWxlJChDT01NQSlwYXRoPSQ8Lm91dCQoQ09NTUEpaWQ9
b3V0cHV0DQo+IFwNCj4gKwkJwqAgLWljb3VudA0KPiBzaGlmdD01JChDT01NQSlycj1yZWNvcmQk
KENPTU1BKXJyZmlsZT1yZWNvcmQuYmluIFwNCj4gKwkJwqAgJChRRU1VX09QVFMpIG1lbW9yeSkN
Cj4gKw0KPiArLlBIT05ZOiBtZW1vcnktcmVwbGF5DQo+ICtydW4tbWVtb3J5LXJlcGxheTogbWVt
b3J5LXJlcGxheSBydW4tbWVtb3J5LXJlY29yZA0KPiArCSQoY2FsbCBydW4tdGVzdCwgJDwsIFwN
Cj4gKwnCoCAkKFFFTVUpIC1tb25pdG9yIG5vbmUgXA0KPiArCQnCoCAtY2hhcmRldiBmaWxlJChD
T01NQSlwYXRoPSQ8Lm91dCQoQ09NTUEpaWQ9b3V0cHV0DQo+IFwNCj4gKwkJwqAgLWljb3VudA0K
PiBzaGlmdD01JChDT01NQSlycj1yZXBsYXkkKENPTU1BKXJyZmlsZT1yZWNvcmQuYmluIFwNCj4g
KwkJwqAgJChRRU1VX09QVFMpIG1lbW9yeSkNCj4gKw0KPiArRVhUUkFfUlVOUyArPSBydW4tbWVt
b3J5LXJlcGxheQ0K

