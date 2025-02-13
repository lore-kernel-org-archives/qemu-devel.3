Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64032C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 10:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tisr6-0006mp-MV; Fri, 14 Feb 2025 05:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1tisr4-0006mh-Vf
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:23:31 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1tisqz-000826-RG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:23:30 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250214102319epoutp04f7e07dedbc74af91e88af4746ddcadef~kDAtqhXQb0546505465epoutp04B
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 10:23:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250214102319epoutp04f7e07dedbc74af91e88af4746ddcadef~kDAtqhXQb0546505465epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739528599;
 bh=Y+YmI6Fv+4dx1jCNiVWWElBmtPS0hoZA2vg6Skzhh8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o0fY1m5N2lpQ6hO/7ao1jN3kIbbD1i2Vrs/3N4wj1wkeUpp0Yy9ePaR56toLzIs3T
 D1+t5+1uFzTvNWbcSfShRaek0XKeNlw03Ix7SNX/sjeg9q2qHqO+nWN8zUULGIcS9g
 5mtFuNDpeIGr/GmcBC100XQiGimWD0F94MdoYIcM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20250214102318epcas5p1ae926a25ac7b6b81a517169295d58415~kDAtBYSiH0495704957epcas5p1j;
 Fri, 14 Feb 2025 10:23:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4YvSn03PSxz4x9Pt; Fri, 14 Feb
 2025 10:23:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9B.B5.19933.4991FA76; Fri, 14 Feb 2025 19:23:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250213091631epcas5p12bc4ff8f6f3498f400cf5f2cb1a42e96~judGrUT3r1560415604epcas5p11;
 Thu, 13 Feb 2025 09:16:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250213091631epsmtrp1cf59accc57012985e3c9bcadf7285db1~judGqhZpE2265622656epsmtrp1f;
 Thu, 13 Feb 2025 09:16:31 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-f4-67af199452a3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 44.94.33707.F68BDA76; Thu, 13 Feb 2025 18:16:31 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250213091629epsmtip1e54855622dae06f776471d16077ffced~judFQq1Cr2264222642epsmtip1r;
 Thu, 13 Feb 2025 09:16:29 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
 <vinayak.kh@samsung.com>
Subject: [PATCH v2 2/3] hw/cxl: factor out calculation of sanitize duration
 from cmd_santize_overwrite
