Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CD5C369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 22:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u30ow-0004DQ-Ts; Thu, 10 Apr 2025 18:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u30od-0004Bp-Js
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 18:56:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u30oa-0002ZK-JS
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 18:56:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22435603572so13836055ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744325767; x=1744930567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+C5+b1a8mySGOnXpO+yRnlPSMlppK5ZlK3cVTr23jo=;
 b=akpNfIYu3iBkedpLWkyIF6Kqy5U6zrRhldChiIEYj17SmLvgwX2gyKXgqT+N6zDBY3
 41ptre0RbbJ4eQGTO8yBLIpu2JPkVSp3cz4xKNRAWKGhR0/RXdlksQNsPA1SN+j0yD40
 bfrXCwVM4AYIVYwSGxCAxx+ROxsHAddDKTeRKmqSMX70hCt6lzXnn67Zbg9JLgUsTVqQ
 HR82dB5BAVNW3D3dvFJqF+VmbUWUtTlVsMpKdPdl5DrOMOisMweJ7OTbWais846cP8Yt
 mBH4M90SvLEbfXreVGsuODfs35y+Ez0SbJMOyhJ6LzGBs6+zhU1teKtpEuGMyI11MuBd
 luMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744325767; x=1744930567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+C5+b1a8mySGOnXpO+yRnlPSMlppK5ZlK3cVTr23jo=;
 b=U98QrVpbcOrC1TbcPQPYb8Ohig8sBnfJJ4maBaWEjUPPOzzUnhIcm9YktUGOeBejNG
 NINYBJeOS0Z3AbPjAvq27XbYrqczrnh4y+9UlQTMosyEwADUQScLbNCVpCI6C+6YR23y
 oj8YMZKM/5z8/oiQBhRBy/75E1NXZrkYvGk+nScdy2wqQxEqUp3XS6wxM/CbvNXN2JKG
 bnsLoWFNoJdUjgeu9MSZ2XebE2R4Rp+IgIi7s/0oLqJB6/UFW3lqbmFOFAObZcyDCcQW
 xhogx2Pq4POwjckNiy8ZbblHT5tudg0Hum0+nzP7vz9eyGBLqzXCNgKJ/jTaJT+6eruB
 MyUw==
X-Gm-Message-State: AOJu0YzPgHh44XezB6DOeTYVQZ4snX4uR8xrwPeT1bckDCEo71dsaqD1
 ivOGdmLnwfFYdzbQlsVPvjy8afTwJ4DVWD8FS74LBLczj9RkaDQ9V8I+3HFzL3gWXxko3VMvgcA
 p2Yo=
X-Gm-Gg: ASbGncseH93nEfIP0zK4t/mW2L+akHAtRS2i4TdnKl4BzezX5n1ozClzaPMpPC/Elab
 Ng43e94Xpa/3ZUxhd1ZTI9V+cXUwthTBU4CLXZVLjZwIlPveqb5KaD0J27GB3g4aCNXbZRzTKt1
 p9rZFP0qplabJNM9EuD78Pw2RY2Qi+tWSm0WM6cgwud7gL34wJ3uepK//45uXF5leGnCa6v38J3
 POB/iOtSGXWAB03nqpmeur8npQ8EQomvkpI7ykzRrChnk/2n8FVZCkt1rFUZjRnRqx/dPy5Q2o+
 o/9Y4JF+zHVXWvcvCOfn+gbNeD3tkJ85bLvgTQgW
X-Google-Smtp-Source: AGHT+IHs9D25qgiDbzI8gGKggg0wrOwdpCaenWVZo1nGJW0XNt6jI+YS4VfDHah/7c/Dul9P8K3bgQ==
X-Received: by 2002:a17:903:2bce:b0:224:ab0:9b00 with SMTP id
 d9443c01a7336-22bea4bcc57mr8155805ad.27.1744325767220; 
 Thu, 10 Apr 2025 15:56:07 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c97228sm36249225ad.128.2025.04.10.15.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 15:56:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/2] system/main: transfer replay mutex ownership from main
 thread to main loop thread
Date: Thu, 10 Apr 2025 15:55:49 -0700
Message-Id: <20250410225550.46807-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On MacOS, UI event loop has to be ran in the main thread of a process.
Because of that restriction, on this platform, qemu main event loop is
ran on another thread [1].

This breaks record/replay feature, which expects thread running qemu_init
to initialize hold this lock, breaking associated functional tests on
MacOS.

Thus, as a generalization, and similar to how BQL is handled, we release
it after init, and reacquire the lock before entering main event loop,
avoiding a special case if a separate thread is used.

Tested on MacOS with:
$ meson test -C build --setup thorough --print-errorlogs \
func-x86_64-x86_64_replay func-arm-arm_replay func-aarch64-aarch64_replay
$ ./build/qemu-system-x86_64 -nographic -icount shift=auto,rr=record,rrfile=replay.log
$ ./build/qemu-system-x86_64 -nographic -icount shift=auto,rr=replay,rrfile=replay.log

[1] https://gitlab.com/qemu-project/qemu/-/commit/f5ab12caba4f1656479c1feb5248beac1c833243

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2907
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/main.c b/system/main.c
index ecb12fd397c..1c022067349 100644
--- a/system/main.c
+++ b/system/main.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-main.h"
 #include "qemu/main-loop.h"
+#include "system/replay.h"
 #include "system/system.h"
 
 #ifdef CONFIG_SDL
@@ -44,10 +45,12 @@ static void *qemu_default_main(void *opaque)
 {
     int status;
 
+    replay_mutex_lock();
     bql_lock();
     status = qemu_main_loop();
     qemu_cleanup(status);
     bql_unlock();
+    replay_mutex_unlock();
 
     exit(status);
 }
@@ -67,6 +70,7 @@ int main(int argc, char **argv)
 {
     qemu_init(argc, argv);
     bql_unlock();
+    replay_mutex_unlock();
     if (qemu_main) {
         QemuThread main_loop_thread;
         qemu_thread_create(&main_loop_thread, "qemu_main",
-- 
2.39.5


