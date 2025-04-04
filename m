Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C960CC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VZ3-0008Kp-8F; Thu, 03 Apr 2025 21:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYy-0008Io-LG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYw-000822-VJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so1219898b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 18:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743728977; x=1744333777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ztloA/BrSXUCyjpky2M3ioZBF5Jl+KSjfz3+89E/Lo=;
 b=ennFpXogfkK2tuBWxEzEuRZIcVeXYGbqwwOf9ACHGM+Qbfi8CrI9MiVGq4pL2rmWsm
 uhGGAgsk9VrayoAjpBke64xIf9nSPfO2+JuKYusT5A/wrOj3TmNevyPsytSy1z0DygA1
 ImawVVRky1pQMm76Roq87cCsTYmIXVLPL0+8tKbdFEYoQC/sMU3oaDtmaq8i4IwSpCjx
 82rRE67ut3LbWxAyljPqmpYQBLC6xzsJvufbPYfCDx11oROtmBrBZD0CKZthkCpxi6y4
 lnukozgbdCQpJqJntJquUJS0z6TW9yljH4AdUinuAS0PipL+uFJQPD+tEG2VU0Xd5M3w
 8bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728977; x=1744333777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ztloA/BrSXUCyjpky2M3ioZBF5Jl+KSjfz3+89E/Lo=;
 b=iNhAJiTEAJ24jIgp37v29M1+PcaxjAXAGlgCn+tMn6+glmEgRgvOLf5ybi7PNEvrJW
 ana6nSvLxsoP3oHwIyAbSM1H3ktKHa+ZqEuyoWf6Vpfclp731gs3XNlGTT8UrJOIZT5J
 lxmk356e+7oUf1EOH5Jn+YepXGEZwE9IsUhRDKVsHGx8rD7pQAVK8koNJ5W08Urttcvs
 wRTXY6BqqIsosSwDI2sbDUittTAHBfzppQ1kAf3ynuI9v93Q5POgVgpwcb+ZFwJ7w3Kb
 vD8JEdv3tbv+OxhvWd2gAWAr2Z/Qs5fw28CjPEwePdD9HRMZpUVCyu5x5NBd7sJEJObN
 wpVA==
X-Gm-Message-State: AOJu0YyZQCHq2IcMuuaooX/lxno7y7QNR4bN7VXEuuvOSQcSBuW1XjY4
 bftA4Im1iHvT2dDkDlEF62f2NHLcHGqyVw1lltx4godDFD7JFfIWtHrMvI+SI9KRxlAWU6hW4dp
 w
X-Gm-Gg: ASbGnctBPb42h0/5vfrKCxuwB6Q9gq5Gmz+2IuHVJizD4QakV4/ze19BOY/EDzXguS8
 gCFP4BwfqN6t2kuzaN2aoklJ1+AK2OIhXbwgCQxw85tPgbaMuifno6kBSBHDLyKuQsgkNg6aDB/
 HZ0UE1/g9p48u4fPACcYgi1tnCc0gAr54SNEQz+UP5QOGyRMV++o0bNBg6BQ7P6LP+GHxwmPksE
 1xti9SddSX7eOSntWsHvZSLr5Q+rJkMHQjVjGCpf9Xl/CA5yXVJ1J7i+VQUVP9Xr1TBj2QM+97L
 D+MU5rDgjBZK61a+rYSEusOa2rlqPYwba0yXzskDmvaUa551Y58=
X-Google-Smtp-Source: AGHT+IGogQGfNf/4oyjD8gTjwRhtHL+dP9K5u4L3gDBUhr9iFYFa31zR3QP7NwFGarxPtW4lF5BtFw==
X-Received: by 2002:a05:6a00:3c83:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-739e46280bcmr1987163b3a.0.1743728977116; 
 Thu, 03 Apr 2025 18:09:37 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee2d9sm2171755b3a.39.2025.04.03.18.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 18:09:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S . Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 5/6] tests/qtest: Skip Aarch64 VMapple machine
Date: Thu,  3 Apr 2025 18:09:29 -0700
Message-ID: <20250404010930.164329-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404010930.164329-1-richard.henderson@linaro.org>
References: <20250404010930.164329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

First, the VMapple machine only works with the ARM 'host' CPU
type, which isn't accepted for QTest:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

Second, the QTest framework expects machines to be createable
without specifying optional arguments, however the VMapple
machine requires few of them:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: No firmware specified

  $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
  qemu-system-aarch64: No AUX device. Please specify one as pflash drive.

Restrict this machine with QTest so we can at least run check-qtest,
otherwise we get:

  $ make check-qtest-aarch64
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
  Broken pipe
  ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
  ...
   7/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp     ERROR      24.71s   killed by signal 6 SIGABRT
   2/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test     ERROR      71.23s   killed by signal 6 SIGABRT

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250403203241.46692-5-philmd@linaro.org>
---
 tests/qtest/libqtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 2750067861..fad307d125 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1788,6 +1788,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
         if (!strncmp("xenfv", machines[i].name, 5) ||
             g_str_equal("xenpv", machines[i].name) ||
             g_str_equal("xenpvh", machines[i].name) ||
+            g_str_equal("vmapple", machines[i].name) ||
             g_str_equal("nitro-enclave", machines[i].name)) {
             continue;
         }
-- 
2.43.0


