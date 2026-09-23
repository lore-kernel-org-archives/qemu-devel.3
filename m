Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467C4C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9LaG-0007NP-E9; Wed, 23 Sep 2026 07:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x9LaE-0007Md-6V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:56:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x9LaB-0003Wf-K0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:56:17 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8HGr32584362; Wed, 23 Sep 2026 04:56:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=WtO1WszyjJ0Jw
 MdB2ULgCwLsPZlal2afn/By156zf2s=; b=0N9swoVm3ydozVEuITuXdot9VOpsi
 ppHoO8+zBTbMJe2IosZe28xGAY0kmlWQYUMsDOc8qHXdvBo2SBtjKGSsbDsxjlLf
 2YUBGBS0nYltmLZSahJJ6Ca1hDniGm29muEMbNcckyvf7Exg9LVWCXMlfJpJae6q
 Nf2p/W/Wliadh7B/XxrrxjhvIEGXhLVV2O7Pl2ua7IPT7JJC1a7uec4Dt3ov49W4
 qHLxYU4dYY51ogbVM4ehfipAatSZ2i0RCgMPryWtD2jXpVcTKG02VIK38HABIWS8
 BlHPvSL/IghZes1GkSVs9zfZDMxQGnry/izzRjZ54lZgsg0sjF9ki8QTg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020075.outbound.protection.outlook.com
 [52.101.193.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gv3269ey9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 04:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahK513BAc7Uls9uQBsw8M23ZBoXwiaw9fKzOY0/+seZWIQNvScDXHiO7CmIrr1cAsXWXyjn4bsmKDXRz/AcTf5Y4D3TKVnXgEVTOY4J381T3Rw6Hz4e52WF73cypDZu66Agy19uhhVKL/B0YU12W7d8gQe7NyKKsnKXfCcgaZN/6hC2wfXTwXzNT1l7i6HyN4p4J+Z4m9ilcho14PYCAAkmE1Lf5QJcGM6GGzAE2XFcpETFjtnzxMYmbHE6PJX0IS/1O0CwjKd5BsXZgtFHp5TdThBMW+8d756y8dtc8UJpGGeETXqSatDGj/8BcYyFc1Z/GX480ZTyGvotuIUmTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtO1WszyjJ0JwMdB2ULgCwLsPZlal2afn/By156zf2s=;
 b=nrJMUmVOBTtNe7GW154tlRt7pt4YbnkGsJ45rYgmIyH+vUkuuJ6+2u+wQN4FoIqx8JnbK0100r4H/lQdH30FKXGZsLXG6c9BAUmzsH/P1JwVUsAr+7YS7FgMyD1qLM+LaV9wa0jopVaUGqLqZBn1RaYl2b+9dPd32lnuD4XdAayoI26zh+4BS+oQKCuEAeUnrs9692cPhfh5jZeCtHLh2psCzqZzvAIIR2A8+DNoqPqxKVvmMrITcoe9rdI6agniTjT3wpi1ZRUNxGPzY8L8EcoP1FjeVzti9UoNpRd9qEtZKtrj2Y16bdlxxKFeWpvP4hmKPWrazbsg//8YrX2cSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtO1WszyjJ0JwMdB2ULgCwLsPZlal2afn/By156zf2s=;
 b=ISFE0Ak+MGnR72LXpR6x+f2+ihOPstnQubQ1apfG3141LUhclmalPXE9gYnLec6ri8c6xPhyQRy8JhBJ32wiASww1po5cjRxs8g0IrgC8TOPRT5/lxRdUChAI9zbU4DhkEmrVlFzzP+RI6Us//LgyZU65XKDvsgTtXiLkqTS7HzoRIqFoYpNvr/Sw8MDHyW35EaeiLqkKs5uT+TXuTHWuiG+HdWraQ0we4LQx6xhH3nEt8lk2UJytn5aqasQ/Nhur07iK0sKqtNSQK3b+l2o7Z3v6yjY9AXpInZAc/oJXIn99jo8ATj1q3HHyKU4VtLdgolidG3IKvKmbmRcG+USNg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8092.namprd02.prod.outlook.com (2603:10b6:610:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 11:55:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:55:56 +0000
Message-ID: <06a98356-20c4-479a-a8f7-392ce5b941b5@nutanix.com>
Date: Wed, 23 Sep 2026 12:55:53 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: tejus.gk@nutanix.com
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: buffer_is_zero() constant optimisation not always applied
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f62ffb-2d47-4560-a5c5-08df1969a059
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: QBFWeUfLABlVXyhEdvvVaqw3xw60zkMSIi86QBjjjmPuaUYWNuNyLz5fIqKzT331gVZrlc9NdN9lu5fKbpJUYTw+eCxzAjv7dPkbGJb0xdgn+upPnVl5DCBKhlNsRW3LhC/s+OZsJTs94NQEP+El3fQ3szzouaCYB/yNqKECwN0xVwqTL8OdFa0vX4srquOrbIGAgAZ/xerto2dGNSTHgaOFFVr0KaX3uAU6XXPAftY6ylDLRa+JK/x7y0emqQvhHx3QO8uIWfiUw0qVJUqLzep+t5Do3UoKQ06fpnQbggAM84b5lA4pdEBY2oKRfpDbs3AUla3aNffjVnwL221J6H1nsDssJaU0dTY+wj3CI2nFORF8NhlJwNjlnPdgBDUlySqcH8UfbxGR+Hi2z324QagAo+U8jxQm/qQir1vluDRUlGJa0UNKVMAIyctJOp566eZjrBOCAY4uuIn7CxAepU32WKpiWdUcgdmXcVuh2PNPA8z6DhxU7YYPEZNTk4C1wrtW69RB220U48/lYf8rm74Gb9r0yoYeum7IWGOahNROJnxwpasLrLTxCazo16dBrRIF0KQsEzP814vTskgfnB7ZC+aEig0Y0VK6zqXDkyN0YP2S5dbNeTBjCqnrog5DovSVy+qeHO3k071pbpByim4o8cx7JGUcNAvIEi7kn5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFRclhRTVRnUDZKam50NW11Z1dDblBQamd4ZWt6SjErZHJsUFkzbEJRQVd3?=
 =?utf-8?B?M1RleVJaTmNFYUk3UDFxdkNSZC92bkRUVUNSaVFTTTZwaDAxVHFqUjFGOFp4?=
 =?utf-8?B?UlBJZ2k2cEZhRVBxQUdvaEl3NHFtbmNhMVVVYW8ya3Z5Q3gwU3BPU2RwU1Vt?=
 =?utf-8?B?YUdnME91cThHRlRCSjJ3Ui9xRUJRN2U3SGpvamc2aUlDMGkyRzNUQ2c3aXdh?=
 =?utf-8?B?dnA2aG5CRVdhQTF4RkUra2N6MnE1Z25BWUVmeE5BWnMyV0xxV3BNMXJOOUpJ?=
 =?utf-8?B?RDVwaGVsKzU3WnVNWlRESGZDQ0VTMGpERXdqWlI4MUx3eUpndUlhQmp4WjVk?=
 =?utf-8?B?VXYrTXpkOTNkNCt5aXpBQUVpRWQwSW9vN1U5ZmV2UmVrcDYwK1ZpenlCUFNP?=
 =?utf-8?B?ZGlpY0ZuRFZjTHBGcWNYVVpGbE9zREdGZTJOQ0NucTI4MGpDWldha3AzVUpv?=
 =?utf-8?B?S05OM2RHNU9SUWxMbmlpcjJwQ1Q2bDBVa3JTUGhEVG5qTEdxcGRwam50N0FF?=
 =?utf-8?B?a3pjalpMN0MvSERNbnQvZnpOc3hLMk9uWEVlbllmTGEwZlpXU1d3U2k0VDVx?=
 =?utf-8?B?UXBqd25TazVTSHNIRUg4RG5yRUFrZzVCMks5MkVKb04wTDZNc0FoaFRla0hv?=
 =?utf-8?B?WFN1ZzZBWDFwMVpHTTczTzJQMml1bTNlOXFHcklrb2R2OWNVK050L1VER1Uz?=
 =?utf-8?B?bjNQZVo1Y01JZkE0aEwzS1FRK3h1aExGcC9GYzVjK0htcDNRT2NIS20yQjNP?=
 =?utf-8?B?WndzZVZlUEtxdjJaejNoWjJOY1BtTWR0YkFDM3R5SEVqbi9ndDBFZ1prVzhw?=
 =?utf-8?B?SnhPaEtmcUg2dllDRUNTejRZeEs3aHVweUwwejBnVXFpZzB1YW03Qmt4Mm1x?=
 =?utf-8?B?VzhkNEhNNWxTRXdHbXlIUXZUQjlKVGlPVEFtT3J3OTF6REo4cFVsemVzRVBk?=
 =?utf-8?B?SjFobHdHbVpqc0N5SlJuOWE1NGlWQWlQMzJTWVZiNld3b2RIY1dTWGhpTUhO?=
 =?utf-8?B?TXlnd3hOa211bmQ2QlBidHRxbFp1V1dkNXU1L2JkZ0FiTUlVZ0JETlY0Y1RR?=
 =?utf-8?B?NmJsKy9mNDBmRmtTRjg3cGRraFZRb01XMitxblFEeHlOd2JoenFSYmJZL0Rm?=
 =?utf-8?B?bGNIVnhvSmYvRWx3OWpCN3U2djV2OERGQjlRNHJ6L1loZU5iV3JEbElZQmRZ?=
 =?utf-8?B?VTMyVUh6eVVLcXRCVnBhT0wvdHlKQnhqQjZScUEzSUlJTGRKNkVmaDZmRWxH?=
 =?utf-8?B?RjIyV3ZBVHBmOEtHUytEdXc5US82VTJ0M3lIeFgzT0xaQ09UblF5c2p2c3hS?=
 =?utf-8?B?Qnk5WXpBT1FXdk90MnJpK1NPbS8xSklzWUJFTUVBc0JwT0xBN3pCQTluQnpF?=
 =?utf-8?B?NGhJc3h5c3hsaW9SVWpyYTE5a0svZnZENHpUWlpzWERZazZhd0VFRytobU80?=
 =?utf-8?B?ckwzdHozcEs1WDQ5VC9hMmhaNkNjQTJSQ3dkcHErcTF4emlZbGpGRURTaWZs?=
 =?utf-8?B?azdQSlR6VDF5MUtRQUNabzluZWcwSVc4cEphSFpDaHp6K1h3VVJTdmVBMGNw?=
 =?utf-8?B?ejU3UzcvV0pVdjJvcElYQ2g4cUJ3b21MQzk2OEZ4aDZZd0Y0U2JMQ3NiRG1t?=
 =?utf-8?B?aDNXY3daT2xmWEw3dlE5WDRJN29FR25MdUhFNDNObHBhZ3M2czNRSjNNcUhW?=
 =?utf-8?B?M3JCKzFZaU0vOVQwczcya3FQU2RLbGc3MFkxSEpMR0RGNEpsWlZDenBhZkZn?=
 =?utf-8?B?elg4SlVLcnc2bE5ieCtMa1M5cHF1N3VJRmtOejA3Z2FDZWdZcm5mSHJNNzNK?=
 =?utf-8?B?ekNJUGNQNlpjZ3FyaUsrRzF1eTd2b2k4T3lQRlJaZHZsMTBuQXErT3RMc2d5?=
 =?utf-8?B?djV2d004anAwY0Q4amM4QWQvUFQ3eXlyYk9Sbm9KbEIzNFVUWGJOcnBXQk5L?=
 =?utf-8?B?QzIxeG9hYmFnWGlxR3BzaEVOYjR5ckpLNUFXT3E0Z2xqWDNYMzhEMjN4TTVZ?=
 =?utf-8?B?cVAzUFNqWFd0eDZ4TzF3aGFQWGZncXJDMG9MVm1xRS9BODhYa09YaEhsWGNI?=
 =?utf-8?B?Q3dmdjJTRWFXM1dKWklvSk5FNmdOc2plRitSWTdGQ29FUitTSTljVDk5RGpt?=
 =?utf-8?B?UXdRaDA5UHBBMVpJT1BXd2tUdUMyS0VoL3VDVWNJcVY2MUJIaFpyUGRkVzkw?=
 =?utf-8?B?TEV0bytHaTVGTjVBUUx3aFM4ME16b0F0WXkvNEUxeCtJbXY5RFRVWm94UjhT?=
 =?utf-8?B?ZnZWOW12NDgrT2ZIaUJtMTREY1V4SEhoOG5zVkorVVJoVjE1RDlkTzRIZStr?=
 =?utf-8?B?UkJsYm1mUXZUVlhUTFNXR0Z3eVN6UHZxYktOUzNYZTdMNGl0R1ZCUEpNSVlW?=
 =?utf-8?Q?3nZRGrh852PTKv2Q=3D?=
X-Exchange-RoutingPolicyChecked: a0QRIOmboxDdQfdYxx+2+WXWqUGhrEAHI0930srtevqrH9FQs4QLQgdHPxTYpPJMqE/awedQMiZxWyHKY4+PXVpiie177v7ilEPsrZF9cwxfIlBEjjnZnYDlkUrTEfx33SK97ltm7S2hB5PF5kbMe59xD2RIg1VFdwi05J2QZER7ZsHl0Iz517dSzgDiobbnwA9YfK565Y6oGL9Ys/qzSSvT5EXRpksP0lw/0XAw4dhlq7HknmrDHMrS5VYfcS0KanSQwBOBLUKKlQ5wIXoJ8A13WdN5Uu3RWWgwPLMn1SQSy8HjhAxHr46m2PU/wv7SILH5blCGgBklYE95vCuSHg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f62ffb-2d47-4560-a5c5-08df1969a059
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:55:56.6139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdEi2X7WWcb2NIPms7GxvHlitvPMpGJGpSVql7ougHCIl2qWxz4xDhnAavMdjG8uK55cVbVRHo8wF/PVNVqy4ZQsQmDksTWwQF678kZqwIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8092
X-Authority-Analysis: v=2.4 cv=XNKl2ghE c=1 sm=1 tr=0 ts=6ab3be5b cx=c_pps
 a=dTGz0tuhMYfsSU3NwIzouA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=b9Jq_OwAuYa9_IyLL6oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vCwQ66KA60IQTdr26XxHVtWAZyScsLNN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NyBTYWx0ZWRfX6fgfnINaXy7S
 JbikyzafMiSXh3+euYL7nPuV0aixfELjhvrzG2xWsehQv7zwzwxRqmC7mUoUy7C7ac1MPHevaqY
 q0WUWvv/4woQG0ENhQV+CD9p5e6Je/q6F5kuRoy+IU5P/hy1FaXlvAp4SJvgB+MiCex3corscdG
 gd35yNv+73gxK+l7s0/VCdIT30ELdu9CynqH7WlbmY6wd0qj7TJYI8hyA5KFhjouBilYEsxzrbf
 0ReKj5urclcymdhB41X9XXeEow5hNZRCRcWaTRib8ke5tpRY++qg/tfBaj01g/PXizbPOVRSArm
 2l9EaP6vcA8DPNQcgU/2YsR2/Tdee6fCzzuu7qpvuUEsFkrq10VehgLCYmybGEiheD1lXXigpHw
 2elZ6ozDTaRXuyB9EPDzyQQ6lJJGb1WJoWKVt1vYnP+USKLyhlDMaQ57vuK7wKvwIvFqf7h33gu
 R1l+VqIQbYRramAwtfA==
X-Proofpoint-ORIG-GUID: vCwQ66KA60IQTdr26XxHVtWAZyScsLNN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NyBTYWx0ZWRfXyYXU+NClUuLF
 DWz7cXVht82s/j5FRpAzU2Y0T8476yyivf3AKdh3M0IdrH1NVcd4RpRfkK4APO7r0LIjKeQG5Wo
 XrhwFXF7sGwR/dlDdy+W+D3t0BtMvW8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Richard,

One of our engineers, Tejus, reported an interesting observation that 
during multifd migration the zero-page detection logic was falling back 
to use the out-of-line buffer_is_zero_ool() implementation instead of 
calling the accelerated implementation directly.

What we discovered is that the optimisation was not being applied to the 
buffer_is_zero() call in multifd_send_zero_page_detect(), even though 
multifd_ram_page_size() is effectively a wrapper around 
qemu_target_page_size().

Digging a bit deeper we found that migration/multifd-zero-page.c is not 
being built with COMPILING_PER_TARGET and so we fall back to the 
TargetPageBits logic for qemu_target_page_size(). On a local x86 host 
here the expansion for qemu_target_page_size() becomes:

static inline size_t qemu_target_page_size(void)
{
     return (-(int)((int)target_page.mask));
}

which isn't considered to be constant at compile time. Given that we are 
building a fixed x86 target, is it still possible to get the 
optimisation applied at least for the migration use-case?


ATB,

Mark.


