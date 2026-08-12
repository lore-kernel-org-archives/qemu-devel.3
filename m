Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD24C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFUS-0002GS-GE; Wed, 12 Aug 2026 16:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFUQ-00029Q-Qk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:23:54 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFUP-0007Q3-1B
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvRJMgaRty5sn4Fopk0uwHD/ivVgIyfDcP7F/SesOZZxPr0l9770hInty3bwb6OOVX+VU/IbUrmLXpRDyW0FRVMoipzV1/C87mlR+MZKirol93LJe54EGwwi183ouP22v5kZDVTZxBP1ztVrFR/nJFdNjywAkH17lwEUoZ64eW+hfdPukPQXy0V86VuEqIYiNZ1OgZlTVwGER1uXQufPwJjpn2ABtu47FxTjBpN8BB/Wb+CG+D75ks3pU/rRUT5TgbX106T6CAFuDTSj6OBLQP+/KqMCOaRKMTHweIvjgCczudBbPJW5e2cLsNvZXondC0h+rZbR2UmkZfDHWNL2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UhXH2seGXK4l/2t8984R8APX/c2CsV1O1RZAW+n3fI=;
 b=F+Z3M+f+uPk3Qd5UT7drvnvNovG7oJv7P/H/m+o+LUwBAlYyiKtqungPYEAY7Dnw9lA6oSOC5/v3XlawClilpk/t+0ekt2M3NQu53D0QERMIkZzszzI9NdELKGfS4fgieG4yTtFu0RcFwt/vf90a6bVsB8hcrrjbVRIuuUmoC1yFjDSHAcMnaEuf2LLPZMfSHjo3OoYdUGFyd284PQzb/GiDlYZFQFiOz4m9uOAoAhHMN8p6MHyQxUmHPrRJqjskx2/gSWXIWteY7NkhKQIRQHUKXjxWQ5YgBK2JFHKpRsr4l22zeu5E7lR8/HyV3IYYJuharg72BwVRyj7ngoThgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UhXH2seGXK4l/2t8984R8APX/c2CsV1O1RZAW+n3fI=;
 b=MWXjE9/DnO3VlqB8YzyqvYJa9bnhVTzIgF8Fl6gzzJvLPZf4H+DlwES+0OGln5Eh6tN97RI+SupVupcS5tkbZgPIRulV6DXoM1dXb0Kdp5HCfewnIhXi3bDz5EvT9RoEoZyCGY28c+KD3zGNxhsa17JJO8VF81A9qVqwiZSun6Y=
Received: from DS7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::14) by
 IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 20:23:47 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:259:cafe::af) by DS7P220CA0084.outlook.office365.com
 (2603:10b6:8:259::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:23:46 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:23:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Date: Wed, 12 Aug 2026 15:16:41 -0500
Message-ID: <20260812201938.198915-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b8b290-338c-47bc-93ec-08def8af9c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5W6A0lit9OwO8BsrnfGpXD0TdYmIPAHctJstxP87ur3CYVTxhCeX5Ep6cMWdrIm6N9ZezRKC2/yzIctuiT5Z9TPkLC1zzYE/q3rZekzNPJD36Zgl9ErW8bBcPaKc6b80ykJWB1XfDaabI9Ewd216Vl6IKNape6edDx25u8r4cJsQqypl98yH5ZOxvs7xE5Qd+tIXJc5zLZgb0icW/WCbzLICVHTCGxg+vRn4MPQPoM9SMaJMQAW+xlHWzYbhpbiaBnm9hMSFGCScfn76QNlsjtqI3Yl3Bn2eE/9FDc0HyBdGYGroa8ro4ogqy6vq+WCKo6MSVCsyYtEvRnD1nmcPOAdNPq3gzRurgSWeGi9cvGvflevqAY2yo6D5CrMcN16pCkuuArq6pPnt7OXLhq6Y0+G1S8g3jrYkvae5Olz4LKtsNPKOJYkLNJRXDLXPjsT0m6KuxtxdDjiyHM786hDKYQtHXp+Omx79m0XzXpDzQ7/2XcY2vP3dLXqC1FiUMuIrttUrikDPDaXPwILpByqqWHeGvl2JHtvpkYMqecnX4SKHHfwAAg7yGNaUNuy2Hh6aGlTd4Z9NTxZ2aWirFgIA1fKj9S2CfodjmF1hRIE6WocdPM7PXTe/8kI8Z4YYFDPwPgjL2g4a6pQi92NxqCzyUrYfhJ8wKBprLcF5jdNqz1RzYyGx5vWnwFk+ZlYCu2uKiaIcHKLHZbnNWJJO6RWdAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kz3IDZeAauvahPVdkXlg6umkwgHY++cK+1jHdBbTWOQmCuzKblqDT9Ipx036I67hSJt2rE4hDW/u+H8pfun9z0ECj8Qg2bKKLupyzrHV8x3BDWYN4W4z3gR1nZJVl8gVo+2GT8fWCU0wlLjOZMinQIxv4CduL640+CGvp9J8xVvmhPAMGhlsiy0qNlwWlkALUP76bFrNz3N4RCdxMoQU6AxvJcUTbey74DDpMqCdGrbU3CCOBUg2BRn2yFI/u+n0tv+viM+VbZ3ot94FUH1qfIvYtRlf8Xi9sMK1rlEGvE6Ri2kPkvm5x6AyL+K/mHceNOrXa01jfyTWyZnP5suelb7btdTwAob2kRyp2m3NBIXEhEd7rYIj4JLKk3YvEX3STslXmwr596O00GXINCB8RvrOUUMRACoHg46LKnaMxxjLq9tXt6LebXNONfrtxHlx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:23:46.2346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b8b290-338c-47bc-93ec-08def8af9c94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

So that there will be a verbal string returned when kvm not enabled, or
kvm not compiled.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 5 +++++
 accel/stubs/kvm-stub.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 120cab1e22..bda2e25a66 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4758,6 +4758,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         .flags = flags,
     };
 
+    if (!kvm_enabled()) {
+        error_setg(errp, "guest-memfd requires KVM accelerator");
+        return -1;
+    }
+
     if (!kvm_guest_memfd_supported) {
         error_setg(errp, "KVM does not support guest_memfd");
         return -1;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 3d34e3b99d..acbd0785e0 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -141,6 +141,7 @@ bool kvm_hwpoisoned_mem(void)
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
+    error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
 }
 
-- 
2.43.0


