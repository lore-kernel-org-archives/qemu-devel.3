Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E183E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfg-0004HK-KN; Wed, 18 Feb 2026 08:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfZ-000465-Fi
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfL-0005eo-7y
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xXGf9wQuXiSKLxPb3FYIBG/K87QsiFd36ndnCqGkII=;
 b=NIgSMuTfWBwOHSm+OI3lXnF7gfZ/gVy+USj69XECvqFltayaAS34yyAIAD0AeT1/ERUE4z
 m+WGmFxqfRgUOWX4/80SKcI+MtVqflFo53aLpbhJfOo8ZF7YBf3+YeWCsYe6fGhj4arXYx
 W91cBcwT/zPkmfTcCGeLhGFnFdVjkSQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-6VMkZD4ZOeuX7w_UEyMf9g-1; Wed, 18 Feb 2026 08:27:22 -0500
X-MC-Unique: 6VMkZD4ZOeuX7w_UEyMf9g-1
X-Mimecast-MFC-AGG-ID: 6VMkZD4ZOeuX7w_UEyMf9g_1771421242
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so59699385e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421241; x=1772026041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xXGf9wQuXiSKLxPb3FYIBG/K87QsiFd36ndnCqGkII=;
 b=Qdk6/Xq3YbV9wEOTk9iRs6ZRws1ySI+DzBuDN31fixqmL/uuEygtbxJqjnjDUKNVhn
 UPvnNoK29mG0Ptva0deMWrGlJWCUEpBqVIdT0VBd2pEi9udEYlOmrNHp0WRzV4REnHLZ
 EIykGYM1fRFrHZW/xMslxXcISCqkAF6z/jru19rbnom0dQdCU/8tUnEYXGLU1vrx/gUZ
 NzS/gqYLWFxoN04kO6IHb30dKdFpDE61ifM4HH4c9YlWsHvDNAH8UnqanOsRTDSgXwpt
 lpSfkpdbCjTsbdoJ+oPsi1O1tAVh6/iN3R97VFuRjfPfQhs4vQ3BrYL3WCMrbBTo79x6
 iSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421241; x=1772026041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8xXGf9wQuXiSKLxPb3FYIBG/K87QsiFd36ndnCqGkII=;
 b=DKiudhNuaFgmmcJ6sJJss8j9sw+xaOC1ecdDFuij8Cne70tbL43jAL4U0awEy+EGEa
 OfXYQ7ecRrkdJR+g5TqKStBUzHaY/LPrxO/mrtBsEoOFFzT2UECvibi+u3Fc+LMzEf49
 9qpslpYEAZS9HZNmXHLW1p6zLxfNHQIe6so7CqOcwQ6Nvg3qEt8TAWSYsPYNzpwg4neR
 bTm7L4qT5b4w7R+yaydOSkAw3dvYEYSqotRDDbZ/SSVlLZWJKXHGlQ/6IB5fZlMy85II
 zxqGPpnKM70e1TpSY/LzA+1pDWzmqwVsecJ02SSdM4vn3c+XchDgOLRw4NWAU/XIy55s
 Kt+Q==
X-Gm-Message-State: AOJu0Yy/QciD5a7wUl5jgXnz1+S9KbFzXHjEIqiT8fb68JxxkwpOMCXZ
 wyjilA8B+FpnPgI2PRwUfjhzRsr87pR5vIHdQScq9zcuTWlXXGk6eCoARKktdmTC6Bk2mw1mSUx
 YfFWISL98pxP3bYuXrOr8AOfFge0HORWjZClb4MePc2Zi4LSS0fXva6LM
X-Gm-Gg: AZuq6aICf+0FDJ6nVviPyFVeTZizsP8w8LAXysbNVmBX3tfiXqaQem1ISDBEwElLDUQ
 AfaQmkbytfTAGmlmqSLbBm4yvT9oemjhLZLTb22bx87m3W2EfFuSoDR16rqtGsSDRxQ1HddS+15
 qaBq93BrT/4BDyWsLWP2sCQzYGkM3nqtk3ZsdEfWPvzneSfkUp3u2H84TQQ9YwpM+rHzJSMm2oA
 k7U5iNo+aB6k/Yb3K76txDtCX4F7HQ88u290p+MYbML35qPIHO7M6XaMrIHOW9JrKNI9cQhWhIG
 hVj6dCS9coOvoHEAsjOXLYvLps1uUvH4ihdesX+rlOEBo/LKZPFrtrqM4Xo5eekhBq+5xQ248yg
 trfjP8yiEzheYs1S4OoksfNVZnT7WA5HJWbSjA5o/8C/3TTJaJXc5hCTlpzRlUDM5ux2U0h3Eio
 MSkIZu
X-Received: by 2002:a05:600c:148f:b0:483:7f7c:ad89 with SMTP id
 5b1f17b1804b1-4837f7cb108mr162399005e9.37.1771421241476; 
 Wed, 18 Feb 2026 05:27:21 -0800 (PST)
X-Received: by 2002:a05:600c:148f:b0:483:7f7c:ad89 with SMTP id
 5b1f17b1804b1-4837f7cb108mr162398695e9.37.1771421241028; 
 Wed, 18 Feb 2026 05:27:21 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48387ab1974sm207441865e9.3.2026.02.18.05.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:20 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 15/24] block: Move qemu_fcntl_addfl() into osdep.c
Date: Wed, 18 Feb 2026 14:26:24 +0100
Message-ID: <20260218132633.29748-16-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index b384b5b506..f151578b5c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -633,6 +633,7 @@ int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+int qemu_fcntl_addfl(int fd, int flag);
 #endif
 
 bool qemu_has_direct_io(void);
diff --git a/block/file-posix.c b/block/file-posix.c
index 6265d2e248..e49b13d6ab 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1056,21 +1056,6 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
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
@@ -1109,7 +1094,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
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
2.53.0


