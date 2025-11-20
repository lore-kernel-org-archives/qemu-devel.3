Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C048CF6497
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMX-0003Cr-Di; Wed, 19 Nov 2025 19:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMV-0003CO-9B
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMT-0007Sc-JS
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooMz4PrdRjFfvcta9qVRDqisJIaUtfGy+SneeR0CR/c=;
 b=Uh02OafQEdOhRiBBH0AvN0Yot60t/LND7OfmnzgdM8WOce5hRMT8ySCX4Y+sZwVFaP0hpg
 6TXBpircxm61d038tY+iBOTQ3R4wMGASsW+BsuIouu96mmdDY0zoNA+BhTaNlBsECv3BMD
 rOShmaa2kpu/2IuqXJgdVj920t5hzKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-TP2Np0ocNmCVkN4zHUrrmQ-1; Wed, 19 Nov 2025 19:17:16 -0500
X-MC-Unique: TP2Np0ocNmCVkN4zHUrrmQ-1
X-Mimecast-MFC-AGG-ID: TP2Np0ocNmCVkN4zHUrrmQ_1763597835
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47754e6bddbso1808335e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597835; x=1764202635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ooMz4PrdRjFfvcta9qVRDqisJIaUtfGy+SneeR0CR/c=;
 b=nhmzj+/rLgWjvuq+yoYcXhJsvkF639CU60ozSdwYUBILL0/XBOZ7abQHWXH2tnbAOk
 w85UKMTY+w8S4EUiQ0T20ynvxCWSIz2mMbDYYCcFyPDk3f0JGvpVeXq0/7QQkxO6poYt
 G+O8UaB8yoTfDuIcQIsfx8vTsR2NQ1w/xss67awbGocpd0OgJ23wJqcfeQacajyv0YOT
 +JDELYkPPedtZ3Rt9F1+ByApXi03q1o21dMWFQc0SFrzrP6imvesrzbDCQV5UhyakFmE
 1kzP/cS9UJI6HA+It8Pw++H/cJhQ6wUZcLcJ05za5+qaZ4cByJ8TO5EXJMxBM+UNThAC
 BM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597835; x=1764202635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ooMz4PrdRjFfvcta9qVRDqisJIaUtfGy+SneeR0CR/c=;
 b=bds4Cn6Q5ZgsFqxTqniJiSsK9yTP55jcNWOJKNtvPuF31PvfDoLRxQbN+ztg3ejHG9
 Pbna+Fq2IsXA9slnTkrlx3doG7jRiSFobP59HIBRnkXPQ82r4BjU7FpkXVhXM5GWd7p2
 fw2S7QHfbgOmKy5Oluc8vqBoUkd2RQ6OpcP5im7xOLC0jPy4W8ecX7ACtvFrgHFEmAwO
 wyYuJDDYfRbqNeCLmtm01XsVNLG5TsLad2qeoqBbzjI/idUUSFPgCrk3UOzKmt8R2KhX
 pLWNH/TrUl/p3WgmfVQ3Z3vkCIeKErDWkP6JinsuEWGLGugpiqP2upaXi/4eZx7PnAMw
 VgSw==
X-Gm-Message-State: AOJu0YydpVsYDjsOPcsz6RucjoeTZRsag7CTeoDzFguAEHbukZVcxZOi
 MvxyhOZmbbnzRSaO3dXMPVAnAwXfTRJPXqQ87cXOz6VJGVpLY2/h/GEhdCog1UdOTmRf9+UEXwN
 4UZ3uPgkyasRXq3W228xifPKqg3kWCzF4bJeMly5a6ybvSdc5aCRnuDYTM9h+SCTLyf8vnfgOv2
 PhUHCu2XlrHfsOHEZ2Dh8zT8AgdSoRDf6KbXz7uZzh
