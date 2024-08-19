Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D794C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 14:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg3bD-0000Bu-O0; Mon, 19 Aug 2024 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg3bC-0000Av-Bb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:43:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg3bA-0004GE-EY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:43:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso33222305e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724078586; x=1724683386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LK0G25CZG013C1Vbj0ZuFTV6wmWQVTRhUl87xQWJTe4=;
 b=aLRMrQLKuSRH/C/+H5HlH6iqo106xe4Z9BhjvLlrrkSXp5ADec0rMMRcS4UP6i4Jv4
 NKWoCYMgEYOaaI6358KDOHcbsZ41jXoY/xZqij/nlyFQAM/1lE567UdZ2gpZ852blPZr
 +tT0WoVEUbEsX5zA16/OmzZ1bmPaQXcW6gPNPv0u8aDiaf1tJEl35AfVNnCT+MpL3YMd
 wSDH+LtqJyCg+ZSU1FryZcQi/+u7mh1Bq5vuzKg9dlLQjNJu3RGDRX38K8DbBcpQs56s
 Gu3hAggVE+gTLpR9DMtvYwEGBbYXjJEH/qjjvK6yHATbQFIvBzyP5PTpMmdDfA0xtLt7
 lzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724078586; x=1724683386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LK0G25CZG013C1Vbj0ZuFTV6wmWQVTRhUl87xQWJTe4=;
 b=m3OjZtNVBMhMkPkVk779yeIk68Wsu/JxY3l3d5oIyopwSO9GeDJFqP5XTPAgLHUKHj
 y4qWpJTq/sVhl69xlIDh0mAIbxuK7Zi3H812SBBEcOpawXWY0KDkWL+eqYjHTPcb0bqb
 JRWY1/KzylrmRHmO0XCRNq8VcFHR/AgSa5qpHzymHXWiKTLOWoz3ipCdy3w78UXVr4yR
 KfHikFux5PHQSGspADstwoq9blT4N3QbBopH7kAOcj+WT0/qmYB+RyAgs82TXxX5EdRS
 nByU5j92bCx6ijC50ENsVuaZzqXTMiPX5SExqXN9zEjtqRjPmkXxp4tJwHgLk7z4Idv9
 nsRw==
X-Gm-Message-State: AOJu0YwCTlOQvp2tSL+nGUOx1cXRF/1NS83a547NHHCVIgLBn+PV9/+W
 2K2uGYOqgwGeFIziRG23eFue61ahqVuPgKpT4W3ttmWciE0nRPr2bYlrrcq+f0EvCfWWCLCyxIN
 h
X-Google-Smtp-Source: AGHT+IHN5LAqNtIMn4Y8RYTYmUEUIdmhoAQsBzSaygKWG7StUQ80ky5DjBR2okypdfLJVjTFQ8uK5Q==
X-Received: by 2002:a05:600c:35c1:b0:426:6320:226a with SMTP id
 5b1f17b1804b1-429ed7baab6mr65607975e9.15.1724078586033; 
 Mon, 19 Aug 2024 07:43:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded7cfc6sm168262695e9.42.2024.08.19.07.43.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 07:43:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/system/cpu-hotplug: Update example's socket-id/core-id
Date: Mon, 19 Aug 2024 15:43:03 +0100
Message-Id: <20240819144303.37852-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

At some point the way we allocate socket-id and core-id to CPUs
by default changed; update the example of how to do CPU hotplug
and unplug so the example commands work again. The differences
in the sample input and output are:
 * the second CPU is now socket-id=0 core-id=1,
   not socket-id=1 core-id=0
 * the order of fields from the qmp_shell is different (it seems
   to now always be in alphabetical order)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I noticed this while I was playing around with vcpu hotplug trying to
demonstrate a memory leak I want to fix...

 docs/system/cpu-hotplug.rst | 54 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/docs/system/cpu-hotplug.rst b/docs/system/cpu-hotplug.rst
index 015ce2b6ec3..443ff226b90 100644
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
 
       (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
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


