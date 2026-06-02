Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4915C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKlG-000394-Iy; Tue, 02 Jun 2026 04:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKlC-000373-Lg
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:07 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKl8-0004PD-IU
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHhvjzDJoA0Ow8ThLp56nCYd9OxRcYAPZmFQyycjFQs5mZBFcV55e94+KURk8rBGPfPXcPDwyx6/+yLHpcy2XHvgrmu0bpsh/aW5cfrxjjgPe08mG6+36MXa9B9wCIMBNFN0esVP1gso7HFCQXZSXl1D8j0Ni6kCZ+wTbs3ym5lJC/dHoImmWihQduidvovPFvXzaEUGv592qwdcfvRmXTAh+LyRLqwBzqwt1U/b5oW5YQUtVihsD3S5W0oVhpd6aYPqUVlKDD+62C7am0Pj4BdZsDxm7cNAlqp+gAQXbIDgtnSjaktFi67d2Xbo25zEuauU0PezMoE5XjfhddPPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYb+NBu0FX5gAhnxINL4VLT6LlAFJgLBG6KtQAM0MAI=;
 b=SVLkPuc/23nd0GeaXbjr7kf4mxGBHDYYbzoQa93IhYAEYRlpTeduUbLEPo8JN7QN++XLkvGuslXJEYfsWQ0dNm4I/D5t6u9/6njWuePvPJoILg7cUFiqhICedqJtPy5xyFBT9a4uebGfvJ/8kFy4umZJ/jNR+RbKMQWs/njGcPAvnyEhd1KXxi2eMBzJR7cAQPwEaqdGev78Rb2xj/yMXxEcelIAoxZ0jNcLp72z/khejjtqo9dB7PXkWxjEldyO8SoXpxdXMKkTjymQzZj16Z6aN1+G8dLF6Aru9YIVmKTjxPogW8xgitaYtl3rNx40SyivHVDy9qUXom/vDq/JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYb+NBu0FX5gAhnxINL4VLT6LlAFJgLBG6KtQAM0MAI=;
 b=xhsa7B6BvBABloE+JbExXg55Tl0OJ9grlH+VXaCLiVqtUvvCarUmg6QQOBlLELj76SrZIJWSLarCC2hCKTw326f6PN2+cld6Xr9q1pwhAtF9bKrGN/oF1ZbjtEmhqRvyETjZA60Ab9L6/tZEW327jCyplO4a2tMwgMOCzYMIkR4=
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 08:45:57 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::af) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 08:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 08:45:57 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:45:55 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v9 4/4] MAINTAINERS: cover spm-memory under Memory devices
Date: Tue, 2 Jun 2026 16:44:47 +0800
Message-ID: <20260602084447.1100554-5-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: c01f37ae-af8a-40fe-fb30-08dec0835d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: K/jRQ2q5tCpruE7tdQ1qVEZchxJMGI+t5gmmB/2LYgDQv045PbkTNL4LD0XiWGJ7W0+M76zeU3MXTjabtNpTbJWLfMUXWoNpERVcoIM9Di5pnD5GiOdaMsZUduEnhMnkmw4Io+yA0keR6z6YCjbvRKJkx58emwEU3gEH47RCDTuhyvWoyxaOsIHjjJ2xMcs/5+yW3wvKsoGzpvg32HXeHP1bgIrY/zgFBd1mLIEuOc4Sp+YG0zVLTmA9+0HiGauMYB3vo+wvvV7Q+oj9hp0/xYVELp99w/jWGqh5jnY51qgMvSens/B5Krc3iFFDl3oC0P7Ly2LgqSswlqLIcyaKMqf+vvgf+8ACC92KEsGxxcllWEYdKP0TUb2Loq3MDB+BVSbHjh7aZWIOPiZaZ66/QUm2rLjQNwdWG1lxeUANTX0kW+h7aAmBhsidlbxGpORpZHOwVzOLe1x5oDmx4PqIO4U1BNKfskqQnGm1EEVPTsHUfmVd0IxZCuywNTcBRFuKkCUR+C9I4wsON+TtYCZwQfGI3FmYEoPNdBMaDA8ELkmD2bJf3149tlwy/9vQDVLBCrtcSto2teCeuoAkynRxNay6BOqyzCoD3yNUahkgNWEhmcjX6HVdKHIlXmkRnNCojIoBxDtvs0aGf2HIbtNVlXq+tU+/I69+/8u7I+oT22UJfmeR6odNkQUiBHOmI4GPUkt1Jh+rrerWdUC6OSsQnsKLKspKjG8LWVimOy13VjR1drrE9JSph2w56BtGz/PTOsqq3xTqqukaIKw10y75dLpOqBqTHbhyVBrGJjPqR14=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UMBDSmjjIxNVk05z8S6Tn8eruGBFdldLeBkYWCucX0CbqLIrvU6igWeKf5jPKrX/hq3GNL5i2KwbAIfVN6axB7ZJkC+G1TBbi1XJr6uQ8UEOMABmsR5F+9Hfdg2mkq+1gzslqpYtF7ylb6ekbCniaior0+SD5i4JsRebjZ/6senkZ5E7xPSVYVBorc/7jlWKtuHEHEZmoNByYhKOj6qQgm81pwNmpFWXX/lorCQN6Z7JN4zNfsVDhT14ypZxrVPvdnbfafAcAO6JDMBx8KRSPX/ZhZ++jiQAvlc0dUGLuEOOfNXwR7dbpqgOzBAv24zTeSoZi44TL8KgF8dkA+A8GJiXXM/l/a5OJareo5dbQsML7MGQfCiLey+UKwpULDsRm9zhG4Uf8rV/h/avbRjlgj8W16/ULI5mB547IH+SvlAYqUdIVQJsaCek7BKS+kev
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:45:57.3650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c01f37ae-af8a-40fe-fb30-08dec0835d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7752917d8c..876744b29b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3365,9 +3365,11 @@ S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/spm-memory.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/spm-memory.h
 F: docs/nvdimm.txt
 
 SPICE
-- 
2.34.1


