Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1F7C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvay-0000FT-QA; Fri, 02 Feb 2024 10:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvav-0000Az-Ha
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvat-0004Rt-PJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so19934225e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888202; x=1707493002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zT33TDQSpbP682JXm0Djn4kZLyqr6gakrEoe9mM4ahM=;
 b=mm6mWc1L1bgPHg0tfzdhYBnDCCOQ6pKKcrpkOOryFWamXhrG2ji3uRFYEBgVKyZRfO
 5IJEZZHtGn0fnLNJDzOReLyh1z5WM3MB5eWVbgg+h73pTrU/rPhq0f29+bWPI4LhsFmX
 cVwGFIy0hsb3o/tOPREyP8RgiyapJAY8KiySCdoUnOLq8w4Ai6Ec4eAismbDOFkTH3PT
 wQg1Y9X5HcdXBHVZU0/bAZ/dD7VGcvH+qynGRP2NHX35tKROzMkJnglanWsOFT3kqllR
 3N+FZ6wP8hdLsTXgzHvgqZvR0HqbqJ+NxEA9zH09vemP26jOHUAhOPvlvqg7Im7bUj0j
 e3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888202; x=1707493002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zT33TDQSpbP682JXm0Djn4kZLyqr6gakrEoe9mM4ahM=;
 b=l/8QvXLArPScobkvYXJ8IsaMZ7ev14sh7TEIuS/eRjNvKA4UG87OeCeMY9t/XK7gbE
 VOEQ0/BPL9MjXZOqa6S26OtF20nzkp3wZFaLC+Wsy6oqI9Ae1A9vfScc2pskkUBlSW9N
 rReRZibegjGZXTk1UbJfsB213T5pULpBNAKTGAk4IvdAQzRSyTytQKwby70FaZ+SFcBr
 sEVx14XR1hCmLuyoKQuv8atW2d5FWqiU651OgOLQ+kWbBa5bNQjlF0OGy/35PtYDrwyc
 f9Q85UalAntmytuSqb9IWP3fwIjhw7jvynYEqLIqG59IOT6winYP1y4zsn4JwVfVfBh9
 iH9w==
X-Gm-Message-State: AOJu0Yym8PnOFlqPS6XfS3NbnURZIeXYH9xqQH3+DAe1iJ3+NC7FacZd
 SUW6Q+YSoRyAGbG4qc92sZhgWsicMriOERDwaWzFwzfiYIeLuEepv0oBt30pzmshi5GG+4PM1C0
 o
X-Google-Smtp-Source: AGHT+IHjKEMfHHK6OQMK4cAorQm+MYbaCF9hw2XQyr9vYsc19vjLZWeqS0deCXcTTZs6h2GL5h+75w==
X-Received: by 2002:a05:600c:45d1:b0:40f:b0ca:2b2d with SMTP id
 s17-20020a05600c45d100b0040fb0ca2b2dmr6271565wmo.1.1706888202323; 
 Fri, 02 Feb 2024 07:36:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/36] system/vl.c: Fix handling of '-serial none -serial
 something'
Date: Fri,  2 Feb 2024 15:36:08 +0000
Message-Id: <20240202153637.3710444-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Currently if the user passes multiple -serial options on the command
line, we mostly treat those as applying to the different serial
devices in order, so that for example
 -serial stdio -serial file:filename
will connect the first serial port to stdio and the second to the
named file.

The exception to this is the '-serial none' serial device type.  This
means "don't allocate this serial device", but a bug means that
following -serial options are not correctly handled, so that
 -serial none -serial stdio
has the unexpected effect that stdio is connected to the first serial
port, not the second.

This is a very long-standing bug that dates back at least as far as
commit 998bbd74b9d81 from 2009.

Make the 'none' serial type move forward in the indexing of serial
devices like all the other serial types, so that any subsequent
-serial options are correctly handled.

Note that if your commandline mistakenly had a '-serial none' that
was being overridden by a following '-serial something' option, you
should delete the unnecessary '-serial none'.  This will give you the
same behaviour as before, on QEMU versions both with and without this
bug fix.

Cc: qemu-stable@nongnu.org
Reported-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240122163607.459769-2-peter.maydell@linaro.org
Fixes: 998bbd74b9d81 ("default devices: core code & serial lines")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/vl.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 60fd1e56b6b..bb959cbc440 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1439,18 +1439,22 @@ static void qemu_create_default_devices(void)
 static int serial_parse(const char *devname)
 {
     int index = num_serial_hds;
-    char label[32];
 
-    if (strcmp(devname, "none") == 0)
-        return 0;
-    snprintf(label, sizeof(label), "serial%d", index);
     serial_hds = g_renew(Chardev *, serial_hds, index + 1);
 
-    serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
-    if (!serial_hds[index]) {
-        error_report("could not connect serial device"
-                     " to character backend '%s'", devname);
-        return -1;
+    if (strcmp(devname, "none") == 0) {
+        /* Don't allocate a serial device for this index */
+        serial_hds[index] = NULL;
+    } else {
+        char label[32];
+        snprintf(label, sizeof(label), "serial%d", index);
+
+        serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
+        if (!serial_hds[index]) {
+            error_report("could not connect serial device"
+                         " to character backend '%s'", devname);
+            return -1;
+        }
     }
     num_serial_hds++;
     return 0;
-- 
2.34.1


