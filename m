Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9A9C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 09:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFsVb-0004Qk-Dh; Sat, 08 Jun 2024 05:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sFsVZ-0004PN-EC; Sat, 08 Jun 2024 05:37:09 -0400
Received: from mail-db5eur01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2600::700]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sFsVX-0001U9-9l; Sat, 08 Jun 2024 05:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1Uj6oqZLRjCMNfO+B0XghXKPCGNGPIa4a0AL0FmgAe7mP36Gul2Cqx6UU0xWJldJwBGr09BuvHlqRWMCiswP5rZy0QxKq2p82P7p368/yE4Qoy7iW0MfkssOhUOO7A1ktUp6i94+41dMhtBtkFTqSiwLOTSy69HXm9CwoeicB7yNGmDblezJLY2EQ6tF+J7u0FE7qg3hRl0X0E/BnZV/uNXk/yVl/NMgdWj96qYhPNVzT6Mw3YbrEZGzWm3Al+OfOKLZFsNNVJAUPDAoMdFk/sOvoxlrGe/Ae29SM5iMlm1MXeEdl9PGEbt7n5FRk8ub1f4U2EqjpzV4UZOjtMG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZBL5kJEh5e/vIp9EyrPuuDlffxPgoM26Y5nQ4wOvNA=;
 b=jYJZJNkpylxbwSThk+PNJQ8q8Lb8U5Zsupswk+wDjwD/4cz+4ClI0fKjsZQhz7T+mDcxeqxrvjnghCAbvmgg98eflm6cFMH9BLtdgISqho1IQ1w7OdhR8ljGVq+H2c+EtrTxZkUN+1AWd+dp99KAnyQg0axwkimYEhjx6l+oKwQjS5AKGUhO9zUnr1ppYHGtzq/KctTC6ajIAhZUTnIjjrPR+M31PuaG8LkVA4SZKlMGdTToPpa/gHufm1Ac8SbBxiPMJXtF+6fggz56IHQaxYuYlz08DdhbU4CQAYuV67V7dGZNhPVDNmm1/qWZVibGZjUKZIW8V1MrHiHZA0Lbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZBL5kJEh5e/vIp9EyrPuuDlffxPgoM26Y5nQ4wOvNA=;
 b=ZvCgiZvWq5h1R3mWSuuUJCD5Dk5y9qigOYt0ec3CI/3T+U6Zpk87jDmERgFCa8POkhKzgarhqJxBichkcZoyBfzzFF9M+mHwEMe7UBnYPJrU4P8hgAJADCna16gOCN6T31GN1ek9vmOv0+ilKSVuFl+nzyivZ7DmjiJ17o8FxFr+ZV1FMqWSIakzmEOdIUbFYIlS1WE48fMszpVZCPZZ4UMT7kaCX2aGdJ/7/KEA76crAr78nfCqcHhiLSG8uozuaNjDzMbNfI0VfizdQjOgVW3cbALK4BSL2G+khySIEQ8lBMGITbKWhmTCG0uI2afQhPnNdhGEeQ3thv77ldSoEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB9PR08MB6490.eurprd08.prod.outlook.com
 (2603:10a6:10:25a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 09:37:01 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%7]) with mapi id 15.20.7633.033; Sat, 8 Jun 2024
 09:37:01 +0000
