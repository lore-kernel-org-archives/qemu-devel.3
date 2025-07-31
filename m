Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF9EC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaf8-0001wl-E0; Thu, 31 Jul 2025 17:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uha5H-0000rH-0k; Thu, 31 Jul 2025 16:41:03 -0400
Received: from mail-mw2nam12on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61f]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uha5D-0000FG-DH; Thu, 31 Jul 2025 16:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLb4nYNmnsqI5lJNXWy0a/ubCkWT0BYKt0AXDCo5jI8OhotKTM3OWGMtIM+B6qdAcSfaV7Zb1Xz7/L3dmtybswBctKNGHRb3RUC03sojEG+5pal4NqktlPkMikDJr5crlUuGGbZw+7i64yhgNsLnSEJMSQPP3JocaczlU5Y41eCH16DA58eEklKDZSJGL8Zg+r1tt8+B/fjew3+D0dWYbeYZeFgKPDdxJfOw0QjPyhn22B82xT1MrULLIoWGdsdYY+z/djQZA1hnO7DavAlAccrA6wAQI+WgS8qbaYlsBB32jTENiWSEV9fD7L3ggi37mwoEEq7HlkQJqr1nFOq7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMOSSdIu4PHxfrWLYJBDgpnT1jpukx+Du5TkFESUr08=;
 b=YK/UzB0QkF5XOFekV/Y2u7xk0J0qmUPWGEZ4TKEpfxo73UUZxEHYHqKyo+bsL5H9fpCKnvVRw6frJ/4eodHOO35Bt2GHyIveTzZSdMsrOP6zchaNowWXOZnnhfe+Jdsu2/P3dgdbCw0w4vxkQ9oivwVZEHiadVVa4uuNJqdKjLkzeDFsz3RhSYEsq1HZeKB2sCLYFAoe9fBXRxCeTgbuhj2XkUN42qbUA1rO8wliV1z/T/cpUv0AN4cd1wCuHNugBN3v6qPLEVdqOTSlOolSIouS6Z5zIlmGCaDVcVkvBMrZV9d0PjJeBfER/vCOGAbfBCCyRcpE7KA1UdyKNNdzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMOSSdIu4PHxfrWLYJBDgpnT1jpukx+Du5TkFESUr08=;
 b=eocJwIbR8XEdX20aYx2ppBRmq5AJRW0XDpCEcac+P72B3issPeUv8y8aqX4UAt5025uGbwJSx+8Pg7bpFdOSUEGZNoRE9Kfc3cw/gIYOD5w082OPSPOyXSyXQlKvwmBFp1+QBY7bah5b9+Kgz1gVnxbAd9cwLna11IYRdPz5PrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 20:40:52 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 20:40:52 +0000
