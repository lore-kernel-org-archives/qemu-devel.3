Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF056CF11F3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt3b-0007qx-AS; Thu, 10 Oct 2024 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syt3O-0007jQ-RN
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:18:07 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syt3M-0008P3-Ej
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 09:18:06 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5398fb1a871so992982e87.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728566282; x=1729171082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ylbu5jo0GWWpRbcIXJid3gmoRXQZOn8CJVhgXWT4S28=;
 b=ZL/3XUIGlhGBnQ252Jwu+LaWpBMl8ED2j6CkNwwnBWQtZA0p4zNgfTFdeukOsImI1M
 AXq1+9U26a88OcsfiIi7yyf0qdZkNry9JkmxvshlM8D32QOhtkCPXMC1dwQEDedYSNhk
 /h9OxGiAgbYDuURrshl+TavFSutkIXNx4LDG3ojoAKAz0tPhYxU6DiSt0IUnkgjdyJ/6
 jTWxVBT6Ech7nApZeL0QJN2YiGv+G8X807tZ0PhYmfemmesUbpOAnisCKO/J119yv1eT
 OPRkiihLZLMWyJTjnJf6na79up/zboUiiAK9e63lgdKkw5+KKORuQ1La3N4lUJuD15gY
 0JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728566282; x=1729171082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylbu5jo0GWWpRbcIXJid3gmoRXQZOn8CJVhgXWT4S28=;
 b=sqffFpJxhpjwvQNakriKw3usSi5ZaZ5kIiITlPR74C7g0kYnhTt695IU8/nMljqb7U
 OKm+YZ5BK4ZW1NeHvKj6ZkYHiJzaU0yeSsRPP7nLh3NxiqjcxveHS7vaXj7oTSlkCL2j
 z1EYdiiuR3ZdSnjNFzptW9/QTNfjaQGK++GMJbHiL0e9C9WNpss9byqcKX4bNKBRB4Dr
 4h8k5QkTMxzJiu4nNGk5TcTMwp7X0eeMi86SFMn/wjWFtR+bYxy0pEdngpBBNOanCfN+
 lP3Tg4gHe5tay/KmJYHkF5YMqNxNzoG5vuWLv/5c5U5vkSXHy5SI8+g48r79Dc6icjOp
 svDQ==
X-Gm-Message-State: AOJu0YwYJWEDTCFoPG/r3eyzNwTNnsflUF0na5TcDEXtxtlvKK9y91jq
 f38/5PqDwhDDNmLlxoNrhgz9doKryNlqVG9fCiyDGtzjobLkRzQvtOb9E0uH3zISVVP+58eg2HA
 W
X-Google-Smtp-Source: AGHT+IHQqMFQkLTXEFpJVeZun85V4jl8Hk+qf+l/JLcKgiP7UHQQr+u8IBoOJtHzq0oKDpCSbidukg==
X-Received: by 2002:ac2:4c45:0:b0:52c:fd46:bf07 with SMTP id
 2adb3069b0e04-539c4970facmr3925972e87.49.1728566282069; 
 Thu, 10 Oct 2024 06:18:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b79fa0asm1538544f8f.83.2024.10.10.06.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 06:18:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2] docs/system/cpu-hotplug: Update example's socket-id/core-id
Date: Thu, 10 Oct 2024 14:18:00 +0100
Message-Id: <20241010131800.3210161-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The example of how to do vCPU hotplug and hot-unlpug in the
cpu-hotplug documentation no longer works, because the way we
allocate socket-id and core-id to CPUs by default has changed at some
point.  The output also no longer matches what current QEMU produces
in some more cosmetic ways.

Update the example to match current QEMU. The differences are:
 * the second CPU is now socket-id=0 core-id=1,
   not socket-id=1 core-id=0
 * the order of fields in QMP responses is now in alphabetical order
 * the "arch" member is no longer present in the query-cpus-fast
   output (it was removed in QEMU 6.0)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20240819144303.37852-1-peter.maydell@linaro.org
