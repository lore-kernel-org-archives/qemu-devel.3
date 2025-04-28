Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E25C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IEG-0000Cv-QX; Mon, 28 Apr 2025 02:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBc-0004DZ-JC; Mon, 28 Apr 2025 02:41:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBa-0007D6-76; Mon, 28 Apr 2025 02:41:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223fb0f619dso48344765ad.1; 
 Sun, 27 Apr 2025 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822507; x=1746427307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIVudYKUPWnwo/udQIX/549TgIPCua5eirLH5QCF/V4=;
 b=aVki+0pcJqlk5O7Y1a8GJpToGHFXA8URU/xDHr5UX0Bl/Qv+QrnGTToA3Uzw4lOYNk
 IOsyfGiZiWrnbQklrTgzol+7L0rqcQ4dLWdzHMejrW5yy15HivFcgAKY/ikBgR/apkrD
 R3nLlTKhKRuCEyDv+/GDVj/y7/0b7mtgG83WHgWN1UK87BTgoYuo7W5FBwTtillNStf9
 KohfzUyZwilssXDpiDg120bIXudHi2marus41sXAeoSUPyxYqUVi+6xD4K80o0ww377d
 aKzwlP6PzlWVeZQbzIaM2lf3kO22lI/mVRIQkFivRN0dLUVCWMSSbYghJ/R0cDlvGd2V
 tj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822507; x=1746427307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIVudYKUPWnwo/udQIX/549TgIPCua5eirLH5QCF/V4=;
 b=prAz8XPZBHyIpeqm20gBu3YF22rdLDqV1b/FVRckl/HsEk1zAv1lI1xI/SXgm+zeaV
 7UayRaC7QAbMMJNsb9rVOxuIY/7JirWnS2rQP0fJJAfONHD3Ruk9mtBB09xoOZbfgNDS
 mhUtc+2oZ6vJ11vg3WiaCcslexYRUkpUxW6SJfNQtMQPFn/WYwtzq8vhWeFo5Tmee6FO
 A2IxYPrfcBrA/+GWcwVVlL0u1E3xomfMXRIxpdr9jBXXMx60zbL2g3v2I6jqnCQPk2aD
 IjlLUGzdcC0gdIsWljwjZ4T+zhzI8maLlDWRbQXxFjqnAdt2WdQ9iqI1YPeTA5NCYemU
 AMBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2KwGoWcPm6NKEZcGzp4+XMRx2CdVGFkijs723dS9sMn7ZdUH+2L3sSsunE75B2TvZTVT4BbYxCfZdtg==@nongnu.org,
 AJvYcCVobhcxlf7khB6oTTjxxLMrgTMh6Yy1cM5ENQdmetRzeKGg4gh3k8HKH3/TAv/8l7FmG0fXd0k/9Q==@nongnu.org,
 AJvYcCX/3De8y4JMA/raXbuZnWQpfOLCE2IybSJ7hh3nlgM4P5esvVNaZELZ+l8E6+PQOIxKJOJXq46b4cDfJA==@nongnu.org,
 AJvYcCXjDo2C7494OqCDPvIh/3RQC5GEmVhfhXcRuPzQON0tgn9jIosuQG4rlvbhsMKXQY/9rQ2lCGTKFwg=@nongnu.org
X-Gm-Message-State: AOJu0YwlJnBpBlxNQtKCitVALeB/UKBDPyk1TIGnwUYSi8/vnrr+aWXX
 xp5mNUdDfsJGU19YeQfNqu/HZhPwMsQ3Hcahzq5xEJ9oH5txBEpDSclE33ke
X-Gm-Gg: ASbGncsRCzUC+gx/LzFN+2hD+b5TD6xPUtgRBvv+Ah2FX8DjM9COIUHiulS1BmUlDtI
 1L5ZCdVyjtZx6lwIZ48DBJLB8J0EIA5DrebQ01VFiy+uJL3MkmQFGwRrClv3l3jGwmdNNtNrPSP
 DfPGgoNXKiTaIqh46DJ2/iLWAy5s56WCCU6X9S7k7GJjQhlQoe9X0ohydULYSUxK4Q0/8SCZrqg
 t/20prz1ZkeNf/fgmJZHn9kKqBVGjl5XL4hOSxJ98yd3w3bV4ClbLyO0eJPLyVxp0QV5hiyhzdW
 iSRqjMmY6lI/9BF+sOPevljMLlH/0B+MQpY2EmhBsQKgDZES
X-Google-Smtp-Source: AGHT+IFFpA0cHAOM2LORiF9JZwDGmmEbA50T1A4Al2CL1NiPxrn+CBXQHN6+80OSgOkBZRoXa7q63A==
X-Received: by 2002:a17:903:187:b0:224:c47:cbd with SMTP id
 d9443c01a7336-22dbf157b05mr158566435ad.0.1745822506956; 
 Sun, 27 Apr 2025 23:41:46 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:41:46 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 16/20] util: exclude mmap-alloc.c from compilation target
 on Emscripten
Date: Mon, 28 Apr 2025 15:39:05 +0900
Message-ID: <76834f933ee4f14eeb5289d21c59d306886e58e9.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Emscripten does not support partial unmapping of mmapped memory
regions[1]. This limitation prevents correct implementation of qemu_ram_mmap
and qemu_ram_munmap, which rely on partial unmap behavior.

