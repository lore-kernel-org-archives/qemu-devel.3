Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9630EC0218E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 14:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taxsc-0001UO-AV; Thu, 23 Jan 2025 09:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1taqB9-0002Qd-RD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 00:54:59 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1taqB5-00054S-VW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 00:54:59 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250123055448epoutp02831680f939763aadb10117d5ba1872aa~dPJ-2fsIJ0391803918epoutp02a
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 05:54:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250123055448epoutp02831680f939763aadb10117d5ba1872aa~dPJ-2fsIJ0391803918epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1737611689;
 bh=pb03Qlpfey9QcVqYI1K3rM6qGOkplAn5Nk9Y1vZ6kqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hlMXIfZnQFwmyG5OZGsDSjjPY+Hd3wsfzxudPcFnMdOa+yq/LVYYxypUid8Psieev
 DRNz8dfbjcMARev8CxDnMN8UlYhoo0+cVdxokcxexCYfJ4575cQXKyhSUcgbw7cf8n
 XWcCKwSjaQENWsNKcGfaVK7juiGgzgjoccUe/d6U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20250123055448epcas5p16eb8bc7d7710351dd69aad8f94cb157e~dPJ-Muyyl0841308413epcas5p1_;
 Thu, 23 Jan 2025 05:54:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YdqsK4SMMz4x9QG; Thu, 23 Jan
 2025 05:54:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FA.6C.20052.3A9D1976; Thu, 23 Jan 2025 14:54:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250123050912epcas5p2965fd6efa702030802a42c225f11f65b~dOiLbSPP12310123101epcas5p2k;
 Thu, 23 Jan 2025 05:09:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250123050912epsmtrp1075f7ba1354aa08594536d5a733f2a63~dOiLalbee0313303133epsmtrp1c;
 Thu, 23 Jan 2025 05:09:12 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-5c-6791d9a38e09
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7F.6F.18729.8FEC1976; Thu, 23 Jan 2025 14:09:12 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250123050911epsmtip18d4c9e5594841fa548db0f70ef0c3ecc~dOiKXDbMS2475324753epsmtip1P;
 Thu, 23 Jan 2025 05:09:11 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: krish.reddy@samsung.com, vishak.g@samsung.com, a.manzanares@samsung.com,
 alok.rathore@samsung.com, s5.kumari@samsung.com, Vinayak Holikatti
 <vinayak.kh@samsung.com>
