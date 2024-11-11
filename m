Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97965D3ABF1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 19:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAZd4-0002R3-4L; Mon, 11 Nov 2024 13:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1tAZd1-0002Ql-6M
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 13:59:12 -0500
Received: from mail-sn1nam02on2045.outbound.protection.outlook.com
 ([40.107.96.45] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1tAZcz-0003oA-EF
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 13:59:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD6vH3hJ4dMyf9Go6dJqRWxocqxdXIO/VBE8QaMk4O6JTV+HCzITsUaWY5bNHFsnKxnpsfenx+ArdAK5JSAoriJXJd4fZ9pfJnEMABxTgC8PQVTxqT4/yR7N0QNKROlyY+K5+1PnI89+8gAMMWMOVaspqdg4yJjtP///TKYp3mNCFiyJZuuUkDT7UxjJ/droql6Exd5w34iAFBd+KfLhADda1lmMU3wqKmcSfYQfE6JUe8t+fdWzPg1RdrUbGPdDrUgSV8QhQB8yoHzM5uXMlTDgRtj6tSgJMt5tgPi6rOq8yV6H9HVmMK9fRrN9SV1sMOeazKxIoAz8ggslyKRXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40CTrPbLByU5cW5JIeCveCntVxwqRoVn2WY30irMCLM=;
 b=A0smZ5UISnrzJ7Rtw8mjKeelU/FaQxnNjY/Zs9Wi7MyP/dGq1YcwOM1BWjyzEI6wBMA630P9yuY8B8nCI/P8ccAMkXU4HatHm6U6IB8+jVslEMui/3qfc4pJCVbA6IKXcVw3G081GPDY0LwZtJrel99exMfYhZyUnrRnz3Qw1bGnnB9bYIHkFqWpjJfGw+67gLNMQQVEePJZ1oqh8VxpvKBULWss4O73eyNsW5Y7HR/DceKNUT/a3r5VWcQW3gRDc5hJxJZrP/cCHRpj/twV6l0VJpm5VchwV0A8CRy1f6n8OjCAP7sq+AnZNObvmhrOwJr8yw/JTjIZ0ch3pJ5Z5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40CTrPbLByU5cW5JIeCveCntVxwqRoVn2WY30irMCLM=;
 b=nGgrVxEzLzQkIrsw4go8/1dA0nD8G6ULJEm1eWc8YaI5Ra3AU0+2uq6OmjJuaWIZh8oZEJ3ojaiHHkdNzhDrUapYGl2MuPqKHXbfFP1c9DNxQrc3ke40IBskLIpEOJSJqSWUTiXC08X2TCGE2eOWsQk1bNFlztP4aK4uuIt5OYM=
Received: from PH7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:510:339::11)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 18:54:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::80) by PH7PR03CA0026.outlook.office365.com
 (2603:10b6:510:339::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Mon, 11 Nov 2024 18:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 18:54:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 12:53:59 -0600
Received: from [172.30.86.253] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 12:53:58 -0600
Message-ID: <567f142a-55d2-4d4a-999d-d8b63e4882e3@amd.com>
Date: Mon, 11 Nov 2024 13:53:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v10] xen/passthrough: use gsi to map pirq when dom0
 is PVH
To: Jiqian Chen <Jiqian.Chen@amd.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony PERARD <anthony@xenproject.org>, "Paul
 Durrant" <paul@xen.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
CC: <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>, Huang Rui
 <ray.huang@amd.com>
