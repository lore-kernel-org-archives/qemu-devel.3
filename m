Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BB1C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 09:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujDpb-0008Nn-7S; Tue, 05 Aug 2025 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujDpY-0008Dn-Sh
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:19:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujDpW-0008JL-9s
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:19:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459e3926cbbso1213555e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754385571; x=1754990371; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KJVH2t1or8LffWhEWHLiYIn9vK2gZYZAZKSnfUNKLCQ=;
 b=ynHZ86rfA0luEKWbI4bV96fJaSJFiSVtfsIAeBDeDw+OZ7YUH+VUtcpQLuelUAoSHp
 cqMcHbgUNUvC7iJ775pwXibbhfWYyOufFWFiEzKvDuQhrsGykqwcG/C/mbZdyoPYEzZV
 vbCCRsH2A2N6z2P2o3R9llp/M/AoqN0Tl65QgVf5l7JhtZPrCa59mxYqWOuHDVmMboDd
 Sc0cipecs7hSrDzAfI1CZ6KvNyJeu/vqtCgKljyZ58IWvrQUgi7i9byZPOItmNuLO8Kn
 /KlDyO5PH+xGBN+Dd+6I0zKkmhHWrYcEAtXEPGfU+9b+cWrvlm2He/sHunyeGmzta+IU
 s2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385571; x=1754990371;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJVH2t1or8LffWhEWHLiYIn9vK2gZYZAZKSnfUNKLCQ=;
 b=SHtD8n1BD8yZr09safc4Ywcrra7ovQHQRSYb4VfSZpPIkjqdS58clXX49UbPR4WY1c
 TydzV0PcJ+Bcok4ZyrivFL3wATOLiJeQndl6kNxoVPqnNBxcPzAAK8Ljxw1e6xAiiY8z
 qkcbTCT125bDABa79X18egBLW2m71Hl+smRwoKQE9rGO023RtuRkPuQ8yH1si/t2oVdo
 CYxuVd+n+/O+lxjCngn/FO/lVaWaeIlGZg/+pNlTv8gGlm8TD0tHwD4iA2mtVxu2To3N
 /N/UkjeukNXzQt0iEQLd24vZKyHHul4FUseaQy4CBZcw9sQE0S3QzIymje5bElU5bfzo
 3DXg==
X-Gm-Message-State: AOJu0YyhaVKqAP9iiOIUw9yBKqJk6b2tnsavVi77wVpoSJMyY4TlfAjo
 KMgpuCweDUNSwnNWRhuLTFTEi3JXek6V4VGrsRX7g8blH6DMW6uk9sUG2lHsxwHF4/Y=
X-Gm-Gg: ASbGncvWHairuHchAkNYc0sKV7pc1TAjZE8i1YmOsaU8ltX2U4+Vsaocy7qRjeWYC9/
 r7EeM3xVFlXnKU+4FVb2jd+TRFipddsrmnfJInMpTtOA4RAgrNeJL+1zf6WIMZ9yu+i1wdrojgj
 tUIyPouOZHTqiLfFgckqBomoPmUDBuZa+1PWz2tA0ISsnmXR0bz60vMzKC+2eU9j17E+jyWOK/g
 +Y2TcImauKR6ujH2y9WtEWLa8jKP0Yxs/u9JNAHh2lhhA8YeoZJV2Mt3zz/842ol9WbUQh9oCKS
 qjoyyjV+GrLZ7+wBb0JYk3ACNXKKneG2btCaYuDkZ40dX6PKa7+b339rUUb6QPiU1bBWA1PVLdz
 6BZrQU7N9NA0/jr9ftK/arMChcrCMK5TIPcL+pVCs1x1PA169MT62lKxmbT2YHhB6WqbOPXy/iO
 skKz4=
X-Google-Smtp-Source: AGHT+IEYCGDa+z7A7prxUXqtlintb+b0UUY89K6SYZCIHupStooDO7ocG5i0I/TZauR8o7c6MEYv0g==
X-Received: by 2002:a05:600c:1e88:b0:459:ddd6:1cc7 with SMTP id
 5b1f17b1804b1-459ddd61f6bmr54073805e9.0.1754385570853; 
 Tue, 05 Aug 2025 02:19:30 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458a7c91c0esm179370855e9.11.2025.08.05.02.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:19:30 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 05 Aug 2025 12:19:26 +0300
Subject: [PATCH RFC] util/error.c: Print backtrace on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ3MkWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNT3aTE5OySosTkVN1Ui1STZCMTS4MkEzMloPqCotS0zAqwWdFKQW7
 OSrG1tQChbXrwYAAAAA==
