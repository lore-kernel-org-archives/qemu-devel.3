Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4503CCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Wu4-00078X-3u; Tue, 30 Sep 2025 05:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v3Wu0-00077v-Vp
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:44:08 -0400
Received: from mail-northcentralusazon11010015.outbound.protection.outlook.com
 ([52.101.193.15] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v3Wtr-000399-SH
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:44:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLTscAHO6V+U4gSu0n+aCIU2Z61IGt2OgJtnNW4787rqexLOYf3yOeP3IcvY7UnNkFS5ZtWZrxGxNEzkMF6xYXav8+0DB/fa+hnag+fKu9hNjeTL9O2gC3/gdqK0Dy+JdlFJQDHOvmDAZWxvEuQ5k6HVKNEDw3EFRTtAjQNyQWDAceM/Q1w5pPxXiqIljjjMCwYDZNsviSx8JMNZjjwVO9gapzLULP3O07dlgtGKdDgScA60hab2NRDvShVJpneSZQFFRXwVFhMP9TiDRG3fdSzgt5IqFeWuI4juO4+St8BQPcq/zdNgUU3z0fsmYeDvGpwtaLT/O5bR/jEw/AR9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvf76MIB1mLFGSfrwV9ZND2EsWBiNTpAqgU6Ua88LXk=;
 b=Nt+TvYNDMgcjEnR1fX9nXZUqzYy1QUWL2hclotew20zkrCiQrIR099Yy/qOolFl4Ls9ZkLCL6mQuA0J8S7vzxbzzc9U3yrikTTpQ3SYg+zaXAtgRZRdVAxwclaI+1oNOv0kBIRJ4agxgSnUVfGVFAVtDGJVg1tofoBqKRfVX9nXTkFAaMypD8xCBH48/RDzYPp+dpQxbQQWC/LHKVOyYKlJeQ+iyjelDzKKZti1p16Qzu2EBUCQnLWfXSqSnHarpCT+RpC7WBQcd7DqwUEnseAqCiOMeVZFa8SSFRPblodmJZJTju/QcPU1vzKWxz/W3ApYlT7sJz+fQcR2puPo7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvf76MIB1mLFGSfrwV9ZND2EsWBiNTpAqgU6Ua88LXk=;
 b=WGH+mCmO7iGzsBAXJPSbGufoQlCwkKZgP4puASzs/y09fje3eA/fXvnZ4+LHOjsMqGtQhaLdiFlBDz+yMRA6DNz/MU3qoKmCRPnYMQb1OTGdRVjeUmxBdAiNsRV3+p+ipHsq3MBPBCSeT4ID/2EEc8veDV8sWydVrbhbiIuxvns=
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 09:38:47 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::2d) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Tue,
 30 Sep 2025 09:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 09:38:47 +0000
Received: from [10.143.206.15] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 02:38:43 -0700
Message-ID: <a008fc30-a7c3-4541-831d-961f453db2af@amd.com>
Date: Tue, 30 Sep 2025 15:08:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] hw/i386/amd_iommu: Fix MMIO register write tracing
Content-Language: en-US
To: <vsntk18@gmail.com>
CC: <Suravee.Suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <philmd@linaro.org>, <qemu-devel@nongnu.org>,
 <richard.henderson@linaro.org>, <vasant.hegde@amd.com>
