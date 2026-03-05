Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A78F30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5be-00044O-AA; Thu, 05 Mar 2026 05:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bY-00043z-4e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:53 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bU-0007Sn-OJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ0R3gcAj5I5ziLNZ7eeOcQBD1C7R8iGK6QGNr7+bImvdNa1qnXbnPKQnxJCX+hkbb6Up5PGKuLkkPZOelNCcO6RaZ8ju0qYMvw6dEdudSFs/jF8uShSTGae4MbEnAF7NEpGWOtddj1IM514a80Wfi2v87SEoVcwXBlDZPwy37ByxAp97t6TkCls4iPS06P+XWhqMOFjHk2/8WWbsqjpgIzqIagocfSnyBZUEVSG0TSnSlqECrJ7jYzmGaRBvU9mL5P6BPRpLL/n0wfgtF4VdcMNyyMX90Jf48IpbATkBad2H0zoYN5ygE1q8nZweE92nBjSNV7QOlbAgfXf9FfDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psp0XI/VXzU5N+CSR50HW4z5F67TYfX8ok8Qs/oKzv4=;
 b=GiQvDRlTEJ/9gieduoNlgE//+F3R0yAOjevyOy8+slbGg9V3ZFPERbWSbuSeKgZJrfcnSr+aw7U3IvH4kxXuESJLMqGnTBUx5RwzGOx5fFZ46Yx8c9DepY23BEWTOvHgrvxVweASy56bVAZWdl3CYU9nJZYeLINe384yYpcO0AKFFlH0hQUKc2e0ApqQKpsDgjeD53J9TtF6mrGWlndwZ+tmyoSuHWxLoAvGIyjHgJwdZhY4P9kGZWIOHhGV7cF0wAzjlJjpGtW6fSkg6GIK5uBZ1d9SOTZ6jmcObebXI5YI+xD53me8CJ6EIjkGUfVTWumbVKejR8Qo78y/QZH1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psp0XI/VXzU5N+CSR50HW4z5F67TYfX8ok8Qs/oKzv4=;
 b=SINucwnM92vCBayZd8Z6mWblyqhmzkdKstuv2CHiWEGOZjX/ifGfPWFz9TzNYAHzda8ifJ771b+dqqPSwVaTqwSdL5aXuL+ewHlnHdLMZpk4U9fEw0Al42Zvg/Zh4MJPa0Ae8JZPY2ttpCAfaGW588GAz6vjcSRPWivvhsGMD3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB0807.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:06:45 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:06:45 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 4/8] plugins: add PC diversion API function
Date: Thu,  5 Mar 2026 11:06:02 +0100
Message-ID: <20260305-setpc-v5-v7-4-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3704;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=UVKdS+oRqmqQ4s/cKw91vBecZs1GDBUW8gYjPJ87V0I=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTGS3MwFakoAyKjmckEUGPXUwFv6jcyf3Gby
 +ir5ryJr/OJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUxgAKCRCW6ye6MV/H
 fB/ZD/0RceTAR09LpHGvXIOBrJ/rbI0DekbTCaFRRUjYPQE8IVnZ8315gRPnxlr528tZmootjZA
 0scQ9qmoZb4tB6twF+7KQ9LORt7F7MFoQLSmE37cYASK7mvt8x80aE4oDq+kJvMcK7fD7lyKSK/
 jXFPvaMd6rFhHIdJE8o60WlKKM38rlGayftZkaqmGhfSIxZWxnYE2pMAE4H8S5qLHlcMHjtLDvV
 0GWtZSnGAL6tv6b+XMrBq25asUxgwIP7oSftUUOUT2D1vPh3mr2ZaP7g5DlBpUFdgmqGmC0mCHO
 eBb4ojUFm6jIeKdjEQ0l4kABtOgnKSr4Rcvhr0r70gWeuhIQy6JhKoRCy/OrdzUM9N20niOgVS0
 q2XEntPQfnQTLaNk+2KCVGlMVeJbAx9cqqMBTTmTbOOYy2yXgD1I5Y8fu2kctFivEDRSk3N6hVz
 qwqLBsaQ/B5wHbYySeIbw+gQ/nvJAfFhZKQ/JeKbqxWnPjKlhdI2W5mIvUf5Pcugh0JXOcBbB4a
 d8Vc77mHRfbab4F27K44sPEAHeJPo0fDoO3RMMCZwTkTZxHdML1htHTLAjLOCnBQCtsAsnGPwt9
 L5mcUvJMbyQkomieQB+DW32t6HzWLtULGtX/TZ7orNufH4UA7uKH5G/2PGxVVzghCvVTdhtS+EQ
 5xu4zHvx7CrdOVQ==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB0807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d340e9b-e46d-4382-7fa5-08de7a9ee799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|786006|19092799006; 
