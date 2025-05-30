Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA14CC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1s-0002zF-Ck; Fri, 30 May 2025 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwv-0002eP-Ia
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwt-0006zV-K0
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDzRaIf4Ba/SVM0QnY683CUkFt3pe9pQh7yPh7y8gnE=;
 b=HkP3oyB9Fw38FikRFK2MSD84+WPd3JCcvmwex5WRbitB/e14VTrn4qQqFwDhuDHXExm/dp
 yEgHlmSuXmNiESd6c/nz2W4MQWNfx5vwkMOoXBjac6FM+dljZ4HXRXIC0kM5j0I7WVqXbf
 bua7gDHM3Bn5ZJLvZ6BGEqydivHPgSQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-MktXU_L2NtGMWFLQAiKlmg-1; Fri, 30 May 2025 03:14:37 -0400
X-MC-Unique: MktXU_L2NtGMWFLQAiKlmg-1
X-Mimecast-MFC-AGG-ID: MktXU_L2NtGMWFLQAiKlmg_1748589276
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad212166df4so130969466b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589275; x=1749194075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDzRaIf4Ba/SVM0QnY683CUkFt3pe9pQh7yPh7y8gnE=;
 b=TlcamDInwUA0cqUgPf3YVP4eCZHj3F2GfecV9dHNkZm3YGgZI/MESKlGzk/M5F01/H
 80t+MD818myXy2BAXWNXB5A3MGSFWDnHEVcJ5yat+XX+VNo4/LTfJb/6Mdn+73Im4NbF
 fY2ULfvWfu39ZWnQWLiGRMAe9WJLxFlklEVqrGgPVevtuljbXhfh4gb/3qa+Dc/s1KFN
 njSg7YwsB6mHbZFdFcsEFyUXN3MyNRjOM287yhWzvTDva4vptLVYqSxHnjC3h/HRxR5B
 jBuVA0dQw8u+mH7B9sWlTIUfu7OlYhn2RcKiDmFzk8NxFB1YAkiP077nrxVVbbw86lVd
 b2MQ==
X-Gm-Message-State: AOJu0YwX1AlD5syElw+SIWDcB/U4z3vrNjNbLASYEd3/wGbxscyXZIGe
 vMPkZ8T18bWUC+/C+l5KptgQ3JGdyHfXMyZ+qfP8VDnsWX6sF69U95EavqJQvT+7eHlXSWOaYal
 x3eeh1B1Bu1rIvUWg2RweWnAd+kVbr6PCcufmgk9ZQKIaEE7BaZMsIGdRG61q+2k3UsAaYu8QEC
 XzRgX1sFijDYesZFzr6u14dLKInN1BuiWPEClHwcV+
X-Gm-Gg: ASbGncvsFLLfZQ/0rvitmCR4K1RcAmru5pOnQ3tYiyxMQI4ZuQEHXtLks45YzrHV/2w
 uaXBv43rxAL8TTdyKTlnYJ2TCTRi67d01/B9Jp1ljuoDaX94IWhpzzBMgvdU+h1BBg3DSCFd5il
 aREd3ER062DvSNEunkhIZEJnE6UAErbPaSEw35/iFZvsr/25M77nJVI4hyMujOxC+47qgPYZKLv
 egocJ7biXBoJGCWjpscfZM81XOJT097G+bjTOhfPN//m1nESTyVUCPYEOe+s8GNUBjjLjK/zQGm
 u9CzmGPHduTNfw==
X-Received: by 2002:a17:907:9285:b0:ad8:9257:5735 with SMTP id
 a640c23a62f3a-adb32264a13mr217722366b.3.1748589275270; 
 Fri, 30 May 2025 00:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjB3+8Auapc13zs594lWmagp+0UIBcduuOYVhG6l4Y5KMJkf2ktZKOtqcfjAB32UfyQDPrHQ==
X-Received: by 2002:a17:907:9285:b0:ad8:9257:5735 with SMTP id
 a640c23a62f3a-adb32264a13mr217718666b.3.1748589274772; 
 Fri, 30 May 2025 00:14:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5e8780f5sm276483566b.95.2025.05.30.00.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 41/77] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with GuestPanic
 facility
Date: Fri, 30 May 2025 09:12:11 +0200
Message-ID: <20250530071250.2050910-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility

Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-30-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/run-state.json   | 31 +++++++++++++++++++--
 system/runstate.c     | 65 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.c | 25 ++++++++++++++++-
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index ce95cfa46b7..ee11adc5088 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -501,10 +501,12 @@
 #
 # @s390: s390 guest panic information type (Since: 2.12)
 #
+# @tdx: tdx guest panic information type (Since: 10.1)
+#
 # Since: 2.9
 ##
 { 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v', 's390' ] }
+  'data': [ 'hyper-v', 's390', 'tdx' ] }
 
 ##
 # @GuestPanicInformation:
