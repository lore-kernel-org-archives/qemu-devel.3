Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF5FC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wM5-0006uD-CG; Mon, 31 Aug 2026 03:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wM3-0006tL-Sf; Mon, 31 Aug 2026 03:22:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wM2-0007KM-1l; Mon, 31 Aug 2026 03:22:55 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V53LNv1331002; Mon, 31 Aug 2026 07:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dNhRB15h6DtzkOqHf
 OMafOVUbQ/3UhWActHPrWHYlxs=; b=Y0pLz5u13G2bZioqoJ6jglWYWI/fxRzw9
 XlC8M+DAt0OQ9WKAABIM6e6VPM4Qp8TevhE/swa/fOiEoxOodEDCR6g8sfeTL4hl
 waA0rtPG2CHlrjfBUj4hJQhnjPXmFzZNlqqCvSBHEm/LIyvKqjNJoVycVK9LMICN
 1qcKpHNUfrXbxacrza56R9AeJxI3Hzo7pfW43XPfHudJPNKa2SxbuFGLbDsxCg2m
 WAyxhm/c0nVOm+7zTnq4KQ7U+QEQQCgyxf+lgC22fEQHozU35u8XRdNlc8AkGt/+
 aB6Mv5VCJRqXalqZtsVZjCXhsCaFB1JlqWpNS9v1ufUeMjpZpmFmQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2symcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V7BHwj025232;
 Mon, 31 Aug 2026 07:22:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq4rcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67V7MkFu37028164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 07:22:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B786E20049;
 Mon, 31 Aug 2026 07:22:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC74220040;
 Mon, 31 Aug 2026 07:22:43 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 07:22:43 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v4 4/6] ppc/spapr: Advertise RTAS error injection call support
 via FDT property
Date: Mon, 31 Aug 2026 12:49:56 +0530
Message-ID: <20260831071958.58824-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
References: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a952bcc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=LnazUrRgPASutW5i7uYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX8nsjJ433OOjL
 YSAq69OodUEDXNoIKV2iJo8+ioEkUP+937A21WhXL0JgBOas5ybOUM7XtD/9SA9VXw3kxMbYnpl
 TPNA9y8k0XUMjk7lUC238EM95ndWPkE=
X-Proofpoint-ORIG-GUID: bl52ieHqQ9V8yLsEO25-oe2jDP74XybG
X-Proofpoint-GUID: nmIZ3uPmAAgoU1HSYTZNkJLPQr8gFsc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfXwHpvZvl5IlR3
 KkgrKFpks5CxCEDYlbmIX2qSqObxRv8wKjTbAK86Q5xOsfru0r8e1vsatG8lsKVlGdkb/higU1p
 rLWn3fdUSMIAKBEj0Dor8kyUMJrBo9heL+SY2Gmdv4D+4Jun+FxMDe+/dwSJYhdN26wN6HJzgDO
 /6mFbllJq5W6K/w+tUsIsowGihhjHNoaMbQ3r+oLA+2HDJpMzy4HZtSt8UtVqkm+GgvjBvrok4r
 fY6XWvKZYL+0ERcC4ghwONpab+f4+TBQ6HkY60NCsi1+p4SnESHpbk4s3+0qM1MaKve6g2o6CzH
 3DJezZcdpXAJMQz9PUEPm60SVn9vr2asEfxcVpsQPSzgFyUtAN+4OAzPFwVY7+X50GNoiLC/OIK
 f7ojymDVPpY/ZHgkrnh2DdkE0S1TxlLLOBlbJ6pcgFHJS1vhwhlZZIjlH5SjfdQRRaG1ZPQluu8
 T08fHJXBHUeFhCN4icA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310059
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Advertise the supported ibm,errinjct token types to the guest through
the "ibm,errinjct-tokens" property under the RTAS node in the device
tree.

