Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807A1EDF148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqp1-0005ku-Hw; Fri, 13 Feb 2026 05:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqp0-0005jj-Fx
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:54:50 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqox-0001jm-Nf
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:54:50 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DAVbXo752466; Fri, 13 Feb 2026 02:54:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6Sp+T4sNXGIrXx9HvV75hpUqVPwiKie2Lr8RV913G
 t8=; b=TvL35hMuYH+QdslIOs0jSZOaNgEgz7XT4QMhTLjGT540XsscJ4h4buDik
 gYcm5h2V1YVwpDIovxxlCXBb36G+l/DUb3EdtMaQSAXqXyL4Bhwq3/DkbvCQoLKB
 JKwPbAAtPLT0UiFltZR1CKVO7zxHxj3d62TkD2eN29tlFHQkeTxpPoWd/pR4cJhL
 //Dh++y+8niKqp8mxz0lbRBR32DdLmtgrTz3SJ/WsfQQ5AnK5ImogArrSD9idmdf
 ZJjRLWuPy6qqKBs5QsdrRgQxVxXowG+4UrUabVUp/ds1TivkbgyW1WPyhJ+cnIxP
 bj7SoR6P+dI+Ly/XWWAuL/k0QRsaw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020126.outbound.protection.outlook.com
 [40.93.198.126])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc8qej-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:54:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzfNXhpt5MN5pjVdkOqne/1wUcx9ObRa4MUr9yL2Mm31EmnSe2cgKjORN1gqauZtdEYKniQ5xhqqOKtq7TnoqS2Tf6GRfu/VlXMcPeDWSj2ccfj6+8SEZim4oMWwshiHUTEHN516ZA88yrnq0QkFhIaAJz7V4ZZyArIIzKSfFhbJQbDRLh23X01kvIrU1ZB2cTBoYu9ZaJj0lRBRxLGk5XA7S4wuGagE+hbcrGg06RJyo70bYUJJ1cIFAbH4+QqtJgzvCw96+FeJdwvUdlT3WYuoztcem4WFsJSnRKj3tGZwmh0xFMXnUQTlD/7uRXn5qT2HAWvPdXKleZqJr7SZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Sp+T4sNXGIrXx9HvV75hpUqVPwiKie2Lr8RV913Gt8=;
 b=gXCmDnsGiAzWeNMFXvyiReLFcNCc09pVt+Q8zEaSr0JxtHY60EPDZjW/y7i3mx53o46ewV1Ikwt3bqyXagW8Z2lCjgEcD3kCko8MVAQExV01RrETm6otf2mC0IGlotUbCp3MTE0q0zQicTet8X3ETzLoWxU+S8v40R2GS1l9zTHIHQvIj5rqnz0HhHdxXSYaX/SR8XZYWHjK85dETLv1Bv7bm1y2LuItCwGer0OpJy4nscqeGVWjrNB6Al9ZBbnyGci8P5zSSxtvvS9s9lI1X5Yu88e9pK5HQSoP+EEADvffUG/JeyHF1SL2Tx9LcuODsbb5LrJzyifuaNHngLVZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Sp+T4sNXGIrXx9HvV75hpUqVPwiKie2Lr8RV913Gt8=;
 b=y0qvgHL/8L6aUg8B065LpwkYZ9h/bW8FprhCk74lT3L8YXF98JWsaJSWF8VQo3xhW7t1QGksnEoROWuzyWhrVqx+NWcIUolMyA6BMFJu4GtUV+aczEzuKkypkM3ANl+U8xdWScKLZgw2p/rrsxGIA4BbU5tQN7ybEGCVt2oussr5Pl3BsSvj7wma7K5xsqxeZJVYLjq9gcXGjtN/MbA4PDmFomRQRY9qm+Z5kIfB8xetXEIPG9EZKkVuDtNSpQj7cXhe02W/8+PinyRA7A20FsspT3/QzuhuwZdGCD1LyEC47jscTdwXkS++htm90CInWTyZVKO0lR4KtPe/Ry2+zA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11162.namprd02.prod.outlook.com (2603:10b6:8:2f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:54:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:54:40 +0000
Message-ID: <d6b18d6b-c443-4e8c-9c4b-2ef588b10038@nutanix.com>
Date: Fri, 13 Feb 2026 10:54:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/43] audio/alsa: replace custom logging with
 error_report and trace events
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-19-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 1838d5d2-44da-4701-7a6a-08de6aee499f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjgzZGZNNVpNekdCeTB5TGFvTlYrckV0Y09mVzQrdG55VTZIcGZuYkI3MjlF?=
 =?utf-8?B?dmJ5UGNPNWphTEVwL0RVN29jZTI1dkxESzNYNDhXM0tmWUhUTndGRE5TR0hO?=
 =?utf-8?B?L0JGWDJ0c0p6TVhDcUh4Q0RGajhEMHFEQ0JKN05MeWxMOGtPek42RVJaZ3Nn?=
 =?utf-8?B?WDU0dmlRV0NRYjNObDNFd0xja3hpVGVPc1oyajZJTkpuL2RLekdlWmJvSTRM?=
 =?utf-8?B?UjMxSUZjVTg0RFhiU2Z6UE1RMTJYL2dsMG1XTGVnWURqZXlRR1VYc3d1VlhV?=
 =?utf-8?B?blFVUlp6QXUxMnR0b3B6VmFDS2xQOVdhU0V3YTBPNnIzTE42US9wYzlDcWF4?=
 =?utf-8?B?ZlVoNlB1bnd5NFJuSmNubkVHRm9pNFp1ZW9acU9oek9vdy9najdZNzIxaFZ3?=
 =?utf-8?B?VDVFcXB4TVFDUWx4MUI0WEpHRmlLU3BINXF1SzRyRk9QRHovMUJENENoWllX?=
 =?utf-8?B?ZjZ0MVVtZWE1QmpmUWdGMFpPa1lFOGdONXE5aGtYQURVMzQ5cmVzY0dUbTdM?=
 =?utf-8?B?Mk13d0VSdjZVM1ZYUFVZYUJ3eDVoZitqMWdUMFpuby8zQ1VwK0pvdzE5S3FK?=
 =?utf-8?B?T1BrZ05QSFZMaUFrNGlhNlJ3Nmp2Skgxa2psNkYrVURIb1VRbjRxdWszZVE4?=
 =?utf-8?B?aDFYVnlidnFvSktrT1ZnckRxcGZNMGFiTFJ5Y2VHd1N0QnU3dFR2U0ZPYXhl?=
 =?utf-8?B?bkptWTk1cmMvVjViRy9sTUlTTSs5TTZQcWNpa1dOcXF0bjhaWmY5dUFabUNL?=
 =?utf-8?B?c2ZnbFRacFJzZHlKUmp5TStrUjJQR2l4V3BPeTR2MzVHZkRRdmZSVFBjdkJX?=
 =?utf-8?B?aUFnb3FrZ2ZEbHVvZXRZeEdXclFDNGZtR0drNjJWU0pjV0Vnc1kxcGJNOUs4?=
 =?utf-8?B?aWxKOE9EOFpMenI1Wm5HUDdCcjZDZlhQdWN3bmg5M2dtcUkxaUxpNFNFZkNn?=
 =?utf-8?B?OW5GZ3JJNzlGeUVYNVBuR1lmbHV0SmEzUHpRQzJPRjM2MVBIT2Q0OFhDQStX?=
 =?utf-8?B?dmZvYXRpR0tCSThDVU1sZDNaVGloYlRXSmh2dFVXMXdBTXAwS0k4RVh0OHdS?=
 =?utf-8?B?TmpvMmlMdUFGZ05TVG1YMDZqenNTUWlqUUlkdU0rR0FRQjBxRDkwUVRDWWQr?=
 =?utf-8?B?a2RvWElRNllnVWpiUC9YbXB2V0hXWnNkMElOVks1dTY2K1Z2czNRWWJqemVH?=
 =?utf-8?B?c01odzlvR0ZjVUVzOTBYREptd1BVQzNFdXgrdjdWWElZWjdTVWJRV0VvUE8x?=
 =?utf-8?B?UFMvQ3ZBd2pOZ09ZVXFpYUJWR1B2Rzk4a2NoaUc4TmhzVTBSRFB2c0ZGWEMr?=
 =?utf-8?B?blZyZzh1cmcvQmphNlBWMmFOL1VZUllqSnV3dDMyeW5ZSU9wUVQyd2lHZFlD?=
 =?utf-8?B?TnBlOWNTcitFUmFPaXlURm90djNwNk5Ja29IMEZWcWNoSEJFeVp6VjZlbWo2?=
 =?utf-8?B?MFljWTYvNXhnaHYzOGl4SFdRV3JUSkRXSU5qT1JFSjhFMmdGWnpDQmJzMlp2?=
 =?utf-8?B?RUdUS0lQd2ZqVkxLWFpXY3lqWDlBTkpGazNJTkFiOGhUK3FvYjNaK1U0d0Y2?=
 =?utf-8?B?ZE1KTnptekNtSVZ6OXNJN3pnOWYyZVh3bmZmaHVlUS9IN0VJeWU3eWcydzRi?=
 =?utf-8?B?Q0FDbWpuMmNQaG9DeGw2M2R1M1RDNVJvVkVMRUlQVEEzbXVFNFRmdFNzSUd2?=
 =?utf-8?B?ZGtvMXZvblFVTGg2OWN1MzRQVURNWmlxT3lSL3RtOTdTcG1PSDB4ZG5ZaWdT?=
 =?utf-8?B?bUcydWhmclI2ckpXb3RTa0ZWYkk2eHZscC8zYTVobG50a1A2SDQ5aldNQmNu?=
 =?utf-8?B?M1VjNFQvbmJFQ1lIRjJrN3VpQlVLeGw5Ymx5Zm1rMytrQlJkRW5mSlh4YUxJ?=
 =?utf-8?B?SFMvdGpLRlZJODI5OTBycnZNSG5pL2VTU1VhZ0tJVzBUeGZmQUh3enQ3aTlV?=
 =?utf-8?B?cWtEUlMzdENTTEc3QU95TkRjYnpzUXZadSswOWJQZDVXTXJKalFINFkxNFVS?=
 =?utf-8?B?MXBWSVRHRlVoUUVQaHJ2ZkcrUk0rSGo5eW5GRWZWU2NQVjZUaGJ5VWowVDlp?=
 =?utf-8?B?bHFINkZWblp5Wk51Zm12VDNPWkpjOGZUVTY4ZlI0S0t5OWhZdlVqTHYrUW41?=
 =?utf-8?Q?WPks=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZZUmFqRmZ4bzdSdUN3bkozOEwxVHFFdkZmZTJjemt0Y0pjand0Z09tUllY?=
 =?utf-8?B?MFByZjFxMGM2b0xUUWZFUHlBd3V1cTgrSHZScFdUYUVwTTk1WkEyTnRoWFFV?=
 =?utf-8?B?bWJjT2YrSDIrc24xYzNWdTlldmFaeDVja29hZnhZOGViTWV5YkxyYWszeXdG?=
 =?utf-8?B?TUcxczhDc2xjUzJaT243dzJLTk8zbThRSDQxc1habFc3clBObzk1RDRjcklF?=
 =?utf-8?B?M3RkL3ByQ1cvREx6WEUzQkF2Y2ZFelEybUZJM2NydGFjQzgwRy9NejQ0UUNk?=
 =?utf-8?B?bjNYOEtmeUlIV0ltS1hpWDZHSi9pdzZHWVJldGxidVk3dnFSdFdQYkhGK1p1?=
 =?utf-8?B?bEEzaUhDbU1TcTFjTzkyYlhUZXlUbzFXNmZtVGhRV3RQaFdRWHVWSjZuQ1Ex?=
 =?utf-8?B?VS9Ib29MZzJFVXBrQjlZdXFxM3BTc3JrV2xGS0t2N3M0OW4zU2RrVWkrK1ZD?=
 =?utf-8?B?UUtRdVJmMGhYd01pNlljQkd6S0QrQlFsQStyd2NvUGNHR1ZNUHhab0kwdzh3?=
 =?utf-8?B?K1h0dTUxblZrUjN5MzYvZE9sVDl0TE5lTjJWZHQxS1FmcnNtREFiV0I0VzVm?=
 =?utf-8?B?U25NdURRdDFIVytXTG81aTFJU3hOQ1dKL29LQ2Y1RUt3LzU0YTRxUWJHODA3?=
 =?utf-8?B?MCt0aERYZkFQdTNyczdUZ2FaRWQ4NGZacm5sQjl2anliWElOaU9uYnBlTFhU?=
 =?utf-8?B?R3ZzZURPSGV3ajNVK01pL3pzQTFOUmdGU2dkeEtQNG9yclFJSm5DR3RvV1F0?=
 =?utf-8?B?R3MxeGV2UkQ1L0xjNGordHZXWTJ4TGkwaHorWDN2QlFaVnhMb28zMGlXL2RB?=
 =?utf-8?B?eWFTWW5OQWtRd0tETHFCdVhPZVF4eVd4SE1iVUtqdk9vQWlZc1lFZVd1MTBy?=
 =?utf-8?B?OXJVcDhPUVQvUDkyeFlWQmtTQ0F2L0JhcXpJYWRyOENhSk90N0grZTdZUWc0?=
 =?utf-8?B?VXVLYWpyaW5XM0xwRTcwdkRWdzd3aVBiM053OExVRVYxbFlSdzdKVjlRTVdY?=
 =?utf-8?B?YjRaWmxVQnkzOGxNUFpMb3NwcFlJZFFIQWEweUpxMzdNT1k4eDZwQmJpSDFh?=
 =?utf-8?B?SktZbUxYSEdOME84dUhwMkljRmFkbFBxdTNWanN4N3c2a25RU1JpdUJRdWdZ?=
 =?utf-8?B?N1VDd1BQQWVMeXYzZVR0Mk0zZDgwZlhxMXVWMCt3RzZOMm9GU2REWmpaNWJE?=
 =?utf-8?B?WnRzbmltb01BTkVzWXFUNW1wVTFqRjFOZFZ4dFBrVG5oc3V4WGhEcGFhODIx?=
 =?utf-8?B?aTI0eC9PclBSR2ZzdHpNOVVVQi82ZnNtYVdrM1NJVjhFdy8wdDNUclFPZ3BM?=
 =?utf-8?B?YTNHbWxDeXF5bWhodkFYMVlrbEZXQXphbjJqZjR6MXF1aS9RdHpoVkVwUVlL?=
 =?utf-8?B?dzZoMDkvRWNCUHptOXVDdlZRZVRLVG5EOGFOVzZMVkdydi80bCtzSEdGbDNQ?=
 =?utf-8?B?OGNTT0VwRzQ5ZGo2cFlnT0ljcnB1WmV3RENteExQeWQySFNOMkpzck85NmZu?=
 =?utf-8?B?emw4L0R4ZGQ4OUxQYjNERk1RWEE0cnNMMmNkR09oSGRRTUNCZHBPQ1VVSzVG?=
 =?utf-8?B?a1BrRWdJQlBnUkdqUUl3WTUrckFrNHZpMWNqbnIwV1RxY1B5U3NlU3c4Z1Yx?=
 =?utf-8?B?clRuOGJrMHNNMHN6TE9XTFdwK0gzY1duYllLSkJmbmx4YjFEUVZlQmhRRXJG?=
 =?utf-8?B?M1NSS3dHT2lXWjBicGVXQ0tVeWhJNDZBY0xiTTJORXhHRWdxMlhlNG5ydmRM?=
 =?utf-8?B?OEtETU9RN3Q5b2s0aE5SZGZFYjd1K1MzWGs0cVZtRGJZT3h3eUtPVHpkamdS?=
 =?utf-8?B?UDhTUllSajBSMmMwQ3FtU0krTFJQVmlOelVVZkpla0s0RVowbzJnRHpHTTFZ?=
 =?utf-8?B?MGt4a1R0VXFCdmptaUZIVVpadWdyL2UrRGZ2RWtzL1lDVW13ekY4SUV1TzU2?=
 =?utf-8?B?ZURLWGE5bSt1emRFVDRERkZaaU44L3NIaFh5dGEyU2MyOW1NYTVpQzhCODZh?=
 =?utf-8?B?YndNMFlWN055aE5HMkZvR0pqTVdSamtxTUdlendydlNNV3ptU1Q5TkU1MVli?=
 =?utf-8?B?MHp5ZExzbmllRkVEN0M5MjU1aHlPcU04R3VHV2dCeW9EOTFIQ1VXYkUrL3Vs?=
 =?utf-8?B?MHpaQUhHUGUwN05KSGdmK2dKbXA2bGFEQktac245RDVSZ1FIUnR0M2dSbU50?=
 =?utf-8?B?Mko1WThMZWNkZGdBK2Q1aHd2cElQQ0FrZzE0cmpvKytuMlNOenYyTkFDNElC?=
 =?utf-8?B?WmdrdjV6S252NnhyTmVEaU81YnlvNmdIckl3MVprYU04QVFyeXN5VGppd09Q?=
 =?utf-8?B?TlRZcWdJcDYyZm5zSVVDek40YnR5T2xzckJsVVJ1bE1kRjZRMnVqVkxCcDQ5?=
 =?utf-8?Q?4PIRf+oVdZEcpZ8Y=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1838d5d2-44da-4701-7a6a-08de6aee499f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:54:40.4118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8TLbdKtDQ+40EBbR6IKIF0mMB0yGQKKaFe9tCsijTteR85LB90hx8g63egRWoA0HcNkZqB60joa4D9zmtCAR1lLVoV2AvvkO3auCmmxspg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11162
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698f02f1 cx=c_pps
 a=zTPsRPtK75HwG7WtZKDGLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=bfb8Zk7S-A2lpaqRZ-AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VVYD5XVq-NqhBDmoflUCgTyMt13efRy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NCBTYWx0ZWRfXxQahbANfHuRJ
 BileYIt0M+uTsviixKeoovd8Ed9PweIZj16c6vuKD4PQSJW2KnE+1P+t6l/WWl6ehMfkyXp9Sli
 ZhqSd/zVRqKK79jTCs+ZxV74S4yZw0qMyMbToUj2qdxsgEILCCfSz/KML3Z569PvrEWlheuMOUr
 1fqihhh8zP25B7W2wlMzIe3Rm72MUZwFjm2gIucV9aHHoV/VLg0Qys7a73ALIOUE4EDraBfwX/v
 si0vCgY98Zzc3IyuMScZ/w6EzVbvukZZgaQI3EA/7xC/4qyIet5O+6K+LGFBLsW4jBiTTXTTTlW
 Btmz3RRJTvhJ4mAukjRochRZtiKQM5Fidxpj1HDEZAViumH4fOOrfRlkyJj7pLEFVcI0NHdipUY
 Sjsaaq8EE/SiUENNceDMiL8IZsVz5PJ0CS57O1wz+F/Iq0OEB7UaLSlkeBXOFeZGxHIlCA+NrzF
 2dQfMjjUMvbuo/vbzNQ==
