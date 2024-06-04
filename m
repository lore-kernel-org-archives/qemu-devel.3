Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FDBC27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQwW-0008Ol-Vx; Tue, 04 Jun 2024 05:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwV-0008E4-1A
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwR-0002Nd-3T
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42120fc8cbfso41562405e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495133; x=1718099933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VTJJ/3m83pWTt3riL5Bvq0vb1UCAyg2JZO38z+luX4=;
 b=KvpsUzmjeAIsoBkpuFu0LsS9A2O6+YycXDc7FJpCAkAkAPxb8Zl+wJywdqkQCpkSJ6
 NBYEkDHCn95PeK9mi32Y7eFNWMSCc5pLPjB4qbmENOdRM5T55L4TP7PTN6L7S2Zfynvj
 lc4whVD+oAa1A6ifPn8esKu1gp9ktP8567XOsX3D5tbIMCu6gID0sn+jri3LI5os5dvI
 BvVVIW0EZCjUrZrTVahCSoS3RkkLpEw3h5IjWO5AjuQXY8/Dqc4QL9nbgCbzr8FjfB+z
 DaiWmPg+s1WOjbTz53M/DsnKfPlP2wHvTnbOi6DSI2wFgCnYKTyiI/wNnT36NPP7w2SN
 9f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495133; x=1718099933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VTJJ/3m83pWTt3riL5Bvq0vb1UCAyg2JZO38z+luX4=;
 b=LiThmH5aI3AwIbWl54S2kZ1u6j9DBg/30UgJ8fzETfe/1L+/gUqMLY9yyAkeuyjDM0
 WkK7atpiyBpCe3fkM2Ab/mThhv+4woWEm6haEqKb6G74BXCyirH5he9sAUKDiX5p/RY8
 3tb2CT68jW8nwXtKjFuwX4k4lAtnfUeJvBJBaILe5ffX1w/zeowJrWm/p5G0OcjW8/vM
 iAsFj34nprvc1KUG+nbnBzoWsGtnkw78hA63EEMvqTpWge1xkQSkzfwl8kKqJxllWI1T
 XTDBfCLIyOGN5DQLO1GBrmQ9tCE6qlV8VwhXBUJm2VCnUeeATRvdzaerxzG61BOCQfzL
 mvzA==
X-Gm-Message-State: AOJu0YwPfC13Vc/icIq+j2YuILe/wNLAUol0lbQXOLSRb+Qgvd9EQWKz
 ybEa7NVyCQ4VrcrbktYClYik3ff7vMCn7e+X8Tmj/kANf2aKAHXICEhnLeoNKGIpIGmwHuHpqwq
 9
X-Google-Smtp-Source: AGHT+IGAgCk1ZFYpPc2Dl/YiWidc0JYy6Mxgj63pxZhDA+Wefk4eYItmYH6Av1iHM1qW4pxQocE91w==
X-Received: by 2002:a05:600c:5488:b0:421:3464:dc7a with SMTP id
 5b1f17b1804b1-4213464df71mr84635205e9.39.1717495133228; 
 Tue, 04 Jun 2024 02:58:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214a9ff986sm19161995e9.42.2024.06.04.02.58.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 30/32] trace: Remove deprecated 'vcpu' field from QMP trace
 events
Date: Tue,  4 Jun 2024 11:56:06 +0200
Message-ID: <20240604095609.12285-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

'vcpu' fields are deprecated since commit 5485e52a33
("qapi: make the vcpu parameters deprecated for 8.1"),
time to remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240530071548.20074-3-philmd@linaro.org>
---
 docs/about/deprecated.rst       | 11 -----------
 docs/about/removed-features.rst |  6 ++++++
 qapi/trace.json                 | 27 +++------------------------
 trace/qmp.c                     |  2 --
 trace/trace-hmp-cmds.c          |  4 ++--
 5 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a61894db6..187c8a3f97 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -148,17 +148,6 @@ accepted incorrect commands will return an error. Users should make sure that
 all arguments passed to ``device_add`` are consistent with the documented
 property types.
 
