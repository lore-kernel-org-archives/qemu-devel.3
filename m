Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEFCC48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayhi-0004yS-QG; Fri, 16 Feb 2024 08:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayhh-0004yI-JZ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:56:37 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayhf-0003Yo-Mo
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:56:37 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-290ec261a61so1324361a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708091793; x=1708696593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POgfkVVu83Vm75+SuvVmDFMZzSx8Ahq22ouOJhX3uno=;
 b=mWNXA0HgB+847rhzh+P1qum3fZaTzBa6N3ny4htBVED/SdEt1fdDG2fUCBZ/4DHzdc
 NRvvJc2pFmhv3V8/hIR8Vvhbz9vJXzXCysG7oABjx+x/GwO4Htqy+VZC4Mpsj60Yg73N
 w+o2el1RMO+o1WSxJHHzF5hxM7sWeiPjJhca2MAXPV8FFhJrOEJNRQwkH9OGKVOAezRW
 D7vruPOHMMCJhdcOD+mO+Wl6i6CHrKDS+gq1H/FZoK6DSb4H3TLboBDp3phZ3H0YHBg6
 Sf1NEes2lCp0VmtS05pldIDHt6wvbaJLcppnA3ma+dR01xmRne9AmzfBRPlCXT9O75f7
 NRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708091793; x=1708696593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POgfkVVu83Vm75+SuvVmDFMZzSx8Ahq22ouOJhX3uno=;
 b=JULqUG4nJb16o1WZzivKVIkN2cHRjStctrOmNd1VNdwQwWVjSHqtEWJVwS0c12kVoS
 9jkuAdBDo/sSleI8G/yHyX4OJfOyKlxSwACDsnmV8YQQ93Oxo4O3WFQyeLUXs/EKChf4
 5f3LB9qec4CMlk5swaI7luWukbqDv3kGhFqnfJnK0uSj8DIjE9kMJpjxsu3xqFuJMwg7
 QPLYeNWMuy54GRpdyUWk/0kQ1jPDwBfc92MUD7sRuaq20bh+Rf8x2KgkL28iXPjf/F4g
 8rMKhh6StzjuQwfReVB2HWiVy+x52ERFRFee/mHclSk3Hjj+AU7+RhKLVBeM0a7WKcpW
 esOg==
X-Gm-Message-State: AOJu0Yx2EYyT9za8dhO5RA+dHiEEygAoTlqxeKn6Ds+M91oOWYTs84Ag
 TM/5ELg78upxKaduV4a7iPnwPKrAw8lhz0qwecza0z2eYCIJ2xUFDZvHdS4hjTE=
X-Google-Smtp-Source: AGHT+IGpbjDgJ90TwkfIlZmijpSkQXLOwcQiUKWD1Rbo9DnCXs7EKrQhu9GyiS+FDx7FNjFwe+MMtQ==
X-Received: by 2002:a17:90a:f597:b0:299:2a8:55b0 with SMTP id
 ct23-20020a17090af59700b0029902a855b0mr5471604pjb.23.1708091793151; 
 Fri, 16 Feb 2024 05:56:33 -0800 (PST)
Received: from iuseotherswifi.notpua ([14.139.82.6])
 by smtp.gmail.com with ESMTPSA id
 gv8-20020a17090b11c800b00296e2434e7esm3382844pjb.53.2024.02.16.05.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:56:32 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH 1/3] misc: m48t59: replace qemu_system_reset_request() call
 with watchdog_perform_action()
Date: Fri, 16 Feb 2024 19:21:37 +0530
Message-ID: <20240216135137.8668-4-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240216135137.8668-3-atp.exp@gmail.com>
References: <20240216135137.8668-3-atp.exp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=atp.exp@gmail.com; helo=mail-pj1-x102a.google.com
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
 hw/rtc/m48t59.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index aa44c4b20c..ebda084478 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -36,6 +36,7 @@
 #include "qemu/bcd.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "sysemu/watchdog.h"
 
 #include "m48t59-internal.h"
 #include "migration/vmstate.h"
@@ -163,8 +164,7 @@ static void watchdog_cb (void *opaque)
     if (NVRAM->buffer[0x1FF7] & 0x80) {
         NVRAM->buffer[0x1FF7] = 0x00;
         NVRAM->buffer[0x1FFC] &= ~0x40;
-        /* May it be a hw CPU Reset instead ? */
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action(); /* watchdog-expired action */
     } else {
         qemu_set_irq(NVRAM->IRQ, 1);
         qemu_set_irq(NVRAM->IRQ, 0);
-- 
2.42.1


