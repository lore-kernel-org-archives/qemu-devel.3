Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9DCE674B5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgIo-0004VO-Cw; Mon, 22 Dec 2025 08:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilia.levi@intel.com>)
 id 1vXf99-00049V-ES
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 07:36:20 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilia.levi@intel.com>)
 id 1vXf97-0005KG-Fl
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 07:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766406977; x=1797942977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A+FK9MGZIaeUuGS7ojIi8kBaRCcnKXus10ZgTHWD2xI=;
 b=U8ntozwk9g5gCMl+dxaaYdTcdrqETgwTnbIM+fzrZgmJvXTMDSViLzFS
 hcbxOCbQfHSbx1eHqVcE8081fCKiBkFdU7ywXy82T/Df40lCq8imOEEzs
 E3hzzWR+Jbz7W10XdMRN7hvlqUXFlz+GyL+ddaGmbo20n5JGurgR+WRmO
 8KU1asxTItv3ZG4q1H3o7DKgml6uq7yTuEreZUy6/TLin47owIRaCBzNF
 2jSWqspgJ+HO/NEm6d3K6jTMKkIOIq8687ZAR0Zo7OTK4r039xcV6PuuP
 vceU2jelwfN4KNw+oLuSSr462m9mvte2zZ3HWzNIkDPhS1dflBBQMhOCe A==;
X-CSE-ConnectionGUID: rjpwhFzoRSWb3K5vYQrU7A==
X-CSE-MsgGUID: XXZNRqtAT/6EZ0n7+jYOaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68142500"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; d="scan'208";a="68142500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 04:36:15 -0800
X-CSE-ConnectionGUID: pcQhGzapTT+ssxfJ3q5ILA==
X-CSE-MsgGUID: n0B8aS1lQqiOJ2yUqQguKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; d="scan'208";a="200408070"
Received: from unknown (HELO ilevi-mobl.intel.com) ([10.13.220.47])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 04:36:14 -0800
From: Ilia Levi <ilia.levi@intel.com>
To: qemu-devel@nongnu.org
Cc: ilia.levi@intel.com, jeuk20.kim@samsung.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 1/2] hw/ufs: Fix mcq completion queue wraparound
Date: Mon, 22 Dec 2025 14:35:58 +0200
Message-ID: <20251222123559.3387-2-ilia.levi@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251222123559.3387-1-ilia.levi@intel.com>
References: <20251222123559.3387-1-ilia.levi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=ilia.levi@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:50:04 -0500
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

Currently, ufs_mcq_process_cq() writes to the CQ without checking whether
there is available space. This can cause CQ entries to be discarded and
overwritten. The solution is to stop writing when CQ is full and exert
backpressure on the affected SQs. This is similar to how NVMe CQs operate.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
---
 hw/ufs/ufs.c | 20 +++++++++++++++++++-
 hw/ufs/ufs.h |  9 +++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 0577747f46..671b851de7 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -446,6 +446,10 @@ static void ufs_mcq_process_cq(void *opaque)
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next)
     {
+        if (ufs_mcq_cq_full(u, cq->cqid)) {
+            break;
+        }
+
         ufs_dma_write_rsp_upiu(req);
 
         req->cqe.utp_addr =
@@ -468,6 +472,12 @@ static void ufs_mcq_process_cq(void *opaque)
         tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
         ufs_mcq_update_cq_tail(u, cq->cqid, tail);
 
+        if (QTAILQ_EMPTY(&req->sq->req_list) &&
+            !ufs_mcq_sq_empty(u, req->sq->sqid)) {
+            /* Dequeueing from SQ was blocked due to lack of free requests */
+            qemu_bh_schedule(req->sq->bh);
+        }
+
         ufs_clear_req(req);
         QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
     }
@@ -777,10 +787,18 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         }
         opr->sq.tp = data;
         break;
-    case offsetof(UfsMcqOpReg, cq.hp):
+    case offsetof(UfsMcqOpReg, cq.hp): {
+        UfsCq *cq = u->cq[qid];
+
+        if (ufs_mcq_cq_full(u, qid) && !QTAILQ_EMPTY(&cq->req_list)) {
+            /* Enqueueing to CQ was blocked because it was full */
+            qemu_bh_schedule(cq->bh);
+        }
+
         opr->cq.hp = data;
         ufs_mcq_update_cq_head(u, qid, data);
         break;
+    }
     case offsetof(UfsMcqOpReg, cq_int.is):
         opr->cq_int.is &= ~data;
         break;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 3799d97f30..13d964c5ae 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -200,6 +200,15 @@ static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
     return ufs_mcq_cq_tail(u, qid) == ufs_mcq_cq_head(u, qid);
 }
 
+static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
+{
+    uint32_t tail = ufs_mcq_cq_tail(u, qid);
+    uint16_t cq_size = u->cq[qid]->size;
+
+    tail = (tail + sizeof(UfsCqEntry)) % (sizeof(UfsCqEntry) * cq_size);
+    return tail == ufs_mcq_cq_head(u, qid);
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
-- 
2.49.1


