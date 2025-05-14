Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0574DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHOf-0001Qy-Uq; Wed, 14 May 2025 15:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHLq-0004Xb-Rk; Wed, 14 May 2025 15:01:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHLn-0007O9-EU; Wed, 14 May 2025 15:01:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62CA2121D94;
 Wed, 14 May 2025 22:00:32 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B2E320BA86;
 Wed, 14 May 2025 22:00:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 10/23] meson: Share common C source prefixes
Date: Wed, 14 May 2025 22:00:22 +0300
Message-Id: <20250514190041.104759-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

gnu_source_prefix defines _GNU_SOURCE for compiler object functions.
The definition is universally available in the code base.

docs/devel/style.rst also says that the "qemu/osdep.h" header is
always included, so files included in the file is also universally
available in the code base.

Rename gnu_source_prefix to osdep_prefix, and add #include directives
that are referred by the users of gnu_source_prefix and contained in
qemu/osdep.h to safely de-duplicate #include directives.

Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424-buildsys-v1-3-97655e3b25d7@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 797150d69d2edba8b1bd4a7d8c7ba2df1219c503)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 1a02cd8990..0a35fc3fa9 100644
--- a/meson.build
+++ b/meson.build
@@ -2185,10 +2185,21 @@ if not has_malloc_trim and get_option('malloc_trim').enabled()
   endif
 endif
 
