Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2A4CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKwon-0004uM-7B; Mon, 17 Nov 2025 05:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKwoh-0004sP-Qo
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:50:40 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKwoe-00006r-Ss
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:50:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAQdW3+WfiOfa3QvtMRZH6lCmxGIdQsyDHz3HOu7YcvB0tHOKCfLdj+95SXyltwYhwQ+587oc5toyPRTt88pkd+JOxpnEKJjktPVmTZUBzxnQi+aIGWhofADFzKlNkVjxMOWC2acgTJyWawBcKx7YE7i8GI81knQ3QZHnLY/2ePnXuea2ZYqI3xHaK8IkpRocIGcLy2xDrbc6yV0TqeVmQx1QUmM0PMV5YccejHTYeKukfi4mQHJe9xRwMDUatDdnU1cBVGnbl2RqzrK4iwB+aWqP3nwMjlAtQJipB6SNmYjOft6sT7XLAQqf0vYyWtFrrZaRPbc0l8Yw2sylWeCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caZneqCNyX3G2bmpMCenf6EL8DsDA5BQY2cASUPDoGk=;
 b=r9gRvzCuCYjOtZwN4kPjjUkOHf9ub+0ZZezciW2k66eJYmexXORuFZO+XW7pFPTygJfc488hFaRzkqCwyIz3J3oFI7RS5HufW6z53QO4KCi3q6gdTlIsZkfeFzCIkLG6scwUxX8Xz+lGVV/dD3G36BpirebwBRDODeUYd157deQz7sknHD9wOv8nOfIIStCWkbQJihL1P1nT7yR/UYuPqSap4QGjAWlJmg1Rf8i6IJkGnxEk3LBCqTZmtshBQQiDDuiLI57gD0tFkTbRP2xXTVq3PY2Du/9IOFtRaUwk02C77RETBbMEXiwiSfz2xWGt0raD/hTdx+J37rLEbDF4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caZneqCNyX3G2bmpMCenf6EL8DsDA5BQY2cASUPDoGk=;
 b=Mkm0nk8F4Jp0H1mQZoKT9mp40wI8sd/fYFU6YQe3Y7Mhbl3KZ0bsh9Hf5SXE89zFMX32BXrV8Y2JeHsLvxbr/azfKVw3TAZl94krGgP3GqikPV7Q+tEI94/z5owAxI/TG4x5+3/e/tYTta5sD6WFrHwtqg8ouqF8W/KGyrENR6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 10:50:28 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Mon, 17 Nov 2025
 10:50:28 +0000
