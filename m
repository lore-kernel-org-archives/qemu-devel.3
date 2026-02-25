Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E74EFD205
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9tC-0005DM-St; Wed, 25 Feb 2026 03:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9t3-0005Cc-Cv
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:50 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9t1-0000eE-J5
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2+VT+1Oh8EdrfIQjH4+VN86A2SdrnjZfYaO4IvwxviumzAICEqxmRuZBGQrVoc7EeTyxaimylhmbtAAT0ulqL7Vb00RuxC1e2Acw/y2DUDZ71xB1HtNRQO4q55aLdcjk9Gupghxx5RWTtFv/19IFALPPHcOI5h8VuU/tP+w8Ia89+7R799y/Rr11LQxxAV8RdMGfwa0vn2gXcHiwJwMe2LZgC3nU3Glia55Sy8XaVDSkiFd4HMVGFBnNFYO4DOANxGwMIaaY49X6nwqfxSK4jP5GAj+ykUXv2hLdMVFQ4TAaQGZnP7yN46kK1oxq2hTlfYjTkVtLQ84srb0t95grQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcYyamdBhVDPyQVQK/UMCL+bjgd9fBd0L34Dg0x55tI=;
 b=TPe0Z8TlkFncYUYdbYB6+uDDZcpOG3fdkqEFtBqvNnlVPn3tx0CDwGcjQNLVVSHranEamYfaGOWy2MdLQDnkcsPaXlLz+BQocff76mpweviPsLIEp+ztNx4QY/jQXRRKOCZyPNCuPq/U4McqvXsCMybW3gm6tg4WQE0WisjHrkP7nCKjNNL9HLdq4oyuYmGG6uWCY+cNg/wuKyqB2yMzcAqSMfZRT+8v+Yov1jjcFSbzEDL7la4aEstY1Qkf7nbXpaYRImZQRpsuwk1RYVOIeAalDfpuMZeg0QMUEGclfOBb0fN6OhRlLs2erK2pm7iVF+VoBcKIZJ+BgSsNE6b0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcYyamdBhVDPyQVQK/UMCL+bjgd9fBd0L34Dg0x55tI=;
 b=d5pDRaOmBC2sRV9uTdELA/K1kU3Ey0NovUC9tLW2PaOyA32P0A55oUl/9YHFkShL2Hlslpj8M/6D+zwUSN0+/tDyDc6nzBQ5eeStn8AeM2oxael9SwEouJWc173XUaqg5HjzISjjcQ4Wy922fsnSrlMZHnddW9ypzZqjGM+yM4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1238.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:04:30 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:04:30 +0000
