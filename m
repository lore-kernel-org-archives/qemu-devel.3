Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CE1C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIow-0007Bj-QI; Wed, 29 May 2024 08:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIor-000782-FB
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sCIoi-0008Il-N3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:16 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240529125358epoutp0417ff4e9ee3fa5c8324b6aca84317ed83~T9svImTFd2500325003epoutp04b
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:53:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240529125358epoutp0417ff4e9ee3fa5c8324b6aca84317ed83~T9svImTFd2500325003epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716987238;
 bh=4UqckNa3SBolRT98q8YcZiBZPFFmi/MfRyXlY1dqzW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pIJMzwgzV1wdLlFFbbW8AWP3UNpHPbeQPl4ULlO4CZN7uihn1TmSxIBGKBerlZb6B
 luC5eX8tBE9Jqhu2tCgbwKsMzdOgctseNFP53Ur7H8N2CvqMkrF2CiaMeTwgNFKqEB
 eYzWmm0t1qX3rtw2mOqUM4+1mX+XbL9Ji9qufJDU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20240529125357epcas2p138f6648af3b1674729552ec99b040d88~T9suwLEmR0515505155epcas2p13;
 Wed, 29 May 2024 12:53:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Vq8TK2RHKz4x9Pv; Wed, 29 May
 2024 12:53:57 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 8C.E6.09479.56527566; Wed, 29 May 2024 21:53:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epcas2p218eee16c01039ef5f0d5c8706825485d~T9suHfgRu0038900389epcas2p2Q;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240529125356epsmtrp2d5418d6fd3b5933b0725e682d48dbe5a~T9suE5hbS1667216672epsmtrp2E;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
X-AuditID: b6c32a48-ea7ff70000002507-e6-6657256564c3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 69.3A.18846.46527566; Wed, 29 May 2024 21:53:56 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240529125356epsmtip25bc1477f69fa5f1f32a9bb55fff374ff~T9st7Iwvf1461914619epsmtip2P;
 Wed, 29 May 2024 12:53:56 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, minwoo.im@samsung.com,
 gost.dev@samsung.com, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v4 4/4] hw/nvme: Expand VI/VQ resource to uint32
