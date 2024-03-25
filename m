Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA26CD11DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropcQ-0000pA-Je; Mon, 25 Mar 2024 15:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcO-0000ot-87
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcM-0004lN-MX
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e04ac200a6so32868975ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711393461; x=1711998261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xakP/WAiR69d8B5B18gJ85sFdqfiQ0c6HHa8yXwoSyo=;
 b=iAir1Uwwl9WlwmE93JfiOb+CwsUb4gBLalGvcvcIVP3we69YeRgbBCXgn9oloUeUZW
 maZTPds8FH/72mXtF+9FQk/EcsRZwWqzACA5lAgJoyHDj+45TD0PBBY/4Se8BHZ3GmtV
 V5UOFD3CfS54ex+fkNJNi9WDU//HaaIPfd4oqczLfrQHzelJnJ1DlyvbWCUK1DpmQbdM
 MqnGVVgD9/FL1OpFFkhbPdHLPyCGH27dNIfsYGq+o6iKfhePgVdPDUi+uCJ8FfUqAfhf
 02FLpqNQQPr/wUi/bLAO659DFgtev0GkKmznyT9ipT+eaUt5B7C+qLDZFVfHik+BZ4je
 B5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393461; x=1711998261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xakP/WAiR69d8B5B18gJ85sFdqfiQ0c6HHa8yXwoSyo=;
 b=LOQCxNwzvZaLE2JZpiz2PlweZ33t8Tz7xBHd37ci0bG0/0EYfXMezJ70/xuWqMnr+r
 E4lZN8GYuA07DHA87VXSWz/MgN352Cph9Dkg9rX1vsDzAZvAS2FH3N/2yOjZnJeKEJLd
 MPJsU5HTuq8EZtbxIZS4iVIg+IfqvOeXtAsAOx6afDJbqAXeXPyvS097jeD6A1o4soXE
 UMxuH13Qbiz90TcbnCOUJKa2LYfyX1IBxdLe2VBXlX2Uzycb8D7ODJKWE3w52SEVUCe7
 RSw5/os35sfn924ukK1Z13kBiJuLoQATmhbpnxJv0+IQzchW3533rCe9Meg8qy/RMKbA
 mLSw==
X-Gm-Message-State: AOJu0YwujhAZ3LZuEgSwdJg7WaJM6GyVtXo8sC8PD7vb7nHExkG30yc4
 6WqrpELXKRBgYvTMjTS7HKEdTwGAU75qlIumNxBEdg4o5WMPbsz03JH8HgVH
X-Google-Smtp-Source: AGHT+IHIlRLO0pl+CVLunHEPlD8oj7IDD/ym0H18wHpotJXetvT29Z/tMxVqVBK/ih6+S4JVauRffQ==
X-Received: by 2002:a17:903:22c4:b0:1e0:c070:b082 with SMTP id
 y4-20020a17090322c400b001e0c070b082mr5039024plg.14.1711393460732; 
 Mon, 25 Mar 2024 12:04:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 12:04:20 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 01/12] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Date: Mon, 25 Mar 2024 12:02:19 -0700
Message-ID: <20240325190339.696686-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x631.google.com
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

Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bcd727f4c..ba1d9901df 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -780,8 +781,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
@@ -807,6 +809,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.43.0


