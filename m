Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38936C5B549
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 02:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMzwg-0004Wi-EO; Wed, 04 Jun 2025 22:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1uMzwd-0004WS-V6; Wed, 04 Jun 2025 22:03:03 -0400
Received: from mail-dm6nam11on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2415::60f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1uMzwb-00013Z-W1; Wed, 04 Jun 2025 22:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySTIjveI+7YtBRHdWvJLtGIfo6hW4A6BuOQVzc3QieGUDnbAH2Kuuc8siTkvg/uGFCUiCZZYFiRfpP42Fy9IqB109R6kpEh2liUTWl2l8/lBv3/zI6Um3QjYrmgK52dVotzFkaCDWUY+EI5YIzmOrDG38qaTuuD1s9blgE9xzZWnrqi+tS5JOOv4cGj8ltwmgesJv+bgOboDP+QrnuOtO46+YA2uS62oSdVkuSmEmz42Z+2jT0lv+/svwPZvC3jZ+C7u8NlrVyRjaHkrRfHXZs6WD5UpKNNfnP5y1O3IdeNqFW416fQD33au99+dWMgf8v1OOxg4CwrrBPnqiTJdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOxdMYpr2PmLCowa7hgbXUqMafxQmcCWg/JXrHamyUs=;
 b=xjeI1yMh6ci+EDgeKjh0vNcay+2dONF/ifhJwYeZ6XOTTD7G6iHA4zQGm1ODj8MWP8+LoNpKBmy0i2tgy1wJ3fwlkCO8EFWDxR1vI17xup/FK7+h6IpYo3TmBvh2kGcKZEqbyHS+y+TNRaKI3ffhE/YT5ghxYGcyMNOaOYYPgMKQxalM9yWflreebr56nFBA2kSzktsw8qJ4c1cG2+niY5d2KQzNJjp0cnRqMuCprUC4RACyBCy6f8y+WwvKqwVkiRqjvofbWV9rD4Rno1nc6bBbLLYVRPEAH24/yIEB84bMC9oWs2Z3bIRwoyTKqc1RhA0JEX9hBfE4JomJOfyPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOxdMYpr2PmLCowa7hgbXUqMafxQmcCWg/JXrHamyUs=;
 b=K9h5xmmuQfSL2RZmOw+u2XjNH1A3LVBARuMvQlfS+xOpm9EAreRx6gAV4RP+YsZxFJT4Js7jhVyph0tegHJKnG9cTGvB5ZssLcyjGtXGtesQ3GRXQDnNE8NPkNWQgmfU9SKiA9jravi9mJ5RL3Cfm2pYdhyutDa/eyJm5254u0x8mJcXtIxYayAt94P7kITVGO8a4iVxuQEc30rLQJTE5IRkW8asb42Js+u8ocPnm8fnyf9OGaroWGdFXEvN5csGJFdOrhXqBO57pkP5CpZGkufF3WboFG4X+FTFy5O9UzxNjxm/2+hUvBzS8qo3jqqbVTGdo6Okay15IqtETee56w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Thu, 5 Jun
 2025 02:02:53 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%3]) with mapi id 15.20.8769.037; Thu, 5 Jun 2025
 02:02:53 +0000