Message-ID: <5e129cf8-6498-44a1-b09f-41551ee11974@epfl.ch>
Date: Wed, 25 Feb 2026 09:03:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <e39a559d-337a-48a5-8e68-27d494ad1ec8@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <e39a559d-337a-48a5-8e68-27d494ad1ec8@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms060000040904060508090200"
X-ClientProxiedBy: GV0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f72f41-822e-4ed3-dc29-08de744480cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmIyZXdQNWlvU1N6Zm1nYkRRdjBzbXI4OUlyRGNaV3poUDUyMWFZNU14cytu?=
 =?utf-8?B?eDhMbXViTWdNQUJZSzQrWWgxOEF4cU15bFBDMmI2WDNUWTkvb2pka3dBWWlI?=
 =?utf-8?B?clNSMTN2ZEVzbGUvQ1dJQ1lZVnhaVGUzeFg5L29LeGdNUGozb2JDMGZkbEdM?=
 =?utf-8?B?eTNEazhxbFI2cE94bEZKeHk4d2ZFWDRPMU9HK0JGVTVGV1RTK1NOK0FCVlFa?=
 =?utf-8?B?K1pZcWxkaXNzMk94L0NMVGFmdlZGd2NWS1RmQTlEZDh2cVgyUmZVTjZqM3BD?=
 =?utf-8?B?NWhheDVmeFlITTBqbW0rUUdnZGpCVUQ5OW5Na2MyT2FtSzdOb1UycSs4ZXFE?=
 =?utf-8?B?Z3IzQ2dKWGJuYVpXd1FhakIrSzdmQmliZ3RsZVpBU2JRTHd1dFJ4UmlNRFpl?=
 =?utf-8?B?am1IVUFlWTQzKzlwemZka2dJVThBRCtlSjFCQWt4Vmd3akZsUVdsOHRkVjFk?=
 =?utf-8?B?UFJnUWp3RW9KYTZOVnh3YlhNYWtmWXovVSsybWt0YzUyQk1lVkx5TUdCcGNQ?=
 =?utf-8?B?NFBlMU9YbXJCdForellnTXJ2clR4UmJEeTJiZ2dud1R6QlR4VWhUcFpYWXhk?=
 =?utf-8?B?WTBHd0VqT2NKTWNzc2NRMzhOS2ZSZGhCVkJqV3FudERMczg2TWI4dVhLdkJr?=
 =?utf-8?B?bXpjNGpPZnZaUjBSSzl3UGFPbGVJRjN6dEt3MXAxZTBIV09veVNJNXRJNnNj?=
 =?utf-8?B?ZHF4RkRuUDA0N0JkR1RaOVpPZXdXekw2cUpzbmVma3RjcUFEVnJmNXRzSmh4?=
 =?utf-8?B?ZWt6U0VqMlArVWZ4enRZVkdCSEQ3S1ZCeEFzcGdEY3JSTTgyOU91Z1hNdUJj?=
 =?utf-8?B?SS9wSlZHVjJHb1VUNFI2UW5BdDFNTmtZSlBoOTZkYXVxVkpkbVA1MXdwWmtw?=
 =?utf-8?B?dkJPREQ4T2lmb2x4U1FBS2thL3YxOG1tc0NjN0l4N1FTemdhUCt5UzRMRHo4?=
 =?utf-8?B?T3RkTERhUi9TUDNJdmZNM1BmeHVWMnZpanJEMkJNWWdQald5NTFiMXh2NitE?=
 =?utf-8?B?bGlNekg2RUtOYk5DWWc5aUk4UTAyMXlwa0xLbzZwTWU2VmZMS1VudUpHaUF6?=
 =?utf-8?B?bVhqZ2NUSHZCanY1Qzh2RXJ6T3BCVFJ1eVJpbmd5L0YxcVFGWjlpak5xNEtw?=
 =?utf-8?B?U0RzVG9aSDVPb0tZUW5RcHJ0eUtWU0Y3L1h6eDBHNWYzelFSS0lXRWJ4dlRv?=
 =?utf-8?B?eFlBUG4zZVVMRWd1NFdaaEE4elVRNGlUcWw5MVNzMXVieDdrejVGek45N2Nt?=
 =?utf-8?B?aUlWcG40MGNlMVdIcG9SbGs3WWFxRUdVSlJhTWdoMTF2N1c2Zy9LR2NoUnlF?=
 =?utf-8?B?TE0wRVREd3ZORkdwaW9XQTJIZ3ZSUVc4TmRlVmo4djZRdGJUUnBvS0M0M1Vx?=
 =?utf-8?B?dzFNL0k3T21BNUd3Tk94R2ZhVHNDOUFpZE5CdVJKSHdpR09DcGdPeDdkMTVI?=
 =?utf-8?B?UjZKOEZmczNwKzE3ZHY1dFpNQmI3UzkzUVFGMnI2aEJFVXF4aEFQeG1LekpQ?=
 =?utf-8?B?L3JkWVdwazBDazRIU0xUQVZTaHFvak51eDhBRGc0UjhnbFdtYWQvVFRRNWpR?=
 =?utf-8?B?R3hYWG8yaUxZSnhQRDlFa3R1QjVDek1hZkJmTmNKWDhsK3F3bE9lL3F3LzMw?=
 =?utf-8?B?QzhaUU5jaTdPV1NZcTF3RE5aTUl4MUZpWmpHN2pZR2Y2LzNHcVhvRGlhaTEw?=
 =?utf-8?B?d1pac05FdHNqUHpyOG00a243NVVOWkxHVFR5ZGJ0WnpRcTMyU1B5aEVWQUdO?=
 =?utf-8?B?WGRJUUs3M1ZtbG5ab2NKSnBNdC9PM3FnRlUxZEV3SlR0amZoRE1EbUZTNGNY?=
 =?utf-8?B?cXAyTHU2ZE8xUUZ1OE9raXJXSzQ2Mkl0Nm5ReG4xRjEvL1VzYVdOZTJDenJQ?=
 =?utf-8?B?ZFJwWjVzazhtSTZiUDh3Kzc3VlkvQUpHYktYSTdHYVhCNTdXYTB5N09FWCta?=
 =?utf-8?B?Wnd1WXg0ZDhWTzNtWEYrQjNnaWFoOHRSeVBzTFVsTS9TNVdmclAySUM1dWU1?=
 =?utf-8?B?S0JzQ3RkU29BT2ZkRkhqUzcrek9adFBrREFiOWhRazlmTWk3SEllelF6RHQz?=
 =?utf-8?B?N01QV1JWaC9tUjlxYzQwRHJ1ZnRiNDMwVFdRTkFxNUJzY2JVa01XZTNGcTBT?=
 =?utf-8?Q?yRpc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9zaFo3Ukw4dWgreVNhVjMzYjVBN1hQbi9BS1NGQ3pUNmt0VHF0eWtkQ3p4?=
 =?utf-8?B?NCtBbVJVQkZZY3JYcWxuc1lFVE4zZUYrOVAwb2p5UkxqdC9WaUdPN2lPZVlq?=
 =?utf-8?B?QjFDQXlXRGh2aDEvdVRtWXJ3QkJBSm1YdU9UREpRbG9UQVNTdDJ1ZWRQUWhy?=
 =?utf-8?B?QUpSOWlqMUllS01XY1VEejFLdjlIQloxcFRaZDJjRDY1bytEZEJGT24zUm4x?=
 =?utf-8?B?WE5HZmZiZE9XMlY1eExuSFd6amxpanhnSmhldFJwTFlNbWx3ZGF6aXIvZWhL?=
 =?utf-8?B?c0o4MUVDeWtFUjZBNzFiNStCa1I2USs2OXhjQ0g2bTJ3VExJaXgzaTBKOWhm?=
 =?utf-8?B?M25GMXJUWThpQnV6ajNjdmc5a0srLzR4SVc3Z3ZMMjFEK0FCR0NuM0lPN3NZ?=
 =?utf-8?B?RTdqMUIxMUgvUEZFMkh1Tk1lMVVYVUtaSmh0UlFGNDRWcTY1TUlDYTdCbk5o?=
 =?utf-8?B?dG9wL3pMUnltb3ozNmdHdmJkOEtPaHVNOXA5SzBnK3M2VWZYNHBIcElzWlMv?=
 =?utf-8?B?SzZQUVBKV01kNXdRbGtLR1FGaFpnMEN3WHowSnNnYzk3WElVcHVqL0NnL2hO?=
 =?utf-8?B?WHlkSWYvaUoybkNQNXdkRUYvbVFIWDJTZ0ZkUVI5WEtpRDh5UVFHQmprTGxz?=
 =?utf-8?B?RyszeEFmdE55ZWt4N2hPOHRxU2pkcVM4bGZyNUwvM2pKb1BVSWpmZUFiQmxM?=
 =?utf-8?B?VkV6Wk1hc2x0N2x3SmFCWGR2eUlpUkZmYUNSOHRlOFNDRCtjNVlzVnVOYVFC?=
 =?utf-8?B?aEsrcDM2QVFVTnBoSXNWVGRYVEV3Slk5a085V2RUYm9tV09MbThXd2o5aUpt?=
 =?utf-8?B?UXVFYU5NVjZ6WWlLK3lSVWFSOGVJc25JaGNJZzhFbzhIR0NCaEhLTzhQZTY3?=
 =?utf-8?B?V2RTWFFjWTdhckg4c0FqSDZYNytIOCs4YnNjcG9udTN3TlJyTFpyTFJYR1d5?=
 =?utf-8?B?UlVYenA0N21iQkpsbDlBcy96L1RXVS80akdPcHEvODU1MTFrWXdhQUhmM3dO?=
 =?utf-8?B?NmQzYVhVWEZtRjZaVWhIM3JhQWNPOXVBQW50NWVLdS92MVcweDNLVEk4eHFN?=
 =?utf-8?B?SThJeUxsaklyQzQ3aGxvSTAvNlcxSlM3L2xqdXJhYURWNVBPd2taRDk4RHdt?=
 =?utf-8?B?K1pFQm15Qng0dkpJS0JyUHY5RW1oMlRuV2ZVVjNmdURZY29VMGFWc09UZUJO?=
 =?utf-8?B?TzZ1Y0FDNFdZVVVSODBsb0hlcFgzTVVXaEdlYWl2T0c2N3BoZW1qNnJLWFlG?=
 =?utf-8?B?MExKMjAwNHJ6cC8yWGs3aE5OOFpBWWRoV2diUE9GWVFya2czZnJEM01BRGQz?=
 =?utf-8?B?UWV1dTUyVy95VUo5VXpJSHRZK0lFUUpYMVlERGVsVHlNQnQ5cE9KZVhYYWZ6?=
 =?utf-8?B?WXpGK004TzhrUFlDdU1JVExIbVlQOVZnbGZSeHg5WnppY3V1b2RSR0xjK1F3?=
 =?utf-8?B?SWttVjRVWXYrUFpYNkZYdi9ZM2JEUEJ5MkxReHJ3a29jcXhqdDFHcitpZGxl?=
 =?utf-8?B?cUVsRUN5VURHTFV3bGNtblF1ZG02YnpPay8vblM4aVl5Q0ZXV3BmUWdJTG1k?=
 =?utf-8?B?eExQL1UwamE4RWg4QWxWOUlFZXI2UGtpRHZUMXZvQnZqcDJoVkgvMEVZa3dF?=
 =?utf-8?B?OHcvMVREV25hNDB1VHppUVFoWTA1NXFNMU8rb2J0UDg4RlB1WTgyR0x6MkZI?=
 =?utf-8?B?V1ZXeDh3MzUyT29jcDlYajZrYkdYSTNTcHM0VFFhcWl6ZGFnTWNaVVZsM29m?=
 =?utf-8?B?WVNKUDBseU9Nc3R3a2s5NkVwOHIxMGJXaEtXMk92NXYxTnFacytFd0pGVE9j?=
 =?utf-8?B?Y21EL0FVdHJSdkxYdmRUb1ZoYmtraUROTUhDdDVhMyt6aWR4MzIzZkdWTXJH?=
 =?utf-8?B?eDhVUU0wTUFRejZZUDNDOUdUckhXdHNNQzN4Qzk0NzIxZG85eDFVSEpyOEJ0?=
 =?utf-8?B?TnZWb1RBYmdHUUZjSVBUaGJYTmdRei9aN1gyeWxXSjgzV05GTDhIcGtvOXRo?=
 =?utf-8?B?dUhrQnRqYVhDVlNBMnZlVkcyKzJtdUgwcUxyeTVSVWprNFRHc1VEMDFjMUcv?=
 =?utf-8?B?QU9OOVlSOGwybzAvbFFlNFYrTFdYYkRpT0g4MEhVejdoV213bXRjK1UzQXBs?=
 =?utf-8?B?elVDcnVZbzFJTHVlU3hScUdsNVI0cVdFU3NiSm9qTjVYNFRNVFBYbmVnWXgw?=
 =?utf-8?B?RHcvdDFhbmVWVG5vV2wrczdVaGM4OVNIdXlsQ0xwNndZZ2dROEhvMG12UDYz?=
 =?utf-8?B?YjBTN0c4R21SbzE0YW1zeTlFSklsME85MXBGNjhZU20wajFmSDE5NzZSd2Nw?=
 =?utf-8?B?UUYzV29VdURpZXRxdzFxOTJPRzVXZTVuMmFiZ1IyS21VZEJWWmY1Zz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f72f41-822e-4ed3-dc29-08de744480cd
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:04:30.2564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0DnyGvM3M1+ogzUMzcRZzvThBPlwPlMnz0RMgFCbPiKoitchDl83CxYryrhAprV10sV0IswDbgwpEKoKqzkBoj1ZDWLzIUtEANfwL2qmtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1238
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
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

