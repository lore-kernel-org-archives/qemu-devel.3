Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF10E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 20:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLT9m-0007LD-U7; Wed, 11 Dec 2024 15:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9f-0007KU-GD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9d-0004DM-Ut
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733948272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFXaLF/2fvXDkwgl6NvuvEBWo6+E26Pv3ho2hdhkbGU=;
 b=ZsGuV4B7jh1AVni8bwF12m27K610qDHON8V2YGaghYVQRSWh0shJ6HdNpDoSd6o9OVUvIU
 ylXV4tTl39+iDHVbzfNRCogi+gK9WHGCr0iVMurewqe+LMrU+2/d6cZr3JJYRZx2dyTV1r
 PoNhmyc2xV6sJzKTKdx//fyqSIuB2gM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-eSoyn-cANIG4Id7V6XMU6Q-1; Wed, 11 Dec 2024 15:17:49 -0500
X-MC-Unique: eSoyn-cANIG4Id7V6XMU6Q-1
X-Mimecast-MFC-AGG-ID: eSoyn-cANIG4Id7V6XMU6Q
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e9fb0436so500882285a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 12:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733948268; x=1734553068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFXaLF/2fvXDkwgl6NvuvEBWo6+E26Pv3ho2hdhkbGU=;
 b=BHpXD6p81li73bhDYP6EZfwDr4q+lQzRYe7WU6mR6He8YBYBQISen9un0B2Uq9pqYO
 nrnxbISs5UpEqA7+CrGmRrSFgp6UxtimISD/K5btbNLt2zaigtxi+I+b4xZt0j4BRsc3
 1V1eaTDslrE1JMvyz0XmI2Lxewnoi27+wEUIsoYFDSmMeYubk4RhuuhSeEpwwJKjehHR
 JWTTkrWlvlLv0awonpNzHtOGQ2KWyi2xeyTZTO2CgJhqU28JIgGmSRVUtx833qjIVuAP
 ByYy0czl7XBnHa+28+1ruOnsEbwqi0K+QJtIjm/cCFcgw5H/joxRzba+o0acu3p/7J5k
 Mwow==
X-Gm-Message-State: AOJu0YxCFUgj9EIa0hVEXx8aLFXtPtVwADlmnLR8/uQD+Ty9T225w6Ez
 Y6b1KDqv1S2VvHycuEvUiGqyRZI1CjwZUvFN0RSWANyr+LzO17U59B1UtnE0+OWzfE6tkgBUQw0
 dkF8DRfw9tWFO6cO8hm8sV4VeyksEEEhSo/0pZiY1eCysKjs/5bHuAtTs3ndWzrxeFj93mz/GDs
 wUjhoufF8zmePrfhrWRdrhxc/Xz8yaHZ7LHw==
X-Gm-Gg: ASbGncso8ZHz4pPxmRbDGgYxOmx+kJUvIMePb6xKw2foYsxBYeD2/yA0h/9H9biMhCQ
 v4l21T6QvCvkg0qIWuC+BG74h2ToeS0fzj8PKPKox2n0AukadSUtb0uRMF95679EVaUeI60RjKl
 BdwfeRT27PqNgIg3uZgrDeyhIXa0vBls2gI7cf6kZL00KXCzyt+BuhGJt1Ryl4E0xAcN5odqlxS
 mg5/+AjasDq1e4fyj5D0lRGfsXLne34/pu/pY52ZYo5wh8a60VILYv5m8fz1ty6ctjnzaZiHK9D
 CBS0h3ua51SkAdU3pamBq1hBcO0LFg==
X-Received: by 2002:a05:620a:2694:b0:7b6:6a3b:539b with SMTP id
 af79cd13be357-7b6f2542a96mr117636385a.17.1733948267965; 
 Wed, 11 Dec 2024 12:17:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmqcZWSZ4uS9cn/ekqKSkDSEDhi2uJtBuXlmrpWWP4T6hSQUf3P3dkJcxTfZMEOcYoWhOJNA==
X-Received: by 2002:a05:620a:2694:b0:7b6:6a3b:539b with SMTP id
 af79cd13be357-7b6f2542a96mr117632585a.17.1733948267602; 
 Wed, 11 Dec 2024 12:17:47 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6c8c6425csm438857485a.100.2024.12.11.12.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 12:17:46 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 3/3] scripts/qemu-gdb: Support coroutine dumps in coredumps
Date: Wed, 11 Dec 2024 15:17:39 -0500
Message-ID: <20241211201739.1380222-4-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211201739.1380222-1-peterx@redhat.com>
References: <20241211201739.1380222-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Dumping coroutines don't yet work with coredumps.  Let's make it work.

We still kept most of the old code because they can be either more
flexible, or prettier.  Only add the fallbacks when they stop working.

Currently the raw unwind is pretty ugly, but it works, like this:

(gdb) qemu bt
Coroutine at 0x7fc474728748:

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/qemugdb/coroutine.py | 50 +++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 20f76ed37b..b29ee16205 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -46,9 +46,30 @@ def get_jmpbuf_regs(jmpbuf):
         'r15': jmpbuf[JB_R15],
         'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
 
-def bt_jmpbuf(jmpbuf):
-    '''Backtrace a jmpbuf'''
-    regs = get_jmpbuf_regs(jmpbuf)
+def symbol_lookup(addr):
+    # Example: "__clone3 + 44 in section .text of /lib64/libc.so.6"
+    result = gdb.execute(f"info symbol {hex(addr)}", to_string=True).strip()
+    return result.split(" in ")[0]
+
+def dump_backtrace(regs):
+    '''
+    Backtrace dump with raw registers, mimic GDB command 'bt'.
+    '''
+    # Here only rbp and rip that matter..
+    rbp = regs['rbp']
+    rip = regs['rip']
+    i = 0
+
+    while rbp:
+        print(f"#{i}\t{symbol_lookup(rip)}")
+        rip = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)} + 8)")
+        rbp = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)})")
+        i += 1
+
+def dump_backtrace_live(regs):
+    '''
+    Backtrace dump with gdb's 'bt' command, only usable in a live session.
+    '''
     old = dict()
 
     # remember current stack frame and select the topmost
@@ -69,6 +90,17 @@ def bt_jmpbuf(jmpbuf):
 
     selected_frame.select()
 
+def bt_jmpbuf(jmpbuf):
+    '''Backtrace a jmpbuf'''
+    regs = get_jmpbuf_regs(jmpbuf)
+    try:
+        # This reuses gdb's "bt" command, which can be slightly prettier
+        # but only works with live sessions.
+        dump_backtrace_live(regs)
+    except:
+        # If above doesn't work, fallback to poor man's unwind
+        dump_backtrace(regs)
+
 def co_cast(co):
     return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
 
@@ -101,10 +133,14 @@ def invoke(self, arg, from_tty):
 
         gdb.execute("bt")
 
-        if gdb.parse_and_eval("qemu_in_coroutine()") == False:
-            return
-
-        co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
+        try:
+            # This only works with a live session
+            co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
+            if co_ptr == False:
+                return
+        except:
+            # Fallback to use hard-coded ucontext vars if it's coredump
+            co_ptr = gdb.parse_and_eval("co_tls_current")
 
         while True:
             co = co_cast(co_ptr)
-- 
2.47.0


