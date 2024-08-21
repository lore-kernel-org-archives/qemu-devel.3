Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EB5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgb30-0000in-Sb; Tue, 20 Aug 2024 22:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2z-0000Yd-21
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2v-0006DX-WE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7c3ebba7fbbso4784544a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724207159; x=1724811959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVcCgltg45eJ8LECAIKCmNL12zJBy0OXmSR3imxiWNo=;
 b=evdP1HR6rlLBMhqk2yOACd+DmV4AsUz1kPdFQbvIglXi/LFRTSDaVY4bDI1I7cyf9k
 W2eY97VhaEeims1gftMuYUYEO/pJ7q29Hv95OgyvPwlChFp14JOWOfImIqpqE//ymmfn
 aZUvBPfHWonKPH1U99Pj1CQqpZogXhmYYf/BkEat/dvgQuH9LxN1/rkJlGZ9XfYq3AU+
 VNd9y/JQAUXu/HSHCH2nI+kMPGbW32X7yJYFEhYdEbn/F9GI5SDA4EUlVcQsg7ZBD75b
 eQoG1+i8qQWEroCEBzSnAzqMRljDTaA1+gZKzl6yBAvr7kp9i7RvE3JjtJIHweKSZFvg
 hJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724207159; x=1724811959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVcCgltg45eJ8LECAIKCmNL12zJBy0OXmSR3imxiWNo=;
 b=u3/TrkC+OPjojhKMDKhh/UUqiM3zZS61AlwMunDaJe/3sdnJBwc6gcdS6VZEbttM98
 F5J+yaV4AwpahHD6+/lkYS77y0U1T7XzF+WrAajgwMZUCQYNhc+0/MvPdpOFH2mz9/UY
 rLhyD7CQ1pNyDTwMdWVcCIoyhFYp5A8Rd6BT7UcY8osQXPROrOW0tDSfCkV+F6fhnESP
 Vz+X8imNsYmSMPXuPfm9T0iJqAi+TWg1WlVbLYZui45/W2Jdf36kCaq7BqB+jo4SWuLr
 5PZwiWCEECqX5IxI6PkBMEMeWHudUX8v8vgWT73mhvWjcbrp+mTTduPDhOTPVveoh2LX
 y/Zg==
X-Gm-Message-State: AOJu0Yw88uC/s9F15hWCrsYDSQjn+gcsRqbWfofOW4y6zuI6hL3XdaeU
 UWRF0h74OqMeiKNQPt8V4ebXttlXzGKZJVNEKBewtzdOFVSWvxH9eSTW+b/mjaHo2R6A+Ksxit2
 4XIc=
X-Google-Smtp-Source: AGHT+IHvJWj7ZeU3TEX8jUo74HytAI/ZtpH/4KCUGpP9VgWJNcBS7Lj0OIScHIKn76qE5ClgqVXM9w==
X-Received: by 2002:a05:6a21:920b:b0:1be:c5d9:5a19 with SMTP id
 adf61e73a8af0-1cad7fb1d21mr1970420637.24.1724207158960; 
 Tue, 20 Aug 2024 19:25:58 -0700 (PDT)
Received: from stoup.. ([203.56.140.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1888esm9210774b3a.149.2024.08.20.19.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 19:25:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] bsd-user: Handle short reads in mmap_h_gt_g
Date: Wed, 21 Aug 2024 12:25:45 +1000
Message-ID: <20240821022548.421745-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821022548.421745-1-richard.henderson@linaro.org>
References: <20240821022548.421745-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In particular, if an image has a large bss, we can hit EOF before reading
all bytes of the mapping.  Mirror the similar change to linux-user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240820050848.165253-3-richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index f3a4f1712d..775e905960 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -128,6 +128,40 @@ error:
     return ret;
 }
 
+/*
+ * Perform a pread on behalf of target_mmap.  We can reach EOF, we can be
+ * interrupted by signals, and in general there's no good error return path.
+ * If @zero, zero the rest of the block at EOF.
+ * Return true on success.
+ */
+static bool mmap_pread(int fd, void *p, size_t len, off_t offset, bool zero)
+{
+    while (1) {
+        ssize_t r = pread(fd, p, len, offset);
+
+        if (likely(r == len)) {
+            /* Complete */
+            return true;
+        }
+        if (r == 0) {
+            /* EOF */
+            if (zero) {
+                memset(p, 0, len);
+            }
+            return true;
+        }
+        if (r > 0) {
+            /* Short read */
+            p += r;
+            len -= r;
+            offset += r;
+        } else if (errno != EINTR) {
+            /* Error */
+            return false;
+        }
+    }
+}
+
 /*
  * map an incomplete host page
  *
@@ -190,7 +224,7 @@ static int mmap_frag(abi_ulong real_start,
             mprotect(host_start, qemu_host_page_size, prot1 | PROT_WRITE);
 
         /* read the corresponding file data */
-        if (pread(fd, g2h_untagged(start), end - start, offset) == -1) {
+        if (!mmap_pread(fd, g2h_untagged(start), end - start, offset, true)) {
             return -1;
         }
 
@@ -565,7 +599,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                                   -1, 0);
             if (retaddr == -1)
                 goto fail;
-            if (pread(fd, g2h_untagged(start), len, offset) == -1) {
+            if (!mmap_pread(fd, g2h_untagged(start), len, offset, false)) {
                 goto fail;
             }
             if (!(prot & PROT_WRITE)) {
-- 
2.43.0


