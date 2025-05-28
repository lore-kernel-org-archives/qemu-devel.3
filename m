Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E81EC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKMPb-0002tC-2Y; Wed, 28 May 2025 15:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uKMPX-0002sD-3P
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:25:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uKMPR-0007qE-HH
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:25:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2349282084bso2643885ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748460346; x=1749065146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p8XQsIys0bjXBF6Rjgp0AQXhuEMtKRZMh2pOpwp/DPs=;
 b=C/JBq3XRT4S52D3vl3/LxyJA1bqqxvr8T5HBSZODVM6SV0LlQ8JHwKqVAJdCqvAgbT
 10EPuYZRoY/kG2fFkV5dEOz0N+IkFa/cPqFfLykgD8Q5cRbYhZQGoRWjMXIOyJfkZGT4
 S4+7/aT2S5kVNG2T1lcn6T06gDSHriG8d3KD4+TDjheK2D2MXt5Z1wcaE5Efg8HWZZ6K
 IzAAv6IqRLh9HyOBYLiB4+MNdV7ndYUisM6gQrKIWeiRtHoovqe/dI4sd3Bw2TB/30wL
 pMcXFuZL2cZ5u3A/Xo21vZ6SMIKyU+EtLm4hw+AAsNaLXwuc56QQ7JOd8hWc3Hew2F40
 kMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748460346; x=1749065146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8XQsIys0bjXBF6Rjgp0AQXhuEMtKRZMh2pOpwp/DPs=;
 b=l9s3gKZvqC44i75Ql4URbvhSyhcN3ZuVgnvJlBn4Fk0qaETf74McrARVAHVZ07i6QE
 v8sIt3XyFmOAS6rDRIg2iov+C7noUw+xvL0Hk2xCDZzgnOmd7/idZDb7NAUhId4Ki5Lo
 94lQfPsoXhVZTTzNnmCbZr8NRyopS4F3J6yVUpk2eiTPlacrnrohg+7KflW5JAfsxeBX
 4hkkz21fqU/32dCSfgiwF4Jjp2veoVQebgoYcAd3U4Trh6/kgEMes/oFQebU9iHgx58A
 iGS/jQNf3IqROPsaYvKsixKBqYl7S2qOhmOTNMtgN7CYzkCBEYcU5azYxX1UxkM3Pg5X
 CQag==
X-Gm-Message-State: AOJu0YwAfnWZM3LRu50KCzdqAfmE/1VKc7pgEu0RSvIgrNlA2iZEzu3k
 5Kvz064maYCdhRee+Yox5RJm/7J/Poh8dIXiirMtMk9nuRe/1svJZj3yZnN/3eCQJphX0g==
X-Gm-Gg: ASbGnct7L6vFjE7Y9fC7Wn+t/gtyWKAKcKMlkV0tGYEcX0NrdokMG0o9ZgGY29df9TT
 PnjFfEYKOfDfvGJ5eTQ0KKfZkHp35WWpcQuWzxnLrguh/FYdqwyisrI0xjIvx3svHRUJVG0KIsl
 HCX5Gs4bjh2y8h+akjnRZUnCMXWqptSAKWlT6d4rjaFu8BozNc0KiTM3X0EaKW7NfsxykNUaYo8
 RpYX3LNcsWIIiVdiLD7fWh2gv/lT7IAaFsBbsKKcQOKxZh8XZ1OCkIRdgQLISrmcY/gUA+9FXp5
 WYgEQNH15ZFAeku3qvMOybsnE1Uw8DL8DOXhhWsnO3cxIZ1H1p0SUR3fk6aEaQ==
X-Google-Smtp-Source: AGHT+IGWap/Yd0Jj7I4I6jYJ8OdX5B9WHnbpr2XZCTR1PPXgPjGTfURdBjfUbAYuOsu/ZWNucRS5vg==
X-Received: by 2002:a17:902:f645:b0:234:c5c1:9b84 with SMTP id
 d9443c01a7336-234c5d0e07emr62053125ad.37.1748460346383; 
 Wed, 28 May 2025 12:25:46 -0700 (PDT)
