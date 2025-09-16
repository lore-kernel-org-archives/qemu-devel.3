Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C029ACAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 07:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQGv-00053u-Lb; Tue, 16 Sep 2025 03:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyQGu-00053S-6C; Tue, 16 Sep 2025 03:38:40 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyQGn-0007ce-57; Tue, 16 Sep 2025 03:38:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tH45Cd6geNGLYXy4+A3vyz45kwilyYo8tttyhFm2pQ5phYpjXsHJZzjnHIMkj1jvXnfqUTNSt+ygb7ABYlWBBmjO7vi+1cB8TJS9oOCYmmMUtZibtou0cP4Xm3BBVcuPzuFaM20st8X835SPt9nRF4q9JDnZVVfrVMHsMSfQhtjiXgvQs5mfLFVNJWDc3z1BNiwTF01+l4qh3IRIOYWedeWQxQeJQ9JxstU8WcelS42fqMX628weLboUQyiPnM+Lpt0X195wmss24USk3TQjUbiKwshcdqTRlvuVLVALvHSPiUQhLy2RyqcGMD3P0Mp+4TktOtOZMh8T7BZgeMVrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gwvzXn4WJMawCHx35Ao8Qa2BJQqhTYHg71o2ieD4N8=;
 b=tx3/5nafIUA3hCbx3wcsj59PB8WqXNMBeF0KZ3quC0OvhaNHABjyb4fmrqd0ptnbrFpXxIvR8SO/T762EBNWCbtZ3UTqCie41BzLX2nHEW1A7TewsaK27gH65KpRcG+Op8R7nispZua2ySSzcewAEwNGzbioSmGBtn6eN3DgpWznZDdDd1a+QpHlEtozDIxTaCw5oMs0n0GGObYxOp+3L8MiP64/pTkMowCgiArNCFVBJDodY1vE/09zaRIhQZiBsT1l2u6bcXm+y1byRRZCJw85tZ9PA9LTy7jX0h+eXX2cWOdbu+QIaFUJVrqL4LuksOOGUkiMeNWNdw0bs4bxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gwvzXn4WJMawCHx35Ao8Qa2BJQqhTYHg71o2ieD4N8=;
 b=F32ius0uMOZlw/gKhuwRIkhF37lmC57zqHTdOrZ4oqa7CIUGGjsSesE+6PZy0CaVSktT5YeGJOMJj4fINddPfVrNzacnWq5E6R8ufbzvWxhfMBjQefLrD5ZDO3b4xRrL+6c+QFxt7yaF4IrrVQmMXOH8E0CHl72zdu0YzojUp5A=
Received: from BL6PEPF00013E10.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:15) by MN2PR12MB4272.namprd12.prod.outlook.com
 (2603:10b6:208:1de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 07:38:25 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2a01:111:f403:c922::2) by BL6PEPF00013E10.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 07:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 07:38:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 00:38:19 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 00:38:18 -0700