Message-ID: <5ed2fc05-9de2-4586-bfd4-5839c400e4bc@amd.com>
Date: Mon, 17 Nov 2025 18:50:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
To: Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251117055112.99046-1-honghuan@amd.com>
 <87ms4lrtd5.fsf@pond.sub.org>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <87ms4lrtd5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd1584f-633c-4b15-d021-08de25c71f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHY0cEFiM3JORlFJWlB1SUcwc01XQ3IvWmsybEpGU0NRN1BHS2V3aEdOc0Mx?=
 =?utf-8?B?UkcyOWFKb0c4dnQrUDJyRjgzNnBucnNtaFZLaG5WRXJIS0loWHoxdWhRNkVT?=
 =?utf-8?B?R2JPL1F2dVRIR1ZBOG1ud0N1LzV3a1ZZaDZwQVNSTDdZdnBLdmp4ZzhocVNH?=
 =?utf-8?B?ODVpWlBsYzZwQnJHLzZKc3VoenBWMlZ5eWt0TmZwSFlKdUlOZWdPNUd4QkdM?=
 =?utf-8?B?cGM5Y2w2TStPRnNod0Z4K0JwVFA3MkJwNitzWmNuRWxCVXZMUmtOWjlwWEhT?=
 =?utf-8?B?RHUwVHptSWo4R20rb1JFV2JrL2l0ZVhqNCtsSlhUUHBlM1d4Mjh4TzIvRTBu?=
 =?utf-8?B?SFdZVEtydGZkVHArSisxdEJDZ2QzeXdZbjlNYWZPVTdldEFFMU92V3Mra280?=
 =?utf-8?B?c3ZzT3ppenZZNXc4VXhOU0FOM0M1UEJJcyt3dkNEdGdsY1JxMHYveFc3dldI?=
 =?utf-8?B?aW1ZV3lNZzdTcEpLNTdnZW5mQmNhQUV5SUpybHE3MDJNS3prZ3Z5cS9jNnBl?=
 =?utf-8?B?cXFYaVNpTlVIZmt4Qk1Cd1lCUi90cWJqYVE1d2pBOXpkTDViMWJmY29FdnpP?=
 =?utf-8?B?cGNiOWFkeWJ4TUh3Y1g3c0tLNFZ2Q3ByTDBOTEExMzh4MmN3a0I2OGlSUW9B?=
 =?utf-8?B?OEI3N0t1NlFnK3RJWk5rajYwbi85WkRWeUVGR3BtakR4S1NCQk1XdXhwNlMz?=
 =?utf-8?B?Uk0xazdxTDNZeERDNmF5YU9ZcGJNTzRkajB4SFZHY2hnL1dzM2JtcHE2aE14?=
 =?utf-8?B?UjQ1V0hid0V2MGZRUHpHaEJjRVFtS0o1aVB2Q25Bcm5RaFVkeU9mQjRyOEFt?=
 =?utf-8?B?eGdEVmxNRURlTk9HK0FWUTB6Z20zTngzaGxMMHBvZnRXTDFhZzFHU0RxbStp?=
 =?utf-8?B?MkVyUUUyZ21hR1FIV2pCL2JqNDgzZ2sxSHVBTkcwTThnT1dJNllVa3lVVFZR?=
 =?utf-8?B?VklHemlYMzNiZlpZY3FaMGhpOWpCOFRZYWdjODg0bENYRnJBSXpqTC8wb2di?=
 =?utf-8?B?bG80Q0ZwUGt1TXVWTUQ2NGpQcWRRc21maE00TzFrK2c3d2Uvd0Ryb1c5L2Zy?=
 =?utf-8?B?ekZiU0didUU5QXIrc0h5TGEyclA1M0ZzYnFzcDdjMzBVZHhlZEJBQ2x3blY2?=
 =?utf-8?B?alNjM3dqUExIVk84aHB1Z1hTTkdZWWg1bHllS2tNWGhiTjg2SjBSUit4WHp5?=
 =?utf-8?B?ZlJ0Ky9HUS96b1FyUFBXWGh4RXJEV1lzenM5SFdmZzVpbzFIVkFRVjVXZDhU?=
 =?utf-8?B?YXVhVURoSTJqUE1QeUVMTU5UZVVIZkppeWJQNzgzaWlKR2YwdGVYcVVIK2RO?=
 =?utf-8?B?OTJWVXFOWngrZUhuRHpiUkRoNEx3RUpZNXFrbzYvNGY2RnhMZlo3TS81bFhN?=
 =?utf-8?B?YURUR3hRM2Rja2VqTlYvVS81M1B6Z3hsSHNaaFhUcWZIUGVJSGpPYXdLQ2hn?=
 =?utf-8?B?NHV2U01LOWtkZHduWisvWHRwRnpaaytzZWxVcEx6UnA5eGtuV3haMXpXb20z?=
 =?utf-8?B?OUtUN0t5bUVrY2tzUzVVb1JqM3VubmtUSm44TFR0d1o5bk1lOGlPUFVUYit4?=
 =?utf-8?B?MW5EaEFRN0RlcmdzS2szc0FOb1dyU1g0SFA3TDJxeW5Qc1c1VWR5T2gyVmtT?=
 =?utf-8?B?enpzdmJtaExONUFVODFnRFlqNThtTi9qWm8wTVhObjZLNDBLMURMOCt3d1Ur?=
 =?utf-8?B?a0srY0xCY3hkNUhNZ080eE1jcytXdGFGT2FodTVFS2JGVElnSW9sSE1GeXIr?=
 =?utf-8?B?OFRZWUtTT3FKTFBaWWRKMjVTTWRTelJReXVkVFgra1krVHkvWVVsQ3F2RnpM?=
 =?utf-8?B?aEtVV1hFVnRzRjVoQWpSUUxBZkVSZUtXWWZYQnhLd1F3M3hXTThXNnRFY011?=
 =?utf-8?B?cWhrRmx6a085UG9UWHNsN0Q5T0I1MUk0b1dxajhRZlBQeER5cWdSaVY2c05T?=
 =?utf-8?Q?ySUXt9Xf3oX+hvcxzqcV3GmWdLOv13Ja?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFloNXZqR1RpSnczY2R3dTNZb3dwM08rKzdOdEZBa1FQRzEwOEpVaFg0N3N6?=
 =?utf-8?B?WW0rd0tVVXljb3hMNiswMGRtdjhhTVZwRmpzMU1ib2Y5RjNZQlRBMG1MaTg4?=
 =?utf-8?B?LzdEMXFpRGZSUmVHZXN5RmRRbjNpOERaSXVncnFhcU9JcTdVUTRZejBqRDl0?=
 =?utf-8?B?dEo3V0QwN3hpTnRSZXpBSkFPK1pLTlhzb3Rwc0x5MnQzN1A1RzFtYmRPWVda?=
 =?utf-8?B?MFdJdE9WUjcyS1NWS1ZENEgxZTdKWEMwVVhlb2k5eEVoVzBUQytYUU1nd3BM?=
 =?utf-8?B?VGZUclphUXg5REhKcnRBWklFUWsySSsya1RBQ0xxTWYwczBiVEEzTnVoTUJr?=
 =?utf-8?B?Z1NmTUtaMmM2QUwxMzdLaWE1YTU3a3AybE00ZldvRzhCaEFDd0dxRTJXenEv?=
 =?utf-8?B?TlhQYTd1ZzM5dkk5cW5pVVhneFNJbHluY2RJejN6T2Y1elUyS2ZRWUJKTEsy?=
 =?utf-8?B?ZDQ4NW5ielp3dEMrNzJ4R1IxTUZTK1VGNVR3cTlNcFBZV0pxdUFaNW1Idmxh?=
 =?utf-8?B?dHZDdHFKVURIc1dURUNuaUlaSlV1V0pZam1PdmU4eDBsSTZBaVdTQ05BcnZ0?=
 =?utf-8?B?K3FpSlVZWk1BNHZEc1NmUS95U0s4Z05TeEFkRTcxR1VxS3ZsT3FSWEt4Y2xC?=
 =?utf-8?B?WUJOT2FWWVhhVUxXMlRWbzRlV2YyZGxZbG90T0tybi90cDFGMHBtTisyZ2Yr?=
 =?utf-8?B?ZGV3QUYyZ3FkcHpITTJmOURQK0ZYYjdFMC84RVVaTjRhb1FZWlJOT0l2R0R3?=
 =?utf-8?B?MTVkdVo3ZHNiNyt0TTJQVHNBYW9YT2pVZnlwR1NDN1g3ajVWb3ZFMFN2dkU4?=
 =?utf-8?B?ZEtZaE9OakJuM2gyK256ajRWRzRPRHZNaTBtUmNPM3NwWUltUU5rNDBYS2c1?=
 =?utf-8?B?QU5yQ21KbVFRZFRXb2JmNzBLZHpVdlp5SnFUMTVjNkxXbE9jbTNTVjFaYkpU?=
 =?utf-8?B?THBWNnF6bjFFamdUbnpCenAxaGhoZklpbHkwa3hLc1FCcjloYm9NQUJaVVU3?=
 =?utf-8?B?UDR3amRQT0JRQWF6b2lyYmR5ZnRmWlp5K3lvenpxc3piM285YlpDbVRVc2Zt?=
 =?utf-8?B?R1dJVkRXTVlYWmtSOWdjYUMyR0M4UXEzelFhRU9xaG1GR3hVN0J4NnAxSlVw?=
 =?utf-8?B?cGNnWVVUejAzTzhLYVdOVEZKTlNyOWloMVlMUEU4UWdPYU1TcTcyQU1QamJ2?=
 =?utf-8?B?YWlJQ1JvOUFNUXgwN2VnTTBwN01XYi9YUXA4bk82UU9GS0N0Y2RFWDBHTmRP?=
 =?utf-8?B?NGt2cHRTMngwYmZzR0hJRVFoMWN5cmhHb2VueW1na2JzOCs0S2UyUDJha0sw?=
 =?utf-8?B?YzFZZVA3ZFR4S3d4ZGlHeUJhczdROUtxVjJTTWsrUzhoM3hlcE9ObUM0eUtr?=
 =?utf-8?B?NjZmNlZsQnNQTGpNWXlXRVFiS0dLUDlteW1rOVN0LysrcFYyTlNydUtwSGRp?=
 =?utf-8?B?REp3TXMxLzRRTGI3a2lTc1JzUEtKRXl6MG81RUp5SU1LYTVEMDJNaE1pbDQ4?=
 =?utf-8?B?alhTWlhEZTdXMFBQUExXSC83ZG1mL2ovbnNoNFUyMzU4UGpOdUV5TkpCbis5?=
 =?utf-8?B?U2pPdm1TV0xkVkswdWxXaDJ6NjF3UlRySDlUTFp6MERhaVZudWcvZmxWcURX?=
 =?utf-8?B?eEdQeHcrS3l1ZHk4WjQ1S3MvL2RaRmRWcXlCMHJEcGlWYWtaQ3RzUm9JcmFI?=
 =?utf-8?B?QzRSYjQ4T2lrWkIxMkdSaGpQZ0FTUy9XdlM5TWdEL05Fckc1M1gxdU1JczI5?=
 =?utf-8?B?cTc5WGdPZDJmb2xGSkgzaEZNZUdnWjZmbU1FdzBGVDY2TUlQcXVuT21jOUdC?=
 =?utf-8?B?Rit0WDU0Z0dseVhyN2EzR3hrdXBFRmVEdnM4RUQwdGg2alVrU0JuR3NHaTBw?=
 =?utf-8?B?dW54aUJjaVo4M0E2K2JKUXVSUm15UE5BejBGMEJzUzFwRGphU3k5VjhySVZ4?=
 =?utf-8?B?dGllYzdzUkd5Zk5GZ2V4S1Jwbm9idW0vRzhUSDhTM0ZxNXY1ZXdOQitnZW1x?=
 =?utf-8?B?MXpyaldNMmRHd04vK1JvcFJGOXByVVY5ZjArbU03SFZwaWtBdER1S1c4R1g3?=
 =?utf-8?B?RUFveDllL0lBR2wyV2E2S25DeWtybTFRN0NUUkxyNjFMNDc3SWwwamh6R2xF?=
 =?utf-8?Q?KHQ1Lcl+KxCFRK0Kgu2sUf96u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd1584f-633c-4b15-d021-08de25c71f02
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:50:28.5394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th1WkoZyixyOkvMMUi11kSAlu/DcbxuNE9xiJErrcNWI0rqpw2XZEyrIGQ2YpKLWe1Be78enUpIkdee9BdPRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Honglei1.Huang@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/11/17 15:49, Markus Armbruster wrote:
> Honglei Huang <honghuan@amd.com> writes:
> 
>> The error handling logic was incorrect in virgl_cmd_resource_create_blob.
>> virtio_gpu_create_mapping_iov() returns 0 on success and non-zero on
>> failure, but the code was checking whether to set the error response.
>>
>> The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
>> properly handle the return value, consistent with other usage patterns
>> in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index 94ddc01f91..e60e1059df 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>>                                               cmd, &res->base.addrs,
>>                                               &res->base.iov, &res->base.iov_cnt);
>> -        if (!ret) {
>> +        if (ret != 0) {
> 
> I recommend
> 
>             if (ret < 0) {
> 
> Why?
> 
> When a function returns true on success, false on error, we check for
> error with
> 
>             if (!fn(...)) {
> 
> Same for functions returning a non-null pointer on success, null on
> error.
> 
> When a function returns non-negative integer on success, negative
> integer on error, we use
> 
>             if (fn(...) < 0) {
> 
> When a function returns zero on success, negative on error, both
> 
>             if (fn(...) < 0) {
> 
> and
> 
>             if (fn(...)) {
> 
> work.  I strongly prefer the former.  Why?
> 
> If fn() returns an integer, fn(...) < 0 is very likely correct (it's
> incorrect only if fn() deviates from "return negative on error", which
> is a bad idea).  If it returns a pointer or bool, fn(...) < 0 won't
> compile.
> 
> If fn() returns an integer, fn(...) or fn(...) != 0 are likely correct
> (same argument).  If it doesn't, they are likely backwards.
> 
> Because of this, an error check fn(...) == 0 triggers my spider sense
> when I read the code: I stop and look up fn(...) to verify the error
> check is correct.
> 
> Please don't write code that makes me stop and look up things when I
> read it :)
> 
>>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>               return;
>>           }
> 


I think this change makes sense for consistency. While the CHECK() macro 
does hide the return logic, changing to CHECK(result >= 0) makes the 
error checking convention immediately clear to code readers - that the 
function returns 0 on success and negative values on error. This follows 
the same pattern as the patch for the other virtio-gpu files.

Will update v4.

Regards,
Honglei


