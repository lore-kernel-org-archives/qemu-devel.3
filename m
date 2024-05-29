Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80702C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIor-000784-Qm; Wed, 29 May 2024 08:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIop-00077J-VZ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIoj-0008Ir-2I
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:13 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240529125358epoutp04c3931a4a4c1ac46f45020f9d6e9b3496~T9svllXSs2526525265epoutp04W
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:53:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240529125358epoutp04c3931a4a4c1ac46f45020f9d6e9b3496~T9svllXSs2526525265epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716987238;
 bh=rf73xYsjOK+oCcrNHdi2Wh/JkLrL9ZINsaGLF1SE6pI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZvTLKqdJZavDqnFA5BLBw4n/Tjmp+KHugwQY23StB8GS55wCdUXuGq+jxJuO75Ifg
 INH0QX2LN/k1+W4jhn7k/tk88580UDBKffAsux01nfPmdbsQws9WZ2IXiorsX9Z0YO
 e9ykPvNc9XnmTK6fUbjTAqJQ1AH/oyDbpuX8UBTE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20240529125358epcas2p3734d60e63720ea47818aea9520ed4c09~T9svOeTbJ1740717407epcas2p3_;
 Wed, 29 May 2024 12:53:58 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.99]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Vq8TK4SRhz4x9Py; Wed, 29 May
 2024 12:53:57 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8B.D5.18956.56527566; Wed, 29 May 2024 21:53:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epcas2p1f29357582a7cb7a922f950fb41f0df17~T9suEPKy40504005040epcas2p19;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240529125356epsmtrp2ac3c724eb80c50f6099880f06e67088b~T9suC_6_n1667216672epsmtrp2B;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
X-AuditID: b6c32a4d-f95ff70000004a0c-57-665725651c51
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 02.AC.08336.46527566; Wed, 29 May 2024 21:53:56 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epsmtip261d983f030f65a2f7c48dc8cf167eee7~T9stztg_j1281412814epsmtip25;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, minwoo.im@samsung.com,
 gost.dev@samsung.com, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v4 1/4] hw/nvme: add Identify Endurance Group List
Date: Wed, 29 May 2024 21:42:31 +0900
Message-Id: <20240529124234.1430707-2-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529124234.1430707-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmmW6qaniawZ9OZYsTU8Isbh7YyWSx
 /+A3VouTjXtYLSYdusZo8ez0AWaLWe/a2SyO9+5gceDwmDLtGrvHuR3n2T02repk83hybTOT
 R9+WVYwBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
 mTlAtygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
 DIxMgQoTsjMu/z3IXrBTpGLKwqgGxk6BLkZODgkBE4ndq/eydjFycQgJ7GGUuDnhAAuE84lR
 4mLbZ0YI5xujxPa7P5hgWqZ1LYJq2csosf7ASqiW34wSX59dZgapYhNQl2iY+ooFxBYRyJHo
 X/mdCaSIWaCFUaL73C2wImEBJ4meV++ARnFwsAioSrzcowAS5hWwkfh77SnUNnmJ/QfPgpVz
 CthKdM15ww5RIyhxcuYTsPnMQDXNW2czg8yXEHjLLnGj9SMbRLOLxOeWyywQtrDEq+Nb2CFs
 KYnP7/ZC1ZRL/HwziRHCrpA4OOs2G8g9EgL2Eteep4CYzAKaEut36UNElSWO3ILayifRcfgv
 O0SYV6KjTQhihrLEx0OHmCFsSYnll15D7fGQ6Li8H+wpIYEJjBKvDtVOYFSYheSXWUh+mYWw
 dwEj8ypGqdSC4tz01GSjAkPdvNRyeBQn5+duYgQnTi3fHYyv1//VO8TIxMF4iFGCg1lJhPfM
 pNA0Id6UxMqq1KL8+KLSnNTiQ4ymwMCeyCwlmpwPTN15JfGGJpYGJmZmhuZGpgbmSuK891rn
 pggJpCeWpGanphakFsH0MXFwSjUwqab+C3ZzmMHRMH8h070f/CK9h07kzVkd9a2Q+6Hie4vS
 GIFD77eePBM0v8WsIewij1fEXlWX2rN1ppMips/fkpV3x/mM+M09j/KDgpyK5GqvPjdnUNpT
 wdO3Kqm3/mXb5ZTbsU6Ghq+Zdi6LlZWdzmbxd9K88MNz29auPRVdnhsm/utFqmaQmcuEkzX7
 3E2W//nUdkNRfOHK7E/hvwJM9Q4F/jKeHHltH9PTDW7LHn6IvKeQ/WPut4URVXOMZgvM2KOl
 kHa/OOXbqjt/l181WXjgu5T5LIVjgUxJgvcOmX970KD26eIkPosLz5bu9XFc/VtBSvbVtqii
 b+d+rdfcYfVisuPO1Qv66nkLYpV1o5VYijMSDbWYi4oTAYeqd78lBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvG6KaniawY0mXYsTU8Isbh7YyWSx
 /+A3VouTjXtYLSYdusZo8ez0AWaLWe/a2SyO9+5gceDwmDLtGrvHuR3n2T02repk83hybTOT
 R9+WVYwBrFFcNimpOZllqUX6dglcGZf/HmQv2ClSMWVhVANjp0AXIyeHhICJxLSuRaxdjFwc
 QgK7GSW+Xp/JBJGQlNh3+iYrhC0scb/lCFTRT0aJ06cmgBWxCahLNEx9xQJiiwjkSVx7uYQZ
 pIgZaLbErItTmUESwgJOEj2v3gF1c3CwCKhKvNyjABLmFbCR+HvtKdQyeYn9B8+ClXMK2Ep0
 zXnDDmILAdUsevybHaJeUOLkzCdgu5iB6pu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYF
 hnmp5XrFibnFpXnpesn5uZsYweGtpbmDcfuqD3qHGJk4GA8xSnAwK4nwnpkUmibEm5JYWZVa
 lB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qBaWKIrEl24YoXpR9UQ8VO
 7pvs0H/sn9OsANXH58OmN8yVqGyYeuhbRuijIKnH921SZMyCwntF0naxv5/F9l4pZ//OgE9l
 Bcv2HHFQ2qrh7ulwz8ZEflX//A8rj2Rv3t/Jf/hVi2T0pW6zS8+2dpk2rd7rulXK593E+/vT
 EtNfmzywYtpj0M5Tz1p4WF6a63XdrBaGX6ppywKNW9lsRVpv3L5R1nm/6WP1q8vCgf4nuNY1
 z+VMSVb2k2VeILpL8JB/UNl8hveCRf98urvnOoU/+GvvHP0+otT7Wn7QK8PlqpdKT5wyy36f
 +oVt+YSU+U4rFZ1K5rodmjDvpL4h3zNH+TaRX+VV99tOz7c49EVaiaU4I9FQi7moOBEAP1z/
 sN4CAAA=
