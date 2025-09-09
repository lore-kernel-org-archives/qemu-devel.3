Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0382CCAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 00:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvmQC-0006Cq-Ja; Mon, 08 Sep 2025 20:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvmQA-0006Bt-CU; Mon, 08 Sep 2025 20:41:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvmQ6-00012s-Qn; Mon, 08 Sep 2025 20:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1757378474; x=1788914474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4QwiS6VV/JCAn53UJE9OTf2n93Bu2Rp090vACVx2TSs=;
 b=CUxm3FZbm3bShViWImYaOxq4yqf0gcDggLnXfvCKc2G7sH7wkI7aqhoS
 5/OtcuTEETfqBdYlPxbu+f5/aXS6AS+OOvwy8uI5CRjVhom777I6AcWBC
 TtUNuL207DnXcA6r5AMT7CHvo6bChPzYd/vra/1AlPFH+EJqOcxsNxvEm
 rqTqtwfWqU7gXBPe//4xqJQoHAjNA1NPczFKzbhr+/tX3N9hy3LMVIhKE
 Zurv0qLaDaAUQY5BJApE8TQx5nUNtwUaRh+UsentndSvwWoXXsxfToUFs
 o8g5g3jwQELb7UL+GVZevYwOpI3sZAK410a8tRIGZPsV7okU5AMHNpV+E Q==;
X-CSE-ConnectionGUID: /i0EJM8kSnedI8wSSYKAiQ==
X-CSE-MsgGUID: Fm7GUVJ9Ts6mwEZpT6YqOQ==
X-IronPort-AV: E=Sophos;i="6.18,250,1751212800"; d="scan'208";a="112560234"
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.79])
 by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 08:41:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwNiawI78l+a5WAHFoNJ5CjzOYfDI1M35OXEVrVSLrnKi4lUic/p/2P66nNmQzZ5QbPP3GOkCSpaxUxNWO/5qxrASkhpckij4k99asgmMm1oz9+lsPGeLY4MCp3s0DjQ7Gdkbg3/Ff382JR+ieeataotd7q48PZ5ws2xGbAaTfxtF+PdJwicXmoaRNIroprdRl9f9Y0RHCb5Et6r5f2Y6FzzC7F+kGoxAD+7Ceq6wEqzfKcGF8MagNjjS62NPTRBIDBFdFNotKJe8gC0SpvvClBEhj2LQAGoaCHHvdJVSOigsILaYGM+5Nbt+Z20bqP05Y4Jf0ASwRIllz9GJxg+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QwiS6VV/JCAn53UJE9OTf2n93Bu2Rp090vACVx2TSs=;
 b=WyspbEHSI+3Maamu7Jw8im6u1Gize1M0CXtc4Pss2EwDMNoz7b8e9TFRFR3vjSaPI6RORZTx8Kf4f2thZ9cK6Y0L2diOmYu64T0KK6RazoMy92ehPA2r1kXv23Y6I+YJvWFM7URwieC4+LdOAvut0YWvjRGtx2Ie+IX+JchOBGKaAiHqpC2+pb2VMXS8FFPl7j/GmnfjpzSvaTFcHXj8oL2Qw0LLqoxVnfzgJTlDqGGg5CXQGaTfClQYOWofO6KE0A6ZWQA9jweYGXwF8Yh5A5sl2WDs95FwGBk/5Md/r+jVOIyv6tM+fSkry4oFYPODS85dHwCSjboas7w0RRUoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QwiS6VV/JCAn53UJE9OTf2n93Bu2Rp090vACVx2TSs=;
 b=P+FNE0YaXSQgmYstAbJ690Ob5ltWMzfH25OkUL/aNkSnXwM0J3T+b7ydvtuXGgtLpoXBLmWSuPmso3YVwcUFXXkGaEQePRywjDYUHJ9tU/xpbgxVQiF785nLvkiDaxhNBNmTqJeJDW+6vfIKTFG9jywn7asebAYAvvK/emauTx4=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 00:41:06 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Tue, 9 Sep 2025
 00:41:06 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4 1/5] spdm-socket: add seperate send/recv functions
