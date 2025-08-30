Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E75CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOJ8-0000e0-2C; Sat, 30 Aug 2025 12:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1usKMn-0004Su-L8
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 08:07:34 -0400
Received: from mail-northeuropeazon11022108.outbound.protection.outlook.com
 ([52.101.66.108] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1usKMh-0003Mb-Oz
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 08:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWHZ4LGSuWdcOFWniMhQRu7fxku/kWkS0W7c0jKdaldtxBJxIUbqNtf8Zieje8OgAqzayyv7tY7efCuBSAappok77X2EhpNXMw63JMQAOXOJaEUnJ2BlR+nNxhBjo6zi8EZECLSaGzXwsgCDQsT1qGYHbCQ3skEGKY0RmZtX0l6XJOLJa6KFsM0gPymsNQWZuzvjGVwGrr9wjkYvI0gSdv+dhTj4b6SN2zSuinYCFh0eD1BMmws1ttcZsY1159A0lpC4BcYwV/wpSL3XrjqfaNFRoBX8euZ/H8r7TA1hGxVKCmZXprTkLk06JOL6naJrRydLP46GlqKlulmuwMF/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmotDNzTieZr3QBN9MebistHB6oDDXxVfRNQwa3rtwA=;
 b=p1NxskLUKsZiERKndKndT/1kEgXQP/QeFYY27Geet+3MMl6JDo2z3Hu7P2DcAjKLG9PTZlCvSccXmSOXkmpc/U5EJpxhsV5MAQ9uuUypo7anzsgAF3j/wj5efDxJxROtOaqwNWxlzDM/BUrdvYT57oy8SS4uFam/W1X97Y9oqBbexYNFlAFlx1JdBZK8bi5Xe0sGlrVgNpE9YCl1tFL1onBb1ChCBja/YnLAp2T1ouvWjBTHNTg36FjfBoLLfdZykDA99IPmNZcx17loTJ9qte4wGg5xuDl3qkFhdfJb4N8pfXD+lyuG+ligFJ6dJ2hhYrm2zQwdpAkvfhoElq5WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmotDNzTieZr3QBN9MebistHB6oDDXxVfRNQwa3rtwA=;
 b=IncyKVz3blzhFxxrNVmUGrFbYubO+ZBPawxHejg+eyN+AY7zNHg8MEB4AombNADU9wg7MSa4aBGYEgoa28Z21iSeEUh0gioyQEihKSyiFw7XdaCW8J2secz0udwnph2lDkFu5p6q715dK+QaBFQuNADLs2Why3LAcw38Vu2E9g1Jl+GnjAIbkshk6JehOKEofrq2fVCNyyE0RS2O9D+7nRd68WLlW+356rvN5FMJRY0zsdwQLGUVjkZRcBpjlrUX8FdJ3oS8ebwJGT6ZKQJ0FSyZGKYKpTD3ckQcvyFmD4MKQHw2ZsLgyBbc+7wnNK5ftHDb5gK57mtzRa03khzxLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PR3PR08MB5579.eurprd08.prod.outlook.com (2603:10a6:102:8c::22)
 by DB9PR08MB7495.eurprd08.prod.outlook.com (2603:10a6:10:36c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sat, 30 Aug
 2025 12:02:21 +0000
Received: from PR3PR08MB5579.eurprd08.prod.outlook.com
 ([fe80::7f12:757d:e50a:5ed7]) by PR3PR08MB5579.eurprd08.prod.outlook.com
 ([fe80::7f12:757d:e50a:5ed7%4]) with mapi id 15.20.9073.014; Sat, 30 Aug 2025
 12:02:20 +0000
Content-Type: multipart/alternative;
 boundary="------------AljYGm0RTDe9c0Bk3u0J9hVU"
Message-ID: <91324239-c144-4b07-9cc0-9093b5870509@virtuozzo.com>
Date: Sat, 30 Aug 2025 14:02:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump: enhance win_dump_available to report properly
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
References: <20250827-enhance-win-dump-avalaible-v2-v1-1-a6f359e9ff8e@virtuozzo.com>
 <aK9K_SIcVBf_70gj@redhat.com>
Content-Language: ru
From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
In-Reply-To: <aK9K_SIcVBf_70gj@redhat.com>
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To PR3PR08MB5579.eurprd08.prod.outlook.com
 (2603:10a6:102:8c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR08MB5579:EE_|DB9PR08MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: cf13a032-d30d-49bd-5519-08dde7bd12a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFJVdXRicVdsZDlZZmJvbXZsTjRMYzhxakJUOGJtdjh2VjFRZ2QySVB3VURQ?=
 =?utf-8?B?SFprbWN3dlR2bTJKVVh1TWNUN096SVFwOCtuS2F6c2lLdUlKOW84Vm96OXk2?=
 =?utf-8?B?RXozQnpRdTZPK3NSZDdoUXJWQzJTSGhRRG9GUUJsZ2Q1SkxFOFVvNmNoNUpI?=
 =?utf-8?B?RmRuYlFaeGtvKzZGblg0ak9MU0VoeUswRmZSSjlrazViUUlydCs5OVFWUHdW?=
 =?utf-8?B?QmZOa2cxSERFZmJpSUJ1ME1QY2pSR1ZobXJjc2MrVStlTnBXOXNhUmdmSDFZ?=
 =?utf-8?B?K29LT2ZKK1poN1BzdlBPQlU3dFR0dzJlaWtuT04zQ2doWnU0d09jTDNJaStW?=
 =?utf-8?B?V24zbGlEWTMyUm04WUc4cktoMjd3Nlh2dmlSbkQ1TGZ0cFBYNEdzT2psU2I4?=
 =?utf-8?B?RmZlWXUzY1YvMysxc01GaytnQlpDeDFZd2hOcXZaNWJIcXRSZndEdE5ibTl4?=
 =?utf-8?B?NXZlcUlFMEJnbjhoQzRRSmxUQjFndHZqSzlOR2kyb252Z1pUQ3c2Y0JOVC90?=
 =?utf-8?B?NVVOVnFHZ0oweHVuRkgwS25OTHlXTUtndmF4V3U4Q0MrclJMT1FmRFhjR3pR?=
 =?utf-8?B?M2RiV2Qvc2pHL3V6NGFVeWhEMXhZRldKK01jRlhRN0JrWU1sRXNObmhLWXM4?=
 =?utf-8?B?Yjl2SFdGamZzQlE4THlvTEJtcktlVDlXUExBQ2k5Y0xVZ0U1TFRzeU1udGo4?=
 =?utf-8?B?Tysvb3BhSzhHdjE3MzVzSTNwNGU4Y1pIeGFaSmtlUmpTUXFlS2R2ZFhROEdn?=
 =?utf-8?B?NXFrcytVeThtVFQ0blJWdkt4OUlxc0k4c2VyVTFKV3FiYTVxWGNuS01jYWtT?=
 =?utf-8?B?b0Jaam54bkNZeWpueVBhSEh3MEI3SlR5a1BCMlJmcDFZTFBOR2FHY0xtQUll?=
 =?utf-8?B?YXBzclBBR2VlZEpvZ2lYSFJoREtjcFcwTjVaZnJFZ3hTa1grRmx1MjdOcEli?=
 =?utf-8?B?M3Uwb2ExWWF3SGZsQzNZUDFHTmNUTlhBY1ZnckNLbnZuWTdMSEFhWUFMdkFN?=
 =?utf-8?B?TVFzcUU2aURYQ2sxamFpaWYxRW1iZlcwS296UFRabUEvU0txaUF6WmVydHZ0?=
 =?utf-8?B?T2pVdUVUbVFiYzM1eEhGTmVwZ2NIazRFa2pTZjRiTTdPSnpta0dHN0l4VUpW?=
 =?utf-8?B?RHBDNU5lQ3Q2OW5keSthYVZmdW41NzBpcnFPVGhIWkhucTg4NVB6VnNaOXcy?=
 =?utf-8?B?bm44c3pnYkJXMTdoNVVma1Q4ZzNUVUxOc2hpZy96VmpjUGoxQUxuUE1WOUtq?=
 =?utf-8?B?V01OSWxCUnB2WUpTbTdsMkFYUW12MnRRTVl1ZzJpcnhOY0lSd1Bza05BUDVw?=
 =?utf-8?B?cDF4Zlh4bWs1OHkrcXJnZ0RzQ0hkc0xtS3U2Y0MwMGNNUWhwU0FnM3BKbUNC?=
 =?utf-8?B?UGtTTE9ITStQWmNyT1dOdlhkTzUzTEZuQnFQWFFKZE1XR3lDeHdRMjhZQzFG?=
 =?utf-8?B?L2hLSjExL0UwSE9xaTFJTjZ3VWF3WjhMNFVjL3IyWU1TK0owS1Bnd0x2Ylph?=
 =?utf-8?B?bzZFZ2RLU1lTUmdqMUtRVS9JZmFFN3BZWjJXNys5MmFabXoxZlFxUFZHeWtX?=
 =?utf-8?B?bS85OFlSZEVuNHlhZGlNdktkcWVDSEVmODJqcURWYVY2YjJsSnQwLzZTMk5H?=
 =?utf-8?B?eFNiU0NlendPMi9vblVKM1FNWGp6ZS9kc3E3UjJOOGtOQU5kWnQ4clJuRWdX?=
 =?utf-8?B?Unh3SkkxT3Z3S25GdDdFQkNWeFBoUkZlMEZSSFYzcCtsdFU0VVNmN3hYSllX?=
 =?utf-8?B?cWU5UjVmV3oxYitjZ2xWdUJURFdUSnBuc1JNWHJ5V0tPbzdMZzc0Smd0NE5R?=
 =?utf-8?Q?eG2N4nakVK8SZOvINn86vK8YPk4zM6D6UBmyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR08MB5579.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBRTmVNajhJcTFkVWkwUlZJb0NseDlrMzZxNGVwRWN1SlJyR1o4TWY1bnlZ?=
 =?utf-8?B?U0RTdzNrdzNmbEdjZ1FFWFpEUDFrTUdTdlJlUUhPSklYSW94WGIvQjRtajVi?=
 =?utf-8?B?SkRTYktNS0c0K2Y4VHIvVDRRQUFqT1V6djZSd0JpU2ptSU1rbUZnNy82b0tF?=
 =?utf-8?B?cW5sT3pUZW5ZWUZnTTBGbWd4RGEwdkZlMXAwR2NYRG9waVNCQm56U2ZGTitx?=
 =?utf-8?B?RDYwemFvVnBRa2MrSFE0bERrMWJZR1J1eUtpcUZ5WWhXTWJweW4vQldmcGVL?=
 =?utf-8?B?MkxPcHpxMnlvSnVHY0w5OUY1Nk5RbDd1SklORDFvSHp6SnFldEp4ekpCUkwy?=
 =?utf-8?B?V1RuaEZnaTJ0dTNTMXJzUnF0bUlzTkNMdVlnSmR3Z0t1L0VBdGMwd0RkOU00?=
 =?utf-8?B?R1NIQUNBbVpYbGNEdGJQWEJ2WldtNWhqTk91WGJ3YWpGUlZycC95ZGl1d1ZY?=
 =?utf-8?B?YVZxKytiQklkRXlKZGcwVGQ3RW9mMnk1K1htV3lSUG9pSUtGVnU0K3Rad3FP?=
 =?utf-8?B?OUpqKzRsSXlpVW9QMXFNQW9sYXRRZkxhNjRGYk4xMUs3QU1HOU53dVljYTBE?=
 =?utf-8?B?NlFGUll2OEh5ZXFscVNNTFFscUtTQkV1MjFPaStndlVJS1RjZk9VR1NOS1Vq?=
 =?utf-8?B?MGtLR0ordkxxY040RU1oZklFOGxYSjAydDlwckhBOFpaNWlVMThOVEFYNVpu?=
 =?utf-8?B?ZE1RRjY5K01qT0VBcmxONUR5MVpkbTQ4RzRoSkdYQTN5K01jOURqZEUvOGlT?=
 =?utf-8?B?UDFnTXFGSVIwVlBTanpwNC9QZTNDOE4yaG5EUGhBVkxpbTh2RERiOHVkWHBV?=
 =?utf-8?B?djVrbE9keitrWEl4Y2gyMGhuYUZsS1J2YnRPRkNCcExyRHdQRncyQVpTVG91?=
 =?utf-8?B?MFU5NVF6cm84M2thdGs4SWVxNkt2YWowd0c5YmtWdW03WkV2WlRPUjU2UVFX?=
 =?utf-8?B?NGJaSDU2Y2VBQzRFM1VGenM4YUVKVzFRQk5uc0V1eEMzejJ0Q0hsK0hMektE?=
 =?utf-8?B?ekVrVlhsT3Ixci9GZVUrZ0UxbStOMmM2RDVlUGxTS2g2cUMyUFJrV2M3d0xG?=
 =?utf-8?B?SFFUa0hiaUlFajQ3Z1VlUzdWNFM0YTc3eHB2VjViYXUrZWhKREhvZ3FqdEtQ?=
 =?utf-8?B?Mm1qWlZyMmlPTmxjV0lmU2lRbzNuN3lTdWdVejQ4V1ZnZGxjTkVVSzBFTldF?=
 =?utf-8?B?RWRLMFpTYjhJL2NuVmViZzdRRG9YOWxveGNGODNTVVUwblZRU0RKUXlQQytu?=
 =?utf-8?B?a01tQzZoWlh4MTZnYzk1YjZqa3hqdmVGNytQbjJDRWg1L3N0QWYzem9oQzc0?=
 =?utf-8?B?YXNhc05yZVRSZHhzeHJsaHI4RHJEV3NGMVhuZDRkcjRLczhkMEdUdDU1NjYx?=
 =?utf-8?B?ekgvYjhGOUNnWkxaL0R3SzkxUXQ4dUJxSzM2TlZDK2FpKzcvaUNLdlk5Vk83?=
 =?utf-8?B?WjJDZ0h0RUU5STRtdmZuM3lCNWp1TFFWckxHM1g3V3puREszRlljY0FYV2M4?=
 =?utf-8?B?bldzdkVhejBOOVRDVS8xeDlrVlJReHRyaUtPT0dqVE1VcGFXWEtDc3NlZDZ6?=
 =?utf-8?B?R0xETE1OSlZIc24vSjRoMUpCd2s2Y1Vxd0NmeWFTbXdpS0NsT3B1L1crZGRh?=
 =?utf-8?B?S3lRRGQ0Vkc4VHFoeDVaYXBxbk05Z2xMTTVIU1U5UVhHelVybE16RG5LTmhy?=
 =?utf-8?B?a2lsSDM2OUx4eEFNazJibkxQS09xMmtqRkhEcmZNZzhLTnpobnlWanBpMHJk?=
 =?utf-8?B?MUNuT3E5bHo1TDhNOUYvUDJ6K0ROM0hzK0pKM0FnaU5CZUhBaEovV0FYdVRP?=
 =?utf-8?B?a3VHMUVpdTF3YzBkY3ZqTlQyeWRSY3JUczJmU3Y3Z0hwcjBTMURNUnZDbEVp?=
 =?utf-8?B?UzROVno3WVBtNjZwV1FtdEJFR051ajBxRnc0OStUaUN2aEdQbjllVXNxcWc3?=
 =?utf-8?B?QXRNN1lZVmZsYjN5bXRmdi9DMzludFdvU0NBeHhiYlJ3RnpJMWZWTEZLVTJt?=
 =?utf-8?B?RDVPaC84SU15SnpGbXJNMFdsa1hrYllkNzVUWWgwOWUycEt5bTRmM1hvN21x?=
 =?utf-8?B?cUZkZnh0QVZSRXhFVng2REFvZ2F5c1IrRlNYcjYvMWRwRkkyM3NMWWppaUZS?=
 =?utf-8?B?c1VCdGhqTHQrN3hJS1RYM2lWRXJqekVBZkNFVVdVQmlNZkdsYTEvNXFyWVVX?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf13a032-d30d-49bd-5519-08dde7bd12a5
X-MS-Exchange-CrossTenant-AuthSource: PR3PR08MB5579.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 12:02:20.6190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uHNGLJ1FP63URds65DObUwCQ3WdaseReoYsg7m3nGtUA83R7lD8yWuiES4nX9MoK1/lh7QU+D6xLld2Qd4YicHvH7jZy8hnUmGysooIBMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7495
Received-SPF: pass client-ip=52.101.66.108;
 envelope-from=nikolai.barybin@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------AljYGm0RTDe9c0Bk3u0J9hVU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

27.08.2025 20:14, Daniel P. Berrangé wrote:

> On Wed, Aug 27, 2025 at 04:15:27PM +0300, Nikolai Barybin wrote:
>> QMP query-dump-guest-memory-capability reports win dump as available for
>> any x86 VM, which is false.
>>
>> This patch implements proper query of vmcoreinfo and calculation of
>> guest note size. Based on that we can surely report whether win dump
>> available or not.
>>
>> To perform this I suggest to split dump_init() into dump_preinit() and
>> dump_init_complete() to avoid exausting copypaste in
>> win_dump_available().
>>
>> For further reference one may review this libvirt discussion:
>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
>> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>>
>> Signed-off-by: Nikolai Barybin<nikolai.barybin@virtuozzo.com>
>> ---
>> During first series discussion Den mentions that that code will not work
>> on 32bit guest with more than 4Gb RAM on i386.
>>
>> This issue required even more code duplication between dump_init() and
>> win_dump_available() which we'd like to avoid as mentioned by Daniel.
>>
>> Hence I present 2nd version of this fix:
>>   - split dump_init() into dump_preinit() and dump_init_complete()
>>   - pass pre-inited dump structure with calculated guest note size to
>>     win_dump_available()
>>   - call header check and guest note size check inside
>>     win_dump_available()
>> ---
>>   dump/dump.c     | 129 ++++++++++++++++++++++++++++++++------------------------
>>   dump/win_dump.c |  23 ++++++++--
>>   dump/win_dump.h |   2 +-
>>   3 files changed, 95 insertions(+), 59 deletions(-)
>>
>> diff --git a/dump/dump.c b/dump/dump.c
>> index 15bbcc0c6192822cf920fcb7d60eb7d2cfad0952..19341fa42feef4d1c50dbb3a892ded59a3468d20 100644
>> --- a/dump/dump.c
>> +++ b/dump/dump.c
>> @@ -1777,10 +1777,7 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
>>       g_strfreev(lines);
>>   }
>>   [...]
>> +    s->nr_cpus = nr_cpus;
>> +    return;
>> +cleanup:
>> +    dump_cleanup(s);
>> +}
> The 'dump_cleanup' call is unsafe.
>
> In qmp_query_dump_guest_memory_capability we initialize 's' using
> 'dump_state_prepare' which just zero's the struct, aside from
> the 'status' field.
>
> Meanwhile 'dump_cleanup' will unconditionally do:
>
>      close(s->fd);
>
> and 'fd' will be 0, as in stdin, so we break any usage of stdin
> that QEMU has. Then some other unlucky part of QEMU will open a
> FD and get given FD == 0, making things potentially even worse.
>
> We need 'dump_state_prepare' to set 's->fd = -1', and in
> dump_cleanup we should check for s->fd != -1, and after
> closing it, must set it back to '-1'.
>
> In fact, I think even the existing dump code is broken in
> this respect, and so this should likely be a separate fix
> we can send to stable.
>
> I think the 'migrate_del_blocker' call in dump_cleanup
> is potentially unsafe too, as it might try to delete a
> blocker that is not registered.

I'm not sure about that. Dump blocker variable is defined as global 
static and is zeroed by default:

static Error *dump_migration_blocker;

And even if we tried to delete unregistered blocker it would do nothing:

migrate_del_blocker(&dump_migration_blocker);

void migrate_del_blocker(Error **reasonp)
{
     if (*reasonp) { <--- NULL-ptr check
         for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
             migration_blockers[mode] = 
g_slist_remove(migration_blockers[mode],
                                                       *reasonp);
         }
         error_free(*reasonp);
         *reasonp = NULL;
     }
}


