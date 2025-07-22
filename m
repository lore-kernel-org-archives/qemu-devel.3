Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEADC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 11:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueBPw-0000tF-A4; Tue, 22 Jul 2025 07:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ueBPn-0000ob-SL
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:44:13 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ueBPl-0004ai-SZ
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:44:11 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-8733548c627so210877839f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753184645; x=1753789445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cnJL6GYN68SRUUGbXCyr3JVs1qmpqzs4vXO3oPkXGqE=;
 b=KZi2v/3UACeKYL6ekH1CksIxbyG8OiZNOUqMQZeYytoFFvkWwCPXmiVpTmIOtn8wOu
 9ecA3vZfZqUqj86atGOe9OvaCYz6Vi5G/N3rcxzy+AkiGlfeLAjH4hDnBJd7Fj6iANPb
 yDq/q0SU2zUmM9rA8CNp6J7+IAIIWTq0zgvl0sYPUjmQhiiyVkCyfGfPijAJ2ZJ9EG08
 RHuMkjvQhfAU6b06lTZvlXTIazXj3IZmSr90soOaq8G/GjH5mjRLCopNoo8hDvtAidLZ
 Bmmf6J+j85ghzz+dLMmyST3UUfq2gVxQSFLB/VJUcw90ytPel7Nd4eS408OQEYB9rTSN
 Nw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753184645; x=1753789445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnJL6GYN68SRUUGbXCyr3JVs1qmpqzs4vXO3oPkXGqE=;
 b=Mc2PIHHzcmaY8UGJg1hG4CulGLxJH+BM7dDdav7K+I+4Rk304x3VLKkv4hbzGAXcXt
 S0xNSmU4lwBFWrIBuWjcbsRDEbY9gIax0R/FNLQQ3STbEVowzbnWLMgDQhYoe7aUc31Z
 TyXgMdkSk6UKnxsI43USJykq6zZv+vrsKrbPK5MI9dq7tAv9jv1XYNx6xr0rMPfZ3XQl
 ActT3O1ZSDuKQMWAMHUCgGn6okdOCUjGSfw9eH2b3uS++vvJMVnzXrWBK+mCSAka5X4E
 Un1+SJLeEsceqqpqdzsPVEc2n/myWzIAxP1hLVbYodiKwwlndU4PW2sEvaNwuxGCEL4U
 owmw==
X-Gm-Message-State: AOJu0Yx21N/xkEdmAEO19AP42sZSX2Ft7CGvwBWOxqzC4zCEtwEj6Xa6
 Kt0z3xCp3tRyLYcXCl3u2jGWqW86wpQ/A7HDJYmzp6qAYhlRbQp76AAFyfHGrO/GT8rXDQ==
X-Gm-Gg: ASbGncuHLzydBIAf7DAunB2HgzI6y4TPzR60RqrZX/qaUm0nd4AbtssD/1EiO97VGaL
 ueGBb4lPavPMqL3a87kDcb0s68Oz8j7SmpN37muDr9MW+gvDvD//ykTkJFNGuMbf7UAfARfy0rO
 fORp+jFepA21vndZUYHQYBegkWdWcL8jdGyjTJPTpGF/ATbelSXXIcEKc+LqvuTSAVTAyzSHeHP
 QiY+wdHkIMqPkHWjhzxgJ1gDFEtj3w16gKflnK9/c/NT/UWl9tDm+FfzD9F4NAEbqMNfRfo/amZ
 NCrUIRTe7YBOp35R6t79qVUmsogADX9lXceBGKuiZv7R8vzQQvedIkqdkdBqK2ZlPi35+eJwUS9
 usp8KloSPqRALOIkykMqU5strVVCDYR5D+JGj
X-Google-Smtp-Source: AGHT+IGzd3VlEKX7Hw2odyFluQOyVArCQ7jcZRn+MmJZzhF74nmvoCilcApUECiHZOtaHZ3E6EpfpQ==
X-Received: by 2002:a05:6602:3e8c:b0:879:26b0:1cca with SMTP id
 ca18e2360f4ac-87c01446defmr2950915639f.13.1753184645331; 
 Tue, 22 Jul 2025 04:44:05 -0700 (PDT)
Received: from ubuntu.. ([2603:300f:1f0f:6e00:86f:729e:7931:1e98])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5084ca05d6asm2537111173.107.2025.07.22.04.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 04:44:04 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, alex.bennee@linaro.org,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH] tracetool: removed the unused vcpu property
Date: Tue, 22 Jul 2025 11:43:52 +0000
Message-Id: <20250722114352.3624-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=tanishdesai37@gmail.com; helo=mail-io1-xd2d.google.com
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

The vcpu property is no longer used in these backends. Removing it avoids
unnecessary checks and simplifies the code generation for these trace
backends.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/__init__.py       | 2 +-
 scripts/tracetool/backend/log.py    | 6 +-----
 scripts/tracetool/backend/simple.py | 6 +-----
 scripts/tracetool/backend/syslog.py | 6 +-----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 6dfcbf71e1..2ae2e562d6 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -219,7 +219,7 @@ class Event(object):
                       r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
                       r"\s*")
 
-    _VALID_PROPS = set(["disable", "vcpu"])
+    _VALID_PROPS = set(["disable"])
 
     def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
                  event_trans=None, event_exec=None):
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 17ba1cd90e..5c9d09dd11 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -29,11 +29,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
+    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
         '        if (message_with_timestamp) {',
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 2688d4b64b..7c84c06b20 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -37,11 +37,7 @@ def generate_h_begin(events, group):
 
 def generate_h(event, group):
     event_id = 'TRACE_' + event.name.upper()
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % event_id
+    cond = "trace_event_get_state(%s)" % event_id
     out('    if (%(cond)s) {',
         '        _simple_%(api)s(%(args)s);',
         '    }',
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 5a3a00fe31..3f82e54aab 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -28,11 +28,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    if "vcpu" in event.properties:
-        # already checked on the generic format code
-        cond = "true"
-    else:
-        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
+    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-- 
2.34.1