As a workaround, this commit excludes mmap-alloc.c from the Emscripten
build. Instead, for Emscripten build, this modifies qemu_anon_ram_alloc to
use qemu_memalign in place of qemu_ram_mmap, and disable memory backends
that rely on mmap, such as memory-backend-file and memory-backend-shm.

[1] https://github.com/emscripten-core/emscripten/blob/d4a74336f23214bf3304d9eb0d03966786b30a36/system/lib/libc/emscripten_mmap.c#L61

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 backends/meson.build |  6 ++++--
 system/memory.c      |  2 +-
 system/physmem.c     |  9 +++++----
 util/meson.build     |  4 +++-
 util/oslib-posix.c   | 28 ++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/backends/meson.build b/backends/meson.build
index da714b93d1..9b88d22685 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -12,8 +12,10 @@ system_ss.add([files(
 
 if host_os != 'windows'
   system_ss.add(files('rng-random.c'))
-  system_ss.add(files('hostmem-file.c'))
-  system_ss.add([files('hostmem-shm.c'), rt])
+  if host_os != 'emscripten'
+    system_ss.add(files('hostmem-file.c'))
+    system_ss.add([files('hostmem-shm.c'), rt])
+  endif
 endif
 if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
diff --git a/system/memory.c b/system/memory.c
index 7e2f16f4e9..f76b895950 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1627,7 +1627,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
     return true;
 }
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 bool memory_region_init_ram_from_file(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
diff --git a/system/physmem.c b/system/physmem.c
index 16cf557d1a..4a7a2e5e12 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1243,7 +1243,7 @@ long qemu_maxrampagesize(void)
     return pagesize;
 }
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 static int64_t get_file_size(int fd)
 {
     int64_t size;
@@ -1978,7 +1978,7 @@ out_free:
     }
 }
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
                                  qemu_ram_resize_cb resized, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
@@ -2158,7 +2158,8 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
-#ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */
+    /* ignore RAM_SHARED for Windows and emscripten*/
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
     if (!host) {
         if (!share_flags && current_machine->aux_ram_share) {
             ram_flags |= RAM_SHARED;
@@ -2255,7 +2256,7 @@ static void reclaim_ramblock(RAMBlock *block)
         ;
     } else if (xen_enabled()) {
         xen_invalidate_map_cache_entry(block->host);
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(EMSCRIPTEN)
     } else if (block->fd >= 0) {
         qemu_ram_munmap(block->fd, block->host, block->max_length);
         close(block->fd);
diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..e5cd327e27 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -11,7 +11,9 @@ if host_os != 'windows'
   endif
   util_ss.add(files('compatfd.c'))
   util_ss.add(files('event_notifier-posix.c'))
-  util_ss.add(files('mmap-alloc.c'))
+  if host_os != 'emscripten'
+    util_ss.add(files('mmap-alloc.c'))
+  endif
   freebsd_dep = []
   if host_os == 'freebsd'
     freebsd_dep = util
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index a697c602c6..4ff577e5de 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -58,6 +58,7 @@
 #include <lwp.h>
 #endif
 
+#include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"
 
 #define MAX_MEM_PREALLOC_THREAD_COUNT 16
@@ -210,11 +211,21 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared,
     const uint32_t qemu_map_flags = (shared ? QEMU_MAP_SHARED : 0) |
                                     (noreserve ? QEMU_MAP_NORESERVE : 0);
     size_t align = QEMU_VMALLOC_ALIGN;
+#ifndef EMSCRIPTEN
     void *ptr = qemu_ram_mmap(-1, size, align, qemu_map_flags, 0);
 
     if (ptr == MAP_FAILED) {
         return NULL;
     }
+#else
+    /*
+     * qemu_ram_mmap is not implemented for Emscripten. Use qemu_memalign
+     * for the anonymous allocation. noreserve is ignored as there is no swap
+     * space on Emscripten, and shared is ignored as there is no other
+     * processes on Emscripten.
+     */
+    void *ptr = qemu_memalign(align, size);
+#endif
 
     if (alignment) {
         *alignment = align;
@@ -227,7 +238,16 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared,
 void qemu_anon_ram_free(void *ptr, size_t size)
 {
     trace_qemu_anon_ram_free(ptr, size);
+#ifndef EMSCRIPTEN
     qemu_ram_munmap(-1, ptr, size);
+#else
+    /*
+     * qemu_ram_munmap is not implemented for Emscripten and qemu_memalign
+     * was used for the allocation. Use the corresponding freeing function
+     * here.
+     */
+    qemu_vfree(ptr);
+#endif
 }
 
 void qemu_socket_set_block(int fd)
@@ -588,7 +608,15 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
 {
     static gsize initialized;
     int ret;
+#ifndef EMSCRIPTEN
     size_t hpagesize = qemu_fd_getpagesize(fd);
+#else
+    /*
+     * mmap-alloc.c is excluded from Emscripten build, so qemu_fd_getpagesize
+     * is unavailable. Fallback to the lower level implementation.
+     */
+    size_t hpagesize = qemu_real_host_page_size();
+#endif
     size_t numpages = DIV_ROUND_UP(sz, hpagesize);
     bool use_madv_populate_write;
     struct sigaction act;
-- 
2.43.0


