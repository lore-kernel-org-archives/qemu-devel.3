Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88337C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 23:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruKae-0006TN-JU; Tue, 09 Apr 2024 19:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ruKad-0006TE-OW
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:09:19 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ruKaa-0005xB-QM
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:09:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIgmliFierrXCk/3rYnRtwyVsBLBOC+2KvOHQkWqFpim2J1jn32hMC9w+bi+a0jKmSNLZGPy+Qm456hj27zGAcdpKgdT78iUT/b9R/B9agz+viz4fODGJAPsPHUNaAugwEgfS53HvjxnsiVyre6HUnchgmePcxKPGtajcg/XSbk7ckpdJOr6NKNz1DhxcbK4wiXxgefXdfrmFYJrUKtWUQORtldH6IiDBeIzuUqNXnPorD+s9PBqV6IE6GWxievADHomRCyPvDvB5tIcCHJs0mJDrdhfSsvq+zQe2IPu9ARvXQ8tq4HFggLE/MfmSXv+FOcaroOffyREIjSuhHNcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty2IOTc9gTBaJQ7l7S7OWQpXxYtZfDrbKLLcPhLIR9E=;
 b=V0p6c3bwkD+UY6JJAwjuM3PL59U/HNJNb3x8+XGRTL/SreOvCylpt//sQTIlgrQVwhv7B+EtEzs0fUNI7XDdu/9subMUq/SAuC/OZDBXPmOUWck4nZtkLUZsabd+8ZeSKEb/MsEXc3xZzhfBh6s3d2xKCSoZqXTW2+e0ZLyDcxSXbF947JBH05OgYeCrw1uccQdNC9XM/FEweAEFQo3ci24QzYA4acqP/iR8irP5/Ltp/hZ6RTVM/pQ1Fybug188MYfpCiHDW1CVjh+lZUmrPiszONNhzP8T7vBpo2VTmLEpUJ9WQETvDifkik6xevL9+9mixV5+mEMPlbUxhQ3gOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty2IOTc9gTBaJQ7l7S7OWQpXxYtZfDrbKLLcPhLIR9E=;
 b=akWmIXDKB4iGeRmfsUTia/N0GXivqVQzBAM2iShjQn5SqEiGOxAl3sEne66NX8/fJMt1gKupMENOEYy75+iRVS0SwjkaNIGjxsL1kbST5XfWNEDjw6o/gHAXFRl1DUd5ERXCOeeA/hEYuLIQX4NkrOxvh18XCGSWUOkzDMxhe/Y=
Received: from BY5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:1d0::27)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 23:09:11 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::48) by BY5PR04CA0017.outlook.office365.com
 (2603:10b6:a03:1d0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 23:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 23:09:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 18:09:09 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Larry Dewey
 <Larry.Dewey@amd.com>, Roy Hopkins <roy.hopkins@suse.com>
Subject: [PATCH v1 3/3] hw/i386/sev: Use legacy SEV VM types for older machine
 types
Date: Tue, 9 Apr 2024 18:07:43 -0500
Message-ID: <20240409230743.962513-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409230743.962513-1-michael.roth@amd.com>
References: <20240409230743.962513-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: db23a42b-9102-435f-b690-08dc58ea10bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCasw7mFDxCdsRUopNe8I/j6uQtshA832J7THi2sWAHTmc4Sbqc/U4lX78/5CTrvLzsIfrgLCeCuuidpYJ6xwyhzgpgccwUuIJvTVIpwnFLHrFmudSFhwKMGZ/3pYUwd854/CvAAqLXTL96PSD/AFfLmIjSzaWS7yhAspupAYN1zmcN9RWClfVFEztkpRIZsBgkpvyD4MGjUf/ihzjR0eP1XPfx7GQd4dYp7dLsugMll7M8EJPXTvY/JUl/a6I0ATAEABLUl85oPRAIha3U5nsDbbln4ZPP3pgrGw7w2n7eYloSlPEMiUeVk4CHZDp7PZ6hx4D5QqEqXEXfckvZEOdCgMl+93YHzHqYmUpjE90P/yLGdF1ugChRa2OZwOuco3d50VpczoPAnSbpKv/GOzYGxwfmRIDovfTNADH4omIMeqWRRBDc+fCry6b9TEyCW3ELJZgHCPnnA0MyGJefQpiUpcBaxtPvIXK+at/rXlLz8WaRmOsvYvltT8MzoW0mQQelyncN9+aUrJCDhD6tuSU8e0nYXUWY/NzsdI/gCDymiZldkWjrdivEACtDGOG2mwyjvUVJoE40l+aAup0Pctauq/jpCpfuqPrJblb10DnWyxakp4dTKtGaVg11qGD6hLZfQ4yJgQHerKzZ1u8TL3Vj77KYyHYJpRaeOmJCy/SIOVmPJaxw8N/IeLfA/Y7hZcWI7l86YCf0iQMPvHjBiCQXAS8eCxi6px8o6IqefnX5ddz46446cnd55uoW2zz4X
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:09:10.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db23a42b-9102-435f-b690-08dc58ea10bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
Received-SPF: permerror client-ip=2a01:111:f403:2415::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

Newer 9.1 machine types will default to using the KVM_SEV_INIT2 API for
creating SEV/SEV-ES going forward. However, this API results in guest
measurement changes which are generally not expected for users of these
older guest types and can cause disruption if they switch to a newer
QEMU/kernel version. Avoid this by continuing to use the older
KVM_SEV_INIT/KVM_SEV_ES_INIT APIs for older machine types.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/i386/pc.c         | 5 +++++
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_q35.c     | 1 +
 include/hw/i386/pc.h | 3 +++
 target/i386/sev.c    | 1 +
 5 files changed, 11 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e80f02bef4..96bf90c17e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,6 +78,11 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_9_0[] = {
+    { "sev-guest", "legacy-vm-type", "true" },
+};
+const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
+
 GlobalProperty pc_compat_8_2[] = {};
 const size_t pc_compat_8_2_len = G_N_ELEMENTS(pc_compat_8_2);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 069414a1ac..0b7a9debab 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -528,6 +528,7 @@ static void pc_i440fx_9_0_machine_options(MachineClass *m)
     pc_i440fx_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
+    compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
 }
 
 DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 77d7f700a8..acb55fc787 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -380,6 +380,7 @@ static void pc_q35_9_0_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = NULL;
+    compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
 }
 
 DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fb1d4106e5..e52290916c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -199,6 +199,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_9_0[];
+extern const size_t pc_compat_9_0_len;
+
 extern GlobalProperty pc_compat_8_2[];
 extern const size_t pc_compat_8_2_len;
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f4ee317cb0..d30b68c11e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1417,6 +1417,7 @@ sev_guest_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "reduced-phys-bits",
                                    &sev->reduced_phys_bits,
                                    OBJ_PROP_FLAG_READWRITE);
+    object_apply_compat_props(obj);
 }
 
 /* sev guest info */
-- 
2.25.1


