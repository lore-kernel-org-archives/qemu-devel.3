Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AACC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDPp-00076f-I1; Wed, 30 Jul 2025 16:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhC5E-0005Pf-Gi; Wed, 30 Jul 2025 15:03:30 -0400
Received: from mail-mw2nam12on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61c]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhC5A-0005hb-26; Wed, 30 Jul 2025 15:03:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCYUoNZbbyKwEiwkj0lZqi/jHFsffg77VseqrPV/SbTx+7I467Ahqo2uHugUiuv+pC6B9bFttw2p9VSNvbJsbU205tGsjFLGfcgIe1d2hc9pT1m82LFHZpfj3/1AsD/x7bTwYYvso99Dy77POPCCvGArYshxvS0ABrZ4MzLe+lKAQe6y8RnP9q1PbVO8A8ew/oJW8iU8qQruyFWTZUZ/VjguPTO9TbIgr36NylNp+JOjPDSYV8gcYn5C+I2P2RVfFP1uDMlIZ1F118x2KcvDCBOyooxofAojFs/yLacFpVlVOZBeFRten9c+yvE44WTWjpLc2PZ/LBfp5k6CdSj0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpeIVKxFowmKazOHf/GXHnNScZlWhY5GKxE8aK/5fXo=;
 b=rB6wuU3DV7Tvf0DSuYRB8b1xdAoaEvUQOIAU95h4Kf6pwODAgXOznEhzArlwsQi7z3hN7iQcuahZq7LQGnzQ+XURO61RGoOlonx3uuunRWf9ZDxA8zdA/zs7MTmwB17WAkU2RhtWTSQUq6/ZI45x5Cp1nftXrFGNUUzi1umJ8+jgeCV0o2P10mexEl/1fHbiwNkjRHMqwj6cvez5jsCR1SHDx+iqNFweCy82ZYK+iFrmLEbt2Om2SJaIZddW7v+7USgXUt0EAG1gSWBesHgoP9enUlJKr3Bq3R484IceZVJXOCAnhZ8WbeTVT8k2oTfihL21BauiWhRnyFEHquWNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpeIVKxFowmKazOHf/GXHnNScZlWhY5GKxE8aK/5fXo=;
 b=JMesVfTBZQ3WiQufJT2Fh8jieD2cWe562IKuABKcgmZ6VKtKvF250K1cKhwj3KY3uxRnhfveJimjlBvCuHkrgOZxYRsBNJFTiPc54oamTcr3KpAfhm2YYwm5tFFafYe9a8njk8HoT+v1GvRC498y8AhnJPUpZ99tEVd6czk6GZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 19:03:14 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:03:12 +0000
