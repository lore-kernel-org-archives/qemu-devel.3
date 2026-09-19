Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A0C982DA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yHh-0005kU-PL; Sat, 19 Sep 2026 12:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFy-0003yS-LI
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:46 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFw-0008R3-WB
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:42 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-4693691fc81so1085276fac.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836580; x=1790441380;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNP16yPun+E5+eIoIGqFoDrmD6nTs5/XLq7Sft9YkM8=;
 b=q4YyCOE6wCKpRQ8JS4iKtOKJNq3ea9e4Dnbh3dGyb6XMZiwGGf6KzH09eRY91cytVC
 XPINbU4JgHD1TsnMzil6Fe9YNLmq79/Y6gnR1Qk7F65A0Q7TEOHdpYjBFMN/uqsiF8E/
 Q4OcNEv9LirAW+KBBZbUC+nA4cmt9pPbCkZaap+ep2gxWdzRfD34Ed91iUjknnZfoARv
 8WoLnV4iEiJpfikM4h1IE93gCFSDPVK/wZYhqaHKFR4cObXMzvfDqgPPVfUBI44vdHHk
 7aK4KP/C6ZmI7FOjxsoky2bJ4y3dsD7Ihi/NURDz8Jup21ZYkGHZt1cb+MNRxSARhSi+
 9Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836580; x=1790441380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNP16yPun+E5+eIoIGqFoDrmD6nTs5/XLq7Sft9YkM8=;
 b=eDkq9odgz55UPKVQyKibCkNWeWzZukApoSz69XI4iG3KP+GANa+ZhH5MzNScx0INbO
 2vwt5nf9hDwm6vZdzLZNtFSv4WqirDmpxEdYQA993Hcz/+cqFdTY0/Jp3/yXTvBFn4WO
 3qCJCE0We0G9Nf7LiKFcAahlBXz5yhUveSWYPhjWVN09f5iL/+trT85cfF4/7dbzdHJ2
 Vv0mTKRXPbPveZb6bUEfVpIT+BjS5nOjAoNMy4/6oslyLIuwXMdNOr8Vzwgn4450HmlA
 WqSaIdqkXE0qBDdRzKXBThRklTV+aeE8b2AmhVg9aT4TBzb3CCIboW9yttgHywKNjart
 sc2g==
X-Gm-Message-State: AFuF++nOX11wD9E8JJL5Ul8Ga8oZNAeAW7bo0K/Jz+s60mvFB1MYgfyb
 w/MmM1VPC81q7y1T5UbIGub14kJqwU5I8Nz0yVJ9CcevXKbFWvKO5iX0SfxDtk7Vh0EalEs5HBr
 T/bZF3JQ=
X-Gm-Gg: AYBFou2KZDjVaSqCEE4f0D5i+H7CyzTFkz5n+NN0I803jYiBBpwaX49Z1sxNo1EeQPP
 Oj6qMVpm/LPQWHE2nJ+amsCem1jSlRuCOtv0JlZ5QnQVH8xDWwKB7Evge3+9MxI9YaSK+bPLpc+
 FGPFdxFtJ5zJO6Ie/P33vELMjBxjYeKqPu7Dvl73tVIB9lnNrT3hXihEq8Qdk+fYxZCxetviw5P
 u2xlWeVuaNDm31Lzqz6MjoU053zmbyfDkcqGpecX3D9CdCvZOxRx7qE5c0B0uwOxoGI2shDjXR9
 E+/peUl4ypcm9ab/25W5OOfg+9rSHXFC0nmarZoxqHRkjktlA9jP0XjWIe8VygdOYnNF3s6tu0G
 Vm5VGZaY1mBoivlP6sObS1Ue2Ap7uNSj2UkHp8kfFqxIyyZQCFvpjohJIAmCeD7zhTyx4edQrCz
 OyzJQB3GLdvaqi05ebOcMQSP9q73LEXDeXHlJxxXAYQdPHhjj/wvaKBZkDvYo=
X-Received: by 2002:a05:6820:3088:b0:6cd:3ffc:ad01 with SMTP id
 006d021491bc7-6cd3ffcb611mr2626870eaf.81.1789836579974; 
 Sat, 19 Sep 2026 09:49:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 37/41] bsd-user: Add extended attribute and ACL system call
 dispatch
Date: Sat, 19 Sep 2026 10:48:05 -0600
Message-ID: <20260919164810.70151-38-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
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

Wire up extended attribute and ACL system calls: extattrctl,
extattr_set/get/delete for file, fd, and link variants,
extattr_list for fd, file, and link, and all __acl_* operations
(aclcheck, delete, get, set for fd, file, and link).

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f385034a53..a14efd3fd4 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1365,6 +1365,109 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_sysarch(env, arg1, arg2);
         break;
 
+        /*
+         * extended attributes and ACL system calls
+         */
+    case TARGET_FREEBSD_NR_extattrctl: /* extattrctl() */
+        ret = do_freebsd_extattrctl(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_file: /* extattr_set_file(2) */
+        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_file: /* extattr_get_file(2) */
+        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_file: /* extattr_delete_file(2) */
+        ret = do_freebsd_extattr_delete_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_fd: /* extattr_set_fd(2) */
+        ret = do_freebsd_extattr_set_fd(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_fd: /* extattr_get_fd(2) */
+        ret = do_freebsd_extattr_get_fd(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_fd: /* extattr_delete_fd(2) */
+        ret = do_freebsd_extattr_delete_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_link: /* extattr_get_link(2) */
+        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_link: /* extattr_set_link(2) */
+        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_link: /* extattr_delete_link(2) */
+        ret = do_freebsd_extattr_delete_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_fd: /* extattr_list_fd(2) */
+        ret = do_freebsd_extattr_list_fd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_file: /* extattr_list_file(2) */
+        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_link: /* extattr_list_link(2) */
+        ret = do_freebsd_extattr_list_link(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_fd: /* __acl_aclcheck_fd() */
+        ret = do_freebsd__acl_aclcheck_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_file: /* __acl_aclcheck_file() */
+        ret = do_freebsd__acl_aclcheck_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_link: /* __acl_aclcheck_link() */
+        ret = do_freebsd__acl_aclcheck_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_fd: /* __acl_delete_fd() */
+        ret = do_freebsd__acl_delete_fd(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_file: /* __acl_delete_file() */
+        ret = do_freebsd__acl_delete_file(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_link: /* __acl_delete_link() */
+        ret = do_freebsd__acl_delete_link(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_fd: /* __acl_get_fd() */
+        ret = do_freebsd__acl_get_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_file: /* __acl_get_file() */
+        ret = do_freebsd__acl_get_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_link: /* __acl_get_link() */
+        ret = do_freebsd__acl_get_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_fd: /* __acl_set_fd() */
+        ret = do_freebsd__acl_set_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_file: /* __acl_set_file() */
+        ret = do_freebsd__acl_set_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_link: /* __acl_set_link() */
+        ret = do_freebsd__acl_set_link(arg1, arg2, arg3);
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         ret = -TARGET_ENOSYS;
-- 
2.55.0


