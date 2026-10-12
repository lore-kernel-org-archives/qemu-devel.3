Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2414CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDjt-0005fb-8d; Mon, 12 Oct 2026 06:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDje-0005cb-K8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:26 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjc-0000vI-Sr
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:26 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ccca948203aso547746a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802703; x=1792407503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ecy/dAmBmlUUJNwI7R0zMatOFewvkTQ2mkggnhbfvX8=;
 b=fdW0DFEu7Oy6tO23KE6DsNflwL9qlITj++sfmuTt70zuIvKHfKMWtBUQbJvpINeHVD
 ECChMuITscO6ZrbYtHTm8Ixcgz8XTanHOsmgPcSoVt8dTbt6XFyI9ZJWRfvrma+szx+o
 SjD8GBb+j3NmH9ah6d0y37WG40iannGW6TddJAVUFpQJWwHmMnma6zVGTBdzbtNWzOfG
 H8sarnDSYaCaq9y8MQlv9spwRugFJudzxTLTfV/hSUJtJRusRFq0zUscmEl5+7z91Sdt
 lPTL5WnQ1Miyamk2AV6VaT5JPdV0+gt4g0TS2I6HM4tQ8ho6tOD6Gpk8WzE7ytYRcD04
 F4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802703; x=1792407503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ecy/dAmBmlUUJNwI7R0zMatOFewvkTQ2mkggnhbfvX8=;
 b=mDiNvuGwZC9s6/E7jS4qZDYyRXGFzXCKNq8yqti3KGxk34d39arzC+fUvrMZA2u/Ik
 74S/oX4mY7Jy9NNInH/Vrl0R5pax7MZ82cKbCxn5txHvVWbz+x/DI9S63OwjOn/O0xzV
 d15RuvGMlSmj/l6Ru6cT70wJMpkipXab5sgAY03yEUrgPp0mpiWu228rO2uOolBA4OM/
 w0BNy1NHFd+0EFbIDZZ26Z/75zaf4VheFtxxD/TVrkP2Zh+wyPUd9uHpHJ9fBF9xjFRE
 EUom409etCQHKYuJM5TIsCcP4ivq6i+/ulVt7wBMQlw7tCAnC4dokSRa39/Ivjsu83/v
 dZOw==
X-Gm-Message-State: AFq9FYK4aZJoVvp0qv5PlyWi8E2GFvZdwv2W7MN6f2USLvmprT3qrzF9
 p+k1LcDLxUw/MaKymp/8nwr2Ox1+o9XDwSC85MnjY6IK1mSyUCLMYZimLiIxZw==
X-Gm-Gg: AYBFou3mqcjyo5n61Sux9fZIRD7/ub84yt3bXqlNeoqz4BrTBd0r5HJP56kjsbzC8s3
 plpNQjWVGVFCl3xzMkiggWLNvxb1vWXLEG7kFlxcyC9esjeK+O+x7QO+nA0p458CY7Lly5I1say
 DGsyeD64jGZlbiPh5W+MG214/gNLV/xLgaa0718hn3kZRQD6BVwKhgqPmKNlR2WsLJ2r0fNGcqk
 M9XLjRgntEnIJ/4l1tUfXO5FzjLFcEGf+N5a84BvTCtHaey4XizC+WEY2W51lunZhfvO19QeYlY
 or6V2wRomKYC3TQP+GsouCjVAyapzcNzyWdS6WjqqxTc99cZMFhqTIULPSEywvZJzeiv9Gp2xE5
 6VKCtkexKbiVAsdBXwlicmSyl2Hxq3LkbzZ3rbV3SdCXFWLfMR+bR7kAAsIb34Hej+ZncRBUgHK
 BvYU7OK63aquUoiSWhNnip5NGggF6N3X+TZaYU41xTQfeTIM5v9pHSzdzdQdtY4EM9qPixgtmPh
 jM=
X-Received: by 2002:a17:902:e5c1:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2e8427f762emr79594495ad.6.1791802703014; 
 Mon, 12 Oct 2026 03:58:23 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e6aasm41220305ad.18.2026.10.12.03.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:58:22 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stanleyjhu@google.com, pierrick.bouvier@oss.qualcomm.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 1/5] hw/ufs: Track SCSIRequest and cancel pending requests in
 ufs_clear_req
Date: Mon, 12 Oct 2026 19:58:03 +0900
Message-ID: <cd8fecdaefdfa143526d87a48cf32ea9c01e79a6.1791802312.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791802312.git.jeuk20.kim@samsung.com>
References: <cover.1791802312.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stanley Jhu <stanleyjhu@google.com>

Existing callers of ufs_clear_req() only invoke it after requests are no
longer in flight. In preparation for Task Management Request (TMR) task
abort and MCQ queue cleanup support, where individual in-flight requests
are aborted without purging the entire SCSI device, track the active
SCSIRequest in UfsRequest and cancel any pending request via
scsi_req_cancel() in ufs_clear_req().

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c  | 8 ++++++++
 hw/ufs/ufs.c | 6 ++++++
 hw/ufs/ufs.h | 1 +
 3 files changed, 15 insertions(+)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index bdb16508512..5905c49fac9 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -173,6 +173,9 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
     int16_t status = scsi_req->status;
     uint32_t transfered_len = scsi_req->cmd.xfer - resid;
 
+    assert(req != NULL);
+    req->sreq = NULL;
+
     /* WB / HID accounting should only happen for successful commands */
     if (status == GOOD) {
         ufs_wb_process_write_req(req, transfered_len);
@@ -190,6 +193,10 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 
 static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
 {
+    UfsRequest *req = scsi_req->hba_private;
+
+    assert(req != NULL);
+    req->sreq = NULL;
     scsi_req->hba_private = NULL;
     scsi_req_unref(scsi_req);
 }
@@ -389,6 +396,7 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     SCSIRequest *scsi_req =
         scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
                      UFS_CDB_SIZE, req);
+    req->sreq = scsi_req;
 
     uint32_t len = scsi_req_enqueue(scsi_req);
     if (len) {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 3c4d7424dae..adae6639e16 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -2221,6 +2221,12 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
 
 static void ufs_clear_req(UfsRequest *req)
 {
+    if (req->sreq != NULL) {
+        SCSIRequest *sreq = req->sreq;
+        req->sreq = NULL;
+        scsi_req_cancel(sreq);
+    }
+
     if (req->sg != NULL) {
         qemu_sglist_destroy(req->sg);
         g_free(req->sg);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 6f2693b7ca2..265a43faaa6 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -60,6 +60,7 @@ typedef struct UfsRequest {
     UtpUpiuRsp rsp_upiu;
 
     /* for scsi command */
+    SCSIRequest *sreq;
     QEMUSGList *sg;
     uint32_t data_len;
 
-- 
2.43.0


