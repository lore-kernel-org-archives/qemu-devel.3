Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E62C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8L6-0002IF-QJ; Thu, 25 Jul 2024 19:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kz-0001jk-1R; Thu, 25 Jul 2024 19:57:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kx-0001P8-7y; Thu, 25 Jul 2024 19:57:32 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cb4b6ecb3dso297516a91.3; 
 Thu, 25 Jul 2024 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951849; x=1722556649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2cAXhmP7xhWiA5NpqALGrPpy40t3KUbUFo6EvSVB44=;
 b=CvZUgctmiW0ABOydlXweALhFbMf6mOnXVnlpWVV8UdQEEhEvef7+aPqKQ/36IkJ0lZ
 1I1gegr17ltUa29V+UWYFEiwEGE7kGsx/HSShUrGQtkCR8Nu122GWKL/a3KXLFHOOdyH
 Ab78M0Ur3Fe8bxQZwxYX2XixdD3iFNyltfwjeo5yieERrgAznzTlCv4tWfEvPQoRwHqH
 86gxS+tkB58JnkdRQ9BhkQn0NgJ/DMTtwJQySSE8Q7chXB7jKUWzzimKJ+E7JUPGCt4E
 EQYNi8zjlk3Z0JTdfKuUvaEoJ39ihs5yFe47IedGItjxkBCDM+IRu+P4KsTiC5eW4UIL
 3wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951849; x=1722556649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2cAXhmP7xhWiA5NpqALGrPpy40t3KUbUFo6EvSVB44=;
 b=gxpJrf2WqCTrypUNmA3xu0L2C1HHRN0rC1XvRTmQgQc/gB+2kq9AUXMx0IErnizHVx
 Yw9vkBFp5jMAb+CmC8nktpoO18bHmtZBoVxXBY7jM2M8PY+A8MqXgPcoMPz/CvFXbj+/
 LBpIaV7OTFFyfRBEaysOpDTp2DOFXLOqoRELS4/vyqckxy+pFfq1GNHAuOLkfArdcYyP
 SvD66MocHvqPAYA2FQqUBGmNFNLRJpBBmYUFdrWsH7Nbae3qpt2wsalL/g5//gCW4dTY
 M6bHQ6BC6dZKT6enaeEFZV42GynXSVTNH9Qq69XkBvv/EPcTY17yV24odWkoxhf/wZCz
 I/UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbKeG0zKY01cac7q4m+O5w6XwkL9fWJm+8DqchhUMvkPsP/8gIPZjn6PChi9VuqycGcDb0K9VzUHhYNHZheagjjdGa
X-Gm-Message-State: AOJu0Yyxkp24R9qQRlFQOqMx7G67QtUFBoyWOlxQYe5PFoGwdS9Db1u2
 RbeseemOLGoejxDb63QSjFtPUED6eb2JpvIC1WVc9D1TqIr9hTiE9gvINw==
X-Google-Smtp-Source: AGHT+IGvrs8uY48BGxlTcYhMl6DBTGkn0vvaQlukFlmAAAvCXsp+j9vEE9eand/jMHNk+W1WObt33g==
X-Received: by 2002:a17:90b:4a81:b0:2c8:946f:5fe7 with SMTP id
 98e67ed59e1d1-2cf237b7c93mr5442647a91.17.1721951849017; 
 Thu, 25 Jul 2024 16:57:29 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 51/96] pnv/xive2: Refine TIMA 'info pic' output
Date: Fri, 26 Jul 2024 09:53:24 +1000
Message-ID: <20240725235410.451624-52-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

In XIVE Gen 2 there were some minor changes to the TIMA header that were
updated when printed.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 70f11f993b..5a02dd8e02 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -692,9 +692,15 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf)
         }
     }
 
-    g_string_append_printf(buf, "CPU[%04x]:   "
-                           "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2\n",
-                           cpu_index);
+    if (xive_presenter_get_config(tctx->xptr) & XIVE_PRESENTER_GEN1_TIMA_OS) {
+        g_string_append_printf(buf, "CPU[%04x]:   "
+                               "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR"
+                               "  W2\n", cpu_index);
+    } else {
+        g_string_append_printf(buf, "CPU[%04x]:   "
+                               "QW   NSR CPPR IPB LSMFB   -  LGS  T  PIPR"
+                               "  W2\n", cpu_index);
+    }
 
     for (i = 0; i < XIVE_TM_RING_COUNT; i++) {
         char *s = xive_tctx_ring_print(&tctx->regs[i * XIVE_TM_RING_SIZE]);
-- 
2.45.2


