Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85974FC6160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9Kt-0006JA-5m; Fri, 13 Sep 2024 12:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Kp-00064c-2d; Fri, 13 Sep 2024 12:39:51 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Km-0000q5-72; Fri, 13 Sep 2024 12:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=ArUS/2lPV+fzhq7HB4Qvl1qp+hz9WlMqmNQIim6zw0I=; b=tN9g0vOZB7fa
 tXFZLoy9YMBCxHpeyV0hxh6zhO84GCY0rK/PEVPYN5gUJ10ThCG7wBGCWBhC2igUZo/UEyrCr44tq
 Q4e2e4RQB97kx8SkdU2PPiGjYtybTBCgRL0wfNTDG8ybc/VS4xLAK1iocRvydP/a+1+sEPfQnerCR
 7hUFYPFhV98kRFTWOePQMXb2j44MAZrkBVXlqstEu1RZROvHj6P0pX8NFK5sNrGxPUUpHI65TPJFZ
 lzxbiXoZOT2F29hlsW7NQ09eh8zBTu0fTtiARxfXtDkREtkh5nZ4OKSyZKa0p1pWvS+FvF17Irmle
 Xj6cw2hOK1n7GdKa/T+rgA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hy-002OPf-2o;
 Fri, 13 Sep 2024 18:39:39 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 04/12] block/file-posix: add trace event for fallocate()
 calls
Date: Fri, 13 Sep 2024 19:39:34 +0300
Message-Id: <20240913163942.423050-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c | 1 +
 block/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index ff928b5e85..9016057926 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1862,6 +1862,7 @@ static int translate_err(int err)
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