But maybe I'm losing something, correct me if I'm wrong.

> [...]
> With regards,
> Daniel
--------------AljYGm0RTDe9c0Bk3u0J9hVU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="2">27.08.2025 20:14, Daniel P. Berrangé wrote:</font></p>
    <blockquote type="cite" cite="mid:aK9K_SIcVBf_70gj@redhat.com">
      <pre wrap="" class="moz-quote-pre">On Wed, Aug 27, 2025 at 04:15:27PM +0300, Nikolai Barybin wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">QMP query-dump-guest-memory-capability reports win dump as available for
any x86 VM, which is false.

This patch implements proper query of vmcoreinfo and calculation of
guest note size. Based on that we can surely report whether win dump
available or not.

To perform this I suggest to split dump_init() into dump_preinit() and
dump_init_complete() to avoid exausting copypaste in
win_dump_available().

For further reference one may review this libvirt discussion:
<a class="moz-txt-link-freetext" href="https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB">https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB</a>
[PATCH 0/4] Allow xml-configured coredump format on VM crash

Signed-off-by: Nikolai Barybin <a class="moz-txt-link-rfc2396E" href="mailto:nikolai.barybin@virtuozzo.com">&lt;nikolai.barybin@virtuozzo.com&gt;</a>
---
During first series discussion Den mentions that that code will not work
on 32bit guest with more than 4Gb RAM on i386.

