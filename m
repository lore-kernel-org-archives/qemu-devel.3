Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF36CE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwYq-0004ie-Lg; Wed, 18 Dec 2024 11:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwYd-0004dA-Bv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:05:58 -0500
Received: from mail-mw2nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2412::626]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwYU-0000iF-VF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:05:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnhHYKNbIxh6WNRczoo641Mg5Mkvuq9022kJ/bBR1JBbD6SOY+/KI2ugBPQld9b9bdeF9SkM7CsKMvolmRYMmJCmhhVpS6q7WbTPiYn/jKdWtlXO8mRaGIeE7dg7zwWNyQ0geEDanjp6maMPAAIFBI5XK60S4qZ2Nk6vAJra7MIhi5A1etRVwtM5e1pUVgbmu6OlTALx4JOCQReHFidOcNgFO95/wo51YAH5cals9w41rzG4Psq3LHm70lhFoX6RpxV/ATu2oJ8jwz08gLWD7lCmMRYhqxW2pOQCeCaM9dMLvPP6bO/AhZLYgEPbrq447qTXOVHwRA2E7DALRd/b9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbke1KDtJCVRs0NmUnLmS0Uhx93eDsE8nWkHU0TRYmA=;
 b=YFjmOaUvCxA2mkpdLOk/SBNL+VVGHOXiTR6zL1SrJD9HX8A/8PjSYtWbPlpLarmC0oRwkEkJUqbjbncg3cw7Ym5hs5jzzNG6Sa7/bBcZhEb6A7jSie7uTcUO9EPvOPiM7mzclepjBWi9qYvWPtG7bStZTTM6D3U2vZ6Z8j4oJK/zsfSRHE8+KVjzpPemptBxMrYW+7N9IxUZKQ63v5Lex1kIYiwlfvhAdIDKkMmQP9AxgT5tq7Eato8u2al24vKK5Yat6abNSW3RJL7lznCgkrTnUgJiscrkUKaslFXlNrxqTpfcedjBnRTd6Q1ochs3aIOTOEx1Lvg6l4LltxhmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbke1KDtJCVRs0NmUnLmS0Uhx93eDsE8nWkHU0TRYmA=;
 b=CcXbGSQnmVzRtoHEu3JYw6ggWAujUyyISfNLh5oJf6WzBTbVHFGomzWK1cYmcj3IbyckCVCDnPcS8n+qNdzPQQy+eWFvfO22VlSxXnOjyvZhjiMSRvoqvbteBFAogxZOIPK2YhuLvbP+iuxmfRlYRd+YJfAE1OpcWXHkU3JONDU=
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.24; Wed, 18 Dec
 2024 15:51:04 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::4d) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.11 via Frontend Transport; Wed,
 18 Dec 2024 15:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:51:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 09:51:01 -0600
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>
Subject: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Date: Wed, 18 Dec 2024 09:49:39 -0600
Message-ID: <20241218154939.1114831-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218154939.1114831-1-michael.roth@amd.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c33f10e-f80b-4c23-9f18-08dd1f7bc6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CVsfsyppceWWWXHiSzUKL/g8misc6QXrEWA8ykAoYYhvmBP30hBJQFJNmlTo?=
 =?us-ascii?Q?BYtZ9ojF4Tde28Yo4l10jUiD8LIpy5jXdEeBUAQuhg1YgpG/oT1FkAwXS0H/?=
 =?us-ascii?Q?TXh000/mEhHDSYNIrDDv+pDqBSY9lxdRUxjLSs9KJniFOJzmUoQ4hIr9aH9w?=
 =?us-ascii?Q?Wh2qAmvaM9cFzTX9KpaEbGQCDNwut3sqD4kPa/CIKVTwiomYx/DwQcfJpqsF?=
 =?us-ascii?Q?j6cMfrkjQs4cqrIWSCoDTgMPZsj8gTB8dGpAmHsBLUYRVULsqTCEvF2EMCXx?=
 =?us-ascii?Q?OdIxZuIjmMalsTTJ54AU7aiWljaUmEs37urDy9eiAmCv1c+m+SfNVUbSVd+f?=
 =?us-ascii?Q?Oko6wTWXu9io7jKNG0fKjSjilr5Gr9SUk8kysyH67friHU8UtSMHJmX8ZJwe?=
 =?us-ascii?Q?RmfHm+j0EKbTkMCOuL32omVmM8RCj99pNDcBIvSJVngKBdWfDDYRX49rd7i9?=
 =?us-ascii?Q?KcbG5vxFVPxxVhY3Nnh40HAJOwb40zsRy1BpesBC/rtqxxkCFOe0/8NhXTEH?=
 =?us-ascii?Q?pArQxRRSd8KHjsIDEPgAXqIwS3wheheyRM8JmSEum6ggzrhfpEl/tZNPFg5h?=
 =?us-ascii?Q?g/xQ1cpKtRIq2hU9lX53eTt709N0jNbTxJ93f8Yiw7Dq2zSts4gsNHLLIyo5?=
 =?us-ascii?Q?SGsDowKVBItZy1gKQwm/mYbI2zu07W6+DhAlOVsZGxS2qHdLJ683RUxRK6U0?=
 =?us-ascii?Q?PIQ8orL6nZ3KRjaIHYR7Vf4SsvTnn+ZHclZWyEAiGPS1rEyJcMK7d88M47D2?=
 =?us-ascii?Q?HELoo2L6YysnB+Jxt3yj7kn4CSUu4SdGNAvNy12/YAICXW0ru1bb3/FkneEL?=
 =?us-ascii?Q?qFSLcC0U7xEXemtIUfzw8bTHUAoG2gGCJ8g9sbgaMyt6zuEETe0YjEzaY5kK?=
 =?us-ascii?Q?IT3H5SJablDoHDWSpyqDbObhIOMyHGI/TZWtEcFP/VHnz42pWLv08CnG1tfq?=
 =?us-ascii?Q?yIMakc3oDLsM+k/OLGgBIb5w6JSnInNqQ7HdowP4Pyc6hieix+OtWYSZ4GQC?=
 =?us-ascii?Q?Wca31PxIHw96b9k2c9kxxiC1pZVmoK35HyuIHUxhdVaGZ4Tlb4LkJtM2dhf4?=
 =?us-ascii?Q?nqoz+KRIajMgDEeI/8BCmcFVDrFzz4h2o7t4rK1AI7xJn1jX+SxHcEwIUKxB?=
 =?us-ascii?Q?Ipa+cUc+GdgCOkFDgQqIr8f5tB8/KUuQEp3fuQng19baE90AKHeyoCYR3yXI?=
 =?us-ascii?Q?8V70H9xqJPChJsEQpB/WI7SiTlUTmgaVO0k1E4Kfnh42k+fRPtWi4fc81/U2?=
 =?us-ascii?Q?NLBJQ1qA8RYDK0GYiCgRp878Wd2m3idkr247kw1n59us1waxE57qn/mO8naD?=
 =?us-ascii?Q?0fcc9dPSy1zmtkzt850T7tGOEkbR1gJxiUJeUIKmu0XoGmkmnLU8jj6KPhml?=
 =?us-ascii?Q?pt5FNa106GALoTlp/aNmrnRtTL+6c8eVH7aSf1evqeICOCzXtjuMxhFWyuRH?=
 =?us-ascii?Q?9c3K402gMpHatXmt+LlY8d8nh1rbSe0mRQNpiwyoKXUrf80wjaw3P+a+VcOR?=
 =?us-ascii?Q?UNeDpfF/wAZ7yYY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:51:03.4930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c33f10e-f80b-4c23-9f18-08dd1f7bc6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
