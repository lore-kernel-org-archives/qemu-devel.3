Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E41EC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvO6-0004fa-2G; Mon, 17 Feb 2025 02:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNe-0004QW-Nw; Mon, 17 Feb 2025 02:17:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNc-0002ei-L5; Mon, 17 Feb 2025 02:17:26 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H5OGJU031595;
 Mon, 17 Feb 2025 07:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9xcPVryMSyHHjxiRM
 EC9nJ/p20WPuyHiZSA1Y0UzFcU=; b=MiiFUDlGQJlc50F3VPyeXTjKCNxGMhGk/
 yC7B4okcwofWh4Yfe2W11o7kTcjetQHPIU2PZ2qXrr6swr6aUYXcpErMni5qmY+i
 hDkln3p/X+ELebrGNAWEGVP8nh9jQOnl/9xRqQxMk7FHMX8jN8ZpCre5C7gRLGD/
 7s12mxopQ+QzvMlzrsLp9W73GzlScSajBAoCNx2m94czGh2LftsJhYTpbzljf/Yn
 ZTTS+aXA7jllAlyoFsXzE9o6t8XhacmcepQ1VRsHG5RgJ1IaTVsK8S1/EKisZlW6
 oNTq5y3kaULvXUd4rjlxXZZ/M91ejKTKnuUdHse7MiCE7Ms4fM11g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7rf34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7AWPO027272;
 Mon, 17 Feb 2025 07:17:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7rf2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H42LJV003891;
 Mon, 17 Feb 2025 07:17:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68nmy9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7HFae57606594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:17:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1AD42004B;
 Mon, 17 Feb 2025 07:17:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D2FE20049;
 Mon, 17 Feb 2025 07:17:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:17:14 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 1/6] hw/ppc: Implement skeleton code for fadump in PSeries
Date: Mon, 17 Feb 2025 12:47:06 +0530
Message-ID: <20250217071711.83735-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071711.83735-1-adityag@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m4Q4NuZ-M0geb_xqlmkt0JfuXag-xxVb
X-Proofpoint-ORIG-GUID: ehhzXck6K6trl28Kd3-hnHj4h2GbqV1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement the handler for "ibm,configure-kernel-dump" rtas call in QEMU.

Currently the handler just does basic checks and handles
register/unregister/invalidate requests from kernel.

Fadump will be enabled in a later patch.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr_rtas.c    | 99 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h | 59 +++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index df2e837632aa..eebdf13b1552 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -341,6 +341,105 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
     rtas_st(rets, 0, ret);
 }
 