This issue required even more code duplication between dump_init() and
win_dump_available() which we'd like to avoid as mentioned by Daniel.

Hence I present 2nd version of this fix:
 - split dump_init() into dump_preinit() and dump_init_complete()
 - pass pre-inited dump structure with calculated guest note size to
   win_dump_available()
 - call header check and guest note size check inside
   win_dump_available()
---
 dump/dump.c     | 129 ++++++++++++++++++++++++++++++++------------------------
 dump/win_dump.c |  23 ++++++++--
 dump/win_dump.h |   2 +-
 3 files changed, 95 insertions(+), 59 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 15bbcc0c6192822cf920fcb7d60eb7d2cfad0952..19341fa42feef4d1c50dbb3a892ded59a3468d20 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1777,10 +1777,7 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
     g_strfreev(lines);
 }
 [...]
+    s-&gt;nr_cpus = nr_cpus;
+    return;
+cleanup:
+    dump_cleanup(s);
+}
</pre>
      </blockquote>
    </blockquote>
    <blockquote type="cite" cite="mid:aK9K_SIcVBf_70gj@redhat.com">
      <pre wrap="" class="moz-quote-pre">
The 'dump_cleanup' call is unsafe.

In qmp_query_dump_guest_memory_capability we initialize 's' using
'dump_state_prepare' which just zero's the struct, aside from
the 'status' field.