X-Proofpoint-GUID: VVYD5XVq-NqhBDmoflUCgTyMt13efRy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The ALSA audio backend uses its own logging infrastructure (AUD_log,
> AUD_vlog, dolog, ldebug) and a custom alsa_dump_info() debug helper.
> This approach is inconsistent with the rest of QEMU and makes the
> output harder to filter and configure.
> 
> Replace the custom logging with standard QEMU error reporting:
> - Use error_report() / error_printf() for errors
> - Use warn_report() for non-fatal warnings (invalid formats,
>    rejected parameters, unexpected states)
> - Convert ldebug() calls and alsa_dump_info() to trace events
> 
> Remove DEBUG_ALSA and AUDIO_CAP macros which are no longer needed.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/alsaaudio.c  | 169 ++++++++++++++++++---------------------------
>   audio/trace-events |   5 ++
>   2 files changed, 72 insertions(+), 102 deletions(-)
> 
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index d3697a148da..3058af58e0b 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -26,17 +26,15 @@
>   #include <alsa/asoundlib.h>
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
> +#include "qemu/error-report.h"
>   #include "qemu/audio.h"
>   #include "qom/object.h"
>   #include "trace.h"
>   
>   #pragma GCC diagnostic ignored "-Waddress"
>   
> -#define AUDIO_CAP "alsa"
>   #include "audio_int.h"
>   
> -#define DEBUG_ALSA 0
> -
>   #define TYPE_AUDIO_ALSA "audio-alsa"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
>   
> @@ -81,33 +79,29 @@ struct alsa_params_obt {
>       snd_pcm_uframes_t samples;
>   };
>   
> -static void G_GNUC_PRINTF (2, 3) alsa_logerr (int err, const char *fmt, ...)
> +static void G_GNUC_PRINTF(2, 3) alsa_logerr(int err, const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> -
> -    AUD_log (AUDIO_CAP, "Reason: %s\n", snd_strerror (err));
> +    error_printf("alsa: ");
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
> +    error_printf(" Reason: %s", snd_strerror(err));
> +    error_printf("\n");
>   }
>   
> -static void G_GNUC_PRINTF (3, 4) alsa_logerr2 (
> -    int err,
> -    const char *typ,
> -    const char *fmt,
> -    ...
> -    )
> +static void G_GNUC_PRINTF(3, 4) alsa_logerr2(int err, const char *typ,
> +                                             const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
> -
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> -
> -    AUD_log (AUDIO_CAP, "Reason: %s\n", snd_strerror (err));
> +    error_printf("alsa: Could not initialize %s:", typ);
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
> +    error_printf(" Reason: %s", snd_strerror(err));
> +    error_printf("\n");
>   }
>   
>   static void alsa_fini_poll (struct pollhlp *hlp)
> @@ -130,7 +124,7 @@ static void alsa_anal_close1 (snd_pcm_t **handlep)
>   {
>       int err = snd_pcm_close (*handlep);
>       if (err) {
> -        alsa_logerr (err, "Failed to close PCM handle %p\n", *handlep);
> +        alsa_logerr(err, "Failed to close PCM handle %p", *handlep);
>       }
>       *handlep = NULL;
>   }
> @@ -145,7 +139,7 @@ static int alsa_recover (snd_pcm_t *handle)
>   {
>       int err = snd_pcm_prepare (handle);
>       if (err < 0) {
> -        alsa_logerr (err, "Failed to prepare handle %p\n", handle);
> +        alsa_logerr(err, "Failed to prepare handle %p", handle);
>           return -1;
>       }
>       return 0;
> @@ -155,7 +149,7 @@ static int alsa_resume (snd_pcm_t *handle)
>   {
>       int err = snd_pcm_resume (handle);
>       if (err < 0) {
> -        alsa_logerr (err, "Failed to resume handle %p\n", handle);
> +        alsa_logerr(err, "Failed to resume handle %p", handle);
>           return -1;
>       }
>       return 0;
> @@ -170,7 +164,7 @@ static void alsa_poll_handler (void *opaque)
>   
>       count = poll (hlp->pfds, hlp->count, 0);
>       if (count < 0) {
> -        dolog ("alsa_poll_handler: poll %s\n", strerror (errno));
> +        warn_report("alsa_poll_handler: poll %s", strerror(errno));
>           return;
>       }
>   
> @@ -183,7 +177,7 @@ static void alsa_poll_handler (void *opaque)
>       err = snd_pcm_poll_descriptors_revents (hlp->handle, hlp->pfds,
>                                               hlp->count, &revents);
>       if (err < 0) {
> -        alsa_logerr (err, "snd_pcm_poll_descriptors_revents");
> +        alsa_logerr(err, "snd_pcm_poll_descriptors_revents");
>           return;
>       }
>   
> @@ -215,7 +209,7 @@ static void alsa_poll_handler (void *opaque)
>           break;
>   
>       default:
> -        dolog ("Unexpected state %d\n", state);
> +        warn_report("alsa: Unexpected state %d", state);
>       }
>   }
>   
> @@ -226,8 +220,8 @@ static int alsa_poll_helper (snd_pcm_t *handle, struct pollhlp *hlp, int mask)
>   
>       count = snd_pcm_poll_descriptors_count (handle);
>       if (count <= 0) {
> -        dolog ("Could not initialize poll mode\n"
> -               "Invalid number of poll descriptors %d\n", count);
> +        warn_report("alsa: Could not initialize poll mode: "
> +                    "Invalid number of poll descriptors %d", count);
>           return -1;
>       }
>   
> @@ -235,8 +229,7 @@ static int alsa_poll_helper (snd_pcm_t *handle, struct pollhlp *hlp, int mask)
>   
>       err = snd_pcm_poll_descriptors (handle, pfds, count);
>       if (err < 0) {
> -        alsa_logerr (err, "Could not initialize poll mode\n"
> -                     "Could not obtain poll descriptors\n");
> +        alsa_logerr(err, "Could not initialize poll mode: Could not obtain poll descriptors");
>           g_free (pfds);
>           return -1;
>       }
> @@ -298,10 +291,7 @@ static snd_pcm_format_t aud_to_alsafmt(AudioFormat fmt, bool big_endian)
>           return big_endian ? SND_PCM_FORMAT_FLOAT_BE : SND_PCM_FORMAT_FLOAT_LE;
>   
>       default:
> -        dolog ("Internal logic error: Bad audio format %d\n", fmt);
> -#ifdef DEBUG_AUDIO
> -        abort ();
> -#endif
> +        warn_report("alsa: Internal logic error: Bad audio format %d", fmt);
>           return SND_PCM_FORMAT_U8;
>       }
>   }
> @@ -371,29 +361,13 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt, AudioFormat *fmt,
>           break;
>   
>       default:
> -        dolog ("Unrecognized audio format %d\n", alsafmt);
> +        warn_report("alsa: Unrecognized audio format %d", alsafmt);
>           return -1;
>       }
>   
>       return 0;
>   }
>   
> -static void alsa_dump_info (struct alsa_params_req *req,
> -                            struct alsa_params_obt *obt,
> -                            snd_pcm_format_t obtfmt,
> -                            AudiodevAlsaPerDirectionOptions *apdo)
> -{
> -    dolog("parameter | requested value | obtained value\n");
> -    dolog("format    |      %10d |     %10d\n", req->fmt, obtfmt);
> -    dolog("channels  |      %10d |     %10d\n",
> -          req->nchannels, obt->nchannels);
> -    dolog("frequency |      %10d |     %10d\n", req->freq, obt->freq);
> -    dolog("============================================\n");
> -    dolog("requested: buffer len %" PRId32 " period len %" PRId32 "\n",
> -          apdo->buffer_length, apdo->period_length);
> -    dolog("obtained: samples %ld\n", obt->samples);
> -}
> -
>   static void alsa_set_threshold (snd_pcm_t *handle, snd_pcm_uframes_t threshold)
>   {
>       int err;
> @@ -403,23 +377,22 @@ static void alsa_set_threshold (snd_pcm_t *handle, snd_pcm_uframes_t threshold)
>   
>       err = snd_pcm_sw_params_current (handle, sw_params);
>       if (err < 0) {
> -        dolog ("Could not fully initialize DAC\n");
> -        alsa_logerr (err, "Failed to get current software parameters\n");
> +        error_report("alsa: Could not fully initialize DAC");
> +        alsa_logerr(err, "Failed to get current software parameters");
>           return;
>       }
>   
>       err = snd_pcm_sw_params_set_start_threshold (handle, sw_params, threshold);
>       if (err < 0) {
> -        dolog ("Could not fully initialize DAC\n");
> -        alsa_logerr (err, "Failed to set software threshold to %ld\n",
> -                     threshold);
> +        error_report("alsa: Could not fully initialize DAC");
> +        alsa_logerr(err, "Failed to set software threshold to %ld", threshold);
>           return;
>       }
>   
>       err = snd_pcm_sw_params (handle, sw_params);
>       if (err < 0) {
> -        dolog ("Could not fully initialize DAC\n");
> -        alsa_logerr (err, "Failed to set software parameters\n");
> +        error_report("alsa: Could not fully initialize DAC");
> +        alsa_logerr(err, "Failed to set software parameters");
>           return;
>       }
>   }
> @@ -451,13 +424,13 @@ static int alsa_open(bool in, struct alsa_params_req *req,
>           SND_PCM_NONBLOCK
>           );
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to open `%s':\n", pcm_name);
> +        alsa_logerr2(err, typ, "Failed to open `%s'", pcm_name);
>           return -1;
>       }
>   
>       err = snd_pcm_hw_params_any (handle, hw_params);
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to initialize hardware parameters\n");
> +        alsa_logerr2(err, typ, "Failed to initialize hardware parameters");
>           goto err;
>       }
>   
> @@ -467,18 +440,18 @@ static int alsa_open(bool in, struct alsa_params_req *req,
>           SND_PCM_ACCESS_RW_INTERLEAVED
>           );
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to set access type\n");
> +        alsa_logerr2(err, typ, "Failed to set access type");
>           goto err;
>       }
>   
>       err = snd_pcm_hw_params_set_format (handle, hw_params, req->fmt);
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to set format %d\n", req->fmt);
> +        alsa_logerr2(err, typ, "Failed to set format %d", req->fmt);
>       }
>   
>       err = snd_pcm_hw_params_set_rate_near (handle, hw_params, &freq, 0);
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to set frequency %d\n", req->freq);
> +        alsa_logerr2(err, typ, "Failed to set frequency %d", req->freq);
>           goto err;
>       }
>   
> @@ -488,8 +461,7 @@ static int alsa_open(bool in, struct alsa_params_req *req,
>           &nchannels
>           );
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to set number of channels %d\n",
> -                      req->nchannels);
> +        alsa_logerr2(err, typ, "Failed to set number of channels %d", req->nchannels);
>           goto err;
>       }
>   
> @@ -501,14 +473,14 @@ static int alsa_open(bool in, struct alsa_params_req *req,
>               handle, hw_params, &btime, &dir);
>   
>           if (err < 0) {
> -            alsa_logerr2(err, typ, "Failed to set buffer time to %" PRId32 "\n",
> +            alsa_logerr2(err, typ, "Failed to set buffer time to %" PRId32,
>                            apdo->buffer_length);
>               goto err;
>           }
>   
>           if (apdo->has_buffer_length && btime != apdo->buffer_length) {
> -            dolog("Requested buffer time %" PRId32
> -                  " was rejected, using %u\n", apdo->buffer_length, btime);
> +            warn_report("alsa: Requested buffer time %" PRId32 " was rejected, using %u",
> +                        apdo->buffer_length, btime);
>           }
>       }
>   
> @@ -520,43 +492,43 @@ static int alsa_open(bool in, struct alsa_params_req *req,
>                                                        &dir);
>   
>           if (err < 0) {
> -            alsa_logerr2(err, typ, "Failed to set period time to %" PRId32 "\n",
> +            alsa_logerr2(err, typ, "Failed to set period time to %" PRId32,
>                            apdo->period_length);
>               goto err;
>           }
>   
>           if (apdo->has_period_length && ptime != apdo->period_length) {
> -            dolog("Requested period time %" PRId32 " was rejected, using %d\n",
> -                  apdo->period_length, ptime);
> +            warn_report("alsa: Requested period time %" PRId32 " was rejected, using %d",
> +                        apdo->period_length, ptime);
>           }
>       }
>   
>       err = snd_pcm_hw_params (handle, hw_params);
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to apply audio parameters\n");
> +        alsa_logerr2(err, typ, "Failed to apply audio parameters");
>           goto err;
>       }
>   
>       err = snd_pcm_hw_params_get_buffer_size (hw_params, &obt_buffer_size);
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to get buffer size\n");
> +        alsa_logerr2(err, typ, "Failed to get buffer size");
>           goto err;
>       }
>   
>       err = snd_pcm_hw_params_get_format (hw_params, &obtfmt);
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Failed to get format\n");
> +        alsa_logerr2(err, typ, "Failed to get format");
>           goto err;
>       }
>   
>       if (alsa_to_audfmt (obtfmt, &obt->fmt, &obt->endianness)) {
> -        dolog ("Invalid format was returned %d\n", obtfmt);
> +        error_report("alsa: Invalid format was returned %d", obtfmt);
>           goto err;
>       }
>   
>       err = snd_pcm_prepare (handle);
>       if (err < 0) {
> -        alsa_logerr2 (err, typ, "Could not prepare handle %p\n", handle);
> +        alsa_logerr2(err, typ, "Could not prepare handle %p", handle);
>           goto err;
>       }
>   
> @@ -574,11 +546,9 @@ static int alsa_open(bool in, struct alsa_params_req *req,
>   
>       *handlep = handle;
>   
> -    if (DEBUG_ALSA || obtfmt != req->fmt ||
> -        obt->nchannels != req->nchannels || obt->freq != req->freq) {
> -        dolog ("Audio parameters for %s\n", typ);
> -        alsa_dump_info(req, obt, obtfmt, apdo);
> -    }
> +    trace_alsa_info_params(req->fmt, obtfmt, req->nchannels, obt->nchannels,
> +                           req->freq, obt->freq);
> +    trace_alsa_info_samples(apdo->buffer_length, apdo->period_length, obt->samples);
>   
>       return 0;
>   
> @@ -601,8 +571,7 @@ static size_t alsa_buffer_get_free(HWVoiceOut *hw)
>               }
>           }
>           if (avail < 0) {
> -            alsa_logerr(avail,
> -                        "Could not obtain number of available frames\n");
> +            alsa_logerr(avail, "Could not obtain number of available frames");
>               avail = 0;
>           }
>       }
> @@ -643,8 +612,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
>   
>               case -EPIPE:
>                   if (alsa_recover(alsa->handle)) {
> -                    alsa_logerr(written, "Failed to write %zu frames\n",
> -                                len_frames);
> +                    alsa_logerr(written, "Failed to write %zu frames", len_frames);
>                       return pos;
>                   }
>                   trace_alsa_xrun_out();
> @@ -656,8 +624,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
>                    * recovery
>                    */
>                   if (alsa_resume(alsa->handle)) {
> -                    alsa_logerr(written, "Failed to write %zu frames\n",
> -                                len_frames);
> +                    alsa_logerr(written, "Failed to write %zu frames", len_frames);
>                       return pos;
>                   }
>                   trace_alsa_resume_out();
> @@ -667,8 +634,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
>                   return pos;
>   
>               default:
> -                alsa_logerr(written, "Failed to write %zu frames from %p\n",
> -                            len, src);
> +                alsa_logerr(written, "Failed to write %zu frames from %p", len_frames, src);
>                   return pos;
>               }
>           }
> @@ -687,7 +653,7 @@ static void alsa_fini_out (HWVoiceOut *hw)
>   {
>       ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
>   
> -    ldebug ("alsa_fini\n");
> +    trace_alsa_fini_out();
>       alsa_anal_close (&alsa->handle, &alsa->pollhlp);
>   }
>   
> @@ -732,19 +698,19 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
>       if (ctl == VOICE_CTL_PAUSE) {
>           err = snd_pcm_drop (handle);
>           if (err < 0) {
> -            alsa_logerr (err, "Could not stop %s\n", typ);
> +            alsa_logerr(err, "Could not stop %s", typ);
>               return -1;
>           }
>       } else {
>           err = snd_pcm_prepare (handle);
>           if (err < 0) {
> -            alsa_logerr (err, "Could not prepare handle for %s\n", typ);
> +            alsa_logerr(err, "Could not prepare handle for %s", typ);
>               return -1;
>           }
>           if (ctl == VOICE_CTL_START) {
>               err = snd_pcm_start(handle);
>               if (err < 0) {
> -                alsa_logerr (err, "Could not start handle for %s\n", typ);
> +                alsa_logerr(err, "Could not start handle for %s", typ);
>                   return -1;
>               }
>           }
> @@ -758,17 +724,17 @@ static void alsa_enable_out(HWVoiceOut *hw, bool enable)
>       ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
>       AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.out;
>   
> +    trace_alsa_enable_out(enable);
> +
>       if (enable) {
>           bool poll_mode = apdo->try_poll;
>   
> -        ldebug("enabling voice\n");
>           if (poll_mode && alsa_poll_out(hw)) {
>               poll_mode = 0;
>           }
>           hw->poll_mode = poll_mode;
>           alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PREPARE);
>       } else {
> -        ldebug("disabling voice\n");
>           if (hw->poll_mode) {
>               hw->poll_mode = 0;
>               alsa_fini_poll(&alsa->pollhlp);
> @@ -834,7 +800,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
>   
>               case -EPIPE:
>                   if (alsa_recover(alsa->handle)) {
> -                    alsa_logerr(nread, "Failed to read %zu frames\n", len);
> +                    alsa_logerr(nread, "Failed to read %zu frames", len);
>                       return pos;
>                   }
>                   trace_alsa_xrun_in();
> @@ -844,8 +810,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
>                   return pos;
>   
>               default:
> -                alsa_logerr(nread, "Failed to read %zu frames to %p\n",
> -                            len, dst);
> +                alsa_logerr(nread, "Failed to read %zu frames to %p", len, dst);
>                   return pos;
>               }
>           }
> @@ -862,10 +827,11 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
>       ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
>       AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.in;
>   
> +    trace_alsa_enable_in(enable);
> +
>       if (enable) {
>           bool poll_mode = apdo->try_poll;
>   
> -        ldebug("enabling voice\n");
>           if (poll_mode && alsa_poll_in(hw)) {
>               poll_mode = 0;
>           }
> @@ -873,7 +839,6 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
>   
>           alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_START);
>       } else {
> -        ldebug ("disabling voice\n");
>           if (hw->poll_mode) {
>               hw->poll_mode = 0;
>               alsa_fini_poll(&alsa->pollhlp);
> diff --git a/audio/trace-events b/audio/trace-events
> index f7f639d9605..737e3e60694 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -9,6 +9,11 @@ alsa_read_zero(long len) "Failed to read %ld frames (read zero)"
>   alsa_xrun_out(void) "Recovering from playback xrun"
>   alsa_xrun_in(void) "Recovering from capture xrun"
>   alsa_resume_out(void) "Resuming suspended output stream"
> +alsa_info_params(int req_fmt, int obt_fmt, int req_channels, int obt_channels, int req_freq, int obt_freq) "format %d->%d, channels %d->%d, frequency %d->%d"
> +alsa_info_samples(int buffer_length, int period_length, long samples) "requested: buffer len %d, period len %d; obtained: %ld samples"
> +alsa_fini_out(void) ""
> +alsa_enable_out(bool enable) "enable=%d"
> +alsa_enable_in(bool enable) "enable=%d"
>   
>   # ossaudio.c
>   oss_version(int version) "OSS version = 0x%x"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