The property blob is built directly from a QEMU-side static table.
No host /proc/device-tree/rtas/ibm,errinjct-tokens probing is done
QEMU presents the same token set regardless of the host platform,
which avoids host-specific dependencies.

Each entry in the blob is a NUL-terminated token name string followed
by a big-endian uint32 type value, matching the PAPR specification for
ibm,errinjct-tokens.

"ibm,open-errinjct" and "ibm,close-errinjct" string properties are
also added to advertise the session-management calls.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 20e024907b..4c5b06d03d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -116,6 +116,8 @@
 
 #define PHANDLE_INTC            0x00001111
 
+#define ERRINJCT_BLOB_MAX       512
+
 /* These two functions implement the VCPU id numbering: one to compute them
  * all and one to identify thread 0 of a VCORE. Any change to the first one
  * is likely to have an impact on the second one, so let's keep them close.
@@ -1081,6 +1083,65 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
      */
     _FDT(fdt_setprop(fdt, rtas, "ibm,extended-os-term", NULL, 0));
 
+    /*
+     * Advertise supported ibm,errinjct token types to the guest via the
+     * "ibm,errinjct-tokens" RTAS FDT property.  The blob is built locally
+     * from the QEMU-side token table; no /proc/device-tree probing is done.
+     * Each entry is: NUL-terminated name string || big-endian uint32 type.
+     */
+    {
+        static const struct {
+            const char *name;
+            uint32_t type;
+        } tok_table[] = {
+            { "recovered-special-event",
+              RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT },
+            { "corrupted-page",     RTAS_ERR_TYPE_CORRUPTED_PAGE          },
+            { "ioa-bus-error",      RTAS_ERR_TYPE_IOA_BUS_ERROR           },
+            { "corrupted-dcache-start",
+              RTAS_ERR_TYPE_CORRUPTED_DCACHE_START  },
+            { "corrupted-dcache-end",
+              RTAS_ERR_TYPE_CORRUPTED_DCACHE_END    },
+            { "corrupted-icache-start",
+              RTAS_ERR_TYPE_CORRUPTED_ICACHE_START  },
+            { "corrupted-icache-end",
+              RTAS_ERR_TYPE_CORRUPTED_ICACHE_END    },
+            { "corrupted-tlb-start",
+              RTAS_ERR_TYPE_CORRUPTED_TLB_START     },
+            { "corrupted-tlb-end",  RTAS_ERR_TYPE_CORRUPTED_TLB_END       },
+            { "ioa-bus-error-64",   RTAS_ERR_TYPE_IOA_BUS_ERROR_64        },
+        };
+        g_autofree char *errinject_tokens = NULL;
+        uint8_t blob[ERRINJCT_BLOB_MAX];
+        size_t blen = 0;
+        bool ok = true;
+
+        for (int i = 0; i < G_N_ELEMENTS(tok_table) && ok; i++) {
+            size_t slen = strlen(tok_table[i].name) + 1;
+            uint32_t be_type;
+
+            if (blen + slen + sizeof(be_type) > ERRINJCT_BLOB_MAX) {
+                ok = false;
+                break;
+            }
+            memcpy(blob + blen, tok_table[i].name, slen);
+            blen += slen;
+            be_type = cpu_to_be32(tok_table[i].type);
+            memcpy(blob + blen, &be_type, sizeof(be_type));
+            blen += sizeof(be_type);
+        }
+
+        if (ok) {
+            errinject_tokens = g_memdup2(blob, blen);
+            _FDT(fdt_setprop(fdt, rtas, "ibm,errinjct-tokens",
+                             errinject_tokens, blen));
+            _FDT(fdt_setprop_string(fdt, rtas, "ibm,open-errinjct",
+                                    "ibm,open-errinjct"));
+            _FDT(fdt_setprop_string(fdt, rtas, "ibm,close-errinjct",
+                                    "ibm,close-errinjct"));
+        }
+    }
+
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
-- 
2.54.0