X-Microsoft-Antispam-Message-Info: 88cLVkmyY1VrLpEMweotbTj+YSTp1ZP0PpLknStKr+VCYC7O5kuI+O3JXa6Zf/nbT8J8xKjlLB1eFkwHOaa1rFODMZ9Q+nw72QI/Hpeae7mEItjz+urxmj9vuRGrtefekKUXa04OlHU5Rci8yAK+vdT8LW/fyRnKmgSiGEesdLHImm6Srn155oXnMMNtwMEgZe77fnxeq5GMTVv0khayJVYi5O7lC+ZsoaTm3VxxZMxhrnR/dqFI3VqrCR/GBtNt4XEjXrFSLpFb8SBixis9xAFoEP32w5sHARNv3mIDghqGlO1sQEq2sj9wox8LVCEPs7v74pqjn1l9/Czz+dAtfle5SerIx+6yaS8IQLMglHtdRuL4VWIvgI5BsJvkuGYh2pozG3m1gkVTn2ZGT5dOCuJo5GNQCxw/a9LGcfgWUHL+VcErbWQHsQETgU/vj8eZGtW1MXOn1XuYtLguVzvTobBRy9Btb+/7KikIA5k/LCUQMREsOyOJvNKZImSs40KQr/FOyKl1d9je8VWQtk1grz4wVS1Jr+j9/83+iK1gBzAC9WyZrC6UHNSdv+3V0XTSj25+2ynYzew8V+lm2hmwYE2Dm1zQBk1FwAlM8TLF/v9caist4ftfY+fe05gZSWp90+1yTLXC/qjhtj/lQ/Mcj8+YqIHa9UpT5sDJrBy47bpHxz0ec5iuO6HYKDP1rlgziGYJk97QyNCdy9ULL3qy0fLJzkp9/xvhAH567wxNNcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(786006)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTBnSGl2OFJ5bFZoZ0M4NmFIb2NtUTRoZzJPVDZEZGdwQzA1MGtKRUZJeUs5?=
 =?utf-8?B?N1k3T3VPNUtPK3RLV2JtMzRSSGlGcHBGN0JXR0s1YUJzdEdqeXBNejkvejhz?=
 =?utf-8?B?TVlrSExGUVI1a0pURjRIUkNvbnhqU3lPWFUxU0VrcjRPeHNlc2ZjQ3M5WTFy?=
 =?utf-8?B?V29MUE9BS2NQWHRVTHZJOEZNMW1IS2pBMXhmbGZEdGtxbG96Z3gwdmhpQlgz?=
 =?utf-8?B?UFdjUWNXRGtzMjI1R054OXlpaFZiMnRpNGRxaCtCcFFxUW84RVhVRjJ0cDZR?=
 =?utf-8?B?ZnMzbllCVStMTE9Sbkk1RU1UbDlzZCtTUlF3RTFXQUpjSXdoZVIrdVpnUGdy?=
 =?utf-8?B?YXRQUEtablFiclZBMTg5anhrbVpoc0RFdnA0NnBXU3FVUFcxMHhzbXpPZTdL?=
 =?utf-8?B?VVRkWmladzVsTG9XWFdoc0NiUXRicWw3eFFVdU1NZksxcmNORytMUWRzMkFW?=
 =?utf-8?B?VWhlUmFxallXdjMwZHFpQThNYk5vQzZKdGFwdWtIQ2JFTnEzTldKN01ZT1JD?=
 =?utf-8?B?c2tieVB3djh4TGFqVUphNE12QzNpRkhKN2xQOGFKTXk1Q1h4dkgxdnJMMGlL?=
 =?utf-8?B?aU9pZlRCSjVNY0RiUzBsTWl3NVpBV3FyTHpWOHZVa3lnZmcyUlB2TUdxTS9p?=
 =?utf-8?B?c3h5VDJpdWNzR0FQSUQ2TTVUb09XRDFBckhKc3Ayci9YT3M0QjVHNnR6UGRQ?=
 =?utf-8?B?K2xBWHdYV0tTdEdUK2wvN0VFTGhHblNaNHJCT1pnbFl4Q0UrcCt5UVo5cDVV?=
 =?utf-8?B?UG9pSmIrQllJbjAvR2FRZ2pmbkVEUkVhWXAvd1BobGZSNHRzOExxOWowUFNx?=
 =?utf-8?B?S1k0a0NGMkZnQUdHWlNuMDJhQ1ByamFmckZqeW1WRWVxMjAxd1ZYZGprOXBy?=
 =?utf-8?B?Sk1YeXJZdEZ3MEVtNXovOE5vbUxONkFCSDk1YjFsbXJxaURRUWJlL2YycWVl?=
 =?utf-8?B?RWdiRmdNQUo2dXBqZ1RtQXRVOHEvYWVyT1FmVTJhRC81TVNSZWY0cjJFR3BL?=
 =?utf-8?B?OE5xUllXRlJoVzhaUXIwZFc5ZHRTcHVGWkNJMTdScnNScmtqU1B0d1ZCVjV6?=
 =?utf-8?B?di96bjFBbUF1ZHhKRWxsekpUNUttZ2NzMXdoT3l4c0RYcE9ZcUJHbnpFbEFM?=
 =?utf-8?B?aExSRnFpOXI3bnlPb2lzQjNPdmNFRE5tTGlGRkc2YXp0NnpYOUlMemt5Vm9S?=
 =?utf-8?B?bWdYNnFpQTZ6WlhYOW92L0kxaGZlNlV3T2pob0ltemUrbllWOW1tNy9DdHpw?=
 =?utf-8?B?VmcrUWRnNnUyWXNETmF2M2loQitxNThEKzJaZWg5cEZhZUlrMng2eGdTWkdU?=
 =?utf-8?B?QjU5NjFWQ1VEVVZMN1ZNU1J2eXRqRHYvK0JXTWdPU3R4TmNpVS8xRlE4VzFJ?=
 =?utf-8?B?R1lBSUcwbWtWRW50K01lc1oxT2JBN3M4bEs3MnVqNUxPc2pFdHNDOWtmdEdr?=
 =?utf-8?B?dHJNRU5neGp5cnFaMFgzT0RGTDVCUXN0ZmVORHhqQ3VwZlNLdUZJMXpuY1hi?=
 =?utf-8?B?UE5vaUZjTzgxQ3EyN2J2MjdkQ2xhWG1DbklXZlZPZFZXaFBuQ0d1NHhrQ3hj?=
 =?utf-8?B?bVdrUmFkVTQ1cUtQcVVya0crd0pSMWhtVEJkZDE0VmVJRDFwNi9icS9Wa2lN?=
 =?utf-8?B?N0RNMjUrL3FTVTkvMzJOWVFXdmdCREFYOGV3SFYxT05sOGdydm44NFBqakdV?=
 =?utf-8?B?cGNNMnBMcDRlajFHL1ZWUmh5aGRXVm5rUGREUTFDZ1QxelBaMHJPSW1PWHhn?=
 =?utf-8?B?UEVldC9US2NoOFV1VGprWG83UnNleS9EYTBweU44N0JYbzhGOGxUZkdFTkpu?=
 =?utf-8?B?YU85dTlleC9TNVlXZjU5eDVDZXBveUQzcURseTVHVVdWc1JVVndqNUlvVkRX?=
 =?utf-8?B?eEllZWxpb2I2U3YzTFk1NVBYdzVVMExSbno3eHVKbVBLU2VzNWFQTVlucUxJ?=
 =?utf-8?B?bHhTc3dxVXRPUDlwYUY2TjhUS0xsWVpLR0thTTd6aGxXNXdNR09hbytwbFFx?=
 =?utf-8?B?YzY5b0laMXpKMy9JSnFxT3QwaFMxT3grMFI4U2Z5M0loQmRaYmJuN25lN1VG?=
 =?utf-8?B?NEpaMThWR3FJRTJoeEhvUUlYZlNEMGw3bElBbW4xalZRTGNEVmtPY055Vm9R?=
 =?utf-8?B?a3o2Zy96WFBiS2xqcHZmSU1rbnF3T0IzcVI2K2xBQk9aNG0yOGlhMTZKZlQ2?=
 =?utf-8?B?WDJZK084ei9tZmpsNXVXKzhXbnhiOHYrU1U4VzZkQk1MY0MwSElqNGRrVDdp?=
 =?utf-8?B?c2NxczRwdVdKNzNFc2RDREVrT203eWw0YnB0dE9CQnFtVThzWE51bUxNejVG?=
 =?utf-8?B?ZjZEZFNDYUFYM05LeGNoa0ZEcEFMTzAxUDIxQmxuZDBacHhHMENFd1ZlY2NG?=
 =?utf-8?Q?mNUBJ994hEoMvQKE=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d340e9b-e46d-4382-7fa5-08de7a9ee799
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:44.3505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSlYMZKweytrGMKdK9zUTcDpgspLfVM0lttFpjNLW3eMcYhSmx9eTqG3KWzJn1DYbqPWL23UzTL1O6jKR9TUOg2mg7RjZ/FFGW8pdoBbzkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0807
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

