Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E07EE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH84-00018z-U7; Wed, 11 Sep 2024 02:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH81-0000uh-AI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:47:01 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7x-0004QX-Ga
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:47:00 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso10839345e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037214; x=1726642014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZtRldQU1q8wU6EHCfF9wA3KDcDHpctGTgp2Kf7weoU=;
 b=xSPoO/tQID3jne5T7GE5MfM4ysFZc5fTIMBwfPaBgRXlrHEPWH4eXF/SPMsT1vroW/
 bQ80/EUvQWUBdieGDC49tCV8Rjf3aQ+AtdPyPyDpzY3N13fyizBbBNCtqoDUlMSNCe0I
 Kc1E1F37/i4+O2dbd57w6rhaA2oz3E2YjBV+KDnZAcrPmEXVJhoLsEcXjtV9D2ZgR0Ad
 diPB3jiU1hCaJOMUZ+TrlLHpWDbYI9EsW5rGJ3zDOL6cDmuQnZYQs2jxJGmZFyjp46ES
 eCnbHyMo1nqTNYUJIIXHeqDa5r/THJuyge1J/pqlA5bsJ0vJz4feY6BSVh43fmPk9hWd
 XayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037214; x=1726642014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZtRldQU1q8wU6EHCfF9wA3KDcDHpctGTgp2Kf7weoU=;
 b=sstC51jHW/I9Pdrw7/QHK9QMy+IliEnG1NRWiOjN4Rn/5M847Z7yjlA0OSGs94duv4
 QA3vSSU512L0tmUzGtCYk8vBL+wPp3NUteckMRV4jTD8ys7ZPJ2XSzJlYZi+xGek2wAp
 oT8ivqqB+0kzM2+2gK8V2wlESNb8YoiqvnQb9Qa2K9mkaDzriz0tMefOrJgXTmaQYvaW
 3tpqixs28UQVhhadKt06ygIPUQI3BG4/LWazyuRcMWptVmcNUXYDfsgG4/WmlxoRZ5WH
 PjUsQldA2DSIr0kOOxvpnn7w+JLzHMaAa2tUryxwJwIOQRHg8zO8s8LR4p26wWsOWxkZ
 hScQ==
X-Gm-Message-State: AOJu0YycDvx1BcoQypfR6V7N/l4ZbPF3CMVDY8I/AnI8fFaoaKEvAklm
 jFBI7HLERAgeYsYnvMADo7nVDV7rWPv5P+jfjl0y66xXZyivohkKaMZxjF7/EmMMavsmVBM1ssH
 nHfI=
X-Google-Smtp-Source: AGHT+IFjTI5gjBj3mll2Un4GLsSviGo0iCKxnWpjxb/LrYmzAbkDJBfZ04HYBjydmqbyPMeJVEyW4Q==
X-Received: by 2002:a05:6512:3d20:b0:52c:deb9:904b with SMTP id
 2adb3069b0e04-536587f8770mr12981179e87.38.1726037213381; 
 Tue, 10 Sep 2024 23:46:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d258354d1sm578640466b.13.2024.09.10.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC1115FA1C;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 09/10] tests/tcg/aarch64: Improve linker script organization
Date: Wed, 11 Sep 2024 07:46:44 +0100
Message-Id: <20240911064645.357592-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Improve kernel.ld linker script organization by using MEMORY command.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240906143316.657436-5-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-10-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index 7b3a76dcbf..5f39258d32 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -1,23 +1,23 @@
 ENTRY(__start)
 
-SECTIONS
-{
-    /* virt machine, RAM starts at 1gb */
-    . = (1 << 30);
+MEMORY {
+    /* On virt machine RAM starts at 1 GiB. */
+
+    /* Align text and rodata to the 1st 2 MiB chunk. */
+    TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
+    /* Align r/w data to the 2nd 2 MiB chunk. */
+    DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
+}
+
+SECTIONS {
     .text : {
         *(.text)
-    }
-    .rodata : {
         *(.rodata)
-    }
-    /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+    } >TXT
     .data : {
         *(.data)
-    }
-    .bss : {
         *(.bss)
-    }
+    } >DAT
     /DISCARD/ : {
         *(.ARM.attributes)
     }
-- 
2.39.2


