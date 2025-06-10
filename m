Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032D6C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxrP-0000c9-CM; Tue, 10 Jun 2025 08:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOxrI-0000bf-1i
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:13:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOxrC-0005HH-2t
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:13:39 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A5QcHS003503;
 Tue, 10 Jun 2025 05:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xvMCX9z22gq2FYoCB/4fn2Qdtrin8O4BjcuwWiYC/
 /I=; b=IGrN5Ts3mAOje+71jqXVhb8mHcA/4KlxO9z/eSrk7AY8853KPkFTSv/ka
 i1m4g0V5mS4V8yXQhxgvLOOX/YJn58Ijp01bES7U23UCR+rTyzTz8h0IvaoqGK/y
 MGIX88YW7MhatHzNq2XaJmhrgv1wtkGAgxhEVzPOj0UK572n3APCdWT32ejSIdiP
 tyDOB38zwJpw0QbAybwmfaanpP96Y6o3Xdc3LcOsg9QYiypaBIvo2IT+yEM+nOog
 EydVupdjvKOE/m7ElWIYVr6YG8prfyUAOLKrX7rhUNfE6gbeliqZln7ASF9LiEBv
 O77/83+RxDhcDECrwiJ80kcw8B3QA==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazon11021114.outbound.protection.outlook.com
 [40.93.199.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474sdgdugh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 05:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGaXmcnIq5fkwf/oKDG/a88yXQBEMkMGkbhlnmgHRZcAPLirmAxZs3H/63QAshuXg5Fo6nV26gmM8YKzuNYnhyymBZxtF1d2ulQARbseYzUKCgjft3j1k2W+TWlIQkl9AvCf4CemONutO65/Ut3qTqkPw1aEr5pcraqU2zBv4yK2N83aB3C3ffk+V1Q0RhtrAtXBl4pFUoRoGIkcjdptdfyaREbJT3Hca0XYVl9xx97KG3N+q7IbHW9fMMM5HAkoE9rWEZAAg5cGCN6Y4M+iGXbHWZGHdhI8t7ZBtNFLGFPhkVPakYl1Bh0SlbqF2fLLWlyXIILUzmHAfXk5eXioBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHkKBuFEa/a/kzfGoABOTo6El89tARYl5sa1k7QhjfU=;
 b=LPqtsCYsNnBzrDHagj5uRNnX5x/WV0NtCpJc9ioyIWCqWwk/pTR8sVbDc4ilDjyWVOD5aLL8OI9Oc2JYVRQef+DOnVbB6n1F1+NBmeFXC42TcOFTE/8AeaCHPJ2XB2A++bVR/V8fDtHYKdHnmXS8R1kU1FFiU+dBMpoCW69vxd2raTlr1SEg2TU09MAPICJVR8ZWNhgtYRsaprfbowl0yeKYfswP9x8B1QEOG9JoXramXMk4OU5Tg5am/KWGdtsPfHosQQU6t8PdPEC02GEiUGaN5LQ+eYrZPbHVUWJP19+gxoCJ7iyzOvuQWggMjHodPl/u5GCxTl6Mz5zWNpVcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHkKBuFEa/a/kzfGoABOTo6El89tARYl5sa1k7QhjfU=;
 b=eQDOPdwi2a04DMmDGagcKtOSdqplwdeoIq8L9Fp/QV+J5xMPZWUo2m9aoexwwt9lA+t7XVISpWv5bbGLVp/jRY6aJDi4jxbE+MvXEjAmVsiZoMqRfzWnopBDXxurtAAF9v9N6WEGKXWtSfs3LipBk+OGYlEYBc+hBFdsb5GTgxFYQVYApdgQx6xGhGrq2W9Xg37VzW5MjuSoCkBqzFU2Iw+JOBxnsNp/jQOMJ71NIkxvOiXi2Jy2mGXcTLJ4qESeilcUZs5KHz9VpJF9QXUez2fCgvh8bwUwgrUzJnBWwilE6R+sEMp0twt/ElgCAXkjZORborPRfNqPsmrpyAL4GQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8351.namprd02.prod.outlook.com (2603:10b6:806:1e6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Tue, 10 Jun
 2025 12:13:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 12:13:23 +0000
Date: Tue, 10 Jun 2025 05:13:20 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
Message-ID: <aEghYMUp2PYw2AAD@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
 <dfa38212-2f55-4097-b025-beafe11bb3d2@nutanix.com>
 <aEgWk5NvYg01GnUO@lent>
 <c1d90eb0-6077-4b43-b1f3-b04dc6551d23@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1d90eb0-6077-4b43-b1f3-b04dc6551d23@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0042.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: b445f40b-e869-45ee-2cf0-08dda8183287
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?UA1/FV6kspWUbbFMjzrd6gDI4YtojB+GjMGhaeWr0wSPPNAtGGVkDxZVLk?=
 =?iso-8859-1?Q?np9KwI7/YysbkHcQUG7LOcXNxA+k1Nkr3MWcPwyLxKFz20qbXrDxY4iyNN?=
 =?iso-8859-1?Q?Gnb0DFlCAOeSgbNtPh8Y+pmheaQSLgRWKDkSue5+ygGb9jzEMHBp9ThLua?=
 =?iso-8859-1?Q?ZX+LBQOvwM/+RfOaf8neEgdgAgMEcOFJ2T/zWTo8BuPbcLMxjIBMxG4oYZ?=
 =?iso-8859-1?Q?H4iUTFXNP9LPlk3SXH0sO5IgYA8BbmajOeeDHybXOGxpvg87+D/LakN7NA?=
 =?iso-8859-1?Q?k4YOk6UqEuu18JbLDA5ipi47J1SgCQvEaw9zJtaxthJQx8d7t3TP7y6d5l?=
 =?iso-8859-1?Q?DJr1TSFUY4Jl3cWMreQEapcspv77Gsdb8S+Y/v/G3/a69+CTXD50Q8fDb4?=
 =?iso-8859-1?Q?njwif9BMY919N+L0n2SxpY2em6cQJMx1foh6y1IT8wkzT71aS2IjnsEFj8?=
 =?iso-8859-1?Q?vT27nrhk1CRDe8MzydC1WlAGY3NkQgGRCjImRxteZq38Vtrl2Ansdmw5OR?=
 =?iso-8859-1?Q?SaoK2PTpkFeq+2/chV+G6bKI300AYLROHSO7PbSL+3wdSfrzMHj4MYSJ2X?=
 =?iso-8859-1?Q?y8SUY4KAFhuMDTetGPHUUdC9748tZjm+iqw+gJzK0DFoz3bvK/YeU8CjH0?=
 =?iso-8859-1?Q?mCBjdu8SCK0RC359gyIMVQTe8bsnGUstVJI9iistGwp0Ud1KZfRpd0oypR?=
 =?iso-8859-1?Q?IN58l4t9XY8UNmqUq47WRcWkihy2djNWkGpPsL9UGYAm1Fq9wu6DidWysG?=
 =?iso-8859-1?Q?Mr5y7gGccveezJXdSxPN5n9CLafCTqGkxGugKC6t2UgXBLLu+335cmoSfd?=
 =?iso-8859-1?Q?MMLMA1Js2FhVZoGZ2nLj2osYj0Ju55v4DTPe/gu2aL/OBuNTLCdxDarRbN?=
 =?iso-8859-1?Q?PZ5Jz4L+ooGVV7b1q+1OD207DPQHI+oNG6FMpbYKA2KSmmk9qvKtksePi1?=
 =?iso-8859-1?Q?45f11O2sFM3bZt+eVPJrI3eiEEGl7kjfJKy2biYHrlZd7xK5m+eU+H9bEg?=
 =?iso-8859-1?Q?Ij8vEinc6Scgmbr6a6WD4LrOh7MFP3ipBHpVM3CdKydbzlrfZs/cxarZNa?=
 =?iso-8859-1?Q?TuHdZAJ1BWMlQEx8xbUA6e6m3viYh+VKgSp6CcGo0DnU/JYuRIYQn1elYy?=
 =?iso-8859-1?Q?xHX3DhoHDVCiakCmRjrDWEzxpBbqJgu+FSr7aRkXh67z+uASVPCqjF8KKr?=
 =?iso-8859-1?Q?KepKV0G/V0mrbaFZTfi5Eygh3jFhsmLMkwY75YZGnPLnmKsYMDj2SCG8be?=
 =?iso-8859-1?Q?D0cFZAzNfbjAInldSX9Xr6tup9lWomU7gPGLfA9hxM8UFdtuhHfjeCYsBH?=
 =?iso-8859-1?Q?ibeqeiKwf9kp6xpnoAVc6YwIL2pAS9VCMEsf3SbL5hkFghgnTvdv7ok7Ak?=
 =?iso-8859-1?Q?O8CSS8SPEursans80beYd7lmh8a4j6Mv3Fs6Yh6gK5pHY5RJ8Rb1NCRILL?=
 =?iso-8859-1?Q?34a7FTN+Wfd2/NW8GPIIak/caafnj3aXfAE7tQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a+jfZ03tjH3+9cnEG+5qzcGjec2HNjHW855Cpwmh8x1VfOaRbBiwB+/jAS?=
 =?iso-8859-1?Q?SCxuqwHqIBcWmLdzIUjedi3wnZTTYflAI/pxLRrOHpYqhdTqnlw8NsE0Ur?=
 =?iso-8859-1?Q?8d0/TA3g1l5qsz11+lSgY12sleOpq95TNt+yaPqCN1ceFSHgeIy/koTl+O?=
 =?iso-8859-1?Q?61yAmnqinEUT/Qy1e2q7rIlQWIqQSxSr0U3W5Or22V0ePJ0kw7uLmWcyaQ?=
 =?iso-8859-1?Q?+wEqvFatNNEPli+xB8462WAdp+QZjP1DN2AYghdeKR+mL82QDeJOOW+lCs?=
 =?iso-8859-1?Q?J/EOLFmYRnk97v+Ew58cZdHJS71YXWl/g8UDpR23FGVgCsfPAd+226Fal+?=
 =?iso-8859-1?Q?k0kQSkYIxpT+D8d4mC05JArUPq2LU8CZ48frQDJrBCwBL4B6/rRew6eshw?=
 =?iso-8859-1?Q?HG9w4rwj2Evqh/XnljLh3iccDgFUlss1U8hy0+Bli/Ha7dmRjGGl3/cCWz?=
 =?iso-8859-1?Q?lqaZOnA07b9tm9s0xw5XzmGFRxV2IXG6lSnFOvg/haCBs5/WWWaPlIyvbl?=
 =?iso-8859-1?Q?N4tObCsJ1KNAJcrvKiM3k4uTqAh2AypqGGlgdXOsPp2I8ifE+86x6X+FOe?=
 =?iso-8859-1?Q?GORwfNBdvwTFMSLzzeNMmpPDgXYdy4UEP6JXninZUmWhI/RDEZdpx11gmv?=
 =?iso-8859-1?Q?MwivOYGN8DdOwraQp8fj/C4UqGs7l4XCS+TxpDL2zb7GXRCs2wIEIUwoiF?=
 =?iso-8859-1?Q?yL57bMwoLpL9eA+e6myhjZHaxtlRKZL2sbBQLr9bqvA06HCI/Muh+VOFa/?=
 =?iso-8859-1?Q?H5vvMHd/ecUAI+HMbfOfnWv/FmgLOMzTZOFWl9rLDTciKBUaYuGv73P/RX?=
 =?iso-8859-1?Q?w5Gc7KLpnr7ORxyB2ks2Tu+nOZYBpx0Dk8mib4zymoro7JES7tG23YjZza?=
 =?iso-8859-1?Q?H3aFqtcqj8RZMog6MihWsgS+IMStN9W2QxlM6zKPoePXhjDd87EUHwqR+L?=
 =?iso-8859-1?Q?mpS3qXPBDwpfBLETHYSd6Cn9GRQI+BXf+5U7gEk0kcRckdXSNfL55pT0kt?=
 =?iso-8859-1?Q?PAgNKYEfLh4/GJ2MtCpeuKaU24I/eDbs3oFugrJCgm6do282NaWhJf+hQB?=
 =?iso-8859-1?Q?X0XXK0jHj7TFE6yZDTRKKp4jWxzKaoQUfrvh1bVPB/PMJc1Xb2w0ED+f1b?=
 =?iso-8859-1?Q?fD+3EFLAIslXw5YUCvfrMHIXQQrVf0HBbs9RLcL1pCzvW0xTqcqI51ySp6?=
 =?iso-8859-1?Q?nwz7/EIUce1OYJQJr9rdDkN7GB5WBtn39uPCy2vd0wjY44JwOKtwnN3xUE?=
 =?iso-8859-1?Q?wq6xDoRfVZILoqJmjqXjoCVcRF87D1jK+eXQJKaH1gDo3y0rRYoRlEdTQj?=
 =?iso-8859-1?Q?E8zyjpzJ7CE4LNsY41QHaekWO92E7t5uTuWhmnVy+7UAA0zU6A8Nf2pQLc?=
 =?iso-8859-1?Q?wJ4jsT3Wg4rurMJlg/6BM6tmrf//Rx6kl4YCs0p9RngHPP0ayMB5rRqXzG?=
 =?iso-8859-1?Q?2KCV+6yG9y+COAgQ8AE1a2qNObdKnL0yoBt6107PktyOK+xOuByhjp/wXe?=
 =?iso-8859-1?Q?NcRP6kOB9HgdwHei8njU+RQLkc0C3/vE2ZA3j8ceHEWV16AzW96FCOV0nF?=
 =?iso-8859-1?Q?cXKd+i2M/eXbidGXloEg5MY/Oi28pMU7hSB8A5McW/nLXrNinZEW4O/h7C?=
 =?iso-8859-1?Q?WU/1VDgBK+H2v0VH7Xr8//zots1PL0WJhc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b445f40b-e869-45ee-2cf0-08dda8183287
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:13:23.8802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m3hMam15TwXRQAsvIGt+iZB3tji0LX4SzT4nVn8RG9t//9zHvILDIgpcL4D/nHU28oOrE/XwBpz81LQWBjrBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8351
X-Proofpoint-GUID: XHLnjvNOct9HwMhCHH3C-6XO7W_-sWFG
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=68482166 cx=c_pps
 a=F87Zho3t19+33hgggmDd9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=X2lp7Aib7Jb76k5qj1wA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: XHLnjvNOct9HwMhCHH3C-6XO7W_-sWFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5NSBTYWx0ZWRfXxPEDkatbl7Vx
 8pOCw/uK1FSJx3ykZH3W7Z/eh1epqThaXVQYeXomsnWU+pJGpxAPcjTarJcwKaJEuxjwU5gPbgw
 qO/br8Wuc9m4II7GRjAGR5DSjdiZKIEVvjUMr1hAnUn2Jypwfnu6xaZrIV4FJ4PlkeQep+JdV1p
 Gd/eM/ETSzbz8WXxmunn0vaPODuaOuMWgabE0nnjP0qkqG0htAMpjjUuC6FoxD2S8CA0jL+gdeE
 UqFjdGTl45phzYoHbW+/+Ki6Vfu1zDx8ZBX61NyIywn+ci06YItKXEanrlpwfyEgE54LTzC8Kdx
 gNIApIcBfF4WzVDmYw0OrPWHCJGgy+i0vhCefpxYaXXzeYmM0avhP28uu85HB8aKLGfEnCzakOd
 GKhyu9vHszfWhqxvxRNfOD6qNnnRsF4CWlmprb31uadsw8pd7LDOZ3bLwPp66bkPdI/BdY5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 01:57:23PM +0200, Cédric Le Goater wrote:

> On 6/10/25 13:27, John Levon wrote:
> > On Tue, Jun 10, 2025 at 11:58:18AM +0100, Mark Cave-Ayland wrote:
> > 
> > > > +        /* Use the per-region fd if set, or the shared fd. */
> > > > +        fd = region->vbasedev->region_fds ?
> > > > +             region->vbasedev->region_fds[region->nr] :
> > > > +             region->vbasedev->fd,
> > > > +
> > > 
> > > This feels a bit odd: if you're asking to map a VFIORegion then shouldn't
> > > that contain all the information required for the mapping, including the fd?
> > > 
> > > (goes and looks)
> > > 
> > > It appears that there is already a fd field in VFIORegion so is there a
> > > reason why we can't use this instead of adding region_fds to vbasedev?
> > 
> > region->fd was in earlier patchsets, but dropped as requested by Cédric. So we
> > must look it up here.
> 
> yes. It didn't seem necessary to store the same information under
> multiple structs.

And the reason we have ->region_fds at all rather than just storing directly in
region->fd is that vfio_device_get_region_info() doesn't take a VFIORegion
argument, as it's used in other contexts too.

regards
john

