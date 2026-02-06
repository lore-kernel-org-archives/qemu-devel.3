Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5147EE20AA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMdY-0008Jt-Ab; Fri, 06 Feb 2026 09:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1voMdU-0008Im-F1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:16:42 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1voMdQ-0001FP-QX
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:16:39 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 616B1qW63559772; Fri, 6 Feb 2026 06:16:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AiYza2NK4/zXjF1USBO36HMk9xNqTwa4LzHjCKIfT
 yA=; b=sUuak1HDLjfJMPQCDztEd6apyjKW71tasftGqNZW93P/Zu7AHkAOqSdlk
 ZJPg3p62xXVDkXU7kWophZRB+qdEmCv4u4aIxp4OIlc5YxA7TMy6JvAzwtCWET+j
 LfeuSrORbCn3YfiqNZWvXntJtC86LJ4MMrjyAZocvrDyOtABZKOYRTLYO2zW59q/
 u7Tauupwhg4o4t1Nrj7yEGDtYIiRLRrHZZIES6P7kNaKy05bcNhXM+HAYeH8MbZA
 OhFlnrlcVl7px6j7Qb1eSSxLBs/ktY/ZaooeG4THHcDottrcMlofJjq0NxH5wHvP
 Pp7Vr/wjmuLEIqbsQLlIoU466QiAg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021126.outbound.protection.outlook.com [40.107.208.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c5f2q0c2f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 06:16:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb2SEh6zTymdXs/VEN7Lw/A0acv74f4uMKiYkXnrD+doQP5gDA1XuLIvtiWCqBgpgyz+o+KrVldkp2xsJkJ4q+Q+LeWCxT4ZzkzW0//BTPw6My29QhaS4IMRqgCgJkb1fWM6ZSG5NCv+lIT/BR1Yt/AgiNdkqF+hA8x//VSjEty7F3EP4971B86z7hB15RX0LJrqK+UFHJcWaKqQYUDe6Ggl2SuBneQVrRCds0LMuwmE0FdGrtkaN63gw6LYHKdQmPsosLok31ZUH5l8XhZTg0ieBAt+XPg/bUeJmCq7CX82SebBsbdftH3I83rgkNnlhIgLuAQm9UjBiJPXX1lr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiYza2NK4/zXjF1USBO36HMk9xNqTwa4LzHjCKIfTyA=;
 b=pY/1S3zRDh5GvUAmnyZSM/MtWnBHOi982bb2RVthzOQg3AtVZWCR6pRWt4oldiqVT7fTCHnhZINsTe0UXe18q02txE55H/k9DWoLnL5PDPLgyWUcVgM7vEUnSCt3SR1zLjVE+1w8YYdclcioYUAtsA74ZqmKZ6UYfUFr1GVdDqt4/+nbLBnP3bwv2K4h0offm1MjGBrpnSj/YxJ4uQRYda02lN6lTLaoieKfTRDmOk8xtL3z15mrbz18H2UiCoLFL6iPTs6ml7X94d0T4c2PIbJiJvXBL9m80H627DfmOcCLLPqoD+LRds4nEk1RpQIyvPz0dR2cG5zbFwSdhAR5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiYza2NK4/zXjF1USBO36HMk9xNqTwa4LzHjCKIfTyA=;
 b=k5WR/WiFkTRbIJfKVzPtaoyaH8ciR5DTBhAnHZz6OnOXrXigGiyi5z874Sq7XF2JYkTOYQOStp3pOxjKltRyhke4B0OvvJ0G92vNJyO2x7AKqmNLKB35pwWm2mI4S3x900i/fCNQOIIU+D5galLThFxw1p+mVZNm9mPdC22W1AyQM+LW0Xf5BpEG8qzeg/rHgwNeOgfvssX0Cw/IUczhz2fp+SEV//5gWbpmrkDz8C2viE9vH5tJE9/GsxurkMf0oYqybcrxMyeiuRnVPftpZ1CnB3yTfhpeqJoB45BeEfW20eiNEj5VOdC5+9HOC2ZU5P54J9m4KS0Z9Rd8UlB7vg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8414.namprd02.prod.outlook.com (2603:10b6:806:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:16:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:16:32 +0000
Message-ID: <ec7390e2-8177-408a-a84a-b79c6352de37@nutanix.com>
Date: Fri, 6 Feb 2026 14:16:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] qemu-options.hx: clarify default audio backend
 selection
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-6-marcandre.lureau@redhat.com>
 <b28fd63e-063c-41d3-a9dc-54929e7adfaa@nutanix.com>
 <CAJ+F1CKauYDpB0+_ggGP9mMkvYTDTbcsp2LX+twm8dvMggpSuQ@mail.gmail.com>
 <1f9dfd2f-9586-4f08-afc9-113b7ecab135@nutanix.com>
 <CAJ+F1CKsXKU9J-cqKT=L8MJP_Xsztoy_Z9TNGOpDUJVxH9xCEw@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAJ+F1CKsXKU9J-cqKT=L8MJP_Xsztoy_Z9TNGOpDUJVxH9xCEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3cd0a6-ce25-4f3c-17aa-08de658a53e8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTluRWFDamROQWNXbFZYQ1JEUWFHakk3cytBc0JjNmdZc2hxS0pXcUx0eEIy?=
 =?utf-8?B?eG5vT3dXZzVVYnVDK2hIbFJHdUNKZkhkK2s1R1pCWDlGSWd0a2puT1hKOUxY?=
 =?utf-8?B?SHN4bU1NZDZzWEtSN3UyWlZ0VVNJekNLNmM3M1plYkZnbnluWVpSS3BjMFRn?=
 =?utf-8?B?RjZpcGY2aWhzbXdrQmhXZEkxKythYzJ3MlBHb2c5ZElEd1g3cFBpQ0ZManFZ?=
 =?utf-8?B?UTFZNDZsQU1SVDhINjZ6NkJWNDF1ZWVJanZucHk4L251WUtTMGFaenR5K214?=
 =?utf-8?B?dnpOVEhzWW9MVjFuMEJXK1grSmhUc3JIb0J3QXlpYlY4aW55anJqQlVSam4z?=
 =?utf-8?B?dkprSHhzZHNPSVdEV2QwUWpMbVRVUlZncVVGMk1JQWZMZDJlVlcyTTN1NDFV?=
 =?utf-8?B?U29VeHdKZ3dlTTIrYXE5dm1IU3M2WThKbXAvWmhOTHU0OXk1ZnZNV0RGNHhs?=
 =?utf-8?B?SzBhNGQ5a2pKUHJJRERpUDZLMDh1VGl6MzQ1NEVTbWFLSThxWitsTy9xOThj?=
 =?utf-8?B?VzVHdjB4eGI5WlJDc3F5Zi84REYxcmVldUxyZzNZWTdCcVRNSEdnTWIvRzRM?=
 =?utf-8?B?YlR1MmFqRE5JUGtobG9wcWxaQkF1NTFUY0E5WXBFZHVrdGViWFo1L1gzSlds?=
 =?utf-8?B?YWttalhlZEFldXVJMW9zQ1k5bE1HM3pwdDJ6YXZmZ1Y5RFgzSE15b3UyWVhW?=
 =?utf-8?B?RVJjcTh2cEUwaFFNZCtCNWVPNWtWOHFxRDI0cWNRN0kyRmtMN3NqZXVOL3NR?=
 =?utf-8?B?czRtbzZPSW05eTB2VVRGbXF2Uy93eHlBR1hGV1lPWDRFWUkvVlNFOEJ6VUs5?=
 =?utf-8?B?Znh5WDRjalV2ZUNOT0ZSUUt4NHZUUmc0WXhRUFBVQWZtZlpXSHJWL0t2eTFx?=
 =?utf-8?B?V3lTYTVTMHVrN0s5TEpZbENzTkVRbW1WUEFOcExqT3BCUXgvR3k1Qm03Z1My?=
 =?utf-8?B?ZE5Cc3ZmVm1vUVFkL3k1R1ZpQllwTDdub0JEbFU3a0pSSE5zZkdJamhHNDlG?=
 =?utf-8?B?dlNIMCttVDhuSWUzYWhjUGMrdlVnRTN2cDRySVRPcFU1VmNaRklmdGNkeGp6?=
 =?utf-8?B?YkwyMEpvdEFkWlZwTGtIWEo5RmtDanFobHhWWmVZWWNsVVNLVTV6TjEyMEZO?=
 =?utf-8?B?V2hsYm1haisrT0x5bzNtVmh5MGgyWGRHaW5MR1ZQWVpmZ1ZESFNIMGI4aXAv?=
 =?utf-8?B?VE1CZSsvVUd6L2RBbmhEaUNHM1ExTEt5RVFGeWR4Vlh6M3VlRmtKSmhLVEVC?=
 =?utf-8?B?Y0tLejFLZWxVSzRWTFU0TVArRWNTd1BIVXcyckU2L0JlcGlOZ1lJZ2FicWtC?=
 =?utf-8?B?ZnNGSkVuZExMbHhlb1M1d2NSQ3NPT3B0S3h1eW52b3JtK041NUZlQUZ6ZnI3?=
 =?utf-8?B?WnVqeHIzNWlDUjhWeFRwaEJGRHVhaG85TjEydEt1L25ycmc3ckFEMEdwSkZz?=
 =?utf-8?B?TE1vZUhRd21sVlZGdTVRYXdRVkRIczZjNEdPWEhncU5Ra2JEaDFHN3ovZ0hL?=
 =?utf-8?B?ejFVaEZFaFIzamRiT1duUDB3amdHdDYrL0FkcGlpakNMNzJnTUFtTzRGTUhy?=
 =?utf-8?B?T1ZGdTduSHdPYVFGVUJpZzRRSDFKR1hncE9SWUZQdDhYK2ZlV1J6UCthNE5r?=
 =?utf-8?B?aGRyOUlkZCt3MjhIZ2wrN1dMaFZWdmNoRGtqMUQxamFObzFkZUlIK0tRcDZm?=
 =?utf-8?B?SnB0ZkxPaVR6amZtNTJxYndtU2lWNUVsQXMrR2pkcmNDQnE0cjFoMmFkUE54?=
 =?utf-8?B?SDdyTngwaC84ZDJab0ZCV1F1UmVEb2JVOE5ibk0vdUxlS2VBbkI5WWFrTDJh?=
 =?utf-8?B?Z0c0ViszQ0FndVpaR2thTCtBbmR5VmE2L3lXVUNjamwzRWpBRWg3NGRYQk5z?=
 =?utf-8?B?VUprVzJSWW9rTTlIUm53MEFvREhMbXYwUVZtZll1cmMxaHBwL3Z2cVh2dGdY?=
 =?utf-8?B?ME9hTVVpQmp5TThUWHhzTmNqeC91ZkF5NFhVVTA3VXRUNDdOallLVFg5VWpX?=
 =?utf-8?B?N1EzL1d5U3paZ3k1UDNIT1lzcDQ0L01FOXlnMWNoVEVzYlg0RGUyYURXMVBE?=
 =?utf-8?Q?KzjAzz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXIvS3NNNmM3WUF1MTZKODFzd1pwdEI3S3NoQ2dJb2FNWEo2KzNmZkhVR2xv?=
 =?utf-8?B?RXA3aElxOE1Vbk9TUnVRZVBueW5LUG1tNEZYQVpxU2JWQTQ0TURyekhWcm1Z?=
 =?utf-8?B?Y1hwWnU0aEdhY01VWWRhNEhNUFJsWGFyVnlPM3dkeDBWczhVNlBBOWpOdDN3?=
 =?utf-8?B?dU9DNTVaZHFTK2VFSTN3bnJCejVDQVFoeEJmd3J0Ly9TVEtaTi9EQkVHTFUv?=
 =?utf-8?B?ckRsSVlibjBOZmI3MVRIMjkzTitrcGtPN0VWa004RW1EYTVKNDFTQmZudHZ4?=
 =?utf-8?B?NUxuUWM1S1czdWJURVprTk1scW45dFpwTHRRa2I2anZzekRRNkc4dS9hb3VJ?=
 =?utf-8?B?TjJSbnJ0WGJZMVZ3Yy9OdjkrMjdvWi82TUZOVEZ3T2ZMYSsyb1JCNTRGazVv?=
 =?utf-8?B?Uk5qUW1xTnhEUWRtQUplNVpIdjAvL3NCb3N6cHhEY2F6c25yM0ZjNmRyZ3J6?=
 =?utf-8?B?ZG1abWxNQzZtcFJncldtSUM2RndEQUk0bDJMQjFTaDVVeExJZnYvdEllby94?=
 =?utf-8?B?bE9kOHFTc2xKaEltZ3lOSFFxbVZ6RkNDUjIyVHdrS0tFRld6WXVoYWNsS1E0?=
 =?utf-8?B?RXBWNW5aSHRZNDlwV21SaVA1WlNPaUYzZmVhSTdFYy83L3QzV0NEVVNDa0Fj?=
 =?utf-8?B?TUxWam4zQ2JRY2VmWnN0ditOUGFaTjRPSWNCdHFwVmNuZThUKy9xbzBLZW5m?=
 =?utf-8?B?dzZtOUdnQzQySXNnWE9TNnVpTXJ1WlU2dzVMMHYxdHhpbDQyODZQdmxyWFd5?=
 =?utf-8?B?aFFXOWlvY05XenA0cnROZkdic3Uwb3BQYW5sRGZMNlJHZVhhSXpxcTJIU1ZS?=
 =?utf-8?B?cGRzcEN6dEdIVGNvOG9UbjJRNE5NUTd6aVovTEtUUk9BTmJsNkZ0TzJML1lV?=
 =?utf-8?B?UUZ6L0twVVUzamoxdm5vTUVuYkY3bU5TZFdoYlJqZGgyakwzNytZQlBJbG5Q?=
 =?utf-8?B?amJwWDNsakoxaFp2Q3hQNFdWQWNPMmtJeGFRSzF4bDVWL3ljUmpTQWkxWlZD?=
 =?utf-8?B?MkRkSFVQUWE1WUp4VEFuT0ZKa25oQ1k4cGt3eGJ5Q01NTFU3RWdDekE3QWxY?=
 =?utf-8?B?Zm1iWmpHVVdhRHN3c0FUbCtTMFg1a0VLdXo1R2wwSmRTbjRNSEpER01Va21p?=
 =?utf-8?B?c05QVFl0LzlXTTZUcHJYM2szZ05NT0ZqdHZWR0RiendOeGt3cDhnZEFicVlZ?=
 =?utf-8?B?RjVOWmxSY2htalU5SVJsRjVvWm9zdUZIYy9pMTJiaTZLMzNYL1FpRUpwbTRz?=
 =?utf-8?B?Qy9NK1JiM294enFYdXo2S1VvTWdHeFJibFdQWjVYdkU2V3pwckdBWTYzR1hT?=
 =?utf-8?B?R2dFWVBOUEsvV2IrcmpveStHcTYvL25weUpvRVF2dUt3SnlaMjFsU2lERi9w?=
 =?utf-8?B?aXJIZHI1cVhpSXI4dW1pRGE4N1RzUlFTdU1uOW1Uc1hraUJqd1NidjJuYldK?=
 =?utf-8?B?SkRsRERJK3VNczMwOEk1TCtEVW9XanpkMGFub0lVNk13b2hMWFN5Z3JnN21y?=
 =?utf-8?B?bjlrY2ZqUjR2aGp6NGNwczFmeVp4RHNHcTZKSUg0NXQvQlh3OU8yUTVQVnE4?=
 =?utf-8?B?WUN6UC84OENYdDRIaEJwNUZUY3J2Q3BmblQzOXJoZUxKWmlRVmU1ek9lQjh4?=
 =?utf-8?B?SmtvWTdUSlREanhCRTFVWWxmdDFJRVRQN3FNa2VPajN0SXhxWEZSdElvZU9o?=
 =?utf-8?B?dWFQbzc4MlR5MlRCVjVVY1RUWDlKdXI4TVlHRE0yR3l1UGRYMHpZaVhrVVhH?=
 =?utf-8?B?TGZQV01KQTR6dHp0NTNrQ1hvNVhVZFNkb09ic0w0ME9aWCtjSnRKZmNIUjlv?=
 =?utf-8?B?ckJZemhqWEtWRTRKNnNrNFJ2R2RtV2EyOXV0UG01TnBjYUt6L1VJbU9PdHhy?=
 =?utf-8?B?RHJLZi9La3l0SUowSHBnWGhuMnFENGxNcmpMd2VPQ0xHK1RpRGFwRGlLcnVy?=
 =?utf-8?B?dG9CRDdqRTl4OElQemszNlhQOTRXRi9LUFdLY3ZtWGNYTlFpNnZkUlVhV1lS?=
 =?utf-8?B?cU92VjFlNWxHbHB1emZtUkRpY3RpdnYySTh2L3pQNlNpcmw1dEJBWVJyd2Z4?=
 =?utf-8?B?cDhuYy9nbVJXemNaUlBlb0g5VFJ0RjB4eVN5ZUxjcW9VdnVPSmtyb3B1TmE0?=
 =?utf-8?B?NS9jNVVYbnY2OFFGbGdkaXBwakhvcjg0TjAyTk9JRmo5WnlRUXFXWWJtc2xs?=
 =?utf-8?B?THp4L3E4LytGeVFubHp4SjdYandiM2pSS2E3aUdtVXR3aU5UWnBWRDF1WGZ3?=
 =?utf-8?B?eE5BZVFnRTVIZVFNMkxsL0hXZWIwODdhZnA2S2FzaWgvQ0dRcmN6NkxmS2lT?=
 =?utf-8?B?RzJtTkZGVmU3cU51em1sbks2T2hNV2hWNWhTcTM0UjJ1M1RwdnpHY3o3V2Ni?=
 =?utf-8?Q?QrGhFtcvBKN8JCgw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3cd0a6-ce25-4f3c-17aa-08de658a53e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:16:32.3342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wlCikCBl5MmhiyfNB5zAGkCv0L3oqy+ahthwnozCGKEbRnci874uxZ8pIz8Ub9greziws0jChaq+3fH9P+0bLzAxfXDVTwXeTTeR06ybLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8414
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEwMiBTYWx0ZWRfX0Xtu66tB6q9j
 aSnk5GxSbaNQnsjxu5xOfOhHzRD8Mjeii1bJbSy1C8Tk3oU9UD97fyxLLzY4kvMumBiWdr0nQif
 msMQ5GpgLxbch8pjbHxYILdpsJE59MoSHPx+75CJtUvW5qPgyg2yyFuEkyBJcD+mTcQovE1ARF7
 Q1i6V5jHn1ASUglY9B7JkIwDn++2g5nj+QeBRXMEub2B8K9IzrwUmAjo7u5EpYBV7jE8gYbMaEo
 HyAFVwyB3i+Z3e+SmczHQ3s7yby+OdF403tDr/UZ4w2rd8w48Oe15CDdl209YADsoKjO6PmBbHP
 GmH2A5UbTragnGbhVW7nC6Q9YHswt05AO25fSz/NQIceYd/6ogAkaX8q+4fTUNVcOsle9r8UB7q
 LQ3BM3Eb4R0NKxEXiPf9/+j5aV862dvu3dOAbL1sRhRs+L/6WTsSOrXXSObPwgY3EYy7s15Xtlr
 igcs7UDDfdbdBC5idEw==
