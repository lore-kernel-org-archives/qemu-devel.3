Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E6AE64A82
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR9E-0001hS-IQ; Tue, 03 Dec 2024 06:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR9B-0001UV-Vw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:54 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR9A-0000cq-9T
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso46170205e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225570; x=1733830370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yG+iobrKsz6g8k3u5QukV9MFc+erYLWSKmXLzhEJYGo=;
 b=Y+qIByOmSFBeazu9rZpLVKHr4A7MDOWP/DC1OSIjk8JvWuepnKonsTrcNoJKe3ufdm
 +2w7O+KEa1m53tgSJX76RscWMmYn8i9l2+klCYq6h/jZ0eCaQrsIWRFs3kvTufaX0oIc
 k4DN7OYK8lYNOR08Nw4V3f9azulO/+8EYJLti6954hWdyxA3bsZpAJ6CS6l+ePYewVjl
 NG/cfh0lkawu3Ama/4zs6UHBD0+skZ1jB1X6orLJ22XQ0RkQxK9kwpbc27+qOFE6bcx2
 c6ji2b7XxDrK7haMPUQbIqj17T9fO+iet8p6rEh1oADo4Oo/dmsOybRjIQuZO7kkNSMD
 kn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225570; x=1733830370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yG+iobrKsz6g8k3u5QukV9MFc+erYLWSKmXLzhEJYGo=;
 b=WWhCo4wZ5p5zeqI1Oo4XvIDBoGO69vidMt5DfEZAoh5kk6zNVyDidQ556eIgEB6i+I
 QEJ+CRYFhqVzemJf3b+scsF04rtK6MKBERKJ9BqfDm4KGtthsJq557qCrrKkzUOUje8h
 0Bw2gQG1Qv+41fcwlVIp3h8QuwWO6HxSOpb4JF0Lemdt519eMLcqVsKdYgPwbhW4bon6
 mudXyRpvl4Q3eSDmKqJy+gB0tl0LIXhuYTObznm7gPVbH16axgeDqh4ocTdmdMY5KW09
 sKuFFuebGbHusZ+vjBjQVf0wdFs+jt3u5QTrImaYkqqWt52Xf4KlLbRx0OZr1qJLIHGB
 AYZw==
X-Gm-Message-State: AOJu0Yxuyfc6Fdy+bWemwbQENPXKnweWx4YUh1DpzhZ/qou1cB2IXtXj
 C0KqAVWnBlnC8yrxu10nGlTsv7vUkOK/pLSp+kev64rD8RkwJFb1X+j/yNL1KjWYsxAzW5ZrS7b
 p6C4=
X-Gm-Gg: ASbGncutV1yzR6Z2yFPkTHJr8EQaBEvz/zhxK55JnGq9QtpLLuVSHqfsAcHDpObeNpf
 C0kAC58ybgCpxBEoUauMCtoYuTTwVxzZXArSyoDKSrf8bdRcMfeFsUPJypWCegm5qxfYZFb3nv8
 Nzu5kyYW0xDaATBHZrqliE8qV8uPhTFWJ1Ui92pZhSNsk6LuNokw+zft7sR6bebMZbPraYQlGGG
 aQMo6VzbxooKxDqsexu/fehHjLzUbuh0y1esfu/X6+yrNocQcTgSuLxM2Qci69tv62QVMgq
X-Google-Smtp-Source: AGHT+IEQVymPCSl0ka7xDA5Y/3FDBbJ8v84Z3EYkdoHhvD/iFfVykK2IxHnd5EGe0vGzJ3gU9Pugkw==
X-Received: by 2002:a05:600c:3c97:b0:431:5d4f:73a3 with SMTP id
 5b1f17b1804b1-434d09c7f34mr19700765e9.18.1733225570258; 
 Tue, 03 Dec 2024 03:32:50 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dbe4e6sm184521365e9.14.2024.12.03.03.32.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/13] system: Select HVF by default when no other accelerator
 is available
Date: Tue,  3 Dec 2024 12:31:40 +0100
Message-ID: <20241203113140.63513-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

When testing with a HVF-only binary, we get:

   3/12 qemu:func-quick+func-aarch64 / func-aarch64-version                                      ERROR            0.29s   exit status 1
  stderr:
  Traceback (most recent call last):
    File "tests/functional/test_version.py", line 22, in test_qmp_human_info_version
      self.vm.launch()
    File "machine/machine.py", line 461, in launch
      raise VMLaunchFailure(
  qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
      Exit code: 1
      Command: build/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
      Output: qemu-system-aarch64: No accelerator selected and no default accelerator available

Fix by checking for HVF in configure_accelerators() and using
it by default when no other accelerator is available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241203094232.62232-1-philmd@linaro.org>
---
 system/vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 54998fdbc7e..2f855d83fbb 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2362,6 +2362,7 @@ static void configure_accelerators(const char *progname)
             /* Select the default accelerator */
             bool have_tcg = accel_find("tcg");
             bool have_kvm = accel_find("kvm");
+            bool have_hvf = accel_find("hvf");
 
             if (have_tcg && have_kvm) {
                 if (g_str_has_suffix(progname, "kvm")) {
@@ -2374,6 +2375,8 @@ static void configure_accelerators(const char *progname)
                 accelerators = "kvm";
             } else if (have_tcg) {
                 accelerators = "tcg";
+            } else if (have_hvf) {
+                accelerators = "hvf";
             } else {
                 error_report("No accelerator selected and"
                              " no default accelerator available");
-- 
2.45.2


