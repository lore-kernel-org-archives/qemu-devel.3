Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E455DCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0vc-0004a7-QH; Thu, 21 May 2026 06:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wQ0vY-0004ZY-Vf
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:46:58 -0400
Received: from mail-westusazon11012046.outbound.protection.outlook.com
 ([52.101.43.46] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wQ0vW-0005zv-47
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:46:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emrTqn4IrXBEP3+e9JLOuMlJ/9dTIDyWQZquf4F3mYuNG6qXwUdrhWu56bBzhYr1PG42D2VSlwpSfMM2qyurVbmmCs4PossBL6Q1L2s9welGWl1cqFFSlp5l5WfVj0xzIQZ7tRc8PNO97jYI9vv2bIxhPMWkqNIOMsA9dwm2KEBXfG7xnl/p5X4njkH5Ja+80fO2dGIQ3R612KQ9DRWZTrr7aqY1RE2GC9P2mNSs8Z1t/jPBer5Tp0rJnNis5/muE2kACd7DYkHOklAoSTIhg7shnvVh8cTrJHe5g4a/6g3mf4snr4EuFW4hUE3K6+LxZFtjOFRud95bO6RPR5n8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s0xXtJLROxiQuMAu43OEUSYi2Yd6kI/NFhQEWF8uFU=;
 b=bulGlvcwTzd3qwpcE2CHOD7wlc4PjquxJT4NZjj6nFBJBLwZML49fdwK+grHtFOrbkbKUQOOzRR6VDukQSOWBYMJG6DwE1Zo3Gt5KAV/RC2img5adjgFOgmdB4m78aaNDFJxYAnNU7Dsnw4IUTMBZMet4ODlD5R4AI5y/rVZqrsZ733szI9L6uJ1OZfrFiU/URKMZ8px3nIMGza2RrTeqczalAvcbQtA3Z8S6pZjsU30wgddfk1Bkc2Swe7B9/uPmI5GMON6iOX3u8MiEL3xqlSj1ZWpvb4LW8eN0ddKl+1jp0ckXx25L1KQcMujfKC+tO1QbTGEvie2qBqFROjspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1s0xXtJLROxiQuMAu43OEUSYi2Yd6kI/NFhQEWF8uFU=;
 b=S80uZQ4E7JDb4jLza9luu1eUdxrvKg0XYdtNMr1Sz52sDI8+Ux4Y/Y+AiPS7lXNIH8LWC+kc2GDcay0iYvkjpXnHHBJbEmm32QyMd2WhF/FCpI2NwCYb3qcjA3HnkJ2anvL6QLTSILFLOY1X/wR+ynS3Aom+mYgk8JsxV5ZasFI=
Received: from MN0P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::23)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 10:41:43 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::6c) by MN0P223CA0022.outlook.office365.com
 (2603:10b6:208:52b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 10:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 10:41:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 05:41:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 05:41:42 -0500
Received: from [10.65.97.62] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 05:41:40 -0500
Message-ID: <666a7ba1-5d3a-4732-b872-0d9fb2fe8461@amd.com>
Date: Thu, 21 May 2026 18:41:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, "Gregory
 Price" <gourry@gourry.net>, Zhigang Luo <Zhigang.Luo@amd.com>, Lianjie Shi
 <Lianjie.Shi@amd.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Subject: Re: [PATCH v7 1/1] numa: add memmap-type option for memory type
 configuration
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0995fe-2636-4fb8-9c64-08deb7258c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: sA9lJgr8mraUzoWC0v7scYWFPXt8J9ooure5GUR2FgfgmjUbJrWJriWM9nCnrhWJZCUfS2nXmuJkcfsggUy3RktMtOYvXqxGDfzIe8urcZf4rB3vpPoSFqPbxb7v3WKCzBnmM+7NMDr1H06UInDZEKbKWLfz7wV+6e4ec5LQOx1YwB8bGI7aMYycNNGoan/e99fG2cWfrnmzyc+eQNlSNwh1bMeb9gOIssarws03ouByQ80ELmyuEPxMSIIuLJ8yBaafuxLaRcwjfxfGrIsmArVbLT9hjxZLFtq+2/xGjTu0Osq+RWsjRQN4RBRUd9Vc0K2VR0x1EqWDPYn+pjcLLNPC5S6puzAcXc22acfLq98yeQjYjrYaNw0D4PEGBEV78ACpZjwBNnOjonmyESLMVuBaq59OLsO5siA+mbmeeuuYAIUW2kkyDX7exxyoV+0nqvTeKXLMq55xe0G/fNRq5QtjkdxYdiODq86xPFFgClMawtIVjn/OSEBidASmQo+VvqtNesF5bZuv4FT4wkl0cdCGdhNJSsyL0W4TEnk/C8/mupguLBvuFwhiAQOLBy4VKXYn9TqSAjaiQzfn39JtMUi0ZREByWoYgyrR29xIAT94ZcOYoWOCu7QLs++nJXcQHyIxMUO9qjBSwpoAGwMg7H5Rxc4NoouyOgZZ7j4NF3+O+t6UwM+2yEJDGP2Pblrm0YzYPV3MfWhPZhJI7SqzQH3TRFlb5069jj1Z9IXuHzo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M7rYfLuUWGk9IVGR6zdoohGS38vFdOhVuWDdmDF48t68um6M3rrYYmjEC2eoC6mmJKf8+hl4QpJpUrGUZzVeFBiQSie92qyVxbxpd9UzUpT+GK2K7ev8dj5mm8BpNFlpibFTycv0OTeuprSrOh+nzOTNm+I8q4HYGsLjPMSZzm6cP7SjDzTWJ5sN7cYMQ1dcFyPqzENZ+BZLQfKLq4TSNTkwUrncAGAjokEz6wLEhXvN71cZ3iBlvm8NY8AjgpVYFC89wllowhLPbwSBwrabkCUdXjikGM1HAkrzUFUQ6RPRQVk7FtiC0UOVOdHIl35pEnjphl1cj7Z/hx5K+IQ//fKAscQoPq67oqU0IUdcs/eSgqkQJ+guAMd7esbICNYlN7U+5kO6BdBlITl5kvw75SXIf4WBnhzehJLamsTOMCGlgsWOMoWEtdeYXdXAbj+M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 10:41:42.9509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0995fe-2636-4fb8-9c64-08deb7258c5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
Received-SPF: permerror client-ip=52.101.43.46;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Hi Igor,

Thanks for the candor in this round, and for laying out the
architectural reasoning rather than just the position. The framing is
clear: an RFC with a rough prototype demonstrating the device-based
approach, and the interface decision after that exploration
converges. That's a reasonable bar and I'm glad to converge on it.

Two of your clarifications particularly helped me converge:

- SPM belongs to the memory-device family by design, not as an
   extension of built-in RAM.

- The v4 -object/backend-property rejection is scoped to that form,
   not to any device-based shape -- so `-device spm-memory` doesn't
   carry the v4 risk forward.

One thing I should mention while we're aligning: in parallel with
this thread, I've actually been prototyping the spm-memory device
direction you outlined. I held off bringing it into the v7
discussion because I didn't want to muddy the interface debate with
implementation specifics before the direction was settled. Now that
you've made the path explicit, I can share what I've found and move
the discussion to the v8 / RFC thread properly.

A short prototype status and a couple of architectural findings
below. Some you've likely thought through already; raising them so
the v8 thread has a starting point.

(1) Prototype status

A working `spm-memory` prototype inheriting from TYPE_MEMORY_DEVICE
-- end-to-end verified on both SeaBIOS and OVMF across single,
multi-instance, and mixed-with-pc-dimm scenarios.

(2) Umbrella overlap finding + proposed mitigation for your read

The umbrella SRAT entry at acpi-build.c:1510-1515 (PXM =
nb_numa_nodes - 1, covering the full device_memory length per
pc.c:615) overlaps every per-device entry by construction. Any
driver that first-match-by-PXM via SRAT walk lands on the
umbrella's range rather than the device's actual range.

Mitigation in the prototype: in acpi-build.c, skip the umbrella
when every plugged memory device is TYPE_SPM_MEMORY. Empty
device_memory and mixed configs (SPM + pc-dimm / nvdimm /
virtio-mem) keep the umbrella, preserving Windows hotplug /
Linux <4G SWIOTLB. Verified in both directions. Honest scoping:
mixed mode still has the overlap, so this is a partial
mitigation.

(3) Process

I'll prepare a v8 PATCH series along the lines you sketched:

   - spm-memory device class (TYPE_MEMORY_DEVICE base for first cut)
   - drop the `reserved` enum value
   - commit message with the bigger-picture rationale

I'll post the RFC on qemu-devel under a fresh subject so the 
device-based discussion can start clean.

Setting the v7 memmap-type discussion aside accordingly. Thanks
again for the patience.

Best regards,
FangSheng Huang (Jerry)

