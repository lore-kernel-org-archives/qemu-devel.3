Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4FDC35FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCY-0001fW-NN; Tue, 11 Mar 2025 08:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCN-0001QA-SL; Tue, 11 Mar 2025 08:59:08 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCL-0007tD-Rc; Tue, 11 Mar 2025 08:59:07 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso7286529a91.3; 
 Tue, 11 Mar 2025 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697943; x=1742302743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrjQAkubjW9GpsAIIJ1EX4bgybSUalPSDK9qpo5mGhU=;
 b=QTBPxkTZWhuzyaWXpvS21/nIa3/M3RA6HxP7irvR22pMonyeTHljrWkG1GZFojbcqY
 jn1ZO3+ndBpblkrOchG4oVtUvBcuaUGh1jh/Xi3Efpa3w4LQ60r+W75pVP3Y/cTTBoay
 D5SHB9OdQbCMX4pX68f3P+qg2GQ7NsYtxjoLM/PraLTAkeQxLISeR8oLOx8tc7NBXvkz
 CBgq0nUS3IqsrlzINUkJEKm0wyE65W4yZJJms0kdl7np0LdTaoRDb20pv4x2KbfAJG3i
 myYMJ4FEf/5zM10LKUqCwfx//3FcMCBhFQPwGP5MZhSPvzNGSMpPZwT/3e5frml4KT+r
 2w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697943; x=1742302743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrjQAkubjW9GpsAIIJ1EX4bgybSUalPSDK9qpo5mGhU=;
 b=BH4Vofo4St+8CvwfGd6qUrEEcPXAR4OjJyeRrI5+QtOAGFp+jhEm7tJJY3INXLUneP
 Qm1p7wobl6srRYguxBRiLr0uN/V4YwqB4WlTZgJ1sxWGQyMQKXgLA/iJa92wAEKI3+Nk
 p4AUxFqGjw+kZkySwLANWVxOcQ30zo0Et5ocfjKv1RNE+Tm3diYxRSRXaAlVUe7hCe7c
 SMJ6Lhbm2ENyrORsshuA8vc3a2tIlJUVk0B5xmYLJ75SoKvsRqfcLgvP5sLzsJoaew0R
 nEgSa0T/P1HrkiyxCGiG5dESE3hJ5qfCxxBT8YiviA0eO1F5gl5AgjDvQUyrbseIrRoR
 +eaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTffL5sF38IYFuYnKKtHvHMiqzN6R2XklqABu87wklmKGYWcdfc94HNTrzaimJAX0d69d6Qlrydw==@nongnu.org
X-Gm-Message-State: AOJu0Yxb4iWBpnrmbOE1MWY0RjlzWBllihHOerXvbQqWr5zD4+K65fyi
 y4ybWK8/roWLMMzm+5cWi/F/9tO+WYA8WiZtUqF1tUoiG8nSKtIjKPW8pw==
X-Gm-Gg: ASbGncvbYgQgLd9FEMeB+xwAV2Ag9iRo2XaVwPkfFQqoy+P8SCNCJ0YLIabgV0aWXqd
 lHvbpwv5U4/Pq244wEy2kGlvoMrultHg1dWg9tKH5ZwkAKHxOPbpKpJd0bXNL3aQZihveKxQxrZ
 WbPy0xtokbCMqsvo3zc+gHxmq2j/gh+8wc205jVAJnYIV/3sAXj2qIG7IEyp04b5BuqqmJpFbrO
 j6gXnIOZaYue7l/x57vM/4DmxqsRQtOgoSsvq1sK8NJ0yWkwRVWqSn0Ff9N+4SRC/1RqDD6C94+
 Cvt4Of9H0LECrMavFIoWRcLEJ3xl9LdG7Em4J+9E4SK+IMwwF9Q=
X-Google-Smtp-Source: AGHT+IGlxVm1OVGiHo8O9YGAo0yMldwiYGsNeGlr5ba15ikp7TBijUHJ9BvvyJJqHqxpAT7ZgRLCag==
X-Received: by 2002:a17:90b:180a:b0:2fe:9e6c:add9 with SMTP id
 98e67ed59e1d1-300ff105730mr5520279a91.18.1741697943064; 
 Tue, 11 Mar 2025 05:59:03 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 09/72] ppc/pnv/occ: Fix common area sensor offsets
Date: Tue, 11 Mar 2025 22:57:03 +1000
Message-ID: <20250311125815.903177-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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
index 48123ceae1..c6681a035a 100644
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
2.47.1


