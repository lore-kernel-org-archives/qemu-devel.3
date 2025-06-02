Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD2AC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDf6-0000C1-M7; Mon, 02 Jun 2025 18:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDf5-0000Be-Nw
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDf4-00043z-45
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748903381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3X5wpgZRRfInHdkT5N4NfWas7VyDtR6M7oFpRGeEAE=;
 b=VnbYIvmujMDyBGaPIFHfml8Dwe0Twkje1kjU2dXGYmpN+aeJJKVbfyQhGzr34eGJl2+aXr
 AxAYuxcrBcHTWAFmmwT6gEgSxX55FWRQUQBFnzrVchXrOpleqN6sQRVT4exb7tja0ouAhv
 SlNQFyJvza6/nactzzVBieFLEryb57g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-DN684fXbO5q_ek2IBs9FSg-1; Mon,
 02 Jun 2025 18:29:39 -0400
X-MC-Unique: DN684fXbO5q_ek2IBs9FSg-1
X-Mimecast-MFC-AGG-ID: DN684fXbO5q_ek2IBs9FSg_1748903378
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 130311956095; Mon,  2 Jun 2025 22:29:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.84])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50D9530002C4; Mon,  2 Jun 2025 22:29:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PULL 1/1] trace/simple: seperate hot paths of tracing fucntions
Date: Mon,  2 Jun 2025 18:29:33 -0400
Message-ID: <20250602222933.336883-2-stefanha@redhat.com>
In-Reply-To: <20250602222933.336883-1-stefanha@redhat.com>
References: <20250602222933.336883-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

From: Tanish Desai <tanishdesai37@gmail.com>

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
Message-id: 20250528192528.3968-1-tanishdesai37@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.49.0


