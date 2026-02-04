Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFD7E9537B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbMY-0003An-8k; Wed, 04 Feb 2026 06:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbMW-0003AW-Uk
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:48:01 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbMU-0004Gz-Up
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:48:00 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145fOIu3066643; Wed, 4 Feb 2026 03:47:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ebYPEqYLB5xKBnd2KHRV1ieMuff8ulc770mqdFgcx
 ws=; b=yPHp/QGMHXWuU5x/ss1FIbxoIYP3j0kntWOC0brbZ1MHVYYoHX3dwsDM6
 CMgckwcmr1dUBtu4YH3cE1lWsBWzD6hsgtSkCRw2pllpmj0sharKezhec7TQlL1W
 v2drd+pwU+PGE99yj2Ulor33ai/W8iRpJCcb1/tsI/RUFE+8431dqlqGA8esCTuA
 0QpIi2buhZ2QeLnOaFdyYc96itB9+FIL1AvqNTWYkoCApEm50HBeeRXy1Xxc+DF7
 bwxiWX0bsvF0Et+KXNILEQoUICC1ACyxsMtCk7SYJKbfKwZ9LPg5JFOrLEvGe37B
 3hHMzUXTOKR7s1SduSHdCnf+I14UA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021141.outbound.protection.outlook.com
 [40.93.194.141])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3aydkwsd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS4hlGO/9MSvGT7fyFGdWizl5qUxKV8RyuXDbdcOZiGwgIlDleBGug/7bygAagsxc5CmYPaYMRbSo/z4OAyc/lkCMJDhOXehZK+Apgob7CD7exbot0nWXpmHQRSJzZSeZ1ha9b9FaQRKyrwVSt+2rihDyeIpDqHtAu6OtTu3T+Hz+Z+nTX71jttr+KbP/KRcnZszdjb/RuvVnkPnKr+Dw4u2HY0bURRWMJUFwi4ZKu2sP7MWgILUOHlZQfVFPDqUtEyIKr8pw3cPc2niZiof5INEK7pkgd2OUl0lOYiuTB3HbV0up9OYNrIs47O0jECKQjaJQ3sd90ooxdPPvjylkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebYPEqYLB5xKBnd2KHRV1ieMuff8ulc770mqdFgcxws=;
 b=FYSvSVOLlDHL4LGyO5ylgBODHpK8qyeNw0WASr5zVnGjB6p+oqfbXZe6STFIc2cRSn58KURMCTbT5yUYkE4jF+QK7Mb3f/onJyIh7j64KqV7wcppGIf5lLz4FGDaW5NaRFmI5dEupw8APAoIl7zQ8+jw14yX6xYKFa9ydTN/Cw277VsVsNUT+aCkZRN6H4dL/zgbapa9WMdMwm3Ncow4hp4hKQMP/FwHAU039VjJNyasgRDgn10oErCZCkab2ZVn2kuntkSSxExx5ePaGcxQ14tdfzKsIzyK6esAviFBL8YRRPI5D4wkkVcp9McqOE2i+iz/jNC/t9V9M2420hVASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebYPEqYLB5xKBnd2KHRV1ieMuff8ulc770mqdFgcxws=;
 b=guzWX+mxTRfOJkp1wC4cXj2MHYGgDaCOIn0y+Tk7SCBfqsSGIamdx1GbAdg0kf6B4TYMiDILxxj/duXQ+LrnOI/NZZFjFGsODqCbYhnBC+K7kzZMRpgPOYTeLaokJy2R9OMqDZy5nS0hf5IEh2RZp2vHVyc4uogxc3Ej31FjUiIUbyk9I/yijFEo3tl9X2SfTusKR8uHRvhxSNxLCLcvycgH8Zo7kSGbS2Ot0R3d6JprbxuEoz4taDGB771DMCVVeESMiSrgOcB+JW3M60vsJ1MgLyDBTMr3QsoRHm3SOPk2JaPyEw30fqkzKwn9Dc2Bd/tMkAIIy+H7Fns4x08vjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8096.namprd02.prod.outlook.com (2603:10b6:408:167::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:47:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:47:53 +0000
Message-ID: <81e8d4f8-ac04-4365-b6fa-375d73fef982@nutanix.com>
Date: Wed, 4 Feb 2026 11:47:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/37] audio-be: add common pre-conditions
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-35-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-35-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0109.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 520928d1-dfee-40d1-a1d3-08de63e33afa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW9jdmV1NloxSy92WThsVHF4NW9ONXF0QnE3WWxGQ1JQSkE3eTRRZ0J5NzJa?=
 =?utf-8?B?ZDVBaEROUTZFL1N1ejdTeHdHS0FpdWZBc1JEaldNcnVwd3IvK2U0eTlRVEQx?=
 =?utf-8?B?ZkpSejBzUUgxbmEvMWVscnNma21JMkpEREpSSU9BSDIrSGpMRHJhSkcveHFB?=
 =?utf-8?B?ZU1Gbm9TRmpkZmJteVQ4bC8xOHluUnlLVnpiN0U3d1NXQkkvaGFtQjFFcWtw?=
 =?utf-8?B?WHlhK3RMUW5iSjVZdHBoaExwOHVTSWFzemtmZzlhdG1jQXVEc0tFbXp3bWVL?=
 =?utf-8?B?YVVXYk1qOVdMeDd4S0RKdWttamNEbE81djJBZWZQZHJna2FWaG1kUEk0bUpz?=
 =?utf-8?B?UlhVenBZOWg3dXd0T2xtOE9CdWk4T0ViaWpEMnorTDZuYU1EcFBPdnR4bGFh?=
 =?utf-8?B?MnB3S29Hb2lwQ1NDQi9HRzBJUG9VUXc0S3FYcWhFNDBsd2plYmpIak9hb01j?=
 =?utf-8?B?bEFaejlHRWQ4c2ZOY3Bpcjh1SEEzQVEzVTdyR05zZnk0SUwrNTFORzlHR0pE?=
 =?utf-8?B?em9jNlowdDlORTNFVDZwd1ROYzJNWm1NOGlxVXpJN1JxUGZkYUJWRnoyUHZo?=
 =?utf-8?B?M1U0dVhCZXJzZEdidzZ5dDNQamxXVTBiaUZZcndVQzRZK3QwYWFzc0F4SDZu?=
 =?utf-8?B?elhsOVl3MTB0UlpLanY1Z1g1YmFEc0t4b203aEcwUStOTlA3MHdxelh3Rkk0?=
 =?utf-8?B?UnhrS1pBTHlEWU96c1dwSWpwSlFMRnljM2R4ZDkwNzFnY1lOWjNwcHJlb1Bm?=
 =?utf-8?B?TTdVNkNiZlBPMmVuY3dnc1d3bU4vS0lNWmVJbjl5SjFsN2RLbC9IeVF3K2lD?=
 =?utf-8?B?UEs1SkVoU2M3RUxEb3REN1l6dlJvcSttN1FyVEwwQTlWajBwN2xOYjdHenBN?=
 =?utf-8?B?N01GajkzVFpiR1VxMmtCeTUzYlJZRDlHSVUwQ3ZDeUREZTNqM25ldWRHMGk1?=
 =?utf-8?B?QnROb0JYVGJyV0J0REZKMDVTUExQY2h1MGlQbGd6ZUlNY0NTTkMvb0xhMU9D?=
 =?utf-8?B?MW9MekUwTlE1WndxSHQ2SytRVTNyOFRSditsSHR4eHdsWHdjR01DUzYxczgy?=
 =?utf-8?B?Y2d2a2VFN0hreWc0ekFsdnpaVGNya09TTWVnM3JWbGZxdGxmTFRFbFEwUEZF?=
 =?utf-8?B?aHZCTzZhWWJ0NzIySHNjak1iYkFmWWdYK1lTLy9pWGE0bE9jbHdsb2JQM1Vx?=
 =?utf-8?B?aHNCdXdhUDhUWDZjTUUvS2Q4ai9Ea3JrbDdIb2kwSm9yeUFSWEl6b0R2bklP?=
 =?utf-8?B?VUJyTlZVN3V5Q0NSQUU0ZFBpQ0J4elE5QVFnY1BpTkJUT2N2RlRTRXNRQ0N2?=
 =?utf-8?B?aE9kMjFkNkI3ZXE4L3ZnTGFTY21aSUtNYmtjenIyWExVVTFXclZxOVE2Tm92?=
 =?utf-8?B?WHZrSG5jU2NNRDhDdzZFTXJFTEtBMnQxRFZvSTRNSEZiRm5GK0tmd3Z0V2VH?=
 =?utf-8?B?V1loM3VSYWxKQnMxY3R1M2FwY0dyTWRoeUxCNXprS0duS2ladWdVSUxKT2R3?=
 =?utf-8?B?QzNxekdYU1BzS1NIbGtaL0NURWZuMnVmUGY5VDJZV3V3SzB5N3ZHNG5jMlFQ?=
 =?utf-8?B?V2YvUDdPa0NkNWdzSUtobE1RdDJsK3kvZG5hRW5nVFVKMlRNeUc0UEwvWFJq?=
 =?utf-8?B?OUJndmdPSUZBZk0zNlAyNSsrVC85UWptaVl4RTdpb2tRNGRHWk9TbFI2R3Fz?=
 =?utf-8?B?b3pMVzIxMWc2YUs4cHZjZ2FhdzU0eUJYckYzSHdycG03aWJDak9tYlh2ZjE4?=
 =?utf-8?B?VzJFWlBYZEU1WURKN2JBTW9GUkZTSXZMNlEvMkNMbHp1TVUxQ0RIMFlHMmJE?=
 =?utf-8?B?MHZ6bjJJN05PWGFCMFhQUlg0akpMSzhOc0JvaVJ6dWNSMUx0VG5ONXZPeXBz?=
 =?utf-8?B?UG9LVWMwd2ZkRzJBM3d4V25MUFdibHJEK2U1bXJ0U0pXSzZGQ0xtWVgyTkNZ?=
 =?utf-8?B?WkdUbElIRWFldmc5OFBOTjBYc1IyM0F4TWlNT1VYRHRiZU5oU3lKUER4N3Fn?=
 =?utf-8?B?M1MzNkJSZ1QvdWo3N21uM21TdGlmL0Yvek5hMWNRRFNJdVFXalVnRU82RVdy?=
 =?utf-8?B?R0hObmU5dTc2U1lBeWxqNXhodk9MMXJva083SndRb05SbFEveXM2Y1NUek1i?=
 =?utf-8?Q?vDx4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDV0TUZqajZmYWVBWFpkK0NmOFhrK2sxWUhJbVR2NCs3SFhGRDQ1TUZDQ3E3?=
 =?utf-8?B?c2dmbWtYSE1DOFdkelNVVlcvd2tRcnp4eGZ4NHQrck9saE05QUZGdDNZZTY3?=
 =?utf-8?B?cGNPSGFSQ2xVc1FsRDg0akZxY0tSaVRCc2s5bzlFRExPRHk5b1c2MUpTS1lP?=
 =?utf-8?B?NzNKQVViK2VRakRseWEzd0pZYllCUHpBQ2R4WkN5UzBQbmZCUkJzV2tRcnNn?=
 =?utf-8?B?Ly90VHJrSE1GbGdZV0I4UlJweXllZER6TjJtNGRUSHYvUGNRaGVYQ0VJNE9w?=
 =?utf-8?B?UUhlZXppeWxtVjhVbnN1S09PQTEyeUxvcytucWNXdjYzVEoveThHekg2MFBz?=
 =?utf-8?B?UlJPbWF1eXd0V281VFlaT2RpYlJPRjg3ZENwM3VyZ3lrMVR6RWRybXpEbXRT?=
 =?utf-8?B?VFRneFR3M2IwTE1OOWxtNVgxcXczWDRjRFlITzB6YkhZQW9lMGFpRjhpcDkz?=
 =?utf-8?B?L0xJQjg3LzQzb3MyNlRqWXllOTF4Zkp3d3ZDWGJqa2syRWdhZWpNMVU1REdH?=
 =?utf-8?B?MjVOeXkzbDd2MTVxeld5S0ltSnRTc2p6bnRRcW9tS0hkMzNsWE1XUWc4Q1l2?=
 =?utf-8?B?aW4zanp0Q1hRd2dsOENlME5ETUV1ZUZWdEZxUTloYnRJNjZoZmY3R2Q5ME1l?=
 =?utf-8?B?RzlqTW44MjhxdVlmU0NuVnBlN1RXWkwvUUxqVjRDVTZvYXptRHI3djFYNmhp?=
 =?utf-8?B?Y0RZZVhESjJpS2FqandtZVJLY2hkZUVtVVpzR2JtajZ4TWhSUStaeU9zbVVF?=
 =?utf-8?B?cE9ubm5EYTlZcjlYS1JTTjJkZ095b0R0L0FsdmpxY2NxYjBkbnlrMVg1UUow?=
 =?utf-8?B?cUNMWGMza2tid0N6cFo5bHpqL285SXVCMDN3dnovSDRId0VSYkRDTU14SkZ4?=
 =?utf-8?B?Vkt0SmVFRXg0UTk2RVR6VWdUb2JsZnF2bk9yWHZnejBuY2NPQlVkRlNaait4?=
 =?utf-8?B?dDE0RjZONXIyNDhoVThDQWIwRzZkWklxQWpjRnZmMnJWNWFwRzJTQnNDNHB0?=
 =?utf-8?B?N2kvWEd3QU5lNEQ4UHl4OG5oRGFxNjJlY3YxSTZFUUJ5ZVpDN0IzT2tpWm9l?=
 =?utf-8?B?d0hPN0VkZ1phRWFkY21rMVpabnFHZnllZW9kNVlnMlArTVRINDV1U2pVbE80?=
 =?utf-8?B?UElpZG9QUjEySFA1U3U2eHVYMk90NlRTZnlsTGNBeGFVUlkzdFNqeTVIa0Jv?=
 =?utf-8?B?aytiR3diQVdqaUU5aTNTV0lOb1BFOGhLa3d0aWFuUGc3ZnFlbFUyYm9HVTF2?=
 =?utf-8?B?OWlBeXExSzVCTFV4UXg0QkF6dkxkZUhZbkx5bHpqeXpPaXZESnQ1OHdVajI4?=
 =?utf-8?B?UHBUS0hHcmpwV0Rpc0N5RHNBOHAwUnEvTnlQSEQ4U09OS0o3Z0lEcXFyTzV2?=
 =?utf-8?B?THNNT1VVV0VmYnZ3MzlpemZVV1RiaERBTHpQN0xMMy9ONVgrZ3BUMTNZbUZ4?=
 =?utf-8?B?YU02RmdLYnQ1bWpwRTIrVGNGSG5qdkRDb3FlSk1SL0cwNmYxVitoK1l1bWxJ?=
 =?utf-8?B?ZldxdVZMQXMyVXdtZ3BkUDlJdU1ONXE4eWM5aUdvYm9XSTMxMEY1eTNycGFQ?=
 =?utf-8?B?ZU5PUFI4K1RVaDNXUVY3MFltWVRkcTNtVTVxcXcxNUFESlZwc05IMVBsNnll?=
 =?utf-8?B?d2NuazF2bWc2R2pqOWhYMDgwVTJ1N2JRdVh3SUo0YTdIeEVMa2ZjemxGTmJ4?=
 =?utf-8?B?RG1FeFQ4WGVpUFFKZ3ZDQ3oxOW0rWWFzbnpJK1J6eERkU3NNVnJFMTRtRFdt?=
 =?utf-8?B?cjhGeml3bmprYXBBbjdaMlZzRndoZTRPSjU2c1NTa3pmT2dQOVJxWGUzLy8v?=
 =?utf-8?B?SlZSM3BDRjd0QXFudmd2TW1FbWRZUlZIK1JoaU4rSHo3NzVLU1pLdnNFVXJ2?=
 =?utf-8?B?WDJKVXJ0by9YRFJGZTFlZ29BY1BYcEhVbWY4Wmw5QWU2dFFmY0ljcyt3bHNj?=
 =?utf-8?B?QXg2Y2haUWViTWV0KzBYZWhqTkhBUGNMZXlQWDJHS2l2SnVaSGZ0ZkxSa05Z?=
 =?utf-8?B?NU5Wbk5iSGdFeWo5bys5WHZ1MDFwZlMveW5IMUMvODNBREtzZWxFSUxHV2dL?=
 =?utf-8?B?UkRjSmpLdjZJdkhZWlVLdlpvZjVEYkNXV1RJQ1U0WHBybjB4aFNKWDJIdEdt?=
 =?utf-8?B?Vk9wODNyLzBaaDBmSEhDbUsvdC9zYy9pZmMvYWhTVUp1MzJidnlsRGoyNnpP?=
 =?utf-8?B?Z3VXV0YxeFJZNlZaczAvRHV5dlJlcUJKMkNsMEF0cHo5RGdRb0ROeEVRVGhT?=
 =?utf-8?B?VTl4emlWWVlncldQNVhRejc2MnBPWEZzZi9CKzRwNmw2NlBSRFdXczRxb1Bt?=
 =?utf-8?B?SVR1WjZzbTlQak0zK2tGdVZJYU5FM0ZvSkJRLzdEVm9GbnFpM214RHdOM0tj?=
 =?utf-8?Q?kYTfxEpqM9agK/Oc=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520928d1-dfee-40d1-a1d3-08de63e33afa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:47:53.2195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZOOprjzDztWj+5Q27sEGHC9aynrIuFjasCyJdA9v3eW4mlUlemiX7SOEolONIxJj+avSC+RAQWW3qreARiZdAO82pP6UwDNAOsLbwP0oAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OSBTYWx0ZWRfXxN5QZwhlwOIH
 hn45ItL3FPEqfychrd3PBGAPpSUDa7h5QYytptcgX08pws623psoSAKNesr9ZCbLhe2ZdJ3rTjC
 LwwwqSnBf8H3P5B8QX3SwziyA1ujq6s2+R9L1sTWJEE6irLJDMHjGsQXqQtR9Ze+2Bx71UiPHE8
 gedmvVNt74IfM1R6i8k/JiHXVx2jD/R1tTbljVaEJKah4HWgVzzYFp2I8gwQb+CHeQVCZpzZFeG
 xNUSGC4m4fv6ieWWIzJIrlC0rtBV+OzNflw5uzC2eXqqn6WJi69oi2RtC9iiV0y/XQIUdxvG8Ik
 Tyj19Ynx2SBdnGwttjNTYVf6oSgNOa7dYxbE4N8z8BwjOIjYBJubpjbnC+vwJzlqtCM48rK85DN
 P3T4sjxCpJlNf/GP1WxB/qwF9VUA4oOvf/i9Vhqz7266RAy2G0U7ALIFezv/t9iWMXUj1dzH7go
 0xOm3PgIe3Gqh7mZctg==
