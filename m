Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5992C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSd-0006wY-Qo; Wed, 24 Apr 2024 18:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSb-0006va-RG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSZ-0006eh-VH
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f074520c8cso493304b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999086; x=1714603886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIVpHaDvexJpR4v3VPoHT+wrjfi6nDMX3Dvh/TsygHY=;
 b=r7kdj/pF1Y578nrjgawPvkKy0b/YSFTML2E9ZPBeF0flZklGUWYYRMpnh7jMpGMuGs
 xsKSdDQKVfbnRKmRSYoQw/NEryLFwRIJodynj+KPZDcq9jKOai2s6p/FztFLmutNbrmB
 PBuqXCoMe/RPr2A6vjIoWaqP42mCxNLhs6idSi2wlJf7N9To7NRziuDMT1CtH3xbGN7H
 x7hiuuf2vVKgod1IN5WLlPhIeNAwIuwlzqjQbQCY0fGxWftZQZgV3XKXfSL+NCm3g2SQ
 j+sDEPovn2AoZmHEXmpp4Muo8U4I598h60TxOYNkflRwL+dEF+yVywXAQsB7xVw+M6pV
 m0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999086; x=1714603886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIVpHaDvexJpR4v3VPoHT+wrjfi6nDMX3Dvh/TsygHY=;
 b=cXkKaUNPXXKWIppX4hs0qzIbq+jB+SYP16D1pEx0GX3ptYZ049cjy/czZegdwPiHbF
 G8xD6Swivkaa5ewToxdxicQWXKW3u2GmTqQka/P5CUNwQKbPj9Do24PGYDdCJF+ng5S+
 nWgY7uPhohVH/ARjv5rChnFkNFFBQvrUTiCw755hnTo9sKokdzLxu6jkn43sTWEdxFs3
 uEYGHIgiag24lf3gCztZAmToA0j3aSpZOXrrNVB0OOg9G+DkSIGBLh5iHG+IBZ6G1+lj
 Ch6msWOUfLamCh2rvBpeJsMjGzFbaCDzJ5eQNwTwD5L3w0sq7LLND9ccl1GW89FLThfM
 WKLw==
X-Gm-Message-State: AOJu0Yw2V6popKh6LafQdM81fRO4w62XC53+MBKowPYdlP7c/Mkp+Reu
 DQDgEMv5FQvKiLON87RZZ5CeIiUUq4i0qLF6/4x1trXIQrqEdz+jI3SMjMBJXIsS05sN6VaOcbA
 F
X-Google-Smtp-Source: AGHT+IE5TOAgqILpleFGV0tPIY646V491UQ39WHGQ+PTWHXeI4ir64SsS/enJkV4YPu6GcAz897mjw==
X-Received: by 2002:a05:6a21:1798:b0:1aa:5b05:7925 with SMTP id
 nx24-20020a056a21179800b001aa5b057925mr4339527pzb.4.1713999086497; 
 Wed, 24 Apr 2024 15:51:26 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 1/9] meson: Make DEBUG_REMAP a meson option
Date: Wed, 24 Apr 2024 15:51:15 -0700
Message-Id: <20240424225123.929152-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently DEBUG_REMAP is a macro that needs to be manually #defined to
be activated, which makes it hard to have separate build directories
dedicated to testing the code with it. Promote it to a meson option.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240312002402.14344-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build                   | 4 ++++
 bsd-user/qemu.h               | 6 ++----
 linux-user/qemu.h             | 4 +---
 linux-user/uaccess.c          | 4 ++--
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 6 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 95cee7046e..553b940999 100644
--- a/meson.build
+++ b/meson.build
@@ -2350,6 +2350,7 @@ config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
 config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
+config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
 config_host_data.set('CONFIG_LIVE_BLOCK_MIGRATION', get_option('live_block_migration').allowed())
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
@@ -4277,6 +4278,9 @@ if config_all_accel.has_key('CONFIG_TCG')
   endif
   summary_info += {'TCG plugins':       get_option('plugins')}
   summary_info += {'TCG debug enabled': get_option('debug_tcg')}
+  if have_linux_user or have_bsd_user
+    summary_info += {'syscall buffer debugging support': get_option('debug_remap')}
+  endif
 endif
 summary_info += {'target list':       ' '.join(target_dirs)}
 if have_system
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 1b0a591d2d..8629f0dcde 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -22,8 +22,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 
-#undef DEBUG_REMAP
-
 #include "exec/user/abitypes.h"
 
 extern char **environ;
