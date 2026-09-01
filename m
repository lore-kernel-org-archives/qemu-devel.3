Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA6C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SUx-0002N1-VE; Tue, 01 Sep 2026 13:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUi-0002Ki-MB; Tue, 01 Sep 2026 13:42:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUg-0001BN-P5; Tue, 01 Sep 2026 13:42:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H4xTY1791409; Tue, 1 Sep 2026 17:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hKQuSXR1kqgR808OI
 zjRax84ayGt+vvJWRiE0sO2lNA=; b=SSwnLATmd1qc7SmN0qjEMFelSOlbpvGrv
 GGCkJYl7s18ltI2q+xbB63IkVp+riih0nYL+fTWcpJ/lGntaLPJBbQtWcnSUUNk8
 Yu7wgnCYmwzKjvGjGQj1fk+5fSKckf8VovsW70HChdiOHYKTjre2eZXMBlx4l0HQ
 bl2RXj2mzvth2U7snQgAbN9xa+W0jWCPlkzP7M/eW1AZIJptAc425iSqjyKK/yXD
 XaOm4CMGnenG6EssjqPP4j//zPsYrvlsviH2yx8xQ+qa1u9JVhZOI6LVuO/XIHRw
 Ca/e4ex0y+IC06awrDTa9YkFhfWz7DNA43ATaz0uvgjL3uCkXusGQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5hgf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681HQRP6001912;
 Tue, 1 Sep 2026 17:41:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w5479-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 681HfolO50725288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 17:41:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A6792004E;
 Tue,  1 Sep 2026 17:41:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0890420043;
 Tue,  1 Sep 2026 17:41:47 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.219.126])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 17:41:46 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v5 4/6] ppc/spapr: Advertise RTAS error injection call support
 via FDT property
Date: Tue,  1 Sep 2026 23:11:08 +0530
Message-ID: <20260901174110.45356-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a970e65 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LnazUrRgPASutW5i7uYA:9
X-Proofpoint-GUID: CKqTADGgy6lgmfZRvBhBwJHmyMSbM9jQ
X-Proofpoint-ORIG-GUID: 3K5u4MTLKBFy6Im8B2GXdRZWBohvszHg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfXwM9pBTgT2qUx
 5Dl2xo+UhDwQeHJL4NbRykVfMpVglA/rcumvwUf+WjnASGc7hPjaX2HmJpeof53xtENYtGOh5/6
 3XtBjwW9HmiHBkHf9VIXf0LQ9P5StpA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfXzUVSayTknDck
 LyiyGjZMTUnPtbNmrSvBPcCDLmuWef13ZQhuDx/Gi8+OSP5isgi0OxSzviNjXA1AfDBABxd5qmY
 nmaM9UkRYT0fQMTPwyNtVy2NmQqFBg2G13I6q59VKDayRAfFcNHL2sui+DDsm1u36wePdX6cpwD
 5nzqj56UQ4x8fmivXBEqA311hhGSzXfUzCdFuJ/n8WD2M47vEv8N55Xsu46XP+XOzCEHFCr9xe/
 by+bA9iFVTlYrvLUjyOzX7YnQxHBf53p0xJkVNS/2TxKs647agT6DHwsR9+YAd4ov2dR7gWd939
 G/QdT4K8p3qc6wj/C+CHDSGCBVAu8fbR7rk0fZpOm9xNHTsQuO9pAMSvfPDXX22alX41QiUNGbe
 y3SabCmRQS7qyfC+TOOPn7A6w94a5veMZPRUzSuMUQ8XmybLsR4zE8w7DoeQZinAvf5jVRuLli3
 63x2h+Ug1WkLfUZexGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010155
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
2.51.1


