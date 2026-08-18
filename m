Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89759C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThc-0004sr-AE; Tue, 18 Aug 2026 19:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTha-0004gG-Om
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:42 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThY-0005KA-Pj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:42 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so219436fac.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097519; x=1787702319;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dIz2VXi+F/15e1S0MVPD1bNQL3JNhpxIrt4slg72Msw=;
 b=mpc1EwtEsTOcW6/8bOKzAn2WBCOJC2L/Sc8WeoGshmSIe1/Ol1UtYtOBbEqsebSdmr
 mYN8esf2vbUM1CussR+WIFV20WG5srMyLGZdxg62nWh9E8QyJDGbZOZElTJmKwFFeJQX
 IrApszYw5CHJPS3yb2kXRfXgvyG+YwwVDa3vz104MQZGloBDKX+de85IiVYMCkPQQLMc
 4R/gnfKcxoTjJjk6IQ47jVBV5FW5Pllov91mNUvOBEDVYbCaNJ15lekd1wrbeiAd+4Qy
 yDt6N0Cqmn0iO1BJsCHuzcQFznAQISl2/S4BUJJo2+wG8IQJ0ERpd5yWEtBtgh/WDeZT
 xmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097519; x=1787702319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dIz2VXi+F/15e1S0MVPD1bNQL3JNhpxIrt4slg72Msw=;
 b=RLFpW592VTaZ0vPu5cLMn+m+ZA7cGFMhOTqQUgcX0IJHrQ7sgHPs7xmhn+jG3/nRwP
 YWgC1SxsEXLNDvbyw7Pw8DDUIcfE5A8330fNjG/Ch6NM128HUK7LGbkAFFjDoZmu+zcj
 lqLDZc1hkZN+JaXWoBsibl6Hei8BWZcCKk6T0SADxDjKdmqmsZS/PqeJr30SY0QVqsak
 T3HEAS+U7FOuXO8VeAgMtKI0fI3svivKgLBKLyZdz88Nc1JvJUHH0kcZp+zv3zoqduO7
 RHPP1hFaUR4oZ9AVYdoKrr+oJ+486MQ5KrHAUYbUy8AiaS7kWpwoP8sRAGhELUMFNps0
 tDww==
X-Gm-Message-State: AOJu0YxtEFjPhfpl8D8x8/7g4sbZiH04bBgt3gk3wUbithMKMl7PK+9r
 YhCbphCt/bcrE/M7iqpb/eqhw+SF4PdUy889e934JgOsP8ovJqANG+m8kTUs4Wim9jI=
X-Gm-Gg: AR+sD11gui4AQKRMlh7bZCpugFpyRxl9hStrvT9qmxoU4VDAh2Hhb1XvIhVZd6ZWNv2
 DrU57/UQ+n/p/EgFofeX5mYFCvabiv/ZHZ+soHCp/Nv+cUYrMO83X+LV1kV63H1ZR2K5AITjq2f
 QYsiHMQaPkupwu54HNf8buzCNINl++6tyDttWjj2ervP4zzdj2qv3PL1w1bm40G6kp98EGEfqWT
 0m3L4n6fHBvT8g14zTKnwMBzO4JBcq/3skX24JARl+2Jk2hk4sZJbZYB0NihZpC4OvUcSLtzR/q
 eqey4oYD2rYVk6JXvLusBIi/kwLTmvo9yyLQ3znNFqerU3ds6i7eJI34TYgShctIBOPKyW3FRC4
 +EKLUXYtDTnUOGcUiTD81298pgz3l1IFe6Ly4/2OG0/iAJhGrFNwB3EK7eR2sX7r0jWIKczOhof
 T9lldssUYvH6Dp17Ml2GtRLFq4sXtqTjIM6MHpbtfT4Xt8l+g=
X-Received: by 2002:a05:6808:c293:b0:495:da89:c578 with SMTP id
 5614622812f47-4b2bc9af497mr335321b6e.9.1787097519434; 
 Tue, 18 Aug 2026 16:58:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:28 -0600
Subject: [PATCH v4 35/40] bsd-user: Add os-extattr.c with ACL conversion
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-35-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5428; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8WTKkkmH+/YIqQ+D8OENQR/1fAIivn67BrWNZ/nK3dk=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFXs2ZcCB7hVkB0XlcDsqkjRsHILukvTRXpM
 m6vH/c7/6qJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxVxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDzNxAAhkUbKOnt5jpY7reTU4SG4eUiQGzxST9
 BZ4RZqqa9Bi6cCFKrZzkm53g4v2KWkceN0XaEu3dIdBGK7AvyPu8CWzGckLTc0Y3AB/X+CWGNro
 Blo7oYFRccj159H2/4gJNM/vLvX5ToOljmg+FgBvAAmCZ3muEGyaaM0TzdL1Sp7A+NvJ7xzECTh
 95ejN9WiNmDxZmEhe+qgKi8nPd6bvxj2EpaPefnNWZMMN+TGftSB+PS2RwdWDjVKokdF5eaThQv
 NOYmF+CkzoElXsVWZNYVbBbNPu/IGN+k/wyiAzSFs1YMgtRxYzVqj5ruDwT/dsXH33BSCaLPg5g
 Xuj50c94StT8AMO1iSyTGkcnNn0lV5yub4A1SCVjtjgvGACkFOYhsOrUnqW1dAuc23yVRTQ/KTM
 XHaZyLmLho4a4M8ijv8+z77gvT7MPGzxe6yQ7j5t092g6xmfHk0OP7aY5MlDcTo0rMxtgRijBN9
 WPwv2LREgYfogJmu+0xPmoPpV9f6it0zKFdWZdXYf8sKo8EvrMToLgbdJdm5ppVklvd7R2S8k23
 MaAejmZU4KbSlMiOqkIeZEV8AapyLmiCDKbe4y9XxiEz7IfepFinj1BbBkeEypAb74aMPtPsD+0
 owKLM/0kHfkR1dZHqPxgeSEUCv7hriZoXzJ26On8UqPeXNqfx5yY=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::32;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x32.google.com
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
2.55.0