X-Proofpoint-ORIG-GUID: YvQFT7e8_tkIPorduMrNQmi_wqQdnTet
X-Authority-Analysis: v=2.4 cv=c/imgB9l c=1 sm=1 tr=0 ts=6985f7c2 cx=c_pps
 a=cnhvvNhNoe9VuZBm3HgdeA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=UXIAUNObAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=HEUUjIVyITnlIFNZYewA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dDbJgj3P-9cA:10
 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-GUID: YvQFT7e8_tkIPorduMrNQmi_wqQdnTet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 06/02/2026 13:04, Marc-André Lureau wrote:

> Hi
> 
> On Thu, Feb 5, 2026 at 8:19 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 04/02/2026 12:27, Marc-André Lureau wrote:
>>
>>> Hi Mark
>>>
>>> On Tue, Feb 3, 2026 at 7:49 PM Mark Cave-Ayland
>>> <mark.caveayland@nutanix.com> wrote:
>>>>
>>>> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>>>>
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>>     qemu-options.hx | 22 +++++++++++++++-------
>>>>>     1 file changed, 15 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>>> index 455b8be8903..732934a6fa8 100644
>>>>> --- a/qemu-options.hx
>>>>> +++ b/qemu-options.hx
>>>>> @@ -896,11 +896,16 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>>>>>         QEMU_ARCH_ALL)
>>>>>     SRST
>>>>>     ``-audiodev [driver=]driver,id=id[,prop[=value][,...]]``
>>>>> -    Adds a new audio backend driver identified by id. There are global
>>>>> -    and driver specific properties. Some values can be set differently
>>>>> -    for input and output, they're marked with ``in|out.``. You can set
>>>>> -    the input's property with ``in.prop`` and the output's property with
>>>>> -    ``out.prop``. For example:
>>>>> +    Adds a new audio backend driver identified by id.
>>>>> +
>>>>> +    If no audio backend is specified, QEMU will attempt to select a
>>>>> +    default one. The ``-display`` option may influence which backend is
>>>>> +    selected.
>>>>> +
>>>>> +    There are global and driver specific properties. Some values can be
>>>>> +    set differently for input and output, they're marked with ``in|out.``.
>>>>> +    You can set the input's property with ``in.prop`` and the output's
>>>>> +    property with ``out.prop``. For example:
>>>>>
>>>>>         ::
>>>>>
>>>>> @@ -2172,8 +2177,11 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
>>>>>         , QEMU_ARCH_ALL)
>>>>>     SRST
>>>>>     ``-display type``
>>>>> -    Select type of display to use. Use ``-display help`` to list the available
>>>>> -    display types. Valid values for type are
>>>>> +    Select type of display to use. This may also influence the default
>>>>> +    audio backend selection.
>>>>> +
>>>>> +    Use ``-display help`` to list the available display types. Valid values
>>>>> +    for type are
>>>>>
>>>>>         ``spice-app[,gl=on|off]``
>>>>>             Start QEMU as a Spice server and launch the default Spice client
>>>>
>>>> The documentation changes look fine in terms of describing how one
>>>> option may influence the other, however there is no explicit mention in
>>>> the documentation that selecting a dbus display with no audio backend
>>>> will also use dbus for audio.
>>>>
>>>> Is it possible to mention this somewhere? Otherwise someone would have
>>>> to go digging through the code to figure this out.
>>>
>>> would something like that help?
>>>
>>> @@ -2191,6 +2192,9 @@ SRST
>>>        ``dbus``
>>>            Export the display over D-Bus interfaces. (Since 7.0)
>>>
>>> +        When no audio backend is specified, the dbus audio backend is used
>>> +        by default.
>>> +
>>
>> That definitely helps. Is it possible to tweak the wording to something
>> along the lines of:
>>
>> If no audio backend is specified and the dbus display backend is
>> specified, the dbus audio backend is used by default.
>>
> 
> ok
> 
>> Another question: is there any documentation for -audiodev dbus and its
>> properties anywhere at all? I had a look at
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__qemu.readthedocs.io_en_master_system_invocation.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=YVTDyodBF4JmdX2qwmxSr6fpEy1WbzwM7Ovk8-n_tAoAcJd6plea1zQTWirWJSgL&s=PSJ5e8WKwy1qjmONVgXjGeBQJi2e0gzgIP5I95felxE&e=  but I can't
>> see an entry for it in the audiodev section anywhere?
> 
> Good catch, what about?:
> 
> +``-audiodev dbus,id=id[,prop[=value][,...]]``
> +    Creates a D-Bus backend. It must be associated with the display
> +    (as ``-display dbus,audiodev=id``). (Since 7.0)
> +
> +    D-Bus specific options are:
> +
> +    ``nsamples``
> +        Number of samples per read/write (default to 480, 10ms at 48kHz)
> +        (Since 10.0)

Looks good to me - feel free to add a:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


