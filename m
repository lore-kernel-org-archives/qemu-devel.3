Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01D3C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBg-00084J-KF; Thu, 27 Aug 2026 10:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBf-00081w-7Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBd-00020l-F1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:39 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE806F110537
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ijAX1J2k0NIdudtWmh8nuYPwX2sCg188GoTPueVnX
 08=; b=esE4HK3qm8B6WG9D+10dRLjnal3SLEam82/Jp5gr5xLeZAnTnZqxZKFoF
 WEOVU39XwjEJ4tvfz1PCb0/PWR98S5GI0DHWiVCA2snnShxQBTKkInC51862YnIv
 KtKirC1vVv1uBxX9besHVEzw3gtrBDGmsyMqJ48Ma1cMU5hHzUCVBUPRumViwcC9
 tvV7kaYsJjHuZ6X3V+bCKdXDYeN4uPbRHNu7mM2iD5MdhJIKjd70payqG5lxegLY
 w6Z5c4/pVNwsqE05if+s3VSe9byHkJnQq0Q2lYlycUPh1hV3SCF9AKtFcuOVbN72
 pj5yn8lBj8gReEcjvRftvq4Z+klEA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023091.outbound.protection.outlook.com
 [40.93.196.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ga8me1vds-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh0BPu/6DfI+dmAzaUD12uyolvHgkWKs+RDNSOXiWI4aMiJpQ/cJhXlpSjUUBVame9TeOchoa8bLzsZrJT+q4L5vhee8A5yqlyMVv2l3Ir9BvGBrfgCoIModuUOfqNHDdNx9mB7QqGnPHuSGtJcKi3AAG/DxDudaRSeiJUWwL450OLhjjRV7AfZMEzfBJ85bST9h02PFuwy0GI9xWqRuBCzeNNND4hHHrf38E1yUh6hp+knkiQ/2omrZVGkhnew37rO2x79xTQ13yk0o2Sj7Uus8xyJJ9+oDx0nERotwbsWs/BULX/ggAF2aqdnSOmLykrVrMVcLuPL8tKzVr1Lpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijAX1J2k0NIdudtWmh8nuYPwX2sCg188GoTPueVnX08=;
 b=DkQg1PggeVSzBPx/8lD6jvBxK+pQBH0CUTsPfXqTrFD0XVYv24cuLP9dDO1B8nnmhtoypzktWKAAPJtzwT9s12ppui3JhIFKGvYnMO9nAofGu4VUNas3qbmdFpHY6Cfyj7/Ogkj1XfvauWHVJq7jh4aNUte5fFFpX79SJ6HJn0axUshrfqEp/t6a029hbDbAuBlqb2xwz/jKTKBH86FORHiaoz5KP3vLnUuo2Dd0fc4UsOC8sodRJLv9dWHAkIYCt1zvl3zO4CF1XiZczMkmlmCc6ZeF4QWHfoRbRMmzA7mmQTwNIS52lSBToLOvdfGEguOskiqKor0FhBa1JOQEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijAX1J2k0NIdudtWmh8nuYPwX2sCg188GoTPueVnX08=;
 b=H0sAdkC06x0XJvEn7XgCczQ2K0DPBChIb/9NmW7kLzeJ29U2TJch01IVtPwEWPYHIxf3e7Q7Hzd8+xiXRBR+/amtkri78eeybJgJrq8jZcKK2HrvHkGKU//YSry22+bjCqOohfbHCTBxeNVUU+3wwKgNJBb7drim9HHrcim7P+2eKFDggRymgs0LXdMZBqpxaRKNIMGEMV0nl+2xBBjTUouIZI+6dZtx7ni1DH8sRnDuDU2cOZ4yoNrTkuM1mE1ynjHv54EKyHm7Y6hV1jvbQnrtY/XOs4dD77Mect2tJwhbvx2rZwUqp0FGH4UiOVyqbK8QS/KBelR4tHBN1TZNGQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] qom/object.c: add object_class_property_add_uint32_ptr()
Date: Thu, 27 Aug 2026 15:33:29 +0100
Message-ID: <20260827143404.1393166-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f64817-8a9f-43a5-edd4-08df04485094
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hCQF2XpZlaiSxG7rPkU3Gn8X7sGhjBzel/P5jMSG981jq9VtZJIV7T+0ySBomZBHCx+DloiSviKiFaaTTBfckSJcu2c3N3DGEkAG+CUcNo/6mQroBsA4WsBWanod0i59YoYTOu6IkaF1hmLxNdoSwducrRgFwdl5up3GWZH8aMbT2/zcMylkZn7P+oEYSIgLsXcQjRY90rFXW+5zOi8AiYt+vs46X3G8rx+8DbFxuahrJaw7yaMQ4TMjTrm2u/FKi/nj5Vdq7fOjwfZ525uxU91x3zM30m1eb8QGcIYqSty499DBp33sa57uXfMHglsDUbj6fue3s0IfRbGc0zBlcKznGB4YY0Vuu5WafeWF+9f382qlaOda4XujC5HHRvf/MyFDdO9eafiUpAnVHdzeC0KknIoFBL/DpUfdskBgcNKoxHrVvWpkEJAn4rkgIy8YuwUw7deCIX3qGHr5JHAl7+HmyhBROCMfosuRreEN02jB9asZBgpwADvn4ju/B3xqGvdOPlo1UJc4+RaYh28XimI615Y/8QEZLOAjHpcbwf3j7lgt6+2Gb+IEVGfypZpJBEI1B2jMWs2mjNTDCurT0hfwNz5io9s/BTl8FcuFTz2w4O+Snjiem9QYjqdOQI5edmQAiIvOnQN+NTz6RdAtVS03GQ6H1bWJas72UoGCbKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlmT1RaRHZFR3dNQ0UwYjN1NzZrdWJkWWM0WjdRS1BaRXRIT2RueFg0Wmt5?=
 =?utf-8?B?dHRwMk9aVjVtdTBpMHpIS0JmSE16ZFhyTkE3Wk5lcnJFQkdnRVVkYzZSM3ph?=
 =?utf-8?B?UXRQSFgyaVJYUXM5dXo5ZDZKNWJrT3Q1Tkg1VHU1K2ZSNkw0Ylhmd1ZTcE5q?=
 =?utf-8?B?YTFBRW1maTQ3NjlnSGZjOElRTk15UktTVVdUb1dpZHFyKzZGc3Jhd0I5blJh?=
 =?utf-8?B?UjRpc3lqNDlwZ0JyaVNCUWxCRDQ3ZjVFS0drc0l1YVNXSUtkdDlidStWczJB?=
 =?utf-8?B?RUZrcllJbzhOay85OXQxMUlJaVB4YWlDTEJQbHQwODYwSXNZY1J4QmYzNjUx?=
 =?utf-8?B?anlJZU8rOTcwWjM0TVpHOU53WE85MEVoR0I5VStrOUlQOXJMS1V2eGVUbkR4?=
 =?utf-8?B?OW9FWHZnNzRQMnVWeitoK3Q2V0FENTN4OXI5RHdROVZQZFlsN1lZQS9vbUc0?=
 =?utf-8?B?Tk5NeDhZSkR1ZkRTSjg4dVY3d2lSK0NUNGV3TXF6RHNXTUdMNk1DaU9KZ09i?=
 =?utf-8?B?dkN2UEhxTmREbVNpcmNvT25TR2REWU9heE5SWHFlYnhJVHhUdk1KbFpkUmth?=
 =?utf-8?B?OGlsRkRKZHdrVUZNNDE2MGlXTnNXanhYMUo5K0lUUUFFUlVSSitPVEFLa0ND?=
 =?utf-8?B?OG50U0Y2Q2hpekFWUHpMaVZQbHdITytxd2NJUWFzdmFQUFN0bWE5VWgySFZX?=
 =?utf-8?B?VFNPQlBmdGc5M1Ewd08wNXNKZitQcjZxZlNDWUtIeldKakVZc05WM1ZWaFpS?=
 =?utf-8?B?djVzblA2VS9LMzdCZCtkK0E3YmowU2xDcTg0cUZzUDFJendobUhlMWtadUho?=
 =?utf-8?B?c2JScGRaOWpKcUhjQk5NSjdNSUJRWGNTWFMyeGIxQmZRcmsydDhNVXRibkRw?=
 =?utf-8?B?dExrYUN0b3VuQnpPaWZqL3BJeGFqV2N3NnRGOG8vcDZQWDRLVUlaNGNOK2hn?=
 =?utf-8?B?TVJuNllBMGZJRmZ0RUxZNTJpeU16OUpOQWJZN2ZkYVljZzZ1M3Z0TjBEOEpL?=
 =?utf-8?B?VitYOEZxb3FPYTlTbk9yZnpJSTdoV3h4MU5SNC90R1NpalA2Mk5rZ2hsQTMw?=
 =?utf-8?B?K3RScHEzeCtYNW1NWEUrSnhOclFUY1J4bDR3S0lMbTloaGdyZVY2eEJNZGt2?=
 =?utf-8?B?Mlp1ajZaWEhSQWlWcUZaNHpVdjQzNnhLVUdRd2xvcVpmU3J2ZEVTUkNoYWFE?=
 =?utf-8?B?aWpwRVo4Y2NkVlZCSU9naVpaL1ZZY2RnNW1oY05qdXZvVTVCNkUwVmdTS3dJ?=
 =?utf-8?B?S0F0SG9PTHBhUXJ3L21lVWtma2pydHRka2N0dW83V1JHdWJ0RXVibzNRMHdq?=
 =?utf-8?B?RXZiKzJWNmFZTFd2Snl6NXFQbzBEZTF1RXJFbTk5Tk56UTlvSG9QNWkvQWF5?=
 =?utf-8?B?cDdNb0RhNzF3VUMzZCtHRXZXRXhvN3FlUnl6WFhqeXJPQzNoTk9YNDdSUE04?=
 =?utf-8?B?RmhHWm15M2F0SlR4RDVxam15NjlBZm9zNFBsSDgxTVVMci85bEJMRmo4enJz?=
 =?utf-8?B?MmpQOEVkd2diRlJxY0tMLzh1NzNYaTNpM21EalJ0NmxaSmVQWStaNWpQNks5?=
 =?utf-8?B?VGl0bXEyc1ZqWm12cXRkeE9MUkh5RUd4eStUc0RsWnQzVW5sNll0aDUyNTlo?=
 =?utf-8?B?OXUwQXBHUFU3WURXUmFVdmlVVWRrMkdkQlRKN0orblZGYlpsemlUcUhKS1JF?=
 =?utf-8?B?WWFzeUlNUE5VSW1LdXN0RHAyU2lTMUg1RTJSenl0MEhyVkpNNlNVTVZSRVdQ?=
 =?utf-8?B?a3dPS3MyYUtKNFVBWUMvbEZoY3RLYWtQQTVYR3BzV3l1RFkzS3R2dUFmK0Q5?=
 =?utf-8?B?RlpyNTF6QlBWS2VqUDBRcmNySWV4cU1objNSMElKVXMvYjF4Z2k5YW44UDBo?=
 =?utf-8?B?TGZZNHJ2NVptT1VIaC9LakNGdS9UYUNNUnpJV0VlUlYydGczZWU3WEFKeTgz?=
 =?utf-8?B?TWNZU1hYU3QxSUZBcE9RNWRaQzVnVGlIMHA4bzVyMFJGUGczZWQ4VjRmTVUr?=
 =?utf-8?B?eWhHM1pwS29SUWhrTDA2RGw2bEx3R08zdjMxV1RZNWVZUjVJcEZuWFdyRnhN?=
 =?utf-8?B?ZUszMmgxOVk1dytNeDB2SkxxeVptRzFQTjhyZWFGTHBvMURDN0VJeHVIMDJ2?=
 =?utf-8?B?bXVvYUNDS1J1MUhFblB3QStSYklTV1UwUGRNYkV3SE9meGRtR0tnRHhNazlr?=
 =?utf-8?B?WXNwd1Exazc3MytoN0hyUzZUY2huajRNNUlaR055WTV5Z25WMnhLQWNoUnNz?=
 =?utf-8?B?OERVa2g4c2lNNUNNRG5mTkR6THVrcTlnY3ozV3AwR2VEMHZUZDlTMGFEUHFh?=
 =?utf-8?B?WUFvSkdGR2tnTnk1YXhYa3Y3SEFuVENjbTZHYzd3SVRzclVhMUZ6dXcySG44?=
 =?utf-8?Q?TKIkcXbJX3FeZWQM=3D?=
X-Exchange-RoutingPolicyChecked: fRbNWh4bZdKUcbKskzbx9wZfKbIvN5nQXGKhV027Pbe4v8C3k+IPzDPayHU2AiG0m6CD+3j9QkNtUicU3iMa57uyE3jR5yQ6QvBQsdtnr4AgygFZMGH12uMjm4AD/Cn5u6hLPV5WWr2W3drcY6G9OJr2N2AMYnkCfLQquASlTX4Q7R3Pd5nscZz0FsJdWHJnGvErvoGsRRVK4MlzTRUPxJkqGQj0St8x0p0pjU/169Awkmjkf5SgaCgJyAZB+eVra9CZNcr2PjGXxChV3yI5npucIDmc3feknW1Ftuq/2JdQ6VIEVXwkfLJdLhconbSAI9qTG7rVOTODzTYuR/d/bw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f64817-8a9f-43a5-edd4-08df04485094
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:34.7679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvFdtTDnsiMuoocbKCCS/obg4bmLMxNEHmD+dGrV4fBt2ykdjGRBMvJTCZakmqiRPRbGIUul1LYHHvSQOd59SzXaI1NTg7K/W0Luyu3R1CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXyzngQmKuy60X
 lX1dKvOv6yuyIBUE8XYML779cyaBhUQTQ7gI1zuuu7M4a3T4SqXTVM5+fw2nCARKeYhdgPGcAS2
 3uASxEOintTkAur3caic0s+YAtHFNhs=
X-Proofpoint-GUID: WfYmtriW3QMOOCDAaToVr6pbn32KN5P3
X-Proofpoint-ORIG-GUID: WfYmtriW3QMOOCDAaToVr6pbn32KN5P3
X-Authority-Analysis: v=2.4 cv=DNm/JSNb c=1 sm=1 tr=0 ts=6a904afc cx=c_pps
 a=H2sYsg3hgj+L3aiWSAFbmg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX5TUCj8rX7rJW
 iV3yLET4jEY0YcbBU3EzbLKTjRXsjmM0AR8Eof1bbrt1Q4dydYsqeZ9Nqpar3k6pG6uIk/mXCcp
 5AIix+e8BPeR9GH8nAd3yam7H6dG1aokAW6iBsOmF4MjRA4Zu6Dg/m4jh43cyTet8q4pByO9Da5
 6Uias9r6YH7SjW+de7t6ZfQ6Io3wf8YDeb4S4rO4nsou/m5IZBXrlLUDjWeAhK7XTVbcHaxy+hD
 S36py5lMK1Rj5b1vi1lv5+fzgN6B3kELE7NVKmty+4Eqj+As3BrIXKFkeCTABygaf6TzbweSQzr
 RPGKiiWuMjoIDB63/ilRFmtZpRL2eWamvXy5LfZIm0Qa/fbZMibH8CW+CRHkuFjuBDLCRl100s5
 EQvUHdLG9g6r0RTfosjH59crOs9AVLJfYQHhPP05ff1Lq9pDa8Mt2UX0CRrwy4cD/mG5xhAKlUC
 Ua2/ITz2WEteijD3Npw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This adds a class property that references a uint32_t within the object instance
and is intended to be a replacement for object_property_add_uint32_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-9-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 67ccd2b08f..8dead29284 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2129,6 +2129,24 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint32_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint32 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                    const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint32_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 271c2916b7..f91764aaa7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
@@ -2871,6 +2872,26 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint32_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint32",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


