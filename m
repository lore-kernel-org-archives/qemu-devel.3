Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EE7C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfCvw-0002Fe-FX; Tue, 04 Feb 2025 02:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tfCBR-0001BY-FF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:13:17 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tfCBN-0002DJ-QY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:13:17 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250204061308epoutp013eac8c377779268fd286b41581a2c781~g7JbYF3xt2291622916epoutp01o
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2025 06:13:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250204061308epoutp013eac8c377779268fd286b41581a2c781~g7JbYF3xt2291622916epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1738649588;
 bh=vE7n1HalGgEXx2bFiYFPN1dtSGXSwvCf8X7QgFrUhdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qVyowM0PCbKwErYLahLhcshcOBQS9KDFqV7lTy6oNfh6aJ1oNK0Feaia2ANqRt6jm
 LcHabj2xJdXkcwwXdYB0sB7V1IuMSg5mmswBMY0VxO2UNOYCtcc9L9Q+Acj5EHe3e+
 AWmOlUMWH7kUY78awpMC+KF+8uxWbYa1pvukjsH4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20250204061308epcas5p4cbd57c134a3e5a95b2ceb7134ff5301b~g7Ja9Rv9q2524825248epcas5p4e;
 Tue,  4 Feb 2025 06:13:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4YnChx3Ntbz4x9Q0; Tue,  4 Feb
 2025 06:13:05 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 54.1E.19956.FEFA1A76; Tue,  4 Feb 2025 15:13:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20250203060055epcas5p4a7889ddf3b73b10f8b9b41778375ce63~gnVdyEX0F2144221442epcas5p4N;
 Mon,  3 Feb 2025 06:00:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250203060055epsmtrp1bcd9a875fd7960ea1d529226fac9e18f~gnVdxB1YC2494724947epsmtrp1-;
 Mon,  3 Feb 2025 06:00:55 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-74-67a1afefec64
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 28.75.33707.69B50A76; Mon,  3 Feb 2025 15:00:54 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250203060053epsmtip22753a1051d82e7e51a79bf7bd47a3110~gnVcTXow62964429644epsmtip2V;
 Mon,  3 Feb 2025 06:00:53 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH 3/3] hw/cxl/cxl-mailbox-utils.c: Added support for Populate
 Log (Opcode 0404h) as background operation
Date: Mon,  3 Feb 2025 11:29:50 +0530
Message-Id: <20250203055950.2126627-4-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmlu779QvTDfafNreYfljR4svpPWwW
 vYuXsFqsvrmG0eLmgZ1MFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfd48m1zUwe
 fVtWMXpMnV3v8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
 qq2Si0+ArltmDtBNSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
 dL281BIrQwMDI1OgwoTsjK5371gKnqpVNCy7zt7A+Fayi5GTQ0LAROLPjE6WLkYuDiGB3YwS
 My80M0I4nxgluhY0M8M577/fYYJp2XztKxtEYiejxP22h1D9DUwSk062MYNUsQnoSJy/PZcN
 xBYRkJT43XUabBSzwBtGiQdXF4AVCQtUSFzfMgesiEVAVWL7hDNAyzk4eAXsJVZ8qIbYJi+x
 /+BZsHJOAQeJH5tvsoLYvAKCEidnPmEBsZmBapq3zgabLyHwk13i5LG1jBDNLhKbji+HOltY
 4tXxLewQtpTEy/42KDtb4s/8djYIu0Bi0c+ZUHF7idZT/cwg9zALaEqs36UPEZaVmHpqHRPE
 Xj6J3t9PoMbzSuyYB2OrSbTvmA81Rkbiza/FUOM9JB5f6GGCBNZkRonvL56wTmBUmIXkn1lI
 /pmFsHoBI/MqRsnUguLc9NRi0wLjvNRyeDQn5+duYgQnVC3vHYyPHnzQO8TIxMF4iFGCg1lJ
 hPf09gXpQrwpiZVVqUX58UWlOanFhxhNgeE9kVlKNDkfmNLzSuINTSwNTMzMzEwsjc0MlcR5
 m3e2pAsJpCeWpGanphakFsH0MXFwSjUwvY0SqCufv2rlnHk5xhtCW9/oTjtV+m12ysxK42cv
 jlkmP156QoLL5AwH17ZpLs43mpy4+y4vPM/Ua7xp/e9i0e+sM09piVgflX38UC/oB4eRTHNo
 1urLTK0XfhrcCn28w/egksb8sCoLywptjRPZWpsyt305c7lX9cw5RTPOjUnLnt04JLUzZZnh
 KxHLc4xrG8M/te2XlMiubDshYH6Et/1R6UILpYim8wlqXNzBfwOuub3Y8zhJm2Pyn+6mi59S
 Dp93sDzwf1NkKZeetdwcmYWz+D7479++7M3rk1xvPZdlKpyazpBZ2MknwLRUYEHv65Dl25fY
 HTOdV684s3lBpcUh4V7VmkPfvsvfL3iZp8RSnJFoqMVcVJwIAMCDxg4xBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO606AXpBiduWFlMP6xo8eX0HjaL
 3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
 vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugSuj6907loKnahUNy66zNzC+lexi5OSQEDCR
 2HztK1sXIxeHkMB2RonFO+awQiRkJC7OfMwCYQtLrPz3nB2i6B+jxJt/J8ASbAI6Eudvz2UD
 sUUEJCV+d51mBiliFvjGKDHn1guwScICZRKnd51gBrFZBFQltk84w9jFyMHBK2AvseJDNcQC
 eYn9B8+ClXAKOEj82HwTrFUIqOR8+xEmEJtXQFDi5MwnYHuZgeqbt85mnsAoMAtJahaS1AJG
 plWMoqkFxbnpuckFhnrFibnFpXnpesn5uZsYwYGuFbSDcdn6v3qHGJk4GA8xSnAwK4nwchye
 ky7Em5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXApH1sRpzS
 8mur3YyT58TG5aa6ORX6CHwXSTbjZQ28ed6qdkvz/KAi3wMTwu1/zrv071WYl/Dnjj8rqr0f
 SHAlXHx79HLmTh5D4ZTf/Q+Pa35bxLrT9M6hg0q3dMXr1b6b3k198qRj692wXFa3uj1Tqjk5
 uDueTJjyR+vDxItz9i+V6L3Mf0P9w6nLMtWs/y+lT9n+/5si8+Onbnn878/8sXl0g9M53yxx
 w+zH+xu4Fkr/0ZGKSbGR2XWm7EHNRH5BXgFlhcdJr11ayrUS2YR3rjE8eNXEtq0mQ/gEV+0f
 neza7Gjeh2afbLRjPOfv/lBs7q1/TpIn/tO+pWtXW2sukbny+Vi1ieJu6af7xAKOK7EUZyQa
 ajEXFScCAHwI3ZXjAgAA