Date: Wed, 29 May 2024 21:42:34 +0900
Message-Id: <20240529124234.1430707-5-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529124234.1430707-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTXDdVNTzNYPF1QYsTU8Isbh7YyWSx
 /+A3VouTjXtYLSYdusZo8ez0AWaLWe/a2SyO9+5gceDwmDLtGrvHuR3n2T02repk83hybTOT
 R9+WVYwBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
 mTlAtygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
 DIxMgQoTsjNO/ZvAXrCMv+LYS7MGxjvcXYycHBICJhLLp05l7GLk4hAS2MEo8XnvNyjnE6NE
 +9FjbHDOx5Zl7DAtszY+h6raySjRfGsPO4Tzm1Fix5zvTCBVbALqEg1TX7GA2CICORL9K0Hi
 XBzMAi2MEt3nbjGDJIQFHCSOz9jICGKzCKhK/Fi3HCzOK2AjsfDyZDaIdfIS+w+eBYtzCthK
 dM15ww5RIyhxcuYTsAXMQDXNW2czQ9S/ZJfoaquEsF0kuhf1M0LYwhKvjm+BekFK4vO7vVDz
 yyV+vpkEVVMhcXDWbaA4B5BtL3HteQqIySygKbF+lz5EVFniyC2opXwSHYf/skOEeSU62oQg
 ZihLfDx0COoWSYnll15D7fGQWNC+kgkSUhMYJWYsX84+gVFhFpJfZiH5ZRbC4gWMzKsYxVIL
 inPTU4uNCkzg8Zucn7uJEZwytTx2MM5++0HvECMTB+MhRgkOZiUR3jOTQtOEeFMSK6tSi/Lj
 i0pzUosPMZoCQ3ois5Rocj4waeeVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBa
 BNPHxMEp1cA08bm3wanSxqL1iQWfGaM72zcapRhUqbxhdOyV+hfYbTgvv2Pvr5eNajfv725V
 ExD0dC68JNvz7Mj5CHU35qU7Li98teT+yk9Sz73PSm15/ur7Z5npgSFirvuFV8je237Hsmrp
 vdK3q37OuiWx+PKkiROZfHxyhUsCcv88n/5U/kPC3y3r/Xc4d9cdUmOp6E7jfChcMEH2kI/+
 g1+e3wvWWnlc/L+fI+ZRe7SunpD6yzg5idO2a9e/kP2/ozS/Z11fryxHwQpb4+WpAUFJF14v
 MWa4/3jVmQur7B+dmRJyfur59pQVRxguqUkkSU35OKk4rDb+45/uGkuX5F/sO6N+nu20VRFa
 O+fLL8n00wdFlFiKMxINtZiLihMB3Ibf5CIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvG6KaniawfNfxhYnpoRZ3Dywk8li
 /8FvrBYnG/ewWkw6dI3R4tnpA8wWs961s1kc793B4sDhMWXaNXaPczvOs3tsWtXJ5vHk2mYm
 j74tqxgDWKO4bFJSczLLUov07RK4Mk79m8BesIy/4thLswbGO9xdjJwcEgImErM2PmfsYuTi
 EBLYzijx9tkDZoiEpMS+0zdZIWxhifstR8BsIYGfjBKfrkqB2GwC6hINU1+xgNgiAnkS114u
 YQYZxCzQxSgx6+JUsEHCAg4Sx2dsZASxWQRUJX6sWw4W5xWwkVh4eTIbxAJ5if0Hz4LFOQVs
 JbrmvGGHWGYjsejxb3aIekGJkzOfgC1jBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqYWFOem5yYX
 GOoVJ+YWl+al6yXn525iBIe1VtAOxmXr/+odYmTiYDzEKMHBrCTCe2ZSaJoQb0piZVVqUX58
 UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDU2XQ59aS+Dt9LffX+OQKnD+r
 e+uZfH9LauH9h4J3lCNmsxUtbEpkKpC4ealIOqBljv7pJhHbIwFGOZH7g9b9imHVmSOwe2PO
 i4W31ROO+/KfV3zG2rh+m7dD5Sy/6Wmtu24sO9WbICVkFe7tLLbEfsb85y6dy3XEDx1M/yzT
 GCOzVeIG88U7Xv/2HPjmnCofm83LEnpmlW/zxydxbXssZnLFnfq5KY5x5YQdr891qQvs/rR8
 fryNafRf4yl9h4p+H2S1ijTd8qcx4O4yjhjfIx72qX777sUwbT7+9nn/pgS+uc8uJeXsuHLp
 9x2/jExx85qCC3scu+69jJzKsqWvUSbhjeWDg+Hr5N7M5vjSp8RSnJFoqMVcVJwIANtkL9/a
 AgAA
X-CMS-MailID: 20240529125356epcas2p218eee16c01039ef5f0d5c8706825485d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240529125356epcas2p218eee16c01039ef5f0d5c8706825485d
References: <20240529124234.1430707-1-minwoo.im@samsung.com>
 <CGME20240529125356epcas2p218eee16c01039ef5f0d5c8706825485d@epcas2p2.samsung.com>
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

VI and VQ resources cover queue resources in each VFs in SR-IOV.
Current maximum I/O queue pair size is 0xffff, we can expand them to
cover the full number of I/O queue pairs.

This patch also fixed Identify Secondary Controller List overflow due to
expand of number of secondary controllers.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++----
 hw/nvme/nvme.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 90a58e71bd..b957debdc3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8460,10 +8460,10 @@ static Property nvme_props[] = {
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
                        params.sriov_vi_flexible, 0),
-    DEFINE_PROP_UINT8("sriov_max_vi_per_vf", NvmeCtrl,
-                      params.sriov_max_vi_per_vf, 0),
-    DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
-                      params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_UINT32("sriov_max_vi_per_vf", NvmeCtrl,
+                       params.sriov_max_vi_per_vf, 0),
+    DEFINE_PROP_UINT32("sriov_max_vq_per_vf", NvmeCtrl,
+                       params.sriov_max_vq_per_vf, 0),
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index d8ec4bad6a..b0b2739802 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -534,8 +534,8 @@ typedef struct NvmeParams {
     uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
-    uint8_t  sriov_max_vq_per_vf;
-    uint8_t  sriov_max_vi_per_vf;
+    uint32_t  sriov_max_vq_per_vf;
+    uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
 } NvmeParams;
 
-- 
2.34.1


