Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2D2D2ED1F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDdd-0001On-D4; Tue, 20 Jan 2026 10:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdY-0001Lp-KB
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:20 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdW-0006ub-N5
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hd+2LUDLRhbKK1C+Ay5BMy2wCryCgSIsW4Slx00kzinfRL6bxPBzFWYrSbPV+GqfHSZUOg2ML39cZ+qXHQ1QE4VoYHXNJdV3xGZWlp+AGXpmY/gQnzgN7VZjSxW04fClGBOaBsArs97Adu4qzwKA08j24ZiPGezm54l0BCgQopMmmD26V7vVY9tPzfZ2BsSCeiA/7ZBVOHm+WvJQ3xdZPGS65jAIYdiRjkQ6vyC/55wJHwcUMQujqVlkepFzTnCTVq7Aj7kyizFCD/YrVcWg2TJXT2/M2VsyIdGDNxjfV+o6Yzh15e+7yAXAU0wmmMGxMn1gorFjlLruvwmP5QcEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b5QMl9gotuKaf/8Q8ZwrJquTPr0Ls10t6fCW8/BkuM=;
 b=pSiIcugSn9MEfgsLLr9/ozv/zR/AZgl2vjbkxrPW9tB8Lai7kgvzK73jTxkJL1bGxMQ6HUXjrbA/Y2dkP1vAMqeemRuEi79bUA8rR4fcYuDWH9HRzcLYbEy+eXjUeDKLu4tSTNFFjQQ740eRQhXCVFy+zoHz+CTR7lWMKtn7ztYMtasGK0k0u9/VMVLJg4/4QIjOZyjkvJL86uJ42RxBxS8k0pptvFUP/TrMeFaQ8toCldGV8+g2z0RnIsmC6JgL7libgNj7XB+z/ybsL6eEFrmgX+iKYMq6fYjYWVgg8EeCUcWzWh7NpwB1P/ZxB/I0k1tykgmu1fm46SjdAswY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b5QMl9gotuKaf/8Q8ZwrJquTPr0Ls10t6fCW8/BkuM=;
 b=b02BZ6DZP8mk+r10ELdjLkvjsyTWcpMSwYVtidvFKzbwwSlQ7LtrCoOfhwTrDkso1YdZ73lzNwXZTvCSdPZwPvkapb0QbbiILG/q6SkpbDt4hWauGDOf2meikZrodrfyrK4+64bYyxNKcEeItxAWG3+Bd864PyWl8CSFXlfNt14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1PPFBC9E76CBE.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:27:11 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:27:11 +0000
