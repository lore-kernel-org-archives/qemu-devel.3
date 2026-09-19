Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63247C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yH3-0005GZ-DJ; Sat, 19 Sep 2026 12:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFy-0003yR-I3
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:46 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFw-0008Qz-K4
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:42 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-801a8bf8112so630248a34.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836578; x=1790441378;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WtfmsscsalVrAJPd73Q0DzcpHT4vVxE/8E3wbnd6UT0=;
 b=EHFNfmHGe7NayOsdCTF8VJxbz9EmdcUgQ/MFvzXbDHF0cBd7Zzy+CzVHpL3hmP15KW
 XZjg6mcwWzAEGxH8A8Rr6RRrMIl6hAzO0P0ZeNz45OyFkMXNqbbTu3EVpP9v0Ch2NDSk
 z8yQ6qT2cpmzv+NroxIhwAXpU1UoVX5SbnW72ibTEdpU93M9oWfhQTRLwZWgmYB02kEa
 dCrva6FgxDWJIa4ZrQBNSX+nYtrSuM+9wB54tlMUr0QMYgjGVRD2cTgbsW8tyUeooEyU
 Fz0+b0M2ztcbiMLoJyLQEGoRKlSjEE9d6Gj+h4lYl1j2otb9f+GgUPjZMWeBW35nBmlM
 rgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836578; x=1790441378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WtfmsscsalVrAJPd73Q0DzcpHT4vVxE/8E3wbnd6UT0=;
 b=cPFG0XkqJukTRj9nL60bwE207cehghNUo8m/hlHe2BsgVGX2rAab6DeVGZtxzdd5my
 t7a9wwfTyFn15hGz3SUGW9Een+AK4eyiLQBqL/AWJXGibz1Pi+GfwRsH0XIrf9OM9kMP
 ImAnwKYx1a7MrrsAXSgeBrG+9DG9GUQuqcKD0kuDXt45NA+zID9ewkeMiJmBgJwJqNGZ
 vfx5aJSN6XJI5yPrkcftxTavF9kg/QNLEkJEXjfDoJV9epZ1pbPVTJMDSVgP1P6bPdwu
 JgLLXhkDhYotNwbRptkWNTnDNOfcCRzPnWFogK5TkHFv4/leg8DjvYefkpqN2L4TwuGD
 bCSA==
X-Gm-Message-State: AFuF++mDAO4q8FyNx0VfrrMgQitHrnQoj/AfDqiAXJJhVQsrHmFhxzA3
 SFhE4IFqTrGb4CkhG488L2uz+ur/1ZX3Nydux28zYFW52atGdIK4nklmiMabevbpiaauNeraI+1
 7kjnHHxw=
X-Gm-Gg: AYBFou19dhbNZXKMMcixjzQ+hzTZA9lGgbRopOgDK02DMkDgT9UhIIbA20iGs47k/7B
 hzJ6uCcjFHDmHPLIpfWLA3k+h7st+MEy1T9kCf8+l7QBGjB9oAU1FyFNlJqldwSHEoN/NLbhRM0
 29rLgkDCF6Z7AYR7HMTqbZR1ZiPW01sTq8nNlQPQ/lygbLNTBlmz0dkIXzvEc9EwGRcMA26z31K
 TYcX9NfAP9zT0JsvqQ22Byp1GDoL4K1vRyEWzJg7VZOaXCejX3pE7h/C3sABUBprkHBJ20FuIZG
 uR3htiF3YoAwNzLNBl3RLfvHvQT++q3gqFNKCmK1d7pVdLmZEe5RSxPzGx7RH1E0tWDkDXgL7ax
 63p7pU0aHv46Je0tk0kd2OpK+EhfV1vVXdQRXPR8K4SVAr442ODoAT6ZwbxZLZWheygCjkn3yjN
 n75pZWUvi5Uwmsv/9uiV4YAkyN8N3M3E4eBQG3w9CIh/8EMAHKQW5qba/hFQ==
X-Received: by 2002:a05:6820:a04:b0:6c0:7620:fccf with SMTP id
 006d021491bc7-6ca9d145308mr5841669eaf.57.1789836578538; 
 Sat, 19 Sep 2026 09:49:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 36/41] bsd-user: Add os-extattr.c with ACL conversion functions
Date: Sat, 19 Sep 2026 10:48:04 -0600
Message-ID: <20260919164810.70151-37-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

