Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76936C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PEU-0007HC-7O; Mon, 13 May 2024 02:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEN-00077m-0o; Mon, 13 May 2024 02:32:15 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEI-0003wa-MO; Mon, 13 May 2024 02:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=EhlDRRck+FVgxMfW1jaod9Ue0Scw5Pjg0RWeaeVQrXE=; b=YlCn9OMQ9HHy
 NH+fhz/HwaG6thwJjb89H5aPX8KCQGCxFMgvSqMOa1+44ynXCN5F/cQ4l0nOdLW/bjlwoE44phTRG
 FAke/9fs95MfdHQSPn5yJdjXvgr65x86OYv8j7V7sH39g01btUbOTnnp9XPSmTiJTtoxV3M1SE6YJ
 dRMWAf0oTtTpgxuhoDU+uxh26AMJb6kF3GzP6Es8k7kryaRFnYZQEGDMhkwinAlF1VdmKm+n/uMyV
 IlGecQZ4RaiL+WK+MtoiS7roWQXFAv4hru+ktAcUYqgL6DGIBwrGu75G6ElZxPOgEY0HC7A7bnM9Z
 5GQixxXm9p6IAfu43btZ5Q==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAR-000qpR-2N;
 Mon, 13 May 2024 08:31:56 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 04/11] block/file-posix: add trace event for fallocate()
 calls
Date: Mon, 13 May 2024 09:31:56 +0300
Message-Id: <20240513063203.113911-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This would ease debugging of write zeroes and discard operations.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/file-posix.c | 1 +
 block/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..45134f0eef 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1859,6 +1859,7 @@ static int translate_err(int err)
 static int do_fallocate(int fd, int mode, off_t offset, off_t len)
 {
     do {
+        trace_file_do_fallocate(fd, mode, offset, len);
         if (fallocate(fd, mode, offset, len) == 0) {
             return 0;
         }
diff --git a/block/trace-events b/block/trace-events
index 8e789e1f12..2f7ad28996 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -203,6 +203,7 @@ curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "reading %"
 curl_close(void) "close"
 
 # file-posix.c
+file_do_fallocate(int fd, int mode, int64_t offset, int64_t len) "fd=%d mode=0x%02x offset=%" PRIi64 " len=%" PRIi64
 file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
 file_FindEjectableOpticalMedia(const char *media) "Matching using %s"
 file_setup_cdrom(const char *partition) "Using %s as optical disc"
-- 
2.39.3