X-Gm-Gg: ASbGnctI+4g8hue1SCMi8GoiNrC6jmutjvMGTgM9VtyMvfDP5vOcXKWT47p+llHwHcG
 blDlzzyaWwvStDOPg2TVqdJOs+YL60ueO8PKAPiX+tu51ehAj0XNxHvNJv8EhNUoeKJ4WXFjYSL
 Sd9lIPy+tPRoJXgG3PkPomyWjaeU2e9DaUY9zQGXHn/MQ3mTFup9fpnk9tp3Hec/9fkkEYZJXSB
 qb8R3nWrRn+E816qVLkqxNEH/G+RYh/4hGvM5pcyFN5+uCWlG+yhdn2OBaeIKRRlTksHXi6NlEc
 GyhtSe/v9onvyzd/RIfEs9ZwWyzGA+zag2OeMkygw7TO2sojjAnLwpQfQsxuRB/55GD9iGnJ8ec
 UO2MfQkxT8cUlZ/+DCm2iNiLR+2XX1j1q+mhQzJx5nVHFvqhHVvPTcL+nKysPvrhz3Tp9c2b0hr
 Ops7EKIVt1lzs6qBs=
X-Received: by 2002:a05:600c:c4b7:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-477b8a8a540mr10184685e9.17.1763597834703; 
 Wed, 19 Nov 2025 16:17:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtcOgkrvdBo25XbutC8v5nEhUCv2A8hluiiN5SibaKQFPhv0Nl/MllGBo+QGXOnAq3xBX6XA==
X-Received: by 2002:a05:600c:c4b7:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-477b8a8a540mr10184605e9.17.1763597834250; 
 Wed, 19 Nov 2025 16:17:14 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b831ad9dsm16388175e9.13.2025.11.19.16.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:17:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] replay: add tracing events
Date: Thu, 20 Nov 2025 01:16:49 +0100
Message-ID: <20251120001649.1085913-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The replay subsystem does not provide any way to see what's going on
and how the replay events interleave with other things happening in QEMU.

Add trace events to improve debuggability; to avoid having too many
events reimplement all functions in terms of (non-traced) replay_getc
and replay_putc and add a single trace event for each datum that is
extracted or written.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build              |  1 +
 replay/trace.h           |  1 +
 replay/replay-internal.c | 70 ++++++++++++++++++++++++++++++----------
 replay/trace-events      | 12 +++++++
 4 files changed, 67 insertions(+), 17 deletions(-)
 create mode 100644 replay/trace.h
 create mode 100644 replay/trace-events

diff --git a/meson.build b/meson.build
index df4460035c3..95fcec9ba15 100644
--- a/meson.build
+++ b/meson.build
@@ -3678,6 +3678,7 @@ if have_system
     'hw/gpio',
     'migration',
     'net',
+    'replay',
     'system',
     'ui',
     'hw/remote',