This patch adds a plugin API function that allows diverting the program
counter during execution. A potential use case for this functionality is
to skip over parts of the code, e.g., by hooking into a specific
instruction and setting the PC to the next instruction in the callback.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h  | 13 +++++++++++++
 plugins/api.c                  | 11 +++++++++++
 scripts/qemu-plugin-symbols.py |  9 +++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index a6ec8e275d..7b9cd6a971 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 6:
  * - changed return value of qemu_plugin_{read,write}_register from int to bool
+ * - added qemu_plugin_set_pc
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
@@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
 bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
                                 GByteArray *buf);
 
+/**
+ * qemu_plugin_set_pc() - set the program counter for the current vCPU
+ *
+ * @vaddr: the new virtual (guest) address for the program counter
+ *
+ * This function sets the program counter for the current vCPU to @vaddr and
+ * resumes execution at that address. This function does not return.
+ */
+QEMU_PLUGIN_API
+__attribute__((__noreturn__))
+void qemu_plugin_set_pc(uint64_t vaddr);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/plugins/api.c b/plugins/api.c
index 32eb086300..23c291f644 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -41,6 +41,7 @@
 #include "qemu/log.h"
 #include "system/memory.h"
 #include "tcg/tcg.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -467,6 +468,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
     return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
+void qemu_plugin_set_pc(uint64_t vaddr)
+{
+    g_assert(current_cpu);
+
+    g_assert(qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_RW_REGS_PC);
+
+    cpu_set_pc(current_cpu, vaddr);
+    cpu_loop_exit(current_cpu);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
diff --git a/scripts/qemu-plugin-symbols.py b/scripts/qemu-plugin-symbols.py
index 69644979c1..ce99796ce2 100644
--- a/scripts/qemu-plugin-symbols.py
+++ b/scripts/qemu-plugin-symbols.py
@@ -20,9 +20,14 @@ def extract_symbols(plugin_header):
     # Remove QEMU_PLUGIN_API macro definition.
     content = content.replace('#define QEMU_PLUGIN_API', '')
     expected = content.count('QEMU_PLUGIN_API')
-    # Find last word between QEMU_PLUGIN_API and (, matching on several lines.
+    # Find last word between QEMU_PLUGIN_API and ( to get the function name,
+    # matching on several lines. Discard attributes, if any.
     # We use *? non-greedy quantifier.
-    syms = re.findall(r'QEMU_PLUGIN_API.*?(\w+)\s*\(', content, re.DOTALL)
+    syms = re.findall(
+        r'QEMU_PLUGIN_API\s+(?:__attribute__\(\(\S+\)\))?.*?(\w+)\s*\(',
+        content,
+        re.DOTALL,
+    )
     syms.sort()
     # Ensure we found as many symbols as API markers.
     assert len(syms) == expected

-- 
2.53.0