--------------ms060000040904060508090200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/02/2026 22:28, Pierrick Bouvier wrote:
> On 2/24/26 7:52 AM, Florian Hofhammer wrote:
>> The test executes a non-existent syscall, which the syscall plugin
>> intercepts and redirects to a clean exit.
>> Due to architecture-specific quirks, the architecture-specific Makefil=
es
>> require setting specific compiler and linker flags in some cases.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   tests/tcg/arm/Makefile.target                 |  6 +++++
>>   tests/tcg/hexagon/Makefile.target             |  7 +++++
>>   tests/tcg/mips/Makefile.target                |  6 ++++-
>>   tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>   tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>   tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>   tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>>   .../{ =3D> plugin}/check-plugin-output.sh       |  0
>>   .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
>>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++=
++
>>   tests/tcg/plugins/syscall.c                   |  6 +++++
>>   tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>   12 files changed, 131 insertions(+), 3 deletions(-)
>>   create mode 100644 tests/tcg/mips64/Makefile.target
>>   create mode 100644 tests/tcg/mips64el/Makefile.target
>>   create mode 100644 tests/tcg/mipsel/Makefile.target
>>   rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (10=
0%)
>>   rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (=
100%)
>>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-sysca=
lls.c
>>   create mode 100644 tests/tcg/sparc64/Makefile.target
>>
>> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>> @@ -0,0 +1,26 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This test attempts to execute an invalid syscall. The syscall test=
 plugin
