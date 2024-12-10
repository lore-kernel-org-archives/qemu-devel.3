Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85067E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYd-0008Np-Gm; Mon, 09 Dec 2024 22:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYb-0008NG-Pg; Mon, 09 Dec 2024 22:05:05 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYa-000324-1c; Mon, 09 Dec 2024 22:05:05 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21654fdd5daso14394095ad.1; 
 Mon, 09 Dec 2024 19:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799901; x=1734404701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LruQ9KYnQvDqCmEjdJ3ocQyVzKWaqruAqXQDYmuVWDI=;
 b=KWtziRYEZYhLAm/1kd4PfpBDA9r9DUz7B3XNNxaMJNdWoBoC1r0s0WiwvJP268F/O3
 rO+bFswfYbgbMdA3SvnfCPLSRsbLwAOJKyl+IXG9Ua/ukiD3UNukVZMkG76fEc5P8gSq
 Q/PlZPxjGiOvw2HF0zPjM+FcsdNdSFwPYBnz3yBrNF6cry/gq3w7EjLMrkCPVXsn1TPx
 BUGhNGN+5sZuy2RHhzP9I39ALP3WQPHRvUReAqlPEUxhwIg3PwnriN3Bu+Thrk5vWz1Q
 UTasP8xrAktKelCiq/2fDOC4Iel6sfLtmDYRMTrfpxGLS5d1VpjYsrBPMGh/dZqHkFHh
 XpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799901; x=1734404701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LruQ9KYnQvDqCmEjdJ3ocQyVzKWaqruAqXQDYmuVWDI=;
 b=eOJHvcsG/0AZO/MMmvWDtAEkqikmwyjKm9j1hfVx06e9ea52WwBOZrLkCUZmuYnhvQ
 DFgO35QljhnI+LB7Q/wM1qmJVC1177mErkrWMHKPGhffLjDJZGnr6eB3GW0PB9AZtKXW
 MSDX/AOOODRd1IkjLTiv7Bz7ODKmXTFov30zGyT3fMe6YAiW/UnT/KU/El8KYAr4tncH
 xLgRSmQMwRIJBNiK2b6k/2G9BO2+5yZ+SKTuqdL7RpXO3QjcBX3pa/TokCRjsPa5hJ/f
 oUpp7gQxrKh9pkDXKTj4zwTXauW3t+RP3isWjZhsU6K2TgNBFh4Xfhpx+odJJdKRHYuH
 muPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnFwjN5T607KW2jlS2IJhwqU0eLOa/rK/gb5+tW807kabj+3W3plGVJ5vU4AN5DGKx6qmrDNJd8mIt@nongnu.org
X-Gm-Message-State: AOJu0YxMQuFLP+Y1SLqUaOvyEk9ma+fVrSByA6geNoEmsKxBYYs7CeO3
 ZeYMI0yd9XM52qGXexSET2eI+onVVSbYE+6M4ZAL2O6moxanVOBPQw+8vQ==
X-Gm-Gg: ASbGncvRYQ2kthtvUg95A0+pfwxqQDdZi6wAqUxLJcoDwC2dFCGBguN+vIhD0eUVtLI
 KcjvWVc+1SYV7fi/YqMVvZragfevlM3x2M6TtM3JIVc7skPipY5lEOjpdQXN5nEeZar+QziUdxe
 VtoQjA0s6vi7S3TGfNqG7pmD0Po/ISMUSaYpo9O1CZUUuRPXoyhCIMoe+i5aO4CzyYkpXg0BnHR
 oqGxzyaTzUv7cNgXH+DyD0UJ1tkrlTDXIgFLA/5pt8sFyBW/qhZk/WLLZRt
X-Google-Smtp-Source: AGHT+IEeZ47upPHlR1XHdhXujprX+K/RYm7BKOFrEw7Zft4zif//BXfWbvRQY4MK3LKEitsCr7ml7A==
X-Received: by 2002:a17:902:e947:b0:216:239e:f90f with SMTP id
 d9443c01a7336-216239efc60mr226081345ad.37.1733799901431; 
 Mon, 09 Dec 2024 19:05:01 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 1/9] ppc/pnv/homer: Fix OCC registers
Date: Tue, 10 Dec 2024 13:04:41 +1000
Message-ID: <20241210030451.1306608-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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
index f9a203d11d0..9aedc08cc00 100644
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
2.45.2


