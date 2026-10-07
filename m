Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1242CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xES4i-0007O0-Ay; Wed, 07 Oct 2026 09:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERy8-0005nw-FT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:46:11 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERy4-0003sH-VZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFWq7P5qG3OAoQl6NtmyaTTwO/WicjqET+9iOkTJ01elmd+3F4Rwlu61zE4cpFxyD/aXuzLv4AqlXMn507l5ewhr4cIwkgDMGCVQIkQ//Bsc1BijF2zJLqOL/zTkMzHE9LRtI9SozbiAAKT+PJrWsc4grVjUmwRALnUTne6fLJVX1EDwscUv4S++P7JuwlP63B7eg4VyHekriNoJbdlIDu2sWwYW3Rb1k2OereJMAZr8H0FY2nbaovTJGCCQLd44EL+e8lND1iHTGHrjyCvMysCKYsFBuqkhDrOjh4/PXn4YYkEFIFSK/xK5MQ/x73NNKhO9dq7UfNialCz7oTzexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7iSxx3/ZmYQ+roiiq5QsiL5RGo7UrsoemSCLi1+3sY=;
 b=Ecjc/CwI2v8pVz62hVoAyeXoQ90onudm/uF+nGScQr1P5VTwHsMTFnmisDDzqnXt5T/BKiabcW+XFu2ZhMJpzl79iWqPns/bRvi19c5SymL+f816foeJtVD+zaBN4I5Hf+HnCX4kRdh0fd70zR693fTgnndxxUtHodNffT7tQA1AnG8X2SH3nMg01e1RdxFdn1+To0XYlwFSmm1O6vzUsKr4zRBpJAK+GQDSBMpbRSs0MeyWcylbKPHw4u2JekLPOpZH57rNLARogvMBd0+wjgVNwR4eREgwWhRgo4+F9GhFoE3kzqofka4ZZjJHqwW7tdcN94yfX6kTCGGwo4aXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7iSxx3/ZmYQ+roiiq5QsiL5RGo7UrsoemSCLi1+3sY=;
 b=Cf6w/MihX+01eGTGRoL3wymKtyfVedPw7tyjPAgDe0p3Z0Q3WnoCdXRn06u18Yqt73+UHQXqtCBAVKIojjTB0J/YkV3Fsft9DCycUAzi2K//hhoFBQleLNf2NumYEBRzIvYi6/bEjw1jpYVUVU9gwMxMs86mXyMVDMJw0wnKK6M=
Received: from PH7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::8)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 13:45:52 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:510:33a:cafe::f) by PH7P222CA0020.outlook.office365.com
 (2603:10b6:510:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:45:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:45:51 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:45:49 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 14/19] accel/kvm: Don't default to private attributes for
 in-place conversion