@@ -519,7 +521,8 @@
  'base': {'type': 'GuestPanicInformationType'},
  'discriminator': 'type',
  'data': {'hyper-v': 'GuestPanicInformationHyperV',
-          's390': 'GuestPanicInformationS390'}}
+          's390': 'GuestPanicInformationS390',
+          'tdx' : 'GuestPanicInformationTdx'}}
 
 ##
 # @GuestPanicInformationHyperV:
@@ -598,6 +601,30 @@
           'psw-addr': 'uint64',
           'reason': 'S390CrashReason'}}
 
+##
+# @GuestPanicInformationTdx:
+#
+# TDX Guest panic information specific to TDX, as specified in the
+# "Guest-Hypervisor Communication Interface (GHCI) Specification",
+# section TDG.VP.VMCALL<ReportFatalError>.
+#
+# @error-code: TD-specific error code
+#
+# @message: Human-readable error message provided by the guest. Not
+#     to be trusted.
+#
+# @gpa: guest-physical address of a page that contains more verbose
+#     error information, as zero-terminated string.  Present when the
+#     "GPA valid" bit (bit 63) is set in @error-code.
+#
+#
+# Since: 10.1
+##
+{'struct': 'GuestPanicInformationTdx',
+ 'data': {'error-code': 'uint32',
+          'message': 'str',
+          '*gpa': 'uint64'}}
+
 ##
 # @MEMORY_FAILURE:
 #
diff --git a/system/runstate.c b/system/runstate.c
index de74d962bca..38900c935a3 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -590,6 +590,58 @@ static void qemu_system_wakeup(void)
     }
 }
 
+static char *tdx_parse_panic_message(char *message)
+{
+    bool printable = false;
+    char *buf = NULL;
+    int len = 0, i;
+
+    /*
+     * Although message is defined as a json string, we shouldn't
+     * unconditionally treat it as is because the guest generated it and
+     * it's not necessarily trustable.
+     */
+    if (message) {
+        /* The caller guarantees the NULL-terminated string. */
+        len = strlen(message);
+
+        printable = len > 0;
+        for (i = 0; i < len; i++) {
+            if (!(0x20 <= message[i] && message[i] <= 0x7e)) {
+                printable = false;
+                break;
+            }
+        }
+    }
+
+    if (len == 0) {
+        buf = g_malloc(1);
+        buf[0] = '\0';
+    } else {
+        if (!printable) {
+            /* 3 = length of "%02x " */
+            buf = g_malloc(len * 3);
+            for (i = 0; i < len; i++) {
+                if (message[i] == '\0') {
+                    break;
+                } else {
+                    sprintf(buf + 3 * i, "%02x ", message[i]);
+                }
+            }
+            if (i > 0) {
+                /* replace the last ' '(space) to NULL */
+                buf[i * 3 - 1] = '\0';
+            } else {
+                buf[0] = '\0';
+            }
+        } else {
+            buf = g_strdup(message);
+        }
+    }
+
+    return buf;
+}
+
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
@@ -631,7 +683,20 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           S390CrashReason_str(info->u.s390.reason),
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
+            char *message = tdx_parse_panic_message(info->u.tdx.message);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "\nTDX guest reports fatal error."
+                          " error code: 0x%" PRIx32 " error message:\"%s\"\n",
+                          info->u.tdx.error_code, message);
+            g_free(message);
+            if (info->u.tdx.gpa != -1ull) {
+                qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
+                              "can be found at gpa page: 0x%" PRIx64 "\n",
+                              info->u.tdx.gpa);
+            }
         }
+
         qapi_free_GuestPanicInformation(info);
     }
 }
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 16ad1af3c5a..ae3740a2305 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "system/ramblock.h"
 
@@ -615,18 +616,35 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
+                                        char *message, uint64_t gpa)
+{
+    GuestPanicInformation *panic_info;
+
+    panic_info = g_new0(GuestPanicInformation, 1);
+    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_TDX;
+    panic_info->u.tdx.error_code = (uint32_t) error_code;
+    panic_info->u.tdx.message = message;
+    panic_info->u.tdx.gpa = gpa;
+
+    qemu_system_guest_panicked(panic_info);
+}
+
 /*
  * Only 8 registers can contain valid ASCII byte stream to form the fatal
  * message, and their sequence is: R14, R15, RBX, RDI, RSI, R8, R9, RDX
  */
 #define TDX_FATAL_MESSAGE_MAX        64
 
+#define TDX_REPORT_FATAL_ERROR_GPA_VALID    BIT_ULL(63)
+
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
 {
     uint64_t error_code = run->system_event.data[R_R12];
     uint64_t reg_mask = run->system_event.data[R_ECX];
     char *message = NULL;
     uint64_t *tmp;
+    uint64_t gpa = -1ull;
 
     if (error_code & 0xffff) {
         error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
@@ -657,7 +675,12 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     }
 #undef COPY_REG
 
-    error_report("TD guest reports fatal error. %s", message ? : "");
+    if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
+        gpa = run->system_event.data[R_R13];
+    }
+
+    tdx_panicked_on_fatal_error(cpu, error_code, message, gpa);
+
     return -1;
 }
 
-- 
2.49.0


