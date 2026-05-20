Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE88CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 09:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPcoa-0002cy-1x; Wed, 20 May 2026 05:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wPcoX-0002cF-1U
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:02:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wPcoT-0002UY-VX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:02:04 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K3udgQ329037; Wed, 20 May 2026 02:01:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Zc8IAp84+AeJpTTbGZEAhU5zZB6aaUPQOz9beXjqj
 /E=; b=j+6bUie0KqdQdntRCdJW2fJMd1siR0S1sy0h6X+DjDgDXu8p0x4g0+Z8F
 srVWDgOGNc0NGpj6XSo46LA0Qx7ONyNPxbxgup17VUIZt0pr0JuIe7w3e6G6n1Yd
 LYk8TBFfsnf1a7oioYHasaTQrvlnXzuk3t4eO+/z2L/pvwlA0tm6uXihiHE3D0MC
 Vx6JotSNkmkY4GowAppOIkgKaqzAI269FP3mdU43nK52IVMW42KkrUegPpX47o1m
 YSLw1CiBEriWJSsnbqO+QQlCjxyDJ4f4DujJnOfiZ7uRYXLN1/Itj1wb/Ahjgq+P
 Bj6T9q7b9eELks26fVZsbEd80Z6BA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022092.outbound.protection.outlook.com [52.101.53.92])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e93k4gvd8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 02:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY168IkcoIDp/kY4KZNy8VTFfdbEk0gUfolXAWvNxW5Z7jT1WadvpyUNU9M5Ykw5zT4KnP1F2mOLMBvoVY/Y55uaBQ6UObKOcDfCwz1etsK3ZtN8ozUzAm2Hf81Qr1HkuzvimVe3/SgKqQL9AfpEv0oF08R/ZyQ/psLyHTxPcpmeay0kXl+ZG/7Eupqgpk2jUZR1NTjqZP0M7TtuEuiUJR0FOTTUQrQTTQzn/dx47QNUeKEKTKLibgmK+PPQUiucZ8jNbTHSY+oKa+epkfTCDNTLfZTSFhzvNL54XAVgfw/i5XH9W73YDkwd14MrZhMVZ+I6L8TucydINSUv5DXNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc8IAp84+AeJpTTbGZEAhU5zZB6aaUPQOz9beXjqj/E=;
 b=NAzFiXYyC33A+1LNNt4THTt0Q0a0XP+DKK2wTb1UP60N3+0pbONe/QDlrr/a4llobIdclhOsvK+q1OdcEYbhcvMqdifRvXbvmO8YpYPIMreIseoWgNrI351irTfxdbC/RnW9fkO03Ueal30Nidkp0mBu1iICBzWUVjw6IDBZSiU7ej+E0Xs17S2FUdbt3ZMjsMqJBfBwODPrwpar8MKyKCvRU0STaW3xuPLtmqkFi9h2+ra0ymvKzhuDVs0eCgAJnh2I2VHhD+Xu91LxAzxOzC4e0UM3q3d+G8lY0K5CaCNDpfZskVAIWmIx87qiDf2MgU0aal8E7NXeL+W3HVrw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc8IAp84+AeJpTTbGZEAhU5zZB6aaUPQOz9beXjqj/E=;
 b=VBIUXUSKjP7OhQaRay01VQHDTzwrW0GI+fNO4x/fbTTOqZLbRICXt4rbuBKf+UJnmNDihwm1ykPLUE4u8aZCXHv6ZBB91atNUnENE3uof0np1k3jkzoCB452v2ePxLozx13ImGEl/Xz0RoGvpowjnHYuNIC8rBvN/w10E4JdUSDeipXWocQe76mNojGavEo+XNw+vC9gL9XTnm+WUliRIGHPdTFYF9Kl26h9d7eigU/k6zIyht90oUHVPW9i9FazwvQ7X7LbV6fM+5a1yZ4OARCI9JvpKZLSiMTPa/F5XuBOwlyWLTOfDwnwu5RRorcv+CXSfbUBF6ai23gpGszAhg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9920.namprd02.prod.outlook.com (2603:10b6:208:48d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Wed, 20 May
 2026 09:01:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 09:01:52 +0000
Message-ID: <cb5c1cbc-e3db-438f-9854-3853ef946b1e@nutanix.com>
Date: Wed, 20 May 2026 10:01:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: use a valid object ID for iothread
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260520082459.1132051-2-berrange@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260520082459.1132051-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9920:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f168e18-417a-452c-799e-08deb64e6f14
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: FUzsKiU3SmSI51UyrsdFFXJUaMyfWGerZwxp/lMtCp9VlddUQwx9zoW6jo9G8lnZyqU77fH2j2wSnjSq7jTtzhJxTYLOTnlUY6VVMptsKmsHi28bnCSPAcn8DKIILC9q89IhFXSoXW11P0h/Lzr/GOPKgJOmGM4BpabqBJ5c9X0XKtwfADjJUgofJb9Q9R+oMkStCE2M47RRxa5vVBbuf9xFtrQ/1WMOcKly/Rq7vRwF8k7Mz99L62dCI2uLRaAXSmw5sZRAxAaZyNmEEtPThOfV3I/gsc/5O8MHW3bIRIoUbISiBYTqMUcpPh2XYpK3+8YgrBsclvftMl//STtM5fAxnoetE89R2hzOj0PO7xS0rCUZeOgyRzxbv5Q5+wjHmAmcJU9QJI44mo1Z0eYIMckZQpZqIBcEgbDGEasRFQCd5psy5etT8Y4tfjcZnMjFH0dZAUFSqtVesMkA1rWdET0SCTBmYC2w3zHIyZmdeWXoS/KF/G08YGg6R/Eqfjk4PJ0DVKPgA3zZRYfLkJVzKkjDzGBii31Z4By/xWfIX3mxBgV5GBQFezzJ5gnsqEezaGSXmlEEYVeTR8hrf3tHcd6dEYOPxw8Vdqmy4ftl+qQkt3sgPoXRhBj5Q6N2yDhRBVpgu/Bq1Pvv6c0QDScNYnJ4cm9EQ+BbkuLR5E6KLBqGF/opqTfxao4G6reCI4eP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhpTzV6UmJFaEtldlg1aDIrTG95MW1nZksvUm5Tbm05dkJlNWRnTkZZaWZu?=
 =?utf-8?B?YnZnRlRVemhkUC9FRlB3dWwrNG1HL2ZJYit0Qk51ekVzRjczMGx3M2pGNC83?=
 =?utf-8?B?aElMZFptNVRTL3hsMmZiVWJKLzZhTmQwTUhyWEIza0k5b1ZObnNpTitKdTRO?=
 =?utf-8?B?dXJPMXUyTzJnWlNiOElrcXVTQ2tqVHlYa3NnQyszOE1lcEQ2WUkyRndvTzBs?=
 =?utf-8?B?YzRBVVNrc3VRVlVpS2J3anFiWWlJcjRBQWtpM0Q2a1VJVTdhYVJoS0Y3UCtB?=
 =?utf-8?B?dUFtRUZSM3V3QjVLUjFNV3dzbzIvRkhUalFsNVlieEh3d2pleUZxMFRUbDd0?=
 =?utf-8?B?eFplV1pGbC8rcXFyTlNUWVRMUmhYY09hVGM0eXpDL0w4NGtIRk1GNFpRWmdv?=
 =?utf-8?B?V20yNHBpRVgzd0xlNnkxQUdVYTBPay9hSXVoY0E4dXY2YUVwUGRESEFuMVQr?=
 =?utf-8?B?RldzdUhrU0FHNG5qS3pmNE04eWtjQjBtN3V1dms0TVhjRVZZcWEveWxOZlJU?=
 =?utf-8?B?R1RyMTRHRU02Rk1PMWVEeVl4TzBJVHBaOVpZdkpKVXdtR2s3VHVLcERkZ3RO?=
 =?utf-8?B?OHJIMUhNQTkvTXErQkw0ai9ib0huVFAwTFhKa0RXVnZjRFBIdTg4akxXSnZR?=
 =?utf-8?B?WjV1c1BZMWNTL21SQnpBK0NDYTUzWmVZbFl1SnZucHJTa3hPdWM1SVZnazdY?=
 =?utf-8?B?cCtSeW1xdXQrSDZLNE1MbEJUd1JsNVJDU3lTRzFGWFVMazhJOHlsZUJseXlr?=
 =?utf-8?B?OHBMRFIzb2VocWo0T1F4NnVLL0dZWnFLUi9TMVE0MEtUNkxqYzg3ZllwK0Jr?=
 =?utf-8?B?WnkxRVZyN21LWm9WbTdWdThVUlRWWFlmYStRVnZQV3Qwemw1VkE3U2hyK0tG?=
 =?utf-8?B?Qnd6eWtDRmZFa0F4b2xwYXdXK0xla2txZzhoaW9CNjR4UUdkN2JDbHpwWnVy?=
 =?utf-8?B?VWJ1MjIyaGhJYUZ2OUQvQy9XRk9adkxSclhoalRzc1BkZGVuUDdjTkN0d1lZ?=
 =?utf-8?B?WnZJYXBYTmlrNlFJMi95ZU0zMXBsT0laUTZTbDZKVCtJdjNqamNxZmxkWlA5?=
 =?utf-8?B?VGt3VWM4eU5zZGZ4cWFHc1hSWnRoUHlBU3NhNEFMS2FBZE1zbXBzeE9PaHoz?=
 =?utf-8?B?Zm9XRzVQRlVUdzU3dklBdG12cjIxdjVNQzhpMU9uTmhPWkJyTHZqdmdBODk3?=
 =?utf-8?B?cFozZjZnVmp0azU0RldhdzMxeDJ0a3hxZmJoY2E0L3grc21FdWhkVCtHVmhr?=
 =?utf-8?B?ZUdWV0J1THJZQzRnZGw5ZmdYZlpTUi80Z29kOHpYUW1Ubjk0dVNPWExyeHZ5?=
 =?utf-8?B?WG5MSVBnWUx2UnRxeUVEU21MTXl5LzdQYUlDd0N4Q0Flby9xenJTMU1zU054?=
 =?utf-8?B?RUF1eXBnMFdYMXcxRVF3cEZ5emxNWG9sWnp4SGgzdUNDdXZkMTZYNEZ4M0Fq?=
 =?utf-8?B?VlpQUCt4ck8xeEtHM1hFMHZNcjZjNXFqdGpaMEY0TkJ4MWQ3ZXNxL0w4Ymli?=
 =?utf-8?B?RlgvN3BpR2FaTlArWTAvQ3l0ck9Pa3Q0Rzk3aTVDamJ4OWN3V1FKcklpdURJ?=
 =?utf-8?B?a3FzWHBlazR2cTZQK1phY2V1TFF4aDRmZWNvZGhRQjM3VzNidXJpdGI4TmdG?=
 =?utf-8?B?V0pwcWdkeEZubnV4WnJ5aDMyY09jaVQrcXBmM1FVQnhoK2ZBbDExb1Vsak9X?=
 =?utf-8?B?bDZHejdkT240aE56WFJEajZxUHE0WDFrSldIUDhBSzU2bkhsQTcwS3o2b1hz?=
 =?utf-8?B?MytEOEZOKy9VZmRoTFFMa1NNbkhINXdNT2wwVWpQcHNlRW9WNEsrdmU4dlZI?=
 =?utf-8?B?VDFQU1JnRkVOcGcvWkRXdjBmbkVJcG92NHE2bEZIc2pOaFFjelFXQzFwR2E4?=
 =?utf-8?B?YWQvVGFvaERrclJzbXFkVHlDNTRQODJyN1RwNUxhQml5K08yV1cvak8rcU5t?=
 =?utf-8?B?Z0xSYkZCTXhEMnhIT0J2K1luQmdUOWNSby9SQkFZMnZNY1RZanFFelRVN1Nr?=
 =?utf-8?B?ak5GNmMzVjg4eUpGQnp0Q1Vma092VVRRMjUvaW1QTENzcHJUcGVnT1RaUTFH?=
 =?utf-8?B?VVltNlhmb3JlcHhSYml0Zm1UV2ZkcTd5akIwM3RVYjJUTjByUTZrSTR4ZFVh?=
 =?utf-8?B?S3VEaFd3Q2lGRFZ5blZQNHU4eEdUVDJjcmdudHRrU0hadHhwdUZJYjg1SWJD?=
 =?utf-8?B?dGdLa3hBRTFITlZUUVBUTXl5Mnp3Q0t0alRSaTJWNGNKWVZKeVpKc3lld0F0?=
 =?utf-8?B?MXcrK1RBbGExOGhsSWg4WDE5dHF1aGJwb1lqbkVqSitmUUViM1oyUnlHeitT?=
 =?utf-8?B?eWdWdG42elRQZll1b3kzdWxBY0VyeE9qN1hpQTFsY0MvZDRQZDdHK2tlUm9C?=
 =?utf-8?Q?Azt3mXVi0FbdDP6k=3D?=
X-Exchange-RoutingPolicyChecked: Ef/LYOjctUgkJmSHFhy8fY6Ckaoifj8EXM5TwkkSAf4exseNiuoWgpEM6KUBc6dgwVJ0If9dIePeX77mKEHWpNJo1563cJKdJbpzLEygRxa0/rewPgWpYHsXkPrR9Tu4MSeaX7nV8gU9rVBZaBwga4Zup0ZbIc01syzwWt/qiM4jbKWkONq6LPJcTx86Bx4faEe4rIGMiBZaOSnutp/YaCAkY8MGet2aqiSNetcpTKGp5ioxV6qZcBmSUWtJsBuWQBpLc6VsL0YKLeqN9qY4FzEi4XJLBz+wXk6iYJFnQzsdSFsSmWyyiem4BP95mGYO0yYMcddl2LT/MYozbvRi7Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f168e18-417a-452c-799e-08deb64e6f14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:01:52.1517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AaQLbiu9D2MipCDt8RUbU+8OVSBdkgvXsET+4t5FVtlfinShHe2Ww8CD90qnmDHYR78untPDQ+rsgOLXwhJfBOzjCW8lLyVCX8ORlrVM28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9920
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NiBTYWx0ZWRfX2bnluSgiSF7o
 EpF/BibzkiGtp6HpbVZfW2A1f9Aocxq6E5TYU+OpoYunCc5l08WtVrfkf0euxvES9ms/zzeeST8
 rjNBRb3u1+OMDXULTa+/ypkRaAv6UVZdVcm7xCSxj6/PV4zlmLkolYpNevpqdyK40+S4jADFcKN
 XASTbY4Xon4RmqQBbmA3kd0qvRUWfhSKnsKq9xKmO0LUFaioYUYEY/j1yyHPaIbJWEUqO+Pgxg9
 /RVcFReNKBO73qZUghz59u9a8QK/jv0dZ8BjX1wEOhGiV/w9p5oRbHHYDmc7n5d8vRmwacX2wZo
 v8Cw9PSHDsZA4pBsetIKC7pGVzg2VMegkDHbyXI/MrNruiZy3R75BGYGjTtEhV+2IbsXUZA3v5r
 BolOSxuLivZbeWKWTNntFVO3V327DOCZSI0Nk+RQCjj92Y2jWgjrD0ta+qZmC+3LDkmysZedvuq
 v3ubG8H01Qz1V7a1JIw==
X-Proofpoint-GUID: sPFrsroYnO_YxJa1bJ3kkvUedwe6C6gG
X-Proofpoint-ORIG-GUID: sPFrsroYnO_YxJa1bJ3kkvUedwe6C6gG
X-Authority-Analysis: v=2.4 cv=RIuD2Yi+ c=1 sm=1 tr=0 ts=6a0d7883 cx=c_pps
 a=KO6HEfrki8vYvSjcdf85Eg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=X-orvChQzJ0r_1ohBZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 20/05/2026 09:25, Daniel P. Berrangé wrote:

> The objectg_new_with_propv/props methods failed to validate that the
> QOM "id" was well formed. This allowed the vfio-user code to use an
> invalid ID of "VFIO user" (space is not permitted) in its internal
> code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/vfio-user/proxy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 314dfd23d8..3d0d72e8b7 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -933,7 +933,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>       qemu_cond_init(&proxy->close_cv);
>   
>       if (vfio_user_iothread == NULL) {
> -        vfio_user_iothread = iothread_create("VFIO user", errp);
> +        vfio_user_iothread = iothread_create("vfio-user", errp);
>       }
>   
>       proxy->ctx = iothread_get_aio_context(vfio_user_iothread);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


