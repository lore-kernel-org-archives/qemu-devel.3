Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BA2C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZRl-0006Qa-5L; Tue, 01 Jul 2025 07:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQj-0005Vg-1P
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQY-0003a2-CH
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMe0OVYlTZYOUnzGRhuNbsELyRKdi/6CFqcynNPkjCw=;
 b=WJry8N301kh5oO52Ll1zTwkhWBu8rdKJxTfuEIpILVmgPC+OOPoogBvnvQLE3ZZdv6A4bf
 o833gmFn2KdDBKJnzVtfUWdJMheKz8m3J4ONZ32+FMZaYQ+AB1of1P3a6o5DOK9vIWchqI
 jXCTddNmQcZIzTlwnIc8A9whgCr8+zc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-q6jaT6KyOtep3jAMtSSolg-1; Tue, 01 Jul 2025 07:45:23 -0400
X-MC-Unique: q6jaT6KyOtep3jAMtSSolg-1
X-Mimecast-MFC-AGG-ID: q6jaT6KyOtep3jAMtSSolg_1751370323
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso3657816f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370322; x=1751975122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMe0OVYlTZYOUnzGRhuNbsELyRKdi/6CFqcynNPkjCw=;
 b=EIdTJZnCsMBi2b0npKsZO6ndOMSwL3uhehLQYmtt1dpiParZwpnE59HQIKmwM+Wm/v
 SAmG6hZ5LFY9Z5yWIPf8xcX51ABO3lagG7IKwBsPmQndBq7xQiDC5m7IC8XFdz4hbKc5
 x8MOtNLJaChi2GHVSGvsoDJBhpLOtQpTXiNvMGA7wU+tQQnYagWYO26kjWEqCNBuYijp
 QpaLRCDQgZzSEaH8aDxom/pLaqvo3mNcT1PZazI+mG2Q9Glo5D1eyKJpbzfU1iRYk8hI
 zZJLDV2OOiMTQwszdbFjAWuxC4hZlYmKixviv3CPPNL+F0j7bMlmpBpDMkyQwZXTgDIN
 xdDg==
X-Gm-Message-State: AOJu0YxRVMmH4j0sa6x8ge91F4rPAYKiFZgWWNgRdP8aSL+HXQM5+myo
 /toKx9ooc9qHqRaRTrBVVEAnOZeB2MW2T630Ww7S4mv1HQzI7ntPg1E08XnUFLsDeXhlv3XL3KF
 sAVrKpE0jI4oZGD9qWWM0TxN57DRT4u/bgGkN9HxK1IHZJ9W4RLYP9TZF
X-Gm-Gg: ASbGnctOcvMDdLXEeijavFr9q7bmZkbdBUa8txT1oL02YI36amEKc1AJL9Rcoq0Nqeh
 UhjRjS0mW23MXa8ZZ266r3+JDFsEiF0aYki1+ohcr+Y1oTKvwaxLBITOgQ8ZH8GOrPpKUF3s5bv
 Tz2IFa2+zjHVfaINMDoba1TJ/DnznP5Nh+Hq7szzzMv6/qyf8UhEEPsto04/CmuLV9S8TaljpLX
 c1tdGUp5uWnuC2QGEaYolV+VqcvV+zqHLADygF/eN9dfIN8qrM9yDN8HABPhJ4HjTpBPbHMdqGo
 9i3cmSAiZQd7R1L4CyPvunBwX2muJFRN1IKKhjjczx0JZNQBbltkqgAOcO0ppNt+HKmat4FIxEX
 ktNGb
X-Received: by 2002:a05:6000:402a:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3a917603734mr15479243f8f.29.1751370322422; 
 Tue, 01 Jul 2025 04:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN2Yw9kikZpOXY+mDEhclFYgRLHty/dbkqGwASlPH8opYztE4LUWpI0gnGzaTZIXorxuUVmQ==
X-Received: by 2002:a05:6000:402a:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3a917603734mr15479218f8f.29.1751370321982; 
 Tue, 01 Jul 2025 04:45:21 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7518sm12850784f8f.2.2025.07.01.04.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:19 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 12/21] block: Move qemu_fcntl_addfl() into osdep.c
Date: Tue,  1 Jul 2025 13:44:28 +0200
Message-ID: <20250701114437.207419-13-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move file-posix's helper to add a flag (or a set of flags) to an FD's
existing set of flags into osdep.c for other places to use.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/qemu/osdep.h |  1 +
 block/file-posix.c   | 17 +----------------
 util/osdep.c         | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 96fe51bc39..ff11070c7e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -619,6 +619,7 @@ int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+int qemu_fcntl_addfl(int fd, int flag);
 #endif
 
 bool qemu_has_direct_io(void);
diff --git a/block/file-posix.c b/block/file-posix.c
index 9b5f08ccb2..045e94d54d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1047,21 +1047,6 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
     return ret;
 }
 
-/* Sets a specific flag */
-static int fcntl_setfl(int fd, int flag)
-{
-    int flags;
-
-    flags = fcntl(fd, F_GETFL);
-    if (flags == -1) {
-        return -errno;
-    }
-    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
-        return -errno;
-    }
-    return 0;
-}
-
 static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
                                  int *open_flags, uint64_t perm, Error **errp)
 {
@@ -1100,7 +1085,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         /* dup the original fd */
         fd = qemu_dup(s->fd);
         if (fd >= 0) {
-            ret = fcntl_setfl(fd, *open_flags);
+            ret = qemu_fcntl_addfl(fd, *open_flags);
             if (ret) {
                 qemu_close(fd);
                 fd = -1;
diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..000e7daac8 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -280,6 +280,24 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
         return fl.l_type == F_UNLCK ? 0 : -EAGAIN;
     }
 }
+
+/**
+ * Set the given flag(s) (fcntl GETFL/SETFL) on the given FD, while retaining
+ * other flags.
+ */
+int qemu_fcntl_addfl(int fd, int flag)
+{
+    int flags;
+
+    flags = fcntl(fd, F_GETFL);
+    if (flags == -1) {
+        return -errno;
+    }
+    if (fcntl(fd, F_SETFL, flags | flag) == -1) {
+        return -errno;
+    }
+    return 0;
+}
 #endif
 
 bool qemu_has_direct_io(void)
-- 
2.49.0