Received-SPF: permerror client-ip=2a01:111:f403:2412::626;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

The GHCB specification[1] defines a VMGEXIT-based Guest Request
hypercall to allow an SNP guest to issue encrypted requests directly to
SNP firmware to do things like query the attestation report for the
guest. These are generally handled purely in the kernel.

In some some cases, it's useful for the host to be able to additionally
supply the certificate chain for the signing key that SNP firmware uses
to sign these attestation reports. To allow for this, the GHCB
specification defines an Extended Guest Request where this certificate
data can be provided in a special format described in the GHCB spec.
This certificate data may be global or guest-specific depending on how
the guest was configured. Rather than providing interfaces to manage
these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
to request the certificate contents from userspace. Implement support
for that here.

To synchronize delivery of the certificates to the guest in a way where
they will not be rendered invalid by updates to SNP firmware or
attestation singing/endorsement keys by management tools outside the
purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
obtain a shared/read lock on the certificate file prior to delivering
them back to KVM. Only after this will the attestation report be
retrieved from firmware and bundled with the certificate data, so QEMU
must continue to hold the file lock until KVM confirms that the
attestation report has been retrieved/bundled. This confirmation is done
by way of the kvm_immediate_exit callback infrastructure that was
introduced in a previous patch.

[1] "Guest Hypervisor Communication Block (GHCB) Standardization",
    https://www.amd.com/en/developer/sev.html

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qapi/qom.json                 |  23 +++-
 target/i386/kvm/kvm.c         |  10 ++
 target/i386/sev-sysemu-stub.c |   5 +
 target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
 target/i386/sev.h             |   2 +
 5 files changed, 288 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24cd8d..6eaf0e7721 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1034,6 +1034,25 @@
 #     firmware.  Set this to true to disable the use of VCEK.
 #     (default: false) (since: 9.1)
 #
