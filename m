Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0892C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 01:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wygGE-00087S-Pf; Mon, 24 Aug 2026 21:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygGA-000871-3F; Mon, 24 Aug 2026 21:47:30 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wygG8-000245-Ao; Mon, 24 Aug 2026 21:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6185iL320lKAeq/oT2wksexzpcsahIJVh1nDoQyrE7c5nCDu7aQsbHIXW11KQLFkfdF5SQxrmg49n9GAkmA0JIIUbrI3681vYukDMR75sFn3qhuLCiBVdYgsSzgfSieF6N8Y4keLHK3hLreR2HruHE/u/sEap8Xxy9z/8K7HnWfIqTOViBZWLDGyqS0rdx42yQvxWGtTzRPWGtoV85MANGieskCmauOPtVd0k3EPhgODWZTqv3+2RHUgZ9c9OGwAPs/qNXcRpPcr41gCsyGcmyrcrQw2jT3EWZghty6AxFu7r8ENPYWWc369Q3l3QMqBx5YJfRL3PD0+L8SN0vhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG8bjFgk6g2Jy735tsWyg6hhJCwErBDayrncIsoglBo=;
 b=qe/wW0mdocc+nU4mV3SF/auwPoJw00s2RSf/C0ciGAhzuGF2ZGBrB0Q8v62o/l2KjsE/0NrqT0TD5CXgGQL64oJaBDXSuhOmYnsvBgG9m8B9PeKCfe+V8YF/EtzLvREmjLBzospEXYanuJgCrz1cJ28enm4YW6nOuOho/0/XCpNP7YImckxGEV47gFAHvZBBxWKQ8RknvucK4kUi61gWZrppszeidoMgcMWnBn1hpzKO9ntA+GP4bA9FNufIjarmSvaBMvDiw8MLPEfycQhmoSrb+IxsaAokVjmNlivZVjDEk+XyUtmXHATFCQipadOP8knReymMIgW200D9yMPBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG8bjFgk6g2Jy735tsWyg6hhJCwErBDayrncIsoglBo=;
 b=pZ4dLWkYrzoCHVAWd2zO6ZDVEppm7XCZ/MvQnFJzT+gLgwFFzfl56ontVLS0/7fOilN2iYXcyDVuYw7tlvMXGqJcMHY9UjSRN+XqtuMk3/22SSWpP5aN4aVrxLjsyEQQdM57xih44vwLYfGZh620kjPe1LQkJ0nx+piMJwPhjmGj6/Ic9aiSAZ56cKFHAFg0K5uP5uFD+1gNsykSNxQixdkwFBTDuSh6VFcI3hQTu/1wzguuGmcjI8OfZcW6oMem6PQePGPd0G+hoJ4348cNqvqFkRGdB7BJU2VmMoyE0UYKcybG/nSosNuIpsVFZBxpr8RecgG26XfEfZB6O1F/UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by PH8PR18MB5265.namprd18.prod.outlook.com (2603:10b6:510:25c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 01:47:23 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 01:47:22 +0000
Message-ID: <d7709c43-52bf-41f7-a4dc-981fb8323b0f@axiado.com>
Date: Tue, 25 Aug 2026 09:47:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/arm/ax3000-soc: Add missing class_size to
 TypeInfo
To: Jack Wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260824030505.1969726-4-kchiu@axiado.com>
 <118138DB-16FF-4F7C-8E75-92976E21A71B@gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <118138DB-16FF-4F7C-8E75-92976E21A71B@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::11) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|PH8PR18MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: fade93a6-82fb-4df8-caec-08df024ace8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: gkmk1OK5nPtr+/n3o5gJ3QTlRVjSTX82mAH/qiDw3ffnSXP/f2smSgleulBjuCI+4MW8HWxx3Bx66gQvuoZBNv7oRBRykSEZttTuy3RIUqkcthLZZVQPCGKsIkho7Hj7eCDjr2NBK3IZf/OsACG/FaCk1XswtB2rZdU7Cc+uWaTnPPC6Bn2oTJSp8YYD4idpsE8hnfvh+0xrAErotXitAxajg6oCWN4setaFKb3ykm1TfnOGy5Hxuf4BoZVpP5rhcjYWrx+QLKFVIR6Zt+oJjr3M7pwiXahJ/NSSzSoXVSiu1ZMAASwMbZmc3C8fHHK19/skJyGgKg0VJpr45lDuX5mPyEO3xU4E4YDKsUJuW0zf7DUbO43+pa6RfQYCJst4DCpafqDS4tP8qLfGJv8V0nN1Xy8uVQIIbYq6sgAjRWu/aY7yywFcXk5hzYjUQAcqhcpRnyCAQEfVOgjG8+koWOYtRXURbPLGQjetK+30UAjIoB3GrwIhLzzSZVyslOkamcT+ox57RSXxUvR8LxSkyarxuRTvpeGo9u36xl1sdk+nEoLm5SEC0UrfaDOGx5MGpzSjE738x8diagqe4oyXBmmD4bjKyFGpo7QnoER2298CO8GCEivc84Am+nrQGHuSGteyEglue7YhBcksbS3QP+7y9RXiLyyE3VTLrfCfMaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnpLM0UxMkJRS2hHdFhGZndzL2tOZ21sNnpTNVRoMDVsRVZtbW5tNXRxYVVM?=
 =?utf-8?B?WVhXaldCOU44NXFvUGhOaVlkcUxUK0dkc29lL1ViV0I1S3B3N0ttVi9RY0VM?=
 =?utf-8?B?SXhvK0N0N0hKcXM1KzFzZ2pObWMrckFQTEp1WVZhdVZyUVoxdW9SeXJva3Vk?=
 =?utf-8?B?a1IyY2ZkVHk0NDNhWVJNY05VRnZNcHVyVUFMNnUxdzE1VW82YXp0cG5WSnlG?=
 =?utf-8?B?ekdjNFhYYWhWU05CZ2o3cCtEdTBuSVdjMkZBN096enpRR2MrRDlwOVlWbFdO?=
 =?utf-8?B?YUFSblBxcDduNVM5TWJIaVRIR0J1cnBLSzR3dUpVbTNNYmtHZHIrTVVVa2ZX?=
 =?utf-8?B?dlhybExKZTVZSFBMalhKUWgyZUVuM2xZSnJTZ0d6VVhMZko4U1pObHNyZlFD?=
 =?utf-8?B?czEwUFJZaTZLQWNGV285ZW9pMTh5aHRpbWtHcm1FaVhrRkc3LzdJek5ZVW54?=
 =?utf-8?B?M2hESzVwb1RXTXZlcGtLMnI4Y0xPRGdyOEZjTFIrcFJ1QWwzbThheFBQVlNH?=
 =?utf-8?B?cFJvaGJzbldpRGdHSjlqdkdCUVFHVUYxSXhvdW5YRWUzaWlxaVREZEVwU1Rw?=
 =?utf-8?B?eHlvUEtZcTJoVUJkTEMvR3hGVDQyQldSdW4vVlNsRk54U3pjcjMyR3lqOFBH?=
 =?utf-8?B?YzBrN3ZwL0dHZWgwbnRvUEpVMjdkYUhZeUxnNk1haHZFeGZVeXlMLy9xL0Z4?=
 =?utf-8?B?UXZ1RnhTd3RSaUd5ZU1HVEdiOEF4aEZQSlhVVElWU1UwUTZWamoyU3RsUnZh?=
 =?utf-8?B?dmZDUWZkZzkxa2tmOVpIRDMvQmtJRmRkYTN6U0ZHTEdWak9KaVRVcktuRGtO?=
 =?utf-8?B?Z1hDMUFhR21EdXhiZlM2WlN3VXFZYUxQZGtueHh1UnNqcDBnNDIrbEZ5MHV6?=
 =?utf-8?B?cEFtTktidWxLT21Hc0lzRUNGS3dIbmNQZVRsRS9SNjJKbDF2MDlFSCtBcTFB?=
 =?utf-8?B?Y1RBUnpTUmN5VXVJS2d6empSdnlmZGd1Q3VpdVErY090UUlQdU5ReXBLV0dj?=
 =?utf-8?B?VUVtaHRybDAwQW5rNFR1VW5lQTFqY0Z6TjY5blprdGZWQm1HSHo3WmwwdmNj?=
 =?utf-8?B?dThuanpoMnpXNkJ1eXE4cVp5aVlseE1WREFXc1ZLYjEwSXY2WU1DRmJrWUpQ?=
 =?utf-8?B?cDcybzNxdkNIVXRWV3ZqY1dMdWlaazFjWFMyNVN3NWRDcy95eGdNQ1FLZFBk?=
 =?utf-8?B?S0RsQ2I4aUdPdVpuRThWOVRMRU9jRVp6TjhvWUErSmdkaVhyNHo1b1BFTWxy?=
 =?utf-8?B?a2xhcTZJb3l3SGJUN243V3R4VnhSYko4STlhVkozUDl0S0srRW9sUDMwNHl4?=
 =?utf-8?B?R1ArWlhSVys5NmhsTCtYVlpWU3k3dVpTakt0a2hZSmtuK2dDMjQ1TnRVUzlp?=
 =?utf-8?B?dTN5My9ka3c4OUxnZmhIa3dmQ3dQSDJQZmZxUk12NFdJZ05DRmZTcVRNL1Z4?=
 =?utf-8?B?V2VKQ2htY1VDelRHK0kyTWg1LzRELzdYUTU4OTY0QjVqSlNHNWpiWGhmZldG?=
 =?utf-8?B?cUFadkVheVM3WTBJeDhlWXRzMU5jVUQvT3BJYVpFdnpuWC9wcFp1dHlqUmxQ?=
 =?utf-8?B?UkZmdkZLUjJIN0h1RFIyQkNQa211NkNkSUZxaGZkOWk5Q1RtbWorZ2NvZm56?=
 =?utf-8?B?UkFnQTBWd0hwTmRXWTd1ZDN2Ukh0bHkyQ2VjM1ZlTzJyOVpnbzRlajR6aXZs?=
 =?utf-8?B?VVE3bzg2WGxISVFzaW1RS3Nqb0lrU25YOS9iZjA1TEdKVXhPY0txcForSFpF?=
 =?utf-8?B?TjY1dG1ieFFVSmN0emNoOFBKQWZsbEY5VlRteEs2R2Zoc0RSNzhVV0MrTWxr?=
 =?utf-8?B?Smp5OGk4NnZ4cE9Jbyt6NDRQRnltU3pjTExSb1pQZTkzQXlreUVvUVJMRE5Q?=
 =?utf-8?B?WC9UUGpXZUxZOUVHNk1CbTFLUXAzamVZSjlWcWFCZ3F1a0JYa1pOL1NxOWFZ?=
 =?utf-8?B?OWZLZjFxOVRjT0lHT1AvZzdvSzZDTVhzM1VlMnhlTUVaNDdrRVdYWHpoQ2d6?=
 =?utf-8?B?ZUdyeFMwU2pmNGRDbXBSelBoRENVK2wwdDV4VHlRcTNKMGxMenBBK3o1Z3Rh?=
 =?utf-8?B?R2VPUWNDNGFZWjM1eGdoS3NaQ1Z5NCtXQXR0MFBLVVpGWHJ4ZE80aC9kWWRs?=
 =?utf-8?B?ZUNTL3BYY3EwWDh2cURBaVFTRENqTWdROTlGTU5SOTF2SzlCeW0rR1VJVEZB?=
 =?utf-8?B?emM5bkJESHhRZm0vWEZhQmFjQkEzeTU5YU1uRnpjTE9SOU1jQlowbTBoMlNU?=
 =?utf-8?B?ZDNCc0JlMlJTdnFnK01XMFBDbGVvQUpXUWJHV2loeXR6djVVcTU4dGFYaGxV?=
 =?utf-8?B?VHdFWjB0SDk3WWNLbnA4Y0VhWXFzWUFRdjdFallFTno1ZTZnT1BFZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fade93a6-82fb-4df8-caec-08df024ace8a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 01:47:22.8179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck2F99vZrdP+Q00rSfFeiXvW+1DyjQQccFRR+xBVHP3OLsGZ8CTuR2GL03P/tRdVq3NYRvAghSbGfbpd9XxfpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5265
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Jack

No problem, I will drop my redundant patch then submit v3 patch set

B.R.

Howard

Jack Wang 於 2026/8/24 下午 08:18 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Hi Kuan-Jui
>
> Sorry again for ambiguity in my previous message.Before I only found problem in ax3005.  After applying the series to my local checkout and in my local it look like
>
>   .instance_init = ax3000_init,
>   .class_size = sizeof(Ax3000SoCClass),
>   .class_init = ax3000_class_init,
>   .class_size = sizeof(Ax3000SoCClass),
>
> The missing `class_size` issue for AX3000 appears to have already been fixed upstream by the following patch: in https://lore.kernel.org/qemu-devel/20260821110101.3971391-16-peter.maydell@linaro.org/ in could confirm it
>
> Best regards : )
> Jack Wang
>
>> static const TypeInfo axiado_soc_types[] = {
>>          .parent         = TYPE_SYS_BUS_DEVICE,
>>          .instance_size  = sizeof(Ax3000SoCState),
>>          .instance_init  = ax3000_init,
>> +        .class_size     = sizeof(Ax3000SoCClass),
>>          .class_init     = ax3000_class_init,
>>      }
>> };