Thread-Topic: [PATCH v4 1/5] spdm-socket: add seperate send/recv functions
Thread-Index: AQHcHUm1W6lbnLSxlkeeRFj/xT6nYbSCzdOAgAc8coA=
Date: Tue, 9 Sep 2025 00:41:06 +0000
Message-ID: <4e258f0d1ef65f5bad372b9b269fa76c6783c615.camel@wdc.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-3-wilfred.opensource@gmail.com>
 <20250904111055.000026a6@huawei.com>
In-Reply-To: <20250904111055.000026a6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA6PR04MB9375:EE_
x-ms-office365-filtering-correlation-id: 0291afa3-0225-44bf-7900-08ddef398fd5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aS9BMnJmbFdPeXg0WFJjZ0dER2pBUjRLSnRYNEU1eEYxSTdtL0J1S0VlRG1X?=
 =?utf-8?B?U0lIVmVWRDQ3dWJJTENOWVhlYU4rbVhsMEZ2TEdGemtNdGNkZERmWTcvSlhq?=
 =?utf-8?B?SnlBN0NXTWdNMFpiTjFBNVZVTldBY3FBRkI2bG01QjRVNEM3L2F3cmN5WWly?=
 =?utf-8?B?dzAwS1BSQXJUakZjYzA4TUYwczNXY2VlV3g1YkZWNzNrc05VWFk2ZjZkakJK?=
 =?utf-8?B?VDFkR1dqQit4Y3pEbndQempUVGgxWllxb3M5ZUxubE41aDZsMDZLRVk3Z1cy?=
 =?utf-8?B?aHMzaGk1ZVYxZjhkNUJGa3p0OU9XdUNOQ3M0WW82ZXdHcXB5eng2eE1RTldr?=
 =?utf-8?B?Z3lsU2l3VGJWOFF2WGo0ZWJtYWxlazdZNGtNR2I5L1RXVmxUOEhMcDM4Zmhn?=
 =?utf-8?B?MStPRTlpRkVod3FsZjQycDREUVJ2clZmbVFmeEtDbWZPT0E5QUx1ZEY3V245?=
 =?utf-8?B?eWhna2ozVGc4NXk3RHo5eE95SUFzZzJFb1NmeEdUNzdXY3NaWnk3dTdxcklj?=
 =?utf-8?B?NGYyZkgrQVRtYU5DNVJCS0F0Y2pNRnN3Sjk5Q0NuQUdVZXBWK3F0OEJkQzBU?=
 =?utf-8?B?d1huSjNVLzhqd2xlVDN5UnRheWJWNWU5NXc4MlVWdVU3alIxMXZUeS9rYUt2?=
 =?utf-8?B?SmQ5SDZlc3I0VWxrcHBPWko3b1Q0ZTlIZm1jcHJ3cGFtcEx6Z1RpdVZRZUFx?=
 =?utf-8?B?OGpocGNJQTNxTGw0QWw5Y3pyMFprcE9UYlpBcnJQa3lMWFJZOVM5ekw3TW1N?=
 =?utf-8?B?cFhURmQ2a3AyNEp3VjhkOXFZVnBGeGdpMUJFRkRWT3dwVndoOThuaWhzM1ps?=
 =?utf-8?B?RlhPOFNzOFNaZVJRUzBERSs3MWxrSmxhZ1Y0WEt0L3d0SWVOQTZpV1Q5K25U?=
 =?utf-8?B?dEdqUW9BNHcvdjhHOFdhUkxvOWVpczRLMGp3dDNZeUlHQm1keXVKa2xuRm9l?=
 =?utf-8?B?ZDRzQXpRUnNCdE14Z0xGdFlYTnluSW55OVJUQ2thWCtYUkxXNU93bG1RVGV3?=
 =?utf-8?B?clRQUzVvUzhTaU5SZThJd0h4MDVvRTdtc3Y5cnduN0NXa3A2MzhCUjJSbE9y?=
 =?utf-8?B?TUJYTVRrNFp0aFhURDFXRzNRU1FGcFdkdWd5U1dOVit3cGUraXp6eHl3U1hn?=
 =?utf-8?B?WWlDaXFHSGlOSkNENHYyaHhqSXI4SXBybFFCaEM5aDhxb1hXeHlQaHZsUmdP?=
 =?utf-8?B?QlVLZWRic0x1Q3N1b09KbFlNTWl0R2RRQlp4RWQ5WGRIR2pXZzZjVWZCYkZX?=
 =?utf-8?B?WkUzZ2ZMeG53ZUJIU1pUR2JBbHFweHNuc1ZFdjltaUlxd1h2ZTI0czl4aklF?=
 =?utf-8?B?NTFaQ3MxQXNHSkxDVkt3bXpMQ0ozcy9UVnVwVSt6eEI1WW8rUzZtK2pydkpm?=
 =?utf-8?B?MHYwUkR6Skc0MUlpd2FEZnZQa0xvbVd3eUFJVkFxQm83ZDNrenB2ZjN6V1Zy?=
 =?utf-8?B?RWprUklxOXg2WjRYclRNY3NuZmc4SzYzMXBQUlZMamtTakx2VEpIUHJlRzRx?=
 =?utf-8?B?RmxOT2ZsenZRNlJSRmRTazhsWXRpQ1NMVyttMXdrMnZIbTVob3NlZjhGTmMw?=
 =?utf-8?B?dkRuZmwzd0dmMGp2dzh6M240U2dtUmtoenJ2UDVvUEQrM3VvdHRWSjF2ODJa?=
 =?utf-8?B?TXhFVXN6aXVVN1dodTJ1VmdmRzZMNjNVODIwYXlIRkJTR1ovR3B2NmVvZW45?=
 =?utf-8?B?UUR0Vyt2QzdOMmZEdnFlbDJpNGdRMHZ4N0JjK3BxYVQ0ei9kWW10blJIZmI5?=
 =?utf-8?B?c0dpWEg2Vk5aZXdGZ2d1OEFTMVhISjNIYmppdW9TRWR5ZUxZZm5SQTQ1UVFi?=
 =?utf-8?B?bGdXcUplbFUvU2c4Y3JRcmdnNmplU01ZcUVEM3ZQZVAwSnVlTHRHY1hCYTJr?=
 =?utf-8?B?akNaV2p1b1FpR00vWDJlV0YyOVpaMVhlaXRyRFFhQTJ6dStraUJleXZldVlj?=
 =?utf-8?B?ZDhnMlZVWlQxVXpaMGNKOEtWMUhoUVRZNGJJQTdnYTN5ek9QdDN6NlNsWktW?=
 =?utf-8?Q?C57ZmeXhv2nqdemucYG1wuv4BG4Y+U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzYxMDZTNXErSyt4Sm1tSE1FeGdLMGIxaWJWajJOcDdGZllBTVFBeFdYNW5G?=
 =?utf-8?B?dlhXVngxemFIeXhvL0lJcEJxL09XRWorVWtCRk94ZU8rcCsxOVc5T1ZITURi?=
 =?utf-8?B?cmRYU1E5VGdCYW01UkgwbXRZM3VFdkhWbDVJbmVMSlBkcUNoZzBUMnZseDlW?=
 =?utf-8?B?ZFZ2UWRhTFdnOXZKcjh0YnRWTGlMVWErY1g2T25GVis2OHdJZ2FSTys0OWFR?=
 =?utf-8?B?N1E1Mm5WWnNOb3lsT0k0M1lGSk5vN0RWbVB3dnQ4M0NxN3BPY0FHdVRMVDB5?=
 =?utf-8?B?QVVrTHYySGVjekkyOTJmMVBXbFNIT3dxV0JqOTdRUkJ5clpWMUh3YngxSG5W?=
 =?utf-8?B?V0U5c1Nrc3JZYjNwUlhhMUxkTGV6dXUvZnBkaHM2bEN0UTgrbGtkTXV6V3A5?=
 =?utf-8?B?cXlLMXlQQWx1MVEzNEF0VHJGVlY3SHpEQk9QL0N4M0g4eVdROGNteGdEbEpm?=
 =?utf-8?B?TVdzNks0ZnhqQmYvSlZPWXhFSFc5RlFESVZXc2p5QkdZR1hKelhCRndlS0pC?=
 =?utf-8?B?b2N2a3hQSTQxWm1KWllZQVJkMzFuN1NmcXVBUERETDk0Skl5RjErek14QTA5?=
 =?utf-8?B?Yk0yYjBqV1N2NTRmQjlFOTF5TkxxaW5PcmZCRFA5dzJiNnA2SGw3NDE5QUlR?=
 =?utf-8?B?aXpPdC9YbHA4UUNCcXlodjZmcU1NNXRsTVNkaG9WcDF2U3ZLaGUwamgvRkdR?=
 =?utf-8?B?Rk9ITnZhN2ZkdHBobUhSOG1tSHg1SG5Gdmd3SmZsNTA4SUo3c3BJc3Q0MTh2?=
 =?utf-8?B?cGE1cEI5TWxteEtHL2h4MXBxRU9tS01HcHB3UTcwSkczWHpkNy8zZlZKUkxm?=
 =?utf-8?B?dE04d2VKSmdVckpxRmpPOHF4aE9DM2hKMDcvWUhOOTQyampBU0kzZFhLTGJX?=
 =?utf-8?B?ck1iUWhHYkJNWDdmSXJabTAwYVA2cWhlZElDZ3dqQ0RLNDZVdGl2aE4zV05p?=
 =?utf-8?B?bWVaNGpmQWN4T1V2WjNMZFVIcEZpdFp3SjZNVVdsV3ZUSkZ1RGxnVXNuRXJL?=
 =?utf-8?B?alBDNGo0cHYwZ2V4c1AvT3N0ZVRTM0tVUEJmR2d2WGkrTVZWTW9FWHVQMmwz?=
 =?utf-8?B?a2czVVNBdWEvTGV2QXhQMUFMR0RieXUzaHBTbUpjT2tIZllKaXhyc2UzajQr?=
 =?utf-8?B?RDRZSUtxSTkvcTZlT0hEYktHc3FWWXZWSUIvdHJ3d3NSZzRRVml4SFVna2lM?=
 =?utf-8?B?bjlNb2VCbXk0dkNGaHNUYmcxRHNYSjVjSzJqR0N1a1lhQk9jTXBDOXdIS1pn?=
 =?utf-8?B?TDNvNkZLM1FGUEw5TVcvVkp2bzFGNnNHdFNQdkFTcE92R0F4OVhISHBQNkho?=
 =?utf-8?B?Z2dOV0h1bnRneEhZZ3FOUTJtbnlKVnVJK29mSEx4YUJnZVR6UFFWU09yMnpG?=
 =?utf-8?B?ZUhLMWs1Qjd6c2dmdFNBNTVkOTZSY0pMRFEveXZSa3NkQWFDSFJyVXg1RzFk?=
 =?utf-8?B?T3lFOE1PeEU5cnQwRlZ0U0RMU1RhbUlEaXBHcXpJYjZqSW5sQTUwWThVaGJq?=
 =?utf-8?B?cWxoVHozMk1ud3gwOGxLTGtTY1JXbFJPNTN4YkFUcXgrdkJ2QkU2dlprVk11?=
 =?utf-8?B?TWJIK2QrVWNGWi83TE5wdnVUei9oZUlEVUNtUVRNMDFXc0pLbDhXV2JydVg0?=
 =?utf-8?B?T0VNZXdpUzdKcXBxdHFHRHNIT0orSm5yc0NkNWExdVduclQwWjkwOURBL21M?=
 =?utf-8?B?UUNGQVc1T2FzQkY0ZTgxTnVqVmN1SGZCREJHYzFlbDV0czExL0VsTkNXa0w1?=
 =?utf-8?B?bStPQ1NWOW1lWHdmeFI4VDF3REVsWEhkVGN3MEhIZzRXV3BId2hVbktZSlN4?=
 =?utf-8?B?NCtRM3ZyNmxFRm0yTUh1SnFhNngwOW9CeVV1aFdTaXo4RFQ0c3V6VXZBaHF3?=
 =?utf-8?B?ay9Xd1FmelRsWUNHaGZqczk5dkpocFFKQXQ4cGFyT2tNdDJnQmZ0UlArOGwz?=
 =?utf-8?B?amlEeTQrZVp1ajQ4RDdsamp1bkowcklJOGYrNXNaSnZJVGhEdUhpMEtUeWJ5?=
 =?utf-8?B?WDFpZitycGI0TzJXQXM4R0UrWWRLUnZpRXpLY2RkN2dScnZwWmd2TnlrTXls?=
 =?utf-8?B?eXZXTkx4SGFlNU9LK3lxTk0wM2d5bVBSK29vekNDV2FmZHhYaml6ZmhUdGtt?=
 =?utf-8?B?RU5HVDhXRm16cnU4alEwakhoMG1LaDlyalA0eVJFTFNjMEl6bVZQQUNGbGZX?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68A13773BC23A3499E1EC05E53CEC420@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X5xf4wqltZ0jRcZuUol+TUM6NLu0Cadx1/rVw4g552qQK5jmFI9lNlPrOhB8flXY17q3W4iFj32/0JgxKFRXwmEDGktigygWGiLsHtUg11bGhG+sWdcrSanerLpfuxQXcMSm+nRJjKgkQNnNNdwdsmXbN4ZSZ2BG2flTKJyvpqgSixaF9yNv/1eIq9LL0nLplKOHCr0l2PwVhcjll00b6+16anlrMnpZJoj/8ROyvGTYlaRcFFCpwYUmWpsd3uysLbkVq5wuNCXMiFQFaQidDNxbzInBGYH2NQqV0w78dLqQ41jC0DapaLbQGojtbexBiMF9wodDKogBWvWTICPQ+MiO43Ay49LynHtL1qS3SaQQe3xNHKm766xNbiR+qA95R5AISVFweRhLCXXhYRrVtEu6tSIRmLhLQnCC2yALCqgjKC6BpmbHz3UU9J0CjI+1T1U/Cppawly22iDLFdsGUj4aobNxdEXHsJ7gj+Vpp/9Ai16IiBAmDLVpOnFUhllKDd7vHWSrp+634qSYlpmMg+VdcutFRnXk8WH711UFSe7P6fJcA++CEn0mlhGFYvKJf1Igdra5HTNiGDmyl+PBWU/51xfGXFq/8AutDNPj2lDcQbeuYnirN3MrSY53ErYd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0291afa3-0225-44bf-7900-08ddef398fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 00:41:06.1380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVtwCIfZ+jVIR7zNwSbixsTpTwJZyAaQG3RM0vqHBj/A7n9s3WmaAiyXTvorgfP2XBGvN0fIjN8AxGfhewxgtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9375
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=340207e43=wilfred.mallawa@wdc.com; helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDExOjEwICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+ID4gClsuLi5dCj4gPiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvc3BkbS1zb2NrZXQuYyBiL2Jh
Y2tlbmRzL3NwZG0tc29ja2V0LmMKPiA+IGluZGV4IDJjNzA5YzY4YzguLjNkMjY0ODE0ZGYgMTAw
NjQ0Cj4gPiAtLS0gYS9iYWNrZW5kcy9zcGRtLXNvY2tldC5jCj4gPiArKysgYi9iYWNrZW5kcy9z
cGRtLXNvY2tldC5jCj4gPiBAQCAtMTg0LDI4ICsxODQsNjIgQEAgaW50IHNwZG1fc29ja2V0X2Nv
bm5lY3QodWludDE2X3QgcG9ydCwgRXJyb3IKPiA+ICoqZXJycCkKPiA+IMKgwqDCoMKgIHJldHVy
biBjbGllbnRfc29ja2V0Owo+ID4gwqB9Cj4gPiDCoAo+ID4gLXVpbnQzMl90IHNwZG1fc29ja2V0
X3JzcChjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdAo+ID4gdHJhbnNwb3J0X3R5cGUsCj4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKnJl
cSwgdWludDMyX3QgcmVxX2xlbiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqcnNwLCB1aW50MzJfdCByc3BfbGVuKQo+ID4gK3N0YXRp
YyBib29sIHNwZG1fc29ja2V0X2NvbW1hbmRfdmFsaWQodWludDMyX3QgY29tbWFuZCkKPiBBcyBi
ZWxvdyAtIHBlcmhhcHMgdGhpcyBzYW5pdHkgY2hlY2sgYmVsb25ncyBpbiBhIHByZWN1cnNvciBw
YXRjaD8KPiA+ICt7Cj4gPiArwqDCoMKgIHN3aXRjaCAoY29tbWFuZCkgewo+ID4gK8KgwqDCoCBj
YXNlIFNQRE1fU09DS0VUX0NPTU1BTkRfTk9STUFMOgo+ID4gK8KgwqDCoCBjYXNlIFNQRE1fU09D
S0VUX1NUT1JBR0VfQ01EX0lGX1NFTkQ6Cj4gPiArwqDCoMKgIGNhc2UgU1BETV9TT0NLRVRfU1RP
UkFHRV9DTURfSUZfUkVDVjoKPiA+ICvCoMKgwqAgY2FzZSBTT0NLRVRfU1BETV9TVE9SQUdFX0FD
S19TVEFUVVM6Cj4gPiArwqDCoMKgIGNhc2UgU1BETV9TT0NLRVRfQ09NTUFORF9PT0JfRU5DQVBf
S0VZX1VQREFURToKPiA+ICvCoMKgwqAgY2FzZSBTUERNX1NPQ0tFVF9DT01NQU5EX0NPTlRJTlVF
Ogo+ID4gK8KgwqDCoCBjYXNlIFNQRE1fU09DS0VUX0NPTU1BTkRfU0hVVERPV046Cj4gPiArwqDC
oMKgIGNhc2UgU1BETV9TT0NLRVRfQ09NTUFORF9VTktPV046Cj4gPiArwqDCoMKgIGNhc2UgU1BE
TV9TT0NLRVRfQ09NTUFORF9URVNUOgo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+
ID4gK8KgwqDCoCBkZWZhdWx0Ogo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPiA+
ICvCoMKgwqAgfQo+ID4gK30KPiA+ICsKPiA+ICt1aW50MzJfdCBzcGRtX3NvY2tldF9yZWNlaXZl
KGNvbnN0IGludCBzb2NrZXQsIHVpbnQzMl90Cj4gPiB0cmFuc3BvcnRfdHlwZSwKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lk
ICpyc3AsIHVpbnQzMl90IHJzcF9sZW4pCj4gPiDCoHsKPiA+IMKgwqDCoMKgIHVpbnQzMl90IGNv
bW1hbmQ7Cj4gPiDCoMKgwqDCoCBib29sIHJlc3VsdDsKPiA+IMKgCj4gPiAtwqDCoMKgIHJlc3Vs
dCA9IHNlbmRfcGxhdGZvcm1fZGF0YShzb2NrZXQsIHRyYW5zcG9ydF90eXBlLAo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFNQRE1fU09DS0VUX0NPTU1BTkRfTk9STUFMLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcSwgcmVxX2xlbik7Cj4g
PiAtwqDCoMKgIGlmICghcmVzdWx0KSB7Cj4gPiArwqDCoMKgIHJlc3VsdCA9IHJlY2VpdmVfcGxh
dGZvcm1fZGF0YShzb2NrZXQsIHRyYW5zcG9ydF90eXBlLAo+ID4gJmNvbW1hbmQsCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKHVpbnQ4X3QgKilyc3AsICZyc3BfbGVuKTsKPiA+ICsKPiA+ICvCoMKgwqAgLyog
d2UgbWF5IGhhdmUgcmVjZWl2ZWQgc29tZSBkYXRhLCBidXQgY2hlY2sgaWYgdGhlIGNvbW1hbmQg
aXMKPiA+IHZhbGlkICovCj4gPiArwqDCoMKgIGlmICghcmVzdWx0IHx8ICFzcGRtX3NvY2tldF9j
b21tYW5kX3ZhbGlkKGNvbW1hbmQpKSB7Cj4gCj4gSXMgdGhpcyBjaGFuZ2UgcmVsYXRlZCB0byB0
aGUgc2VwYXJhdGUgc2VuZC9yZWN2IHBhcnQ/wqAgUGVyaGFwcyBpdAo+IGlzIGEgdXNlZnVsIGJp
dCBvZiBoYXJkZW5pbmcgdG8gZG8gYXMgYSBwcmVjdXJzb3IgcGF0Y2g/CkhleSBKb25hdGhhbiwK
CkkgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gaW50ZWdyYXRlIHRoaXMgZGlyZWN0bHkgaW50bwpz
cGRtX3NvY2tldF9yZWNlaXZlKCkgaW4gdGhpcyBwYXRjaC4gQXMgaW4gYSBwcmVjdXJzb3IgcGF0
Y2gsIGl0IHdvdWxkCm5lZWQgdG8gYmUgY2hhbmdlZCBoZXJlIGFnYWluLgo+IAo+ID4gwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+IMKgwqDCoMKgIH0KPiA+IMKgCj4gPiAtwqDCoMKgIHJl
c3VsdCA9IHJlY2VpdmVfcGxhdGZvcm1fZGF0YShzb2NrZXQsIHRyYW5zcG9ydF90eXBlLAo+ID4g
JmNvbW1hbmQsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHVpbnQ4X3QgKilyc3AsICZyc3BfbGVuKTsKPiA+
ICvCoMKgwqAgcmV0dXJuIHJzcF9sZW47Cj4gPiArfQo+ID4gKwo+ID4gK2Jvb2wgc3BkbV9zb2Nr
ZXRfc2VuZChjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdCBzb2NrZXRfY21kLAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCB0cmFuc3BvcnRf
dHlwZSwgdm9pZCAqcmVxLCB1aW50MzJfdAo+ID4gcmVxX2xlbikKPiA+ICt7Cj4gPiArwqDCoMKg
IHJldHVybiBzZW5kX3BsYXRmb3JtX2RhdGEoc29ja2V0LCB0cmFuc3BvcnRfdHlwZSwKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHNvY2tldF9jbWQsIHJlcSwgcmVxX2xlbik7Cj4gCj4gSSdkIHdyYXAgdGhhdCBjbG9zZXIgdG8g
ODAgY2hhcnMuCkFoIHllcCEKPiAKPiA+ICt9Cj4gPiArCj4gPiArdWludDMyX3Qgc3BkbV9zb2Nr
ZXRfcnNwKGNvbnN0IGludCBzb2NrZXQsIHVpbnQzMl90Cj4gPiB0cmFuc3BvcnRfdHlwZSwKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAq
cmVxLCB1aW50MzJfdCByZXFfbGVuLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpyc3AsIHVpbnQzMl90IHJzcF9sZW4pCj4gPiArewo+
ID4gK8KgwqDCoCBib29sIHJlc3VsdDsKPiA+ICsKPiA+ICvCoMKgwqAgcmVzdWx0ID0gc3BkbV9z
b2NrZXRfc2VuZChzb2NrZXQsIFNQRE1fU09DS0VUX0NPTU1BTkRfTk9STUFMLAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJh
bnNwb3J0X3R5cGUsIHJlcSwgcmVxX2xlbik7Cj4gPiDCoMKgwqDCoCBpZiAoIXJlc3VsdCkgewo+
ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+IMKgwqDCoMKgIH0KPiA+IMKgCj4gPiAt
wqDCoMKgIGFzc2VydChjb21tYW5kICE9IDApOwo+ID4gLQo+ID4gK8KgwqDCoCByc3BfbGVuID0g
c3BkbV9zb2NrZXRfcmVjZWl2ZShzb2NrZXQsIHRyYW5zcG9ydF90eXBlLCAodWludDhfdAo+ID4g
Kilyc3AsCj4gCj4gV2h5IGNhc3RpbmcgdG8gYSB1aW50OF90ICogP8KgIEl0IGlzIGEgdm9pZCAq
IGFuZCB0aGlzIGZ1bmN0aW9uIHRha2VzCj4gYSB2b2lkICouCk9rYXkgeWVhaCwgd2lsbCBmaXh1
cC4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcnNwX2xlbik7Cj4gPiDCoMKgwqDCoCByZXR1cm4gcnNwX2xl
bjsKPiA+IMKgfQo+ID4gwqAKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c3RlbS9zcGRtLXNv
Y2tldC5oIGIvaW5jbHVkZS9zeXN0ZW0vc3BkbS0KPiA+IHNvY2tldC5oCj4gPiBpbmRleCA1ZDhi
ZDlhYTRlLi4yYjdkMDNmODJkIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9zeXN0ZW0vc3BkbS1z
b2NrZXQuaAo+ID4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaAo+IAo+ID4gwqAv
KioKPiA+IMKgICogc3BkbV9zb2NrZXRfY2xvc2U6IHNlbmQgYSBzaHV0ZG93biBjb21tYW5kIHRv
IHRoZSBzZXJ2ZXIKPiA+IMKgICogQHNvY2tldDogc29ja2V0IHJldHVybmVkIGZyb20gc3BkbV9z
b2NrZXRfY29ubmVjdCgpCj4gPiBAQCAtNjAsNiArODksOSBAQCB1aW50MzJfdCBzcGRtX3NvY2tl
dF9yc3AoY29uc3QgaW50IHNvY2tldCwKPiA+IHVpbnQzMl90IHRyYW5zcG9ydF90eXBlLAo+ID4g
wqB2b2lkIHNwZG1fc29ja2V0X2Nsb3NlKGNvbnN0IGludCBzb2NrZXQsIHVpbnQzMl90IHRyYW5z
cG9ydF90eXBlKTsKPiA+IMKgCj4gPiDCoCNkZWZpbmUgU1BETV9TT0NLRVRfQ09NTUFORF9OT1JN
QUzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAxCj4gPiArI2RlZmluZSBTUERN
X1NPQ0tFVF9TVE9SQUdFX0NNRF9JRl9TRU5EwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAyCj4g
PiArI2RlZmluZSBTUERNX1NPQ0tFVF9TVE9SQUdFX0NNRF9JRl9SRUNWwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHgwMDAzCj4gPiArI2RlZmluZSBTT0NLRVRfU1BETV9TVE9SQUdFX0FDS19TVEFUVVPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MDAwNAo+ID4gwqAjZGVmaW5lIFNQRE1fU09DS0VUX0NP
TU1BTkRfT09CX0VOQ0FQX0tFWV9VUERBVEXCoCAweDgwMDEKPiA+IMKgI2RlZmluZSBTUERNX1NP
Q0tFVF9DT01NQU5EX0NPTlRJTlVFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhGRkZECj4g
PiDCoCNkZWZpbmUgU1BETV9TT0NLRVRfQ09NTUFORF9TSFVURE9XTsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDB4RkZGRQo+ID4gQEAgLTY4LDcgKzEwMCwxMCBAQCB2b2lkIHNwZG1fc29ja2V0
X2Nsb3NlKGNvbnN0IGludCBzb2NrZXQsCj4gPiB1aW50MzJfdCB0cmFuc3BvcnRfdHlwZSk7Cj4g
PiDCoAo+ID4gwqAjZGVmaW5lIFNQRE1fU09DS0VUX1RSQU5TUE9SVF9UWVBFX01DVFDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAweDAxCj4gPiDCoCNkZWZpbmUgU1BETV9TT0NLRVRfVFJBTlNQT1JUX1RZ
UEVfUENJX0RPRcKgwqDCoMKgwqDCoMKgIDB4MDIKPiA+ICsjZGVmaW5lIFNQRE1fU09DS0VUX1RS
QU5TUE9SVF9UWVBFX1NDU0nCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAzCj4gPiArI2RlZmluZSBT
UERNX1NPQ0tFVF9UUkFOU1BPUlRfVFlQRV9OVk1FwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwNAo+
IAo+IE5vdCB1c2VkIGluIHRoaXMgcGF0Y2guIE1vdmUgaXQgdG8gd2hlcmUgaXQgaXMgZmlyc3Qg
dXNlZC4KPiAKPiA+IMKgCj4gPiDCoCNkZWZpbmUgU1BETV9TT0NLRVRfTUFYX01FU1NBR0VfQlVG
RkVSX1NJWkXCoMKgwqDCoMKgwqAgMHgxMjAwCj4gPiArI2RlZmluZSBTUERNX1NPQ0tFVF9NQVhf
TVNHX1NUQVRVU19MRU7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MDIKPiAKPiBOb3QgdXNlZCBp
biB0aGlzIHBhdGNoLiAKU291bmRzIGdvb2QsIEkgd2lsbCBtb3ZlIHRoZW0gdXAuCgpUaGFua3Mh
CldpbGZyZWQK

