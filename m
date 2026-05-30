Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2101CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 18:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTOaa-0000by-1f; Sat, 30 May 2026 14:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Costas.Argyris@amd.com>)
 id 1wTOaW-0000bn-6t
 for qemu-devel@nongnu.org; Sat, 30 May 2026 14:39:12 -0400
Received: from mail-southcentralusazon11013043.outbound.protection.outlook.com
 ([40.93.196.43] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Costas.Argyris@amd.com>)
 id 1wTOaU-0007tB-IP
 for qemu-devel@nongnu.org; Sat, 30 May 2026 14:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KglCY1ny7j9b3ygR8LU7O0RKZu6Xex2Vyla3oys9nvgIMMBHXT37p9ExybwH69SScVhfbX032rl934EdTrvQhIq6jiIwAOocw0/Hp8Je6ZWx3jOAa3ZtygG31qVSj1XOCCv3qb3BuLowJKaQprQe5h+Wzx+8CBHSYQiI+TJYpvKjcUscx0NsLDmKu+YpFAtsPfC/ZMURJdp3LODUEQa5jA02UGe6hEdbEHqdRazYxxnqHtEjGH2sehfhOb2Wmboi8VekzBrqY4OXO54/qZEpHzIu6uqz0cfInVqn9SWgAGGpLjvIIq2FnBRTlqVb8xv8jrqHTqSpd6fHhtXfqyUV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SFfRUBmFCbjO/gemM9OWIvmwp4md2OFqeFdZtO4Qr8=;
 b=l12sH0cutqBWfuabvwRRvq0XfrGu2M+GJJuooTFsp1rd+myVTG1REN2853xX7/EXpYQsLTalcVR+jy2stKwYbYibs+4bOvBovlvda9Py3mBMWt3mHL2uCGReybKTri4ZD/3qwPsL2uY9zy4ONr7DuAaSmyerae2B5caFG2OJAJFOTQiBYOQiBglfi9vshMTVSvLZHrm/+2tODgLNICn+7AxOqMxTgsw9wJq19PLBQJqCr2A822p/vjkpQH1H2hIxMp7wOkhV81X5o0UzH6EHcYvyeOoOLKwC+FUVm5VRueeGLNYLw0e9lYrqqQh9Dzya95Acs6KQ3aXPNjdwS+QIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SFfRUBmFCbjO/gemM9OWIvmwp4md2OFqeFdZtO4Qr8=;
 b=s+Dxbid9VNa9nu+KqZKI6aes83JcjmOqPlh2pEpsFENKxLpTkP41VT39jU8OB7467A18zd4z5qUce5TV+JzGcQvNPdGQsCPqidtrx7GgN/WpBulz2L1rqvXP+oVyfGONpEbcYxpA0ibjG1ZPR/EqHpIp8aR/027FQgzLWN9jiMY=
Received: from CY8PR12CA0072.namprd12.prod.outlook.com (2603:10b6:930:4c::15)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sat, 30 May
 2026 18:34:01 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:930:4c:cafe::8) by CY8PR12CA0072.outlook.office365.com
 (2603:10b6:930:4c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Sat, 30
 May 2026 18:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 30 May 2026 18:34:01 +0000
Received: from MIKCARGYRISD1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 30 May
 2026 13:34:00 -0500
From: Costas Argyris <costas.argyris@amd.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
CC: <qemu-devel@nongnu.org>, Sairaj Kodilkar <sarunkod@amd.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] amd-iommu: fix CmdHeadPtr not wrapping to 0 after full
 command buffer pass
Date: Sat, 30 May 2026 19:33:34 +0100
Message-ID: <20260530183340.7748-1-costas.argyris@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0094f356-36c9-4f8c-84ff-5d98b0108f14@oracle.com>
References: <20260517192314.355499-1-costas.argyris@amd.com>
 <0094f356-36c9-4f8c-84ff-5d98b0108f14@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5001645d-759e-4920-7799-08debe7a04f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: LhTYe4afrv5Mgu8WqfO7tptzcBt4IvupKpS31MpMtHMYR9YbStvwENisXrTAdkA7BZw4G8wXfti4UB0BLJolMsNMGWSQt+NiqiGGbQqQkwN/jh6Le31XcsxwV/6pJ9DaENqofnho+/YikA+GpkK/eWZlYIeMxTSwx+38cGZpA3/VziZr9cYaQ1/vh+OcMQuX4wykm1m8SIgfWv2OrcGUeu8Gf2t6hx+BWHvsOZNO9hjU9GToSXiIbwKgDpYVCsI4r5jZ/68yqbZyQ7N0bxeSHp9VvEhmsEOzuDCgRSKUsWSgjSXotKE7Ko8VlRNWIMS2Ir5x7de08ZsxohMV/7Ap2TfGqmJ7a3J1XC5u9avpgtLltAGXnOARzTJnhjsVqs4gNsVkhWGzuUwAweiGp2XW2pIa66n8E5ciSXAdhT7/yMbg5HbeVGGu8Mr6H2q74OqgVdgE1qsCcelhO2iX1FqTSDPPJrHCVVh/rhz8EY4pRmo1ef4L6/lCHA5Z834Lstle9CbMLMr7uP9HfmXjkIsHwjQ46rThQ1lkyO87k4xgIbUNQzZX7phWz/0in+ZaNyaqOvQ2WyybfwbjG9kU09RBYvv/rIgmUJwgop49JSiMr5ayoCV0p9v+sAGWYJt9SJKNik+nrQb74tQDujeKJvnjTobQ85kMZaHrNKIfd6AK0gDRQXBQK92X15wpMVkfBK1CceJybxdlDpXus2pK9jRDCXmo0qYAaJCyY+qa8uMlKmY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r6j5XamlAUeHxQogDvXdD7VH6K2u8gejQR/ZlJlmgHjFSoYBobH2hdgp8gSfIocaHw0uuypx0VXM1OJAiJEPFvS8ofQPS//O3ui9XamSMGGnNPRK4SuMy4I1RPOyFm7HSLYjKAFbAmlzaV6m5LfqvkDluE7Mz9KzL7k7ux2ISmgnj3ZqAV2s0YL+G8rhzphGgqS7pAusuu10veGJg5TBv/He3BxoKrB+KXbQsY17sHmd6cR6nGtd554e7fVDBwxOfa6XFeaA2aUbK3mpYCpEA4rNnZqqQJVM7Yj1VhmFYgpc0PnXkQ6Fj9N2iNLw+7B562nch7vEsD67znTaQQgCWVaRB3l0h0C+X6659ql0Ubj6V1K6QwjgEv2E3RKw1jKFUFB86laHLr765b5FfnYYT1ToQODbETgBni/lbuRcLnIC7/ac5VcYFHju3/3sK75K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 18:34:01.1301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5001645d-759e-4920-7799-08debe7a04f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741
Received-SPF: permerror client-ip=40.93.196.43;
 envelope-from=Costas.Argyris@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi Alejandro,

Thanks for reviewing this.

Yes, it makes sense to me both for the commit and the test comments.

I will send the v2 shortly.

Thanks,
Costas

