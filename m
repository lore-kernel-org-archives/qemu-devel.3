Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7D7C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 12:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9nZ-0003dH-Jv; Tue, 09 Jul 2024 08:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sR3yj-0003kI-1k; Tue, 09 Jul 2024 02:05:29 -0400
Received: from mail-eastusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c101::3] helo=BL0PR05CU006.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sR3ye-0005De-HO; Tue, 09 Jul 2024 02:05:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NScMd8ah/0r66jWno0u2TPdyv7s40uf0/rFfMjhh+edLeQMcWbRL0bUC/VNcFW+5xwq2oCMGUg8klEFhYWlMInLNthOq6ytwqAZoGLFjcM3EiEsZ+GWxNLeVA49Dr38GzoS1j0oF5357BCJCn0iWXzvwLLaXCKMmL0n+EIahd2G4jsC9DJlRqyYvTP7nQ/EBVRNHySi9ykcItQxNaK83K2wmGfCOUrmfLLggazd4ZxeCTmqDwfOXOEbDaJ0Oos3AKJL3/yiT1ukHoyRwUs2dlnyDwYBog1OdNunbN7luZUa+8s3RnBq7YRGysQwPX++zVXJWDQUx3BCl5sAB+QNdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2cRKcukKCWVNpDlp67KfDkVO2TwoI5+vukjMLxJhCM=;
 b=S60u1AfKpe9bW+jGHtaZQu1kuB/IXO8MWlN+LTeW2VVYVWx8llVpn3C2iArIBsu3YZd9Ry7U6tUGTpOZKTiA1nIHS6zCB3NKopZwnMoUbwjOn8j0gng9Z3H2wL5UL5w19UypsG4U7mj0YkMIbCqaqWa7wfvX3WVLuEQzenHEdWPH7Z4R/24jHedhS5sFeA8g/YVnQTlP9jMihPeou+Qi5iinMy07wNfFdTs+H91YCojJA97JN/kMmhquWD1tCO+6OpgFv5TIEvB/v144Lt2X9rVb/+2BAe6E1t5kjQY1mZt5QrPuR6dq99Sy1WmXVcdhOZ/Y8dm/Q9LBVkJylbQGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2cRKcukKCWVNpDlp67KfDkVO2TwoI5+vukjMLxJhCM=;
 b=gy0tzwUja4EyYKzZTMEhHHyEoQH6PjZceasMZw3uC7mICkz5vuZWpJfIoPxdXOCnCva+B+RRdPxgSgo/0NE+49Sk4/YVtZJkcc8pln57+SSZ9QObRGf0rZsiPquX3LCpiioVVvf7BhizUDsnz6si2Mog1tFjt445FR6ONzr9BnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ0PR01MB6477.prod.exchangelabs.com (2603:10b6:a03:29b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Tue, 9 Jul 2024 06:05:17 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:05:17 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 darren@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH] arm/kvm: add support for MTE
