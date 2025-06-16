Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D3AC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 20:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGCE-0002VN-8n; Mon, 16 Jun 2025 16:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGC7-0002UZ-P7
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:40 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGC5-00074q-M0
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso5359961b3a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750104755; x=1750709555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMLuv2vyspJx1ktef09ky9DNsdcrDZF/n+8r+bXhZTs=;
 b=TVez522h9/Ku2fOmOwg8TEpMl82qpb9x5tJ15ix0PzmAJiIJ3YT3h0X72UUpdSYqV6
 GKJg52plmNegn6Nj5lkitthQGG0WcaF57kg0rzvlqBuC7335moQ2EDZiYFtQkAgLyEJK
 SfYLxFMrEP4Z72/UZNY63zkqBelCMzExAuHRM3Bwu0aO64FSMcit4+CUkgbjt/o41jSS
 gfiFblOqsW1V6HdZA4+83KueadQ2FG6e2To0zVB3ha9xbLOci+XYk/21IEViSBmzv+1n
 ug9BNSfFfyvPFGUalD9Gv6EIFmt5ZBNg1CibBd47BQl2su+VpivfypJ22wx3TJe2wgy6
 4pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750104755; x=1750709555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMLuv2vyspJx1ktef09ky9DNsdcrDZF/n+8r+bXhZTs=;
 b=U03KeyLT1Css34rUUaAQH8NyIEFlDbKBDE+UIGBaBCW/7SiPkC9NrDFTjU/Nt+XgDN
 EWk7ZhIqU0lsCzn0XBSrbAM9uSY7d4CVQEwCpkZ3Rc4YtqsUBREWsfpX7hGcpaCpXSWg
 /J/U0Qt3Ry530RlJb/29hPWnn+DZjKI5l5PIzRW7tiITPlzx28wKP78+13fC8gLQvwzE
 +BrFRVNIyc7zhjV3GVlfTLfxrylKPfA3EapIVbQRQZxMV9tr3XxWmqinUSJgqlZC2HRF
 1eMG6Ccrb0Y83+3qfu9nkAUZcfQkOrNgjfLA5cXm8boOqaDrrLnGw4tjzREzNs7VYTep
 Ou8A==
X-Gm-Message-State: AOJu0YyZ9lOX+NFbLN7JZAfWzutdyhEv9qVFprjEisf1a7YMYImXnkWF
 nb8Bw7CNsIpTF0ebAJLjQj9mpanFijelqPwkaI2k/HHIc/HsKaM6g4JU1TF0ggTkFjksnQ==
X-Gm-Gg: ASbGnctm7gVaxN7n8VxrArn7N4yKzmrWtpjjwP+py63dMOkaNXnvzY4wM5Z5leptvI3
 O61v0CKSSV6+/Eg4ocL2a/HIZLnlHFrOl7ZIHzPb0ActDsAsEsYLK9MltbcQT+8nIjogGO0ug0J
 0pcvoANkDENQCPSEmOYlu5txdXPHhtnREg1DLUYa6i1bdMtza1PY2YHR6aDYhsV7ddKe8+EWLCp
 vSdntnsqYlOj/CsvLD/A2P/e36XcvpQ/kk2BjnKU8rVHQns3iagMKOlSjhLUqZoCNyaRPklaGz8
 4byfuo+mBAFiB5xcoAZ79OywwwQVJFFiz/G+YAweXd5hwjJzOoEbQkFBTugoHxeFCAjCBB4VVX8
 OpFMzVwM5q10D
X-Google-Smtp-Source: AGHT+IHadnjeBaHytxdHlaAAJyLlzEQNf+vnUDIiJhuf8KWg0aTPHDkFbZn20fAEmtl0fLEorIkipA==
X-Received: by 2002:a05:6a20:3ca5:b0:20b:a75e:fa32 with SMTP id
 adf61e73a8af0-21fbd5d2f63mr16670365637.40.1750104755489; 
 Mon, 16 Jun 2025 13:12:35 -0700 (PDT)
Received: from ubuntu.. ([49.207.59.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe1642dfdsm7369494a12.18.2025.06.16.13.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 13:12:35 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 3/3] tracetool: remove redundant event_get_state checks
Date: Mon, 16 Jun 2025 20:12:22 +0000
Message-Id: <20250616201222.6416-4-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616201222.6416-1-tanishdesai37@gmail.com>
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Moved trace_event_get_state check from _no_check_trace_foo to trace_foo, and removed
if (true) checks. The _no_check_trace_foo now only emits backend-specific core
logic, avoiding trace event conditionals entirely.
This brings conditional logic in format/h.py, reducing duplication across
backends and simplifying their code generation. It also removes one conditional
branch instruction from the fast path (trace_foo), improving runtime performance slightly(for some old compiler).
---
 scripts/tracetool/backend/ftrace.py | 3 ---
 scripts/tracetool/backend/log.py    | 5 +----
 scripts/tracetool/backend/simple.py | 7 +------
 scripts/tracetool/backend/syslog.py | 7 +------
 scripts/tracetool/format/h.py       | 3 ++-
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index baed2ae61c..2d6d608add 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -34,18 +34,15 @@ def generate_h(event, group):
         '        char ftrace_buf[MAX_TRACE_STRLEN];',
         '        int unused __attribute__ ((unused));',
         '        int trlen;',
-        '        if (trace_event_get_state(%(event_id)s)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
         '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
         '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
         '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
         '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '        }',
         '    }',
         name=event.name,
         args=event.args,
-        event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         fmt=event.fmt.rstrip("\n"),
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index f24acad74c..35a3aeee55 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -31,9 +31,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
-
-    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
+    out('    if (qemu_loglevel_mask(LOG_TRACE)) {',
         '        if (message_with_timestamp) {',
         '            struct timeval _now;',
         '            gettimeofday(&_now, NULL);',
@@ -49,7 +47,6 @@ def generate_h(event, group):
         '#line %(out_next_lineno)d "%(out_filename)s"',
         '        }',
         '    }',
-        cond=cond,
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         name=event.name,
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 7c84c06b20..ce8036f5da 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -36,13 +36,8 @@ def generate_h_begin(events, group):
 
 
 def generate_h(event, group):
-    event_id = 'TRACE_' + event.name.upper()
-    cond = "trace_event_get_state(%s)" % event_id
-    out('    if (%(cond)s) {',
-        '        _simple_%(api)s(%(args)s);',
-        '    }',
+    out('        _simple_%(api)s(%(args)s);',
         api=event.api(),
-        cond=cond,
         args=", ".join(event.args.names()))
 
 
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 6fdc1142fb..f84cec641c 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -30,14 +30,9 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
-
-    out('    if (%(cond)s) {',
-        '#line %(event_lineno)d "%(event_filename)s"',
+    out('#line %(event_lineno)d "%(event_filename)s"',
         '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '    }',
-        cond=cond,
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         name=event.name,
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 89d54b9aff..7bbe6d3148 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -71,7 +71,8 @@ def generate(events, backend, group):
 
         out('}')
 
-        cond = "true"
+        event_id = 'TRACE_' + e.name.upper()
+        cond = "trace_event_get_state(%s)" % event_id
 
         out('',
             'static inline void %(api)s(%(args)s)',
-- 
2.34.1


