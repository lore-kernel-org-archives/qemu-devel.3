Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A20CA101A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 21:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk8lw-0002Du-7Q; Fri, 30 Aug 2024 17:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rebecca@os.amperecomputing.com>)
 id 1sk6W2-0002cd-Ge
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:38:34 -0400
Received: from mail-northcentralusazon11020098.outbound.protection.outlook.com
 ([52.101.193.98] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rebecca@os.amperecomputing.com>)
 id 1sk6Vz-0001CQ-1F
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kozZcm2uXb3vld4P5OnzYCCGNX316DOv456vW1F+vJcBe/ZAynTNj2S1tAXf2WqisL+mCAdaPSVo492hbShdC8PEtWOAj5Y+M6ZJ3NWcwBnuSdR3fFOJtR1ePyqXxytlJkmbzQBn6Qiepyi9p+uAkmUN0ytJGLbzbSBw9pSNADM7fLsvlHSOyG/20tzSvEEk+2aiCtABAnt4mpcLMtB13eaa0t+AIpSUz8GAa8BEJCX/5rjAvMaBJn+aB3sagYVS9YWLceJeNuD3srzba0I3l/Llm1tP91anRAgOvOj4wPJHeNaTCkn0gW9ZMtby0KfkvH/g3cyp4ALHTavJqN3PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkB2gRdOWidEt5tA+cFax05bB6cIcIu0VeipyX5+y18=;
 b=j1nHTlmTxxeg3Wa8Hs0RyHh8VNko4oDyYtTl2WylbOUiS6XcIHN0GxKHBIcpleYTbfwAA/nIt/ZxGPDzpbrfFvRNvPActzbJ7cNoyzI/y45sROR2X+tfYuqhJrXnk9jmbKs78RWzY9eLco4lYe9fJhdYy2RfP1eqGJuI4ge2Qklc71R4JigDe/ey4QjrXeb7OQ4woz2i48vpLWF8N8Quoqv5IMZHeA3kyhk2IyDcDSU3lPKwgf8p7f4WbmMjijEPktVf5bn1KgvkZAWYIOLLkHx1oC7QKpk5bgt8bfYbRQtqinKIFW+47hEHGYpkSAoGIM/6aR3o+J4I1nna7RV7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkB2gRdOWidEt5tA+cFax05bB6cIcIu0VeipyX5+y18=;
 b=YQC44d0NtRaD52d2qiVnnBTLfv//kGmorsqOOZ7IRD+w5ZNG/BN+T6RjJj2FKNtDefZ528Au4qVQq4l+y6oEyQIbxis5pEMOp13YbcQk8MSqa/slPOTWB/H1EoUnof+/ZeSlBoTJdRu3p58UMyqwW6key9xym5DRMZwNUI+W3lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV3PR01MB8464.prod.exchangelabs.com (2603:10b6:408:1a3::7) by
 CYYPR01MB8611.prod.exchangelabs.com (2603:10b6:930:bc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Fri, 30 Aug 2024 18:33:23 +0000
Received: from LV3PR01MB8464.prod.exchangelabs.com
 ([fe80::74dd:8ddd:b9c2:8d2d]) by LV3PR01MB8464.prod.exchangelabs.com
 ([fe80::74dd:8ddd:b9c2:8d2d%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 18:33:23 +0000
Message-ID: <b985d2e1-5b97-45d7-93db-53e3253672b4@os.amperecomputing.com>
Date: Fri, 30 Aug 2024 12:33:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [edk2-devel] [RFC PATCH 1/1] MdePkg/IndustryStandard: add
 definitions for ACPI 6.4 CEDT
To: devel@edk2.groups.io, michael.d.kinney@intel.com,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
 "gaoliming@byosoft.com.cn" <gaoliming@byosoft.com.cn>,
 "ardb+tianocore@kernel.org" <ardb+tianocore@kernel.org>,
 "chenbaozi@phytium.com.cn" <chenbaozi@phytium.com.cn>,
 "wangyinfeng@phytium.com.cn" <wangyinfeng@phytium.com.cn>,
 "shuyiqi@phytium.com.cn" <shuyiqi@phytium.com.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240830021117.538954-1-wangyuquan1236@phytium.com.cn>
 <20240830021117.538954-2-wangyuquan1236@phytium.com.cn>
 <20240830121646.0000729a@Huawei.com>
 <CO1PR11MB49291F248F08F89124086C8AD2972@CO1PR11MB4929.namprd11.prod.outlook.com>
Content-Language: en-US
From: Rebecca Cran <rebecca@os.amperecomputing.com>
In-Reply-To: <CO1PR11MB49291F248F08F89124086C8AD2972@CO1PR11MB4929.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To LV3PR01MB8464.prod.exchangelabs.com
 (2603:10b6:408:1a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR01MB8464:EE_|CYYPR01MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2b0a98-576a-458d-8ff8-08dcc9223a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|4022899009|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFowMlNaOTd2UnRKa0QraFhPQ05vL2w5cTkvcmJ0WXdlYlNiMWw0ZEV5OFps?=
 =?utf-8?B?OE90WElFeG9BRWRsbkNKcFNKWDFzb2s3YmtlZXNMbjZjc2c4bXFJaE0zSWo1?=
 =?utf-8?B?QzdMd1dmQm5XM2U4Q3h0ZU5tYjJTRWZUeW9mdWJDQ3BveERtWUgwMitQaTRC?=
 =?utf-8?B?SXJxT3FnU3prOENUNEwxRUxOaWlEQkU5ZndseGxCTnkySDA0QnVMUzRMSVJy?=
 =?utf-8?B?SmZXSWhFMDhQQklMRUQwVUkyc2tLOWw0L09XUm95eGVzRmMreHBkQWZEelBH?=
 =?utf-8?B?KytRajJHU1dzai9sT2k2TTFmZkhlMWk0TjZEenYyMlBveEdyMzQ0TG91OW9P?=
 =?utf-8?B?dktRNjI0TzlBb2FQNnpNaUpnQzRxTnVtaFlmRzFZTGNTSXhzV2tNTUxFN2lG?=
 =?utf-8?B?cG0xdnBsSTJ1MXQrem5HMlp6QmExS3ZZazdyWU1wL0pOa2xYK3RjTTZ6b3I2?=
 =?utf-8?B?T3dvZ29LaTIrRDIvd2dqcExvbWhBM2hTRGM4aXFCQUJlVlEwV0ppejRqbmh3?=
 =?utf-8?B?MlhVS0NnYnByTm5uZVpWUklCTzA5TTJ1c2dTSzJiUVdteHlvcGNnei9QTlhy?=
 =?utf-8?B?eFZUVzNxM1hTbmhNd0Z0WlJreDBPeGx4RDRtWlRZNzl6QjZ4dWc5NXEwNHJY?=
 =?utf-8?B?Zk1ENy9ra25COGZqcWhnSXduUDRwbFNrdGJrZUh4Z3lBV3hxUkFVZGk5TVkz?=
 =?utf-8?B?K04wUk5MN1RKaDRNSnVXSXNJaC9Cb203REdBQXYvNTJzaDNpeUFqTXN2YS9G?=
 =?utf-8?B?TzRzdDJQTlptOHIwUXp6YmhIWnZoTkVma05wOVRHTUFUTUpvOFdxWUo3ZSs1?=
 =?utf-8?B?b1hRaitOeXRqNEZsQko1c1V5Zzd3cXVMek81amZxS3JmOHF5bkQ5bFlhOTRP?=
 =?utf-8?B?dmQrbUx0dlorMmJuajQvUC85Uy9obDI1UlZGOEthOUdLMDlHWktvS3E4UGNa?=
 =?utf-8?B?WXRwY1lnekVkakg3MGR0c3NsSDJpM2ovakhYMFFhVjdRNnZPUml6MUM5OVFO?=
 =?utf-8?B?T2h3czhiajdPaW5aWlp5bGdaY3RMODY2NS8rdUV4eEVoZ3VKNVpyeDhQdStz?=
 =?utf-8?B?TlRoZGRGUHIxUi96ZllLMDBibVRIN2RKWEdXQ09xT3dIQzU0ZW5GMEwxaGU5?=
 =?utf-8?B?SzVaNlI5MUxFd0xkMnpOaC9lZUIzbmFFYTJyVXAvNnVCUENkVGs0bmIya0Jl?=
 =?utf-8?B?NlU0cWFNYWh1UUltYkNzeEZHZXZqWUQ1MktzeXZrd1JvdklzTURvdEQweStB?=
 =?utf-8?B?b2c2a2NoYTl0bnQ3R3pYVEZrcnVmMjkzTWtpVStURldiNWFDK2U5NEd2Sm1u?=
 =?utf-8?B?amJwb2JyTlhjSEg1RWdHbS80TXEvZSswRmczT3lDL3VQTnVDV1pIK3dqWkg1?=
 =?utf-8?B?REVUdWtLanphZTN1MGxlOUdGdWZwa3NpU01uRmE1bXFKdEtkRWkrNDlCOXRL?=
 =?utf-8?B?WHM3WEtBUUN6MnBreVF3VmQzaDFweTYrdlppeE5sSW5hb3Z1OFhLWU9GanNV?=
 =?utf-8?B?RURIN3lRRHJCUkdRcWNWRDlRNFRiNVJPcWJiS2lVWXBNOHJzamdLbExubVhO?=
 =?utf-8?B?VzB2M2FCT2kvajA3SVhYRTZHdElUaFdtU1YwM3kzdGFkWkgvRE1RSi80YWRo?=
 =?utf-8?B?T3ZBeGJtMlk1RGhLNlYxekM1dGlqYUt4MXZNdldkNkRGUVp1V3JYdXJmZGxZ?=
 =?utf-8?B?MWhETHF4RTVPcUNibDEvb0JCMU9HVWhveHBxU2x5T2NKOW02RVVzK096MVhX?=
 =?utf-8?Q?3LmuMFRJsJl/1YoQIQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR01MB8464.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(4022899009)(7416014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVF2dURjL3lldXFpTXptTmUyd3R5VEZVOGY0blhsU0RmcEY0RmJ3WUtNQkF2?=
 =?utf-8?B?WHlkclBSUXk0ajU4Vk9IK29Hbi90TVR3aThRVStkY1V4QmhFT3NXV1FTUnlF?=
 =?utf-8?B?T3JFWkVXci9HTUJIRk1FQzQ0TVJaVGFNVHVJcGhFNGJSNHI0SUZjSnFtVDBk?=
 =?utf-8?B?NHZ4UmFBRmZZaWZaU3o1cU1rNFovTkhZS3pwSTZiQUg4QWtyaGxWVEY5VnB6?=
 =?utf-8?B?ZGhQbllTSi9JYllWWXlqeDhkei9DQ1hGM2FxZjB3V1hpZ0RFTkV2REd2bmtt?=
 =?utf-8?B?cnE0N05taGVydDFDKytFRVhjMGFmL21IUWo3UnlmZkpwckVsMXg1WDlMZ0tX?=
 =?utf-8?B?WFdXaE91QkdqVXJFV2txb3lqUGJIbmFwZldUTFVQZ3VHVlhQVWUwTWc5czlQ?=
 =?utf-8?B?YXR6MzdQTThSeEhNSnBrNjR6YUpScEJqNDNQcWJBMmZJcXgxakIyOVBPOXQ3?=
 =?utf-8?B?TDRZeTRjL1lsOHZSbWFLQ2psc0oxUWxPRDQ3cXA2aUNISHFnK1k5bFNKM3Zx?=
 =?utf-8?B?N2xYQnVVM0lOQmJTZ2hYc2tFOWdhNlNPTFgwcWR4VjgybG1UbmNNSEZIRjdy?=
 =?utf-8?B?RWVoaVRuNnNLbm9sL3NIUldKdXhaWHBMMWREZ01mUko3YnhEZXowYVJoQysy?=
 =?utf-8?B?V1htdGFJQmpZdmZSaXRGSURPU1FhM0x6OFVxS1J2ZnFCOWdyUWtQbDNTTUdO?=
 =?utf-8?B?R2hoNUExUkMwcTlUS294MURTLzg1NU9BUjRETWRSTWx3SXJ6d01ScXN5MkNX?=
 =?utf-8?B?Q1ExaUsrOStMckVHNWxFZHJxbWdYWE9LOVJRang4RHpXWFAwRi82bGluNnpx?=
 =?utf-8?B?N2lJWUhUSVBxWlRnaWdUQVpxVTJJWjRWbmhEamU3ei9RTVRUVjlIdUx5MUxa?=
 =?utf-8?B?YkJ6Z2ZNbEx3UzJVdnhlbUhMY2dxdGtvUVJ3TFZlejV0N3dxY0lOM1NHS1Fr?=
 =?utf-8?B?NjZRUUFFbGhJL01iNDVjUG43Q2g3YVM3N2hsUjhwaHlMSys0c2hSTzFIRS9L?=
 =?utf-8?B?SFdNdG5YRlE2Mk1MajZkTzk3QkswOU5aazhzT29DblUrR0E4ZmhRdWRJTGdG?=
 =?utf-8?B?ZGxUL3p1MFhlQkJyemNXaHQ1djRwRS82a3h4bFFRYkJaeFNaZGVWY0FrMmEr?=
 =?utf-8?B?NmFiMmZhRVdUYzFjQmpvZ1V5ZWpQOHdMLzhURUhmQlJyTWtTc2x2N24yaHhn?=
 =?utf-8?B?NTRpN1JhNDJmazhtTExhK3VhNVRkUnR4VGtjZjZrdThYcUUzMjJNUUlOUkhK?=
 =?utf-8?B?Q2JFRkR1SGJQODJ6WTdoRUswZCtwZ2ZLVjV3RVpKbE9RMjAybGFkeFcrNjRQ?=
 =?utf-8?B?OGgvN1pKbE5mQWRtUWYrNDlJNWhrVUUwakJJY29QYlA2REZiT2hRQktBbVpD?=
 =?utf-8?B?Z0FVQkZ2Nzl0NUM0M0JGd1RXMGpGQXViV1dFMGNYVjJPNHlzNVFCRkxKMU9Y?=
 =?utf-8?B?ZnhlaWE5RHAxMy9pV0NUZHJCZHhtZE9Nak82TVlJNEQ5T3BvajBDVkFrVEU4?=
 =?utf-8?B?V2RMOWRkZkc0QXhrMjhHU1hNRTBOZUp5VElJMlBPYUtycEkrM21SbFhjeVht?=
 =?utf-8?B?b1U4RnM3VXlSekVraVl5bmJydUE5U1dHZG1LN3g2ZmZ0V0JmUHYxVU1EY2Y0?=
 =?utf-8?B?Z3BXdTc0a2UzVDE5YjRXeWgwcTVOaGhkUnJkL1hXSllCZVcwSFM4WkpBQWJw?=
 =?utf-8?B?UjJrTDJpS2t4blZMNmcrb1NjQlFlM1kxMHJPZU54cStzTkY1L0pEeXpvM1FS?=
 =?utf-8?B?RTZqNzQ3Nkw5dE1lRDNqUFBkdFJCR2RETTdtMW1NWXM2cURWaHcyOWNHaklO?=
 =?utf-8?B?ZVpzQkE4L09Kb3pOaXdKQzk1WGdxL3BlbSsyZS9DWkVmbWtCZVovTHNCQlp3?=
 =?utf-8?B?b1dBNjRzS0p1SjB2WGtvQVltTk12a1MyMWFqVUFQTFl2aTlxN3M1SGdXcjcy?=
 =?utf-8?B?ZS9ua3pUdzRzNVRFQWVGbjdrSVZxb0hzYTVBdjZJVldVL3lGRXZFU2lKNk5O?=
 =?utf-8?B?U2Nlc1pCNHJoT1Izd0tsdHVjNFp2SnlCTGFySmNxNXBaOVg0K2M1emk3ZDVn?=
 =?utf-8?B?Ni9ianFEZ3d4dWsrTElxVVVCcE9PbTdaZXB3a3g2SVo0MDJJZ0liOHNHcFhD?=
 =?utf-8?B?MEltZjhGKzVrUjFaVU1aU2lhZWl4MXJ5bG1HTHVUdjVlZTRrTU5qeVBUcjhI?=
 =?utf-8?Q?M0VpZzulrwPp/NXq5QjL3QU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2b0a98-576a-458d-8ff8-08dcc9223a93
X-MS-Exchange-CrossTenant-AuthSource: LV3PR01MB8464.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:33:22.9789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+rUaar6VWvxVDa/ECfvOTJkZVh+XKKmtrKKJf5WLQ9mNRCgwAwiVAF3HsTIsJ9D+OCS3Napp6ppVSM1TFqao+ElF9Xeq7hCdPrla5suAvXEqDQxyS8nQHF7wPm8J35g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8611
Received-SPF: pass client-ip=52.101.193.98;
 envelope-from=rebecca@os.amperecomputing.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Aug 2024 17:03:05 -0400
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

Also, leading underscores are supposed to be reserved for compiler 
implementations (and there only needs to be a single trailing 
underscore) so it should really be:


__CXL_Early_Discovery_TABLE_H__ -> CXL_EARLY_DISCOVERY_TABLE_H_

-- 
Rebecca


On 8/30/2024 12:06 PM, Michael D Kinney via groups.io wrote:
> For this MdePkg change to add an ACPI table type, do you mind opening a PR?
>
> There are some minor code style issues that need to be addressed.
>
> Structure type names and define names should be all upper case.
>
> 	__CXL_Early_Discovery_TABLE_H__ -> __CXL_EARLY_DISCOVERY_TABLE_H__
>
> File names should be camel case.
>
> 	CXLEarlyDiscoveryTable.h -> CxlEarlyDiscoveryTable.h
>
> Also, please provide links to the supporting public specifications in
> the include file headers.
>
> Thanks,
>
> Mike
>
>> -----Original Message-----
>> From: devel@edk2.groups.io <devel@edk2.groups.io> On Behalf Of Jonathan
>> Cameron via groups.io
>> Sent: Friday, August 30, 2024 4:17 AM
>> To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
>> Cc: marcin.juszkiewicz@linaro.org; gaoliming@byosoft.com.cn; Kinney,
>> Michael D <michael.d.kinney@intel.com>; ardb+tianocore@kernel.org;
>> chenbaozi@phytium.com.cn; wangyinfeng@phytium.com.cn;
>> shuyiqi@phytium.com.cn; qemu-devel@nongnu.org; devel@edk2.groups.io
>> Subject: Re: [edk2-devel] [RFC PATCH 1/1] MdePkg/IndustryStandard: add
>> definitions for ACPI 6.4 CEDT
>>
>> On Fri, 30 Aug 2024 10:11:17 +0800
>> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>> One request - when cross posting to multiple lists, it is useful to
>> add something to the patch title to make it clear what is EDK2, what
>> is QEMU etc.
>>
>> [RFC EDK2 PATCH 1/1]
>>
>> It might irritate the EDK2 folk but it is useful for everyone else
>> to figure out what they are looking at.
>>
>>> This adds #defines and struct typedefs for the various structure
>>> types in the ACPI 6.4 CXL Early Discovery Table (CEDT).
>> It's in the CXL spec, not ACPI spec so call out in this
>> patch description that all that was added in ACPI 6.4 was
>> the reservation of the ID.  The rest needs to refer to appropriate
>> CXL specifications.
>>
>> For naming I have no idea on the EDK2 Convention for
>> structures in specifications other than ACPI that are for
>> ACPI structures.  The current one is definitely missleading
>> however.
>>
>>
>>> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
>>> ---
>>>   MdePkg/Include/IndustryStandard/Acpi64.h      |  5 ++
>>>   .../IndustryStandard/CXLEarlyDiscoveryTable.h | 69
>> +++++++++++++++++++
>>>   2 files changed, 74 insertions(+)
>>>   create mode 100644
>> MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
>>> diff --git a/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
>> b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
>>> new file mode 100644
>>> index 0000000000..84f88dc737
>>> --- /dev/null
>>> +++ b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
>>> @@ -0,0 +1,69 @@
>>> +/** @file
>>> +  ACPI CXL Early Discovery Table (CEDT) definitions.
>>> +
>>> +  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
>>> +
>>> +**/
>>> +
>>> +#ifndef __CXL_Early_Discovery_TABLE_H__
>>> +#define __CXL_Early_Discovery_TABLE_H__
>>> +
>>> +#include <IndustryStandard/Acpi.h>
>>> +#include <IndustryStandard/Acpi64.h>
>>> +
>>> +#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01  0x1
>> //CXL2.0
>>> +#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_02  0x2
>> //CXL3.1
>>> +
>>> +#define EFI_ACPI_CEDT_TYPE_CHBS     0x0
>>> +#define EFI_ACPI_CEDT_TYPE_CFMWS    0x1
>> Sensible to add all defines from the start?
>> So CXIMS, RDPAS and CSDS
>> (only that last one was added in 3.1 / revision 2.0)
>>
>>
>>> +} EFI_ACPI_6_4_CEDT_Structure;
>>> +
>>> +///
>>> +/// Definition for CXL Host Bridge Structure
>>> +///
>>> +typedef struct {
>>> +  EFI_ACPI_6_4_CEDT_Structure    header;
>>> +  UINT32                         UID;
>>> +  UINT32                         CXLVersion;
>>> +  UINT32                         Reserved;
>>> +  UINT64                         Base;
>>> +  UINT64                         Length;
>>> +} EFI_ACPI_6_4_CXL_Host_Bridge_Structure;
>> Should this naming reflect where it's actually defined?
>> EFI_ACPI_CXL_3_1_CXL_Host_Bridge_Structure etc
>>
>>> +
>>> +///
>>> +/// Definition for CXL Fixed Memory Window Structure
>>> +///
>>> +typedef struct {
>>> +  EFI_ACPI_6_4_CEDT_Structure    header;
>>> +  UINT32                         Reserved;
>>> +  UINT64                         BaseHPA;
>>> +  UINT64                         WindowSize;
>>> +  UINT8                          InterleaveMembers;
>>> +  UINT8                          InterleaveArithmetic;
>>> +  UINT16                         Reserved1;
>>> +  UINT32                         Granularity;
>>> +  UINT16                         Restrictions;
>>> +  UINT16                         QtgId;
>>> +  UINT32                         FirstTarget;
>> Is this common for an EDK2 definition?  If it were kernel we'd
>> be using a [] to indicate this has variable number of elements.
>> I'm too lazy to check for EDK2 equivalents ;)
>>
>>> +} EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure;
>>> +
>>> +#pragma pack()
>>> +
>>> +#endif
>>
>>
>>
>>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#120453): https://edk2.groups.io/g/devel/message/120453
> Mute This Topic: https://groups.io/mt/108173030/8845205
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub [rebecca@os.amperecomputing.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

