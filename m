Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B05EEB56F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofwb-0007nu-SD; Thu, 12 Sep 2024 05:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sofwZ-0007mH-N9; Thu, 12 Sep 2024 05:16:51 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sofwX-00030K-Cn; Thu, 12 Sep 2024 05:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kbr/y6q89QyINxfMpx5H4yASwd5+R3soFAl2r6ieySkx/T380e8EpywH+JOHbLdOS8eD8RGY6higBSvFLpVI2OOQpN5azB4AHx9++TLl1b29L1UkPxi7YZqhQHoL0+Yi8o1F8BsOl42IwBBZw9ixrOTCeKqeLysV04F1FGRT6ZQe39V/oTT1qP/Ec7mtMDpBychClbhpN7KW3aZbwxFTY4OIm9ZAINpuG+2Ph77urywvWBy1Q+BV4gG4w2lX2vHly7OtCoXlO/Fjg5XEypz94mCPNaUn5GrRYu26KeWzyUDrZAj/941aiIJLwx9Rd1eVDZyDC/tnaACOidVyCafJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PZ2Ljq9RlDQ479G3NrzY6d7Nk0X8pFjpShv0Y69lZM=;
 b=jDQRn4fUxg17S22c3rSM0cAYuhpmeDVWhPx7R32jRRg7jd2591xNQED/J4XSGJccVQXLcQ5Yu7BFby61X3pvCysRth9UJgX+8d24vpEHS94YwMmq+gps7A3seVgWjsE8yKolb/OtFtRft7s5CL7CQPVfDo5fc3KVRWYwwNCT+20XVgmmy8YH/13RkXtWWHaA4em/+Kf8+EKRKIZLTANfksIObn/nrpPJVGX25f0nO4foOR9t4KUuOkF/sCr0o/iZTvjMtCVjDveDouGEN84sZXahINCCkRnpaW7YTlJ94sVR4l9Cg8GTkyw39BWECbF2ZiQgDInTfRP8BUwbFMxLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PZ2Ljq9RlDQ479G3NrzY6d7Nk0X8pFjpShv0Y69lZM=;
 b=Htmm0PGLsFuRmE1SG+uxZ7cJQTccQGb/NAUSNGZBhvYosM4hCWK/7ZNLJcEQe2J1NeYbuhW4wyrQqW3TtkJ65IzP/kGBGCowpKS7+Byd7SnNqSHmwfY3hTbRTH2XQXiZNiAjqcQVJOQG7rCIIxbz6lefh0GY2uryjr0kNRMgYm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 DS7PR01MB7782.prod.exchangelabs.com (2603:10b6:8:7d::17) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Thu, 12 Sep 2024 09:16:41 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 09:16:41 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 gustavo.romero@linaro.org, alex.bennee@linaro.org,
 darren@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH V2] arm/kvm: add support for MTE
