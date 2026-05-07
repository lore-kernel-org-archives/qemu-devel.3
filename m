Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F9ACD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWn-0000d2-T2; Wed, 06 May 2026 22:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVo-0007XA-TB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:31:00 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVl-0000a9-0r
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:52 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7de46b8e432so336182a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121046; x=1778725846;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ry/+AD30vqQ1SM10FWDtz2pfyCCIJfoXwGJ8k1dXU+Q=;
 b=eCBxrjyvqTVaYsZenoReqAuVqvqwdDsgWaeOt6UnQb45xZt115tzdsenIPg/XL51RO
 VLhRsv91gyenuSDyg0ciSQJA0kiJi5oo8MuaNbNrxQjjtAT6bomQxp23NIRc9gR6e7NJ
 cHmBfK1QPbKcUxm/gxTbw4ubZWcIkbO0qScEmSYTsXAair9bbweW8zElSwqMVgsKhAe1
 VUWPQdv+mm9OpQeA4hDNEx1HcgevouShI0/1QqGYQoo1WsoBePlEGIEFOi45hozTJreZ
 SK99lvfdHGUKHgt+/w/J072tvZpLdUMTkOR7H9TSRiKjhrenMYqP/TH13FhfWGWtQopc
 Vmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121046; x=1778725846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ry/+AD30vqQ1SM10FWDtz2pfyCCIJfoXwGJ8k1dXU+Q=;
 b=XrhWiOm+coDzvpdixgNqu9whd3q/vS/1C55hQe1ohrIlnTlh+/LZDI0p1rRUIYyVP4
 xk/N6YX2QPIv2NPIGZW2OyNsbvLHQTGXM9FZNk+jfPaRAvbfyK6sFtPQdI8C+EwU7x8X
 Xs7Svma9rYn2pJGzailRpR0+vkEEJ1vg2/uTaVd4fKpxExFygd0mH9Smr3nkurdhIbCb
 4xMTNWWokxAWsYUB41rM8wMr6+gDD+QYIQmWWoXaRlAeIGLZAna+ap/cVIPw9mwRKT6f
 jIrYFjdVWdO8AXaL9qoKkU/ZpNK61rXMCmpUXZ09QW55bF+PCYvvY40FWLwptekRACoo
 TXww==
X-Gm-Message-State: AOJu0YxPELvrCoyVBo7epLHX7fYV0hQM5aPd4rOtODOvZaBHiEzTKY2v
 gqMg/tSDM9sYeHTvkpnh3+10dXcLsAH2YP7jOTGTzPHzsjPTd0uHC92JGA1cCmoH7ml0cD39QbW
 9fCi+n/g=
X-Gm-Gg: AeBDieugdqLyEh3yFLsk0T16YGIsWFwnR4f12+Ja/M3lTmOzc7XUqJ5+smlr1iQZSXP
 XJdsUZG1DPXn1blJpyUizEzoSPvqRGzWwzbL+FzjF3JeEFamqJS6C2cxf8+oR9nAQi1ejfpTlwZ
 TnLRuCr3fIyS7u/Lq3QqlT3hYajaAg1+Ki0INUgtoOuC7Wskvwl/Kkb8hwaaNTXrIaSlxXAwHlq
 ckJZOVGEDJ3GGUXZaS6BtCXM3+fxwRg9gw6iE4RAKnsCQ0Gee3+SfhHyeoBKpsBQvHmqUTPa61L
 ipV+ub7zOBnjbjFi9E+NKVAQCKTeQ8IfGsoVVbNZIz1rLRI8PJrNJd72+pMn3ceSBwkc+xhC+Kt
 LdmWKZr0t/phSwF3Ru02OP9lyLGUJg1tPAvq2ikaCTetXEnoLIpM4u487LSWAME37VhYWqvecWG
 2Y4u6nTFV+dWPwuWlPm4G964VmREMlqtY=
X-Received: by 2002:a05:6830:2704:b0:7d7:f13a:761c with SMTP id
 46e09a7af769-7e1df15829emr3012072a34.23.1778121046234; 
 Wed, 06 May 2026 19:30:46 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 23/25] bsd-user: Add do_bsd_ioctl main function
Date: Wed,  6 May 2026 20:28:25 -0600
Message-ID: <20260507022827.44499-24-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add main ioctl emulation dispatcher that handles table-driven
ioctl translation with thunk-based structure conversion. Supports
TYPE_NULL, TYPE_INT, and TYPE_PTR argument types with read, write,
and read-write access modes.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 8d25d84dbe..3940a69260 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -292,3 +292,103 @@ static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
 
     return ret;
 }
+
+abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg)
+{
+    const IOCTLEntry *ie;
+    const argtype *arg_type;
+    abi_long ret;
+    uint8_t buf_temp[MAX_STRUCT_SIZE];
+    int target_size;
+    void *argptr;
+
+    ie = ioctl_entries;
+    for (;;) {
+        if (ie->target_cmd == 0) {
+            gemu_log("QEMU unsupported ioctl: ");
+            log_unsupported_ioctl(cmd);
+            return -TARGET_ENOSYS;
+        }
+        if (ie->target_cmd == cmd) {
+            break;
+        }
+        ie++;
+    }
+    arg_type = ie->arg_type;
+#if defined(DEBUG)
+    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
+#endif
+    if (ie->do_ioctl) {
+        return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
+    }
+
+    switch (arg_type[0]) {
+    case TYPE_NULL:
+        /* no argument */
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd));
+        break;
+
+    case TYPE_PTRVOID:
+    case TYPE_INT:
+        /* int argument */
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
+        break;
+
+    case TYPE_PTR:
+        arg_type++;
+        target_size = thunk_type_size(arg_type, 0);
+        switch (ie->access) {
+        case IOC_R:
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg,
+                    target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type,
+                    THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+
+        case IOC_W:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            break;
+
+        case IOC_RW:
+            /* fallthrough */
+        default:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+        }
+        break;
+
+    default:
+        gemu_log("QEMU unknown ioctl: type=%d ", arg_type[0]);
+        log_unsupported_ioctl(cmd);
+        ret = -TARGET_ENOSYS;
+        break;
+    }
+    return ret;
+}
-- 
2.52.0


