Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8112CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 04:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sswvu-0005Yi-VW; Tue, 24 Sep 2024 00:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1sswvp-0005Xl-2t
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 00:13:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1sswvj-0001pQ-17
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 00:13:44 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240924041326epoutp02bb2de16dd7f5828e2ae7568ac966e010~4Et8feeP12141121411epoutp02c
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 04:13:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240924041326epoutp02bb2de16dd7f5828e2ae7568ac966e010~4Et8feeP12141121411epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1727151206;
 bh=iyNskUAt0AE4meTXsXgejL5F0mzFDfpPi7FcLpZQry8=;
 h=From:To:Cc:Subject:Date:References:From;
 b=CKz34t+6ufEw5CVcv4EUEQfMNCUpdAGE5aq53JQkTdOgjueUAKUEOHbGO/70Trs+y
 HgbWkjek0OLRrsIFnVw078Fjhr0fGrGgm61nV78Bd0DSJUGtPvRKNzZlogBpa1cGwn
 wy2h6tcAueDx9PEmAM/6u5XkujjV1xEs7O8SW6cY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20240924041325epcas5p1086a28d6ccadbc565f4fad72559d0ae6~4Et7uD0W_2335823358epcas5p1f;
 Tue, 24 Sep 2024 04:13:25 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4XCRLD44X6z4x9Q7; Tue, 24 Sep
 2024 04:13:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DE.DA.19863.36C32F66; Tue, 24 Sep 2024 13:13:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20240923115650epcas5p4750a5c44184b2439d7dc012e950db99e~33ZQOZgp-0164501645epcas5p4k;
 Mon, 23 Sep 2024 11:56:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240923115650epsmtrp196d2fd794a9088cdc5f48e492f507f7a~33ZQNzLft2531025310epsmtrp1x;
 Mon, 23 Sep 2024 11:56:50 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-dc-66f23c6353a7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 28.80.19367.18751F66; Mon, 23 Sep 2024 20:56:49 +0900 (KST)
