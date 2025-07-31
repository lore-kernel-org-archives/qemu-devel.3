Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B88C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhal7-00012n-FG; Thu, 31 Jul 2025 17:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaPN-0007GL-Pp; Thu, 31 Jul 2025 17:01:51 -0400
Received: from mail-dm6nam11on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62d]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaPL-0003YW-Md; Thu, 31 Jul 2025 17:01:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2Nodkl1NLoyTojTiZvFm4HdpIhakXN3MKOu+rZEkMB+nVVQtashKFjVsxKR/b5eSCgUheM6/vl9izcEQlMCLb5gRDNEbUo5rOZ/ik+u1SGhMl/Z3h5Aj8UtxlmshoBV4He0+A1WlxSt//o7yft5AXu/8U3a/vPkCfxmJFQnvtdDfpJcFuP2oXsOoujBjmOheApHIhFSs7VoIQToBN8RSr6g1Mkc+EwDcwkdQNLqoNhwQ3a3hHO6d+ieUgjg62X20qEkDpBZaTsOwovWPIHfin37YxzVQsKpqEUUEB8JLCI2FaE44P/0+Ac7Izkv8Zf4douNsMK4OoIz3oaor47rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9YTDpNbHJiaRw/L4IpdQT319JmMMkrigGT83I7hK4Y=;
 b=iJGRDnvGaMyBfdrgAboe7K3XUaXcxcTlg11CTtJ4VDvr3gZA5KaKZPOxkyaIs1cO4rb3ZwSwq064CiwvFDZ8khaOU5FfPF1hMBj/c9XtvqbS1UujLbtNkVJYOzgcUd/bDmGgOwlQ6LY+GhqGRVA5HTeHUyzyaHEgor5ZI2juXxKfxlj1UJDsjQ8VOIuKpy83Mx+TC+tzjubUzJQAjHkyCNwPWKkOTt0rEFJQFqdMa09LbCvHO4h/bVW1lRyxpwUxZ5WuhNe6yu35IKYwU3y0tPi/wFxitj1DePbOCMtK0GY0N4o9Yy/+RG/anH8Wsxn37jLNnhfLqeArrOa1IJltbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9YTDpNbHJiaRw/L4IpdQT319JmMMkrigGT83I7hK4Y=;
 b=bo66eDl7Oh9W18m5eboK3/ly6ULSpJPpxBCIMm3u+TjqYCHZmB5ssB1f1SitPeas4lDIFLri7l1ncp7TDiA2YZc6+mLUNjRvKmVaZaiaiZ3p7tg5gSzJerrcu3REYVnpWfM9bj+xGzpa0PkcPyfRHVwk+wAlPwWY7dxvAMB/Ce0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 21:01:43 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 21:01:43 +0000
Date: Thu, 31 Jul 2025 23:01:36 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 45/48] docs/system/arm/xlnx-versal-virt: update supported
 devices