X-Change-ID: 20250805-backtrace-e8e4c2490b46
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6849;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=qLwXPfO8zcgv4akobMLlNzA2xl9hLQMg9mCZt8MubzM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9rY3loRU5peTRETE83V1J0UU5nY2diK0E4MmNlCjFtY1o3eWltTXg1YWE5c2tL
 OENKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpITW9RQUt
 DUkIzS2Nkd2YzNEowR1kwRC80cUZiZFRmVHZmcnZ3dVVnUGdjM1lJaW1SZTkwSVVWT0t6UXcxTg
 pYZHRzQlBPYkJhT3prcUVDNklUOXRUSTc0WkI3eFJ5eWd0L2trcTAyQmpobWxnQ1lPUnJkamphZ
 DN0NWltblE0CkpQVUIxbS9rdDVOQkdkWk1jSTNXUXNqckR6Y3hiVm8zYm9rMnRubFlwNlcvNjZj
 VXV6SWE2Z01qRjJCdzlTbHYKN1RYZVRlRHo3OVJHdVptTXkxeE0vRHdWcWU1dlN2emlFbzhGcGx
 VMzJzckU2OE9hdzR2Qm4ya1JNdGlnSE8wSgpzRGZ2bHYrNVlLSUc1UlAzVSsyc2hhTEJsalR0dz
 B4aVpjZlR2NkZUMk85dDAwZ29vV0VyODg4aVVCNkdubUc3ClpDNnFaL2xIRE5XcW00aFc4cXVuZ
 ytlS3NWYXpLYngrcEo2VXBnWnZNempJM3NlMDZXUkhkdWlxcGtoSzB1SVMKcDA2ZG1MOFFMbHN4
 a1RWSFZNS2M2ZGRZWm9yazZWZ1EvdFRuMFYvQTRyZDVZSlBCRGphUzVKQjRISWZ3ZXZoVApCemg
 4R1orYXQyVzZNZ1RIK2lDVjdlc3B2UDV4S05uMWh5V2t1bXB5bDZadnZ2ejhya05CVjBYczlBU0
 xDZTFoCjI4dmlHZkpjck9kaytuQUdOZ1VkY280YmtLWG5zZlgyeStFR2N1YnpPVVVLa1ZOSFBEO
 Gk1cnJtWGg0VWpHeVUKdHpQc3lkd1NqTUtLa21YRmpURmU5MGd3WjJJRkU5bmNmS003b08vY3Ft
 aGJ1YnJERVdBWE9Dd2xzRklQajArbgp2bDVvczJPMHBXVFA3Z212NEFtN0pWK0U4RlFZMXJGWEd
 nNVlkcHdRbTdONEVub054Uzk3aVdIOHRBdGlTZ0EyCmpLbkhzZz09Cj11eTBHCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

Add a backtrace_on_error meson feature (enabled with
--enable-backtrace-on-error) that compiles system binaries with
-rdynamic option and prints a function backtrace on error to stderr.

Example output by adding an unconditional error_setg on error_abort in hw/arm/boot.c:

  ./qemu-system-aarch64(+0x13b4a2c) [0x55d015406a2c]
  ./qemu-system-aarch64(+0x13b4abd) [0x55d015406abd]
  ./qemu-system-aarch64(+0x13b4d49) [0x55d015406d49]
  ./qemu-system-aarch64(error_setg_internal+0xe7) [0x55d015406f62]
  ./qemu-system-aarch64(arm_load_dtb+0xbf) [0x55d014d7686f]
  ./qemu-system-aarch64(+0xd2f1d8) [0x55d014d811d8]
  ./qemu-system-aarch64(notifier_list_notify+0x44) [0x55d01540a282]
  ./qemu-system-aarch64(qdev_machine_creation_done+0xa0) [0x55d01476ae17]
  ./qemu-system-aarch64(+0xaa691e) [0x55d014af891e]
  ./qemu-system-aarch64(qmp_x_exit_preconfig+0x72) [0x55d014af8a5d]
  ./qemu-system-aarch64(qemu_init+0x2a89) [0x55d014afb657]
  ./qemu-system-aarch64(main+0x2f) [0x55d01521e836]
  /lib/x86_64-linux-gnu/libc.so.6(+0x29ca8) [0x7f3033d67ca8]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85) [0x7f3033d67d65]
  ./qemu-system-aarch64(_start+0x21) [0x55d0146814f1]

  Unexpected error in arm_load_dtb() at ../hw/arm/boot.c:529:

For qemu-system-aarch64, this adds an additional 2MB to the binary size
so this is not enabled by default. I also only tested this on Linux, it
might not be portable.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 meson.build                   |  3 +++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  4 ++++
 util/error.c                  | 17 +++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/meson.build b/meson.build