Date: Tue, 16 Sep 2025 09:38:12 +0200
From: Luc Michel <luc.michel@amd.com>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 04/47] hw/arm/xlnx-versal: canfd: refactor creation
Message-ID: <aMkT5H6WdairAaaf@XFR-LUMICHEL-L2.amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-5-luc.michel@amd.com>
 <aMRZCBCAZLER7uzd@zapote>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aMRZCBCAZLER7uzd@zapote>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: c68a70f1-1205-4fa9-752f-08ddf4f40522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMJmSW1bNfo3yOO+YHLPA1ed89baPACO5A942fswlf5i0CRaIWYo56s2+7Up?=
 =?us-ascii?Q?ZfxVSKb7HB4/JtV+WQXAhIy+8mFEc0h/CrkGjGy92xdS88FYWlNNtk6FbN9E?=
 =?us-ascii?Q?gOmzhM7mMzqbOa8I2UTr/95QbQbRo7exMExNhxwy5hYLRfwUTQo8sFDsmC3G?=
 =?us-ascii?Q?/22SqiYUOxBvIp/fitUofu7eBb3+X3atTaFUGGM+k+8e+pRy1qjXd+WKnxLT?=
 =?us-ascii?Q?nk4K5sKutdG5PScxc+gL3ijTUNhTud2AW0nmafhtuvpbs36Hv23zpeQNQpu4?=
 =?us-ascii?Q?CgIT/JPpIVdDuUZIr6OJu2OlRW+PQZQCXt3+FlrwU8SK+CfkVva9nRvaXCRg?=
 =?us-ascii?Q?S+HSdxFLU79flMTj17hObTtXEobTOw97d9eYrfZvyrXoaEVN6HUao/BjFSdZ?=
 =?us-ascii?Q?miB/8p2waYHhxDxXR5JvTQkHaho9P9dDnO+3aSWukj4KmqBZIP3ViYW93fyj?=
 =?us-ascii?Q?cKwvVVRWIHEsWxeS1ZlOlTpdb+x5v1hxMY+vTNm+o6Cr4/g9qG2s0U28OZs7?=
 =?us-ascii?Q?tLBavPmR1IyHaEgjL8JN0/fvjG6IZZv8HMur3uPljvxpqtvKQ6I3iJaV6faP?=
 =?us-ascii?Q?pQoCOuXUVM0+FzQ4UcfRCSGwaEpppyNL53XpznM7SmilOHuEsoB5dzQmyGu/?=
 =?us-ascii?Q?E6Xa5CJ5btEpP83vGtugJPKAdQEg+K51q4BgfNMGrG5PsfQP00f78S5Zf+ne?=
 =?us-ascii?Q?tHS3HxoIx5rMm+GXltM9Lfb2msT5g5HdhS3Jh2EVASFtSdMfhXz79gs983Iq?=
 =?us-ascii?Q?ni3i9hLGJCuqcEgvlpeTrnLHP8brXYTLWlli6HVFAlsnHjDoFHjblTc4hev6?=
 =?us-ascii?Q?udGhD0376n400mxcRSXjyz5nAaNCvT+8i9uQll2yKzet77jsK/iDYDYTarmA?=
 =?us-ascii?Q?x0QbjLW4HGo5e9w4N2Igh3ZTzrp1oSg2U0LaowaOsbf/UlXwzclK8hBLadNr?=
 =?us-ascii?Q?nZCaZZC3sZDrHTE9bbpq9+LeCtCtpzpB6FgrlkbhCKBYHEieesdJzG/FzTHk?=
 =?us-ascii?Q?y/9FLn1SLHaFjRHEXIQUd5QiQau1P/wHDAb7G5X7kqPAj/ASaX8f6R2FytuI?=
 =?us-ascii?Q?0lNdF+lT6I3cb7YreUeSliJJIWDCzYEXoiXEJ1Ax0Pf5DfjiF+TT0zrCQd6s?=
 =?us-ascii?Q?ukNHG7DCNilwxLlAWNi67q9Gw4GVNKQvHwL8LuzyJyVE/tTCX4pHi5rc5ICp?=
 =?us-ascii?Q?mxRpNnVAxzHJGiffJ9zloqjsa5BA+t7YqZ9ZuZeHfAdGxPdXUvoFdy66vGJ8?=
 =?us-ascii?Q?CPSdbH2hS7yDYkC3jttezsOf13uRQQa0zGEvnn9N3ItDMyFnlG6vN54QWYLx?=
 =?us-ascii?Q?Cejeyh90S9mtsfM46H0iSKR1xrUZutAIHE+y6VvNpKrXlvU6aK87pxF1j7w0?=
 =?us-ascii?Q?4XWV4fwAAHBfLOuZgQ+HmOedIbFmSa3OCs23xvZxcXI5AdPV4houDWooK90+?=
 =?us-ascii?Q?SwjshTEHqazLYJyPyJfw8XUG3lwIRpjgh/iAmUDG9L3qTokjnvuMGHDMohya?=
 =?us-ascii?Q?+XWODba5kMhD2XAk/YqjL5tU7kVxwJg+82KQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:38:25.1261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68a70f1-1205-4fa9-752f-08ddf4f40522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Luc.Michel@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Edgar,

On 19:31 Fri 12 Sep     , Edgar E. Iglesias wrote:
> > +int versal_get_num_can(VersalVersion version)
> > +{
> > +    const VersalMap *map = VERSION_TO_MAP[version];
> > +
> > +    return map->num_canfd;
> > +}
> 
> Is there a QOM way to do this? Like a read-only prop?
> Or do we usually handle these kind of things by non-QOM side interfaces?

Yes I think it would be possible but again, I don't see much gain in
doing so given the use-case here.

Thanks

-- 
Luc

