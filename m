Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3C5E7E0B9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpO1k-0006Dv-CZ; Mon, 09 Feb 2026 04:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vpO1i-0006DU-Id; Mon, 09 Feb 2026 04:57:54 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vpO1f-0005pe-7m; Mon, 09 Feb 2026 04:57:54 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 618Nd7fg1496971; Mon, 9 Feb 2026 01:57:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=d0V25+EWp08XisfdF9Itoppb+ifPIfLeinhDdczx1
 Q0=; b=fdCXhWf6xWwIUzJaV5Iw7raWDSw2pyXifXOoiFO7HLxDUZxPs7e689oxB
 u22diJs+qvVQkHSnjyL7eTj4zGwovCHqnZEgblJW5WoITgr+jEx0Un1alGxopNIT
 lTB0mWjpqUjBTPbV0JTRS4N1RL2cOgvgeIx57ODGjivpgzyNxbgQ2VfjrE8zIhbs
 kzNsECMNVlCMwswujmC9Y7TwQW5TY+yfpAvOhsjzOTq3GmMC5O44V3qZH6RdO5sY
 gO9Yjl8Asezd0z2YkCsjLD0qW/FkMb1G6ayrTw5LrpmtfC5mGSifd44+C94vZ+HG
 SdmXxiyBQ/2YbM2/dze35kg0RbPrg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021089.outbound.protection.outlook.com
 [40.93.194.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c65twtspf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 01:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAnimAcBaV4vpHklzhBsPOIkV08tQXlZ4sTQBw0O1wDW1iTfEPadZaA1zwdiHEPDvefi42qm+4qI8fs0oWAnC4Q2Ulu262D1+/Wmlxf2TdftTq7qVGarFqq9gFqeGYX7aYiWKGDyO3qi5JTT4ALJUjUjxFIR9Ke6bk7/w5lBD+aZLILvEXQr8hIUcZZzVismhcIh/WZ6MJlgsbOOTL8WLlK/Cas8iF6Q1qMpuR5IR1uppzcxLIC4QCZs2NwKmCmnwDsmLU1+P3HhwZTCTh2qg5NL3QywMJWwz0nYSP9wM8rCbp2CcIeGxCXXkF0m9hkXkGpe+9q5ylgSDCXdxAEmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0V25+EWp08XisfdF9Itoppb+ifPIfLeinhDdczx1Q0=;
 b=LBnJMS3al5imQJrLHR92DTlvQc95DBzKw2HKM7Lwcvnjac1x+VyYilfGgp4OFeQGa94GSrvMEW1HYoWjdMD9LEiIrVJrhMzqIaY482Hk9Fg0d+BUfysdfO9VE+ymfvoKrHFw4K4uzWmN6YQN6wNsV2EoJilT+sQ3m5Qshii8U3/WUAp7VIlMCdUdcjS6P7+KnReaSRo2jMrsYKtJkiZNFSZav4hXh1A9YXW2IjW9BUMZ7OiFv8aGttiRL1ahNduBNlVpWQiZGf6oaucakCEptHeovcfZOlSuDmhMuihMEmkTRE4XU55nRSxEjvAuS0aIbK60Bc+mLwMHxmHmR5DZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0V25+EWp08XisfdF9Itoppb+ifPIfLeinhDdczx1Q0=;
 b=IkmhYTOJfp1vPNBWzh9e1kt/F7QHUhzS2SWEP2LmfMagVFUcMrqDlG4wM4nPKIpuXACdG5vozZWLTdqHe8AR5SmbQXF47SXyIGzfIp9AKe3ALAiijaQNFB573Vf/7V9S8wqXew7EMzlh1jz/BQuv6WnifdPxw8zSQaH1kTC2Hcay/QHLZwA8QebdgjvD5FcWTOEKyhRUj+iWqt1wDBeOpFIdQ82WiFaPPMWzGqPd2i3S/NQLwFfIpunudQiLmMFDkQ/cUSJF72qlfrTLoZYDNeoihkVi7WQPVSldCI5hmzheWYxc7NtKj/59nrbc+U+jgG687bGbe9GRjhx9czojRA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB8968.namprd02.prod.outlook.com (2603:10b6:930:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 09:57:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:57:14 +0000
Message-ID: <1f688aaf-c476-4fd9-abe8-7c4028f6e6e4@nutanix.com>
Date: Mon, 9 Feb 2026 09:57:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/20] hw/i3c: Split DesignWare I3C out of Aspeed I3C
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 Joe Komlodi <komlodi@google.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
 <20260209091629.823457-4-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260209091629.823457-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 726b5378-bd9d-461b-129e-08de67c199d1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDZ4WFlORkdUUXpCQWlLaXZzT2Q5OVc2S3k5VmU1aTZldzNHdm5oWnZEYXhs?=
 =?utf-8?B?OEthdWZpNk9BUFpTMWZLWCtyR1d2QThlN1V2TUdtM3RmYWJpNlNtcm13YWVw?=
 =?utf-8?B?ejBpdUcyWWM5b1pCOW5FeXlFOWN0amhwaW9md1BuTE5xR1NWejA0bldYZWl1?=
 =?utf-8?B?WEM2RFY4RkZVUjcxYVc4aE1FdzUrKzZZaEF4dkpRc0ZwMVJiUVFLelovcFFy?=
 =?utf-8?B?M1A0WGhZR0tLNGhjZ3VpaEU1TkVlbkRZZSsvSkhSZDQ0UURNczllNk1VRWVK?=
 =?utf-8?B?SlhUdUZmZGMwbUllSWVvanh6MUZ5SjB4YWRoQmd4VVdzalJsa0F5ZlZIN05Y?=
 =?utf-8?B?MGk2ZkdiS01PcDM4NnluZTY3K2JjWTg5MEFLSm40Smo0eUxGZVJuWGpoNW0w?=
 =?utf-8?B?V25QVXNZNkZFckJKV3Y0TmprV0VURlEzMzNvOEZQbUVWK0MvRnczZkxHbXJU?=
 =?utf-8?B?aTV1ZzVlRzREVURlWmNRa01JQUo0SDhUbXZSbWFHWWNPYU45V2lkZ1ZLYXhj?=
 =?utf-8?B?TTBEYmJtQTlvZGt3OHY5RGtvcnZHRzF5NHh6THhFeFVjUmNJMzBqQTdwNzhJ?=
 =?utf-8?B?N05MakN2cGVRNjVuVGxaT0hDRDlBUjhrWUkxQWcvNk9NSW5WWUpEQjNDRUhz?=
 =?utf-8?B?KzZZS1UvVmgyc1VTblhzaWJzOS9rSjJod3k5MlI4bWFKMnIxbkh3MDNMeWk4?=
 =?utf-8?B?MXZhR0JVT2hJOU9WdTExRmZUZDR4QXI5YWlZd0QyNFhHaFhhQnRoa3c1RGhs?=
 =?utf-8?B?Tjh5UmVrR05sbWVBb3ByRmpiTTRCVEx6Wlo0TFAxVzUwUHFCYlUrU0p4bnRU?=
 =?utf-8?B?aTNDak0xYkppTzdranRyNFJ6OUw0R0NRYmUyQnY4M2FuYW5QQzIwaFI1WWFL?=
 =?utf-8?B?R0l0bDROK0JROWFyOEFEbzg5N00zbGh3S3ovUkZ4UjFKYTQxYjFqK0tKZGZL?=
 =?utf-8?B?VWNWWEVlNEJ6aXVxbU1mVEZDK1VQbVlvZnFzNmsrTlFkRktXY1VQM1FjaTcr?=
 =?utf-8?B?Sy90dVBJOVRyMnNZMnhEY1lCR0ZZK2l5RkE3YXlZTlRuYWt6bitacFlOcElm?=
 =?utf-8?B?K2dGY1dxVFNEeHp4Y2xUWTd1TngvMDRIaEoxOWlQU3lRS0hUSVNpYmRSWC9i?=
 =?utf-8?B?QTVJSkJZVjZMRjFqc3REenZNUWRtWXhBYld5a1VUVFY4MVRWaUhKdUVRY29Y?=
 =?utf-8?B?VHpzQ1YwUTN1eThjTGl0WC9LS0s2azNTSXpXaXdZRHRjamU5RzZLMGtyZDgz?=
 =?utf-8?B?WllJVFB5U1hMMldMcWhmVWloV3RzSUJPRlFubmZ3Yzl6UHBwSlBJY29yaFM4?=
 =?utf-8?B?Q2dvTDhBc1haUjFvZXlSSzZxRTlRQkVIZUhhZ3NVbWpyT2JJMDNVcWJTMTRq?=
 =?utf-8?B?TEdmOUtEcmErcnFvQURhTk05SDRYK0VkME5qM080Mll4YWJLaS80SWVOb0lm?=
 =?utf-8?B?RVN6RDB3cWdQRDV6OXRSSDNNbVZ2cW9NRGdsYzNvR2RRT0w0bmdKd2tGUVgx?=
 =?utf-8?B?cHFuRU5vbDVZcjhmem1tRHViMUxWc3NKTWV3MkJFdUhRbHpEL1Z4R0hxeFRk?=
 =?utf-8?B?bXU2bEYycjkyWFJkZkl0YkxnclpzUmR2MEdkSTZqVUJreWVzVXBYZTFyK2ZP?=
 =?utf-8?B?RXhLMFBUeit2MGwzVEFmcDBPTUJjOFkwV2NuQXVqMERxcWF4RTRnUnAxUytl?=
 =?utf-8?B?Y3Y4VHNtci9hVldKSU9xU3F6aUJZdkJFakk4RkxVYlplTGJpZkJXZkdKeGhq?=
 =?utf-8?B?WThIdjdBNW1CMy9nNmpmUmo4NmR0d01RT2lqdkJ3WmpnRkthN3pSNmJ3L0ZN?=
 =?utf-8?B?d3Vsd3lQWCtEclN1T1ZuVVU1UFN0ekQ2ejFmZmd1SG0wNzJqdEx1OTVDWU5I?=
 =?utf-8?B?YW9KYzFTdVBpMElpUHhuSHVWOUFFbFpuVTd4SVdUbzZyNXRkRElqKzdhS1RV?=
 =?utf-8?B?Skw1N2drNU1JajZpemNqM2JCNldRR0pTcGtBU2J1YWt0djRGNU1sa0RjeVdq?=
 =?utf-8?B?eW5MMkYvYTl3NEFxTGxtVEw0MUxKb005YU5sMy8vOE1kMW1Od3NyRW4vS28v?=
 =?utf-8?B?Y2hLUE5tdGRMY1BDREo4YlhSajhtRnV1Uk5UOWVjdjFOVEVXN2wvZ1kzOG1n?=
 =?utf-8?B?NWN1N1JaSkZFbkQzWHdIL2hHZk5WcjBxM2Q3VXRlR3pCTDY3MEJpUmtjT0Vq?=
 =?utf-8?B?QlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGNsRENpQk1uaWdQb0dLL0VBQVFVb1hJakU5UHQxR09Ibno4T3lXcHIvNjE1?=
 =?utf-8?B?YTJmaTVXTlUzSXFpTWJpN0tSaFg5R2ZiRmh4QnRyMlV4eHV6NndxUFdzRWtQ?=
 =?utf-8?B?Zm5URlBrT2F5eEh3TjBGTWJ1dDA3NHNJNFhmVGk4eEFEdzRjTDc4YzNrMno1?=
 =?utf-8?B?MHgvQUgwZWJwQ2UxT0l5YkUzTzI2aCt4OC9GRVViYUJWQTFRdTFKdDh2R0hr?=
 =?utf-8?B?MFkycmVuNkV1WGdSUzZIQVJzbzgwdHFQQnpWWEZBeElqWGM4VUtaRW42d1lT?=
 =?utf-8?B?Zm4xb21NV2VGN3AvcjRaYmVtblRIRnEwNEZtTnM0SDE4VlFmMXZ6OW1ua3lH?=
 =?utf-8?B?QVBsNTlKZTNaRUtJT1g3Q3pJS3djMWdlWm5sdno5VGV4WXFUZ0lQNlNaTUJw?=
 =?utf-8?B?UjdHM2xzY1hSRklCSld4amo0VHhjMWdPRTFmTGRtaGpVK09vNzU2K3pCT1M4?=
 =?utf-8?B?dHlXQ1Bla1FaWjNFTlN4SnEzSkk0VXovMk1EUTZhY2JDLzBoL0ZIcXU4bCt5?=
 =?utf-8?B?KzdJZHpKVFUvdDBjcFMydmRXcVcvQmFaNHRQemwyRjE3bnNSWUY1TzN1SXZz?=
 =?utf-8?B?SGdOQlN5MjBGNjBEMlBETGswUTVpeC9TQW9NeEpCRmpMZmlGQjJudDFUVnE2?=
 =?utf-8?B?SG9MeGUwdzQ3aWhRQkZIdHdSdGwzKzllUDM1Y1NzelRpV0hNQndvRlFRaGxH?=
 =?utf-8?B?aG1EenpLK0hwMHUveHZOaVpGdXVGZUlqRnVUZGM5TjcrTGxFS0thN1FkMWhI?=
 =?utf-8?B?ZVQwK3NwaVlvTlJxUWdkSUh5U01oNktFTFVreFNGaUI1eWlNclN0QkJLRVox?=
 =?utf-8?B?ZHB3eFp6TlVtaS9oeTVVb1l2djN0b0M0WkxGK2NybzhOTUJnQVI3MEd4T0wv?=
 =?utf-8?B?aDJaSFg1WGtkdDhSZTdQZzYwNnlJS2tBTDFIK2prNTFMd3BhK2JLdEZJZGN5?=
 =?utf-8?B?aXlkY0UyTTAramMzVHhVNWUzUzJBWExPdlpQb09naGd5Zk1Kelc0YlpFTFIw?=
 =?utf-8?B?M0NmZXEyMzkzNlEzaUhYSEdtL2dqeGlDaHRlamhJRXg4NSt1OHd5VkcrK2d1?=
 =?utf-8?B?SnRpYjkyMjZPYWpUdldzdzFlS3lnMGhRWU1VTmt5ODhXT2VjU1l4TWhGeE9a?=
 =?utf-8?B?WEo1RERhR2RTaHRwSWdaRXcvWitZNWlQdHhTOEtxNmxKUy95amxvbUgxNlMw?=
 =?utf-8?B?V2VoaUdHdHlSRTN2a2VvWGdHZk9LTWRYNU9Ua0hNZCtNdVhpUTRwWVprdjJw?=
 =?utf-8?B?a2twZHNIbi9GdU01UEgxVEhkb0ptR1M4bStxVjB1Um5jWkZGcUhwckoxUWlV?=
 =?utf-8?B?aXFjdStkNVJqbHRNTjZFMndDd3hYR1d1M1FSa0c1L0FZall3aGlHZTZuWkQx?=
 =?utf-8?B?ZTFGaVBQdjU3SDhMK28xYkh3dHJ4SjUwaVZRRGo5Q0toMlMxUERWTFZ6THE1?=
 =?utf-8?B?Z05XNktHWUJCWW1vTUdaYzhsOUJkdE1LRk5VeW8xUVpOdzlqUUxFb01QaVNp?=
 =?utf-8?B?eHJ5eWJZM2JaTFQ5OThteXZRL2U5cENmejJjWmUrSEtTeElTeWdndnFRNzJk?=
 =?utf-8?B?SVc4M0doTFhEV21TTnIzaDljdGtJcVVyMll3czJYV2JaTUYyQzdaNkY4WjhI?=
 =?utf-8?B?WVpVOFJvRTllajlxMkdZSnZZbi9vMmI1cDdpQzVuL2RWTDJVYWQ4NU9vTUJi?=
 =?utf-8?B?OE9VVGwyTnNQY3ZmUVVxU1NZT0JUUkg0SEovN0VDY3l5Ty9tNUNteG1vemhh?=
 =?utf-8?B?TWxURGFsbDBMWVhjaVFMaW5FU2swS0RNaEJXWXBTUGtmZnNHeDFuTlVSTHpE?=
 =?utf-8?B?L2ZhU3NUSERJNmR4SGdGZFhxYXR2TGE1d1ZiUk0vVk1vZHF6SWhVbVQzVDlk?=
 =?utf-8?B?QlBwdXBhVVRueXFDMldnWGh5WkVucGhUMXFMa1JubTgveDliS3QvV2dTWXFZ?=
 =?utf-8?B?RnNoaUlmSnJKTFMzQnBWM1dSS1JZUlBnNlNFZExMbzlvdVM5YUdtSGpFOE1o?=
 =?utf-8?B?bUdyaDJYVmxIZ3RhSzcyWlRHMHVGRkVHRStyUTgwem1MRTBwQnp3OElWZm0x?=
 =?utf-8?B?akhLV2J1MTFJcWNHL2JxYVdScFpCWmhleFU0c3ZNamxVMGp3S0hOMTIvNlNN?=
 =?utf-8?B?bGl6dzlLazRDMGp5SXdiUmxlem5qK3ZQQXV3alA0V2tkY1Y1SkRJZzVtUnY5?=
 =?utf-8?B?QldHNld2Q0M3UkFna2oxeFN5aFdmSW5IcmNWUngvR0F3RFBmaUM5bFoxais3?=
 =?utf-8?B?REhhSUovOHZZd0tPdEZGaXpNc1VkYzhHNWRmdHQ3dzFKU2ZkSnFBK1c5WFQx?=
 =?utf-8?B?Zm56L0xWeEhodVF4WVZsTlpONFFpZkVpZTNvZ1ZKakpGalZrRlFIK2dZTXRO?=
 =?utf-8?Q?0dWW3Hw+k+fp4v70=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726b5378-bd9d-461b-129e-08de67c199d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 09:57:14.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXnOkbRybWMVwqme6qYaI+5DI7N1bpebi0OENFu+ycqXvrSV9MJ25Uby3qVDnIJGGbYwSJlWM7O/Gas6IB0+JrjR9q9ogbhqKU7z83wOhfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8968
X-Proofpoint-ORIG-GUID: MNl2H3SggVKDXyRmjDgS0Et8_iY8FFL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA4MiBTYWx0ZWRfX7aQK81y3WKor
 AdXmpMeC7/ZmkAfsTRshOYzHuNCUNuRYObuELOZaqWXljZW8HuHyzWKvQA63zS92tn+5diUVUh1
 4P1lmOG7/yfJ9DcMGSlHpOuoMXzU0F/jeag6bkmdILPodgxL/VCTB69tEhmAoj5XWeSX646Lpqf
 HRbG0iqgC3JNon/WVipVp992N9F2BkBBpoPzxv/rkKsPPKdyBOpSWzXmz3zLnk4PFIua0w95g2a
 mWiLPOis104TEx16aAUUph7WL0WdoqpBVCUvH1pRK9PvvMbuKVLm72xwGmirXjxzzUM6OiYwUG9
 ZYOKirRCHCFZw56sopNg7cDT32AAa9NEv94Hupf5bWXDDi/4ydxeBWsw5o2vypvudZSXqKAnzTZ
 tB1Y0iW7Xv8tMbR3/Ct5orqVIvb+dQCy1e0A65TI6KTK2Z//75wsCwm9ZEEDLhLECKO0w99sYqU
 KQxlplRaohrRQjr/wlA==
X-Proofpoint-GUID: MNl2H3SggVKDXyRmjDgS0Et8_iY8FFL8
X-Authority-Analysis: v=2.4 cv=O5k0fR9W c=1 sm=1 tr=0 ts=6989af7c cx=c_pps
 a=/L+qah5tOETEvltlblSARw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=1XWaLZrsAAAA:8 a=V2NxCb60AAAA:8 a=bnfNz4R3W9a77zOm4QoA:9 a=QEXdDO2ut3YA:10
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 09/02/2026 09:16, Jamin Lin wrote:

> The Aspeed I3C IP block is technically an Aspeed IP block that manages
> 6 DW I3C controllers.
> 
> To help reflect this better and to make it easier for other SoCs to use
> the DW I3C model, we'll split out the DW portion from the Aspeed
> portion.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/i3c/aspeed_i3c.h |  19 +---
>   include/hw/i3c/dw-i3c.h     |  35 +++++++
>   hw/i3c/aspeed_i3c.c         | 183 +-------------------------------
>   hw/i3c/dw-i3c.c             | 204 ++++++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig              |   1 +
>   hw/i3c/Kconfig              |   3 +
>   hw/i3c/meson.build          |   1 +
>   hw/i3c/trace-events         |   6 +-
>   8 files changed, 254 insertions(+), 198 deletions(-)
>   create mode 100644 include/hw/i3c/dw-i3c.h
>   create mode 100644 hw/i3c/dw-i3c.c
> 
> diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
> index 7a984e1f01..f8e13b6fab 100644
> --- a/include/hw/i3c/aspeed_i3c.h
> +++ b/include/hw/i3c/aspeed_i3c.h
> @@ -10,29 +10,15 @@
>   #ifndef ASPEED_I3C_H
>   #define ASPEED_I3C_H
>   
> +#include "hw/i3c/dw-i3c.h"
>   #include "hw/core/sysbus.h"
>   
>   #define TYPE_ASPEED_I3C "aspeed.i3c"
> -#define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"
>   OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)
>   
>   #define ASPEED_I3C_NR_REGS (0x70 >> 2)
> -#define ASPEED_I3C_DEVICE_NR_REGS (0x300 >> 2)
>   #define ASPEED_I3C_NR_DEVICES 6
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)
> -typedef struct AspeedI3CDevice {
> -    /* <private> */
> -    SysBusDevice parent;
> -
> -    /* <public> */
> -    MemoryRegion mr;
> -    qemu_irq irq;
> -
> -    uint8_t id;
> -    uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];
> -} AspeedI3CDevice;
> -
>   typedef struct AspeedI3CState {
>       /* <private> */
>       SysBusDevice parent;
> @@ -43,6 +29,7 @@ typedef struct AspeedI3CState {
>       qemu_irq irq;
>   
>       uint32_t regs[ASPEED_I3C_NR_REGS];
> -    AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];
> +    DWI3C devices[ASPEED_I3C_NR_DEVICES];
> +    uint8_t id;
>   } AspeedI3CState;
>   #endif /* ASPEED_I3C_H */
> diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
> new file mode 100644
> index 0000000000..4550ea45fe
> --- /dev/null
> +++ b/include/hw/i3c/dw-i3c.h
> @@ -0,0 +1,35 @@
> +/*
> + * DesignWare I3C Controller
> + *
> + * Copyright (C) 2021 ASPEED Technology Inc.
> + * Copyright (C) 2025 Google, LLC.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef DW_I3C_H
> +#define DW_I3C_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_DW_I3C "dw.i3c"
> +OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)
> +
> +#define DW_I3C_NR_REGS (0x300 >> 2)
> +
> +typedef struct DWI3C {

The typedef can be dropped because it is generated as part of 
OBJECT_DECLARE_SIMPLE_TYPE().

> +    /* <private> */

