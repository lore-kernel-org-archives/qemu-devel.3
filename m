Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB3CC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLqN-0002d7-Tm; Thu, 22 Feb 2024 22:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqK-0002cR-QM
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:21 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqI-0000cq-Vp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:20 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso411345b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708657397; x=1709262197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sktbWKa1binb241q0r6ct6YkNzdPk613k2Pdqrs3XY=;
 b=WPC2MgZmL++cV5nYo1BOWU+lOWnIuzL+7gYBaqtMQqRBwe1Ycn5FUITv76VUaAUN7J
 R9BGClzmoYQTTsDCg9OMjP0rq0nKD9jCOZXCkmdRSPwGD0RflZ43ABWpR2Y9Q3XMgjsh
 4Gck01YhqbHHsiYYyCLo4S/coJfvScaFCAUc0C0XlRaPz1nkHWX8XVmTu807l2+I/0Eu
 urhoorMtdRzplBRcbPDpI1v/MDTDGLy9JL8rG81ndJWhxIowx5LLMOwBfiL0vB8RchP6
 Qj7AND2zlHlN0/V8ap6/H2JAnMu0gZOG5KEpkyBeMkk5BXLkbzxPgAbRJmXquSDShHoB
 pTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657397; x=1709262197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sktbWKa1binb241q0r6ct6YkNzdPk613k2Pdqrs3XY=;
 b=IsQjTQqAGenV7mLVPm6oGk9pblLgOSwbBcAlviZzI5SguOFj+dghxUQ3SCN/1uP2a4
 pCq2+nmYIS+yVgfQiRBRqLq80otUvck0rkzBoFxBenlSd9AwWvdAnG3CFBobgT+LdpuW
 IsQm51VAfg50jDXOak7mtVVwxHF/QA8zrC4Axtm9QCy3qAJQ2RndvyntEBG+cLINmgO3
 x1CiBwCRgT2VOnBt0KQhLA7lk806Mi+21nA3YGVb25LRkaDpODUewsJBQDkHh7izqvDl
 MtP8nfUbWaPF/hmCgZET84OpssVQAxllis+qGJYwLW/kI1Ovichl7iUgR7jPnVpppSpu
 iu7w==
X-Gm-Message-State: AOJu0YyesQWAM/kI2HdG4I1c87LDVaY1AEywPv9H7MEXlKevXgj0mo21
 9f97h+2fco4pnPm5pifypdnIthDvxSWOt9WZYdO3/FZjnkN5YjSDRQbOPbGYMpNtjXcQHbBo7+h
 m
X-Google-Smtp-Source: AGHT+IHTflDvkUzGMyqQfgieheaBVY+CPzniQDOQ9PGNgSEtei/QtAqc469kvKQWZsSiZZX5HPD/NA==
X-Received: by 2002:a05:6a00:1807:b0:6e4:8b07:1060 with SMTP id
 y7-20020a056a00180700b006e48b071060mr6500541pfa.14.1708657397435; 
 Thu, 22 Feb 2024 19:03:17 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a056a000d6600b006e31f615af6sm11594159pfv.17.2024.02.22.19.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:03:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, iii@linux.ibm.com, richard.purdie@linuxfoundation.org,
 mjt@tls.msk.ru
Subject: [PATCH 3/3] linux-user: Rewrite target_shmat
Date: Thu, 22 Feb 2024 17:03:09 -1000
Message-Id: <20240223030309.458451-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223030309.458451-1-richard.henderson@linaro.org>
References: <20240223030309.458451-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 146 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 110 insertions(+), 36 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 82f4026283..29421cfab0 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1236,69 +1236,143 @@ static inline abi_ulong target_shmlba(CPUArchState *cpu_env)
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
+        void *host_raddr, *test;
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
+        } else if (!(shmflg & SHM_REMAP)) {
+            if (!page_check_range_empty(shmaddr, shmaddr + m_len - 1)) {
+                return -TARGET_EINVAL;
+            }
+        } else if (t_len < h_len) {
+            /*
+             * ??? If the host page size is larger than host page size,
+             * then we might be mapping more pages than the guest expects.
+             * TODO: Could be fixed with softmmu.
+             */
+            if (!page_check_range_empty(shmaddr + t_len, shmaddr + h_len - 1)) {
+                return -TARGET_EINVAL;
+            }
         }
 
-        if (host_raddr == (void *)-1) {
-            return get_errno(-1);
-        }
-        raddr = h2g(host_raddr);
-        last = raddr + shm_info.shm_segsz - 1;
+        /* All placement now manually completed. */
+        host_raddr = (void *)g2h_untagged(shmaddr);
+        test = shmat(shmid, host_raddr, shmflg | SHM_REMAP);
 
-        page_set_flags(raddr, last,
+        if (test != MAP_FAILED && t_len > h_len) {
+            /*
+             * The target page size is larger than the host page size.
+             * Fill in the final target page with anonymous memory.
+             */
+            void *t2 = mmap(host_raddr + h_len, t_len - h_len,
+                           PROT_READ | (shmflg & SHM_RDONLY ? 0 : PROT_WRITE),
+                           MAP_PRIVATE | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
+            if (t2 == MAP_FAILED) {
+                test = MAP_FAILED;
+            }
+        }
+
+        if (test == MAP_FAILED) {
+            ret = get_errno(-1);
+            if (!(shmflg & SHM_REMAP)) {
+                do_munmap(host_raddr, m_len);
+            }
+            return ret;
+        }
+
+        assert(test == host_raddr);
+        last = shmaddr + m_len - 1;
+
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
@@ -1312,7 +1386,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
         tb_flush(cpu);
     }
 
-    return raddr;
+    return shmaddr;
 }
 
 abi_long target_shmdt(abi_ulong shmaddr)
-- 
2.34.1