Date: Wed, 30 Jul 2025 21:03:05 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 27/48] hw/arm/xlnx-versal: rpu: refactor creation
Message-ID: <aIpsafCkNi5Yumbv@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-28-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-28-luc.michel@amd.com>
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 773c46ce-f4cf-46a0-9693-08ddcf9bbb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDVEWFFVMGJHZVV2bmxWRTVjTFRKbVlZa3BGNTBUSkx3S2szd1ZZdldXbVVa?=
 =?utf-8?B?RWl2NG5WRllGM0RHY2ZhRmZ1Ny94RENHNDE3a3U5UWhEYmJZNURldy9oQjRC?=
 =?utf-8?B?akx2YjFhUWtFb29WTGNIRm45ZkxOSXJPU3Z2N3BJZ0d3RDZhKzRJcG5CZHNx?=
 =?utf-8?B?bmt5emFDeWxlajhVMFZzSExsdjc3NE1xeXhKNEhtYjFNVTByNFlITzFxUlRS?=
 =?utf-8?B?aWJxY1dZWk5sRVhHZEpmS1dvM3Y2ajIvclhIVXptZ3NGa0ZMZ2Y3bU9UeHpW?=
 =?utf-8?B?T0R0cDBSNlA3eG1tMnFSOFJGbEtJQjcxNEMvRWN1RS9USjZ0VXNuK0VYRE0x?=
 =?utf-8?B?eW5xaTdTMm5QcWVua2JhcGJlVTBTS2c4bU0vcUpSdDJsQnJQSlRoQ0NMdncw?=
 =?utf-8?B?c2dyZCt4My8xeW9GaTNQbzZBOFZtSzBZMTJ3SGdaL04rUHFZalo2QjNNaTZU?=
 =?utf-8?B?dXZlUjRQOHY1S3NBNzZnTW5GVmcrM0VINnAwNDdsR0tFRE9vKzdMTVZxK2NR?=
 =?utf-8?B?L0dHaGt2N2o2clhNV1hIVkxUdFUrVlM2eUlpaVlubmd6VlVWV3JjWTlVMnU0?=
 =?utf-8?B?eTZycTg4WS9iaDN5NnVlMDJHZlViLzFRSldSRk1zTzduUTdpblVsQThkRUJJ?=
 =?utf-8?B?V2liLzJhR2JRS3FlSnRnTWZrOFdSRFJ5WGh0MC9jNzJlQWtsV2ZHZXdzbkdR?=
 =?utf-8?B?TmV2TnFOTEppK2g1R1J3ekQwZm9JSE1xWjl1c2lHKy9MeGlHZEpHRjBQblZB?=
 =?utf-8?B?cEN4Nk1WNEhNRVpsV1RteGhNYnlrd0JaQVBNRm1sdkhsRERFWGlyOFJuRXNM?=
 =?utf-8?B?Q3JUOUVITmRYaE1EY2NZeUZsdVlLRTluR1RXYVdlaEYyTWx2ekU5eW8zam90?=
 =?utf-8?B?K3NwT1oxUStWNFhUTzZvUEFKRm1YalVWeFNBZmo5R2pZbWl0bExZNWRTUFFo?=
 =?utf-8?B?Z1Z1dHBvVmd3U25UUVhnZy9FTTk0MThVWVJ3d2E0bVVRSFgzZC8waHZ4OVg3?=
 =?utf-8?B?WkJRNUJBOUF0VWxGRlFxSjdnT0ZwWUJWb1RVQitSTTViS3NBRUF5Y3JTMkJo?=
 =?utf-8?B?TmxLc21yUTVwOEhZK2NXNFhrMVpXWGQ0OGdhRy81VUlhRnlkOEhmMEJzQXRH?=
 =?utf-8?B?bnVqSlB4SGhpcTcrL0I1WFRtdlk3R1B2cTkzeWc0TE85Nk1HNjZBeHVqMVAv?=
 =?utf-8?B?YXNrQ244M05JRm1pZ21HTmRnV1RFaTRQSW5oNXlkTVpBUXhSblBmQVUzdjBt?=
 =?utf-8?B?Q3YrRnVaMHlmbmZaTFp2UFJWTEJhdnRjU25XR1BzbzFEcm1uWDgwNno0NTVP?=
 =?utf-8?B?RXptTjBwSUNUZDNwdkJZOTNGSDNxMzZVVkhzUFdPN3FOdjhGT3BxM2V0a1ha?=
 =?utf-8?B?MEVuSjZTZmdWSzJEZFN5KzkwU1lhK1JTSFZ5ZnpUcHVWa21sS1hHK2JVT1RY?=
 =?utf-8?B?V2gvQTM4LzZneHdjU0haM2RWM3JPZndnL0VwM0ljcDI1SHdIZnoyUkRlWEhn?=
 =?utf-8?B?SC8zRTNhclVweU91YXB5UFFQL1NBSXVIdWtzVkxnbE9jWURrYzJqVTQ4SGpk?=
 =?utf-8?B?eit3Q0lQMC94bFVnMXJiN2daQXI1Yno3aUxRcUpkZWw0M0R3TU5vK3YxUkRB?=
 =?utf-8?B?Qi9leHEybHZaM2x4TnZ2SkkyK3NpVjJncTRSdjkwTHEwNDgrTHladDBnVWEz?=
 =?utf-8?B?eWUwYTJQRjJoSkJRYm02bER0anRCRk5XOFFEU2lKK3lNSVpZOHltcnMvanJu?=
 =?utf-8?B?akVxWjdMUitqOHFtYjU4SVNYczVQMjRYOWwzaEFiVzl6dk80bEVYZ2xFQldM?=
 =?utf-8?B?dy9SeUhUTlQ4U0E2YjBkQTBRbkxQNEtEVDdYY2NZN2xKRlVrRm1hUVV0V0tR?=
 =?utf-8?B?QjBxaUR1WFhlNEhHQ3N6SWJmUFZtdVVJZ2IxZHA2aWYrNXI3eHpFSlR5d25S?=
 =?utf-8?Q?XEX+4uuzwsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clQ4NmdNZk5YVlBVZEQrL01iUWozM3M5Szh6bVNXVExDc1pLVE5tZUJVZWRM?=
 =?utf-8?B?UjhmaGxXRkhWbWFoRWVmUWtUVzdqTStGUnV1dnNXaXFhdVZ0Y085WEw3ZWM2?=
 =?utf-8?B?NUdENWFOaHhBSkJUeVZKTWM0d0IrRURWakIxUGFmUHhpM0F0cjEyMXRCTnRT?=
 =?utf-8?B?WUtTRi9LZ0tHNXhMVEVsb0VRTmxFa1lDa2JCRnVINXYxOVVTRFl5Z3lia090?=
 =?utf-8?B?N1hWVnlCc3A1cUE1OEZKOHRIZWF5TlpaNjFrcHRMakxUMkQ2WE9rVzZ3dEln?=
 =?utf-8?B?c0pLcEFFMXNaV1JueEwyMUtNQXErZk5pMVo1SHBpRjRRWTVzZ3kydHJQbDFW?=
 =?utf-8?B?ajVKNi9IS1ZqZXNjTFVBelYvbHVXcE5Gb05wQmx2MzJ2TUFwd0tndEFGQU1O?=
 =?utf-8?B?dG9CaTdLUWQvclh1T1JWeUxkSExGZmg4dUdJajlWOWhUK2hMRE5yNDJwT2Vl?=
 =?utf-8?B?T28zSHhWWVJ5M3p2eEVQL2lYUkZXeURJRGtycVgwVkVCeGUvRW90RWNhV3g3?=
 =?utf-8?B?LzJXcEo2QWJERk5vSytUQTFVVkwrYkVkNzdpVWNIZldnY0lWbWs1Wno1TmRm?=
 =?utf-8?B?b2VmcDZZSTI0ODczWmZjZkRDMmtQL3phdW1XTlVHMU12OXpmMHBoNkNhQjVx?=
 =?utf-8?B?K05peGFQOHdsR3N4UjY4ek10MWp0UlZrRDVRWWU4dERDWm1FdEIrUjU1eXd0?=
 =?utf-8?B?Mys3RHdhTFNJQTlQWFFyR05jSlBrWHJvRHFiam04NEVQZ1dDM3lWUUROYXNE?=
 =?utf-8?B?SEVKNEJPZ3lNK2R4enN4eE1BUVhIcElQUldmQ3hJT1lkVzhJZmNaNXpaaHpC?=
 =?utf-8?B?amRFNWxZKzFQdnZ0dld2WkRBS2xiUWZPOHNzbGZNbWgwZGVpWVl3dnJtOGo2?=
 =?utf-8?B?L1hPVE90ZGxCWEtEMHJKMGVBb1NpeXRYTDBhNGdKUG1PSjUyZWNKNDdXblBy?=
 =?utf-8?B?WTRPMjNDRUMvMGVsWlJwamlIbEowcDVxYjNXeS93VmFQNTVzbUVtcUNJZGNl?=
 =?utf-8?B?U1ZwbmJUYWhScjNObVNweUpOY3NlMGs3WFY4Q1BseUtyUGxHeERha3UvS1B4?=
 =?utf-8?B?TkZMUjkwL1R5UEc1NURaVi8zWWRhbHBSQmZubURDV2I1dVJRcE1Fd2hiY0Fn?=
 =?utf-8?B?NW1oR1NDdnBVa1QzckwyVk90cjV4ODNHYllBOFhJZm1VT2g4TGlNQlpEelVo?=
 =?utf-8?B?OGg4ZVRKd3pYbDlhZnZSZzVCRFQzWEJXTnVwb3hCZzFhWjcyWWpsUGNyWEZF?=
 =?utf-8?B?RHlCZ0wxWkJTTmRKNSttQlhNNExFTW1JeXdidC8wOTdYdnFRUVBoUERQUjlj?=
 =?utf-8?B?NFhpU3cvOGJER3FSOWlRMDNrTmx3UDZGQWtFaGcrQytYQUszVExOdHVHKzY1?=
 =?utf-8?B?VGx4eXQzYlVGb1dORkpwQ1RKV2pNNS9pc00zTTZTT2VqVGM2VFdxK0wwbFJ0?=
 =?utf-8?B?b0Y1VFVaNjZQemVRYzVBQnFHdmQrbE1BYlVDYUtJUmNGUlpCaXhtQ2Jzekln?=
 =?utf-8?B?RU12aGxXMm5Sa0ZybTVrQ3hVUFZ0K05KNjBRamx3UmNNMFhCYnQzODYwa2Fl?=
 =?utf-8?B?ZGZhNVBsT2xUbFEzbUpKcUZibEJMM1gzQkUwbUloUkM2emlCMjJWWlFXMmxS?=
 =?utf-8?B?Sy9RYlFQakloWHkvNW81V0djNFc4YmFhZHBCSVdUNlB5bFNBWndVL0xUK25K?=
 =?utf-8?B?MWMwclY2RTRlNnlvOXR6RkhubmtxWFpheXZwaVlMNzRNTHRpOEZMWWwzZ2Yy?=
 =?utf-8?B?T3ZaSEdmQjZ6TURpdjZ1eUNBbkxPK3NUYjV1aCtrU2J3d0l1QS9BekllaHFR?=
 =?utf-8?B?MjFYR0hVenJ0RmJ6eEZzb25qMXR4N0thV1RjbVpwcmw4UVIwVzhTNHFXNUgx?=
 =?utf-8?B?RFJTZ2lzUEJuM3MxRXRyQW05YWF5UExKTE10RzEvbU5KbWd6eWRKaTBvemVS?=
 =?utf-8?B?dnBRb3dDZXRaeERnUUtkeHREU2hWb1RWQW5ZRkowS0VsTEZWZndta1R4ZHgz?=
 =?utf-8?B?T1JGT1BUeVlnR0ZaRnJUWmNBQVhDRS9sMnRIZ1N0aHk5SzdEeEJWdVAxQUlo?=
 =?utf-8?B?TDRMVHN3cjBXbHVLckhSV1pyWS9PUGxKSGhjR2FZZXd1cGM4UHVnYVRZR2FC?=
 =?utf-8?Q?43X5G+OGPpSBwhnCYLHpFe61O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773c46ce-f4cf-46a0-9693-08ddcf9bbb4d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:03:12.9260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+XGaGp8dMY6bgKQfY2fyv2M48wBj5TFw+bJqQp2HFOtBHEUzwxw4ExiRKFqmpNXAaoo1HKrZ3e1Yz7FdeAKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
