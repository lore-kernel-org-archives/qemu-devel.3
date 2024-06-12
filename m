Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A5BC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQ0T-00013P-EL; Wed, 12 Jun 2024 11:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0P-0000t3-TD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:21 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0J-0004LM-0c
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:21 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso2062419a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718206513; x=1718811313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0NIpkhyGGYgnbxSmBPfzzcGZB9GrmkEzQVe5cCnoVc=;
 b=tRTIDd1HyYwWmQwkkWddb105y5bfpXwZbOp9TBgvN7EjHiAD7KYItTow7GFMi/Be8S
 4lBWP+utlChzWSjn21UIFUf+BwGdwZSGNta0TrH5EXYb4RyyRW6jlql74WRZkBiQkjF6
 eXXPqNgPJrdJ9FuUx3w3Zlnt2ve/w8kmve8Q3HfT0KZYfnJxlUoAANNC3q00IfAh4H+7
 6mFWgCorjlh5yJRTJv4taoZ5YOgNjPqARkUxtYn2LcLCCBdeW6iUk8vCH3bCX77c7xKa
 XMsSWErr/W1Lty1VuGC5hiOl6B43HhTlrjBDRd/iwpqduPf8peMwt41mgkTdurX/mpN/
 1b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206513; x=1718811313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0NIpkhyGGYgnbxSmBPfzzcGZB9GrmkEzQVe5cCnoVc=;
 b=n7jZZS4vlzPPMzooKCYHPsC9SxhwKxd5PzK9ArBr+PC99q+5lYX5PqY4fc9gLWuBAk
 +3yuXLol74fqkMhkGnX9TGqBqlUPcR9HgvGOUzWdinAldA99xl95y0AYwTAc5JsrwlLP
 UwJtS7dFv/zVAiULpn9i3ubijHlVCFUbj5KAfzk/OWW3oYzwnPT2vzg591/KjnQRgPrg
 Fr2xG9CS30s/C09r2eTVzOUWxAL2VuLnCey+K/gE/ZiCDu28II2cSbJR/g15ODbuIHSX
 u2wckcPCrNIe5YhD9C/usHL2aBrFXczi/zCVnD2l42RLTffWO2iMUYK8elid0bXLA5W4
 7Wjg==
X-Gm-Message-State: AOJu0Yz8hrB7S6dTcrT4HevE8fONCug5qlUpcFWgJ03LT/R3LzxX9apg
 uiP3iMEOCEGI9XW1pinHV2sSbCP2mZ7WLt+WYwpgHCkP5sACDDsrqWXGsE7i7Og=
X-Google-Smtp-Source: AGHT+IHiw9ywaeCwe00VTJSJ8JkM2YVfCIcQrjCS/i3yRBDrnPHhfF6suexbyfgKr6PBW9GlUolKmQ==
X-Received: by 2002:a05:6402:703:b0:57c:537a:49c5 with SMTP id
 4fb4d7f45d1cf-57cb4c17f24mr6294a12.18.1718206513407; 
 Wed, 12 Jun 2024 08:35:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c855b959bsm5045481a12.38.2024.06.12.08.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:35:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE76D5FA1B;
 Wed, 12 Jun 2024 16:35:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 7/9] qtest: move qtest_{get,
 set}_virtual_clock to accel/qtest/qtest.c
Date: Wed, 12 Jun 2024 16:35:06 +0100
Message-Id: <20240612153508.1532940-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612153508.1532940-1-alex.bennee@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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


