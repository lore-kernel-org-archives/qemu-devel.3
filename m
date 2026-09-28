Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EF7C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0d-0005CX-QZ; Mon, 28 Sep 2026 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0a-0005BJ-B9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0Y-0004Mz-K9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWTp+6K7E/K8crot3KEl7U888+KpjQqgcdT3Duqs7nU=;
 b=WcKt2cbN0R7lL33mjm0o1qUrhdPsoKpeda0R5eT6UbwQikv1IlMJAl6Yc0EV2hWiY/YuPd
 gpCrYH1ELUFSjoWx/vHziIGK9rr4z/wUZPORV+qjSCdkOVVXK3Vjo49CNk3WVBIY0LiXtw
 vinWgjvyrrSNvacbDeAKh887+zEiB/o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-d69LEimPNSOZL17vfBff3g-1; Mon, 28 Sep 2026 09:02:59 -0400
X-MC-Unique: d69LEimPNSOZL17vfBff3g-1
X-Mimecast-MFC-AGG-ID: d69LEimPNSOZL17vfBff3g_1790600578
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c294442d71dso345101766b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600578; x=1791205378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZWTp+6K7E/K8crot3KEl7U888+KpjQqgcdT3Duqs7nU=;
 b=Of0bGMVsT0+C8DWA0Dol+rMLS6ZCUSe9qkz+j8WHsb1FDT/I/ZNKZXnfdtbvOU0E8L
 XT8JjxRvp8VL/Rw305fKKTpnbrgE+CW9f7MfYxntZIPZpf7vDwt5WOWMpExOSHAiJCgg
 /EK1/lW1nuYsfXUPeuukNVzcIkzcDISw+kA6L2mTALVW0LVuMz5pe/XN61SHmKi4Kq/W
 5WOydi8hOVG4PSbieqPPHW2Lf0ipahY32nPifc/LUzliMQr10q0b1jrzilgZ2l0qbo/S
 +Pkr5ddkw1fXDmVfYoX2im1OSQnSqGNqzlRMFNfpC4lM6g76PeZ375uHXToJtqodl/Qv
 Pxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600578; x=1791205378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZWTp+6K7E/K8crot3KEl7U888+KpjQqgcdT3Duqs7nU=;
 b=HOZg06dMMv1z9RIIapgiIt4RZ+BrsuZI1da947TE9H6kGQko+pivoB5b/PMnL68GsY
 tf59f5thjb2hXVnRhn5/ug7ogG8y7K4wjJFQXaBansQLDrdAlM23vvPDTa4Ok9X5Uy4S
 PcGuaUzdwstoQZu25BwaDMl6fAv3eiVv7fQCgXaN/sIzVD8wJWm0pQrGFMUPW2eBWUco
 q4dM5wvlkZdhf4mXX3yyPEVx8hPncmAS56HF1JLq8MUfUb3VcJVdFqwQU8e5l2CfSiqB
 ct6U+V8zAG+OCkB+3TwoiTFwPiKaa6uyJiIe94yjVoGbmvEr/mu+ngMjRqvb35yQbRgy
 Gbag==
X-Gm-Message-State: AFuF++nvmrtjl/HCMZMaaE5QcaZuunMSUeWevzbVMUDf//R7Zn63bfZi
 qx9hxKTQhNFGZdVQbpc1jerT6IuL++VK2UxGZCMMqd9i7g4b3j7CDJrMq6jb2IjVOlyKH5z1yz/
 X9wah0CCaYqxS3i2uAOL8jcbsZ5vB5KKUiBT/+ahKObmUWZ9cWMsZOo7ePk0FwIjai/sd8Rgwel
 BA31q1kU93VF5eyjclGq3OtaBQlkZOAs/kYSRRAizW