Meanwhile 'dump_cleanup' will unconditionally do:

    close(s-&gt;fd);

and 'fd' will be 0, as in stdin, so we break any usage of stdin
that QEMU has. Then some other unlucky part of QEMU will open a
FD and get given FD == 0, making things potentially even worse.

We need 'dump_state_prepare' to set 's-&gt;fd = -1', and in
dump_cleanup we should check for s-&gt;fd != -1, and after
closing it, must set it back to '-1'.

In fact, I think even the existing dump code is broken in
this respect, and so this should likely be a separate fix
we can send to stable.

I think the 'migrate_del_blocker' call in dump_cleanup
is potentially unsafe too, as it might try to delete a
blocker that is not registered.
</pre>
    </blockquote>
    <p><font size="2">I'm not sure about that. Dump blocker variable is
        defined as global static and is zeroed by default:</font></p>
    <p><font size="2">static Error *dump_migration_blocker;<br>
        <br>
        And even if we tried to delete unregistered blocker it would do
        nothing:</font></p>
    <p><font size="2">migrate_del_blocker(&amp;dump_migration_blocker);</font></p>
    <p><font size="2">void migrate_del_blocker(Error **reasonp)<br>
        {<br>
        &nbsp; &nbsp; if (*reasonp) { &lt;--- NULL-ptr check<br>
        &nbsp; &nbsp; &nbsp; &nbsp; for (MigMode mode = 0; mode &lt; MIG_MODE__MAX; mode++)
        {<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; migration_blockers[mode] =
        g_slist_remove(migration_blockers[mode],<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *reasonp);<br>
        &nbsp; &nbsp; &nbsp; &nbsp; }<br>
        &nbsp; &nbsp; &nbsp; &nbsp; error_free(*reasonp);<br>
        &nbsp; &nbsp; &nbsp; &nbsp; *reasonp = NULL;<br>
        &nbsp; &nbsp; }<br>
        }</font></p>
    <p><br>
    </p>
    <p><font size="2">But maybe I'm losing something, correct me if I'm
        wrong.</font></p>
    <blockquote type="cite" cite="mid:aK9K_SIcVBf_70gj@redhat.com">
      <pre wrap="" class="moz-quote-pre">[...]
</pre>
      <pre wrap="" class="moz-quote-pre">
With regards,
Daniel
</pre>
    </blockquote>
  </body>
</html>

--------------AljYGm0RTDe9c0Bk3u0J9hVU--