Date: Mon,  8 Jul 2024 23:04:48 -0700
Message-Id: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:76::27) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ0PR01MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3d3979-3db1-43a5-7fc1-08dc9fdd1b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5WzqLEcSDmKAXmeT6sP5sCrmIYfKr87lyloRL/OX/tGTU+q7ngkyRhYwz7Fx?=
 =?us-ascii?Q?liYc4+fvMV9rdXhqCcQ7MQNG2PXnIiHXJoAa6yPVip1VW66kezSIWfKxvgT3?=
 =?us-ascii?Q?yyKewJZh2+c1AbXPLXifloVhAySHmdzMKp9Hc1WjHvj8Tjw005dde9ILYomH?=
 =?us-ascii?Q?6Vfy9AgOWrcHY8XJlpMg+czyt5Qb6TSDZ01It1LoZQ2In9HD1o5IlOxgn4+/?=
 =?us-ascii?Q?4fgN3Nwwks8GAfd9JtaBY5bjuuNaixy6KoybY/wKoRFdRrffaKSlm4Obqs5R?=
 =?us-ascii?Q?tPoyT+7s3Ch9V2AVnxYY4JU5dTCDMm2yPQDcwk9rseTl2DNgEWlko5OXuUHG?=
 =?us-ascii?Q?uhGAlweJVQspvYP6wDoZOyklOyfrXa1Js+plJsrCocotWBBe55ushW5grEzU?=
 =?us-ascii?Q?9E1mwqnJ+tXov12bPB5pB63EKMnn5iwxnZvODG/P5XS+MyYOqT5HxEQAaVaL?=
 =?us-ascii?Q?TfTHKmHqJ8F+U2GOnqlfId7oWCKPBOkCibOC7P7zB3eWixUZaKStSBeud2oV?=
 =?us-ascii?Q?uPuZysZRBz93NsAA+RqpWtek2yLUMUC0X9n/82nWTlNMTdV8vXI8Z9+lfqxx?=
 =?us-ascii?Q?5p9K8XAVfIGDMR1BTWNH9agdEGQHZyEBmSH9TMeqkAMBnWmhge4xRkqWKZPs?=
 =?us-ascii?Q?NiDACZ10HCGlTbb5JgJsCJqRyaGEiIHuan50rFPtwtiq9u0E7PiIvZqCJ+a6?=
 =?us-ascii?Q?7KCwP8Kxzzx8symIIW541PY70XWnkgRkRaDxieJ86PLtphlZpPK4IK5HOMKR?=
 =?us-ascii?Q?c/jRG3La+bVISig8dDiNf8s+uMVQWo310a1h42sgLHsRAyxHdDVdwOItTy8x?=
 =?us-ascii?Q?yN+1uxMdop04NpHOrE29jJdGB+LLO1fL0eX9dM+WoDSnFtzdBhxDPSlA8lw9?=
 =?us-ascii?Q?AtIGwxjI6+GhnVb86NGmg4w6Yg/q7EdaMtqpm7fkRCgaNtdNQvQQAC8ECWBi?=
 =?us-ascii?Q?XAFkxAoMaWslClTil/AHiCaJRhImSxBtqK2OQHS+QFmFsu1FkmNXmukTh0jj?=
 =?us-ascii?Q?ilbvxKs4aOQ9IVWtILgsKcYS6Y5FAT4nEnDfFMvyQ+Wxgm/cz8Xhrxb9TAiG?=
 =?us-ascii?Q?MNHxRGyyAho4n8EFXCkHqhIynd5DRy8XGO1QdKgiYsqZdPUySWwBchcdRbJW?=
 =?us-ascii?Q?pgw1BIgee+9eVqmtTZre0AkRIdSSWcQ3RkxGxhFX2Qe6BN7srsMM/VKy5qyt?=
 =?us-ascii?Q?6amMH6WFwjujChPxQCtI3axs/LjMtowOcgdK1ij2sSnp0+Gv6REbAlI4NyBb?=
 =?us-ascii?Q?tGDw4lJYCSLao6tvNjJC9Bp0G4onZidwzs9trgYZ+Anwa9K9gIHG68IdtQ1f?=
 =?us-ascii?Q?A3t3C8SCq8cPZx5wWOaiunbffyqCYm6V9/dT3rjJFGmU9L86aape+dzI9qD1?=
 =?us-ascii?Q?G95J71QoZeM3T0E/mDaMsDxiQbuvWkLVjHBc34H/cCiaG+Z4MA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izBBkWLXYc2vsWyJJfWiEbVLbhX5TR7TU/4cjL/7165vR0I0sEDJ2v5f5eNt?=
 =?us-ascii?Q?arsl1G730lx/4qiUPhlP8JWdDOlCw0PG9RC/cu/r3si09XmFACHgxdBCDv1F?=
 =?us-ascii?Q?YWVZBwkTTjuVNFVBXOUMB2SCnthFUXHDe7YLBq4Ev9UCk14dnJM95xL9oXR5?=
 =?us-ascii?Q?FYNM1HGNo9YR8PMJheGUvUaQUwlzhE8e0gvzzcYb2Gw0xo5XwYe7hEWeTI48?=
 =?us-ascii?Q?ZUOKzWIPHntegX9aLvdGhZ0oGDdVOxe0EAAESysx8zWo6AIVbwAVvGX0RZR1?=
 =?us-ascii?Q?TICyMIV31U1Z2kR2adGG6LifM7mz9+Nr79meAvS/4HRrCTztGrExaQuplfMz?=
 =?us-ascii?Q?HyOU92QPA6pzGrG63fmWa+nFkHT021DVpFB4RGuGgFF+otv5eic8664Q/xGg?=
 =?us-ascii?Q?7z5XFEu4MGOtVDwCH5B/XEidMejMJOgKiCoc4fp+2XAld80bxFKUAtKV94Ol?=
 =?us-ascii?Q?ZrFXEmxEngCxRfgDGt7oIqBImWl3G5hQHXK4u+tLZlSEOkwGIcT/WWDD2RZV?=
 =?us-ascii?Q?umsQfwys7SapBFbtKAf7RA4ecuvSdVfXWD7CZdnR+IwvJecFAddogbzs5H71?=
 =?us-ascii?Q?XgpPIP82Er7xsmLwV3PVldcLT2DWYqJeA8p4cLr1Txru/ToVzWQTZtUCTuex?=
 =?us-ascii?Q?sodvgyGLYwYofHrDqdiQCRC6IPhnvf0Isi4wfWRFrmDpGPMk22fJtalY4mAZ?=
 =?us-ascii?Q?jF8vmofvPugP+WgERTjN/lvVAFllxlAvci7fG4DGNVDRy6BHPuA5NQNM7Kvw?=
 =?us-ascii?Q?AP3vYAhUrwTuiTuUESek/5lNStrB89z/Wvy4Y3FJOsaMndrk4CEoW64hI6qT?=
 =?us-ascii?Q?AlGeNBWLtRuVCC4Al5QjjwEAn6bGK6j7owAms2hZt5G36Q7ql4eMTAUJsBkk?=
 =?us-ascii?Q?Au+EjE4nOXFEBAK2PIgGDUh7QqMvcUDzEqBWvS8H1RP8q3gh5u+2NNM4Wbea?=
 =?us-ascii?Q?cFhsaxnKNrCs8O4fb7v0XFg1spy7Mtd7nBnZMfo9hPUgVhzdNquEFS39KJ/P?=
 =?us-ascii?Q?EvUaWhQFeX9xb0M31tnb9bo+04NBQyTm49sPnfGx+s0LKo1nNNYsGTKXLv9j?=
 =?us-ascii?Q?CL0zN2TDG5lD/wnAYb3OXUPKfJcz0G8cuebR1L78c0AI1AmjBP+MFfp8TmvT?=
 =?us-ascii?Q?xd/kgrvEvKJz5D6cIDZacmqH8tbrkZ3H4xpBkPwiWH98O3NFxE9PGXuTL70Z?=
 =?us-ascii?Q?ObXxmGYeL5i6ufy3FuBcpsqO92j/BGar4f59e8XI+Xko5hvIcaI7ZCwbdrB3?=
 =?us-ascii?Q?NkjUd3hvEZI3QEgbQSCGfHMR3z9B04yA392svTkSHlGd7JrI06ra/bZE+eSR?=
 =?us-ascii?Q?/JicnoC6kxnlBxuxsSKhExr3/HkjV/NEvwPaQKFExG6eU8c33Xn3OCGuqe15?=
 =?us-ascii?Q?o+Wr0uJoR4j8N5/Py2ckWTIfVXtm5dXr9ee5tFzWoKQTRbRUmuXl9IHNOR+6?=
 =?us-ascii?Q?mmAoXzW8SQ4qOXP3oybJ1IBYh/kRrllpw/xzq8Vr+gKXNKxDh/0Hbzyb81pQ?=
 =?us-ascii?Q?wdq2plxRFSeUTpdl7IMJJvJ8Xx+3BTK7nvT7N3tZH9bIfw719YmuMvRtovRG?=
 =?us-ascii?Q?M9C1+J9jdlngwT8Q/WeUZEJbJrHKraqW5YIDddjfile3FUM+uilKM4kxcm0E?=
 =?us-ascii?Q?WVoHiibgNw/jZltkXeFbKQ8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3d3979-3db1-43a5-7fc1-08dc9fdd1b11
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:05:17.1702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qu6BDH5taWH9yN31LoSSH3TEQFdnf1DVM6KPTiIKJZNzqZZSGLmkKKDQxu+m9o7DtJQU2RhyLdSwotrj+s87oANfh4ScSjkoCwkanqg50pRPvH17zv0/gJMBX5lKnnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6477
Received-SPF: pass client-ip=2a01:111:f403:c101::3;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=BL0PR05CU006.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jul 2024 08:18:19 -0400
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

