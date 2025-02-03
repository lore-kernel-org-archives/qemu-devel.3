Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC91C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfCux-0001DD-7V; Tue, 04 Feb 2025 02:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tfCBN-0001Ao-Fo
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:13:14 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tfCBL-0002CP-3G
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 01:13:12 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250204061305epoutp02ffdfcbe59b3caf1a8c77b22a42858a5c~g7JYI9g8C2156721567epoutp02U
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2025 06:13:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250204061305epoutp02ffdfcbe59b3caf1a8c77b22a42858a5c~g7JYI9g8C2156721567epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1738649585;
 bh=aaIOgdg3KaYLAgArba1Iytpk/jlai0hkq0kWenR5qik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Br37YQ0WrW7DnJ/8rVqXxrbRz09i7Nh4clDhxJ52cw1RrcWo49b5I6X2ruejeifbU
 FLnK9kVR4YoPvjq6ri1bzowBUUtLyWkmUMAmDSKnR/pFATNU1g3/amcR5AbCfa4VSZ
 Hjs3FCzc3ZcYt3q7orMxsoiIbxva4CzW+BFzkJwg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20250204061304epcas5p252a2390135e9b3f6cfc86e31fec46f91~g7JXnOi4y0463804638epcas5p2D;
 Tue,  4 Feb 2025 06:13:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4YnChv3MSsz4x9Px; Tue,  4 Feb
 2025 06:13:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 00.1E.19956.DEFA1A76; Tue,  4 Feb 2025 15:13:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9~gnVcMhXk01242612426epcas5p1Z;
 Mon,  3 Feb 2025 06:00:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250203060053epsmtrp156739bb88a34cf16dd64483c36252757~gnVcKu75s2494724947epsmtrp15;
 Mon,  3 Feb 2025 06:00:53 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-6c-67a1afed8ce3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 93.EE.23488.59B50A76; Mon,  3 Feb 2025 15:00:53 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250203060051epsmtip2705fb526d7f55303c237de7f953dd9e1~gnVawSwzL2702127021epsmtip22;
 Mon,  3 Feb 2025 06:00:51 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
 <arpit1.kumar@samsung.com>
Subject: [PATCH 2/3] hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log
 (Opcode 0403h)
