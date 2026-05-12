Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F42CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMext-0006Jr-Qg; Tue, 12 May 2026 00:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexm-0006Gv-Hj
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexi-00075O-BY
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bab82d75fdso27498095ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778560996; x=1779165796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfNfbmfumQccuX8qMq74MCT7/fIYFt3RmQiDbRRXf9c=;
 b=e7eKN9YSz74qI3CkhbUtqWstXsz8GV6D7vcVIjm6RItpj7C3G3PDIpzrxmqtAAafOX
 5jsD7S8o4u6xQLiGCj/eTDipmw/qN5F68HGiaLVb5C4i6EfIJfwRNpY4HoTFRopBtOmZ
 3ATRKumhClZDXGck1OxY+yK1PXpQJDAydrH2uu5K+1pMKukTbd2q0EBOjdVeBkBmX7pv
 aLN0x6gnKNdnlx8Xt4b1ymTrwWGbhz3TFef+T2PPB61uxY/fQpS0vjdYanUryRuCnnyp
 1MjHIokjpNjygP2dTlK8m/nzPZgsKbWeVgGxbdLqG4mBmYfVOK2g0k4MKXBDNcnUL14m
 t+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778560996; x=1779165796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CfNfbmfumQccuX8qMq74MCT7/fIYFt3RmQiDbRRXf9c=;
 b=Xqk4gJejJWV/0Y3hDz/X9gCatxXo3Qd6IMEX+4f6iUcrLflWERujn5Yh0XJ1biKl/u
 N/WRxZpgYxBWy73kt7GN8Kc3r/Ch03zHhULzTSrjzcPlEO0jjBmyYBp6KGeodbQKi32y
 X78RrtnT1yt5a52Ft/XVqIggsDnmYYeHn1wkgQ9gWqqA5t7lO5wPPPRqS+DEmPSlakWg
 DSbHENIRNskHoMLoQCI0oYUVnXX0HYOgcBHbCM6egYm6CuOZGxFdPynjiowi/yqhOzd/
 the+zd0uX6hwhcY5aaCZacXTLo3ov3PZfUx/lNf42mmjfajh0wOxW2dEZO5Y20vSaZvc
 tBWw==
X-Gm-Message-State: AOJu0YyZVsM//kjJvuJsGwRysafi74LgC9RapnPdJsVVx5s4iQf7ItHr
 Qg/oFKkq757tAxaiH15QlUj3rQ0rWS6jGbRLovf+sZq/V8s+N5HaMnrHSJ1JKA==
X-Gm-Gg: Acq92OFz7hmt37xTwVUA+Pp3h+HlY+4Mcb9/oJfSkAJRWJRTWgICpkYXC3CSz72y1LW
 EV+pq8HlPTaqArcClEu1semCyeQWf3gKIAQbLkK+MTvVREhcdP25A4TVuCCrsrRXkBTPBloAkS0
 Eaasdx5TCFi6ahUOo6Hkk20IuDGyO/S6V42mEbEQiTRl67IR7tMa+if6ubAv1uuTWURSfmKclWa
 DWM06R3urHZdmYT5rIwyDxvUSOiESCT/vDtfgbKJYB2TIEf1Oxoi6HGPyZnunSCKOcOXft7mEya
 qxHluyj33CWjI9A4oEFScXc2QJaV5A6gqOneHy0cvCUFM/5jSmhcnf1IrZ2NxQdyMbswfUiVWx1
 PcDYFwPgPHniT9r8pXxPQayisY/0bsG9CjXaj8H6aALHMEO8IfjgVxY7tO/00G34tY/pTHw4MWx
 Cf2vi8p14/nfIwqLCoNEmia6kgKH04
X-Received: by 2002:a17:903:1a28:b0:2b9:f8e9:70e2 with SMTP id
 d9443c01a7336-2bc7a990b6emr127377925ad.8.1778560995429; 
 Mon, 11 May 2026 21:43:15 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebe7f1sm108938215ad.78.2026.05.11.21.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 21:43:14 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Subject: [PULL 1/5] hw/ufs: Validate MCQ SQ references before use
Date: Tue, 12 May 2026 13:42:51 +0900
Message-ID: <332ea29787800fff2b49e9b89ec93bd370a11965.1778560533.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778560533.git.jeuk20.kim@samsung.com>
References: <cover.1778560533.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

A guest can program an out-of-range SQATTR.CQID value, or ring an
MCQ SQ doorbell before the submission queue exists.

Reject SQ creation when the referenced CQ is invalid, and ignore SQ
doorbells for queues that have not been created. This prevents a
guest-triggerable out-of-bounds read and NULL pointer dereference.

Fixes: 5c079578d2e ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Reported-by: Rayhan Ramdhany Hanaputra <hanaputrarayhan@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index cb74cb56bc..d5fba15e2a 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -517,8 +517,13 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
         return false;
     }
 
+    if (cqid >= u->params.mcq_maxq) {
+        trace_ufs_err_mcq_create_sq_invalid_cqid(cqid);
+        return false;
+    }
+
     if (!u->cq[cqid]) {
-        trace_ufs_err_mcq_create_sq_invalid_cqid(qid);
+        trace_ufs_err_mcq_create_sq_invalid_cqid(cqid);
         return false;
     }
 
@@ -775,6 +780,11 @@ static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
     }
 
     sq = u->sq[qid];
+    if (!sq) {
+        trace_ufs_err_mcq_db_wr_invalid_sqid(qid);
+        return;
+    }
+
     if (sq->size * sizeof(UfsSqEntry) <= db) {
         trace_ufs_err_mcq_db_wr_invalid_db(qid, db);
         return;
@@ -788,7 +798,14 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
                                  unsigned size)
 {
     int qid = offset / sizeof(UfsMcqOpReg);
-    UfsMcqOpReg *opr = &u->mcq_op_reg[qid];
+    UfsMcqOpReg *opr;
+
+    if (qid >= u->params.mcq_maxq) {
+        trace_ufs_err_invalid_register_offset(offset);
+        return;
+    }
+
+    opr = &u->mcq_op_reg[qid];
 
     switch (offset % sizeof(UfsMcqOpReg)) {
     case offsetof(UfsMcqOpReg, sq.tp):
-- 
2.43.0


