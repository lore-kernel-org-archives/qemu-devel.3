Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7973AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbH-0000bv-OZ; Sun, 11 May 2025 23:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJad-000889-EF; Sun, 11 May 2025 23:12:27 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJab-0006ql-OK; Sun, 11 May 2025 23:12:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22fb33898bbso47266055ad.3; 
 Sun, 11 May 2025 20:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019543; x=1747624343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDqoWuZwIRvGFlMJ4dv35HlEIf/ra31t+mGO69ly2tI=;
 b=kD5RNsCAIYjqvPx0A+xjjt98EShZDlkTF5BynNO0U8f5tcfZ0ay4oCihtCOt+5bK0i
 yKlQeG1942NwwPSIifcnQpVrYP0RfwkfgUj3imvbaySm0/hZcFN2Ba2c8b4WRO3NRxE6
 8KLHUaiHdbhXjCG/sdK7safM7t8OIlFQ9qrQivg0w7F/7YhbR9mvJHxQKzVajdMjYYqE
 Ot3uGqXGV09hBhhsEJlXh+pgaeXypHQhfJIBjDrJFUNYnIKAQAah6N+7cnWrDSPI+lBL
 O21mOfGkhrTiDlJBIBAoWrTUf3GAXPYjY9+J2UtgbPGqeWYvwEaLjo0DlZrcipVNfZyz
 qWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019543; x=1747624343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDqoWuZwIRvGFlMJ4dv35HlEIf/ra31t+mGO69ly2tI=;
 b=FNt4/cfCGsUoXEUCD2PR+fkP9d7HVf8t5zwIUUGJOk2qwskl5/6HLloniKNKLAawQh
 zrbn+h3fUWUJI53DKcf4n+F85KSIfE2GVqX3/+5Rx8OCCQEgEgJOWSxdAOi1sb2dTz+8
 r6YNdEelf0jfXYcaSgHxNsO3O3Ya1YCkowHuYXmGlvYiyeYABw+QQial3rrrwTEbkhKL
 887J/E6EWhOo4stZJldTiQOF9ouUSA2j07EYIcp7e8kY3N5VpWRU1K5JEIa/sqG5TA/X
 z13/04OPA5AULmrfvU0O8UYDwTNFpPbISp5Kjth/PexFScE9OdSlZwI8M+3CzWuHFc34
 7p4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuA4Sfed3csQmiPZtBxbOQ/YEuXubNTC6ccl+PH06aMlW7Xs5fQehS7DLJpJNcLtdGDnOyXYO2Iffs@nongnu.org
X-Gm-Message-State: AOJu0YzF1rVg8UUPoW9JD701ioxVWZnltk72ZaL+Iqs36B97DmCqdV98
 GA5tPYN+rP9LT+1ks7jd9QHb/iB1AtY/sKzNdNmJJUvtyZe2H2JYfeAGfw==
X-Gm-Gg: ASbGncshfsPE+p5nVoUVvRs+kY/1OETPyppsS0kwEiUoAPxTxpoYThYL6Rkwt53HWhG
 JB/skmJ+1b9P3vODwolO8+V9aQCjajz4dnLH8L7deVWPuL5SuqG3vOTUh+gSsexR3gNCUm9URtH
 nXvOOGCM++FxLpdRMEIm/if9gY8MSr3/dZFdtzf99J4mlDR21R/kbnVvlqTsnoxC1253LRAg8D9
 nsT41ZPxtpCsAhkuZjkcFMiLnwY9hDrJLtf/OP50PkIsnnM3LM6AoW+wDs7Pabl+dW8K4namAZa
 QuiZJV6piQdC0N2I96ZcHWVLk9T/L8Lpa6XTeavaMu/zbG1M70oCHpVCsrMQnYSp1vX6
X-Google-Smtp-Source: AGHT+IF1pZ1sGAYPbHdP1EgKQy/1oo/aC1LUr0zUbte5hf3oiq8UI5NE1jDF7FVs0GmFeKCO5qZVSg==
X-Received: by 2002:a17:902:f706:b0:22e:6ea8:8a14 with SMTP id
 d9443c01a7336-22fc8b76adbmr210783205ad.24.1747019543184; 
 Sun, 11 May 2025 20:12:23 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 20/50] pnv/xive2: Permit valid writes to VC/PC Flush Control
 registers
Date: Mon, 12 May 2025 13:10:29 +1000
Message-ID: <20250512031100.439842-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

From: Michael Kowal <kowal@linux.ibm.com>

Writes to the Flush Control registers were logged as invalid
when they are allowed. Clearing the unsupported want_cache_disable
feature is supported, so don't log an error in that case.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 3c26cd6b77..c9374f0eee 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1411,7 +1411,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
     /*
      * ESB cache updates (not modeled)
      */
-    /* case VC_ESBC_FLUSH_CTRL: */
+    case VC_ESBC_FLUSH_CTRL:
+        if (val & VC_ESBC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case VC_ESBC_FLUSH_POLL:
         xive->vc_regs[VC_ESBC_FLUSH_CTRL >> 3] |= VC_ESBC_FLUSH_CTRL_POLL_VALID;
         /* ESB update */
@@ -1427,7 +1434,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
     /*
      * EAS cache updates (not modeled)
      */
-    /* case VC_EASC_FLUSH_CTRL: */
+    case VC_EASC_FLUSH_CTRL:
+        if (val & VC_EASC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case VC_EASC_FLUSH_POLL:
         xive->vc_regs[VC_EASC_FLUSH_CTRL >> 3] |= VC_EASC_FLUSH_CTRL_POLL_VALID;
         /* EAS update */
@@ -1466,7 +1480,14 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         break;
 
 
-    /* case VC_ENDC_FLUSH_CTRL: */
+    case VC_ENDC_FLUSH_CTRL:
+        if (val & VC_ENDC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case VC_ENDC_FLUSH_POLL:
         xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
         break;
@@ -1687,7 +1708,14 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         pnv_xive2_nxc_update(xive, watch_engine);
         break;
 
-   /* case PC_NXC_FLUSH_CTRL: */
+    case PC_NXC_FLUSH_CTRL:
+        if (val & PC_NXC_FLUSH_CTRL_WANT_CACHE_DISABLE) {
+            xive2_error(xive, "VC: unsupported write @0x%"HWADDR_PRIx
+                        " value 0x%"PRIx64" bit[2] poll_want_cache_disable",
+                        offset, val);
+            return;
+        }
+        break;
     case PC_NXC_FLUSH_POLL:
         xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
         break;
-- 
2.47.1