+# @certs-path: Path to certificate data that can be passed to guests via
+#              SNP Extended Guest Requests. File should be in the format
+#              described in the GHCB specification. (default: none)
+#              (since: 10.0)
+#
+# @certs-timeout: Max time in milliseconds to wait to obtain a read lock
+#                 on the certificate file specified by @certs-path. This
+#                 is not a cumulative value and only affects how long
+#                 QEMU waits before returning execution to the vCPU and
+#                 informing the guest of the timeout, so the guest can
+#                 still continuing retrying for as long as it likes
+#                 (which will be about 60 seconds for linux guests at
+#                 the time of this writing). If the guest-side timeout
+#                 is insufficient, set this higher to allow more time to
+#                 fetch the certificate. If the guest-side timeout is
+#                 sufficient, set this lower to reduce the likelihood of
+#                 soft lockups in the guest.
+#                 (default: 100) (since: 10.0)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1045,7 +1064,9 @@
             '*id-auth': 'str',
             '*author-key-enabled': 'bool',
             '*host-data': 'str',
-            '*vcek-disabled': 'bool' } }
+            '*vcek-disabled': 'bool',
+            '*certs-path': 'str',
+            '*certs-timeout': 'uint32' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e17942c3b..cffc7ff33e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6107,6 +6107,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 #endif
     case KVM_EXIT_HYPERCALL:
         ret = kvm_handle_hypercall(run);
+        break;
+    case KVM_EXIT_SNP_REQ_CERTS:
+        if (!sev_snp_enabled()) {
+            error_report("KVM: Encountered a certificate request exit for a "
+                         "non-SEV-SNP guest.");
+            ret = -1;
+        } else {
+            ret = kvm_handle_snp_req_certs(cs, run);
+        }
+
         break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
diff --git a/target/i386/sev-sysemu-stub.c b/target/i386/sev-sysemu-stub.c
index d5bf886e79..685c56f62c 100644
--- a/target/i386/sev-sysemu-stub.c
+++ b/target/i386/sev-sysemu-stub.c
@@ -71,3 +71,8 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
 {
 }
+
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
+{
+    g_assert_not_reached();
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1a4eb1ada6..2c41bdbccf 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -157,6 +157,9 @@ struct SevSnpGuestState {
     char *id_auth_base64;
     uint8_t *id_auth;
     char *host_data;
+    char *certs_path;
+    int certs_fd;
+    uint32_t certs_timeout;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
@@ -1355,6 +1358,215 @@ sev_snp_launch_finish(SevCommonState *sev_common)
     }
 }
 
