Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA33FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCd-0001sZ-TF; Tue, 11 Mar 2025 08:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCO-0001Qi-Rq; Tue, 11 Mar 2025 08:59:09 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCH-0007s7-Iz; Tue, 11 Mar 2025 08:59:06 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so11364432a91.1; 
 Tue, 11 Mar 2025 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697938; x=1742302738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcsPJBP6bO4++1h7GJpYSXw0Uff46Q4C7W6SLg5uEts=;
 b=cPfl47h3QH/D3Lr5jxmwwecgMvdnWqXuI0hfV2dBtjft6yLaSCS3PwJL+9Hn168/tw
 JzuUaEGt10cBNecVZpQllBcdcDVYL4/YO+st4q2+SQZ66mhcQJgoOLg4T5TMvu8hAyJC
 0ro3eHlxTeuqdVqZam7PvsWRg1O2Xkz+taFfdK5uYn6Vf/EMfsxuUPmKZhY3kO9OEc3q
 KVx605FjTGjHSG1XjJme7lL1H2S+8R5Rcm2syTthefF4qRpNbXgljRKf1zGOHkXCWj0D
 7gtzH0Ea+loX6AcjuvV0GfFeK0bN4e3xk6mDPKTC5u5KyXuKTYsUkBO4NGnNEsq6kQcn
 HuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697938; x=1742302738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcsPJBP6bO4++1h7GJpYSXw0Uff46Q4C7W6SLg5uEts=;
 b=wc47OaogXN0H1REW8NeeWOqb768MHaNGXLh3ZBCALHlFDKBYbTt38LKwsrEn8TaNYv
 U/hP5l3pf5pTGp/e8Yf4JjyNa2A9kqXJtoJwlQiuqbSRnPzhPU1OjHcq90PKW2nDsdQZ
 UzFRdIjAbQOka/e/0yLIS3PQWdYDMekYBoXbZ5SDOk1zIjJ5y/8dT/LoGK/Nu+zEBy0v
 mXadyf/W2efgS5Oba0IyE4lASsxLToVz/kfzl0mJLJwGTGjyMcXR8Y6Y1HUVI7J7OERe
 YPMuc3bhQ/pC/6e56vw8uAwqz1cvMKylIylp+gE7nayctQ5xTkp44d0ve1bMVW14muEc
 x80Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe3wtdbookycgWIHSsKnC2djbLA4dNhRZv+h58SyJ9Ol/T3z1GPk3TMzS1vhr45ZNfx0SptopuHw==@nongnu.org
X-Gm-Message-State: AOJu0YxCDd/V2eNS/DbMcXdX2z3MjF3ljeC05AQfQbbOYc3xfxy+4I1h
 IT0cPiCiiY8EjEdZePoU3NlAwLWGMa7GKT+C4I/zpzMQIx+3mGiKl8lMvw==
X-Gm-Gg: ASbGncvkhgQ51l4UlzZoA+EYB9FukBeLrA3381BW6ljpU0tzLJ0a9FFtPunrgNB8HvK
 0K0VcjuLggxHLZn7wY/zHZ69LtvmZr7pzEcFViFIyvgOLXU/fAWLideNVC6cYbDmxd8eX5zKQs6
 Xbaco3aCGsYBEnhkYal/CupuQ4C8Vio3sUL4fkCa3w5nqi+4Yqcy6RZkDjBvmOZvNNEJ4ksaP2x
 x0KI3dfpgEqU+/gsOQ3lKTvxQk0jA9xWf/OpUMKQvzRz7nBRKiZNbOuxc+2Ru997MgZef2+0Y59
 lk0nVY4syxlYLPKdks9VZhzNbCJW1U1o7CWhmZo6lwpsB40mwF0=
X-Google-Smtp-Source: AGHT+IEGGlDAaDwQ0oZiGUGFomsh5DUynMHiKF2q1dA/1Lk9XGFtScknb0Pv6FUuvwx8p4UG4MPh9Q==
X-Received: by 2002:a17:90b:3849:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-2ff7ce9114dmr26936375a91.10.1741697938308; 
 Tue, 11 Mar 2025 05:58:58 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:58:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 07/72] ppc/pnv/homer: Fix OCC registers
Date: Tue, 11 Mar 2025 22:57:01 +1000
Message-ID: <20250311125815.903177-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

The HOMER OCC registers seem to have bitrotted and fail for various
reasons on powernv8, 9, and 10.

The major problems are that POWER8 has the wrong version value and its
pstate ordering is incorrect. POWER9/10 have not set the OCC state to
active. Non-zero chips are also set to OCC slaves for POWER9/10.

Unfortunately skiboot has also bitrotted and requires fixes that are
not yet in the bios files to run. With a patched skiboot, before this
change, powernv9/10 report:

[    0.262050394,3] OCC: Chip: 0: OCC not active
[    0.262128603,3] OCC: Initialization on all chips did not complete(timed out)

powernv8 reports:

[    0.173572100,3] OCC: Unknown OCC-OPAL interface version.
[    0.173812059,3] OCC: Initialization on all chips did not complete(timed out)

After this patch, all report:

