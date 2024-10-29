Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFFAD7494D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 23:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5vXc-0004D8-Sj; Tue, 29 Oct 2024 19:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5vXa-0004Cm-Lk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:22:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5vXY-00045m-IO
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:22:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLKBAI021909;
 Tue, 29 Oct 2024 23:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=elkOFMLAOG0QMfWUi
 cilS7TVTzCePyoAKqei98EDHBs=; b=XxXX/VHB3cIX0LMu4OTWmNqlKXnWRyfAN
 Dqygt/VYuOjsl+enKM08E/mHSv0VuZUr6O284OCLZ51RBtRDPKwcmSQODWYY4ror
 V3LtNpAYyvAjH6tGTsZ1t6xznFY4CQXyoixq/tPy3yG9FNPxEOXfbu+hPYj5y648
 QnY9LYoeWzSlDDrMKNfp7EIzYGaSNhwZjh2aOcAyVHHMuKLeL2t2WlQXRYNJIyVd
 gvZBL601jg/JYDsvlJ7FNFt1q580t4S0cHWE99NLunMzCdfJ8AiZlkxpfSYnyMtO
 h2BZCccfzq+p/9TEB7C6xXKojufehIaOC/xv2II9wsLGg0d+FueNg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65fkgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49TNMHfj022873;
 Tue, 29 Oct 2024 23:22:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65fkgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TMSgFd018371;
 Tue, 29 Oct 2024 23:22:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8k5b4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49TNMEwT54853930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Oct 2024 23:22:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7C8E20043;
 Tue, 29 Oct 2024 23:22:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 544E720040;
 Tue, 29 Oct 2024 23:22:14 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.12.2])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Oct 2024 23:22:14 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>,
 "ltaylorsimpson @ gmail . com" <ltaylorsimpson@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 1/2] linux-user: Allow custom rt signal mappings
Date: Wed, 30 Oct 2024 00:17:47 +0100
Message-ID: <20241029232211.206766-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029232211.206766-1-iii@linux.ibm.com>
References: <20241029232211.206766-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jRUBoJdGdfCHcRT9VMDDSuWladIW0PvE
X-Proofpoint-GUID: DgWnHWaMTC2o9H9aquTNoYsLrfwyEJGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some applications want to use low priority realtime signals (e.g.,
SIGRTMAX). Currently QEMU cannot map all target realtime signals to
host realtime signals, and chooses to sacrifice the end of the target
realtime signal range.

Allow users to choose how to map target realtime signals to host
realtime signals using the new -t option, the new QEMU_RTSIG_MAP
environment variable, and the new -Drtsig_map=\"...\" meson flag.
To simplify things, the meson flag is not per-target, because the
intended use case is app-specific qemu-user builds.

The mapping is specified using the "tsig hsig count[,...]" syntax.
Target realtime signals [tsig,tsig+count) are mapped to host realtime
signals [hsig,hsig+count). Care is taken to avoid double and
out-of-range mappings.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/main.c             |  12 +++-
 linux-user/signal-common.h    |   2 +-
 linux-user/signal.c           | 108 +++++++++++++++++++++++++++-------
 meson.build                   |   3 +-
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   2 +
 6 files changed, 106 insertions(+), 23 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8143a0d4b02..b09af8d4365 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -412,6 +412,13 @@ static void handle_arg_reserved_va(const char *arg)
     reserved_va = val ? val - 1 : 0;
 }
 
+static const char *rtsig_map = CONFIG_QEMU_RTSIG_MAP;
+
+static void handle_arg_rtsig_map(const char *arg)
+{
+    rtsig_map = arg;
+}
+
 static void handle_arg_one_insn_per_tb(const char *arg)
 {
     opt_one_insn_per_tb = true;
@@ -494,6 +501,9 @@ static const struct qemu_argument arg_table[] = {
      "address",    "set guest_base address to 'address'"},
     {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
      "size",       "reserve 'size' bytes for guest virtual address space"},
+    {"t",          "QEMU_RTSIG_MAP",   true,  handle_arg_rtsig_map,
+     "tsig hsig n[,...]",
+                   "map target rt signals [tsig,tsig+n) to [hsig,hsig+n]"},
     {"d",          "QEMU_LOG",         true,  handle_arg_log,
      "item[,...]", "enable logging of specified items "
      "(use '-d help' for a list of items)"},
@@ -1002,7 +1012,7 @@ int main(int argc, char **argv, char **envp)
 
     target_set_brk(info->brk);
     syscall_init();
-    signal_init();
+    signal_init(rtsig_map);
 
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index f4cbe6185e1..8584d9ecc2a 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -56,7 +56,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_sigset_t *set, CPUArchState *env);
 
 void process_pending_signals(CPUArchState *cpu_env);