Content-Type: multipart/mixed; boundary="------------EGUCwYg2kTUH0SSKOKolHtAf"
Message-ID: <810e4bf9-ba9b-4bff-976e-047e8be467ba@virtuozzo.com>
Date: Sat, 8 Jun 2024 11:36:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: Prevent NULL pointer dereference in
 nbd_blockdev_client_closed()
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 eblake@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
X-ClientProxiedBy: VI1PR0902CA0049.eurprd09.prod.outlook.com
 (2603:10a6:802:1::38) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB9PR08MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 665f4172-6cc1-47c8-b8f2-08dc879e8c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mk16WVRlaGRubkR3QWIrUHBkT3piUmtZVG1qK2UrNnhFVXhPTDZxQTQ4MElt?=
 =?utf-8?B?RlBFd0ZHVzhPTm96bCsrcVBDUmh1T0xjN3kwMzQ3enJIa09Wemc4Zk1hKzEr?=
 =?utf-8?B?ekp2a3hOYXo0eEQrMGFqN0dENTNQWTdaMjJCSUdRSlNLbE1iVzRtMFQwd1l4?=
 =?utf-8?B?bitwdm90OFplWXJkVDdTODBhbzJjQWhGNXltOUdBMTJaV3grYzFDbmJkaWwr?=
 =?utf-8?B?VkVxbExOWUM1VGw5WVRBVWh2SW9CNWFJUXEzNUdxK3duaTIzNldENjFLeks2?=
 =?utf-8?B?Q0tPeFNERFJFbDZNSVd3ZWxUQWFwWkdydVhrdEdHN3YvRTdYZmYvL0t6RXN1?=
 =?utf-8?B?MXlFUEkwMWFpOG9laDNxd2kyVENXaDIzcTJEdUlSVWpXRHFmWTBqVmQ3TDlJ?=
 =?utf-8?B?eURMR0djQjJkQjV0YmxTOCtmS3VBa1BjM3ZPbkVldkFadWRSY1Vob1B4NEdX?=
 =?utf-8?B?OC9KOHZsRE93bDZPODJtZUhrVWplcVJrM0EwQVYwaXJYQ3FMeVJKdHZuN0xk?=
 =?utf-8?B?WUtrRlRZb09BK21hVEpxalliRXpEMjA0MnhoS2wxT2N1TnFnWUZlT1h5dmw4?=
 =?utf-8?B?VUxDQnZhY3VFSWpkdk9pS0FHeGwxUWh4SjVhZklkVkRSamFYTWtieTVxVW5m?=
 =?utf-8?B?NW0xWjA3cElMRXFWeXBpZEtNVnpSMW84NzJlUlREZTJhaVdXVE9jdUFOeVVs?=
 =?utf-8?B?VkQrT1BsV0hsNjFsNVErQ3IxcVpiY25NQ2Z1ajdtU2FpR3RWbG1vYXV6OUZL?=
 =?utf-8?B?dTdRL2RUaE0yOFJ4ZTRsM3VzdWxLV1hKZnVndXdFVkJKejZUcTBiQjF5NG5W?=
 =?utf-8?B?ZVpSbUlaK2o4RlA4THllZnowNElTUGJBajA3RWlkdTEwek9wdE1NRmhnNXNV?=
 =?utf-8?B?bmNxUkhFckhac0pueXcweHpDMVlKOUU2TkZTNlZNOVN6Qk5SWUg0Q0ZLYm1E?=
 =?utf-8?B?TWhXWWd4a1UrZFNXUkZEZmd3WVY5TE9DTEk0cXozYmN6ZkpjRlZDaG5adi9h?=
 =?utf-8?B?azU3NElrWW52K3BnUmQ3Wk16YWZjcWlXalpOWXZ6ZEtyeUU3QjB0bWxVS0Nz?=
 =?utf-8?B?RHJSNnpUcnRTVTlBVExjUnU4a1dGVmZseHVjb2NSQm02eGJUZkViR0ZiSWpI?=
 =?utf-8?B?S2h4ZG1xZDgxT0sxN09hdXhDQ09ob1VoRGNuekFwVk5EMGJyY3pGTWxlU0RJ?=
 =?utf-8?B?SStDRUJCQUhlS3U4ZWlCWkRtdmtvSndzT3N5RG92OTF2dVlhS3JxYk02bHNZ?=
 =?utf-8?B?aitjYUhjVk1lV0p5eHgwSGRwZWNvd3l5Q0YrRkZKWGxYZVVKMGFyZFlXSHVP?=
 =?utf-8?B?a3kvRG4xQmZQcDduSE1lYm1YUGFTNFRXN2EyY2Q3MHhsTE96Y2tKNVpmTlhP?=
 =?utf-8?B?R2RWY0hSRmpIaEJ6aEhNaXd1aTdHOHhyeUlxQ0lHNzVrbUNkekRSR2EyZExz?=
 =?utf-8?B?Z280a28rVlpCaGpKMUxRS2FXbUhKc0lGSWowVmljeVQrTEpleDNiblpwK3Nl?=
 =?utf-8?B?WW1menFXQnpId3c1cWNoMUp2NGcwNGNxTkpFaDR3WTN0eFhBS01veTlNb0g0?=
 =?utf-8?B?ZXpLZWV3bEhQWXJJQ2J0TEJRSWJnL01WZVRYWXI3d3padnFQYk1VNzF3NDVW?=
 =?utf-8?B?MnE3dFlmeGZKaDZOYVYrUUJOWXRON2xiL1VtL2R4Z2RucHhFUmNvcnloU3M4?=
 =?utf-8?Q?hQ2eIIKkgCepqME+M1Ka?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRYTzNxV1o0WHZ1OEJDWjVsMGVyNThIaE1HVC85Uks4b0xhN0NPZjhXTTBr?=
 =?utf-8?B?NXYyZFN4enFxRFlFQWhYTThNNFpvd3FmemVGcnpqRXp4amlGR05HNlZNZG5I?=
 =?utf-8?B?eitsQ0REVk1yZzFKTk50MzljZFFiRlZTUzR4UUhyK0NVZjc5dE92TVl3NDFG?=
 =?utf-8?B?MDlBS0JhVDNTeEdpeHpxNTcyWEVXZDVPWHFUWGs5M0dxMmQxZ0FvVkFlZ2Vz?=
 =?utf-8?B?WnFQY0JWTElFNU9MYThTRmhQd3gyMW5BQ3dSVTlhcURmL3FhaGQyUlZ0TERG?=
 =?utf-8?B?bHRwOFozQzBub0RHbDE3ZDI4UmFSa041TTZSZG9ubEJPRzRLcnNpLzZsV3pp?=
 =?utf-8?B?bHZkV3NTNlZMc0FwQVQydyt4U2lTdW5RaC9NK2tsWHlESUp6STBsQytPR1l0?=
 =?utf-8?B?Y0tYK2hWRjg2T2l5MmpOakVlTzdoOE9rSXQ1R2VHUjlySnBrNHJtemFiVS9w?=
 =?utf-8?B?dTRvazJxTE5TcDRqVnpXbDdKcS9aTDVpeml1bmFoaTJWeVA5YUFDYTAxU25L?=
 =?utf-8?B?M0d6Z2EvM2dHTS9ZekNkZ3lyenZxOGU2QnRZRkJYSXVPTDhZQWM3NkJ6N0pI?=
 =?utf-8?B?b01VOG5WWUtMWmg3Ri9TUzdud1RNdmdSNWhzME8yU3A5RXJ1SmkvYnZHVnJP?=
 =?utf-8?B?a3JPa0xSa0ttM3V0TldSamYzUmlGNXFaOHFiQnV6eUNTc28venFoQUkxa1Fk?=
 =?utf-8?B?TnlyMzczdHNoNGkvU0Jac25CTlMzUFMwUGUvUk44QXM2OGpwNEZLZXFjb2Rl?=
 =?utf-8?B?RjBnMmVneWx6WGpBTVpOOUlDbzJDTGVWakVoUUZ4Qml3Mk5iSXNZb0owNzQr?=
 =?utf-8?B?N0xHdzNRRnRmS2VsQXc3enk2K2N1U29yY3hYZUEyYklVSXpNOVB0RHZldmIr?=
 =?utf-8?B?d2R1YnBNZENlNWdyMThHbW9tL1YxKzFNbXNEdUpmdkkrb2pGQXpkNUNub1hN?=
 =?utf-8?B?TStuRys3OFNEQUk2N0Rwa3lPTW0yVS9NRkg5NTFkc0V5Vk90M1htdmsxNUw1?=
 =?utf-8?B?aEIrNWlmeGwrU2Z0U3NrWWxpR3ZGeU5nK1JHUzB3RVRmUndwbEJ1dE5NOGF4?=
 =?utf-8?B?VmJmNWoxNnVNVkNPLzRWVTZDOVJJU3l3YkR0ZGNkRUdCRURTNzFVOWFTWWJn?=
 =?utf-8?B?ZEtwZUlMU2dtVVkvVkpQbm53QTk3SkRmTTVpQXNTb0tTS2RYdlFjcnczM2t2?=
 =?utf-8?B?UXhBaUIxeVVwOEw2TVgrVFQvd1NwdFdsczFyVnJqWDhuL1RvWml3OWVwZ0My?=
 =?utf-8?B?VG1BS3YrRW95ODhRWkt0eUFWK1YvWE1uY3ZnN2wvbE43NzNMa2J0M0hheXd3?=
 =?utf-8?B?NjdwT2NJMHBFWDVPV0tZM3pQNHZXZ2JYa21OWkJNemFQNUNzY1dZc1BLRUZS?=
 =?utf-8?B?TytVaDU2ZVdxekxFM2Qydi9la1hNU1RNNDdmYmgyUWlwUys1Y0NyUitVYWpr?=
 =?utf-8?B?SHZIaHp1Nk9iQkhMZ3JKdDhlZVdHbm9PODc0UC8zVkxkTVF0REtGbTRxS3Nh?=
 =?utf-8?B?WTRsZU1kdjhzT0EzTld5NnFZdWozdktYQTJRTFpWS1lkckhBckxpSVJsUHNB?=
 =?utf-8?B?NEp0TmI5SFhoUld2K1ZrUHY5VmR3bjNTUWhSdGxmZDN3NTNiQXpxUzlIbDk2?=
 =?utf-8?B?SXZTUlF2WUxmZFdyc0g1WnV2YlJaRjdEY0xLSWI3ZThUVGdwdGFqemxpUlpy?=
 =?utf-8?B?QlVNc2ZaV1E5a3EyN09sdHVCZTZJUkgvMElZODBDSkVrRzd2ZVorWjc3QTZG?=
 =?utf-8?B?YTlLaFFzbS9iL0lmSVk2UWNWT0tDYjNHcDBtdmJ0Y2tSeEt5ZVJtTzZ0ZkFI?=
 =?utf-8?B?ZlZ4MDJIRWsrS0llYldpeXV2YzFCRmZoVUljMUJCUnYvbEpxeE1HUWJoMng2?=
 =?utf-8?B?REFXWHBKbVhJaXRwVEpVSmRJTjFveDl0dVF3TzlDeEtIL25Pb1VuV0tkZUlY?=
 =?utf-8?B?KzFFNFN2QlF0bUQxbG9sU0VpbXVncjdoU0NiMFZ6NFRBTG1WZ0Q2dW9yRUdY?=
 =?utf-8?B?TXBSRnVYa3k4ZC8rcTJjUFdZSFM3dzI2eUFIeTBodlcyNDhLS1lZVVkwS01D?=
 =?utf-8?B?bmZjazllRllPelRxRTdBbDRlREs4T3BqQWtnRldHY1hiR0wwZXN5aTRUTFR2?=
 =?utf-8?B?N01OMmhLelR6YUFiMXhIUXN1Y0h3NUR6Z29oZzYrUmxUeDYzVTJxMnFtUWlY?=
 =?utf-8?Q?N9d2ubvbIQKwcJt0xbdAtkg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665f4172-6cc1-47c8-b8f2-08dc879e8c88
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 09:37:01.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BDyuh3Oy58lLJvPQs7bg0MXjc89zoasONqwbqfdejb2HSIPsMlL16AiKrW3urN8EcRXhVZTj2gPkQXWjAJtiI/2E7K92Pgj/lgzK/2o4nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6490
Received-SPF: pass client-ip=2a01:111:f403:2600::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--------------EGUCwYg2kTUH0SSKOKolHtAf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There is a bug reproducer in the attachment.


On 6/7/24 17:00, Alexander Ivanov wrote:
> In some cases, the NBD server can be stopped before
> nbd_blockdev_client_closed() is called, causing the nbd_server variable
> to be nullified. This leads to a NULL pointer dereference when accessing
> nbd_server.
>
> Add a NULL check for nbd_server to the nbd_blockdev_client_closed()
> function to prevent NULL pointer dereference.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   blockdev-nbd.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 213012435f..fb1f30ae0d 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -52,6 +52,9 @@ int nbd_server_max_connections(void)
>   static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
>   {
>       nbd_client_put(client);
> +    if (nbd_server == NULL) {
> +        return;
> +    }
>       assert(nbd_server->connections > 0);
>       nbd_server->connections--;
>       nbd_update_server_watch(nbd_server);

-- 
Best regards,
Alexander Ivanov

--------------EGUCwYg2kTUH0SSKOKolHtAf
Content-Type: application/gzip; name="reproducer.tar.gz"
Content-Disposition: attachment; filename="reproducer.tar.gz"
Content-Transfer-Encoding: base64

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

--------------EGUCwYg2kTUH0SSKOKolHtAf--