Message-ID: <413559ea-fdc1-4b0b-9d94-9876511d1899@epfl.ch>
Date: Tue, 20 Jan 2026 16:23:48 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/5] plugins: prohibit writing to read-only registers
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR1PPFBC9E76CBE:EE_
X-MS-Office365-Filtering-Correlation-Id: 000c3a70-e123-440e-149e-08de583860f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|786006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUplbmRpTEdHNzdIMmRqR0FlRXVUOXRmZXFwZ3k5cjJrNmRXUUUwcytlQmQr?=
 =?utf-8?B?VjArTE5POERnczJQbkVYbm9LVExjZ0FGNHZZRWRuOStiRkxDZllNZ2tML1R6?=
 =?utf-8?B?WWdxSFk0QVdvVHg4b1pqOUxoZ2tDY0hYTk9JS2gvU2drYStKYnhXRnVyWG85?=
 =?utf-8?B?N2p2d2h1Z2diMkxGTDJBT3hxcHFzZDRHa05Ub2krOHJxcWZHMTRCZFRvMElR?=
 =?utf-8?B?U3d2aVRwRmJ1cVd3Zk44aExyWFhQaVRDck9SMnA3N2Y0MmV6M0lNYW1KMHgr?=
 =?utf-8?B?QzJNZmh0RnkwK3hTUlBoaFhDL1ZZWlhoTzRqeFNucXVtVFpDTlBMRVdyNTk0?=
 =?utf-8?B?N2FReUxra1k5c0lKSjlPYmxWZDN6NnFvQ3I3TGJyRnVuSHllUllGenhseGMy?=
 =?utf-8?B?Z1lsWDNnc2FDMkFnM1VtMTJpb2xqVTNCQ0kyOTRXTDI2WXhOTkxvVFdyVlBF?=
 =?utf-8?B?Z1Q4VHZjSzRIN0d0cDg2UktuUkZHYlRvazFOdTQ5MjBrcHBtL2QyNGljeWJn?=
 =?utf-8?B?MUpNTllOV1AxaFZIM0F6U0Fhamt1Mk9wWW1scUdtZEZJc3I4WkJWQXpDY3BQ?=
 =?utf-8?B?WHJISS9LM0hFQWpwWXJpY29tYzhrTkVvazdaZW1TaU91VjhPZndvcXA3T1Ux?=
 =?utf-8?B?T3RoTEJoZUpvTGY4VVZxRUVQaEhBYXlXemgycnlTYWNsVnVKN2szajlhYTlI?=
 =?utf-8?B?ckVNVFZHbVQ5V2tBbHRqeFRCcjVaYTU3U1Z4MGZuRitiNGU3QnlCeGlOMEQ4?=
 =?utf-8?B?NDlNSXNONEhMRGo5UThlR3RleGRObVU4VkRaeWtiVWM1MWtjbC9vRnFjTk1x?=
 =?utf-8?B?bWpEUWZDcVBTeTZpWDZTRGl3cHFTWjIyNkh5MVZkNURFZU11aFlnWm8rTjFm?=
 =?utf-8?B?aEZseCtOL0JGaTdldVZPMzlOc2s1LytsYXY2SWx3aHluamdPeFpiT0F2L24z?=
 =?utf-8?B?Nkp5MksxWHZOcDBkSnhCVnVSK3ZDVHE4enBqQVZKRVF5ejRCVFJYUTJJRS9K?=
 =?utf-8?B?aHJXcWdpeFBrQ1piQWVjMGNrV3V1YVlQS1pLMG0rNFZKREhoR3d4c2xsNThO?=
 =?utf-8?B?NkMvOTNRc1RmRFd5R0kxMGMwckxZR05kRzJFSGg0RUpCVFIwUFNrZDBjbW9E?=
 =?utf-8?B?eDBuYVQ2ZGlYdmN1aWlaaXJ6YkpSL3JzZzM4a0NOVFZ3RHdxYmN0dlNOWG9R?=
 =?utf-8?B?U2s0Z04zQjdkRHl3bXdjUzdueHNTcWcxVVRDbU5PWWhwSEdIMUw2b1F6eDhX?=
 =?utf-8?B?YmZTV0xzdkxCSnYweE9IcTNsbU96Tzkvd2RMR2M0eUlCVys4WjZvV01UWllD?=
 =?utf-8?B?dWtEVk53RC83OUJHT0h1VHY2Wkx0VnJrNXErV2NrZ0NXNGduKzRpMkc2cHRr?=
 =?utf-8?B?bktQemV6LzF5eXJheU5SNDZrTHNZRndzRmlHVWhyNzUyampwcFpvNmZvMDZT?=
 =?utf-8?B?dGZtNXptc3MxQVJXUUFJZUovdUd2dUV0dHhSbzE5NXJoZ05YanBXZVdTbDhk?=
 =?utf-8?B?TmFjREJZT0Yxc2FtSGY0bHBJbjdYRzlZZTlvdFltZGo1T1NEbVdQbHluSEpu?=
 =?utf-8?B?cjU1c1hkREZpQ3ZHK04wSXNXWGFCZm1JK3hvN1h1RFNpTksyQkFlNlVyVFhp?=
 =?utf-8?B?OXU2cWJPZ2FCbXpoUHFlMEEzaWlnRkxrendZSXkvSUpuMm5qNFZ2WXA1QzJJ?=
 =?utf-8?B?eGk2enBCSW00N2p2YWlFbHhZcUxFZTN2VlZWck5JNXdxdkZXOHgzMElMZEY4?=
 =?utf-8?B?a1RLbEx0NjVSd0VNNGVyUElUVDRVSGptN3pmNmcwdy92SzQzSGFydThTOWsx?=
 =?utf-8?B?WG80SkVuaXBlK1FTaHY1NnVRejBhUjY3VXM4MXdnSTJCTk0rUlVmZjI1Y0dC?=
 =?utf-8?B?VnRKNUtJQVNUdHlaUFRvckovVW1RbEtMMk4zS0FNbzU3ZHlzOVJxMnJYY3Fa?=
 =?utf-8?B?cEtIYVZsUHhsZjhJdUJPM054YmF0eHRGNUxiR0JWODhrWHpDR1RrVDFXbkZZ?=
 =?utf-8?B?bWpZc09uSXprUXkvTlR2RlY2R3pqc2JLaXdUZVUxU2lUc2N3dlFWalFJOCtC?=
 =?utf-8?B?cEZzK21YbmgzeDRTcmNYcXlNQ3l2WERRelJKNGxzNDVMUGlqWmluSk5MbEFN?=
 =?utf-8?Q?q7aA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVY0c1Era2w1U1ptQkM4M3hmelZmbWlvUzJrQlhaVUlKU01PajlPeW0xb1RL?=
 =?utf-8?B?RUNaK0EvS3JFbVdlSjl5ay9xZWhjOUVQcnB1ZHRkQ1U5Yjc4ak11eVJMZkJF?=
 =?utf-8?B?enZSTno3N3dqWlFzd1ZEMWR2S0pNdTJPRnlRTHBJOVIxMytWajhBc2pINkY5?=
 =?utf-8?B?QUNjVkRlYnFzS1lHQVByT09ySktndXZQc3VhWXJhMnJyKzI0bkdaLy9EZERo?=
 =?utf-8?B?VUFFV1U0Qks5U1IrcHdLUTJ2YUFsaGI4eWVIQURpWDJQN0MySG54dlNmUUFs?=
 =?utf-8?B?YzIwaVJCVkw3djYrQ0xBZXVMUC92NlVRVHlVbm05V3dPNG10czNWSURscDl2?=
 =?utf-8?B?NDBFTUhjTEtsR1Nvck0wNFRqMjVQSjVmaVZ6WmhNNENUZnhmeFlrc292bkpk?=
 =?utf-8?B?RFpGcXFjNXEvbitZZ1lFUitnRjNVR1VPODkrUWhOYXpFOENiU280bnVnR2Fl?=
 =?utf-8?B?MlNSWXl0MUxOVWdDUXZOUmh3MGpwcnZiZUdTbGM0L2pMMndPOTZXaWZiNnNw?=
 =?utf-8?B?RHRnUjB6N2pYN25mbWY2aUpDSGQ5T29CK0xJbFdWNGVwK3ZKbDM1Vm9tRnIx?=
 =?utf-8?B?VkR4S3NXWDdYM1BYNWY4Y08vVEo3SnZYS3gzTUVhQ3Vja1hMcTVZWXFydzcx?=
 =?utf-8?B?MGw2VUxoRmhpamdqR3NVYTU3UXJnVG41N1IxOTgrOEVZZE80MERkTXBYc0ZQ?=
 =?utf-8?B?Qk9sM2dtUWNSVUNGVEorWENlODVWVjNEVDZlSFl6Q2xNTWVQbzhibUcrK0NW?=
 =?utf-8?B?QWYxMVJOcG9STXNlV0VjQzY0SmVmYzZIS2FOck1keUlUMEFkUTh1VFJRRENk?=
 =?utf-8?B?ZFBWSnVNdVN6Y1lieVlzT3NNM1ZwSG1COHJqc3UrWi8vZHZnZUNXMFdiUkcx?=
 =?utf-8?B?VGY5b0loeVhyQ3lwVjV2YW83cFJiR1NaRThTWUpxMVRqVk5UdFlPU3pOd252?=
 =?utf-8?B?YVdTcGx0MXJrK01KaFRkUURVcTloV0ZidkxJcjIxbHA2SDNvbER6b0VxNS9X?=
 =?utf-8?B?VkQ4dkZvMkMzdDVaT0ZMRjRvTythUTJwQUpyVjlDTFZCMVIxei9udVhvSnpG?=
 =?utf-8?B?YnZrbWJINW9zZk4vS3htM0Z5R0FHQ0hTeVEwMUhmcFYxRDMzeEMxYVlaNHhk?=
 =?utf-8?B?SG02WXhZclVwVlBPZ29sUjNhZGlvL05zVytnTDdZYzFQckhuZkJteTBVbXR6?=
 =?utf-8?B?OWZodEd3Y1dhS0hwUHl4R2t5bDVpeTZONzNTVmlab3psbWdvaUJaR0JTSmFR?=
 =?utf-8?B?TDh5NHMrVU5Qd2c4bXJaK1k3UVNsanZob1M1Vkt3WlZQTjdCNHBPRW92c0xP?=
 =?utf-8?B?bXhZQXlHMmRIUGNuSnhZV014R2tPRTNVUnZ5dlJBSGU3bjhIY3RBeEp6S2ZU?=
 =?utf-8?B?Zzd5NWdPSWpQT1RiK2xxeDRkV1FxQWl5VWc4RE1KYUpFU0F4d2RCSitSaXZI?=
 =?utf-8?B?NDhUUDM4RTA5aG54c0VhdXBnMkszYXVTaGtTR3V2aGNJc0lncnMyYVVxT2U3?=
 =?utf-8?B?N1RSZ3NtSU9FemI3c2ZxV2R4TnRzWGY4TFI2ZGVsbVQ5RG1WQ1JVUWppa0Vl?=
 =?utf-8?B?OXpYYXBqTnY5aDJRTmoyTGQvVk9IUFl1dGhNQ3VJdGtMdEFvLzM5T2wzZHoy?=
 =?utf-8?B?WklzSlNycXhkS1BFVXBKVVpnbmF2S0FlMVJQbmZFcExISmVzVzRuTlNOa3k1?=
 =?utf-8?B?Ym92R3RpaTZlN3p0RGhGYVZzVEpFR3Z6RGhSem40MTZKQU5od2FWT3FnUkdO?=
 =?utf-8?B?REJHVGpsd2hLTDAvQkhXbmVyNkRJZm5IS3hTZzlkcU12YzdtY2MxQk9nUGRC?=
 =?utf-8?B?MnQzbTJ4Q2RmZjFZOThKaUx6QVlyeEdPODB4S2JHM1hRa3RzaytEZFIzMXdo?=
 =?utf-8?B?ZUh4RDdPVlFUWDlTempMYzBSRTcwUmRGTlJSOGtlNVk3L1ZOVEdhajQvQnNH?=
 =?utf-8?B?dGtRMHNsTG41aTVZV3RMc0dTcWVVd3hmcjBrSGE1WnJac2tWRW1CdWQwTHdm?=
 =?utf-8?B?UEdYY09qS0VxTnZpbzg4ZzJtbjR6SmxRSXNnTWpKQlFjYTFCbjdmaHlUZ0tn?=
 =?utf-8?B?VEVHSFduV294Mm5WQXRERVd0eFM5WGpUanpHMFhnMXh5YzFVVVlOck10WDBG?=
 =?utf-8?B?dHZzbmdGajlMMEt0QmZOdkNQSW5yR2xvNkd3MExDR0JPY3FxM0Y5RWx4TWZW?=
 =?utf-8?B?QlhnQ2xNa0RxZGxoV3NJSE5PYjhFRjRqMFpkK1VKbHg0WkVFbXNJMUVNMTQy?=
 =?utf-8?B?cUdOaEZKSCtCZDBpRW9OOXZiM3RsNGVtTWk5cUZYWkpFelkrNUtPQ3MvWUow?=
 =?utf-8?B?N3RYWDQ2NG1sWFpiTkRNb1haeUhSeUNpVXdTM0tHdVAzVTdTQ2dTbWhGU2sy?=
 =?utf-8?Q?sYbjBJdOqp3oySIo=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 000c3a70-e123-440e-149e-08de583860f6
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:27:10.2513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfmu+TCSx5CNsupaTFbMgOJ1QXtryU1ofHbORsQ97XH6HTUsJCjhV9N1xWeJJn5CG+QzNrikrpr2iry7YrkLWBB68dsNWgPgTttu8ajra/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPFBC9E76CBE
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The opaque register handle encodes whether a register is read-only in
the lowest bit and prevents writing to the register via the plugin API
in this case.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 plugins/api.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index de8c32db50..4555f048a1 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -425,7 +425,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
 
         gint plugin_ro_bit = 0;
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         if (!strcmp(desc.name, pc_str)
             || !strcmp(desc.name, eip_str)
@@ -436,6 +435,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
            ) {
             plugin_ro_bit = 1;
         }
+        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
         desc.is_readonly = plugin_ro_bit == 1 ? true : false;
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
@@ -460,7 +460,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
         return -1;
     }
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1);
 }
 
 int qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -470,11 +470,12 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
 
     if (buf->len == 0 || (
                 qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS
-                && qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
+                && qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)
+            || (GPOINTER_TO_INT(reg) & 1)) {
         return -1;
     }
 
-    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)
-- 
2.52.0


