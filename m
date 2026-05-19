Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E77CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHm3-0001qO-FP; Tue, 19 May 2026 06:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHlz-0001pQ-KQ; Tue, 19 May 2026 06:34:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHlx-0005Gv-J0; Tue, 19 May 2026 06:34:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JAVCoH4037410; Tue, 19 May 2026 10:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nWGxl4Ceh9AbrghqM
 SsTySbVESl8QiNAXUM20ljfeCg=; b=q1jY7XDYfJT8JvdkxK4AxLQBFb5TuAHr0
 NuC+6hZq4FzKY5ePrTJor/nMqiHhYtm5S424ae5XL9XSnX+JEjUfakctfxuqLFNH
 AxuDwyMZNEoLmLOz0KHfei/MFwXRd4033WwswoXe4DGC0PPZZNAj11S4D5KkAfez
 gGzAt3EybiJ8MMM7q3WQ89JICNqVTnrHO1r504wEHmG3onih5Na7poZd6/qy/QDI
 NjlCzMwfr098gKiUu16HtnxnzPergrV1RMf10IJdBNN8nbBiKGMWr/vlP1mq0WkD
 YQmy1n0C3v+8bvNy1Cp3lhYiA4LDmfbTY4h7CLujL+B6I412XAyRA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74veqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAO80g013256;
 Tue, 19 May 2026 10:33:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vt873-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64JAXrVp32375228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 10:33:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40EAA20043;
 Tue, 19 May 2026 10:33:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF2EA2004B;
 Tue, 19 May 2026 10:33:50 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 May 2026 10:33:50 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v2 4/6] ppc/spapr: Advertise RTAS error injection call support
 via FDT property
Date: Tue, 19 May 2026 16:03:22 +0530
Message-ID: <20260519103325.8056-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
References: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0c3c96 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=nNPvQeRNBT9IKkD_gJkA:9
X-Proofpoint-ORIG-GUID: qW1YtGR-c7nud1sl8A7Bx76OOP_3tSn1
X-Proofpoint-GUID: gVORSflNXqYTSYk4idtKNCcRBftnaOC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5OSBTYWx0ZWRfX8doDIh2yZUY4
 cWRvlH+dhMkIXuXzP+j9CKfn2tsYnzHJI9jlZgXp1VCkCGOr193hlDgnEp+5Hq6jS1AoYjzzceP
 rz6nbRZ3Lj2qgLunExGMeHxQZqeslX4jnD++o3ex2XQfUd8/ruJbdCIdt5WlMWSghSXSEfseuAQ
 q2kEhPla7FoPgQM2YTJ3dB+cYpANSgAI6nbYNSAt2cbMlcj0fDIQZ1/R4NDIbWvfW9m38i82tJ3
 TkG2tcBx5oD2anbEqOLLrddAfoBnHOaTGnMDbu3JzMDi73K/+e7GXrLuUDUgg+CXTjm7B8xZe11
 MMZDcfSV0SIziI8ttq/X4H1OZ5ugl/lhcxcC0Ws6ONQYk2Y6B57AV2mhXiPz2YTYsRt2U3KOGfm
 1+yQCs5pORCG+Yetic/ZOAi8NtdLO9WrlXXmaCDNlIDBC7NQwPmK3bMn33DwN0BM0FHL7OICi+7
 tdm1FiltiyWu8xZcZBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190099
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Advertise RTAS error injection call support to guests through a new
"ibm,errinjct-tokens" property under the RTAS node in the device tree.

This patch introduces:
  - spapr_get_errinject_tokens(), which retrieves or constructs a blob
    of supported error injection tokens from the host or fallback data.
  - Integration of "ibm,errinjct-tokens" into the RTAS FDT node.
  - Addition of "ibm,open-errinjct" and "ibm,close-errinjct" properties
    to advertise open/close handlers for error injection sessions.

The ibm,errinjct-tokens property allows guests to programmatically
discover supported RTAS error injection facilities, enabling safe and
dynamic usage. The helper routine allocates memory for the token blob,
which the caller must free once it has been added to the FDT.

If the device-tree file (/proc/device-tree/rtas/ibm,errinjct-tokens)
is not available, a static fallback blob is generated internally.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d40af312fa..bf6c838e0a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -115,6 +115,8 @@
 
 #define PHANDLE_INTC            0x00001111
 