Date: Wed, 7 Oct 2026 08:41:38 -0500
Message-ID: <20261007134323.1606088-15-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6f7dcb-f273-481f-edc6-08df24794d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|23010399003|11063799006|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: rhURSsK+ycoQc09NmXM3xEP/EFOSc30j1Dp0o9L+pvkOeXDqZ6w0zaidlu7uHuiHjYJ+bCWTgOjvvmI3hfuF03UoUAdfzB/XkJAimEAd7wi4qPC2C/+ADVDqNIvq171sGWqmjvhTHs+tITIKkP5YZbInOrI0VuCHmn15/A3pcrNtuOHv9xkpnSeL3SekxxenQwXfnlXhnctG1Zr0zlzFWgJkU7+X+AlMyR0Nhj00WmN9yhX0V5uKz1IHWzYtT+ylEcNhIX3yd/2iny7L2mBhmIBEZ4ES5k8n6Vn1Z7jIfVXFI+va9q5gM/eTyOuElKlSusMzh3BfCMm12mz3ycJPH7EyRZxCz2golKFnxOFFMOSN2xH9h616NCPGZvBJljdvxfN0R3jLCXEkR2m/oIRtPPUfg4f22Tc5zBGtkY71zlnw31kt6ebRQkCMhvFOeXKJM1Zrrz3WMWw5Yk1O+86utCV85n4lTJ34ImoSYxsVOv0vgqzA5A41F8g5M3kgGcWlclwYyNhtEZZ+Kr6zniYX+A4fWA1q+NgdPBE6bATmYIZc5nr6qHc83OjD2KphRcdGiap0q98I0R+Q9fGng6svRsy7Pu+isIkWTzVuCkzvfNrWaFurN4qY47L9VFpDNIpO30VD0sG8FSlIEm0WzE+3gE8RUZiWRvV6tTymjDLb77WnN3K3/5bPYCAgjU9fYDI3jQgJAhBDPENdqNTn1+oNag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(11063799006)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KFRGIgfFFRBsC7vBChvyPWtpx4MXXf2OKDv8LQK5KZgHpGsTmgaQmLyBPgEAIJTywLO03gCMz1CB1oG06LWLLAWez3SnJ/wJ8p3Md5khec+k2lJVudLnggTvXGz+frMQMfCWREgL/I38Tkv68UZMod728Opm2WHYNwHBo+WJhfiI6jF8HnLV69gtwjt/SAXrgaCb4N+B86WTW80c49pIgSyKp3klXN8PynZuTcprfP7kkODbq4Vc5qNofLmbR7Zchm4pEINbu+jssvuqTWLIuhdddMjk1BFeb6yDHwR+OTfVrDXeJdrfQpD/8I8GZ6ZBZ6V2b713eRDTZiVkIrQfhetD4kZnty2BGhqAzIfNrd3BXrn1i7PLpSVqFNVIAaxyR6O5thsa5Be5pF36Xz76tMf04qrrI4DHdQK3IOnl2JellIOsli6fZJ4SQAXwtdC1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:45:51.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6f7dcb-f273-481f-edc6-08df24794d45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Michael.Roth@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Without in-place conversion, QEMU can still access shared memory to load
initial state into guest memory prior to launch even if the GPA's memory
attributes default to private, since userspace is accessing a completely
separate pool of memory. With in-place conversion, all these accesses
would need to first be converted to shared, then back to private, since
the memory all comes from guest_memfd and only shared memory can be
accessed by userspace.

Additionally, with in-place conversion, the most efficient way to set
the default memory attribute state is via the presence/absence of the
GUEST_MEMFD_FLAG_INIT_SHARED flag, which is handled in the guest_memfd
creation routine, so if future in-place conversion implementations wish
to set the default to something otherwise then doing so using that flag
would be ideal rather than changing the default after guest_memfd
creation by issuing a guest_memfd ioctl.

To account for that and avoid sprinkling these differences in behavior
throughout QEMU when in-place conversion is enabled, just default to
shared. This does not compromise guest security, since Confidential VMs
will necessarily enforce this via trusted entities, and simply generate
implicit page state changes if their default expectations don't match
KVM's. However, in most cases a guest will explicitly convert memory to
a particular state before actually using it, so even these implicit
conversion requests should be rare. If this ends up needing to be
changed for other reasons in the future, the guest_memfd creation is the
right place to handle it for in-place conversions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2d4cba1a3b..bfb8b4a190 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1810,7 +1810,26 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd_private(mr)) {
+        /*
+         * Without in-place conversion, QEMU can still access shared memory
+         * to load initial state into guest memory prior to launch even if
+         * the GPA's memory attributes default to private, since userspace
+         * is accessing a completely separate pool of memory. With in-place
+         * conversion, all these accesses would need to first be converted
+         * to shared, then back to private, since the memory all comes from
+         * guest_memfd and only shared memory can be accessed by userspace.
+         *
+         * To avoid sprinkling these differences in behavior throughout QEMU
+         * when in-place conversion is enabled, just default to shared. This
+         * does not compromise guest security, since Confidential VMs will
+         * necessarily enforce this via trusted entities, and simply generate
+         * implicit page state changes if their default expectations don't
+         * match KVM's. However, in most cases a guest will explicitly
+         * convert memory to a particular state before actually using it, so
+         * even these implicit conversion requests should be rare.
+         */
+        if (memory_region_has_guest_memfd_private(mr) &&
+            !machine_require_guest_memfd_convert_in_place(current_machine)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
-- 
2.43.0


