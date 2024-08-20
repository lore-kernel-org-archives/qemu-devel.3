Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDAEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 05:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgH7Q-0004PP-7P; Tue, 20 Aug 2024 01:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgH7A-0004LU-FU
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:09:05 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgH77-0007q0-HT
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:09:04 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2704d461058so1541068fac.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724130540; x=1724735340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/V+/zK9f6DneOT0stD1zbRm+cUo+xuW5miljh1QM8Q=;
 b=dvC/ETQRSGZ4XlRWPF3Cla6m8ZCxk8XrFRzuq2N2AttOy0JLds608Oaz2L82Qo2FrL
 gHf8O3UN3E870TlgrrKAiKx1whELzkGg1O8TOtnLf6Q4WYkV2fzZK4hEGXX6zSM3LWHc
 JPh30gs+VP+Dqt0UbPMV4Hkx0566NUSruOZZXaZ3gmN8US/A38jLmzo9dpUzBj8UiVct
 rX7lxuRly2sN1GBX786zTloH8ijGMrhrj2dLefBR5+otajQfKgpmNv1GQwHvPVeY3jQx
 tlLDrYZE9ChbB0cvO09+1EECWBffyPcvCPnRLdsPMZClonP/tecNSrSR0LZmYkRO4qyx
 XTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724130540; x=1724735340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/V+/zK9f6DneOT0stD1zbRm+cUo+xuW5miljh1QM8Q=;
 b=UxfAfLOi23QUXubUn5LtDAhnNMyYguvDDEEHiCENZheBKQYVoeBcTd7VPSUxhbtZfJ
 sw1yhk6QZYGQqNLT+YP1xnWIaaQR60aeGcwBxGEGDex2lCmeZj2FNDiiJcQfCi1RseDz
 8kQMs83vYHDSVwCkffmifzSddyATO4jX8nMenMDfvfKaingOqf9YaA/xRL9Va0wAW6iT
 S/pZ3KVswOZNlSWeYxNv3YRMg+I6oPj3OPgTXsf0h6ZbYDOqiDL6gmt40sa1w31QNaJN
 6Qt8AHLlUB18i/raIOR2Jjh5Xi8NMFRXliB2PPYH10/MZshi9/dNorcsZHwB4fhi436t
 pfiQ==
X-Gm-Message-State: AOJu0YxmSmm08f6Rg0CLYopCagimQW/VPY6ZuvmkgxjhGZJJggpCH3f/
 QjOlG/wj4BFRnlf3+cKuGhHvzzaHB0nIpNSxFIfJ1d0o6jsNi//v57tWM6oMMev8Y9QzWbGGSyF
 96CY=
X-Google-Smtp-Source: AGHT+IGApbUlEljK6DxsVx9YsxklWq8nSaeVXvdWqH4JlCF9r/yuHl2DRYhQvp1RZMA7VQO098D3tg==
X-Received: by 2002:a05:6870:d607:b0:261:1eb4:dd8e with SMTP id
 586e51a60fabf-2701c3450e3mr15351560fac.2.1724130539755; 
 Mon, 19 Aug 2024 22:08:59 -0700 (PDT)
Received: from stoup.. ([203.30.3.188]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af416fbsm7382814b3a.207.2024.08.19.22.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 22:08:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, philmd@linaro.org, imp@bsdimp.com,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/2] linux-user: Handle short reads in mmap_h_gt_g
Date: Tue, 20 Aug 2024 15:08:47 +1000
Message-ID: <20240820050848.165253-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820050848.165253-1-richard.henderson@linaro.org>
References: <20240820050848.165253-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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