+struct fadump_metadata fadump_metadata;
+
+/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
+static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args,
+                                   uint32_t nret, target_ulong rets)
+{
+    struct rtas_fadump_section_header header;
+    target_ulong cmd = rtas_ld(args, 0);
+    target_ulong fdm_addr = rtas_ld(args, 1);
+    target_ulong fdm_size = rtas_ld(args, 2);
+
+    /* Number outputs has to be 1 */
+    if (nret != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "FADUMP: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
+        return;
+    }
+
+    /* Number inputs has to be 3 */
+    if (nargs != 3) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    switch (cmd) {
+    case FADUMP_CMD_REGISTER:
+        if (fadump_metadata.fadump_registered) {
+            /* Fadump already registered */
+            rtas_st(rets, 0, RTAS_OUT_DUMP_ALREADY_REGISTERED);
+            return;
+        }
+
+        if (fadump_metadata.fadump_dump_active == 1) {
+            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
+            return;
+        }
+
+        if (fdm_size < sizeof(struct rtas_fadump_section_header)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADUMP: Header size is invalid: %lu\n", fdm_size);
+            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+            return;
+        }
+
+        /* XXX: Can we ensure fdm_addr points to a valid RMR-memory buffer ? */
+        if (fdm_addr <= 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADUMP: Invalid fdm address: %ld\n", fdm_addr);
+            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+            return;
+        }
+
+        /* Verify that we understand the fadump header version */
+        cpu_physical_memory_read(fdm_addr, &header, sizeof(header));
+        if (header.dump_format_version != cpu_to_be32(FADUMP_VERSION)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADUMP: Unknown fadump header version: 0x%x\n",
+                header.dump_format_version);
+            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+            return;
+        }
+
+        fadump_metadata.fadump_registered = true;
+        fadump_metadata.fadump_dump_active = false;
+        fadump_metadata.fdm_addr = fdm_addr;
+        break;
+    case FADUMP_CMD_UNREGISTER:
+        if (fadump_metadata.fadump_dump_active == 1) {
+            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
+            return;
+        }
+
+        fadump_metadata.fadump_registered = false;
+        fadump_metadata.fadump_dump_active = false;
+        fadump_metadata.fdm_addr = -1;
+        break;
+    case FADUMP_CMD_INVALIDATE:
+        if (fadump_metadata.fadump_dump_active) {
+            fadump_metadata.fadump_registered = false;
+            fadump_metadata.fadump_dump_active = false;
+            fadump_metadata.fdm_addr = -1;
+            memset(&fadump_metadata.registered_fdm, 0,
+                    sizeof(fadump_metadata.registered_fdm));
+        } else {
+            hcall_dprintf("fadump: Nothing to invalidate, no dump active.\n");
+        }
+        break;
+    default:
+        hcall_dprintf("Unknown RTAS token 0x%x\n", token);
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static void rtas_ibm_os_term(PowerPCCPU *cpu,
                             SpaprMachineState *spapr,
                             uint32_t token, uint32_t nargs,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a6c0547e313d..efa2f891a8a7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -704,6 +704,8 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define RTAS_OUT_PARAM_ERROR                    -3
 #define RTAS_OUT_NOT_SUPPORTED                  -3
 #define RTAS_OUT_NO_SUCH_INDICATOR              -3
+#define RTAS_OUT_DUMP_ALREADY_REGISTERED        -9
+#define RTAS_OUT_DUMP_ACTIVE                    -10
 #define RTAS_OUT_NOT_AUTHORIZED                 -9002
 #define RTAS_OUT_SYSPARM_PARAM_ERROR            -9999
 
@@ -769,6 +771,63 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 
 #define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
 
+/* Fadump commands */
+#define FADUMP_CMD_REGISTER            1
+#define FADUMP_CMD_UNREGISTER          2
+#define FADUMP_CMD_INVALIDATE          3
+
+#define FADUMP_VERSION    1
+
+/*
+ * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
+ * in the dump memory structure. Presently, three sections are used for
+ * CPU state data, HPTE & Parameters area, while the remaining seven sections
+ * can be used for boot memory regions.
+ */
+#define FADUMP_MAX_SECTIONS            10
+#define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
+
+/* Kernel Dump section info */
+struct rtas_fadump_section {
+    __be32    request_flag;
+    __be16    source_data_type;
+    __be16    error_flags;
+    __be64    source_address;
+    __be64    source_len;
+    __be64    bytes_dumped;
+    __be64    destination_address;
+};
+
+/* ibm,configure-kernel-dump header. */
+struct rtas_fadump_section_header {
+    __be32    dump_format_version;
+    __be16    dump_num_sections;
+    __be16    dump_status_flag;
+    __be32    offset_first_dump_section;
+
+    /* Fields for disk dump option. */
+    __be32    dd_block_size;
+    __be64    dd_block_offset;
+    __be64    dd_num_blocks;
+    __be32    dd_offset_disk_path;
+
+    /* Maximum time allowed to prevent an automatic dump-reboot. */
+    __be32    max_time_auto;
+};
+
+struct rtas_fadump_mem_struct {
+    struct rtas_fadump_section_header header;
+    struct rtas_fadump_section        rgn[FADUMP_MAX_SECTIONS];
+};
+
+struct fadump_metadata {
+    bool fadump_registered;
+    bool fadump_dump_active;
+    target_ulong fdm_addr;
+    struct rtas_fadump_mem_struct registered_fdm;
+};
+extern struct fadump_metadata fadump_metadata;
+
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
 #define RTAS_SYSPARM_DIAGNOSTICS_RUN_MODE        42
-- 
2.48.1