Message-ID: <aIvZsOqdkdkr6krt@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-46-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-46-luc.michel@amd.com>
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: e64d77bc-fb75-4813-ff8f-08ddd0757402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alZHZDBIR2xXTGIwY3pSVkc1MUlHMW5LRFAxaUY5eGxTVkJmNVBFOWFzNWNr?=
 =?utf-8?B?T0o5YXllemUyTzNoODQ3M0ZmMjdQUTFabTRXSTg1WjRjMkZRRnZWQ2VpVk1Z?=
 =?utf-8?B?YW1oYmZoZDdENC9xU1Y2YUUxYWJrV05wYWpSa2VST1BmbWZIaUtNYVlQa0Fl?=
 =?utf-8?B?S01NbFZ0NkZHTWVqdldJWlJtRDkxNHM0b0dkZnUzNkNxY0xYWVRNeUV6QTBC?=
 =?utf-8?B?ZTJMeEg2NVo4VkRwZTNNZlBaU0V2dlozSjlCQWtnV1JDaHo4OEFhek1nZjdv?=
 =?utf-8?B?NGtpakNwRkxOM1hadEczQnFwQjhwNkVDc0wvNmJMYlhNWmd4elVpVHhqRWll?=
 =?utf-8?B?TFdKLzZiRnRSdXJDMjJlWmV2RGwrMjJucHBndENCSUJaUFY4Rm9KV2NRR255?=
 =?utf-8?B?UkM3dDZ6cXR4THk0UW91LzJ1MGFmUGFick8vQmw4ZGtIbEdsa09RWFVDck92?=
 =?utf-8?B?a1VCTlVSc1UwaE95a29XbXdKUTQ3dFl0UWFPTEE4UUtSUnBKb3ZKeDNLV0ZO?=
 =?utf-8?B?R1hvVWJLbk4wdCthUmhTMm1qOEw3WVU1cWJpeGVydVVLMUJ1ZHh4dlVZTFJN?=
 =?utf-8?B?SWhlRGdwbHVoaFA4QnFDOXJyNHp3MjJvV25pYXR0Mno4Z1hScWhNU20zYXZ2?=
 =?utf-8?B?OW4rT3BKREtXRTBlaW1EYUloVmRUM2NRZTZ3bHpIQWFiWmh2dFVlY1dvMXkv?=
 =?utf-8?B?Ym9VRGE5RXBwNks0bGRsd05NTGJqUWlwdFo5TU5pRTNZUHR3dDF5MFlZTm1E?=
 =?utf-8?B?RXNudGQyL0llZ3NLK3JiNC9LREk0cGlLOXNXa3gxVGVGaHRCU295M1RpSXda?=
 =?utf-8?B?eHdHWTFuTjMvQ0JHK2xtbUFTbmRoRkMxWThVeUN3WjE4Rjk3Nm51STd6WStm?=
 =?utf-8?B?ZjBwY3IxajY3R2sxck8yNisrRU56MGgwZWNZR0xsa0NHZFM1TjVpbU5pUFB1?=
 =?utf-8?B?eWJlNnFLcUlmdW1ON25NNzJOVnp4VVRxQ3RZYkFUM1JjOWJ6c0ZsUG9Vblhl?=
 =?utf-8?B?dHFMS3hibVV2RDlWWFRRa0srdGRucHkvVVVCeGQrUFI4MEtOdHpzZkNjZ0J5?=
 =?utf-8?B?YXNvV1p1UU9lM3ZhTEh6S3RnSjh5dUFPUC94d28vT0tBSjU1ZTk1ODREMkpo?=
 =?utf-8?B?WlFKbkxQdnpJZjk5NUtPdEVCMmsxUHh1K0pNZ0VTWVJram81bndqRVk1Ujda?=
 =?utf-8?B?WTZvNFVPNXNOSmdJNHI1MDEvcEl3RkV5N3lRZGw2d29NbzMrTCtwVE1pOUE5?=
 =?utf-8?B?L01iVENYNDk0TWVCSno3Y1J6NUZVa0RRWlJlenFzVEdGK2NUdDlZNnFkL1ZM?=
 =?utf-8?B?RVg5d3d2bUxXNGNmUG9iSXI4ak9pMmloaXFMc3JtUTBicUcwVyt2ZjZid0xT?=
 =?utf-8?B?S1VEQjc3anhvdmNTeXBSajBDUldhc0h5U2NaS1BobzVJbXE2VXVOeDZvNzBk?=
 =?utf-8?B?ZkxyVzBEL2lhOFJnNzZMbERlbGErWWdwNVVtVjc0YTZCOCtDVU40TE5LcXFP?=
 =?utf-8?B?SDlJdHM2RkJpb3VBMFVuekl6bGtWUmpYYkxMTlZIOFVwaXg1UmMzd0xtZVN0?=
 =?utf-8?B?YzBKQTlWK005M3BtSHE4bElHMlF4WXN1dURaVXhGMnNIeVpQZ1ZsdmtDUkhw?=
 =?utf-8?B?dTYrNHh6U0xMOExVRUNCd0p2WXNpS1MwWk9SOVlGWnJWNVJjNTB5TXUzWm8z?=
 =?utf-8?B?aEU2T0hOZlZVc0lEY0R4MlhJQVU2blV1UElaOTNYdWV3RFlnWU9vRDQzWHRG?=
 =?utf-8?B?Z0xENzJxdlp4SnZQRTBoaGptRDZzem1sT3FPajIrUkNRWkN2VDE3ZGZXY0pk?=
 =?utf-8?B?L2xKV1pXSElnRWRqdW5VQ0dKNmRQdTVVb2ZGM0IvYnlMUEZIUVlSYkhOZTMz?=
 =?utf-8?B?TzMzUFRGdExWaUhrOCtwV0tUM3dCWUNvM1o0STVUU1dnLzVzNzZYQnJMUFow?=
 =?utf-8?Q?BvDBl1YODvg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REs5RXQwWTdLdHhxWk5RN1hjTjdvWUI5T0drdkpEVkpRclhVZ1pla2NIdkFy?=
 =?utf-8?B?WTNwVnRCL3pmZXk1T3J4azlRbVpUdXZBajRRTXA1QjdCZFNCdUtsTmRUQThU?=
 =?utf-8?B?Qk5vM1BRbzFXQVhoS1J5K01tNzcwbU1BNmI3WlFNcFg0OFV1bjhCelBTZEZJ?=
 =?utf-8?B?azRIeHRqUnhHTmMvb1Zrc0hoMi82Wi9pQ2JUWEh0NFMzZFlpU2puWU1yVWI1?=
 =?utf-8?B?KzduejVmL1dDaGlJWlNUazBHK2RwQngyMDE5L0xRTXR5NnYxb3kySW02SjU5?=
 =?utf-8?B?dUJCakF0TWl6SUhiU252RitRaDBYT1kvVFZYbm44VFhCYU04OUR3NUlFbDVY?=
 =?utf-8?B?NmVmNTVmY1EyWExPRjZLRkIvNG9JaG5La3ZaWFI3ZFdIME5lMEhNS01Cb0xO?=
 =?utf-8?B?WmgrUkIrVmw0QXFzRkRzUVByWC8xSXVhNCs5T3dzc2gyTm5qdWZrcVM4aHpS?=
 =?utf-8?B?c2hYMWx5bkdqMGFXRnhybTdkSUNVcnRIdGcxNGZDVHdpcUo0eHR4S2g3bXRn?=
 =?utf-8?B?Qyt2OXBiaGFlTlB5bk54bk1TK0ZBK3F0YVg0SmM5VEtLaTFSZGtkTzBQU2R4?=
 =?utf-8?B?S21hdFByRUp3N215SWRkUGRRaC9GdlRnbmphSDVOaDhuQU1pd0VYemxiUWh4?=
 =?utf-8?B?ditadG1CdTdiaVlwc3hiNC9UcTJ2cDd2TlVydnB2eFJ6R3FJcnFGTGltSUcr?=
 =?utf-8?B?TlJRNnQrNGhvYm15U2FVN3BzekNxQ2ZPeUFBRVREMDNRdWNySlRLUDZzWGFJ?=
 =?utf-8?B?V1ZLS1VxdDhCTmxxVlJGMVZ5RE0vdVJsUVRRUDhZNVNnNjlHQXBVbFBVQ3pQ?=
 =?utf-8?B?NDN5aG04ZUR5OXVUUUlwQ3YxVzNsajdWeHo4bVRYSFpFTUdSL1hHZzVXWWVU?=
 =?utf-8?B?NlhlQXFFK2lXYUpHT2NETWJlNERpN21QU0NoeGFFcjFHaDFTd3lCQkZiTjQ3?=
 =?utf-8?B?VmJpcUVoMTAxSjhXejREeXJMWjhEMFBqNlNBYW5OU3NmSXB0Wk1kNVYxYjQ2?=
 =?utf-8?B?bVlBTysvYUpwNkFHeSsrZlYwTXltZlFncTh5UkcvV09CamlWQXBKOXAwL0NU?=
 =?utf-8?B?bzUvQ3ZGY2k0ZHgxMmtmeFpwbEZDWjZiN0g2bHZWU2MxUEp3K2Rub3A4ZWM5?=
 =?utf-8?B?Y3REaWNVb1NxSHRTZ29tSFZLM1lMS2xLaElaSEtwT29pYUE1Rm81Y2JiYWxR?=
 =?utf-8?B?aWdqdUh3WlBjYTRJc213L25PcHQ5eTAveXNPSUl6WDR6RktsM3REQk1YckRP?=
 =?utf-8?B?Qmh5OG15TjliMDNTOVh5T25oMVBVeGlKajJ3amNpQzFzY09VREtPUUVGdHBR?=
 =?utf-8?B?Zmd3UEEwbXZIT0JOM2p1V1BzbHJmRWR3MTgvc2U1eDNoRFZIaG5xWE1lelVG?=
 =?utf-8?B?TmxsWnFGamdpVUozSUxpMi8ycnBGc0g1VGtGSkk4WFg4OW8zTGZEcGFXVUov?=
 =?utf-8?B?NkVwZ2prT1gzejBYTDFhSDZlUmxpUmt3UjNwSE8xS2J1cHVYY3lIQWFubzFZ?=
 =?utf-8?B?NDdaUlhFeG1SUlprakR3NzJPZVNFRU52aGZFbGRKWlZJRVBKZGljZ0NFZXRo?=
 =?utf-8?B?Tmx3NGlFcXBCYmdLakRaYWJucnVtcGUxUTFvU1IrcUNGbWZQYTFWMm04NURH?=
 =?utf-8?B?M0t6ekdOd3BsWm03WnRyZzlTeXIwbmRrV3h6cUxGWUNTeThMdzBSTnFiTFNh?=
 =?utf-8?B?bUZwakp3OFpCeW1oWEZVcGxXV1o3a3BJY1F2YnNOOEhscUNJcmpRVS9tWHpq?=
 =?utf-8?B?MzBMb2tZSmREeDN5b2Nsb0ZON2IwTmZPVklQTSs5OWNUY1BGQlhNZTh6RkM5?=
 =?utf-8?B?OGhORWxiTlJ3T3lkdGd0eEQ3SEhkeVpWK0d1cGtYb2VyRjlGSVQ4LzVSR2gy?=
 =?utf-8?B?NUtqSFZqc2dQNWFUclZHRWJMZVhtcXAyejVPR3NCZ2NENjN3SklEVFRLY2tE?=
 =?utf-8?B?a2dvVWhOM2k4SzFkUVBSWHBIRFZ1bVFuYmtxNDA0cFFWT1VjK1BUM1YrMVNY?=
 =?utf-8?B?V2lPRVNLS1lRWUlaQkJ0dzVLdmRWRCsza1VwVDZwOVpNQzQ5a3BPK2dyakpJ?=
 =?utf-8?B?L3h1Q3NnUXN4WXd1eXlPZi9SUjFzZE1GSERYNjUwbWhQVC9xZStGeEt3d1Zt?=
 =?utf-8?Q?jHKmo09qnBhYSeGei0wSwCxk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64d77bc-fb75-4813-ff8f-08ddd0757402
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 21:01:43.5649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWZEjmpAkwUjOxIzi6cQ4pTyMEHmklifKzWdbsY6y65ldf4x80Mg67FlIgsuzG4YM9B/EocWPISFZEu8v4jcQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
Received-SPF: permerror client-ip=2a01:111:f403:2415::62d;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Jul 16, 2025 at 11:54:27AM +0200, Luc Michel wrote:
> Update the list of supported devices in the Versal SoCs.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  docs/system/arm/xlnx-versal-virt.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index 2c63fbf519f..94c8bacf61a 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -21,15 +21,15 @@ The AMD Versal Virt board in QEMU is a model of a virtual board
>  (does not exist in reality) with a virtual Versal SoC without I/O
>  limitations. Currently, we support the following cores and devices:
>  
>  Implemented CPU cores:
>  
> -- 2 ACPUs (ARM Cortex-A72)
> +- 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
> +- 2 RCPUs (ARM Cortex-R5F) with their GICv2
>  
>  Implemented devices:
>  
> -- Interrupt controller (ARM GICv3)
>  - 2 UARTs (ARM PL011)
>  - An RTC (Versal built-in)
>  - 2 GEMs (Cadence MACB Ethernet MACs)
>  - 8 ADMA (Xilinx zDMA) channels
>  - 2 SD Controllers
> @@ -37,10 +37,13 @@ Implemented devices:
>  - XRAM (4MB of on chip Accelerator RAM)
>  - DDR memory
>  - BBRAM (36 bytes of Battery-backed RAM)
>  - eFUSE (3072 bytes of one-time field-programmable bit array)
>  - 2 CANFDs
> +- USB controller
> +- OSPI controller
> +- TRNG controller
>  
>  QEMU does not yet model any other devices, including the PL and the AI Engine.
>  
>  Other differences between the hardware and the QEMU model:
>  
> -- 
> 2.50.0
> 