Date: Thu, 31 Jul 2025 22:40:38 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 41/48] hw/arm/xlnx-versal: add versal2 SoC
Message-ID: <aIvUxmtjNiE1r2RW@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-42-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-42-luc.michel@amd.com>
X-ClientProxiedBy: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 891ccfbb-642b-445d-eece-08ddd07289fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azZCaGNLWjRQTTY2c3N3bmkvVFEwaFpWTU5ycE9ja2xTZkI5RWdvNWwwOXUx?=
 =?utf-8?B?NVR4dmdIWmVJblZ1dUhTbkEzMVF5NTJJS2ExMEVwd3F4dUJaWGtHTnQ2alFl?=
 =?utf-8?B?dXFMc2hvbGtVK1d2SDFPUnhLbVNGeUdENlpaNE5zdUs1MlFrVGlVYlBpaEw2?=
 =?utf-8?B?Ny9MbW53Y3Z4MERGNTNYZmRwSFZ4Wm92TzlsWG4zcXo5OTlpbUVTMVI1WTFV?=
 =?utf-8?B?WXdTYVIrMjhDdkRJZmh2b0NFVFRCdFZYQjVyY285KzcvM3ZnY0RMYTJuMjl4?=
 =?utf-8?B?eStkZHJpL3Zxc1Y5eDJKcDJGZkNRSng5cDRYcEdlaXIwSUdEVCtjbWtINFZV?=
 =?utf-8?B?Qk1BNlhldG45aDZlMExLRnkxWVZqcUVnSDFLWDZaYzd5ajVUZFFsdThsMnJL?=
 =?utf-8?B?NUZBZk1HTk1weGtlMmx5N0crSTJWbng0Rnl6K0x0NTIwTU1wYmVxS2J2eHRM?=
 =?utf-8?B?TDR1YzNhVFhZOVZjaWEwZktyd2x6b0ZEZll1bi9jWURiWjdWZ2JMU2lCRTdT?=
 =?utf-8?B?QWRtbHpLSVZ1SWlxVktuVzVCUWxkdk1qOEJIUGMzMldiVUJNUGlnOVExV05y?=
 =?utf-8?B?OU5zbmc0RUM4bVArNXJMTHVLVmJwQWpvajVDK2xaa2dIb1JienhiWTQ1U2Zq?=
 =?utf-8?B?RWpjb3lBLzZXMVB2OHh4TVhNWG5DeTA1S3NCdGM1Ym8wbTY5MzFjbytITnFw?=
 =?utf-8?B?dkVzNDJ6QUgwb0VLbG9MUUh1aEd3bU16bXNSN0lxZ0JkVUVoY2duaEtxRytZ?=
 =?utf-8?B?elJPOXM4YlhLejBDMVlpU1ArVzJmbXFRVTJyZG9HekJSV2VwUlVHdFRpcjA2?=
 =?utf-8?B?Q3dYbXVsTCt6QkFseE9FaklqcWZXKzhPUkxIc2xVa1UxSi9PNG1Xaml0RVBU?=
 =?utf-8?B?aTdkWjRYb0NZSmIvUXBVaE55QmpjZ0M1U1hreVh3SjhWUXM1aVB1bVNGa2tN?=
 =?utf-8?B?M2JIN1JuZVdJUTZNNldLcHdISVdyUDdVdVFYT281V3lSQ2JBbzVjMkVFaVp2?=
 =?utf-8?B?YktqQnUxYjFaWmxqSi9WamIwVkFxUmQ5VWluNjhxRkJVL2tFalJvTzYvdXZu?=
 =?utf-8?B?QXFZY1pJVHkrQ3ZFekd5dFFjT1B4eEFzTndrTW1lL2NRR25VQUo3NzFNS0ZT?=
 =?utf-8?B?b0NibUJURnpHcTVRMWdtMHVhUWZUeThIRVk0MllhaUZGUjdUQjJDUEs4Zm4x?=
 =?utf-8?B?YmxWeUlOM0lHY1dQam1QdGU5K0g4R25wYTNpN2JqVUFETHJNRk9WbTl0bUg0?=
 =?utf-8?B?eWJ6Yy9UbGxXNTA2QTJFMXMxSHRRM0ZJaUhuRWluemFLRW1iY3ZOSjUyMlYv?=
 =?utf-8?B?cUdpTURWOUMxQmRKaCtOUFl3YitEMWwvZk55VCthbkEwcjhwWTdiOVRKWFJO?=
 =?utf-8?B?TE5TdnFUblJyeW1MaFIzdDZVNXovWmNKdGpBMXB3R0wxN09Zb3hreHR6M1B1?=
 =?utf-8?B?TVI4bDVpZkNmbDBsOVVMWk1iRGFvd1A5SjRCN2VQSkNOY0w0Mjlxb05oaGcr?=
 =?utf-8?B?WTJDYjFKeDRjc1dRaUhsZGp4Z25Xc2hKYnNpSE8zZjBnaW9IVWJqeVd3dDhD?=
 =?utf-8?B?M3dtcENoVDBSTkcwclFPNnhsMXEyZjhHbVozSDhSUGlzZnhiYUJrRTU3eGt1?=
 =?utf-8?B?MDM1SnlUckpJOEdJQ3pjNDdhUDE1Z1h1bmpHT05QZTNaQ0R5bGsxUmRxWWkv?=
 =?utf-8?B?RjQyWlhoT3AyUGJ1SVN3cGpFZUpYNHlkb3duN1ZqR3FZZUIwVmZnQjVyd1Ur?=
 =?utf-8?B?RkVJcVVZcTNucVVNbmovZW1HUEg5emJCSEZEaHpIZkU2aFhlaUJCUnZzbjdh?=
 =?utf-8?B?ZldkbStnY0dnR3hXWHVvcktQbThaeHNVLzNsQ2tRemsyaE5YOXpNNGRkZnlT?=
 =?utf-8?B?SEoyNHhWODlJWnp5aFJOY0oybTNMNm9KakM0S3UrN2NtZnRJY0pjNy9NL2xK?=
 =?utf-8?Q?hm76EJVHT+w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFMwZE5qdVR1SFVjZ0dPZkpnSktlWHZFTTNtcW1vdTJTZDZ4eXJLOXQ0dzFr?=
 =?utf-8?B?SzZnZHlRUWk4UHdsdlRCZVBYWDlZbzl2clhISkg0STFBMmtEVDJKZUtnUTRX?=
 =?utf-8?B?TkNOemswZFVuNmJVTDFSMTgyRENCS1pUZ3k5bWlCSlZXTVR3UGtxV2d6UEJX?=
 =?utf-8?B?emUzK1lyMTduVkc2eVAzbzY1cGZWN3pLak85S3h2eWpoVlpwcDkyRy9KcERM?=
 =?utf-8?B?NHJYdmx4NlIvTGJua09Nck9UdzAyMVZUR1ZTRXo5clhzSVBKUmZGdFRHeVFI?=
 =?utf-8?B?N3lEclR1cTJCZ1V2WXpzalhlUkQwVzZOaWNrWkwwQlVTckl5Y0xVbEpzbGlL?=
 =?utf-8?B?ejBMU0RUc1FrandUckxnVENUYmFUMWtVRGtVR1R5aTRnYU5rVE5JMEc4TUdT?=
 =?utf-8?B?dER6NmtRbVpLWW1rS2doZ29iRjgwTm9pcWpRTTlET2p0Q2pZN3E5YmZIdk1R?=
 =?utf-8?B?OUtXSFpScEVJbFlQOGY2NHhSeGpiczJzdEgrOFFUaTF1bVJXbWNIZTMvZytO?=
 =?utf-8?B?Q1hRcERtWTdza0dnNldTenkxaWVlRHRFbHdQdGk4Qm9aWWpqN05FRGtDZ3Jw?=
 =?utf-8?B?bzRmMTJlS2RjS1B4Q2ovelVYOXFCcXhZQWV1L0FWQ21YYnZETys5dnpiS0dm?=
 =?utf-8?B?bjEvSThmd3k1SytKdC9pSlRVRDJLV3RXMlR1L0JtWmhOUVgzMS85QWk5WUdt?=
 =?utf-8?B?TWpyNkNaSXhNa2J4Y3hhd2VZa0RrbEV6MjIxdXRzUEtqMW8ySVhubUsvRzZX?=
 =?utf-8?B?ZGF5d1dBQ2hqaTYwQWhMYVVGYklsckk4akVrQUhCSXBLNFkzWTVpbzlwN2RT?=
 =?utf-8?B?ZTBoQW9FV0hsMVdQemsyd2dmQzI3TXFiZFErcStlUml0VVZOMFRMN2ZUR2Uz?=
 =?utf-8?B?dUI4N2d2WFgxVjNadDNyY0grWjFrNm1iTWp0OWxlcFdVcTFyNjZZOUNtWWhL?=
 =?utf-8?B?dXV2VEVzREhXR0FEYVZ2Y1BnTVp4UUY2L293RnRnMXk3anRDTTFldGpSQW50?=
 =?utf-8?B?ZHBLY00vVXFYSDlnVnpBSW9yZ0FoUG5xVlBqMm9Nd1VuVUtTbWU3bmJ6dWJH?=
 =?utf-8?B?UGRya2k4Vjh5WFdqRUNpSHVXNHJ0S2JsZ1BCRldZZWFvQjM5QnVPS1R3SzlQ?=
 =?utf-8?B?R1dXRVVnYWRoUlp1aXE3L2lJSm8rbHE2MkltZUhYR0pmVThQRERwRnQySUEx?=
 =?utf-8?B?RjFZei9MK1JXUWtxSXZCc1N6VnJpNWlGeUJOTFpqQ3B2RGtScGJGQlk4OWVv?=
 =?utf-8?B?NmFxMUdxTm4yemtobFJPMlp3b3BuSG1qQnphTnRsQzB0dHhtUyt3WFowTnNW?=
 =?utf-8?B?Z2NqZW9vV3grdUpzZ2dhcFpNbSsvZFJEamJkejlLNGRVd3lzd3YxSnFvQ3My?=
 =?utf-8?B?akJKc0xmV3RLRGF5cnNZMzhUSHU0TXpGbDRjVFdocG1sVDArYng0SmR0Ym5r?=
 =?utf-8?B?UnB3V2k3UmFNM1RydnVnWkUvR3RaamtranlHWWlyaWlyemZNYjB5cktuOVpK?=
 =?utf-8?B?RTlzeUtEbWltTk5HQkRNSFhsQURyVHluOC9nT3JoVnlpcjB0SWRVMEhBeFNl?=
 =?utf-8?B?UkphSWYvU1BPTlZmVURTTTBQbHhBYm45TVlycHgrUEtxZ1poYmxNZURiR09j?=
 =?utf-8?B?NzRoOVgzbEVsR3dJOTVUKzQ4aVlBc3lSclMwazZSajJjUEg0SG9vRmFsemNz?=
 =?utf-8?B?RFVneEI5dU9WNnBGMW1GZUg3MlpVbnV2Tm9mNGFoWFBwbzVCVDBmajF6ZFJs?=
 =?utf-8?B?N3FUUXppSndGWFRSWHgzOFN6ZUxsWkRqeE1JQVhxWHFsdnJHRjVGT244eDRL?=
 =?utf-8?B?bTY0dE8xZEVZK3MrdEFnNlR2eTBRdGxsaVcwajRIcnQ3MFhvdHRrMUEvMUZG?=
 =?utf-8?B?b3NXQmt4Y3BMZjloTEdOUTh5OCttS2U4MmRITmxXM0E4S2JVZWVyeUJKK0dl?=
 =?utf-8?B?MFUxdmg2RjU2eS9nTkUzWFIvTDkvMnBOVVpPcWlNQXI3ZUxEZzUzNGxsRUZL?=
 =?utf-8?B?aWt1MFQwZE82Ym8ydmw4OEdSeHdPQXdmMmk3Vjk5b2kvVWV4b2x3akJKcjZt?=
 =?utf-8?B?WExwcVk1enF4RUlPUnJhY0JoeFBPdytNUzdzdUVpUEttRG01b1l0cmFQNUh4?=
 =?utf-8?Q?gfyHGlHDb+PvPWdWUBp4ElSo5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891ccfbb-642b-445d-eece-08ddd07289fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 20:40:51.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQCraIANs0rZ9QfneGaxdrptLLpy/hL0/jNSffCtDWBCvH+cf3fga/jNGWpS5xNmXHsG2XAEaK8UMoZS+LBFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
