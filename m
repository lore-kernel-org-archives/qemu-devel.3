Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C6ACD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqE-0003vS-3l; Thu, 18 Jun 2026 15:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq2-0003sS-Bg
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIpv-0007rR-Lk
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso10252405ad.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812532; x=1782417332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwD+09xFgdMoZuAKSWmp8VsuyM0k0eLL68nRKXSEm94=;
 b=d2j33pXZnz/E5qpRJvUXHofxzv89lz1gPWfKdIt60EghP09Dsw6te2slyCmgYpjpXr
 eRBjDyUDUnIfcgdH8VuI7+zVIFNKc3I04b63wX1aTsP+YY0OT7L/BgCKDOaSNBaCNqRR
 OPrt1sBF8wRUR3SayITI0OL0ciERf+DcvRThmxUerpJlQ4Ms8qio1D3mRE9OPpHA1VD/
 MUyz+ydV5IfWzbpnIfZ+k0LkMkqCjjkXnvJlP0z75aMeMqUwSQ4afkQHkX3Nof3O4MMr
 cChiKoUZL0pdRHOfucVSsnl4hMsLnJBkOdv6vpNgehJgF5RC8wYZPI4qiaA5FVpcsZUB
 JusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812532; x=1782417332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZwD+09xFgdMoZuAKSWmp8VsuyM0k0eLL68nRKXSEm94=;
 b=qxkFWG7KIKrWp7UICTN8n8dUOcYCJ33ud9qcn8Wf9rPYVhtedpBQ2+LT1f7HFfPV0k
 52XYha0NmlHS5S0Nwh5xd3kf8L/Zii9i3USUnp3+hNbXmqjKaNqGpqIkLqiaOfZTKrP3
 y7+hzR+M2BdENqwgc7Mi4GzWVDreXjosS5j4XrEzUHY1wQ6Kb3h5zlftwzASGi9aiPkP
 X4mrublvtWW0czisBVfxqzJiRpDRKFmTa4qpo4kp09XS4cAmr228XffFQ9bVQeLqmMai
 7RWEQOi7IFfwr9FC6vHuqpyn0BVHe59+azLui/jOSrrocqaW85yNjJmM+782OTaadsUi
 2RHg==
X-Gm-Message-State: AOJu0Yz3H3Ucl96iFF66OsPCtzTmjh6gWZmsxBSXkKkU1l0EGGTQhh4W
 IAkEZA2rsKRGFZ9a08byuF4DRxn8jbve+xgxOLm9V22gM9j3qsO52GwyI7m5DQQZjJkY70BcWTa
 0xcpe
X-Gm-Gg: AfdE7cnZoZ0iUJ8co0d8F4QnrdFzq0TFN9poRQM2mYLkkSdm0zNwASs7nSj606N+Fsx
 yuPcRFzKI+14nEvg3gvp68dbcYSl/6P5+lvGcmoxNnKoRuSRl/FsTBniAX9T8ySGndQwkjauTW2
 dxf+VO0NhvKchMlH6VaKyR/ReoeS/LRBop5bHxZhlo1sjcTHwuc4GPQ+T1KXXal+2qVVjhRUvHk
 PuRl+xL25S0LgC6xQuqfv9KZwzXjnbmtzv63oDOzW+DoVan1r83QeB8FLUDv41JqlcSyePOi7sB
 vLhoy0+JJ8VXQ8JQIIHeBgGNY+r08qirTIyngfsiT2YcKo8wSe8tNADHy6j1bM39/28WKRxH7Xj
 pjEqmvGg7DPNZzxzqrjIWKA2Pmsw0LIubPTljmv/N6WUoLI/7NR5MZjXKT5wVHd6gEDt+6XKnBX
 zFjU0zJz8uYGMW7k0OpfNrkYwEiR+/4MTTlbfCehjH5aohxxaSWQ==
X-Received: by 2002:a17:903:2347:b0:2c6:9358:3ad5 with SMTP id
 d9443c01a7336-2c718fc45fbmr6291135ad.17.1781812532446; 
 Thu, 18 Jun 2026 12:55:32 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v3 03/13] linux-user: Drop hiaddr out-of-range check in
 probe_guest_base
Date: Thu, 18 Jun 2026 12:55:09 -0700
Message-ID: <20260618195520.589907-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since dropping 32-bit host support, a guest address cannot
overflow a host pointer.  This means guest_hiaddr is unused
for relocatable images, so don't pass guest_hiaddr as size.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c  | 26 +++++++-------------------
 linux-user/flatload.c |  3 +--
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b32abd569f..960847fda7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1092,20 +1092,11 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
     uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
-    if (reserved_va) {
-        if (guest_hiaddr > reserved_va) {
-            error_report("%s: requires more than reserved virtual "
-                         "address space (0x%" PRIx64 " > 0x%lx)",
-                         image_name, (uint64_t)guest_hiaddr, reserved_va);
-            exit(EXIT_FAILURE);
-        }
-    } else {
-        if (guest_hiaddr != (uintptr_t)guest_hiaddr) {
-            error_report("%s: requires more virtual address space "
-                         "than the host can provide (0x%" PRIx64 ")",
-                         image_name, (uint64_t)guest_hiaddr + 1);
-            exit(EXIT_FAILURE);
-        }
+    if (reserved_va && guest_hiaddr > reserved_va) {
+        error_report("%s: requires more than reserved virtual "
+                     "address space (0x%" PRIx64 " > 0x%lx)",
+                     image_name, (uint64_t)guest_hiaddr, reserved_va);
+        exit(EXIT_FAILURE);
     }
 
     if (have_guest_base) {
@@ -1373,11 +1364,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              */
             probe_guest_base(image_name, range.lo, range.hi);
         } else {
-            /*
-             * The binary is dynamic, but we still need to
-             * select guest_base.  In this case we pass a size.
-             */
-            probe_guest_base(image_name, 0, range.hi - range.lo);
+            /* The binary is dynamic; we still need to select guest_base. */
+            probe_guest_base(image_name, 0, 0);
 
             /*
              * Avoid collision with the loader by providing a different
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 4beb3ed1b9..8abdd2aef2 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -261,8 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     /*
      * Allocate the address space.
      */
-    probe_guest_base(bprm->filename, 0,
-                     text_len + data_len + extra + indx_len - 1);
+    probe_guest_base(bprm->filename, 0, 0);
 
     /*
      * there are a couple of cases here,  the separate code/data
-- 
2.43.0


