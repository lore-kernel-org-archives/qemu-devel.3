Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC84C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyZe-00031S-S5; Wed, 20 Mar 2024 12:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZZ-000307-TX
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:49 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZY-00035u-7o
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:49 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513a08f2263so25691e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710951225; x=1711556025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/x0YSZtzRIY30vUkQYvc9W5wyQ/P/3DVs+8N5NQ/6c=;
 b=TGPKOCVHBYWJhbEG7IrRl0oTnP/+Nauy/sxN7T1jC01WUzWZD+v9Leh7+jI6pgMMlT
 5MzZbp7JJYB3mOLMsCT8Dtst05VtQFRbFzNJsmETCllz0HtjtDZn3yFa7WVc6EC6//Qr
 WQD3gX1YSRcl3/bjU7WGN0Kfi5AHn0BHn55IIUH8rC8Ho27py6C0XkfqlUFd2TCzZ6/h
 p1gr/IadVvd5+heG7HAjGRw3yd/lTZj7oX14JlfhvnQj/fTfAIi1SJpT+LRWkWn4nkBv
 xM3vxHn0+Lc0FZuiSmKjxd6b5QWcwQnOILFH/QoQbj/3HXWL+sM7HWKZogsc8Vb56gTz
 47IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951225; x=1711556025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/x0YSZtzRIY30vUkQYvc9W5wyQ/P/3DVs+8N5NQ/6c=;
 b=kUU5DcA0kxac8No7BRPwdGtlhELQi30H2c5Vs1lGJu6ZmLCuGbVcHBROei/RdLHgX/
 3L+C5v+2//sJYJxKhtHMUiUb7hc/36fkMj64VbxgfZFTUYWb/B/qv0mJEUWhasQWnlHr
 MaueywpYR25/4ni+NdDWeOUVh1PFgDGPfpC6lpWjrewjtbNlgTdbZxnSbACRBqjZX+bU
 xjN/rkhhnqgkNzlFGkat95jLjjBnWR6NdD1+77tEVOZknu15J5sxRw7J8ATxuBDpmlUl
 XCqq6rll0ueWjA28iwOuuGOops+rjyFMnWluNM1NcaOkSelm/RAAj1kIRxcDFqY0howc
 l3nQ==
X-Gm-Message-State: AOJu0YxrDaMu3aOPrdbZ0/2Q6C5EgMqTlJ9PNa0PQyhT/Q+ZGeHKoeLq
 a+C+QtNathH6CGF/yftMFxVIAstGMuyTI7Dvt336pK41vwr0b+Nc2NrpfgBIfcI=
X-Google-Smtp-Source: AGHT+IHtxb8zJP4T2n5Hl9NyK7Yfn6X+03+Sz4+8Vd7ueMRSfFQSqQ0xMaCuCBgbtIliEOP26tieaQ==
X-Received: by 2002:a19:6408:0:b0:513:d32a:89e1 with SMTP id
 y8-20020a196408000000b00513d32a89e1mr4875122lfb.51.1710951225469; 
 Wed, 20 Mar 2024 09:13:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h25-20020a17090634d900b00a46196a7faesm7416406ejb.57.2024.03.20.09.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 09:13:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 505025FB8B;
 Wed, 20 Mar 2024 16:13:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 4/5] tests/avocado: sbsa-ref: add Alpine tests for misc 'max'
 setup
Date: Wed, 20 Mar 2024 16:13:39 +0000
Message-Id: <20240320161340.391798-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320161340.391798-1-alex.bennee@linaro.org>
References: <20240320161340.391798-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

PAuth makes run timeout on CI so add tests using 'max' without it
and with impdef one.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240318-sbsa-ref-firmware-update-v3-3-1c33b995a538@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 259225f15f..cf8954d02e 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -140,18 +140,36 @@ def boot_alpine_linux(self, cpu):
     def test_sbsaref_alpine_linux_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
+        :avocado: tags=os:linux
         """
         self.boot_alpine_linux("cortex-a57")
 
     def test_sbsaref_alpine_linux_neoverse_n1(self):
         """
         :avocado: tags=cpu:neoverse-n1
+        :avocado: tags=os:linux
         """
         self.boot_alpine_linux("neoverse-n1")
 
+    def test_sbsaref_alpine_linux_max_pauth_off(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:linux
+        """
+        self.boot_alpine_linux("max,pauth=off")
+
+    def test_sbsaref_alpine_linux_max_pauth_impdef(self):
+        """
+        :avocado: tags=cpu:max
+        :avocado: tags=os:linux
+        """
+        self.boot_alpine_linux("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
+        :avocado: tags=os:linux
         """
         self.boot_alpine_linux("max")
 
-- 
2.39.2


