Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22786CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxa-0002He-9F; Fri, 15 May 2026 17:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxY-0002Ci-Hu
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:40 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxW-00033S-Jl
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:40 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso313348a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880036; x=1779484836;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Tsh8lm+LqQy4W3ldmlNqx+xWEUkmkQXWSGTTg0z9ek=;
 b=jOMhuu8wOBsiQbEFM8R7bjsVaDHueX/ph0+D60EWKAuDmIkOVDCTOH7gXzIDxnGOEB
 zXTtWmFDz2fBywcnYiZz6V5aP6eymDGGbtnN8H0Pj/N9Ai7WgGlP0jUsB991zKtHYcrn
 hqEDvEg/uJ1TYtteDV0LoWegOoBQiooLZWiRZJX4zNjoPawG2eIn0p862VKmUf9sNqTT
 31zIXA3z80TT3DaPib1bJqC52q74ri4v1oeLi2LymzvpKlGWYbAjibq+qgHp1y/dfBzY
 vA2iEl7+9v4blq3dgD6gDYQQ6X2Bx2jti9ATdFGJfaZK6GEWjEv3PNxfmNxTl8hTVw4V
 eK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880036; x=1779484836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Tsh8lm+LqQy4W3ldmlNqx+xWEUkmkQXWSGTTg0z9ek=;
 b=Lha9WRD75ntn0wA9QTrS8RVWXqJQ89bB2/7eLytPORKkUqgoFhdg7c7UgJp0wGCYrH
 AzDTta6lBx2l8SwbxdPEJXae5SqSoiHPRjWBd6ZDtF1suzhzYAEvDgcyjpYFNlWXJ6A9
 zRD5Q3QzsGJdv3eAugArEXs4TLakS28GEes3zKgb7MCAOHw8zudGKvgEnrBVm0LuLHuR
 OYB7NW60wC5OKCO/ij8cXGPzEFY2VtrCXrDdr6rnhviaTYmRdP2RdfwwVlTQNfHQIu76
 mE0MXYysGSn3wu93A2l8Mh5KALc8jIdff5gTzL7wAwmZPydKdsEQQoIubPP1lP04BaNr
 F8pw==
X-Gm-Message-State: AOJu0Yw2si/j7gBON3j8D7GMlHZwEvVx76hUCmTgjTivPNS1Ur5Sz1qB
 E6r/yQxB7iNvAls5B+I9ozDEFGuA7o0IeYsj40c6u1sV/GcxTxoGq7dP69hKmMZHSdg=
X-Gm-Gg: Acq92OHzzM98IqD50lQ1UHVNcrp5UQ6zTSVLbzQw0kUlSGDMJ11GrxiXWEW1oivd5tO
 dwN82TwSbuNCmjJi5ZbcLvxwO2tsx5Ru3NklN5iYgsNPV1e9z15uyvvWWAcp5efbxtFZUILGG/B
 qD+SQtrVOGR7tSnZirWMy6fu6LCu/y/C9SETiv0UYrDRLrpESQQAN14zMEGgbDhyRdczCu7qyqU
 4RYniqVPg1QhP1OHsT+zLmm0UUeZSty6032qpXksNWNLamWq77M5dLBdZ7971qD8CtJjmpzZDN4
 8Tk0vTvwrk3cS9jNxu9s1J/HVboRqZqj1kAKNyd5KaX0msilKwmx0+Pucjg9oPaLqiXOzgpg/sq
 jmkajuJ8pl8OOqMxgvHAvgRbs2ssuozeLoaZp72geV1Lfie0X6kGkAC+KP7TT1SFqsZm5fQ1qoU
 NkNJ1srfPQyQ==
X-Received: by 2002:a05:6830:3812:b0:7d7:eab6:fb23 with SMTP id
 46e09a7af769-7e4f2bada38mr4107959a34.22.1778880036516; 
 Fri, 15 May 2026 14:20:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:32 -0600
Subject: [PATCH 33/66] bsd-user: Add os-extattr.c with ACL conversion functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-33-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4528; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=6svb8ssm9ozon8n/fFZUWOe2tBLRcZ2f+HXF4WmJ+cE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43lDaGThytNysOLMFbiBEBxNR8yGIGZud9IR
 GYnURYkFwqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5QAKCRBsHNEofbAR
 AFzqEADdDay63IYUAFl/EUg7ic383xZnKohUHsLLA2OkK3jnLJzfPsQvqxpjdupuy7QXa70p6xw
 oov1eVprkyxCFVk5yB83vW39xxGD4c6iCLc/B616gxiDsVVDzcWztIHHNI9YjT3AfuoCBFKJ6VH
 7asmOFPnXAWP9R+SOioO28PCARcaR2BMsTlj1CjnSgbyIn3krV0StID0g/wl/8862gtiZnHQXZv
 rWIAYsvagOnISj+zaLKkQggoWjdGUKebHNM2mJ/IDgllrzFK35CZDNf+CwiOZhgV7fhzFg2qTQU
 znjjKVdNiioqrOSZBBOuFrSMZF9870a6gQWWy06tyMrUJvs0miFqH/Joa8WNUR13KnhFIB1QJHX
 vjy0h6mwowTmV/zE8bcnHM1RF16Po0a/BqqIkuqHgNeUwVb4H8eXVoNpxjpaZtnpm/9SrRBlYeE
 y9oQ3JSJevB2eyxNoby5pT6h+tTNVUFLAQ+c+ndKiNdZyj14gzHvCAidN3mAFqeGH8FnnDDyh6f
 WNJkhal8bQycQ/ST1umC5XECtBgliR+zBhmrRrVqp3g89Ry+cjgiqxS4gxwqPTpWylfXUx8mrS0
 NSdFeBWvZ3yosUxZ9GfdVyl52ge8HrSXLbmcfMo1zljrb9dWuYsyvREiY9GaGpGBBKjj2cnDWF0
 iV/Svug5WimiEgQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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
 bsd-user/freebsd/os-extattr.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   2 +
 2 files changed, 109 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.c b/bsd-user/freebsd/os-extattr.c
new file mode 100644
index 0000000000..a30d513655
--- /dev/null
+++ b/bsd-user/freebsd/os-extattr.c
@@ -0,0 +1,107 @@
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