Extend the 'mte' property for the virt machine to cover KVM as
well. For KVM, we don't allocate tag memory, but instead enable
the capability.

If MTE has been enabled, we need to disable migration, as we do not
yet have a way to migrate the tags as well. Therefore, MTE will stay
off with KVM unless requested explicitly.

This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
which broke TCG since it made the TCG -cpu max
report the presence of MTE to the guest even if the board hadn't
enabled MTE by wiring up the tag RAM. This meant that if the guest
then tried to use MTE QEMU would segfault accessing the
non-existent tag RAM.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---

This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
and default case(no mte).

 hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
 target/arm/cpu.h     |  1 +
 target/arm/kvm.c     | 40 ++++++++++++++++++++++++
 target/arm/kvm_arm.h | 19 ++++++++++++
 4 files changed, 102 insertions(+), 30 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b0c68d66a3..cc9db79ec3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2206,7 +2206,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
+    if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
                      current_accel_name());
@@ -2276,39 +2276,51 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (vms->mte) {
-            /* Create the memory region only once, but link to all cpus. */
-            if (!tag_sysmem) {
-                /*
-                 * The property exists only if MemTag is supported.
-                 * If it is, we must allocate the ram to back that up.
-                 */
-                if (!object_property_find(cpuobj, "tag-memory")) {
-                    error_report("MTE requested, but not supported "
-                                 "by the guest CPU");
-                    exit(1);
+            if (tcg_enabled()) {
+                /* Create the memory region only once, but link to all cpus. */
+                if (!tag_sysmem) {
+                    /*
+                     * The property exists only if MemTag is supported.
+                     * If it is, we must allocate the ram to back that up.
+                     */
+                    if (!object_property_find(cpuobj, "tag-memory")) {
+                        error_report("MTE requested, but not supported "
+                                     "by the guest CPU");
+                        exit(1);
+                    }
+
+                    tag_sysmem = g_new(MemoryRegion, 1);
+                    memory_region_init(tag_sysmem, OBJECT(machine),
+                                       "tag-memory", UINT64_MAX / 32);
+
+                    if (vms->secure) {
+                        secure_tag_sysmem = g_new(MemoryRegion, 1);
+                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                                           "secure-tag-memory",
+                                           UINT64_MAX / 32);
+
+                        /* As with ram, secure-tag takes precedence over tag. */
+                        memory_region_add_subregion_overlap(secure_tag_sysmem,
+                                                            0, tag_sysmem, -1);
+                    }
                 }
 
-                tag_sysmem = g_new(MemoryRegion, 1);
-                memory_region_init(tag_sysmem, OBJECT(machine),
-                                   "tag-memory", UINT64_MAX / 32);
-
+                object_property_set_link(cpuobj, "tag-memory",
+                                         OBJECT(tag_sysmem), &error_abort);
                 if (vms->secure) {
-                    secure_tag_sysmem = g_new(MemoryRegion, 1);
-                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
-                                       "secure-tag-memory", UINT64_MAX / 32);
-
-                    /* As with ram, secure-tag takes precedence over tag.  */
-                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
-                                                        tag_sysmem, -1);
+                    object_property_set_link(cpuobj, "secure-tag-memory",
+                                             OBJECT(secure_tag_sysmem),
+                                             &error_abort);
                 }
-            }
-
-            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
-                                     &error_abort);
-            if (vms->secure) {
-                object_property_set_link(cpuobj, "secure-tag-memory",
-                                         OBJECT(secure_tag_sysmem),
-                                         &error_abort);
+            } else if (kvm_enabled()) {
+                if (!kvm_arm_mte_supported()) {
+                    error_report("MTE requested, but not supported by KVM");
+                    exit(1);
+                }
+                kvm_arm_enable_mte(cpuobj, &error_abort);
+            } else {
+                    error_report("MTE requested, but not supported ");
+                    exit(1);
             }
         }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d8eb986a04..661d35d8d8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1054,6 +1054,7 @@ struct ArchCPU {
     bool prop_pauth_impdef;
     bool prop_pauth_qarma3;
     bool prop_lpa2;
+    OnOffAuto prop_mte;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
     uint8_t dcz_blocksize;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 70f79eda33..0267a013e4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
+#include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -1793,6 +1794,11 @@ bool kvm_arm_sve_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
+bool kvm_arm_mte_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
@@ -2422,3 +2428,37 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     }
     return 0;
 }