Message-ID: <74d9f7a2-dbf4-48d5-bda8-847d1fc73e38@nvidia.com>
Date: Wed, 4 Jun 2025 19:02:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] hw/arm/virt: Add support for user creatable SMMUv3
 device
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::40) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fdc3ba-0dfa-4f8c-e457-08dda3d514f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGlmeUFEZmJGRjBlZzRQT0NxanRYMVV6aTR2YmxSTitVL2VQR1dxYlN6S3lZ?=
 =?utf-8?B?TkNwUXp1N1F0OHFTQWpLcUZXSDNncmRVcmtWaEovZ2g4ajlCVGpOaEFCcm4x?=
 =?utf-8?B?MFdBeE83RUNXRGFHZ095OHZoOVZBNkk1Qk4rRDhPcG1ocGZ0a2hsQnJtWGNF?=
 =?utf-8?B?T244ZzhNM3Z0bzVyck9MS1BjQTlQeWxRallSL3lwcVNJN3piZS9yZUFOQk12?=
 =?utf-8?B?dTVkdlJ1UGVVWnk3STVoREFkY3lIc2d1WTB6TVpLcVhFRklSY0h2Ny9hdUNZ?=
 =?utf-8?B?S1JnZmpVTTVOWEd1dHlvU1pwVlRBVnJ3clM4NnE2VGhENEhOeGFmTEZLT1Iw?=
 =?utf-8?B?Mllsc2R1M1EvT1hCWnl2UmtMS2RSMitRV0V3cFNCYUNVNHg0d3I1NUo5dHdF?=
 =?utf-8?B?REFnU0ZRb0RmYVlheG5pT2hnTHE1aVVjMGtsUFNVb3lUanVBRmY4ZHEzcC9x?=
 =?utf-8?B?WFBKWXpqMEJlYjljeDNGZk1iTlRycy9MSW1VTm9NMHdZWWQ1ZVpDdm5POWUz?=
 =?utf-8?B?K0JVczdRbUMzM0I5QzVQWmYxZ2pSRStUTlgwQW40clVPNFpyMlZjV09vc0xl?=
 =?utf-8?B?Lyt1U1BZa2ora1A2QnhlN3JHbjZwSndXU2NZTitpazkvaEVIZUtYRUZobnJ0?=
 =?utf-8?B?Z1pHRGpDcktRN2Q0Nkp3SnFEL056RWpvbWlCbktJNnZCeUVKMytUVDFQT040?=
 =?utf-8?B?L2hQd204UTRsNWtja25POVdybkwrTzI4VmR3STFZTXQ0OUZQdGlQSVlBWjBj?=
 =?utf-8?B?UDkwZkpIWWt5OEM3clNOZmdQMVgwckxoSFVaeExMYnZpK3M4anpzdXRkQVFu?=
 =?utf-8?B?Um12QTBZTlcyK0ROb0lzUVMzL2c1cVpUdkw4ai82ZEMwUEZFOWhNT21qZHph?=
 =?utf-8?B?YllQekEyeVRsSldWRFA4ZU5aYmk0QWNEellwMFpid2haNkVhaVNySGd0cXdh?=
 =?utf-8?B?ckFBdUxkYTMwSlIvVC9ZSmoweThpbldoNGRQSmhFYjQ2Z2tybnBIYTZ4RTQ2?=
 =?utf-8?B?YVB6bHlrZElabi90dzM5T0FYVlpQUjgrRUFMWWpXMmZ4bHR0bjd5TWt2TXE0?=
 =?utf-8?B?aUlVb2FEWTV5Q2RZbUcrUGdaRGtCRlJkckhXbDlIMEhGaDB4UDZmYWNLRTJD?=
 =?utf-8?B?RlMzRUxXVEpuRDBYMHRjWWZMeVhFSDFGeVR6Q0dLL0NmbG9CYmFuT3ZRYW1o?=
 =?utf-8?B?OGNveFJwR2w0YW9PZ3IrOGRhZ01Rd0IzN1hqb1Ewbk1uMG15YXN0TUlVT3Yx?=
 =?utf-8?B?azgzMkc2UW1oMElVcWZFSXBmWHZydzVXOFVwSTI1WmVmKzFTaHVESFRDb0Iw?=
 =?utf-8?B?Q2hDMStFcTRFLzhrK0pwb3hKRnV2VUtLNU5lTWljWjBRd1VtMit5R3kvVlFa?=
 =?utf-8?B?UnJ5VHoxdCtqdHoyR2tZQ3pDTG90T2RIL3IzNG1FdkUxQ3VCVFFUdWxjLzNL?=
 =?utf-8?B?ejZ0VmExekFGRk8yZzlPK2YvSjA4R0VPNFZCT09XUGZWS1dRVnpRUXVQTU9q?=
 =?utf-8?B?dW9nMFZCbERBU0Qvd29EVWRQQW5Jb2pDOUR4SS9salE2NnBUMzJSQnFabHVp?=
 =?utf-8?B?TjJjTWh0aDNFcVhEMExNVmF4eEc3SkxCdkZXU2xxM0RhbGFkaUhRUGMxVnpR?=
 =?utf-8?B?VmtlTjAyaFJwSWJYc01hQUNTeEYreDJ1MVd5VVlBSnVQTTFDQm1jTFdDUmlq?=
 =?utf-8?B?eC9lTzlpYm81cFdaWGFUeE1JU2R3V0tEakVoeXZCUXhSSzN6L1RlanhHdGRJ?=
 =?utf-8?B?Ry8zSERDSG9ScjNtdnFibjZ1OVhUcTZUTHplSEZLdVV2SVJ5TXZwVG94d0JR?=
 =?utf-8?B?WXFuYXFMczV1UmQ0RTdVVWlhcDdreFV0R0FZcm5ZRHZIMlN4UVVtNjBxZFpj?=
 =?utf-8?B?d0pIRW5sb29RZVpBaUp5QlpaTFVEQ0NWY05rQXVBb1lpTFZGc0YzOHFIZXlD?=
 =?utf-8?Q?Hsz8uvWBT/I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VTQTZQVE1OdEpqVHlkT1E3L043SzFxNVFjeGFJOUpkR3NBTmYyME5CV0VE?=
 =?utf-8?B?QW1QWWZVaXEwaU9hSTN6WmJodlN1aWhQTWkvaGtaQzdGZGpmUStVN1pDaXNF?=
 =?utf-8?B?Q3RGeE1zRU4wb3diQUw1eGRaQnhHUXNZWXRDaWNJS2V0dWQ4N0FGZDRpQ2lV?=
 =?utf-8?B?VkR1czM3ZzlnSFFoVFNnZlk4VEdwNGhEbWVuYnpsSVRjaEFiazliZms2SWdU?=
 =?utf-8?B?b2M5ZEhPMU9vQlk4Y1FlcU5Ta28rdUp2MkMrMG5IZXJCM3RvekFkQjQyR3NQ?=
 =?utf-8?B?RXp3Qm5GRnFLeUJtWU5JUnRxYUQ0N1JmT0tpbWNtYmlvaVVGUWYybUFxWlRH?=
 =?utf-8?B?L2NFNUtXNG44L2FoQSt3QkRuYm02U3FYdGJFa1NRNWdoNzVKVVVxQzByMkx6?=
 =?utf-8?B?ZjJCbGtzQzRJYmQ4aEtQTGlFWmdLbVZuTWJFR05LY0htLzJvR1A1KzRla0ky?=
 =?utf-8?B?aTJMU0RNTzZUQ0RtU2RNMlFzL0RKcjlDZkkrTFhmR0JXRUt5dHMxa2pHTlhX?=
 =?utf-8?B?ZldDQno5WW9IRVYySXVMYkoxcmE0dEd5NFBrTnNvRzMrMWJBQnB6WFFPbVZG?=
 =?utf-8?B?dGhsOHNyT0xpZFBiOVU3Q3diaGR6eUpOa1Q1Wjg1U0hUbklRVVUyUktQUVpT?=
 =?utf-8?B?MUxWbTl3b0FnMXB6MmFVdytDOVl3NjRLdHhFWDk2OTRhN1NqTVhSUkFGa1JE?=
 =?utf-8?B?dEV6L2lybmxsQlpsVDdHd3ZYMXB2U3FmTDE3Slhxd0owYjVqeHViaThqUEl4?=
 =?utf-8?B?aXQ1a2FpeHhySzJmQ09LcDNNUHdFRVdKUjdLWVdwVm1KUE5SSHN4aE5jbGZY?=
 =?utf-8?B?eDNYR2RhSytEM2RwZVFqN0t2d0UzMTdPeVN3V0l1QnlNQk84TGZkYW9Xa3Ar?=
 =?utf-8?B?eFh1UWh2eXpxL01CNUZWNm1LVllOc0Yya2tpazFnb1lwUm40eCtWQnVqWGc3?=
 =?utf-8?B?NUd4bDFCdElGbmNOREJrUmZkTHd6N0x3UXkyRS8vSUFGSHpySzdiWVowbStN?=
 =?utf-8?B?dVAwVFJzRUdtUEVFWC9SZ05WK1JtZEJpVDlSR2RrWmdHUldDcHZtTFRTMHJN?=
 =?utf-8?B?RFpDQ1o5YWZsRTZIbnBPaUZBNmh0dkFEZnZlTndUV0dBbGpjaUd5OGtlQlBu?=
 =?utf-8?B?ZlBIS0xuelorT0lFeXZWTkNmZDBLVEQ2RGk1b1pUZjZ3dXdXRkcvSVpTdzdJ?=
 =?utf-8?B?Vjh1V00xOEY5c1BaWlg3V254M3RpT0JteHA5dUJBWGJ1NnFqQUs0WXJ0SytO?=
 =?utf-8?B?aGlMQlQ0RXVnVEJ4VUhLZWlLTVJqSzVvNnRhNGliNm1wdk1jQjExTlFVUUJE?=
 =?utf-8?B?MWlGQjc3MVhObllBbkRGbXAxaHMvZmpnR0xuelhLdjdkODBsK1l1TysxL09s?=
 =?utf-8?B?NmUyTFV4b21XVVRmT0U2d1NibmtoSEx1cFFkcHhqblhZTnZwQnA4ZThCcEh3?=
 =?utf-8?B?WEI1Q2pScmZMWTUvcUJSSW00alpLVnBTTUliTHR5UW8rZS80dWo2VUY0RVE4?=
 =?utf-8?B?a1dyblBmeEZ0cVl1TnRINCsvT1I5akhnNWhIQlNvcTgyaXJMWUowcmJjZ3Rt?=
 =?utf-8?B?ZkQzcnJTbGlHbmpuRmd3OE1IZ0xKVVVNSGt4eDlKeGoxOHlBMzJhQlAzOXRv?=
 =?utf-8?B?OEJodm9MT2JWbDR3L3djb2s3MDNidEpRZy8xbWNQL1lzL1JVUWZpZzExSTVK?=
 =?utf-8?B?T3ltaGZsZFRCTUhYdjBrUHFFajBVNENLUnhKcHgrRk9jQjdrVTB0QzRmZitM?=
 =?utf-8?B?M1FuM2xoYnh1dnNKalBPd1ZxM3FWcWZEQWN2M0orK3RwaHc4TndheDFLQk1w?=
 =?utf-8?B?RlY5c2dONzQwSVJjYUl2VjJmL3JyeDdaZllFS3FqZlFJZ0ozSFVENDU3R2Zw?=
 =?utf-8?B?Wkp2d1pqN1VSVXBMcTBoaU5PRWxldkZOdnd3Sm1XYVlGODNmaUM2c081M25h?=
 =?utf-8?B?dzhwdk5LOFE4YTJLSFlvRGRnTDV2TVFPYzdwRnY3bU1Gem12a1plQ0hPRGdU?=
 =?utf-8?B?bUtYV1BTUUN0anMxZmNQN05YUHlsa1R5b0FqN3JiemVYdnR5N3ZscS9BUXpS?=
 =?utf-8?B?aDNtdmRKWlhqeXdaL0tJbXowbkNsL1NwV3FnWEhGZjF2djdyR1VLb2JsUm9G?=
 =?utf-8?Q?r6zIbjOY9eX0ahBQ331pV2jnE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fdc3ba-0dfa-4f8c-e457-08dda3d514f1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 02:02:53.3100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i62tUbJkueUhO9coCj5ZnyWgyzDicvASIW+YeVOA6NGAQsG7Jo4ZoSmNbLuur1y+Lz4UsKfUOyHflyLKZxHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
Received-SPF: permerror client-ip=2a01:111:f403:2415::60f;
 envelope-from=nathanc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/2/2025 8:41 AM, Shameer Kolothum wrote:
> This patch series introduces support for a user-creatable SMMUv3 device
> (-device arm-smmuv3) in QEMU.

Tested-by: Nathan Chen <nathanc@nvidia.com>

I am able to create 16 SMMUv3 devices in a qemu VM with emulated devices 
properly associated with the guest SMMUs in guest sysfs - verified with 
some guest SMMUs having two or three emulated NICs assigned to them 
while other guest SMMUs have a minimum of one assigned.

Thanks,
Nathan

