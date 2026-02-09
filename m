Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8927FEF06ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHvI-0002Hf-KG; Sun, 08 Feb 2026 22:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpHvG-0002HM-Lw; Sun, 08 Feb 2026 22:26:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpHvD-0002hp-E7; Sun, 08 Feb 2026 22:26:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g79pxzLNcd+hTQ+9SC5KaCLADv5SfJGLHLmcrRPg0T1vruloElibfY7MGdMYiCB3DeG9MKgJ1cs3IXPxjjO8XGxQvzZIIrj7pRlLQMYw0GdktMlF4z2oUiJ72VxLpLFtm21dHXNpaZPo2qA66eD6aACIzntlrU9NgcnFYBDET3MDAwBK41n+7vBizFp6cN7uvDhDO2F1lKCv1+5RtoKApEwIHqWVC4rOU1Fb7VJwmXpCFjEHMqc6NWby7wwVd9Bscxoqk2Ix9hqk1te+QZ3cRgoeFWLRBaUkypjTCVTGZFUZsjv2qPjDEZIo8tzbT6Y43I8GmJ2G2XJKgp1BFtrHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9/7kjoA2VYwaBtZvxmyViHYY141DWoDZFg4abtZ9Xs=;
 b=fPsiBvAgxfmCqZhL8aetrbcY3KeJD/kuK3vHjvZuNUeCczO07iqzwEN34dgE+NVG8/99gai8eR0FrnR5zYC3UpDeHYg0aF3FAuEpe6102a96eWaFig8Lop3LU30dEflLvrOnl8EHsOz3wVrtnEzm0ncE2iiO+D+gf76ijAwGjKs6WH1Gbp1xY8vGQqWbJvhB5aua95wQClY1iwiDjeg/NLYB6Vhjpveuw1Z1lCE6/2d3d602UFLSfPoUJhMncOc64KjjqyleqpsXIUgyTlMWTXKILNH6QeMCmzN0cEf+zoTtnen5xt15/wTgkZugjIWrkkgqX8eO+Q2eUSecVHGdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9/7kjoA2VYwaBtZvxmyViHYY141DWoDZFg4abtZ9Xs=;
 b=V/v0Sungz0svaWJN1q/X28FmrQS9oj0Ur6W1ASErKiblv2ypznUttGt3/8kbk/RSFZsqFySKDff9xAmbkEXJD+mlOGTS4GxJc4Sv2DTZZWfNrb/PjyJsxY8R86TM6fBvq7urmML+K5lX+VeU/atyuPWGz+TtOv74xi68hto804LJb1jH+z72XIyRyfou3+1ySAMpyVM7NHq4Z5membveNH+Lh0Ug/W3K/nfESHKn31AOR+SUv49XVwkVEF7hgpl9idPPiJOoiQ5p84VytseTYSTIldiwX4gK8vi5KftFm+RVCgfqITIJOWpNTFao+hDBpI7u4hXDxcOEdLDJlokNUA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB7161.apcprd06.prod.outlook.com (2603:1096:405:8c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Mon, 9 Feb
 2026 03:26:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 03:26:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 00/10] Support ASPEED AST2700 A2
