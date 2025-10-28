Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcUX-00039A-6p; Tue, 28 Oct 2025 01:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcUT-00038W-DQ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:43:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcUQ-0002b7-Rz
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:43:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so55056155e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630204; x=1762235004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSq0w+2pMt9GZjD8Tq18/wVUPKd35IM8rk6GrG4O1u0=;
 b=SkYfA/ewNck2bK/+QkP6bTSuabmuLDqVUukFl5Iw9+0Ga9TimSqqUbs10mqmEyZ8pI
 Awyu6W7zmHm8InOZgKyxrVA/r1HFqEO6+hIddsA+PZlyI3gAPUdHrXIYGrq30zjz5i2Z
 bBMG5JIs8wgd7TGYi7RVkikM/JnH0ALmv3tZM3ASducvxjaL4fS1Nknp2SpxTvxloS7j
 hgj5cNB+PlLWsjK9ktjTJKF0cZ2msw7VDj0sEP1Z+1Sxba/maypYTLavaCf31/F+kqN2
 qm8Uwa8oEFa98tHI5qL6Y0AC8YaHvm1KSxwgsFDTJxbLpq6cfV8RbhXEbLYKJJB6fURF
 /C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630204; x=1762235004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSq0w+2pMt9GZjD8Tq18/wVUPKd35IM8rk6GrG4O1u0=;
 b=LXH/xxXPk55x7+V/wx8W7u5xXsoPNoj6RBtICibTGi8ogln1DsD9WgZ7f6AFir4Equ
 vs/xN7k5OxZNj94H/Lsl2XQo1Wc75MnaIIz8Z8KSUJB8ibc/WvIwzxcQsNTT5aAxGT08
 3yphp6zNlCWgrdG6qkA8Ox7Nw6yLv6YdBZlpJ57kya76QEpLhBD2qiuTwmM6C0PAWrof
 PnjxiTzHQLOSNSxwzyuUu3oafQ9UyMWcYZ6/wVXgKkIDDe7DJJaNXNDCM24qzqsfFwzA
 EpOxfN4NIB4Zpjpgk0GqCOhxf/vMk+RjlucDgAr16/WMu0nkYdYSzTTPMqRklJlwF1On
 zXaw==
X-Gm-Message-State: AOJu0YwjEEhuRIlkAx5a12Jw2Z/N127Wdr+mbVV9SaO+pdXL5whpKC+a
 +zoXvxhwO1ucEzHP+F7DZ4ZCwWB4l4XDlivVJADoIt3e+G8HqRsKHhhZKZkWJ9rrywaz31cpl/z
 tFlyWRrQ=
X-Gm-Gg: ASbGncuOh9lwAmsz/4E1PBIT9uWU7u1zc+l4YVaeVsDQHMhkHkR8KnRj6z0JGe5puE/
 vmBRZRIcm0wSv6Jd6mN7Ds+5SQHtOJPNyjq+RNW4Vk1+CfIizNWx6ZkVybYN3MDuvrDtWeo09Tn
 lSYCXVb/Z3I/cEA9ce29HjONJLI4QeNeoNEBFTSaVzbMzrjFP1JhizX13cyrMEO1EWy6dLYutVw
 4IvJFW576jhDt2XcYMQ9X5sJUZ+THRKNixLKw16hjqLDFvkiZBczJQvkGUM+myDYYesjzTzEhHv
 MscZmfGtnsAoY4DHI5TFyXLLolHIdgAXxdZCA6zF38kW+0u+wqlD2PhP6ITmoIPbiDCyUMjpiLM
 GwXdjnBvMkGxWEtoEXdd/JD5YuCVV5x7nZU+W9p70pyygZXnIVjA6eUpafKQRlz5/O5hPE/hloZ
 u+kWormsCUwSuEFdkLbvbFugbs0EyS+ES9/PthdmMR4GqY8fyl2/Y/OsM=
X-Google-Smtp-Source: AGHT+IHKLuQPpl8TG0v/3PIw0D21QYoCXdnMS1OnyJsYEiz+iIqN35oOag2/YpDSKLMzitEGD1pbMA==
X-Received: by 2002:a05:600c:4ec8:b0:475:dac3:699f with SMTP id
 5b1f17b1804b1-47717dfdf67mr17136215e9.9.1761630204377; 
 Mon, 27 Oct 2025 22:43:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02ce46sm209225495e9.3.2025.10.27.22.43.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:43:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/59] target/arm/hvf: Release memory allocated by
 hv_vcpu_config_create()
Date: Tue, 28 Oct 2025 06:41:37 +0100
Message-ID: <20251028054238.14949-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

hv_vcpu_config_create() is documented in <Hypervisor/hv_vcpu_config.h>
as:

  /*!
   @abstract Creates a vcpu configuration object.
   @result A new vcpu configuration object. This should be released with os_release when no longer used.
   */
  OS_OBJECT_RETURNS_RETAINED OS_WARN_RESULT
  hv_vcpu_config_t hv_vcpu_config_create(void);

Release the memory allocated by hv_vcpu_config_create() with
os_release().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0658a99a2d1..83db1088384 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -150,6 +150,8 @@ void hvf_arm_init_debug(void)
     max_hw_wps = hvf_arm_num_wrps(config);
     hw_watchpoints =
         g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
+
+    os_release(config);
 }
 
 #define SYSREG_OP0_SHIFT      20
-- 
2.51.0


