Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5E0CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 17:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHQUT-0004xr-K1; Fri, 07 Nov 2025 12:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHQUR-0004xi-T5
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 12:43:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHQUQ-00060z-Ay
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 12:43:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47112a73785so6869465e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762537389; x=1763142189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tEVjFw9/vVifKB9WC/qzkxZS2VAp9lKEgO+j94YR0CE=;
 b=dq5+5oL7slxkiVdqVpkONbxWPY3Em49jHrZFaCvFFvrm1ee/NXwvfwJ/H2EidMlU+h
 Yv+ZB2478FPxRws1hrDATxnb5aQ1FQnTTkbGY10U9oACDMaJ0qTz6VMP5rIThWi/ARd7
 YNhGIgC0F/n8uroZhxT9xV4KCit9WW1QUh1RZBrHREB58Iyf6ZecE3LbJVtD8/s/1MaS
 svZjwnIEGtnq/ICmUlijfco3lYqrnnj9djbiPRcVqO8K9aklSnc49TSkPyz/+b99/EZ9
 6YLzxGpRhOAH7lp4rY+1A1nIwLJyolWDgWgL7zdvyynuAfDlwCLg7a9Aif/Y/RCxW6rd
 CiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762537389; x=1763142189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEVjFw9/vVifKB9WC/qzkxZS2VAp9lKEgO+j94YR0CE=;
 b=bnB504dCJdFPnx4aEbaDvbnkkKG1Yn0PLZIjZQFyHVM4OYiOFiCZKcJWJvl3FvUL2U
 +w5eCGTQACImSr7/5owZxKSiDNz/Sm3UXabqT4uNFC28JQxdkgrQzo7TtAMzBe2D+pL8
 UX8A3dqNUrftWXu3zifZQHHAh+5iQgaokJFXxsOTBVonkeh2g7C9LSS+6s21aF0FmFv0
 i+upgMQdbdQUylbuyskWlnt2Vi/d0RZ4U8XHhPu4V7C3yaYJxF1sm9BYKJugLESrSp4r
 /tjjDxmkRwEHaDIBTjZjR7xkj+wIRpFgTKHpW+Jd010GR55ufe7lPkTgqb85n7llorPe
 yS3w==
X-Gm-Message-State: AOJu0YwFeNsMQ5jBySuQuMxnr3yj7FHyIpiNGCdx85T5LvjCP4/L0ab+
 W7B1/Yb1jXxtYZ30VA3BSSwmeD163qTMhz6p0+3/RMgvUABACbWafNQ/TUBBnBsVzWDpBaGHahW
 ASf9C
X-Gm-Gg: ASbGncufpdKjrXzRu19FWUhBNIhaZv+MZD/n+CrK7iPm9o2Qi0XkBWTXSCbnbVBus0l
 /VSsb09+sBAd1H9AmMfMUnhsFqXICVPRCvYVEgFnoBXgOTj6YZPcahxHhdkF9kc1tckWzl9+RE/
 DzxWyjFAgstgHNQ6JtSS4f3Bn8zymVNwT3eqebUnNTHfEV+fyEh0xoqHmbYL20gZyFB+x9up5rd
 LfVSc6obIP2V5gU9N3+s6B4EyxE5d7OI+CZwjPLXjP2xeD3iVmz2d9dnW+QgFm3SNDSUlOJjLx2
 v0iT0f0o6MUMqBC5AyhF9U8tjsWGtb/fBZ4+yp1KZ8X4qCDuV/iETXKUfDNV8wJerH6IvIkquol
 tPcr5AkXVsG0s2ZK04n328CG8t0DWS3KvZ73sDXUytUwwOSLQMyzc3wRMZJbfXKdiLxrIMndYWP
 mhQ4p8Lg==
X-Google-Smtp-Source: AGHT+IE5xLAWx3pBfpnQe/mEi0SJ5VKOBkPJkHHpj1eRa5I9/Fyuo/JP9OSgydUwFOGt7L82LXO48g==
X-Received: by 2002:a05:600c:1c0f:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-4776bce1b13mr31231085e9.20.1762537388661; 
 Fri, 07 Nov 2025 09:43:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47767749916sm97058845e9.4.2025.11.07.09.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 09:43:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] system/qtest.c: Allow for multiple CHR_EVENT_CLOSED events
Date: Fri,  7 Nov 2025 17:43:06 +0000
Message-ID: <20251107174306.1408139-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In the qtest_event() QEMUChrEvent handler, we create a timer
and log OPENED on CHR_EVENT_OPENED, and we destroy the timer and
log CLOSED on CHR_EVENT_CLOSED. However, the chardev subsystem
can send us more than one CHR_EVENT_CLOSED if we're reading from
a file chardev:
 * the first one happens when we read the last data from the file
 * the second one happens when the user hits ^C to exit QEMU
   and the chardev is finalized: char_fd_finalize()

This causes us to call g_timer_elapsed() with a NULL timer
(which glib complains about) and print an extra CLOSED log line
with a zero timestamp:

[I +0.063829] CLOSED
qemu-system-aarch64: GLib: g_timer_elapsed: assertion 'timer != NULL' failed
[I +0.000000] CLOSED

Avoid this by ignoring a CHR_EVENT_CLOSED if we have already
processed one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/qtest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/qtest.c b/system/qtest.c
index baef06d4d1b..67e2385f4b0 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -815,6 +815,10 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
         }
         break;
     case CHR_EVENT_CLOSED:
+        if (!qtest_opened) {
+            /* Ignore CLOSED events if we have already closed the log */
+            break;
+        }
         qtest_opened = false;
         if (qtest_log_fp) {
             fprintf(qtest_log_fp, "[I +" FMT_timeval "] CLOSED\n", g_timer_elapsed(timer, NULL));
-- 
2.43.0