Add os-extattr.c with t2h_freebsd_acl, h2t_freebsd_acl, and
t2h_freebsd_acl_type helper functions for ACL operations. Add
os-extattr.c to the build and include os-extattr.h in the
syscall dispatcher.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-extattr.c | 118 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   2 +
 3 files changed, 121 insertions(+)
 create mode 100644 bsd-user/freebsd/os-extattr.c

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index db531604ad..0fc779749d 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -4,6 +4,7 @@ bsd_syscall_nr = custom_target('bsd-syscall-h',
     command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
 
 bsd_user_ss.add(files(
+  'os-extattr.c',
   'os-proc.c',
   'os-socket.c',
   'os-stat.c',
diff --git a/bsd-user/freebsd/os-extattr.c b/bsd-user/freebsd/os-extattr.c
new file mode 100644
index 0000000000..3456157b4d
--- /dev/null
+++ b/bsd-user/freebsd/os-extattr.c
@@ -0,0 +1,118 @@
+/*
+ * FreeBSD extend attributes and ACL conversions
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#ifndef _ACL_PRIVATE
+#define _ACL_PRIVATE
+#endif
+#include <sys/acl.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+/*
+ * FreeBSD ACL conversion.
+ */
+abi_long t2h_freebsd_acl(struct acl *host_acl, abi_ulong target_addr)
+{
+    uint32_t i;
+    struct target_freebsd_acl *target_acl;
+
+    if (!lock_user_struct(VERIFY_READ, target_acl, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_acl->acl_maxcnt, &target_acl->acl_maxcnt);
+    __get_user(host_acl->acl_cnt, &target_acl->acl_cnt);
+
+    if (host_acl->acl_maxcnt > ACL_MAX_ENTRIES ||
+        host_acl->acl_cnt > ACL_MAX_ENTRIES) {
+        unlock_user_struct(target_acl, target_addr, 0);
+        return -TARGET_EINVAL;
+    }
+
+    for (i = 0; i < host_acl->acl_cnt; i++) {
+        __get_user(host_acl->acl_entry[i].ae_tag,
+            &target_acl->acl_entry[i].ae_tag);
+        __get_user(host_acl->acl_entry[i].ae_id,
+            &target_acl->acl_entry[i].ae_id);
+        __get_user(host_acl->acl_entry[i].ae_perm,
+            &target_acl->acl_entry[i].ae_perm);
+        __get_user(host_acl->acl_entry[i].ae_entry_type,
+            &target_acl->acl_entry[i].ae_entry_type);
+        __get_user(host_acl->acl_entry[i].ae_flags,
+            &target_acl->acl_entry[i].ae_flags);
+    }
+
+    unlock_user_struct(target_acl, target_addr, 0);
+    return 0;
+}
+
+abi_long h2t_freebsd_acl(abi_ulong target_addr, struct acl *host_acl)
+{
+    uint32_t i;
+    struct target_freebsd_acl *target_acl;
+
+    if (host_acl->acl_maxcnt > ACL_MAX_ENTRIES ||
+        host_acl->acl_cnt > ACL_MAX_ENTRIES) {
+        return -TARGET_EINVAL;
+    }
+
+    if (!lock_user_struct(VERIFY_WRITE, target_acl, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(host_acl->acl_maxcnt, &target_acl->acl_maxcnt);
+    __put_user(host_acl->acl_cnt, &target_acl->acl_cnt);
+
+    for (i = 0; i < host_acl->acl_cnt; i++) {
+        __put_user(host_acl->acl_entry[i].ae_tag,
+            &target_acl->acl_entry[i].ae_tag);
+        __put_user(host_acl->acl_entry[i].ae_id,
+            &target_acl->acl_entry[i].ae_id);
+        __put_user(host_acl->acl_entry[i].ae_perm,
+            &target_acl->acl_entry[i].ae_perm);
+        __put_user(host_acl->acl_entry[i].ae_entry_type,
+            &target_acl->acl_entry[i].ae_entry_type);
+        __put_user(host_acl->acl_entry[i].ae_flags,
+            &target_acl->acl_entry[i].ae_flags);
+    }
+
+    unlock_user_struct(target_acl, target_addr, 1);
+    return 0;
+}
+
+abi_long t2h_freebsd_acl_type(acl_type_t *host_type, abi_long target_type)
+{
+
+    switch (target_type) {
+    case TARGET_FREEBSD_ACL_TYPE_ACCESS_OLD:
+        *host_type = ACL_TYPE_ACCESS_OLD;
+        break;
+
+    case TARGET_FREEBSD_ACL_TYPE_DEFAULT_OLD:
+        *host_type = ACL_TYPE_DEFAULT_OLD;
+        break;
+
+    case TARGET_FREEBSD_ACL_TYPE_ACCESS:
+        *host_type = ACL_TYPE_ACCESS;
+        break;
+
+    case TARGET_FREEBSD_ACL_TYPE_DEFAULT:
+        *host_type = ACL_TYPE_DEFAULT;
+        break;
+
+    case TARGET_FREEBSD_ACL_TYPE_NFS4:
+        *host_type = ACL_TYPE_NFS4;
+        break;
+
+    default:
+        return -TARGET_EINVAL;
+    }
+    return 0;
+}
+
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 0c729da0ab..f385034a53 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -17,6 +17,7 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#define _ACL_PRIVATE
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/path.h"
@@ -43,6 +44,7 @@
 #include "bsd-socket.h"
 
 /* BSD dependent syscall shims */
+#include "os-extattr.h"
 #include "os-stat.h"
 #include "os-proc.h"
 #include "os-signal.h"
-- 
2.55.0


