Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB7AC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ3K-0004it-SI; Tue, 15 Jul 2025 02:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1q-0003Gl-3R
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1k-0007PW-1L
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4561607166aso14859875e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560425; x=1753165225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynSWv/Qrgid3k9uBxFI+RTPdBaS744OcQkC40jCmXSU=;
 b=owRgY8ZzfThy/Q3aAXRYjea6unakkYYAopwU71Asm2RAKGDFCnV+RatFOgNxKi4B62
 hRmNobNbV/l1uSX2fHldPMO2FDhMCw7HShYeNqL+j5t4fV+f8yiVpVnGRGf1nuschbQN
 ElR8SpKwuxTl0GlA0dk7E4LTlvHmpz/H+VSxSLWcdAw172xSV+XvRTxai/b52+OCfkKW
 Q0Y8GSWWlNc8w5VKf+gn6fzT513GC/8jdc6ezx28UcMylkOJ0Jbg613dQ+ozhwAK0rU6
 7Nl9EXGwFhH1g5xCXp7iCwiSWtH8JAZ1yjmm9PTCh63czBNMCdyVu7B0ElyLcrIjr6oM
 mYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560425; x=1753165225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynSWv/Qrgid3k9uBxFI+RTPdBaS744OcQkC40jCmXSU=;
 b=MLqUHjUAsqcvIJ1R6bFpXTNJ7WcAhqAETyTwodnSJuqVAtKMQJGukv09coGyW8D9vP
 K1XBzQMeShQ9NJtbwj36g6HwMQnUHgTsr8T2cV24hEqtc9kmB6JH1VVNaMwjh6/TjBKl
 tCkuehY3kscUNr9tkA1KT+e35npV+t34bmfZ7I1NA3HhCKcaTQp+8XeFlb07ty0hs5FQ
 BHN1411mGwvg44z85RxzMJY/O7txKhlkOSFvzAJJG+JFgaEm9XFD3fmvF5LhVME7/s6W
 fT5nosKYZ6ej3Kosyb05+VSPOTEeQbB0d6inzCkaXYH14CNcNFATrqxJxp8CDGT0MQ9y
 20BQ==
X-Gm-Message-State: AOJu0YxtJJEN2WhBdIFZGfo5VYtRzTp7F8MDYTWzPe2ahcQkVn0P4G8z
 eX/mFZqAzKWIUhmUnct+3xR68SZjOsMA1Xjm+6F+vzYHer6yrCZ5UFmKbmyyBwtFp1DY40JCQD1
 NR1m2
X-Gm-Gg: ASbGncujxYp2jS/qyCLd1q+Xi733GZXl90m8gZdVxCH7kfsuQa9qSQgjhu7kQgOsTRU
 wOTboh1zqilZLPcHu9cBCjlb9ByRMmXoQuOu9gyxCv0SI5j0EdJ35JLAakvITukREB1V2UkYjYL
 +HVpfEKdPJVkAlNFecR4TjmmP1tKHDSYaDBxxsSja81YICQ/3lVRtx333KONmND9db+i/bX2o1K
 mhJM9uiY2DQygyMk+Fm1eYN4nGo4vrUw10yxTRyNYmTG5VwbdLrIheTuN4DBI9Fz3A7GBfu3IuC
 cB3onKAW7w9OEAWwed+5Y106/OBf852DLanvNyPsrSgwWx+KCYHFuJuQgh03zJmJAQ5knu+NJqC
 DDNWEHkMBQs8UeffNZor5eFM3FkS/d6KKVHVYe1fgVvJwG3OaQ79No8ksgl4pEdmslWDhlUpY
X-Google-Smtp-Source: AGHT+IFDpbBwXEbGCiqg1cmoPOfmDg3T4I0ap9sS8hckmTecCimesS2QtZkqoTS56WGjAnxY8IWz8Q==
X-Received: by 2002:a05:600c:8505:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-4555f895526mr142828575e9.3.1752560425510; 
 Mon, 14 Jul 2025 23:20:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d571sm14481044f8f.57.2025.07.14.23.20.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 13/17] esp.h: remove separate ESPState typedef
Date: Tue, 15 Jul 2025 08:19:13 +0200
Message-ID: <20250715061918.44971-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is not needed as it is now handled by the OBJECT_DECLARE_SIMPLE_TYPE() macro.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250711204636.542964-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/scsi/esp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 533d856aa34..c9afcb7cac0 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -14,8 +14,6 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
 #define ESP_FIFO_SZ 16
 #define ESP_CMDFIFO_SZ 32
 
-typedef struct ESPState ESPState;
-
 #define TYPE_ESP "esp"
 OBJECT_DECLARE_SIMPLE_TYPE(ESPState, ESP)
 
-- 
2.49.0


