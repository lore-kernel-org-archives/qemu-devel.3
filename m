Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB675E87842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIXS-0004jL-VY; Tue, 03 Feb 2026 10:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIXR-0004gG-CE
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:42:01 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIXO-0008Fq-G9
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:42:01 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613EOXo51438807; Tue, 3 Feb 2026 07:41:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=S0I44zoXQSuqI8sChMromzLffauE/qOYiTPLHm65F
 eM=; b=dJW7KOJ6kg2Ohznoafm65HyLYSOQTdCuDA2BqX1uzS/nXdGfZlkXdNSHK
 3wPPd0vO8v/zr2tOJyNss0tKFm7Uz06z3WGvAizW6Tlai8siInZS27YRNgXxCl78
 w4glxpwz0XNggt/nHeqbJn4ls0bqiPmHevVSy6TtUallgMcuqdwwgRYa5/+54ffG
 sNHQmCK3Yuqp+3fnMBL+NSQf5N1h9W7ggm2pCvFqywyHw/aexSx0wPCzIcSeuGjm
 QHu6d74QclGFutTa4wIG2Um6i0BdFnF2ygmw5zL+FRqAxjP0T4dORI1dbFhbAwzB
 pdw+bxKgnyZJS63cY8Novi49/F0Gw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021120.outbound.protection.outlook.com [40.107.208.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3aydhcpe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:41:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1mhdL4dIvEH/aFUY6DMs7OyfSKsG/4iV/D48GvyABNBgSmQUJ5Q1laA+lJluArqti0twB7cWQ0WE0zCiMdMf77miHMa6exrIuZsUioXjH/ozooMUI7eHZ10B2mEO7ZJ6SS7Aa5VSOGImdDDfa8J8GBkoTli/Kz1MDtSasiKucaUGDLWxeAULHAzcKnwdAgZAJz/QLaTwo+BOkAck/gmCSc4M/GgOvRARqogFtFLtReVZTD08T/hH2PBpVlqAfF3df6YwaG28J23sTWt5rCAHi+nZm5apORg9BOzIe/v2Ghaaka+v2zWUdDt8zC09lCYSO2b/sjzV30fTCLFmRGHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0I44zoXQSuqI8sChMromzLffauE/qOYiTPLHm65FeM=;
 b=dYfOLaNlzDzpuTQEFjwgaMZ68HSPAI/jHyWG7d3cr4IPDO/xwmo9SOK5C6bywruMfEunGzADDyHjQl0Kqg2Yz+5l+ZDk0CKqWAP/ohmBt7GVLmCmnWLJbnBqKareXoDervIasKhj1+Ky0zGewyOBRizkwGRThL+Rt/KmpZbBsNSc26yAs+0xrtPHlh7Vr+uWi1UcGXjRmGCwC3MJ89JGWDGNaex1t+b3ZeaXSOi8WMCguk3IOC/5fH+iVuebgVA10Brw2IpBm4pJ9RH1jos0HGhpaely6HoaA+KcQFIhR+v2TgrNWmDjB/Fu323e+EqLr8V+fJW2xqPiDUBNERPmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0I44zoXQSuqI8sChMromzLffauE/qOYiTPLHm65FeM=;
 b=uIS99UzNNHBq5N+tiRHlqZgDZzQPgDmaemqDnl4GMjJeJ1G1DWcDO6iApCx+CVaqrCZtQI/AY0KfTbyf4+OSB1OGtLCkLi74hma8uHOSMlnW4bRF+BHpARKaKH5bFNovA12515an3iBSAWyWKohNExCn8Qy+AEFjaiIg7ihn1iB0W01RQMMWco84d/hpnln2TTH7FuBxYZxXuJSDl6sCyd4WKQX2+bj1mANnQJcswhcta0qscYbmOtshpJAVFyk7wrycAGORZ1r6mLezRsHQNCZ4oaWcw28cKpAXXHz8tJuMJF0jYl+BaiQnu/HWtXgziajbjYazDk2SD5BU/R5FfQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA3PR02MB10116.namprd02.prod.outlook.com (2603:10b6:806:39c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:41:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:41:51 +0000
Message-ID: <a86192d7-4de8-4835-a868-0d0d7cb42eb1@nutanix.com>
Date: Tue, 3 Feb 2026 15:41:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/37] audio/dbus: make "dbus" the default backend when
 using -display dbus
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-5-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:806:130::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA3PR02MB10116:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a929e7-909d-4fb9-0138-08de633abfcc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THRZaTMxRUNLd2RjYkVPeElzMC85YUNLb25BSmhJYURzWXRvc1EyNVpVejNM?=
 =?utf-8?B?NmFvQVhFWG5XbjJkWkE0WHVXT1V0ZHJVTThXM0xPTkpFbXcxRjByckYvMkRx?=
 =?utf-8?B?bHNiTVZ1RFZuZEk1QUJGR3E1NVMvK3BNaGw3V3YyL0hVbzkrR09BRE9DZnla?=
 =?utf-8?B?Nk9vRzZmZi9Mc2FMd0NhdGo5TGZFQnJMczV2QkJCTGdNdEZkeVU4dGFwc2ky?=
 =?utf-8?B?NWNGc1g4UWR5UzVDbkJSU2dDTUJyNDFCdzFIUzlnWk1KMnAvYmV2Z1lvOThI?=
 =?utf-8?B?azE2Y2VoVEdIdldRaGJkZWhNdVVrT2lsa3JQaUtjM2I3SjVOZkgzWnNnSXZh?=
 =?utf-8?B?R3hrcDFEcGJCOFJDMlllQ0x4WGliL2wwN21lWGhQcE5DWkh6STBJSXhaemJW?=
 =?utf-8?B?K1BOeHpBMlRscFFObFE2bzFWbkRuWURxUURNYVl5WEsreTkyenVTeGlHVzhH?=
 =?utf-8?B?cEQ3dnFWdExkQTRXR0lHcUxHZHZkSGFFRnk3QjN1Um9CTDZ5WE14Szl2S3l1?=
 =?utf-8?B?My8wR2UxN3dQcFRlamF3eGF5SzBHTHNMd1E0Um1Sb1BWZkhMVDRaaVl6aDhM?=
 =?utf-8?B?NENwM2l5QVdpVmRmTS9ZL0dhTENxTkgwSm5XTjZsKzlVVlRvTXFhVzhhOXFr?=
 =?utf-8?B?Wi9DbTU5ZEs5dytsYktJK3hndjYvSkFPUmEzbHQxVER5VllneVVPTzhPZXJm?=
 =?utf-8?B?Q0NFaXZtdXdDSHJEWHRyK1R5U2hBVWdyVnZVUDdVcHBEZU1TQWxST1VnL0pT?=
 =?utf-8?B?cXV5RXhDNUFJMzRXYkdCUStQRzhzOFk4a2w1TDFsblM1SjVvNS81dzQ4RW1P?=
 =?utf-8?B?UjJEc0RMM2JGNnFQL2pLRHhOaGhPQ2J6US9mQmREOCt3TVZnQVJHVU9zTW56?=
 =?utf-8?B?OVpTRjFNTCtuaEVDbVFhL2VqV2ZIQXl2VDJBdGFEakNpOU9KVVk2d3VPUyti?=
 =?utf-8?B?ZkFCSE8vUGsvTm93QTNvb2N3VEpNVG0zTER3dytPL1Naa1NHa0pYbHNuRkxH?=
 =?utf-8?B?OHE0amlFdkVWdE5oYy93UGh1UEl1SmFWSnk3SzQxN1Q2UVVFdUNpVndHQk13?=
 =?utf-8?B?bWhlbDE1TGJBbEsyV09Ienp5SUdaeXR3RmdYMU1jN1JnbDZQNFBMWTVMZTVh?=
 =?utf-8?B?MzRCdC9UdHpHL1h6dysrYW5NRldmVXNGRTBMZzRZRFF0OHp5LzVXMUZPQ0Ex?=
 =?utf-8?B?b3M4NW1GalVDUzlBdkpjM2kxUFg1bWVQRXFtNVlIYXVEbURvK0o3SUlTWlNY?=
 =?utf-8?B?SGNkZnRZelc3S0NnN0gyYnJ5ajZGM2ZSVHlwUVU3K1c2NHZxb0F5ODljMjZE?=
 =?utf-8?B?dFZJT3hWMHJDRTBNTVhzM2FqTUtLUHMxWlNMVGJ6a0VKYTdhbzRWQVdtRVBS?=
 =?utf-8?B?NUtMTDVWeEk1QmtkOGd4SDZwSHFQNWVOSU5FWkpNOTVUZmFWMnBMV3VBZ0VU?=
 =?utf-8?B?SmhRdlZuLzRVakl5S05HWmtrOGZIK3JyR3dUOFRXeXJkeWhtSU9qSFZyN0hZ?=
 =?utf-8?B?NE5tV001bzJIaVQ4VHNwNTRqYkNyUW1CM2ZLd1N4VUR6bUFjVU5uTzNlMG1l?=
 =?utf-8?B?dXhtTVlEa2d0QWFDUWtGaE9NYmFaTG16NkpMV1FOeVNwUytwa2tIZGFyZk1y?=
 =?utf-8?B?UldtWTh4Rko0TkZkUDNGbHpLbjdhS3d5aTVjbFlhQ21taEtzWHNvaFd6SFIy?=
 =?utf-8?B?Zzlod2ZRV3dHbThYV2doREZZOGdkeUIyMjFSZnVCYW1RVHBxTXRJcEF0Y1RQ?=
 =?utf-8?B?WnBaRG9vbXUxOVlDQkxaNC85Q29XUitTcjlwS25ObzlmRDB3T3RidWtOUFRP?=
 =?utf-8?B?WGlqWE9lQTRaVUlMaEFsQlFpcndxNHVDUEpNTkVpbVNncy96b3R6Uk9JaDly?=
 =?utf-8?B?TDNoWUFleDlSZUNUNkY0M1RYRWVRdHltRXdTVXhXUkpWQzNMYmNMRytWUnk2?=
 =?utf-8?B?N1dzTHZvNjRrQWxTenFLTjdPTGZha3VjQVRJUS9EY3UyUzVFVnJ2YmNISHlW?=
 =?utf-8?B?S1NKWDgrQVNVZGkzczMwcjB6SHNZODFFQ2RMbmF0SGsxUHp2K0N1ekpsQy9v?=
 =?utf-8?B?bGlkNUtzNG45b0doVnFxNDdGaFZIU1dXV0VyejZrcXJHSWw0Sm9CK2Q0S0E5?=
 =?utf-8?Q?vaxw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEcyOUFsdi9OTzVCZUkxYy95bWppVG5MVlU4R21aM0xwelViOVRBOVAybW5C?=
 =?utf-8?B?OG0yblp2T1lzcWpDQ1l1a0JUakNqVkdLVkhBKzByYlBHMnNyZTZEeHFOY2w2?=
 =?utf-8?B?ak1ZRDBjckVZQjNIWjhocmI5anozeXN3S2RKQlJvZHdsamdTS0NSd0RoL3N3?=
 =?utf-8?B?THpXWDljclNOeDNpM0dZYTlDdlBQMUVlMXN1OUxOVC90OXMwSmUyUi8xYzdO?=
 =?utf-8?B?VjgwU0ZMekZzbkV1dVAwSG9DWDZEUHMzNVMyc21udlh0djFQRVJyaWpEcXNy?=
 =?utf-8?B?WmNrUSt0YStnS2xLdFFTcVdlMnQ2RUJIMUp1RmRmTEI3eVdWenJkZTdsTFpB?=
 =?utf-8?B?ZnlPRjBRMTkvclg5bklYZ29aeG9VL1F2cGllZU14L3REaDNGdnI3UjhiOU8r?=
 =?utf-8?B?V2JHcWNmMk15MFdRdVFoT1U2bzVsVHRTa2c0bUcxcWh5Y2xtek9lbnFFcGlY?=
 =?utf-8?B?WTNQb291U2ZPSGZNTm5SY3hTZExmKzRpT25FOUtldWJrdVpFQzNUR25HMm1i?=
 =?utf-8?B?N0hzZ29XakdVeXBYa21IL0RCaVNlSDFwanliNmQvcmNNcHdRc0h3YkI2SnF0?=
 =?utf-8?B?KzB3YUxmcUhEYWNwYjRKUnZXb3RjNnhaUE1iQ3RZY0FkY1ZBQ1ZHeEsyMjMw?=
 =?utf-8?B?RExVaXBPendPUDdreGdpUmdwanJyMEIxNEh5Zk9qRm5mVHBJYUY3K0pIMkU1?=
 =?utf-8?B?cythMFJaYm9TYkZEYi80dVl2QURsN0hNR3YzYnhqK0VKaTFkMnNuYUFmUVV5?=
 =?utf-8?B?d3pIbHk0U2RBajAybThIWXoraHh1N3R6d0Q0a21QUWhFd3lyeHo5SXZLVytX?=
 =?utf-8?B?U1J1amtuS0R4NFl3QTZ5UXVFbWZwSTJ2TmRQTnhGK2VLSFJuSzZHdGVrK252?=
 =?utf-8?B?elFNZTJUSTVmYW9rc2ZjZlVuNDY2a2VBWHQrMm14NDJ5QUZGQjRKbjg1amkw?=
 =?utf-8?B?WmJ3eWNaTHhuWXhxVjZqR2pNMU1SNURKK1ozZFAvMlZhWTVXcUJWSi82clEz?=
 =?utf-8?B?RnZ5Zm1rV3FORGp2ZmpMdmg4czk3SkYwd0dQUnBzMnUrTHNOc2gzeWg4aG8x?=
 =?utf-8?B?aHdIN2ZHZ3g2N1F1ZHIrVWx2TnlYZUJwR0JhQjlKa0NhRmFsdlhHZlM4WkJm?=
 =?utf-8?B?WVh1SWxYQnFRbWMvWlhXZlBVdU9WTHJLdTQ1b2VXMjdmMjVCSUwxdkNOTnB3?=
 =?utf-8?B?TkV3T3Mzb0h3OWRNZG90elcvdXpVQjFFUEVJS1NFZFFqbUFDVHZiYk1KTSti?=
 =?utf-8?B?SkorMWxZMmR3YmJoeUxzRmNvd3haSnNpZUhLYWNwa0VNYnhlS3haVlQ4MDY2?=
 =?utf-8?B?MlIwWjlVQlZEdXdzTExQRVpIb2JzSGRrNUMxM1ZScE5uRDRnMnRNN3QyMm9L?=
 =?utf-8?B?ejYrdWFZdytjU2U0ZXBtRlFoOU8raENQUzFmNkNJMjU1eHFzdWM5WG1qNllj?=
 =?utf-8?B?dzFWZlpacXpIOXNOaXpxVWc5UjM2VUFqTU9sWnRVRWNsQzBsZ1cxTnNKT2Iy?=
 =?utf-8?B?UEZiSFNFSHNFT0JxUkI4TzNHMk9HVkxSZ0hIUFdVY1k3VDZvZU5vc0NWOE85?=
 =?utf-8?B?WWFIT3plNEFYRFBLTGZWbnVDK28vOHJCZXY5Qm1rS1RML1U4aTF1ckNJeGRN?=
 =?utf-8?B?SzRlZFcweUcwQTNFNDdpZmdhNUpGK0pERCtoU29Mam9HcW1wUERObXpFS3pM?=
 =?utf-8?B?c0V2THhqdGlOY2pObGNNWnpVNkhwampjSTdjeEpSNmdMWGphQ2l0bk5OV2pa?=
 =?utf-8?B?V3JneUllZVR1Vi85ZHVkZ3h0R04yNm5SUE9HNHNPa0t0Snp0UzZoNVJRR3Yw?=
 =?utf-8?B?LytqWDJBUSs1TEh1S1dldE9WOEFNRm95U2FnTEd6QVBTREQ0am5kejF6SStB?=
 =?utf-8?B?QlFwU0s1QkQzZUpZa1NFUG1xWXhJV1V4Mnh5TWV3eU93bCtpU1RqYy9US255?=
 =?utf-8?B?Z0kwOERXVElXTjNsUTBaVlh3ZktGS2h0eFRLRlYwZXMxdVlKRWxkMXlyRWVo?=
 =?utf-8?B?Rk53eG9PWWRKUStlOTJ5YmR2NHVLM2RyQ3BJcHdXWDVwOGVOeGY1R0NsN2p4?=
 =?utf-8?B?NUx0d1kzUEZRL3JBdnN3dDhlelBiWG1tbWZHSEZzbnF0ZTB6U1didWp5YkJw?=
 =?utf-8?B?dUVWS2JKeHFDQVpOWHZYakt2emhsc3BIYURKNkZ4eEdsZlpmNTMxWGV4ZWJ5?=
 =?utf-8?B?SHJiMW5weEwwUFJZbEpmYjZ0azhuZ2Q1Ly82RzhIMTUwdDhaUy9JdWVPMDl0?=
 =?utf-8?B?VWNKRVovcmo3UG9WcnVrZW9lRmtzQUs5OUJoL2MxK0ljU0RJU1lITFk5TjFu?=
 =?utf-8?B?RlJqeW9acVJ6cHV6UnJlUVdiWjNqZXBLVXVOb0hvNTZSeTJJZjZ5L3JqNjNw?=
 =?utf-8?Q?9igBzmctp3mTMaYQ=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a929e7-909d-4fb9-0138-08de633abfcc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:41:51.0985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o784nnHAlm4r+fQF2p9qPEXFMh9rTjx1YcicyhOHqoxDdCbfnfIE14g4OoD+4okYS3t6yWfkmh5GGP0qH0ku2VxVosCsue01/O+AKGSPgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNSBTYWx0ZWRfXy5waNKR2OwW8
 5gqbfdJp78clW2ajXqJ0UgrHeluVkT1dA+HOwduYHgFlVIlO0662hfDBTDwpjnu/hzemCZdCr1q
 Xc3uno+38VwvpQCLxzv7eqQAUOZE6SECBf43TxiKy6SEecZT1BFqUQuOG2hSxO+85m09YjYx9Lm
 VfUjJhHnoiEb8kN73tnyLWyb/rUqqTs+YGZDwNTNEVNX4xKglGG33vJTfrvC+djzTevMh22jqFN
 Ear2JJRX06ca2Dl6/lCn5bMgfKH4ufbICaGaxsBwM1ev1EgoaCAPRmcju87Ez97hvvkpK0zchUc
 Ma7IxjnjR3T1z+33Caic0FO5Z7G6J/gqVmkEddAnjdrUzhasvfgk8QIxxG1Cv+YswVRyFZt/aQW
 d8UWJMcEMRlBG0DnhSucgX+VPf2bI2gpJSvkOTf9GMCovgw/4W8dTgBt4kDXQYyzzDANn1ogXjb
 TNvdI+P+jO15Ce1hteg==
X-Proofpoint-GUID: 3oLgTIKFf4alJAHAHpfF1IlNMiOWgBIE
X-Proofpoint-ORIG-GUID: 3oLgTIKFf4alJAHAHpfF1IlNMiOWgBIE
X-Authority-Analysis: v=2.4 cv=AeC83nXG c=1 sm=1 tr=0 ts=69821741 cx=c_pps
 a=eQAqIyCScLYb0ahyOVIXtg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=B653tGuM8NYLLLkMC0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
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
> Set "using_dbus_display" during early_dbus_init(), so that we can try to
> create the "dbus" audio backend by default from audio_prio_list.
> 
> This makes dbus audio work by default when using an audio device,
> without having to setup and wire up the -audiodev manually.
> 
> The added FIXME is addressed in the following commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c     |  3 +++
>   audio/dbusaudio.c |  8 +++++++-
>   ui/dbus.c         | 22 +++++++++++++++++-----
>   3 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index e5841d7f0e6..80e4ba83712 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -57,6 +57,9 @@
>       that we generate the list.
>   */
>   const char *audio_prio_list[] = {
> +#ifdef CONFIG_GIO
> +    "dbus",
> +#endif
>       "spice",
>       CONFIG_AUDIO_DRIVERS
>       "none",
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index d729a810aa6..1fe7c4ed647 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -32,6 +32,7 @@
>   #endif
>   
>   #include "ui/dbus.h"
> +#include "ui/dbus-display.h"
>   #include "ui/dbus-display1.h"
>   
>   #define AUDIO_CAP "dbus"
> @@ -408,8 +409,13 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
>   static void *
>   dbus_audio_init(Audiodev *dev, Error **errp)
>   {
> -    DBusAudio *da = g_new0(DBusAudio, 1);
> +    DBusAudio *da;
>   
> +    if (!qemu_using_dbus_display(errp)) {
> +        return NULL;
> +    }
> +
> +    da = g_new0(DBusAudio, 1);
>       da->dev = dev;
>       da->out_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
>                                                   g_free, g_object_unref);
> diff --git a/ui/dbus.c b/ui/dbus.c
> index d2dff332585..e44e2ff9877 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -35,6 +35,7 @@
>   #include "ui/egl-context.h"
>   #endif
>   #include "qemu/audio.h"
> +#include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
>   #include "qapi/error.h"
>   #include "trace.h"
>   
> @@ -218,9 +219,20 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
>           return;
>       }
>   
> -    if (dd->audiodev && *dd->audiodev) {
> -        AudioBackend *audio_be = audio_be_by_name(dd->audiodev, errp);
> -        if (!audio_be || !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
> +    {
> +        AudioBackend *audio_be = audio_get_default_audio_be(NULL);
> +
> +        if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
> +            audio_be = NULL;
> +        }
> +        if (dd->audiodev && *dd->audiodev) {
> +            audio_be = audio_be_by_name(dd->audiodev, errp);
> +            if (!audio_be) {
> +                return;
> +            }
> +        }
> +        if (audio_be &&
> +            !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
>               return;
>           }
>       }
> @@ -475,6 +487,8 @@ early_dbus_init(DisplayOptions *opts)
>   #endif
>       }
>   
> +    using_dbus_display = 1;
> +
>       type_register_static(&dbus_vc_type_info);
>   }
>   
> @@ -488,8 +502,6 @@ dbus_init(DisplayState *ds, DisplayOptions *opts)
>           exit(1);
>       }
>   
> -    using_dbus_display = 1;
> -
>       object_new_with_props(TYPE_DBUS_DISPLAY,
>                             object_get_objects_root(),
>                             "dbus-display", &error_fatal,

Looks reasonable to me: out of curiosity, what's the best client to use 
to test a combined dbus display/audio setup? Anyhow:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