You can drop the private comment marker as it isn't relevant anymore.

> +    SysBusDevice parent;

This should be parent_obj as per the style guidelines.

> +
> +    /* <public> */

Same for the public comment marker.

> +    MemoryRegion mr;
> +    qemu_irq irq;
> +
> +    uint8_t id;
> +    uint32_t regs[DW_I3C_NR_REGS];
> +} DWI3C;
> +
> +/* Extern for other controllers that use DesignWare I3C. */
> +extern const VMStateDescription vmstate_dw_i3c;
> +
> +#endif /* DW_I3C_H */
> diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
> index fff259ff66..b0844d4da2 100644
> --- a/hw/i3c/aspeed_i3c.c
> +++ b/hw/i3c/aspeed_i3c.c
> @@ -2,6 +2,7 @@
>    * ASPEED I3C Controller
>    *
>    * Copyright (C) 2021 ASPEED Technology Inc.
> + * Copyright (C) 2025 Google, LLC.
>    *
>    * This code is licensed under the GPL version 2 or later.  See
>    * the COPYING file in the top-level directory.
> @@ -43,162 +44,6 @@ REG32(I3C6_REG1, 0x64)
>       FIELD(I3C6_REG1, I2C_MODE,  0,  1)
>       FIELD(I3C6_REG1, SA_EN,     15, 1)
>   
> -/* I3C Device Registers */
> -REG32(DEVICE_CTRL,                  0x00)
> -REG32(DEVICE_ADDR,                  0x04)
> -REG32(HW_CAPABILITY,                0x08)
> -REG32(COMMAND_QUEUE_PORT,           0x0c)
> -REG32(RESPONSE_QUEUE_PORT,          0x10)
> -REG32(RX_TX_DATA_PORT,              0x14)
> -REG32(IBI_QUEUE_STATUS,             0x18)
> -REG32(IBI_QUEUE_DATA,               0x18)
> -REG32(QUEUE_THLD_CTRL,              0x1c)
> -REG32(DATA_BUFFER_THLD_CTRL,        0x20)
> -REG32(IBI_QUEUE_CTRL,               0x24)
> -REG32(IBI_MR_REQ_REJECT,            0x2c)
> -REG32(IBI_SIR_REQ_REJECT,           0x30)
> -REG32(RESET_CTRL,                   0x34)
> -REG32(SLV_EVENT_CTRL,               0x38)
> -REG32(INTR_STATUS,                  0x3c)
> -REG32(INTR_STATUS_EN,               0x40)
> -REG32(INTR_SIGNAL_EN,               0x44)
> -REG32(INTR_FORCE,                   0x48)
> -REG32(QUEUE_STATUS_LEVEL,           0x4c)
> -REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
> -REG32(PRESENT_STATE,                0x54)
> -REG32(CCC_DEVICE_STATUS,            0x58)
> -REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
> -    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
> -    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
> -REG32(DEV_CHAR_TABLE_POINTER,       0x60)
> -REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
> -REG32(SLV_MIPI_PID_VALUE,           0x70)
> -REG32(SLV_PID_VALUE,                0x74)
> -REG32(SLV_CHAR_CTRL,                0x78)
> -REG32(SLV_MAX_LEN,                  0x7c)
> -REG32(MAX_READ_TURNAROUND,          0x80)
> -REG32(MAX_DATA_SPEED,               0x84)
> -REG32(SLV_DEBUG_STATUS,             0x88)
> -REG32(SLV_INTR_REQ,                 0x8c)
> -REG32(DEVICE_CTRL_EXTENDED,         0xb0)
> -REG32(SCL_I3C_OD_TIMING,            0xb4)
> -REG32(SCL_I3C_PP_TIMING,            0xb8)
> -REG32(SCL_I2C_FM_TIMING,            0xbc)
> -REG32(SCL_I2C_FMP_TIMING,           0xc0)
> -REG32(SCL_EXT_LCNT_TIMING,          0xc8)
> -REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
> -REG32(BUS_FREE_TIMING,              0xd4)
> -REG32(BUS_IDLE_TIMING,              0xd8)
> -REG32(I3C_VER_ID,                   0xe0)
> -REG32(I3C_VER_TYPE,                 0xe4)
> -REG32(EXTENDED_CAPABILITY,          0xe8)
> -REG32(SLAVE_CONFIG,                 0xec)
> -
> -static const uint32_t ast2600_i3c_device_resets[ASPEED_I3C_DEVICE_NR_REGS] = {
> -    [R_HW_CAPABILITY]               = 0x000e00bf,
> -    [R_QUEUE_THLD_CTRL]             = 0x01000101,
> -    [R_I3C_VER_ID]                  = 0x3130302a,
> -    [R_I3C_VER_TYPE]                = 0x6c633033,
> -    [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
> -    [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
> -    [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
> -    [R_SLV_MAX_LEN]                 = 0x00ff00ff,
> -};
> -
> -static uint64_t aspeed_i3c_device_read(void *opaque, hwaddr offset,
> -                                       unsigned size)
> -{
> -    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(opaque);
> -    uint32_t addr = offset >> 2;
> -    uint64_t value;
> -
> -    switch (addr) {
> -    case R_COMMAND_QUEUE_PORT:
> -        value = 0;
> -        break;
> -    default:
> -        value = s->regs[addr];
> -        break;
> -    }
> -
> -    trace_aspeed_i3c_device_read(s->id, offset, value);
> -
> -    return value;
> -}
> -
> -static void aspeed_i3c_device_write(void *opaque, hwaddr offset,
> -                                    uint64_t value, unsigned size)
> -{
> -    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(opaque);
> -    uint32_t addr = offset >> 2;
> -
> -    trace_aspeed_i3c_device_write(s->id, offset, value);
> -
> -    switch (addr) {
> -    case R_HW_CAPABILITY:
> -    case R_RESPONSE_QUEUE_PORT:
> -    case R_IBI_QUEUE_DATA:
> -    case R_QUEUE_STATUS_LEVEL:
> -    case R_PRESENT_STATE:
> -    case R_CCC_DEVICE_STATUS:
> -    case R_DEVICE_ADDR_TABLE_POINTER:
> -    case R_VENDOR_SPECIFIC_REG_POINTER:
> -    case R_SLV_CHAR_CTRL:
> -    case R_SLV_MAX_LEN:
> -    case R_MAX_READ_TURNAROUND:
> -    case R_I3C_VER_ID:
> -    case R_I3C_VER_TYPE:
> -    case R_EXTENDED_CAPABILITY:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: write to readonly register[0x%02" HWADDR_PRIx
> -                      "] = 0x%08" PRIx64 "\n",
> -                      __func__, offset, value);
> -        break;
> -    case R_RX_TX_DATA_PORT:
> -        break;
> -    case R_RESET_CTRL:
> -        break;
> -    default:
> -        s->regs[addr] = value;
> -        break;
> -    }
> -}
> -
> -static const VMStateDescription aspeed_i3c_device_vmstate = {
> -    .name = TYPE_ASPEED_I3C,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .fields = (const VMStateField[]){
> -        VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_REGS),
> -        VMSTATE_END_OF_LIST(),
> -    }
> -};
> -
> -static const MemoryRegionOps aspeed_i3c_device_ops = {
> -    .read = aspeed_i3c_device_read,
> -    .write = aspeed_i3c_device_write,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> -};
> -
> -static void aspeed_i3c_device_reset(DeviceState *dev)
> -{
> -    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(dev);
> -
> -    memcpy(s->regs, ast2600_i3c_device_resets, sizeof(s->regs));
> -}
> -
> -static void aspeed_i3c_device_realize(DeviceState *dev, Error **errp)
> -{
> -    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(dev);
> -    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I3C_DEVICE ".%d",
> -                                            s->id);
> -
> -    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> -
> -    memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i3c_device_ops,
> -                          s, name, ASPEED_I3C_DEVICE_NR_REGS << 2);
> -}
> -
>   static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int size)
>   {
>       AspeedI3CState *s = ASPEED_I3C(opaque);
> @@ -275,7 +120,7 @@ static void aspeed_i3c_instance_init(Object *obj)
>   
>       for (i = 0; i < ASPEED_I3C_NR_DEVICES; ++i) {
>           object_initialize_child(obj, "device[*]", &s->devices[i],
> -                TYPE_ASPEED_I3C_DEVICE);
> +                TYPE_DW_I3C);
>       }
>   }
>   
> @@ -323,27 +168,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
>   
>   }
>   
> -static const Property aspeed_i3c_device_properties[] = {
> -    DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),
> -};
> -
> -static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -
> -    dc->desc = "Aspeed I3C Device";
> -    dc->realize = aspeed_i3c_device_realize;
> -    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);
> -    device_class_set_props(dc, aspeed_i3c_device_properties);
> -}
> -
> -static const TypeInfo aspeed_i3c_device_info = {
> -    .name = TYPE_ASPEED_I3C_DEVICE,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(AspeedI3CDevice),
> -    .class_init = aspeed_i3c_device_class_init,
> -};
> -
>   static const VMStateDescription vmstate_aspeed_i3c = {
>       .name = TYPE_ASPEED_I3C,
>       .version_id = 1,
> @@ -351,7 +175,7 @@ static const VMStateDescription vmstate_aspeed_i3c = {
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),
>           VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICES, 1,
> -                             aspeed_i3c_device_vmstate, AspeedI3CDevice),
> +                             vmstate_dw_i3c, DWI3C),
>           VMSTATE_END_OF_LIST(),
>       }
>   };
> @@ -376,7 +200,6 @@ static const TypeInfo aspeed_i3c_info = {
>   
>   static void aspeed_i3c_register_types(void)
>   {
> -    type_register_static(&aspeed_i3c_device_info);
>       type_register_static(&aspeed_i3c_info);
>   }
>   
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> new file mode 100644
> index 0000000000..c949579ea1
> --- /dev/null
> +++ b/hw/i3c/dw-i3c.c
> @@ -0,0 +1,204 @@
> +/*
> + * DesignWare I3C Controller
> + *
> + * Copyright (C) 2021 ASPEED Technology Inc.
> + * Copyright (C) 2025 Google, LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/i3c/i3c.h"
> +#include "hw/i3c/dw-i3c.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +
> +REG32(DEVICE_CTRL,                  0x00)
> +REG32(DEVICE_ADDR,                  0x04)
> +REG32(HW_CAPABILITY,                0x08)
> +REG32(COMMAND_QUEUE_PORT,           0x0c)
> +REG32(RESPONSE_QUEUE_PORT,          0x10)
> +REG32(RX_TX_DATA_PORT,              0x14)
> +REG32(IBI_QUEUE_STATUS,             0x18)
> +REG32(IBI_QUEUE_DATA,               0x18)
> +REG32(QUEUE_THLD_CTRL,              0x1c)
> +REG32(DATA_BUFFER_THLD_CTRL,        0x20)
> +REG32(IBI_QUEUE_CTRL,               0x24)
> +REG32(IBI_MR_REQ_REJECT,            0x2c)
> +REG32(IBI_SIR_REQ_REJECT,           0x30)
> +REG32(RESET_CTRL,                   0x34)
> +REG32(SLV_EVENT_CTRL,               0x38)
> +REG32(INTR_STATUS,                  0x3c)
> +REG32(INTR_STATUS_EN,               0x40)
> +REG32(INTR_SIGNAL_EN,               0x44)
> +REG32(INTR_FORCE,                   0x48)
> +REG32(QUEUE_STATUS_LEVEL,           0x4c)
> +REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
> +REG32(PRESENT_STATE,                0x54)
> +REG32(CCC_DEVICE_STATUS,            0x58)
> +REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
> +    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
> +    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
> +REG32(DEV_CHAR_TABLE_POINTER,       0x60)
> +REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
> +REG32(SLV_MIPI_PID_VALUE,           0x70)
> +REG32(SLV_PID_VALUE,                0x74)
> +REG32(SLV_CHAR_CTRL,                0x78)
> +REG32(SLV_MAX_LEN,                  0x7c)
> +REG32(MAX_READ_TURNAROUND,          0x80)
> +REG32(MAX_DATA_SPEED,               0x84)
> +REG32(SLV_DEBUG_STATUS,             0x88)
> +REG32(SLV_INTR_REQ,                 0x8c)
> +REG32(DEVICE_CTRL_EXTENDED,         0xb0)
> +REG32(SCL_I3C_OD_TIMING,            0xb4)
> +REG32(SCL_I3C_PP_TIMING,            0xb8)
> +REG32(SCL_I2C_FM_TIMING,            0xbc)
> +REG32(SCL_I2C_FMP_TIMING,           0xc0)
> +REG32(SCL_EXT_LCNT_TIMING,          0xc8)
> +REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
> +REG32(BUS_FREE_TIMING,              0xd4)
> +REG32(BUS_IDLE_TIMING,              0xd8)
> +REG32(I3C_VER_ID,                   0xe0)
> +REG32(I3C_VER_TYPE,                 0xe4)
> +REG32(EXTENDED_CAPABILITY,          0xe8)
> +REG32(SLAVE_CONFIG,                 0xec)
> +
> +static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
> +    [R_HW_CAPABILITY]               = 0x000e00bf,
> +    [R_QUEUE_THLD_CTRL]             = 0x01000101,
> +    [R_I3C_VER_ID]                  = 0x3130302a,
> +    [R_I3C_VER_TYPE]                = 0x6c633033,
> +    [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
> +    [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
> +    [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
> +    [R_SLV_MAX_LEN]                 = 0x00ff00ff,
> +};
> +
> +static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    DWI3C *s = DW_I3C(opaque);
> +    uint32_t addr = offset >> 2;
> +    uint64_t value;
> +
> +    switch (addr) {
> +    case R_COMMAND_QUEUE_PORT:
> +        value = 0;
> +        break;
> +    default:
> +        value = s->regs[addr];
> +        break;
> +    }
> +
> +    trace_dw_i3c_read(s->id, offset, value);
> +
> +    return value;
> +}
> +
> +static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
> +                         unsigned size)
> +{
> +    DWI3C *s = DW_I3C(opaque);
> +    uint32_t addr = offset >> 2;
> +
> +    trace_dw_i3c_write(s->id, offset, value);
> +
> +    switch (addr) {
> +    case R_HW_CAPABILITY:
> +    case R_RESPONSE_QUEUE_PORT:
> +    case R_IBI_QUEUE_DATA:
> +    case R_QUEUE_STATUS_LEVEL:
> +    case R_PRESENT_STATE:
> +    case R_CCC_DEVICE_STATUS:
> +    case R_DEVICE_ADDR_TABLE_POINTER:
> +    case R_VENDOR_SPECIFIC_REG_POINTER:
> +    case R_SLV_CHAR_CTRL:
> +    case R_SLV_MAX_LEN:
> +    case R_MAX_READ_TURNAROUND:
> +    case R_I3C_VER_ID:
> +    case R_I3C_VER_TYPE:
> +    case R_EXTENDED_CAPABILITY:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write to readonly register[0x%02" HWADDR_PRIx
> +                      "] = 0x%08" PRIx64 "\n",
> +                      __func__, offset, value);
> +        break;
> +    case R_RX_TX_DATA_PORT:
> +        break;
> +    case R_RESET_CTRL:
> +        break;
> +    default:
> +        s->regs[addr] = value;
> +        break;
> +    }
> +}
> +
> +const VMStateDescription vmstate_dw_i3c = {
> +    .name = TYPE_DW_I3C,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]){
> +        VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static const MemoryRegionOps dw_i3c_ops = {
> +    .read = dw_i3c_read,
> +    .write = dw_i3c_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void dw_i3c_reset_enter(Object *obj, ResetType type)
> +{
> +    DWI3C *s = DW_I3C(obj);
> +
> +    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));
> +}
> +
> +static void dw_i3c_realize(DeviceState *dev, Error **errp)
> +{
> +    DWI3C *s = DW_I3C(dev);
> +    g_autofree char *name = g_strdup_printf(TYPE_DW_I3C ".%d", s->id);
> +
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +
> +    memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,
> +                          DW_I3C_NR_REGS << 2);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
> +}
> +
> +static const Property dw_i3c_properties[] = {
> +    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),
> +};
> +
> +static void dw_i3c_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.enter = dw_i3c_reset_enter;
> +
> +    dc->desc = "DesignWare I3C Controller";
> +    dc->realize = dw_i3c_realize;
> +    dc->vmsd = &vmstate_dw_i3c;
> +    device_class_set_props(dc, dw_i3c_properties);
> +}
> +
> +static const TypeInfo dw_i3c_info = {
> +    .name = TYPE_DW_I3C,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(DWI3C),
> +    .class_init = dw_i3c_class_init,
> +};
> +
> +static void dw_i3c_register_types(void)
> +{
> +    type_register_static(&dw_i3c_info);
> +}

Again you probably want to use DECLARE_TYPES() here.

> +type_init(dw_i3c_register_types);
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 8344b9769f..d545ecd712 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -546,6 +546,7 @@ config ASPEED_SOC
>       select FTGMAC100
>       select I2C
>       select I3C
> +    select DW_I3C
>       select DPS310
>       select PCA9552
>       select PCA9554
> diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
> index e07fe445c6..ecec77d6fc 100644
> --- a/hw/i3c/Kconfig
> +++ b/hw/i3c/Kconfig
> @@ -1,2 +1,5 @@
>   config I3C
>       bool
> +
> +config DW_I3C
> +    bool
> diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
> index fb127613fe..83d75e7d5c 100644
> --- a/hw/i3c/meson.build
> +++ b/hw/i3c/meson.build
> @@ -1,4 +1,5 @@
>   i3c_ss = ss.source_set()
>   i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
>   i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
> +i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))
>   system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
> diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
> index cdf7cb07f6..2d944387db 100644
> --- a/hw/i3c/trace-events
> +++ b/hw/i3c/trace-events
> @@ -3,8 +3,10 @@
>   # aspeed_i3c.c
>   aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
>   aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
> -aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
> -aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
> +
> +# dw-i3c,c
> +dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
> +dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
>   
>   # core.c
>   i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " event 0x%" PRIx8



ATB,

Mark.


