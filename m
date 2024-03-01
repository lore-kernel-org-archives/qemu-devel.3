Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA2EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC3K-0006mH-BP; Fri, 01 Mar 2024 18:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1l-0003zg-2o
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:59 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1j-000608-4f
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:52 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6e125818649so1418531a34.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334650; x=1709939450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BedJyRvGRjcK6ipu0C7X+tD3tsp2DJnWnzl/pxkro0=;
 b=mi/ntgh18DhG8dhG9nnmaikT+mQMIyszrexS4Re54hlKOf6W5G0OD2m0fkThFP+Qsg
 Q8lP+Rc7KPopkjunaKJ5uQzvZF20yc3JVPKu5uUcLxLHs9eOE+i6xtl8w3UrQV2o2B4D
 Oyqenz+Vy45XeD8lvxHmCE82Qx7uu8QgoBcs75Uvrcv8l4vpGh12CrBfYY502GkJxgtf
 qY3lIEmdadekh+7BVUrbpfETr1m5uhFk6rUto0oR1QchAf28AX0dXT59RgbpfXIXe467
 qddPSUXHvoo6TtqBCfkA8BE62mHa6OgP+nX8sGPzuYWrNRJZsOmKWoxKmB0FQr4jdX6A
 OYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334650; x=1709939450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BedJyRvGRjcK6ipu0C7X+tD3tsp2DJnWnzl/pxkro0=;
 b=movLj2CR4N1rjARYoBUkVzyzKO488umyIqDW9/qhfezbh1M91Pnn3SDwWF6OWyXU8m
 BFU+KK6i8r9Z9f2IqdKF2YzUCBj7u0jC9HmfhXR0pLHxOsmenhrr/kbkAzFrz15qFczd
 Y5QubOGhmWkseDyaG/vLxMnouT5qvvIzFpulCWb9Yl9IRGVAS4rk5t2mfRPjf/jw2cyp
 4cKbxgTpFEwtXqma9c6IkKDxOMaV2iPxFY7SJLRPfM/Zjp2gbAVCYwnMXu3ix3cBdwzY
 889BWukI4mAcMuZuz+RtV+aH2g8XOmIamE5M0wJO0PEW/A8WBgVKfm8j6ovhWydynv+r
 Iz9A==
X-Gm-Message-State: AOJu0YwXJ55tLWxfxTiDZZWOndW1K8AzMA6a91oE9/d/gdq6GVrNi+yE
 Hm/7YTymviZ/ozh5VPAOkfOikaJDyxZfnXS9C4ARdih8/WD6wyWJphPk1ffj/LJU/5+j/0WtwX+
 t
X-Google-Smtp-Source: AGHT+IGtsIM0fB/Wsn7MjnEWb9eOUmx34kcK3kS/USgpPE881lOPMsQlRHMzTBkdwP9zA/MvJICe4A==
X-Received: by 2002:a05:6830:6dc7:b0:6e4:8776:36a1 with SMTP id
 eb7-20020a0568306dc700b006e4877636a1mr5262963otb.25.1709334650010; 
 Fri, 01 Mar 2024 15:10:50 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH 59/60] linux-user: Rewrite target_shmat
Date: Fri,  1 Mar 2024 13:06:18 -1000
Message-Id: <20240301230619.661008-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Handle combined host and guest alignment requirements.
Handle host and guest page size differences.
Handle SHM_EXEC.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/115
Tested-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 172 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 136 insertions(+), 36 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 82f4026283..4505fd7376 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1236,69 +1236,161 @@ static inline abi_ulong target_shmlba(CPUArchState *cpu_env)
 }
 #endif
 
