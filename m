Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62013C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3Gk-00083v-En; Fri, 14 Jun 2024 05:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Gh-00082p-S9; Fri, 14 Jun 2024 05:30:47 -0400
Received: from mail-mw2nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2412::609]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sI3Ge-0006ue-Fo; Fri, 14 Jun 2024 05:30:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYEesVSzUTQTAkI7jW2O9FvWQH7m7aSybWZBxnaaT304zKTCmyr28wvtw5eIJb3vRNTnzPqx9BojcXfirFj1YXrhsTlu53cRmeCGos6GFSkCW0EPoCd3p/5EScghu983CPJWBFplxLroFKaVakYgPGVFNXzuosvEbN8zLa64ZMpow3aQVuTRgBTxHaEjWKWAj8h/kgTAhuy6v0fXwvYbod42fVBz1xnDT1qNyAWkDPIWos43RSYiCnXl2QY5xbI58AykKd/GnLl4E1OzpN/5QBs0CZlObjJ9rVzc10ARdgIXMa/ftRyQJFUJLkuTg+riqI0m9MKXXRautS3DwR8/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4aPXc8ioCOc2fg0KuFegWqZExg2QQe+Vp0spLVQirc=;
 b=bUBOVc08EaMszQo1Vyofr8O3HaWhLV/uAkRJGfmkOacsQYXr0jlIoFjA7LthQikCmZ+uswmRkRuYylDajMqhvle9rbq8Yp3zgOhIhRcHLdiDyEJ2oLbEnOMaBDMf8DNQA/lgXMNv/7R3s9J1+ogHj/s12hk1pIhmf4Wejcs51DN6D19Iu/CeNjdOKCZBiC0zdSV5EcKnyO0xUp48qo2+hkYRTdiTIw0lO+Zuu3kWFBF4ERsBpQwtxiXdulpjtUPpXWtGpDix4+10x0QXvC90mGnXmpXJouWUcR5Vjk2ous+HZw1xuxQeysxQmk5LQHmr38EpoaW2ZSuNAojeZcAStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4aPXc8ioCOc2fg0KuFegWqZExg2QQe+Vp0spLVQirc=;
 b=Y7gJkHsYn+UWj9sWY4CN4JUZ0l8rSAJ7l474nDvNu+ptyI+NNxH9ocde0mwE5npIthDr7xb1u9shiBiKTFiPWd5b56B4uMURwf/25bDSThEZPe7jUfDzUC3fk5xy0VOAWo90uRn2CdHUrirZsAOTkv0Fpqlvyz/MClyB0GtGR+g=
