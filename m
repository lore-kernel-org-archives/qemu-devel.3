Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7F9C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 19:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5VvP-0003KV-N1; Fri, 10 May 2024 15:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s5VvL-0003K4-80; Fri, 10 May 2024 15:28:55 -0400
Received: from mail-vi1eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2613::700]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s5VvI-0007sd-G8; Fri, 10 May 2024 15:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPAQG1wefTFPvuVDt9RVXJpC0e1L1xpyvzEOyzTOZbjETO/AIWO9mIWm3C8HubX/DWtX5WLzlGvIwrUwTKkdTmx0RXKTR4HXfNiyS3i0nhDj86Vs9RToS4w4oCrIhR2N6Sk4CLHna6DMnQDH3IAU4uyrYTzawb51Ru5erBwBe0gZqAaDA2y6Mwr/0n2x/CSUqdL3koz5Js8ggkxS79FpkZWIcQmUbfxj4KirFce3PDfQFEw8f8ekfTlBdXhHCpOGik4y1Q6IYCQCWeiU4OcC5QcndM3Zzkj2KCs1ZdPZpVzskr5TZq8u1M1OAMrnw+7KUogMCNbjILRpYhXZLWz2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzTKX5b0Sh5MWyXziEsAGnZRZkAsb23vmWPGZC40W0s=;
 b=j3vLaqTv88OkIK0sQ89UkKh/apKt/Hu3ks/tCN2IywkAsXaH9RkJoENBnWK8XIkb91iMrN+1hIV/5gBeY4lHK8NGRoRIbHVmsMwP/UQMZtgyfa+bKyY/BwCb+Iy+6mHDlZSWL0G1iqRifpHYTkMK9e2P4b9lYX8D3kFJ0lS5lw0YkoRSVATcGYmrHMnXldareXN6UrTiMdyZ7PunqdyRnuVvymdzH4swso8Ff6qAIhBbVXnPnboTapbk+mUBNYMJ2bkI8ZeyroI6HvVcRkhOaEMYvrcu+tRwBHOWdKibXcARSD8xWQvH/QN2gmYTdPvBId+PWVfHF3o9psGTIuLr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzTKX5b0Sh5MWyXziEsAGnZRZkAsb23vmWPGZC40W0s=;
 b=r5hGVWiqQ+5K46oLz6uKLeGxtM1cQkziPgbfuV7Yq8+h2HFTZe8hKp6bZ+ZTHKWhO4f7ES0FHXcyyENz8bPfjcT8zDaHE+O4K5buLovdF7X6PElvuU3SI/yeQcK8gWRO/9m1L+kOX3IE0AVe6Z4eQ8KnTNKrzvLty2cz4k82Q/rWbUbmcST0WqQOiijbfm9WBCthvT+SPG/K4ZAXlol3syL2/CZWWqG3SE3dm9loH2a5dLjRo+mvVKe2euL75CbkCPBgeYrZXe0OHt8lB6ZSA6kWHD5h7TW9U1Bbl67OgfliJN66uIVPGRoKMM9rtIkjg7pnMXqttXaEbdzuOTOA0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VE1PR08MB5677.eurprd08.prod.outlook.com
 (2603:10a6:800:1ab::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.52; Fri, 10 May
 2024 19:28:44 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 19:28:44 +0000
Message-ID: <7a998b0a-3d48-430b-a945-3d350f605ab3@virtuozzo.com>
Date: Fri, 10 May 2024 22:29:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] Base node is in RW after making external snapshot
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>,
 Pavel Ganyushin <pganyushin@virtuozzo.com>
