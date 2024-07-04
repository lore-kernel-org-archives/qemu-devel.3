Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C39C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 00:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP9zz-0002ah-Q5; Wed, 03 Jul 2024 20:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sP9zr-0002Zy-1F
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 20:06:48 -0400
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com
 ([40.107.237.52] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sP9zc-0002Zo-Uk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 20:06:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijsmdG81HNhHEmk2BtEzHjbydalT+YWAlUdm3oCaAnEHM4Cty+bcEkijlcv1GzpKzOfW4MRjfvc2EGBtuLcOVHdj4G10HLp7ppU/+1Dln0HQYvPK/8TFXgs1l4Tyi3TxAMW3e5rSkFLP3pOjAA5T1W68qkbErWmfIMkj4yIzq67IoPhdP+e3UgIP8o5hiYpclJIQoTGUMuJUqRdRoMQxWhV3K3hNKvBbULkRUPAykkR1k53Mr80FyjrWDzDfZXd+c1r7Xm4kvqiFNR6glVWGK/4GoD1kOdfsU0ddK+wOy5dwwZAyVxr2fUSpzBLcMS3TES2gt8b7lvu5RjKBeQ3uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVy/eR8ifWXY4MCIq+yHoIgKsHrfQilhGMiPY9WrrEI=;
 b=mqV1zlPLVeP+aHU6fRo5DX70PqsT19IappOrXkzhCTRVQFinokRc89ykw6RBNlQC3ybgXQTWQcsrZF9n7OGBenIaovS1gw9M9d7AlClC+uI4Nf9uV91LikXQfvAtb+N/lC4MyW6otlUgJD8fu8zTvJRvG9Hle8ECUJ42ASUno8oBO71qEIsQeXu83+vPCD2xkRxNpaAcg4xUnjaDu3PLNCJrgrpvanlHomhmR2ZiDnepQtf6b9HNDN6ZXxxgKHZf6ro49AEamkbOyWBXoIers1eSI18EJZ06NkdyNpZMBUV0gT4Db7Hjz5iztEMG1TqlAyaz3A03maSjHfT+2uq8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVy/eR8ifWXY4MCIq+yHoIgKsHrfQilhGMiPY9WrrEI=;
 b=QySHwBvl7TMRI2/F1l7lgiWFOBFEWCRfCHeDNuadvEBQSjzdyItpcJXqNj1zgJ4eau0UCVLBepGli+Z4hmT+4Pd0KBhjhGRYsZQ5wg3u6VgYH8CWy0dKokfepqQdu4xSbqfdU5aNenDQUm1HxnZdOPtxsMyuz22++lVQMWQMZaQ=
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 00:01:24 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1e) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Thu, 4 Jul 2024 00:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 00:01:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 19:01:23 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>
Subject: [PATCH] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
Date: Wed, 3 Jul 2024 19:00:19 -0500
Message-ID: <20240704000019.3928862-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6f2141-c6b7-4ccf-510b-08dc9bbc7185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0xZcUpncTloVEVHZWZIaGFjOEUySi9COHo2NEFMSytlS1M1UEZUY2ZXSDF3?=
 =?utf-8?B?TlJXSnFuQnVSQW1LeVgwWjBpbW1yck1FcXo1YUwrSGJDWXlFTC92dFJhREUy?=
 =?utf-8?B?QVhBMmQ5NWlyZGJWTllrVFBYY0sxQ1RPS2gwa2k1dE8rWlM4VGdHeHFNeG1y?=
 =?utf-8?B?bkJ5R0pYOUcwSEQrQ1ozUFJqaENMbEc4MWlTTVJraW1ycjVoVmFTYnQreVZC?=
 =?utf-8?B?K2l5WVBqVXI4VzhHa0x1ay9LRWVaVHo3YTJScjRnUUw3cllPZmwyNzRuVVc5?=
 =?utf-8?B?ZW9BUUJRbXdQVDEwYmt0emdCRHVmditCemYzNWVmWXJuTXp1Rys5bmJkWHRi?=
 =?utf-8?B?WU9JcTNqbk9qeERtVEVBREYzMEl0ODFlcE9Id0UzVjNuazNDL2tYTExnS3VE?=
 =?utf-8?B?enhJUkhtSlh6RWxieVNpRDl2YVVPbmxIVXkzNkp2UDRvMmFuc0RZZ2tQY3JU?=
 =?utf-8?B?cDhia3Q1NHFFUmFtYWdkZ1NCWlRhOENGTDRmSDdtUVd2MnMxSklINDdhNWZs?=
 =?utf-8?B?UlVRWlRsR1dwMXBvY1BpWTBrdEd2Snh5NDVaS21JV1hHQ1IwVlgrQjVBc29B?=
 =?utf-8?B?UVhoNVNtNWU1ZSszM2FxSHNsbEFmZndTcmhEejBneDM0RHdTTTM3NUdoc2la?=
 =?utf-8?B?RWRRNGRuWXlEaC9oSDJVRVk1NEI4UHJZT1RRQlhtT2d1bzZpMVd0MzdnY1ZV?=
 =?utf-8?B?VDNZaitkYTBDOExxazVBQzlmMHk0NGRTODRJdG1ORXlqN1IyeW9iWXp6UUpl?=
 =?utf-8?B?azRVdHpUR0FBNE1BM2g4Z0pveXNLaVd0NnFFTDR4RHlHc3AxVXVOSTdNNnZr?=
 =?utf-8?B?S3NvWkE2VHdyeVlJamNlTjRKN29JS0V5ZktvTkplV3I3UEQybTFLc1NCL1RL?=
 =?utf-8?B?SlhkQlllUnIvSlMxWVhVRUZHdVBOdnVhaGRpdUZpcDRnZnVNOTdYZDUyYzZP?=
 =?utf-8?B?RDBxOHh2ZFhKdTdadERxVGV4dGdtU216M0xGb0w0TnA2eTU3Mm5ka2dDTmU5?=
 =?utf-8?B?R3FybzRmY3h0MmJVTmdTSWVRNW9UcWdRNTIrd2xqRVFtRmhOcUZkSVNHbUY3?=
 =?utf-8?B?M3V6OVNwbnViQk5QT0lrYlVVK2lZdlNZa1pGR1VnS3NWRG54NGJyRDhjU0Np?=
 =?utf-8?B?QlBGSENEUzk2KzZkUEFjbXZYSUF6Tmt1RXoyTVAzcUlQLzVuK1ZOZHdIQnFp?=
 =?utf-8?B?cUxjeW9SQnNJckxPNFpIdFJDMWxIRGl3ckZtN3R3cnY0bFFNUUxtWDdVQjVr?=
 =?utf-8?B?Tzh2a21KRnF6ak56QjhVblhoellMTDhFTTgzR2lQallzTXhNdWpFS0ZhTTVU?=
 =?utf-8?B?ek5QTGNWNGhYaEkxT2JlMzNTQXpwWlorNlUwS1BwUkpsVWxEQVRvc0J6VkRX?=
 =?utf-8?B?Q0dTN0JqalpRaXJ6RlUrZUEwSTVIN29NNGdwN1UzYW40OGdESlhMbHlXRkI1?=
 =?utf-8?B?RnpxdTBiYzc5WXk1Q0NxaEM3UzVQOFNsM254Yk5yTzRSZXdPOVRQcnJlSEY0?=
 =?utf-8?B?aE1MTGpBTkFFRlV1MjNFdWwrQTRERlhZV3V5Z3Y5UnZ4RGthRDAxd2NiS0M4?=
 =?utf-8?B?QlpwNnkxL3g5RWREN3VZUkczTFZ4U2JnWnpHYlNuYUJSVnlnWldGcFBTMnho?=
 =?utf-8?B?S0dubTdQcUlkb3QwdlJyakpPb0RvbHdtMmFkeHRBTExXb0dhNXZIbDU0cHNN?=
 =?utf-8?B?eEhMSHp6eGxabU1NSlF5ekJDNmNQK25TQjZCdmZ1RWVjTFBCeWdvUmJZTnhi?=
 =?utf-8?B?MUpvZXNCN0x0S0djSldJak1vdTZ2VzVMYVd5dE55TmRYWmJIWUhyT0NFMTMw?=
 =?utf-8?B?emZLNkcxeVhaMmc3VEN0VmplVGxFaVdoV0Fxbk1EeHgrK0dLNWZGVFVPVHo2?=
 =?utf-8?B?dFhQdmxlTjRyT3Jwa2tURWNTaEZCbGFMaW1GM3M0UTZmTWcvbUtlSmJ2amc2?=
 =?utf-8?Q?g3ytkQpTzsZvlf7YGyCHHsGEWLwVTwXD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 00:01:23.8924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6f2141-c6b7-4ccf-510b-08dc9bbc7185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