Received: from BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25) by
 MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 09:30:38 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::f4) by BYAPR01CA0012.outlook.office365.com
 (2603:10b6:a02:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 09:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 09:30:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 04:30:35 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 14 Jun 2024 04:30:33 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>
Subject: [PATCH RFC 0/3] Add DCC uart console support
Date: Fri, 14 Jun 2024 15:00:23 +0530
Message-ID: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5bc143-eabb-46a6-c791-08dc8c54a62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|1800799019|376009|82310400021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yVu5Ccood6x43MCFS8smPhvfKBk4wb/gJgUi0bK9PqtcIBe36qSTJ2+X3vHk?=
 =?us-ascii?Q?k90Q/F5pGDnY6+FZfKd5zLJ6sb/jQYXxjwtGb0cjM8NeWLdvUE8WlsHBGa6t?=
 =?us-ascii?Q?VYoWRFuXEK7zJJtmMWbZvkzHveK5JM+5qS78mhgggRX/sZ1PBmuPjzjPkiZf?=
 =?us-ascii?Q?uwxw9Rv+a+Pn7qW3ans1FQ/wTJgjvaWQc8KN0HpLqawEohjmEXCCCo3Rra8r?=
 =?us-ascii?Q?xm7Ak1hRKEjh6pHaBszWhHvKEob9BpIg5FBN5YPFSofKOy+PV3bhUTGhrwNk?=
 =?us-ascii?Q?srLDiBODg4ITzQYjndSZZ4a1BAZqRSkrDU+LbPp6oEgSPQ2YYmO5TliZSivS?=
 =?us-ascii?Q?m2T9bG5vqVweUqY4ri/98m8W9in3FhM+p+BpYUAe2NOKd3MO/32/SKXCE6dd?=
 =?us-ascii?Q?JIBAz6GbZcjAogkyRPmFAAyLbv/ZypKdD2QXqtDvP5FlXkaopeU/I/saQtHz?=
 =?us-ascii?Q?6mJbfggD60D5OMCmvkggB8NNp7TpnnJmtVNN47a9bgFyfYeh5OH1ZW+c0NfB?=
 =?us-ascii?Q?muz1mI7pl1JD6pKNWORUzwUpapwNtGrNQp6p14PCy5w+Hi4+IM7GGWAlgXLd?=
 =?us-ascii?Q?WeclkfjDgOnyLIIsYT1ha56kyIpmnPWuj7cGd9U72GzL78Mc6otRW9qvSaYT?=
 =?us-ascii?Q?56InEWxZwduMsVZRja2gpqExuBOhB7fX7y1V47lgHZGMjrfSOOFX4QpetvQp?=
 =?us-ascii?Q?iwhf/ww9xUw3tpbNS7D+PPsGBsMt+HU0Eb3IcVFvNu8Tbn6ANgYKuI3muD4t?=
 =?us-ascii?Q?bDH6ZAVUiRRdlypDXcNKmyHra4Gg5P/Jgc3S54dj4vAqLHB7F7FkvYZYoViL?=
 =?us-ascii?Q?RG4HUY4iQWtcnM3l83R0fw176DYWZyIaDbGqmcZf//SGQQe5X4YKnzX4R0f8?=
 =?us-ascii?Q?N7wSvKV1xoETcD1zL9g15fFqGRGSRys+luDD+/vE34jAEKMj6SlDDE0ggRNu?=
 =?us-ascii?Q?jY1DOTyRCE+kwBqIJWBJrXGDJvs5zsRhh0N9IawJpRg2c4bK7Ga5TrrY3XAE?=
 =?us-ascii?Q?XYutWG5MkExetO8j/3eaNzv3tSpBw/gwdAtqlAkOEBKkuhj4TaZNpgXoHY3U?=
 =?us-ascii?Q?/5qzG9SiHb98r4wKc3VsnfpXPosukVX4ep7MuCtRqIb2QWJyX4Uqvf4+va6e?=
 =?us-ascii?Q?fFUzSOJLupvA7pO5ZtFUqPWuvMlFQ6hu+v4+J0TbLZtR8hZIFCI5qk783LE0?=
 =?us-ascii?Q?rUjFTTheBe6StRBNPDg+7X8vFjsCLOIfanzgW4IqNgqpTG8rkZHNC6z8v3fi?=
 =?us-ascii?Q?hJcpOwYtaEsSUt7WjzeHipnNDo3SShHlGPI75ZNnhe5zabJO23ym7b7bCp3M?=
 =?us-ascii?Q?agS+knrdTRdZ4rmfjFkqPrMmVSrO1fZgSfFJPfuEkAtkpkoTNUnGFGi6fYkT?=
 =?us-ascii?Q?JzPu6BbC5UGYm+gGiCtGOReJtatQjANueMEbsgC3d9CY8uh/Kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230035)(36860700008)(1800799019)(376009)(82310400021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:30:36.9449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5bc143-eabb-46a6-c791-08dc8c54a62a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
Received-SPF: permerror client-ip=2a01:111:f403:2412::609;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.145, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This patch series attaches a chardev to  arm Debug Communication channel registers,
As each cpu has it own DBGDTRTX/RX register just tried to hook each cpu
with chardev iff we find a chardev with id "dcc<cpu-id>".

ex:
    Below chardev switch would be connected to A53-0.

    ./qemu-system-aarch64 -M xlnx-zcu102 -kernel u-boot-dtb.bin
      -dtb zynqmp-zcu102-rev1.1.d -display none -m 2G
      -chardev stdio,id=dcc0


Sai Pavan Boddu (3):
  target/arm: Add dcc uart support
  target/arm: Enable dcc console for a53 and R5
  target/arm/debug_helper: Add fieldoffset for MDCCSR_EL0 reg

 target/arm/cpu.h          | 11 +++++
 target/arm/internals.h    |  4 ++
 target/arm/cpu64.c        |  1 +
 target/arm/debug-dcc.c    | 99 +++++++++++++++++++++++++++++++++++++++
 target/arm/debug_helper.c |  2 +-
 target/arm/helper.c       |  3 ++
 target/arm/tcg/cpu32.c    |  1 +
 target/arm/meson.build    |  1 +
 8 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/debug-dcc.c

-- 
2.34.1