>> + * should intercept this.
>> + */
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +
>> +void exit_success(void) __attribute__((section(".redirect"), noinline=
,
>> +                                       noreturn, used));
>> +
>> +void exit_success(void) {
>> +    _exit(EXIT_SUCCESS);
>> +}
>> +
>> +int main(int argc, char *argv[]) {
>> +    long ret =3D syscall(0xc0deUL);
>> +    if (ret !=3D 0L) {
>> +        perror("");
>> +    }
>> +    /* We should never get here */
>> +    return EXIT_FAILURE;
>> +}
> After reviewing patch 2, I think it could be nice to test also the path=
 redirecting pc not from a syscall, in addition to what this test already=
 does.
>=20
> You can reuse syscall mechanic to communicate with plugin to share addr=
ess that should crash and which destination it should reach instead.
>=20
> And while at it, you can add the same thing from a signal handler (reus=
ing syscall trick), so it should cover most of "special" cases.
>=20
> You can merge all test cases in a single test.c.
> Also, you can create a new set_pc plugin combining all this, because ot=
her test cases don't really belong to tests/tcg/plugins/syscall.c.
>=20
> test.c:
> int main(int argc, char *argv[]) {
>   syscall(..., &&skip, &&dest);
> error:
>   g_assert_not_reached();
> dest:
>   return EXIT_SUCCESS;
> }
>=20
> plugin.c:
> static void* error;
> static void* dest;
>=20
> void on_syscall(num, a1, a2) {
>   if (num =3D=3D magic) {
>     error =3D a1;
>     dest =3D a2;
>   }
>   return true;
> }
>=20
> void insn_exec(..., void* pc) {
>   if (pc =3D=3D error) {
>     qemu_plugin_set_pc(dest);
>   }
> }
>=20
> Regards,
> Pierrick

Makes sense, I'll factor that out and add additional tests for the
functionality.

Best regards,
Florian

--------------ms060000040904060508090200
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNTA4MDM1MlowLwYJKoZI
hvcNAQkEMSIEIO94ckSXfRpOE7RjIq8U/Ro4mMiZ/rv9HfmLHvFPBiSJMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAMNLOOyWgWKiE6amSSudq1P8K6hf
xXkk5UxZer+wVVXYN7p1bfX1lsEr1RgQi6h3DpAnOdE0IwNRsT3EFg5d7KYCPjfUo0iS3iOc
QHksg64Q3Gb/z20aGGR1w6p4sFXNSkA4Oh3/q55/9olgPvYrvFRZgDvW8nlTbR0YLYRkJvcv
jCbmaUNJ2mP7GlyGUGLFmw83yY5btuXoAhear2/iMOhl7ysh8rwxlY85iW0roHTMwr3Z9WXs
+391Cv/sI7VbBPfxQIYSyjO6DgYarxZ7F77abv0bQAqv/QvM2FpNh5v3G2uLYCkPcU6e3FVm
zcjjMdvu+03PQ4GtcDd9qsX6yh4AAAAAAAA=

--------------ms060000040904060508090200--

