Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE4AC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14Rx-0002KR-9y; Mon, 31 Aug 2026 12:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14Rm-00029D-R5
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:24 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14Rj-0001WR-Ne
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:01:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cf452def93so20165ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192078; x=1788796878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZazPTB8lxfIB8WM1wpaGEcezQFI0+RTAozYokTq4HPk=;
 b=eaKCgeodP95iBi1qdHw5mqelgbYCTI/wRlMA1Pp272Uv/XsRuxz4kNMdtGNRWv9Qbi
 +t+H22Ohm4Vp6VcmJerEwD61jhZ5Te2AhR3jJvMcDOkeILq2lI5+xvWS5hNJmNhekzfw
 pmB8//xIvPwE1weEDVDDQSsdkGw0W7Mf0CE89u3Qe6OhzTL2JT5rNfbUsB8610W38j8P
 OM6KueLNVTk5CYddHnYGyF1bW8NUx9mS4pIxdS/3cSwbjcI5axhkgqzreCizWSiNzNtO
 sltQOo8q67BQ8/u+X6YjcOd01bcf/kA12DIYzVx1cVgOO5nyFfjNkUwtq3E9/ozuM0Au
 8Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192078; x=1788796878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZazPTB8lxfIB8WM1wpaGEcezQFI0+RTAozYokTq4HPk=;
 b=Jl8yCnzI+sOozwJ7wcIHHs3NyTERZSD78h0J6bTLIBSNVN4onXsm3ke/NgIGfnFgXC
 irV3/04ctuK35BHTefY1KGs6XMppgiTqcN42JpfD4AyWY1PHO55U8IVjS0lXmVIEW6UB
 Xd29pNxwdqHriUcA9eMyln6vEyQ9S2+xClvCL/Yomt35Jai8lSBX59H4+dd8SU++QC3q
 c/AioqKrr8o9vKJx2k+IrUgLCLJfC/v1MaPsBV33KXzcAVZNSJdBFY6ZARim28zJ9f8h
 CWn019Xo+S0q5x01od79h/r81/V/DaMeyWaJXay13wMAryKkpH3mV/F2ttX1FSdp3Wph
 V/zw==
X-Gm-Message-State: AFuF++kG8QeSo9iSN0jsTJulUsX9SV3AHjVm8l9EiI5Ut0hiXASKeoJm
 kOlK5qtkgeYAhczdBTtZdzy/lebCoy7A0KdZX3cHiGLlozIT7IZ4QZAdroF0HqS30xupRSSj
X-Gm-Gg: AYBFou1WLnghNlSlBM9e7ciLdISTlDyrrxc4/wjuRounjJ7F/DmBZIxbIDdN6duDirE
 W3UIVn7YMEDSqAK5u/lQZTKZODFhWBGElq/Nc2CaqxnDVgccX1/Pq8AVZIAs6eEIbi/2v6+q90c
 ufgdHPlIDg5Z/rhi0oSuKlcDEk6e7hoaHfwY/LXWFwFinvRZNxFK9RQvNToLnLD4EXxzUd4nIq+
 BU4/jMOt+9u1qMWriG2lzsHjVthhrJZVjiAxwptQlVNhM8il55PlMfnOZPzx4LhATnx1COsENl8
 2lIZEmAcCaBpjUjAEcuI7g4jkJ2LPvPQZu3vltd9sLhLn3QIUxQyWjvQyGtJhVktvMazrWLAKS8
 7NgNWKjpgY72sGOGhDwk0JIWCxxydOKmqmwK70awh6dkjiV/5qef7WQIW2lz+LhmC9pywu1Qinz
 v8G0q7LLd94KXFNCz3pPgTOJyYj9rrmLokyEUgQ3DgtRlL7KJTpgwaxGNLzvIKoSvQtZ1m5YNJc
 HZgfOI7
X-Received: by 2002:a17:903:40cc:b0:2d6:ee34:c043 with SMTP id
 d9443c01a7336-2d91b018bf4mr72436985ad.11.1788192077727; 
 Mon, 31 Aug 2026 09:01:17 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:01:16 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
Date: Tue,  1 Sep 2026 00:00:25 +0800
Message-ID: <20260831160038.221776-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add an explicitly unsafe accessor for legacy callers that cannot
provide a matching holder lifecycle, and convert blockdev.c to use it.

Keep iothread_get_aio_context() temporarily so that later caller
conversions remain independently buildable. It will be removed after
all production callers have migrated.

New code should use iothread_ref_and_get_aio_context().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                |  2 +-
 include/system/iothread.h | 10 ++++++++++
 iothread.c                |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..baeab3a3e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        new_context = iothread_unsafe_get_aio_context(obj);
     } else {
         new_context = qemu_get_aio_context();
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index f6c5f95dd9..2ef8c1a1bb 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -68,6 +68,16 @@ char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 
+/*
+ * Return @iothread's AioContext without registering a holder or taking a
+ * reference on @iothread.  The caller must ensure that the IOThread remains
+ * alive for as long as the returned AioContext is used.
+ *
+ * This API exists for legacy callers without a clear ref/unref lifecycle.  Do
+ * not use it in new code; use iothread_ref_and_get_aio_context() instead.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
+
 /*
  * Register @holder and return @iothread's AioContext.  The holder is copied,
  * and a reference is taken on @iothread so that both the IOThread and its
diff --git a/iothread.c b/iothread.c
index 58dace351c..803d6ce3c3 100644
--- a/iothread.c
+++ b/iothread.c
@@ -443,6 +443,11 @@ void iothread_unref_and_put_aio_context(IOThread *iothread,
     iothread_unref(iothread, holder);
 }
 
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
+{
+    return iothread->ctx;
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.55.0


