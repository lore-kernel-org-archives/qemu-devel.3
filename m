Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A9D68BF4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 08:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW9nI-0003sb-LK; Thu, 18 Dec 2025 03:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vW9nG-0003rT-47
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:55:30 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vW9nE-000571-I5
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:55:29 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso462695b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766048127; x=1766652927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBlyXOWb/KMcPwA7yvb0AbdJKytBhHprjnVY2HHlTkI=;
 b=mEoKnPKzLr/q9cWjl/S0KtOtutg/ih3i/av17N2LTSkVq4Z+1A+tMd+YDBMUNPzcd0
 e39vqcHGsljHNPNLVJnGJerXDfeSI2IzGF9ZY7/VTfzy4gLDBXtcVAIpir5YLXW1P35F
 21uVdp+ES0DkK9imQcGQvfiOn0IJ367ehBZH9I4rZml/aoSwkgHMiXjM7OVC+KI74IC4
 Rz/GWa2gZ5wxYS0F0/g4DILSSdXFeZ8uoshuWY+dFIUZiSH7ZC4dmRUwaSWWBKU6eF3H
 uGddDxUBUfykqmM86+tSs4rwXq3dYnxx20XXIiGtp/Fn+GIDmNRv3dZliRZIR993Jdwf
 lMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766048127; x=1766652927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBlyXOWb/KMcPwA7yvb0AbdJKytBhHprjnVY2HHlTkI=;
 b=VXrFXWYrgM3bsW415zxcSafegDe++rJJVoucMp/tfnCj1OzUT2OyvVgBW9L/Gsrdxg
 fS3BkqelriCRqcDVS2z0PAiI+HrdvzWVnNxVaDGENRVTHUS8MBpI3ZFoG5hFDeAJHhFI
 YjLj3Xv4BJpy2/SrcOXol3pXyP5NxZ+dKQOkJqj5k7vm6drgJDgFu6awT1QJceAvhEO9
 iuYnM6kKd7cBLt4JbXf3f8NI2XGAFFXtj1C5co7XjfAuqvAWwyewCN/yripfFNZgsGko
 boI2G5PwdGmOYk3rPb6yr8hybHIzHSyz+HbbPpP8VXj29ppvrbZuZjIbm7cAHmnpvrjK
 hRXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnOURPSDRwyiRkRcU7AkOeWlPyrY8IU/NJds62xMsMPquYdILRjJCzUT+3gT0+hQgx0PIsg/S5N6xS@nongnu.org
X-Gm-Message-State: AOJu0Yz41SM1f+K1NTRzwA2MVZryasgG24LzL+2LwET5eZuSPKzDbA4m
 9TiUQL4W/I95BN6tjrOepsQ1mzMbUDLyNJre2MltauPHVIwiltS2FyZW
X-Gm-Gg: AY/fxX5fo1oL2nGbYVZnli7/aeJG6S3v4ylU6104ekHYa7iYKdSAA4rg+19cwEJJIbO
 CJMbHEBhg+Mv5abmD6iApN9G863qX6gATAKFQGf8XpcYaKWwmg3X6TaxhzDsHNcZFAbVDbX9484
 l25rQw+b/+J+klDjNcmlinYTNZTz1Ongj1HMn0gbtba05k5B51y777ES+qOukyeSrXsI+byoxfV
 iM0UdmI0I7+l+aNq8V0oKBLOMHq3Hi8B3bI/grIAezQNnllyIUkN1o9kdDqrJ9G/Jgsr7svrGFh
 eE7L3IsgcmRnxcxYHUVIBQ5yp8L+JcDclkn6tNbx+HtAg/4WqkqelDGdztZakGJfqDz/G8caHy4
 pmD6FX5F0cyGU/MvjJoN3ntobg2fP4+HCPzD/f8ZucOQCz82XUP/g2jQQ8Y6ohNH6bI4zkX6QIO
 PPvWLsksVOyll/O5+RqgmYR3g=