+
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    static bool tried_to_enable;
+    static bool succeeded_to_enable;
+    Error *mte_migration_blocker = NULL;
+    int ret;
+
+    if (!tried_to_enable) {
+        /*
+         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
+         * sense), and we only want a single migration blocker as well.
+         */
+        tried_to_enable = true;
+
+        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
+            return;
+        }
+
+        /* TODO: Migration is not supported with MTE enabled */
+        error_setg(&mte_migration_blocker,
+                   "Live migration disabled due to MTE enabled");
+        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
+            error_free(mte_migration_blocker);
+            return;
+        }
+        succeeded_to_enable = true;
+    }
+    if (succeeded_to_enable) {
+        object_property_set_bool(cpuobj, "has_mte", true, NULL);
+    }
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfaa0d9bc7..4d293618a7 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -188,6 +188,13 @@ bool kvm_arm_pmu_supported(void);
  */
 bool kvm_arm_sve_supported(void);
 
+/**
+ * kvm_arm_mte_supported:
+ *
+ * Returns: true if KVM can enable MTE, and false otherwise.
+ */
+bool kvm_arm_mte_supported(void);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
@@ -214,6 +221,8 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
+
 #else
 
 /*
@@ -235,6 +244,11 @@ static inline bool kvm_arm_sve_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
@@ -283,6 +297,11 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 #endif
-- 
2.44.0


