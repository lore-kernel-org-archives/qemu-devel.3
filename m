Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A217CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX6R-0002ii-Bo; Wed, 06 May 2026 03:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX6B-0002eX-Dz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:20 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wKX68-00082z-Hi
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:55:14 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36534668247so3330979a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778054111; x=1778658911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPf1WJ1+U+u46IYFp/g9GCUhxcS1hDN0tG9RbQh1S9c=;
 b=YXaBINPOmPnoWIf7qAQnXJBRf0UnUgNmUV0PtKRAMU9DghZ5rg3cezr3QD5sUiUnzJ
 M2XnHEk0mT1yxGkXGIC5hxKH9HSCVahr7m3+IS2Z50jA+8H96Hxt+6WTXfrxLE/Ey/0p
 oqL2chmEPcIpbe9gKG4Scj+U5ExAm4lLOE55cVSly6w9PiEdBuIlWEJDIdiiIz1QFy/S
 wD4g0OvlRTKlL9MhgZvHcfXHs+TOWLelnFTr5mCmK7NBYa1ZMeqmA8x5l9uFOrjKQ8bN
 50VYq/Opq195j5UwpA+aebMP05g6GK6zaQz+T+VVsxIZ+2+f2ldpssMR5xdqN/LwHqMy
 pY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054111; x=1778658911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZPf1WJ1+U+u46IYFp/g9GCUhxcS1hDN0tG9RbQh1S9c=;
 b=niUtWfvwhdiRoYl6S5jm8ZvfM7VnIoixvz5d2CkarWsXtpucWLNW3ANTnwOWX8FTV4
 QfMEOAKAfSGGYYFM2AOhXk+VvypDB/hmNu2GvWbF3kaBrFK4ZIllcMm+NqW/lD/ezHy4
 83LTfAmQXrbWUqFYrvFbahUkGfAiPaNnyscWJCcBmA7Aa7KXILWN658CB2apFleXWJea
 2Fb0QQ2oSn1ivhnmt2fT9kg2dxmvaD1PBgkoKzWaBE5B8pBzIco1YxcwEl6rDfY3z9JG
 wV64T3QJzMzY/5pggYti5avj8y/cbOBZodgMCC2JBcmbkwN3mUK7kiAwMqmwn3fVFYyJ
 EXrw==
X-Gm-Message-State: AOJu0YxPbMjevIJAXYPo0i3C60BbMGd2GLgIo8evMojv7xk/tygCcR79
 yfntHHJY2SEmiA5dv+NtZFB/rowypX8+5UiDhpM1cQt/98p0Hb4YtR/e+r3SVQ==
X-Gm-Gg: AeBDieuBhew26RWcFGumgaRhEQiLvcagY4GWWeKK7rmgbqRZSXMkurFVsFwpGQOwZoL
 MN1uoDE105dwX7Ch9eUv4izBAwDNYpmuoxKkMS1SoVMFSYFIcwwgHmiYARSQ128Q4InI2FAflQc
 /y3t6l4K9RNUknMTz2m/QZw2CJWmV6AzcjMKv+wbhmChq6LkWl/vgLiN4jITPFQquCUyQ+lMGSo
 qZavhIDe3Ngv3ygLdjOGqEhYkku75P2hpL3q6byb+fv3Hm4AOk6fwJpHi3LXmwwf10x+E/b/4Vk
 KoFJ0NSKL4G2YO8fhiSzVu7DxDLXSuNLusvj0MvpQAWPnNEtb7rkgJpLSQXeca17kqvNHKSxjp5
 p7o0hnJMvlsfhYCn61rIqAt0E/1eWOd9YsqVYFv1ykZW/gtf57k3eVfDk/rTPYc06OiQYVLjvRo
 hFbdzNMdoZoDDJj6Towwpa6Di9W2MWmg4oFhrcKlXblUx4Cj0KvT24
X-Received: by 2002:a17:90b:33d1:b0:359:f43d:4a6e with SMTP id
 98e67ed59e1d1-365aa93c123mr2307983a91.0.1778054110764; 
 Wed, 06 May 2026 00:55:10 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4bcaa49sm1380997a91.1.2026.05.06.00.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:55:10 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 j-young.choi@samsung.com