Subject: [PATCH 1/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands (8.2.9.9.5.3)
Date: Thu, 23 Jan 2025 10:39:02 +0530
Message-Id: <20250123050903.92336-2-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123050903.92336-1-vinayak.kh@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTU3fxzYnpBmd2alhMP6xo8eX0HjaL
 hRuXMVkc793BYrHm3GcWixMnt7NbnJ81h92B3ePJtc1MHn1bVjEGMEVl22SkJqakFimk5iXn
 p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VVSKEvMKQUKBSQWFyvp29kU
 5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGc8ntfEVPBMv6LtxDrm
 BsZt8l2MnBwSAiYSHxZtZO9i5OIQEtjNKPHkwV1WCOcTo8TOe+cZIZxvjBJ9Ew6yw7RM+j6R
 GSKxFyjx9iJUSwOTxOsFJ1hAqtgEDCQeNB8H6xARkJT43XWaGcRmFljDKLFtCdhyYYEiibcN
 L8FqWARUJS6/XgVm8wpYS7TvvA+1TV5i/8GzYL2cAjYSxza9YYSoEZQ4OfMJC8RMeYnmrbPB
 LpIQuMQuse3kQiaIZheJ1xefskHYwhKvjm+BGiol8bK/Dcouljh38RMjhF0j8bprBTOEbS/R
 eqofyOYAWqApsX6XPkRYVmLqqXVMEHv5JHp/P4FaxSuxYx6IzQFkq0gsfZsJs+nLs2ao6R4S
 606uZ4GEVT+jxIojbUwTGBVmIXlnFpJ3ZiFsXsDIvIpRMrWgODc9tdi0wDAvtRwey8n5uZsY
 wWlRy3MH490HH/QOMTJxMB5ilOBgVhLh/f9kQroQb0piZVVqUX58UWlOavEhRlNgeE9klhJN
 zgcm5rySeEMTSwMTMzMzE0tjM0Mlcd7mnS3pQgLpiSWp2ampBalFMH1MHJxSDUwinVzVYv5L
 /0+LV9nsai356MHCgj0HRH4sSHx9lS18V+3slStkbyzxrutZ33linpj2xZAKiSmO3fcOW00z
 3ei2/dal6CvLrdVVTyrv7pN5vl5B96l+5eUC678LQ+2/81+f89Eo5WBxaN3Z4PirOjpaLhFr
 4uqvKK6/YXlmvURv2PFN2eevZXVYLvE1m1cp55An5+WrXvfWI/THpr2Ol8UvOfcZ/L1/u2b+
 JwP2HrnYZ6+eBrw7dCbA+Or+tYL/pE05GbpPWtdrHFuSyujUu2B56Ipy0/5FxVPdQtU6Thrv
 bHpRGrBi87rJv23/mOh/4ong/Wy1yWXh+jmmFn2tNUY68z+9ZDJr5Gk6+2F7spsSS3FGoqEW
 c1FxIgCoyZnBFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSnO6PcxPTDR4sV7SYfljR4svpPWwW
 CzcuY7I43ruDxWLNuc8sFidObme3OD9rDrsDu8eTa5uZPPq2rGIMYIrisklJzcksSy3St0vg
 yng8r4mp4Jl+RduJdcwNjNvkuxg5OSQETCQmfZ/I3MXIxSEksJtRYkHHWyaIhJTEsZ0/2SBs
 YYmV/56zQxT9Y5SYMO81O0iCTcBA4kHzcTBbREBS4nfXaWYQm1lgE6NE6z49EFtYoEDi4ZJn
 LCA2i4CqxOXXq8DqeQWsJdp33meHWCAvsf/gWbBeTgEbiWOb3jCC2EJANT8nzWGFqBeUODnz
 CQvEfHmJ5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
 4Gpp7mDcvuqD3iFGJg7GQ4wSHMxKIrz/n0xIF+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3
 RUggPbEkNTs1tSC1CCbLxMEp1cC04vWXsjtztW6vevRfw3/53LC45CnKPCtj3Cc6rMuU+l3w
 /s5pa5alDDLBfjN+Ch4puC4buOVJ+8zz9hFu3lXMvDzhu7qes73NUq6Ofn/D0lB8sdpF259X
 mTeo2tpO/BGqbX5znVrNZbnYSWu49T3Su119OcSP7ymNfPDfcP8XqcDlXF+3rdFMXmN15mX4
 3H05nvMXTtB6zzhx0TVB3siA790HG94vZU58tuNkb6/a/BS/CauLp3x8XJMis4FZM71QWuob
 s2KpT+CcdrYrb9RfOidzzLhfea7EZVrXwVXH5PPMa3PExXSfhdzXvx/OULpEnv//cadVMxSX
 bHgoGp28TaRl+nYt39RXV37y3JuqxFKckWioxVxUnAgAC10IR8sCAAA=
X-CMS-MailID: 20250123050912epcas5p2965fd6efa702030802a42c225f11f65b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250123050912epcas5p2965fd6efa702030802a42c225f11f65b
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
 <CGME20250123050912epcas5p2965fd6efa702030802a42c225f11f65b@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=vinayak.kh@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jan 2025 09:08:19 -0500
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

    CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
    CXL devices supports media operations discovery command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 130 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..2315d07fb1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -87,8 +87,9 @@ enum {
         #define GET_LSA       0x2
         #define SET_LSA       0x3
     SANITIZE    = 0x44,
-        #define OVERWRITE     0x0
-        #define SECURE_ERASE  0x1
+        #define OVERWRITE        0x0
+        #define SECURE_ERASE     0x1
+        #define MEDIA_OPERATIONS 0x2
     PERSISTENT_MEM = 0x45,
         #define GET_SECURITY_STATE     0x0
     MEDIA_AND_POISON = 0x43,
@@ -1721,6 +1722,127 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+enum {
+    MEDIA_OP_GENERAL  = 0x0,
+    MEDIA_OP_SANITIZE = 0x1,
+    MEDIA_OP_CLASS_MAX,
+} MEDIA_OPERATION_CLASS;
+
+enum {
+    MEDIA_OP_SUB_DISCOVERY = 0x0,
+    MEDIA_OP_SUB_SANITIZE = 0x0,
+    MEDIA_OP_SUB_ZERO     = 0x1,
+    MEDIA_OP_SUB_CLASS_MAX
+} MEDIA_OPERATION_SUB_CLASS;
+
+struct media_op_supported_list_entry {
+    uint8_t media_op_class;
+    uint8_t media_op_subclass;
+};
+
+struct media_op_discovery_out_pl {
+    uint64_t dpa_range_granularity;
+    uint16_t total_supported_operations;
+    uint16_t num_of_supported_operations;
+    struct media_op_supported_list_entry entry[0];
+};
+
+#define MAX_SUPPORTED_OPS 3
+struct media_op_supported_list_entry media_op_matrix[MAX_SUPPORTED_OPS] = {
+                                                            {0, 0},
+                                                            {1, 0},
+                                                            {1, 1} };
+
+static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+    uint8_t media_operation_class;
+    uint8_t media_operation_subclass;
+    uint8_t rsvd[2];
+    uint32_t dpa_range_count;
+    union {
+        struct {
+            uint64_t starting_dpa;
+            uint64_t length;
+        } dpa_range_list[0];
+        struct {
+            uint16_t start_index;
+            uint16_t num_supported_ops;
+        } discovery_osa;
+    };
+    } QEMU_PACKED *media_op_in_pl = (void *)payload_in;
+
+    uint8_t media_op_cl = media_op_in_pl->media_operation_class;
+    uint8_t media_op_subclass = media_op_in_pl->media_operation_subclass;
+    uint32_t dpa_range_count = media_op_in_pl->dpa_range_count;
+
+    if (len_in < sizeof(*media_op_in_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    switch (media_op_cl) {
+    case MEDIA_OP_GENERAL:
+        switch (media_op_subclass) {
+        case MEDIA_OP_SUB_DISCOVERY:
+            int count = 0;
+            struct media_op_discovery_out_pl *media_out_pl =
+                (void *)payload_out;
+            int num_ops = media_op_in_pl->discovery_osa.num_supported_ops;
+            int start_index = media_op_in_pl->discovery_osa.start_index;
+
+            /* As per spec CXL 3.1 8.2.9.9.5.3 dpa_range_count */
+            /* should be zero for discovery sub class command */
+            if (dpa_range_count) {
+                return CXL_MBOX_INVALID_INPUT;
+            }
+
+            if ((start_index >= MEDIA_OP_CLASS_MAX) ||
+                (num_ops > MAX_SUPPORTED_OPS)) {
+                return CXL_MBOX_INVALID_INPUT;
+            }
+
+            media_out_pl->dpa_range_granularity = CXL_CAPACITY_MULTIPLIER;
+            media_out_pl->total_supported_operations = MAX_SUPPORTED_OPS;
+            if (num_ops > 0) {
+                for (int i = start_index; i < MAX_SUPPORTED_OPS; i++) {
+                    media_out_pl->entry[count].media_op_class =
+                            media_op_matrix[i].media_op_class;
+                    media_out_pl->entry[count].media_op_subclass =
+                            media_op_matrix[i].media_op_subclass;
+                    count++;
+                    if (count == num_ops) {
+                        goto disc_out;
+                    }
+                }
+            }
+disc_out:
+            media_out_pl->num_of_supported_operations = count;
+            *len_out = sizeof(struct media_op_discovery_out_pl) +
+            (sizeof(struct media_op_supported_list_entry) * count);
+            break;
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
+        break;
+    case MEDIA_OP_SANITIZE:
+        switch (media_op_subclass) {
+
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
+        break;
+    default:
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -2864,6 +2986,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
          CXL_MBOX_SECURITY_STATE_CHANGE |
          CXL_MBOX_BACKGROUND_OPERATION |
          CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
+    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
+        ~0,
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
-- 
2.34.1