@@ -437,7 +435,7 @@ static inline void *lock_user(int type, abi_ulong guest_addr, long len,
     if (!access_ok(type, guest_addr, len)) {
         return NULL;
     }
-#ifdef DEBUG_REMAP
+#ifdef CONFIG_DEBUG_REMAP
     {
         void *addr;
         addr = g_malloc(len);
@@ -461,7 +459,7 @@ static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
                                long len)
 {
 
-#ifdef DEBUG_REMAP
+#ifdef CONFIG_DEBUG_REMAP
     if (!host_ptr) {
         return;
     }
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 32cd43d9ef..4777856b52 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -4,8 +4,6 @@
 #include "cpu.h"
 #include "exec/cpu_ldst.h"
 
-#undef DEBUG_REMAP
-
 #include "exec/user/abitypes.h"
 
 #include "syscall_defs.h"
@@ -332,7 +330,7 @@ void *lock_user(int type, abi_ulong guest_addr, ssize_t len, bool copy);
 /* Unlock an area of guest memory.  The first LEN bytes must be
    flushed back to guest memory. host_ptr = NULL is explicitly
    allowed and does nothing. */
-#ifndef DEBUG_REMAP
+#ifndef CONFIG_DEBUG_REMAP
 static inline void unlock_user(void *host_ptr, abi_ulong guest_addr,
                                ssize_t len)
 {
diff --git a/linux-user/uaccess.c b/linux-user/uaccess.c
index 425cbf677f..27e841e651 100644
--- a/linux-user/uaccess.c
+++ b/linux-user/uaccess.c
@@ -14,7 +14,7 @@ void *lock_user(int type, abi_ulong guest_addr, ssize_t len, bool copy)
         return NULL;
     }
     host_addr = g2h_untagged(guest_addr);
-#ifdef DEBUG_REMAP
+#ifdef CONFIG_DEBUG_REMAP
     if (copy) {
         host_addr = g_memdup(host_addr, len);
     } else {
@@ -24,7 +24,7 @@ void *lock_user(int type, abi_ulong guest_addr, ssize_t len, bool copy)
     return host_addr;
 }
 
-#ifdef DEBUG_REMAP
+#ifdef CONFIG_DEBUG_REMAP
 void unlock_user(void *host_ptr, abi_ulong guest_addr, ssize_t len)
 {
     void *host_ptr_conv;
diff --git a/meson_options.txt b/meson_options.txt
index b5c0bad9e7..adc77bae0c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -85,6 +85,8 @@ option('plugins', type: 'boolean', value: false,
        description: 'TCG plugins via shared library loading')
 option('debug_tcg', type: 'boolean', value: false,
        description: 'TCG debugging')
+option('debug_remap', type: 'boolean', value: false,
+       description: 'syscall buffer debugging support')
 option('tcg_interpreter', type: 'boolean', value: false,
        description: 'TCG with bytecode interpreter (slow)')
 option('safe_stack', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5ace33f167..0a29d35fdb 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -29,6 +29,7 @@ meson_options_help() {
   printf "%s\n" '  --enable-debug-graph-lock'
   printf "%s\n" '                           graph lock debugging support'
   printf "%s\n" '  --enable-debug-mutex     mutex debugging support'
+  printf "%s\n" '  --enable-debug-remap     syscall buffer debugging support'
   printf "%s\n" '  --enable-debug-stack-usage'
   printf "%s\n" '                           measure coroutine stack usage'
   printf "%s\n" '  --enable-debug-tcg       TCG debugging'
@@ -294,6 +295,8 @@ _meson_option_parse() {
     --disable-debug-graph-lock) printf "%s" -Ddebug_graph_lock=false ;;
     --enable-debug-mutex) printf "%s" -Ddebug_mutex=true ;;
     --disable-debug-mutex) printf "%s" -Ddebug_mutex=false ;;
+    --enable-debug-remap) printf "%s" -Ddebug_remap=true ;;
+    --disable-debug-remap) printf "%s" -Ddebug_remap=false ;;
     --enable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=true ;;
     --disable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=false ;;
     --enable-debug-tcg) printf "%s" -Ddebug_tcg=true ;;
-- 
2.34.1