+static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
+{
+    int fd, ret;
+
+    if (sev_snp_guest->certs_fd != -1) {
+        return 0;
+    }
+
+    fd = qemu_open(sev_snp_guest->certs_path, O_RDONLY, NULL);
+    if (fd == -1) {
+        error_report("Unable to open certificate blob at path %s, ret %d",
+                     sev_snp_guest->certs_path, fd);
+        return fd;
+    }
+
+    ret = qemu_lock_fd(fd, 0, 0, false);
+    if (ret == -EAGAIN || ret == -EACCES) {
+        ret = -EAGAIN;
+        goto out_close;
+    } else if (ret) {
+        goto out_close;
+    }
+
+    sev_snp_guest->certs_fd = fd;
+    return 0;
+out_close:
+    close(fd);
+    return ret;
+}
+
+static void close_certs(SevSnpGuestState *sev_snp_guest)
+{
+    if (sev_snp_guest->certs_fd == -1) {
+        return;
+    }
+
+    qemu_unlock_fd(sev_snp_guest->certs_fd, 0, 0);
+    close(sev_snp_guest->certs_fd);
+    sev_snp_guest->certs_fd = -1;
+}
+
+static ssize_t get_certs_size(SevSnpGuestState *sev_snp_guest)
+{
+    ssize_t size;
+
+    size = lseek(sev_snp_guest->certs_fd, 0, SEEK_END);
+
+    if (size < 0)
+        return -errno;
+
+    return size;
+}
+
+static int read_certs(SevSnpGuestState *sev_snp_guest, void *buf, size_t buf_len)
+{
+    ssize_t n, len = 0;
+
+    n = lseek(sev_snp_guest->certs_fd, 0, SEEK_SET);
+    if (n) {
+        return n;
+    }
+
+    while ((n = read(sev_snp_guest->certs_fd, buf, buf_len)) != 0) {
+        if (n < 0) {
+            if (errno == EINTR) {
+                continue;
+            } else {
+                len = -errno;
+                break;
+            }
+        }
+        len += n;
+    }
+
+    return len;
+}
+
+static void snp_release_certs_lock(void *opaque)
+{
+    SevSnpGuestState *sev_snp_guest = opaque;
+
+    close_certs(sev_snp_guest);
+}
+
+static void certs_timeout(void *opaque)
+{
+    bool *timed_out = opaque;
+
+    *timed_out = true;
+}
+
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run)
+{
+    struct kvm_exit_snp_req_certs *req_certs = &run->snp_req_certs;
+    g_autofree gchar *contents = NULL;
+    SevSnpGuestState *sev_snp_guest;
+    MemTxAttrs attrs = { 0 };
+    bool timed_out = false;
+    QEMUTimer *timer;
+    uint32_t npages;
+    void *guest_buf;
+    hwaddr buf_sz;
+    hwaddr gpa;
+    int ret;
+
+    req_certs->ret = EIO;
+
+    if (!sev_snp_enabled()) {
+        return -EIO;
+    }
+
+    gpa = req_certs->gfn << TARGET_PAGE_BITS;
+    npages = req_certs->npages;
+
+    sev_snp_guest = SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
+    if (!sev_snp_guest->certs_path) {
+        req_certs->ret = 0;
+        return 0;
+    }
+
+    /*
+     * -EAGAIN from open_certs_locked() indicates that a lock could not be
+     * obtained on the certificate file. It would be possible to set
+     * req_certs->ret = EAGAIN to immediately inform the requesting vCPU of
+     * this condition so that it can retry again later, however, linux guests
+     * are currently hard-limited to a 60 second timeout, at which point they
+     * will assume misbehavior and refuse to continue issuing attestation
+     * requests from that point forward.
+     *
+     * Allowing for this guest timeout to be configured in some way that will
+     * be easier to coordinate with on the QEMU side will make that approach
+     * more viable, but until then just busy-wait on the QEMU side, which
+     * allows more flexibility in how long QEMU can wait for things like SNP
+     * firmware updates/etc. which may be holding an exclusive lock on the
+     * certificate.
+     *
+     * The down-side to doing things this way is that too long of a busy-wait
+     * will result in soft-lockups in the guest, but the guest will otherwise
+     * continue normally afterward.
+     *
+     * If the QEMU-side timeout is reached, then just go ahead and indicate
+     * EAGAIN to the guest, at which point the above-mentioned guest-side
+     * timeout will trigger if QEMU's timeout exceeds that of the guest. But
+     * that's better than killing the vCPU, which is the only viable
+     * alternative at that point.
+     */
+    timer = timer_new_ms(QEMU_CLOCK_REALTIME, certs_timeout, &timed_out);
+    timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                     sev_snp_guest->certs_timeout);
+
+    do {
+        ret = open_certs_locked(sev_snp_guest);
+        g_usleep(1000);
+    } while (ret == -EAGAIN && !timed_out);
+
+    timer_del(timer);
+
+    if (ret) {
+        if (timed_out) {
+            req_certs->ret = EAGAIN;
+            return 0;
+        }
+
+        /*
+         * It's a bit ambiguous when to propagate a generic error to the guest
+         * rather than simply letting QEMU crash. The general methodology here
+         * is to let QEMU crash if there is a misconfiguration issue that the
+         * guest has absolutely no potential role in, but to otherwise notify
+         * the guest if there is some remote possibility that the issue is
+         * related to something on the guest side.
+         */
+        return ret;
+    }
+
+    buf_sz = npages * TARGET_PAGE_SIZE;
+    if (buf_sz < get_certs_size(sev_snp_guest)) {
+        req_certs->ret = ENOSPC;
+        req_certs->npages =
+            (get_certs_size(sev_snp_guest) + TARGET_PAGE_SIZE) / TARGET_PAGE_SIZE;
+        close_certs(sev_snp_guest);
+        goto out;
+    }
+
+    guest_buf = address_space_map(&address_space_memory, gpa, &buf_sz, true, attrs);
+    if (buf_sz < npages * TARGET_PAGE_SIZE) {
+        error_report_once("Unable to map entire guest buffer, mapped size %ld (expected %ld)",
+                          buf_sz, get_certs_size(sev_snp_guest));
+        close_certs(sev_snp_guest);
+        goto out_unmap;
+    }
+
+    ret = read_certs(sev_snp_guest, guest_buf, buf_sz);
+    if (ret < 0) {
+        error_report_once("Unable to read certificate data into guest buffer, ret %d",
+                          ret);
+        close_certs(sev_snp_guest);
+        goto out_unmap;
+
+    }
+
+    req_certs->ret = 0;
+
+    add_immediate_exit_callback(cpu, snp_release_certs_lock, sev_snp_guest);
+out_unmap:
+    address_space_unmap(&address_space_memory, guest_buf, buf_sz, true, buf_sz);
+
+out:
+    return ret;
+}
 
 static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