X-Google-Smtp-Source: AGHT+IHbT9YOQdX3ThNpiyotAQ3FTMdosOz+gS66I7NiTVvEUG03SGviKHw3v/Vpa0AnOqMlOcJe/w==
X-Received: by 2002:aa7:81c5:0:b0:7e8:450c:61b8 with SMTP id
 d2e1a72fcca58-7f67156b7ffmr13729050b3a.40.1766048126992; 
 Thu, 18 Dec 2025 00:55:26 -0800 (PST)
Received: from localhost.localdomain ([116.86.160.247])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7fe12128ea4sm1926218b3a.27.2025.12.18.00.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 00:55:26 -0800 (PST)
From: phind.uet@gmail.com
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] util: Move qemu_ftruncate64 from block/file-win32.c to
 oslib-win32.c
Date: Thu, 18 Dec 2025 16:54:46 +0800
Message-ID: <20251218085446.462827-3-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218085446.462827-1-phind.uet@gmail.com>
References: <20251218085446.462827-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=phind.uet@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nguyen Dinh Phi <phind.uet@gmail.com>

qemu_ftruncate64() is a general-purpose utility function that may be
used outside of the block layer. Move it to util/oslib-win32.c where
other Windows-specific utility functions reside.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 block/file-win32.c | 32 --------------------------------
 util/oslib-win32.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index af9aea631c..8a44853389 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -170,38 +170,6 @@ static BlockAIOCB *paio_submit(BlockDriverState *bs, HANDLE hfile,
     return thread_pool_submit_aio(aio_worker, acb, cb, opaque);
 }
 
-int qemu_ftruncate64(int fd, int64_t length)
-{
-    LARGE_INTEGER li;
-    DWORD dw;
-    LONG high;
-    HANDLE h;
-    BOOL res;
-
-    if ((GetVersion() & 0x80000000UL) && (length >> 32) != 0)
-        return -1;
-
-    h = (HANDLE)_get_osfhandle(fd);
-
-    /* get current position, ftruncate do not change position */
-    li.HighPart = 0;
-    li.LowPart = SetFilePointer (h, 0, &li.HighPart, FILE_CURRENT);
-    if (li.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
-        return -1;
-    }
-
-    high = length >> 32;
-    dw = SetFilePointer(h, (DWORD) length, &high, FILE_BEGIN);
-    if (dw == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
-        return -1;
-    }
-    res = SetEndOfFile(h);
-
-    /* back to old position */
-    SetFilePointer(h, li.LowPart, &li.HighPart, FILE_BEGIN);
-    return res ? 0 : -1;
-}
-
 static int set_sparse(int fd)
 {
     DWORD returned;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 839b8a4170..766c602172 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -899,3 +899,37 @@ int qemu_shm_alloc(size_t size, Error **errp)
     error_setg(errp, "Shared memory is not supported.");
     return -1;
 }
+
+int qemu_ftruncate64(int fd, int64_t length)
+{
+    LARGE_INTEGER li;
+    DWORD dw;
+    LONG high;
+    HANDLE h;
+    BOOL res;
+
+    if ((GetVersion()&0x80000000UL) && (length >> 32) != 0) {
+        return -1;
+    }
+
+    h = (HANDLE)_get_osfhandle(fd);
+
+    /* get current position, ftruncate do not change position */
+    li.HighPart = 0;
+    li.LowPart = SetFilePointer (h, 0, &li.HighPart, FILE_CURRENT);
+    if (li.LowPart == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
+        return -1;
+    }
+
+    high = length >> 32;
+    dw = SetFilePointer(h, (DWORD) length, &high, FILE_BEGIN);
+    if (dw == INVALID_SET_FILE_POINTER && GetLastError() != NO_ERROR) {
+        return -1;
+    }
+    res = SetEndOfFile(h);
+
+    /* back to old position */
+    SetFilePointer(h, li.LowPart, &li.HighPart, FILE_BEGIN);
+    return res ? 0 : -1;
+}
+
-- 
2.43.0


