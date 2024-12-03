Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7891FD4979A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPQY-0001kI-0i; Tue, 03 Dec 2024 04:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPQV-0001jm-NI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:42:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPQT-00052c-QV
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:42:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso45190855e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733218955; x=1733823755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5s5PWLTfQVptCG3HIJElGI4YVuaTaoJWIlnXWhqF62c=;
 b=b7pK5sVY6iUkJTPO/sLN5ddDJnI4h+xXEQVd2fp0GKDkpGsPsj24oF61JJAeKcv+H2
 Fdi3VSgRgH2dfbucvknsnOgZVE9GMRBI0uDZIpgIGNmg34HHsbz+tXIwRwuV/pamCUz8
 uLeJbT5CvxQsE4ufAwSJp+8m5v3f0ByApkL0ILMXFwoK82GwBPr8pH43WOnlyT05yllH
 TGqVLCq+UIVeB4ddg21Og+34RPyp+X6G3rwafBjymzTOzRzIMI+Y+NKcg4KPZAJazzu2
 yCBrp5DAhwafuKfVLZAuYEi/yr3ucyDytRiOPadHPtBvg3uu2V236npNsNMnCYc2O4G0
 o/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733218955; x=1733823755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5s5PWLTfQVptCG3HIJElGI4YVuaTaoJWIlnXWhqF62c=;
 b=YSMWowdw00Hi31xcjZvM227eEo5MlScB2vHewY8mXcqYuAlpKeckGaLsE775gsQ0cB
 ngMruuY1Z2YYkf9tBaVjpjDmO6Gc1L2zyad5dA8xYHL5QkQ4Uzv5i5vZTH8GeM8tyU+p
 DPLLMyo6lQo8jjbHpCEBtO6K6C+rQMVhRiKgHyHKnswVToKnUqg5Jc/RCA4AfXnEyhmU
 xXwGj4OW5w4G1H4rdGV6s3kG2MtSmdB9bpwGLRxDrJD9KcRY30poH/l0MH8B8ojK6dSn
 uqggtG8LMYGwqgDEUEeOBX/WJAGHuadBEcUyKy+0Pktljk26OadgN7ICzOGinq2lOnkv
 1+Aw==
X-Gm-Message-State: AOJu0Yyb/0PEs2TFrqhXusyDBqSuRyEyxundYq9uSABVp3lfnRh4Z59p
 DqFEE9XhAJWAFG7HXIcRMiYvdp6ezoieIpFUTZ6u00BRQTabED/kOCFKi0SsVVkKU/PY3aAapXZ
 SQos=
X-Gm-Gg: ASbGncs1bGv/OPx8pVmFLCob3TaU6rvZ5WgwScTVx7Qq8p26/0cBUt6bRKVMyUCjnd3
 23gkMYxo0ogm+ZTDnTCRJNViHJ+WMh5N4MoQDbAIfozE6zvfqvvd8vKuEPfx5IkuJ0XrU7lN4B6
 QASmCiGXi+7ZieGJUiXEkmh49z8fR+zFJGcaFQQlkStCFaSjHJenGswO4wdbGAp7rTbagsDq9Go
 FUxcroStyV3FOup4KCNYjYCsnQaNhG540ae+dAuVyWP8G/Ag5R4/N6AjRjk7EZZ9AdpXlJ+
X-Google-Smtp-Source: AGHT+IEVPISI1ZFOfrRgtzc89rAqXipHXQphkO4uBsEBlho56ggw85qDUahodeSFm3OyEB4S7IXeqw==
X-Received: by 2002:a05:600c:3ba0:b0:434:a160:3682 with SMTP id
 5b1f17b1804b1-434d09c36d4mr17543485e9.17.1733218955385; 
 Tue, 03 Dec 2024 01:42:35 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f70cbfsm187271615e9.36.2024.12.03.01.42.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:42:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3] system: Select HVF by default when no other accelerator is
 available
Date: Tue,  3 Dec 2024 10:42:32 +0100
Message-ID: <20241203094232.62232-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
---
v2 was https://lore.kernel.org/qemu-devel/20241203091036.59898-1-philmd@linaro.org/
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