Subject: [PATCH 3/4] hw/ufs: Reject zero-depth MCQ queues
Date: Wed,  6 May 2026 16:54:30 +0900
Message-ID: <8d3bc0e97de971ec10727f5bc2b5f9183eb62976.1778053560.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778053560.git.jeuk20.kim@samsung.com>
References: <cover.1778053560.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reject SQATTR.SIZE and CQATTR.SIZE values that produce zero-entry MCQ
queues. Such queues can later trigger a divide-by-zero while advancing
queue pointers.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |  2 ++
 hw/ufs/ufs.c        | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 531dcfc686..7734b35f08 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -40,10 +40,12 @@ ufs_err_mcq_db_wr_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_db_wr_invalid_db(uint8_t qid, uint32_t db) "invalid mcq doorbell sqid %"PRIu8", db %"PRIu32""
 ufs_err_mcq_create_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_create_sq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_sq_invalid_size(uint8_t qid) "invalid mcq sq size for sqid %"PRIu8""
 ufs_err_mcq_create_sq_already_exists(uint8_t qid) "mcq sqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_sq_invalid_sqid(uint8_t qid) "invalid mcq sqid %"PRIu8""
 ufs_err_mcq_delete_sq_not_exists(uint8_t qid) "mcq sqid %"PRIu8 "not exists"
 ufs_err_mcq_create_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
+ufs_err_mcq_create_cq_invalid_size(uint8_t qid) "invalid mcq cq size for cqid %"PRIu8""
 ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exists"
 ufs_err_mcq_delete_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
 ufs_err_mcq_delete_cq_not_exists(uint8_t qid) "mcq cqid %"PRIu8 "not exists"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1819ba2e8a..4ccd7aa64d 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -506,6 +506,8 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     UfsMcqReg *reg = &u->mcq_reg[qid];
     UfsSq *sq;
     uint8_t cqid = FIELD_EX32(attr, SQATTR, CQID);
+    uint16_t qsize =
+        ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
 
     if (qid >= u->params.mcq_maxq) {
         trace_ufs_err_mcq_create_sq_invalid_sqid(qid);
@@ -527,12 +529,17 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (!qsize) {
+        trace_ufs_err_mcq_create_sq_invalid_size(qid);
+        return false;
+    }
+
     sq = g_malloc0(sizeof(*sq));
     sq->u = u;
     sq->sqid = qid;
     sq->cq = u->cq[cqid];
     sq->addr = ((uint64_t)reg->squba << 32) | reg->sqlba;
-    sq->size = ((FIELD_EX32(attr, SQATTR, SIZE) + 1) << 2) / sizeof(UfsSqEntry);
+    sq->size = qsize;
 
     sq->bh = qemu_bh_new_guarded(ufs_mcq_process_sq, sq,
                                  &DEVICE(u)->mem_reentrancy_guard);
@@ -576,6 +583,8 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
 {
     UfsMcqReg *reg = &u->mcq_reg[qid];
     UfsCq *cq;
+    uint16_t qsize =
+        ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
 
     if (qid >= u->params.mcq_maxq) {
         trace_ufs_err_mcq_create_cq_invalid_cqid(qid);
@@ -587,11 +596,16 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (!qsize) {
+        trace_ufs_err_mcq_create_cq_invalid_size(qid);
+        return false;
+    }
+
     cq = g_malloc0(sizeof(*cq));
     cq->u = u;
     cq->cqid = qid;
     cq->addr = ((uint64_t)reg->cquba << 32) | reg->cqlba;
-    cq->size = ((FIELD_EX32(attr, CQATTR, SIZE) + 1) << 2) / sizeof(UfsCqEntry);
+    cq->size = qsize;
 
     cq->bh = qemu_bh_new_guarded(ufs_mcq_process_cq, cq,
                                  &DEVICE(u)->mem_reentrancy_guard);
-- 
2.43.0