-QEMU Machine Protocol (QMP) events
-----------------------------------
-
-``vcpu`` trace events (since 8.1)
-'''''''''''''''''''''''''''''''''
-
-The ability to instrument QEMU helper functions with vCPU-aware trace
-points was removed in 7.0. However QMP still exposed the vcpu
-parameter. This argument has now been deprecated and the remaining
-remaining trace points that used it are selected just by name.
-
 Host Architectures
 ------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f1e70263e2..1e64c27cd8 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -679,6 +679,12 @@ QEMU Machine Protocol (QMP) events
 
 MEM_UNPLUG_ERROR has been replaced by the more generic ``DEVICE_UNPLUG_GUEST_ERROR`` event.
 
+``vcpu`` trace events (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''
+
+The ability to instrument QEMU helper functions with vCPU-aware trace
+points was removed in 7.0.
+
 
 Human Monitor Protocol (HMP) commands
 -------------------------------------
diff --git a/qapi/trace.json b/qapi/trace.json
index 043d12f83e..9ebb6d9eaf 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -35,17 +35,10 @@
 #
 # @state: Tracing state.
 #
-# @vcpu: Whether this is a per-vCPU event (since 2.7).
-#
-# Features:
-#
-# @deprecated: Member @vcpu is deprecated, and always ignored.
-#
 # Since: 2.2
 ##
 { 'struct': 'TraceEventInfo',
-  'data': {'name': 'str', 'state': 'TraceEventState',
-           'vcpu': { 'type': 'bool', 'features': ['deprecated'] } } }
+  'data': {'name': 'str', 'state': 'TraceEventState' } }
 
 ##
 # @trace-event-get-state:
@@ -54,12 +47,6 @@
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-# @vcpu: The vCPU to query (since 2.7).
-#
-# Features:
-#
-# @deprecated: Member @vcpu is deprecated, and always ignored.
-#
 # Returns: a list of @TraceEventInfo for the matching events
 #
 # Since: 2.2
@@ -71,8 +58,7 @@
 #     <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
 ##
 { 'command': 'trace-event-get-state',
-  'data': {'name': 'str',
-           '*vcpu': {'type': 'int', 'features': ['deprecated'] } },
+  'data': {'name': 'str' },
   'returns': ['TraceEventInfo'] }
 
 ##
@@ -86,12 +72,6 @@
 #
 # @ignore-unavailable: Do not match unavailable events with @name.
 #
-# @vcpu: The vCPU to act upon (all by default; since 2.7).
-#
-# Features:
-#
-# @deprecated: Member @vcpu is deprecated, and always ignored.
-#
 # Since: 2.2
 #
 # Example:
@@ -101,5 +81,4 @@
 #     <- { "return": {} }
 ##
 { 'command': 'trace-event-set-state',
-  'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool',
-           '*vcpu': {'type': 'int', 'features': ['deprecated'] } } }
+  'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool' } }
diff --git a/trace/qmp.c b/trace/qmp.c
index 3e3971c6a8..074a27b204 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -48,7 +48,6 @@ static bool check_events(bool ignore_unavailable, bool is_pattern,
 }
 
 TraceEventInfoList *qmp_trace_event_get_state(const char *name,
-                                              bool has_vcpu, int64_t vcpu,
                                               Error **errp)
 {
     TraceEventInfoList *events = NULL;
@@ -86,7 +85,6 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
 
 void qmp_trace_event_set_state(const char *name, bool enable,
                                bool has_ignore_unavailable, bool ignore_unavailable,
-                               bool has_vcpu, int64_t vcpu,
                                Error **errp)
 {
     TraceEventIter iter;
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index 86211fce27..d38dd600de 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -40,7 +40,7 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;
 
     qmp_trace_event_set_state(tp_name, new_state,
-                              true, true, false, 0, &local_err);
+                              true, true, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
@@ -82,7 +82,7 @@ void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
         name = "*";
     }
 
-    events = qmp_trace_event_get_state(name, false, 0, &local_err);
+    events = qmp_trace_event_get_state(name, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return;
-- 
2.41.0


