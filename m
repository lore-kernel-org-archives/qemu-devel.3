Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2071ACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBWG-0006Mx-8g; Wed, 29 Oct 2025 15:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBWB-0006MI-Ms; Wed, 29 Oct 2025 15:07:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBW0-0001PK-4m; Wed, 29 Oct 2025 15:07:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TC6kdr025645;
 Wed, 29 Oct 2025 19:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ECb2xfE+GzOP0lSP6
 3dCsi5rgcQWNkidDjZYytOst/8=; b=O6YrXUcT6mq2g9XwTtlS5h8n1kKNAX12Y
 DWCt9d3bWYiIRWNfc5J8L+SkIvboLP0eTJ0TuNcV+Mh8TDapRLPsjSrgzA+3Q/8D
 T9Uz9Nu9+V1qkOe+niyeC3H/mPI4fKwLe11DnhnPHFNovkzctbH62Rn2zeBG7c8T
 uxQvNFNMmyggOip8yV791fJ57TDChmrJPVLJJEdJJmerA9dkr8XWI4mcfiF2/mlb
 kHLYvPB8URN+g8MMvUv0QFhPNRmfG15bldaqTXLSdXq3p+CudjBVkwulNW9++Afh
 bB35dLMqcSR5o8d1uo4PiK0aQnzQs/Gix6OphRZVEy47qXfe0qKdg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acn2x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TJ2Qnx029338;
 Wed, 29 Oct 2025 19:07:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acn2x5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGh1HW030714;
 Wed, 29 Oct 2025 19:07:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwn1n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TJ77B955771582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 19:07:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CBA620049;
 Wed, 29 Oct 2025 19:07:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14BDD20040;
 Wed, 29 Oct 2025 19:07:06 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 19:07:05 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: mahesh@linux.ibm.com, ganeshgr@linux.ibm.com
Subject: [RFC 4/4] ppc/spapr: Advertise RTAS error injection call support via
 FDT property
Date: Wed, 29 Oct 2025 10:06:18 -0500
Message-ID: <20251029150618.186803-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
References: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=690265e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=nNPvQeRNBT9IKkD_gJkA:9
X-Proofpoint-ORIG-GUID: G45XxM0orDulbhSaYFtxnRNAtVMIroqb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX7hLtUSEBY9UR
 gJ/xGVXuEddIsde0V3wE1r0iCtban+qEaQl+ib2CYqglSuX8m4tI6ssC/19U1PDNj2m95YYFd2h
 fLlsNmUfnxRvI7nuW6WBWmJUsy9TPJDHMgAS37H3p8zlvOtmx4lWE015+Mya+iZwK/aePX1X21J
 CrYSweDczS3bDtlDCA2gqxGzsmnJSudZhwIfsfpHceO1FxMiRxA6+fTO05/mTyOuofB8ZPzmfhN
 1kNzs6EYAVj8OzGvVOWClm8iFILpxvn/Bu+zihxqD1ZgGR1Hs/WMynMlFTKFJpp6obsd0BqueWP
 KZ1PRA30/C/NoIC3ZwRSMiyv63RGrFPooGzUBwybcgVbPFMRLot8t2Y/Ly+4PsKHZw+h29335yW
 NmkUh5qgHXojl4EszRnBLC68c1oWNA==
X-Proofpoint-GUID: tMn96BJAQp8FBZPB8PWG7uO6qNWMqSNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index e0a2e5a984..0ca8c777d5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -114,6 +114,8 @@
 
 #define PHANDLE_INTC            0x00001111
 
+#define ERR_BLOB_MAX            512
+
 /* These two functions implement the VCPU id numbering: one to compute them
  * all and one to identify thread 0 of a VCORE. Any change to the first one
  * is likely to have an impact on the second one, so let's keep them close.
@@ -900,10 +902,104 @@ static int spapr_dt_rng(void *fdt)
     return ret ? -1 : 0;
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
@@ -1012,6 +1108,16 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
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
2.51.0