[    0.176815668,5] OCC: All Chip Rdy after 0 ms

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_homer.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index a1d83c8149..acd2f7b3a6 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -70,21 +70,24 @@ static uint64_t pnv_power8_homer_read(void *opaque, hwaddr addr,
     PnvHomer *homer = PNV_HOMER(opaque);
 
     switch (addr) {
-    case PNV8_OCC_PSTATE_VERSION:
-    case PNV8_OCC_PSTATE_MIN:
-    case PNV8_OCC_PSTATE_ID_ZERO:
-        return 0;
     case PNV8_OCC_PSTATE_VALID:
+        return 1;
     case PNV8_OCC_PSTATE_THROTTLE:
+        return 0;
+    case PNV8_OCC_PSTATE_VERSION:
+        return 0x02;
+    case PNV8_OCC_PSTATE_MIN:
+        return -2;
     case PNV8_OCC_PSTATE_NOM:
     case PNV8_OCC_PSTATE_TURBO:
-    case PNV8_OCC_PSTATE_ID_ONE:
+        return -1;
+    case PNV8_OCC_PSTATE_ULTRA_TURBO:
+        return 0;
+    case PNV8_OCC_PSTATE_ID_ZERO:
+        return 0;
     case PNV8_OCC_VDD_VOLTAGE_IDENTIFIER:
     case PNV8_OCC_VCS_VOLTAGE_IDENTIFIER:
         return 1;
-    case PNV8_OCC_PSTATE_ULTRA_TURBO:
-    case PNV8_OCC_PSTATE_ID_TWO:
-        return 2;
     case PNV8_OCC_PSTATE_DATA:
         return 0x1000000000000000;
     /* P8 frequency for 0, 1, and 2 pstates */
@@ -92,6 +95,10 @@ static uint64_t pnv_power8_homer_read(void *opaque, hwaddr addr,
     case PNV8_OCC_PSTATE_ONE_FREQUENCY:
     case PNV8_OCC_PSTATE_TWO_FREQUENCY:
         return 3000;
+    case PNV8_OCC_PSTATE_ID_ONE:
+        return -1;
+    case PNV8_OCC_PSTATE_ID_TWO:
+        return -2;
     }
     /* pstate table core max array */
     if (core_max_array(homer, addr)) {
@@ -192,11 +199,12 @@ static const TypeInfo pnv_homer_power8_type_info = {
 
 /* P9 Pstate table */
 
+#define PNV9_OCC_PSTATE_VALID            0xe2000
 #define PNV9_OCC_PSTATE_ID_ZERO          0xe2018
 #define PNV9_OCC_PSTATE_ID_ONE           0xe2020
 #define PNV9_OCC_PSTATE_ID_TWO           0xe2028
 #define PNV9_OCC_PSTATE_DATA             0xe2000
-#define PNV9_OCC_PSTATE_DATA_AREA        0xe2008
+#define PNV9_OCC_PSTATE_MINOR_VERSION    0xe2008
 #define PNV9_OCC_PSTATE_MIN              0xe2003
 #define PNV9_OCC_PSTATE_NOM              0xe2004
 #define PNV9_OCC_PSTATE_TURBO            0xe2005
@@ -211,7 +219,7 @@ static const TypeInfo pnv_homer_power8_type_info = {
 #define PNV9_OCC_PSTATE_TWO_FREQUENCY    0xe202c
 #define PNV9_OCC_ROLE_MASTER_OR_SLAVE    0xe2002
 #define PNV9_CORE_MAX_BASE               0xe2819
-
+#define PNV9_DYNAMIC_DATA_STATE          0xe2b80
 
 static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
                                       unsigned size)
@@ -219,11 +227,17 @@ static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
     PnvHomer *homer = PNV_HOMER(opaque);
 
     switch (addr) {
+    case PNV9_OCC_PSTATE_VALID:
+        return 1;
     case PNV9_OCC_MAX_PSTATE_ULTRA_TURBO:
     case PNV9_OCC_PSTATE_ID_ZERO:
         return 0;
-    case PNV9_OCC_PSTATE_DATA:
     case PNV9_OCC_ROLE_MASTER_OR_SLAVE:
+        if (homer->chip->chip_id == 0) {
+            return 0x1; /* master */
+        } else {
+            return 0x0; /* slave */
+        }
     case PNV9_OCC_PSTATE_NOM:
     case PNV9_OCC_PSTATE_TURBO:
     case PNV9_OCC_PSTATE_ID_ONE:
@@ -241,10 +255,13 @@ static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
         return 3000;
     case PNV9_OCC_PSTATE_MAJOR_VERSION:
         return 0x90;
+    case PNV9_OCC_PSTATE_MINOR_VERSION:
+        return 0x01;
     case PNV9_CHIP_HOMER_BASE:
-    case PNV9_OCC_PSTATE_DATA_AREA:
     case PNV9_CHIP_HOMER_IMAGE_POINTER:
         return 0x1000000000000000;
+    case PNV9_DYNAMIC_DATA_STATE:
+        return 0x03; /* active */
     }
     /* pstate table core max array */
     if (core_max_array(homer, addr)) {
-- 
2.47.1