-gnu_source_prefix = '''
+osdep_prefix = '''
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif
+
+  #include <stddef.h>
+  #include <sys/types.h>
+
+  #include <limits.h>
+  /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
+   * function availability on recentish Mingw-w64 platforms. */
+  #include <unistd.h>
+  #include <time.h>
+  #include <errno.h>
+  #include <fcntl.h>
 '''
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
@@ -2703,7 +2714,7 @@ config_host_data.set('CONFIG_FIEMAP',
                      cc.has_header('linux/fiemap.h') and
                      cc.has_header_symbol('linux/fs.h', 'FS_IOC_FIEMAP'))
 config_host_data.set('CONFIG_GETCPU',
-                     cc.has_header_symbol('sched.h', 'getcpu', prefix: gnu_source_prefix))
+                     cc.has_header_symbol('sched.h', 'getcpu', prefix: osdep_prefix))
 config_host_data.set('CONFIG_GETRANDOM',
                      cc.has_function('getrandom') and
                      cc.has_header_symbol('sys/random.h', 'GRND_NONBLOCK'))
@@ -2748,8 +2759,7 @@ config_host_data.set('HAVE_UTMPX',
 config_host_data.set('CONFIG_EVENTFD', cc.links('''
   #include <sys/eventfd.h>
   int main(void) { return eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC); }'''))
-config_host_data.set('CONFIG_FDATASYNC', cc.links(gnu_source_prefix + '''
-  #include <unistd.h>
+config_host_data.set('CONFIG_FDATASYNC', cc.links(osdep_prefix + '''
   int main(void) {
   #if defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0
   return fdatasync(0);
@@ -2758,10 +2768,8 @@ config_host_data.set('CONFIG_FDATASYNC', cc.links(gnu_source_prefix + '''
   #endif
   }'''))
 
-has_madvise = cc.links(gnu_source_prefix + '''
-  #include <sys/types.h>
+has_madvise = cc.links(osdep_prefix + '''
   #include <sys/mman.h>
-  #include <stddef.h>
   int main(void) { return madvise(NULL, 0, MADV_DONTNEED); }''')
 missing_madvise_proto = false
 if has_madvise
@@ -2771,21 +2779,18 @@ if has_madvise
   # missing-prototype case, we try again with a definitely-bogus prototype.
   # This will only compile if the system headers don't provide the prototype;
   # otherwise the conflicting prototypes will cause a compiler error.
-  missing_madvise_proto = cc.links(gnu_source_prefix + '''
-    #include <sys/types.h>
+  missing_madvise_proto = cc.links(osdep_prefix + '''>
     #include <sys/mman.h>
-    #include <stddef.h>
     extern int madvise(int);
     int main(void) { return madvise(0); }''')
 endif
 config_host_data.set('CONFIG_MADVISE', has_madvise)
 config_host_data.set('HAVE_MADVISE_WITHOUT_PROTOTYPE', missing_madvise_proto)
 
-config_host_data.set('CONFIG_MEMFD', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_MEMFD', cc.links(osdep_prefix + '''
   #include <sys/mman.h>
   int main(void) { return memfd_create("foo", MFD_ALLOW_SEALING); }'''))
-config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(gnu_source_prefix + '''
-  #include <fcntl.h>
+config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(osdep_prefix + '''
   #if !defined(AT_EMPTY_PATH)
   # error missing definition
   #else
@@ -2796,13 +2801,12 @@ config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(gnu_source_prefix + '''
 # i.e. errno is set and -1 is returned. That's not really how POSIX defines the
 # function. On the flip side, it has madvise() which is preferred anyways.
 if host_os != 'darwin'
-  config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(gnu_source_prefix + '''
+  config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(osdep_prefix + '''
     #include <sys/mman.h>
-    #include <stddef.h>
     int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }'''))
 endif
 
-config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
   static void *f(void *p) { return NULL; }
@@ -2813,7 +2817,7 @@ config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(gnu_source_pref
     pthread_setname_np(thread, "QEMU");
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_WO_TID', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_WO_TID', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
   static void *f(void *p) { pthread_setname_np("QEMU"); return NULL; }
@@ -2823,7 +2827,7 @@ config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_WO_TID', cc.links(gnu_source_pre
     pthread_create(&thread, 0, f, 0);
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(osdep_prefix + '''
   #include <pthread.h>
   #include <pthread_np.h>
 
@@ -2835,9 +2839,8 @@ config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(gnu_source_prefix +
     pthread_set_name_np(thread, "QEMU");
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix + '''
   #include <pthread.h>
-  #include <time.h>
 
   int main(void)
   {
@@ -2846,7 +2849,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(gnu_source_pre
     pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
   static void *f(void *p) { return NULL; }
@@ -2863,15 +2866,10 @@ config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(gnu_source_prefix +
     CPU_FREE(cpuset);
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_SIGNALFD', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_SIGNALFD', cc.links(osdep_prefix + '''
   #include <sys/signalfd.h>
-  #include <stddef.h>
   int main(void) { return signalfd(-1, NULL, SFD_CLOEXEC); }'''))
-config_host_data.set('CONFIG_SPLICE', cc.links(gnu_source_prefix + '''
-  #include <unistd.h>
-  #include <fcntl.h>
-  #include <limits.h>
-
+config_host_data.set('CONFIG_SPLICE', cc.links(osdep_prefix + '''
   int main(void)
   {
     int len, fd = 0;
@@ -2880,13 +2878,13 @@ config_host_data.set('CONFIG_SPLICE', cc.links(gnu_source_prefix + '''
     return 0;
   }'''))
 
-config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
+config_host_data.set('HAVE_MLOCKALL', cc.links(osdep_prefix + '''
   #include <sys/mman.h>
   int main(void) {
     return mlockall(MCL_FUTURE);
   }'''))
 
-config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
+config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(osdep_prefix + '''
   #include <sys/mman.h>
   int main(void) {
       return mlockall(MCL_FUTURE | MCL_ONFAULT);
@@ -2895,7 +2893,7 @@ config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
 have_l2tpv3 = false
 if get_option('l2tpv3').allowed() and have_system
   have_l2tpv3 = cc.has_type('struct mmsghdr',
-    prefix: gnu_source_prefix + '''
+    prefix: osdep_prefix + '''
       #include <sys/socket.h>
       #include <linux/ip.h>''')
 endif
@@ -3011,13 +3009,13 @@ if has_int128_type
   endif
 endif
 
-config_host_data.set('CONFIG_GETAUXVAL', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_GETAUXVAL', cc.links(osdep_prefix + '''
   #include <sys/auxv.h>
   int main(void) {
     return getauxval(AT_HWCAP) == 0;
   }'''))
 
-config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(osdep_prefix + '''
   #include <sys/auxv.h>
   int main(void) {
     unsigned long hwcap = 0;
@@ -3130,9 +3128,7 @@ config_host_data.set('CONFIG_MEMBARRIER', get_option('membarrier') \
   .allowed())
 
 have_afalg = get_option('crypto_afalg') \
-  .require(cc.compiles(gnu_source_prefix + '''
-    #include <errno.h>
-    #include <sys/types.h>
+  .require(cc.compiles(osdep_prefix + '''
     #include <sys/socket.h>
     #include <linux/if_alg.h>
     int main(void) {
-- 
2.39.5


