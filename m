Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D63F36C58
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnTF-0006be-Iv; Mon, 20 Apr 2026 08:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSW-0006HV-UW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:41 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEnSV-0004Rl-5h
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776687036; x=1808223036;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FRDFZTXk/wsz+JehMsAdHWcXLCvo0ta2YnqKF+zvKDE=;
 b=J6WC+/9QXdkFBTxlopngrVaIb+3Pn2A7b8Fd4T+N31RY8zpZ7Y9ZWNGt
 y2q/hWk1NWxioZe+G7KFc5ugHLkaEw1xM9bwbVoabdCvz9P9fC4joDK1d
 ongSJ29csNFcthZwTZHWE4Gi/BnXZ6tSab4E+0sFZVhr+04EF69ykVFCF
 iXYUs+X/NSHUwuX/R5dFnbwC07Fim5IrSoTxbARn59ZGgSAvcq92a+Tqb
 1buNECtE5lVQO9NVKmwmuT7R3JcUe+HB0TIdMTeqDhPO65CmA00PdQOjT
 yFuEo2cAttVeEKwDNtDt5sZVnjn48w2x7GSc3kmH5edjrXQUeSYlOX3+u g==;
X-CSE-ConnectionGUID: Mlu0mJGSQI+qcD8g5BblLA==
X-CSE-MsgGUID: qN3uVjSBSQeF/4UeCyCVzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88674256"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="88674256"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 05:10:35 -0700
X-CSE-ConnectionGUID: p0+IrDa3SFCWxpDZ3XGolA==
X-CSE-MsgGUID: gfrZWsBTTf+5knFCofey6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="235708280"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 05:10:33 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	junjie.cao@intel.com
Subject: [PATCH 3/3] migration/qemu-file: drop incorrect const from
 qemu_get_buffer_at buf
Date: Tue, 21 Apr 2026 04:13:17 +0800
Message-ID: <20260420201317.30199-4-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420201317.30199-1-junjie.cao@intel.com>
References: <20260420201317.30199-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

qemu_get_buffer_at() reads data *into* buf -- it should not be const.
Drop the qualifier and remove the now-unnecessary cast.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 migration/qemu-file.c | 4 ++--
 migration/qemu-file.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9dfb202203..d5a48115bd 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -550,7 +550,7 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 }
 
 
-size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
                           off_t pos)
 {
     Error *err = NULL;
@@ -559,7 +559,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
         return 0;
     }
 
-    if (qio_channel_pread_all(f->ioc, (char *)buf, buflen, pos, &err) < 0) {
+    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
         qemu_file_set_error_obj(f, -EIO, err);
         return 0;
     }
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a390554208..8f824c124d 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -76,7 +76,7 @@ void qemu_set_offset(QEMUFile *f, off_t off, int whence);
 off_t qemu_get_offset(QEMUFile *f);
 void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                         off_t pos);
-size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
                           off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
-- 
2.43.0