+#if defined(__arm__) || defined(__mips__) || defined(__sparc__)
+#define HOST_FORCE_SHMLBA 1
+#else
+#define HOST_FORCE_SHMLBA 0
+#endif
+
 abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
                        abi_ulong shmaddr, int shmflg)
 {
     CPUState *cpu = env_cpu(cpu_env);
-    abi_ulong raddr;
     struct shmid_ds shm_info;
     int ret;
-    abi_ulong shmlba;
+    int h_pagesize;
+    int t_shmlba, h_shmlba, m_shmlba;
+    size_t t_len, h_len, m_len;
 
     /* shmat pointers are always untagged */
 
-    /* find out the length of the shared memory segment */
+    /*
+     * Because we can't use host shmat() unless the address is sufficiently
+     * aligned for the host, we'll need to check both.
+     * TODO: Could be fixed with softmmu.
+     */
+    t_shmlba = target_shmlba(cpu_env);
+    h_pagesize = qemu_real_host_page_size();
+    h_shmlba = (HOST_FORCE_SHMLBA ? SHMLBA : h_pagesize);
+    m_shmlba = MAX(t_shmlba, h_shmlba);
+
+    if (shmaddr) {
+        if (shmaddr & (m_shmlba - 1)) {
+            if (shmflg & SHM_RND) {
+                /*
+                 * The guest is allowing the kernel to round the address.
+                 * Assume that the guest is ok with us rounding to the
+                 * host required alignment too.  Anyway if we don't, we'll
+                 * get an error from the kernel.
+                 */
+                shmaddr &= ~(m_shmlba - 1);
+                if (shmaddr == 0 && (shmflg & SHM_REMAP)) {
+                    return -TARGET_EINVAL;
+                }
+            } else {
+                int require = TARGET_PAGE_SIZE;
+#ifdef TARGET_FORCE_SHMLBA
+                require = t_shmlba;
+#endif
+                /*
+                 * Include host required alignment, as otherwise we cannot
+                 * use host shmat at all.
+                 */
+                require = MAX(require, h_shmlba);
+                if (shmaddr & (require - 1)) {
+                    return -TARGET_EINVAL;
+                }
+            }
+        }
+    } else {
+        if (shmflg & SHM_REMAP) {
+            return -TARGET_EINVAL;
+        }
+    }
+    /* All rounding now manually concluded. */
+    shmflg &= ~SHM_RND;
+
+    /* Find out the length of the shared memory segment. */
     ret = get_errno(shmctl(shmid, IPC_STAT, &shm_info));
     if (is_error(ret)) {
         /* can't get length, bail out */
         return ret;
     }
+    t_len = TARGET_PAGE_ALIGN(shm_info.shm_segsz);
+    h_len = ROUND_UP(shm_info.shm_segsz, h_pagesize);
+    m_len = MAX(t_len, h_len);
 
-    shmlba = target_shmlba(cpu_env);
-
-    if (shmaddr & (shmlba - 1)) {
-        if (shmflg & SHM_RND) {
-            shmaddr &= ~(shmlba - 1);
-        } else {
-            return -TARGET_EINVAL;
-        }
-    }
-    if (!guest_range_valid_untagged(shmaddr, shm_info.shm_segsz)) {
+    if (!guest_range_valid_untagged(shmaddr, m_len)) {
         return -TARGET_EINVAL;
     }
 
     WITH_MMAP_LOCK_GUARD() {
-        void *host_raddr;
+        bool mapped = false;
+        void *want, *test;
         abi_ulong last;
 
-        if (shmaddr) {
-            host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
-        } else {
-            abi_ulong mmap_start;
-
-            /* In order to use the host shmat, we need to honor host SHMLBA.  */
-            mmap_start = mmap_find_vma(0, shm_info.shm_segsz,
-                                       MAX(SHMLBA, shmlba));
-
-            if (mmap_start == -1) {
+        if (!shmaddr) {
+            shmaddr = mmap_find_vma(0, m_len, m_shmlba);
+            if (shmaddr == -1) {
                 return -TARGET_ENOMEM;
             }
-            host_raddr = shmat(shmid, g2h_untagged(mmap_start),
-                               shmflg | SHM_REMAP);
+            mapped = !reserved_va;
+        } else if (shmflg & SHM_REMAP) {
+            /*
+             * If host page size > target page size, the host shmat may map
+             * more memory than the guest expects.  Reject a mapping that
+             * would replace memory in the unexpected gap.
+             * TODO: Could be fixed with softmmu.
+             */
+            if (t_len < h_len &&
+                !page_check_range_empty(shmaddr + t_len,
+                                        shmaddr + h_len - 1)) {
+                return -TARGET_EINVAL;
+            }
+        } else {
+            if (!page_check_range_empty(shmaddr, shmaddr + m_len - 1)) {
+                return -TARGET_EINVAL;
+            }
         }
 
-        if (host_raddr == (void *)-1) {
-            return get_errno(-1);
-        }
-        raddr = h2g(host_raddr);
-        last = raddr + shm_info.shm_segsz - 1;
+        /* All placement is now complete. */
+        want = (void *)g2h_untagged(shmaddr);
 
-        page_set_flags(raddr, last,
+        /*
+         * Map anonymous pages across the entire range, then remap with
+         * the shared memory.  This is required for a number of corner
+         * cases for which host and guest page sizes differ.
+         */
+        if (h_len != t_len) {
+            int mmap_p = PROT_READ | (shmflg & SHM_RDONLY ? 0 : PROT_WRITE);
+            int mmap_f = MAP_PRIVATE | MAP_ANONYMOUS
+                       | (reserved_va || (shmflg & SHM_REMAP)
+                          ? MAP_FIXED : MAP_FIXED_NOREPLACE);
+
+            test = mmap(want, m_len, mmap_p, mmap_f, -1, 0);
+            if (unlikely(test != want)) {
+                /* shmat returns EINVAL not EEXIST like mmap. */
+                ret = (test == MAP_FAILED && errno != EEXIST
+                       ? get_errno(-1) : -TARGET_EINVAL);
+                if (mapped) {
+                    do_munmap(want, m_len);
+                }
+                return ret;
+            }
+            mapped = true;
+        }
+
+        if (reserved_va || mapped) {
+            shmflg |= SHM_REMAP;
+        }
+        test = shmat(shmid, want, shmflg);
+        if (test == MAP_FAILED) {
+            ret = get_errno(-1);
+            if (mapped) {
+                do_munmap(want, m_len);
+            }
+            return ret;
+        }
+        assert(test == want);
+
+        last = shmaddr + m_len - 1;
+        page_set_flags(shmaddr, last,
                        PAGE_VALID | PAGE_RESET | PAGE_READ |
-                       (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
+                       (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE) |
+                       (shmflg & SHM_EXEC ? PAGE_EXEC : 0));
 
-        shm_region_rm_complete(raddr, last);
-        shm_region_add(raddr, last);
+        shm_region_rm_complete(shmaddr, last);
+        shm_region_add(shmaddr, last);
     }
 
     /*
@@ -1312,7 +1404,15 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
         tb_flush(cpu);
     }
 
-    return raddr;
+    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
+        FILE *f = qemu_log_trylock();
+        if (f) {
+            fprintf(f, "page layout changed following shmat\n");
+            page_dump(f);
+            qemu_log_unlock(f);
+        }
+    }
+    return shmaddr;
 }
 
 abi_long target_shmdt(abi_ulong shmaddr)
-- 
2.34.1