diff --git a/replay/trace.h b/replay/trace.h
new file mode 100644
index 00000000000..39ff481742e
--- /dev/null
+++ b/replay/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-replay.h"
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index c2a7200339f..4839f2b6321 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -15,6 +15,7 @@
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "trace.h"
 
 /* Mutex to protect reading and writing events to the log.
    data_kind and has_unread_data are also protected
@@ -44,7 +45,7 @@ static void replay_read_error(void)
     exit(1);
 }
 
-void replay_put_byte(uint8_t byte)
+static void replay_putc(uint8_t byte)
 {
     if (replay_file) {
         if (putc(byte, replay_file) == EOF) {
@@ -53,29 +54,45 @@ void replay_put_byte(uint8_t byte)
     }
 }
 
+void replay_put_byte(uint8_t byte)
+{
+    trace_replay_put_byte(byte);
+    replay_putc(byte);
+}
+
 void replay_put_event(uint8_t event)
 {
+    trace_replay_put_event(event);
     assert(event < EVENT_COUNT);
-    replay_put_byte(event);
+    replay_putc(event);
 }
 
 
 void replay_put_word(uint16_t word)
 {
-    replay_put_byte(word >> 8);
-    replay_put_byte(word);
+    trace_replay_put_word(word);
+    replay_putc(word >> 8);
+    replay_putc(word);
 }
 
 void replay_put_dword(uint32_t dword)
 {
-    replay_put_word(dword >> 16);
-    replay_put_word(dword);
+    int i;
+
+    trace_replay_put_dword(dword);
+    for (i = 24; i >= 0; i -= 8) {
+        replay_putc(dword >> i);
+    }
 }
 
 void replay_put_qword(int64_t qword)
 {
-    replay_put_dword(qword >> 32);
-    replay_put_dword(qword);
+    int i;
+
+    trace_replay_put_qword(qword);
+    for (i = 56; i >= 0; i -= 8) {
+        replay_putc(qword >> i);
+    }
 }
 
 void replay_put_array(const uint8_t *buf, size_t size)
@@ -88,7 +105,7 @@ void replay_put_array(const uint8_t *buf, size_t size)
     }
 }
 
-uint8_t replay_get_byte(void)
+static uint8_t replay_getc(void)
 {
     uint8_t byte = 0;
     if (replay_file) {
@@ -101,36 +118,52 @@ uint8_t replay_get_byte(void)
     return byte;
 }
 
+uint8_t replay_get_byte(void)
+{
+    uint8_t byte = replay_getc();
+    trace_replay_get_byte(byte);
+    return byte;
+}
+
 uint16_t replay_get_word(void)
 {
     uint16_t word = 0;
     if (replay_file) {
-        word = replay_get_byte();
-        word = (word << 8) + replay_get_byte();
+        word = replay_getc();
+        word = (word << 8) + replay_getc();
     }
 
+    trace_replay_get_word(word);
     return word;
 }
 
 uint32_t replay_get_dword(void)
 {
     uint32_t dword = 0;
+    int i;
+
     if (replay_file) {
-        dword = replay_get_word();
-        dword = (dword << 16) + replay_get_word();
+        for (i = 24; i >= 0; i -= 8) {
+            dword |= replay_getc() << i;
+        }
     }
 
+    trace_replay_get_dword(dword);
     return dword;
 }
 
 int64_t replay_get_qword(void)
 {
-    int64_t qword = 0;
+    uint64_t qword = 0;
+    int i;
+
     if (replay_file) {
-        qword = replay_get_dword();
-        qword = (qword << 32) + replay_get_dword();
+        for (i = 56; i >= 0; i -= 8) {
+            qword |= (uint64_t)replay_getc() << i;
+        }
     }
 
+    trace_replay_get_qword(qword);
     return qword;
 }
 
@@ -172,10 +205,12 @@ void replay_check_error(void)
 
 void replay_fetch_data_kind(void)
 {
+    trace_replay_fetch_data_kind();
     if (replay_file) {
         if (!replay_state.has_unread_data) {
-            replay_state.data_kind = replay_get_byte();
+            replay_state.data_kind = replay_getc();
             replay_state.current_event++;
+            trace_replay_get_event(replay_state.current_event, replay_state.data_kind);
             if (replay_state.data_kind == EVENT_INSTRUCTION) {
                 replay_state.instruction_count = replay_get_dword();
             }
@@ -246,6 +281,7 @@ void replay_advance_current_icount(uint64_t current_icount)
     int diff = (int)(current_icount - replay_state.current_icount);
 
     /* Time can only go forward */
+    trace_replay_advance_current_icount(replay_state.current_icount, diff);
     assert(diff >= 0);
 
     if (replay_mode == REPLAY_MODE_RECORD) {
diff --git a/replay/trace-events b/replay/trace-events
new file mode 100644
index 00000000000..e9c887a6c57
--- /dev/null
+++ b/replay/trace-events
@@ -0,0 +1,12 @@
+replay_put_byte(uint8_t event) "%02x"
+replay_put_event(uint8_t event) "%02x"
+replay_put_word(uint16_t event) "%04x"
+replay_put_dword(uint32_t event) "%08x"
+replay_put_qword(uint64_t event) "%016" PRIx64
+replay_get_byte(uint8_t byte) "%02x"
+replay_get_word(uint16_t word) "%04x"
+replay_get_dword(uint32_t dword) "%08x"
+replay_get_qword(uint64_t qword) "%016" PRIx64
+replay_fetch_data_kind(void) ""
+replay_get_event(uint32_t current, uint8_t data) "#%u data=%02x"
+replay_advance_current_icount(uint64_t current_icount, int diff) "current=%" PRIu64 " diff=%d"
-- 
2.51.1


