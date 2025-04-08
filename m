Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAEBC369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 04:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u20d8-0006Uf-IA; Tue, 08 Apr 2025 00:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20d6-0006U2-EU
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:32:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20d4-0005d8-FT
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:32:07 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225477548e1so47446615ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744086725; x=1744691525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIf6KRZsta6SFyUZqr4u0W6SgvBvMAQeL+UZ3/HECqo=;
 b=Wl4U1MHQ9zCb1mmtkkQhRXT8TZQN0wv6U4LI2MZAmz4rsp8EQCX82rCPh27p/xSQ9a
 a14HwvvZ0REnQezAHXV1TylGTZZEBTtPL3RWWazY6Dx+Tp6VEeuvb7ttobZJjgWLdnRl
 2A/Aj726MmoWaVZdYCYrtmtSaJPew+5P0JqgcxLnQkqc4LLB1vme+4xa4NlGGYh6jtWe
 Vntcr4txdGGhRxxV9COPuf0ZMViKmqBX146NgLlNUdm5KYzRQhSQ2hQb7svlQzzMMUso
 SK8zOnNp5aYm2DMVplqJrpteP+9ZgZ+ml/Gv3t/8YLgsXDHu+nlnlGyWNZDg0xxIjxnd
 PFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744086725; x=1744691525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIf6KRZsta6SFyUZqr4u0W6SgvBvMAQeL+UZ3/HECqo=;
 b=uInxg8UQn+RqmNxVO9wZROgUC4Kc/d20q2SDB9CmFOnITfC2APkTrmyKt6hfWiO0qp
 9N3UikNhn1KSKyTX5PyOoB+nwwEwzGRZ56h9tonBrpFlLuVD4KJm68Fp8J9NpXQ6JutH
 pwQAaa/KG+uYgCD1JTHhK8osfBP+JYNWhKzeb3jp3GFGdIpzDEBwH/1BjqTGyqNbqapc
 Al0OzRL/3DAlneYz/7GOxrU8qmC+ZJxyPOn/7xr7tXnwwfLOIY73qMZ9qr9N/FoiCmd6
 7ulkwe3cro1lX9qZDRJ2X8VjL8YRt1ZeGMKCQl4WckQRAkutLQ6kPy8mYlMXEfPw/jn9
 nMrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXhOKOmpD7VJGkkjzSYnTJGVG/hXMGJR7Q50AO3/L20Gy1WdjV2N3ZrLhbnZll3uXBOAjGH0XTQMDa@nongnu.org
X-Gm-Message-State: AOJu0Yx1L076c1Uo/cTMHSvWxvaI8WyyKdZQiBjXtCRiHXmnKu9ElgDB
 k0rSywkIP13h8MZvAd3EvrHKDwLvQ1tPVwIKJQAPvgkOQy/iddp6
X-Gm-Gg: ASbGncttHSwwevfov6lmw14LOHZaZiz1zCmMR8DhcuHcfXTejOrtZjJ9Ud8k5pHxtw6
 nMH3LDGbzowij+YGnVt+IOK3rBCWU+hMiNI9BMhjlm6LLGcgDDD/VWeW5El/Q38/QlwSoTcBuOQ
 ol5xrjEMutCZyQZBWdElIYS52Xiw2RnBIIN24dsZCD4EktQ6+ketPuPQd71ZNuWQpVpKJ5cnSfC
 BpBXQsGAghlUYZ/lIQh8VmXwaF3TdFaJwCYPS0a/sVtHaTQDItgZ3+ZVShwS3JFsPZ37ZWOVqRv
 TS5oBMGp46dmtOU7RNaNXWK9VBzSLqSx/m0TI9HfDLChdK5GwBFZqk+qykB7zgY976CpIBeg
X-Google-Smtp-Source: AGHT+IG95Srqv4+u+FHkRMxez0pgopseFoWm6fSASwQ6yjOyz+N/XBQF4kWBCIkYShUTM1WzudKcbQ==
X-Received: by 2002:a17:903:2352:b0:224:c46:d162 with SMTP id
 d9443c01a7336-22a8a865a9cmr187371765ad.20.1744086725038; 
 Mon, 07 Apr 2025 21:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e0a9sm90055385ad.149.2025.04.07.21.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 21:32:04 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan.cxl@gmail.com, anisa.su887@gmail.com,
 gourry@gourry.net, Fan Ni <fan.ni@samsung.com>
Subject: [RFC 2/3] cxl_type3: Add qmp_cxl_process_mctp_message qmp interface
Date: Mon,  7 Apr 2025 21:20:29 -0700
Message-ID: <20250408043051.430340-3-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250408043051.430340-1-nifan.cxl@gmail.com>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
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

Add a new QAPI "qmp-cxl-process-mctp-message" to process the MCTP
request cached in the shared buffer from FM VM.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c       | 41 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c |  5 +++++
 qapi/cxl.json            | 18 ++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7f85616ca1..f7ac8e8da7 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1614,6 +1614,47 @@ void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d)
     ct3d->poison_list_overflow_ts = 0;
 }
 
+void qmp_cxl_process_mctp_message(const char *cci_name, Error **errp)
+{
+    int i;
+    struct CXLCCINamePtrMap *map;
+    struct CXLMCTPCommandBuf *buf;
+    CXLCCI *cci = NULL;
+    CXLType3Dev *ct3d;
+
+    if (!cci_map_buf) {
+        error_setg(errp, "CCI name mapping buffer not setup");
+        return;
+    }
+
+    for (i = 0; i < cci_map_buf->num_mappings; i++) {
+        map = &cci_map_buf->maps[i];
+        if (!strcmp(map->cci_name, cci_name)) {
+            cci = (CXLCCI *) map->cci_pointer;
+            break;
+        }
+    }
+    if (!cci) {
+        error_setg(errp, "CCI instance is not found with name: %s", cci_name);
+        return;
+    }
+    ct3d = CXL_TYPE3(OBJECT(cci->d));
+    if (!ct3d) {
+        error_setg(errp, "No Type3 device associated with the cci");
+        return;
+    }
+    if (ct3d->mctp_shared_buffer->status != 1) {
+        error_setg(errp, "MCTP buffer status is not set to 1, skip");
+        return;
+    }
+    buf = &ct3d->mctp_shared_buffer->command_buf;
+    buf->ret_val = cxl_process_cci_message(cci, buf->command_set, buf->command,
+                                           buf->len_in, buf->payload,
+                                           &buf->len_out, buf->payload_out,
+                                           &buf->bg_started);
+    ct3d->mctp_shared_buffer->status = 0;
+}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index c1a5e4a7c1..dbf18f2af2 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -92,3 +92,8 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_process_mctp_message(const char *cci_name, Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
diff --git a/qapi/cxl.json b/qapi/cxl.json
index dd947d3bbc..fcb1e0b3fd 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -553,3 +553,21 @@
            },
   'features': [ 'unstable' ]
 }
+
+##
+# @cxl-process-mctp-message:
+#
+# Command to process a MCTP command sent from another VM.
+#
+# @cci-name: name of the CCI to process the command;
+#
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
+# Since: 9.1
+##
+{'command': 'cxl-process-mctp-message',
+ 'data': {'cci-name': 'str'},
+  'features': [ 'unstable' ]
+ }
-- 
2.47.2