@@ -1594,6 +1806,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
 static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(cgs);
     MachineState *ms = MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(ms);
 
@@ -1604,6 +1817,13 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
+    if (sev_snp_guest->certs_path &&
+        kvm_vm_enable_cap(kvm_state, KVM_CAP_EXIT_SNP_REQ_CERTS, 0, 1)) {
+        error_setg(errp, "Failed to enable support for SEV-SNP "
+                         "certificate-fetching requests.");
+        return -1;
+    }
+
     return 0;
 }
 
@@ -2393,6 +2613,26 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     memcpy(finish->host_data, blob, len);
 }
 
+static char *
+sev_snp_guest_get_certs_path(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return g_strdup(sev_snp_guest->certs_path);
+}
+
+static void
+sev_snp_guest_set_certs_path(Object *obj, const char *value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    if (sev_snp_guest->certs_path) {
+        g_free(sev_snp_guest->certs_path);
+    }
+
+    sev_snp_guest->certs_path = value ? g_strdup(value) : NULL;
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, void *data)
 {
@@ -2428,6 +2668,9 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "host-data",
                                   sev_snp_guest_get_host_data,
                                   sev_snp_guest_set_host_data);
+    object_class_property_add_str(oc, "certs-path",
+                                  sev_snp_guest_get_certs_path,
+                                  sev_snp_guest_set_certs_path);
 }
 
 static void
@@ -2440,6 +2683,12 @@ sev_snp_guest_instance_init(Object *obj)
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
+
+    sev_snp_guest->certs_fd = -1;
+    sev_snp_guest->certs_timeout = 100;
+    object_property_add_uint32_ptr(obj, "certs-timeout",
+                                   &sev_snp_guest->certs_timeout,
+                                   OBJ_PROP_FLAG_READWRITE);
 }
 
 /* guest info specific to sev-snp */
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 858005a119..91b9c38ac1 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -68,4 +68,6 @@ void sev_es_set_reset_vector(CPUState *cpu);
 
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size);
 
+int kvm_handle_snp_req_certs(CPUState *cpu, struct kvm_run *run);
+
 #endif
-- 
2.25.1


