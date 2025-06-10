Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D84C61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6Wd-0005Zs-Bp; Tue, 10 Jun 2025 17:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6WY-0005Ui-P5
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:28:50 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6WX-0000h0-3h
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:28:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74865da80c4so608229b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749590928; x=1750195728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVY2h3n6p5UCM76x7xGwJIthJDO3448sqBl62JxkyBE=;
 b=m5bOhuLDaqavMLzVhEliOA/dXEkCEk26nmZ/dYPPJ1ZdMMMtgMWCizk/rG5E6aiPVf
 QHFr0iiUPzntEeX8FN5i97v9kgBl6TPTqsjlmMnV+y/MwOtw03SSGCQ3CW7yJiIThKHB
 81cMu9GImK6y43FVOQr3gWN7ZZHV3B/12IS+xQ6SjiSbHkScaVot+0xSQZDjb7ZGLDqb
 a2xFIFDL8mljTT38YLbflpWTSOCoatn4y7Luns3CFACJtrq48y51ItSW9IWqSHuO0vzv
 Y5HeS+XdSQPX6wsuEhSR4o8pfjno5Jv7D2xC3H4bwzzA87BsHV0Ep1agylUAwnDAA3ZI
 278A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749590928; x=1750195728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVY2h3n6p5UCM76x7xGwJIthJDO3448sqBl62JxkyBE=;
 b=FGn+uwEKyIkX+1TvTkwxoV08IMoYUhfsGRhJ2JyBUajqMMKGLljpH3xCaEx8McFbag
 KjgPILPeLqs3UTi4D5r7ABNm+mntZaW7O6bAxffblbWbqRIuyjmH46p9TQpDcvkQ8jGq
 a1851CpVoxO4ZD0N5xXxIXPrJ98FfTfAIKVNLF+nky0jhhNLPvWVQIgOzvNfoH6elZDo
 6Fu6xYvIW+1CLS8/MOAUI65o3foyN57dkYv3VPxZxsZ9NRIxThh6QEa9j8iS6MMeRIRk
 sdUUmS/EanCqKuMEx8zljQxDqXcYI0TNdr9fDRT/sTv38jZzdIU0uTzWrAd2ujVwYacm
 ATSw==
X-Gm-Message-State: AOJu0YwwnzGcmk7otWyZEJo3+2Kig+f4zT593BfPtaKHsEWSrhet3GSW
 C1qr4aDOhCP9XUHqxkiQVzxPyblrDdFdzvHuQHFISzcIj4lqdsxcyaH7pjy0r+PhjpZo/Jmyp9v
 y4raw
X-Gm-Gg: ASbGncsAbtQZvA5r/pI1T9BWALw7Fobe+r+KqABIOFe0tvu8B+dzjzgQkAwXimVR6Do
 nLUqqLb48JS+Zp/hF7HLOoebR8q4/5HsFnRM333x4OpS/fi1smgo5moSOwC/UnlvlVZfmXhqo5S
 AUP/OaewP2G20EYKE933+y/cvl2Kc1Q2x/RKUfEnHu31aS4SFNRGQ7aJSBi5CBICHadhE3WhJrf
 lo8QhoNCmvbs7LzPDmvTR+FAkfKqZEaN6GmSrc4pAP35Y55G+55u8LZjB7GEY9OYs/EAYS+t2Zd
 1z037waLwL3NIppMR/VtxZIt2ITFYglMu7hCfSjP+XMBuQfv+WMnefdHpd0LZQ==
X-Google-Smtp-Source: AGHT+IHCDP1aoZ1YMOECVSdtgjMM0Xm16ODzLXHv0mB2GT6ShoFLgoYmVdq0V+wKaGE1S4GTEgPpYA==
X-Received: by 2002:a05:6a00:814:b0:740:b5f8:ac15 with SMTP id
 d2e1a72fcca58-7486cb71816mr1267571b3a.10.1749590927779; 
 Tue, 10 Jun 2025 14:28:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0c0613sm7864225b3a.122.2025.06.10.14.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 14:28:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, berrange@redhat.com, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/2] qemu/timer: introduce time dilation factor
Date: Tue, 10 Jun 2025 14:28:28 -0700
Message-ID: <20250610212829.2818792-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
References: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

This factor is applied to time spent since we read clock for the first
time. It impacts value returned by get_clock() and get_clock_realtime().

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/timer.h     | 22 ++++++++++++++++------
 util/qemu-timer-common.c |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index abd2204f3be..9c3b8e5506d 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -801,6 +801,18 @@ static inline int64_t get_max_clock_jump(void)
     return 60 * NANOSECONDS_PER_SECOND;
 }
 
+extern int64_t clock_start;
+extern double clock_time_dilation;
+
+static inline int64_t dilate_time(int64_t now)
+{
+    g_assert(now >= clock_start);
+    if (!clock_time_dilation) {
+        return now;
+    }
+    return clock_start + (now - clock_start) * clock_time_dilation;
+}
+
 /*
  * Low level clock functions
  */
@@ -811,11 +823,9 @@ static inline int64_t get_clock_realtime(void)
     struct timeval tv;
 
     gettimeofday(&tv, NULL);
-    return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
+    return dilate_time(tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000));
 }
 
-extern int64_t clock_start;
-
 /* Warning: don't insert tracepoints into these functions, they are
    also used by simpletrace backend and tracepoints would cause
    an infinite recursion! */
@@ -826,7 +836,7 @@ static inline int64_t get_clock(void)
 {
     LARGE_INTEGER ti;
     QueryPerformanceCounter(&ti);
-    return muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, clock_freq);
+    dilate_time(muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, clock_freq));
 }
 
 #else
@@ -838,10 +848,10 @@ static inline int64_t get_clock(void)
     if (use_rt_clock) {
         struct timespec ts;
         clock_gettime(CLOCK_MONOTONIC, &ts);
-        return ts.tv_sec * 1000000000LL + ts.tv_nsec;
+        return dilate_time(ts.tv_sec * 1000000000LL + ts.tv_nsec);
     } else {
         /* XXX: using gettimeofday leads to problems if the date
-           changes, so it should be avoided. */
+           changes, so it should be avoided. Time is already dilated. */
         return get_clock_realtime();
     }
 }
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
index cc1326f7264..d8895aaccad 100644
--- a/util/qemu-timer-common.c
+++ b/util/qemu-timer-common.c
@@ -28,6 +28,7 @@
 /* real time host monotonic timer */
 
 int64_t clock_start;
+double clock_time_dilation;
 
 #ifdef _WIN32
 
-- 
2.47.2