References: <fa7a3d64-aa65-444b-8e65-87a64e47684a@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <fa7a3d64-aa65-444b-8e65-87a64e47684a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VE1PR08MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d4e9b0-e936-4ddf-8b58-08dc7127681c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjRYZVhsN2NXbWZRQjNMWERvcVZZVmhVM0U2d05hQ29nVC9laEtaVmpJSDRv?=
 =?utf-8?B?UDVTa2xsMUFFeGFZN3E4eWVkUzlBSmJtWnJwbmJaYzdBY2xEK1U4U1pwT0Vk?=
 =?utf-8?B?ME53WHJzSjl6Z3lyb0V5N0lFUmhHSnlSeTJwRzE3OWRtY1FhVWovWG5ESTIv?=
 =?utf-8?B?Z2M3M0hNOEhxYjVYcmxLWEUwSzltci85UGFYQytIUCs4Mmd4eWNZdVU0OTQx?=
 =?utf-8?B?azVBNllhcEtZQVcvVDZmaU5hUGxiZEgwZFkzVG1vMHVPNEdMelZSQldxUFBs?=
 =?utf-8?B?T2hPazkrcXJWUG1iSDNtb2Y3L2toUkkvMjZmcmhGRXlsQnBiNFlETmhzOGt6?=
 =?utf-8?B?Z0lDcFdxeEdDZXJBR0cvaXc2Yy9lOTNCdlIxYm1nNkJkck5BMEpPMFYwNzBD?=
 =?utf-8?B?NGdubWRvRm1DejRSYk9veGZqREp5NCs5Z3pCa2VEazlKdnl6SWlOc0JYMFd0?=
 =?utf-8?B?a2lvQ3ZlZU9JRG0yTEpOWEluV3Rsd2NRQ1FNNVA3YlZBM1FLanF6UTN1T2c4?=
 =?utf-8?B?Ymw4WEJnZkFnWmc4YWE0OTdFdWxZOTY3ckQ0Z3lKSG82Ym1SWW5IaUoyTzk1?=
 =?utf-8?B?YmZtMmpsRVlDMlNtUGtuM2FKY296b3ppakFDNmsvb2c3WUY4NEI1dlZkNkkr?=
 =?utf-8?B?czdPZ2ZXRS9PYWt0NFBxekJ6OEg0L2dTclluVGNHRHBJc29sUG5NVXF4QWpX?=
 =?utf-8?B?R3pkaGhORFdONXZ3UVRoQ3JEWkNSM1NGM2VnbVlmOEJlbUxReXYzaURlRi9E?=
 =?utf-8?B?RW1jc3FKNU5ueXhKbnBTMWgxTVFOOExlemJqV1ZEbUlHbFRZcXVHVjhsVk56?=
 =?utf-8?B?eVdSQW5KVTVMMHJ2YndRdEUrUndGaTFTUmRZK1hEdHZha2REME1TNVFBNjNL?=
 =?utf-8?B?VXBCZldLaS9CdzRMODZQaU9UNmI2TytOaEhTTXhEcWZqTjE4SUF6RDAwQmU0?=
 =?utf-8?B?bUVMcW9CS3Mxc1hPWUFZVW02ODQ5eXFPSGpocFZYUWhyNDd2ZGdBRk95VWRi?=
 =?utf-8?B?cS8zZ2EzSys3ZzQzbXo1OTBzNnlSUEtqMTM4MndYODVjNnBaeG5Ya28yUmpL?=
 =?utf-8?B?OWxxRzlmWjVJOXhvdjJwRWlaTTlxMGsvWnJPREtRS0hmSTAybFNwbUsyblB4?=
 =?utf-8?B?SDA1ZWpwN3AwYnl0b0YxeWhFYjVwVW52VDBTRVBmTE8rdjg5cGJhTElDZ3hR?=
 =?utf-8?B?Yk41aDdVVW5yNjVtRnNpSksvazF1a2tnRWRlRGthckdvVDZJcUlxeWdlUGJq?=
 =?utf-8?B?OGNjQmwvVWRPWk5tZGpyOTY1MDZXVjh5SmczTEdRZWFNMlBHLzFsVFcyYVBx?=
 =?utf-8?B?bE5hMmpaTmhkOEVhNlUrZERGOFBNUGYvdVdRTmd2NGNkaSsxR01YdHVFeEp5?=
 =?utf-8?B?VFh1dzhEa0NZbG83QXdsbUU4dW9wNUpIN09VNFh6Ym9mQ1FlcTE2aU9mRHN5?=
 =?utf-8?B?OWdSaEZtaVZwazI3ei9DRTBKTURJenhIM1BoNVNKR0g1M0hYRWFzN1JHODFZ?=
 =?utf-8?B?Z1RsdS83U1F3OEc2Q0xKck5vZ0IxQ3ZvaEJuVHBLck9QZGpVWDd2bmdmYVhM?=
 =?utf-8?B?L0Nycm00RzgrK0hSd2dheGsvcE5jakZKN0U3Z05DcVFHR3J0cGFWVStXaFRB?=
 =?utf-8?B?QWMrNXNuSGg2YURqRUpFbExYUFgvcWVpZUhtczUwMEt5a3N1TjdQRzBldGpr?=
 =?utf-8?B?ZVY4SnFuU0FHMElJYmVTV2lXVHF2eVFab1l5bEF5MWtuUzB6dlRld1hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9ZTUlIbWt0S2dyNFY1bVE5WUd1cWNNUTdVWmpRcnhqMWtndlp6b3R6eWNh?=
 =?utf-8?B?K0g4dThFMXB6a3JHUnlFRnFmZTAvWkZhcjZ0c2pqRnUvRGExVWcrNGxlMHJh?=
 =?utf-8?B?ZEtsT2xSMWptMVd2M1hQSWR6TThHcEl6SmorR2RmUXVOYWVpamx6V3U3Z1dE?=
 =?utf-8?B?YlBWeFYwK2lpUzN5TnFSbXlyalhHallvQlN3NEtET1NQcnM4M1RRb0RjWlo2?=
 =?utf-8?B?RDVaWitrQ2FZaVZQb1hENTg2RFRJWXBtSUJKV1ZsWUQvVnJoZm10WmxIQlFP?=
 =?utf-8?B?TldrVlc2YXlmcEg5ZXBTN3hkQVhsT2MySEd3bDZmVW1NSU8xVEtPY096alha?=
 =?utf-8?B?REZodm1lNnFKZlVDOWp6SHNtVWNFeUJWRzkwUEtSSDBXYTN2WWFHelhpV0hE?=
 =?utf-8?B?bnNsTG81RC9GcnVwMkplV0pNK015UzllcG00c2JYUnVyamN0Z2YrSDlvWDFu?=
 =?utf-8?B?ODk2NTZtM2p2NXJlTWZYNTFCQmxPZTNsaTBpZmM1eXQ1RXI3ck5Yc2F3Ri9K?=
 =?utf-8?B?ZTZ0V1NPYXR4N0dSc3RlSFFlM0ZXYUtwYkhtMThxcEd5WC82WDJtZXN2SFNs?=
 =?utf-8?B?VGltUzNYU1A3OVNnR0I0amZmeW05Y0c3ZTM2Z0x3a2Q4MENZek1HOG1DZXZV?=
 =?utf-8?B?aTVqV0xiZ2w4eDFwZE9uQWNaTlE5aVNCTDh5QkZpUTBYZmxCaGMwMUJsdTBI?=
 =?utf-8?B?N0VhVFlCWFNiTUh4YlVrTFRTc1k0MDQvbWZrS2p4NDcwanZJQ2E2aFlEaGFm?=
 =?utf-8?B?U3RJYzc3UTZ3RXBJU2xFVC9LQTJvcHdMbTNKMjRhRnFVdU9WcjdxWWNaSHBO?=
 =?utf-8?B?VU5NQTB4TnRQVkNhS3BHampLSXV3VzAydXE0cExMYVhEU3BCeEU2UGg1Qkdw?=
 =?utf-8?B?NXF2K09kRCttcG1pQmhleDF5bTJiRysvRk0yS2tKSHVOaXp6OGpRUFFMZ055?=
 =?utf-8?B?Y2NSSnp5OVZNUXBIU1VSTXBObHNPMUJVWHk1a2FNZDk4ZHlPL2xaNTNGd2V4?=
 =?utf-8?B?OEdKUG9qOEtrM25ETWkzdENNQ2hVQVArYzFPd1FsYkhkRXVjSkNycnB5eWlE?=
 =?utf-8?B?S0xmMWtlcXBoWlcwL1VzNVg2MlNadDZQVlJYNUlxZEJjLzVmY1VzMEpDZnhm?=
 =?utf-8?B?RGN3K2l0WDBNckIySzFIWE95ZkQyUHpMMkI1cmhCNnlWUHNtOWtRV052ZzRC?=
 =?utf-8?B?T1kyMTNZdS9Oc3NkOGVwQlJONytFL1hobzZVbVU2OXNKeDdwa3dCVm91UzBW?=
 =?utf-8?B?dFhBckhDNjNKQ2ZZRkdRMTZVWHk2LzlheFc2dXNTQmlwWk9SdzJub3J2VVdP?=
 =?utf-8?B?akdQTVVUNWs5eGtPWFVPaFpDdUJrQ0M3YVc0RHpyK3RCNFFlU3VmZVlSMVpz?=
 =?utf-8?B?ZHFIMzlYbWVwNm5peU1FOTdYUHpaTVhqV0JLbk1pVFg1YVEyMWdEY2pFZ1Fp?=
 =?utf-8?B?K3Z4ajdDeHRnWlJJd25hMC9xV3dCb2VrRGJUQTl0Vjc2dTZSUk0vMThlNGR1?=
 =?utf-8?B?VThqbHcxdllsUndibFEyTGZzSnF2ME9mMXJxOVY0TFFxK2Jma3JTZjRacG00?=
 =?utf-8?B?bnVLOEtwMzBsb1cwdHJpNUxGbzgvaFVvd0JIR2hhL1h0WDB1dHRaTDZ5NzNi?=
 =?utf-8?B?YVhSWFlBNzZ6em04b2xEcXVYOUJOcktuWE5KV0pIanREN1lQYVM3VlVIcElk?=
 =?utf-8?B?SEhGSTNQeityWnh4SWNBYWNTUmNIbzI2ZkQxcFlXeWhoNWI0WG9vY1lLOFNU?=
 =?utf-8?B?a0JBV0RPMlhKaHNNUWlYNGtnVHdSZ3EwTk9aZVN5SVYzVGJaSmFNYWt0U2VX?=
 =?utf-8?B?eCtvSjVhWHVUNXZvaGZMUDBpenpKV0Q2U1Ftai9pRStRZ3RKanhwM3JpQTdq?=
 =?utf-8?B?OXpzNUhibTZORnQ5OGZjdnZleXJreVY5QlpzVjE1Q1EvWW1FUFV2NWE5bDRQ?=
 =?utf-8?B?N0lWQlowSm5HcWVFWnEyOWxDME1mZFBCMkVxYlpDdHQxMms1RmZyZlBpR093?=
 =?utf-8?B?UmJDRFpWMkxSN0ZNVEJqSENkeHVrZDRzdTlxcUVWNngxbU1TZDk2TVd3TExY?=
 =?utf-8?B?RHFjanZTTGdFMGpaWUx1emNtd0MzVEg5ZVpqUEJlSHNqUlJQc0VybzQ2NkxM?=
 =?utf-8?B?NEpCWko4ZG9UemVKOHdoMkVuU1lCTytDSndYbVdOd28ya0RlbER1Q1hPVmxO?=
 =?utf-8?Q?et4DLuGYWAXMWvAlNpeCbWI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d4e9b0-e936-4ddf-8b58-08dc7127681c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 19:28:44.5833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lEep2Tmh1bC1wMw923WZ1C8ELXCerdEFpRWiC8z5JX7q5Psy7rTrOsorJJH1pVju2FWR7U54LIA8OSV1FgKDtRBU2yKT/PvlXmujPlaK2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5677
