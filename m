Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D79ACD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vq-0000jN-Mg; Mon, 18 May 2026 17:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vl-0000Xb-7B
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:29 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vj-0000eH-BS
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:28 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479eb8bcacbso1903192b6e.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139706; x=1779744506;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6BsiMsWnWcz0ZD7fdHEqgpW91pDlHqlwEAlWvdbmtTQ=;
 b=WmDtAY7tmUFTiroWwModz6DYW0dFLV+k7mq07MsQQgHDn08SzENgsTWZr7Bmld2wyd
 jpectl/PfTpOuZy6P4nRxi/TffJ2mM6FBazewSrmXbNJ+PVAzGO2jnkHchl0rWARUupP
 ArsjkfJCU6nZtINF0lDKeIto+rpmhEarrsalOk7WEflvYWNkb7iK+23KYvFsaX/3IcnW
 F13vr1H4pK/N6N2pNZ6GLn0kivJnXNNTHgUC6LzkY5t5lGUlBnJGMalQUu2Vqhv7EncR
 79XpMDe9EmosDMJguw3CPZb9vWgZhsHzFAS4ZCtZdT6bZ+TlL5F7qjpSAIieVjpG4o+o
 fq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139706; x=1779744506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6BsiMsWnWcz0ZD7fdHEqgpW91pDlHqlwEAlWvdbmtTQ=;
 b=fsnJ+hV/71BiCemWFosqzY0CJDxO4i1dfz8HXrfI+d42ZQvam12d+ueN7zN8s8nSNu
 rlQdxaYFIZOhBexPp9fZ/SyFL6biDIqXrOS61D1tdKYoM/UpyFnIGCxS3xDVCWVz2kwc
 MmflZo0/Y+IyLJpsgsJNJ+E7GUFN/DfZCLINo2YKXEo7Imtgcnuku2Qp3Lw2wSrBoLi0
 Epbbg+yXgL+yuash7z/lK8EKAMtp5z1iDKKQFHWDVieKiMUd9TdXNwCxoazGz4SS5z1z
 JqIAK0T3ZT1nBynPy+jMo9oJ4g1wuF6oM3L7tPqel7KNZpOT+kWncv/UAQxrItLX3OjY
 6G+w==
X-Gm-Message-State: AOJu0YxK5vT0QOZ8vROOJnjB49z1QFMAXC83l2rcD2Ee2GPRv+md1zBo
 C8PaNgnhARYa0TuVj+oY4MphlBE3AJhzhVxjIHWC/LOeT1qjZ/1CfBoaMohhC5awhH6lYpeJQKu
 UksHsbGM=
X-Gm-Gg: Acq92OFdbFITeHgRlkenbvzCSJpIKsfAbkNtmTjypRNNikbPhX0etJxWmENqeUNdxU4
 q/k0rLEVpjV75TlGIfPMl40aJtEFZkd6auQsGJxLzgyKNvYrkv2gQgleH/YQagKC7CZMx4Ub0H+
 i87EpxJhe3DRy8aEQlatmd10GggUFVzf4/oxg7x7xSpQi8PsyuUqFPckArckDTQTiyHRKPn0Pxn
 XlPkI5HOJFHjkYwO+Mos7IA6iQR6VCX+K4G/r4Xz31pzXQLl5hHfUnz5bbDKd3O7rHyQLxE9Ujb
 vhSzU7v5IlbuFKfMFjcUmOzom2z0piaRnS+Be9haDq3FExsBXsKiOfBfXTKZjQU01Z5zzX6yLC4
 41jC1YMXfTMk9rhV3N0OaIzcihrRIq3o92EGx6ybMJsKMjT07vcbrqosRAynMeqWkp7E5jwM/ll
 8XdYm2HKkPpA==
X-Received: by 2002:a05:6808:5282:b0:479:d16e:9629 with SMTP id
 5614622812f47-482e56ea6f3mr11772616b6e.21.1779139706088; 
 Mon, 18 May 2026 14:28:26 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:25 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:51 -0600
Subject: [PATCH v2 33/37] bsd-user: Add os-extattr.c with ACL conversion
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-33-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4778; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xbLf/gX+EPcfRk77GR+uzvmVg3QKmNFciyS2O2arL5c=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RJnG5tw0B8UWEUi+rhwIn9dlBatkzMZaTiW
 VZYohXh/S2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESQAKCRBsHNEofbAR
 AFN2EAClTyeyrDUqrC+BdEgRlQpLsIE9BiGMWzlMb6atthr9VBvskFUnXs20kYGJAzckG9IvLKZ
 FBj+ofCgX8GYK4vknn5BC67o9DC0BElhy/iARIiq5BoNBktgpPDAn0ZF39DDBtIsqgkXMrbdHgC
 WwPU8MQFY1d+/QkRZfMVc4fzwbN43MRrkUpmnioY0o+1fo0XfP/hfFgXUjakMZ66LGoJOaUDYB+
 upe0986XgGu4tbolKtzOv0Q6A6fIiB3B6u8pg4DenyDzaKhOSRd7lvOQ4BPEIK4FRq6CNWk2x+1
 6pNNpkqtNTfozIekL2aXGKNaKNtwx4rtqe1MTSqacVKcLlunnpw3yokTDiNyCjMaWvztpEgz7TZ
 MOXdd/wp0jeeT9IwsB4iJk7iDiGEddyymeglu9C2alcVeVpBXxwwMKHWpyuSZtZOB9DuNrC8A+5
 WFFzxnTDJbqBZP45O5BZ/TI4a4JImpW4RzUSIitckY/JdOHe84z8BMi+h8uKyfTkRne5mEWOCGa
 bckBlb/WBH7GrbP4nMjQruMQI5hzLusHHWh0bEVcCLNShwCjYir6VLkEt9Tr3ZHdKQrtXYltAk7
 LhOFfFtzI0YZf7+QHeGVB9Zot6iHHS6xWOVb5PWX6ePBrdxswpyNwP6Hs2tr5XGnF1PkwONygrb
 eQxR6v5E1oMT4KA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22a.google.com
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
 bsd-user/freebsd/os-extattr.c | 116 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   2 +
 2 files changed, 118 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.c b/bsd-user/freebsd/os-extattr.c
new file mode 100644
index 0000000000..0f0c7123dd
--- /dev/null
+++ b/bsd-user/freebsd/os-extattr.c
@@ -0,0 +1,116 @@
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
+    if (host_acl->acl_maxcnt > ACL_MAX_ENTRIES) {
+        unlock_user_struct(target_acl, target_addr, 0);
+        return -TARGET_EINVAL;
+    }
+
+    for (i = 0; i < host_acl->acl_maxcnt; i++) {
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
+    if (host_acl->acl_maxcnt > ACL_MAX_ENTRIES) {
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
+    for (i = 0; i < host_acl->acl_maxcnt; i++) {
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