Received-SPF: permerror client-ip=2a01:111:f403:200a::61f;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:23AM +0200, Luc Michel wrote:
> Add the Versal Gen 2 (versal2) version of the Versal SoC family.
> This version embeds up to 8 Cortex-A78AE cores (split into 4 clusters)
> and 10 Cortex-R52 cores (split into 5 clusters). The similarities
> between versal and versal2 in term of architecture allow to reuse the
> VersalMap structure to almost fully describe the implemented parts of
> versal2.
> 
> The versal2 eFuse device differs quite a lot from the versal one and is
> left as future work.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  17 ++-
>  hw/arm/xlnx-versal.c         | 212 ++++++++++++++++++++++++++++++++---
>  2 files changed, 214 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index bdfab2a5426..1d216b5dbf1 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -1,7 +1,7 @@
>  /*
> - * Model of the Xilinx Versal
> + * AMD/Xilinx Versal family SoC model.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
>   * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
> @@ -20,10 +20,11 @@
>  
>  #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
>  OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
> +#define TYPE_XLNX_VERSAL2 "xlnx-versal2"
>  
>  struct Versal {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
> @@ -69,6 +70,20 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s);
>  
>  int versal_get_num_cpu(VersalVersion version);
>  int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
>  
> +static inline const char *versal_get_class(VersalVersion version)
> +{
> +    switch (version) {
> +    case VERSAL_VER_VERSAL:
> +        return TYPE_XLNX_VERSAL;
> +
> +    case VERSAL_VER_VERSAL2:
> +        return TYPE_XLNX_VERSAL2;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  #endif
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 551671af425..52a68e356b0 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -1,7 +1,7 @@
>  /*
> - * Xilinx Versal SoC model.
> + * AMD/Xilinx Versal family SoC model.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
>   * Copyright (c) 2025 Advanced Micro Devices, Inc.
>   * Written by Edgar E. Iglesias
>   *
> @@ -353,12 +353,133 @@ static const VersalMap VERSAL_MAP = {
>      .crl = { 0xff5e0000, 10 },
>  
>      .reserved = { 0xa0000000, 111, 8 },
>  };
>  
> +static const VersalMap VERSAL2_MAP = {
> +    .ocm = {
> +        .addr = 0xbbe00000,
> +        .size = 2 * MiB,
> +    },
> +
> +    .ddr = {
> +        .chan[0] = { .addr = 0x0, .size = 2046 * MiB },
> +        .chan[1] = { .addr = 0x800000000ull, .size = 32 * GiB },
> +        .chan[2] = { .addr = 0xc00000000ull, .size = 256 * GiB },
> +        .chan[3] = { .addr = 0x10000000000ull, .size = 734 * GiB },
> +        .num_chan = 4,
> +    },
> +
> +    .apu = {
> +        .name = "apu",
> +        .cpu_model = ARM_CPU_TYPE_NAME("cortex-a78ae"),
> +        .num_cluster = 4,
> +        .num_core = 2,
> +        .qemu_cluster_id = 0,
> +        .mp_affinity = {
> +            .base = 0x0, /* TODO: the MT bit should be set */
> +            .core_mask = 0xff,
> +            .core_shift = 8,
> +            .cluster_mask = 0xff,
> +            .cluster_shift = 16,
> +        },
> +        .start_powered_off = SPO_SECONDARIES,
> +        .dtb_expose = true,
> +        .gic = {
> +            .version = 3,
> +            .dist = 0xe2000000,
> +            .redist = 0xe2060000,
> +            .num_irq = 544,
> +            .has_its = true,
> +            .its = 0xe2040000,
> +        },
> +    },
> +
> +    .rpu = {
> +        .name = "rpu",
> +        .cpu_model = ARM_CPU_TYPE_NAME("cortex-r52"),
> +        .num_cluster = 5,
> +        .num_core = 2,
> +        .qemu_cluster_id = 1,
> +        .mp_affinity = {
> +            .base = 0x0,
> +            .core_mask = 0xff,
> +            .core_shift = 0,
> +            .cluster_mask = 0xff,
> +            .cluster_shift = 8,
> +        },
> +        .start_powered_off = SPO_ALL,
> +        .dtb_expose = false,
> +        .per_cluster_gic = true,
> +        .gic = {
> +            .version = 3,
> +            .dist = 0x0,
> +            .redist = 0x100000,
> +            .num_irq = 288,
> +        },
> +    },
> +
> +    .uart[0] = { 0xf1920000, 25 },
> +    .uart[1] = { 0xf1930000, 26 },
> +    .num_uart = 2,
> +
> +    .canfd[0] = { 0xf19e0000, 27 },
> +    .canfd[1] = { 0xf19f0000, 28 },
> +    .canfd[2] = { 0xf1a00000, 95 },
> +    .canfd[3] = { 0xf1a10000, 96 },
> +    .num_canfd = 4,
> +
> +    .gem[0] = { { 0xf1a60000, 39 }, 2, "rgmii-id", 1000 },
> +    .gem[1] = { { 0xf1a70000, 41 }, 2, "rgmii-id", 1000 },
> +    .gem[2] = { { 0xed920000, 164 }, 4, "usxgmii", 10000 }, /* MMI 10Gb GEM */
> +    .num_gem = 3,
> +
> +    .zdma[0] = { "adma", { 0xebd00000, 72 }, 8, 0x10000, 1 },
> +    .zdma[1] = { "sdma", { 0xebd80000, 112 }, 8, 0x10000, 1 },
> +    .num_zdma = 2,
> +
> +    .usb[0] = { .xhci = 0xf1b00000, .ctrl = 0xf1ee0000, .irq = 29 },
> +    .usb[1] = { .xhci = 0xf1c00000, .ctrl = 0xf1ef0000, .irq = 34 },
> +    .num_usb = 2,
> +
> +    .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 230 },
> +
> +    .ospi = {
> +        .ctrl = 0xf1010000,
> +        .dac = 0xc0000000, .dac_sz = 0x20000000,
> +        .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
> +        .irq = 216,
> +    },
> +
> +    .sdhci[0] = { 0xf1040000, 218 },
> +    .sdhci[1] = { 0xf1050000, 220 }, /* eMMC */
> +    .num_sdhci = 2,
> +
> +    .pmc_iou_slcr = { 0xf1060000, 222 },
> +    .bbram = { 0xf11f0000, PPU1_OR_IRQ(18, 0) },
> +    .crl = { 0xeb5e0000 },
> +    .trng = { 0xf1230000, 233 },
> +    .rtc = {
> +        { 0xf12a0000, PPU1_OR_IRQ(18, 1) },
> +        .alarm_irq = 200, .second_irq = 201
> +    },
> +
> +    .cfu = {
> +        .cframe_base = 0xf12d0000, .cframe_stride = 0x1000,
> +        .cframe_bcast_reg = 0xf12ee000, .cframe_bcast_fdri = 0xf12ef000,
> +        .cfu_apb = 0xf12b0000, .cfu_sfr = 0xf12c1000,
> +        .cfu_stream = 0xf12c0000, .cfu_stream_2 = 0xf1f80000,
> +        .cfu_fdro = 0xf12c2000,
> +        .cfu_apb_irq = 235, .cframe_irq = EAM_IRQ(7),
> +    },
> +
> +    .reserved = { 0xf5e00000, 270, 8 },
> +};
> +
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
> +    [VERSAL_VER_VERSAL2] = &VERSAL2_MAP,
>  };
>  
>  static inline VersalVersion versal_get_version(Versal *s)
>  {
>      return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
> @@ -1291,10 +1412,15 @@ static void versal_create_efuse(Versal *s,
>  {
>      DeviceState *bits;
>      DeviceState *ctrl;
>      DeviceState *cache;
>  
> +    if (versal_get_version(s) != VERSAL_VER_VERSAL) {
> +        /* TODO for versal2 */
> +        return;
> +    }
> +
>      ctrl = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CTRL);
>      cache = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CACHE);
>      bits = qdev_new(TYPE_XLNX_EFUSE);
>  
>      qdev_prop_set_uint32(bits, "efuse-nr", 3);
> @@ -1542,34 +1668,47 @@ static inline void crl_connect_dev_by_name(Versal *s, Object *crl,
>  }
>  
>  static inline void versal_create_crl(Versal *s)
>  {
>      const VersalMap *map;
> +    VersalVersion ver;
>      const char *crl_class;
>      DeviceState *dev;
> +    size_t num_gem;
>      Object *obj;
>  
>      map = versal_get_map(s);
> +    ver = versal_get_version(s);
>  
> -    crl_class = TYPE_XLNX_VERSAL_CRL;
> +    crl_class = xlnx_versal_crl_class_name(ver);
>      dev = qdev_new(crl_class);
>      obj = OBJECT(dev);
>      object_property_add_child(OBJECT(s), "crl", obj);
>  
> +    /*
> +     * The 3rd GEM controller on versal2 is in the MMI subsystem.
> +     * Its reset line is not connected to the CRL. Consider only the first two
> +     * ones.
> +     */
> +    num_gem = ver == VERSAL_VER_VERSAL2 ? 2 : map->num_gem;
> +
>      crl_connect_dev_by_name(s, obj, "rpu-cluster/rpu",
>                              map->rpu.num_cluster * map->rpu.num_core);
>      crl_connect_dev_by_name(s, obj, map->zdma[0].name, map->zdma[0].num_chan);
>      crl_connect_dev_by_name(s, obj, "uart", map->num_uart);
> -    crl_connect_dev_by_name(s, obj, "gem", map->num_gem);
> +    crl_connect_dev_by_name(s, obj, "gem", num_gem);
>      crl_connect_dev_by_name(s, obj, "usb", map->num_usb);
>  
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
>  
>      memory_region_add_subregion(&s->mr_ps, map->crl.addr,
>                                  sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>  
> -    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
> +    if (ver == VERSAL_VER_VERSAL) {
> +        /* CRL IRQ line has been removed in versal2 */
> +        versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
> +    }
>  }
>  
>  /*
>   * This takes the board allocated linear DDR memory and creates aliases
>   * for each split DDR range/aperture on the Versal address map.
> @@ -1657,21 +1796,16 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
>      qemu_log_mask(LOG_UNIMP,
>                    "PMC SLCR parity interrupt behaviour "
>                    "is not yet implemented\n");
>  }
>  
> -static void versal_unimp(Versal *s)
> +static void versal_unimp_common(Versal *s)
>  {
>      DeviceState *slcr;
>      qemu_irq gpio_in;
>  
> -    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
> -    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
> -    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
>      versal_unimp_area(s, "crp", &s->mr_ps, 0xf1260000, 0x10000);
> -    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
> -    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps, 0xff140000, 0x10000);
>  
>      qdev_init_gpio_in_named(DEVICE(s), versal_unimp_sd_emmc_sel,
>                              "sd-emmc-sel-dummy", 2);
>      qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
>                              "qspi-ospi-mux-sel-dummy", 1);
> @@ -1690,10 +1824,29 @@ static void versal_unimp(Versal *s)
>  
>      gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
>      qdev_connect_gpio_out_named(slcr, SYSBUS_DEVICE_GPIO_IRQ, 0, gpio_in);
>  }
>  
> +static void versal_unimp(Versal *s)
> +{
> +    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
> +    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
> +    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
> +    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
> +    versal_unimp_area(s, "iou-scntr-secure", &s->mr_ps, 0xff140000, 0x10000);
> +
> +    versal_unimp_common(s);
> +}
> +
> +static void versal2_unimp(Versal *s)
> +{
> +    versal_unimp_area(s, "fpd-systmr-ctrl", &s->mr_ps, 0xec920000, 0x1000);
> +    versal_unimp_area(s, "crf", &s->mr_ps, 0xec200000, 0x100000);
> +
> +    versal_unimp_common(s);
> +}
> +
>  static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>                                   unsigned int freq_hz)
>  {
>      uint32_t phandle;
>  
> @@ -1707,13 +1860,12 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>      qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
>  
>      return phandle;
>  }
>  
> -static void versal_realize(DeviceState *dev, Error **errp)
> +static void versal_realize_common(Versal *s)
>  {
> -    Versal *s = XLNX_VERSAL_BASE(dev);
>      DeviceState *slcr, *ospi;
>      MemoryRegion *ocm;
>      Object *container;
>      const VersalMap *map = versal_get_map(s);
>      size_t i;
> @@ -1782,18 +1934,33 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_rtc(s, &map->rtc);
>      versal_create_cfu(s, &map->cfu);
>      versal_create_crl(s);
>  
>      versal_map_ddr(s, &map->ddr);
> -    versal_unimp(s);
>  
>      /* Create the On Chip Memory (OCM).  */
>      ocm = g_new(MemoryRegion, 1);
>      memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
>      memory_region_add_subregion_overlap(&s->mr_ps, map->ocm.addr, ocm, 0);
>  }
>  
> +static void versal_realize(DeviceState *dev, Error **errp)
> +{
> +    Versal *s = XLNX_VERSAL_BASE(dev);
> +
> +    versal_realize_common(s);
> +    versal_unimp(s);
> +}
> +
> +static void versal2_realize(DeviceState *dev, Error **errp)
> +{
> +    Versal *s = XLNX_VERSAL_BASE(dev);
> +
> +    versal_realize_common(s);
> +    versal2_unimp(s);
> +}
> +
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
>  {
>      DeviceState *sdhci, *card;
>  
>      sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
> @@ -1925,20 +2092,30 @@ static const Property versal_properties[] = {
>  
>  static void versal_base_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    dc->realize = versal_realize;
>      device_class_set_props(dc, versal_properties);
>      /* No VMSD since we haven't got any top-level SoC state to save.  */
>  }
>  
>  static void versal_class_init(ObjectClass *klass, const void *data)
>  {
>      VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      vc->version = VERSAL_VER_VERSAL;
> +    dc->realize = versal_realize;
> +}
> +
> +static void versal2_class_init(ObjectClass *klass, const void *data)
> +{
> +    VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    vc->version = VERSAL_VER_VERSAL2;
> +    dc->realize = versal2_realize;
>  }
>  
>  static const TypeInfo versal_base_info = {
>      .name = TYPE_XLNX_VERSAL_BASE,
>      .parent = TYPE_SYS_BUS_DEVICE,
> @@ -1953,12 +2130,19 @@ static const TypeInfo versal_info = {
>      .name = TYPE_XLNX_VERSAL,
>      .parent = TYPE_XLNX_VERSAL_BASE,
>      .class_init = versal_class_init,
>  };
>  
> +static const TypeInfo versal2_info = {
> +    .name = TYPE_XLNX_VERSAL2,
> +    .parent = TYPE_XLNX_VERSAL_BASE,
> +    .class_init = versal2_class_init,
> +};
> +
>  static void versal_register_types(void)
>  {
>      type_register_static(&versal_base_info);
>      type_register_static(&versal_info);
> +    type_register_static(&versal2_info);
>  }
>  
>  type_init(versal_register_types);
> -- 
> 2.50.0
> 