References: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20241106061418.3655304-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6e1520-2835-4b68-965f-08dd02823454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0VickcyNlk1ZWNWVi9kL3hpVzRlUFFYOU9aOG9SQW5wUmswd3IvZEphQTVC?=
 =?utf-8?B?QXFvcGRvczJrcHVNbndEMS9vd3dZTGpHVzZzSU8yY1dyQVJmWk9mSjZwbnl5?=
 =?utf-8?B?RVpkRkcxZ2o5YTJQb2JMYUloTURrdVd5MG84WUlZYjRTeWoyanV6R2M3QUZ1?=
 =?utf-8?B?cmUxQ0RBSStVaytmcTNkVjBqNGtSRTdVV0M4eWRJVW82NmQxL1UwZFN1M1hn?=
 =?utf-8?B?Rk9FZDdobXIxbWpNMXBnRDVoMFNiSDR2MmVNOVEwMDVGTUlnRmRyNldzY1VY?=
 =?utf-8?B?OHlBRkFwZE9PMXllK3JlWFh3U2VVN0dmYjdmSDBPQW5XdmplaHhuQmpOaSs2?=
 =?utf-8?B?cUFpSHpOQWdrZ1VLalppR1JDU0dDeHdQeWE1MmE1TWRRamREZkY2T0JPZTUr?=
 =?utf-8?B?Z1gwV1V1emZZTGQ5TVhWOHBMZWRyaFAxbDJzNVBZQkpuT3dndDBwTWdhVzF3?=
 =?utf-8?B?OE9JaGxCcFVwQUNzaXZtcVlRak9aRm5TQXhjdFBhSU1wa2dDRzE0Y3BMNEF1?=
 =?utf-8?B?Q21STXlHcklaeWpzMWVoZlNEWEVSZkNJakVJR3N4Q3JaUUhmeE9JTkRiN213?=
 =?utf-8?B?bEpDNTRMOW1WZys5ZE91dGJVR0dFeC93anZjQzl6R1I2aVEyUlc4MFZoSElm?=
 =?utf-8?B?dVM2c0FEY0g0TlJsSTFoU0FLcGNQTHNNaWZmZk15ckVGVDNtTHowVmxXT3U1?=
 =?utf-8?B?OUVPNXIxc2d3VERPYVhQcDFhUi9qMEk0a2Z5S3NCM2hZd3VHdTBXZnI2UzdP?=
 =?utf-8?B?Y3hQOFgxT2V6V211RzZpaktlRGZFNlRjdmJNQ1hyRGZYUkF4RmFsSlpYTEoy?=
 =?utf-8?B?NFEzQnFUUFdlczFKeGRHeTVhSHg3MjkrbU9UaDF1eW82c05CUVl4WVN3RHM3?=
 =?utf-8?B?NTJ1TCsyQ2dQSTArSTk1bFRuUGZXMlE2cXB0MStRc1pWMDJPTmpFR09NWGlV?=
 =?utf-8?B?V1RBdnlQSFdjNzYzdDNRZzFoRlVqVERHOVhGczVDVmxOSkI3UjRGbHJYQmp2?=
 =?utf-8?B?NEVXOHNCZEI1VXRyam81S1ZKZGE2S0p0QWZ4NzRKS1VaVHp3eXJnYW5hQURQ?=
 =?utf-8?B?cnExOThjbEJiL3A3WjNoQnp4c1FIUG5sOWtpWDBKbkxqcFdscjQ2bUJ0UG1v?=
 =?utf-8?B?T0g0R3R4bFJIM05CRzRuQVM3dTJYTWw3ZWNTMEhWV1RrZTlHQVdPUkxjYVpL?=
 =?utf-8?B?QWdVeXZIcFppMTBPZlhOQlZOM3F3N1hWelFpd3dQNGtRQWpXa1BpYm1qd2tk?=
 =?utf-8?B?cTZCak94dXJITnIvRVpxVWNndmtMRjdsWVNzK2hRWmlMdWFUOVpCeDdUOHJh?=
 =?utf-8?B?VDRteTZuUkF0N2hGejNHUTZyKzJIYVBrb0QrZ09TcEpBL21IQWlWeFNlM1B6?=
 =?utf-8?B?OUhUUXlzN3BXbFgvTlJiVGxnVEtXRThZYThGS3dlVG0xSUJ6d2RkaU1rNU5Z?=
 =?utf-8?B?dEtkbjE4bFVrOExxVDRPMkxzaElKNTMrRzhPNlpMVFpMN2p0UG56d2dpWUh5?=
 =?utf-8?B?by9uUzJHanI0djFDZEx3OUdlakN5VXZ2d25wUnpMMTNCNzk2NVFlODFKWitM?=
 =?utf-8?B?VEF0VUVZbFhRclhPaFUrQUlYcXVWNnA3cURpb1R1VkRxOWNqaHp1ZzZPbFRo?=
 =?utf-8?B?bDNWcEUvd2pheVFjRGpNVy8vNUR2YWRjaDAvSFZObTRxcjFhSkY5N01uZkRw?=
 =?utf-8?B?SExOVitBdENRelZubWNuak9jOEtaU3prdDlYb2t0V1pPc2Yyb3FFOGNZOW1j?=
 =?utf-8?B?V3BsS1VDUG1NZzg4eGlmZ3gwYWo3UVNob2dxcmkwY3NWT1B1V0Yxb0kyVU9S?=
 =?utf-8?B?dkhQSitiRjBIOENtMmFPbGJyQ25seS9tbGZJQlUxZnkyOW8vYVdaczBVNjk3?=
 =?utf-8?B?eDFCYWhGMjM4UlhzR1MyZmt0bG9MVThEQ1IvWStzbHRKZUE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 18:54:00.2502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6e1520-2835-4b68-965f-08dd02823454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
Received-SPF: permerror client-ip=40.107.96.45;
 envelope-from=Stewart.Hildebrand@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/6/24 01:14, Jiqian Chen wrote:
> In PVH dom0, when passthrough a device to domU, QEMU code
> xen_pt_realize->xc_physdev_map_pirq wants to use gsi, but in current codes
> the gsi number is got from file /sys/bus/pci/devices/<sbdf>/irq, that is
> wrong, because irq is not equal with gsi, they are in different spaces, so
> pirq mapping fails.
> 
> To solve above problem, use new interface of Xen, xc_pcidev_get_gsi to get
> gsi and use xc_physdev_map_pirq_gsi to map pirq when dom0 is PVH.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

Reviewed-by: Stewart Hildebrand <stewart.hildebrand@amd.com>