Date: Thu, 12 Sep 2024 02:16:16 -0700
Message-Id: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:610:77::18) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|DS7PR01MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9367bd-ac29-47ed-6332-08dcd30b9d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EvC8rcE1KdBFDHpEMpLEU7Lv0vid5+TZjEcSlAMIk+c8kEAPGTsOeUzhZwBq?=
 =?us-ascii?Q?2zUJhtTvAjdYYK23PX20LfgmZdsrCoBIiWxBSq76p6LHEcHUmm1NueoNqVFv?=
 =?us-ascii?Q?dWZInh2nWbtM+zkPmYO0p7u8j0efmA6/Il2CiSljnnRh4bsal4SEYP6pAHZg?=
 =?us-ascii?Q?YIcnh8n4X3pRqATMaFZDgSeunAzaJjMlGok3XeKcx+vwyTM5h8U2elGBHjMw?=
 =?us-ascii?Q?tBJ9D7qmiYqXKpby4NeoJGIXanm/OqIPJ1wIAYdI6sQs7XKkyJpLPLiyX2R+?=
 =?us-ascii?Q?euX3Fz8Zdlaoy205UgtZw++kyZzcXcPBNNQdXSSGu5wmyVxT2R5twpvndjyZ?=
 =?us-ascii?Q?4dorGcVsk+ku19kg7ejDyiVFoFbYYfIgjZGdK4EnXz6zMR61nJp/FjCYNomC?=
 =?us-ascii?Q?qO+LR4hjWKf9Hv6FSvRSXli//oW/Or0KPD0oTwzVdo4odDu0vdr3nO3z6Bn7?=
 =?us-ascii?Q?615mNsqUJqkQHAk7OJRX9NQioKwrcgxURKZiZewmVMH+Wtk5yizhq8ErRINr?=
 =?us-ascii?Q?++MbAhrEs6OEJalFPvKzw0S/hK7uhlJS4sOeYfkp7fSb39OReLNx8+GUqlGD?=
 =?us-ascii?Q?/+gyr2IX/v3TR8ya63QkwagaDcnAtIiqMRzUnHhdHN64RNXeWIkYK5AoH40E?=
 =?us-ascii?Q?xpOui39XNrxVfq8rq8v0fJhZlRd+UXPIAwmHPzQqjT2nwwYaliu9VVNzfMaF?=
 =?us-ascii?Q?cx0xrUeGsNQ7FmRAV32FPaiDawC4aBCncWYWP7AWS3Mu22TVYpQHu1Qa+CNy?=
 =?us-ascii?Q?iPbPkvX3ERRZW+ogDyk9aAP9KFOSd1NUjorKLRMK9S0HQF/mrY4TR7wHjxGL?=
 =?us-ascii?Q?gznSz3tO2C8NDmQFDXGaHUciF68/k1uaqAHvHqNuImAjtopwI5qUj9x5ULbX?=
 =?us-ascii?Q?sd4Frf6a15v/a8iinVvFgCRY2hFcrONthfzH7xivE7C+VRj4rOBlN7M2sOTa?=
 =?us-ascii?Q?Fboq67RQPA1JcW1h+gDcrEoe+Bg8ft+emcluQrw0MC/MBgC+JiwRRwXvt7LU?=
 =?us-ascii?Q?ah26fzfZHbXqkY2aku6nIaTMrpthUV7JJv8H6KBGIMq0OXu1gJlHlPQyHgPk?=
 =?us-ascii?Q?BPBYoBBILFYyIm/DKNlsBC2/ZvVI/NUK8SRE8/DzO0nPjds+h7/rx4f4HmxD?=
 =?us-ascii?Q?+Loi2oPDFYVCpPheyUTpQzcRk36S+4tnGhwLRWUwY4wN3FqPk7e74+e7yLJM?=
 =?us-ascii?Q?S12SEQeHofMZ8ym5K0Go+sVLJtvl27N//x832xcl1J0RBMX76L29N94Udepd?=
 =?us-ascii?Q?7sikGVIFR/ge9s+aLIsYIlFM6HQuPXNuwHbvcBHVOLgadkdQbE6Ah32/PECL?=
 =?us-ascii?Q?oCJDBlcBtoFJYIdTul39YexJ6FLG6WmLOBSC9EOT1/LoFQ+Nl2kLqECYO8hs?=
 =?us-ascii?Q?9ToUuwsE00Vq4KfMDnUeCvonI0O/8QmS5cU8tosl+qcqwAnvnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fw/rw7SYMXaOhX64Ux7JRnPRLjn+Ug4cKasOzRfKEUy6nNpzWq4U80Jcsorx?=
 =?us-ascii?Q?zMMDX1hSPEDInIve76baT+DiTkPwcmCvRx8I7IWydl8xBGq9EehgZQ/SJRhH?=
 =?us-ascii?Q?MU2GGUvu4zrUbSHL2QeMtqusvEIE2POPJPNnEWwSR1mRH5UXL/jqaiwPEKty?=
 =?us-ascii?Q?WNyQRPWh72lQIocqAHRn7Xfa40m0R5+6UTRDy+NgCAOX6qIdja/JShKZqnBh?=
 =?us-ascii?Q?U1at6vPaXaVRIq1Si+U+hm+On60bd3ageUBCuKLaIWOXKLbJxGyv8vBdE61X?=
 =?us-ascii?Q?AvYzYaVUngw+JDNUDLiEcTiltunqSVp9mAZy8jNoX9FJ7W6THlQW5+lQDlO0?=
 =?us-ascii?Q?5NELRc6TPuvisPBx0vAi92/s6hmZtKsffLkQc/jQsCdRp9ND2VRMuGtIydjg?=
 =?us-ascii?Q?y40SHI/ryVAxlga8EYKer4K7fwWLXytELxrHR1nlJT15jXIZ4DtKkhVf1JfT?=
 =?us-ascii?Q?0djDhhAF/bRG1y5JpDghpU2ck+RC347Keewc2Yrv8Fwb3PQjmG4YkG1J5R/m?=
 =?us-ascii?Q?yx5R+XPgs5YPBYYm1nIFPmNZVe29bK4c5gckbdtLniyxh9qhDaKcMl6ZhfMt?=
 =?us-ascii?Q?RHbHcvqpOFBohacGnwtReud5LkKF6ugOsDJBfEjsI17dY+VeAvDyOshwejPc?=
 =?us-ascii?Q?VSQ4r7bFeLJdNbBBMcso7krnGXo3jHlh6Lw9HD9yZ8bJIzuxWG9avsUHLI0v?=
 =?us-ascii?Q?fj4tQWIYsnG2fhFXoCYX55SQ7ym6yDeYzlOL1Anl7nZa45hGxMiDEDZpDTQF?=
 =?us-ascii?Q?J7yaOajjSgaAf7XHUD4i5JxWNgkSf4Fcxeu//vphajlrseY+0tnA1tYteKrR?=
 =?us-ascii?Q?27cwxyZ+goH+HQB8pH84gbDPe5c54EvdV72TePiudiRbV51PWxAJttEx4v2T?=
 =?us-ascii?Q?RPesLPwpztZxKSAry+K5unHR58PLglcnxqLVQu0TFchparvtS2sEwbFNitOc?=
 =?us-ascii?Q?TCotKHWypJbn8pMeOhdf7H/LPiuB0tchLsqG0GaTpWmkOoB1Ehj8hAbMGT92?=
 =?us-ascii?Q?O/xAlPtPuhH9ctdL7rEY9jsIsgoncfdNSJjKT+6sizHGkwO7bKDg2oFOF0Q3?=
 =?us-ascii?Q?ywPjkjenw2Re+0si+8Yc/W6qMUr3AJZh990Ms+ET0vOnwFdXR+5ZJEIJr4no?=
 =?us-ascii?Q?BxUA13xAv/iheO26ogBbkfarmBDxJ+7uHWsqkDUOIBEYhc3Vvlvvo/owosQd?=
 =?us-ascii?Q?GGkoJLBa4hZEaxxABgbNQsy3YwHnUmay5pMV+W3tySuvFoJKlOmEjc8SAOVP?=
 =?us-ascii?Q?giyQHzFHotZl0OWSgStINLjdMBQd4NSQ3xtU+/u7AhkN3v37Hu8zvFbuBA85?=
 =?us-ascii?Q?cXzmesRE5MjZbuGDhA0lXB6/Y2Ica0gKqDy8V6pZ9FKyEOAvGyBIH63Xv0Ya?=
 =?us-ascii?Q?Are+K1MBB4SVqEwLeruVpZ4/nH3JAmyl5Qv+edaSr6hAmWnJUNzFDkpAlau0?=
 =?us-ascii?Q?Up9fsUiDgYlctVlW+v1/dTFoh8I5sJ81gA4jo0nwZk9wKXLO4wF+eKVMEPje?=
 =?us-ascii?Q?k92ECPbROegTHWEUk7IdZ/hU2f9AfgaOoptCjlxZVLM4nXHeo6n49y7hWbso?=
 =?us-ascii?Q?uR0GhvIbH0kxzwz7WPN5rKOahQuASfpBjYqhoCXUrmiYM86nhqcgEFnJITnS?=
 =?us-ascii?Q?zsUiB1ztJR5aE/O5XaM3Y44=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9367bd-ac29-47ed-6332-08dcd30b9d1c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:16:41.5054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7v4CdTUzfarri7L5dCRRA0+Xk6kpYIdIlg3akHgajSTzvxV+2L+wVz9TeTS5OsTXPz5VfWRPlumLIoI9IrQltCv4LhQ38/uUhj2HZopiRru06lhF7J9yVjP9A+Nnmya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7782
