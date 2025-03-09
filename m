Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A70C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpB-0005AQ-Ew; Sun, 09 Mar 2025 13:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKp9-0005AD-FR
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKp7-0004oY-Rn
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so19917165e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542744; x=1742147544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I3NR+5rxXyS1Unu3/N17nFNE/6t0ATq2jAlqmEXa0yw=;
 b=PQ465ES6JSXBfszIkQO0eQXhPJ5WlEUy9oClOs3Jrh+sAQlNuX75YQkbGcHULmMThx
 nCzHiaxQGj9cJVP5IRs1128QMVgic/WpnVEHcuWFtlp5V65WI6ly0eTvc2Rg6hZcJMKe
 drPoshelWqNluUidD5URnnryrVIn0Sc8govlyiseds41MyXJWvfP2aPNbzPS525CHRvh
 h1rYwYi/5uzNvOV2bK67ktSh/htsjWfeniUjq6cimA/DfQ6IRoPtInYjQOZWj7Ls94Hy
 wlGGdwXGeJDYLqicetuBdcw+EcToFA3XjJiFJGg5c661SJnK3zMlput4msGdqgazjKbd
 EXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542744; x=1742147544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I3NR+5rxXyS1Unu3/N17nFNE/6t0ATq2jAlqmEXa0yw=;
 b=OaJaCfwvfk1jxfmwlt0XQu01bMc8SB53JtXFn7BEOFJE3wLyaJL9dZDmGMo+vaoMdu
 Lw18SsM0Mvn6la5V60Hlk+sQ9u/pF01//BnKC3Aj6bQzsP9CejS9WkPB1bLhW6k6F/on
 UVzpq+5xZovCSMYdOx9+WgAlRHDKksEf0GNjPk6doEb763sj9nKPTmOt9Dd9sXqDusTH
 TCX+easu8nG5Vkm+RLcR7X31eaWO7cNdkys2iSOokJinQ4m0UDFewANq6evJAK0Re2S9
 mtvmX2x7pegZxa7fn4jk5BWn+ocOQT2kfTWIjqG6K2OJWThJSwH2Jk80J1P53b4yT9Mn
 F8CQ==
X-Gm-Message-State: AOJu0YyBV3XxWPqyIsHICYeFBHKJ6aC5AAyI6vwUYGE0bjjfXHo+uWe1
 m8Bhr2QqvRO+SYBcZw9h1KUCUy2pJoWA1I48DuSYUmIJKDzxRKnS1NBukjojJ2GKCMzy0cKh8He
 hB10=
X-Gm-Gg: ASbGncuO8PihviY2QH5EOwxt1sxEH9/gZPiB/r92Ju3pEHUCKdJBDqcGk5xFreZECTG
 M2l8FKj1v/4coh/n8DgKT3yJcXmNN00vtJktWN9wZX2iSivtEw/GqNvmgvnRNATMl0AAroRXaRs
 WR7ENlIOJHiI9ohEnEypaYTfeLDcq3+d4HKt1bDIlabdUHDzE9uH2LOCiVkEdzI8mrKKkV4kzxm
 EU2XLe9Rqd6tSylxqQZHUUY/SboGXSPSFCEIZAll+FG0ZtSvFz8y5/nD/wYUdKzGVfzEH6YBnin
 i7ZYfpttOzx2QREEL9DfdStTy7+V6NGU05TPl2J85hzGdJw7JjqP92XDSnzdDOprmSlWRXu23nQ
 Yv39mLsW1k7QimEVcpdPw2CetEiNgbQ==
X-Google-Smtp-Source: AGHT+IFO1/oUuVaYLKaejKW45XLEgrXqtWD100cEYoy2qq3dChUlbidwJXH/D/Ek//Nzd/t5knxe4A==
X-Received: by 2002:a05:600c:3054:b0:43b:c270:49ae with SMTP id
 5b1f17b1804b1-43ce4a4adf9mr37286325e9.0.1741542743696; 
 Sun, 09 Mar 2025 10:52:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf1b36d14sm27582095e9.37.2025.03.09.10.52.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/38] bsd-user: Propagate alignment argument to mmap_find_vma()
Date: Sun,  9 Mar 2025 18:51:32 +0100
Message-ID: <20250309175207.43828-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Propagate the alignment to mmap_find_vma(), effectively
embedding mmap_find_vma_aligned() within mmap_find_vma().

Add a comment in do_bsd_shmat() to clarify alignment above
page size is not required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20250308122842.76377-3-philmd@linaro.org>
---
 bsd-user/bsd-mem.h |  4 +++-
 bsd-user/qemu.h    |  2 +-
 bsd-user/mmap.c    | 10 ++--------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f5ec0de24ca..90ca0e33775 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -370,9 +370,11 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
         if (shmaddr) {
             host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
         } else {
+            abi_ulong alignment;
             abi_ulong mmap_start;
 
-            mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
+            alignment = 0; /* alignment above page size not required */
+            mmap_start = mmap_find_vma(0, shm_info.shm_segsz, alignment);
 
             if (mmap_start == -1) {
                 return -TARGET_ENOMEM;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4e97c796318..0b3bd65b180 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -242,7 +242,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment);
 void mmap_reserve(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
 void TSA_NO_TSA mmap_fork_end(int child);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index dfa6e728ab5..3f0df79c375 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -275,8 +275,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
  * It must be called with mmap_lock() held.
  * Return -1 if error.
  */
-static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
-                                       abi_ulong alignment)
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment)
 {
     void *ptr, *prev;
     abi_ulong addr;
@@ -395,11 +394,6 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
     }
 }
 
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
-{
-    return mmap_find_vma_aligned(start, size, 0);
-}
-
 /* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, off_t offset)
@@ -494,7 +488,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
         alignment = (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT;
-        start = mmap_find_vma_aligned(real_start, host_len, alignment);
+        start = mmap_find_vma(real_start, host_len, alignment);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
-- 
2.47.1


