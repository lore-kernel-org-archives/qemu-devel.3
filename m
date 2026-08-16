Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D42C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvai8-0001ck-L5; Sun, 16 Aug 2026 09:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahz-0001W8-TW; Sun, 16 Aug 2026 09:15:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wvahx-0005TH-Rb; Sun, 16 Aug 2026 09:15:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsajT0qiZdZvSc0z8ZKjwBTgOBjlEWZaNFtDtz4a70hms6Y5pk1eAyXYItGrRwmFYX+NpVJc8b5SngdXXhpAxFrP93NUGG6QfFq2qawivDAfGkT24AMWmx7dJYgtykVoObT5Qk9SkxNmSlAKGXbxpaMiRbieteHHBVEkt1Dck9XD7QZfVr9i2EV/EgGuRsWrwJ4R4CpA8Ch8YJGkFqAXY7RHR7i6gyyOW/wkR3kJAeWCKSOx7EecuYdhseC8+ZBOWFhYGupPZdvSU5fktDWVDkANgZoz8EAdHrgn5J7QccO/Qnff/u0ZILD6sB3wcf5UzREBnRHAkIYO66scF2QOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn0C3ohsq8SJ2T0Y6dvew6X98nn+hPVXNsnhDAMN3a4=;
 b=f8DyYi74PjP7c+Aohl5AMxQQzGltT8BkrEQwXkp90LkbIksDlqWjfuQHXv7mbJsZc8X8NTD7iV5rSb6d6ipJvPZbUfYrEGnGvYAlHp8UAPwa2dJ7NlYKQBqmn9U3P/eYgyompbiCK3gkByJp8ryDpGR7ybHmf4fbt5enQoYWUkgLeLsTk4eaA4K3bKAYJTTBeNKYyaHUUIcfIazZmCFNl4Iie/EVRK+j+Q0Y2+46Ig26jGl5gvKQDYEVz1cLhKT0yr2HHr5nF+7owNanHrvaHtVn0GwZ41briDenVguhRw03dOzF5wQldsddBi22itD4sYIsyvUkcwbJBD2yAo3YLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn0C3ohsq8SJ2T0Y6dvew6X98nn+hPVXNsnhDAMN3a4=;
 b=aAtrfIGGHd4BCt/hnWCZoYECHE2hGmD8aCPE5s9V55UAb1y1SZ7PkKxm73p286uV9Lbxw0H3mDgxJez6iFS8IoTOZn0DVNCbTbqceYIrglrUvNkjOXNfJw7cF21HE60dZTJSp8mPJjaWG3r0DPYt/6sTYlNPWuQOu7cOYT5ND4w8tsiAMrJ2nRw5AIqbWBuMd53e5vsMHnHzd8JqGCdxY+E6jG23zgxLhov3qM3sOIE+idRwJxfE7iituFyITyMDE8rdow3JUZBvygHOqrbnL6I3EEFjSiO2coh8nGqrJgHfa7fTstY+MXUE4tEVT8LDKzjy/OJ3eFsLZsC0Y+lI9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KUXPR02MB9310.apcprd02.prod.outlook.com (2603:1096:d10:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:15:17 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 13:15:17 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 05/20] hw/arm: cubieboard: Store boot info in the machine
 state
