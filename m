Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F04CEE339
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOWB-0004Zn-9e; Tue, 18 Nov 2025 11:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLOW9-0004ZL-Ps
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLOW7-0007J9-LY
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763483118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PDT+l/dN7ross2kmxKtQCUOge2vHNUeprysafZ46yXY=;
 b=CQoywJw1YP2wFLZj+NSSfpT7UgQI9TQIMFcLs+5RcV0ru6LKEiU1IPaWh47N8v6hm3yQcy
 Ccv+upd8MfSWlG4GdgF+o3J2gg8oMd0fPfCLS707Exx6w6Asi+zCwDAvQ0UGdQut+LweiU
 TPQc1DkWKVJP37NyrcS3SvMPS0qhQIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Vq7AXAigOpGdbZz3YGXHuw-1; Tue, 18 Nov 2025 11:25:17 -0500
X-MC-Unique: Vq7AXAigOpGdbZz3YGXHuw-1
X-Mimecast-MFC-AGG-ID: Vq7AXAigOpGdbZz3YGXHuw_1763483116
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so26870695e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763483115; x=1764087915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PDT+l/dN7ross2kmxKtQCUOge2vHNUeprysafZ46yXY=;
 b=kqFM+Z5FqRy/89OTwOIj79fEouJGR5miYsrCjeprSMBRu+W12muwl4Fx2UzJ8P9OjO
 JcBs2eyqMfANkBu0ooF39jjPgDIFqTu060xdnDmtQ4vnEB2hdPK6hsVHakD7NgC8+BG5
 MqnKfaElU6nUwIP3/un4U1/sQzkXiwrRr2uaxjt+ZrlxPMQD9JETnFY2dDri1IT60B0d
 jIFf6tW+P0Jgd5hjGk+Cf1HRZbAfBjq6jDDj9w9/BUfwjepvygSkh+F86izirL37P7P9
 zI2aNxboLF+MYojmWlC5F0EDVOtGrtA4lNfVxr7DlMTc3+Vx72vq0BqWDgi3SONlDDnm
 cl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763483115; x=1764087915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PDT+l/dN7ross2kmxKtQCUOge2vHNUeprysafZ46yXY=;
 b=goSx25zBokwbB8lD5RQwqP/nf2/JidmeR1uynER2DhXsNzFCwWwsqX9ay4J5tQAuG+
 yF8DoyCdBwO2Y40d+Iq+uyunrGLWH4S7rUW53IX69Yi+1vwGN4TcYLo8YmuDCMWDJCpF
 HOkJj3udKDnobSLTG8v3aSrrq4aZOuJXafMCqiKUJik8+RuO2PFkST1dAPwMU7gcCSnB
 TvEv20axOYvi4iRGavxpKMV1NLK+V8hfQNr8Ic5Nis0UqvxyhtKhBobNn5hvGf8/mUFt
 /3rJQaq7aoeATOTytt2ZEygo/myqkizw1gqwIySMRwuQuCkk++dm2InADHsG0vgS+Bp3
 xLJg==
X-Gm-Message-State: AOJu0YxugbadPilifO4CXRlpCCDlzwM65fSOpcKnUOYX+OC6Qhar9C7g
 Wv3F8G5LbOsAebzYLRv2XnqPBNp8FVoqbH5svKV9RVS8K0bJA2PRtwz+y7XqZsTk98/W77b0tid
 /4eqYWZKt/EEsTNf7mhiuIP0mtuQ0VfaI6hUFiFvYVUAIaqLBAit8jEPkXV4cVVzjk1nCwDxG9T
 TrBrvHQrYnIHEH1Gm6p9Vo3GXLLXQqtw2Bue8PSJgY
X-Gm-Gg: ASbGncscC8/Q6tKvVpcilAnL/KAJ2KEwK5ooz5vGT1aGt5PwIqa2uF2nzkdTOe77LOa
 oK+gXK8RhjQt70hIBrkhd9WCEJyI0cIhbu+yS2Vynv7p3NAnGwlD7rhenZ6YW63LGNVq8mICKWJ
 cp/tzy63S8LDnNp8Yq+2/twnEyQWGl85qjn1YShHQKSuwP506nuNg2tpu0g8F1hP0EBOZ6RiSeR
 ZfOAWJYboa1ITs1QV3SAnnopsbiT6gMym67FcCg85pvcaedITEf5B5jpDACmXNbJEfuAGmReTtT
 pyPRQgwhWpMHzcquEde7dboM731h53+gyM17Y5/3YrrE5lrbE7vfGt7Pjl947FXuY4jr/cVb+At
 9Dxu7jE0ud2vcqp7wakViqHCrrGKViPb5WzXNBAI3+OIDCgPRenh9dXcTIUgGgKQJiLxvx+D6jc
 wgkNx9zZUpafps344=
X-Received: by 2002:a05:600c:4443:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-477b0ca2fa5mr952555e9.8.1763483115377; 
 Tue, 18 Nov 2025 08:25:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbxg1jjiUEw5pfnwWlD+xqblmHTJ5gYnjJZBwX8EClpLr/2Y1MbFPzx9oNRXFo7EfkoSD0Dw==
X-Received: by 2002:a05:600c:4443:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-477b0ca2fa5mr952275e9.8.1763483114885; 
 Tue, 18 Nov 2025 08:25:14 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779973ddcfsm194463255e9.15.2025.11.18.08.25.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 08:25:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] replay: add tracing events
Date: Tue, 18 Nov 2025 17:25:12 +0100
Message-ID: <20251118162513.730659-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
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

The replay subsystem does not have any way to see what's going on and
how the replay events interleave with other things happening in QEMU.

Add trace events to improve debuggability; to avoid having too many
events reimplement all functions in terms of (non-traced)
replay_getc and replay_putc and add a single trace event for each
datum that is extracted or written.

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


