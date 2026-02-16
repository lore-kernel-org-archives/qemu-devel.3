Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4E6E7BD87
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvrs-0005xY-Bj; Mon, 16 Feb 2026 05:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvrl-0005we-EH
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvri-0006m7-Od
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771237803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9y4jIW3yOBt9OHzqVap3xId+tC7KWpl0iJxMP328cPk=;
 b=XL7uEidiWzBkEtA9JMprH0cejeT4pLwmP95DonogJVl8DhNIQYnByy6wWL5aWk+K9sq1zG
 c22/vY9qMDCrLnlu+PfPMSIWhzUtEWxJ60wgnZ18R+kPSh+saQDb32Iyfs8d4GTYEoyjaf
 wtzxlIv2GCQMnjb5XcBSycxAS+XNEn4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-AfG6aiP6NfiKNsxDsSjSnw-1; Mon,
 16 Feb 2026 05:29:59 -0500
X-MC-Unique: AfG6aiP6NfiKNsxDsSjSnw-1
X-Mimecast-MFC-AGG-ID: AfG6aiP6NfiKNsxDsSjSnw_1771237799
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8F8A180025A; Mon, 16 Feb 2026 10:29:58 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6E551800666; Mon, 16 Feb 2026 10:29:57 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/5] util: Move qemu_ftruncate64 from block/file-win32.c to
 oslib-win32.c
Date: Mon, 16 Feb 2026 12:29:48 +0200
Message-ID: <20260216102951.150381-3-kkostiuk@redhat.com>
In-Reply-To: <20260216102951.150381-1-kkostiuk@redhat.com>
References: <20260216102951.150381-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

qemu_ftruncate64() is a general-purpose utility function that may be
used outside of the block layer. Move it to util/oslib-win32.c where
other Windows-specific utility functions reside.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251218085446.462827-3-phind.uet@gmail.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 block/file-win32.c | 32 --------------------------------
 util/oslib-win32.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index af9aea631c..8a44853389 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -170,38 +170,6 @@ static BlockAIOCB *paio_submit(BlockDriverState *bs, HANDLE hfile,
     return thread_pool_submit_aio(aio_worker, acb, cb, opaque);
 }
 
-int qemu_ftruncate64(int fd, int64_t length)
-{
-    LARGE_INTEGER li;
-    DWORD dw;
-    LONG high;
-    HANDLE h;
-    BOOL res;
-
-    if ((GetVersion() & 0x80000000UL) && (length >> 32) != 0)
-        return -1;
-
-    h = (HANDLE)_get_osfhandle(fd);
-
-    /* get current position, ftruncate do not change position */
-    li.HighPart = 0;
-    li.LowPart = SetFilePointer (h, 0, &li.HighPart, FILE_CURRENT);
-    if (li.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
-        return -1;
-    }
-
-    high = length >> 32;
-    dw = SetFilePointer(h, (DWORD) length, &high, FILE_BEGIN);
-    if (dw == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
-        return -1;
-    }
-    res = SetEndOfFile(h);
-
-    /* back to old position */
-    SetFilePointer(h, li.LowPart, &li.HighPart, FILE_BEGIN);
-    return res ? 0 : -1;
-}
-
 static int set_sparse(int fd)
 {
     DWORD returned;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 839b8a4170..766c602172 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -899,3 +899,37 @@ int qemu_shm_alloc(size_t size, Error **errp)
     error_setg(errp, "Shared memory is not supported.");
     return -1;
 }
+
+int qemu_ftruncate64(int fd, int64_t length)
+{
+    LARGE_INTEGER li;
+    DWORD dw;
+    LONG high;
+    HANDLE h;
+    BOOL res;
+
+    if ((GetVersion()&0x80000000UL) && (length >> 32) != 0) {
+        return -1;
+    }
+
+    h = (HANDLE)_get_osfhandle(fd);
+
+    /* get current position, ftruncate do not change position */
+    li.HighPart = 0;
+    li.LowPart = SetFilePointer (h, 0, &li.HighPart, FILE_CURRENT);
+    if (li.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
+        return -1;
+    }
+
+    high = length >> 32;
+    dw = SetFilePointer(h, (DWORD) length, &high, FILE_BEGIN);
+    if (dw == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
+        return -1;
+    }
+    res = SetEndOfFile(h);
+
+    /* back to old position */
+    SetFilePointer(h, li.LowPart, &li.HighPart, FILE_BEGIN);
+    return res ? 0 : -1;
+}
+
-- 
2.52.0


