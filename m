Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B968D0EE34
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 20:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szMHq-0008KB-Ox; Fri, 11 Oct 2024 16:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1szMHX-00089O-R9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 16:30:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1szMHW-0000na-62
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 16:30:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so22778115ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728678636; x=1729283436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rz6vGoXtQ8OGPE036yHF1biqczt6VgPMUWgroJxMWJ8=;
 b=JhzMvFiAv1OrypWPhelAqMxGrPCM7VSIEPq9CwexY8DbLjds3skAO10VqqtwvmRYhY
 CsPaem+QRI4lNtZFuwTINMC3942aF5VwpMQQubYyqUqqT8ITc6z8xD6gXie5K94N1MZg
 tOj46h0VJNUte5iY4xNnVoLbxC2jlwzjv8AysAMJ1O6uS1Y37lkZ4ANNC38WZIK3dKDt
 BNc+F/EssSm516SOvgPBgEp0QlyUepgxIWXcRWS93GFxQGjYUSE9fUeqrIwrMsE4ukdl
 fPqpTyEeJgk4LixmvLT86bjIQBnRCMVeLy5mzwxvYc3N+8uunoa5SLNWKpD8waunozvq
 0kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728678636; x=1729283436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rz6vGoXtQ8OGPE036yHF1biqczt6VgPMUWgroJxMWJ8=;
 b=ejEdpzfS9piaflAhQCweJg3AeOoUgP1SVgWPjJiqwxmJJvW4SH3e5oXy/wGZXGuXfO
 TLAKyq5czxLVunL4Z+TZuHQVZC9URLlvYeFpaHvUu1gUdqww7jqB3B+cZfEZpRW7OvuV
 fKbSE3Y0DTDNpJvaKnzIX1QvkNAQxyBdxTt8qAtEfdMA0B/U20SqLXfRmeAI7OkwOSme
 7+Z/NfeZGVsOysOBQr57qcZ2yw5NHDMtYbpQ44Tm9FBPugm/JVXhukA7JejItYpWZEz/
 XBmDswTwHfnTdp01oo7luP8WQeMU3fnLlmyo6MVjdJ4uI7bO5skAhS4miIAcV8lR1u2M
 l8gg==
X-Gm-Message-State: AOJu0Yzdwa3X3b8WjCZHSTdzavRENorOz9n84T+7cR8kWYld/Nq1Qywb
 yct6oWjaJzZtBrK1BXJO7aiWsk6ZDlHhMxWttj1/VwPmXhIF5Q7pu6BrKA==
X-Google-Smtp-Source: AGHT+IFuAwHAP0t7894mcawPGcyqy5qcL9EKa1mT3PbzMHJnT9sHJW+BxDiletBdOS9DigBb/ji5eQ==
X-Received: by 2002:a17:902:e74b:b0:20c:8daf:8530 with SMTP id
 d9443c01a7336-20ca144a5femr60890855ad.7.1728678636358; 
 Fri, 11 Oct 2024 13:30:36 -0700 (PDT)
Received: from fan.. ([2601:646:8f03:9fee:fa84:fdda:e412:45e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c312f49sm27345205ad.233.2024.10.11.13.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 13:30:35 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan.cxl@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: [QEMU RFC] hw/mem/cxl_type3: add guard to avoid event log overflow
 during a DC extent add/release request
Date: Fri, 11 Oct 2024 13:24:50 -0700
Message-ID: <20241011202929.11611-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

One DC extent add/release request can take multiple DC extents.
For each extent in the request, one DC event record will be generated and
isnerted into the event log. All the event records for the request will be
grouped with the More flag (see CXL spec r3.1, Table 8-168 and 8-170).
If an overflow happens during the process, the yet-to-insert records will
get lost, leaving the device in a situation where it notifies the host
only part of the extents involved, and the host never surfacing the
extents received and waiting for the remaining extents.

Add a check in qmp_cxl_process_dynamic_capacity_prescriptive and ensure
the event log does not overflow during the process.

Currently we check the number of extents involved with the event
overflow threshold, do we need to tight the check and compare with
the remaining spot available in the event log?

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-events.c         | 2 --
 hw/mem/cxl_type3.c          | 7 +++++++
 include/hw/cxl/cxl_events.h | 3 +++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..05d8aae627 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -16,8 +16,6 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 
-/* Artificial limit on the number of events a log can hold */
-#define CXL_TEST_EVENT_OVERFLOW 8
 
 static void reset_overflow(CXLEventLog *log)
 {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3d7289fa84..32668df365 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2015,6 +2015,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         num_extents++;
     }
 
+    if (num_extents > CXL_TEST_EVENT_OVERFLOW) {
+        error_setg(errp,
+                   "at most %d extents allowed in one add/release request",
+                   CXL_TEST_EVENT_OVERFLOW);
+       return;
+    }
+
     /* Create extent list for event being passed to host */
     i = 0;
     list = records;
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..2a6b57e3e6 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -12,6 +12,9 @@
 
 #include "qemu/uuid.h"
 
+/* Artificial limit on the number of events a log can hold */
+#define CXL_TEST_EVENT_OVERFLOW 8
+
 /*
  * CXL r3.1 section 8.2.9.2.2: Get Event Records (Opcode 0100h); Table 8-52
  *
-- 
2.43.0


