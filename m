Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7041BC531DF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgb30-0000eO-A9; Tue, 20 Aug 2024 22:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2y-0000VH-Ac
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:04 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2v-0006DM-Uc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:03 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7093c94435bso2381032a34.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 19:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724207157; x=1724811957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S39pbsi04lxxgffqB3S31UEXKo2fS7pxTQUq/De0mMM=;
 b=Ff83HT2+bhzCkN8PtwxeEw6vJ26ve01tJoWokh4hhWdjQ1UwFvds7mJSdpB+AVW1bh
 Z+APVO99bbSGnYnlcVxG9rv2MT/1p2k8xbuaOyWP8F/EVybAhlMa6shEvuBUbGLs3WUf
 zWvU3b5gsXwPNbIKLPObzQP5pUsmM1NGpUATORAqFWxP+M7JF6dhVFIaidYSAcgWz3YL
 Ooe6YBvL7j9ignw/TEzBDRT9n44xO1PYX+jN2AZmC7nq73SiE9ZRPMWPhFlpa7yS3pPQ
 1tyx5REKwVvqQneq7elKdJhFjaeAj0Fuebat/lbEzf7NFt8zE9DlagV52fkyGIzMjjOj
 GTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724207157; x=1724811957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S39pbsi04lxxgffqB3S31UEXKo2fS7pxTQUq/De0mMM=;
 b=ehxB/ypFojd7qNpBmlyQq+J+xvfoEcsDX8YvQEYc8xYQPcJw2/7NMCFHf63SrAEN08
 Zyhhu37w1b1NGzWh3yW0Mw1aypkzDIN8olG/bHF773f3EXsT/YjoHEZT8Z9BLtF5sSzm
 Dtoiwy5wKBAIiYaV+8i3+8X9hpSAP7Sd/4uJyq/k3y1CPxduRl2k3Kj006vxHDNcRGhU
 9KhyCb82uFipLMcjR3fFi4b3TZ8Fp9mSBTZozNmp8MddJH+Al+64aAy+flR1PlBIQoGt
 3J7kWB2xB3q5iNuzktq1xAoIJdHHYR74k7t8qdvUbxUdu7InLHua3lMPFejTvMSbPt2X
 WXfQ==
X-Gm-Message-State: AOJu0YyAfSFZOwCr+XskAz+g66w/Xku7AeEQYJBSZAGtnZJmu71rOWQx
 hZ9EVVkGkOXlGrkcq+Xixb1st13qf1wbdb2AzMhe8nvK0yfrWCrPuBBd30W6v/kn6uM/RaBIlB+
 0HiM=
X-Google-Smtp-Source: AGHT+IFUZosUPjiuiQ4dDhrvSmPTEOjvr/XEeQxubZowfYq4JejiOT2H++HI9lL7R6H1OLficxKBpg==
X-Received: by 2002:a05:6870:82a2:b0:258:5143:a21a with SMTP id
 586e51a60fabf-2737ef0023bmr845403fac.13.1724207156792; 
 Tue, 20 Aug 2024 19:25:56 -0700 (PDT)
Received: from stoup.. ([203.56.140.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1888esm9210774b3a.149.2024.08.20.19.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 19:25:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] linux-user: Handle short reads in mmap_h_gt_g
Date: Wed, 21 Aug 2024 12:25:44 +1000
Message-ID: <20240821022548.421745-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821022548.421745-1-richard.henderson@linaro.org>
References: <20240821022548.421745-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In particular, if an image has a large bss, we can hit
EOF before reading all host_len bytes of the mapping.

Create a helper, mmap_pread to handle the job for both
the larger block in mmap_h_gt_g itself, as well as the
smaller block in mmap_frag.

Cc: qemu-stable@nongnu.org
Fixes: eb5027ac618 ("linux-user: Split out mmap_h_gt_g")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2504
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240820050848.165253-2-richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mmap.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6418e811f6..e4bf5d5f39 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -283,6 +283,40 @@ static int do_munmap(void *addr, size_t len)
     return munmap(addr, len);
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
  * Map an incomplete host page.
  *
@@ -357,10 +391,9 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
     /* Read or zero the new guest pages. */
     if (flags & MAP_ANONYMOUS) {
         memset(g2h_untagged(start), 0, last - start + 1);
-    } else {
-        if (pread(fd, g2h_untagged(start), last - start + 1, offset) == -1) {
-            return false;
-        }
+    } else if (!mmap_pread(fd, g2h_untagged(start), last - start + 1,
+                           offset, true)) {
+        return false;
     }
 
     /* Put final protection */
@@ -853,8 +886,7 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
     }
 
     if (misaligned_offset) {
-        /* TODO: The read could be short. */
-        if (pread(fd, p, host_len, offset + real_start - start) != host_len) {
+        if (!mmap_pread(fd, p, host_len, offset + real_start - start, false)) {
             do_munmap(p, host_len);
             return -1;
         }
-- 
2.43.0


