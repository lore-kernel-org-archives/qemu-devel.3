Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C97C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayhm-00052y-IY; Fri, 16 Feb 2024 08:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayhl-00050a-2p
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:56:41 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayhj-0003ZA-EN
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:56:40 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-296e22229b6so476158a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708091797; x=1708696597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gX9IUPWPcBf9gAlly0i+hCoY3fDrVJRBiGPX7Qe8RY=;
 b=OFS4HSQl4GXcqf2xduWQRK0y2NM90Ejm+PwBhAdWtjFmIxXUINdPetF68UBaNw0BvT
 AR7hCJReKEZjaUsrKgeUki5eBo3hD4KgX6S3Ul0wi5nJaSqrmaYNk2EQ5QeTY4TCb2ME
 XPnrvcgXXoeOZS5lPZWwe4zuwU9mMHl+JzqeuSto6J+i1Vt7bpmtxIR7NrY3L0Q13jYq
 A2CgeW/6qXHsY2lB1PcwhtfFpgVzmfQIiNOGqt9ZJKF6RGef41jNVU9VlBvYGJ4mRxf0
 eF0b+nWBG2dxZ0Mm1Mm3CjrTqQfGLI/0RsbZ+7sWMvYZYa7IuTZRaT1F+JH4LluRyRNI
 ruuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708091797; x=1708696597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1gX9IUPWPcBf9gAlly0i+hCoY3fDrVJRBiGPX7Qe8RY=;
 b=tpG5VQuHLnJDC4BU7NODeARr0uLgXoDXQnFJw3ik92NGE7gKh5sqbGhD7QpAlq9Gtk
 VTO9esPRYCDCKrnF5lmt15K9cgTEQBSBJlixGELw36J9AYWgbWEL8ZXmtz/Qfcpcb9c/
 Eyzs4OMQ1Zxqs+15p2eGhiBKcLBXj5UOvR2pKe1/rcVhmbGT8eIWQm5Hbhmwkop2fTRr
 8lr/pp/PK/FtyLkLmTES3b+oV3ebsgWZ8pziSEqaOUTEcI1KisUg0LlbrSOUin27hJQJ
 pN0TxQXdTeuL2VmrrEo0wL8Mew9uxDRgk3iTXfegYUAIpVfxqBBxm0uptQ1PEvhFNUin
 VADw==
X-Gm-Message-State: AOJu0Yy9BwdvG6vi2Y0+NHnNdhYDBBwxhUSqSJX1PcePM+OOgraZwPxz
 EmIO8m+zYLEV2zv+3wvVw0EPj/mK88e0zly9Wb8IxAUuh8V/TjxoMrlOs/fDX80=
X-Google-Smtp-Source: AGHT+IFF5RZI2telRMBNKwNibKQQtuSsKFYjTBSHKB3VRXujXyWCB+CyKHB874HsT/WOal+NnUBs7A==
X-Received: by 2002:a17:90b:1953:b0:298:c81a:2395 with SMTP id
 nk19-20020a17090b195300b00298c81a2395mr4496568pjb.1.1708091797106; 
 Fri, 16 Feb 2024 05:56:37 -0800 (PST)
Received: from iuseotherswifi.notpua ([14.139.82.6])
 by smtp.gmail.com with ESMTPSA id
 gv8-20020a17090b11c800b00296e2434e7esm3382844pjb.53.2024.02.16.05.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:56:36 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH 2/3] misc: pxa2xx_timer: replace qemu_system_reset_request()
 call with watchdog_perform_action()
Date: Fri, 16 Feb 2024 19:21:38 +0530
Message-ID: <20240216135137.8668-5-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240216135137.8668-3-atp.exp@gmail.com>
References: <20240216135137.8668-3-atp.exp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=atp.exp@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A few watchdog devices use qemu_system_reset_request(). This is not ideal since
behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
to reset when a watchdog timer expires, let watchdog_perform_action() decide
what to do.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
---
 hw/timer/pxa2xx_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 6a7d5551f4..6479ab1a8b 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -18,6 +18,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "sysemu/watchdog.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
@@ -417,7 +418,7 @@ static void pxa2xx_timer_tick(void *opaque)
     if (t->num == 3)
         if (i->reset3 & 1) {
             i->reset3 = 0;
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            watchdog_perform_action();
         }
 }
 
-- 
2.42.1