X-CMS-MailID: 20240529125356epcas2p1f29357582a7cb7a922f950fb41f0df17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240529125356epcas2p1f29357582a7cb7a922f950fb41f0df17
References: <20240529124234.1430707-1-minwoo.im@samsung.com>
 <CGME20240529125356epcas2p1f29357582a7cb7a922f950fb41f0df17@epcas2p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 73064edfb864 ("hw/nvme: flexible data placement emulation")
intorudced NVMe FDP feature to nvme-subsys and nvme-ctrl with a
single endurance group #1 supported.  This means that controller should
return proper identify data to host with Identify Endurance Group List
(CNS 19h).  But, yes, only just for the endurance group #1.  This patch
allows host applications to ask for which endurance group is available
and utilize FDP through that endurance group.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c       | 22 ++++++++++++++++++++++
 include/block/nvme.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..18672f6619 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5629,6 +5629,26 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
     return nvme_c2h(n, list, data_len, req);
 }
 
+static uint16_t nvme_endurance_group_list(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint16_t list[NVME_CONTROLLER_LIST_SIZE] = {};
+    uint16_t *nr_ids = &list[0];
+    uint16_t *ids = &list[1];
+    uint16_t endgid = le32_to_cpu(req->cmd.cdw11) & 0xffff;
+
+    /*
+     * The current nvme-subsys only supports Endurance Group #1.
+     */
+    if (!endgid) {
+        *nr_ids = 1;
+        ids[0] = 1;
+    } else {
+        *nr_ids = 0;
+    }
+
+    return nvme_c2h(n, list, sizeof(list), req);
+}
+
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -5744,6 +5764,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
         return nvme_identify_nslist(n, req, false);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
         return nvme_identify_nslist_csi(n, req, true);
+    case NVME_ID_CNS_ENDURANCE_GROUP_LIST:
+        return nvme_endurance_group_list(n, req);
     case NVME_ID_CNS_CS_NS_PRESENT_LIST:
         return nvme_identify_nslist_csi(n, req, false);
     case NVME_ID_CNS_NS_DESCR_LIST:
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..7c77d38174 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1074,6 +1074,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CTRL_LIST             = 0x13,
     NVME_ID_CNS_PRIMARY_CTRL_CAP      = 0x14,
     NVME_ID_CNS_SECONDARY_CTRL_LIST   = 0x15,
+    NVME_ID_CNS_ENDURANCE_GROUP_LIST  = 0x19,
     NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
     NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
     NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
-- 
2.34.1