References: <20250801060507.3382-2-sarunkod@amd.com>
 <20250930093636.11796-1-vsntk18@gmail.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250930093636.11796-1-vsntk18@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9072f0-0230-4808-d4e5-08de000527a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTlYT2Nkbm9BOWFLTER6enJDZk14NEhFZXhXTS8yd25iZGpqM3FwUFhPdnkw?=
 =?utf-8?B?dlh6WGk2eTVacjhzYlI2aHdhUHZwaWNObkhaeWZVcUpReVlhNXN6TzN6Tmw0?=
 =?utf-8?B?Nzd4UGdpT2J4b2FMMXpjaXJhR1E3cXZGbE9RMlVIYUk0TW5kWXRRRk1GZlBk?=
 =?utf-8?B?SWcwRUtTTE15eUhxSW53VDVQNFMvcEUvbkVmWXZ2WGVseFB4aW5pbzBEQjlG?=
 =?utf-8?B?LzVYU1R6VURMZEJmMHFYWkpobCtjUU44MG1iTkFOSDlUWG5NM0lPdnk4WXNU?=
 =?utf-8?B?b205L3g1aWtmRmtkYXg4TXB1R3BJK1hHSWJ0NGVvYmNjdkcyaGhkK3FKSkJk?=
 =?utf-8?B?R0llZWo1aVBHSzJCTGFNQVRXWFFrTThaczVKYm9DNGRIWUdXYWF0MGhzR243?=
 =?utf-8?B?OTBLL2hvRHF0SEhFbkM4Qi9EWEZxNUozMjdTUE1TVm11TmQ5VXdZU1ptVnNI?=
 =?utf-8?B?T1JOemJZVmgyR2hhVC9oMzJ2MlpueElQblFZWnZMUUJGM2Nxa2NYZ1YrQ0xO?=
 =?utf-8?B?SGlNY3Bsc0dhQzRjM2JPaTdMRzR4SGw2MFlGekEvVENLV1E5V3UwT1pqRDN5?=
 =?utf-8?B?cnJzWjh2c2d4a01LUk9FT1RZRE5tQlFna0N2aUJnemNZelVQOGlJdnc2ajV3?=
 =?utf-8?B?VWtsd290eGVtTjRCaWs0ZXljMjNSTTB1UnJWMDhnQzlZWG9IR0lndFFKa202?=
 =?utf-8?B?RTFyZjVYcDQzakRZQ1hodGZpM0N1OVFpWFpqYURGWWNkTERjVENpclZCSHV4?=
 =?utf-8?B?RzRtY2YxZS9PeXFuT1R1YUVwNTNndE5UeXpQSWhONFZWVHVNN1IvZDdDRk1i?=
 =?utf-8?B?a09GaGJxV3lKd0xEM0hjWXFaVDRVaFEvdEQwaDRlOWVlNWdaak1nUGU5TTdU?=
 =?utf-8?B?S3lWMmxuVmdtTlNybXBCM2pqby8wNDhOczQrWUlIVkU0Z3Z5aWlHS1FqQ09n?=
 =?utf-8?B?VFExem1CKzRwUEhYMHM1OTFubFZkNVhhcmJwYnRPYU1RUkNHbUlBWVNNK2Yv?=
 =?utf-8?B?dENQRTVyT3AvU1ByV3Iyci9GQ2FrMUd5TVdrUVZGeU9Fc0RHYXJFTjN2bnFk?=
 =?utf-8?B?Z0gvUXpHNkxDZ3R0c28xUHUwUHhSNEMvNzlxeWNEU1ZzM0FTNXFrK2N0MDYz?=
 =?utf-8?B?S0FMaU1kVzhJVzNuWlJ3aSt6ZGZ5KzMxSDZrdDFKWmpvWUJ3azllcjhNRnpn?=
 =?utf-8?B?NURtR1JjaDAramI5cHJwa09FaGl3UkxubVM3MkZQdk5zN2VRcitJWVlLM1ZX?=
 =?utf-8?B?dm9WUlNROFFhNVkyc0RpRFBzT3A2N25QWjdpcGU0emNQQ1VxNlFwZXo5K2R4?=
 =?utf-8?B?VkRpSEJKSUNMUWtxTXViQ1lzQ1N1SXpqaVZ3V1orZGVZTTVENUZiREhUUE5W?=
 =?utf-8?B?dk16aVFLNzRobG51VXB3bzNjUkNqTExlYkdjWk91OHdRMHF6a1M5cGw3N08y?=
 =?utf-8?B?aTh3TElicUJ3aGFMeXMrNmRZbWw5NXRkdjhrbk0zaWtnNXVKNWJocmExcXhE?=
 =?utf-8?B?anJPMWYvYTNZajBKb2xlRER1MFBOUXIzeGdCUGtGLzcyRkExYSs0K2JTTEox?=
 =?utf-8?B?MzcwUFVwQnN5ZU9GdFRlSVBqMDJYb3VLaE53c2tXSGpyUDBPYk0zcm5hTWZL?=
 =?utf-8?B?bjgwR1Z1cUtqRHZaQjF2a2dFc3JVQ0R2TE1xcXRRb01aYlRHeU9iaURsRGxB?=
 =?utf-8?B?NVkwQ2pZc1ZBN0k5dlhwY080TktBb0ROYk9yMzhqSGxDOHRjdjVaUDRianhm?=
 =?utf-8?B?TFNMOFF3blIvcmpyRVh4NElTRDFVQnJpTGx3bldZRWlobldCWTJnTlJmM2E3?=
 =?utf-8?B?eEhhZVlvdjBWOTJEeDh0UFM2a0NnNUI1U29XdTlwV0UzM0QzVFNKYy9BWUM5?=
 =?utf-8?B?NVhnRWROdmIxZi82YUozMXFIenU4YzZaYTlteWYrc0tBMklHQWplWFpLQ08v?=
 =?utf-8?B?M0IrL3RPU0hjM2p2b2g4bUpiR3pwcSsweXRtVmNuc0ppYm55OEQ2SkkvOHdY?=
 =?utf-8?B?UStLclJRZExreUJJZWMrZG5qb3JUVC82YmM0TmtCNWVJSSt4RTVsVUh1TE5Q?=
 =?utf-8?B?THFKWlRSMFZRWDIvU1pZV1VYQThDbWJoa25LSm44OWhTZEt0NHE2eEpGQjhK?=
 =?utf-8?Q?dba0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:38:47.2049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9072f0-0230-4808-d4e5-08de000527a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
Received-SPF: permerror client-ip=52.101.193.15;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/30/2025 3:06 PM, vsntk18@gmail.com wrote:
>> -static void amdvi_mmio_trace(hwaddr addr, unsigned size)
>> +static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>> {
>>      uint8_t index = (addr & ~0x2000) / 8;
>>
>>     if ((addr & 0x2000)) {
>>          /* high table */
>>          index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
>> -        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
>>      } else {
>>          index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
>> -        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>>      }
>> +
>> +    return index;
>> +}
>> +
>> +static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>> +{
>> +    uint8_t index = amdvi_mmio_get_index(addr);
>> +    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
>> +}
>> +
>> +static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
>> +{
>> +    uint8_t index = amdvi_mmio_get_index(addr);
>> +    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
> Shouldn't you be picking between amdvi_mmio_low and amdvi_mmio_high in the
> above 2 fuctions depending on the addr value?
Yep I realized that after the patches were merged. I have included the 
fix in the next cleanup series

Thanks
Sairaj