+#define ERR_BLOB_MAX            512
+
 /* These two functions implement the VCPU id numbering: one to compute them
  * all and one to identify thread 0 of a VCORE. Any change to the first one
  * is likely to have an impact on the second one, so let's keep them close.
@@ -968,10 +970,104 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
     }
 }
 
+/*
+ * spapr_get_errinject_tokens:
+ * ---------------------------
+ * Retrieve or construct a binary blob representing supported RTAS error
+ * injection tokens. If the host device-tree path
+ * "/proc/device-tree/rtas/ibm,errinjct-tokens" exists, it is read directly.
+ * Otherwise, a static fallback list of tokens is generated.
+ *
+ * The caller receives a dynamically allocated buffer in @out_buf and
+ * its size in @out_size, both of which must be freed by the caller
+ * once used.
+ *
+ * Returns:
+ *   0 (EXIT_SUCCESS)  - on success
+ *  -EIO, -ENOMEM      - on failure
+ */
+static int spapr_get_errinject_tokens(char **out_buf, size_t *out_size)
+{
+    char *path = NULL, *buf = NULL;
+    gsize len = 0;
+    uint8_t errinjct_blob[ERR_BLOB_MAX];
+
+    static const struct {
+        const char *name;
+        enum rtas_err_type token;
+    } errinjct_tokens[] = {
+        { "recovered-special-event", RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT },
+        { "corrupted-page",          RTAS_ERR_TYPE_CORRUPTED_PAGE },
+        { "ioa-bus-error",           RTAS_ERR_TYPE_IOA_BUS_ERROR },
+        { "corrupted-dcache-start",  RTAS_ERR_TYPE_CORRUPTED_DCACHE_START },
+        { "corrupted-dcache-end",    RTAS_ERR_TYPE_CORRUPTED_DCACHE_END },
+        { "corrupted-icache-start",  RTAS_ERR_TYPE_CORRUPTED_ICACHE_START },
+        { "corrupted-icache-end",    RTAS_ERR_TYPE_CORRUPTED_ICACHE_END },
+        { "corrupted-tlb-start",     RTAS_ERR_TYPE_CORRUPTED_TLB_START },
+        { "corrupted-tlb-end",       RTAS_ERR_TYPE_CORRUPTED_TLB_END },
+        { "ioa-bus-error-64",        RTAS_ERR_TYPE_IOA_BUS_ERROR_64 },
+    };
+
+    path = g_strdup("/proc/device-tree/rtas/ibm,errinjct-tokens");
+
+    if (g_file_test(path, G_FILE_TEST_EXISTS)) {
+        qemu_log("RTAS: Found %s\n", path);
+
+        if (!g_file_get_contents(path, &buf, &len, NULL)) {
+            error_report("RTAS: Failed to read %s", path);
+            g_free(path);
+            return -EIO;
+        }
+
+        qemu_log("RTAS: Read %zu bytes from device-tree\n", len);
+        *out_buf = buf;
+        *out_size = len;
+        g_free(path);
+        return EXIT_SUCCESS;
+    }
+
+    qemu_log("RTAS: %s not found, building fallback blob\n", path);
+    g_free(path);
+    len = 0;
+
+    for (int i = 0; i < G_N_ELEMENTS(errinjct_tokens); i++) {
+        const char *name = errinjct_tokens[i].name;
+        size_t str_len = strlen(name) + 1;
+
+        if (len + str_len + sizeof(uint32_t) > sizeof(errinjct_blob)) {
+            error_report("RTAS: Too many tokens for static buffer");
+            return -ENOMEM;
+        }
+
+        memcpy(&errinjct_blob[len], name, str_len);
+        len += str_len;
+
+        uint32_t be_token = cpu_to_be32(errinjct_tokens[i].token);
+        memcpy(&errinjct_blob[len], &be_token, sizeof(be_token));
+        len += sizeof(be_token);
+    }
+
+    buf = g_malloc(len);
+    if (!buf) {
+        error_report("RTAS: Failed to allocate %zu bytes for blob", len);
+        return -ENOMEM;
+    }
+
+    memcpy(buf, errinjct_blob, len);
+    *out_buf = buf;
+    *out_size = len;
+
+    qemu_log("RTAS: Fallback blob built (%zu bytes)\n", len);
+    return EXIT_SUCCESS;
+}
+
+
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *ms = MACHINE(spapr);
     int rtas;
+    size_t size_tokens = 0;
+    g_autofree char *errinject_tokens;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
     uint64_t max_device_addr = 0;
@@ -1080,6 +1176,16 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
      */
     _FDT(fdt_setprop(fdt, rtas, "ibm,extended-os-term", NULL, 0));
 
+    if (!spapr_get_errinject_tokens(&errinject_tokens, &size_tokens)) {
+        _FDT(fdt_setprop(fdt, rtas, "ibm,errinjct-tokens",
+                         errinject_tokens, size_tokens));
+
+        _FDT(fdt_setprop_string(fdt, rtas, "ibm,open-errinjct",
+                                "ibm,open-errinjct"));
+        _FDT(fdt_setprop_string(fdt, rtas, "ibm,close-errinjct",
+                                "ibm,close-errinjct"));
+    }
+
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
-- 
2.54.0


