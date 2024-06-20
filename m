Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE5DC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcV-0005uy-1v; Thu, 20 Jun 2024 11:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcT-0005t9-8e
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:37 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcP-0007yW-IG
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:36 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cc14815c3so1063507e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896952; x=1719501752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0NIpkhyGGYgnbxSmBPfzzcGZB9GrmkEzQVe5cCnoVc=;
 b=p9TrWohcr0ofM0C0tvh8djX/Ijp5UfvKqp+rLMhEnmfAW8mjqiamcyXWvG4PVh/i3n
 pGr4viTQGv+6lUoJcE8yGTgF7z5+9fMs0MzkG9AqMxPI1EFGxUPum6ksgQl0ZePQZUhG
 7YnpnLLTCe4jP0XuR41PgAi5qYouJo4yRXa4Jp6WbmKx+0mCmf5tSYQFgQ6zMccsBorQ
 Lqj/D+d8QEAyITPyiiDULFNeGrSJtuzhxsPvU1wXtBp6Hv0SlwW3q3pLrztJ8UIcl5t8
 zyk+Wpr2W6Er+98RmRgeZ9a9jaJ8rQ2ZIQr7b2dU3oajF+92lVLnMIrmlMj1jvPEWind
 xnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896952; x=1719501752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0NIpkhyGGYgnbxSmBPfzzcGZB9GrmkEzQVe5cCnoVc=;
 b=ugQFj5KT3XYtgmt9SbFzOvuLXL5ZsDonk3arWk5g79RAif9Vl8pDLMuo8gdy+WhjHo
 qZNSkFCvyF2RGoJOHwsC4bJj20dTi6la5o9xf0CenXUIUVoqgIIpkw7XhOOAPqTuQmke
 iHwL4JFjNX+OGLRifQygII6+s4EbBb3bLRPybigpSKQl6hzQ6UAVUHC63+VBBNnfkaUa
 5p9tt0ko626h1JHijR+mmBjTPAQWKQ8Lhobkplu+5RGOrhk2u3dnF+bajvDAxCkJy3Wy
 IAnAdATB6qLNSYkbxrexZ2N1vGHUftOuCFM3Rvtf4g1p4kGVnRyNndN1SvQxCtqSHtWA
 unXg==
X-Gm-Message-State: AOJu0YzZOsmjK3HJgGLz1sNBW80mtu4/8iLOcuCE4KJuwTkOr6yt5dt1
 +hJ8E5+e89xZZ7Fucj0gDgFyKprDmMTNofU/LSRPrswnqCgm4wy5mkEuF4GmTsE=
X-Google-Smtp-Source: AGHT+IF/Ow3t51hj2zvFm2LAur2fftlTRBJVGqnvOSs+DkFtw+O0hxF8fAtrEgLsUxfRTp/WRXnwOw==
X-Received: by 2002:a05:6512:6d3:b0:52c:7f7f:dc1f with SMTP id
 2adb3069b0e04-52ccaa5c755mr4114734e87.61.1718896951767; 
 Thu, 20 Jun 2024 08:22:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed0f2asm783454366b.131.2024.06.20.08.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B3C945FA03;
 Thu, 20 Jun 2024 16:22:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/12] qtest: move qtest_{get,
 set}_virtual_clock to accel/qtest/qtest.c
Date: Thu, 20 Jun 2024 16:22:15 +0100
Message-Id: <20240620152220.2192768-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620152220.2192768-1-alex.bennee@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240530220610.1245424-5-pierrick.bouvier@linaro.org>
---
 include/sysemu/qtest.h |  3 ---
 accel/qtest/qtest.c    | 12 ++++++++++++
 system/qtest.c         | 12 ------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 45f3b7e1df..c161d75165 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -34,9 +34,6 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
 void qtest_server_inproc_recv(void *opaque, const char *buf);
-
-int64_t qtest_get_virtual_clock(void);
-void qtest_set_virtual_clock(int64_t count);
 #endif
 
 #endif
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 53182e6c2a..bf14032d29 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -24,6 +24,18 @@
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
+static int64_t qtest_clock_counter;
+
+static int64_t qtest_get_virtual_clock(void)
+{
+    return qatomic_read_i64(&qtest_clock_counter);
+}
+
+static void qtest_set_virtual_clock(int64_t count)
+{
+    qatomic_set_i64(&qtest_clock_counter, count);
+}
+
 static int qtest_init_accel(MachineState *ms)
 {
     return 0;
diff --git a/system/qtest.c b/system/qtest.c
index 8cb98966b4..12703a2045 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -325,18 +325,6 @@ static void qtest_irq_handler(void *opaque, int n, int level)
     }
 }
 
-static int64_t qtest_clock_counter;
-
-int64_t qtest_get_virtual_clock(void)
-{
-    return qatomic_read_i64(&qtest_clock_counter);
-}
-
-void qtest_set_virtual_clock(int64_t count)
-{
-    qatomic_set_i64(&qtest_clock_counter, count);
-}
-
 static bool (*process_command_cb)(CharBackend *chr, gchar **words);
 
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words))
-- 
2.39.2


