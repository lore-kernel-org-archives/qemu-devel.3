Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D3AC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayhr-00055C-4x; Fri, 16 Feb 2024 08:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayhp-00054h-8B
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:56:45 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayhn-0003Zd-FR
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:56:44 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e0f4e3bc59so450219b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708091801; x=1708696601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PElm9I154heYaeu6k8uGuG3u5y2sEE2oCYC2BoRDtc=;
 b=I27y+pgn8h+B9wXCq9TKWdSweYf3igCfbM9Fm+JBb3nCeoawbgKSrGcQKCK50BYl3q
 0ve/qR/vVCtfY3lue4U3rkQr1HcwiGGnhE2dgfTk6nIdobFYsDF+Ebbx+FGBYGiAA9nb
 7P8gJCwNZ6t1ANAw0LMyKkPZry91MLVFpCBPWSXzS5cQ/EERLA5P1G5M1wCxmVCD85/4
 25/+I/qdX67lbThU9jKvkUKe+GiW/GV0t2vAi6gbBAG/kBIt9+LI6h8Wgx7nkV0Jpofy
 vUD+ZN6j9W4wmQEvdnyK0ioxEZQvaAAMfFQEkvx7gS6f5PaGAfcsvrg2pgXJRTHs2HSS
 9Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708091801; x=1708696601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PElm9I154heYaeu6k8uGuG3u5y2sEE2oCYC2BoRDtc=;
 b=CnCVuVEuCb+UT6u5oMTz4V4d+cGTXHalaF9PNT4t1YXmzsSu1ZaVkt8Mwy7rbOrWMh
 6cyGy2WaZaWbu6tWqf3gHJwqMUkmwnJZCPOfxoiImBtUmP7yxD+gL10j5U7nl4gvlZCs
 mewC2TnJ9KUaPqHP9sQCHaWP9ZgMSMwxM0+9fnO3T0yC3OjleAq65EYdRHeHGwANnsKb
 GH+NJRY5ab6vYuv3TkSXyHKbDgWkbm4suFVW77HgcdepdHWVzhc1EWyeCPVzG7KQ1JJi
 9q4rrSZxaPoBh+tEzO++lf6G2ZAPxcGbeNfNS/SjwoUNnXtyzRpiBL39RYYNUTqbrSg9
 I+8A==
X-Gm-Message-State: AOJu0YxdN3kdkAyIQcbPp9yxIytrHr1ZZsHI2qbZ28C6Sh5V1UsbFA03
 gP7a+T/xj1V2+b0H9k7Ke7iEw5bJFeQ68qlCRNZKlVFVoGWH3KXxkloUDWYroMo=
X-Google-Smtp-Source: AGHT+IGO4c8orlI/qXB7F+HSitkKKs7sw5g/P6j5EemsKkbTtmAThWiEI1mXt6Rup6LTSYX3vvjPEw==
X-Received: by 2002:a05:6a20:d38f:b0:1a0:6856:d1a9 with SMTP id
 iq15-20020a056a20d38f00b001a06856d1a9mr5820110pzb.10.1708091801032; 
 Fri, 16 Feb 2024 05:56:41 -0800 (PST)
Received: from iuseotherswifi.notpua ([14.139.82.6])
 by smtp.gmail.com with ESMTPSA id
 gv8-20020a17090b11c800b00296e2434e7esm3382844pjb.53.2024.02.16.05.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:56:40 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH 3/3] misc: ppc/spapr: replace qemu_system_reset_request()
 calls with watchdog_perform_action()
Date: Fri, 16 Feb 2024 19:21:39 +0530
Message-ID: <20240216135137.8668-6-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240216135137.8668-3-atp.exp@gmail.com>
References: <20240216135137.8668-3-atp.exp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=atp.exp@gmail.com; helo=mail-pf1-x433.google.com
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

I am unsure about the changes in `spapr_watchdog.c` in patch 3, it would be great
if any of the maintainers review it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
---
 hw/watchdog/spapr_watchdog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 2bb1d3c532..9751b19506 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -18,6 +18,7 @@
 #include "target/ppc/cpu.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "sysemu/watchdog.h"
 
 #include "hw/ppc/spapr.h"
 
@@ -114,7 +115,7 @@ static void watchdog_expired(void *pw)
         qemu_system_vmstop_request(RUN_STATE_SHUTDOWN);
         break;
     case PSERIES_WDTF_ACTION_HARD_RESTART:
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
         break;
     case PSERIES_WDTF_ACTION_DUMP_RESTART:
         CPU_FOREACH(cs) {
-- 
2.42.1


