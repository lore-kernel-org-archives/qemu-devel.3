Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A23E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnib-0000WW-J1; Sun, 29 Dec 2024 02:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniJ-0007nX-La
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:53 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniH-0002ZU-Ei
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:50 -0500
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so14963527a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457268; x=1736062068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2x1C1KETruZ4XgMCe5FOJyXuqUjk3r6Kg+gcBPkahg=;
 b=O3rpMtHuikT+VN4xJNoQw1YdRcwPs7/jzsechfr2Kz5nzu1hPmMnUM2UxkXSpspmMe
 78fUfwye8LVxFHj5Uewgw5f27MMgo+MmvwngBW3+v79qh2rR1EWUtO5hyKjvNTYtdvSE
 YhktJCt5F77+e6TZctKIujkuz/Q1GqNhe5rQKjeiywBKeh2OrYe5W/fe20WThteilrOC
 3hfe4GRuTrslQ4Ef+z7UfM63mjgUMh3jDisyDJH6kjrzg/xu0Jp0FuEmEHrX3kiQHJlx
 9D4n37z/MK8hW/VoEtmQqYwKW8S3dTaUOs9BLll0F7WbkjpUzUHd5KbhPWDuSdQ27uUw
 MLnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTT52io1/2QtMAUPo91d+kqs57UXtj9hqnJD3rTLPQaBvL2BBahLYghMnZNUw6LU2G9nq9pkRHqweR@nongnu.org
X-Gm-Message-State: AOJu0YxwEo0dZS3UFYyfDHlV4lrQN8c45jUQ63j9YoAnrsqNRVHBPcRe
 jb6OMhiGMm/48JuuVzgMoVD2YlIkGFXftcMD3GzFCz83n6bs+DKejRKxlw==
X-Gm-Gg: ASbGncs1sF03z5sbL97s0sRVe3hfbG5QbE4p3fAXLMW8qEK1JgmZO0DnDOMVDaDcctx
 tNjWefyAs+4uF5QQeax1i0YhdMBDD8ac6I9I7s7eqXxoZQ4wYBwLB3K52qBznZgOti2fQbnCf0X
 xVL6HaidqzXp5yAM2vnaez/lwz8w3v2lv8msX/tA8CZFySlShc47iS+JLcVuEJBwBoAYB5x2lGs
 B1f5DOErsRrAIj/V9UXXlK9ldqh9gR3o7aSBSQU0/dziV9juBSmZvJIkv+lX17EdzlnnS5J/fAb
 3gg=
X-Google-Smtp-Source: AGHT+IGEhPwSp0E2XfirKl/mp8H32vP7eG4+K67DBezTYR/T094GQMQKYFTBEuUk89bY20xLvN4cUw==
X-Received: by 2002:a05:6402:370f:b0:5d4:3761:d196 with SMTP id
 4fb4d7f45d1cf-5d81dda7b47mr27160689a12.10.1735457267878; 
 Sat, 28 Dec 2024 23:27:47 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:46 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 35/35] next-cube: add my copyright to the top of the file
Date: Sun, 29 Dec 2024 08:25:26 +0100
Message-ID: <20241229072526.166555-36-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.42; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f42.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This series has involved rewriting and/or updating a considerable part of the
next-cube emulation so update the copyright in next-cube.c to reflect this.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241222130012.1013374-34-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 513ce5844b..0570e4a76f 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -2,6 +2,7 @@
  * NeXT Cube System Driver
  *
  * Copyright (c) 2011 Bryce Lanham
+ * Copyright (c) 2024 Mark Cave-Ayland
  *
  * This code is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published
-- 
2.47.1


