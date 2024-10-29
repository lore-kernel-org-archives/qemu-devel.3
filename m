Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73285D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nsK-00014x-2T; Tue, 29 Oct 2024 11:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nrz-0000aI-RU
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:10:56 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nrw-0007fS-O1
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:10:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso4863697e87.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214651; x=1730819451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QD7klZQEYAvteWerIuPHuaPLuFXzFsaVkFjCQXxT8EE=;
 b=gKZ5Pq4adhHJdcarha+byvmh1LtU3lepymo7Nr0ty4VlaotXVzq6d9fTndGM+3LkWg
 hP55BTqUS2sGMJKyxTpR1/fYOUMlFi5tKtcGA+ANGeBNR2o/8GvzfRCRupQfw+WxzmCB
 E2/IjXDVjOOl/CDBrAAn3tLJ8CvbcLIeml0NIUwHYVV64oShNJMYAKk36RcPW4fsgJWC
 OOuf7Ia7a+Lz5vkFM/PSBgYo1cZp4WIuPBrkXtHsqNZgpHH6kCzWwV5B+3yvDWyMR8uh
 WrUQLP9Hymbv9cleMdHF7/r7Omn7MKvqKbWqWpaTTpJP5OuQ1Qh0Oq2F/qL/KP/NaaXA
 Pu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214651; x=1730819451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QD7klZQEYAvteWerIuPHuaPLuFXzFsaVkFjCQXxT8EE=;
 b=YCTap3lBZMCV9N/yozQ8RiqyoKJV28S5s4kM/U2ZrapCUKYDaH0KIC8WxqtYU5XIig
 y/qLplkhGTFkX8r8gd9rpugKuHkkszMWVfpm2hJ3RrPKZ36YF/1K3iYjlisocTFhvWXQ
 ZJWE4CoSq4xLscitWfP4NBwladu4upglJlgVWEi0EMZkzo06yYxpdOxIlepF4fxOK0LY
 uWYJ4QStieEOsLJGNcNAuKc7bOIkO9Wdk6FSi4c7qek1pCL2hYp5cBuLFBA+xd8s/mJW
 +2Uu0d5UQbA2OQASyqI3nDTHYeNov68SkSQk7g5DDKAdtDOg5HumkIqq9rBMCKDyU89t
 r2ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTSi7Mw5vfU2lRtjr1+DIaVlWVrGfs3xJpP9cEmdHpDWU/zZAXZnin1NNyjxmKU/Z81fG++SleEt/1@nongnu.org
X-Gm-Message-State: AOJu0YzOk4SNDflh7T3Yot7wv5koLq+1JdJyJZZqPZ045izZRUgwIMka
 uVxGkriGRXKxDwEdbOlKzkpwSkdM3Rknjlezu7IyH0w2W0Zr0WX5SYvT50V5Pr8+usR/AusAN/n
 S
X-Google-Smtp-Source: AGHT+IG8u3jDQAjMK230Gd0k9DR9L5Mi5+qLsHUMyR9MjSbiw/do4+c8faxdtpUxrZyU24OjhWnz4g==
X-Received: by 2002:a05:6512:2304:b0:53a:aea:a9e1 with SMTP id
 2adb3069b0e04-53b34a1afd9mr6639430e87.54.1730214650697; 
 Tue, 29 Oct 2024 08:10:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/18] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
Date: Tue, 29 Oct 2024 15:10:32 +0000
Message-Id: <20241029151048.1047247-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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
Message-id: 20241010131800.3210161-1-peter.maydell@linaro.org
Message-id: 20240819144303.37852-1-peter.maydell@linaro.org
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


