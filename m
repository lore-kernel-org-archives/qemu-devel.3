Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7E1CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vm-0000Xm-IY; Mon, 18 May 2026 17:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vj-0000WS-J2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:27 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vh-0000b8-71
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:27 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcd689829eso2448348a34.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139704; x=1779744504;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9/Pm983+RalHXEJdvhTE1ujaaD6WPIIdOj3PbrYoEDY=;
 b=gGF2UTrQ/XXc4NHuTUnA11mhZLme189qbbgwP4jvL82PlQpFeXX7pFe+uCxak8gvsr
 CVg/HD5dOUmkQ4mpygf6+DRpebQy5+EixRNtguoN7inJc8dPQcNtxarRpw49bTOP2Tj/
 7XUqFDigrPgTCK/W1KEjK12LWVC4gweC5O9f1yj4NXbxdyrJ3869w1G1Z5RPfpb9olXh
 upfxAuetsQdatn9bhvrzonH2FWgHwCe82Kfb17eraDI0kWxekpav/eG2aMIDTtZBzTgp
 AwJ2I8t7BsTW6ADjwpbn4o5O+g8iLjSKANKHKhJz9YpBRQInoMUHILQb4yUDC9ees+Cs
 f3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139704; x=1779744504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9/Pm983+RalHXEJdvhTE1ujaaD6WPIIdOj3PbrYoEDY=;
 b=c+PwOXCdK6Mlq7KyFps+qRuwk4aKYyCtHWvNbgAUqQu4SpxTArrvad9FVT8mxeoGZx
 nAGYF/K7c1MAKoDHhSSYHGQWFKY6Ph4uiEw22MTY7PaLUBVwR7geO5pkskygQ/WGBCZ5
 pFOkVEtBWRddCs2Wx1KAgmuDjK/vc4Kx1C1GPiOQyXMuvShYRzk/SmBOlndMVObvmnDe
 VThZPE6TjBCWkDhM4DYhVkTX3pbk7ugwq4/JHDbqwih5UMKpr/RUkGp4/HDdlqDzyD6a
 djG/A6MZHTz+Gho/vTz/RQjEFhOPxKZ9my+U4CpSxp4aSgJtlTOAsjQATG8UrR/lBZDf
 5mFw==
X-Gm-Message-State: AOJu0Ywryg44eMLlD6IWpr1Cxd01UznJSMvsJasVGQ9YQ84LOgjJNMP4
 cyVhIOwwC8vFjJC/i76iN3EXrg8f+Y09RiOJ6qETxWspzeImVo20+aqejFQFz1D1JN4=
X-Gm-Gg: Acq92OG+XnSYi9HjNZnOS6ShTpyY+fgFZjuO0PiGM1vZePr2AAmGEH7csq8bnsIIdzT
 HOPUAPvc+Iq30yzlvwtKpSXM9P0w+4KdFqDC6DFKTQ3AiLZNlDu61+yrdBHTBg7PRFcrv34/prD
 w26qNmCwE+OOKQA6Y+/70/CYQyz/3QFtLUIaSAO+BmNCwaksvznkWVXwOM/vr7Lq+9I8rikV8Pc
 KJ0zT4HbGQ44S/emm4j7RPB6a99vWKqw3brR7X6Rqlmqt1mODl3jGzJYrJhNsoNeGR5nRZZe0Q7
 gK4IVKe6OVjw1IBciMEA5iBqgpCiaer+YgQzYtxql5KaDO1wAzydAKdvBf1t234+3a1BqdV6jbB
 Gk2hY2QHYwh0wC5huteSLXHguGSAShbiTqzSQ2sURF2NP4JzbS7O6dACiKmcGymEWoFUTp1KSX7
 5uMD009TuDLg==
X-Received: by 2002:a05:6830:3c10:b0:7d7:58b0:7685 with SMTP id
 46e09a7af769-7e4f2b45a37mr11795047a34.13.1779139704277; 
 Mon, 18 May 2026 14:28:24 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:49 -0600
Subject: [PATCH v2 31/37] bsd-user: Add link and list extattr functions to
 os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-31-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5758; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=PPbhfZAlz9FxOpn1hoNZ1jrd9DPBmOMpHGkAGZveSpc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RJE2p5r0kysLDzLNjAnUH0pZbZOSUJhksaz
 OkrBm/eqkuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESQAKCRBsHNEofbAR
 AKNFEADe7TJLTpUEb8WF75QT84uyv4ShkP10lkYzSVsJRZkXV6ywwqD4yO8yOp0ClGJtxgXdMHF
 XWGoGRqc3MEInOBN/PQ6z5fV3fgiMFm2P6iB7sgNiuGmuuEJo3RjI4ds317/6lPvWKo9Mx7phu/
 dlw3CtoPkk+Jc0iPLcM+9T3IX9yEVhBV48Y8wfePJoZjMVAjBkK3QJerWRlhwbqEaDwranLCu1P
 xTIBaaFS7rDf9YzuHnMU2p6rUlmGafQ2tuo22gZw2V4dWUEeWcjy5p/eaHZQq6naerunQ4ZRrqn
 yww70NdkQhRGG3iWNODrz0wY28m2xXfR/Mq6hvijBWJSYEgMQKfg5toyedvcZsbnayAXmTca/EB
 /l7LZj3cowWlSd8iFQ1G7Zv5iP3mf4VXCaMCJSc+F6qdwBfZzMpEmOwrQ92eLwTcS7Y+2SJqlnq
 spDGVhcKUWJaTyqCailqYEQLaLf7+fkU9/DeFfMXjXiZqZQ+6iWFBU7n3czWoQqlsJxBijGVgXc
 ztBZzcaJwN+bsZ750Lm4e/2jj0MyXSqBMYVYjMQ5zja6nRBMjgMPJ1zARSWYlBTlS+eXQDXiHeK
 gf63hnPuxmNFfVQuxEDuIfn0/3UQYsPLWDmJ96vcwY/1WCBOtSD62cBrYTKgDCuvsdvtNw1TGHf
 45otcow17+q5xVg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add extattr_get_link, extattr_set_link, extattr_delete_link,
extattr_list_fd, extattr_list_file, and extattr_list_link.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-extattr.h | 172 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index f1dfa344cf..788e40ef30 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -204,5 +204,177 @@ static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
     return ret;
 }
 
+/* extattr_get_link(2) */
+static inline abi_long do_freebsd_extattr_get_link(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
+{
+    abi_long ret;
+    void  *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_link(path(p), arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_link(path(p), arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_link(2) */
+static inline abi_long do_freebsd_extattr_set_link(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
+{
+    abi_long ret;
+    void  *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_link(2) */
+static inline abi_long do_freebsd_extattr_delete_link(abi_ulong arg1,
+                                                      abi_long arg2,
+                                                      abi_ulong arg3)
+{
+    abi_long ret;
+    void *p, *a;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_link(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_fd(2) */
+static inline abi_long do_freebsd_extattr_list_fd(
+    abi_long arg1, abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret;
+    void *d;
+
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_fd(arg1, arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_fd(arg1, arg2, NULL, arg4));
+    }
+    return ret;
+}
+
+/* extattr_list_file(2) */
+static inline abi_long do_freebsd_extattr_list_file(
+    abi_long arg1, abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_file(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_file(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_link(2) */
+static inline abi_long do_freebsd_extattr_list_link(
+    abi_long arg1, abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_link(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_link(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/*
+ *  Access Control Lists
+ */
+
 
 #endif /* FREEBSD_OS_EXTATTR_H */

-- 
2.52.0


