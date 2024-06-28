Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10D1C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dm-0000Lc-Jb; Fri, 28 Jun 2024 03:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dd-0000Hf-Aa
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:18 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5da-0006ik-Eu
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:16 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eaea28868dso3184441fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558192; x=1720162992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JpVotoHspFlZ3BpKrTY/FaOKVvxynyJagKJZJS+6h3k=;
 b=dbO0HjE7Lo7Xo1HZggB4F7WgZIaNFTWwD/bPtr+sK+PD6MNwMGeQYsnCUXR0vBzgLm
 qImMVpyGIPJlz32DblgajCObsSxg1utkrGPyV/eQPIUuj/Vn44yhQMZSk0ID9+DBDkdm
 8pIK/Z5JtzE8F5+W2OQmZB2HI1uiDlu3/QW0cF5yDyd20ZAkqcB2IWohuopwUUlbe90Q
 d6gpSHa0JkeF915lNzVTUM598LZwtE0ehmLi8z6z0WhDNB5BlzPIIvrB8HbQKXdXUzrV
 0LxATLCxSXHS/QYw2Pt6apXfDwZGUOwG+4V5XiQr49APUrgUL+jKDGAyvMk3j0tsFYCP
 q8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558192; x=1720162992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpVotoHspFlZ3BpKrTY/FaOKVvxynyJagKJZJS+6h3k=;
 b=QNRWi6TX+gz4i1s65seKg449iCUKiN3E/s2CcwUN0Yf3OUYnWOMf/IYskLHXvGyqTq
 utmmOHq6j4dODKqrogM0824GRzH2pWu6dAWAarGWz+5KrkxrPBb0uyMiQmoH9A7wyvur
 5rLDIO54+E25TZGRuMx2SY9TFFA1RySuLDgELmMyr70iptkB8tiBBuhUIykJDOWEEcnJ
 jzmPzCgeSL4f+4sj6m1dEveiQZoSE64KJAumyDpRbCk767kyqBjkPI080OEpCgkEAkvU
 NQvJC9R0UnZIjtWalFX34EVl/kJ1lgQxFCSbP9Taowoa+OCATCu9a4OLVI39OE2gQWvP
 bJUg==
X-Gm-Message-State: AOJu0YzRfwlDXd/nUno4Y8ecsyOUBP+cKyYO1OUfjdIjVqGJFGI1gIUH
 v05INdeL8vOSp4+PdI3zECqvzA1Qcu4taMYW0/Cvgna0SG/4RIGNV26C5VxW6cWevoGjbMJOlW8
 4Sq0=
X-Google-Smtp-Source: AGHT+IG4uitz8ZON4/9qKI7gHG5vv1fiAu2SHtAGAqC3kSP8gR0G2+5fFfTkAAD9aolaWJRmeiLKcw==
X-Received: by 2002:a2e:8746:0:b0:2ec:5685:f061 with SMTP id
 38308e7fff4ca-2ec5b2d6313mr123829411fa.21.1719558192057; 
 Fri, 28 Jun 2024 00:03:12 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c19eesm21186555e9.45.2024.06.28.00.03.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 10/98] hw/sd/sdcard: Assign SDCardStates enum values
Date: Fri, 28 Jun 2024 09:00:46 +0200
Message-ID: <20240628070216.92609-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

SDCardStates enum values are specified, so assign them
correspondingly. It will be useful later when we add
states from later specs, which might not be continuous.

See CURRENT_STATE bits in section 4.10.1 "Card Status".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 135b7d2e23..fbdfafa3a6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -75,16 +75,16 @@ enum SDCardModes {
 };
 
 enum SDCardStates {
-    sd_inactive_state = -1,
-    sd_idle_state = 0,
-    sd_ready_state,
-    sd_identification_state,
-    sd_standby_state,
-    sd_transfer_state,
-    sd_sendingdata_state,
-    sd_receivingdata_state,
-    sd_programming_state,
-    sd_disconnect_state,
+    sd_inactive_state       = -1,
+    sd_idle_state           = 0,
+    sd_ready_state          = 1,
+    sd_identification_state = 2,
+    sd_standby_state        = 3,
+    sd_transfer_state       = 4,
+    sd_sendingdata_state    = 5,
+    sd_receivingdata_state  = 6,
+    sd_programming_state    = 7,
+    sd_disconnect_state     = 8,
 };
 
 typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
-- 
2.41.0