Received: from open-sourcing.sa.corp.samsungelectronics.net (unknown
 [107.99.41.223]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240923115649epsmtip1d9509b16166de302c22b487866ee70e4~33ZPWjrZ41737917379epsmtip1B;
 Mon, 23 Sep 2024 11:56:49 +0000 (GMT)
From: Ayush Mishra <ayush.m55@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Ayush Mishra
 <ayush.m55@samsung.com>
Subject: [PATCH] hw/nvme: Adding support for NPDAL and NPDGL
Date: Mon, 23 Sep 2024 11:56:51 +0530
Message-ID: <20240923062651.3511358-1-ayush.m55@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmhm6yzac0g3ddgha3J/NYnJgSZrH/
 4DdWi0mHrjFaHO/dweLA6jFl2jV2j3M7zrN7bFrVyebx5NpmJo++LasYA1ijsm0yUhNTUosU
 UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
 9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzXtywLHjEW/F1
 6lLWBsbtXF2MnBwSAiYSl95fZ+1i5OIQEtjDKPH/6G82COcTo8TDlZ9Y4ZyP/WeZYFoe7DoC
 VbWTUeJBTzcLhNPFJPG++xobSBWbgJbEvZe3WEBsEQFJid9dp5m7GDk4mAWSJLo+a4OEhQVs
 JD5fmQNWziKgKrF100WwBbxA8Q/tmxkhlslLLN6xnBkiLihxcuYTsJHMQPHmrbOZQfZKCGxj
 lzi+pA2qwUVi65/zUJcKS7w6voUdwpaSeNnfBmVnS8xp/QZVXyKxdt41FgjbXuLinr9MEHdq
 SqzfpQ8RlpWYemodE8RePone30+gxvNK7Jj3BKxcQkBZoueQAURYUuLJ6y9sELaHxJelj8Fs
 IYFYie0v7rBNYJSfheSbWUi+mYWweAEj8ypGqdSC4tz01GTTAkPdvNRyeLwm5+duYgSnQK2A
 HYyrN/zVO8TIxMF4iFGCg1lJhHfSzY9pQrwpiZVVqUX58UWlOanFhxhNgWE8kVlKNDkfmITz
 SuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgcg6o+RN95+x59vY2
 0QiNxcyev4RC3r+yqbA803qSQdGRT/npbzFbz8mRgoxb6/bfNdAszjuf2MSqWv/v3vNtkzo6
 UlY/0Jy+XSNA/KL5Tr0NVRUmqzZebFDddeF8/zetqgcivz+xMVf37BAJNWDJv9SQ7pvCojNZ
 YY5KplPmhngVjbu/TCQmXWlvdlJS2+K4ZWM4X+10uRUWjz9vrGRX8GVvPco+wdtU9Mx+P2EX
 xSV/f2nNrzSMK73peN5Jz5NRdf2ZK6kp5s4Xwi2WN2zY486/afWdT0krlLwWvouYsHnf3+3x
 G1sOFh0Q+fFh34/KcjarvLy5h+YXqma++mTuvUI+Y6r4zKVMYh9PzjmnxFKckWioxVxUnAgA
 lec59woEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnG5j+Mc0gzmTrS1uT+axODElzGL/
 wW+sFpMOXWO0ON67g8WB1WPKtGvsHud2nGf32LSqk83jybXNTB59W1YxBrBGcdmkpOZklqUW
 6dslcGW8uGFZ8Ii34uvUpawNjNu5uhg5OSQETCQe7DrC1sXIxSEksJ1RYsWxnewQCUmJudu+
 sULYwhIr/z0HiwsJdDBJtO2XBrHZBLQk7r28xQJiiwDV/+46zQxiMwukSXxtecwGYgsL2Eh8
 vjIHzGYRUJXYuukiE4jNCxT/0L6ZEWK+vMTiHcuZIeKCEidnPmGBmCMv0bx1NvMERr5ZSFKz
 kKQWMDKtYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAgOQq2gHYzL1v/VO8TIxMF4iFGCg1lJ
 hHfdk7dpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUw6
 6doBl3YdyZrMXLFsyUf/W0LOU7huvz2k/2alv9VJ/htGPz+cc96zwfDdrRjlQEd3IVvm1V8n
 l0pu7Pnp2F2/Kdy/lfvpSoFnU/bvKLf2+Df5xAKNC9e2iJ+tqJZLXZy3OMQ8OengyX1+oSVs
 jwX2KT28XmcZe5bJTN6jvTyizW//fRPdypfPzh8s6SwJfyux1dvYRP80w+fson3OVzbxFd/n
 dLT/I6hivrzzob7/QZ1DPpOqNDRnTf5h7vZo947kA9rLNv70KLyW9ZbhndCyczb2Iv8MZGPS
 8nUdcv4J+5xunvXRfcUMf1m9klXtz/0bXjH+2d2tm1mwIEq0iPFZQdLqGRIGy443T4i1uqnE
 UpyRaKjFXFScCABNJDVPsQIAAA==
X-CMS-MailID: 20240923115650epcas5p4750a5c44184b2439d7dc012e950db99e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240923115650epcas5p4750a5c44184b2439d7dc012e950db99e
References: <CGME20240923115650epcas5p4750a5c44184b2439d7dc012e950db99e@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=ayush.m55@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.144, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adding support for new 32 bit NPDGL and NPDAL fields to address the
needs of larger granularities.

Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
---
 hw/nvme/ns.c         | 5 ++++-
 include/block/nvme.h | 7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..8b2ea37a1b 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -30,6 +30,7 @@
 void nvme_ns_init_format(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdNsNvm *id_ns_nvm = &ns->id_ns_nvm;
     BlockDriverInfo bdi;
     int npdg, ret;
     int64_t nlbas;
@@ -55,6 +56,8 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+    id_ns_nvm->npdal = npdg;
+    id_ns_nvm->npdgl = npdg;
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
@@ -72,7 +75,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     ns->id_ns.dlfeat = 0x1;
 
     /* support DULBE and I/O optimization fields */
-    id_ns->nsfeat |= (0x4 | 0x10);
+    id_ns->nsfeat |= (0x4 | 0x30);
 
     if (ns->params.shared) {
         id_ns->nmic |= NVME_NMIC_NS_SHARED;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 5298bc4a28..fdf3d999c0 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1413,7 +1413,12 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
     uint8_t     pic;
     uint8_t     rsvd9[3];
     uint32_t    elbaf[NVME_MAX_NLBAF];
-    uint8_t     rsvd268[3828];
+    uint32_t    npdgl;
+    uint32_t    nprg;
+    uint32_t    npra;
+    uint32_t    nors;
+    uint32_t    npdal;
+    uint8_t     rsvd288[3808];
 } NvmeIdNsNvm;
 
 typedef struct QEMU_PACKED NvmeIdNsDescr {
-- 
2.43.0


