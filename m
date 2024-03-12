Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AE0C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 00:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjpwM-0001RH-P7; Mon, 11 Mar 2024 20:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rjpwJ-0001Qm-AU
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 20:24:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rjpwF-000389-1h
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 20:24:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42C0Ac10010519; Tue, 12 Mar 2024 00:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=E0VnF5RdCII/XkCClG1U7GdlEOyLZcvZnRXhohhBrG8=;
 b=eTRWfKFbTY/7wt3xZMUwmZM0UBMXLNKchd6/pUJ8Hc/hg1JzLeAGH+9RMUOMb/+jNMM+
 /LvRe44/Fxc8IPveO2eAq4IYmR6ocn1JxYRFcY/cxQsL6ajq8cpRgydnwqW4TukVqcfC
 jqj06m62q+MCOj7SR3WkcPh99/jxtXehrx/4GmVkRIU0kP3rgoo0iLEYjaI+0L/Ssv24
 oJeMXyD6/z/riCNZZE/iLCbhdP474EMj4OfL3KRuAEXphr7sotDoGmGlG8s4cHYHxbRn
 hQOm1H8R5mpyrUpuiW7tTuRzKd3kskr36q7kATMbZ40aSK+qdPbQO9IMwrdR0ZLxDwQb cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtc55r65q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 00:24:10 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C0OABD002859;
 Tue, 12 Mar 2024 00:24:10 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtc55r65k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 00:24:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BLDnU0018143; Tue, 12 Mar 2024 00:24:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t42mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 00:24:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C0O5GT49217792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 00:24:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E4D720040;
 Tue, 12 Mar 2024 00:24:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 070D32004B;
 Tue, 12 Mar 2024 00:24:05 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.72.107])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 00:24:04 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] meson: Make DEBUG_REMAP a meson option
Date: Tue, 12 Mar 2024 01:23:30 +0100
Message-ID: <20240312002402.14344-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9zNDmOHFh98xb1Gb5EgrEvHJy9HYT_ZP
X-Proofpoint-GUID: bsH09rus8mvTU3gi8nMQTjiZXy3KpbMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_12,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403120000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently DEBUG_REMAP is a macro that needs to be manually #defined to
be activated, which makes it hard to have separate build directories
dedicated to testing the code with it. Promote it to a meson option.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/qemu.h               | 6 ++----
 linux-user/qemu.h             | 4 +---
 linux-user/uaccess.c          | 4 ++--
 meson.build                   | 4 ++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 6 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 1b0a591d2d2..8629f0dcde9 100644
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
index 32cd43d9eff..4777856b529 100644
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
index 425cbf677f7..27e841e6510 100644
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
diff --git a/meson.build b/meson.build
index f9dbe7634e5..1427e9f8811 100644
--- a/meson.build
+++ b/meson.build
@@ -2342,6 +2342,7 @@ config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
 config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
+config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
 config_host_data.set('CONFIG_LIVE_BLOCK_MIGRATION', get_option('live_block_migration').allowed())
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
@@ -4285,6 +4286,9 @@ if config_all_accel.has_key('CONFIG_TCG')
   endif
   summary_info += {'TCG plugins':       get_option('plugins')}
   summary_info += {'TCG debug enabled': get_option('debug_tcg')}
+  if have_linux_user or have_bsd_user
+    summary_info += {'syscall buffer debugging support': get_option('debug_remap')}
+  endif
 endif
 summary_info += {'target list':       ' '.join(target_dirs)}
 if have_system
diff --git a/meson_options.txt b/meson_options.txt
index 0a99a059ec8..7cd48a88e6e 100644
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
index 680fa3f581d..aff58275daf 100644
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
@@ -295,6 +296,8 @@ _meson_option_parse() {
     --disable-debug-graph-lock) printf "%s" -Ddebug_graph_lock=false ;;
     --enable-debug-mutex) printf "%s" -Ddebug_mutex=true ;;
     --disable-debug-mutex) printf "%s" -Ddebug_mutex=false ;;
+    --enable-debug-remap) printf "%s" -Ddebug_remap=true ;;
+    --disable-debug-remap) printf "%s" -Ddebug_remap=false ;;
     --enable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=true ;;
     --disable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=false ;;
     --enable-debug-tcg) printf "%s" -Ddebug_tcg=true ;;
-- 
2.44.0