Received: from ubuntu.. ([49.207.62.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-234d2fd22d4sm15522765ad.4.2025.05.28.12.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 12:25:45 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, mads@ynddal.dk,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH] trace/simple: seperate hot paths of tracing fucntions
Date: Wed, 28 May 2025 19:25:28 +0000
Message-Id: <20250528192528.3968-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This change improves performance by moving the hot path of the trace_vhost_commit()(or any other trace function) logic to the header file.
Previously, even when the trace event was disabled, the function call chain:-
	trace_vhost_commit()(Or any other trace function) →  _nocheck__trace_vhost_commit() →  _simple_trace_vhost_commit()
	incurred a significant function prologue overhead before checking the trace state.

Disassembly of _simple_trace_vhost_commit() (from the .c file) showed that 11 out of the first 14 instructions were prologue-related, including:
0x10	stp x29, x30, [sp, #-64]!	Prologue: allocates 64-byte frame and saves old FP (x29) & LR (x30)
0x14	adrp x3, trace_events_enabled_count	Prologue: computes page-base of the trace-enable counter
0x18	adrp x2, __stack_chk_guard	Important (maybe prolog don't know?)(stack-protector): starts up the stack-canary load
0x1c	mov x29, sp	Prologue: sets new frame pointer
0x20	ldr x3, [x3]	Prologue: loads the actual trace-enabled count
0x24	stp x19, x20, [sp, #16]	Prologue: spills callee-saved regs used by this function (x19, x20)
0x28	and w20, w0, #0xff	Tracepoint setup: extracts the low-8 bits of arg0 as the “event boolean”
0x2c	ldr x2, [x2]	Prologue (cont’d): completes loading of the stack-canary value
0x30	and w19, w1, #0xff	Tracepoint setup: extracts low-8 bits of arg1
0x34	ldr w0, [x3]	Important: loads the current trace-enabled flag from memory
0x38	ldr x1, [x2]	Prologue (cont’d): reads the canary
0x3c	str x1, [sp, #56]	Prologue (cont’d): writes the canary into the new frame
0x40	mov x1, #0	Prologue (cont’d): zeroes out x1 for the upcoming branch test
0x44	cbnz w0, 0x88	Important: if tracing is disabled (w0==0) skip the heavy path entirely

The trace-enabled check happens after the prologue. This is wasteful when tracing is disabled, which is often the case in production.
To optimize this:
_nocheck__trace_vhost_commit() is now fully inlined in the .h file with
the hot path.It checks trace_event_get_state() before calling into _simple_trace_vhost_commit(), which remains in .c.
This avoids calling into the .c function altogether when the tracepoint is disabled, thereby skipping unnecessary prologue instructions.

This results in better performance by removing redundant instructions in the tracing fast path.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/simple.py | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index a74d61fcd6..2688d4b64b 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -36,8 +36,17 @@ def generate_h_begin(events, group):
 
 
 def generate_h(event, group):
-    out('    _simple_%(api)s(%(args)s);',
+    event_id = 'TRACE_' + event.name.upper()
+    if "vcpu" in event.properties:
+        # already checked on the generic format code
+        cond = "true"
+    else:
+        cond = "trace_event_get_state(%s)" % event_id
+    out('    if (%(cond)s) {',
+        '        _simple_%(api)s(%(args)s);',
+        '    }',
         api=event.api(),
+        cond=cond,
         args=", ".join(event.args.names()))
 
 
@@ -72,22 +81,10 @@ def generate_c(event, group):
     if len(event.args) == 0:
         sizestr = '0'
 
-    event_id = 'TRACE_' + event.name.upper()
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % event_id
-
     out('',
-        '    if (!%(cond)s) {',
-        '        return;',
-        '    }',
-        '',
         '    if (trace_record_start(&rec, %(event_obj)s.id, %(size_str)s)) {',
         '        return; /* Trace Buffer Full, Event Dropped ! */',
         '    }',
-        cond=cond,
         event_obj=event.api(event.QEMU_EVENT),
         size_str=sizestr)
 
-- 
2.34.1