Date: Sun, 16 Aug 2026 21:12:35 +0800
Message-ID: <20260816131300.51799-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816131300.51799-1-bin.meng@processmission.com>
References: <20260816131300.51799-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KUXPR02MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6b4277-2974-4916-2ce4-08defb986a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4hJFxYfZXaX9vb4P877JTzM3EpTTvDyoCb5KZfQ5rgWY00kOtZN2WNT1c40youHYlJCoUL1gc/0Xk813y8bNjpRca0V+moO4T68aNHTl2H8mX/VRtnLM3xJOgxLp3/E7xJpFjCUk9NM5NN0lCsC58SqJmB6Ow19EcRd0Mn7ytlPLDqmFKndLz6g68WwLquWJUmpucxnfHWuR6ugF9WyWnQs24NDVh7+CFQSgYLgjJ3r1OF7UKi3UbQF0AsNnKd6ehYqK197eNILO+8eXjkUc09VuS+Bf/R61YSMuioQRq3ZS/t8SOoh6iYByq5wuu1Mn5bm0BbZp13U4WaUDcqz4ATGZQirU5CMjDOv93l9w0iIImf9Gv1f3/z5Z4iSBkIjOw3g8rl8DjkvqE7r4u1SkSa7PHjB1DSNK6fWTWShKnXZ6udMRcsn0+9Nsjbmx6Ond2PqrP7upoIDAC9lZ5gUGSLf0aNk5qP3cfPrbiLryZlKS1d5h+YCXr2jt3t6mQGvd7k/HOT85TRDR/Rd6tmJv5W3bWZd49q4KhZH/iYYab2daLJpfVPAEL0Vu24sB9KcpwVaYoOA9IHmpHXRTJSQWXQQ/pr/RWyBuXMnFUGz7x7IFlVf7tt67+njRg8oHmpNI1CYgbW24S+AmSoOmsHh8N6lOdfqWjJsSBYlRN/P4I10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rTfpPAs7of/2GPilyN7mDq4feKRaDQwToNQsq3sVuNz7CXN5RVvL2SnaNIZ3?=
 =?us-ascii?Q?Do+o+PKkjQ9XlIr9OwiLkBGeKfXA0Bht82laG08HU+e8E2PxdtwXq37Maf42?=
 =?us-ascii?Q?0+SNQ9ar4OvWir73rskOccZ/2QDOxrFLUc/wq+NPgRpFN/J4496WpsmnzsBE?=
 =?us-ascii?Q?bA+kG4aN2PW+MkYQTkJR2r0LOkEgvCXbGQsNPh26+bKybWZCQAoVF76PDABl?=
 =?us-ascii?Q?fUVnLnV9duQdk0dNG7jlJI9ah4dzHpwrZgUVsFiFUyQzUYMLJp6xn6K+E0C8?=
 =?us-ascii?Q?U+zD8n3qU3dIcS08AGJ3msLA97GLX0Nv8pD7cwI8wWIwtDFk35aLYqtMVOBw?=
 =?us-ascii?Q?LitNfwkddZPtk5qhZyWQ/c8Jx/DhpIcj0WLSe5zcI3I8+CzbC56dnlCyW2YD?=
 =?us-ascii?Q?+Kjg5sKYHza4QMIZnKypiLtyaJaBg18mu2sK0VR2NughBu8QWsn2YGP8eZNN?=
 =?us-ascii?Q?HV+Dw1zX+x2zu8KpVAEx0JVGZHJz8Y6QJtwdtoLzlX6U1shtrny3S+tQ8i9e?=
 =?us-ascii?Q?B0Mw+AdKMW7eXIDToqEkc7TtIa0IzG2MO3N8eP9OU5Bz286qiyyYE338Bbyl?=
 =?us-ascii?Q?RpHVmr5dwtzcU3LQYbtphjbsZNizNQz5Gi9Xvz9Fn9ST8Mn7zLC1JaoSDKls?=
 =?us-ascii?Q?7NzvhYUZEcCyVDbfM5/SMewf1MwAFPX9BtIapFT+x2/qEldhTkWEbnWGS/ca?=
 =?us-ascii?Q?7/ZCC+SSJqJN++5wTYSpj5EhvMHUi4O5YXuq5yUbXcGzON3JCVYaFk7QYqST?=
 =?us-ascii?Q?O44G9L2OKEf8wsJ8mQ74fU/Sk/9qELjeRzounweqonzpuWlvxDutScgi8jQQ?=
 =?us-ascii?Q?Gld/3ySn1vhSYnoWqG0OW/421Pmr+LjNhumHjGHIvTuqXkNXIILFJ5QGjAy9?=
 =?us-ascii?Q?/25ZPF/g06CxUW1WKj2SfMh0lDwotF0m+dmzYRs6Y5gUMlVe2IW0skTlk7wZ?=
 =?us-ascii?Q?7dbJh9n/+4iozisz/waRyhip6DlLLLjtjBwlMw4GlAZ0kjwPnT8s1eQQf4oF?=
 =?us-ascii?Q?b/0mnCcqn1YfJbTiFNflm0b+vGaC5IbmfyEDgKw7spqSNnazqaOhv3N5r2ez?=
 =?us-ascii?Q?YChX8ioHHOLBUHK/YBnXmHJaNbOoQhcOdq7xQ7GYMtQ+sd3NOhSdTTScVhqs?=
 =?us-ascii?Q?H4BBlpP0KplHX6YSa/IdvFxGqy4xQs83F0ujfbkRHj6XrOunalVgml0x4IBi?=
 =?us-ascii?Q?vHxAjtq5MbfX2lF9Dz6rBJt3XQp+9sfVcGYDbXYCAJ2QQBW5tuwJMBJxlits?=
 =?us-ascii?Q?zzUBPT3HssQtFxE9cj8s9+4i8YW50OSBXx/DVmos+qyWcZ8yWlkjUcCHF53S?=
 =?us-ascii?Q?OhesODzfxgjSsjpAtilZLoljbepiYc2hXbEcq8lQCRSFsBZmXYPKXKFQqRMG?=
 =?us-ascii?Q?12cDroJy9UtSK1hqZZb1ZuOL0ZPsum7vgvJaQCwyEjMWRX91Qpg8FtiyA8Y9?=
 =?us-ascii?Q?xl6lz92NgIqTOmaI+4ldopfJ86roKt9zZzgG7y6iJJNvPrM1tJ/ZIATnewJK?=
 =?us-ascii?Q?EnVxVbNEo00QimEE2Rk6ERrj9h+OSG7HkPdHC2VAtzuATB6YQkmlLXnNT0lF?=
 =?us-ascii?Q?hrDXh6SO2k/UtKGUnQwV2/wwBxcY2mpeZg0eNHvUJapyC2CvV+8fri5hDA9m?=
 =?us-ascii?Q?1+JN9Wy5lWJCO9letqXXidCNi1AK/OxXw22jaXOrwK7f4OHhTP1kajm1QDzO?=
 =?us-ascii?Q?Z7wOfeFXXyme0rSnK5T+7AMDG5zThMd3RnY0VD/6NbV9nLhqKnVJVoWb3JEy?=
 =?us-ascii?Q?ujloIDMy0EeiBUnfyMKcN6WwrO9Y/lo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6b4277-2974-4916-2ce4-08defb986a3c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:15:17.0467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c13SU9//ZlqYek9fHUv75Txx9RS447nAHNpKLSI3pmyl1p1LeyUj373Adum2X0gwXKo7fnTQp+lTEqkLeMzn7Ev7ZIJ+jSEVyBz2uGCaJIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9310
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move it into a new CubieboardMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/cubieboard.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index a643ae4e27..d59c1ebba7 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -25,13 +25,18 @@
 #include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
