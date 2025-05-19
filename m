Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD48C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH5aG-0005Nm-IQ; Mon, 19 May 2025 14:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uH5aF-0005Ne-DY
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:51:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uH5aD-00040T-OR
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:51:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742caef5896so1569085b3a.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747680688; x=1748285488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LMK3qevlZgTdlBwz3LettjQv7IPbFh0iI0aXRz8G2l8=;
 b=fEtRDh64iwCOWaKki878vhKThfxmoP0pmzvhWKOacoVAHbE/SN9H+g6nN0acuZqp/e
 gpNwW8TaMvqgbCDVoSMWGQo3mROBHML1NwHnED82PrL0RvY/JkS0vpF3gLiwUBoEtRtK
 xCfU/I+qmx/p7wqi92HZgnwxObX0UWBhxWcrRVvk+Jq5MuNQ5yVdJytZZHDi7Zt4I4rq
 xqCAmXP6YS/ELgtXocgou5qVN5w0VsKyu4XQ2YeKsBPRP/m2brMCFuP705BPyTWQ0Gwy
 jKYjUSQwFQipvKENb/EIOHQ1HNVK7MisP2J1f5FLlo64uWL3N+oFC24x/06WtUB1O3mj
 iOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747680688; x=1748285488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMK3qevlZgTdlBwz3LettjQv7IPbFh0iI0aXRz8G2l8=;
 b=gjPtKr+9dxo2+0OkLf7+TeuEusO03EC1tbIHrh8yDiqJliLCn05nK+KcICUA3X3P3r
 gSe7afTSNiYzVkM9YQXus7Rwhl3/GGpGhgoAwMpjgcdj1NnZsRiRPI1tEmLCYRFW45W2
 gAWxOUFURv6VcXPxN5pe68URyadszEPPatsfqZyV5Mwt/Ahx+zAitLkExq7lqeBIqwJV
 pPWuyA3G2NZo14KRQZKqOn9RS1ijKEbrv6NUb5F+t1q/X/mMxD1OS2kwNjb8p6sH8cW5
 mfG7JhZa4R0d5I0+1FK04oIdqFF2RsnrQUD0kTip6GLLK89rT4T6v+ZM7FG9Cz9sZo9f
 NGPw==
X-Gm-Message-State: AOJu0YwmfXCQdlEoh5Nj9M0gBCmNobpEXKz1HjXzDzsIldl15toxLnT8
 uwVb1xuU2CGANFpE9e5WSl+tuJzfd5E5AgiC/v9T31sCaYGvlJXn1hCXtNcLkFWmO3Va8Q==
X-Gm-Gg: ASbGncv4/OCDYls0f+9O5+vGryT5BWNQwEvx7hEVc/oalnOnKbSUvR/u38x2mo1jl7W
 jM/ahp1e5cUl/IE5wdHoMfgAiUIIpjySyhXp7mfnsxcfeo0C0agTjN0uqevTCQ03L01Zq5s4c4m
 zOfpM+Bm+Q5ZyEvygld3kEiAHVpfQvBEJqtpIJwuh+9//G7fV5F4ph1DdevhOdeX5n69w8s2HKb
 TV6hGfGiFn96dVv7bAXB1jfxUNVaNjJEUyaJN3wH5ElqQVWd21jYNPuJZVa/eUIatpJgiYd2SQi
 C/qPVVnUxxRUEIwSxt4tV1SIZhc18XAVVzeueKDM1Wdq2BLziyfhwruyJ25+Cg==
X-Google-Smtp-Source: AGHT+IG+Z2SN2sV86NXAEiNBdt8lGEi1LpHu2Y/Esk0Ut3i0FTf7Xeix7Xm6Be+/XcFYSfdBoRY6/g==
X-Received: by 2002:a05:6a21:3993:b0:1f5:56fe:b437 with SMTP id
 adf61e73a8af0-216219b13demr24667611637.32.1747680687790; 
 Mon, 19 May 2025 11:51:27 -0700 (PDT)
Received: from ubuntu.. ([49.207.59.149]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb085ad4sm6559687a12.59.2025.05.19.11.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 11:51:27 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH] trace/simple: seperate hot paths of tracing fucntions
Date: Mon, 19 May 2025 18:51:08 +0000
Message-Id: <20250519185108.14412-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pf1-x42d.google.com
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

Remove hot paths from .c file and added it in .h file to keep it inline.

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