Received-SPF: pass client-ip=2a01:111:f403:2613::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

On 4/24/24 21:00, Andrey Drobyshev wrote:
> Hi everyone,
> 
> When making an external snapshot, we end up in a situation when 2 block
> graph nodes related to the same image file (format and storage nodes)
> have different RO flags set on them.
> 
> E.g.
> 
> # ls -la /proc/PID/fd
> lrwx------ 1 root qemu 64 Apr 24 20:14 12 -> /path/to/harddisk.hdd
> 
> # virsh qemu-monitor-command VM '{"execute": "query-named-block-nodes"}'
> --pretty | egrep '"node-name"|"ro"'
>       "ro": false,
>       "node-name": "libvirt-1-format",
>       "ro": false,
>       "node-name": "libvirt-1-storage",
> 
> # virsh snapshot-create-as VM --name snap --disk-only
> Domain snapshot snap created
> 
> # ls -la /proc/PID/fd
> lr-x------ 1 root qemu 64 Apr 24 20:14 134 -> /path/to/harddisk.hdd
> lrwx------ 1 root qemu 64 Apr 24 20:14 135 -> /path/to/harddisk.snap
> 
> # virsh qemu-monitor-command VM '{"execute": "query-named-block-nodes"}'
> --pretty | egrep '"node-name"|"ro"'
>       "ro": false,
>       "node-name": "libvirt-2-format",
>       "ro": false,
>       "node-name": "libvirt-2-storage",
>       "ro": true,
>       "node-name": "libvirt-1-format",
>       "ro": false,                        <--------------
>       "node-name": "libvirt-1-storage",
> 
> File descriptor has been reopened in RO, but "libvirt-1-storage" node
> still has RW permissions set.
> 
> I'm wondering it this a bug or this is intended?  Looks like a bug to
> me, although I see that some iotests (e.g. 273) expect 2 nodes related
> to the same image file to have different RO flags.
> 
> bdrv_reopen_set_read_only()
>   bdrv_reopen()
>     bdrv_reopen_queue()
>       bdrv_reopen_queue_child()
>     bdrv_reopen_multiple()
>       bdrv_list_refresh_perms()
>         bdrv_topological_dfs()
>         bdrv_do_refresh_perms()
>       bdrv_reopen_commit()
> 
> In the stack above bdrv_reopen_set_read_only() is only being called for
> the parent (libvirt-1-format) node.  There're 2 lists: BDSs from
> refresh_list are used by bdrv_drv_set_perm and this leads to actual
> reopen with RO of the file descriptor.  And then there's reopen queue
> bs_queue -- BDSs from this queue get their parameters updated.  While
> refresh_list ends up having the whole subtree (including children, this
> is done in bdrv_topological_dfs()) bs_queue only has the parent.  And
> that is because storage (child) node's (bs->inherits_from == NULL), so
> bdrv_reopen_queue_child() never adds it to the queue.  Could it be the
> source of this bug?
> 
> Anyway, would greatly appreciate a clarification.
> 
> Andrey

Friendly ping.  Could somebody confirm that it is a bug indeed?