Date: Mon,  3 Feb 2025 11:29:49 +0530
Message-Id: <20250203055950.2126627-3-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhu7b9QvTDb5/YbGYfljR4svpPWwW
 vYuXsFqsvrmG0eLmgZ1MFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfd48m1zUwe
 fVtWMXpMnV3v8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
 qq2Si0+ArltmDtBNSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
 dL281BIrQwMDI1OgwoTsjF9tUgWTRSv+PbzM3MB4mq+LkZNDQsBE4tPev4xdjFwcQgK7GSUu
 d3ZAOZ8YJVbOOMwG4XxjlJj1dCMbTMuzlrnMEIm9jBL3vxxiAkkICTQwSXyb6gliswnoSJy/
 PResQURAUuJ312mwBmaBN4wSD64uAHI4OIQFYiXOLlcFqWERUJV4OnMqWD2vgL3E8Tt9TBDL
 5CX2HzzLDGJzCjhI/Nh8kxWiRlDi5MwnLCA2M1BN89bZYPMlBL6yS9x9NIEdotlFYmPHVEYI
 W1ji1fEtUHEpiZf9bVB2tsSf+e1QnxVILPo5EypuL9F6qh/sTmYBTYn1u/QhwrISU0+tY4LY
 yyfR+/sJ1J28EjvmwdhqEu075kONkZF482sx1HgPiWPr/0ODdzKjxJVr+xknMCrMQvLPLCT/
 zEJYvYCReRWjZGpBcW56arFpgXFeajk8kpPzczcxgpOplvcOxkcPPugdYmTiYDzEKMHBrCTC
 e3r7gnQh3pTEyqrUovz4otKc1OJDjKbAAJ/ILCWanA9M53kl8YYmlgYmZmZmJpbGZoZK4rzN
 O1vShQTSE0tSs1NTC1KLYPqYODilGpiixbgZT53w/5RU6hB494NR4YJtqjdbLFlqM3x+rX1w
 QSlawSxnYpxM4KRH3zLfCC2rOLvRb52Ixv/Py7oqHas8NxZstzWTcmx2L4vZvvrgimucLKvD
 /hUaHT11q1wtdMMEM9UfBm6l0ckxL1bvkUrXyqm/3nrk5zLDn2krt6QLK0YZNIkWbf0dtWbH
 0v329r/PrhE+92WCbkhQd8Kz/m7mrprZxmdmHWp9erz14hXOCY9KAnJWzViyMv9v6lqLgJKe
 HZzq19LZZ627O8f4Brdptr4+U65/564ft7X+Vy9SKLT2qLbUOe/HWSueeuvIBI7TnFt+rFvr
 7Fp2Yf/tu6vYKww/Ta1g9amRvC9hMUeJpTgj0VCLuag4EQAsk+uYLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO7U6AXpBhOPC1hMP6xo8eX0HjaL
 3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
 vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugSvjV5tUwWTRin8PLzM3MJ7m62Lk5JAQMJF4
 1jKXuYuRi0NIYDejxP4tu9ggEjISF2c+ZoGwhSVW/nvODlH0j1Fi9pstYEVsAjoS52/PBbNF
 BCQlfnedBpvELPCNUWLOrResIAlhgWiJ20c6mEFsFgFViaczp4I18ArYSxy/08cEsUFeYv/B
 s2A1nAIOEj823wTrFQKqOd9+hAmiXlDi5MwnYBcxA9U3b53NPIFRYBaS1CwkqQWMTKsYJVML
 inPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYIDXktjB+O7b036hxiZOBgPMUpwMCuJ8HIcnpMu
 xJuSWFmVWpQfX1Sak1p8iFGag0VJnHelYUS6kEB6YklqdmpqQWoRTJaJg1OqgYkhJ3/Gxv3e
 dycsYbpi1fD78p3Xh7p775i2cRnkz17YaNQtHtWV8m+eUbV/QDVP5ayL79sMkpguTtnDfeag
 UKpfoKvdp55W27ve2wwEY1e47ebd6pfbZNGne/H222naU+e9ffixt9d+X8FOHQvjoBnr83z/
 HQm5HPDOlX+24WcBn12fr+9yCvmxfX0Gi5ti3LmZy1WlChtuLs/2F0vTVNO2aTyr8JLl5PVF
 ZQHhjcGLNn2LWvKZv9P8wsvmB/vrjxz9cGJVmmTuDm62/odHjHqt+25Mk5m57JjIBJGNX419
 73kfO9gi5NTrufG6SrLj5byrU8J22xtltKxzrGKq2L1mhk+CbtySCr45RvMY5ZRYijMSDbWY
 i4oTAZA0euznAgAA
X-CMS-MailID: 20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
 <CGME20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Feb 2025 02:00:08 -0500
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
 hw/cxl/cxl-mailbox-utils.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3d66a425a9..5fd7f850c4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -77,6 +77,7 @@ enum {
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
         #define GET_LOG_CAPABILITIES   0x2
+        #define CLEAR_LOG     0x3
     FEATURES    = 0x05,
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
@@ -1115,6 +1116,39 @@ static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.5.4: Clear Log (Opcode 0403h) */
+static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
+                                     uint8_t *payload_in,
+                                     size_t len_in,
+                                     uint8_t *payload_out,
+                                     size_t *len_out,
+                                     CXLCCI *cci)
+{
+    int32_t cap_id;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) * clear_log = (void *)payload_in;
+
+    cap_id = valid_log_check(&clear_log->uuid, cci);
+    if (cap_id == -1) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    if (cci->supported_log_cap[cap_id].param_flags.clear_log_supported) {
+        switch (cap_id) {
+        case CEL:
+            memset(cci->cel_log, 0, (1 << 16) * sizeof(struct cel_log));
+            cci->cel_size = 0;
+            break;
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -2882,6 +2916,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
                                      cmd_logs_get_log_capabilities, 0x10, 0 },
+    [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
+                          CXL_MBOX_IMMEDIATE_LOG_CHANGE},
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
-- 
2.34.1