Received-SPF: permerror client-ip=2a01:111:f403:200a::61c;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:09AM +0200, Luc Michel wrote:
> Refactor the RPU cluster creation using the VersalMap structure. This
> effectively instantiate the RPU GICv2 which was not instantiated before.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h | 11 -------
>  hw/arm/xlnx-versal-virt.c    |  1 +
>  hw/arm/xlnx-versal.c         | 60 +++++++++++++++---------------------
>  3 files changed, 26 insertions(+), 46 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 9b11ffb845d..62b8d234ecb 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -12,14 +12,12 @@
>  
>  #ifndef XLNX_VERSAL_H
>  #define XLNX_VERSAL_H
>  
>  #include "hw/sysbus.h"
> -#include "hw/cpu/cluster.h"
>  #include "qom/object.h"
>  #include "net/can_emu.h"
> -#include "target/arm/cpu.h"
>  #include "hw/arm/xlnx-versal-version.h"
>  
>  #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
>  OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>  
> @@ -50,19 +48,10 @@ struct Versal {
>          MemoryRegion mr_ddr_ranges[4];
>      } noc;
>  
>      struct {
>          MemoryRegion mr_ocm;
> -
> -        /* Real-time Processing Unit.  */
> -        struct {
> -            MemoryRegion mr;
> -            MemoryRegion mr_ps_alias;
> -
> -            CPUClusterState cluster;
> -            ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
> -        } rpu;
>      } lpd;
>  
>      struct {
>          uint32_t clk_25mhz;
>          uint32_t clk_125mhz;
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 55159536ceb..cad345b98e0 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -22,10 +22,11 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "hw/arm/boot.h"
>  #include "target/arm/multiprocessing.h"
>  #include "qom/object.h"
> +#include "target/arm/cpu.h"
>  
>  #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
>  OBJECT_DECLARE_SIMPLE_TYPE(VersalVirt, XLNX_VERSAL_VIRT_MACHINE)
>  
>  #define XLNX_VERSAL_NUM_OSPI_FLASH 4
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 771f6108558..3905549b32e 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -45,10 +45,12 @@
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "hw/intc/arm_gicv3_its_common.h"
>  #include "hw/intc/arm_gic.h"
>  #include "hw/core/split-irq.h"
> +#include "target/arm/cpu.h"
> +#include "hw/cpu/cluster.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -107,10 +109,11 @@ typedef struct VersalCpuClusterMap {
>      enum StartPoweredOffMode start_powered_off;
>  } VersalCpuClusterMap;
>  
>  typedef struct VersalMap {
>      VersalCpuClusterMap apu;
> +    VersalCpuClusterMap rpu;
>  
>      VersalSimplePeriphMap uart[2];
>      size_t num_uart;
>  
>      VersalSimplePeriphMap canfd[4];
> @@ -227,10 +230,31 @@ static const VersalMap VERSAL_MAP = {
>              .has_its = true,
>              .its = 0xf9020000,
>          },
>      },
>  
> +    .rpu = {
> +        .name = "rpu",
> +        .cpu_model = ARM_CPU_TYPE_NAME("cortex-r5f"),
> +        .num_cluster = 1,
> +        .num_core = 2,
> +        .qemu_cluster_id = 1,
> +        .mp_affinity = {
> +            .base = 0x100,
> +            .core_mask = 0xff,
> +            .core_shift = 0,
> +        },
> +        .start_powered_off = SPO_ALL,
> +        .dtb_expose = false,
> +        .gic = {
> +            .version = 2,
> +            .dist = 0xf9000000,
> +            .cpu_iface = 0xf9001000,
> +            .num_irq = 192,
> +        },
> +    },
> +
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
>      .num_uart = 2,
>  
>      .canfd[0] = { 0xff060000, 20 },
> @@ -809,39 +833,10 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
>          qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
>                           compatible, sizeof(compatible));
>      }
>  }
>  
> -static void versal_create_rpu_cpus(Versal *s)
> -{
> -    int i;
> -
> -    object_initialize_child(OBJECT(s), "rpu-cluster", &s->lpd.rpu.cluster,
> -                            TYPE_CPU_CLUSTER);
> -    qdev_prop_set_uint32(DEVICE(&s->lpd.rpu.cluster), "cluster-id", 1);
> -
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
> -        Object *obj;
> -
> -        object_initialize_child(OBJECT(&s->lpd.rpu.cluster),
> -                                "rpu-cpu[*]", &s->lpd.rpu.cpu[i],
> -                                XLNX_VERSAL_RCPU_TYPE);
> -        obj = OBJECT(&s->lpd.rpu.cpu[i]);
> -        object_property_set_bool(obj, "start-powered-off", true,
> -                                 &error_abort);
> -
> -        object_property_set_int(obj, "mp-affinity", 0x100 | i, &error_abort);
> -        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->lpd.rpu.cpu),
> -                                &error_abort);
> -        object_property_set_link(obj, "memory", OBJECT(&s->lpd.rpu.mr),
> -                                 &error_abort);
> -        qdev_realize(DEVICE(obj), NULL, &error_fatal);
> -    }
> -
> -    qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
> -}
> -
>  static void versal_create_uart(Versal *s,
>                                 const VersalSimplePeriphMap *map,
>                                 int chardev_idx)
>  {
>      DeviceState *dev;
> @@ -1637,11 +1632,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
>      qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(s->cfg.fdt, "/", "#address-cells", 0x2);
>  
>      versal_create_cpu_cluster(s, &map->apu);
> -    versal_create_rpu_cpus(s);
> +    versal_create_cpu_cluster(s, &map->rpu);
>  
>      for (i = 0; i < map->num_uart; i++) {
>          versal_create_uart(s, &map->uart[i], i);
>      }
>  
> @@ -1687,12 +1682,10 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      /* Create the On Chip Memory (OCM).  */
>      memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
>                             MM_OCM_SIZE, &error_fatal);
>  
>      memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
> -    memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
> -                                        &s->lpd.rpu.mr_ps_alias, 0);
>  }
>  
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
>  {
>      DeviceState *sdhci, *card;
> @@ -1794,14 +1787,11 @@ int versal_get_num_sdhci(VersalVersion version)
>  static void versal_base_init(Object *obj)
>  {
>      Versal *s = XLNX_VERSAL_BASE(obj);
>      size_t i, num_can;
>  
> -    memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
>      memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
> -    memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
> -                             "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
>      s->intc = g_array_new(false, false, sizeof(DeviceState *));
>  
>      num_can = versal_get_map(s)->num_canfd;
>      s->cfg.canbus = g_new0(CanBusState *, num_can);
>  
> -- 
> 2.50.0
> 