X-Gm-Gg: AYBFou1slRBxXlu/KdGqlTXyYPEGon+J57sF4VoaxRaYn4Kf7T4PbZBpBu1fbefVM0+
 jzNElXTbbBgQ/tO3VCOREKntKl+IBNenvTY94+a6oI0+3T1GVeXkDbi1dkW/5rhV1yiHG0Xj1QN
 sujMi+yhU+gBuullYmTyFIZtfJkpVosB+IlHU86Q4VI9dlX4rWvZzOJGeRExSCJ5sXEBwWBkGZK
 6RGeivm5+qWG6xoGdd5RHemYE7DwKaRSAVJUnYpXi4eRxJj3/xMg8za/0DDWeWcL9dnMx56X8MT
 C+LXZTkVwPibcRfL98+1ZEN/kufpfLFWeWVfCpU5pn8DPoqxr6Ncp643Tl/fpwr5oFRt/N78Ezr
 SgEygjybYHLgzKb3fS8f1aqnO4Lz2vSrN5R/2cIZGZ6vREdqpZWk5EtBGZEzFae/zi0EAmT+zYf
 J2bC7T
X-Received: by 2002:a17:907:1c93:b0:c2d:c03d:acaa with SMTP id
 a640c23a62f3a-c2dec6f6cd3mr54625866b.22.1790600578128; 
 Mon, 28 Sep 2026 06:02:58 -0700 (PDT)
X-Received: by 2002:a17:907:1c93:b0:c2d:c03d:acaa with SMTP id
 a640c23a62f3a-c2dec6f6cd3mr54623966b.22.1790600577696; 
 Mon, 28 Sep 2026 06:02:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae7352336sm463905966b.16.2026.09.28.06.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Jordy Zomer <jordyzomer@google.com>
Subject: [PULL 09/30] system: fix buffer overflow in tdx_parse_panic_message
Date: Mon, 28 Sep 2026 15:02:07 +0200
Message-ID: <20260928130228.877003-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Maxim Levitsky <mlevitsk@redhat.com>

tdx_parse_panic_message has code that detects if the guest supplied
message contains some unprintable characters and in this case prints a hex dump.

The code has a bug: it allocates 3 bytes for 'sprintf("%02x ")',
but sprintf in this case actually writes at least 4 bytes, because it adds the NULL
terminator, or even 9 bytes if the char type is signed and the MSB is set.

To fix this, just use qemu_hexdump_line instead.

Reported-by: Jordy Zomer <jordyzomer@google.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3905
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004553.100732-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index d3e64d2b625..56bfc5b07da 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -50,6 +50,7 @@
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
 #include "qemu/thread.h"
+#include "qemu/cutils.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "system/cpu-timers.h"
@@ -760,10 +761,9 @@ static void qemu_system_wakeup(void)
     }
 }
 
-static char *tdx_parse_panic_message(char *message)
+static GString *tdx_parse_panic_message(char *message)
 {
     bool printable = false;
-    char *buf = NULL;
     int len = 0, i;
 
     /*
@@ -784,32 +784,11 @@ static char *tdx_parse_panic_message(char *message)
         }
     }
 
-    if (len == 0) {
-        buf = g_malloc(1);
-        buf[0] = '\0';
+    if (printable) {
+        return g_string_new(message);
     } else {
-        if (!printable) {
-            /* 3 = length of "%02x " */
-            buf = g_malloc(len * 3);
-            for (i = 0; i < len; i++) {
-                if (message[i] == '\0') {
-                    break;
-                } else {
-                    sprintf(buf + 3 * i, "%02x ", message[i]);
-                }
-            }
-            if (i > 0) {
-                /* replace the last ' '(space) to NULL */
-                buf[i * 3 - 1] = '\0';
-            } else {
-                buf[0] = '\0';
-            }
-        } else {
-            buf = g_strdup(message);
-        }
+        return qemu_hexdump_line(NULL, message, len, 1, 0);
     }
-
-    return buf;
 }
 
 void qemu_system_guest_panicked(GuestPanicInformation *info)
@@ -854,12 +833,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
         } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
-            char *message = tdx_parse_panic_message(info->u.tdx.message);
+            g_autoptr(GString) message = tdx_parse_panic_message(info->u.tdx.message);
             qemu_log_mask(LOG_GUEST_ERROR,
                           "\nTDX guest reports fatal error."
                           " error code: 0x%" PRIx32 " error message:\"%s\"\n",
-                          info->u.tdx.error_code, message);
-            g_free(message);
+                          info->u.tdx.error_code, message->str);
             if (info->u.tdx.has_gpa) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
                               "can be found at gpa page: 0x%" PRIx64 "\n",
-- 
2.55.0


