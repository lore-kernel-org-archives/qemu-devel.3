Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D044CC5DF6B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 01:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtbxX-0004AE-Fn; Fri, 20 Feb 2026 20:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=505209226=wilfred.mallawa@wdc.com>)
 id 1vtbxV-0004A0-PJ; Fri, 20 Feb 2026 20:39:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=505209226=wilfred.mallawa@wdc.com>)
 id 1vtbxT-0003qo-Rl; Fri, 20 Feb 2026 20:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1771637939; x=1803173939;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=era0fnSi6RNl9mdqx8557VvGktvpjvVaM11RtHAJr0s=;
 b=UZkyFw9PHpVNoMjRZSeaP3dgkXJh9QfBExcIRrAW82wiSIPyaxWFdsYM
 cOQ8pJTMmhd5tig+KpLX0DhXWnWnlqU5mvFit9Jcn6UboHiVoYMnS0fM3
 MsZYODkhpN6dknYfmRjxnJbIWksp+gZQ6QZOP+p9TBJBaQr2YErSvW7dx
 s8PZ2VsfMvl8NInLMTLU/sHJMIl0GIkQieF5C6H5ZbF2HF+vb8Bvq5Em+
 30w1EjKULEkSmFugzEwPP19wGi05OW7SucHRzbU9YBtVRqmqwheuMUAxu
 S+SLDGXC6dd5EL9YmSsteHIJz5g3WlpgF5oCXkp1jVjuNbkRH1lZ/ou3F A==;
X-CSE-ConnectionGUID: uws0+u9eRlufso2kYsZlhg==
X-CSE-MsgGUID: cWcFsAg2SByjB47n9m1CBQ==
X-IronPort-AV: E=Sophos;i="6.21,302,1763395200"; d="scan'208";a="142262995"
Received: from mail-southcentralusazon11013027.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.27])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Feb 2026 09:38:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+EJudhm0fZC4bxk3uHUOsDQVWhDdO8ybF9icRxMFz/tjFcOJ41Ww3KEnyKMxKLsFwzj1Ep4Y9wPblDNWhEpm7LE24b2nIFJrB4Y1PCAfaSEhn4NgTFe1ZjBTKK1O3gU0dES4QlCPX1cMzKXbawfC4NwRUTlpm6EdOMkxpMoyMom4iXwjIuPQPp3t2BvxYPt1Y2LmyjWlGvW7LsQYwBeugBFxX5BVwixIVTTav/XhN3PGE08TdD26CEJ7mkJX3muP4g42co2oY65LtneqdZnf+TQKi0GBfisDyfW6s0E9eZKzdLwDuhHAD269uDQVk7ihOwgYeYrVlA542AnlCT6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=era0fnSi6RNl9mdqx8557VvGktvpjvVaM11RtHAJr0s=;
 b=R+GqvjWBpZ4g/Zzn8smYTCcilqNuhfMTHET1wDmad6Q0XgSxaJhLCOUkiDk+75kgQC044LRq1iG8unD43W7oSw8CiRr2Ff7SBxHCK4fgtIGSDCdoa28OhXh+7MRiyuJxVfxZO0qhB2z/110FwkSdjun5GpBG0opeR0vDjfTog5Z1XfNuPaCTQVSz7xpQvV9mVxZkZO3UCGOsE6aHmdKFqcHd4XBRMfV4vtXsydC4tarXhH5agEdMSDnj/atUyz5EWRUbv7LNfR2tdPS4iqBaLff+Q4ddH8k532cGHVkfs8XBBPbEqWNlXd0C+2AkxVVuOlI4+w/hztaEI1o+esFzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=era0fnSi6RNl9mdqx8557VvGktvpjvVaM11RtHAJr0s=;
 b=GFmNogYo23xJtyHIpJGn9ujljBSjU1VMy+CmmEgr/KXM/wPRRKslRmPhRWdDYiO5raH+ugu3J31r4OdGHWM4UbHt1bcyVFUUu2bC/kxWeRiOqmJQZGpEgOQgXR9fIenBYtb1maWoLYIMwz7e11pvAzXv5sDaEI9+ymfeOaxwCM8=