Received-SPF: permerror client-ip=40.107.237.52;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Currently if the 'legacy-vm-type' property of the sev-guest object is
left unset, QEMU will attempt to use the newer KVM_SEV_INIT2 kernel
interface in conjunction with the newer KVM_X86_SEV_VM and
KVM_X86_SEV_ES_VM KVM VM types.

This can lead to measurement changes if, for instance, an SEV guest was
created on a host that originally had an older kernel that didn't
support KVM_SEV_INIT2, but is booted on the same host later on after the
host kernel was upgraded.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
cc: kvm@vger.kernel.org
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qapi/qom.json     | 11 ++++++-----
 target/i386/sev.c | 30 ++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 8bd299265e..a212c009aa 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -912,11 +912,12 @@
 # @handle: SEV firmware handle (default: 0)
 #
 # @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating the VM.
-#                  The newer KVM_SEV_INIT2 interface syncs additional vCPU
-#                  state when initializing the VMSA structures, which will
-#                  result in a different guest measurement. Set this to
-#                  maintain compatibility with older QEMU or kernel versions
-#                  that rely on legacy KVM_SEV_INIT behavior.
+#                  The newer KVM_SEV_INIT2 interface, from Linux >= 6.10, syncs
+#                  additional vCPU state when initializing the VMSA structures,
+#                  which will result in a different guest measurement. Set
+#                  this to force compatibility with older QEMU or kernel
+#                  versions that rely on legacy KVM_SEV_INIT behavior.
+#                  Otherwise, QEMU will require KVM_SEV_INIT2 for SEV guests.
 #                  (default: false) (since 9.1)
 #
 # Since: 2.12
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 3ab8b3c28b..8f56c0cf0c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1347,14 +1347,22 @@ static int sev_kvm_type(X86ConfidentialGuest *cg)
         goto out;
     }
 