X-Proofpoint-GUID: yC7bkPct3nr5uol0IKAnu0HMfiw_GM7K
X-Proofpoint-ORIG-GUID: yC7bkPct3nr5uol0IKAnu0HMfiw_GM7K
X-Authority-Analysis: v=2.4 cv=AeC83nXG c=1 sm=1 tr=0 ts=698331ed cx=c_pps
 a=OpSXQbuC3dJaDDyxjzMkQg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=rx8nAtwFGiLeKI6EF8UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> assert() on valid values, and handle acceptable NULL arguments
> gracefully.
> 
> Note audio_driver_write() and audio_driver_read() used to return
> size (with a "XXX: Consider options") when sw was NULL. Imho, it is more
> correct to not pretend to have read/written anything by default in the
> AudioBackend base abstract class.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio-be.c         | 61 ++++++++++++++++++++++++++++++++++++++++
>   tests/audio/test-audio.c |  8 ++----
>   2 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/audio/audio-be.c b/audio/audio-be.c
> index 37e3eb0909d..b3fa8d9c549 100644
> --- a/audio/audio-be.c
> +++ b/audio/audio-be.c
> @@ -29,6 +29,10 @@ SWVoiceIn *audio_be_open_in(
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    assert(name != NULL);
> +    assert(callback_fn != NULL);
> +    assert(as != NULL);
> +
>       return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
>   }
>   
> @@ -42,6 +46,10 @@ SWVoiceOut *audio_be_open_out(
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    assert(name != NULL);
> +    assert(callback_fn != NULL);
> +    assert(as != NULL);
> +
>       return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
>   }
>   
> @@ -49,6 +57,10 @@ void audio_be_close_out(AudioBackend *be, SWVoiceOut *sw)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return;
> +    }
> +
>       return klass->close_out(be, sw);
>   }
>   
> @@ -56,6 +68,10 @@ void audio_be_close_in(AudioBackend *be, SWVoiceIn *sw)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return;
> +    }
> +
>       return klass->close_in(be, sw);
>   }
>   
> @@ -63,6 +79,10 @@ bool audio_be_is_active_out(AudioBackend *be, SWVoiceOut *sw)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return false;
> +    }
> +
>       return klass->is_active_out(be, sw);
>   }
>   
> @@ -70,6 +90,10 @@ bool audio_be_is_active_in(AudioBackend *be, SWVoiceIn *sw)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return false;
> +    }
> +
>       return klass->is_active_in(be, sw);
>   }
>   
> @@ -77,6 +101,10 @@ size_t audio_be_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return 0;
> +    }
> +
>       return klass->write(be, sw, buf, size);
>   }
>   
> @@ -84,6 +112,10 @@ size_t audio_be_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return 0;
> +    }
> +
>       return klass->read(be, sw, buf, size);
>   }
>   
> @@ -91,6 +123,10 @@ int audio_be_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return 0;
> +    }
> +
>       return klass->get_buffer_size_out(be, sw);
>   }
>   
> @@ -98,6 +134,10 @@ void audio_be_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return;
> +    }
> +
>       return klass->set_active_out(be, sw, on);
>   }
>   
> @@ -105,6 +145,10 @@ void audio_be_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return;
> +    }
> +
>       return klass->set_active_in(be, sw, on);
>   }
>   
> @@ -112,6 +156,10 @@ void audio_be_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return;
> +    }
> +
>       klass->set_volume_out(be, sw, vol);
>   }
>   
> @@ -119,6 +167,10 @@ void audio_be_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!sw) {
> +        return;
> +    }
> +
>       klass->set_volume_in(be, sw, vol);
>   }
>   
> @@ -130,6 +182,9 @@ CaptureVoiceOut *audio_be_add_capture(
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    assert(as != NULL);
> +    assert(ops != NULL);
> +
>       return klass->add_capture(be, as, ops, cb_opaque);
>   }
>   
> @@ -137,6 +192,10 @@ void audio_be_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaqu
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    if (!cap) {
> +        return;
> +    }
> +
>       klass->del_capture(be, cap, cb_opaque);
>   }
>   
> @@ -155,6 +214,8 @@ bool audio_be_set_dbus_server(AudioBackend *be,
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
>   
> +    assert(server != NULL);
> +
>       if (!audio_be_can_set_dbus_server(be)) {
>           error_setg(errp, "Audiodev '%s' is not compatible with DBus",
>                      audio_be_get_id(be));
> diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> index 812ee187e8f..e403f11f093 100644
> --- a/tests/audio/test-audio.c
> +++ b/tests/audio/test-audio.c
> @@ -480,11 +480,9 @@ static void test_audio_null_handling(void)
>       /* audio_be_get_buffer_size_out(NULL) should return 0 */
>       g_assert_cmpint(audio_be_get_buffer_size_out(be, NULL), ==, 0);
>   
> -    /* audio_be_write/read(NULL, ...) should return size (no-op) */
> -    g_assert_cmpuint(audio_be_write(be, NULL, buffer, sizeof(buffer)), ==,
> -                     sizeof(buffer));
> -    g_assert_cmpuint(audio_be_read(be, NULL, buffer, sizeof(buffer)), ==,
> -                     sizeof(buffer));
> +    /* audio_be_write/read(NULL, ...) should return 0 */
> +    g_assert_cmpuint(audio_be_write(be, NULL, buffer, sizeof(buffer)), ==, 0);
> +    g_assert_cmpuint(audio_be_read(be, NULL, buffer, sizeof(buffer)), ==, 0);
>   
>       /* These should not crash */
>       audio_be_set_active_out(be, NULL, true);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