Received: from SA1PR04MB8303.namprd04.prod.outlook.com (2603:10b6:806:1e4::17)
 by BY5PR04MB6721.namprd04.prod.outlook.com (2603:10b6:a03:22a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sat, 21 Feb
 2026 01:38:50 +0000
Received: from SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1]) by SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1%5]) with mapi id 15.20.9632.010; Sat, 21 Feb 2026
 01:38:49 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "noodles@earth.li" <noodles@earth.li>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: NVMe: Add SPDM over the storage transport support
Thread-Topic: NVMe: Add SPDM over the storage transport support
Thread-Index: AQHcooz/td5YLMYqsUygDHBER2NY7bWMYIqA
Date: Sat, 21 Feb 2026 01:38:49 +0000
Message-ID: <9fb564e200841e2ee4244f1a848120a928cdf024.camel@wdc.com>
References: <aZiXdwyWO6MMsnXA@earth.li>
In-Reply-To: <aZiXdwyWO6MMsnXA@earth.li>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB8303:EE_|BY5PR04MB6721:EE_
x-ms-office365-filtering-correlation-id: 4757332e-d876-415a-1fed-08de70e9f687
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|19092799006|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?TWJacDRDWk9TREtHN0hKNktNRE5Sc0NwMWJQZU50ajlUQVNEb3Z4ZDNtWFNL?=
 =?utf-8?B?QWluMEZKNjRtclBvNEQwUUQyQXF3VEQwYUxmam5CdWlVV3R4UlRYaWNvbHEx?=
 =?utf-8?B?cVFIc3pacmFPaDF0enBValNLeEpWaGJzeG13ZnptcjV1VldxR0l3bllvWUg2?=
 =?utf-8?B?OWcyYzZvL0VuVlNGNExpbTduQVpoY3hKVjFiRTVDV3p5THhBQVI4R1U2K0ds?=
 =?utf-8?B?UVFFOHQ4b2lqU0lIR0svU3FSR1BaQ0pLdnV0eS9wTDBpZ3luNzlHT0JDUjNV?=
 =?utf-8?B?OFVOS0dMdE9qd3VETzRzWnd4WmpuTFZTd0xVRFpKSllESUhTRGZ1aWNrcjBO?=
 =?utf-8?B?U3E3NlNRVmdYV2ZzVUNyZ095NlBRS2t6cE5QY3BuRHVxWlpOa0dvWWE2bjVs?=
 =?utf-8?B?KzAxdG1CQXcwUlRMUlE4NUlGUDR1NTFRTzdNdndRNHdHS3Bla3JhUFltREMw?=
 =?utf-8?B?dk95NUQzSVI4THpmdWVWbUJ1c2FQdThFVTJpNGxBK1dHVUtTbDdHUDBYR1lx?=
 =?utf-8?B?NTZRbEs5MUQ5UEEwZ0kzZERiWGhOaWEzTWNUZFFGVGdBdUpjSVpObm11RGgz?=
 =?utf-8?B?cjhvMzlhMDM5OUdBMEY3NmlOWlJlb002VGRGa1NFT3U4QnlMUTU3YlhQak5C?=
 =?utf-8?B?aFEwRFQwaVIzRHRlVUYvQ0l4QXE5SUt3WVRHQjExSXBITE10MkFNMzFaSVZt?=
 =?utf-8?B?L0dTeU9KaXJDRGM3NVBlR1Q0aTZ6Unc0R0IzMG9VSW1zcWw2bWQzakx1NG0w?=
 =?utf-8?B?RlZKZXh4dnN5cmpZeS9NUHpxWjZodEtiTjJBdnhLL1QvU21vNmUvdFpHZEFN?=
 =?utf-8?B?dGtKNWN4NjNVdzdQdUhJWk1VU3dUVXVQQzJtN3dhMG8rRy80S1F0cTNabE9j?=
 =?utf-8?B?c0NGSUNkZitRQzlkV09rN0NaMGU1N2VRblQ2QlFnY2NwWjBPZDhYWU1CQVFT?=
 =?utf-8?B?cXRFWng3bnZpQ0g4Tk9BUUtxMk9ZK1R4dkZNdm9Lc1lQdTIxSTZySDdqNU4r?=
 =?utf-8?B?MWZ6VXFOUnh3R2hoVWZmSm4xMnRrSVNaL3M3SnFySjdac1pkWHZaSk9iUWR0?=
 =?utf-8?B?Nm5WTGJWT0E2VEpJOWZtc2hRZi9CSmtrTmpJY0R3VWRNaFZ1a0Q0ak8xQUpj?=
 =?utf-8?B?QWdVN0ZQTXBqKzVzLzJBNy94UnlHTlhONExIUzVTRExvL2NZdmhZK1V4UjdI?=
 =?utf-8?B?eHhJaDRxTCsxTk9Id3N3WXpiMU5XNW41eStDQ0tiSXJPTkh5UzJGck9NSjFL?=
 =?utf-8?B?SVorZG5sRVRFY1hBUHY5Q1V4a2F5MnArRmJMSlJGNXBncHh3WVFzZW45MEhk?=
 =?utf-8?B?RlhiSHg2ai9zQ0R4dDFiWUl3QWhIM3ByMjdXNHdCWmNhZGV0bGdFTHFrZlJ1?=
 =?utf-8?B?Mks2TVJmeXpLcW50MTd6eUR0Yktta3c0b1JlMjNJVDlhcnEybWtGL0w3Y3RO?=
 =?utf-8?B?OWcrSmVoQkF2WkRoUXFvSVRNc2s3Nm1YQWV6bXVxRjBZRXh1UnBsRnp0V1Iw?=
 =?utf-8?B?L2VSeFZydmREaC9EU3BUL3N6elFVQzBKT2tXK0JiT2pMaWJVSVUyRERjbjhO?=
 =?utf-8?B?eXI5OGVqZFNXNnR6MlR5NlpVZkNNcGlhQU5wM2Y2UTI0QitwN3Y2QzNIOGl5?=
 =?utf-8?B?M2p5WExmRTArRHFiYTcvYlk1TkFGWHcrUkxVR3hWVWZHUXFuUURVNU1UM3Vw?=
 =?utf-8?B?KzNRdjVlOU11ZTVvdUhOTXB1OEpkUXpwNTZjdGh3OStaSVpMYjBXT0p4TTZL?=
 =?utf-8?B?NklXUk5iVDJ6ZkxmaWV1U1dtRVNPaHdFWXBXaGFjcVgvWFNMb1JhWk8xdXhz?=
 =?utf-8?B?QkFpM3c3WnFxNUxTN0tSSG44cjA0V3dyUjk0NGZDN2NhdDNac01rNVgyTWxO?=
 =?utf-8?B?TDc3U1VhMnhTL3NtR2p0Z0ZETEJ4K0o4ZlRSYTFMSlduMlpGNXlsTk1rNjBa?=
 =?utf-8?B?ZFU4bWFrbDFmTVlmaGVRd2tldjlVbUFIUlNXWXJLVDFYSldVeXExTmd1Q2lv?=
 =?utf-8?B?RWxveHV5YkhxMlJzQWF3MjlIYnErT1hOKy9aWEdpa2RaUmZ2YmdFd1JxMkFW?=
 =?utf-8?B?US9tbWlXQk5INnYrN3NHRWFHSmVjbzBRVTJndUJ3Y0Z1bzBySEVPNnQ4TVFm?=
 =?utf-8?B?Q2s5RFJkelNJeUlGa1RISUlkVy9Nb1pvQkFUZVZjQnlwTFhVQWFJZjJRRUtR?=
 =?utf-8?Q?DpBctN/42rzwseFSL+88znhx7D7HJcUZ1ahx7wjwfPT4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB8303.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(19092799006)(366016)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFE4VlM2MWV0cjBYTnhRUnhNUGtKaWRQV2ROeFZUc2s2dTN1dXVhWFU2YXBs?=
 =?utf-8?B?VEtXZmMwdUNTWUd4dm9qTnIyVWowS0JYZDY0bVpBN1RPU2pneThhZTRpWlYv?=
 =?utf-8?B?dTJrTkJiVlZsc2FKOTFtSjJDWktDZCtGK2s2TFJ4Q2xBUjd3N25Na2lLUnY1?=
 =?utf-8?B?Z1dmekcxVklGQXFSUUs1c0NZdEoyaEpDWDhlWXlSemlGd21za2dtZjZkUW1G?=
 =?utf-8?B?dXl0WEdMbHJvN3hPeWIxd1dBVUl4YjFJbkdxTGpkT0MzTUZOY2lNU0lUVkpV?=
 =?utf-8?B?Rjd6QUZ2eXZoTG1UbjZEY1IrRGlnV0xFU2VlY3M2eEtuR2Q5c3kyTklId0p2?=
 =?utf-8?B?cmhqNDRCNzF6Wk5xR2gxaGF3eVNmbUJ3amxvdkZKT0tKVGJSbk5XRXRoMWVF?=
 =?utf-8?B?dVZsc3gyYW1Jc1JIMCtFMVo3VnExRFRsbHc5RWVLeTVCL1VDa3o1RDVDRC96?=
 =?utf-8?B?QzNEWDBSMzZJbU1SRTBWVHJiSDUwNDBoRVB4cFRKUGVjZzVYWFR6RDJSWjNm?=
 =?utf-8?B?ZGFTNHJMMTExN1F1V3RPVFJnbmgvZWg3K2kvOVNGQjhxZHhxUFNobk54NmE4?=
 =?utf-8?B?VW1qMHJZYmQ3Qzg4OEhMTWE2QnNLYjA2MU9CNTlxM3BzMG10dFhrSkRnUTRm?=
 =?utf-8?B?bE5GaHVLQ0ZOYTdMZ1NsZGVvU0pOYWUxQ2I5THp5S0VQckNxeGpUaXcyeVQy?=
 =?utf-8?B?UWZNV2FWK1pRL0ZYbC9nSSswZDJaLzRBOTN2VXpvMEw0ZTRLemx2QjJyN0ww?=
 =?utf-8?B?TmtoeUlxNEZSQkx0OGhYR0gzem8vdm1TRERxQjFROEhTZXd1cVR5NGJsMWNl?=
 =?utf-8?B?RndNY0IxNHpRR1VDYmhzWVVjaE45S2pRRW9GZEkvdkprc2cvME5OM0d0a2tW?=
 =?utf-8?B?b3FxbGVWVjMxUWZJUmhjZXl6d0lSQ3ZsQ3hkT1BXbUVsU1hKeTBzZmpGLzhG?=
 =?utf-8?B?eTk4RndNbkJPQ2VCR0ZMMlU1UnJYMGV1ZkFvTUhVMkc0UlRLVU1kbTZrRXNX?=
 =?utf-8?B?dE5uejRZWndJV3B0TmowZDh5U2NvZjJSUDl4bEdEQXRBRWlGZW1CWGs5Wncy?=
 =?utf-8?B?MEpUdnBUamY4VHExRDNsZ1NUV2hmSXJFb0JGa2VVVnlnZCt2Zk9rQnhoS09E?=
 =?utf-8?B?OFUxNllnT1BLcHN3SkMvSCt0NkRhM0Y3M1Q5OHZkcmhzUGNXQlJLMk0rT2Ja?=
 =?utf-8?B?dk1KSmE2RXgzOCs1ZCtqOWVxN0p5RnBFYjRCUDcvVVo4bTEvOU5UNUhkWnZ5?=
 =?utf-8?B?Vm9wNFhBTG5yNXFCMGI1bk0zTjVidzJ1WXRWTVFBaDBETnRCc3ZCQmZrNTQy?=
 =?utf-8?B?aVJUVTc1cHNqOU5qMHRZeTVDUmpoVUlxMDl2Qm41RWV2cVI4Wi84OGU5S3FJ?=
 =?utf-8?B?eVU3WGhJTG9OQXA1S29FcmNOb0IyaTJUWFVVZDRzWVFZcWtCbzV4NERFREk0?=
 =?utf-8?B?T3lvUHQxWUZVQXVpTUtycHpjZlMwTWZIMHRDZGxicTdlODUvUkhpSk9lT3pE?=
 =?utf-8?B?QWh2SE9scHRMV2VRalQ4U0hScWxOa0pmYmJUbVNqYzNpemlYR1VIdzBrNTBU?=
 =?utf-8?B?dGFkNlhuZE5yVUhNVTk0SkpCMUp4WW1saGNiZmVQclpLcHpSVmhZYzBlNU9F?=
 =?utf-8?B?UEwxKzZIRlp3ZThXeUd0NmpRT0pCRFFQWUo4RnljMnE5bzRJNmR0RVovV0lF?=
 =?utf-8?B?TG5wWWxMS3ZxUElnRFQwR0ltY2I1NG1vOEM2VzkvbUk5bTVwanI3UVBTbEFK?=
 =?utf-8?B?ZnlUUE52SkRaUW5WNDYxNlc3RzlqWlREVy84ZmNzZnJJMHVhYlBjMEFLY0FX?=
 =?utf-8?B?WENFNE5reTFYTytFbzBzMEsyb1pMNXNLUmd0YnlIR2k0UzBCQjVhc1dBeE05?=
 =?utf-8?B?ZEprUHl3YkRLOE1QMU5qeFdsdHZsRHJnejFFOHh4MDUzbW1YUDFCN3B0dVJL?=
 =?utf-8?B?cHJLSHpnRzdDdGoydEZTdUQ3Y1NveUZ4VmF3bmducjJqblNuWndJSThVaVRr?=
 =?utf-8?B?a3RuUUVkcnhtWjc3cFJkVVZ6MkpGMWJZbDdXNkhnQjZybHhOaGh6em5YbkpX?=
 =?utf-8?B?dWtPOVhmSFZaQ1JCaDFQZHViTGFCVGJUNXlYNWJUa0ZHN2FKM0RMVGxCQnRX?=
 =?utf-8?B?Ynk2bjJqRzZWMnB2Z0REaHF0Vk0rVEpIMm9WZ3NFSUwwMmR2YWhKd3ArTDcx?=
 =?utf-8?B?L0dibFJ1dUEwSElIUVY3V3Q5aFhhem9IbHlhV1Y2UnZRakFHTzZidmRuVVdu?=
 =?utf-8?B?SHJlL01RMlE0NDhFTW5zd1h3bi9xNlIvUjVIZFE0WDBjKzdPWWE5VVJsNVUw?=
 =?utf-8?B?eTJpbGt1RlFha1pTWkxiOWYyZjN3ZkNLd3F6OXo0Z0tDZ3dUd2UrMU9vbDhl?=
 =?utf-8?Q?Rqed3MK472zoA76ZJBoCb5aWYI22vhrdSpNoZIh8FVn2C?=