-void signal_init(void);
+void signal_init(const char *rtsig_map);
 void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 63ac2df53b7..9b6d772882d 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/cutils.h"
 #include "gdbstub/user.h"
 #include "exec/page-protection.h"
 #include "hw/core/tcg-cpu-ops.h"
@@ -513,20 +514,81 @@ static int core_dump_signal(int sig)
     }
 }
 
-static void signal_table_init(void)
+static void signal_table_init(const char *rtsig_map)
 {
     int hsig, tsig, count;
 
+    if (rtsig_map) {
+        /*
+         * Map host RT signals to target RT signals according to the
+         * user-provided specification.
+         */
+        const char *s = rtsig_map;
+
+        while (true) {
+            int i;
+
+            if (qemu_strtoi(s, &s, 10, &tsig) || *s++ != ' ') {
+                fprintf(stderr, "Malformed target signal in QEMU_RTSIG_MAP\n");
+                exit(EXIT_FAILURE);
+            }
+            if (qemu_strtoi(s, &s, 10, &hsig) || *s++ != ' ') {
+                fprintf(stderr, "Malformed host signal in QEMU_RTSIG_MAP\n");
+                exit(EXIT_FAILURE);
+            }
+            if (qemu_strtoi(s, &s, 10, &count) || (*s && *s != ',')) {
+                fprintf(stderr, "Malformed signal count in QEMU_RTSIG_MAP\n");
+                exit(EXIT_FAILURE);
+            }
+
+            for (i = 0; i < count; i++, tsig++, hsig++) {
+                if (tsig < TARGET_SIGRTMIN || tsig > TARGET_NSIG) {
+                    fprintf(stderr, "%d is not a target rt signal\n", tsig);
+                    exit(EXIT_FAILURE);
+                }
+                if (hsig < SIGRTMIN || hsig > SIGRTMAX) {
+                    fprintf(stderr, "%d is not a host rt signal\n", hsig);
+                    exit(EXIT_FAILURE);
+                }
+                if (host_to_target_signal_table[hsig]) {
+                    fprintf(stderr, "%d already maps %d\n",
+                            hsig, host_to_target_signal_table[hsig]);
+                    exit(EXIT_FAILURE);
+                }
+                host_to_target_signal_table[hsig] = tsig;
+            }
+
+            if (*s) {
+                s++;
+            } else {
+                break;
+            }
+        }
+    } else {
+        /*
+         * Default host-to-target RT signal mapping.
+         *
+         * Signals are supported starting from TARGET_SIGRTMIN and going up
+         * until we run out of host realtime signals.  Glibc uses the lower 2
+         * RT signals and (hopefully) nobody uses the upper ones.
+         * This is why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
+         * To fix this properly we would need to do manual signal delivery
+         * multiplexed over a single host signal.
+         * Attempts for configure "missing" signals via sigaction will be
+         * silently ignored.
+         *
+         * Reserve one signal for internal usage (see below).
+         */
+
+        hsig = SIGRTMIN + 1;
+        for (tsig = TARGET_SIGRTMIN;
+             hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
+             hsig++, tsig++) {
+            host_to_target_signal_table[hsig] = tsig;
+        }
+    }
+
     /*
-     * Signals are supported starting from TARGET_SIGRTMIN and going up
-     * until we run out of host realtime signals.  Glibc uses the lower 2
-     * RT signals and (hopefully) nobody uses the upper ones.
-     * This is why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
-     * To fix this properly we would need to do manual signal delivery
-     * multiplexed over a single host signal.
-     * Attempts for configure "missing" signals via sigaction will be
-     * silently ignored.
-     *
      * Remap the target SIGABRT, so that we can distinguish host abort
      * from guest abort.  When the guest registers a signal handler or
      * calls raise(SIGABRT), the host will raise SIG_RTn.  If the guest
@@ -536,21 +598,27 @@ static void signal_table_init(void)
      * parent sees the correct mapping from wait status.
      */
 
-    hsig = SIGRTMIN;
     host_to_target_signal_table[SIGABRT] = 0;
-    host_to_target_signal_table[hsig++] = TARGET_SIGABRT;
-
-    for (tsig = TARGET_SIGRTMIN;
-         hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
-         hsig++, tsig++) {
-        host_to_target_signal_table[hsig] = tsig;
+    for (hsig = SIGRTMIN; hsig <= SIGRTMAX; hsig++) {
+        if (!host_to_target_signal_table[hsig]) {
+            host_to_target_signal_table[hsig] = TARGET_SIGABRT;
+            break;
+        }
+    }
+    if (hsig > SIGRTMAX) {
+        fprintf(stderr, "No rt signals left for SIGABRT mapping\n");
+        exit(EXIT_FAILURE);
     }
 
     /* Invert the mapping that has already been assigned. */
     for (hsig = 1; hsig < _NSIG; hsig++) {
         tsig = host_to_target_signal_table[hsig];
         if (tsig) {
-            assert(target_to_host_signal_table[tsig] == 0);
+            if (target_to_host_signal_table[tsig]) {
+                fprintf(stderr, "%d is already mapped to %d\n",
+                        tsig, target_to_host_signal_table[tsig]);
+                exit(EXIT_FAILURE);
+            }
             target_to_host_signal_table[tsig] = hsig;
         }
     }
@@ -573,13 +641,13 @@ static void signal_table_init(void)
     trace_signal_table_init(count);
 }
 
-void signal_init(void)
+void signal_init(const char *rtsig_map)
 {
     TaskState *ts = get_task_state(thread_cpu);
     struct sigaction act, oact;
 
     /* initialize signal conversion tables */
-    signal_table_init();
+    signal_table_init(rtsig_map);
 
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
diff --git a/meson.build b/meson.build
index 85594fd3f18..bc282c8d187 100644
--- a/meson.build
+++ b/meson.build
@@ -3167,7 +3167,8 @@ foreach target : target_dirs
     config_target += {
       'CONFIG_USER_ONLY': 'y',
       'CONFIG_QEMU_INTERP_PREFIX':
-        get_option('interp_prefix').replace('%M', config_target['TARGET_NAME'])
+        get_option('interp_prefix').replace('%M', config_target['TARGET_NAME']),
+      'CONFIG_QEMU_RTSIG_MAP': get_option('rtsig_map'),
     }
   endif
 
diff --git a/meson_options.txt b/meson_options.txt
index 0ee4d7bb86b..b61808b46a6 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -27,6 +27,8 @@ option('block_drv_ro_whitelist', type : 'string', value : '',
        description: 'set block driver read-only whitelist (by default affects only QEMU, not tools like qemu-img)')
 option('interp_prefix', type : 'string', value : '/usr/gnemul/qemu-%M',
        description: 'where to find shared libraries etc., use %M for cpu name')
+option('rtsig_map', type : 'string', value : 'NULL',
+       description: 'default value of QEMU_RTSIG_MAP')
 option('fuzzing_engine', type : 'string', value : '',
        description: 'fuzzing engine library for OSS-Fuzz')
 option('trace_file', type: 'string', value: 'trace',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6d08605b771..9684f82ffbb 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -72,6 +72,7 @@ meson_options_help() {
   printf "%s\n" '                           "manufacturer" name for qemu-ga registry entries'
   printf "%s\n" '                           [QEMU]'
   printf "%s\n" '  --qemu-ga-version=VALUE  version number for qemu-ga installer'
+  printf "%s\n" '  --rtsig-map=VALUE        default value of QEMU_RTSIG_MAP [NULL]'
   printf "%s\n" '  --smbd=VALUE             Path to smbd for slirp networking'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
@@ -457,6 +458,7 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --rtsig-map=*) quote_sh "-Drtsig_map=$2" ;;
     --enable-rust) printf "%s" -Drust=enabled ;;
     --disable-rust) printf "%s" -Drust=disabled ;;
     --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
-- 
2.47.0


