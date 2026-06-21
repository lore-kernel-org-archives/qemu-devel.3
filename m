Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2505CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9he-0003CM-I2; Sun, 21 Jun 2026 00:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9ha-00039b-7Q
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:35 -0400
Received: from mail-oa1-x42.google.com ([2001:4860:4864:20::42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hY-0005OD-CC
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:33 -0400
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-4471c2ae049so1065646fac.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015750; x=1782620550;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5qimRSElObv1x5nSEz2bAFqjoLHlEU4oNntYB0m/4Tg=;
 b=CYOVfUoTxSQuafpp9QGlE79rNZwuhh9Bpm0s1D+hXM1zFIaGmOriyE2vHfeCnqLg3C
 3XaO6daHJe/YCtN/8O9wm40RmQlrfbLDk+lUGK/x+70roKREU94gJ5hO4HZuEOrvWUeU
 m+hzFN1fvB/pxsAtI89YenDIoRt2u674bFj3IMPkzu6fuqhgN+JSkxKZeXKTZfbJxxja
 peyLBR6jyfEn4zfbFTxeU8ZL/INYVVoPgYdOuI5YNCBeai9dw/VUdIIplLWgM9ZZgLA7
 anE8eO/R5/SErovIeIledRmB9aBn/k/4TSP0wXDe+UquLcLt6QlnEL01M/xDDO95Htvm
 FITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015750; x=1782620550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5qimRSElObv1x5nSEz2bAFqjoLHlEU4oNntYB0m/4Tg=;
 b=r9dKCoEj50S+Fl08+vxCMWotAWd03Gqtd7Q92uWl/NRsaj1YrcKUIf1Bgs+IfXiimK
 u1QknKRfJ1wsJ4K8P08tu47Ptss/1CwSbCjmAU+Ve/sdWBzIsd+8lz9JoP3kHA44Z5V8
 LJZBRm3remuBjdZBXjpBK8TWRZYEV9cNpQhbj1ty7FtOzElpV38AkvrxmWN0nWG2zvay
 WKhgwTV8rRY8GGY0dvJMv8Nk1/eKJOWucj6KGsjaKvKsNBsSVpkt74AZ0hFaAs+ws6No
 WZWS590PUyGmf+RFjuWipsZExRkCXDPZqS4kJ0/09X3/k1p0lXZTGzQSbUnShsb8paq8
 nL5Q==
X-Gm-Message-State: AOJu0YwbHUcuKuXhv8mw99r/5j0k19WrCiGmRn+wQLhtoLMj4zR2YZU6
 Q9fY8Tyc7O4ow3tRK+yok/tG365lv//TSM9vgc9ewAvwJOvzbfVBAVAvM028AlayT9Y=
X-Gm-Gg: AfdE7ckMWPtJDbFCX2E1Zs5+9k/5Sma27x2PrSTR/0I3uAXMJsAgI+LjQuB3/DxZYx3
 JTY5jzyPaEN4KWTQAQAlL1kSRiPqnP4exCz5z3rFGB5TQX4MdL1PeWK8OFBLst/8dFVdTxTKiBU
 1jzwDQWpimYoMz01Ot78aVmh13ILMe0L86Gb3xg2gbQ3HlLB7P4QM/9qQTHE5YSdnWaOYtKh8RC
 nZgYudvXCbX1JOcrhKbUDgIylkjNHlTcyq2yQNopmopOjdD2IrrG+q8YcgPLilseMKpnm21DqZK
 TBYlnMU62Sg4rPXfw+MGnx7ANj1cGgYAb1afSQsjNSKRoJHpnMwpsco6AW9OknMGNIJM4z6ll0p
 jR+siA6RJo1UfVApINBim5aUeOju6+OT15L3KFQUMrHz1zGIyoZLWZyDOQUHA2pKg1ejsoSWEw8
 7ulhnGm14l7A==
X-Received: by 2002:a05:6820:210a:b0:69e:98c0:4bc9 with SMTP id
 006d021491bc7-6a0eb329e4dmr4141512eaf.19.1782015750569; 
 Sat, 20 Jun 2026 21:22:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:21 -0600
Subject: [PATCH v3 34/40] bsd-user: Add os-extattr.c with ACL conversion
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-34-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5368; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ZIr7Yj40Tc7tAzlzobPhYQrM/hycg5Rm+eugHAV6nCs=;
 b=kA0DAAoBbBzRKH2wEQAByyZiAGo3ZoHID3EJbpp2jdOtJ4EwOIri4CUnLIPealmifT/jpgSjr
 4kCMwQAAQoAHRYhBCA1+JSwCqPPfM3ht2wc0Sh9sBEABQJqN2aBAAoJEGwc0Sh9sBEAS9kP/RSn
 1hzCK6/CByxmJq4ssTDSodX9ERP2ak7oaMBZenixA5aKR/SNGPQGlxmeXODIX4/OyQM03xlPV7n
 z6ZGYJp3B8CIXscBhmJypVUy+z3Iym/ekWDeuFIsstmJz1KzGZk6+zNN2WjuItjvxnupfVE+SYo
 BLT772OHeTE2jhVdihTDXYDNGEFc7AoA3jjXjGx3YiajXhFF6f5UflZtqRczVKjbF7Cmzlry4Mu
 23BNbefD+83uDXBeu8kuY9AdI3/HBjWyfl3Ox3wQbLmRqosd1kEBgZ81HVhkbtgUo8dFnbOqfif
 DPgPspOwE/EmU+nIym75qTsE3N33KSzTpAEjIYdiJjnW8yl9bezyL1857buf9mWlLMlUIhM5XFJ
 D0vz5WD9FrLc6Knm2AzqkCSx/E1DAKKDX0z190gtSOLHrn+JzdOhkCNSqjsVN3CsAYjFJhMS0cH
 y4utncdATugz++R2COPnO+utpgvsLw/yDfjBWyx0iXDLphJWyn/2YTkaVi7PA5y2OqDKifRraPq
 7ynCDlKfcuZxpBruMdeC9aPZ0IfzdYF3ERAenpsD2eqrVQ+q6sWWV9yG0UXVX41wtSemuTbApoi
 5winY9ZaPVIjOLP9K6Ie9TAdiB8bs75mePZXj1BnKbHoBERmNyAs/Qb3Z+yqsN0TmqwzUq7gVct
 9xfXT
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::42;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x42.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-extattr.c | 118 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   2 +
 3 files changed, 121 insertions(+)

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
2.52.0