Thread-Topic: [PATCH v1 00/10] Support ASPEED AST2700 A2
Thread-Index: AQHclyom2186LUNFREyi/PlKsz01c7V1aSIAgAROi9A=
Date: Mon, 9 Feb 2026 03:26:37 +0000
Message-ID: <TYPPR06MB82060421095B73D157D1D7F3FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <fd3c6343-22b6-4573-a177-46e14a0aa9f4@kaod.org>
In-Reply-To: <fd3c6343-22b6-4573-a177-46e14a0aa9f4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB7161:EE_
x-ms-office365-filtering-correlation-id: e544c1b2-bc00-4d65-74d9-08de678b08c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?VVF3eDdlMVpWS3hDTmNpR3dZdDNoMkdGWmFobFJhOHdINTN1Z3hGS0NUYTZl?=
 =?utf-8?B?S3RmZ012N21Cdnd2cGRJQXVGYkt5WFczT2EzMjVHUDRDY1hWeDNmZFA0WEdr?=
 =?utf-8?B?L1cvblFWa3B6WUdQTXF4MHlGblp6ZmQyNXpBKzJON2wrcVlQZ05pbG9KTWMy?=
 =?utf-8?B?UENEOTFjejh0cUMwb09RREhFU2ZCSFpBZ3VRemZEL3ZwNlhnQ1UzMDJWU1U2?=
 =?utf-8?B?QnRrOEV3Mit2aWV2Y1ZyOHdsVDZKZ1FhaUtsWmk5VWh5VWdoVDVWWDlKVjdx?=
 =?utf-8?B?d1hTcEpLWm9lMElVSXprNnAwL3F2WlFSN0NlNjBwUytrYkFiTkxzZ2Y3UGU2?=
 =?utf-8?B?eGk4Sys1MFVlL0R2Nk9UcTdlYVRBR2FsZlpFbzJJVEMwNjhXQUo3RW8wL2d4?=
 =?utf-8?B?MlYyN1VSd1VwbWJLNFpueXRlc0lWZkNQNGZYQkxOQkhOdWRyQjNYaGlZRUVo?=
 =?utf-8?B?YVB0dVlwOWtXZGkvRFJZWVhWOEdvQVA0R1BUN2NqRnpIM2J2bnRyQnZzSUV6?=
 =?utf-8?B?TkxBTmxUWDR5RGpKdnZoODRTM1pkQkdnNkNDYzNLUUhkYjM1UGNsMEtlZXlI?=
 =?utf-8?B?YVRtRWt6K0F2Qm8xTXVLODlSN0NmYUxGdEZURER0WGVLbEpYNXdIakRSOTEw?=
 =?utf-8?B?KzlUR09RS1BaOENHRG5INUVRdUtJVGpqbEpSM1NvbWpjbWl1RkNzTHhiUFNu?=
 =?utf-8?B?VXQzTmNKemw0c25WVC9HRzdCeEY5RWRUM3VGL1NpY0VhUzBQWTRCZXNxT3A3?=
 =?utf-8?B?bVVqZXdvOGFienIxMTU1eS9JamhUQnYzcGlKU3NsQ3NFV2JoK1FHd2xpZmgx?=
 =?utf-8?B?dUo0WTRHNURrSDBSVis0Q1E4OXpSUU1YcjAwdi84TTZ5eHNNR3RTZWFjUUZC?=
 =?utf-8?B?dm81bTNuRGw2SGliSXowVkF3WXFBdjhHMUZyRDZyZlhkck8rVElRdjVIcjZ0?=
 =?utf-8?B?R3EyTytKMms5UHNYSUhhOTZQUk5IUUdXeUNDV1FGcTlCbUo0T2NicVRpT0Ro?=
 =?utf-8?B?Tm9FUVRHM1NBQkMyeENRd1BOVi9Fb0owcER1NUhGRGZqQmF4SFV3a0pYcHdC?=
 =?utf-8?B?dzkxUnFVald6SEZ6ek1SSExSK21oM3FVQUQySXpHakFQWGFSU2U3RGlmL0N3?=
 =?utf-8?B?eHRnVlI0SS81UlRzMDhNbnVCMGdTeWRkdEhuK1k2ZDNHYnFGT0RNMXJ1akZN?=
 =?utf-8?B?dGhIZm1NcUNWUS9GQWwzdlJWRHl3Tk9WcFN6Y0dCOGoxWnhKU2g4V01sUUd4?=
 =?utf-8?B?eWpuSGt3b2ROS2JvaktIMHFlQ25aYit6WWhjQ0lsMEVrcnlKaXZRR2NJMERE?=
 =?utf-8?B?WldXaG9JendzaFBzaXJBb1FYdGdUS3lreUhGaGpIdjkvMUVDaS9EU1pHdE9V?=
 =?utf-8?B?VFhDbVBVYytBZDBnUWpiMDR0RnpmTWt6S09uZDFKZ3lXOEs3ZHdFanZXN2E3?=
 =?utf-8?B?VksvOFozb2FZUE1GZE1oMXlFUTBPVUd6a1JVQmhRVXVvN1c0OTE3Q21TZkdt?=
 =?utf-8?B?bTlsZmtMS1hHcUp0WnFGMDBqS1NHNTk0MHZjdm9DdnlhcnRyb1lTUHFObG5U?=
 =?utf-8?B?WHA5bmZPSlpWbWpBemtSbWNlNWFXdnFlOHpicjV5T0JoWkYxQ25ZVjJWNCta?=
 =?utf-8?B?VGIyUTR6U01FQjBKbUFZbktKT1BiNksvQ0NFekk0WG13ZTVsaVJFUzYwdGxE?=
 =?utf-8?B?RUZlMXQycGd5ZkNuYk9VZ09hUHlST2JXSnNFRjFuQ1YzS0FiU3BrZjk5Rnk2?=
 =?utf-8?B?NlIrWXBITnBRWjRYblh6ZG1hZG1kSjZWZi9acDlSdVVXWm5qTW15end5bGpv?=
 =?utf-8?B?UHFsblN6L3pSajZ3eHhxeWMrUGhLMUo3UHJsNitMcHI4UXlqeUdRQUpOU0p5?=
 =?utf-8?B?RlNoNUFDajFuUEJYTklza1VWWlhSU0gxUExoK1N0ZHNMbmVNcmp3WTFxV1Vx?=
 =?utf-8?B?d0VLeDU0VGJYOWpBLy9oUHFGY0E4TXN1VmlLbzlwTUhud3BjdGgrYllQVWJp?=
 =?utf-8?B?K1pqd2xPY0NseXB4aEZESEhQYU5aL2k1ZzFUMUVVaU1qM3d1T2FQWkJIRVBD?=
 =?utf-8?B?ZVFkRE85blk4QmFoMFFMaU1UQkVTclZlQmw1eURxSzg3NDZza3ZxRjE0YWpm?=
 =?utf-8?B?U1ZpTVg1RlpzOEhvQm1IRmEzb1c3L1RhOEg5Rmg3MVc2QXovQWlkQmhvU3d6?=
 =?utf-8?Q?KqNugJ5D/jV9Q7IRCTKxcJz6OEAWkGHThGWtDZ7hEQnx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWRkeFMwZjhzbCs4NE1WeTJkRDJ0NkRtV1NxRTJxYStSeTd3WmJmNThRSkpw?=
 =?utf-8?B?T2FjSE01UEU1WWpLWE56TFJVNjQwNUhqMFg1MlhRTmptTXlUT3h0UlVuaFht?=
 =?utf-8?B?UlFTRHltQlEzVURvck45elFha3ZGeFNFdjVZbE9QNnpvWXhDZEwyTFo1ZnpX?=
 =?utf-8?B?QjNaaUpUM3dnY1RtcGFMdnplV3R6NEErajlIa1p1aDdkQUdkczBXZFA1Sk4w?=
 =?utf-8?B?V3Z6RFhRRGhlYlFmbThIclBTVzBxU3ZNTlJhaVplQ0JYNjdTbDI5TWJqbVJT?=
 =?utf-8?B?RkVTTXp6ckcxeThEZWw2WlR4YlpQL2thc3VVazlVTVJvU3E5Z2tZOHpYKzVL?=
 =?utf-8?B?ZW1ocTd2dC9OWTUva1hvdUdWOWtiekRMQ3c2Smw4aHk1bkJ5VnVZMWIybDlS?=
 =?utf-8?B?bmlueHViMEUrTnpmZVFvdWFTdS9TTHdQSVJrN2ZQblRyemtXaDhVSGRTWjBv?=
 =?utf-8?B?STZOWmozZk5BcWZWUWlFdXgvVEl1WHRRQ3lIY1UrS3BxMlptdHFQa0oySjlx?=
 =?utf-8?B?RUdlRWFKVnFjb0Vkc0VRSTJDQmxkZGluSmtkV3FLRmdCQTY2QWVUMWlwdXdE?=
 =?utf-8?B?RlJveDVKZ2Fsd29WcE5Xdnl5NGNQMDdBVm5NaWRHQjg3emVqV1JVa2tOeDFW?=
 =?utf-8?B?dURiK2lIY2I0U1dPV0hDYmRpdUVSMGVwU0lPaUw5Q1RCc3lDcUVQM3RDWFBa?=
 =?utf-8?B?dFk1K3RRRDNhVFpaZUI3Wm1NV3JLMUV1c3VINU0yTHBRa0ttQ2phRnl0UFVW?=
 =?utf-8?B?VUxuRk1WRUR1TVl5WVJYTlpqbEVNc3QrRm5HTTdzTmQ1UHRMQ3k5bVBRbXdO?=
 =?utf-8?B?VXk2YjJWNWpOaGQ1UFZ4VHUwODBIbkxXK3lBTEZpOHJnZjFmb21sd3BzUUpT?=
 =?utf-8?B?aFlVbVdXY3FtWEUva0YvNUtWa1lPSDFrWU9yeHJyaDBiWHFMYVQvVC9pUnF4?=
 =?utf-8?B?U1Bzc2pIdzE3Q0xzeGkydkpwUFducVlxd2FqZStzbUsxTGRJbnczUVNxcDU0?=
 =?utf-8?B?S3FzSm1sSXA0QU9RR001RUMxMlFBUGJZZ09vc0p5aExXQXo4N3dYMDhJT2p3?=
 =?utf-8?B?dXZVQ3JBOCs1MitNcG40VG1qTTlnZXRGdDhhT0JQNmpsdFZjS2tXc0hkaWYx?=
 =?utf-8?B?TVFWdURDREtSS0ZDNVNMTnAxVkhnOWxWeUZxVmZ2OW14R0Z6RkREdmtQaHJG?=
 =?utf-8?B?TG1OMXl0ZUV0a2czMzBhWHZ3cll4RlZ1QVI1SjlaemlTWTJZejFPcFIvR2VM?=
 =?utf-8?B?eGNJcFdIVUNseGk4ZHBNeXRDTnhMMG1NZ0pldUVTRGdydW94SCtYeDRpSWZP?=
 =?utf-8?B?SlFlbnp6MWtiaWNjdUhUUVVqWklNWDBIcjdEY0kxUVpDTzJPSk9weDhSNG9a?=
 =?utf-8?B?dzE0djFmOFdzVWsxMUNjTkdJT3Z3bGl3VkdzTVI3VTVWT2Y2ckFzZTlCQW0r?=
 =?utf-8?B?MXpFSFZrZGI3Y3k1bFpITEZoZTNYNjhTWmZkWUt6RFhOOCtJc01YLzJVbndF?=
 =?utf-8?B?SVpaV0NoRHh3cTZPNE1aL3VRUXI0TlBGYTJyV1UyT29NeWx4d243SFVMV2Uz?=
 =?utf-8?B?N2FNTXAxNjJCUldKQjBGbDRlWEQwVzFaRHRyZ3RPbXBkNlhydkRTUGxrb0hl?=
 =?utf-8?B?OHFQdUx5K0F3SUtyYlprWFdUeEtIR3oraWxLTzJjbGlzMzhuTi9uMy84OWJ4?=
 =?utf-8?B?Wk1ZWHNUSjVMQ2tJbFo0aWNNbU5VZnUwcnlzKzBOQkJqbXowRDYxSFd6M0J5?=
 =?utf-8?B?b01sR3N0ZVZlWVU2RklHaUM4N2pjUnhOeXdlODdNZVU0akQ4QXRyd0tMTCti?=
 =?utf-8?B?citNSUcrRVROY0VVdWRXcUtHVi9STU45RWUzbzEvN250RkhqaU4yTEpPbTEw?=
 =?utf-8?B?bkdkQmQ2VDFjTGZxbE91Y2FFOVBQcHdrTjdzaFdRZmFZS3BwUGE2aGFXaURL?=
 =?utf-8?B?R3JaUDE1akg3bVozNWMxcDR2TEtFMi9La2RRbXBlNEhEN0FBeTBtMzR5OExx?=
 =?utf-8?B?cWwzOGFLcUkvdVU1WnlxQU0vbGZET2duTXFNZTJtOXlCQmxTWHliSTdNWEJX?=
 =?utf-8?B?V0dCaFNxYjZTY0wwbjFTcUV2Wjc3bkJDM0hTVlgvTExYb21yY2wxdFpzZkpR?=
 =?utf-8?B?U3NEZFNkOE10WG1VaXdEcGM5V3ZEK2w3aU1xeTFPQ2tIMWl3RW8yOVp1S3dQ?=
 =?utf-8?B?YlY3Lzlxa3pjWXUycXQySW1TR3daK0h5VmV5YitFSXVNcXF4UkVDdGo2eVJh?=
 =?utf-8?B?OUx0bTBCcFo5UTNiaUxmaUVjM29pN2NBb2tRNmZWY3gxMjJVQzdzdk1DejJD?=
 =?utf-8?B?SXhmaWdKUXVJaXRsSGxkNElTMXpHRTQvbkgvUnhLSWZaNUxWUStSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e544c1b2-bc00-4d65-74d9-08de678b08c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 03:26:37.7594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwhMKuV0ULiUegO0rlGdMV/6C3Hkrwr/crqXAemVErNlTJE75ZvjUEDjc6d335ZEDgasBtuXXnvpW3kK4d8pKq5VemxbdM6SrSTJbpulcAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7161
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAwLzEwXSBTdXBwb3J0IEFT
UEVFRCBBU1QyNzAwIEEyDQo+IA0KPiBKYW1pbiwNCj4gDQo+IE9uIDIvNi8yNiAwNjozMywgSmFt
aW4gTGluIHdyb3RlOg0KPiA+IHYxDQo+ID4gICAgMS4gQWRkIEFTVDI3MDAgQTIgU29DIHN1cHBv
cnQNCj4gPiAgICAyLiBBZGQgQVNUMjcwMCBBMiBFVkIgbWFjaGluZQ0KPiA+ICAgIDMuIEFsaWFz
IGFzdDI3MDAtZXZiIHRvIGFzdDI3MDBhMi1ldmINCj4gPiAgICA0LiBTd2l0Y2ggQVNUMjcwMCBG
QyBtYWNoaW5lIHRvIHVzZSB0aGUgQTIgU29DDQo+ID4gICAgNS4gVXBkYXRlIGZ1bmN0aW9uYWwg
dGVzdHMgZm9yIGJvdGggQVNUMjcwMCBBMSBhbmQgQTINCj4gPiAgICA2LiBGaXggSTJDIEZpeCBP
dXQtb2YtQm91bmRzIGFjY2VzcyBpc3N1ZQ0KPiA+DQo+ID4gSmFtaW4gTGluICgxMCk6DQo+ID4g
ICAgaHcvaTJjL2FzcGVlZF9pMmM6IEZpeCBPdXQtb2YtQm91bmRzIGFjY2VzcyBieSB1c2luZyBk
eW5hbWljIHJlZ2lzdGVyDQo+ID4gICAgICBhcnJheQ0KPiA+ICAgIGh3L2kyYy9hc3BlZWRfaTJj
OiBJbmNyZWFzZSBJMkMgZGV2aWNlIHJlZ2lzdGVyIHNpemUgdG8gMHhBMA0KPiA+ICAgIGh3L21p
c2MvYXNwZWVkX3NjdTogUmVtb3ZlIHVudXNlZCBTb0Mgc2lsaWNvbiByZXZpc2lvbiBkZWZpbml0
aW9ucw0KPiA+ICAgIGh3L21pc2MvYXNwZWVkX3NjdTogQWRkIEFTVDI3MDAgQTIgc2lsaWNvbiBy
ZXZpc2lvbnMNCj4gPiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDA6IEFkZCBBU1QyNzAwIEEyIFNv
QyBzdXBwb3J0DQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwX2V2YjogQWRkIEFTVDI3MDAg
QTIgRVZCIG1hY2hpbmUNCj4gPiAgICB0ZXN0cy9xdGVzdC9hc3QyNzAwLWhhY2UtdGVzdDogVXNl
IGFzdDI3MDAtZXZiIGFsaWFzIGZvciBBU1QyNzAwIEhBQ0UNCj4gPiAgICAgIHRlc3RzDQo+ID4g
ICAgdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDA6IEFkZCBBU1Qy
NzAwIEEyIEVWQg0KPiA+ICAgICAgZnVuY3Rpb25hbCB0ZXN0cw0KPiA+ICAgIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC1mYzogU3dpdGNoIEFTVDI3MDAgRkMgbWFjaGluZSB0byBBMiBTb0MNCj4gPiAg
ICB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjOiBVc2UgQVNU
MjcwMCBBMiBTREsNCj4gPiAgICAgIGltYWdlIGZvciBGQyB0ZXN0cw0KPiA+DQo+ID4gICBpbmNs
dWRlL2h3L2kyYy9hc3BlZWRfaTJjLmggICAgICAgICAgICAgICAgICAgfCAgNCArLQ0KPiA+ICAg
aW5jbHVkZS9ody9taXNjL2FzcGVlZF9zY3UuaCAgICAgICAgICAgICAgICAgIHwgMTEgKy0tLQ0K
PiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMgICAgICAgICAgICAgICAgICAgIHwgMTUg
KysrLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgICAgICAgICAgICAg
ICAgfCAzNg0KPiArKysrKysrKysrKysrDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDBfZXZi
LmMgICAgICAgICAgICAgICAgICAgfCAyOSArKysrKysrKystDQo+ID4gICBody9pMmMvYXNwZWVk
X2kyYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA1NA0KPiArKysrKysrKysrKy0tLS0t
LS0tDQo+ID4gICBody9taXNjL2FzcGVlZF9zY3UuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAxMSArLS0tDQo+ID4gICB0ZXN0cy9xdGVzdC9hc3QyNzAwLWhhY2UtdGVzdC5jICAgICAgICAg
ICAgICAgfCAyMiArKysrLS0tLQ0KPiA+ICAgLi4uL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2Fz
cGVlZF9hc3QyNzAwLnB5IHwgNDQgKysrKysrKysrKysrKysrDQo+ID4gICAuLi4vYWFyY2g2NC90
ZXN0X2FzcGVlZF9hc3QyNzAwZmMucHkgICAgICAgICAgfCAxNiArKystLS0NCj4gPiAgIDEwIGZp
bGVzIGNoYW5nZWQsIDE2OSBpbnNlcnRpb25zKCspLCA3MyBkZWxldGlvbnMoLSkNCj4gPg0KPiAN
Cj4gDQo+IEl0IHdvdWxkIG5pY2UgaWYgeW91IGNvdWxkIHByb3ZpZGUgYSBzdW1tYXJ5IG9mIHRo
ZSBjaGFuZ2VzIGludHJvZHVjZWQgaW4gdGhlDQo+IEEyIHJldmlzaW9uIGNvbXBhcmVkIHRvIHRo
ZSBBMS4gVGhhdCBpbiB0aGUgY292ZXIgbGV0dGVyIGFuZCBpbiB0aGUgY29tbWl0IGxvZw0KPiBv
ZiB0aGUgcGF0Y2ggYWRkaW5nIHN1cHBvcnQuIFdlJ3JlIGN1cmlvdXMgIQ0KPiANClRoYW5rcyBm
b3IgdGhlIHJldmlldyBhbmQgdGhlIHN1Z2dlc3Rpb24uDQoNCkkgaGF2ZSBhZGRlZCBhIHN1bW1h
cnkgb2YgdGhlIGRpZmZlcmVuY2VzIGJldHdlZW4gQVNUMjcwMCBBMSBhbmQgQVNUMjcwMCBBMiB0
byB0aGUgY29tbWl0IGxvZyBvZiB0aGUgcGF0Y2ggdGhhdCBhZGRzIEEyIHN1cHBvcnQuDQpUaGUg
c2FtZSBpbmZvcm1hdGlvbiBoYXMgYWxzbyBiZWVuIGFkZGVkIHRvIHRoZSBjb3ZlciBsZXR0ZXIu
DQoNCkZvciBjbGFyaXR5LCB0aGUgZGlmZmVyZW5jZXMgYXJlOg0KVjI6DQogMS4gQVNUMjcwMCBB
MiBpcyBmdW5jdGlvbmFsbHkgaWRlbnRpY2FsIHRvIEFTVDI3MDAgQTEuIFRoZXJlIGFyZSBubyBj
aGFuZ2VzIHRvIHRoZSBJUlEgbGF5b3V0LCBtZW1vcnkgbWFwLCBvciBwZXJpcGhlcmFsIGNvbmZp
Z3VyYXRpb247IHRoZSBvbmx5IGRpZmZlcmVuY2UgaXMgdGhlIHNpbGljb24gcmV2aXNpb24uDQog
Mi4gVGhlIGFzdDI3MDBhMi1ldmIgbWFjaGluZSBpcyBsYXJnZWx5IGlkZW50aWNhbCB0byBhc3Qy
NzAwYTEtZXZiLiBUaGUgb25seSBkaWZmZXJlbmNlIGlzIHRoZSBkZWZhdWx0IERSQU0gc2l6ZSwg
d2hpY2ggaXMgaW5jcmVhc2VkIHRvIDIgR0IuDQogMy4gVGhlIEkyQyBvdXQtb2YtYm91bmRzIGZp
eCBoYXMgYmVlbiBzZXBhcmF0ZWQgaW50byBhIG5ldyBwYXRjaCBzZXJpZXMuDQoNClRoYW5rcywN
CkphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCg0K

