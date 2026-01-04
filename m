Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A454C2A074
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 10:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcLfc-0003IH-CF; Sun, 04 Jan 2026 05:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vcLfY-0003Hx-JU
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 05:49:08 -0500
Received: from mail-westcentralusazon11013056.outbound.protection.outlook.com
 ([40.93.201.56] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vcLfU-0003tp-RR
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 05:49:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEyMOPuVzDkWlEZWNMXVD2o0s8dAY4Xemthp4jxZVtTTuMpEu+s1LCoWOhk/zSUTPTTjBa9+oaLGg2i5iKwACglu7imXTzU7apaJi5YqPynwsE/C/pLEfY5RH4HrRzL8P2p4/d6eqS1j/blHDz9J5OC13nypdbRaA4h+x+/ji/CrMhYJIraII3Xjyr7/SKVZ3tlejXizXj0xs3S6niQdE60QhAWAXeGJY6cP3hCxKieEsr27NPjU9hJqBZh91pX3iDlZ8kyUQe+0X2mv/CZgRwsgBizhUopvg2paxpQkb/qiAz/xTXjvfZnaaWqpxODwwMQKOCAAyIEMlL2HJZHTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+Xh2xCbPHn0p/WPb4D5BwW4iCuIgFzfLu/4Jzi7wJE=;
 b=dBcl+xVlOF6gh59eA/ASHK55q7VEn/NIA3dqwWO12iiynbZeoyFet5Uw6gNULcjWClTbfnvF0wAX96DvHNdo4imHPJa3T5zGWJDqNhNQw4CLArx1MJjuu/xVwIdbbgKP1EuvS+R6gW2FPfZ1P6f6dvAJSw7mcVPGheBjR6g+ZNJ3a+5uqy06yfzaVncgGOcVggyRzBxld/zBis6m45PLZD8ntO3CksL3uSDMREyrPNnC7YtThzOPhFfVuKFBolYGRjkM72S/OSSDjRkiZg0F7IQZHv1i/78nf6JcCxwvjIoZjGVLmtBBIhlF97khbjThWo7CITLN9Kxu1jmY90cuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+Xh2xCbPHn0p/WPb4D5BwW4iCuIgFzfLu/4Jzi7wJE=;
 b=xD4/BZzqbCAJT+YN11IjGbluD4D4wqVDbWkMxg35bXeyHFmftUo8VGr0FqEN7ebvJuPTivNNv3eolcGliqAb/+w8VXmpkrYJY+Y049NJ5NZ9uX0O//XB7p50eEsUAPICbpA52O+QkLp+SMK0RBCJIDr0oB3K8TkloSLYR0zuaTM=
Received: from PH7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::9)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sun, 4 Jan
 2026 10:43:57 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::82) by PH7P220CA0017.outlook.office365.com
 (2603:10b6:510:326::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sun, 4
 Jan 2026 10:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Sun, 4 Jan 2026 10:43:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 4 Jan
 2026 04:43:55 -0600
Received: from [10.65.98.143] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 4 Jan 2026 02:43:53 -0800
Message-ID: <8f91be85-d1e7-4b5b-9ae2-e88e0f1c33cf@amd.com>
Date: Sun, 4 Jan 2026 18:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] numa: add 'spm' option for Specific Purpose Memory
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, Alistair Popple <apopple@nvidia.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>, Paul Blinzer <Paul.Blinzer@amd.com>,
 <dan.j.williams@intel.com>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <20251209093841.2250527-2-FangSheng.Huang@amd.com>
 <20251223095605.0000065d@huawei.com>
 <586a3535-ffa1-4d13-8bb5-c1b922a90a43@kernel.org>
 <bcad3442-0ed2-4046-a2a6-5176a7530f93@amd.com>
 <9713eeae-65fb-4b6e-b5c8-5ffc2c5b4044@kernel.org>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <9713eeae-65fb-4b6e-b5c8-5ffc2c5b4044@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b885278-56d0-4205-002e-08de4b7e294f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ZzaFIwTGsxTTNoaVNQbmVMbVhZeHNtMkNmZXRZWnZkSmhFUTNvWkpoR2hT?=
 =?utf-8?B?cGNiNllnSzZkL2VEWDFZbG95QjlkVEtLaXlMd0hzOThLdzN6YnIwZERYVGhC?=
 =?utf-8?B?MkZXMUE0RnF3eFFEL0dHOWhqMFVPRS84dm1uUmFSa3JRc2VqRG9oQ3dSWFhJ?=
 =?utf-8?B?cnR2UnhuMjc5UUQ0aVk1bTcvdGF3QzR1MUFkc0V4VmgrRkljV2Y5bWI5Z0tF?=
 =?utf-8?B?UXFJV0FJN3YrV2MwSVlPNWpwOGNFT2tZR01IMXVZTU5nc0FHSy8xeDZQREQ4?=
 =?utf-8?B?Q05nNUM2WWxIWVVuZW1XNC9INU1tRE1NVlNTV3MwZ1I4NXg5eXNycmlhR0Nh?=
 =?utf-8?B?eDRyUkNrNVZGR0puUmgwUnlDSElLZldZSE1uTWZiS0FiSzRtbU83RUFRNVZO?=
 =?utf-8?B?bjQ3cXNaUjlyazRuY0pDUFhGbEZFcUF3MzBHeVVPVjVoMVVVWjBhU21FSUpH?=
 =?utf-8?B?eDVyNDFkckZXaWFjaHNOSTM5RlVFUmNaL2thQ2hhbjZ6Ym5mOHdyU0tlTWR2?=
 =?utf-8?B?d1lPanp2UVVGK2FWSkFIYVd0NzZNTFdMVTB5dy8vQ0N1d212UmxPeFU2dWR5?=
 =?utf-8?B?cEFuTXFqbERwcUpWUXpGbjY0K1pUYzdpYTFSN1pPL1ZOMmlXYnZwZW5CWU5p?=
 =?utf-8?B?eThxV3dubDY4Z203aGF6M0tqQlZvU3o1SUFvTUZ4NXYxM3J2cGdid3R4UXht?=
 =?utf-8?B?K2lQdE9sRTB1NHhBSkJmY0NzK0FaeDJEQkZVajY0bk1Ob2hVS0VDV0xVNHFo?=
 =?utf-8?B?Y1k3Ui9FeWpMSDFiNG1ZYk9vUjFMaTc4MUpnTVFJS21tSjMxdlAvalZoVFJY?=
 =?utf-8?B?Vm5saCtaYkdqVExlTnJtVlllSnZyZmEzdmtVb1lacElnRFVSbTNyc2Zhb1FO?=
 =?utf-8?B?YlZvTGJ4NHpGQzBYM29CZk42WVhrd0wydW9KbC8zUWRqbFphd2hjVDc0MDVD?=
 =?utf-8?B?RUk1TGVHajlXcXZKRGNRcW9SM2lzL0c2YkRLZnpCUzQ4UlRPSXVUaGdDeklF?=
 =?utf-8?B?QlJKQVErUWUzWjVxMzQ5Y1dDMDFoZG1hcFpyaHVqaS95K3ZLZFlmb1ptbFJp?=
 =?utf-8?B?RU00Rm5XY3kwYXdWazFidG9UNS94N2Q3TXlOdElLYVEzR2pTVjBvWWF4Ti9q?=
 =?utf-8?B?ZVowVmc2VnhORFB2dm90NXdXaUNTZDBRazRudEtJeGJubTYyOXlBZzl4MlVL?=
 =?utf-8?B?R1h0Z1luMU9OL0IyWHRSaXQwUy8rNnlkdzRBSDc4QkQzRk1Ed09pUWorQ2hQ?=
 =?utf-8?B?ekZPbVB6NEJiTE9xSVczV2RtMlVTNmxUNVJYUy9IVlZJWTRrb0NvRkVicVp1?=
 =?utf-8?B?K21tTjQrVkpFamtTK3N1ZHJGOU53NnAxSk03c1JucjlVWFRGQ1RnVWRCODZO?=
 =?utf-8?B?cVB1aDZJTzY4YTVJM01uZm5zYUdzY2J4SG1SenZQTm9hOUg3OFdPdkY3MFJX?=
 =?utf-8?B?MDRCYnZHdVlQUkN0UGt2WERjYldIR2M0WC9IZzh4V0g4NjN2N0FSMnYxaWs2?=
 =?utf-8?B?akhHUVBFeFV6SVM5V08vV283NFpVL21ZQmVMOVdrR25mcm9kZnNCSHh3dW9E?=
 =?utf-8?B?VVNvUCs3cklLekQrSjNyb0UwM3c5RUlsN0tPUnNBcWFjQU55dEpiaEV1N2dO?=
 =?utf-8?B?bXpDWENJKzhDUXZ1YkhmdUd3SEVNVlFCQ3dMK2ZlTy9HdEtvY3l3bkk4MDdO?=
 =?utf-8?B?NlViYi96U08rMFZMMEphMjlldmV4dEN3amdEK1lBNE01Z0RyTy9GdEk0WFFk?=
 =?utf-8?B?WmFuMHRtbnNKVThDTlhVc2lNN1lpNHhKWjUzUmZzeFRaT2JMQ1RrbkJiVU5V?=
 =?utf-8?B?eFAxUklwc0JOMHhENlJCTG5YYUdmMUhGRVRhTVd1MERaTHNRSFptdlA1WGNx?=
 =?utf-8?B?OXRPMEluRGNVbzJ4MmEzYk9LS21OUmJmcGVKSWFPTDBiYm9zUFpMMXRYcjc5?=
 =?utf-8?B?OUJ4ZE9EV2piQmErQ1VJUEQ4ckFEekJvQ3N6VG1hSWdyZ2srM042aGlsTWsv?=
 =?utf-8?B?TFVYeW9FYmdFeUZHcTFWeUlOZFhHRFBkQWR2aVZ6eDdMK1Qza3MxSG9oWnhR?=
 =?utf-8?B?Qmo2STQzOHpTTE1ERXRaem9uM3JERGFxY1BjRFNHT3VCazE0NlpNdTZ3U3pa?=
 =?utf-8?Q?5FTk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 10:43:56.3253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b885278-56d0-4205-002e-08de4b7e294f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
Received-SPF: permerror client-ip=40.93.201.56;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 12/31/2025 4:09 AM, David Hildenbrand (Red Hat) wrote:
>>>
>>> Just curious, it's the same on real hardware, right?
>>>
>>
>> Hi David, could you clarify what you're asking about? Whether the SPM
>> semantics are the same, or whether this QEMU implementation matches real
>> hardware behavior?
> 
> Yes exactly. If it matches real hardware behavior then there are no real 
> surprises exposed by the QEMU implementation.
> 
For the SBIOS pre-configured scenario, yes, it matches.

This QEMU implementation assumes SBIOS pre-configures the NUMA node
with SPM via SRAT/E820 - SPM is static boot memory from VM start.

One potential difference on real hardware: SPM might be initially
soft-reserved by SBIOS, then dynamically added to a NUMA node via
add_memory_driver_managed() at runtime. In that case, it's not
pre-bound boot memory.

This patch targets the first scenario, which should have
no surprises.

Thanks,
Jerry