Date: Thu, 13 Feb 2025 14:45:57 +0530
Message-Id: <20250213091558.2294806-3-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213091558.2294806-1-vinayak.kh@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpu4UyfXpBi/fSVhMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
 VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
 6Xp5qSVWhgYGRqZAhQnZGSf+2xR0ylc0HVjD2sC4QKyLkZNDQsBEYmLDVNYuRi4OIYHdjBIv
 nuxlgnA+MUrcPviGEc5Z9uoWK0zL0uanbBCJnYwSC189YYdwGpgkWpZtBKtiEzCQeNB8nB3E
 FhGQlPjddZoZxGYW+MAoseipLogtLJAhsWzHViYQm0VAVeLD0+9gNbwCthLtJ99AbZOX2H/w
 LFCcg4NTwE5i2stsiBJBiZMzn7BAjJSXaN46mxnkBgmBVg6J31enskP0ukj82LeDEcIWlnh1
 fAtUXEriZX8blF0sce7iJ6iaGonXXSuYIWx7idZT/WB7mQU0Jdbv0ocIy0pMPbWOCWIvn0Tv
 7ydMEHFeiR3zQGwOIFtFYunbTJhNX541Q033kPh46y8zJKgmMkpce/OQbQKjwiwk78xC8s4s
 hM0LGJlXMUqmFhTnpqcWmxYY5aWWw+M4OT93EyM4lWp57WB8+OCD3iFGJg7GQ4wSHMxKIrwS
 09akC/GmJFZWpRblxxeV5qQWH2I0BQb3RGYp0eR8YDLPK4k3NLE0MDEzMzOxNDYzVBLnbd7Z
 ki4kkJ5YkpqdmlqQWgTTx8TBKdXAlJRw/X72jO0BrnI7FyV0b+22vSJnsXJpaY9O2b3CWwxi
 6xKqmvnnekgzSn79vz/H8LnWJ3Xmvl+LDCbXn3FhOaY1x5QptvuDn8H6cGG3kiMFGac2Pzog
 WP2//cqx4BK/S2+fnvkhIXyq+JC3yBmHtX+7nDdUn1117yjnvd4bHiJWXOeOT544+fFTg098
 Tvyps4Lm907PKw9eenjKuY/3fz5c1WxmKGXyPGEPn2L5q7Qr4lZycusy3qYleXWGHONvvjKv
 al946+5/P9+u7UnmvXlhcv1n3VXWefLPWryc2K4UnL4s8f/etmnchT/bAi2WOio8M93Qq2H/
 /ZfMmdoy+bjg8orvKk7bPr9jzu2wUmIpzkg01GIuKk4EAN1nzb8uBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnG7+jrXpBnfbeCymH1a0+HJ6D5vF
 6ptrGC1uHtjJZLFw4zImi/OzTrFY/N22l9HieO8OFosTJ7ezA8XmsDtweeycdZfd48m1zUwe
 fVtWMXpMnV3v8XmTXABrFJdNSmpOZllqkb5dAlfGif82BZ3yFU0H1rA2MC4Q62Lk5JAQMJFY
 2vyUrYuRi0NIYDujROuRl4wQCSmJYzt/skHYwhIr/z1nhyj6xyjRtnEtO0iCTcBA4kHzcTBb
 REBS4nfXaWaQImaBX4wST3ffB0pwcAgLpEnc+MkKUsMioCrx4el3ZhCbV8BWov3kG1aIBfIS
 +w+eZQYp5xSwk5j2MhskLARUsrvzGhNEuaDEyZlPWEBKmAXUJdbPEwIJMwN1Nm+dzTyBUXAW
 kqpZCFWzkFQtYGRexSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREcEVpBOxiXrf+rd4iRiYPx
 EKMEB7OSCK/EtDXpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJM
 HJxSDUxsBQ2X2ObMM/dzLtl76bG1y9tZis7ZGv8vXVzzdnu9pO8E90tLfjEmV9ZePBe/9doJ
 5S1PdwnKHTmi5L7/X9axtjLBKM33rtzTosyXxugLdtfueFgry19f2mX2v6u/taw3/NIHd7uN
 TGu/8WZbWx41Smzb7fA+Ja/xWrzfr8Ta0MS6pZbJq7h3PPseWPNy11Mdm6zlNu4XfXVShT9N
 //BLaK5Pb89MBsG4mXpHP4R/n5G56EbSDRdnQ9Up+3kS7jb7zv3ToT/bxln73PddDZlrmWyv
 F4YEWYQusp2yPlfQ98jHGKaAyO/trY9qmJYr2izO6+SPPta9ZHFwIs/aOexsu8KT5HdqTeqP
 cbz6T4mlOCPRUIu5qDgRAKNOHPn3AgAA
X-CMS-MailID: 20250213091631epcas5p12bc4ff8f6f3498f400cf5f2cb1a42e96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213091631epcas5p12bc4ff8f6f3498f400cf5f2cb1a42e96
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
 <CGME20250213091631epcas5p12bc4ff8f6f3498f400cf5f2cb1a42e96@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=vinayak.kh@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Move the code of calculation of sanitize duration into function
for usability by other sanitize routines

Estimate times based on:
             https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 61 ++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index fa38ecf507..d58c20842f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1656,34 +1656,10 @@ static void __do_sanitization(CXLType3Dev *ct3d)
     cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
-/*
- * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
- *
- * Once the Sanitize command has started successfully, the device shall be
- * placed in the media disabled state. If the command fails or is interrupted
- * by a reset or power failure, it shall remain in the media disabled state
- * until a successful Sanitize command has been completed. During this state:
- *
- * 1. Memory writes to the device will have no effect, and all memory reads
- * will return random values (no user data returned, even for locations that
- * the failed Sanitize operation didn’t sanitize yet).
- *
- * 2. Mailbox commands shall still be processed in the disabled state, except
- * that commands that access Sanitized areas shall fail with the Media Disabled
- * error code.
- */
-static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
-                                         uint8_t *payload_in,
-                                         size_t len_in,
-                                         uint8_t *payload_out,
-                                         size_t *len_out,
-                                         CXLCCI *cci)
+static int get_sanitize_duration(uint64_t total_mem)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-    uint64_t total_mem; /* in Mb */
-    int secs;
+    int secs = 0;
 
-    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
     if (total_mem <= 512) {
         secs = 4;
     } else if (total_mem <= 1024) {
@@ -1712,6 +1688,39 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
         secs = 240 * 60; /* max 4 hrs */
     }
 
+    return secs;
+}
+
+/*
+ * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
+    secs = get_sanitize_duration(total_mem);
+
     /* EBUSY other bg cmds as of now */
     cci->bg.runtime = secs * 1000UL;
     *len_out = 0;
-- 
2.34.1