x-ms-exchange-antispam-messagedata-1: ZQfuOEup54IWKrygKYhHC9MEPWWVMQGSnwA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8623816CE52D34F9CC85B2BE7361A21@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OAaYZgoa4Jmade/vUAfYnBXvZ+7uxC2W3BEePk6RmPRrLT+kJJ0DtH0iVOdijs9zpPbrLaeTqbu6Uh/eE5Pm+OxNts45cbHbNoEnha0FEw8DODVsGV4Kf8HDY+XZjWVIOytw4C/TraPgw6KS5fDcAx6P8NNAkOTR2J/Ocwex1B0e+W9dFJczhlz7sPgFfGSFBKTUwpOrYOW8rlq67ScPoxxoBrCTN4c6cNYEFmHQkdglBNNpAa7bWZGVw8LDyGBv7bEWXQsX0z//hM/Aa/FqAwniRfLosivlu9CX5vInvtAKfNcQ+FIS4IBiEsQWwCvFdQysceXOpiS4wcAUCSSqABiJ8bztDqxCf5BT+OPCyz4q5LtySx5D4bOe+kNVMOMZQemzjg/jDWY4KCP2wZE413SE5XGTKHty8hLCNir2n1xNdB1ONl251w43i//7qnEw+C/P0Wy2xytusadK5w5oSDvmlSm6l7YlOtNCfF8ckFTFB73yx09NBIqSRk7PhoQzVarPr5HkasmgkmhTWlAxpvJWAE802OOTef0JZwzHZMnYZ4iX6TaAs2OiY0SXFtpF4cB7ZmY/nkd1eQSMuFSSVhv0ax3XNg7/bK0I27K8eA3yEt5h2cJxLNf9qN/ua08I
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB8303.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4757332e-d876-415a-1fed-08de70e9f687
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2026 01:38:49.8550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyKx3SR/H++QVUUiYw+zj8IvpysTxfWerr3veIIQhLy907dJ+WdKpuszXjBfNiuvN7Bke1wOVw5pB+9x7uxzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6721
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=505209226=wilfred.mallawa@wdc.com; helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTAyLTIwIGF0IDE3OjE4ICswMDAwLCBKb25hdGhhbiBNY0Rvd2VsbCB3cm90
ZToNCj4gT24gRnJpLCAzIE9jdCAyMDI1IDIxOjM5OjQxICsxMDAwLCB5b3Ugd3JvdGU6DQo+IA0K
PiA+IFRoaXMgc2VyaWVzIGV4dGVuZHMgdGhlIGV4aXN0aW5nIFNQRE0gc3VwcG9ydCBpbiBRRU1V
IHRvIHN1cHBvcnQNCj4gPiB0aGUgDQo+ID4gRFNQMDI4NiBTUERNIFN0b3JhZ2UgVHJhbnNwb3J0
IFsxXSBmb3IgTlZNZS4gU1BETSBTdG9yYWdlIFRyYW5zcG9ydA0KPiA+IHVzZXMgdGhlIE5WTWUg
QWRtaW4gU2VjdXJpdHkgU2VuZC9SZWNlaXZlIGNvbW1hbmRzLCBhcyBzdWNoLA0KPiA+IHN1cHBv
cnQgDQo+ID4gZm9yIHRoZXNlIGNvbW1hbmRzIGhhdmUgYWxzbyBiZWVuIGFkZGVkLg0KPiANCj4g
PiBXaXRoIHRoZSBhZGRpdGlvbiBvZiBhIG5ldyBgc3BkbS10cmFuc2AgQ0xJIGFyZ3VtZW50IGZv
ciBOVk1lIA0KPiA+IGNvbnRyb2xsZXJzLCB1c2VycyBjYW4gc3BlY2lmeSBgc3BkbV90cmFucz1u
dm1lYCBvcg0KPiA+IGBzcGRtX3RyYW5zPWRvZWAuwqAgDQo+ID4gVGhpcyBhbGxvd3MgZm9yIHRo
ZSBzZWxlY3Rpb24gb2YgdGhlIFNQRE0gdHJhbnNwb3J0LiBUaGUgYGRvZWANCj4gPiBvcHRpb24g
DQo+ID4gaXMgdGhlIGN1cnJlbnQgZGVmYXVsdCwgYG52bWVgIHdvdWxkIHNlbGVjdCBTUERNIFN0
b3JhZ2UgVHJhbnNwb3J0DQo+ID4gZm9yIA0KPiA+IHRoZSBjb250cm9sbGVyLCB3aGVyZSBTUERN
IGNvbW11bmljYXRpb24gaGFwcGVucyBvdmVyIHRoZSBOVk1lDQo+ID4gQWRtaW4gDQo+ID4gU2Vj
dXJpdHkgU2VuZC9SZWNlaXZlIGNvbW1hbmRzLg0KPiANCj4gPiBTdXBwb3J0IGZvciBEU1AwMjg2
IGFscmVhZHkgZXhpc3RzIGluIGBsaWJzcGRtYCBbMl0gYW5kIHN1cHBvcnQgZm9yDQo+ID4gdGhl
IFFFTVUgU1BETSBzZXJ2ZXIgaXMgYmVpbmcgdXBzdHJlYW1lZCBmb3IgYHNwZG0tdXRpbHNgIFsz
XS4gVGhpcw0KPiA+IHNlcmllcyB3YXMgdGVzdGVkIGJ5IHVzaW5nIGBzcGRtLXV0aWxzYCBhcyB0
aGUgcWVtdSBTUERNIHNlcnZlcg0KPiA+IHdpdGggDQo+ID4gU1BETSBTdG9yYWdlIFRyYW5zcG9y
dCBzdXBwb3J0IGJ1aWx0IHdpdGggYGxpYnNwZG1gIHYzLjguMCwgYW5kIA0KPiA+IGBzcGRtLXV0
aWxzYCBhbHNvIGFzIHRoZSBTUERNIHJlcXVlc3Rlci4NCj4gDQo+IERvIHlvdSBoYXZlIGEgcG9p
bnRlciB0byB0aGUgY29ycmVjdCBzcGRtLXV0aWxzIHZlcnNpb24vYnJhbmNoIHRvIHVzZQ0KPiBm
b3IgdGVzdGluZyB0aGlzPyBJIHRyaWVkIHdpbGZyZWQvc3BkbS1zdG9yYWdlLXY0LCB3aGljaCBh
cHBlYXJzIHRvDQo+IGJlIA0KPiB0aGUgbGF0ZXN0LCBidXQgaXQgZmFpbHMgdG8gYnVpbGQsIGFu
ZCB0aGUgZm9vdG5vdGUgaW4geW91ciBtYWlsIGlzIA0KPiBkYW5nbGluZy4NCg0KSGV5IEpvbmF0
aGFuLCANCg0KWW91IHNob3VsZCBiZSBhYmxlIHRvIHVzZSBbMV0gaW4gdGhlIGhvc3QgdG8gc2V0
dXAgdGhlIHJlc3BvbnNlIHNlcnZlcg0KZm9yIFFFTVUuIFNvIGFmdGVyIGNhcmdvIGJ1aWxkOg0K
DQpgYGANCiQgLi90YXJnZXQvZGVidWcvc3BkbV91dGlscyAtLXFlbXUtc2VydmVyIC0tc3BkbS10
cmFuc3BvcnQtDQpwcm90b2NvbD1zdG9yYWdlIHJlc3BvbnNlDQpgYGANCg0KVGhlbiBydW4gUUVN
VSB3aXRoIFNQRE0gZW5hYmxlZCBmb3IgYW4gZW11bGF0ZWQgY29udHJvbGxlciwgd2hlcmUgdGhl
DQp0cmFuc3BvcnQgaXMgTlZNZS4NCg0KZS5nLg0KLWRldmljZSAgICANCm52bWUsZHJpdmU9bXlu
dm1lLHNlcmlhbD1kZWFkYmVlZixzcGRtX3BvcnQ9MjMyMyxzcGRtX3RyYW5zPW52bWUuLi4NCg0K
WzJdIGlzIHRoZSBsYXRlc3Qgc2VyaWVzIGFkZGluZyBOVk1lIHN1cHBvcnQgdG8gc3BkbS11dGls
cyB3aGljaCBzaG91bGQNCmJlIG1lcmdlZCBzb29uLCB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gdXNl
IHRoaXMgaW4gdGhlIGd1ZXN0IHRvIGlzc3VlDQpyZXF1ZXN0cyB0byB0aGUgTlZNZSBjb250cm9s
bGVyIG92ZXIgdGhlIHN0b3JhZ2UgdHJhbnNwb3J0IHByb3RvY29sLg0KDQpTb3JyeSBmb3IgbWlz
c2luZyBsaW5rcyBhbmQgZGlmZmVyZW50IGJyYW5jaGVzLi4uIGFsbCBvZiB0aGlzIHNob3VsZCBi
ZQ0KdXBzdHJlYW0gc29vbiENCldpbGZyZWQNCg0KWzFdDQpodHRwczovL2dpdGh1Yi5jb20vdHdp
bGZyZWRvL3NwZG0tdXRpbHMvdHJlZS93aWxmcmVkL2FkZC1zcGRtLXN0b3JhZ2UtdXBzdHJlYW0t
djYNCg0KWzJdDQpodHRwczovL2dpdGh1Yi5jb20vd2VzdGVybmRpZ2l0YWxjb3Jwb3JhdGlvbi9z
cGRtLXV0aWxzL3B1bGwvMTM5DQoNCg==

