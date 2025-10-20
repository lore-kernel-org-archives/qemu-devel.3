Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB15CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy5c-00070q-Vb; Mon, 20 Oct 2025 18:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy5U-0006wB-AD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy5O-0006KF-Gb
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-471076f819bso38548645e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998237; x=1761603037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Cw/auqPGZF90bg+tsodLyu1anbpQABoi+IFSvgYon0=;
 b=zg80fWayYLrf53HlAa+hgpR5HoBUmtyA1SQZFmoT2L0+In1axfLREYDe59wmjeHuFG
 9gKAyMJBCODxjc8xj/0Pun0b+PxbwFFpr9w3q7YaxoHEfG27pP77herwmXI7uPzuzOp3
 jArbh/6P0c7+f0TO0meu8uyF9o53pGVPoFd8DXD/zgZSzuATHid8snoOk2iKaNXqIML3
 DWGVOGvOVWbDiGtyKbEhwi0cKIkjdgWZGib23GeO67giGHxgYJtn/bY1r/70NeOIN4vw
 9xA5nLQVWNc5s8LiiI98Lby9URo/11hnIZdb713ie+Q3Fl05GnYGH9RGJwsHBCUL7f64
 g8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998237; x=1761603037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Cw/auqPGZF90bg+tsodLyu1anbpQABoi+IFSvgYon0=;
 b=uTMYFwfa2IkTeoZr3IgeI5l9/V57TUBLMhQglBwOLSMh3v07U34I8+xJQMMZfVVNMA
 7bINbB7ojuS3aKQdnKozLj46P//m/3UBR8LDSPivtTy3qOoLakKILPOfIzfJSR4CiSeY
 L0Iypbe8Stu/KL+gXlcf+mRI5BzSdczDWIz11jEyinGjVq6uOE39g3b/3RRC8kI7nrek
 HcQN+yKOWYcKwq+cFBfANwJn81hjUBIZsZSHJWl4RenaR/UKMEW9XTE7D2J4TGli2bnf
 3t28/qqNTv6UK4KxK1PLv3UIqEWldoGsLU4CaP7hR0KDPg/0ApkYJekaxp794pOK4Sq8
 M6kg==
X-Gm-Message-State: AOJu0YxFBCUAxZ6QVUbQPzQn6tSm56YkTW7Y1mpzUmA9K+DwJ/snAuYX
 /Up2t/AlTKvmfwKPGC83fIYvC+cHw1c5jpmf3ncQ9EdLL/HGETunJZgkdoC8jMmZ1tU15FPxWfs
 IM72piyM=
X-Gm-Gg: ASbGncvIt/9nuyJLdz1pDaGLbUc0CGAVkb1GQ3E6LsHvV5CSlyetXjreSNmivvQW+vE
 x+3Wq9CMFa0/AdF8mbEHy5XHCWLkXdVZSKgLT6yTzIz4x0YkDD07fSYj38bkaK9qSWQYLu0oKeM
 t0fYUnmpV3cUM2HrDWt67YNczlkvoaANKszPJB2lIFncTZjAYxLWXfXwIf/df2F5uPd7nEEIQ1U
 BZaDMIQaj2xabiDl+UhqOZkEYV+3lFKmOw5vPPHZ3C2Y8SrOk6JZaRd59oci7PTEpK0CJCEeLhi
 gSOUI5XiZSuHY3Ibbmo/4bZixQPM5caHMYHygvLTBnXGJoaUCXKli+WQ22zVt8ewCFApHPwfqdI
 bIWZOHKU5847597Bwb9web0CNARMB93eXDTOPw8lgwicD7Ik4R3mlaKkii2wyjQz8w9Mm5aqNrW
 YUO0H7T0W4L2Ju4r4pDzxGuK+yBUyTv6Mh6wGLoPh4u4lmj76Yzw==
X-Google-Smtp-Source: AGHT+IFLJcFed2v1EwRR5nAucAd53PrnYFHH3fMQTblIj5z3+zgKP4Me9HwpmLj11s1hThPxS/p+mQ==
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47117874978mr106495845e9.3.1760998236723; 
 Mon, 20 Oct 2025 15:10:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494aad668sm4570025e9.2.2025.10.20.15.10.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:10:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 10/30] meson: Prepare to accept per-binary TargetInfo
 structure implementation
Date: Tue, 21 Oct 2025 00:09:19 +0200
Message-ID: <20251020220941.65269-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If a file defining the binary TargetInfo structure is available,
link with it. Otherwise keep using the stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                 | 1 +
 meson.build                 | 9 ++++++++-
 configs/targets/meson.build | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 configs/targets/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 667acd933c7..17f90230bf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2001,6 +2001,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
+F: configs/targets/*.c
 
 Xtensa Machines
 ---------------
diff --git a/meson.build b/meson.build
index f4ac0a6e95b..0f27a2a8f90 100644
--- a/meson.build
+++ b/meson.build
@@ -3312,6 +3312,7 @@ config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
 config_base_arch_mak = {}
+config_target_info = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3912,9 +3913,9 @@ specific_ss.add(files('page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
-specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
+subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4364,6 +4365,12 @@ foreach target : target_dirs
     arch_srcs += gdbstub_xml
   endif
 
+  if target in config_target_info
+    arch_srcs += config_target_info[target]
+  else
+    arch_srcs += files('target-info-stub.c')
+  endif
+
   t = target_arch[target_base_arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
   arch_deps += t.dependencies()
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
new file mode 100644
index 00000000000..a9f6b24ec01
--- /dev/null
+++ b/configs/targets/meson.build
@@ -0,0 +1,4 @@
+foreach target : [
+  ]
+  config_target_info += {target : files(target + '.c')}
+endforeach
-- 
2.51.0


