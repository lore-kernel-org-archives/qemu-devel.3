Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8370ECA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTtN-0002Ru-St; Tue, 02 Sep 2025 12:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utTtL-0002Q7-5i; Tue, 02 Sep 2025 12:29:55 -0400
Received: from mail-northeuropeazon11010048.outbound.protection.outlook.com
 ([52.101.84.48] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utTtI-000745-BM; Tue, 02 Sep 2025 12:29:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0ElOvDdhbPvmjvTAt6pmOCkoqXfp/gmBNSFUm7CXo8V6Mox56tqlyy7hqoEHN6ww4n3v5mzuR+tc0ynjNUjUcLmedIIa4kAq7ng89rZpd22nClopgtTLaDtVoo+0GddGbA9zzrs8y7JzncaixCfh074r6vH7qcjMdWfLhvsN7rSkPFdj7BPrcPCosYaDcehVjPtNmV0eX4ZW4MrD5+VIypMyzyVDjpauBhzYNN+4uNgFYMoRD3iSKV0GHAfjDnT/gTvfAc+QToqqZEPikIgmP8iD6wAnq1FqzVqGQMnRXfK+EAttY8c+v4zqHI6v4YaiRH82kQtOyYqKGyQlrqofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trCGrI7wla41Y1yuFDqCJRfKpvUrzHHOWllowVC48QU=;
 b=yolKQr9PLBFWVWz0TgtWAreUOJw1DgEIglXpzgGfMvMmB9FTlDFfZYFQxc3GlkhZNL1XJkQmIqQrDNHXd+Za6QVl5TSLJ7lB0ihzlrKDstUvFSUXUXd1HzeOpsZ7nveo1bXPgzSGln4tD7HEPSYWdLEUhtQdUDqBc5BMFzt+GDNHDq702NPHeBXkkHw64gewu+qCSD7sy+jfQm0wQLpQVrkfcfh32aLF5NPzw6p41MSt4La6LLa8lssI2fZPMGXAkuM6w+dcuvmlcynGJ8sHEntXob4Kk7j/mi0R6I/YroOVRsvzlCHx54ZRC1gDiqJaFZae0T0KIK0lOa74jaJoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trCGrI7wla41Y1yuFDqCJRfKpvUrzHHOWllowVC48QU=;
 b=PMuy9QRNgl/AdiwZHS/OERYkT2oWeV2lcL9HgPU/1r8GWVt22Mk5HiyelZOska4wJvqptVcuwAVidx58M2O2BfXuXxwsNcmcooUtMQauJnBqkcxq70cNU/iW4sTS9NOFvPDiJGUipj9lgbom6wheBD3lIo/dUFKyy7Wgo7CFLhCHwIBHJx8VTJVuOSbqj2IcYV12mXaKu/SGX/pzh/TCKppmEYmpaqYFzP+dNboJwmDivuFPoIGwDSbISKJAR/DR2AVUXKjuIovbcnRKtg0ss2mFS2vohW0fMYbrowjw4I0hG3RZHqI7zKir/+WyszrrNa1bnxQG1Fp5bFpVgMp89A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU2PR10MB7693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:492::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 16:24:42 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 16:24:42 +0000
Message-ID: <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
Date: Tue, 2 Sep 2025 18:24:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?SmFuIEzDvGJiZSI=?=
 <jlu@pengutronix.de>, Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:4e::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU2PR10MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f29b682-d9fb-45a2-02af-08ddea3d38b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTd3U29iUzZnaG1Ed3c0UEY5YTVyVmV0WjdSL3dMb284Y3dTTzNvWk0ycXlW?=
 =?utf-8?B?dlM5WGVzM2JHOUdPelg5emhwbWlKeU5GcjAyOUw0emlUZHRxcEhFanMvWGxW?=
 =?utf-8?B?amRWelNLRlA2aDJuSCsxbjhtS0k2c1ZGZHpmRHlwU2YvZ1piaFR6YnFDajUx?=
 =?utf-8?B?Q1V2OWdiM1liMWtyR0JSZFdoc3cyTTBSbldqc2QrTFhkWW16Wkw3aWxWZmIw?=
 =?utf-8?B?OFMwMmZYKytjT2NPUk5TVDR3ZUQ1MU50cUNReks5V1l2L211UlhDZWZ5enk3?=
 =?utf-8?B?aTdTZFZmekZGKy84d2xtdXZ5YkFFV1F2eE84ZmxTeGNWaHhmLzJRZit3ckt5?=
 =?utf-8?B?YkZtTm9uTk5LbG0zTElheTIzUkEvRmpoSzlva3pYTTUydTdTcW1Oam1pZWZU?=
 =?utf-8?B?RFBldHlNeUsrVVFMRzFCQnNPTVQxZ2s1dVlTcEJpSDZsZjM2VjZnUXhQQ3Uy?=
 =?utf-8?B?bE9QL1dWMHY4QlA3cGNpM2hYM0l4WVpZSlc1YzdmMGVaVUFnTjM2ZDlnZFA1?=
 =?utf-8?B?L21Pc0RhWW84UEFHcndxZ1RPRkdtL2ZoSnh4cndUTHFNT2ZZRUE5V3I5VmlU?=
 =?utf-8?B?YWVmTW9rajhtZXdwTDdTR0gyY01vVGpVenp3aXc0dWZQUkRhbmY2NzQvVWQx?=
 =?utf-8?B?NGNyL2Z5UVFHQlJTcHZNTGg1eXFMTFc2T3pXR25XUDZvTU9EUGY4cXAzRVB5?=
 =?utf-8?B?UUpoVEpJS0FBb3RWSmxuVDEzbHlNaXpoMGtpZ3FJTHp6L2p6QmIvM24xWVBH?=
 =?utf-8?B?SFNvTG05N2hpYnlPMVgyWUtNKzN5OGd2MnRWTEx3bDBrdXFYY09PVHUraVph?=
 =?utf-8?B?emJsajVqWjcwRjd4VnBCL3Z2VVpadlNKVC9wdmcxNFQ4dVFyWFozYnVmdlIw?=
 =?utf-8?B?TEFqK0pjc2JJazN5UlBQbUNPckYwOVQ5cU5QM05aS1hBcTBTaWZrK25jQmdN?=
 =?utf-8?B?NDFjdVFMbVZDS3NkaXpZaHk4ejlvNkg5R05uUzBISmgrUU12M283Z09FQlNN?=
 =?utf-8?B?blJIQW5NUkEzL2hOTE5UenpXM0ZVQ0tKdk0ySnJ1aWYxeVhJdmtYRlFXdWVB?=
 =?utf-8?B?WTU2bjlPWEVFRlREUGNYSzcxd0xJcmx4bCsydlhlL2laRVh1WkJudHRic3Mr?=
 =?utf-8?B?NEVPN0FTL2JOblFRNkt4UDZvUFFQcmxNTTlBME9tVjB2REJLb200K1ExZUlZ?=
 =?utf-8?B?NUh5U2ZTRmNUMzU4azE4RGlvNWRnOWZ6QzV5MXp0cjdrNWtlYTlSU1FtTUlW?=
 =?utf-8?B?dm8zQ3hZNlZFemE2aHVVTzg5bTVhRkNsSzVIZHhrU1VMSkRvbUMySUx1MkV6?=
 =?utf-8?B?KzZaMlZUZ3ZMQzZvRThLNVdjTThvRTkyQm5vVjNSTDN4UW0vSnlrblRPTUly?=
 =?utf-8?B?b05meFpxUzd6WGJ6TW9zSWhYRFgyNUdlQVpSc0RoczgvZThsK2hIODdSaG83?=
 =?utf-8?B?NmFjc3FVSmNRbi9VWTYxQldWQ0FsMnRsZXFzM0hPaE5xQmFrUkc5U2hYQ1Vp?=
 =?utf-8?B?VVd0eDB5cTEyZDhqZC9zQ2pvQzhFTGxha2xkV1lKUXROb1JaVExicEo2cE1E?=
 =?utf-8?B?V3Y4ejJYZlNkWkpDazhvNC9iVWFrVWZCWThLSEszQ005L1VMYmttTGFLaUxZ?=
 =?utf-8?B?Y0VlUlpCNXhwK0dEZUx4Rkx0c0s3eU9Ya1Y4UDlsM0c1d0NVZnZWQXEvenZw?=
 =?utf-8?B?YjBWanF3VXF2bSt6bklVUnpsMXZWdlE3SzBVMng0Qnh1M3FiNjdCa0pIL1k3?=
 =?utf-8?B?UEtaRzlXQVR4TUduT2xxc1VhZUM5dlZ0aXJrNFE4N21vemRDWmVVR1Nxby9s?=
 =?utf-8?Q?ukXLVstqw6wAHE6Xoow5TngmpTsbe9KHSVrTA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdLTU56SktBNnpsM0pHR09EV09pdHYzM3dQcThzS1FOaUtUYjRDaStIbnZX?=
 =?utf-8?B?ZHFETndieE1sZ1JESkZHVUgwWFdOczR3Und3U29USlVrZzJnQ05uR2ZHbGQ3?=
 =?utf-8?B?cStha1I0MHNRd1Bia1c1T0xWcFFvTHJkdmtsclBUYi9SbVFGWHhUSFVJWWVj?=
 =?utf-8?B?K0s0eW81eDZSdnRHa05vWHdPaHFJTXIyb0pVVXhRYmJPSW9CNk5UQmg2YWxQ?=
 =?utf-8?B?OG1NSjJvMGxpOW43MURPcEpLOHFQVm0rTUpCOVkwNkdPL0cxc002Z0loNmo3?=
 =?utf-8?B?aVV5MDROYlBJMzY1UkpsWHY2MTFoSTV0dDdlWXBrUFZtZ01JRm81bmpuZmpP?=
 =?utf-8?B?WWJjQ3VTcVlJVVpsc1VoNFdzd2lIbVNTOHFqMkZnc09RR3g0S3l0SFpaMEY4?=
 =?utf-8?B?TSt2U2FzMTEycHVWS3I0L1NrbGFTNWV5dTJwVjJTV2w0UDBMd1NVZ0VsaTAz?=
 =?utf-8?B?MFdlRFhkL3hxY1NZWWV5cmRvdzFsSityd0YzUDZnTlpLZTV2TFZQMEF6NFBk?=
 =?utf-8?B?YzRNd1pZSlV5bXJ0WWI2SjgrU0dCdE85Nmd3UDZJU3o1VXBiQjNhcFNDMi9w?=
 =?utf-8?B?bmlqalJyMnVjZFROZ1ZXVjE4K1NYdUN6Sk9IMXk2ZUhjWFozb2JYTkpBUlpq?=
 =?utf-8?B?cTN0NExCVkpYTUxHaC9aTHVvQ0pJN2w5NUR3RUxEakp1SldEc3BPZ0p3Zkoy?=
 =?utf-8?B?dTR3bUM5R1VHcVZ5QjdmUWE0U2dWblptSHI1eXp0TjhQSllPUEJ4UmxPbitq?=
 =?utf-8?B?RDlZM3FPUHA1QVVURUFhZ2hNb2NFOWg4QUJtT2VpdnNnVzRJWjVxUDRZeDVk?=
 =?utf-8?B?QjVhQzRJOVJleHNsQjhCbi9hU20xT1VrZ0c1SlV6RUJFd3J5QUVObnc4dm1C?=
 =?utf-8?B?RHZCVk5weEprd3Y4N3pGTEhmUGZxN05nQ0c2b25ZNkl0V2p1bHNFaUNucmNV?=
 =?utf-8?B?SWUyRHhZQiszV2JyclZ3MUpQMUFSNGk1cnMyTERFSngzTHZGVkJOQUNhakp1?=
 =?utf-8?B?VkJKcEJEY01SY0VZdm11cXhYV0FlcVh6bVEveWRlTk9HYytXeHhVV0VhSjRR?=
 =?utf-8?B?RzBUa3M0SlZGSitCSFo1NlZBWnBtYzl6OStMc3hNWTVqOXpWS0N6R2NTbGov?=
 =?utf-8?B?SU9pMnlOYjNNRlhuWVhNbEZmT2JLdzZpMTdycHFBK0JjZHZHUjEzSnBJcWRH?=
 =?utf-8?B?NVVSbG1WNlQrUkhFT1FLbzhyQ21TZ2ZtbExCbDNBUDBmVWprOVl0RjdFYUFO?=
 =?utf-8?B?RUVVbWYzbm5nWmZEZjdZNXpQNGQ0bS9PNWkwM3M4RWVJcFdiYlVOT2hEQ1Vk?=
 =?utf-8?B?blBnY3BRY1BlNUdXNkhlbEJxRnRmZzdLS2wxM2VoNlNCNjdxTDc1YWRJUmdR?=
 =?utf-8?B?TVpwWFpSOFdLa0V0ZDUzZW53WXk2R21GWjZOWmplWGwzYUdkWHp5eGh6L1B4?=
 =?utf-8?B?dGRWMG8wQnJtM0xWK3RVN2JZVmQxRXB6VnZzK2xIL1ZoVmFBK2lBSForYm9R?=
 =?utf-8?B?SDQ4VDM4NUQ4WXlnS0dNbnl3TTF3SEUzWEZDVmtJOGpENEE0OTVQK2ROcE9H?=
 =?utf-8?B?UldWaVRYU1cyM0d2Rzd3eHVQVkdSa2FzR0RCRUI2RHhaMmgwL29Nc3I5Y3Vt?=
 =?utf-8?B?NDVYZEd6dXlvK2ltdXN1cDV6cXBxWTA5NUFWejVYZXk1c0lzYW5PQWNVdXRq?=
 =?utf-8?B?VFZBUjl0K1BqNHY4TFhzT0ZTT1NuN0NTMGovNW44V2dud21PUGlGYlUwdXdt?=
 =?utf-8?B?aW1RU0dpYVJYWmc2akhRdlNzLzBEQnM3L2lQajhXVHhQSWhzdWhtS3RFcWFT?=
 =?utf-8?B?NGtRdnlEUDdlNEJpRVBERCtvVUJQU1U4ZTlxeFo4YVpMYUlzMlNVOXlKSjVC?=
 =?utf-8?B?ZkJZOCs0MnFya1R5SmRiUStucGJ3enlNYzdVMTBhTkZtR1BkbFZ0T2tKejJp?=
 =?utf-8?B?ZkJmRDZoV0g0SEppdzc2L0Yyc0xwVFVJTVVkVXdYYkErdEJVcHZqMXkvVjZC?=
 =?utf-8?B?Q3Z6SzNNWUVPcW00UWl6ZW03aDA4M0RqWWJEVTUrbzRQblZBLzI0OEFNOFlQ?=
 =?utf-8?B?UUhWMXVTVnhJWWZhWGhKdGZmNjM3WDQxdEI0M1pFeFdmWlVIT1hmck5zVDND?=
 =?utf-8?B?YTA5T0lqSW9oWTFnaTE1T3RQTTRYdms4MkMzdVg1S25OWVJmTXdZQ3ZHQVlG?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f29b682-d9fb-45a2-02af-08ddea3d38b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:24:42.4600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4SNx606l5ZUgFclfBSEraGCJ2e1TtMmVgUcxcHn5OqIAVhqt8MSOLmFH0qtLUcdUhk8G1/EHUpDw5IzyVkV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7693
Received-SPF: pass client-ip=52.101.84.48; envelope-from=jan.kiszka@siemens.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 02.09.25 18:20, Philippe Mathieu-Daudé wrote:
> On 2/9/25 18:14, Philippe Mathieu-Daudé wrote:
>> On 2/9/25 18:00, Cédric Le Goater wrote:
>>> On 9/2/25 17:55, Philippe Mathieu-Daudé wrote:
>>>> On 2/9/25 17:47, Cédric Le Goater wrote:
>>>>> On 9/2/25 17:45, Philippe Mathieu-Daudé wrote:
>>>>>> On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
>>>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
>>>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>>>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>
>>>>>>>>>> The power-of-2 rule applies to the user data area, not the
>>>>>>>>>> complete
>>>>>>>>>> block image. The latter can be concatenation of boot partition
>>>>>>>>>> images
>>>>>>>>>> and the user data.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>>> ---
>>>>>>>>>>    hw/sd/sd.c | 2 +-
>>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>>>>>> index 8c290595f0..16aee210b4 100644
>>>>>>>>>> --- a/hw/sd/sd.c
>>>>>>>>>> +++ b/hw/sd/sd.c
>>>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev,
>>>>>>>>>> Error
>>>>>>>>>> **errp)
>>>>>>>>>>                return;
>>>>>>>>>>            }
>>>>>>>>>>    -        blk_size = blk_getlength(sd->blk);
>>>>>>>>>> +        blk_size = blk_getlength(sd->blk) - sd-
>>>>>>>>>> >boot_part_size * 2;
>>>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>>>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>>>>>>                char *blk_size_str;
>>>>>>>>>
>>>>>>>>> This seems to break the tests/functional/arm/
>>>>>>>>> test_aspeed_rainier.py
>>>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
>>>>>>>>>
>>>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -
>>>>>>>>> display none -
>>>>>>>>> vga none -chardev socket,id=mon,fd=5 -mon
>>>>>>>>> chardev=mon,mode=control -
>>>>>>>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>>>>>>>>> chardev:console -drive file=/builds/qemu-project/qemu/
>>>>>>>>> functional- cache/
>>>>>>>>> download/
>>>>>>>>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>>>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>>>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
>>>>>>>>>
>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hmm, then the test was always wrong as well. I suspect the
>>>>>>>> aspeed is
>>>>>>>> enabling boot partitions by default, and the image was created
>>>>>>>> to pass
>>>>>>>> the wrong alignment check. Where / by whom is the image maintained?
>>>>>>>
>>>>>>> Cédric Le Goater (Cc'ed).
>>>>>>>
>>>>>>> The test comes from:
>>>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-
>>>>>>> a85f-09964268533d@kaod.org/
>>>>>>>
>>>>>>> Maybe also relevant to your suspicion:
>>>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd-
>>>>>>> c2bf-28950ba48ccb@kaod.org/
>>
>> [*]
>>
>>>>>>
>>>>>> Digging further:
>>>>>> https://lore.kernel.org/qemu-
>>>>>> devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
>>>>>>
>>>>>
>>>>> yes commit c078298301a8 might have some impact there.
>>>>
>>>> With Jan patch, your script doesn't need anymore the
>>>>
>>>>    echo "Fixing size to keep qemu happy..."
>>>>
>>>> kludge.
>>>
>>> which script ?
>>
>> The one you pasted in [*]:
>>
>> -- 
>> #!/bin/sh
>>
>> URLBASE=https://jenkins.openbmc.org/view/latest/job/latest-master/
>> label=docker-builder,target=witherspoon-tacoma/lastSuccessfulBuild/
>> artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/
>>
>> IMAGESIZE=128
>> OUTFILE=mmc.img
>>
>> FILES="u-boot.bin u-boot-spl.bin obmc-phosphor-image-witherspoon-
>> tacoma.wic.xz"
>>
>> for file in ${FILES}; do
>>
>>      if test -f ${file}; then
>>          echo "${file}: Already downloaded"
>>      else
>>          echo "${file}: Downloading"
>>          wget -nv ${URLBASE}/${file}
>>      fi
>> done
>>
>> echo
>>
>> echo "Creating empty image..."
>> dd status=none if=/dev/zero of=${OUTFILE} bs=1M count=${IMAGESIZE}
>> echo "Adding SPL..."
>> dd status=none if=u-boot-spl.bin of=${OUTFILE} conv=notrunc
>> echo "Adding u-boot..."
>> dd status=none if=u-boot.bin of=${OUTFILE} conv=notrunc bs=1K seek=64
>> echo "Adding userdata..."
>> unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd
>> status=progress of=${OUTFILE} conv=notrunc bs=1M seek=2
>> echo "Fixing size to keep qemu happy..."
>> truncate --size 16G ${OUTFILE}
>>
>> echo "Done!"
>> echo
>> echo " qemu-system-arm -M tacoma-bmc -nographic -drive
>> file=mmc.img,if=sd,index=2,format=raw"
>> ---
> 
> FTR the alignment check was added to shut up fuzzed CVEs in commit
> a9bcedd15a5 ("hw/sd/sdcard: Do not allow invalid SD card sizes"):
> 
>     QEMU allows to create SD card with unrealistic sizes. This could
>     work, but some guests (at least Linux) consider sizes that are not
>     a power of 2 as a firmware bug and fix the card size to the next
>     power of 2.
> 
>     While the possibility to use small SD card images has been seen as
>     a feature, it became a bug with CVE-2020-13253, where the guest is
>     able to do OOB read/write accesses past the image size end.
> 
>     In a pair of commits we will fix CVE-2020-13253 as:
> 
>         Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>         occurred and no data transfer is performed.
> 
>         Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>         occurred and no data transfer is performed.
> 
>         WP_VIOLATION errors are not modified: the error bit is set, we
>         stay in receive-data state, wait for a stop command. All further
>         data transfer is ignored. See the check on sd->card_status at
>         the beginning of sd_read_data() and sd_write_data().
> 
>     While this is the correct behavior, in case QEMU create smaller SD
>     cards, guests still try to access past the image size end, and QEMU
>     considers this is an invalid address, thus "all further data
>     transfer is ignored". This is wrong and make the guest looping until
>     eventually timeouts.
> 
>     Fix by not allowing invalid SD card sizes (suggesting the expected
>     size as a hint):
> 
>       $ qemu-system-arm -M orangepi-pc -drive
> file=rootfs.ext2,if=sd,format=raw
>       qemu-system-arm: Invalid SD card size: 60 MiB
>       SD card size has to be a power of 2, e.g. 64 MiB.
>       You can resize disk images with 'qemu-img resize <imagefile> <new-
> size>'
>       (note that this will lose data if you make the image smaller than
> it currently is).
> 
> 
> I expect us to be safe and able to deal with non-pow2 regions if we use
> QEMUSGList from the "system/dma.h" API. But this is a rework nobody had
> time to do so far.

We have to tell two things apart: partitions sizes on the one side and
backing storage sizes. The partitions sizes are (to my reading) clearly
defined in the spec, and the user partition (alone!) has to be power of
2. The boot and RPMB partitions are multiples of 128K. The sum of them
all is nowhere limited to power of 2 or even only multiples of 128K.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

