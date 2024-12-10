Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3BBE7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYj-0008RR-I1; Mon, 09 Dec 2024 22:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYi-0008R1-0H; Mon, 09 Dec 2024 22:05:12 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYg-0003Da-Bs; Mon, 09 Dec 2024 22:05:11 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216281bc30fso30040765ad.0; 
 Mon, 09 Dec 2024 19:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799908; x=1734404708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ndiCqcmzK/5KbMYZe47Ps1mr/e55HwDfmvRY6XeS2o=;
 b=EJDFCzmJgFYSTgQTR1S25C0JH9bweJV9S0p6cRJoHqo9aswr92Dzu32pRmsKOAgBl8
 kKUJAJgMxwH7X/AAE3B6Qy0rI2Or44b1sgyEAu0wxHbl6wzeBkUo4TqPlOX4VKk8K7Jb
 5Yfc61J4qXGp9ytTK6rUw7eq0FwGtaL4Xrb3Gt6Wii12DrsD2hIRSM225cFAAa7fnwHF
 fyDxvwDKAUBGtokNbHgSICfPGcEEXrTp6JlRJBjTBGHWLnq6Oj/eiaKrTjgTCTqln/Th
 lzD3F9FuLRKrOp8XrK/EeiqyMVfACrrLLwJ4qo82fyUdJPUtVT4liYQc2FiBgHWBA85r
 cZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799908; x=1734404708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ndiCqcmzK/5KbMYZe47Ps1mr/e55HwDfmvRY6XeS2o=;
 b=GPVzzTQOJQCYEs+PrSw2USfs1AL+L7PkDTgUQ1wHTEev0ikH9fCoTGW4LtApDgehn0
 lBguYmwBoq1tP9g+6J0cZpA7gWtQN+Tn3iSigwz3s2jZw/YgDG1OTCnMZ8TKm8zARiSQ
 PeLpSL4z9P5Is3eu7SRTWHJySkV3gLRwIMxe+OkdUy70R4yEZnyUScAnuJDLlNnBlEaM
 +OXxsxnj3JFynARJEP6/j5vONF/nhdPnYAwY4qxwN9Nigul44Ac+quusnEk4sue3m5td
 YFskcw2nOypvlc+ydygiCmTdl1Igbnqz+PmIf75El2gtcEvUOguLvs5CzdPeyqcq3YB1
 zcMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpMQRqNTFQQ2joI+ug8jAJvKc+YYqzM9FCo+/+/WpgTibZbeO3GwMUHrchgdENIJoLhtQLjR5qFLdc@nongnu.org
X-Gm-Message-State: AOJu0YwJJgh/tkDC0+4vEbF7tWFmnFyuw2P3el28dHrAKrDE8Ve1Hhza
 WRfzXHm8ZMTzLT4EtYxFHD3hL7Y6FMrPrkr62vw4UeIIfkIULUln8X3SKg==
X-Gm-Gg: ASbGncteDiAg2ppBRKVdVsRcqKgrvZdIh8oM4fZnwPqZLOFFTvJfDCG4ockGPOpYhjS
 2OQYghvaN0OBB/pjAMlAhUK3twV8IUqYdD42xfGOjsEQZDesT6mTiT3g+HxwqRsBdqD5rr1Mwfa
 RNf9WLc8HSZ0ZCASTRiSmWDtX83MU3yuSBZSEyYVs6pjprthCS5wfaIuudMVdJExmyrp7kQ99G3
 fd9w9dgJ6ldZP0WhhYBIaEn/8U6ViBv2/wvmTkMfG05f1mWpUMOKxohJkdK
X-Google-Smtp-Source: AGHT+IEnlStGc8p1y5cmCYvQQGknNSWMJ+Isy1NINkIAAli3OovBccx2Hz3bpGilC0j5ThPPbBW2nQ==
X-Received: by 2002:a17:902:da91:b0:215:6816:6345 with SMTP id
 d9443c01a7336-21669fdec47mr46874775ad.16.1733799908036; 
 Mon, 09 Dec 2024 19:05:08 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 3/9] ppc/pnv/occ: Fix common area sensor offsets
Date: Tue, 10 Dec 2024 13:04:43 +1000
Message-ID: <20241210030451.1306608-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

The commit to fix the OCC common area sensor mappings didn't update the
register offsets to match.

Before this change, skiboot reports:

[    0.347100086,3] OCC: Chip 0 sensor data invalid

Afterward, there is no error and the sensor_groups directory appears
under /sys/firmware/opal/.

The SLW_IMAGE_BASE address looks like a workaround to intercept firmware
memory accesses, but that does not seem to be required now (and would
have been broken by the OCC common area region mapping change anyway).
So it can be removed.

Fixes: 3a1b70b66b5cb4 ("ppc/pnv: Fix OCC common area region mapping")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 48123ceae17..c6681a035a7 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -32,22 +32,21 @@
 #define OCB_OCI_OCCMISC_OR      0x4022
 
 /* OCC sensors */
-#define OCC_SENSOR_DATA_BLOCK_OFFSET          0x580000
-#define OCC_SENSOR_DATA_VALID                 0x580001
-#define OCC_SENSOR_DATA_VERSION               0x580002
-#define OCC_SENSOR_DATA_READING_VERSION       0x580004
-#define OCC_SENSOR_DATA_NR_SENSORS            0x580008
-#define OCC_SENSOR_DATA_NAMES_OFFSET          0x580010
-#define OCC_SENSOR_DATA_READING_PING_OFFSET   0x580014
-#define OCC_SENSOR_DATA_READING_PONG_OFFSET   0x58000c
-#define OCC_SENSOR_DATA_NAME_LENGTH           0x58000d
-#define OCC_SENSOR_NAME_STRUCTURE_TYPE        0x580023
-#define OCC_SENSOR_LOC_CORE                   0x580022
-#define OCC_SENSOR_LOC_GPU                    0x580020
-#define OCC_SENSOR_TYPE_POWER                 0x580003
-#define OCC_SENSOR_NAME                       0x580005
-#define HWMON_SENSORS_MASK                    0x58001e
-#define SLW_IMAGE_BASE                        0x0
+#define OCC_SENSOR_DATA_BLOCK_OFFSET          0x0000
+#define OCC_SENSOR_DATA_VALID                 0x0001
+#define OCC_SENSOR_DATA_VERSION               0x0002
+#define OCC_SENSOR_DATA_READING_VERSION       0x0004
+#define OCC_SENSOR_DATA_NR_SENSORS            0x0008
+#define OCC_SENSOR_DATA_NAMES_OFFSET          0x0010
+#define OCC_SENSOR_DATA_READING_PING_OFFSET   0x0014
+#define OCC_SENSOR_DATA_READING_PONG_OFFSET   0x000c
+#define OCC_SENSOR_DATA_NAME_LENGTH           0x000d
+#define OCC_SENSOR_NAME_STRUCTURE_TYPE        0x0023
+#define OCC_SENSOR_LOC_CORE                   0x0022
+#define OCC_SENSOR_LOC_GPU                    0x0020
+#define OCC_SENSOR_TYPE_POWER                 0x0003
+#define OCC_SENSOR_NAME                       0x0005
+#define HWMON_SENSORS_MASK                    0x001e
 
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
@@ -129,8 +128,6 @@ static uint64_t pnv_occ_common_area_read(void *opaque, hwaddr addr,
     case HWMON_SENSORS_MASK:
     case OCC_SENSOR_LOC_GPU:
         return 0x8e00;
-    case SLW_IMAGE_BASE:
-        return 0x1000000000000000;
     }
     return 0;
 }
-- 
2.45.2