-static struct arm_boot_info cubieboard_binfo = {
-    .loader_start = AW_A10_SDRAM_BASE,
-    .board_id = 0x1008,
+#define TYPE_CUBIEBOARD_MACHINE MACHINE_TYPE_NAME("cubieboard")
+OBJECT_DECLARE_SIMPLE_TYPE(CubieboardMachineState, CUBIEBOARD_MACHINE)
+
+struct CubieboardMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
 };
 
 static void cubieboard_init(MachineState *machine)
 {
+    CubieboardMachineState *cbs = CUBIEBOARD_MACHINE(machine);
     AwA10State *a10;
     Error *err = NULL;
     DriveInfo *di;
@@ -103,8 +108,10 @@ static void cubieboard_init(MachineState *machine)
     }
     /* TODO create and connect IDE devices for ide_drive_get() */
 
-    cubieboard_binfo.ram_size = machine->ram_size;
-    arm_load_kernel(&a10->cpu, machine, &cubieboard_binfo);
+    cbs->bootinfo.loader_start = AW_A10_SDRAM_BASE;
+    cbs->bootinfo.board_id = 0x1008;
+    cbs->bootinfo.ram_size = machine->ram_size;
+    arm_load_kernel(&a10->cpu, machine, &cbs->bootinfo);
 }
 
 static void cubieboard_machine_init(MachineClass *mc)
@@ -126,4 +133,6 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("cubieboard", cubieboard_machine_init)
+DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
+                        cubieboard_machine_init, false,
+                        arm_machine_interfaces)
-- 
2.53.0