Received-SPF: pass client-ip=2a01:111:f403:c001::2;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Changes since V1:
	Added code to enable MTE before reading register
id_aa64pfr1 (unmasked MTE bits).

This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
and default case(i.e, no mte).

 hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
 target/arm/cpu.c     |  7 +++--
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 19 ++++++++++++
 5 files changed, 126 insertions(+), 33 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7934b23651..a33af7d996 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2211,7 +2211,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
+    if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
                      current_accel_name());
@@ -2281,39 +2281,51 @@ static void machvirt_init(MachineState *machine)
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
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c2391..a59417aac8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2390,11 +2390,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
         /*
-         * If we do not have tag-memory provided by the machine,
-         * reduce MTE support to instructions enabled at EL0.
+         * If we do not have tag-memory provided by the TCG
+         * nor MTE at KVM enabled, reduce MTE support to
+         * instructions enabled at EL0.
          * This matches Cortex-A710 BROADCASTMTE input being LOW.
          */
-        if (cpu->tag_memory == NULL) {
+        if (cpu->tag_memory == NULL && !cpu->kvm_mte) {
             cpu->isar.id_aa64pfr1 =
                 FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
         }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f065756c5c..8fc8b6398f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -922,6 +922,8 @@ struct ArchCPU {
 
     /* CPU has memory protection unit */
     bool has_mpu;
+    /* CPU has MTE enabled in KVM mode */
+    bool kvm_mte;
     /* PMSAv7 MPU number of supported regions */
     uint32_t pmsav7_dregion;
     /* PMSAv8 MPU number of supported hyp regions */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 849e2e21b3..29865609fb 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
+#include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
     if (vmfd < 0) {
         goto err;
     }
+
+    /*
+     * MTE bits of register id_aa64pfr1 are masked if MTE is
+     * not enabled and required to enable before VCPU
+     * is created. Hence enable MTE(if supported) before VCPU
+     * is created to read unmasked MTE bits.
+     */
+    if (kvm_arm_mte_supported()) {
+        KVMState kvm_state;
+
+        kvm_state.fd = kvmfd;
+        kvm_state.vmfd = vmfd;
+        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
+    }
+
     cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
     if (cpufd < 0) {
         goto err;
@@ -1793,6 +1809,11 @@ bool kvm_arm_sve_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
+bool kvm_arm_mte_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
@@ -2417,3 +2438,41 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     }
     return 0;
 }
+
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    static bool tried_to_enable;
+    static bool succeeded_to_enable;
+    Error *mte_migration_blocker = NULL;
+    ARMCPU *cpu = ARM_CPU(cpuobj);
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
+        /* TODO: Add migration support with MTE enabled */
+        error_setg(&mte_migration_blocker,
+                   "Live migration disabled due to MTE enabled");
+        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
+            error_free(mte_migration_blocker);
+            return;
+        }
+
+        succeeded_to_enable = true;
+    }
+
+    if (succeeded_to_enable) {
+        cpu->kvm_mte = true;
+    }
+}
+
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