+    if (sev_guest->legacy_vm_type) {
+        sev_common->kvm_type = KVM_X86_DEFAULT_VM;
+        goto out;
+    }
+
     kvm_type = (sev_guest->policy & SEV_POLICY_ES) ?
                 KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
-    if (kvm_is_vm_type_supported(kvm_type) && !sev_guest->legacy_vm_type) {
-        sev_common->kvm_type = kvm_type;
-    } else {
-        sev_common->kvm_type = KVM_X86_DEFAULT_VM;
+    if (!kvm_is_vm_type_supported(kvm_type)) {
+            error_report("SEV: host kernel does not support requested %s VM type. To allow use of "
+                         "legacy KVM_X86_DEFAULT_VM VM type, the 'legacy-vm-type' argument must be "
+                         "set to true for the sev-guest object.",
+                         kvm_type == KVM_X86_SEV_VM ? "KVM_X86_SEV_VM" : "KVM_X86_SEV_ES_VM");
+            return -1;
     }
 
+    sev_common->kvm_type = kvm_type;
 out:
     return sev_common->kvm_type;
 }
@@ -1445,14 +1453,24 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
 
     trace_kvm_sev_init();
-    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
+    switch (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common))) {
+    case KVM_X86_DEFAULT_VM:
         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
 
         ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
-    } else {
+        break;
+    case KVM_X86_SEV_VM:
+    case KVM_X86_SEV_ES_VM:
+    case KVM_X86_SNP_VM: {
         struct kvm_sev_init args = { 0 };
 
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
+        break;
+    }
+    default:
+        error_setg(errp, "%s: host kernel does not support the requested SEV configuration.",
+                   __func__);
+        return -1;
     }
 
     if (ret) {
-- 
2.25.1