X-CMS-MailID: 20250203060055epcas5p4a7889ddf3b73b10f8b9b41778375ce63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060055epcas5p4a7889ddf3b73b10f8b9b41778375ce63
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
 <CGME20250203060055epcas5p4a7889ddf3b73b10f8b9b41778375ce63@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Feb 2025 02:00:52 -0500
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

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 95 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  2 +
 2 files changed, 97 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5fd7f850c4..115c2dc66b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -78,6 +78,7 @@ enum {
         #define GET_LOG       0x1
         #define GET_LOG_CAPABILITIES   0x2
         #define CLEAR_LOG     0x3
+        #define POPULATE_LOG  0x4
     FEATURES    = 0x05,
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
@@ -1149,6 +1150,94 @@ static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_rebuild_cel(CXLCCI *cci);
+
+static int get_populate_duration(uint32_t total_mem)
+{
+    int secs = 0;
+
+    if (total_mem <= 512) {
+        secs = 4;
+    } else if (total_mem <= 1024) {
+        secs = 8;
+    } else if (total_mem <= 2 * 1024) {
+        secs = 15;
+    } else if (total_mem <= 4 * 1024) {
+        secs = 30;
+    } else if (total_mem <= 8 * 1024) {
+        secs = 60;
+    } else if (total_mem <= 16 * 1024) {
+        secs = 2 * 60;
+    } else if (total_mem <= 32 * 1024) {
+        secs = 4 * 60;
+    } else if (total_mem <= 64 * 1024) {
+        secs = 8 * 60;
+    } else if (total_mem <= 128 * 1024) {
+        secs = 15 * 60;
+    } else if (total_mem <= 256 * 1024) {
+        secs = 30 * 60;
+    } else if (total_mem <= 512 * 1024) {
+        secs = 60 * 60;
+    } else if (total_mem <= 1024 * 1024) {
+        secs = 120 * 60;
+    } else {
+        secs = 240 * 60; /* max 4 hrs */
+    }
+
+    return secs;
+}
+
+/* CXL r3.1 Section 8.2.9.5.5: Populate log (Opcode 0404h) */
+static CXLRetCode cmd_logs_populate_log(const struct cxl_cmd *cmd,
+                                        uint8_t *payload_in,
+                                        size_t len_in,
+                                        uint8_t *payload_out,
+                                        size_t *len_out,
+                                        CXLCCI *cci)
+{
+    int32_t cap_id;
+    uint32_t total_mem = 0;
+    int secs = 0;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) * populate_log = (void *)payload_in;
+
+    cap_id = valid_log_check(&populate_log->uuid, cci);
+    if (cap_id == -1) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    if (cci->supported_log_cap[cap_id].param_flags.populate_log_supported) {
+        switch (cap_id) {
+        case CEL:
+            cci->log = CEL;
+            total_mem = (1 << 16) * sizeof(struct cel_log);
+            secs = get_populate_duration(total_mem >> 20);
+            goto start_bg;
+            break;
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
+    }
+    return CXL_MBOX_UNSUPPORTED;
+
+start_bg:
+    cci->bg.runtime = secs * 1000UL;
+    *len_out = 0;
+    return CXL_MBOX_BG_STARTED;
+}
+
+static void __do_populate(CXLCCI *cci)
+{
+    switch (cci->log) {
+    case CEL:
+        cxl_rebuild_cel(cci);
+        break;
+    default:
+        break;
+    }
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -2918,6 +3007,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                      cmd_logs_get_log_capabilities, 0x10, 0 },
     [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
                           CXL_MBOX_IMMEDIATE_LOG_CHANGE},
+    [LOGS][POPULATE_LOG] = { "LOGS_POPULATE_LOG", cmd_logs_populate_log, 0x10,
+                             (CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                              CXL_MBOX_BACKGROUND_OPERATION)},
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
@@ -3098,6 +3190,9 @@ static void bg_timercb(void *opaque)
         case 0x0201: /* fw transfer */
             __do_firmware_xfer(cci);
             break;
+        case 0x0404: /* populate_ log */
+            __do_populate(cci);
+            break;
         case 0x4400: /* sanitize */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e7cb99a1d2..d90d0d4a8f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -230,6 +230,8 @@ typedef struct CXLCCI {
     } cel_log[1 << 16];
     size_t cel_size;
 
+    enum Logs log;
+
     /* get log capabilities */
     CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
 
-- 
2.34.1