---
v1->v2:
 * update device_add command line to use right socket-id/core-id
 * expand commit message to mention that "arch" field has gone
---
 docs/system/cpu-hotplug.rst | 56 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/docs/system/cpu-hotplug.rst b/docs/system/cpu-hotplug.rst
index 015ce2b6ec3..cc50937c36c 100644
--- a/docs/system/cpu-hotplug.rst
+++ b/docs/system/cpu-hotplug.rst
@@ -33,23 +33,23 @@ vCPU hotplug
       {
           "return": [
               {
-                  "type": "IvyBridge-IBRS-x86_64-cpu",
-                  "vcpus-count": 1,
                   "props": {
-                      "socket-id": 1,
-                      "core-id": 0,
+                      "core-id": 1,
+                      "socket-id": 0,
                       "thread-id": 0
-                  }
+                  },
+                  "type": "IvyBridge-IBRS-x86_64-cpu",
+                  "vcpus-count": 1
               },
               {
+                  "props": {
+                      "core-id": 0,
+                      "socket-id": 0,
+                      "thread-id": 0
+                  },
                   "qom-path": "/machine/unattached/device[0]",
                   "type": "IvyBridge-IBRS-x86_64-cpu",
-                  "vcpus-count": 1,
-                  "props": {
-                      "socket-id": 0,
-                      "core-id": 0,
-                      "thread-id": 0
-                  }
+                  "vcpus-count": 1
               }
           ]
       }
@@ -58,18 +58,18 @@ vCPU hotplug
 (4) The ``query-hotpluggable-cpus`` command returns an object for CPUs
     that are present (containing a "qom-path" member) or which may be
     hot-plugged (no "qom-path" member).  From its output in step (3), we
-    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
-    while hot-plugging a CPU into socket 1 requires passing the listed
+    can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0 core 0,
+    while hot-plugging a CPU into socket 0 core 1 requires passing the listed
     properties to QMP ``device_add``::
 
-      (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
+      (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=0 core-id=1 thread-id=0
       {
           "execute": "device_add",
           "arguments": {
-              "socket-id": 1,
+              "core-id": 1,
               "driver": "IvyBridge-IBRS-x86_64-cpu",
               "id": "cpu-2",
-              "core-id": 0,
+              "socket-id": 0,
               "thread-id": 0
           }
       }
@@ -83,34 +83,32 @@ vCPU hotplug
 
       (QEMU) query-cpus-fast
       {
-          "execute": "query-cpus-fast",
           "arguments": {}
+          "execute": "query-cpus-fast",
       }
       {
           "return": [
               {
-                  "qom-path": "/machine/unattached/device[0]",
-                  "target": "x86_64",
-                  "thread-id": 11534,
                   "cpu-index": 0,
                   "props": {
-                      "socket-id": 0,
                       "core-id": 0,
+                      "socket-id": 0,
                       "thread-id": 0
                   },
-                  "arch": "x86"
+                  "qom-path": "/machine/unattached/device[0]",
+                  "target": "x86_64",
+                  "thread-id": 28957
               },
               {
-                  "qom-path": "/machine/peripheral/cpu-2",
-                  "target": "x86_64",
-                  "thread-id": 12106,
                   "cpu-index": 1,
                   "props": {
-                      "socket-id": 1,
-                      "core-id": 0,
+                      "core-id": 1,
+                      "socket-id": 0,
                       "thread-id": 0
                   },
-                  "arch": "x86"
+                  "qom-path": "/machine/peripheral/cpu-2",
+                  "target": "x86_64",
+                  "thread-id": 29095
               }
           ]
       }
@@ -123,10 +121,10 @@ From the 'qmp-shell', invoke the QMP ``device_del`` command::
 
       (QEMU) device_del id=cpu-2
       {
-          "execute": "device_del",
           "arguments": {
               "id": "cpu-2"
           }
+          "execute": "device_del",
       }
       {
           "return": {}
-- 
2.34.1


