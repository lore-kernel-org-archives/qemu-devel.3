Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF216C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh32K-00029s-8z; Tue, 07 Jul 2026 06:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wh32I-00029j-L6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:28:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wh32G-0007nK-Rk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:28:18 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678EcvA1859065; Tue, 7 Jul 2026 03:27:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Z42rsv9U7KCnv6KL8dqA1EambXRePeqcbLFJTC+wo
 m8=; b=boxmy9+HHVtjsBiHQoFE8Enh9flfpiLq9iYYvFUYLJEcqCuJENeI4RipC
 cbpNv0OLayCkNi5a3ZwYpOwQ4zRF8cGAiKKTWyiYYzjQRIWUpro6u74O85DpBRsJ
 CYor1lXkmEvq9y7sPUz16Aw9uZZbK2PU406se38PcV3BEVtCaR/XDTmk32RYz8cL
 xdOvrF9tchrM4Xgw8R/id6KDub+8dtp2HpLWgvIjVqIXZ8CdZzN3ou7IXylLLAom
 /hYXarN9OwL/Jcr+7Ce5sykUUn2U7KwEKDrDz5qlB9jZWNiPpEQa/Yt7SVCtkWH/
 dv6oeeDo83kYWXOKQgG3kl/LYPz2A==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020115.outbound.protection.outlook.com [52.101.46.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f71q060cn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 03:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWICwmQLiuxZ2ktsUPzPqhvNYP1I3zh2TtLV2fg1GE2wE2+cBlNnyoLgpwlPh9KAPa26VeFTCrnY0NfNtvMyi6o2g1KMd3xKMnDYg26gDm02ZAjY0M4aB5d266460fPElrl+7Q3hLObqIyafsbP7G1eNSOYKh8JLaNnjZDuEr4TmWt/MynzxYs2RSuy/xFyjw/h7JQ2UAzn/0UyKtok2ZFmc+uurGilaT/7AV9wTtojB66bE5tJPDZVYnbs5VA1oKNOCgE3rHcNpWNErQ3ze1t6yVA+Rs2WjpLQV7hk+AW+vy8j2hPkC7rCnA/MYW6ENVKUIbDmdeJrQvmwQU5EohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z42rsv9U7KCnv6KL8dqA1EambXRePeqcbLFJTC+wom8=;
 b=I/zPMBK753pXu24QjxcHnT2lCqkzAA8onY3+T9LJk+LvqNdr9k0UHeIMqBMtFIdMeqvj0z+z4lqF7dgyNtlFCFh5PNkjwrC41ph9/nCrDmcAXcd8Db1gkSU5bNshmmMBzWbBxXvCIQUSqzJMMMIhSS9P8pbm72hS+0OWGov/O/+/hY0bAZE9TPrk7tOvPP7zrtapsSje0pLRCVxhgqRJ/SSqLVRR+V/STOafdiNVVhs+nIn2w0AMMArd/LDAF40axRoYwKvm2nC6YS0+lxpCUX+TmeC3+yJ3ZK4oKr6nVovVACjKPziLjgeXlI4JQAL269AjYQloNr17ltmfwrVrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z42rsv9U7KCnv6KL8dqA1EambXRePeqcbLFJTC+wom8=;
 b=bmMMxL14Hnf2Xh5qYoZZZtbfE7b4elNfSUncYFzXjd2ZqoiheADHr3L/0HRbzdZGJT2MwXlflWZtFRJYT10xDlgEmvnM1HDqB4BkUWCgY97GZpqJ6CrNQt8+pGhg5lK2VSy8sb5VGWi+tcbWMe9IOe3OZ26Fv9ogZkUyrs8gKKwh5JC05KD19pkMKBn51lrn7gNEuR57fFKEGKzqavGTGrs02Com3SqfEB6dMrFBgVjLYqZFXSQj8fnBpKc7z6MVBr2L7742f0ku5wla2mTCmXP1awr+2s+VaeVpyk65Z3fFx+PqV6/EvOxIhzjEsGK7YFSn3qtXdRvIYhpTWXpZ4g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6946.namprd02.prod.outlook.com (2603:10b6:a03:239::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 10:27:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 10:27:36 +0000
Message-ID: <9b723771-d0f4-48e2-9785-70b683e4467e@nutanix.com>
Date: Tue, 7 Jul 2026 11:27:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call today @ 14:00 UTC agenda items?
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, cw@f00f.org,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
References: <87h5mbunho.fsf@draig.linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <87h5mbunho.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 51140957-ca8a-477f-d1bd-08dedc125cb0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|4133799003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UU6cHpALfwNRckXj+jggOFCJK4B7E0Fz9sCJ3vm4LajRuyqzeIWYnJ9L58eiWwjNw65178f4C9uHXaPnOJhazMh3U3XcWbrYLO1703XI0xeDBJ+x4pTbcFUqXvS/agUZzIegCNfoBOIz3jYaBbNXM97X18lMU7sLOtRRAnJbqjY0Qcyqy0YfjdHlHyJgsrQYnY1wSYp0BvS6sXmyD9U8AQYmPuakbBrpaAjsaRF6MUYZmJ5oXznKO/pXhRBw4DzqyW0lnxuDDqaJerrhEvHUOpHS3pCpHIEQIUr5DppkcdRBjL61fzOTjtTev0Xf5P2rLq+bLNKa+LaWyVLvoXZOSt1rs/5pHoasMvqOhCFiFj8MZt0cB5Py3Bp09Vbr+pX3nWNg8SRJIoqwWMWa/buIVrpSEtng5Jwtcy5+CaZtPYCCvhG2oJg5W/mu+ftJtSpVwOZ9IqdNInLSCMIv4E8MeZOLmnGNI/lcPXzdU1nL6CRic4EQTrC+IbEczHVAu71UzfTageXnEdCl79HHUSGZ6vzdIwOT9ny06C3O/hzCaGgxmbQBoXJJXKlRP0W7DqrJ8R5zm0kwKTlp0S8pDJR1SJ0CpbWnqRizZCR08wV3+cqPM6+LDp+7/P1NJQ+eMoFxFRCoDj9faE022vmCspkkwnsNVWJnHJi3TqwWdO+FmOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(4133799003)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJYbE5uZ1RWY1NYWHJLQWpna2wwb2pMckl3dTJiZ0NtVU96NkV0Wkg0V2ZN?=
 =?utf-8?B?OXlRVHFIWk14eld1YUJmejNnRFV4WmpxazNEUnJ6UnpLcktDbHdPSWJQS25C?=
 =?utf-8?B?aVN2TDNiaTRaZ0ZtODlXZ3F6dmlGRE5iTGJkeWJXM2UxRWtXSTZpM0Jpc00r?=
 =?utf-8?B?b0FpM0xQZ1ZLVjRqb1FwSm1oZTdQNi9RQlplVlBaMXF1VDRSOHhucHZ5U20v?=
 =?utf-8?B?ZVNBdVlKcXR6cE81bC9hcUtTc2hLOCt0UlBRb1l5eWluVlJmeTJSVk9ORXhU?=
 =?utf-8?B?cnlLUGJvY3NKblAzWXU4TlM0ZHZyZENtVjB0aFlleHNhTUxNNzZjcDNnOENC?=
 =?utf-8?B?M0E3S2dlRzVVL1B1dzZoQXVWczIxenZZYUM4V2l2dXhOL2xkMVdSZWdvN2Fa?=
 =?utf-8?B?bUVra0ZNcE1PalJyTVgyNEd3NVZLOXI3YUlwWHlKZEZrT09vckc4a09jT1k4?=
 =?utf-8?B?czJWakRtaWdMb0syc2lIdVhRTzJIWEJqRzFwdkxlTWFMVVB6L1dzVjhwdW9Z?=
 =?utf-8?B?T1ZBeHY1MkFYNlV2SUQwV0J3OW9GZHUyTHhjemRkSDhRQWFvN1JlNzRnSEJB?=
 =?utf-8?B?SnRWZjVSS2dvV1NoRjduZ01Gd1M1WWtDNCs1OXUzRm8xckFpOE8zMDZoQzlE?=
 =?utf-8?B?WHZ6NGNMUkc3cmgyT0FFVW5vbThKNjRhTTZqQmkxWUU2WEFHdmxuWFdYUUhO?=
 =?utf-8?B?TWIyd2gyNlFyWk8wa3BUMEtibm5VS0RnWnhmM1ovR0tIb2xBVXpDOFZiRXpN?=
 =?utf-8?B?b3ZCRG1HS2tCMGc4Tlh4N3g2ejFQSEVEeXBZSHZqSWNXamNTVllrb0lBUFlo?=
 =?utf-8?B?SEtkMC8rNzV3ZHlGSWFpWXhvOFU1T256OTZqQTBkV1NqZFNyQ3N0aGEwaEcy?=
 =?utf-8?B?d3pBcUNyMmhLK1Y2MTJ4Vmdmdnd5VmlwRzFIbEVlUEI5TTc1dzNCcWJqV3VG?=
 =?utf-8?B?V1drWmxWczNxZVcwNFE1dlFvVHhGQlBZbWFoWXU2MkpFblN0Q3NVak4vejha?=
 =?utf-8?B?NWtkamFpYjJJWnhXd3VBM0IzWmFpUUx4d2FIaDJaS25VeXdDNXduU2h1M1RJ?=
 =?utf-8?B?a2hXS3hPME9rbUVPc3BRSDdDY1FpdWhQMkRIWWRVV1Y2bWJDOFExVDdGVm94?=
 =?utf-8?B?bnorMVUreXdwN2VFZENuQmFSb3dad0NpcUZMUHNUOGlXbnhNc3laVElqMWNG?=
 =?utf-8?B?WmVYbkpFc1J1L1BOVDBCdElxNHZOQVM5RldDMUdmUkJFaFRKU09USHZTeDVz?=
 =?utf-8?B?ZFNtSlBmeWxFcyt1MVczL2YyZ09pTndxc25zTzNUaXpvakFIZWNWYURaQXRa?=
 =?utf-8?B?L3JSVHAxU3ZFUmFOZ25WWXVlQW5sVHNBMlVwZ1FZcjJUSHllREJjSTBkaEFX?=
 =?utf-8?B?MW1IZVdUMFZBUnBpYTVXaVFVdnR3THh4ZUdJTWdUV0wxMFp6QUhrZURXZFZS?=
 =?utf-8?B?eTBLakZlMXNyRk1lSG1Dek10VWJqSlZEVEpzMDV1MSt4aXpXVEM5WjVKclpK?=
 =?utf-8?B?cUVoaU8rRGxMa1A5SlJRVFZVd2ZQb1BzdXl3L1lGRm1KTVRNak9vaWx4OTU2?=
 =?utf-8?B?T2lCUTVKQ0o4TTF6Yk5WT0tib21YS3pvdnIxMzh2a3gyeUttYUxXQi80SlN1?=
 =?utf-8?B?ZmNVWW40NVBBUE9IUnpkalk1bHpzR3ZSbUhNeVB5VHJxT25KZEJMK3lQN2Zk?=
 =?utf-8?B?N1VOaHBJck9NQWY3M2ttZHR0aXZtWk9vQ0J5TyswWGJnSXNqbGI4VWo3RHE1?=
 =?utf-8?B?WUt1VThqUDRCN1Zndmt0c3VRWkdJRGM2emY3OEhRYUREZEFWS3drNDBUK1Q1?=
 =?utf-8?B?SGtYZnVhRStOUmRpMEtDcklxWENVWkZZWkN4bDZteFFLc0QwYzZzOVpXWnI2?=
 =?utf-8?B?QUUxTWoxZS9ZRS9xQTR5T2Z3ZFJISmRzT2ZjaEtWVXFTZTNpTzZKVXVjZTVQ?=
 =?utf-8?B?c1plQm0zMkx5NUFLWExKUWp5VVp2UG50UmRTWE96MG9SM3AyRXB5QXBrL21n?=
 =?utf-8?B?QkI4ZWtjMGtvKzY1eENmM0NRTUdrY2FGRkM1cHN6RjdOaW9xMlJGR1AyRlBS?=
 =?utf-8?B?ekdVdGF5cVBjcGFmS0NXVVhoWEpHTVcvdUx3ZHFjQ2s0V0JJRWVqOU8vRzlr?=
 =?utf-8?B?T0dwV2RTQjRuc0FNN1pKNm4wRFpDWWw2QmdHWHMwcnZGdlo3ZHllWm9Ibmsz?=
 =?utf-8?B?RFZHbWpOMEljZFVraUFQd3pZRWk3RGNhaDFaK2ZGVWtUSDQwSktod3pLVXVV?=
 =?utf-8?B?dW5kZGxJelNpOFM5a0JmaHdmSU42eEhyN1YxbHZuTExJMTNwaHpWdFNXcW9C?=
 =?utf-8?B?NXUxbHU3R3VuYVFlZFc3UW5WTWw0aWdValplemVxbkFQeXBVc015amk0QStV?=
 =?utf-8?Q?soP+q7TU8dQ/6IBs=3D?=
X-Exchange-RoutingPolicyChecked: VbzBlFOvz0RjXh3VRLfHOrsGE4rtCzWAHzIDjE0lKqbo6CTc7aQDGOZMCLObQpCXG9LyoloIsuoecRUrmo05JWvq4m8FdC9JKalzbVFZtesBkDQtbgyjfByWXD8Sr3+ptAabdkQ67cYEonoVnrkwUpzNjDMpXXVIlrVgfcti0JLVzVHZmkR75GMH4l2r4mMcNRsOTOPXvibGCkE0GslzBpj5keID7uZCflGaB8XTMOrHSKWppAw0sehpP85N1z/XMNdYCtSEHhLhvthYSXGn39dbyz3L2toDT/eyU6TeDZCIcbYcpGM0EzDo5SEgi3dALNBktv+ClBGlTChp27dqMQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51140957-ca8a-477f-d1bd-08dedc125cb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:27:36.0912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY/5e0LJLY8F9aKaUTxuMGUU+aaaClfYxCo6pc1ULibwUyD/7rCrYoyITEM+y2Qqv1giQPnb2XkZITDUcu/9CM23uEttYnKeXl57634usvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6946
X-Authority-Analysis: v=2.4 cv=M/N97Sws c=1 sm=1 tr=0 ts=6a4cd49b cx=c_pps
 a=3+BHtXVVVEj9tth3MIVLhA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=nXA5WNwiAAAA:8 a=mVNQn0hwbiEPxT4WSmAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=fGr-7aqQv4RST94IA8XU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMSBTYWx0ZWRfX4xx3C0TrAA6r
 Uo00+1pLfQdctoAPmiVuHeBa+VZn9kWsfNZaxrGWoME0+j5DJzctcwzEKCAkyveBO1/Ft6U4Jmv
 bgUPbQwNP+8j3Hp+NVHu8orpqmbFQ8E=
X-Proofpoint-ORIG-GUID: EmfT9jsMbKK5MMpzzerTfJJHqm-1uLd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMSBTYWx0ZWRfX2iuwnv2otsnK
 YFfh7eFNgEy6Xhz1W6AS0ana8qedde5j0LqWIPYGK+x9CA5m9ulhLBR8mKyrffdUc6YxRpNUdVN
 qzcFdOlQMMBX2+aZmnxqw4kEYN37FA5+lIMzmqsxW7Zd5q63IQiR6RXzbdN+zzeFn76qu6MkbnJ
 rByrLPycL3XaOA0qmiRwaKg3NMJBLJ81aOqaUgqGe9C49Rt3Y78LzXA9tWizF5deHCOvDiGtMbn
 KAlNIPOw/whL53TfeZ3JxR16jaCKk1rkBa1ie887XhkcAxRq8vmJr7RlPunQe569x202sxOkSIZ
 l53F08EK5OOYMFVTndmc0WYxGetu449zLslMJift4ZZ/vYhV5280O1MX2hiM0+uNo79HSSTZ3d3
 bbzDoCjB5rpl22LHIhmh3/wUUrce0E12AEh1LpCfGJg0JbPcmPBB2bWGz2I9TQEW8hN/P+4fLmf
 +4FoPSym4CYS+ZU7Knw==
X-Proofpoint-GUID: EmfT9jsMbKK5MMpzzerTfJJHqm-1uLd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 07/07/2026 11:01, Alex Bennée wrote:

> Hi,
> 
> The KVM/QEMU community call is at:
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__meet.jit.si_kvmcallmeeting&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=hWE_0FOyLKcAreqfVma5qg81fXYKMGyJBLvyvOKY_aUU74d-oFvV9xnFYCQbHDBy&s=vRucXACQG_8F3znVjheeXco1uAtq4bJgHHRG-VoKoGA&e=
> @
> 07/07/2026 14:00 UTC
> 
> Are there any agenda items for the sync-up?

Hi Alex,

I'd like to talk about the best way to move forward converting object 
properties to class properties please :)


ATB,

Mark.


