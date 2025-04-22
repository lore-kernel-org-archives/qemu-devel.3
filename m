Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D1C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F2E-0006tF-Ub; Tue, 22 Apr 2025 10:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2C-0006sp-MU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2A-0005CX-Sl
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so3269314f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333737; x=1745938537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpcspgIhlgKyCaOz9UHnXAYe0CmwdQHUivc3mJB7oNw=;
 b=mpWZMLXhX9QnjQKEI8nvB91lOnqmkLmwEmBmAtxoKaBzWC/V9/iE49fEanJBhtl3nc
 0wrB7B9tKLWXoy9WoIzX77SIbGjXoBsmWNG4Dq8gJCrsjvEQIPc1rTpa9OL/sCResLQ1
 X6hdE17ShwswE9jZ/e1GQOfNM4btC2EadxUS6zBU7Vwap3zVi7pXguNm8wnhtuuEntfC
 I69G15yW5fuPmr5Ef+2P/cTjttBzOhJIAugpV5/Vo+mDfN6K6++pCOV7KOYoEc2dWxzN
 gIm7lBviFf+HDcoSv+3aydMu9HLIAONQziGq87F48GyGFppnBVnUsa1d7PXQYXhUiT6k
 nABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333737; x=1745938537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpcspgIhlgKyCaOz9UHnXAYe0CmwdQHUivc3mJB7oNw=;
 b=LtQMjoC9MWT2BK1S2C2kmkb1vkbNIXZF4+ImW0MGpk6J7CvWRXjoloIKr0CkkBuL6r
 /84ypDZr5ZALmiX53Vk+02NcsisZqea/sVs0b3I6JQkoXCDM1a+R/yB3BWmy7j9tBkKp
 zn0FQzCkjADo1rQ7ahBdVpsKkKcSijJhUnjnnYfmIRWrDVPozfeJhJ17GR9EjITbeV3O
 EozJS+qNEpFp/hG9x/DCviLyrfQRJVOXi4FDLJ2GpArWojh22oPlZkofl0aatoNd2qwh
 ZV2ir0dRJ3imwW3c4HlfEJLEx1yAJPHcTDZ9qxsoM7p9kwaHDBXqxTPHJtsQ1GF42RVr
 XYzA==
X-Gm-Message-State: AOJu0YwrMmWKkfkuoC6rEAWF47aRf0xivyfXFck2O9jVS+enw5sngU9s
 DUNXnR8MwwxpjTSQ9NZUdjqgsjoSeT5u3rsUImKixBPaiv0nbxOkQy0BEtAz740HOD98K2+vHpv
 5
X-Gm-Gg: ASbGnctN8JMl937Jz0PbPKQzJsRllinA3W8UR8rl3r8h0kCB6B23BdJgDHpmoDSBWuk
 4dsx+Mbu9EavaR40R6vNb4FS2+6wC5GvqqOFDaePiJji1ZSiqyNkvPwONodup9jUwbuAkbfY1Nz
 B1nm+Rv9WPgTJbrTzG/5jqnkaWIjvaU8AiLKwzTeLRAYhtTQW/x6ZU/ux5C/pH6H8GTBoPunw8w
 tAmgv6L3NQERZhV8vl+XY705ZhJR9rq04SyOEDbApYZXRHSgiAFzcvxrllbZVXkH4Dt5rdp/GNz
 sxxHOIZdw9QJ32TKVa/usSPTdSmWHORxKAZGzRNtsCDrdpfIXA4RhSUQFQQeZR9+Ls6C0nM6jHS
 j6KsKs9T//tEN2HVP1TWVh7nn2A==
X-Google-Smtp-Source: AGHT+IG3BCL0gA5UfElBNf9nAlZcZKz7l1TI2iX1KmWz58tJNKAMU8k7ZaVgTdeeuN4BYKgmxNBDQg==
X-Received: by 2002:a05:6000:40cd:b0:39a:d32c:fb5e with SMTP id
 ffacd0b85a97d-39efba3cbe4mr12789933f8f.21.1745333737063; 
 Tue, 22 Apr 2025 07:55:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa5a2300sm15291826f8f.101.2025.04.22.07.55.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 07/19] meson: Prepare to accept per-binary TargetInfo
 structure implementation
Date: Tue, 22 Apr 2025 16:54:49 +0200
Message-ID: <20250422145502.70770-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

If a file defining the binary TargetInfo structure is available,
link with it. Otherwise keep using the stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                 | 9 ++++++++-
 configs/targets/meson.build | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 configs/targets/meson.build

diff --git a/meson.build b/meson.build
index a1109b6db3f..69f60755377 100644
--- a/meson.build
+++ b/meson.build
@@ -3216,6 +3216,7 @@ config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+config_target_info = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3809,9 +3810,9 @@ specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
-specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
+subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4272,6 +4273,12 @@ foreach target : target_dirs
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
index 00000000000..e9a5f7b078e
--- /dev/null
+++ b/configs/targets/meson.build
@@ -0,0 +1,3 @@
+foreach target : ['arm-softmmu', 'aarch64-softmmu']
+  config_target_info += {target : files(target + '.c')}
+endforeach
-- 
2.47.1