index e53cd5b413847f33c972540e1f67a092164a200d..5d6ec5a5d5cb4c176bb32450f2adf85fc4963105 100644
--- a/meson.build
+++ b/meson.build
@@ -2649,6 +2649,7 @@ config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage')
 config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
+config_host_data.set('CONFIG_BACKTRACE', get_option('backtrace_on_error'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
 config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
 config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
@@ -4454,6 +4455,7 @@ foreach target : target_dirs
     endif
 
     emulator = executable(exe_name, exe['sources'],
+               export_dynamic: get_option('backtrace_on_error'),
                install: true,
                c_args: c_args,
                dependencies: arch_deps + exe['dependencies'],
@@ -4714,6 +4716,7 @@ if 'simple' in get_option('trace_backends')
   summary_info += {'Trace output file': get_option('trace_file') + '-<pid>'}
 endif
 summary_info += {'QOM debugging':     get_option('qom_cast_debug')}
+summary_info += {'Backtrace support':     get_option('backtrace_on_error')}
 summary_info += {'Relocatable install': get_option('relocatable')}
 summary_info += {'vhost-kernel support': have_vhost_kernel}
 summary_info += {'vhost-net support': have_vhost_net}
diff --git a/meson_options.txt b/meson_options.txt
index dd335307505fb52c5be469aa4fab8883c93ec5c9..450c17349263429e59413b0c483c2d52db13325e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -368,6 +368,8 @@ option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
+option('backtrace_on_error', type: 'boolean', value: false,
+       description: 'print backtrace on error')
 option('slirp_smbd', type : 'feature', value : 'auto',
        description: 'use smbd (at path --smbd=*) in slirp networking')
 
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index d559e260ed17e50a423aa25b27a86777489565d7..0dd28c93e4d8bd24f7343745c6462aa5d9a603ee 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -22,6 +22,8 @@ meson_options_help() {
   printf "%s\n" '  --docdir=VALUE           Base directory for documentation installation'
   printf "%s\n" '                           (can be empty) [share/doc]'
   printf "%s\n" '  --enable-asan            enable address sanitizer'
+  printf "%s\n" '  --enable-backtrace-on-error'
+  printf "%s\n" '                           print backtrace on error'
   printf "%s\n" '  --enable-block-drv-whitelist-in-tools'
   printf "%s\n" '                           use block whitelist also in tools instead of only'
   printf "%s\n" '                           QEMU'
@@ -251,6 +253,8 @@ _meson_option_parse() {
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
     --disable-lto) printf "%s" -Db_lto=false ;;
+    --enable-backtrace-on-error) printf "%s" -Dbacktrace_on_error=true ;;
+    --disable-backtrace-on-error) printf "%s" -Dbacktrace_on_error=false ;;
     --bindir=*) quote_sh "-Dbindir=$2" ;;
     --enable-blkio) printf "%s" -Dblkio=enabled ;;
     --disable-blkio) printf "%s" -Dblkio=disabled ;;
diff --git a/util/error.c b/util/error.c
index daea2142f30121abc46e5342526f5eec40ea246e..d834756abd563f4108b7599bb4da1e5dd85ec46c 100644
--- a/util/error.c
+++ b/util/error.c
@@ -17,13 +17,28 @@
 #include "qemu/error-report.h"
 #include "qapi/error-internal.h"
 
+#ifdef CONFIG_BACKTRACE
+#include <execinfo.h>
+#endif /* CONFIG_BACKTRACE */
+
 Error *error_abort;
 Error *error_fatal;
 Error *error_warn;
 
+static inline void dump_backtrace(void)
+{
+#ifdef CONFIG_BACKTRACE
+    void *buffer[255] = { 0 };
+    const int calls =
+        backtrace(buffer, sizeof(buffer) / sizeof(void *));
+    backtrace_symbols_fd(buffer, calls, 2);
+#endif /* CONFIG_BACKTRACE */
+}
+
 static void error_handle(Error **errp, Error *err)
 {
     if (errp == &error_abort) {
+        dump_backtrace();
         if (err->func) {
             fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
                     err->func, err->src_len, err->src, err->line);
@@ -38,10 +53,12 @@ static void error_handle(Error **errp, Error *err)
         abort();
     }
     if (errp == &error_fatal) {
+        dump_backtrace();
         error_report_err(err);
         exit(1);
     }
     if (errp == &error_warn) {
+        dump_backtrace();
         warn_report_err(err);
     } else if (errp && !*errp) {
         *errp = err;

---
base-commit: a41280fd5b94c49089f7631c6fa8bb9c308b7962
change-id: 20250805-backtrace-e8e4c2490b46

--
γαῖα πυρί μιχθήτω


